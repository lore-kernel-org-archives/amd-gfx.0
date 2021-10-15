Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C12C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 23:53:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5174611C2
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 23:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B5174611C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75DC16EE0D;
	Fri, 15 Oct 2021 23:53:18 +0000 (UTC)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18D0D6EE0D
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 23:53:18 +0000 (UTC)
Received: by mail-qk1-x72a.google.com with SMTP id bj31so7254925qkb.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 16:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VcaW94SQGHd6a0GmPqK8E/egawOqzbg2uplAODuOJjQ=;
 b=hy6guPAg82Yb9eS6sezHzrqgXV8A5YPCPe0ZCV0ICUcr9BTK22wOQnMhcLheflYGxX
 j47lTpPYb6jXqtw7UArNqpMoGLbQQyyMWiAs0PIuCW2Ry3eo+U75ItJvyTjzxBAjTmz0
 zmu9KdzNL7I5mqjn14VVuDbsVXb4jTzdw8Et7JteM5Q1+RfPn3zO8NcFNU7ijsWniyVk
 9HdbRZryN6hCTDnM2d8DQp6+o4fqB9GZRDv8+qgQX4F00mF8uWSJp+PkYNILq+2hph43
 gF2Wn7wcc3D9niB4B39Yk/TxHIgBriRZadO/N7mV4Z4Yy6zAzUojYaSI0cnpDmYm9q/8
 CZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VcaW94SQGHd6a0GmPqK8E/egawOqzbg2uplAODuOJjQ=;
 b=WfFVQcJTdWrYLu7LQ1gq/bkM7fhlJNnesPILiNFf7m0o0aHKmSNGvTNC9ks3fSjYUk
 7JX3f06iGcOGVCs5JykMik2BHnHBMkcI7NEpHKF/KFaCH23Ine3l7KHLlIURq1tHIP1c
 mDZSd5TRX4z3x8yB6m49OQQ4VoOXFK71XCEWk6eXJxsg9NeVp3gn548XYpZwEkq0BkLx
 WG01PjvE77+wfO17Gcqa2EwzIaeIbSpU6eTTjqA4B42QgaAguDjqlmhhP7AgXHwv4Zyb
 sIAOI68/l/uQsIugeW9PnDPkcZdcypHwAmX/AGpw7IrwAZTnlMsG/fOVMwUufStacE5V
 6Zhg==
X-Gm-Message-State: AOAM531RHhE6XTmeEvSIb1HzsPgrCWpU1zzsJQBAtRwE8t7ODUmbBnWj
 ufhMJb8cwtVbveTadSiEeTtofQ6ET363pQqChzN2Fg==
X-Google-Smtp-Source: ABdhPJwLbao9WFaQdiGJv2wYaNKj8k6RDnblWi/hAB5gNFVbpewGpl4rG7BA1b7ls29sF5sPrfURUcFhGOFD2RBLYOc=
X-Received: by 2002:a37:6c42:: with SMTP id h63mr12252558qkc.243.1634341996982; 
 Fri, 15 Oct 2021 16:53:16 -0700 (PDT)
MIME-Version: 1.0
References: <20211015184332.221091-1-agustin.gutierrez@amd.com>
 <20211015184332.221091-17-agustin.gutierrez@amd.com>
In-Reply-To: <20211015184332.221091-17-agustin.gutierrez@amd.com>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Sat, 16 Oct 2021 00:53:05 +0100
Message-ID: <CAHbf0-HyA2EPHq74e_oq_X1bbSd9-uNwuX6aWYjf7Hz3UYTx3Q@mail.gmail.com>
Subject: Re: [PATCH 16/27] drm/amd/display: increase Z9 latency to workaround
 underflow in Z9
To: Agustin Gutierrez <agustin.gutierrez@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Harry Wentland <Harry.Wentland@amd.com>, 
 Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Rodrigo.Siqueira@amd.com, 
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, qingqing.zhuo@amd.com, 
 "Lipski, Mikita" <mikita.lipski@amd.com>, Roman Li <roman.li@amd.com>,
 Anson.Jacob@amd.com, 
 Wayne Lin <wayne.lin@amd.com>, stylon.wang@amd.com, solomon.chiu@amd.com, 
 pavle.kotarac@amd.com, Eric Yang <Eric.Yang2@amd.com>, 
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch seems to change z8 - not that I know what z8 or z9 are

On Fri, 15 Oct 2021 at 19:44, Agustin Gutierrez
<agustin.gutierrez@amd.com> wrote:
>
> From: Eric Yang <Eric.Yang2@amd.com>
>
> [Why]
> Z9 latency is higher than when we originally tuned the watermark
> parameters, causing underflow. Increasing the value until the latency
> issues is resolved.
>
> Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
> Acked-by: Agustin Gutierrez Sanchez <agustin.gutierrez@amd.com>
> Signed-off-by: Eric Yang <Eric.Yang2@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> index c9d3d691f4c6..12ebd9f8912f 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> @@ -222,8 +222,8 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_1_soc = {
>         .num_states = 5,
>         .sr_exit_time_us = 9.0,
>         .sr_enter_plus_exit_time_us = 11.0,
> -       .sr_exit_z8_time_us = 402.0,
> -       .sr_enter_plus_exit_z8_time_us = 520.0,
> +       .sr_exit_z8_time_us = 442.0,
> +       .sr_enter_plus_exit_z8_time_us = 560.0,
>         .writeback_latency_us = 12.0,
>         .dram_channel_width_bytes = 4,
>         .round_trip_ping_latency_dcfclk_cycles = 106,
> --
> 2.25.1
>
