Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 454E6D116E1
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2024 02:36:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E761810E9EF;
	Fri, 25 Oct 2024 02:36:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JF53pkre";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7454B10E9ED
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Oct 2024 02:36:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xp1dheOULsSK7E9bSSz7+R30fLfr3DPdZn3wcsqVSSt4Ew10Qr+jfx1DIZhrMQAiOPKjo6YUrPuFHXKo8e3gPWZczK43Xf//RsxMm2pasA/ipV+a32vCndvB4Av6eV7GPr0D2ybmfkKizDM8sbL2KZCWNwmjNTLZeVer4PNno8XNrd/r84NICtwt5FGQQRpWqmY8O52rRmQ48C4m881xQDfldociw2FWphkxceQyR1ZKtEHfQSNNJs2s4WHEssRJ2RgvRCzGBckwJk4CNWXKUvhv+kdMm4SZIYcRorOZegCaoHhFUU5zEdA2S/gE4FERRvy7KjnWBCV0iGyf+o/IrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jr7SQZfiQqAdAVJ6RU0Mz0nzU4/vzPA+ANGqD7emYb8=;
 b=ibsFUpoyJpy9K8wNtjkuomWk0g7n7h6Nc4WmV7BRZNb8Wgys2Y8OrAVvrYcTsEkKXkfGUB2Qqa9VGJln3dUjqOr9ztnrYDrTtsw4U7GGED0X1UXYdVfrJ8xCQ9ByTrdt/wknKrUV8Gmq7+pIJs5euM39Vu4W+3EFqgglpuUuC+JC4TRan1qVTL9XAYGYPvJ+sY8sucGV8KcZj0BvHDbuAQT0wvH6grICsLs5dsG2sLgruPDtC5HBBnjryOmUxuklv2Ouqc0mu8Vm/JIhJDxWvZPUECw+Xw5By1tKRttFmX+Wswnd4GmCSgMHyh4QkIxDBUXYIJ/IwzyvATca8XsZYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jr7SQZfiQqAdAVJ6RU0Mz0nzU4/vzPA+ANGqD7emYb8=;
 b=JF53pkrebmfoentpSatoCdd6ptbBdoEsQTaho9Z5QlfilOCDMvoJxDpIYIdxMEhqbnEyIPTy9j4Lr4j5/RU3RvKl3DhGdBItqx9mTzfzfVgp07pM8qGzoI0qYqhcdl0JIYgcyyWHphPPEeODJgVW10BnY3/KWLXp2S1tHaul/BE=
Received: from DM6PR18CA0012.namprd18.prod.outlook.com (2603:10b6:5:15b::25)
 by CH0PR12MB8549.namprd12.prod.outlook.com (2603:10b6:610:182::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 02:36:28 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:5:15b:cafe::8) by DM6PR18CA0012.outlook.office365.com
 (2603:10b6:5:15b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
 Transport; Fri, 25 Oct 2024 02:36:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 02:36:27 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Oct
 2024 21:36:23 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 29/29] drm/amdgpu: set_powergating for each vcn instance
