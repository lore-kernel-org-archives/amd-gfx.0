Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E514C7115B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 19:49:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E51A910E285;
	Mon, 23 Jun 2025 19:49:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ukp2d3xK";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DD1710E285
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 19:49:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e4OVbVWGKR17HjYdBa7+rN6wKemwiGNVbfvDqHK9Ix30hxpCw84AoCiiJQEWJF1I2jqGPqazvy2o0H57vhTpt1DM+m3OXy8VQSqy0Qq1t/w7bWZVMa2IM7KV/IH5B2ZeZM0EBeTexaDHfJEqkR+Jvi+v+MdQxspMWydRC/Of60gFBvYx8/B3SZtZvHHsmls1cjg/qyUcOhP91klaYmMtSpKmH7hSBv7q6/5QI+7mDyZ0jGCi4OYNUYcaDGLsdUJ06plPYu8gOgMnwquhHIj22W36iI9euxO86vZDm4djeA0xSyLN4/z2URlkme7YNgXKgU6P3I3GtUquBUJ6X36itQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FmWYQCe66Q2pNWT+0zjbfnI9IxEIE61s8eesLWUcpk=;
 b=s5VdFoUmwc9Kpko5bAR4GvA7wepyjcuE1XqJOxSmB98w6sMsKRnB/vrdBkO7Duga0MXQ5gst9ccWwJdDqAY0A4M8vgFwiey/GrGhYghj1U7nLW/85DEKfOYUHM3kx31X6mhYs7S6RmA/VBR1RWedTzt91hSba7p7L89ngQU3tMPvUlIpBp0RKQtvWo0r6xh+oJJ5eq22IjVS8EwTt4xJymsu4fb8Zd007VdRrOoeQCibOlmgkoXRxoAdR+/eGsDleYyzkmtk8CL9TvwkUyit2Lvt2W9xHrxEDWaGhwyZOitX2hWYpENoIl8IJ1RqqLqFyGorIApulKPIkAs/E+Iyhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FmWYQCe66Q2pNWT+0zjbfnI9IxEIE61s8eesLWUcpk=;
 b=Ukp2d3xKbgHFT0ib4r9gGbktk1ymrqARTtkhf/cKWB1jN67ctgASHuGmB2ryEHfcYpu4FqtSRJLGH0cFQAUFsjAUIeqvGA/g1dbvxX6gkvc0pHlnDBsH65HsWCY18u9hS8/5nhTdIexQ5dYeR260KYecr7UK5j8Hn/GqG2BcpW4=
