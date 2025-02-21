Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BBCDC021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 17:10:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF6AE10EB06;
	Fri, 21 Feb 2025 17:10:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0Cr4WqjR";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EABAE10EB05
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 17:10:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=srpIsIPHNm/faAlranmHbaLLCusPFm6hwsJiluDjrM6GWccyMxIZHIOaGrCTwC346DdJRQ11mH8DGrdmTuWp6SLYo7Cgag6I/kH1pShO7gyB1KIQt7KxiNp11OimGv0y3JosEsP87uWxwQLXRgXsu1rn86whykML1hvDURDKARrWoJ+nohtXs+32fOVQkW5qvtk+LaSCobyNRXpzu74BsYY4udqjmIZ7AkcVSSN6LtpBkokXKXVpdGzUcuRMpgYRXf5pRRFFdOPlTwkr5keU7+DUmLC5ojFLvWPK7DJ7b3WzWuIFx5JsiZUkJn4loegHB2XsE2oLil+nuEMBzjB/OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7Prw+FL6BThjedvQ5RsTFoTsGwXvdwphrusM3nlHIU=;
 b=jL1lBrjQEQuo6dsSmNLs8iP0N5gAh0XSCQjzFC0Euc4o803kO8Xra1BtbsLNonHhfl9/S+UM6h2eelBh/9ybzGaV21kEQJy75ghrbW6R8M1kfLH75xr51LGpBm8aRXc5c2gmGX93uA8CpDE18xLbZeybM4Vv97ad3NUF+0rnzt/lSou4aGPUaHs7Fhpqr43AeWYUlCoyGo7m2h3ZXzx4FFRthasEscjaRgcJknXVJYkngqB3TCezYeAx2rtZqSHePAcCusvDZonNoznqhDhKC6Et4rmPvSHrj/////r9zd4uAdNLfff966oGhJ1hI4D3f+AOXLUKjvUn5LAbgXYsMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7Prw+FL6BThjedvQ5RsTFoTsGwXvdwphrusM3nlHIU=;
 b=0Cr4WqjR+7e99fsP3n+pIDgHsmSbBMZSRsEtKdWGAoCKhO2F20uUC4umSOf73dS4lV/0UMRW9cOdbPS9PzU5p5NHr3ahqQZ3zglQRMt6BljqdbDPDP8Gdbn0Fldqo/M9MmREAyXI+r2Wd2i1sIlEGpo4zrmqSkIlqWUDvtvqFlA=
