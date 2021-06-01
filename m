Return-Path: <SRS0=H3yO=K3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4B3C47080
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 13:17:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F76C613B1
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 13:17:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F76C613B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A90426E7F5;
	Tue,  1 Jun 2021 13:17:29 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9537D6E7F5
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jun 2021 13:17:28 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id y7so17288592eda.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Jun 2021 06:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XdnTo2xiFIZUf8RX6VjyA9Y655hHeR0liNnxCDaxTWE=;
 b=jm7Fbrl/3BTpnbVdhhGOK81v/l9HB6j6sUfXf6b3P/qKXYOj3PBD/F/1/niqL3/qj4
 v6IwqyKbSLI5Nilv6MybOG77NQwvi3befq7wmrYWA9z6ch1+nXluGbzf4/nJxZ8qczbu
 GSQpheJbQeZ36S13mhfCeDe+DMqRC1DuaKl9PoH8IWIu3GrNV+sv8WtLUDbseoIel1ek
 3beHVdgQO2jcmuZC9VTltqSHdujTUYlp9knWWc2mFzSnZon15WBKDUEQ+LwP4/1olX1L
 GEdrJOHr0fcI0bLaUrnaJwtv5V1SurTugRxM0o2t86EbQrehnnIaAgIfz4FRgmfwYUwj
 pGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XdnTo2xiFIZUf8RX6VjyA9Y655hHeR0liNnxCDaxTWE=;
 b=WZMJLNHCj7KbTgTa7zdNj0CGzEux4pKFF26qzZtY7haT79LMqK83btxeh6PiIvimHZ
 Dl2RKpnGS5TuRVcgf5slmd41O9iAewH6OW529UbjYKoiRPQ0Hb5xPgES9O9njTHnin3L
 ssRkjuAVBPBjpAaVli5S5l0pZGqJzL7GxNAxjs98lib9AcE2Gp94hCIoOCGE/DpFVr1F
 /kw+Vs3bvOFb3GziUdSWV1kzw/9SfCI0JjjAc+GTtxPCo75HCL+BDbYqzDoEjOO0i/Eo
 olpp/MITDoO92et3id943CS2H5Mmolqq7av2hQNpdMaYvWs3OdF/TggFuismU6s8QG8+
 QkTQ==
X-Gm-Message-State: AOAM530Zgzm9FYol9JFRqmtZZQShle4GtbT6kMFNnTnEJxxOrtSF/UmU
 BWwLkLaz591qsaGOOLpZLzH0mU53oXxrjdJO9bQ=
X-Google-Smtp-Source: ABdhPJxvEUOWPjbR+ZkmZT2rXqUHUBoIu00hoo3y03MfHTszA4XQ+UV48ky/NC3DaoY1Ei7A6JLiD+2mJsaF4An2Wj0=
X-Received: by 2002:aa7:cd19:: with SMTP id b25mr30597923edw.84.1622553447262; 
 Tue, 01 Jun 2021 06:17:27 -0700 (PDT)
MIME-Version: 1.0
References: <DM6PR12MB3547CA74B0AA230909080A0AF73F9@DM6PR12MB3547.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3547CA74B0AA230909080A0AF73F9@DM6PR12MB3547.namprd12.prod.outlook.com>
From: Mario Kleiner <mario.kleiner.de@gmail.com>
Date: Tue, 1 Jun 2021 15:17:15 +0200
Message-ID: <CAEsyxyhmjds=87PKyVVkruwZLOQgk_DALgD_-_nLxzmMiH3qFg@mail.gmail.com>
Subject: Re: display regression on Carrizo
To: "StDenis, Tom" <Tom.StDenis@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, May 31, 2021 at 4:14 PM StDenis, Tom <Tom.StDenis@amd.com> wrote:
>
> [AMD Official Use Only]
>
> Hi Mario,
>

Hi Tom,

> The following commit causes a display regression on my Carrizo when booting linux into a console (e.g. no WM).  When the driver inits the display goes green and is unusable.  The commit prior to this one on amd-staging-drm-next results in a clean init.
>

That's sad. What happens if you only revert the change to
drivers/gpu/drm/amd/display/dc/core/dc_resource.c in this commit,ie.
change the assignment in resource_build_scaling_params() back to:

pipe_ctx->plane_res.scl_data.lb_params.depth = LB_PIXEL_DEPTH_30BPP;

As my testing on Polaris / DCE11.2 showed, for some reason the change
in linebuffer pixeldepth was not required for my Polaris11 to get
12bpc output, only for my Raven Ridge / DCN-1. Maybe I could make a
followup patch to make it conditional on asic? Either only increase lb
depth on DCN-1+, leave it off for DCE, or just exclude DCE-11.0 from
the change, as Carrizo is DCE-11? I seem to remember there were some
other DCE-11 specific restrictions wrt. 64bpp fp16 and the scaler.
Maybe something similar happens here?

-mario

> commit b1114ddd63be03825182d6162ff25fa3492cd6f5
> Author: Mario Kleiner <mario.kleiner.de@gmail.com>
> Date:   Fri Mar 19 22:03:15 2021 +0100
>
>     drm/amd/display: Increase linebuffer pixel depth to 36bpp.
>
>     Testing with the photometer shows that at least Raven Ridge DCN-1.0
>     does not achieve more than 10 bpc effective output precision with a
>     16 bpc unorm surface of type SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616,
>     unless linebuffer depth is increased from LB_PIXEL_DEPTH_30BPP to
>     LB_PIXEL_DEPTH_36BPP. Otherwise precision gets truncated somewhere
>     to 10 bpc effective depth.
>
>     Strangely this increase was not needed on Polaris11 DCE-11.2 during
>     testing to get 12 bpc effective precision. It also is not needed for
>     fp16 framebuffers.
>
>     Tested on DCN-1.0 and DCE-11.2.
>
>     Signed-off-by: Mario Kleiner <mario.kleiner.de@gmail.com>
>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>
>  drivers/gpu/drm/amd/display/dc/core/dc_resource.c          | 7 +++++--
>  drivers/gpu/drm/amd/display/dc/dce/dce_transform.c         | 6 ++++--
>  drivers/gpu/drm/amd/display/dc/dce110/dce110_transform_v.c | 3 ++-
>  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c           | 3 ++-
>  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  | 2 +-
>  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c           | 3 ++-
>  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c         | 2 +-
>  drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c           | 3 ++-
>  8 files changed, 19 insertions(+), 10 deletions(-)
>
> Tom
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
