Return-Path: <SRS0=vl2N=PR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F039C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 15:57:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43FDD610D2
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 15:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 43FDD610D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCB4C6EA64;
	Fri, 29 Oct 2021 15:57:52 +0000 (UTC)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 724926EA64
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Oct 2021 15:44:04 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 v19-20020a9d69d3000000b00555a7318f31so2003620oto.9
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Oct 2021 08:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=LpeVRRqClpMhp45WFhauQPIkOJ6795C6SM+DoLzlFlY=;
 b=KNNg/EIySaNDh7LMiHFhPFv5D6rCFd7DjWeWdnohvmplko9KIAtxT3M9OS5iLUfzip
 8s8V95KF9svS2qy63jBjTJXws/RJANvN9Nt5Dcd184fCfUwaozAPp7Z0B/qVfMq7iXtV
 8ZauvE0PwAMkUoSgxZtgmhfIGU8I7U1VnL5WciKLvA8yasQDn7pSq59E5BL7lE3bjH6P
 MtsaYXTU9ZwoyvvBVu0dTJzyzYyx7Tx5SJ3xez4iQ4rMvP4pyEi0eQ/s5O+JiTuzHNnm
 QayTeTT/iVB/uFl0mviBAmi0AGyNk9kqk78vZQilOIGC28RkM8TPA++H/gML5I4ixTUO
 46YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=LpeVRRqClpMhp45WFhauQPIkOJ6795C6SM+DoLzlFlY=;
 b=NAJ8I6yZJZ6RLRSf+lEWXE3wJqeu3w2+XTXw/Ky83mmDECD7bRXdY9Acwz7ZqrNhoj
 ymN2w5hPiOBefVvPTjLLXM6zHNhxehHQ/gCVHC4gzk51gG9YRybG3NFAg+ko63B0kcWu
 OeWcMZu99vi59lca/pFhPROIhYTmRpm8ge147y5P2LGwPQF6Ify1qrdykt9exjE0RTh7
 EuDMVE08qaUK93H9QgrzQsrgF6MncZFI+T9NBwra/6QnJBYT542hAnj80A/IRvgSZ8cm
 QGPqI4J+sJW0zeHsbBlFRmOpTvbvgg7X+Wt8/qMcgAoXKlu4IFMhvbbuZwd/YKfj4BRl
 VorQ==
X-Gm-Message-State: AOAM5306cgB3JYYc7QrzE04jzrGZGStUj4ipg0GmiygqGae9UIdpgIm2
 CW7Si6DfGMRn7VFdnimqu3OYsY3YveVIl12o/1k=
X-Google-Smtp-Source: ABdhPJw5//+xrY3KuVpeEWFTKoMjAOZea2Qcl9ycEFKdzA3dyGUdmU+VTXme68FC/nXCOPhqHFcL9tJq68BTOwOZczQ=
X-Received: by 2002:a9d:70c4:: with SMTP id w4mr8804030otj.170.1635522243653; 
 Fri, 29 Oct 2021 08:44:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:158:0:0:0:0 with HTTP; Fri, 29 Oct 2021 08:44:03
 -0700 (PDT)
In-Reply-To: <20211013061604.3404343-2-yifan1.zhang@amd.com>
References: <20211013061604.3404343-1-yifan1.zhang@amd.com>
 <20211013061604.3404343-2-yifan1.zhang@amd.com>
From: youling 257 <youling257@gmail.com>
Date: Fri, 29 Oct 2021 23:44:03 +0800
Message-ID: <CAOzgRdadY-19Co6JfipmNjOSUtJuU+=5BToKQxdrqf83AGHw3Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/amdkfd: fix resume error when iommu disabled
 in Picasso
To: Yifan Zhang <yifan1.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Felix.Kuehling@amd.com, James.Zhu@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 29 Oct 2021 15:57:52 +0000
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

will it merge into linux 5.15 release?

2021-10-13 14:16 GMT+08:00, Yifan Zhang <yifan1.zhang@amd.com>:
> When IOMMU disabled in sbios and kfd in iommuv2 path,
> IOMMU resume failure blocks system resume. Don't allow kfd to
> use iommu v2 when iommu is disabled.
>
> Reported-by: youling <youling257@gmail.com>
> Tested-by: youling <youling257@gmail.com>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 08eedbc6699d..99d2b9c875ea 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -1021,6 +1021,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>  	kfd_double_confirm_iommu_support(kfd);
>
>  	if (kfd_iommu_device_init(kfd)) {
> +		kfd->use_iommu_v2 = false;
>  		dev_err(kfd_device, "Error initializing iommuv2\n");
>  		goto device_iommu_error;
>  	}
> --
> 2.25.1
>
>
