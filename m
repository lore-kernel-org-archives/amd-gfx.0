Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA0F4C021A4
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2025 17:08:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64C9B10EB46;
	Thu, 13 Feb 2025 17:08:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2rNpY6hA";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E13B10E021
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Feb 2025 17:08:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RaHts1Ud3x4UUuUOt7d4AOHolnyMzXYQDdRB4SuzkhhT105zjcdZzlzct1cOyxK2dAduAAfrH7dPsnn6PpLIy0rrzQhbKbT3M70/7kQwBWSp1NS+tOSJRgRs7kGf3/qLw0uqeLKXcXqHVsL4jdRrW7yxAcCHaRpupcy6c4v2dkyeCdcoXwzDuYhpPPVnoXbXTcJkHhgGjinbivoywVXUPTrvHphPkGY7T48XC5KW0MNPLuRJpvl/IxYdc2bfqfZ1JSHlql5LSxRJO+yQezFwazLbigLBmrEE2rPrpYkM3jNsIxWXBSKpH/UiHA5Wx6SodI6+/zI0TbBXXVZVC5RHOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXf/xFJl+G1I4M0k72Scql+twIGetojMxrGoJEg42f4=;
 b=IHTx0lyPQDx6sqiEc/1za7/A70v1stDojVc8xsLmWC47X6bcoxCv1/Vf1psD6wghNT11TgykeiaU+fVdLwu+UpZW5GGM/PeCeJWSJegdsw7k6IQLcJxAMpW4Lf92dWuEmRpI2kv+C+uM8jeqpvrw2iMStqJpo/yvLuGOi2+JiSI8N7A/3Y3UR72hYzE/yeS/dHQDX7Lg64lwLQumkdSS0dK7g7BxLcQtEgnOfHpSOoMNw8egLUCKG2efOIzpVQDemma+flJxNYfUbu9xhfXh7v5/Gz/15tYubWeW3g/JW0O+hY9bRnNTi2xdr7x0uvOjxxUu0ecuHK3Oq+RbT3XUkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXf/xFJl+G1I4M0k72Scql+twIGetojMxrGoJEg42f4=;
 b=2rNpY6hA9k7a2JW0jmvCNHp+M8bAyvqsla40lqWKjhLoWJrpvvYYH1CNDeSTkyjQWic9GlCBFT2uOIrdMA59HyZIjm1PSVWF5Ijt20NOq0FXfSAC+kcb8CIvVHmo+gfRq6nI09TZ4q/dJlLhowU46AmPV+Ed6nMk3Vmwn9OSKKA=
