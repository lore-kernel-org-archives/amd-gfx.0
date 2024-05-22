Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DBABC25B77
	for <amd-gfx@archiver.kernel.org>; Wed, 22 May 2024 05:36:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B7B310E6A6;
	Wed, 22 May 2024 05:36:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jIgCdbV0";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12C9B10E1E2
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 May 2024 05:35:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cd8vfz7s8GmIqXILP7ex5/gz3f7nHqXznffp/raXWW7WG3d/7NlxrTHmG1aPsCrrtnIPwIPoDgi2R/uSnJgUNCyhWDzD7M2aC2+pqF82eP2Jv8Rm86wydzftkt5/Vsf+iaRl9q721fqBE3wQEKvnRPKKeP5V+3whOrR45uzdTkpYLLqXcbeeRcRc5VJhd2lUGi0532K7E3wGq8ahscEN2EuoRQo2oy4hemuSfINqfpOKKeYjGkEBl1YbmY6LnpC9iHwrni9R6WU1Yz2lA7BnK1G4UDdji66NN+MnXRwsI+BIpmwoll0aSc2ni7WmlfJGS2QKqFLr5kTHw1YHkQ1tgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VwKFF36rVjtx38TuCAAV/sCsTjTkQEywbZwEAWCZGs0=;
 b=I2fW8XaWP5k6Yzz9EmrjShffcw7bV4I0y9/Ezb360BANGQpa+rW4hpKTtc5gGVVEaepFhwKKAij56haLkGumgFUGbhtu0C+Xnz6/kTrZJ18ICujWG2YB3wc2WfuPX3GTjqduSMV/DKFMGJpCQKoPpCPvVjcumTi4zCUNyxlwfeCu38PWUMgissTLFO4sxu6S3xqSVOvJOlypDHUfgPACVAz89Esu8Eas5in/0a/eYfs0ev7bIDbBFWP2OXGmkloyxriu9SLMaGN/kpA18yGajCW4zO5M2i5hliAzE3Oh2vdqH59MY0wtaOEY1hIl7yCuScEhjD/GHphzfTKLqwRyuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VwKFF36rVjtx38TuCAAV/sCsTjTkQEywbZwEAWCZGs0=;
 b=jIgCdbV0WaI492QWZ/NbptF4lEg0VGt4Zj9noQZca8bM279/rCuGwYSZe/53Ny2pYOJfR+shSEClvCXnrmciPBU8kpJnFL28D+LWB8PGfdCK0n8UfFrV9dTJMJ4xWfX7wzg8w+cBcZ0rbq1cOU+wqsVhsUorTN5TudfU9XCebqY=
