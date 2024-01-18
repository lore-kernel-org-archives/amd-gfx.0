Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41994C4707B
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 06:44:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF55510E14D;
	Thu, 18 Jan 2024 06:44:15 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C4C210E14D
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 06:44:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHHstJLQNtdd+d5M0SonscRSdld2i/Ebb9y7tioyo2XI8q29O3/1zukt4hJiuoAzcGLh1744nrMPtSQlaUKwECGIWlH1Wy0JNwyTUAYc/1U2nADUOQ6+tIb4mWMK85xIrkonnzTJCV7R2VZeBVZS6vuEtL6SpkTxl4tkGRDzOYdtHv+ZuwSBQDfeRBUVxsSEaWvQw0E6pAoWrUuQ3nVJAlllV2XG7/7vtkKSZHtOt9dYi5vVWo4kV2ooRecZ3VDAignchaw0wb/ZARFnmpbn7uskAyKHLY5dek2MYUNmTmdvy/QYbci6Ei9uthDLElKoT07UaGb8pz74+bEiWAOpdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hbzu8P32bSQ6Ds21brBz4jvifdOE7MwEyWxgURPwgdI=;
 b=L5yU9CMcfkLiSjbVGxnZCx99jVU6/TFfsaXe/siXWL8hucbocPHXHu7xyk7e0NspxnQgELOABHSlGZO38aW2W0Zo1vaiRYcOWTwJMxzYTYGAMeqpMJzXJOrjVtILQdIHce9DBAKLmYx4N2Q1w1DeNGTwE64DAhAcTvQSoknOsxXe4MWBOBwZFDQ5r2AYkyD+evaJ6n/FlWB5wyC4SrI+n72ceTwAgHJsTlN8z/0wW4CPMjaszlrjxHfpYaIBdVz6en3eyG8pxypgxWXf/jF5l3ELMrc6AS29mKdm+qh2qGspQiisqcZdPkM8chszA1LVNMinKS1Q2vgDZKo7WReMZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hbzu8P32bSQ6Ds21brBz4jvifdOE7MwEyWxgURPwgdI=;
 b=dblnZIFjmT85M4ebbl8+WZzGBprbEGZTIvgPL6xbLE0o20efEN22VSgYYzhCOfgmV5q1cyG5POOoF8YI/92eyhpXu5+R/+QLZAn7iy7+7nb89r+GgFBP1Oe9gNMNSY5u1BJDwL8YNiXalgMt7GhLp2MakH0IlSJv7JlDtAjUe1w=
Received: from SN1PR12CA0062.namprd12.prod.outlook.com (2603:10b6:802:20::33)
 by SJ0PR12MB5612.namprd12.prod.outlook.com (2603:10b6:a03:427::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.31; Thu, 18 Jan
 2024 06:43:59 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:802:20:cafe::e7) by SN1PR12CA0062.outlook.office365.com
 (2603:10b6:802:20::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.30 via Frontend
 Transport; Thu, 18 Jan 2024 06:43:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 06:43:59 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 00:43:36 -0600
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 3/5] drm/amdgpu: Use asynchronous polling to handle
 umc_v12_0 poisoning
Date: Thu, 18 Jan 2024 14:42:55 +0800
Message-ID: <20240118064257.1951585-3-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118064257.1951585-1-YiPeng.Chai@amd.com>
References: <20240118064257.1951585-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|SJ0PR12MB5612:EE_
X-MS-Office365-Filtering-Correlation-Id: baafa656-03fc-4904-b2f2-08dc17f0d9ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r6mYovic08uxFW+RDpO8pC/nzL7T0XYQ+8yTa/ijO3J4NPpSujIL0ysTUnDZAl2PerSgPnVMJv0dVFnfSW/fUd9qn4S8pnaVtggXn9Go96TT6aH5jJy4v+uWT8sKxQEeqkT9B3SULapv/qKkKSar+Heal34OCkZNa3TLMgMcJfsueeC+1srGqNzh4ENwuOu6sBV193FnxghF1QbEjagUjIJ1sU4eZGlH5sYKaHlIO+jS7JQqRlzRkTIMlXkiMfrfMeRC87pJ+rJ8i27GWK3kHDesGZAPYUD2A13cNcfWcz3R5ewBKRwj2T3CEJSFZ4p1oDHpsSbkGqkSvj3XsbtgmhxKccm0/lWYdp8vXlmwbBbUfEhFMaA5D5OCmHifwMf8uHRsmRFVTOa0yu32fDafSAfoYd/Fo2TBHu7/4kXONceucD1u2jLTgrnLTMP7rxhBL8kXHXagACgAVk3uvzQE2dqeA4C6OuztMTWVu6c2x/TEqdyNYQYGoxXA28Ud37IBsSzi843j3zurZxZ79j6Rg5qtDf0+/iJYO24rNL5ekEqQ7XH0gu0OFPYJ4oCD7x84G1clkEX+gITfAXiQAm8SvJgDpjhi3OsvV2OP9yLx/VCytS9PeSq6DAJtFKKXwBWRoFZweKFabe6O9xtWpoatlCXAd0iLZzR/p+rCxw5vtMj1dr/VlG5Zc0lsG3Z7DN+2upK1rfWOrHsDKj8BZQquoDkCBYBuyudbpn/pkb7pcC9EfVfA8/Ekh3APUD8/qiMD8ihBUFXx9b+HAoY4uoKk3w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(186009)(82310400011)(451199024)(1800799012)(46966006)(36840700001)(40470700004)(40460700003)(40480700001)(26005)(336012)(16526019)(83380400001)(426003)(86362001)(36756003)(82740400003)(1076003)(81166007)(356005)(8676002)(5660300002)(4326008)(8936002)(7696005)(2616005)(47076005)(36860700001)(70206006)(54906003)(70586007)(316002)(41300700001)(6916009)(6666004)(2906002)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 06:43:59.0993 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: baafa656-03fc-4904-b2f2-08dc17f0d9ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5612
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
Cc: KevinYang.Wang@amd.com, Tao.Zhou1@amd.com,
 YiPeng Chai <YiPeng.Chai@amd.com>, Stanley.Yang@amd.com, yipechai@amd.com,
 Candice.Li@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use asynchronous polling to handle umc_v12_0 poisoning.

