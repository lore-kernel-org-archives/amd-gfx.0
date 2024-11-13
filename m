Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1FAED637CA
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2024 21:45:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D998010E723;
	Wed, 13 Nov 2024 21:45:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wluo9tou";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C0CA10E70A
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 21:45:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rliMiEvrOKKlQ7YCyCwpP/OctORvBCRgb+0B+BtZu59Gd8FXtNaDcXC3POmuDSkYiQgWDNskpWy+4NksCVT0npbJstviIz48v2BAt8yX8S429jEgwwJw5AHjml+iW2RS4HnCgnkAsOZs3lRrTw6vxQTTc8WvTz6rbKcqdSJqMklG02mEEQnrEzsPmmdIxMbEG7KS3KPt9plm1A2cq1UV9qwbOJymbV9fp5Qv5xTTvpNhtHRul3RyVYJ3e1CJVAB+UdJ910i4o+ThfiaUMRczMdV6dY2pDT1J7CwkCxFEcDXFe78mBKu1a2EnaScCN+TrruQyeiCe79Fbm5RFaYp8Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PURvOTvKh74vMG5q3MhkzRMrpBDWgIFBNxQAVOQBhkI=;
 b=CrITcFw9mmPCeUh8/p633ys8DCoHJLLXhd5O9ub8eCPtYLxNsrjomm0uqxFw44cEXbfz8dX6T4TcTxtz8hvjVRP/hgMBKlLgDUMQIrQXsOd0m3lwZ+t0nbEZJpkVvZnVaA86DNCg5evkIh1/ef7zCAC3qAatElEjWiUy4wzjW+WRuMZ1PKo6voizpSqn+sDurHJfylZWF3HJr9B0YuaVxD/EsI1bxki3zYtL1pJIuqS7bCOT9tS39Gjrn6rRfi7PnGLeMnw/kDSKDTPmBunSBg5fjVloMbPakZUq2XdsNQ85NsOoLgJuM6PmExWy6vbY19IEYiwhmXps6V5QSGaC0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PURvOTvKh74vMG5q3MhkzRMrpBDWgIFBNxQAVOQBhkI=;
 b=wluo9touT5mPniIrHX/yfGsx0AEzKoHuVTFI14YyqW0IxcEoGnZrAEcYaGz/Z4zispWb92dYEEL1X6hjebkrzOvwbtFBFEAlJo1/gSIwJlw87SrDzOdlVoBhdlOuSH3+yTfgZfqh/Q30oMaM8gu0LDueYmn9FA7Bhm01e8qumGU=
Received: from SJ0PR05CA0162.namprd05.prod.outlook.com (2603:10b6:a03:339::17)
 by BY5PR12MB4162.namprd12.prod.outlook.com (2603:10b6:a03:201::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Wed, 13 Nov
 2024 21:45:18 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::18) by SJ0PR05CA0162.outlook.office365.com
 (2603:10b6:a03:339::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17 via Frontend
 Transport; Wed, 13 Nov 2024 21:45:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 21:45:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 15:45:12 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 12/15] drm/amdgpu/vcn: make powergating status per instance
