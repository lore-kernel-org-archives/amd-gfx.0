Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F35C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Nov 2021 10:59:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A48D76E94E;
	Thu, 25 Nov 2021 10:59:04 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 767A96E93B
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Nov 2021 10:59:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZKnFKZ7xnSjfCbQA4KwXf5x5mmzznvPfpV+wHuRnlo3lBM5YrQ/3FiklT2Igx1buSxHEbgBK6U+w0nrai6hfJNjULTEMmDlHNm807VEm4LpmZ8f51N6AJSKSaC+EAy3GZI2dn98A+XRiueMxiWmiWgcjfz6TUhXfM72dKtoEaseuk7ckczvOFG2f9UEtJ3m7ahywiP1aO5wICFVLC0I7uCi+uXCBCXxUnxr+CqpvUOQnt6GzKKf5eZk4tgHWs9Z6TwcmTZYUODywkVqwxh+s1+YPmz8mRwyG27HgbVBgIyY9QtLPwkjF2UNTEwkxs3tpab5zzoygWehPPFHxttUTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XX4t6db69vjG91btPcCzY7EfJU3Fh//OSfYZwF8JK/s=;
 b=Xz3RBmVhtV3IpJtDFezABiEZkWAK4tpknau9lRdGyZ8zFS7FGr2vS039X4gLoD6I9Yy3MR0bgNnzkSH8acA4yMbdYf647BevcFY8fvSOysUgVpddQ9fPQ/MWfSiCxwh/UuUaVOiL9B19b1osHu3afx/lvD4eY50vp8Om5oWBSvc4miwNcBrekYmXZDQKsUWjB1GpR7rL85VqOiPVJgtH1Z/lmIP+7/sqcw1nXz+ygnIE2JuFWGOAxZ6Kvh1ZTCrmqHJc/iZzEKvu/MoBodXA4jYS1gNJ3GRpCkuJaqrCCmJ/kub050glFKJfDJL4D4UTh+8zIt6gIN0WqB4ZYHvEZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XX4t6db69vjG91btPcCzY7EfJU3Fh//OSfYZwF8JK/s=;
 b=gX86N0TRGTRNnqPPAMm4zeKWdzkUm4NOHEK+KWt9nLjLp82pP8dhNjfxgxSYDJmHTjvZmPEltJqYwfT+pW0RWSrlJHTTkuaH8pvciQDbPgWxIFhBODO9ws2hbQ+YUVFW/J8vsLIpVAzjgjp4HisreENGWJoHeAeEKd9U+0qWn7k=
Received: from DM5PR21CA0069.namprd21.prod.outlook.com (2603:10b6:3:129::31)
 by DM6PR12MB3674.namprd12.prod.outlook.com (2603:10b6:5:1c4::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24; Thu, 25 Nov
 2021 10:59:01 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:129:cafe::b4) by DM5PR21CA0069.outlook.office365.com
 (2603:10b6:3:129::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.7 via Frontend
 Transport; Thu, 25 Nov 2021 10:59:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Thu, 25 Nov 2021 10:59:01 +0000
Received: from thomas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 25 Nov
 2021 04:58:59 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 9/9] drm/amdgpu: Modify sdma block to fit for the unified ras
 function pointers.
Date: Thu, 25 Nov 2021 18:57:01 +0800
Message-ID: <20211125105701.15860-9-YiPeng.Chai@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 03a48cd8-8d9a-45d8-5630-08d9b00296e4
X-MS-TrafficTypeDiagnostic: DM6PR12MB3674:
X-Microsoft-Antispam-PRVS: <DM6PR12MB367481D2158372B58B8E03F0FC629@DM6PR12MB3674.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I5ehtgTbgM3r85rTZvAGsu8XlfZJTqWh7Yrt8gBfQqPMUUsijoqb5vBxRs7eyWxqiflW1Bo3vaza0jvYQhZKZ1sMXofpmR7faq83cW9dWVxRwM6s/G9gxf4iQPkbQznww00VuqwsIGlg+GvsisTtI/K4Xqq4YqD017tnuwH8caNI9WD/Yz6fYeKtOtpnodi3qruVPmIQy8qyUiJq8DxOG+LzBJhJhLVizlA0LuW+OkejHFoyPZZknCXb5HplpgLQbmFIrqTTXzyaHsZO+4n4jovcNfprkPMRtzux0aUNK0/yMyTtkIvnzUPq4MhqvWgyG3zOubz1dF9hja0t4a/4OK5gIeR4ce4oAdAfeGBqWMVQ0FsriL1A2u9eTFoet0UM58YRXNMh9HmfTkMLIdd59uWJAUdvKUO++nKAqYDbaTkuGV7u+IGjUqCfNHV6WlyBxUDbEJ8opoB1P829KKxdmWg8h5VWQqJAv7GLzkQ+RX8wwCxFnNdH3kHSTqr1pT3gPmGYqzyrtCJLT3UMBrc6niBl07Zv5CPmNEmruBZsubrdW4U9lXCTvGJ/WTmZZhBPnDKiUQGqM3k0BMhakCTW/uF/N74S7d9rPy10W3yO2HlPbtjdAUxdidQ5dUrHCMPkWcaEa+K9xCCZ9r2Gg7SR98wOahlM24emxV+8t5SB4w/LnCTrMe98OqsyKai1jFA8VzEF6QZAEqQwj9Iw3klzZwjYjt3XYA5fIJ4xkIp1VAZESlkIUD0ZiADQGBjto+YV
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(2906002)(5660300002)(70206006)(316002)(54906003)(36860700001)(47076005)(8936002)(508600001)(26005)(7696005)(36756003)(82310400004)(4326008)(70586007)(6666004)(16526019)(2616005)(1076003)(8676002)(336012)(83380400001)(6916009)(86362001)(186003)(81166007)(356005)(426003)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 10:59:01.6786 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a48cd8-8d9a-45d8-5630-08d9b00296e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3674
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

