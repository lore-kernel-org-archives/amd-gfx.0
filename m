Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94DB2C36008
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 13:58:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2589C10E12B;
	Wed, 26 Mar 2025 13:58:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B3Wlruqs";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8630510E12B
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 13:58:32 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-301a8b7398cso1762571a91.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 06:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742997512; x=1743602312; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o2PpA+q2rxN+MHEijxWAUlfzbLWiP2cp7ZIvu/wDIbQ=;
 b=B3WlruqsqwDxfr9UZHVYPTpEtEohm+VPFlfVu2q3adwqeU5GOfInpEnSWlyKzQLNXd
 unnd2bRO4rxjYy4AIwm81aNstIgJMPtAj11uA+w0HoxoSOnSAxPP+lKxO1DJWvRmroEN
 vTjdUCEmrLT/KldZdwdscmjc6QnSAbsKdY1tN0JqcY+mq74hB2951FRIeVkzp0ro/JeI
 0GVvSDT3y7PYtHw14H4t+MACTNbK354Nsaw/sUyCG0xDs7h57m+A5KvJjhIk9U7geGcn
 i+pAMgXrq7xP8+7U2aZNDlj/aqQZwJqWiwgo4JDLao8NfeTmeKVDxNcNI9OJJ+Pk+yoi
 vutg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742997512; x=1743602312;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o2PpA+q2rxN+MHEijxWAUlfzbLWiP2cp7ZIvu/wDIbQ=;
 b=h3YxiG5G0+TprtlVwv86QyBzgH7Dz3sviIfOXK1zGyr25EXUJ0ou0Iljx3ISkrR533
 WDKiue9W4RyraiqxbENnneBexeWXNSZtRk3bp9hKbwyvOY/mzmwJllTginUE8P4cW7re
 1CSjZvaaQ6rGRzbO6ZnvcmkeGTRt1b5OfE9xUkq60hF3Gda9SlqLSUgtStdZuNRnUGbk
 Cca3gOQZbcmoQ/aXcOxwq/6UId7d7Yjp1051H42GRieafoxxX9Es2PNS5wEdRLu2QB5z
 HKd/pmjI76Wv6ZJE44UtecEnJSlZlaM3DvASKH18waHddZj1QrwGIR7YgJGkH5/zBggx
 S+tA==
X-Gm-Message-State: AOJu0YxxlTqz62mcxpJ9ssYyPcsp2R55Rrfw3rPtee7BrfckfC88NF2V
 rmOmLs0tNCbUHwA1ktJABV5BZgND70vzrOOg+PU28hliptLCINr68QZ7sPRi0jCUwo5+TVyHbpg
 ZcrHkC7G+TOALzTc3zty2B7sxfKk=
X-Gm-Gg: ASbGncuOt1s1Ynrr2CWblt5WopctX/43r0JCzjNXKDUJIP4uCmaCcUz30PZJEpsy53s
 tgKDuFl08Ev9uS47Picj1Uxr2a/bz2JnWSrB2ZvCPq43GtTBjG7iRiDCqw9ann2TXhF4w0O1M0S
 HXIzbiwVmSgRqhRBEny7FXKfE+DA==
X-Google-Smtp-Source: AGHT+IFCJT0sXr4sea7a0CJCdmJd5tX95awQ2g3JcgWnlJaYlZhkH44gvosEucUdEbqxlLTYU4WEm9M/0mEMQ2BFez8=
X-Received: by 2002:a17:90a:e7cc:b0:2fe:7f51:d2ec with SMTP id
 98e67ed59e1d1-3030fb1fff3mr12332206a91.0.1742997511587; Wed, 26 Mar 2025
 06:58:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250320203549.1345822-1-alexander.deucher@amd.com>
 <CADnq5_O_hotchYfpWvcatLTL6_s1YJD2qBwL5yqvXkhDQ2+swg@mail.gmail.com>
In-Reply-To: <CADnq5_O_hotchYfpWvcatLTL6_s1YJD2qBwL5yqvXkhDQ2+swg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 Mar 2025 09:58:19 -0400
X-Gm-Features: AQ5f1JpxYoCJGUklAUiEfa2t_cbrtUB96u1mj0hCxa0DVvsBFC1Kt0pgp1nHqoU
Message-ID: <CADnq5_OO98WVP2Nbo=WBayd4q6b=OL_9QpFycd0vK3wiomNFCA@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu/gfx: make amdgpu_gfx_me_queue_to_bit()
 static
To: Alex Deucher <alexander.deucher@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

+ Sunil to review this series


On Mon, Mar 24, 2025 at 3:48=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> ping on this series?
>
> On Thu, Mar 20, 2025 at 4:36=E2=80=AFPM Alex Deucher <alexander.deucher@a=
md.com> wrote:
> >
> > It's not used outside of amdgpu_gfx.c.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 4 ++--
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 2 --
> >  2 files changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gfx.c
> > index 72af5e5a894a2..04982b7f33a8a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > @@ -74,8 +74,8 @@ bool amdgpu_gfx_is_mec_queue_enabled(struct amdgpu_de=
vice *adev,
> >                         adev->gfx.mec_bitmap[xcc_id].queue_bitmap);
> >  }
> >
> > -int amdgpu_gfx_me_queue_to_bit(struct amdgpu_device *adev,
> > -                              int me, int pipe, int queue)
> > +static int amdgpu_gfx_me_queue_to_bit(struct amdgpu_device *adev,
> > +                                     int me, int pipe, int queue)
> >  {
> >         int bit =3D 0;
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gfx.h
> > index 75af4f25a133b..319e6e547c734 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > @@ -551,8 +551,6 @@ bool amdgpu_gfx_is_high_priority_compute_queue(stru=
ct amdgpu_device *adev,
> >                                                struct amdgpu_ring *ring=
);
> >  bool amdgpu_gfx_is_high_priority_graphics_queue(struct amdgpu_device *=
adev,
> >                                                 struct amdgpu_ring *rin=
g);
> > -int amdgpu_gfx_me_queue_to_bit(struct amdgpu_device *adev, int me,
> > -                              int pipe, int queue);
> >  bool amdgpu_gfx_is_me_queue_enabled(struct amdgpu_device *adev, int me=
,
> >                                     int pipe, int queue);
> >  void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable);
> > --
> > 2.49.0
> >
