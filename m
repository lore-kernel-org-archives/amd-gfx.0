Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 421FECA5FDF
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jan 2026 13:47:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C9F410E7B4;
	Wed, 21 Jan 2026 13:47:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="UcwzmdY3";
	dkim-atps=neutral
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95DA610E79E
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jan 2026 13:47:14 +0000 (UTC)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-8c5320536bfso700167685a.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jan 2026 05:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1769003234; x=1769608034; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yPFd5kAX+x+JPapHwkry8xE9pec/AtWEm0UrVlklyxQ=;
 b=UcwzmdY3PvBatN6DC9Dqprm/bCCuBU0j7ILgW4++DNUeqwfrCjT4oFcZ/wIr97QGRP
 0PdDGeWLWbKWL0GaFWE/nI6PgbsfexaNZ4SqPWGlwgDj+Pblb4udxv5Xbz+RDs2YAt0r
 zVSmV0I2kSok6GrkIDiIMDZ5FMIKnwH2bK6LgYAKmHWpxKua3SM81nO0JIiaARfoo5Wd
 4ZnkhZYnYD/oydqbqyIVZeAh2wSP5zbDVzn4ZKGb7Wj4k/bMN91NLDXHeEMVI4+VDRVn
 A7lyI6e7aeTuiAB7eCbuvHIBySDqDjdY99pojnR4OFR7uVCaU/lOC9Bx6YjrdPC/TMlP
 KgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769003234; x=1769608034;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yPFd5kAX+x+JPapHwkry8xE9pec/AtWEm0UrVlklyxQ=;
 b=INVhOk+EvmVfR6vycfPEs/JZkyan/3x4YOjErk6q+2VW2D6w4aTrKaEtjnjFvTazcH
 FCESDsMmPatfl29dF46offNH2JGRGAqicSxOeYTDmOxAoeFijSyGWSbZ2toMBtdanyz7
 tP24tQJgs4gGytzqsBJtau62sRepPsUJPm2WsRH6keTsUCaZpGhtAXlF/x1z3cWQkwxe
 t3WqkcekzqkkBwJq8+G+aiwDvmNI1Z8H4DbM5IWXnfIDcyeheiSYFwUUukCr0dhqM8PF
 3rOoVaU/Y8qCRtdWP5FFXWW+C6J8b00GaXgje1sDosbf6AEwIDcbKlgIvU0NSXLLxSro
 Dm+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXySqPo3MjQwbxS4IT41OyXvbBb49VY1iQgB6Q9+qqXn4dHf4eHeAwdJ+ITV9uPqXXQjyL6REH5@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzWVA8jknyfFvcgCJCcxzEx2JH3l55kcn+J0TvjcZLD7ALNJSwi
 uIx2JgLrwQBl5qvCwd27XG9O5deUKPjp5vQEKlc00uu++BmrN8q2wATO5IOLMXNiknI=
X-Gm-Gg: AZuq6aLmVv/WhwwskMYIjj+kDQOlirk+niT2FrHqGdsCOWLSdUm1c4Bke/kF8YTA+pf
 tO5t5hgAv3sf7bg40chXbOoTKU6yKfpnRYXW59pEUfHfHbuvbMcWgPbB2z5ASmbTmICjuaOA5M+
 lXw7H/vndV+/kLj5kbT9I58s7brE7YJtgr75euh2TJx+FzVw5dNMHVtNV8NCqS8xyh/xDBXW4Zg
 wfiHouyURaLO3aYZI8JIsgXhTzbEK7930eNsV6kA4GWbSbYe09IQvE08grkeH6Jm/CDz+unRNg0
 5QH0p0WoxIaokzsyNab7ebqKprN/eBIJUKZKJklFAde9o06/D/cCLZPalCLwGPAw6ZbzGSF/wWu
 /KJCOYrMu7cG892ENbRM03oJZoXoaQw/4xfOKUPFjQSGaM5+Ps7GEchbSt2IbJlZU20b1f2Mxai
 f1EHNXUUo8y7Mgs1+8HhRqKaXq6B3WuxCbiiizmmjxFqc21dB9DvokDR+njm3MGpHqIty/FmAI/
 JB3dw==
X-Received: by 2002:a05:620a:4003:b0:8b2:f090:b167 with SMTP id
 af79cd13be357-8c6ccdbf81fmr639187685a.24.1769003233554; 
 Wed, 21 Jan 2026 05:47:13 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.112.119]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c6a71ab288sm1307247385a.6.2026.01.21.05.47.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 05:47:12 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1viYYC-00000006Dum-1GTZ;
 Wed, 21 Jan 2026 09:47:12 -0400
Date: Wed, 21 Jan 2026 09:47:12 -0400
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
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Williamson <alex@shazbot.org>, Ankit Agrawal <ankita@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, virtualization@lists.linux.dev,
 intel-xe@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 iommu@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v4 8/8] vfio: Validate dma-buf revocation semantics
Message-ID: <20260121134712.GZ961572@ziepe.ca>
References: <20260121-dmabuf-revoke-v4-0-d311cbc8633d@nvidia.com>
 <20260121-dmabuf-revoke-v4-8-d311cbc8633d@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121-dmabuf-revoke-v4-8-d311cbc8633d@nvidia.com>
X-Mailman-Approved-At: Wed, 21 Jan 2026 13:47:37 +0000
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

On Wed, Jan 21, 2026 at 02:59:16PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Use the new dma_buf_attach_revocable() helper to restrict attachments to
> importers that support mapping invalidation.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/vfio/pci/vfio_pci_dmabuf.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> index 5fceefc40e27..85056a5a3faf 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> @@ -31,6 +31,9 @@ static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
>  	if (priv->revoked)
>  		return -ENODEV;
>  
> +	if (!dma_buf_attach_revocable(attachment))
> +		return -EOPNOTSUPP;
> +
>  	return 0;
>  }

We need to push an urgent -rc fix to implement a pin function here
that always fails. That was missed and it means things like rdma can
import vfio when the intention was to block that. It would be bad for
that uAPI mistake to reach a released kernel.

It's tricky that NULL pin ops means "I support pin" :|

Jason
