Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10097C02180
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2025 17:54:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9F8B10E763;
	Mon, 13 Jan 2025 17:54:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=emersion.fr header.i=@emersion.fr header.b="MHUqaJ7e";
	dkim-atps=neutral
X-Greylist: delayed 35390 seconds by postgrey-1.36 at gabe;
 Mon, 13 Jan 2025 17:54:14 UTC
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74AAA10E75C;
 Mon, 13 Jan 2025 17:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1736790849; x=1737050049;
 bh=wIAdXpOHVH+eIAYsSAK460HlK14I3mdw2LRKlhpihUY=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=MHUqaJ7e4bJqxxc5zQL9i2ie9+kD8ZAXGqTK12Eyu+2lXgiAxXPiOBrSrjZMXw8uh
 l/2Ka5k1p2XmFtKKoJzWMWb4MbOwkHtm+MRExF0V/FzXUQaZlFAqUh9d9GFj9NyeYs
 8WziWuDEPb0Hl5BFTkV62P6Ad5ljYKXYJvEAOKKxs8kp2CuaaItgdw/8fPUX1qB2Xd
 hzuy4j4omaKB5j0oal9XmhoeGNhoX6eASR9MtqfHI+VtAHAtyWuL+xKrOVs8Z+84PY
 PsAV8kzBjZHLbekoeiq16EHGLphBvwtPwrRq/e60BNcVnCDw6pt3mThXnekabfk62T
 gVljeKr5TNj3g==
Date: Mon, 13 Jan 2025 17:54:03 +0000
To: Alex Hung <alex.hung@amd.com>
From: Simon Ser <contact@emersion.fr>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 wayland-devel@lists.freedesktop.org, harry.wentland@amd.com
Subject: Re: [V7 10/45] drm/colorop: Add NEXT property
Message-ID: <hcaZ4ajZCirbuHqNhPXDazl7dn71rmBstMMeLn-Z0c90FgxKYGWSn_lNoe6BJCtYf6xMA9NHznA4_Q3M7dN-303eU0_EX_cRaOp_-vwG40s=@emersion.fr>
In-Reply-To: <20241220043410.416867-11-alex.hung@amd.com>
References: <20241220043410.416867-1-alex.hung@amd.com>
 <20241220043410.416867-11-alex.hung@amd.com>
Feedback-ID: 1358184:user:proton
X-Pm-Message-ID: b5c7b3c7f83da49e1a4a97fd1bba47a68d253fc5
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

> +void drm_colorop_set_next_property(struct drm_colorop *colorop, struct d=
rm_colorop *next)
> +{
> +=09if (!colorop->next_property)
> +=09=09return;

Why is this early return necessary? Shouldn't this field be always
populated?

Even if that's not the case, I don't think silently ignoring the
call is a good idea.
