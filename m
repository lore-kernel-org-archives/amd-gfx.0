Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55974D3A678
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 17:43:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06E0810E6CA;
	Tue, 29 Oct 2024 17:43:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mmo4keqh";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8883010E6BA
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 17:43:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BrCr8IXRl+DmhqEVUyU85cVrP0cTlhlICKj55ZyBoYQvgvSO1tOPuCBDgNXCJfKz3kCxsqQIaMm3JqRtLdfyEkXaXgRdw4j3L9NJaYNOjDvNSyiyUgWpZMrh7JfO5S8wfs37I7RU46rfAlhAdrJJ9RaXHquCTs5mtwB38DN0ZB/dqmb0rPFjACBOAbjA9SN1oT2VcU9MWaODobKuHi2p3wCMybYKICS1OvF+fhTIIK3vIx+gZQwy+D168bL7SdYtlAtCzDZ/CDcGZWNEx3fw5BVRUwDG63oVIuYlxT+xbvB87Dk89U0Eahs01MHGhJRsvMt1elx95Id46Sq1n07fHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1GeBvrSjRk8wshdf5Hvx5yHWMN/nwift4uVI8FRUow=;
 b=Uod0arKMnFyvih+O/FWA+lDIspzi1RHLXytaH4rHJJElcA6QsF7ZkVe8SCxRPFfa/FDkNIMeM9Hnms7jZPYYtyWX6VHsGJLfQd4o6f2XrPFILzN4tAdhThYhRQBlDbhUB6lfNXhYCDKfSRvylfvCDJIbDEnZI1nG3QP9EWbVWo4o0FtIqW1gIjJ9HkuODwmy6LJ/Rl2yA1q68+3HA41TTNvuYAuXGB8sEH5sQBvLgTEk3D0GgA4m5nXycHI1JATC4sQf/7IrIg5Yv0d9yOkyXKP6ttp/xFb/0HlLBfhBVo3ckZoXQUkKiT3YAPtcQcVSRzQ7k9FyknQN5f7qkhsf4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1GeBvrSjRk8wshdf5Hvx5yHWMN/nwift4uVI8FRUow=;
 b=mmo4keqh58cLLzaLOiIhyWKtfrOPaafPQvUnAX93zQGO5AzfWufWQPCpmsZ5vYja9jItT2B4DnO1Na8kNIRIq9y/DQ/v/n2FcrqsVWyse3h3ZRoV/PLarFfatBXAV/SuwWX8hZo/k4Vvf8+C7PtfEgH/+4KJMNMcnlVuI8D15BE=
Received: from SN6PR16CA0043.namprd16.prod.outlook.com (2603:10b6:805:ca::20)
 by DM6PR12MB4371.namprd12.prod.outlook.com (2603:10b6:5:2a3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 17:43:11 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:805:ca:cafe::5c) by SN6PR16CA0043.outlook.office365.com
 (2603:10b6:805:ca::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.17 via Frontend
 Transport; Tue, 29 Oct 2024 17:43:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 17:43:11 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 12:43:04 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 29/29] drm/amdgpu: set_powergating for each vcn instance
