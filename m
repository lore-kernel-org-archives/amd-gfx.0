Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F78C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Feb 2022 10:17:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A8CE10F1C4;
	Mon, 21 Feb 2022 10:17:01 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1525410F1C4
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Feb 2022 10:17:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NjJcX3tujWvajFY8QiCru1X7eihvTHXvuW4T7RgxcQBeZmWQZLAjvydTrHM9d3Hipl9Gx1CEAXPEN9yWT5mqktMd1Hf/dbjcCgyEzQFI8/fmZB2SO6WDOQKJZVeGd6j6VsVeWWfgK2i2/iZzMQHxF10XTLEbdr7tEDbIRwrl2ReEJ+ouSKEvlW/u4YLbZRMNgOX3lNucXxNcVaPXPM6EQhoe7bvA73mvUQWPFOW67XJX1n4rU9fuNa7gGD0tnkOzABPloX08gfNOFYwXtCb8u894Ga0X9IS2pWZXiatxNDTq9iQ5C+5N+YPP0+ZDcnGzutUgSSeyamx+ir8y6k+Czg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxGCEO+TRjse5aYHXYKw4Wi0QpGwx+lz2TWzAIVPU78=;
 b=HPByPvS5hFtrA858O6zHaYXaDWw000O3W4ixvRBAyebLObgxjG+NWm9J76YKHM4cqzMUWUUS3rZIi+8FyalKkGl3gKM/O3c8lnlC2WN0euq1+v89on4SgWoFiXLynakA0j3Sk0gGBHwr/qcrMRk8UGHKXOhHwts9upkKp58H2FLIZP0eRnWXwOoKcAVi580w/9x/FlGp7ieLu/LcTEIjsIadrknknJZqyuSLBRG9DH8gx4+1HMDLsa/Spjc/wyf3X4x77aLvMTZY/9L8V4bSGxhtIpUGUnaytsI/XkZbC8L7kKHeiHI5l2JmvqxHtYYH5m5szbKaDg7vzjSjHh5Xvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxGCEO+TRjse5aYHXYKw4Wi0QpGwx+lz2TWzAIVPU78=;
 b=HsP461iInWGXxIodq3OeXGdz7bnfLF7qD+/HxpdCwkuZfYf4S9WvJdHQ5ViNLbnTRGvzw43jddX4P98G+5cVTrIrs2DI+dZjgQysL0vPno3ziWX5Xaliy3vmcrhWYEiCRyt3lEi5iyist5W0udt05K74q2wV4xowNteCSTxu9wI=
Received: from DS7PR03CA0285.namprd03.prod.outlook.com (2603:10b6:5:3ad::20)
 by BYAPR12MB3158.namprd12.prod.outlook.com (2603:10b6:a03:13a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Mon, 21 Feb
 2022 10:16:56 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::56) by DS7PR03CA0285.outlook.office365.com
 (2603:10b6:5:3ad::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15 via Frontend
 Transport; Mon, 21 Feb 2022 10:16:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Mon, 21 Feb 2022 10:16:56 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 21 Feb
 2022 04:16:53 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/12] drm/amdgpu: Modify .ras_fini function pointer parameter
