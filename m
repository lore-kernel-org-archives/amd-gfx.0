Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3DC0CA0ED1
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Aug 2025 14:58:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CE3110E466;
	Mon, 18 Aug 2025 14:58:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J7gRcWja";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4197D10E466
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 14:58:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AsEo53rB4Nz/u6xWvQ9SJAO1O3RzH1tpfbiSJACXKpbUQqcT0wEe97pFzOW8IwXrG7SOiJztWXt5A3TU0UnukZDKbjVKbyS1y1uj1s9j38a5PsLaDuvK7sv+pe/K/Nbz8lftrSpVdM+fpgQ1TlRWTLeYbiiivAwOqiEkcLKWCYZNMbBqkS163JOoq1c3MJpinrrGgQUOaKoX7rppBzzNdXXXq8XdWpmpaicJn6WlQXlKdZA9IAWmrvR1ky/tO1Vp9ddtvmQmQlKQ1Nz+SajJg92CmkRdlztS4K+q8IeKcWPTDug3nx053LIO6tk014NySc1v3B2sRIFoFqHEcslIEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVy7oG4wWEITGPzu5DzbLJCFYUqOWjNTKoTxTRB0Lro=;
 b=n6B3+YFbofAXb0MT8LuHMDT7dSiP6cIyZpw2gicp8scZwX4SrIm+yLBUcWfAnVTEMizczNn9KmacRdNOdtOxsSVhKwMed8RkSii74Y7Z9ByotvhK22CGedIVN/zmWTI3rLB6vf+BjSKYEAeNETEXMKnGHAV4SCNfExpYwJaLvlDg+kqHba09MlQhhU38j9/DSwhMWI4uQrDZ7LiiL+T3t4UKlqDEO2cdXws6GStQNna1489R3cOhdoNFxv/bJuEBySjMylMTxhYbkiCHeE+od0ffyYEyzOoT7CFjXwlU6DiJZxzIt8L85cR8LSWXpq1ZFoKS4aa55Rq59qc5MzzCnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVy7oG4wWEITGPzu5DzbLJCFYUqOWjNTKoTxTRB0Lro=;
 b=J7gRcWjaHwo9kcM3WmUYWWvvsPf2QeL/QGNMy8UlfbhMd1B6BUSL6Rf+r/YMtIPJGegU9dTpNQYZGcwacs8p3z5lwQUNq0sP9Bpjgiw/kSlAb3UXjYcRl1eZYqdo0yf0Bg5f7Yv9PKxuWSp3XwEG3kdaQmFn8W78U4n21iNDXkg=
Received: from BN9PR03CA0954.namprd03.prod.outlook.com (2603:10b6:408:108::29)
 by PH0PR12MB7011.namprd12.prod.outlook.com (2603:10b6:510:21c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 14:58:14 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:408:108:cafe::e9) by BN9PR03CA0954.outlook.office365.com
 (2603:10b6:408:108::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.20 via Frontend Transport; Mon,
 18 Aug 2025 14:58:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 18 Aug 2025 14:58:13 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 09:58:11 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <Stanley.Yang@amd.com>, <Hawking.Zhang@amd.com>,
 <kevinyang.wang@amd.com>, <YiPeng.Chai@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH 4/4 v5] drm/amdgpu: Correct the loss of aca bank reg info
