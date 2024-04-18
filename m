Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36749C001CC
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Apr 2024 03:02:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C4DC11394A;
	Thu, 18 Apr 2024 03:02:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t9su67pm";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94658113949
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Apr 2024 03:02:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=niwPW8wEc9fELyhdjFOXqAmC42WW1Epi+D+91lf19+JOyKD1zqMB9QtSVbULyawy9sw1LyOGr+JlKYQa2WnD7uRUKmmXWOjG4KB4X6gXuR3cg3ghaGBIUlCB1t1X30SklSu8TRqYhvmfF4V8BbMPYFrrTF5xtlzP/v3c85nFNrxDgHX9WSI2N1hsB+di/VQciMnCDeMZiT1/B7P7ttmJHY/8xrc0tvBLfXKOInvCuzA/WltwjV8rYSa70MqyBhGXHC1ac1tPiZCW5bwKHL07WhjHGyJqRoF1ZxEvHYqaVb15I3R6z58yRlgGUYYxKwvSrG1h2Lc7wgL6g/sGbAMx3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqAn2ZZP8FAjo7AiLEzpEORHzAwXvDzwPhGtpHlrQWc=;
 b=C8jtv2KCF+uTlwtTyZwojoPWgXZ9Gr2gEGqevK+MlIb4mpHrQBV6Au+0jQbzE3xx+ivl9ertTEAxiQc1oduO2dqqJFCqpbs2+N2hhMRWBbSEAn9ClKSYQzicSGTAwpvtWaRsEByGsnT2xAoA3mxn3gcj19stoY0TonrGM7FtRKL/p0RUnwhdthcSl5aNZUop9V/ESYe0VP6gitlXBTKxhi+XgV53/BCD5335FDJXs9kLt7rToRO4a7MMfiXVKKqgR3A+KUxOE7tHk80sWhHqWmFdGheFCTEUyExamDBZTU8Pqx8mqCuNd8BtqWqm98uPO+vx/9CAFzrLyEfJJZLErg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqAn2ZZP8FAjo7AiLEzpEORHzAwXvDzwPhGtpHlrQWc=;
 b=t9su67pm+DOswag+XHAWYQ5uOeQwwCWMXoQkXoARVRgtg17Qc152ePp6Q8OOjjj0Qv+j7QV4JNrYRGGBwzenOEm/xkdEBjGVb5nWCd0y/uJyqxGkzBYW8hBvjRoGD0Xv6EHh1OS+D37tkqgwnvtR0kvFmPWpjFJf3BNKs52EpQI=
Received: from MN2PR05CA0028.namprd05.prod.outlook.com (2603:10b6:208:c0::41)
 by MW6PR12MB8868.namprd12.prod.outlook.com (2603:10b6:303:242::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 03:02:01 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:c0:cafe::b9) by MN2PR05CA0028.outlook.office365.com
 (2603:10b6:208:c0::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.20 via Frontend
 Transport; Thu, 18 Apr 2024 03:02:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 03:02:00 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 17 Apr
 2024 22:01:57 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yipechai@amd.com>, <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>,
 <Candice.Li@amd.com>, <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH 11/15] drm/amdgpu: prepare to handle pasid poison consumption
Date: Thu, 18 Apr 2024 10:58:32 +0800
Message-ID: <20240418025836.170106-11-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418025836.170106-1-YiPeng.Chai@amd.com>
References: <20240418025836.170106-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|MW6PR12MB8868:EE_
X-MS-Office365-Filtering-Correlation-Id: 45738085-ed2f-49c8-7e5e-08dc5f53eaf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C5ePtE7d/1sZAGEPjBXBmoxu3ZbGH44Aat3xtb1hA4eY+TRp9yyy6vx0VLWLlAwAw9MAmNlMn1XObR1lHWCQbPM69xn4yDMUeTG2QiDdAzgUHuD16vxssTqqA/331YvzXWa/uhK4mIHMA8u5OxaZPVUXHkDTBuC9eRjPIcT4fkIF3Y2ZoOSTLfKKXlkaiE0OYXUOcf3fH3xvyLunYTn/vBfU71f4xmwtzFb+9s+Fi6usP7QqpAY18t0QcoqT6SoB+f8lU0XRC5J982D/uwdWxl6tO4lJzlqT96dOs0J11MN6ygsy8QEZVbSE8ogu9wOrhJP++3n+TrPp359zxJxH/mcKzDLxznbY/dwazmor7umM9N6Y/DcwJX3LQcfCmG085tBbG9NRI6gJYEJ66llkzfGxPLag7zXNThDaIHSnlyjliwNRfylYTT4MMsFqIuOwGzI8beEvvEV2TF8fVoAsPvZ9cg+pkIeoea4YSj/fUns5qIaewGGi4RcxjP57ic3BWoz6/jtYewlyz9KHTSM5ytqgQfVLyR5G40RwTIx5xB1tzy0DHboulepdEzpDkzY+ErqkgyiImgP5TfDHaWttfdMALpVbjkg+80unaIrz4n0B+DGJjNxb/W488GDdaJVmRb5kXH2Xm/HzLKrJbNt3v4Cg0WK82gpG/tGTUwG/D2Lu8duSYcI7zNZFN1cWjzc/fhR3iS4KVzCWADmttYbqhSmc5IFa/m3cRMwIiEsWYJnnUpImgNdmddnopfr2FY1Z
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 03:02:00.3115 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45738085-ed2f-49c8-7e5e-08dc5f53eaf4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8868
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

