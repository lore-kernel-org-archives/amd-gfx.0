Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF4A606A31C
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 08:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZuNmhfxa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA48310E145;
	Thu, 26 Nov 2026 08:26:22 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B77210E145
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 08:26:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2ED6862BE9;
 Thu, 26 Nov 2026 08:26:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62031F000D3;
 Thu, 26 Nov 2026 08:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795681575;
 bh=8A7OE1EsrVHvptoWCg7r6zVFj2WS2GES7m8uCqgXlNU=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=ZuNmhfxaa88gBpu6FKio1tvPPqQg4wx6b18v1F6lT07WqPj/8fXITJ8siuep80/bw
 co24rb7FJPp00KKrZD/BfnqmkCgbLhWs2tpVewZtbM2Yel8wOf85E8O9RFqNvuNrNf
 m1xTyn5zMIbQnmZWM9X/IjTekPLmyMvkGOQafoAhlXaPFFZX6Ilar7li1Pl9zlPHnw
 /qC6YH+ryipWKkzI+aUZKAW66tzHpaKssTFjraKUXX0AIu90cTRWzPSLbSp38g8reU
 kiLStbjGmBO1H/oMPpZ9V7TVuF8DoDwS+G/s8iid1wvHWXgMQBbSgM8ECFWGqyrGPA
 ZvtlAjd3CkWzQ==
Message-ID: <sashiko-outbox-235009@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/amd/display: Rebuild the VRR vtotal limits on a
 modeset
To: "Matthew Schwartz" <matthew.schwartz@linux.dev>,
 amd-gfx@lists.freedesktop.org
In-Reply-To: <20261126053606.12286-2-matthew.schwartz@linux.dev>
References: <20261126053606.12286-1-matthew.schwartz@linux.dev>
 <20261126053606.12286-2-matthew.schwartz@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 08:26:14 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/amd/display: missing Fixes trailer for VRR vtotal limits
  modeset bug
--

commit 3bbede195cddea78c60d37613de49a067d814537
Author: Matthew Schwartz <matthew.schwartz@linux.dev>

> drm/amd/display: Rebuild the VRR vtotal limits on a modeset
>
> mod_freesync_build_vrr_params() returns early when the VRR state, the
> calculated refresh limits and the fixed refresh target are unchanged,
> so a modeset between two modes with the same refresh rate keeps the old
> mode's v_total_min/max while VRR stays active. With BTR enabled they
> are recalculated on the next flip or the vupdate after it. Without BTR
> they stay until six flips come in below the refresh range. Going from
> 1080p60 to 4K60 on a 40-60 Hz sink, where BTR is off, leaves limits of
> 1125 and 1687 lines on a 2250-line timing, and they are programmed into
> the OTG on every vupdate.
>
> Commit 33c995709121 ("drm/amd/display: Allow VRR params change if
> unsynced with the stream") resynced the limits for the inactive state
> only. Clear the saved VRR params on a modeset so they are always
> rebuilt from the new stream.
>
> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>

[Severity: Low]
585d450c76d1 ("drm/amd/display: Refactor to prevent crtc state access in
DM IRQ handler") moved vrr_params from dm_crtc_state to
acrtc->dm_irq_params and dropped the memset() that reset_freesync_config_fo=
r_crtc()
performed on a modeset.  Should this include a Fixes tag:

  Fixes: 585d450c76d1 ("drm/amd/display: Refactor to prevent crtc state acc=
ess in DM IRQ handler")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126053606.1228=
6-1-matthew.schwartz@linux.dev?part=3D1
