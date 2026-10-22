Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7E9606A31A
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 09:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Lpl8bCFl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD4E311245F;
	Thu, 22 Oct 2026 09:44:10 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012038.outbound.protection.outlook.com [52.101.53.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF7D011245F
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 09:44:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wnBhFEq0TJ+AFQaPnLgfb+m11Nvn+B3kD6Kt/s+DYsj30p/m+DYuc9Qu6MfOoGRYOZtDimRTukNXBsMk7LzGlz64IXqHZemOp2QhKeirsbPf84LI4m37b+HEOMTpy8D8hrrvB4IBQbxpBCMmWNuLidc+PHp2VFJp/NLuMwypwvY2m+uwxdFJYe32Ejko0iwFswuJHijBzGl4gXepXfmi2ECdnv+l11Tr5NjFZzGOf42dFn0NMA81qEHjUiyk9y8H5GbcblrxOcOKr9yClo7sApEqxS5aJydewxQX/spea2rOIbkpPVsLEDwV0BvTy+VmTzjXhtN4LenWmkRzI42Nww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ooHSry8ax3+z31QV9g8rx4Bnqr4WKAwNSIaYABV14fw=;
 b=k9cO/lzBigkBkcGmtXcp+vV+NmwxnNakNRY+J7SA3D8CqgXSmV1uKp3H4Z1ln0YUQlESIyfwPVPjC0iw31hzOb+PMx+hyWeAL9YstouZVkUiMEZxak6jMj1wxK8wd17Gr/phQyfKNiGFIwBE2QvHnhvxRk3Dk8T/MNJnyVCnRtvIL0Ju/itF6+v3xLtOWqPppc59aYUbNNGeEF00sePIM2Gtsnd3BLzhEmZ+CPOfFkwfhg7izbP4WkAAUgT2gRWf71uy+pK2DcYu7M4K7COCNM3ydrJfc0YkNArlqSmbt0vQCafal0FnOwp//OBy/D64KiqlO2GFbfQeSOc11yiuGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ooHSry8ax3+z31QV9g8rx4Bnqr4WKAwNSIaYABV14fw=;
 b=Lpl8bCFlHoa+x4InCha8TS9tjVCw7qHSr8cqGWgt1CHAz7T+Kvh548skvLNM7HWPOd4kbbKYjcU8MCDGXRWxSzMtNrFksd+nCg8QBCzohqjup2kMPoeH9g8p+bZ0BzK281xLFJ8VetNpvjUYv0IH/XTNkTGtluGfmcznFXAO6xI=
Received: from CH0PR04CA0087.namprd04.prod.outlook.com (2603:10b6:610:74::32)
 by IA0PPF1D04084C7.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bca) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Thu, 22 Oct
 2026 09:44:00 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::56) by CH0PR04CA0087.outlook.office365.com
 (2603:10b6:610:74::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.18 via Frontend Transport; Thu,
 22 Oct 2026 09:44:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 09:44:00 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Thu, 22 Oct 2026 04:43:58 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH] drm/amdgpu/gfx12: Add SPM interrupt source plumbing
