Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67213CEDD93
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 13:32:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E63910E717;
	Wed,  9 Oct 2024 13:32:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="XnumZVjG";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 220F610E669
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 07:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QxoonKYIeouRV9JVmnxl80EhVidi1HBKDMiSbKDh4Vs=; b=XnumZVjGl+n58xK5e4N1BLG7Qb
 U/Q7VVwKZ6xUldCFPSGzQJ+lLnEW9l0vIhhvrgZeJp3e3JSBSDLJSgkmnYth9Z0vdynG8sbDtpVjr
 9wu0+AcdRscp7UjwiMV9yHeHrL4+BXqc/AjY8BLsXoCqNpT5X5ZxJZ2RWV6L2m3TftHOhhWlIni+A
 NMRfcX3CR/UZYBrYyEmO3O7j/KxVcdgied4k+gQLQRf1aFAPejV1YPRcqOCOnItKetLyJd+JRGl/S
 bAoVGm4dCCdV/Zzqesjlo+SYaVlzT1Qsea7SYQxyxu1LJ55SA6CxDzFCm5JR0ScBvanmUMAOlJAyX
 tCmMhrHA==;
Received: from [90.241.98.187] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1syRHI-006rHj-Kj; Wed, 09 Oct 2024 09:38:36 +0200
Message-ID: <0a3d60a6-f053-4884-9e3f-6f55550b6db5@igalia.com>
Date: Wed, 9 Oct 2024 08:38:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Ring padding CPU optimisation and some RFC bits
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Sunil Khatri <sunil.khatri@amd.com>
References: <20241008150532.23661-1-tursulin@igalia.com>
 <d363fa0b-a22b-4fad-9027-ed6f831b92dc@gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <d363fa0b-a22b-4fad-9027-ed6f831b92dc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 09 Oct 2024 13:32:04 +0000
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


On 08/10/2024 19:10, Christian König wrote:
> Am 08.10.24 um 17:05 schrieb Tvrtko Ursulin:
>> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>
>> I've noticed the hardware ring padding optimisations have landed so I 
>> decided
>> to respin the CPU side optimisations.
>>
>> First two patches are simply adding ring fill helpers which deal with 
>> reducing
>> the CPU cost of emitting hundreds of nops from the 
>> for-amdgpu_ring_write loops.
>>
>> If receptive for the idea, please double-check I preserved endianess 
>> behaviour
>> as is.
> 
> I'm pretty sure that this was broken before or at least uses HW features 
> which are not guaranteed to work any more.
> 
> Sunil has already commited a set which does mostly the same as this 
> here. The only thing missing is the improvements for the IB patching and 
> a bunch of things I've been working on recently.
> 
> Going to send those out in a Minute, would be cool if you could run a 
> few performance analysis on those patches as well since you already seem 
> to have the setup for that.

Are you refering to "drop volatile" and "stop masking wptr" or something 
else? I haven't seen anything that adds an equivalent of my 
amgdpu_ring_fill yet.

Regards,

Tvrtko
