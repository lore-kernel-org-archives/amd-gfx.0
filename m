Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F5FC531DC
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Aug 2024 07:55:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25BD210E5C9;
	Fri, 16 Aug 2024 07:55:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i/xfn5WZ";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6458A10E5C9
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Aug 2024 07:55:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H/9D28gpB9CSPs46FOHjVnOKJcRfqhpjLZhTqOP1XxropKhoH/9Au9iuCw3JGAKDCdKBKXZTRBjxc3A+HIH91DnWVUifQpFJhKu9sZQfSl4fk6Vg0WvMYzpZh+nuJ+tF6Ff3fulH4hOUzMUlLUNLPn0XyRKV9FEGVQZf5CLcFB1IAQMHVr/rcplCLTB19b7GpL1QHQ8iu54OYs/CN9maugnRu/OoXIB7vuk0n99MzynSByIDYLdMjAEV0TFi4UsHTzU+Rph6Xcc4GsOKPrwPw9CRSArfby5ltI4u5RSxe2uTG8TaEc71yUd2TrPo/RU/gJUKQhF+3fG4LGIZUHrvag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iK9U+J0Ue4NYULPLFfx3E8ebh6MAKRNLJKXIZLabt60=;
 b=tLyXkgKc55sIfQqJhIBt6Eo3N44vjG+w+p9KU0+ernoJkbMdKm5qdwxdYPVE6i2e542NlTbPBAExCU0xo6ZwIPry2XlMOxyiAuFt25q/M8MbKOrFjfEhhRfvcnaLj4NY/VrpYEDpFjG+GY5FOfp2/vIBJDoSALAPHDqLsSh4yP1E6Hu44Nw9DccYCyu2rp7tTTE5Z8YlMj1xUjNoxSKv+RKpmcfoNwC2kfE4OGc448tjmpE6a935XbMRZACjIqsGTywgWyBshBR/OFSv/gcZfXkL3fQPKQgViiWgx85XPA4eGTuaYuT26yRzo/hu568ywADN8XYOH0Kv/qptagOT8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iK9U+J0Ue4NYULPLFfx3E8ebh6MAKRNLJKXIZLabt60=;
 b=i/xfn5WZnziACdsERGubB1ecg1MdMobL/+cwZQNp1aTXKh0EOz45d05qBzsjWgR5a442JMS8WZZaCzjpGMCFwAv3ovi58VveFGYFCosuo1OHayOJuME0EMUZxq1dapeWLOmv/fGnuraqjrU5QGdKTTb+0jPe8SxfFj4I425ugWs=
