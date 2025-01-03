Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD923E7719B
	for <amd-gfx@archiver.kernel.org>; Sat,  4 Jan 2025 16:58:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 868DF10E476;
	Sat,  4 Jan 2025 16:58:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="XY4Rh6kL";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8BEE10E8A0
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jan 2025 13:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=C7ocV46Q7NFXP4nCUml0S0C6qTO8SbJoc4nbcIdi8A8=; b=XY4Rh6kL+yLBdja3PvfOd0hlra
 Q3s+P4FzLDZN71pcPEZWVnSkL60ugyoea+Md+TnsgJ6cVPP25I+Q8KOWaddMl8j6SMA1aKYMZMfI3
 etNblDr7wWwTJAskPbX+hnIaSOiwi/EKLPO5nX/W2xau3VP9XdrfnDncvOdPFgLSRCEVcwagwvWiL
 0DY1xbM3UVtp7bInoi1/GeUslGxaIeXaNX22jEQjCdLaPxnAICFdS7OCKOth48iszuHemjAQ1AnLc
 QRi/G11trjGdEjXld+1dw4Nia5Zk6+bS6IIvnhxJUwhvm/glbQy7zsmjiyqsX43W2ar+js4BskwzX
 lrHg9L5g==;
Received: from [90.241.98.187] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1tThK8-00BE8E-Hu; Fri, 03 Jan 2025 14:02:44 +0100
Message-ID: <bde9d523-db9c-4a20-a0d9-4e1befbe85b5@igalia.com>
Date: Fri, 3 Jan 2025 13:02:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/12] drm/amdgpu: Optimise amdgpu_ring_write()
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Sunil Khatri <sunil.khatri@amd.com>
References: <20241227111938.22974-1-tursulin@igalia.com>
 <20241227111938.22974-10-tursulin@igalia.com>
 <5b3b2fa0-cbf8-41e4-b6ab-b66996b94de2@gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <5b3b2fa0-cbf8-41e4-b6ab-b66996b94de2@gmail.com>
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


On 02/01/2025 13:55, Christian König wrote:
> Am 27.12.24 um 12:19 schrieb Tvrtko Ursulin:
>> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>
>> There are more than 2000 calls to amdgpu_ring_write() in the driver and
>> the majority is multiple sequential calls which the compiler cannot
>> optimise much.
>>
>> Lets make this helper variadic via some pre-processor magic which allows
>> merging those sequential calls and in turn enables the compiler to emit
>> much less code.
> 
> I've played around with the same idea before abandoning it for this 
> patch here: 
> https://lore.kernel.org/all/20241008181134.1350-2-christian.koenig@amd.com/

That would be nicer indeed. Okay I will leave you to it. And if you see 
something in this series which does not overlap with your work and looks 
interesting let me know.

> Basically we don't need to update count_dw nor mask the WPTR which has 
> the same effect as this optimization here and far less code change.
> 
> The problem is that some code for Polaris HW generations seem to use the 
> WPTR or count_dw directly for some calculation. I didn't had time to 
> clean that up and push the resulting change.

Is there a public mapping table for figuring out which IP block versions 
are Polaris?

I can't grep any count_dw usage and in case of wptr the places I found 
which access it directly (but I was only converting a small subset of 
files) where sdma_v5_2_ring_init_cond_exec, 
sdma_v6_0_ring_init_cond_exec and sdma_v7_0_ring_init_cond_exec. Not 
sure if it is those you had in mind or there is something else?

Regards,

Tvrtko

