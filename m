Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE0CDC0218A
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jan 2025 02:46:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9830910E722;
	Wed, 29 Jan 2025 02:46:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o5cifED5";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDBBE10E722
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jan 2025 02:46:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W2hmtybLNWAs4jCzCfvgJ4Ne3ub1iqXTiiXEiJbkbCNaq077evl2b59cWoVfDONBBKtTk78ur7vnIb2UgekNu/3meFMkiYrtdr3tzOKhRP+UmKLmGxKd3X/xmMwxkH9j2j1SA98eQrmdJ+knda0+OdaiHh0ypy8ROsolnjvaPaQLH4aF73CmNrWSRWhkTyptoO3jY+uLXS9xVVYmBs1yEjneDPbDh7+/cl3czsl7VO/o79wSHfbT2pX/Nh6MT0zIoIs1+KcUC+PlShNZenEfNnKOYVJrAKU5AcDrt2oR3qV6yumIuo9nuYy/UY8mCB3h0AWRZ5vurx5UIAo2QGcosw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILx0b3izQYeAk7DzQ76hVhTbIYBZ71lbkGPkLZGVcZw=;
 b=CwxPRjSJdaJdhh0zWkb5f+uvkK5ro1oOpe/G9mcb8zy3UwQvrhMOgfEPrb/lL4P7bDGuBxE/+dI1sqhPQuBMWLZ8JNW2s2hPLZee9F+NfFSIg0yNk4CiptQ2AtFHfkDyFI5SaEK197v3zWf9LqCXVBhZ8SB+ra9hd9/PhTPaf3dW/TBFZOov/WZzn0twfQLGGx04J+1Tl5yAJ2+pcvyfmjb391CF60sNEaDYw++pBpvAMvnrSb5x1YLQHxdQwaUTYkRHITy11klJm6xJQCuU0NVKdcSepBHRqKuCZ+YNWFZi7KG54DmvNQyYYDZQcCNC0AlybUEoJGNoaD+/0GuAQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILx0b3izQYeAk7DzQ76hVhTbIYBZ71lbkGPkLZGVcZw=;
 b=o5cifED5/rU5tLXGdnwTB+CPwwafn7aIYrs4ng9M4HXVWrP8x2+kCKIgwS/jhpGPVqR8Y/SQmVhQgDZ9i6hNUzL2dFMkpXdcO/5KTqfvwL2q+RXzIzuegECUw+Ru07XL8KKTZbDs2iMHgLkziAzl2exYAJZxeTiLeJJOh4R0vuY=
Received: from MN2PR19CA0061.namprd19.prod.outlook.com (2603:10b6:208:19b::38)
 by BY5PR12MB4132.namprd12.prod.outlook.com (2603:10b6:a03:209::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Wed, 29 Jan
 2025 02:46:33 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:208:19b:cafe::3) by MN2PR19CA0061.outlook.office365.com
 (2603:10b6:208:19b::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.17 via Frontend Transport; Wed,
 29 Jan 2025 02:46:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 02:46:32 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 Jan
 2025 20:46:30 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Martin Tsai
 <Martin.Tsai@amd.com>, Anthony Koo <anthony.koo@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 04/10] drm/amd/display: Support multiple options during psr
 entry.
