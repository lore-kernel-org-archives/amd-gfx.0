Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49777CD6E55
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 21:03:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D377D10E9A8;
	Mon,  1 Jun 2026 21:03:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QGF8epKA";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012051.outbound.protection.outlook.com [52.101.48.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B18B410E9A8
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 21:03:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pDn6sikEciH43SG48B1RU64jRZHL5fXESU3iMlqjB8dHNPNMZrLDLbX2l4eprOnLoOPyUCp099DiC4oCuqVIN25j9CxvLji+bMtB7n70d/V1qXMkv7LNs9mhZxbOd9/+6YkbN3fJPwNgoWGFSt0yoVCNveT4ruPQMhKbaLuBlI4v5tWjX0ONJJPb9on1SLUOXbRLsOGTJoLsB0THVOLfZyIxNySguovqGqxfbq1IWakuWBnmAt7UEic6qb1gdhxSr4KnGNUslUOC3Hbs6tN6s/CwF2m9a2ssJaPvmUBbMqEc5Dvrj6fGvyR6hYcAGbIwJeLUILPBN445xed0RP3b2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0TlKWrrZTrIYyMLAxIOn8KkEuF2/e1VftqP/MyWxbE=;
 b=yXTpFvuuwGk42zUprbACtvg6mNXt1ugOzPN6qmprYbzC5rIllqxNrxW8EOuL/xYqlw5uwyOi2pTDJx93C01rZMMl6z0RzLF8KgzpNA5ZZcmXDYn/x7W14UVM/y67/CakmiIrdHZKFp/gZ/oi7Xm5aYqOsmlCkgzx4M0+3dtAr22Rg+yYCMitgccWk9J05lWdC+wq0Zp3G9BfEnt1Q1LCOccbkwMzxESWhBbZde1a6vgufuHridqQZAWdw3FzPf4G6H4ZdPbUYr1GPgBXIOREWbMbO2Mj4tOAjXmzNuPqccWhDD+k91yi81+KvQJYRTm+6+wZoKFEV5szoLHGfOUMqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0TlKWrrZTrIYyMLAxIOn8KkEuF2/e1VftqP/MyWxbE=;
 b=QGF8epKAlEaa/ydcLWCUyJzCDAoa2cqpgA+OPMNySdLJ3j3qLvQOoJ+HpFOj035jGtRDhhxZ0yXQqERUvaTD3LwLFYwlAuiIOzdQLdgCuNBsCwzUirxuv4Vo4iyPE0fEVFpd8LLWYNXYnKBfwPS1YiVYqEdxABDeM38EUkFmA8c=
