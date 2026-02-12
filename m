Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 547C5EB270C
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Feb 2026 01:10:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED08410E6B0;
	Thu, 12 Feb 2026 01:10:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xoNwh4Vg";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012007.outbound.protection.outlook.com [52.101.43.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13BEC10E6B0
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Feb 2026 01:10:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jsgTGjp+AJ9xLvBrShZu4nP+P5PBdo+XQ9APQsrv/rccwawiKlTBA8Q6anpdwyI6wLzDmuBjidp5e5VcVpDOYK9biZ/Z0t4+Wp/4ds/qJbTVhm9MAjm8vK+JMQOFTrtYrqaMQ0NWdvKiftLwwe6w8LYAFl3TZRGly7OwNmAxJNoZvE+3bCP3se3RsJWZHGc7t0k+OUJ63O7ywb2xST7q9h/IMdqg4/geN7PcDoj40WWunQfbVrT16hG+XjqnrnRNuKwfNUaEqwcIJif8aWPUDjH3Vwkckm+xFqNm8bMgWErmrH7b1VH8IKFyhtCaxe5vQxDoGf0sgONPm9WvGKYybg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfNPKYw7aUBfs5D6+G0bfQ+cAxlPtbx+7tTBGfHzs10=;
 b=QzSBnWBRpLfC8ULoljy0hFHfDT0+wCg2shV1RL86tgB1KjfN+XQimbAhJyneglMtH1W+cMEqz2g+KDSqq3+mKi5pH7XoPQIz/wPYzg8C6vGzRY9tTw9t6oR4EDVItSJZpBtwj97W+c9c8Yy2ePMzgfGvTeGY0hg/qbk2VPHDvOuRv00LSTiJE69Ad84T3gkrwKfBxnh6mVnjtLxUAA0u8WdfuldkT5Hqj7PRsA4mOGoeYmeXPLZ/7vzNzolfOJzrLGqFKr5ZpzhExFROODDejEzZ1qMdIJHwx7vaDNF6XRZs9X01TWSKUP+jKZ3/MGqJUUFmdC/JqYK7XtQPf4iKYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfNPKYw7aUBfs5D6+G0bfQ+cAxlPtbx+7tTBGfHzs10=;
 b=xoNwh4VgxuR+6ZEnMeDs7Z89/5LIWn90h75FyJAd7HVV8pVT77PlvyXMZ8ICU9O63LVML2FAEAkEx2gl2eelb9DePkXopzGKmrrxJa8KT+N0tFtGiuFb0un2H9TuTRJWLWAv/In9LOEQc446TNEGDg15/cx37y7+x1Qh2iiDoQA=