Date: Mon, 18 Aug 2025 22:57:57 +0800
Message-ID: <20250818145757.318636-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|PH0PR12MB7011:EE_
X-MS-Office365-Filtering-Correlation-Id: fafe52ed-0674-4347-c975-08ddde67a80f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wxTytCNCy9F6BJnhEotXxUkU2lh+EU0BKitwa6bsI48TXGn/Sjmr7fqnpl0w?=
 =?us-ascii?Q?Bfu5aWb9Ff6cNnCbMJsK8HG2wiR4+axPBasNifXj3l+8ACq+zCQYtNCtbt1R?=
 =?us-ascii?Q?kMEAQTWsmIAyh4htuz1hTJAg1C8AUrEkGR0kPDto577p0VhqUR4Z8X3KmA1S?=
 =?us-ascii?Q?o1cmtfCp+MZLMfdYzS13SaF354LJSwNc0WRerEMZujBqE6nB97CWXawaJFfP?=
 =?us-ascii?Q?OxsPUjx5xoIS436tReIrPAARXGQGBwF9/8+rOh5sRoOEq+rsEblydYUL3C4A?=
 =?us-ascii?Q?jp+7VARErEaAZlIMoB8NK3oAJfxoiOVEOeIlgayX9mWLbtAvBLMWUQfiZzIi?=
 =?us-ascii?Q?mex7gWQGfNeta6z0TzEsubo+/svXk1BiZzNlNNNACMVBmCAsduG8k3PxL7E/?=
 =?us-ascii?Q?n9egSH5eSSnZ6VAuMoO/+VrRYxDd/bAIcE6mn7R1j/MHDm0uMCLEfwE8ZF6m?=
 =?us-ascii?Q?PJTU6MlwMJ0I/D79zXpYFEi6mkE0NfjiPCcBGcr41V+IptY9OF1zc+lATsEW?=
 =?us-ascii?Q?m4P4S5ArHqBHLU5Lg1g3hrhEZ/u6xryLSLbLpgHP/B0SeEzkveuDzN7XamJQ?=
 =?us-ascii?Q?4FO2D/RHg2SxPGLODuLAI4rD6siPg4L7vRwTpbpLPS7+9HfuhD1zTQOkStny?=
 =?us-ascii?Q?R+VoiAmxdZpHWodVzRLa8TSKBl2fdLLqRjOLO+pdY1EXlIURGQv67libCPYr?=
 =?us-ascii?Q?UgXzkRQGBT4UQ9KSi5NQvhzf0vNzUb8QN16r82UmROkhIKGGHGMMSesBVEbG?=
 =?us-ascii?Q?abSwFBE+fhS34v24ZDhiIeyH94q0mE2+X6O/FK8dGNdKKZdjDn2J1yTad886?=
 =?us-ascii?Q?bd81X2mFl6V0QSceiYwWHlGWseclqTN1WndkhobjyD6o2BBjKWWBwtTXSV9e?=
 =?us-ascii?Q?j1il47BAqIYa+XvG66TAWGbxuot0xT/J2/dpezUGn4fjpGpjxG+5vhds+NJj?=
 =?us-ascii?Q?w0oDufzKSZki8ZKqMnezeSE0Itla4GfUppa6KFX+iZuhWJrEVrjp+7Gu3Cke?=
 =?us-ascii?Q?EMDD62Ec22RdPdc2K45xIXSHmNGPyKxM1PS7UKw/m0JlN/MO4mET0OE2y0FB?=
 =?us-ascii?Q?cWJjJBb4aABWCpMDjtn9M1AeeNB6lMhdIRITe3pAnlsO5fxbCJncDzPkJehv?=
 =?us-ascii?Q?rp96y+zgCmkhjwWSvAQ9CRbkeCnOFr+VzJpmzS2xN9mBFCXRqI4OH4YbiGu6?=
 =?us-ascii?Q?WtCOIFxi7CoWIlAdvMUUPFdbvJxbNkRU9obXtI6b3qgS2iy/OUmJc+W35h9H?=
 =?us-ascii?Q?Z11aT+x9iUlqHw2/xPfh+UT/BrvFi5GYLrpf4lMp3ViOf7psub4RXj0WPvzP?=
 =?us-ascii?Q?2ZwADn+id0trwsfMjh4dQD73M4xVJsQG+mOJwMPYRMBWe12yzTArrLSgbx6w?=
 =?us-ascii?Q?l4YAg6Oyl+e48fiYgOxSQzjKCeJIGtAB8yuFBVx9ViJc2xVDHMSMoCnY6bhz?=
 =?us-ascii?Q?35bgA9IjTKfjEQ+4jARidMn5MdbVytbTzn8MHU/pGsJPQN9c3Rbd4L0qlEPc?=
 =?us-ascii?Q?DeV0QCi/thwyt1gvzUj6K3UwFy+h1DlqXExm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 14:58:13.8643 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fafe52ed-0674-4347-c975-08ddde67a80f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7011
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

v5: continuously inject ce. If a creation interruption occurs at this time,
bank reg info will be lost. (Thomas)
v5: each cycle is delayed by 5ms. (Tao)

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 74 ++++++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c |  1 +
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  |  9 ++-
 4 files changed, 51 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 31850a47a41f..a779336e2fd3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -122,7 +122,7 @@ const char *get_ras_block_str(struct ras_common_if *ras_block)
 /* typical ECC bad page rate is 1 bad page per 100MB VRAM */
 #define RAS_BAD_PAGE_COVER              (100 * 1024 * 1024ULL)
 
-#define MAX_UMC_POISON_POLLING_TIME_ASYNC  300  //ms
+#define MAX_UMC_POISON_POLLING_TIME_ASYNC  200
 
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
+			msleep(5);
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
+		if (total_detect_count >= MAX_BANK_COUNT && consumption_q_count)
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

