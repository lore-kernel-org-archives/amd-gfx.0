Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94490C5AD57
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Feb 2026 19:23:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E1AD10E833;
	Fri, 20 Feb 2026 19:23:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ev9sQbc/";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012017.outbound.protection.outlook.com [52.101.53.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEB0C10E82D
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Feb 2026 19:23:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TydTY9Mz30MQhB/eRh0j0NYtE198m2HplKcBc6ppCrrh5+3GouMp2jo45OuIV29LjiCYFuZo8GRXViMCdlc6MyLgu6LxKsEzDkBp0wTPLXxHv80Ciayq55NzzNmZ2g0uwxDgvKQJy5uRoV8T7bw4OejaOu5L7TlZtTq3DNZHFoOwgNrWO7Iz/m0c6tXl+bARKjWpkSnY97vBnyK37AkUlPWINPd4UEO9Wnlqla4IccsV7f6FBUQx9JrqwvRUIzmtbpq1Gt6vRXZFuTy6RRGaVQGLeQHeVIlBid2qFsOwCBDcijhx4V2BqkJwATyqLEkpo/lGCZ5RbEUSbSnXS5F+Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lonN3NUoewbLcuhvfSpWyfTITfiTMOZKlKRQzveWHXE=;
 b=YQubWJOCkLotV00gM7mhh4kVj/kNWz7pEqYlCwGPqEOE2smsMSqhGJm1ekC72G5/CeAlcU5LQu5qlz2GQK7s1zb6g8vFA/BFYYc+77txBBDSNJagbhJiUbesU8xn/Yv5ZZ1PquuQ3YmKA3T5yJwVpzQeALPBDKS/pe7TSgtjAapBW3IRj4c9l8imgWJVll87eON5XNPH5Aix/3/hI2VFwKp16vA+qqlGERpW9PqIHeoZyGyNGl1FYkmLlCfLF2sKD3hCMiLChihxTXgWGQ87B2EF+iIGSzjsFBvIwP6uAVgPl0+k+5YP5/806s8tDWyCl2g7dG/xVuUA8TtyI1IbtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lonN3NUoewbLcuhvfSpWyfTITfiTMOZKlKRQzveWHXE=;
 b=ev9sQbc/1Fz18s62gcXBwZcB3dgFShVJjZQt6DD9K+tMKv0uBOuBfMmbQioc4/IQzYc6vHIkfCDSYH3xurpL8ztWfR3ZOgXx4WBRWKqltqi6bIsJ+ok43TPzKaOJV/5hnY6BO3j0WWRUydbf2n5+bpYiLoVgr0BkhOdJAPpRlqg=
Received: from PH1PEPF00013303.namprd07.prod.outlook.com (2603:10b6:518:1::12)
 by MN0PR12MB6031.namprd12.prod.outlook.com (2603:10b6:208:3cd::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Fri, 20 Feb
 2026 19:23:10 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2a01:111:f403:f910::2) by PH1PEPF00013303.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.16 via Frontend Transport; Fri,
 20 Feb 2026 19:23:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Fri, 20 Feb 2026 19:23:09 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Feb
 2026 13:22:56 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>
