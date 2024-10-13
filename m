Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57999CF2576
	for <amd-gfx@archiver.kernel.org>; Sun, 13 Oct 2024 15:20:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0630210E1F5;
	Sun, 13 Oct 2024 15:20:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=emersion.fr header.i=@emersion.fr header.b="nmKmoR9u";
	dkim-atps=neutral
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D79810E1F5
 for <amd-gfx@lists.freedesktop.org>; Sun, 13 Oct 2024 15:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1728832792; x=1729091992;
 bh=qG9+i76TEyUOa3D20qUMKF8MN9rU3beW9C+iTJeDRG0=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=nmKmoR9ui/QtyGhsQbn5Y/Lj0MdH/pFNbENFq9xXTMZaGc9kPda8a+D4ZTaY8XeJV
 f+tPkB0bMvkvX9ljH3zLEYyR0pU44ocaTHvZRr3tsE7hS0htxb/A+DGT8TY0T+crF4
 C2tb+8V0KO88L46PMUwX5tkWlcb6tCbajGFXWogVfN5+FzH9l8kfwCqoo7DIJ/qH5U
 BEFtb2359Tw4W9rdNe804X1GtBvcAmbe4BvyykEXw0xdEK3NYbwqgdyJp+csYksjBA
 UJJUzwKW31BczxbN2ykcDl9wod4Cnms5SNdsCDurbezaT4ecdgJhwcs8mT3+hk0pax
 h9GF7FkDb9MMg==
Date: Sun, 13 Oct 2024 15:19:50 +0000
To: Harry Wentland <harry.wentland@amd.com>
From: Simon Ser <contact@emersion.fr>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 wayland-devel@lists.freedesktop.org
Subject: Re: [PATCH v6 05/44] drm/colorop: Introduce new drm_colorop mode
 object
Message-ID: <nb7nlv8nVlD6Kyd2cY9FiA5BuxHu9BeVKYSbc_ukRLZKW-BqpCwonJDpoYLKs03i0c_WnujwguLcNfB8YONqSTBYsqDN5B7hZmCrxmchYAc=@emersion.fr>
In-Reply-To: <20241003200129.1732122-6-harry.wentland@amd.com>
References: <20241003200129.1732122-1-harry.wentland@amd.com>
 <20241003200129.1732122-6-harry.wentland@amd.com>
Feedback-ID: 1358184:user:proton
X-Pm-Message-ID: 0eaca2afe889db67fa41a119ee984d410a29e1ce
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

Would be nice to have user-space uAPI docs for the colorop properties.
Just like we have for other KMS object types:
https://dri.freedesktop.org/docs/drm/gpu/drm-kms.html#standard-connector-pr=
operties

Internal kernel docs aren't great for user-space developers, because
user-space developers have no clue where to search the docs. I think
it's totally fine to refer to the uAPI docs from the internal docs,
though.
