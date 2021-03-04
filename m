Return-Path: <SRS0=anlk=IC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41054C433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 17:04:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E892064F5E
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 17:04:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E892064F5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8D0A6EA36;
	Thu,  4 Mar 2021 17:04:51 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E1016EA36
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Mar 2021 17:04:50 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id l64so30833739oig.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Mar 2021 09:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5Ldogr5dyPLmtZ1jcyRzKVIuLPxB5lUWwXnIg3N7f0c=;
 b=j1RQqzo/3l0iFGuShbvPaLk7JErYfCThRZFkUPehO0vqO7v5akVcj9NW6tmkkOzvgK
 6a6zRYxVvYO6NN05wxu1p1Qjd3XDrTT3bUsGsK+ogltIcb/aZP+VCffAq7a9gMBtywlH
 aP0KpHUq+efFks1ojIzhf/wwzc+2WxRGnGY/bEVgT8ckyAtShqq2RDxG3gqBHQxh+yyI
 N5kIx7hr6A5bviYarunRCdjTbkvqpYguOtIsTruKBNz/ZXea2t5cBSDSIAhfR67PJUTK
 izRmdt268kA2qn+lGhW2e/i5oRPkO20wid5phPCCocaAjewfhy6K770PCykRuNuJOGrM
 nUdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5Ldogr5dyPLmtZ1jcyRzKVIuLPxB5lUWwXnIg3N7f0c=;
 b=OuR4FyQfSiMfVuYM7vFSeEcxkJ7T9CxktwZq8F1LS4Ofi7Ips6bJpDJcy671Lq2LKR
 /zIsjO46NZAh11MWfT0q1LfDb8XJWlHxLMommqPTpmAd/GD81VdmTf3MdvZc5LGIOD7h
 SyfJkYDYkAqy5jcCV+0+eX4VDSbj/eIZeMSRKY6/A0psQ4/iuCFhICO1qIWsEOUBBvNZ
 hG7YWL8GfH/Dp8lua74EhduIc+Datr4mpNeKlK4gf23OebNuKCOBKICSDrjJ77eoTPfT
 3XVAmMZ6RJeHVai1mS5mfR5roysTMJBAJWttAz1cULdPUR56la7xjBVqaiD//sI67uuH
 Q8Og==
X-Gm-Message-State: AOAM531+oY2FGfsmd0AKgU2BOecfP5RqKsuvMpg5gFzLak7uQJsuN3zl
 25SdanPI3yX1eE+1Ltemq3OHZ/0I41ZEBCEOPoc=
X-Google-Smtp-Source: ABdhPJw6stHtOFs8z4ZlY/MbYGeVuX4ffwH0g/X43GSTjAOmRGDtf48rFjY8OJA93bukrZgv5HKizVH6cXspl0OYpRI=
X-Received: by 2002:aca:af10:: with SMTP id y16mr673696oie.120.1614877489911; 
 Thu, 04 Mar 2021 09:04:49 -0800 (PST)
MIME-Version: 1.0
References: <20210216172854.1738806-1-alexander.deucher@amd.com>
 <16e82f38-f1af-ce47-96a2-1464eee519c8@amd.com>
In-Reply-To: <16e82f38-f1af-ce47-96a2-1464eee519c8@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 4 Mar 2021 12:04:27 -0500
Message-ID: <CADnq5_N1EM6a9K-gK3g-7MVF7t6LVS=T_LYNG+GgQ9uNpoDi+g@mail.gmail.com>
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

Hi Harry, any progress on this?

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
