Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67112C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Dec 2023 11:44:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03A5410E13C;
	Fri,  8 Dec 2023 11:44:00 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8E6D10E13C
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Dec 2023 11:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1702035833; x=1702640633; i=friedrich.vock@gmx.de;
 bh=/JDnU67Z3oBRfKZscn+atOhlIhW7ziGsvQ5bf+dmndw=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=EA9n10sbtfPbuLII7Xb8oR1JcmlodBkg337bsuFDT0lBwWHJ7h4p6LuBUseQlQ+0
 b4JfUlMQfJiYC4q8CNJdnoaHD4nTfLShkqSlKkSlVHhAcAVTD6U90ALSIOVX+cG1/
 x6FXmxkG8/Ey6zRqP86jYvapHqsGBCtdolAc6rCgmdif9XUe96/EybosEuZu2XPXB
 1zI/WENBbfqjYVeChC3WBGLL2QRKYs2EeFH7E1Wimpbb/6MpxKuF22XXmykQcpb6S
 eT1ZQ8ISMUNZNgHEXeEUZ8+kGqr7ImP+gzyfUh1tcx+wOAagNdPHUcQpIEQD/eyAz
 x1R3vzskwaJ8J2fwhA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.177.3] ([213.152.118.80]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2DxE-1rNNBP2QIw-013cgF; Fri, 08
 Dec 2023 12:43:53 +0100
Message-ID: <1939f568-f780-4e34-b5c5-dab461f93b57@gmx.de>
Date: Fri, 8 Dec 2023 12:43:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Enable tunneling on high-priority compute
 queues
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231202001740.120840-1-friedrich.vock@gmx.de>
 <3525f437-9537-4fb4-80d0-65acd9d55d2f@gmx.de>
 <3cf226b8-c80b-43f6-9f6c-9610d224717a@amd.com>
From: Friedrich Vock <friedrich.vock@gmx.de>
Autocrypt: addr=friedrich.vock@gmx.de; keydata=
 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
 f7+xmX0X3AMtWz/15Y+7cPO2
In-Reply-To: <3cf226b8-c80b-43f6-9f6c-9610d224717a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:442wV03+vk5kBHBolZLOYiFUSNAThGUihU+mZ6xbkOTsgUdRrbX
 4oR7FXgkFnaHT4QH9X6o38AL5EMRD5H2tHkVDsWM6CBvRgyVYu3JvAwfI0BIxH9HgGJW01H
 CPZXqYG0YBdsLsoCB3tfT8TDQ7Bre/jIuNEWpsfHg94pIF0Z/ubC5ccaZYkMv2trnl/ieav
 QQF0dI+WHsNgCUwMZlzuQ==
UI-OutboundReport: notjunk:1;M01:P0:MoaFK4L3QuE=;aEITo9PUzgl5DS1L4R2aAO5CWsp
 1ClAqKvyVrBJFXgem7/1rsHb7qVwYXc5BWQsyq6T7GJsE/TiVf5JEHRjyGIiPXtXONNOfKiuH
 qJ7Fj+97XFVPXALiCXWt/vCqmlr9aplzb0twahrnqpEZQno4dlB6qVNFa6qSdpK5wGaf5wjen
 Ni8tqCvWWWq+ff3LVKdsquOXmIPwEs5uH0v66t0JCvY8+5Q72yfI+ncu4lvd286PKpQtb4ZUb
 TSBw2cA6VuLewzF7hFZ+G4HZsXWid02etpWSVzCOnU485WLMK3FShaySbl17j5jVwasY4c4lC
 DBQnT/XTu2u0gbBb3Rpy6tl1iPwbi1znAbmKJUUZv7IkWTA8ss7nSZCybGq0y9jfZ4K4yccoE
 es6TUhuEgyrVbxTsZ6ymkLrT01YnSlda4hIaI56hM+wSk83eS0JRXKsCH84LP5yRXzriRd2Xv
 bKVAr8bcTaNjXP6VDWzB1eNL7gQ2mDknwq9vZcMiJK0XYvEcsmLc2VXp56MPAAj7kR65Q1zfw
 Bc//LOUoXCtXLeTjvjxnQxCH2nyci92UjhRnd7/eUy9HVL04WYQaQk0Ea5or6Q82BK806/Wpx
 YejPGGtl3RRNB7hthz1VIZL8xmr/fqaSCLgernL8gpDFljLCF7LMgiCi7LxmcqO2Xh2jORAxo
 rS0F1nnjryVoxC/4vCqSCoDPRnrBBdV0KVsI3QVVPp+a2Py1GSDfk0H2TY1wRXBMIqDFVsi+r
 dqx8tp3Lak1005GA6vApC7wT8oQLJOElaqZeUlZrs9I5zz+5rFrRo9OUBSMsGMiZnj5dAAGOj
 BFHBWwaM6DgJuZwq/LhBvAkNLhtWjU6kfHVCQLHRHrxAYvsUs9l8xnP4ajdVZoEYuL7JyDaJY
 gpBUd4aEFSbVX9RU7IES375nlP4pQM4pPXpTOm0Lm3Y6/jKzy0g98bzaAELlC4MjCUdrNA5S2
 ZBu9MEoPh+JjPocq8hhc19O2l5o=
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Marek Olsak <Marek.Olsak@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 08.12.23 10:51, Christian K=C3=B6nig wrote:
> Well longer story short Alex and I have been digging up the
> documentation for this and as far as we can tell this isn't correct.
Huh. I initially talked to Marek about this, adding him in Cc.
>
> You need to do quite a bit more before you can turn on this feature.
> What userspace side do you refer to?
I was referring to the Mesa merge request I made
(https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/26462).
If/When you have more details about what else needs to be done, feel
free to let me know.
I'm happy to expand this to add the rest of what's needed as well.

Thanks,
Friedrich

>
> Regards,
> Christian.
>
> Am 08.12.23 um 09:19 schrieb Friedrich Vock:
>> Friendly ping on this one.
>> Userspace side got merged, so would be great to land this patch too :)
>>
>> On 02.12.23 01:17, Friedrich Vock wrote:
>>> This improves latency if the GPU is already busy with other work.
>>> This is useful for VR compositors that submit highly latency-sensitive
>>> compositing work on high-priority compute queues while the GPU is busy
>>> rendering the next frame.
>>>
>>> Userspace merge request:
>>> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/26462
>>>
>>> Signed-off-by: Friedrich Vock <friedrich.vock@gmx.de>
>>> ---
>>> =C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 1 +
>>> =C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 10 ++++++----
>>> =C2=A0 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c=C2=A0=C2=A0 |=C2=A0 3 ++=
-
>>> =C2=A0 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c=C2=A0=C2=A0 |=C2=A0 3 ++=
-
>>> =C2=A0 4 files changed, 11 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index 9505dc8f9d69..4b923a156c4e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -790,6 +790,7 @@ struct amdgpu_mqd_prop {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t eop_gpu_addr;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t hqd_pipe_priority;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t hqd_queue_priority;
>>> +=C2=A0=C2=A0=C2=A0 bool allow_tunneling;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool hqd_active;
>>> =C2=A0 };
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> index 231d49132a56..4d98e8879be8 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> @@ -620,6 +620,10 @@ static void amdgpu_ring_to_mqd_prop(struct
>>> amdgpu_ring *ring,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_mq=
d_prop *prop)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_device *adev =3D ring->ad=
ev;
>>> +=C2=A0=C2=A0=C2=A0 bool is_high_prio_compute =3D ring->funcs->type =
=3D=3D
>>> AMDGPU_RING_TYPE_COMPUTE &&
>>> + amdgpu_gfx_is_high_priority_compute_queue(adev, ring);
>>> +=C2=A0=C2=A0=C2=A0 bool is_high_prio_gfx =3D ring->funcs->type =3D=3D
>>> AMDGPU_RING_TYPE_GFX &&
>>> + amdgpu_gfx_is_high_priority_graphics_queue(adev, ring);
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset(prop, 0, sizeof(*prop));
>>>
>>> @@ -637,10 +641,8 @@ static void amdgpu_ring_to_mqd_prop(struct
>>> amdgpu_ring *ring,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prop->hqd_active =3D ring->funcs->type =
=3D=3D AMDGPU_RING_TYPE_KIQ;
>>>
>>> -=C2=A0=C2=A0=C2=A0 if ((ring->funcs->type =3D=3D AMDGPU_RING_TYPE_COM=
PUTE &&
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 amdgpu_gfx_is_high_p=
riority_compute_queue(adev, ring)) ||
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (ring->funcs->type =3D=3D =
AMDGPU_RING_TYPE_GFX &&
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 amdgpu_gfx_is_high_p=
riority_graphics_queue(adev, ring))) {
>>> +=C2=A0=C2=A0=C2=A0 prop->allow_tunneling =3D is_high_prio_compute;
>>> +=C2=A0=C2=A0=C2=A0 if (is_high_prio_compute || is_high_prio_gfx) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prop->hqd_pipe_=
priority =3D AMDGPU_GFX_PIPE_PRIO_HIGH;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prop->hqd_queue=
_priority =3D AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> index c8a3bf01743f..73f6d7e72c73 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> @@ -6593,7 +6593,8 @@ static int gfx_v10_0_compute_mqd_init(struct
>>> amdgpu_device *adev, void *m,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CO=
NTROL, ENDIAN_SWAP, 1);
>>> =C2=A0 #endif
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CO=
NTROL, UNORD_DISPATCH, 0);
>>> -=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNN=
EL_DISPATCH, 0);
>>> +=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNN=
EL_DISPATCH,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 prop->allow_tunneling);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CO=
NTROL, PRIV_STATE, 1);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CO=
NTROL, KMD_QUEUE, 1);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mqd->cp_hqd_pq_control =3D tmp;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> index c659ef0f47ce..bdcf96df69e6 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> @@ -3847,7 +3847,8 @@ static int gfx_v11_0_compute_mqd_init(struct
>>> amdgpu_device *adev, void *m,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CO=
NTROL, RPTR_BLOCK_SIZE,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) =
- 1));
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CO=
NTROL, UNORD_DISPATCH, 0);
>>> -=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNN=
EL_DISPATCH, 0);
>>> +=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNN=
EL_DISPATCH,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 prop->allow_tunneling);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CO=
NTROL, PRIV_STATE, 1);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CO=
NTROL, KMD_QUEUE, 1);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mqd->cp_hqd_pq_control =3D tmp;
>>> --
>>> 2.43.0
>>>
>
