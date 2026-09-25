Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C64DC9831E
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2026 00:21:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5D3110E767;
	Fri, 25 Sep 2026 00:21:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hSLg7FXO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CABA10E767
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2026 00:21:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9ABA8601F6;
 Fri, 25 Sep 2026 00:21:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C46E1F000FF;
 Fri, 25 Sep 2026 00:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790295678;
 bh=gyCscDrvbCzB9iNXT7GjqtIZgcR8xxRnG4OhnV//SYg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=hSLg7FXOTR1SqjNfmTTNge4RI3UGXFbTXBttDXi0CBsiVe7DY4LXcCBRm9SN9YWoO
 M99X62qTDgScE3mLhPsV2VrxrG2sH0IRKcw/JZJrhqtgAhr9h0B8QP2qP1g1SyR2RE
 QcRQBNoiABbHMXFEJY0qEr8lULiLJF/QGIIE13smz2jYPqje0v+NANkwop2ng1Xu/i
 M588vrWqAg47efQt15BU23AoPete3w7SqjxKm5+ELvxUKvRbd3+n3/2VE+wst+9s+C
 3HRImuU7oMedvDu2EgGoMQWHCYmZ3f4GN5Dqyk8TgxMJ88Skn4In7s067IwgjbBeBk
 ilYkrGp2YXtTw==
Message-ID: <3ca396df-a2d4-45b9-9a9c-45e0f414a423@kernel.org>
Date: Thu, 24 Sep 2026 19:21:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] iommu/amd: Add PerfOpt IOMMU performance
 optimization support
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Joerg Roedel <joro@8bytes.org>,
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
 <5a6ba6f3-4d8b-4d67-8e5a-ffbe22126464@kernel.org>
 <20260925001718.GC163130@ziepe.ca>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260925001718.GC163130@ziepe.ca>
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



On 9/24/26 7:17 PM, Jason Gunthorpe wrote:
> On Thu, Sep 24, 2026 at 07:03:56PM -0500, Mario Limonciello wrote:
>>
>>
>> On 9/24/26 5:50 PM, Jason Gunthorpe wrote:
>>> On Mon, Sep 07, 2026 at 11:12:06PM -0500, Mario Limonciello wrote:
>>>> +EXPORT_SYMBOL_GPL(amd_iommu_enable_perfopt);
>>>
>>> Last time we hardwired the GPU and IOMMU drivers together it was a
>>> huge mess to undo.
>>>
>>> Why does the GPU driver have to request this? Why can't the iommu
>>> driver know that this is a special device that can use this magic fast
>>> path and then auto set it when identity is asked for?
>>
>> The reason was to allow an "opt-out" path on the GPU driver.
> 
> This seems like a very poor reason for doing this given the past
> negative experiances.
> 
> Jason

I guess I don't have the context of what happened in the past.  Could 
you fill me in?  I'm not against it being automatic when in identity 
mode.  I'll just need to come up with a way to check it's the GPU inside 
of an APU not a dGPU connected to the APU.