CC: <Bing.Ma@amd.com>, <jamesz@amd.com>
Subject: [PATCH 16/17] drm/amdgpu: add profiler/spm support for gfx9
Date: Fri, 20 Feb 2026 14:22:35 -0500
Message-ID: <20260220192236.3121556-16-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260220192236.3121556-1-James.Zhu@amd.com>
References: <20260220192236.3121556-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|MN0PR12MB6031:EE_
X-MS-Office365-Filtering-Correlation-Id: c02ef5e5-9499-41bd-efb7-08de70b57b97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b87MmLrHfBK9izNwuJTEfkrraE0zkfgXOujAhPeIOF6e4Uf+MW2SI6/Rz2s0?=
 =?us-ascii?Q?ogD2mVJPZXjI+QbYwRYtpwJtMdvf1yKAHFGMuIB3GWPQKd0Jkmpsd5+F1XE6?=
 =?us-ascii?Q?7jtkjrBcs+VuNlZvceampGuQ6eWfo24RBJaYuuVOSNfOAlVCjw9iPt1ALA7R?=
 =?us-ascii?Q?xWZ2Ry15kwaDbQszAQk8Agqd1If0t+o4RTGuKB60fTPoqndLgyFIIrjJIr30?=
 =?us-ascii?Q?b+Xs7gjep3f+3TqWlc7daK0FBmjjfjYYybbvT/hZJJhAo8wzK1LDfDFvZOrR?=
 =?us-ascii?Q?saBnsv6xLWjYbrHEOQo/jKFX0Lx2+fWRuug9MvNsM3zZ85z7KWGqAcsJuS12?=
 =?us-ascii?Q?SnbcwLdZAUnBupvTg/xUFpDXaLf5kJuMpZmOEaR+uw7hv+7aI4cEVQRbuaoI?=
 =?us-ascii?Q?O5jVeMeaMypV7TkDtYB3ZVbsaylzSWqfzsxK9rO5ojFUj2kDtHqeCVcFtWna?=
 =?us-ascii?Q?S0zS82J/Z56DQ8g47V9CwiImNHs7T89thZ9RhnnGik9TaatLhKybP1xWwIgE?=
 =?us-ascii?Q?Ym2Pn1tUgjR2uynXzJWgBBjbfzp52GKYloolV8Ds053eSRH/d50HopkpuAVU?=
 =?us-ascii?Q?Yi4lIZRJFWkKDyB7SHqlKJQ8PMDgIC+EUPSvEiNc4Ei9xVb/zX9MuXYzV8xq?=
 =?us-ascii?Q?5POjyswqRsXD1IS2nbMRxPHmexvmHXRCTO1XeQSbKQDO6wwsQjoHKKqBhopu?=
 =?us-ascii?Q?lAHgqtc+SEqSf0S6r9AGSDbl7/mpOAdJ3BVKX7XflbJ9pWiNfwit5XZeGz5f?=
 =?us-ascii?Q?O/4WlVyA3BEI/l8GOucZi7CoxgHNIpt4TAVXusIEJSPq178dYKt2oU2QB47c?=
 =?us-ascii?Q?upAKeZiNASK12Ab+CrqcgTU4UdX02gP+e0fymJrURGnM/0JJBpi1XLZM/nnB?=
 =?us-ascii?Q?D6JRsWbxLSzP/D/iHxlko+EHWqXVesn4HpUgtDJgfrIrZHJoiD+gef1rVwtx?=
 =?us-ascii?Q?W5/fu3ARfqu+/PP8F6zjS0bmFWHFNOcJnA+99kjh+vwaJbEnkpd6lNHipDK8?=
 =?us-ascii?Q?FKBbQ1TsAgPYOsXP0X1Nokxz2AdzHRisjGzsKEaN6WxqbtYGwMz+ra3+h6dV?=
 =?us-ascii?Q?T0gAY1sz0h6h0bgWBw5KuKfh+lO4eR05wpkPg+Ewl/H9Twna0JLSTnVYy0OU?=
 =?us-ascii?Q?8XIIdeAzWSGL/hy2G+K9Axm35HUGx3dnyQgpazdxglUvzfqqZbv4aqg2keIJ?=
 =?us-ascii?Q?2Ls7kpCB4bRsGLh2PGlGA6gKlYnt75PSgban+C9YJtdyxFblSDlBGgK2eBMp?=
 =?us-ascii?Q?w5/hCHsFEBcCwyFg5fXv49pg52pskiRQo/mRcPWHweju3cSvhyxIbvYk+67g?=
 =?us-ascii?Q?WigezXoFFwdsEgYPLeUEDSJ4eY5V6Tz4WlKaReRI5bLn/fxl1TDFAiwI/34H?=
 =?us-ascii?Q?OZN0siN4Ndu0b1Crm9K7jXVp8c09izSIig4/UtsBrlE3zzoVtQyQPPIG1Y1T?=
 =?us-ascii?Q?KXK7m5yAzCD8UX8AWQ20+bMUzzlchNCEJ/4ZGu1qvzkBIxw8TuBzIznjmXMz?=
 =?us-ascii?Q?YM41n9n1dAchlpfYA9FjFmiYoZ0nnA8aVoRrBk/Rj+bP28lCqJYmOBxts3GQ?=
 =?us-ascii?Q?1vSuDFSun+7iEWJjVoKbMLiRH+rlkzagfdJg//y5uiNvX41RAJaVVK+gCK+B?=
 =?us-ascii?Q?9XuGu9eSCGp4ee/nqOkdBTpbj3PyNsb4M38Zhd7xK0MnKdNavTt8yyNtRwEV?=
 =?us-ascii?Q?6y3l9w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: q72KEdfavmi6pOtCVONxxIskho5FaZXNY7SrdiTR7QNt+NO117Nj5lpDN7aNPdxkwXpbCCnTCKpcVNCuMjvmrYUctpK5h5Xxr2m4jWVbb+E3HNUkCMGcKQ8vEHc+4SnO9i3a8lODpvC4jvVNZNFtbt7njAB7js+lK7KaxQAcE05dAuohDf7vU3gfdt2tCs5MgQY78mvA82D1CvqwikLreqAtCCaFIqG+ew5hrjenZ09leDBXD3T/oEa601i6XrIIjscvcOZ/pT0sMd/i9BIky1VIitlLfTCmV4MI7Qg7AjX+Gbgp8PBmF5M5/ieUKYhWTbXt/nTYjEIjy7BS1a2F4KZ/y48KBQVU8Uw1w5Dkml8ulOwPpORMYTWrlPs89fZr1c700tABfrOmIzKaTGOtQsES1/gAOCbSAbJQYH/j68A0aELPUf/dkAKiqnNKeWhf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 19:23:09.7260 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c02ef5e5-9499-41bd-efb7-08de70b57b97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6031
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

