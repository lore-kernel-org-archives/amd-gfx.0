Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60924E83EF6
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 08:10:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B8C710E4C2;
	Wed,  4 Feb 2026 08:10:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TO+ZzsLa";
	dkim-atps=neutral
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1269910E75C
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 18:56:50 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-b8864618c99so61962066b.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Feb 2026 10:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770145008; x=1770749808; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uzW7AW51HsUGJKWqzdZ3dl0YJS+mvGm7coF5xMofNf0=;
 b=TO+ZzsLa2NH2cKSqmb3Yq9WBwnZZb7y2f3kdEm+D32sje9uq/DvwicgDM6TJM5YPxR
 jcit34sciz4Mz66ZLFAxbzcmPOWo1sqxPWNsLvQsWy+fQGwBp/wHf3FDJisRzPbSBz9x
 voivlNDnxg//4y78J/LaP4mNBGEuHKGZJWrKGTZJXa0daSmmI0XSszzvZ6HiMI6Ds0H/
 +wMpqBP9WdQAWhlnN24rp/pwGHrZQW+jyb4JtpmPnfaA2ThfddgI2reHj4RCyHGJsuvy
 23yIx8hHxfOvuNUst5c6Gg0n2SwAdFPr1PuDkTeoUbgCy8gtgODNrz9DBKjVkokgh5FI
 agmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770145008; x=1770749808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uzW7AW51HsUGJKWqzdZ3dl0YJS+mvGm7coF5xMofNf0=;
 b=b0OXP2mJYjQskkh1BrMCyvAh8CAMgsj1iYG+GgL/F8azR8Z24kVSC30qgDnsiAXyGh
 6nunsw96/OyT0YwL30IqwYqaFlULUdsk9bDqKYPkSNj0PsH2Xtt7chr17hzusMTHeBY8
 ARXkJxOmh/O440SEF0lRndUXZyjxTrXFreDHIBttntlpUTE9Yd725e9hkFL3Ek6CZI0C
 0+UMAx8k1RkPmDbvQ6GtWqasjHlP5mn/0BtI2fBLBCNYzqqXnTJKRgBJ4G9YLRRdiLR3
 E4nVR7CFXZNqTWDsX8mDv+uFWwN9MiNmTpMqX3jXzQ8lj7mpaZiRwMHSLVRJf9CQU560
 cpEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3fpf657qKH8jGyaJc0DpmcA+OwROAbKyt7V4dcv0RcERKonwbZ3lGiYI4MkInNDpmIMr9vqDJ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzzGJoaKqm2nqIKWesUpF4++gI/ee76ysUxf9myd8WvqvpVQATi
 yl6/rN5EyVQQ1m9qyQjxf0ADCfOHA8QnsNu52fmV1fxP2HIPEuh4yYb8
X-Gm-Gg: AZuq6aLFUGNl/ViAlxGOEnGpcsTSC/loAmPjGlkN/Kp/EvBeH3zGF/BCLcbX7WTssxK
 kYuX0qEnHBYZmgV0Z+qUq21fALiYIU57kPIbavDO+EhtF5JuO8eS2tHx2djqwWmnyHFaIrS+46T
 ToxgI+uoTir5IJBxr7gShcToLgftrq5SXkyJncXrhq7WyyK+bLaWgDYX9GlHYzp9ZR3CD/JhpLq
 gQgU1ocmyc+AYxyjW2x9IfRUffA5uptyAAK7jfl+WfH1OYwe9XgWPVprDq4qp0o1Zk4HORCzuoh
 CdMwvwwwLtIiWfiZUjGjc+Mxy3vNcVj26lJRjHrKbMBdHMvhElAvrGZZAvzCyaENYktFJPK39s6
 UBA+r2evoeqCnFmVcje8PfpE9x2TFCpOsEqub7SrLisBzxR53CPe8SLG+ulVu2HpEvpn0GU4sby
 Y8m7lcfnsmOwOgIzqXoVrNGfoHN9+3e0qq2wTuz3ymc7r5/QzpFhrAC6XmJTyt+v1b
X-Received: by 2002:a17:906:9f85:b0:b87:2681:f608 with SMTP id
 a640c23a62f3a-b8e9f644b9bmr16665166b.8.1770145008412; 
 Tue, 03 Feb 2026 10:56:48 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8e9fad97a7sm16715766b.0.2026.02.03.10.56.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 10:56:48 -0800 (PST)
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
Subject: [PATCH v3 13/19] drm/amd/display: Save HDMI gaming info to edid caps
Date: Tue,  3 Feb 2026 19:56:20 +0100
Message-ID: <20260203185626.55428-14-tomasz.pakula.oficjalny@gmail.com>
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
We need info about these features in parts of the driver where fishing
for drm_connector struct is infeasible.

[How]
Add three new fields to dc_edid_caps and fill them if connected device
is HDMI based on it's EDID

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 7 ++++++-
 drivers/gpu/drm/amd/display/dc/dc_types.h                 | 7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 690558584a0f..c24476182fdf 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -137,7 +137,12 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 				  edid_caps->display_name,
 				  AUDIO_INFO_DISPLAY_NAME_SIZE_IN_CHARS);
 
-	edid_caps->edid_hdmi = connector->display_info.is_hdmi;
+	if (connector->display_info.is_hdmi) {
+		edid_caps->edid_hdmi = true;
+		edid_caps->allm = connector->display_info.hdmi.allm;
+		edid_caps->fva = connector->display_info.hdmi.vrr_cap.fva;
+		edid_caps->hdmi_vrr = connector->display_info.hdmi.vrr_cap.supported;
+	}
 
 	if (edid_caps->edid_hdmi)
 		populate_hdmi_info_from_connector(&connector->display_info.hdmi, edid_caps);
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 0e953059ff6d..f9f108db1734 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -210,9 +210,14 @@ struct dc_edid_caps {
 
 	uint32_t max_tmds_clk_mhz;
 
-	/*HDMI 2.0 caps*/
+	/* HDMI 2.0 caps */
 	bool lte_340mcsc_scramble;
 
+	/* HDMI 2.1 caps */
+	bool allm;
+	bool fva;
+	bool hdmi_vrr;
+
 	bool edid_hdmi;
 	bool hdr_supported;
 	bool rr_capable;
-- 
2.52.0

