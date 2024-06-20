Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD3CC27C79
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 05:41:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E7CF10E09A;
	Thu, 20 Jun 2024 05:41:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F5tAa2/z";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2BA210E09A
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 05:41:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZ1F9UufMtsxs2VIOl9aoJrKu9keRjv+Lxkbj7y4wqf4aPa8LAppe2cWUHQvDQQGKXcOQ7mbuO80IPYofGjcMQkOL2iCdZj137pOzcezQhwR59Ze2kafCO1b+Y4WRkbvIcnVtFZwHfXVhqqgePVOmrksAi3wtCkUMynsP3AmNJ0DPS1cAJMFPuNn0pt6uI9+kn8bv7YUKjR8sXYXqtWvBdVGpjI2OwuL/fNYu6056WKxbg7PgAF+A8zw7RL4nN7l+Pcun5dvK9zU0zyAJdQ02Pkd31hMxP4s3S8Ww7no048pgZ1fVOa5jt/9dZ2u+zJ2a3D3VeDQB8aSCi5NlR3m7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+xRDiwx54TTsibvK0Ky9DNXlJ3Bes6c3xPcQMlPxbZM=;
 b=iIofQYawbzod+T9IwrIocxnyCJ3v+UHWbNlLDGbGjtXlZLPiMe2ReXeQJ0/s0iwoS/ZVFoMOi2crBRXyq3uUSCWxWGuCR2X08dNvGGhpejpesPxpXIjXk18yxAke9BakmcA7YstDoW85uKJFEVbr/TbLDmnHPgtdrp4ua+oBGkKSPDNfCLQ41KvhfOMUT7R55s4EFucvyaMqihZ7o6FLr4t+8W3zsnFCJWY2hsGR1QqdnyjhOO8TwEexFnm4nAje+o+0efyispBnR1abrQF6R86MaINb/DjnugsTXJFMWVVwEr5l5UrRMiVQWgBfPOlVqhZP9qRckPmVRL+9xIKv4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xRDiwx54TTsibvK0Ky9DNXlJ3Bes6c3xPcQMlPxbZM=;
 b=F5tAa2/zVlTVmYoMSIy99Ta6Cf99ptqIAL72nK9BWGmxKAKL1GtsP5saOqtkOWmVdc0aSSaMDOHzjKOvMx1kvbLq2VUqFRpffs9BJutnK91RRd4uinE3GekEZX8orvu5lVzGE/YxE+5NrlFe5oy/mlg1xRM4FjapWAp0SPQ1w0c=
Received: from CH2PR02CA0008.namprd02.prod.outlook.com (2603:10b6:610:4e::18)
 by DM6PR12MB4339.namprd12.prod.outlook.com (2603:10b6:5:2af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 05:41:21 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:610:4e:cafe::98) by CH2PR02CA0008.outlook.office365.com
 (2603:10b6:610:4e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Thu, 20 Jun 2024 05:41:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7719.0 via Frontend Transport; Thu, 20 Jun 2024 05:41:21 +0000
Received: from amd-02.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 00:41:18 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH V2 1/4] drm/amdgpu: add variable to record the deferred error
 number read by driver
