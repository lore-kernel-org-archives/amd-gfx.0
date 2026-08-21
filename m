Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA311C5DF8C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:55:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6229810F4E4;
	Fri, 21 Aug 2026 19:55:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ayjq1ZjZ";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012027.outbound.protection.outlook.com
 [40.107.200.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 309E510F4E4
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:55:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cRN8e9iGuiAKQZ7C+QHiyRYtb4BJNpCNeeg05nu5QZu4zhRU2EWm1axNVNkb4xWrE1HKSwB/iEfBO/VjyzCNI0MYp2a8umgLBXYHYhpF+ah65MdJRLTWYgumr53hODWphEi8MgUu8RFHJhDEupvtcHR8LJ2DC2kVXVpCptO13y+ZCXKAVqE8V3uMTUfi/UkG/2FmHRmwVw+aa3tpxc1XMr7Wdqyomms8zX6uKIGV2igv8qlz2++ma0413PY+wL5VSf4btU5GVZ3Iu43I4lAFL3px46LbRg7avTrCrUgKXxKkkg9EdXKXngbxRSoGZ+1DC/U98TSM5pIOwCNElyCFww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SlksjwC/Ucgj/puVPU89BqTWo1aEetN6QOdgunLAkmQ=;
 b=Ul8nBj/XT/3TkOrpAQH1qjMcY5KTFcpHWdPz2tGBtbPvtXoRz1SV1veO0YUWgDFgSBN48EhF+Ue4o6omENjD2jUGRil303/bxmDJpCmnB7/CP75WDi94eXmkzEFOJpNUktz7mSijIXcZ/11EvBgb1ZsCh1YYAQxrWF84ZRFcngVD2Bw95w1sWSR14XfyAqOXZcjV2NpuSpvqP8JXSYH3h2Cpus/ewyegzpjxzEYCCMVDt77zFvS71OGa74+8VOvnDSBhlgGpoU8krGfFXJktkUnwiEn9IM6r7WiJlyFw+DiCTlHLze5nMlme1YImAoYTyodoRLQVLxet+MP6N1n+8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SlksjwC/Ucgj/puVPU89BqTWo1aEetN6QOdgunLAkmQ=;
 b=Ayjq1ZjZ4talUdAa1n/JrC45GEmDNBybNa/oDrtP9R0Vphm4HrPYkaV1KQ+aVX7I+OkCn8uqpy5KCBuFMNRoJO0gbb8Q+wgcSVNTeYrjb0Az2Z5C549mEIAgNxB+FnqjVkWphhEXBXpR8cK3n/ssfmPhR4cPrHkTZMDyTEa3gd8=
Received: from CH5P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::19)
 by IA0PR12MB8976.namprd12.prod.outlook.com (2603:10b6:208:485::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 19:35:28 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::ad) by CH5P222CA0007.outlook.office365.com
 (2603:10b6:610:1ee::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:28 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:24 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:23 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:23 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 20/95] drm/amdgpu: Add ual_config_state to ual_get_config
Date: Fri, 21 Aug 2026 15:33:43 -0400
Message-ID: <20260821193458.808626-21-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|IA0PR12MB8976:EE_
X-MS-Office365-Filtering-Correlation-Id: e1eaed5b-8deb-423a-19c9-08deffbb5b15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|56012099006|10067099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: gSd+5cbqm4QoFXpoVwxn0AU4psKUarGJn/ZthjVZcYCPX1zQNJIwwmxWHraNPXRSoDT36QE1SSLsCP/vY9bUAvWfGGJDFu0MkD6zUCDC4z54Uos5QyL/UmFBCCbLCl5ApYYzRIEOxupgK4+/t83n78EbCcKyR7Ol6RX8pQQMwg36P1z2N4jDEM6U6mYqbmudnbzieCrDqnazCWl0HvXDfN9gdCaDugXYCt/9JPMAYEW6nPAN5UOzqljnuIxCl/vsxjg+jQcNABk5MRnGKM7POVy6m0t5kmzR2OQpGhiCzcZnIdBuJyNZftJtoMTvjxhYm05fHE/rTuSrzSrj0nStKsqjEOlhTan+/J5raeymLfjMClvQSq5P8EXa0RTx8P2s/sri62HzRKiNnL1/nbTFDTHZ6tDRA/HRSFMcFsav2CnZMgdhMOGELApwCivmkdzc+HE3rAA8fNY1xvjxp2R0uZ4Q0bV1w6ru+kpBZAtefqo75yvOtlTxlVuPkjMBAfNMen4YwDtl1qtETJXa4mtUB2WbaiAuGgcVUoXFyUvk0lnhMNOJKEbtVEkCL1Med/DH4YoA5LN8vqONIuT8CP4p152kPfdBEkO3WixAsjlioRmlv/UYLxvklIJv1MN0EwKqm2o2lnfq8OwJPecKLSpz7roIwKSqKse8uK1RCCTmsm86uJ5PQjqbnoJjJRTuThwVuIwuBIq0QJa9BBcmvMVbxw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(56012099006)(10067099003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: raKKtat/B5JgzXJC+HUd7sxHRgQlcx7C1T+e9V63POvrHKNEQlmv++LlHXImHrk5+AKGIOHaNMO67HiB0lUx4ZmX4mUdfd3CS1oys6nazM8k8Ftda+O92zbAjTk0nBDEyeYKapi+tu2FleG8k0iFtXwIyktK0Jkq50OG5g9TAnQ8Iwipw/wNTJOGfY7fITPivS4B5aNq5xGBRBX+9feeNNWvUn85YzSLj8Q9EXRETv9Jd8Mm5zEM+qbBJrs2ZVLq2tiFEJZQLWESYPwM2pLu/WAlO3uHP9zHKDt1dCaYjCSUQifMEydyAjhBc0Ym40eP2cGdG+tYtOJz4EsjLVfa39BhZiKiY2+huvjq1FTTR/g1PmZXaIqR436GDIK+F8kw/dvcfZrhrERO+ZE1lRWwmJYU/vonu/e5QaWTPKh3Xi3MTZSNEmophNBlcEQDwBEW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:28.4943 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1eaed5b-8deb-423a-19c9-08deffbb5b15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8976
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

From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

Add psp_gfx_ual_config_state

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
index 6bcc04109d4cb..77be21c3eada3 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
@@ -421,6 +421,17 @@ enum psp_gfx_ual_link_type
     PSP_GFX_UALMAX
 };
 
+enum psp_gfx_ual_config_state
+{
+	UAL_CFG_IDLE        = 0,
+	UAL_CFG_PPOD        = 1,
+	UAL_CFG_VPOD        = 2,
+	UAL_CFG_PAUSE       = 3,
+	UAL_CFG_STATION     = 4,
+	UAL_CFG_COMPLETE    = 5,
+	UAL_CFG_INVALID     = 0xFF
+};
+
 struct psp_gfx_cmd_set_ppod_config_ual_v1
 {
     uint32_t accelerator_id;     // Accelerator ID
@@ -477,6 +488,7 @@ struct psp_gfx_get_config_ual_v1 {
     uint32_t vpod_size;
     uint32_t vpod_active_accelerators[PSP_GFX_UAL_MAX_ACC_BIT_MASK];
     enum psp_gfx_ual_npa_address_mode addr_mode;
+    enum psp_gfx_ual_config_state config_state;
 };
 
 struct psp_gfx_cmd_send_completion_ual_v1
-- 
2.55.0

