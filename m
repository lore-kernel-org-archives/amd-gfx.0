Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B24C35FF1
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Mar 2025 20:45:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8263C10E62D;
	Tue, 11 Mar 2025 20:45:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2M3hjwPI";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D2B810E5ED
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Mar 2025 20:45:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cCUZqnSeLJdaC3Br7nnHaSqACozpFxvcM4tpo2D1pgh3Sn0hT5NG0P8vOV5Lsmtvm9GXiD11/bMRc9n4vAUST7GYiDBn5uzAqHUg6T5msvIXxPujiMtIdOnB8g4uPgvz8NgRQstYWLLlyjXFG2CjNSgVHiP1tDcTDSkJ0Sh1Kco42ZT1B8EnEV6RN02aml7mfFOElrjbInHgDgn1qNKGeRaKvPjBixgLr9huzr0NCNKvlLZ9LybPLHkMSXZZam1TZBfwatPicHDmbV24bWZI4us1NXQ3PYnSDs1Wm6oqzanSDn7DN0HIvlBriYyMqOTsxDxNU7s8DHpnd/HNoifPzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1qlpx9Q2+iXdvk/c8sS1s9Iy/j22IK3pTza7QfC4tM=;
 b=VONU1GpyC9uY1uMxMUswaYGNPHh3RgCS3Su2FxQ08AVDR0It2VtklQfGH4up7MkcD4E8Ae4ghfXFd2fHgyjMu9C8H0YgkCm+6Sv0UunM5PmgfEuXLuDqD7kIR4fkVXzGXTyww4NjiG7Bwb/LopgzLrMRSAZPkvr5XfHyaEd3LU5a8+MSl00Bv7I2O3qsaYXlwgKS9dgQV4fIrTrBGuH55z0g6TKRE03YFAtOp215DN0DC79Ccn1qXR47foUJkzF5fzUijYsPToRxh818BOMQ//OYO8XdlqexOtz3OZlBDqYVbqdsHl5E/pZ52mjqriAFFqkdGmoiqwibGt1Nes83IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1qlpx9Q2+iXdvk/c8sS1s9Iy/j22IK3pTza7QfC4tM=;
 b=2M3hjwPIZDT+4EDsuKflZ5m4oRpyMqLusecdWVInyC6Ym7+VyDaGoumXF02FrzSucrpVD7yTdP9ke9ISDydUpw+JTrYFV/+plvsvJxga5Be+cKiqvM40CgkZpvV+E3HmNXl8g/ZzjIfxdve6ykxnPUqsJEHpoXWxFeWPwpBKfLY=
Received: from SN6PR2101CA0022.namprd21.prod.outlook.com
 (2603:10b6:805:106::32) by MN2PR12MB4047.namprd12.prod.outlook.com
 (2603:10b6:208:1de::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 20:45:14 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:805:106:cafe::77) by SN6PR2101CA0022.outlook.office365.com
 (2603:10b6:805:106::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.3 via Frontend Transport; Tue,
 11 Mar 2025 20:45:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 20:45:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 15:45:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/6] drm/amdgpu/pm: enable vcn busy sysfs for additional GC
 11.x