Date: Wed, 13 Nov 2024 16:44:48 -0500
Message-ID: <20241113214453.17081-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113214453.17081-1-alexander.deucher@amd.com>
References: <20241113214453.17081-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|BY5PR12MB4162:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d3e6743-119f-46c6-dba3-08dd042c773f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?li52AX0/KDpnxOtYnIaY2eqNpQqdsSFQinmqAJnaMqKEnQ7SsLkVGrol9Myn?=
 =?us-ascii?Q?h9D/fdN4jaEdiLBFdimq2nqAoDJJCO0aIniyCYlkJXR4BC/0G99r8l/zGEjD?=
 =?us-ascii?Q?yUgdM22i8yR2j/p1XBcEpzlzHFn5KQwWSRNnW1HqyMWcO6kYnAGcBxwM8uih?=
 =?us-ascii?Q?yjszL0hcnEdqgwYjMUxeTwBwZ4JPafsbYjumDNTuhctFv0Jf4/xJRHr2yqNt?=
 =?us-ascii?Q?p1rN/okNjMBy+B5vp1+4yiQIYfWVS6N8D2ur8tNgoVqalUFITmnGg/oxmosS?=
 =?us-ascii?Q?dGWDSNamjEKnzMICj49z0Rl4C2D3bqKj4uyhnZRneBssRkql8M4QV8NqHXE7?=
 =?us-ascii?Q?0Duyj0nQkTA/mLU0s12xiwVXmGcGn9Yn37c2YIIX/i+60wHWRY0UA5NXkyMC?=
 =?us-ascii?Q?+5Kf5/eHTjXHg1Mpq5qvb07whk5MK2s0wuSHHU+ykqAZdmNrv9Rc+8Izf3+b?=
 =?us-ascii?Q?b+UEjNgrcKXLPGSai2dRAfkI9iLZBwYjqTpTetHUzS7vUNrLw7YblvCTwZUP?=
 =?us-ascii?Q?F21OWWEc6S1np8cK4OPtYZ2CJ8NBnx+h+fR7GQue4nHgDk0n8lG5nxg4oWiL?=
 =?us-ascii?Q?hoxlvFtxTObYcooeT3vUvb+swgN2r3Xf0s+uNYWinArsJcreY1sBk0431KxK?=
 =?us-ascii?Q?cYCF8kHHXA1Q6fl2m2YZQwrjp+qa3UvUSqVkjOccWQQSIXeszXhk1yLuFKk3?=
 =?us-ascii?Q?MoAW467i9ne7NgBYNE8IZQWtR87dym+5urun0QSh25iHay/JlufY4EZF2Dtl?=
 =?us-ascii?Q?nQog/Y7GGA5B2+3XTIIIRpm6o4dPA0HXhmw0cyG5idZUtJ6F7UuundiqFlLU?=
 =?us-ascii?Q?hhp8AWrdzzo6Eb7Ngp9y4OnwFNqGe62AKgG2vRxZDEIcUOcevL3QfPV4UP/B?=
 =?us-ascii?Q?D4PdT6YvJZ9W8YQ4SuWcntk7DWv0XkquzBNPiRy9O6GjAhytA2uR6V7F1aBE?=
 =?us-ascii?Q?ydebHkIi478t5/bRJ+0ymnoatTNCQ5i34V2KNg1bkR08m+xmOfydCmHwo2DS?=
 =?us-ascii?Q?H5JXGcJPV2QXUiTgBpX7PTXHyBID1KX4ukVX6TVB1DcFYZbx7fEpAhSzWbUJ?=
 =?us-ascii?Q?9MCA1sp/683E8IkfPrpJy11IJefIImEcFy7Pao8/2BS9MBjDE1wNSm0ELUUF?=
 =?us-ascii?Q?uYJfRWRZxXae0h3urVI35TUYgb0vHgzgt/RI0+mdyBkGV8AJrM2BvEyBHISb?=
 =?us-ascii?Q?soFyoLRvaJSStZ8J+Jt5V0Yka73xG6apFnhZ6qUAFPdJcxs8bblomKSMp6N1?=
 =?us-ascii?Q?nPsrYA/IK2QFSLvXORO288KwS8rJYpv1/Znjxo9o5PKJ44cvdM4zDEn1BOK/?=
 =?us-ascii?Q?puHO+TYxwDNXzXGRz27MtsihxIgyGO7uHCB9lDvuIc+wtRVD+b+o/FGgXJlC?=
 =?us-ascii?Q?DhbDpHpvrX35UONyX8nHn1iMdKfRDSbLV0hp4hmRPxFvksTU0w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 21:45:17.8630 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3e6743-119f-46c6-dba3-08dd042c773f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4162
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

