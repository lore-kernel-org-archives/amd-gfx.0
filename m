Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49358E7C70D
	for <amd-gfx@archiver.kernel.org>; Sun,  1 Feb 2026 10:52:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7480488C4C;
	Sun,  1 Feb 2026 10:52:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="Cqv8CE0I";
	dkim-atps=neutral
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7423610EA08
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 14:44:17 +0000 (UTC)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-8c6f21c2d81so223550485a.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 06:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1769784256; x=1770389056; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UlIFC23S9unnjQhVGEC3vUha1a+Kfy5xxpLqRiUCtvQ=;
 b=Cqv8CE0I5etEUquT1xgBZe/pjZMAsJxOBrq4Yih/3qz2svW59f1ymULImZtvDBHzQ2
 v2Z4ydPBXC/9YNMi1DNCYfSpicfGs9REsVs20Or9m3wxeoYGYuf4jBEweTW+ZnzFYlQ9
 f0+rhft5sYYl30QoQ40kMKM0WnvXgyBfz/mj+O3yFOesTOmSKrLemhNCcup4untZ5BXQ
 3arKwy0Ea6jS3Cx5FY7uVKeV7YPPliVA0i2KOpb3eeFHz+4HFYQTCPPWAclAImkF7WtN
 LynKvKflA6DkxbQC8OjbWABn3TP7EC0LAi9H+bjKmESWishZQweKVvZzckuBNltEhQzV
 DhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769784256; x=1770389056;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UlIFC23S9unnjQhVGEC3vUha1a+Kfy5xxpLqRiUCtvQ=;
 b=RhQO+olov1/R9miSB7AdVYGU4tpOzbIPLB/9xnHCyTkvyQfUaON7UzbNyM7vS3FRQG
 6aldUHIjEAof/FpVM683oXHZ6W+oskePreYr8pHmWTZ9gtjLoLx1GJVKhnFTCuTyMBjU
 Gy3ohxQCDIFKibnsPzy0+SjTCYW6DGblRdq4X2pC2Ko0FqkUskz2r8+bFRkC5/uHJdNn
 GPjumhmN5bO5APwxph8RFHMad0L0PnaJqbOS1PvlUyZgvaMtuk/QBsa9g978v72m1lJq
 eEbCNB34bZtqoxwvr2U+HLO5xEDwQxoxk2nfko5imdfS2cAP7iEfDd1OB0kSt4zNwa9T
 cC6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqiJrxvUPQE/y6A8YIO7GtggqJzXD9JX5NQkYILN0rQx8YVHSI8r1uJaXjkfq0fph8Hnut/LRs@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxjHsfQpJuvhBZK07BkRTuyh0owz1d6qWiu2F9S+xahTvUGkC6M
 fynTXJHF7zXF5qaLux/4vr2zfzzLj4S1hzsdMM6Om9eRRNX6rWshIO8JkLU+DN1kVUE=
X-Gm-Gg: AZuq6aKLWPxXM2isTYM5S+ZRia5u9MfDqTikUYUrgm1NP/lrOt9IbDdLzvpJ6cz2LnD
 qm43mkvVtsJNsvKJ3f1sjsOvkB+VeNlToXAVTpDYCkyNOAAMjnts67xVMpPXXrmozjHTNEseLRF
 LdNYfCe8CoMfvtFoX1XOpyMeoa+OSvq1NKtWcc0hq0A2w4PpGEL0mgwyyZXtIAHvW7rYgy0NTME
 /4Rrfsi0mYNMM6vJ7IaopQJzGrNcleYaPDDtaPAId5vj/g6/RDhDnjsGSW7X/4k1ndxsBcKLn0e
 hnyAgkUrY4Yjnv2OXV4VuutYq3M00IHRF22V9cZIYu/bwaOPYWRsINWf0RmMxxGnqQNdAVTmkNx
 ZgYJqLnASf+Mdgbdd7Z2nvVO8bgRxClwxjeED0KIn5W9Bpm3qfShCY0EtX7YfBsHtYM67T1c2E1
 Iaqali5qu8n+9OP9geR/oq+2huCfNCaaxcV3Xa9dYmXb9LaMweB43PvJ4ZBkf9NlbR6fU=
X-Received: by 2002:ac8:7f0f:0:b0:501:51b6:cd3e with SMTP id
 d75a77b69052e-505d21a4775mr39321141cf.29.1769784256186; 
 Fri, 30 Jan 2026 06:44:16 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.112.119]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5033745c426sm56137391cf.7.2026.01.30.06.44.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 06:44:15 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1vlpjL-0000000B0t1-0Fhg;
 Fri, 30 Jan 2026 10:44:15 -0400
Date: Fri, 30 Jan 2026 10:44:15 -0400
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
Subject: Re: [PATCH v5 4/8] vfio: Wait for dma-buf invalidation to complete
Message-ID: <20260130144415.GE2328995@ziepe.ca>
References: <20260124-dmabuf-revoke-v5-0-f98fca917e96@nvidia.com>
 <20260124-dmabuf-revoke-v5-4-f98fca917e96@nvidia.com>
 <31872c87-5cba-4081-8196-72cc839c6122@amd.com>
 <20260130130131.GO10992@unreal>
 <d25bead8-8372-4791-a741-3371342f4698@amd.com>
 <20260130135618.GC2328995@ziepe.ca>
 <d1dce6c1-9a89-4ae4-90eb-7b6d8cdcdd91@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d1dce6c1-9a89-4ae4-90eb-7b6d8cdcdd91@amd.com>
X-Mailman-Approved-At: Sun, 01 Feb 2026 10:52:53 +0000
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

On Fri, Jan 30, 2026 at 03:11:48PM +0100, Christian König wrote:
> On 1/30/26 14:56, Jason Gunthorpe wrote:
> > On Fri, Jan 30, 2026 at 02:21:08PM +0100, Christian König wrote:
> > 
> >> That would work for me.
> >>
> >> Question is if you really want to do it this way? See usually
> >> exporters try to avoid blocking such functions.
> > 
> > Yes, it has to be this way, revoke is a synchronous user space
> > triggered operation around things like FLR or device close. We can't
> > defer it into some background operation like pm.
> 
> Yeah, but you only need that in a couple of use cases and not all.

Not all, that is why the dma_buf_attach_revocable() is there to
distinguish this case from others.

Jason
