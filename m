Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A23EAFCC062
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 20:36:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24E4310E3F5;
	Fri,  6 Mar 2026 20:36:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="njHPMEks";
	dkim-atps=neutral
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25A7710E3F5
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 20:36:32 +0000 (UTC)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-124a55b7bfbso306041c88.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Mar 2026 12:36:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772829391; cv=none;
 d=google.com; s=arc-20240605;
 b=NZ63fqfZoDpILkAYyarpbTpVMuzzEEO6DgpkVkzYSUlilJQTG9FcHTFol9g1TTBnJh
 36OmsyTJWZCtW8fOSXdO+MRBizHagf/W08Ot9P55uQyFtfJwaGeyNazhgg2NTtM9+pQh
 G+TSjt66HZ1Ori2DhU4qzFo9O8lZxXpOgYWUSeVnRu3rWxSLE1RtC8lMPYkbbSxojfZd
 PtGy0jzPQglSnvxht4CspTkDGcq9bRNyRBgv09KOIEV3j8R5QC5VxgAnlRg14vFBTR8Z
 lMmyJ9QR4kZC2PF2S1S/jl9MV51rB5/fSQrnrzO+7kgrN+TNMNajOJ19Qxqkb8X/R42u
 FxDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aUY0QvC3kE6cfPdq0xNCzkLSqWD4lSp92+Uk5iqI9vk=;
 fh=vmG5S7+njx2NFPmoBk8s5rIvBsA9VPEl63PreGrEDGg=;
 b=VDxj2u2VHdWaMbw9wirRorTJky5JnupdcrRq4HfOeBAfhSWEMk3O0Xd93EDSxMkZPV
 0WyVdT08vXkTmt97OIl42oAhkKpzM/yLNwHURJJGY4vp9WdZdNFDg4m2bk6eRcg/MB/L
 BRnugf5sjz49NXGFIdWJW0ZikylCIodBUo0W7bD+G7eGJ4VUcpZt2Dt0YUtGes9jhUzp
 BF/UELHvgy9Ri/UmN1LQ15dAThJxKmfShvXnAVCGmV0RTDr7VPmM7mPJ5AuGLlwikUAp
 KNDCB6Rhp56envRG1kVpwjOAJ+qag+vetcL6NM9n/oaDHiCcRlEqZjhyEXFGOuOwzsbI
 SY7w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772829391; x=1773434191; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aUY0QvC3kE6cfPdq0xNCzkLSqWD4lSp92+Uk5iqI9vk=;
 b=njHPMEksGNslpT7oJL1FNtcSSMeyC0bXdvYoIJ0C5DW+Nea+YxP6SrJyDobbo+gzYI
 fPvP2CJscICuYIEUqA2RygmwdE01fU6CSLGJWsb3QNi9U+7dV+6CMhag+N9vpF+bTkQC
 klOxO1+pqqPQiF6GXWbjbIkY+qMFfPIZxXJwmukXYi+ilhQDTa1jPJdKza+MNpNs2xKR
 GregKB7QkHSCJ7LREZtqf+SgqAzs2Pul+Q/HQXrNy673g7C6SzXMLp/YgXETeO/1e3yc
 GUvaUWKZhL9nxQ7DNoYpt2ncEUwA90x2AH5Jy5hKkBUDQJshXbuuzCbbBJ+X3nW0+CIS
 fJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772829391; x=1773434191;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aUY0QvC3kE6cfPdq0xNCzkLSqWD4lSp92+Uk5iqI9vk=;
 b=REoo0J1VYI/7jdTP5G9ovoW7pNPWdy5QWC/UpqkciUSM1j6GdClvgSg4vSKsG1B7dk
 7LR13fpHzkF8+ged8dhZRcrnk14O3r5VaRsAH0hP1YYpxZc2jGUfkKwEnhI3taCf1ZRs
 iCBTeEqe60A83jeGTK37OW3wXWEZelV5TYJ2wWpmkknLn+amOWrfHACLozzCDrnKqEJC
 hE6pVJoZpGgPuwaChvlM031BF4JwuXC/y4k5dKfqQ2Fjk1VyBkLgNFcD7ydB0GTLevid
 3EaWOz2PDZPTO55Iwkr1CXy0Xz14dmxOoVLjoyQW4Qjr2jDNg02TUZE7r2E6SW1MHl0j
 xatQ==
