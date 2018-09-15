From: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [BUG] gpu: drm: amdgpu: Possible sleep-in-atomic-context bugs in
 amdgpu_uvd_ring_begin_use()
Date: Sat, 15 Sep 2018 09:01:38 +0000
Message-ID: <3fe8b580-e94c-42bc-a4f8-54d8d44cbda2@email.android.com>
References: <f09853dc-591c-05d3-9f56-63e4b338c585@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1892635747=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <f09853dc-591c-05d3-9f56-63e4b338c585@gmail.com>
Content-Language: de-DE
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: "airlied@linux.ie" <airlied@linux.ie>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

--===============1892635747==
Content-Language: de-DE
Content-Type: multipart/alternative;
	boundary="_000_3fe8b580e94c42bca4f854d8d44cbda2emailandroidcom_"

--_000_3fe8b580e94c42bca4f854d8d44cbda2emailandroidcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Sorry to say that but your analysis tool is buggy.

The proposed call paths will never trigger.

Regards,
Christian.

Am 15.09.2018 10:59 schrieb Jia-Ju Bai <baijiaju1990@gmail.com>:
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

--_000_3fe8b580e94c42bca4f854d8d44cbda2emailandroidcom_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<div>
<div dir=3D"auto">Sorry to say that but your analysis tool is buggy.
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">The proposed call paths will never trigger.</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Regards,</div>
<div dir=3D"auto">Christian.</div>
</div>
<div class=3D"x_gmail_extra"><br>
<div class=3D"x_gmail_quote">Am 15.09.2018 10:59 schrieb Jia-Ju Bai &lt;bai=
jiaju1990@gmail.com&gt;:<br type=3D"attribution">
</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:11pt;">
<div class=3D"PlainText">The driver may sleep with holding a spinlock.<br>
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
</span></font>
</body>
</html>

--_000_3fe8b580e94c42bca4f854d8d44cbda2emailandroidcom_--

--===============1892635747==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1892635747==--
