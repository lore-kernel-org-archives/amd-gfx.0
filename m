Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE891061B13
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2026 16:07:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65C9910E15F;
	Mon, 30 Mar 2026 16:07:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="MZnLRU2b";
	dkim-atps=neutral
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4CFE10E15F
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2026 16:07:29 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fkx3L22FFz9tdq;
 Mon, 30 Mar 2026 18:07:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774886846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nhuanttx5RU8PENCxZU2Scn/6ACgmydlS6rO4D0Bmog=;
 b=MZnLRU2ba+YLERh4dBS4OzlnkSArx5A5QIbkS6NN3oym3lmtx1bYnP80g3xWQdNs0dH3G/
 WPalSY1b/mMeKsCOtK90ELJST6hpWgEmnrjSqiYtiKMGebPTAYCEN1POEUq88bVCeCKwKP
 18iBPo41WRiQsjMoWzkQlbj7N2+gd78ZSDp+jUcFpoZfah64sa2JScNKUwjcqbUqIqXq/n
 Q0av7vP/SFalaGOAw/C9Sij6H1VAjIneIO0KqOKH8BB6nKi/opuitk5Ju/wM67JC1Z6B+L
 1SU+xp55y/pC2xAyJqubAuvPM6qqfdo9RTmIPSPlD0WqGbf+tAQbAtiZm2kE6g==
Message-ID: <a7fa1371-f530-463e-b7d1-7b8f989b5ca9@mailbox.org>
Date: Mon, 30 Mar 2026 18:07:22 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] drm/amd/display: Dither when plane bpc is higher than
 output bpc
To: Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
Cc: "Kovac, Krunoslav" <Krunoslav.Kovac@amd.com>,
 "Hung, Alex" <Alex.Hung@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Mario Kleiner <mario.kleiner.de@gmail.com>
References: <CAEsyxyiCN6KmyDBGZBJYKv+wt6w6j5QdUfTa1zJojAQ20V84xg@mail.gmail.com>
 <20260324210447.541630-2-harry.wentland@amd.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <20260324210447.541630-2-harry.wentland@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 69u1tbqfx94h4dkm49xzasbkzh4kny53
X-MBO-RS-ID: 933e828e984924a49ad
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

On 3/24/26 22:04, Harry Wentland wrote:
> We don't want to dither when a 10bpc buffer is output on a 10bpc
> connection as we'd get off-by-one errors. But we do want to dither
> if we have planes with a higher bit depth.
> 
> In order to solve this, look at all planes, and pick TRUN dither
> when input bit depth doesn't exceed output bit depth, otherwise
> pick SPATIAL.

This mixes up the framebuffer format and the bpc of the display HW colour pipeline output, which aren't directly related.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
