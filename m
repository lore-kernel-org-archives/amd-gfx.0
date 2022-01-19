Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD6EFC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 22:20:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38C2410E495;
	Wed, 19 Jan 2022 22:20:41 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8ECC10E479
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 22:20:39 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 t4-20020a05683022e400b00591aaf48277so5081503otc.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 14:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YJ8uGwyfCWw5eVtidKpOrN1CVNYakCMcjDqJcLbAkE0=;
 b=KWpoKfFRohq3H1SO0mnqcbbb6NtBuWhqKxVi7PfTWuu1g80E5AXZXQGTuabliEVKo9
 YgOJxAFLPaM3rgUh9FFS+Z30H97xcqSl1GbYhG7DsJPCG1hdI+i1meFEszBpjKBqHGJ2
 P5TVAk3Ha0JsY+tJwL5NKA/0o/ohSbS0tBvoVK8oINfWuOWYFkMrDRZk9Id5dboYF69Z
 qQoCwI2kxgSgMdzsYtMu9L1X8KCfBpa4BivRfJhoZikAJ9wHq32h8ZMm4F1mdM+70cP2
 z/ZRwM1VD9cpxg7O/mHvZYlR987gB2cpRmH+4hhL1kFJ9v6YCpUO5RoVRZFcjOEqHz/5
 yYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YJ8uGwyfCWw5eVtidKpOrN1CVNYakCMcjDqJcLbAkE0=;
 b=2tapCvD8jm9LLdHhXDrULcPQCMh6Onn3ppXFF1KedmiCb4lhJqYmzCtHmXJwD2gOhQ
 xvdWO+j5t5oW69FZWcml/cmbj7Q86R0zF4DgUcnWd87R0rwqjj52cXJMqfNEYJO3IBt9
 xECWC/vC5/Cs3xvZP+sRr5XvxIb3ivDCk7efdEn5774RpLbqsCgpHDMGZr0CGyH9hz1U
 bSHdmd7yrSyr0PJeqILMCOm4gIQT2wgWFJuxC9r8550XYe9bJxGJuGCTLXpHCv4ckQSK
 CTUa9Qny83Du6ThzBYECn7aBqhSJZZy1em+wN5u9zYyJhB3urAM1YoAA9TJ46XxlbHnF
 13UQ==
X-Gm-Message-State: AOAM532jSvYZuUr3ZpjqAlD+3G9p4ALQaYTJ2z8sdgf2z7opycLq+ax8
 OgitNC7pQ1qijXmp660KxNkkXSxVa0ZlwyJBglQ=
X-Google-Smtp-Source: ABdhPJy0OWPazNBUmVBXQf3Wbbt16I9NRRyJmFEkKqLBUkDba9pkrJGC7DmZzLNAybCm5LbVMBZpVyM4rn3B/2TdC+U=
X-Received: by 2002:a05:6830:1d90:: with SMTP id
 y16mr15171739oti.200.1642630838888; 
 Wed, 19 Jan 2022 14:20:38 -0800 (PST)
MIME-Version: 1.0
References: <DM4PR12MB521400998515602D0F8AA6EA9E599@DM4PR12MB5214.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB521400998515602D0F8AA6EA9E599@DM4PR12MB5214.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 19 Jan 2022 17:20:27 -0500
Message-ID: <CADnq5_NLuUWqH8YZcMAgaSVv78bEQ1=Xbona9J4JJKOO_5_OeA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Shorten delay time to 1us while
 resetting FIFO
To: "Liu, Zhan" <Zhan.Liu@amd.com>
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
Cc: "Liu, Charlene" <Charlene.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Cornij,
 Nikola" <Nikola.Cornij@amd.com>,
 Pierre-Loup Griffais <pgriffais@valvesoftware.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Wed, Jan 19, 2022 at 5:19 PM Liu, Zhan <Zhan.Liu@amd.com> wrote:
>
> [AMD Official Use Only]
>
> [Why]
> Current FIFO reset delay for dcn10 is 100us, which is too long
> and will fail atomic flip. As a result, there will be no display
> on boot.
>
> [How]
> Shorten delay time to 1us. This also aligns with FIFO reset delay
> on other ASICs.
>
> Signed-off-by: Zhan Liu <zhan.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
> index bf4436d7aaab..2077c22befa5 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
> @@ -909,7 +909,7 @@ void enc1_stream_encoder_reset_fifo(
>
>         /* set DIG_START to 0x1 to reset FIFO */
>         REG_UPDATE(DIG_FE_CNTL, DIG_START, 1);
> -       udelay(100);
> +       udelay(1);
>
>         /* write 0 to take the FIFO out of reset */
>         REG_UPDATE(DIG_FE_CNTL, DIG_START, 0);
> --
> 2.25.1
