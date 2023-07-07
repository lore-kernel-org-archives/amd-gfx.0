Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 073BAEB64D9
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jul 2023 07:28:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B9EC10E51E;
	Fri,  7 Jul 2023 07:28:07 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EB1910E51E
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jul 2023 07:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1688714881; x=1689319681; i=friedrich.vock@gmx.de;
 bh=DjvL42x+xMj0/VOSL2iioL/F0qclBAM3AtYW+st7kqM=;
 h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
 b=bT9AebQH2dSaROxmx/a2arQvunrZ4Kixab7hjm6Gt2v1MNXL4f2u3eYRcg4gx2k7ZMKl+qi
 9/jYjBHgMq1rlDVfDc8LP0iiKB8kAyA1BMXx0vxWgp/HI+gfXIrXuc/MyHEdGY85QltOsLdFa
 kgalRU8rDC0HP0c8Hy1Hti+W3uKORkayf3Pnez1xY3/R7bnxBy6EBzUMydHWLnplwrHl3RQ+/
 kl1mj4jWb6L0qf6cKk33vzQiNzFuyuboiGYCq2FDFF4WRw+hXoWouB92VuZlwAQJJKEbEhnJG
 XtnCSdkXetEzrbVSdOrxoBhg7mX69NqpkksqYmY1lbwyvU3HJ5iw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.177.34] ([213.152.119.29]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0oBx-1q30ke0hTZ-00woXe; Fri, 07
 Jul 2023 09:28:01 +0200
Message-ID: <ef348f8d-27a6-06b2-210c-da1d8c8f3cca@gmx.de>
Date: Fri, 7 Jul 2023 09:28:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230707062908.9470-2-friedrich.vock@gmx.de>
 <a625bd04-1ae6-536d-d255-c3efa6351312@amd.com>
From: Friedrich Vock <friedrich.vock@gmx.de>
Subject: Re: [PATCH] drm/amdgpu: Always emit GDS switch when GDS/GWS/OA is used
In-Reply-To: <a625bd04-1ae6-536d-d255-c3efa6351312@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZpIaYo3D06zfQtjERQI3+FOzZv08ZS+GDFN34cYXjwnuQ256zSm
 +XsvheIy9VaGQ3HXDpFOtw6SufpszcGXzywufc1WI9FwR3gwVBFmr2dP9FPRC0mZAeMIdVd
 gw60Q0iLqgkPzrJRePVQLVffTlnzq1LtZy+SaQgF/PilfW7lD7Y6IiUSIaUzSAO7JRL4HTO
 SpAEVGNujfPw/ckrjMyVA==
UI-OutboundReport: notjunk:1;M01:P0:LX4UKWRJPRI=;cFrs1Yqf7vex5IFS8/PKAigHCIV
 TFXw79kxFw6eOtuJTKrnDyPJotpTXhTRqk5tORdxkJo0mSMFDRUmEp+ORxIO12zHJRWLjtXs6
 s5K7UA4vBpG8Q63SODXiIcyn27VUf+XKJVdQpqb5NUm9IQ2rhj1IK9bUU1hMlByw2miWpYd+8
 ph/wfoWlQDc3wst/TkJl4b4dAleEyuqw09Xpqj7x6ZGXzxB2h/Ch7wOkUW7pRX3w7sfTXOY89
 rmNIF4xjb40vaNn25XasTpKIj4kxaqkWF53oWvjihiq75uxHBxpDeuUaTl6znGAtT9TVARWd7
 g+PzYPmMRY0CcoTAf6kfv+PwHR1zO1ZVrWk7gXKxBOVjHM72ijdw7GBY2BaDtgIGZIcYJ6z+C
 LILzbqNZ0KG7kQX/ZepGidyqWxMCpKPbMqXSEoU1BRnC7Fjvz6FSN83dJAskvtJVojXJyjMe8
 Z5fxIoio+1Yj3geIPPVsAAc3Q0VLAVw7PuicjqPquutwQIN3hDKGfM8S+wLOmjh/ta9crq1bV
 zuceEFtqnH7yensCbR+NTS6R7eMsG3nZSujVH45tZVB1iWn8bKYUSkyhAm08pTFEk7jCui0+1
 9r9vJXswIYF1DDDSu6wkjXcBEZD2dya/6GHJLFpU649tIgnuAx8btITRUZFGYbUjM72ykQKKO
 KfimPt1Yn+ORaOIzfVcIF/UXEmhbe8iVH+Q8bAsscLxf99qgYOYBrATSFfufcgbIRSIEst/zX
 m0i+oRrC52NjoA2XGpO4iLn+acADv6bGuN0A0XQfbNGxxZTb9LsMShtrrZ9VvIbusausOr0JS
 TGW/MoEs9i8HEsb3JLBY9qwuH76dSz1W9ZHAQ5XIlJt5srdsnT9j5yrCdTMMuWC2Z1z0kgcVB
 /wEHlrUGJY1yGg16vNTxlO4K6F48MIEe6zB/7NIxxxvpQrLmF47CQjNXxgyGb9YlxQvd8+lgh
 9laG5jFjm21FwCGMcfuZIQ3iJRowZVMCb+VVBhj+ZlmakAinZ/had0F4T/MW2pWWqF8Pzw==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: stable@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Christian,

On 07.07.23 08:56, Christian K=C3=B6nig wrote:
>
>
> Am 07.07.23 um 08:28 schrieb Friedrich Vock:
>> During gfxoff, the per-VMID GDS registers are reset and not restored
>> afterwards.
>
> Hui? Since when? Those registers should be part of the saved ones.
>
> Have you found that by observation?

yes. I tested this on my RX 6700 XT and the Steam Deck (Vangogh). In the
bug report I linked, a test program using GWS I developed hangs because
of this.

The hang occurs as soon as the kernel re-uses a VMID on which GWS was
already used once. In the hung state, inspecting the per-VMID GWS
registers shows that the values have been reset to 0.
The hang does not occur when gfxoff is disabled.

Even without causing hangs, you can confirm the behaviour by doing the
following:
1. Disable gfxoff.
2. Set some GWS registers.
3. Enable gfxoff and wait a bit.
4. Disable gfxoff and read the registers again. The GWS registers have
been reset.

I performed this test for the GDS_BASE/SIZE registers and it seems these
aren't affected, so it's only GWS that is buggy here.
I should probably make a v2 that combines the behaviour before this
patch for GDS and OA, and the patched behaviour for GWS.

I'm not aware of userspace using GWS (yet, I had some ideas for using it
in RADV which is what I've been writing these tests for),
so perhaps the Cc to stable can also be omitted.

Thanks,
Friedrich

>
> Thanks,
> Christian.
>
>
>> =C2=A0 The kernel needs to emit a GDS switch to manually update the
>> GWS registers in this case. Since gfxoff can happen between any two
>> submissions and the kernel has no way of knowing, emit the GDS switch
>> before every submission.
>>
>> Fixes: 56b0989e29 ("drm/amdgpu: fix GDS/GWS/OA switch handling")
>> Cc: stable@vger.kernel.org
>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2530
>> Signed-off-by: Friedrich Vock <friedrich.vock@gmx.de>
>> ---
>> =C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 22 +++++++------------=
---
>> =C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h |=C2=A0 1 -
>> =C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c=C2=A0 | 10 ++++++++--
>> =C2=A0 3 files changed, 15 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>> index ff1ea99292fb..de73797e9279 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>> @@ -165,24 +165,17 @@ bool amdgpu_vmid_had_gpu_reset(struct
>> amdgpu_device *adev,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic_read(&ade=
v->gpu_reset_counter);
>> =C2=A0 }
>>
>> -/* Check if we need to switch to another set of resources */
>> -static bool amdgpu_vmid_gds_switch_needed(struct amdgpu_vmid *id,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_jo=
b *job)
>> -{
>> -=C2=A0=C2=A0=C2=A0 return id->gds_base !=3D job->gds_base ||
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id->gds_size !=3D job->gds_=
size ||
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id->gws_base !=3D job->gws_=
base ||
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id->gws_size !=3D job->gws_=
size ||
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id->oa_base !=3D job->oa_ba=
se ||
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id->oa_size !=3D job->oa_si=
ze;
>> -}
>> -
>> =C2=A0 /* Check if the id is compatible with the job */
>> =C2=A0 static bool amdgpu_vmid_compatible(struct amdgpu_vmid *id,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_job *job=
)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return=C2=A0 id->pd_gpu_addr =3D=3D job-=
>vm_pd_addr &&
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !amdgpu_vmid_gds_switch_nee=
ded(id, job);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id->gds_base =3D=3D job->gd=
s_base &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id->gds_size =3D=3D job->gd=
s_size &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id->gws_base =3D=3D job->gw=
s_base &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id->gws_size =3D=3D job->gw=
s_size &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id->oa_base =3D=3D job->oa_=
base &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id->oa_size =3D=3D job->oa_=
size;
>> =C2=A0 }
>>
>> =C2=A0 /**
>> @@ -434,7 +427,6 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct
>> amdgpu_ring *ring,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_move_tail(&=
id->list, &id_mgr->ids_lru);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> -=C2=A0=C2=A0=C2=A0 job->gds_switch_needed =3D amdgpu_vmid_gds_switch_n=
eeded(id, job);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (job->vm_needs_flush) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id->flushed_upda=
tes =3D amdgpu_vm_tlb_seq(vm);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma_fence_put(id=
->last_flush);
>> @@ -503,7 +495,7 @@ void amdgpu_vmid_free_reserved(struct
>> amdgpu_device *adev,
>> =C2=A0=C2=A0 * @vmhub: vmhub type
>> =C2=A0=C2=A0 * @vmid: vmid number to use
>> =C2=A0=C2=A0 *
>> - * Reset saved GDW, GWS and OA to force switch on next flush.
>> + * Reset saved GDS, GWS and OA data.
>> =C2=A0=C2=A0 */
>> =C2=A0 void amdgpu_vmid_reset(struct amdgpu_device *adev, unsigned vmhu=
b,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned vmid)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>> index a963a25ddd62..2898508b1ce4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>> @@ -53,7 +53,6 @@ struct amdgpu_job {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 preamble_status;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 preemption_st=
atus;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 vm_needs_flush;
>> -=C2=A0=C2=A0=C2=A0 bool=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 gds_switch_needed;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spm_update_needed;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 vm_pd_addr;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 vmid;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 291977b93b1d..61856040cae2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -557,6 +557,12 @@ void amdgpu_vm_check_compute_bug(struct
>> amdgpu_device *adev)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 }
>>
>> +/* Check if the job needs a GDS switch */
>> +static bool amdgpu_vm_need_gds_switch(struct amdgpu_job *job)
>> +{
>> +=C2=A0=C2=A0=C2=A0 return job->gds_size || job->gws_size || job->oa_si=
ze;
>> +}
>> +
>> =C2=A0 /**
>> =C2=A0=C2=A0 * amdgpu_vm_need_pipeline_sync - Check if pipe sync is nee=
ded for
>> job.
>> =C2=A0=C2=A0 *
>> @@ -579,7 +585,7 @@ bool amdgpu_vm_need_pipeline_sync(struct
>> amdgpu_ring *ring,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (job->vm_needs_flush || ring->has_com=
pute_vm_bug)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
>>
>> -=C2=A0=C2=A0=C2=A0 if (ring->funcs->emit_gds_switch && job->gds_switch=
_needed)
>> +=C2=A0=C2=A0=C2=A0 if (ring->funcs->emit_gds_switch && amdgpu_vm_need_=
gds_switch(job))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (amdgpu_vmid_had_gpu_reset(adev, &id_=
mgr->ids[job->vmid]))
>> @@ -609,7 +615,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring,
>> struct amdgpu_job *job,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_vmid *id =3D &id_mgr->ids[=
job->vmid];
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool spm_update_needed =3D job->spm_upda=
te_needed;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool gds_switch_needed =3D ring->funcs->=
emit_gds_switch &&
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job->gds_switch_needed;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 amdgpu_vm_need_gds_switch(j=
ob);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool vm_flush_needed =3D job->vm_needs_f=
lush;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dma_fence *fence =3D NULL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool pasid_mapping_needed =3D false;
>> --
>> 2.41.0
>>
>
