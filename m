Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE9FCD128A
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Apr 2024 16:47:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C7EF1127B5;
	Wed,  3 Apr 2024 16:47:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="dtOYGjCV";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56A8D112D62
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Apr 2024 16:47:19 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4V8rJL72BBz9tMh;
 Wed,  3 Apr 2024 18:47:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1712162835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eaJO93fX0gam8b79g/8gNXLIn7MQPW1h6WaGvtVcLvk=;
 b=dtOYGjCVnw+KDwhThSGW8egi+ISBJm5Ej2mftWgcv2kq3EqXk2uKFcVBaBQzxY35nk8eQd
 cfz8q9qJrDb6yRoJOeOcREZ/lXln0UQzvaw2oUCIiyuEAL4B4bXRzWFYp27SDsCb7Kz8o2
 dw78w/fZZOjgb4YwYWIsmwYydkcBLhrWf43EH4yoyZcx4iK14txrxgyqXDJ825C4Ygh+TY
 HlORRXvMERzn7GsyAIe88Nek6NyBZN5Bu9XRE7jb1lmtIXvzJiJmKUJKoN0RTrMxudM28y
 jPa6zpNKglW00MoAQeedhixwZylyub9zjnAwkcnk/bICzhcvI2ltHb4tAfp5+Q==
Message-ID: <12449e7f-9557-4391-ae7b-e3299393fc0c@mailbox.org>
Date: Wed, 3 Apr 2024 18:47:13 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] drm/amdgpu: always allocate cleared VRAM for KFD
 allocations
To: Felix Kuehling <felix.kuehling@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20240326155203.5246-1-alexander.deucher@amd.com>
 <7e15b576-6ece-480e-86dd-ab5e4fbfc5db@amd.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: de-CH-frami, en-CA
Cc: amd-gfx@lists.freedesktop.org
In-Reply-To: <7e15b576-6ece-480e-86dd-ab5e4fbfc5db@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: a4e504d414e7ca6f81b
X-MBO-RS-META: r6hpxfptkxff6akp868i9w6zac8eu6o4
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

On 2024-03-26 19:21, Felix Kuehling wrote:
> 
> On 2024-03-26 11:52, Alex Deucher wrote:
>> This adds allocation latency, but aligns better with user
>> expectations.  The latency should improve with the drm buddy
>> clearing patches that Arun has been working on.
> 
> If we submit this before the clear-page-tracking patches are in, this will cause unacceptable performance regressions for ROCm applications.

I agree this probably shouldn't land earlier than that, ideally together or shortly after though.


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