Store it per instance so we can track it per instance.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h   |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c     |  6 +--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c     | 11 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c     | 43 +++++++++++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c     | 49 ++++++++++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c     | 60 ++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c   | 63 ++++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c   | 48 +++++++++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c   | 48 +++++++++++------
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c |  8 +--
 10 files changed, 214 insertions(+), 124 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 0d9a4d946eac..dc3c7b7bdd33 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -304,6 +304,7 @@ struct amdgpu_vcn_inst {
 	uint32_t		vcn_codec_disable_mask;
 	atomic_t		total_submission_cnt;
 	struct mutex		vcn_pg_lock;
+	enum amd_powergating_state cur_state;
 	struct delayed_work	idle_work;
 };
 
@@ -314,7 +315,6 @@ struct amdgpu_vcn_ras {
 struct amdgpu_vcn {
 	unsigned		fw_version;
 	unsigned		num_enc_rings;
-	enum amd_powergating_state cur_state;
 	bool			indirect_sram;
 
 	uint8_t	num_vcn_inst;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 9ca964e11540..406886f13566 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -280,7 +280,7 @@ static int vcn_v1_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	cancel_delayed_work_sync(&adev->vcn.inst->idle_work);
 
 	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-		(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
+		(adev->vcn.inst->cur_state != AMD_PG_STATE_GATE &&
 		 RREG32_SOC15(VCN, 0, mmUVD_STATUS))) {
 		vcn_v1_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 	}
@@ -1813,7 +1813,7 @@ static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	int ret;
 	struct amdgpu_device *adev = ip_block->adev;
 
-	if (state == adev->vcn.cur_state)
+	if (state == adev->vcn.inst->cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -1822,7 +1822,7 @@ static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		ret = vcn_v1_0_start(adev);
 
 	if (!ret)
-		adev->vcn.cur_state = state;
+		adev->vcn.inst->cur_state = state;
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 115f33c3ab68..f445ae401359 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -316,8 +316,8 @@ static int vcn_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	cancel_delayed_work_sync(&adev->vcn.inst->idle_work);
 
 	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-	    (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
-	      RREG32_SOC15(VCN, 0, mmUVD_STATUS)))
+	    (adev->vcn.inst->cur_state != AMD_PG_STATE_GATE &&
+	     RREG32_SOC15(VCN, 0, mmUVD_STATUS)))
 		vcn_v2_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 
 	return 0;
@@ -1810,11 +1810,11 @@ static int vcn_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	struct amdgpu_device *adev = ip_block->adev;
 
 	if (amdgpu_sriov_vf(adev)) {
-		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
+		adev->vcn.inst->cur_state = AMD_PG_STATE_UNGATE;
 		return 0;
 	}
 
-	if (state == adev->vcn.cur_state)
+	if (state == adev->vcn.inst->cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -1823,7 +1823,8 @@ static int vcn_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		ret = vcn_v2_0_start(adev);
 
 	if (!ret)
-		adev->vcn.cur_state = state;
+		adev->vcn.inst->cur_state = state;
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 6fb08ed09310..1d3780a2d851 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -95,8 +95,11 @@ static const struct amdgpu_hwip_reg_entry vcn_reg_list_2_5[] = {
 static void vcn_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v2_5_set_enc_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v2_5_set_irq_funcs(struct amdgpu_device *adev);
+static int vcn_v2_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+					       enum amd_powergating_state state,
+					       int i);
 static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
-				enum amd_powergating_state state);
+					  enum amd_powergating_state state);
 static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
 				int inst_idx, struct dpg_pause_state *new_state);
 static int vcn_v2_5_sriov_start(struct amdgpu_device *adev);
@@ -397,9 +400,9 @@ static int vcn_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
 		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
 
 		if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-		    (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
+		    (adev->vcn.inst[i].cur_state != AMD_PG_STATE_GATE &&
 		     RREG32_SOC15(VCN, i, mmUVD_STATUS)))
