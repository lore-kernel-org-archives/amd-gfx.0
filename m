Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4ED5CD8CB9
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 09:51:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 677A510E88A;
	Wed, 10 Jun 2026 09:51:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mRcCeIMg";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010056.outbound.protection.outlook.com [52.101.85.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22A9110E88A
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 09:51:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jpW3LKdJV0aZko8xwfFtwB4D9TPHiSkiNnW1YgFtkBdTtTPXk5nnIpmTQ1WWbgonX+eCAb+hMHUzsfUpdxV+V4awrAWh3iRaVEbRcuaz/uWvyPMVjLVa7pew9ybgjW+5Gj8qDIJAQIaLQRiy7LZ+1+7RA8iX+yrgf0JO+KnLLPiZc02qQ9kbJTmcKO61b6mZv/UsmDB9Uyl/1hKFacnOxv3mS9BVAEjSC/3JithCrcrLDpBvegIUyEskaqjfZ7BN/szuBT2AxNiWM62zDcbRIWnb1l9n7899Kh2OXYqq5pgxy0C0sh+eL5aj6f93CBZQ/1/BX2OrTxDqtb1Ec1MDZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PJx56pLPNVZVBnSl825uZlLHbt8HH6c+Tjjoy/qYzc=;
 b=tXQj63nlIRjjB9UL7SDXM9j956fKpgxjMkEOStjLuObLmu16a5nTrQ2EsBy24qTD3rF4X174PClFL/ZyqwUu+zqznjtt1Y1eVcD4vrq6mVH4TyL7GjCeQM4rtlxeMb10Q5rMXN3gkG8CYKoPhGU8Kvjo0zpDWuO1jXNitVL3MQvhLyi+pCcMD7K53IZrPEEvpM+KYA/sfzpcyWUXZdS9QF/zFl46et9FYhbWKEAX/IwCiGCXSQjMJ0LO1x2tl3eehayZ16A5upW/gq/kTs/jFgFrmd7vqYM9rgQCQ68PYv+EPrTJf2EY4L6DaWwgZQAlKp7K7TCuBTOWV0YYRbL3NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PJx56pLPNVZVBnSl825uZlLHbt8HH6c+Tjjoy/qYzc=;
 b=mRcCeIMgG9d4mWs1E18fqfAaj2T9Z+m4sQi4QnPiVxEe19qnQ5a/ExXsEcW75Hlayck2QV9iX6n44uitoQBHGW3y1z4Bi5YblQlKlDnl3JbIG0VSehxCeeK5KimHqr1LUkbZ03nDmlJhvBba5snIT0Jb/T4SuJslqnu+j5NDV7E=
