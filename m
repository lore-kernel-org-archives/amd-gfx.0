Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ACA6C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jan 2022 16:24:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C605410E119;
	Tue, 25 Jan 2022 16:24:02 +0000 (UTC)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32B1010E119
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jan 2022 16:24:01 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id s9so31933824oib.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jan 2022 08:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=H88NmC+1Bl/teEZANxvOpW/rmmTEGzp8RVIG0xUyZ34=;
 b=SHW0G0AbNyuwnpKklcxGoD2l9jf4c7NQs2Uyn9kRkDAfqqE7xNrrOIgVdwXw3Z08Pq
 2icspPwZwPcE7bpWZsANqvxEnkOyRrY2dsPPP8f1cdYS0cm1/Xyt5yVGz7/3Zq98OVu5
 3G/rKSRlC/KLMd8cUi5r4AA0bkcL5jxuMEENO2c2FllQTNJDaYF4WfqNtN0qE54dQqKO
 mkJVIvKT8BTZvi44WiL3Jgi9lVnKreujYjjKMkGPTjwIbAqzlvn3QZ4I+y5cEwPePTbm
 WvS63/+EyhtHpi7KdafPFHuyO+QKtz5bw+8ix9vm891Jf4hvGlKpl64AK7sfTebfGdfe
 9Evw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=H88NmC+1Bl/teEZANxvOpW/rmmTEGzp8RVIG0xUyZ34=;
 b=VtyynWGASR2iYeWe2I+Q2LXSbu2aALN1pVOKyZReUQkERQFW12gHIvHw69CfzG3Noi
 KCls1j27AJkWjpzm6t1AzZHErJ4rQa9cw7E4Dr9YARtkjAsIXtIyGpTEfbnSAA4v1Kim
 uIifR7WrqfV+Jzt0+6Tgh55jUtykp6wv6KIotIfHY0waEP2Uh4Mwar9Qs/W/9RNaBlxo
 lsxT4GbV3N8/hFHa0rBI1VO8vzgr+KB5bnrGlii1NcKDNOYaar5ki8eUxt7A1ARrJ/d2
 CJY8bPfhSDa3vi4IICHzUEZssE6IgbsX+rj8dKGegxWgm1g5dIRQ6FyVJCFy7681stYd
 hJTA==
X-Gm-Message-State: AOAM530i7ESpGq3gHhdQC+kPeuZGTB/YCqNheuKS+WKQ+LK+qoQKR1HL
 fsJ+ukbVgYKuL2HyJ8CVAvzJ05lO0kjRZEHo58VLxgaE
X-Google-Smtp-Source: ABdhPJzwzKK/FTkAIHi0YZ/aaO/1UgBXfvT2LDOAqtABEKA4FnSVLPXGX0BIA2waSk++tMuD5228sDsRTF90vzSed/4=
X-Received: by 2002:a05:6808:2189:: with SMTP id
 be9mr1142710oib.93.1643127840280; 
 Tue, 25 Jan 2022 08:24:00 -0800 (PST)
MIME-Version: 1.0
References: <20220120180429.616236-1-alexander.deucher@amd.com>
 <20220120180429.616236-2-alexander.deucher@amd.com>
 <36b699d7-b7c4-21cf-93ee-47f4f33190df@amd.com>
In-Reply-To: <36b699d7-b7c4-21cf-93ee-47f4f33190df@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 25 Jan 2022 11:23:49 -0500
Message-ID: <CADnq5_PWLOF8Drkr=f+dUnBxEP81JJyQSHt7gVBaD9xgyAn-hw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu/display: use msleep rather than udelay for
 long delays
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jan 25, 2022 at 6:32 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>
>
>
> On 1/20/2022 11:34 PM, Alex Deucher wrote:
> > Some architectures (e.g., ARM) throw an compilation error if the
> > udelay is too long.  In general udelays of longer than 2000us are
> > not recommended on any architecture.  Switch to msleep in these
> > cases.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> > index aa1c67c3c386..eb4432dca761 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> > @@ -6941,7 +6941,7 @@ bool dpcd_write_128b_132b_sst_payload_allocation_table(
> >                       }
> >               }
> >               retries++;
> > -             udelay(5000);
> > +             msleep(5);
>
> msleep is not recommended for sleeps < 20ms. The original code (modified
> in patch 1) seems to do such a check. As per kernel doc, if precision
> matters recommendation is to use usleep_range().

I'm not sure what to use here.  ARM32 doesn't allow udelay longer than 2000us.

Alex

>
> Thanks,
> Lijo
>
> >       }
> >
> >       if (!result && retries == max_retries) {
> > @@ -6993,7 +6993,7 @@ bool dpcd_poll_for_allocation_change_trigger(struct dc_link *link)
> >                       break;
> >               }
> >
> > -             udelay(5000);
> > +             msleep(5);
> >       }
> >
> >       if (result == ACT_FAILED) {
> >