v2:
  1. Change function name.
  2. Change the debugging information content.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 139 ++++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |   3 +
 3 files changed, 116 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 856206e95842..61a02dbac087 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -118,6 +118,8 @@ const char *get_ras_block_str(struct ras_common_if *ras_block)
 /* typical ECC bad page rate is 1 bad page per 100MB VRAM */
 #define RAS_BAD_PAGE_COVER              (100 * 1024 * 1024ULL)
 
+#define MAX_UMC_POISON_POLLING_TIME_ASYNC  100  //ms
+
 enum amdgpu_ras_retire_page_reservation {
 	AMDGPU_RAS_RETIRE_PAGE_RESERVED,
 	AMDGPU_RAS_RETIRE_PAGE_PENDING,
@@ -2670,6 +2672,9 @@ static int amdgpu_ras_page_retirement_thread(void *param)
 			atomic_read(&con->page_retirement_req_cnt));
 
 		atomic_dec(&con->page_retirement_req_cnt);
+
+		amdgpu_umc_bad_page_polling_timeout(adev,
+				false, MAX_UMC_POISON_POLLING_TIME_ASYNC);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 9d1cf41cf483..83983f0e8eb5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -23,6 +23,7 @@
 
 #include "amdgpu.h"
 #include "umc_v6_7.h"
