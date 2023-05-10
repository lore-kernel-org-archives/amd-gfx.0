Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA86C7EE24
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 17:56:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E451110E4EA;
	Wed, 10 May 2023 17:56:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B26F310E4DC
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 17:56:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOrMKLjRWoQYSWTtcPf99NEe4UW5OGRHdb92w99O4Vr30hrOlFVH7b/xAixvaqMP4RxtDWHIJpYvj1UWBT2Ya2pgKrTxBqnd/js3m9Qkh7V7wPsw07Qro0rHzC6lFar3RU665//CBmfOdnuYeXT7Yx9NH9R0l6mvVHZ50wKZn/zbFwnCWV+HEnWMhnfaAFXkd3mq4tDqbuOll8zTArbs6sFA4nC7HQYcM4D/judzAv9E/Gf09+qksy+gKJ3pUJkNlORPqD5l+zssSkcam7edtSCc/PMLrb7EeQesGoWoQMm2jitj7ovBuLMJNTNJhpBQ15htErh6ELnAdaYFZFuxag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NwyaKRgkVJGgkMjZ/RRuu5wpZvX/M11CTR37X1AX3OA=;
 b=NDalMRUCxx1tdJOeIeM5vcYkCr4AII0TiPqpFecgQzlYpw4JDrPJvIifDmrL9h1fBd+Lx1KaoYMnrdeZ3m0MLiRWnkRYA9hQqzdv0QT6r966TVrz9DZQYo1n6Bn3GS2V88BLE8KnRDRdNbmVYMoiapluiWqaJXO+heGr1dGn611yU0ghCszf8yXKLvKR5StboHDhvM+db817C+Osmuc7B+EwsHtC3W5Ev5lmDZb54iRgshcq+6czuRZcP7CVXqJl1fgRlbWqbA1NOrvx5HImrRoIMjHN6TOGZS49E54DlmgUYEj1O43nKlJEmTi7tOcDOn3GzAMtL0nHRZNc4Mez+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwyaKRgkVJGgkMjZ/RRuu5wpZvX/M11CTR37X1AX3OA=;
 b=jYqOdZ5NJZj/dYr+g6a5KJtRMk1/7vfQtZ1JCTzHsaB2egdDlrVL6AWwptSZKBigTn+sNTFxK86mY2+56m1ynKVt2N9cckLwUOKo/Oqv/HZwoRf6JCrTE+uJjm7Lb2eOXK6NsbgBOgGAjqqy4NNiVyXKWyxP7eRFW3OL5rstvz0=
Received: from BN9PR03CA0935.namprd03.prod.outlook.com (2603:10b6:408:108::10)
 by SJ2PR12MB7821.namprd12.prod.outlook.com (2603:10b6:a03:4d2::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Wed, 10 May
 2023 17:56:46 +0000
Received: from BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::82) by BN9PR03CA0935.outlook.office365.com
 (2603:10b6:408:108::10) with Microsoft SMTP Server (version=TLS1_2,
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
 15.20.6387.21 via Frontend Transport; Wed, 10 May 2023 17:56:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 12:56:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/6] drm/amdgpu/bu: Add use_mtype_cc_wa module param
