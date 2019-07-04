From: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/1] drm/amdkfd: Consistently apply noretry setting
Date: Thu, 4 Jul 2019 07:14:38 +0000
Message-ID: <be9a4b8c-cd48-443f-9f55-09b41c91e263@email.android.com>
References: <20190622001959.32290-1-Felix.Kuehling@amd.com>
 <953e3a92-2d3b-0275-2a05-253570ab6277@amd.com>,
 <5edef671-8986-e513-f03b-15066b8ab0d6@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1522252846=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <5edef671-8986-e513-f03b-15066b8ab0d6-5C7GfCeVMHo@public.gmane.org>
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
To: "Yang, Philip" <Philip.Yang-5C7GfCeVMHo@public.gmane.org>
Cc: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1522252846==
Content-Language: de-DE
Content-Type: multipart/alternative;
	boundary="_000_be9a4b8ccd48443f9f5509b41c91e263emailandroidcom_"

--_000_be9a4b8ccd48443f9f5509b41c91e263emailandroidcom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Patches to silent retry faults are already on the mailing list.

But I need to get back from vacation to take a closer look at this once mor=
e.

Christian.

Am 04.07.2019 00:19 schrieb "Yang, Philip" <Philip.Yang-5C7GfCeVMHo@public.gmane.org>:
amdgpu_noretry default value is 0, this will generate VM fault storm
because the vm fault is not recovered. It may slow down the machine and
need reboot after application VM fault. Maybe change default value to 1?

Other than that, this is reviewed by Philip Yang <Philip.Yang-5C7GfCeVMHo@public.gmane.org>

