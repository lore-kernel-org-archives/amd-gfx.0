Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA870C25B48
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 19:52:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6941110E884;
	Thu, 26 Oct 2023 19:52:16 +0000 (UTC)
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com
 [IPv6:2607:f8b0:4864:20::e33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A4CF10E884
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 19:52:14 +0000 (UTC)
Received: by mail-vs1-xe33.google.com with SMTP id
 ada2fe7eead31-45895225422so533380137.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 12:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698349933; x=1698954733; darn=lists.freedesktop.org;
 h=in-reply-to:autocrypt:from:references:cc:to:content-language
 :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=EOD8ClET3ZLIQzPFXKB7bvTdYWvf1mDeSAyiCmstoks=;
 b=Wz448RuXgwXg5YQlUPuJoH6WGJvN2ordvTe7qc8yvzch9oLCg7Hwmp3SfvwmS2Poz+
 0mfQeq/qzQIR1+AMvL3JjvCJP9ThedABsSi/TCaamwy4MSqCx0NNp4C4XIGJSzm54Uf8
 K3tHgqg+sMh9E/UXy6JOk9FlKlYJ2Z2AAK+9w3Wk7jycaRcwgKYoK3nFuBSWbGU7jnN6
 FmKnYlhiShBmFWiKFAbOz+2FzMGg1BaouJ1HtYdEQGOYg9BWxbUX4gK6PQLWakbUjNh6
 d32nJJCXSA0buILqe8I3GtNPecaLQ1V6AHurjdmUGaHf9JZAehoHhjEId97ONgW4VYUJ
 S92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698349933; x=1698954733;
 h=in-reply-to:autocrypt:from:references:cc:to:content-language
 :subject:user-agent:mime-version:date:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EOD8ClET3ZLIQzPFXKB7bvTdYWvf1mDeSAyiCmstoks=;
 b=g1d0HbndEDhsmvQOrLpuZhl8XrKX+2BdMnCRy+pwNLOiEc3ZAaWi/XUMIZWwLCTBJl
 7V3kL7HOEQGNwMoL+Qtl1dN6zd93wzdvfl4xKwNwy03h48rk53ednIQm9SHZmu4FvxwO
 NsAkm2iARBepqllxGbqyXgHj/etIan4RKaucHaEjq0SYTLucz6JzKyrkvuh/I9SEYTr3
 2wjGaI79ZCSTy0MsA/qMMrL511qRdvwrpI2EtIxrwFKGVbAT8pBAB6nXJh4RRL7ZqT/B
 2+RFXeHpj5OxK3iauvmZNgihwFIJkRgYKB2G8H7cB6NgLmoJNsv4PD+1O031ZDpNZTm4
 DpgQ==
X-Gm-Message-State: AOJu0YyFFESp1ZX1RHlw4TpS8EMRcp7dpk1QjOjZbOgvOqlW6pp1j1WF
 QJMTiJOS+sunf2iBI/QqQNk=
X-Google-Smtp-Source: AGHT+IFZ9/TE/X9UN07UVgdd6UMzEo87t8CS799/GJlupV3fEStWO6FheIdpt//rl+I4aYqt6rHAAQ==
X-Received: by 2002:a05:6102:1043:b0:452:67fd:e5c1 with SMTP id
 h3-20020a056102104300b0045267fde5c1mr886329vsq.4.1698349933309; 
 Thu, 26 Oct 2023 12:52:13 -0700 (PDT)
Received: from [192.168.2.14] ([64.231.246.137])
 by smtp.gmail.com with ESMTPSA id
 w20-20020a05620a149400b0076cbcf8ad3bsm5183456qkj.55.2023.10.26.12.52.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Oct 2023 12:52:12 -0700 (PDT)
Message-ID: <04db543c-7aec-4550-878f-a9753142130e@gmail.com>
Date: Thu, 26 Oct 2023 15:52:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:115.0) Gecko/20100101
 Thunderbird/115.4.1
