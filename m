Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A12B2C3DA61
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jul 2024 15:41:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 381F610E37D;
	Mon, 29 Jul 2024 15:41:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="eskZPAJJ";
	dkim-atps=neutral
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6F7B10E37D
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jul 2024 15:41:07 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WXjJ003f5z9ssX;
 Mon, 29 Jul 2024 17:41:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1722267664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5fNbMGyRzYh9EgPVD+1ShAZVKsHd8Xe56ahC8vzxas4=;
 b=eskZPAJJp0RXsuJh3n+tLBLrFMSghmu2Zl5MpmmUld7RBhybG0jvRHcDJho/iCCxDFay6y
 HJrxku9Nc0zKXCayej0Hv3VlcPig9Omaz8SmiHo/+udkDocPSysYiya6vcBhnzMwGvpwHH
 45b0TOsJLMHxNhGUntOZLjTVV1ufQ54DXnqE6zh/dnwDAY4ph4dSA/lcjQZW+A1vQsrrPZ
 5QK7giOwP9b5B/xJJQAlCVjMf7BOnTSqx08bezBMsya3LzCqVj1ux6ly/N+8Y6CjwF55kt
 Wvz7UOijR9wBg4vBYnek+vgYqN3j5F4+5RRFIkKh+tzWlBSi9Wc1qeQqFHrrQg==
Message-ID: <9bee645a-cae1-42b8-b5b6-8b2166f7ea0c@mailbox.org>
Date: Mon, 29 Jul 2024 17:41:02 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] drm/amdgpu: always allocate cleared VRAM for GEM
 allocations
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240726134115.36802-1-alexander.deucher@amd.com>
 <CADnq5_PGaR=0bqmXckwY8HpgCj5MxCJ4Qc1JP=QR9Lnb7AES6w@mail.gmail.com>
 <efd8495a-d869-4314-acfb-d3e704c68cda@mailbox.org>
 <654328ee-5bdb-4de1-853f-55360e6ff39f@gmail.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA, de-CH-frami
In-Reply-To: <654328ee-5bdb-4de1-853f-55360e6ff39f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: d75434effa2b654656a
X-MBO-RS-META: 9bczzb7yrsufqp47w1qatopgobkxgg6f
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

On 2024-07-29 13:14, Christian König wrote:
> Am 29.07.24 um 12:42 schrieb Michel Dänzer:
>> On 2024-07-26 17:25, Alex Deucher wrote:
>>> On Fri, Jul 26, 2024 at 9:50 AM Alex Deucher <alexander.deucher@amd.com> wrote:
>>>> This adds allocation latency, but aligns better with user
>>>> expectations.  The latency should improve with the drm buddy
>>>> clearing patches that Arun has been working on.
>>>>
>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 4 ++++
>>>>   1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>>> index ebb3f87ef4f6..768840e8937d 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>>> @@ -347,6 +347,10 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>>>>                  return -EINVAL;
>>>>          }
>>>>
>>>> +       /* always clear VRAM */
>>>> +       if (args->in.domains & AMDGPU_GEM_DOMAIN_VRAM)
>>>> +               flags |= AMDGPU_GEM_CREATE_VRAM_CLEARED;
>>> Alternatively, we can set AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE here,
>>> although for cases like reboots, we probably want clear on create.
>> I agree. Thanks for doing this!
> 
> I strongly disagree. We have use cases were this will immediately become a problem.
> 
> Especially we won't be able to hold latency requirements on boot for certain projects any more.

Then it was only possible to achieve them by essentially cheating, leaking uncleared VRAM contents to user space.

If that's acceptable for those use cases, you could maybe add some kind of opt-in mechanism for them.


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

