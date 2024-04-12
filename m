Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0414AC00A94
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Apr 2024 12:54:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A28310F60F;
	Fri, 12 Apr 2024 12:54:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fie9gY5V";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AF9110F60F
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Apr 2024 12:54:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jW/uZbe2C1/+wd5pULZQruTbdoose2EM191330BAhSXzQu0sIttW82juGLFTvWdZB57LID724KrRT/gSVNynI9SSIHZIuOz1Sbmq5HL/6QElp012/kjGGcmMM20wzKD95GBVo1WO2l6qSWQt3sfp4Ow03zn1y0wk+Drk2tO08Kz26xOELtT78NpJima4pBMF1gm7+89x8XsL1OncUcVViuDpIVE0mCnqwd2KgcrR9HoB6aA38xHCaBXOmV6mWAW3/73oulhsyKmEpmnzOtchTdwfMkM+LlnopQspZQARaq0Baf/qoLwmxQJCOv6fIKJiFpjyNRHdUm2iYp01Ele0EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DUx1JJMJY4Z1cDlHFjZS1yQro0ztnYVSLVivxpXZn8U=;
 b=hE5CsUimeOsZdIzZqDKD41mj26Jo7rKCheleIvC65SCFUFybCy7gCKIc5LtmHK7IgXTaR01QMiaMjCyDunB5SM7WIGzCORSOQqoIFcSLdAn8xWCaae9gzyNs/OlpLETL+tt6L9RKN3+l34j92ZXbUUW4cg7umDJnB2CQUi/PtKmFcwlRg52RlLsancP4KKNn2pqxggauiNExCqVVD/1cGsJG9SN15m363urW9HVjZ58UsVa+N3RKZykSnVmhQLTdshk0L2W6Fr1a7vtwn3yoc+bBlwM5ApfeQFkl8Brj0Ot8m2MH+ToNV4eDWN6B6c2KMT7tuLVXN1xa4TNlVG8cNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUx1JJMJY4Z1cDlHFjZS1yQro0ztnYVSLVivxpXZn8U=;
 b=fie9gY5VXkSlHsstq5MkhXlM4O1ATQvE7yKNPLXeY2J1Mbkh2Thob8WTQkWtG0h3rienQglZzUfNZCPcMXpEmqcmaLv1fL2PosP79HB+pVdqHGAkKuivDIzBko1VlDURcG9/2ThCaz3Rr819xT1CK5oMk5f2sJPodbMLuSpW6Z4=
