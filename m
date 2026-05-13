Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF4ECD37AC
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 22:12:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D263610E0DB;
	Wed, 13 May 2026 22:12:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hOertfqE";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B3E910E0DB
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 22:12:32 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so81522115e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 15:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778710350; x=1779315150; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wMLhz4vKJGhRTzqh3lsB2jnpEbnY8ZQgpm6JsE7u/P4=;
 b=hOertfqEkCLbLQqmmnU/9Ql28s1SljUmpoPEYsd6VdXRP79+ru24OwHxC8utuYnwhD
 YCZsnHHu26dd/Qi7Umw3QbFr5NRVpEg84NQomOpC0WeBFxIjqHUcmHRTWf+5JetQsLL7
 q6ocHTClXhKFJ5ikhHKVanFurMgtdSJCXZMCVVvcPn8msI3gr2dnZBJxEQTGX5qYIFyw
 Nszj6O6zuBA3mWVJHnNC01ps73ncHES6cqsXbeCNEj46lmNVX3+UKs3Fg9xzIPwKA8VO
 DVbKlzcT6q7YLsUXwUcmOjzQ5wEsyz5tEAt7aA5/h9moviY2CZeu1mp6OUT70uxHMeJm
 zHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778710350; x=1779315150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wMLhz4vKJGhRTzqh3lsB2jnpEbnY8ZQgpm6JsE7u/P4=;
 b=Drl/9EvwQLZnYUDJMu86DnAwbSPtkj3SFnIqIbnlK3g/ofY9RNqB5YyqJh5TIBPyCm
 20GFLp1zcByBgtGHV9LpQRqYQszJSqQuNRcN0+VNrqn3fErZIMpCNtW3w5szIYOqO2Bw
 PUFUimHKNevPnL4TMO1QyFIQUdQToTb1cMlZ77h6rcdr2j94Fdv0qzi5oqSRriGCuDKi
 AQ85p0oob2dlEslWkENr9aQo1mk66fS/XCiRg519+qOlg87avGsuxw1sr1Z3IviGPA0L
 n66LXs2p4rn0OGpo3Mm/UsObOqkzBXQ28gjrpG1cmS85zTiRV4DxV6MfMh0oOXnhEbrh
 QYHQ==
X-Gm-Message-State: AOJu0YxOgS6gUoGNb619cYU6R03Q4BbxqR9mylzMfTJrZrIDEZ4qeWl/
 EAzk1/jlbAc4uxxr1zFfnz00lIqKHFE0wo1OtlH8jyfSp/gpOK9uGb5W
X-Gm-Gg: Acq92OFLkR9siADsp3FpZBJRDMi/Tn+NA6ieBPt5s0g8/hnSqzU2gxqkzhcJY86apV3
 uiUgQAQmmR8Oe6oixMBQxhRw2Ii0TQZ90puXWN+yCbAo94VKmzTaNjN6HH6ivWbcEO5HjqV/j9A
 5MKoHBIPaGSjw4EUy7XyWT0V560BbpvnJIVa/4kTSWNc22RVMk2FHflg+I9r7UeLtupUTmSUKrc
 vzqIKZRFdXliCbkiBdytm0Qiu14+8q3laoMBDHSurZfA932mTPMdpd1pm1hVtHt+5JDOAbNyxY2
 3uhKSX6oRea/GX0oetmJlPUunUheZ2f9LHXaFm91+/vf/THM/65k7b/HF2UqJwvs5cW4ZPOOoC9
 4OA6z0R8hVBZhavxMWIlkcoby4tX0FQEUOP3El6sfY7C+NF4r184uyhtXZtQ35cCJz2GwHF6/bT
 TJt6xCX8toOSUECNI/gkLURDchsz3/WBFfd0TCNa2dqx2koO+d8qSZCgL5JIr1rA2S6NCEIGIET
 dhhhh0I
X-Received: by 2002:a05:600c:4e0d:b0:48a:5c23:cab with SMTP id
 5b1f17b1804b1-48fc9a3abb0mr78314095e9.19.1778710349941; 
 Wed, 13 May 2026 15:12:29 -0700 (PDT)
