Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E5B4C43217
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Feb 2022 10:17:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6FB110F293;
	Mon, 21 Feb 2022 10:17:21 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2048.outbound.protection.outlook.com [40.107.212.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7D7010F279
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Feb 2022 10:17:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ioiLy2xY3Jp8e6WMo+3l38T9rd9VJpiDNDMe3Tt6WEsWcrZB+hcjxTM0NcE4ysovwA2rX61dyriyilLcdF787xp4ubqL1fXhKg8pRmOlJ+EQqPbw/SL+UfBAzkTlDQAYTPLhcJ1Pps9xwv58li1ZYkDVQEwWspXRHxqRpjVVa0DKvMO5BS/wCINUWvavUbGiDaBIGGvKyRlnlOmM8F8fUNPNj+J77JeBF84jxxBGQ0qCt7UtdaJuuj2kzdfswOTaqlNI0a75f8zGS5EZ6zbVYUETX8yW9GlKjCAm2vX0A0AXFrkW7q4i0lqAldrK2jz2xPGX6t6ZmE8fDaNILDf7kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxstEAvevrKUFdJwfEPNKAw7nFgmAHwE3BtcxaVppPE=;
 b=crV331zbKOY96XJ1mAIMqc4DDE09L29TiUPcybx/Vbchiz6Qo0/tD8TiDd6+mAEOCUTlZkrhH1V5l6lmYTmSnaXJGmuNMjeLmgqFy3N59ZZ7952TsnFyS4JJalPlpec3HETVpYGqc877kPJVzbWdWKRJK3nRS2gqdZY8c8C3nRisWha9wkznOJcd4BiVCbDOszornQWHh6G3oyV+gES3seRVRHScNLoyFCXlZnIy3Xa3f2+oM499e3EmDgLiOro0UuRU40UMBesOm77Lndlg5DF27tqUP64QI7XKJaAv6E6GQxUMnNgYfzDg+Rj2sdVfrtVto6FfJd4yv79hr5utlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxstEAvevrKUFdJwfEPNKAw7nFgmAHwE3BtcxaVppPE=;
 b=lTAE2K0brXC7pstQEczpr3b4WmySrYE9PtUS/xP12HHUdJT2/vdtazE9ddZfr3uZx26W6f1UiYY/Qx/N/VIidkUfzjRczCW2GbkVHIZ2CdyrYKmi482cCYuyfv9tWkbs/wNpXN7bJTfgsonAuTltGyD347T1wZOWqhyYXeNmRKQ=
Received: from DM5PR19CA0004.namprd19.prod.outlook.com (2603:10b6:3:151::14)
 by BN8PR12MB3523.namprd12.prod.outlook.com (2603:10b6:408:69::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Mon, 21 Feb
 2022 10:17:18 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:151:cafe::7f) by DM5PR19CA0004.outlook.office365.com
 (2603:10b6:3:151::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12 via Frontend
 Transport; Mon, 21 Feb 2022 10:17:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Mon, 21 Feb 2022 10:17:17 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 21 Feb
 2022 04:17:15 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/12] drm/amdgpu: Remove redundant .ras_fini initialization
 in some ras blocks
Date: Mon, 21 Feb 2022 18:16:20 +0800
Message-ID: <20220221101620.3269611-12-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220221101620.3269611-1-YiPeng.Chai@amd.com>
References: <20220221101620.3269611-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54248f3c-91a3-468b-268f-08d9f52356f0
X-MS-TrafficTypeDiagnostic: BN8PR12MB3523:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3523DB716100ED0337C4CE2CFC3A9@BN8PR12MB3523.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6xhjHoq7jlKc+tjePlSb1xB0EG1G/rAet8F55LaP29tu/L/W7fu2wtlYKenfYvWmQ3G2vy1+KaF1ORgga0WpjCMIUeSvm3VxB655y9TNMChzdzBGHlrg0fLd4EnfU02mP4W8/eoYp4XGPuJ2mJYJfOqTOX+bq/E1XYdyg7u7Zz9tCVaJlbznGM3SK83ivm73UgmYOaqots6d86U08NJFRAeISXBuLRSM5fNSTDfHM7SeJUMbsL2L+HIPjaqVB1/L3RnAdp16Y9Fi9Zbh2y2wrs4yNFoWbUSWv6ogbScbGTS07+x5hvUvwOPFcQRrQehpzYs2OvB2qm92iwm8sftpHIV7A3jb6bOQ8UwSOy9yavg6x6rHvgeeOLIfyEa6x0aV5NIsUu8uv911WypnS0ZUg1mgnC4cupZemiQqCb0hCdrEBSe3cMuzmSgh21iIWTn3xNmL0rtyj8+tHVGGg0wBJGZCSkTCBmmNEkPkLZ/j2zOVSpvdhrP67LJGemZ8/4fh1TGDRfKVYi0bnxswl5w9BgXcQl0b9Fj8zRroO/JsEYDBcqThOTIqccV89/tP3B50WS9kT1p7GxuDi8cJYGQV5/yFpvBtyHx0CBsQVdjs1XmghUQfPiSvjr+3uN4YOFz5U8KC9QzwkR7BCmvPPybaCU+2gth3i20Krc83c3xoBnafboRTd4SBHpqcBEBqorbUMdeyJlAVIFLx1Wuv0p8sYtUgCpHqeOxf0GzCsnPmKtdVfY6Vi4MESAwHEU23SoR4
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36756003)(2906002)(2616005)(82310400004)(1076003)(86362001)(26005)(16526019)(4326008)(70586007)(6666004)(8936002)(426003)(8676002)(186003)(336012)(508600001)(7696005)(81166007)(70206006)(356005)(5660300002)(54906003)(316002)(83380400001)(6916009)(36860700001)(47076005)(40460700003)(43062005)(142923001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 10:17:17.9937 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54248f3c-91a3-468b-268f-08d9f52356f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3523
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1. Define amdgpu_ras_block_late_fini_default in amdgpu_ras.c as
   .ras_fini common function, which is called when
   .ras_fini of ras block isn't initialized.
2. Remove the code of using amdgpu_ras_block_late_fini to
   initialize .ras_fini in ras blocks.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  | 8 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 1 -
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 4 ----
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   | 4 ----
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 8 --------
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c    | 1 -
 drivers/gpu/drm/amd/amdgpu/mca_v3_0.c    | 3 ---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c   | 1 -
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 4 ----
 9 files changed, 8 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 846f51b0c013..17f7c0259115 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2477,6 +2477,12 @@ void amdgpu_ras_block_late_fini(struct amdgpu_device *adev,
 		amdgpu_ras_interrupt_remove_handler(adev, ras_block);
 }
 
+void amdgpu_ras_block_late_fini_default(struct amdgpu_device *adev,
+			  struct ras_common_if *ras_block)
+{
+	return amdgpu_ras_block_late_fini(adev, ras_block);
+}
+
 /* do some init work after IP late init as dependence.
  * and it runs in resume/gpu reset/booting up cases.
  */
@@ -2586,6 +2592,8 @@ int amdgpu_ras_fini(struct amdgpu_device *adev)
 			if (amdgpu_ras_is_supported(adev, obj->ras_comm.block) &&
 				obj->ras_fini)
 				obj->ras_fini(adev, &obj->ras_comm);
+			else
+				amdgpu_ras_block_late_fini_default(adev, &obj->ras_comm);
 		}
 
 		/* Clear ras blocks from ras_list and free ras block list node */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index c04d98e3bd9d..8abdab6869e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -950,6 +950,5 @@ struct amdgpu_xgmi_ras xgmi_ras = {
 		},
 		.hw_ops = &xgmi_ras_hw_ops,
 		.ras_late_init = amdgpu_xgmi_ras_late_init,