Received: from PH8P223CA0005.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::19)
 by DM4PR12MB8572.namprd12.prod.outlook.com (2603:10b6:8:17d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Thu, 12 Feb
 2026 01:10:14 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:510:2db:cafe::5c) by PH8P223CA0005.outlook.office365.com
 (2603:10b6:510:2db::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.10 via Frontend Transport; Thu,
 12 Feb 2026 01:10:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Thu, 12 Feb 2026 01:10:12 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Feb
 2026 19:10:02 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 11 Feb 2026 19:10:01 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>, Roman Li
 <Roman.Li@amd.com>
Subject: [PATCH 7/7] drm/amd/display: Enable dcn42 in DM
Date: Wed, 11 Feb 2026 20:09:49 -0500
Message-ID: <20260212010949.654686-8-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260212010949.654686-1-Roman.Li@amd.com>
References: <20260212010949.654686-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|DM4PR12MB8572:EE_
X-MS-Office365-Filtering-Correlation-Id: ccc03e5b-deb9-4d33-b91d-08de69d3795c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7rp68yXeKX4Dq5m35LeLSWQuiici/evj1bo4Siw4TCc8kxLJBthE+je+fjA9?=
 =?us-ascii?Q?iivDIyLuDdg/QR7KFheYHjSjAnNT3alHj+HVeHP8L2EU6L3qw/p79oOIzE5L?=
 =?us-ascii?Q?QIMdw3fakJIF4nbx24ArMWfDb+1rLWBEbF3aBJHAZp76/De1jyqMj5fHEGKS?=
 =?us-ascii?Q?ieq5SS8941ZlM+WG3PFnoOPBQ746SXkHIUPtR3GM7+IMZp0/rpFbLoI7rX/e?=
 =?us-ascii?Q?f42ETatDn3Sij/MTL2CeTUsVUuqB06EnkLTgklQxEcBwbOU5vhPJsK62CmyW?=
 =?us-ascii?Q?k+q4JcQM31zsQI7w9DJjyrUi6XnVOGGlovH/BJr93Qgw3F0O239flJmQUUzc?=
 =?us-ascii?Q?pqLqEAPx/eLbIbuE1SWBvG5IAb/px8yW3SxLrcH18KEehFoJWw+GO7pMARXL?=
 =?us-ascii?Q?SUiv2Byho4iCGSd2Cp/I4AcQ68RXYmk040vJ+2Li4M7+x0MSQ1WxcwzDKArd?=
 =?us-ascii?Q?toECbkRa+AESOvGTz5nWbsqAsr2MIvMy24whpZC9nbfCiKCNrjilrR226NGN?=
 =?us-ascii?Q?Mf8QLBxdfT9K6JbmydB/BpzTNfcmg9+5eFFt8vze/KBYIqWCv8SR6GRwj0Dt?=
 =?us-ascii?Q?0FAwLz6P8AEV3iIXKdfpCUE3j3xu3KIP+OQsgkicjmsaYrEjcxas2qwzRwNG?=
 =?us-ascii?Q?BzDNenpW+vNvkKrA93zZA1knS7lFNCUa11xLSi/Ct8q46tW/yC5sREDtVAQx?=
 =?us-ascii?Q?ki6V7l40rgiWkq+dLvbgOBDWkTgGtvlNBwjfseorrOG2dS7EPPAXzKwOhAVM?=
 =?us-ascii?Q?qIa2vTlWN3SH6b4J2+4hPTS7I1356eBLi4XFPvG3Z3wt4pcYFpwrD5y5UP6t?=
 =?us-ascii?Q?Xck1H1kjgqxKSM80z+A/09x27yOGAWq8/2PWpous2Oye+3C8Y8YiTmwmVliS?=
 =?us-ascii?Q?DNFWYcKaDR0AlBBNCJHiMNATVotOJ0EXZeD/g7CFzJLuSFcOtEGcEYeXLoFS?=
 =?us-ascii?Q?9T0EcGDqyp3tktPlfyPfLtnAGFL06+S6aX2bq4ehCS1XddcTdgDAQnKHQFwx?=
 =?us-ascii?Q?LPLeNgnBDaFnrkf5PzcLJLhJ0WbAL5Vsfp2+P+D7pHNshFI80ke3zHYzz+a+?=
 =?us-ascii?Q?ro1z+CYUtzlmFGwyYd1hmngJRUtVNtVHfL7V8L15PX/7hUYeSH4Lgdy0e6rw?=
 =?us-ascii?Q?W2DtTLGSSMISaiELcETnk6rCH1Qn2jAKmNPR5PD7XiO4wbVKCdt+kX2cv52P?=
 =?us-ascii?Q?b1VLjqDzNulzhFVCmxCtO++8MbCFR1IsJ92HmvSeEZQT+coHcRmOwO9+0bGA?=
 =?us-ascii?Q?+zqEq/6BsrKT1sH6UCw6eQ7IY/AuXkbEB3F2vmiDe6mZZPp7XcAAg3AoaTfm?=
 =?us-ascii?Q?WbyvqHXpuckISttExjv8ysZDj/XeSzHH47aqtdZlej4Bd95KWrschMr4rRFx?=
 =?us-ascii?Q?Vr11hecaumDoXBSPaHTiIC8WGeXNycoXwLFDHgfCA6FIJMnhnBI2JcY/mHyg?=
 =?us-ascii?Q?70v1uC8z4a2nbTmt5tqmQn4h63wKKBNikKG2viz773V0/XhW3fj9JHe/QGb9?=
 =?us-ascii?Q?YI5SU55z/eV+t9G3aDjzFx7tosd7qVqgLTS5FMvUosbDXpyj/FBqn6zTKkao?=
 =?us-ascii?Q?iO5pLuogoOXrpArW9zI49fcniloMvZdvzGPSen+l3c+c4AYR2LSae1+lELKS?=
 =?us-ascii?Q?B3X8qHmsyMj+Ohr03c75Uvhzdlc+0Jh7dKdOpHIIJiwr0W/jtFcAuy/ot/nO?=
 =?us-ascii?Q?suhGng=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4bukWwyDAQ8uS0sHuFCV4NcR4kdzTRM4Raxf5LAklC1y4G83qOUxJxGEo1wzVu222/qfqnC91sJ/eAnpYwK54wHZxHNJfphhCMRHcRJtK8LM7bVQJ54Gf58SL6vJfpWm1R6ot9+L0/HzLKnsRGZjVruna9LgPTvi//7CBnYrkXnj25VCa+Okcj/ob/JCt+s3NcL6ix6lcPqTFtB0WvoxUlzCWqvBK23qes3W4HXGdLYqG5KrEaVfZ7PN7SOcYIjMGuAG7ylhOsvQU9P1Sch7wRt7UTa4DEqmkOmQGe0JIqKyI3308o7hkX67JeOkK/IKudHg7ZIkN3EGy1HbI9H0+7MUwPomlf61IXj6cUkuN4aixg7U33JIEnFYk9cJNTva8KAW24b9A30WeL6DMwrfbD13k8ehjCfPbW1UA1Maj742pID1HGTNlNRek1BEf5m2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 01:10:12.7986 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc03e5b-deb9-4d33-b91d-08de69d3795c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8572
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

From: Roman Li <Roman.Li@amd.com>

Add support for DCN 4.2 in Display Manager

Signed-off-by: Roman Li <Roman.Li@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 41 ++++++++++++++++---
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |  3 +-
 2 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 12bebdfd7fdc..024a502fbc58 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: MIT
 /*
- * Copyright 2015 Advanced Micro Devices, Inc.
+ * Copyright 2015-2026 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
@@ -152,6 +152,9 @@ MODULE_FIRMWARE(FIRMWARE_DCN_36_DMUB);
 #define FIRMWARE_DCN_401_DMUB "amdgpu/dcn_4_0_1_dmcub.bin"
 MODULE_FIRMWARE(FIRMWARE_DCN_401_DMUB);
 
+#define FIRMWARE_DCN_42_DMUB "amdgpu/dcn_4_2_dmcub.bin"
+MODULE_FIRMWARE(FIRMWARE_DCN_42_DMUB);
+
 /**
  * DOC: overview
  *
@@ -1365,6 +1368,7 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 	case IP_VERSION(3, 5, 0):
 	case IP_VERSION(3, 5, 1):
 	case IP_VERSION(3, 6, 0):
+	case IP_VERSION(4, 2, 0):
 		hw_params.ips_sequential_ono = adev->external_rev_id > 0x10;
 		hw_params.lower_hbr3_phy_ssc = true;
 		break;
@@ -1812,6 +1816,9 @@ static void *dm_dmub_get_vbios_bounding_box(struct amdgpu_device *adev)
 	case IP_VERSION(4, 0, 1):
 		bb_size = sizeof(struct dml2_soc_bb);
 		break;
+	case IP_VERSION(4, 2, 0):
+		bb_size = sizeof(struct dml2_soc_bb);
+		break;
 	default:
 		return NULL;
 	}
@@ -1856,6 +1863,9 @@ static enum dmub_ips_disable_type dm_get_default_ips_mode(
 	case IP_VERSION(3, 5, 1):
 		ret =  DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF;
 		break;
+	case IP_VERSION(4, 2, 0):
+		ret =  DMUB_IPS_DISABLE_ALL;
+		break;
 	default:
 		/* ASICs older than DCN35 do not have IPSs */
 		if (amdgpu_ip_version(adev, DCE_HWIP, 0) < IP_VERSION(3, 5, 0))
@@ -1999,6 +2009,13 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	if (amdgpu_ip_version(adev, DCE_HWIP, 0) >= IP_VERSION(3, 0, 0))
 		init_data.num_virtual_links = 1;
 
+	/* DCN42 and above dpia switch to unified link training path */
+	if (amdgpu_ip_version(adev, DCE_HWIP, 0) >= IP_VERSION(4, 2, 0)) {
+		init_data.flags.consolidated_dpia_dp_lt = true;
+		init_data.flags.enable_dpia_pre_training = true;
+		init_data.flags.unify_link_enc_assignment = true;
+		init_data.flags.usb4_bw_alloc_support = true;
+	}
 	retrieve_dmi_info(&adev->dm);
 	if (adev->dm.edp0_on_dp1_quirk)
 		init_data.flags.support_edp0_on_dp1 = true;
@@ -2366,6 +2383,7 @@ static int load_dmcu_fw(struct amdgpu_device *adev)
 		case IP_VERSION(3, 5, 1):
 		case IP_VERSION(3, 6, 0):
 		case IP_VERSION(4, 0, 1):
+		case IP_VERSION(4, 2, 0):
 			return 0;
 		default:
 			break;
@@ -2499,7 +2517,9 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 	case IP_VERSION(4, 0, 1):
 		dmub_asic = DMUB_ASIC_DCN401;
 		break;
-
+	case IP_VERSION(4, 2, 0):
+		dmub_asic = DMUB_ASIC_DCN42;
+		break;
 	default:
 		/* ASIC doesn't support DMUB. */
 		return 0;
@@ -5533,6 +5553,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 	case IP_VERSION(3, 5, 1):
 	case IP_VERSION(3, 6, 0):
 	case IP_VERSION(4, 0, 1):
+	case IP_VERSION(4, 2, 0):
 		if (register_outbox_irq_handlers(dm->adev)) {
 			drm_err(adev_to_drm(adev), "DM: Failed to initialize IRQ\n");
 			goto fail;
@@ -5557,6 +5578,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		case IP_VERSION(3, 5, 1):
 		case IP_VERSION(3, 6, 0):
 		case IP_VERSION(4, 0, 1):
+		case IP_VERSION(4, 2, 0):
 			psr_feature_enabled = true;
 			break;
 		default:
@@ -5739,6 +5761,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		case IP_VERSION(3, 5, 1):
 		case IP_VERSION(3, 6, 0):
 		case IP_VERSION(4, 0, 1):
+		case IP_VERSION(4, 2, 0):
 			if (dcn10_register_irq_handlers(dm->adev)) {
 				drm_err(adev_to_drm(adev), "DM: Failed to initialize IRQ\n");
 				goto fail;
@@ -5887,6 +5910,9 @@ static int dm_init_microcode(struct amdgpu_device *adev)
 	case IP_VERSION(4, 0, 1):
 		fw_name_dmub = FIRMWARE_DCN_401_DMUB;
 		break;
+	case IP_VERSION(4, 2, 0):
+		fw_name_dmub = FIRMWARE_DCN_42_DMUB;
+		break;
 	default:
 		/* ASIC doesn't support DMUB. */
 		return 0;
@@ -6014,6 +6040,7 @@ static int dm_early_init(struct amdgpu_ip_block *ip_block)
 		case IP_VERSION(3, 5, 1):
 		case IP_VERSION(3, 6, 0):
 		case IP_VERSION(4, 0, 1):
+		case IP_VERSION(4, 2, 0):
 			adev->mode_info.num_crtc = 4;
 			adev->mode_info.num_hpd = 4;
 			adev->mode_info.num_dig = 4;
@@ -12304,10 +12331,11 @@ static int dm_crtc_get_cursor_mode(struct amdgpu_device *adev,
 	int i;
 
 	/* Overlay cursor not supported on HW before DCN
-	 * DCN401 does not have the cursor-on-scaled-plane or cursor-on-yuv-plane restrictions
-	 * as previous DCN generations, so enable native mode on DCN401
+	 * DCN401/420 does not have the cursor-on-scaled-plane or cursor-on-yuv-plane restrictions
+	 * as previous DCN generations, so enable native mode on DCN401/420
 	 */
-	if (amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 0, 1)) {
+	if (amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 0, 1) ||
+	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 2, 0)) {
 		*cursor_mode = DM_CURSOR_NATIVE_MODE;
 		return 0;
 	}
@@ -12727,7 +12755,8 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 
 		/* Check if rotation or scaling is enabled on DCN401 */
 		if ((drm_plane_mask(crtc->cursor) & new_crtc_state->plane_mask) &&
-		    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 0, 1)) {
+		    (amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 2, 0) ||
+		    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 0, 1))) {
 			new_cursor_state = drm_atomic_get_new_plane_state(state, crtc->cursor);
 
 			is_rotated = new_cursor_state &&
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 4f4b868bd8dd..073710bff012 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: MIT
 /*
- * Copyright 2022 Advanced Micro Devices, Inc.
+ * Copyright 2022-2026 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
@@ -758,6 +758,7 @@ static int amdgpu_dm_plane_get_plane_modifiers(struct amdgpu_device *adev, unsig
 	case AMDGPU_FAMILY_GC_11_0_0:
 	case AMDGPU_FAMILY_GC_11_0_1:
 	case AMDGPU_FAMILY_GC_11_5_0:
+	case AMDGPU_FAMILY_GC_11_5_4:
 		amdgpu_dm_plane_add_gfx11_modifiers(adev, mods, &size, &capacity);
 		break;
 	case AMDGPU_FAMILY_GC_12_0_0:
-- 
2.34.1

