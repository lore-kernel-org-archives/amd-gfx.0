Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47025CD98C7
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 09:51:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D306210E87C;
	Wed, 10 Jun 2026 09:51:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pkMMFMie";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011045.outbound.protection.outlook.com [52.101.62.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCF7710E87C
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 09:51:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gQuPP5GQkGRxP17careIXdpMcoB3OCZUySfzby+QA9D0wrfzIJHSMvI82N78Sc/ufGmsP6NWCwHiI0DHIEJVebWGdx0R4vucz4jUBfeE2A2QjXsnRY/cPLXE1zC99wUb3q6QAg1drdJsOkhzabiVodL+6LRYegkQ5r0jkX/c5I+da4mM5N9f9C9XCW36L6aB1mCOC8i4tttwSAvQlugCEXAI3TRJopssl4xebshoOiqNijRCWLzr2YMJy2ix4hW0RiZUhUyd4QdQNRW29zO/XofM1PiWyDc8bDyXANUKCq7qKsQi6eBEWvglYBQ9252lHHjVwZNdcnMDbCvbOc4KCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lqmcDtnkL7aP+0fxrb4YxMw7cSfFgLJ7dSl5cIaQ2z4=;
 b=QB9VLKbyh6vNf9MNNVgya6DN6nslzbljEGmpS8E1qrSlUCy5S4GQuPsnd0JgyibgoSFb70YCv2HhJx0vV6kPJ7FsBNgPNG5BqpQtNf9HhxhGVLqqUzn5P/9w7MqFNe6h/+3cZGyZI/akHONzAOQHa3jajBTjoOvM3ZToEDOmHr2NB3hx9WECse/1Y8+KnHdATnt9KAP9iC0HP5nvH7moDNlfQGrbcDRxmBJUULYxay6UUBPUkIfo2LkONy6BZlH1o9yKHc50+tje77vdGJrUvmIss6Xc77N/pgAxxEmjNhXr74R9MGLortaFsF4qGDXD3Iq8fiLFlWbk0q6hM5d+sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqmcDtnkL7aP+0fxrb4YxMw7cSfFgLJ7dSl5cIaQ2z4=;
 b=pkMMFMieg6zZHbguXRILax7MSQA54apcfZVRo1C2Q1MJzJTO+vBU5kD32LDa+62zohhwiK3c5uCojCE7glYHuAvsb3MwUXNkiyTsnOjkKDbymr/7zII0u1y5RSxeo+ZLGEV13Ve1DBkG7IR+K7VU0sP2xe8RMaiXOeVoGnrTAls=
