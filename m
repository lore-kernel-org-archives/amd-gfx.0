Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3FFF1075262
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2026 07:00:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F42210E137;
	Thu, 19 Mar 2026 07:00:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kZp5hLBM";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010048.outbound.protection.outlook.com [52.101.201.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DE1B10E137
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2026 07:00:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l593EwSOF7aA1IUsWOwUWb07odOlp3yzWybr40IkMVquhoR6DbX9VJba3T9l8uprCvmZ1hQVMjkYrjatq62vjsvM5ggasIPt7O9vhocQzSriMoUoQ93Dvzz4zLmGmRsPqXYydif9iNoNfCaCh+ODLFyYiuuDpZRo/UaHW5Ta3t+vNP1/3T5ZMGuefAvPkaQlPfoZj1QFCdFMSc834FQ+KnlYOov8RKcVDawu8/x6mNONCE1nHHkjWo6HbpdIuN3X6SAAX+LomAotRFy3X5emGb4kUJgFw8ox4RbOc0nS3Yom/LCfnOciJOMQZKuvut20F6azYAR0E4vNx2/9WeaMqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8XnHtDpt/RaJ93c4064vm2Ja07hJBNF4mwIKKP85ksU=;
 b=M+ll9yLXYIMf2/yQ2TR5H9qd7Pm/tEwI7ai0t67gdnkLZ2fqLRVwtRxkEVVbTBWZSRm8Dc7VvrtVb0EdwpHcbJVTOTOeUhpD1vAh87KudiICzQWHEHFxKky1OG/xdpMwBqgqgtPGJoPMYrFtpVInfEEE0QTXxHTTQSt1jrdmYE72OTkrn8ZVRAUxAMFs27HNbHUHeJWmYQ6HVl8liuPsWkGAZ/yUVizYpWrsHmIEjo1yOvXl8b8LlNk418C+mluuTptiVo+BUnF3nSwLjJRv7tqC7gNqj1OUsLVldz3f4zTPTQVwjbCIwCAT2in+KsXKPbrjcK8vpNX2vmUDAf3uFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XnHtDpt/RaJ93c4064vm2Ja07hJBNF4mwIKKP85ksU=;
 b=kZp5hLBMC/WoUMqhdCRRAREn3WDiD2Oyga+ZQvemMUuC7W/OhgNCiZmaXMUuBT4TtRRy4QVD2XC8UB0pFiAYggc5fAjq5vjG/iMAz4hCPxYXO59NbfwUueOB7CSbwOz6WNHALJf/LHQNMU3lSTfmg5xX3oB0qwqSxMybvlEZZVs=
Received: from CH2PR17CA0025.namprd17.prod.outlook.com (2603:10b6:610:53::35)
 by DM3PR12MB9349.namprd12.prod.outlook.com (2603:10b6:0:49::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 07:00:38 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:610:53:cafe::39) by CH2PR17CA0025.outlook.office365.com
 (2603:10b6:610:53::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend
 Transport; Thu, 19 Mar 2026 07:00:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.0 via Frontend Transport; Thu, 19 Mar 2026 07:00:38 +0000
Received: from yifan.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 19 Mar
 2026 02:00:36 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <Perry.Yuan@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH] drm/amdkfd: check system memory when set apt_prefer_gtt
Date: Thu, 19 Mar 2026 15:00:10 +0800
Message-ID: <20260319070010.135987-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|DM3PR12MB9349:EE_
X-MS-Office365-Filtering-Correlation-Id: 0397daac-3e54-45f4-fe86-08de858539f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: elTLG6t+FsFGDIx4HgSujXpJMo7aFN5lFRW/BqpE12O9DShw46VlPwoo++R1gM/JQ8bmLS90iabz5wiR6UUcxzkhAmL+wTEkOnEmlLz3fJT0kMvN0i8OYVZEy9mhp7BtEBVI4vAEWHpFbndoMyA8M3QOF4C5CRDHpQYLeE+KF4noGB9QF+fs5li0QnofdD4u8/tYMUG7Dp+v+HFytp0uGEfSvW8qNLHjsuO2RzjVTCcjaAGewDQqj/yzoZIH4bPzj0OgpkpUfmwTC2xavh2Dj8NCVB1T0bgLAndY3s3njvrK0iNYCFOwaf8ZO/caH7TqxP3/eWImuKto0gedOy7uLEJwdkXpQpzV1SMtON/FmvJQeSsAP21Skn/EloMLENbxXAMkddPMU8kzwQoUpu6g5nOo8RIUIHry3zqr46I5NN8rdhZx8I09A0ZvqZIGNHDlq3/tIC5VYF146Vc4DQNTodAdw0Off952G2S90F4Enhg0ZnuLPv7Y4IoQFRXIfi1xN8gxSnSVMPYhH6mkYQj5DDsSAwIYvnlWZecwxNWPhFt0oTnVX7hANx+YwbxVxURL1L5DqcP8fcwfIqzBnWuB9schu/y523OKMXf28js9/nXOpfoLGSIBm5OQh0obum2sIE/YzTw29fbpZe2cIOw/T2ofqR/xWhLamTQSCdp++si9HBKkP6JtY8YUVR+pX036ILla8uOUDtYy3a4paGGQYhuh2Tij5Zphkox1CvGN7IrMn0yVAKwproTr/a5SsmQIPsN8Sn7iDOGMIFldeaWRtA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GJz9MBzQcp4jGv6xZjMa3FyNPvQFqg7+VzHbXdRCih5srJno/aPDEn1lG4JExfGi2Cu6XIGALjdBPZsxTw9MreUUz9nq1UimqTG08/RusiJWMXagSxara8R/BBVe/n1GeBv707zDOdW+4sPbNLtHG7WsKRqffI9ogkxtKic3scrO81CADqvYIFud1SbeMH9UhMjfQTWHO9x+3zqSDLP+Ld/PxUzQjlsUlm2fJ1jTe8akUmqC2nDgOXFgB+nk9+K2ikl9/crAZip77WMpkjHeLjwqPBRDZK0uP/0kwTpVPPrXirxAxdbs1Y/3gfcGnTqkJwgAQTgNwsN779WGuSsgjwizfhqkZsy/iaFnB7vSs8khmNcJk1Hd5Wyl0StHN90H9t6d28XGikT0w/0K+QLfe7zaiLYpKx60jJKOeiIFtZvW4xLRyoHXSKO0LOpmrdbm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 07:00:38.2432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0397daac-3e54-45f4-fe86-08de858539f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9349
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

