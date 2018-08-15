From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2] drm/amdgpu/sriov: For sriov runtime, use kiq to do
 invalidate tlb
Date: Wed, 15 Aug 2018 10:21:41 +0000
Message-ID: <BYAPR12MB27750F6900E2660C071FC0ADFB3F0@BYAPR12MB2775.namprd12.prod.outlook.com>
References: <1534244211-4717-1-git-send-email-Emily.Deng@amd.com>
 <a865d2c4-2373-1101-2dd1-ca3a8f0792eb@gmail.com>
 <CY4PR12MB11250F5E45EBEBDD519056BB8F3F0@CY4PR12MB1125.namprd12.prod.outlook.com>,
 <2e0a1f3e-4e8a-b9ae-bfe6-46b4b74144ce@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0308985830=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <2e0a1f3e-4e8a-b9ae-bfe6-46b4b74144ce-5C7GfCeVMHo@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Deng, Emily" <Emily.Deng-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0308985830==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB27750F6900E2660C071FC0ADFB3F0BYAPR12MB2775namp_"

--_000_BYAPR12MB27750F6900E2660C071FC0ADFB3F0BYAPR12MB2775namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Remove the sriov check, The patch can work on both vega10 and Raven under b=
are metal with tip firmware.


Best Regards

Rex




________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Christia=
n K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, August 15, 2018 3:07 PM
To: Deng, Emily; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH v2] drm/amdgpu/sriov: For sriov runtime, use kiq to do =
invalidate tlb

> As need to let somebody to test all your bare metal test cases, such as v=
ega10, and other asics, as I don't have those environments, and only could =
test sriov.
That is not much of a problem. We have plenty of people on the mailing
list (including me) who can test this on both Vega10 and Raven.

Just remove the SRIOV check and send the patch out with a request for
testing it on bare metal.

Christian.

