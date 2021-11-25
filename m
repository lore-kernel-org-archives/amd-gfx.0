Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A7D0C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Nov 2021 10:58:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A44796E84F;
	Thu, 25 Nov 2021 10:58:48 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 806296E84F
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Nov 2021 10:58:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHdTQ1piPEv3HE9al2+bWP5k/J+yqRv+EbJeFZ9+wKwYMRYMhZT5IgM9BbjrTrwPIgaAFWVqiZYV+cOVP5cM/FKGU7KW88COMmNZFYOpjCDXS5/i/x5ZSAXhoHCCT4xf4daVTdplTQaoA5DSqydzFjde7pi8t3QjRHgkvvc1US3eY6/Gc/v77L45Y3Zs0NlAsym3aaVh0T9IbYALE1GmNxGvca/vzboKMNOvYDCQeoXhu5KzWe+mmGhP0iOkXyFTzOdd+Qxk2N8F0ym2BW6ltLr+uoTuMc+M2jMDJpZSmLtK+jrzgvLYBBlBbsYMUHCZ6a9gmDLsHykmXsdn1rUzcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehSUmtF7nKWcS1qYEa1qZaC9ju+uJsmu0YwLdjIbyfs=;
 b=OnUcoYyERUYpYyFZHkrj0C4w62tYi+RAACK6YplT/V4+6OXQWqes6ULC1TWxAx/+FFZBRYnDImgu9kf1BSx6G+0elGksmgU17yXuCwNr8TXyI8DAKu11OSa4DJzzKKbMgWgCXOJqvUE9YVMeKb9mzfdJWAOwp8V7wfJ77d9Z3yBAqJMFS5hmwvdDUlnPWxc2GNxBhRv8QjX4HGzU2rzDPBDVDIvb9mzgCCvi05/RhbxchXbTKk7lDwCJNtkRz3YeqYW1Qo9ZW339Z+txPmBt2OFt4twwgE0fx5CFgOjrp3ROGwEb6ABNaFWtrRIHwj/u9eonZaVCu8GqxCUpJLOaEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehSUmtF7nKWcS1qYEa1qZaC9ju+uJsmu0YwLdjIbyfs=;
 b=5Q/Io1hIkIQsp1BKD+0wdWM+YmpYRrWCUpN3cwpaiIRMRYDzQV2Y6MRSha2vzZunDyizCUNyqQEgAYo6uwFFyVZHaya8VuNP1kdmDDBuzTk16cOZy6OQyDYNzlk4VD8TkWzuFcg2gG5q3lRFATpl44JlshDnM4Wb3Q+2bcpTOfg=
Received: from DM6PR06CA0016.namprd06.prod.outlook.com (2603:10b6:5:120::29)
 by DM4PR12MB5101.namprd12.prod.outlook.com (2603:10b6:5:390::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24; Thu, 25 Nov
 2021 10:58:45 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::b2) by DM6PR06CA0016.outlook.office365.com
 (2603:10b6:5:120::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Thu, 25 Nov 2021 10:58:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Thu, 25 Nov 2021 10:58:45 +0000
Received: from thomas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 25 Nov
 2021 04:58:44 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/9] drm/amdgpu: Modify gmc block to fit for the unified ras
 function pointers.
