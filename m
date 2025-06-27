Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7279CC7EE2A
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 03:40:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0285910E944;
	Fri, 27 Jun 2025 03:40:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YUBk/PUh";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A49110E944
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 03:40:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LhX4H1Lzg85+zUGsxAEuHVchnqW1x0NMHTZo0fbKAR+TKm19yLglRaOwe+yfdaDmnzGiE0OQu1kI3sUDBQnOQKYTOG5zbIAwviVS4oe4zqohTPPXSyIrTonXfOckjB7NKV80bGTQUG5k7PX+UWH0g/lRngKBPshHAQs1NpXiFHjuHarPOgTe+5W/jOqtBHjf8oRHJTE2/Lab3rVc3XQ6+omvV4eNmPMpYmgGAmtUJ3LHAgwSsNyfNx5G71aa0oq5OLXN6HrMVYN096P077/XSKUppP0ES6oj/JeXs/3RfswPvOldhSwUlJ/IUev0fteEPn3a4VhBgqHK757neqsKaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3AsPlGovU2seiUeHIviEap44EdQp40oMVXT0tNjVoXM=;
 b=Ya+w6cwNiHGi6blv1DybhSBpsqP6ph8KeSbDHw0qvE9rXvqjP4COpkKhNJ9zwVBjboeZBIdfvEL7XMDJMldLJmlOAcY9Qm7cLNQdhAxG5sFqBBXoeX8XEdVkoIoo++A03K1flF5ofd5rAdoQf2a0JTEg1gvaoRSFnARV4hlxXiD/p/JNBh3Y0Ud/p7u1fCF4OsTjrqaSLVuzghreerYiRFSJu+lnA0eA5xgHEJmtS2RMRK2Wj48an0LJATcCmX7Nu03aIAYkLYAHf1a1NRzoemvcYYSkRVSpB145ImxTu4lFvZHk+DhBU5rIY0Z91fpQ5mHFqebild09qOH4CJcfUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AsPlGovU2seiUeHIviEap44EdQp40oMVXT0tNjVoXM=;
 b=YUBk/PUh065aViK+JrEqf2Is0fAyLANJBankcfkqGkaKLwszHOWXK+puF4Qo2I6Gp3uUM/hlbrmJ2gBl2WTRvazv1fPJTNPTarJzID/pcXGPEnb6RpYsfxItEqiYXyBqrgDGTTCb6NitjfD8c/vy5YMFByPRMajA0mr4BgNJJg8=
Received: from MN0PR03CA0013.namprd03.prod.outlook.com (2603:10b6:208:52f::24)
 by IA4PR12MB9786.namprd12.prod.outlook.com (2603:10b6:208:5d3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.35; Fri, 27 Jun
 2025 03:40:43 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:52f:cafe::27) by MN0PR03CA0013.outlook.office365.com
 (2603:10b6:208:52f::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.21 via Frontend Transport; Fri,
 27 Jun 2025 03:40:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 03:40:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 22:40:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 33/33] drm/amdgpu/vcn3: implement ring reset
