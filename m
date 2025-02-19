Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 208ACC021AA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2025 16:28:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C39AE10E850;
	Wed, 19 Feb 2025 16:28:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nwX4ngLy";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88ABA10E850
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2025 16:28:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=azRdRWIrFh2OxqYU2BPd8spgVWcZSm7ZqvvMBaU0okR+AHZq54kKycyx5UjIL0AKK+L2xcNiqe7VU4LLpsu8tmwIsThCxEOA/whbHgbAIfwVmLC7u2GRoUJGwU5U0X2dxAgKWSeFlpyN51xsuI32yuhxlFKrtQfiyrABXppI80/FRaK28VrJG9oX7bl9iWSuY5Emm1OpzL3d0TzwrpawwMkqK2/73M6lzAYxaG/ieb15nAPsrm3okYRoIKwaQVk3+JJGFuKKJ/3v6H/YZQc0t/POTfdiSAiYxJSkLrN98XZCbZaHsdI7eFy4VMkgFG4dl9kGr7Qg24FsHAxNEz1cuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNH0quBFblOaL/jsm/wMhfyGitncnhk+iplU/+9Oiz0=;
 b=f1b0vi7eE72HgF6wSrOam4u6Brasw+pW9xyn5Q7HNRuwGuH0ruVrEKrw0li1/dEO4IUGBjK6HBgjQJ1oebjjxTQT+HyXjp1yreuJUNF7n/TaInjZ8gXYWAQbO5/ZCpPUmA2irQNSQAO+2VSVyEILb0Gf2oPbN9DXcD7ZxCYHhigZXl1+UzYgnOtvQTzSRLOCaAeMI2epsvQLmWsCgTGur7u8p92plnRC+3VsJw0xMVq+72IcE5TWA+hWQ3mmnoodINlq1ChnCM8sZdV//jhkGkt7/5jy3zvNqSoNDbEu1wIWh6haHe+Pd78eWnonkVtoWiZ2w9uA0EK95bHYM/hghQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNH0quBFblOaL/jsm/wMhfyGitncnhk+iplU/+9Oiz0=;
 b=nwX4ngLyGKFGyUfHdSqbTi/1nIlwTcEtPx5rTqnyln6oqUWxzKqONV/+oCtM7aTmrzp1LmRQHZKzqjOxtwWVJ2eXDrBGYwpkAEt3P6ImWwQVPizdj3fQkxrXOOqXsNMCf7JXS6sjQ10QNZwHv8FNofwwowNhpwsJeWKnlFZJMic=