Date: Thu, 24 Oct 2024 22:35:45 -0400
Message-ID: <20241025023545.465886-30-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025023545.465886-1-boyuan.zhang@amd.com>
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|CH0PR12MB8549:EE_
X-MS-Office365-Filtering-Correlation-Id: 88d129cd-275d-4409-6245-08dcf49dd3d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SWZrOWMxV3VXZlBsNGh5aThyNCtkYmxFSUVxUlpDdHhSSFM1KzZiNEpIRkMx?=
 =?utf-8?B?VjZXc2lEd0dOaUlEbDhjaFZURW9FdTNlUnlMYXVwQWNTaVBISnFmRHIvTFJW?=
 =?utf-8?B?cHF0SlQ0WFVpOVZ6U1paQjRMNWVweE5UQVRnckYxcHI3bGRpbHhaY0NHWkU4?=
 =?utf-8?B?NmgwSlFweHlFazVhN2ZIMUsxTVBZdjZpaWxUdkVCYTNNN3dzNjhhU1RBeXhl?=
 =?utf-8?B?TG9iNk9IQWd3TjlFZ1piRS9lU3ZMZFpnSFFRK2hNc2c5UHNBc3BrOVpQdEtZ?=
 =?utf-8?B?QitLSzUxMkRpVG1adXRCcEYyWW5FOG1sc29FNUZFOVlyMW9BZ1VBZTN5dE5G?=
 =?utf-8?B?TXdudkpGcXlZWG1ncHVVUDRvcWRIcy9wMUp1a0xMYkdBd2NzcExrdFJ2aURF?=
 =?utf-8?B?TURhM1U3YjVGTjdNTkt5SmV5aUoySURwL1pUMi92alhCOS9vWDVmY3p4c2tE?=
 =?utf-8?B?UGwzOHR3R2VQYUN2REFDTE10ZkloSDRtWkt4dStGK2xrK3RuZ2JUYnE1YkJx?=
 =?utf-8?B?eW5ObzZNMDh6MHRUWmdBSXpTc2paaU1udzYwTHZVZW8xd21Fb3BqTzFxZEN2?=
 =?utf-8?B?cElJZkRFRlV5cWthSU9oU2NSczMrK0YzQ0VwVi9rSGpGSWFRUm5NSmtnU3N5?=
 =?utf-8?B?cjRoazdKcFhtTGpnVnVHNG01dnMyZUZzWE1MdnJRVE0vSUpMcVNWalB5THJT?=
 =?utf-8?B?T3ZKMHlIY0tNU29TSHlIWnRWZ1hRRnZQVnhMS1NwS1NJTks1eStsbmFna3g2?=
 =?utf-8?B?V05aakNXNDJUMjE3bitmMHZrb1dCb2VWZHFvN3lsVjBvSkg3b3pzVzNxbFE2?=
 =?utf-8?B?UTNWSFMwT1JqOWh6dCt0bWFlSy80blhNeHV4MzRBSFBxSjlUbGp5ZlRnM2h6?=
 =?utf-8?B?WStjdGVSN1ZDbm1hdE8zSTFLWmxMRFMwSDAxRnhjL0FEYi9PU2NqYkdpTmlo?=
 =?utf-8?B?YXhnNnJDYzZqRE5ySFFuM0JYREQxSzllcTBrTitHc3plck5jNE0vWmxLRTM0?=
 =?utf-8?B?VmVOUWFHelJNS1JyR2VDaTAzL3U0N2s0VjRZb1hxUXo5L2VrbjM4SGphVWdQ?=
 =?utf-8?B?NFg4aWs0RXA1QTczYkR3dmk0TnA5ZEJXVlNTUC8xYVJPWTVNQzltOTFkeFRK?=
 =?utf-8?B?aDB4cHFyN1JYWEs0Y2IvZjNvSjFRN0lBWWNjNjJCYWU2U1hFT1ZXVzF3bGxF?=
 =?utf-8?B?UEVkUlBWcjJ1U01IeUlhWEt0Um53UEhITVBvUHJFdVozZE4wbVNRcFp6QThy?=
 =?utf-8?B?SEpIN1A3RDlxM1pjRnRNY3BzZ1lwdVg1M1F2N2dxdHlORVNnbVBhNnhHWU9Z?=
 =?utf-8?B?MDdjRGgyeTBXYUs3YkEyZjZRUEtKbEs2bmh0RXp0ZW16RkJ0c0pKYzA4aTVP?=
 =?utf-8?B?SU5TKzVwT3d4aGFBSVJLL0JSVjkzNGN4VGtBZHJmMWtYYnduSjBBR3ZWTkQw?=
 =?utf-8?B?NFhSVzgyZFRCSHVMVkZJOExNTnVyY3JHTmdjaG5JcTFnNTBwMnQ0WTU5UjVD?=
 =?utf-8?B?a1hnbm1oVGR1SHVndXV5UnQ1SmczWmpvWjVUVUtVQjI0dVhZYTExSTVraHRD?=
 =?utf-8?B?NGw2SlZPOExPYnhKcGd1R3pSMG56Z0d6OGpwNUYxUUF2bE16ZGRzckhJRk1j?=
 =?utf-8?B?UzZEaG5LRVY4NjBRUDE3MTJ4eU9RRE4xYnl0UUNCQ084VlpyR2FzYW1FOC9i?=
 =?utf-8?B?U2M1a3A0Z3ozZ282Yk01bXFFL2hvZVpNQ284T2tZbE1KcmJHZ0VvK21HbXAy?=
 =?utf-8?B?WEd4cGxDRXJmTWVEWkZXYSs3VDF6NHIxR3kvbmw5cHFCbHhwcjVZZFdjYmpi?=
 =?utf-8?B?QlZKck5VMEVRSWM3SHdnS01XaU1mVkFaOGkxcFRTb3ZFU3JyenRJYVFnZUta?=
 =?utf-8?B?YUU2L254TUhiNjVVdi9KZlgwWFp3VVJGaTZFMEswZklBbnc9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 02:36:27.8650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d129cd-275d-4409-6245-08dcf49dd3d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8549
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Perform set_powergating_state only for the instance of the current vcn
IP block, instead of perform it for all vcn instances.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 313 ++++++++++++------------
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  20 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  20 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  19 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c |  20 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c |  20 +-
 6 files changed, 199 insertions(+), 213 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 34d94b09f04c..da3d55cc3ac1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -612,114 +612,111 @@ static void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx
  *
  * Disable clock gating for VCN block
  */
