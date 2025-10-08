Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C80DCCA472
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 13:33:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E025310E80B;
	Wed,  8 Oct 2025 13:33:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4Kf+ygiC";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012033.outbound.protection.outlook.com
 [40.107.200.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C93E410E813
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 13:33:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VF0UL7TQ5iaojEWcgGPBIkd0h2x+RsDvgiN/MphjqbbzLqcpxEZo0NJY/UocDSVSgoCVfaGcwKuUS78NYjZhxEI3ZPVIno8Y7r63yfFYe386BKxLibTkWw2eP+Im5hK7C5KrYUmJDThh3fH/9BHJK1iZl0JR/lbIw0K4DQGDm3ooGiy1J94/bLDtiK5lj9Tc1mywQyp8n57JgTQzFiYxYCPItwRTL/CosBX45dFiy0CGGF6lFMD2jb8/9tDcBjUYRQFpVPwkOKrqDWj4+L0X04VPBHzqbo0CWUFvwFl4l37kmq7JQ6LTivld1Y9LUFATkt0T8A9LvD7V6Qw+j/+OGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ptxj2WY3wAYJ5nZ0jUaF7vOR9tdpUVCAXRqTeDWSQh0=;
 b=xdXct3EiQ3TVNnSwrJ58Jy7H7/SC7giIlUwQYjkwJSugHuupcSGyDD0n1mthsdnPnBTKkoaZI9rGZT15UVOtKOGnrAhl8cIzVQVmTCt05hEFWVUX/BO7AmEUHId0G3dN/t91NOFNIlhvF1f7Gzx8ooxQzhFSQtuU+vwIxEQ1ldn/tfn75AkRRaCNjKGycl7MwToxvpteZku96nGYwq0FIWmFgnKvaxNMhX+T+SQLHkeU/SZkWK33b212C4TzxxoHUqpY9Bvxn/5it5P4+TafRRcsUaoth+T7foMJoVNTYsgQA6htVA3DdLKp6oEbGeFPku5T27eNHD1Dv1BqkZwB+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ptxj2WY3wAYJ5nZ0jUaF7vOR9tdpUVCAXRqTeDWSQh0=;
 b=4Kf+ygiCd3rEzM869ERuFa5drfPubjtsLwVTtjGbKREQfX8EyafKXc+/sVb7txABGaXuwnjMgDnrXCXxG6p0loJh7VWUp7J4KH7zWygOOIdLWuHBWFdeF3EC2f9hu28dm2FJY2mVtk48+6ljFf8ColeWj3AJBR5EWg4F6yxQVfI=
Received: from CH0PR03CA0419.namprd03.prod.outlook.com (2603:10b6:610:11b::8)
 by PH0PR12MB7814.namprd12.prod.outlook.com (2603:10b6:510:288::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 13:33:18 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::ec) by CH0PR03CA0419.outlook.office365.com
 (2603:10b6:610:11b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Wed,
 8 Oct 2025 13:33:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Wed, 8 Oct 2025 13:33:17 +0000
Received: from smc-sc-di15-34.dh144.dcgpu (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 8 Oct 2025 06:33:16 -0700
From: <will.aitken@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.skvortsov@amd.com>, <lijo.lazar@amd.com>, Will Aitken
 <wiaitken@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Update headers for sriov xgmi ext peer link
 support feature flag
Date: Wed, 8 Oct 2025 13:32:24 +0000
Message-ID: <20251008133225.1238028-2-will.aitken@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008133225.1238028-1-will.aitken@amd.com>
References: <20251008133225.1238028-1-will.aitken@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|PH0PR12MB7814:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ec5128f-0d00-42f4-88ee-08de066f3dae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kuui2LbKTdYtv45svJknNICt3PIAIBjJvHJFvJDg+NhKF8Y4yO4HQ+YQtlN9?=
 =?us-ascii?Q?9zXsg+qDdWtWiiKFa8Mx3eUtyIPCHglYcJJw84agqA6Gi0qAfmpde+JaK0rR?=
 =?us-ascii?Q?kF2IC7EMLLUH/M5dbzD+bQ3qjw+xr6qRuI+pJnxdBI3mk3PY+xvBiF8w7K1B?=
 =?us-ascii?Q?6HN+peIwVbRX0EbKUXHis6fM9brge73IZ+5MjVY2RjH025SmbbGT9/7VC2oE?=
 =?us-ascii?Q?h//xYzASHsQ+ADAUzuZWn9p/4kBZVEZf8fQcYU055tSWwbOP9ghWOsZa43VY?=
 =?us-ascii?Q?RLaKfbjZy++95iKXB71QTMB3CudJZL5H45HA8pYuBK7+OCdAHx+MWiR5rd29?=
 =?us-ascii?Q?ADkGSltx/D64EscMsClvVXIyuEi7X/WVIr7bPhbO4p2gHJVezHF24QOaeGPa?=
 =?us-ascii?Q?c/ACSBRcQAgPHR2ZRC5xx91xPnwB9fFYGKvYJ98NuNDmCptDEEkrbZoqF8hq?=
 =?us-ascii?Q?YoE56wg6b8e2HfvbAc6ZfOHKhshWv8bKwBhE12+QvWAoJLP6Vj0Ei2LQRPEO?=
 =?us-ascii?Q?yctjQzCHvl8x0p1nU7rHHUCfPyAYVuMQ/zE07BGOtMg/3xOtUKZSpH11eD9c?=
 =?us-ascii?Q?hfzMIvzbTvPUYSGXsjujgLrqCKVTKisQ+4dINuqH2h9AGPdnGiYrka0ES4Jn?=
 =?us-ascii?Q?xh4+su3K1Xl8lJ4Q7gybaP/eF9gsj1kd7ud4B+mNqQCyKQXfNC354FscqqN0?=
 =?us-ascii?Q?szhSg7ifLYNWi9CqTAg5LrSphVrlhek0efq1lyDHo+cryQ9/2VWEtxaDRGAd?=
 =?us-ascii?Q?Og2YVrp1jBr2CUK7zG4V9pVUZbpgEh37Qxeh+f0gtMVPSXixwlY+t6mMRiJd?=
 =?us-ascii?Q?ctDNDsekYri3V8xwKSIrSuaKDxMHejXAM/6ToV1j2qt7vUaFm4KsMZdEEWBZ?=
 =?us-ascii?Q?F0AxL7Qj/pTg2UYyqYkitEK2t8JuD/qhNc81FvUABjAOgN74PwYy51A2R/qD?=
 =?us-ascii?Q?/hOcAGzm5kNQD+wd1McPfqkmcs/ivbtfAAHRD6FYh/ozrrHqHOoXauJ7HYoy?=
 =?us-ascii?Q?DMENB2JqthFzeXWXct6TQr9QQcL4qbwmpjM8wa1YOdZ64cWYanrlufCOhewb?=
 =?us-ascii?Q?GuqDEpuji3afsY0ffA7sVaRBtLTpIsrWzqhsA4iybNz7N88e0k61MAfUa/Ff?=
 =?us-ascii?Q?5/J2uUKJR2ZeHcIW78R2hSD9Wgyjlt7YqEoByXzaFF5uTzVH1+MAbYriEE/j?=
 =?us-ascii?Q?bKdpd0aK7QJZfszhL9BTq4QAf8uAUE2fNYL9Irg/vxdInEJg5vw/s47UbIOn?=
 =?us-ascii?Q?FR6LjzIfxselsPSa5Ijhu8TJhJ6xM5i9DiWKfKMm6ylLVkuwEQYEJO69GL2h?=
 =?us-ascii?Q?DLQoY9p1LpsE00Ni93SCPs3t+PGUH2U1ykUgj77dpMx2ItHrn3B0aFMzQAU9?=
 =?us-ascii?Q?NHazCB80s3EoX/vBRgTZz1xPnhxN15LVYascE8GgB1+AsP3hbR1xRwL7G55m?=
 =?us-ascii?Q?uaoZTuigzG3DV0Abto+s72KypkV/FVWgBwFARB8fnbKaIeQv79Oxj7pWHZex?=
 =?us-ascii?Q?Qfxa9jcL5hOBO/6K/30D4y3A79+C9ZNA2WEpz4x2mBefLdPxSMI22FyTr5Bl?=
 =?us-ascii?Q?12yg5WqsQvlG6JoutCg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 13:33:17.8636 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec5128f-0d00-42f4-88ee-08de066f3dae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7814
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

From: Will Aitken <wiaitken@amd.com>

Adds new sriov msg flag to match host, feature flag in the amdgim
enum, and a wrapper macro to check it.

Signed-off-by: Will Aitken <wiaitken@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h    | 4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index d1172c8e58c4..73b7ead88aa3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -144,6 +144,7 @@ enum AMDGIM_FEATURE_FLAG {
 	AMDGIM_FEATURE_RAS_CAPS = (1 << 9),
 	AMDGIM_FEATURE_RAS_TELEMETRY = (1 << 10),
 	AMDGIM_FEATURE_RAS_CPER = (1 << 11),
+	AMDGIM_FEATURE_XGMI_TA_EXT_PEER_LINK = (1 << 12),
 };
 
 enum AMDGIM_REG_ACCESS_FLAG {
@@ -378,6 +379,9 @@ struct amdgpu_video_codec_info;
 #define amdgpu_sriov_ras_cper_en(adev) \
 ((adev)->virt.gim_feature & AMDGIM_FEATURE_RAS_CPER)
 
+#define amdgpu_sriov_xgmi_ta_ext_peer_link_en(adev) \
+((adev)->virt.gim_feature & AMDGIM_FEATURE_XGMI_TA_EXT_PEER_LINK)
+
 static inline bool is_virtual_machine(void)
 {
 #if defined(CONFIG_X86)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index 3a79ed7d8031..652d809bba06 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -102,7 +102,8 @@ union amd_sriov_msg_feature_flags {
 		uint32_t ras_caps		: 1;
 		uint32_t ras_telemetry		: 1;
 		uint32_t ras_cper		: 1;
-		uint32_t reserved		: 20;
+		uint32_t xgmi_ta_ext_peer_link	: 1;
+		uint32_t reserved		: 19;
 	} flags;
 	uint32_t all;
 };
-- 
2.43.0

