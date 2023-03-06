Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B776C61DA4
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Mar 2023 02:33:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75A4D10E048;
	Mon,  6 Mar 2023 02:33:17 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C693810E048
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Mar 2023 02:33:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJIHpDQlRk6SwF2SA14o0577tKepihKkbC/uVAr4KwY+QDmBVz6Muc6+DJzjOOl31Vo/Fj0MAXMxWl30cRkFk15XUmnlsPkaGCW1Dm96awfh0NDxh2U5Gqs32gsy6yMCJtK78aJNLDVxaWtGJkBwymdErygcmfRu74RQe+B2Cq0Qzzw07ZhPzH6L/Yv225oygDQePAYhkVfVTCGsAhOZSZzjrDL6zv+rQkP76HxPaRJd49tB5qspjmGD5dzbuH6gGg9yC7mUuRW1psHhheQI6MzkSmD9ThdSOtFRhBqXGfQh4XJAMT6EzYuMLYq1GhQSk5GUn0cNs7q3pG80HuAkIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xOQbiSoZLoaCBudDRFuYm2K2Ha9rdQJ+jHqaqVYH880=;
 b=IZ4ojIMaCyu91fTC13vUogxqih9epKkAgzHFKXRHE1rmbZe2fkqkREZwEy+StK3TjAlElzg2RjjmmPJ7ygRNTr148oe/tD4bp5219xjg/uSgPhsQgVpT0X3dGXI3O5lvN1g6CnTIrJQzlY1SoPIRxoWzARjkKnjN5TanBPDSsV8OpdFgkdgEYt93s6K42W6GWRcAd8WKhVEOp9hEFLIUdSyrp2gB1jS3pSkn5pKTg0vxxgGxVjTSgjtd6yV94Dc3LUhlNT6Z8EsG04LSKj2/7LgMSysQiNkRPkBYCisyyEn9T+D+HQyzc2pvBfjgGv4HnefPzBnMW30Z7COg71yOig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xOQbiSoZLoaCBudDRFuYm2K2Ha9rdQJ+jHqaqVYH880=;
 b=jGz1J5utWi/If9EQk4VRJGGNpPL4KPXgLWcxhg0J0J1szDgZRQmmGVw76dYMTknp5dvIdQwHXh4PpTd6hMIDUCCRYijHlYET/Unc834dLExkxNcUUnKoQ698OXQgLw8KZs9AMiqBkZsAyhKikl2EP+bp3EFIdF5XhCY/Gie8slw=
Received: from BN8PR12CA0001.namprd12.prod.outlook.com (2603:10b6:408:60::14)
 by BY5PR12MB4997.namprd12.prod.outlook.com (2603:10b6:a03:1d6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 02:33:08 +0000
Received: from BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::7f) by BN8PR12CA0001.outlook.office365.com
 (2603:10b6:408:60::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27 via Frontend
 Transport; Mon, 6 Mar 2023 02:33:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT088.mail.protection.outlook.com (10.13.177.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.15 via Frontend Transport; Mon, 6 Mar 2023 02:33:07 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 5 Mar 2023 20:33:05 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Candice Li <Candice.Li@amd.com>, Thomas Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH 07/11] drm/amdgpu: Move hdp ras block init to ras sw_init
Date: Mon, 6 Mar 2023 10:31:56 +0800
Message-ID: <20230306023200.29158-8-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230306023200.29158-1-Hawking.Zhang@amd.com>
References: <20230306023200.29158-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT088:EE_|BY5PR12MB4997:EE_
X-MS-Office365-Filtering-Correlation-Id: b3606250-ac84-4c0b-eba9-08db1deb1ee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: clN81JJTsKYCZvCZHauYlfaY+8OSgSJBkn0kbNzS6PEcj6heif5u87vQIAB2exxtA8P5ZZj+3WZwohN+BNMGvYrsbq7vQVNo0tLUi9KW15T7gs3+ZoOIPPwhtvl3quLLbwJ5xQBwadNfSTOwImltOUporaw+54HQaHBD9w6BYhWIVJcl/aRTfeFur8FZKvS+fUp1bdJji0miRrWdrZjw3NT4ltzRBW30x1G70yUbhrLnp6Is8mGeo7tAGIueFyJHLyQq5iEH1JeKGAzVbqb2Z/CRHFfeJZqG/lmdcoXHebEiH2lS7Fa4F664O4k2zUYOLbqO5ZW0qCHQEx8x7VqKexmVRw4AZrbs+XzLHd5cUXHgLOl0mvv+h5UZYVF3CnFqN5j0F16zLKZXwwAJ+N8xQVXhFxvr0GgVZcU+jLN8d+iiyFqvaLZWlFGn9QrFL4JnP5LQ0kiwZoEfMoldfrkDDokisQxXJR7c2dbgMnYaqfbDr4ga31M22HVJDx3Hb1MdGiXhjYwNlaoseGxbaN7cSHDUv4u7aA1luVH6BlhOcsPAvBB4F0GAKK1dvBRmWtZpRWsSkzSe3w9VRxyeoCgf8o3Y7Ubu+fTEO7gZiTHE2Uuz28K28vyi9hE9UXzcbgOpwrld8JYOkkYWoZkwGqf1Gm/N3AC8MFec5QdJzXDTMnhBB3rOJCW6LuF1talpI6I/yiAShdg2yE32Mu4S0EoLlJdh+WEMdCk8cvdr/w0VDk8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(396003)(136003)(39850400004)(346002)(451199018)(46966006)(36840700001)(40470700004)(36860700001)(86362001)(81166007)(82740400003)(356005)(36756003)(2906002)(5660300002)(4326008)(70586007)(70206006)(40480700001)(8676002)(8936002)(41300700001)(82310400005)(40460700003)(2616005)(336012)(26005)(186003)(16526019)(83380400001)(47076005)(426003)(110136005)(6636002)(478600001)(316002)(1076003)(6666004)(7696005)(66899018)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 02:33:07.5689 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3606250-ac84-4c0b-eba9-08db1deb1ee8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4997
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Initialize hdp ras block only when mmhub ip block
supports ras features. Driver queries ras capabilities
after early_init, ras block init needs to be moved to
sw_init.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c |  9 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c | 48 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  2 --
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c   |  5 ---
 6 files changed, 59 insertions(+), 9 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 00c33ce38761..5f9ac1bcb6bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -54,7 +54,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
 	amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o amdgpu_sync.o \
 	amdgpu_gtt_mgr.o amdgpu_preempt_mgr.o amdgpu_vram_mgr.o amdgpu_virt.o \
 	amdgpu_atomfirmware.o amdgpu_vf_error.o amdgpu_sched.o \
-	amdgpu_debugfs.o amdgpu_ids.o amdgpu_gmc.o amdgpu_mmhub.o \
+	amdgpu_debugfs.o amdgpu_ids.o amdgpu_gmc.o amdgpu_mmhub.o amdgpu_hdp.o \
 	amdgpu_xgmi.o amdgpu_csa.o amdgpu_ras.o amdgpu_vm_cpu.o \
 	amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o amdgpu_nbio.o \
 	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index e90c59693c31..087a75374610 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -468,6 +468,15 @@ int amdgpu_gmc_ras_sw_init(struct amdgpu_device *adev)
 		}
 	}
 
