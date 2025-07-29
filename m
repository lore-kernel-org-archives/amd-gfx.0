Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B88C83F17
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jul 2025 03:23:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E90210E5AD;
	Tue, 29 Jul 2025 03:23:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aoYtoCYg";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E598C10E5AD
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jul 2025 03:23:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MynK3fZXtAvgOcYYlKpUo33xe3yicBcWHczdWEVrt2YfhnsqlZbifcM658orfgV6S+5LEpqR4sfC/VPC6gkxP4n4a93pm5f9smWGqDMK4ol9Da0gk7XwIOvaLFTxmQ88vvYnUfyvSQOjzaWaa641YVNLFB3eOHQfkeV07Ux/KnaIZC23ZpwpQs2rNg28tHvB9j4ns+47RpH43NR1WBH1vFtgmnblPuioxnenr6H/MrXqDoHD8bFJR+dU89U8vm+Nb7bDiACL+tbx9brRQUicODfu/Gia/isuCl30ffbAPe83NzDifNSEEw6xVLrfjXU5croJ+Z0QAeKMG8dIkngYWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yy+ncxoKob6UuXh1d/y4bouVJRN+Has5vu5A/VtbRDw=;
 b=EOftKnOqAeDQa5l/9T3PnH+S4O9e4R8Q/DCBogEEAm97EWIePrtGx+w/V7SHIdwlCD9bgqvSjjnIQDu79uFXE7zfnzL0qw4YkTFjenwlBPDL3Z7DsAc+djFc5oZHq5+t+SlQ+/qFbGpDoa6UEh0wF9a87LYP+LXOLNjBgL7qXQ5UPxETPRzqgTKKa3G8V1uvFywiaIJ++PY2TYd+auSIG7c5aPAKT7IG6r0cRu7VuPI/AmsoOJ4n+1Vc3DGwACOUBS5SCZTMIvtWLhBSa/DzVP1XqSdYlteuAFKhikrsKEy90bOdD6/WKWkM0Fp2DSwCbi2dU4cRF+J2nISl8VcuPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yy+ncxoKob6UuXh1d/y4bouVJRN+Has5vu5A/VtbRDw=;
 b=aoYtoCYgES6kvhk93oEwZQAc+8aF2G6r9AuXk0nnEGkrGiTppYNtklZJaDwYb1qmmH3QniL8ZP0m1x+kckPnq0BseXk6tsOj33qLbLXE7v1kJs9GlzjPfFR7GtKiH3yS3fU2AI57iZ6PXd2CKp3nVD1JrCKB3aAzXStjxtCxd3g=