Received: from PH7P220CA0099.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::23)
 by MN2PR12MB4254.namprd12.prod.outlook.com (2603:10b6:208:1d0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Mon, 1 Jun 2026
 21:03:41 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:510:32d:cafe::82) by PH7P220CA0099.outlook.office365.com
 (2603:10b6:510:32d::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 21:03:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 21:03:40 +0000
Received: from yunxiali-dev (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 16:03:40 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Yunxiang Li <Yunxiang.Li@amd.com>
Subject: [PATCH] drm/amdgpu: set sub_block_index for mca ras sub-blocks
Date: Mon, 1 Jun 2026 17:03:23 -0400
Message-ID: <20260601210323.493076-1-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|MN2PR12MB4254:EE_
X-MS-Office365-Filtering-Correlation-Id: 94a994e5-4b44-4f00-59ab-08dec02141f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|56012099006|18002099003|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: KkcK3hmyNAQK0DQ1Ix1PN0zBL0I3b5Xx4yzvSf9iiSjs4gxMeLbLhrDBmeGfuBTZIvZ+BbYt+Su38AnnL0MjOZzPyhbZBYP3FKJC9THazgfopA7MHd8RSV30a/I4H69+FSHeLeKRSv4gXmeVLJyt6/xhnD0GV0tvxFP3oyAdpqxqlCThuRa/9ylTLrfMaWzWDx0FjsFwEQwNqClHUqsFkgZIvR+2mOGGTbuNLJoGAl8U/pWMudIm/tl5rBhBaHom0P90f9e0N52JKs1zEzxcoAXyyNDgRZbagr4zaPG9jAuNv71aYEOAmQV3Pfy9seMxk4VDdQfz7/AFEY7zStgePqB5PfniUIQRLI8DOxaL+qdMmPehIwYxB0mE49pEGXwpqCjoNKl3EHMlBppCsCvBvaBBF20sqGj4wHLf/AOPzgtyCZCeNxqsBxwE2ShYMeP1iP622JZ7iPAjaTls0OgmkPhhHTEVRKAhSvcqtcOBCqz8GTEMBe8X9P30GSxWVmKr/47FrKNT/ILmPJOMolei0cGD/SWyNP5gDc/Di7n30aN1GRTMyEWo7tfJJOdNz0UiwNcfdxsmM1f2EuPiwzi3hO80ulAjDhsxwfaLDBVspiqgKBw/FBhtw98R6Mg5EuwXcI3cZR4+m+CxPx2Bwnrv3Aw5VM/zK4DYVCVvK5fF+5HDiXr7ekiHtUQ/8YK9dRmvygcXmaxz7j2GFaAHzYKP/iHZpoO17dqsTj+Em12xn2o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(56012099006)(18002099003)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MGEMsJhY41xFh3MzGweKM/g9MDvu+IMis/IbN8IxUi69ejbjv8OerzBxk0IfkD2MhxEG3zltUufY/cgVazdrsC/BNjZIy8vl1/FlW+ZuIHHdR3R/qqoJZ88RKZJwwI2hxJaIX7SJTRKMLAjWKBV/AI/Qz+OvYfVCZc34Yo4pHCkkVSr6Gq1AVsewoR9p03BYb2V5RpULIcYJLqMzSD05M3KtWYGKysBq9b8i0/lnwdeLX8u+8Y98WnKcxAAplxBSNske3G72rzoOTJPaA2j7B31yqFRnJEUFvGjDJVIftvfegYNl+YWlN6kjdfM/i/HT54DgFPuZw+UOeKdnSOlTUaVW5SbjJtVpCxV/lIvvVzvenNrYTIsmufosHR+2ZmblpqL/mTpHihWJzhuN97lu5UvqTBlETrBnqNUtRtLeQKzJrG6emsKvVg/6orhnFfB/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 21:03:40.6184 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a994e5-4b44-4f00-59ab-08dec02141f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4254
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

The mca ras sub-blocks (mp0, mp1, mpio) all share the
AMDGPU_RAS_BLOCK__MCA block id and are distinguished only by
sub_block_index. The ras manager object for an mca block is selected
with:

	con->objs[AMDGPU_RAS_BLOCK__LAST + head->sub_block_index]

Since the rework in commit 7f544c5488cf ("drm/amdgpu: Rework mca ras
sw_init") moved the ras_comm setup into amdgpu_mca_mp*_ras_sw_init() but
left sub_block_index unset, mp0/mp1/mpio all default to index 0 and
collide on the same object slot. mp0 grabs the slot and creates its
sysfs node first; mp1 (and mpio) then find the slot already in use, so
amdgpu_ras_block_late_init() -> amdgpu_ras_sysfs_create() returns
-EINVAL:

  amdgpu: mca.mp1 failed to execute ras_block_late_init_default! ret:-22
  amdgpu: amdgpu_ras_late_init failed -22
  amdgpu: amdgpu_device_ip_late_init failed
  amdgpu: Fatal error during GPU init

The error is currently masked because amdgpu_ras_late_init() does not
check the return value of amdgpu_ras_block_late_init_default(), but it
already leaves mp1/mpio without their sysfs nodes and becomes a fatal
init failure as soon as that return value is honored.

Restore the per-sub-block sub_block_index assignment so each mca
sub-block maps to its own object slot.

Fixes: 7f544c5488cf ("drm/amdgpu: Rework mca ras sw_init")
Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
index 3ca03b5e0f913..e1e4a61b1301c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -99,6 +99,7 @@ int amdgpu_mca_mp0_ras_sw_init(struct amdgpu_device *adev)
 
 	strcpy(ras->ras_block.ras_comm.name, "mca.mp0");
 	ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__MCA;
+	ras->ras_block.ras_comm.sub_block_index = AMDGPU_RAS_MCA_BLOCK__MP0;
 	ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
 	adev->mca.mp0.ras_if = &ras->ras_block.ras_comm;
 
@@ -123,6 +124,7 @@ int amdgpu_mca_mp1_ras_sw_init(struct amdgpu_device *adev)
 
 	strcpy(ras->ras_block.ras_comm.name, "mca.mp1");
 	ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__MCA;
+	ras->ras_block.ras_comm.sub_block_index = AMDGPU_RAS_MCA_BLOCK__MP1;
 	ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
 	adev->mca.mp1.ras_if = &ras->ras_block.ras_comm;
 
@@ -147,6 +149,7 @@ int amdgpu_mca_mpio_ras_sw_init(struct amdgpu_device *adev)
 
 	strcpy(ras->ras_block.ras_comm.name, "mca.mpio");
 	ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__MCA;
+	ras->ras_block.ras_comm.sub_block_index = AMDGPU_RAS_MCA_BLOCK__MPIO;
 	ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
 	adev->mca.mpio.ras_if = &ras->ras_block.ras_comm;
 
-- 
2.51.2

