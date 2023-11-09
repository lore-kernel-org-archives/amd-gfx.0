Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B07BC4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Nov 2023 21:35:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1A7210E91F;
	Thu,  9 Nov 2023 21:35:51 +0000 (UTC)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0406410E91F
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Nov 2023 21:35:19 +0000 (UTC)
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-778ac9c898dso82823785a.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Nov 2023 13:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699565718; x=1700170518; darn=lists.freedesktop.org;
 h=in-reply-to:autocrypt:from:content-language:references:cc:to
 :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=bdnKgXfRk0dGCF864qHuW8O//PNi43orLvHVp6GDePg=;
 b=NujQavg1Zi6Dvxw6eL9+25uBIswBeGYC8pzN+DopaSUZkaTJXaYj5PdEvBscr80A4I
 vBLDHVUO9FmzWdSKgvxBsRwW8nAdbWeEb4hXzNTc6HEIt4gSMe9eu5lRWYrqaIgWrc19
 XAu06H10COoezsPIt0GsYuMmhPV1mJxfckYwqXErMCVzzkIBCT3DkHYVHLQoQwdi1lw1
 trUULsxahbGsgFHWKnFrox94mecTd7MgQBQ/PBDjHI1SFVWwoakjula4Y4zaoqNSeHtr
 FuE6/+NotDJhQfTZGkwfdbgt/XuWRrdu9FYHsSh8mxGPOVxPjVA4RbxpBN834O0ezidP
 S3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699565718; x=1700170518;
 h=in-reply-to:autocrypt:from:content-language:references:cc:to
 :subject:user-agent:mime-version:date:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bdnKgXfRk0dGCF864qHuW8O//PNi43orLvHVp6GDePg=;
 b=Sa+mJC1rFz8KyM+XpH3ieB+K4BZtaQ/YE/FNGbD3FD/a0zlypaYUotNbffE8Dakvg/
 BQ1hmgP9Fe14vxGQu/1T0QPH4YLBFyXyBgwnzGQAiZhash5ttpEvXhuBgMhBSP1urUly
 yWoJHVlvT5TZAQKUr5oRD+qy9joK+Q0sytWUo/pAtNY3xe/HjrNwOwymNrpDIinvKIGd
 g65zbhbNdRzXWq7RQToq5jzzCjoZQpP6vIQOtJD4K0sDIDUy/NuM0ACptK/EesX38iP5
 CNrXeicdUk+qC/QmU9kf6q9yahjA43DDJ1Qc2XeF95awsZ63EMl0984Al8I7qOSnl86O
 qRCQ==
X-Gm-Message-State: AOJu0YyJrycKwQqQTH4f+Qo0k5u88WJCbQ9w7f9EdwHM+46JnU1Kdz8C
 b3UYvIuSCjoYoMu1zEbXa2w=
X-Google-Smtp-Source: AGHT+IEe1J49xamC79VjVkQKBN6dRX+dvl+l3sreKYxvUDeMRhmHxggAajCiHneKtfqjXfgX6UWPvQ==
X-Received: by 2002:a05:6214:29c6:b0:66d:2785:a2b0 with SMTP id
 gh6-20020a05621429c600b0066d2785a2b0mr6241654qvb.29.1699565717598; 
 Thu, 09 Nov 2023 13:35:17 -0800 (PST)
Received: from [192.168.2.14] ([76.65.20.140])
 by smtp.gmail.com with ESMTPSA id
 pz6-20020ad45506000000b0065823d20381sm2416590qvb.8.2023.11.09.13.35.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Nov 2023 13:35:17 -0800 (PST)
Message-ID: <55c7fe4c-b594-4442-971e-3d4adefdb664@gmail.com>
Date: Thu, 9 Nov 2023 16:35:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:115.0) Gecko/20100101
 Thunderbird/115.4.2
Subject: Re: [PATCH] drm/amdgpu: move UVD and VCE sched entity init after
 sched init
To: Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20231108184152.4755-1-alexander.deucher@amd.com>
 <CADnq5_Msooo0n7=hLS9vXL3sn-_AGHaauejkCE+NP-AUuaEJEg@mail.gmail.com>
