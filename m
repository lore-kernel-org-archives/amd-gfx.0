Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F079C88E71
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 08:09:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D397A10E3CB;
	Mon, 26 Jan 2026 08:09:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QX2T99U/";
	dkim-atps=neutral
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C53C110E378
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Jan 2026 18:39:35 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-6505d1420daso572321a12.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Jan 2026 10:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769366374; x=1769971174; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uzW7AW51HsUGJKWqzdZ3dl0YJS+mvGm7coF5xMofNf0=;
 b=QX2T99U/fOWs4f5/QnqVPcCLxijIMlK95hUbvyaLlOHfsBPMpFPFys2mwjYdiHCHnw
 HnJTE4IMYUlBrmbn2yoppRTC42IiSn78SCWI13dHWUZzzj5WKXlA2JMjbbh69VhzlxFw
 UCrVK11o3p9X0CFrC+i42VI0WZQ3w0D2Ne2HvdySuNReVROStzAORXFu0DVRMp36Ez1Y
 kSN0AqQyTldx2GUf/XgjbCJgJG7Qw1SUOrtx/8UbDsCiJEU0Dw9Tz0iEkKxuug66dOwb
 bIGFReKdFl3ARcfoK1leuDAeoOJQDdRFR4YSzdgRbsG+vwW4pTfv6y5ivfSu4rd44z2I
 7alA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769366374; x=1769971174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uzW7AW51HsUGJKWqzdZ3dl0YJS+mvGm7coF5xMofNf0=;
 b=El3toDDRv2x9XyTnyERe/91CqH5SUWtOkIbd1LAD6TPadUco92Dp1e/sTzD2/GA+5l
 K21VulBIR80W98y9wFf19eG5mtXzoRSOlS+fZSNqkqHbuu5vNwA6uqMCnWxtLJZXiVZ/
 ahCmsNO6x4zsxG55fNOFg6fVONOnG9SqbQuqpEKnNa8UebfUl7HRUTzPjB10T2VWxBlq
 4bUZu3PEyXettr5oETAZ03Mx+TeamqPypeoAvKTHyVVDzV/D5GB6oTB6vC94F3OExVcw
 6nWfcNpyMVrzkC6LcjZy556U2kbkK22nkErsIpKoofZ1oURaAr7w2G+QiBn2CMruOZ+B
 finw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKL5wjEICjjkvjZ3qVCoBzw3Sx9CcLglLd15o/O89RgLTmDm8YvFDFJoI3YmgvGPrWIVRQTx6L@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzUInrHfloUXq1B26H0e2O/ow+Cq/C/bjynqY97nNvop8KLU2Ty
 5RbhUpdxtmBeAd14cRf12kb55AgBH9FOJ+CgHxOb2e1ywMhzs3+O38eP
X-Gm-Gg: AZuq6aIgeW1cT3ClQS+j4IGOaUgfVw7PUnPpgz9Iol3X4NMLVfKedD6cac7GusLgFoB
 n5hyRyx1OnLH1mLIr6Hk3HdANvtfQo7n2obHWqqMY28x28B/GS6TS+vqmg0g13avlO5Z7BU0Rlk
 br+yf2oFWyizBZJfXDos/dGncLviVs5jf6UIP0Pc6bUZf34JfUKL07wW8wfixHuWbYnJgOYDTkx
 HsN5Ai6KiwsJfzT8EM/lEFkdERIv6ik8EYMdG57G2KRTTr9Tsz/Wpo6VL8xWPHsCRZGWrkGivBt
 Z4s6TVLgw/mAL8DweIsrcfpLoEDnJMuYYiO+bbJCLaoDa74fBo2VVN9po2gZqQ4l+lO1c8FWwlF
 UHUAetRo6pDvYMDYvcLAylA7HPrnHnQo7fvJJYijGpkMg2XocEWGwzNmgQdWLCaVX7ZeRFRZYRA
 6fSoqStMl8UctNg+WcOlfVF7O77vIg3saXJEyekQxzqbOeiiSaUF65iFL1filO4CowmKuxcHavF
 ek=
X-Received: by 2002:a17:906:c110:b0:b88:45e8:cbac with SMTP id
 a640c23a62f3a-b8d4f7197f6mr85434266b.6.1769366374187; 
 Sun, 25 Jan 2026 10:39:34 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b885b3dad3asm499133766b.12.2026.01.25.10.39.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 10:39:33 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com, michel.daenzer@mailbox.org, daniel@fooishbar.org
Subject: [PATCH v2 13/19] drm/amd/display: Save HDMI gaming info to edid caps
Date: Sun, 25 Jan 2026 19:39:08 +0100
Message-ID: <20260125183914.459228-14-tomasz.pakula.oficjalny@gmail.com>
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

