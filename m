Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 895E6C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Dec 2021 08:51:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E990511301D;
	Mon, 20 Dec 2021 08:51:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D37B11301D
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Dec 2021 08:51:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGJkJi82Rmj4d4DndEMWB2oPDUVci9/wKm9QYr+1M8PngO9zegovw5SGr0+3wKUUh4ecP9OnEbbRsI6uiaOAQq4mP2uWJ4y8TKNPubjbYdD8hyvzi5PDpcdXOZHyCqeBR5sOkhWXTHnQG+p9ewfB4NbXVQwDz39HbV0Rol/s9u9IiqHKCRMDD7aZb9pCq4WFyp+wnUHaqDU7lgNOpdX0+OpujCUdUmWo0rq1EVEEs3FXoUyzyenarXiOujjAGPfGknxhqL0GGpd+1awvUOVm7Mus7wTPXodEhuzyEFY4eZKLNgOQ843v3WF6m1v8rQTv5JFeqpTPlFFNAsHwMBbTmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJ4rlbWvH9A9MYUt9m5Wpehi/N4auvOiDhf2s+X1wyE=;
 b=B3y8m77Tezs2vX6RFJLLA6hiA10JJzORZmdckQPuV8pewMyXRI8KUeZVlImjLW7rIXFbjYsCOzvGZaOFskgQVyMrbk4dMfR0S/j+tz7C+MbwkN/cXhUqYgshN2/e2rG9zuXcIshScOhY4HJO1SCJabpBQiklPKeH1h1JyDqRnk8GF45fCT0cLqHlP0vqsXtvvg6o0Q27nufpbPJnwj0IMhlQXusuFuGHoBg/dO8iCdqFnm0vLdb51I1JGHrM5lYIkhGjt7ODsdRZrKzRtqefbU+frurfiVXtI+/aZmgjpvbdB0NXzTkGDHn6TId6Pc8zZkZBJN8XUvpkBAfdTidNUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJ4rlbWvH9A9MYUt9m5Wpehi/N4auvOiDhf2s+X1wyE=;
 b=CowwguZ1MnMEZqnjUrhJXPGfWu/nHhuBXDPOYyvinN2B/PzKJS0NDeKCIVrG+mIDfuiyVe60o/amloiY/3f89FEuh1fLwOK/XyHSnnC89vC36SPqYbFT9CNLMMZWwOxqoQ8covgBKEchO9YrRv29n3okuhDAB0ywaL5aN6UfwyM=
