Return-Path: <SRS0=nWm5=BC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0C3C433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 20:23:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CAC62065F
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 20:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ieT93Cda"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CAC62065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 425A76E284;
	Thu, 23 Jul 2020 20:23:27 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 415386E284;
 Thu, 23 Jul 2020 20:23:26 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id c80so6095932wme.0;
 Thu, 23 Jul 2020 13:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ic3jTqBcuk4A2YnKQnoJUoi8ZVAuMeAUsxIP8au8VqE=;
 b=ieT93CdakDSdYVpLpHmyLQvPa9yuKZSLL6sCJMJiabdIduu39BfQVsyevEzx4NrHuv
 zpYfdrMOFqKetrD2mjQXWl7EEGY/3j/T8uM2M5qeMfDlSbYFpXTSb+zwZ9X+B1Abi4vF
 s2t9KD3qnbzlt9gQ0DI2YlEX2c5LKImAQ5eCMcBs0mxk19IPUso7yVQq31LkaRsd4xH/
 pAAQ4e6vXFZM1IxTSQfTs5Q98a7yEUN4jW9sQzKcIFsyc3PgkthOGxArOO0s6/UBqgEM
 7RwM4vmbb23BM7A4aNW2kdyo/6YIydu/ZNXdKY1FioSuNqdiaeev9qYRebUXJ3PPAlhu
 h1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ic3jTqBcuk4A2YnKQnoJUoi8ZVAuMeAUsxIP8au8VqE=;
 b=VV0hBkyOz7SyS+f09mgXpwgagNurZ1RnFZzVH7kO9YNJnLOajnmE3ydE54d1Ciin2q
 XY4mZcZVSeM9/RL3e+n4uPMEkSSsyi4as/AtUiEY0jMfEP/sk521SDWTolRwVn09nxKs
 K2pjCnZKma8XvI0oGavmIZjneH5smpnpXuD7WYToR9uzdKbtHEkRSuzHCXlX8XlQyJrq
 lxXgQBBMUYAUBOHVCdd1AsTtc9OB7cEOxipK+NScmu8KK2YOmGNf1FKXGMUDMFic8iGO
 iaosOZTPTU/PFXDv4m1OsL2bjtB5jhsLiPm4R1PYvN2nFqXeR2Fx8tTTb60VeBHUS8Eu
 noMw==
X-Gm-Message-State: AOAM5307zBDguNkDmWAj4PLP95lhZAhOkhDVfNdVCOseUNck3x6JCQmc
 Wr2mecUsYFb5PvhgWKlEzRffhIS3RLrTOFGtH1Y=
X-Google-Smtp-Source: ABdhPJy1tsbBRn7UN6iAjHTn7BzaU6FZXUYje9C8iI+iChyo2GYaMNOzXLHpF+2C2xvdYtvzOURwGwbq/RlvI/UVP30=
X-Received: by 2002:a05:600c:252:: with SMTP id
 18mr2311976wmj.56.1595535804824; 
 Thu, 23 Jul 2020 13:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200723143637.991988-1-colin.king@canonical.com>
In-Reply-To: <20200723143637.991988-1-colin.king@canonical.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 23 Jul 2020 16:23:13 -0400
Message-ID: <CADnq5_NicLnGDbk6XsT4Ux1nPNNgDu84kAPJfGJANQ9YWrcFuw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove redundant initialization of
 variable result
To: Colin King <colin.king@canonical.com>
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
Cc: Leo Li <sunpeng.li@amd.com>, kernel-janitors@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, David Airlie <airlied@linux.ie>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Thu, Jul 23, 2020 at 10:36 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The variable result is being initialized with a value that is never read
> and it is being updated later with a new value.  The initialization is
> redundant and can be removed.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
> index 5d83e8174005..0853bc9917c7 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
> @@ -1017,7 +1017,7 @@ enum dc_status dce112_add_stream_to_ctx(
>                 struct dc_state *new_ctx,
>                 struct dc_stream_state *dc_stream)
>  {
> -       enum dc_status result = DC_ERROR_UNEXPECTED;
> +       enum dc_status result;
>
>         result = resource_map_pool_resources(dc, new_ctx, dc_stream);
>
> --
> 2.27.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
