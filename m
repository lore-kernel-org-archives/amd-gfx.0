Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB80C021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 13:00:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC29B10E844;
	Fri, 21 Feb 2025 13:00:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AZLBd26q";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC89810E844
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 13:00:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cs8skXsF42Q+gsMGkSi9bvjjw2EOtHOGMoMdTb6KIG7lV50TT4bc8U3teoRjpZQFJwE9sKm+lZ5FDI2vOd9LfWbdL4GkfFTA887+HbE8PAmITGCyaamq0jKeMcorcaB2YR4xu3rGWGBRQ11oHO3vzevKlHPMCRMDRcm9EKMAUxamRooG0ldRRAzTSmeFQ1ikj8H55Ll6+eV61S791SGiIGZmbsQgSqVPVapenRn58NUmm/YFVHRRg+R0wET+URzA07Hg47Su+2F+5omchNZisz1R9xtrNCQkV82vA8/n/4408LyqfwM45jVntkCyntEeYkTfdMOcNEAmnLhkVX3YvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQ25dMuV1y/GtKkLtuyKYav0YH0U66SuxYYS4wB0GGw=;
 b=UPItwgMMeHwrcVYCxY5Xk1VI5nQMrRd6/7+A11yQwNhoJKDvVqp6oXa0I419JTi5x+SsG3D+7RX0/n/Mh2TJ0a6n1ZhOlxo+Vcoqfswej7KQ23gMl3ZXntdYMm38mq4oPd+Ks/Jpbm0alQV/w+JbSbo4iQlOjJ51SqxmE3Vrr6OaVEPR1qCUVgG7riQzjEAnX9ljm3ed+hJy7fpgvnl7frm/Xn7ioCH3Blie19j3TEPidIEqZ1WAIKKCM8vwj6xA9ymGSSfOFglO2Jbkvx6l1I0OTigJAXl7CE3haEJKrlsQL4ihBhuHbSpCSOiYtsJJpO+DLbh2IQz3+X53CVdV4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQ25dMuV1y/GtKkLtuyKYav0YH0U66SuxYYS4wB0GGw=;
 b=AZLBd26qyKF3SEnAEMuJGwNuPKc/k1UHeBp6b4oLKOEMcJ/RIhPdlVl2CTSO1mnEVx194Ba3t7FbZhmS7Mr4Nz+oh/bF2DgR8EINbckl3ErI+xB3qlXxVOq8T2a8yu4I6D9OnPkqNIQWImgTaWxuwZYiYSBR9wmgl0cQ2PwBC84=
Received: from PH0P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::22)
 by MW4PR12MB5643.namprd12.prod.outlook.com (2603:10b6:303:188::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 13:00:45 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::a) by PH0P220CA0004.outlook.office365.com
 (2603:10b6:510:d3::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Fri,
 21 Feb 2025 13:00:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 13:00:44 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 07:00:41 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH v2 2/4] drm/amdgpu/gfx11: Implement the GFX11 KCQ pipe reset