-		.ras_fini = amdgpu_ras_block_late_fini,
 	},
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index f0cc073e6bb0..8def7f630d4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2204,10 +2204,6 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)
 		if (!adev->gfx.ras->ras_block.ras_late_init)
 			adev->gfx.ras->ras_block.ras_late_init = amdgpu_gfx_ras_late_init;
 
-		/* If not define special ras_fini function, use gfx default ras_fini */
-		if (!adev->gfx.ras->ras_block.ras_fini)
-			adev->gfx.ras->ras_block.ras_fini = amdgpu_ras_block_late_fini;
-
 		/* If not defined special ras_cb function, use default ras_cb */
 		if (!adev->gfx.ras->ras_block.ras_cb)
 			adev->gfx.ras->ras_block.ras_cb = amdgpu_gfx_process_ras_data_cb;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index c8ad824328d7..d9353bb99314 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -681,10 +681,6 @@ static void gmc_v10_0_set_umc_funcs(struct amdgpu_device *adev)
 		if (!adev->umc.ras->ras_block.ras_late_init)
 				adev->umc.ras->ras_block.ras_late_init = amdgpu_umc_ras_late_init;
 
-		/* If don't define special ras_fini function, use default ras_fini */
-		if (!adev->umc.ras->ras_block.ras_fini)
-			adev->umc.ras->ras_block.ras_fini = amdgpu_ras_block_late_fini;
-
 		/* If not defined special ras_cb function, use default ras_cb */
 		if (!adev->umc.ras->ras_block.ras_cb)
 			adev->umc.ras->ras_block.ras_cb = amdgpu_umc_process_ras_data_cb;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index b01767d78153..4c3483fbe613 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1241,10 +1241,6 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *adev)
 		if (!adev->umc.ras->ras_block.ras_late_init)
 				adev->umc.ras->ras_block.ras_late_init = amdgpu_umc_ras_late_init;
 