Date: Mon, 21 Feb 2022 18:16:09 +0800
Message-ID: <20220221101620.3269611-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6053177b-125a-4515-75d9-08d9f52349e3
X-MS-TrafficTypeDiagnostic: BYAPR12MB3158:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB31589E35CC2B9BBC20B70865FC3A9@BYAPR12MB3158.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qpPCdU8qY4bN4d1Fxi0vnGWmdDoDnDCJgH3UWYAm2u4TtjHGgCgzmNwehY9gIkwEeDme0Hc1nzboaMs6AVGwX/cBo1DGtiUNz6BOWHcwL0L8htkJtt7oVPoGDAhhCj3CzfGHDyMJ+QeKkLWf+X76GqJgMrQFFP87J0feLGsl8Sf2mLG2Kd1/fdG67ZduSRW7RSLc0xrpgmOa8IUjpY55Z/zCT7xs8tIXig2TBN0hl/gzJrchKPqhvtkFGCK2vMU2yJqA0yw0ljsL/zpyONzwXEMip4c3qHAbJoZ29ezYiVT6dB+n2cB1oM7fCSsxv0s9sB0U9T7KPi3CTckn2+d4OunfQ3lezep3udqDxzKuJWXSJIiWiFmJII4i/cP0C8RxKuspF3yKsRv8HFWYPRaqVGxLs5sMgMYjarVPvj9JJWoS0sMA9UZFenpxLMHlHY4Vbk0fAD34sYEJaoBU5iTKPzupdb2oa1aTCWJAK9FXnESOVFFXVVC97dLRfhjOJBmPUfQtr4NoZrDZ5tJvR5qvDSjmAf2dW/FfRwC27Qcex+O1TV7zxVUPEXnjc3/T7V6IcO+sMV0xOm2M9S5LG0B4+beTWVVHcaWpZUSIO544mNVVIQy9R91T/a2RV6qUkoOW0TpGW4RpNo2I92KQiGFlNSbDaM8L0JLhDbWbn6nHPNPQMz/lukIX4NmUFbSDFB6rKD2Xv8GLSs6mD19kir2YQYEc9EJx+PV8Jv7SF3SUaw48fduNd9xoLXZoJUsO79/IWafJIPN1Ja7OzYuSjJEvsQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(186003)(7696005)(16526019)(70206006)(70586007)(26005)(8676002)(54906003)(6916009)(2616005)(1076003)(316002)(86362001)(508600001)(82310400004)(36860700001)(6666004)(356005)(81166007)(30864003)(83380400001)(426003)(4326008)(47076005)(336012)(5660300002)(8936002)(2906002)(40460700003)(36756003)(43062005)(142923001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 10:16:56.0846 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6053177b-125a-4515-75d9-08d9f52349e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3158
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

Modify .ras_fini function pointer parameter so that
it can remove redundant intermediate calls in some
ras blocks.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h   | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c   | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h   | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h  | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h   | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h  | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h   | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c     | 2 +-
 drivers/gpu/drm/amd/amdgpu/mca_v3_0.c     | 6 +++---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c    | 2 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c        | 2 +-
 19 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 52912b6bcb20..d020c4599433 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -644,7 +644,7 @@ int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *r
 	return r;
 }
 
-void amdgpu_gfx_ras_fini(struct amdgpu_device *adev)
+void amdgpu_gfx_ras_fini(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
 	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX) &&
 			adev->gfx.ras_if)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index ccca0a85b982..f7c50ab4589c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -387,7 +387,7 @@ bool amdgpu_gfx_is_me_queue_enabled(struct amdgpu_device *adev, int me,
 void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable);
 int amdgpu_get_gfx_off_status(struct amdgpu_device *adev, uint32_t *value);
 int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block);
