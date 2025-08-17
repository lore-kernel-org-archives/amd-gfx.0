Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D0ECA0EDC
	for <amd-gfx@archiver.kernel.org>; Sun, 17 Aug 2025 09:14:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABE1A10E0D1;
	Sun, 17 Aug 2025 09:14:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j+XzH7Tv";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C29A10E0D1
 for <amd-gfx@lists.freedesktop.org>; Sun, 17 Aug 2025 09:14:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lCQTsylHcZQSmmvrZTacELGdmNS/tdjVBqLSP0H9WK0SOXjrUJyUxkmA21AegPx4aieZHqdGUpBQD5AdF+ioNSX9ONr3grzwVOnrnyQfr2hFlYgUSHHWUQgnlbAQ6SJKStIc0KlZTb1En4Lmqr7mYj5xSyNFMBF8WvIjDc8GMD/+Rn2dRtZFjHyfd4BZV+YbPqCiRM6umIHL1zm65Zr9Rx7MVKA6n1nV/+kCSJkDVU3xG5rD8Kq1lJN27TIP1YYK20UrsVq6bRwubsMpL4YrxBHNlBjc+9K3d/aL6pjWF8D7UTbAK+IWD2LyUqDPe51i7X5Tcw5omYTB/n3HWaf0Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oSVdhzslpaSZBvwxHOshH+fOIZz5vTxt/Aid7fiNSQw=;
 b=PEDTiFoELetNS4D6xgvs4pX0XnMNBG/YZiKhQxeO3YmtGlZIdeLK+jCOpEWhjoY+sLZjekMKggTpCCLkYOVUYRbTkttbW2ATBzJYPTmeUt2kt0x8bxYtLNJxBfU7zZN2opztlrzVrPKGGtfozVZNgUAbyAjfq8DVGMpze7zbAAHylK97uBQHPg8UnGt22D4WLym/2DM0tuSPjJoDoJvmRnPV1P+j3oak5kwKy5bCo/xXOxYgYWqytQuJJeih/y+hTQtLunQKknehjspG08THwV0aM2YTKROigz8WZWt2vi6uTvDGeH15wugxeywusSHtErtPBpkIcMZiwMBQYxkGAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSVdhzslpaSZBvwxHOshH+fOIZz5vTxt/Aid7fiNSQw=;
 b=j+XzH7TvMT+nXEHcL/p73cFP04gFynfxInz1mLr1VRtITthlpUR2zWAy1lseiYq46l//t1HZ7oMQ0PZcbAU7WLTLuoDFqaZnW1DJHEE5Nj6AQsv9B2wMKFMo/9vbh8vynFhDda9GvhDlSLg+/p1MG++6Sh9+loF+ULTLcavg/zY=
Received: from SJ0PR13CA0024.namprd13.prod.outlook.com (2603:10b6:a03:2c0::29)
 by SA5PPF9176ED2F1.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.23; Sun, 17 Aug
 2025 09:14:01 +0000
Received: from BY1PEPF0001AE18.namprd04.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::2) by SJ0PR13CA0024.outlook.office365.com
 (2603:10b6:a03:2c0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.11 via Frontend Transport; Sun,
 17 Aug 2025 09:14:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BY1PEPF0001AE18.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Sun, 17 Aug 2025 09:14:00 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 17 Aug
 2025 04:13:57 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <Stanley.Yang@amd.com>, <Hawking.Zhang@amd.com>,
 <kevinyang.wang@amd.com>, <YiPeng.Chai@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH 4/4 v4] drm/amdgpu: Correct the loss of aca bank reg info
