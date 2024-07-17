Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B687C3DA62
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 19:39:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D27AE10E3AA;
	Wed, 17 Jul 2024 19:39:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i3bTgT32";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD3E610E3AA
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 19:39:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ffff+nhn6xIvMiUYDJzpkyQ2OWZ5dklFKId/JJB5tr6kDPn/scRc32OROL2qrmr5Mz4mTKwSJCNdA6vloUDNDO7iPWjIp2gXFWxva6c4NtTHxTV2C8PpS8I39rSZ+AipxC6PWHeuLbGOivME0RG2gFBsuqIeAKbZcdSVRXILfDV3F/pCCMS+bQCzH8/mCV5l/auz22jWsxHa/O4ly6zNtn7sB1b96dGpZ3LYQnKzWLP0StLcqFZWKb8OuGFTqheybmqny7Eta+tZ+kqugXcJXPNpQMgBHVM/lA7Vhpjg2qHE+UfDKfIPZVTf1SiAdPJxnM8f68wEyegIxtvEncav4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osb6XWF/2/gYGJ58Qshzc2logB6IghM+09FGbD3FnRI=;
 b=QiOETLH6br+ntFWPLkmW0WDrQUDLQvkLJXV60mO6cxth57ttntGqVlXW9MVBT/sq8dpnLRDSro8YTUS7VCr+PnUdbZMmUPXrkkDT6hs6NdkI7Nd4yzRWGxWBhRLDmcSPtgLVUnwQJ35eWJLUgHbGb+tWacfVvdUKwbDmgRJJrFqoggAY2bTD/Z+xag68NnUFrljC0+MIE+BxCQGSK0bLbe1BvkKvoN1YH9IrLy0GS69zHUJsQAX2xZsz41RYDQzB6/EXpjBkB3aDmAHWV+jdZVIcV/VDrHg1za6/W3+xQHgeb/S6X2cYZ6hDV746rIa/cxSGDz4g/VLrs2nJi3/xvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osb6XWF/2/gYGJ58Qshzc2logB6IghM+09FGbD3FnRI=;
 b=i3bTgT32sKQtZJ74iZq0A7M7hQiuJXq3tWXFHqFzumhxRDEBLft6DSErYS3Lv+p6Mxrajp9i/NYtSaYXWrgqc0kcIJLjQpGmZMlFoadejIBr7emdqoAb1kTdrZYxBDY7rK+a+I/MnwOsfppxXo6IiNCLMLfFfvgWvk+cKDtpRb8=
