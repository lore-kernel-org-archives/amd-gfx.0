Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB72C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 22:19:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D832E10E236;
	Wed, 19 Jan 2022 22:19:44 +0000 (UTC)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66C3910E236
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 22:19:43 +0000 (UTC)
Received: by mail-oo1-xc35.google.com with SMTP id
 k15-20020a4a850f000000b002dc3cdb0256so1216906ooh.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 14:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LZbyyEo1SRmbfcvqRL6QioefO0Xw05uJiX0ooyzBXaw=;
 b=KNNI2HrsLpy7v+6h0dRcp4gpL9rigy7ctT9ctjedZB33CMys0vALLNoF6P35DeXt3J
 TO78s4n9qsDBaCSqkjOhUYcExVlKaO1i0wrjR7pmhtHIx2zmE/qmfH/jFpQd5vQeJdS2
 dLdAC4T99oaKATDdWteokIqQQkYp/r4RTP2D0rcZBoV4P6kn4qiErER/OoaViay7ZS0+
 7rS2RH1dEo7kOTeZ0JxBtjN7UPtR1f1U6E7vc/CUNsUSVwYF6gCLj4k337+5JaDPElSw
 E6WdziPoEO1l56ZTsf/gLJYYqb9KzoKpZcTkazbJ9rFtvhA4x2Tui5HeDOnElfo5SD08
 B3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LZbyyEo1SRmbfcvqRL6QioefO0Xw05uJiX0ooyzBXaw=;
 b=cXOCoIMk8bQEkLllerU0viMTDvhpFwOGAnstcouVekxSvrGayRU0qFYG/VyT7gXTIS
 k4aCW6NGTVj+c3nePvUdFNn5Y68ndBsuJJ11SCNEvqLOtwhNFc5DeyH+bPbZ3uf/ddfJ
 sbF+jatpZUIV10lShmXkjGBYjWJnpuxaroH/A10UbCmswhMtGXt+bWc4cdvnIdOnsnDr
 ZeHR7UJJEXA+an9+UbrckcqP27zJVEJTd8CUxZ1QGrobkgwUqJky5UsJcylqRkz8y3q5
 J2j+dqZRAhlYMm+Hv9DSsvK9Dmo+PQcH9f6pToz+tjW9OrFKg27EdcpHk8Aje4n1jU4z
 EfgA==
X-Gm-Message-State: AOAM531BshLqCDviAGVusG1OQhXbTgeAS9w4NwnlnLXYL1pSx2rMr1/c
 DeSE88uuDjuaQ4/lkK+2GjVdx41J4WTd+hL1BVM=
X-Google-Smtp-Source: ABdhPJxb8gUWgPcHYkJI0IaLIKUEJFmTaDdLIg4ZIVS+4T+CWeYLn1KlSgO9CaVoBwUXaenIBINAXBGuu4NAtv6sP8w=
X-Received: by 2002:a4a:e3c5:: with SMTP id m5mr4927581oov.73.1642630782658;
 Wed, 19 Jan 2022 14:19:42 -0800 (PST)
MIME-Version: 1.0
References: <DM4PR12MB52141E8C6959D2BE69FAB8479E599@DM4PR12MB5214.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB52141E8C6959D2BE69FAB8479E599@DM4PR12MB5214.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 19 Jan 2022 17:19:31 -0500
Message-ID: <CADnq5_P_PxufuQAsb3LxvXSDMUqtSkQNF+6okzyMqiv1zGHHNQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Correct MPC split policy for DCN301
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

On Wed, Jan 19, 2022 at 5:17 PM Liu, Zhan <Zhan.Liu@amd.com> wrote:
>
> [AMD Official Use Only]
>
> [Why]
> DCN301 has seamless boot enabled. With MPC split enabled
> at the same time, system will hang.
>
> [How]
> Revert MPC split policy back to "MPC_SPLIT_AVOID". Since we have
> ODM combine enabled on DCN301, pipe split is not necessary here.
>
> Signed-off-by: Zhan Liu <zhan.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> index c1c6e602b06c..b4001233867c 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> @@ -686,7 +686,7 @@ static const struct dc_debug_options debug_defaults_drv = {
>         .disable_clock_gate = true,
>         .disable_pplib_clock_request = true,
>         .disable_pplib_wm_range = true,
> -       .pipe_split_policy = MPC_SPLIT_DYNAMIC,
> +       .pipe_split_policy = MPC_SPLIT_AVOID,
>         .force_single_disp_pipe_split = false,
>         .disable_dcc = DCC_ENABLE,
>         .vsr_support = true,
> --
> 2.25.1