Received: from DS7P220CA0068.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::23) by
 DS7PR12MB8372.namprd12.prod.outlook.com (2603:10b6:8:eb::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.20; Mon, 23 Jun 2025 19:49:15 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:8:224:cafe::e7) by DS7P220CA0068.outlook.office365.com
 (2603:10b6:8:224::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Mon,
 23 Jun 2025 19:49:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.1 via Frontend Transport; Mon, 23 Jun 2025 19:49:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 14:49:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/sdma6: add more ucode version checks for userq
 support
Date: Mon, 23 Jun 2025 15:49:00 -0400
Message-ID: <20250623194900.144270-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|DS7PR12MB8372:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c44f522-5c52-4d7c-293f-08ddb28f0853
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Yi1/C//rrg5s2jWoYNH9Vh812S8uOk0BbBHS9DvhhSDGebeCfP0FLEyjMjQk?=
 =?us-ascii?Q?3KEL7Fl2C9ef4SlnQYgaaV0rFH0qyDHtAVJtZwbemvdGiJ4P4corXH2vlJLw?=
 =?us-ascii?Q?ezVjS2qfV3W6t21vFmerAPc1+DAI/XkfkOA6+cKauGM9V7cwx7JS/XG2uhDk?=
 =?us-ascii?Q?NYKMjLRgGh/i0j8t0fEgUGzEPXnYTZwzmL3YLbzvwvVc5JKTHjAKkq97wfA+?=
 =?us-ascii?Q?j48dT9uSlZtD5u+uWF0gmIdVhJGLuDM3oGIuqfVUhoz+6pi6H64fhew8kxLx?=
 =?us-ascii?Q?NLlIjcc52zp9b9VnCAVzY7rfVFHWfBLS5fqiMz2AVPOT/GJGApBLxXZgkAA8?=
 =?us-ascii?Q?Qx2cdmXmsB2cJgKKZ1+uKIsF07VX23mn8WW+WQ/jKaT+SNQvgXKegeuS602d?=
 =?us-ascii?Q?T4Sb8rETgkn3+CtirkPZHys23dxGdftwjfxiUfiLrflYCNQ/9cn4yh+MEYqr?=
 =?us-ascii?Q?suqmRbv+XjIFEsh9o933cTmGnWsMf0vZ8q86Q20ggrKbTssqAGHblK+tfcDW?=
 =?us-ascii?Q?AZsqHpvskB0+BzXSUZkfdD9pUb244kOjM2+4ximCd/16mBFbFEmN7YkYTaiF?=
 =?us-ascii?Q?Gg3IzchtsSesxfU6/yDGiqB3wyvYCJeJ4IBmBIt3iUiS++GpTwX2ktfPyZOw?=
 =?us-ascii?Q?1RMm8TMkptA7zY39zAnvAD8oyN3Zp08J/itkSpJ3ttIiUw/xQn8vRJy9oCy+?=
 =?us-ascii?Q?Vf0hSX0N+RnRrYXPaa7BAgac91j6HAXDDqy4k9Y7AANkcGFH9SMu9/BdwDdq?=
 =?us-ascii?Q?KRx96uAyNWstDVoyeMjQ8VSJlq8Op7RjZSNOl+aBjvq2k/PGY1/jiYxPpb7q?=
 =?us-ascii?Q?/y8O0tcArcQEKFOUOXxmm05AeOUYnSXfyU/gfHBWMx8MP3mUa9Cq0EOwmBuw?=
 =?us-ascii?Q?mG/RvtWHcAN/mK3wXNZCZ8wXtvfmn3zY89zBfeo1x8+H6s4V9BpvThraP2Fy?=
 =?us-ascii?Q?XLYwzUHyftWHf2z5VXMMck/ch2xflvWPN7u1P5CQYXKOJ95zTetBIrmDssG/?=
 =?us-ascii?Q?wQ3FJub1tqP+VDU8RxWPXKzkdTfCaJjTBCsKLZfkg8WNn9C1lySrbPWJrHYi?=
 =?us-ascii?Q?YLePK/S9/IJmqik/qyDcz6UwBU9GcBtpGhUamzBZg0NjvTSAdipjpf2ce7R2?=
 =?us-ascii?Q?IA2Li+KraATdrmd9ZZ4VrioNFtp68CclqAUaD/UPrDjd+lSZnB20oxOFxWjD?=
 =?us-ascii?Q?xtdmgM8u/4cYk9JZv1TJCZbuvNIO7vgyAuwX0X803TvlVamokRvXCYp19cMC?=
 =?us-ascii?Q?tju371fm06lTk+M7fOYPOHfPrww8XUg3Z//W3W1tnQizyhPUANh3y/ziLKqO?=
 =?us-ascii?Q?J5nxmTNlnIDC7x4oYrsBzoW+lj9UxenqTyLt9KB2Is2rrqHQBEezv1hQZz3Z?=
 =?us-ascii?Q?WwBCc/M93AhoFVXu+oyPsG41r7PgYg9O0kZKzOEiUcmwmv3IZA0tNyYYpoE8?=
 =?us-ascii?Q?iPKjoTZGfNkaOBbP5L/PSoovKOue99v05at4MvW5wDQxxNuVQE34YxEwcoru?=
 =?us-ascii?Q?8nH66mm2SMzmCUX8USx718fRi3+948Xnz1J5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 19:49:14.5591 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c44f522-5c52-4d7c-293f-08ddb28f0853
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8372
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

Fill in the SDMA ucode version checks for more SDMA 6.x parts.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index a9bdf8d61d6ce..2f3250d30bb01 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1379,6 +1379,10 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 		if ((adev->sdma.instance[0].fw_version >= 24) && !adev->sdma.disable_uq)
 			adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
 		break;
+	case IP_VERSION(6, 0, 1):
+		if ((adev->sdma.instance[0].fw_version >= 18) && !adev->sdma.disable_uq)
+			adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
+		break;
 	case IP_VERSION(6, 0, 2):
 		if ((adev->sdma.instance[0].fw_version >= 21) && !adev->sdma.disable_uq)
 			adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
@@ -1387,6 +1391,18 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 		if ((adev->sdma.instance[0].fw_version >= 25) && !adev->sdma.disable_uq)
 			adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
 		break;
+	case IP_VERSION(6, 1, 0):
+		if ((adev->sdma.instance[0].fw_version >= 11) && !adev->sdma.disable_uq)
+			adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
+		break;
+	case IP_VERSION(6, 1, 1):
+		if ((adev->sdma.instance[0].fw_version >= 14) && !adev->sdma.disable_uq)
+			adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
+		break;
+	case IP_VERSION(6, 1, 2):
+		if ((adev->sdma.instance[0].fw_version >= 12) && !adev->sdma.disable_uq)
+			adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
+		break;
 	default:
 		break;
 	}
-- 
2.49.0

