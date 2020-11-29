Return-Path: <SRS0=tlEs=FD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266C0C63777
	for <amd-gfx@archiver.kernel.org>; Sun, 29 Nov 2020 00:38:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E206D20857
	for <amd-gfx@archiver.kernel.org>; Sun, 29 Nov 2020 00:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=basnieuwenhuizen.nl header.i=@basnieuwenhuizen.nl header.b="ENmxCtbn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E206D20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 035156E118;
	Sun, 29 Nov 2020 00:38:23 +0000 (UTC)
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com
 [IPv6:2607:f8b0:4864:20::d41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 127466E118
 for <amd-gfx@lists.freedesktop.org>; Sun, 29 Nov 2020 00:38:21 +0000 (UTC)
Received: by mail-io1-xd41.google.com with SMTP id u21so8235748iol.12
 for <amd-gfx@lists.freedesktop.org>; Sat, 28 Nov 2020 16:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QL8LnXwHcQ2AuwyoWBx962VcskXOMnWOVXYNENtQjJQ=;
 b=ENmxCtbnBb/yn7rN/PlNg2iVmn9JJU5MYO3d8w8FE4Z1cjdvxx2U4xkNqlWDg77voW
 yHloAAwvFjmdoD3ruOSau0Jbjw6F6z3/dofAic35qccuSRUxtGcMYpUZ5mJQDVzjne3q
 Vi6R5tFeGFHh0rivU/qR6l3yIYzATEEsX8apbipjILFZXVWWHVoDL1aArGjZB+c4dJYX
 ynGesxjzbMmyBfg6Vee+Ygo36LFKNXBKuwJ2RSi8M9erBb/23sK751WUXAXneJixg8Ps
 J8p4f9D/oIm28sPlwD8tEv7UW48PhhxVntBFVGw+/nwmjylS3UQ4xpz5nPf1L8+spHxM
 eHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QL8LnXwHcQ2AuwyoWBx962VcskXOMnWOVXYNENtQjJQ=;
 b=gx4Wnne4ho4J9/FJJpLVk6qXFTUX5/VlQL2SW6H0tQHXREI5nt8Nn0++qOlq4TpF4C
 8RxEzx6RdzQEmicsrSZ5uCrA+HmO63/TB5vM2Km+x43IyshXBSQhbfLGYGitOFq2vuRq
 u6jxfdajWfDPZM9JFtJaMIHEmzWHbgaR/UD91oBD/tQFFoK90WXNGzQnK8B2rNmdoHQB
 xu3ww8Ncr+QLPvFCJJTOMxEgSa0Q6zEePrurc+VZMEBQ/uq4xg+2treFlvyGWxlrZUvL
 +6xXGm/ZEzNCkb4ylwxHlvF+x/GRD/GNxGSzntxSOz4rBfwoODjgLrNT0MqaE1vcvNQ9
 lpyQ==
X-Gm-Message-State: AOAM532e35OWub0bSDBgnImiFPeEvsyZp8adLri5tFgJ8DLesYSsGuV6
 +3vuIZPg2pW6iRGpmbtHg2GXR2vDG+9APzQzNG7hjQ==
X-Google-Smtp-Source: ABdhPJy+EHFDGmGEkATHgEbY5ViO8PdvyfgMZO9NSyFJroapNPbQ2ri3ZRiouiw9+Oo91XH7DjPoFCrCZlfGFMd3JVg=
X-Received: by 2002:a02:90ca:: with SMTP id c10mr13977251jag.115.1606610300455; 
 Sat, 28 Nov 2020 16:38:20 -0800 (PST)
MIME-Version: 1.0
References: <20201015033557.3046-1-Jack.Gui@amd.com>
 <ccd27274-44e1-3bfc-24a8-e24750889efe@amd.com>
In-Reply-To: <ccd27274-44e1-3bfc-24a8-e24750889efe@amd.com>
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date: Sun, 29 Nov 2020 01:38:20 +0100
Message-ID: <CAP+8YyF59Hnq=NgVbfV__GqMZ8y+HyNYRqoPo3hOBDUj1+CtZA@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amd/amdgpu: set the default value of noretry to 1
 for some dGPUs
To: Felix Kuehling <felix.kuehling@amd.com>
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
Cc: Chengming Gui <Jack.Gui@amd.com>, Guchun.Chen@amd.com,
 Tao Zhou <Tao.Zhou1@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, Ray.Huang@amd.com,
 Alex Deucher <Alexander.Deucher@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Can we revert this patch to fix
https://gitlab.freedesktop.org/drm/amd/-/issues/1374 ?

On Thu, Oct 15, 2020 at 4:30 PM Felix Kuehling <felix.kuehling@amd.com> wrote:
>
> Am 2020-10-14 um 11:35 p.m. schrieb Chengming Gui:
> > noretry = 0 cause some dGPU's kfd page fault tests fail,
> > so set noretry to 1 for these special ASICs:
> > vega20/navi10/navi14/ARCTURUS
> >
> > v2: merge raven and default case due to the same setting
> > v3: remove ARCTURUS
> >
> > Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
> > Change-Id: I3be70f463a49b0cd5c56456431d6c2cb98b13872
>
> Acked-by: Felix Kuhling <Felix.Kuehling@amd.com>
>
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 23 +++++++++++++++--------
> >  1 file changed, 15 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > index 36604d751d62..f26eb4e54b12 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > @@ -425,20 +425,27 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
> >       struct amdgpu_gmc *gmc = &adev->gmc;
> >
> >       switch (adev->asic_type) {
> > -     case CHIP_RAVEN:
> > -             /* Raven currently has issues with noretry
> > -              * regardless of what we decide for other
> > -              * asics, we should leave raven with
> > -              * noretry = 0 until we root cause the
> > -              * issues.
> > +     case CHIP_VEGA20:
> > +     case CHIP_NAVI10:
> > +     case CHIP_NAVI14:
> > +             /*
> > +              * noretry = 0 will cause kfd page fault tests fail
> > +              * for some ASICs, so set default to 1 for these ASICs.
> >                */
> >               if (amdgpu_noretry == -1)
> > -                     gmc->noretry = 0;
> > +                     gmc->noretry = 1;
> >               else
> >                       gmc->noretry = amdgpu_noretry;
> >               break;
> > +     case CHIP_RAVEN:
> >       default:
> > -             /* default this to 0 for now, but we may want
> > +             /* Raven currently has issues with noretry
> > +              * regardless of what we decide for other
> > +              * asics, we should leave raven with
> > +              * noretry = 0 until we root cause the
> > +              * issues.
> > +              *
> > +              * default this to 0 for now, but we may want
> >                * to change this in the future for certain
> >                * GPUs as it can increase performance in
> >                * certain cases.
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