Received: from MN2PR22CA0029.namprd22.prod.outlook.com (2603:10b6:208:238::34)
 by SJ2PR12MB8110.namprd12.prod.outlook.com (2603:10b6:a03:4fc::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 12:54:11 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:208:238:cafe::32) by MN2PR22CA0029.outlook.office365.com
 (2603:10b6:208:238::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26 via Frontend
 Transport; Fri, 12 Apr 2024 12:54:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 12 Apr 2024 12:54:10 +0000
Received: from khazad-dum.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 12 Apr
 2024 07:54:01 -0500
From: Lancelot SIX <lancelot.six@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Jonathan.Kim@amd.com>, Lancelot SIX <lancelot.six@amd.com>
Subject: [PATCH] drm/amdkfd: Enable SQ watchpoint for gfx10
Date: Fri, 12 Apr 2024 13:53:33 +0100
Message-ID: <20240412125333.257946-1-lancelot.six@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|SJ2PR12MB8110:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e20ae9d-90b9-4a2e-5731-08dc5aefa5e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HmZPlJySkbVXGMwIz1EFCoWGAzB6C+RcMrtfITIloU+Pfin2y/v8rCKo+6R0UW0fDpNHtSZsHjcXUXNcS8V9+ElViyPo4lssiireMKQTtTwFOVcR3o5JqftZlDnFHOzXpiSw7pBkQ8k7/FkyG0gWv4iqBGp+GpvDZNnIcD+LpjcIJkZheFAtbdr6DyK+FVB3YlseVTOVz4RUzWtfiAdxUVCHvKlTnCfSWVeScthtn7SAcD3i9B8Fau4MkS8dzHflJBRvxpOmdx3Om824Wnf9si1Sn1Kheo1pZ92ArmltLqnNijQlcgDz115KMV56XRGWTPtLhnipXmidJYiUJIr9Jx9RG6qG6lXJcWFLunB6urwoR4/QJeoYs6ZIgiAZerqD7eDjOt6qwrBShP9NLBr6wqmnWMrNTKP5P78X4Vkd5L4HAK+qFMYdd9E5LpoG8IR7BCZ5VU8j94/VkAGrh63XarOCjsSH/iaZXWUrSrvq0iIW0AYdvp6MpY2iAcmPCMj8leZoXUGjUXGheOSuWixCDP3xIHKCn2/j1SpHFixcxsbPvmfR4aaDw68rT8urGGw3bfOw6W+onBJJFtnHVoT4rmqUwxbMFAno32r+z3V2a2WQDKInXiu8YpiZRMYaBGl48Uoj9n7qmDXH3AuUTGY3dRxFdWSHRbfjUyxzhOPwLYBEz4ZDBGZOrTQISSub96fEuC/vLVVhH9MZsJmOwVV2B54hcoKdXuKnfqNZ+5g3+ROA/z+cO2MWcuFa5kqD74kb
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 12:54:10.6516 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e20ae9d-90b9-4a2e-5731-08dc5aefa5e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8110
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

There are new control registers introduced in gfx10 used to configure
hardware watchpoints triggered by SMEM instructions:
SQ_WATCH{0,1,2,3}_{CNTL_ADDR_HI,ADDR_L}.

Those registers work in a similar way as the TCP_WATCH* registers
currently used for gfx9 and above.

This patch adds support to program the SQ_WATCH registers for gfx10.

The SQ_WATCH?_CNTL.MASK field has one bit more than
TCP_WATCH?_CNTL.MASK, so SQ watchpoints can have a finer granularity
than TCP_WATCH watchpoints.  In this patch, we keep the capabilities
advertised to the debugger unchanged
(HSA_DBG_WATCH_ADDR_MASK_*_BIT_GFX10) as this reflects what both TCP and
SQ watchpoints can do and both watchpoints are configured together.

Signed-off-by: Lancelot SIX <lancelot.six@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    | 71 +++++++++++++++----
 1 file changed, 58 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 69810b3f1c63..3ab6c3aa0ad1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -881,6 +881,7 @@ uint32_t kgd_gfx_v10_set_wave_launch_mode(struct amdgpu_device *adev,
 }
 
 #define TCP_WATCH_STRIDE (mmTCP_WATCH1_ADDR_H - mmTCP_WATCH0_ADDR_H)
+#define SQ_WATCH_STRIDE (mmSQ_WATCH1_ADDR_H - mmSQ_WATCH0_ADDR_H)
 uint32_t kgd_gfx_v10_set_address_watch(struct amdgpu_device *adev,
 					uint64_t watch_address,
 					uint32_t watch_address_mask,
@@ -889,55 +890,93 @@ uint32_t kgd_gfx_v10_set_address_watch(struct amdgpu_device *adev,
 					uint32_t debug_vmid,
 					uint32_t inst)
 {
+	/* SQ_WATCH?_ADDR_* and TCP_WATCH?_ADDR_* are programmed with the
+	 * same values.
+	 */
 	uint32_t watch_address_high;
 	uint32_t watch_address_low;
-	uint32_t watch_address_cntl;
-
-	watch_address_cntl = 0;
+	uint32_t tcp_watch_address_cntl;
+	uint32_t sq_watch_address_cntl;
 
 	watch_address_low = lower_32_bits(watch_address);
 	watch_address_high = upper_32_bits(watch_address) & 0xffff;
 
-	watch_address_cntl = REG_SET_FIELD(watch_address_cntl,
+	tcp_watch_address_cntl = 0;
+	tcp_watch_address_cntl = REG_SET_FIELD(tcp_watch_address_cntl,
 			TCP_WATCH0_CNTL,
 			VMID,
 			debug_vmid);
-	watch_address_cntl = REG_SET_FIELD(watch_address_cntl,
+	tcp_watch_address_cntl = REG_SET_FIELD(tcp_watch_address_cntl,
 			TCP_WATCH0_CNTL,
 			MODE,
 			watch_mode);
-	watch_address_cntl = REG_SET_FIELD(watch_address_cntl,
+	tcp_watch_address_cntl = REG_SET_FIELD(tcp_watch_address_cntl,
 			TCP_WATCH0_CNTL,
 			MASK,
 			watch_address_mask >> 7);
 
+	sq_watch_address_cntl = 0;
+	sq_watch_address_cntl = REG_SET_FIELD(sq_watch_address_cntl,
+			SQ_WATCH0_CNTL,
+			VMID,
+			debug_vmid);
+	sq_watch_address_cntl = REG_SET_FIELD(sq_watch_address_cntl,
+			SQ_WATCH0_CNTL,
+			MODE,
+			watch_mode);
+	sq_watch_address_cntl = REG_SET_FIELD(sq_watch_address_cntl,
+			SQ_WATCH0_CNTL,
+			MASK,
+			watch_address_mask >> 6);
+
 	/* Turning off this watch point until we set all the registers */
-	watch_address_cntl = REG_SET_FIELD(watch_address_cntl,
+	tcp_watch_address_cntl = REG_SET_FIELD(tcp_watch_address_cntl,
 			TCP_WATCH0_CNTL,
 			VALID,
 			0);
-
 	WREG32((SOC15_REG_OFFSET(GC, 0, mmTCP_WATCH0_CNTL) +
 			(watch_id * TCP_WATCH_STRIDE)),
-			watch_address_cntl);
+			tcp_watch_address_cntl);
+
+	sq_watch_address_cntl = REG_SET_FIELD(sq_watch_address_cntl,
+			SQ_WATCH0_CNTL,
+			VALID,
+			0);
+	WREG32((SOC15_REG_OFFSET(GC, 0, mmSQ_WATCH0_CNTL) +
+			(watch_id * SQ_WATCH_STRIDE)),
+			sq_watch_address_cntl);
 
+	/* Program {TCP,SQ}_WATCH?_ADDR* */
 	WREG32((SOC15_REG_OFFSET(GC, 0, mmTCP_WATCH0_ADDR_H) +
 			(watch_id * TCP_WATCH_STRIDE)),
 			watch_address_high);
-
 	WREG32((SOC15_REG_OFFSET(GC, 0, mmTCP_WATCH0_ADDR_L) +
 			(watch_id * TCP_WATCH_STRIDE)),
 			watch_address_low);
 
+	WREG32((SOC15_REG_OFFSET(GC, 0, mmSQ_WATCH0_ADDR_H) +
+			(watch_id * SQ_WATCH_STRIDE)),
+			watch_address_high);
+	WREG32((SOC15_REG_OFFSET(GC, 0, mmSQ_WATCH0_ADDR_L) +
+			(watch_id * SQ_WATCH_STRIDE)),
+			watch_address_low);
+
 	/* Enable the watch point */
-	watch_address_cntl = REG_SET_FIELD(watch_address_cntl,
+	tcp_watch_address_cntl = REG_SET_FIELD(tcp_watch_address_cntl,
 			TCP_WATCH0_CNTL,
 			VALID,
 			1);
-
 	WREG32((SOC15_REG_OFFSET(GC, 0, mmTCP_WATCH0_CNTL) +
 			(watch_id * TCP_WATCH_STRIDE)),
-			watch_address_cntl);
+			tcp_watch_address_cntl);
+
+	sq_watch_address_cntl = REG_SET_FIELD(sq_watch_address_cntl,
+			SQ_WATCH0_CNTL,
+			VALID,
+			1);
+	WREG32((SOC15_REG_OFFSET(GC, 0, mmSQ_WATCH0_CNTL) +
+			(watch_id * SQ_WATCH_STRIDE)),
+			sq_watch_address_cntl);
 
 	return 0;
 }
@@ -953,8 +992,14 @@ uint32_t kgd_gfx_v10_clear_address_watch(struct amdgpu_device *adev,
 			(watch_id * TCP_WATCH_STRIDE)),
 			watch_address_cntl);
 
+	WREG32((SOC15_REG_OFFSET(GC, 0, mmSQ_WATCH0_CNTL) +
+			(watch_id * SQ_WATCH_STRIDE)),
+			watch_address_cntl);
+
 	return 0;
 }
+#undef TCP_WATCH_STRIDE
+#undef SQ_WATCH_STRIDE
 
 
 /* kgd_gfx_v10_get_iq_wait_times: Returns the mmCP_IQ_WAIT_TIME1/2 values

base-commit: fd1be4972efe2c3f1183404572c34e2b5549c07e
-- 
2.34.1

