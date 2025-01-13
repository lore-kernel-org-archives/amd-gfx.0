Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C9AEE7719E
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2025 08:07:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C103F10E420;
	Mon, 13 Jan 2025 08:07:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=emersion.fr header.i=@emersion.fr header.b="JKk1qxqs";
	dkim-atps=neutral
Received: from mail-41104.protonmail.ch (mail-41104.protonmail.ch
 [185.70.41.104])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B594C10E420;
 Mon, 13 Jan 2025 08:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1736755628; x=1737014828;
 bh=zRwWsMDd5Kf2yQpedEA3Ka2dLpgNvYvwuOL0uYq4mxY=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=JKk1qxqsChv3tz/9oCATFdb/gjg6WwsnHD/hkziYkS9/5jRSc0aXkoXI+xsee7J4C
 mkV4DPSy20Gen4pM2NERSbzJGtnE1y38i7xA+hCy9WzJdBnE4Wf3bZhIIprXFigH+X
 NydWKEbR13M7CTdq1P1BE7hqzgBF8wWhC4v5Puiqv6F4SJI62YoUEwYuxDHlbi9hgX
 L5vHkDdpmMmhM5qy3Zl6EgQAu5tWPTYCm1p0oixVB2u6sM0L6U0j4B7Qgt1gpgOikn
 3xn6Kt+dqoGoavN3BtxHgChkLxrXkBXZ46LswjM5tpVfhEV3DdIgWUXGwqcOEhOWu8
 j83WiWrSAle/w==
Date: Mon, 13 Jan 2025 08:07:03 +0000
To: Alex Hung <alex.hung@amd.com>
From: Simon Ser <contact@emersion.fr>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 wayland-devel@lists.freedesktop.org, harry.wentland@amd.com
Subject: Re: [V7 07/45] drm/colorop: Add 1D Curve subtype
Message-ID: <08ZAONAsAAyGiNLj1-tmB7YeJRYPqWFBxnOLIipVCvig37L1TwBKBiuOrotcHtYWO7-JN6wwrj19QZzaEuapiECmIYGsYX7Ul3Qr8pBuAxk=@emersion.fr>
In-Reply-To: <20241220043410.416867-8-alex.hung@amd.com>
References: <20241220043410.416867-1-alex.hung@amd.com>
 <20241220043410.416867-8-alex.hung@amd.com>
Feedback-ID: 1358184:user:proton
X-Pm-Message-ID: 9033b743e070ec9bd4808ce224177c27b2bffedc
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Reviewed-by: Simon Ser <contact@emersion.fr>