Received: from BLAPR03CA0008.namprd03.prod.outlook.com (2603:10b6:208:32b::13)
 by SJ1PR12MB6265.namprd12.prod.outlook.com (2603:10b6:a03:458::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 09:51:23 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::4e) by BLAPR03CA0008.outlook.office365.com
 (2603:10b6:208:32b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.14 via Frontend Transport; Wed, 10
 Jun 2026 09:51:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 09:51:22 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 04:51:21 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 04:51:13 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 "Chenyu Chen" <chen-yu.chen@amd.com>
Subject: [PATCH 22/32] drm/amd/display: Add KUnit tests for amdgpu_dm_irq
Date: Wed, 10 Jun 2026 17:45:06 +0800
Message-ID: <20260610094639.1965367-23-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610094639.1965367-1-chen-yu.chen@amd.com>
References: <20260610094639.1965367-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|SJ1PR12MB6265:EE_
X-MS-Office365-Filtering-Correlation-Id: c13c43fc-94a1-4c30-9cc7-08dec6d5d442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|18002099003|22082099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: zvxl0ZuLTlzpmRMXJAHeQdgQThHCQbihqY/r7RKKjEdKU7dIJdmPU+6QYTYYiA1PMoUOlrRAJMZ1QPJdVR4LcFMCia9KP4petn2jWldvteDf7xbZzxxXJ6QuwamMHm9+ZFmlwFVPxNaKXNOtpqHHagQjcaT4/EbFzqwhpMPzPDMJqpkD4UDXPbzguPKdDrHnPuAZr/YAdaQx2PQfsI/S1/RmG1LkFkgfbMXcneLCBGkDmpR66FcUmoDkZ4X1sR1ZNcO4D5nmONbVt3pXteAEGKGuKL0FS1eC0l5PMHKc87lfg+HYTscaSQsaXc+Td3+zMC8sEY003+FkannFIu4NZZj7VA3AalCDGx7hPW0vFDC9LXS/xtSR4hS5PRnYbryZLrhxnA8pO6y6CIOeTMiSECn3LiuucsIaRdLtV3azUh3z4/7CYAR1HFQE9QNzZkO7T1l0TDlz9vU3wd23EK5dGs2QzECkXV6BPuYXsyEPPykC20Z2gZRlQ72+DgNdDQ/91TXL6Bec4FaNvbG29ZeQ69RqMIVYsEQwmjw+ZbTZZtDQ4sXOFmTlp7X9lXSTuECltVigj2AUqE2Hp+PoAO0NGdjxI8FGFSGzMustkc/S39lBwj+It5SDqPV+l2iHJxznFeiQ6RYAhuPfFe0MATAM2dqBjUdHGswyb1gO/iXnSK/RpCRRikdX3UDVamQjxm5RL4MLqSu9/fkHO9i45Yxoc6ocReHReuWlHaWBQ1rKSYE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ToGd/Wea7bt3m0dhy6zw8lPYYEKFvpEdou8xksPM2ljKqVaWqV5hLINgX5hYBqMfTriLstTAEW00wbdp2UYyR8Q0eUmKKMLHTmNdtCAKxd0dwTMuc+p0c4+TQPaXxjr24kTVs675GlMJtG53dBgW3FkMKNG0jnYImonwAOhaEsbewNYo9AAzTR6+j+Gf18qx63WFCh2FwtfI9BvHZDczxKD3V9dL8s+SHJuYrBmdCXlHB1LwW7crCcNPX4jhhmi0zv9zBt8pgHq278N+gfkOTNzrFAQ6pFIK0H4DJKL3Rwwgu7H1Ou6ahXK3TMNwgoafMGXtHqEVFqYHKP7Br0oLaHV/6D9TfXhgcnRe4/jjvDgDJN0QyBYGJ6XRaAIidTqWhP9Evbuedxvq2MXg54Z5KLFiTxsgCA+Lt5EdclDY3R/Ggl8CpKiRGBANJdKboDWu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:51:22.4218 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c13c43fc-94a1-4c30-9cc7-08dec6d5d442
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6265
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

Add KUnit tests for helper functions, IRQ table management paths, and
DRM mock-backed CRTC lookup in amdgpu_dm_irq.c.

Tests cover:
- amdgpu_dm_hpd_to_dal_irq_source(): all HPD types 1-6,
  AMDGPU_HPD_NONE, and out-of-range values
- are_sinks_equal(): NULL inputs, signal mismatch, EDID
  length mismatch, EDID data mismatch, identical sinks,
  zero-length EDID, full-length identical EDID, and a
  single trailing-byte difference
- dmub_notification_type_str(): notification type mappings that are
  always built, plus the unknown/default case
- amdgpu_dm_irq_init(): low/high handler list initialization
- amdgpu_dm_irq_register_interrupt(): NULL input rejection,
  invalid context/source rejection, low/high handler insertion,
  multiple handlers on one source, and the same handler registered
  in both low and high contexts
- amdgpu_dm_irq_unregister_interrupt(): invalid source and NULL
  handler rejection, removal of registered low/high handlers, and
  the handler-not-found path
- amdgpu_dm_irq_fini(): cleanup of registered low/high handlers and
  the empty-table case
- amdgpu_dm_get_crtc_by_otg_inst(): DRM mock CRTC list match,
  no-match, and empty-list paths

Assisted-by: Copilot:Claude-Opus-4

Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |  15 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h |   8 +
 .../drm/amd/display/amdgpu_dm/tests/Makefile  |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_irq_test.c      | 934 ++++++++++++++++++
 4 files changed, 955 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index 2433180d014f..4c4624f3a122 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -33,6 +33,7 @@
 #include "amdgpu_display.h"
 #include "amdgpu_dm.h"
 #include "amdgpu_dm_irq.h"
+#include "amdgpu_dm_kunit_helpers.h"
 #include "amdgpu_dm_crtc.h"
 #include "amdgpu_dm_hdcp.h"
 #include "amdgpu_dm_mst_types.h"
@@ -372,6 +373,7 @@ void *amdgpu_dm_irq_register_interrupt(struct amdgpu_device *adev,
 
 	return handler_data;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_irq_register_interrupt);
 
 /**
  * amdgpu_dm_irq_unregister_interrupt() - Remove a handler from the DM IRQ table
@@ -416,6 +418,7 @@ void amdgpu_dm_irq_unregister_interrupt(struct amdgpu_device *adev,
 			ih, irq_source);
 	}
 }
+EXPORT_IF_KUNIT(amdgpu_dm_irq_unregister_interrupt);
 
 /**
  * amdgpu_dm_irq_init() - Initialize DM IRQ management
@@ -450,6 +453,7 @@ int amdgpu_dm_irq_init(struct amdgpu_device *adev)
 
 	return 0;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_irq_init);
 
 /**
  * amdgpu_dm_irq_fini() - Tear down DM IRQ management
@@ -488,6 +492,7 @@ void amdgpu_dm_irq_fini(struct amdgpu_device *adev)
 	/* Deallocate handlers from the table. */
 	unregister_all_irq_handlers(adev);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_irq_fini);
 
 void amdgpu_dm_irq_suspend(struct amdgpu_device *adev)
 {
@@ -690,7 +695,7 @@ static int amdgpu_dm_irq_handler(struct amdgpu_device *adev,
 	return 0;
 }
 
-static enum dc_irq_source amdgpu_dm_hpd_to_dal_irq_source(unsigned int type)
+STATIC_IFN_KUNIT enum dc_irq_source amdgpu_dm_hpd_to_dal_irq_source(unsigned int type)
 {
 	switch (type) {
 	case AMDGPU_HPD_1:
@@ -709,6 +714,7 @@ static enum dc_irq_source amdgpu_dm_hpd_to_dal_irq_source(unsigned int type)
 		return DC_IRQ_SOURCE_INVALID;
 	}
 }
+EXPORT_IF_KUNIT(amdgpu_dm_hpd_to_dal_irq_source);
 
 static int amdgpu_dm_set_hpd_irq_state(struct amdgpu_device *adev,
 				       struct amdgpu_irq_src *source,
@@ -1192,7 +1198,7 @@ void amdgpu_dm_hpd_rx_irq_work_suspend(struct amdgpu_display_manager *dm)
 	}
 }
 
