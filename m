Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC8AE83F1F
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 14:05:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B712110E0D6;
	Wed,  4 Feb 2026 14:05:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="Cs2LwwUR";
	dkim-atps=neutral
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com
 [209.85.222.196])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7954410E64E
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 13:56:59 +0000 (UTC)
Received: by mail-qk1-f196.google.com with SMTP id
 af79cd13be357-8c69ffb226eso934532785a.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Feb 2026 05:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1770213418; x=1770818218; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iRrqXVZVX7Z3YtbKGBkBfsPXFsl6FxGibC0bf/QAItY=;
 b=Cs2LwwURh20GRUGYCEAfO4zQPcoOwwNf9iqYwtmQ/3ZG5J9uKkHGUBhMUL/0/PBXhi
 y/P7dOvWXhwn2fqwEK+1d/J0H1E+pR1dKIaNNLGLN+czJxq97pJ6SGNK2Mq7N4LCa83s
 kNtwN+mihW7gvHI7A91SKIzYWhm6mr4KrFuxMCUm2h/Keqnlh9hPHhCEBNGz+OSj2D1k
 2wL2oenaZWxaxAUii8MX4L2whiYyxVD/gHid9l/9ndDEI3WdMxlB+nppcjF87mp19lme
 noLWCtM3X/TKGqtIaiUDsfeOCWkZh7u8j+JHS45pEA9Uw8fUW84Sv0IEzSzYma3OlPrg
 P0Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770213418; x=1770818218;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iRrqXVZVX7Z3YtbKGBkBfsPXFsl6FxGibC0bf/QAItY=;
 b=xMuAD7HI13eF0mcrIt1tkwgkGQK+HSsu6B4NqWM3L+UP62WLPWNIhc01cjpOAzsJUQ
 MewTJTO9IYJyoEERNhWkg80eDJcRnO6F+oupgoUrdr7kNDlTaxQYL/r/pfNxoZuRRcx4
 azAjCR+ZNGUGQHc/fzfNpPPINLXk+4XyerxikJlRrFTEp6E+Fq+JHy41aWGCk5GGIvT7
 43LU+eNlUJdai3SZtVsHjr+ol9Pk1KjyF0+k7UTVaORwuYJ74QQyZKrlqnBxe9bIIjS/
 j/zUqSTMHxTDngtgPI6rRQ2KUdretP3Ana5cHWR0HUhpFKIHEKzUB14aYiLca6KvMiRn
 gm5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJT96wjs/CWLzsQOv8R6sdxDI5reLLITkc3sy7drXGpdlkVzLQEfslejIWnuSnKXcuND8uKiY6@lists.freedesktop.org
X-Gm-Message-State: AOJu0YywfcdKs19/K5uPybG2SPB9ac3J7HYa4gAfQQvPJPezQfUm/IvO
 BPtvAXNLXfiJgDyfJuK6g4vMU8Y+7lg46HEm69+vhtFSMseO4+iJ/YUBIFt/PfijcU8=
X-Gm-Gg: AZuq6aI2LVX516Djf5UT+d3HESnk+Ap8KrqyLJwD9S7f3KMFUMffPRHyE5+rMPNu19F
 BG1NvyNUOstOUCfz31KbsSOtiOWcJV8bSkfzsvObhjSVkf7bdq7Fr5Cnm+/Adg+PDm9Pj2QF7l4
 BHpsgjviYBZj/rQ53ubKRhahPUVWWDppm9BNVZxwqlNjhduDIoQ3/s4F6P7efyppx7EtHIPvZ2f
 rWG9+HP51gcMIA8YNO+Ct2EOwegqhtuP5LAZHvyqLEDF+cx1dqHxmlXtvc3Jxz7C6yX5375XRvz
 bZ6pGJLxhVUpPmMbR1io/k1+fXfgxKKiOGmHQFfYPH3EffNQLl3Qlabq+TbvdjOBIZRcyBScrOB
 yINrTLzSG8cZa5hFxUJ0S1nhJT/egrp3sXQ/m5tjrTUr0rOicEhjBz+Hr6OY9fnPEeYYQ/KcZPB
 LqLl5cvrTwnnB4YSBzRJzuMTDbSYNhk1hQH6Tab+R4AO0UwRcyo3qnoy85ECFt6/smWFQ=
X-Received: by 2002:a05:620a:3953:b0:8a1:21a6:e045 with SMTP id
 af79cd13be357-8ca2f82b068mr371751685a.19.1770213418187; 
 Wed, 04 Feb 2026 05:56:58 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.112.119]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8ca2fa552f2sm187407785a.11.2026.02.04.05.56.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 05:56:57 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1vndNJ-0000000H1He-18eG;
 Wed, 04 Feb 2026 09:56:57 -0400
Date: Wed, 4 Feb 2026 09:56:57 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Maxime Ripard <mripard@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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
Message-ID: <20260204135657.GE2328995@ziepe.ca>
References: <20260131-dmabuf-revoke-v7-0-463d956bd527@nvidia.com>
 <20260202160425.GO34749@unreal> <20260204081630.GA6771@unreal>
 <20260204-icy-classic-crayfish-68da6d@houat>
 <20260204115212.GG6771@unreal>
 <20260204-clever-butterfly-of-mastery-0cdc19@houat>
 <20260204121354.GH6771@unreal>
 <20260204-bloodhound-of-major-realization-9852ab@houat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204-bloodhound-of-major-realization-9852ab@houat>
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

On Wed, Feb 04, 2026 at 02:44:42PM +0100, Maxime Ripard wrote:
> > From what I have seen, subsystems such as netdev, the block layer, and RDMA continue
> > to accept code that is ready for merging, especially when it has been thoroughly
> > reviewed by multiple maintainers across different subsystems.
> 
> He said it multiple times, but here's one of such examples:
> 
> https://lore.kernel.org/all/CA+55aFwdd30eBsnMLB=ncExY0-P=eAsxkn_O6ir10JUyVSYdhA@mail.gmail.com/

Woah, nobody is saying to skip linux-next. It is Wednesday, if it
lands in the public tree today it will be in linux next probably for a
week before a PR is sent. This is a fairly normal thing for many trees
in Linux.

Linus is specifically complaining about people *entirely* skipping
linux-next.

> So, yeah, we can make exceptions. But you should ask and justify for
> one, instead of expecting us to pick up a patch submission that was
> already late.

I think Leon is only pointing out that a hard cut off two weeks before
the merge window even opens is a DRMism, not a kernel wide convention.

Jason
