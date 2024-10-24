Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7CA3D10380
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2024 21:35:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5329C10E3BA;
	Thu, 24 Oct 2024 21:35:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=emersion.fr header.i=@emersion.fr header.b="GchmDkiw";
	dkim-atps=neutral
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9849310E3BC
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2024 21:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1729805698; x=1730064898;
 bh=U0MZUFxkg3+UOPqNFrbWaEyCbKpVVLhO0H5Klvvg8Vk=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=GchmDkiwzjHUzphRTZ7mqVaLX2rZofgM4AeXNI1oLuZBQlf6NiAkhwO71L7ZqlXw/
 Z88fUiHzB4reDhzc5BLtCRTrWUdeZqFf66kACHNnSXaqgQi7HFFDbaKXtDPCI0lwvQ
 /xYfCYTEs5rqpCsP8XHu0Odx7iqSfJC3vAaYm8XhI/K/7f+I+GiorF/ipKppCXwiyA
 XMuMoPP/6Fu3JAfGd/63W6CNXBijFN6BkAFXgu5r4W6EkWgqy1uOa6cwu1xh9PgXWk
 B3aIk07fwbgTww5H7lkC3sqYqqagIcF+hOR1IQ6Vlhq6qUeyvdDsdSCQv/IJZB+fsI
 /06b1a3z3rctQ==
Date: Thu, 24 Oct 2024 21:34:52 +0000
To: Jani Nikula <jani.nikula@intel.com>
From: Simon Ser <contact@emersion.fr>
Cc: dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 =?utf-8?Q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 amd-gfx@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 nouveau@lists.freedesktop.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH 2/2] drm: remove driver date from struct drm_driver and
 all drivers
Message-ID: <QMi2RXA05r08zucgpXkakwSfIm28vqmqYoOP-Da66Gq4jQWGZA8PfpAGd4z1VYfU4ao-2sj4u5qO6n5OpQv-ccu8Rwtm5Y1MNpQ-rpTo0tY=@emersion.fr>
In-Reply-To: <20241024162240.2398664-2-jani.nikula@intel.com>
References: <20241024162240.2398664-1-jani.nikula@intel.com>
 <20241024162240.2398664-2-jani.nikula@intel.com>
Feedback-ID: 1358184:user:proton
X-Pm-Message-ID: ff36b191848725b70c63fcfb4b045f3132e16d83
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

Acked-by: Simon Ser <contact@emersion.fr>