Modify sdma block ras functions to fit for the unified ras function pointers.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  | 11 +++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h | 11 +++----
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 42 ++++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c   | 25 +++++++++++---
 4 files changed, 56 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 65306e0079af..e6d82e6e702c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -912,11 +912,8 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 			adev->umc.ras_funcs->ops.query_ras_error_address(adev, &err_data);
 		break;
 	case AMDGPU_RAS_BLOCK__SDMA:
-		if (adev->sdma.funcs->query_ras_error_count) {
-			for (i = 0; i < adev->sdma.num_instances; i++)
-				adev->sdma.funcs->query_ras_error_count(adev, i,
-									&err_data);
-		}
+		if (adev->sdma.ras_funcs->ops.query_ras_error_count)
+			adev->sdma.ras_funcs->ops.query_ras_error_count(adev, &err_data);
 		break;
 	case AMDGPU_RAS_BLOCK__GFX:
 		if (adev->gfx.ras_funcs &&
@@ -1035,8 +1032,8 @@ int amdgpu_ras_reset_error_status(struct amdgpu_device *adev,
 			adev->mmhub.ras_funcs->ops.reset_ras_error_status(adev);
 		break;
 	case AMDGPU_RAS_BLOCK__SDMA:
-		if (adev->sdma.funcs->reset_ras_error_count)
-			adev->sdma.funcs->reset_ras_error_count(adev);
+		if (adev->sdma.ras_funcs->ops.reset_ras_error_count)
+			adev->sdma.ras_funcs->ops.reset_ras_error_count(adev);
 		break;
 	case AMDGPU_RAS_BLOCK__HDP:
 		if (adev->hdp.ras_funcs &&
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index f8fb755e3aa6..a76c63520ca0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -23,6 +23,7 @@
 
 #ifndef __AMDGPU_SDMA_H__
 #define __AMDGPU_SDMA_H__
+#include "amdgpu_ras.h"
 
 /* max number of IP instances */
 #define AMDGPU_MAX_SDMA_INSTANCES		8
@@ -51,12 +52,8 @@ struct amdgpu_sdma_instance {
 };
 
 struct amdgpu_sdma_ras_funcs {
-	int (*ras_late_init)(struct amdgpu_device *adev,
-			void *ras_ih_info);
-	void (*ras_fini)(struct amdgpu_device *adev);
-	int (*query_ras_error_count)(struct amdgpu_device *adev,
-			uint32_t instance, void *ras_error_status);
-	void (*reset_ras_error_count)(struct amdgpu_device *adev);
+	struct amdgpu_ras_block_ops ops;
+	int (*sdma_ras_late_init)(struct amdgpu_device *adev, void *ras_ih_info);
 };
 
 struct amdgpu_sdma {
@@ -73,7 +70,7 @@ struct amdgpu_sdma {
 	uint32_t                    srbm_soft_reset;
 	bool			has_page_queue;
 	struct ras_common_if	*ras_if;
-	const struct amdgpu_sdma_ras_funcs	*funcs;
+	const struct amdgpu_sdma_ras_funcs	*ras_funcs;
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 69c9e460c1eb..d5bd23b57f5d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1898,13 +1898,13 @@ static int sdma_v4_0_late_init(void *handle)
 	sdma_v4_0_setup_ulv(adev);
 
 	if (!amdgpu_persistent_edc_harvesting_supported(adev)) {
-		if (adev->sdma.funcs &&
-		    adev->sdma.funcs->reset_ras_error_count)
-			adev->sdma.funcs->reset_ras_error_count(adev);
+		if (adev->sdma.ras_funcs &&
+		    adev->sdma.ras_funcs->ops.reset_ras_error_count)
+			adev->sdma.ras_funcs->ops.reset_ras_error_count(adev);
 	}
 
-	if (adev->sdma.funcs && adev->sdma.funcs->ras_late_init)
-		return adev->sdma.funcs->ras_late_init(adev, &ih_info);
+	if (adev->sdma.ras_funcs && adev->sdma.ras_funcs->sdma_ras_late_init)
+		return adev->sdma.ras_funcs->sdma_ras_late_init(adev, &ih_info);
 	else
 		return 0;
 }
@@ -2007,8 +2007,8 @@ static int sdma_v4_0_sw_fini(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int i;
 
-	if (adev->sdma.funcs && adev->sdma.funcs->ras_fini)
-		adev->sdma.funcs->ras_fini(adev);
+	if (adev->sdma.ras_funcs && adev->sdma.ras_funcs->ops.ras_fini)
+		adev->sdma.ras_funcs->ops.ras_fini(adev);
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		amdgpu_ring_fini(&adev->sdma.instance[i].ring);
@@ -2745,7 +2745,7 @@ static void sdma_v4_0_get_ras_error_count(uint32_t value,
 	}
 }
 
-static int sdma_v4_0_query_ras_error_count(struct amdgpu_device *adev,
+static int sdma_v4_0_query_ras_error_count_by_instance(struct amdgpu_device *adev,
 			uint32_t instance, void *ras_error_status)
 {
 	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
@@ -2778,11 +2778,25 @@ static void sdma_v4_0_reset_ras_error_count(struct amdgpu_device *adev)
 	}
 }
 
+static void sdma_v4_0_query_ras_error_count(struct amdgpu_device *adev,  void *ras_error_status)
+{
+	int i = 0;
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		if (sdma_v4_0_query_ras_error_count_by_instance(adev, i, ras_error_status))
+		{
+			dev_err(adev->dev, "Query ras error count failed in SDMA%d \n", i);
+			return;
+		}
+	}
+}
+
 static const struct amdgpu_sdma_ras_funcs sdma_v4_0_ras_funcs = {
-	.ras_late_init = amdgpu_sdma_ras_late_init,
-	.ras_fini = amdgpu_sdma_ras_fini,
-	.query_ras_error_count = sdma_v4_0_query_ras_error_count,
-	.reset_ras_error_count = sdma_v4_0_reset_ras_error_count,
+	.ops = {
+		.ras_fini = amdgpu_sdma_ras_fini,
+		.query_ras_error_count = sdma_v4_0_query_ras_error_count,
+		.reset_ras_error_count = sdma_v4_0_reset_ras_error_count,
+	},
+	.sdma_ras_late_init = amdgpu_sdma_ras_late_init,
 };
 
 static void sdma_v4_0_set_ras_funcs(struct amdgpu_device *adev)
@@ -2790,10 +2804,10 @@ static void sdma_v4_0_set_ras_funcs(struct amdgpu_device *adev)
 	switch (adev->asic_type) {
 	case CHIP_VEGA20:
 	case CHIP_ARCTURUS:
-		adev->sdma.funcs = &sdma_v4_0_ras_funcs;
+		adev->sdma.ras_funcs = &sdma_v4_0_ras_funcs;
 		break;
 	case CHIP_ALDEBARAN:
-		adev->sdma.funcs = &sdma_v4_4_ras_funcs;
+		adev->sdma.ras_funcs = &sdma_v4_4_ras_funcs;
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c
index bf95007f0843..a4b05dbb88ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c
@@ -188,7 +188,7 @@ static void sdma_v4_4_get_ras_error_count(struct amdgpu_device *adev,
 	}
 }
 
-static int sdma_v4_4_query_ras_error_count(struct amdgpu_device *adev,
+static int sdma_v4_4_query_ras_error_count_by_instance(struct amdgpu_device *adev,
 					   uint32_t instance,
 					   void *ras_error_status)
 {
@@ -245,9 +245,24 @@ static void sdma_v4_4_reset_ras_error_count(struct amdgpu_device *adev)
 	}
 }
 
+static void sdma_v4_4_query_ras_error_count(struct amdgpu_device *adev,  void *ras_error_status)
+{
+	int i = 0;
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		if (sdma_v4_4_query_ras_error_count_by_instance(adev, i, ras_error_status))
+		{
+			dev_err(adev->dev, "Query ras error count failed in SDMA%d \n", i);
+			return;
+		}
+	}
+
+}
+
 const struct amdgpu_sdma_ras_funcs sdma_v4_4_ras_funcs = {
-	.ras_late_init = amdgpu_sdma_ras_late_init,
-	.ras_fini = amdgpu_sdma_ras_fini,
-	.query_ras_error_count = sdma_v4_4_query_ras_error_count,
-	.reset_ras_error_count = sdma_v4_4_reset_ras_error_count,
+	.ops = {
+		.ras_fini = amdgpu_sdma_ras_fini,
+		.query_ras_error_count = sdma_v4_4_query_ras_error_count,
+		.reset_ras_error_count = sdma_v4_4_reset_ras_error_count,
+	},
+	.sdma_ras_late_init = amdgpu_sdma_ras_late_init,
 };
-- 
2.25.1

