Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9944DC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jun 2022 00:24:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B482F10E313;
	Tue, 28 Jun 2022 00:24:02 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFC0110E313
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jun 2022 00:24:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VyQ9zEj2mabyV8cPW0X1eg17xSFkF8zT70y1DoZcbSmhA9+WykLl8w6Wu4XoxV4eDhrZr7UsOWOtuZBWTzjqYjiJY1JW5gNAyJQfBI3kTnIffYWzGIXCPanfADivnGh3iTgHXh3ts4ybsqHDymSVy5jfqVSD/+o8LtOZh6/Z8FG8F/ErZlzc/aH734zFNQiYi/h/i8blLnc7EOnVejnlDxnaqD+iSfl8vNwCi6Pi+v1f0t51ob4VQv4J0pRPqSZjcE825Sq406LuvTv0Oukvstyx2fotkZNZTphmtJddf/88m61R1Gt06+9h7c+JsdBBUn7kgw1wHKa4MQ4Wibv6dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3P56k1C9NtkqMoial2gi2OvOO9Cy7B7D1akTkgUbCJE=;
 b=iRz3IyFkcEY19/j2QHNwtx2ubLGdAmQ7TqgXRMca9kh6E2DCFQKowmynptfyrT+nCTkJNmrHQMMK1WE0YDQtLh35UZeskjcsYSyYWCepdhXsMuzbJG8AOzeYxf+cWnuwDxVVP1c0uFfxAIqB+5CPyyr1F0D08itdD+A5QiuCn4WArRh1JAdSjOmV82OpiLvOyG5PFQOqwwp5kaimsiI7F7rbCm4UILQ7BzFk61HGO+eJICnNOSsffhiSef2LOlTKN99ykCEjb2UAfh9CSNVx/gln1v9cBNdCZfpaaUdRUKI9qdihnkxsgfuJsqMjzSYWElWbGMIuaT+d6FDom9R+fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3P56k1C9NtkqMoial2gi2OvOO9Cy7B7D1akTkgUbCJE=;
 b=wFfsH3PsZU/C2KZD/dnps91WwxCyzOnHoWitQtKkmB8KMbS2tQqm6VLBKSWHQSwe3Lep8bNQ7GNP7mvGy/BWAZj83M09RAfEOvMCCqBQTYU71TYF/gF5Jfoc0Jrt+y85ffAuWU6r9Z/ywjngY5Ruwk4iL4f5bRrkDe0yFpHxRMQ=
