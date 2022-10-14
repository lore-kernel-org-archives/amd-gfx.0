Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B4CC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Oct 2022 06:19:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A16310EA7E;
	Fri, 14 Oct 2022 06:19:28 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2061.outbound.protection.outlook.com [40.107.95.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2068010EA7E
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Oct 2022 06:19:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YP0/9m+7Axah1jg3N/C+yA/UOHkEbS5VGZBjkIC6DY5kRTNF543Pp73QtKdLrwYes6MhD2c5FxT2wO5Pq7669njvjwlXNR+Syj2OVmO7r20dPr84TsTxQD4rNVldTY3DG6XuG9YLMyj/gHC2D7CH7Q+JJXx2F6yUV49cn5KaQrKyMVeSCisv5EjOlNeTZxHYUZl0cvulX+kC1KWvW5i1Xy4NtD55ttLMerT1diq/L3EIV638La/Ds8DHh6uK+4OZwfDMnXNPPUzecE3PIWgeoTOiyHEURyt0qgLaAvMKKXt78dvHdqk2/0UBFHPng2TKknPpHQPopbpSepmPc8EYLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HRywFaQclolaxWEFqolTe+MsHM3eesrxbA9bkWb3nnw=;
 b=PFVd7rr730LKZLV8XIHVOeo8MMmsNlAoHPsSEW7tZbefQyQNTxQSLl5ieTIVDwOCIuG6t6fIrkURxd/v9LejtkdayneAzhU7MfViU+L2Rk6buo/UdzmoYCBC/b0E8lqO5fbGS4eYH5PHeK0fdT6DGQnU7shOC0aqVN4JASLE+4Yw3X5lD9rTJEGHh/bOzdN7J/KShdOchUUGG6op5QynPBQqJUCTvptWjUXwS79Q8otdifqxPvQKHVDE5q785bzDS52Ko7VYoRjF5a6GqSRfPd59xepaefhRSWLlmZjjE33VphJYripqfzNFTDnK6oUN6I7gRiIddYuASz+U/CwFWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRywFaQclolaxWEFqolTe+MsHM3eesrxbA9bkWb3nnw=;
 b=0UFm6jFfKt0Cxe9hoVWgpw7cw46FwF88m+lVvJIHr526WriO6fIaIjIZX2U7cZJzGuf34EZ+e2nXSCz8Wl5WGGN1WY2d7WpRomaib9eP7gxPl/wolquNngsxWJhAgyY4wvBh41hzrgnTaLGhzqk1Mchwk/lXsbBmgCyLE5Bt4BQ=
Received: from DM5PR07CA0078.namprd07.prod.outlook.com (2603:10b6:4:ad::43) by
 DS7PR12MB6007.namprd12.prod.outlook.com (2603:10b6:8:7e::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.15; Fri, 14 Oct 2022 06:19:22 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::46) by DM5PR07CA0078.outlook.office365.com
 (2603:10b6:4:ad::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26 via Frontend
 Transport; Fri, 14 Oct 2022 06:19:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Fri, 14 Oct 2022 06:19:22 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 14 Oct
 2022 01:19:22 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 14 Oct
 2022 01:19:22 -0500
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 14 Oct 2022 01:19:20
 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>
Subject: [PATCH] drm/amdgpu: move convert_error_address out of umc_ras
Date: Fri, 14 Oct 2022 14:19:18 +0800
Message-ID: <20221014061918.21494-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT020:EE_|DS7PR12MB6007:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f759ae3-2ee0-46ef-6d21-08daadac090e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sh0RwlWx6V+VP4c1UPBi36qIwSwxPxK27dfMrqzBbRZEmJ67MaXP2JtiRDM6rxiKhbwbVXCVx/jgBRaGEHVFraLgW2Y5bBYys0gF0VZyJFhoGwIc7o9d43UeJyvCe79UKwUM5cJSLFyZ9y2+7L0GlrD6Gucsb1vmzhrFNSU7NzC3swvIZbBlZK1vN0+kzXthWqVdn6SA7FSEta8JrIsqyGRgi2ANokQPuSTxwXarWWe3BIkK+P5jOUoWAWCscSGtY0KMGYnPJoFb29kkS1spOw1aNh0UFLJ5T8HCBlXEwXgUaxXAN8LU49u+IN3+RK9xfq/cl/CGsTjTOafpSYlxXJOrdcinPcD9/DnTZ38nCugPJpLONAHRSt/CUT0ptvH2I/HKEU62TBkBpQbT7EJ7yUk2FscJmRy8zdIBzsCDA+ip89II3GvzaG1gvZnARa06AIjfBdKqm2fFhajFHlMwhmnY1G5oXYDym+9pVvyA+LTVjvBqjD44aiTLuJiNDGmkP8Hd737PKigJWuSigSrVqtXswlqYrNNy511Z9FyN6AjGJSMk6vjHJuIX4aziWheP4pA0ZVcPBfkqf3RsX3RRe6PnWLiSx+pNmLUVwNRFSVsAoZbzWVR6t1bG3hfi2cMxY1Q1y967lUTbyPdD6Ls2++5hoEXN+3zPTlPgYKXaxsCCsIn40oEbcKB5Hks0caPWJ7upNNNtBgViBa7yZp/jJDg07PpMi7vNF5s+taojT2yMPd2OXwpZWLSIkp+eD/QS5U0miMojKKcyaPLby7LXQ6/WKwzyANgLUyyGhgSU+jBHwuSk4qPyHigguaTezP1G
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199015)(40470700004)(46966006)(36840700001)(26005)(83380400001)(54906003)(110136005)(6636002)(81166007)(82740400003)(356005)(186003)(2906002)(36860700001)(86362001)(36756003)(40480700001)(5660300002)(82310400005)(47076005)(426003)(40460700003)(8676002)(316002)(8936002)(7696005)(70206006)(1076003)(41300700001)(336012)(4326008)(478600001)(70586007)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 06:19:22.3642 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f759ae3-2ee0-46ef-6d21-08daadac090e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6007
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
Cc: Kent Russell <Kent.Russell@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RAS error address translation algorithm is common
across dGPU and A + A platform as along as the SOC
integrates the same generation of UMC IP.

UMC RAS is managed by x86 MCA on A + A platform,
umc_ras in GPU driver is not initialized at all on
A + A platform. In such case, any umc_ras callback
implemented for dGPU config shouldn't be invoked
from A + A specific callback.

The change moves convert_error_address out of dGPU
umc_ras structure and makes it share between A + A
and dGPU config.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 15 +++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |  3 ---
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c   |  7 +++----
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.h   |  4 +++-
 4 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 75f1402101f4..ff92ea99d513 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -36,6 +36,7 @@
 #include "ivsrcid/nbio/irqsrcs_nbif_7_4.h"
 #include "atom.h"
 #include "amdgpu_reset.h"
+#include "umc_v6_7.h"
 
 #ifdef CONFIG_X86_MCE_AMD
 #include <asm/mce.h>
@@ -2885,10 +2886,16 @@ static int amdgpu_bad_page_notifier(struct notifier_block *nb,
 	/*
 	 * Translate UMC channel address to Physical address
 	 */
-	if (adev->umc.ras &&
-	    adev->umc.ras->convert_ras_error_address)
-		adev->umc.ras->convert_ras_error_address(adev,
-			&err_data, m->addr, ch_inst, umc_inst);
+	switch (adev->ip_versions[UMC_HWIP][0]) {
+	case IP_VERSION(6, 7, 0):
+		umc_v6_7_convert_error_address(adev,
+				&err_data, m->addr, ch_inst, umc_inst);
+		break;
+	default:
+		dev_warn(adev->dev,
+			 "UMC address to Physical address translation is not supported\n");
+		return NOTIFY_DONE;
+	}
 
 	if (amdgpu_bad_page_threshold != 0) {
 		amdgpu_ras_add_bad_pages(adev, err_data.err_addr,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index e46439274f3a..3629d8f292ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -51,9 +51,6 @@ struct amdgpu_umc_ras {
 	struct amdgpu_ras_block_object ras_block;
 	void (*err_cnt_init)(struct amdgpu_device *adev);
 	bool (*query_ras_poison_mode)(struct amdgpu_device *adev);
-	void (*convert_ras_error_address)(struct amdgpu_device *adev,
-				struct ras_err_data *err_data, uint64_t err_addr,
-				uint32_t ch_inst, uint32_t umc_inst);
 	void (*ecc_info_query_ras_error_count)(struct amdgpu_device *adev,
 				      void *ras_error_status);
 	void (*ecc_info_query_ras_error_address)(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
index 5d5d031c9e7d..72fd963f178b 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -187,9 +187,9 @@ static void umc_v6_7_ecc_info_query_ras_error_count(struct amdgpu_device *adev,
 	}
 }
 
-static void umc_v6_7_convert_error_address(struct amdgpu_device *adev,
-					struct ras_err_data *err_data, uint64_t err_addr,
-					uint32_t ch_inst, uint32_t umc_inst)
+void umc_v6_7_convert_error_address(struct amdgpu_device *adev,
+				    struct ras_err_data *err_data, uint64_t err_addr,
+				    uint32_t ch_inst, uint32_t umc_inst)
 {
 	uint32_t channel_index;
 	uint64_t soc_pa, retired_page, column;
@@ -553,5 +553,4 @@ struct amdgpu_umc_ras umc_v6_7_ras = {
 	.query_ras_poison_mode = umc_v6_7_query_ras_poison_mode,
 	.ecc_info_query_ras_error_count = umc_v6_7_ecc_info_query_ras_error_count,
 	.ecc_info_query_ras_error_address = umc_v6_7_ecc_info_query_ras_error_address,
-	.convert_ras_error_address = umc_v6_7_convert_error_address,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
index fe41ed2f5945..105245d5b6e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
@@ -71,5 +71,7 @@ extern const uint32_t
 	umc_v6_7_channel_idx_tbl_second[UMC_V6_7_UMC_INSTANCE_NUM][UMC_V6_7_CHANNEL_INSTANCE_NUM];
 extern const uint32_t
 	umc_v6_7_channel_idx_tbl_first[UMC_V6_7_UMC_INSTANCE_NUM][UMC_V6_7_CHANNEL_INSTANCE_NUM];
-
+void umc_v6_7_convert_error_address(struct amdgpu_device *adev,
+                                    struct ras_err_data *err_data, uint64_t err_addr,
+                                    uint32_t ch_inst, uint32_t umc_inst);
 #endif
-- 
2.17.1

