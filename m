Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 362DEC3601E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 11:35:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D306710E96E;
	Thu, 10 Apr 2025 11:35:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z6J6SIEe";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F245B10E96E
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 11:35:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SUTZADlXhvXLV6aUy8nN5o+qZDXrVAAhTR0uYVXGUcMeRj8QZHKAGlj4QM9RIfl3NUjnAEfPDWSHUFC79StxdCDIjfqqjtQIctsUzYn93/71NWi0B/+M8rNKwIS/6lcVVHw9etceFviBs222ccwcPyO7sUFb20Gymaz63yy+7UVCk+LiR/tvbPQ1zIqZFdT8qxrd0VaJlohDJiwfz+LTig/oTv5M0ZuLU3AyI2LWISv+/MwE0Krp89LHoY+Uc8Dh2T8NRoU2Srm37meK6ouLKfO/9iHPQixBTJKhAYl5enwD1FiNcMfD9rXVNjMdjApMcLfef37zXbO7cmBOj2MLtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDJTEFDw9jBLU5yEvJGd//3+KvrRTEVV47YfBa53oBE=;
 b=anzVhglgTpXHsMH+r5eptgme5wnLYvYTOFUdqvJBwCdDwKSkn//bW5/Ff0jq8v4zwqI8Uyjsufawmd8PJBC5fyohTuE6MdJcY2zQbnZ8EFIF8ySN5uEfRDOFTWHgJez/3SXWjRSnMBrWtBxNVA27Uw5kofUrNIsfLN0yWgcfleQRXTlISnPyWw2qrrON0+WEQcmVZH50k+XP59o88hlieb5GGFmL1BgZus2ZW3BZYZ7+mO5sddZ/LJJID7Iika3I1CcLk4j5wfyJHcK7Z3I92ZbE259V9m/y81ucN/P2K48B180kxvFaXdrN9lTAAPyUifrTIOczEGgEUr9u2dVUCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDJTEFDw9jBLU5yEvJGd//3+KvrRTEVV47YfBa53oBE=;
 b=Z6J6SIEe7Q2Z7COdnURC7Jb3QFQQppgD+2BbB1XFPThWp7Nbeaudr0nb6PLoMle1L8Rfe6o0MqHKD1y3044rCTMvR7egyWrQpGHfsVYgXUWU1CkZm71mwAk7TGhRcTecXa5UFxl+qGCpY4npWdQ6JVG1MKNQjrlyLzcQy0H3ls4=
