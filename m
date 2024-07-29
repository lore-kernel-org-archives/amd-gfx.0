Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD62C3DA4A
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jul 2024 10:49:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E29610E38C;
	Mon, 29 Jul 2024 10:49:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="DBD8aStb";
	dkim-atps=neutral
X-Greylist: delayed 422 seconds by postgrey-1.36 at gabe;
 Mon, 29 Jul 2024 10:49:12 UTC
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A0A110E38C
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jul 2024 10:49:12 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4WXZg26C1zz9spm;
 Mon, 29 Jul 2024 12:42:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1722249726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S9SU7VXSqqyPsfu4yVvSEDtwwj3MzBkFc/q8re+PJqs=;
 b=DBD8aStb7yOsjSf3dZMg0MQ8BEEBBHjIiNDok5qtc2gJ3jLDJ6LR5tSLR/dHRO9V16sMIH
 I5ovVKhJbgeBk1pHnnMRSSieUBRAklOMR0jX4wwlOAEfDAFsJMIXLjC4SVqoK8jtGOimr/
 g5Dr2x+R3AAusFz5fCyFgsdfpj79mQlYZwSaNmN3upAqM/oHi350V2YMlJSr9hp+rA+eY5
 C7tbWM8enspUOmtjNxKMpIQIjdOdDCdT6HW5SXjhe72lJFO0Qx1EaOaozXBta5JSkvQcBD
 G+1oZyJ87i+4FYn7sMlk+DU4umN2nWG5fdHYGj6Oov3suxw9pBlf0o9eQMFWyQ==
Message-ID: <efd8495a-d869-4314-acfb-d3e704c68cda@mailbox.org>
Date: Mon, 29 Jul 2024 12:42:05 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] drm/amdgpu: always allocate cleared VRAM for GEM
 allocations
To: Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240726134115.36802-1-alexander.deucher@amd.com>
 <CADnq5_PGaR=0bqmXckwY8HpgCj5MxCJ4Qc1JP=QR9Lnb7AES6w@mail.gmail.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <CADnq5_PGaR=0bqmXckwY8HpgCj5MxCJ4Qc1JP=QR9Lnb7AES6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 5e4201341fc00b2e31b
X-MBO-RS-META: gpsekkm837axao9e1sd8kguuujhfkg7h
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

On 2024-07-26 17:25, Alex Deucher wrote:
> On Fri, Jul 26, 2024 at 9:50 AM Alex Deucher <alexander.deucher@amd.com> wrote:
>>
>> This adds allocation latency, but aligns better with user
>> expectations.  The latency should improve with the drm buddy
>> clearing patches that Arun has been working on.
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> index ebb3f87ef4f6..768840e8937d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> @@ -347,6 +347,10 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>>                 return -EINVAL;
>>         }
>>
>> +       /* always clear VRAM */
>> +       if (args->in.domains & AMDGPU_GEM_DOMAIN_VRAM)
>> +               flags |= AMDGPU_GEM_CREATE_VRAM_CLEARED;
> 
> Alternatively, we can set AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE here,
> although for cases like reboots, we probably want clear on create.

I agree. Thanks for doing this!

Reviewed-by: Michel Dänzer <mdaenzer@redhat.com>


BTW, maybe this allows reducing the use of AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE, or even eliminating it altogether? Does this leave any way for user space to access uncleared VRAM?


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

