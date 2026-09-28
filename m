Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D7DCA5FB1
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 08:23:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BA6810ED86;
	Tue, 29 Sep 2026 08:23:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="dEDNXdqj";
	dkim-atps=neutral
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com
 [209.85.161.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 079C610E927
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 17:12:00 +0000 (UTC)
Received: by mail-oo1-f47.google.com with SMTP id
 006d021491bc7-6d95185ee17so182770eaf.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 10:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1790615520; x=1791220320; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=a9vn70oN/MkzXdp1qzKn2h1C6fFreFjIcRIhZBrGV58=;
 b=dEDNXdqjTkeIVyxX/1bNuzSHvJppEQ54IEWo4E2g1AsMUsvTTJefkHY/M4W0jj++TV
 Ihyq8NgqqV0zHMuXC5dl7f1TSRmDpJkaTflJqspLZo/okRKyrRjR+Ro+utOLgs6MXZz1
 /5qnKNKIDfwRB+d6FEQv1fJnzIjcg0j3xnhtj/3fnOT9A2eMlOuSnNtUEfN4M6vxIkZg
 uTvaB0MKEqf0ljr0uJyNrS336nDM9wYu2gI2daDcEkvLil8zdFffRIjNFFsaOHXkvkf/
 G1aR/CNnq/pQPmcQoKrptqdRB0ewl/PNCuXRR0q5jBxgBtF7c6Psne/Ct8rP/+GO+MA+
 Ldjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790615520; x=1791220320;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=a9vn70oN/MkzXdp1qzKn2h1C6fFreFjIcRIhZBrGV58=;
 b=lsnkWQMqvklIXqyrNU1wr9HEqQDrMOvrIdt8XmQ5fPGfmSr1hYBkyUD/P4UrfnLYeg
 UK8QRHP0Ht2H5cE522dwTMHlvj7OgjUV40wKzQAhQFZ1FIlhQ0gYinSaRvwV6YjYybqL
 /Y6SQ4771MxjRURMTfeBR6jFqG5XFoKNcnCXZBYtp8TIUIg7xzg7TTWFdP+XDfTwD4YL
 ualXiVVYjK6ARqfeiQxm4IKL1cZgzWUwUFT5CQpr0QJ9kE9j9xTChHriy0ANxbi3zfAy
 ACl7NTNEQfEG9NHaWeyUDnjDTEcMKmJGMVbPth/yg5djyqIAxukvvkcPg0bJKkgrE0xW
 oHUA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwhw4jGNCHRsra5I6mkpAzdnIIEGPi4aBXb2+50gEanJIjZ72YN4+V8V8V4iOObaDc1eWED6wcl@lists.freedesktop.org
X-Gm-Message-State: AFuF++kvhBXfExrvX+Gk+9yrElghIvhBvLwbVMhAUlDmjwK730wv7IDE
 lSFULy7Q3tiklHTGZv5hv+2LHAwe8ruTYPpsHnEw22esvoLjZxF2dOJ811ntQ7ZDvJw=
X-Gm-Gg: AYBFou27lDX9xSrusAsRG43js2ltLh/QA/z7qzoii+wAPrXbfOkbt9+VzRDp/VaHJaI
 GhxpuOtrbU2lQceb2ZdDPA34dkMP2KffaPvO+8dmJX2W+/6W4KYRKgqc78MyMr+Hka4VJ2I+8QG
 UP6oUx+6/LjRfCUfdByILEvlYnpl+UJqn/KJw7Y3l/DPZEPURjW5utiF+00ZDyt3XBChYS2vd4s
 kbcbBPpkC4m4VSy4FJYXaF+n4xeDn80xxhXemukI3bp9jMxEO9fempXkl834vN6U1oP5PyP+tYq
 Ke4Lv/kLiuPH9GUzBF+kftsRIWUjPpb5rQPzOQoHSep+yHVshEvzezChVyu1+G1ExEXEepCimfx
 Oqr/By9ygHSTcCm8GxMd/uk4h1/hBqeF2cD5p2PEnOhLXvH4IDe6FULFOV3gchEaMYr9j1WnDK0
 o02Dzmk8ok1jTviPgKN8dsZfHwtoVQvJbHvQENLeGKc6zz/w==
X-Received: by 2002:a05:6820:308f:b0:6d8:f3dd:4453 with SMTP id
 006d021491bc7-6db1146f8d1mr8836eaf.1.1790615519756; 
 Mon, 28 Sep 2026 10:11:59 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4933501183bsm8991295fac.5.2026.09.28.10.11.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 10:11:58 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1xBEtR-00000007LlD-3D6p;
 Mon, 28 Sep 2026 14:11:57 -0300
Date: Mon, 28 Sep 2026 14:11:57 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Mario Limonciello <superm1@gmail.com>, Joerg Roedel <joro@8bytes.org>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>,
 Jatin Kataria <jkataria@netflix.com>, Boqun Feng <boqunf@netflix.com>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>
Subject: Re: [PATCH v2 1/2] iommu/amd: Add PerfOpt IOMMU performance
 optimization support
Message-ID: <20260928171157.GI163130@ziepe.ca>
References: <20260908041207.38113-1-mario.limonciello@amd.com>
 <20260908041207.38113-2-mario.limonciello@amd.com>
 <20260924225018.GB16465@ziepe.ca> <arYf3iJW7hfTua__@8bytes.org>
 <20260925122848.GD163130@ziepe.ca>
 <4560d7d3-4d67-457d-bcd7-2176bd850bd4@amd.com>
 <20260925223928.GE163130@ziepe.ca>
 <ab1cdd64-3390-480a-8d41-a942e8b2e120@gmail.com>
 <20260928120831.GF163130@ziepe.ca>
 <34bcdf7a-82b1-43cb-8409-735ebef3fa97@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34bcdf7a-82b1-43cb-8409-735ebef3fa97@amd.com>
X-Mailman-Approved-At: Tue, 29 Sep 2026 08:23:02 +0000
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

On Mon, Sep 28, 2026 at 10:32:41AM -0500, Mario Limonciello wrote:

> Actually; no.  amdgpu has migrated away from PCI IDs and probes based on the
> "ATI vendor" + "display class" instead.  As part of the probe sequence there
> is something called an IP discovery table pull from the platform that
> identifies all IP blocks in the hardware.

Oh, so that big table is not processing pci ids.. OK

> This IP discovery table will indicate graphics IP and that is mapped to
> relevant driver code.  So for example GC 11.5.1 is what you find in a Strix
> Halo APU.  If a future APU had exactly the same graphics IP but a different
> display IP it would still be GC 11.5.1.

Move this stuff to drivers/firmware and iommu and GPU can access it
together?

"IP discovery table" sure sounds like a platform firmware datablob to
me at least?

Jason