Date: Sun, 17 Aug 2025 17:13:47 +0800
Message-ID: <20250817091347.308839-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE18:EE_|SA5PPF9176ED2F1:EE_
X-MS-Office365-Filtering-Correlation-Id: d84a05ce-35e4-458c-1d9c-08dddd6e672d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tajrsKBOwiVRVFu4hrZToa2k6encODCa8ZHzZMCPTHnD0IBrQnqmHq4Y8wpw?=
 =?us-ascii?Q?w5bXNqiCo/BUnA+5/ehmp18wwm6Pnw5apfE4Gj5cOLRxBYhMiPGZ5S04NwFr?=
 =?us-ascii?Q?HpurynIjvLQt0uoQYuks1O545we7o7mrHXPic8MeHbqXAqPMApF1ngV7Q9v1?=
 =?us-ascii?Q?Uui/AfN6g9L31TNET0gugQ6NWHQ1BL8U4ffTIFXVPnyNm67+WHrsW5nxLSM1?=
 =?us-ascii?Q?u91qtf38dsehqRFRgjCcEtQz1jdn7h0HsFwXWh8mkisdS+Ai092akTfNsJxQ?=
 =?us-ascii?Q?k9tIdey+Rng6XA8jXwhPk7tbagFG6noavBjkALsWqMtGE91zTqjoIAXypnAX?=
 =?us-ascii?Q?54Tpa3f3pGG5kUfia3gOEBMmQY/qjr0Qiiu6+2VUQnf6uiaUEhyxgJfHvftx?=
 =?us-ascii?Q?ea1Y3lEgCmoB2gYcyZtT/VJ/dl+WrKKNqdONNYVJOwFKQpVABZI0Op/NKQc1?=
 =?us-ascii?Q?J3n07MhpmrrA++EWqcwomPfF9IJaKkinaGd5rh0OIbOf9wJAMXzMVOQ+fZLH?=
 =?us-ascii?Q?dvA2jSHxh4kJTBjato3uBxHDdySsaLZbx++QPBmEDFXVFyXNw0yE4piZndfB?=
 =?us-ascii?Q?U9GvY6KyAxcUMlmZ4UlvHPEjy5WHAHoZ7Au6/N+7m2pLbHH5Mv3P0G/O9lRv?=
 =?us-ascii?Q?8+7tiIgSZqpiKj8faDQBGP0yXupYmZFhp6PRg2tlQmDsBplbq6yX0X8NAFXK?=
 =?us-ascii?Q?cSIgixR23alLMQ26+sUEEJNPg5HjFp2Av3C3MYooMPSZo/ZJhqI9j293W8hs?=
 =?us-ascii?Q?1dIU6TAh2nEfeOdOSs7r8AwMnzF17Hq1xZ43PsMmMXP/H2NNlpgTI0DH4TJ5?=
 =?us-ascii?Q?T3VnCRPUHFV0VjOe/KPtoY2gDgtcThLWlLmWZTyuOGiMC7Zm7SvaYsoVqNFr?=
 =?us-ascii?Q?2trxtxED1plIpuKEz1WM2xfVy67udCzsU0uLNVBfoNBk5iOX514UMrcK8Bn4?=
 =?us-ascii?Q?BjbkOPYBGEkm6wVpH4NFtpdrEzb6D0oMrMpk412VNAvtELy3DGwhn62RHTTY?=
 =?us-ascii?Q?XSDSnyl/KJJlJDuGWlUxc+zRHxFGK4AJcogUBFhItcpoaPvVn7Yud0QCTOEJ?=
 =?us-ascii?Q?4yrviXfnO5FzshsM5UHa0oIn6bSi6V9v2nKmgS5rzaQNQhQ0bpShJH3s6mHh?=
 =?us-ascii?Q?CUZJu3le0sy8LSQqIWyPyFqykJvTXfUlX0QGho4AqPLd0Nia5mDv0SIxxhgb?=
 =?us-ascii?Q?+ZBPgwTVMlUv+fk3fwxLU1fZwX9IZEWmhScvQIueuKwtWeNjPjQgcXPInqaG?=
 =?us-ascii?Q?ztG01w8E9PDW+eh/HmXdf7Xgu0v8x3/6BdoUXXY1sLYTmWMEsyNmJrHKzRsa?=
 =?us-ascii?Q?sVpIRP6fiuI/UTA4JbLK9LXfBJ9gTtFI1ZX9QbY5Ip/2vBt11KqnpWtzoaUp?=
 =?us-ascii?Q?FvSFF3Srt/bpjpjN3Nv9SWTCGofDvX82USrPBSOD9sFGrFmuEAk3hn/Mw3LS?=
 =?us-ascii?Q?iUut4Zf+/HK+rWQnv97LUaOMzkNWHXd8HQHi225lH6flBldJpQ/1UA/OrBJ4?=
 =?us-ascii?Q?Q25JR2gKLHKcZMsYdlrdyPM+KIRf+ipObVcW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2025 09:14:00.2297 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d84a05ce-35e4-458c-1d9c-08dddd6e672d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE18.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF9176ED2F1
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