Date: Tue, 28 Jan 2025 19:41:40 -0700
Message-ID: <20250129024432.2107937-5-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129024432.2107937-1-alex.hung@amd.com>
References: <20250129024432.2107937-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|BY5PR12MB4132:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eb2685b-8b77-4618-632e-08dd400f23c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+8SCKPfSK8HevSoKUE7DOgPDfL5EE5Jlexc7M8HQC8bZTDHG0xo47gqD3Hqq?=
 =?us-ascii?Q?HbFLp8sF4rb4mF2x0dPzGuuqZTQGlwj0t6Mydfz6Effz7jWkeur4I/R9YXPH?=
 =?us-ascii?Q?+oSfd7bTW+nBKJNcbITT8Vqa6x/snAB5Phi3nb1KQYDa/RPWAify9+GyLFw+?=
 =?us-ascii?Q?LQ1I6G3Zp11Ogw2UAOD+leuilpTKJSlulcZlR4pyf/aQMYO8TXFpR4TbzIkM?=
 =?us-ascii?Q?E7Xy8aZ59KsJ/qvNOuIGzbZT71A3wTngfbTKsBlZp8asAkIzfbLP+mHILUQ0?=
 =?us-ascii?Q?Xnx2jncgqCzJmU1KV7TZIrIqljXZvuQ4yqBMtm96pBU6YXjkn1V/eYUDxQCd?=
 =?us-ascii?Q?1wzAyITPx2cbIK3dMe/RfmVO9WShPGDNj60BazJC8bNnygqmJsgQwbMpd126?=
 =?us-ascii?Q?2sBon16NpGFj1eljeqUSsIZgErlTjtebFmfl9yyGYkkDGfiNF3Qu3t3ErAJN?=
 =?us-ascii?Q?LLPwMMDhd1cI47Iw2Yh9+mNgTuvmQJmRfJTV6PAlJXPjeXfzwxpTfvZHC0FA?=
 =?us-ascii?Q?l828eXbGqjaOFwjZPjx5NBMjFTO9jROT7/ZFNyrDnxc6qYDDTpghQEfzxoks?=
 =?us-ascii?Q?y5LbDNgA0CNEemHFKRt9a6F3rb+tmGv/OrNYeN2n05DxtjUUYvBfhwdasAXt?=
 =?us-ascii?Q?xDMZT74abEKVpJDFXVRF6sZVhX9Rsu8enMAlILNnbGsn908aXqmuR48qnugQ?=
 =?us-ascii?Q?W8wX0veOcD5YBDHpXVM8oE1lt7bm8sPw1cO00dg9a6Ee36AJVPCXQPVOAm4O?=
 =?us-ascii?Q?s3/RkucrAX1wfhh8CzCIRb/OAA6f3mCWNneRwd7lEhP/XSAU9CNTkxAPsAB+?=
 =?us-ascii?Q?TiHabzyB7L964sKoTj9xa/BjLGLGZ6KPgFISVQGVaM9xPdtikmSY88J/wQez?=
 =?us-ascii?Q?1a/bGCrsXBDG/fKN50zXFCd0BTh/U4t8WZz3WC9uAFje5yGJGryucgRU7/yC?=
 =?us-ascii?Q?yTJ39pblVUgrpvOa4tZqoxVXaM4a1IK6w4CCMKmUDT77mI7sUYKXdufyNiPA?=
 =?us-ascii?Q?lQZrK7PhAZRwEJacpNlGY3MUgun4jjoIF2RJp2D3D5ShcO00gWw1X2K11oEt?=
 =?us-ascii?Q?fhMv/64O36DKrQyQ/g5eilWAv5N+bAKOabq3kzIRAHyNAklUV0sD89eFzGeh?=
 =?us-ascii?Q?STGq22Pw8LO3S9032QY7xjjvLb/ZIs9T9G+f+kt8RegYmHQfxlG0fz3hwujO?=
 =?us-ascii?Q?GS/WKqqxGGilNWBuxcleVpqDuOf/oY/aHX3RDdb69Bl9b1GEo8029Z0du5Ef?=
 =?us-ascii?Q?YHY03JfeWJt/IrcoYWV29tb2lAkRHvvzrPNpMIzVOZGzQV/wPfwClk6QXF0h?=
 =?us-ascii?Q?3oC/AqDjK7qdAz+xrN6oR2Py9J5ju2uHHqkWiapdI9VMOEJ66CcX+969PjfI?=
 =?us-ascii?Q?g0NOw9fyZaXOVVFdCI0HCYspeO2CDxQB9KEohRDMOfxoJe/IC3C7PIIqejGd?=
 =?us-ascii?Q?wfx3D9pVqUsiFBuxDNlMQj5V1dXKJ4VpO6efYtXWgTjFRrJVDc8HnQ/rmGib?=
 =?us-ascii?Q?psEdrEVsiYi129A=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 02:46:32.4351 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb2685b-8b77-4618-632e-08dd400f23c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4132
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

From: Martin Tsai <Martin.Tsai@amd.com>

[WHY]
Some panels may not handle idle pattern properly during PSR entry.

[HOW]
Add a condition to allow multiple options on power down
sequence during PSR1 entry.

Reviewed-by: Anthony Koo <anthony.koo@amd.com>
Signed-off-by: Martin Tsai <Martin.Tsai@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h       | 7 +++++++
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c   | 4 ++++
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 6 ++++++
 3 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 0c2aa91f0a11..e60898c2df01 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1033,6 +1033,13 @@ struct psr_settings {
 	unsigned int psr_sdp_transmit_line_num_deadline;
 	uint8_t force_ffu_mode;
 	unsigned int psr_power_opt;
+
+	/**
+	 * Some panels cannot handle idle pattern during PSR entry.
+	 * To power down phy before disable stream to avoid sending
+	 * idle pattern.
+	 */
+	uint8_t power_down_phy_before_disable_stream;
 };
 
 enum replay_coasting_vtotal_type {
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index 88c75c243bf8..ff3b8244ba3d 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -418,6 +418,10 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 	copy_settings_data->relock_delay_frame_cnt = 0;
 	if (link->dpcd_caps.sink_dev_id == DP_BRANCH_DEVICE_ID_001CF8)
 		copy_settings_data->relock_delay_frame_cnt = 2;
+
+	copy_settings_data->power_down_phy_before_disable_stream =
+		link->psr_settings.power_down_phy_before_disable_stream;
+
 	copy_settings_data->dsc_slice_height = psr_context->dsc_slice_height;
 
 	dc_wake_and_execute_dmub_cmd(dc, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index d0fe324cb537..8cf89aed024b 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -3118,6 +3118,12 @@ struct dmub_cmd_psr_copy_settings_data {
 	 * Some panels request main link off before xth vertical line
 	 */
 	uint16_t poweroff_before_vertical_line;
+	/**
+	 * Some panels cannot handle idle pattern during PSR entry.
+	 * To power down phy before disable stream to avoid sending
+	 * idle pattern.
+	 */
+	uint8_t power_down_phy_before_disable_stream;
 };
 
 /**
-- 
2.43.0

