Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E9AE77189
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 22:54:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8BA810E9E8;
	Tue, 10 Dec 2024 22:54:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Id5t+JNw";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9464310E9E1
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 22:54:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sFTd39Idl2RBOvWx9WYjKTtrTAxSihNbYKEvvPIKPbtkT4f41ohh2AgBW17F/zZSQfN4Md/9nWDqN6wTztj3s3GBP4AXmBMEwKAuxbGlZhFdVvDMny85CPo5UR/Lt3XHoGMrkOCCN8Z8tB0d/h9hjBbxIIUl/2GhOWn8c2j7hjMwUZ6Sk1ratonBTzPFKxS7RDtGz+mIUBIgjO2bos3BH2wLK+bKBnelXIEMs1SQgEpNPRaU/RqgdRrdfzcW78mBCoa7E/KRCpRfCiYc7ciO0MTZrCg6jZGFxeQ1Oq63mEwDPdUNtA7ISBVMIVAwuNoALT5ETEp52plU9SBx6wy4TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHL6WPya8jOz4qDKsNBAKgZTy2NgrFpUkRdN9ZyjgNs=;
 b=nyjLv4MVx5RAO0K/UA2c94sMrFN7qPi8hkC5O1h/Ak4Mm2CALht8ciLMqQT42ZzyARe7hcgj2uzGtawxLdG9j/a/jsDBdV0lyBgbVB9jUVomg3jsFmANtpa1ZfSFHX0CTQ8PzZZFdLKcdq9hllniXZqrot/r3gSGyYOr8E3eN2nGtStUM0OrYeSuObTRP01ChFNurkTjVXumGK7NQKoBBlrNg8/prQY98J59ZHguWt5LGawzFOjJvCtdQpo3FiIMaP+uoYvFaIyU/XoPJ2/Pc+y7GKBLXAHHTTK0mGg+utJXoxBcbuYtK5qcDDrWDlWVUiMk3DpSktO0KmAIOC7WDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHL6WPya8jOz4qDKsNBAKgZTy2NgrFpUkRdN9ZyjgNs=;
 b=Id5t+JNwuTWvorG36XxZrtFIidJEXEUr6bQOt8H9Q0qKGurD5iSvOX7X846DE3m+BzLpYaex3++0+Wcp+55H0ZD1uVM6OEo41AyT/ZRKwwpUBJhQEj5MXmJLBGi5moac05c+ueex4Zkr731li4xNPP4HDHC7ZA4E7nAtpHYh3iw=
Received: from BN9PR03CA0225.namprd03.prod.outlook.com (2603:10b6:408:f8::20)
 by SJ0PR12MB5661.namprd12.prod.outlook.com (2603:10b6:a03:422::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Tue, 10 Dec
 2024 22:54:12 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:f8:cafe::7f) by BN9PR03CA0225.outlook.office365.com
 (2603:10b6:408:f8::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.18 via Frontend Transport; Tue,
 10 Dec 2024 22:54:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 10 Dec 2024 22:54:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 16:54:04 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 23/48] drm/amdgpu/vcn1.0: add set_pg_state callback
