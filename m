Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD837C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jul 2022 09:14:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C88F8ED1F;
	Wed, 13 Jul 2022 09:14:57 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2BF88EC1D
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 09:14:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kiToWNrPPtAieAVg2e6uXNEc67vJtyNl+v3PrGRjGpJM0g5zqGBcMtmF3HUkqgaXbrzyydAk1EF8tnsSX+8Zk3Gj83yJiRPGlLGNHZxhdfJP/tNUy0MY6SV65Ri7NlFAK1vN2S6o+lMEFzBGqTxWG/rHHlFUh3trw1R82YOz9+e7onaOsCLDV+tjbkAB34kj79nNhvVzRlRTW8myWnDAl6dGhzJuUZQ8Jo/2ePqACeuF9qPsJV4/28dAwIs4PJKe1ZSdZvYUQFRWPY/qqMgBinUN1hQmvJgt1ZzEdMiQB5HEFmh+GhS9gnYOSeIenxtWUYYDMIvU+fMgScK2/lbdfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNo000COZekloN7e5zw4Ck3xun+cPISze5/goEj01WA=;
 b=djczbmuyklN/qn7+Uc6WN1gMmT3sV+14vS5fC+4Uqinym/SRlpiZ1mgK/2dGNLOP/W+4+5unFPAr5405he81yOfbavLVB0xUiMfTTWXIAqV5IDxLsRfDhzTokVvgPIlACkywhhh0bzL6vjQKIbm+ACNLioAWrz3gfAea/xHAX0S+m9twbnAmVs6DG3u3kJMF6L5lLbb6C9qe+zycD2vLAVplccUVI0t0jNzwbZxoigh7BWtY1BYheN3+jsxNSTAlJGD8NkuTquKd0p7fAugnJOckrPM2hI3bsNy0uJhqaXNcIcy9n70hh3sws+7k/sZMImitlBQ1TaDUJ8rufCzXNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNo000COZekloN7e5zw4Ck3xun+cPISze5/goEj01WA=;
 b=hZ0jIweMhGd58RBOESYqwdGiQhpJM4IsNlU2ehxeXIUY+82a1yUmJ0z3hMj27CrMz7xGYUeMlGvAq+NN1gUQRt1insbynCahg4f8Zvaz+uwlvIm/gHiUn/f7+22z1uclcCWuobB8VuahUoyMqKZTL3Oiyno5vJYznQ10nmCudQg=
