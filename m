Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE97AC2BB85
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 05:41:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5226810E2B3;
	Thu, 20 Jun 2024 05:41:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j2tcFUF9";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA89910E2B3
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 05:41:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VdflZJZqpu5k65V/mhT3trDc8D4ZHrKPavJ6psVWQSbPh0ztl30PhVCXnVOQAlznTzJaUkXBTQvOeIGFUMHgRZd6TVrsMEZ35gDdSdrFdtDFeCRzMnWz+gz6/eIQBLGrUlolhJ500WKwp5lixM5HTbfHjNO2+YvLZUCx3LI1YCenJ8fkkpxyFjW+o2NvMTzc7gVusHgMc7d8gmxvaZm8uvavzPlEzAYQjy5qb7aE0JARt84/YGkElZ6YJDfiiEbXas8lFON/y/UFe7dWs/oERx8dsNt4bxvu/GKA/jTsqlQRZUnRoWED9/Q5njuntvN86VJeEVGoDoKFyfkH/g3OSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hybsGgmQlwlbnH/ETmiMKi7E3P7jKUw0pvfKe0sAh1c=;
 b=FvFSvC3z8BWl+UH8KT1nv7/iYZ2Om3RrHLjhmLs9hFmJ3Sdq+5cUxz88sodXKYkK+JIUoUOCqEloZI3JrrcerwKcmojokcKmRba7s4EAg0A2Uk/+MRr9Aga8R9vI0xgNK3cYXtENoV62Qk5u47riWtlW7GNrKV7If57y6tRe50H+2qe6GdOq5ad5WWKHVAjYiAZyjv8xHP7BydtT3Y+/dYVoANJSL/rkbPbcTUXztMtANLY0k+TQ7x9tHIZtwNEfcLblMwPWniv9HOv201v13y+UK/2sAZY+NZ9AVvpYSGOa8LWTTFbpa0KEKUPF95KWQqM1fA6wCNCExjNaMd6Z+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hybsGgmQlwlbnH/ETmiMKi7E3P7jKUw0pvfKe0sAh1c=;
 b=j2tcFUF9PxVGwmX1WDGdewLx70tdpA4f/4ErQe7jLRA0v+v0bduuxG/zmQD5hspkKsJKi2yix1Ah+8mV5Wwz3jDayiScykjFH6DAKBONKK4oo7zRbg5vvEzugWUgFeDJ0362UORdxnTRHD9lvUqfKTK2qFO7b4iWyJFEdqnmTu8=
