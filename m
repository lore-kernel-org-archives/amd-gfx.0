Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E38BDD31A28
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 08:29:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CF5A10E5E3;
	Wed, 14 Jan 2026 08:29:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Pf7Nr+s9";
	dkim-atps=neutral
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
 [209.85.208.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F6E010E553
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jan 2026 21:41:11 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-64b5eb14e88so1429486a12.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jan 2026 13:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768340470; x=1768945270; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N4LHM++IvHyHjeqEMT100Kj5QFDlUAnoHSe0AnsGOac=;
 b=Pf7Nr+s9oLXy88kFDfzaUyhKv6S86YWMpLvEErt8P2mSL0UtYKRpPWg2rvnJ/ELhQK
 LdO+YZwObbAQDp0TgHTGRn/sJqMznrK6x+LX6tpKrVAuE4WswD06lKfv2I+98k6U6tjH
 hcCraZ6HPBkHg71gsBjyn4d85kwlVg8QlNesoXaxQFdKmxk9B9+RWRbdomjll3rftgDb
 OkOdg2jPmCvuV1GakB6BHRHGd1yJno9NJlqd8WwO22NVggwImKK+FLu3EYCGrVfn4/2c
 AtlTk8eYNHImNt9hctmNX/RB2MRvxIXptzseDjLthdgIPiZ30b+zAeKs90HgQziONCxR
 07sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768340470; x=1768945270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N4LHM++IvHyHjeqEMT100Kj5QFDlUAnoHSe0AnsGOac=;
 b=PQP9i/TZ/KkP9waD7ta72kM9zGDutS/VvlwxQ1iTfNOWBX4+yi2f8sZ0MUj6IMYbMa
 kjGp2AwKZ6+AUu/eH4tVBBW5Fdros8hR/fcdJONY8Rk2zXHwPPtU78M6ol0z6cYrp+NR
 CnfIBzglZRfnVegExBDJ6y+KnFYAj376egU0JyiaW7R8+xA0iGIhN/urFWGWMw+T5Vl/
 q3qo3J7C9em9WX3f2I2iYVHeLU4AHO564jfF8hATubWM4e3kyj/MgIgPCm/o9j5sfrwn
 KLX7Fei/oFT5SItpWBYR2sq6SZoIughZxUXU9/iVzqip18NMKb6EQREsBgonvT6UcOGO
 f5Cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVk4isJaI5W/wGm8SbNR0zyL3iZP01WJLQ0iZk5Lep5IXI8/E5/U4h2H/RA5B0Xb/NejKjbx7Kg@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzXQqtHWC+qjf1vBFBuUFC1MZ683K+B24KXCOWkY0agX1ktOt/g
 fFD6h+Xe2EtMXhVEk9nvNjOirt0V++PZI/0i62gI3Cz21V9fCsYF7LgZ
X-Gm-Gg: AY/fxX571XrvuIWcz007rhT6OTN8/h+/BoXwL8zhSYmCIwcGtmHcByBWaj1COpK4p+p
 o5xBScSPLswj7K98fNN6w3q51wF6ywV0pcEZFBxarr3IjGRNDoaEtrBPowqypz8LZ07s7OINBTS
 o10Sq6MB08rmhRvrpFhu0e40nAlQBaH73JUkGUN1/iWTKVfs2LfJFb0P7bX3RAa/G4JBqCCsz4d
 +0x5lFtKEZ9kfimr2mezLSSO1ovGTd4vC8kcQYKWbDpxvx/RxtZPmesyRhyHguk72oIjviuQF9i
 InUY2L22b4H/XtGCDsMZ/IIa1Kbt74Gm/cwjfIhp12NE5IhcyX1ZG9cT22JW/UrsKdTMkN5M3E8
 rZxrHHjO8CzKA7ndmCkYhppbh8f55WLNnHJeZWfk/+li6L2iuXdjkbY6m9Dp7fMYQOGARUpU7op
 OAlTpi61fsDGhsj+0RuGSNLhFr43SwpbssOZjFlfi6D+zPNI3Vuj1j3JboFAoPt3v1
X-Received: by 2002:a05:6402:2816:b0:645:7d1b:e151 with SMTP id
 4fb4d7f45d1cf-653ec1086d0mr204062a12.1.1768340470025; 
 Tue, 13 Jan 2026 13:41:10 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507bf6d5e0sm20858052a12.31.2026.01.13.13.41.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 13:41:09 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, harry.wentland@amd.com, sunpeng.li@amd.com,
 siqueira@igalia.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] drm/amd/display: enable HDMI VRR over PCON
