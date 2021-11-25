Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD163C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Nov 2021 10:58:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 508756E866;
	Thu, 25 Nov 2021 10:58:52 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53BA76E866
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Nov 2021 10:58:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7GGU4SqfRY9JZgIW8bRcd3A2XNvY943tbxunLkbxE5Nux4+qczkBIvlex2sNUR1gxiRRmBxTB6hVFZpJh7z1N3GScht/Tu0cpB3Sg/L8MgMmWcKDK166gNy6NDnLNYj9kzeuotmSRTwP7dMyGuPe0EPdrReDWTVTup4psGbUg6stfBAXQfiHYtPPYYZSFnHpepcqrZ8YK/d1CHgvOOVECjrvk28u+vAsyHAfAoK4ZU88X6toV/qV4xCQydBxgbxvwB6u/5e7416uzO99qaCGUIso7HUsuw1l7xDSKhDDnO0/uAI/vckGL1zPSrMCO15c/EF6cN3hVTDr29pSAxDvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eq3SpMhZc3nJ9xsd6Hne3OKo+yDiqEu4reY6DgEPwYo=;
 b=ft76lNFHb9voD/OBkOuQw0ipyuEGtTmUjzVGnV7WGwnwsxRO62EV4l0OxMznUQFeHGvte8O7CJdPu/QuICdM+PA9b63j4S5oREZdAiaSIPexXf8AjVVUX3iTPUz5E+wbllNLKmBH10jI2YQRB077u5DuP3t6144CRnaG5GBGrnUvMdV7imymPfDWt7uFGpe2HLHTGyQH5MHTEo8244vJADuALHPNJg1Di1vdR2zCL/TFe6ep/bZMasa+QKyDQIUBBucP15ZM4mFjr8N8cPj3J5SNhnZSvlHgMoKGN3Pmae/S/GviHzHBhBs2RvWNRgbAMp1m2hykoPiR9umBT8Ahlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eq3SpMhZc3nJ9xsd6Hne3OKo+yDiqEu4reY6DgEPwYo=;
 b=yLVmf0AbOx5jK/JeGI/pCfckUyjQbajL4g3bgsZyhWrZkESsZ2bTX8d/Ul2hdTuwfuzDF+11oC/pD7BLMXOULaWdNQC/9xJ5iGz5iQatSjxwHPKrFU7ICmgEpjTc9zVVAAONuP72d32BShTd09hE5nJPV1aJWqCDUWqJgBPz9c8=
Received: from DM6PR03CA0083.namprd03.prod.outlook.com (2603:10b6:5:333::16)
 by MWHPR12MB1869.namprd12.prod.outlook.com (2603:10b6:300:111::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Thu, 25 Nov
 2021 10:58:48 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::b2) by DM6PR03CA0083.outlook.office365.com
 (2603:10b6:5:333::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend
 Transport; Thu, 25 Nov 2021 10:58:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Thu, 25 Nov 2021 10:58:48 +0000
Received: from thomas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 25 Nov
 2021 04:58:46 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/9] drm/amdgpu: Modify hdp block to fit for the unified ras
 function pointers.
Date: Thu, 25 Nov 2021 18:56:56 +0800
Message-ID: <20211125105701.15860-4-YiPeng.Chai@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: e3d10dbc-3710-449e-c533-08d9b0028f09
X-MS-TrafficTypeDiagnostic: MWHPR12MB1869:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1869C538E3371DA6EE3A75E8FC629@MWHPR12MB1869.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eI1TMqFAIvl+zncRrkyvFSAfbr6Po1+CRG6lH7n20wKYzXKWsZS2K5SfucSwmJe+7X4+M1Ug79o58j+WHX8cHg/iz9WUpc9G+WuJjXfdXiElg4pmzr9IQsRqD6oUKuTkahcYmt1dgZ/WhWi2P1d5d/4sozrnbDYxd0NHEvcJ/Pc2ra26t7PERR06RABo0t96yxCBVfY/eXronX7sOmx3/9BkNuPDVPIg/uucBhSwDB4OXjgm9F0RvF0aqsays65/CQ3gyVSINE+zMeTxhqOfpwRDVrfsWzYR3GNH32W/xMMW2PbuGF9O06k/DYBQolWbsJE3gbFk9JDyFJQFORrJ2IraEom/IY71mRxCcviAO99QWiFH1lcWYS7V9cYVf7EtTH7ExmfBcmRy1cgryV2sxzpIklRYzI69vny2HF6c+N2ekxagwf0TdGf4ND8A/OqaftSiSTVPaYU5AFdG50iCURMtZ7HstD2Z9KzmF6Lb4OwSS59uMBHizwMRkLF/a2UfL6GZNdg/q5fKTXVhQjBwEqVrKHmi9GFZ3bXbhZpy050b+nTNKd8Y5NKgaYKWWO28tFv5uq9Q+gSDXxFUyfS373P3sPNv5N48a+hhNDDK8/1IR4NimalMGImpggAJy0/uku+G4umtw7caLxIsdo2r+Y8gXGblZwwe4Qbgj1a2yugW2kWC7h1RB2J63cfAO7E/RqiSpXuRkwQnzGPyrHoPjdfg6FDiDfKBTVxUXriI3uw1jFaiH+iSMJD8Z+5O3Ra5
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(2616005)(26005)(6666004)(16526019)(8676002)(81166007)(186003)(508600001)(7696005)(83380400001)(336012)(70586007)(47076005)(36756003)(426003)(1076003)(82310400004)(6916009)(356005)(316002)(54906003)(4326008)(36860700001)(8936002)(2906002)(70206006)(5660300002)(86362001)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 10:58:48.5121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3d10dbc-3710-449e-c533-08d9b0028f09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1869
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