-			vcn_v2_5_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
+			vcn_v2_5_set_powergating_state_inst(ip_block, AMD_PG_STATE_GATE, i);
 
 		if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
 			amdgpu_irq_put(adev, &adev->vcn.inst[i].ras_poison_irq, 0);
@@ -1805,27 +1808,39 @@ static int vcn_v2_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
-static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
-					  enum amd_powergating_state state)
+static int vcn_v2_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+					       enum amd_powergating_state state,
+					       int i)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int ret = 0, i;
+	int ret;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	if (state == adev->vcn.cur_state)
+	if (state == adev->vcn.inst[i].cur_state)
 		return 0;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (state == AMD_PG_STATE_GATE)
-			ret |= vcn_v2_5_stop(adev, i);
-		else
-			ret |= vcn_v2_5_start(adev, i);
-	}
+	if (state == AMD_PG_STATE_GATE)
+		ret = vcn_v2_5_stop(adev, i);
+	else
+		ret = vcn_v2_5_start(adev, i);
 
 	if (!ret)
-		adev->vcn.cur_state = state;
+		adev->vcn.inst[i].cur_state = state;
+
+	return ret;
+}
+
+static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
+					  enum amd_powergating_state state)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int ret = 0, i;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+		ret |= vcn_v2_5_set_powergating_state_inst(ip_block,
+							   state, i);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 70a1b85a4efa..13b9ed96cccd 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -105,8 +105,11 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev);
 static void vcn_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v3_0_set_irq_funcs(struct amdgpu_device *adev);
+static int vcn_v3_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+					       enum amd_powergating_state state,
+					       int i);
 static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
-			enum amd_powergating_state state);
+					  enum amd_powergating_state state);
 static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
 			int inst_idx, struct dpg_pause_state *new_state);
 
@@ -430,9 +433,11 @@ static int vcn_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
 
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
-				 RREG32_SOC15(VCN, i, mmUVD_STATUS))) {
-				vcn_v3_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
+			    (adev->vcn.inst[i].cur_state != AMD_PG_STATE_GATE &&
+			     RREG32_SOC15(VCN, i, mmUVD_STATUS))) {
+				vcn_v3_0_set_powergating_state_inst(ip_block,
+								    AMD_PG_STATE_GATE,
+								    i);
 			}
 		}
 	}
@@ -2147,33 +2152,45 @@ static int vcn_v3_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
-static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
-					  enum amd_powergating_state state)
+static int vcn_v3_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+					       enum amd_powergating_state state,
+					       int i)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int ret = 0, i;
+	int ret = 0;
 
 	/* for SRIOV, guest should not control VCN Power-gating
 	 * MMSCH FW should control Power-gating and clock-gating
 	 * guest should avoid touching CGC and PG
 	 */
 	if (amdgpu_sriov_vf(adev)) {
-		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
+		adev->vcn.inst[i].cur_state = AMD_PG_STATE_UNGATE;
 		return 0;
 	}
 
-	if (state == adev->vcn.cur_state)
+	if (state == adev->vcn.inst[i].cur_state)
 		return 0;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (state == AMD_PG_STATE_GATE)
-			ret |= vcn_v3_0_stop(adev, i);
-		else
-			ret |= vcn_v3_0_start(adev, i);
-	}
+	if (state == AMD_PG_STATE_GATE)
+		ret = vcn_v3_0_stop(adev, i);
+	else
+		ret = vcn_v3_0_start(adev, i);
 
 	if (!ret)
-		adev->vcn.cur_state = state;
+		adev->vcn.inst[i].cur_state = state;
+
+	return ret;
+}
+
+static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
+					  enum amd_powergating_state state)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int ret = 0, i;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+		ret |= vcn_v3_0_set_powergating_state_inst(ip_block,
+							   state, i);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 656c2a1c4bf9..9b7fc7ee4188 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -96,8 +96,11 @@ static int amdgpu_ih_clientid_vcns[] = {
 static int vcn_v4_0_start_sriov(struct amdgpu_device *adev);
 static void vcn_v4_0_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v4_0_set_irq_funcs(struct amdgpu_device *adev);
+static int vcn_v4_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+					       enum amd_powergating_state state,
+					       int i);
 static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