Received: from CH2PR10CA0022.namprd10.prod.outlook.com (2603:10b6:610:4c::32)
 by BY5PR12MB4196.namprd12.prod.outlook.com (2603:10b6:a03:205::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 05:41:23 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:610:4c:cafe::7c) by CH2PR10CA0022.outlook.office365.com
 (2603:10b6:610:4c::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Thu, 20 Jun 2024 05:41:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7719.0 via Frontend Transport; Thu, 20 Jun 2024 05:41:23 +0000
Received: from amd-02.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 00:41:20 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH V2 2/4] drm/amdgpu: refine poison creation interrupt handler
Date: Thu, 20 Jun 2024 13:40:18 +0800
Message-ID: <20240620054020.434523-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620054020.434523-1-YiPeng.Chai@amd.com>
References: <20240620054020.434523-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|BY5PR12MB4196:EE_
X-MS-Office365-Filtering-Correlation-Id: 20797d36-b091-4610-ecdb-08dc90eb9edd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|82310400023|1800799021|36860700010|376011; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2SgikW7OBloi0iv0dJrz5Iy8Ysb1BP97T6JwRSEnWo2rrMTisYemd2ngXKYN?=
 =?us-ascii?Q?doSNF73KfcZEv1nz3W5wSXPa2epHFlNsTmlsBAiNqGZ2fxW2e6D3wdDRbNp+?=
 =?us-ascii?Q?4uXK2IVSKp9hXXpvV6W6rgIrmqAHtkKL4cP/znytV1hOFBugzrjkEV4NlEe8?=
 =?us-ascii?Q?wKH5dC8jbzv/IZ9heocKe8JWFbVggRQlSwoROJUZrZ/NZBeNX8obXo4VYVpH?=
 =?us-ascii?Q?pBioEyx0UL1mO6Bd4QnYnIlu+5DvBqw9W/VZPX8q8sYwN4f4rqxOvBXjNf+6?=
 =?us-ascii?Q?yhEESXP3d/TG/rNkkVMxdQ/zsP5MSQAI3xGp/6zYri2T5hhTxYeLpK9wGimx?=
 =?us-ascii?Q?7n+O3UCrIAG4LGY//12omEUHEEaI4VUozZ21PzB6NOk/E8BQUVPCmHNXA6aa?=
 =?us-ascii?Q?6G+kyHfbxRpqOthg8370yKVBn/+yc4jcsfmKi4KXlMsxTMr2vCffMz5j3JOs?=
 =?us-ascii?Q?lmUKn1Ab3bvudzfRAXypt5Lc8uDo6cgmDSCEmC+XfkAjeSaf5fS6AV/Nun6z?=
 =?us-ascii?Q?H01CbvworQC1UaQxZZI319p94arVQaVYvqd8ejvoObxKxpRTkw1UwmLfuxDx?=
 =?us-ascii?Q?BynbBh0cx5FVX9Rp0DLFMw34eLnHE7+1LadbzZzK+yTOr1O3Kz68BVCzyHxO?=
 =?us-ascii?Q?VWJ9FZ5MkkkPD7joMqJ7D5rNsSg3xSQ6fAHIJ2z8EULAdKlfKFgf5GK+EzN3?=
 =?us-ascii?Q?c8m1JGgm00HswwNBJyuc4GizSBWc/ug0ooDfq595KVe//NH1+KWb65Itd2zJ?=
 =?us-ascii?Q?NCP61Nl0wxbPmMSzY9Mpyqcrj6FebFrR+m0MwSr6M9lVJvAzTENvH9dqUnCK?=
 =?us-ascii?Q?5v/j8AQCbcX5oqUxSP5BUgJJ9XlXKyTBpxbOF5+oB/zEh5G17eUmT7KF2/Ft?=
 =?us-ascii?Q?L2U24IruaYf17VMGRDPLPE32Gxo0R7rYNhl7AzvPgdsjqZqkYJmIEeXu9pnB?=
 =?us-ascii?Q?uiGQBEZBnuBUuxo44SVU0BiVCAOMIPp7B4xrvxia/+TMvBFPcPcVnt62EszV?=
 =?us-ascii?Q?i64qjzoOjCbmZlwhI0AXEFqTLeEuBYbJofXnphbcKCXehV8JSieEdmXO6bsM?=
 =?us-ascii?Q?LFDdwh+P/NkU7Lihs65ifOQzTujGK5qK5ytrgF+vf1ETXEIh7kAj0YuY5kRn?=
 =?us-ascii?Q?HLhFl35sTCEXqe3GKfTNyKVtUdjgMD/2H74E5SCmZgg3mTBlEVPhwh19QaOQ?=
 =?us-ascii?Q?d79xCqhQkhobAk8cBOVXXIiSNhcEPmDZmUnJEKa5GIWLBz9MsFfr60AELhNv?=
 =?us-ascii?Q?LnE+bS8Th71Wdy1wo6DD8m9TO1USzJFeLj9GpZKZqZ3OmsYoGXhn/7WhfSBF?=
 =?us-ascii?Q?lAqisrLbzxkMIZ1Kg23MRJWRNKp3u1MeyL8Rzk5M3zhG0Jn2+6q8rbRoT6gV?=
 =?us-ascii?Q?2TH/zr4NaZ0psoU5fyLANr1SAkR6mVYmIXciB73n4oZsx2k7CQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(82310400023)(1800799021)(36860700010)(376011); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 05:41:23.5888 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20797d36-b091-4610-ecdb-08dc90eb9edd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4196
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

In order to apply to the case where a large number
of ras poison interrupts:
1. Change to use variable to record poison creation
   requests to avoid fifo full.