Date: Tue, 13 Jan 2026 22:41:04 +0100
Message-ID: <20260113214104.146856-4-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113214104.146856-1-tomasz.pakula.oficjalny@gmail.com>
References: <20260113214104.146856-1-tomasz.pakula.oficjalny@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 14 Jan 2026 08:29:27 +0000
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

This works the same as FreeSync over PCON just without sending FreeSync
info packets (we're sending standard DisplayPort info packets) + reading
the VRR range from the HDMI Forum vendor specific data block. PCONs take
over HDMI VRR triggering.

Prefer HDMI VRR over FreeSync to reduce VRR flickering on many TVs.
FreeSync over HDMI seems to be a fallback solution and not a first-class
citizen. This especially helps VMM7100.

In case of VRRmin == 0, the selected video mode is the upper boundary.

Tested with VMM7100 and CH7218 based adapters on multiple HDMI 2.1 and
HDMI 2.0 devices. (Samsung S95B, LG C4, Sony Bravia 8, Dell AW3423DWF)

Fixes: https://gitlab.freedesktop.org/drm/amd/-/issues/4805

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
Tested-by: Bernhard Berger <bernhard.berger@gmail.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 ++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1318d88687ae..53f3c88c7cdc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -12932,6 +12932,7 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	struct dc_sink *sink;
 	struct amdgpu_device *adev = drm_to_adev(connector->dev);
 	struct amdgpu_hdmi_vsdb_info vsdb_info = {0};
+	struct drm_hdmi_vrr_cap *hdmi_vrr;
 	const struct edid *edid;
 	bool freesync_capable = false;
 	enum adaptive_sync_type as_type = ADAPTIVE_SYNC_TYPE_NONE;
@@ -13004,21 +13005,37 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 		as_type = dm_get_adaptive_sync_support_type(amdgpu_dm_connector->dc_link);
 
 	if (as_type == ADAPTIVE_SYNC_TYPE_PCON_IN_WHITELIST) {
+		hdmi_vrr = &connector->display_info.hdmi.vrr_cap;
 		i = parse_hdmi_amd_vsdb(amdgpu_dm_connector, edid, &vsdb_info);
-		if (i >= 0 && vsdb_info.freesync_supported && vsdb_info.amd_vsdb_version > 0) {
 
+		/* Prefer HDMI VRR over FreeSync */
+		if (hdmi_vrr->supported) {
+			/* VRRmax == 0 is a valid value. Selected mode is the upper boundary. */
+			u16 vrr_max = hdmi_vrr->vrr_max ? hdmi_vrr->vrr_max : 10000;
+
+			amdgpu_dm_connector->pack_sdp_v1_3 = true;
+			amdgpu_dm_connector->as_type = as_type;
+
+			amdgpu_dm_connector->min_vfreq = hdmi_vrr->vrr_min;
+			amdgpu_dm_connector->max_vfreq = vrr_max;
+
+			connector->display_info.monitor_range.min_vfreq = hdmi_vrr->vrr_min;
+			connector->display_info.monitor_range.max_vfreq = vrr_max;
+
+		} else if (i >= 0 && vsdb_info.freesync_supported && vsdb_info.amd_vsdb_version > 0) {
 			amdgpu_dm_connector->pack_sdp_v1_3 = true;
 			amdgpu_dm_connector->as_type = as_type;
 			amdgpu_dm_connector->vsdb_info = vsdb_info;
 
 			amdgpu_dm_connector->min_vfreq = vsdb_info.min_refresh_rate_hz;
 			amdgpu_dm_connector->max_vfreq = vsdb_info.max_refresh_rate_hz;
-			if (amdgpu_dm_connector->max_vfreq - amdgpu_dm_connector->min_vfreq > 10)
-				freesync_capable = true;
 
 			connector->display_info.monitor_range.min_vfreq = vsdb_info.min_refresh_rate_hz;
 			connector->display_info.monitor_range.max_vfreq = vsdb_info.max_refresh_rate_hz;
 		}
+
+		if (amdgpu_dm_connector->max_vfreq - amdgpu_dm_connector->min_vfreq > 10)
+			freesync_capable = true;
 	}
 
 update:
-- 
2.52.0

