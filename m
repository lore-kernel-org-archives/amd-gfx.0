Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 191C1E83EF9
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 08:10:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 741CA10E54B;
	Wed,  4 Feb 2026 08:10:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Slg/3qXU";
	dkim-atps=neutral
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
 [209.85.208.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 922BB10E759
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 18:56:45 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id
 4fb4d7f45d1cf-650854d9853so1067275a12.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Feb 2026 10:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770145004; x=1770749804; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZMyppU45ocduU72R81pb5sGVjFLNkBj7pAzByccoIn4=;
 b=Slg/3qXUyrK2BChhj11kY6BHYsi/utDfYCe62vwgFi8vuEt+bZTbt9oF9+3Z8ohbw0
 P0Rngzp7jvKRzjEZXHw4rwNNyj+hu0/4Rb1JbyKe/tuI2FOUq6k9lXyNhVLqv8TQeTam
 xOY2fsB8gALPvHblTlxb8jHljnEET2b+u54DTS7t+0hBM90g0iwV0N6RN+gF6gcudNC1
 ca6q6fqmh5DVKoGzONDQXNkqCZ+v1+s9cSyLJO9KWrBxoGZIMwb9xHp2SSh83YsNpqz6
 64Pv/jl+uMVmJPEBgLyzmnkxyiMI/RgyZY/9eQ9g2U9cQekLgw5422rY/FUw3nvXb90s
 g+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770145004; x=1770749804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZMyppU45ocduU72R81pb5sGVjFLNkBj7pAzByccoIn4=;
 b=BPE10Cl6UnQL4GUN/j/pg1v8lZOLcojX8E7PdlgFIJ0DPYZG46LtgdDJ8GLWtdJEhm
 sPjGOpoehqaaIMC55i3NJRNXMLZOtD0QKaapV+HK5W8QfFk9gmg9cc2SRTpQ6lI98+ls
 CN9rh9IVfX1vx3NC6yfDZpsft7zNknxLHTOqNc0QrmiEk6ZWfSqWwe81vfoZ+Gd/cKP2
 udi67itD8B9Ij1BEMIRY9RJsDPtdT/rSyeYVVT1FxUFhVl2ZRKEXHkrfDtyI1syPbhTP
 6lyCyNA/HQ6ztHp3wi7IGKg17BusxonuKYOOWeZmO8jCeo2q6DZ3k3UtTK5EYSya2208
 LZFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7PEn3L67EGXxqtwaeN8CGY+CuP3KIaPAzYGlwd3rMUMBRcgpZw3epma7cXCiciq88UnZC6pkC@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwrkP6KXPkkdKuoQvrTmdZ7gsWz6/INy5fYNanzfn4RuLfQwUc5
 AtCNb7USMWG4jJhZhGDQueLFt3vqVawvGwXk1UoM8gSv+JPskYmnJ6fr
X-Gm-Gg: AZuq6aLIs3DKvVXWNdPc6y1AMMTCA/eNyHwFkmx3jHmd1550OFSxqJJ3wZ4VC0NW0GF
 ZuoWzmbXHuEvNEakeZk+bYJwA99Gs/G0S1S0l9rBDStNsayFcsguhzuAmTbgXL4nL3uCs3Bnp5B
 16Wb2KK2wWhpyxAB0HdaK/b7wmfSCbeHhLD3nPq+CGAv8QxP4JYAWon9WdSfRcyO5IlnudQKPwf
 gX7bUwYi25MsWpX5UwTp2s5/ILLkbjrL4jH/PmM01LdUVoDs1kKyARZoR7optpAx2s0zACs91bK
 UUw8/qWKJwHoxbmS0EMD1BIIRFMGTl1XMoaFBDJk23uI2ti6KUxLGGpRXekNYrmPXqS1+Dk+Oa3
 VuJ+Hu4uXKk+tdTmmOBTKUfaR6l8SRdO/KfaKPeQaxHmHRaNJ/tX1KjDMt8QSifDES9vl/M3jN5
 /O7GQ7WM7gwGZBTptDpF9qszTbEs8vG4WkJ160s9K0ezfXspjgFTjinmULduDfQZN8
X-Received: by 2002:a17:907:d78b:b0:b8d:e858:dee5 with SMTP id
 a640c23a62f3a-b8e9f2b2cfbmr22346466b.5.1770145003959; 
 Tue, 03 Feb 2026 10:56:43 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8e9fad97a7sm16715766b.0.2026.02.03.10.56.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 10:56:43 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com, michel.daenzer@mailbox.org,
 daniel@fooishbar.org, admin@ptr1337.dev
Subject: [PATCH v3 10/19] drm/amd/display: Enable HDMI VRR over PCON
Date: Tue,  3 Feb 2026 19:56:17 +0100
Message-ID: <20260203185626.55428-11-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203185626.55428-1-tomasz.pakula.oficjalny@gmail.com>
References: <20260203185626.55428-1-tomasz.pakula.oficjalny@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 04 Feb 2026 08:10:21 +0000
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

[Why]
Not all TVs support FreeSync and many TVs suffer from VRR flickering
while Freesync is activated.

[How]
This works the same as FreeSync over PCON just without sending FreeSync
info packets (we're sending standard DisplayPort info packets) + reading
the VRR range from the HDMI Forum vendor specific data block. PCONs take
over HDMI VRR triggering.

Prefer HDMI VRR over FreeSync to reduce VRR flickering on many TVs.
FreeSync over HDMI seems to be a fallback solution and not a first-class
citizen. This especially helps VMM7100.

Tested with VMM7100 and CH7218 based adapters on multiple HDMI 2.1 and
HDMI 2.0 devices. (Samsung S95B, LG C4, Sony Bravia 8, Dell AW3423DWF)

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4805

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
Tested-by: Bernhard Berger <bernhard.berger@gmail.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 28 +++++++++++++++----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 92e571e687e9..6fb23d59fcc9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -13231,6 +13231,17 @@ static void monitor_range_from_vsdb(struct drm_display_info *display,
 	display->monitor_range.max_vfreq = vsdb->max_refresh_rate_hz;
 }
 
+/**
+ * Get VRR range from HDMI VRR info in EDID.
+ *
+ * @conn: drm_connector with HDMI VRR info
+ */
+static void monitor_range_from_hdmi(struct drm_display_info *display)
+{
+	display->monitor_range.min_vfreq = display->hdmi.vrr_cap.vrr_min;
+	display->monitor_range.max_vfreq = display->hdmi.vrr_cap.vrr_max;
+}
+
 /*
  * Returns true if connector is capable of freesync
  * Optionally, can fetch the range from AMD vsdb
@@ -13279,6 +13290,7 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	struct amdgpu_device *adev = drm_to_adev(connector->dev);
 	struct amdgpu_hdmi_vsdb_info vsdb_info = {0};
 	struct amdgpu_hdmi_vsdb_info vsdb_did = {0};
+	struct drm_hdmi_vrr_cap hdmi_vrr = {0};
 	struct dpcd_caps dpcd_caps = {0};
 	const struct edid *edid;
 	bool freesync_capable = false;
@@ -13314,6 +13326,7 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	/* Gather all data */
 	edid = drm_edid_raw(drm_edid); // FIXME: Get rid of drm_edid_raw()
 	parse_amd_vsdb_cea(amdgpu_dm_connector, edid, &vsdb_info);
+	hdmi_vrr = connector->display_info.hdmi.vrr_cap;
 
 	if (amdgpu_dm_connector->dc_link) {
 		dpcd_caps = amdgpu_dm_connector->dc_link->dpcd_caps;
@@ -13359,12 +13372,17 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 		freesync_capable = copy_range_to_amdgpu_connector(connector);
 
 	/* DP -> HDMI PCON */
-	} else if (pcon_allowed && vsdb_info.freesync_supported) {
-		amdgpu_dm_connector->as_type = ADAPTIVE_SYNC_TYPE_PCON_ALLOWED;
-		amdgpu_dm_connector->pack_sdp_v1_3 = true;
-		amdgpu_dm_connector->vsdb_info = vsdb_info;
+	} else if (pcon_allowed) {
+		/* Prefer HDMI VRR */
+		if (hdmi_vrr.supported && hdmi_vrr.vrr_max > 0)
+			monitor_range_from_hdmi(&connector->display_info);
+		else if (vsdb_info.freesync_supported) {
+			amdgpu_dm_connector->vsdb_info = vsdb_info;
+			monitor_range_from_vsdb(&connector->display_info, &vsdb_info);
+		}
 
-		monitor_range_from_vsdb(&connector->display_info, &vsdb_info);
+		amdgpu_dm_connector->pack_sdp_v1_3 = true;
+		amdgpu_dm_connector->as_type = ADAPTIVE_SYNC_TYPE_PCON_ALLOWED;
 		freesync_capable = copy_range_to_amdgpu_connector(connector);
 	}
 
-- 
2.52.0

