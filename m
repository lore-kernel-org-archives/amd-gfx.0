Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE454C7115C
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Jun 2025 15:56:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B5B810E10B;
	Fri, 20 Jun 2025 15:56:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b8x3R1c3";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2064.outbound.protection.outlook.com [40.107.95.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BDB010E10B
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Jun 2025 15:56:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lyzktwie28g0dGSvrV4rKGOdokMlDq2XkAfBn8jioTaxgtsfs9ojmKzE6O0eaxnW+Xn8FvYcdEFoc/GheuZl2z9lBdwr5cKJrfEt1k4QDxku9EJqzTc2UJ4DmysoSYVPuRXTYtzLQTWiUWig39MolfXhyPl/Qxgs27EDsrJIu9xgAlff5RnCPtxOEtToMG1s7v8QmUwA/g9dNUinQH9k+8mtOpMLWO86zm22A9m+weBapp8oY9pZBpmgY6yEsL5yqgZN3T2YCX8/NYrhAH1dLtRdsBYOaOxwu1phH5uWzo0Fe7Hdy61rz8XWqpJ0vtpRoG+waZri/ZbVF+yxkppnUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJStKS/xnsM03HnwjrGdUE4WvbCOW2tOa7GeR+Boocs=;
 b=a0o3vgXkt2J1D7miH0wWJBM4UD7RrFH1vsrvy07YHQTCnAmJ1cAywZ2jyStQFUyw1ysAHODJQxv7EqZAO0Q8vpbHjb9yVzUU27ughltx0iua+UU5pBiBDN/tI/lgMcHmjFS2YOz2bNvTJBTCsJMwwA3yOD0UaBYtpwqwrWM1eMwvbHAb+KKPOy+30vU+x5RrEomZ8AoHAzG3NxRRDWAEG+zcykaUkCtGN4CcrOWlM2mUNnZTX5YnijazK3yidWdwFi5aIe/UY5kxYXPAzoaOM7aKUfi/YsBWYyvyE6koFJ/4Ys9I9GF3mAdSzYyTKapQEMu3i3z5m+m0q2puH5tciA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJStKS/xnsM03HnwjrGdUE4WvbCOW2tOa7GeR+Boocs=;
 b=b8x3R1c3IcOjekEmeAxFmUj+H5ViBOC6gV3/qf4SR+8DWvaBlwCUccy1wF9Slc8JkIfDVvjhfnI0rSrwsMZYjV4JatnZ0FXPjChxGImG7iId4cU5obdPkQ6t1vTmRmG83dmnPxltG66yOLlBEepqVivVART/vwMyT8LxxNUTH+E=