with spm function interface and spm irq.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |   1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 135 ++++++++++++++++++++++++
 2 files changed, 136 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 685ebbacf14a..cae88f6ed3bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -469,6 +469,7 @@ struct amdgpu_gfx {
 	struct amdgpu_irq_src		priv_inst_irq;
 	struct amdgpu_irq_src		bad_op_irq;
 	struct amdgpu_irq_src		cp_ecc_error_irq;
+	struct amdgpu_irq_src		spm_irq;
 	struct amdgpu_irq_src		sq_irq;
 	struct amdgpu_irq_src		rlc_gc_fed_irq;
 	struct sq_work			sq_work;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index e6187be27385..edb5efbcd216 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2273,6 +2273,13 @@ static int gfx_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 	adev->gfx.mec.num_pipe_per_mec = 4;
 	adev->gfx.mec.num_queue_per_pipe = 8;
 
+	/* SPM */
+	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_RLC,
+			      GFX_9_0__SRCID__RLC_STRM_PERF_MONITOR_INTERRUPT,
+			      &adev->gfx.spm_irq);
+	if (r)
+		return r;
+
 	/* EOP Event */
 	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_GRBM_CP, GFX_9_0__SRCID__CP_EOP_INTERRUPT, &adev->gfx.eop_irq);
 	if (r)
@@ -4052,6 +4059,7 @@ static int gfx_v9_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
 		amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
+	amdgpu_irq_put(adev, &adev->gfx.spm_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
 
@@ -4789,6 +4797,95 @@ static int gfx_v9_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 	return r;
 }
 
+static void gfx_v9_0_spm_start(struct amdgpu_device *adev, int xcc_id)
+{
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[0].ring;
+	uint32_t data = 0;
+
+	data = RREG32_SOC15(GC, 0, mmRLC_SPM_PERFMON_CNTL);
+	data |= RLC_SPM_PERFMON_CNTL__PERFMON_RING_MODE_MASK;
+	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false,
+			SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_PERFMON_CNTL), data);
+
+	data = REG_SET_FIELD(0, CP_PERFMON_CNTL, SPM_PERFMON_STATE,
+			CP_PERFMON_STATE_DISABLE_AND_RESET);
+	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false,
+			SOC15_REG_OFFSET(GC, 0, mmCP_PERFMON_CNTL), data);
+
+	/* When SPM is reset, RLC automatically resets wptr to 0.
+	 * Manually reset rptr to match this.
+	 */
+	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false,
+			SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_RING_RDPTR), 0);
+
+	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false,
+			SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_INT_CNTL), 1);
+}
+
+static void gfx_v9_0_spm_stop(struct amdgpu_device *adev, int xcc_id)
+{
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[0].ring;
+	uint32_t data = 0;
+
+	data = REG_SET_FIELD(0, CP_PERFMON_CNTL, SPM_PERFMON_STATE,
+			CP_PERFMON_STATE_STOP_COUNTING);
+	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false,
+			SOC15_REG_OFFSET(GC, 0, mmCP_PERFMON_CNTL), data);
+
+	data = REG_SET_FIELD(0, CP_PERFMON_CNTL, PERFMON_STATE,
+			CP_PERFMON_STATE_DISABLE_AND_RESET);
+	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false,
+			SOC15_REG_OFFSET(GC, 0, mmCP_PERFMON_CNTL), data);
+
+	/* When SPM is reset, RLC automatically resets wptr to 0.
+	 * Manually reset rptr to match this.
+	 */
+	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false,
+			SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_RING_RDPTR), 0);
+}
+
+static void gfx_v9_0_spm_set_rdptr(struct amdgpu_device *adev, int xcc_id,  u32 rptr)
+{
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[0].ring;
+
+	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false,
+			SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_RING_RDPTR), rptr);
+}
+
+static void gfx_v9_0_set_spm_perfmon_ring_buf(struct amdgpu_device *adev,
+					    int xcc_id, u64 gpu_addr, u32 size)
+{
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[0].ring;
+
+	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0,
+			mmRLC_SPM_PERFMON_RING_BASE_LO), lower_32_bits(gpu_addr));
+
+	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false,
+			SOC15_REG_OFFSET(GC, 0,
+				mmRLC_SPM_PERFMON_RING_BASE_HI), upper_32_bits(gpu_addr));
+
+	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false,
+			SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_PERFMON_RING_SIZE), size);
+	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false,
+			SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_SEGMENT_THRESHOLD), 0x1);
+
+	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false,
+			SOC15_REG_OFFSET(GC, 0, mmCP_PERFMON_CNTL), 0);
+}
+
+static const struct spm_funcs gfx_v9_0_spm_funcs = {
+	.start = &gfx_v9_0_spm_start,
+	.stop = &gfx_v9_0_spm_stop,
+	.set_rdptr = &gfx_v9_0_spm_set_rdptr,
+	.set_spm_perfmon_ring_buf = &gfx_v9_0_set_spm_perfmon_ring_buf,
+	.set_spm_config_size = 30,
+};
+
+static void gfx_v9_0_set_spm_funcs(struct amdgpu_device *adev)
+{
+	adev->gfx.spmfuncs = &gfx_v9_0_spm_funcs;
+}
+
 static int gfx_v9_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -4803,6 +4900,7 @@ static int gfx_v9_0_early_init(struct amdgpu_ip_block *ip_block)
 	adev->gfx.xcc_mask = 1;
 	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
 					  AMDGPU_MAX_COMPUTE_RINGS);
