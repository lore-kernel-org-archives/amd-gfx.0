Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AFDEE87845
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 14:05:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B178D10E653;
	Wed,  4 Feb 2026 14:05:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="Zlkv2MNP";
	dkim-atps=neutral
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5B6510E368
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 13:35:25 +0000 (UTC)
Received: by mail-qt1-f172.google.com with SMTP id
 d75a77b69052e-5036d7d14easo69348981cf.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Feb 2026 05:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1770212125; x=1770816925; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cy8s41Ej9e437sslVRAHtURD2nYFlOPaZF56zUYznoI=;
 b=Zlkv2MNP6ARr+aoVWTKOVz9KBe9L++DgVe0XIUHG5GI4rcfLiESP/T2ErBvbO8JFdN
 FFAtdUbtoJ+LYy/AewfKJvknHLQpcASIs4jH5Tx8WcBnsSkdmWr6ek9gO1t4NOS03P8W
 iofvuY4ceo1sHgrnErGJPxrn9tdcD+bvxNuLpbo47OVS9f0wHOVL636OuRWes3WJlxLJ
 07C4jom2B/c6Df4wjFUyJHLZFXd3D939y1k9sKK5wMkeLHyVgu+WdYcUywB4U+0KIWAV
 QQIAA1GubAJVdgb8WikVdGHkUxZvAJLVTKUrHwkL/PqWcGbL01E9SZJPwlAXCEaWLyNu
 F0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770212125; x=1770816925;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cy8s41Ej9e437sslVRAHtURD2nYFlOPaZF56zUYznoI=;
 b=UoyUqvEKaohPmU7nuaSkP5h0lGr3TDfULwJrJcYZASXQHxDAdXrYTBAwU7yZ4axz74
 rDstNhj8uRB6Hab2lHDsAeTWFrOqTPzpD/hK0f67sdgtggBN8orzPWBY7gDkO4YBwkhq
 tBJWUyOjSB5APxCIjM5JPufrG5PNuJV266LviCs5mvLcaeVajMk9PtUxUX5CfdsZVNWL
 IDb8iMJMZ7RTa5ymgai4FwyZRGA9PHCDWC6ZnNK7UmVO2DjjHTRUqy+vLkJNiWdDOvX6
 SN0NxB7NE5H8O2U7oVc8ysTizgnw0u055pMurlvgVaj4UJhtldXZ+yK5JCCTm5KbvZ1a
 vyBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8/+x/i1ZRzkg78NmnEO2hopYhe9UYCoaR5j2+F+Y2nsgsHflIl0027alqNb+BeL99halc7T1+@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx1Oky8URpnXpEjbplDKOSv/Bf85HnixLl3Q1aeRR/MkOTGG9r+
 GesS/W2jIeNIOZIUPCenOd7pLZFry+6FLoBeCAVClBTBmfq4+Xk330oDBxMQyXH/L0w=
X-Gm-Gg: AZuq6aIi7TRZeGKSxfoX84LlW9vZIN0yqyt9zI21grMzaxFERpPzfqI4OvW1cdXLrce
 ATuuZ+5TDBh8NHIJ/Uz6830gwZ4YvkIM5pSQXxmF209OQlgS7Ni/Kdfqsch02rcblF7OHxAlXbt
 Wy8URLZTN5tQ8PpULghoMysls3I6asIFN8jAsMM9Bf5vxeDJvaDLVBfnAk3KwLCnZC0dc5uQuR/
 6A4JEQTYMhkqYx/HZBAscznniXMFs4n6gbpwgrEJtfuZfiE+wc/yj45NudL29rouRtiT36H/dVa
 jz3XU2HW6pPXbbiUEHKJ+OW+wyU2qB4j7Im92be/JszU+SNdal6v4PLxYZCOGzioPjR6v6trQ+E
 FpOWU591RUytOkSIunFky/IQa/0TaYW/DCSwCMhxO56DX7WCp7O6BlJ6CcK5L3uQO1HgqNFbVRB
 GBf0QWTJjeSNII5M8hy8K3xGmB8UcWqnIdZpt001QaTYYHAwi83yWH13mLHbysYpzWyHw=
X-Received: by 2002:a05:622a:1aaa:b0:4f4:d29a:40e7 with SMTP id
 d75a77b69052e-5061c1c1dc5mr32950871cf.74.1770212124739; 
 Wed, 04 Feb 2026 05:35:24 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.112.119]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5061c17babbsm16346801cf.15.2026.02.04.05.35.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 05:35:24 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1vnd2R-0000000H0ml-1uPP;
 Wed, 04 Feb 2026 09:35:23 -0400
Date: Wed, 4 Feb 2026 09:35:23 -0400
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
Subject: Re: [PATCH v7 0/8] dma-buf: Use revoke mechanism to invalidate
 shared buffers
Message-ID: <20260204133523.GD2328995@ziepe.ca>
References: <20260131-dmabuf-revoke-v7-0-463d956bd527@nvidia.com>
 <20260202160425.GO34749@unreal> <20260204081630.GA6771@unreal>
 <6d5c392b-596b-4341-9992-aa4b26001804@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d5c392b-596b-4341-9992-aa4b26001804@amd.com>
X-Mailman-Approved-At: Wed, 04 Feb 2026 14:05:23 +0000
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

On Wed, Feb 04, 2026 at 09:54:13AM +0100, Christian König wrote:
> 
> Mhm, sounds like AMDs mail servers never send my last mail out.

Oh :(
 
> As far as I can see all patches have an reviewed-by, I also gave an
> rb on patch #6 (should that mail never got out as well). The
> discussion on patch v5 is just orthogonal I think, the handling was
> there even completely before this patch set.

Leon I guess grab the reviewed-by from this email and we have a full
package if it needs a v8

> For upstreaming as long as the VFIO and infiniband folks don't
> object I would like to take that through the drm-misc branch (like
> every other DMA-buf change).

No issue here, both subsystems are waiting for this..

> So as long as nobody objects I can push that today, but I can't
> promise that Dave/Linus will take it for the 6.20 window.

Sure, thanks, and if it doesn't happen for whatever reason lets just
consider it pending for the next cycle.

Next is to work on the dma mapping type, I should be able to post a
rfc next week for people to look at.

Thanks,
Jason
