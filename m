Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA43D2ED11
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 08:26:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0A9B10E583;
	Tue, 20 Jan 2026 08:25:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="Q62jz8uV";
	dkim-atps=neutral
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C78B10E4D3
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 16:59:53 +0000 (UTC)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-8c532d8be8cso429876585a.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 08:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1768841992; x=1769446792; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TPsA7s1a/5IQbuetD0KLnhoW9jbCMPzN3lJpfuVRncw=;
 b=Q62jz8uV0DbYXz1eUwSSsgNGb8yJitOTmzwFBHjedovTKxO9kptsWTHf7cOYlL30lA
 ZkNVS/v3U0sEym6GEKnApPKdXSsDXUfIY/puyE2doNQQO5LZGKzL/mjj28BQYQlySSy1
 xBz8RjzqWLW3dRd6nAbi4aTIZvKJkhbhVFxUUOBBDDXlm4MsBdVkEd4Sr4UBZtc0T4T2
 YUdh/dOS9L2wcduPAp3CS/SWIoqaTzaeK/IqxcTLrctYqi/fwkOGU+N4b6ImnBCYjztK
 h71QJ2PcMee3vqoexpfK2k09a5W4l74AVYTziQdiKTKNCDdLL8F8qK8Ef+QeANaJS32x
 RgqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768841992; x=1769446792;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TPsA7s1a/5IQbuetD0KLnhoW9jbCMPzN3lJpfuVRncw=;
 b=dpL5i7p6QCiplwFUeSEyFXbgMi16kjPPKR+3DQiWx9Hrm4zKEbOipqz067EpA3Sa6U
 7QDjoHmqv6uDNWHFzYs8W4xHclHePVnHnxQ6rUI40493CPrMH4kdahDplPna240Hl4L7
 6t+aZV73QntOBef5shv7I9h/uUsqM12mji85b+haChJ0t4vR9y9FNkghEe3Ho9siPQgd
 yTIOXtIn4QUyb7bPCLWP9chidun4FzmH+4RfPHiU2NQUSmF47zC+0UPplZT0u+SV2KMS
 dcL7+D4i4LvXSNvgBx/Mu6sPW02P41Ic4YTrC57RgFtrkFSWARziEoxGxm3dgOEJn1f/
 pdYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2hABkzaTaMWVPjMcnz7z9X7sbJ0D3fRPWh8R6i2RAoZSFce6h/0PpWhjWpbakg9Dv+PWpTuRg@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxeYsfQ3R0/4VVD9Ee5/wRoCzL+ul9wU8dTRO1X1c+lVVZsnvvJ
 LgOlEEgSUuRxDRBp9ELUdtwUFmdx+KYy4ugyMGBPHtRlnosmmWFttOT//iGOHW3Gf7k=
X-Gm-Gg: AY/fxX5u+jQLrebpZm692mN8hujbC7NB1xYQsYgy5iV1Tx7zYgqqKDah5Ya/m3zNoRL
 t7CUq38QCcZKt4uVdUfy0FGNd/+G7g5MgSo1zNGvg1izTxbmZTeG0AHFUafbnIwMCM0hdDFIJ6L
 KhfmQBFKUDU1CL8JkIQ5d4OYLgWJfmtZ3K7jQK8VKxwlEn/zUfBQZ8rF8PXLOzajjBCAs5dMAqL
 c3H1CMpsz19F36gVAbWF8y59Qdb3HpEejS4hUfbIa0V5Ek3l0E6E/guefevMzIAnZ+YIQ9pMoyd
 RAnJBVi/r6V4vM6o+X90nezdu7bFxplFmU9on9VEBjspfa2mt5FPn0HyAHVN0BRX+W83MLRAOuX
 1Dbt3b4KDP1VMGchvlmI6eRXCjv09IkYC8MRnJ1dz0r67/cqubcg+1Yy9BIT9zBOYMXFXvYurau
 5s27VZKaImEpT/Ovo/cHhd41rTo8wiDi+vKC/pZ8vKpZm3Bl/Osx9VSK1mokA7YWJxQLQ=
X-Received: by 2002:ac8:7f56:0:b0:501:50cd:cd3a with SMTP id
 d75a77b69052e-502a16b363amr184663241cf.43.1768841992288; 
 Mon, 19 Jan 2026 08:59:52 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.112.119]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8942e5e4d79sm93947786d6.2.2026.01.19.08.59.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 08:59:51 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1vhsbX-00000005IQz-1QSu;
 Mon, 19 Jan 2026 12:59:51 -0400
Date: Mon, 19 Jan 2026 12:59:51 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 virtualization@lists.linux.dev, intel-xe@lists.freedesktop.org,
 linux-rdma@vger.kernel.org, iommu@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v2 3/4] iommufd: Require DMABUF revoke semantics
Message-ID: <20260119165951.GI961572@ziepe.ca>
References: <20260118-dmabuf-revoke-v2-0-a03bb27c0875@nvidia.com>
 <20260118-dmabuf-revoke-v2-3-a03bb27c0875@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260118-dmabuf-revoke-v2-3-a03bb27c0875@nvidia.com>
X-Mailman-Approved-At: Tue, 20 Jan 2026 08:25:58 +0000
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

On Sun, Jan 18, 2026 at 02:08:47PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> IOMMUFD does not support page fault handling, and after a call to
> .invalidate_mappings() all mappings become invalid. Ensure that
> the IOMMUFD DMABUF importer is bound to a revoke‑aware DMABUF exporter
> (for example, VFIO).
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/iommu/iommufd/pages.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
> index 76f900fa1687..a5eb2bc4ef48 100644
> --- a/drivers/iommu/iommufd/pages.c
> +++ b/drivers/iommu/iommufd/pages.c
> @@ -1501,16 +1501,22 @@ static int iopt_map_dmabuf(struct iommufd_ctx *ictx, struct iopt_pages *pages,
>  		mutex_unlock(&pages->mutex);
>  	}
>  
> -	rc = sym_vfio_pci_dma_buf_iommufd_map(attach, &pages->dmabuf.phys);
> +	rc = dma_buf_pin(attach);
>  	if (rc)
>  		goto err_detach;
>  
> +	rc = sym_vfio_pci_dma_buf_iommufd_map(attach, &pages->dmabuf.phys);
> +	if (rc)
> +		goto err_unpin;
> +
>  	dma_resv_unlock(dmabuf->resv);
>  
>  	/* On success iopt_release_pages() will detach and put the dmabuf. */
>  	pages->dmabuf.attach = attach;
>  	return 0;

Don't we need an explicit unpin after unmapping?

Jason
