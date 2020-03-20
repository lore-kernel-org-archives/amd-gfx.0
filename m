Return-Path: <SRS0=S2wj=5F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2182C4332B
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 14:46:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C25520739
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 14:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IvTQLQxf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C25520739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BB2C89F77;
	Fri, 20 Mar 2020 14:46:34 +0000 (UTC)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 883C06EB2B
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 12:58:16 +0000 (UTC)
Received: by mail-qv1-xf42.google.com with SMTP id h20so2840391qvr.12
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 05:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=7tshdo6c8ufpkvS21qNDq3o1JI++3fGdgC9NNzUitoU=;
 b=IvTQLQxfTudOZo6mQWXcw0MoAViFLghOoPbxW/9yZkUMgOiZ4Pv9Z04Csj2TJq5vca
 qb/NOPGNHtZJ6s24cM+QRSb5JuK21NJyav0y6/cJqE7vqjvLZeiPQwWPggHqBJHigTLB
 ymmND/5GQ89u7BiyP07RYIjAcCIa+vFjUpz4zOgJSTVCkcudYccK0vOVEQgM0fc99dpd
 Vs62xPG18t0GhZadO3Oap9mTCctOwTr0CiUfvnOTXVINl2qtmYv1/+hwvSX1r+r/EA1v
 Ke5XvA9K39riwOsICVFnrILW1mFcLwADDE6udlfAI2AZmQRk3mQ4NBUc46ebi+QLcJNF
 7/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=7tshdo6c8ufpkvS21qNDq3o1JI++3fGdgC9NNzUitoU=;
 b=PuE44IXmuhKH+0isR8EqdVCe7C2szeMknqMUpiLDbreepKqDEMa63nUt6QdCdO9Pzb
 MGtHQQMqMQDgCWFnCsDfyH2zLQ6AnSUdWcEyEmp32fM4WzaoVTMN3wcCxFvsLYQa5OK4
 vJoSL0VIFyE/8TU+XIm8nF1iMPsT8k6YHMwzwDJgKLAavvj/qBQxZ9DukUHeJUf3GJDp
 ZlotFHjaGxdRHQt9MI+ph40tMUd0DO/YaYqmjmr96yDuYDOZyDJDAuGALlDoFFVnCOr7
 i59pkRHFsUHyaYWJJz1PA7o11xRGG8VHRud2OjVE5Pd74B8YmCzXr8Ol8k2mqn2O4MLV
 vxvg==
X-Gm-Message-State: ANhLgQ1uynAFc+zaF5pRcqxJL0u4JieGs2i3lrQaHIlZnNPyI9/y4ZV0
 UaojymnLs5p3RJxg5C9BBDlMvg==
X-Google-Smtp-Source: ADFU+vvR+3vAV1p7d+fDNfmTEDRX1I6s0r0r+8MeuA2PAqUC3MBTAsQJGe+LIm8TG0FJxBXCYdsOGw==
X-Received: by 2002:a0c:ec02:: with SMTP id y2mr7683694qvo.171.1584709095500; 
 Fri, 20 Mar 2020 05:58:15 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id y15sm4157894qky.33.2020.03.20.05.58.13
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 20 Mar 2020 05:58:14 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jFHE5-0007Cq-2w; Fri, 20 Mar 2020 09:58:13 -0300
Date: Fri, 20 Mar 2020 09:58:13 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH 3/4] mm: simplify device private page handling in
 hmm_range_fault
Message-ID: <20200320125813.GQ20941@ziepe.ca>
References: <20200316193216.920734-4-hch@lst.de>
 <7256f88d-809e-4aba-3c46-a223bd8cc521@nvidia.com>
 <20200317121536.GQ20941@ziepe.ca> <20200317122445.GA11662@lst.de>
 <20200317122813.GA11866@lst.de> <20200317124755.GR20941@ziepe.ca>
 <20200317125955.GA12847@lst.de>
 <24fca825-3b0f-188f-bcf2-fadcf3a9f05a@nvidia.com>
 <20200320001428.GA9199@ziepe.ca>
 <8d549ef6-14ae-7055-58c8-d56de8bf4ba6@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8d549ef6-14ae-7055-58c8-d56de8bf4ba6@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailman-Approved-At: Fri, 20 Mar 2020 14:46:33 +0000
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
Cc: amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, kvm-ppc@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
 Jerome Glisse <jglisse@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
 Dan Williams <dan.j.williams@intel.com>, Bharata B Rao <bharata@linux.ibm.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Mar 19, 2020 at 06:33:04PM -0700, Ralph Campbell wrote:

> > > +		.default_flags = dmirror_hmm_flags[HMM_PFN_VALID] |
> > > +				(write ? dmirror_hmm_flags[HMM_PFN_WRITE] : 0),
> > > +		.dev_private_owner = dmirror->mdevice,
> > > +	};
> > > +	int ret = 0;
> > 
> > > +static int dmirror_snapshot(struct dmirror *dmirror,
> > > +			    struct hmm_dmirror_cmd *cmd)
> > > +{
> > > +	struct mm_struct *mm = dmirror->mm;
> > > +	unsigned long start, end;
> > > +	unsigned long size = cmd->npages << PAGE_SHIFT;
> > > +	unsigned long addr;
> > > +	unsigned long next;
> > > +	uint64_t pfns[64];
> > > +	unsigned char perm[64];
> > > +	char __user *uptr;
> > > +	struct hmm_range range = {
> > > +		.pfns = pfns,
> > > +		.flags = dmirror_hmm_flags,
> > > +		.values = dmirror_hmm_values,
> > > +		.pfn_shift = DPT_SHIFT,
> > > +		.pfn_flags_mask = ~0ULL,
> > 
> > Same here, especially since this is snapshot
> > 
> > Jason
> 
> Actually, snapshot ignores pfn_flags_mask and default_flags.

Yes, so no reason to set them to not 0..

Jason
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