Date: Tue, 29 Oct 2024 13:42:40 -0400
Message-ID: <20241029174240.682928-30-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029174240.682928-1-boyuan.zhang@amd.com>
References: <20241029174240.682928-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|DM6PR12MB4371:EE_
X-MS-Office365-Filtering-Correlation-Id: a3d04006-5b66-4d83-9f89-08dcf8412845
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0dhREZSR3RyWHZiUTNHQ3JGTmpGRjNmT1daRzJTc1pJeXo1dzNWUzg0OUVi?=
 =?utf-8?B?SHhrVkZUSExTd3Q0OGIxYVN4WUtDOVZBWTNQUURMMVBpbkhkWUxvYzR0MVhO?=
 =?utf-8?B?dUQ0MGt1RDd1cDBrbFZsWExqNGtQUVFYRzl0S0lQMkl3emdNVElmVlJqYUhl?=
 =?utf-8?B?cXA3R1VKdVVSYndLQjZoZDB1Y0pGSmtzZUtiY2l0YnpsVFVxK3pzR3RXS0RC?=
 =?utf-8?B?eGF3amIxd3NZVkNFdFZ2dGJxNlZqZ29xbWxXZ0FTOUN6OUFXNmcydllTM2l2?=
 =?utf-8?B?WFd1a0NKNnlkYk45NWdQMVlXYmNGRUxuVG9Fd2dPWlBPQ2RmQXl0Q0tZVU92?=
 =?utf-8?B?VGJ0RDdzNVdWSGlTcEtnWmlxOVZYMHBBQ1RkeGFkTm1IV3BQekFiM2VFUWcz?=
 =?utf-8?B?TGxtNjhzRHVNSnFmaFNRUWZqaXZObzI5c2F0Y3dEOHpnK3MvNDdsMHYyemEy?=
 =?utf-8?B?UFM5SWdCbUJKYUt5cFh3N3cvOWdWRDVlY1dETm81L2k3UDJEejVGeFFKRVho?=
 =?utf-8?B?akNkVUpVMHFjUDBxMGVITUs5NFNsd3ZmRmZCdHdPRWNuT0ZyR2ZZdVoyV0FO?=
 =?utf-8?B?SmNsWDIzSjgrNytQV25iTm1vUWpuNkYvYnhONjRuZVp6b1pLM1E2RElNeHVp?=
 =?utf-8?B?clQ3MjhyTTRMVzVScTJyZFdaeDIyT0ZPVjlxNm9ZVU1iTGF4Z3FpRDJpRHhl?=
 =?utf-8?B?bDhJUzVoMWwxMDR4MUtjcXBCcTRtbjdiSXpUQ0RlMjgrS3pycXQrWUJPbS9i?=
 =?utf-8?B?QWNuYVdVdG94UTJnWmhCd3E5N3RkSUFMTFY5NUlTSUhaNkIrNGU3a081a0h5?=
 =?utf-8?B?emJrbTBjZjhwMERjVUxkcXhIdy85YW5ZWFhjQjVNcGZzM1FPTzk2TXdmTHRK?=
 =?utf-8?B?WTFNekFlNXBpY0RMZWFqbUhaSnUrOCt0RGxXRTNDQVNEdXZTYmxxNFNSZUVt?=
 =?utf-8?B?dFd5eGw0V2MzNG00MUh1QU03SmRVbUVES2NxcXovUENyTk5mcThMaEFsNVky?=
 =?utf-8?B?QUlYdk56MHRwbkd5RnBhNHBJbDZ1Tm5NbVlXM1J2NUFqV1k0U0k5eThKME9U?=
 =?utf-8?B?NUcxdmtYWUE3T2hHdmhsMUFVWm0veHMweW9NVE5Ic2hHbU5jd2Y1d3hSVDFv?=
 =?utf-8?B?WTNxelFIYUhMcFI0RHpXSzNBMmFFOEczcEtFaFJXdGdNcmdRTGV1YkYwSzkx?=
 =?utf-8?B?amxXRDFoZU5kQ1ZGREx0QzZaVkJLUTlnMnRMdDdXbUdUSFlIVXIyMzc3enBx?=
 =?utf-8?B?UFZaQzNOb3VJcXYxWWpsdUpGNUtKOWpkZFpvdzYvU1RHcElnd2ExMC85V3ZV?=
 =?utf-8?B?ZTVwS1M3Y2Z4TkFpMmxJU1h2anY2T1BVQkpoc3o4M2E2Zm1sak5DK2pxaHFt?=
 =?utf-8?B?Y2trZnRBaWJLcW5qK0dkRWNjYmltaHJ1UVpUN0dpNjhpRFRReld1QU41dG9D?=
 =?utf-8?B?SlpjU1U5SXZLd1lMTkJFdElvNVBUdndpck00WnJzSUw4dDNpK2dYbCtDclpE?=
 =?utf-8?B?dzlKRGhzNVRPOElIdEdzcTNVeGpkNDVMTEI5enBtWjRZdWNwdmliN1RuK2wr?=
 =?utf-8?B?cDgzVGNIQ3c5UGM5VyszR0NDN2hQUkJwaEtybHNQM1d1aWFIa1hJeUlpa0VR?=
 =?utf-8?B?TmJBRFNLY0JYMzNpM0Y3cGJUdDQyMUhCYkE3d2ZUOEhKMWhObG5IeXVFeFFF?=
 =?utf-8?B?VEpaOG02UFA2citUSjRWT3NZMXVmWXMxZm5ZMWlhOUNxSWpGdzFmend2c25W?=
 =?utf-8?B?dTBOSUdxdWEvYy9QS1lTdUpTbmExVGNxR21sYis2aXo1dG94R0hMR2c3SVVR?=
 =?utf-8?B?QmU0L290YXM3dkZLOXJRc2RJUjVKRlp3REtHbDcyd3dPT0xHL0UwUkV3aVIr?=
 =?utf-8?B?QmltK2hSMnZQUlF1Q1hxUFpyMkZPUE1YZ3VBekhzTG14SHc9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 17:43:11.1200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3d04006-5b66-4d83-9f89-08dcf8412845
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4371
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
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
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

