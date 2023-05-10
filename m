Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B38C7EE24
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 17:56:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7B4D10E4EC;
	Wed, 10 May 2023 17:56:56 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2073.outbound.protection.outlook.com [40.107.212.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61CF410E4EC
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 17:56:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYkN/OeY/gbRoupo3u0gyYyyjCRBt1IckSRet5ImRVNBOXBahkBfO8dSC5MMjZiCegMjSyw8AdUN4cLyPQHs3FAVhjt/ZmzBqPrhO59PbIBQSv73zkOjENb6RwX/mJ0MahXsjBL+WLo0TUFgtUmXZ052fItVGqavT+3stTf+d1MWiARcoKS4/0G6zj1G8WgneWi+XvHoC/BYHvHzZC6mz2E1KLHX/e4/tH7K1G5A7GRg+s00zIwCPPB785QTtddjZMykbx31WmRzwY1uKNyg9gzbQhwfT19Qf5NLexAFTM3X1samAvbxP3fiK9YlwRZPvYgXNcdx2Cno24Xx4NQpQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YpTDJliznQj6ZjM7+lB7SNLQhmK3uK3KKZGbchSe7VE=;
 b=fYRBhVnWq8kdRqpM+Avbl31DzUGt+LGNvAFR52WCgMlKZCQ1ZGQ0StIJzYmrar3jofApaKRCaLsNNotUsB1ptb4zZnpCHr6xHKX8u7HcQvqA+2FCkXhNEIM+b90ubU/0r35YI3UQUzNI/PyS72wPwd1Y/aLGd9pmdoufxwQviJSDfWUy8uiGV/tV4f3dsautvyz0Oo70ZhlWJ/9AQggha/tSh6ZqbMrHoyXdu4eUjVUHc/Z4TtUBt0XCdJm9rFUC0o0lrbm3HuZNrjIt+ktphxmRoGudaBS3KrLKlTU/nX75eqP5hR7irRZh+K31COomA7jZJHwAc60paKMbUFwIZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpTDJliznQj6ZjM7+lB7SNLQhmK3uK3KKZGbchSe7VE=;
 b=AzUnm6dQ1P/2LEfTr7Fy/BqK/8spXVh6sVJu7aCC++WHhMCg7jgU4wd5pH5pfYUQZ7hFkXe5C9wmhx5UfGCyjebFaNwPO0osV6Tw1K8EpPfixlwybmkx0curRhZIHVIMheyNRTfpvDJTzTpu8E6uxTzH95pRHQaA5hdmlFyynAc=
Received: from BN9PR03CA0946.namprd03.prod.outlook.com (2603:10b6:408:108::21)
 by DM4PR12MB5232.namprd12.prod.outlook.com (2603:10b6:5:39c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Wed, 10 May
 2023 17:56:46 +0000
Received: from BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::12) by BN9PR03CA0946.outlook.office365.com
 (2603:10b6:408:108::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Wed, 10 May 2023 17:56:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT086.mail.protection.outlook.com (10.13.176.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.21 via Frontend Transport; Wed, 10 May 2023 17:56:46 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 12:56:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/6] drm/amdgpu: Fix per-BO MTYPE selection for GFXv9.4.3
Date: Wed, 10 May 2023 13:56:27 -0400
Message-ID: <20230510175630.938276-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230510175630.938276-1-alexander.deucher@amd.com>
References: <20230510175630.938276-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT086:EE_|DM4PR12MB5232:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e3e5bf3-8237-44ee-ea45-08db517fec15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vrgDvqEY1llT6Yiyv65bns6PE4QAlV2rxaFXpiiCTlgqTDh7FECJyeMZXHelN3T1/q+F0Jf5EyHEsDON8ZPXjGeyj5uYjqcDmRoM8CUdLvNG3fUAM3oXh2/0CleyFPBYFSA8dTQd0vfTmvfmZJ8ubcdL40U6dcdoEPt5S4hbgsVL8qEsYLzHWzNYkLlgqfS5tCEe6T41blPmz3w5Qw9/2UVelqIzVTfRQwiT9MJs2Y3aP6qfqFB15cpsXw/328JpYwui5En5TMCn0cCA/KKMSW0lPNui6zap0v5KezmAEO0p58bPbseKt2z1ZLsY/kUsOYQL65FX3HWsDotamXeO8lv3m8zpq22cc+rbxHFpITmqVbBPLc4pAW2STDvh3sbNSZT4c21p3PaPr+H3xP3xs2BjtD/n4Lp87jv2U3tMUtLPJhI4q3aM6eRJsdTWKka2M0qUJb7/if3SYqJqWCG/n+o93jx3v0ubUe1SpEeLxp9n7swK3kjsGbNy3RtpZhb/Id/QzrnDviCjdlXuwMadi1ACIEGSk+EkBq7/uQ0WEZZXLIRW9CIcZRpBX93aqnx7ZMFiJpCbwI8brxoYrY3/KBd2Sk9cjo1Qfc2gLZT+wPOQtpivdSijhUTbljkVG9N73vViO/3nufHKhAgvghWzKbqI8xhThtdVXu+Tel3zWqy+eViV+a9dGOVAUS+RgCfZw4Nhry0VeW6IHlRTr3upKrxo8fP2ONCtidAdVpzEXBumzKV5ZqAG4nkHTeUgB2elOtba06+aXvfgimcbF7p6oQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(82740400003)(26005)(186003)(1076003)(6666004)(7696005)(356005)(81166007)(86362001)(83380400001)(36860700001)(47076005)(40480700001)(336012)(426003)(2616005)(316002)(4326008)(2906002)(8676002)(36756003)(8936002)(41300700001)(5660300002)(16526019)(54906003)(6916009)(70586007)(70206006)(82310400005)(40460700003)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 17:56:46.6144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e3e5bf3-8237-44ee-ea45-08db517fec15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5232
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
Cc: Alex
 Deucher <alexander.deucher@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Felix Kuehling <Felix.Kuehling@amd.com>

Treat system memory on NUMA systems as remote by default. Overriding with
a more efficient MTYPE per page will be implemented in the next patch.

No need for a special case for APP APUs. System memory is handled the same
for carve-out and native mode. And VRAM doesn't exist in native mode.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-and-tested-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 40 +++++++++++----------------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c  | 24 +++++++++-------
 2 files changed, 30 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 59ce741dfa73..52f5bab5fcb7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1191,9 +1191,10 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
 	bool is_vram = bo->tbo.resource->mem_type == TTM_PL_VRAM;
 	bool coherent = bo->flags & AMDGPU_GEM_CREATE_COHERENT;
 	bool uncached = bo->flags & AMDGPU_GEM_CREATE_UNCACHED;
-	unsigned int mtype;
-	unsigned int mtype_default;
+	/* TODO: memory partitions struct amdgpu_vm *vm = mapping->bo_va->base.vm;*/
+	unsigned int mtype_local, mtype;
 	bool snoop = false;
+	bool is_local;
 
 	switch (adev->ip_versions[GC_HWIP][0]) {
 	case IP_VERSION(9, 4, 1):
@@ -1233,35 +1234,26 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
 		}
 		break;
 	case IP_VERSION(9, 4, 3):
-		/* FIXME: Needs more work for handling multiple memory
-		 * partitions (> NPS1 mode) e.g. NPS4 for both APU and dGPU
-		 * modes.
-		 * FIXME: Temporarily using MTYPE_CC instead of MTYPE_RW where applicable.
-		 * To force use of MTYPE_RW, set use_mtype_cc_wa=0
+		/* Only local VRAM BOs or system memory on non-NUMA APUs
+		 * can be assumed to be local in their entirety. Choose
+		 * MTYPE_NC as safe fallback for all system memory BOs on
+		 * NUMA systems. Their MTYPE can be overridden per-page in
+		 * gmc_v9_0_override_vm_pte_flags.
 		 */
-		mtype_default = amdgpu_use_mtype_cc_wa ? MTYPE_CC : MTYPE_RW;
+		mtype_local = amdgpu_use_mtype_cc_wa ? MTYPE_CC : MTYPE_RW;
+		is_local = (!is_vram && (adev->flags & AMD_IS_APU) &&
+			    num_possible_nodes() <= 1) ||
+			   (is_vram && adev == bo_adev /* TODO: memory partitions &&
+			    bo->mem_id == vm->mem_id*/);
 		snoop = true;
 		if (uncached) {
 			mtype = MTYPE_UC;
-		} else if (adev->gmc.is_app_apu) {
-			/* FIXME: APU in native mode, NPS1 single socket only
-			 *
-			 * For suporting NUMA partitioned APU e.g. in NPS4 mode,
-			 * this need to look at the NUMA node on which the
-			 * system memory allocation was done.
-			 *
-			 * Memory access by a different partition within same
-			 * socket should be treated as remote access so MTYPE_RW
-			 * cannot be used always.
-			 */
-			mtype = mtype_default;
 		} else if (adev->flags & AMD_IS_APU) {
-			/* APU on carve out mode */
-			mtype = mtype_default;
+			mtype = is_local ? mtype_local : MTYPE_NC;
 		} else {
 			/* dGPU */
-			if (is_vram && bo_adev == adev)
-				mtype = mtype_default;
+			if (is_local)
+				mtype = mtype_local;
 			else if (is_vram)
 				mtype = MTYPE_NC;
 			else
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index c55b9754c506..ab1acf97d049 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1150,6 +1150,7 @@ svm_range_get_pte_flags(struct kfd_node *node,
 	bool snoop = (domain != SVM_RANGE_VRAM_DOMAIN);
 	bool coherent = flags & KFD_IOCTL_SVM_FLAG_COHERENT;
 	bool uncached = flags & KFD_IOCTL_SVM_FLAG_UNCACHED;
+	unsigned int mtype_local;
 
 	if (domain == SVM_RANGE_VRAM_DOMAIN)
 		bo_node = prange->svm_bo->node;
@@ -1190,19 +1191,16 @@ svm_range_get_pte_flags(struct kfd_node *node,
 		}
 		break;
 	case IP_VERSION(9, 4, 3):
-		//TODO: Need more work for handling multiple memory partitions
-		//e.g. NPS4. Current approch is only applicable without memory
-		//partitions.
+		mtype_local = amdgpu_use_mtype_cc_wa ? AMDGPU_VM_MTYPE_CC :
+						       AMDGPU_VM_MTYPE_RW;
 		snoop = true;
 		if (uncached) {
 			mapping_flags |= AMDGPU_VM_MTYPE_UC;
 		} else if (domain == SVM_RANGE_VRAM_DOMAIN) {
-			/* local HBM region close to partition
-			 * FIXME: Temporarily using MTYPE_CC instead of MTYPE_RW where applicable.
-			 * To force use of MTYPE_RW, set use_mtype_cc_wa=0
-			 */
-			if (bo_node == node)
-				mapping_flags |= amdgpu_use_mtype_cc_wa ? AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW;
+			/* local HBM region close to partition */
+			if (bo_node->adev == node->adev /* TODO: memory partitions &&
+			    bo_node->mem_id == node->mem_id*/)
+				mapping_flags |= mtype_local;
 			/* local HBM region far from partition or remote XGMI GPU */
 			else if (svm_nodes_in_same_hive(bo_node, node))
 				mapping_flags |= AMDGPU_VM_MTYPE_NC;
@@ -1211,7 +1209,13 @@ svm_range_get_pte_flags(struct kfd_node *node,
 				mapping_flags |= AMDGPU_VM_MTYPE_UC;
 		/* system memory accessed by the APU */
 		} else if (node->adev->flags & AMD_IS_APU) {
-			mapping_flags |= AMDGPU_VM_MTYPE_NC;
+			/* On NUMA systems, locality is determined per-page
+			 * in amdgpu_gmc_override_vm_pte_flags
+			 */
+			if (num_possible_nodes() <= 1)
+				mapping_flags |= mtype_local;
+			else
+				mapping_flags |= AMDGPU_VM_MTYPE_NC;
 		/* system memory accessed by the dGPU */
 		} else {
 			mapping_flags |= AMDGPU_VM_MTYPE_UC;
-- 
2.40.1