Subject: Re: [PATCH] drm/amdgpu: move buffer funcs setting up a level
Content-Language: en-CA, en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
References: <20231025171928.3318505-1-alexander.deucher@amd.com>
 <96db9e3d-4636-4da4-b4d1-ca3f5fd8d887@gmail.com>
 <CADnq5_ORyv9MDfUd3NPDw+APUunDjkTW4Bx4z0FoCiK+s_i+uw@mail.gmail.com>
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
In-Reply-To: <CADnq5_ORyv9MDfUd3NPDw+APUunDjkTW4Bx4z0FoCiK+s_i+uw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------iE0Wl8FxUR5cHrLLffJmvm1R"
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------iE0Wl8FxUR5cHrLLffJmvm1R
Content-Type: multipart/mixed; boundary="------------8n8DIA0zDJQqsiE504hA2ULx";
 protected-headers="v1"
From: Luben Tuikov <ltuikov89@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org
Message-ID: <04db543c-7aec-4550-878f-a9753142130e@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: move buffer funcs setting up a level
References: <20231025171928.3318505-1-alexander.deucher@amd.com>
 <96db9e3d-4636-4da4-b4d1-ca3f5fd8d887@gmail.com>
 <CADnq5_ORyv9MDfUd3NPDw+APUunDjkTW4Bx4z0FoCiK+s_i+uw@mail.gmail.com>
In-Reply-To: <CADnq5_ORyv9MDfUd3NPDw+APUunDjkTW4Bx4z0FoCiK+s_i+uw@mail.gmail.com>

--------------8n8DIA0zDJQqsiE504hA2ULx
Content-Type: multipart/mixed; boundary="------------xfKh0LVuDhI7P0fnyQhc3Ab2"

--------------xfKh0LVuDhI7P0fnyQhc3Ab2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2023-10-26 15:32, Alex Deucher wrote:
> On Thu, Oct 26, 2023 at 2:22=E2=80=AFAM Christian K=C3=B6nig
> <ckoenig.leichtzumerken@gmail.com> wrote:
>>
>> Am 25.10.23 um 19:19 schrieb Alex Deucher:
>>> Rather than doing this in the IP code for the SDMA paging
>>> engine, move it up to the core device level init level.
>>> This should fix the scheduler init ordering.
>>>
>>> v2: drop extra parens
>>> v3: drop SDMA helpers
>>>
>>> Tested-by: Luben Tuikov <luben.tuikov@amd.com>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>
>> I don't know of hand if the high level function really cover everythin=
g,
>> so only Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com> for =
now.
>>
>=20
> Luben,
>=20
> Was this needed for some of the scheduler stuff that is pending?  If
> you would rather take it via drm-misc to align with the scheduler
> changes, that works for me, otherwise I can take it via the amdgpu
> tree.

Hi Alex,

Yes, it does.

I can take it via drm-misc-next as that where the scheduler changes lande=
d.

I'll add Christian's Acked-by.

I'll add a Fixes tag because ideally it should've gone before the dynamic=

sched_rq commit.

Thanks for the heads-up!

Regards,
Luben



>=20
> Thanks,
>=20
> Alex
>=20
>=20
>> Christian.
>>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 +++++++++++++++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c   | 21 -------------------=
--
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h   |  1 -
>>>   drivers/gpu/drm/amd/amdgpu/cik_sdma.c      |  5 -----
>>>   drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c     |  5 -----
>>>   drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c     |  5 -----
>>>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c     | 16 +---------------
>>>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c     | 10 +---------
>>>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c     | 10 +---------
>>>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c     | 10 +---------
>>>   drivers/gpu/drm/amd/amdgpu/si_dma.c        |  5 -----
>>>   11 files changed, 19 insertions(+), 84 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_device.c
>>> index 2031a467b721..5c90080e93ba 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -2662,6 +2662,9 @@ static int amdgpu_device_ip_init(struct amdgpu_=
device *adev)
>>>       if (r)
>>>               goto init_failed;
>>>
>>> +     if (adev->mman.buffer_funcs_ring->sched.ready)
>>> +             amdgpu_ttm_set_buffer_funcs_status(adev, true);
>>> +
>>>       /* Don't init kfd if whole hive need to be reset during init */=

