Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60CE6CA5FE8
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2026 12:52:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4205610F836;
	Fri,  2 Oct 2026 12:52:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="JwwAkFOa";
	dkim-atps=neutral
Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com
 [74.125.229.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D19210E533
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2026 11:46:35 +0000 (UTC)
Received: by mail-dy2-f43.google.com with SMTP id
 5a478bee46e88-34abf779ac9so2877679eec.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 02 Oct 2026 04:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1790941594; x=1791546394; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=p3RrKegDIYcP9bXP/97JoW1rLjg2e5Ae98djanO6X2o=;
 b=JwwAkFOaBEJkmtlHekkGvMs6s1P7UvRFZJHvKAde1RiasI8uC/ye2zKMc2OLeoCwVM
 jRlSObfKDQTjVJlFRYJxlHQgdPPMOPfNpxgZ2AiNi06RzDkaSJ57bzRUPfLnx1FcEtlc
 fUxB/N0ozAzpVVTHKndZjF8lFUCMtXnOcgcPov8Ra/4SzfcNtglVmcHj8BrVdT6iYpsU
 3JfVHBvqjgUs3zcvIGKbMXeQWl/aNj39iLMQz74ihWA2HIOEMtt5NXpyYP/918Dq+KmW
 YYXEG1KRjTnl18YZmtdRddgLBeASCBJIJbnwjn7zZkAPPcUJRtZCe+8EhRYfzmqT7g+I
 HVXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790941594; x=1791546394;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=p3RrKegDIYcP9bXP/97JoW1rLjg2e5Ae98djanO6X2o=;
 b=2s6OohQsqodldIP5YunMMhJlqq7uss4no+lJYl+NsBI0bCL5vhUK+htVpvGbqaWEYT
 V58OxznJ1Q5ZqlBxDVLkQjjzfxtEO44KCVlb1XJKw+J8YjRsn4YLEG+B/KKKdEYvM6qN
 KOTRLXIN/b4NcsF6ANKQ72H8mdb5RvKNng8WTGBvqyNu4OQ6mrfuldkuNAhbAnTQkpC4
 5MmAxUEAdRWBnHjeByF12cpT5AMg2BjEdLxH46Ixl9zZsD+7zvt6qFXZyDbug7foc/Oc
 cw92jXDy8QntjTOdjDTj0k5sZj1g8tKsk0gER/4JwSWu3Ff0yfXWG8UTeSb/WFr4+Q8Z
 A0Eg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxStAnfIX2F8QI9ii4XTVX8kVmWptteZZWzatyX9DqaBbrRpXtoxvCJLO48ifE1GixuP7Ev4psc@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ6r9CTKYdVdgnZL4BMra1fzrDYAmPWxybOzmjB8RnmaB2CS7vB
 Xpe4rOEzIUviYsNkKa9hd5DQh+vBynP5N+fA93Bcx/8e5OW8PHJaFOdGNaFWbwyb30w=
X-Gm-Gg: AYBFou2sBr+hN0ozHVSKRVUBUqvmhfn7gZZSJ8TvAhOWdvl1oPa3fMdjP1K8CZt3/Iw
 zbDoYg/1bpMPt5XzZ0fvpx9RmxXEFgWxl+DM49WzfztYam2kSxfM7R9HESCAwWm3DcKATieHESc
 bCu0GBH9McJV/DKVrtAYv1h5DFmK3SgaPjSnmHoPNOXSxQxiYt8uwDN8NonQxbhTZfqLvhNsLA0
 LyZ0PpgFV/K2wOT985djcOgsRr18ZCTU3i4WsYspzqf//ryuDknJvaqQcJZ6XtMea0Hz/uyJM1s
 tA8UDCjyvatw3wjDVMWi726Ueui6GWJziB8YeDivVDL8d5uZtIs9BBIE1YMR7SOr6aje/NfJj3i
 g7ikz2W1CmhfBi6JDDwu8Zu7hDovtqqJ6HXIXH+lQ3OZAonoM1LajXHVdaPYWsJa+dr8Ykkn22/
 B9QRX+7XY3R2/vqjO5GWlx2QX5PnDUc9+2s8jrJHqxaMpe
X-Received: by 2002:a05:693c:8808:10b0:33c:259a:759 with SMTP id
 5a478bee46e88-34f21996151mr2610780eec.36.1790941594306; 
 Fri, 02 Oct 2026 04:46:34 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34f14f303e3sm7587040eec.5.2026.10.02.04.46.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 04:46:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1xCbih-0000000GQhV-36wt;
 Fri, 02 Oct 2026 08:46:31 -0300
Date: Fri, 2 Oct 2026 08:46:31 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mario Limonciello <superm1@kernel.org>
Cc: Vasant Hegde <vasant.hegde@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>
Subject: Re: [PATCH v4] iommu/amd: Make PerfOpt compulsory
Message-ID: <20261002114631.GA3481470@ziepe.ca>
References: <20261001182410.1525285-1-superm1@kernel.org>
 <d4634df4-ab32-46df-8b05-665998959e43@amd.com>
 <f790bd53-8610-4e8a-aa4c-1f346c0cbbe6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f790bd53-8610-4e8a-aa4c-1f346c0cbbe6@kernel.org>
X-Mailman-Approved-At: Fri, 02 Oct 2026 12:52:19 +0000
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

On Thu, Oct 01, 2026 at 10:57:17PM -0500, Mario Limonciello wrote:
> > On 10/1/2026 11:54 PM, Mario Limonciello (AMD) wrote:
> > > PerfOpt is only a feature usable by integrated GPUs and only in identity
> > > mode.  Instead of leaving a policy knob in amdgpu, just turn it on when
> > > an integrated GPU is in identity.
> > > 
> > > PerfOpt locks the GPU into identity mode where the DTE is ignored, so mark
> > > it require_direct (blocks VFIO/iommufd claims) and disable PASID (no GCR3
> > > table in the fast path).
> > > 
> > > This drops quite a bit of compatibility glue.  There was a refcounting
> > > system, exported symbols, and device attach/detach logic.  By just setting
> > > it immediately it's a lot more straightforward.
> > > 
> > > Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> > > Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> > > ---
> > > v4:
> > >   * Disable PASID for PerfOpt devices
> > >   * Don't allow attaching a blocked domain
> > 
> > This will block attaching device to guest via vfio-pci. Is that fine?
> 
> Right - The thing is from that experiment on v3, putting it in blocked
> domain does nothing while PerfOpt is enabled.
> 
> I figured the user should be aware; so I was between blocking attaching a
> blocked domain or showing a warning.

Ideally you'd fix it by making the perfopt bit only set when an
identity domain is attached.

Though I'm not especially happy to see a driver that can't support at
least blocking, that's pretty broken in our model...

Definately don't show a warning, this is security stuff if the driver
can't do an operation then it must fail.

Jason
