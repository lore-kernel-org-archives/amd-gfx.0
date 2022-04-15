Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F26B3C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Apr 2022 08:50:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C5881121BE;
	Fri, 15 Apr 2022 08:50:11 +0000 (UTC)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F30E1121BD
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Apr 2022 08:50:10 +0000 (UTC)
Received: by mail-il1-x129.google.com with SMTP id e1so4541896ile.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Apr 2022 01:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=pyHZtUqk/yZ5JeYE4ce1xHZL3ov2K5bIFKslAQ/EBo8=;
 b=EAsd3Q5pw+uEI/l+mi0URHRfnLw2Nk+ERD/JgJ4iIZlDxVLmaiewwBbPqyatErM5Q6
 PC+N9A83F+JML/HKihzczbMlyJryI9kb7VXR1qOnQxuthpGRyYzml8Q/ymoi4DxaL51w
 WA2d6YhL6DjhgPaBEbcGgMUT8ZQ3ZuPKB54Ey4Z9JzEzEFPorpePHGbEgIMw5Duzk6Cr
 xSyRGStmg0MLyV5+iLRux70/UnJz4pB2Y176ZwfNYBBOgsf1XV5spIsmzX46zckEsIbb
 NM6pbUJjt7hXXo3mcdb3lQ7EsmSDka1QBDvJhRf1hz5NqWatv+gKP/qDrpPxWFxUlI93
 96Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=pyHZtUqk/yZ5JeYE4ce1xHZL3ov2K5bIFKslAQ/EBo8=;
 b=l78lKPka3KPAmaGpcEQi6ICshHFm+SX7cg4RHtf3bA+SPCEoiHiWw+I7xPoZRBxB3E
 w3vhPKQhmKaNVAlG+YVK69GHpP4Es0LnvAVxfKJrDyipyzNMAfp7ayx5lYMTwMN2Xnlh
 tvV8aP4/koEBEimQSpK8HFOl9OqiBMEVtTJAsLNqAzbIlB2Y00BL8vednJqztmB1EWzJ
 0UHPbC3PZMO2Am3U11tnTOPj5ecqgWvt0jy2rGx9rpj836rRfCbUo5SquKbLeoay29SA
 KI0RWl06ZuPI9VK9HCZAHtG6p8s+tP5DhGDCqUyti5VqV6vB9XrSsshdYJSpvyzDqVnU
 v22g==
X-Gm-Message-State: AOAM530sWgtF83mjv8jMaPsfSCzmrENX90gWiy4Php9GukZDYXL7oe+J
 fclI9IAgsHozTWX/+RQg6X/8SoJJBkJt1KUBhkY+LndK
X-Google-Smtp-Source: ABdhPJxTGk1zegqDs3dUL8TGJAG3vPyiW/De8wfwGc2/uERTFYc0K9Ta5akcMJubGplLSbuPcX1iAjHDMNT6luxjRcc=
X-Received: by 2002:a05:6e02:1986:b0:2ca:bd0e:a272 with SMTP id
 g6-20020a056e02198600b002cabd0ea272mr2644090ilf.160.1650012609666; Fri, 15
 Apr 2022 01:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAAMvbhF-mcZd+mfSUVpYShvKmFiQ6pb+j2eosBr-kvsxE+202g@mail.gmail.com>
 <fae30821-f0b8-440a-a0d1-4c2a7d37ec07@molgen.mpg.de>
 <CAAMvbhFcD_YuoZEM+LyY6Yga9foR5mUBqPZP9TPpto5o4EGo1Q@mail.gmail.com>
 <28aa9e6b-5267-ea95-9a61-7c488fa97cdc@molgen.mpg.de>
In-Reply-To: <28aa9e6b-5267-ea95-9a61-7c488fa97cdc@molgen.mpg.de>
From: James Dutton <james.dutton@gmail.com>
Date: Fri, 15 Apr 2022 09:49:33 +0100
Message-ID: <CAAMvbhHK3_Cn2-2y4EisxXc5wJe5qZhCmCw5kqRek32tg7qEsQ@mail.gmail.com>
Subject: Re: Vega 56 failing to process EDID from VR Headset
To: Paul Menzel <pmenzel@molgen.mpg.de>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, 13 Apr 2022 at 08:11, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear James,
>
> > I will do some more investigation. In addition to it not processing
> > the EDID particularly well...
> > Since my email, I have found out that it is failing to complete CR
> > (Clock Recovery) on Link 0,2, but it works on 1,3 at HBR2. All 4 Links
> > work at HBR1.   (I need the HBR2 working)
> > The CR negotiation in the code looks a bit wrong to me, so I will look
> > into that a bit more.
> > Looking at the current amdgpu source code   (I am using Mainline
> > kernel version 5.17.1), it appears to retry CR negotiation, but each
> > time it uses the same settings, rather than try different driver
> > parameters, as recommended in the DP standards and compliance test
> > documents.
>
> [=E2=80=A6]
>
> Awesome, that you review the code with your expertise. Though I suggest
> to look at and work on agd5f/amd-staging-drm-next [1], having the latest
> code for the driver.
>
Just a small update. I have CR negotiation working now.
I have found out what I suspected. Although the amdgpu driver has code
in it that looks like CR negotiation is implemented, it does not
actually do any negotiation at all.
I still have some work to do, to also get EQ negotiation working.
Once I have a patch that is tidy enough, I will raise a bug request
and attach the patch to it.
I am just pleased that this is a software problem, and not my screen at fau=
lt.

Someone mentioned that the amdgpu driver is DP compliance tested
periodically. In short, I don't think any of those Link negotiation DP
compliance tests are actually valid, based on what I have found, so it
might be sensible for the person who runs the Link negotiation DP
compliance test suite to double check it is actually doing its job.

Summary:  During CR negotiation, it only ever outputs a swing of 0,
and never 1,2 or 3 as it should.
So, my guess is only Screens on relatively short cables have ever
worked with the Linux amdgpu driver.
Although longer cables might work for some, it probably gets a bit hit
and miss for them.

Kind Regards

James