>>>       if (!adev->gmc.xgmi.pending_reset) {
>>>               kgd2kfd_init_zone_device(adev);
>>> @@ -3260,6 +3263,8 @@ int amdgpu_device_ip_suspend(struct amdgpu_devi=
ce *adev)
>>>               amdgpu_virt_request_full_gpu(adev, false);
>>>       }
>>>
>>> +     amdgpu_ttm_set_buffer_funcs_status(adev, false);
>>> +
>>>       r =3D amdgpu_device_ip_suspend_phase1(adev);
>>>       if (r)
>>>               return r;
>>> @@ -3449,6 +3454,9 @@ static int amdgpu_device_ip_resume(struct amdgp=
u_device *adev)
>>>
>>>       r =3D amdgpu_device_ip_resume_phase2(adev);
>>>
>>> +     if (adev->mman.buffer_funcs_ring->sched.ready)
>>> +             amdgpu_ttm_set_buffer_funcs_status(adev, true);
>>> +
>>>       return r;
>>>   }
>>>
>>> @@ -4236,6 +4244,8 @@ void amdgpu_device_fini_hw(struct amdgpu_device=
 *adev)
>>>       /* disable ras feature must before hw fini */
>>>       amdgpu_ras_pre_fini(adev);
>>>
>>> +     amdgpu_ttm_set_buffer_funcs_status(adev, false);
>>> +
>>>       amdgpu_device_ip_fini_early(adev);
>>>
>>>       amdgpu_irq_fini_hw(adev);
>>> @@ -4407,6 +4417,8 @@ int amdgpu_device_suspend(struct drm_device *de=
v, bool fbcon)
>>>
>>>       amdgpu_ras_suspend(adev);
>>>
>>> +     amdgpu_ttm_set_buffer_funcs_status(adev, false);
>>> +
>>>       amdgpu_device_ip_suspend_phase1(adev);
>>>
>>>       if (!adev->in_s0ix)
>>> @@ -5178,6 +5190,9 @@ int amdgpu_do_asic_reset(struct list_head *devi=
ce_list_handle,
>>>                               if (r)
>>>                                       goto out;
>>>
>>> +                             if (tmp_adev->mman.buffer_funcs_ring->s=
ched.ready)
>>> +                                     amdgpu_ttm_set_buffer_funcs_sta=
tus(tmp_adev, true);
>>> +
>>>                               if (vram_lost)
>>>                                       amdgpu_device_fill_reset_magic(=
tmp_adev);
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_sdma.c
>>> index e8cbc4142d80..1d9d187de6ee 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>>> @@ -292,27 +292,6 @@ int amdgpu_sdma_init_microcode(struct amdgpu_dev=
ice *adev,
>>>       return err;
>>>   }
>>>
>>> -void amdgpu_sdma_unset_buffer_funcs_helper(struct amdgpu_device *ade=
v)
>>> -{
>>> -     struct amdgpu_ring *sdma;
>>> -     int i;
>>> -
>>> -     for (i =3D 0; i < adev->sdma.num_instances; i++) {
>>> -             if (adev->sdma.has_page_queue) {
>>> -                     sdma =3D &adev->sdma.instance[i].page;
>>> -                     if (adev->mman.buffer_funcs_ring =3D=3D sdma) {=

>>> -                             amdgpu_ttm_set_buffer_funcs_status(adev=
, false);
>>> -                             break;
>>> -                     }
>>> -             }
>>> -             sdma =3D &adev->sdma.instance[i].ring;
>>> -             if (adev->mman.buffer_funcs_ring =3D=3D sdma) {
>>> -                     amdgpu_ttm_set_buffer_funcs_status(adev, false)=
;
>>> -                     break;
>>> -             }
>>> -     }
>>> -}
>>> -
>>>   int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev)
>>>   {
>>>       int err =3D 0;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_sdma.h
>>> index 513ac22120c1..173a2a308078 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
>>> @@ -169,7 +169,6 @@ int amdgpu_sdma_init_microcode(struct amdgpu_devi=
ce *adev, u32 instance,
>>>                              bool duplicate);
>>>   void amdgpu_sdma_destroy_inst_ctx(struct amdgpu_device *adev,
>>>           bool duplicate);
>>> -void amdgpu_sdma_unset_buffer_funcs_helper(struct amdgpu_device *ade=
v);
>>>   int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev);
>>>
>>>   #endif
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/=
amd/amdgpu/cik_sdma.c
>>> index ee5dce6f6043..a3fccc4c1f43 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
>>> @@ -308,8 +308,6 @@ static void cik_sdma_gfx_stop(struct amdgpu_devic=
e *adev)
>>>       u32 rb_cntl;
>>>       int i;
>>>
>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
>>> -
>>>       for (i =3D 0; i < adev->sdma.num_instances; i++) {
>>>               rb_cntl =3D RREG32(mmSDMA0_GFX_RB_CNTL + sdma_offsets[i=
]);
>>>               rb_cntl &=3D ~SDMA0_GFX_RB_CNTL__RB_ENABLE_MASK;
>>> @@ -498,9 +496,6 @@ static int cik_sdma_gfx_resume(struct amdgpu_devi=
ce *adev)
>>>               r =3D amdgpu_ring_test_helper(ring);
>>>               if (r)
>>>                       return r;
>>> -
>>> -             if (adev->mman.buffer_funcs_ring =3D=3D ring)
>>> -                     amdgpu_ttm_set_buffer_funcs_status(adev, true);=

>>>       }
>>>
>>>       return 0;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm=
/amd/amdgpu/sdma_v2_4.c
>>> index b58a13bd75db..45377a175250 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
>>> @@ -339,8 +339,6 @@ static void sdma_v2_4_gfx_stop(struct amdgpu_devi=
ce *adev)
>>>       u32 rb_cntl, ib_cntl;
>>>       int i;
>>>
>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
>>> -
>>>       for (i =3D 0; i < adev->sdma.num_instances; i++) {
>>>               rb_cntl =3D RREG32(mmSDMA0_GFX_RB_CNTL + sdma_offsets[i=
]);
>>>               rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, R=
B_ENABLE, 0);
>>> @@ -474,9 +472,6 @@ static int sdma_v2_4_gfx_resume(struct amdgpu_dev=
ice *adev)
>>>               r =3D amdgpu_ring_test_helper(ring);
>>>               if (r)
>>>                       return r;
>>> -
>>> -             if (adev->mman.buffer_funcs_ring =3D=3D ring)
>>> -                     amdgpu_ttm_set_buffer_funcs_status(adev, true);=

