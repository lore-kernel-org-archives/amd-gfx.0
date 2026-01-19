Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C2ACA6016
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 08:18:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF79710E3CA;
	Mon, 19 Jan 2026 08:18:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O4hDBWGR";
	dkim-atps=neutral
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com
 [209.85.218.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A29AE10E30B
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 01:12:05 +0000 (UTC)
Received: by mail-ej1-f65.google.com with SMTP id
 a640c23a62f3a-b8712506a3eso22992566b.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Jan 2026 17:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768785124; x=1769389924; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r18vhTswb3nOt1VBJpOlruOgjP/ijyrBC8r/JG8t7Ms=;
 b=O4hDBWGRi9clgsLkpcl/dRjs8BKKhkgWb+HKbwDA55xnpumF7NbDDY9P/lCk1h74ye
 X1NOaqvMMMIsS01nmRSRT4blIFwrzQcNNYCAztrkhMkjukhEB7us9rn+bTE8teKzDglN
 7hE0hZ8uwcAkLSAYMY+bpiskMLAEYNPOtiWT+M8GD1y1OJ1ly91g7NpzJc6DvB2XUdmi
 uiwtU8bRTqSHRN7nMwapDhOL6FxN+UZ37LaKWiBSNPR4vhprQp/LfibWPg1HX/fW0Ce/
 HIjDamrPIhgp7LMU7qxEyX69+n/ePTgweTG2vD7D4qYx4jnMVDJPmQQUbgE/LMV63g2T
 qd0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768785124; x=1769389924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r18vhTswb3nOt1VBJpOlruOgjP/ijyrBC8r/JG8t7Ms=;
 b=Vvl8le2sQhDVMlmYbwQnmuBY9rVvvW1SMmV2Jq0LBB2DxPi18R5Lt9e+gzMX61jqXb
 M35gmWhmwIYDQaTDWSznD1wXzmFN2ak+NgmsmRXFX6IfhIk1TIZ3c1eT9vXZW02r81e+
 wH3MB3L6MS8TSyGkMhTacI8GoNO6GbUc4MaliHdC7ffLmg2YJDLyZRjVSep2v1FHGhlW
 eOrSRPfTvmaJICLuiCDx8I5Ru6DejBnIVgC2j4EnYLzh6+xcIkiyLuyCUvjNnQQngrZ6
 vzTR6D9mpBSCMD0DZwSmNplyNaoyCyV6LO1cKhhFg6b1YgxFoK6cntuQgerVeXk39nR0
 ZkCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4HxfSx7mqbaoC2dNHCT1zrxjPC83ZDz4d/hy6PMWzg6oi39Kw7+A+/A0XrKTx020w3s01IK+H@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxGsLqmUJQrHiUSQ/317adDpcnGDHGR6+wH+oHjGxffqGPZgETK
 y4guqXm+AJ8ckm/iS/5hyL0nNGhSjY1zRN+ql0SNVEWgWjU6MHVt636I
X-Gm-Gg: AY/fxX4W5mY/A/meQcy/5vpt3IfujwRGmiTMOH6W3SHZuR3VTBs0rZrolKYl86AWWKH
 +tLqEQbVyDIFWC3Y+TW+OW7TECgT1UwgmzXXMY/EtV/p0AUbx/+pwb71E+8earmZRsbdH9Dy9L7
 Jpc6SnIe4nseRHctotVYRoyQ7xF6h3Fv7AiUGBREQ3yK6Io+R7tl5wO4KeeiQ7gHozDuFG2ygJv
 zF9F7QPIq9nHHRvaNbDnvjKr5ggKGHd4UtWqCkNpbPbNtlelTlZyExDRvULNqcJEWtQy3Te5lwp
 saCeWsD3ZNWk+H7K0YArAbJXbMK8eqKWtRYvHr7BUeNb3LNGxuDT1NL1oaM5I36APIGdDwY/45/
 RQ+IbI0UMkvwEEoY/tkVgZybFHlys/STT2pQRn1OeRnRIDwrn6bGipEwu567MuZYlBaOqpQQHrD
 mVj9hWl/TWMJswz9RBtoMSD5uAzBV/CVlJuu6IcIS5blImYC8rlGhOnVL/hkysrHEr
X-Received: by 2002:a05:6402:348d:b0:64c:9e19:982d with SMTP id
 4fb4d7f45d1cf-654523cc85bmr4269711a12.1.1768785124078; 
 Sun, 18 Jan 2026 17:12:04 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-654535c4912sm8989806a12.30.2026.01.18.17.12.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 17:12:03 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com
Subject: [PATCH 10/17] drm/amd/display: Enable HDMI VRR over PCON
Date: Mon, 19 Jan 2026 02:11:39 +0100
Message-ID: <20260119011146.62302-11-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119011146.62302-1-tomasz.pakula.oficjalny@gmail.com>
References: <20260119011146.62302-1-tomasz.pakula.oficjalny@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 19 Jan 2026 08:18:28 +0000
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
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 31 ++++++++++++++++---
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b7deff137df4..772deaa136d7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -13193,6 +13193,20 @@ static void monitor_range_from_vsdb(struct drm_connector *conn,
 	range->max_vfreq = vsdb->max_refresh_rate_hz;
 }
 
+/*
+ * Get VRR range from HDMI VRR info in EDID.
+ *
+ * @conn: drm_connector with HDMI VRR info
+ */
+static void monitor_range_from_hdmi(struct drm_connector *conn)
+{
+	struct drm_monitor_range_info *range = &conn->display_info.monitor_range;
+	struct drm_hdmi_vrr_cap *caps = &conn->display_info.hdmi.vrr_cap;
+
+	range->min_vfreq = caps->vrr_min;
+	range->max_vfreq = caps->vrr_max;
+}
+
 /**
  * Returns true if connector is capable of freesync
  * Optionally, can fetch the range from AMD vsdb
@@ -13242,6 +13256,7 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	struct amdgpu_hdmi_vsdb_info vsdb_info = {0};
 	struct amdgpu_hdmi_vsdb_info vsdb_did = {0};
 	struct dpcd_caps dpcd_caps = {0};
+	struct drm_hdmi_vrr_cap *hdmi_vrr;
 	const struct edid *edid;
 	bool freesync_capable = false;
 	bool valid_vsdb_cea = false;
@@ -13279,6 +13294,7 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	edid = drm_edid_raw(drm_edid); // FIXME: Get rid of drm_edid_raw()
 	valid_vsdb_cea = parse_amd_vsdb_cea(amdgpu_dm_connector, edid, &vsdb_info) >= 0;
 	vsdb_freesync = valid_vsdb_cea && vsdb_info.freesync_supported;
+	hdmi_vrr = &connector->display_info.hdmi.vrr_cap;
 
 	if (amdgpu_dm_connector->dc_link) {
 		dpcd_caps = amdgpu_dm_connector->dc_link->dpcd_caps;
@@ -13324,12 +13340,17 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 		freesync_capable = copy_range_to_amdgpu_connector(connector);
 
 	/* DP -> HDMI PCON */
-	} else if (pcon_allowed && vsdb_freesync) {
-		amdgpu_dm_connector->as_type = ADAPTIVE_SYNC_TYPE_PCON_ALLOWED;
-		amdgpu_dm_connector->pack_sdp_v1_3 = true;
-		amdgpu_dm_connector->vsdb_info = vsdb_info;
+	} else if (pcon_allowed) {
+		/* Prefer HDMI VRR */
+		if (hdmi_vrr->supported && hdmi_vrr->vrr_max > 0)
+			monitor_range_from_hdmi(connector);
+		else if (vsdb_freesync) {
+			amdgpu_dm_connector->vsdb_info = vsdb_info;
+			monitor_range_from_vsdb(connector, &vsdb_info);
+		}
 
-		monitor_range_from_vsdb(connector, &vsdb_info);
+		amdgpu_dm_connector->pack_sdp_v1_3 = true;
+		amdgpu_dm_connector->as_type = ADAPTIVE_SYNC_TYPE_PCON_ALLOWED;
 		freesync_capable = copy_range_to_amdgpu_connector(connector);
 	}
 
-- 
2.52.0

