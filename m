Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C2C4F9D0CD
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 13:42:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BF6010E605;
	Tue, 14 Apr 2026 13:42:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="rQvmMCgr";
	dkim-atps=neutral
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C565010E605
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 13:42:48 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4fw57T2lcpz9sr7;
 Tue, 14 Apr 2026 15:42:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776174165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lyqtUuymzDFhIdD9TxUkl1mA0WskJ12shu7Apmv3HL4=;
 b=rQvmMCgrXKI7lmVmz3BtTcpVqCu9cwckEYGq9B8Aq4dQP53tSFEpaURnISMNefHKntq8AY
 UH4onfZYPz8DoBYlXjipy1U2DnU9p5fiYpDFvQV1NpDFU4OQL6Be9Vvl0YAVZjGihhp65j
 4lsdmkkLxWpl11U/KSDAK5srHmnZMSmV0gLmazwJKt5JnqEuq946NYvU0o0fTi/8Hg+L+v
 zdCEqM2cU9LMOI2SJCnhzInIPhwR+O3dzJqwixFvG/T2LEjd6LET0aL7N/Cqkuu7lGHfLS
 aw9OkH8aVsCd2E0Ak7YDou0rffSiH58AT4GOHjgkZXUvm+Wfb97jxDGqA1Ou2A==
Message-ID: <3e220f91-a89e-42fa-9186-c9658d41839b@mailbox.org>
Date: Tue, 14 Apr 2026 15:42:42 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] drm/amdgpu/userq: gnome shell uses max priority
To: "Khatri, Sunil" <sukhatri@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>,
 "Mohan Marimuthu, Yogesh" <yogesh.mohanmarimuthu@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260413084943.819126-1-sunil.khatri@amd.com>
 <5976d500-d768-4a63-8fbe-4e68e20fc0e6@amd.com>
 <4e862955-3437-40f4-bf04-2bdab7d84909@amd.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <4e862955-3437-40f4-bf04-2bdab7d84909@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 3kt4xtyo3t5a85gt9cikh9qq8qj3i3rp
X-MBO-RS-ID: 4ca052bfcd47c0e6cbe
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

On 4/13/26 11:24, Khatri, Sunil wrote:
> On 13-04-2026 02:32 pm, Christian König wrote:
>> On 4/13/26 10:49, Sunil Khatri wrote:
>>> In function amdgpu_userq_priority_permit allow till
>>> maximum priority i.e 3 which is seen for gnome shell.
>>>
>>> This is needed to fix the issue of unable to create queue
>>> for gnome shell.
>>>
>>> logs:
>>> [drm] *ERROR* comm: gnome-shell pid: 2802 client-id:10 client: Unset ... SK: Priority 3
>> Clear NAK, as far as I can see the existing code is correct.
>>
>> AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_HIGH is only allowed when you have CAP_SYS_NICE, e.g. you are root.
>>
>> That is also documented in the UAPI. Question is why is gnome shell trying to use that?
> I see, let me add Yogesh for his inputs, @yogesh, why gnome shell is asking for priority AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_HIGH. Based on the code seems mesa is getting a flag set flags & PIPE_CONTEXT_HIGH_PRIORITY -> this sets AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_HIGH for graphics queue.

For some background, mutter uses EGL_CONTEXT_PRIORITY_HIGH_IMG when EGL_IMG_context_priority is supported, to try and prevent its GPU work from getting starved by clients.

This works (or at least doesn't fail similarly) with kernel queues, presumably via DRM master status. I'd argue that should suffice with user queues as well.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
