Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0247CC98325
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2026 00:03:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F25F10E558;
	Fri, 25 Sep 2026 00:03:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dsD0KwM8";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D49FC10E558
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2026 00:03:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8F0F343287;
 Fri, 25 Sep 2026 00:03:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 632DD1F00893;
 Fri, 25 Sep 2026 00:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790294637;
 bh=IvuCKKesGJGL73AIQe+UGtgPPKsfK1qWpEmaJi2MOd0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=dsD0KwM8YVrziEOOqLDWjFJgwJI8FUvtKfnwmXVqSQTnkWyDDS0bvwk1CPnhOwGuK
 4qzJClli4k6JplFx6KBiU1MnCrvqV8an2EWJERI7csS6ETJpeTjFfvIQ8d9vg4jCfp
 sPoZX1fdPeYO8VoWWReXBGifan0kkh3nDENdrow4fPm8vEUCviF+ld1D9VjUbpjJ2x
 HSQlbIKtrS1vpvNAW4SSwqRwUyxJ+KIvo2Jpbh8wSpCddNuEjg0sx9T9/bYfJkXdq+
 UVnSs1oeWISy11eoNrpnW3rb3uTbzzPJPaZqAqY+X0EiYTFNp8pFEq+GsRZinHytOq
 qtTbnlALlF+5A==
Message-ID: <5a6ba6f3-4d8b-4d67-8e5a-ffbe22126464@kernel.org>
Date: Thu, 24 Sep 2026 19:03:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] iommu/amd: Add PerfOpt IOMMU performance
 optimization support
To: Jason Gunthorpe <jgg@ziepe.ca>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, Joerg Roedel <joro@8bytes.org>, 
 amd-gfx@lists.freedesktop.org,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>,
 Jatin Kataria <jkataria@netflix.com>, Boqun Feng <boqunf@netflix.com>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>
References: <20260908041207.38113-1-mario.limonciello@amd.com>
 <20260908041207.38113-2-mario.limonciello@amd.com>
 <20260924225018.GB16465@ziepe.ca>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260924225018.GB16465@ziepe.ca>
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



On 9/24/26 5:50 PM, Jason Gunthorpe wrote:
> On Mon, Sep 07, 2026 at 11:12:06PM -0500, Mario Limonciello wrote:
>> +EXPORT_SYMBOL_GPL(amd_iommu_enable_perfopt);
> 
> Last time we hardwired the GPU and IOMMU drivers together it was a
> huge mess to undo.
> 
> Why does the GPU driver have to request this? Why can't the iommu
> driver know that this is a special device that can use this magic fast
> path and then auto set it when identity is asked for?

The reason was to allow an "opt-out" path on the GPU driver.

> 
> How does the GPU driver even know it is magic special?

See patch 2/2.  GPU driver looks if it's an APU and it's in identity 
mode.  The special mode is only for the GPU in an APU.  It shouldn't be 
applied to anything else.
> 
>> +	/*
>> +	 * Restore ATS/PRI/PASID (and thus SVA) by re-homing the device onto its
>> +	 * identity domain with the flag cleared, so a later bind without PerfOpt
>> +	 * sees a normally-capable device. See the locking note in
>> +	 * amd_iommu_enable_perfopt().
>> +	 */
> 
> And this is sort of a wrong thing in the driver, it shouldn't have ATS
> turned on for identitiy mappings, and it certainly shouldn't have PRI
> turned on until a PRI capable domain is attached.
> 
> Jason
> 

amd_iommu_disable_perfopt() only re-applies the policy that was 
previously set before PerfOpt.

If you would like I'll send a follow up patch to clarify this comment.