By polling, poll ACA bank count to ensure that valid
ACA bank reg info can be obtained

v2: add corresponding delay before send msg to SMU to query mca bank info.
(Stanley)

v3: the loop cannot exit. (Thomas)

v4: remove amdgpu_aca_clear_bank_count. (Kevin)

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 74 ++++++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c |  1 +
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  |  9 ++-
 4 files changed, 51 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 31850a47a41f..62d33843ecc3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -122,7 +122,7 @@ const char *get_ras_block_str(struct ras_common_if *ras_block)
 /* typical ECC bad page rate is 1 bad page per 100MB VRAM */
 #define RAS_BAD_PAGE_COVER              (100 * 1024 * 1024ULL)
 
-#define MAX_UMC_POISON_POLLING_TIME_ASYNC  300  //ms
+#define MAX_UMC_POISON_POLLING_TIME_ASYNC  1000
 
 #define AMDGPU_RAS_RETIRE_PAGE_INTERVAL 100  //ms
 
@@ -131,6 +131,8 @@ const char *get_ras_block_str(struct ras_common_if *ras_block)
 #define BYPASS_ALLOCATED_ADDRESS        0x0
 #define BYPASS_INITIALIZATION_ADDRESS   0x1
 
+#define MAX_BANK_COUNT 12
+
 enum amdgpu_ras_retire_page_reservation {
 	AMDGPU_RAS_RETIRE_PAGE_RESERVED,
 	AMDGPU_RAS_RETIRE_PAGE_PENDING,
@@ -3306,8 +3308,8 @@ static void amdgpu_ras_ecc_log_init(struct ras_ecc_log_info *ecc_log)
 	mutex_init(&ecc_log->lock);
 
 	INIT_RADIX_TREE(&ecc_log->de_page_tree, GFP_KERNEL);
-	ecc_log->de_queried_count = 0;
-	ecc_log->prev_de_queried_count = 0;
+	ecc_log->consumption_q_count = 0;
+	ecc_log->creation_de_count = 0;
 }
 
 static void amdgpu_ras_ecc_log_fini(struct ras_ecc_log_info *ecc_log)
@@ -3326,8 +3328,8 @@ static void amdgpu_ras_ecc_log_fini(struct ras_ecc_log_info *ecc_log)
 	mutex_unlock(&ecc_log->lock);
 
 	mutex_destroy(&ecc_log->lock);
-	ecc_log->de_queried_count = 0;
-	ecc_log->prev_de_queried_count = 0;
+	ecc_log->consumption_q_count = 0;
+	ecc_log->creation_de_count = 0;
 }
 #endif
 