Prepare to handle pasid poison consumption.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  9 ++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       | 20 ++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h       |  3 +++
 .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   |  3 ++-
 5 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 66753940bb4d..287ce431901c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -759,10 +759,17 @@ bool amdgpu_amdkfd_is_fed(struct amdgpu_device *adev)
 	return amdgpu_ras_get_fed_status(adev);
 }
 
+void amdgpu_amdkfd_ras_pasid_poison_consumption_handler(struct amdgpu_device *adev,
+				enum amdgpu_ras_block block, uint16_t pasid,
+				pasid_notify pasid_fn, void *data, uint32_t reset)
+{
+	amdgpu_umc_pasid_poison_handler(adev, block, pasid, pasid_fn, data, reset);
+}
+
 void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *adev,
 	enum amdgpu_ras_block block, uint32_t reset)
 {
-	amdgpu_umc_poison_handler(adev, block, reset);
+	amdgpu_umc_pasid_poison_handler(adev, block, 0, NULL, NULL, reset);
 }
 
 int amdgpu_amdkfd_send_close_event_drain_irq(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index ad50c7bbc326..54e15994d02b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -401,6 +401,11 @@ int amdgpu_amdkfd_get_tile_config(struct amdgpu_device *adev,
 				struct tile_config *config);
 void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *adev,
 			enum amdgpu_ras_block block, uint32_t reset);
+
+void amdgpu_amdkfd_ras_pasid_poison_consumption_handler(struct amdgpu_device *adev,
+			enum amdgpu_ras_block block, uint16_t pasid,
+			pasid_notify pasid_fn, void *data, uint32_t reset);
+
 bool amdgpu_amdkfd_is_fed(struct amdgpu_device *adev);
 bool amdgpu_amdkfd_bo_mapped_to_dev(struct amdgpu_device *adev, struct kgd_mem *mem);
 void amdgpu_amdkfd_block_mmu_notifications(void *p);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index dcda3d24bee3..8ebbca9e2e22 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -252,8 +252,9 @@ int amdgpu_umc_bad_page_polling_timeout(struct amdgpu_device *adev,
 	return 0;
 }
 
-int amdgpu_umc_poison_handler(struct amdgpu_device *adev,
-			enum amdgpu_ras_block block, uint32_t reset)
+int amdgpu_umc_pasid_poison_handler(struct amdgpu_device *adev,
+			enum amdgpu_ras_block block, uint16_t pasid,
+			pasid_notify pasid_fn, void *data, uint32_t reset)
 {
 	int ret = AMDGPU_RAS_SUCCESS;
 
@@ -291,16 +292,14 @@ int amdgpu_umc_poison_handler(struct amdgpu_device *adev,
 
 			amdgpu_ras_error_data_fini(&err_data);
 		} else {
-			if (reset) {
-				amdgpu_umc_bad_page_polling_timeout(adev,
-							reset, MAX_UMC_POISON_POLLING_TIME_SYNC);
-			} else {
 				struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 
+				amdgpu_ras_put_poison_req(adev,
+					block, pasid, pasid_fn, data, reset);
+
 				atomic_inc(&con->page_retirement_req_cnt);
 
 				wake_up(&con->page_retirement_wq);
-			}
 		}
 	} else {
 		if (adev->virt.ops && adev->virt.ops->ras_poison_handler)
@@ -313,6 +312,13 @@ int amdgpu_umc_poison_handler(struct amdgpu_device *adev,
 	return ret;
 }
 
+int amdgpu_umc_poison_handler(struct amdgpu_device *adev,
+			enum amdgpu_ras_block block, uint32_t reset)
+{
+	return amdgpu_umc_pasid_poison_handler(adev,
+				block, 0, NULL, NULL, reset);
+}
+
 int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
 		void *ras_error_status,
 		struct amdgpu_iv_entry *entry)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index 9e77e6d48e3b..5f50c69c3cec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -106,6 +106,9 @@ int amdgpu_umc_ras_sw_init(struct amdgpu_device *adev);
 int amdgpu_umc_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block);
 int amdgpu_umc_poison_handler(struct amdgpu_device *adev,
 			enum amdgpu_ras_block block, uint32_t reset);
+int amdgpu_umc_pasid_poison_handler(struct amdgpu_device *adev,
+			enum amdgpu_ras_block block, uint16_t pasid,
+			pasid_notify pasid_fn, void *data, uint32_t reset);
 int amdgpu_umc_process_ecc_irq(struct amdgpu_device *adev,
 		struct amdgpu_irq_src *source,
 		struct amdgpu_iv_entry *entry);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index c368c70df3f4..6bf4bbc3cffa 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -201,7 +201,8 @@ static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
 			"RAS poison consumption, fall back to gpu reset flow: client id %d\n",
 			client_id);
 
-	amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, block, reset);
+	amdgpu_amdkfd_ras_pasid_poison_consumption_handler(dev->adev,
+		block, pasid, NULL, NULL, reset);
 }
 
 static bool context_id_expected(struct kfd_dev *dev)
-- 
2.34.1