-static void vcn_v2_5_disable_clock_gating(struct amdgpu_device *adev)
+static void vcn_v2_5_disable_clock_gating(struct amdgpu_device *adev, int inst)
 {
 	uint32_t data;
-	int i;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-		/* UVD disable CGC */
-		data = RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
-		if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
-			data |= 1 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
-		else
-			data &= ~UVD_CGC_CTRL__DYN_CLOCK_MODE_MASK;
-		data |= 1 << UVD_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
-		data |= 4 << UVD_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
-		WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
-
-		data = RREG32_SOC15(VCN, i, mmUVD_CGC_GATE);
-		data &= ~(UVD_CGC_GATE__SYS_MASK
-			| UVD_CGC_GATE__UDEC_MASK
-			| UVD_CGC_GATE__MPEG2_MASK
-			| UVD_CGC_GATE__REGS_MASK
-			| UVD_CGC_GATE__RBC_MASK
-			| UVD_CGC_GATE__LMI_MC_MASK
-			| UVD_CGC_GATE__LMI_UMC_MASK
-			| UVD_CGC_GATE__IDCT_MASK
-			| UVD_CGC_GATE__MPRD_MASK
-			| UVD_CGC_GATE__MPC_MASK
-			| UVD_CGC_GATE__LBSI_MASK
-			| UVD_CGC_GATE__LRBBM_MASK
-			| UVD_CGC_GATE__UDEC_RE_MASK
-			| UVD_CGC_GATE__UDEC_CM_MASK
-			| UVD_CGC_GATE__UDEC_IT_MASK
-			| UVD_CGC_GATE__UDEC_DB_MASK
-			| UVD_CGC_GATE__UDEC_MP_MASK
-			| UVD_CGC_GATE__WCB_MASK
-			| UVD_CGC_GATE__VCPU_MASK
-			| UVD_CGC_GATE__MMSCH_MASK);
-
-		WREG32_SOC15(VCN, i, mmUVD_CGC_GATE, data);
-
-		SOC15_WAIT_ON_RREG(VCN, i, mmUVD_CGC_GATE, 0,  0xFFFFFFFF);
-
-		data = RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
-		data &= ~(UVD_CGC_CTRL__UDEC_RE_MODE_MASK
-			| UVD_CGC_CTRL__UDEC_CM_MODE_MASK
-			| UVD_CGC_CTRL__UDEC_IT_MODE_MASK
-			| UVD_CGC_CTRL__UDEC_DB_MODE_MASK
-			| UVD_CGC_CTRL__UDEC_MP_MODE_MASK
-			| UVD_CGC_CTRL__SYS_MODE_MASK
-			| UVD_CGC_CTRL__UDEC_MODE_MASK
-			| UVD_CGC_CTRL__MPEG2_MODE_MASK
-			| UVD_CGC_CTRL__REGS_MODE_MASK
-			| UVD_CGC_CTRL__RBC_MODE_MASK
-			| UVD_CGC_CTRL__LMI_MC_MODE_MASK
-			| UVD_CGC_CTRL__LMI_UMC_MODE_MASK
-			| UVD_CGC_CTRL__IDCT_MODE_MASK
-			| UVD_CGC_CTRL__MPRD_MODE_MASK
-			| UVD_CGC_CTRL__MPC_MODE_MASK
-			| UVD_CGC_CTRL__LBSI_MODE_MASK
-			| UVD_CGC_CTRL__LRBBM_MODE_MASK
-			| UVD_CGC_CTRL__WCB_MODE_MASK
-			| UVD_CGC_CTRL__VCPU_MODE_MASK
-			| UVD_CGC_CTRL__MMSCH_MODE_MASK);
-		WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
-
-		/* turn on */
-		data = RREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_GATE);
-		data |= (UVD_SUVD_CGC_GATE__SRE_MASK
-			| UVD_SUVD_CGC_GATE__SIT_MASK
-			| UVD_SUVD_CGC_GATE__SMP_MASK
-			| UVD_SUVD_CGC_GATE__SCM_MASK
-			| UVD_SUVD_CGC_GATE__SDB_MASK
-			| UVD_SUVD_CGC_GATE__SRE_H264_MASK
-			| UVD_SUVD_CGC_GATE__SRE_HEVC_MASK
-			| UVD_SUVD_CGC_GATE__SIT_H264_MASK
-			| UVD_SUVD_CGC_GATE__SIT_HEVC_MASK
-			| UVD_SUVD_CGC_GATE__SCM_H264_MASK
-			| UVD_SUVD_CGC_GATE__SCM_HEVC_MASK
-			| UVD_SUVD_CGC_GATE__SDB_H264_MASK
-			| UVD_SUVD_CGC_GATE__SDB_HEVC_MASK
-			| UVD_SUVD_CGC_GATE__SCLR_MASK
-			| UVD_SUVD_CGC_GATE__UVD_SC_MASK
-			| UVD_SUVD_CGC_GATE__ENT_MASK
-			| UVD_SUVD_CGC_GATE__SIT_HEVC_DEC_MASK
-			| UVD_SUVD_CGC_GATE__SIT_HEVC_ENC_MASK
-			| UVD_SUVD_CGC_GATE__SITE_MASK
-			| UVD_SUVD_CGC_GATE__SRE_VP9_MASK
-			| UVD_SUVD_CGC_GATE__SCM_VP9_MASK
-			| UVD_SUVD_CGC_GATE__SIT_VP9_DEC_MASK
-			| UVD_SUVD_CGC_GATE__SDB_VP9_MASK
-			| UVD_SUVD_CGC_GATE__IME_HEVC_MASK);
-		WREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_GATE, data);
-
-		data = RREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL);
-		data &= ~(UVD_SUVD_CGC_CTRL__SRE_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SIT_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SMP_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SCM_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SDB_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SCLR_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__UVD_SC_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__ENT_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__IME_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SITE_MODE_MASK);
-		WREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL, data);
-	}
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
+	/* UVD disable CGC */
+	data = RREG32_SOC15(VCN, inst, mmUVD_CGC_CTRL);
+	if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
+		data |= 1 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
+	else
+		data &= ~UVD_CGC_CTRL__DYN_CLOCK_MODE_MASK;
+	data |= 1 << UVD_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
+	data |= 4 << UVD_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
+	WREG32_SOC15(VCN, inst, mmUVD_CGC_CTRL, data);
+
+	data = RREG32_SOC15(VCN, inst, mmUVD_CGC_GATE);
+	data &= ~(UVD_CGC_GATE__SYS_MASK
+		| UVD_CGC_GATE__UDEC_MASK
+		| UVD_CGC_GATE__MPEG2_MASK
+		| UVD_CGC_GATE__REGS_MASK
+		| UVD_CGC_GATE__RBC_MASK
+		| UVD_CGC_GATE__LMI_MC_MASK
+		| UVD_CGC_GATE__LMI_UMC_MASK
+		| UVD_CGC_GATE__IDCT_MASK
+		| UVD_CGC_GATE__MPRD_MASK
+		| UVD_CGC_GATE__MPC_MASK
+		| UVD_CGC_GATE__LBSI_MASK
+		| UVD_CGC_GATE__LRBBM_MASK
+		| UVD_CGC_GATE__UDEC_RE_MASK
+		| UVD_CGC_GATE__UDEC_CM_MASK
+		| UVD_CGC_GATE__UDEC_IT_MASK
+		| UVD_CGC_GATE__UDEC_DB_MASK
+		| UVD_CGC_GATE__UDEC_MP_MASK
+		| UVD_CGC_GATE__WCB_MASK
+		| UVD_CGC_GATE__VCPU_MASK
+		| UVD_CGC_GATE__MMSCH_MASK);
+
+	WREG32_SOC15(VCN, inst, mmUVD_CGC_GATE, data);
+
+	SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_CGC_GATE, 0,  0xFFFFFFFF);
+
+	data = RREG32_SOC15(VCN, inst, mmUVD_CGC_CTRL);
+	data &= ~(UVD_CGC_CTRL__UDEC_RE_MODE_MASK
+		| UVD_CGC_CTRL__UDEC_CM_MODE_MASK
+		| UVD_CGC_CTRL__UDEC_IT_MODE_MASK
+		| UVD_CGC_CTRL__UDEC_DB_MODE_MASK
+		| UVD_CGC_CTRL__UDEC_MP_MODE_MASK
+		| UVD_CGC_CTRL__SYS_MODE_MASK
+		| UVD_CGC_CTRL__UDEC_MODE_MASK
+		| UVD_CGC_CTRL__MPEG2_MODE_MASK
+		| UVD_CGC_CTRL__REGS_MODE_MASK
+		| UVD_CGC_CTRL__RBC_MODE_MASK
+		| UVD_CGC_CTRL__LMI_MC_MODE_MASK
+		| UVD_CGC_CTRL__LMI_UMC_MODE_MASK
+		| UVD_CGC_CTRL__IDCT_MODE_MASK
+		| UVD_CGC_CTRL__MPRD_MODE_MASK
+		| UVD_CGC_CTRL__MPC_MODE_MASK
+		| UVD_CGC_CTRL__LBSI_MODE_MASK
+		| UVD_CGC_CTRL__LRBBM_MODE_MASK
+		| UVD_CGC_CTRL__WCB_MODE_MASK
+		| UVD_CGC_CTRL__VCPU_MODE_MASK
+		| UVD_CGC_CTRL__MMSCH_MODE_MASK);
+	WREG32_SOC15(VCN, inst, mmUVD_CGC_CTRL, data);
+
+	/* turn on */
+	data = RREG32_SOC15(VCN, inst, mmUVD_SUVD_CGC_GATE);
+	data |= (UVD_SUVD_CGC_GATE__SRE_MASK
+		| UVD_SUVD_CGC_GATE__SIT_MASK
+		| UVD_SUVD_CGC_GATE__SMP_MASK
+		| UVD_SUVD_CGC_GATE__SCM_MASK
+		| UVD_SUVD_CGC_GATE__SDB_MASK
+		| UVD_SUVD_CGC_GATE__SRE_H264_MASK
+		| UVD_SUVD_CGC_GATE__SRE_HEVC_MASK
+		| UVD_SUVD_CGC_GATE__SIT_H264_MASK
+		| UVD_SUVD_CGC_GATE__SIT_HEVC_MASK
+		| UVD_SUVD_CGC_GATE__SCM_H264_MASK
+		| UVD_SUVD_CGC_GATE__SCM_HEVC_MASK
+		| UVD_SUVD_CGC_GATE__SDB_H264_MASK
+		| UVD_SUVD_CGC_GATE__SDB_HEVC_MASK
+		| UVD_SUVD_CGC_GATE__SCLR_MASK
+		| UVD_SUVD_CGC_GATE__UVD_SC_MASK
+		| UVD_SUVD_CGC_GATE__ENT_MASK
+		| UVD_SUVD_CGC_GATE__SIT_HEVC_DEC_MASK
+		| UVD_SUVD_CGC_GATE__SIT_HEVC_ENC_MASK
+		| UVD_SUVD_CGC_GATE__SITE_MASK
+		| UVD_SUVD_CGC_GATE__SRE_VP9_MASK
+		| UVD_SUVD_CGC_GATE__SCM_VP9_MASK
+		| UVD_SUVD_CGC_GATE__SIT_VP9_DEC_MASK
+		| UVD_SUVD_CGC_GATE__SDB_VP9_MASK
+		| UVD_SUVD_CGC_GATE__IME_HEVC_MASK);
+	WREG32_SOC15(VCN, inst, mmUVD_SUVD_CGC_GATE, data);
+
+	data = RREG32_SOC15(VCN, inst, mmUVD_SUVD_CGC_CTRL);
+	data &= ~(UVD_SUVD_CGC_CTRL__SRE_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__SIT_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__SMP_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__SCM_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__SDB_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__SCLR_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__UVD_SC_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__ENT_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__IME_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__SITE_MODE_MASK);
+	WREG32_SOC15(VCN, inst, mmUVD_SUVD_CGC_CTRL, data);
 }
 
 static void vcn_v2_5_clock_gating_dpg_mode(struct amdgpu_device *adev,
@@ -777,59 +774,56 @@ static void vcn_v2_5_clock_gating_dpg_mode(struct amdgpu_device *adev,
  *
  * Enable clock gating for VCN block
  */
-static void vcn_v2_5_enable_clock_gating(struct amdgpu_device *adev)
+static void vcn_v2_5_enable_clock_gating(struct amdgpu_device *adev, int inst)
 {
 	uint32_t data = 0;
-	int i;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-		/* enable UVD CGC */
-		data = RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
-		if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
-			data |= 1 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
-		else
-			data |= 0 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
-		data |= 1 << UVD_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
-		data |= 4 << UVD_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
-		WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
-
-		data = RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
-		data |= (UVD_CGC_CTRL__UDEC_RE_MODE_MASK
-			| UVD_CGC_CTRL__UDEC_CM_MODE_MASK
-			| UVD_CGC_CTRL__UDEC_IT_MODE_MASK
-			| UVD_CGC_CTRL__UDEC_DB_MODE_MASK
-			| UVD_CGC_CTRL__UDEC_MP_MODE_MASK
-			| UVD_CGC_CTRL__SYS_MODE_MASK
-			| UVD_CGC_CTRL__UDEC_MODE_MASK
-			| UVD_CGC_CTRL__MPEG2_MODE_MASK
-			| UVD_CGC_CTRL__REGS_MODE_MASK
-			| UVD_CGC_CTRL__RBC_MODE_MASK
-			| UVD_CGC_CTRL__LMI_MC_MODE_MASK
-			| UVD_CGC_CTRL__LMI_UMC_MODE_MASK
-			| UVD_CGC_CTRL__IDCT_MODE_MASK
-			| UVD_CGC_CTRL__MPRD_MODE_MASK
-			| UVD_CGC_CTRL__MPC_MODE_MASK
-			| UVD_CGC_CTRL__LBSI_MODE_MASK
-			| UVD_CGC_CTRL__LRBBM_MODE_MASK
-			| UVD_CGC_CTRL__WCB_MODE_MASK
-			| UVD_CGC_CTRL__VCPU_MODE_MASK);
-		WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
-
-		data = RREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL);
-		data |= (UVD_SUVD_CGC_CTRL__SRE_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SIT_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SMP_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SCM_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SDB_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SCLR_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__UVD_SC_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__ENT_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__IME_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SITE_MODE_MASK);
-		WREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL, data);
-	}
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
+	/* enable UVD CGC */
+	data = RREG32_SOC15(VCN, inst, mmUVD_CGC_CTRL);
+	if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
+		data |= 1 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
+	else
+		data |= 0 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
+	data |= 1 << UVD_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
+	data |= 4 << UVD_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
+	WREG32_SOC15(VCN, inst, mmUVD_CGC_CTRL, data);
+
+	data = RREG32_SOC15(VCN, inst, mmUVD_CGC_CTRL);
+	data |= (UVD_CGC_CTRL__UDEC_RE_MODE_MASK
+		| UVD_CGC_CTRL__UDEC_CM_MODE_MASK
+		| UVD_CGC_CTRL__UDEC_IT_MODE_MASK
+		| UVD_CGC_CTRL__UDEC_DB_MODE_MASK
+		| UVD_CGC_CTRL__UDEC_MP_MODE_MASK
+		| UVD_CGC_CTRL__SYS_MODE_MASK
+		| UVD_CGC_CTRL__UDEC_MODE_MASK
+		| UVD_CGC_CTRL__MPEG2_MODE_MASK
+		| UVD_CGC_CTRL__REGS_MODE_MASK
+		| UVD_CGC_CTRL__RBC_MODE_MASK
+		| UVD_CGC_CTRL__LMI_MC_MODE_MASK
+		| UVD_CGC_CTRL__LMI_UMC_MODE_MASK
+		| UVD_CGC_CTRL__IDCT_MODE_MASK
+		| UVD_CGC_CTRL__MPRD_MODE_MASK
+		| UVD_CGC_CTRL__MPC_MODE_MASK
+		| UVD_CGC_CTRL__LBSI_MODE_MASK
+		| UVD_CGC_CTRL__LRBBM_MODE_MASK
+		| UVD_CGC_CTRL__WCB_MODE_MASK
+		| UVD_CGC_CTRL__VCPU_MODE_MASK);
+	WREG32_SOC15(VCN, inst, mmUVD_CGC_CTRL, data);
+
+	data = RREG32_SOC15(VCN, inst, mmUVD_SUVD_CGC_CTRL);
+	data |= (UVD_SUVD_CGC_CTRL__SRE_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__SIT_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__SMP_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__SCM_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__SDB_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__SCLR_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__UVD_SC_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__ENT_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__IME_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__SITE_MODE_MASK);
+	WREG32_SOC15(VCN, inst, mmUVD_SUVD_CGC_CTRL, data);
 }
 
 static void vcn_v2_6_enable_ras(struct amdgpu_device *adev, int inst_idx,
@@ -1032,7 +1026,7 @@ static int vcn_v2_5_start(struct amdgpu_device *adev, unsigned int inst)
 		return 0;
 
 	/*SW clock gating */
-	vcn_v2_5_disable_clock_gating(adev);
+	vcn_v2_5_disable_clock_gating(adev, inst);
 
 	if (adev->vcn.harvest_config & (1 << inst))
 		return 0;
@@ -1471,7 +1465,7 @@ static int vcn_v2_5_stop(struct amdgpu_device *adev, unsigned int inst)
 	/* clear status */
 	WREG32_SOC15(VCN, inst, mmUVD_STATUS, 0);
 
-	vcn_v2_5_enable_clock_gating(adev);
+	vcn_v2_5_enable_clock_gating(adev, inst);
 
 	/* enable register anti-hang mechanism */
 	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_POWER_STATUS),