Date: Tue, 10 Dec 2024 17:53:12 -0500
Message-ID: <20241210225337.75394-24-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210225337.75394-1-alexander.deucher@amd.com>
References: <20241210225337.75394-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|SJ0PR12MB5661:EE_
X-MS-Office365-Filtering-Correlation-Id: 07cc86d9-e5b6-4564-c475-08dd196d9057
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RB5KE1eifxQ8PLNz7elIbvLE3825dkURol85ojASZQXO7zt7dGRtjL8Camq9?=
 =?us-ascii?Q?zjCDNmroxeDEnp0b1PcVKeEL/+/71RVs93xgpLk4uBPg1hU2Cc+s7+DUPSmp?=
 =?us-ascii?Q?M6en+AXEmPYYlnjNK7+D0V9c+gaq5U51S7DecuIVuO07Ia3J8odBZU9dnMgX?=
 =?us-ascii?Q?34Y3yIFLkKvRfS5OM5sWvRuxGSRDtwcTbl8NXw0R+QKmn0w5ibU68y4LOtLO?=
 =?us-ascii?Q?odhjLP/ynMgECIUELxB6i9wSRPiM0Bxlj4CKmNqu2/h7LSP4CiBagXKiEwBg?=
 =?us-ascii?Q?7h1SZfyjlBm4j9MJCYXa1kUOusUHXdLeIcFbPMRFYLYw+Se0hCazNudghJeA?=
 =?us-ascii?Q?OrlW1NnhrRtpiL3AWrwIBXu+GXknVUQejGtrlIdQ38fsJ4+BpcEU4e82+/Ks?=
 =?us-ascii?Q?sdJWYPBD6MUkHsKcBwajmDtc51Q/VKDC6b6S6TIR1aHYIu2B7NgB7B/59gRn?=
 =?us-ascii?Q?8H+DiNLL4QpBlgm7WvZ5v2oBNLxv6rVtTvCcXkbKfgJSULWs/iaxjXH9lbMd?=
 =?us-ascii?Q?nk8fwxC1fD4cV7k86vUAZ2LJHLOj4Z7pwttatFDL6s/U1Mej9uTzW/uWOCji?=
 =?us-ascii?Q?3b9ohNrIKqgPEyyzN2hVq/lKqlz4oCH6Hl5EtP/rAVlaTyRRE5IufLj1ceDm?=
 =?us-ascii?Q?y68fJv37BYEI1WaolcxKtFsZ79bGMa40oJSimvp/uIqxKxwQzkypD7dXff9h?=
 =?us-ascii?Q?jHZ/GkEoIjZ1jcVdWs0rkAieFNDWnEi5ZeMxMLk9k7LUaRNWFBFLHGAoGyhL?=
 =?us-ascii?Q?0M9Jxmvt0wKyhcAZZgpr0OjaT4hDMv6SbD/GYmCJu1efPz6kJLsE5ERF8CeY?=
 =?us-ascii?Q?P1PUpy2AaRBWHBn1inDm/ZteiHtGvq+7UOaCp/HFqa76ut0EQwa0ALQCaOas?=
 =?us-ascii?Q?IDV/Z1prWLKl4SyD+8QlGyTHCtG7tlfBLfe5sssm/1MHT8hS7h2bg4KDkGy5?=
 =?us-ascii?Q?JiHJy0E5NRlLoZSFG22iccJUga/2CsoyDmI66uEFAeRRnj7j2vm9HC/Vvp7v?=
 =?us-ascii?Q?bVJ+tX+IT6KkRr1QntjoRhl4oHc6jekhy/yMRi21VeFDE9cjKyOEnQH1vHLp?=
 =?us-ascii?Q?GG1c8U1U7tAM2sZ0GrN3S9El5FMGTBrWLOjhA/k6Cly8SHMEGXy1/2Jvfo3J?=
 =?us-ascii?Q?0aY/Xrj7uQVeuq35QgKBE4++V18iuGhpSIxywmYi/F4oTinzLzBaFeJvJqNb?=
 =?us-ascii?Q?HUsf1Cerh7nvAzA2Zq+AJtHmd3iY7MsRjHvA+FHmQm5+mJKvChTI/PO8N1hY?=
 =?us-ascii?Q?WtcosmLArmxT4afWdqTefCB/T2i2F32y9zHzyKVUfX/YrCLKX6UJ22Q6+dc0?=
 =?us-ascii?Q?5dABJTr3SSWA2XwIhbI9pJ6Ui6cpx0VOXHPk3gs3a3u7AEVWRmR19Uxa/7DX?=
 =?us-ascii?Q?/bxtcVbYXtllbkaUjtxDLH70sorERD0GaswKIhaGQcGCleVchw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 22:54:11.9654 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07cc86d9-e5b6-4564-c475-08dd196d9057
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5661
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
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 29 ++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 95e370b28e1f3..670851166a805 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -85,6 +85,8 @@ static int vcn_v1_0_stop(struct amdgpu_vcn_inst *vinst);
 static void vcn_v1_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v1_0_set_enc_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v1_0_set_irq_funcs(struct amdgpu_device *adev);
+static int vcn_v1_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
+				 enum amd_powergating_state state);
 static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 				enum amd_powergating_state state);
 static int vcn_v1_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
@@ -106,6 +108,7 @@ static int vcn_v1_0_early_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 
 	adev->vcn.inst->num_enc_rings = 2;
+	adev->vcn.inst->set_pg_state = vcn_v1_0_set_pg_state;
 
 	vcn_v1_0_set_dec_ring_funcs(adev);
 	vcn_v1_0_set_enc_ring_funcs(adev);
@@ -276,13 +279,14 @@ static int vcn_v1_0_hw_init(struct amdgpu_ip_block *ip_block)
 static int vcn_v1_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	struct amdgpu_vcn_inst *vinst = adev->vcn.inst;
 
-	cancel_delayed_work_sync(&adev->vcn.inst->idle_work);
+	cancel_delayed_work_sync(&vinst->idle_work);
 
 	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-		(adev->vcn.inst->cur_state != AMD_PG_STATE_GATE &&
+		(vinst->cur_state != AMD_PG_STATE_GATE &&
 		 RREG32_SOC15(VCN, 0, mmUVD_STATUS))) {
-		vcn_v1_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
+		vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
 	}
 
 	return 0;
@@ -1818,8 +1822,8 @@ static void vcn_v1_0_dec_ring_insert_nop(struct amdgpu_ring *ring, uint32_t coun
 	}
 }
 
-static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
-					  enum amd_powergating_state state)
+static int vcn_v1_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
+				 enum amd_powergating_state state)
 {
 	/* This doesn't actually powergate the VCN block.
 	 * That's done in the dpm code via the SMC.  This
@@ -1829,10 +1833,8 @@ static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	 * the smc and the hw blocks
 	 */
 	int ret;
-	struct amdgpu_device *adev = ip_block->adev;
-	struct amdgpu_vcn_inst *vinst = adev->vcn.inst;
 
-	if (state == adev->vcn.inst->cur_state)
+	if (state == vinst->cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -1841,10 +1843,19 @@ static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		ret = vcn_v1_0_start(vinst);
 
 	if (!ret)
-		adev->vcn.inst->cur_state = state;
+		vinst->cur_state = state;
 	return ret;
 }
 
+static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
+					  enum amd_powergating_state state)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	struct amdgpu_vcn_inst *vinst = adev->vcn.inst;
+
+	return vinst->set_pg_state(vinst, state);
+}
+
 static void vcn_v1_0_idle_work_handler(struct work_struct *work)
 {
 	struct amdgpu_vcn_inst *vcn_inst =
-- 
2.47.1

