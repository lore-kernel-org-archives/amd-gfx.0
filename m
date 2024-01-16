Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 960C2C47077
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jan 2024 08:21:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21F9D10E41E;
	Tue, 16 Jan 2024 08:21:30 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3138910E41E
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jan 2024 08:21:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LbaQCsvnHteS11F61/N7C5Wy8LX4IMJBvylwQe98kqkRveT8zn9I0Lsm7QVjT8kEhI0mv3Uirxz4z63evwroO2ro8yJ9IifbHmHZMe6fTVjiGaX6XAtskMS8CTWyxNbv0fQW8IM/+qGK9IlRKKGsJcBlmTMVagHEMwGmUnJt8vOAHn60/VsfBg/lVCFdkd7Q15DYZuQdgkDaMx+WJRxemp+KXKOAEHetwqXQteIV4MBsOeWg7kbVfHcJwZguJUWQvPpzs0hXYVxu1mELH+McBvrWxYmwuSOlal2DeXyDbM5fUJqn2fi7aQGbjcp5KbtNIxg+bPdOMHNKWndhZ8r/Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hOsbGVSVLH7AFii2cOPlkvq9xDy4K18g21efqUo6tz0=;
 b=iB+yMOR1HA9FXDW8Wq8zQJvYJ6KK7+xClXt484rfCJxwXifyDgE8snIQrkj7xG4G99lZqr98aBE6ZzcN8qyQfd83Pqqa4JIh9CtDFiKEdYOxO/TrnId/5OQzWnaLBgl6CoTss4JBg5hZih9rFANBTxnUYO0MTPtbxmB+YphXYIMcqe2sMQ98iK8YvqhbVjqG8vRRvQ8wYh3wJcxDJrmM+b9Z4Csipu4QBz1ebMliBDBaEk0JL+1j8UVRKo2y93TwlxV9XkL/RMjOD9U8pAoB9dk1XZctO5GqVyHDziY09GPTtutEfDjxd9mACttII91woSdjKibLES/MiLNDlgHyxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOsbGVSVLH7AFii2cOPlkvq9xDy4K18g21efqUo6tz0=;
 b=jIBHbvpes8B39m2WeS3gxtafsOE+VO3WCo4WeJamRxMalAz1jFfcJJWwZx0C8jweVDVjs+BGO1Gfy8UQRSSZLNLRYzgWMH7NTWKozR20gwQphsYOJ+y73NlafMhcG6aAnrkCjL19sYMbND4Z1UiGEIzyMj5VIuUQco2A57O3WRc=
Received: from MN2PR05CA0064.namprd05.prod.outlook.com (2603:10b6:208:236::33)
 by CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Tue, 16 Jan
 2024 08:21:16 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:236:cafe::c1) by MN2PR05CA0064.outlook.office365.com
 (2603:10b6:208:236::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.19 via Frontend
 Transport; Tue, 16 Jan 2024 08:21:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 16 Jan 2024 08:21:16 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 16 Jan
 2024 02:21:13 -0600
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/5] drm/amdgpu: Use asynchronous polling to handle umc_v12_0
 poisoning