Received: from BY5PR20CA0019.namprd20.prod.outlook.com (2603:10b6:a03:1f4::32)
 by BY5PR12MB4145.namprd12.prod.outlook.com (2603:10b6:a03:212::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 03:23:35 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::f4) by BY5PR20CA0019.outlook.office365.com
 (2603:10b6:a03:1f4::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.27 via Frontend Transport; Tue,
 29 Jul 2025 03:23:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Tue, 29 Jul 2025 03:23:34 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Jul
 2025 22:23:32 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>, <Stanley.Yang@amd.com>, "Ce
 Sun" <cesun102@amd.com>
Subject: [PATCH] drm/amdgpu: Avoid rma causes GPU duplicate reset
Date: Tue, 29 Jul 2025 11:23:23 +0800
Message-ID: <20250729032323.74649-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|BY5PR12MB4145:EE_
X-MS-Office365-Filtering-Correlation-Id: 17677666-65da-4582-0bf8-08ddce4f4ceb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y+xDyaFy08DrM8SdLrus83V22Pp2/29SdZ7ndyRV1fKDS1/d9eKlDavE+HOi?=
 =?us-ascii?Q?w+zkwmam5Nw1Zcmyd/MADTAjXFAYJkY7zYl63S+RFQDz3NrYRkMqLzg7k6tK?=
 =?us-ascii?Q?YeTGx5K3SLTdGC+cr3SXOhhbu5m76gz7EkENqRzVAOibAlCd7zBvxpZWQq0b?=
 =?us-ascii?Q?WdZqdoKoiPxYDlOaPwIlF0al3Vxkp7Xi7j/CMgwIDoAMmJPcupduNpzQRsca?=
 =?us-ascii?Q?0DiXVWv7ejMwbCesK+l0iQyq7u8qThmLP57LuBVAWiX0Ay4Ha5TzDXWv2Aqu?=
 =?us-ascii?Q?wFp9zJgkkDG3Rx8/x9OBzdgzwqPWH7E+kV0EaihfG3d4jH7InXdxPDO4i3CI?=
 =?us-ascii?Q?iHsAlAY8U7LqaSxrmBjjW/lQwKC9TjQcJNP+++DHyZDlra7+nqZ/wvlGuVAd?=
 =?us-ascii?Q?xBYJ8JAxquG0En1jhSCnffn+OniPeDqVHZR6QmCtJiHkncLHcu8z9imU/pdS?=
 =?us-ascii?Q?cz07Kmirx3DOdSEPVdm9UxPv4uauXkbbcueYqUwcL1mTmJoY/PeC/FcZGuHZ?=
 =?us-ascii?Q?/PVU/tG4ne/yn5MyAm7TSJ2OoAM+AYMU1++p/Tq6VklVYbqX8iJs0E8wBlW+?=
 =?us-ascii?Q?fWi1T5wwtKN+eODQ8bWAKmM0H+pDQnqCvzO4CIOFJYfc++TX8Ux5sZJuBcA1?=
 =?us-ascii?Q?gJ9Xo2LcROg0CTXpnvVHaH4ETAIfZQDr6xiFNxNiuzz73MX9Rlad+cvg/UM7?=
 =?us-ascii?Q?nj8uH0b8OR5LlMsHLPZsHurBwD8CknHsJoiE+1wsMtw/XjzTS1CsaxVkpJxH?=
 =?us-ascii?Q?XzxKPSwvjUh2oaK6Cemv6Rx4JZDaOV+M8Xm8X4yEGy4RHd3vIgwpA4LZaZDx?=
 =?us-ascii?Q?bIjVub7BA8XvyjllPJaxuWGDAIwHfLe5GiDVSluhYzNM46HREgAo+TCUqEYA?=
 =?us-ascii?Q?dlIQfGK6F3a8ayXpZOO/aJpsN7huc+0vYKk6uD8GXaaEZpMTGWkd27KBCqiA?=
 =?us-ascii?Q?E3mK771Tbi5HXx+gALy8MxHcBz9RmnxqFpuL3xZkZzpTy/8S0qpOGHhfdajy?=
 =?us-ascii?Q?C8Pv/dqsUoAkhJ0/TbFYtNEJ6FYk6zWDsutq+syS4iZFMgREMVbRxTncHBf+?=
 =?us-ascii?Q?fpgQbcG4LY7nqn+SWYubEojGtVweoc4ohBKexogERIn/EgWRN846X+1F4kO1?=
 =?us-ascii?Q?cwfAyhex4vlyrtNrPtC3Lzaf0BZ5ub1JiVkNn0nmfMtindtjYRrvOENAJTmk?=
 =?us-ascii?Q?GfkZpZQuwEalPfsAAlR7aOdGJv3cOa+1SiGqlunPgNjK6/KppO0slvOjGKFS?=
 =?us-ascii?Q?XK4TaftubZAw9SvoRCBBcCWecDsD7uKstaFfMIfgoR4qiIVmANa0qvsrnKRY?=
 =?us-ascii?Q?PZMy1F5bTGOFlfj22umf0YC/aA2hreZSWjoKUcRV/z/u/7m/6My9lyrDKr0X?=
 =?us-ascii?Q?UinHMrGkak/+SM5xhFQwT1ty3lS7Rd8eu9BfSrcKwmqlx0iJzX+QzBKvWE9A?=
 =?us-ascii?Q?wrUKtTWG1zqPUW2aq4Bei2GJwrExDiiqG7K7MARBhpxLwxyH+YxnUN9IoWIf?=
 =?us-ascii?Q?tRwr8q1pd9bkOLowuMB4dAWzb6Qj7TUiqnfz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 03:23:34.3343 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17677666-65da-4582-0bf8-08ddce4f4ceb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4145
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

Try to ensure poison creation handle is completed in time
to set device rma value.

Signed-off-by: Ce Sun <cesun102@amd.com>
Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 17 ++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  1 +
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index ac7099d03e89..eea175874ba0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3356,7 +3356,6 @@ static void amdgpu_ras_do_page_retirement(struct work_struct *work)
 					      page_retirement_dwork.work);
 	struct amdgpu_device *adev = con->adev;
 	struct ras_err_data err_data;
