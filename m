Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2156BCD4F21
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 14:33:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9DC610EED5;
	Wed, 13 May 2026 14:33:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CF0al26b";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011001.outbound.protection.outlook.com [52.101.57.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F55F10EED1
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 14:33:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WLPm1ZFcNrtjoeikmoHon0O+rQ/a+CIEeTY6LCWgFOfH8lakgbOqv2bPjxTA2Llk3+K/d5KTmFXh/7uq6UydV8V+TndH6WuxYEABax0/Z9Fz6fXyyI0WrARHvzf9fc7DJbstzuQi5vikctog+Ufn/QSvK1LoiE0DkM/bh/bdkrXx4xl8OZDrvUwZXND6DhG3NSAw2iB6TjloJCSGYZRqHvyD61MnSOVWUuB1k7zVnLshQxahA6zLn1mVnvTMqkl+2bFPwijX6C/EHnUkS1xYcrUFFbZCP996Czgl5osIKRQeMJCWVgSA94R9uS4y5FZwD6GA2k34ubUuFK4L4lg98A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MW3bv14jjc6gF6DIaPylxzykY0i0394RnUd1LKmrYcY=;
 b=AVk7hcfelBgJ614n9F22tRhZx5qOKK3XrqJdy673oRRkUP8aXrroNYXLG6E+vACVrSYP8MqYtI/eMVFWwf1Si+jdvrjmPZ5yerTBs70/gm332F9v/AgGZQfNJz6uNeUHvWflc6oN4OuNYBr++4nByEN7+rM4JVTAq0EIpNoNoc+nr3Zn81BLey5Y871o40a0I9zutvcXnhsyJE4tbK+20oS0NT91tRAuKXXauVgdlhvByx/105QhaFgLdXxCnCGXidiVUVe3o9eV+rPSnCHpoEPf+7pdfMmJctXM2F3lvMA/rFEpxkdfKNceyD1haeZBTYCE8CH7jCjf3Hvf5yPS3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MW3bv14jjc6gF6DIaPylxzykY0i0394RnUd1LKmrYcY=;
 b=CF0al26bISMa6ATNerUyw/RzRBCxINfJ9XYt/LJsBXsnIISVL53WPv7DBdD55ATeOffHoVsozAQ1cYsWOUH/NTXgVmgSVH35U6rTsHTrcb+Y8mlK6suJ6CKMsdmE+tcBUd75zt0lQ1FoiHnFL9Ioz0yOULlS3xkLCm1Wnhh/oCc=
