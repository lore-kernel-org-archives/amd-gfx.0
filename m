Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A50D4C02184
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2025 18:23:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27A1910E07F;
	Mon, 13 Jan 2025 18:23:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=emersion.fr header.i=@emersion.fr header.b="djH4Vcaw";
	dkim-atps=neutral
X-Greylist: delayed 1999 seconds by postgrey-1.36 at gabe;
 Mon, 13 Jan 2025 18:23:23 UTC
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0F3910E07F;
 Mon, 13 Jan 2025 18:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1736792602; x=1737051802;
 bh=N/vuTYAMgwItZ38XD28tjmHIGa2c176dnzKIH0kQz+Q=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=djH4VcawAZXKu2lUJtW6WCrrOywuGPB/zS3iHnG43qeE5QPejIxjuREqTlTMb/4hH
 sBWkVj4sCUow5Vr8R3dDrXmu76TY9e/Tto1Rli0SbKTQ3r6hu/6kmWWy6b80s7pl+h
 +ft/KumBcBeCKjhFAyLP1WythIo6qH+zayKx7PEHn5T53C/7WKOE1gzyr0FRbFxL5N
 5HvDp+aZstpLEwKyua8uMG/52RKSy95wxBPVu8umwOPmXeKeo3jC1C+AoSLgS7usF0
 QqZFbx2aUog3d8dKe3I6w51aStR01GBiPLLkvTIs+ykWUvh6ZSbX7Oiz0YAUUCPTRI
 GgAXhuNVL0X0Q==
Date: Mon, 13 Jan 2025 18:23:18 +0000
To: Alex Hung <alex.hung@amd.com>
From: Simon Ser <contact@emersion.fr>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 wayland-devel@lists.freedesktop.org, harry.wentland@amd.com
Subject: Re: [V7 13/45] drm/colorop: Introduce
 DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE
Message-ID: <AJXss1OmMMC2tqJmFXzUC-YCESFw4ncGj-sEh-B1LuuDnPL-0hOQ3kSSM5DtkYvFv8bHRpMxguAInlYiw8AdkstU_jZVp0ly_EGq0P_m37M=@emersion.fr>
In-Reply-To: <20241220043410.416867-14-alex.hung@amd.com>
References: <20241220043410.416867-1-alex.hung@amd.com>
 <20241220043410.416867-14-alex.hung@amd.com>
Feedback-ID: 1358184:user:proton
X-Pm-Message-ID: 6127e2e54c2bbe06b7d22142f86435b148d097c5
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

> v4:
>  - Don't block setting of COLOR_RANGE and COLOR_ENCODING
>    when client cap is set

Can you remind me why these should not be blocked?

We should also add doc comments in the color_range and color_encoding field=
s,
to document that drivers should ignore these fields when the cap is set.
