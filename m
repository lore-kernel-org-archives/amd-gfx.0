Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55DF7C3DA5D
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jul 2024 19:52:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD4A989FD4;
	Mon, 22 Jul 2024 19:52:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W4f8FKvL";
	dkim-atps=neutral
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C661D89FD4
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jul 2024 19:52:49 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-70d1c655141so1188096b3a.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jul 2024 12:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721677969; x=1722282769; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4WVCiQ8RaVA2ELPEfdidkAogvXvtozPdYuxPz33iDSw=;
 b=W4f8FKvLiZ3g0rSZ2X55LcMDJWhvruYzHLlQjxZczmhOrnlaeIpGrhZFTSkC427J6j
 1x7KYyJHApefG3HXRQ7ksg9JopioRkVpz4CQyOAtA3wk0ZH5JGm9s4f+OoA8wMBWgP+a
 +cI7iXskbiigTE2GCVLT+Y6n1/WUEf5J/uddhJpXvAiK6EWkuavEiogjSftKXzpceS93
 BK3rsDjqpXpTwSiGb531HNbvqBntL6cTYZJAqxQdNtzE1hiEq9KdcmM0fCw4KMhZ9Qih
 Lse+tMmhZkvlB5autbZM01iHcFKUzRWsj31Gjp0aJTCb81AQW27qFcUWt+2DfAOHLgYR
 hKmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721677969; x=1722282769;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4WVCiQ8RaVA2ELPEfdidkAogvXvtozPdYuxPz33iDSw=;
 b=XS9Yur0Iml/YAM07t1WYYFoIxU6a4WrWZme5jlf6UNFZ0jW5t+rgKA92Zdrmm2adk6
 961rsg1lxMozKF22BsVjEXeS44I4sG6TISOlM0/EsxGMR9eR8Ub1Y2YUUd+I3+L8BnpJ
 A6t1qyLANwl27S1VMApLcqOFTSLw+J8IMKEs7mvzaxsMkAylxbZqBrdLY7Eb3QATl4KZ
 9yHjDtYBxlKVgX9vmfpQUkZPJxHQWktHrq7/UEix0I/MX6EbY/QlJHjqAzrgMjjSlBZi
 A8p3wgFv3bmpcqc+Y6TC9tTY9RGd+PwLHj6TGlQN3K15g7TzqZS1JVpLWF7kvBS7CGb2
 JYPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaW9jr8uqc7jmmIfBXOFHn13l9GcVvo/SvE3+f917yz6fR9/uJEJiSbT+UhAJ4vfRbUB5EPKtS2BLAkx8nc9niS0eFet/e3CYcDOfXRw==
X-Gm-Message-State: AOJu0YzywY2WdSRzL0WDBQrrRCpIwIrltl/Qv1sa7nf+4NMIF6NGjH2h
 yd59Jk08ObzFTIiuuu+p1ABeERwWRqw3mZdYqfIXaYsbKDU1KJT2pEM+ltC+xB/9unjQJzQtufX
 mmlOTIV1PI4WQw4YegKi0BC+lGaPLA8GE
X-Google-Smtp-Source: AGHT+IHyBS9YZZRpTi3ENeeDOXBOypAewQMpUsb6gBLBZgOxaq7TtjkNYK4Wu+po11jLIlvTZGebxA3u/Ln76hGowWs=
X-Received: by 2002:a05:6a21:3398:b0:1c2:9643:2921 with SMTP id
 adf61e73a8af0-1c4285b759fmr5837975637.10.1721677969049; Mon, 22 Jul 2024
 12:52:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240719091615.1534436-1-Jack.Xiao@amd.com>
 <bfca2c44-9e40-4e04-bfcf-1285b3552707@gmail.com>
 <PH8PR12MB68417B9F856C92BD02912A08EFA82@PH8PR12MB6841.namprd12.prod.outlook.com>
 <92f00b1c-79c2-431b-b8dc-70070a65b14a@gmail.com>
 <PH8PR12MB6841A6DA262E07EF7317FE72EFA82@PH8PR12MB6841.namprd12.prod.outlook.com>
 <87d19441-ac19-4b79-a7d8-6980840f0f19@gmail.com>
In-Reply-To: <87d19441-ac19-4b79-a7d8-6980840f0f19@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 22 Jul 2024 15:52:37 -0400
Message-ID: <CADnq5_POpPNcaBqV6rH94T7K_rEiGJ9xSry2TKXAhmmTem++aA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/mes: fix mes ring buffer overflow
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Does this patch fix it?
https://patchwork.freedesktop.org/patch/605437/