Date: Thu, 25 Nov 2021 18:56:55 +0800
Message-ID: <20211125105701.15860-3-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211125105701.15860-1-YiPeng.Chai@amd.com>
References: <20211125105701.15860-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9cd1828-68f3-4b14-dfef-08d9b0028d55
X-MS-TrafficTypeDiagnostic: DM4PR12MB5101:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5101F3B0E5DF999A75AF6B17FC629@DM4PR12MB5101.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oE9TRypxTNXUv0FQyazVd742Z/nUtF6Vt03o0eg0iLBHMnJNxs5bqxd1DAl2iH/B2W7/FeQ+3ZnX3jVJjX3NUcuMgBUeAMHfREEDovZvsZ35lW9/vUNPoRHpyhEmeZ8Mt2ogheHUZMEE9PEoQKV9xMNk8XH+rSOrPET41c34DhiBANKXsl/orMzYnOB0GyAi5AZrSdeOlPJuaw+VSaCFxpaLn7yoj1IHe2FmFqCPZCLGD7YnPuUwrcUzrpvzAcRdQKs9Xbce1Lhha8K5iCKSiLIJE5f5xhHKoqLGhGciap8/mzEfPmkvZUvORs/1P9NlV7K3m3TTuNtqPTQN9Yr1lyIyDWfVIkVqIUXOfCCpFW3IBYhfjqXq4FxgoijAMBUu094qEPRpNlEfJKYN4mH9MiqVldWY+z2JaVFI+iLJXx0m4auTusseS4PpcouQYuICa1NWwTogQ8BXoLvHQmAErF+F6dTgI1B/gx15M0NSkri3PZ8wVJ7MuMtlWTxDPUlAm8zKYyfmcE0p1mDyrBNZUAOeO4enY800kaf+4FPzFuqP2IRqW8Jb8PQCMLWTmEbqrOFFnASjorB9JsDaLp+FCX5sawxf3q1HI0io/DZ+ndNEqHM/2rZplF911DF+mIoNHHQW1fCKRuY93xz5Q1SfxOSSW87SNtw4HIjCCNanE41GzicEhE28TtN9bNZnhTM736RT1bASGX19AJgv3AUW7obmwxyIGzG5Tlq9lZIcCGPCcDeYsfnkcfwAhr4pPc5W/2/13vLE1cGEgUgcklKY9w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(2906002)(36756003)(2616005)(86362001)(7696005)(5660300002)(8676002)(83380400001)(336012)(82310400004)(81166007)(356005)(316002)(6916009)(6666004)(36860700001)(426003)(47076005)(70586007)(70206006)(508600001)(26005)(16526019)(186003)(4326008)(8936002)(54906003)(1076003)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 10:58:45.6444 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9cd1828-68f3-4b14-dfef-08d9b0028d55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5101
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
Cc: yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Modify gmc block ras functions to fit for the unified ras function pointers.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  7 ++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 20 ++++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h |  2 +-
 5 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 83f26bca7dac..b7c462749d37 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -452,8 +452,8 @@ int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
 		adev->gmc.xgmi.ras_funcs = &xgmi_ras_funcs;
 
 	if (adev->gmc.xgmi.ras_funcs &&
-	    adev->gmc.xgmi.ras_funcs->ras_late_init) {
-		r = adev->gmc.xgmi.ras_funcs->ras_late_init(adev);
+	    adev->gmc.xgmi.ras_funcs->ops.ras_late_init) {
+		r = adev->gmc.xgmi.ras_funcs->ops.ras_late_init(adev);
 		if (r)
 			return r;
 	}
@@ -500,8 +500,8 @@ void amdgpu_gmc_ras_fini(struct amdgpu_device *adev)
 		adev->mmhub.ras_funcs->ras_fini(adev);
 
 	if (adev->gmc.xgmi.ras_funcs &&
-	    adev->gmc.xgmi.ras_funcs->ras_fini)
-		adev->gmc.xgmi.ras_funcs->ras_fini(adev);
+	    adev->gmc.xgmi.ras_funcs->ops.ras_fini)
+		adev->gmc.xgmi.ras_funcs->ops.ras_fini(adev);
 
 	if (adev->hdp.ras_funcs &&
 	    adev->hdp.ras_funcs->ras_fini)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index e55201134a01..f6f7d996ff98 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -29,6 +29,7 @@
 #include <linux/types.h>
 
 #include "amdgpu_irq.h"
+#include "amdgpu_ras.h"
 
 /* VA hole for 48bit addresses on Vega10 */
 #define AMDGPU_GMC_HOLE_START	0x0000800000000000ULL
