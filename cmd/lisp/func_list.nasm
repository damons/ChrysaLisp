%include 'inc/func.inc'
%include 'class/class_vector.inc'
%include 'cmd/lisp/class_lisp.inc'

	def_function cmd/lisp/func_list
		;inputs
		;r0 = lisp object
		;r1 = args
		;outputs
		;r0 = lisp object
		;r1 = 0, else value

		ptr this, args
		ulong length

		push_scope
		retire {r0, r1}, {this, args}

		;eval args
		static_call vector, get_length, {args}, {length}
		static_call vector, slice, {args, 1, length}, {args}
		static_call lisp, repl_eval_list, {this, args}, {length}
		if {!length}
			static_call vector, deref, {args}
			assign {0}, {args}
		endif

		eval {this, args}, {r0, r1}
		pop_scope
		return

	def_function_end
