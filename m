Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47BBFC0218F
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 16:58:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E384210E3B1;
	Fri, 31 Jan 2025 16:58:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MYAaBTtp";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B33D510E3D5
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 16:58:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UjIZMC3LMg9gRDXcbHBDJT4sMzfTVGeFK9CW7uzWOd9Q+uaQQDiiaibjDEIRcY6mITWrMv2z7hL3B6M+p9BF3F8ipzJS2nBWnYmog+beQh5zUJ+y/5h+DipusvdWnVqPIwcJ86zwJUVb3tcbKVO+nLafbQe7AsWPlir/FLwPDtdOlemvNIciWCKXM4jH8kuSPC0N0wY6w909ich71j9YpSUP2mF/5FwblbT1+Vq6n9CLFvmageg7ccAcXsBRheN3rHpBcx95NlCXF9o2R2yVLfda4qrN0LSA4raRyYnkctx9lye18ziLsnaYvb7BRX/mmD/jNCCdtRcm9Ky/AYLTVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPgYRYvQDpOIPk+4qOLWMA45tJfd/bNXb8c9pM7wxJ8=;
 b=xOkc1saJFGH42/TJzKnTG4Tqpr3vEIbcWaEsYaBuVri53S1oGeBcj8+SKUUG44s0yySbpKEecTEgKzBSXfYF+OphFcTmSV585wKSnrn2p+4pUM/18IbHkJoTgVguAvxlfYaI+/IBuPlWqSpeN2f+CnxuTC9idu2JCmtWUp+l+fSGge7RXw5Arwqz4z3S7J37CB2T7I/nRnH6xDT59cKXPibafa6AubLlItqkwNneGWysbwKsSRc5uAKx0oVWzbzBBna9EjX253yOUgS2B2TAERcaYZoaPpHiK/2QCsKR/tvr13zlFubnxbuMMc505F+ufkaNyvq5u0gXGisIlaK6Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPgYRYvQDpOIPk+4qOLWMA45tJfd/bNXb8c9pM7wxJ8=;
 b=MYAaBTtpNUvNZdMEJIgEfcS0QAznDO4PVUMPeaaqA6S9HndisK/qiuwzZBmIa8gDlqCIJvxILtTWYMF6mcspqhf7YcYDrOUrLe74af+G8IIjlgC3+dSicoypb4y21bmAKIRU+1P9YuqyNTI5jafHVDtzS+jQG8Z5di3w04ixzlk=
Received: from DM6PR07CA0075.namprd07.prod.outlook.com (2603:10b6:5:337::8) by
 MN2PR12MB4390.namprd12.prod.outlook.com (2603:10b6:208:26e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Fri, 31 Jan
 2025 16:58:17 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:5:337:cafe::b) by DM6PR07CA0075.outlook.office365.com
 (2603:10b6:5:337::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.21 via Frontend Transport; Fri,
 31 Jan 2025 16:58:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 16:58:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 Jan
 2025 10:58:13 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 24/44] drm/amdgpu/vcn2.0: add set_pg_state callback
Date: Fri, 31 Jan 2025 11:57:20 -0500
Message-ID: <20250131165741.1798488-25-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250131165741.1798488-1-alexander.deucher@amd.com>
References: <20250131165741.1798488-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|MN2PR12MB4390:EE_
X-MS-Office365-Filtering-Correlation-Id: 0261381a-e1ad-4b92-8663-08dd42187577
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+ux5jV3u/dRe1T6AJNF/JJSx+SPNPi9hfAH5cYK+FSDmHQdGmHZ7YSzxCGdD?=
 =?us-ascii?Q?Ult7D2ji8S2yHjMufuXpNnYNIg74QHWB911r75d+Q11LQgS+vW5aWaAA0OK7?=
 =?us-ascii?Q?gZoFjMDoUlViu9aRYpwXNZTzXK54E5VHySLr0PJScQ4v29tSuzJIzPN6rWK2?=
 =?us-ascii?Q?fIIpxWb/Nk21BwESjV+hcBTvpHOCXOmeknihXiuf+e4q2Hb4NFSSVkiXRYjA?=
 =?us-ascii?Q?bushtsQDR+43hgH0HO8oJwUR6D6BzLg4SK9n2RwbgRRLjuHJDc82J/SSHCdM?=
 =?us-ascii?Q?AXqFEi5ccZRmb352R4hyVU2BV8lM1+BUvcuJZfpNdsaCzTRFY6J+NhRoclzg?=
 =?us-ascii?Q?kDg/STQ3epYygbmqP53pB5VO9bckmEMtkwbWEPnw1PcSdZuLvV04Tus3pMDp?=
 =?us-ascii?Q?HtK23yjYfumPmP7e8HESu+oB1jB/VK5RKdsBTgH1BD3tJvRhr/SJzB8v0et2?=
 =?us-ascii?Q?wGVgB1DawsCHIihhuCYDa7LQq2jyy8MdKTxZXiYt6mMEQyAclQsrBl2UJFob?=
 =?us-ascii?Q?i+2sEotoIxSokE5MIKbQlR59GHnD1sRhzm+BDhTvyceQINiDEmj2VLWoIxwD?=
 =?us-ascii?Q?BaMuyx4eoOzgM30q4M/3/Vl6pwX/PRdSHRXn3oimmRzyIovhqwOW8gTD7k5g?=
 =?us-ascii?Q?6RDciyTgSgCYyHsktMJFFRkwEGhQj6BQM07d0HJaH1aFiJwUdix1VEzL0zej?=
 =?us-ascii?Q?pg9629aMEiPlexEZjsc690X6nA/ejC0uv3tI47STIfYcuUATZG75SOGX+5jJ?=
 =?us-ascii?Q?wDPft8e1Xa7hR34CPjdNQW2ZIo7SqNUKUFFyM65/JoOD69KqrDHG1q8LK9va?=
 =?us-ascii?Q?2BHwiF5tMYVrjYz3nwQkyl/vTbp/ZPM6AmE6MQlwJOrPORh55gTpi/duQ6HY?=
 =?us-ascii?Q?lpjhux4aRvpzXdSx/FuZZzXug8ucmFKHLGlZJW3wnH2XD3ykIPb5VMwzVNot?=
 =?us-ascii?Q?NoMKPwf0oWuXb3unBRRgAOm4rOb17l+dfVTlTVZBt3vybvHNi906Du8iEQHd?=
 =?us-ascii?Q?jxFVWW+Cy/QiaD2rTwgTPd1ygFNxpRrcmjUOVvf78xJaGD0nLhQg4JQDAoTS?=
 =?us-ascii?Q?+FnVUQJ/vb2on2GC1iCeXOC2dVfvLVklwD4Cnm/+TnT64zi2zDJvYPNEoj3O?=
 =?us-ascii?Q?qFMFbfqc0jAeI961vtCrFtFkoUWo6Us4ksLC/QUV6MpfgTe7D0TSCqyoHf+i?=
 =?us-ascii?Q?T+N32kbMPyM3r8xpc5I0PpCl4uKu7XWCuOmiFf3XihT7MHyz6vdKzUhepMgj?=
 =?us-ascii?Q?Xuh8Y+8qJVCfLLHdzJD+arTA5Vb1c0GCy4ziAGWsPpPKkUdOY0ovCTlbK75K?=
 =?us-ascii?Q?s+TE6QCaY9zwo5PrPogjGragKLf3XBwsZi0MG6qF6IuctDMonEN0lgPme8Hz?=
 =?us-ascii?Q?7PR0RPUI0OGOBMEjGN5V7eo4LJgpz5Qqwjk12yX3IMkkPUn8ss30/vhzqcxi?=
 =?us-ascii?Q?ltnxQiTy7VpP4zeLwVt+WirlegRV38e+9M6Cm+gFZKOJKL/UbDeUWA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:58:17.2644 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0261381a-e1ad-4b92-8663-08dd42187577
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4390
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

