Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E72EC3DA61
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jul 2024 11:14:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C196E10E387;
	Mon, 29 Jul 2024 11:14:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LLyJknT2";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69A7E10E387
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jul 2024 11:14:14 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4281e3b2f72so5308585e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jul 2024 04:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722251653; x=1722856453; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bMchZ68G/L3beXy+mww0qdNYcVpHBknfnoEkPRfYH08=;
 b=LLyJknT236Y9BNkONOGVq/rh3baVMLBTsxO9HSnm5SGh6GsvhrFcM0iWXI1NpH1cWD
 Bm7O7WOf4IZqRym+sQppIPK+z3f1b0ttthvEzddlc79iBgwmLgDLd4IRlzxkCS4GENxL
 SOkYyyF60/UGiNL7yjjfxBZDmPNeLVf+nuU5vXWElMrqKGJwDuWhx1tjO51hbQsHnH1E
 YhRNVSLK3A/amDYTIPsD33qHKTaB8s2OnyB9+dQ+CI3b33dbhcYn6tvKnVcVVz2Ga88P
 oJh2OFr3lXn5kq0OjzU2W+lR+KFwb5ldpOHgic/9TOFIpmhKXrh38f0lQnDwHyv/UaNu
 SOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722251653; x=1722856453;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bMchZ68G/L3beXy+mww0qdNYcVpHBknfnoEkPRfYH08=;
 b=fxpOJwUJ7yGJ/RLLJyR8XlBBhQ1MPQCBwooKe0QjUu5CMOxDYELiFJwmYqqP2rXSHq
 WWLd/rhcSz44rTCFd/r6kJc5k5EcwVYHTJ/49kJnwdb2wFhE5Oclit0E00gvj+UC6inh
 LjP/RwDgsEGm50dYahZJuleZqcqbclXhlEFsbw6aFRhpwZdpjR8utBaXGwNwR00kM/1k
 mqWWicWG01UzdSeWhbUfTDbX2acnFqNBtInojq7myPaWSYv2HUQqDIBOGJNcrMlCyC6X
 nPIP6IzWHgn6SHkWEIMyEKNLH+FPiEEbWFHBDmHANap6aWpZKGXYF1SYIVs15FFLIRXX
 mW9g==
X-Gm-Message-State: AOJu0Yzq2Bp5ciWLd/OqMoZ3epzQqJUq4vF1PrWCO63Qi2rjE1RbJ0l9
 670QTcRc4MAd0zeIyA0krauBsQGeqQ996+giiklwD5PSBDm/L0MF
X-Google-Smtp-Source: AGHT+IH5eNLmWI9/YLXDYp849FqNoUfCk1pfiKd3EpdtcPbPQNYQKHTwfS4ZcoWdu6aPDZ1Alz+OXw==
X-Received: by 2002:a05:600c:35d6:b0:426:5216:3247 with SMTP id
 5b1f17b1804b1-42811d73ab3mr51948795e9.6.1722251652168; 
 Mon, 29 Jul 2024 04:14:12 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4281c3cc71fsm42912065e9.39.2024.07.29.04.14.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 04:14:11 -0700 (PDT)
Message-ID: <654328ee-5bdb-4de1-853f-55360e6ff39f@gmail.com>
Date: Mon, 29 Jul 2024 13:14:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: always allocate cleared VRAM for GEM
 allocations
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240726134115.36802-1-alexander.deucher@amd.com>
 <CADnq5_PGaR=0bqmXckwY8HpgCj5MxCJ4Qc1JP=QR9Lnb7AES6w@mail.gmail.com>
 <efd8495a-d869-4314-acfb-d3e704c68cda@mailbox.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <efd8495a-d869-4314-acfb-d3e704c68cda@mailbox.org>
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

Am 29.07.24 um 12:42 schrieb Michel Dänzer:
> On 2024-07-26 17:25, Alex Deucher wrote:
>> On Fri, Jul 26, 2024 at 9:50 AM Alex Deucher <alexander.deucher@amd.com> wrote:
>>> This adds allocation latency, but aligns better with user
>>> expectations.  The latency should improve with the drm buddy
>>> clearing patches that Arun has been working on.
>>>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> index ebb3f87ef4f6..768840e8937d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> @@ -347,6 +347,10 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>>>                  return -EINVAL;
>>>          }
>>>
>>> +       /* always clear VRAM */
>>> +       if (args->in.domains & AMDGPU_GEM_DOMAIN_VRAM)
>>> +               flags |= AMDGPU_GEM_CREATE_VRAM_CLEARED;
>> Alternatively, we can set AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE here,
>> although for cases like reboots, we probably want clear on create.
> I agree. Thanks for doing this!

I strongly disagree. We have use cases were this will immediately become 
a problem.

Especially we won't be able to hold latency requirements on boot for 
certain projects any more.

Regards,
Christian.

>
> Reviewed-by: Michel Dänzer <mdaenzer@redhat.com>
>
>
> BTW, maybe this allows reducing the use of AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE, or even eliminating it altogether? Does this leave any way for user space to access uncleared VRAM?
>
>