Received: from BY1P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::14)
 by SN7PR12MB6713.namprd12.prod.outlook.com (2603:10b6:806:273::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Thu, 13 Feb
 2025 17:08:20 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::14) by BY1P220CA0022.outlook.office365.com
 (2603:10b6:a03:5c3::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.16 via Frontend Transport; Thu,
 13 Feb 2025 17:08:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 17:08:19 +0000
Received: from work.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Feb
 2025 11:08:17 -0600
From: David Rosca <david.rosca@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Rosca <david.rosca@amd.com>
Subject: [PATCH] drm/amdgpu/display: Allow DCC for video formats on GFX12
Date: Thu, 13 Feb 2025 18:06:40 +0100
Message-ID: <20250213170639.30490-2-david.rosca@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|SN7PR12MB6713:EE_
X-MS-Office365-Filtering-Correlation-Id: 172b1d63-06a3-411a-1895-08dd4c510410
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JctIh6CpyF29ynaX+qGkmZBbTVaJ9l9VyN68WwOe1cxFrad6B+lLqht6wMPy?=
 =?us-ascii?Q?O05y2OXONQxFWVFqC9qRzMOG4bXG7YfCCExflry8nAxgWUCB0zjXdwTEds/b?=
 =?us-ascii?Q?1FkQF9dwBP5nsTY1jn95cEOcItOp+ES0useO1cYGxl9T64wevlCftSZeovEI?=
 =?us-ascii?Q?l098MqCKAZY9DaVzAha6nFO7h6fKtzPFR/f0NksTV5zYWazqaDj6wZo6B5lO?=
 =?us-ascii?Q?Vgu75Rw8bGD2b+dGkTA6caQsOCeF21Urg2WNpnV86wWLqTlBluLbs5CCyBU9?=
 =?us-ascii?Q?r5DfcIboYiHLQ96MYPPf5z+PEodNJPK0O8ddkAaCUc4bHIhVhhit7xlUfM43?=
 =?us-ascii?Q?PeD9HvPo0YsoXC5w3fsKh+2solWmzFaUMWkYOzgMTpz6TKG1QJpjDpvUfRrU?=
 =?us-ascii?Q?48lltBghPu/kmXmg6UnGzyBKI1V1q2KWfm+AnMRhDc1chGfyucdL1Oy0Fn4c?=
 =?us-ascii?Q?WYr6rYw7vU5u5Ghd94UfC9qhDsuuduAwEVb9UCGstzSTwTmtBV74QoRHzEsg?=
 =?us-ascii?Q?T3w33lpW0TnfrQXr85fS2Cas3+QWZqcnfhlnINTdd/sLRrP2r/YFIFxSeYEQ?=
 =?us-ascii?Q?90iE1/E9CgT8G5OaiiIHVdMVGzTtT+eYz0PGI3K0T4ljjH94r3DvxrdNMEow?=
 =?us-ascii?Q?nwaXBYNG7R1AlJ8aNZZ4ul/+SdnIA0/lCtmv/SpNz8qlmpxRVDJFrnLWFhKY?=
 =?us-ascii?Q?ER/ikO/Ul+UlmptWsLFGngPnwW3XsjNF7MqhKiNDar9FajPwZyXPTzGvREuA?=
 =?us-ascii?Q?aCYAWj95lMnNRsh30IIQXcVX9WPJNtNREE0iTKxZ0SqVSUirA/qgztGESHL2?=
 =?us-ascii?Q?L4x6jEGOvwfrW3MjxSuzSwy92nM3s32ZVz7XQMpTZMik4mDqR858dbWCDrVg?=
 =?us-ascii?Q?raqBX9K1V3tnWRmVyCsxERuTL7CuVjlT1B1z4L7Cpefro7RKHxM1vdl5LFI7?=
 =?us-ascii?Q?s/WH37XeCAZFhuCGxE/CShC7UIKIg1nd70Iy7ivfQ41SoTlXlWevrb9Bim66?=
 =?us-ascii?Q?E8WomomvhWSo7m7avxE3kn5LDDnUKYstK2AVn4YI1rN8pIZ3v9Iyh7H9o5jK?=
 =?us-ascii?Q?w3Y6CXSm00p2Tn0PruHPh56z1+fOohU1xnDMTFusJH3Ml+FvrKZwSUPmAaNE?=
 =?us-ascii?Q?WPDnLdTwDfKUhzQV4Ahzi3dT580iAOdV8cYTM1IsFM4Hd5JQ1MGvdwm4R8jy?=
 =?us-ascii?Q?NbtTQpJyLa3lMU6W9hvs/LBLjKdC1DesJ+jLrgsIV2QICSw+w/usA0Vyp034?=
 =?us-ascii?Q?+5+wMETB4B9zYhjPGCTGqj4IFUUihXNRXJ+9Kb9QyGMJ87VMKehpjP+X1sYR?=
 =?us-ascii?Q?pnTg3VOygq17jPxgdtYXjmxSIczhdoEEEt6SFZSOz6GVHm+oeroD0mA8AX6/?=
 =?us-ascii?Q?PfKYzDeQhAvpUhoRZ6gZYN0ILorFecSTOridxO6EqwLceUWe5zU2t7Gzgu7S?=
 =?us-ascii?Q?zDZRnhooRkRLD79vrDBNtRwdteixjNDFKPm37/XZCPcv7puovnsJ1vrPqbeG?=
 =?us-ascii?Q?ravbMUuzW+eQQu8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 17:08:19.9141 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 172b1d63-06a3-411a-1895-08dd4c510410
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6713
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

We advertise DCC as supported for NV12/P010 formats on GFX12,
but it would fail on this check on commit.

Signed-off-by: David Rosca <david.rosca@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 774cc3f4f3fd..92472109f84a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -277,8 +277,11 @@ static int amdgpu_dm_plane_validate_dcc(struct amdgpu_device *adev,
 	if (!dcc->enable)
 		return 0;
 
-	if (format >= SURFACE_PIXEL_FORMAT_VIDEO_BEGIN ||
-	    !dc->cap_funcs.get_dcc_compression_cap)
+	if (adev->family < AMDGPU_FAMILY_GC_12_0_0 &&
+	    format >= SURFACE_PIXEL_FORMAT_VIDEO_BEGIN)
+		return -EINVAL;
+
+	if (!dc->cap_funcs.get_dcc_compression_cap)
 		return -EINVAL;
 
 	input.format = format;
-- 
2.43.0