-        enum amd_powergating_state state);
+					  enum amd_powergating_state state);
 static int vcn_v4_0_pause_dpg_mode(struct amdgpu_device *adev,
         int inst_idx, struct dpg_pause_state *new_state);
 static void vcn_v4_0_unified_ring_set_wptr(struct amdgpu_ring *ring);
@@ -367,9 +370,9 @@ static int vcn_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
 
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
+				(adev->vcn.inst[i].cur_state != AMD_PG_STATE_GATE &&
 				 RREG32_SOC15(VCN, i, regUVD_STATUS))) {
-				vcn_v4_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
+				vcn_v4_0_set_powergating_state_inst(ip_block, AMD_PG_STATE_GATE, i);
 			}
 		}
 		if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
@@ -2039,41 +2042,52 @@ static int vcn_v4_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
-/**
- * vcn_v4_0_set_powergating_state - set VCN block powergating state
- *
- * @handle: amdgpu_device pointer
- * @state: power gating state
- *
- * Set VCN block powergating state
- */
-static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
-					  enum amd_powergating_state state)
+static int vcn_v4_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+					       enum amd_powergating_state state,
+					       int i)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int ret = 0, i;
+	int ret = 0;
 
 	/* for SRIOV, guest should not control VCN Power-gating
 	 * MMSCH FW should control Power-gating and clock-gating
 	 * guest should avoid touching CGC and PG
 	 */
 	if (amdgpu_sriov_vf(adev)) {
-		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
+		adev->vcn.inst[i].cur_state = AMD_PG_STATE_UNGATE;
 		return 0;
 	}
 
-	if (state == adev->vcn.cur_state)
+	if (state == adev->vcn.inst[i].cur_state)
 		return 0;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (state == AMD_PG_STATE_GATE)
-			ret |= vcn_v4_0_stop(adev, i);
-		else
-			ret |= vcn_v4_0_start(adev, i);
-	}
+	if (state == AMD_PG_STATE_GATE)
+		ret = vcn_v4_0_stop(adev, i);
+	else
+		ret = vcn_v4_0_start(adev, i);
 
 	if (!ret)
-		adev->vcn.cur_state = state;
+		adev->vcn.inst[i].cur_state = state;
+
+	return ret;
+}
+
+/**
+ * vcn_v4_0_set_powergating_state - set VCN block powergating state
+ *
+ * @handle: amdgpu_device pointer
+ * @state: power gating state
+ *
+ * Set VCN block powergating state
+ */
+static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
+					  enum amd_powergating_state state)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int ret = 0, i;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+		ret |= vcn_v4_0_set_powergating_state_inst(ip_block, state, i);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 8eea78c498da..60b6cece499a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -87,8 +87,11 @@ static const struct amdgpu_hwip_reg_entry vcn_reg_list_4_0_3[] = {
 static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev);
 static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev);
+static int vcn_v4_0_3_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+						 enum amd_powergating_state state,
+						 int i);
 static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
-		enum amd_powergating_state state);
+					    enum amd_powergating_state state);
 static int vcn_v4_0_3_pause_dpg_mode(struct amdgpu_device *adev,
 		int inst_idx, struct dpg_pause_state *new_state);
 static void vcn_v4_0_3_unified_ring_set_wptr(struct amdgpu_ring *ring);
@@ -333,11 +336,12 @@ static int vcn_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int i;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
 
-	if (adev->vcn.cur_state != AMD_PG_STATE_GATE)
-		vcn_v4_0_3_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
+		if (adev->vcn.inst[i].cur_state != AMD_PG_STATE_GATE)
+			vcn_v4_0_3_set_powergating_state_inst(ip_block, AMD_PG_STATE_GATE, i);
+	}
 
 	return 0;
 }