Date: Fri, 21 Feb 2025 21:00:28 +0800
Message-ID: <20250221130030.3703750-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221130030.3703750-1-Prike.Liang@amd.com>
References: <20250221130030.3703750-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|MW4PR12MB5643:EE_
X-MS-Office365-Filtering-Correlation-Id: 98175e5a-9b5b-47e7-63ad-08dd5277c10e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?M5+yIJlEJdFXtRHLqA+2Pr5LE6niMRrSnSalZbqrK6wKWnlUsl2FzLklK2ql?=
 =?us-ascii?Q?vhrGrenyxz0OtKXfkoeTI9J9R3g8ofiZdt7jS16rTPOuP/dkzsVhESgq4uCv?=
 =?us-ascii?Q?J5XuWT9jvYdW694cDNISE1JcSA7oEbsM1xIsKIUuCoAv/xqjqmtIFwvnyAC1?=
 =?us-ascii?Q?WVKqtF4ZXbgFeeek74BKePNnJM4symIwHeOHQGkU1e/7KAncDCmwlcvexrrU?=
 =?us-ascii?Q?hbXnunzBvxZNo1soDC6ZI4SET6KA2iPk6Q6b2/mgC5m1qUw2Uz682MA7oiN6?=
 =?us-ascii?Q?/ALxMi2oic7ChebWmIc9qbpIIOVzy8GaBsUTV+Yfr54whLpYtjacvncLw3ya?=
 =?us-ascii?Q?Q2LnujlOz3kB3qsz+teWHkfx4W6FVo7Xt9gy4rzKz9swO0FK4VqpsNUW/gCW?=
 =?us-ascii?Q?0tE1dEEuytZVqgXL5kilKaiCdgdxLynBPiJKbs9XXj00pE9j619HEN791bia?=
 =?us-ascii?Q?d7XqpB/icoZccVNJ1BwBMlFwHHl/M8qI7rTlWHoX8TaBEC8ZiTKOiPh6HObg?=
 =?us-ascii?Q?qKbFqT82OUFbPg2ZeKQRhNfmnbnzDZ5qclQXFkmuyXuECHq46VnAkDMU+244?=
 =?us-ascii?Q?bcaHJrfc4KaSbTl8hgpLHkOIHS6cUwjCu5A26rNMIdmMV+x3e/LyPTv55MEX?=
 =?us-ascii?Q?EPWrFWcATLgoF2N94msumpReNT17pnegBHo9Ys9p/JnW/VitZC6fIsXHL0oE?=
 =?us-ascii?Q?iEaOzBr1nk3sjzNkPTqDhnHV3ifsCE+ywsgO74i8Q2bGusv1R4YooSWmiIcF?=
 =?us-ascii?Q?9wYU8lMjDjbKOVeVXtpeBPYFBIBYbSPzjI4B+WJiRsazyQhu/HdNygKv4ENl?=
 =?us-ascii?Q?grDvy1DDDqjBUtj5G6Mlz9jQ0Vu4eJDDosDTtLq+L1mp7bC2TjBJ+jZuqMx7?=
 =?us-ascii?Q?a8o7/4JT3FUAcum+yctFvxP8bir+RotDHIc8f/1PNvg2CvWGHCRvQ7Sqkodc?=
 =?us-ascii?Q?x4EJpWm9iwm9X2u9lYbajNqytXV/awWEZpdDqxQgtiXa/nbCnpqE69SnRcsM?=
 =?us-ascii?Q?BvAQwGddYM6VT65EBSL5d2JNsIx655QuZrLEzDzDRypyxBW5/pUpDu10eICc?=
 =?us-ascii?Q?FdR7ekk6EgELDr2hZpr0NzMwD+tGRkmUJfKsfcuWVnqBs/suIx3ZnuRXTANH?=
 =?us-ascii?Q?DWkz3WB2eNITa2YriBagzljriIvnF2lPFwPCauzkYsVmHoBDnub/FPQBsTOz?=
 =?us-ascii?Q?CNZ4GVCzLrme+YQnW1MLxFVmZS3/KslMGtF5AhhIOUZDsYOdozhZ5b3+ZcZ9?=
 =?us-ascii?Q?C6mXoyOV3fHwM+9f9/LE+FA9tEfPiwPjlw9U3eLdOgFhSde0eezTS+A46Z+6?=
 =?us-ascii?Q?9B1ekV0sWbI09DNXm1uEMx8831mRU8d5ZF491Cw2JFvTPAmsjTfzs1LJOmGO?=
 =?us-ascii?Q?9ttriirp5YPzl0hkiyD+AT4woZmSyMYfOq1waGzPgqREFN686Wd0ryIBRHAp?=
 =?us-ascii?Q?5p52KEcljR7vESQziX3My07oU1Qj/Mgu1O09vuc8Mhxmb0Lc8zTQaGR4V7AS?=
 =?us-ascii?Q?gdluko72XG2zf0M=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 13:00:44.8447 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98175e5a-9b5b-47e7-63ad-08dd5277c10e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5643
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

Implement the GFX11 compute pipe reset. As the GFX11 CPFW
still hasn't fully supported pipe reset yet, therefore
disable the KCQ pipe reset temporarily.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 135 ++++++++++++++++++++++++-
 1 file changed, 133 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 7e53c0b63f88..000bc455208b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6758,6 +6758,135 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 	return amdgpu_ring_test_ring(ring);
 }
 