Received: from BY3PR04CA0014.namprd04.prod.outlook.com (2603:10b6:a03:217::19)
 by CY8PR12MB7732.namprd12.prod.outlook.com (2603:10b6:930:87::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Fri, 20 Jun
 2025 15:56:09 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:a03:217:cafe::68) by BY3PR04CA0014.outlook.office365.com
 (2603:10b6:a03:217::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.25 via Frontend Transport; Fri,
 20 Jun 2025 15:56:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.21 via Frontend Transport; Fri, 20 Jun 2025 15:56:09 +0000
Received: from sriov-ubuntu-161.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Jun
 2025 10:56:06 -0500
From: Tony Yi <Tony.Yi@amd.com>
To: <tony.yi@amd.com>, <victor.skvortsov@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <zhigang.luo@amd.com>, <shravankumar.gande@amd.com>, <jeffrey.chan@amd.com>
CC: Tony Yi <Tony.Yi@amd.com>
Subject: [PATCH] drm/amdgpu: Check SQ_CONFIG register support on SRIOV
Date: Fri, 20 Jun 2025 10:54:40 -0500
Message-ID: <20250620155440.1897130-1-Tony.Yi@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|CY8PR12MB7732:EE_
X-MS-Office365-Filtering-Correlation-Id: d34de6b7-2c2a-4261-a8ad-08ddb012f91a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OJT5x8UOqX2BaaZm4efqm2J51wyDr9SXdmS68sfghupcABIeK6/PwJYNas+t?=
 =?us-ascii?Q?UQF4O1iNWEhIeIINxsYWXZ0W7AId9CVXLlwCKsjnVc/ZyY/WLrwDDAt739BJ?=
 =?us-ascii?Q?2bPj+Hl+mrPDi7e8vSjU5xMCPq81iiu7eDt+o0AabeMZ32swFhvHHCLl0qXp?=
 =?us-ascii?Q?vNVbxLcbaJzjANRLwd1ZFPiw9nue6TbT3eRb2n3yFyBxTn25RV5F3BwN+JY3?=
 =?us-ascii?Q?O1NPmNShc4CoPOVUjs06FKiHNlLqIdIigbrNjIe2Jt35BLC+5Uy+mgZrPNt1?=
 =?us-ascii?Q?wI6XVhiltwl3v6sxUTo7XtzIQTghGLC6BPo50mKimyWrU7pMjxvtIoHI7C3s?=
 =?us-ascii?Q?N6rCO+/M9StrFK/meNAaFY4MvKWQLZj7O7abLKr/QQVcFF65i3kWTRm++d9g?=
 =?us-ascii?Q?AbWV/fGeRe2dDilr7B+kyqnQ37Svk0mO+7i3zoZhKL/1dF+5J1F8WwnZgKVN?=
 =?us-ascii?Q?6PUAU0COpJMSlqpU1HLiA896hhonSyw9wMEjBQFdUSCqQzNBf+NYPc9qcISb?=
 =?us-ascii?Q?aR7uTA6rqs271QKfk1pFbT0wM9dSnUj2Pn5FIEop9YzaA20YARNILvVftP74?=
 =?us-ascii?Q?rCfYWciFbOxPhS1YTKn98TFIaRVWxcexZOWO2pcO6FFEaWRpUfKyr7DWVAYl?=
 =?us-ascii?Q?3/QKo7nKKGkOe8k1uxVJ4GxLI+gaXnd66ITvuTFil1Ok9bXYvDsgwm76Gq/j?=
 =?us-ascii?Q?c2jd6vSIhNyF0JX1vRwEeKTGYH3NWniDxQXcFJF8xFDeRrecJLBagr+I9muh?=
 =?us-ascii?Q?ECervGDGBW+FQtYAt5t9FeTZwn/K1MYP3Eg92RB4CTRYmjChUjJSh/qdQO1Q?=
 =?us-ascii?Q?sluQGC63gfBq1YBheAFtbGAEK8x4sH0IC9TrGmGFP8sGpFyRaI/wWSS+L1ws?=
 =?us-ascii?Q?KLV4RxpWkUM7Z3r6ndtIw5wgp8kXycfUdx7w8aNIHbEMmxjMsCfZCbGBbNN+?=
 =?us-ascii?Q?C6RHZssup8/makb7sLMOEPagthkoBtiBFHd+80iQvB+AnDcOfQ8tvTsAjWln?=
 =?us-ascii?Q?dPpnJwe18996jnVe7XI0raYmov4JI4ln416ieWLYdOWgpq1tMj5XqyGGzLWW?=
 =?us-ascii?Q?bd6wQf6McQe7FPXA0KpJN+PBBehX/7PAKkPNC9VbugHL5ndJ+zDqoAQP8tVh?=
 =?us-ascii?Q?WTH6e1eWHlnV4re3fRG0jRImyKtVAJ2Z3ZHGfjmv0PS+ltizpPvL3WAO1D9k?=
 =?us-ascii?Q?gm8N667WVCpKg1Mwh6cMVGX5JD3rwRbMoYBBe0FqtpMiTgJCJLPcpGYZ/8qA?=
 =?us-ascii?Q?x/VBJESJBUNspR/GANBotd1ZvdAXIoN9A5hw4gtudoQCcBkbZXTauepVpykC?=
 =?us-ascii?Q?gIvPpkINeDuRLTfRGamOxV5rF876pX2b7Hs7ErPLNNsGPPJJH7qfMQQPKFeI?=
 =?us-ascii?Q?NMjtJrmlkcTi6gINYfeY9Hv7cC6O1i8Iw6++LiYbdeUisbREJGVO3pbnbB19?=
 =?us-ascii?Q?eLL2ryBAv5G7XVWo5NUDrmAMygZr9MvP0pIrIXXAvI4Gq/Lb1T3d3ymeRdZ8?=
 =?us-ascii?Q?XW7Aem/u5ZycVxnNuaEgV2Tubgol7xdoNX+h?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 15:56:09.0768 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d34de6b7-2c2a-4261-a8ad-08ddb012f91a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7732
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

On SRIOV environments, check if RLCG supports
SQ_CONFIG register programming.

Signed-off-by: Tony Yi <Tony.Yi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h    | 8 +++++++-
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 3 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c     | 4 +++-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 9320461bb486..3da3ebb1d9a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -152,8 +152,10 @@ enum AMDGIM_REG_ACCESS_FLAG {
 	AMDGIM_FEATURE_MMHUB_REG_RLC_EN   = (1 << 1),
 	/* Use RLC to program GC regs */
 	AMDGIM_FEATURE_GC_REG_RLC_EN      = (1 << 2),
-	/* Use PSP to program L1_TLB_CNTL*/
+	/* Use PSP to program L1_TLB_CNTL */
 	AMDGIM_FEATURE_L1_TLB_CNTL_PSP_EN = (1 << 3),
+	/* Use RLCG to program SQ_CONFIG1 */
+	AMDGIM_FEATURE_REG_ACCESS_SQ_CONFIG = (1 << 4),
 };
 
 struct amdgim_pf2vf_info_v1 {
@@ -346,6 +348,10 @@ struct amdgpu_video_codec_info;
 #define amdgpu_sriov_rlcg_error_report_enabled(adev) \
         (amdgpu_sriov_reg_indirect_mmhub(adev) || amdgpu_sriov_reg_indirect_gc(adev))
 
+#define amdgpu_sriov_reg_access_sq_config(adev) \
+(amdgpu_sriov_vf((adev)) && \
+	((adev)->virt.reg_access & (AMDGIM_FEATURE_REG_ACCESS_SQ_CONFIG)))
+
 #define amdgpu_passthrough(adev) \
 ((adev)->virt.caps & AMDGPU_PASSTHROUGH_MODE)
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index 92ca13097aaa..33edad1f9dcd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -113,7 +113,8 @@ union amd_sriov_reg_access_flags {
 		uint32_t vf_reg_access_mmhub		: 1;
 		uint32_t vf_reg_access_gc		: 1;
 		uint32_t vf_reg_access_l1_tlb_cntl	: 1;
-		uint32_t reserved			: 28;
+		uint32_t vf_reg_access_sq_config	: 1;
+		uint32_t reserved			: 27;
 	} flags;
 	uint32_t all;
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index c233edf60569..4a5fc5b8ac6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1349,7 +1349,9 @@ static void gfx_v9_4_3_constants_init(struct amdgpu_device *adev)
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	/* ToDo: GC 9.4.4 */
 	case IP_VERSION(9, 4, 3):
-		if (adev->gfx.mec_fw_version >= 184)
+		if (adev->gfx.mec_fw_version >= 184 &&
+		    (amdgpu_sriov_reg_access_sq_config(adev) ||
+		     !amdgpu_sriov_vf(adev)))
 			adev->gmc.xnack_flags |= AMDGPU_GMC_XNACK_FLAG_CHAIN;
 		break;
 	case IP_VERSION(9, 5, 0):
-- 
2.34.1

