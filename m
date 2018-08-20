From: "Zhu, James" <James.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2 5/5] drm/amdgpu:add VCN booting with firmware loaded by
 PSP
Date: Mon, 20 Aug 2018 13:42:59 +0000
Message-ID: <CY4PR1201MB01023F0F48FCB23B50671D4FE4320@CY4PR1201MB0102.namprd12.prod.outlook.com>
References: <1533832302-21440-1-git-send-email-James.Zhu@amd.com>
 <1533832302-21440-5-git-send-email-James.Zhu@amd.com>,
 <18e7213d-1d9e-c613-43bd-fe735a9de130@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0919512655=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <18e7213d-1d9e-c613-43bd-fe735a9de130-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
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
To: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, James Zhu <jzhums-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Xu,
 Feifei" <Feifei.Xu-5C7GfCeVMHo@public.gmane.org>, "Gao, Likun" <Likun.Gao-5C7GfCeVMHo@public.gmane.org>, "Huang,
 Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "Liu, Leo" <Leo.Liu-5C7GfCeVMHo@public.gmane.org>

--===============0919512655==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR1201MB01023F0F48FCB23B50671D4FE4320CY4PR1201MB0102_"

--_000_CY4PR1201MB01023F0F48FCB23B50671D4FE4320CY4PR1201MB0102_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Felix,


We did test on both China team and Makham team. Also Embedded team did the =
test also on release 18.20 for Raven.


Please let ROCm CQE team issue a JIRA ticket and the detail reproduce step.


Thanks & Best Regards!


James Zhu

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Felix Ku=
ehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, August 17, 2018 7:25:53 PM
To: James Zhu; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Deucher, Alexander; Gao, Likun; Zhu, James; Huang, Ray
Subject: Re: [PATCH v2 5/5] drm/amdgpu:add VCN booting with firmware loaded=
 by PSP

ROCm CQE is seeing what looks like hangs during amdgpu initialization on
Raven and Vega20. Amdgpu basically stops printing messages while trying
to load VCN firmware. It never completes initialization, but there is no
obvious error message. These are the last messages from amdgpu in the log:

[    1.282661] [drm] Found VCN firmware Version: 1.24 Family ID: 18
[    1.282664] [drm] PSP loading VCN firmware
[    1.303164] [drm] reserve 0x400000 from 0xf400e00000 for PSP TMR SIZE