@@ -3381,49 +3383,50 @@ static int amdgpu_ras_poison_creation_handler(struct amdgpu_device *adev,
 				uint32_t poison_creation_count)
 {
 	int ret = 0;
-	struct ras_ecc_log_info *ecc_log;
 	struct ras_query_if info;
-	uint32_t timeout = 0;
+	struct ras_ecc_log_info *ecc_log;
+	uint32_t timeout = MAX_UMC_POISON_POLLING_TIME_ASYNC;
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
-	uint64_t de_queried_count;
-	uint32_t new_detect_count, total_detect_count;
-	uint32_t need_query_count = poison_creation_count;
+	uint64_t creation_de_count = 0;
+	uint64_t consumption_q_count = 0;
 	enum ras_event_type type = RAS_EVENT_TYPE_POISON_CREATION;
+	uint64_t bank_count = 0;
+	uint32_t new_detect_count, total_detect_count;
+	uint64_t pre_bank_count = 0;
 
 	memset(&info, 0, sizeof(info));
 	info.head.block = AMDGPU_RAS_BLOCK__UMC;
-
 	ecc_log = &ras->umc_ecc_log;
-	total_detect_count = 0;
+
 	do {
 		ret = amdgpu_ras_query_error_status_with_event(adev, &info, type);
 		if (ret)
 			return ret;
-
-		de_queried_count = ecc_log->de_queried_count;
-		if (de_queried_count > ecc_log->prev_de_queried_count) {
-			new_detect_count = de_queried_count - ecc_log->prev_de_queried_count;
-			ecc_log->prev_de_queried_count = de_queried_count;
-			timeout = 0;
+		creation_de_count = ecc_log->creation_de_count;
+		consumption_q_count = ecc_log->consumption_q_count;
+
+		bank_count = amdgpu_aca_get_bank_count(adev);
+		if (bank_count > pre_bank_count) {
+			new_detect_count = bank_count - pre_bank_count;
+			pre_bank_count = bank_count;
+			total_detect_count += bank_count;
+			timeout = MAX_UMC_POISON_POLLING_TIME_ASYNC;
 		} else {
-			new_detect_count = 0;
+			--timeout;
+			msleep(1);
 		}
 
-		if (new_detect_count) {
-			total_detect_count += new_detect_count;
-		} else {
-			if (!timeout && need_query_count)
-				timeout = MAX_UMC_POISON_POLLING_TIME_ASYNC;
+		if (creation_de_count && consumption_q_count)
+			break;
 
-			if (timeout) {
-				if (!--timeout)
-					break;
-				msleep(1);
-			}
-		}
-	} while (total_detect_count < need_query_count);
+		if (total_detect_count >= MAX_BANK_COUNT)
+			break;
+	} while (timeout);
 
-	if (total_detect_count)
+	ecc_log->creation_de_count = 0;
+	ecc_log->consumption_q_count = 0;
+
+	if (creation_de_count)
 		schedule_delayed_work(&ras->page_retirement_dwork, 0);
 
 	return 0;
@@ -3516,7 +3519,7 @@ static int amdgpu_ras_page_retirement_thread(void *param)
 				atomic_sub(poison_creation_count, &con->poison_creation_count);
 				atomic_sub(poison_creation_count, &con->page_retirement_req_cnt);
 			}
-		} while (atomic_read(&con->poison_creation_count));
+		} while (atomic_read(&con->poison_creation_count) && !atomic_read(&con->poison_consumption_count));
 
 #ifdef HAVE_KFIFO_PUT_NON_POINTER
 		if (ret != -EIO) {
@@ -3534,6 +3537,7 @@ static int amdgpu_ras_page_retirement_thread(void *param)
 			/* gpu mode-1 reset is ongoing or just completed ras mode-1 reset */
 			/* Clear poison creation request */
 			atomic_set(&con->poison_creation_count, 0);
+			atomic_set(&con->poison_consumption_count, 0);
 
 			/* Clear poison fifo */
 			amdgpu_ras_clear_poison_fifo(adev);
@@ -3558,6 +3562,8 @@ static int amdgpu_ras_page_retirement_thread(void *param)
 				atomic_sub(msg_count, &con->page_retirement_req_cnt);
 			}
 
