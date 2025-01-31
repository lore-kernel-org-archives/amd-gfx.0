Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA7B2C02199
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 16:58:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B67E510E3DB;
	Fri, 31 Jan 2025 16:58:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oOUEYO0h";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2080.outbound.protection.outlook.com [40.107.96.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E2F010E3C9
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 16:58:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sOm6SXITvy3A3LrbYrvBQalggnG6vtAr1FQ+mVuRkwrHEj8lJkguzdFnm4iySFhVTpPryYfknXYYojOpDQMVV6vM0uZyfhTmk5SPRquKnc0Ee5dCFAu5Qb4XgiXTU6xXdNaCLMMw6e8YbN6ZW8n8Xk8RMv2RFgvlaPnzH2XAJK1h9VF2CXjDo29h8B47EDhvGB04+uVVICemE5YodkifhKobqFIiSsy3svjmIwnrlOF0YyZfHmCJEvubkjrbnRtuUvJMBa8waEKZERTsigCP5zkiZkh4STTg8ywYJrePIHpyeq2EnMNBcg5Kdoei1VlAxHXs8lQ7F1OndUBIQhlaiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8B7jtiVaH7ErkYZXTneciDiViwHghJ8HoZEXBoHGBfQ=;
 b=JOUW81Zqr39iWA825GilUMQW+Nldel006iARmqSQJUMeU1gCPSaxyVKZacQoEfsxuBPzYW19Qh3IzMQxE94Ffq/nK2BtU728+57lZhczOaReGHXNhIMYpaeYxad1lribfydK/ZRDncjMkJs0KKBeIlwje6YQtK+nD88fuqkxFt4LDEGKqVQ7ti0r5S075YQDh4+p+k7CW+ivu/PSJ+E2THvrI32jU5Egd0LReDrR5MNOmBVGHpNV5K/8LcQ1f3tMBCxRRDJDst/k+NBmXHOo235DUt9OOiZeB6SVqFScDf1y4aJjzw0fXre1Fq5klxHrTdTBXLS8hhbspIC2k0D6TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8B7jtiVaH7ErkYZXTneciDiViwHghJ8HoZEXBoHGBfQ=;
 b=oOUEYO0hyO6V9pSuaHcaSswwk+AJnplFk3SykAgT32HlIFfGQLh20yxXp9r4o5HQ30jayioeKA+6ld8bxnspL0rfRwbgTvSOYUkpCxK1zyMzOternUzOeQn+fDEVIRjPNOZb04KZL/b95YEQhkjBsTsH9X2P3lEt7eT8Hms7tpM=
Received: from CH5P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::23)
 by SA1PR12MB7197.namprd12.prod.outlook.com (2603:10b6:806:2bd::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Fri, 31 Jan
 2025 16:58:19 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::a8) by CH5P220CA0024.outlook.office365.com
 (2603:10b6:610:1ef::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Fri,
 31 Jan 2025 16:58:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 16:58:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 Jan
 2025 10:58:15 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 27/44] drm/amdgpu/vcn4.0: add set_pg_state callback
