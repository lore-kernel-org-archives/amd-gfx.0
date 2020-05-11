Return-Path: <SRS0=XsTU=6Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E326AC47255
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2020 13:51:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5BE2206F5
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2020 13:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fTLHNSai"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5BE2206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6873489951;
	Mon, 11 May 2020 13:51:19 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99A2D6E47A
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 May 2020 13:49:56 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id a136so784953qkg.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 May 2020 06:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=4rPpMLzUp9bspNeARk829RL9zhdg6LdCbnWGM4mXn5M=;
 b=fTLHNSaidCTBTVafRZ88/JPpZndAW4JKAiqp+xUjmlcGq11JBx+zkoc/gLYyuRZMpU
 8huyG7Lesc6lj13AkjhSbtSdyaW0HhfFpl0iYlVpDT1IiP7SHlaVI+MZSY7RwrTYhtBq
 RQNBgrM8IvriB2Mvvs4e8HQwdfhdtIbJbykV3RNu3vDxx3lnpyWu6MdARnOn+R62z8Jc
 KN8rcWegPekMEUZip8kruV0JwYQbPzQPKIlrCHz/KHExck9xbphKWhwcVarhbGi64Uoa
 alGo+ohiWuSyQC8pRj3oZO/AC0G930Xueg4XAOk+AAPwsMsi4evR7ZHEiIxrpqeKQKyH
 7Trg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=4rPpMLzUp9bspNeARk829RL9zhdg6LdCbnWGM4mXn5M=;
 b=hwILmMGeVtYXpQkC32G9LVZGyvG257+fNgJPZIh8e51X2VXfiL4uZJAKn6iUiuxKcB
 0BJP+3dYpzkhJnaQ0O0Zz4VVTz8ukCq0qfX4QC5rKTaBRFW1/b3xf/pmBKA6dZk/jw1a
 q64yeBHeUNZRexTL9AEYclxaXsZeK5X2DJMR0imyJ/lp7cIRNA/S3u3tzPRL4ap6p7Gu
 k040rwrYNiZuC5ElAFRMKxP/Y2Ic1IjDaQoSkIy9WdpALk9Y+j1EjppDKvV+FgVQiCIX
 lT/BAsJtDRTVeRogJLVQAPLRKNXr3Th4kJJsjhWynlb//zwjjNf6UWyBRnMAaFnkFElH
 2tfg==
X-Gm-Message-State: AGi0PuY8bYzOJR5cbbDgtsBB2eVwYZ0Evk9luX/ZvaU/0gB8zR+nwsk7
 jxZe/Gff5XZryDkdNcW3NZG65Q==
X-Google-Smtp-Source: APiQypJNAQ0/U/AQ7HD5Ea1GoiCuDrCNke0sGrNZi0ZXjdmU+vdOsV+r7iIZyEfm/aW74L1CSMAM/Q==
X-Received: by 2002:a05:620a:2019:: with SMTP id
 c25mr15376455qka.320.1589204995576; 
 Mon, 11 May 2020 06:49:55 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id i10sm1542178qkk.128.2020.05.11.06.49.54
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 11 May 2020 06:49:55 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jY8oc-0005UB-FF; Mon, 11 May 2020 10:49:54 -0300
Date: Mon, 11 May 2020 10:49:54 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH hmm v2 1/5] mm/hmm: make CONFIG_DEVICE_PRIVATE into a
 select
Message-ID: <20200511134954.GS26002@ziepe.ca>
References: <0-v2-b4e84f444c7d+24f57-hmm_no_flags_jgg@mellanox.com>
 <1-v2-b4e84f444c7d+24f57-hmm_no_flags_jgg@mellanox.com>
 <20200509171612.94ee332ad4f494521d911ac0@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200509171612.94ee332ad4f494521d911ac0@linux-foundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailman-Approved-At: Mon, 11 May 2020 13:51:18 +0000
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
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 Ralph Campbell <rcampbell@nvidia.com>, "Yang, Philip" <Philip.Yang@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
 =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
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

On Sat, May 09, 2020 at 05:16:12PM -0700, Andrew Morton wrote:
> On Fri,  1 May 2020 15:20:44 -0300 Jason Gunthorpe <jgg@ziepe.ca> wrote:
> 
> > From: Jason Gunthorpe <jgg@mellanox.com>
> > 
> > There is no reason for a user to select this or not directly - it should
> > be selected by drivers that are going to use the feature, similar to how
> > CONFIG_HMM_MIRROR works.
> > 
> > Currently all drivers provide a feature kconfig that will disable use of
> > DEVICE_PRIVATE in that driver, allowing users to avoid enabling this if
> > they don't want the overhead.
> > 
> 
> I'm not too sure what's going on here, but i386 allmodconfig broke.
> 
> kernel/resource.c: In function '__request_free_mem_region':
> kernel/resource.c:1653:28: error: 'PA_SECTION_SHIFT' undeclared (first use in this function); did you mean 'SECTIONS_PGSHIFT'?
>   size = ALIGN(size, 1UL << PA_SECTION_SHIFT);
> 
> because in current mainline, allmodconfig produces
> CONFIG_DEVICE_PRIVATE=n but in current linux-next, allmodconfig
> produces CONFIG_DEVICE_PRIVATE=y.  But CONFIG_SPARSEMEM=n so the build
> breaks.

I think Arnd identified this, let us just revet the patch that caused
it.

> Bisection fingers this commit, but reverting it doesn't seem to fix
> things.  Could you take a look please?

There is a latter patch adding a 'select DEVICE_PRIVATE' so reverting
this needs to swap that to 'depends on'.

I've done both and updated git

Regards,
Jason
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