+			atomic_set(&con->poison_consumption_count, 0);
+
 			/* Wake up work to save bad pages to eeprom */
 			schedule_delayed_work(&con->page_retirement_dwork, 0);
 		}
@@ -3663,6 +3669,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev, bool init_bp_info)
 	init_waitqueue_head(&con->page_retirement_wq);
 	atomic_set(&con->page_retirement_req_cnt, 0);
 	atomic_set(&con->poison_creation_count, 0);
+	atomic_set(&con->poison_consumption_count, 0);
 	con->page_retirement_thread =
 		kthread_run(amdgpu_ras_page_retirement_thread, adev, "umc_page_retirement");
 	if (IS_ERR(con->page_retirement_thread)) {
@@ -3723,6 +3730,7 @@ static int amdgpu_ras_recovery_fini(struct amdgpu_device *adev)
 
 	atomic_set(&con->page_retirement_req_cnt, 0);
 	atomic_set(&con->poison_creation_count, 0);
+	atomic_set(&con->poison_consumption_count, 0);
 
 	mutex_destroy(&con->page_rsv_lock);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 6265dac0e1c0..f5797e53f966 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -492,8 +492,8 @@ struct ras_ecc_err {
 struct ras_ecc_log_info {
 	struct mutex lock;
 	struct radix_tree_root de_page_tree;
-	uint64_t	de_queried_count;
-	uint64_t	prev_de_queried_count;
+	uint64_t consumption_q_count;
+	uint64_t creation_de_count;
 };
 
 struct amdgpu_ras {
@@ -557,6 +557,7 @@ struct amdgpu_ras {
 	struct mutex page_retirement_lock;
 	atomic_t page_retirement_req_cnt;
 	atomic_t poison_creation_count;
+	atomic_t poison_consumption_count;
 	struct mutex page_rsv_lock;
 	DECLARE_KFIFO(poison_fifo, struct ras_poison_msg, 128);
 	struct ras_ecc_log_info  umc_ecc_log;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index bfc86f1e84e5..983a428eddd4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -254,6 +254,7 @@ int amdgpu_umc_pasid_poison_handler(struct amdgpu_device *adev,
 			if (!ret) {
 #endif
 				atomic_inc(&con->page_retirement_req_cnt);
+				atomic_inc(&con->poison_consumption_count);
 				wake_up(&con->page_retirement_wq);
 #ifdef HAVE_KFIFO_PUT_NON_POINTER
 			}
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index e590cbdd8de9..69c22bdaed3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -536,8 +536,11 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
 	hwid = REG_GET_FIELD(ipid, MCMP1_IPIDT0, HardwareID);
 	mcatype = REG_GET_FIELD(ipid, MCMP1_IPIDT0, McaType);
 
-	if ((hwid != MCA_UMC_HWID_V12_0) || (mcatype != MCA_UMC_MCATYPE_V12_0))
+	/* The IP block decode of consumption is SMU */
+	if ((hwid != MCA_UMC_HWID_V12_0) || (mcatype != MCA_UMC_MCATYPE_V12_0)) {
+		con->umc_ecc_log.consumption_q_count++;
 		return 0;
+	}
 
 	if (!status)
 		return 0;
@@ -582,7 +585,7 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
 	ret = amdgpu_umc_logs_ecc_err(adev, &con->umc_ecc_log.de_page_tree, ecc_err);
 	if (ret) {
 		if (ret == -EEXIST)
-			con->umc_ecc_log.de_queried_count++;
+			con->umc_ecc_log.creation_de_count++;
 		else
 			dev_err(adev->dev, "Fail to log ecc error! ret:%d\n", ret);
 
@@ -590,7 +593,7 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
 		return ret;
 	}
 
-	con->umc_ecc_log.de_queried_count++;
+	con->umc_ecc_log.creation_de_count++;
 
 	memset(page_pfn, 0, sizeof(page_pfn));
 	count = amdgpu_umc_lookup_bad_pages_in_a_row(adev,
-- 
2.34.1

