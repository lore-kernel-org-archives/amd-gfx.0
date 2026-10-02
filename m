Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E79BCA5FD4
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2026 03:57:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFBCA10E426;
	Fri,  2 Oct 2026 03:57:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fiJkGWu5";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D98D10E426
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2026 03:57:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A9DC8413F8;
 Fri,  2 Oct 2026 03:57:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DED1F000FF;
 Fri,  2 Oct 2026 03:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790913439;
 bh=JGbxfjALTUQwxq1qJv01o3GgQpTAqeK9iKQm41v7RH0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=fiJkGWu5LJxFkR3v6K0UnkZ3TKNnXEv4qWypJMDSvW9pkeN4RItLn2SBF7Ubej4VB
 xmU0yzbWQ12Xf4YDF4O15g4sX6iZyJFRFLedUWJREiGGU+Wj1V3Mz8n2f01OLYhyzf
 /KjbfSVPIWDd2SgNG2VrgelKFaIK+EPZ/hYD1HsKE1/iWsb4qj3bMQpZ/PepUuDqPC
 WmjdW0Dh2jfdQ2uCNRgr8cMfYE/5yyMqNYGPE4XiDZmI6Xm4UOlSA8xazXs8nvRQ7N
 eP4Tr3nd6sSTPpNViD1JuXoey7tLZx7cQj561YBho3gXAPvNle2TU5o0RMf7zuPGzJ
 ISREDXIhmnXwQ==
Message-ID: <f790bd53-8610-4e8a-aa4c-1f346c0cbbe6@kernel.org>
Date: Thu, 1 Oct 2026 22:57:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] iommu/amd: Make PerfOpt compulsory
To: Vasant Hegde <vasant.hegde@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alex Deucher <alexander.deucher@amd.com>, Joerg Roedel <joro@8bytes.org>, 
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>
References: <20261001182410.1525285-1-superm1@kernel.org>
 <d4634df4-ab32-46df-8b05-665998959e43@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <d4634df4-ab32-46df-8b05-665998959e43@amd.com>
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



On 10/1/26 10:44 PM, Vasant Hegde wrote:
> 
> 
> On 10/1/2026 11:54 PM, Mario Limonciello (AMD) wrote:
>> PerfOpt is only a feature usable by integrated GPUs and only in identity
>> mode.  Instead of leaving a policy knob in amdgpu, just turn it on when
>> an integrated GPU is in identity.
>>
>> PerfOpt locks the GPU into identity mode where the DTE is ignored, so mark
>> it require_direct (blocks VFIO/iommufd claims) and disable PASID (no GCR3
>> table in the fast path).
>>
>> This drops quite a bit of compatibility glue.  There was a refcounting
>> system, exported symbols, and device attach/detach logic.  By just setting
>> it immediately it's a lot more straightforward.
>>
>> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
>> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
>> ---
>> v4:
>>   * Disable PASID for PerfOpt devices
>>   * Don't allow attaching a blocked domain
> 
> This will block attaching device to guest via vfio-pci. Is that fine?
> 
> -Vasant
> 

Right - The thing is from that experiment on v3, putting it in blocked 
domain does nothing while PerfOpt is enabled.

I figured the user should be aware; so I was between blocking attaching 
a blocked domain or showing a warning.


