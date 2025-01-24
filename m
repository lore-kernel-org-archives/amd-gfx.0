Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C854EC02182
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jan 2025 03:04:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67AC910E05C;
	Fri, 24 Jan 2025 03:04:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SVDObo98";
	dkim-atps=neutral
Received: from out30-119.freemail.mail.aliyun.com
 (out30-119.freemail.mail.aliyun.com [115.124.30.119])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EB3110E05C
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jan 2025 03:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1737687878; h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
 bh=54Bt2a931kVPXQX7j+D1c/gUBAcHLzdJLb/k6Iolgc4=;
 b=SVDObo98f0Mnk2XNV/hsKwtk+rRRWyjg5iMdsoSClZ6vRfkJNSt7M7ns3Hv3+1FIQb+8L/BuG1oroBt59b7dEWESZUG7YCHqzN4JibeVtm8l+SGA8qiK9WHlym5WwbJw2uks4/SUzFROI2/amkYtUA9/FBWuxC1yYI1OHiBMKRw=
Received: from smtpclient.apple(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WODCiBS_1737687877 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 24 Jan 2025 11:04:38 +0800
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [v5 5/5] drm/amdgpu: fix invalid memory access in
 amdgpu_fence_driver_sw_fini()
From: Gerry Liu <gerry@linux.alibaba.com>
In-Reply-To: <5a5af585-cfa1-473f-a758-29e47b49ef50@amd.com>
Date: Fri, 24 Jan 2025 11:04:36 +0800
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, airlied@gmail.com, simona@ffwll.ch,
 sunil.khatri@amd.com, lijo.lazar@amd.com, Hawking.Zhang@amd.com,
 mario.limonciello@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7BBFD461-6250-4FA4-81B9-30F1A30C0E15@linux.alibaba.com>
References: <cover.1737100293.git.gerry@linux.alibaba.com>
 <2e4357dd1daf3068b1b883be604a335cc2be8c3a.1737100293.git.gerry@linux.alibaba.com>
 <5a5af585-cfa1-473f-a758-29e47b49ef50@amd.com>
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



> 2025=E5=B9=B41=E6=9C=8820=E6=97=A5 17:04=EF=BC=8CChristian K=C3=B6nig =
<christian.koenig@amd.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Am 17.01.25 um 08:55 schrieb Jiang Liu:
>> Introduce amdgpu_device_fini_schedulers() to clean scheduler related
>> resources, and avoid possible invalid memory access.
>>=20
>> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 35 =
+++++++++++++++++++---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  |  9 ------
>>  2 files changed, 31 insertions(+), 13 deletions(-)
>>=20
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index ee695e70fb4f..dd94f87c1f7c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -2821,6 +2821,26 @@ static int amdgpu_device_fw_loading(struct =
amdgpu_device *adev)
>>  	return r;
>>  }
>>  +static void __amdgpu_device_fini_schedulers(struct amdgpu_device =
*adev,
>> +					    int num_rings)
>> +{
>> +	int i;
>> +
>> +	for (i =3D 0; i < num_rings; ++i) {
>> +		struct amdgpu_ring *ring =3D adev->rings[i];
>> +
>> +		if (!ring || ring->no_scheduler)
>> +			continue;
>> +
>> +		drm_sched_fini(&ring->sched);
>> +	}
>> +}
>> +
>> +static void amdgpu_device_fini_schedulers(struct amdgpu_device =
*adev)
>> +{
>> +	__amdgpu_device_fini_schedulers(adev, AMDGPU_MAX_RINGS);
>> +}
>> +
>>  static int amdgpu_device_init_schedulers(struct amdgpu_device *adev)
>>  {
>>  	long timeout;
>> @@ -2857,27 +2877,32 @@ static int =
amdgpu_device_init_schedulers(struct amdgpu_device *adev)
>>  		if (r) {
>>  			DRM_ERROR("Failed to create scheduler on ring =
%s.\n",
>>  				  ring->name);
>> -			return r;
>> +			goto out_err;
>>  		}
>>  		r =3D amdgpu_uvd_entity_init(adev, ring);
>>  		if (r) {
>>  			DRM_ERROR("Failed to create UVD scheduling =
entity on ring %s.\n",
>>  				  ring->name);
>> -			return r;
>> +			goto out_sched_fini;
>>  		}
>>  		r =3D amdgpu_vce_entity_init(adev, ring);
>>  		if (r) {
>>  			DRM_ERROR("Failed to create VCE scheduling =
entity on ring %s.\n",
>>  				  ring->name);
>> -			return r;
>> +			goto out_sched_fini;
>>  		}
>>  	}
>>    	amdgpu_xcp_update_partition_sched_list(adev);
>>    	return 0;
>> -}
>>  +out_sched_fini:
>> +	drm_sched_fini(&adev->rings[i]->sched);
>> +out_err:
>> +	__amdgpu_device_fini_schedulers(adev, i);
>=20
> I would just open code that as:
>=20
> while (i--)
>     if (adev->rings[i] && !adev->rings[i]->no_scheduler)
>         drm_sched_fini(adev->rings[i]);
>=20
> instead of delegating that to the __amdgpu_device_fini_schedulers() =
function.
>=20
> That makes code maintenance easier should anything more need to be =
added to the amdgpu_device_fini_schedulers() function in the future.
OK, will fix it in next version.

>=20
> Regards,
> Christian.
>=20
>> +	return r;
>> +}
>>    /**
>>   * amdgpu_device_ip_init - run init for hardware IPs
>> @@ -3424,6 +3449,8 @@ static int amdgpu_device_ip_fini(struct =
amdgpu_device *adev)
>>    	amdgpu_amdkfd_device_fini_sw(adev);
>>  +	amdgpu_device_fini_schedulers(adev);
>> +
>>  	for (i =3D adev->num_ip_blocks - 1; i >=3D 0; i--) {
>>  		if (!adev->ip_blocks[i].status.sw)
>>  			continue;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> index 2f24a6aa13bf..c95895a7b888 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> @@ -650,15 +650,6 @@ void amdgpu_fence_driver_sw_fini(struct =
amdgpu_device *adev)
>>  		if (!ring || !ring->fence_drv.initialized)
>>  			continue;
>>  -		/*
>> -		 * Notice we check for sched.ops since there's some
>> -		 * override on the meaning of sched.ready by amdgpu.
>> -		 * The natural check would be sched.ready, which is
>> -		 * set as drm_sched_init() finishes...
>> -		 */
>> -		if (ring->sched.ops)
>> -			drm_sched_fini(&ring->sched);
>> -
>>  		for (j =3D 0; j <=3D ring->fence_drv.num_fences_mask; =
++j)
>>  			dma_fence_put(ring->fence_drv.fences[j]);
>>  		kfree(ring->fence_drv.fences);