>>>       }
>>>
>>>       return 0;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm=
/amd/amdgpu/sdma_v3_0.c
>>> index c5ea32687eb5..2ad615be4bb3 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>>> @@ -513,8 +513,6 @@ static void sdma_v3_0_gfx_stop(struct amdgpu_devi=
ce *adev)
>>>       u32 rb_cntl, ib_cntl;
>>>       int i;
>>>
>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
>>> -
>>>       for (i =3D 0; i < adev->sdma.num_instances; i++) {
>>>               rb_cntl =3D RREG32(mmSDMA0_GFX_RB_CNTL + sdma_offsets[i=
]);
>>>               rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, R=
B_ENABLE, 0);
>>> @@ -746,9 +744,6 @@ static int sdma_v3_0_gfx_resume(struct amdgpu_dev=
ice *adev)
>>>               r =3D amdgpu_ring_test_helper(ring);
>>>               if (r)
>>>                       return r;
>>> -
>>> -             if (adev->mman.buffer_funcs_ring =3D=3D ring)
>>> -                     amdgpu_ttm_set_buffer_funcs_status(adev, true);=

>>>       }
>>>
>>>       return 0;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm=
/amd/amdgpu/sdma_v4_0.c
>>> index 683d51ae4bf1..3d68dd5523c6 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>>> @@ -877,8 +877,6 @@ static void sdma_v4_0_gfx_enable(struct amdgpu_de=
vice *adev, bool enable)
>>>       u32 rb_cntl, ib_cntl;
>>>       int i;
>>>
>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
>>> -
>>>       for (i =3D 0; i < adev->sdma.num_instances; i++) {
>>>               rb_cntl =3D RREG32_SDMA(i, mmSDMA0_GFX_RB_CNTL);
>>>               rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, R=
B_ENABLE, enable ? 1 : 0);
>>> @@ -913,8 +911,6 @@ static void sdma_v4_0_page_stop(struct amdgpu_dev=
ice *adev)
>>>       u32 rb_cntl, ib_cntl;
>>>       int i;
>>>
>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
>>> -
>>>       for (i =3D 0; i < adev->sdma.num_instances; i++) {
>>>               rb_cntl =3D RREG32_SDMA(i, mmSDMA0_PAGE_RB_CNTL);
>>>               rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_PAGE_RB_CNTL,
>>> @@ -1402,13 +1398,7 @@ static int sdma_v4_0_start(struct amdgpu_devic=
e *adev)
>>>                       r =3D amdgpu_ring_test_helper(page);
>>>                       if (r)
>>>                               return r;
>>> -
>>> -                     if (adev->mman.buffer_funcs_ring =3D=3D page)
>>> -                             amdgpu_ttm_set_buffer_funcs_status(adev=
, true);
>>>               }
>>> -
>>> -             if (adev->mman.buffer_funcs_ring =3D=3D ring)
>>> -                     amdgpu_ttm_set_buffer_funcs_status(adev, true);=