Received: from MW4P223CA0017.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::22)
 by SA3PR12MB7952.namprd12.prod.outlook.com (2603:10b6:806:316::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Wed, 17 Jul
 2024 19:39:49 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com (2603:10b6:303:80::4)
 by MW4P223CA0017.outlook.office365.com (2603:10b6:303:80::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.29 via Frontend Transport; Wed, 17 Jul 2024 19:39:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 19:39:48 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 14:39:47 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 14:39:47 -0500
Received: from debian.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 17 Jul 2024 14:39:41 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Hansen Dsouza
 <hansen.dsouza@amd.com>, Daniel Miess <daniel.miess@amd.com>, Muhammad Ahmed
 <ahmed.ahmed@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: [PATCH 06/22] drm/amd/display: Add RCG helper functions
Date: Wed, 17 Jul 2024 19:38:45 +0000
Message-ID: <20240717193901.8821-7-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240717193901.8821-1-aurabindo.pillai@amd.com>
References: <20240717193901.8821-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|SA3PR12MB7952:EE_
X-MS-Office365-Filtering-Correlation-Id: dcc616ac-a892-41d3-6b84-08dca698381f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?63gn77luMf80+lqRPx6xhSosZWp58qx5ep8CiT3k1N4smfZQJJNGgIx7tOhv?=
 =?us-ascii?Q?XgNy1DI2jiQClqY3fcrY/QshqWhpV4itQMu0pZecT8iei1n/mIKOMVDR4ISe?=
 =?us-ascii?Q?gzwPwkGunNi6nm1s/kwYW3Ndipqna2gzmcrVb5FveYgzOcNeb6Elgf/tcUHK?=
 =?us-ascii?Q?5/bfMT6mBHFxd2Zgb4rpkytdE0xFE1+dWm4FCJS+19V/wYl7n3DRRfwYgYAn?=
 =?us-ascii?Q?+5HpQMgcOEFKCxmWLPTKl+cg11ZluF9r4rLXH21xE2WO4DI97dRM1qunf9zg?=
 =?us-ascii?Q?3LdBfs7BlTq7EvLOulofwQ1gELzsGn7BVMxTWGnFo/qhaeu3IB1nDjHlTaRt?=
 =?us-ascii?Q?Hh+tcexkrQhk57lz9P25/M+Cx6dmIsE+ZiPePVYCtMNfDCEzXgoku2D8j5v4?=
 =?us-ascii?Q?nRBjWicN3h9L9sBps+GZZkMrYZNWNaEq067nfcYXoYxyzE5kA/08I0FjbwIo?=
 =?us-ascii?Q?j/KmtDGfUVzI6wBgejRjWfEgiGMzN2Qda6s03sQ0j32r4OTEDNNqeWiYcYa/?=
 =?us-ascii?Q?Cha6oAme5LujXiPxOioN/CvKXPBpYTw54KdDyFDXER/9yJz8By7tj3MvUjGr?=
 =?us-ascii?Q?o6GKE7k2xm9BYIQnpSHw1dioCXFMMwXnIU2MkDzaXIrjkr17wyKLTUsUwFAG?=
 =?us-ascii?Q?9nqmnnpaSVLJlUyJxShOMtvD2bS7TupWEjLewJE5CE8nMMaOnfYAIPxukN5x?=
 =?us-ascii?Q?sZUlaWeAZB3bz6i8sAAQux0cuY3t3Ro5pFtOy0woZa2hOdPj0JPNq3RDW546?=
 =?us-ascii?Q?fhzB+hNA3AEzgQ1YxTceKsB22BqJLv8GKOAI6xz/+vRV4pDMZ2I57f68gXsw?=
 =?us-ascii?Q?HpWK5fvw6IRTIw610b1dzSBsOquHAVvr8RGrd5ksTZTE7y/zOQO3RUZajMeA?=
 =?us-ascii?Q?iKM545TcukLdfhZfk12AUaG5WKp5rtl/1j14hevYZzmBVEqOxEKAikQDoh3F?=
 =?us-ascii?Q?rcttljyobA42xAjgw2V4+nV3/nVlDQ8OSTGs2eN+/yUVxo7aOGXWTzaq5TVc?=
 =?us-ascii?Q?FySw+jo7uK1nTUNzXjwkv+QwfKEv5hXAcL2tIRFXU+7kYC1AAqRSCqwQXeqe?=
 =?us-ascii?Q?RdVCmHFeM9lbShJMz0eXdN4h37DgcpEZyrxRwHyMAw+gNJpMD+PlUvZVLiGY?=
 =?us-ascii?Q?XfPdig0scg1xIj8evhGMU9GgAruGMXz8Y/D9MAWrRp2+/v9NuwKEpVCEMHos?=
 =?us-ascii?Q?hVDzOOuijD5Fc7+Bm1SR/6OLVuiHV7zjyAFL3aEeiGg5VIioeceAUPu08X4R?=
 =?us-ascii?Q?+rTQ24WGCyTd5+zvqq3M/KfkAHRqOlyzwXhkWGjZHoUfH0+R2lpBT8zhsYZC?=
 =?us-ascii?Q?yzIX4p3HUyFqVVAsKBXRD7Q/wxqrVnEVhg/eey72Ub75lPM++hmmcTurQMV0?=
 =?us-ascii?Q?cdUYvMUMyiRcKaC8XjF6cwwm7Br3D++OZCcu2MjbEcxtlGFGcNTPKZYpmiCn?=
 =?us-ascii?Q?K7a56/avrA2KuwMUElQesTo/vAVqmCvH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 19:39:48.5028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc616ac-a892-41d3-6b84-08dca698381f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7952
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

From: Hansen Dsouza <hansen.dsouza@amd.com>

[why & how]
Add standard RCG helpers based on DCCG spec

Reviewed-by: Daniel Miess <daniel.miess@amd.com>
Reviewed-by: Muhammad Ahmed <ahmed.ahmed@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Hansen Dsouza <hansen.dsouza@amd.com>
---
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    | 307 ++++++++++++++++++
 1 file changed, 307 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
index 64b25e5d9d7a..76f069f703ef 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
@@ -122,6 +122,302 @@ enum dsc_clk_source {
 	DSC_DTO_TUNED_CK_GPU_DISCLK_3,	// DTO divided clock selected as functional clock
 };
 
+
+static void dccg35_set_dsc_clk_rcg(struct dccg *dccg, int inst, bool enable)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	if (!dccg->ctx->dc->debug.root_clock_optimization.bits.dsc)
+		return;
+
+	switch (inst) {
+	case 0:
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL6, DSCCLK0_ROOT_GATE_DISABLE, enable ? 0 : 1);
+		break;
+	case 1:
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL6, DSCCLK1_ROOT_GATE_DISABLE, enable ? 0 : 1);
+		break;
+	case 2:
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL6, DSCCLK2_ROOT_GATE_DISABLE, enable ? 0 : 1);
+		break;
+	case 3:
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL6, DSCCLK3_ROOT_GATE_DISABLE, enable ? 0 : 1);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+}
+
+static void dccg35_set_symclk32_se_rcg(
+	struct dccg *dccg,
+	int inst,
+	bool enable)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	if (!dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se)
+		return;
+
+	/* SYMCLK32_ROOT_SE#_GATE_DISABLE will clock gate in DCCG */
+	/* SYMCLK32_SE#_GATE_DISABLE will clock gate in HPO only */
+	switch (inst) {
+	case 0:
+		REG_UPDATE_2(DCCG_GATE_DISABLE_CNTL3,
+				   SYMCLK32_SE0_GATE_DISABLE, enable ? 0 : 1,
+				   SYMCLK32_ROOT_SE0_GATE_DISABLE, enable ? 0 : 1);
+		break;
+	case 1:
+		REG_UPDATE_2(DCCG_GATE_DISABLE_CNTL3,
+				   SYMCLK32_SE1_GATE_DISABLE, enable ? 0 : 1,
+				   SYMCLK32_ROOT_SE1_GATE_DISABLE, enable ? 0 : 1);
+		break;
+	case 2:
+		REG_UPDATE_2(DCCG_GATE_DISABLE_CNTL3,
+				   SYMCLK32_SE2_GATE_DISABLE, enable ? 0 : 1,
+				   SYMCLK32_ROOT_SE2_GATE_DISABLE, enable ? 0 : 1);
+		break;
+	case 3:
+		REG_UPDATE_2(DCCG_GATE_DISABLE_CNTL3,
+				   SYMCLK32_SE3_GATE_DISABLE, enable ? 0 : 1,
+				   SYMCLK32_ROOT_SE3_GATE_DISABLE, enable ? 0 : 1);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+}
+
+static void dccg35_set_symclk32_le_rcg(
+	struct dccg *dccg,
+	int inst,
+	bool enable)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	if (!dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_le)
+		return;
+
+	switch (inst) {
+	case 0:
+		REG_UPDATE_2(DCCG_GATE_DISABLE_CNTL3,
+				   SYMCLK32_LE0_GATE_DISABLE, enable ? 0 : 1,
+				   SYMCLK32_ROOT_LE0_GATE_DISABLE, enable ? 0 : 1);
+		break;
+	case 1:
+		REG_UPDATE_2(DCCG_GATE_DISABLE_CNTL3,
+				   SYMCLK32_LE1_GATE_DISABLE, enable ? 0 : 1,
+				   SYMCLK32_ROOT_LE1_GATE_DISABLE, enable ? 0 : 1);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+}
+
+static void dccg35_set_physymclk_rcg(
+	struct dccg *dccg,
+	int inst,
+	bool enable)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	if (!dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
+		return;
+
+	switch (inst) {
+	case 0:
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
+				PHYASYMCLK_ROOT_GATE_DISABLE, enable ? 0 : 1);
+		break;
+	case 1:
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
+				PHYBSYMCLK_ROOT_GATE_DISABLE, enable ? 0 : 1);
+		break;
+	case 2:
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
+				PHYCSYMCLK_ROOT_GATE_DISABLE, enable ? 0 : 1);
+		break;
+	case 3:
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
+				PHYDSYMCLK_ROOT_GATE_DISABLE, enable ? 0 : 1);
+		break;
+	case 4:
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
+				PHYESYMCLK_ROOT_GATE_DISABLE, enable ? 0 : 1);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+}
+
+static void dccg35_set_physymclk_fe_rcg(
+		struct dccg *dccg,
+		int inst,
+		bool enable)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	if (!dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
+		return;
+
+	switch (inst) {
+	case 0:
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL5,
+				SYMCLKA_FE_ROOT_GATE_DISABLE, enable ? 0 : 1);
+		break;
+	case 1:
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL5,
+				SYMCLKB_FE_ROOT_GATE_DISABLE, enable ? 0 : 1);
+		break;
+	case 2:
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL5,
+				SYMCLKC_FE_ROOT_GATE_DISABLE, enable ? 0 : 1);
+		break;
+	case 3:
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL5,
+				SYMCLKD_FE_ROOT_GATE_DISABLE, enable ? 0 : 1);
+		break;
+	case 4:
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL5,
+				SYMCLKE_FE_ROOT_GATE_DISABLE, enable ? 0 : 1);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+}
+
+static void dccg35_set_dtbclk_p_rcg(struct dccg *dccg, int inst, bool enable)
+{
+
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	if (!dccg->ctx->dc->debug.root_clock_optimization.bits.dpp)
+		return;
+
+	switch (inst) {
+	case 0:
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, DTBCLK_P0_GATE_DISABLE, enable ? 0 : 1);
+		break;
+	case 1:
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, DTBCLK_P1_GATE_DISABLE, enable ? 0 : 1);
+		break;
+	case 2:
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, DTBCLK_P2_GATE_DISABLE, enable ? 0 : 1);
+		break;
+	case 3:
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, DTBCLK_P3_GATE_DISABLE, enable ? 0 : 1);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		break;
+	}
+}
+
+static void dccg35_set_dppclk_rcg(struct dccg *dccg,
+												int inst, bool enable)
+{
+
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	if (!dccg->ctx->dc->debug.root_clock_optimization.bits.dpp)
+		return;
+
+	switch (inst) {
+	case 0:
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL6, DPPCLK0_ROOT_GATE_DISABLE, enable ? 0 : 1);
+		break;
+	case 1:
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL6, DPPCLK1_ROOT_GATE_DISABLE, enable ? 0 : 1);
+		break;
+	case 2:
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL6, DPPCLK2_ROOT_GATE_DISABLE, enable ? 0 : 1);
+		break;
+	case 3:
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL6, DPPCLK3_ROOT_GATE_DISABLE, enable ? 0 : 1);
+		break;
+	default:
+	BREAK_TO_DEBUGGER();
+		break;
+	}
+}
+
+static void dccg35_set_dpstreamclk_rcg(
+	struct dccg *dccg,
+	int inst,
+	bool enable)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	if (!dccg->ctx->dc->debug.root_clock_optimization.bits.dpstream)
+		return;
+
+	switch (inst) {
+	case 0:
+		REG_UPDATE_2(DCCG_GATE_DISABLE_CNTL5,
+					 DPSTREAMCLK0_GATE_DISABLE, enable ? 0 : 1,
+					 DPSTREAMCLK0_ROOT_GATE_DISABLE, enable ? 0 : 1);
+		break;
+	case 1:
+		REG_UPDATE_2(DCCG_GATE_DISABLE_CNTL5,
+					 DPSTREAMCLK1_GATE_DISABLE, enable ? 0 : 1,
+					 DPSTREAMCLK1_ROOT_GATE_DISABLE, enable ? 0 : 1);
+		break;
+	case 2:
+		REG_UPDATE_2(DCCG_GATE_DISABLE_CNTL5,
+				   DPSTREAMCLK2_GATE_DISABLE, enable ? 0 : 1,
+				   DPSTREAMCLK2_ROOT_GATE_DISABLE, enable ? 0 : 1);
+		break;
+	case 3:
+		REG_UPDATE_2(DCCG_GATE_DISABLE_CNTL5,
+				   DPSTREAMCLK3_GATE_DISABLE, enable ? 0 : 1,
+				   DPSTREAMCLK3_ROOT_GATE_DISABLE, enable ? 0 : 1);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+}
+
+static void dccg35_set_smclk32_se_rcg(
+		struct dccg *dccg,
+		int inst,
+		bool enable)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	if (!dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se)
+		return;
+
+	switch (inst) {
+	case 0:
+		REG_UPDATE_2(DCCG_GATE_DISABLE_CNTL3,
+					 SYMCLK32_SE0_GATE_DISABLE, enable ? 0 : 1,
+					 SYMCLK32_ROOT_SE0_GATE_DISABLE, enable ? 0 : 1);
+		break;
+	case 1:
+		REG_UPDATE_2(DCCG_GATE_DISABLE_CNTL3,
+					 SYMCLK32_SE1_GATE_DISABLE, enable ? 0 : 1,
+					 SYMCLK32_ROOT_SE1_GATE_DISABLE, enable ? 0 : 1);
+		break;
+	case 2:
+		REG_UPDATE_2(DCCG_GATE_DISABLE_CNTL3,
+					 SYMCLK32_SE2_GATE_DISABLE, enable ? 0 : 1,
+					 SYMCLK32_ROOT_SE2_GATE_DISABLE, enable ? 0 : 1);
+		break;
+	case 3:
+		REG_UPDATE_2(DCCG_GATE_DISABLE_CNTL3,
+					 SYMCLK32_SE3_GATE_DISABLE, enable ? 0 : 1,
+					 SYMCLK32_ROOT_SE3_GATE_DISABLE, enable ? 0 : 1);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+}
+
 static void dccg35_trigger_dio_fifo_resync(struct dccg *dccg)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
@@ -1123,6 +1419,17 @@ struct dccg *dccg35_create(
 		return NULL;
 	}
 
+	/* Temporary declaration to handle unused static functions */
+	(void)&dccg35_set_dsc_clk_rcg;
+	(void)&dccg35_set_symclk32_se_rcg;
+	(void)&dccg35_set_symclk32_le_rcg;
+	(void)&dccg35_set_physymclk_rcg;
+	(void)&dccg35_set_physymclk_fe_rcg;
+	(void)&dccg35_set_dtbclk_p_rcg;
+	(void)&dccg35_set_dppclk_rcg;
+	(void)&dccg35_set_dpstreamclk_rcg;
+	(void)&dccg35_set_smclk32_se_rcg;
+
 	base = &dccg_dcn->base;
 	base->ctx = ctx;
 	base->funcs = &dccg35_funcs;
-- 
2.39.2

