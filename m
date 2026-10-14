Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D187CC6B1A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 12:55:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D196310E640;
	Wed, 14 Oct 2026 12:55:34 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010025.outbound.protection.outlook.com [52.101.56.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F3FE10E640
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 12:55:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EpfvJKqzAa5KjT+LJxV2R5FsJcUEhhxvrdiG2vPAcuiKgjBAJKnIv5JBqll2cvGyEpcR8gg2edi298a0hcB5RULDpVoWxWrzBJzHEGrTor9X1wAaohzG6TgO1ZcDmC0b6pI73t0XoqWLWzmkm2DUBJysHduHA44bPvoDm6J0cImiHuJ/SHSoqxY+/PLgSUKMdrJlkYrNnp/1cmQIfnxu0AsfWRm0/bGJaB2LXuknUEsrJ3Pgs2t2/bRlNuXEvG3SlMfSIh0DJvZjGdFrwDuxC5rLhAppN2i585lYWaBeG7SAs3P7JlADjutN+VhuBArxJR4GewUuwcew/3EcstzByg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJFa17XF9agbeJe5O4CXCBXJSDNA4htBRMFckav2j+s=;
 b=jTTyEiVW6KhfsrZCt2atK1VdAwNoMiSWf8IUpQmvNz0swsh4tqwfpHVrDIU48VuEdwAiESG6tUVBcAYCG4Yq3eHAxod8K+V0bSa8qo9OI/Kf8dE9uuVpwy+9+Oy9OcVn9EIae2Wpa1At9rx74GxQFQRNdaHECTJUM/aaS+OMz3zoNTRvfy4szeFYA0l5DUIt466H5rGBp7aMtC79reoCBrpJmfVr8ED+l6WOl9mrEA2ke3ukYy9+xehq8DQngM26Ra4JW355doFWSsxDqa1A++WBAND8ASxrb1umsPHUg0u5L7FZwJaC95whHHzfIGO8xdFZD3+LR7dJgBkMaCSmMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJFa17XF9agbeJe5O4CXCBXJSDNA4htBRMFckav2j+s=;
 b=3fRu8YbYFwiNlzchmVR499uKc1Zdu7kJNYd/AY1PM2SD97f38u1tBBDLsK04TbpGttfkPeYXTE8cCAL781AHfVO36gcpY0wnjXfXKc0VaRYNp4gpAeLO0CDxY3r3pKksa1mPRyvAKCl52FELdZrrcIHPhaHERtLb/fZbyqXgWAM=
Received: from CH2PR07CA0041.namprd07.prod.outlook.com (2603:10b6:610:5b::15)
 by DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 12:55:19 +0000
Received: from DM3PEPF000265B0.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::65) by CH2PR07CA0041.outlook.office365.com
 (2603:10b6:610:5b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 14
 Oct 2026 12:55:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265B0.mail.protection.outlook.com (10.167.23.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 12:55:18 +0000
Received: from stanley-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 07:55:09 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <YiPeng.Chai@amd.com>,
 <Candice.Li@amd.com>, <Xiang.Liu@amd.com>, <Ce.Sun@amd.com>,
 <Gangliang.Xie@amd.com>, Stanley.Yang <Stanley.Yang@amd.com>
Subject: [PATCH Review v2 1/1] drm/amd/ras: Fix APU platform ras block feature
 mask
Date: Wed, 14 Oct 2026 20:53:58 +0800
Message-ID: <20261014125358.320557-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265B0:EE_|DS7PR12MB6309:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b1529ee-d6c4-4e18-4177-08df29f26677
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|56012099006|261009223027099003|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: fTdu3aBKy9bfeE0a+2YVENcDBdan+klbdBRvv5D9d3thIGqfxIQn4yCEnGb9XfxEo2fLduDyb+e+dNaoo5AbcgzCM3yjN7zhEg6mVkPR7i6xvnRQdJ2U0RENmy9fMfS0t8GgseRfJUfr+86Ys1Pb1t6992Nh9dOrwkV+iuYknc2Q31Aep/jxpdgSKHpcRTZlgNffXMYVGJBAoq6sW8GYBn7616kPrcNchAJA2nNM02miT9CQaxMiHC46yP3QSE8zN2rAiDZsvPShWDAkAMg/IgeczEVRMsPXlaD+iVZ+pmxBhkerlbTYYtStuSSP5g4RhAoljbR3wEzeSG/BLedV7nRXIiNJ5HQGa89mNc3aXqatbLmU/OOBOC6jCEsjfFaspJv0GuFcCZ2vL8OPz/cj5bZrgnXa0FcxPyEzT9BrN9q/yHvrYvT3OWIEy0lnhGSYHJkHQjokcYgrplqsplZFotzMgMAV25b89HJHgjstVR4+8gdhkdMOjtHeWX7FxWoepJOcsOVszm+z0DyKpRaqB3oO1YbtHDgunjv6tJtk2mto9adXBllxmiR+SGmf/i6EdoPljvYvIWTGTixAGFp1DiVUj3bG6xh6IIG4eJwNtcUJoaYOrcPOTa2N9F2fbMGU9YClf7FiB1E4itmbjWHvoyOyQEOyBiBtPxxY8EXsYxaJGoniSSsj0Aih4iv13VATpgGZjy9DgVs5jdF94FqqDQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(56012099006)(261009223027099003)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: o5lWjx7y2ydKT6F6/C4kcooQNXw1t9pJJnkjj4cXEVpkkDYGlbombMo1NrHXOSM3LLJcdHeqe+E+rnm1q7f4gWTuQVzjGUBkDW/mGtX54f5ibC+kkYiX7JrMAmdRpNI5DIBrIU9DzSib44EukF2lMr+qVuFL03sCxq10HTzV51xhBNO4FgPIOs86CDuogcVP/0QBaaQ6j6Nn7+LauqtqVKaLXSXvu6Mahj4exdLFST0px91fwVt9OEP+/r6ia0nJr497ne8bTAvgBJdIu8Io7K+uO7HgnPhIq+rJAjByLq71CgZk6D3EWf6Idyl5ByuRnoSPZ+t/cPuiaBc/DFlRKiNzeingkiyFkY0mxRcbH9evHLsb78RfG59jfk7UWfTAF/7CNKlmnzYLvkWvQsNQrU7oYmINHWm5KFuPZZ8QLcSuCXtKptM2CcTqwt38Felv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 12:55:18.7080 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b1529ee-d6c4-4e18-4177-08df29f26677
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265B0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6309
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

the register c2pmsg_127 design only applies to dGPU not
APU platform, so hard code ras block feature mask on APU
platform.

Changed from v1:
	replace AMD_IS_APU with is_app_apu for judgment

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/ras/core/ras_psp_v13_0.c | 14 ++++++++++++--
 drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h    |  6 ++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/ras_psp_v13_0.c b/drivers/gpu/drm/amd/ras/core/ras_psp_v13_0.c
index 49ba57f58878..bdd3da2c66f3 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_psp_v13_0.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_psp_v13_0.c
@@ -80,13 +80,23 @@ static int ras_psp_v13_0_get_ras_block_maps(struct ras_core_context *ras_core,
 static int ras_psp_v13_0_get_ras_hw_caps(struct ras_core_context *ras_core,
 				struct ras_hw_caps *ras_cap)
 {
-	uint32_t ras_hw_cap, bit;
+	uint32_t ras_hw_cap = 0, bit;
 	uint32_t i;
 
 	if (!ras_cap)
 		return -EINVAL;
 
-	ras_hw_cap = RAS_DEV_RREG32_SOC15(ras_core->dev, MP0, 0, regMP0_SMN_C2PMSG_127);
+	/*
+	 * driver only manages a few IP block RAS fearure
+	 * when GPU is connected CPU through XGMI
+	 */
+	if (RAS_DEV_IS_APP_APU(ras_core->dev)) {
+		ras_hw_cap |= (1 << AMDGPU_RAS_BLOCK__GFX |
+					   1 << AMDGPU_RAS_BLOCK__SDMA |
+					   1 << AMDGPU_RAS_BLOCK__MMHUB);
+	} else {
+		ras_hw_cap = RAS_DEV_RREG32_SOC15(ras_core->dev, MP0, 0, regMP0_SMN_C2PMSG_127);
+	}
 
 	ras_cap->poison_supported = true;
 	ras_cap->flex_mca_enabled = false;
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h b/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
index 1c5e02de7fca..00ff12ccb01a 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
@@ -106,6 +106,12 @@
 	amdgpu_ip_map_logical_to_dev_mask(&adev->ip_map, ip##_HWIP, mask); \
 })
 
+#define RAS_DEV_IS_APP_APU(dev) \
+({ \
+	struct amdgpu_device *adev = (struct amdgpu_device *)dev; \
+	adev->gmc.is_app_apu; \
+})
+
 static inline void *ras_radix_tree_delete_iter(struct radix_tree_root *root, void *iter)
 {
 	return radix_tree_delete(root, ((struct radix_tree_iter *)iter)->index);
-- 
2.43.0

