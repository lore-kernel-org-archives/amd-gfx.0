Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED10D2ECF9
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 07:00:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F8E610E55C;
	Tue, 20 Jan 2026 07:00:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YO0obULr";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010023.outbound.protection.outlook.com [52.101.61.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07A4310E55A
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 07:00:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=amtmEP3q7xJ8/BKiPgXVb+Mls9aZOX3Lzh3fw1sU3h7In9vYgoXFp1wVOql4NVlCqfu0rfXbURIDlMw2uzCTC3ZU/P9/SMWLVcv+1rqTH7buEfvlSZffzpRwtHsjEEPWvz4KHLJhtta7o8qioRak3toLY4RLcZ08mky5lGeSAD+/f5XSELplUcdq9AvuYbj/TXIB9NanGgR7suSV9lvJaseVinkk6QvLFnGXqVxpLkOLmP+M0Lvah/1uXwl6lDDkR8NNO04I8pnuUM5nIpWGiq5zP7ri99Wb+5DYApxhoeQblLIRbLzWDr48ZVAYs2UJQ6KYEo+nw/TXsMm+ZEHgsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYj//V6cxm6401VGhLYkuorRsCtmSREuxeMEMeKBOVA=;
 b=fzqSD2IvTgnR9+gQjLZKmFTGci8I449pAtdVlaSb3ItSKw6PtZ+dHA3ubn5QnQmb8GzxpWvpFcAXlwBBOc8NW5CDr6cM4gZer9+IvNhIQ3CO5TyvAMF94mY7fIYF+yV7y5NdfexvtIAUttj+gbWOf6yybJR7g/JzpfL14Olsv5ahHjY2QEZGZ+YsWO9vqzYSja7jtC8OV6lH9xCDTgjo28uS7BC28xf/Y+cQPQ0r8dlysGd+qj5wnjz1XnbXI4hD7PFWNCdJSBeb/7ULR6GOn3UshO39V3o1XjOhkkcLqkGXDSVKWW+ZcJOKYWPPqt6prtAQ8FYs1TwIstBV8/IP+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYj//V6cxm6401VGhLYkuorRsCtmSREuxeMEMeKBOVA=;
 b=YO0obULr56jxmUv1r+mpomANgjEHGNt012vIg2pZ/OZstuTyhMMPzjyFQAjpDcX+2gua4ajoQPGkI8QVy6g/2mBYoPTRRTaXGXFlbWge3d49PUTZoj2xiP8VDoEXusRr6qLVYSRv6eF324z18esFIRkndwOh2VtYnE7TzD4kVcA=
Received: from BY5PR03CA0025.namprd03.prod.outlook.com (2603:10b6:a03:1e0::35)
 by SN7PR12MB6981.namprd12.prod.outlook.com (2603:10b6:806:263::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 07:00:08 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::6d) by BY5PR03CA0025.outlook.office365.com
 (2603:10b6:a03:1e0::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Tue,
 20 Jan 2026 06:59:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 07:00:08 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 20 Jan
 2026 00:59:59 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH 05/15] drm/amdgpu: Add gc cac method to register block
