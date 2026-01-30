Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3718D49C80
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 09:22:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0890410E98B;
	Fri, 30 Jan 2026 09:22:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="PP9xP45O";
	dkim-atps=neutral
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A93C010E169
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 00:17:13 +0000 (UTC)
Received: by mail-qt1-f179.google.com with SMTP id
 d75a77b69052e-502a407dabaso11224411cf.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 16:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1769732232; x=1770337032; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JQnCcQDZjp9U0R1Q7JCyNDeekOxxS8phMo1p2crcsis=;
 b=PP9xP45OQLNpYiW6EFi2rAiTdHE26QjeyOoPnpmiUQxIYef+QJuGq5TmjrSEfndzaL
 u57hlcvAHDe8JiS9BSnz+rdZ5/yqRk7BbhUDJvOdBwpq6ijih5NGl0F65a1O+sjKDOAo
 FzMBTZzlrF5NHoYkOCEpew5QE9wFvlSUC2HYk70WEpsMAziHDgR3ZjgtlV+3+2+CnYOj
 Wdpd+/KCKH8VzBZFcPMz87uAJwD3k8TgUq+cfpft2gljOVVD7u8bmaimirV6oNONF2ZH
 U9cpI5AJrRezQ4c2MDXH2ruDfpkdo+N2pu1ksvJ66TCTpaoLwF2d5kV1tdR7unHuO0jL
 wShw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769732232; x=1770337032;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JQnCcQDZjp9U0R1Q7JCyNDeekOxxS8phMo1p2crcsis=;
 b=t6zGHWUrs6BomdzZliiV3/baC5jufBY27D1YsSZWVv1EFVA1+yKdnwBTxoeifNP2Ak
 LSl35Pa8RjK0KNMDV19IczUNhrJVvzSM2eg6HTpSwhHW/L5YbBNJHmZZHNpU48f9WGB2
 MiGNM/4OzDJBYg7a9P4y9nGDlU7SJVQFcOrMbSwGt++1uJWSPAlCr5bHREnUlXhJ6Mqm
 4oj8l5m3CIf52WjD9DMcRr5xZ5NHpLwR2gUBNviFr7VkI7oOsSl0fnFZxQY0QmaFIpUV
 OWKpNFE0hNpqIla5nr4LE44B9Tq9FYfIOMAMFnsYQCHx3B7XAKqW918Zk5USBOCJa36g
 WDRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrbdCez1AEIVstqbqjk3qsJxWZwfiOqBtoOM7x3pcpBnyaol2ljkrNFeOLHCiggh4cJL8xF1NV@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx/AvRVuV4W17I6LKab0p1vB1qW1fNXvtYBu/c/pg8bmnS/zEVy
 TlDaFY09+enNIIiy03eWrmJurArgp8W7o7EEN7v9p0uvJZwdDnUERr6rLto7UWHNZCM=
X-Gm-Gg: AZuq6aKPhzRd0doaxwzbkAeU82dneAoMtcjaYGxxWiCnBycyLGmo1A/fZ0IMn2/KZ3+
 7/chxJqQJJndnO4XPqTjGfa/CZAWmYBst8YSPeuIYWYssstmn3U0AV4i7JAsztOgOxfAbCFQghD
 7g0tCNuFdjJVrdzuvy4U0YDN7P6xl0Qx2ZFa23IV5QjqbJgXs7eqlq/2YZzn/2HdLODkBKWT7Ea
 mEIaqnH2THl1FWmLpKsGsbYk+6n2Cpp/Np8ba+MJwXVNUVRXr+5DDySh6IEIGqdC1R/4O2GvGIY
 c4pAYOLTYLqyBcl7Sir4KWQZ8Jr5+KbMm7wUYI26jZ6wSQMm0VyUrm8P6hPOKNlk3QJ3lW9B+xh
 4M85q0m1B2L/vbavBBG2lVG1nHnWaK0+ipIxrzqqVOrkU+xnH8/ygoHK5/eHzZdUw2zpJP6dr9q
 weP2P/9P/k/K9CAWkIklv8aTnOpjfrK/bgyjOG7HrTDwd5pok7uFLYhQVJ84M2fk9a4ir9JEvKM
 mFBkQ==
X-Received: by 2002:ac8:5781:0:b0:4f3:5f7b:cc1d with SMTP id
 d75a77b69052e-505d21846b4mr19549181cf.34.1769732232444; 
 Thu, 29 Jan 2026 16:17:12 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.112.119]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50337cc19d7sm45008611cf.35.2026.01.29.16.17.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 16:17:11 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1vlcCE-0000000AQZD-13C4;
 Thu, 29 Jan 2026 20:17:10 -0400
Date: Thu, 29 Jan 2026 20:17:10 -0400
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
Subject: Re: [PATCH v5 8/8] iommufd: Add dma_buf_pin()
Message-ID: <20260130001710.GB2328995@ziepe.ca>
References: <20260124-dmabuf-revoke-v5-0-f98fca917e96@nvidia.com>
 <20260124-dmabuf-revoke-v5-8-f98fca917e96@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260124-dmabuf-revoke-v5-8-f98fca917e96@nvidia.com>
X-Mailman-Approved-At: Fri, 30 Jan 2026 09:22:26 +0000
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

On Sat, Jan 24, 2026 at 09:14:20PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> IOMMUFD relies on a private protocol with VFIO, and this always operated
> in pinned mode.
> 
> Now that VFIO can support pinned importers update IOMMUFD to invoke the
> normal dma-buf flow to request pin.
> 
> This isn't enough to allow IOMMUFD to work with other exporters, it still
> needs a way to get the physical address list which is another series.
> 
> IOMMUFD supports the defined revoke semantics. It immediately stops and
> fences access to the memory inside it's invalidate_mappings() callback,
> and it currently doesn't use scatterlists so doesn't call map/unmap at
> all.
> 
> It is expected that a future revision can synchronously call unmap from
> the move_notify callback as well.
> 
> Acked-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/iommu/iommufd/pages.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
