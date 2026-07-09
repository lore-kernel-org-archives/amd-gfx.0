Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D11DC44506
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E19C310F6E2;
	Thu,  9 Jul 2026 21:02:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q1v5IxxG";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012001.outbound.protection.outlook.com [52.101.43.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98E2310F6DC
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hTRUaJDdnWZaQtIo03jt3RTtm9cwTNtHrWWE22kQ5vFougvYsLhS/Je2iEM71ulWw9D2iNJdGT8E+3qEHEC/x1SgHHuy5gKo4Cab7l3tZg/a0Kzg2vyOJmNut37HkPA3W+L/MKDeqap9gJu96hI9xw4l8U0Kg51VwqQlz2vuPzrSsdbc2SATF/2BLbrG+IlMlbc/gtIueKOGX28WHjF1+SYTUlKRGD16vzUei0oR854IAk/TgmuEZLNXKNi/pIOZNjQwaSlZVmEQKExhbuo7fXsaS6RPyM7NSQKmO6mkG2R3qHnVBlTV/vaXbIK08hMYxfVd1ChCJ5+brTxFH9e3QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=327WRLM2fUIQE6L3yt0KVFJDYLZZtxKtqkwwdXTmLVU=;
 b=wrwJwflWRdfPzlQwjZTjW359akjJixtwJeIU97KxNIaGVmsz8DygRsekpwLu+wA6uG16D6HOykKY4VcFKn/Gtvz+tvy7uE7UfOdz+slMFns7jP+c302MUVsoDsJpenjKidFufdgk+J1UrMaUyeGq5j6tX3E/DuS1AWXsyCkBXfwPZN+YpSnscFl39PSBc4Cf1qlv9RytLsXpCCzWRVoL6j1kZ2bVoYWicOXZ08oVMfvMnIH4jZYgJokRZARWGUWw0IguZ2FvfWrQqWs8YplbofdCb4ha7OISXi/+JMVCKyosgBJLtRLqpb7lEeRhla6CFbYbTf9OjAZabC3app+27w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=327WRLM2fUIQE6L3yt0KVFJDYLZZtxKtqkwwdXTmLVU=;
 b=Q1v5IxxGFxbcR08YcNVL6Cazm4NYjIEAmBt4kXSBE/7cUTfjcRTlW7Qhgt35EJUSEFP5zVQJgC0kp9/qD4Q7GyoL9E4MiZDyxMWPLQ5VHMPUUtn/QuM1dNgDKVeOwwV7aEiLlb2zeCXJdF6knEhM4/PMeJqQ1WFDAHWvgm18D80=
