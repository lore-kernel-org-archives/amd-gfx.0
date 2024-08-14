Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FBFAC52D7B
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Aug 2024 02:09:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F41F210E24E;
	Wed, 14 Aug 2024 02:09:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kode54.net header.i=@kode54.net header.b="DGu6KNgQ";
	dkim-atps=neutral
X-Greylist: delayed 501 seconds by postgrey-1.36 at gabe;
 Wed, 14 Aug 2024 02:09:33 UTC
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com
 [91.218.175.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96B9010E24E
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Aug 2024 02:09:33 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kode54.net; s=key1;
 t=1723600870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wG9DIG79vb0bxX96t9DAQQD3GXc6IfrfZvACFwsXH0c=;
 b=DGu6KNgQwnv+MKwmxzUJvP7xL4DNjTZci2DCw99DCg2Y1KNwoiAKiIR2VxogqNDWEiPfuw
 Wm0rWgfd7UmS0UpMgtyF8XlGF6r0Ke7XnQYrSQvjYyM/WxvJGCxZBWfJnUbw2bUCCVBU91
 U2NZidZ3MLBgeJ/VdSFLEkqw+ZZxHHrCiaPhMNRrw0O1bQmDKpDRj+o0M9qtN8EBPhEAuH
 5Fu+gi4xIZTKTepYcO5hLWZCN5cVGqkpZa7iM/UFWg7sjEEhLmy2Pec/C/siVWmsnLluTr
 003bzeuRWBcrSRwpNMDRP84WmwLoYJ7v2gMrKhzcQJzkr34EPyac2vS0VAFJUA==
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Christopher Snowhill <chris@kode54.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] drm/amdkfd: keep create queue success if cwsr save area
 doesn't match
Date: Tue, 13 Aug 2024 19:00:51 -0700
Message-Id: <E3D1CFD8-93E9-4B38-BC02-7432B94432E8@kode54.net>
References: <7e40e8c2-d6a7-4e10-b71c-c4f869e825ab@amd.com>
Cc: "Zhang, Yifan" <Yifan1.Zhang@amd.com>,
 "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 amd-gfx@lists.freedesktop.org, "Yang, Philip" <Philip.Yang@amd.com>
In-Reply-To: <7e40e8c2-d6a7-4e10-b71c-c4f869e825ab@amd.com>
To: Felix Kuehling <felix.kuehling@amd.com>
X-Migadu-Flow: FLOW_OUT
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



> On Aug 13, 2024, at 6:52=E2=80=AFPM, Felix Kuehling <felix.kuehling@amd.co=
m> wrote:
>=20
> =EF=BB=BFHang on a second. If there are production GPUs that only work wit=
h HSA_OVERRIDE_GFX_VERSION right now, then we should make those GPUs properl=
y supported. I thought this was only used internally for bring-up or maybe e=
xternally as a short-term solution before we upstream proper support for new=
 GPUs.

For instance, for a bunch of compute things, I have to override 10.3.0 for m=
y 10.3.1 GPU, a 6700 XT, because nobody builds or packages the kernels for 1=
0.3.1.

>=20
> Regards,
>  Felix
>=20
>=20
>> On 2024-08-11 22:10, Zhang, Yifan wrote:
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>=20
>> I agree that adding exp_hw_support is a safer approach. My concern is tha=
t HSA_OVERRIDE_GFX_VERSION has been used for a while and has become a status=
 quo for running ROCm on unsupported APUs. I'm not sure if this approach wil=
l be a burden for APU end users. Adding driver load parameters is more compl=
icated than simply adding an environment variable on consumer PCs.
>>=20
>> Best Regards,
>> Yifan
>>=20
>> -----Original Message-----
>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>> Sent: Saturday, August 10, 2024 7:37 AM
>> To: Zhang, Yifan <Yifan1.Zhang@amd.com>; Kasiviswanathan, Harish <Harish.=
Kasiviswanathan@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Yang, Philip <Philip.Yang@amd.com>
>> Subject: Re: [PATCH] drm/amdkfd: keep create queue success if cwsr save a=
rea doesn't match
>>=20
>> Maybe we can turn this check into a warnings if, and only if the exp_hw_s=
upport module param is set. That way we don't water down the checks on the p=
roduction code path but allow experimental setups to run without a seat belt=
.
>>=20
>> Regards,
>>   Felix
>>=20
>>=20
>>> On 2024-08-09 01:39, Zhang, Yifan wrote:
>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>=20
>>> Yes, I think we need that change for a normal code path, but this case i=
s introduced only with the HSA_OVERRIDE_GFX_VERSION environment setting, whi=
ch implies that "the override ASIC is compatible with the real ASIC." It is i=
ntended for experimental purposes. When a user is using HSA_OVERRIDE_GFX_VER=
SION, they should be aware of the potential risks it may bring. Usually, HSA=
_OVERRIDE_GFX_VERSION is used to force an unsupported APU to be recognized a=
s a ROCm-supported high-end dGPU, which has a large cwsr save area, making t=
he operation safe. This check was added to KFD two weeks ago, the HSA_OVERRI=
DE_GFX_VERSION environment had been working fine before that.
>>>=20
>>> Best Regards,
>>> Yifan
>>>=20
>>> -----Original Message-----
>>> From: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
>>> Sent: Thursday, August 8, 2024 10:46 PM
>>> To: Zhang, Yifan <Yifan1.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
>>> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Yang, Philip
>>> <Philip.Yang@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>
>>> Subject: RE: [PATCH] drm/amdkfd: keep create queue success if cwsr
>>> save area doesn't match
>>>=20
>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>=20
>>> In this case, shouldn't larger of two sizes be used. Also, we should hav=
e an upper bound check.
>>>=20
>>> -----Original Message-----
>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>>> Yifan Zhang
>>> Sent: Thursday, August 8, 2024 4:44 AM
>>> To: amd-gfx@lists.freedesktop.org
>>> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Yang, Philip
>>> <Philip.Yang@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>
>>> Subject: [PATCH] drm/amdkfd: keep create queue success if cwsr save
>>> area doesn't match
>>>=20
>>> If HSA_OVERRIDE_GFX_VERSION is used in ROCm workload, user space and ker=
nel use different spec to calculate cwsr save area, current check may fail c=
reate queue ioctl. Change error to warn to make create queue succeed in that=
 case.
>>>=20
>>> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 4 +---
>>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>>=20
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>>> index e0a073ae4a49..9f283aff057a 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>>> @@ -295,11 +295,9 @@ int kfd_queue_acquire_buffers(struct kfd_process_de=
vice *pdd, struct queue_prope
>>>         }
>>>=20
>>>         if (properties->ctx_save_restore_area_size !=3D topo_dev->node_p=
rops.cwsr_size) {
>>> -               pr_debug("queue cwsr size 0x%x not equal to node cwsr si=
ze 0x%x\n",
>>> +               pr_warn("queue cwsr size 0x%x not equal to node cwsr
>>> + size 0x%x\n",
>>>                         properties->ctx_save_restore_area_size,
>>>                         topo_dev->node_props.cwsr_size);
>>> -               err =3D -EINVAL;
>>> -               goto out_err_unreserve;
>>>         }
>>>=20
>>>         total_cwsr_size =3D (topo_dev->node_props.cwsr_size +
>>> topo_dev->node_props.debug_memory_size)
>>> --
>>> 2.37.3
>>>=20
>>>=20