Any applications trying to use /dev/dri/* hang with a backtrace like below.

Was this change expected to affect Raven and Vega20? Has it been tested
before submitting? Do we need updated VCN firmware for it to work?

Thanks,
  Felix

[  363.352985] INFO: task gpu-manager:937 blocked for more than 120 seconds=
.
[  363.352995]       Not tainted 4.18.0-rc1-kfd-compute-roc-master-8912 #1
[  363.352999] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this message.
[  363.353004] gpu-manager     D    0   937      1 0x00000000
[  363.353008] Call Trace:
[  363.353018]  ? __schedule+0x3d9/0x8b0
[  363.353023]  schedule+0x32/0x80
[  363.353026]  schedule_preempt_disabled+0xa/0x10
[  363.353028]  __mutex_lock.isra.4+0x2ae/0x4e0
[  363.353031]  ? _cond_resched+0x16/0x40
[  363.353048]  ? drm_stub_open+0x2e/0x100 [drm]
[  363.353063]  drm_stub_open+0x2e/0x100 [drm]
[  363.353069]  chrdev_open+0xbe/0x1a0
[  363.353072]  ? cdev_put+0x20/0x20
[  363.353075]  do_dentry_open+0x1e2/0x300
[  363.353078]  path_openat+0x2b4/0x14b0
[  363.353082]  ? vsnprintf+0x230/0x4c0
[  363.353086]  ? __alloc_pages_nodemask+0x100/0x290
[  363.353088]  do_filp_open+0x99/0x110
[  363.353092]  ? generic_update_time+0x6a/0xc0
[  363.353094]  ? touch_atime+0xc1/0xd0
[  363.353096]  ? _cond_resched+0x16/0x40
[  363.353100]  ? do_sys_open+0x126/0x210
[  363.353102]  do_sys_open+0x126/0x210
[  363.353106]  do_syscall_64+0x4f/0x100
[  363.353110]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  363.353113] RIP: 0033:0x7f988f340040
[  363.353113] Code: Bad RIP value.
[  363.353120] RSP: 002b:00007ffecdefe618 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000002
[  363.353123] RAX: ffffffffffffffda RBX: 0000000002337cd0 RCX: 00007f988f3=
40040
[  363.353124] RDX: 00007ffecdefe67e RSI: 0000000000000002 RDI: 00007ffecde=
fe670
[  363.353125] RBP: 00007ffecdefe6a0 R08: 0000000000000000 R09: 00000000000=
0000e
[  363.353126] R10: 000000000000069d R11: 0000000000000246 R12: 00000000004=
01b40
[  363.353127] R13: 00007ffecdefe910 R14: 0000000000000000 R15: 00000000000=
00000



On 2018-08-09 12:31 PM, James Zhu wrote:
> From: Likun Gao <Likun.Gao-5C7GfCeVMHo@public.gmane.org>
>
> Setup psp firmware loading for VCN, and make VCN block
> booting from tmr mac address.
>
> Signed-off-by: James Zhu <James.Zhu-5C7GfCeVMHo@public.gmane.org>
> Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 17 +++++++++------
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   | 38 ++++++++++++++++++++++++++-=
------
>  2 files changed, 40 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.c
> index 878f62c..77c192a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -111,9 +111,10 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
>                        version_major, version_minor, family_id);
>        }
>
> -     bo_size =3D AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes=
) + 8)
> -               +  AMDGPU_VCN_STACK_SIZE + AMDGPU_VCN_HEAP_SIZE
> +     bo_size =3D AMDGPU_VCN_STACK_SIZE + AMDGPU_VCN_HEAP_SIZE
>                  +  AMDGPU_VCN_SESSION_SIZE * 40;
> +     if (adev->firmware.load_type !=3D AMDGPU_FW_LOAD_PSP)
> +             bo_size +=3D AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_s=
ize_bytes) + 8);
>        r =3D amdgpu_bo_create_kernel(adev, bo_size, PAGE_SIZE,
>                                    AMDGPU_GEM_DOMAIN_VRAM, &adev->vcn.vcp=
u_bo,
>                                    &adev->vcn.gpu_addr, &adev->vcn.cpu_ad=
dr);
> @@ -189,11 +190,13 @@ int amdgpu_vcn_resume(struct amdgpu_device *adev)
>                unsigned offset;
>
>                hdr =3D (const struct common_firmware_header *)adev->vcn.f=
w->data;
> -             offset =3D le32_to_cpu(hdr->ucode_array_offset_bytes);
> -             memcpy_toio(adev->vcn.cpu_addr, adev->vcn.fw->data + offset=
,
> -                         le32_to_cpu(hdr->ucode_size_bytes));
> -             size -=3D le32_to_cpu(hdr->ucode_size_bytes);
> -             ptr +=3D le32_to_cpu(hdr->ucode_size_bytes);
> +             if (adev->firmware.load_type !=3D AMDGPU_FW_LOAD_PSP) {
> +                     offset =3D le32_to_cpu(hdr->ucode_array_offset_byte=
s);
> +                     memcpy_toio(adev->vcn.cpu_addr, adev->vcn.fw->data =
+ offset,
> +                                 le32_to_cpu(hdr->ucode_size_bytes));
> +                     size -=3D le32_to_cpu(hdr->ucode_size_bytes);
> +                     ptr +=3D le32_to_cpu(hdr->ucode_size_bytes);
> +             }
>                memset_io(ptr, 0, size);
>        }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v1_0.c
> index 2ce91a7..74c4ef4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -100,6 +100,16 @@ static int vcn_v1_0_sw_init(void *handle)
>        if (r)
>                return r;
>
> +     if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP) {
> +             const struct common_firmware_header *hdr;
> +             hdr =3D (const struct common_firmware_header *)adev->vcn.fw=
->data;
> +             adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].ucode_id =3D AMDG=
PU_UCODE_ID_VCN;
> +             adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].fw =3D adev->vcn.=
fw;
> +             adev->firmware.fw_size +=3D
> +                     ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE=
);
> +             DRM_INFO("PSP loading VCN firmware\n");
> +     }
> +
>        r =3D amdgpu_vcn_resume(adev);
>        if (r)
>                return r;
> @@ -265,26 +275,38 @@ static int vcn_v1_0_resume(void *handle)
>  static void vcn_v1_0_mc_resume(struct amdgpu_device *adev)
>  {
>        uint32_t size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw->size + 4);
> -
> -     WREG32_SOC15(UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
> +     uint32_t offset;
> +
> +     if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP) {
> +             WREG32_SOC15(UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
> +                     (adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].tmr_mc_a=
ddr_lo));
> +             WREG32_SOC15(UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,
> +                     (adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].tmr_mc_a=
ddr_hi));
> +             WREG32_SOC15(UVD, 0, mmUVD_VCPU_CACHE_OFFSET0, 0);
> +             offset =3D 0;
> +     } else {
> +             WREG32_SOC15(UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
>                        lower_32_bits(adev->vcn.gpu_addr));
> -     WREG32_SOC15(UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,
> +             WREG32_SOC15(UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,
>                        upper_32_bits(adev->vcn.gpu_addr));
> -     WREG32_SOC15(UVD, 0, mmUVD_VCPU_CACHE_OFFSET0,
> +             offset =3D size;
> +             WREG32_SOC15(UVD, 0, mmUVD_VCPU_CACHE_OFFSET0,
>                                AMDGPU_UVD_FIRMWARE_OFFSET >> 3);
> +     }
> +
>        WREG32_SOC15(UVD, 0, mmUVD_VCPU_CACHE_SIZE0, size);
>
>        WREG32_SOC15(UVD, 0, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW,
> -                     lower_32_bits(adev->vcn.gpu_addr + size));
> +                     lower_32_bits(adev->vcn.gpu_addr + offset));
>        WREG32_SOC15(UVD, 0, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH,
> -                     upper_32_bits(adev->vcn.gpu_addr + size));
> +                     upper_32_bits(adev->vcn.gpu_addr + offset));
>        WREG32_SOC15(UVD, 0, mmUVD_VCPU_CACHE_OFFSET1, 0);
>        WREG32_SOC15(UVD, 0, mmUVD_VCPU_CACHE_SIZE1, AMDGPU_VCN_HEAP_SIZE)=
;
>
>        WREG32_SOC15(UVD, 0, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW,
> -                     lower_32_bits(adev->vcn.gpu_addr + size + AMDGPU_VC=
N_HEAP_SIZE));
> +                     lower_32_bits(adev->vcn.gpu_addr + offset + AMDGPU_=
VCN_HEAP_SIZE));
>        WREG32_SOC15(UVD, 0, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH,
> -                     upper_32_bits(adev->vcn.gpu_addr + size + AMDGPU_VC=
N_HEAP_SIZE));
> +                     upper_32_bits(adev->vcn.gpu_addr + offset + AMDGPU_=
VCN_HEAP_SIZE));
>        WREG32_SOC15(UVD, 0, mmUVD_VCPU_CACHE_OFFSET2, 0);
>        WREG32_SOC15(UVD, 0, mmUVD_VCPU_CACHE_SIZE2,
>                        AMDGPU_VCN_STACK_SIZE + (AMDGPU_VCN_SESSION_SIZE *=
 40));

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_CY4PR1201MB01023F0F48FCB23B50671D4FE4320CY4PR1201MB0102_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Hi Felix,</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">We did test on both China team an=
d Makham team. Also Embedded team did the test also on release 18.20 for Ra=
ven.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Please let <font size=3D"2"><span=
 style=3D"font-size:11pt;">ROCm CQE</span></font> team issue a JIRA ticket =
and the detail reproduce step.<br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<div id=3D"Signature">
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size: 12pt; colo=
r: rgb(0, 0, 0); font-family: Calibri, Arial, Helvetica, sans-serif, &quot;=
EmojiFont&quot;, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;,=
 NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, Em=
ojiSymbols;">
<p>Thanks &amp; Best Regards!</p>
<p><br>
</p>
<p>James Zhu<br>
</p>
</div>
</div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Felix Kuehling &lt;felix.kueh=
ling-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Friday, August 17, 2018 7:25:53 PM<br>
<b>To:</b> James Zhu; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Deucher, Alexander; Gao, Likun; Zhu, James; Huang, Ray<br>
<b>Subject:</b> Re: [PATCH v2 5/5] drm/amdgpu:add VCN booting with firmware=
 loaded by PSP</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">ROCm CQE is seeing what looks like hangs during am=
dgpu initialization on<br>
Raven and Vega20. Amdgpu basically stops printing messages while trying<br>
to load VCN firmware. It never completes initialization, but there is no<br=
>
obvious error message. These are the last messages from amdgpu in the log:<=
br>
<br>
[&nbsp;&nbsp;&nbsp; 1.282661] [drm] Found VCN firmware Version: 1.24 Family=
 ID: 18<br>
[&nbsp;&nbsp;&nbsp; 1.282664] [drm] PSP loading VCN firmware<br>
[&nbsp;&nbsp;&nbsp; 1.303164] [drm] reserve 0x400000 from 0xf400e00000 for =
PSP TMR SIZE<br>
<br>
Any applications trying to use /dev/dri/* hang with a backtrace like below.=
<br>
<br>
Was this change expected to affect Raven and Vega20? Has it been tested<br>
before submitting? Do we need updated VCN firmware for it to work?<br>
<br>
Thanks,<br>
&nbsp; Felix<br>
<br>
[&nbsp; 363.352985] INFO: task gpu-manager:937 blocked for more than 120 se=
conds.<br>
[&nbsp; 363.352995]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Not tainted 4.18.0-=
rc1-kfd-compute-roc-master-8912 #1<br>
[&nbsp; 363.352999] &quot;echo 0 &gt; /proc/sys/kernel/hung_task_timeout_se=
cs&quot; disables this message.<br>
[&nbsp; 363.353004] gpu-manager&nbsp;&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp;=
 0&nbsp;&nbsp; 937&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 0x00000000<br>
[&nbsp; 363.353008] Call Trace:<br>
[&nbsp; 363.353018]&nbsp; ? __schedule&#43;0x3d9/0x8b0<br>
[&nbsp; 363.353023]&nbsp; schedule&#43;0x32/0x80<br>
[&nbsp; 363.353026]&nbsp; schedule_preempt_disabled&#43;0xa/0x10<br>
[&nbsp; 363.353028]&nbsp; __mutex_lock.isra.4&#43;0x2ae/0x4e0<br>
[&nbsp; 363.353031]&nbsp; ? _cond_resched&#43;0x16/0x40<br>
[&nbsp; 363.353048]&nbsp; ? drm_stub_open&#43;0x2e/0x100 [drm]<br>
[&nbsp; 363.353063]&nbsp; drm_stub_open&#43;0x2e/0x100 [drm]<br>
[&nbsp; 363.353069]&nbsp; chrdev_open&#43;0xbe/0x1a0<br>
[&nbsp; 363.353072]&nbsp; ? cdev_put&#43;0x20/0x20<br>
[&nbsp; 363.353075]&nbsp; do_dentry_open&#43;0x1e2/0x300<br>
[&nbsp; 363.353078]&nbsp; path_openat&#43;0x2b4/0x14b0<br>
[&nbsp; 363.353082]&nbsp; ? vsnprintf&#43;0x230/0x4c0<br>
[&nbsp; 363.353086]&nbsp; ? __alloc_pages_nodemask&#43;0x100/0x290<br>
[&nbsp; 363.353088]&nbsp; do_filp_open&#43;0x99/0x110<br>
[&nbsp; 363.353092]&nbsp; ? generic_update_time&#43;0x6a/0xc0<br>
[&nbsp; 363.353094]&nbsp; ? touch_atime&#43;0xc1/0xd0<br>
[&nbsp; 363.353096]&nbsp; ? _cond_resched&#43;0x16/0x40<br>
[&nbsp; 363.353100]&nbsp; ? do_sys_open&#43;0x126/0x210<br>
[&nbsp; 363.353102]&nbsp; do_sys_open&#43;0x126/0x210<br>
[&nbsp; 363.353106]&nbsp; do_syscall_64&#43;0x4f/0x100<br>
[&nbsp; 363.353110]&nbsp; entry_SYSCALL_64_after_hwframe&#43;0x44/0xa9<br>
[&nbsp; 363.353113] RIP: 0033:0x7f988f340040<br>
[&nbsp; 363.353113] Code: Bad RIP value.<br>
[&nbsp; 363.353120] RSP: 002b:00007ffecdefe618 EFLAGS: 00000246 ORIG_RAX: 0=
000000000000002<br>
[&nbsp; 363.353123] RAX: ffffffffffffffda RBX: 0000000002337cd0 RCX: 00007f=
988f340040<br>
[&nbsp; 363.353124] RDX: 00007ffecdefe67e RSI: 0000000000000002 RDI: 00007f=
fecdefe670<br>
[&nbsp; 363.353125] RBP: 00007ffecdefe6a0 R08: 0000000000000000 R09: 000000=
000000000e<br>
[&nbsp; 363.353126] R10: 000000000000069d R11: 0000000000000246 R12: 000000=
0000401b40<br>
[&nbsp; 363.353127] R13: 00007ffecdefe910 R14: 0000000000000000 R15: 000000=
0000000000<br>
<br>
<br>
<br>
On 2018-08-09 12:31 PM, James Zhu wrote:<br>
&gt; From: Likun Gao &lt;Likun.Gao-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;<br>
&gt; Setup psp firmware loading for VCN, and make VCN block<br>
&gt; booting from tmr mac address.<br>
&gt;<br>
&gt; Signed-off-by: James Zhu &lt;James.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 17 &#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;------<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c&nbsp;&nbsp; | 38 &#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-------<br>
&gt;&nbsp; 2 files changed, 40 insertions(&#43;), 15 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_vcn.c<br>
&gt; index 878f62c..77c192a 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
&gt; @@ -111,9 &#43;111,10 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *=
adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; version=
_major, version_minor, family_id);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; bo_size =3D AMDGPU_GPU_PAGE_ALIGN(le32_to_cp=
u(hdr-&gt;ucode_size_bytes) &#43; 8)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; &#43;&nbsp; AMDGPU_VCN_STACK_SIZE &#43; AMDGPU_VCN_HEAP_SIZ=
E<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; bo_size =3D AMDGPU_VCN_STACK_SIZE &#43; =
AMDGPU_VCN_HEAP_SIZE<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &#43;&nbsp; AMDGPU_VCN_SESSION_SIZE * 40;<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;firmware.load_type !=3D AMD=
GPU_FW_LOAD_PSP)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; bo_size &#43;=3D AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr-&gt;ucode_si=
ze_bytes) &#43; 8);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_create_kerne=
l(adev, bo_size, PAGE_SIZE,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GEM=
_DOMAIN_VRAM, &amp;adev-&gt;vcn.vcpu_bo,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;adev-=
&gt;vcn.gpu_addr, &amp;adev-&gt;vcn.cpu_addr);<br>
&gt; @@ -189,11 &#43;190,13 @@ int amdgpu_vcn_resume(struct amdgpu_device *=
adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; unsigned offset;<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; hdr =3D (const struct common_firmware_header *)adev-&gt=
;vcn.fw-&gt;data;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; offset =3D le32_to_cpu(hdr-&gt;ucode_array_offset_bytes);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; memcpy_toio(adev-&gt;vcn.cpu_addr, adev-&gt;vcn.fw-&gt;data &#43; offse=
t,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 le32_to_cpu(hdr-&gt;ucode_size_bytes));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; size -=3D le32_to_cpu(hdr-&gt;ucode_size_bytes);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ptr &#43;=3D le32_to_cpu(hdr-&gt;ucode_size_bytes);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (adev-&gt;firmware.load_type !=3D AMDGPU_FW_LOAD_PSP) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offset =3D le32_to_=
cpu(hdr-&gt;ucode_array_offset_bytes);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy_toio(adev-&g=
t;vcn.cpu_addr, adev-&gt;vcn.fw-&gt;data &#43; offset,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(hdr-&gt;uc=
ode_size_bytes));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size -=3D le32_to_c=
pu(hdr-&gt;ucode_size_bytes);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ptr &#43;=3D le32_t=
o_cpu(hdr-&gt;ucode_size_bytes);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; memset_io(ptr, 0, size);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/a=
md/amdgpu/vcn_v1_0.c<br>
&gt; index 2ce91a7..74c4ef4 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c<br>
&gt; @@ -100,6 &#43;100,16 @@ static int vcn_v1_0_sw_init(void *handle)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&nbsp; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;firmware.load_type =3D=3D A=
MDGPU_FW_LOAD_PSP) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; const struct common_firmware_header *hdr;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; hdr =3D (const struct common_firmware_header *)adev-&gt;vcn.fw-&gt;=
data;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;firmware.ucode[AMDGPU_UCODE_ID_VCN].ucode_id =3D AMDGPU_UC=
ODE_ID_VCN;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;firmware.ucode[AMDGPU_UCODE_ID_VCN].fw =3D adev-&gt;vcn.fw=
;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;firmware.fw_size &#43;=3D<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALIGN(le32_to_cpu(h=
dr-&gt;ucode_size_bytes), PAGE_SIZE);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; DRM_INFO(&quot;PSP loading VCN firmware\n&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_vcn_resume(adev=
);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; @@ -265,26 &#43;275,38 @@ static int vcn_v1_0_resume(void *handle)<br>
&gt;&nbsp; static void vcn_v1_0_mc_resume(struct amdgpu_device *adev)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t size =3D AMDGPU_GPU=
_PAGE_ALIGN(adev-&gt;vcn.fw-&gt;size &#43; 4);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(UVD, 0, mmUVD_LMI_VCPU_CACHE_64=
BIT_BAR_LOW,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t offset;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;firmware.load_type =3D=3D A=
MDGPU_FW_LOAD_PSP) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_SOC15(UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;firmware.=
ucode[AMDGPU_UCODE_ID_VCN].tmr_mc_addr_lo));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_SOC15(UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;firmware.=
ucode[AMDGPU_UCODE_ID_VCN].tmr_mc_addr_hi));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_SOC15(UVD, 0, mmUVD_VCPU_CACHE_OFFSET0, 0);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; offset =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_SOC15(UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lower_3=
2_bits(adev-&gt;vcn.gpu_addr));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(UVD, 0, mmUVD_LMI_VCPU_CACHE_64=
BIT_BAR_HIGH,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_SOC15(UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; upper_3=
2_bits(adev-&gt;vcn.gpu_addr));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(UVD, 0, mmUVD_VCPU_CACHE_OFFSET=
0,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; offset =3D size;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_SOC15(UVD, 0, mmUVD_VCPU_CACHE_OFFSET0,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_UVD_FIRMWARE_OFFSET &gt;&gt=
; 3);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(UVD, 0, mmUVD_V=
CPU_CACHE_SIZE0, size);<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(UVD, 0, mmUVD_L=
MI_VCPU_CACHE1_64BIT_BAR_LOW,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lower_32_bits(adev-&gt;=
vcn.gpu_addr &#43; size));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lower_32_bits(adev-=
&gt;vcn.gpu_addr &#43; offset));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(UVD, 0, mmUVD_L=
MI_VCPU_CACHE1_64BIT_BAR_HIGH,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; upper_32_bits(adev-&gt;=
vcn.gpu_addr &#43; size));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; upper_32_bits(adev-=
&gt;vcn.gpu_addr &#43; offset));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(UVD, 0, mmUVD_V=
CPU_CACHE_OFFSET1, 0);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(UVD, 0, mmUVD_V=
CPU_CACHE_SIZE1, AMDGPU_VCN_HEAP_SIZE);<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(UVD, 0, mmUVD_L=
MI_VCPU_CACHE2_64BIT_BAR_LOW,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lower_32_bits(adev-&gt;=
vcn.gpu_addr &#43; size &#43; AMDGPU_VCN_HEAP_SIZE));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lower_32_bits(adev-=
&gt;vcn.gpu_addr &#43; offset &#43; AMDGPU_VCN_HEAP_SIZE));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(UVD, 0, mmUVD_L=
MI_VCPU_CACHE2_64BIT_BAR_HIGH,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; upper_32_bits(adev-&gt;=
vcn.gpu_addr &#43; size &#43; AMDGPU_VCN_HEAP_SIZE));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; upper_32_bits(adev-=
&gt;vcn.gpu_addr &#43; offset &#43; AMDGPU_VCN_HEAP_SIZE));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(UVD, 0, mmUVD_V=
CPU_CACHE_OFFSET2, 0);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(UVD, 0, mmUVD_V=
CPU_CACHE_SIZE2,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_=
VCN_STACK_SIZE &#43; (AMDGPU_VCN_SESSION_SIZE * 40));<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_CY4PR1201MB01023F0F48FCB23B50671D4FE4320CY4PR1201MB0102_--

--===============0919512655==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0919512655==--