Date: Tue, 20 Jan 2026 12:27:39 +0530
Message-ID: <20260120065931.1300054-6-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260120065931.1300054-1-lijo.lazar@amd.com>
References: <20260120065931.1300054-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|SN7PR12MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: d1c91dbd-6e78-4634-fafa-08de57f18c0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DTCVF62gSn5P0McTWfYYg5BVDCygNoqD+9T6O+2xjy6QesHpxHLs7nbAY9fm?=
 =?us-ascii?Q?XGfMGpguoPkFohs0FV1MjQE9FSzXOdIG/eP9E89LYHLEiihjd1rXKsPYLqOV?=
 =?us-ascii?Q?WWxtmlFi3Xp4KiZzqVI8J2pTofB4XcGHXfXAVK7Kn1pAFRBQmOfAigleddzt?=
 =?us-ascii?Q?SM3DW5X7jKPbcj8qDHInFnFAfBvsxkYkMwftYdXZGClv0I4UwGGYMhT+VPE7?=
 =?us-ascii?Q?HtWevaMwixiFD9zB9TFKeZOXKOEdjgncmh2w9YKgdOsikZ64j100yOCs6X/F?=
 =?us-ascii?Q?syaLq3nhjKMq59iD7gB+fsNzH1ECpGuczKevE8IJkEEmxBqUaPozJ4JAn30P?=
 =?us-ascii?Q?RrbmF6wQsgSV32VKaIboM6/Dm2TqsIT8OLi5ypOu3Vvb6w19biWgk3lhTLvD?=
 =?us-ascii?Q?ZuC95iEnLjtRFp/rT0RS4hd2nB5C1bzG62qLVE0937OoYyGinW1jKf5ws1PC?=
 =?us-ascii?Q?1+q+ip0WPzPEuJCI3v+4OP6ZGwUzJp1rTIIkJsYSHkqERvazkG07IGeigdXV?=
 =?us-ascii?Q?fFckrxzz6KvmRegmNajq6VxLoq/KybO90hVTnb5lsJVMf/uHrCrTa25C74Ov?=
 =?us-ascii?Q?glkd0JKfb9WLTY7/nFB0PwSOsAKqFdLYZRdox8pSMkE7aQaVf2mLGCzMMDD7?=
 =?us-ascii?Q?Fiv54Syig9mY0oCtxS3oG3k0O6+ElpWpHPp9JpC5tvFhAB46vHCEeLFnbb8/?=
 =?us-ascii?Q?YWyHGQdE/IpkD8zHqsCGY05676QG+8jyi2QTLTL6aahsYPDUUuLc4NP9VU9W?=
 =?us-ascii?Q?AY4kAFlRgSBmM2tI+0LW9+o0+9F+7tkXhPIbVHtz2AchhZBHx2aUT6fBCM6i?=
 =?us-ascii?Q?6Q02PNW9HdK9xeByt1aOgtm66WDEYm+ACNpCsV0OrO7UDY7WT1eq7iEw5//D?=
 =?us-ascii?Q?1QxTUpFQfz0N8dMaxDgxRTJSwvYEFrOCOV3AnlYHuMuWTDt1WXQkTpyk8+eo?=
 =?us-ascii?Q?NH4N3okUxxuH6VEk7XZWJqclHbk6yZSzzXralLzafV6nW1rBGmSfJiVieNDh?=
 =?us-ascii?Q?omHzKp8LQTEPMI4FUmwVP2B+4VZcu8hP4QLQe26HnLpPSkoo70e5hsnS6WLA?=
 =?us-ascii?Q?VMDoYFom2TTfF+Sud56xZUWPAGDpEhQCugFx66VWPlZSSe3eJr/bbueh2SyC?=
 =?us-ascii?Q?Kpm/hkW6zJzCEjlmxJK2ZmJ0Mjvyke376WQ0tIkLmD/NFXAAuJkTEy28O942?=
 =?us-ascii?Q?Q29Fs669EwkRHdJd9SOh6Dv4+vqizob2GSkeR8cJdm893fr/V8OCtxB218un?=
 =?us-ascii?Q?tOJT11up/kWIMmru3XaRwrF5cy+8Va0yw7D8IctRlH0bAF8pltm9uqZmNcQg?=
 =?us-ascii?Q?kndOT34pBZ+dRTiOLWN6HR/8IxCcwRAVRdKEUybT/KYUWJiXBKBZ9HFSmGcT?=
 =?us-ascii?Q?lYSJtkLqi/oaYAqlyhr9zNqkdelXiPZXxVoVwa0Jyjsjv8SdBk3S5INrTh9F?=
 =?us-ascii?Q?RgccMzgQsDvA6WTX54DNX5eFmoLrPexSH3j+eruLruRypc7uEhUKKtH8ePY5?=
 =?us-ascii?Q?OIo5SKm3CibmxI7idTo2/eWhWPR1Nnfu4N4ff3f8vO17glplMCZBli33xyZF?=
 =?us-ascii?Q?GB3pJaQ334xsy2G15Hb3QuaeTjSDtLrhpWmF39WafXC6Tejvq1+ztVH+xBXQ?=
 =?us-ascii?Q?eSMAQQvlg7cG/qVbgSRVTTmnZztJp2bFAxBG656SMqm4wbgY+2cje45QheWK?=
 =?us-ascii?Q?0OICVA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 07:00:08.0434 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c91dbd-6e78-4634-fafa-08de57f18c0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6981
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