@@ -1794,6 +1788,7 @@ static int vcn_v2_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	bool enable = (state == AMD_CG_STATE_GATE);
+	int inst = ip_block->instance;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
@@ -1801,9 +1796,9 @@ static int vcn_v2_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	if (enable) {
 		if (!vcn_v2_5_is_idle(adev))
 			return -EBUSY;
-		vcn_v2_5_enable_clock_gating(adev);
+		vcn_v2_5_enable_clock_gating(adev, inst);
 	} else {
-		vcn_v2_5_disable_clock_gating(adev);
+		vcn_v2_5_disable_clock_gating(adev, inst);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 451858f86272..b78c6da0a3cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -2122,19 +2122,17 @@ static int vcn_v3_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	bool enable = state == AMD_CG_STATE_GATE;
-	int i;
+	int inst = ip_block->instance;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return 0;
 
-		if (enable) {
-			if (RREG32_SOC15(VCN, i, mmUVD_STATUS) != UVD_STATUS__IDLE)
-				return -EBUSY;
-			vcn_v3_0_enable_clock_gating(adev, i);
-		} else {
-			vcn_v3_0_disable_clock_gating(adev, i);
-		}
+	if (enable) {
+		if (RREG32_SOC15(VCN, inst, mmUVD_STATUS) != UVD_STATUS__IDLE)
+			return -EBUSY;
+		vcn_v3_0_enable_clock_gating(adev, inst);
+	} else {
+		vcn_v3_0_disable_clock_gating(adev, inst);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index fa7cf10e8900..8aa30a4bddbf 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1993,19 +1993,17 @@ static int vcn_v4_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	bool enable = state == AMD_CG_STATE_GATE;
-	int i;
+	int inst = ip_block->instance;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return 0;
 
-		if (enable) {
-			if (RREG32_SOC15(VCN, i, regUVD_STATUS) != UVD_STATUS__IDLE)
-				return -EBUSY;
-			vcn_v4_0_enable_clock_gating(adev, i);
-		} else {
-			vcn_v4_0_disable_clock_gating(adev, i);
-		}
+	if (enable) {
+		if (RREG32_SOC15(VCN, inst, regUVD_STATUS) != UVD_STATUS__IDLE)
+			return -EBUSY;
+		vcn_v4_0_enable_clock_gating(adev, inst);
+	} else {
+		vcn_v4_0_disable_clock_gating(adev, inst);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index d05dcadb3e81..64b738f929b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1587,18 +1587,17 @@ static int vcn_v4_0_3_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	bool enable = state == AMD_CG_STATE_GATE;
-	int i;
+	int inst = ip_block->instance;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (enable) {
-			if (RREG32_SOC15(VCN, GET_INST(VCN, i),
-					 regUVD_STATUS) != UVD_STATUS__IDLE)
-				return -EBUSY;
-			vcn_v4_0_3_enable_clock_gating(adev, i);
-		} else {
-			vcn_v4_0_3_disable_clock_gating(adev, i);
-		}
+	if (enable) {
+		if (RREG32_SOC15(VCN, GET_INST(VCN, inst),
+				 regUVD_STATUS) != UVD_STATUS__IDLE)
+			return -EBUSY;
+		vcn_v4_0_3_enable_clock_gating(adev, inst);
+	} else {
+		vcn_v4_0_3_disable_clock_gating(adev, inst);
 	}
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 307c8e204456..c901255a05ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1490,19 +1490,17 @@ static int vcn_v4_0_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	bool enable = (state == AMD_CG_STATE_GATE) ? true : false;
-	int i;
+	int inst = ip_block->instance;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return 0;
 
-		if (enable) {
-			if (RREG32_SOC15(VCN, i, regUVD_STATUS) != UVD_STATUS__IDLE)
-				return -EBUSY;
-			vcn_v4_0_5_enable_clock_gating(adev, i);
-		} else {
-			vcn_v4_0_5_disable_clock_gating(adev, i);
-		}
+	if (enable) {
+		if (RREG32_SOC15(VCN, inst, regUVD_STATUS) != UVD_STATUS__IDLE)
+			return -EBUSY;
+		vcn_v4_0_5_enable_clock_gating(adev, inst);
+	} else {
+		vcn_v4_0_5_disable_clock_gating(adev, inst);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 50022bbb276e..6973fee37c12 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1217,19 +1217,17 @@ static int vcn_v5_0_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	bool enable = (state == AMD_CG_STATE_GATE) ? true : false;
-	int i;
+	int inst = ip_block->instance;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return 0;
 
-		if (enable) {
-			if (RREG32_SOC15(VCN, i, regUVD_STATUS) != UVD_STATUS__IDLE)
-				return -EBUSY;
-			vcn_v5_0_0_enable_clock_gating(adev, i);
-		} else {
-			vcn_v5_0_0_disable_clock_gating(adev, i);
-		}
+	if (enable) {
+		if (RREG32_SOC15(VCN, inst, regUVD_STATUS) != UVD_STATUS__IDLE)
+			return -EBUSY;
+		vcn_v5_0_0_enable_clock_gating(adev, inst);
+	} else {
+		vcn_v5_0_0_disable_clock_gating(adev, inst);
 	}
 
 	return 0;
-- 
2.34.1

