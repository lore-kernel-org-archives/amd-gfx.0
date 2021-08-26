Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11982C432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 20:25:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE57361002
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 20:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BE57361002
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C92B6E8B3;
	Thu, 26 Aug 2021 20:25:37 +0000 (UTC)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E69AD6E8AF;
 Thu, 26 Aug 2021 20:25:35 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 q11-20020a9d4b0b000000b0051acbdb2869so124104otf.2; 
 Thu, 26 Aug 2021 13:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+OwUj+s0HNattd+5fUEdf8kL9KlZKYth38XeOI86GBM=;
 b=GvOiYGTxzVJK2Z6Cyk6SXOuZS+W/wonzJWQtf6j8DkLIJ5ZaKFtZWfVs1D5CDlUfu4
 o8fIBD4NzUYzjD2yrjHKoGG7CVfHr9jwSPIgazfKwTdRcjeRsBYv0N355Qp8FwB1+lRd
 EZ1MA29Pmyoe2a/dOAWC+r9IrpTf3NhvjqugJJJZH9M6FXPePVc6XUgZ+27Lzj5gVkiv
 s2qMQcseIjjHi5pt7Dy0GvZAOZGYkiJ2xULaHkT56rP39FuXMrxLC7zcg+2O0Pju5fqI
 9p6pHdFTlqv0RKwyIb7Ad+LnUxaQqG+vrT0ZVf58lbUmz/5wBezAHB7tWFY8fPyJN/BF
 L3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+OwUj+s0HNattd+5fUEdf8kL9KlZKYth38XeOI86GBM=;
 b=iSQhG4yrF7DnLtH3FjcG2gBm/TjdVO3mSIrk7AbPNDr3KjLdqlRMzf8gWNYI0+Yilp
 KAM80/gntAzSguiZj7UWL7nAPI+RaPKK/pcyzCDLRqsC3HVZnxTrJPFunGwjAroujWWs
 xM+OPQh2+slUOvNDAb2wX/FJQXlUDQeDaIFTOPlx4gMjOapJKFiT9rmvahuT1s+hWnHl
 CUVOMLDg9psv8yIgPQQ/4FG3jSWNnM+/F5wZHPUk8wRNqcOI+CxIAYft8TWKzfYVmPTt
 F5ZpXWu7YhUvrYgU89Nf90bnnweqIEt14zEBFYn7xqu52nzndu+DL6e+97lJe2MJR1CF
 glMg==
X-Gm-Message-State: AOAM533XQj/YRLsPwzZcBWn7I3/9vZ6oU+8VnM7VxXzBMswYYeCIuRAR
 fz8OgPjDEzuj7r/Q1K4RrPXizfMaGUI5ajKgaiU=
X-Google-Smtp-Source: ABdhPJy5+C2/xsJ1xt+TqHfRlGfEtbsG335lAWagX2JBVc+qU9P0KiYuPGjrbJpUfcjZoNuDsWYlbKC8S/WqUMWjId8=
X-Received: by 2002:a05:6830:1c69:: with SMTP id
 s9mr5058633otg.132.1630009535275; 
 Thu, 26 Aug 2021 13:25:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210824055232.58653-1-deng.changcheng@zte.com.cn>
In-Reply-To: <20210824055232.58653-1-deng.changcheng@zte.com.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 26 Aug 2021 16:25:24 -0400
Message-ID: <CADnq5_PhsVRBMcV7065+6sgBJnjjrCnU6Eiph7d8mrRVZFFa0A@mail.gmail.com>
Subject: Re: [PATCH linux-next] drm:dcn31: fix boolreturn.cocci warnings
To: CGEL <cgel.zte@gmail.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@linux.ie>, 
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Huang Rui <ray.huang@amd.com>, 
 amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>, 
 Jing Yangyang <jing.yangyang@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
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

Applied.  Thanks!

Alex

On Tue, Aug 24, 2021 at 1:52 AM CGEL <cgel.zte@gmail.com> wrote:
>
> From: Jing Yangyang <jing.yangyang@zte.com.cn>
>
> ./drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c:112:9-10:WARNING:
> return of 0/1 in function 'dcn31_is_panel_backlight_on'
> with return type bool
>
> ./drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c:122:9-10:WARNING:
> return of 0/1 in function 'dcn31_is_panel_powered_on'
> with return type bool
>
> Return statements in functions returning bool should use true/false
> instead of 1/0.
>
> Generated by: scripts/coccinelle/misc/boolreturn.cocci
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Jing Yangyang <jing.yangyang@zte.com.cn>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c
> index 7db268d..3b37213 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c
> @@ -109,7 +109,7 @@ bool dcn31_is_panel_backlight_on(struct panel_cntl *panel_cntl)
>         union dmub_rb_cmd cmd;
>
>         if (!dcn31_query_backlight_info(panel_cntl, &cmd))
> -               return 0;
> +               return false;
>
>         return cmd.panel_cntl.data.is_backlight_on;
>  }
> @@ -119,7 +119,7 @@ bool dcn31_is_panel_powered_on(struct panel_cntl *panel_cntl)
>         union dmub_rb_cmd cmd;
>
>         if (!dcn31_query_backlight_info(panel_cntl, &cmd))
> -               return 0;
> +               return false;
>
>         return cmd.panel_cntl.data.is_powered_on;
>  }
> --
> 1.8.3.1
>
>
