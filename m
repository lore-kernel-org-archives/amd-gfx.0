Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8FF9C04FFE
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 20:47:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B63EE10E6A6;
	Tue, 14 May 2024 20:47:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PdDObi2t";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2049.outbound.protection.outlook.com [40.107.95.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8F2710E6A6
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 20:47:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JodzPyJwOMT32IGc8hr1oYLWZg9DjV4czE0XQf978VEdJs9PIdv7xDFl7feW/LCIwUir8BcgK3sIy1+ooH0JBlXGaEVew5Q0zKB52V905zUv6VR6UgOiE3qOXezSAsz8lWr9ECnYKIrTqMTMJI73oZDMShhVa49G8g60TM85wUg0mEm5YMJe97d2ivK9ANmYMBUUDR5QAwAY4Dj+30TkzcyMGrnEkpoII9KqIT0qOlIrljXWGFVbTKPtj0v32RcxDv0lEU2/iMUXRyV9H29ITggNDCmiwmF5FGMkS5TBJw15puaS4E5yYnZnGL95pk8wPSM+0VVqlcvus8bIgkoZ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+6M/WTVPnb6MDfwQKedLitm3oID7XipkU78mXOlZwo=;
 b=bt+Sl8kEh1XkEBo6wNFltQ8rdia0plp8F/OGG9X1sxOrGTf85+YobXuLhLS1WnqLuYTGE0Psp9vWz/M7NxGQ+96sCakpFj7TECy8QSUbrz5bDRsBiG4oHiedCnWzLBqbWFBkRQR2O67XaigfNHlQvkwY28rWkWASSYyN6AA1GpdlQOeubtZG87R5NB3rFlIcyn1bIp/66xnvH4cYmgjfLm8eO6dGbMRcDKgWM/1wqGbOUnJ7iflVYlxt4nmZJgcPBpJXDMdaaVMQLxRoovfdR/vxgYRgNEJ22PGqcMi71M84l27r+s4jVXEYaDbACF1hrOUmKKsDOqVN+QdGsTLbSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+6M/WTVPnb6MDfwQKedLitm3oID7XipkU78mXOlZwo=;
 b=PdDObi2t1a/B+Z3i8H3iKy4P3219V717dyGuoKT5zC/eG4h4SMVI3iK24sJC9d+w6SVrvugtQ3zH8mzGotJ9UB/2nvR9RXEImuSH7jbLVJljXp5l27P/GlARhci/knTrkWFu0mnRfy2ddrKFexjDKfK/3s4nBUSXsOANQNnQ/Jg=