Received: from MW4PR04CA0285.namprd04.prod.outlook.com (2603:10b6:303:89::20)
 by CH0PR12MB5187.namprd12.prod.outlook.com (2603:10b6:610:ba::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Wed, 13 Jul
 2022 09:14:53 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::a6) by MW4PR04CA0285.outlook.office365.com
 (2603:10b6:303:89::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16 via Frontend
 Transport; Wed, 13 Jul 2022 09:14:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Wed, 13 Jul 2022 09:14:53 +0000
Received: from master-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 13 Jul
 2022 04:14:50 -0500
From: shikai guo <shikai.guo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Remove Align VRAM allocations to 1MB on APU ASIC
Date: Wed, 13 Jul 2022 17:14:26 +0800
Message-ID: <20220713091426.938701-1-shikai.guo@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14f03f90-a40a-4d75-d5e0-08da64b0258b
X-MS-TrafficTypeDiagnostic: CH0PR12MB5187:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nlfPo+uCUdJudn3U7p4jh25XGCOZbGvZqPSrtKIZV/JYaNbI8Pww/Bbdf6mzgbUif5EpSckdHk9qQXqF8tDMnxtQCbOzi55XQKRp3Pd9kVCIU7qYHc2OnwauFfb2MxEWFNmMnADptE+Eqxr+8F9jjI8Boe3NjkMUocwtg/bBveEbZ34nbZ27ZxTcvtqaZ0AIm/RVMy4qa1nI+ZPp3V8CwvgxMeJylOr+3MC0oxYE8Xoxfx4NKzKz/DhqbUhjOagbm0tERO4i2a2GLkG1NbshmEcsu0ok6WOJtIsbJ0SeSFkB6ZtigTDdjsGTWRMxiWIEU6I47/SqxsN/D8PLi0Zw2WjAwVO8xVf4/0vv5KDaDgIjf/ih119iW2hBQa1c6ZHXvcnKFzq8u4nlP4n73/MJ3JWWff6fyRwl94Mu4wNi1HieaQO0vGZUP0s/MD84FmDAridPcS2OjBlgR99xZu5k8QdglKKqvjnHWiJuHJGX8E0B8+Mcl9S3lkdkI/rYYUfR4Bg4Bfuvdn5fTb8PjDxEOpv+OOGmWN/WFCWPBYIxzgq7U8bL5bRd4y2T6VUTydGMB6TOVxYgpU//XScS7Se3HSI/fNxOAPKHBHukYfNbNKrrwVJSq9sjp1XV7W90LFuW5gJ8W3vyueRbLHomaSDx6QqqqP9Wvs+M6kCI8UyOFUidjdJ5EaN1lbauHi0NQ2TO8M+xNRuDUXvWbUGPjjoaa2Cyh0in5eBXFLBQI/DWXOoV4bSEjMm/n6uog7UDOIrJbz8MBgb5ksy6JaJ3TTUMXSZ1hXrlxjVAlJ8bx/JP/BpsehdZ/QIcnqdhsUYdC24YLnKHs6xrLdP7ZxFpZ6YXvEeS1IIp8DitJX3getTQno1NH/JCR1Ak5B3OSQepDR9a
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(136003)(346002)(396003)(46966006)(36840700001)(40470700004)(336012)(86362001)(70206006)(478600001)(47076005)(81166007)(54906003)(8676002)(426003)(6916009)(186003)(6666004)(356005)(316002)(41300700001)(1076003)(70586007)(16526019)(4326008)(2616005)(36756003)(40460700003)(40480700001)(26005)(7696005)(5660300002)(82310400005)(8936002)(83380400001)(82740400003)(36860700001)(2906002)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 09:14:53.1258 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f03f90-a40a-4d75-d5e0-08da64b0258b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5187
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
Cc: daniel.phillips@amd.com, ruili.ji@amd.com, felix.kuehling@amd.com,
 aaron.liu@amd.com, shikai guo <shikai.guo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Shikai Guo <Shikai.Guo@amd.com>

While executing KFDMemoryTest.MMBench, test case will allocate 4KB size memory 1000 times.
Every time, user space will get 2M memory.APU VRAM is 512M, there is not enough memory to be allocated.
So the 2M aligned feature is not suitable for APU.

guoshikai@guoshikai-MayanKD-RMB:~/linth/libhsakmt/tests/kfdtest/build$ ./kfdtest --gtest_filter=KFDMemoryTest.MMBench
[          ] Profile: Full Test
[          ] HW capabilities: 0x9
Note: Google Test filter = KFDMemoryTest.MMBench
[==========] Running 1 test from 1 test case.
[----------] Global test environment set-up.
[----------] 1 test from KFDMemoryTest
[ RUN      ] KFDMemoryTest.MMBench
[          ] Found VRAM of 512MB.
[          ] Available VRAM 328MB.
[          ] Test (avg. ns)         alloc   mapOne  umapOne   mapAll  umapAll     free
[          ] --------------------------------------------------------------------------
[          ]   4K-SysMem-noSDMA     26561    10350     5212     3787     3981    12372
[          ]  64K-SysMem-noSDMA     42864     6648     3973     5223     3843    15100
[          ]   2M-SysMem-noSDMA    312906    12614     4390     6254     4790    70260
[          ]  32M-SysMem-noSDMA   4417812   130437    21625    97687    18500   929562
[          ]   1G-SysMem-noSDMA 132161000  2738000   583000  2181000   499000 39091000
[          ] --------------------------------------------------------------------------
/home/guoshikai/linth/libhsakmt/tests/kfdtest/src/KFDMemoryTest.cpp:922: Failure
Value of: (hsaKmtAllocMemory(allocNode, bufSize, memFlags, &bufs[i]))
  Actual: 6
Expected: HSAKMT_STATUS_SUCCESS
Which is: 0
[  FAILED  ] KFDMemoryTest.MMBench (749 ms)

fix this issue by adding different treatments for apu and dgpu

Signed-off-by: ruili ji <ruili.ji@amd.com>
Signed-off-by: shikai guo <shikai.guo@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index d1657de5f875..2ad2cd5e3e8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -115,7 +115,9 @@ void amdgpu_amdkfd_reserve_system_mem(uint64_t size)
  * compromise that should work in most cases without reserving too
  * much memory for page tables unnecessarily (factor 16K, >> 14).
  */
-#define ESTIMATE_PT_SIZE(mem_size) max(((mem_size) >> 14), AMDGPU_VM_RESERVED_VRAM)
+
+#define ESTIMATE_PT_SIZE(adev, mem_size)   (adev->flags & AMD_IS_APU) ? \
+                (mem_size >> 14) : max(((mem_size) >> 14), AMDGPU_VM_RESERVED_VRAM)
 
 static size_t amdgpu_amdkfd_acc_size(uint64_t size)
 {
@@ -142,7 +144,7 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 		uint64_t size, u32 alloc_flag)
 {
 	uint64_t reserved_for_pt =
-		ESTIMATE_PT_SIZE(amdgpu_amdkfd_total_mem_size);
+		ESTIMATE_PT_SIZE(adev, amdgpu_amdkfd_total_mem_size);
 	size_t acc_size, system_mem_needed, ttm_mem_needed, vram_needed;
 	int ret = 0;
 
@@ -156,12 +158,15 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 		system_mem_needed = acc_size;
 		ttm_mem_needed = acc_size;
 
+		if (adev->flags & AMD_IS_APU)
+			vram_needed = size;
+		else
 		/*
 		 * Conservatively round up the allocation requirement to 2 MB
 		 * to avoid fragmentation caused by 4K allocations in the tail
 		 * 2M BO chunk.
 		 */
-		vram_needed = ALIGN(size, VRAM_ALLOCATION_ALIGN);
+			vram_needed = ALIGN(size, VRAM_ALLOCATION_ALIGN);
 	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
 		system_mem_needed = acc_size + size;
 		ttm_mem_needed = acc_size;
@@ -220,7 +225,10 @@ static void unreserve_mem_limit(struct amdgpu_device *adev,
 	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
 		kfd_mem_limit.system_mem_used -= acc_size;
 		kfd_mem_limit.ttm_mem_used -= acc_size;
-		adev->kfd.vram_used -= ALIGN(size, VRAM_ALLOCATION_ALIGN);
+		if (adev->flags & AMD_IS_APU)
+			adev->kfd.vram_used -= size;
+		else
+			adev->kfd.vram_used -= ALIGN(size, VRAM_ALLOCATION_ALIGN);
 	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
 		kfd_mem_limit.system_mem_used -= (acc_size + size);
 		kfd_mem_limit.ttm_mem_used -= acc_size;
@@ -1666,7 +1674,7 @@ int amdgpu_amdkfd_criu_resume(void *p)
 size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev)
 {
 	uint64_t reserved_for_pt =
-		ESTIMATE_PT_SIZE(amdgpu_amdkfd_total_mem_size);
+		ESTIMATE_PT_SIZE(adev, amdgpu_amdkfd_total_mem_size);
 	size_t available;
 
 	spin_lock(&kfd_mem_limit.mem_limit_lock);
-- 
2.25.1

