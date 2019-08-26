From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: gnome-shell stuck because of amdgpu driver [5.3 RC5]
Date: Mon, 26 Aug 2019 11:24:44 +0200
Message-ID: <20190826092408.GA2112@phenom.ffwll.local>
References: <20190825141305.13984-1-hdanton@sina.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190825141305.13984-1-hdanton@sina.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hillf Danton <hdanton@sina.com>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Sun, Aug 25, 2019 at 10:13:05PM +0800, Hillf Danton wrote:
> 
> On Sun, 25 Aug 2019 04:28:01 -0700 Mikhail Gavrilov wrote:
> > Hi folks,
> > I left unblocked gnome-shell at noon, and when I returned at the
> > evening I discovered than monitor not sleeping and show open gnome
> > activity. At first, I thought that some application did not let fall
> > asleep the system. But when I try to move the mouse, I realized that
> > the system hanged. So I connect via ssh and tried to investigate the
> > problem. I did not see anything strange in kernel logs. And my last
> > idea before trying to kill the gnome-shell process was dumps tasks
> > that are in uninterruptable (blocked) state.
> > 
> > After [Alt + PrnScr + W] I saw this:
> > 
> > [32840.701909] sysrq: Show Blocked State
> > [32840.701976]   task                        PC stack   pid father
> > [32840.702407] gnome-shell     D11240  1900   1830 0x00000000
> > [32840.702438] Call Trace:
> > [32840.702446]  ? __schedule+0x352/0x900
> > [32840.702453]  schedule+0x3a/0xb0
> > [32840.702457]  schedule_timeout+0x289/0x3c0
> > [32840.702461]  ? find_held_lock+0x32/0x90
> > [32840.702464]  ? find_held_lock+0x32/0x90
> > [32840.702469]  ? mark_held_locks+0x50/0x80
> > [32840.702473]  ? _raw_spin_unlock_irqrestore+0x4b/0x60
> > [32840.702478]  dma_fence_default_wait+0x1f5/0x340
> > [32840.702482]  ? dma_fence_free+0x20/0x20
> > [32840.702487]  dma_fence_wait_timeout+0x182/0x1e0
> > [32840.702533]  amdgpu_fence_wait_empty+0xe7/0x210 [amdgpu]
> > [32840.702577]  amdgpu_pm_compute_clocks+0x70/0x5f0 [amdgpu]
> > [32840.702641]  dm_pp_apply_display_requirements+0x19e/0x1c0 [amdgpu]
> > [32840.702705]  dce12_update_clocks+0xd8/0x110 [amdgpu]
> > [32840.702766]  dc_commit_state+0x414/0x590 [amdgpu]
> > [32840.702834]  amdgpu_dm_atomic_commit_tail+0xd1e/0x1cf0 [amdgpu]
> > [32840.702840]  ? reacquire_held_locks+0xed/0x210
> > [32840.702848]  ? ttm_eu_backoff_reservation+0xa5/0x160 [ttm]
> > [32840.702853]  ? find_held_lock+0x32/0x90
> > [32840.702855]  ? find_held_lock+0x32/0x90
> > [32840.702860]  ? __lock_acquire+0x247/0x1910
> > [32840.702867]  ? find_held_lock+0x32/0x90
> > [32840.702871]  ? mark_held_locks+0x50/0x80
> > [32840.702874]  ? _raw_spin_unlock_irq+0x29/0x40
> > [32840.702877]  ? lockdep_hardirqs_on+0xf0/0x180
> > [32840.702881]  ? _raw_spin_unlock_irq+0x29/0x40
> > [32840.702884]  ? wait_for_completion_timeout+0x75/0x190
> > [32840.702895]  ? commit_tail+0x3c/0x70 [drm_kms_helper]
> > [32840.702902]  commit_tail+0x3c/0x70 [drm_kms_helper]
> > [32840.702909]  drm_atomic_helper_commit+0xe3/0x150 [drm_kms_helper]
> > [32840.702922]  drm_atomic_connector_commit_dpms+0xd7/0x100 [drm]
> > [32840.702936]  set_property_atomic+0xcc/0x140 [drm]
> > [32840.702955]  drm_mode_obj_set_property_ioctl+0xcb/0x1c0 [drm]
> > [32840.702968]  ? drm_mode_obj_find_prop_id+0x40/0x40 [drm]
> > [32840.702978]  drm_ioctl_kernel+0xaa/0xf0 [drm]
> > [32840.702990]  drm_ioctl+0x208/0x390 [drm]
> > [32840.703003]  ? drm_mode_obj_find_prop_id+0x40/0x40 [drm]
> > [32840.703007]  ? sched_clock_cpu+0xc/0xc0
> > [32840.703012]  ? lockdep_hardirqs_on+0xf0/0x180
> > [32840.703053]  amdgpu_drm_ioctl+0x49/0x80 [amdgpu]
> > [32840.703058]  do_vfs_ioctl+0x411/0x750
> > [32840.703065]  ksys_ioctl+0x5e/0x90
> > [32840.703069]  __x64_sys_ioctl+0x16/0x20
> > [32840.703072]  do_syscall_64+0x5c/0xb0
> > [32840.703076]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > [32840.703079] RIP: 0033:0x7f8bcab0f00b
> > [32840.703084] Code: Bad RIP value.
> > [32840.703086] RSP: 002b:00007ffe76c62338 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > [32840.703089] RAX: ffffffffffffffda RBX: 00007ffe76c62370 RCX: 00007f8bcab0f00b
> > [32840.703092] RDX: 00007ffe76c62370 RSI: 00000000c01864ba RDI: 0000000000000009
> > [32840.703094] RBP: 00000000c01864ba R08: 0000000000000003 R09: 00000000c0c0c0c0
> > [32840.703096] R10: 000056476c86a018 R11: 0000000000000246 R12: 000056476c8ad940
> > [32840.703098] R13: 0000000000000009 R14: 0000000000000002 R15: 0000000000000003
> > [root@localhost ~]#
> > [root@localhost ~]# ps aux | grep gnome-shell
> > mikhail     1900  0.3  1.1 6447496 378696 tty2   Dl+  Aug24   2:10 > /usr/bin/gnome-shell
> > mikhail     2099  0.0  0.0 519984 23392 ?        Ssl  Aug24   0:00 > /usr/libexec/gnome-shell-calendar-server
> > mikhail    12214  0.0  0.0 399484 29660 pts/2    Sl+  Aug24   0:00 > /usr/bin/python3 /usr/bin/chrome-gnome-shell
> > chrome-extension://gphhapmejobijbbhgpjhcjognlahblep/
> > root       22957  0.0  0.0 216120  2456 pts/10   S+   03:59   0:00 > grep --color=auto gnome-shell
> > 
> > After it, I tried to kill gnome-shell process with signal 9, but the
> > process won't terminate after several unsuccessful attempts.
> > 
> > Only [Alt + PrnScr + B] helped reboot the hanging system.
> > I am writing here because I hope some ampgpu hackers cal look in the
> > trace and understand that is happening.
> > 
> > Sorry, I dont know how to reproduce this bug. But the problem itself
> > is very annoying.
> > 
> > Thanks.
> > 
> > GPU: AMD Radeon VII
> > Kernel: 5.3 RC5
> > 
> Can we try to add the fallback timer manually?
> 
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -322,6 +322,10 @@ int amdgpu_fence_wait_empty(struct amdgp
>  	}
>  	rcu_read_unlock();
>  
> +	if (!timer_pending(&ring->fence_drv.fallback_timer))
> +		mod_timer(&ring->fence_drv.fallback_timer,
> +			jiffies + (AMDGPU_FENCE_JIFFIES_TIMEOUT << 1));

This will paper over the issue, but won't fix it. dma_fences have to
complete, at least for normal operations, otherwise your desktop will
start feeling like the gpu hangs all the time.

I think would be much more interesting to dump which fence isn't
completing here in time, i.e. not just the timeout, but lots of debug
printks.
-Daniel

> +
>  	r = dma_fence_wait(fence, false);
>  	dma_fence_put(fence);
>  	return r;
> --
> 
> Or simply wait with an ear on signal and timeout if adding timer seems
> to go a bit too far?
> 
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -322,7 +322,12 @@ int amdgpu_fence_wait_empty(struct amdgp
>  	}
>  	rcu_read_unlock();
>  
> -	r = dma_fence_wait(fence, false);
> +	if (0 < dma_fence_wait_timeout(fence, true,
> +				AMDGPU_FENCE_JIFFIES_TIMEOUT +
> +				(AMDGPU_FENCE_JIFFIES_TIMEOUT >> 3)))
> +		r = 0;
> +	else
> +		r = -EINVAL;
>  	dma_fence_put(fence);
>  	return r;
>  }
> --
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
