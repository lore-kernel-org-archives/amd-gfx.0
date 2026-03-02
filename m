Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D80D58E7A
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2026 08:53:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56D4810E45F;
	Mon,  2 Mar 2026 08:53:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="DKvGHwPf";
	dkim-atps=neutral
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A95D10E45F
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2026 08:53:15 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4fPXlC2Rzcz9tt0;
 Mon,  2 Mar 2026 09:53:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1772441591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gZefzYjkBmHWRAlbhRCEfYn0dyKO6XNzBN5u4MIBYJM=;
 b=DKvGHwPfy2XtJd3vE4pfGX621UDb3DeQPnXXtjM/5QYDSNTzfRbqHGpMkEulJ6szAPWy4G
 3V5i0m+9F6pjl2fcfE/ykQysGMi8BrZw8s0P//EVzJGKye+cxVD4r6DgnhfHg7LCht+e7d
 ID5BYCA9+7IHRSTfRxHOKLyoPbajr0O5JJzR4ToOtW8+5Ih1T9H/56WjjMiABM7xAQrGZg
 N1oqzZwq0bbGrMMBNWlVXXLG0fo9gquNHzh4nt4rki5qKwjXmK4JyAC3JwPrnhpJHEAzCa
 2rHeQjCp6kkhDoZCI/b1EUy2KmdcjZMqBVnQ0AXRofPhVmHNyL33AG9ELqUOLA==
Message-ID: <965e25c6-f34e-4fa5-a014-03776cea6b28@mailbox.org>
Date: Mon, 2 Mar 2026 09:53:08 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] drm/amd/display: complete cursor vblank events
 immediately
To: Leo Li <sunpeng.li@amd.com>, Michele Palazzi <sysdadmin@m1k.cloud>,
 amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com
References: <20260217191632.1243826-1-sysdadmin@m1k.cloud>
 <f43075c8-e5f1-426c-b70e-743d1e7e4c59@amd.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <f43075c8-e5f1-426c-b70e-743d1e7e4c59@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 657fb1504055f8ece40
X-MBO-RS-META: k83594ouab7qixbjadnbfd894gjyr4yb
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

On 2/23/26 16:27, Leo Li wrote:
> 
> Ideally, the cursor event should be delivered when hardware latches onto the new
> cursor info and starts scanning it out. The latching event fires an interrupt
> that should be handled by dm_crtc_high_irq().
> 
> dm_pflip_high_irq() handles an interrupt specifically for when hardware latches
> onto a new fb address; I don't think it actually fires when there's a
> cursor-only update. I think if we really want to do it right, we can have
> another "acrtc_attach->cursor_event" just for cusror-only updates, and deliver
> the event in crtc_high_irq().
> 
> In any case, I don't foresee any major issues with delivering the event early.

If the event having wrong sequence & timestamp values isn't considered a "major issue", we might as well not bother and just put random values in there. ;)

Compositors actually make use of the timestamp for frame scheduling.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
