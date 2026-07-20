Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C240C44515
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jul 2026 07:11:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15CCA10E6C0;
	Mon, 20 Jul 2026 07:11:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OYa0+5cB";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011055.outbound.protection.outlook.com
 [40.93.194.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3117910E6C0
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jul 2026 07:11:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q6eQ+mDA73Mss7Q1s3YSs24tu1pJ89+Pjvysgy0LpoAbMuZLrSh+H2OzD1udQlZLfWvb4kikXVlyDEgVZWAoZsHErNB0bxYzYND5wL0IJ7H0+ozM60Tz7vPV7stGwyhtry6GYuChARsdWAhELT67QQhiCpd0bcUJTmgFQ5g1ntpg9fSgMlZJs1pItT5fH0sOoUX4Pj9QtLl8XZB0CsN1+FoB5Z9Y98OujuEdurE6a7dcaEkDeQUDtaTnu3X5dbPoLuQl5w0oBsCIAlMqha+9noRkITh35Zr+ZWG7DJFUYBUtvey/JGZUuffqxfRpUarRlQRg7WJPf5cRNW93Bf40JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j8OxqUJFiIZFHIZHfUFITNazc1xG6E7ATa3zw5rUs4c=;
 b=AWCRmeeBVwl5MgNsk+diyAAuR/xBj8C8B27rOIRS9FIxVAYSVSSzrhzyR9E2vD7Oy2hBtlqFKWeDodZCFBnmpywMVyWd4Y+2XtmS8mNP/EIus6IN/slc69FEI11C3Qirol/x+/N76AyvElR1u0dQMhhV8J+GaUchAsD5TgtW+xLZIzvfIZSmXbfVumUJlFJGaRAR8OQAWj/iofrpMQL5b1OTwwDAz7seeACPr/VPmEfRqDqmEyCBoAFEumbVKLFshoPYzTbCz6T6h2lDZT8O6xWJiuxUWFE+m1YC6jboGHhUE3fPCW8iQkZFkHPw+sffHavMRHPJbb75o0LUKQ8bww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8OxqUJFiIZFHIZHfUFITNazc1xG6E7ATa3zw5rUs4c=;
 b=OYa0+5cBrXvL0Rgam/BtoaSRuqi7wJlIjjq7PSopcDUMTdNqyHMTm3+0j1V4o31DW4qFYufao83e5emsXtMhTjQFLyDHztnK+2KDCBDFxenBGVxuVg/lb5AkqfS8HKeo0yIHbuVCzxQO3KBdaaLNibLq0VBIvCSGOQyOjfW3zYQ=
Received: from SJ0PR13CA0002.namprd13.prod.outlook.com (2603:10b6:a03:2c0::7)
 by LV8PR12MB9334.namprd12.prod.outlook.com (2603:10b6:408:20b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 07:11:25 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::6b) by SJ0PR13CA0002.outlook.office365.com
 (2603:10b6:a03:2c0::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.9 via Frontend Transport; Mon, 20
 Jul 2026 07:11:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Mon, 20 Jul 2026 07:11:24 +0000
Received: from ram-Splinter.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 20 Jul
 2026 02:11:22 -0500
From: Kanala Ramalingeswara Reddy <Kanala.RamalingeswaraReddy@amd.com>
To: <Alexander.Deucher@amd.com>, <Mario.Limonciello@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <Pratik.Vishwakarma@amd.com>,
 <Lijo.Lazar@amd.com>
CC: <Kanala.RamalingeswaraReddy@amd.com>
Subject: [PATCH] drm/amdgpu: Reuse common IP firmwares for GC 11.7.1 from GC
 11.7.0
Date: Mon, 20 Jul 2026 12:41:05 +0530
Message-ID: <20260720071105.3214694-1-Kanala.RamalingeswaraReddy@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|LV8PR12MB9334:EE_
X-MS-Office365-Filtering-Correlation-Id: 42c4ed29-de1b-43ca-8948-08dee62e1c3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: gKe2lXtwhcYJNYYi7dGg/9PShVLyAM3nsg1/HZj08Mshj3xkmMcn1F/nMzfho3cAjJC7Ro6oUy+7GVJl6wld6Xd+m8auzLAbWxyc3JoBfh3UkbdyZgBcaGWXaosgJJ9MujR22vw4pdhMD5UGRksIPY+SOf6GKl0sexwMWqGAUbh79JqZ+283AFk7CaFuSD0ddp3RcTuZx1lABfSjDY2qfFi4z/OWTB2bgyrPzCH8pnonvkbzr0onnWanWyGChgrp01+LGUid3u8DHWUEstN701uXgeLaOYrQTnscLEUjsT/njtnuD0xhyrEhkpmR1SU+sKEM+jfgatTRGVmh9IrKFQieDjo5xH31IpNCsbiwvMUm7nkLxmC4Li5sKGWVv/aNoWpYqAIO2WobiqX+VIMuVd8LWoGwLcgj7mviLAlNW0SHdqWXAbOy06zz8zVr4tS9346rCAn+xE26Fpkpv5uuzt848fQkscf0VW9r05ZO/XE1FBpbhtYWtNHMGOLlVTTO/ERosfGPfxRLfdKn0wWmB7tyJZOo3qhrP8BMhjZslCI/aKsDxAGETVuUOCMH4z7GWY+SS/YTHFtRVOWykrBIBDyEwFf3bg908CLcSO0byqtI2W/thwRGCB/4QO/HmbV9FzNGgWxh6ICwYBqvVMkAF6copXeYo9hpU4OxZ66DTW5JlsB2tcP2wTeV4QuE4Xu6RhsuBmMZKJtTFlv5+ZTZwg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JdUWdXAbiOOrE80K2I+5Lu76x8Z6fjdWqcotHnfy6P3SSORRUh66kFPGEZMBU2OwBpCYcRgHZulLhdvWoW8RxHeG4Rkz+KAHIHTfu8tOzmkWZ4jXEkEYi18oopkMa/cjSTkCQIo1LxZ4oGpEvyEzP0RmwRM0NSOrj5tj7mxfI3HtqkcLq0lGN3ZY7qMjpKM8HqBj5g8M4nBG1WjLyZqNa6gTSOmqBV5xs78Z+KxpfBaoWyFKA7VXCCZpym0Eznatm0PRdmEx2J+oh093BsMS3QiEcAWhR/d58NEe8IvycaQddSskLKxhB0z0m+SY8SQ3XjTlVErq2O6giAWLXMQBTKTqvi3l4N17wbzj0wMIF59kiD0j0zV1+GzOkVL/REkFg2Ijx0RAKHOW9e45vpeKmIfWZGgQgTPB7NrKUMaUsg4lQwDYWCHuOBY3kPjH3uvM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 07:11:24.8323 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c4ed29-de1b-43ca-8948-08dee62e1c3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9334
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

RLC and PSP TOC firmwares are different, rest all firmwares are
same for GC 11.7.0 and GC 11.7.1. Reuse VCN,VPE,SDMA,DMU,MES,PFP,
ME,MEC,IMU and PSP TA firmwares for GC 11.7.1 from GC 11.7.0

Signed-off-by: Kanala Ramalingeswara Reddy <Kanala.RamalingeswaraReddy@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c    | 11 ++++++++---
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c    |  1 -
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c    |  2 --
 drivers/gpu/drm/amd/amdgpu/psp_v15_0.c    |  7 ++++++-
 5 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 4f1c711df5bd..ee0b785b4a39 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -1458,6 +1458,12 @@ void amdgpu_ucode_ip_version_decode(struct amdgpu_device *adev, int block_type,
 	switch (block_type) {
 	case GC_HWIP:
 		ip_name = "gc";
+		/*
+		 *RLC fw is different and rest all fw are same for GC 11.7.0
+		 *and GC 11.7.1
+		 */
+		if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 7, 1))
+			version = IP_VERSION(11, 7, 0);
 		break;
 	case SDMA0_HWIP:
 		ip_name = "sdma";
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 0cbbdc3694f4..710bd195c4b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -137,9 +137,6 @@ MODULE_FIRMWARE("amdgpu/gc_11_7_0_pfp.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_7_0_me.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_7_0_mec.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_7_0_rlc.bin");
-MODULE_FIRMWARE("amdgpu/gc_11_7_1_pfp.bin");
-MODULE_FIRMWARE("amdgpu/gc_11_7_1_me.bin");
-MODULE_FIRMWARE("amdgpu/gc_11_7_1_mec.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_7_1_rlc.bin");
 
 static const struct amdgpu_hwip_reg_entry gc_reg_list_11_0[] = {
@@ -745,6 +742,7 @@ static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
 	DRM_DEBUG("\n");
 
 	amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof(ucode_prefix));
+
 	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
 				   AMDGPU_UCODE_REQUIRED,
 				   "amdgpu/%s_pfp.bin", ucode_prefix);
@@ -786,6 +784,13 @@ static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
 			err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
 						   AMDGPU_UCODE_REQUIRED,
 						   "amdgpu/%s_rlc_kicker.bin", ucode_prefix);