Date: Thu, 26 Jun 2025 23:40:02 -0400
Message-ID: <20250627034002.5590-34-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250627034002.5590-1-alexander.deucher@amd.com>
References: <20250627034002.5590-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|IA4PR12MB9786:EE_
X-MS-Office365-Filtering-Correlation-Id: bf1881a3-1d17-4abb-b922-08ddb52c6517
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HdLuF5kVgcyU8eUt3Tzx6TDdZzCMF6DDTIpbcXMV+ee/vTD0X/OagafLHOOt?=
 =?us-ascii?Q?9yWeE0j0LWPwExQS78gw3t96RTtK3sDdQv29s1JNYSqANyLVkNM6ye/JWaof?=
 =?us-ascii?Q?DqzdiTJIp0IGAJVwuX2cXkTdaM+slSyeT1Gl8zP4qXq1fISTTdl2ZBhe4SE0?=
 =?us-ascii?Q?FfKEwmMMWi4db9NbWo92yxq5QnYd7FSx/R5V2URhzHB5Wv3rTL1prrZFAJcn?=
 =?us-ascii?Q?3VuGGvll20oCkPiEZQj1EgHd7c+kZpSQoIbnWVXDRO1b2fWm2VtRKbcINt3F?=
 =?us-ascii?Q?KzE1VM3sPnCcmVcG4eNFIsw9t0tWj6YYVJ5CUgIDsClXXhD+Ngi9KDvblQtZ?=
 =?us-ascii?Q?iNJlrhOoV6+P6z3yeJLnldLeyVyf4dlLsNsyd3BX5j9rEhijVHurAtjk07ec?=
 =?us-ascii?Q?U4c317C9SD0RICxkSTTN6XuuKj9NLB06QRfa0HwjFjV4CSCnYbPJQNJEvFYe?=
 =?us-ascii?Q?TEDLY1Rx/YJEUFNf1PrCer+N9/tRjQjll3OEjcShxyRFrc1RWFWgbNCppmqU?=
 =?us-ascii?Q?q4Yhpy0kwPydMLbQWhiQ0TZ2r4q7i/g1NnX1HSzv0dZKqFTPf2+TgLpS+04S?=
 =?us-ascii?Q?vN76QIJsslxu2HodB1tInTKhk043apArwFkJ9ZcYqRLB2df+nC9A7FC1c5dJ?=
 =?us-ascii?Q?EYp2E96XB2KSBi4Po/phFiqixHWMkKwoc1+rhNtjgPiiKb7rCCKDZU+7YnNG?=
 =?us-ascii?Q?Jk54VrJIzh1VGAOZHcz6VcvktCuUp5GYUOSnd+6B0tqEc/+vozqMoEM5FABg?=
 =?us-ascii?Q?yg9BeEOMXcWvzPdR85G1hxgrhCNTI2rdJuAfu3kjkTHiJR2z6oQwQlogDecm?=
 =?us-ascii?Q?wDdcqqhv2Xdn675QMp3YzancFQJpqVD0IDmP3CCrfH6jroJvQkQSIRJGNd2H?=
 =?us-ascii?Q?XtLodkAU1F1FxXG+H7OaClOiMCjZrTDNxKFefLA34OACCds5wGhuuG8RXQvZ?=
 =?us-ascii?Q?KO4TYSj7vG1gEAErxMPoHT6oPsreyFXKZj+kjneEqMj72eurXH71VJQgFUNb?=
 =?us-ascii?Q?V1pUdSWrrXPO1WpSi3U8WdAMyGxtixLekuSgrlWArXNaVFc/A8OQZc8jw5Kl?=
 =?us-ascii?Q?thILlR9Xy++qVdd4zwG/3AS+rMG175BqLn9GJ7z4osHKZo/jlNH400ufbwrr?=
 =?us-ascii?Q?WxFHhEq3eCUUDxj8vrBdIN3LQPn3nuSH8jmF2qbrYcNbwwuqcmuZ4vzwWaAv?=
 =?us-ascii?Q?ehcHFgyIBxtJVoP9HjrCnUT1rltETw+Fpb4+FPEPm8eTYmid54IX80cgEEmz?=
 =?us-ascii?Q?XBXTEbCDBPOKFPaGI5Ra1ZiIYrx7+u0wBDuHGRqZElETY7ptfTJzQR4UV+zh?=
 =?us-ascii?Q?Ellacn9FB1Ps975j2igB2DBaIsRcYTX3+Bx1GEO3aimIO9wCpVPfBdNMueGv?=
 =?us-ascii?Q?DyA19mSM340w37oTMye/J1AhV0jj7UrXiQsiZxtyeAD8uVPv6SzOF851+Z0a?=
 =?us-ascii?Q?On53XiYWiGz73TRm3yE0QTx+XPgkJ/m0pvT6EB1+982KY2OIqt42h7PTROJy?=
 =?us-ascii?Q?TowhkSlUN3LxqqnuZ7DPh+ZsbMuue8Per+QL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 03:40:43.5290 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf1881a3-1d17-4abb-b922-08ddb52c6517
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9786
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

Use the new helpers to handle engine resets for VCN.

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 9fb0d53805892..dd015bc6fd0ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -110,6 +110,7 @@ static int vcn_v3_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
 				 enum amd_powergating_state state);
 static int vcn_v3_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
 				   struct dpg_pause_state *new_state);
+static int vcn_v3_0_reset(struct amdgpu_vcn_inst *vinst);
 
 static void vcn_v3_0_dec_ring_set_wptr(struct amdgpu_ring *ring);
 static void vcn_v3_0_enc_ring_set_wptr(struct amdgpu_ring *ring);
@@ -289,6 +290,7 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
 			adev->vcn.inst[i].pause_dpg_mode = vcn_v3_0_pause_dpg_mode;
+		adev->vcn.inst[i].reset = vcn_v3_0_reset;
 	}
 
 	if (amdgpu_sriov_vf(adev)) {
@@ -2033,6 +2035,7 @@ static const struct amdgpu_ring_funcs vcn_v3_0_dec_ring_vm_funcs = {
 	.emit_wreg = vcn_v2_0_dec_ring_emit_wreg,
 	.emit_reg_wait = vcn_v2_0_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = amdgpu_vcn_ring_reset,
 };
 
 /**
@@ -2131,6 +2134,7 @@ static const struct amdgpu_ring_funcs vcn_v3_0_enc_ring_vm_funcs = {
 	.emit_wreg = vcn_v2_0_enc_ring_emit_wreg,
 	.emit_reg_wait = vcn_v2_0_enc_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = amdgpu_vcn_ring_reset,
 };
 
 static void vcn_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev)
@@ -2164,6 +2168,15 @@ static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev)
 	}
 }
 
+static int vcn_v3_0_reset(struct amdgpu_vcn_inst *vinst)
+{
+	vcn_v3_0_stop(vinst);
+	vcn_v3_0_enable_clock_gating(vinst);
+	vcn_v3_0_enable_static_power_gating(vinst);
+	vcn_v3_0_start(vinst);
+	return 0;
+}
+
 static bool vcn_v3_0_is_idle(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-- 
2.50.0