X-Gm-Message-State: AOJu0YweswC7Zdl3mzvTmWE/xz87iJhohShKor48XDugU/ArfcDojdl3
 u/GTR32/qP+ToEdzmkM7Z3rPtvohHracY2Ar0grHjgXWZHRPZU6bniMogEG8Zt+fHiHD/of1lb0
 06Ds6FfiKqZRaDq3cIxHVkubsPzw3xGQ=
X-Gm-Gg: ATEYQzxL4rIoQ4ToCgZWUFLRZMlrz6S1hAP0patbAwAfSzgWZrUSqDyAQz+WNTUdS7e
 YpnlvhHxEYAKirvNLsql0uJKb8l/hpuH741jK51xF9H5365snPpH5zKvcLUMlso47xXZ2ODXgoc
 gHPP0rf3jbq732LmBlvCGYGcMQeqDaFjU2KrfT6iogdMOCa+jbqvAsY5PfKSiSxPS90UGWBDAlD
 ggCXWKMXb4GL1HKhOkvdAGmWno5UJ47KCWMHCQDF1btSFfLvMxHJsRs/ukcsKtSHwI3PKdTMTLv
 GjvtfnjRKc1pB7A8WPOlBvYOKVHE6iqxT6hTBLKpx4yWTq9g2M6oztdOxIxIMcQkyGo8OA==
X-Received: by 2002:a05:7300:bc8a:b0:2bd:db75:c283 with SMTP id
 5a478bee46e88-2be4e0ebd6cmr595178eec.8.1772829391209; Fri, 06 Mar 2026
 12:36:31 -0800 (PST)
MIME-Version: 1.0
References: <20260303161921.435188-1-Chenglei.Xie@amd.com>
 <CADnq5_OCRm7oVkr7TY_OCyfSnkPJXAY7ZhjThpEbAauQNz_T_g@mail.gmail.com>
 <SJ1PR12MB61217A1E333E25490C325B8B807AA@SJ1PR12MB6121.namprd12.prod.outlook.com>
In-Reply-To: <SJ1PR12MB61217A1E333E25490C325B8B807AA@SJ1PR12MB6121.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 6 Mar 2026 15:36:19 -0500
X-Gm-Features: AaiRm532LDDOWqsGqlGe-J6E8IEZ-Csbsr9g1CSkeUKGtgT25MR-_eXYFtUw9b0
Message-ID: <CADnq5_Pr3EWLHr5sPjAq=b7yJhcEDJ_vadoUuiF7SSXJELbT6g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix KIQ fence timeout after GPU reset on GFX
 v9.4.3
To: "Xie, Chenglei" <Chenglei.Xie@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Chan,
 Hing Pong" <Jeffrey.Chan@amd.com>, 
 "Luo, Zhigang" <Zhigang.Luo@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
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

On Fri, Mar 6, 2026 at 3:26=E2=80=AFPM Xie, Chenglei <Chenglei.Xie@amd.com>=
 wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi Alex,
>
> amdgpu_fence_driver_force_completion() is working but it was called prior=
 to GPU reset.
>
> However, in this failing case, during a GPU reset, the KIQ ring is still =
used (e.g. for HDP flush in amdgpu_kiq_hdp_flush()). Each of those submissi=
ons emits a fence and increments sync_seq. The hardware queue is later clea=
red by the reset and never runs those commands, so it never updates the fen=
ce writeback location. After reset, the writeback memory still holds the la=
st value written before reset while sync_seq has moved far ahead.

Sounds like a bug in the reset sequence.  We should fix that so that
we don't use KIQ during the reset.

Alex

