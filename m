Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B021CC55190
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Feb 2026 11:10:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B2A410E7B8;
	Fri, 20 Feb 2026 11:10:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=m1k.cloud header.i=@m1k.cloud header.b="RnG+c/tT";
	dkim-atps=neutral
Received: from mail.m1k.cloud (mail.m1k.cloud [195.231.66.115])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6B6D10E7B8
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Feb 2026 11:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=m1k.cloud; s=mail;
 t=1771585841; bh=asfgtfKfQeVveokKthwyiOEzF4/2GzTrIvHaLs2LsTg=;
 h=Subject:To:Cc:References:From:In-Reply-To;
 b=RnG+c/tTCL0oGucwErQPwyJRFIlK26QzIvm1WM0gEuJbqo23698YXW9k3vFxr2qdm
 8flbTInr29E/4y9DWU6i575/RgU5Bq7/+5NeIYDUaaXDcH2X+kCCFPEm6g8n53Zi84
 OAh0opqWggCe0xkQnkEcJG4zDVUH52R/qu9CjiaYq5fVl5MtOsL2V8ApnpN6JguxkP
 PgAw2sBHQ+QoB/236fZYyCn0LYEWcLYGTLte6dSBdTdfYbzph/8FYhq8Dc5mLUHHdZ
 INou4ecBQ4zM7novcQTMe/wrVpB4Ea7G4rLgk5u/fo8UM84tjC6Tis7yoGW+4OAgds
 bQP+iPbjEsxCw==
Message-ID: <0e416077-3443-4985-8988-496524958ebb@m1k.cloud>
Date: Fri, 20 Feb 2026 12:10:41 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] drm/amd/display: complete cursor vblank events
 immediately
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Cc: harry.wentland@amd.com, siqueira@igalia.com, alexander.deucher@amd.com,
 sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org
References: <20260218003104.1256473-1-sysdadmin@m1k.cloud>
 <02cb98e2-5666-45ca-be15-93c93f517238@mailbox.org>
 <44af0f28-8731-4c54-8bf6-0e844eb14b14@m1k.cloud>
 <d2d820a1-0320-4047-8837-2fed0186f4cf@mailbox.org>
 <001df5d5-4602-47f6-9d04-5c94f83d40d0@m1k.cloud>
 <43954b65-db3c-4f6b-837f-e025ac84788f@mailbox.org>
 <6b91ca71-40fe-4be3-b007-cda351580d39@m1k.cloud>
 <9ffdc1e3-cf1a-424f-b7b0-6e7a5da49120@mailbox.org>
Content-Language: en-US
From: Michele Palazzi <sysdadmin@m1k.cloud>
In-Reply-To: <9ffdc1e3-cf1a-424f-b7b0-6e7a5da49120@mailbox.org>
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

On 2/19/26 17:02, Michel Dänzer wrote:
> "If vblank is disabled by the off-delay timer before the handler runs, the PENDING cursor event is never delivered" indicates otherwise. If the handling was correct, the vblank interrupt should never be disabled before the handler runs.

You are correct again, calling drm_crtc_vblank_get() ensures the 
off-delay timer cannot disable the interrupt before handler runs.
I will add a fallback to check if it fails and send the event 
immediately only in that case, this would prevent hangs for disabled crtcs.

> Maybe? If the vblank event handler never needs to send an event for a flip.

This point would be covered with a dedicated cursor_event, the vblank 
handler only touches cursor_event, never acrtc->event. So the condition 
is met.
Unless advised against it I will be moving in this direction testing 
this approach, and if nothing unforeseen arises send a v2 when ready.
Thanks for the guidance.
