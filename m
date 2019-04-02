From: Joel Fernandes <joel-QYYGw3jwrUn5owFQY34kdNi2O/JbrIOy@public.gmane.org>
Subject: Re: [PATCH RFC tip/core/rcu 0/4] Forbid static SRCU use in modules
Date: Tue, 2 Apr 2019 14:40:54 -0400
Message-ID: <20190402184054.GA18150@google.com>
References: <20190402142816.GA13084@linux.ibm.com>
 <886051277.1395.1554218080591.JavaMail.zimbra@efficios.com>
 <20190402152334.GC4102@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20190402152334.GC4102-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: "Paul E. McKenney" <paulmck-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>
Cc: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, fweisbec <fweisbec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Lai Jiangshan <jiangshanlai-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>, Josh Triplett <josh-iaAMLnmF4UmaiuxdJuQwMA@public.gmane.org>, rcu-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Eric Dumazet <edumazet-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Mathieu Desnoyers <mathieu.desnoyers-vg+e7yoeK/dWk0Htik3J/w@public.gmane.org>, Oleg Nesterov <oleg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, dipankar <dipankar-xthvdsQ13ZrQT0dZR+AlfA@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Apr 02, 2019 at 08:23:34AM -0700, Paul E. McKenney wrote:
> On Tue, Apr 02, 2019 at 11:14:40AM -0400, Mathieu Desnoyers wrote:
> > ----- On Apr 2, 2019, at 10:28 AM, paulmck paulmck-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org wrote:
> > 
> > > Hello!
> > > 
> > > This series prohibits use of DEFINE_SRCU() and DEFINE_STATIC_SRCU()
> > > by loadable modules.  The reason for this prohibition is the fact
> > > that using these two macros within modules requires that the size of
> > > the reserved region be increased, which is not something we want to
> > > be doing all that often.  Instead, loadable modules should define an
> > > srcu_struct and invoke init_srcu_struct() from their module_init function
> > > and cleanup_srcu_struct() from their module_exit function.  Note that
> > > modules using call_srcu() will also need to invoke srcu_barrier() from
> > > their module_exit function.
> > 
> > This arbitrary API limitation seems weird.
> > 
> > Isn't there a way to allow modules to use DEFINE_SRCU and DEFINE_STATIC_SRCU
> > while implementing them with dynamic allocation under the hood ?
> 
> Although call_srcu() already has initialization hooks, some would
> also be required in srcu_read_lock(), and I am concerned about adding
> memory allocation at that point, especially given the possibility
> of memory-allocation failure.  And the possibility that the first
> srcu_read_lock() happens in an interrupt handler or similar.
> 
> Or am I missing a trick here?

Hi Paul,

Which 'reserved region' are you referring to? Isn't this region also
used for non-module cases in which case the same problem applies to
non-modules?

thanks!

 - Joel