Content-Language: en-CA, en-US
From: Luben Tuikov <ltuikov89@gmail.com>
Autocrypt: addr=ltuikov89@gmail.com; keydata=
 xjMEZTohOhYJKwYBBAHaRw8BAQdAWSq76k+GsENjDTMVCy9Vr4fAO9Rb57/bPT1APnbnnRHN
 Ikx1YmVuIFR1aWtvdiA8bHR1aWtvdjg5QGdtYWlsLmNvbT7CmQQTFgoAQRYhBJkj7+VmFO9b
 eaAl10wVR5QxozSvBQJlOiE6AhsDBQkJZgGABQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheA
 AAoJEEwVR5QxozSvSm4BAOwCpX53DTQhE20FBGlTMqKCOQyJqlMcIQ9SO1qPWX1iAQCv3vfy
 JwktF7REl1yt7IU2Sye1qmQMfJxdt9JMbMNNBs44BGU6IToSCisGAQQBl1UBBQEBB0BT9wSP
 cCE8uGe7FWo8C+nTSyWPXKTx9F0gpEnlqReRBwMBCAfCfgQYFgoAJhYhBJkj7+VmFO9beaAl
 10wVR5QxozSvBQJlOiE6AhsMBQkJZgGAAAoJEEwVR5QxozSvSsYA/2LIFjbxQ2ikbU5S0pKo
 aMDzO9eGz69uNhNWJcvIKJK6AQC9228Mqc1JeZMIyjYWr2HKYHi8S2q2/zHrSZwAWYYwDA==
In-Reply-To: <CADnq5_Msooo0n7=hLS9vXL3sn-_AGHaauejkCE+NP-AUuaEJEg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------C3FViV8WEUzSAUAlOy7LaUfd"
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------C3FViV8WEUzSAUAlOy7LaUfd
Content-Type: multipart/mixed; boundary="------------rRFw7bYwEuVfBmfGKeBAOjUg";
 protected-headers="v1"
From: Luben Tuikov <ltuikov89@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Message-ID: <55c7fe4c-b594-4442-971e-3d4adefdb664@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: move UVD and VCE sched entity init after
 sched init
References: <20231108184152.4755-1-alexander.deucher@amd.com>
 <CADnq5_Msooo0n7=hLS9vXL3sn-_AGHaauejkCE+NP-AUuaEJEg@mail.gmail.com>
In-Reply-To: <CADnq5_Msooo0n7=hLS9vXL3sn-_AGHaauejkCE+NP-AUuaEJEg@mail.gmail.com>

--------------rRFw7bYwEuVfBmfGKeBAOjUg
Content-Type: multipart/mixed; boundary="------------pTqvwWtyr8a6PhkXLOP06Tx6"

