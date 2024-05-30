Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6445C25B7E
	for <amd-gfx@archiver.kernel.org>; Thu, 30 May 2024 01:35:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1097E11AA01;
	Thu, 30 May 2024 01:35:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V8KIqUVf";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00E5811AA01
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 May 2024 01:35:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oKmaO9jjfhybt1++kqNqTR8n1qJLiq4gd5d6ELZDzyEYNgEuOMT7iEMuw05Kc7HH5IwA9qNL4q4shmJtaneUHUw9Al3HRQ5RQOA/wMsh/XpNYZR36+NWH7C1tlBw9Rc7pSaGpxgg+w6fyc8O69c61qNZyftrHFoMgY6Mxi5IFN/BvWeqfmwnok42lWGQNFysuQZcHeRsXMyMi4fkVvFUTdT/pXwL15Ehp/c0Eo52ji4bdiq0CuFJ83xmdH19VMs3gz4wIVZ/pCBDok5KcvwwB9YK1STzwutfuMJ8QI/Lia1Yf4E+3YbWOyD27qAuK6NKEapPIAXTe+fHQZbmRXfXnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=272siVnJSdK/yI8AQ16CMR5T20gIi8u/F6KOuPCC5B0=;
 b=QMewFWe7SOZvk+1nIhTDeZGo2arjqTe98RJJAw+wANZEzj7eJcG7yRD1b95AZodBrzkl3v7hFZcCp1iALRpoyJaIDpNwkuMc4QPxSTY+WRoDM6xa4LMDVVLgkPcAX7bzJ+IGbJ6CJU0gS3q19QV9VabZZZZ3+NmBmrYYFi9JeAZfOEtKdKTGC7ckZgmX652ykhSijgiyofuy5sW2ksBBVf+4rJ3V+ZFsY16+wJrcC6rgxplFrnjf5oc7HL1wKRnQi2+dTTPt16muohQXw3o7xFKRSOLJm+D8E+k/3Q8BA/KF+oacnhvBp/W7v1HWM1tlcrbsHGfreKJvRoI9NHwf5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=272siVnJSdK/yI8AQ16CMR5T20gIi8u/F6KOuPCC5B0=;
 b=V8KIqUVfv7fm/y5LNhQbcWO6lXZHvz6czyzXpZviDpJw4oPHge1qTYW45ODJWpX6nvO3Ge6i1+ikKfMyDPgnv7ztCBR9yxJ3Tmevdw/rWcOYvCCFN7YEtwy/wmqVqE53H+jAXk0hxhPCHY3GyhsJUTuhEv573d/vJffmFT/Ks9Y=
