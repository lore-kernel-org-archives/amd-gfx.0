Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47259C001B2
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Dec 2022 21:54:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AFD310E49C;
	Wed, 14 Dec 2022 21:54:26 +0000 (UTC)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A34C110E4A3
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Dec 2022 21:54:19 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id l127so3772948oia.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Dec 2022 13:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HLH2XySlmItWCgaR7KmWWzrbiQ5J9iIU4jWh/dNkwg0=;
 b=Z4WhNbgTx1BJSXDWlTFwxi9jr9k16RGOnNPjcl8eGzzjZu9R30gEIBIbKgLaYVbn4p
 jbBI0hNfNz93ulWFBFiR8jVZ9nG2l/zaTX63b4ZR2f5pW6NgF5SdrynlFF4mCRUEGFUi
 tl/CCSr3Wze+IPbhBjiQtTOzey5973OuCWdQsfkCcaw/nyjvfG2jTK+6JS9NlksZZb95
 7Es8ZlReB0DFDc085fwrP7V0Kf5/omggolmEBaIlKVobj0eJFdKRSkAz/WipSvX0Tr/d
 TGvqZkN2KliAQ1WipdptXTSNMO+j1W4trltnKsGEUqwFoYeYcTbVT/XuplHT7l/+SLMK
 AAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HLH2XySlmItWCgaR7KmWWzrbiQ5J9iIU4jWh/dNkwg0=;
 b=KjrncfsDnTTHz/DKg5MiCq3BHvUXq4uTFi136n/KWtk6P51MGVwD1H+sHr2NFkigWj
 2C9XPyVSL3qjhPYQJCxjRDg0yXinOMl7AVpV9Gwelh5UEJRKGDO7oLIkwemojDwEcSQ8
 sXtDW+KlMjuprHB1FleqXTRHOxqUWbRqahMQSp4dg/myGG/WjAwWg7nEwSbmz/CnFubg
 nfuL8vzTuseqSv9J8Ik80rz6hYE09snk4S0oUsEeK6zBvmIPONz79E1+rzlsWEgSor7Y
 SvHwV30jLmUXqAyWnZxLP1pKISIp1J2QaQw5P0Joj3i8K2BgaTt6TabYBqdQaaQMukK3
 O7UQ==
X-Gm-Message-State: ANoB5plDnV6BOTt0QMJ0T5t2HuMg7b96X3niCqMsjSBaTXSyKGhbCxRb
 cSrtw2GNb3MpFzZ6/tGTAAnEfdGgx/cZ+faIWT5GbTkL
X-Google-Smtp-Source: AA0mqf5IKpva+r97YgLYRfj0zONSZkaSGq3k2654oSyG1yNXytIs4GR3qPZ+xKIWMyAAWQDfJCT17XTHPP5I7wlHAUo=
X-Received: by 2002:a05:6808:1886:b0:35b:d93f:cbc4 with SMTP id
 bi6-20020a056808188600b0035bd93fcbc4mr225147oib.96.1671054858905; Wed, 14 Dec
 2022 13:54:18 -0800 (PST)
MIME-Version: 1.0
References: <20221214202141.1721178-1-aurabindo.pillai@amd.com>
 <20221214202141.1721178-6-aurabindo.pillai@amd.com>
 <CADnq5_PKy2+2-5X+zn4Ax2wp1iuiZ7E-r-bQ3cSHifE34FYfRA@mail.gmail.com>
 <2938ab78-3224-4097-f5d1-f64c354e5eb6@amd.com>
In-Reply-To: <2938ab78-3224-4097-f5d1-f64c354e5eb6@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 14 Dec 2022 16:54:07 -0500
Message-ID: <CADnq5_P83EkSqXxe29diJZ2eJH8-8v308jLRZxJ4f8e7FnEOmw@mail.gmail.com>
Subject: Re: [PATCH 05/18] drm/amd/display: Use mdelay to avoid crashes
To: Alex Hung <alex.hung@amd.com>
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 amd-gfx@lists.freedesktop.org, solomon.chiu@amd.com,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Dec 14, 2022 at 4:50 PM Alex Hung <alex.hung@amd.com> wrote:
>
>
>
> On 2022-12-14 13:48, Alex Deucher wrote:
> > On Wed, Dec 14, 2022 at 3:22 PM Aurabindo Pillai
> > <aurabindo.pillai@amd.com> wrote:
> >>
> >> From: Alex Hung <alex.hung@amd.com>
> >>
> >> [Why]
> >> When running IGT kms_bw test with DP monitor, some systems crash from
> >> msleep no matter how long or short the time is.
> >>
> >> [How]
> >> To replace msleep with mdelay.
> >
> > Can you provide a bit more info about the crash?  A lot of platforms
> > don't support delay larger than 2-4ms so this change will generate
> > errors on ARM and possibly other platforms.
> >
> > Alex
>
> The msleep was introduced in eec3303de3378 for non-compliant display
> port monitors but IGT's kms_bw test can cause a recent h/w to hang at
> msleep(60) when calling "igt_remove_fb" in IGT
> (https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/blob/master/tests/kms_bw.c#L197)
>
> It is possible to workaround this by reversing order of
> igt_remove_fb(&buffer[i]), as the following example:
>
>    igt_create_color_fb with the order buffer[0], buffer[1], buffer[2]
>
> Hangs:
>    igt_remove_fb with the order buffer[0], buffer[1], buffer[2]
>
> No hangs:
>    igt_remove_fb with the reversed order buffer[2], buffer[1], buffer[0]
>
> However, IGT simply exposes the problem and it makes more sense to stop
> the hang from occurring.
>
> I also tried to remove the msleep completely and it also work, but I
> didn't want to break the fix for the original problematic hardware
> configuration.

Why does sleep vs delay make a difference?  Is there some race that we
are not locking against?

Alex

>
> >
> >>
> >> Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> >> Signed-off-by: Alex Hung <alex.hung@amd.com>
> >> Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> >> index 913a1fe6b3da..e6251ccadb70 100644
> >> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> >> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> >> @@ -1215,7 +1215,7 @@ void dce110_blank_stream(struct pipe_ctx *pipe_ctx)
> >>                           * After output is idle pattern some sinks need time to recognize the stream
> >>                           * has changed or they enter protection state and hang.
> >>                           */
> >> -                       msleep(60);
> >> +                       mdelay(60);
> >>                  } else if (pipe_ctx->stream->signal == SIGNAL_TYPE_EDP) {
> >>                          if (!link->dc->config.edp_no_power_sequencing) {
> >>                                  /*
> >> --
> >> 2.39.0
> >>
