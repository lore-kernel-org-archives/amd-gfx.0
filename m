Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD7FC7EE2A
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 17:56:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62EB010E4F6;
	Wed, 10 May 2023 17:56:57 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2051.outbound.protection.outlook.com [40.107.212.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9079610E4DC
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 17:56:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KkupHtBYnJq/GwLPTPbwP3ozONSZ2NZ597NoDzJM54aygJgdx2IsoPIYZcIIi+2XeQLjIj9yrot0TiRDUUV9lz9ZqUPyYcEn+/OiCSvAncla+7XsougV2J1iUqqyOmMZ3/EBmj3QAkOOquza/t5d22Q+g5vrVKOvgcObzZ11p08G4vSshgHrg+TpAH3kGC/6rrIa/hPM1+ysYskSyNSmP+Z++KhhFOHThWBW1Wmt8DKjDlHD4Lg36IiOT3suN+NGWmROM08clbmB0mTBTAsgcEEN3hUGAWfd65QAPccM+0u17AX8gVe0540in9uXs4b586GKhuSWfORDAD8GPHa2OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9U80IwBgqziE8gtH1b46A5re4rsj7m1eRvAoj0nx6Aw=;
 b=jDBT4j6z02cYkLGnew7mbODKtQYQMEsnMzvuWDEbG4yyPjGkqUhhjhiWQnkN/AU3gwNBNJV3sUOtJZqztFJCdWjwPl7hZuERx1O2GZAxE8Jpk9GgHWKmXwh5P6bAIBJvqweSR4Nxy5v2NBt/lTwA5hCuwChbiQx/VwQYVechXPKeaI3Oz+ojw/Tt8HgGpO466YY4b5B0E18+E+tv0qC5HVdNC+GrIJ8H0qTpK/ghQk/XQxjhdMtuolkzPTISY+XGsnla3snLt425sZRBIN5S0r6qzqdVBQtlF3f3lvC4krUhUemtt8MlLAGluo7MeBktrGCDRSXg/xD3IVfDdBSDDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9U80IwBgqziE8gtH1b46A5re4rsj7m1eRvAoj0nx6Aw=;
 b=YTvByKujj0d8UqlcznDytKWieGl80k0CU4A1EXuolBdxCdy9GDl4ggn59dM0pPrkzc0W5/RMzF2ri8E1mt9yQ514a4R6tBvfnbgcIq4XQQ0LuOfQeDW/FbMMUOMbl2RdCSrfHcVQ4CNluXMq+lNWpIW5oDZt7X3cSxBs34vA1hM=
Received: from BN9PR03CA0935.namprd03.prod.outlook.com (2603:10b6:408:108::10)
 by DM4PR12MB6590.namprd12.prod.outlook.com (2603:10b6:8:8f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Wed, 10 May
 2023 17:56:52 +0000
Received: from BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::22) by BN9PR03CA0935.outlook.office365.com
 (2603:10b6:408:108::10) with Microsoft SMTP Server (version=TLS1_2,
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
 2023 12:56:45 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/6] drm/amdgpu/bu: add mtype_local as a module parameter
Date: Wed, 10 May 2023 13:56:29 -0400
Message-ID: <20230510175630.938276-5-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT086:EE_|DM4PR12MB6590:EE_
X-MS-Office365-Filtering-Correlation-Id: 53c74b20-8acf-45e5-fc73-08db517fef87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SdYaLLHkZEJkLTzXGJ9YcxT5lkcNpyeyzmHggTkg73DtJGXS9vVJfgZmYAFlB+WoMlZYE7BfBLrQaPwcJX+CWdsjvG+z3/ZZb+PZ5TM4XJUSKMhPoWLCiuOSH66tMc1pmjCBe6nh2SLRb036K2WaXXwZj5qdUNHkco0jHA02w2GOO4iy685Kpe/2oRG1LwAhyVv4lQax9lF7RVPYN+b9UfNF7fNxEQLCORQxMCGi+4VN+Rd06wLZnyi+3A8xjPvxABgnGkG9pEO8bsW47ywA57JanBntJhYGnh8xlibID5LUlipxwo81WHoGIEjLohykrwrPKTaztEqanxgQHpbI4XehCAfkyH4JV/08CFtBQc6N0iepugv+b8Qqo6KLjuSMtUzTRlNEgcFQHCN0+y4mmAuNPDAMeiXXE2Szr0JxANeKoq6IZj2ohUBSnSNzN5o5VFwapAwazwTGAQCkGqs6ud0KZC7WNskdRR5+cy+ZG4H1ZtO7WKRzqcE1zHC1RaxhCFyNSxaFjemPVqSsvmfb6jX82Q0H6MR9UolA6JHoDAxobt/JWO2uSWLMEQcobiHE0Scyu+FLkqD58R21uLqy5Bhu928jh4cpTTCGDC89zZkJ0g24wmPJFwyNNL/y7g1PcqKIinds1twUZ+Nl7osQIMdizwOYNnJmnptDkV7aQjCWbe3KJovYsuAQiOWjBxV2oCPvHOtoiJhMyN+v9WdG6NP5E7QWZvuTq8a52XYNW2KZ6d0pRl/mhvfOBv8eQxAQ/FLlLoyd6PvcUoz9YDvbgg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199021)(46966006)(40470700004)(36840700001)(40460700003)(6916009)(4326008)(70206006)(70586007)(478600001)(54906003)(2906002)(5660300002)(8676002)(8936002)(316002)(426003)(336012)(86362001)(41300700001)(40480700001)(7696005)(26005)(82740400003)(16526019)(1076003)(356005)(82310400005)(186003)(36860700001)(36756003)(81166007)(83380400001)(47076005)(2616005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 17:56:52.4107 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53c74b20-8acf-45e5-fc73-08db517fef87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6590
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
 David Francis <David.Francis@amd.com>, Graham Sider <Graham.Sider@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: David Francis <David.Francis@amd.com>

Selects the MTYPE to be used for local memory,
(0 = MTYPE_CC (default), 1 = MTYPE_NC, 2 = MTYPE_RW)

This change is for internal testing only - do not upstream.

v2: squash in build fix (Alex)

Reviewed-by: Graham Sider <Graham.Sider@amd.com>
Signed-off-by: David Francis <David.Francis@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 19 ++++++++++++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c    |  3 +--
 4 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index a3a0dbeb251f..bed6d1d09ac2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -213,7 +213,7 @@ extern int amdgpu_noretry;
 extern int amdgpu_force_asic_type;
 extern int amdgpu_smartshift_bias;
 extern int amdgpu_use_xgmi_p2p;
-extern bool amdgpu_use_mtype_cc_wa;
+extern int amdgpu_mtype_local;
 #ifdef CONFIG_HSA_AMD
 extern int sched_policy;
 extern bool debug_evictions;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 2f38c49aa597..8163abcc420c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -832,11 +832,11 @@ module_param_named(no_queue_eviction_on_vm_fault, amdgpu_no_queue_eviction_on_vm
 #endif
 
 /**
- * DOC: use_mtype_cc_wa (bool)
+ * DOC: mtype_local (int)
  */
-bool amdgpu_use_mtype_cc_wa = true;
-MODULE_PARM_DESC(use_mtype_cc_wa, "Use MTYPE_CC workaround (0 = use MTYPE_RW where applicable, 1 = use MTYPE_CC where applicable (default))");
-module_param_named(use_mtype_cc_wa, amdgpu_use_mtype_cc_wa, bool, 0444);
+int amdgpu_mtype_local;
+MODULE_PARM_DESC(mtype_local, "MTYPE for local memory (0 = MTYPE_CC (default), 1 = MTYPE_NC, 2 = MTYPE_RW)");
+module_param_named(mtype_local, amdgpu_mtype_local, int, 0444);
 
 /**
  * DOC: pcie_p2p (bool)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 5c9f0169292e..5f7e6e15842b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1240,7 +1240,16 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
 		 * NUMA systems. Their MTYPE can be overridden per-page in
 		 * gmc_v9_0_override_vm_pte_flags.
 		 */
-		mtype_local = amdgpu_use_mtype_cc_wa ? MTYPE_CC : MTYPE_RW;
+		mtype_local = MTYPE_CC;
+		if (amdgpu_mtype_local == 1) {
+			DRM_INFO_ONCE("Using MTYPE_NC for local memory\n");
+			mtype_local = MTYPE_NC;
+		} else if (amdgpu_mtype_local == 2) {
+			DRM_INFO_ONCE("Using MTYPE_RW for local memory\n");
+			mtype_local = MTYPE_RW;
+		} else {
+			DRM_INFO_ONCE("Using MTYPE_CC for local memory\n");
+		}
 		is_local = (!is_vram && (adev->flags & AMD_IS_APU) &&
 			    num_possible_nodes() <= 1) ||
 			   (is_vram && adev == bo_adev /* TODO: memory partitions &&
@@ -1354,9 +1363,13 @@ static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
 	dev_dbg(adev->dev, "vm->mem_id=%d, local_node=%d, nid=%d\n",
 		/*vm->mem_id*/0, local_node, nid);
 	if (nid == local_node) {
-		unsigned int mtype_local =
-			amdgpu_use_mtype_cc_wa ? MTYPE_CC : MTYPE_RW;
 		uint64_t old_flags = *flags;
+		unsigned int mtype_local = MTYPE_CC;
+
+		if (amdgpu_mtype_local == 1)
+			mtype_local = MTYPE_NC;
+		else if (amdgpu_mtype_local == 2)
+			mtype_local = MTYPE_RW;
 
 		*flags = (*flags & ~AMDGPU_PTE_MTYPE_VG10_MASK) |
 			 AMDGPU_PTE_MTYPE_VG10(mtype_local);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index ab1acf97d049..9053202ab534 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1191,8 +1191,7 @@ svm_range_get_pte_flags(struct kfd_node *node,
 		}
 		break;
 	case IP_VERSION(9, 4, 3):
-		mtype_local = amdgpu_use_mtype_cc_wa ? AMDGPU_VM_MTYPE_CC :
-						       AMDGPU_VM_MTYPE_RW;
+		mtype_local = amdgpu_mtype_local == 1 ? AMDGPU_VM_MTYPE_NC : (amdgpu_mtype_local == 2 ? AMDGPU_VM_MTYPE_RW : AMDGPU_VM_MTYPE_CC);
 		snoop = true;
 		if (uncached) {
 			mapping_flags |= AMDGPU_VM_MTYPE_UC;
-- 
2.40.1

