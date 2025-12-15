Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F3F7D59D99
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 10:46:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FA2D10E3EF;
	Mon, 15 Dec 2025 10:46:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hQ7QeFLM";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010069.outbound.protection.outlook.com [52.101.61.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 987C210E3EF
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 10:46:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3ZALDOgwoRbGVM/4VEJ+8+H89ni4O/7xje2DWelMVeOhsdEA/+8AeWIUPk3KMryyKTJj4Ko0WgnMe49yars15wZnibbOKGLzLboX8an3mjjkhkEB41cyVKP5oISMpQ6ZPWYWByt3/CqmBbNi9aRoUGqZvDmKmpoebYZFFJsZPBFVAO394/aJTuUwnVzE/6Q2VwSYjM2esF5PItCe/wlk87zUDw+UME0+uzYgn8rSE9iLZWvUlK/oaCYy+mm/hamf5XqBcXjVV9nBGMfgyT/pRBo5hJXHg4k3rR3XR4qT3AWije2eeChNSqksXNU/UBuxqWQ0C3kJlBB7oskG6BFNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUY7Uv2psPyxw5VNLxQZpxV6Um9/T6RMsUIu2D6p5wo=;
 b=kjBZyILcHiklMRnOXmVEmOQbb4QrirZDC7AOXwARABl2gFhI1IuuID8z2CrF0d/tMw+dM6XxNJKQSDO5QtQHU/9axJa/pc3O5MbwLNqN6sshEeOD4AG0f3ejG/ZqVMyvFEELzy2PSQpYCAjftHAYk7T7+XLBNzRP2tczynxiN4U/EaDapAPKRmiw4gn9Q+KNZpx4Ag8YL84IJLLByEQ9le25QpAtNm7nZctlZAS+H7ofO3nXJS0d9c42U7QF3nQRnH9J+5kNBlWP2xw5p/0GMe5Tf9xqZywHNPtj+EgwvoKfOxaem6nEJMRTWqatiYCldYi6oyglYQ8mYG4wVjqFcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUY7Uv2psPyxw5VNLxQZpxV6Um9/T6RMsUIu2D6p5wo=;
 b=hQ7QeFLM5ET6gBamb/hIb6Zf9NU6K42ZslbCmDqYHLqc88j445Lpwbp5wrm7aixCOmdimqhjq7Owbv5HUVg2XyoebkSuIm6PwAqkQC5XVExTHkOq+0MbusaT5EDl2aZh/ZYZqiMleiaN8tUyg0kTNBTFRDbhMuibQ5vJuEUuLZ8=
Received: from BL1PR13CA0264.namprd13.prod.outlook.com (2603:10b6:208:2ba::29)
 by IA1PR12MB6235.namprd12.prod.outlook.com (2603:10b6:208:3e5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 10:46:46 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:208:2ba:cafe::75) by BL1PR13CA0264.outlook.office365.com
 (2603:10b6:208:2ba::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Mon,
 15 Dec 2025 10:46:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 10:46:45 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 04:46:44 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>, Kenneth Feng
 <kenneth.feng@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH v2 1/2] drm/amd/pm: fix wrong pcie parameter on navi1x
