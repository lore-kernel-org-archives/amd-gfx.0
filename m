Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93064C77B7D
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 17:56:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2A5F10E4ED;
	Wed, 10 May 2023 17:56:56 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2077.outbound.protection.outlook.com [40.107.95.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E80D210E4EC
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 17:56:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D9c6ecDtdBRldXgsPrjE7QQ/xEcbqoLnVDwCLwnsyNL60X3hWAPcf9bpn8vocHyvcrQXVPNtBn71USWK5w9R/pxHoW4urPlA/7axapZObuHZzXLFhyxW+HayBX8iPCOS43AdoOuEMlevdne6G42Iu6pX+G2En67i/y4hqWGi7kvrltFwpkD6Lm1lJ/ynEpyB6Z2QWKaAoj7AttFnujdVmwl38yKOkEnj5bYDBx9l9qLHwb7Tlu3YfOIiYDHde6HfTU0qr5vJoDwq0S/DQXLQOZSSGkpioCmkUhk2N2ESWvEIuG45nFY3q1/xK7c2U6SaiBMhSSq6E2T2KS3zykC+qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ik4rvUKxKhqo8F3B+ymPXfldVCtAZnUCIefair7BK+c=;
 b=EvdRQhxFBLmIHMjdeKrVILdZBhwfkCj0asaTxjk0aUmEEx4f0RrSTEgXp4pgQTJhaTgjsaMZrySFDAz2YzKfXD4DBlxw4MNjNRQkxfpCvj0SYc3pPemBAngmLoVxruAxsjGmY+ndHJq3X6GS8UVoc8osu1A/fktnumzc4d2uj+CANPSsYCJUv+6pKuqg/UrVo4wZVijAxZkR2QY1FW2w7Kipr9FkhIcAvUnVHXOMoK7pzdD2444cEMmldK2z8fSFsesSIF3Zgr25dkG4VBxURYtXnzFpWgQis4hdz7JUmZhcwzCdjUmlo9IxQe84OsN+92VBsngEhdssLOIk8agELA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ik4rvUKxKhqo8F3B+ymPXfldVCtAZnUCIefair7BK+c=;
 b=MX+7LftkA0v8YYMNidZf3iFt0YlVZWgTDeJeQV+F4tiETj5KbT6NKCxqMNzweFtwwwJCSsq1NHkY6/lht26GpoaL2rI1C/CPBST9F09uM4iQtcSpHzYiNwaRSXO53F9uIv5q0dgXl7RFWT3Fp90mUMJhGBFmjnlDJEIfm3UA/1c=
Received: from BN9PR03CA0947.namprd03.prod.outlook.com (2603:10b6:408:108::22)
 by DS0PR12MB8480.namprd12.prod.outlook.com (2603:10b6:8:159::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Wed, 10 May
 2023 17:56:53 +0000
Received: from BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::2d) by BN9PR03CA0947.outlook.office365.com
 (2603:10b6:408:108::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Wed, 10 May 2023 17:56:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT086.mail.protection.outlook.com (10.13.176.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.21 via Frontend Transport; Wed, 10 May 2023 17:56:52 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 12:56:46 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/6] drm/amdgpu/bu: update mtype_local parameter settings
Date: Wed, 10 May 2023 13:56:30 -0400
Message-ID: <20230510175630.938276-6-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT086:EE_|DS0PR12MB8480:EE_
X-MS-Office365-Filtering-Correlation-Id: 75c9a3a4-e3a8-4aae-6ce0-08db517fefdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xNDAHZnxJPqwWavE5cmru91JoKst9y/anejjp52DKbBQ7PUtEZFdwX8BrmRm1sH16Q7Fihme767DRyYuQLEBrJukAphAu/NBxxfhwPRqiL30IdhYh+gkqlbl2z3rYeLaI9ofm55uv+VCyap+B7YqcaZbUfopMCyakv0bgp+l1oBJjFVHio12VqkThz6h8UYBhE5mlsDFS9hIr7/D183voXjd3QDpZ560cLhPAwAj266Gi/CbVa5DsSjXMkZxeTItTPbQf3iZhuz37oa1gRVDah/97fhbxV86o4Dudozy+vul+E+IvcNY/yyLyXjWjbmuQc3CwZSLJe39g+X+3+d7BIYnzKXihAoy93Eerxz0FZ82Ua3Ji2oLIRYkguasXRmInfwNATyoe+TaxZJCdH3xqaMj2lywO/rzpj1RCGFmuo51J/Rxs4AiAivbzvclfe+O1eOvjP8hlzORCTTWXaGLhK+1fk0HIog6RfvD6W0RNYPpnvnO7SB6Fk2MWGMXWWSEzMQ33x7zUn1vFs0oUseFV5LQnmTrezEVhq4tx3pRtjl28loT3zZQ8dkbUg88aQS8VERWMSUrg8Xy4tIIMqZMoBXL1U3LUXjGH2GNskOsUSqW6H2oo2IWqg1u4/p0yURSuY4f9+KxNA/V7VH9qLQF+jWK5KCr3WVfV+eGmzUijtzAyapmy9VZmGLo3KQqQEWmAs0f2HL1q+NE+lvlmNX/VmcY63+1okKSJVA0YAk6B8s708ihL0RIpZDmyQdvkDgBKD7ZTejH5vnwjGFG8FjYVA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199021)(46966006)(40470700004)(36840700001)(186003)(40480700001)(16526019)(1076003)(26005)(4326008)(6916009)(316002)(86362001)(70586007)(54906003)(70206006)(40460700003)(82310400005)(81166007)(478600001)(356005)(36756003)(7696005)(6666004)(5660300002)(83380400001)(2906002)(41300700001)(36860700001)(8936002)(8676002)(82740400003)(336012)(47076005)(426003)(15650500001)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 17:56:52.9419 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75c9a3a4-e3a8-4aae-6ce0-08db517fefdb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8480
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 Graham Sider <Graham.Sider@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Graham Sider <Graham.Sider@amd.com>

Update mtype_local module parameter to use MTYPE_RW by default.

0: MTYPE_RW (default)
1: MTYPE_NC
2: MTYPE_CC

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 12 ++++++------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c    |  3 ++-
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 8163abcc420c..562e65ab48fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -835,7 +835,7 @@ module_param_named(no_queue_eviction_on_vm_fault, amdgpu_no_queue_eviction_on_vm
  * DOC: mtype_local (int)
  */
 int amdgpu_mtype_local;
-MODULE_PARM_DESC(mtype_local, "MTYPE for local memory (0 = MTYPE_CC (default), 1 = MTYPE_NC, 2 = MTYPE_RW)");
+MODULE_PARM_DESC(mtype_local, "MTYPE for local memory (0 = MTYPE_RW (default), 1 = MTYPE_NC, 2 = MTYPE_CC)");
 module_param_named(mtype_local, amdgpu_mtype_local, int, 0444);
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 5f7e6e15842b..7dfe6a8ca91a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1240,15 +1240,15 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
 		 * NUMA systems. Their MTYPE can be overridden per-page in
 		 * gmc_v9_0_override_vm_pte_flags.
 		 */
-		mtype_local = MTYPE_CC;
+		mtype_local = MTYPE_RW;
 		if (amdgpu_mtype_local == 1) {
 			DRM_INFO_ONCE("Using MTYPE_NC for local memory\n");
 			mtype_local = MTYPE_NC;
 		} else if (amdgpu_mtype_local == 2) {
-			DRM_INFO_ONCE("Using MTYPE_RW for local memory\n");
-			mtype_local = MTYPE_RW;
-		} else {
 			DRM_INFO_ONCE("Using MTYPE_CC for local memory\n");
+			mtype_local = MTYPE_CC;
+		} else {
+			DRM_INFO_ONCE("Using MTYPE_RW for local memory\n");
 		}
 		is_local = (!is_vram && (adev->flags & AMD_IS_APU) &&
 			    num_possible_nodes() <= 1) ||
@@ -1364,12 +1364,12 @@ static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
 		/*vm->mem_id*/0, local_node, nid);
 	if (nid == local_node) {
 		uint64_t old_flags = *flags;
-		unsigned int mtype_local = MTYPE_CC;
+		unsigned int mtype_local = MTYPE_RW;
 
 		if (amdgpu_mtype_local == 1)
 			mtype_local = MTYPE_NC;
 		else if (amdgpu_mtype_local == 2)
-			mtype_local = MTYPE_RW;
+			mtype_local = MTYPE_CC;
 
 		*flags = (*flags & ~AMDGPU_PTE_MTYPE_VG10_MASK) |
 			 AMDGPU_PTE_MTYPE_VG10(mtype_local);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 9053202ab534..c5675c7e3b9e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1191,7 +1191,8 @@ svm_range_get_pte_flags(struct kfd_node *node,
 		}
 		break;
 	case IP_VERSION(9, 4, 3):
-		mtype_local = amdgpu_mtype_local == 1 ? AMDGPU_VM_MTYPE_NC : (amdgpu_mtype_local == 2 ? AMDGPU_VM_MTYPE_RW : AMDGPU_VM_MTYPE_CC);
+		mtype_local = amdgpu_mtype_local == 1 ? AMDGPU_VM_MTYPE_NC :
+			     (amdgpu_mtype_local == 2 ? AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW);
 		snoop = true;
 		if (uncached) {
 			mapping_flags |= AMDGPU_VM_MTYPE_UC;
-- 
2.40.1