Received: from BL1P221CA0028.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::18)
 by CY5PR12MB6177.namprd12.prod.outlook.com (2603:10b6:930:26::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Wed, 19 Feb
 2025 16:28:21 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:2c5:cafe::c8) by BL1P221CA0028.outlook.office365.com
 (2603:10b6:208:2c5::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Wed,
 19 Feb 2025 16:28:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Wed, 19 Feb 2025 16:28:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Feb
 2025 10:28:20 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: disable BAR resize on Dell G5 SE
Date: Wed, 19 Feb 2025 11:28:02 -0500
Message-ID: <20250219162802.61564-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|CY5PR12MB6177:EE_
X-MS-Office365-Filtering-Correlation-Id: 69af744e-8f85-4f37-cb7d-08dd51026c6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wUqGZiWEVCrB18VBy/cwMq723AdNprBImpzKV/5HoZaBLtwom8zTOhBGRXfW?=
 =?us-ascii?Q?N+Ydz9cGK7AcMi0oZPaD9teEadZ4ca/T6FIrtAzH+iKyQXt/cTlBGjMRphBD?=
 =?us-ascii?Q?kp36Ll90Jdb6S6JzMvHdqlknVya8XkxBohvD7rJxVn3lbQUKy4xsRvnxnkh+?=
 =?us-ascii?Q?57olP4CNKzUfZTk/u8+/TfaYGi6WDEjFY/1VDufPQbV1dVHaeIJ3ZXO6zqs7?=
 =?us-ascii?Q?4Fkm5xbbsw+96fB6lIyEpRpXgj3NYx7xs+w5k5Bnbey+Y23xOxTojBXbkN3S?=
 =?us-ascii?Q?euon8OTYLzNwA129XABhy3auS3P0uGcYsVCa+WpT3gpg7bg9phGzXwonvqO5?=
 =?us-ascii?Q?8tVV8+t2ZT1ENaGF0y/Zde5SBb0OCMLfnbGc46OBOnicTin0BiAeQ8CtbHLG?=
 =?us-ascii?Q?Stk1lB/sJjvu2U/fDgcgXXt7H7In8WNEh7oxvqdrPQ53rRF6v3w1Mdiw+E/3?=
 =?us-ascii?Q?6Cm4UgcEpc4nvSvFmGuOY6JrM+6F/U7cglrIjDRvmgyQYneEo1NI5aaDW75Z?=
 =?us-ascii?Q?fA0UHEmQHDzqsLok/ZKDb2iXT7R230s5lHVLhhJK7Tqlb0ut4Z1ZxH8jVeXy?=
 =?us-ascii?Q?/QUp8zGuRvrmb+Ll2+NofZszSgsXWvVf+oBo3FgG84O0A90ogxTyb4Ntdm7q?=
 =?us-ascii?Q?diaJ3SUzsXVIG4uJidkpsZarEmyjJBNxkPl5/CQXJr31IPg5MxcdUl2VFOY1?=
 =?us-ascii?Q?iKvFkB/jfp/9cOoN62dIItM3U4GAJdXs79TLO9+Kksc2WZvnFYyYa5IONaHy?=
 =?us-ascii?Q?8RqNqkBK+HkiHkTvdXFSLJnId6fRk1y5xkH0UQH73CzNhQvxIC5JcIZk6H4C?=
 =?us-ascii?Q?9zihBD5k1oPC36ihq0WO12qSFcc0d7rWxVE5P3Bmhbp7qrx4JiSyI/N7vBnJ?=
 =?us-ascii?Q?6DslrsK0/6XtI1VdjUUek0tE0HIWU5yZnJ0TM0nT+7yKxZqDtJJUeKEzvaSe?=
 =?us-ascii?Q?YthaQLOwkcrrKjU8O6ZV4VMHqnMFwoSBO0AktX57/O8rN7GTKMMikabYJaAT?=
 =?us-ascii?Q?ethfHeIGHVYlliMjYLrsOEhmLNaULa1sYLFQh8okHFNTHAiidHwZLgovdDIh?=
 =?us-ascii?Q?/bgK68kxKitlNwU8bRuEVyXqhsHPq4uhWs6sx+wXPSoMLfdQv7iji1tUhUAx?=
 =?us-ascii?Q?8UyyvG3Yj9HKxu+0tG74f0bCRm2Ek8zO1YBUv2q1Fnp/aAhfNo2oKznI/uSl?=
 =?us-ascii?Q?NR77a71EmzE4HS0AXY22iiEZfu5W0y/ldeyy1/SnjCHJx0TPzmumSUUOhxqg?=
 =?us-ascii?Q?2YeZi8Iut0ISX1oKhrGFUtBpF8l6YwP22dRFBYzMK968/zzwbMGy/i3omsxa?=
 =?us-ascii?Q?8IJzS1IMDwiFAPs9RyT0NivWtduhsSptXOJbUBiZ21lyzuHezrluP0zbIX5m?=
 =?us-ascii?Q?gKuv+IrC7fV/Z1wXRH0NtJZ1GBFAq7Ex3QsoF/uv2jEbJYZOW7ygLpdcT70f?=
 =?us-ascii?Q?i4Z3/X0kxM0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 16:28:20.7060 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69af744e-8f85-4f37-cb7d-08dd51026c6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6177
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

There was a quirk added to add a workaround for a Sapphire
RX 5600 XT Pulse that didn't allow BAR resizing.  However,
the quirk caused a regression with runtim pm on Dell laptops
using those chips, rather than narrowing the scope of the
resizing quirk, add a quirk to prevent amdgpu from resizing
the BAR on those Dell platforms unless runtime pm is disabled.

v2: update commit message, add runpm check

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1707
Fixes: 907830b0fc9e ("PCI: Add a REBAR size quirk for Sapphire RX 5600 XT Pulse")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5ec71f146fa93..cae6dcb95a131 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1662,6 +1662,13 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
+	/* resizing on Dell G5 SE platforms causes problems with runtime pm */
+	if ((amdgpu_runtime_pm != 0) &&
+	    adev->pdev->vendor == PCI_VENDOR_ID_ATI &&
+	    adev->pdev->device == 0x731f &&
+	    adev->pdev->subsystem_vendor == PCI_VENDOR_ID_DELL)
+		return 0;
+
 	/* PCI_EXT_CAP_ID_VNDR extended capability is located at 0x100 */
 	if (!pci_find_ext_capability(adev->pdev, PCI_EXT_CAP_ID_VNDR))
 		DRM_WARN("System can't access extended configuration space, please check!!\n");
-- 
2.48.1

