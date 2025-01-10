Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB00E77188
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2025 07:37:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40A1310E4E8;
	Fri, 10 Jan 2025 07:37:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="leaz4kfG";
	dkim-atps=neutral
Received: from out30-113.freemail.mail.aliyun.com
 (out30-113.freemail.mail.aliyun.com [115.124.30.113])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3458B10E4E8
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 07:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736494633; h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
 bh=sZ6wkonleB0Y++9DcEWZO2tKP0JiPWTpU/zkYM7Ac0M=;
 b=leaz4kfG1HIcMDkg8p8boQBUY5uopydTmcU+MgUDY1Udd8X/bNVy4Wm0wB4S5LQ3xbcoekWXO69q8y6wEAg8kDB90w4ADi7gzvuZ9VX2Ay2zOu2S1JzweCkbvyvFmSZ0LqFvfri2GIRZCTbolCop7c3oY9YWeAe0aqwFMHwyjtE=
Received: from smtpclient.apple(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WNKJt7y_1736494631 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 10 Jan 2025 15:37:12 +0800
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [v4 5/5] drm/amdgpu: fix invalid memory access in
 amdgpu_fence_driver_sw_fini()
From: Gerry Liu <gerry@linux.alibaba.com>
In-Reply-To: <098f1b68-4772-481b-9b50-864d9cd2ad8a@amd.com>
Date: Fri, 10 Jan 2025 15:37:11 +0800
Cc: alexander.deucher@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 simona@ffwll.ch, sunil.khatri@amd.com, lijo.lazar@amd.com,
 Hawking.Zhang@amd.com, mario.limonciello@amd.com, xiaogang.chen@amd.com,
 Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E4A0DF29-FB19-49CE-BF2C-373D9D75C39B@linux.alibaba.com>
References: <cover.1736474822.git.gerry@linux.alibaba.com>
 <b824d12a9636ac43066d731c514de8abbf1d115e.1736474822.git.gerry@linux.alibaba.com>
 <098f1b68-4772-481b-9b50-864d9cd2ad8a@amd.com>
To: =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
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



> 2025=E5=B9=B41=E6=9C=8810=E6=97=A5 14:51=EF=BC=8CChristian K=C3=B6nig =
<christian.koenig@amd.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Am 10.01.25 um 03:08 schrieb Jiang Liu:
>> Function detects initialization status by checking sched->ops, so set
>> sched->ops to non-NULL just before return in function
>> amdgpu_fence_driver_sw_fini() and amdgpu_device_init_schedulers()
>> to avoid possible invalid memory access on error recover path.
>>=20
>> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 4 +++-
>>  2 files changed, 4 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index f29a4ad3c6d0..3688e9eb949b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -2857,6 +2857,7 @@ static int amdgpu_device_init_schedulers(struct =
amdgpu_device *adev)
>>  		if (r) {
>>  			DRM_ERROR("Failed to create scheduler on ring =
%s.\n",
>>  				  ring->name);
>> +			ring->sched.ops =3D NULL;
>>  			return r;
>>  		}
>>  		r =3D amdgpu_uvd_entity_init(adev, ring);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> index 2f24a6aa13bf..b5e87b515139 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> @@ -656,8 +656,10 @@ void amdgpu_fence_driver_sw_fini(struct =
amdgpu_device *adev)
>>  		 * The natural check would be sched.ready, which is
>>  		 * set as drm_sched_init() finishes...
>>  		 */
>> -		if (ring->sched.ops)
>> +		if (ring->sched.ops) {
>>  			drm_sched_fini(&ring->sched);
>> +			ring->sched.ops =3D NULL;
>> +		}
>=20
> As said in my previous reply we should really stop checking sched.ops =
here.
>=20
> The scheduler should not be cleaned up by this function in the first =
place.

Hi Christian,
	The current workflow is as below:
amdgpu_device_init
        amdgpu_fence_driver_sw_init
        amdgpu_device_ip_init
                amdgpu_device_init_schedulers
                        drm_sched_init
        amdgpu_fence_driver_hw_init
amdgpu_device_fini_hw
        amdgpu_fence_driver_hw_fini
amdgpu_device_fini_sw
        amdgpu_device_ip_fini
        amdgpu_fence_driver_sw_fini
                drm_sched_fini

	As you have mentioned, we should introduce =
amdgpu_device_fini_schedulers() and gets it called by =
amdgpu_device_ip_fini().
But I have no idea about why currently drm_sched_fini() is called by =
amdgpu_fence_driver_sw_fini() and whether it=E2=80=99s safe to move it =
into amdgpu_device_ip_fini().

Thanks,
Gerry

>=20
> Regards,
> Christian.
>=20
>>    		for (j =3D 0; j <=3D ring->fence_drv.num_fences_mask; =
++j)
>>  			dma_fence_put(ring->fence_drv.fences[j]);

