Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CDF2FF8868
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 11:41:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3282310EB20;
	Tue, 28 Apr 2026 11:41:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="creKIdfJ";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 538C610EB21
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 11:40:58 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4891c00e7aeso86368035e9.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 04:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777376457; x=1777981257; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k9znm/Hx+qgO3TCVZIvNRzqBAOrjfULJb7WpuY3j6cM=;
 b=creKIdfJmwdDgKJ3uBuV6DfLiHf+ja5IW4GDmTNeiIdyhLFcOQTC/I9kc3ypdfn70v
 ZqB8QxfdXiB9z3EheYzDfvV7DkZM2TzTudNH2lhEGlCHsG4Ie0Rk1KkuTCxBQZZ8LwKM
 AkjX3fjGtKA5HAgsGX8OJYS/o8exhoXK649D9gUiRsExAjMc1Q9Vl0A5ffZ6PbuShPb/
 JJobQcWXzlhiXBjru5lp6jQ3JDkyi28Miry1xZc6mJvjx2crIE/F5n7bSV9ZUsTz2j8V
 7zCQlP0hxCPd28zyk+D2iSI9kUE6k2Itg5hU1DVFmpsT/TKjcibbS0h0ykiq86eh8x/U
 DAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777376457; x=1777981257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k9znm/Hx+qgO3TCVZIvNRzqBAOrjfULJb7WpuY3j6cM=;
 b=tAVTkz/PZne/XAuo0sTn1Tr36MRTP++YhcS/PVlAhvImEUHlzg8X6Q+ESo1ckhWcQ0
 Mo0E6/Il1N6/0m+tqZ16mKcLWlQzZNb8lPpKgNp0v+juf4h1S3KM2swqw+eQkhrDoAFI
 DjwbRR8LmIx5fMF8Q85ZteU9KRgIm8YESFI7qBI41tkPd96CHG4Fwpicia06h5i9hxDi
 C6k2h7ClorFkzbHPhe0b9R1S+BWPXvKFmFDdffWGaJJB9s5blj8RcH9AbbmZIOizy29N
 1qS9SHue+k2YQdBNUSyoOWe3wieJdRKqPrF+6p3G3Mvatn7IIslr/H6oijKivxPdPhMd
 aAkQ==
X-Gm-Message-State: AOJu0Yye8vcabRo6yCYisi0n9ZRN1ojaGRO0yfC4KSJdgiZL0Ad99TZq
 /CKcYn8Tnq3fdF3GXeyFyuvBba2uNrYtkFRxnoTrFKc5R+CUKpWQjMmW2E4874GF
X-Gm-Gg: AeBDietPL/Gz4ZX1u3BwM6yb7vtrBYWUF/mctV4Lo8xL5+FqSjpdNHjN52HBKOoX1++
 QIs6hdPuLDgj4otEuAG4EwdZi/BaIAGj8hzHMyiD+rhZM1idi2vqpVdn9NEACpzsgIszfMMQ58o
 INkcyPIz1lcAjkWs6TbZgGDm6MfqvSHsQdsWb6FWg4EbaUAbSEX2v1kw7n3S05hO0R8IyKtyIu1
 7hV9r0mb+mEJAetjMlpmhlmRqnlmk7gDJ+MjMCvGA5kSSSE8f76HViThzrHGQyn5KjWPIyJlrgc
 LsUE1iqCMN8Dd9tMvKkVe95Pu8age8+sfVCLneSJc/XLe1mkR1Lltc+XJWWZabLxcQMkzCB0fly
 cSQVraWGA34+3jvbVEdAK/e+bMVzwBebLcD2Ss8C/Z2CT+593SUP59h8/B8oTS5kETTFnqF4KGz
 Vh3XhHQ3qqRMQKFk4FOybxpjZmNPAcu8iu/0jM/IXyVfsGAka54vbX0y984Rfj1rtoNVPvojHwW
 /sq
