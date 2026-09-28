Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C58FFCA5FA1
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 08:23:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC6B410ED7A;
	Tue, 29 Sep 2026 08:23:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=freebsd.org header.i=@freebsd.org header.b="rCW4HRuJ";
	dkim-atps=neutral
Received: from mx2.freebsd.org (mx2.freebsd.org [96.47.72.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12C3710E891
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 13:30:51 +0000 (UTC)
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519)
 (Client CN "mx1.freebsd.org", Issuer "YR1" (not verified))
 by mx2.freebsd.org (Postfix) with ESMTPS id 4hthyd5vKsz4fq3;
 Mon, 28 Sep 2026 13:30:49 +0000 (UTC)
 (envelope-from emaste@freebsd.org)
Received: from freefall.freebsd.org (freefall.freebsd.org [96.47.72.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
 client-signature RSA-PSS (4096 bits) client-digest SHA256)
 (Client CN "freefall.freebsd.org", Issuer "YR2" (not verified))
 by mx1.freebsd.org (Postfix) with ESMTPS id 4hthyd55y5z3JR5;
 Mon, 28 Sep 2026 13:30:49 +0000 (UTC)
 (envelope-from emaste@freebsd.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
 t=1790602249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=YCxMIzkkwqZVcAZWwFDBgHmeqojxubLQfMAiQkqnlzM=;
 b=rCW4HRuJGsQlHgh5xkeyci7i8WTSXsU31P2Y+tJoO+A9SpQIDW6qPAeY9mtM2XETGNxkWV
 SMhlSCeJGruZoCQAHlQchC4aEpiPB2iTGYvx3OkVKt0qZVrI9lbcextq3099S0sop4PHSb
 jASUgF9oKJRvR594c3ElLTzj4FJkWgZ5oZcbAVjZPi/nB5F7KspJLux3KUBCHyW7HRVX1D
 mL7G0+O9yKGRpD3fqVsdX7WF5ySDt0xLAzBGspYmFJpkF110/aKUgGtpfUKvGpGVn8nK7q
 CeZD6vPNK+v31H2pnHUQJkiAzoMIAFOcG1Bl121StXoPVIHV+KWP1qTWxp6ebg==
ARC-Seal: i=1; a=rsa-sha256; d=freebsd.org; s=dkim; cv=none; t=1790602249;
 b=VkuH7erWgR1fIA2vPnVE9kIRGbhEDbDUKMN2Ep4Z2H02BvO6b379U7ATQBK/tfcCp0Cbxc
 nJPAXkUB5yatByetkq0RO8iD0MYvyn5jKEnbOXR83s/l+slgj5GsLJTqEIe8PSxoOsD3fv
 WNeTHfiOT36mgC+7puM/f0tYuSSlehNbuGBzi1SXh0gNrG++GcPs9htaBs2B29TTXV+HmR
 vJHk4b18MJZNMoU5lALzE/jumJC6p6+lW2H/q1jyq07J5R7SZIYvYM4huHUxo86oKHt0Od
 etaY747TnW27z83FwzmMWR05tk4KiZb+Kzz/UqdFg2+VZN82+U2++EHbt0vRzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
 s=dkim; t=1790602249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=YCxMIzkkwqZVcAZWwFDBgHmeqojxubLQfMAiQkqnlzM=;
 b=PGGz+LCSssOBgY/TfZjabpN2TIDkTS7Roqbc+YH/szL4VCk7Uc0HvOSx2NFnVXOj2BBRwC
 +D2YoIlmxiO6kqA92HPeCUun3Wli4wpGvBmXAXnN4PtE1LPx771Hd3JkKWShfFEcC1tBC1
 5Cp7Tf9cw1yi3axrv1ziBO6XV2BAPyfJYmLOLN/bTf4h6qEcwFOcy4+iGgwMz2OXBx+4Tr
 VxHSRFAwi9JNkMeScQeJc9sJeoaiZHyrLFa9AgO614atM7a01AFQn9oF1gpJ8vyjbINpeP
 1YW+SvrrK0Q3LVEvFh2BD1hE5Cq7hmK+Nxeu7hu+N1eVNm5zihMZFHFSgj9rnA==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
Received: by freefall.freebsd.org (Postfix, from userid 1079)
 id 8BA0819BB5; Mon, 28 Sep 2026 13:30:49 +0000 (UTC)
From: "Ed Maste" <emaste@FreeBSD.org>
To: "Alex Deucher" <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: amd-gfx@lists.freedesktop.org,
	Ed Maste <emaste@FreeBSD.org>
Subject: [PATCH] drm/amd/amdgpu: Add newlines in drm_dbg format strings
Date: Mon, 28 Sep 2026 13:30:30 +0000
Message-ID: <20260928133030.69982-1-emaste@FreeBSD.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 29 Sep 2026 08:23:02 +0000
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

From: Ed Maste <emaste@FreeBSD.org>

Signed-off-by: Ed Maste <emaste@FreeBSD.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c    | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c      | 2 +-
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c          | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index 1e21e3444802..c283087bb560 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -311,7 +311,7 @@ static int amdgpu_atomfirmware_get_uma_carveout_info_v2_3(struct amdgpu_device *
 
 	if (nr_uma_options > MAX_UMA_OPTION_ENTRIES) {
 		drm_dbg(adev_to_drm(adev),
-			"Number of UMA options exceeds max table size. Options will not be parsed");
+			"Number of UMA options exceeds max table size. Options will not be parsed\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 62f5c5cbd7f9..d23de711d8cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -720,13 +720,13 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 	/* Read from file if it is the preferred option */
 	fw_name = amdgpu_discovery_get_fw_name(adev);
 	if (fw_name != NULL) {
-		drm_dbg(&adev->ddev, "use ip discovery information from file");
+		drm_dbg(&adev->ddev, "use ip discovery information from file\n");
 		r = amdgpu_discovery_read_binary_from_file(adev, discovery_bin,
 							   fw_name);
 		if (r)
 			goto out;
 	} else {
-		drm_dbg(&adev->ddev, "use ip discovery information from memory");
+		drm_dbg(&adev->ddev, "use ip discovery information from memory\n");
 		r = amdgpu_discovery_read_binary_from_mem(adev, discovery_bin,
 							  is_tmr_in_sysmem);
 		if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 59ea338b554c..0a8dd7241750 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -1428,7 +1428,7 @@ static int amdgpu_display_framebuffer_init(struct drm_device *dev,
 			ret = convert_tiling_flags_to_modifier_gfx6(rfb);
 
 		if (ret) {
-			drm_dbg_kms(dev, "Failed to convert tiling flags 0x%llX to a modifier",
+			drm_dbg_kms(dev, "Failed to convert tiling flags 0x%llX to a modifier\n",
 				    rfb->tiling_flags);
 			return ret;
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
index 485ecdec9618..363266f3e0a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
@@ -235,7 +235,7 @@ static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
 
 	r = amdgpu_acpi_get_isp4_dev(&acpi_dev);
 	if (r) {
-		drm_dbg(&adev->ddev, "Invalid isp platform detected (%d)", r);
+		drm_dbg(&adev->ddev, "Invalid isp platform detected (%d)\n", r);
 		/* allow GPU init to progress */
 		return 0;
 	}
-- 
2.55.0

