Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EAE0C2BA1A
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jun 2024 06:34:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A858110E585;
	Tue, 18 Jun 2024 06:34:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eQV1OcZ9";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C6E410E586
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 06:34:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqEBDziNOkA8PNF7ac1WWoqvNSAa3M7+jaoXGXOYXuRWZWhXEmI/sV/Bu//lsUsHxf6185DdsCp8j4KuiUJerS4Jay4/vWxwV9FB9PaI28mNTDMWQjaQKrMYICmNBrXlBaq3TBbDEbuzXPE82o3E7vp88a26E5j5wiJsS4xhQi/7g+RrDwxjzyMhn0/r5z5xxpSo5JswmkrExRJAizjWVKXGLQftbTeslbLIP6YCAztWtl1XPK44maCJKmJBfh0/M/Pj+E5E+axg91qLX8y++J3SIlYORxRQPLB6LJDAWoWLlYj/S7Z5itc0HGlvx0hLF2AHCbh6uqEWNblDvibYEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8JZdON4LwXm7Q2JryKDnWabiKngmx6a2NdUqbgQTFI=;
 b=RNBDVLuBDIlqDmuEQyxrFBXOh/uPEeSUfEIuY13rVtLkPpBi6FJP0H0JnOViU5bQqy5BGPi890GiGOp9FOfzQeZsQ3WHBfXTob14rThMv3NCO9xrv9QqGCvw0OqI2AQzpH+kT1HDAUW/4lQ3cy6S2Pw+AgAIE95l+HNmGonGp/sNXl0F+W+4h2nwkHr/X6gPaIDhKXCFCbtEbsVsFgWtOfMd8fQCsstwdOBngTaGdRa0ktmVDAjBruMBeOTLGw6lrMZoyUWaE+mCOXcHEdUGzQ0OZkiTH220qwhFceIsKkYZO6pO7NjnkHyj9DeegsZGmrxIXPY5+phscDXTad9fjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8JZdON4LwXm7Q2JryKDnWabiKngmx6a2NdUqbgQTFI=;
 b=eQV1OcZ9PevF1EchmH0+0cud1++RV9eHpC3LhMjrN6yH3w26HNwZom5lMgoTNDvJ7eoEPdtqEGfySGwvJo1T9ufOTsw/Ry9ev7VN0/4kyJN/JztSRs90VCKluJ/Da0nlAlJvmOq6qwRnGUY7W/H/82PlIX7DJLW1pbyD8QgVFqA=
Received: from SA0PR11CA0084.namprd11.prod.outlook.com (2603:10b6:806:d2::29)
 by IA0PR12MB7721.namprd12.prod.outlook.com (2603:10b6:208:433::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 06:34:34 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:806:d2:cafe::b4) by SA0PR11CA0084.outlook.office365.com
 (2603:10b6:806:d2::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30 via Frontend
 Transport; Tue, 18 Jun 2024 06:34:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 06:34:34 +0000
Received: from amd-02.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Jun
 2024 01:34:31 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH 2/5] drm/amdgpu: refine poison creation interrupt handler