Current apu_prefer_gtt setting only check gtt_size, which could be set
by user to a larger than system memory value (by ttm modules paramter
pages_limit). E.g. carveout vram 32GB, gtt_size 50GB (by ttm modules
paramter pages_limit), system memory 31GB. In that case, apu_prefer_gtt
will be set incorrectly. Take system memory into account when set
apu_prefer_gtt.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c       | 2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 +++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c          | 7 ++++++-
 4 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 3bfd79c89df3..a6ee9d9bfafb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -170,8 +170,6 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
 	int i;
 	int last_valid_bit;
 
-	amdgpu_amdkfd_gpuvm_init_mem_limits();
-
 	if (adev->kfd.dev) {
 		struct kgd2kfd_shared_resources gpu_resources = {
 			.compute_vmid_bitmap =
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index cdbab7f8cee8..b720f4bd646f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -369,7 +369,7 @@ u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id);
 
 
 #if IS_ENABLED(CONFIG_HSA_AMD)
-void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
+void amdgpu_amdkfd_gpuvm_init_mem_limits(uint64_t *max_system_mem_limit);
 void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
 				struct amdgpu_vm *vm);
 
@@ -382,7 +382,7 @@ void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo);
 void amdgpu_amdkfd_reserve_system_mem(uint64_t size);
 #else
 static inline
-void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
+void amdgpu_amdkfd_gpuvm_init_mem_limits(uint64_t *max_system_mem_limit)
 {
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 8a869fe41acd..4b176ebc7da9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -109,7 +109,7 @@ static bool reuse_dmamap(struct amdgpu_device *adev, struct amdgpu_device *bo_ad
  *  System (TTM + userptr) memory - 15/16th System RAM
  *  TTM memory - 3/8th System RAM
  */
-void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
+void amdgpu_amdkfd_gpuvm_init_mem_limits(uint64_t *max_system_mem_limit)
 {
 	struct sysinfo si;
 	uint64_t mem;
@@ -121,6 +121,7 @@ void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
 	mem = si.totalram - si.totalhigh;
 	mem *= si.mem_unit;
 
+
 	spin_lock_init(&kfd_mem_limit.mem_limit_lock);
 	kfd_mem_limit.max_system_mem_limit = mem - (mem >> 6);
 	if (kfd_mem_limit.max_system_mem_limit < 2 * AMDGPU_RESERVE_MEM_LIMIT)
@@ -129,9 +130,12 @@ void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
 		kfd_mem_limit.max_system_mem_limit -= AMDGPU_RESERVE_MEM_LIMIT;
 
 	kfd_mem_limit.max_ttm_mem_limit = ttm_tt_pages_limit() << PAGE_SHIFT;
+
 	pr_debug("Kernel memory limit %lluM, TTM limit %lluM\n",
 		(kfd_mem_limit.max_system_mem_limit >> 20),
 		(kfd_mem_limit.max_ttm_mem_limit >> 20));
+
+	max_system_mem_limit = kfd_mem_limit.max_system_mem_limit;
 }
 
 void amdgpu_amdkfd_reserve_system_mem(uint64_t size)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 714fd8d12ca5..22ccdaa3a2df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2071,6 +2071,7 @@ static void amdgpu_ttm_buffer_entity_fini(struct amdgpu_gtt_mgr *mgr,
 int amdgpu_ttm_init(struct amdgpu_device *adev)
 {
 	uint64_t gtt_size;
+	uint64_t max_system_mem_limit;
 	int r;
 
 	dma_set_max_seg_size(adev->dev, UINT_MAX);
@@ -2210,8 +2211,12 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	dev_info(adev->dev, " %uM of GTT memory ready.\n",
 		 (unsigned int)(gtt_size / (1024 * 1024)));
 
+
+	amdgpu_amdkfd_gpuvm_init_mem_limits(&max_system_mem_limit);
+
 	if (adev->flags & AMD_IS_APU) {
-		if (adev->gmc.real_vram_size < gtt_size)
+		if (adev->gmc.real_vram_size < gtt_size &&
+			adev->gmc.real_vram_size < max_system_mem_limit)
 			adev->apu_prefer_gtt = true;
 	}
 
-- 
2.43.0