-static bool are_sinks_equal(const struct dc_sink *sink1, const struct dc_sink *sink2)
+STATIC_IFN_KUNIT bool are_sinks_equal(const struct dc_sink *sink1, const struct dc_sink *sink2)
 {
 	if (!sink1 || !sink2)
 		return false;
@@ -1207,6 +1213,7 @@ static bool are_sinks_equal(const struct dc_sink *sink1, const struct dc_sink *s
 		return false;
 	return true;
 }
+EXPORT_IF_KUNIT(are_sinks_equal);
 
 
 /**
@@ -1693,6 +1700,7 @@ amdgpu_dm_get_crtc_by_otg_inst(struct amdgpu_device *adev,
 
 	return NULL;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_get_crtc_by_otg_inst);
 
 /**
  * dm_pflip_high_irq() - Handle pageflip interrupt
@@ -2067,7 +2075,7 @@ static void dm_handle_hpd_work(struct work_struct *work)
 
 }
 
-static const char *dmub_notification_type_str(enum dmub_notification_type e)
+STATIC_IFN_KUNIT const char *dmub_notification_type_str(enum dmub_notification_type e)
 {
 	switch (e) {
 	case DMUB_NOTIFICATION_NO_DATA:
@@ -2090,6 +2098,7 @@ static const char *dmub_notification_type_str(enum dmub_notification_type e)
 		return "<unknown>";
 	}
 }
+EXPORT_IF_KUNIT(dmub_notification_type_str);
 
 #define DMUB_TRACE_MAX_READ 64
 /**
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
index ba6968f5626f..bccb5d354a9f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
@@ -30,8 +30,10 @@
 struct amdgpu_device;
 struct amdgpu_crtc;
 struct amdgpu_display_manager;
+struct dc_sink;
 struct hpd_rx_irq_offload_work_queue;
 struct work_struct;
+enum dmub_notification_type;
 
 /*
  * Display Manager IRQ-related interfaces (for use by DAL).
@@ -120,4 +122,10 @@ int amdgpu_dm_dce110_register_irq_handlers(struct amdgpu_device *adev);
 int amdgpu_dm_dcn10_register_irq_handlers(struct amdgpu_device *adev);
 int amdgpu_dm_register_outbox_irq_handlers(struct amdgpu_device *adev);
 
+#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+enum dc_irq_source amdgpu_dm_hpd_to_dal_irq_source(unsigned int type);
+bool are_sinks_equal(const struct dc_sink *sink1, const struct dc_sink *sink2);
+const char *dmub_notification_type_str(enum dmub_notification_type e);
+#endif
+
 #endif /* __AMDGPU_DM_IRQ_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
index 422eef0bfe49..583604914753 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_dmub_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_psr_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_replay_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_ism_test.o
+obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_irq_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_wb_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_mst_types_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_pp_smu_test.o
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
new file mode 100644
index 000000000000..525caa0b1f6a
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
@@ -0,0 +1,934 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * KUnit tests for amdgpu_dm_irq.c
+ *
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#include <kunit/test.h>
+#include <drm/drm_kunit_helpers.h>
+
+#include "dc.h"
+#include "amdgpu.h"
+#include "amdgpu_mode.h"
+#include "amdgpu_dm.h"
+#include "amdgpu_dm_irq.h"
+#include "dmub/dmub_srv.h"
+
+static void dm_test_irq_handler(void *arg)
+{
+}
+
+static void dm_test_irq_handler_alt(void *arg)
+{
+}
+
+static void dm_test_crtc_list_del(void *data)
+{
+	struct amdgpu_crtc *acrtc = data;
+
+	list_del_init(&acrtc->base.head);
+}
+
+/* Tests for amdgpu_dm_hpd_to_dal_irq_source() */
+
+/**
+ * dm_test_hpd_to_dal_irq_source_hpd1 - Test Hpd to dal irq source hpd1
+ * @test: The KUnit test context
+ */
+static void dm_test_hpd_to_dal_irq_source_hpd1(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_hpd_to_dal_irq_source(AMDGPU_HPD_1),
+			(int)DC_IRQ_SOURCE_HPD1);
+}
+
+/**
+ * dm_test_hpd_to_dal_irq_source_hpd2 - Test Hpd to dal irq source hpd2
+ * @test: The KUnit test context
+ */
+static void dm_test_hpd_to_dal_irq_source_hpd2(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_hpd_to_dal_irq_source(AMDGPU_HPD_2),
+			(int)DC_IRQ_SOURCE_HPD2);
+}
+
+/**
+ * dm_test_hpd_to_dal_irq_source_hpd3 - Test Hpd to dal irq source hpd3
+ * @test: The KUnit test context
+ */
+static void dm_test_hpd_to_dal_irq_source_hpd3(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_hpd_to_dal_irq_source(AMDGPU_HPD_3),
+			(int)DC_IRQ_SOURCE_HPD3);
+}
+
+/**
+ * dm_test_hpd_to_dal_irq_source_hpd4 - Test Hpd to dal irq source hpd4
+ * @test: The KUnit test context
+ */
+static void dm_test_hpd_to_dal_irq_source_hpd4(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_hpd_to_dal_irq_source(AMDGPU_HPD_4),
+			(int)DC_IRQ_SOURCE_HPD4);
+}
+
+/**
+ * dm_test_hpd_to_dal_irq_source_hpd5 - Test Hpd to dal irq source hpd5
+ * @test: The KUnit test context
+ */
+static void dm_test_hpd_to_dal_irq_source_hpd5(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_hpd_to_dal_irq_source(AMDGPU_HPD_5),
+			(int)DC_IRQ_SOURCE_HPD5);
+}
+
+/**
+ * dm_test_hpd_to_dal_irq_source_hpd6 - Test Hpd to dal irq source hpd6
+ * @test: The KUnit test context
+ */
+static void dm_test_hpd_to_dal_irq_source_hpd6(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_hpd_to_dal_irq_source(AMDGPU_HPD_6),
+			(int)DC_IRQ_SOURCE_HPD6);
+}
+
+/**
+ * dm_test_hpd_to_dal_irq_source_invalid - Test Hpd to dal irq source invalid
+ * @test: The KUnit test context
+ */
+static void dm_test_hpd_to_dal_irq_source_invalid(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_hpd_to_dal_irq_source(AMDGPU_HPD_NONE),
+			(int)DC_IRQ_SOURCE_INVALID);
+}
+
+/**
+ * dm_test_hpd_to_dal_irq_source_out_of_range - Test Hpd to dal irq source out of range
+ * @test: The KUnit test context
+ */
+static void dm_test_hpd_to_dal_irq_source_out_of_range(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_hpd_to_dal_irq_source(99),
+			(int)DC_IRQ_SOURCE_INVALID);
+}
+
+/* Tests for are_sinks_equal() */
+
+/**
+ * dm_test_are_sinks_equal_both_null - Test Are sinks equal both null
+ * @test: The KUnit test context
+ */
+static void dm_test_are_sinks_equal_both_null(struct kunit *test)
+{
+	KUNIT_EXPECT_FALSE(test, are_sinks_equal(NULL, NULL));
+}
+
+/**
+ * dm_test_are_sinks_equal_first_null - Test Are sinks equal first null
+ * @test: The KUnit test context
+ */
+static void dm_test_are_sinks_equal_first_null(struct kunit *test)
+{
+	struct dc_sink *sink2;
+
+	sink2 = kunit_kzalloc(test, sizeof(*sink2), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sink2);
+
+	KUNIT_EXPECT_FALSE(test, are_sinks_equal(NULL, sink2));
+}
+
+/**
+ * dm_test_are_sinks_equal_second_null - Test Are sinks equal second null
+ * @test: The KUnit test context
+ */
+static void dm_test_are_sinks_equal_second_null(struct kunit *test)
+{
+	struct dc_sink *sink1;
+
+	sink1 = kunit_kzalloc(test, sizeof(*sink1), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sink1);
+
+	KUNIT_EXPECT_FALSE(test, are_sinks_equal(sink1, NULL));
+}
+
+/**
+ * dm_test_are_sinks_equal_different_signal - Test Are sinks equal different signal
+ * @test: The KUnit test context
+ */
+static void dm_test_are_sinks_equal_different_signal(struct kunit *test)
+{
+	struct dc_sink *sink1, *sink2;
+
+	sink1 = kunit_kzalloc(test, sizeof(*sink1), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sink1);
+	sink2 = kunit_kzalloc(test, sizeof(*sink2), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sink2);
+
+	sink1->sink_signal = SIGNAL_TYPE_HDMI_TYPE_A;
+	sink2->sink_signal = SIGNAL_TYPE_DISPLAY_PORT;
+
+	KUNIT_EXPECT_FALSE(test, are_sinks_equal(sink1, sink2));
+}
+
+/**
+ * dm_test_are_sinks_equal_different_edid_length - Test Are sinks equal different edid length
+ * @test: The KUnit test context
+ */
+static void dm_test_are_sinks_equal_different_edid_length(struct kunit *test)
+{
+	struct dc_sink *sink1, *sink2;
+
+	sink1 = kunit_kzalloc(test, sizeof(*sink1), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sink1);
+	sink2 = kunit_kzalloc(test, sizeof(*sink2), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sink2);
+
+	sink1->sink_signal = SIGNAL_TYPE_HDMI_TYPE_A;
+	sink2->sink_signal = SIGNAL_TYPE_HDMI_TYPE_A;
+	sink1->dc_edid.length = 128;
+	sink2->dc_edid.length = 256;
+
+	KUNIT_EXPECT_FALSE(test, are_sinks_equal(sink1, sink2));
+}
+
+/**
+ * dm_test_are_sinks_equal_different_edid_data - Test Are sinks equal different edid data
+ * @test: The KUnit test context
+ */
+static void dm_test_are_sinks_equal_different_edid_data(struct kunit *test)
+{
+	struct dc_sink *sink1, *sink2;
+
+	sink1 = kunit_kzalloc(test, sizeof(*sink1), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sink1);
+	sink2 = kunit_kzalloc(test, sizeof(*sink2), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sink2);
+
+	sink1->sink_signal = SIGNAL_TYPE_HDMI_TYPE_A;
+	sink2->sink_signal = SIGNAL_TYPE_HDMI_TYPE_A;
+	sink1->dc_edid.length = 4;
+	sink2->dc_edid.length = 4;
+	memset(sink1->dc_edid.raw_edid, 0xAA, 4);
+	memset(sink2->dc_edid.raw_edid, 0xBB, 4);
+
+	KUNIT_EXPECT_FALSE(test, are_sinks_equal(sink1, sink2));
+}
+
+/**
+ * dm_test_are_sinks_equal_identical - Test Are sinks equal identical
+ * @test: The KUnit test context
+ */
+static void dm_test_are_sinks_equal_identical(struct kunit *test)
+{
+	struct dc_sink *sink1, *sink2;
+
+	sink1 = kunit_kzalloc(test, sizeof(*sink1), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sink1);
+	sink2 = kunit_kzalloc(test, sizeof(*sink2), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sink2);
+
+	sink1->sink_signal = SIGNAL_TYPE_HDMI_TYPE_A;
+	sink2->sink_signal = SIGNAL_TYPE_HDMI_TYPE_A;
+	sink1->dc_edid.length = 4;
+	sink2->dc_edid.length = 4;
+	memset(sink1->dc_edid.raw_edid, 0xAA, 4);
+	memset(sink2->dc_edid.raw_edid, 0xAA, 4);
+
+	KUNIT_EXPECT_TRUE(test, are_sinks_equal(sink1, sink2));
+}
+
+/**
+ * dm_test_are_sinks_equal_zero_length - Test Are sinks equal zero length
+ * @test: The KUnit test context
+ */
+static void dm_test_are_sinks_equal_zero_length(struct kunit *test)
+{
+	struct dc_sink *sink1, *sink2;
+
+	sink1 = kunit_kzalloc(test, sizeof(*sink1), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sink1);
+	sink2 = kunit_kzalloc(test, sizeof(*sink2), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sink2);
+
+	sink1->sink_signal = SIGNAL_TYPE_DISPLAY_PORT;
+	sink2->sink_signal = SIGNAL_TYPE_DISPLAY_PORT;
+	sink1->dc_edid.length = 0;
+	sink2->dc_edid.length = 0;
+
+	KUNIT_EXPECT_TRUE(test, are_sinks_equal(sink1, sink2));
+}
+
+/**
+ * dm_test_are_sinks_equal_full_edid_identical - Test Are sinks equal full edid identical
+ * @test: The KUnit test context
+ */
+static void dm_test_are_sinks_equal_full_edid_identical(struct kunit *test)
+{
+	struct dc_sink *sink1, *sink2;
+
+	sink1 = kunit_kzalloc(test, sizeof(*sink1), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sink1);
+	sink2 = kunit_kzalloc(test, sizeof(*sink2), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sink2);
+
+	sink1->sink_signal = SIGNAL_TYPE_HDMI_TYPE_A;
+	sink2->sink_signal = SIGNAL_TYPE_HDMI_TYPE_A;
+	sink1->dc_edid.length = 128;
+	sink2->dc_edid.length = 128;
+	memset(sink1->dc_edid.raw_edid, 0x5A, 128);
+	memset(sink2->dc_edid.raw_edid, 0x5A, 128);
+
+	KUNIT_EXPECT_TRUE(test, are_sinks_equal(sink1, sink2));
+}
+
+/**
+ * dm_test_are_sinks_equal_full_edid_last_byte_differs - Test Are sinks equal last byte differs
+ * @test: The KUnit test context
+ */
+static void dm_test_are_sinks_equal_full_edid_last_byte_differs(struct kunit *test)
+{
+	struct dc_sink *sink1, *sink2;
+
+	sink1 = kunit_kzalloc(test, sizeof(*sink1), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sink1);
+	sink2 = kunit_kzalloc(test, sizeof(*sink2), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sink2);
+
+	sink1->sink_signal = SIGNAL_TYPE_HDMI_TYPE_A;
+	sink2->sink_signal = SIGNAL_TYPE_HDMI_TYPE_A;
+	sink1->dc_edid.length = 128;
+	sink2->dc_edid.length = 128;
+	memset(sink1->dc_edid.raw_edid, 0x5A, 128);
+	memset(sink2->dc_edid.raw_edid, 0x5A, 128);
+	sink2->dc_edid.raw_edid[127] = 0x5B;
+
+	KUNIT_EXPECT_FALSE(test, are_sinks_equal(sink1, sink2));
+}
+
+/* Tests for dmub_notification_type_str() */
+
+/**
+ * dm_test_notification_str_no_data - Test Notification str no data
+ * @test: The KUnit test context
+ */
+static void dm_test_notification_str_no_data(struct kunit *test)
+{
+	KUNIT_EXPECT_STREQ(test, dmub_notification_type_str(DMUB_NOTIFICATION_NO_DATA), "NO_DATA");
+}
+
+/**
+ * dm_test_notification_str_aux_reply - Test Notification str aux reply
+ * @test: The KUnit test context
+ */
+static void dm_test_notification_str_aux_reply(struct kunit *test)
+{
+	KUNIT_EXPECT_STREQ(test, dmub_notification_type_str(DMUB_NOTIFICATION_AUX_REPLY), "AUX_REPLY");
+}
+
+/**
+ * dm_test_notification_str_hpd - Test Notification str hpd
+ * @test: The KUnit test context
+ */
+static void dm_test_notification_str_hpd(struct kunit *test)
+{
+	KUNIT_EXPECT_STREQ(test, dmub_notification_type_str(DMUB_NOTIFICATION_HPD), "HPD");
+}
+
+/**
+ * dm_test_notification_str_hpd_irq - Test Notification str hpd irq
+ * @test: The KUnit test context
+ */
+static void dm_test_notification_str_hpd_irq(struct kunit *test)
+{
+	KUNIT_EXPECT_STREQ(test, dmub_notification_type_str(DMUB_NOTIFICATION_HPD_IRQ), "HPD_IRQ");
+}
+
+/**
+ * dm_test_notification_str_set_config - Test Notification str set config
+ * @test: The KUnit test context
+ */
+static void dm_test_notification_str_set_config(struct kunit *test)
+{
+	KUNIT_EXPECT_STREQ(test, dmub_notification_type_str(DMUB_NOTIFICATION_SET_CONFIG_REPLY),
+			   "SET_CONFIG_REPLY");
+}
+
+/**
+ * dm_test_notification_str_dpia - Test Notification str dpia
+ * @test: The KUnit test context
+ */
+static void dm_test_notification_str_dpia(struct kunit *test)
+{
+	KUNIT_EXPECT_STREQ(test, dmub_notification_type_str(DMUB_NOTIFICATION_DPIA_NOTIFICATION),
+			   "DPIA_NOTIFICATION");
+}
+
+/**
+ * dm_test_notification_str_hpd_sense - Test Notification str hpd sense
+ * @test: The KUnit test context
+ */
+static void dm_test_notification_str_hpd_sense(struct kunit *test)
+{
+	KUNIT_EXPECT_STREQ(test, dmub_notification_type_str(DMUB_NOTIFICATION_HPD_SENSE_NOTIFY),
+			   "HPD_SENSE_NOTIFY");
+}
+
+/**
+ * dm_test_notification_str_fused_io - Test Notification str fused io
+ * @test: The KUnit test context
+ */
+static void dm_test_notification_str_fused_io(struct kunit *test)
+{
+	KUNIT_EXPECT_STREQ(test, dmub_notification_type_str(DMUB_NOTIFICATION_FUSED_IO),
+			   "FUSED_IO");
+}
+
+/**
+ * dm_test_notification_str_unknown - Test Notification str unknown
+ * @test: The KUnit test context
+ */
+static void dm_test_notification_str_unknown(struct kunit *test)
+{
+	KUNIT_EXPECT_STREQ(test, dmub_notification_type_str(DMUB_NOTIFICATION_MAX), "<unknown>");
+}
+
+/* Tests for amdgpu_dm_irq_init() */
+
+/**
+ * dm_test_irq_init_initializes_lists - Test irq init initializes list heads
+ * @test: The KUnit test context
+ */
+static void dm_test_irq_init_initializes_lists(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	int src;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_irq_init(adev), 0);
+
+	for (src = 0; src < DAL_IRQ_SOURCES_NUMBER; src++) {
+		KUNIT_EXPECT_TRUE(test,
+				  list_empty(&adev->dm.irq_handler_list_low_tab[src]));
+		KUNIT_EXPECT_TRUE(test,
+				  list_empty(&adev->dm.irq_handler_list_high_tab[src]));
+	}
+}
+
+/* Tests for amdgpu_dm_irq_register_interrupt() */
+
+/**
+ * dm_test_irq_register_rejects_null_params - Test register rejects null params
+ * @test: The KUnit test context
+ */
+static void dm_test_irq_register_rejects_null_params(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc_interrupt_params int_params = { 0 };
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	int_params.int_context = INTERRUPT_LOW_IRQ_CONTEXT;
+	int_params.irq_source = DC_IRQ_SOURCE_HPD1;
+
+	KUNIT_EXPECT_NULL(test,
+		amdgpu_dm_irq_register_interrupt(adev, NULL,
+						   dm_test_irq_handler, NULL));
+	KUNIT_EXPECT_NULL(test,
+		amdgpu_dm_irq_register_interrupt(adev, &int_params, NULL, NULL));
+}
+
+/**
+ * dm_test_irq_register_rejects_invalid_context - Test register rejects context
+ * @test: The KUnit test context
+ */
+static void dm_test_irq_register_rejects_invalid_context(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc_interrupt_params int_params = { 0 };
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	int_params.int_context = INTERRUPT_CONTEXT_NUMBER;
+	int_params.irq_source = DC_IRQ_SOURCE_HPD1;
+
+	KUNIT_EXPECT_NULL(test,
+		amdgpu_dm_irq_register_interrupt(adev, &int_params,
+						   dm_test_irq_handler, NULL));
+}
+
+/**
+ * dm_test_irq_register_rejects_invalid_source - Test register rejects source
+ * @test: The KUnit test context
+ */
+static void dm_test_irq_register_rejects_invalid_source(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc_interrupt_params int_params = { 0 };
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	int_params.int_context = INTERRUPT_LOW_IRQ_CONTEXT;
+	int_params.irq_source = DC_IRQ_SOURCE_INVALID;
+
+	KUNIT_EXPECT_NULL(test,
+		amdgpu_dm_irq_register_interrupt(adev, &int_params,
+						   dm_test_irq_handler, NULL));
+}
+
+/**
+ * dm_test_irq_register_adds_low_context_handler - Test register adds low handler
+ * @test: The KUnit test context
+ */
+static void dm_test_irq_register_adds_low_context_handler(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc_interrupt_params int_params = { 0 };
+	void *handler;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
+
+	int_params.int_context = INTERRUPT_LOW_IRQ_CONTEXT;
+	int_params.irq_source = DC_IRQ_SOURCE_HPD1;
+
+	handler = amdgpu_dm_irq_register_interrupt(adev, &int_params,
+						    dm_test_irq_handler, adev);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, handler);
+	KUNIT_EXPECT_FALSE(test,
+			   list_empty(&adev->dm.irq_handler_list_low_tab[DC_IRQ_SOURCE_HPD1]));
+	KUNIT_EXPECT_TRUE(test,
+			  list_empty(&adev->dm.irq_handler_list_high_tab[DC_IRQ_SOURCE_HPD1]));
+
+	amdgpu_dm_irq_unregister_interrupt(adev, DC_IRQ_SOURCE_HPD1,
+						dm_test_irq_handler);
+	KUNIT_EXPECT_TRUE(test,
+			  list_empty(&adev->dm.irq_handler_list_low_tab[DC_IRQ_SOURCE_HPD1]));
+}
+
+/**
+ * dm_test_irq_register_adds_high_context_handler - Test register adds high handler
+ * @test: The KUnit test context
+ */
+static void dm_test_irq_register_adds_high_context_handler(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc_interrupt_params int_params = { 0 };
+	void *handler;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
+
+	int_params.int_context = INTERRUPT_HIGH_IRQ_CONTEXT;
+	int_params.irq_source = DC_IRQ_SOURCE_HPD2;
+
+	handler = amdgpu_dm_irq_register_interrupt(adev, &int_params,
+						    dm_test_irq_handler, adev);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, handler);
+	KUNIT_EXPECT_FALSE(test,
+			   list_empty(&adev->dm.irq_handler_list_high_tab[DC_IRQ_SOURCE_HPD2]));
+	KUNIT_EXPECT_TRUE(test,
+			  list_empty(&adev->dm.irq_handler_list_low_tab[DC_IRQ_SOURCE_HPD2]));
+
+	amdgpu_dm_irq_unregister_interrupt(adev, DC_IRQ_SOURCE_HPD2,
+						dm_test_irq_handler);
+	KUNIT_EXPECT_TRUE(test,
+			  list_empty(&adev->dm.irq_handler_list_high_tab[DC_IRQ_SOURCE_HPD2]));
+}
+
+/**
+ * dm_test_irq_register_multiple_handlers - Test register keeps multiple handlers
+ * @test: The KUnit test context
+ */
+static void dm_test_irq_register_multiple_handlers(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc_interrupt_params int_params = { 0 };
+	struct list_head *hnd_list;
+	void *handler1, *handler2;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
+
+	int_params.int_context = INTERRUPT_LOW_IRQ_CONTEXT;
+	int_params.irq_source = DC_IRQ_SOURCE_HPD1;
+
+	handler1 = amdgpu_dm_irq_register_interrupt(adev, &int_params,
+						    dm_test_irq_handler, adev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, handler1);
+	handler2 = amdgpu_dm_irq_register_interrupt(adev, &int_params,
+						    dm_test_irq_handler_alt, adev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, handler2);
+
+	hnd_list = &adev->dm.irq_handler_list_low_tab[DC_IRQ_SOURCE_HPD1];
+	KUNIT_EXPECT_EQ(test, list_count_nodes(hnd_list), 2);
+
+	amdgpu_dm_irq_unregister_interrupt(adev, DC_IRQ_SOURCE_HPD1,
+						dm_test_irq_handler);
+	amdgpu_dm_irq_unregister_interrupt(adev, DC_IRQ_SOURCE_HPD1,
+						dm_test_irq_handler_alt);
+	KUNIT_EXPECT_TRUE(test, list_empty(hnd_list));
+}
+
+/**
+ * dm_test_irq_register_separate_contexts - Test register same source in two contexts
+ * @test: The KUnit test context
+ */
+static void dm_test_irq_register_separate_contexts(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc_interrupt_params int_params = { 0 };
+	void *handler;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
+
+	int_params.irq_source = DC_IRQ_SOURCE_HPD5;
+
+	int_params.int_context = INTERRUPT_LOW_IRQ_CONTEXT;
+	handler = amdgpu_dm_irq_register_interrupt(adev, &int_params,
+						    dm_test_irq_handler, adev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, handler);
+
+	int_params.int_context = INTERRUPT_HIGH_IRQ_CONTEXT;
+	handler = amdgpu_dm_irq_register_interrupt(adev, &int_params,
+						    dm_test_irq_handler, adev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, handler);
+
+	KUNIT_EXPECT_FALSE(test,
+			   list_empty(&adev->dm.irq_handler_list_low_tab[DC_IRQ_SOURCE_HPD5]));
+	KUNIT_EXPECT_FALSE(test,
+			   list_empty(&adev->dm.irq_handler_list_high_tab[DC_IRQ_SOURCE_HPD5]));
+
+	/*
+	 * A single unregister call stops at the first context where the handler
+	 * is found (low context), leaving the high context handler in place.
+	 */
+	amdgpu_dm_irq_unregister_interrupt(adev, DC_IRQ_SOURCE_HPD5,
+						dm_test_irq_handler);
+
+	KUNIT_EXPECT_TRUE(test,
+			  list_empty(&adev->dm.irq_handler_list_low_tab[DC_IRQ_SOURCE_HPD5]));
+	KUNIT_EXPECT_FALSE(test,
+			   list_empty(&adev->dm.irq_handler_list_high_tab[DC_IRQ_SOURCE_HPD5]));
+
+	/* A second call removes the remaining high context handler. */
+	amdgpu_dm_irq_unregister_interrupt(adev, DC_IRQ_SOURCE_HPD5,
+						dm_test_irq_handler);
+
+	KUNIT_EXPECT_TRUE(test,
+			  list_empty(&adev->dm.irq_handler_list_high_tab[DC_IRQ_SOURCE_HPD5]));
+}
+
+/* Tests for amdgpu_dm_irq_unregister_interrupt() */
+
+/**
+ * dm_test_irq_unregister_rejects_invalid_source - Test unregister rejects source
+ * @test: The KUnit test context
+ */
+static void dm_test_irq_unregister_rejects_invalid_source(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
+
+	amdgpu_dm_irq_unregister_interrupt(adev, DC_IRQ_SOURCE_INVALID,
+						dm_test_irq_handler);
+
+	KUNIT_EXPECT_TRUE(test,
+			  list_empty(&adev->dm.irq_handler_list_low_tab[DC_IRQ_SOURCE_HPD1]));
+	KUNIT_EXPECT_TRUE(test,
+			  list_empty(&adev->dm.irq_handler_list_high_tab[DC_IRQ_SOURCE_HPD1]));
+}
+
+/**
+ * dm_test_irq_unregister_rejects_null_handler - Test unregister rejects handler
+ * @test: The KUnit test context
+ */
+static void dm_test_irq_unregister_rejects_null_handler(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
+
+	amdgpu_dm_irq_unregister_interrupt(adev, DC_IRQ_SOURCE_HPD1,
+						DAL_INVALID_IRQ_HANDLER_IDX);
+
+	KUNIT_EXPECT_TRUE(test,
+			  list_empty(&adev->dm.irq_handler_list_low_tab[DC_IRQ_SOURCE_HPD1]));
+	KUNIT_EXPECT_TRUE(test,
+			  list_empty(&adev->dm.irq_handler_list_high_tab[DC_IRQ_SOURCE_HPD1]));
+}
+
+/**
+ * dm_test_irq_unregister_handler_not_found - Test unregister keeps unmatched handler
+ * @test: The KUnit test context
+ */
+static void dm_test_irq_unregister_handler_not_found(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc_interrupt_params int_params = { 0 };
+	void *handler;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
+
+	int_params.int_context = INTERRUPT_LOW_IRQ_CONTEXT;
+	int_params.irq_source = DC_IRQ_SOURCE_HPD1;
+	handler = amdgpu_dm_irq_register_interrupt(adev, &int_params,
+						    dm_test_irq_handler, adev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, handler);
+
+	/* Unregister a handler that was never registered for this source. */
+	amdgpu_dm_irq_unregister_interrupt(adev, DC_IRQ_SOURCE_HPD1,
+						dm_test_irq_handler_alt);
+
+	/* The originally registered handler must still be present. */
+	KUNIT_EXPECT_FALSE(test,
+			   list_empty(&adev->dm.irq_handler_list_low_tab[DC_IRQ_SOURCE_HPD1]));
+
+	amdgpu_dm_irq_unregister_interrupt(adev, DC_IRQ_SOURCE_HPD1,
+						dm_test_irq_handler);
+	KUNIT_EXPECT_TRUE(test,
+			  list_empty(&adev->dm.irq_handler_list_low_tab[DC_IRQ_SOURCE_HPD1]));
+}
+
+/* Tests for amdgpu_dm_irq_fini() */
+
+/**
+ * dm_test_irq_fini_removes_registered_handlers - Test fini removes handlers
+ * @test: The KUnit test context
+ */
+static void dm_test_irq_fini_removes_registered_handlers(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc_interrupt_params int_params = { 0 };
+	void *handler;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
+
+	int_params.int_context = INTERRUPT_LOW_IRQ_CONTEXT;
+	int_params.irq_source = DC_IRQ_SOURCE_HPD3;
+	handler = amdgpu_dm_irq_register_interrupt(adev, &int_params,
+						    dm_test_irq_handler, adev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, handler);
+
+	int_params.int_context = INTERRUPT_HIGH_IRQ_CONTEXT;
+	int_params.irq_source = DC_IRQ_SOURCE_HPD4;
+	handler = amdgpu_dm_irq_register_interrupt(adev, &int_params,
+						    dm_test_irq_handler, adev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, handler);
+
+	amdgpu_dm_irq_fini(adev);
+
+	KUNIT_EXPECT_TRUE(test,
+			  list_empty(&adev->dm.irq_handler_list_low_tab[DC_IRQ_SOURCE_HPD3]));
+	KUNIT_EXPECT_TRUE(test,
+			  list_empty(&adev->dm.irq_handler_list_high_tab[DC_IRQ_SOURCE_HPD4]));
+}
+
+/**
+ * dm_test_irq_fini_on_empty_tables - Test fini on tables with no handlers
+ * @test: The KUnit test context
+ */
+static void dm_test_irq_fini_on_empty_tables(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	int src;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
+
+	amdgpu_dm_irq_fini(adev);
+
+	for (src = 0; src < DAL_IRQ_SOURCES_NUMBER; src++) {
+		KUNIT_EXPECT_TRUE(test,
+				  list_empty(&adev->dm.irq_handler_list_low_tab[src]));
+		KUNIT_EXPECT_TRUE(test,
+				  list_empty(&adev->dm.irq_handler_list_high_tab[src]));
+	}
+}
+
+/* Tests for amdgpu_dm_get_crtc_by_otg_inst() */
+
+/**
+ * dm_test_get_crtc_by_otg_inst_returns_match - Test CRTC lookup by OTG instance
+ * @test: The KUnit test context
+ */
+static void dm_test_get_crtc_by_otg_inst_returns_match(struct kunit *test)
+{
+	struct amdgpu_crtc *acrtc_a, *acrtc_b;
+	struct amdgpu_device *adev;
+	struct drm_device *drm;
+	struct device *dev;
+
+	dev = drm_kunit_helper_alloc_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	drm = __drm_kunit_helper_alloc_drm_device(test, dev,
+						   sizeof(*adev),
+						   offsetof(struct amdgpu_device, ddev),
+						   DRIVER_MODESET);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
+	adev = drm_to_adev(drm);
+
+	acrtc_a = kunit_kzalloc(test, sizeof(*acrtc_a), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc_a);
+	acrtc_b = kunit_kzalloc(test, sizeof(*acrtc_b), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc_b);
+
+	INIT_LIST_HEAD(&acrtc_a->base.head);
+	INIT_LIST_HEAD(&acrtc_b->base.head);
+	acrtc_a->otg_inst = 1;
+	acrtc_b->otg_inst = 3;
+
+	list_add_tail(&acrtc_a->base.head, &drm->mode_config.crtc_list);
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test, dm_test_crtc_list_del,
+							acrtc_a), 0);
+	list_add_tail(&acrtc_b->base.head, &drm->mode_config.crtc_list);
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test, dm_test_crtc_list_del,
+							acrtc_b), 0);
+
+	KUNIT_EXPECT_PTR_EQ(test, amdgpu_dm_get_crtc_by_otg_inst(adev, 3), acrtc_b);
+}
+
+/**
+ * dm_test_get_crtc_by_otg_inst_returns_null - Test CRTC lookup misses unknown OTG
+ * @test: The KUnit test context
+ */
+static void dm_test_get_crtc_by_otg_inst_returns_null(struct kunit *test)
+{
+	struct amdgpu_crtc *acrtc;
+	struct amdgpu_device *adev;
+	struct drm_device *drm;
+	struct device *dev;
+
+	dev = drm_kunit_helper_alloc_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	drm = __drm_kunit_helper_alloc_drm_device(test, dev,
+						   sizeof(*adev),
+						   offsetof(struct amdgpu_device, ddev),
+						   DRIVER_MODESET);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
+	adev = drm_to_adev(drm);
+
+	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+
+	INIT_LIST_HEAD(&acrtc->base.head);
+	acrtc->otg_inst = 2;
+
+	list_add_tail(&acrtc->base.head, &drm->mode_config.crtc_list);
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test, dm_test_crtc_list_del,
+							acrtc), 0);
+
+	KUNIT_EXPECT_NULL(test, amdgpu_dm_get_crtc_by_otg_inst(adev, 5));
+}
+
+/**
+ * dm_test_get_crtc_by_otg_inst_empty_list - Test CRTC lookup on empty CRTC list
+ * @test: The KUnit test context
+ */
+static void dm_test_get_crtc_by_otg_inst_empty_list(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct drm_device *drm;
+	struct device *dev;
+
+	dev = drm_kunit_helper_alloc_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	drm = __drm_kunit_helper_alloc_drm_device(test, dev,
+						   sizeof(*adev),
+						   offsetof(struct amdgpu_device, ddev),
+						   DRIVER_MODESET);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
+	adev = drm_to_adev(drm);
+
+	KUNIT_EXPECT_NULL(test, amdgpu_dm_get_crtc_by_otg_inst(adev, 0));
+}
+
+static struct kunit_case amdgpu_dm_irq_tests[] = {
+	/* amdgpu_dm_hpd_to_dal_irq_source */
+	KUNIT_CASE(dm_test_hpd_to_dal_irq_source_hpd1),
+	KUNIT_CASE(dm_test_hpd_to_dal_irq_source_hpd2),
+	KUNIT_CASE(dm_test_hpd_to_dal_irq_source_hpd3),
+	KUNIT_CASE(dm_test_hpd_to_dal_irq_source_hpd4),
+	KUNIT_CASE(dm_test_hpd_to_dal_irq_source_hpd5),
+	KUNIT_CASE(dm_test_hpd_to_dal_irq_source_hpd6),
+	KUNIT_CASE(dm_test_hpd_to_dal_irq_source_invalid),
+	KUNIT_CASE(dm_test_hpd_to_dal_irq_source_out_of_range),
+	/* are_sinks_equal */
+	KUNIT_CASE(dm_test_are_sinks_equal_both_null),
+	KUNIT_CASE(dm_test_are_sinks_equal_first_null),
+	KUNIT_CASE(dm_test_are_sinks_equal_second_null),
+	KUNIT_CASE(dm_test_are_sinks_equal_different_signal),
+	KUNIT_CASE(dm_test_are_sinks_equal_different_edid_length),
+	KUNIT_CASE(dm_test_are_sinks_equal_different_edid_data),
+	KUNIT_CASE(dm_test_are_sinks_equal_identical),
+	KUNIT_CASE(dm_test_are_sinks_equal_zero_length),
+	KUNIT_CASE(dm_test_are_sinks_equal_full_edid_identical),
+	KUNIT_CASE(dm_test_are_sinks_equal_full_edid_last_byte_differs),
+	/* dmub_notification_type_str */
+	KUNIT_CASE(dm_test_notification_str_no_data),
+	KUNIT_CASE(dm_test_notification_str_aux_reply),
+	KUNIT_CASE(dm_test_notification_str_hpd),
+	KUNIT_CASE(dm_test_notification_str_hpd_irq),
+	KUNIT_CASE(dm_test_notification_str_set_config),
+	KUNIT_CASE(dm_test_notification_str_dpia),
+	KUNIT_CASE(dm_test_notification_str_hpd_sense),
+	KUNIT_CASE(dm_test_notification_str_fused_io),
+	KUNIT_CASE(dm_test_notification_str_unknown),
+	/* amdgpu_dm_irq_init */
+	KUNIT_CASE(dm_test_irq_init_initializes_lists),
+	/* amdgpu_dm_irq_register_interrupt */
+	KUNIT_CASE(dm_test_irq_register_rejects_null_params),
+	KUNIT_CASE(dm_test_irq_register_rejects_invalid_context),
+	KUNIT_CASE(dm_test_irq_register_rejects_invalid_source),
+	KUNIT_CASE(dm_test_irq_register_adds_low_context_handler),
+	KUNIT_CASE(dm_test_irq_register_adds_high_context_handler),
+	KUNIT_CASE(dm_test_irq_register_multiple_handlers),
+	KUNIT_CASE(dm_test_irq_register_separate_contexts),
+	/* amdgpu_dm_irq_unregister_interrupt */
+	KUNIT_CASE(dm_test_irq_unregister_rejects_invalid_source),
+	KUNIT_CASE(dm_test_irq_unregister_rejects_null_handler),
+	KUNIT_CASE(dm_test_irq_unregister_handler_not_found),
+	/* amdgpu_dm_irq_fini */
+	KUNIT_CASE(dm_test_irq_fini_removes_registered_handlers),
+	KUNIT_CASE(dm_test_irq_fini_on_empty_tables),
+	/* amdgpu_dm_get_crtc_by_otg_inst */
+	KUNIT_CASE(dm_test_get_crtc_by_otg_inst_returns_match),
+	KUNIT_CASE(dm_test_get_crtc_by_otg_inst_returns_null),
+	KUNIT_CASE(dm_test_get_crtc_by_otg_inst_empty_list),
+	{}
+};
+
+static struct kunit_suite amdgpu_dm_irq_test_suite = {
+	.name = "amdgpu_dm_irq",
+	.test_cases = amdgpu_dm_irq_tests,
+};
+
+kunit_test_suite(amdgpu_dm_irq_test_suite);
+
+MODULE_AUTHOR("AMD");
+MODULE_DESCRIPTION("KUnit tests for amdgpu_dm_irq");
+MODULE_LICENSE("Dual MIT/GPL");
-- 
2.43.0

