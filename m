Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51EEFC9830D
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2026 12:55:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAA9610FA48;
	Fri, 25 Sep 2026 12:55:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="c0+Y1NpC";
	dkim-atps=neutral
Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com
 [74.125.229.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 409AE10E5CA
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2026 12:28:51 +0000 (UTC)
Received: by mail-dy2-f43.google.com with SMTP id
 5a478bee46e88-33c24422d4dso940271eec.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2026 05:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1790339330; x=1790944130; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IYBi22JlMsDFxH8u3SI63AaYNIN6lXRFrma2FvtvBGo=;
 b=c0+Y1NpCpAxuAkY6U3NVAJLR+QwF/3R0ucrPObe5okHvpxYC7/zcvWI4+2/YpERX0t
 eRbJASXP8XK5FLSFIn4AtYls3TlId66BgyJX6AOzcRpUYpHVge69tfCdlYx2JaUmalfB
 4L4x1TH7VbbGOlpJ0DFfsTDn1lDMyTm9fpAptc+EF6aoxyhAisWnilsHGoSRTIyyOHOK
 9/p1yvGqTeeQ55TxRNScHihjNJhcFisAUrrV7bjKFFEMIDLXqH1mHW5lQxsEKPPyrhUY
 FWpQZeKtbJkh5SfTC93FfAy4XX4GEZM/SNzVVzTMoTSSkDSEXIn0HY5+L9iR7IHtXkmJ
 PdZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790339330; x=1790944130;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IYBi22JlMsDFxH8u3SI63AaYNIN6lXRFrma2FvtvBGo=;
 b=VF+3dtL4chlaMXLUKDyIk0LpA9ezIeh1sYCND8OUXYPAL+m8M4mYdhe9jqsVeVl5rL
 oAj2qTksnGfSwUBt6IlsvLBWo3mCQubGFGMwwBf5HNaAmfAautyIxzyOSIZ/+4ksh65m
 utVvmrRkCezPwCrf8W9empdR9skkfYDGCJq2jdnjHVwFDzO3l/KaK8ANYMmxj75v6dn/
 ue2aelliQ/EAXscgZTo4RSSLYggMY2Be3K86rZ5BbVw1aZgFIJnqC0mJocjOtpTxxzIz
 xNKYxhZBZ7OHgIyl8Tyq9Nkhlg0OyWtaRVT2BPDWYQ/lgFAevTUtbbCcQYfxZ5UfULRo
 VRbQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzX8cf8Cr/KyeCW+WxxZmfSeQ9e7IcOsSpDlKYroISjJK6teoTREVr1x0v9dkrra6vNwH0e+kWI@lists.freedesktop.org
X-Gm-Message-State: AFuF++mR8MzW9IgrZMBmwzrseeqKEb+e9tu3To0yAgsaRNXS9b9KHCuQ
 qP7c30VMcUZghZkn1Z+NFzr+9qUzLecAbPKBX/BqZSwJqtsxqbsuz+p3ulwxJ4YY9KE=
X-Gm-Gg: AYBFou2JjQl2yXsa1+YWw9sFXq9G53B5EjQ7dPUMDPa+wPgjdCS+rLWhHU5m+/kDms+
 BSmBa2unWnV2liCQAfeFSmQ5aQMHcfLrBdWSL0sT57R3NIqn/foZc3nU5LyJ8yY+9wJFlaWvq+j
 AkARl9i8Yj6Vk40634sKO1I+FH1V8pc73zK6kSdfFWDzg8wjyNnvsa796iQOGC0r2wABlsmc8eP
 8MxNCjB+0ZC/W9bE5rn1Mj2+T8LUYD2IKloviVWtmM80+Nyx5a+qXWEQQF/Zv8xHBCs0gCjoxCN
 gu/zYSPhp2NTLhz2pCXXw/Ag9l11IAOID6pKjnbi2elCTv4i0G494sO5NYEH99ue9rmsNlj2sog
 9/t3OERjC1np9D6aCKN7MoYytNcXaq8cLZ28aCr3yv7he2M47wqT2vW8SsrB+ePli3DZIOowz1R
 2rlY8xHMu9w+noIVbpDPN/hR+DBvYwjuecnDprAflHhCGn
X-Received: by 2002:a05:7300:e11c:b0:33e:633c:7f70 with SMTP id
 5a478bee46e88-34272b3bbb7mr97724eec.35.1790339330310; 
 Fri, 25 Sep 2026 05:28:50 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3414456b496sm6623329eec.11.2026.09.25.05.28.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 05:28:49 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1xA52m-00000001FlS-2vL4;
 Fri, 25 Sep 2026 09:28:48 -0300
Date: Fri, 25 Sep 2026 09:28:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Joerg Roedel <joro@8bytes.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>,
 Jatin Kataria <jkataria@netflix.com>, Boqun Feng <boqunf@netflix.com>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>
Subject: Re: [PATCH v2 1/2] iommu/amd: Add PerfOpt IOMMU performance
 optimization support
Message-ID: <20260925122848.GD163130@ziepe.ca>
References: <20260908041207.38113-1-mario.limonciello@amd.com>
 <20260908041207.38113-2-mario.limonciello@amd.com>
 <20260924225018.GB16465@ziepe.ca> <arYf3iJW7hfTua__@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arYf3iJW7hfTua__@8bytes.org>
X-Mailman-Approved-At: Fri, 25 Sep 2026 12:55:24 +0000
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

On Fri, Sep 25, 2026 at 09:20:02AM +0200, Joerg Roedel wrote:
> On Thu, Sep 24, 2026 at 07:50:18PM -0300, Jason Gunthorpe wrote:
> > Why does the GPU driver have to request this? Why can't the iommu
> > driver know that this is a special device that can use this magic fast
> > path and then auto set it when identity is asked for?
> 
> This is a layering violation either way. Either the IOMMU driver needs to poke
> into device details and their relations or the device driver needs to poke into
> IOMMU details.

There are no device details, this is just a module option in the gpu
driver.

> This is not perfect but to some degree unavoidable with these highly integrated
> SOCs.

This is exactly the sort of hacky thing ACPI should describe so the
drivers can just turn things on automatically.

Who is ever going to track down and figure out it is OK to set these
kinds of module options in the first place? There is general negative
sentiment in the kernel to doing things like this with modue options.

How does Windows do it? There certainly isn't a "module option" there?

Jason
