Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3284CC98321
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2026 07:39:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DAC610F936;
	Fri, 25 Sep 2026 07:39:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="nEBHxuWM";
	dkim-atps=neutral
Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com
 [74.125.229.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36C4910E767
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2026 00:17:21 +0000 (UTC)
Received: by mail-dy2-f43.google.com with SMTP id
 5a478bee46e88-340f56c44b0so117605eec.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 17:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1790295440; x=1790900240; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bBP41wsUfxAtNYlcp3VvzpWs4GlF6loBq2EU7rP0+w0=;
 b=nEBHxuWMkG1RlK1O/n0yKPpKNkuER/K+op2ydKLEBeVQQBFjFkWnUMScl96MQPuDzK
 s5lZDFJBj1U05D6C0qPsQvIghDYYgjAzraK9alwj9fJE9Tw1WFRLv51Pc73xFV/mXn0E
 KUQgW+28I6iyCj+sPtOt8L3Fu9fgfB4vttIQal6QuEFZLsMEaapZHfdqcGyfPRA8Fbhp
 HD619QRtnsC0q7OHgEa7G3eh1CcMcuUV4u225lN0vBn0Zauq38i3ifyk8MNl4crECg7r
 AWDLCaeAXoQqJjBQtyJZmQnw07hIo/KTGJXRvCA9+m/Uwy0DB5tMiI0fhlaPCMlBDzNY
 bdqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790295440; x=1790900240;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bBP41wsUfxAtNYlcp3VvzpWs4GlF6loBq2EU7rP0+w0=;
 b=pWoPrhFARx6vTo/sd6hWfMUvInNw6o3li0zjKmlWjiiEjo7pLsr+dTI62MjZwgjEYp
 p1F0aGgkmUX2/iqzq+YqN3PEBvNd0CIsSs0GLqd7tHKW5u8fMZX947kkTHsilwQQ8FcI
 0/c0uaMkZtFSiN0Xk8bGVjH/3oYJROZbvlq5Q7h+SsBps7QygC6VCwgFFiQgR1UaxcFg
 /Df/E6LUBGkobHCJxZDAH2o5rg7+wKONVbSVXYPCSKZwcRpCu90cUGbKgSAKktIdt8m0
 bePBFtvgDS5UBX93Z/ZgCZUoogK/Bad72e9e59KE5yjSP5d9ZfPqjpyBj9SpnksnUfk4
 5c5Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBx0LeeOvs5K4ULn+sHHZmkMUXA69Z/E6X8R2AwBx/p3nJ+TeSqG23W3FF6VRoJqUEZaYNl6AGad@lists.freedesktop.org
X-Gm-Message-State: AFuF++ncm7BbVOQu6hYkCQIJSu5fSOGIq118cBFK7iICfAb4rcIJVDDw
 6TXDUyYP+SJDwlJ7m7wJOo8cIDfSShSC9vJYaz2pCmmEEVzLHVqftN4w30GJQ8HOf8k=
X-Gm-Gg: AYBFou1SEocKXze4GJC/Wyb2uyC4Dt1pPxhkRRgYGMbrODBMSzj7j5h9fU5Dzwy6FT9
 7aO1bh6akSxqVfRNX5l8YiFOPmVXl9mYX0xtVW7OvbEfyMaeBaVlYKdJulAaeQqeGNwcnXhmhz/
 ZAMlos3CNuHiHWKqaFIjr2OzsYg1Fvhb5EAOmy+KK1686ECx7JM85UYQWIQDsvxHjwRMpiKvS/1
 hHRjEvaC5upZbsesIA5ey9Mr8LgiIJ2Ost1WxBkbyh6mNJ0gKNdslTlIHcAPzn5sDOa+LIyWRDG
 s7YQcQuCspMNFnl+TvGuRRZ9dmSk2TmmKW/EkIB2g7XowopGWuQv2WWmIChfXHqZxGOkd3wuQ5o
 2EVhOJ2bMabsuvA7QWp2cIKg8tkztGZJef79rphZRdUNAJ172n36cAJnNpmrbYhTDzfZkP4fUAE
 fWFOvG7tutfgIcmYMfkC6z8zjS4bmtShXUFNDKiuRVu+dr
X-Received: by 2002:a05:7300:23cd:b0:33b:ebaa:e03b with SMTP id
 5a478bee46e88-340006437eemr4655606eec.22.1790295440228; 
 Thu, 24 Sep 2026 17:17:20 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3414456b496sm1830997eec.11.2026.09.24.17.17.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 17:17:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1x9tcs-00000000j4H-2AoY;
 Thu, 24 Sep 2026 21:17:18 -0300
Date: Thu, 24 Sep 2026 21:17:18 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mario Limonciello <superm1@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Joerg Roedel <joro@8bytes.org>, amd-gfx@lists.freedesktop.org,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>,
 Jatin Kataria <jkataria@netflix.com>, Boqun Feng <boqunf@netflix.com>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>
Subject: Re: [PATCH v2 1/2] iommu/amd: Add PerfOpt IOMMU performance
 optimization support
Message-ID: <20260925001718.GC163130@ziepe.ca>
References: <20260908041207.38113-1-mario.limonciello@amd.com>
 <20260908041207.38113-2-mario.limonciello@amd.com>
 <20260924225018.GB16465@ziepe.ca>
 <5a6ba6f3-4d8b-4d67-8e5a-ffbe22126464@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a6ba6f3-4d8b-4d67-8e5a-ffbe22126464@kernel.org>
X-Mailman-Approved-At: Fri, 25 Sep 2026 07:39:28 +0000
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

On Thu, Sep 24, 2026 at 07:03:56PM -0500, Mario Limonciello wrote:
> 
> 
> On 9/24/26 5:50 PM, Jason Gunthorpe wrote:
> > On Mon, Sep 07, 2026 at 11:12:06PM -0500, Mario Limonciello wrote:
> > > +EXPORT_SYMBOL_GPL(amd_iommu_enable_perfopt);
> > 
> > Last time we hardwired the GPU and IOMMU drivers together it was a
> > huge mess to undo.
> > 
> > Why does the GPU driver have to request this? Why can't the iommu
> > driver know that this is a special device that can use this magic fast
> > path and then auto set it when identity is asked for?
> 
> The reason was to allow an "opt-out" path on the GPU driver.

This seems like a very poor reason for doing this given the past
negative experiances.

Jason
