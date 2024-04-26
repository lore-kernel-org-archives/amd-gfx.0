Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60514C04FFE
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 08:38:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDD1A10EA7E;
	Fri, 26 Apr 2024 08:38:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="stKP5V/s";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F2F810E571
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 08:38:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9BbnLKh4LxBaLa8e8j36+06kghkpixaSDn5dMud3YjTI+KHPv3UHGrjVyKN6jIF5Q0aT+CGlEZJBBAA+Eoaz2P3WD6eFscqPF6uQNjoEzNKhwk0cK3sx7ovq7AC3is2dUeiKjWrDU6WrdkYMT1MSXxW1aPN3rwmycfgHTisIu0/g0XX7be1dsA4zqzudWYtCT5n93AeAq0g5/mTXFA41TJc0zuqEfniq+jNPR8VbG3NZvNeultjLB+cqfIBloC9hdAoaU9t0riCv1m56GzoziEhxnxc/SXyPTcbycild54SqaoGVsjMxYgxPkVh4XvfbAe8wNvaAJPQAOVrdLEWUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vvfl4VpSvtpuTfII/mm/t/tf3A6A8ryD4BJWIWVg2Jk=;
 b=bAD0ebd15863sCz9Q9Ww6bzER8hS9O9KR0v6GpSE/7T5wBlub21z2NjgrJkhr1ilW2eInuriowF35HF5FC0ZGUSX2dnx9F68ta3uPh6/YJ/jXCTGo4YhR3GRkq+Cqde5jjxEktarhpiIJhQieo5O2U3sS0ZSUvNq3lH2Yhf9ubHxcHGvJp6GtScLGnBh7X61AZ/2dlQlpA0Ln2vL4mNb+N6lKE0I4WI4R3J6YrMmg7/56NUaAhWDTcbEOuzGNIzjDTEIFeG4sHzA/hiBKq9kTe70TTgLiuJFq7afoHiEfsD7Mq6r/JwCmY+cIU0VbtyvnunDPLmUqoH8Ohl78TXcuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vvfl4VpSvtpuTfII/mm/t/tf3A6A8ryD4BJWIWVg2Jk=;
 b=stKP5V/sTulrMWvZIb05/OfKWl1O6S04nVNgw47yoVKsFtOWP4jmbAZ3dGQbm8rYrdG/s9seIaCs+7/267t/Onq2e0aos+BbCMZIIGN0+FkP8TVwq/6aWxbwf4P+j0ob0ydNWEWOMK5hKE7Qqbr3paMsQu6fOzfKK2cUD8o2+yI=
