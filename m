Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B2F5E9A04A
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Feb 2026 16:02:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24C5B10E0E0;
	Thu, 19 Feb 2026 16:02:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="dPh4NmJ0";
	dkim-atps=neutral
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DBE210E0E0
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Feb 2026 16:02:23 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fGynR5wRgz9txP;
 Thu, 19 Feb 2026 17:02:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1771516939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A9zI4MhW+vbYKOti1ybLjgsxyt5Jhv1d6QiLp9yx6fQ=;
 b=dPh4NmJ0oxKZ/bRflsxa4PV44mMoHE/pJ0J7lUk6lijzo4qjMc3Rx+9+TmUFrVa/fNrlVs
 aTehPv7nQrdUtYxGFW7o3t4CZCAiOG+fnIRBHZO+xQ80xTLskF0TjK6K2Ucq+4b/btjDKs
 KrmOYpbivB3m3+NVmSooBDl85LRN7zUyEVTN7GEq2+TLQPscuvEctTZwuSf9f+IhaBwkaQ
 08u3+wbQ1JCTHZV+sw6tWXdZYoNXqqLf7XtXbe3ysasWWxi1uNIe/OM9riW21H2LZmHzkd
 eU7jSnavefZULweq3UGxGhHBmbK5N4FQNpPZEPdx1duY6A2KiiKiaqkeN0PIKg==
Message-ID: <9ffdc1e3-cf1a-424f-b7b0-6e7a5da49120@mailbox.org>
Date: Thu, 19 Feb 2026 17:02:16 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] drm/amd/display: complete cursor vblank events
 immediately
To: Michele Palazzi <sysdadmin@m1k.cloud>
Cc: harry.wentland@amd.com, siqueira@igalia.com, alexander.deucher@amd.com,
 sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org
References: <20260218003104.1256473-1-sysdadmin@m1k.cloud>
 <02cb98e2-5666-45ca-be15-93c93f517238@mailbox.org>
 <44af0f28-8731-4c54-8bf6-0e844eb14b14@m1k.cloud>
 <d2d820a1-0320-4047-8837-2fed0186f4cf@mailbox.org>
 <001df5d5-4602-47f6-9d04-5c94f83d40d0@m1k.cloud>
 <43954b65-db3c-4f6b-837f-e025ac84788f@mailbox.org>
 <6b91ca71-40fe-4be3-b007-cda351580d39@m1k.cloud>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <6b91ca71-40fe-4be3-b007-cda351580d39@m1k.cloud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: o1coa1t9jie3i6b46w6abypizpcakitx
X-MBO-RS-ID: 375e2e3c65ab270d410
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

On 2/19/26 16:56, Michele Palazzi wrote:
> On 2/19/26 14:59, Michel Dänzer wrote:
>> Can't the issue be solved by fixing the pflip_status handling in the vblank handler?
>> I guess that might also hit the second race condition:
>>
>>> - If vblank is disabled by the off-delay timer before the handler
>>>    runs, the PENDING cursor event is never delivered and the commit hangs.
>>
>> That sounds like the drm_crtc_vblank_get/put handling might be incorrect in amdgpu_dm.
>>
>> In a nutshell, the vblank interrupt is kept enabled as long as there have been more
>> drm_crtc_vblank_get calls than _put ones for the CRTC. I.e. amdgpu_dm needs to call the former under circumstances where it needs the interrupt to be on, and the latter only once it's no longer needed for those circumstances (in this case when sending the event).
> 
> The get/put pairing seems correct,

"If vblank is disabled by the off-delay timer before the handler runs, the PENDING cursor event is never delivered" indicates otherwise. If the handling was correct, the vblank interrupt should never be disabled before the handler runs.


> the issue is that cursor and pflip share the same acrtc->event slot, so the pflip_status check in the vblank handler can race. Adding a dedicated cursor_event field, separate from event used by pflip, could maybe solve the whole thing?

Maybe? If the vblank event handler never needs to send an event for a flip.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
