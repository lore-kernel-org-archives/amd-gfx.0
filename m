Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD388C352A1
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Dec 2022 10:04:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 019C010E384;
	Wed,  7 Dec 2022 10:04:02 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2056.outbound.protection.outlook.com [40.107.95.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15A1089DA9
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Dec 2022 10:03:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtzZgkjymFfj8yPRzRB+biaDVRqDsKKndPZZf9qWgLo4jysCUlNVB273V/VI1zOMy53m7LsNsZ+pyguP3HDqsFGGIXpDUCTJY8J33/j9bfKJY5oGVBWEDIAytsFaqN5R6WZKEo1815mQIN82GU6RU2JAre/wUk3rIQcQlC2alFGI1dx91Z8d6x5KIAVmvyGxBKlCi4g0d9csn1d8N24lZBciMaxPck9gQOApXsqoWeMdBSO8LSMy3C886gAKR5o19CSxqwipircDrV8GwM7cLjZvwkcSmb9cdyQ2daiqUK6cfdXl1HW0Ux/ZpQfE5fLMRfBGoi6M8Eriv5Iz6xTPig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufDR8+OhBad7QLPfWzq8BKuJo0JpsMfE/ecVC3aeWnY=;
 b=cx82aumLneGbt8PIxV8IDuazqGpU/lrLVdkAg2pt797rY4jIMshLJlgI2+YiFCjJBRr3y1MD1GG3jErQVVfiUYN5sfL4qBDgXIfAnsOsoWLHnNi6+ZgUr04+xxbxOpZZQkZ4VGOahNOME3BJ9g/mEKbjSN+pDAnthb1aCMNAL6SskPmNlCI2Cvh+BIijdO5l4pYky1n6G+XPtv+dqDI5KFMs0n1ox9Q670tM4/th4iw0/Cy5BD2lV2Km83mataJDg3dp+p96SZIUArafVEo+spVanIKIAmDq7adq/tHdk2YNUyvT38iUyzQLta/Bxc837d/lpK1L+8xBZ55EQ0Y2jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufDR8+OhBad7QLPfWzq8BKuJo0JpsMfE/ecVC3aeWnY=;
 b=3b3p9J9a+Okes6y0CnvAjzIWmXnGb2Z+5jQwqs0oc158ECt80Pzs97SFXU2BMm5ppPTg+WGcvXkrxCjTYLqgoUGzIshy4PRixHDJ77RB5istsYY1vzEkQd70TSg8eQgaurU+S9NHTRxfbX5Da09zJvNIs+b7OfxHXBtD2VQuBJY=
Received: from DM6PR06CA0085.namprd06.prod.outlook.com (2603:10b6:5:336::18)
 by MW4PR12MB6951.namprd12.prod.outlook.com (2603:10b6:303:207::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 10:03:53 +0000
Received: from DS1PEPF0000E62F.namprd02.prod.outlook.com
 (2603:10b6:5:336:cafe::23) by DM6PR06CA0085.outlook.office365.com
 (2603:10b6:5:336::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Wed, 7 Dec 2022 10:03:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E62F.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.8 via Frontend Transport; Wed, 7 Dec 2022 10:03:53 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Dec
 2022 04:03:50 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <Gavin.Wan@amd.com>, <Vignesh.Chander@amd.com>,
 <david.yu@amd.com>
Subject: [PATCH 1/6] drm/amdgpu: inform PF if VF receives RAS poison interrupt
Date: Wed, 7 Dec 2022 18:03:36 +0800
Message-ID: <20221207100341.15356-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E62F:EE_|MW4PR12MB6951:EE_
X-MS-Office365-Filtering-Correlation-Id: 26e12a49-d444-4e75-b563-08dad83a58bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LRwZk8sr9uRMp8i8VCZJQReqbwP8NuNkctQpXx5WbfiUiBW1e4W/KvevwIcq8r0/p1vyeakSEI6F+rYvNnVeziX5uwctNrcvomwLn+QB3nmpVBatvnvERkUkFQytnZZnT6VQ5oRp3KYASSEIlH7eZ3EMy7lgX6qCr5UFmB4NqUSqE1uHtca+hvMFnqt/F/TV3c1qK7rPNJQERvTx5EMG27fRCFbxQyxBfNcCGo9HFxPz3opu07CcKStaOlS0URqiVOIXMZGK4h1EqmbzFrOpoBeWvmlq823qrNoQT0snGcBV0EKuIQZ4J9bVmeTeVRygS0ZKTl4yYS+Ie5av2zY1uiSPYOSfxo7ObEYxGVdczhevL5elSBNmJySx/9dbccLCVY42qiyH3EYCdlmSCG2HrohVfD3JJ8Hb5scAUb0brA5s1qDGBMdXJPOW1c0wrrbu4OB/qqaUTySk4lDqCI2m9Dw3tyb2VFmpwRJeknmlpOmKSgUQOrpv8DGNspJMngWPZ8i2nTo+lNsn4X0cY0tKO404ypf9go84p/DDyIHOKCgGr3qNGdgo1aZWbc/TDapRa1fDQPqMwPK2/7J+OXfg00ivla9FVgkDs4LhQivpLBLPB8u+lwGUEVCm8QpkKxXB0TM/43e2TYVqc+rKMIUcBGxJ8+67ex7KgzJBxWxiG2FrFLXeggC0zwV65xOh+lnuLyJoJZX+z5x/XIoLvlb41bwBw56b4SI6gb+6z6RiSto=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199015)(36840700001)(46966006)(40470700004)(1076003)(2906002)(16526019)(110136005)(2616005)(356005)(81166007)(8676002)(40480700001)(4326008)(41300700001)(186003)(70206006)(70586007)(26005)(82740400003)(7696005)(82310400005)(36756003)(36860700001)(8936002)(40460700003)(316002)(5660300002)(6636002)(83380400001)(478600001)(47076005)(86362001)(336012)(426003)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 10:03:53.4095 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e12a49-d444-4e75-b563-08dad83a58bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E62F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6951
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

PF will do page retirement, reset VF and inform VF to reserve RAS
bad pages.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c  | 44 ++++++++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  1 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c    |  6 ++++
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h    |  1 +
 4 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index f76c19fc0392..1c7fcb4f2380 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -169,25 +169,33 @@ int amdgpu_umc_poison_handler(struct amdgpu_device *adev, bool reset)
 {
 	int ret = AMDGPU_RAS_SUCCESS;
 
-	if (!adev->gmc.xgmi.connected_to_cpu) {
-		struct ras_err_data err_data = {0, 0, 0, NULL};
-		struct ras_common_if head = {
-			.block = AMDGPU_RAS_BLOCK__UMC,
-		};
-		struct ras_manager *obj = amdgpu_ras_find_obj(adev, &head);
-
-		ret = amdgpu_umc_do_page_retirement(adev, &err_data, NULL, reset);
-
-		if (ret == AMDGPU_RAS_SUCCESS && obj) {
-			obj->err_data.ue_count += err_data.ue_count;
-			obj->err_data.ce_count += err_data.ce_count;
+	if (!amdgpu_sriov_vf(adev)) {
+		if (!adev->gmc.xgmi.connected_to_cpu) {
+			struct ras_err_data err_data = {0, 0, 0, NULL};
+			struct ras_common_if head = {
+				.block = AMDGPU_RAS_BLOCK__UMC,
+			};
+			struct ras_manager *obj = amdgpu_ras_find_obj(adev, &head);
+
+			ret = amdgpu_umc_do_page_retirement(adev, &err_data, NULL, reset);
+
+			if (ret == AMDGPU_RAS_SUCCESS && obj) {
+				obj->err_data.ue_count += err_data.ue_count;
+				obj->err_data.ce_count += err_data.ce_count;
+			}
+		} else if (reset) {
+			/* MCA poison handler is only responsible for GPU reset,
+			 * let MCA notifier do page retirement.
+			 */
+			kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
+			amdgpu_ras_reset_gpu(adev);
 		}
-	} else if (reset) {
-		/* MCA poison handler is only responsible for GPU reset,
-		 * let MCA notifier do page retirement.
-		 */
-		kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
-		amdgpu_ras_reset_gpu(adev);
+	} else {
+		if (adev->virt.ops && adev->virt.ops->ras_poison_handler)
+			adev->virt.ops->ras_poison_handler(adev);
+		else
+			dev_warn(adev->dev,
+				"No ras_poison_handler interface in SRIOV!\n");
 	}
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 2b9d806e23af..b9e9480448af 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -88,6 +88,7 @@ struct amdgpu_virt_ops {
 	int (*wait_reset)(struct amdgpu_device *adev);
 	void (*trans_msg)(struct amdgpu_device *adev, enum idh_request req,
 			  u32 data1, u32 data2, u32 data3);
+	void (*ras_poison_handler)(struct amdgpu_device *adev);
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index 12906ba74462..63725b2ebc03 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -404,6 +404,11 @@ static int xgpu_ai_request_init_data(struct amdgpu_device *adev)
 	return xgpu_ai_send_access_requests(adev, IDH_REQ_GPU_INIT_DATA);
 }
 
+static void xgpu_ai_ras_poison_handler(struct amdgpu_device *adev)
+{
+	xgpu_ai_send_access_requests(adev, IDH_RAS_POISON);
+}
+
 const struct amdgpu_virt_ops xgpu_ai_virt_ops = {
 	.req_full_gpu	= xgpu_ai_request_full_gpu_access,
 	.rel_full_gpu	= xgpu_ai_release_full_gpu_access,
@@ -411,4 +416,5 @@ const struct amdgpu_virt_ops xgpu_ai_virt_ops = {
 	.wait_reset = NULL,
 	.trans_msg = xgpu_ai_mailbox_trans_msg,
 	.req_init_data  = xgpu_ai_request_init_data,
+	.ras_poison_handler = xgpu_ai_ras_poison_handler,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
index fa7e13e0459e..0136bd059f68 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
@@ -39,6 +39,7 @@ enum idh_request {
 
 	IDH_LOG_VF_ERROR       = 200,
 	IDH_READY_TO_RESET 	= 201,
+	IDH_RAS_POISON		= 202,
 };
 
 enum idh_event {
-- 
2.35.1

