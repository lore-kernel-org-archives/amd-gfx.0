Return-Path: <SRS0=Nkia=FE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F8FC63777
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 19:47:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4383520674
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 19:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MluZ77kU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4383520674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79E3D89C6A;
	Mon, 30 Nov 2020 19:47:13 +0000 (UTC)
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E77E789C6A
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Nov 2020 19:47:11 +0000 (UTC)
Received: by mail-oi1-x241.google.com with SMTP id o25so15511482oie.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Nov 2020 11:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aDOyha4/MgE7iVgLzqEcPI8cSqZrMBvdVGm8fUfMhIY=;
 b=MluZ77kU8WpOrpig65833kh0LK+XhRSrsPSH/a3D0NESL3QU+2qgcFX8UmTBKpwCTL
 Det0Xol2xbauscnyjfeMoiPb28d49GJaaPZ4tE+IxBDlis2MWuu+2aQDqsLbAYzNGGXJ
 sA9H7bvEitdxrAVI3shXBHX+6sGovt2aYLa1vKliuvLLksv+t+rawTb37qQccOSt9d9/
 QtTiYvw5oMe0l1V0UAg0R9BNilYCb/QDV8R25kAhOWO4I3y3mukkYFEO/eH8VDroY6Du
 /4RhlbnB7LF+zBhQxw30x5EBZoGSh5XXUCFVKaRnYxF/qjrq+sPGxmh3BgdM5UfayMWT
 5Oog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aDOyha4/MgE7iVgLzqEcPI8cSqZrMBvdVGm8fUfMhIY=;
 b=kl1QlFkOpQwUJQ7Jh9ZHV9ibMySsv69x9WjPfOc0OHg0AwYFy0YSIxjismHL7r5wEe
 1GxaoU3Xn7u3Fwz4fZqErzO0d8isFR5gvHxD+15rvgaaa563Mlm6g+GyaNCEvl5MyTw4
 LYzLwczBBPZt1DQvz0O+ft9qb3GV50dwUdqVW1menKCRs9HX46CHW5kGg/3z0eNbgUpa
 F9PMvThBrbeSYiBR+Gk6BZp8M7MgcHEb5l0yNKwIvv98QdM4kVj7NnqjTJHLMNIKC3TL
 dcaSepd9AZ5g7axW1cNfRK2paS2WWwzHVgAZq33fWYaQi6aGSelO7Oo2g41KllZi8H9N
 1e1Q==
X-Gm-Message-State: AOAM532BmsrSV0EVEttJQrrU3+6pVeeHwRvBeIpcoX6HcF41nxJULQdQ
 nCyCt+/Oin0ewXHAAerh//Vzlx5uZOkvdG8JUNXejdsg
X-Google-Smtp-Source: ABdhPJx863RRuqXlz6cO/cEPnYBytey3JsSh6PJ+ZpxFkabIMWcnvDSoSRtttqlHZtHhphFfs7XnUeyRidyftbqSAE8=
X-Received: by 2002:aca:f50e:: with SMTP id t14mr372516oih.123.1606765631237; 
 Mon, 30 Nov 2020 11:47:11 -0800 (PST)
MIME-Version: 1.0
References: <20201130185837.291258-1-alexander.deucher@amd.com>
 <6aacba1f-6f0d-650e-c3ac-e20f88469891@amd.com>
In-Reply-To: <6aacba1f-6f0d-650e-c3ac-e20f88469891@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 30 Nov 2020 14:47:00 -0500
Message-ID: <CADnq5_O2UFex+5i2zkwVCMgasFkbP_UVJfpc5eHYO2j77=K=VA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: default noretry=0 for navi1x and newer
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Nov 30, 2020 at 2:25 PM Felix Kuehling <felix.kuehling@amd.com> wrote:
>
> Am 2020-11-30 um 1:58 p.m. schrieb Alex Deucher:
> > There are no performance advantages to setting it to 1 and
> > it causes stability issues in some cases.
> >
> > Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1374
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > index fede84509dbc..02b2ee9b8939 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > @@ -422,11 +422,6 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
> >
> >       switch (adev->asic_type) {
> >       case CHIP_VEGA20:
> > -     case CHIP_NAVI10:
> > -     case CHIP_NAVI14:
> > -     case CHIP_SIENNA_CICHLID:
> > -     case CHIP_NAVY_FLOUNDER:
> > -     case CHIP_DIMGREY_CAVEFISH:
> >               /*
> >                * noretry = 0 will cause kfd page fault tests fail
> >                * for some ASICs, so set default to 1 for these ASICs.
> > @@ -437,6 +432,11 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
> >                       gmc->noretry = amdgpu_noretry;
> >               break;
> >       case CHIP_RAVEN:
> > +     case CHIP_NAVI10:
> > +     case CHIP_NAVI14:
> > +     case CHIP_SIENNA_CICHLID:
> > +     case CHIP_NAVY_FLOUNDER:
> > +     case CHIP_DIMGREY_CAVEFISH:
>
> Is there any point listing those chips here explicitly, given that it's
> the default case? Anyway, the patch is

Just noticed that myself and sent a v2.

Alex

>
> Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
>
> >       default:
> >               /* Raven currently has issues with noretry
> >                * regardless of what we decide for other
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