Received: from CH0PR03CA0291.namprd03.prod.outlook.com (2603:10b6:610:e6::26)
 by BY1PR12MB8445.namprd12.prod.outlook.com (2603:10b6:a03:523::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Fri, 21 Feb
 2025 17:10:15 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::2f) by CH0PR03CA0291.outlook.office365.com
 (2603:10b6:610:e6::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 17:10:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 17:10:15 +0000
Received: from AUS-S16-AI-13.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 11:10:14 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: "amd-gfx @ lists . freedesktop . org" <amd-gfx@lists.freedesktop.org>,
 Alex Hung <alex.hung@amd.com>
CC: Harry Wentland <Harry.Wentland@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH 0/5] Add custom brightness curve support
Date: Fri, 21 Feb 2025 11:09:57 -0600
Message-ID: <20250221171002.209895-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|BY1PR12MB8445:EE_
X-MS-Office365-Filtering-Correlation-Id: db3acfb7-d35c-421c-0846-08dd529a9c15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CSbmNGl0IvlqZBQ92duqzHGpVo2eTrrt6w2ejoqoVHUnPcz6Y5CLZGkZOKZ4?=
 =?us-ascii?Q?SBPr7WZNwYeiiyGV+Bu+c/l3FG/HT2KhA3lX/xrhs8XytaiaVvHExiy14s0O?=
 =?us-ascii?Q?7448q+mj3iomsAMIPQ/Owdx7322GAC6axhUwADIgpnZjm5CQ8nD8MnzxV/Kn?=
 =?us-ascii?Q?bUGmll5+EmHDUtXmDqMlaJQctxG7FcBCAvhzi2byyG1VmKauHId5R+3XdL7R?=
 =?us-ascii?Q?GVOzwj0VyXBQDdqSKISWMXlV2YtgdateopjRr6p0+04fIoMJPsIuWVqdlAU0?=
 =?us-ascii?Q?hNUVEoCrzoeLap1Xk1kLkleTeXJlGHby9r7MZUjDp6rwkh7qlVYATT7DomLl?=
 =?us-ascii?Q?jeVAi9He6RIE9Yu3NjfRl0ECnqcwmYpqYPVlM5bPHwRsmdkoBnPzx5tXkexy?=
 =?us-ascii?Q?Lm02yl3XwqZkPftV1jmNzR42TYjF+XtiZ5k+3uBbdFZZfiP1yDKxJrdyBcd2?=
 =?us-ascii?Q?zcCmJgFf701OvyUkhz3vLcCp5SNNCjX1sYfGMX3Onk8Kz6tfRAyNc7cDKL2S?=
 =?us-ascii?Q?pAq/7nANVe77oZmWsF8jSZcEnTQ7F25h/0rHSoBqgZxZt44iv6h88lhpXnBr?=
 =?us-ascii?Q?GRfNVx1zOKSFjJw3OtBsbvFRSOyYbQJkv5gdVn77Uoy+7NiqD17Fl+igiCPy?=
 =?us-ascii?Q?ZSfRLAwZmR8qJ1LT18Ym6DIBbEduGL3+QQfiLjc+OPYOw6FWpAhZ3JZMY4OR?=
 =?us-ascii?Q?zqWpIa7IY6M2xxTEvBc8TFT1iBrpMchlClrOLoJtY5cVIoRd2lJNIXPccGxt?=
 =?us-ascii?Q?7emnKHXfA2WdMjemFKsUuNs8taq4eMuI/8U3dMc10kGRIifJUPiyjaMiGPTa?=
 =?us-ascii?Q?dnGy3PDgFdprB6W3mCBQV2TzafUWZgBdh3x5LlMlEfgdsxNx5BVKdTsfRx7b?=
 =?us-ascii?Q?gKu5aBonKmzdvQnlJKP0R8L1PMsBVv677OFepwDyKAVn1Di3aMFxLE+HeMIH?=
 =?us-ascii?Q?SKI6CT26gdAYQMxxEFabQGqwqphfriDklgzBsOlSHpCp+OpmlaqLNXcENxa/?=
 =?us-ascii?Q?YDAxzaaTYt8eU5QED9W/PsF3NMx/5KsEMao26oBXtKf8vtqR0PRfGAV8CKxt?=
 =?us-ascii?Q?epxj7sHwXhLtUvwFCohZyZIdvAHzGsvKcpbyUUnM3PPm124AFfTDHIQM6elo?=
 =?us-ascii?Q?56gr3rNFBOyrRM4NNjwpyp7C2KXy3ElGRtpMCMCkUztfyOKq1AFkoMi5Dpur?=
 =?us-ascii?Q?Vt+C0yLOWWd0r+RRSKpue5yNUJY1gdUgYatjxCaDLrg0QDu18NAkU0NQb19n?=
 =?us-ascii?Q?pITB9EGUfmfs1pmTDu0Ev8jDuJl885Chvmx3yRGDlKhcc4AyQHSKAu0ulmHJ?=
 =?us-ascii?Q?lzeH7W5MDrK8neYIxOVJq5UTk4TMA7lW6jQ14kQhtftJ4nUf8dzJ9wXQpSwA?=
 =?us-ascii?Q?FEwtg+wVqEuTIPiQKIh3C4p8h+S9hw9UekRQElF70CVOpL4czDa1eQL5v89Y?=
 =?us-ascii?Q?xVFHAyCX5m7+sbWyJu8KJNEPEloQojzH3RznI+wVtSML4TPDyK+btkqLgmzH?=
 =?us-ascii?Q?Pg8cKk+QrxxbRTU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 17:10:15.3074 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db3acfb7-d35c-421c-0846-08dd529a9c15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8445
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

Some OEMs support custom brightness curves where the ATIF method includes
a collection of data points where the input signal is mapped out to
percentage of luminance. This series shuffles around some code to add in
the ability to do that mapping in amdgpu_dm when brightness is set.

Mario Limonciello (5):
  drm/amd: Copy entire structure in amdgpu_acpi_get_backlight_caps()
  drm/amd: Pass luminance data to amdgpu_dm_backlight_caps
  drm/amd/display: Avoid operating on copies of backlight caps
  drm/amd/display: Add support for custom brightness curve
  drm/amd/display: Add a new dcdebugmask to allow turning off brightness
    curve

 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c      | 10 +--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 80 ++++++++++++-------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 20 +++++
 drivers/gpu/drm/amd/include/amd_acpi.h        |  9 +--
 drivers/gpu/drm/amd/include/amd_shared.h      |  4 +
 5 files changed, 81 insertions(+), 42 deletions(-)

-- 
2.43.0

