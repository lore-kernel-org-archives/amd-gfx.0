Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C76A2E6BF17
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 14:15:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5578510E162;
	Fri, 30 Jan 2026 14:15:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="oRzw9hOm";
	dkim-atps=neutral
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0306310E0B7
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 14:01:20 +0000 (UTC)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-8c07bc2ad13so165018185a.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 06:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1769781679; x=1770386479; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RZzJd1rUXnKgbbFoik2J/HwA+Mcwjh2UI/kxMGq+fms=;
 b=oRzw9hOmDoaqaHWxKFEv+YWA5gxWfzMpvpPlsiUfkjLY78MvTvjld4VE2qZI4POLjK
 csDdVmtUSRTsrp8SuPRJ5vs+YQTaG8tnvFu5ndA07W7ZUvmBNlPoIsiFiETuwRI5pZAo
 JfGmAFvRwGSOc+3O1VfchL5ApdKJGX8WrVgzEugybo+sk0+Qqff4QLmtKXMVKSAl6T6m
 dMaq60hggYWq0cy1psF6yfkfDJmgKt0AjcAOHUyWQJ8WJzEykee2DvDpMFhisnETbUB4
 75TRtamprXKD3mcvO/uY9TxeUcKhxuhrSR5mMAaRXg5+M3FbGXe3VKkXaYkYG5v35VUb
 fyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769781679; x=1770386479;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RZzJd1rUXnKgbbFoik2J/HwA+Mcwjh2UI/kxMGq+fms=;
 b=DaryAsrAxqU1zOjeu0wKhueNNr54/PC4XdY8SOkFb6dvV1C7SGRpUZb9DwDeofzTm8
 sBrL3GQ5VsgIBB6NGwmXRxvXXHzX3nVmmMcQrbznYcexe9patLjKgpe9+mvzA/9fu+gF
 7kcW+13FEziCf4ed9lufCS8JJo1UEnWcL/sodTdAEZBOASJEQhRwO0xhz/JZaRD0fDPw
 O0lB1ZjLOIiPqCcmhdIJQYe1XYFwX70nwCJ4pf+bI1o5eNEYydpoEmY/HkbHU8RAYmNw
 dzRdg82+hkHtdcRA/VSd0UUoDgjShiBwqXYXvI/A7/u2ZVv2NQcY6gJXr00BMF0xIsD8
 Vkkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgPUC8hI1Icj9s23fhEaODM7GTjj2Od0nTgRzPWGh/iOkTXnuUvZX4zh/DqmgGIKGmqNOBu7Vq@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzRYPwr60jOftwj6Vd0l6d8MJ4+SosolmL9yC4nW71vqPzXz6sA
 6yrQkbJoX9XOmyR1UzzjhulUL5YEGz0QkYgOauXtPiuBDWlpGBAcMklDj2K+97oE1uk=
X-Gm-Gg: AZuq6aJrPQSXqca12PkSxRwPfXogfQE1/8hASLpCCT27GEcuxDNGRqAEQaTgp/wpR5S
 cUxGx4Ga9sjwQr6TLaeubIuD1fdlZQfgoIvo7Dxxy0ZMoCZiP5WN+BW9zfsMSO95lxUrDJpb4K/
 KvZS5hCpik+Di6Wd17wekolBAQuJPFsjRybRoYXXMvzxvjAy7aN/KbC+g/5tYSDO9A7HC6ue4mD
 hQWG3YOgOuAHfkSyoTpD290BnknviBkDNZSZ+tcalBkLGRIgy2amzAmsR4hjHs2DdVK1cOVdzVM
 +HygIXwUIiQF+CdoFBR1jZ849PuU1XAMIiwj5fR2bntPyXQ+ShF1kEeZKOvn8fO0QTRgfn9mE6a
 XUpyoU83saiNk1988+6zVcnZshNHprarxU8Hi9cLs5WBS2Gght9nqp7Q4OpWUBBhPsAVQgIIBkN
 m/1dCokAjt5RcGpri00I05sQBHck6diajoqezt2FolJh28ddR4uesddAtYBnwps2D2++53EsFpa
 XxJYg==
X-Received: by 2002:a05:620a:290f:b0:8c3:650d:577e with SMTP id
 af79cd13be357-8c9eb224827mr368793585a.4.1769781649371; 
 Fri, 30 Jan 2026 06:00:49 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.112.119]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c711b95e4esm700915485a.15.2026.01.30.06.00.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 06:00:48 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1vlp3H-0000000Annc-1AWG;
 Fri, 30 Jan 2026 10:00:47 -0400
Date: Fri, 30 Jan 2026 10:00:47 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Leon Romanovsky <leon@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
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
Subject: Re: [PATCH v5 6/8] dma-buf: Add dma_buf_attach_revocable()
Message-ID: <20260130140047.GD2328995@ziepe.ca>
References: <20260124-dmabuf-revoke-v5-0-f98fca917e96@nvidia.com>
 <20260124-dmabuf-revoke-v5-6-f98fca917e96@nvidia.com>
 <b4cf1379-d68b-45da-866b-c461d6feb51b@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b4cf1379-d68b-45da-866b-c461d6feb51b@amd.com>
X-Mailman-Approved-At: Fri, 30 Jan 2026 14:15:21 +0000
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

On Fri, Jan 30, 2026 at 09:43:22AM +0100, Christian König wrote:
> On 1/24/26 20:14, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Some exporters need a flow to synchronously revoke access to the DMA-buf
> > by importers. Once revoke is completed the importer is not permitted to
> > touch the memory otherwise they may get IOMMU faults, AERs, or worse.
> 
> That approach is seriously not going to fly.
> 
> You can use the invalidate_mappings approach to trigger the importer
> to give back the mapping, but when the mapping is really given back
> is still completely on the importer side.

Yes, and that is what this is all doing, there is the wait for the
importer's unmap to happen in the sequence.

> In other words you can't do the shot down revoke semantics you are
> trying to establish here.

All this is doing is saying if dma_buf_attach_revocable() == true then
the importer will call unmap within bounded time after
dma_buf_invalidate_mappings().

That's it. If the importing driver doesn't want to do that then it
should make dma_buf_attach_revocable()=false.

VFIO/etc only want to interwork with importers that can do this.

Jason
