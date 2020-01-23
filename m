Return-Path: <SRS0=UzQs=3M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC1DC33CB6
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jan 2020 16:08:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33B7C21D7D
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jan 2020 16:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqAjZxjK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33B7C21D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B28C56FD79;
	Thu, 23 Jan 2020 16:08:19 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23D8A6FD79
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jan 2020 16:08:18 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id q10so3675573wrm.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jan 2020 08:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IVJt6YaGaLYB6N0jj9kbgPx3/lE2hDwWRI0Z5mihtIs=;
 b=eqAjZxjKLf/o2VDJCiZ1Pgdvv9ifunP+hB+Qb2S1z8asRRZ0i911QGf0QhpF6NXLoy
 LHShpoyYuzhmOPWLq6T31n+CTY0aNeCMYock2v+Lak4D34fnypO3QG7dPmCp9ba/KW5n
 Mfg8NjSbR5NEp+5bcD35+M7XBNZOBbWoznnfbjfCaxqxZ337ZbOrXMwMblRdFxcFgbxn
 BEagtRhtC2/Qyp4zYLoaYqSV8kUPlyEMw5qHreR8RrhP+sUkLLpoVjrVTEZuz04eQOZa
 XUa4Bq7UpIj7tE3I1B0D1f/rjQDdFjR1pQOcUaSf9xna4YnorG5jWh6kYdcH1BbGBr/r
 E+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IVJt6YaGaLYB6N0jj9kbgPx3/lE2hDwWRI0Z5mihtIs=;
 b=l7LmyfKzdFwKZxtvDWM1kyspuit0TAV50MgXra+dk0OHXbbel6bQhGiH55UNTxtxiV
 B5vkzOziCfkWGFrXh2wPlt+ZZxzPwsRo/t7AVhwGvHW6YQJnohn7ZuG8xY29AUP9WxwP
 G0DL1VuR4gyYhxDeH8YXHH6qzdlY0ehk6t1/BClnh/JQCAhliTZGUeyRMtgDeXnxxDU1
 Qx6sANWB6LSrAbSi0stNk/C1KrDfdmqLoQHH+4uMJ3q/6Su2l4l2eJo3JWqWw1rNJx8J
 Vy/5iXBm3IdfpRf9f0NeM4moghO3w7IZaLiJYbNhRZfQ7l3+srRREClNGWAoctANJNPg
 dMEg==
X-Gm-Message-State: APjAAAXky+vkB1pVfy3ZPUNytgrRuMITwGGPc8yoQFbzeLdMywupwvWT
 fRUBVeqinj/RFCaWhB3iTDLCG1LA9XwxjciSeWxBAA==
X-Google-Smtp-Source: APXvYqwFVUjNHoD/W/5yvBcD0ql8OZGOajiP1e0L1eUySpnaOos2PjhGBHyxK5bIel7bzvol6+ttjXmMcaTnG6VsA0s=
X-Received: by 2002:adf:f2c1:: with SMTP id d1mr18114142wrp.111.1579795696620; 
 Thu, 23 Jan 2020 08:08:16 -0800 (PST)
MIME-Version: 1.0
References: <20200122164623.239931-1-alexander.deucher@amd.com>
In-Reply-To: <20200122164623.239931-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 23 Jan 2020 11:08:05 -0500
Message-ID: <CADnq5_N4_oaHNXHcXj79-O3d-y+v=ZrEhnJ=MhtfYm-5ixgzCw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: remove the experimental flag for renoir
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping?

Alex

On Wed, Jan 22, 2020 at 11:46 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> Should work properly with the latest sbios on 5.5 and newer
> kernels.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 01a793a0cbf7..30a1e3ac21d6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1004,7 +1004,7 @@ static const struct pci_device_id pciidlist[] = {
>         {0x1002, 0x734F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI14},
>
>         /* Renoir */
> -       {0x1002, 0x1636, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RENOIR|AMD_IS_APU|AMD_EXP_HW_SUPPORT},
> +       {0x1002, 0x1636, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RENOIR|AMD_IS_APU},
>
>         /* Navi12 */
>         {0x1002, 0x7360, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI12|AMD_EXP_HW_SUPPORT},
> --
> 2.24.1
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