X-Received: by 2002:a05:600c:c114:b0:487:1108:48b8 with SMTP id
 5b1f17b1804b1-48a77af3d5bmr33879355e9.2.1777376456798; 
 Tue, 28 Apr 2026 04:40:56 -0700 (PDT)
Received: from Timur-Hyperion.home (5401DFC2.dsl.pool.telekom.hu.
 [84.1.223.194]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a775e4bd0sm25048275e9.8.2026.04.28.04.40.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 04:40:55 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Melissa Wen <mwen@igalia.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 6/6] drm/amd/display: Use EDID from VBIOS embedded panel info
Date: Tue, 28 Apr 2026 13:40:45 +0200
Message-ID: <20260428114045.40710-7-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428114045.40710-1-timur.kristof@gmail.com>
References: <20260428114045.40710-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

When an embedded panel has no DDC, read the EDID from
the VBIOS embedded panel info and use that.

Fixes: 7c7f5b15be65 ("drm/amd/display: Refactor edid read.")
Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/5192
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index c53230cdfdc57..c491af21a34c6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -1032,6 +1032,45 @@ dm_helpers_read_acpi_edid(struct amdgpu_dm_connector *aconnector)
 	return drm_edid_read_custom(connector, dm_helpers_probe_acpi_edid, connector);
 }
 
+static const struct drm_edid *
+dm_helpers_read_vbios_hardcoded_edid(struct dc_link *link, struct amdgpu_dm_connector *aconnector)
+{
+	struct dc_bios *bios = link->ctx->dc_bios;
+	struct embedded_panel_info info;
+	const struct drm_edid *edid;
+	enum bp_result r;
+
+	if (!dc_is_embedded_signal(link->connector_signal) ||
+	    !bios->funcs->get_embedded_panel_info)
+		return NULL;
+
+	memset(&info, 0, sizeof(info));
+	r = bios->funcs->get_embedded_panel_info(bios, &info);
+
+	if (r != BP_RESULT_OK) {
+		dm_error("Error when reading embedded panel info: %u\n", r);
+		return NULL;
+	}
+
+	if (!info.fake_edid || !info.fake_edid_size) {
+		dm_error("Embedded panel info doesn't contain an EDID\n");
+		return NULL;
+	}
+
+	edid = drm_edid_alloc(info.fake_edid, info.fake_edid_size);
+
+	if (!drm_edid_valid(edid)) {
+		dm_error("EDID from embedded panel info is invalid\n");
+		drm_edid_free(edid);
+		return NULL;
+	}
+
+	aconnector->base.display_info.width_mm = info.panel_width_mm;
+	aconnector->base.display_info.height_mm = info.panel_height_mm;
+
+	return edid;
+}
+
 void populate_hdmi_info_from_connector(struct drm_hdmi_info *hdmi, struct dc_edid_caps *edid_caps)
 {
 	edid_caps->scdc_present = hdmi->scdc.supported;
@@ -1052,6 +1091,9 @@ enum dc_edid_status dm_helpers_read_local_edid(
 
 	if (link->aux_mode)
 		ddc = &aconnector->dm_dp_aux.aux.ddc;
+	else if (link->ddc_hw_inst == GPIO_DDC_LINE_UNKNOWN &&
+		 dc_is_embedded_signal(link->connector_signal))
+		ddc = NULL;
 	else
 		ddc = &aconnector->i2c->base;
 
@@ -1065,6 +1107,8 @@ enum dc_edid_status dm_helpers_read_local_edid(
 		drm_edid = dm_helpers_read_acpi_edid(aconnector);
 		if (drm_edid)
 			drm_info(connector->dev, "Using ACPI provided EDID for %s\n", connector->name);
+		else if (!ddc)
+			drm_edid = dm_helpers_read_vbios_hardcoded_edid(link, aconnector);
 		else
 			drm_edid = drm_edid_read_ddc(connector, ddc);
 		drm_edid_connector_update(connector, drm_edid);
-- 
2.53.0