-		/* If don't define special ras_fini function, use default ras_fini */
-		if (!adev->umc.ras->ras_block.ras_fini)
-			adev->umc.ras->ras_block.ras_fini = amdgpu_ras_block_late_fini;
-
 		/* If not defined special ras_cb function, use default ras_cb */
 		if (!adev->umc.ras->ras_block.ras_cb)
 			adev->umc.ras->ras_block.ras_cb = amdgpu_umc_process_ras_data_cb;
@@ -1290,10 +1286,6 @@ static void gmc_v9_0_set_mmhub_ras_funcs(struct amdgpu_device *adev)
 		adev->mmhub.ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__MMHUB;
 		adev->mmhub.ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
 		adev->mmhub.ras_if = &adev->mmhub.ras->ras_block.ras_comm;
-
-		/* If don't define special ras_fini function, use default ras_fini */
-		if (!adev->mmhub.ras->ras_block.ras_fini)
-			adev->mmhub.ras->ras_block.ras_fini = amdgpu_ras_block_late_fini;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
index 86c166ae794a..04bc615f3af0 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
@@ -163,7 +163,6 @@ struct amdgpu_hdp_ras hdp_v4_0_ras = {
 			.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE,
 		},
 		.hw_ops = &hdp_v4_0_ras_hw_ops,
-		.ras_fini = amdgpu_ras_block_late_fini,
 	},
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
index 5ce6778a821d..d4bd7d1d2649 100644
--- a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
@@ -66,7 +66,6 @@ struct amdgpu_mca_ras_block mca_v3_0_mp0_ras = {
 		},
 		.hw_ops = &mca_v3_0_mp0_hw_ops,
 		.ras_block_match = mca_v3_0_ras_block_match,
-		.ras_fini = amdgpu_ras_block_late_fini,
 	},
 };
 
@@ -93,7 +92,6 @@ struct amdgpu_mca_ras_block mca_v3_0_mp1_ras = {
 		},
 		.hw_ops = &mca_v3_0_mp1_hw_ops,
 		.ras_block_match = mca_v3_0_ras_block_match,
-		.ras_fini = amdgpu_ras_block_late_fini,
 	},
 };
 
@@ -120,7 +118,6 @@ struct amdgpu_mca_ras_block mca_v3_0_mpio_ras = {
 		},
 		.hw_ops = &mca_v3_0_mpio_hw_ops,
 		.ras_block_match = mca_v3_0_ras_block_match,
-		.ras_fini = amdgpu_ras_block_late_fini,
 	},
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index 485fd9239cd5..b31df4db01fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -671,7 +671,6 @@ struct amdgpu_nbio_ras nbio_v7_4_ras = {
 		},
 		.hw_ops = &nbio_v7_4_ras_hw_ops,
 		.ras_late_init = amdgpu_nbio_ras_late_init,
-		.ras_fini = amdgpu_ras_block_late_fini,
 	},
 	.handle_ras_controller_intr_no_bifring = nbio_v7_4_handle_ras_controller_intr_no_bifring,
 	.handle_ras_err_event_athub_intr_no_bifring = nbio_v7_4_handle_ras_err_event_athub_intr_no_bifring,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 206acb6a5b20..01b385568c14 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2822,10 +2822,6 @@ static void sdma_v4_0_set_ras_funcs(struct amdgpu_device *adev)
 		if (!adev->sdma.ras->ras_block.ras_late_init)
 			adev->sdma.ras->ras_block.ras_late_init = amdgpu_sdma_ras_late_init;
 
-		/* If don't define special ras_fini function, use default ras_fini */
-		if (!adev->sdma.ras->ras_block.ras_fini)
-			adev->sdma.ras->ras_block.ras_fini = amdgpu_ras_block_late_fini;
-
 		/* If not defined special ras_cb function, use default ras_cb */
 		if (!adev->sdma.ras->ras_block.ras_cb)
 			adev->sdma.ras->ras_block.ras_cb = amdgpu_sdma_process_ras_data_cb;
-- 
2.25.1