+#define MAX_UMC_POISON_POLLING_TIME_SYNC   20  //ms
 
 static int amdgpu_umc_convert_error_address(struct amdgpu_device *adev,
 				    struct ras_err_data *err_data, uint64_t err_addr,
@@ -85,17 +86,14 @@ int amdgpu_umc_page_retirement_mca(struct amdgpu_device *adev,
 	return ret;
 }
 
-static int amdgpu_umc_do_page_retirement(struct amdgpu_device *adev,
-		void *ras_error_status,
-		struct amdgpu_iv_entry *entry,
-		bool reset)
+static void amdgpu_umc_handle_bad_pages(struct amdgpu_device *adev,
+			void *ras_error_status)
 {
 	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	int ret = 0;
 	unsigned long err_count;
-
-	kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
+	mutex_lock(&con->page_retirement_lock);
 	ret = amdgpu_dpm_get_ecc_info(adev, (void *)&(con->umc_ecc));
 	if (ret == -EOPNOTSUPP) {
 		if (adev->umc.ras && adev->umc.ras->ras_block.hw_ops &&
@@ -163,19 +161,85 @@ static int amdgpu_umc_do_page_retirement(struct amdgpu_device *adev,
 				con->update_channel_flag = false;
 			}
 		}
-
-		if (reset) {
-			/* use mode-2 reset for poison consumption */
-			if (!entry)
-				con->gpu_reset_flags |= AMDGPU_RAS_GPU_RESET_MODE2_RESET;
-			amdgpu_ras_reset_gpu(adev);
-		}
 	}
 
 	kfree(err_data->err_addr);
+
+	mutex_unlock(&con->page_retirement_lock);
+}
+
+static int amdgpu_umc_do_page_retirement(struct amdgpu_device *adev,
+		void *ras_error_status,
+		struct amdgpu_iv_entry *entry,
+		bool reset)
+{
+	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+
+	kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
+	amdgpu_umc_handle_bad_pages(adev, ras_error_status);
+
+	if (err_data->ue_count && reset) {
+		/* use mode-2 reset for poison consumption */
+		if (!entry)
+			con->gpu_reset_flags |= AMDGPU_RAS_GPU_RESET_MODE2_RESET;
+		amdgpu_ras_reset_gpu(adev);
+	}
+
 	return AMDGPU_RAS_SUCCESS;
 }
 
+int amdgpu_umc_bad_page_polling_timeout(struct amdgpu_device *adev,
+			bool reset, uint32_t timeout_ms)
+{
+	struct ras_err_data err_data;
+	struct ras_common_if head = {
+		.block = AMDGPU_RAS_BLOCK__UMC,
+	};
+	struct ras_manager *obj = amdgpu_ras_find_obj(adev, &head);
+	uint32_t timeout = timeout_ms;
+
+	memset(&err_data, 0, sizeof(err_data));
+	amdgpu_ras_error_data_init(&err_data);
+
+	do {
+
+		amdgpu_umc_handle_bad_pages(adev, &err_data);
+
+		if (timeout && !err_data.de_count) {
+			msleep(1);
+			timeout--;
+		}
+
+	} while (timeout && !err_data.de_count);
+
+	if (!timeout)
+		dev_warn(adev->dev, "Can't find bad pages\n");
+
+	if (err_data.de_count)
+		dev_info(adev->dev, "%ld new deferred hardware errors detected\n", err_data.de_count);
+
+	if (obj) {
+		obj->err_data.ue_count += err_data.ue_count;
+		obj->err_data.ce_count += err_data.ce_count;
+		obj->err_data.de_count += err_data.de_count;
+	}
+
+	amdgpu_ras_error_data_fini(&err_data);
+
+	kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
+
+	if (reset) {
+		struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+
+		/* use mode-2 reset for poison consumption */
+		con->gpu_reset_flags |= AMDGPU_RAS_GPU_RESET_MODE2_RESET;
+		amdgpu_ras_reset_gpu(adev);
+	}
+
+	return 0;
+}
+
 int amdgpu_umc_poison_handler(struct amdgpu_device *adev, bool reset)
 {
 	int ret = AMDGPU_RAS_SUCCESS;
@@ -193,25 +257,38 @@ int amdgpu_umc_poison_handler(struct amdgpu_device *adev, bool reset)
 	}
 
 	if (!amdgpu_sriov_vf(adev)) {
-		struct ras_err_data err_data;
-		struct ras_common_if head = {
-			.block = AMDGPU_RAS_BLOCK__UMC,
-		};
-		struct ras_manager *obj = amdgpu_ras_find_obj(adev, &head);
-
-		ret = amdgpu_ras_error_data_init(&err_data);
-		if (ret)
-			return ret;
-
-		ret = amdgpu_umc_do_page_retirement(adev, &err_data, NULL, reset);
-
-		if (ret == AMDGPU_RAS_SUCCESS && obj) {
-			obj->err_data.ue_count += err_data.ue_count;
-			obj->err_data.ce_count += err_data.ce_count;
-			obj->err_data.de_count += err_data.de_count;
-		}
+		if (amdgpu_ip_version(adev, UMC_HWIP, 0) < IP_VERSION(12, 0, 0)) {
+			struct ras_err_data err_data;
+			struct ras_common_if head = {
+				.block = AMDGPU_RAS_BLOCK__UMC,
+			};
+			struct ras_manager *obj = amdgpu_ras_find_obj(adev, &head);
+
+			ret = amdgpu_ras_error_data_init(&err_data);
+			if (ret)
+				return ret;
 
-		amdgpu_ras_error_data_fini(&err_data);
+			ret = amdgpu_umc_do_page_retirement(adev, &err_data, NULL, reset);
+
+			if (ret == AMDGPU_RAS_SUCCESS && obj) {
+				obj->err_data.ue_count += err_data.ue_count;
+				obj->err_data.ce_count += err_data.ce_count;
+				obj->err_data.de_count += err_data.de_count;
+			}
+
+			amdgpu_ras_error_data_fini(&err_data);
+		} else {
+			if (reset) {
+				amdgpu_umc_bad_page_polling_timeout(adev,
+							reset, MAX_UMC_POISON_POLLING_TIME_SYNC);
+			} else {
+				struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+
+				atomic_inc(&con->page_retirement_req_cnt);
+
+				wake_up(&con->page_retirement_wq);
+			}
+		}
 	} else {
 		if (adev->virt.ops && adev->virt.ops->ras_poison_handler)
 			adev->virt.ops->ras_poison_handler(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index 417a6726c71b..de2dc1853636 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -118,4 +118,7 @@ int amdgpu_umc_page_retirement_mca(struct amdgpu_device *adev,
 
 int amdgpu_umc_loop_channels(struct amdgpu_device *adev,
 			umc_func func, void *data);
+
+int amdgpu_umc_bad_page_polling_timeout(struct amdgpu_device *adev,
+			bool reset, uint32_t timeout_ms);
 #endif
-- 
2.34.1

