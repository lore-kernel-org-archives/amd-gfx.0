Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 120B5C282C6
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2025 18:52:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D3EB10ED22;
	Fri, 28 Feb 2025 18:52:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jkJUcJQG";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28AE810E337
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 18:52:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hfx89g0reFRweCHt+QeLOXzKE3hQQrT/Lp5Lr/80RIZVdPrATf8Vzs2U781XsC9wAYLmPpGFdHHELc1KYpodFzHkvp3kgpc8kutcIvpfqWqtJimKXPMHEx99zQWkdAnixefA39v1f02igw0ckUDOpUDchA0eVAX9NkVC9Wz5R+GB45Q6ZVslkViIp8T9lXv9q/z3XafbK20SPUZG9xzOqBa/8evJbTCMnS4ggfSpPLhCZdrSobIn4JT9AbX09C+liQ4fS67RQU13wtWnYhvuboQlAdZKvzk4/S6wh2U5nTxs8DFxOEj0YhXx3CIy3yng2CEqTeHSI9dMWtvcgzvmMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bswf2BiFxzbkr1eWwwKfiUGZF+dkxwCBTED675vRKwM=;
 b=Yoel6MVusuYOGY3clc9J2rOIgzGKgVB748UWiUPh7ROpKbBdULmdllKRTpBSHt8ff0pjG7iU4QtjrudGzHgBo624O1wjDqfBe1QJaKEAGSUSxW1bSfs4ahP/pHzV/aLPS3/QJ6WINkc1xGshhhyTSn417OKL3GfDaXbmvEmeT0JLy0XNf0ZBNY8igWOqN6sK9KM3gKrKrn7RbPFe/7NtO/9LWX/hD/AhrDzh1d84vZj6Who9AN+g8zwNpQ+ofMwulJO5TqfV/kGXperHRCLhzPkzmG+gLM+edrvhPb/30TYEGs+7tQTtYOmqu/tCl6l4jjqTQNLIXQCEwwz60WbFzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bswf2BiFxzbkr1eWwwKfiUGZF+dkxwCBTED675vRKwM=;
 b=jkJUcJQGdWzCJLb/UvUfMLDJKKQxFYCTrsUTts5/5osUbpyBobFYVNOWWERyWbqkbQKwK6HARCbl1K/K1rdpQCJPlU2QIfIJirUOUdpuSPcwVIQZr4TxqC264wlp5nybO4hHAEjaGyhyPIf9TdK0VJuVrxU0/ZDQUZUO8TDYwgE=
Received: from BN9PR03CA0846.namprd03.prod.outlook.com (2603:10b6:408:13d::11)
 by SJ0PR12MB5611.namprd12.prod.outlook.com (2603:10b6:a03:426::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 18:52:03 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:13d:cafe::6b) by BN9PR03CA0846.outlook.office365.com
 (2603:10b6:408:13d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.24 via Frontend Transport; Fri,
 28 Feb 2025 18:52:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 18:52:03 +0000
Received: from AUS-S16-AI-13.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 12:52:02 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alex.hung@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 5/5] drm/amd/display: Add a new dcdebugmask to allow
 turning off brightness curve
