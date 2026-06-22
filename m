Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E75DCDB466
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 08:45:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE9B788CE4;
	Mon, 22 Jun 2026 08:45:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BrUiU6OS";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012062.outbound.protection.outlook.com
 [40.93.195.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 721B688CE4
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 08:45:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZrpINPD3hBxMn6YlVZNA1j77a2PTXFaCUpsPEUgyzYK3fVoxHUt+h3dbkqey3LH41wHmkWU/9TaWplYpvYpcILoEbJq0SXskb0lIkmSirIqrEu43j57Ch1YwJC2+vI+DWYzAg42NXChlhz8XWbXbK/9P22QDaqfAwCKY2bjSV3Pbx9BQLexDAVwWqstMoKeMNX72VLiYBri+x2c5NshWQA3mFkz484gUmvrMbOsf77GtXjtLi9Bl5jwM7SQQYDlqtBS7ZhZwFxS2OXvjZqvHboVWYBdTMWR0FYVeHaIC7m9iwKyMWZ8R3ADZHAhw+cj0dE1NoCxo3cjYEOTFPih95A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TAN6sgzmHC9/7C8FWadaiSQi3mJQ7ZmSq3pp5rfv7MA=;
 b=GSEj/2PeiNxI0Lc6K2d/ihS+iKGx91bPrVRxKJnK41hOaYzK6PuyQkjRmRlorWpdwyUmeUM6HiNo1IBjuXd7rRVl8YmD5TFKdQ0I84SGyp6y0F0NunCiZmbp/O7ime7bkSlcO8CuixgTp4y+5nRYGrBukNtC72yBIxCbcsyqeOCnvVDnbZdbt2lgPmG4PbVoFK3YsqFm1mhYamrFUHzMAtycUerxZpU4mbonVOUvJPl87FoD+bsPr/UlpZc7Jb5QTr0PNqYXIijqpOamB6kWO+KXD1qYFcC3VFG9RGPZGYf8La5QUddWGj3FRzJ3Hhl4owvrlgCUPZAjW0PiEQ8iMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAN6sgzmHC9/7C8FWadaiSQi3mJQ7ZmSq3pp5rfv7MA=;
 b=BrUiU6OSiCSOHP6vg5SILfKVF7wr64FRhVnv8BQRAFXP1vBRv47O54hFME7csbWFmGxNqwYWrlosEiwmB9LVJyLSzd9neVNHHxh2/84U+47YP66frErDB10HZjwyH0yM+vi5cg/5EzzC5X+UcKYp6hzXxGBPh8yBYPAXO3N+prw=
Received: from DS7PR06CA0039.namprd06.prod.outlook.com (2603:10b6:8:54::7) by
 CH3PR12MB7762.namprd12.prod.outlook.com (2603:10b6:610:151::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 08:45:15 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:8:54:cafe::30) by DS7PR06CA0039.outlook.office365.com
 (2603:10b6:8:54::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 08:45:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 08:45:14 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 03:45:09 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v2 01/48] drm/amdgpu: Retire legacy page retirement RAS code
Date: Mon, 22 Jun 2026 16:44:03 +0800
Message-ID: <594f7cbae0387b60f8af49505b57c1a5a604db2f.1782117608.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|CH3PR12MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: abd29f3f-1227-4c97-43ef-08ded03a9442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|6133799003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: dND6DcG6G/Cas7bDt1bk0m9aG8wxfDdOvRpGu0CVd5tWzCR4je7BeQVGw3Os+UP8AKioCsoL4n3SFpbxRaUtRpks5iWj/Zl1zIklyUNJcJNUNyy6lEXGXbWzI4sQfaPM6v8gMo516LqaQopdsqaFPwQmYMIJNCMji+YpiLqRRqDcHy+OUjtApYg9UCP2gWCUzN56E86nVbg0Ip+dnwYmi/4F+oAdaMPPkcV3nkb2znrxwiF/wyY6lUCEqNlRzCEgwKivnHQT0TCHn6RucSkRVroyI3ixKEiIVOY2ZcZQ5CVoyYpwszJsmQYQomFsE5RdvO1mfgTDPlQv43PEm7ErMfzCfnpkuCMqTaLEsbS1XcUgtZjw3t5BkVjt2QbrHHoXArOQ7pwBS2GWmMBdKF+nwjpPs8qpPUsOgurWORBgxqoEzcyCTbXxXQcuFa9wrSszZU+UdzrRstL7mMVeYGzUyplfzB6sHAhEBg2nWRf0ElGx6U2RTKI4V5lOws1OVfhVLstcdbxskZlc+4xqwdEPjG1J/3sgXczmV8+G8ONQzYX7TNsJei6Fxe8sQ3+ygrPsS0wl2O6QVDVhlo1jONfCfToyEwLGBEBru3A4OXFw65bcIXfNnqknz5ZGSg7G1+S4qLr9mI4EoWDoFUtCBMW33XYvnMps/dBvdPfIgy9GBT2umYRO1BL4aGMba8UdW2MGQqxh84L8hqy0ldpkjT7XKw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(6133799003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /gkWlpL/I7RhPeiftOVeWUuj6yxCUP3FtzmqqfBSmmNVUm6/FN5qX07iCLadb1mpIJKG4WaSqk8F2PBCfTI6lkRbEetsBeF8jsFrCoeFJdrWAC7lvW9ubBxt2J2cPmEZDvO1k6WK/vuRa6f1JECa4/Rvv8luD8q+dIQZg73BQH9zkgVvg/xtXqgJd8FwLinPdNTiX9DBbtakSM2DctqPH05ir6gGtAGli8SR8KZQZjGWTU3KJfNHFpm5AiH3ZZWO4etGM6iJOSd+Iu9bCNWqm0ksA30qBHFKW86CIuCOjdlqeqCUSZPfDVnq3VrgBASn/XQU6M358vT252vqlOklmoZ12SXiivFf1e4RuU0B1G6fBFtPGOgOtsSLAqwXruiQSPvBy1WW1jKEu2eE9PmswWgAAlj3/MZntkskmrOVBPNSqwNBQdnnDw8wBLusMobY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:45:14.6373 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abd29f3f-1227-4c97-43ef-08ded03a9442
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7762
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

Remove the deprecated legacy RAS code path for page retirement

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 304 +-----------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  23 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c |  13 +-
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  |  17 --
 4 files changed, 2 insertions(+), 355 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 8a49ae4c0132..8095f284d531 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -128,12 +128,6 @@ const char *get_ras_block_str(struct ras_common_if *ras_block)
 /* typical ECC bad page rate is 1 bad page per 100MB VRAM */
 #define RAS_BAD_PAGE_COVER              (100 * 1024 * 1024ULL)
 
-#define MAX_UMC_POISON_POLLING_TIME_ASYNC  10
-
-#define AMDGPU_RAS_RETIRE_PAGE_INTERVAL 100  //ms
-
-#define MAX_FLUSH_RETIRE_DWORK_TIMES  100
-
 #define BYPASS_ALLOCATED_ADDRESS        0x0
 #define BYPASS_INITIALIZATION_ADDRESS   0x1
 
@@ -2489,14 +2483,6 @@ static void amdgpu_ras_interrupt_poison_creation_handler(struct ras_manager *obj
 	event_id = amdgpu_ras_acquire_event_id(adev, type);
 	RAS_EVENT_LOG(adev, event_id, "Poison is created\n");
 
-	if (amdgpu_ip_version(obj->adev, UMC_HWIP, 0) >= IP_VERSION(12, 0, 0)) {
-		struct amdgpu_ras *con = amdgpu_ras_get_context(obj->adev);
-
-		atomic_inc(&con->page_retirement_req_cnt);
-		atomic_inc(&con->poison_creation_count);
-
-		wake_up(&con->page_retirement_wq);
-	}
 }
 
 static void amdgpu_ras_interrupt_umc_handler(struct ras_manager *obj,
@@ -3550,38 +3536,6 @@ static void amdgpu_ras_validate_threshold(struct amdgpu_device *adev,
 	}
 }
 
-int amdgpu_ras_put_poison_req(struct amdgpu_device *adev,
-		enum amdgpu_ras_block block, uint16_t pasid,
-		pasid_notify pasid_fn, void *data, uint32_t reset)
-{
-	int ret = 0;
-	struct ras_poison_msg poison_msg;
-	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-
-	memset(&poison_msg, 0, sizeof(poison_msg));
-	poison_msg.block = block;
-	poison_msg.pasid = pasid;
-	poison_msg.reset = reset;
-	poison_msg.pasid_fn = pasid_fn;
-	poison_msg.data = data;
-
-	ret = kfifo_put(&con->poison_fifo, poison_msg);
-	if (!ret) {
-		dev_err(adev->dev, "Poison message fifo is full!\n");
-		return -ENOSPC;
-	}
-
-	return 0;
-}
-
-static int amdgpu_ras_get_poison_req(struct amdgpu_device *adev,
-		struct ras_poison_msg *poison_msg)
-{
-	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-
-	return kfifo_get(&con->poison_fifo, poison_msg);
-}
-
 static void amdgpu_ras_ecc_log_init(struct ras_ecc_log_info *ecc_log)
 {
 	mutex_init(&ecc_log->lock);
@@ -3611,232 +3565,6 @@ static void amdgpu_ras_ecc_log_fini(struct ras_ecc_log_info *ecc_log)
 	ecc_log->consumption_q_count = 0;
 }
 
-static bool amdgpu_ras_schedule_retirement_dwork(struct amdgpu_ras *con,
-				uint32_t delayed_ms)
-{
-	int ret;
-
-	mutex_lock(&con->umc_ecc_log.lock);
-	ret = radix_tree_tagged(&con->umc_ecc_log.de_page_tree,
-			UMC_ECC_NEW_DETECTED_TAG);
-	mutex_unlock(&con->umc_ecc_log.lock);
-
-	if (ret)
-		schedule_delayed_work(&con->page_retirement_dwork,
-			msecs_to_jiffies(delayed_ms));
-
-	return ret ? true : false;
-}
-
-static void amdgpu_ras_do_page_retirement(struct work_struct *work)
-{
-	struct amdgpu_ras *con = container_of(work, struct amdgpu_ras,
-					      page_retirement_dwork.work);
-	struct amdgpu_device *adev = con->adev;
-	struct ras_err_data err_data;
-
-	/* If gpu reset is ongoing, delay retiring the bad pages */
-	if (amdgpu_in_reset(adev) || amdgpu_ras_in_recovery(adev)) {
-		amdgpu_ras_schedule_retirement_dwork(con,
-				AMDGPU_RAS_RETIRE_PAGE_INTERVAL * 3);
-		return;
-	}
-
-	amdgpu_ras_error_data_init(&err_data);
-
-	amdgpu_umc_handle_bad_pages(adev, &err_data);
-
-	amdgpu_ras_error_data_fini(&err_data);
-
-	amdgpu_ras_schedule_retirement_dwork(con,
-			AMDGPU_RAS_RETIRE_PAGE_INTERVAL);
-}
-
-static int amdgpu_ras_poison_creation_handler(struct amdgpu_device *adev,
-				uint32_t poison_creation_count)
-{
-	int ret = 0;
-	struct ras_ecc_log_info *ecc_log;
-	struct ras_query_if info;
-	u32 timeout = MAX_UMC_POISON_POLLING_TIME_ASYNC;
-	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
-	u64 de_queried_count;
-	u64 consumption_q_count;
-	enum ras_event_type type = RAS_EVENT_TYPE_POISON_CREATION;
-
-	memset(&info, 0, sizeof(info));
-	info.head.block = AMDGPU_RAS_BLOCK__UMC;
-
-	ecc_log = &ras->umc_ecc_log;
-	ecc_log->de_queried_count = 0;
-	ecc_log->consumption_q_count = 0;
-
-	do {
-		ret = amdgpu_ras_query_error_status_with_event(adev, &info, type);
-		if (ret)
-			return ret;
-
-		de_queried_count = ecc_log->de_queried_count;
-		consumption_q_count = ecc_log->consumption_q_count;
-
-		if (de_queried_count && consumption_q_count)
-			break;
-
-		msleep(100);
-	} while (--timeout);
-
-	if (de_queried_count)
-		schedule_delayed_work(&ras->page_retirement_dwork, 0);
-
-	if (amdgpu_ras_is_rma(adev) && atomic_cmpxchg(&ras->rma_in_recovery, 0, 1) == 0)
-		amdgpu_ras_reset_gpu(adev);
-
-	return 0;
-}
-
-static void amdgpu_ras_clear_poison_fifo(struct amdgpu_device *adev)
-{
-	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-	struct ras_poison_msg msg;
-	int ret;
-
-	do {
-		ret = kfifo_get(&con->poison_fifo, &msg);
-	} while (ret);
-}
-
-static int amdgpu_ras_poison_consumption_handler(struct amdgpu_device *adev,
-			uint32_t msg_count, uint32_t *gpu_reset)
-{
-	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-	uint32_t reset_flags = 0, reset = 0;
-	struct ras_poison_msg msg;
-	int ret, i;
-
-	kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
-
-	for (i = 0; i < msg_count; i++) {
-		ret = amdgpu_ras_get_poison_req(adev, &msg);
-		if (!ret)
-			continue;
-
-		if (msg.pasid_fn)
-			msg.pasid_fn(adev, msg.pasid, msg.data);
-
-		reset_flags |= msg.reset;
-	}
-
-	/*
-	 * Try to ensure poison creation handler is completed first
-	 * to set rma if bad page exceed threshold.
-	 */
-	flush_delayed_work(&con->page_retirement_dwork);
-
-	/* for RMA, amdgpu_ras_poison_creation_handler will trigger gpu reset */
-	if (reset_flags && !amdgpu_ras_is_rma(adev)) {
-		if (reset_flags & AMDGPU_RAS_GPU_RESET_MODE1_RESET)
-			reset = AMDGPU_RAS_GPU_RESET_MODE1_RESET;
-		else if (reset_flags & AMDGPU_RAS_GPU_RESET_MODE2_RESET)
-			reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
-		else
-			reset = reset_flags;
-
-		con->gpu_reset_flags |= reset;
-		amdgpu_ras_reset_gpu(adev);
-
-		*gpu_reset = reset;
-
-		/* Wait for gpu recovery to complete */
-		flush_work(&con->recovery_work);
-	}
-
-	return 0;
-}
-
-static int amdgpu_ras_page_retirement_thread(void *param)
-{
-	struct amdgpu_device *adev = (struct amdgpu_device *)param;
-	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-	uint32_t poison_creation_count, msg_count;
-	uint32_t gpu_reset;
-	int ret;
-
-	while (!kthread_should_stop()) {
-
-		wait_event_interruptible(con->page_retirement_wq,
-				kthread_should_stop() ||
-				atomic_read(&con->page_retirement_req_cnt));
-
-		if (kthread_should_stop())
-			break;
-
-		mutex_lock(&con->poison_lock);
-		gpu_reset = 0;
-
-		do {
-			poison_creation_count = atomic_read(&con->poison_creation_count);
-			ret = amdgpu_ras_poison_creation_handler(adev, poison_creation_count);
-			if (ret == -EIO)
-				break;
-
-			if (poison_creation_count) {
-				atomic_sub(poison_creation_count, &con->poison_creation_count);
-				atomic_sub(poison_creation_count, &con->page_retirement_req_cnt);
-			}
-		} while (atomic_read(&con->poison_creation_count) &&
-			!atomic_read(&con->poison_consumption_count));
-
-		if (ret != -EIO) {
-			msg_count = kfifo_len(&con->poison_fifo);
-			if (msg_count) {
-				ret = amdgpu_ras_poison_consumption_handler(adev,
-						msg_count, &gpu_reset);
-				if ((ret != -EIO) &&
-				    (gpu_reset != AMDGPU_RAS_GPU_RESET_MODE1_RESET))
-					atomic_sub(msg_count, &con->page_retirement_req_cnt);
-			}
-		}
-
-		if ((ret == -EIO) || (gpu_reset == AMDGPU_RAS_GPU_RESET_MODE1_RESET)) {
-			/* gpu mode-1 reset is ongoing or just completed ras mode-1 reset */
-			/* Clear poison creation request */
-			atomic_set(&con->poison_creation_count, 0);
-			atomic_set(&con->poison_consumption_count, 0);
-
-			/* Clear poison fifo */
-			amdgpu_ras_clear_poison_fifo(adev);
-
-			/* Clear all poison requests */
-			atomic_set(&con->page_retirement_req_cnt, 0);
-
-			if (ret == -EIO) {
-				/* Wait for mode-1 reset to complete */
-				down_read(&adev->reset_domain->sem);
-				up_read(&adev->reset_domain->sem);
-			}
-
-			/* Wake up work to save bad pages to eeprom */
-			schedule_delayed_work(&con->page_retirement_dwork, 0);
-		} else if (gpu_reset) {
-			/* gpu just completed mode-2 reset or other reset */
-			/* Clear poison consumption messages cached in fifo */
-			msg_count = kfifo_len(&con->poison_fifo);
-			if (msg_count) {
-				amdgpu_ras_clear_poison_fifo(adev);
-				atomic_sub(msg_count, &con->page_retirement_req_cnt);
-			}
-
-			atomic_set(&con->poison_consumption_count, 0);
-
-			/* Wake up work to save bad pages to eeprom */
-			schedule_delayed_work(&con->page_retirement_dwork, 0);
-		}
-		mutex_unlock(&con->poison_lock);
-	}
-
-	return 0;
-}
-
 int amdgpu_ras_init_badpage_info(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
@@ -3917,10 +3645,8 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev, bool init_bp_info)
 	}
 
 	mutex_init(&con->recovery_lock);
-	mutex_init(&con->poison_lock);
 	INIT_WORK(&con->recovery_work, amdgpu_ras_do_recovery);
 	atomic_set(&con->in_recovery, 0);
-	atomic_set(&con->rma_in_recovery, 0);
 	con->eeprom_control.bad_channel_bitmap = 0;
 
 	max_eeprom_records_count = amdgpu_ras_eeprom_max_record_count(&con->eeprom_control);
@@ -3933,20 +3659,8 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev, bool init_bp_info)
 	}
 
 	mutex_init(&con->page_rsv_lock);
