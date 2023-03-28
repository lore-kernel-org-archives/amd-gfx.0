Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0BCC77B6D
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 15:15:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED44F10E91B;
	Tue, 28 Mar 2023 15:15:04 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4363A10E90A
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 15:14:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKp6azQWFVBqHpIwr7wEctWY3YPYWmDQPIbYXb9v5E2hX5r5bdhce5qmkg3b6D1dxqcMKJAi2fuEht26Got77lNyxkCuO58qXV7Gnt5xAET4qfxXHpwf0ky5jqai2APVRcL/2SK+Mc2DOdfPtgWbsbzi/mfpF30FkAr4NDm6X0tmP0fXbFscP89T8XxHf+nXrNtAAyZSrCbj6IKRMcX/Qflz82chTpXR3AVAG6UZr8EB6zxw/UhAPNWXUWL2uSC6zU/FVPRaGUupLlDPRLJu3cHT8dVyFF1VdO8P91k4/LAPN1uF5qhTkNSoQGMtW81Sd/OWCYMvmhCrk03Leo/3MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwlA3iuA5IUoUkvpgBkJBiCIcVUhJoy/FViIcDQrCcQ=;
 b=RLETzvRS69jTy6VYL1nRwwcBYbfZjpjq6ZusJwQj4HgS/XEhvJuLfUP15817+3ygG1CWcZqwG4+p3Xn1T0fgwE2hAZP5+3hLQmcIPKDQwlmuWPOTNuXRh1B6um5XJDtKDU73rPS8pT2wRBuC6v7R8woEyS2hbuqIa+03sGjLzMRS0Oo3xUvUiBPotUOXL+Divz9vNG+kjbxeSG9eZDDTZ7Y1efN5BGMzkNilwftPJLFuQ/LoU0mjAhpsBmmZJ9fGGvd32YY+YIyjfZUno1rw4LjKuTs4/F4idw0giTg80ZwhzC5HAXGUFtwodIf1ZWcBkb+CFtY9nASpUp3amrB8iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwlA3iuA5IUoUkvpgBkJBiCIcVUhJoy/FViIcDQrCcQ=;
 b=WLuwkIL8KCxBf6uUrP0f3JzJ5muFGaSz4CFn08tVBH/D+RzIHD9x+HjyRAzYZ/cBmfpwkaX7FtE5L0WncQ5/uBuVWPfFMPZ00AJujhqOwRU6+Pk6cGmkbeilDy/VSPEXcW2Kd42yvMK/uUt783Qqa6titc14X2wOCEU96oKefPE=
