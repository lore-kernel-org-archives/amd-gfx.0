Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFFCFCCA47C
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 14:50:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D07894D05;
	Tue, 12 Jul 2022 14:50:50 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2671794D0D
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 14:50:49 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id y4so10430943edc.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 07:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mvFaonXjpRalTdp5zWO0qkTi6nFeNQNL1y1AR2vkU34=;
 b=O+5YFvlnL/4hBZlV17EvwHZpzqS8e5whcjAUqxMz1m0Z2b1UdQ6HX17FvVcxVNKSKQ
 pnzufy2YTUKlxINxfza9ec2oNY02QrMVjLKiYenoUrfTc0Nbf963Zjhqv407H84uEwUt
 vZhKAMQCfGEei7uRPCGv1IcET9M65g4m+jKCEGUWnKFdSxoEC5AhcHlRl8K+pMUzjhXQ
 xmGOdl/BT6TABz1EAp6udzZztfbXIjKXbGGeV1OcLYtzFPnRybJ/k15+D4pL2FTekBoK
 IKyYiOs+LF/40UMeICr43H4iBW+N4OodSmhRcgMcg7wz6XrIlBiRebpCYBUEAemv/6od
 G8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mvFaonXjpRalTdp5zWO0qkTi6nFeNQNL1y1AR2vkU34=;
 b=3Bg7qWrNX0eDNX4EctnTTZ/pD9jWa45IHlhE074phnN1LC9WqxKRP5s0WPqXH3+Wmd
 Dg1qLPiJlAEaja+W0RhgW5zAPhtF7Vy14A7rnusEHqvipBqsTQNqQC9Fx1lCXbh7T6Zg
 6fODqaON6zilyM8wcINtD+hYRlurM2/pJlwr//HKKi/XYKHeLbxXx8nFnys7kCQwqLn6
 jBOfRoT8ABEk2TBF4E8oVLAyDYomVpkvV5em2Bo7hQzuB5YRnCBiavVkPH/ImxxdHWKE
 IpTkOqmhG1COZM/R7+dqvA48S17IVOEoE/6KSC8nux43thUqbpURBDRuBQCnSuGEWtWW
 1uNQ==
X-Gm-Message-State: AJIora9dfwwPqhj6eE7l79S48LvdByNx5wmSjdiAkHl+MaSrfReVCTnX
 UAT19XIWgrW5T9HOovZzZ3IJImNkQiEFZpsXDjeIXoUP
X-Google-Smtp-Source: AGRyM1upI2zURYvYOUv4n5PdvFcX8VJfCQqARJTgaEyFd5CfAn5TabY+QZ+v4w3aXam9B3U+66KTozZJB3KN10yFPLA=
X-Received: by 2002:aa7:cd64:0:b0:43a:4d43:7077 with SMTP id
 ca4-20020aa7cd64000000b0043a4d437077mr32833122edb.302.1657637447618; Tue, 12
 Jul 2022 07:50:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220708155036.1092134-1-alexander.deucher@amd.com>
In-Reply-To: <20220708155036.1092134-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 12 Jul 2022 10:50:35 -0400
Message-ID: <CADnq5_NtVbuAwgEUoNc+KG+y7BNswjpcP-5Yi_9V-h-ODc1p+A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: make some dc_dmub_srv functions static
To: Alex Deucher <alexander.deucher@amd.com>
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
Cc: kernel test robot <lkp@intel.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping?

On Fri, Jul 8, 2022 at 11:50 AM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> Not used outside of dc_dmub_srv.c.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> index 832f7a4deb03..39b426d04037 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> +++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> @@ -270,7 +270,7 @@ void dc_dmub_srv_drr_update_cmd(struct dc *dc, uint32_t tg_inst, uint32_t vtotal
>         dc_dmub_srv_wait_idle(dc->ctx->dmub_srv);
>  }
>
> -uint8_t dc_dmub_srv_get_pipes_for_stream(struct dc *dc, struct dc_stream_state *stream)
> +static uint8_t dc_dmub_srv_get_pipes_for_stream(struct dc *dc, struct dc_stream_state *stream)
>  {
>         uint8_t pipes = 0;
>         int i = 0;
> @@ -284,7 +284,7 @@ uint8_t dc_dmub_srv_get_pipes_for_stream(struct dc *dc, struct dc_stream_state *
>         return pipes;
>  }
>
> -int dc_dmub_srv_get_timing_generator_offset(struct dc *dc, struct dc_stream_state *stream)
> +static int dc_dmub_srv_get_timing_generator_offset(struct dc *dc, struct dc_stream_state *stream)
>  {
>         int  tg_inst = 0;
>         int i = 0;
> --
> 2.35.3
>
