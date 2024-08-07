Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C4B3C3DA7F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 15:03:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28C4910E563;
	Wed,  7 Aug 2024 15:03:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="NiD3vO8E";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AC1510E562
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 15:03:18 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4WfD2B23Pkz9tW6;
 Wed,  7 Aug 2024 17:03:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1723042994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pXRi0p1boQwmSOXB6TcX4M9iZ9VAA4CzygoqXnWmCgE=;
 b=NiD3vO8EgdhZqr1flxiPg5u+hpiyuEnEv6Hu8xTLx1129X9ZfncDWFrHuwIT/9xeANkyr7
 TXKyzILT9TJS1jAyopEVBcQQJVhf2S44M+8IoCU4DPRp4XBgWRVhs2QNWT9Ztjj7Bpct+z
 twhV3xfKLaVUJJ2WOK41oJ3MvqatMhwYwXcv1tHitLmxM3fRs6P34uGrHFpQIUSGDh/qn5
 RGEIvHymLJygVchNNb8P601JOV+MuOaeb4UbsFGup3u+ay5G24/D/heQyBH4QVU/fs6HT8
 84FyRHy5fK9N97KWc/m4ic3ccavW63jtFugp07yqrLL3mzDA/6HQXzl8kUfXHA==
Message-ID: <63b3fedc-e793-4e87-82a6-5448adb2e544@mailbox.org>
Date: Wed, 7 Aug 2024 17:03:12 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] drm/amdgpu: Actually check flags for all context ops.
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Cc: alexander.deucher@amd.com, christian-koenig@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20240806202732.783604-1-bas@basnieuwenhuizen.nl>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: de-CH-frami, en-CA
In-Reply-To: <20240806202732.783604-1-bas@basnieuwenhuizen.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 0a13fc1aa3981410364
X-MBO-RS-META: euiqhmd5t43w567bkgyx84jmxmhf1b4h
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

On 2024-08-06 22:27, Bas Nieuwenhuizen wrote:
> Missing validation ...
> 
> Checked libdrm and it clears all the structs, so we should be
> safe to just check everything.

Thanks for fixing this.

FWIW, amdgpu_cs_ioctl has the same issue AFAICT. Haven't checked any others, there might be more.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast

