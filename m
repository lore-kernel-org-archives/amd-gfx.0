Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BFE5C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jan 2022 21:40:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D79A410E66A;
	Thu,  6 Jan 2022 21:40:37 +0000 (UTC)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E830910E66A
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jan 2022 21:40:36 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 f66-20020a9d03c8000000b00590788fb853so4555469otf.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Jan 2022 13:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IgKddoT0qfw7F/ayfJswDgXpoRrllJY5vp1DoQTRIo4=;
 b=be/zqRgA0iTRL7w3+y8yJwUxkBFC9etKKJ+OmJRhHgclMvuwjKlp5XeZceyThXMoJZ
 Qr5zwltmn79eE4A4aYDu9mQpv3Hfs0RHFyG0AvmCkYScC4AUFHAX2amQfJzW6H62jYR3
 YM7tBFul7Wi6whb5JwEYTQ1clGJtYQhsCwD4LBVoCvBlepnjsT6IK6WdodNRE9kmpxkX
 zSNGQMC5St4CB2WHRunUSaxHhMmIH/OYSPDCgjAiZy1zWD5dnrMCPlay3Wa8sBVFXqVV
 PYmq3NYdRWn8orZE45Biu0CMkC/MOxk0asT3/O93ztizT/7cNJs+h2B0/Ag44+lptsRQ
 1tXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IgKddoT0qfw7F/ayfJswDgXpoRrllJY5vp1DoQTRIo4=;
 b=wGsk630sXyiKEw2/rsvia1bngkZ2tHWG6KjLKi9qqk5T7lPGRTqLhzlDta30Ao53lb
 hwp0LM0ObktQ36hYLgSAgwaDfwNSwN8JDuwTGqZr0yEZxnxvMk20TlEmevBEp3CFH1om
 6XD8634V1jwamT5jCCrCZkHbq+3Ul8ExKLU/OAlKA0YYnbWYxs696pQvZL6TTesJLH/G
 MkPjSAL718+0Ay369xppVHseBJOPAgiW+uJDCtZjCSrW0HIiEHO968RCg17nbYWeGxeN
 yBBKb8oH3VoAW6bfXSx0nKiMwz3Ax5k/RsVHJJAJP+ybhdRpq+XZIg84TrDt1oZK98TK
 9eGg==
X-Gm-Message-State: AOAM533+Lun3lblKzLQxCZddcwS0b9RqdGwsMWVZ2mjdrqI/rSkoBgjG
 QI9A2AZ+LTsl/oRX+vsEi3t+NYsqt3Q+vOpRFGKLreijLrmhjQ==
X-Google-Smtp-Source: ABdhPJwACxmyKtYkX5Gj1i2bu5caBIKFDh43Ok9cbVlLr0OWxTD0IwP5C7yqbYX2otsyyZIra4b7hC/k9n0WJwWAztM=
X-Received: by 2002:a9d:6390:: with SMTP id w16mr45550272otk.200.1641505236197; 
 Thu, 06 Jan 2022 13:40:36 -0800 (PST)
MIME-Version: 1.0
References: <20220106134049.23608-1-mario.limonciello@amd.com>
In-Reply-To: <20220106134049.23608-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 6 Jan 2022 16:40:24 -0500
Message-ID: <CADnq5_O9nSrupvqEwvVJg4hvJ+vBKrJXcW8tFnCtkFy03kvnkg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: explicitly set is_dsc_supported to false
 before use
To: Mario Limonciello <mario.limonciello@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Thu, Jan 6, 2022 at 8:40 AM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> When UBSAN is enabled a case is shown on unplugging the display that
> this variable hasn't been initialized by `update_dsc_caps`, presumably
> when the display was unplugged it wasn't copied from the DPCD.
>
> Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1956497
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 5d20807b6f88..3d81314e6cb4 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -6093,6 +6093,7 @@ static void update_dsc_caps(struct amdgpu_dm_connector *aconnector,
>                                                         struct dsc_dec_dpcd_caps *dsc_caps)
>  {
>         stream->timing.flags.DSC = 0;
> +       dsc_caps->is_dsc_supported = false;
>
>         if (aconnector->dc_link && (sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT ||
>                 sink->sink_signal == SIGNAL_TYPE_EDP)) {
> --
> 2.25.1
>