Modify hdp block ras functions to fit for the unified ras function pointers.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h |  7 ++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  4 ++--
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c   | 10 ++++++----
 5 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index b7c462749d37..0aab31fce997 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -459,8 +459,8 @@ int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
 	}
 
 	if (adev->hdp.ras_funcs &&
-	    adev->hdp.ras_funcs->ras_late_init) {
-		r = adev->hdp.ras_funcs->ras_late_init(adev);
+	    adev->hdp.ras_funcs->ops.ras_late_init) {
+		r = adev->hdp.ras_funcs->ops.ras_late_init(adev);
 		if (r)
 			return r;
 	}
@@ -504,8 +504,8 @@ void amdgpu_gmc_ras_fini(struct amdgpu_device *adev)
 		adev->gmc.xgmi.ras_funcs->ops.ras_fini(adev);
 
 	if (adev->hdp.ras_funcs &&
-	    adev->hdp.ras_funcs->ras_fini)
-		adev->hdp.ras_funcs->ras_fini(adev);
+	    adev->hdp.ras_funcs->ops.ras_fini)
+		adev->hdp.ras_funcs->ops.ras_fini(adev);
 }
 
 	/*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
index 7ec99d591584..49121eb7d599 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
@@ -22,13 +22,10 @@
  */
 #ifndef __AMDGPU_HDP_H__
 #define __AMDGPU_HDP_H__
+#include "amdgpu_ras.h"
 
 struct amdgpu_hdp_ras_funcs {
-	int (*ras_late_init)(struct amdgpu_device *adev);
-	void (*ras_fini)(struct amdgpu_device *adev);
-	void (*query_ras_error_count)(struct amdgpu_device *adev,
-				      void *ras_error_status);
-	void (*reset_ras_error_count)(struct amdgpu_device *adev);
+	struct amdgpu_ras_block_ops ops;
 };
 
 struct amdgpu_hdp_funcs {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 7f830bf8f8df..a3b606c84d45 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -948,8 +948,8 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 		break;
 	case AMDGPU_RAS_BLOCK__HDP:
 		if (adev->hdp.ras_funcs &&
-		    adev->hdp.ras_funcs->query_ras_error_count)
-			adev->hdp.ras_funcs->query_ras_error_count(adev, &err_data);
+		    adev->hdp.ras_funcs->ops.query_ras_error_count)
+			adev->hdp.ras_funcs->ops.query_ras_error_count(adev, &err_data);
 		break;
 	case AMDGPU_RAS_BLOCK__MCA:
 		amdgpu_ras_mca_query_error_status(adev, &info->head, &err_data);
@@ -1040,8 +1040,8 @@ int amdgpu_ras_reset_error_status(struct amdgpu_device *adev,
 		break;
 	case AMDGPU_RAS_BLOCK__HDP:
 		if (adev->hdp.ras_funcs &&
-		    adev->hdp.ras_funcs->reset_ras_error_count)
-			adev->hdp.ras_funcs->reset_ras_error_count(adev);
+		    adev->hdp.ras_funcs->ops.reset_ras_error_count)
+			adev->hdp.ras_funcs->ops.reset_ras_error_count(adev);
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 3606d2cbff5e..c40c669d49c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1301,8 +1301,8 @@ static int gmc_v9_0_late_init(void *handle)
 			adev->mmhub.ras_funcs->reset_ras_error_count(adev);
 
 		if (adev->hdp.ras_funcs &&
-		    adev->hdp.ras_funcs->reset_ras_error_count)
-			adev->hdp.ras_funcs->reset_ras_error_count(adev);
+		    adev->hdp.ras_funcs->ops.reset_ras_error_count)
+			adev->hdp.ras_funcs->ops.reset_ras_error_count(adev);
 	}
 
 	r = amdgpu_gmc_ras_late_init(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
index 74b90cc2bf48..9021ea08ee0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
@@ -150,10 +150,12 @@ static void hdp_v4_0_init_registers(struct amdgpu_device *adev)
 }
 
 const struct amdgpu_hdp_ras_funcs hdp_v4_0_ras_funcs = {
-	.ras_late_init = amdgpu_hdp_ras_late_init,
-	.ras_fini = amdgpu_hdp_ras_fini,
-	.query_ras_error_count = hdp_v4_0_query_ras_error_count,
-	.reset_ras_error_count = hdp_v4_0_reset_ras_error_count,
+	.ops = {
+		.ras_late_init = amdgpu_hdp_ras_late_init,
+		.ras_fini = amdgpu_hdp_ras_fini,
+		.query_ras_error_count = hdp_v4_0_query_ras_error_count,
+		.reset_ras_error_count = hdp_v4_0_reset_ras_error_count,
+	},
 };
 
 const struct amdgpu_hdp_funcs hdp_v4_0_funcs = {
-- 
2.25.1