>
> Before emitting a new fence, amdgpu_fence_emit_polling() waits until the =
oldest in-flight fence is done: it calls amdgpu_fence_wait_polling(ring, se=
q - ring->fence_drv.num_fences_mask, timeout), which busy waits until the w=
riteback value is at least that sequence. Because the writeback value is st=
ill near the pre-reset value and sync_seq has grown, the required sequence =
(sync_seq - num_fences_mask) is much larger than the writeback value. The d=
river therefore waits for completion of fences that were lost in the reset =
and will never complete, the wait hits the timeout, and amdgpu_fence_emit_p=
olling() returns -ETIMEDOUT. The driver then refuses to emit new KIQ fences=
, assuming the ring is full, and KIQ submissions effectively stall.
>
> To fix this, when re-initializing the KIQ after a reset, the code now set=
s the fence writeback memory to sync_seq. So it no longer waits for those l=
ost fences. amdgpu_fence_emit_polling() can then emit new fences without ti=
ming out, and KIQ usage resumes after reset.
>
> Regards,
> Chenglei
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Friday, March 6, 2026 11:18 AM
> To: Xie, Chenglei <Chenglei.Xie@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Chan, Hing Pong <Jeffrey.Chan@amd.com>=
; Luo, Zhigang <Zhigang.Luo@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com=
>
> Subject: Re: [PATCH] drm/amdgpu: Fix KIQ fence timeout after GPU reset on=
 GFX v9.4.3
>
> [You don't often get email from alexdeucher@gmail.com. Learn why this is =
important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On Tue, Mar 3, 2026 at 11:29=E2=80=AFAM Chenglei Xie <Chenglei.Xie@amd.co=
m> wrote:
> >
> > After GPU reset, the hardware queue is cleared and all pending fences
> > are lost. However, the fence writeback memory remains stale from
> > before reset, while software continues emitting fences and sync_seq
> > keeps incrementing. This causes amdgpu_fence_emit_polling() to wait
> > for fences that were lost during reset, resulting in -ETIMEDOUT errors.
> >
> > Fix this by updating the fence writeback memory to match sync_seq
> > after GPU reset in gfx_v9_4_3_xcc_kiq_init_queue(). This aligns the
> > hardware's view of completed fences with software's view of emitted
> > fences, preventing timeouts when waiting for fences that no longer exis=
t.
> >
> > Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
> > Change-Id: I717df52ed0ef0bb51a6901f218191d9837a77f6f
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> > index ad4d442e7345e..6b5fcdd987693 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> > @@ -2135,6 +2135,15 @@ static int gfx_v9_4_3_xcc_kiq_init_queue(struct =
amdgpu_ring *ring, int xcc_id)
> >                 gfx_v9_4_3_xcc_kiq_init_register(ring, xcc_id);
> >                 soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_id=
));
> >                 mutex_unlock(&adev->srbm_mutex);
> > +
> > +               /* Update fence writeback memory to align with software=
 state after reset.
> > +                * After GPU reset, the hardware queue is cleared and a=
ll pending fences
> > +                * are lost. The fence writeback memory may be stale fr=
om before reset. To prevent
> > +                * waiting for lost fences, update writeback memory to =
match sync_seq.
> > +                * This avoids waiting for lost fences and prevents tim=
eouts.
> > +                */
>
> This doesn't make sense.  No other kiq_init_queue() function does this.  =
When the GPU is reset, amdgpu_fence_driver_force_completion()
> should get called for each ring.  That will set an error on the fence and=
 update the fence sequence.  Why is that not working?
>
> Alex
>
> > +                if (ring->fence_drv.cpu_addr)
> > +                       *ring->fence_drv.cpu_addr =3D
> > + cpu_to_le32(ring->fence_drv.sync_seq);
> >         } else {
> >                 memset((void *)mqd, 0, sizeof(struct v9_mqd_allocation)=
);
> >                 ((struct v9_mqd_allocation *)mqd)->dynamic_cu_mask =3D
> > 0xFFFFFFFF;
> > --
> > 2.34.1
> >
