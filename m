Return-Path: <SRS0=NxiI=D5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D29C388F2
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 03:46:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F7AB2225D
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 03:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FaoVxxLI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F7AB2225D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1122E6E185;
	Thu, 22 Oct 2020 03:46:07 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C3C96E185
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2020 03:46:05 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id f19so106101wmj.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 20:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wW73XwNSS0vtdi0iQrM1VgruZpt/drHzBeMdurUmbbw=;
 b=FaoVxxLIvwFUw30nc+AmAAhQ64T6+dOldFbVdqq5skfLtvvTQlf0cyQISYseaoUza3
 HO7QAgLn9awv/KNABCskM//CdLSMZNYsyEmXmHq5nk8IFUYdFJrMm4LvkTLqqAz2YGiX
 kDFEU9r7po2cpo/FqjQXWbTCcLyBa/eFvK79c/y47dkCnBjYJiXr4sJKRZ25ULMX6PdS
 0vC+RDHmoOb69sDxZJWhrLzeft9gVtw1pDWozc5qXZxtrT4tACF0/NGZNIK3l+cuQ0TH
 v9aohzwDV0dx+VQPFlImQpHXyGlAWBNlqk8aQ0E8KO0Mn4TxD2jKo86lA7JaxYeWm17E
 +kWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wW73XwNSS0vtdi0iQrM1VgruZpt/drHzBeMdurUmbbw=;
 b=ZNvl1G/5o7uGBsD70UrvXOlCPIufVw7vOw2d4Zjko32fGJvX96Lm0peZdPZ5C7IigK
 pdADOFtFL5RuWWy4H7UcfeNQNO1/2mcpUwI799pdTchkTPa9EOY4gxCzwJ+9VWEIoy4F
 jSwHEUyWHPThFnRN35IrWbsnFmaQWwiMq0y+3zUslRt8N8DYd8fihL1Yy28OV8FG3mwj
 6wyxGwUanb9Cv6YIRgB1OdaX6K+for1jwcQscHxyzgosfeLYthEs/vpQ/Eqz47ogrJSY
 tk0YN91OecLolSaKF54DcE98ONzNN6tFX6gXrRqpoiZa0yNB85wc4dVHuJbwrWw75Rqm
 0+ig==
X-Gm-Message-State: AOAM530Nwic42ZM8ZkWquu/Va9tQ6lj1WTalKCZ3u7NVOKRIcpqMW4qL
 yuQzge9xK/W6mmKtuCPhvuGEyz+RQd4ek19EL5s=
X-Google-Smtp-Source: ABdhPJyxPsulaa9+zZBACvP9pX8prd+E7WZ0kXC3qL9MnYHQuORPhe9avymfW//I6oDJf2PDO4Ic9t9jmjRTDM/6xY4=
X-Received: by 2002:a1c:49c2:: with SMTP id w185mr486508wma.70.1603338363734; 
 Wed, 21 Oct 2020 20:46:03 -0700 (PDT)
MIME-Version: 1.0
References: <20201022034309.7568-1-tianci.yin@amd.com>
 <20201022034309.7568-2-tianci.yin@amd.com>
In-Reply-To: <20201022034309.7568-2-tianci.yin@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 21 Oct 2020 23:45:52 -0400
Message-ID: <CADnq5_MeJxe5VO1o-+x7rL-UvJGEKy3PrE7zrNzb4hxZ30Rkmg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: disable DCN and VCN for navi10 blockchain
 SKU(v3)
To: Tianci Yin <tianci.yin@amd.com>
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
Cc: Long Gang <Gang.Long@amd.com>, Guchun Chen <guchun.chen@amd.com>,
 Feifei Xu <Feifei.Xu@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Flora Cui <flora.cui@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Oct 21, 2020 at 11:43 PM Tianci Yin <tianci.yin@amd.com> wrote:
>
> From: "Tianci.Yin" <tianci.yin@amd.com>
>
> The blockchain SKU has no display and video support, remove them.
>
> Change-Id: I419cfae8b00125f3bff18c0a8cd92f3266d5f04a
> Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/nv.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index ce787489aaeb..26702c85caf8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -497,6 +497,14 @@ void nv_set_virt_ops(struct amdgpu_device *adev)
>         adev->virt.ops = &xgpu_nv_virt_ops;
>  }
>
> +bool nv_is_blockchain_sku(struct pci_dev *pdev)

This can be static.  With that fixed, the series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> +{
> +       if (pdev->device == 0x731E &&
> +           (pdev->revision == 0xC6 || pdev->revision == 0xC7))
> +               return true;
> +       return false;
> +}
> +
>  int nv_set_ip_blocks(struct amdgpu_device *adev)
>  {
>         int r;
> @@ -530,7 +538,8 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
>                 if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
>                         amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
>  #if defined(CONFIG_DRM_AMD_DC)
> -               else if (amdgpu_device_has_dc_support(adev))
> +               else if (amdgpu_device_has_dc_support(adev) &&
> +                        !nv_is_blockchain_sku(adev->pdev))
>                         amdgpu_device_ip_block_add(adev, &dm_ip_block);
>  #endif
>                 amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
> @@ -538,7 +547,8 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
>                 if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT &&
>                     !amdgpu_sriov_vf(adev))
>                         amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
> -               amdgpu_device_ip_block_add(adev, &vcn_v2_0_ip_block);
> +               if (!nv_is_blockchain_sku(adev->pdev))
> +                       amdgpu_device_ip_block_add(adev, &vcn_v2_0_ip_block);
>                 amdgpu_device_ip_block_add(adev, &jpeg_v2_0_ip_block);
>                 if (adev->enable_mes)
>                         amdgpu_device_ip_block_add(adev, &mes_v10_1_ip_block);
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