Rework the code as a vcn instance callback.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 35 ++++++++++++++++++---------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index e4305687749a8..ecbf0dd0b6603 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -92,6 +92,8 @@ static const struct amdgpu_hwip_reg_entry vcn_reg_list_2_0[] = {
 static void vcn_v2_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v2_0_set_enc_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v2_0_set_irq_funcs(struct amdgpu_device *adev);
+static int vcn_v2_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
+				 enum amd_powergating_state state);
 static int vcn_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 				enum amd_powergating_state state);
 static int vcn_v2_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
@@ -114,6 +116,7 @@ static int vcn_v2_0_early_init(struct amdgpu_ip_block *ip_block)
 	else
 		adev->vcn.inst[0].num_enc_rings = 2;
 
+	adev->vcn.inst->set_pg_state = vcn_v2_0_set_pg_state;
 	vcn_v2_0_set_dec_ring_funcs(adev);
 	vcn_v2_0_set_enc_ring_funcs(adev);
 	vcn_v2_0_set_irq_funcs(adev);
@@ -312,13 +315,14 @@ static int vcn_v2_0_hw_init(struct amdgpu_ip_block *ip_block)
 static int vcn_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	struct amdgpu_vcn_inst *vinst = adev->vcn.inst;
 
-	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
+	cancel_delayed_work_sync(&vinst->idle_work);
 
 	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-	    (adev->vcn.inst[0].cur_state != AMD_PG_STATE_GATE &&
+	    (vinst->cur_state != AMD_PG_STATE_GATE &&
 	     RREG32_SOC15(VCN, 0, mmUVD_STATUS)))
-		vcn_v2_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
+		vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
 
 	return 0;
 }
@@ -1810,8 +1814,8 @@ int vcn_v2_0_dec_ring_test_ring(struct amdgpu_ring *ring)
 }
 
 
-static int vcn_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
-					  enum amd_powergating_state state)
+static int vcn_v2_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
+				 enum amd_powergating_state state)
 {
 	/* This doesn't actually powergate the VCN block.
 	 * That's done in the dpm code via the SMC.  This
@@ -1821,27 +1825,36 @@ static int vcn_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	 * the smc and the hw blocks
 	 */
 	int ret;
-	struct amdgpu_device *adev = ip_block->adev;
+	struct amdgpu_device *adev = vinst->adev;
 
 	if (amdgpu_sriov_vf(adev)) {
-		adev->vcn.inst[0].cur_state = AMD_PG_STATE_UNGATE;
+		vinst->cur_state = AMD_PG_STATE_UNGATE;
 		return 0;
 	}
 
-	if (state == adev->vcn.inst[0].cur_state)
+	if (state == vinst->cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
-		ret = vcn_v2_0_stop(adev->vcn.inst);
+		ret = vcn_v2_0_stop(vinst);
 	else
-		ret = vcn_v2_0_start(adev->vcn.inst);
+		ret = vcn_v2_0_start(vinst);
 
 	if (!ret)
-		adev->vcn.inst[0].cur_state = state;
+		vinst->cur_state = state;
 
 	return ret;
 }
 
+static int vcn_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
+					  enum amd_powergating_state state)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	struct amdgpu_vcn_inst *vinst = adev->vcn.inst;
+
+	return vinst->set_pg_state(vinst, state);
+}
+
 static int vcn_v2_0_start_mmsch(struct amdgpu_device *adev,
 				struct amdgpu_mm_table *table)
 {
-- 
2.48.1