Received: from MW4PR04CA0386.namprd04.prod.outlook.com (2603:10b6:303:81::31)
 by PH7PR12MB7162.namprd12.prod.outlook.com (2603:10b6:510:201::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Thu, 10 Apr
 2025 11:35:11 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:303:81:cafe::e3) by MW4PR04CA0386.outlook.office365.com
 (2603:10b6:303:81::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.36 via Frontend Transport; Thu,
 10 Apr 2025 11:35:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 11:35:11 +0000
Received: from rtg-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 10 Apr 2025 06:35:07 -0500
From: Arvind Yadav <Arvind.Yadav@amd.com>
To: <Christian.Koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>, <shashank.sharma@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Arvind Yadav <Arvind.Yadav@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Add fw minimum version check for usermode
 queue
Date: Thu, 10 Apr 2025 17:04:52 +0530
Message-ID: <20250410113452.15753-1-Arvind.Yadav@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|PH7PR12MB7162:EE_
X-MS-Office365-Filtering-Correlation-Id: 677625f9-3933-4c85-e3fe-08dd7823c101
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MyQAvRQSGTBdfQBmOVsrujoXbMExWiVnU8BPnXYWAFq5w+ojx0dMTd0HC93q?=
 =?us-ascii?Q?q9B3KHB/twS+6FmBOYkp7D+UOKWZLO1huM3dKQlxsljgKeZM+oK8KJQ8m44k?=
 =?us-ascii?Q?EBdoQQiOtwUJrYV2kkoIWWfI0kLQvZ9PdWfIVMBcf190s6iR/lJ1kDnz/bhh?=
 =?us-ascii?Q?H+Cg1tbfMGXs0R3Md58sIce7q7FHgpfS9mXlUktesToLxJn06NbG1VjN5QBK?=
 =?us-ascii?Q?75PaDbQZEfTiktHX/2wiWhNYJZYpuwjoICtlrDoJphrLr935cebcO4TGHAkc?=
 =?us-ascii?Q?Axz/7nU8zj2bPnHEPQVyI9hr8ChK/6CwaFRmVL7ZHSz+85aPTlG0H6sKfu4Z?=
 =?us-ascii?Q?TG/XH1Vnqx11i0duRsq8ERzOaVJ+OH0HiXuvCer2y6Uv/5OViZj8YvR0GZma?=
 =?us-ascii?Q?wkTQxOp0cshmQxEJm2r6ZzDwwjF17sAr75n1CQZcVgxutWw73Xd+/PG0CRoB?=
 =?us-ascii?Q?tStqgmF9S/MJqgo5oYDJDIS6QHogAJ2hKa6JDjkoYiGSfju5xbm2Nmu3o7nH?=
 =?us-ascii?Q?WPcApK6M+c7nD2rcVZT7BGGNTeq7e9FzaF1EX7/8EH7uSv29r4m/Ds5KcMW9?=
 =?us-ascii?Q?jiIjgvUuVayRDlLIdmRBQLaA8ZJqTnCm6oT5ppFglHeg/orRCrdWrLqVybe2?=
 =?us-ascii?Q?yl2mhdEdZYvh8aGgoDqVqdpOLgh2IRmcTAY5b9ZKFHUGvNu/MAFV6MGSuXCt?=
 =?us-ascii?Q?YqBjD/y2kVIDpFUnybcr/qARh66DsH9iHuG6UbAxdS8D1+oholY9Q/8b1Hc0?=
 =?us-ascii?Q?SgAQI9++2hZrcOjXsEpWKxvKHYwKKL4qzRegYdmp7lNypFZZMfivMTEZkAmd?=
 =?us-ascii?Q?Y2M7Af1LFP6/I3h1z2jvIWNfSNkDQ/isA6wz+ZCefGgMxxU9ZnzevTVS1r9r?=
 =?us-ascii?Q?Z0edbMOMwZjSMDbjZ4HpCPEMc+7TplLOTBeA6zkWLN6Ip1qmgR7B6F3S55os?=
 =?us-ascii?Q?cPROLqMXzQxNhYe+tYjtdLlONpHVz3IYdrlu0I6d88yld/3tyELIqbUdcp0k?=
 =?us-ascii?Q?inVmROk4Gkyni5Rpr0lSNqcmpD1jr/mQfO3NI5OjA4TQsPRISLgwZSkH4LT3?=
 =?us-ascii?Q?nuOEbwQMM1OVWD8d4jl9CTbQG91grCQR0uTRKqMIj1vP5yNcM9PeoSK8yQgt?=
 =?us-ascii?Q?YxWGgqRSntEAth/nSGg0uhulcsRdnU5fvoCo7K+4u3BxckLfzr/pSNGgD1qu?=
 =?us-ascii?Q?yKV/4maAQ5XZe1y31it63MNZqzUmrmkuNO3VUSvQVbG3hDxt7ImBZaLXxilb?=
 =?us-ascii?Q?ei0HAOr97tepXI3Q9rUd4aW/dRN3knUJOwNmRYdrE5D/CrlMMU65g8JlmO75?=
 =?us-ascii?Q?N5X3icJrik7s30uPZpGVLugzISeDU7VsfVcTUU8PJ0fFHaX6ul+8Mdlb/FNy?=
 =?us-ascii?Q?rLvcqf+InJsutoRGdiQ3WvkFut85puptaIqvlYFy25/YAI7KG0YKf5KoFTD/?=
 =?us-ascii?Q?FZ/r2w580/Eey5ajf3WWYSBOE1ZpFfn/YY5Mg2HRxhhm8bfcWFGBJBG3nN2I?=
 =?us-ascii?Q?VgTmhUax/AIE3OQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 11:35:11.1606 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 677625f9-3933-4c85-e3fe-08dd7823c101
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7162
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

This patch is load usermode queue based on FW support for gfx12.
CP Ucode FW Vesion: [PFP = 2840, ME = 2780, MEC = 2600, MES = 123]

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Shashank Sharma <shashank.sharma@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Arvind Yadav <Arvind.Yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 3d87e445270e..c31c96fc13f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -69,6 +69,10 @@
 #define regCP_HQD_PERSISTENT_STATE_DEFAULT                                        0x0be05501
 #define regCP_HQD_IB_CONTROL_DEFAULT                                              0x00300000
 
+#define GFX12_ME_FW_MIN_VERSION							0x00000adc
+#define GFX12_PFP_FW_MIN_VERSION						0x00000b18
+#define GFX12_MEC_FW_MIN_VERSION						0x00000bea
+#define GFX12_MES_FW_MIN_VERSION						0x0000007b
 
 MODULE_FIRMWARE("amdgpu/gc_12_0_0_pfp.bin");
 MODULE_FIRMWARE("amdgpu/gc_12_0_0_me.bin");
@@ -1383,6 +1387,15 @@ static void gfx_v12_0_alloc_ip_dump(struct amdgpu_device *adev)
 	}
 }
 
+static bool gfx_v12_0_is_userq_supported(struct amdgpu_device *adev)
+{
+	return (adev->gfx.me_fw_version >= GFX12_ME_FW_MIN_VERSION &&
+		adev->gfx.pfp_fw_version >= GFX12_PFP_FW_MIN_VERSION &&
+		adev->gfx.mec_fw_version >= GFX12_MEC_FW_MIN_VERSION &&
+		adev->mes.fw_version[0] >= GFX12_MES_FW_MIN_VERSION);
+}
+
+
 static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int i, j, k, r, ring_id = 0;
@@ -1418,7 +1431,7 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(12, 0, 1):
 #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 		/* add firmware version checks here */
-		if (0) {
+		if (gfx_v12_0_is_userq_supported(adev)) {
 			adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
 			adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
 		}
-- 
2.34.1