Date: Tue, 18 Jun 2024 14:33:56 +0800
Message-ID: <20240618063359.304293-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618063359.304293-1-YiPeng.Chai@amd.com>
References: <20240618063359.304293-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|IA0PR12MB7721:EE_
X-MS-Office365-Filtering-Correlation-Id: ef1b387b-ca33-4c43-bd03-08dc8f60b7b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|36860700010|1800799021|376011|82310400023; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oCUSdMpMOlAALZGCUcetPCWF/2waPchjUpKE2Yg/5CZBRtNz6B0fDbenq/HR?=
 =?us-ascii?Q?EPnmL1tYa1JhGKaCYztsrzR2ZyLGEsdHOLnNaBZvosLNx4K0FZue9LKGjurG?=
 =?us-ascii?Q?LMio8xZ2p7xZwZCoeSFEmmtaJau9el0nwb1ZX+XzYTP0ZrFtFLMXpXsX3Bd1?=
 =?us-ascii?Q?FEAjUFjkJ/AwGh0AApF8l0v85gscTrr/dDlI0wnFI1l53y+uGMWQUKmvCfgY?=
 =?us-ascii?Q?7OgWa3D9uC0aZU5RWO2kxdpDqgQxTLUAsMvhqP8lGjtYdmAVuZ5by954edmT?=
 =?us-ascii?Q?jiRPkM6iQ7AniC6E1PB0otf9aci+uFeEOHlBCZkXJCmoZn+pnm5UGc8iuCvU?=
 =?us-ascii?Q?0igdoImNr3PgBuBPg6xfDsodBdv9X6oKXTg63wf++qJhoMlC5L8DNp4RUXGn?=
 =?us-ascii?Q?2hkttrqLs9JaYksBj61OokcPcCYdiDKmiBPvRLykY2S0UINpNvQPkNFBlWpx?=
 =?us-ascii?Q?jsWvZpMidV4v2YOsoX18uWycESQztDwqIwM0kZSV74sYCTfy53A7n9A7DCnH?=
 =?us-ascii?Q?m+HsObV7a6RNjobOHRxYcUQB3LJKo7CQUE9dyYtthBAASbaehZdZkmH16JEm?=
 =?us-ascii?Q?8zTHxMHLsOUwIRyJlgf8qXeJ/rdtDKIALgFF4wlsEn7xEm3wfYRDTxQlQuqA?=
 =?us-ascii?Q?aUwuUz7xGbOTqioaDRAAH6ktiwgIPSc7o4JPXiphAJQahApoJNxJ2pMQg/si?=
 =?us-ascii?Q?ez72BFQZqN/fPUkia2SYINdB6VSaE4+tZHfhInqMe+Vc05RQ0a+eTsaB5+S9?=
 =?us-ascii?Q?5FpsaFzdUoA8i+h23rbsmzi2esHlGefYdUPs0titn3J/xFKnUxUJInFNBJwY?=
 =?us-ascii?Q?3uy4xJpMcb56KqBfUL9WVmGqABqzfRD19AbwDlKi2NUb+weh57RTZHetpuBJ?=
 =?us-ascii?Q?aGRNdY5lDYepuVrUclIoBlJL1g84oAN/qGBk0th036ue+WF/bbsGujiPWOAf?=
 =?us-ascii?Q?nhSC3SuDI0oCgEVP7XXYhdPqUjOI78+a7P+i/RNDU/WSGC9tiE5MK3+qrPvQ?=
 =?us-ascii?Q?HW4uRH8VfsV5jGtbyBSynAqta5alvWVl/s+MkXcYuQjIimp4m+uuea+Sv0kW?=
 =?us-ascii?Q?gDKP47mBQUPVgauwou4rJRiRh3ZDBAEfLLC6fVSFCfAq7cmKCKH59b1I4jSi?=
 =?us-ascii?Q?TnArdsFqHFUwPjbbULCadWgxwEAl3YOuZSkDng++i1Bibp1XEHZWtxE3cBSl?=
 =?us-ascii?Q?fHzBs2T78PmEW6bm8smobCyuXFKCVXLrD1+IDBKxrC4CQ+o9B4y0W3lr8on8?=
 =?us-ascii?Q?7OD5oCceI7K6U+gfTQJAbgwpK5xGwctXYIRjn+k+NDFNhQ68J3Ba7/PQ9f5a?=
 =?us-ascii?Q?bnMsdXvUZSA8ssCQ3BGpQd1+y82ZTEMAnojH1zRysfPdzd4BQhGrqUqntnYR?=
 =?us-ascii?Q?sV7IfoROcfBofIMpF2TwbAR/O6z3NVgYh0DIp/8kAy9QLEfntg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(36860700010)(1800799021)(376011)(82310400023); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 06:34:34.0406 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef1b387b-ca33-4c43-bd03-08dc8f60b7b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7721
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 41 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  1 +
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index ec8e848122f9..13cd6a9234f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2093,10 +2093,8 @@ static void amdgpu_ras_interrupt_poison_creation_handler(struct ras_manager *obj
 	if (amdgpu_ip_version(obj->adev, UMC_HWIP, 0) >= IP_VERSION(12, 0, 0)) {
 		struct amdgpu_ras *con = amdgpu_ras_get_context(obj->adev);
 
-		amdgpu_ras_put_poison_req(obj->adev,
-			AMDGPU_RAS_BLOCK__UMC, 0, NULL, NULL, false);
-
 		atomic_inc(&con->page_retirement_req_cnt);
+		atomic_inc(&con->poison_creation_count);
 
 		wake_up(&con->page_retirement_wq);
 	}
@@ -2873,7 +2871,7 @@ static int amdgpu_ras_poison_creation_handler(struct amdgpu_device *adev,
 	if (query_data_timeout) {
 		dev_warn(adev->dev, "Can't find deferred error! count: %u\n",
 			(need_query_count - total_detect_count));
-		return 0;
+		return -ENOENT;
 	}
 
 	if (total_detect_count)
@@ -2908,6 +2906,8 @@ static int amdgpu_ras_page_retirement_thread(void *param)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)param;
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	uint32_t poison_creation_count;
+	int ret;
 	struct ras_poison_msg poison_msg;
 	enum amdgpu_ras_block ras_block;
 	bool poison_creation_is_handled = false;
@@ -2921,7 +2921,20 @@ static int amdgpu_ras_page_retirement_thread(void *param)
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
+				while (poison_creation_count--) {
+					atomic_dec(&con->poison_creation_count);
+					atomic_dec(&con->page_retirement_req_cnt);
+				}
+			}
+		} while (atomic_read(&con->poison_creation_count));
 
 #ifdef HAVE_KFIFO_PUT_NON_POINTER
 		if (!amdgpu_ras_get_poison_req(adev, &poison_msg))
@@ -2932,24 +2945,8 @@ static int amdgpu_ras_page_retirement_thread(void *param)
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
@@ -3029,6 +3026,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 	mutex_init(&con->page_retirement_lock);
 	init_waitqueue_head(&con->page_retirement_wq);
 	atomic_set(&con->page_retirement_req_cnt, 0);
+	atomic_set(&con->poison_creation_count, 0);
 	con->page_retirement_thread =
 		kthread_run(amdgpu_ras_page_retirement_thread, adev, "umc_page_retirement");
 	if (IS_ERR(con->page_retirement_thread)) {
@@ -3080,6 +3078,7 @@ static int amdgpu_ras_recovery_fini(struct amdgpu_device *adev)
 		kthread_stop(con->page_retirement_thread);
 
 	atomic_set(&con->page_retirement_req_cnt, 0);
+	atomic_set(&con->poison_creation_count, 0);
 
 	mutex_destroy(&con->page_rsv_lock);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index c50f5f2b1f4f..91daf48be03a 100644
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