Am 15.08.2018 um 04:28 schrieb Deng, Emily:
> Thanks for your review, will send a patch to review again as your suggest=
ion. I think it will be better to use the amdgpu_sriov_vf(adev).
> As need to let somebody to test all your bare metal test cases, such as v=
ega10, and other asics, as I don't have those environments, and only could =
test sriov.
> If passed those bare metal test cases and fixed the bugs if occurs, then =
could remove the amdgpu_sriov_vf(adev). Do you think so?
>
> Best wishes
> Emily Deng
>> -----Original Message-----
>> From: Christian K=F6nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> Sent: Tuesday, August 14, 2018 8:46 PM
>> To: Deng, Emily <Emily.Deng-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> Subject: Re: [PATCH v2] drm/amdgpu/sriov: For sriov runtime, use kiq to =
do
>> invalidate tlb
>>
>> Am 14.08.2018 um 12:56 schrieb Emily Deng:
>>> To avoid the tlb flush not interrupted by world switch, use kiq and
>>> one command to do tlb invalidate.
>>>
>>> v2:
>>> Add firmware version checking.
>>>
>>> SWDEV-161497
>>>
>>> Signed-off-by: Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 63
>> ++++++++++++++++++++++++++++++++
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  2 +
>>>    drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    |  7 ++++
>>>    3 files changed, 72 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>>> index 21adb1b6..436030c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>>> @@ -233,6 +233,69 @@ void amdgpu_virt_kiq_wreg(struct amdgpu_device
>> *adev, uint32_t reg, uint32_t v)
>>>      pr_err("failed to write reg:%x\n", reg);
>>>    }
>>>
>>> +signed long  amdgpu_virt_kiq_invalidate_tlb(struct amdgpu_device *adev=
,
>> struct amdgpu_vmhub *hub,
>>> +           unsigned eng, u32 req, uint32_t vmid)
>> Drop that function here. It is Vega specific and doesn't belong into com=
mon
>> code.
>>
>>> +{
>>> +   signed long r, cnt =3D 0;
>>> +   unsigned long flags;
>>> +   uint32_t seq;
>>> +   struct amdgpu_kiq *kiq =3D &adev->gfx.kiq;
>>> +   struct amdgpu_ring *ring =3D &kiq->ring;
>>> +   struct drm_amdgpu_info_firmware fw_info;
>>> +
>>> +   if (ring->me =3D=3D 1) {
>>> +           fw_info.ver =3D adev->gfx.mec_fw_version;
>>> +           fw_info.feature =3D adev->gfx.mec_feature_version;
>>> +   } else {
>>> +           fw_info.ver =3D adev->gfx.mec2_fw_version;
>>> +           fw_info.feature =3D adev->gfx.mec2_feature_version;
>>> +   }
>>> +
>>> +   if (fw_info.ver <  0x00000190 || fw_info.feature < 42)
>>> +           return -EPERM;
>> Please move that check into gfx_v9_0_ring_emit_reg_write_reg_wait().
>>
>>> +
>>> +   BUG_ON(!ring->funcs->emit_reg_write_reg_wait);
>> That check is superfluous.
>>
>>> +
>>> +   spin_lock_irqsave(&kiq->ring_lock, flags);
>>> +   amdgpu_ring_alloc(ring, 32);
>>> +   amdgpu_ring_emit_reg_write_reg_wait(ring, hub->vm_inv_eng0_req +
>> eng,
>>> +                                       hub->vm_inv_eng0_ack + eng,
>>> +                                       req, 1 << vmid);
>>> +   amdgpu_fence_emit_polling(ring, &seq);
>>> +   amdgpu_ring_commit(ring);
>>> +   spin_unlock_irqrestore(&kiq->ring_lock, flags);
>>> +
>>> +   r =3D amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
>>> +
>>> +   /* don't wait anymore for gpu reset case because this way may
>>> +    * block gpu_recover() routine forever, e.g. this virt_kiq_rreg
>>> +    * is triggered in TTM and ttm_bo_lock_delayed_workqueue() will
>>> +    * never return if we keep waiting in virt_kiq_rreg, which cause
>>> +    * gpu_recover() hang there.
>>> +    *
>>> +    * also don't wait anymore for IRQ context
>>> +    * */
>>> +   if (r < 1 && (adev->in_gpu_reset || in_interrupt()))
>>> +           goto failed_kiq;
>>> +
>>> +   if (in_interrupt())
>>> +           might_sleep();
>>> +
>>> +   while (r < 1 && cnt++ < MAX_KIQ_REG_TRY) {
>>> +           msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
>>> +           r =3D amdgpu_fence_wait_polling(ring, seq,
>> MAX_KIQ_REG_WAIT);
>>> +   }
>>> +
>>> +   if (cnt > MAX_KIQ_REG_TRY)
>>> +           goto failed_kiq;
>>> +
>>> +   return 0;
>>> +
>>> +failed_kiq:
>>> +   pr_err("failed to invalidate tlb with kiq\n");
>>> +   return r;
>>> +}
>>> +
>>>    /**
>>>     * amdgpu_virt_request_full_gpu() - request full gpu access
>>>     * @amdgpu:      amdgpu device.
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>>> index 880ac11..8908ff9 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>>> @@ -288,6 +288,8 @@ void amdgpu_free_static_csa(struct amdgpu_device
>> *adev);
>>>    void amdgpu_virt_init_setting(struct amdgpu_device *adev);
>>>    uint32_t amdgpu_virt_kiq_rreg(struct amdgpu_device *adev, uint32_t r=
eg);
>>>    void amdgpu_virt_kiq_wreg(struct amdgpu_device *adev, uint32_t reg,
>>> uint32_t v);
>>> +signed long  amdgpu_virt_kiq_invalidate_tlb(struct amdgpu_device *adev=
,
>> struct amdgpu_vmhub *hub,
>>> +           unsigned eng, u32 req, uint32_t vmid);
>>>    int amdgpu_virt_request_full_gpu(struct amdgpu_device *adev, bool in=
it);
>>>    int amdgpu_virt_release_full_gpu(struct amdgpu_device *adev, bool in=
it);
>>>    int amdgpu_virt_reset_gpu(struct amdgpu_device *adev); diff --git
>>> a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> index 6999042..812f71e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> @@ -331,6 +331,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct
>> amdgpu_device *adev,
>>>      /* Use register 17 for GART */
>>>      const unsigned eng =3D 17;
>>>      unsigned i, j;
>>> +   int r;
>>>
>>>      spin_lock(&adev->gmc.invalidate_lock);
>>>
>>> @@ -338,6 +339,12 @@ static void gmc_v9_0_flush_gpu_tlb(struct
>> amdgpu_device *adev,
>>>              struct amdgpu_vmhub *hub =3D &adev->vmhub[i];
>>>              u32 tmp =3D gmc_v9_0_get_invalidate_req(vmid);
>>>
>>> +           if (amdgpu_sriov_vf(adev) && amdgpu_sriov_runtime(adev)) {
>>> +                   r =3D amdgpu_virt_kiq_invalidate_tlb(adev, hub, eng=
, tmp,
>> vmid);
>>> +                   if (!r)
>>> +                           continue;
>>> +           }
>>> +
>> Drop that SRIOV check here. We don't want specialized code path for SRIO=
V.
>>
>> Christian.
>>
>>>              WREG32_NO_KIQ(hub->vm_inv_eng0_req + eng, tmp);
>>>
>>>              /* Busy wait for ACK.*/

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of Conduct.



--_000_BYAPR12MB27750F6900E2660C071FC0ADFB3F0BYAPR12MB2775namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Remove the sriov check, The patch=
 can work on both vega10 and Raven under bare metal with tip firmware.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Best Regards</p>
<p style=3D"margin-top:0;margin-bottom:0">Rex<br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" color=
=3D"#000000" face=3D"Calibri, sans-serif"><b>From:</b> amd-gfx &lt;amd-gfx-=
bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Christian K=F6nig &lt;christ=
ian.koenig-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Wednesday, August 15, 2018 3:07 PM<br>
<b>To:</b> Deng, Emily; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH v2] drm/amdgpu/sriov: For sriov runtime, use kiq=
 to do invalidate tlb</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">&gt; As need to let somebody to test all your bare=
 metal test cases, such as vega10, and other asics, as I don't have those e=
