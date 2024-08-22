Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0654BC3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Aug 2024 14:51:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B053A10EB17;
	Thu, 22 Aug 2024 14:51:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="xwIDGcIr";
	dkim-atps=neutral
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F48F10EB0D
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Aug 2024 14:51:39 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WqR3q5h2fz9sxp;
 Thu, 22 Aug 2024 16:51:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1724338295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w4swD9eHTh8+apZXdVKXkTXXQ80yGnjdSnN22Xbs3m0=;
 b=xwIDGcIrbNzjJugZiwzTWbUy9BlgFvn1C+Xze5KQT920paoKQRdf37W66cvmrOubB6vkDe
 iNXhta97s4l9rwWQIAVlag76j+IVYNSODReDT6fqo02RlOdAciv+DaxL5gcHOyzWMiXQ36
 BrjULWe562MDEfXWNwXm6Wp/ju7gtT8hyP75ciyvrPGC2ggC8ORgmHv49XFx80bkN3FZaW
 FLoqKYIpKjQFRyy7EF3nOZUqggKv/fXYcd4m68d0gA3yFmC236goEMTOL+AV9SrdiFx6xL
 ZcJBSLmKJHlMeAYZahUSekYaGkD1ALbOyj7QSQwrUAz6fTsO2qtkWQcnlnhZ6A==
Message-ID: <df116d3d-a82f-4893-a93d-2bf39a51d7f3@mailbox.org>
Date: Thu, 22 Aug 2024 16:51:34 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] drm/amdgpu: add list empty check to avoid null pointer
 issue
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, tao.zhou1@amd.com
References: <20240821065722.353171-1-kevinyang.wang@amd.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <20240821065722.353171-1-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 924cc7bbcabee3c1a01
X-MBO-RS-META: k47qu6ma775r7s6mari7hwyij93wta4h
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

On 2024-08-21 08:57, Yang Wang wrote:
> Add list empty check to avoid null pointer issues in some corner cases.
> - list_for_each_entry_safe()

What corner cases?

If the list is empty, list_for_each_entry_safe() should be mostly a no-op.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