Date: Tue, 11 Mar 2025 16:44:57 -0400
Message-ID: <20250311204459.23864-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311204459.23864-1-alexander.deucher@amd.com>
References: <20250311204459.23864-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|MN2PR12MB4047:EE_
X-MS-Office365-Filtering-Correlation-Id: 42cc1163-b3f9-4619-a4a5-08dd60dd9fd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/9cntUcTQbvlOI5iVTANFGV/H2+Vua3NTEy94589iWh6SHshOj/VbUVs4GXP?=
 =?us-ascii?Q?G0vXa/UlQT7rNAOfHqACz4RhDavr+E/drlsajx3PTwGpSWMsn9xkOBx8maaQ?=
 =?us-ascii?Q?nlrHyyH3xBLCm4rNVDMAynpb+mBm3g7VY8Uj0yQAV8qWHww/pYJ4SznMkOp3?=
 =?us-ascii?Q?RgiVHVWseDk5d/mNzAxMtr/mkGOkJ3DN7oHvt7iWfqac3v92rHkS5ViEv4n9?=
 =?us-ascii?Q?lZAOnzePWqsfJyEnHwB3sTTvkjiE3SJIVrZ+qkdCNS7ju67gjVfS7VrwMPF6?=
 =?us-ascii?Q?cykY3pA94yGeZuIGvEq+0JZN6ta44Wjh/KJ2Klye7/GZMJwqlDJs8e0+ZUM6?=
 =?us-ascii?Q?qJec9aMwWpWJukrXUF0K8SEQWKn6Lqdt4sB4dYz+bGeXYGw1jugvphQIqaLh?=
 =?us-ascii?Q?1HDEeQmtO/iMtvfNoNGC76N3vpndV+Tm3aVTKhl1UXR/YPo7Tm+Ds0yNZwmM?=
 =?us-ascii?Q?OvFPDC+tkO+K2DrO6o8QMOInosDoXg2v8PEuSq3DRhNN1137ggMEKWNWQAWV?=
 =?us-ascii?Q?C6RC42eKTVb2jCmw0ZPukUR88MnL+UwGYt+biAnBgrSOlCJhQr8jh4QqQWtr?=
 =?us-ascii?Q?kZPwz5HbLvUT2WTU4L8veIlK7Zp+/khR7636iTk4X9/md9Xc86ytCnMQrSv7?=
 =?us-ascii?Q?661pVK63DdcsnV4DUynV85gQ/iLhUfgOvckyIzAdD0vduWY/tqChw6jzSlID?=
 =?us-ascii?Q?y1jdppg49NwVMelqZ+G4tXo5WXjYec5kL+n6cQ7wWEYsKYblCm4yqDFxSi1O?=
 =?us-ascii?Q?uySXt7HhLsY4RVEqUlJbWfuPUWSq+6M94Y2vEqG0FaR82iQ8SC++BDHnB7Nl?=
 =?us-ascii?Q?NZpCyCO/DJPHE3Y/1V5D72xYkirAXxfSY9dz3yroQF3x1QRliMYUayat5zpX?=
 =?us-ascii?Q?YtIv8P2n21h4lueXJJ9qKwa/hhsajMgbOVFKGlSAC/vV6FQSQaDsV7QzPt0S?=
 =?us-ascii?Q?XgKCCVhDOTyQ9XFTjU6A8cumhekNWSelMC1fc88N5rHF8xZEFd8/E7HGtBXE?=
 =?us-ascii?Q?QQvY20fmEHXsGBG/N12fFEoqNooXqrO3BMFSHIySgGQhODwYAGTNLOHHiR9z?=
 =?us-ascii?Q?mDPGR4IZcMCDUq3PxRXmmnLjx4XSCw5cNxXstro22uSXPQpW7NlD7QJGA/LQ?=
 =?us-ascii?Q?Z27fSfdihV27L1E0CA2QTDL+RmQmG+8b7Ri2tH6AAleazYhfc2xz36DFAB92?=
 =?us-ascii?Q?eNubCXrMZfS5CwJPd4fn65LDJKpQ9YunVQC4xD4XqHOI7ltQGJHfeOTRJ0P5?=
 =?us-ascii?Q?1gNGNFmMTUqj2wTw1T+b1kmcfMBMGgHHMs8DyHPtHyYaUA5CtBdGliBgPXSj?=
 =?us-ascii?Q?HBjfA4lExPSxdOTp8+UUst3ssXHT3Bn0inJ3JWWX/5FrzLsdPf6tj+DYmIV6?=
 =?us-ascii?Q?4TZYH/MzNuI5F9E0F2qaD64GOgCbvHy+KRzS2Y/6k2c5Dc8TdZKBsgfFji3E?=
 =?us-ascii?Q?Ptm/4K07MU6Mxys5O+FDQoBBYIex96s1TMKPUzGEfQBvpkooKkXs6w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 20:45:14.1355 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42cc1163-b3f9-4619-a4a5-08dd60dd9fd8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4047
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

Make it visible for the all GC 11.x chips that support it.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index e463f7a739988..bb39e7f83341b 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2315,12 +2315,18 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(vcn_busy_percent)) {
 		if (!(gc_ver == IP_VERSION(10, 3, 1) ||
-			  gc_ver == IP_VERSION(10, 3, 3) ||
-			  gc_ver == IP_VERSION(10, 3, 6) ||
-			  gc_ver == IP_VERSION(10, 3, 7) ||
-			  gc_ver == IP_VERSION(11, 0, 1) ||
-			  gc_ver == IP_VERSION(11, 0, 4) ||
-			  gc_ver == IP_VERSION(11, 5, 0)))
+		      gc_ver == IP_VERSION(10, 3, 3) ||
+		      gc_ver == IP_VERSION(10, 3, 6) ||
+		      gc_ver == IP_VERSION(10, 3, 7) ||
+		      gc_ver == IP_VERSION(11, 0, 0) ||
+		      gc_ver == IP_VERSION(11, 0, 1) ||
+		      gc_ver == IP_VERSION(11, 0, 2) ||
+		      gc_ver == IP_VERSION(11, 0, 3) ||
+		      gc_ver == IP_VERSION(11, 0, 4) ||
+		      gc_ver == IP_VERSION(11, 5, 0) ||
+		      gc_ver == IP_VERSION(11, 5, 1) ||
+		      gc_ver == IP_VERSION(11, 5, 2) ||
+		      gc_ver == IP_VERSION(11, 5, 3)))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pcie_bw)) {
 		/* PCIe Perf counters won't work on APU nodes */
-- 
2.48.1

