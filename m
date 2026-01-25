Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03318C88E64
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 08:09:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8850F10E3BE;
	Mon, 26 Jan 2026 08:09:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZvNwLJdg";
	dkim-atps=neutral
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
 [209.85.208.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2738A10E372
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Jan 2026 18:39:32 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id
 4fb4d7f45d1cf-6505d1420daso572310a12.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Jan 2026 10:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769366371; x=1769971171; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wD3DZNrHRBINvEokamMq5jiUBWudz0vnljedektK4oE=;
 b=ZvNwLJdg6SgwpXRVs07hszBs/x03Q9/P1PESbSsKqYXSWTLdluGyCbJgFSwOG04TuA
 iVGcasrdu/LSzvXcJKt5/azN1/v1KKwHHd3OHLO+CJ/otyBSPpM1Ey5SrWauHrZkRUz6
 pH8Vw4x9QCcQ+s/phNTvQwVb2pHNasiwlr/Zersqv5l5H6au1lbP96muPo5XCvJgRt6E
 CcYn5z1FeBb00IXa8cUnQ4cbcg4APefbfw3VI2CRUkJYJXgoijvonC0MiHCohvR0+hBz
 mdF0Y9UpQ6q6pqlbs+bt3r3t1Aj3nzkHuIp5OGZBCH594MOnrSL22ppfXzW8afLsP9Pc
 sF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769366371; x=1769971171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wD3DZNrHRBINvEokamMq5jiUBWudz0vnljedektK4oE=;
 b=L20lggydObXYioYjwMzxsd7ztQFAyRv/ddWgrr19J+jGJfll37Y2QR069PF+mrTy+D
 wV8H7wRxsc+pGiIEEPzL6/QKYSQKlRYX+oF0gr9vv8ET31fM5FPOsD/imupaWP9Ypwo4
 Kdjq+H9YvElP5K533D4l3aZMLZQlv0t35djIj13rHkPIAlPlI5wHQ79GxNZRWHzu3coB
 5F7QI8ErmQQ29i2FUxqf1xeD6va8bo2BlRojOvTTMmR8eZo1BrJogqjQZ3p/SZIHjINc
 b5cCxPmHhIiC1tV/D2U9TM/97VNr4WJ4KabJExBexnRFcgqwC3j4nTINmzBR3v8AuLTF
 17Jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGqGjqFnfDhGngHFnQi7htomm0i9D4CVdyQquEedS/ZaEotMfxr5ENIcMI3HZ7q2MXG6lThJBY@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxYumL1DI403elCc6zt/C3ihscJ+3X/g6Kjj40sCkLvEPb8RxfF
 Th8UWKvbTIUZ0Mn/6msyOO2cRFtmETlnEXmL8pwl+graSntevdc2H1Fq
X-Gm-Gg: AZuq6aIPVSwkeD60V4RcQCHW3DPfj2zmGooQHDWmKwQq3hSli7rP6bO7P/G0lBZ24BQ
 EXeA/5ATrLVt38iMxCd/6b2X7c1uJrdXCFlZ9kj6xp9X2/GBg9F7EyZCbX1w/tibDP5PEJ8KFBq
 DqVBx7indJkSpl3emCLPOXA4LqUZ00yxnI8tIaCOVo2H+y37ZXDuOexLnv9bmxqBSFwXmOpcIdH
 BeCce1/PmCDkOg89h7xbpsL5wg4qW1tJoRyMpxxPmKQU+5ntKnMVp85hutSvDSMmMgFV0ph94UU
 KHbme/pvPXNKlBByy2iXu8Ts9pYyxrX+l/Tlj+lI4byGOi+hN2adbnMqAkwK3CJ5tNGFtmBSJCy
 34Tal7e2O4OpXIULPEKsXRg+xFY3cBdxMcSJWbHWsFifI8jhVEJN0aZ5/NWsaSEkxS0rHyDfXA8
 QauVokem6W4s7MQLJ2oALQ8M/qQch5BjcuIkQmR3d5PgX7DdcCx8or6paupxjZPUir
X-Received: by 2002:a05:6402:1467:b0:658:1299:8a03 with SMTP id
 4fb4d7f45d1cf-658706c3572mr823565a12.1.1769366370537; 
 Sun, 25 Jan 2026 10:39:30 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b885b3dad3asm499133766b.12.2026.01.25.10.39.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 10:39:30 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com, michel.daenzer@mailbox.org, daniel@fooishbar.org
Subject: [PATCH v2 10/19] drm/amd/display: Enable HDMI VRR over PCON
Date: Sun, 25 Jan 2026 19:39:05 +0100
Message-ID: <20260125183914.459228-11-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260125183914.459228-1-tomasz.pakula.oficjalny@gmail.com>
References: <20260125183914.459228-1-tomasz.pakula.oficjalny@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 26 Jan 2026 08:09:08 +0000
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
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 32 ++++++++++++++++---
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2f856833806e..d3464705ab7f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -13210,6 +13210,21 @@ static void monitor_range_from_vsdb(struct drm_connector *conn,
 	range->max_vfreq = vsdb->max_refresh_rate_hz;
 }
 
+/**
+ * Get VRR range from HDMI VRR info in EDID. If VRRmax == 0,
+ * try getting upper bound from AMD vsdb (if passed).
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
 /*
  * Returns true if connector is capable of freesync
  * Optionally, can fetch the range from AMD vsdb
@@ -13259,6 +13274,7 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	struct amdgpu_hdmi_vsdb_info vsdb_info = {0};
 	struct amdgpu_hdmi_vsdb_info vsdb_did = {0};
 	struct dpcd_caps dpcd_caps = {0};
+	struct drm_hdmi_vrr_cap *hdmi_vrr;
 	const struct edid *edid;
 	bool freesync_capable = false;
 	bool valid_vsdb_cea = false;
@@ -13296,6 +13312,7 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	edid = drm_edid_raw(drm_edid); // FIXME: Get rid of drm_edid_raw()
 	valid_vsdb_cea = parse_amd_vsdb_cea(amdgpu_dm_connector, edid, &vsdb_info) >= 0;
 	vsdb_freesync = valid_vsdb_cea && vsdb_info.freesync_supported;
+	hdmi_vrr = &connector->display_info.hdmi.vrr_cap;
 
 	if (amdgpu_dm_connector->dc_link) {
 		dpcd_caps = amdgpu_dm_connector->dc_link->dpcd_caps;
@@ -13341,12 +13358,17 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
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

