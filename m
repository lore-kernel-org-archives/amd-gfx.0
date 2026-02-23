Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E2BDEC1134
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Feb 2026 20:36:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF50410E30F;
	Mon, 23 Feb 2026 20:36:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="AhZNfyDd";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C04410E30F;
 Mon, 23 Feb 2026 20:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8N68AvewiJEiVoFb9Et69iCQWQxrvhKR8SCPUSqu5Pc=; b=AhZNfyDdmJM0bYKBtoiUjSriME
 hM1wwEyYOhLYsXxlfw4If9c5Lq1Qbs/EDqjPmybc3t7L9cjOPpD+SHyQtY5tiJfLfBfbfQ7NsHKYp
 xPCXtf8sgvaiyOPf04Y5sQdQ5GHwpwOjGOGvqgEeMZ45gFTo34DizTFQwpIn7qICkEWQveEAyJIMr
 TCTs1huDAC4GdMJnGWj884jhAPy953wFtmU4WLMTC9CrYRh17X+B9M3CyKLhkVeTK6iDrKViLL3SW
 gVVgmTNJJDqTkDmYplKIgs9Te7lIomB7h+utIHBoA3pgr7z3jJ0+YxI32Sp6GMr5Ic+3WAaY6IST4
 Zx4znVjA==;
Received: from [186.208.68.119] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vuceV-004QdK-MG; Mon, 23 Feb 2026 21:35:36 +0100
From: Melissa Wen <mwen@igalia.com>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 mario.limonciello@amd.com, mwen@igalia.com, alexander.deucher@amd.com,
 alex.hung@amd.com
Cc: Ivan Sergeev <ivan8215145640@gmail.com>,
 =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Xaver Hugl <xaver.hugl@gmail.com>, amd-gfx@lists.freedesktop.org,
 kernel-dev@igalia.com,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 Jani Nikula <jani.nikula@intel.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Mario Limonciello <superm1@kernel.org>, dri-devel@lists.freedesktop.org
Subject: [RFC PATCH] drm/drm_edid: ignore continuous frequency support for VRR
Date: Mon, 23 Feb 2026 17:29:46 -0300
Message-ID: <20260223203528.213275-1-mwen@igalia.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Display can be VRR capable even if its EDID doesn't contain the
Continuous Frequency flag. On the other hand, continuous frequency
support is expected for smooth VRR and ensures better compatibility with
VRR tehcnologies. As the lack of this flag can result in unexpected
issues like tearing, get monitor range even without the guarantee of
continuous frequency but add a debug message for unexpected results.

CC: Ville Syrjälä <ville.syrjala@linux.intel.com>
CC: Jani Nikula <jani.nikula@intel.com>
CC: Harry Wentland <harry.wentland@amd.com>
CC: Mario Limonciello <superm1@kernel.org>
CC: Alex Hung <alex.hung@amd.com>
Reported-by: Ivan Sergeev <ivan8215145640@gmail.com>
Fixes: 0159f88a ("drm/amd/display: remove redundant freesync parser for DP")
Signed-off-by: Melissa Wen <mwen@igalia.com>
---

Hello,

After replacing the AMD driver-specific parser for VRR with the drm_edid
implementation, monitors without the continuous frequency flag in their
EDID stopped obtaining the monitor range because the DRM common code
considers them incompatible with VRR if they don't advertise support to
continuous frequencies. This differs from the original driver-specific
parser of AMD, that only checked EDID version, EDID_DETAIL_MONITOR_RANGE
and DRM_EDID_RANGE_LIMITS_ONLY_FLAG to determine the VRR range, so
switching to DRM common code caused a regression (reported by Ivan).

The commit ca2582c66b930 `drm/edid: Parse only the VRR range for
continuous frequency displays` [1] introduced the Continuous Frequency
flag condition. While it was created to avoid issues related to
non-continuous refresh rates, it looks very restrictive to drivers that
want to deal with VRR capable monitor even without the guarantee of
continuous frequencies. I propose relaxing this restriction and adding a
debug message if anyone experiences problems related to the lack of
continuous frequency support.

Maybe I'm missing something, so I would like to hear your opinions.

Obs.: In addition to the display kernel developers who have already
worked with this code, I am sending copies to some compositor developers
who may have an opinion on it.

[1] https://cgit.freedesktop.org/drm/drm-misc/commit/?id=ca2582c66b930

Thanks in advance,

Melissa


 drivers/gpu/drm/drm_edid.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index ff432ac6b569..8ebd1c17d78a 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -6517,7 +6517,9 @@ static void drm_get_monitor_range(struct drm_connector *connector,
 		return;
 
 	if (!(drm_edid->edid->features & DRM_EDID_FEATURE_CONTINUOUS_FREQ))
-		return;
+		drm_dbg_kms(connector->dev,
+			    "[CONNECTOR:%d:%s] Display doesn't support continuous frequencies\n",
+			    connector->base.id, connector->name);
 
 	drm_for_each_detailed_block(drm_edid, get_monitor_range, &closure);
 
-- 
2.51.0