Received: from CH2PR18CA0042.namprd18.prod.outlook.com (2603:10b6:610:55::22)
 by CY3PR12MB9578.namprd12.prod.outlook.com (2603:10b6:930:109::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 14:33:17 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::95) by CH2PR18CA0042.outlook.office365.com
 (2603:10b6:610:55::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Wed,
 13 May 2026 14:33:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 14:33:16 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Wed, 13 May
 2026 09:33:16 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 May
 2026 09:33:16 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 13 May 2026 09:33:10 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, James Lin <pinglei.lin@amd.com>
Subject: [PATCH 02/28] Revert "drm/amd/display: dmub_cmd.h: add missing
 kernel-doc for enums"
Date: Wed, 13 May 2026 10:29:24 -0400
Message-ID: <20260513143213.1852892-4-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
References: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|CY3PR12MB9578:EE_
X-MS-Office365-Filtering-Correlation-Id: 19ed1ce8-c165-4525-7a9e-08deb0fc9257
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|11063799003|22082099003|18002099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info: SP0CZyuWxTO8gKQPMG1RHIYPuvkzmiPLDIWySayrSycVYltjKLnievo77Y6pRVBYe6I1HT4SLTrydhZF0wjpuKevy9z+DBiULCeAdqpgPMHWv85LIHa3Hf3IBVXVsD7lJqM5bB0yDI8koS51QLORU7pBPyA5DQheKsaneSfl2zuXlWasYWGxUidmAvFreokuPtzQTnQ0Pw5oe503+K0U5skFhbCIC9QMjy0dd5eyzu4asKn9ZTkByX/+rCZDJegMFhXr/GTN04dSgLsRSRlQWOOrQ2lXMHXQn8tzrvXXHfbEr1+PnnJF9IaAS3t5ZkQE1+EoVfy79IyeGpmP7ygKpmZT1l3cHCuRYxgjLJYzjMvj2fKoWUqw+uot4UG7Pi+JjtJ6V+rDOPXKGrDMbx/yfidMsFGMNJN9+VeNT4VzSq7CDZ7iWl5Juml7lWedZy6HRdX9bbZmxcWWryUDzQFMzEr4hbpsxNv54KiEVf5VynEgjJ7GBY7EENI1vlSvzDQyXVDtN4+sOd+QLz54g6ws82UNx1cu8KEMKyfGfth3lbohPqP/7h1BtZPMbGviPZLqngg87oWHJEpreqc6BLQUAESdDTV/PeLdpDAGTiU4oxYKcXPoN+0SfByqSeeB2HS2b6q+ut1Q4AvV3By6ODTEJQgrAZ+g1frLd5us2t1Lp/AHDFJGF0VQQthhyJ+DCxWi4J6PwGdnYTJXbKMT6Sc95q1Q0yBDzb+3+PZa1+lpNA8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(11063799003)(22082099003)(18002099003)(56012099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rdEym/KyRGl0YIWQYr2pzMBnbiJgvsxyCGsmPg+C8b2RwwB2YJEYRZe5feZH2YpCnMjl1g6OXi84MItBA0A5ESOzLZi6+VfP4YqdAHkv40b5YN1QxbaBel/5kBoD9MPYpwNZ3p8lbi2tegwsClRq7dtLhGoIRg60K3rtd0YHhEQ52qcegJdCU1N/ymPjWdnFYE2g7PnNSv1yOb7uClzjVls5QNOGownUYM3T67Vg1sBLbCxDhqZqUmY9xoJ5nXvXE/Wa0vVBkFVs0WdYduzdQnnENjhTrM/uCrMVPL3jIAMkgvY6gWxZ6aoirvAXIw00RfAOg456K8o1eHfOoKBfWNtf641b7UKjcZcg59QbZi9YRclK5Dfq5UtgO9XRNn2S40wRIWPWUguTRwP+ZwbvLYaOuN14xPr0T4T+Vt40euSD5gMZ3T8CcFMGrUkDADZw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 14:33:16.6390 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ed1ce8-c165-4525-7a9e-08deb0fc9257
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9578
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

From: James Lin <PingLei.Lin@amd.com>

[Why & How]
This reverts commit 7d9d8fc1db837bdf39a8947b2928ec562dab83f1.

1. Auto-generated Header: The file 'dmub_cmd.h' is an auto-generated header
   managed in an external repository (dmu_stg). Manual changes made directly in
   this repository will be overwritten and lost during the next automated weekly
   synchronization.

2. Tooling Compatibility: This header is governed by internal AMD firmware
   standards which require Doxygen formatting for cross-team documentation.
   Moving to kernel-doc syntax may break internal documentation pipelines.

3. Suppressing Warnings: Current 'make htmldocs' and 'make W=1' builds
   do not actively scan 'dmub_cmd.h' for kernel-doc compliance, thus no warnings
   are triggered during standard compilation. To address warnings generated when
   manually running './scripts/kernel-doc', we have added a notice at the file
   header indicating that this is an auto-generated file that does not strictly
   follow kernel-doc formatting. This ensures that any future linting tools or
   manual checks recognize the formatting as intentional.

Acked-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 156 ++++++------------
 1 file changed, 48 insertions(+), 108 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index c1becd664cb9..2f68438000ea 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -1008,30 +1008,15 @@ union dmub_fw_boot_status {
  * enum dmub_fw_boot_status_bit - Enum bit definitions for SCRATCH0.
  */
 enum dmub_fw_boot_status_bit {
-	/** @DMUB_FW_BOOT_STATUS_BIT_DAL_FIRMWARE: 1 if DAL FW */
-	DMUB_FW_BOOT_STATUS_BIT_DAL_FIRMWARE = (1 << 0),
-	/** @DMUB_FW_BOOT_STATUS_BIT_MAILBOX_READY: 1 if mailbox ready */
-	DMUB_FW_BOOT_STATUS_BIT_MAILBOX_READY = (1 << 1),
-	/** @DMUB_FW_BOOT_STATUS_BIT_OPTIMIZED_INIT_DONE: 1 if init done */
-	DMUB_FW_BOOT_STATUS_BIT_OPTIMIZED_INIT_DONE = (1 << 2),
-	/** @DMUB_FW_BOOT_STATUS_BIT_RESTORE_REQUIRED: 1 if driver should call restore */
-	DMUB_FW_BOOT_STATUS_BIT_RESTORE_REQUIRED = (1 << 3),
-	/**
-	 * @DMUB_FW_BOOT_STATUS_BIT_DEFERRED_LOADED: 1 if VBIOS data is
-	 * deferred programmed
-	 */
-	DMUB_FW_BOOT_STATUS_BIT_DEFERRED_LOADED = (1 << 4),
-	/** @DMUB_FW_BOOT_STATUS_BIT_FAMS_ENABLED: 1 if FAMS is enabled */
-	DMUB_FW_BOOT_STATUS_BIT_FAMS_ENABLED = (1 << 5),
-	/**
-	 * @DMUB_FW_BOOT_STATUS_BIT_DETECTION_REQUIRED: 1 if detection needs
-	 * to be triggered by driver
-	 */
-	DMUB_FW_BOOT_STATUS_BIT_DETECTION_REQUIRED = (1 << 6),
-	/** @DMUB_FW_BOOT_STATUS_BIT_HW_POWER_INIT_DONE: 1 if hw power init is completed */
-	DMUB_FW_BOOT_STATUS_BIT_HW_POWER_INIT_DONE = (1 << 7),
-	/** @DMUB_FW_BOOT_STATUS_BIT_ONO_REGIONS_ENABLED: if ONO regions are enabled */
-	DMUB_FW_BOOT_STATUS_BIT_ONO_REGIONS_ENABLED = (1 << 8),
+	DMUB_FW_BOOT_STATUS_BIT_DAL_FIRMWARE = (1 << 0), /**< 1 if DAL FW */
+	DMUB_FW_BOOT_STATUS_BIT_MAILBOX_READY = (1 << 1), /**< 1 if mailbox ready */
+	DMUB_FW_BOOT_STATUS_BIT_OPTIMIZED_INIT_DONE = (1 << 2), /**< 1 if init done */
+	DMUB_FW_BOOT_STATUS_BIT_RESTORE_REQUIRED = (1 << 3), /**< 1 if driver should call restore */
+	DMUB_FW_BOOT_STATUS_BIT_DEFERRED_LOADED = (1 << 4), /**< 1 if VBIOS data is deferred programmed */
+	DMUB_FW_BOOT_STATUS_BIT_FAMS_ENABLED = (1 << 5), /**< 1 if FAMS is enabled*/
+	DMUB_FW_BOOT_STATUS_BIT_DETECTION_REQUIRED = (1 << 6), /**< 1 if detection need to be triggered by driver*/
+	DMUB_FW_BOOT_STATUS_BIT_HW_POWER_INIT_DONE = (1 << 7), /**< 1 if hw power init is completed */
+	DMUB_FW_BOOT_STATUS_BIT_ONO_REGIONS_ENABLED = (1 << 8), /**< 1 if ONO regions are enabled */
 };
 
 /* Register bit definition for SCRATCH5 */
@@ -1095,22 +1080,18 @@ enum dmub_ips_comand_type {
  */
 enum dmub_cursor_offload_comand_type {
 	/**
-	 * @DMUB_CMD__CURSOR_OFFLOAD_INIT:
 	 * Initializes the cursor offload feature.
 	 */
 	DMUB_CMD__CURSOR_OFFLOAD_INIT = 0,
 	/**
-	 * @DMUB_CMD__CURSOR_OFFLOAD_STREAM_ENABLE: Enables cursor offloading
-	 * for a stream and updates the timing parameters.
+	 * Enables cursor offloading for a stream and updates the timing parameters.
 	 */
 	DMUB_CMD__CURSOR_OFFLOAD_STREAM_ENABLE = 1,
 	/**
-	 * @DMUB_CMD__CURSOR_OFFLOAD_STREAM_DISABLE:
 	 * Disables cursor offloading for a given stream.
 	 */
 	DMUB_CMD__CURSOR_OFFLOAD_STREAM_DISABLE = 2,
 	/**
-	 * @DMUB_CMD__CURSOR_OFFLOAD_STREAM_PROGRAM:
 	 * Programs the latest data for a given stream.
 	 */
 	DMUB_CMD__CURSOR_OFFLOAD_STREAM_PROGRAM = 3,
@@ -1176,7 +1157,7 @@ enum dmub_fw_boot_options_bit {
  * [Header (256 Bytes)][Feature 1 (256 Bytes)][Feature 2 (256 Bytes)]...
  */
 
-/*
+/**
  * enum dmub_shared_state_feature_id - List of shared state features.
  */
 enum dmub_shared_state_feature_id {
@@ -1933,36 +1914,30 @@ enum dmub_cmd_type {
  */
 enum dmub_out_cmd_type {
 	/**
-	 * @DMUB_OUT_CMD__NULL: Invalid outbox command, ignored.
+	 * Invalid outbox command, ignored.
 	 */
 	DMUB_OUT_CMD__NULL = 0,
 	/**
-	 * @DMUB_OUT_CMD__DP_AUX_REPLY:
 	 * Command type used for DP AUX Reply data notification
 	 */
 	DMUB_OUT_CMD__DP_AUX_REPLY = 1,
 	/**
-	 * @DMUB_OUT_CMD__DP_HPD_NOTIFY:
 	 * Command type used for DP HPD event notification
 	 */
 	DMUB_OUT_CMD__DP_HPD_NOTIFY = 2,
 	/**
-	 * @DMUB_OUT_CMD__SET_CONFIG_REPLY:
 	 * Command type used for SET_CONFIG Reply notification
 	 */
 	DMUB_OUT_CMD__SET_CONFIG_REPLY = 3,
 	/**
-	 * @DMUB_OUT_CMD__DPIA_NOTIFICATION:
 	 * Command type used for USB4 DPIA notification
 	 */
 	DMUB_OUT_CMD__DPIA_NOTIFICATION = 5,
 	/**
-	 * @DMUB_OUT_CMD__HPD_SENSE_NOTIFY:
 	 * Command type used for HPD redetect notification
 	 */
 	DMUB_OUT_CMD__HPD_SENSE_NOTIFY = 6,
 	/**
-	 * @DMUB_OUT_CMD__FUSED_IO:
 	 * Command type used for Fused IO notification
 	 */
 	DMUB_OUT_CMD__FUSED_IO = 7,
@@ -2154,19 +2129,19 @@ struct dmub_rb_cmd_PLAT_54186_wa {
  */
 enum dmub_cmd_mall_type {
 	/**
-	 * @DMUB_CMD__MALL_ACTION_ALLOW: Allows display refresh from MALL.
+	 * Allows display refresh from MALL.
 	 */
 	DMUB_CMD__MALL_ACTION_ALLOW = 0,
 	/**
-	 * @DMUB_CMD__MALL_ACTION_DISALLOW: Disallows display refresh from MALL.
+	 * Disallows display refresh from MALL.
 	 */
 	DMUB_CMD__MALL_ACTION_DISALLOW = 1,
 	/**
-	 * @DMUB_CMD__MALL_ACTION_COPY_CURSOR: Cursor copy for MALL.
+	 * Cursor copy for MALL.
 	 */
 	DMUB_CMD__MALL_ACTION_COPY_CURSOR = 2,
 	/**
-	 * @DMUB_CMD__MALL_ACTION_NO_DF_REQ: Controls DF requests.
+	 * Controls DF requests.
 	 */
 	DMUB_CMD__MALL_ACTION_NO_DF_REQ = 3,
 };
@@ -2195,21 +2170,18 @@ struct dmub_rb_cmd_mall {
  */
 enum dmub_cmd_cab_type {
 	/**
-	 * @DMUB_CMD__CAB_NO_IDLE_OPTIMIZATION:
 	 * No idle optimizations (i.e. no CAB)
 	 */
 	DMUB_CMD__CAB_NO_IDLE_OPTIMIZATION = 0,
 	/**
-	 * @DMUB_CMD__CAB_NO_DCN_REQ: No DCN requests for memory
+	 * No DCN requests for memory
 	 */
 	DMUB_CMD__CAB_NO_DCN_REQ = 1,
 	/**
-	 * @DMUB_CMD__CAB_DCN_SS_FIT_IN_CAB:
 	 * Fit surfaces in CAB (i.e. CAB enable)
 	 */
 	DMUB_CMD__CAB_DCN_SS_FIT_IN_CAB = 2,
 	/**
-	 * @DMUB_CMD__CAB_DCN_SS_NOT_FIT_IN_CAB:
 	 * Do not fit surfaces in CAB (i.e. no CAB)
 	 */
 	DMUB_CMD__CAB_DCN_SS_NOT_FIT_IN_CAB = 3,
@@ -2224,7 +2196,7 @@ struct dmub_rb_cmd_cab_for_ss {
 	uint8_t debug_bits;     /* debug bits */
 };
 
-/*
+/**
  * Enum for indicating which MCLK switch mode per pipe
  */
 enum mclk_switch_mode {
@@ -2702,18 +2674,11 @@ struct dmub_fams2_stream_static_state_v1 {
  * p-state request to allow latency
  */
 enum dmub_fams2_allow_delay_check_mode {
-	/**
-	 * @FAMS2_ALLOW_DELAY_CHECK_NONE: No check for request to allow delay
-	 */
+	/* No check for request to allow delay */
 	FAMS2_ALLOW_DELAY_CHECK_NONE = 0,
-	/**
-	 * @FAMS2_ALLOW_DELAY_CHECK_FROM_START: Check for request to allow delay
-	 */
+	/* Check for request to allow delay */
 	FAMS2_ALLOW_DELAY_CHECK_FROM_START = 1,
-	/**
-	 * @FAMS2_ALLOW_DELAY_CHECK_FROM_PREPARE:
-	 * Check for prepare to allow delay
-	 */
+	/* Check for prepare to allow delay */
 	FAMS2_ALLOW_DELAY_CHECK_FROM_PREPARE = 2,
 };
 
@@ -2785,28 +2750,27 @@ struct dmub_rb_cmd_ib {
  */
 enum dmub_cmd_idle_opt_type {
 	/**
-	 * @DMUB_CMD__IDLE_OPT_DCN_RESTORE: DCN hardware restore.
+	 * DCN hardware restore.
 	 */
 	DMUB_CMD__IDLE_OPT_DCN_RESTORE = 0,
 
 	/**
-	 * @DMUB_CMD__IDLE_OPT_DCN_SAVE_INIT: DCN hardware save.
+	 * DCN hardware save.
 	 */
 	DMUB_CMD__IDLE_OPT_DCN_SAVE_INIT = 1,
 
 	/**
-	 * @DMUB_CMD__IDLE_OPT_DCN_NOTIFY_IDLE: DCN hardware notify idle.
+	 * DCN hardware notify idle.
 	 */
 	DMUB_CMD__IDLE_OPT_DCN_NOTIFY_IDLE = 2,
 
 	/**
-	 * @DMUB_CMD__IDLE_OPT_SET_DC_POWER_STATE:
 	 * DCN hardware notify power state.
 	 */
 	DMUB_CMD__IDLE_OPT_SET_DC_POWER_STATE = 3,
 
 	/**
-	 * @DMUB_CMD__IDLE_OPT_RELEASE_HW: DCN notify to release HW.
+	 * DCN notify to release HW.
 	 */
 	 DMUB_CMD__IDLE_OPT_RELEASE_HW = 4,
 };
@@ -2835,7 +2799,7 @@ struct dmub_rb_cmd_idle_opt_dcn_notify_idle {
 	struct dmub_dcn_notify_idle_cntl_data cntl_data;
 };
 
-/*
+/**
  * enum dmub_idle_opt_dc_power_state - DC power states.
  */
 enum dmub_idle_opt_dc_power_state {
@@ -2877,7 +2841,7 @@ struct dmub_clocks {
  */
 enum dmub_cmd_clk_mgr_type {
 	/**
-	 * @DMUB_CMD__CLK_MGR_NOTIFY_CLOCKS: Notify DMCUB of clock update.
+	 * Notify DMCUB of clock update.
 	 */
 	DMUB_CMD__CLK_MGR_NOTIFY_CLOCKS = 0,
 };
@@ -3122,40 +3086,21 @@ struct dmub_rb_cmd_dpphy_init {
  * 4 AUX request command bits are shifted to high nibble.
  */
 enum dp_aux_request_action {
-	/**
-	 * @DP_AUX_REQ_ACTION_I2C_WRITE: I2C-over-AUX write request
-	 */
+	/** I2C-over-AUX write request */
 	DP_AUX_REQ_ACTION_I2C_WRITE		= 0x00,
-	/**
-	 * @DP_AUX_REQ_ACTION_I2C_READ: I2C-over-AUX read request
-	 */
+	/** I2C-over-AUX read request */
 	DP_AUX_REQ_ACTION_I2C_READ		= 0x10,
-	/**
-	 * @DP_AUX_REQ_ACTION_I2C_STATUS_REQ: I2C-over-AUX write status request
-	 */
+	/** I2C-over-AUX write status request */
 	DP_AUX_REQ_ACTION_I2C_STATUS_REQ	= 0x20,
-	/**
-	 * @DP_AUX_REQ_ACTION_I2C_WRITE_MOT:
-	 * I2C-over-AUX write request with MOT=1
-	 */
+	/** I2C-over-AUX write request with MOT=1 */
 	DP_AUX_REQ_ACTION_I2C_WRITE_MOT		= 0x40,
-	/**
-	 * @DP_AUX_REQ_ACTION_I2C_READ_MOT:
-	 * I2C-over-AUX read request with MOT=1
-	 */
+	/** I2C-over-AUX read request with MOT=1 */
 	DP_AUX_REQ_ACTION_I2C_READ_MOT		= 0x50,
-	/**
-	 * @DP_AUX_REQ_ACTION_I2C_STATUS_REQ_MOT:
-	 * I2C-over-AUX write status request with MOT=1
-	 */
+	/** I2C-over-AUX write status request with MOT=1 */
 	DP_AUX_REQ_ACTION_I2C_STATUS_REQ_MOT	= 0x60,
-	/**
-	 * @DP_AUX_REQ_ACTION_DPCD_WRITE: Native AUX write request
-	 */
+	/** Native AUX write request */
 	DP_AUX_REQ_ACTION_DPCD_WRITE		= 0x80,
-	/**
-	 * @DP_AUX_REQ_ACTION_DPCD_READ: Native AUX read request
-	 */
+	/** Native AUX read request */
 	DP_AUX_REQ_ACTION_DPCD_READ		= 0x90
 };
 
@@ -3163,21 +3108,21 @@ enum dp_aux_request_action {
  * enum aux_return_code_type - DP AUX process return code listing.
  */
 enum aux_return_code_type {
-	/** @AUX_RET_SUCCESS: AUX process succeeded */
+	/** AUX process succeeded */
 	AUX_RET_SUCCESS = 0,
-	/** @AUX_RET_ERROR_UNKNOWN: AUX process failed with unknown reason */
+	/** AUX process failed with unknown reason */
 	AUX_RET_ERROR_UNKNOWN,
-	/** @AUX_RET_ERROR_INVALID_REPLY: AUX process completed with invalid reply */
+	/** AUX process completed with invalid reply */
 	AUX_RET_ERROR_INVALID_REPLY,
-	/** @AUX_RET_ERROR_TIMEOUT: AUX process timed out */
+	/** AUX process timed out */
 	AUX_RET_ERROR_TIMEOUT,
-	/** @AUX_RET_ERROR_HPD_DISCON: HPD was low during AUX process */
+	/** HPD was low during AUX process */
 	AUX_RET_ERROR_HPD_DISCON,
-	/** @AUX_RET_ERROR_ENGINE_ACQUIRE: Failed to acquire AUX engine */
+	/** Failed to acquire AUX engine */
 	AUX_RET_ERROR_ENGINE_ACQUIRE,
-	/** @AUX_RET_ERROR_INVALID_OPERATION: AUX request not supported */
+	/** AUX request not supported */
 	AUX_RET_ERROR_INVALID_OPERATION,
-	/** @AUX_RET_ERROR_PROTOCOL_ERROR: AUX process not available */
+	/** AUX process not available */
 	AUX_RET_ERROR_PROTOCOL_ERROR,
 };
 
@@ -3185,9 +3130,9 @@ enum aux_return_code_type {
  * enum aux_channel_type - DP AUX channel type listing.
  */
 enum aux_channel_type {
-	/** @AUX_CHANNEL_LEGACY_DDC: AUX thru Legacy DP AUX */
+	/** AUX thru Legacy DP AUX */
 	AUX_CHANNEL_LEGACY_DDC,
-	/** @AUX_CHANNEL_DPIA: AUX thru DPIA DP tunneling */
+	/** AUX thru DPIA DP tunneling */
 	AUX_CHANNEL_DPIA
 };
 
@@ -3672,7 +3617,7 @@ enum phy_link_rate {
 	 */
 };
 
-/*
+/**
  * enum dmub_phy_fsm_state - PHY FSM states.
  * PHY FSM state to transit to during PSR enable/disable.
  */
@@ -5949,11 +5894,10 @@ struct dmub_rb_cmd_abm_query_caps {
  */
 enum dmub_abm_ace_curve_type {
 	/**
-	 * @ABM_ACE_CURVE_TYPE__SW: ACE curve as defined by the SW layer.
+	 * ACE curve as defined by the SW layer.
 	 */
 	ABM_ACE_CURVE_TYPE__SW = 0,
 	/**
-	 * @ABM_ACE_CURVE_TYPE__SW_IF:
 	 * ACE curve as defined by the SW to HW translation interface layer.
 	 */
 	ABM_ACE_CURVE_TYPE__SW_IF = 1,
@@ -5964,11 +5908,10 @@ enum dmub_abm_ace_curve_type {
  */
 enum dmub_abm_histogram_type {
 	/**
-	 * @ABM_HISTOGRAM_TYPE__SW: ACE curve as defined by the SW layer.
+	 * ACE curve as defined by the SW layer.
 	 */
 	ABM_HISTOGRAM_TYPE__SW = 0,
 	/**
-	 * @ABM_HISTOGRAM_TYPE__SW_IF:
 	 * ACE curve as defined by the SW to HW translation interface layer.
 	 */
 	ABM_HISTOGRAM_TYPE__SW_IF = 1,
@@ -6174,17 +6117,14 @@ struct dmub_rb_cmd_get_visual_confirm_color {
  */
 enum dmub_cmd_panel_cntl_type {
 	/**
-	 * @DMUB_CMD__PANEL_CNTL_HW_INIT:
 	 * Initializes embedded panel hardware blocks.
 	 */
 	DMUB_CMD__PANEL_CNTL_HW_INIT = 0,
 	/**
-	 * @DMUB_CMD__PANEL_CNTL_QUERY_BACKLIGHT_INFO:
 	 * Queries backlight info for the embedded panel.
 	 */
 	DMUB_CMD__PANEL_CNTL_QUERY_BACKLIGHT_INFO = 1,
 	/**
-	 * @DMUB_CMD__PANEL_DEBUG_PWM_FREQ:
 	 * Sets the PWM Freq as per user's requirement.
 	 */
 	DMUB_CMD__PANEL_DEBUG_PWM_FREQ = 2,
-- 
2.43.0