Date: Fri, 28 Feb 2025 12:51:45 -0600
Message-ID: <20250228185145.186319-6-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228185145.186319-1-mario.limonciello@amd.com>
References: <20250228185145.186319-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|SJ0PR12MB5611:EE_
X-MS-Office365-Filtering-Correlation-Id: 136c593d-eb6b-4b53-e862-08dd5828fda3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xk/joEakeNqjV3cImGPKPczI4/QG+8/9sj30wyrhrrbuRstLeCeMsg6Gyv8G?=
 =?us-ascii?Q?SmKHuxnMRD5rqw+7ZJ9T+9C3dya+Hxiw1MXbzyI1+AkpXkZH/76cwmTUZ7Cv?=
 =?us-ascii?Q?F37jV/wsYzzIsURhEdZhYJ29R4c1VVQHeHwpT4Joby/OlsyhSg7H2g5vcLZK?=
 =?us-ascii?Q?ncAEjTW9ipd+eAEg+sIA4LRvjh/1TSVlE9FuCS42whSj+cJT+/eoa6Ce2PJF?=
 =?us-ascii?Q?NhhAzsxJkxKXWgjdiX5IPjJih/p+NDJ1M8TCkncQPohBocPFYkVSxVVeGnwb?=
 =?us-ascii?Q?4SZlgo3gLtCfCLaOfdgE0yNFLXnFq0y+TgM+A5FmoGcd2FyWHGgVeACsnPQ+?=
 =?us-ascii?Q?1reX8YgVnNE7qx/ZGhTdKLfuRIFzzbgMIlIYGGhA+RZPH1GTMbuFablU1yQC?=
 =?us-ascii?Q?g0uPIshVQleuHYv608tfAf8+sLAcEuWK6LGmR8dp3aHwbvJKs0aNGCVBT0Vk?=
 =?us-ascii?Q?gHkA58bteXmmNMKNXXZKJGhHF7yYng60jpqxOobGBct8B83L4JRb82m1sVDY?=
 =?us-ascii?Q?bI2wsBUT4jnzaZhcYSFsTLJsVhv52Ru4sm5v0WnqXpNV8VJ+viMu7GMHTBLf?=
 =?us-ascii?Q?CI692ZP+1zAQS5Q5HiuffSjTl/C6Yv34mTklRl5B91HcvpnG8o2JKMxzDWYJ?=
 =?us-ascii?Q?bNbIk0EtZ96YECUvGABVnMCWkHvu+Pa/TSHd1Bzl/E5wBuj0+RfCYBPwO3FI?=
 =?us-ascii?Q?upNPNEQJCoJR8lWkk/K8ewRILi9gVR5dhs07rSm1CR4D6mfOYzgMpDazNTZn?=
 =?us-ascii?Q?Tfgb6EgYp8mHQS2nhzeOpbfuTiMWfs0nbEw4j26gIXV+RksnOSwRIGCDMMjJ?=
 =?us-ascii?Q?3CxwlQya4bNsuPfa7guhtqtf48xgBnr1mT/68ONIAdr4vO4/zbwxaKZ9ab1Q?=
 =?us-ascii?Q?LfFtpKdwnXFHc5B/sR+GjCrGh8XCrMw21682lzLUyFYqu9Vte/ldIPzPDaYH?=
 =?us-ascii?Q?Ujxfi5rgCunT+a5SsUXyQ2yQkTh7pcjovYkqu43a7a9bpDZ7/9GCu5Q2tpVi?=
 =?us-ascii?Q?lxwMuezwr8Jc2SjrrCRgcya0QgzKyDXsQXCqaI5ayMK/Ug96b1csI1QBAoDa?=
 =?us-ascii?Q?EQG5/hEvLpfJB18uKDKkkZ0nwXpGw+SsdLHNwXlOcXv7w4NiyWdRSKk6bmxn?=
 =?us-ascii?Q?KY8eiDCoWvFEhYAGXlQbnyAm+uINnr4GQVcodQelwf5IWhNnIpwzf/V8G4F+?=
 =?us-ascii?Q?6Qe04IEWJNsiQMSKAH6QKDf8A9FjOj3dSELMYYZ0jip94B18akt5Vr+OT9pH?=
 =?us-ascii?Q?8Mj3RX4ohcVcysK0nLmpy7toG3KMZiUR1OiOUnti89pcXJK0pLRspt0StEBI?=
 =?us-ascii?Q?QKJvWzPzpCehFN9vur2HcD0QRglOjuzj7AneKW7hzQcsDPIQYbzK1uS/+D4m?=
 =?us-ascii?Q?SJcaEs0quOLhPA+KKWfJfjjqdpYakDsYYCW++qGG05NQeT8I+iYSiTJMUNWs?=
 =?us-ascii?Q?7mkeILyWBn/MeZMsGLmO8AaowCpyz+GHJ41ScvCXf9hVgdD0udzqe6yI0oU7?=
 =?us-ascii?Q?1BJk1H+t5O+iaAE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 18:52:03.2542 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 136c593d-eb6b-4b53-e862-08dd5828fda3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5611
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

Upgrading the kernel may cause some systems that were previously not using
a firmware specified brightness curve to use one.

In the event of problems with this curve (for example an interpolation
error) add a new dcdebugmask value that can be used to turn it off.  Also
add an info message to show that custom brightness curves are currently in
use.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++++
 drivers/gpu/drm/amd/include/amd_shared.h          | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b252c67f2bc4..63b66e2c9ab9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4767,6 +4767,9 @@ static u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *c
 	for (int i = 0; i < caps->data_points; i++) {
 		u8 signal, lum;
 
+		if (amdgpu_dc_debug_mask & DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE)
+			break;
+
 		signal = caps->luminance_data[i].input_signal;
 		lum = caps->luminance_data[i].luminance;
 
@@ -4951,6 +4954,8 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 	} else
 		props.brightness = AMDGPU_MAX_BL_LEVEL;
 
+	if (caps.data_points && !(amdgpu_dc_debug_mask & DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE))
+		drm_info(drm, "Using custom brightness curve\n");
 	props.max_brightness = AMDGPU_MAX_BL_LEVEL;
 	props.type = BACKLIGHT_RAW;
 
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index c0538763ec1a..485b713cfad0 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -354,6 +354,10 @@ enum DC_DEBUG_MASK {
 	 * @DC_DISABLE_SUBVP: If set, disable DCN Sub-Viewport feature in amdgpu driver.
 	 */
 	DC_DISABLE_SUBVP = 0x20000,
+	/**
+	 * @DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE: If set, disable support for custom brightness curves
+	 */
+	DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE = 0x40000,
 };
 
 enum amd_dpm_forced_level;
-- 
2.48.1

