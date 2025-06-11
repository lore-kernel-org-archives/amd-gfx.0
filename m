Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 886B3C71143
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Jun 2025 18:41:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08BDC10E184;
	Wed, 11 Jun 2025 18:41:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tqWewJEC";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0621110E35A
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Jun 2025 18:41:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c1UfkENB/spChUpSCkfVTjiQn7T9vfUx38H6f2WCguS68yjf36TYed2p/rD9WrXBUGbGB2ieDr7lN/L9mnP1Gh7nwL8UmVHlPIzbkWTLY9F6YXyez1Vic8r+jQMCQiOuVVtgltUhIQ0g5tNVgQEj3/aIgFqAdMY/kFaXxAe1MSApLq2sFUrDWkNfycW0xjJ7IreR5pL8PY+yYaoup5F2nxzygefKobk6uIr3Z9RVQsVmxeBrfULvprAt+hkNaa5cDVEfyeGsso0I/KrOHZHsm7hyeoOwQogMCE/QGDCpc3wNrm4X1OsG8DqDPuBb1qr5UFMAVd/AHQzv9zKShoQrQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4yRPNGZ0iVWRvyyI3U7qypsvtWLIBx7nbK3mwfSxpac=;
 b=fzPaAx6ONYHn9WFny6XFz934vP44yhz2eNhni0hbYqwgbdKq1nlQSDRqiMj2m6OIigEmHkDQYT2kqT0u0ECtMd4rIqzahe4I05HnKpH/VhatAd3nILBhhzbpi3zlHXLct5/bEdvKlGP4oObj4L9/21Lx2uUNRaj4U3mO5VwwQTFP17tkglBIngjKAvUY+TZkzz7ll5y5jT0c0pA4i1Gkg+zI4Ri4L6TPD4EmDTMYXHPZs8sdXGiLZ7alkm1GY8Ayg7JIi+AhLSK5Jzpz9NdnwdxfvMUG254dB84YjuH0jlYeaFKFOjTeqYNeCcyvUteIKGsKsN4jdVVxaVLCXbaqog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yRPNGZ0iVWRvyyI3U7qypsvtWLIBx7nbK3mwfSxpac=;
 b=tqWewJECh/FC6pm5eDatSPLuhydk3gGcH+3S8M5yGhNI6YQrPm0RCp4Hpt/ruHAfzogNbPGG3IY10okTuBanUDWl9XGA9CBnX/XvWYnY34f5vjxXjqVln2Ga7Ud0CeWfqHtgqcYDSkgyuTmdbOt9nBaADDOo4YaxcYRNbIrEwkE=
Received: from BL1PR13CA0152.namprd13.prod.outlook.com (2603:10b6:208:2bd::7)
 by SA3PR12MB9130.namprd12.prod.outlook.com (2603:10b6:806:37f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.36; Wed, 11 Jun
 2025 18:41:15 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:2bd:cafe::fd) by BL1PR13CA0152.outlook.office365.com
 (2603:10b6:208:2bd::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.18 via Frontend Transport; Wed,
 11 Jun 2025 18:41:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Wed, 11 Jun 2025 18:41:14 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Jun
 2025 13:41:14 -0500
Received: from aaurabin-z5-cachy.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 11 Jun 2025 13:41:13 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 03/10] drm/amd/display: Use scaling for non-native resolutions
 on eDP