-	INIT_KFIFO(con->poison_fifo);
 	mutex_init(&con->page_retirement_lock);
-	init_waitqueue_head(&con->page_retirement_wq);
-	atomic_set(&con->page_retirement_req_cnt, 0);
-	atomic_set(&con->poison_creation_count, 0);
-	atomic_set(&con->poison_consumption_count, 0);
-	con->page_retirement_thread =
-		kthread_run(amdgpu_ras_page_retirement_thread, adev, "umc_page_retirement");
-	if (IS_ERR(con->page_retirement_thread)) {
-		con->page_retirement_thread = NULL;
-		dev_warn(adev->dev, "Failed to create umc_page_retirement thread!!!\n");
-	}
-
-	INIT_DELAYED_WORK(&con->page_retirement_dwork, amdgpu_ras_do_page_retirement);
+
 	amdgpu_ras_ecc_log_init(&con->umc_ecc_log);
 #ifdef CONFIG_X86_MCE_AMD
 	if ((adev->asic_type == CHIP_ALDEBARAN) &&
@@ -3978,31 +3692,15 @@ static int amdgpu_ras_recovery_fini(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_err_handler_data *data = con->eh_data;
-	int max_flush_timeout = MAX_FLUSH_RETIRE_DWORK_TIMES;
-	bool ret;
 
 	/* recovery_init failed to init it, fini is useless */
 	if (!data)
 		return 0;
 
-	/* Save all cached bad pages to eeprom */
-	do {
-		flush_delayed_work(&con->page_retirement_dwork);
-		ret = amdgpu_ras_schedule_retirement_dwork(con, 0);
-	} while (ret && max_flush_timeout--);
-
-	if (con->page_retirement_thread)
-		kthread_stop(con->page_retirement_thread);
-
-	atomic_set(&con->page_retirement_req_cnt, 0);
-	atomic_set(&con->poison_creation_count, 0);
-
 	mutex_destroy(&con->page_rsv_lock);
 
 	cancel_work_sync(&con->recovery_work);
 
-	cancel_delayed_work_sync(&con->page_retirement_dwork);
-
 	amdgpu_ras_ecc_log_fini(&con->umc_ecc_log);
 
 	mutex_lock(&con->recovery_lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index a86ab65aa2f0..1629a242d58e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -466,14 +466,6 @@ struct ras_query_context {
 typedef int (*pasid_notify)(struct amdgpu_device *adev,
 		uint16_t pasid, void *data);
 
-struct ras_poison_msg {
-	enum amdgpu_ras_block block;
-	uint16_t pasid;
-	uint32_t reset;
-	pasid_notify pasid_fn;
-	void *data;
-};
-
 struct ras_err_pages {
 	uint32_t count;
 	uint64_t *pfn;
@@ -549,7 +541,6 @@ struct amdgpu_ras {
 	/* gpu recovery */
 	struct work_struct recovery_work;
 	atomic_t in_recovery;
-	atomic_t rma_in_recovery;
 	struct amdgpu_device *adev;
 	/* error handler data */
 	struct ras_err_handler_data *eh_data;
@@ -587,16 +578,9 @@ struct amdgpu_ras {
 	/* Record special requirements of gpu reset caller */
 	uint32_t  gpu_reset_flags;
 
-	struct task_struct *page_retirement_thread;
-	wait_queue_head_t page_retirement_wq;
 	struct mutex page_retirement_lock;
-	atomic_t page_retirement_req_cnt;
-	atomic_t poison_creation_count;
-	atomic_t poison_consumption_count;
 	struct mutex page_rsv_lock;
-	DECLARE_KFIFO(poison_fifo, struct ras_poison_msg, 128);
 	struct ras_ecc_log_info  umc_ecc_log;
-	struct delayed_work page_retirement_dwork;
 
 	/* ras errors detected */
 	unsigned long ras_err_state;
@@ -615,9 +599,6 @@ struct amdgpu_ras {
 	struct list_head critical_region_head;
 	struct mutex critical_region_lock;
 
-	/* Protect poison injection */
-	struct mutex poison_lock;
-
 	/* Disable/Enable uniras switch */
 	bool uniras_enabled;
 	const struct ras_smu_drv *ras_smu_drv;
@@ -1029,10 +1010,6 @@ int amdgpu_ras_reserve_page(struct amdgpu_device *adev, uint64_t pfn);
 int amdgpu_ras_add_critical_region(struct amdgpu_device *adev, struct amdgpu_bo *bo);
 bool amdgpu_ras_check_critical_address(struct amdgpu_device *adev, uint64_t addr);
 
-int amdgpu_ras_put_poison_req(struct amdgpu_device *adev,
-		enum amdgpu_ras_block block, uint16_t pasid,
-		pasid_notify pasid_fn, void *data, uint32_t reset);
-
 bool amdgpu_ras_in_recovery(struct amdgpu_device *adev);
 
 __printf(3, 4)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index a250109edb63..f22d07e9c29c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -276,7 +276,7 @@ int amdgpu_umc_pasid_poison_handler(struct amdgpu_device *adev,
 			}
 
 			amdgpu_ras_error_data_fini(&err_data);
-		} else if (amdgpu_uniras_enabled(adev)) {
+		} else {
 			struct ras_ih_info ih_info = {0};
 
 			ih_info.block = block;
@@ -285,17 +285,6 @@ int amdgpu_umc_pasid_poison_handler(struct amdgpu_device *adev,
 			ih_info.pasid_fn = pasid_fn;
 			ih_info.data = data;
 			amdgpu_ras_mgr_handle_consumer_interrupt(adev, &ih_info);
-		} else {
-			struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-			int ret;
-
-			ret = amdgpu_ras_put_poison_req(adev,
-				block, pasid, pasid_fn, data, reset);
-			if (!ret) {
-				atomic_inc(&con->page_retirement_req_cnt);
-				atomic_inc(&con->poison_consumption_count);
-				wake_up(&con->page_retirement_wq);
-			}
 		}
 	} else {
 		if (adev->virt.ops && adev->virt.ops->ras_poison_handler)
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index a6df6a778f50..749c1f845ac6 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -656,23 +656,6 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
 	for (i = 0; i < count; i++)
 		amdgpu_ras_reserve_page(adev, page_pfn[i]);
 
-	/* The problem case is as follows:
-	 * 1. GPU A triggers a gpu ras reset, and GPU A drives
-	 *    GPU B to also perform a gpu ras reset.
-	 * 2. After gpu B ras reset started, gpu B queried a DE
-	 *    data. Since the DE data was queried in the ras reset
-	 *    thread instead of the page retirement thread, bad
-	 *    page retirement work would not be triggered. Then
-	 *    even if all gpu resets are completed, the bad pages
-	 *    will be cached in RAM until GPU B's bad page retirement
-	 *    work is triggered again and then saved to eeprom.
-	 * Trigger delayed work to save the bad pages to eeprom in time
-	 * after gpu ras reset is completed.
-	 */
-	if (amdgpu_ras_in_recovery(adev))
-		schedule_delayed_work(&con->page_retirement_dwork,
-			msecs_to_jiffies(DELAYED_TIME_FOR_GPU_RESET));
-
 	return 0;
 }
 
-- 
2.34.1