+	/* hdp ras block */
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__HDP)) {
+		r = amdgpu_hdp_ras_sw_init(adev);
+		if (r) {
+			dev_err(adev->dev, "Failed to initialize hdp ras block!\n");
+			return r;
+		}
+	}
+
 	/* xgmi ras block */
 	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__XGMI_WAFL)) {
 		adev->gmc.xgmi.ras = &xgmi_ras;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
new file mode 100644
index 000000000000..b6cf801939aa
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
@@ -0,0 +1,48 @@
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+#include "amdgpu.h"
+#include "amdgpu_ras.h"
+
+int amdgpu_hdp_ras_sw_init(struct amdgpu_device *adev)
+{
+	int err;
+	struct amdgpu_hdp_ras *ras;
+
+	if (!adev->hdp.ras)
+		return 0;
+
+	ras = adev->hdp.ras;
+	err = amdgpu_ras_register_ras_block(adev, &ras->ras_block);
+	if (err) {
+		dev_err(adev->dev, "Failed to register hdp ras block!\n");
+		return err;
+	}
+
+	strcpy(ras->ras_block.ras_comm.name, "hdp");
+	ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__HDP;
+	ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
+	adev->hdp.ras_if = &ras->ras_block.ras_comm;
+
+	/* hdp ras follows amdgpu_ras_block_late_init_default for late init */
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
index ac5c61d3de2b..7b8a6152dc8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
@@ -43,5 +43,5 @@ struct amdgpu_hdp {
 	struct amdgpu_hdp_ras	*ras;
 };
 
-int amdgpu_hdp_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block);
+int amdgpu_hdp_ras_sw_init(struct amdgpu_device *adev);
 #endif /* __AMDGPU_HDP_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index b3bb70210122..9a333f9744bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1361,8 +1361,6 @@ static void gmc_v9_0_set_gfxhub_funcs(struct amdgpu_device *adev)
 static void gmc_v9_0_set_hdp_ras_funcs(struct amdgpu_device *adev)
 {
 	adev->hdp.ras = &hdp_v4_0_ras;
-	amdgpu_ras_register_ras_block(adev, &adev->hdp.ras->ras_block);
-	adev->hdp.ras_if = &adev->hdp.ras->ras_block.ras_comm;
 }
 
 static void gmc_v9_0_set_mca_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
index ee09cf1b8e4f..71d1a2e3bac9 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
@@ -161,11 +161,6 @@ struct amdgpu_ras_block_hw_ops hdp_v4_0_ras_hw_ops = {
 
 struct amdgpu_hdp_ras hdp_v4_0_ras = {
 	.ras_block = {
-		.ras_comm = {
-			.name = "hdp",
-			.block = AMDGPU_RAS_BLOCK__HDP,
-			.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE,
-		},
 		.hw_ops = &hdp_v4_0_ras_hw_ops,
 	},
 };
-- 
2.17.1