--------------pTqvwWtyr8a6PhkXLOP06Tx6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2023-11-09 11:13, Alex Deucher wrote:
> Ping?
>=20
> On Wed, Nov 8, 2023 at 1:42=E2=80=AFPM Alex Deucher <alexander.deucher@=
amd.com> wrote:
>>
>> We need kernel scheduling entities to deal with handle clean up
>> if apps are not cleaned up properly.  With commit 56e449603f0ac5
>> ("drm/sched: Convert the GPU scheduler to variable number of run-queue=
s")
>> the scheduler entities have to be created after scheduler init, so
>> change the ordering to fix this.
>>
>> v2: Leave logic in UVD and VCE code
>>
>> Fixes: 56e449603f0ac5 ("drm/sched: Convert the GPU scheduler to variab=
le number of run-queues")
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> Cc: ltuikov89@gmail.com

Reviewed-by: Luben Tuikov <ltuikov89@gmail.com>

Regards,
Luben

>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 +++++++++++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c    | 22 ++++++++++----------
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h    |  2 +-
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c    | 24 +++++++++++----------=
-
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h    |  2 +-
>>  drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c      |  2 --
>>  drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c      |  2 --
>>  drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c      |  2 --
>>  drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c      |  2 --
>>  drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c      |  4 ----
>>  drivers/gpu/drm/amd/amdgpu/vce_v2_0.c      |  2 --
>>  drivers/gpu/drm/amd/amdgpu/vce_v3_0.c      |  2 --
>>  drivers/gpu/drm/amd/amdgpu/vce_v4_0.c      |  5 -----
>>  13 files changed, 37 insertions(+), 46 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c
>> index 43a95feba884..03e669c34033 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -2499,6 +2499,18 @@ static int amdgpu_device_init_schedulers(struct=
 amdgpu_device *adev)
>>                                   ring->name);
>>                         return r;
>>                 }
>> +               r =3D amdgpu_uvd_entity_init(adev, ring);
>> +               if (r) {
>> +                       DRM_ERROR("Failed to create UVD scheduling ent=
ity on ring %s.\n",
>> +                                 ring->name);
>> +                       return r;
>> +               }
>> +               r =3D amdgpu_vce_entity_init(adev, ring);
>> +               if (r) {
>> +                       DRM_ERROR("Failed to create VCE scheduling ent=
ity on ring %s.\n",
>> +                                 ring->name);
>> +                       return r;
>> +               }
>>         }
>>
>>         amdgpu_xcp_update_partition_sched_list(adev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_uvd.c
>> index 815b7c34ed33..65949cc7abb9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>> @@ -399,20 +399,20 @@ int amdgpu_uvd_sw_fini(struct amdgpu_device *ade=
v)
>>   *
>>   * @adev: amdgpu_device pointer
>>   *
>> + * Initialize the entity used for handle management in the kernel dri=
ver.
>>   */
>> -int amdgpu_uvd_entity_init(struct amdgpu_device *adev)
>> +int amdgpu_uvd_entity_init(struct amdgpu_device *adev, struct amdgpu_=
ring *ring)
>>  {
>> -       struct amdgpu_ring *ring;
>> -       struct drm_gpu_scheduler *sched;
>> -       int r;
>> +       if (ring =3D=3D &adev->uvd.inst[0].ring) {
>> +               struct drm_gpu_scheduler *sched =3D &ring->sched;
>> +               int r;
>>
>> -       ring =3D &adev->uvd.inst[0].ring;
>> -       sched =3D &ring->sched;
>> -       r =3D drm_sched_entity_init(&adev->uvd.entity, DRM_SCHED_PRIOR=
ITY_NORMAL,
>> -                                 &sched, 1, NULL);
>> -       if (r) {
>> -               DRM_ERROR("Failed setting up UVD kernel entity.\n");
>> -               return r;
>> +               r =3D drm_sched_entity_init(&adev->uvd.entity, DRM_SCH=
ED_PRIORITY_NORMAL,
>> +                                         &sched, 1, NULL);
>> +               if (r) {
>> +                       DRM_ERROR("Failed setting up UVD kernel entity=
=2E\n");
>> +                       return r;
>> +               }
>>         }
>>
>>         return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_uvd.h
>> index a9f342537c68..9dfad2f48ef4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
>> @@ -73,7 +73,7 @@ struct amdgpu_uvd {
>>
>>  int amdgpu_uvd_sw_init(struct amdgpu_device *adev);
>>  int amdgpu_uvd_sw_fini(struct amdgpu_device *adev);
>> -int amdgpu_uvd_entity_init(struct amdgpu_device *adev);
>> +int amdgpu_uvd_entity_init(struct amdgpu_device *adev, struct amdgpu_=
ring *ring);
>>  int amdgpu_uvd_prepare_suspend(struct amdgpu_device *adev);
>>  int amdgpu_uvd_suspend(struct amdgpu_device *adev);
>>  int amdgpu_uvd_resume(struct amdgpu_device *adev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_vce.c
>> index 1904edf68407..0954447f689d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>> @@ -231,20 +231,20 @@ int amdgpu_vce_sw_fini(struct amdgpu_device *ade=
v)
>>   *
>>   * @adev: amdgpu_device pointer
>>   *
>> + * Initialize the entity used for handle management in the kernel dri=
ver.
>>   */
>> -int amdgpu_vce_entity_init(struct amdgpu_device *adev)
>> +int amdgpu_vce_entity_init(struct amdgpu_device *adev, struct amdgpu_=
ring *ring)
>>  {
>> -       struct amdgpu_ring *ring;
>> -       struct drm_gpu_scheduler *sched;
>> -       int r;
>> -
>> -       ring =3D &adev->vce.ring[0];
>> -       sched =3D &ring->sched;
>> -       r =3D drm_sched_entity_init(&adev->vce.entity, DRM_SCHED_PRIOR=
ITY_NORMAL,
>> -                                 &sched, 1, NULL);
>> -       if (r !=3D 0) {
>> -               DRM_ERROR("Failed setting up VCE run queue.\n");
>> -               return r;
>> +       if (ring =3D=3D &adev->vce.ring[0]) {
>> +               struct drm_gpu_scheduler *sched =3D &ring->sched;
>> +               int r;
>> +
>> +               r =3D drm_sched_entity_init(&adev->vce.entity, DRM_SCH=
ED_PRIORITY_NORMAL,
>> +                                         &sched, 1, NULL);
>> +               if (r !=3D 0) {
>> +                       DRM_ERROR("Failed setting up VCE run queue.\n"=
);
>> +                       return r;
>> +               }
>>         }
>>
>>         return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_vce.h
>> index ea680fc9a6c3..6e53f872d084 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
>> @@ -55,7 +55,7 @@ struct amdgpu_vce {
>>
>>  int amdgpu_vce_sw_init(struct amdgpu_device *adev, unsigned long size=
);
>>  int amdgpu_vce_sw_fini(struct amdgpu_device *adev);
>> -int amdgpu_vce_entity_init(struct amdgpu_device *adev);
>> +int amdgpu_vce_entity_init(struct amdgpu_device *adev, struct amdgpu_=
ring *ring);
>>  int amdgpu_vce_suspend(struct amdgpu_device *adev);
>>  int amdgpu_vce_resume(struct amdgpu_device *adev);
>>  void amdgpu_vce_free_handles(struct amdgpu_device *adev, struct drm_f=
ile *filp);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/a=
md/amdgpu/uvd_v3_1.c
>> index 58a8f78c003c..a6006f231c65 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
>> @@ -577,8 +577,6 @@ static int uvd_v3_1_sw_init(void *handle)
>>         ptr +=3D ucode_len;
>>         memcpy(&adev->uvd.keyselect, ptr, 4);
>>
>> -       r =3D amdgpu_uvd_entity_init(adev);
>> -
>>         return r;
>>  }
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/a=
md/amdgpu/uvd_v4_2.c
>> index d3b1e31f5450..1aa09ad7bbe3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
>> @@ -127,8 +127,6 @@ static int uvd_v4_2_sw_init(void *handle)
>>         if (r)
>>                 return r;
>>
>> -       r =3D amdgpu_uvd_entity_init(adev);
>> -
>>         return r;
>>  }
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/a=
md/amdgpu/uvd_v5_0.c
>> index 5a8116437abf..f8b229b75435 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
>> @@ -125,8 +125,6 @@ static int uvd_v5_0_sw_init(void *handle)
>>         if (r)
>>                 return r;
>>
>> -       r =3D amdgpu_uvd_entity_init(adev);
>> -
>>         return r;
>>  }
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/a=
md/amdgpu/uvd_v6_0.c
>> index 74c09230aeb3..a9a6880f44e3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
>> @@ -432,8 +432,6 @@ static int uvd_v6_0_sw_init(void *handle)
>>                 }
>>         }
>>
>> -       r =3D amdgpu_uvd_entity_init(adev);
>> -
>>         return r;
>>  }
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/a=
md/amdgpu/uvd_v7_0.c
>> index 1c42cf10cc29..6068b784dc69 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
>> @@ -480,10 +480,6 @@ static int uvd_v7_0_sw_init(void *handle)
>>         if (r)
>>                 return r;
>>
>> -       r =3D amdgpu_uvd_entity_init(adev);
>> -       if (r)
>> -               return r;
>> -
>>         r =3D amdgpu_virt_alloc_mm_table(adev);
>>         if (r)
>>                 return r;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/a=
md/amdgpu/vce_v2_0.c
>> index 67eb01fef789..a08e7abca423 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
>> @@ -441,8 +441,6 @@ static int vce_v2_0_sw_init(void *handle)
>>                         return r;
>>         }
>>
>> -       r =3D amdgpu_vce_entity_init(adev);
>> -
>>         return r;
>>  }
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/a=
md/amdgpu/vce_v3_0.c
>> index 18f6e62af339..f4760748d349 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>> @@ -450,8 +450,6 @@ static int vce_v3_0_sw_init(void *handle)
>>                         return r;
>>         }
>>
>> -       r =3D amdgpu_vce_entity_init(adev);
>> -
>>         return r;
>>  }
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/a=
md/amdgpu/vce_v4_0.c
>> index e0b70cd3b697..06d787385ad4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>> @@ -486,11 +486,6 @@ static int vce_v4_0_sw_init(void *handle)
>>                         return r;
>>         }
>>
>> -
>> -       r =3D amdgpu_vce_entity_init(adev);
>> -       if (r)
>> -               return r;
>> -
>>         r =3D amdgpu_virt_alloc_mm_table(adev);
>>         if (r)
>>                 return r;
>> --
>> 2.41.0
>>