Date: Thu, 20 Jun 2024 13:40:17 +0800
Message-ID: <20240620054020.434523-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|DM6PR12MB4339:EE_
X-MS-Office365-Filtering-Correlation-Id: 1df16564-90c5-46ce-de53-08dc90eb9d8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|376011|1800799021|82310400023|36860700010; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CmKXMCOznI7Wiz3G2/IdixKU76UGk9tSHvYaanD482+rKcGYDcHvLZuQLu5Y?=
 =?us-ascii?Q?4u1otjvxGLiZmvm95mKrRbrnPZgEaYxXUfZCtzve1kQpdVMOuvBEyJ+ByVNG?=
 =?us-ascii?Q?AuLDoahygg5JiYmJZdAbTXUpEq4duKx9OhqZw+FIvu8l/O2n8eEs5K88Gi8t?=
 =?us-ascii?Q?ZMU6jFS8UmYGHQ8Ib1fFBlzaykJJXePSkF7PmX7bznVhr0hKofJMMYDp/GdC?=
 =?us-ascii?Q?MQPk1D/ayodw5nsgxBeg3CGQAATVbaMUL416LBmamoyhIWRbWFDriG+yspVV?=
 =?us-ascii?Q?eSRu/1y+X07CtOf6IZkXXkDdd8z1ivenrZRVxmUqNNV1pYwLfC+mcbvuKh/G?=
 =?us-ascii?Q?uVNgra9QXQTcSUYR6IPyqjmfqVJEYIYu39i+jZARYKu1Gk+FrbD1xjzywPpv?=
 =?us-ascii?Q?48SBr03zoq0hIWvi4CE5UqwTbQZn1nBYWOfC/dA3d26OizuW+gaAQhfX67Pv?=
 =?us-ascii?Q?rpqV1+ZO+Tw2U8vnIyy0hbqMKcicmfiUDGMwJ/6kyF9mtSSNzaO8kfB3LCGg?=
 =?us-ascii?Q?UC7MReYp4hkGQ6yN909xxKsXdBWeCtdpIYWFAmvemkjPg0HowSmDYZ5AMk9b?=
 =?us-ascii?Q?lBGgOVRjZZfg6x4tXPbVYvIbSHyIw6WBSnCfUFkvVSP8P802CttYrHeP4Nir?=
 =?us-ascii?Q?3upSUErfLpzPmjNdFL55xejoJB/2Vyu6YyX9xd00zGRt5DCHusyI8kiCtMj0?=
 =?us-ascii?Q?L6L/qwnomafJqqnorS4jKF4iipFmpg8dlJLt7YKYMwUcd4gUJkhF+nwe9odh?=
 =?us-ascii?Q?3fVTg5JiCcxINNoreLgkOQQXgTR7B0wYaPndTO20FJ5ZNStSE0j0oZxAJtdk?=
 =?us-ascii?Q?5gywh4BTuYC6heS8kdm8d+LR7n3YWrnsU+g9ROwL+Ti9mpj5/NUoJAYJT1GP?=
 =?us-ascii?Q?/MUnxscKbiEAbgvSWr5vBo5VZqISNRySjCFjFrcop+WXuwNfDTchT5RlEH+B?=
 =?us-ascii?Q?TMYCMrpD2w62s0FAMezEMw0vqOBNVrDh/QrrBJXEmJ3bjsAY88A9NNcw8ZI8?=
 =?us-ascii?Q?JwZ54yWPwL0i5DPXPfoSFDQ9uHp/WgLEGo7hBEK9NIoVfJVPOHTldndefw0A?=
 =?us-ascii?Q?kmEoaXu9mhYbDylK56+zzDogclDdMRouhCin/B/jJDpBkXJLZDethgrYvLHB?=
 =?us-ascii?Q?ywWNF7A0CBx9dunCsamv8/PPZMk0d+6REeLJO1wWun8NgHa51T857o70xy7d?=
 =?us-ascii?Q?i9qPTwD9MRTfW88qlOIgKoj4UUTpyuDlz/TPyv3aCYwgmsKeKOsm2nlC1qfx?=
 =?us-ascii?Q?zxXLoprpi2HOqtq6w7gd7zCRo0VDWs+XCe4JA8rnqqDoyxvtPKEuFpd723Yv?=
 =?us-ascii?Q?YFRrQ9q/frcaFP5qDq7DEOdxv/cgTzqORT678tpQIA9HEYn27nxVB1k2rDkz?=
 =?us-ascii?Q?98iBLiNHv1d1Z+ZZkIAuhIyI+IxGz/+RU1xOJztfqcfE8Uk3nw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(376011)(1800799021)(82310400023)(36860700010); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 05:41:21.3708 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1df16564-90c5-46ce-de53-08dc90eb9d8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4339
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

Add variable to record the deferred error
number read by driver.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 62 ++++++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  3 +-
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  |  4 +-
 3 files changed, 48 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 86cb97d2155b..f674e34037b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -120,7 +120,7 @@ const char *get_ras_block_str(struct ras_common_if *ras_block)
 /* typical ECC bad page rate is 1 bad page per 100MB VRAM */
 #define RAS_BAD_PAGE_COVER              (100 * 1024 * 1024ULL)
 
-#define MAX_UMC_POISON_POLLING_TIME_ASYNC  100  //ms
+#define MAX_UMC_POISON_POLLING_TIME_ASYNC  300  //ms
 
 #define AMDGPU_RAS_RETIRE_PAGE_INTERVAL 100  //ms
 
@@ -2804,7 +2804,8 @@ static void amdgpu_ras_ecc_log_init(struct ras_ecc_log_info *ecc_log)
 	memset(&ecc_log->ecc_key, 0xad, sizeof(ecc_log->ecc_key));
 
 	INIT_RADIX_TREE(&ecc_log->de_page_tree, GFP_KERNEL);
