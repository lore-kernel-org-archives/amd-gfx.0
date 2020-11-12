Return-Path: <SRS0=wW4+=ES=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16EFC56201
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 14:24:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71B1522240
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 14:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aj20Y8+G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71B1522240
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA2286E24D;
	Thu, 12 Nov 2020 14:24:12 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FA5C6E24D
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2020 14:24:11 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id o15so6189633wru.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2020 06:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aQTOlhWbdL+xSzA5B0jj6TCD4ydGDUXLTO5gcNt+otI=;
 b=Aj20Y8+G88j0iAejOovZzNV7cgTjznSqpxsMNQ+XpSpYMV7+VUntsKmF30eYqkEy0B
 9iMyVS7Qwe9cIU5A3b6vDaVs4diKFS9rNs7cuCYzU93a2fHfIhDWbUrhzaJQlnwm0ICP
 oh6S4mItwPytx11EomkDoXoBhN5CZ+d0ky+N56djXqiX+vUC5hTNkWSgthzNMbc3AA0/
 FhTGg+XGjnJiOv3C7GA0R/wd/pKPONP19/qtyeDx4aWu8FaPGKvD0gG2Lg7ki2wJrmsE
 t56nFNQSDt0kOyCQyneT8MSKwaTt9mFuBrRAnluUAGjR/RmqxcV7FekFI5nRQCrzvEo+
 JbuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aQTOlhWbdL+xSzA5B0jj6TCD4ydGDUXLTO5gcNt+otI=;
 b=lCkNYIm7pqCS/H+AEx9LwFTqygxLLQ44JEDfFeaWnpTOUiNtkA+2DjTxiEPwn03GO0
 TnJn0izfLnZnxqLBoNuYjbLxW50DEW3nP9mSG6sTxyERumHlFRas5FUlr5ev9WhlA160
 VCgI+g26vfNRN7y+/24hnT/VIKO6LcPkr4o14zpo+jtbGF9ng6SvSfKRLFHI4qqh9PTI
 ypknf3c/DMhjVhxCyMpsPBvfKVN/gVcL7I4qTgMjGx//WFbNYZqGT17acApZCOPdnamz
 457qA1w/211xMuBPoJ9P93HE0USf8iN2Pthl8Mrmewqfev0nRQD7eC2GN4aoLo/DkWg2
 wnTw==
X-Gm-Message-State: AOAM5320cvOvFSod2FRvDy7H8ClG/MmaryVknlIXWpgjYFj8JPFq9XBJ
 iovEnxKAdzFn2uYSGt6UEK2VJmHXjyRch4KnFEw=
X-Google-Smtp-Source: ABdhPJw3+KDW4Vy+9T0sFYTECQNYfkvMgFRXpGBLurYfs+qCsIX7tq19AuCTmdT8J6EXILkks65rkUnHcrbn62FABug=
X-Received: by 2002:adf:ce87:: with SMTP id r7mr4870500wrn.212.1605191050291; 
 Thu, 12 Nov 2020 06:24:10 -0800 (PST)
MIME-Version: 1.0
References: <1605133674-21093-1-git-send-email-James.Zhu@amd.com>
In-Reply-To: <1605133674-21093-1-git-send-email-James.Zhu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 12 Nov 2020 09:23:59 -0500
Message-ID: <CADnq5_OuXH4iWR7baRsUDTO3BMe=TditrXgCqvzC1U_pb27saQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] drm/amdgpu: add vcn dec software ring enabled
 parameter
To: James Zhu <James.Zhu@amd.com>
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

On Wed, Nov 11, 2020 at 5:28 PM James Zhu <James.Zhu@amd.com> wrote:
>
> This allows us to enable dec software ring feature on VCN.
> The default is 0 for all asics, and it is only valid for
> asics with vcn3.0 and above.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> Reviewed-by: Leo Liu <leo.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 8 ++++++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 20400ec..cc47da6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -209,6 +209,7 @@ extern int amdgpu_si_support;
>  extern int amdgpu_cik_support;
>  #endif
>  extern int amdgpu_num_kcq;
> +extern int amdgpu_dec_sw_ring_enabled;
>
>  #define AMDGPU_VM_MAX_NUM_CTX                  4096
>  #define AMDGPU_SG_THRESHOLD                    (256*1024*1024)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 999f84d..570088f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -160,6 +160,7 @@ int amdgpu_force_asic_type = -1;
>  int amdgpu_tmz;
>  int amdgpu_reset_method = -1; /* auto */
>  int amdgpu_num_kcq = -1;
> +int amdgpu_dec_sw_ring_enabled;
>
>  struct amdgpu_mgpu_info mgpu_info = {
>         .mutex = __MUTEX_INITIALIZER(mgpu_info.mutex),
> @@ -806,6 +807,13 @@ module_param_named(bad_page_threshold, amdgpu_bad_page_threshold, int, 0444);
>  MODULE_PARM_DESC(num_kcq, "number of kernel compute queue user want to setup (8 if set to greater than 8 or less than 0, only affect gfx 8+)");
>  module_param_named(num_kcq, amdgpu_num_kcq, int, 0444);
>
> +/**
> + * DOC: dec_sw_ring_enabled (uint)
> + * Override vcn decode software ring features enabled.
> + */
> +MODULE_PARM_DESC(dec_sw_ring_enabled, "vcn dec sw ring support (1 = enable, 0 = disable (default))");
> +module_param_named(dec_sw_ring_enabled, amdgpu_dec_sw_ring_enabled, int, 0444);

How about just vcn_sw_ring as the parameter name?

> +
>  static const struct pci_device_id pciidlist[] = {
>  #ifdef  CONFIG_DRM_AMDGPU_SI
>         {0x1002, 0x6780, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TAHITI},
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
