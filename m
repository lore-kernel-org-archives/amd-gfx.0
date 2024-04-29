Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5ED6C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 06:48:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24A0610E58E;
	Mon, 29 Apr 2024 06:48:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dVcT9/Gr";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D40BB10E58E
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 06:48:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bRoC0/Qc3gu7XR2BSUJDhkSx3gUJH/CpSzmhU1WiAA4xX6YR4zFEwD+k/W87hxGhBdwzIutmref2rN6VfTmfJRy98SwH1d/CbybZ55UsCdk/KL9vw2gUnK2JRIa3P5IN3GJzzN45uTpum5ZPmTck18884cZCMVFo+8etmNfvceAZCKytwm6lR1d6ayBk6+hSMMfmpq1WYSLwQS4W/3SVX4SqQKUBXWOkKw4CcBHTpO2F6eJ5wqd96wCnXbq6RIPEFpzc/rNnPPgcOQZiCly6DKqRBOe0xvruYkzYrmPPUv1wvV8byGQPbtlPfczdsFcLOli4CRYRP+kR3SunTI+Ksw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x4qBpt/y+CxIqhLUK0xae9kSoZ9SP6ZNoP0YqpTVhTA=;
 b=N5mhKa8YQOU28BKB7Ftx/iMLah8V9fv51cZfEbZZfLDEaFhk6qg7pWz1osaPb8a+QxOaW74GjIvJxgRx75l4vI9YCeyHJXMjUCYBkM7fJaWpTAHCh0ZnF2SmE7nGRZbsoVSF4q0I3PYBgwxPaAmDGgxrLeS1CBVH92D1MpuQcsHdkv6S6RGtFC3ejUhykWvyh5akgAdJAnYyo9lPJysuIF0xP7ylevG+nAQdvjwdI8EDemViL4n2v8Ch2wyuzAH0nB8r9PZwdvJeU4W7eKI+W1t3ITnRrshKDb8kF/xxID7yCh29MUw+s6kr+xAr0ZHpKkwV6ardSWi2XqlsXk/T3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4qBpt/y+CxIqhLUK0xae9kSoZ9SP6ZNoP0YqpTVhTA=;
 b=dVcT9/Grg0rXkDS9e4FN7gAmP06lloXpF7Z+dF0gotg/JRwRCZmWpDBPGTrzcG3zkYsGBX8Mk31dtImM1FOctVJROhJeB15+u7HXsBBuJ4G8u42cjESGsecspEp7TTV/QDZYYYwfjQyIczpDKV4fhAqfSuC3FubxusvwUwKTKHs=