Received: from BN0PR02CA0051.namprd02.prod.outlook.com (2603:10b6:408:e5::26)
 by DM4PR12MB5844.namprd12.prod.outlook.com (2603:10b6:8:67::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Tue, 28 Mar
 2023 15:14:38 +0000
Received: from BL02EPF000100D3.namprd05.prod.outlook.com
 (2603:10b6:408:e5:cafe::55) by BN0PR02CA0051.outlook.office365.com
 (2603:10b6:408:e5::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.42 via Frontend
 Transport; Tue, 28 Mar 2023 15:14:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 28 Mar 2023 15:14:37 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 10:14:36 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/32] drm/amdkfd: Update context save handling for multi XCC
 setup (v2)
Date: Tue, 28 Mar 2023 11:13:24 -0400
Message-ID: <20230328151344.1934291-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328151344.1934291-1-alexander.deucher@amd.com>
References: <20230328151344.1934291-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D3:EE_|DM4PR12MB5844:EE_
X-MS-Office365-Filtering-Correlation-Id: cb2ce968-34ba-4fc0-d244-08db2f9f2585
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2QJY/FV3T4DSWJto1sGET1YKAiXLDdwzzDbrFC4z2PhDk8hVLSKEVZUoCecd9XiZ6SlIkQDaNZdx9kB4W3Y6Zku4AQj9giCUKpO8VikWU9YH/ciJsYjgNe/xwCLPlp54s66ZZKR45j4rSox+YClimjSuDFHwJKY39UYi+Stl8wsCwmKrQWMGY2x3YT1CkhmpK/ovDEKxRpt8G+MpPzrHJZgyW/SsfzXd7/RD1P7dA35VXPxRbKLYkGvWVj1jLZcSpEv2MIa0uy/aSahG8aBbbHuQb/kcdjYoShGMFVm9O114GDNL3mlCK76iJWDr9Opx3MNrrb/5z6owJAwGksQpF6BSvwQQdAcKnwlXEwMY1wRc4f5gxNAr/SkuowNOqxCstvOyxDEIW95GpMdqhOX3CCIKnOKOkFHXx99wKgAHPipfGxZhhIu2gTdQ6vutLZFLMUAtiwfao5psbpI7Toz9LA1tDzSHxIDJaHrSWVckhKNzzeJjWqIqo7JiaoNMn4Plxr8wCEevgeNVdOz2LeEW8P0DoXQgcQJf82pP3DfdmvldcdZfr5I5AjIyHrzPzST5rrvkCKrCKxvN7yq2TjGrQSOmqJelRWcF2cp4I2rWaqfPK7fxcZJ6kyyVCX26PUTk3rk56tjrZVY7OlbiBqJZfIEbmtBuXcdC+qaBxwLFCU2j/IwRMzoCgrUJx1sfEFYtJ3IDOI89Z68wzapZgUsrrBqeO8lBydbQ45fKtnOljcE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(16526019)(26005)(1076003)(426003)(40480700001)(41300700001)(186003)(6666004)(7696005)(83380400001)(336012)(2616005)(47076005)(478600001)(54906003)(316002)(36860700001)(40460700003)(4326008)(15650500001)(70206006)(70586007)(8676002)(6916009)(2906002)(81166007)(82740400003)(356005)(82310400005)(36756003)(86362001)(5660300002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 15:14:37.8577 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb2ce968-34ba-4fc0-d244-08db2f9f2585
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5844
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
Cc: Amber Lin <Amber.Lin@amd.com>, Mukul Joshi <mukul.joshi@amd.com>, Felix
 Kuehling <Felix.Kuehling@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>, Morris Zhang <Shiwu.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mukul Joshi <mukul.joshi@amd.com>

Context save handling needs to be updated for a multi XCC
setup:
- On a multi XCC setup, KFD needs to report context save base
  address and size for each XCC in MQD.
- Thunk will allocate a large context save area covering all
  XCCs which will be equal to: num_of_xccs in a partition * size
  of context save area for 1 XCC. However, it will report only the
  size of context save area for 1 XCC only in the ioctl call.
- Driver then setups the MQD correctly using the size passed from
  Thunk and information about number of XCCs in a partition.
- Update get_wave_state function to return context save area
  for all XCCs in the partition.

v2: update the get_wave_state function for mqd manager v11 (Morris)

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Tested-by: Amber Lin <Amber.Lin@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Morris Zhang <Shiwu.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h  |  1 +
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c  |  1 +
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c  |  1 +
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 62 ++++++++++++++++++-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c   |  1 +
 6 files changed, 67 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index a49ac19ca12e..07a04c41e92a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2095,8 +2095,8 @@ static int get_wave_state(struct device_queue_manager *dqm,
 	 * and the queue should be protected against destruction by the process
 	 * lock.
 	 */
-	return mqd_mgr->get_wave_state(mqd_mgr, q->mqd, ctl_stack,
-			ctl_stack_used_size, save_area_used_size);
+	return mqd_mgr->get_wave_state(mqd_mgr, q->mqd, &q->properties,
+			ctl_stack, ctl_stack_used_size, save_area_used_size);
 }
 
 static void get_queue_checkpoint_info(struct device_queue_manager *dqm,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
index eb18be74f559..23158db7da03 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
@@ -97,6 +97,7 @@ struct mqd_manager {
 				uint32_t queue_id);
 
 	int	(*get_wave_state)(struct mqd_manager *mm, void *mqd,
+				  struct queue_properties *q,
 				  void __user *ctl_stack,
 				  u32 *ctl_stack_used_size,
 				  u32 *save_area_used_size);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
index d54c6fdebbb6..772c09b5821b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
@@ -227,6 +227,7 @@ static uint32_t read_doorbell_id(void *mqd)
 }
 
 static int get_wave_state(struct mqd_manager *mm, void *mqd,
+			  struct queue_properties *q,
 			  void __user *ctl_stack,
 			  u32 *ctl_stack_used_size,
 			  u32 *save_area_used_size)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
index e7acde3a849b..31f7732166fa 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
@@ -253,6 +253,7 @@ static uint32_t read_doorbell_id(void *mqd)
 }
 
 static int get_wave_state(struct mqd_manager *mm, void *mqd,
+			  struct queue_properties *q,
 			  void __user *ctl_stack,
 			  u32 *ctl_stack_used_size,
 			  u32 *save_area_used_size)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 89f8ba8a127c..09083e905fee 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -294,6 +294,7 @@ static uint32_t read_doorbell_id(void *mqd)
 }
 
 static int get_wave_state(struct mqd_manager *mm, void *mqd,
+			  struct queue_properties *q,
 			  void __user *ctl_stack,
 			  u32 *ctl_stack_used_size,
 			  u32 *save_area_used_size)
