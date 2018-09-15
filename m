From: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [BUG] gpu: drm: amdgpu: Possible sleep-in-atomic-context bugs in
 amdgpu_uvd_ring_begin_use()
Date: Sat, 15 Sep 2018 09:23:30 +0000
Message-ID: <68eb2303-ec42-470e-a060-487a14e2708c@email.android.com>
References: <dbf146f7-1196-43f8-a064-c59638788a54@email.android.com>,
 <9dd9f4ed-f338-8970-b29e-200ef0eafb62@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0998783355=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <9dd9f4ed-f338-8970-b29e-200ef0eafb62-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: de-DE
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Jia-Ju Bai <baijiaju1990-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "airlied-cv59FeDIM0c@public.gmane.org" <airlied-cv59FeDIM0c@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>

--===============0998783355==
Content-Language: de-DE
Content-Type: multipart/alternative;
	boundary="_000_68eb2303ec42470ea060487a14e2708cemailandroidcom_"

--_000_68eb2303ec42470ea060487a14e2708cemailandroidcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

No, the problem is the function pointer analysis.

In other words the KIQ ring is sometimes used in atomic and even interrupt =
context.

But the UVD ring is never used in atomic context.

But I don't see a way a static analysis could ever figure that out.

Regards,
Christian.

Am 15.09.2018 11:18 schrieb Jia-Ju Bai <baijiaju1990-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
Sorry, I am still not clear why the call chain I proposed is incorrect...

I find a conditional in amdgpu_mm_wreg():

    if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
        return amdgpu_virt_kiq_wreg(adev, reg, v);

Is amdgpu_virt_kiq_wreg() never called from WREG32() or RREG32()?


Best wishes,
Jia-Ju Bai


On 2018/9/15 17:10, Koenig, Christian wrote:
amdgpu_ring_alloc() does call amdgpu_uvd_begin_use(), but never in the call=
 chain you proposed.

Thinking about it I actually don't see a way a statically analysis could ev=
er figure that out.

Christian.

Am 15.09.2018 11:05 schrieb Jia-Ju Bai <baijiaju1990-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org><mailto:baij=
iaju1990-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
Thanks for your reply.

On 2018/9/15 17:01, Koenig, Christian wrote:
Sorry to say that but your analysis tool is buggy.

The proposed call paths will never trigger.

Could you please explain which piece of the call path is incorrect?
I am not very sure of my function pointer analysis.
Does amdgpu_ring_alloc() never calls amdgpu_uvd_ring_begin_use()?

Thanks in advance.


Best wishes,
Jia-Ju Bai


Regards,
Christian.

Am 15.09.2018 10:59 schrieb Jia-Ju Bai <baijiaju1990-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org><mailto:baij=
iaju1990-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
The driver may sleep with holding a spinlock.
The function call paths (from bottom to top) in Linux-4.17 are:

[FUNC] mutex_lock_nested
drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c, 1477:
     mutex_lock_nested in amdgpu_dpm_enable_uvd
drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c, 1154:
     amdgpu_dpm_enable_uvd in amdgpu_uvd_ring_begin_use
drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c, 80:
     [FUNC_PTR]amdgpu_uvd_ring_begin_use in amdgpu_ring_alloc
drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c, 199:
     amdgpu_ring_alloc in amdgpu_virt_kiq_wreg
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c, 207:
     amdgpu_virt_kiq_wreg in amdgpu_mm_wreg
drivers/gpu/drm/amd/amdgpu/vi.c, 207:
     amdgpu_mm_wreg in vi_gc_cac_rreg
drivers/gpu/drm/amd/amdgpu/vi.c, 206:
     _raw_spin_lock_irqsave in vi_gc_cac_rreg

[FUNC] mutex_lock_nested
drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c, 1477:
     mutex_lock_nested in amdgpu_dpm_enable_uvd
drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c, 1154:
     amdgpu_dpm_enable_uvd in amdgpu_uvd_ring_begin_use
drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c, 80:
     [FUNC_PTR]amdgpu_uvd_ring_begin_use in amdgpu_ring_alloc
drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c, 199:
     amdgpu_ring_alloc in amdgpu_virt_kiq_wreg
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c, 207:
     amdgpu_virt_kiq_wreg in amdgpu_mm_wreg
drivers/gpu/drm/amd/amdgpu/soc15.c, 106:
     amdgpu_mm_wreg in soc15_pcie_rreg
drivers/gpu/drm/amd/amdgpu/soc15.c, 105:
     _raw_spin_lock_irqsave in soc15_pcie_rreg

[FUNC] mutex_lock_nested
drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c, 1477:
     mutex_lock_nested in amdgpu_dpm_enable_uvd
drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c, 1154:
     amdgpu_dpm_enable_uvd in amdgpu_uvd_ring_begin_use
drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c, 80:
     [FUNC_PTR]amdgpu_uvd_ring_begin_use in amdgpu_ring_alloc
drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c, 199:
     amdgpu_ring_alloc in amdgpu_virt_kiq_wreg
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c, 207:
     amdgpu_virt_kiq_wreg in amdgpu_mm_wreg
drivers/gpu/drm/amd/amdgpu/cik.c, 139:
     amdgpu_mm_wreg in cik_uvd_ctx_wreg
drivers/gpu/drm/amd/amdgpu/cik.c, 138:
     _raw_spin_lock_irqsave in cik_uvd_ctx_wreg

[FUNC] mutex_lock_nested
drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c, 1477:
     mutex_lock_nested in amdgpu_dpm_enable_uvd
drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c, 1154:
     amdgpu_dpm_enable_uvd in amdgpu_uvd_ring_begin_use
drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c, 80:
     [FUNC_PTR]amdgpu_uvd_ring_begin_use in amdgpu_ring_alloc
drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c, 199:
     amdgpu_ring_alloc in amdgpu_virt_kiq_wreg
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c, 207:
     amdgpu_virt_kiq_wreg in amdgpu_mm_wreg
drivers/gpu/drm/amd/amdgpu/dce_v6_0.c, 126:
     amdgpu_mm_wreg in dce_v6_0_audio_endpt_rreg
drivers/gpu/drm/amd/amdgpu/dce_v6_0.c, 125:
     _raw_spin_lock_irqsave in dce_v6_0_audio_endpt_rreg

Note that [FUNC_PTR] means a function pointer call is used.

These bugs are found by my static analysis tool DSAC.


Best wishes,
Jia-Ju Bai




--_000_68eb2303ec42470ea060487a14e2708cemailandroidcom_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta content=3D"text/html; charset=3Dutf-8">
</head>
<body bgcolor=3D"#FFFFFF">
<div dir=3D"auto">No, the problem is the function pointer analysis.
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">In other words the KIQ ring is sometimes used in atomic a=
nd even interrupt context.</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">But the UVD ring is never used in atomic context.</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">But I don't see a way a static analysis could ever figure=
 that out.</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Regards,</div>
<div dir=3D"auto">Christian.</div>
</div>
<div class=3D"gmail_extra"><br>
<div class=3D"gmail_quote">Am 15.09.2018 11:18 schrieb Jia-Ju Bai &lt;baiji=
aju1990-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;:<br type=3D"attribution">
</div>
</div>
<div>Sorry, I am still not clear why the call chain I proposed is incorrect=
...<br>
<br>
I find a conditional in amdgpu_mm_wreg():<br>
<br>
&nbsp;&nbsp;&nbsp; if (!(acc_flags &amp; AMDGPU_REGS_NO_KIQ) &amp;&amp; amd=
gpu_sriov_runtime(adev))<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return amdgpu_virt_kiq_wreg(adev, reg=
, v);<br>
<br>
Is amdgpu_virt_kiq_wreg() never called from WREG32() or RREG32()?<br>
<br>
<br>
Best wishes,<br>
Jia-Ju Bai<br>
<br>
<br>
<div class=3D"moz-cite-prefix">On 2018/9/15 17:10, Koenig, Christian wrote:=
<br>
</div>
<blockquote type=3D"cite">
<div dir=3D"auto">
<div>amdgpu_ring_alloc() does call amdgpu_uvd_begin_use(), but never in the=
 call chain you proposed.</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Thinking about it I actually don't see a way a statically=
 analysis could ever figure that out.</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Christian.</div>
<div dir=3D"auto">
<div class=3D"gmail_extra" dir=3D"auto"><br>
<div class=3D"gmail_quote">Am 15.09.2018 11:05 schrieb Jia-Ju Bai <a class=
=3D"moz-txt-link-rfc2396E" href=3D"mailto:baijiaju1990-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">
&lt;baijiaju1990-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a>:<br type=3D"attribution">
<blockquote class=3D"quote" style=3D"margin:0 0 0
                .8ex; border-left:1px #ccc solid; padding-left:1ex">