Date: Fri, 31 Jan 2025 11:57:23 -0500
Message-ID: <20250131165741.1798488-28-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|SA1PR12MB7197:EE_
X-MS-Office365-Filtering-Correlation-Id: bf4f225b-2709-406c-0e79-08dd42187651
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Hv1bLaVqezDjIpiBo2u1yeD3HBHPkVTIZtV9+XXnecMUIYN3x0J4Nzo8Qhty?=
 =?us-ascii?Q?cNzalnlLqxe2Un/+WsF93VrRMK7dxLFpoFuFzRWiHRXyw+JD2i5v923S+iVb?=
 =?us-ascii?Q?MHgcmHpRZRT4xgPhN9uJq5L77j0Kwuy5nfT1SG2G+K1RseESi/HmJedxXNmz?=
 =?us-ascii?Q?jgj9mOscyX40qWr9BcMtYGobax25ac5Ov8VhOhNb/JOgdXKw/yaIhEP1f71L?=
 =?us-ascii?Q?NnGW4TbeBlNPfV63+vQW2pNi4pS83IyK97fdr5BNcPTVNwZZ3/BdC/vaq27N?=
 =?us-ascii?Q?DxKUBYC/l8+ywma1PzT90CgENUNZPFbKKXwCXjmxZWQsf/rHIALTQFUfF6hg?=
 =?us-ascii?Q?YRs/Y/jA9lhNv97QyXGbRFpTFZ8O2GBuz1niVSxeycNAFYETbVYLGrf191Y5?=
 =?us-ascii?Q?gv0gwGPLzDFY6MZmBis/T3yjsh0koMG+02dQHpUifnFnw9sKXWsCV/rG3RtZ?=
 =?us-ascii?Q?QI2bjroTAJd+lY2xSXFNu6YKjlN35eYzsvufIQxeRtyCafSAIdK4UarNIcCd?=
 =?us-ascii?Q?PeCuPFSl3IBpQZM7D4OMJLp9TxHy96bMoZX20b0I+68ug4MwraUt4Iemc6eG?=
 =?us-ascii?Q?t4gYEBMgg1kKTfcXpBnG/ovZP9usBS6Dmtha3LlGojBE6MPKEyYqjKa3leSJ?=
 =?us-ascii?Q?1IL5d6F4i/UWK52+0g2wFVkFaJQoXXpO8viQ1HJVtUQardERFwsUpz8VWbf8?=
 =?us-ascii?Q?Rli6qSyHp0lKv9T4uoV5BsBPB7wwveUHab57p64efWGOizr5SaCMZ8ytIO2W?=
 =?us-ascii?Q?NMY0csV7aoA57m0lDnEhooUb0iaPh60VWw5qQjzl6hpXXTnsn3nh0+rOKr5h?=
 =?us-ascii?Q?bWFD8/YxJRL0f/ZRCkEVKVnQkB1W6k/lRrHr0UmoMUJ1Xz6unBqJd/cy5KH4?=
 =?us-ascii?Q?1q/Zom4+S+HZ2JMiicK0QM/99NRSr5USnyrQCKeiYCidRilTHQNOMJAyDv0r?=
 =?us-ascii?Q?b/gI3bLb6wSxBnFTgvJPKUBS7kE2cVIg6IwDMq1ZHqP2hLEiMicYrQEa08My?=
 =?us-ascii?Q?q5rupuF3M+exAGD7GdVPyqZrkzP+GgcNhw3xwGZ/E87i+na2tHWPfNEJoohz?=
 =?us-ascii?Q?gfcq2GA7fDtPys+unfHTuob4QhQhXjKXWYPxVSaAnY7nCtXiWeVMTNfyuj3o?=
 =?us-ascii?Q?wbYDlIE6NrC1ctzU9heEKS5plMgir98SFi1i+WY9/tIBBmTKOx0xcZ8+VcL8?=
 =?us-ascii?Q?0zdgXJ+0fIxNILvitYg1usURYI3ktYQbBR5rxBnJetAs8seNwv2wgzwO+cwb?=
 =?us-ascii?Q?45EZDe4MQHUYuvqgJN774JD4Ha0mArT24m2fteNAtHeaHfNmvbWrPsAkGZ1F?=
 =?us-ascii?Q?c0I6ZeDjFlMWKw0aB6nMmRgdX6h3mVrt9ecI23HgfVv3mCmmErxYUdknP5AF?=
 =?us-ascii?Q?FcYjccUrbE4eYPy/R9VUO0ts9wUyVt65SFpTZXimIF0qbmZkVDvyNsOZ+hUt?=
 =?us-ascii?Q?HmwYluTnywRAamEAc9mqDyfgAf9Wk3i/1/5+lRgR+dWMD1/l4iU7eQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:58:18.7212 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf4f225b-2709-406c-0e79-08dd42187651
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7197
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
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 38 +++++++++++++++------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 2ad217470c8c6..790b533605849 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -96,9 +96,8 @@ static int amdgpu_ih_clientid_vcns[] = {
 static int vcn_v4_0_start_sriov(struct amdgpu_device *adev);
 static void vcn_v4_0_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v4_0_set_irq_funcs(struct amdgpu_device *adev);
-static int vcn_v4_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
-					       enum amd_powergating_state state,
-					       int i);
+static int vcn_v4_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
+				 enum amd_powergating_state state);
 static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state);
 static int vcn_v4_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
@@ -138,6 +137,8 @@ static int vcn_v4_0_early_init(struct amdgpu_ip_block *ip_block)
 	vcn_v4_0_set_ras_funcs(adev);
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		adev->vcn.inst[i].set_pg_state = vcn_v4_0_set_pg_state;
+
 		r = amdgpu_vcn_early_init(adev, i);
 		if (r)
 			return r;
@@ -379,20 +380,22 @@ static int vcn_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	int i;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
+
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
-		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+		cancel_delayed_work_sync(&vinst->idle_work);
 
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-				(adev->vcn.inst[i].cur_state != AMD_PG_STATE_GATE &&
+			    (vinst->cur_state != AMD_PG_STATE_GATE &&
 				 RREG32_SOC15(VCN, i, regUVD_STATUS))) {
-				vcn_v4_0_set_powergating_state_inst(ip_block, AMD_PG_STATE_GATE, i);
+				vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
 			}
 		}
 		if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
-			amdgpu_irq_put(adev, &adev->vcn.inst[i].ras_poison_irq, 0);
+			amdgpu_irq_put(adev, &vinst->ras_poison_irq, 0);
 	}
 
 	return 0;
@@ -2077,12 +2080,10 @@ static int vcn_v4_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
-static int vcn_v4_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
-					       enum amd_powergating_state state,
-					       int i)
+static int vcn_v4_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
+				 enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = ip_block->adev;
-	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
+	struct amdgpu_device *adev = vinst->adev;
 	int ret = 0;
 
 	/* for SRIOV, guest should not control VCN Power-gating
@@ -2090,11 +2091,11 @@ static int vcn_v4_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
 	 * guest should avoid touching CGC and PG
 	 */
 	if (amdgpu_sriov_vf(adev)) {
-		adev->vcn.inst[i].cur_state = AMD_PG_STATE_UNGATE;
+		vinst->cur_state = AMD_PG_STATE_UNGATE;
 		return 0;
 	}
 
-	if (state == adev->vcn.inst[i].cur_state)
+	if (state == vinst->cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -2103,7 +2104,7 @@ static int vcn_v4_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
 		ret = vcn_v4_0_start(vinst);
 
 	if (!ret)
-		adev->vcn.inst[i].cur_state = state;
+		vinst->cur_state = state;
 
 	return ret;
 }
@@ -2122,8 +2123,11 @@ static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	struct amdgpu_device *adev = ip_block->adev;
 	int ret = 0, i;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
-		ret |= vcn_v4_0_set_powergating_state_inst(ip_block, state, i);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
+
+		ret |= vinst->set_pg_state(vinst, state);
+	}
 
 	return ret;
 }
-- 
2.48.1