Date: Mon, 15 Dec 2025 18:46:33 +0800
Message-ID: <20251215104634.983674-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|IA1PR12MB6235:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d73832d-f9bc-4b4e-2eee-08de3bc73e09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6pLWQ15AmacjzSMZ/f5y8KOx2iQlbmA0JCik1P7v+juga+wwaEGz3coVSjJ4?=
 =?us-ascii?Q?CkNJZGK5+KCIobs2WcWB3DI96jSGylNQUqrRCUScxfpYcLzwgw2pbkC75nqj?=
 =?us-ascii?Q?9CxpsCdA0L8Zuthzf2uVhjPMhlXyve1fU1vMY/7UM25EGWREnzVrteME8oeB?=
 =?us-ascii?Q?hQZUlfqaFZdJftIDSV+8fTzOrBsOOpQK+F9BbfghjNbypNVUVgenrhRO4UEC?=
 =?us-ascii?Q?/vnkKLmaDYjgL7jv9LrWkxvv0s3tDdET5tRlfYB3VqR63kwMJSEPWrrx3K2+?=
 =?us-ascii?Q?mn/SkDbAfyOV9kuQrg1ixyqldHOtdSIAEKs6+C5Qwokg1PhuiQjrmZC+QXIB?=
 =?us-ascii?Q?2UEQWLwta28XU8MBZiLr2C2a9QvzsZDR6DeiRU3Conjgr7CvR5xDs7pjRkhr?=
 =?us-ascii?Q?yoC8gc220batQOp9NJb398iRmoiz1rYjnOV3hAMUXmzBFS8P/bNppMCXk061?=
 =?us-ascii?Q?VOjbHc7kpoN5UCPOg/hOFESljLzTQXKt/yZIMg3cqY60ojhDO7kIheobm4Yd?=
 =?us-ascii?Q?XF0veqC2My/7GSw5YRtl3u+xNrE8VHiIvyFEq6tidd5aRSbjbv9bnh+sesUE?=
 =?us-ascii?Q?7GnTi91UQDOUo7+Q5FZ+87IY0STQeIIYLf6sTEXziolRby56S37OskPX5hE0?=
 =?us-ascii?Q?d4DQPFmBWG/w0QRPLSpUd0UtMVxvLHeTeo7/7sWoiTjWiHvtC3BYRIj6YUnF?=
 =?us-ascii?Q?4XX7PkdZkkzNCLpqFqJvo5sogAMQlucJGGRP/eIDZx0RdPREWm24J/iICBqJ?=
 =?us-ascii?Q?47W5fh+4bYkEkbbHo5NbK87BKQvm/I+XPU5VUMzuyJOZCkccWf2A6kgh14Rv?=
 =?us-ascii?Q?nMeycr45X+K6hgu7NO9SiQqIHCITe/l+vcai47NbBrMJ7mA6Kxk0TOabGPGL?=
 =?us-ascii?Q?HgHilemXCv4qfSMjhX8evKd0fp7IpsbXBouGVBjne6Sa3N0QZvj00fIrumO8?=
 =?us-ascii?Q?XVXYr/h/JwOyC2Z5ZTbZS7/4M7m7tgS3szY9waOOZMhDV2x+0TpX4DinGjY8?=
 =?us-ascii?Q?91vZIX+Ok/H/pAu74/fNT717dAXFbsmXk4q8XAnDgWBgHdgE5pb0tzuVXB7/?=
 =?us-ascii?Q?WSra/kQPBcHwLO4vuXTfnfQuab1j4vazsnyUbh2s10FuP30v0m56uKZOxbwt?=
 =?us-ascii?Q?haqq6nG9IggY9B17jG5gwX0kQJQm4naNdstKQNGIa16EKjt24DdICHy6Ka6Z?=
 =?us-ascii?Q?nYFPGqI/hwPWHcd/T5PyOZaD2cRf+THhKCrtheZWsUPYtSxKHNqkI5txO9+f?=
 =?us-ascii?Q?M6uTFqPCcNthdGTW7yazlcssm/TxTtRDcowMnKjc1onHhG9u5nLjuJzeKdjG?=
 =?us-ascii?Q?J0mJuW9JpiSqAQUiP2nVHMD32M+FX0YhrbfUxHWIGP4QM3fhcKPu/3Ft5sKn?=
 =?us-ascii?Q?9E1I+Mrn9N9txiT0tsgLGTMglIVQGNhrkaZElI1Sd8LPBhWkxA9fV2O1CilY?=
 =?us-ascii?Q?kn1/8GbFqb3JV3NqsHW3SzPEfXvqmQ7edG2A+wmbbvktCRdg4c66AP+fkF6+?=
 =?us-ascii?Q?jgLHR/PfVRRnX8VQ3VSITAv3qIFj+BzrWajBrcml4kuwls4xlHRXNHEuiuWl?=
 =?us-ascii?Q?9o6cWnJ6FmdxulNjtlo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 10:46:45.8072 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d73832d-f9bc-4b4e-2eee-08de3bc73e09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6235
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

fix wrong pcie dpm parameter on navi1x

Fixes: 1a18607c07bb ("drm/amd/pm: override pcie dpm parameters only if it is necessary")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Co-developed-by: Kenneth Feng <kenneth.feng@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 882830770b79..0c26fe6fb949 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2216,8 +2216,8 @@ static int navi10_update_pcie_parameters(struct smu_context *smu,
 									pptable->PcieLaneCount[i] > pcie_width_cap ?
 									pcie_width_cap : pptable->PcieLaneCount[i];
 			smu_pcie_arg = i << 16;
-			smu_pcie_arg |= pcie_gen_cap << 8;
-			smu_pcie_arg |= pcie_width_cap;
+			smu_pcie_arg |= dpm_context->dpm_tables.pcie_table.pcie_gen[i] << 8;
+			smu_pcie_arg |= dpm_context->dpm_tables.pcie_table.pcie_lane[i];
 			ret = smu_cmn_send_smc_msg_with_param(smu,
 							SMU_MSG_OverridePcieParameters,
 							smu_pcie_arg,
-- 
2.34.1

