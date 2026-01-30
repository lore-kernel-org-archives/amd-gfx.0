Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E75BE6BF17
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 14:15:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3703C10E09F;
	Fri, 30 Jan 2026 14:15:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="Z8deGvD3";
	dkim-atps=neutral
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6CB910E100
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 13:56:20 +0000 (UTC)
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-88ffcb14e11so27843266d6.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 05:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1769781379; x=1770386179; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nHaCd4HrbYw78ScpRIoaj6AeaBJaVtnx8urFDLScj1Y=;
 b=Z8deGvD3MtWtmdYm4TJCnWvkKNM3+syMTy4LW3kivOuC6AARMfvNm9DAkVbu0iM/Xt
 xgKOWKatpqV6Yp6usrQAJnM2nHGu6NKWGJkHXUbAch1qQls/fuo3f+UXLsmZD8Tz4NW7
 FvI5mb45CpOdYnqTZ3T3nGvXeit8Zbo6Z04C/DpTvNbMksjDEnTYLBljgYcpCk3dSWtn
 efjLiLkMULvwmSk+7xUFGArERe/8pTQxFAmRsqC3aCbRAO8SRGR5cs16CLoD3lTbvHN3
 9Ltr1hVT3ESfFITI9AjPLIMdSS24LsjA5GxOCHa2V7yItDjPsdl5IAb4W5QYoqAosQx8
 ZsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769781379; x=1770386179;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nHaCd4HrbYw78ScpRIoaj6AeaBJaVtnx8urFDLScj1Y=;
 b=jfvDQXndylhXW5Vb3cvOrX7UYb+GcOLIYawvcGNMFxEhEdxA10guQPxJF/n+xV06Kk
 P+J71gRvZyMv4Xh/cEY5xJCjWySeuAACZ9EWZsuMxQticSyEmUla2p6jJ894WZMnUQSS
 79HvVshdCy5ab3+qyuBa0iRFaHACWns/u1ahuhqIpYXYaV48tVU2kcjqW0r0reOmtHA6
 685UvpQN7kHhKmItaiTPRKgiKUm575rmPoCx2tJ7qaGuw/E2QgclgeNY/B0FuscV5bdD
 CCPti6w3N9RvVjbzr75C3cNJA2tPD82nP+MQ9VjHvJwdNT4EFXzb7ab+gl/haXbK28kC
 pO8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWovolVUIskjw0Uwbx3Z6TDALACgA3Mh/aVGMLHzUgenR3nUZkMPCpcH98MVmdBp4c0tPTgbdVb@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzYIIojELTIseoAJNPJ7LL4oO/w4iqo5Ad+2dqNxHsnFTdlx/Fn
 pm8nUPDcS6Rjf/TUTH7Zp76T5lR9SeoBtv8xKvHGvMiwg+a2gPKhnlHr7cGPmzRZzHg=
X-Gm-Gg: AZuq6aItchYc9VH9LNSMFgQ4UXl+3oBIWyg93dBA4YG8ObOh7cSRWHijdvOqpPn9N09
 WsLD+Lt6LAjUZ2B5j3dDSUEwTrwKm9ZgOj0HP7iR1cy7K7UqFSqIXVX/IlqP7IaL0DQ6s6k1o47
 fQv0681ldsOm1MUjcW6/h2zaJtjWVfWYtUcSoEIJksMhsqVzkVBLPy1rrR0pVdpephHonDa4I4b
 IEPYIht9A/3LWfaeBwXs8pLtd1gUubMkRe6KGErsLldDLi6kn+HKokdYOCHsJtRQHo9PXL7GG3n
 Htl3leKES0/vd+qH7CJofCXg8IWGXgcrtnH/6/7S3U7g5j/SJePIn+dE5O8fbvomriKokZtRR6D
 nImcvKjU6gGKTtVk9sund47wMhjJIn94BCdL641gp1Mf6HsBbN8tJ/nltdwLN2m/9S2WmfSQEuJ
 E3yiAQ6tmgnmm9sIvFjuvXzH0w4nnqYvynR7dMO42s2NebGDNUD70qd1TcGCjBmUw5g/2oIKc7i
 XCYdA==
X-Received: by 2002:a05:6214:2a48:b0:88a:529a:a53a with SMTP id
 6a1803df08f44-894ea09691emr43666386d6.51.1769781379597; 
 Fri, 30 Jan 2026 05:56:19 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.112.119]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-894d376da66sm59670316d6.50.2026.01.30.05.56.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 05:56:19 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1vloyw-0000000AmRb-29H1;
 Fri, 30 Jan 2026 09:56:18 -0400
Date: Fri, 30 Jan 2026 09:56:18 -0400
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
Message-ID: <20260130135618.GC2328995@ziepe.ca>
References: <20260124-dmabuf-revoke-v5-0-f98fca917e96@nvidia.com>
 <20260124-dmabuf-revoke-v5-4-f98fca917e96@nvidia.com>
 <31872c87-5cba-4081-8196-72cc839c6122@amd.com>
 <20260130130131.GO10992@unreal>
 <d25bead8-8372-4791-a741-3371342f4698@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d25bead8-8372-4791-a741-3371342f4698@amd.com>
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

On Fri, Jan 30, 2026 at 02:21:08PM +0100, Christian König wrote:

> That would work for me.
> 
> Question is if you really want to do it this way? See usually
> exporters try to avoid blocking such functions.

Yes, it has to be this way, revoke is a synchronous user space
triggered operation around things like FLR or device close. We can't
defer it into some background operation like pm.

> >>>  		}
> >>>  		fput(priv->dmabuf->file);
> >>
> >> This is also extremely questionable. Why doesn't the dmabuf have
> >> a reference while on the linked list?

If we hold a refcount while on the list then the FD can never be
closed.

There is locking protecting the list so that it is safe and close
continues to work right.

Jason