Date: Tue, 16 Jan 2024 16:20:32 +0800
Message-ID: <20240116082034.1739848-3-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240116082034.1739848-1-YiPeng.Chai@amd.com>
References: <20240116082034.1739848-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|CH3PR12MB8728:EE_
X-MS-Office365-Filtering-Correlation-Id: e8d65318-4546-4b92-b2c7-08dc166c1c27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: quQhGXHKJQt3CkKn/wc+AOMPyJyjhDv0Dbm6JbPUilfqGp4UbeQ/0+UHFZ7xzMIrqRUKtMv9/H4uJEMeWmog22nCPvlukW9ItgYfxXTJHKNvgw3O4f1dOcEXiimA4sf+Tx1QGjvtFdSScyeS6x/ZC+F7LqKqqvPtrI649Mrz7AjF9QmtNS8U5nVFBywCigFBQaeftoUsZzXJ7T2XNXwatGAm+H3KkuedyfHMpOauSoFVKssJz/iek61K3B/QBq40QveR86kO5w/c0KEpm41lqZsx+6f7J+k9E4+HgcSAPFsLHckc1HUqVhvT54Z/w43IF6uprzDWFvRWl4SmsheRE6lTxXFyrgdEPNy+GBj1l6qqvtr1Tdbsyip/Vn1ZG1FAoUuiYLDQdSGEoFv4FGRmDO8H3OKItCpyz9PtTkezUzwJf/PT/LkgP/63nFNQPVhx8DZFzgF2XXqMTDaC9pEL/WhBnW2LOJ2kNJFZ2q/5FEGyiSfkWc4xx/cHLt6IkAXsV6B+mKQyB9GFSjKMwsU856xo8VDKtI/IUiD5/T+8BjoUnZPvxBbe5sDfmXxueFeJePVqwkfBgjphRfuMF1K5mRHOdTsC5SKygaN6eznPS0rb1rkWBRpSZKEZ/jXTlvjABO2Eq0lwTjTziGRrNqxxamltLe42pyKkzr1O8ZGmrOITWTe7P7FnpOLL+emaVgAeeM0pLrC2Q3apsC4UWKZIU2WjwEJjzmUI/Rj5AzRBzqCJEE+ZbeWhQfPOa6jHPxv8XH9WxcICsDrOGIFfyuT+ZA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(82310400011)(46966006)(40470700004)(36840700001)(86362001)(47076005)(83380400001)(36860700001)(426003)(2616005)(1076003)(16526019)(26005)(336012)(81166007)(82740400003)(356005)(41300700001)(54906003)(70206006)(70586007)(316002)(6916009)(5660300002)(8676002)(2906002)(8936002)(4326008)(6666004)(7696005)(478600001)(36756003)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 08:21:16.4098 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d65318-4546-4b92-b2c7-08dc166c1c27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8728
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

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 143 +++++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |   3 +
 3 files changed, 120 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 856206e95842..44929281840e 100644
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
+		amdgpu_umc_poison_retire_page_polling_timeout(adev,
+				false, MAX_UMC_POISON_POLLING_TIME_ASYNC);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 9d1cf41cf483..2dde29cb807d 100644
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
@@ -163,19 +161,86 @@ static int amdgpu_umc_do_page_retirement(struct amdgpu_device *adev,
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
 
+int amdgpu_umc_poison_retire_page_polling_timeout(struct amdgpu_device *adev,
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
+		dev_warn(adev->dev, "Page retirment executed, but did not find bad pages\n");
+
+	if (err_data.de_count)
+		dev_info(adev->dev, "Page retirment: ue:%ld, ce:%ld, de:%ld\n",
+				err_data.ue_count, err_data.ce_count, err_data.de_count);
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
@@ -193,25 +258,41 @@ int amdgpu_umc_poison_handler(struct amdgpu_device *adev, bool reset)
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
+		if (amdgpu_ip_version(adev, UMC_HWIP, 0) != IP_VERSION(12, 0, 0)) {
+			struct ras_err_data err_data;
+			struct ras_common_if head = {
+				.block = AMDGPU_RAS_BLOCK__UMC,
+			};
+			struct ras_manager *obj = amdgpu_ras_find_obj(adev, &head);
+
+			ret = amdgpu_ras_error_data_init(&err_data);
+			if (ret)
+				return ret;
+
+			ret = amdgpu_umc_do_page_retirement(adev, &err_data, NULL, reset);
 
-		amdgpu_ras_error_data_fini(&err_data);
+			if (ret == AMDGPU_RAS_SUCCESS && obj) {
+				obj->err_data.ue_count += err_data.ue_count;
+				obj->err_data.ce_count += err_data.ce_count;
+				obj->err_data.de_count += err_data.de_count;
+			}
+
+			amdgpu_ras_error_data_fini(&err_data);
+		} else {
+			if (reset) {
+				amdgpu_umc_poison_retire_page_polling_timeout(adev,
+							reset, MAX_UMC_POISON_POLLING_TIME_SYNC);
+			} else {
+				struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+
+				dev_info(adev->dev, "Page retirement pending request count: %d\n",
+				atomic_read(&con->page_retirement_req_cnt));
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
index 417a6726c71b..ee487adce7e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -118,4 +118,7 @@ int amdgpu_umc_page_retirement_mca(struct amdgpu_device *adev,
 
 int amdgpu_umc_loop_channels(struct amdgpu_device *adev,
 			umc_func func, void *data);
+
+int amdgpu_umc_poison_retire_page_polling_timeout(struct amdgpu_device *adev,
+			bool reset, uint32_t timeout_ms);
 #endif
-- 
2.34.1