+static int gfx_v11_0_reset_compute_pipe(struct amdgpu_ring *ring)
+{
+
+	struct amdgpu_device *adev = ring->adev;
+	uint32_t reset_pipe = 0, clean_pipe = 0;
+	int r;
+
+	if (!gfx_v11_pipe_reset_support(adev))
+		return -EOPNOTSUPP;
+
+	gfx_v11_0_set_safe_mode(adev, 0);
+	mutex_lock(&adev->srbm_mutex);
+	soc21_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
+
+	reset_pipe = RREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL);
+	clean_pipe = reset_pipe;
+
+	if (adev->gfx.rs64_enable) {
+
+		switch (ring->pipe) {
+		case 0:
+			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_RS64_CNTL,
+						   MEC_PIPE0_RESET, 1);
+			clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_RS64_CNTL,
+						   MEC_PIPE0_RESET, 0);
+			break;
+		case 1:
+			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_RS64_CNTL,
+						   MEC_PIPE1_RESET, 1);
+			clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_RS64_CNTL,
+						   MEC_PIPE1_RESET, 0);
+			break;
+		case 2:
+			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_RS64_CNTL,
+						   MEC_PIPE2_RESET, 1);
+			clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_RS64_CNTL,
+						   MEC_PIPE2_RESET, 0);
+			break;
+		case 3:
+			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_RS64_CNTL,
+						   MEC_PIPE3_RESET, 1);
+			clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_RS64_CNTL,
+						   MEC_PIPE3_RESET, 0);
+			break;
+		default:
+			break;
+		}
+		WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, reset_pipe);
+		WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, clean_pipe);
+		r = (RREG32_SOC15(GC, 0, regCP_MEC_RS64_INSTR_PNTR) << 2) - RS64_FW_UC_START_ADDR_LO;
+	} else {
+		if (ring->me == 1) {
+			switch (ring->pipe) {
+			case 0:
+				reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
+							   MEC_ME1_PIPE0_RESET, 1);
+				clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
+							   MEC_ME1_PIPE0_RESET, 0);
+				break;
+			case 1:
+				reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
+							   MEC_ME1_PIPE1_RESET, 1);
+				clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
+							   MEC_ME1_PIPE1_RESET, 0);
+				break;
+			case 2:
+				reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
+							   MEC_ME1_PIPE2_RESET, 1);
+				clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
+							   MEC_ME1_PIPE2_RESET, 0);
+				break;
+			case 3:
+				reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
+							   MEC_ME1_PIPE3_RESET, 1);
+				clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
+							   MEC_ME1_PIPE3_RESET, 0);
+				break;
+			default:
+				break;
+			}
+			/* mec1 fw pc: CP_MEC1_INSTR_PNTR */
+		} else {
+			switch (ring->pipe) {
+			case 0:
+				reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
+							   MEC_ME2_PIPE0_RESET, 1);
+				clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
+							   MEC_ME2_PIPE0_RESET, 0);
+				break;
+			case 1:
+				reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
+							   MEC_ME2_PIPE1_RESET, 1);
+				clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
+							   MEC_ME2_PIPE1_RESET, 0);
+				break;
+			case 2:
+				reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
+							   MEC_ME2_PIPE2_RESET, 1);
+				clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
+							   MEC_ME2_PIPE2_RESET, 0);
+				break;
+			case 3:
+				reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
+							   MEC_ME2_PIPE3_RESET, 1);
+				clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
+							   MEC_ME2_PIPE3_RESET, 0);
+				break;
+			default:
+				break;
+			}
+			/* mec2 fw pc: CP:CP_MEC2_INSTR_PNTR */
+		}
+		WREG32_SOC15(GC, 0, regCP_MEC_CNTL, reset_pipe);
+		WREG32_SOC15(GC, 0, regCP_MEC_CNTL, clean_pipe);
+		r = RREG32(SOC15_REG_OFFSET(GC, 0, regCP_MEC1_INSTR_PNTR));
+	}
+
+	soc21_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+	gfx_v11_0_unset_safe_mode(adev, 0);
+
+	dev_info(adev->dev,"The ring %s pipe resets to MEC FW start PC: %s\n", ring->name,
+			r == 0 ? "successfully" : "failed");
+	/*FIXME:Sometimes driver can't cache the MEC firmware start PC correctly, so the pipe
+	 * reset status relies on the compute ring test result.
+	 */
+	return 0;
+}
+
 static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -6768,8 +6897,10 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
 
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true);
 	if (r) {
-		dev_err(adev->dev, "reset via MMIO failed %d\n", r);
-		return r;
+		dev_warn(adev->dev,"fail(%d) to reset kcq and try pipe reset\n", r);
+		r = gfx_v11_0_reset_compute_pipe(ring);
+		if (r)
+			return r;
 	}
 
 	r = amdgpu_bo_reserve(ring->mqd_obj, false);
-- 
2.34.1