Received: from MWHPR17CA0084.namprd17.prod.outlook.com (2603:10b6:300:c2::22)
 by MWHPR1201MB0221.namprd12.prod.outlook.com (2603:10b6:301:56::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Mon, 20 Dec
 2021 08:51:20 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c2:cafe::bc) by MWHPR17CA0084.outlook.office365.com
 (2603:10b6:300:c2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Mon, 20 Dec 2021 08:51:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Mon, 20 Dec 2021 08:51:19 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 20 Dec
 2021 02:51:16 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <yipeng.chai@amd.com>
Subject: [PATCH] drm/amdgpu: save error count in RAS poison handler
Date: Mon, 20 Dec 2021 16:51:07 +0800
Message-ID: <20211220085107.7608-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ee5747f-1b57-45ca-41ce-08d9c395e463
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0221:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0221DB45AB3A1AA18BB2A1FFB07B9@MWHPR1201MB0221.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:644;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lBhNLWbYUu/LgeHdGR/NulrhPsfFij2ub6D+ENf+gk6z8h/BSs1i2XygHFp+xwRaFXsaCH1CwqqtbPal4UfOPFokxpgLDpJi2MCqugxoymp3e2jnzXvHOuFPmtTmzGGVJXEecuwUtIrH++VRg7qH1577RwObuYiM53rPkVJ0DYY2+UwuEHD16f6Io3hpV04OAMJGxlYHKYGiUD8LYFL4FeMPSR5Q8TzgZz6+yTx+FEE2jNWVQEpayv3buj12W4TmS7HGIy/C4fRO9OyMU3DCspTHZzAAHvHu+xVpRJoOoii8kKWdBIknyA0F/m1fUrtnMzTuBTxpj6bzw8tF5O2GhdKBZiyqMRmzv/cfU1Ge3YfGIgKrDIS1MjSW1r4p83ukn2wKntzGbhcueAwRRbd77C5R3akTeb9JYQmu5VHkj+sQgraLITozV5NZSQjP4TFFMeoWwsBTwD0YM5xyPbMmyyN79Ri5w1GHSgY2/Jw53N0a4EmbiZNOdcARRQU62rf1lzDKVTEDk1WUaxNcT8RI57SGFBYNFOSlSFBKhmJF+pWTkVdtpWHWSdShcsm3Y8nPUpqJbnpxI3pn/+z4jlwNzVh5ok7ozUyzoo7QZU6lvlod8/q0jB+LSoObGL6Nq8zJQiNHJap5txdwm0zom5Rm1FkuXq5UFDbkKukPQoCQkvVXUyqU+0hyaztG2ZCiQfexyl8rlkZxMazQ3QMnuujE6L3yeuo299GT5CcOt0i8ruymsFKumkWnHT270cSr+4DUuc3/G9md1P4diFMTzXvB5WTD1SN4ra+/vz7mLflzl/4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(6636002)(6666004)(336012)(70586007)(70206006)(1076003)(2616005)(426003)(7696005)(47076005)(508600001)(36860700001)(4326008)(5660300002)(16526019)(356005)(81166007)(83380400001)(316002)(40460700001)(8936002)(86362001)(8676002)(82310400004)(2906002)(110136005)(26005)(186003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2021 08:51:19.7170 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee5747f-1b57-45ca-41ce-08d9c395e463
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0221
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Otherwise the RAS error count couldn't be queried from sysfs.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c    | 170 ++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h    |   3 +-
 3 files changed, 99 insertions(+), 76 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 0bf09a94d944..776a947b45df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -727,7 +727,7 @@ void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *adev, bo
 
 	/* CPU MCA will handle page retirement if connected_to_cpu is 1 */
 	if (!adev->gmc.xgmi.connected_to_cpu)
-		amdgpu_umc_do_page_retirement(adev, &err_data, NULL, reset);
+		amdgpu_umc_poison_handler(adev, &err_data, reset);
 	else if (reset)
 		amdgpu_amdkfd_gpu_reset(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 0c33f367a4e5..1c2dbd00f647 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -23,79 +23,7 @@
 
 #include "amdgpu_ras.h"
 
-static int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
-		void *ras_error_status,
-		struct amdgpu_iv_entry *entry)
-{
-	return amdgpu_umc_do_page_retirement(adev, ras_error_status, entry, true);
-}
-
-int amdgpu_umc_ras_late_init(struct amdgpu_device *adev)
-{
-	int r;
-	struct ras_fs_if fs_info = {
-		.sysfs_name = "umc_err_count",
-	};
-	struct ras_ih_if ih_info = {
-		.cb = amdgpu_umc_process_ras_data_cb,
-	};
-
-	if (!adev->umc.ras_if) {
-		adev->umc.ras_if =
-			kmalloc(sizeof(struct ras_common_if), GFP_KERNEL);
-		if (!adev->umc.ras_if)
-			return -ENOMEM;
-		adev->umc.ras_if->block = AMDGPU_RAS_BLOCK__UMC;
-		adev->umc.ras_if->type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
-		adev->umc.ras_if->sub_block_index = 0;
-	}
-	ih_info.head = fs_info.head = *adev->umc.ras_if;
-
-	r = amdgpu_ras_late_init(adev, adev->umc.ras_if,
-				 &fs_info, &ih_info);
-	if (r)
-		goto free;
-
-	if (amdgpu_ras_is_supported(adev, adev->umc.ras_if->block)) {
-		r = amdgpu_irq_get(adev, &adev->gmc.ecc_irq, 0);
-		if (r)
-			goto late_fini;
-	} else {
-		r = 0;
-		goto free;
-	}
-
-	/* ras init of specific umc version */
-	if (adev->umc.ras_funcs &&
-	    adev->umc.ras_funcs->err_cnt_init)
-		adev->umc.ras_funcs->err_cnt_init(adev);
-
-	return 0;
-
-late_fini:
-	amdgpu_ras_late_fini(adev, adev->umc.ras_if, &ih_info);
-free:
-	kfree(adev->umc.ras_if);
-	adev->umc.ras_if = NULL;
-	return r;
-}
-
-void amdgpu_umc_ras_fini(struct amdgpu_device *adev)
-{
-	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC) &&
-			adev->umc.ras_if) {
-		struct ras_common_if *ras_if = adev->umc.ras_if;
-		struct ras_ih_if ih_info = {
-			.head = *ras_if,
-			.cb = amdgpu_umc_process_ras_data_cb,
-		};
-
-		amdgpu_ras_late_fini(adev, ras_if, &ih_info);
-		kfree(ras_if);
-	}
-}
-
-int amdgpu_umc_do_page_retirement(struct amdgpu_device *adev,
+static int amdgpu_umc_do_page_retirement(struct amdgpu_device *adev,
 		void *ras_error_status,
 		struct amdgpu_iv_entry *entry,
 		bool reset)
@@ -180,6 +108,102 @@ int amdgpu_umc_do_page_retirement(struct amdgpu_device *adev,
 	return AMDGPU_RAS_SUCCESS;
 }
 
+int amdgpu_umc_poison_handler(struct amdgpu_device *adev,
+		void *ras_error_status,
+		bool reset)
+{
+	int ret;
+	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
+	struct ras_common_if head = {
+		.block = AMDGPU_RAS_BLOCK__UMC,
+	};
+	struct ras_manager *obj = amdgpu_ras_find_obj(adev, &head);
+
+	ret =
+		amdgpu_umc_do_page_retirement(adev, ras_error_status, NULL, reset);
+
+	if (ret == AMDGPU_RAS_SUCCESS && obj) {
+		obj->err_data.ue_count += err_data->ue_count;
+		obj->err_data.ce_count += err_data->ce_count;
+	}
+
+	return ret;
+}
+
+static int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
+		void *ras_error_status,
+		struct amdgpu_iv_entry *entry)
+{
+	return amdgpu_umc_do_page_retirement(adev, ras_error_status, entry, true);
+}
+
+int amdgpu_umc_ras_late_init(struct amdgpu_device *adev)
+{
+	int r;
+	struct ras_fs_if fs_info = {
+		.sysfs_name = "umc_err_count",
+	};
+	struct ras_ih_if ih_info = {
+		.cb = amdgpu_umc_process_ras_data_cb,
+	};
+
+	if (!adev->umc.ras_if) {
+		adev->umc.ras_if =
+			kmalloc(sizeof(struct ras_common_if), GFP_KERNEL);
+		if (!adev->umc.ras_if)
+			return -ENOMEM;
+		adev->umc.ras_if->block = AMDGPU_RAS_BLOCK__UMC;
+		adev->umc.ras_if->type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
+		adev->umc.ras_if->sub_block_index = 0;
+	}
+	ih_info.head = fs_info.head = *adev->umc.ras_if;
+
+	r = amdgpu_ras_late_init(adev, adev->umc.ras_if,
+				 &fs_info, &ih_info);
+	if (r)
+		goto free;
+
+	if (amdgpu_ras_is_supported(adev, adev->umc.ras_if->block)) {
+		r = amdgpu_irq_get(adev, &adev->gmc.ecc_irq, 0);
+		if (r)
+			goto late_fini;
+	} else {
+		r = 0;
+		goto free;
+	}
+
+	/* ras init of specific umc version */
+	if (adev->umc.ras_funcs &&
+	    adev->umc.ras_funcs->err_cnt_init)
+		adev->umc.ras_funcs->err_cnt_init(adev);
+
+	return 0;
+
+late_fini:
+	amdgpu_ras_late_fini(adev, adev->umc.ras_if, &ih_info);
+free:
+	kfree(adev->umc.ras_if);
+	adev->umc.ras_if = NULL;
+	return r;
+}
+
+void amdgpu_umc_ras_fini(struct amdgpu_device *adev)
+{
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC) &&
+			adev->umc.ras_if) {
+		struct ras_common_if *ras_if = adev->umc.ras_if;
+		struct ras_ih_if ih_info = {
+			.head = *ras_if,
+			.cb = amdgpu_umc_process_ras_data_cb,
+		};
+
+		amdgpu_ras_late_fini(adev, ras_if, &ih_info);
+		kfree(ras_if);
+	}
+}
+
+
+
 int amdgpu_umc_process_ecc_irq(struct amdgpu_device *adev,
 		struct amdgpu_irq_src *source,
 		struct amdgpu_iv_entry *entry)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index 8d18d5121f66..b72194e8bfe5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -78,9 +78,8 @@ struct amdgpu_umc {
 
 int amdgpu_umc_ras_late_init(struct amdgpu_device *adev);
 void amdgpu_umc_ras_fini(struct amdgpu_device *adev);
-int amdgpu_umc_do_page_retirement(struct amdgpu_device *adev,
+int amdgpu_umc_poison_handler(struct amdgpu_device *adev,
 		void *ras_error_status,
-		struct amdgpu_iv_entry *entry,
 		bool reset);
 int amdgpu_umc_process_ecc_irq(struct amdgpu_device *adev,
 		struct amdgpu_irq_src *source,
-- 
2.17.1