>>>       }
>>>
>>>       return r;
>>> @@ -1921,11 +1911,8 @@ static int sdma_v4_0_hw_fini(void *handle)
>>>       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>>>       int i;
>>>
>>> -     if (amdgpu_sriov_vf(adev)) {
>>> -             /* disable the scheduler for SDMA */
>>> -             amdgpu_sdma_unset_buffer_funcs_helper(adev);
>>> +     if (amdgpu_sriov_vf(adev))
>>>               return 0;
>>> -     }
>>>
>>>       if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA)) {
>>>               for (i =3D 0; i < adev->sdma.num_instances; i++) {
>>> @@ -1964,7 +1951,6 @@ static int sdma_v4_0_resume(void *handle)
>>>       if (adev->in_s0ix) {
>>>               sdma_v4_0_enable(adev, true);
>>>               sdma_v4_0_gfx_enable(adev, true);
>>> -             amdgpu_ttm_set_buffer_funcs_status(adev, true);
>>>               return 0;
>>>       }
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm=
/amd/amdgpu/sdma_v5_0.c
>>> index be5d099c9898..c78027ebdcb9 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>>> @@ -559,8 +559,6 @@ static void sdma_v5_0_gfx_stop(struct amdgpu_devi=
ce *adev)
>>>       u32 rb_cntl, ib_cntl;
>>>       int i;
>>>
>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
>>> -
>>>       for (i =3D 0; i < adev->sdma.num_instances; i++) {
>>>               rb_cntl =3D RREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offse=
t(adev, i, mmSDMA0_GFX_RB_CNTL));
>>>               rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, R=
B_ENABLE, 0);
>>> @@ -825,9 +823,6 @@ static int sdma_v5_0_gfx_resume(struct amdgpu_dev=
ice *adev)
>>>               r =3D amdgpu_ring_test_helper(ring);
>>>               if (r)
>>>                       return r;
>>> -
>>> -             if (adev->mman.buffer_funcs_ring =3D=3D ring)
>>> -                     amdgpu_ttm_set_buffer_funcs_status(adev, true);=

>>>       }
>>>
>>>       return 0;
>>> @@ -1426,11 +1421,8 @@ static int sdma_v5_0_hw_fini(void *handle)
>>>   {
>>>       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>>>
>>> -     if (amdgpu_sriov_vf(adev)) {
>>> -             /* disable the scheduler for SDMA */
>>> -             amdgpu_sdma_unset_buffer_funcs_helper(adev);
>>> +     if (amdgpu_sriov_vf(adev))
>>>               return 0;
>>> -     }
>>>
>>>       sdma_v5_0_ctx_switch_enable(adev, false);
>>>       sdma_v5_0_enable(adev, false);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm=
/amd/amdgpu/sdma_v5_2.c
>>> index a3e8b10c071c..2e35f3571774 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>>> @@ -364,8 +364,6 @@ static void sdma_v5_2_gfx_stop(struct amdgpu_devi=
ce *adev)
>>>       u32 rb_cntl, ib_cntl;
>>>       int i;
>>>
>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
>>> -
>>>       for (i =3D 0; i < adev->sdma.num_instances; i++) {
>>>               rb_cntl =3D RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offse=
t(adev, i, mmSDMA0_GFX_RB_CNTL));
>>>               rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, R=
B_ENABLE, 0);
>>> @@ -625,9 +623,6 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_dev=
ice *adev)
>>>               r =3D amdgpu_ring_test_helper(ring);
>>>               if (r)
>>>                       return r;
>>> -
>>> -             if (adev->mman.buffer_funcs_ring =3D=3D ring)
>>> -                     amdgpu_ttm_set_buffer_funcs_status(adev, true);=