Received: from DM6PR06CA0019.namprd06.prod.outlook.com (2603:10b6:5:120::32)
 by CH3PR12MB8583.namprd12.prod.outlook.com (2603:10b6:610:15f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.31; Fri, 26 Apr
 2024 08:38:15 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:5:120:cafe::d1) by DM6PR06CA0019.outlook.office365.com
 (2603:10b6:5:120::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.29 via Frontend
 Transport; Fri, 26 Apr 2024 08:38:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Fri, 26 Apr 2024 08:38:14 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 03:38:10 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <Felix.Kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, Christian Koenig <christian.koenig@amd.com>, "Yifan
 Zhang" <yifan1.zhang@amd.com>, Aaron Liu <aaron.liu@amd.com>, Lang Yu
 <Lang.Yu@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: Allow memory oversubscription on small APUs
Date: Fri, 26 Apr 2024 16:37:50 +0800
Message-ID: <20240426083750.485808-2-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240426083750.485808-1-Lang.Yu@amd.com>
References: <20240426083750.485808-1-Lang.Yu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|CH3PR12MB8583:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ebbd471-021d-4429-078d-08dc65cc36d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400014|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0htoXSdzu5SqtULwI1BElmg3lKWQ50NgBvNW404jQ3HsT/ViT0baCVfymrHM?=
 =?us-ascii?Q?RyQtWtoOaLK2p1qsPyOwYGqBIPC1MS64f2WPbgyAXVjrc5DpImFR1X7rWNTo?=
 =?us-ascii?Q?Hv/745kpwmem3bDTTYGCTkcFmkXRRiebI+6RPMYPOu9OLn2Hb5Oe5fcgUll4?=
 =?us-ascii?Q?WxGVL4vnvohB/aQzb8sSb0sTwK3OQul+ETWSAKBbVB+uWZ50vzNlSkX66uKa?=
 =?us-ascii?Q?rrJ8J47LlAnTc7S43l7OmUslkhVt1VndzLCyqp/iDeE8cohFVudC6TBx9zPe?=
 =?us-ascii?Q?AFUjsA9KSJiyeujH6KtGIuPGa8wQajZOSrvqel9ArBZt6H2wwDqDsWTGnm/Q?=
 =?us-ascii?Q?nN91BDrld6aQdR/MOMZnEzJ0dB0/xkK7gUevjYhhecdW0ga5YGY2korKEABv?=
 =?us-ascii?Q?Yu90eBqhZg/mTxz2Jkg/LI46PGQsaCI463yUs1ujmDgtevti9o1ZxkMnJbS1?=
 =?us-ascii?Q?IhvSCcmBtx/5p7CiJRiUVJ2zhNCMQbTS5zQkaCqdrzgPPg46PGkDOSFgJR2e?=
 =?us-ascii?Q?/eqnrKCkVab5mcMu2d/kGPq+nq0UzLo+gOX6ECWGTd5uhZogReDlBtXuwUXc?=
 =?us-ascii?Q?38kkODfhWawCu/ErzTkOnX+O/rhhfXk1n20b+UV6MQQWIo+W+kWjFfut7mPx?=
 =?us-ascii?Q?0U+8DMyn6cJgIHyVmPWcPR10t6uszBR7BJ30Wa1G+aAbJlidl2FGFt/ZoxgZ?=
 =?us-ascii?Q?cE/R9dihn42favqygH9X3JPHMQlTWgTYn2NJM+QozEQzklhu9n2iOv0DcUXw?=
 =?us-ascii?Q?P2WiDTtAacWJH/a1xHB/JGIccaCWJ6Mj4lgaO4W/WbQg9ThGwPyr14FuMBAr?=
 =?us-ascii?Q?JuP7go2o7hF45mA5Amfkrt4Sou2l7LeH1El+GXurVbLAR56vw3RJKoHzzehO?=
 =?us-ascii?Q?sV+Kl//Q9nvtBPaB38oTw2a0jVR70G3Nhg57Lc0hmU07Rj1mWbVrTp5FsGtw?=
 =?us-ascii?Q?LO6KcBXbzOJgMAdV6T9PJbZJdloZ93KIhddWDPMnL4B6kpk1NBLjr5T3u2Lb?=
 =?us-ascii?Q?7UBE+9YF83Xs623dgOKCsEBLGfMn7pchK61S9+ZAx1BP0LUV96kg3iT/Zq7C?=
 =?us-ascii?Q?vlEg0fdHb2LgVTHWQ8bl3k+LdaYBxaRRxpncP0/0TCJoE7dkujFSqCJvkpAr?=
 =?us-ascii?Q?WujRlbfgVuJh6rxzU9S5w2+8z/+UX3murZf9QlyzSTmC3XRF20GF8dHQXCHz?=
 =?us-ascii?Q?ykwTM3dJ8BsD5PQNLuKh8YFTorHFKGEQNncFlxu6sNo12fL9YYncR5D8tLh+?=
 =?us-ascii?Q?7KKEyjQqYrqE2CX9cZ/uzlaXFA87FXKPt3iz16BqNU4CEwDb3HwVWDxS1Z6i?=
 =?us-ascii?Q?naQBO8rOmYJo/V33CB04jlGrG3isM2zryMM+Bzw2bR0ofSilfm5mPV2h/3SP?=
 =?us-ascii?Q?YBcI+bs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 08:38:14.5673 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ebbd471-021d-4429-078d-08dc65cc36d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8583
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

The default ttm_tt_pages_limit is 1/2 of system memory.
It is prone to out of memory with such a configuration.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 12 +++++++++---
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 3295838e9a1d..c01c6f3ab562 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -167,7 +167,7 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
 	int i;
 	int last_valid_bit;
 
-	amdgpu_amdkfd_gpuvm_init_mem_limits();
+	amdgpu_amdkfd_gpuvm_init_mem_limits(adev);
 
 	if (adev->kfd.dev) {
 		struct kgd2kfd_shared_resources gpu_resources = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 1de021ebdd46..13284dbd8c58 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -363,7 +363,7 @@ u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id);
 
 
 #if IS_ENABLED(CONFIG_HSA_AMD)
-void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
+void amdgpu_amdkfd_gpuvm_init_mem_limits(struct amdgpu_device *adev);
 void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
 				struct amdgpu_vm *vm);
 
@@ -376,7 +376,7 @@ void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo);
 void amdgpu_amdkfd_reserve_system_mem(uint64_t size);
 #else
 static inline
-void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
+void amdgpu_amdkfd_gpuvm_init_mem_limits(struct amdgpu_device *adev)
 {
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 7eb5afcc4895..a3e623a320b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -60,6 +60,7 @@ static struct {
 	int64_t system_mem_used;
 	int64_t ttm_mem_used;
 	spinlock_t mem_limit_lock;
+	bool alow_oversubscribe;
 } kfd_mem_limit;
 
 static const char * const domain_bit_to_string[] = {
@@ -110,7 +111,7 @@ static bool reuse_dmamap(struct amdgpu_device *adev, struct amdgpu_device *bo_ad
  *  System (TTM + userptr) memory - 15/16th System RAM
  *  TTM memory - 3/8th System RAM
  */
-void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
+void amdgpu_amdkfd_gpuvm_init_mem_limits(struct amdgpu_device *adev)
 {
 	struct sysinfo si;
 	uint64_t mem;
@@ -130,6 +131,7 @@ void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
 		kfd_mem_limit.max_system_mem_limit -= AMDGPU_RESERVE_MEM_LIMIT;
 
 	kfd_mem_limit.max_ttm_mem_limit = ttm_tt_pages_limit() << PAGE_SHIFT;
+	kfd_mem_limit.alow_oversubscribe = !!(adev->flags & AMD_IS_APU);
 	pr_debug("Kernel memory limit %lluM, TTM limit %lluM\n",
 		(kfd_mem_limit.max_system_mem_limit >> 20),
 		(kfd_mem_limit.max_ttm_mem_limit >> 20));
@@ -221,8 +223,12 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 	     kfd_mem_limit.max_ttm_mem_limit) ||
 	    (adev && xcp_id >= 0 && adev->kfd.vram_used[xcp_id] + vram_needed >
 	     vram_size - reserved_for_pt - atomic64_read(&adev->vram_pin_size))) {
-		ret = -ENOMEM;
-		goto release;
+		if (kfd_mem_limit.alow_oversubscribe) {
+			pr_warn_ratelimited("Memory is getting oversubscried.\n");
+		} else {
+			ret = -ENOMEM;
+			goto release;
+		}
 	}
 
 	/* Update memory accounting by decreasing available system
-- 
2.25.1

