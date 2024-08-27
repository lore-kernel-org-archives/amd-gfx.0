Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 264F4C54731
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Aug 2024 17:50:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9F4010E3EB;
	Tue, 27 Aug 2024 17:50:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="D058zNNB";
	dkim-atps=neutral
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECC7710E3E4;
 Tue, 27 Aug 2024 17:49:57 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (unknown [217.70.183.197])
 by mslow1.mail.gandi.net (Postfix) with ESMTP id AD757C4690;
 Tue, 27 Aug 2024 17:49:55 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D838E1C0002;
 Tue, 27 Aug 2024 17:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1724780993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=35efPCWUZcUi3GpHQu8tIPAWdOO2gcBhHvXSLqqJNzw=;
 b=D058zNNBa9400NUF86ikKyllFC4flvT3jJSeFlZ2V5EcLYbNAP+xrCe7bErbxzMn0XX/v+
 5l7nlTYHiUMijTYYcuergB3Xr3LamIa8Ygp4hmAoNcWgIDdNxA/Q81/Nn2hMv2Wh6p6pRR
 8KvKKgojkYU9JsMdhqXq/gCIaVj5EtRfuDdN3kfuExjc6yBQdO8qgEbDw2pbIuuF4Yp1wY
 E5872DTJddc9YVfGZMt260Bx8vsxRiR3mbhwOjD3AZOK01OkCM1sFHjF5yir5vJHSf+OWK
 E8PQalsXxA6YVbsnwhgNAtWDG+fS/gnUND63ru5/uK1LnYWItLKCmGf8EecjRQ==
Date: Tue, 27 Aug 2024 19:49:51 +0200
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Harry Wentland <harry.wentland@amd.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 wayland-devel@lists.freedesktop.org
Subject: Re: [PATCH v5 41/44] drm/colorop: allow non-bypass colorops
Message-ID: <Zs4Rv929Kc5YVyzw@louis-chauvet-laptop>
References: <20240819205714.316380-1-harry.wentland@amd.com>
 <20240819205714.316380-42-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240819205714.316380-42-harry.wentland@amd.com>
X-GND-Sasl: louis.chauvet@bootlin.com
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

Le 19/08/24 - 16:57, Harry Wentland a écrit :
> Not all HW will be able to do bypass on all color
> operations. Introduce an 'allow_bypass' boolean for
> all colorop init functions and only create the BYPASS
> property when it's true.

You did not change the documentation of struct drm_colorop_state, so can 
we expect state->bypass to be always valid (ie. false when bypass is not 
possible)?

I don't think so, because drm_atomic_helper_colorop_duplicate_state 
/ drm_colorop_reset are setting the bypass to true. Maybe you can add 
something like this?

	/**
	 * @bypass:
	 *
	 * When the property BYPASS exists on this colorop, this stores 
	 * the requested bypass state: true if colorop shall be bypassed, 
	 * false if colorop is enabled.
	 */
 
[...]

