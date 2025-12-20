Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7874E6749A
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Dec 2025 08:23:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E23410E598;
	Mon, 22 Dec 2025 08:23:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bRACLZ8S";
	dkim-atps=neutral
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD40210E1F5
 for <amd-gfx@lists.freedesktop.org>; Sat, 20 Dec 2025 11:46:55 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-b79f698aa91so57341766b.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 20 Dec 2025 03:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766231214; x=1766836014; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hLaocZC4NvxtPqMjK5we9d8bEcoDqJs24P0yOjcLJPA=;
 b=bRACLZ8Stn5CX5yaL/PAXlPE9RLrks8s/sWdbNM8Fh1Ddz/jA2PMuu/rXYuDl2FPGu
 /RtVbB0NLkoQSjSzcwZSUt6oKvf1UuE44bCDDcp4751Hxy6EQYSC9EeCsM/EJqGsmWpX
 83DnHrCXhmM56DU7Rfq8zPQNSJxsYmTwgR5jrwNH9dqu9Vmc5qIRNRwIn+NEypUsLNYS
 OsdxBq36sdIGNgAbE454A21Rv+s0CkzYhCIBtkFPc7JiE+leUc1ehEpqaiqbKSpCEkIO
 mq28giJ56Nhp7/OGBea3eYGPW+DvxsLPBhl1B7zCWGU+LwM3CqjsGuOAE83J23G2jvF+
 80nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766231214; x=1766836014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hLaocZC4NvxtPqMjK5we9d8bEcoDqJs24P0yOjcLJPA=;
 b=cq3XwBZlgYCURzuDBMPB+5rKNko/otqYLv9bn2UNsdVxSVYoqAz4JHN3187e3DoybZ
 n06T8DciADOun1CWSK83t0NxLg66riDHfAzwSLyWViVvpX/qE/O8hrl4DKCtTRuzq601
 ommNCLUznUqm89Pjhq6ueFGNKjsB+CaCpK91HgrmDvHPpBGmT01cv2Y/C7jNLdgnRg2w
 zYYAXEZrKpuUhugbYPCLyFsRRwX30hepnN39Qul6A+SM9lQFQxNyLxFfPWFgrGMcg3AC
 KGeN6DRWH7x7LY5tOYO173Nm+Z/EtBe1M7QX/RpXNG9GmLTH/l0Qrc28hpIvCOfcsr/u
 Tpxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxN2Nrx/8UeEmlCKnryAD/0g6VPfWY2PQV6fgZIzFLoa4qTvANZuy8kecKWXgB/JbVo2ZwcKjn@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxfKR5PDe0PtclOEasi6UPrP71+swxT7NOAUtEYQbCAb3iHDTlB
 0L7ZE3Tqdk2FCxtd48zACXJYAyKShzhPYXCqS4Dr5UAxVQ3fUejFWu55
X-Gm-Gg: AY/fxX4/TtUfN4eCU8YsDOmOK7JcCYVbgCMduvAs0lAGPmDNoIYLXhOU51oWl2sLLrV
 QRztgo+GNzUao6Drm3hDogJChSe6Z5hWMp/LZvbSIMuUMUFoSvf+eIzVksYsj6CUSVsORP+4Nop
 4ZFtY4LRhPtu616tZxzvfT/RKTRKDcptqC3Nht4YwBNp47Q1aPLDDp/hkm+i6xHHsk9XyvjRd80
 7ZPY2wedR57Eqz1xzYN6/JrVMfqhe0uXLphqU/XcpMsWzFixPEiGFigRqbO7KGzQcc+X81q0GWC
 WSMsIuqbX3FZ1yzAQX5n3znEapxFdYVPHHu+8gLc9w9ltAkm+6oWSD4FbL+epQuqlUyo7i50sGV
 iZwU/4kPjTU52A+IRBbUayyBDsdFE4JEDh8Zd0hsgfCJIc/xLLuYI+jGMYkdm3mhwP+C6IOk+wg
 jXMBeQJIfys4GUYIxZDXsBQKZ/cgPfK6W3NNp3O1pPFJE2oyUW1jaFXjsDh+H6j9dn
X-Google-Smtp-Source: AGHT+IGbYX0x/ELOzTU4jh/PMYfc1b2VbALIo6/OkfIB9jSswCMXM4Yr+hxtbcG4AVIMOuxe7PQpcA==
X-Received: by 2002:a17:907:961e:b0:b7f:fa04:faea with SMTP id
 a640c23a62f3a-b8037269daemr356204466b.4.1766231214269; 
 Sat, 20 Dec 2025 03:46:54 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037a5bdb9sm495449066b.7.2025.12.20.03.46.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Dec 2025 03:46:54 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, harry.wentland@amd.com, sunpeng.li@amd.com,
 siqueira@igalia.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 bernhard.berger@gmail.com
Subject: [PATCH 1/4] drm/edid: parse HDMI ALLM info
Date: Sat, 20 Dec 2025 12:46:46 +0100
Message-ID: <20251220114649.169147-2-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251220114649.169147-1-tomasz.pakula.oficjalny@gmail.com>
References: <20251220114649.169147-1-tomasz.pakula.oficjalny@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 22 Dec 2025 08:23:36 +0000
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

This allows us to understand if a TV supports ALLM and gpu drivers can
use this to trigger ALLM when they so desire.

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
Tested-by: Bernhard Berger <bernhard.berger@gmail.com>
---
 drivers/gpu/drm/drm_edid.c  | 5 +++++
 include/drm/drm_connector.h | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index e2e85345aa9a..bb6cee249749 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -6274,6 +6274,8 @@ static void drm_parse_hdmi_forum_scds(struct drm_connector *connector,
 	}
 
 	drm_parse_ycbcr420_deep_color_info(connector, hf_scds);
+	if (cea_db_payload_len(hf_scds) >= 8 && hf_scds[8])
+		hdmi->allm_supported = hf_scds[8] & DRM_EDID_ALLM;
 
 	if (cea_db_payload_len(hf_scds) >= 11 && hf_scds[11]) {
 		drm_parse_dsc_info(hdmi_dsc, hf_scds);
@@ -6284,6 +6286,9 @@ static void drm_parse_hdmi_forum_scds(struct drm_connector *connector,
 		    "[CONNECTOR:%d:%s] HF-VSDB: max TMDS clock: %d KHz, HDMI 2.1 support: %s, DSC 1.2 support: %s\n",
 		    connector->base.id, connector->name,
 		    max_tmds_clock, str_yes_no(max_frl_rate), str_yes_no(dsc_support));
+	drm_dbg_kms(connector->dev,
+		"[CONNECTOR:%d:%s] ALLM support: %s\n",
+		connector->base.id, connector->name, str_yes_no(hdmi->allm_supported));
 }
 
 static void drm_parse_hdmi_deep_color_info(struct drm_connector *connector,
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 8f34f4b8183d..ac84884a96a5 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -330,6 +330,9 @@ struct drm_hdmi_info {
 	/** @max_lanes: supported by sink */
 	u8 max_lanes;
 
+	/** @allm_supported: flag for auto low latency mode support by sink */
+	bool allm_supported;
+
 	/** @dsc_cap: DSC capabilities of the sink */
 	struct drm_hdmi_dsc_cap dsc_cap;
 };
-- 
2.52.0