@@ -1633,41 +1637,52 @@ static int vcn_v4_0_3_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
-/**
- * vcn_v4_0_3_set_powergating_state - set VCN block powergating state
- *
- * @handle: amdgpu_device pointer
- * @state: power gating state
- *
- * Set VCN block powergating state
- */
-static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
-					  enum amd_powergating_state state)
+static int vcn_v4_0_3_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+						 enum amd_powergating_state state,
+						 int i)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int ret = 0, i;
+	int ret = 0;
 
 	/* for SRIOV, guest should not control VCN Power-gating
 	 * MMSCH FW should control Power-gating and clock-gating
 	 * guest should avoid touching CGC and PG
 	 */
 	if (amdgpu_sriov_vf(adev)) {
-		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
+		adev->vcn.inst[i].cur_state = AMD_PG_STATE_UNGATE;
 		return 0;
 	}
 
-	if (state == adev->vcn.cur_state)
+	if (state == adev->vcn.inst[i].cur_state)
 		return 0;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (state == AMD_PG_STATE_GATE)
-			ret |= vcn_v4_0_3_stop(adev, i);
-		else
-			ret |= vcn_v4_0_3_start(adev, i);
-	}
+	if (state == AMD_PG_STATE_GATE)
+		ret = vcn_v4_0_3_stop(adev, i);
+	else
+		ret = vcn_v4_0_3_start(adev, i);
 
 	if (!ret)
-		adev->vcn.cur_state = state;
+		adev->vcn.inst[i].cur_state = state;
+
+	return ret;
+}
+
+/**
+ * vcn_v4_0_3_set_powergating_state - set VCN block powergating state
+ *
+ * @handle: amdgpu_device pointer
+ * @state: power gating state
+ *
+ * Set VCN block powergating state
+ */
+static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
+					    enum amd_powergating_state state)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int ret = 0, i;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+		vcn_v4_0_3_set_powergating_state_inst(ip_block, state, i);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 7086f98c2ddc..422f90c3d2b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -95,8 +95,11 @@ static int amdgpu_ih_clientid_vcns[] = {
 
 static void vcn_v4_0_5_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v4_0_5_set_irq_funcs(struct amdgpu_device *adev);
+static int vcn_v4_0_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+						 enum amd_powergating_state state,
+						 int i);
 static int vcn_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
-		enum amd_powergating_state state);
+					    enum amd_powergating_state state);
 static int vcn_v4_0_5_pause_dpg_mode(struct amdgpu_device *adev,
 		int inst_idx, struct dpg_pause_state *new_state);
 static void vcn_v4_0_5_unified_ring_set_wptr(struct amdgpu_ring *ring);
@@ -308,9 +311,9 @@ static int vcn_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
 
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
-				RREG32_SOC15(VCN, i, regUVD_STATUS))) {
-				vcn_v4_0_5_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
+			    (adev->vcn.inst[i].cur_state != AMD_PG_STATE_GATE &&
+			     RREG32_SOC15(VCN, i, regUVD_STATUS))) {
+				vcn_v4_0_5_set_powergating_state_inst(ip_block, AMD_PG_STATE_GATE, i);
 			}
 		}
 	}
@@ -1517,6 +1520,27 @@ static int vcn_v4_0_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
+static int vcn_v4_0_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+						 enum amd_powergating_state state,
+						 int i)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int ret = 0;
+
+	if (state == adev->vcn.inst[i].cur_state)
+		return 0;
+
+	if (state == AMD_PG_STATE_GATE)
+		ret = vcn_v4_0_5_stop(adev, i);
+	else
+		ret = vcn_v4_0_5_start(adev, i);
+
+	if (!ret)
+		adev->vcn.inst[i].cur_state = state;
+
+	return ret;
+}
+
 /**
  * vcn_v4_0_5_set_powergating_state - set VCN block powergating state
  *
@@ -1526,23 +1550,13 @@ static int vcn_v4_0_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
  * Set VCN block powergating state
  */
 static int vcn_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