--------------pTqvwWtyr8a6PhkXLOP06Tx6
Content-Type: application/pgp-keys; name="OpenPGP_0x4C15479431A334AF.asc"
Content-Disposition: attachment; filename="OpenPGP_0x4C15479431A334AF.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xjMEZTohOhYJKwYBBAHaRw8BAQdAWSq76k+GsENjDTMVCy9Vr4fAO9Rb57/bPT1A
PnbnnRHNIkx1YmVuIFR1aWtvdiA8bHR1aWtvdjg5QGdtYWlsLmNvbT7CmQQTFgoA
QRYhBJkj7+VmFO9beaAl10wVR5QxozSvBQJlOiE6AhsDBQkJZgGABQsJCAcCAiIC
BhUKCQgLAgQWAgMBAh4HAheAAAoJEEwVR5QxozSvSm4BAOwCpX53DTQhE20FBGlT
MqKCOQyJqlMcIQ9SO1qPWX1iAQCv3vfyJwktF7REl1yt7IU2Sye1qmQMfJxdt9JM
bMNNBs44BGU6IToSCisGAQQBl1UBBQEBB0BT9wSPcCE8uGe7FWo8C+nTSyWPXKTx
9F0gpEnlqReRBwMBCAfCfgQYFgoAJhYhBJkj7+VmFO9beaAl10wVR5QxozSvBQJl
OiE6AhsMBQkJZgGAAAoJEEwVR5QxozSvSsYA/2LIFjbxQ2ikbU5S0pKoaMDzO9eG
z69uNhNWJcvIKJK6AQC9228Mqc1JeZMIyjYWr2HKYHi8S2q2/zHrSZwAWYYwDA=3D=3D
=3DqCaZ
-----END PGP PUBLIC KEY BLOCK-----

--------------pTqvwWtyr8a6PhkXLOP06Tx6--

--------------rRFw7bYwEuVfBmfGKeBAOjUg--

--------------C3FViV8WEUzSAUAlOy7LaUfd
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSZI+/lZhTvW3mgJddMFUeUMaM0rwUCZU1QjAUDAAAAAAAKCRBMFUeUMaM0r+BQ
AP4q7oVZeRvZm1oe/LVFlRwojYVH4zFgwKEmgnI9i60O+wEAueUfYp5g2XkilxVnRUyZi7zyjGlL
OhlZpFazLjQZ7w4=
=sOh9
-----END PGP SIGNATURE-----

--------------C3FViV8WEUzSAUAlOy7LaUfd--
