Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F0EC9830E
	for <amd-gfx@archiver.kernel.org>; Sun, 27 Sep 2026 13:26:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F012F10E5CD;
	Sun, 27 Sep 2026 13:26:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="Q8NG70cU";
	dkim-atps=neutral
Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com
 [74.125.229.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 574A810E1D5
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2026 22:39:31 +0000 (UTC)
Received: by mail-dy2-f43.google.com with SMTP id
 5a478bee46e88-33e630052ebso1601748eec.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2026 15:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1790375970; x=1790980770; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2DkhnlaU8X97aKYc97FzNgp9vm+bQnZHirc2X/jss6k=;
 b=Q8NG70cU9MCAEfhANyrPFYF0/LUlX8jKj08eMryDbA1h/gd3oj4MpnFfkxnm1etCjk
 06VrXtbpZIZnQOWy4lk3De/YWeplfX1nRrRRrJsggWdZUr5iBNi2b5NCiqUezs6obcM+
 rH+a0zbE6Tvf4/iTsB4esr+/YOAkmF2eobm0sJRLsFyLsjAxhXlC9lRpEHkFXT6azs29
 hjv+Su1mVscbrP0rMPd/oVLXU7SfpNUPqu2A2WDF3pbba5zVGeb857b8SP/FBMISN7gP
 jnfcfxKso14g0C1eoSqjIIS7KMAde5TZrDFq/OQoSLninNGDT2cg25VCbajFmMstZaMD
 8+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790375970; x=1790980770;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2DkhnlaU8X97aKYc97FzNgp9vm+bQnZHirc2X/jss6k=;
 b=bvZh8BGyrZCnyBdL2WpHezOirMYuQypNVhBHGQTDuo8lHbKkV0L3B/3MLbwsgNHPNM
 dozxbfnpTMV8BP48fceekf8YySWu+eQ9ItzGlifoa/THCIPg9ooPUQgoGvrqSZ4Ovycg
 AfT9CUcwK/5fpqdBiMeAKwet1ubgAZdhDWwzN08ogXnYl1JMYJzGSU5E4NyVsO4UupTa
 gUaM9FqiRazNV0secOx+S8Sfn1Huir2jIVPoAdxgzG0jm32na/3hG3MzUC4pjgaNiiCb
 rDKT67HtdK4LDfY3EKhyYTc9tQRSxcjSfq/tIH07Lx0XoWBfDBQsgYw5lFlj69YOCU3z
 HnwQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxbG60h9obDDPJSPXYZbrG8rn6Ixkzq/8cUAx8esTZMae1MLUP2srBmnrhrph+ObMaUJIpXMU+d@lists.freedesktop.org
X-Gm-Message-State: AFuF++mPiAH4avWtsPHSJnFeXM2MDGnG3wqwhsx5u4zJRMZwMIUmINh/
 umUigH0mRGq3DrreGsh9wEucs7twLcdC4YSfWtcH4L+7QxhLUoFuYEPdPDEbsPMhxgg=
X-Gm-Gg: AYBFou1jTM3/idskzl54RsTDw3AoG6kd1oyYW5CjbZ2qu+Xi8hrXSXJrMqoRzo+TzwE
 HuUqqp6VaZNZlYnbnY9eI7is1AbQtsFUvF5bjJSrRJI+XQjkIzlSgRomWGXEykKFl3ZYmjRwUkR
 GgVpy7Sm+JQJxEO1msEXKgnOOHcw3jxXfs6wQ4KVgxqr2dSSqAjREC96FEfMS8Qzya0ldOHBarA
 zwCpFHHBmIi9e255uH0uAZpa5Q1Wmq4oakHx+nuSbseNdLyEthqFQqoG9iFiNOyv2cP2ajRpA7v
 /hg9VkI68yR2poYjubeWR2q8A4+vmHMPtYc3ZuRZugnjZqt6LE5dTpQmEm5ePzEZPhCkq45zmjF
 +jrw614WwyWU+3T3wURbZ4rrztIa4HGFUYtLqZ8ZYfXk0vjAExyfuTOr+cEeQNnIkKfw/miyNEH
 MN+lNWXck/c1/fqtwEmAyFLbcdRT801LSdMpVYBWxmp6Sm
X-Received: by 2002:a05:7301:7196:b0:341:d152:9cfe with SMTP id
 5a478bee46e88-34272c5c768mr1133260eec.38.1790375970281; 
 Fri, 25 Sep 2026 15:39:30 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3414407ea69sm8644124eec.7.2026.09.25.15.39.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 15:39:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1xAEZk-00000001mwH-2Nok;
 Fri, 25 Sep 2026 19:39:28 -0300
Date: Fri, 25 Sep 2026 19:39:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Joerg Roedel <joro@8bytes.org>, Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx@lists.freedesktop.org,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>,
 Jatin Kataria <jkataria@netflix.com>, Boqun Feng <boqunf@netflix.com>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>
Subject: Re: [PATCH v2 1/2] iommu/amd: Add PerfOpt IOMMU performance
 optimization support
Message-ID: <20260925223928.GE163130@ziepe.ca>
References: <20260908041207.38113-1-mario.limonciello@amd.com>
 <20260908041207.38113-2-mario.limonciello@amd.com>
 <20260924225018.GB16465@ziepe.ca> <arYf3iJW7hfTua__@8bytes.org>
 <20260925122848.GD163130@ziepe.ca>
 <4560d7d3-4d67-457d-bcd7-2176bd850bd4@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4560d7d3-4d67-457d-bcd7-2176bd850bd4@amd.com>
X-Mailman-Approved-At: Sun, 27 Sep 2026 13:26:05 +0000
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

On Fri, Sep 25, 2026 at 08:11:41AM -0500, Mario Limonciello wrote:
> 
> 
> On 9/25/26 07:28, Jason Gunthorpe wrote:
> > On Fri, Sep 25, 2026 at 09:20:02AM +0200, Joerg Roedel wrote:
> > > On Thu, Sep 24, 2026 at 07:50:18PM -0300, Jason Gunthorpe wrote:
> > > > Why does the GPU driver have to request this? Why can't the iommu
> > > > driver know that this is a special device that can use this magic fast
> > > > path and then auto set it when identity is asked for?
> > > 
> > > This is a layering violation either way. Either the IOMMU driver needs to poke
> > > into device details and their relations or the device driver needs to poke into
> > > IOMMU details.
> > 
> > There are no device details, this is just a module option in the gpu
> > driver.
> 
> Well the GPU driver has knowledge whether it's a GPU inside of an APU to
> decide if it's valid.  That information is part of the discovery table
> setup.

Where was that in patch 2?

The right way for this to work is to quirk it through the iommu driver
so it can choose the fast mode, and not involve the GPU driver at
all. Like we've done for every other GPU weirdness. And AMD should be
making this work better by providing ACPI support so the iommu driver
can understand how it should work without inspecting PCI IDs.

> > > This is not perfect but to some degree unavoidable with these highly integrated
> > > SOCs.
> > 
> > This is exactly the sort of hacky thing ACPI should describe so the
> > drivers can just turn things on automatically.
> > 
> > Who is ever going to track down and figure out it is OK to set these
> > kinds of module options in the first place? There is general negative
> > sentiment in the kernel to doing things like this with modue options.
> > 
> > How does Windows do it? There certainly isn't a "module option" there?
> 
> This specific one I don't know; but these kinds of things usually end up in
> knobs in a UI that plumb some IPC deep into the driver stack.

Given the huge delta I somehow doubt that AMD would ship a windows
driver that defaults to "slow" ? Nor should linux...

Jason