Received: from MN0PR04CA0023.namprd04.prod.outlook.com (2603:10b6:208:52d::28)
 by LV2PR12MB5845.namprd12.prod.outlook.com (2603:10b6:408:176::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 21:02:20 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:52d:cafe::4b) by MN0PR04CA0023.outlook.office365.com
 (2603:10b6:208:52d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.12 via Frontend Transport; Thu, 9
 Jul 2026 21:02:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:20 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:01:59 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 "George Zhang" <george.zhang@amd.com>
Subject: [PATCH 31/80] drm/amd/display: Test irq state setters and work
Date: Thu, 9 Jul 2026 16:47:59 -0400
Message-ID: <20260709205936.5719-32-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|LV2PR12MB5845:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f39e598-40d8-4264-5943-08deddfd5dc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|56012099006|5023799004|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: T3JNTA8jCgQCQMLp7Fgbi7ok8tx9TiATebAsm5vSJ+hFqa/ePFKA2fUdRkA4jiJDncfyT5inWbuUmzjLSibYmV5mSKfENEVkrT031R88eQ8BxTZkpUZf0+oDWVIXB5+hWW72EnBX9V9YVsRMmV4LJXmMwNVKSpfMyRHp9xy+1U75s81vaCepShXoPPfKdU2sG4t+L3WInR9PahjxUndbCd+ZhDNFpxHvw4ftZGW6tPj5nvsRs9r4jCHhdpwi/fZrXNh4EHhaw6qxLupzrF+4aL1SIyG47wMSvFsMYq/rjvANAtG9ErAtIeSo2G4riNimWATBpzR8DPDlAAX2Xte7Bp21WuQE9ZNEe/bcAf6aa8rE0WPCtuD8yxLSh0XGctxJE+uQinnHzKTRVIAEdihHHUoCh/nLpSkQ3k7vk+D9AE2pJrSehHeAU4WYpCRSlMWQY7GWX2QNjFyy7PWz+CyvpWc00T0tnHf7bYkFGtl0pb+O4UAQJhu4kjJS28SWFzbi48LICCOtQ/vC4gZxKzPHeq7dAc2LYpkIj1jcQm6ajvSFr/Rg04zIlnZUC/ulrelAKkvrxS/F/I42CcG5IF+LQoCsVuHoBO4pOTHJNUpLQM3fT/TnIWuwolTjWDF/MWpzMYXtCq8xpyIxzaxz0YffJw44/kUsBVIUKVDrRXm/Ml7NHKf6A1TCuUGTrELILsxwlMGRxYlk35kMvsqt01ssdQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(56012099006)(5023799004)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Zn+wa8mqfV17AJDep6rhvuj+wCkvSvL5r2qQpWIvsXqTuhQYmgTXMEoop7Yj0r9JHCZiB0i7Bagsab4ML1PGNQutIvvPkDwf8AFGGSeZeNLkjribUhSoasDXcK7CS4Hc+nTSrAqDffHb+QaIvj4oAB3HInBZPHgQDZ4mZaUYajABVayyZBczB66rOgRYBzmB2bKnlWFDOIe9jFWY5567JFqovyMHNiPwEp/I04TFKkoCBxESbi5jRMGWzsm6Q3ajmo+8a9qR8kfih+EbhLOO6gu6ZJQg3qPd19Rl3EIBnRsIIPQzcwEUkVtt8cGQXsiELzNjW3MBKl7xR+bX/z/aRhpG5mGkuFqPJJiA80S1tZIqHRFGCw4VQDuP2Zv1RgMVxX4wNSxA4IkkLlDeaZIW/T/tjvTYuWH+I8zxkuApgNc3+rbO86Yfz80mQOTSHX6p
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:20.2745 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f39e598-40d8-4264-5943-08deddfd5dc9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5845
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

[WHAT]
Add KUnit tests for the per-source IRQ state callbacks (HPD, pflip,
CRTC, vline0, vupdate, dmub outbox/trace), the immediate and scheduled
IRQ work paths, and amdgpu_dm_outbox_init.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |  28 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h |  35 ++
 .../amdgpu_dm/tests/amdgpu_dm_irq_test.c      | 582 ++++++++++++++++++
 3 files changed, 636 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index ee74b212aebf..5af7f0bebdb8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -594,7 +594,7 @@ EXPORT_IF_KUNIT(amdgpu_dm_irq_resume_late);
  * amdgpu_dm_irq_schedule_work - schedule all work items registered for the
  * "irq_source".
  */
-static void amdgpu_dm_irq_schedule_work(struct amdgpu_device *adev,
+STATIC_IFN_KUNIT void amdgpu_dm_irq_schedule_work(struct amdgpu_device *adev,
 					enum dc_irq_source irq_source)
 {
 	struct  list_head *handler_list = &adev->dm.irq_handler_list_low_tab[irq_source];
@@ -643,12 +643,13 @@ static void amdgpu_dm_irq_schedule_work(struct amdgpu_device *adev,
 				  irq_source);
 	}
 }
+EXPORT_IF_KUNIT(amdgpu_dm_irq_schedule_work);

 /*
  * amdgpu_dm_irq_immediate_work
  * Callback high irq work immediately, don't send to work queue
  */
-static void amdgpu_dm_irq_immediate_work(struct amdgpu_device *adev,
+STATIC_IFN_KUNIT void amdgpu_dm_irq_immediate_work(struct amdgpu_device *adev,
 					 enum dc_irq_source irq_source)
 {
 	struct amdgpu_dm_irq_handler_data *handler_data;
@@ -667,6 +668,7 @@ static void amdgpu_dm_irq_immediate_work(struct amdgpu_device *adev,

 	DM_IRQ_TABLE_UNLOCK(adev, irq_table_flags);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_irq_immediate_work);

 /**
  * amdgpu_dm_irq_handler - Generic DM IRQ handler
@@ -719,7 +721,7 @@ STATIC_IFN_KUNIT enum dc_irq_source amdgpu_dm_hpd_to_dal_irq_source(unsigned int
 }
 EXPORT_IF_KUNIT(amdgpu_dm_hpd_to_dal_irq_source);

-static int amdgpu_dm_set_hpd_irq_state(struct amdgpu_device *adev,
+STATIC_IFN_KUNIT int amdgpu_dm_set_hpd_irq_state(struct amdgpu_device *adev,
 				       struct amdgpu_irq_src *source,
 				       unsigned int type,
 				       enum amdgpu_interrupt_state state)
@@ -730,6 +732,7 @@ static int amdgpu_dm_set_hpd_irq_state(struct amdgpu_device *adev,
 	dc_interrupt_set(adev->dm.dc, src, st);
 	return 0;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_set_hpd_irq_state);

 static inline int dm_irq_state(struct amdgpu_device *adev,
 			       struct amdgpu_irq_src *source,
@@ -765,7 +768,7 @@ static inline int dm_irq_state(struct amdgpu_device *adev,
 	return 0;
 }

-static int amdgpu_dm_set_pflip_irq_state(struct amdgpu_device *adev,
+STATIC_IFN_KUNIT int amdgpu_dm_set_pflip_irq_state(struct amdgpu_device *adev,
 					 struct amdgpu_irq_src *source,
 					 unsigned int crtc_id,
 					 enum amdgpu_interrupt_state state)
@@ -778,8 +781,9 @@ static int amdgpu_dm_set_pflip_irq_state(struct amdgpu_device *adev,
 		IRQ_TYPE_PFLIP,
 		__func__);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_set_pflip_irq_state);

-static int amdgpu_dm_set_crtc_irq_state(struct amdgpu_device *adev,
+STATIC_IFN_KUNIT int amdgpu_dm_set_crtc_irq_state(struct amdgpu_device *adev,
 					struct amdgpu_irq_src *source,
 					unsigned int crtc_id,
 					enum amdgpu_interrupt_state state)
@@ -792,8 +796,9 @@ static int amdgpu_dm_set_crtc_irq_state(struct amdgpu_device *adev,
 		IRQ_TYPE_VBLANK,
 		__func__);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_set_crtc_irq_state);

-static int amdgpu_dm_set_vline0_irq_state(struct amdgpu_device *adev,
+STATIC_IFN_KUNIT int amdgpu_dm_set_vline0_irq_state(struct amdgpu_device *adev,
 					struct amdgpu_irq_src *source,
 					unsigned int crtc_id,
 					enum amdgpu_interrupt_state state)
@@ -806,8 +811,9 @@ static int amdgpu_dm_set_vline0_irq_state(struct amdgpu_device *adev,
 		IRQ_TYPE_VLINE0,
 		__func__);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_set_vline0_irq_state);

-static int amdgpu_dm_set_dmub_outbox_irq_state(struct amdgpu_device *adev,
+STATIC_IFN_KUNIT int amdgpu_dm_set_dmub_outbox_irq_state(struct amdgpu_device *adev,
 					struct amdgpu_irq_src *source,
 					unsigned int crtc_id,
 					enum amdgpu_interrupt_state state)
@@ -818,8 +824,9 @@ static int amdgpu_dm_set_dmub_outbox_irq_state(struct amdgpu_device *adev,
 	dc_interrupt_set(adev->dm.dc, irq_source, st);
 	return 0;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_set_dmub_outbox_irq_state);

-static int amdgpu_dm_set_vupdate_irq_state(struct amdgpu_device *adev,
+STATIC_IFN_KUNIT int amdgpu_dm_set_vupdate_irq_state(struct amdgpu_device *adev,
 					   struct amdgpu_irq_src *source,
 					   unsigned int crtc_id,
 					   enum amdgpu_interrupt_state state)
@@ -832,8 +839,9 @@ static int amdgpu_dm_set_vupdate_irq_state(struct amdgpu_device *adev,
 		IRQ_TYPE_VUPDATE,
 		__func__);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_set_vupdate_irq_state);

-static int amdgpu_dm_set_dmub_trace_irq_state(struct amdgpu_device *adev,
+STATIC_IFN_KUNIT int amdgpu_dm_set_dmub_trace_irq_state(struct amdgpu_device *adev,
 					   struct amdgpu_irq_src *source,
 					   unsigned int type,
 					   enum amdgpu_interrupt_state state)
@@ -844,6 +852,7 @@ static int amdgpu_dm_set_dmub_trace_irq_state(struct amdgpu_device *adev,
 	dc_interrupt_set(adev->dm.dc, irq_source, st);
 	return 0;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_set_dmub_trace_irq_state);

 static const struct amdgpu_irq_src_funcs dm_crtc_irq_funcs = {
 	.set = amdgpu_dm_set_crtc_irq_state,
@@ -911,6 +920,7 @@ void amdgpu_dm_outbox_init(struct amdgpu_device *adev)
 		DC_IRQ_SOURCE_DMCUB_OUTBOX,
 		true);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_outbox_init);

 /**
  * amdgpu_dm_hpd_init - hpd setup callback.
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
index bccb5d354a9f..15e024947970 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
@@ -123,9 +123,44 @@ int amdgpu_dm_dcn10_register_irq_handlers(struct amdgpu_device *adev);
 int amdgpu_dm_register_outbox_irq_handlers(struct amdgpu_device *adev);

 #if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+struct amdgpu_irq_src;
+enum amdgpu_interrupt_state;
+
 enum dc_irq_source amdgpu_dm_hpd_to_dal_irq_source(unsigned int type);
 bool are_sinks_equal(const struct dc_sink *sink1, const struct dc_sink *sink2);
 const char *dmub_notification_type_str(enum dmub_notification_type e);
+int amdgpu_dm_set_hpd_irq_state(struct amdgpu_device *adev,
+				struct amdgpu_irq_src *source,
+				unsigned int type,
+				enum amdgpu_interrupt_state state);
+int amdgpu_dm_set_dmub_outbox_irq_state(struct amdgpu_device *adev,
+					struct amdgpu_irq_src *source,
+					unsigned int crtc_id,
+					enum amdgpu_interrupt_state state);
+int amdgpu_dm_set_dmub_trace_irq_state(struct amdgpu_device *adev,
+				       struct amdgpu_irq_src *source,
+				       unsigned int type,
+				       enum amdgpu_interrupt_state state);
+int amdgpu_dm_set_pflip_irq_state(struct amdgpu_device *adev,
+				  struct amdgpu_irq_src *source,
+				  unsigned int crtc_id,
+				  enum amdgpu_interrupt_state state);
+int amdgpu_dm_set_crtc_irq_state(struct amdgpu_device *adev,
+				 struct amdgpu_irq_src *source,
+				 unsigned int crtc_id,
+				 enum amdgpu_interrupt_state state);
+int amdgpu_dm_set_vline0_irq_state(struct amdgpu_device *adev,
+				   struct amdgpu_irq_src *source,
+				   unsigned int crtc_id,
+				   enum amdgpu_interrupt_state state);
+int amdgpu_dm_set_vupdate_irq_state(struct amdgpu_device *adev,
+				    struct amdgpu_irq_src *source,
+				    unsigned int crtc_id,
+				    enum amdgpu_interrupt_state state);
+void amdgpu_dm_irq_schedule_work(struct amdgpu_device *adev,
+				 enum dc_irq_source irq_source);
+void amdgpu_dm_irq_immediate_work(struct amdgpu_device *adev,
+				  enum dc_irq_source irq_source);
 #endif

 #endif /* __AMDGPU_DM_IRQ_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
index 7ea6f93ca998..7537d30cd983 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
@@ -33,6 +33,104 @@ static void dm_test_irq_handler_alt(void *arg)
 {
 }

+static void dm_test_irq_handler_count(void *arg)
+{
+	int *count = arg;
+
+	if (count)
+		(*count)++;
+}
+
+static struct dc *dm_test_alloc_dc_with_ctx(struct kunit *test)
+{
+	struct dc_context *ctx;
+	struct dc *dc;
+
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
+	dc->ctx = ctx;
+	ctx->dc = dc;
+
+	return dc;
+}
+
+static enum dc_irq_source dm_test_to_dal_irq_source_dcn10(
+		struct irq_service *irq_service,
+		uint32_t src_id,
+		uint32_t ext_id)
+{
+	switch (src_id) {
+	case DCN_1_0__SRCID__DC_D1_OTG_VSTARTUP:
+		return DC_IRQ_SOURCE_VBLANK1;
+	case DCN_1_0__SRCID__OTG0_IHC_V_UPDATE_NO_LOCK_INTERRUPT:
+		return DC_IRQ_SOURCE_VUPDATE1;
+	case DCN_1_0__SRCID__HUBP0_FLIP_INTERRUPT:
+		return DC_IRQ_SOURCE_PFLIP1;
+	case DCN_1_0__SRCID__DMCUB_OUTBOX_LOW_PRIORITY_READY_INT:
+		return DC_IRQ_SOURCE_DMCUB_OUTBOX;
+	default:
+		return DC_IRQ_SOURCE_INVALID;
+	}
+}
+
+static const struct irq_service_funcs dm_test_irq_service_funcs_dcn10 = {
+	.to_dal_irq_source = dm_test_to_dal_irq_source_dcn10
+};
+
+static bool dm_test_irq_src_set(struct irq_service *irq_service,
+				const struct irq_source_info *info, bool enable)
+{
+	return true;
+}
+
+static bool dm_test_irq_src_ack(struct irq_service *irq_service,
+				const struct irq_source_info *info)
+{
+	return true;
+}
+
+/* Per-source funcs let dc_interrupt_set() succeed without register access. */
+static struct irq_source_info_funcs dm_test_irq_src_funcs = {
+	.set = dm_test_irq_src_set,
+	.ack = dm_test_irq_src_ack,
+};
+
+static struct dc *dm_test_alloc_dc_with_irq_service(struct kunit *test,
+						    const struct irq_service_funcs *funcs)
+{
+	struct irq_source_info *info;
+	struct resource_pool *res_pool;
+	struct irq_service *irqs;
+	struct dc *dc;
+	int i;
+
+	dc = dm_test_alloc_dc_with_ctx(test);
+	res_pool = kunit_kzalloc(test, sizeof(*res_pool), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, res_pool);
+	irqs = kunit_kzalloc(test, sizeof(*irqs), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, irqs);
+
+	/*
+	 * Populate the per-source info table so dc_interrupt_set()/_ack()
+	 * succeed without touching hardware registers.
+	 */
+	info = kunit_kzalloc(test, sizeof(*info) * DAL_IRQ_SOURCES_NUMBER,
+			     GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, info);
+	for (i = 0; i < DAL_IRQ_SOURCES_NUMBER; i++)
+		info[i].funcs = &dm_test_irq_src_funcs;
+
+	irqs->funcs = funcs;
+	irqs->info = info;
+	res_pool->irqs = irqs;
+	dc->res_pool = res_pool;
+
+	return dc;
+}
+
 static void dm_test_crtc_list_del(void *data)
 {
 	struct amdgpu_crtc *acrtc = data;
@@ -1179,6 +1277,462 @@ static void dm_test_hpd_rx_irq_work_suspend_flushes(struct kunit *test)
 	amdgpu_dm_hpd_rx_irq_work_suspend(&adev->dm);
 }

+/* Tests for CRTC-based irq state callbacks (no-CRTC early return) */
+
+/**
+ * dm_test_set_crtc_irq_state_no_crtc - Test crtc irq state with missing CRTC
+ * @test: The KUnit test context
+ */
+static void dm_test_set_crtc_irq_state_no_crtc(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	/* mode_info.crtcs[0] is NULL -> returns 0 without dereferencing DC. */
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_set_crtc_irq_state(adev, NULL, 0, AMDGPU_IRQ_STATE_ENABLE), 0);
+}
+
+/**
+ * dm_test_set_pflip_irq_state_no_crtc - Test pflip irq state with missing CRTC
+ * @test: The KUnit test context
+ */
+static void dm_test_set_pflip_irq_state_no_crtc(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_set_pflip_irq_state(adev, NULL, 0, AMDGPU_IRQ_STATE_DISABLE), 0);
+}
+
+/**
+ * dm_test_set_vline0_irq_state_no_crtc - Test vline0 irq state with missing CRTC
+ * @test: The KUnit test context
+ */
+static void dm_test_set_vline0_irq_state_no_crtc(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_set_vline0_irq_state(adev, NULL, 0, AMDGPU_IRQ_STATE_ENABLE), 0);
+}
+
+/**
+ * dm_test_set_vupdate_irq_state_no_crtc - Test vupdate irq state with missing CRTC
+ * @test: The KUnit test context
+ */
+static void dm_test_set_vupdate_irq_state_no_crtc(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_set_vupdate_irq_state(adev, NULL, 0, AMDGPU_IRQ_STATE_ENABLE), 0);
+}
+
+/* Tests for CRTC-based irq state callbacks (dm_irq_state happy path) */
+
+/**
+ * dm_test_set_crtc_irq_state_otg_disabled - Test crtc irq state with disabled OTG
+ * @test: The KUnit test context
+ */
+static void dm_test_set_crtc_irq_state_otg_disabled(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+
+	/* otg_inst == -1 short-circuits before computing the irq source. */
+	acrtc->otg_inst = -1;
+	adev->mode_info.crtcs[0] = acrtc;
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_set_crtc_irq_state(adev, NULL, 0, AMDGPU_IRQ_STATE_ENABLE), 0);
+}
+
+/**
+ * dm_test_set_crtc_irq_state_enable - Test crtc irq state reaches DC (enable)
+ * @test: The KUnit test context
+ */
+static void dm_test_set_crtc_irq_state_enable(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+
+	/*
+	 * otg_inst >= 0 computes the irq source and reaches the NULL-safe
+	 * dc_interrupt_set(); the ips_support branch is skipped (dc == NULL).
+	 */
+	acrtc->otg_inst = 3;
+	adev->mode_info.crtcs[0] = acrtc;
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_set_crtc_irq_state(adev, NULL, 0, AMDGPU_IRQ_STATE_ENABLE), 0);
+}
+
+/**
+ * dm_test_set_pflip_irq_state_disable - Test pflip irq state reaches DC (disable)
+ * @test: The KUnit test context
+ */
+static void dm_test_set_pflip_irq_state_disable(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+
+	/* The disable state exercises the st == false path. */
+	acrtc->otg_inst = 1;
+	adev->mode_info.crtcs[0] = acrtc;
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_set_pflip_irq_state(adev, NULL, 0, AMDGPU_IRQ_STATE_DISABLE), 0);
+}
+
+/**
+ * dm_test_set_vline0_irq_state_enable - Test vline0 irq state reaches DC (enable)
+ * @test: The KUnit test context
+ */
+static void dm_test_set_vline0_irq_state_enable(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+
+	acrtc->otg_inst = 0;
+	adev->mode_info.crtcs[0] = acrtc;
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_set_vline0_irq_state(adev, NULL, 0, AMDGPU_IRQ_STATE_ENABLE), 0);
+}
+
+/**
+ * dm_test_set_vupdate_irq_state_enable - Test vupdate irq state reaches DC (enable)
+ * @test: The KUnit test context
+ */
+static void dm_test_set_vupdate_irq_state_enable(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+
+	acrtc->otg_inst = 2;
+	adev->mode_info.crtcs[0] = acrtc;
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_set_vupdate_irq_state(adev, NULL, 0, AMDGPU_IRQ_STATE_ENABLE), 0);
+}
+
+/**
+ * dm_test_set_crtc_irq_state_allows_idle - Test the idle-optimization branch
+ * @test: The KUnit test context
+ *
+ * With a non-NULL DC that advertises IPS support and currently allows idle
+ * optimizations, dm_irq_state() must call dc_allow_idle_optimizations() before
+ * dc_interrupt_set(). disable_idle_power_optimizations makes that call a safe
+ * early return, and per-source stub funcs let dc_interrupt_set() succeed.
+ */
+static void dm_test_set_crtc_irq_state_allows_idle(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc;
+	struct dal_logger *logger;
+	struct dc *dc;
+
+	adev = dm_kunit_alloc_adev(test);
+	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+
+	dc = dm_test_alloc_dc_with_irq_service(test, &dm_test_irq_service_funcs_dcn10);
+
+	/* DC_LOG_* dereferences ctx->logger->dev, so wire a real drm device. */
+	logger = kunit_kzalloc(test, sizeof(*logger), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, logger);
+	logger->dev = &adev->ddev;
+	dc->ctx->logger = logger;
+
+	dc->caps.ips_support = true;
+	dc->idle_optimizations_allowed = true;
+	/* Keep dc_allow_idle_optimizations() a safe early return. */
+	dc->debug.disable_idle_power_optimizations = true;
+	adev->dm.dc = dc;
+
+	acrtc->otg_inst = 0;
+	adev->mode_info.crtcs[0] = acrtc;
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_set_crtc_irq_state(adev, NULL, 0, AMDGPU_IRQ_STATE_ENABLE), 0);
+}
+
+/* Tests for amdgpu_dm_irq_immediate_work() */
+
+/**
+ * dm_test_irq_immediate_work_empty - Test immediate work on empty high table
+ * @test: The KUnit test context
+ */
+static void dm_test_irq_immediate_work_empty(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
+
+	/* No registered high-context handlers: must be a safe no-op. */
+	amdgpu_dm_irq_immediate_work(adev, DC_IRQ_SOURCE_HPD1);
+}
+
+/**
+ * dm_test_irq_immediate_work_invokes_handler - Test immediate work calls handler
+ * @test: The KUnit test context
+ */
+static void dm_test_irq_immediate_work_invokes_handler(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc_interrupt_params int_params = { 0 };
+	int count = 0;
+	void *handler;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
+
+	int_params.int_context = INTERRUPT_HIGH_IRQ_CONTEXT;
+	int_params.irq_source = DC_IRQ_SOURCE_HPD1;
+	handler = amdgpu_dm_irq_register_interrupt(adev, &int_params,
+						   dm_test_irq_handler_count, &count);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, handler);
+
+	/* High-context handlers are invoked synchronously, in-place. */
+	amdgpu_dm_irq_immediate_work(adev, DC_IRQ_SOURCE_HPD1);
+	KUNIT_EXPECT_EQ(test, count, 1);
+
+	amdgpu_dm_irq_unregister_interrupt(adev, DC_IRQ_SOURCE_HPD1, dm_test_irq_handler_count);
+}
+
+/**
+ * dm_test_irq_immediate_work_invokes_all - Test immediate work calls all handlers
+ * @test: The KUnit test context
+ */
+static void dm_test_irq_immediate_work_invokes_all(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc_interrupt_params int_params = { 0 };
+	int count = 0;
+	void *handler;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
+
+	int_params.int_context = INTERRUPT_HIGH_IRQ_CONTEXT;
+	int_params.irq_source = DC_IRQ_SOURCE_HPD2;
+	handler = amdgpu_dm_irq_register_interrupt(adev, &int_params,
+						   dm_test_irq_handler_count, &count);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, handler);
+	handler = amdgpu_dm_irq_register_interrupt(adev, &int_params,
+						   dm_test_irq_handler_count, &count);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, handler);
+
+	/* Both registered high-context handlers must run. */
+	amdgpu_dm_irq_immediate_work(adev, DC_IRQ_SOURCE_HPD2);
+	KUNIT_EXPECT_EQ(test, count, 2);
+
+	amdgpu_dm_irq_unregister_interrupt(adev, DC_IRQ_SOURCE_HPD2, dm_test_irq_handler_count);
+	amdgpu_dm_irq_unregister_interrupt(adev, DC_IRQ_SOURCE_HPD2, dm_test_irq_handler_count);
+}
+
+/* Tests for amdgpu_dm_irq_schedule_work() */
+
+/**
+ * dm_test_irq_schedule_work_empty - Test schedule work on empty low table
+ * @test: The KUnit test context
+ */
+static void dm_test_irq_schedule_work_empty(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
+
+	/* Empty handler list: schedule_work returns immediately. */
+	amdgpu_dm_irq_schedule_work(adev, DC_IRQ_SOURCE_HPD1);
+}
+
+/**
+ * dm_test_irq_schedule_work_queues_handler - Test schedule work runs handler
+ * @test: The KUnit test context
+ */
+static void dm_test_irq_schedule_work_queues_handler(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc_interrupt_params int_params = { 0 };
+	int count = 0;
+	void *handler;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
+
+	int_params.int_context = INTERRUPT_LOW_IRQ_CONTEXT;
+	int_params.irq_source = DC_IRQ_SOURCE_HPD1;
+	handler = amdgpu_dm_irq_register_interrupt(adev, &int_params,
+						   dm_test_irq_handler_count, &count);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, handler);
+
+	amdgpu_dm_irq_schedule_work(adev, DC_IRQ_SOURCE_HPD1);
+
+	/*
+	 * Low-context work runs asynchronously on system_highpri_wq.
+	 * amdgpu_dm_irq_fini() flushes each pending work item before freeing
+	 * the handlers, so the handler is guaranteed to have run afterwards.
+	 */
+	amdgpu_dm_irq_fini(adev);
+	KUNIT_EXPECT_EQ(test, count, 1);
+}
+
+/**
+ * dm_test_irq_schedule_work_requeue_fallback - Test the re-queue fallback path
+ * @test: The KUnit test context
+ *
+ * The first schedule queues the handler's work item. Issuing a second
+ * schedule before the work has run makes queue_work() fail for the
+ * still-pending item, forcing amdgpu_dm_irq_schedule_work() into the fallback
+ * that allocates and queues a fresh handler copy. Both work items run when
+ * amdgpu_dm_irq_fini() flushes the queue, so the handler fires twice.
+ */
+static void dm_test_irq_schedule_work_requeue_fallback(struct kunit *test)
+{
+	struct dc_interrupt_params int_params = { 0 };
+	struct amdgpu_device *adev;
+	int count = 0;
+	void *handler;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
+
+	int_params.int_context = INTERRUPT_LOW_IRQ_CONTEXT;
+	int_params.irq_source = DC_IRQ_SOURCE_HPD1;
+	handler = amdgpu_dm_irq_register_interrupt(adev, &int_params,
+						   dm_test_irq_handler_count, &count);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, handler);
+
+	amdgpu_dm_irq_schedule_work(adev, DC_IRQ_SOURCE_HPD1);
+	amdgpu_dm_irq_schedule_work(adev, DC_IRQ_SOURCE_HPD1);
+
+	amdgpu_dm_irq_fini(adev);
+	KUNIT_EXPECT_EQ(test, count, 2);
+}
+
+/* Tests for amdgpu_dm_set_hpd_irq_state() */
+
+/**
+ * dm_test_set_hpd_irq_state_null_dc - Test HPD irq state with no DC
+ * @test: The KUnit test context
+ */
+static void dm_test_set_hpd_irq_state_null_dc(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	/* dc_interrupt_set() is a no-op when dc is NULL, so both states
+	 * return 0 without dereferencing the (absent) DC.
+	 */
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_set_hpd_irq_state(adev, NULL, AMDGPU_HPD_1,
+							  AMDGPU_IRQ_STATE_ENABLE), 0);
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_set_hpd_irq_state(adev, NULL, AMDGPU_HPD_1,
+							  AMDGPU_IRQ_STATE_DISABLE), 0);
+}
+
+/* Tests for amdgpu_dm_set_dmub_outbox_irq_state() */
+
+/**
+ * dm_test_set_dmub_outbox_irq_state_null_dc - Test outbox irq state with no DC
+ * @test: The KUnit test context
+ */
+static void dm_test_set_dmub_outbox_irq_state_null_dc(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_set_dmub_outbox_irq_state(adev, NULL, 0,
+								  AMDGPU_IRQ_STATE_ENABLE), 0);
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_set_dmub_outbox_irq_state(adev, NULL, 0,
+								  AMDGPU_IRQ_STATE_DISABLE), 0);
+}
+
+/* Tests for amdgpu_dm_set_dmub_trace_irq_state() */
+
+/**
+ * dm_test_set_dmub_trace_irq_state_null_dc - Test trace irq state with no DC
+ * @test: The KUnit test context
+ */
+static void dm_test_set_dmub_trace_irq_state_null_dc(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_set_dmub_trace_irq_state(adev, NULL, 0,
+								 AMDGPU_IRQ_STATE_ENABLE), 0);
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_set_dmub_trace_irq_state(adev, NULL, 0,
+								 AMDGPU_IRQ_STATE_DISABLE), 0);
+}
+
+/* Tests for amdgpu_dm_outbox_init() */
+
+/**
+ * dm_test_outbox_init_null_dc - Test outbox init is a safe no-op with no DC
+ * @test: The KUnit test context
+ */
+static void dm_test_outbox_init_null_dc(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	/* Single dc_interrupt_set() call must be skipped when dc is NULL. */
+	amdgpu_dm_outbox_init(adev);
+}
+
 static struct kunit_case amdgpu_dm_irq_tests[] = {
 	/* amdgpu_dm_hpd_to_dal_irq_source */
 	KUNIT_CASE(dm_test_hpd_to_dal_irq_source_hpd1),
@@ -1247,6 +1801,34 @@ static struct kunit_case amdgpu_dm_irq_tests[] = {
 	/* amdgpu_dm_hpd_rx_irq_work_suspend */
 	KUNIT_CASE(dm_test_hpd_rx_irq_work_suspend_null),
 	KUNIT_CASE(dm_test_hpd_rx_irq_work_suspend_flushes),
+	/* CRTC-based irq state callbacks (no-CRTC early return) */
+	KUNIT_CASE(dm_test_set_crtc_irq_state_no_crtc),
+	KUNIT_CASE(dm_test_set_pflip_irq_state_no_crtc),
+	KUNIT_CASE(dm_test_set_vline0_irq_state_no_crtc),
+	KUNIT_CASE(dm_test_set_vupdate_irq_state_no_crtc),
+	/* CRTC-based irq state callbacks (dm_irq_state happy path) */
+	KUNIT_CASE(dm_test_set_crtc_irq_state_otg_disabled),
+	KUNIT_CASE(dm_test_set_crtc_irq_state_enable),
+	KUNIT_CASE(dm_test_set_pflip_irq_state_disable),
+	KUNIT_CASE(dm_test_set_vline0_irq_state_enable),
+	KUNIT_CASE(dm_test_set_vupdate_irq_state_enable),
+	KUNIT_CASE(dm_test_set_crtc_irq_state_allows_idle),
+	/* amdgpu_dm_irq_immediate_work */
+	KUNIT_CASE(dm_test_irq_immediate_work_empty),
+	KUNIT_CASE(dm_test_irq_immediate_work_invokes_handler),
+	KUNIT_CASE(dm_test_irq_immediate_work_invokes_all),
+	/* amdgpu_dm_irq_schedule_work */
+	KUNIT_CASE(dm_test_irq_schedule_work_empty),
+	KUNIT_CASE(dm_test_irq_schedule_work_queues_handler),
+	KUNIT_CASE(dm_test_irq_schedule_work_requeue_fallback),
+	/* amdgpu_dm_set_hpd_irq_state */
+	KUNIT_CASE(dm_test_set_hpd_irq_state_null_dc),
+	/* amdgpu_dm_set_dmub_outbox_irq_state */
+	KUNIT_CASE(dm_test_set_dmub_outbox_irq_state_null_dc),
+	/* amdgpu_dm_set_dmub_trace_irq_state */
+	KUNIT_CASE(dm_test_set_dmub_trace_irq_state_null_dc),
+	/* amdgpu_dm_outbox_init */
+	KUNIT_CASE(dm_test_outbox_init_null_dc),
 	{}
 };

--
2.55.0