Date: Wed, 11 Jun 2025 14:39:53 -0400
Message-ID: <20250611184111.517494-4-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611184111.517494-1-aurabindo.pillai@amd.com>
References: <20250611184111.517494-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|SA3PR12MB9130:EE_
X-MS-Office365-Filtering-Correlation-Id: d3aafa71-0779-44d8-fc67-08dda9178bae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6ofrF070FXfvA/K+Bdaxn667Di9t4aTGQQ/RYuhCLBJkhKVnPbOV8EFrrDeq?=
 =?us-ascii?Q?+SWbiRuFIOYJ+F/ZVSh3DTcP+OX9MZ1XxF/7PXwO7jjca4ypVR+cue82bK+N?=
 =?us-ascii?Q?jKIdGvRRhmB34OwNXCJR6RamPd8MhJW/7gP86+p0Hq2otfXD+nd8oclw5eD5?=
 =?us-ascii?Q?NwMp5iNDAdSYpJmzCKv+6OHOGBlH4eyHfSbpr7+wahrUBs/Ft9oypcFnAAop?=
 =?us-ascii?Q?8ev4bC3zDHalsi0VdWAtt8zGcFpV2OzYvyKvJxw5HLbxSnIw6sHBhfje07Uc?=
 =?us-ascii?Q?bPXckTNTYGg1g5Q8jNlGJWGsjIYWf2XsM91n8p50aPh/xFiW/oF2HgPzLyxI?=
 =?us-ascii?Q?HLuxyjqsibHlMmQz5UFBGS0g+KbRXABz8i3vHIfU964verELAtFaj8+EnFki?=
 =?us-ascii?Q?2eiTjsCrm4QkzJR2L03ccns/DFRyMGllIuUuQTNbwO2Mgu/p5mm/5x3QGacA?=
 =?us-ascii?Q?H+4ENgKR/u/G6GDATi7NHTtHn+raFs668mU6TUpcfk1iF2AE0rlRwjRT8qH8?=
 =?us-ascii?Q?yj5LKiFAxCAoNmtlI431RDB9x6pyTb7gxkaVTzbBWdkgKc79lG1bFQShvSqE?=
 =?us-ascii?Q?VkiDDqP3lmgttKmADddI9/bmgGehpzuX/1WFtjeBLcfEJZJSetQKDbg+YGqE?=
 =?us-ascii?Q?7MzgshkB9VysEhTZ7l/Z0mVHFjDH0recgTs6Dlxh5xyUGJsaiWPs5BbY0vt2?=
 =?us-ascii?Q?C4bbf1Z1E+UtOGB5hu/hTDvghnelIg4x7Q7Z0ONlD8T7rY2ITPrprfXNaCk0?=
 =?us-ascii?Q?84UojxJv7/KjHvGT/SpRw2l35W/XxwsAaC/Bn0jYrNN6lF+5Q7uABSh70YCj?=
 =?us-ascii?Q?xW7XQGGkZRw/EtcfJ9FOMEO0kZTR0Fx2uxoxD0enPcMzuehYiR0g1Vt+13sf?=
 =?us-ascii?Q?9w9ae+PqNUpHrUQRVp+4kj4qcRXUL0yZqBkX60J8zO/MtymSoQQMDCJcLjjD?=
 =?us-ascii?Q?phTO9u+gn8hE5UY1js/9DRDZO2DgxBENwsPcWNB7jmN22I9wNiMpaqOCUkJo?=
 =?us-ascii?Q?bfRocxoof78lPeT4qCH31bBcaKFk9yWSs4ytpZl70l4NLuHrkVOOWEF1CrId?=
 =?us-ascii?Q?VAF3sEnjsYdhHlg0g6YK4+wVLXskOdyEHwB3JSo99tS+xhHpclv5kRkrs/QR?=
 =?us-ascii?Q?GsEl8fhyjDgAqE1cEs8KmekJ6ONEcxI3LBtbHr6haLvfdtZ6FP37KLfPsM52?=
 =?us-ascii?Q?pffR2J/6bF5KVx39KQ4LM80twKZcmSZAGwaEnp8x8jtHPKk/1pur52qmmJpE?=
 =?us-ascii?Q?aRpt2n7Hw+obL84xO3OFe/WflbHbW22bysgHLYELrRoxLOBHhEvCfk38zjip?=
 =?us-ascii?Q?wWOOfU3ghNJTC6M7NyQhIja98l1Ite44vz1NJlgkVCHI8esOIkRvfLXQOMGn?=
 =?us-ascii?Q?qlOQ3Lou4tsspAiX31GpXsTpktf+2LKPQzn4mxdq1k7EmPJ1fS4XWLl0TTTD?=
 =?us-ascii?Q?35rQyW9VhVcSCgbyW5F7NNnnH4XLnvnjjbCxkIqqonBBU5fiotcU+JhL2EbI?=
 =?us-ascii?Q?R5RF8/seIe7l/xhQ2y8nNaOC/a2KNb4Z1VUC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 18:41:14.8879 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3aafa71-0779-44d8-fc67-08dda9178bae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9130
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

From: Mario Limonciello <mario.limonciello@amd.com>

[Why]
Common resolutions are added to supported modes to enable compatibility
scenarios that compositors may use to do things like clone displays. There
is no guarantee however that the panel will natively support these modes.

[How]
If the compositor hasn't enabled scaling but a non-native resolution has
been picked for an eDP panel turn the scaler on anyway.  This will ensure
compatibility.

Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a4e3448e5a2c..12cbfd7ffbc7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7891,6 +7891,22 @@ static int dm_encoder_helper_atomic_check(struct drm_encoder *encoder,
 	int clock, bpp = 0;
 	bool is_y420 = false;
 
+	if (connector->connector_type == DRM_MODE_CONNECTOR_eDP) {
+		struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
+		struct drm_display_mode *native_mode = &amdgpu_encoder->native_mode;
+		enum drm_mode_status result;
+
+		result = drm_crtc_helper_mode_valid_fixed(encoder->crtc, adjusted_mode, native_mode);
+		if (result != MODE_OK && dm_new_connector_state->scaling == RMX_OFF) {
+			drm_dbg_driver(encoder->dev,
+				       "mode %dx%d@%dHz is not native, enabling scaling\n",
+				       adjusted_mode->hdisplay, adjusted_mode->vdisplay,
+				       drm_mode_vrefresh(adjusted_mode));
+			dm_new_connector_state->scaling = RMX_FULL;
+		}
+		return 0;
+	}
+
 	if (!aconnector->mst_output_port)
 		return 0;
 
-- 
2.49.0