2. Prioritize handling poison creation requests
   instead of following the order of requests
   received by the driver.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 37 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  1 +
 2 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index f674e34037b6..308348b4644f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2106,10 +2106,8 @@ static void amdgpu_ras_interrupt_poison_creation_handler(struct ras_manager *obj
 	if (amdgpu_ip_version(obj->adev, UMC_HWIP, 0) >= IP_VERSION(12, 0, 0)) {
 		struct amdgpu_ras *con = amdgpu_ras_get_context(obj->adev);
 
-		amdgpu_ras_put_poison_req(obj->adev,
-			AMDGPU_RAS_BLOCK__UMC, 0, NULL, NULL, false);
-
 		atomic_inc(&con->page_retirement_req_cnt);
+		atomic_inc(&con->poison_creation_count);
 
 		wake_up(&con->page_retirement_wq);
 	}
@@ -2945,6 +2943,8 @@ static int amdgpu_ras_page_retirement_thread(void *param)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)param;
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	uint32_t poison_creation_count;
+	int ret;
 	struct ras_poison_msg poison_msg;
 	enum amdgpu_ras_block ras_block;
 	bool poison_creation_is_handled = false;
@@ -2958,7 +2958,18 @@ static int amdgpu_ras_page_retirement_thread(void *param)
 		if (kthread_should_stop())
 			break;
 
-		atomic_dec(&con->page_retirement_req_cnt);
+
+		do {
+			poison_creation_count = atomic_read(&con->poison_creation_count);
+			ret = amdgpu_ras_poison_creation_handler(adev, poison_creation_count);
+			if (ret == -EIO)
+				break;
+
+			if (poison_creation_count) {
+				atomic_sub(poison_creation_count, &con->poison_creation_count);
+				atomic_sub(poison_creation_count, &con->page_retirement_req_cnt);
+			}
+		} while (atomic_read(&con->poison_creation_count));
 
 #ifdef HAVE_KFIFO_PUT_NON_POINTER
 		if (!amdgpu_ras_get_poison_req(adev, &poison_msg))
@@ -2969,24 +2980,8 @@ static int amdgpu_ras_page_retirement_thread(void *param)
 		dev_dbg(adev->dev, "Start processing ras block %s(%d)\n",
 				ras_block_str(ras_block), ras_block);
 
-		if (ras_block == AMDGPU_RAS_BLOCK__UMC) {
-			amdgpu_ras_poison_creation_handler(adev,
-				MAX_UMC_POISON_POLLING_TIME_ASYNC);
-			poison_creation_is_handled = true;
-		} else {
-			/* poison_creation_is_handled:
-			 *   false: no poison creation interrupt, but it has poison
-			 *          consumption interrupt.
-			 *   true: It has poison creation interrupt at the beginning,
-			 *         but it has no poison creation interrupt later.
-			 */
-			amdgpu_ras_poison_creation_handler(adev,
-					poison_creation_is_handled ?
-					0 : MAX_UMC_POISON_POLLING_TIME_ASYNC);
 
 			amdgpu_ras_poison_consumption_handler(adev, &poison_msg);
-			poison_creation_is_handled = false;
-		}
 #else
         dev_info(adev->dev, "Start processing page retirement. request:%d\n",
                     atomic_read(&con->page_retirement_req_cnt));
@@ -3066,6 +3061,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 	mutex_init(&con->page_retirement_lock);
 	init_waitqueue_head(&con->page_retirement_wq);
 	atomic_set(&con->page_retirement_req_cnt, 0);
+	atomic_set(&con->poison_creation_count, 0);
 	con->page_retirement_thread =
 		kthread_run(amdgpu_ras_page_retirement_thread, adev, "umc_page_retirement");
 	if (IS_ERR(con->page_retirement_thread)) {
@@ -3117,6 +3113,7 @@ static int amdgpu_ras_recovery_fini(struct amdgpu_device *adev)
 		kthread_stop(con->page_retirement_thread);
 
 	atomic_set(&con->page_retirement_req_cnt, 0);
+	atomic_set(&con->poison_creation_count, 0);
 
 	mutex_destroy(&con->page_rsv_lock);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 748bbac666e6..0fa1148e6642 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -532,6 +532,7 @@ struct amdgpu_ras {
 	wait_queue_head_t page_retirement_wq;
 	struct mutex page_retirement_lock;
 	atomic_t page_retirement_req_cnt;
+	atomic_t poison_creation_count;
 	struct mutex page_rsv_lock;
 	DECLARE_KFIFO(poison_fifo, struct ras_poison_msg, 128);
 	struct ras_ecc_log_info  umc_ecc_log;
-- 
2.34.1

