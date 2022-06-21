Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE0DC43334
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jun 2022 13:16:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AC84112223;
	Tue, 21 Jun 2022 13:16:07 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BFB81121D2
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jun 2022 13:16:06 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id o7so27458392eja.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jun 2022 06:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xR2joSNgZrAyVurUEPg9InZqC5PQfULS98zCoXEmro4=;
 b=idzfQ9LUoFG4R1gV8kLmTD2D5/5rnlaua4ancpyRbk/FU4wHCQpz5rmetDSplBX+4D
 1BltcQH9F1FHmdkbii1W1i4330e9WMRmW+L1ZQ842pfxMO4dUh8ZdC77r5kqtZultLul
 myaXtyWqePF6aG6Nf84njUYem5NjDk9NPVLZvnu7+QfW1B/2MnP/HEI1MaIejBeptmy7
 rbHHi3qlYA1x9y8smphzNUfcx6o2eNX71j8qDZYqH22IM3BCxhv68pYjzWamBPBMkF+b
 tC03T80WhZGH4SUViUFE3viU9IWHvqvcBNYHqGAo391vUvK4COeJFqtdztYFMTtpdSbg
 Do6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xR2joSNgZrAyVurUEPg9InZqC5PQfULS98zCoXEmro4=;
 b=UHwdNcq/lP7R0i0CmKXmoIINyvgp9ZkLzulWiOdKS+mae96h6U1u3txMRTVg7uiv4U
 R774Gsdo99o3jpYCOQXIK8G+8WYRktq7b82zUD6EYAW86BW6tDR1sWi8RtV0jbZlQKv6
 DhwBb6JUa2vaPTc71Bccnra9A0dzxrdXCLbme6c5Ejata/3/rD9+gJ7IejEEvCRbg7ji
 Zb3/s14RL3K8L4cbgcSco/aoMbZAgajteMe0FSaNLsTGIIP9RWCE6WZR+Lb6Z4il/bpY
 vxlaPSZGBjx1aEzGaTmovkk8xbEfqj9fFk4/wUpgU/6WX3Z+C5MTMtXm3RsAHSSMLeGQ
 GU6Q==
X-Gm-Message-State: AJIora+e66NrBSQrNeTWY8xnUZc82K9XLtyr/W8vlkMkpNdMAOApMVQH
 K3BkvqEoMI5FP3zunc8FxEmv/dy7d5NPLvzw3uo=
X-Google-Smtp-Source: AGRyM1vA6+G3WLP40SnaBYpko91tuEMRLht9XNMJwgLGq/LinMG+bCTzyPqZ6i8/vh4v0p1r9QD/OrNprTUt41PH8dg=
X-Received: by 2002:a17:906:74c2:b0:722:e1e2:edea with SMTP id
 z2-20020a17090674c200b00722e1e2edeamr3683539ejl.658.1655817355052; Tue, 21
 Jun 2022 06:15:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220616012127.793375-1-joshua@froggi.es>
 <CADnq5_NdAmAJ93A8ADVYzvYN=-hdWACxJyeBAfgmxc6_-RUq-Q@mail.gmail.com>
 <MW4PR12MB5668626C2F2357142755239896B39@MW4PR12MB5668.namprd12.prod.outlook.com>
In-Reply-To: <MW4PR12MB5668626C2F2357142755239896B39@MW4PR12MB5668.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 21 Jun 2022 09:15:43 -0400
Message-ID: <CADnq5_NGcwG0QP4tL5Wtr_9+acUjHZUarK6-ubuiqnapuPzLoA@mail.gmail.com>
Subject: Re: [PATCH] amd/display/dc: Fix COLOR_ENCODING and COLOR_RANGE doing
 nothing for DCN20+
To: "VURDIGERENATARAJ, CHANDAN" <CHANDAN.VURDIGERENATARAJ@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Joshua Ashton <joshua@froggi.es>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jun 20, 2022 at 8:46 PM VURDIGERENATARAJ, CHANDAN
<CHANDAN.VURDIGERENATARAJ@amd.com> wrote:
>
> Hi Alex,
>
> I think this was pushed earlier by Harry.
> Not sure why it did not get merged.
> https://www.spinics.net/lists/stable/msg543116.html has the history.

I guess it never landed?  I don't see it in the git history.

Alex

>
> BR,
> Chandan V N
>
> >Applied.  Thanks!
> >
> >Alex
> >
> >On Wed, Jun 15, 2022 at 9:21 PM Joshua Ashton <joshua@froggi.es> wrote:
> >>
> >> For DCN20 and above, the code that actually hooks up the provided
> >> input_color_space got lost at some point.
> >>
> >> Fixes COLOR_ENCODING and COLOR_RANGE doing nothing on DCN20+.
> >> Tested using Steam Remote Play Together + gamescope.
> >>
> >> Signed-off-by: Joshua Ashton <joshua@froggi.es>
> >> ---
> >>  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c   | 3 +++
> >>  drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.c | 3 +++
> >>  drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c   | 3 +++
> >>  3 files changed, 9 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c
> >> b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c
> >> index 970b65efeac1..eaa7032f0f1a 100644
> >> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c
> >> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c
> >> @@ -212,6 +212,9 @@ static void dpp2_cnv_setup (
> >>                 break;
> >>         }
> >>
> >> +       /* Set default color space based on format if none is given. */
> >> +       color_space = input_color_space ? input_color_space :
> >> + color_space;
> >> +
> >>         if (is_2bit == 1 && alpha_2bit_lut != NULL) {
> >>                 REG_UPDATE(ALPHA_2BIT_LUT, ALPHA_2BIT_LUT0, alpha_2bit_lut->lut0);
> >>                 REG_UPDATE(ALPHA_2BIT_LUT, ALPHA_2BIT_LUT1,
> >> alpha_2bit_lut->lut1); diff --git
> >> a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.c
> >> b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.c
> >> index 8b6505b7dca8..f50ab961bc17 100644
> >> --- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.c
> >> +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.c
> >> @@ -153,6 +153,9 @@ static void dpp201_cnv_setup(
> >>                 break;
> >>         }
> >>
> >> +       /* Set default color space based on format if none is given. */
> >> +       color_space = input_color_space ? input_color_space :
> >> + color_space;
> >> +
> >>         if (is_2bit == 1 && alpha_2bit_lut != NULL) {
> >>                 REG_UPDATE(ALPHA_2BIT_LUT, ALPHA_2BIT_LUT0, alpha_2bit_lut->lut0);
> >>                 REG_UPDATE(ALPHA_2BIT_LUT, ALPHA_2BIT_LUT1,
> >> alpha_2bit_lut->lut1); diff --git
> >> a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
> >> b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
> >> index 9cca59bf2ae0..3c77949b8110 100644
> >> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
> >> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
> >> @@ -294,6 +294,9 @@ void dpp3_cnv_setup (
> >>                 break;
> >>         }
> >>
> >> +       /* Set default color space based on format if none is given. */
> >> +       color_space = input_color_space ? input_color_space :
> >> + color_space;
> >> +
> >>         if (is_2bit == 1 && alpha_2bit_lut != NULL) {
> >>                 REG_UPDATE(ALPHA_2BIT_LUT, ALPHA_2BIT_LUT0, alpha_2bit_lut->lut0);
> >>                 REG_UPDATE(ALPHA_2BIT_LUT, ALPHA_2BIT_LUT1,
> >> alpha_2bit_lut->lut1);
> >> --
> >> 2.36.1
> >>