-	ecc_log->de_updated = false;
+	ecc_log->de_queried_count = 0;
+	ecc_log->prev_de_queried_count = 0;
 }
 
 static void amdgpu_ras_ecc_log_fini(struct ras_ecc_log_info *ecc_log)
@@ -2823,7 +2824,8 @@ static void amdgpu_ras_ecc_log_fini(struct ras_ecc_log_info *ecc_log)
 	mutex_unlock(&ecc_log->lock);
 
 	mutex_destroy(&ecc_log->lock);
-	ecc_log->de_updated = false;
+	ecc_log->de_queried_count = 0;
+	ecc_log->prev_de_queried_count = 0;
 }
 #endif
 
@@ -2856,40 +2858,64 @@ static void amdgpu_ras_do_page_retirement(struct work_struct *work)
 	mutex_unlock(&con->umc_ecc_log.lock);
 }
 
-static void amdgpu_ras_poison_creation_handler(struct amdgpu_device *adev,
-				uint32_t timeout_ms)
+static int amdgpu_ras_poison_creation_handler(struct amdgpu_device *adev,
+				uint32_t poison_creation_count)
 {
 	int ret = 0;
 	struct ras_ecc_log_info *ecc_log;
 	struct ras_query_if info;
-	uint32_t timeout = timeout_ms;
+	uint32_t timeout = 0;
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+	uint64_t de_queried_count;
+	uint32_t new_detect_count, total_detect_count;
+	uint32_t need_query_count = poison_creation_count;
+	bool query_data_timeout = false;
 
 	memset(&info, 0, sizeof(info));
 	info.head.block = AMDGPU_RAS_BLOCK__UMC;
 
 	ecc_log = &ras->umc_ecc_log;
-	ecc_log->de_updated = false;
+	total_detect_count = 0;
 	do {
 		ret = amdgpu_ras_query_error_status(adev, &info);
-		if (ret) {
-			dev_err(adev->dev, "Failed to query ras error! ret:%d\n", ret);
-			return;
+		if (ret)
+			return ret;
+
+		de_queried_count = ecc_log->de_queried_count;
+		if (de_queried_count > ecc_log->prev_de_queried_count) {
+			new_detect_count = de_queried_count - ecc_log->prev_de_queried_count;
+			ecc_log->prev_de_queried_count = de_queried_count;
+			timeout = 0;
+		} else {
+			new_detect_count = 0;
 		}
 
-		if (timeout && !ecc_log->de_updated) {
-			msleep(1);
-			timeout--;
+		if (new_detect_count) {
+			total_detect_count += new_detect_count;
+		} else {
+			if (!timeout && need_query_count)
+				timeout = MAX_UMC_POISON_POLLING_TIME_ASYNC;
+
+			if (timeout) {
+				if (!--timeout) {
+					query_data_timeout = true;
+					break;
+				}
+				msleep(1);
+			}
 		}
-	} while (timeout && !ecc_log->de_updated);
+	} while (total_detect_count < need_query_count);
 
-	if (timeout_ms && !timeout) {
-		dev_warn(adev->dev, "Can't find deferred error\n");
-		return;
+	if (query_data_timeout) {
+		dev_warn(adev->dev, "Can't find deferred error! count: %u\n",
+			(need_query_count - total_detect_count));
+		return -ENOENT;
 	}
 
-	if (!ret)
+	if (total_detect_count)
 		schedule_delayed_work(&ras->page_retirement_dwork, 0);
+
+	return 0;
 }
 
 static int amdgpu_ras_poison_consumption_handler(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 83437fef9df5..748bbac666e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -469,7 +469,8 @@ struct ras_ecc_log_info {
 	struct mutex lock;
 	siphash_key_t ecc_key;
 	struct radix_tree_root de_page_tree;
-	bool	de_updated;
+	uint64_t	de_queried_count;
+	uint64_t	prev_de_queried_count;
 };
 
 struct amdgpu_ras {
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 6d6350f220b0..0faa21d8a7b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -557,7 +557,7 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
 	ret = amdgpu_umc_logs_ecc_err(adev, &con->umc_ecc_log.de_page_tree, ecc_err);
 	if (ret) {
 		if (ret == -EEXIST)
-			con->umc_ecc_log.de_updated = true;
+			con->umc_ecc_log.de_queried_count++;
 		else
 			dev_err(adev->dev, "Fail to log ecc error! ret:%d\n", ret);
 
@@ -566,7 +566,7 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
 		return ret;
 	}
 
-	con->umc_ecc_log.de_updated = true;
+	con->umc_ecc_log.de_queried_count++;
 
 	return 0;
 }
-- 
2.34.1

