Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 469E9E77197
	for <amd-gfx@archiver.kernel.org>; Sat,  4 Jan 2025 16:58:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A2DE10E00F;
	Sat,  4 Jan 2025 16:58:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="hVSwqx/x";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72A4B10E8D9
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jan 2025 14:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WC3/mHz9p53uqeY9BMahgfN4rk0EMxbE3AOPwr1LnN4=; b=hVSwqx/xGwMkuv3FWDR0yMyT+1
 M/homfS+66K78o2tX9hx+GBxwFbXt7Oe2qCoy0Su/c/+M2w1IGkBH1hEB81gMv7fdwKeJOpIx6hK1
 Jv8NVp/Npxnp8NK1/rDCW5rAsTak0tE7jn1wvSVbtAYDN/O5NueCuzEIKPwAYVGOFOD9AbzsaCJ1J
 tu5bYJ6g+fuBEEvpqVx8b0IFJaPm6nVLg9wiyYcIEm9fMnpPiRYK8bAYiUVupn38noj3d4zYgljWZ
 zzc0Ls9p8Fuy8yjvxX8aKi6xWiZ2tN08D9z/TN7NuzwCrZqTk/tmPHAFC7M2RCTzPJ8autTx1t7J3
 8TLRkf3A==;
Received: from [90.241.98.187] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1tTiqb-00BFYT-Bg; Fri, 03 Jan 2025 15:40:21 +0100
Message-ID: <b09c8456-a907-421e-ada8-e0af72107bde@igalia.com>
Date: Fri, 3 Jan 2025 14:40:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] drm/amdgpu: Use memset32 for IB padding
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Sunil Khatri <sunil.khatri@amd.com>
References: <20241227111938.22974-1-tursulin@igalia.com>
 <20241227111938.22974-2-tursulin@igalia.com>
 <0757a5c8-5aaf-4874-9c7b-1ee20aec41e4@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <0757a5c8-5aaf-4874-9c7b-1ee20aec41e4@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 04 Jan 2025 16:58:36 +0000
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


On 02/01/2025 13:45, Christian König wrote:
> 
> 
> Am 27.12.24 um 12:19 schrieb Tvrtko Ursulin:
>> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>
>> Use memset32 instead of open coding it, just because it is
>> that bit nicer.
> 
> In general looks mostly good, my only concern is that we already had to 
> switch to memset_io() on some platforms for clearing buffers.
> 
> Now an IB should in theory always be in system memory, but it would be 
> nice to handle that cleanly.

I could only find kmap on the sub-allocation path which leads into IB. 
What am I missing?

Or if one day IO mapped objects will be added as backing store for SA 
then I think it shouldn't be too difficult to somehow propagate that 
fact up. Maybe all the way to struct amdgpu_ib which would then be able 
to decide here which flavour of memset to use.

Regards,

Tvrtko
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> index a6e28fe3f8d6..a27e32f48f99 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> @@ -136,8 +136,16 @@ void amdgpu_ring_insert_nop(struct amdgpu_ring 
>> *ring, uint32_t count)
>>    */
>>   void amdgpu_ring_generic_pad_ib(struct amdgpu_ring *ring, struct 
>> amdgpu_ib *ib)
>>   {
>> -    while (ib->length_dw & ring->funcs->align_mask)
>> -        ib->ptr[ib->length_dw++] = ring->funcs->nop;
>> +    u32 align_mask = ring->funcs->align_mask;
>> +    u32 count = ib->length_dw & align_mask;
>> +
>> +    if (count) {
>> +        count = align_mask + 1 - count;
>> +
>> +        memset32(&ib->ptr[ib->length_dw], ring->funcs->nop, count);
>> +
>> +        ib->length_dw += count;
>> +    }
>>   }
>>   /**
> 