<div>Thanks for your reply.<br>
<br>
<div>On 2018/9/15 17:01, Koenig, Christian wrote:<br>
</div>
<blockquote>
<div>
<div dir=3D"auto">Sorry to say that but your analysis tool is buggy.
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">The proposed call paths will never trigger.</div>
</div>
</div>
</blockquote>
<br>
Could you please explain which piece of the call path is incorrect?<br>
I am not very sure of my function pointer analysis.<br>
Does amdgpu_ring_alloc() never calls amdgpu_uvd_ring_begin_use()?<br>
<br>
Thanks in advance.<br>
<br>
<br>
Best wishes,<br>
Jia-Ju Bai<br>
<br>
<blockquote>
<div>
<div dir=3D"auto">
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Regards,</div>
<div dir=3D"auto">Christian.</div>
</div>
<div><br>
<div>Am 15.09.2018 10:59 schrieb Jia-Ju Bai <a href=3D"mailto:baijiaju1990@=
gmail.com">
&lt;baijiaju1990-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a>:<br type=3D"attribution">
</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:11pt">
<div>The driver may sleep with holding a spinlock.<br>
The function call paths (from bottom to top) in Linux-4.17 are:<br>
<br>
[FUNC] mutex_lock_nested<br>
drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c, 1477:<br>
&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock_nested in amdgpu_dpm_enable_uvd<br>
drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c, 1154:<br>
&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dpm_enable_uvd in amdgpu_uvd_ring_begin_use=
<br>
drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c, 80:<br>
&nbsp;&nbsp;&nbsp;&nbsp; [FUNC_PTR]amdgpu_uvd_ring_begin_use in amdgpu_ring=
_alloc<br>
drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c, 199:<br>
&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_alloc in amdgpu_virt_kiq_wreg<br>
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c, 207:<br>
&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_virt_kiq_wreg in amdgpu_mm_wreg<br>
drivers/gpu/drm/amd/amdgpu/vi.c, 207:<br>
&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mm_wreg in vi_gc_cac_rreg<br>
drivers/gpu/drm/amd/amdgpu/vi.c, 206:<br>
&nbsp;&nbsp;&nbsp;&nbsp; _raw_spin_lock_irqsave in vi_gc_cac_rreg<br>
<br>
[FUNC] mutex_lock_nested<br>
drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c, 1477:<br>
&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock_nested in amdgpu_dpm_enable_uvd<br>
drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c, 1154:<br>
&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dpm_enable_uvd in amdgpu_uvd_ring_begin_use=
<br>
drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c, 80:<br>
&nbsp;&nbsp;&nbsp;&nbsp; [FUNC_PTR]amdgpu_uvd_ring_begin_use in amdgpu_ring=
_alloc<br>
drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c, 199:<br>
&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_alloc in amdgpu_virt_kiq_wreg<br>
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c, 207:<br>
&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_virt_kiq_wreg in amdgpu_mm_wreg<br>
drivers/gpu/drm/amd/amdgpu/soc15.c, 106:<br>
&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mm_wreg in soc15_pcie_rreg<br>
drivers/gpu/drm/amd/amdgpu/soc15.c, 105:<br>
&nbsp;&nbsp;&nbsp;&nbsp; _raw_spin_lock_irqsave in soc15_pcie_rreg<br>
<br>
[FUNC] mutex_lock_nested<br>
drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c, 1477:<br>
&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock_nested in amdgpu_dpm_enable_uvd<br>
drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c, 1154:<br>
&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dpm_enable_uvd in amdgpu_uvd_ring_begin_use=
<br>
drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c, 80:<br>
&nbsp;&nbsp;&nbsp;&nbsp; [FUNC_PTR]amdgpu_uvd_ring_begin_use in amdgpu_ring=
_alloc<br>
drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c, 199:<br>
&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_alloc in amdgpu_virt_kiq_wreg<br>
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c, 207:<br>
&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_virt_kiq_wreg in amdgpu_mm_wreg<br>
drivers/gpu/drm/amd/amdgpu/cik.c, 139:<br>
&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mm_wreg in cik_uvd_ctx_wreg<br>
drivers/gpu/drm/amd/amdgpu/cik.c, 138:<br>
&nbsp;&nbsp;&nbsp;&nbsp; _raw_spin_lock_irqsave in cik_uvd_ctx_wreg<br>
<br>
[FUNC] mutex_lock_nested<br>
drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c, 1477:<br>
&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock_nested in amdgpu_dpm_enable_uvd<br>
drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c, 1154:<br>
&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dpm_enable_uvd in amdgpu_uvd_ring_begin_use=
<br>
drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c, 80:<br>
&nbsp;&nbsp;&nbsp;&nbsp; [FUNC_PTR]amdgpu_uvd_ring_begin_use in amdgpu_ring=
_alloc<br>
drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c, 199:<br>
&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_alloc in amdgpu_virt_kiq_wreg<br>
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c, 207:<br>
&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_virt_kiq_wreg in amdgpu_mm_wreg<br>
drivers/gpu/drm/amd/amdgpu/dce_v6_0.c, 126:<br>
&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mm_wreg in dce_v6_0_audio_endpt_rreg<br>
drivers/gpu/drm/amd/amdgpu/dce_v6_0.c, 125:<br>
&nbsp;&nbsp;&nbsp;&nbsp; _raw_spin_lock_irqsave in dce_v6_0_audio_endpt_rre=
g<br>
<br>
Note that [FUNC_PTR] means a function pointer call is used.<br>
<br>
These bugs are found by my static analysis tool DSAC.<br>
<br>
<br>
Best wishes,<br>
Jia-Ju Bai<br>
</div>
</span></font></blockquote>
<br>
</div>
</blockquote>
</div>
<br>
</div>
</div>
</div>
</blockquote>
<br>
</div>
</body>
</html>

--_000_68eb2303ec42470ea060487a14e2708cemailandroidcom_--

--===============0998783355==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0998783355==--