-	unsigned long err_cnt;
 
 	/* If gpu reset is ongoing, delay retiring the bad pages */
 	if (amdgpu_in_reset(adev) || amdgpu_ras_in_recovery(adev)) {
@@ -3368,13 +3367,9 @@ static void amdgpu_ras_do_page_retirement(struct work_struct *work)
 	amdgpu_ras_error_data_init(&err_data);
 
 	amdgpu_umc_handle_bad_pages(adev, &err_data);
-	err_cnt = err_data.err_addr_cnt;
 
 	amdgpu_ras_error_data_fini(&err_data);
 
-	if (err_cnt && amdgpu_ras_is_rma(adev))
-		amdgpu_ras_reset_gpu(adev);
-
 	amdgpu_ras_schedule_retirement_dwork(con,
 			AMDGPU_RAS_RETIRE_PAGE_INTERVAL);
 }
@@ -3428,6 +3423,9 @@ static int amdgpu_ras_poison_creation_handler(struct amdgpu_device *adev,
 	if (total_detect_count)
 		schedule_delayed_work(&ras->page_retirement_dwork, 0);
 
+	if (amdgpu_ras_is_rma(adev) && atomic_cmpxchg(&ras->rma_in_recovery, 0, 1) == 0)
+		amdgpu_ras_reset_gpu(adev);
+
 	return 0;
 }
 
@@ -3464,6 +3462,12 @@ static int amdgpu_ras_poison_consumption_handler(struct amdgpu_device *adev,
 		reset_flags |= msg.reset;
 	}
 
+	/*
+	 * Try to ensure poison creation handler is completed first
+	 * to set rma if bad page exceed threshold.
+	 */
+	flush_delayed_work(&con->page_retirement_dwork);
+
 	/* for RMA, amdgpu_ras_poison_creation_handler will trigger gpu reset */
 	if (reset_flags && !amdgpu_ras_is_rma(adev)) {
 		if (reset_flags & AMDGPU_RAS_GPU_RESET_MODE1_RESET)
@@ -3473,8 +3477,6 @@ static int amdgpu_ras_poison_consumption_handler(struct amdgpu_device *adev,
 		else
 			reset = reset_flags;
 
-		flush_delayed_work(&con->page_retirement_dwork);
-
 		con->gpu_reset_flags |= reset;
 		amdgpu_ras_reset_gpu(adev);
 
@@ -3645,6 +3647,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev, bool init_bp_info)
 	mutex_init(&con->recovery_lock);
 	INIT_WORK(&con->recovery_work, amdgpu_ras_do_recovery);
 	atomic_set(&con->in_recovery, 0);
+	atomic_set(&con->rma_in_recovery, 0);
 	con->eeprom_control.bad_channel_bitmap = 0;
 
 	max_eeprom_records_count = amdgpu_ras_eeprom_max_record_count(&con->eeprom_control);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 7f10a7402160..662046ab73ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -515,6 +515,7 @@ struct amdgpu_ras {
 	/* gpu recovery */
 	struct work_struct recovery_work;
 	atomic_t in_recovery;
+	atomic_t rma_in_recovery;
 	struct amdgpu_device *adev;
 	/* error handler data */
 	struct ras_err_handler_data *eh_data;
-- 
2.34.1

