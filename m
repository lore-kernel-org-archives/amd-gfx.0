Return-Path: <SRS0=bDL0=IJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5551C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 14:22:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80C4B64FA9
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 14:22:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80C4B64FA9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 083A489C0D;
	Thu, 11 Mar 2021 14:22:46 +0000 (UTC)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8727D89C0D
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Mar 2021 14:22:45 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id t16so1617610ott.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Mar 2021 06:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+uiiKOdesJC5aH8HxmOGncL5OUtoXf3nbDHGp3HEuTQ=;
 b=M7Qkvd0mQIAUhEvfreYCnQG43YNjCcmAO1cyiUSPtuG7bhfr6tAt1a4XE+D1mAg2kF
 q9lWNhSkeOYpl/zTGjL3HUf+gqISuFrWIDvxR8XLpXfp4CJja45Vr26QetX8+vdGktq0
 V4kHDggF0neB6CPPDhAnULsJyLMRSV+BQZ1Scad+tlvosjwYKC3kI1P2CS7hkETvOHB4
 Lilp5cd1vxftP3xLI1EdwSpB9R60NMUsmWM7cUE4OJo/Qv0v9SMToiyHc99ePp0A2T+K
 vxMi1wyaI6ZzCVj1Pyug02tfYL2zG7IFWw4qelI9ewo4sYP9hIxvjJQx2JHBWGaUfwk+
 QP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+uiiKOdesJC5aH8HxmOGncL5OUtoXf3nbDHGp3HEuTQ=;
 b=EDrueHndEbz2KR4O9gueIgJBGLwAcv8XCTmBjWxj9qC1D+JqlxmmxpKHV54VLrkb0S
 TwHDrkOX4ycxCwHEUILUeBmmf4zN74BqfOumhJl7FJLtluJaTDe++W/Ve8JAZPc2u3uz
 uzBQHRgjTrpmE0PxXEcixvJds65NKysbKAnV7t4U9Uf41KnjGT6ha6PJnM0qNYv2/LLM
 TtVpuCAicpINs3VKGtFI+X1qcd2mxTyNGlqzwoc19LAWHBbamQXMH/ddTWedI7s3q6U7
 g2hK0dkUpePI+r9R8rDOIK8sK4yE7HMGjPLA591jMIdOr5EnNzupVgIzIlYEwPUtQ8Lt
 3M7g==
X-Gm-Message-State: AOAM532/tT106txXYKoZbffh9pOebeR7TWjSRWmahU4f0FRHi8GuGtH8
 DaPLbzYSgwU0fOHmAQ2MEZbd5baflvTJN3U0cps=
X-Google-Smtp-Source: ABdhPJz+RPLL/isN1+uxA2Diws0TKPdUB3eUtX6n1VAgyByoiIIhGgVt1wKhL0fGN4relvfDEJyJVkAm+ixfdN4uRu0=
X-Received: by 2002:a9d:760a:: with SMTP id k10mr7067297otl.23.1615472564842; 
 Thu, 11 Mar 2021 06:22:44 -0800 (PST)
MIME-Version: 1.0
References: <20210216172854.1738806-1-alexander.deucher@amd.com>
 <16e82f38-f1af-ce47-96a2-1464eee519c8@amd.com>
In-Reply-To: <16e82f38-f1af-ce47-96a2-1464eee519c8@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 11 Mar 2021 09:22:34 -0500
Message-ID: <CADnq5_Nk4U0vnk=FXRHJ5U1QEZur2xtTe=+ScC_94tqqOo+e2w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/display: restore AUX_DPHY_TX_CONTROL for DCN2.x
To: Harry Wentland <harry.wentland@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Aric Cyr <Aric.Cyr@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Igor Kravchenko <Igor.Kravchenko@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Feb 17, 2021 at 11:53 AM Harry Wentland <harry.wentland@amd.com> wrote:
>
> On 2021-02-16 12:28 p.m., Alex Deucher wrote:
> > Commit 098214999c8f added fetching of the AUX_DPHY register
> > values from the vbios, but it also changed the default values
> > in the case when there are no values in the vbios.  This causes
> > problems with displays with high refresh rates.  To fix this,
> > switch back to the original default value for AUX_DPHY_TX_CONTROL.
>
> I don't see how this impacts displays with high refresh rates
> specifically. This is a change that only affects our AUX pre-charge time
> and was provided to us by the HW team. It does depend on another
> register being programmed by the VBIOS/DMCUBFW at boot.
>
> Before we revert this I would like confirmation that this is the root of
> the problem.

Any updates on this?  Can we apply this in the meantime?

Thanks,

Alex

>
> Harry
>
> >
> > Fixes: 098214999c8f ("drm/amd/display: Read VBIOS Golden Settings Tbl")
> > Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1426
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Igor Kravchenko <Igor.Kravchenko@amd.com>
> > Cc: Aric Cyr <Aric.Cyr@amd.com>
> > Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> > ---
> >   drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.c
> > index fa013496e26b..2f9bfaeaba8d 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.c
> > @@ -341,8 +341,7 @@ void enc2_hw_init(struct link_encoder *enc)
> >       } else {
> >               AUX_REG_WRITE(AUX_DPHY_RX_CONTROL0, 0x103d1110);
> >
> > -             AUX_REG_WRITE(AUX_DPHY_TX_CONTROL, 0x21c4d);
> > -
> > +             AUX_REG_WRITE(AUX_DPHY_TX_CONTROL, 0x21c7a);
> >       }
> >
> >       //AUX_DPHY_TX_REF_CONTROL'AUX_TX_REF_DIV HW default is 0x32;
> >
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
