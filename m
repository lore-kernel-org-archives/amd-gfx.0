Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98453CA6009
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 08:18:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 289A510E3AC;
	Mon, 19 Jan 2026 08:18:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KUoTfDvG";
	dkim-atps=neutral
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C36510E303
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 01:11:56 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-b87677a8a96so75086266b.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Jan 2026 17:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768785115; x=1769389915; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y8+XechJIId3v9u+c/ggDmxy+XunBGz8iE7d4QwyvbM=;
 b=KUoTfDvGknsMxOSGiRA110K4piuuCMS6nYMzk7P5LVXKOwImHGtqpqRW+oIiDhCrVT
 MhyNywkK5bYpaMkzMCljCGpTc6QH0xNJNqYI80MNEHxfn+SdBlsJbzHBw6wGVMvyEMqc
 FomC+uL/74jIaUYsD4THj+sWjfyJjap3nsE8sNbvJEhU2uWJsL1iB/Jlpi3oZNvK7cf/
 9pphYUYOHN89uMTgibV3hzeG1cc09XadCCL3ROtDq3Gna+EtJSxyEtTNgYpY9M9fyzZL
 WjL0PCyabLlTuamXIHetD91ynd50ldJjc+JMF/5Pc6QPgXSzuQl6muHFbZiRSl5rk7me
 t1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768785115; x=1769389915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y8+XechJIId3v9u+c/ggDmxy+XunBGz8iE7d4QwyvbM=;
 b=Gc/9WW2OuMziqZkwIcHi/PEPCszNxxp3NFs4wqnjF55JeD6fkJep7njK/Wtjc8PVKu
 ZwVqnVuZMJKm/5g1/HCBLeUcIFF3yPrOMqRK7sFcfFiWep6WfDn7t2SEcLHoK0rgeOt+
 FRll3xgZLZPmmcJy3CFzmBatw8tzZRLSWdqcNMDs11AZkgsNo2QVIYH8W/S9dnWeZz0d
 Q+J8bVC+jkJ7xSXMZ1K4ViOyDM86oAyaY2WSs4frZPUrIH+6UcNwDMoYkNRn33XewtOk
 SBxUgZP9ll43xsRZ9OAtUDxwbqKfssVRR1W2RPQCnL3g1ZKzpZP6t6vSzc1NrtOUGEGV
 0dqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBNJ5gHYI5bYCFxWrepKz+pbZ4f0mra+Uttcie0wbnjP+1Q4jvjO9i/tmK8BPakyGC0hrkhh2V@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzFGgXKzBWgLNWNi8xBecT3JA8+EOHKCo0V9HJaYbm5m6NqUGZ0
 JuEe4Ny8RCio474vcJUr+401sp1c84e33u3tXLACZM/EiSW+UABcRGUb
X-Gm-Gg: AY/fxX7jWvtFRjtXE8o0OdW0zOE8Kf8tE0frwKTqBV7ZaQaKapm+2agVDuDkVzW1Eob
 6gbq1AD68NoISueCBZJG0LMEG8xWrwtUcTro56w/+tXN/lmVyetldp1VAaVNcOqbyS7PGesDd1P
 0A01PT+LR8fRo9+YA34quaaPAgZPkTfA6QPl9kTdvxeN+vFPEfw8Ef4H357iDd1nI1L6576rU8K
 TytvUatMLJ40DSrajB0oXGaPO7zG4I6SMRIfRexOEcz5Om9MMtCWKtnBpsohoPcx7yVFpZL7QV9
 i+MUHF+FjeqtpX5v52GUOxLQfUquNAABAjUAgac1AbnOYhGOYFBr1NEl/eSq1H5DDXDRmpDobTV
 5hcufrNCAqTgmo1mhJ0JnLbJOpP4zVC46Zdx/BuTF9O/OMHIl8FJbc7BeUGByhqVkZtUSuWQvle
 qfEY+5UuDi1pxs0QwN0oepI2uwvzHsrwXXQDHOHH8J1Hg2zPJVsEX4gKo8JUhunaJ7
X-Received: by 2002:a05:6402:5253:b0:647:9bdd:3211 with SMTP id
 4fb4d7f45d1cf-65452acc814mr4363238a12.4.1768785114650; 
 Sun, 18 Jan 2026 17:11:54 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-654535c4912sm8989806a12.30.2026.01.18.17.11.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 17:11:54 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com
Subject: [PATCH 04/17] drm/amd/display: Use bigger VRR range if found in AMD
 vsdb
Date: Mon, 19 Jan 2026 02:11:33 +0100
Message-ID: <20260119011146.62302-5-tomasz.pakula.oficjalny@gmail.com>
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
Some monitors only expose their full VRR range in AMD vsdb for some
reason.

[How]
Compare exposed ranges and use the bigger one.

This check could be merged with the previous one but it's better to keep
them separate to easily convey their meaning.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4177
Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 69f3dbfe4ca3..37ab89532408 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -13204,6 +13204,18 @@ static bool copy_range_to_amdgpu_connector(struct drm_connector *conn)
 	return is_freesync_capable(range);
 }
 
+/**
+ * Returns true if range from AMD vsdb is bigger
+ */
+static bool compare_ranges(struct drm_connector *conn,
+			   struct amdgpu_hdmi_vsdb_info *vsdb)
+{
+	struct drm_monitor_range_info *range = &conn->display_info.monitor_range;
+
+	return (vsdb->max_refresh_rate_hz - vsdb->min_refresh_rate_hz) >
+	       (range->max_vfreq - range->min_vfreq);
+}
+
 /**
  * amdgpu_dm_update_freesync_caps - Update Freesync capabilities
  *
@@ -13277,6 +13289,10 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 		if (valid_vsdb_cea && is_monitor_range_invalid(connector))
 			monitor_range_from_vsdb(connector, &vsdb_info);
 
+		/* Use bigger range if found in AMD vsdb */
+		if (valid_vsdb_cea && compare_ranges(connector, &vsdb_info))
+			monitor_range_from_vsdb(connector, &vsdb_info);
+
 		if (dpcd_caps.allow_invalid_MSA_timing_param)
 			freesync_capable = copy_range_to_amdgpu_connector(connector);
 
-- 
2.52.0

