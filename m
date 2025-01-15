Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 235ADC02180
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2025 15:48:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BE0910E715;
	Wed, 15 Jan 2025 15:48:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=emersion.fr header.i=@emersion.fr header.b="afH2ivZU";
	dkim-atps=neutral
Received: from mail-10627.protonmail.ch (mail-10627.protonmail.ch
 [79.135.106.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 254A110E715
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2025 15:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail2; t=1736956108; x=1737215308;
 bh=Mt89DaH1uATjgYiC+N17QrcLQ9Zd3LKJA3mnurPmefI=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=afH2ivZUQBlcjJUezRAxG4riQIXITMXKPdrYfrqMSUCqVZUA9mOa6p7BI+dE6N8/u
 O9RF4bCY5HibUd50M3VmxRNfgwrjWnxitKA+rvkxZckyTuJkrpkYJMpirUOIaJzwAK
 GSlTw9j07gAbgC3lY8CR7gOZl+acQP4IJ4p0J5XD0LlQnjCQ3kfHl8Vz/gFNqmAELx
 SseAtpcVIbuppMAIPowdbRnYkVArmY0xm5bT3AzRLstaAmbHtY/oSgHdyEF8s/V84k
 npnnAsjTcNOHDnuC76gPlsaUNZQtowKPeQQPi1R4oeUQUMdNzCsoGerQDpXgF8k8CE
 lkRAL1nesokAQ==
Date: Wed, 15 Jan 2025 15:48:23 +0000
To: Alex Hung <alex.hung@amd.com>
From: Simon Ser <contact@emersion.fr>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 wayland-devel@lists.freedesktop.org, harry.wentland@amd.com
Subject: Re: [V7 33/45] drm/colorop: Add 1D Curve Custom LUT type
Message-ID: <MGVACUtk1em89eXBBEsVZcPZvOVc0CdVJ51KYgPvJ3ujloB5B1t1mlk_JSYCZyZ-gyIL_qtsTFTZX_r_sMQy7HZK_sJAMSligkMFvGYR4Ng=@emersion.fr>
In-Reply-To: <20241220043410.416867-34-alex.hung@amd.com>
References: <20241220043410.416867-1-alex.hung@amd.com>
 <20241220043410.416867-34-alex.hung@amd.com>
Feedback-ID: 1358184:user:proton
X-Pm-Message-ID: 60f661218027eb869abc79a1edb91e1da014c3c5
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

> +=09prop =3D drm_property_create_range(dev, DRM_MODE_PROP_IMMUTABLE, "SIZ=
E",

Ah, I forgot something: I think this needs to be DRM_MODE_PROP_ATOMIC?