Received: from MW4PR04CA0377.namprd04.prod.outlook.com (2603:10b6:303:81::22)
 by SJ2PR12MB7962.namprd12.prod.outlook.com (2603:10b6:a03:4c2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 06:48:39 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:303:81:cafe::7f) by MW4PR04CA0377.outlook.office365.com
 (2603:10b6:303:81::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34 via Frontend
 Transport; Mon, 29 Apr 2024 06:48:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 06:48:38 +0000
Received: from Peytolee-HPDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 01:48:36 -0500
From: Peyton Lee <peytolee@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Lang Yu <lang.yu@amd.com>, "Alan
 Liu" <haoping.liu@amd.com>, Peyton Lee <peytolee@amd.com>
Subject: [PATCH] drm/amdgpu/vpe: fix vpe dpm clk ratio setup failed
Date: Mon, 29 Apr 2024 14:52:45 +0800
Message-ID: <20240429065245.166647-1-peytolee@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|SJ2PR12MB7962:EE_
X-MS-Office365-Filtering-Correlation-Id: b784f1f5-964a-4110-e24c-08dc681866b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400014|36860700004|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Er6ZrKycBWO5j75pNOmlK1eao1lsXY94ays3gF9kIEWM29iMpeev96BL/AO8?=
 =?us-ascii?Q?rDuXcrE2MKFl/3tsvk36S/npYHfRjNsFu5c45nHsBBOp+MCage4W9frZDWyB?=
 =?us-ascii?Q?69YyHdIKBVIHHIkvriNsaifop7tLofGktHOZkzFy/bb7LDOEga+Apm3cfACh?=
 =?us-ascii?Q?u5WpUzd46a2qnM+SjZwFtc7m/AtBb5zpWoEbsLpMDtsGPkh3tXT9yytBYWwk?=
 =?us-ascii?Q?e8OuDVRzjoG5HNlVv1KKXggOnSgvkSnCd7K7R0kohhrm5uS3CsEPf+JLtzoY?=
 =?us-ascii?Q?4bHCrhfJsfXNtnLjgtNzzySXPBTbMB/9llE18mnhsCRy0IRYsEXcJkzW6FrL?=
 =?us-ascii?Q?IlgtHGK2XWikmU1OU54l1ZtCYunIfCyiC8CR6qcvQfBRg11gobCIFBhV0H5E?=
 =?us-ascii?Q?oNPD2JPZWGIz5USsLT6OvyjaDkh1ENIefoy1r21yalLbNzA43wWOa8thi3nU?=
 =?us-ascii?Q?LvH9+qa7+l+tZPJ+sliER5myHBMPm/s3OjyqUyx5qSiHFO7iVm9dg6mkwnB9?=
 =?us-ascii?Q?ODVZZEVOLSgGowLCTVIjRPW/LHavMqQHqdwOJfX0CVFdfY2IGbi4y6CrxZbo?=
 =?us-ascii?Q?+Mctd3VrRyUbalFUALmk7gUTdrpCRBU3abFOPUjTKaA8CLnC2i7LdQrQNq6i?=
 =?us-ascii?Q?ijoF7OIe0/DnMqklgX/7cuNvgIWfU8OJUUUrI9nTA2TI8oD6y9pi+hSqSB9O?=
 =?us-ascii?Q?GFcYnusGFrfl6piH1AUTxCETl/zRRku6lmsGkYsOblXy9fLoR/ysvVi8HnlH?=
 =?us-ascii?Q?Ir6eH377O3Tct4DpWdWGkyJLFGWQzqCp8cNYM8S39MgnJhL5BFoWB15X27ia?=
 =?us-ascii?Q?MirZdawFQJrHrSYtd7LlLR0BosgIS+zGjiWulDJ4f09OLQguNuQFeVNnG6Os?=
 =?us-ascii?Q?uNuG7a2MPe67ekYa6x+7z3BaxoMv3hrTsdUAxGjtHmyulFdJtjta2XuYg3ix?=
 =?us-ascii?Q?DdJv6RtffAdUx8t673N57YrSk0XXoq61RSCIje/f2eLc6kVd8OXfplMjLn5g?=
 =?us-ascii?Q?Q39I0/ts41rmsv1hft2EIlBmZLoO5PrEgVQmxGOKZd5n4RLgiDzIhFDL82G4?=
 =?us-ascii?Q?z9zedsTVGWyPNaNES5uTpDmLjzYLQd5n4UhYbpK+Sd2FFV9VqkYygplPVnkP?=
 =?us-ascii?Q?neYY3XqXUgEwMaMjB6bPGg0UXLVu/02fJLe53NImkIXDFSV3uUh2tozjWZED?=
 =?us-ascii?Q?cyENiXR4V4VpHX7bEdqvMJVjgvk6ea0H/CtkZhMWU17YM7CQMFJVw9psbKEU?=
 =?us-ascii?Q?iPFykasedmO9gxB6bxZ8ra7fjtrLGmILEF5BAg2vy2BuCGC1yrXc1Anf7eQT?=
 =?us-ascii?Q?S1S2qKrL30de8sgocPJfpJr7ZmLvo0M+J7blEzTIMW3O2/IAAlDPaHIMqWi1?=
 =?us-ascii?Q?b63FUaY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 06:48:38.9970 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b784f1f5-964a-4110-e24c-08dc681866b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7962
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

Some version of BIOS does not enable all clock levels,
resulting in high level clock frequency of 0.
The number of valid CLKs must be confirmed in advance.

Signed-off-by: Peyton Lee <peytolee@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index c23d97d34b7e..49881073ff58 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -128,6 +128,7 @@ int amdgpu_vpe_configure_dpm(struct amdgpu_vpe *vpe)
 		struct dpm_clock *VPEClks;
 		struct dpm_clock *SOCClks;
 		uint32_t idx;
+		uint32_t vpeclk_enalbled_num = 0;
 		uint32_t pratio_vmax_vnorm = 0, pratio_vnorm_vmid = 0, pratio_vmid_vmin = 0;
 		uint16_t pratio_vmin_freq = 0, pratio_vmid_freq = 0, pratio_vnorm_freq = 0, pratio_vmax_freq = 0;
 
@@ -144,6 +145,14 @@ int amdgpu_vpe_configure_dpm(struct amdgpu_vpe *vpe)
 		SOCClks = clock_table.SocClocks;
 		VPEClks = clock_table.VPEClocks;
 
+		/* Comfirm enabled vpe clk num
+		 * Enabled VPE clocks are ordered from low to high in VPEClks
+		 * The highest valid clock index+1 is the number of VPEClks
+		 */
+		for (idx = PP_SMU_NUM_VPECLK_DPM_LEVELS; idx && !vpeclk_enalbled_num; idx--)
+			if (VPEClks[idx-1].Freq)
+				vpeclk_enalbled_num = idx;
+
 		/* vpe dpm only cares 4 levels. */
 		for (idx = 0; idx < VPE_MAX_DPM_LEVEL; idx++) {
 			uint32_t soc_dpm_level;
@@ -155,8 +164,8 @@ int amdgpu_vpe_configure_dpm(struct amdgpu_vpe *vpe)
 				soc_dpm_level = (idx * 2) + 1;
 
 			/* clamp the max level */
-			if (soc_dpm_level > PP_SMU_NUM_VPECLK_DPM_LEVELS - 1)
-				soc_dpm_level = PP_SMU_NUM_VPECLK_DPM_LEVELS - 1;
+			if (soc_dpm_level > vpeclk_enalbled_num - 1)
+				soc_dpm_level = vpeclk_enalbled_num - 1;
 
 			min_freq = (SOCClks[soc_dpm_level].Freq < VPEClks[soc_dpm_level].Freq) ?
 				   SOCClks[soc_dpm_level].Freq : VPEClks[soc_dpm_level].Freq;
-- 
2.34.1

