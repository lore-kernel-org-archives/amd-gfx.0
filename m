Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD587E83EEF
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 08:10:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6228510E52A;
	Wed,  4 Feb 2026 08:10:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L7GeOq7i";
	dkim-atps=neutral
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD83310E743
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 18:56:36 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-b8719f5a2b5so69360466b.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Feb 2026 10:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770144995; x=1770749795; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Vvinyd/bDfTMBX7NZU90g5DKWFs8k0OH4aETYAERXs=;
 b=L7GeOq7ifzKP7V7dXBY4CVb5y4lq3gJz3WKjMYEo45vfmJbdzkC7ew1DX4Laq663qi
 HsUJKDpf2uXOg/fEmEnk35EPNhglwyF9LNXZCM3PIq7vmWXMliLYoZ3MoUCAK4d2uY1L
 4jFh2QZSwF1M2vOCsuZTZT1e9vWDIqf0hxViI2HsKX6SZGe0tQk5Wyhzna3CL49X0rmw
 xH5L8RY5KMoGecg6kEX8GLSvMMbzJFc/JPUKj9yghvTwbUtNuNZWXB1bU36AOYEEioNZ
 Eo8MWPphX6oecnAJPyu6w5l7eG+OqUW0MnrE+2+fjDLRbIk7g0bSupjCjAl1ZI2EhJPz
 7+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770144995; x=1770749795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3Vvinyd/bDfTMBX7NZU90g5DKWFs8k0OH4aETYAERXs=;
 b=QLY58Drt+09SFq3SAdDKcBjSzODyUHbD4NFqfZrKd8wPnZaS1ePHde9BQJpsWSibra
 SFMHNDydBb5BpM/wRC08im9kv9HXULmyRGyXIUkKTLJ9TQvpAEzzJB/cJWuyd5b303WW
 IvpMXvpmyY0gOWHx0rxXd9tLf7LiXsedqSpvmWkp7xEOYBqDAFLoUwPHEetckKrQENps
 X6seFE+RdzqRNKrxglTItwh1AEOep6UTWn021Gpw/J3aM2ggQN3CeVrRLwyLnnITQfVq
 Fz+39t1T8E9tksdnlxqsiGgMqTYxNpI6ur7Etdip5lZFzFdid8EP1Hftb3y7pdfz3wSY
 2ILg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcw9qK/Vw5RDlyJrVZH7FWNjekh6eDmkJxtaHet8/kjzwcsl1sfijNjj//jKvjDertd2k7npfN@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzfKIIE4WU78g57go5RJsdC+VspmSStlJvP3E88kNjBJivVSB2r
 G+M/uWAWAnkJceJ+Kbn1t0NxbH+RhkahXp+JMy3BqEQhwlVFeqngYIXo
X-Gm-Gg: AZuq6aLibXOEdQoZL9zaM5VjyCrPuUBT6KIRt2+ZFh803ZZ/15Vn+2RFRLi/KmgjvyW
 wk0YZSJgIgoo+Jo+u3BhUpiC3e1KAxfq3qNphesEiNEO5NYD6YN3JdK/1cizfMz47q6/tps61ic
 zmA4AnqsejIK0gkC+qDiJMF4PNK/cE0xqy/PhbXhneavAkLRxn8US/KI1n/fw3C6Gf2+LbWVKU7
 3+YsQ2XDV8uO/1VqWuvWpJ6UxkFP4tS6Hxpd8LjGZimOMze1TBFhKgvPnVSB3OVRK/L4YZs7+89
 WGJN5RZOnbsYs28NVawv6wLZQEh1IiY7IIsm8do6mxfRR3V9VWPVrlImTlXytdvMDMB46+r5iI7
 SVikBujjCunHZX++xNKHxjwrL6ob5CfT+r2g80OP8OiHmsXv8PQem9mXgxnf3qPrsJMYa7Bjpf4
 fCFxnrKBg8Vac3+LZ5kmwOWlicxIiTdnYEWOIZgN69oqzRzpKt4YIb7BK5X3wti7Kw
X-Received: by 2002:a17:907:3f08:b0:b8e:7dcb:7f23 with SMTP id
 a640c23a62f3a-b8e9ef22f6amr20457566b.2.1770144995003; 
 Tue, 03 Feb 2026 10:56:35 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8e9fad97a7sm16715766b.0.2026.02.03.10.56.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 10:56:34 -0800 (PST)
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
Subject: [PATCH v3 04/19] drm/amd/display: Use bigger VRR range if found in
 AMD vsdb
Date: Tue,  3 Feb 2026 19:56:11 +0100
Message-ID: <20260203185626.55428-5-tomasz.pakula.oficjalny@gmail.com>
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
index 856007bba4d9..284f5b326c18 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -13242,6 +13242,18 @@ static bool copy_range_to_amdgpu_connector(struct drm_connector *conn)
 	return is_freesync_capable(range);
 }
 
+/*
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
@@ -13313,6 +13325,10 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 		if (is_monitor_range_invalid(connector))
 			monitor_range_from_vsdb(&connector->display_info, &vsdb_info);
 
+		/* Use bigger range if found in AMD vsdb */
+		if (compare_ranges(connector, &vsdb_info))
+			monitor_range_from_vsdb(&connector->display_info, &vsdb_info);
+
 		if (dpcd_caps.allow_invalid_MSA_timing_param)
 			freesync_capable = copy_range_to_amdgpu_connector(connector);
 
-- 
2.52.0

