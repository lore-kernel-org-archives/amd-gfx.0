Return-Path: <SRS0=JxR8=6U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B8AC28CBC
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 16:31:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D74120708
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 16:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CDYYUXVy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D74120708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB25D6E8A7;
	Wed,  6 May 2020 16:31:21 +0000 (UTC)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E232C6E8A6
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2020 16:18:26 +0000 (UTC)
Received: by mail-qt1-x842.google.com with SMTP id q13so1849509qtp.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 May 2020 09:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=dI/8k01wqNtPsEMN3JryPuexKMUAM9GFAPsiKlMJOgs=;
 b=CDYYUXVytFKURB46DxLbtSQhLKEUVHOamKg4N6ws/VeYuZqe48aW2fVU4DY/h9Bp0C
 oxPsar9OJVyyfKYewl2b61UAK/iYMJhUOEztf6FyAWUPWMHx6K52Ms3zjFawc0T82Nl1
 7Xt+P1aPijxMvudfHiyJNFg5C9ZFGxb7Xq5W8dbwJ21FJwxC/q1Blc/Rw7qi4EBtZ7QU
 QsgB9ERVVjUURncAAw80TIEnHnDpJ9Brzd9+PloSZTbvOPoos60r/CIiiaGLTHr18jlp
 z1hKejvJ2XMgEhTqjmxxET3DODSbvUQWlTA4t/TK35N6seBmGymATrWanur938yEOAM8
 A/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=dI/8k01wqNtPsEMN3JryPuexKMUAM9GFAPsiKlMJOgs=;
 b=s3IfM77MCxn3Y8cPV8Mlwch72kHhzPUYyL21v5RvLJdgWl5yiVznZ42ZOnjvW/eEhK
 RNNcuGgeVxi0LShYGL1iIfIGErajo+DjGZh/XElU+QHzXAi37tHy52OLn7JQpbp2abdW
 ahSlyb10oVKjKB6PCYPwzNL+tx6o+vAMvcV2YHr7g1KVGxwn5zs8NnMZ90g5cmElIyov
 IQIjmHqNPWkbZX2Ok/58vBn3N73fuaMsuQPjSue9NztSVhyu+JXc7wh7dfEKLzh92F0T
 VymO0jXU8kAM4u7IvUshg0XTNJc8dKoDvqJRddpXvKrnusigKqfD/6jDQLLVxKZHJ6F4
 6Hsw==
X-Gm-Message-State: AGi0PualhT/e/mgnD1TrN8vG3WRPmGvgdD18/qwYNooMZS4iyjs5dD6B
 imsmyZzumh85Go5NFiJaovnuAA==
X-Google-Smtp-Source: APiQypKyDRDNEzprm+gsfACpH0aQyfocl+/L2XhuNJKEuZItD8tyLPJ84MVvdGkrVM9/6D8550tNkg==
X-Received: by 2002:aed:2e83:: with SMTP id k3mr9101168qtd.2.1588781906015;
 Wed, 06 May 2020 09:18:26 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id h13sm1895261qti.32.2020.05.06.09.18.25
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 06 May 2020 09:18:25 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jWMka-0002ut-Lq; Wed, 06 May 2020 13:18:24 -0300
Date: Wed, 6 May 2020 13:18:24 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH hmm v2 5/5] mm/hmm: remove the customizable pfn format
 from hmm_range_fault
Message-ID: <20200506161824.GG26002@ziepe.ca>
References: <5-v2-b4e84f444c7d+24f57-hmm_no_flags_jgg@mellanox.com>
 <3c06a94c-c17f-dc31-537e-f3f6e1ace9a2@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3c06a94c-c17f-dc31-537e-f3f6e1ace9a2@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailman-Approved-At: Wed, 06 May 2020 16:31:21 +0000
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
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>, "Yang,
 Philip" <Philip.Yang@amd.com>, John Hubbard <jhubbard@nvidia.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@lst.de>,
 linux-mm@kvack.org, =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
 Ben Skeggs <bskeggs@redhat.com>, nouveau@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
 intel-gfx@lists.freedesktop.org,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, May 01, 2020 at 05:53:26PM -0700, Ralph Campbell wrote:
> > Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
> > Tested-by: Ralph Campbell <rcampbell@nvidia.com>
> > Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> >   Documentation/vm/hmm.rst                |  26 ++--
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  35 ++----
> >   drivers/gpu/drm/nouveau/nouveau_dmem.c  |  27 +---
> >   drivers/gpu/drm/nouveau/nouveau_dmem.h  |   3 +-
> >   drivers/gpu/drm/nouveau/nouveau_svm.c   |  87 ++++++++-----
> >   include/linux/hmm.h                     |  99 ++++++---------
> >   mm/hmm.c                                | 160 +++++++++++-------------
> >   7 files changed, 192 insertions(+), 245 deletions(-)
> > 
> 
> ...snip...
> 
> > +static void nouveau_hmm_convert_pfn(struct nouveau_drm *drm,
> > +				    struct hmm_range *range, u64 *ioctl_addr)
> > +{
> > +	unsigned long i, npages;
> > +
> > +	/*
> > +	 * The ioctl_addr prepared here is passed through nvif_object_ioctl()
> > +	 * to an eventual DMA map in something like gp100_vmm_pgt_pfn()
> > +	 *
> > +	 * This is all just encoding the internal hmm reprensetation into a
> 
> s/reprensetation/representation/
> 
> Looks good and still tests OK with nouveau.

Got it, thanks

Jason
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