nvironments, and only could test sriov.<br>
That is not much of a problem. We have plenty of people on the mailing <br>
list (including me) who can test this on both Vega10 and Raven.<br>
<br>
Just remove the SRIOV check and send the patch out with a request for <br>
testing it on bare metal.<br>
<br>
Christian.<br>
<br>
Am 15.08.2018 um 04:28 schrieb Deng, Emily:<br>
&gt; Thanks for your review, will send a patch to review again as your sugg=
estion. I think it will be better to use the amdgpu_sriov_vf(adev).<br>
&gt; As need to let somebody to test all your bare metal test cases, such a=
s vega10, and other asics, as I don't have those environments, and only cou=
ld test sriov.<br>
&gt; If passed those bare metal test cases and fixed the bugs if occurs, th=
en could remove the amdgpu_sriov_vf(adev). Do you think so?<br>
&gt;<br>
&gt; Best wishes<br>
&gt; Emily Deng<br>
&gt;&gt; -----Original Message-----<br>
&gt;&gt; From: Christian K=F6nig &lt;ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<b=
r>
&gt;&gt; Sent: Tuesday, August 14, 2018 8:46 PM<br>
&gt;&gt; To: Deng, Emily &lt;Emily.Deng-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.org<br>
&gt;&gt; Subject: Re: [PATCH v2] drm/amdgpu/sriov: For sriov runtime, use k=
iq to do<br>
&gt;&gt; invalidate tlb<br>
&gt;&gt;<br>
&gt;&gt; Am 14.08.2018 um 12:56 schrieb Emily Deng:<br>
&gt;&gt;&gt; To avoid the tlb flush not interrupted by world switch, use ki=
q and<br>
&gt;&gt;&gt; one command to do tlb invalidate.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; v2:<br>
&gt;&gt;&gt; Add firmware version checking.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; SWDEV-161497<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Signed-off-by: Emily Deng &lt;Emily.Deng-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 6=
3<br>
&gt;&gt; &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |&n=
bsp; 2 &#43;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c&nbsp;&=
nbsp;&nbsp; |&nbsp; 7 &#43;&#43;&#43;&#43;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; 3 files changed, 72 insertions(&#43;)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
&gt;&gt;&gt; index 21adb1b6..436030c 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
&gt;&gt;&gt; @@ -233,6 &#43;233,69 @@ void amdgpu_virt_kiq_wreg(struct amdg=
pu_device<br>
&gt;&gt; *adev, uint32_t reg, uint32_t v)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;failed to write reg=
:%x\n&quot;, reg);<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; &#43;signed long&nbsp; amdgpu_virt_kiq_invalidate_tlb(struct a=
mdgpu_device *adev,<br>
&gt;&gt; struct amdgpu_vmhub *hub,<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; unsigned eng, u32 req, uint32_t vmid)<br>
&gt;&gt; Drop that function here. It is Vega specific and doesn't belong in=
to common<br>
&gt;&gt; code.<br>
&gt;&gt;<br>
&gt;&gt;&gt; &#43;{<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp; signed long r, cnt =3D 0;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp; unsigned long flags;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp; uint32_t seq;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp; struct amdgpu_kiq *kiq =3D &amp;adev-&gt;gfx=
.kiq;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp; struct amdgpu_ring *ring =3D &amp;kiq-&gt;ri=
ng;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp; struct drm_amdgpu_info_firmware fw_info;<br>
&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp; if (ring-&gt;me =3D=3D 1) {<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; fw_info.ver =3D adev-&gt;gfx.mec_fw_version;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; fw_info.feature =3D adev-&gt;gfx.mec_feature_version;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp; } else {<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; fw_info.ver =3D adev-&gt;gfx.mec2_fw_version;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; fw_info.feature =3D adev-&gt;gfx.mec2_feature_version;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp; }<br>
&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp; if (fw_info.ver &lt;&nbsp; 0x00000190 || fw_=
info.feature &lt; 42)<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return -EPERM;<br>
&gt;&gt; Please move that check into gfx_v9_0_ring_emit_reg_write_reg_wait(=
).<br>
&gt;&gt;<br>
&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp; BUG_ON(!ring-&gt;funcs-&gt;emit_reg_write_re=
g_wait);<br>
&gt;&gt; That check is superfluous.<br>
&gt;&gt;<br>
&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp; spin_lock_irqsave(&amp;kiq-&gt;ring_lock, fl=
ags);<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp; amdgpu_ring_alloc(ring, 32);<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp; amdgpu_ring_emit_reg_write_reg_wait(ring, hu=
b-&gt;vm_inv_eng0_req &#43;<br>
&gt;&gt; eng,<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; hub-&gt;vm_inv_eng0_ack &#43; eng,<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; req, 1 &lt;&lt; vmid);<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp; amdgpu_fence_emit_polling(ring, &amp;seq);<b=
r>
&gt;&gt;&gt; &#43;&nbsp;&nbsp; amdgpu_ring_commit(ring);<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp; spin_unlock_irqrestore(&amp;kiq-&gt;ring_loc=
k, flags);<br>
&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp; r =3D amdgpu_fence_wait_polling(ring, seq, M=
AX_KIQ_REG_WAIT);<br>
&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp; /* don't wait anymore for gpu reset case bec=
ause this way may<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; * block gpu_recover() routine forever,=
 e.g. this virt_kiq_rreg<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; * is triggered in TTM and ttm_bo_lock_=
delayed_workqueue() will<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; * never return if we keep waiting in v=
irt_kiq_rreg, which cause<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; * gpu_recover() hang there.<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; *<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; * also don't wait anymore for IRQ cont=
ext<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; * */<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp; if (r &lt; 1 &amp;&amp; (adev-&gt;in_gpu_res=
et || in_interrupt()))<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; goto failed_kiq;<br>
&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp; if (in_interrupt())<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; might_sleep();<br>
&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp; while (r &lt; 1 &amp;&amp; cnt&#43;&#43; &lt=
; MAX_KIQ_REG_TRY) {<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; r =3D amdgpu_fence_wait_polling(ring, seq,<br>
&gt;&gt; MAX_KIQ_REG_WAIT);<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp; }<br>
&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp; if (cnt &gt; MAX_KIQ_REG_TRY)<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; goto failed_kiq;<br>
&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt; &#43;failed_kiq:<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp; pr_err(&quot;failed to invalidate tlb with k=
iq\n&quot;);<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp; return r;<br>
&gt;&gt;&gt; &#43;}<br>
&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; /**<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; * amdgpu_virt_request_full_gpu() - req=
uest full gpu access<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; * @amdgpu:&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; amdgpu device.<br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h<br>
&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h<br>
&gt;&gt;&gt; index 880ac11..8908ff9 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h<br>
&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h<br>
&gt;&gt;&gt; @@ -288,6 &#43;288,8 @@ void amdgpu_free_static_csa(struct amd=
gpu_device<br>
&gt;&gt; *adev);<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; void amdgpu_virt_init_setting(struct amdgpu_=
device *adev);<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; uint32_t amdgpu_virt_kiq_rreg(struct amdgpu_=
device *adev, uint32_t reg);<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; void amdgpu_virt_kiq_wreg(struct amdgpu_devi=
ce *adev, uint32_t reg,<br>
&gt;&gt;&gt; uint32_t v);<br>
&gt;&gt;&gt; &#43;signed long&nbsp; amdgpu_virt_kiq_invalidate_tlb(struct a=
mdgpu_device *adev,<br>
&gt;&gt; struct amdgpu_vmhub *hub,<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; unsigned eng, u32 req, uint32_t vmid);<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; int amdgpu_virt_request_full_gpu(struct amdg=
pu_device *adev, bool init);<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; int amdgpu_virt_release_full_gpu(struct amdg=
pu_device *adev, bool init);<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; int amdgpu_virt_reset_gpu(struct amdgpu_devi=
ce *adev); diff --git<br>
&gt;&gt;&gt; a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
&gt;&gt;&gt; index 6999042..812f71e 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
&gt;&gt;&gt; @@ -331,6 &#43;331,7 @@ static void gmc_v9_0_flush_gpu_tlb(str=
uct<br>
&gt;&gt; amdgpu_device *adev,<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Use register 17 for GART */<b=
r>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const unsigned eng =3D 17;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned i, j;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp; int r;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;adev-&gt;gmc.inva=
lidate_lock);<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; @@ -338,6 &#43;339,12 @@ static void gmc_v9_0_flush_gpu_tlb(st=
ruct<br>
&gt;&gt; amdgpu_device *adev,<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct amdgpu_vmhub *hub =3D &amp;adev-&gt;vmhub[i];<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; u32 tmp =3D gmc_v9_0_get_invalidate_req(vmid);<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (amdgpu_sriov_vf(adev) &amp;&amp; amdgpu_sriov_runtime(adev)) {<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_virt_kiq_i=
nvalidate_tlb(adev, hub, eng, tmp,<br>
&gt;&gt; vmid);<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r)<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt;&gt;&gt; &#43;<br>
&gt;&gt; Drop that SRIOV check here. We don't want specialized code path fo=
r SRIOV.<br>
&gt;&gt;<br>
&gt;&gt; Christian.<br>
&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; WREG32_NO_KIQ(hub-&gt;vm_inv_eng0_req &#43; eng, tmp);<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; /* Busy wait for ACK.*/<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk575449" class=3D"OWAAutoLink" previewremoved=3D"true">https://lists.free=
desktop.org/mailman/listinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_15343271181480.00033885929112609237" style=3D"margin=
-bottom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_15343271181480.9816543027771137" style=3D"width: 9=
0%; background-color: rgb(255, 255, 255); position: relative; overflow: aut=
o; padding-top: 20px; padding-bottom: 20px; margin-top: 20px; border-top: 1=
px dotted rgb(200, 200, 200); border-bottom: 1px dotted rgb(200, 200, 200);=
" role=3D"presentation" cellspacing=3D"0">
<tbody>
<tr style=3D"border-spacing: 0px;" valign=3D"top">
<td id=3D"TextCell_15343271181480.9952248566073559" style=3D"vertical-align=
: top; position: relative; padding: 0px; display: table-cell;" colspan=3D"2=
">
<div id=3D"LPRemovePreviewContainer_15343271181480.875376248828901"></div>
<div id=3D"LPTitle_15343271181480.18428245518285646" style=3D"top: 0px; col=
or: rgb(0, 120, 215); font-weight: 400; font-size: 21px; font-family: &quot=
;wf_segoe-ui_light&quot;, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&=
quot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-seri=
f; line-height: 21px;">
<a id=3D"LPUrlAnchor_15343271181480.9572732071652488" style=3D"text-decorat=
ion: none;" href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx"=
 target=3D"_blank">amd-gfx Info Page - freedesktop.org</a></div>
<div id=3D"LPMetadata_15343271181480.5649528060753035" style=3D"margin: 10p=
x 0px 16px; color: rgb(102, 102, 102); font-weight: 400; font-family: &quot=
;wf_segoe-ui_normal&quot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Taho=
ma, Arial, sans-serif; font-size: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_15343271181480.30659632369144363" style=3D"display=
: block; color: rgb(102, 102, 102); font-weight: 400; font-family: &quot;wf=
_segoe-ui_normal&quot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma,=
 Arial, sans-serif; font-size: 14px; line-height: 20px; max-height: 100px; =
overflow: hidden;">
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of Conduct.</d=
iv>
</td>
</tr>
</tbody>
</table>
</div>
<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_BYAPR12MB27750F6900E2660C071FC0ADFB3F0BYAPR12MB2775namp_--

--===============0308985830==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0308985830==--