On 2019-07-02 3:05 p.m., Kuehling, Felix wrote:
> Ping.
>
> Christian, Philip, any opinion about this patch?
>
> On 2019-06-21 8:20 p.m., Kuehling, Felix wrote:
>> Apply the same setting to SH_MEM_CONFIG and VM_CONTEXT1_CNTL. This
>> makes the noretry param no longer KFD-specific. On GFX10 I'm not
>> changing SH_MEM_CONFIG in this commit because GFX10 has different
>> retry behaviour in the SQ and I don't have a way to test it at the
>> moment.
>>
>> Suggested-by: Christian K=F6nig <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
>> CC: Philip Yang <Philip.Yang-5C7GfCeVMHo@public.gmane.org>
>> Signed-off-by: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h              |  1 +
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c          | 16 +++++----------=
-
>>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c            |  4 ++++
>>    drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c         |  3 ++-
>>    drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c         |  3 ++-
>>    drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c          |  3 ++-
>>    drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c          |  3 ++-
>>    .../drm/amd/amdkfd/kfd_device_queue_manager_v9.c |  2 +-
>>    drivers/gpu/drm/amd/amdkfd/kfd_priv.h            |  2 +-
>>    9 files changed, 20 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu.h
>> index 9b1efdf94bdf..05875279c09e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -164,6 +164,7 @@ extern int amdgpu_async_gfx_ring;
>>    extern int amdgpu_mcbp;
>>    extern int amdgpu_discovery;
>>    extern int amdgpu_mes;
>> +extern int amdgpu_noretry;
>>
>>    #ifdef CONFIG_DRM_AMDGPU_SI
>>    extern int amdgpu_si_support;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_drv.c
>> index 7cf6ab07b113..0d578d95be93 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -140,6 +140,7 @@ int amdgpu_async_gfx_ring =3D 1;
>>    int amdgpu_mcbp =3D 0;
>>    int amdgpu_discovery =3D 0;
>>    int amdgpu_mes =3D 0;
>> +int amdgpu_noretry;
>>
>>    struct amdgpu_mgpu_info mgpu_info =3D {
>>       .mutex =3D __MUTEX_INITIALIZER(mgpu_info.mutex),
>> @@ -591,6 +592,10 @@ MODULE_PARM_DESC(mes,
>>       "Enable Micro Engine Scheduler (0 =3D disabled (default), 1 =3D en=
abled)");
>>    module_param_named(mes, amdgpu_mes, int, 0444);
>>
>> +MODULE_PARM_DESC(noretry,
>> +    "Disable retry faults (0 =3D retry enabled (default), 1 =3D retry d=
isabled)");
>> +module_param_named(noretry, amdgpu_noretry, int, 0644);
>> +
>>    #ifdef CONFIG_HSA_AMD
>>    /**
>>     * DOC: sched_policy (int)
>> @@ -666,17 +671,6 @@ module_param(ignore_crat, int, 0444);
>>    MODULE_PARM_DESC(ignore_crat,
>>       "Ignore CRAT table during KFD initialization (0 =3D use CRAT (defa=
ult), 1 =3D ignore CRAT)");
>>
>> -/**
>> - * DOC: noretry (int)
>> - * This parameter sets sh_mem_config.retry_disable. Default value, 0, e=
nables retry.
>> - * Setting 1 disables retry.
>> - * Retry is needed for recoverable page faults.
>> - */
>> -int noretry;
>> -module_param(noretry, int, 0644);
>> -MODULE_PARM_DESC(noretry,
>> -    "Set sh_mem_config.retry_disable on Vega10 (0 =3D retry enabled (de=
fault), 1 =3D retry disabled)");
>> -
>>    /**
>>     * DOC: halt_if_hws_hang (int)
>>     * Halt if HWS hang is detected. Default value, 0, disables the halt =
on hang.
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v9_0.c
>> index e0f3014e76ea..c4e715170bfe 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> @@ -1938,11 +1938,15 @@ static void gfx_v9_0_constants_init(struct amdgp=
u_device *adev)
>>               if (i =3D=3D 0) {
>>                       tmp =3D REG_SET_FIELD(0, SH_MEM_CONFIG, ALIGNMENT_=
MODE,
>>                                           SH_MEM_ALIGNMENT_MODE_UNALIGNE=
D);
>> +                    tmp =3D REG_SET_FIELD(tmp, SH_MEM_CONFIG, RETRY_DIS=
ABLE,
>> +                                        !!amdgpu_noretry);
>>                       WREG32_SOC15_RLC(GC, 0, mmSH_MEM_CONFIG, tmp);
>>                       WREG32_SOC15_RLC(GC, 0, mmSH_MEM_BASES, 0);
>>               } else {
>>                       tmp =3D REG_SET_FIELD(0, SH_MEM_CONFIG, ALIGNMENT_=
MODE,
>>                                           SH_MEM_ALIGNMENT_MODE_UNALIGNE=
D);
>> +                    tmp =3D REG_SET_FIELD(tmp, SH_MEM_CONFIG, RETRY_DIS=
ABLE,
>> +                                        !!amdgpu_noretry);
>>                       WREG32_SOC15_RLC(GC, 0, mmSH_MEM_CONFIG, tmp);
>>                       tmp =3D REG_SET_FIELD(0, SH_MEM_BASES, PRIVATE_BAS=
E,
>>                               (adev->gmc.private_aperture_start >> 48));
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/=
amd/amdgpu/gfxhub_v1_0.c
>> index 9f0f189fc111..15986748f59f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
>> @@ -236,7 +236,8 @@ static void gfxhub_v1_0_setup_vmid_config(struct amd=
gpu_device *adev)
>>                                   block_size);
>>               /* Send no-retry XNACK on fault to suppress VM fault storm=
. */
>>               tmp =3D REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
>> -                                RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,=
 1);
>> +                                RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
>> +                                !amdgpu_noretry);
>>               WREG32_SOC15_OFFSET(GC, 0, mmVM_CONTEXT1_CNTL, i, tmp);
>>               WREG32_SOC15_OFFSET(GC, 0, mmVM_CONTEXT1_PAGE_TABLE_START_=
ADDR_LO32, i*2, 0);
>>               WREG32_SOC15_OFFSET(GC, 0, mmVM_CONTEXT1_PAGE_TABLE_START_=
ADDR_HI32, i*2, 0);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/=
amd/amdgpu/gfxhub_v2_0.c
>> index b7de60a15623..d605b4963f8a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
>> @@ -215,7 +215,8 @@ static void gfxhub_v2_0_setup_vmid_config(struct amd=
gpu_device *adev)
>>                               adev->vm_manager.block_size - 9);
>>               /* Send no-retry XNACK on fault to suppress VM fault storm=
. */
>>               tmp =3D REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
>> -                                RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,=
 0);
