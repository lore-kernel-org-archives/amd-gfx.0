Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB9CD116F1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 11:02:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DCFA10E11B;
	Mon,  1 Dec 2025 11:02:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="HtuVKQgd";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71A6B10E11B
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 11:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1klX/Z54QKI3NMDGjICgajNYbRF65XwOlnzoBIKbVxU=; b=HtuVKQgd7Y8TecZSTpIK9dSdfE
 R0nZx7HpyM0Qc2PQ+pu4UXqJHURpNrXwvm87X1tEBNA5fGHJhsSf7+jBNrrST7lBtTPAN9hYRt5JI
 DI7zlqUYKjMxPKTwwUGsW+Y+5ZLXA0AQABChpn1uuJuAbixGjaRcaiHeoySEHnSVXNpYrTrKZQS/d
 RBnBBYimPCWSBD8oT/wD+n2lGopxtmDKAmN9aI64QSDp6wdTXlKHnqJFeIne9vWXECpWDJCfDXyDC
 aNMEvudEH7XM0WeDzpMVKXNtqcw1NrCW45Edtn6KJ6G17iOBMrCmDrpUUQBjHETyW7QazGmm3u5aC
 KidQjrpQ==;
Received: from [90.240.106.137] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1vQ1fZ-007Lke-CL; Mon, 01 Dec 2025 12:02:13 +0100
Message-ID: <9cb701a5-76a4-46c4-ac72-8812decbc1c6@igalia.com>
Date: Mon, 1 Dec 2025 11:02:12 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Allow direct CPU drawing of DRM panic on APUs
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>,
 Melissa Wen <mwen@igalia.com>, Rodrigo Siqueira <siqueira@igalia.com>
References: <20251128150814.11612-1-tvrtko.ursulin@igalia.com>
 <eef300e9-9368-43db-b148-f31453031f88@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <eef300e9-9368-43db-b148-f31453031f88@amd.com>
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


On 01/12/2025 08:27, Christian König wrote:
> On 11/28/25 16:08, Tvrtko Ursulin wrote:
>> There is no need to draw the panic screen via the slow MMIO access on
>> APUs, since the frame buffer is guaranteed to be CPU accessible.
> 
> Well that is actually not correct. It is only guaranteed to be CPU accessible on 64bit kernels!
> 
> I suggest to use the appropriate test function to see if a BO is fully CPU accessible or not and just drop the check for the AMDGPU_GEM_CREATE_NO_CPU_ACCESS flag.
> 
> BTW: It is perfectly normal for the framebuffer to not be in VRAM on APUs! So the check below is broken as well.

Hmm I also misread the tail end of this function. It wouldn't even work 
if frame buffer was non-contiguous since it uses ttm_bo_kmap.

Never mind then, archive to /dev/null please.

Regards,

Tvrtko

>>
>> Lets skip setting the .set_pixel method which allows the DRM panic core to
>> just work and it renders much more quickly.
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: "Christian König" <christian.koenig@amd.com>
>> Cc: Melissa Wen <mwen@igalia.com>
>> Cc: Rodrigo Siqueira <siqueira@igalia.com>
>> ---
>> FWIW this draws the panic faster, but.. the whole DRM panic setup only
>> appears to work with non-tiled modes. There is something broken in the
>> dcn10_reset_surface_dcc_and_tiling() code with "more advanced" modes
>> where thing the turning off compression seems to trigger some weird
>> display engine behaviour. (On the Steam Deck at least.)
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
>> index b5d34797d606..7f75f1319d3f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
>> @@ -1900,7 +1900,8 @@ int amdgpu_display_get_scanout_buffer(struct drm_plane *plane,
>>   
>>   	sb->pitch[0] = fb->pitches[0];
>>   
>> -	if (abo->flags & AMDGPU_GEM_CREATE_NO_CPU_ACCESS) {
>> +	if (!(amdgpu_ttm_adev(abo->tbo.bdev)->flags & AMD_IS_APU) &&
>> +	    (abo->flags & AMDGPU_GEM_CREATE_NO_CPU_ACCESS)) {
>>   		if (abo->tbo.resource->mem_type != TTM_PL_VRAM) {
>>   			drm_warn(plane->dev, "amdgpu panic, framebuffer not in VRAM\n");
>>   			return -EINVAL;
> 

