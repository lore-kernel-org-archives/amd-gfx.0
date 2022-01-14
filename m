Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E51AAC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 14:56:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5539C10EDAE;
	Fri, 14 Jan 2022 14:56:39 +0000 (UTC)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3288910EDAE
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 14:56:38 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 35-20020a9d08a6000000b00579cd5e605eso10366948otf.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 06:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HXQISz6uUvwg8Vwt1+DIrxstrllwfzEuYjBo3yyTGQk=;
 b=KvyUbQkcGR3KApmkiZfu8C5xmBmzwpDOMQhR6WXG3miM86IPV6nfbAa3aqFSmkFIT4
 Io0wuqtpSpPfNvf2LkobGgtBXIiwpomuyI+x1Co09hZAF0EukRzWIEXi2XhrJZbThuWm
 UaJiYglKy6n6Yo1uw5Pqak6Ypb3N5cauggsXotdIs9wGfgXMjKqhcOwTSfFu4BFKaxEH
 kRQt0iOHxYWNkvVJPOBQNq1f356aEXVVIRTYJzY7C5+fKyVicWrLJALyIE831d4J85AM
 AKHNBV6dSiTSsKankfwnDqKPgqXdWyjIIw4JUt9kYQvtN9XfGuEqLx703FctdeIE4NgB
 mJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HXQISz6uUvwg8Vwt1+DIrxstrllwfzEuYjBo3yyTGQk=;
 b=raTSXYcpIhjWxRcBQ0eFs0HAXWqJZBxnZRjomNjPdIWNQPJB933sdI/hy5EobmKuZI
 3hIz3a5Pq3XVKsUgyd0IioWlbz9qCJu6Y0oBe995vlxzAqISpsV2LDMmdOMkC8spQ84G
 bh7MjHd5EYYt+ERr9HHdcCedcMIXQCvwVMJkUiyJO+4yw12CfGtsiZrXV3rOaEYuc97U
 cq9dVSwChjMIcgwiK5tixbLyCNCVVBwmN5u0OL3bnJueugFu4WJaqTw1rIx4TrUFEYsy
 TqRb4uC7UNLKffG4AZbfbRKeGXdLqUbDnDlUsvbiYvEF26ckLpKpGyKX1Lwqo8Uouepd
 K+lA==
X-Gm-Message-State: AOAM531KLnlAgD7mVXiJ5jxNibb9jll75tJGecp0ziYCc9aZ0gyLKyQa
 RzqjAHouKgGdj8QXosz7qaCwdzHRSW2c8RMkdd0=
X-Google-Smtp-Source: ABdhPJzDS22hiVXyfeCFx1bY6D/SQdYj6JjBOobUXzm4JrBhml3GZ+MsD+6xfd1BH+kWL3QLJAIFLT+r2hQC+tMsiGY=
X-Received: by 2002:a05:6830:19e6:: with SMTP id
 t6mr4712317ott.357.1642172197491; 
 Fri, 14 Jan 2022 06:56:37 -0800 (PST)
MIME-Version: 1.0
References: <20220114065141.14506-1-lukas.fink1@gmail.com>
In-Reply-To: <20220114065141.14506-1-lukas.fink1@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 14 Jan 2022 09:56:26 -0500
Message-ID: <CADnq5_PBt9-x9d9TuW7_0Yrarpmp2bMTdDPXFv2ep=p89sULkg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix rejecting Tahiti GPUs
To: Lukas Fink <lukas.fink1@gmail.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 xinhui pan <Xinhui.Pan@amd.com>, Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jan 14, 2022 at 3:27 AM Lukas Fink <lukas.fink1@gmail.com> wrote:
>
> eb4fd29afd4a ("drm/amdgpu: bind to any 0x1002 PCI diplay class device") added
> generic bindings to amdgpu so that that it binds to all display class devices
> with VID 0x1002 and then rejects those in amdgpu_pci_probe.
>
> Unfortunately it reuses a driver_data value of 0 to detect those new bindings,
> which is already used to denote CHIP_TAHITI ASICs.
>
> The driver_data value given to those new bindings was changed in
> dd0761fd24ea1 ("drm/amdgpu: set CHIP_IP_DISCOVERY as the asic type by default")
> to CHIP_IP_DISCOVERY (=36), but it seems that the check in amdgpu_pci_probe
> was forgotten to be changed. Therefore, it still rejects Tahiti GPUs.
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1860
> Fixes: eb4fd29afd4a ("drm/amdgpu: bind to any 0x1002 PCI diplay class device")
>
> Signed-off-by: Lukas Fink <lukas.fink1@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 9ec58bf74012..224d073022ac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1903,7 +1903,7 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>                         return -ENODEV;
>         }
>
> -       if (flags == 0) {
> +       if (flags == CHIP_IP_DISCOVERY) {
>                 DRM_INFO("Unsupported asic.  Remove me when IP discovery init is in place.\n");
>                 return -ENODEV;
>         }

Thanks.  Actually this entire check can be removed at this point.  The
IP discovery support is in place.  I'll send a patch.

Alex


> --
> 2.34.1
>
