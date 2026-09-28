Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E1B1C9832A
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 08:23:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0F3710ED7C;
	Tue, 29 Sep 2026 08:23:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="DgHxUQxO";
	dkim-atps=neutral
Received: from mail-qv2-f41.google.com (mail-qv2-f41.google.com
 [74.125.230.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C344910E93E
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 17:27:44 +0000 (UTC)
Received: by mail-qv2-f41.google.com with SMTP id
 6a1803df08f44-91784fbb60dso885426d6.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 10:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1790616463; x=1791221263; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Snkhkpv5tfQYCAgHHo/k8kMLGqfuMfM+gSc1uL+OvlM=;
 b=DgHxUQxOIHzuDvEv4NJMXoEnhLb+Wq/hFx5atqWJL9AMj9QsmBb3ePlc1Y5g3j6hAN
 ELzAuqGne6RJS0t/uZFUH/NIzi8TGhnWPLvOGQVCNnw1RnH3UA+Tnl8EujDO+w5usayq
 0jJk8e4+TP8dqxBabIAguXpVPtRCEYRvnrVuiXR+XPtOV+/+lpisWMEh/ebosj0fPAyH
 mZk4KuaGebQNSvYc/VpdTwM6FzAqzJXIvaYQLBpo0bVmGeLXIEGndRF9xp0LlTAStoEE
 cVfed+DuAmSqkiYiswUAG1Xuoz8csj5/VxOVSRrXdwR/h443+4G9Yn0c4Ktb1EO+fU0n
 4PoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790616463; x=1791221263;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Snkhkpv5tfQYCAgHHo/k8kMLGqfuMfM+gSc1uL+OvlM=;
 b=dGEfJX//1QSMMZHRKjyNax+5tQhNvJ6WiRz7q7o1pqVRkLiZrWYSz2eWezs2/zS22V
 JwA6w0DCE9sBhQLp4LGsTtsV6Mb5pbXoNlrqn9saKSJItvJxHtMm/zhxpGfincFu13Fx
 Qro08PMnf+do3LM+vbg29dSf7cSZ+PcVtUcypeO5zB9Dr4AsFH1NQGVqWoXxVEz8RdJY
 Mq7F+zkJQIO2+Dy3UzyixnqkN5AGrMJr3H5tPsMpGMOqtkeT/qjOXkng+Ze5h/A0uIH5
 UGPtEOotXaT65ZGpX6N3XnhOlJTicqLoJ1pDiPrm33TBR+MARJNuQpJWjPzhQIwFXFO3
 9l1g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwCRjz34b0QIrKzYv6GopdurFnivOZ5cUwlPC17JA+04oxI8JRzTcCMUvWstZTEIFhprgWLp6Wp@lists.freedesktop.org
X-Gm-Message-State: AFuF++l1n+BoCDQhVn1Y0P2TgX3Arlq8CqJo03z7qcGH0XHnWw7rSOHD
 Hrxc4PtLU4wzUSnFgIlcaY61BGZVeZ2cZryk5oBHUkqY0EKHciKwLSg1MclIoEf0ZHU=
X-Gm-Gg: AYBFou03FAECtU2Dy+0xOhgxIwvn3MegWEhORwhYnHur4qqrUAWUlug4UZqrwZt3HKf
 CExF3JJxYGrKjWejzluQXI9+vvWf81iDeYKezhDHowQFBZ2lHZ6LPO2R+5VLhcPcco/E+cDuH7r
 sXj8NQamTyWIItvVTqlOJ1so9JcDN3WWftaFNsvesB9DSYednZxIqInvTbgCOkPwgrhu5+6uHXj
 erFJIRmWBtq70RteX+r3BzzZmFFvBI/WpOfmxTEyBerZG6nSKQoRahhkZEDYxVR3SLo/Cm2Gxqj
 flomrfnDQI3QePRUThltU4QJYH0GCRDidBm0m6RYJDFzvEycjxZPoG3p4cqZKxFd74iT3cWwhcw
 yGy4jrvcrqehMasgQZvvtd5fcMEFWaEPXWo3ImKPxXBLXlIW1BEUHaursZaeMgcPHTnL6pnkH4X
 +o/Ht1o9wAOu2Sck2KSr3VYRMBjo8Nf36fw5JEXwTWIbz9
X-Received: by 2002:a05:6214:ca2:b0:915:e892:d932 with SMTP id
 6a1803df08f44-915e892f966mr81063516d6.3.1790616463265; 
 Mon, 28 Sep 2026 10:27:43 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9144b6335f6sm57161666d6.11.2026.09.28.10.27.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 10:27:42 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1xBF8f-00000007NXN-3v3H;
 Mon, 28 Sep 2026 14:27:41 -0300
Date: Mon, 28 Sep 2026 14:27:41 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: Alex Deucher <alexander.deucher@amd.com>, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>
Subject: Re: [PATCH] iommu/amd: Make PerfOpt compulsory for APUs in identity
Message-ID: <20260928172741.GJ163130@ziepe.ca>
References: <20260928045050.955165-1-superm1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928045050.955165-1-superm1@kernel.org>
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

On Sun, Sep 27, 2026 at 11:50:50PM -0500, Mario Limonciello (AMD) wrote:
> PerfOpt is only a feature usable by integrated GPUs and only in identity
> mode.  Instead of leaving a policy knob in amdgpu, just turn it on when
> an integrated GPU in an APU is in identity. Re-use the heuristic in
> amd_iommu_def_domain_type() to make this decision.
> 
> This drops quite a bit of compatibility glue.  There was a refcounting
> system, exported symbols, and device attach/detach logic.  By just setting
> it immediately it's a lot more straightforward.
> 
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  50 -----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  12 --
>  drivers/iommu/amd/amd_iommu.h              |   2 +-
>  drivers/iommu/amd/amd_iommu_types.h        |   3 -
>  drivers/iommu/amd/init.c                   |   3 +-
>  drivers/iommu/amd/iommu.c                  | 234 ++++-----------------
>  include/linux/amd-iommu.h                  |  11 -
>  8 files changed, 48 insertions(+), 268 deletions(-)

Diffing across the originals to net them out it is much smaller:

 5 files changed, 122 insertions(+), 1 deletion(-)

And I think this is much better , but I have a few questions

Why is this setting and clearing perf_opt in dev_data?

I expect probe to make a determination if this device has the special
path and if so then there should be a permanent flag in the dev_data.

Based on that flag amd_iommu_def_domain_type() can return identity to
override things

When the driver does an identity attachment it would enable the
perfopt and write out the right DTE for it.

Whenever the driver removes that identity it would disable the
perf_opt. These points are all marked out in the attach function flow
you don't need another variable to keep track, or the funny logic to
block things. All you want is an attached identity domain that is
"optimized".

Release goes to blocked which should already disable it, so no need to
disable it again in amd_iommu_release_device()

The repeated pattern is a bit much:
+       if (dev_data->perfopt) {
+               if (WARN_ON(amd_iommu_perfopt_clear(iommu)))
+                       dev_err(dev, "IOMMU%d: failed to clear PerfOpt on release\n",
+                               iommu->index);

Clear should probably just do the warn on and not return any error
code. It is never OK to allow this to fail..

I'm also scratching my head a bit why the global register needs to be
set/unset like this? Does that global bit completely bypass the iommu
for a single special device? With no way to discover from FW which BDF
is the special device? If this is the right guess please document this
in a comment around __perfopt_write (and again that's awful, ACPI
should have a pointer to the special device so the OS can understand
this)

Jason