Received: from BLAPR03CA0081.namprd03.prod.outlook.com (2603:10b6:208:329::26)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 05:35:57 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::1) by BLAPR03CA0081.outlook.office365.com
 (2603:10b6:208:329::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36 via Frontend
 Transport; Wed, 22 May 2024 05:35:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Wed, 22 May 2024 05:35:57 +0000
Received: from shane-u20.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 22 May
 2024 00:35:55 -0500
From: Shane Xiao <shane.xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <felix.kuehling@amd.com>
CC: <hawking.zhang@amd.com>, <aaron.liu@amd.com>,
 <sreekant.somasekharan@amd.com>, Shane Xiao <shane.xiao@amd.com>, longlyao
 <Longlong.Yao@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Update the impelmentation of
 AMDGPU_PTE_MTYPE_VG10
Date: Wed, 22 May 2024 13:35:32 +0800
Message-ID: <20240522053532.2896100-3-shane.xiao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240522053532.2896100-1-shane.xiao@amd.com>
References: <20240522053532.2896100-1-shane.xiao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|MN2PR12MB4175:EE_
X-MS-Office365-Filtering-Correlation-Id: ff89b809-e64d-4747-b89c-08dc7a210e9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?z8pfXhgSEzhvFBN3m882TwFJyEqmqa462J1+fmUwmaCKD8XuO+qRwqsgdazb?=
 =?us-ascii?Q?otiwC9HLxcQPk3rs8DMXMt7VosbmVJXkI2+ww0ZR4VeFLAhjgDd8GarLkG1d?=
 =?us-ascii?Q?9kvbViPUT1C1caEsYmtCgLInRqmDmpXU5d4P0+mx5+/bY+tJb+HY2bDeDCX9?=
 =?us-ascii?Q?fS0wQOLevGllh4+bb4M/NalB2sUhlHbAHxgFqENX1XtexjzjQCW1s/KXaiaT?=
 =?us-ascii?Q?w1fWxUtoJawXzHc0wcqGnCYNSBs+YRszclmHttLxHF4TkOiCNx2S6EASQob6?=
 =?us-ascii?Q?kDVHREF8KTyqFxgyqBrDs+GpLnP+y2GfP1fncEFR4eA8c1O0zDaNUNBe2kh/?=
 =?us-ascii?Q?+DDLpaeQw4rFy2B/rIxD1VT+sf1wDBq0rqeIonbvmFu5mBJ2svip2GqqiQgI?=
 =?us-ascii?Q?Xsn6yp+dYOOIN5wtu579mQi/ugMfAPePDPyzskFu/ug2bzwNSheQihKAmT/X?=
 =?us-ascii?Q?Cg413HJUSOvYiIGQxu3fWHZrgqMD4484e68fE1dKvvL84GOYUJDPqaeCHFom?=
 =?us-ascii?Q?0AbLPDnb+XMPD1MKFyJsM1GTjBBGfu9TJPF4BlhObUFD9u4OD1KltWpxnyaG?=
 =?us-ascii?Q?t2KCjs0cLNT7QHW/YGT5qe8tCTpQKPvOhkhmvxe05YLZ65mM64VkzqbtIkky?=
 =?us-ascii?Q?FI6EOqhRNR6cLwp4oglWDIWDci1kIc3WOmK+CMj9+KwLFX3pEEryluzgahKb?=
 =?us-ascii?Q?fHfwbUe6EZ2ryFVGbjBZMUkJMN99mtyPZmqjjxAvr0UdDv4bMAHea33L6MIU?=
 =?us-ascii?Q?PckHXdEqD2IgV/z06akniZWHlYHFcjqo3eS3iiKSOPWkFa7+8W8J0JI28LNT?=
 =?us-ascii?Q?yYMmL+kj0j0z2LaayXNeneI/Yg7XeNq4tw3o+h0jvzxK87DbdOMGX/Kv8Y5e?=
 =?us-ascii?Q?ngVrR+ow9uEULSpxdn4m1UWNh9eonpIhpJ4O3bJ/dcLKOWgWlscCcaCba4+m?=
 =?us-ascii?Q?D/UL/FH/RbG597DF1xQtS+/HYjGfjC+twtS6y30lanmvWXpxJTmLVBhWIRDB?=
 =?us-ascii?Q?fej5tUDLXQFSp8wWY2xHgvkgVsvsOcagF5nPkPzndBYdTjd4Fz8KBMoCNEpp?=
 =?us-ascii?Q?oGSfQ/AFX4zB5hL6lZHz96ZraAtp6awFq1P64sFQEgNZXD2WsngMECRI8HIr?=
 =?us-ascii?Q?cOu4RugE5qCfydmgNpcTDbIZIb4e4asFAZst84jVcTdGqfoNm2TLgHM8ITJR?=
 =?us-ascii?Q?p6hm5teNKBneDzQTzfXG5/YNBSmm1eesV73Tir3DxLVGjQnXZOH1JjfPvmUe?=
 =?us-ascii?Q?YTnEN3TaclKEWwYfkOUI16Xg3WSAnyn/XCIWE+N76Wa5nccxgz0t7QjXhmbf?=
 =?us-ascii?Q?Pw/LAYmPAqG7S1DhRHnLv738sYgtjARSx3E/w0Z6ByqwHcSP3FY8B+T1od6S?=
 =?us-ascii?Q?1osgU1c=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 05:35:57.6829 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff89b809-e64d-4747-b89c-08dc7a210e9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4175
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

This patch changes the implementation of AMDGPU_PTE_MTYPE_VG10,
clear the bits before setting the new one.

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: longlyao <Longlong.Yao@amd.com>
Signed-off-by: Shane Xiao <shane.xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  7 ++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 32 ++++++++++++-------------
 3 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 0364a7bb5893..f09f33d1beec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -844,8 +844,7 @@ static void amdgpu_ttm_gart_bind_gfx9_mqd(struct amdgpu_device *adev,
 	int num_xcc = max(1U, adev->gfx.num_xcc_per_xcp);
 	uint64_t page_idx, pages_per_xcc;
 	int i;
-	uint64_t ctrl_flags = (flags & ~AMDGPU_PTE_MTYPE_VG10_MASK) |
-			AMDGPU_PTE_MTYPE_VG10(AMDGPU_MTYPE_NC);
+	uint64_t ctrl_flags = AMDGPU_PTE_MTYPE_VG10(flags, AMDGPU_MTYPE_NC);
 
 	pages_per_xcc = total_pages;
 	do_div(pages_per_xcc, num_xcc);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 0c4a01fad851..9990794e275e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -94,8 +94,11 @@ struct amdgpu_mem_stats;
 #define AMDGPU_VM_NORETRY_FLAGS_TF (AMDGPU_PTE_VALID | AMDGPU_PTE_SYSTEM | \
 				   AMDGPU_PTE_PRT)
 /* For GFX9 */
-#define AMDGPU_PTE_MTYPE_VG10(a)	((uint64_t)(a) << 57)
-#define AMDGPU_PTE_MTYPE_VG10_MASK	AMDGPU_PTE_MTYPE_VG10(3ULL)
+#define AMDGPU_PTE_MTYPE_VG10_SHIFT(mtype)	((uint64_t)(mtype) << 57)
+#define AMDGPU_PTE_MTYPE_VG10_MASK	AMDGPU_PTE_MTYPE_VG10_SHIFT(3ULL)
+#define AMDGPU_PTE_MTYPE_VG10(flags, mtype)			\
+	((flags) & ((~AMDGPU_PTE_MTYPE_VG10_MASK)) |	\
+	  AMDGPU_PTE_MTYPE_VG10_SHIFT(mtype))
 
 #define AMDGPU_MTYPE_NC 0
 #define AMDGPU_MTYPE_CC 2
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 094c08cb98e7..6809ab532c40 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1075,19 +1075,19 @@ static uint64_t gmc_v9_0_map_mtype(struct amdgpu_device *adev, uint32_t flags)
 {
 	switch (flags) {
 	case AMDGPU_VM_MTYPE_DEFAULT:
-		return AMDGPU_PTE_MTYPE_VG10(MTYPE_NC);
+		return AMDGPU_PTE_MTYPE_VG10(0ULL, MTYPE_NC);
 	case AMDGPU_VM_MTYPE_NC:
-		return AMDGPU_PTE_MTYPE_VG10(MTYPE_NC);
+		return AMDGPU_PTE_MTYPE_VG10(0ULL, MTYPE_NC);
 	case AMDGPU_VM_MTYPE_WC:
-		return AMDGPU_PTE_MTYPE_VG10(MTYPE_WC);
+		return AMDGPU_PTE_MTYPE_VG10(0ULL, MTYPE_WC);
 	case AMDGPU_VM_MTYPE_RW:
-		return AMDGPU_PTE_MTYPE_VG10(MTYPE_RW);
+		return AMDGPU_PTE_MTYPE_VG10(0ULL, MTYPE_RW);
 	case AMDGPU_VM_MTYPE_CC:
-		return AMDGPU_PTE_MTYPE_VG10(MTYPE_CC);
+		return AMDGPU_PTE_MTYPE_VG10(0ULL, MTYPE_CC);
 	case AMDGPU_VM_MTYPE_UC:
-		return AMDGPU_PTE_MTYPE_VG10(MTYPE_UC);
+		return AMDGPU_PTE_MTYPE_VG10(0ULL, MTYPE_UC);
 	default:
-		return AMDGPU_PTE_MTYPE_VG10(MTYPE_NC);
+		return AMDGPU_PTE_MTYPE_VG10(0ULL, MTYPE_NC);
 	}
 }
 
@@ -1228,8 +1228,8 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
 	}
 
 	if (mtype != MTYPE_NC)