>>>       }
>>>
>>>       return 0;
>>> @@ -1284,11 +1279,8 @@ static int sdma_v5_2_hw_fini(void *handle)
>>>   {
>>>       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>>>
>>> -     if (amdgpu_sriov_vf(adev)) {
>>> -             /* disable the scheduler for SDMA */
>>> -             amdgpu_sdma_unset_buffer_funcs_helper(adev);
>>> +     if (amdgpu_sriov_vf(adev))
>>>               return 0;
>>> -     }
>>>
>>>       sdma_v5_2_ctx_switch_enable(adev, false);
>>>       sdma_v5_2_enable(adev, false);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm=
/amd/amdgpu/sdma_v6_0.c
>>> index 445a34549d2c..1c6ff511f501 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>>> @@ -348,8 +348,6 @@ static void sdma_v6_0_gfx_stop(struct amdgpu_devi=
ce *adev)
>>>       u32 rb_cntl, ib_cntl;
>>>       int i;
>>>
>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
>>> -
>>>       for (i =3D 0; i < adev->sdma.num_instances; i++) {
>>>               rb_cntl =3D RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offse=
t(adev, i, regSDMA0_QUEUE0_RB_CNTL));
>>>               rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL=
, RB_ENABLE, 0);
>>> @@ -561,9 +559,6 @@ static int sdma_v6_0_gfx_resume(struct amdgpu_dev=
ice *adev)
>>>               r =3D amdgpu_ring_test_helper(ring);
>>>               if (r)
>>>                       return r;
>>> -
>>> -             if (adev->mman.buffer_funcs_ring =3D=3D ring)
>>> -                     amdgpu_ttm_set_buffer_funcs_status(adev, true);=

>>>       }
>>>
>>>       return 0;
>>> @@ -1308,11 +1303,8 @@ static int sdma_v6_0_hw_fini(void *handle)
>>>   {
>>>       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>>>
>>> -     if (amdgpu_sriov_vf(adev)) {
>>> -             /* disable the scheduler for SDMA */
>>> -             amdgpu_sdma_unset_buffer_funcs_helper(adev);
>>> +     if (amdgpu_sriov_vf(adev))
>>>               return 0;
>>> -     }
>>>
>>>       sdma_v6_0_ctxempty_int_enable(adev, false);
>>>       sdma_v6_0_enable(adev, false);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/am=
d/amdgpu/si_dma.c
>>> index 42c4547f32ec..9aa0e11ee673 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
>>> @@ -115,8 +115,6 @@ static void si_dma_stop(struct amdgpu_device *ade=
v)
>>>       u32 rb_cntl;
>>>       unsigned i;
>>>
>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
>>> -
>>>       for (i =3D 0; i < adev->sdma.num_instances; i++) {
>>>               /* dma0 */
>>>               rb_cntl =3D RREG32(DMA_RB_CNTL + sdma_offsets[i]);
>>> @@ -177,9 +175,6 @@ static int si_dma_start(struct amdgpu_device *ade=
v)
>>>               r =3D amdgpu_ring_test_helper(ring);
>>>               if (r)
>>>                       return r;
>>> -
>>> -             if (adev->mman.buffer_funcs_ring =3D=3D ring)
>>> -                     amdgpu_ttm_set_buffer_funcs_status(adev, true);=

>>>       }
>>>
>>>       return 0;
>>

--------------xfKh0LVuDhI7P0fnyQhc3Ab2
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

--------------xfKh0LVuDhI7P0fnyQhc3Ab2--

--------------8n8DIA0zDJQqsiE504hA2ULx--

--------------iE0Wl8FxUR5cHrLLffJmvm1R
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSZI+/lZhTvW3mgJddMFUeUMaM0rwUCZTrDZAUDAAAAAAAKCRBMFUeUMaM0r5cl
AP93u0Qj/dVaJmtJlfupVKlJtR/gC7z++TtcjOo3KxZLxwEAndG/WvGYQHmJEQjjGaNIQl5OEHXs
/SnLauU8Kc0j5gY=
=FOMP
-----END PGP SIGNATURE-----

--------------iE0Wl8FxUR5cHrLLffJmvm1R--