@@ -136,11 +137,7 @@ struct amdgpu_gmc_funcs {
 };
 
 struct amdgpu_xgmi_ras_funcs {
-	int (*ras_late_init)(struct amdgpu_device *adev);
-	void (*ras_fini)(struct amdgpu_device *adev);
-	int (*query_ras_error_count)(struct amdgpu_device *adev,
-				     void *ras_error_status);
-	void (*reset_ras_error_count)(struct amdgpu_device *adev);
+	struct amdgpu_ras_block_ops ops;
 };
 
 struct amdgpu_xgmi {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 790aaba065ab..7f830bf8f8df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -943,8 +943,8 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 		break;
 	case AMDGPU_RAS_BLOCK__XGMI_WAFL:
 		if (adev->gmc.xgmi.ras_funcs &&
-		    adev->gmc.xgmi.ras_funcs->query_ras_error_count)
-			adev->gmc.xgmi.ras_funcs->query_ras_error_count(adev, &err_data);
+		    adev->gmc.xgmi.ras_funcs->ops.query_ras_error_count)
+			adev->gmc.xgmi.ras_funcs->ops.query_ras_error_count(adev, &err_data);
 		break;
 	case AMDGPU_RAS_BLOCK__HDP:
 		if (adev->hdp.ras_funcs &&
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 0d149f5f000e..306962c95d52 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -739,7 +739,7 @@ static int amdgpu_xgmi_ras_late_init(struct amdgpu_device *adev)
 	    adev->gmc.xgmi.num_physical_nodes == 0)
 		return 0;
 
-	adev->gmc.xgmi.ras_funcs->reset_ras_error_count(adev);
+	adev->gmc.xgmi.ras_funcs->ops.reset_ras_error_count(adev);
 
 	if (!adev->gmc.xgmi.ras_if) {
 		adev->gmc.xgmi.ras_if = kmalloc(sizeof(struct ras_common_if), GFP_KERNEL);
@@ -859,7 +859,7 @@ static int amdgpu_xgmi_query_pcs_error_status(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int amdgpu_xgmi_query_ras_error_count(struct amdgpu_device *adev,
+static void amdgpu_xgmi_query_ras_error_count(struct amdgpu_device *adev,
 					     void *ras_error_status)
 {
 	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
@@ -868,7 +868,7 @@ static int amdgpu_xgmi_query_ras_error_count(struct amdgpu_device *adev,
 	uint32_t ue_cnt = 0, ce_cnt = 0;
 
 	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__XGMI_WAFL))
-		return -EINVAL;
+		return ;
 
 	err_data->ue_count = 0;
 	err_data->ce_count = 0;
@@ -934,17 +934,17 @@ static int amdgpu_xgmi_query_ras_error_count(struct amdgpu_device *adev,
 		break;
 	}
 
-	adev->gmc.xgmi.ras_funcs->reset_ras_error_count(adev);
+	adev->gmc.xgmi.ras_funcs->ops.reset_ras_error_count(adev);
 
 	err_data->ue_count += ue_cnt;
 	err_data->ce_count += ce_cnt;
-
-	return 0;
 }
 
 const struct amdgpu_xgmi_ras_funcs xgmi_ras_funcs = {
-	.ras_late_init = amdgpu_xgmi_ras_late_init,
-	.ras_fini = amdgpu_xgmi_ras_fini,
-	.query_ras_error_count = amdgpu_xgmi_query_ras_error_count,
-	.reset_ras_error_count = amdgpu_xgmi_reset_ras_error_count,
+	.ops = {
+		.ras_late_init = amdgpu_xgmi_ras_late_init,
+		.ras_fini = amdgpu_xgmi_ras_fini,
+		.query_ras_error_count = amdgpu_xgmi_query_ras_error_count,
+		.reset_ras_error_count = amdgpu_xgmi_reset_ras_error_count,
+	},
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
index d2189bf7d428..0f3f09d58793 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -24,7 +24,7 @@
 
 #include <drm/task_barrier.h>
 #include "amdgpu_psp.h"
-
+#include "amdgpu_ras.h"
 
 struct amdgpu_hive_info {
 	struct kobject kobj;
-- 
2.25.1