Received: from timur-hyperion.localnet (540017BE.dsl.pool.telekom.hu.
 [84.0.23.190]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a17ec2sm1608987f8f.24.2026.05.13.15.12.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 15:12:29 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>,
 "Shetaia, Amir" <Amir.Shetaia@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 Marek =?UTF-8?B?T2zFocOhaw==?= <maraeo@gmail.com>,
 Natalie Vock <natalie.vock@gmx.de>, Melissa Wen <mwen@igalia.com>
Subject: Re: [PATCH 0/6] drm/amdgpu: Improve retry fault handling
Date: Thu, 14 May 2026 00:12:28 +0200
Message-ID: <4570266.UPlyArG6xL@timur-hyperion>
In-Reply-To: <PH8PR12MB6889FE1792A871E69F2F588C87062@PH8PR12MB6889.namprd12.prod.outlook.com>
References: <20260513163043.8725-1-timur.kristof@gmail.com>
 <10056920.eNJFYEL58v@timur-hyperion>
 <PH8PR12MB6889FE1792A871E69F2F588C87062@PH8PR12MB6889.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

Hi Amir,

> Timur, you are right, I see your patch 6 already does the MMIO ACK for
> gmc_v11_0/ih_v6_0. I missed that. The gap is only in patch 5's ih_v7_0
> implementation, which still does WDOORBELL. that's where I'd suggest
> swapping in MMIO for NV4.

First, let me clear up a slight misunderstanding here. The patch series that I 
sent here only contains what I managed to get working on Navi 31, it does not 
contain any code from my attempt at Navi 48.

The patch 5 is just a slight refactor of the pre-existing code and 
(intentionally) doesn't contain any functional changes. It seems that IH 7.1 
relies on the doorbell, so I didn't want to remove it, albeit I have no means 
to verify if that actually works or not.

If you like, I can push a few WIP patches to a different branch tomorrow to 
show you exactly what I did on Navi 48. However, I wouldn't want to submit 
that to the mailing list without first making sure that it works well.
 
> 1. "Fault never resolves on NV48" different shape from our broken-CAM-ACK
> symptom.
 
> You're right, those are different. Our cam-walk-monotonically symptom only
> shows up when CAM is enabled but the ACK is broken.
 > On your NV48 setup CAM
> probably isn't enabled at all (your patch 6 only enables it for
> ih_v6_0_irq_init, no equivalent in ih_v7_0_irq_init)

For the attempt on Navi 48, I enabled the CAM in ih_v7_0 the same way I do for 
ih_v6_0 in the series. But, because I couldn't get it fully working, I didn't 
include any of that code in the series.

> so retries fire
> repeatedly on the IH ring instead of being deduped by CAM. That matches
> what you're seeing .. amdgpu_vm_handle_fault keeps being called but each
> call is on a fresh IRQ for the same address. 
> Two things that could be happening underneath:
> - The fault handler runs but the updated PTE never reaches UTC L0 (TLB
> invalidation gap). On NV4 we see this as "valid PTEs failing to translate"
> in our UMR captures.

I think this explanation may fit what I saw.
Why is it not reaching UTC L0?
Also, how do you inspect this stuff in umr?

> 2. What bits we check on src_data[2]:
> 
> Honestly, we don't use src_data[2] for retry detection. We use it only for
> the cam_index: cam_index = entry->src_data[2] & 0x3ff;   /* low 10 bits =
> CAM slot */
 
> For retry detection we initially used the gfx9 constant on src_data[1] like
> you, but observed the bit cleared on a lot of NV4 events that should have
> been retries (waves were hung in xnack-stall but no IH event matched).
> So
> we just go through the retry path unconditionally on NV4

I see. I think I needed to change some gfxhub registers to get those src_data 
bits that you are missing.

> and let
> amdgpu_vm_handle_fault sort it out via SVM range migration. May be specific
> to gfx1201 / our test path 

My test case is a simple Vulkan shader which I am executing with vkrunner. 
Each shader invocation does an out of bounds read from a different page. For 
Navi 31 (and Strix Halo), I started out with just 1 page fault, and once I 
could mitigate that reliably, I turned it up to several hundred faults.

> 3. TLB flush making it worse .. clue about what to do:
> 
> Honest answer: not really, not a SW-only fix. Our 1 GiB hang is an
> architectural deadlock ... ih_soft_work blocks on a dma_fence for an SDMA
> BO-clear, the BO-clear is stalled on a GCR (cache flush) request,
> and the
> GC cache block isn't ACK'ing the GCR while UTC L2 is saturated by the user
> shader's XNACK retry storm. Adding a TLB flush adds another translation
> request to the same saturated UTC, which is why it makes things worse.

This may be related to a flaw in amdgpu_gmc_handle_retry_fault():
what the function does is first call amdgpu_vm_handle_fault() which kicks off an 
SDMA job to update page tables, and then it ACKs the filter CAM. However, at 
the moment when the CAM is ACKed, the SDMA job is not finished yet, so the CP 
sees that the page is still invalid and the page fault interrupt is fired 
again. I actually noticed that on Navi 31 too, but it's just not fatal there. 
It just basically handles the same page fault twice. Once we solve this flaw, I 
would like to propose to enable retry faults by default on Navi 3.

Here is an idea for a solution:

Instead of ACKing the CAM right away, we should do it after the SDMA fence is 
signalled, ie. when we are sure the page tables are updated. Maybe we can set 
a callback on the fence and do it there, though it would require a slight code 
churn to get that to work.

What do you think?

> 4. IH1 ring on NV4:
> 
> Same as you ... retry faults on NV4 always come in on IH0. We delegate from
> IH0 to ih.ring_soft (amdgpu_irq_delegate(adev, entry, 8)) so the
> SVM/migration path can sleep, but the original entry is on IH0. We haven't
> tried IH1 routing.

Why, though? 

The ih_v7_0 code does set up the IH1 ring and configure it exactly the same as 
the ih_v6_0, so I don't see why it wouldn't work?
 
> Re your branch: thanks for the gitlab link, easier than digging through
> patchwork.
> I'll cherry-pick patches 1, 3, 4 into our test build to see if
> patch 4 cleans up the timestamp filter delta we're seeing (97k entered /
> 2.8k completed at 1 GiB might be partly explained by your Strix Halo bug). 

The timestamp issue actually gave me an endless headache when I first got into 
this topic in December. I hope the patch helps!

Best regards,
Timur