-		enum amd_powergating_state state)
+					    enum amd_powergating_state state)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	int ret = 0, i;
 
-	if (state == adev->vcn.cur_state)
-		return 0;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (state == AMD_PG_STATE_GATE)
-			ret |= vcn_v4_0_5_stop(adev, i);
-		else
-			ret |= vcn_v4_0_5_start(adev, i);
-	}
-
-	if (!ret)
-		adev->vcn.cur_state = state;
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+		vcn_v4_0_5_set_powergating_state_inst(ip_block, state, i);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 4c641813aeff..8c953cd1f95a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -78,8 +78,11 @@ static int amdgpu_ih_clientid_vcns[] = {
 
 static void vcn_v5_0_0_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v5_0_0_set_irq_funcs(struct amdgpu_device *adev);
+static int vcn_v5_0_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+						 enum amd_powergating_state state,
+						 int i);
 static int vcn_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
-		enum amd_powergating_state state);
+					    enum amd_powergating_state state);
 static int vcn_v5_0_0_pause_dpg_mode(struct amdgpu_device *adev,
 		int inst_idx, struct dpg_pause_state *new_state);
 static void vcn_v5_0_0_unified_ring_set_wptr(struct amdgpu_ring *ring);
@@ -282,9 +285,9 @@ static int vcn_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
 
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
-				RREG32_SOC15(VCN, i, regUVD_STATUS))) {
-				vcn_v5_0_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
+			    (adev->vcn.inst[i].cur_state != AMD_PG_STATE_GATE &&
+			     RREG32_SOC15(VCN, i, regUVD_STATUS))) {
+				vcn_v5_0_0_set_powergating_state_inst(ip_block, AMD_PG_STATE_GATE, i);
 			}
 		}
 	}
@@ -1254,6 +1257,27 @@ static int vcn_v5_0_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
+static int vcn_v5_0_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+						 enum amd_powergating_state state,
+						 int i)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int ret = 0;
+
+	if (state == adev->vcn.inst[i].cur_state)
+		return 0;
+
+	if (state == AMD_PG_STATE_GATE)
+		ret = vcn_v5_0_0_stop(adev, i);
+	else
+		ret = vcn_v5_0_0_start(adev, i);
+
+	if (!ret)
+		adev->vcn.inst[i].cur_state = state;
+
+	return ret;
+}
+
 /**
  * vcn_v5_0_0_set_powergating_state - set VCN block powergating state
  *
@@ -1263,23 +1287,13 @@ static int vcn_v5_0_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
  * Set VCN block powergating state
  */
 static int vcn_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
-		enum amd_powergating_state state)
+					    enum amd_powergating_state state)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	int ret = 0, i;
 
-	if (state == adev->vcn.cur_state)
-		return 0;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (state == AMD_PG_STATE_GATE)
-			ret |= vcn_v5_0_0_stop(adev, i);
-		else
-			ret |= vcn_v5_0_0_start(adev, i);
-	}
-
-	if (!ret)
-		adev->vcn.cur_state = state;
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+		vcn_v5_0_0_set_powergating_state_inst(ip_block, state, i);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 2a9f041cf46d..abbd751926bb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2031,15 +2031,15 @@ static int smu_hw_fini(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
 		return 0;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
+	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
 		smu_dpm_set_vcn_enable(smu, false, i);
+		adev->vcn.inst[i].cur_state = AMD_PG_STATE_GATE;
+	}
 	smu_dpm_set_jpeg_enable(smu, false);
+	adev->jpeg.cur_state = AMD_PG_STATE_GATE;
 	smu_dpm_set_vpe_enable(smu, false);
 	smu_dpm_set_umsch_mm_enable(smu, false);
 
-	adev->vcn.cur_state = AMD_PG_STATE_GATE;
-	adev->jpeg.cur_state = AMD_PG_STATE_GATE;
-
 	if (!smu->pm_enabled)
 		return 0;
 
-- 
2.47.0