Received: from DS7PR03CA0005.namprd03.prod.outlook.com (2603:10b6:5:3b8::10)
 by CH0PR12MB5155.namprd12.prod.outlook.com (2603:10b6:610:ba::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Tue, 28 Jun
 2022 00:24:00 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::85) by DS7PR03CA0005.outlook.office365.com
 (2603:10b6:5:3b8::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15 via Frontend
 Transport; Tue, 28 Jun 2022 00:23:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Tue, 28 Jun 2022 00:23:59 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 27 Jun
 2022 19:23:58 -0500
From: Alex Sierra <alex.sierra@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: remove acc_size from reserve/unreserve mem
Date: Mon, 27 Jun 2022 19:23:45 -0500
Message-ID: <20220628002347.3982-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66aebf77-ada0-4cdf-85fa-08da589c7f28
X-MS-TrafficTypeDiagnostic: CH0PR12MB5155:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zGxRXRuk71mnlz+ipRELWw4Z5b5ktjry4K+XXzBEBWHDbjtBb6ZqRkZEMWa3VbTaek+c/6IO8wocanIIrx1g2uTAqBErk2xD/dboQpqYIWn4ZeLzTZJWfrDTcCzhsYvQUt3CbguZ4suUVb6zBm0pgIDVLJQs6VH/8ZmPl37Wes0tlp6jXSO0Lr5iL94AXmmkwSWajRuTOKYKMY5Uq5l5hVqkcIYG91MYKZRhRPumvDjNbFfZxQu1pJa/l441KarRjbvjkMBDDp5bIMVxbtniV+5mX1EFfUn4jm3ATpovyeOTcaMQYRkrmp2E0f0BY8qhzo6GcX3UgnA0YyAz0NgyuwsNRmGvRZV6XSbkvZSMpPLa5/G/SkmRD6TI76Ot/wFK+EcghnCYQC1TmSXeYJK2gbbuUfhE1vhHIY86h5LQPiilhaJwanMxbMunE7Sih+8e9dDxJa2zwE0rwC2l1b75pogdaheJCPdK9E1Vu4B7W0iZuKqOkpa4qS1qJpYOyAqCaNLfaT7bRUPKyqk0jCS/0iazlV/gFrN2b/8OZv6nd2L2UiWuFgEje9/oNW1cIuIK4l1e3Pvv/s4mjEAbDwOffItn8ipQKutkgz+0bFKJy+pNWN9LtHS7MI7xuxPfVaJSZwatlG5vZvbQ4KFZjZbeb/WC0n5R6a1r+zxd3ZZU9iZKM/SAdMJm9CZfSofkgfeqCq5j7ZUngj+hdfTJKSIb5CF6L+t9qJJ8anm7S9cH2vCjhj16MwTVrZfS0MElXAXH6ft/aTvupTJJrZpPGF4blNUl/UNQGFS3AX/qjOhXXlo7Vl3aybIwiMEnHLs/HbXcEqSPUeAGm3MC+ry7Smozbg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(39860400002)(396003)(376002)(40470700004)(46966006)(36840700001)(336012)(478600001)(7696005)(86362001)(1076003)(2616005)(356005)(47076005)(70586007)(426003)(5660300002)(44832011)(8936002)(41300700001)(2906002)(82310400005)(16526019)(186003)(6666004)(81166007)(36756003)(26005)(4326008)(54906003)(70206006)(82740400003)(6916009)(8676002)(40480700001)(40460700003)(36860700001)(83380400001)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 00:23:59.6913 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66aebf77-ada0-4cdf-85fa-08da589c7f28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5155
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
Cc: Alex Sierra <alex.sierra@amd.com>, Philip Yang <philip.yang@amd.com>,
 Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

TTM used to track the "acc_size" of all BOs internally. We needed to
keep track of it in our memory reservation to avoid TTM running out
of memory in its own accounting. However, that "acc_size" accounting
has since been removed from TTM. Therefore we don't really need to
track it any more.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Reviewed-by: Philip Yang <philip.yang@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 60 ++++++-------------
 1 file changed, 17 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 5ba9070d8722..9142f6cc3f4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -114,21 +114,12 @@ void amdgpu_amdkfd_reserve_system_mem(uint64_t size)
  * compromise that should work in most cases without reserving too
  * much memory for page tables unnecessarily (factor 16K, >> 14).
  */
-#define ESTIMATE_PT_SIZE(mem_size) max(((mem_size) >> 14), AMDGPU_VM_RESERVED_VRAM)
-
-static size_t amdgpu_amdkfd_acc_size(uint64_t size)
-{
-	size >>= PAGE_SHIFT;
-	size *= sizeof(dma_addr_t) + sizeof(void *);
 
-	return __roundup_pow_of_two(sizeof(struct amdgpu_bo)) +
-		__roundup_pow_of_two(sizeof(struct ttm_tt)) +
-		PAGE_ALIGN(size);
-}
+#define ESTIMATE_PT_SIZE(mem_size) max(((mem_size) >> 14), AMDGPU_VM_RESERVED_VRAM)
 
 /**
  * amdgpu_amdkfd_reserve_mem_limit() - Decrease available memory by size
- * of buffer including any reserved for control structures
+ * of buffer.
  *
  * @adev: Device to which allocated BO belongs to
  * @size: Size of buffer, in bytes, encapsulated by B0. This should be
@@ -142,19 +133,16 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 {
 	uint64_t reserved_for_pt =
 		ESTIMATE_PT_SIZE(amdgpu_amdkfd_total_mem_size);
-	size_t acc_size, system_mem_needed, ttm_mem_needed, vram_needed;
+	size_t system_mem_needed, ttm_mem_needed, vram_needed;
 	int ret = 0;
 
-	acc_size = amdgpu_amdkfd_acc_size(size);
-
+	system_mem_needed = 0;
+	ttm_mem_needed = 0;
 	vram_needed = 0;
 	if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_GTT) {
-		system_mem_needed = acc_size + size;
-		ttm_mem_needed = acc_size + size;
+		system_mem_needed = size;
+		ttm_mem_needed = size;
 	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
-		system_mem_needed = acc_size;
-		ttm_mem_needed = acc_size;
-
 		/*
 		 * Conservatively round up the allocation requirement to 2 MB
 		 * to avoid fragmentation caused by 4K allocations in the tail
@@ -162,14 +150,10 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 		 */
 		vram_needed = ALIGN(size, VRAM_ALLOCATION_ALIGN);
 	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
-		system_mem_needed = acc_size + size;
-		ttm_mem_needed = acc_size;
-	} else if (alloc_flag &
-		   (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
-		    KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
-		system_mem_needed = acc_size;
-		ttm_mem_needed = acc_size;
-	} else {
+		system_mem_needed = size;
+	} else if (!(alloc_flag &
+				(KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
+				 KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))) {
 		pr_err("%s: Invalid BO type %#x\n", __func__, alloc_flag);
 		return -ENOMEM;
 	}
@@ -207,28 +191,18 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 static void unreserve_mem_limit(struct amdgpu_device *adev,
 		uint64_t size, u32 alloc_flag)
 {
-	size_t acc_size;
-
-	acc_size = amdgpu_amdkfd_acc_size(size);
-
 	spin_lock(&kfd_mem_limit.mem_limit_lock);
 
 	if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_GTT) {
-		kfd_mem_limit.system_mem_used -= (acc_size + size);
-		kfd_mem_limit.ttm_mem_used -= (acc_size + size);
+		kfd_mem_limit.system_mem_used -= size;
+		kfd_mem_limit.ttm_mem_used -= size;
 	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
-		kfd_mem_limit.system_mem_used -= acc_size;
-		kfd_mem_limit.ttm_mem_used -= acc_size;
 		adev->kfd.vram_used -= ALIGN(size, VRAM_ALLOCATION_ALIGN);
 	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
-		kfd_mem_limit.system_mem_used -= (acc_size + size);
-		kfd_mem_limit.ttm_mem_used -= acc_size;
-	} else if (alloc_flag &
-		   (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
-		    KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
-		kfd_mem_limit.system_mem_used -= acc_size;
-		kfd_mem_limit.ttm_mem_used -= acc_size;
-	} else {
+		kfd_mem_limit.system_mem_used -= size;
+	} else if (!(alloc_flag &
+				(KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
+				 KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))) {
 		pr_err("%s: Invalid BO type %#x\n", __func__, alloc_flag);
 		goto release;
 	}
-- 
2.32.0