>> If we then would convert some call sites to use this macro, lets see on
>> the example of amdgpu_vce_ring_emit_ib(), what results that would bring.
>> Before (but after the wptr local caching, before it is even worse):
>>
>>    173c39:       48 89 f8                mov    %rdi,%rax
>>    173c3c:       48 89 d1                mov    %rdx,%rcx
>>    173c3f:       48 8b 97 c8 01 00 00    mov    0x1c8(%rdi),%rdx
>>    173c46:       48 8b b0 a8 01 00 00    mov    0x1a8(%rax),%rsi
>>    173c4d:       89 d7                   mov    %edx,%edi
>>    173c4f:       23 b8 f8 01 00 00       and    0x1f8(%rax),%edi
>>    173c55:       48 83 c2 01             add    $0x1,%rdx
>>    173c59:       c7 04 be 02 00 00 00    movl   $0x2,(%rsi,%rdi,4)
>>    173c60:       48 23 90 f0 01 00 00    and    0x1f0(%rax),%rdx
>>    173c67:       48 89 90 c8 01 00 00    mov    %rdx,0x1c8(%rax)
>>    173c6e:       48 8b b0 a8 01 00 00    mov    0x1a8(%rax),%rsi
>>    173c75:       89 d7                   mov    %edx,%edi
>>    173c77:       48 83 c2 01             add    $0x1,%rdx
>>    173c7b:       83 a8 e0 01 00 00 01    subl   $0x1,0x1e0(%rax)
>>    173c82:       4c 8b 41 10             mov    0x10(%rcx),%r8
>>    173c86:       23 b8 f8 01 00 00       and    0x1f8(%rax),%edi
>>    173c8c:       44 89 04 be             mov    %r8d,(%rsi,%rdi,4)
>>    173c90:       48 23 90 f0 01 00 00    and    0x1f0(%rax),%rdx
>>    173c97:       48 89 90 c8 01 00 00    mov    %rdx,0x1c8(%rax)
>>    173c9e:       48 8b b0 a8 01 00 00    mov    0x1a8(%rax),%rsi
>>    173ca5:       89 d7                   mov    %edx,%edi
>>    173ca7:       48 83 c2 01             add    $0x1,%rdx
>>    173cab:       83 a8 e0 01 00 00 01    subl   $0x1,0x1e0(%rax)
>>    173cb2:       44 8b 41 14             mov    0x14(%rcx),%r8d
>>    173cb6:       23 b8 f8 01 00 00       and    0x1f8(%rax),%edi
>>    173cbc:       44 89 04 be             mov    %r8d,(%rsi,%rdi,4)
>>    173cc0:       48 23 90 f0 01 00 00    and    0x1f0(%rax),%rdx
>>    173cc7:       48 89 90 c8 01 00 00    mov    %rdx,0x1c8(%rax)
>>    173cce:       89 d6                   mov    %edx,%esi
>>    173cd0:       23 b0 f8 01 00 00       and    0x1f8(%rax),%esi
>>    173cd6:       48 83 c2 01             add    $0x1,%rdx
>>    173cda:       83 a8 e0 01 00 00 01    subl   $0x1,0x1e0(%rax)
>>    173ce1:       8b 79 08                mov    0x8(%rcx),%edi
>>    173ce4:       48 8b 88 a8 01 00 00    mov    0x1a8(%rax),%rcx
>>    173ceb:       89 3c b1                mov    %edi,(%rcx,%rsi,4)
>>    173cee:       48 23 90 f0 01 00 00    and    0x1f0(%rax),%rdx
>>    173cf5:       83 a8 e0 01 00 00 01    subl   $0x1,0x1e0(%rax)
>>    173cfc:       48 89 90 c8 01 00 00    mov    %rdx,0x1c8(%rax)
>>    173d03:       c3                      ret
>>
>> And after:
>>
>>      1579:       48 89 f8                mov    %rdi,%rax
>>      157c:       44 8b 4a 08             mov    0x8(%rdx),%r9d
>>      1580:       48 8b 7a 10             mov    0x10(%rdx),%rdi
>>      1584:       48 8b 90 c8 01 00 00    mov    0x1c8(%rax),%rdx
>>      158b:       8b b0 f8 01 00 00       mov    0x1f8(%rax),%esi
>>      1591:       48 8b 88 a8 01 00 00    mov    0x1a8(%rax),%rcx
>>      1598:       49 89 d0                mov    %rdx,%r8
>>      159b:       49 21 f0                and    %rsi,%r8
>>      159e:       42 c7 04 81 02 00 00    movl   $0x2,(%rcx,%r8,4)
>>      15a5:       00
>>      15a6:       4c 8d 42 01             lea    0x1(%rdx),%r8
>>      15aa:       49 21 f0                and    %rsi,%r8
>>      15ad:       42 89 3c 81             mov    %edi,(%rcx,%r8,4)
>>      15b1:       4c 8d 42 02             lea    0x2(%rdx),%r8
>>      15b5:       48 c1 ef 20             shr    $0x20,%rdi
>>      15b9:       49 21 f0                and    %rsi,%r8
>>      15bc:       42 89 3c 81             mov    %edi,(%rcx,%r8,4)
>>      15c0:       48 8d 7a 03             lea    0x3(%rdx),%rdi
>>      15c4:       48 83 c2 04             add    $0x4,%rdx
>>      15c8:       48 21 fe                and    %rdi,%rsi
>>      15cb:       44 89 0c b1             mov    %r9d,(%rcx,%rsi,4)
>>      15cf:       48 23 90 f0 01 00 00    and    0x1f0(%rax),%rdx
>>      15d6:       83 a8 e0 01 00 00 04    subl   $0x4,0x1e0(%rax)
>>      15dd:       48 89 90 c8 01 00 00    mov    %rdx,0x1c8(%rax)
>>      15e4:       c3                      ret
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 222 ++++++++++++++++++++++-
>>   1 file changed, 220 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> index b57951d8c997..4f467864ed09 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> @@ -383,15 +383,233 @@ static inline void 
>> amdgpu_ring_clear_ring(struct amdgpu_ring *ring)
>>       memset32(ring->ring, ring->funcs->nop, ring->buf_mask + 1);
>>   }
>> -static inline void amdgpu_ring_write(struct amdgpu_ring *ring, 
>> uint32_t v)
>> +static inline void
>> +amdgpu_ring_write1(struct amdgpu_ring *ring,
>> +           u32 v1)
>>   {
>> +    const u32 buf_mask = ring->buf_mask;
>>       u64 wptr = ring->wptr;
>> -    ring->ring[wptr++ & ring->buf_mask] = v;
>> +    ring->ring[wptr++ & buf_mask] = v1;
>>       ring->wptr = wptr & ring->ptr_mask;
>>       ring->count_dw--;
>>   }
>> +static inline void
>> +amdgpu_ring_write2(struct amdgpu_ring *ring,
>> +           u32 v1, u32 v2)
>> +{
>> +    const u32 buf_mask = ring->buf_mask;
>> +    u64 wptr = ring->wptr;
>> +    u32 *r = ring->ring;
>> +
>> +    r[wptr++ & buf_mask] = v1;
>> +    r[wptr++ & buf_mask] = v2;
>> +
>> +    ring->wptr = wptr & ring->ptr_mask;
>> +    ring->count_dw -= 2;
>> +}
>> +
>> +static inline void
>> +amdgpu_ring_write3(struct amdgpu_ring *ring,
>> +           u32 v1, u32 v2, u32 v3)
>> +{
>> +    const u32 buf_mask = ring->buf_mask;
>> +    u64 wptr = ring->wptr;
>> +    u32 *r = ring->ring;
>> +
>> +    r[wptr++ & buf_mask] = v1;
>> +    r[wptr++ & buf_mask] = v2;
>> +    r[wptr++ & buf_mask] = v3;
>> +
>> +    ring->wptr = wptr & ring->ptr_mask;
>> +    ring->count_dw -= 3;
>> +}
>> +
>> +static inline void
>> +amdgpu_ring_write4(struct amdgpu_ring *ring,
>> +           u32 v1, u32 v2, u32 v3, u32 v4)
>> +{
>> +    const u32 buf_mask = ring->buf_mask;
>> +    u64 wptr = ring->wptr;
>> +    u32 *r = ring->ring;
>> +
>> +    r[wptr++ & buf_mask] = v1;
>> +    r[wptr++ & buf_mask] = v2;
>> +    r[wptr++ & buf_mask] = v3;
>> +    r[wptr++ & buf_mask] = v4;
>> +
>> +    ring->wptr = wptr & ring->ptr_mask;
>> +    ring->count_dw -= 4;
>> +}
>> +
>> +static inline void
>> +amdgpu_ring_write5(struct amdgpu_ring *ring,
>> +           u32 v1, u32 v2, u32 v3, u32 v4, u32 v5)
>> +{
>> +    const u32 buf_mask = ring->buf_mask;
>> +    u64 wptr = ring->wptr;
>> +    u32 *r = ring->ring;
>> +
>> +    r[wptr++ & buf_mask] = v1;
>> +    r[wptr++ & buf_mask] = v2;
>> +    r[wptr++ & buf_mask] = v3;
>> +    r[wptr++ & buf_mask] = v4;
>> +    r[wptr++ & buf_mask] = v5;
>> +
>> +    ring->wptr = wptr & ring->ptr_mask;
>> +    ring->count_dw -= 5;
>> +}
>> +
>> +static inline void
>> +amdgpu_ring_write6(struct amdgpu_ring *ring,
>> +           u32 v1, u32 v2, u32 v3, u32 v4, u32 v5, u32 v6)
>> +{
>> +    const u32 buf_mask = ring->buf_mask;
>> +    u64 wptr = ring->wptr;
>> +    u32 *r = ring->ring;
>> +
>> +    r[wptr++ & buf_mask] = v1;
>> +    r[wptr++ & buf_mask] = v2;
>> +    r[wptr++ & buf_mask] = v3;
>> +    r[wptr++ & buf_mask] = v4;
>> +    r[wptr++ & buf_mask] = v5;
>> +    r[wptr++ & buf_mask] = v6;
>> +
>> +    ring->wptr = wptr & ring->ptr_mask;
>> +    ring->count_dw -= 6;
>> +}
>> +
>> +static inline void
>> +amdgpu_ring_write7(struct amdgpu_ring *ring,
>> +           u32 v1, u32 v2, u32 v3, u32 v4, u32 v5, u32 v6, u32 v7)
>> +{
>> +    const u32 buf_mask = ring->buf_mask;
>> +    u64 wptr = ring->wptr;
>> +    u32 *r = ring->ring;
>> +
>> +    r[wptr++ & buf_mask] = v1;
>> +    r[wptr++ & buf_mask] = v2;
>> +    r[wptr++ & buf_mask] = v3;
>> +    r[wptr++ & buf_mask] = v4;
>> +    r[wptr++ & buf_mask] = v5;
>> +    r[wptr++ & buf_mask] = v6;
>> +    r[wptr++ & buf_mask] = v7;
>> +
>> +    ring->wptr = wptr & ring->ptr_mask;
>> +    ring->count_dw -= 7;
>> +}
>> +
>> +static inline void
>> +amdgpu_ring_write8(struct amdgpu_ring *ring,
>> +           u32 v1, u32 v2, u32 v3, u32 v4, u32 v5, u32 v6, u32 v7,
>> +           u32 v8)
>> +{
>> +    const u32 buf_mask = ring->buf_mask;
>> +    u64 wptr = ring->wptr;
>> +    u32 *r = ring->ring;
>> +
>> +    r[wptr++ & buf_mask] = v1;
>> +    r[wptr++ & buf_mask] = v2;
>> +    r[wptr++ & buf_mask] = v3;
>> +    r[wptr++ & buf_mask] = v4;
>> +    r[wptr++ & buf_mask] = v5;
>> +    r[wptr++ & buf_mask] = v6;
>> +    r[wptr++ & buf_mask] = v7;
>> +    r[wptr++ & buf_mask] = v8;
>> +
>> +    ring->wptr = wptr & ring->ptr_mask;
>> +    ring->count_dw -= 8;
>> +}
>> +
>> +static inline void
>> +amdgpu_ring_write9(struct amdgpu_ring *ring,
>> +           u32 v1, u32 v2, u32 v3, u32 v4, u32 v5, u32 v6, u32 v7,
>> +           u32 v8, u32 v9)
>> +{
>> +    const u32 buf_mask = ring->buf_mask;
>> +    u64 wptr = ring->wptr;
>> +    u32 *r = ring->ring;
>> +
>> +    r[wptr++ & buf_mask] = v1;
>> +    r[wptr++ & buf_mask] = v2;
>> +    r[wptr++ & buf_mask] = v3;
>> +    r[wptr++ & buf_mask] = v4;
>> +    r[wptr++ & buf_mask] = v5;
>> +    r[wptr++ & buf_mask] = v6;
>> +    r[wptr++ & buf_mask] = v7;
>> +    r[wptr++ & buf_mask] = v8;
>> +    r[wptr++ & buf_mask] = v9;
>> +
>> +    ring->wptr = wptr & ring->ptr_mask;
>> +    ring->count_dw -= 9;
>> +}
>> +
>> +static inline void
>> +amdgpu_ring_write10(struct amdgpu_ring *ring,
>> +           u32 v1, u32 v2, u32 v3, u32 v4, u32 v5, u32 v6, u32 v7,
>> +           u32 v8, u32 v9, u32 v10)
>> +{
>> +    const u32 buf_mask = ring->buf_mask;
>> +    u64 wptr = ring->wptr;
>> +    u32 *r = ring->ring;
>> +
>> +    r[wptr++ & buf_mask] = v1;
>> +    r[wptr++ & buf_mask] = v2;
>> +    r[wptr++ & buf_mask] = v3;
>> +    r[wptr++ & buf_mask] = v4;
>> +    r[wptr++ & buf_mask] = v5;
>> +    r[wptr++ & buf_mask] = v6;
>> +    r[wptr++ & buf_mask] = v7;
>> +    r[wptr++ & buf_mask] = v8;
>> +    r[wptr++ & buf_mask] = v9;
>> +    r[wptr++ & buf_mask] = v10;
>> +
>> +    ring->wptr = wptr & ring->ptr_mask;
>> +    ring->count_dw -= 10;
>> +}
>> +
>> +static inline void
>> +amdgpu_ring_write11(struct amdgpu_ring *ring,
>> +           u32 v1, u32 v2, u32 v3, u32 v4, u32 v5, u32 v6, u32 v7,
>> +           u32 v8, u32 v9, u32 v10, u32 v11)
>> +{
>> +    const u32 buf_mask = ring->buf_mask;
>> +    u64 wptr = ring->wptr;
>> +    u32 *r = ring->ring;
>> +
>> +    r[wptr++ & buf_mask] = v1;
>> +    r[wptr++ & buf_mask] = v2;
>> +    r[wptr++ & buf_mask] = v3;
>> +    r[wptr++ & buf_mask] = v4;
>> +    r[wptr++ & buf_mask] = v5;
>> +    r[wptr++ & buf_mask] = v6;
>> +    r[wptr++ & buf_mask] = v7;
>> +    r[wptr++ & buf_mask] = v8;
>> +    r[wptr++ & buf_mask] = v9;
>> +    r[wptr++ & buf_mask] = v10;
>> +    r[wptr++ & buf_mask] = v11;
>> +
>> +    ring->wptr = wptr & ring->ptr_mask;
>> +    ring->count_dw -= 11;
>> +}
>> +
>> +#define AMDGPU_RING_WRITE(_1, _2, _3, _4, _5, _6, _7, _8, _9, _10, 
>> _11, _12, NAME, ...) NAME
>> +#define amdgpu_ring_write(...) \
>> +    AMDGPU_RING_WRITE(__VA_ARGS__, \
>> +              amdgpu_ring_write11, \
>> +              amdgpu_ring_write10, \
>> +              amdgpu_ring_write9, \
>> +              amdgpu_ring_write8, \
>> +              amdgpu_ring_write7, \
>> +              amdgpu_ring_write6, \
>> +              amdgpu_ring_write5, \
>> +              amdgpu_ring_write4, \
>> +              amdgpu_ring_write3, \
>> +              amdgpu_ring_write2, \
>> +              amdgpu_ring_write1, \
>> +              NULL)(__VA_ARGS__)
>> +
>>   static inline void amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
>>                             void *src, int count_dw)
>>   {
> 
