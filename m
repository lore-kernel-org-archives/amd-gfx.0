Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33059CA5FA2
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2026 18:01:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA15510E983;
	Mon, 28 Sep 2026 18:01:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Yrcvafud";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8837110E983
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 18:01:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4321B436E8;
 Mon, 28 Sep 2026 18:01:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7744F1F000FF;
 Mon, 28 Sep 2026 18:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790618483;
 bh=FqICvKR436oyLWIxH7465+Z6LW/2aaNNdeBKefqMvkI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=YrcvafudCH2JTenhTS/JSlTcNcPmi/rU0bfQdzwc0aG4WxqLznpkmgeymFj94UdRG
 5Ab8jchI9gvo1KYP8h0OG0YG1C+FsAka1SjOVq7o5tXpJ+ZpjueQyw1UCmcFgBCuw1
 9k3UJCUBAWJLlP9JPbyBhuf+tzG5XJSE6ye7yqTMmbhKuQtXKVKj3MlPZMnzfOsscj
 hKyeb+0URImPZmeDn/chvPKe7fhCkdjlkQgga04zDKgnKQwTq0sJ0yISj5ti7KtRIW
 FEhoajnN/GYyIJzi6cXGlLox+EVE/aXnEJtFe/Pjb/+syZU+5/fuoW/tWcR/QUWuoG
 4JKLxvi8WhGZQ==
Message-ID: <7a503739-9458-4d2a-a84f-276ebeb7b713@kernel.org>
Date: Mon, 28 Sep 2026 13:01:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Make PerfOpt compulsory for APUs in identity
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alex Deucher <alexander.deucher@amd.com>, Joerg Roedel <joro@8bytes.org>, 
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>
References: <20260928045050.955165-1-superm1@kernel.org>
 <20260928172741.GJ163130@ziepe.ca>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260928172741.GJ163130@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 9/28/26 12:27, Jason Gunthorpe wrote:
> On Sun, Sep 27, 2026 at 11:50:50PM -0500, Mario Limonciello (AMD) wrote:
>> PerfOpt is only a feature usable by integrated GPUs and only in identity
>> mode.  Instead of leaving a policy knob in amdgpu, just turn it on when
>> an integrated GPU in an APU is in identity. Re-use the heuristic in
>> amd_iommu_def_domain_type() to make this decision.
>>
>> This drops quite a bit of compatibility glue.  There was a refcounting
>> system, exported symbols, and device attach/detach logic.  By just setting
>> it immediately it's a lot more straightforward.
>>
>> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
>> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   1 -
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  50 -----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  12 --
>>   drivers/iommu/amd/amd_iommu.h              |   2 +-
>>   drivers/iommu/amd/amd_iommu_types.h        |   3 -
>>   drivers/iommu/amd/init.c                   |   3 +-
>>   drivers/iommu/amd/iommu.c                  | 234 ++++-----------------
>>   include/linux/amd-iommu.h                  |  11 -
>>   8 files changed, 48 insertions(+), 268 deletions(-)
> 
> Diffing across the originals to net them out it is much smaller:
> 
>   5 files changed, 122 insertions(+), 1 deletion(-)
> 
> And I think this is much better , but I have a few questions
> 
> Why is this setting and clearing perf_opt in dev_data?
> 
> I expect probe to make a determination if this device has the special
> path and if so then there should be a permanent flag in the dev_data.
> 
> Based on that flag amd_iommu_def_domain_type() can return identity to
> override things
> 
> When the driver does an identity attachment it would enable the
> perfopt and write out the right DTE for it.

I believe you're right.  This was an artifact from the tracking I had to 
do when it was a two driver solution.  I'll rework it.

> 
> Whenever the driver removes that identity it would disable the
> perf_opt. These points are all marked out in the attach function flow
> you don't need another variable to keep track, or the funny logic to
> block things. All you want is an attached identity domain that is
> "optimized".
> 
> Release goes to blocked which should already disable it, so no need to
> disable it again in amd_iommu_release_device()
> 
> The repeated pattern is a bit much:
> +       if (dev_data->perfopt) {
> +               if (WARN_ON(amd_iommu_perfopt_clear(iommu)))
> +                       dev_err(dev, "IOMMU%d: failed to clear PerfOpt on release\n",
> +                               iommu->index);
> 
> Clear should probably just do the warn on and not return any error
> code. It is never OK to allow this to fail..

OK.

> 
> I'm also scratching my head a bit why the global register needs to be
> set/unset like this? Does that global bit completely bypass the iommu
> for a single special device? With no way to discover from FW which BDF
> is the special device? If this is the right guess please document this
> in a comment around __perfopt_write (and again that's awful, ACPI
> should have a pointer to the special device so the OS can understand
> this)
> 
Yeah; it's only for the privileged integrated GPU to access system memory.

I'll leave a comment around it in a v2.
