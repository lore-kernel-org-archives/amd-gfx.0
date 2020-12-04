Return-Path: <SRS0=65vk=FI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EC3C433FE
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 14:30:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F39BD22B2E
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 14:30:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F39BD22B2E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DEBB6E188;
	Fri,  4 Dec 2020 14:30:33 +0000 (UTC)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47B0B6E188
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Dec 2020 14:30:32 +0000 (UTC)
Received: by mail-qv1-xf44.google.com with SMTP id 62so2797596qva.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Dec 2020 06:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=me1hoNMZRnf4ECkDBYmvsy5PAi+5v4xVEolL2FJNbXg=;
 b=cLNJFpBTxSHqyC6npdScvvwCN1M7dEQnhcAM1rjAy4rN7f2nIcBzO5ZW/l+jMK1zRJ
 MPXcoVN+bFq/L5D8N0oo3PIGBgvdhq6JDNniCSk9ukFThiFFTGTJBqxQDO0dUFwRfxjp
 Sw5SNlLruqnbNVyZfxG0IGqeaNU0S1U0sg6pedTKtfEkvHmWYF2OA93/FDaA45IIxR5K
 ewDwWZOs9anGvBk72g4tEBaDAL4fQZJSR0GdEnlBc/L7SKQCjdORjUm0a5nGTu3NOiYW
 YCrliWXwM8qFNRji4qz7x3C3lOW4M5FR8SZjQGOXFA90IxcaHAk9UgpgGJh1TbCQ8PjI
 ry6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=me1hoNMZRnf4ECkDBYmvsy5PAi+5v4xVEolL2FJNbXg=;
 b=mtWDsBc0w5ixGpo3oSVhPPcVVNoqkOvrs5La8cZ6nKcGZJsB43jsI/KnYJyjrBsX/V
 MUVStHU/OhZOiU6P+20WGH579hdv7mKs0KmjT79/lxPBboZaKA93jXqCqPB04BhZ5AuY
 yQajDbg8xq8GaLuEX9rDlGq6nP+TptUhEyZH4OwSmbAzozo8Mi791Y6MgGDN6rbaszZr
 MC+KbRJkqHasgnsWuo9aCVzOUJEdR1D6xhkDG+NdyQJWakriN4TLpjL3LT4+pCqX/vbh
 Qq4t0QOw3onfTqPtQJRQZRrgpHSV2NBvxSLpBUso63p7cyNFV6Wu66ITzjFYaQua3ash
 owkA==
X-Gm-Message-State: AOAM5327GaCbTiBwq9AJsoEuiK4aW/zxZBef7k1zD+4bjvNUHKb0UCE2
 i5psazWSU/guzvi0+eUgZvVTexQHeZ4=
X-Google-Smtp-Source: ABdhPJwlLTuSYt4SvZrnK88KVnV0IUoiA1Acf/OcPo7iTnptxb0o/v57ygnqV7HlL+Cff8cpC8C3rQ==
X-Received: by 2002:a05:6214:2cf:: with SMTP id
 g15mr5606406qvu.7.1607092231343; 
 Fri, 04 Dec 2020 06:30:31 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.5])
 by smtp.gmail.com with ESMTPSA id y56sm5088806qth.54.2020.12.04.06.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Dec 2020 06:30:30 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/disply: set num_crtc earlier
Date: Fri,  4 Dec 2020 09:30:24 -0500
Message-Id: <20201204143024.16465-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To avoid a recently added warning:
 Bogus possible_crtcs: [ENCODER:65:TMDS-65] possible_crtcs=0xf (full crtc mask=0x7)
 WARNING: CPU: 3 PID: 439 at drivers/gpu/drm/drm_mode_config.c:617 drm_mode_config_validate+0x178/0x200 [drm]
In this case the warning is harmless, but confusing to users.

Bug: https://bugzilla.kernel.org/show_bug.cgi?id=209123
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 313501cc39fc..1ec57bc798e2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1130,9 +1130,6 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		goto error;
 	}
 
-	/* Update the actual used number of crtc */
-	adev->mode_info.num_crtc = adev->dm.display_indexes_num;
-
 	/* create fake encoders for MST */
 	dm_dp_create_fake_mst_encoders(adev);
 
@@ -3364,6 +3361,10 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 	enum dc_connection_type new_connection_type = dc_connection_none;
 	const struct dc_plane_cap *plane;
 
+	dm->display_indexes_num = dm->dc->caps.max_streams;
+	/* Update the actual used number of crtc */
+	adev->mode_info.num_crtc = adev->dm.display_indexes_num;
+
 	link_cnt = dm->dc->caps.max_links;
 	if (amdgpu_dm_mode_config_init(dm->adev)) {
 		DRM_ERROR("DM: Failed to initialize mode config\n");
@@ -3425,8 +3426,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 			goto fail;
 		}
 
-	dm->display_indexes_num = dm->dc->caps.max_streams;
-
 	/* loops over all connectors on the board */
 	for (i = 0; i < link_cnt; i++) {
 		struct dc_link *link = NULL;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
