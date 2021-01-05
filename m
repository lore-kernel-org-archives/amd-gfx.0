Return-Path: <SRS0=s2Nc=GI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C106DC433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jan 2021 17:24:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D53A22D50
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jan 2021 17:24:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D53A22D50
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 165306E075;
	Tue,  5 Jan 2021 17:24:23 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2516B6E075
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Jan 2021 17:24:22 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id x13so334028oic.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Jan 2021 09:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LvgOsttJJf/2GgkxOFUN9EuXH20POCifHtB/cOouROY=;
 b=k3vjVGWjIAh0JK7ImvixOgazbhecwOi4dIAcvQG6SAwuxsUOhrZEme+COoc167eYAk
 Gsoq94J0fYGsXDPHchPoPcPi15xU1rUQElY6tpWXKjdWcggveshvJN5ugLU8vwUHLq/d
 WmoJa2hfwIbLJH7/PbB0+V556OGa4lDoEepZJMrdnxB4sWvsvIOFh53taCrWlz7QhjwR
 MJZ+Iwg43x7TZuv35T4Ta0QCrVw9khmLeP7iHB8PBgv7+L9HimhAEM7hppeSpubq+90O
 QDQEPJreNLastEmBmKWLsuBgGTKqVeC0RoOylZY9vXCPHHtmqsjGhIq2pUnNYmFEUUj7
 mQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LvgOsttJJf/2GgkxOFUN9EuXH20POCifHtB/cOouROY=;
 b=MP/4mscIkjpqAg48tVkLkXkuQMEVA/UdR7zQJ3SYXFtDiFRiaNyeXPGqHqAfL4ZXYF
 kvc87ninP4tVrpIGHWUbEiZGt09JGZMcDMpGpfMXzdi00VTNK9mf7kPcL3oozLijdeYA
 LCusralptxdSHfw4015DUDaY8xkBApl4d+RPRbdu/5ITyYisbTxiHw+ZRwBvjusuhw3O
 AB9O3wUPOdVeARNj6NEHIfWU50VAJoVTqEbA6aiTqsFWY+c3K0OL2GpLA11E0nxrAxUk
 KVOaSJFyx4O7lxMdNAAZiXeYYNSwGDqYqE+rJA7e+s+agaX+ofqYrmzUu8xw+o+qB5ND
 NRcw==
X-Gm-Message-State: AOAM5332LE6OyBXT7wSMaiLLYgAT9SlD4cuss6TdOBp2SV6ijTrXCPTg
 MifELwxqx3OUmtUcgtvdNl7jfggErRsynVqnH4w=
X-Google-Smtp-Source: ABdhPJzwpgNSVQXmuG5714O73PC1+Fy6IRmEtBKDGYUiN2Fag7y+l3jNE3rbUep64sYDL+5QlGrxPbS2Db4vnYBPhI4=
X-Received: by 2002:aca:4f97:: with SMTP id d145mr404928oib.123.1609867461488; 
 Tue, 05 Jan 2021 09:24:21 -0800 (PST)
MIME-Version: 1.0
References: <20210105083717.468585-1-Emily.Deng@amd.com>
In-Reply-To: <20210105083717.468585-1-Emily.Deng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 5 Jan 2021 12:24:10 -0500
Message-ID: <CADnq5_NzVxXkZY1srbYcGCFVtnwTKJDXxrwj12xe-fOff_HuOw@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu: Add new mode 2560x1440
To: "Emily.Deng" <Emily.Deng@amd.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jan 5, 2021 at 3:37 AM Emily.Deng <Emily.Deng@amd.com> wrote:
>

Please add a patch description.  With that fixed this patch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
> index bc3dcc262fc2..2b16c8faca34 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
> @@ -324,7 +324,7 @@ static int dce_virtual_get_modes(struct drm_connector *connector)
>         static const struct mode_size {
>                 int w;
>                 int h;
> -       } common_modes[21] = {
> +       } common_modes[] = {
>                 { 640,  480},
>                 { 720,  480},
>                 { 800,  600},
> @@ -342,13 +342,14 @@ static int dce_virtual_get_modes(struct drm_connector *connector)
>                 {1600, 1200},
>                 {1920, 1080},
>                 {1920, 1200},
> +               {2560, 1440},
>                 {4096, 3112},
>                 {3656, 2664},
>                 {3840, 2160},
>                 {4096, 2160},
>         };
>
> -       for (i = 0; i < 21; i++) {
> +       for (i = 0; i < ARRAY_SIZE(common_modes); i++) {
>                 mode = drm_cvt_mode(dev, common_modes[i].w, common_modes[i].h, 60, false, false, false);
>                 drm_mode_probed_add(connector, mode);
>         }
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