Date: Thu, 22 Oct 2026 15:12:42 +0530
Message-ID: <20261022094242.1401561-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|IA0PPF1D04084C7:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c6b58ea-68a3-4670-0c4e-08df3020fff3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|18002099003|261021121427099003|11063799006|261009223027099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: NGEXE2eZUTPR/Uf5gXglAfAMzMUlhsKFwY6pJLuum5ohmd64fjSavZc17lC9gG1cVQjkgMSdZHXW9IHlLLJY6etJgaPdnnmpaslRoUAOW+JFOSYJ5Qn9Tf/xTQ9xxIdPmirx4xYX1ocUX2T7JkwtkbAlKsXFotfDwNIqj7wa84A4yqVGyjPkiHhb+hboc28B3uhFbP36C52gHCoFJPX90jN8lkOFaTFyVxiqnvB+Z5ilxiuZRRPU23UxNM87jJ4IXl6jRZwrxI2mEz4oYE6EkyLnpB5kWvvTeBRK0iGHe7PNFjCB2z6pgjeErx4nPjhjbVriTOYiuTNfTo4xJGOs5LiihiNE6IzxREEcC8m3G6MsG9RMXQbePeOu5b5VEd98O/wKtucTtu62C34RcakkZrQ/cOQp1+AKPkcHzunIU3pTrxAja6x1ukTKTm0inz/arK+8MZNsOrZRvDxOPlpF7i7PI0lhehOOtEDiOrGg5laDn20RIT6ZP4GHgoF/Lu3jNE+LfWivMpYTUDyetp70iEeTU3FEKMOAdc92A8sVJoL0+iCJn1Rw+xML338XB/X0YHjv94tq+q6IZNPZV274uXevP8yuH6PDTE12BxNx7LztSh85+x84c14fhUQ/pFwLYFdhGBakgA0FRY8OZpFRQYqv43/hjEsQWEWThKP0+7fh+BbYsUbPj1nQEfLTarX+
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(18002099003)(261021121427099003)(11063799006)(261009223027099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SvxtVI542B4p1F5ADsbLiUMaDrk3uDKjHPngF285povcCfYkdoJeSD6sbh/Tlv+UDSahTcfOh7rHr0fETJ5hO8uu5i6LParHd/t+x9lxVBZl3BKtn3+z59hiCOOojrHxHulkA9ta0M0uOdxO42ezkZePKHzyfzOwVizjYPtj2GcL8mYj3GaJ9eFOUiB52n73M4qNq3g0tpj4/ZXPbW2t/dCDAHKdML5voIJlmgvnF50nWDfVPCmZflyNnd2TkuV73mp0ii8WeBbI0oFOxhCb9u2pDmmV4GtIBfaKOVXmn+lxMsgrG5+Dd5TP6arKbJPTRfP4c0HDK9ZBx4GAp+/IHyGoQVStlEbzcmL5ANR4iC7aiU6Rff2vMpEv/jaUlGsqHwZbYNpQlTSLlMz4AtX1GTAj6Ovl+HU4AFCMLcdI60E1dj9ZAv7n2goKBn0ZQQh1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 09:44:00.0537 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c6b58ea-68a3-4670-0c4e-08df3020fff3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF1D04084C7
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Register the RLC Streaming Performance Monitor interrupt source (SRCID
202) on GFX12.1 and add a minimal interrupt handler for bring-up and
validation.

The handler currently logs interrupt information and SPM interrupt
register contents to help verify interrupt routing from RLC through IH
into the AMDGPU IRQ framework.

No SPM-specific interrupt processing is implemented yet.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c  | 39 +++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 5939e1fb3b24..7af5618b8b98 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -482,6 +482,7 @@ struct amdgpu_gfx {
 	struct amdgpu_irq_src		rlc_gc_fed_irq;
 	struct amdgpu_irq_src		rlc_poison_irq;
 	struct amdgpu_irq_src		pmr_ea_irq;
+	struct amdgpu_irq_src		spm_irq;
 	struct sq_work			sq_work;
 
 	/* gfx status */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 1589fc6413af..f2279a0d9e43 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -1355,6 +1355,13 @@ static int gfx_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	/* SPM interrupt */
+	r = amdgpu_irq_add_id(adev, SOC_V1_0_IH_CLIENTID_RLC,
+			      GFX_12_1_0__SRCID__RLC_STRM_PERF_MONITOR_INTERRUPT,
+			      &adev->gfx.spm_irq);
+	if (r)
+		return r;
+
 	/* pmr ea error */
 	r = amdgpu_irq_add_id(adev, SOC_V1_0_IH_CLIENTID_GFX,
 				GFX_12_1_0__SRCID__PMR_EA_ERROR_INTERRUPT,
@@ -3680,6 +3685,29 @@ static int gfx_v12_1_rlc_poison_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int gfx_v12_1_spm_irq(struct amdgpu_device *adev,
+			     struct amdgpu_irq_src *source,
+			     struct amdgpu_iv_entry *entry)
+{
+	u32 rlcs_info1, rlcs_info2;
+
+	rlcs_info1 = RREG32_SOC15(GC, 0, regRLC_RLCS_SPM_INT_INFO_1);
+	rlcs_info2 = RREG32_SOC15(GC, 0, regRLC_RLCS_SPM_INT_INFO_2);
+
+	dev_info(adev->dev,
+		 "SPM IRQ: client=%u src=%u ring=%u vmid=%u data0=0x%08x data1=0x%08x rlcs_info1=0x%08x rlcs_info2=0x%08x\n",
+		 entry->client_id,
+		 entry->src_id,
+		 entry->ring_id,
+		 entry->vmid,
+		 entry->src_data[0],
+		 entry->src_data[1],
+		 rlcs_info1,
+		 rlcs_info2);
+
+	return 0;
+}
+
 static int gfx_v12_1_pmr_ea_irq(struct amdgpu_device *adev,
 				  struct amdgpu_irq_src *source,
 				  struct amdgpu_iv_entry *entry)
@@ -3809,6 +3839,10 @@ static const struct amdgpu_irq_src_funcs gfx_v12_1_rlc_poison_irq_funcs = {
 	.process = gfx_v12_1_rlc_poison_irq,
 };
 
+static const struct amdgpu_irq_src_funcs gfx_v12_1_spm_irq_funcs = {
+	.process = gfx_v12_1_spm_irq,
+};
+
 static const struct amdgpu_irq_src_funcs gfx_v12_1_pmr_ea_irq_funcs = {
 	.process = gfx_v12_1_pmr_ea_irq,
 };
@@ -3827,6 +3861,9 @@ static void gfx_v12_1_set_irq_funcs(struct amdgpu_device *adev)
 	adev->gfx.rlc_poison_irq.num_types = 1;
 	adev->gfx.rlc_poison_irq.funcs = &gfx_v12_1_rlc_poison_irq_funcs;
 
+	adev->gfx.spm_irq.num_types = 1;
+	adev->gfx.spm_irq.funcs = &gfx_v12_1_spm_irq_funcs;
+
 	adev->gfx.pmr_ea_irq.num_types = 1;
 	adev->gfx.pmr_ea_irq.funcs = &gfx_v12_1_pmr_ea_irq_funcs;
 }
-- 
2.34.1