Received: from PH8PR20CA0021.namprd20.prod.outlook.com (2603:10b6:510:23c::26)
 by DS7PR12MB6192.namprd12.prod.outlook.com (2603:10b6:8:97::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.19; Fri, 16 Aug 2024 07:55:05 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:510:23c:cafe::4f) by PH8PR20CA0021.outlook.office365.com
 (2603:10b6:510:23c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.24 via Frontend
 Transport; Fri, 16 Aug 2024 07:55:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 07:55:04 +0000
Received: from lps-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 02:55:02 -0500
From: <Trigger.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <sunil.khatri@amd.com>, <alexander.deucher@amd.com>, Trigger Huang
 <Trigger.Huang@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: Add gpu_coredump parameter
Date: Fri, 16 Aug 2024 15:54:44 +0800
Message-ID: <20240816075447.442983-2-Trigger.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816075447.442983-1-Trigger.Huang@amd.com>
References: <20240816075447.442983-1-Trigger.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|DS7PR12MB6192:EE_
X-MS-Office365-Filtering-Correlation-Id: ea1e35b0-e446-463c-d2ce-08dcbdc8bd49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?khR9JNYFKVI36UcrmG09xqh7BQ4eWVZ09zMe3MJkyYquT1X2QB1YM8sKFURR?=
 =?us-ascii?Q?5WAnX0XsF/TP/0wRw6DPEcjIrt4HNOfJj2KSmAvNbezo/mpVh71218wx/7CI?=
 =?us-ascii?Q?5Nb0vF+d8q9tf8nb8IaIw+dnNTi4ivEQB023B29fzW8JLm370wsjA7R6+K8T?=
 =?us-ascii?Q?THQUeXAri395rgU7c+uwvc/ZEvG4ts/ePK3CbrjcVSKzFPtzADrevCu5JuDD?=
 =?us-ascii?Q?329XLV8EFI10M2uomtJAuZGJfeF71fXTMQKXGjheLHw92oyJqQFQsIihkXR4?=
 =?us-ascii?Q?EhliB+PBPMgaNSfyw1dEo6FikEKkFDeKnSxtOcaTtYarXclnjJgEgHySoGrm?=
 =?us-ascii?Q?rWoC2p/Vu1HpaJD5aZR3SjKYta4/pjJ5kdHnyAjoDaXdN4S4M3ONi9aKII3J?=
 =?us-ascii?Q?Z20/4y7t8xqn9i8US26UkJs1sZcpq58E8nuA07msdXgjb8aCEJIbPxGCxqtQ?=
 =?us-ascii?Q?8+Wyowhk51gKri9VNN/WC/ndk1aI0S4yWWhwXzqYGDRFB0OlHgincr00hGDU?=
 =?us-ascii?Q?SeG6FVozA9D1cERjrTTH9ukgPFneh8hwN9ghArLTAM5hl2eF+mpbJ/EhsRgC?=
 =?us-ascii?Q?OXA7zBh3UgnxVlhemSx7ID/QLhR//tnk7cnR4PiV745IVGxbhg95XC6EYqvg?=
 =?us-ascii?Q?Z22j56+OuVo4NfFSFcoGj8Cuk880Z3Oo1aYoq0YDlLPII6+IhPi8KJj0Q3ME?=
 =?us-ascii?Q?CowCj7hLH7TCzqSguap29ErFfXDclBO8FS6tiEUdiqLCEjs7bIqDS7ohHlWs?=
 =?us-ascii?Q?H3G3wpifbDKsGv3wsfPKvtGWGyrqt0EXyjFM2foWEKdjXYdUSJ85SsiwI+It?=
 =?us-ascii?Q?rpnO09w7JVUUTwP07CtUX6DGtI9gwbG5rkZ8bzI9ThblIAglQ9I+fyYDH3DK?=
 =?us-ascii?Q?qG2zjEovEg2HjkvlIzTxRXFRZ263DIYYlstvrJndKwx0L58VZdpB2gruLpsQ?=
 =?us-ascii?Q?e+7Wy4jdxGnPfclBYJwWAI3oq/CfMOkzsW+tMUtwl54ua+hhurpLKt/ZpedG?=
 =?us-ascii?Q?cpsLN8KL8Hduo9UDy7Xepgjso0Lh1GN8Hp+YoI/kxTYU3y60wk1pO7ugh5zL?=
 =?us-ascii?Q?M3RkB1kGyASS1ct7Y/lOvwZm8EBEeO10YPgSeIo1ekiZNGPApVRLyFa0Rjlx?=
 =?us-ascii?Q?ImUARDM7UuAc7qO8LLdpgvaaHQpny5DX/vJlqd7IuOIYimGBgGtGOCE9GHEz?=
 =?us-ascii?Q?W51CfiR1shB1h4bVdFlFDwDdH9IBj1UobLRbRLYAXrytWgpV4cGy+5Mk6/VD?=
 =?us-ascii?Q?7EtRpX/aZkSJNacKsufb9O2rvOSvbZrCIR+P1PCMkQ7NqGxfb7iqLrojCB5v?=
 =?us-ascii?Q?IcwUPAxihAmRoLqBgca+yWsg91G/mLqxFZ1WFweFA/25zv1a2cRQ3PqFrXcv?=
 =?us-ascii?Q?RME1wLbGxgWgWMj7migJkjGnrNnQ8c3UYv7FyftKan7zvnbD412f5h4J+VQA?=
 =?us-ascii?Q?mpgHtUQ0zrFjs04Lqy+u46VZiwZRhmqX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 07:55:04.5358 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea1e35b0-e446-463c-d2ce-08dcbdc8bd49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6192
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

From: Trigger Huang <Trigger.Huang@amd.com>

Add new separate parameter to control GPU coredump procedure. This can
be used to decouple the coredump procedure from gpu recovery procedure

V2: enable gpu_coredump by default (Alex)

Signed-off-by: Trigger Huang <Trigger.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 937de21a7142..4dd465ad14af 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -201,6 +201,7 @@ extern uint amdgpu_force_long_training;
 extern int amdgpu_lbpw;
 extern int amdgpu_compute_multipipe;
 extern int amdgpu_gpu_recovery;
+extern int amdgpu_gpu_coredump;
 extern int amdgpu_emu_mode;
 extern uint amdgpu_smu_memory_pool_size;
 extern int amdgpu_smu_pptable_id;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index b9529948f2b2..06bd20d83db7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -178,6 +178,7 @@ uint amdgpu_force_long_training;
 int amdgpu_lbpw = -1;
 int amdgpu_compute_multipipe = -1;
 int amdgpu_gpu_recovery = -1; /* auto */
+int amdgpu_gpu_coredump = 1;
 int amdgpu_emu_mode;
 uint amdgpu_smu_memory_pool_size;
 int amdgpu_smu_pptable_id = -1;
@@ -556,6 +557,13 @@ module_param_named(compute_multipipe, amdgpu_compute_multipipe, int, 0444);
 MODULE_PARM_DESC(gpu_recovery, "Enable GPU recovery mechanism, (1 = enable, 0 = disable, -1 = auto)");
 module_param_named(gpu_recovery, amdgpu_gpu_recovery, int, 0444);
 
+/**
+ * DOC: gpu_coredump (int)
+ * Set to enable GPU coredump mechanism (1 = enable, 0 = disable). The default is 1
+ */
+MODULE_PARM_DESC(gpu_coredump, "Enable GPU coredump mechanism, (1 = enable(default), 0 = disable)");
+module_param_named(gpu_coredump, amdgpu_gpu_coredump, int, 0444);
+
 /**
  * DOC: emu_mode (int)
  * Set value 1 to enable emulation mode. This is only needed when running on an emulator. The default is 0 (disabled).
-- 
2.34.1

