Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F33F606A323
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2026 08:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=hVN/8O77
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B74D810EB62;
	Thu, 12 Nov 2026 08:22:42 +0000 (UTC)
X-Greylist: delayed 578 seconds by postgrey-1.36 at gabe;
 Thu, 12 Nov 2026 08:22:36 UTC
Received: from mail-106109.protonmail.ch (mail-106109.protonmail.ch
 [79.135.106.109])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E8A210EB62
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2026 08:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1794471176; x=1794730376;
 bh=qfqBwPi7/tBSKHsxnXYvEMUHhF+vLEImInAzziGGcgE=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=hVN/8O77cy97QqsfX8J/K7m/DJt9GdDMzfCSTSokPOcaL/niCl1lm1UR/ClNOjY4L
 P4/hDcIaLhSiyYLQKipiyqn6kDjBl+UPVKiSewpDx79xdFdnEZV3kPd6Q2cRoyh9kK
 IdKm9r6LfEGUhwkvBVa5NjrMUm0QlPTZLPinVVz1RIX+gZ0PbRoKk0moflvXS67xch
 jlmC36F4SWqg398rQfB3XkMF7NkFtukkMpheYr7XDYz4PYxfe18MXNVktghm0PVgB7
 NkF7pIoUlMlaQUWeT5961lvbcDTNeAkKD2C5iqUW/BQJ5ERh/Hpcg0oIe2qDhyr+h/
 gXDSA4pUljOkQ==
Date: Thu, 12 Nov 2026 08:12:52 +0000
To: James Lin <PingLei.Lin@amd.com>
From: =?utf-8?Q?Eren_=C3=96zen?= <erenozen@protonmail.com>
Cc: amd-gfx@lists.freedesktop.org,
 Alexander Deucher <Alexander.Deucher@amd.com>,
 Sun peng Li <Sunpeng.Li@amd.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Melissa Wen <mwen@igalia.com>
Subject: Re: [PATCH] drm/amd/display: Attach blend mode property for alpha
 planes
Message-ID: <MjIJeaH45OE4BtxZSqwUqXuTQ25FZHMC4xbhnbCo96iss2M96QMI8vBAsBlBqA0F_gFuiMPgUTaH6Y1rjiWP18FjavL1uwecmv6qKNNYIEc=@protonmail.com>
In-Reply-To: <20261108223626.13681-1-PingLei.Lin@amd.com>
References: <20261108223626.13681-1-PingLei.Lin@amd.com>
Feedback-ID: 19860221:user:proton
X-Pm-Message-ID: f1eabd3f1f048cbaa154d7b371ddc0de040f8c1d
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 08, 2026 at 05:36:26PM -0500, James Lin wrote:
> This re-applies commit 3f3139234c28 ("drm/amd/display: Attach blend mode
> property for alpha planes"), which was reverted by
> commit 07df8cb29c8b ("Revert \"drm/amd/display: Attach blend mode propert=
y for alpha planes\"").

Hi James,

I think this warning is already fixed in mainline by Melissa Wen's
series, which went into 7.3 through drm-misc-fixes:

  f0c75da0a6b4 ("drm/amd/display: fix missing blend-mode-prop warning for D=
CN")
  332ad707e38f ("drm/amd/display: advertise PIXEL_NONE and PREMULTI blend m=
ode for DCE")

They change the same block in amdgpu_dm_plane_init(), so I assume they
are the drm-next conflict the revert mentions. amd-staging-drm-next
(47df73aa49) doesn't have them yet, which is why the warning still shows
up there (I get all 8 on a Cezanne laptop). Once the tree picks up 7.3,
this patch would create the blend mode property a second time on the
same planes.

Would it make more sense to pick up Melissa's two commits instead of
re-applying 3f3139234c28?

Thanks,
Eren