>> +                                RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
>> +                                !amdgpu_noretry);
>>               WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL, i, tmp);
>>               WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_STAR=
T_ADDR_LO32, i*2, 0);
>>               WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_STAR=
T_ADDR_HI32, i*2, 0);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/a=
md/amdgpu/mmhub_v1_0.c
>> index 05d1d448c8f5..dc5ce03034d3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
>> @@ -265,7 +265,8 @@ static void mmhub_v1_0_setup_vmid_config(struct amdg=
pu_device *adev)
>>                                   block_size);
>>               /* Send no-retry XNACK on fault to suppress VM fault storm=
. */
>>               tmp =3D REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
>> -                                RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,=
 1);
>> +                                RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
>> +                                !amdgpu_noretry);
>>               WREG32_SOC15_OFFSET(MMHUB, 0, mmVM_CONTEXT1_CNTL, i, tmp);
>>               WREG32_SOC15_OFFSET(MMHUB, 0, mmVM_CONTEXT1_PAGE_TABLE_STA=
RT_ADDR_LO32, i*2, 0);
>>               WREG32_SOC15_OFFSET(MMHUB, 0, mmVM_CONTEXT1_PAGE_TABLE_STA=
RT_ADDR_HI32, i*2, 0);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/a=
md/amdgpu/mmhub_v2_0.c
>> index 37a1a318ae63..0f9549f19ade 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
>> @@ -205,7 +205,8 @@ static void mmhub_v2_0_setup_vmid_config(struct amdg=
pu_device *adev)
>>                                   adev->vm_manager.block_size - 9);
>>               /* Send no-retry XNACK on fault to suppress VM fault storm=
. */
>>               tmp =3D REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
>> -                                RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,=
 0);