-		*flags = (*flags & ~AMDGPU_PTE_MTYPE_VG10_MASK) |
-			 AMDGPU_PTE_MTYPE_VG10(mtype);
+		*flags = AMDGPU_PTE_MTYPE_VG10(*flags, mtype);
+
 	*flags |= snoop ? AMDGPU_PTE_SNOOPED : 0;
 }
 
@@ -1281,9 +1281,9 @@ static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
 	 * and can also be overridden.
 	 */
 	if ((*flags & AMDGPU_PTE_MTYPE_VG10_MASK) !=
-	    AMDGPU_PTE_MTYPE_VG10(MTYPE_NC) &&
+	    AMDGPU_PTE_MTYPE_VG10(0ULL, MTYPE_NC) &&
 	    (*flags & AMDGPU_PTE_MTYPE_VG10_MASK) !=
-	    AMDGPU_PTE_MTYPE_VG10(MTYPE_UC)) {
+	    AMDGPU_PTE_MTYPE_VG10(0ULL, MTYPE_UC)) {
 		dev_dbg_ratelimited(adev->dev, "MTYPE is not NC or UC\n");
 		return;
 	}
@@ -1312,7 +1312,7 @@ static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
 	if (nid == local_node) {
 		uint64_t old_flags = *flags;
 		if ((*flags & AMDGPU_PTE_MTYPE_VG10_MASK) ==
-			AMDGPU_PTE_MTYPE_VG10(MTYPE_NC)) {
+			AMDGPU_PTE_MTYPE_VG10(0ULL, MTYPE_NC)) {
 			unsigned int mtype_local = MTYPE_RW;
 
 			if (amdgpu_mtype_local == 1)
@@ -1320,12 +1320,10 @@ static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
 			else if (amdgpu_mtype_local == 2)
 				mtype_local = MTYPE_CC;
 
-			*flags = (*flags & ~AMDGPU_PTE_MTYPE_VG10_MASK) |
-				 AMDGPU_PTE_MTYPE_VG10(mtype_local);
+			*flags = AMDGPU_PTE_MTYPE_VG10(*flags, mtype_local);
 		} else if (adev->rev_id) {
 			/* MTYPE_UC case */
-			*flags = (*flags & ~AMDGPU_PTE_MTYPE_VG10_MASK) |
-				 AMDGPU_PTE_MTYPE_VG10(MTYPE_CC);
+			*flags = AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_CC);
 		}
 
 		dev_dbg_ratelimited(adev->dev, "flags updated from %llx to %llx\n",
@@ -1772,7 +1770,7 @@ static int gmc_v9_0_gart_init(struct amdgpu_device *adev)
 	if (r)
 		return r;
 	adev->gart.table_size = adev->gart.num_gpu_pages * 8;
-	adev->gart.gart_pte_flags = AMDGPU_PTE_MTYPE_VG10(MTYPE_UC) |
+	adev->gart.gart_pte_flags = AMDGPU_PTE_MTYPE_VG10(0ULL, MTYPE_UC) |
 				 AMDGPU_PTE_EXECUTABLE;
 
 	if (!adev->gmc.real_vram_size) {
-- 
2.25.1

