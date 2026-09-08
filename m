Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55867C79FA0
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 08:54:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2BAB10E0C4;
	Tue,  8 Sep 2026 08:54:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="aWHIqabL";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00FA810E0C4
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 08:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=x2sptS86kWKzcM9tp7GIxXLzKXpOufPv4BhiXQlaYyk=; b=aWHIqabLFiZP1UEN+EKWJ32QYk
 /rW2irZIk5frqCIkMHG1FGKmFXO4ZJyM5UiwVy6+Y3NEMmv6WDVWgMwFI7KPsRT5JJdfXdBZHyFw4
 4CEUedHLymebaOxBGYF29KfqXxun1VCMNhhZt7HUrVFbj5asQH3bIrH8szMBXZODm5MEKGRVv8aRE
 N84pwY/6C5xJATYJcC3vI4QTQ72vwHUODwpd/wLXMot6Cvmn8FomMG56kIUosbXRm+dSwWLwNlGgN
 wA5qpzFtGXUOPp3NxpbZIQTNf7CoqvdPsO9IN68rYCPKYRmjd5kKRbnU17RGhO856xHOXYSWGMCeJ
 HhJy0UqQ==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1x3raf-00GPSG-OL; Tue, 08 Sep 2026 10:54:05 +0200
Message-ID: <76000248-b0ac-478d-bb13-45d4eebb1676@igalia.com>
Date: Tue, 8 Sep 2026 09:54:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] drm/amdgpu: Store SDMA instance and index in the ring
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>
References: <20260622143649.54632-1-tvrtko.ursulin@igalia.com>
 <20260622143649.54632-2-tvrtko.ursulin@igalia.com>
 <15g9zLryTPO4j32E_pIEBQ@gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <15g9zLryTPO4j32E_pIEBQ@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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


On 08/09/2026 09:42, Timur Kristóf wrote:
> On 2026. június 22., hétfő 16:36:48 közép-európai nyári idő Tvrtko Ursulin
> wrote:
>> Instead of searching for the matching SDMA instance inside many of the
>> SDMA ring vfuncs, lets just cache the instance and index in the new SDMA
>> specific section of struct amdgpu_ring. This converts a function call plus
>> array walks to a direct lookup.
> 
> AFAIK, the rings already have the IP block instance ID in the "me" field. So
> this could be simplified by using that. For example like this:
> https://pastebin.com/raw/jp4Uk2sE

Ah thank you, it never occurred to me ring->me is not a management 
engine of some sort but ring's personal pronoun. :)

>>
>> While at it, we also consolidate the initialization side with a new
>> amdgpu_sdma_ring_init() helper.
> 
> Can you move that part to a separate commit?

Yes that makes much more sense indeed, will do.

Regards,

Tvrtko

