Return-Path: <SRS0=UzQs=3M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D704DC2D0DB
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jan 2020 17:05:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA9E221569
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jan 2020 17:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t9j+WpA3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA9E221569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C1576E0FA;
	Thu, 23 Jan 2020 17:05:59 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30FF56E0FA
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jan 2020 17:05:58 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id w8so2986254qts.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jan 2020 09:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Lfsg+E38fen8LkCjtNI12VPr90+9rK5ecTQ+vKtbCq8=;
 b=t9j+WpA3rlNVcEbiaHOlgxoL4GfVv4b5EJHKY6EwTNx/baB6/kImrGIrJNHyiyTIIX
 mHVn/gU45WMVYxKClMPxrypagDevG5oKw3nvCeUk1mYvJUijLVkg6z9Qre9BEPweyed6
 0uwziVHK+j+cnz4sSJhyd/ea6sPDz7zo5YHEfoaV2mAjU71SgFdRSIgR3FTFDH4oWnBG
 TOdoJGsxzF8n+QZNm/YwTIj0l0EOOnQpcl2Gn3veco+YSoXZAeFMOLHneNCO3RiD3Qab
 Z0ZcG2lnZA/X9PozXnzuJDef9iD2DQ3wQbrMaK2xG8LKPs7Yq1DknfJTAbikgHfe5gBC
 JQ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Lfsg+E38fen8LkCjtNI12VPr90+9rK5ecTQ+vKtbCq8=;
 b=ODEv11I3qAhtQFX8DxPjw11VNklePgNh8NUD7ukwUEl244yB2+pdq3x0psi+eNKZN2
 8kvUeB8XcZibFlVA22MbSMkz5oM3EZagSe1RvLbg8Pk8sdiYS59j3meIFFQU5Nww8k/x
 2VKNhn7LRyTbbDzQNiYYRTsMGB18a4f3pkb1k0TBEpDgKYDoNl+HFWKt80aN3gL2aGOb
 l1sskY4a7/aVxtXs6kbCOlF3zt3ZPJbTG5fiJqbNKqKAbX2E0bGbDGtJ19dd8ukhvjF2
 WxoAuxcbCsslL971KN/bwXzkwVmTKwhwHUoWZKeMgACHAWCepvADj7rW4NCcTAOV2NUS
 FM3Q==
X-Gm-Message-State: APjAAAUPWW3sxPJDh/184xM1pmKOUQ6u3zB65/97/sXkqYfubZXFgVUw
 wtiMUt7AIOQWy7PzjCrPOmmPxlbN
X-Google-Smtp-Source: APXvYqxF1P+RBuJnJ/COvObTx6PCztPVw5s2agcI/0TuIC0LlY3Xev8MUyPB3pwJitpXP3j5JR3npQ==
X-Received: by 2002:ac8:24c1:: with SMTP id t1mr17198256qtt.257.1579799157063; 
 Thu, 23 Jan 2020 09:05:57 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id d9sm1202507qth.34.2020.01.23.09.05.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2020 09:05:56 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: attempt to enable gfxoff on more raven1
 boards (v2)
Date: Thu, 23 Jan 2020 12:05:48 -0500
Message-Id: <20200123170549.4179-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
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

Switch to a blacklist so we can disable specific boards
that are problematic.

v2: make the blacklist non-raven specific.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 44 ++++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 33e851ad4943..67ea6a9e13d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1162,18 +1162,54 @@ static void gfx_v9_0_check_fw_write_wait(struct amdgpu_device *adev)
 	}
 }
 
+struct amdgpu_gfxoff_quirk {
+	u16 chip_vendor;
+	u16 chip_device;
+	u16 subsys_vendor;
+	u16 subsys_device;
+	u8 revision;
+};
+
+static const struct amdgpu_gfxoff_quirk amdgpu_gfxoff_quirk_list[] = {
+	/* https://bugzilla.kernel.org/show_bug.cgi?id=204689 */
+	{ 0x1002, 0x15dd, 0x1002, 0x15dd, 0xc8 },
+	{ 0, 0, 0, 0, 0 },
+};
+
+static bool gfx_v9_0_should_disable_gfxoff(struct pci_dev *pdev)
+{
+	const struct amdgpu_gfxoff_quirk *p = amdgpu_gfxoff_quirk_list;
+
+	while (p && p->chip_device != 0) {
+		if (pdev->vendor == p->chip_vendor &&
+		    pdev->device == p->chip_device &&
+		    pdev->subsystem_vendor == p->subsys_vendor &&
+		    pdev->subsystem_device == p->subsys_device &&
+		    pdev->revision == p->revision) {
+			return true;
+		}
+		++p;
+	}
+	return false;
+}
+
 static void gfx_v9_0_check_if_need_gfxoff(struct amdgpu_device *adev)
 {
+	if (gfx_v9_0_should_disable_gfxoff(adev->pdev))
+		adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
+
 	switch (adev->asic_type) {
 	case CHIP_VEGA10:
 	case CHIP_VEGA12:
 	case CHIP_VEGA20:
 		break;
 	case CHIP_RAVEN:
-		if (!(adev->rev_id >= 0x8 ||
-		      adev->pdev->device == 0x15d8) &&
-		    (adev->pm.fw_version < 0x41e2b || /* not raven1 fresh */
-		     !adev->gfx.rlc.is_rlc_v2_1)) /* without rlc save restore ucodes */
+		if (!(adev->rev_id >= 0x8 || adev->pdev->device == 0x15d8) &&
+		    ((adev->gfx.rlc_fw_version != 106 &&
+		      adev->gfx.rlc_fw_version < 531) ||
+		     (adev->gfx.rlc_fw_version == 53815) ||
+		     (adev->gfx.rlc_feature_version < 1) ||
+		     !adev->gfx.rlc.is_rlc_v2_1))
 			adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
 
 		if (adev->pm.pp_feature & PP_GFXOFF_MASK)
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