Date: Wed, 10 May 2023 13:56:26 -0400
Message-ID: <20230510175630.938276-2-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT086:EE_|SJ2PR12MB7821:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bcd5a98-3295-417a-b1d1-08db517fead1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZkBAg9efsTYrcWLyTsi3JXZR/1gmZ3rSIclpZ3tMvFXg99Rjs59Jyq0vn1xEQ9AmdhT/OpV7+8+Np4eRrN4Rb9KTcPNRzMKA1WP8UL4biDFd3Cuz+U/QTebkT9CM2GlWKZxcDHLiMNO8XyolPlxl33kgotwTPDQY/5Exqa+3ST1RkatHxbYdrghNUpgQJiDTlgJMJwJTo8SVjHTye6087FwuYxqJjq3lObFcGW11N04h/ewnjnFv0DA/hTt5oRCZcxUpWh4W4T0PnDT/XvJKsZMs7PL1ke90omJ+sz5fWTNEToPFNFQ+eHdyykJtqDRqSZEDi/XTJ+vaRmTzfkY180bRaIwc+L+Tuy8bo+uWAh6TZxC5yaNMSayFNB4dGbYv4TNLB1yUWYSlib5e9xVklTBACRm264szIwb4kF9m4U7HOhAkimztjFnodA5lkfVvFnd/nuOF7Vu9MF2OoaX0tnC/JuNB+3HXv+v9ExEfAWLMAzgQw4XoUcA1m71g9MFffm6xY3XTcZENjmyWt2t71zuO6+JZkKDYylftnIt/LX26zQHWFNJEFIayBD9VEDMcBQF77yvuW1AOBavWbggu+BSeLmdhSEhdrzGTJAmfM26zwBEtyXxV+rgmZYQAs1GO+EQS3U0Qz/sZt7VgZz+M+XFfSGwiXYYvAYfetUEKFgsmZM/3Cm14Z1U+V42H7wyR1rob86Qd8BBp2PtEcU2K314ruqrKTnatbXGtsxtG0Mk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199021)(40470700004)(46966006)(36840700001)(36860700001)(47076005)(83380400001)(426003)(336012)(86362001)(40460700003)(81166007)(54906003)(6916009)(2906002)(70586007)(40480700001)(70206006)(186003)(16526019)(316002)(4326008)(478600001)(82740400003)(82310400005)(8676002)(2616005)(26005)(8936002)(36756003)(7696005)(1076003)(6666004)(356005)(41300700001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 17:56:44.4895 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bcd5a98-3295-417a-b1d1-08db517fead1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7821
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
 Deucher <alexander.deucher@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>,
 Joseph Greathouse <Joseph.Greathouse@amd.com>,
 Graham Sider <Graham.Sider@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Graham Sider <Graham.Sider@amd.com>

By default, set use_mtype_cc_wa to 1 to set PTE coherence flag MTYPE_CC
instead of MTYPE_RW by default. This is required for the time being to
mitigate a bug causing XCCs to hit stale data due to TCC marking fully
dirty lines as exclusive.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
Reviewed-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  7 +++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 10 +++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c    |  7 +++++--
 4 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 9904ce78b8fc..a3a0dbeb251f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -213,6 +213,7 @@ extern int amdgpu_noretry;
 extern int amdgpu_force_asic_type;
 extern int amdgpu_smartshift_bias;
 extern int amdgpu_use_xgmi_p2p;
+extern bool amdgpu_use_mtype_cc_wa;
 #ifdef CONFIG_HSA_AMD
 extern int sched_policy;
 extern bool debug_evictions;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index e4d09bf0887d..2f38c49aa597 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -831,6 +831,13 @@ MODULE_PARM_DESC(no_queue_eviction_on_vm_fault, "No queue eviction on VM fault (
 module_param_named(no_queue_eviction_on_vm_fault, amdgpu_no_queue_eviction_on_vm_fault, int, 0444);
 #endif
 
+/**
+ * DOC: use_mtype_cc_wa (bool)
+ */
+bool amdgpu_use_mtype_cc_wa = true;
+MODULE_PARM_DESC(use_mtype_cc_wa, "Use MTYPE_CC workaround (0 = use MTYPE_RW where applicable, 1 = use MTYPE_CC where applicable (default))");
+module_param_named(use_mtype_cc_wa, amdgpu_use_mtype_cc_wa, bool, 0444);
+
 /**
  * DOC: pcie_p2p (bool)
  * Enable PCIe P2P (requires large-BAR). Default value: true (on)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index d28ffdb07ae6..59ce741dfa73 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1192,6 +1192,7 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
 	bool coherent = bo->flags & AMDGPU_GEM_CREATE_COHERENT;
 	bool uncached = bo->flags & AMDGPU_GEM_CREATE_UNCACHED;
 	unsigned int mtype;
+	unsigned int mtype_default;
 	bool snoop = false;
 
 	switch (adev->ip_versions[GC_HWIP][0]) {
@@ -1235,7 +1236,10 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
 		/* FIXME: Needs more work for handling multiple memory
 		 * partitions (> NPS1 mode) e.g. NPS4 for both APU and dGPU
 		 * modes.
+		 * FIXME: Temporarily using MTYPE_CC instead of MTYPE_RW where applicable.
+		 * To force use of MTYPE_RW, set use_mtype_cc_wa=0
 		 */
+		mtype_default = amdgpu_use_mtype_cc_wa ? MTYPE_CC : MTYPE_RW;
 		snoop = true;
 		if (uncached) {
 			mtype = MTYPE_UC;
@@ -1250,14 +1254,14 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
 			 * socket should be treated as remote access so MTYPE_RW
 			 * cannot be used always.
 			 */
-			mtype = MTYPE_RW;
+			mtype = mtype_default;
 		} else if (adev->flags & AMD_IS_APU) {
 			/* APU on carve out mode */
-			mtype = MTYPE_RW;
+			mtype = mtype_default;
 		} else {
 			/* dGPU */
 			if (is_vram && bo_adev == adev)
-				mtype = MTYPE_RW;
+				mtype = mtype_default;
 			else if (is_vram)
 				mtype = MTYPE_NC;
 			else
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 83f8e4e50315..c55b9754c506 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1197,9 +1197,12 @@ svm_range_get_pte_flags(struct kfd_node *node,
 		if (uncached) {
 			mapping_flags |= AMDGPU_VM_MTYPE_UC;
 		} else if (domain == SVM_RANGE_VRAM_DOMAIN) {
-			/* local HBM region close to partition */
+			/* local HBM region close to partition
+			 * FIXME: Temporarily using MTYPE_CC instead of MTYPE_RW where applicable.
+			 * To force use of MTYPE_RW, set use_mtype_cc_wa=0
+			 */
 			if (bo_node == node)
-				mapping_flags |= AMDGPU_VM_MTYPE_RW;
+				mapping_flags |= amdgpu_use_mtype_cc_wa ? AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW;
 			/* local HBM region far from partition or remote XGMI GPU */
 			else if (svm_nodes_in_same_hive(bo_node, node))
 				mapping_flags |= AMDGPU_VM_MTYPE_NC;
-- 
2.40.1