@@ -560,6 +561,7 @@ static void init_mqd_v9_4_3(struct mqd_manager *mm, void **mqd,
 	int xcc = 0;
 	struct kfd_mem_obj xcc_mqd_mem_obj;
 	uint64_t xcc_gart_addr = 0;
+	uint64_t xcc_ctx_save_restore_area_address;
 	uint64_t offset = mm->mqd_stride(mm, q);
 
 	memset(&xcc_mqd_mem_obj, 0x0, sizeof(struct kfd_mem_obj));
@@ -569,6 +571,23 @@ static void init_mqd_v9_4_3(struct mqd_manager *mm, void **mqd,
 		init_mqd(mm, (void **)&m, &xcc_mqd_mem_obj, &xcc_gart_addr, q);
 
 		m->cp_mqd_stride_size = offset;
+
+		/*
+		 * Update the CWSR address for each XCC if CWSR is enabled
+		 * and CWSR area is allocated in thunk
+		 */
+		if (mm->dev->kfd->cwsr_enabled &&
+		    q->ctx_save_restore_area_address) {
+			xcc_ctx_save_restore_area_address =
+				q->ctx_save_restore_area_address +
+				(xcc * q->ctx_save_restore_area_size);
+
+			m->cp_hqd_ctx_save_base_addr_lo =
+				lower_32_bits(xcc_ctx_save_restore_area_address);
+			m->cp_hqd_ctx_save_base_addr_hi =
+				upper_32_bits(xcc_ctx_save_restore_area_address);
+		}
+
 		if (q->format == KFD_QUEUE_FORMAT_AQL) {
 			m->compute_tg_chunk_size = 1;
 
@@ -688,6 +707,46 @@ static int load_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
 	return err;
 }
 
+static int get_wave_state_v9_4_3(struct mqd_manager *mm, void *mqd,
+				 struct queue_properties *q,
+				 void __user *ctl_stack,
+				 u32 *ctl_stack_used_size,
+				 u32 *save_area_used_size)
+{
+	int xcc, err = 0;
+	void *xcc_mqd;
+	void __user *xcc_ctl_stack;
+	uint64_t mqd_stride_size = mm->mqd_stride(mm, q);
+	u32 tmp_ctl_stack_used_size = 0, tmp_save_area_used_size = 0;
+
+	for (xcc = 0; xcc < mm->dev->num_xcc_per_node; xcc++) {
+		xcc_mqd = mqd + mqd_stride_size * xcc;
+		xcc_ctl_stack = (void __user *)((uintptr_t)ctl_stack +
+					q->ctx_save_restore_area_size * xcc);
+
+		err = get_wave_state(mm, xcc_mqd, q, xcc_ctl_stack,
+				     &tmp_ctl_stack_used_size,
+				     &tmp_save_area_used_size);
+		if (err)
+			break;
+
+		/*
+		 * Set the ctl_stack_used_size and save_area_used_size to
+		 * ctl_stack_used_size and save_area_used_size of XCC 0 when
+		 * passing the info the user-space.
+		 * For multi XCC, user-space would have to look at the header
+		 * info of each Control stack area to determine the control
+		 * stack size and save area used.
+		 */
+		if (xcc == 0) {
+			*ctl_stack_used_size = tmp_ctl_stack_used_size;
+			*save_area_used_size = tmp_save_area_used_size;
+		}
+	}
+
+	return err;
+}
+
 #if defined(CONFIG_DEBUG_FS)
 
 static int debugfs_show_mqd(struct seq_file *m, void *data)
@@ -725,7 +784,6 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
 		mqd->allocate_mqd = allocate_mqd;
 		mqd->free_mqd = kfd_free_mqd_cp;
 		mqd->is_occupied = kfd_is_occupied_cp;
-		mqd->get_wave_state = get_wave_state;
 		mqd->get_checkpoint_info = get_checkpoint_info;
 		mqd->checkpoint_mqd = checkpoint_mqd;
 		mqd->restore_mqd = restore_mqd;
@@ -739,11 +797,13 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
 			mqd->load_mqd = load_mqd_v9_4_3;
 			mqd->update_mqd = update_mqd_v9_4_3;
 			mqd->destroy_mqd = destroy_mqd_v9_4_3;
+			mqd->get_wave_state = get_wave_state_v9_4_3;
 		} else {
 			mqd->init_mqd = init_mqd;
 			mqd->load_mqd = load_mqd;
 			mqd->update_mqd = update_mqd;
 			mqd->destroy_mqd = kfd_destroy_mqd_cp;
+			mqd->get_wave_state = get_wave_state;
 		}
 		break;
 	case KFD_MQD_TYPE_HIQ:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
index ebf963f42b51..fe69492b1bb3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
@@ -261,6 +261,7 @@ static void update_mqd_tonga(struct mqd_manager *mm, void *mqd,
 }
 
 static int get_wave_state(struct mqd_manager *mm, void *mqd,
+			  struct queue_properties *q,
 			  void __user *ctl_stack,
 			  u32 *ctl_stack_used_size,
 			  u32 *save_area_used_size)
-- 
2.39.2