+	gfx_v9_0_set_spm_funcs(adev);
 	gfx_v9_0_set_kiq_pm4_funcs(adev);
 	gfx_v9_0_set_ring_funcs(adev);
 	gfx_v9_0_set_irq_funcs(adev);
@@ -4858,6 +4956,10 @@ static int gfx_v9_0_late_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	r = amdgpu_irq_get(adev, &adev->gfx.spm_irq, 0);
+	if (r)
+		return r;
+
 	r = amdgpu_irq_get(adev, &adev->gfx.priv_inst_irq, 0);
 	if (r)
 		return r;
@@ -7100,6 +7202,32 @@ static void gfx_v9_0_emit_mem_sync(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, 0x0000000A); /* POLL_INTERVAL */
 }
 
+static int gfx_v9_0_spm_set_interrupt_state(struct amdgpu_device *adev,
+					     struct amdgpu_irq_src *src,
+					     unsigned int type,
+					     enum amdgpu_interrupt_state state)
+{
+	switch (state) {
+	case AMDGPU_IRQ_STATE_DISABLE:
+		WREG32_SOC15(GC, 0, mmRLC_SPM_INT_CNTL, 0);
+		break;
+	case AMDGPU_IRQ_STATE_ENABLE:
+		WREG32_SOC15(GC, 0, mmRLC_SPM_INT_CNTL, 1);
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+static int gfx_v9_0_spm_irq(struct amdgpu_device *adev,
+			     struct amdgpu_irq_src *source,
+			     struct amdgpu_iv_entry *entry)
+{
+	amdgpu_rlc_spm_interrupt(adev, 0);
+	return 0;
+}
+
 static void gfx_v9_0_emit_wave_limit_cs(struct amdgpu_ring *ring,
 					uint32_t pipe, bool enable)
 {
@@ -7633,12 +7761,19 @@ static const struct amdgpu_irq_src_funcs gfx_v9_0_cp_ecc_error_irq_funcs = {
 	.process = amdgpu_gfx_cp_ecc_error_irq,
 };
 
+static const struct amdgpu_irq_src_funcs gfx_v9_0_spm_irq_funcs = {
+	.set = gfx_v9_0_spm_set_interrupt_state,
+	.process = gfx_v9_0_spm_irq,
+};
 
 static void gfx_v9_0_set_irq_funcs(struct amdgpu_device *adev)
 {
 	adev->gfx.eop_irq.num_types = AMDGPU_CP_IRQ_LAST;
 	adev->gfx.eop_irq.funcs = &gfx_v9_0_eop_irq_funcs;
 
+	adev->gfx.spm_irq.num_types = 1;
+	adev->gfx.spm_irq.funcs = &gfx_v9_0_spm_irq_funcs;
+
 	adev->gfx.priv_reg_irq.num_types = 1;
 	adev->gfx.priv_reg_irq.funcs = &gfx_v9_0_priv_reg_irq_funcs;
 
-- 
2.34.1