Move gc cac access callbacks to register access block.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  8 ++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  3 ---
 .../gpu/drm/amd/amdgpu/amdgpu_reg_access.c    | 24 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_reg_access.h    |  4 ++++
 drivers/gpu/drm/amd/amdgpu/soc15.c            | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/vi.c               | 12 +++++-----
 6 files changed, 42 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index f312057494e6..95defe443a5d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -906,10 +906,6 @@ struct amdgpu_device {
 	amdgpu_wreg64_t			pcie_wreg64;
 	amdgpu_rreg64_ext_t			pcie_rreg64_ext;
 	amdgpu_wreg64_ext_t pcie_wreg64_ext;
-	/* protects concurrent gc_cac register access */
-	spinlock_t gc_cac_idx_lock;
-	amdgpu_rreg_t			gc_cac_rreg;
-	amdgpu_wreg_t			gc_cac_wreg;
 	/* protects concurrent se_cac register access */
 	spinlock_t se_cac_idx_lock;
 	amdgpu_rreg_t			se_cac_rreg;
@@ -1320,8 +1316,8 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 #define WREG32_UVD_CTX(reg, v) amdgpu_reg_uvd_ctx_wr32(adev, (reg), (v))
 #define RREG32_DIDT(reg) amdgpu_reg_didt_rd32(adev, (reg))
 #define WREG32_DIDT(reg, v) amdgpu_reg_didt_wr32(adev, (reg), (v))
-#define RREG32_GC_CAC(reg) adev->gc_cac_rreg(adev, (reg))
-#define WREG32_GC_CAC(reg, v) adev->gc_cac_wreg(adev, (reg), (v))
+#define RREG32_GC_CAC(reg) amdgpu_reg_gc_cac_rd32(adev, (reg))
+#define WREG32_GC_CAC(reg, v) amdgpu_reg_gc_cac_wr32(adev, (reg), (v))
 #define RREG32_SE_CAC(reg) adev->se_cac_rreg(adev, (reg))
 #define WREG32_SE_CAC(reg, v) adev->se_cac_wreg(adev, (reg), (v))
 #define RREG32_AUDIO_ENDPT(block, reg) adev->audio_endpt_rreg(adev, (block), (reg))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 40d7f3b7cb2e..ef4c91482061 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3861,8 +3861,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	adev->pcie_wreg64 = &amdgpu_invalid_wreg64;
 	adev->pcie_rreg64_ext = &amdgpu_invalid_rreg64_ext;
 	adev->pcie_wreg64_ext = &amdgpu_invalid_wreg64_ext;
-	adev->gc_cac_rreg = &amdgpu_invalid_rreg;
-	adev->gc_cac_wreg = &amdgpu_invalid_wreg;
 	adev->audio_endpt_rreg = &amdgpu_block_invalid_rreg;
 	adev->audio_endpt_wreg = &amdgpu_block_invalid_wreg;
 
@@ -3910,7 +3908,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	spin_lock_init(&adev->mmio_idx_lock);
 	spin_lock_init(&adev->pcie_idx_lock);
-	spin_lock_init(&adev->gc_cac_idx_lock);
 	spin_lock_init(&adev->se_cac_idx_lock);
 	spin_lock_init(&adev->audio_endpt_idx_lock);
 	spin_lock_init(&adev->mm_stats.lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
index c31c86bbf18a..69db9de507c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
@@ -46,6 +46,10 @@ void amdgpu_reg_access_init(struct amdgpu_device *adev)
 	spin_lock_init(&adev->reg.didt.lock);
 	adev->reg.didt.rreg = NULL;
 	adev->reg.didt.wreg = NULL;
+
+	spin_lock_init(&adev->reg.gc_cac.lock);
+	adev->reg.gc_cac.rreg = NULL;
+	adev->reg.gc_cac.wreg = NULL;
 }
 
 uint32_t amdgpu_reg_smc_rd32(struct amdgpu_device *adev, uint32_t reg)
@@ -105,6 +109,26 @@ void amdgpu_reg_didt_wr32(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
 	adev->reg.didt.wreg(adev, reg, v);
 }
 
+uint32_t amdgpu_reg_gc_cac_rd32(struct amdgpu_device *adev, uint32_t reg)
+{
+	if (!adev->reg.gc_cac.rreg) {
+		dev_err_once(adev->dev, "GC_CAC register read not supported\n");
+		return 0;
+	}
+	return adev->reg.gc_cac.rreg(adev, reg);
+}
+
+void amdgpu_reg_gc_cac_wr32(struct amdgpu_device *adev, uint32_t reg,
+			    uint32_t v)
+{
+	if (!adev->reg.gc_cac.wreg) {
+		dev_err_once(adev->dev,
+			     "GC_CAC register write not supported\n");
+		return;
+	}
+	adev->reg.gc_cac.wreg(adev, reg, v);
+}
+
 /*
  * register access helper functions.
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
index 239dbd6ef2f6..3736fd571771 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
@@ -42,6 +42,7 @@ struct amdgpu_reg_access {
 	struct amdgpu_reg_ind smc;
 	struct amdgpu_reg_ind uvd_ctx;
 	struct amdgpu_reg_ind didt;
+	struct amdgpu_reg_ind gc_cac;
 };
 
 void amdgpu_reg_access_init(struct amdgpu_device *adev);
@@ -51,6 +52,9 @@ uint32_t amdgpu_reg_uvd_ctx_rd32(struct amdgpu_device *adev, uint32_t reg);
 void amdgpu_reg_uvd_ctx_wr32(struct amdgpu_device *adev, uint32_t reg, uint32_t v);
 uint32_t amdgpu_reg_didt_rd32(struct amdgpu_device *adev, uint32_t reg);
 void amdgpu_reg_didt_wr32(struct amdgpu_device *adev, uint32_t reg, uint32_t v);
+uint32_t amdgpu_reg_gc_cac_rd32(struct amdgpu_device *adev, uint32_t reg);
+void amdgpu_reg_gc_cac_wr32(struct amdgpu_device *adev, uint32_t reg,
+			    uint32_t v);
 
 typedef uint32_t (*amdgpu_rreg_ext_t)(struct amdgpu_device *, uint64_t);
 typedef void (*amdgpu_wreg_ext_t)(struct amdgpu_device *, uint64_t, uint32_t);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index b69e50b4a66a..534cd336a9b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -298,10 +298,10 @@ static u32 soc15_gc_cac_rreg(struct amdgpu_device *adev, u32 reg)
 	unsigned long flags;
 	u32 r;
 
-	spin_lock_irqsave(&adev->gc_cac_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.gc_cac.lock, flags);
 	WREG32_SOC15(GC, 0, mmGC_CAC_IND_INDEX, (reg));
 	r = RREG32_SOC15(GC, 0, mmGC_CAC_IND_DATA);
-	spin_unlock_irqrestore(&adev->gc_cac_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.gc_cac.lock, flags);
 	return r;
 }
 
@@ -309,10 +309,10 @@ static void soc15_gc_cac_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&adev->gc_cac_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.gc_cac.lock, flags);
 	WREG32_SOC15(GC, 0, mmGC_CAC_IND_INDEX, (reg));
 	WREG32_SOC15(GC, 0, mmGC_CAC_IND_DATA, (v));
-	spin_unlock_irqrestore(&adev->gc_cac_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.gc_cac.lock, flags);
 }
 
 static u32 soc15_se_cac_rreg(struct amdgpu_device *adev, u32 reg)
@@ -973,8 +973,8 @@ static int soc15_common_early_init(struct amdgpu_ip_block *ip_block)
 	adev->reg.uvd_ctx.wreg = &soc15_uvd_ctx_wreg;
 	adev->reg.didt.rreg = &soc15_didt_rreg;
 	adev->reg.didt.wreg = &soc15_didt_wreg;
-	adev->gc_cac_rreg = &soc15_gc_cac_rreg;
-	adev->gc_cac_wreg = &soc15_gc_cac_wreg;
+	adev->reg.gc_cac.rreg = &soc15_gc_cac_rreg;
+	adev->reg.gc_cac.wreg = &soc15_gc_cac_wreg;
 	adev->se_cac_rreg = &soc15_se_cac_rreg;
 	adev->se_cac_wreg = &soc15_se_cac_wreg;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 9a0856a601c0..b8b6e1ea0d52 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -416,10 +416,10 @@ static u32 vi_gc_cac_rreg(struct amdgpu_device *adev, u32 reg)
 	unsigned long flags;
 	u32 r;
 
-	spin_lock_irqsave(&adev->gc_cac_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.gc_cac.lock, flags);
 	WREG32(mmGC_CAC_IND_INDEX, (reg));
 	r = RREG32(mmGC_CAC_IND_DATA);
-	spin_unlock_irqrestore(&adev->gc_cac_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.gc_cac.lock, flags);
 	return r;
 }
 
@@ -427,10 +427,10 @@ static void vi_gc_cac_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&adev->gc_cac_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.gc_cac.lock, flags);
 	WREG32(mmGC_CAC_IND_INDEX, (reg));
 	WREG32(mmGC_CAC_IND_DATA, (v));
-	spin_unlock_irqrestore(&adev->gc_cac_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.gc_cac.lock, flags);
 }
 
 
@@ -1466,8 +1466,8 @@ static int vi_common_early_init(struct amdgpu_ip_block *ip_block)
 	adev->reg.uvd_ctx.wreg = &vi_uvd_ctx_wreg;
 	adev->reg.didt.rreg = &vi_didt_rreg;
 	adev->reg.didt.wreg = &vi_didt_wreg;
-	adev->gc_cac_rreg = &vi_gc_cac_rreg;
-	adev->gc_cac_wreg = &vi_gc_cac_wreg;
+	adev->reg.gc_cac.rreg = &vi_gc_cac_rreg;
+	adev->reg.gc_cac.wreg = &vi_gc_cac_wreg;
 
 	adev->asic_funcs = &vi_asic_funcs;
 
-- 
2.49.0