Received: from CH0PR03CA0268.namprd03.prod.outlook.com (2603:10b6:610:e5::33)
 by LV2PR12MB5798.namprd12.prod.outlook.com (2603:10b6:408:17a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Thu, 30 May
 2024 01:35:04 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:e5:cafe::e9) by CH0PR03CA0268.outlook.office365.com
 (2603:10b6:610:e5::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Thu, 30 May 2024 01:35:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 01:35:03 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 29 May
 2024 20:34:38 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Pratap.Nirujogi@amd.com>,
 <Mario.Limonciello@amd.com>, <Bin.Du@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: disable lane0 L1TLB and enable lane1 L1TLB
Date: Thu, 30 May 2024 09:33:36 +0800
Message-ID: <20240530013337.20776-2-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240530013337.20776-1-yifan1.zhang@amd.com>
References: <20240530013337.20776-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|LV2PR12MB5798:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e50a23a-25a0-4f9d-9c80-08dc8048bab2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|1800799015|82310400017|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tw8thFvTbAiKaT0LTwobX4meDphaUIsxUbktvGzY843X3YuGuTbesi/oJxbp?=
 =?us-ascii?Q?qkWH5Vwjr387EA4LOiXyLGfE3mYbLyAKnPS8JYOkDO71ggjK7uxBUfXDq4rl?=
 =?us-ascii?Q?xucRVQPpH+woje+3TzBaJyQf/kE44lwCJbz673zHi4BkCxAPsA1F08l6/MvX?=
 =?us-ascii?Q?2YCE52qJimrrnKP6Ymc9GseKDRHvl4AcxuUlE+VZ6WU8Of/86N/Lh0R4zvCN?=
 =?us-ascii?Q?qebrV6xkciXhGfcEDRXeHJlc3RFLTiwf1b6vwQ35EllJLmf/3n2MH36YuNN+?=
 =?us-ascii?Q?lWeQp/foMrqeilfPDUejfBEB7C6PFmJ9Z82EMl2oiAnao+fxPCyMhxs85n6w?=
 =?us-ascii?Q?YEg2PLNHann0/Yj/f67QWLo44joTsXC5yHdVpe1kqcJF4vsa5tjeAgqzx9RU?=
 =?us-ascii?Q?15xcm9H+82wJQzZ09JwPhjJaRnbA1v0QL27B8tzaSzaZ9+OJAVldghMdKt++?=
 =?us-ascii?Q?Sy7P1qhjiku8uA2DLPqjzYiYIDTuY+/rRPd9VZYS33OjvHJnqmz8WmxJzXig?=
 =?us-ascii?Q?Ki5GsedfiPNAQFf89t9roCUp04FSZJCWMziY+wmKc1UIYLtAKRy1/76YVSM2?=
 =?us-ascii?Q?yR73TwTHePpPmaES2aFPHyp6PIg6HugmhlC2M7kEB75GuEWfxPFZcc/31dpB?=
 =?us-ascii?Q?Y479K7rCL1yCX+IY+CHUPKcpNK+p1SIvgO/scr5hIGOBWGmohGFMYfEguVKL?=
 =?us-ascii?Q?GpLc5JGPiMlOnVKxffDb0hcTvzHN+EoAa+bJGJbxVZrLK61Wsc2YRLaxkA/2?=
 =?us-ascii?Q?y+3Bd+EZqXmydZqUXz98eUzJL8PLaOZOWqQpywC8QGBusV3nPbdXYYph0R9O?=
 =?us-ascii?Q?Tcgr9VXunj0n/mHeriR1W+KNV1jv2FU9UKlg5hOr5zxvj8AheDUixWZasd0+?=
 =?us-ascii?Q?O63pho6l5kqf0PWZ9Cuu8vEhETLOw/lYb29+efQnBK9RZcUbRki9lPHb9Qrv?=
 =?us-ascii?Q?c3NG2ULyFB7j0eoVkKKGzTNSRJnpFv2BvsVodVynZrbi0BR5IFKT7OOC20Wf?=
 =?us-ascii?Q?jiUdYfL1QUSt/CvzRej6PqQH1HDXG2f1s7AYpCO+/YVWOA3I5HSDqwCTzuKy?=
 =?us-ascii?Q?CuoKcZIX1g0KnwMAMzvKCfo03z33P4vI3XMH8mspQO1iBSdzaJyAehhpC/aR?=
 =?us-ascii?Q?S+sOXiOYmX/tw7SwJiiu19dLPgxPvwh5SEXexoW/Bes3PCoUSbrZESYrtyfY?=
 =?us-ascii?Q?9mJc/naGT+WZqbEYvmAwyaRez6wd1gLQxbLHAytl/41HUsEHjjCqom5qUIJW?=
 =?us-ascii?Q?sI90lLEVeGMuqkQVoJ7aJkr2WvPmEBsbpMVAPMCgHArlDqg0ZIeU760NjaRE?=
 =?us-ascii?Q?gjujk1l2USIobaagLP1/45nT5sf4Qy6slrepuyubdCJ+XAyJrdn+lUr0sHbH?=
 =?us-ascii?Q?B1Ni8I58+VraZ/fEz/2LaC+Hb8Fy?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(82310400017)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 01:35:03.7411 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e50a23a-25a0-4f9d-9c80-08dc8048bab2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5798
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

This patch to disable lane0 L1TLB and enable lane1 L1TLB.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
index b22751a25c9c..8928f9160822 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
@@ -33,6 +33,10 @@
 #define regMMVM_L2_CNTL3_DEFAULT				0x80100007
 #define regMMVM_L2_CNTL4_DEFAULT				0x000000c1
 #define regMMVM_L2_CNTL5_DEFAULT				0x00003fe0
+#define regDAGB0_L1TLB_REG_RW_3_3                   0x00a4
+#define regDAGB0_L1TLB_REG_RW_3_3_BASE_IDX          1
+#define regDAGB1_L1TLB_REG_RW_3_3                   0x0163
+#define regDAGB1_L1TLB_REG_RW_3_3_BASE_IDX          1
 
 static const char *mmhub_client_ids_v3_3[][2] = {
 	[0][0] = "VMC",
@@ -396,6 +400,12 @@ static void mmhub_v3_3_init_saw_regs(struct amdgpu_device *adev)
 	WREG32_SOC15(MMHUB, 0, regMMVM_L2_SAW_CNTL4, tmp);
 }
 
+static void mmhub_v3_3_enable_tls(struct amdgpu_device *adev)
+{
+	WREG32_SOC15(MMHUB, 0, regDAGB0_L1TLB_REG_RW_3_3, 0);
+	WREG32_SOC15(MMHUB, 0, regDAGB1_L1TLB_REG_RW_3_3, 3);
+}
+
 static int mmhub_v3_3_gart_enable(struct amdgpu_device *adev)
 {
 	/* GART Enable. */
@@ -412,6 +422,9 @@ static int mmhub_v3_3_gart_enable(struct amdgpu_device *adev)
 	/* standalone alone walker init */
 	mmhub_v3_3_init_saw_regs(adev);
 
+	/* enable mmhub tls */
+	mmhub_v3_3_enable_tls(adev);
+
 	return 0;
 }
 
-- 
2.37.3