Received: from BYAPR07CA0046.namprd07.prod.outlook.com (2603:10b6:a03:60::23)
 by MW4PR12MB6753.namprd12.prod.outlook.com (2603:10b6:303:1ec::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Tue, 14 May
 2024 20:47:31 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:60:cafe::b6) by BYAPR07CA0046.outlook.office365.com
 (2603:10b6:a03:60::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Tue, 14 May 2024 20:47:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Tue, 14 May 2024 20:47:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 14 May
 2024 15:47:29 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Pratap Nirujogi
 <pratap.nirujogi@amd.com>
Subject: [PATCH] drm/amdgpu: fix Kconfig for ISP
Date: Tue, 14 May 2024 16:47:14 -0400
Message-ID: <20240514204714.1230427-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|MW4PR12MB6753:EE_
X-MS-Office365-Filtering-Correlation-Id: aa331e3e-0eed-4d70-dd5b-08dc745712fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lRoHRpMssc4/NY8mj0EttvbmTyWVAuLTYwOvlqoknOWr2GkwK1PO7ipCXbta?=
 =?us-ascii?Q?OWBQmT6KsiSyWaDAJAil5IK5maagYpjryCX2L5xbKH5/Mt5LeHeoUa5me5N9?=
 =?us-ascii?Q?ICekPAR1xAzY9E2bF+/PLsTWbaW1AVkR1Fkswh8eKpxMH72aO8VKPR3CNvdr?=
 =?us-ascii?Q?SHoWXKcHw+15/LH2t/53XY2yCqVowid/fCYSTQSqzH6S64DVCXvcFku66Bo5?=
 =?us-ascii?Q?PoVz3M6b54hVSyElac9TT/XhwQtv3/i7CoS0F5FclhOCMSuB8EZ38kYNPZGv?=
 =?us-ascii?Q?VHJ1q+1g4jxkGcVe1GxKNneLGbuoeJaVEAzIuLlmrZEhnTS7N294xdIAFjFu?=
 =?us-ascii?Q?SOSLNm0rqnMsd2fNtiRjzjEYmeLFFGeJe/RRsKGNzixaDtbdCjubwuSJ02ah?=
 =?us-ascii?Q?EpHxrNBWnhBcefrOjKVT4F7F53OAEJzMQHyhnkX7RTUSXtQnUy4OPUEwdVxp?=
 =?us-ascii?Q?7gN7oPjq7rAPNy2y7Zf9UI1Nbou2HljypcSmDEzJ0emDsbcQ5Hs2GeQhf1Cv?=
 =?us-ascii?Q?XNVvoTTWiHMSRhCZGcn5+3iXjHFB1hPNdah9TGWYTiIxMlTfuJf8gwGT0gJy?=
 =?us-ascii?Q?ljmTtaqR/lDA5zOcHyUCgc/XngF7OUbDda/M97cvDK+e0ZHrsJ1vtn/SE6hR?=
 =?us-ascii?Q?7Dy4feNWKPkA+erPiURUB85Ai9iNa00ynV4nl92NXjYEWAWuFZi1IbqymwCY?=
 =?us-ascii?Q?stRYb1H5tdTEezDVtvmTPvgpomZVQobDjtiSVUHuzV5bvNuKWB3eIXQe387n?=
 =?us-ascii?Q?N/nPGJEpvvV25xer/2Ry4wYH0ioc8CK9QFehh9xAWK733P/ZLeGZGQQhs28y?=
 =?us-ascii?Q?NZ0AndXP5PmjWcnHy9qeX08pyB8+miDwV1KuNA90dOj7WYM0AAMFkZCAvwzC?=
 =?us-ascii?Q?B8DZCeWoAn3H1ugI86ycnkTcX6BL7nUG2pQll5F5D8Nh8TygNVbbzCSkZFGk?=
 =?us-ascii?Q?j1nPSbkFgsi/wCW1b6FsApitGekj1bbYVY+0JAtWDo8XaeshcLEwx1dKTStu?=
 =?us-ascii?Q?YvJ1o/4LBRXKgAaD0VunKus1aBpiy7DUNcNuwvHVQ0EdrpWb7Uq22JkeHQ7W?=
 =?us-ascii?Q?HhQYmfuPgyP/cCWmHVhM6I+yQDTj4AUtuUtCLi/zcmjva56yFLJiZL80TfK4?=
 =?us-ascii?Q?4ANnLGhqH808PG1MnF0K4ljCGmZBLPWW22mfhVB80R4QuiDTqeY3hmI/hL8B?=
 =?us-ascii?Q?hZh4JF0ChHSFqO/8Be+d8sfEoxapwNfmIiX2xOFKqdHib8umY5tuQMKSck79?=
 =?us-ascii?Q?MANJitsUIogV/FK5mwV9xumx/6OSUpn0EjteHQ2PAFcVrAkyw3Q3WG+N1Ume?=
 =?us-ascii?Q?6uJay621RRqbCbyk+zOx/VepZI8K60bQtJhKDbJWiDS1/UnATKUODzL8ZC1g?=
 =?us-ascii?Q?811KKmg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 20:47:30.7874 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa331e3e-0eed-4d70-dd5b-08dc745712fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6753
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

Add new config option and set proper dependencies for ISP.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Pratap Nirujogi <pratap.nirujogi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Kconfig  |  1 +
 drivers/gpu/drm/amd/amdgpu/Makefile |  2 ++
 drivers/gpu/drm/amd/isp/Kconfig     | 17 +++++++++++++++++
 3 files changed, 20 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/isp/Kconfig

diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
index 22d88f8ef5279..aa037ac7ef24f 100644
--- a/drivers/gpu/drm/amd/amdgpu/Kconfig
+++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
@@ -83,3 +83,4 @@ config DRM_AMDGPU_WERROR
 source "drivers/gpu/drm/amd/acp/Kconfig"
 source "drivers/gpu/drm/amd/display/Kconfig"
 source "drivers/gpu/drm/amd/amdkfd/Kconfig"
+source "drivers/gpu/drm/amd/isp/Kconfig"
diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 12ba76025cb7c..c95ec19a38264 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -325,6 +325,8 @@ amdgpu-y += $(AMD_DISPLAY_FILES)
 endif
 
 # add isp block
+ifneq ($(CONFIG_DRM_AMD_ISP),)
 amdgpu-y += amdgpu_isp.o
+endif
 
 obj-$(CONFIG_DRM_AMDGPU)+= amdgpu.o
diff --git a/drivers/gpu/drm/amd/isp/Kconfig b/drivers/gpu/drm/amd/isp/Kconfig
new file mode 100644
index 0000000000000..afa3579901009
--- /dev/null
+++ b/drivers/gpu/drm/amd/isp/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: MIT
+menu "ISP (Image Signal Processor) Configuration"
+	depends on DRM_AMDGPU
+
+config DRM_AMD_ISP
+	bool "Enable AMD Image Signal Processor IP support"
+	depends on DRM_AMDGPU
+	select MFD_CORE
+	select PM_GENERIC_DOMAINS if PM
+	help
+	Choose this option to enable ISP IP support for AMD SOCs.
+	This adds the ISP (Image Signal Processor) IP driver and wires
+	it up into the amdgpu driver.  The ACP block provides the DMA
+	engine for the V4L mipi driver. It is required for camera
+	on APUs which utilize a mipi camera.
+
+endmenu
-- 
2.45.0