+		/*
+		 *RLC fw is different for GC 11.7.0 and GC 11.7.1
+		 */
+		else if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 7, 1))
+			err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
+						   AMDGPU_UCODE_REQUIRED,
+						   "amdgpu/gc_11_7_1_rlc.bin");
 		else
 			err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
 						   AMDGPU_UCODE_REQUIRED,
diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
index 09dc01a425d1..2fc2a8e4be98 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
@@ -44,7 +44,6 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_3_imu.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_4_imu.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_6_imu.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_7_0_imu.bin");
-MODULE_FIRMWARE("amdgpu/gc_11_7_1_imu.bin");
 
 static int imu_v11_0_init_microcode(struct amdgpu_device *adev)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index b72da75dd851..988afc0631b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -62,8 +62,6 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_6_mes_2.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_6_mes1.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes_2.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes1.bin");
-MODULE_FIRMWARE("amdgpu/gc_11_7_1_mes_2.bin");
-MODULE_FIRMWARE("amdgpu/gc_11_7_1_mes1.bin");
 
 static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block);
 static int mes_v11_0_hw_fini(struct amdgpu_ip_block *ip_block);
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
index 2a4d91368ac6..c78a8f1e8c8a 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
@@ -34,7 +34,6 @@
 MODULE_FIRMWARE("amdgpu/psp_15_0_0_toc.bin");
 MODULE_FIRMWARE("amdgpu/psp_15_0_0_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_15_0_9_toc.bin");
-MODULE_FIRMWARE("amdgpu/psp_15_0_9_ta.bin");
 
 static int psp_v15_0_0_init_microcode(struct psp_context *psp)
 {
@@ -48,6 +47,12 @@ static int psp_v15_0_0_init_microcode(struct psp_context *psp)
 	if (err)
 		return err;
 
+	/*
+	 *PSP ta FW is same for PSP v15_0_9 and PSP v15_0_0
+	 */
+	if (amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(15, 0, 9))
+		snprintf(ucode_prefix, sizeof(ucode_prefix), "%s", "psp_15_0_0");
+
 	err = psp_init_ta_microcode(psp, ucode_prefix);
 	if (err)
 		return err;
-- 
2.53.0