Received: from BL1PR13CA0346.namprd13.prod.outlook.com (2603:10b6:208:2c6::21)
 by PH0PR12MB999090.namprd12.prod.outlook.com (2603:10b6:510:38c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 09:50:55 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::38) by BL1PR13CA0346.outlook.office365.com
 (2603:10b6:208:2c6::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Wed,
 10 Jun 2026 09:50:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 09:50:55 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 04:50:55 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 04:50:54 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 04:50:46 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>, Chenyu
 Chen <chen-yu.chen@amd.com>
Subject: [PATCH 19/32] drm/amd/display: Add KUnit tests for amdgpu_dm_audio
Date: Wed, 10 Jun 2026 17:45:03 +0800
Message-ID: <20260610094639.1965367-20-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610094639.1965367-1-chen-yu.chen@amd.com>
References: <20260610094639.1965367-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|PH0PR12MB999090:EE_
X-MS-Office365-Filtering-Correlation-Id: 92f92779-7a01-4787-1967-08dec6d5c41c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|18002099003|22082099003|11063799006|56012099006|5023799004|6133799003;
X-Microsoft-Antispam-Message-Info: M0bgIyTOjg4dcLXxXWGqOBemfK/6WI9qZ6FHPqEqXvqJKvWw7dVYPaf75HvHeVarkYvzqnXBOJ+8y2ZGDtxdKsnTZ6fWKfFNc62mhgImNNSfqB0+i4H2Yw1mSi9D/utOQ+xgu3fH7M082OH+hhWqRUjAM2nwEA/t9dGqXywMzDTK2q0b4Aw6RtFQcFFChvl5EldQOGipX52HtGFkRLUZsPpkXN/B09Jj9j0Y4A6XLO8IUu2g7aT9JWRVCgUAjUX3pCXx8B4aW2re2aGX3fvP9ZauXr34o7+J4ask0hihukU14HYIVEFovkpsb27/7bdB88SpuqYl3NhssNImZA3zf5L3BxnNhuoUZQmPWtdgM7cg/vbKJe90eNEi8Mb75UZY+3oCM1okElDeQQ5Fw8iH8vDcBbbXVzEb3wSK7ndd5XLS6Z0ARNBWKZtoioi86LGFRdrG+djzS3WlpZGBlD1tfMuvnE6UUDxkz7KlfT78/EbceC6AmaoCAAPPLinBCHvA5bDuaO/Bf//72E82/3weM/ce2drgvuVWYl0R6vHIzpF2IK8n6XCKGb5n9xSbwP8bkFJNmufJfMqPx+AqRiRwRbjAceNg1ld9BTTN3MyEhZRHT185lQpFL5G2IseWyxZMELbaZOjBxqmuDxG9BvnCX/E0/hYllmNwfM7PGkrg+x4KPQi+oghF9CIkqnndtLAW/sPpFTWGEeVkCKrnr7UgsaQEvCt5JQ25JYwLPJdmSB4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(18002099003)(22082099003)(11063799006)(56012099006)(5023799004)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oMhcsHFnDOtZlib8inEbZXyZAc+kTTpd3kUYpqQFzKPwplWHSRq5DgL35T5Xg5NbeN5sndBHaN1lb444FW59kQEn5he6d/lwk2VmnoclpVd8+xDgRv2illLjFx4/hHTart/0BzOwKPYU4XKdrIgUSGTID8b3eURso/MJc0hKOdroQh2+BCW9u2CEhG6s+9nKXKQ4xQizSR6No+YXU2f6xg2iPfmyydo5qfcCd77fOaurivdLazLj49P9RhBGuo/IiPfJrlf/PGhISiB+59tnE18PD9VczOrPHpG8e7QgUjOtW6iXr8GxCr2km0ON8G0sGzGtnTmbmdueUzqxEwjTTDBK65O6VSXVGSp1XstVNlYotKs3l+/EZ38Eg9oTvtD+7kalVn7z4qsrHEcpOJA2/243hXN+/Pu2pwgBZXS3OGKw8Ym4JmMJy41Ah4K5gqjP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:50:55.3261 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f92779-7a01-4787-1967-08dec6d5c41c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB999090
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

From: Alex Hung <alex.hung@amd.com>

Add KUnit tests for amdgpu_dm_audio.c.

Tests cover:
- amdgpu_dm_audio_init(): early exit when audio is disabled
- amdgpu_dm_audio_fini(): early exit when audio is not enabled
- fill_audio_info(): manufacturer and product ID propagation,
  display name copy, speaker allocation flags, CEA revision
  gating of audio mode copying (including the zero-mode case),
  and latency field propagation
- amdgpu_dm_audio_component_bind()/unbind(): component ops, device,
  and audio_component pointer are wired up on bind and cleared on
  unbind
- amdgpu_dm_audio_eld_notify(): callback is forwarded with the
  correct port and audio pointer, and the no-op guard paths for a
  missing component, audio_ops, or pin_eld_notify callback

Assisted-by: Copilot:Claude-Opus-4.8

Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_audio.c   |  27 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_audio.h   |  12 +
 .../drm/amd/display/amdgpu_dm/tests/Makefile  |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_audio_test.c    | 490 ++++++++++++++++++
 4 files changed, 527 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_audio_test.c

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c
index 70b7dbded275..1ae121387297 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c
@@ -26,6 +26,7 @@
 #include "amdgpu.h"
 #include "amdgpu_dm.h"
 #include "amdgpu_dm_audio.h"
+#include "amdgpu_dm_kunit_helpers.h"
 #include "dc.h"
 
 #include <linux/component.h>
@@ -83,7 +84,7 @@ static const struct drm_audio_component_ops amdgpu_dm_audio_component_ops = {
 	.get_eld = amdgpu_dm_audio_component_get_eld,
 };
 
-static int amdgpu_dm_audio_component_bind(struct device *kdev,
+STATIC_IFN_KUNIT int amdgpu_dm_audio_component_bind(struct device *kdev,
 				       struct device *hda_kdev, void *data)
 {
 	struct drm_device *dev = dev_get_drvdata(kdev);
@@ -96,8 +97,9 @@ static int amdgpu_dm_audio_component_bind(struct device *kdev,
 
 	return 0;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_audio_component_bind);
 
-static void amdgpu_dm_audio_component_unbind(struct device *kdev,
+STATIC_IFN_KUNIT void amdgpu_dm_audio_component_unbind(struct device *kdev,
 					  struct device *hda_kdev, void *data)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev_get_drvdata(kdev));
@@ -107,6 +109,7 @@ static void amdgpu_dm_audio_component_unbind(struct device *kdev,
 	acomp->dev = NULL;
 	adev->dm.audio_component = NULL;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_audio_component_unbind);
 
 static const struct component_ops amdgpu_dm_audio_component_bind_ops = {
 	.bind	= amdgpu_dm_audio_component_bind,
@@ -144,6 +147,7 @@ int amdgpu_dm_audio_init(struct amdgpu_device *adev)
 
 	return 0;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_audio_init);
 
 void amdgpu_dm_audio_fini(struct amdgpu_device *adev)
 {
@@ -162,8 +166,9 @@ void amdgpu_dm_audio_fini(struct amdgpu_device *adev)
 
 	adev->mode_info.audio.enabled = false;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_audio_fini);
 
-static void amdgpu_dm_audio_eld_notify(struct amdgpu_device *adev, int pin)
+STATIC_IFN_KUNIT void amdgpu_dm_audio_eld_notify(struct amdgpu_device *adev, int pin)
 {
 	struct drm_audio_component *acomp = adev->dm.audio_component;
 
@@ -174,6 +179,7 @@ static void amdgpu_dm_audio_eld_notify(struct amdgpu_device *adev, int pin)
 						 pin, -1);
 	}
 }
+EXPORT_IF_KUNIT(amdgpu_dm_audio_eld_notify);
 
 void amdgpu_dm_fill_audio_info(struct audio_info *audio_info,
 		     const struct drm_connector *drm_connector,
@@ -219,6 +225,7 @@ void amdgpu_dm_fill_audio_info(struct audio_info *audio_info,
 	/* TODO: For DP, video and audio latency should be calculated from DPCD caps */
 
 }
+EXPORT_IF_KUNIT(amdgpu_dm_fill_audio_info);
 
 void amdgpu_dm_commit_audio(struct drm_device *dev,
 			    struct drm_atomic_state *state)
@@ -300,3 +307,17 @@ void amdgpu_dm_commit_audio(struct drm_device *dev,
 		amdgpu_dm_audio_eld_notify(adev, inst);
 	}
 }
+
+#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+int amdgpu_dm_audio_get_param(void)
+{
+	return amdgpu_audio;
+}
+EXPORT_IF_KUNIT(amdgpu_dm_audio_get_param);
+
+void amdgpu_dm_audio_set_param(int val)
+{
+	amdgpu_audio = val;
+}
+EXPORT_IF_KUNIT(amdgpu_dm_audio_set_param);
+#endif
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.h
index efd412bba178..48391305c3c2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.h
@@ -41,4 +41,16 @@ void amdgpu_dm_fill_audio_info(struct audio_info *audio_info,
 		     const struct drm_connector *drm_connector,
 		     const struct dc_sink *dc_sink);
 
+#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+struct device;
+
+int amdgpu_dm_audio_component_bind(struct device *kdev,
+				   struct device *hda_kdev, void *data);
+void amdgpu_dm_audio_component_unbind(struct device *kdev,
+				      struct device *hda_kdev, void *data);
+void amdgpu_dm_audio_eld_notify(struct amdgpu_device *adev, int pin);
+int amdgpu_dm_audio_get_param(void);
+void amdgpu_dm_audio_set_param(int val);
+#endif
+
 #endif /* __AMDGPU_DM_AUDIO_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
index ddd9fce66232..5bb43b3bc439 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
@@ -13,6 +13,7 @@ ccflags-y += -I$(src)/../../../include
 
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_crc_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_hdcp_test.o
+obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_audio_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_color_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_colorop_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_backlight_test.o
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_audio_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_audio_test.c
new file mode 100644
index 000000000000..79ff5d9b3fa5
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_audio_test.c
@@ -0,0 +1,490 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * KUnit tests for amdgpu_dm_audio.c
+ *
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#include <kunit/test.h>
+
+#include <drm/drm_audio_component.h>
+
+#include "dc.h"
+#include "amdgpu.h"
+#include "amdgpu_mode.h"
+#include "amdgpu_dm.h"
+#include "amdgpu_dm_audio.h"
+
+/* Tests for amdgpu_dm_audio_init() */
+
+/**
+ * dm_test_audio_init_disabled - Test audio init exits when audio is disabled
+ * @test: The KUnit test context
+ */
+static void dm_test_audio_init_disabled(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	int saved_audio = amdgpu_dm_audio_get_param();
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	amdgpu_dm_audio_set_param(0);
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_audio_init(adev), 0);
+	KUNIT_EXPECT_FALSE(test, adev->mode_info.audio.enabled);
+	KUNIT_EXPECT_FALSE(test, adev->dm.audio_registered);
+
+	amdgpu_dm_audio_set_param(saved_audio);
+}
+
+/* Tests for amdgpu_dm_audio_fini() */
+
+/**
+ * dm_test_audio_fini_without_enabled_audio - Test fini exits when audio is not enabled
+ * @test: The KUnit test context
+ */
+static void dm_test_audio_fini_without_enabled_audio(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	int saved_audio = amdgpu_dm_audio_get_param();
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	amdgpu_dm_audio_set_param(1);
+	adev->mode_info.audio.enabled = false;
+	adev->dm.audio_registered = true;
+
+	amdgpu_dm_audio_fini(adev);
+
+	KUNIT_EXPECT_FALSE(test, adev->mode_info.audio.enabled);
+	KUNIT_EXPECT_TRUE(test, adev->dm.audio_registered);
+
+	amdgpu_dm_audio_set_param(saved_audio);
+}
+
+/* Tests for amdgpu_dm_fill_audio_info() */
+
+/**
+ * dm_test_fill_audio_info_ids_name_flags - Test Fill audio info ids name flags
+ * @test: The KUnit test context
+ */
+static void dm_test_fill_audio_info_ids_name_flags(struct kunit *test)
+{
+	struct audio_info *audio_info;
+	struct drm_connector *connector;
+	struct dc_sink *dc_sink;
+	const char *name = "DM-AUDIO-PANEL";
+
+	audio_info = kunit_kzalloc(test, sizeof(*audio_info), GFP_KERNEL);
+	connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
+	dc_sink = kunit_kzalloc(test, sizeof(*dc_sink), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, audio_info);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc_sink);
+
+	dc_sink->edid_caps.manufacturer_id = 0x1234;
+	dc_sink->edid_caps.product_id = 0xABCD;
+	dc_sink->edid_caps.speaker_flags = 0x5;
+	strscpy(dc_sink->edid_caps.display_name, name,
+		AUDIO_INFO_DISPLAY_NAME_SIZE_IN_CHARS);
+
+	connector->display_info.cea_rev = 1;
+
+	amdgpu_dm_fill_audio_info(audio_info, connector, dc_sink);
+
+	KUNIT_EXPECT_EQ(test, audio_info->manufacture_id, 0x1234U);
+	KUNIT_EXPECT_EQ(test, audio_info->product_id, 0xABCDU);
+	KUNIT_EXPECT_EQ(test, audio_info->flags.all, 0x5U);
+	KUNIT_EXPECT_STREQ(test, audio_info->display_name, name);
+}
+
+/**
+ * dm_test_fill_audio_info_cea_lt_3_skips_modes - Test Fill audio info cea lt 3 skips modes
+ * @test: The KUnit test context
+ */
+static void dm_test_fill_audio_info_cea_lt_3_skips_modes(struct kunit *test)
+{
+	struct audio_info *audio_info;
+	struct drm_connector *connector;
+	struct dc_sink *dc_sink;
+
+	audio_info = kunit_kzalloc(test, sizeof(*audio_info), GFP_KERNEL);
+	connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
+	dc_sink = kunit_kzalloc(test, sizeof(*dc_sink), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, audio_info);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc_sink);
+
+	connector->display_info.cea_rev = 2;
+	dc_sink->edid_caps.audio_mode_count = 2;
+	dc_sink->edid_caps.audio_modes[0].format_code = 1;
+	dc_sink->edid_caps.audio_modes[0].channel_count = 2;
+	dc_sink->edid_caps.audio_modes[0].sample_rate = 0x07;
+	dc_sink->edid_caps.audio_modes[0].sample_size = 16;
+
+	amdgpu_dm_fill_audio_info(audio_info, connector, dc_sink);
+
+	KUNIT_EXPECT_EQ(test, audio_info->mode_count, 0U);
+}
+
+/**
+ * dm_test_fill_audio_info_cea_ge_3_copies_modes - Test Fill audio info cea ge 3 copies modes
+ * @test: The KUnit test context
+ */
+static void dm_test_fill_audio_info_cea_ge_3_copies_modes(struct kunit *test)
+{
+	struct audio_info *audio_info;
+	struct drm_connector *connector;
+	struct dc_sink *dc_sink;
+
+	audio_info = kunit_kzalloc(test, sizeof(*audio_info), GFP_KERNEL);
+	connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
+	dc_sink = kunit_kzalloc(test, sizeof(*dc_sink), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, audio_info);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc_sink);
+
+	connector->display_info.cea_rev = 3;
+	dc_sink->edid_caps.audio_mode_count = 2;
+
+	dc_sink->edid_caps.audio_modes[0].format_code = 1;
+	dc_sink->edid_caps.audio_modes[0].channel_count = 2;
+	dc_sink->edid_caps.audio_modes[0].sample_rate = 0x07;
+	dc_sink->edid_caps.audio_modes[0].sample_size = 16;
+
+	dc_sink->edid_caps.audio_modes[1].format_code = 11;
+	dc_sink->edid_caps.audio_modes[1].channel_count = 6;
+	dc_sink->edid_caps.audio_modes[1].sample_rate = 0x1F;
+	dc_sink->edid_caps.audio_modes[1].sample_size = 24;
+
+	amdgpu_dm_fill_audio_info(audio_info, connector, dc_sink);
+
+	KUNIT_EXPECT_EQ(test, audio_info->mode_count, 2U);
+
+	KUNIT_EXPECT_EQ(test, (int)audio_info->modes[0].format_code, 1);
+	KUNIT_EXPECT_EQ(test, audio_info->modes[0].channel_count, 2);
+	KUNIT_EXPECT_EQ(test, audio_info->modes[0].sample_rates.all, 0x07U);
+	KUNIT_EXPECT_EQ(test, audio_info->modes[0].sample_size, 16);
+
+	KUNIT_EXPECT_EQ(test, (int)audio_info->modes[1].format_code, 11);
+	KUNIT_EXPECT_EQ(test, audio_info->modes[1].channel_count, 6);
+	KUNIT_EXPECT_EQ(test, audio_info->modes[1].sample_rates.all, 0x1FU);
+	KUNIT_EXPECT_EQ(test, audio_info->modes[1].sample_size, 24);
+}
+
+/**
+ * dm_test_fill_audio_info_latency_present - Test Fill audio info latency present
+ * @test: The KUnit test context
+ */
+static void dm_test_fill_audio_info_latency_present(struct kunit *test)
+{
+	struct audio_info *audio_info;
+	struct drm_connector *connector;
+	struct dc_sink *dc_sink;
+
+	audio_info = kunit_kzalloc(test, sizeof(*audio_info), GFP_KERNEL);
+	connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
+	dc_sink = kunit_kzalloc(test, sizeof(*dc_sink), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, audio_info);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc_sink);
+
+	connector->display_info.cea_rev = 3;
+	connector->latency_present[0] = true;
+	connector->video_latency[0] = 11;
+	connector->audio_latency[0] = 22;
+
+	amdgpu_dm_fill_audio_info(audio_info, connector, dc_sink);
+
+	KUNIT_EXPECT_EQ(test, audio_info->video_latency, 11U);
+	KUNIT_EXPECT_EQ(test, audio_info->audio_latency, 22U);
+}
+
+/**
+ * dm_test_fill_audio_info_latency_absent_keeps_zero - Test Fill audio info latency absent keeps zero
+ * @test: The KUnit test context
+ */
+static void dm_test_fill_audio_info_latency_absent_keeps_zero(struct kunit *test)
+{
+	struct audio_info *audio_info;
+	struct drm_connector *connector;
+	struct dc_sink *dc_sink;
+
+	audio_info = kunit_kzalloc(test, sizeof(*audio_info), GFP_KERNEL);
+	connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
+	dc_sink = kunit_kzalloc(test, sizeof(*dc_sink), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, audio_info);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc_sink);
+
+	connector->display_info.cea_rev = 3;
+	connector->latency_present[0] = false;
+	connector->video_latency[0] = 99;
+	connector->audio_latency[0] = 88;
+
+	amdgpu_dm_fill_audio_info(audio_info, connector, dc_sink);
+
+	KUNIT_EXPECT_EQ(test, audio_info->video_latency, 0U);
+	KUNIT_EXPECT_EQ(test, audio_info->audio_latency, 0U);
+}
+
+/**
+ * dm_test_fill_audio_info_cea_ge_3_zero_modes - Test cea >= 3 with zero modes
+ * @test: The KUnit test context
+ *
+ * When cea_rev >= 3 but the sink reports no audio modes, mode_count must be
+ * copied as 0 and no mode entries should be populated.
+ */
+static void dm_test_fill_audio_info_cea_ge_3_zero_modes(struct kunit *test)
+{
+	struct audio_info *audio_info;
+	struct drm_connector *connector;
+	struct dc_sink *dc_sink;
+
+	audio_info = kunit_kzalloc(test, sizeof(*audio_info), GFP_KERNEL);
+	connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
+	dc_sink = kunit_kzalloc(test, sizeof(*dc_sink), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, audio_info);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc_sink);
+
+	connector->display_info.cea_rev = 3;
+	dc_sink->edid_caps.audio_mode_count = 0;
+
+	amdgpu_dm_fill_audio_info(audio_info, connector, dc_sink);
+
+	KUNIT_EXPECT_EQ(test, audio_info->mode_count, 0U);
+	KUNIT_EXPECT_EQ(test, (int)audio_info->modes[0].format_code, 0);
+}
+
+/* Tests for amdgpu_dm_audio_component_bind()/unbind() */
+
+/**
+ * dm_test_audio_component_bind_sets_fields - Test bind wires up audio component
+ * @test: The KUnit test context
+ *
+ * Binding must publish the DRM audio component ops, record the kernel device,
+ * and store the component pointer in the display manager.
+ */
+static void dm_test_audio_component_bind_sets_fields(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct device *kdev;
+	struct drm_audio_component *acomp;
+	int ret;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	kdev = kunit_kzalloc(test, sizeof(*kdev), GFP_KERNEL);
+	acomp = kunit_kzalloc(test, sizeof(*acomp), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, kdev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acomp);
+
+	dev_set_drvdata(kdev, &adev->ddev);
+
+	ret = amdgpu_dm_audio_component_bind(kdev, NULL, acomp);
+
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_NOT_NULL(test, acomp->ops);
+	KUNIT_EXPECT_PTR_EQ(test, acomp->dev, kdev);
+	KUNIT_EXPECT_PTR_EQ(test, adev->dm.audio_component, acomp);
+}
+
+/**
+ * dm_test_audio_component_unbind_clears_fields - Test unbind tears down component
+ * @test: The KUnit test context
+ *
+ * Unbinding must clear the component ops, the kernel device, and the display
+ * manager's stored component pointer.
+ */
+static void dm_test_audio_component_unbind_clears_fields(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct device *kdev;
+	struct drm_audio_component *acomp;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	kdev = kunit_kzalloc(test, sizeof(*kdev), GFP_KERNEL);
+	acomp = kunit_kzalloc(test, sizeof(*acomp), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, kdev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acomp);
+
+	dev_set_drvdata(kdev, &adev->ddev);
+
+	/* Pretend a prior bind already happened. */
+	acomp->dev = kdev;
+	adev->dm.audio_component = acomp;
+
+	amdgpu_dm_audio_component_unbind(kdev, NULL, acomp);
+
+	KUNIT_EXPECT_NULL(test, acomp->ops);
+	KUNIT_EXPECT_NULL(test, acomp->dev);
+	KUNIT_EXPECT_NULL(test, adev->dm.audio_component);
+}
+
+/* Tests for amdgpu_dm_audio_eld_notify() */
+
+static int dm_test_eld_notify_count;
+static int dm_test_eld_notify_port;
+static void *dm_test_eld_notify_ptr;
+
+static void dm_test_pin_eld_notify(void *audio_ptr, int port, int pipe)
+{
+	dm_test_eld_notify_count++;
+	dm_test_eld_notify_port = port;
+	dm_test_eld_notify_ptr = audio_ptr;
+}
+
+/**
+ * dm_test_eld_notify_invokes_callback - Test ELD notify forwards to hda driver
+ * @test: The KUnit test context
+ *
+ * When a component with a pin_eld_notify callback is registered, the notify
+ * helper must invoke it with the audio pointer and the requested pin.
+ */
+static void dm_test_eld_notify_invokes_callback(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct drm_audio_component *acomp;
+	struct drm_audio_component_audio_ops *audio_ops;
+	int marker = 0;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	acomp = kunit_kzalloc(test, sizeof(*acomp), GFP_KERNEL);
+	audio_ops = kunit_kzalloc(test, sizeof(*audio_ops), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acomp);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, audio_ops);
+
+	audio_ops->audio_ptr = &marker;
+	audio_ops->pin_eld_notify = dm_test_pin_eld_notify;
+	acomp->audio_ops = audio_ops;
+	adev->dm.audio_component = acomp;
+
+	dm_test_eld_notify_count = 0;
+	dm_test_eld_notify_port = -100;
+	dm_test_eld_notify_ptr = NULL;
+
+	amdgpu_dm_audio_eld_notify(adev, 7);
+
+	KUNIT_EXPECT_EQ(test, dm_test_eld_notify_count, 1);
+	KUNIT_EXPECT_EQ(test, dm_test_eld_notify_port, 7);
+	KUNIT_EXPECT_PTR_EQ(test, dm_test_eld_notify_ptr, (void *)&marker);
+}
+
+/**
+ * dm_test_eld_notify_no_component - Test ELD notify is a no-op without component
+ * @test: The KUnit test context
+ *
+ * With no registered audio component, the notify helper must return without
+ * invoking any callback.
+ */
+static void dm_test_eld_notify_no_component(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	adev->dm.audio_component = NULL;
+
+	dm_test_eld_notify_count = 0;
+
+	amdgpu_dm_audio_eld_notify(adev, 3);
+
+	KUNIT_EXPECT_EQ(test, dm_test_eld_notify_count, 0);
+}
+
+/**
+ * dm_test_eld_notify_null_audio_ops - Test ELD notify is a no-op without audio_ops
+ * @test: The KUnit test context
+ *
+ * A component without audio_ops must not trigger any callback.
+ */
+static void dm_test_eld_notify_null_audio_ops(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct drm_audio_component *acomp;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	acomp = kunit_kzalloc(test, sizeof(*acomp), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acomp);
+
+	acomp->audio_ops = NULL;
+	adev->dm.audio_component = acomp;
+
+	dm_test_eld_notify_count = 0;
+
+	amdgpu_dm_audio_eld_notify(adev, 3);
+
+	KUNIT_EXPECT_EQ(test, dm_test_eld_notify_count, 0);
+}
+
+/**
+ * dm_test_eld_notify_null_callback - Test ELD notify is a no-op without callback
+ * @test: The KUnit test context
+ *
+ * audio_ops present but with a NULL pin_eld_notify must not crash or call
+ * anything.
+ */
+static void dm_test_eld_notify_null_callback(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct drm_audio_component *acomp;
+	struct drm_audio_component_audio_ops *audio_ops;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	acomp = kunit_kzalloc(test, sizeof(*acomp), GFP_KERNEL);
+	audio_ops = kunit_kzalloc(test, sizeof(*audio_ops), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acomp);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, audio_ops);
+
+	audio_ops->pin_eld_notify = NULL;
+	acomp->audio_ops = audio_ops;
+	adev->dm.audio_component = acomp;
+
+	dm_test_eld_notify_count = 0;
+
+	amdgpu_dm_audio_eld_notify(adev, 3);
+
+	KUNIT_EXPECT_EQ(test, dm_test_eld_notify_count, 0);
+}
+
+static struct kunit_case dm_audio_test_cases[] = {
+	/* amdgpu_dm_audio_init */
+	KUNIT_CASE(dm_test_audio_init_disabled),
+	/* amdgpu_dm_audio_fini */
+	KUNIT_CASE(dm_test_audio_fini_without_enabled_audio),
+	/* amdgpu_dm_fill_audio_info */
+	KUNIT_CASE(dm_test_fill_audio_info_ids_name_flags),
+	KUNIT_CASE(dm_test_fill_audio_info_cea_lt_3_skips_modes),
+	KUNIT_CASE(dm_test_fill_audio_info_cea_ge_3_copies_modes),
+	KUNIT_CASE(dm_test_fill_audio_info_cea_ge_3_zero_modes),
+	KUNIT_CASE(dm_test_fill_audio_info_latency_present),
+	KUNIT_CASE(dm_test_fill_audio_info_latency_absent_keeps_zero),
+	/* amdgpu_dm_audio_component_bind/unbind */
+	KUNIT_CASE(dm_test_audio_component_bind_sets_fields),
+	KUNIT_CASE(dm_test_audio_component_unbind_clears_fields),
+	/* amdgpu_dm_audio_eld_notify */
+	KUNIT_CASE(dm_test_eld_notify_invokes_callback),
+	KUNIT_CASE(dm_test_eld_notify_no_component),
+	KUNIT_CASE(dm_test_eld_notify_null_audio_ops),
+	KUNIT_CASE(dm_test_eld_notify_null_callback),
+	{}
+};
+
+static struct kunit_suite dm_audio_test_suite = {
+	.name = "amdgpu_dm_audio",
+	.test_cases = dm_audio_test_cases,
+};
+
+kunit_test_suite(dm_audio_test_suite);
+
+MODULE_LICENSE("Dual MIT/GPL");
+MODULE_DESCRIPTION("KUnit tests for amdgpu_dm_audio");
+MODULE_AUTHOR("AMD");
-- 
2.43.0