Alex

On Mon, Jul 22, 2024 at 7:21=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> What I meant is that the MES ring is now to small for the number of packe=
ts written to it.
>
> Either reduce the num_hw_submission or increase the MES ring size.
>
> E.g. see this code here in amdgpu_ring_init:
>
>         if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_KIQ)
>                 sched_hw_submission =3D max(sched_hw_submission, 256);
>         else if (ring =3D=3D &adev->sdma.instance[0].page)
>                 sched_hw_submission =3D 256;
>
> We are basically just missing a case for the MES here as far as I can see=
.
>
> Regards,
> Christian.
>
> Am 22.07.24 um 10:46 schrieb Xiao, Jack:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>
> >> Can you try to reduce num_hw_submission for the MES ring?
>
> Smaller num_hw_submission should not help for this issue, for Mes work wi=
thout drm scheduler like legacy kiq. Smaller num_hw_submission will result =
in smaller mes ring size and more waiting time.
>
> Regards,
> Jack
> ________________________________
> From: Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>
> Sent: Monday, 22 July 2024 16:20
> To: Xiao, Jack <Jack.Xiao@amd.com>; amd-gfx@lists.freedesktop.org <amd-gf=
x@lists.freedesktop.org>; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH] drm/amdgpu/mes: fix mes ring buffer overflow
>
> Thx, but in that case this patch here then won't help either it just miti=
gates the problem.
>
> Can you try to reduce num_hw_submission for the MES ring?
>
> Thanks,
> Christian.
>
> Am 22.07.24 um 05:27 schrieb Xiao, Jack:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>
> >> I think we rather need to increase the MES ring size instead.
>
> Unfortunately, it doesn't work. I guess mes firmware has limitation.
>
> Regards,
> Jack
>
> ________________________________
> From: Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>
> Sent: Friday, 19 July 2024 23:44
> To: Xiao, Jack <Jack.Xiao@amd.com>; amd-gfx@lists.freedesktop.org <amd-gf=
x@lists.freedesktop.org>; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH] drm/amdgpu/mes: fix mes ring buffer overflow
>
> Am 19.07.24 um 11:16 schrieb Jack Xiao:
> > wait memory room until enough before writing mes packets
> > to avoid ring buffer overflow.
> >
> > Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 18 ++++++++++++++----
> >   drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 18 ++++++++++++++----
> >   2 files changed, 28 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/a=
md/amdgpu/mes_v11_0.c
> > index 8ce51b9236c1..68c74adf79f1 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> > @@ -168,7 +168,7 @@ static int mes_v11_0_submit_pkt_and_poll_completion=
(struct amdgpu_mes *mes,
> >        const char *op_str, *misc_op_str;
> >        unsigned long flags;
> >        u64 status_gpu_addr;
> > -     u32 status_offset;
> > +     u32 seq, status_offset;
> >        u64 *status_ptr;
> >        signed long r;
> >        int ret;
> > @@ -196,6 +196,13 @@ static int mes_v11_0_submit_pkt_and_poll_completio=
n(struct amdgpu_mes *mes,
> >        if (r)
> >                goto error_unlock_free;
> >
> > +     seq =3D ++ring->fence_drv.sync_seq;
> > +     r =3D amdgpu_fence_wait_polling(ring,
> > +                                   seq - ring->fence_drv.num_fences_ma=
sk,
> > +                                   timeout);
> > +     if (r < 1)
> > +             goto error_undo;
> > +
> >        api_status =3D (struct MES_API_STATUS *)((char *)pkt + api_statu=
s_off);
> >        api_status->api_completion_fence_addr =3D status_gpu_addr;
> >        api_status->api_completion_fence_value =3D 1;
> > @@ -208,8 +215,7 @@ static int mes_v11_0_submit_pkt_and_poll_completion=
(struct amdgpu_mes *mes,
> >        mes_status_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
> >        mes_status_pkt.api_status.api_completion_fence_addr =3D
> >                ring->fence_drv.gpu_addr;
> > -     mes_status_pkt.api_status.api_completion_fence_value =3D
> > -             ++ring->fence_drv.sync_seq;
> > +     mes_status_pkt.api_status.api_completion_fence_value =3D seq;
> >
> >        amdgpu_ring_write_multiple(ring, &mes_status_pkt,
> >                                   sizeof(mes_status_pkt) / 4);
> > @@ -229,7 +235,7 @@ static int mes_v11_0_submit_pkt_and_poll_completion=
(struct amdgpu_mes *mes,
> >                dev_dbg(adev->dev, "MES msg=3D%d was emitted\n",
> >                        x_pkt->header.opcode);
> >
> > -     r =3D amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq, t=
imeout);
> > +     r =3D amdgpu_fence_wait_polling(ring, seq, timeout);
> >        if (r < 1 || !*status_ptr) {
> >
> >                if (misc_op_str)
> > @@ -252,6 +258,10 @@ static int mes_v11_0_submit_pkt_and_poll_completio=
n(struct amdgpu_mes *mes,
> >        amdgpu_device_wb_free(adev, status_offset);
> >        return 0;
> >
> > +error_undo:
> > +     dev_err(adev->dev, "MES ring buffer is full.\n");
> > +     amdgpu_ring_undo(ring);
> > +
> >   error_unlock_free:
> >        spin_unlock_irqrestore(&mes->ring_lock, flags);
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/a=
md/amdgpu/mes_v12_0.c
> > index c9f74231ad59..48e01206bcc4 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> > @@ -154,7 +154,7 @@ static int mes_v12_0_submit_pkt_and_poll_completion=
(struct amdgpu_mes *mes,
> >        const char *op_str, *misc_op_str;
> >        unsigned long flags;
> >        u64 status_gpu_addr;
> > -     u32 status_offset;
> > +     u32 seq, status_offset;
> >        u64 *status_ptr;
> >        signed long r;
> >        int ret;
> > @@ -182,6 +182,13 @@ static int mes_v12_0_submit_pkt_and_poll_completio=
n(struct amdgpu_mes *mes,
> >        if (r)
> >                goto error_unlock_free;
> >
> > +     seq =3D ++ring->fence_drv.sync_seq;
> > +     r =3D amdgpu_fence_wait_polling(ring,
> > +                                   seq - ring->fence_drv.num_fences_ma=
sk,
>
> That's what's amdgpu_fence_emit_polling() does anyway.
>
> So this here just moves the polling a bit earlier.
>
> I think we rather need to increase the MES ring size instead.
>
> Regards,
> Christian.
>
>
> > +                                   timeout);
> > +     if (r < 1)
> > +             goto error_undo;
> > +
> >        api_status =3D (struct MES_API_STATUS *)((char *)pkt + api_statu=
s_off);
> >        api_status->api_completion_fence_addr =3D status_gpu_addr;
> >        api_status->api_completion_fence_value =3D 1;
> > @@ -194,8 +201,7 @@ static int mes_v12_0_submit_pkt_and_poll_completion=
(struct amdgpu_mes *mes,
> >        mes_status_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
> >        mes_status_pkt.api_status.api_completion_fence_addr =3D
> >                ring->fence_drv.gpu_addr;
> > -     mes_status_pkt.api_status.api_completion_fence_value =3D
> > -             ++ring->fence_drv.sync_seq;
> > +     mes_status_pkt.api_status.api_completion_fence_value =3D seq;
> >
> >        amdgpu_ring_write_multiple(ring, &mes_status_pkt,
> >                                   sizeof(mes_status_pkt) / 4);
> > @@ -215,7 +221,7 @@ static int mes_v12_0_submit_pkt_and_poll_completion=
(struct amdgpu_mes *mes,
> >                dev_dbg(adev->dev, "MES msg=3D%d was emitted\n",
> >                        x_pkt->header.opcode);
> >
> > -     r =3D amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq, t=
imeout);
> > +     r =3D amdgpu_fence_wait_polling(ring, seq, timeout);
> >        if (r < 1 || !*status_ptr) {
> >
> >                if (misc_op_str)
> > @@ -238,6 +244,10 @@ static int mes_v12_0_submit_pkt_and_poll_completio=
n(struct amdgpu_mes *mes,
> >        amdgpu_device_wb_free(adev, status_offset);
> >        return 0;
> >
> > +error_undo:
> > +     dev_err(adev->dev, "MES ring buffer is full.\n");
> > +     amdgpu_ring_undo(ring);
> > +
> >   error_unlock_free:
> >        spin_unlock_irqrestore(&mes->ring_lock, flags);
> >
>
>
>
