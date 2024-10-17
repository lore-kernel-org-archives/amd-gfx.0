Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B933D2F7F0
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 06:23:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE03B10E0E5;
	Thu, 17 Oct 2024 06:23:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BgYHOsHZ";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BEE910E0E5
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 06:23:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+dTIDzz+rXwVnZBt88CkCzZsW3AbICj46Bfh+61CwisJispWuER3gQa7aEJYYwqgbauu8q9+SkwOZpUqfDh2XXJLoifJ2ZfjmCiwNdpT+hbR2rNGdPzXHyy2XA7HF7fJmQaiVHCDFIj9w8DzmCkdi7GKtubIW1lMB6JD1hWHDjIbQXWE/hCDXbOAxAg46doA25yvQed+tpRVgYV+6GQuGhEKywZEz+4yha4Musv2T9tS/mQA6cVRnF+agN0y1g40ckz1hEs6gqcu3YnndP/lU9i55Wsv7UYaLFefcjzJWfKmSBytCaObOYrILelLoz7T+pER5W+nYSL6/3uqe1nQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2U0ZgvmZUNqxs0hPe7FdE+zi3vkJJWjP98t3/m7xtGo=;
 b=JI/ySZCee01noclnjT38E+zDOgKe+lDx6XWwqzlJHlnuZiwUcwgN/MbbXaVo9nFXbLa3AlWcvs//ivJQeLLP/1jVQDA0PQ6SeABOpLEjFzexk7kfvoLYTIlVmmJ7biHAA80L2IHP9jfU0+4Gq+Mex+vdb2pKLJA5NeIZgvneJJ+ERDl8od2EnBAAD7AOTzDKyojv6J0YU5Cy5x8lL1Xv2BgYYqmKMjD+6BiHxjJfPmnl6kyIp4dZ/GUfSktBC/d0J5j03Sgszs3VFk5AfsNmlaUAYTHKjjQfcWC5wRyYRucge1yky9bp7lTyKSKFXRgXp5hT2qRJ1Qwr2HV1791Fow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2U0ZgvmZUNqxs0hPe7FdE+zi3vkJJWjP98t3/m7xtGo=;
 b=BgYHOsHZDPrEANc8Q/heloIlvcXGUrXYYtVa+pfLtdccoE3TC/Li1Sp+grAA8tYGewqsxi/MByTkSkyZRNBQKIMJgm8gzhP0oyhoJhAG341ghx52YdWiTM05ZIz3A0WVJdkTk2atNJsgR2M+9LXZYPjWE5kagWgm5SM8ENKX3HA=
Received: from BN9PR03CA0578.namprd03.prod.outlook.com (2603:10b6:408:10d::13)
 by SJ2PR12MB8927.namprd12.prod.outlook.com (2603:10b6:a03:547::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 06:23:38 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:408:10d:cafe::84) by BN9PR03CA0578.outlook.office365.com
 (2603:10b6:408:10d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Thu, 17 Oct 2024 06:23:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 06:23:37 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 01:23:35 -0500
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Thu, 17 Oct 2024 01:23:35 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <kevinyang.wang@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH v2] drm/amd/pm: update deep sleep status on smu v14.0.2/3
Date: Thu, 17 Oct 2024 14:23:32 +0800
Message-ID: <20241017062332.2151448-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: kenneth.feng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|SJ2PR12MB8927:EE_
X-MS-Office365-Filtering-Correlation-Id: ee5e945b-aa37-4bda-c349-08dcee743c70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sKKDCRPGoVWM6BHp2tUU9iBFu+UapliWJeCJLvu2taWP+76iUcIFF4uyLLb2?=
 =?us-ascii?Q?iDXjiKFb7VxQsrXdbG5sRoSzmSadpcjFLqfbj4HCKf5gOYRGUvEGApOKgdgc?=
 =?us-ascii?Q?yMxAeMsp5ekO2uioSts+8Ma1dFkggYBr5KibkyKn4JUNeC4qM5XRcHwgJxLe?=
 =?us-ascii?Q?rM5Dsg4NGEGsGv1Vx2AA1rawb9VeVEsoNYpNBGY32Mx9bxpqcCe5pCRiL+Dx?=
 =?us-ascii?Q?rR6wi58I0jNLqb5LNFr6ay6JS8JBSR2RTbf2PnBXuJfOk1zL1zbSCDS+WgHv?=
 =?us-ascii?Q?pZkOpE4N3qaMyAzKmDnasZRSABMtHJi2Zt4SGtmkT1ANVSZypot1DV2gFO52?=
 =?us-ascii?Q?w1SCdPUoocpC4wMDJY6OIGl0PXpmlJoNhBl2KqiCExLn+NL29ena7ffvxX8g?=
 =?us-ascii?Q?ghfWuxex/VvZE0w9OmH9YNmEgwULgeE3FK3eAWE7vk7FJFsIUMB65w+BRF5/?=
 =?us-ascii?Q?TC2JbkIU+bsfOEvOImoFYvNx4ULX9lg4Q5XAMpnKUJwRGHegq4nWorgLAUbl?=
 =?us-ascii?Q?RbKCsTPmzufy8z+aVFRKmrj6ydhUL/Gp0ul7Cr7hwF5hvPewdNwFCRWiH1FE?=
 =?us-ascii?Q?EUUyaD7V8JBmY5AJaMLHZiedl/BpthKxAJhADa/v/nHpexNeReCsbv4/FM50?=
 =?us-ascii?Q?dkVAGTW40GHNJsqSylemDVMkkXqaXm9nNVlsx+5RuemI0SOZwok9k+Numh7B?=
 =?us-ascii?Q?lVxhCQutHQewW6vGfbn9YF72xV+hicTkbXWWuQOphT4RylXSdBJhu8BtOme9?=
 =?us-ascii?Q?g2v6DXdxO+rt96KeWzNBWkdrhFCNg+LhnkkOSgiY/TZes+Arxhsm377BnDEY?=
 =?us-ascii?Q?qtk5UqdbmpjJoU1myOD+APKr301qMrX6I71xrim6hTg1J2yz55/gqsPaBZHq?=
 =?us-ascii?Q?uPMNO6JxdNDok939bObMgU4SC0VDJ4DgBo6HfnOAPfR2SKANEEuZUzOqmJvF?=
 =?us-ascii?Q?8j/BtjI1Abbpa2pB7Vfxjbz9jZT3WqcNfZYTIKveFP3N1axq8ujhdcLHnlEX?=
 =?us-ascii?Q?xmZzYTyd4I/LpzWniWxjdJlTTka9ClrnFA73JOCS32wdrTgn6vWisU3W+cWO?=
 =?us-ascii?Q?kCeI8xiOxlle09355q7qY9eFQqQfUbjhVZwh6kBDsW0GBs30SYNAekQAIpf1?=
 =?us-ascii?Q?FRTKrzzjJd6SVGxvrXa6+yrciy4tT80ebUEACq2JI4rBDqsDNZmKr0xVRf4W?=
 =?us-ascii?Q?MclJ70jQgPcDK6im8pRA+FI8rWCQ+uNCux7mnfseI2LSoXGeOKiLY5bStLCu?=
 =?us-ascii?Q?Uj3cJib00GGnRBvv+su6zynqDF8kAK5OlXLoet0uWzeQbeLO66rzp8QuqU/b?=
 =?us-ascii?Q?F5A5wuAp3P8zddr2Ulp610CxVn9S0p5MRMjjJ7sXLeH+5jApQ7/jCBb614fg?=
 =?us-ascii?Q?jRd1UCNUHnlsGeHpgOWjKZ9VQrjRq+Psz5ZhnWt0njd5NNON4w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 06:23:37.6782 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee5e945b-aa37-4bda-c349-08dcee743c70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8927
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

disable deep sleep during the compute workload for the
potential performance loss on smu v14.0.2/3

V2: consider the case when the compute workload is set twice

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index da448523ec60..618a8e17c457 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1787,7 +1787,7 @@ static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
 	DpmActivityMonitorCoeffInt_t *activity_monitor =
 		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
 	int workload_type, ret = 0;
-
+	uint32_t prev_profile_mode = smu->power_profile_mode;
 	smu->power_profile_mode = input[size];
 
 	if (smu->power_profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
@@ -1845,6 +1845,14 @@ static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
 		}
 	}
 
+	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_COMPUTE &&
+		prev_profile_mode != PP_SMC_POWER_PROFILE_COMPUTE)
+		smu_v14_0_deep_sleep_control(smu, false);
+
+	if (smu->power_profile_mode != PP_SMC_POWER_PROFILE_COMPUTE &&
+		prev_profile_mode == PP_SMC_POWER_PROFILE_COMPUTE)
+		smu_v14_0_deep_sleep_control(smu, true);
+
 	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
 	workload_type = smu_cmn_to_asic_specific_index(smu,
 						       CMN2ASIC_MAPPING_WORKLOAD,
-- 
2.34.1