-void amdgpu_gfx_ras_fini(struct amdgpu_device *adev);
+void amdgpu_gfx_ras_fini(struct amdgpu_device *adev, struct ras_common_if *ras_block);
 int amdgpu_gfx_process_ras_data_cb(struct amdgpu_device *adev,
 		void *err_data,
 		struct amdgpu_iv_entry *entry);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 26e31c53ed0d..5dcb341cae19 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -455,16 +455,16 @@ int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
 void amdgpu_gmc_ras_fini(struct amdgpu_device *adev)
 {
 	if (adev->umc.ras && adev->umc.ras->ras_block.ras_fini)
-		adev->umc.ras->ras_block.ras_fini(adev);
+		adev->umc.ras->ras_block.ras_fini(adev, NULL);
 
 	if (adev->mmhub.ras && adev->mmhub.ras->ras_block.ras_fini)
-		adev->mmhub.ras->ras_block.ras_fini(adev);
+		adev->mmhub.ras->ras_block.ras_fini(adev, NULL);
 
 	if (adev->gmc.xgmi.ras && adev->gmc.xgmi.ras->ras_block.ras_fini)
-		adev->gmc.xgmi.ras->ras_block.ras_fini(adev);
+		adev->gmc.xgmi.ras->ras_block.ras_fini(adev, NULL);
 
 	if (adev->hdp.ras && adev->hdp.ras->ras_block.ras_fini)
-		adev->hdp.ras->ras_block.ras_fini(adev);
+		adev->hdp.ras->ras_block.ras_fini(adev, NULL);
 }
 
 	/*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
index b7fbc114a175..0f224e21cd55 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
@@ -24,7 +24,7 @@
 #include "amdgpu.h"
 #include "amdgpu_ras.h"
 
-void amdgpu_hdp_ras_fini(struct amdgpu_device *adev)
+void amdgpu_hdp_ras_fini(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
 	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__HDP) &&
 	    adev->hdp.ras_if)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
index aabd59aa5213..c05cd992ef8a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
@@ -44,5 +44,5 @@ struct amdgpu_hdp {
 };
 
 int amdgpu_hdp_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block);
-void amdgpu_hdp_ras_fini(struct amdgpu_device *adev);
+void amdgpu_hdp_ras_fini(struct amdgpu_device *adev, struct ras_common_if *ras_block);
 #endif /* __AMDGPU_HDP_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
index 42413813765a..6dfcedcc37fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
@@ -24,7 +24,7 @@
 #include "amdgpu.h"
 #include "amdgpu_ras.h"
 
-void amdgpu_mmhub_ras_fini(struct amdgpu_device *adev)
+void amdgpu_mmhub_ras_fini(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
 	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__MMHUB) &&
 			adev->mmhub.ras_if)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
index 240b26d9a388..253f047379cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
@@ -47,6 +47,6 @@ struct amdgpu_mmhub {
 	struct amdgpu_mmhub_ras  *ras;
 };
 
-void amdgpu_mmhub_ras_fini(struct amdgpu_device *adev);
+void amdgpu_mmhub_ras_fini(struct amdgpu_device *adev, struct ras_common_if *ras_block);
 #endif
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
index f09ad80f0772..0de2fdf31eed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
@@ -44,7 +44,7 @@ int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *
 	return r;
 }
 
-void amdgpu_nbio_ras_fini(struct amdgpu_device *adev)
+void amdgpu_nbio_ras_fini(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
 	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__PCIE_BIF) &&
 			adev->nbio.ras_if)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
index f9546c7341b8..3222e1cae134 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
@@ -105,5 +105,5 @@ struct amdgpu_nbio {
 };
 
 int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block);
-void amdgpu_nbio_ras_fini(struct amdgpu_device *adev);
+void amdgpu_nbio_ras_fini(struct amdgpu_device *adev, struct ras_common_if *ras_block);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 143a83043d7c..7cddaad90d6d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -491,7 +491,7 @@ struct amdgpu_ras_block_object {
 	int (*ras_block_match)(struct amdgpu_ras_block_object *block_obj,
 				enum amdgpu_ras_block block, uint32_t sub_block_index);
 	int (*ras_late_init)(struct amdgpu_device *adev, struct ras_common_if *ras_block);
-	void (*ras_fini)(struct amdgpu_device *adev);
+	void (*ras_fini)(struct amdgpu_device *adev, struct ras_common_if *ras_block);
 	ras_ih_cb ras_cb;
 	const struct amdgpu_ras_block_hw_ops *hw_ops;
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 3b5c43575aa3..863035a94bd8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -111,7 +111,7 @@ int amdgpu_sdma_ras_late_init(struct amdgpu_device *adev,
 	return r;
 }
 
-void amdgpu_sdma_ras_fini(struct amdgpu_device *adev)
+void amdgpu_sdma_ras_fini(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
 	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA) &&
 			adev->sdma.ras_if)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 8b226ffee32c..34ec60dfe5e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -118,7 +118,7 @@ int amdgpu_sdma_get_index_from_ring(struct amdgpu_ring *ring, uint32_t *index);
 uint64_t amdgpu_sdma_get_csa_mc_addr(struct amdgpu_ring *ring, unsigned vmid);
 int amdgpu_sdma_ras_late_init(struct amdgpu_device *adev,
 			      struct ras_common_if *ras_block);
-void amdgpu_sdma_ras_fini(struct amdgpu_device *adev);
+void amdgpu_sdma_ras_fini(struct amdgpu_device *adev, struct ras_common_if *ras_block);
 int amdgpu_sdma_process_ras_data_cb(struct amdgpu_device *adev,
 		void *err_data,
 		struct amdgpu_iv_entry *entry);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 9400260e3263..41e976733c57 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -162,7 +162,7 @@ int amdgpu_umc_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *r
 	return r;
 }
 
-void amdgpu_umc_ras_fini(struct amdgpu_device *adev)
+void amdgpu_umc_ras_fini(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
 	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC) &&
 			adev->umc.ras_if)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index e4b3678a6685..c8deba8dacb5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -73,7 +73,7 @@ struct amdgpu_umc {
 };
 
 int amdgpu_umc_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block);
-void amdgpu_umc_ras_fini(struct amdgpu_device *adev);
+void amdgpu_umc_ras_fini(struct amdgpu_device *adev, struct ras_common_if *ras_block);
 int amdgpu_umc_poison_handler(struct amdgpu_device *adev,
 		void *ras_error_status,
 		bool reset);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 77b65434ccc2..27421811f2f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -743,7 +743,7 @@ static int amdgpu_xgmi_ras_late_init(struct amdgpu_device *adev, struct ras_comm
 	return amdgpu_ras_block_late_init(adev, ras_block);
 }
 
-static void amdgpu_xgmi_ras_fini(struct amdgpu_device *adev)
+static void amdgpu_xgmi_ras_fini(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
 	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__XGMI_WAFL) &&
 			adev->gmc.xgmi.ras_if)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 1997f129db9c..3ecb238c6483 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2433,7 +2433,7 @@ static int gfx_v9_0_sw_fini(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	if (adev->gfx.ras && adev->gfx.ras->ras_block.ras_fini)
-		adev->gfx.ras->ras_block.ras_fini(adev);
+		adev->gfx.ras->ras_block.ras_fini(adev, NULL);
 
 	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
 		amdgpu_ring_fini(&adev->gfx.gfx_ring[i]);
diff --git a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
index b4b36899f5c6..02c50be19d3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
@@ -37,7 +37,7 @@ static void mca_v3_0_mp0_query_ras_error_count(struct amdgpu_device *adev,
 				         ras_error_status);
 }
 
-static void mca_v3_0_mp0_ras_fini(struct amdgpu_device *adev)
+static void mca_v3_0_mp0_ras_fini(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
 	amdgpu_mca_ras_fini(adev, &adev->mca.mp0);
 }
@@ -83,7 +83,7 @@ static void mca_v3_0_mp1_query_ras_error_count(struct amdgpu_device *adev,
 				         ras_error_status);
 }
 
-static void mca_v3_0_mp1_ras_fini(struct amdgpu_device *adev)
+static void mca_v3_0_mp1_ras_fini(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
 	amdgpu_mca_ras_fini(adev, &adev->mca.mp1);
 }
@@ -115,7 +115,7 @@ static void mca_v3_0_mpio_query_ras_error_count(struct amdgpu_device *adev,
 				         ras_error_status);
 }
 
-static void mca_v3_0_mpio_ras_fini(struct amdgpu_device *adev)
+static void mca_v3_0_mpio_ras_fini(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
 	amdgpu_mca_ras_fini(adev, &adev->mca.mpio);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index e26c39fcd336..d0a9012e53d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1997,7 +1997,7 @@ static int sdma_v4_0_sw_fini(void *handle)
 
 	if (adev->sdma.ras && adev->sdma.ras->ras_block.hw_ops &&
 		adev->sdma.ras->ras_block.ras_fini)
-		adev->sdma.ras->ras_block.ras_fini(adev);
+		adev->sdma.ras->ras_block.ras_fini(adev, NULL);
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		amdgpu_ring_fini(&adev->sdma.instance[i].ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index b7c24149a6bd..34cd5cad7da5 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1215,7 +1215,7 @@ static int soc15_common_sw_fini(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	if (adev->nbio.ras && adev->nbio.ras->ras_block.ras_fini)
-		adev->nbio.ras->ras_block.ras_fini(adev);
+		adev->nbio.ras->ras_block.ras_fini(adev, NULL);
 
 	if (adev->df.funcs &&
 	    adev->df.funcs->sw_fini)
-- 
2.25.1