>> +                                RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
>> +                                !amdgpu_noretry);
>>               WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_CNTL, i, tmp=
);
>>               WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_PAGE_TABLE_S=
TART_ADDR_LO32, i*2, 0);
>>               WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_PAGE_TABLE_S=
TART_ADDR_HI32, i*2, 0);
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c b/=
drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
>> index e9fe39382371..95a82ac455f2 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
>> @@ -61,7 +61,7 @@ static int update_qpd_v9(struct device_queue_manager *=
dqm,
>>               qpd->sh_mem_config =3D
>>                               SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
>>                                       SH_MEM_CONFIG__ALIGNMENT_MODE__SHI=
FT;
>> -            if (noretry &&
>> +            if (amdgpu_noretry &&
>>                   !dqm->dev->device_info->needs_iommu_device)
>>                       qpd->sh_mem_config |=3D
>>                               1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd=
/amdkfd/kfd_priv.h
>> index d4bba0124d29..aa7bf20d20f8 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -157,7 +157,7 @@ extern int ignore_crat;
>>    /*
>>     * Set sh_mem_config.retry_disable on Vega10
>>     */
>> -extern int noretry;
>> +extern int amdgpu_noretry;
>>
>>    /*
>>     * Halt if HWS hang is detected

--_000_be9a4b8ccd48443f9f5509b41c91e263emailandroidcom_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<div>
<div dir=3D"auto">Patches to silent retry faults are already on the mailing=
 list.
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">But I need to get back from vacation to take a closer loo=
k at this once more.</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Christian.</div>
</div>
<div class=3D"x_gmail_extra"><br>
<div class=3D"x_gmail_quote">Am 04.07.2019 00:19 schrieb &quot;Yang, Philip=
&quot; &lt;Philip.Yang-5C7GfCeVMHo@public.gmane.org&gt;:<br type=3D"attribution">
</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:11pt;">
<div class=3D"PlainText">amdgpu_noretry default value is 0, this will gener=
ate VM fault storm
<br>
because the vm fault is not recovered. It may slow down the machine and <br=
>
need reboot after application VM fault. Maybe change default value to 1?<br=
>
<br>
Other than that, this is reviewed by Philip Yang &lt;Philip.Yang-5C7GfCeVMHo@public.gmane.org&gt=
;<br>
<br>
On 2019-07-02 3:05 p.m., Kuehling, Felix wrote:<br>
&gt; Ping.<br>
&gt; <br>
&gt; Christian, Philip, any opinion about this patch?<br>
&gt; <br>
&gt; On 2019-06-21 8:20 p.m., Kuehling, Felix wrote:<br>
&gt;&gt; Apply the same setting to SH_MEM_CONFIG and VM_CONTEXT1_CNTL. This=
<br>
&gt;&gt; makes the noretry param no longer KFD-specific. On GFX10 I'm not<b=
r>
&gt;&gt; changing SH_MEM_CONFIG in this commit because GFX10 has different<=
br>
&gt;&gt; retry behaviour in the SQ and I don't have a way to test it at the=
<br>
&gt;&gt; moment.<br>
&gt;&gt;<br>
&gt;&gt; Suggested-by: Christian K=F6nig &lt;Christian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;<b=
r>
&gt;&gt; CC: Philip Yang &lt;Philip.Yang-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;&gt; Signed-off-by: Felix Kuehling &lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 1=
 &#43;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 16 &#43;&#43;&#43;&#43;&#43=
;-----------<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 4 &#43;&#43=
;&#43;&#43;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 3 &#43;&#43;-<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 3 &#43;&#43;-<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 3 &#43;&#43;-<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 3 &#43;&#43;-<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; .../drm/amd/amdkfd/kfd_device_queue_manager_v9.c=
 |&nbsp; 2 &#43;-<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 &#43;-<br=
>
&gt;&gt;&nbsp;&nbsp;&nbsp; 9 files changed, 20 insertions(&#43;), 17 deleti=
ons(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu.h<br>
&gt;&gt; index 9b1efdf94bdf..05875279c09e 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt;&gt; @@ -164,6 &#43;164,7 @@ extern int amdgpu_async_gfx_ring;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; extern int amdgpu_mcbp;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; extern int amdgpu_discovery;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; extern int amdgpu_mes;<br>
&gt;&gt; &#43;extern int amdgpu_noretry;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp; #ifdef CONFIG_DRM_AMDGPU_SI<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; extern int amdgpu_si_support;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt;&gt; index 7cf6ab07b113..0d578d95be93 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt;&gt; @@ -140,6 &#43;140,7 @@ int amdgpu_async_gfx_ring =3D 1;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; int amdgpu_mcbp =3D 0;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; int amdgpu_discovery =3D 0;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; int amdgpu_mes =3D 0;<br>
&gt;&gt; &#43;int amdgpu_noretry;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp; struct amdgpu_mgpu_info mgpu_info =3D {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mutex =3D __MUTEX_INITIALIZER=
(mgpu_info.mutex),<br>
&gt;&gt; @@ -591,6 &#43;592,10 @@ MODULE_PARM_DESC(mes,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Enable Micro Engine Sche=
duler (0 =3D disabled (default), 1 =3D enabled)&quot;);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; module_param_named(mes, amdgpu_mes, int, 0444);<=
br>
&gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&gt;&gt; &#43;MODULE_PARM_DESC(noretry,<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; &quot;Disable retry faults (0 =3D retry en=
abled (default), 1 =3D retry disabled)&quot;);<br>
&gt;&gt; &#43;module_param_named(noretry, amdgpu_noretry, int, 0644);<br>
&gt;&gt; &#43;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; #ifdef CONFIG_HSA_AMD<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; /**<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; * DOC: sched_policy (int)<br>
&gt;&gt; @@ -666,17 &#43;671,6 @@ module_param(ignore_crat, int, 0444);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; MODULE_PARM_DESC(ignore_crat,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Ignore CRAT table during=
 KFD initialization (0 =3D use CRAT (default), 1 =3D ignore CRAT)&quot;);<b=
r>
&gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&gt;&gt; -/**<br>
&gt;&gt; - * DOC: noretry (int)<br>
&gt;&gt; - * This parameter sets sh_mem_config.retry_disable. Default value=
, 0, enables retry.<br>
&gt;&gt; - * Setting 1 disables retry.<br>
&gt;&gt; - * Retry is needed for recoverable page faults.<br>
&gt;&gt; - */<br>
&gt;&gt; -int noretry;<br>
&gt;&gt; -module_param(noretry, int, 0644);<br>
&gt;&gt; -MODULE_PARM_DESC(noretry,<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; &quot;Set sh_mem_config.retry_disable on Vega1=
0 (0 =3D retry enabled (default), 1 =3D retry disabled)&quot;);<br>
&gt;&gt; -<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; /**<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; * DOC: halt_if_hws_hang (int)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; * Halt if HWS hang is detected. Default va=
lue, 0, disables the halt on hang.<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/d=
rm/amd/amdgpu/gfx_v9_0.c<br>
&gt;&gt; index e0f3014e76ea..c4e715170bfe 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&gt;&gt; @@ -1938,11 &#43;1938,15 @@ static void gfx_v9_0_constants_init(st=
ruct amdgpu_device *adev)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (i =3D=3D 0) {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D R=
EG_SET_FIELD(0, SH_MEM_CONFIG, ALIGNMENT_MODE,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SH_MEM_ALIGNMENT_MODE_UNALIGNED);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD=
(tmp, SH_MEM_CONFIG, RETRY_DISABLE,<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; !!amdgpu_noretry);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SO=
C15_RLC(GC, 0, mmSH_MEM_CONFIG, tmp);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SO=
C15_RLC(GC, 0, mmSH_MEM_BASES, 0);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; } else {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D R=
EG_SET_FIELD(0, SH_MEM_CONFIG, ALIGNMENT_MODE,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SH_MEM_ALIGNMENT_MODE_UNALIGNED);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD=
(tmp, SH_MEM_CONFIG, RETRY_DISABLE,<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; !!amdgpu_noretry);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SO=
C15_RLC(GC, 0, mmSH_MEM_CONFIG, tmp);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D R=
EG_SET_FIELD(0, SH_MEM_BASES, PRIVATE_BASE,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;gmc.private_aperture_start=
 &gt;&gt; 48));<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gp=
u/drm/amd/amdgpu/gfxhub_v1_0.c<br>
&gt;&gt; index 9f0f189fc111..15986748f59f 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c<br>
&gt;&gt; @@ -236,7 &#43;236,8 @@ static void gfxhub_v1_0_setup_vmid_config(=
struct amdgpu_device *adev)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; block_size);=
<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; /* Send no-retry XNACK on fault to suppress VM fault stor=
m. */<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RETRY_PERMISSION_OR_INVALID_=
PAGE_FAULT, 1);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RETRY_PERMISSION_OR_INVA=
LID_PAGE_FAULT,<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !amdgpu_noretry);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; WREG32_SOC15_OFFSET(GC, 0, mmVM_CONTEXT1_CNTL, i, tmp);<b=
r>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; WREG32_SOC15_OFFSET(GC, 0, mmVM_CONTEXT1_PAGE_TABLE_START=
_ADDR_LO32, i*2, 0);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; WREG32_SOC15_OFFSET(GC, 0, mmVM_CONTEXT1_PAGE_TABLE_START=
_ADDR_HI32, i*2, 0);<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gp=
u/drm/amd/amdgpu/gfxhub_v2_0.c<br>
&gt;&gt; index b7de60a15623..d605b4963f8a 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c<br>
&gt;&gt; @@ -215,7 &#43;215,8 @@ static void gfxhub_v2_0_setup_vmid_config(=
struct amdgpu_device *adev)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;vm_manager.block_size - 9);=
<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; /* Send no-retry XNACK on fault to suppress VM fault stor=
m. */<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RETRY_PERMISSION_OR_INVALID_=
PAGE_FAULT, 0);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RETRY_PERMISSION_OR_INVA=
LID_PAGE_FAULT,<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !amdgpu_noretry);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL, i, tmp);=
<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_STA=
RT_ADDR_LO32, i*2, 0);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_STA=
RT_ADDR_HI32, i*2, 0);<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu=
/drm/amd/amdgpu/mmhub_v1_0.c<br>
&gt;&gt; index 05d1d448c8f5..dc5ce03034d3 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c<br>
&gt;&gt; @@ -265,7 &#43;265,8 @@ static void mmhub_v1_0_setup_vmid_config(s=
truct amdgpu_device *adev)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; block_size);=
<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; /* Send no-retry XNACK on fault to suppress VM fault stor=
m. */<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RETRY_PERMISSION_OR_INVALID_=
PAGE_FAULT, 1);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RETRY_PERMISSION_OR_INVA=
LID_PAGE_FAULT,<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !amdgpu_noretry);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; WREG32_SOC15_OFFSET(MMHUB, 0, mmVM_CONTEXT1_CNTL, i, tmp)=
;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; WREG32_SOC15_OFFSET(MMHUB, 0, mmVM_CONTEXT1_PAGE_TABLE_ST=
ART_ADDR_LO32, i*2, 0);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; WREG32_SOC15_OFFSET(MMHUB, 0, mmVM_CONTEXT1_PAGE_TABLE_ST=
ART_ADDR_HI32, i*2, 0);<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu=
/drm/amd/amdgpu/mmhub_v2_0.c<br>
&gt;&gt; index 37a1a318ae63..0f9549f19ade 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c<br>
&gt;&gt; @@ -205,7 &#43;205,8 @@ static void mmhub_v2_0_setup_vmid_config(s=
truct amdgpu_device *adev)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;vm_=
manager.block_size - 9);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; /* Send no-retry XNACK on fault to suppress VM fault stor=
m. */<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RETRY_PERMISSION_OR_INVALID_=
PAGE_FAULT, 0);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RETRY_PERMISSION_OR_INVA=
LID_PAGE_FAULT,<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !amdgpu_noretry);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_CNTL, i, tm=
p);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_PAGE_TABLE_=
START_ADDR_LO32, i*2, 0);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_PAGE_TABLE_=
START_ADDR_HI32, i*2, 0);<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v=
9.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c<br>
&gt;&gt; index e9fe39382371..95a82ac455f2 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_mana=
ger_v9.c<br>
&gt;&gt; @@ -61,7 &#43;61,7 @@ static int update_qpd_v9(struct device_queue=
_manager *dqm,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; qpd-&gt;sh_mem_config =3D<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SH_MEM_ALIGNMENT_MODE_UNALIGNED &lt;=
&lt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; if (noretry &amp;&amp;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; if (amdgpu_noretry &amp;&amp;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !dqm-&gt;dev-&gt;device_info-&gt;=
needs_iommu_device)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qpd-&gt;s=
h_mem_config |=3D<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 &lt;&lt; SH_MEM_CONFIG__RETRY_DISA=
BLE__SHIFT;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/d=
rm/amd/amdkfd/kfd_priv.h<br>
&gt;&gt; index d4bba0124d29..aa7bf20d20f8 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
&gt;&gt; @@ -157,7 &#43;157,7 @@ extern int ignore_crat;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; * Set sh_mem_config.retry_disable on Vega1=
0<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&gt; -extern int noretry;<br>
&gt;&gt; &#43;extern int amdgpu_noretry;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; * Halt if HWS hang is detected<br>
</div>
</span></font>
</body>
</html>

--_000_be9a4b8ccd48443f9f5509b41c91e263emailandroidcom_--

--===============1522252846==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1522252846==--
