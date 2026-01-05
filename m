Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A017CCF2D5
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Jan 2026 20:14:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D55C10E40B;
	Mon,  5 Jan 2026 20:14:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IMkhxuCK";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011031.outbound.protection.outlook.com
 [40.93.194.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 586EC10E3FE
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Jan 2026 20:13:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k8iby0u/qJwd9uJLvufTmptjBi+iD4V50pNpoZaACSHEyyGHvExvvlumsfXWEYroSEqVYKLdjE45LaN1Gha/YuyIEQUjNYo4Eg1QgqI9UU15RCEn12eInVmZfCQuBk6KJcRGvb+bYpTaBSI8prxQBskxQsxH4leTPF7QcWdzjwgcwfM7t3RR6CzqFPdgvsZ3t34h6qKKgse1MeLHR9RrApgbqvpPoZXwsFzBWvX4FO9IR794b62I2ptdtzSHCg8/ItKN9yF4VbqATyYV0ulFs/UpVMWPS5R3qmYn32aY1Y5ZvhymvUdIAGHcr0fq3fVspVdqBwQZ/lw0Y9Xa/cXiJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnpI82vF2G9B1QluWDblV6k664G+WZd+eQ7MVRzFUwc=;
 b=UJe5ctlpPRAfXhz5tGuFSsVZL8MufsNwBHL+wzq9NKlevFbJqb9fH5RgJi7Z/ynPJZ2frOjwpRNu4EtU5JT5Pb3UzsGo9QRq5Z+Jtem1ttLlekAkfrHTM2yU9qgCFe1rsSKpkVVLPVxL868Xclu5W4gl8sVw3VX/8LvOJIEIBziUiJrlTiNrYfPTcVOLp3cBPskyN1SW7k9yl0KYuVa+/CA7skCy+OiUAmyHfImO+mknqQ69sjBJ165LXYjjtOxb4oraJhpMvGX23GYOY4ZCkaIi4a5Q/u3H4gIYmLOudwyXpeJqlvR8G0okgqMdKlM3S8uEiGjdm+jRzPAtHbuGhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnpI82vF2G9B1QluWDblV6k664G+WZd+eQ7MVRzFUwc=;
 b=IMkhxuCKqyKfWV/wpO3a44PLPfmzl4eqRqo/D1YmLeqHHdmpRgmfUZK49sqZxpoWX1zdJxwfGdshl0aGKfYgIas0WCfZxwmEaqRR0GksESECZJNUhUjX4dJ1Ablhh4KEJceIHOGo/fnR60joGofmYVD7XgEwyMlpZKUJ2MR15jQ=
Received: from MN0PR04CA0026.namprd04.prod.outlook.com (2603:10b6:208:52d::17)
 by DS0PR12MB7770.namprd12.prod.outlook.com (2603:10b6:8:138::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 20:13:35 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:208:52d:cafe::81) by MN0PR04CA0026.outlook.office365.com
 (2603:10b6:208:52d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Mon, 5
 Jan 2026 20:13:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.0 via Frontend Transport; Mon, 5 Jan 2026 20:13:35 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 5 Jan
 2026 14:13:33 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 5 Jan
 2026 12:13:33 -0800
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 5 Jan 2026 14:13:32 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 5/5] drm/amd: Enable SMU 15_0_0 support
Date: Mon, 5 Jan 2026 15:13:18 -0500
Message-ID: <20260105201318.64865-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260105201318.64865-1-alexander.deucher@amd.com>
References: <20260105201318.64865-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|DS0PR12MB7770:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a1d1bd8-72f1-491d-587a-08de4c96e82e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1SiaAkaAj5bdnVckPRFt5MvKEGgtS9970+CE89PnTZaYIyepbH/SX7ld/hVZ?=
 =?us-ascii?Q?Nl9V3hYw0v/33vYkx01xN4Xnw78V6/lasg8TFS9SscdP+ljsRCty2MaEalg5?=
 =?us-ascii?Q?zfh3Jy/4Fa3behHPD53SnB3obIwFbhKcPhS4I1FguC4WHVp0XWEkcV8YygMh?=
 =?us-ascii?Q?pmEpXXPr0fbWKtGGZhkUjcLpmdlsu8AVZNz6tNRogU9RJ9DhnMoxPShQg4OX?=
 =?us-ascii?Q?OTZFhTxXvm3C7djMulIRXKT3EwbTnKDjVZLKRU/aP32wX2s/rHaoSACYNpPZ?=
 =?us-ascii?Q?OJtSxI4QNDBb/q8r9/EcJM2cORswwHEUJN+1sunrlm9pw7QTWT8DuQt4bEUq?=
 =?us-ascii?Q?mFXrAh2s9nxIdLbNje7iM8ATgFLQJmKsX5Iw0aUK7bmbBw6cSEwqB24i0dUj?=
 =?us-ascii?Q?tpKfKmpKTvM/pQW60TbIU9Py7c7ynheeVXrGFjBTkKb2rCtj7tl/qKdyelBI?=
 =?us-ascii?Q?9rrM5KQWHaV4fWpKnZ89DPsSW6TkKbJrTm9eaEZxJj7AnX5S8yEBp1kWIEGe?=
 =?us-ascii?Q?A3c1tSTcg3GSTeDnIrrsxGJB3T0J6GbDhHluoKd5Sas6P1BBDzW3FRfwL6D5?=
 =?us-ascii?Q?tipiccskT7TcYwfHW79eCQ+cXS6NC0A0f7euDyIbyuM4MNnCl1tZyeHZcj+l?=
 =?us-ascii?Q?JRAO6Eq9+AqoBxE5GzApfgcPSe2xBfqygJJrcBXtdFYxBtpj8KiQs/WoisMO?=
 =?us-ascii?Q?otkKge/I3ayekprQi3bVLUaP2+gkp4PCDPxFlkHMLlAi3+/vcp/5JlAEisTN?=
 =?us-ascii?Q?EhqWNfrk1CdD0MjPcDyZ+WRPHMDxpvctV80Ut42sNmn5k0JDixfd3AcvSMb6?=
 =?us-ascii?Q?yJuHp4iIC7w1yugd8jjA/l43htPPpdG0mGnq++b6GHInKPTRuXxSXCkCaXDF?=
 =?us-ascii?Q?0SsQio7F4fETXmFyu3Fa1SXbV7Erpuq1YKCKU3ygbsYlyPn3Ajnd89J/TrN7?=
 =?us-ascii?Q?EsniqblwYwDw5wZax0W6GQFU9ilPXBk0VShxpgfNNXo2cVKnQzPJjerXxtG/?=
 =?us-ascii?Q?f3+BBo2xnjLalT0JbJfQVT8HBHIKMeKwP7tpZ7ArDNUHl7uWMft3vGOF1EdU?=
 =?us-ascii?Q?Dh7moAB95y+N4a26ifPYiSTh/h5fqubp9I1PFMQB5IHB4GQn83PMdd2HPZRE?=
 =?us-ascii?Q?hVrgnEW3hTy8KlrVuk962KFMwXyqFvYuktoGECthzr/m0kfOPAyqOxVompsI?=
 =?us-ascii?Q?Bc1PgzvOjukQtpsJN0tUiqzLsXJe+CGed3fjKxxOZmwIuHUPbBMjwGNIdgRn?=
 =?us-ascii?Q?CEgCRcd5KIE4KBoxRm/+98d4lE6PbT80bBxJJPEkL3dxu+S9xCzgjdZajLNo?=
 =?us-ascii?Q?dBMCzVy9EU4BOIzZgm8zRf24hh6/DTfqIqFk8CQLgzm8PktXrbjJF0Qtgt8d?=
 =?us-ascii?Q?rxx0Ac/puL2XqtzCayIUSB0vCDr0YXuMfY9skWYH5um+wZqa4VeNGqJOpc7v?=
 =?us-ascii?Q?nMunb5evFrx24ukxaBLuJqcwvyvOsMvmsbyTeLVGN5udSAfbboHXNEtwjaMr?=
 =?us-ascii?Q?5QUBQccmXWF/F7h0cIoHxcnZrsxzeeIgJOBb935y4AjR0zNvuOZey9tiXhno?=
 =?us-ascii?Q?8cbp7kP+GgB8LQI6l+A=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 20:13:35.6914 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a1d1bd8-72f1-491d-587a-08de4c96e82e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7770
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

From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>

Add SMU 15_0_0

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |    3 +
 .../gpu/drm/amd/include/kgd_pp_interface.h    |    1 +
 drivers/gpu/drm/amd/pm/Makefile               |    1 +
 drivers/gpu/drm/amd/pm/swsmu/Makefile         |    2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |   12 +
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |    1 +
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |    6 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h  |  247 +++
 drivers/gpu/drm/amd/pm/swsmu/smu15/Makefile   |   30 +
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c    | 1843 +++++++++++++++++
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 1352 ++++++++++++
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h  |   28 +
 12 files changed, 3524 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu15/Makefile
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 1d91de35237ba..8070a6da794f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2238,6 +2238,9 @@ static int amdgpu_discovery_set_smu_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(14, 0, 5):
 		amdgpu_device_ip_block_add(adev, &smu_v14_0_ip_block);
 		break;
+	case IP_VERSION(15, 0, 0):
+		amdgpu_device_ip_block_add(adev, &smu_v15_0_ip_block);
+		break;
 	default:
 		dev_err(adev->dev,
 			"Failed to add smu ip block(MP1_HWIP:0x%x)\n",
diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 2a454f06c022e..9fd78fcff15c3 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -29,6 +29,7 @@ extern const struct amdgpu_ip_block_version smu_v11_0_ip_block;
 extern const struct amdgpu_ip_block_version smu_v12_0_ip_block;
 extern const struct amdgpu_ip_block_version smu_v13_0_ip_block;
 extern const struct amdgpu_ip_block_version smu_v14_0_ip_block;
+extern const struct amdgpu_ip_block_version smu_v15_0_ip_block;
 
 enum smu_temp_metric_type {
 	SMU_TEMP_METRIC_BASEBOARD,
diff --git a/drivers/gpu/drm/amd/pm/Makefile b/drivers/gpu/drm/amd/pm/Makefile
index ebbf188f625c1..a4dde44f7a44d 100644
--- a/drivers/gpu/drm/amd/pm/Makefile
+++ b/drivers/gpu/drm/amd/pm/Makefile
@@ -31,6 +31,7 @@ subdir-ccflags-y += \
 		-I$(FULL_AMD_PATH)/pm/swsmu/smu12 \
 		-I$(FULL_AMD_PATH)/pm/swsmu/smu13 \
 		-I$(FULL_AMD_PATH)/pm/swsmu/smu14 \
+		-I$(FULL_AMD_PATH)/pm/swsmu/smu15 \
 		-I$(FULL_AMD_PATH)/pm/powerplay/inc \
 		-I$(FULL_AMD_PATH)/pm/powerplay/smumgr\
 		-I$(FULL_AMD_PATH)/pm/powerplay/hwmgr \
diff --git a/drivers/gpu/drm/amd/pm/swsmu/Makefile b/drivers/gpu/drm/amd/pm/swsmu/Makefile
index e5fdda49c96ce..178b102a8845d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/Makefile
+++ b/drivers/gpu/drm/amd/pm/swsmu/Makefile
@@ -22,7 +22,7 @@
 
 AMD_SWSMU_PATH = ../pm/swsmu
 
-SWSMU_LIBS = smu11 smu12 smu13 smu14
+SWSMU_LIBS = smu11 smu12 smu13 smu14 smu15
 
 AMD_SWSMU = $(addsuffix /Makefile,$(addprefix $(FULL_AMD_PATH)/pm/swsmu/,$(SWSMU_LIBS)))
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index b7dfd98d387d3..f774b06e7e85e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -46,6 +46,7 @@
 #include "smu_v13_0_7_ppt.h"
 #include "smu_v14_0_0_ppt.h"
 #include "smu_v14_0_2_ppt.h"
+#include "smu_v15_0_0_ppt.h"
 #include "amd_pcie.h"
 
 /*
@@ -796,6 +797,9 @@ static int smu_set_funcs(struct amdgpu_device *adev)
 	case IP_VERSION(14, 0, 3):
 		smu_v14_0_2_set_ppt_funcs(smu);
 		break;
+	case IP_VERSION(15, 0, 0):
+		smu_v15_0_0_set_ppt_funcs(smu);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -2806,6 +2810,14 @@ const struct amdgpu_ip_block_version smu_v14_0_ip_block = {
 	.funcs = &smu_ip_funcs,
 };
 
+const struct amdgpu_ip_block_version smu_v15_0_ip_block = {
+	.type = AMD_IP_BLOCK_TYPE_SMC,
+	.major = 15,
+	.minor = 0,
+	.rev = 0,
+	.funcs = &smu_ip_funcs,
+};
+
 const struct ras_smu_drv *smu_get_ras_smu_driver(void *handle)
 {
 	struct smu_context *smu = (struct smu_context *)handle;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 1aa7d653df7d3..b43c7cbcf75a3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1633,6 +1633,7 @@ typedef enum {
 	METRICS_THROTTLER_RESIDENCY_THM_CORE,
 	METRICS_THROTTLER_RESIDENCY_THM_GFX,
 	METRICS_THROTTLER_RESIDENCY_THM_SOC,
+	METRICS_AVERAGE_NPUCLK,
 } MetricsMember_t;
 
 enum smu_cmn2asic_mapping_type {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index 9b71a8afdd351..584c4cfd0c16f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -288,7 +288,11 @@
 	__SMU_DUMMY_MAP(GetBadPageIpid), \
 	__SMU_DUMMY_MAP(EraseRasTable),  \
 	__SMU_DUMMY_MAP(SetFastPptLimit), \
-	__SMU_DUMMY_MAP(GetFastPptLimit),
+	__SMU_DUMMY_MAP(GetFastPptLimit), \
+	__SMU_DUMMY_MAP(AllowZstates), \
+	__SMU_DUMMY_MAP(GetSmartShiftStatus), \
+	__SMU_DUMMY_MAP(EnableLSdma), \
+	__SMU_DUMMY_MAP(DisableLSdma),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
new file mode 100644
index 0000000000000..9020317ffd691
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
@@ -0,0 +1,247 @@
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+#ifndef __SMU_V15_0_H__
+#define __SMU_V15_0_H__
+
+#include "amdgpu_smu.h"
+
+#define SMU15_DRIVER_IF_VERSION_INV 0xFFFFFFFF
+#define SMU15_DRIVER_IF_VERSION_SMU_V15_0 0x7
+
+
+#define FEATURE_MASK(feature) (1ULL << feature)
+
+/* MP Apertures */
+#define MP0_Public			0x03800000
+#define MP0_SRAM			0x03900000
+#define MP1_Public			0x03b00000
+#define MP1_SRAM			0x03c00004
+
+/* address block */
+#define smnMP1_FIRMWARE_FLAGS		0x3010024
+#define smnMP1_PUB_CTRL			0x3010d10
+
+#define MAX_DPM_LEVELS 16
+#define MAX_PCIE_CONF 3
+
+#define SMU15_TOOL_SIZE			0x19000
+
+#define CTF_OFFSET_EDGE			5
+#define CTF_OFFSET_HOTSPOT		5
+#define CTF_OFFSET_MEM			5
+
+extern const int decoded_link_speed[5];
+extern const int decoded_link_width[8];
+
+#define DECODE_GEN_SPEED(gen_speed_idx)		(decoded_link_speed[gen_speed_idx])
+#define DECODE_LANE_WIDTH(lane_width_idx)	(decoded_link_width[lane_width_idx])
+
+struct smu_15_0_max_sustainable_clocks {
+	uint32_t display_clock;
+	uint32_t phy_clock;
+	uint32_t pixel_clock;
+	uint32_t uclock;
+	uint32_t dcef_clock;
+	uint32_t soc_clock;
+};
+
+struct smu_15_0_dpm_clk_level {
+	bool				enabled;
+	uint32_t			value;
+};
+
+struct smu_15_0_dpm_table {
+	uint32_t			min;        /* MHz */
+	uint32_t			max;        /* MHz */
+	uint32_t			count;
+	bool				is_fine_grained;
+	struct smu_15_0_dpm_clk_level	dpm_levels[MAX_DPM_LEVELS];
+};
+
+struct smu_15_0_pcie_table {
+	uint8_t  pcie_gen[MAX_PCIE_CONF];
+	uint8_t  pcie_lane[MAX_PCIE_CONF];
+	uint16_t clk_freq[MAX_PCIE_CONF];
+	uint32_t num_of_link_levels;
+};
+
+struct smu_15_0_dpm_tables {
+	struct smu_15_0_dpm_table        soc_table;
+	struct smu_15_0_dpm_table        gfx_table;
+	struct smu_15_0_dpm_table        uclk_table;
+	struct smu_15_0_dpm_table        eclk_table;
+	struct smu_15_0_dpm_table        vclk_table;
+	struct smu_15_0_dpm_table        dclk_table;
+	struct smu_15_0_dpm_table        dcef_table;
+	struct smu_15_0_dpm_table        pixel_table;
+	struct smu_15_0_dpm_table        display_table;
+	struct smu_15_0_dpm_table        phy_table;
+	struct smu_15_0_dpm_table        fclk_table;
+	struct smu_15_0_pcie_table       pcie_table;
+};
+
+struct smu_15_0_dpm_context {
+	struct smu_15_0_dpm_tables  dpm_tables;
+	uint32_t                    workload_policy_mask;
+	uint32_t                    dcef_min_ds_clk;
+};
+
+enum smu_15_0_power_state {
+	smu_15_0_POWER_STATE__D0 = 0,
+	smu_15_0_POWER_STATE__D1,
+	smu_15_0_POWER_STATE__D3, /* Sleep*/
+	smu_15_0_POWER_STATE__D4, /* Hibernate*/
+	smu_15_0_POWER_STATE__D5, /* Power off*/
+};
+
+struct smu_15_0_power_context {
+	uint32_t	power_source;
+	uint8_t		in_power_limit_boost_mode;
+	enum smu_15_0_power_state power_state;
+};
+
+#if defined(SWSMU_CODE_LAYER_L2) || defined(SWSMU_CODE_LAYER_L3)
+
+int smu_v15_0_init_microcode(struct smu_context *smu);
+
+void smu_v15_0_fini_microcode(struct smu_context *smu);
+
+int smu_v15_0_load_microcode(struct smu_context *smu);
+
+int smu_v15_0_init_smc_tables(struct smu_context *smu);
+
+int smu_v15_0_fini_smc_tables(struct smu_context *smu);
+
+int smu_v15_0_init_power(struct smu_context *smu);
+
+int smu_v15_0_fini_power(struct smu_context *smu);
+
+int smu_v15_0_check_fw_status(struct smu_context *smu);
+
+int smu_v15_0_setup_pptable(struct smu_context *smu);
+
+int smu_v15_0_get_vbios_bootup_values(struct smu_context *smu);
+
+int smu_v15_0_check_fw_version(struct smu_context *smu);
+
+int smu_v15_0_set_driver_table_location(struct smu_context *smu);
+
+int smu_v15_0_set_tool_table_location(struct smu_context *smu);
+
+int smu_v15_0_notify_memory_pool_location(struct smu_context *smu);
+
+int smu_v15_0_system_features_control(struct smu_context *smu,
+				      bool en);
+
+int smu_v15_0_set_allowed_mask(struct smu_context *smu);
+
+int smu_v15_0_notify_display_change(struct smu_context *smu);
+
+int smu_v15_0_get_current_power_limit(struct smu_context *smu,
+				      uint32_t *power_limit);
+
+int smu_v15_0_set_power_limit(struct smu_context *smu,
+			      enum smu_ppt_limit_type limit_type,
+			      uint32_t limit);
+
+int smu_v15_0_gfx_off_control(struct smu_context *smu, bool enable);
+
+int smu_v15_0_register_irq_handler(struct smu_context *smu);
+
+int smu_v15_0_baco_set_armd3_sequence(struct smu_context *smu,
+				      enum smu_baco_seq baco_seq);
+
+int smu_v15_0_get_bamaco_support(struct smu_context *smu);
+
+enum smu_baco_state smu_v15_0_baco_get_state(struct smu_context *smu);
+
+int smu_v15_0_baco_set_state(struct smu_context *smu, enum smu_baco_state state);
+
+int smu_v15_0_baco_enter(struct smu_context *smu);
+int smu_v15_0_baco_exit(struct smu_context *smu);
+
+int smu_v15_0_get_dpm_ultimate_freq(struct smu_context *smu, enum smu_clk_type clk_type,
+				    uint32_t *min, uint32_t *max);
+
+int smu_v15_0_set_soft_freq_limited_range(struct smu_context *smu, enum smu_clk_type clk_type,
+					  uint32_t min, uint32_t max, bool automatic);
+
+int smu_v15_0_set_hard_freq_limited_range(struct smu_context *smu,
+					  enum smu_clk_type clk_type,
+					  uint32_t min,
+					  uint32_t max);
+
+int smu_v15_0_set_performance_level(struct smu_context *smu,
+				    enum amd_dpm_forced_level level);
+
+int smu_v15_0_set_power_source(struct smu_context *smu,
+			       enum smu_power_src_type power_src);
+
+int smu_v15_0_set_single_dpm_table(struct smu_context *smu,
+				   enum smu_clk_type clk_type,
+				   struct smu_15_0_dpm_table *single_dpm_table);
+
+int smu_v15_0_gfx_ulv_control(struct smu_context *smu,
+			      bool enablement);
+
+int smu_v15_0_wait_for_event(struct smu_context *smu, enum smu_event_type event,
+			     uint64_t event_arg);
+
+int smu_v15_0_set_vcn_enable(struct smu_context *smu,
+			      bool enable,
+			      int inst);
+
+int smu_v15_0_set_jpeg_enable(struct smu_context *smu,
+			      bool enable);
+
+int smu_v15_0_init_pptable_microcode(struct smu_context *smu);
+
+int smu_v15_0_run_btc(struct smu_context *smu);
+
+int smu_v15_0_gpo_control(struct smu_context *smu,
+			  bool enablement);
+
+int smu_v15_0_deep_sleep_control(struct smu_context *smu,
+				 bool enablement);
+
+int smu_v15_0_set_gfx_power_up_by_imu(struct smu_context *smu);
+
+int smu_v15_0_set_default_dpm_tables(struct smu_context *smu);
+
+int smu_v15_0_get_pptable_from_firmware(struct smu_context *smu,
+					void **table,
+					uint32_t *size,
+					uint32_t pptable_id);
+
+int smu_v15_0_od_edit_dpm_table(struct smu_context *smu,
+				enum PP_OD_DPM_TABLE_COMMAND type,
+				long input[], uint32_t size);
+
+void smu_v15_0_set_smu_mailbox_registers(struct smu_context *smu);
+
+int smu_v15_0_enable_thermal_alert(struct smu_context *smu);
+
+int smu_v15_0_disable_thermal_alert(struct smu_context *smu);
+
+#endif
+#endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/Makefile b/drivers/gpu/drm/amd/pm/swsmu/smu15/Makefile
new file mode 100644
index 0000000000000..7f59a0aabdeb6
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/Makefile
@@ -0,0 +1,30 @@
+#
+# Copyright 2025 Advanced Micro Devices, Inc.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+# OTHER DEALINGS IN THE SOFTWARE.
+#
+#
+# Makefile for the 'smu manager' sub-component of powerplay.
+# It provides the smu management services for the driver.
+
+SMU15_MGR = smu_v15_0.o smu_v15_0_0_ppt.o
+
+AMD_SWSMU_SMU15MGR = $(addprefix $(AMD_SWSMU_PATH)/smu15/,$(SMU15_MGR))
+
+AMD_POWERPLAY_FILES += $(AMD_SWSMU_SMU15MGR)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
new file mode 100644
index 0000000000000..0740603e8d56c
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
@@ -0,0 +1,1843 @@
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include <linux/firmware.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/reboot.h>
+
+#define SWSMU_CODE_LAYER_L3
+
+#include "amdgpu.h"
+#include "amdgpu_smu.h"
+#include "atomfirmware.h"
+#include "amdgpu_atomfirmware.h"
+#include "amdgpu_atombios.h"
+#include "smu_v15_0.h"
+#include "soc15_common.h"
+#include "atom.h"
+#include "amdgpu_ras.h"
+#include "smu_cmn.h"
+
+#include "asic_reg/thm/thm_15_0_0_offset.h"
+#include "asic_reg/thm/thm_15_0_0_sh_mask.h"
+#include "asic_reg/mp/mp_15_0_0_offset.h"
+#include "asic_reg/mp/mp_15_0_0_sh_mask.h"
+
+#define regMP1_SMN_IH_SW_INT_mp1_15_0_0			0x0341
+#define regMP1_SMN_IH_SW_INT_mp1_15_0_0_BASE_IDX        0
+#define regMP1_SMN_IH_SW_INT_CTRL_mp1_15_0_0            0x0342
+#define regMP1_SMN_IH_SW_INT_CTRL_mp1_15_0_0_BASE_IDX   0
+
+/*
+ * DO NOT use these for err/warn/info/debug messages.
+ * Use dev_err, dev_warn, dev_info and dev_dbg instead.
+ * They are more MGPU friendly.
+ */
+#undef pr_err
+#undef pr_warn
+#undef pr_info
+#undef pr_debug
+
+#define ENABLE_IMU_ARG_GFXOFF_ENABLE		1
+
+int smu_v15_0_init_microcode(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	char ucode_prefix[15];
+	int err = 0;
+	const struct smc_firmware_header_v1_0 *hdr;
+	const struct common_firmware_header *header;
+	struct amdgpu_firmware_info *ucode = NULL;
+
+	/* doesn't need to load smu firmware in IOV mode */
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
+	amdgpu_ucode_ip_version_decode(adev, MP1_HWIP, ucode_prefix, sizeof(ucode_prefix));
+	err = amdgpu_ucode_request(adev, &adev->pm.fw, AMDGPU_UCODE_REQUIRED,
+				   "amdgpu/%s.bin", ucode_prefix);
+	if (err)
+		goto out;
+
+	hdr = (const struct smc_firmware_header_v1_0 *) adev->pm.fw->data;
+	amdgpu_ucode_print_smc_hdr(&hdr->header);
+	adev->pm.fw_version = le32_to_cpu(hdr->header.ucode_version);
+
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
+		ucode = &adev->firmware.ucode[AMDGPU_UCODE_ID_SMC];
+		ucode->ucode_id = AMDGPU_UCODE_ID_SMC;
+		ucode->fw = adev->pm.fw;
+		header = (const struct common_firmware_header *)ucode->fw->data;
+		adev->firmware.fw_size +=
+			ALIGN(le32_to_cpu(header->ucode_size_bytes), PAGE_SIZE);
+	}
+
+out:
+	if (err)
+		amdgpu_ucode_release(&adev->pm.fw);
+	return err;
+}
+
+void smu_v15_0_fini_microcode(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	amdgpu_ucode_release(&adev->pm.fw);
+	adev->pm.fw_version = 0;
+}
+
+int smu_v15_0_load_microcode(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	const uint32_t *src;
+	const struct smc_firmware_header_v1_0 *hdr;
+	uint32_t addr_start = MP1_SRAM;
+	uint32_t i;
+	uint32_t smc_fw_size;
+	uint32_t mp1_fw_flags;
+
+	hdr = (const struct smc_firmware_header_v1_0 *) adev->pm.fw->data;
+	src = (const uint32_t *)(adev->pm.fw->data +
+				 le32_to_cpu(hdr->header.ucode_array_offset_bytes));
+	smc_fw_size = hdr->header.ucode_size_bytes;
+
+	for (i = 1; i < smc_fw_size/4 - 1; i++) {
+		WREG32_PCIE(addr_start, src[i]);
+		addr_start += 4;
+	}
+
+
+	for (i = 0; i < adev->usec_timeout; i++) {
+		if (smu->is_apu)
+			mp1_fw_flags = RREG32_PCIE(MP1_Public |
+						   (smnMP1_FIRMWARE_FLAGS & 0xffffffff));
+
+		if ((mp1_fw_flags & MP1_CRU1_MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED_MASK) >>
+		    MP1_CRU1_MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED__SHIFT)
+			break;
+		udelay(1);
+	}
+
+	if (i == adev->usec_timeout)
+		return -ETIME;
+
+	return 0;
+}
+
+int smu_v15_0_init_pptable_microcode(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	struct amdgpu_firmware_info *ucode = NULL;
+	uint32_t size = 0, pptable_id = 0;
+	int ret = 0;
+	void *table;
+
+	/* doesn't need to load smu firmware in IOV mode */
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
+	if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP)
+		return 0;
+
+	if (!adev->scpm_enabled)
+		return 0;
+
+	/* override pptable_id from driver parameter */
+	if (amdgpu_smu_pptable_id >= 0) {
+		pptable_id = amdgpu_smu_pptable_id;
+		dev_info(adev->dev, "override pptable id %d\n", pptable_id);
+	} else {
+		pptable_id = smu->smu_table.boot_values.pp_table_id;
+	}
+
+	/* "pptable_id == 0" means vbios carries the pptable. */
+	if (!pptable_id)
+		return 0;
+
+	ret = smu_v15_0_get_pptable_from_firmware(smu, &table, &size, pptable_id);
+	if (ret)
+		return ret;
+
+	smu->pptable_firmware.data = table;
+	smu->pptable_firmware.size = size;
+
+	ucode = &adev->firmware.ucode[AMDGPU_UCODE_ID_PPTABLE];
+	ucode->ucode_id = AMDGPU_UCODE_ID_PPTABLE;
+	ucode->fw = &smu->pptable_firmware;
+	adev->firmware.fw_size +=
+		ALIGN(smu->pptable_firmware.size, PAGE_SIZE);
+
+	return 0;
+}
+
+int smu_v15_0_check_fw_status(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t mp1_fw_flags;
+
+	if (smu->is_apu)
+		mp1_fw_flags = RREG32_PCIE(MP1_Public |
+					   (smnMP1_FIRMWARE_FLAGS & 0xffffffff));
+
+
+	if ((mp1_fw_flags & MP1_CRU1_MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED_MASK) >>
+	    MP1_CRU1_MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED__SHIFT)
+		return 0;
+
+	return -EIO;
+}
+
+int smu_v15_0_check_fw_version(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t if_version = 0xff, smu_version = 0xff;
+	uint8_t smu_program, smu_major, smu_minor, smu_debug;
+	int ret = 0;
+
+	ret = smu_cmn_get_smc_version(smu, &if_version, &smu_version);
+	if (ret)
+		return ret;
+
+	smu_program = (smu_version >> 24) & 0xff;
+	smu_major = (smu_version >> 16) & 0xff;
+	smu_minor = (smu_version >> 8) & 0xff;
+	smu_debug = (smu_version >> 0) & 0xff;
+	if (smu->is_apu)
+		adev->pm.fw_version = smu_version;
+
+	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
+	case IP_VERSION(15, 0, 0):
+		smu->smc_driver_if_version = SMU15_DRIVER_IF_VERSION_SMU_V15_0;
+		break;
+	default:
+		dev_err(adev->dev, "smu unsupported IP version: 0x%x.\n",
+			amdgpu_ip_version(adev, MP1_HWIP, 0));
+		smu->smc_driver_if_version = SMU15_DRIVER_IF_VERSION_INV;
+		break;
+	}
+
+	if (adev->pm.fw)
+		dev_dbg(smu->adev->dev, "smu fw reported program %d, version = 0x%08x (%d.%d.%d)\n",
+			 smu_program, smu_version, smu_major, smu_minor, smu_debug);
+
+	/*
+	 * 1. if_version mismatch is not critical as our fw is designed
+	 * to be backward compatible.
+	 * 2. New fw usually brings some optimizations. But that's visible
+	 * only on the paired driver.
+	 * Considering above, we just leave user a verbal message instead
+	 * of halt driver loading.
+	 */
+	if (if_version != smu->smc_driver_if_version) {
+		dev_info(adev->dev, "smu driver if version = 0x%08x, smu fw if version = 0x%08x, "
+			 "smu fw program = %d, smu fw version = 0x%08x (%d.%d.%d)\n",
+			 smu->smc_driver_if_version, if_version,
+			 smu_program, smu_version, smu_major, smu_minor, smu_debug);
+		dev_info(adev->dev, "SMU driver if version not matched\n");
+	}
+
+	return ret;
+}
+
+static int smu_v15_0_set_pptable_v2_0(struct smu_context *smu, void **table, uint32_t *size)
+{
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t ppt_offset_bytes;
+	const struct smc_firmware_header_v2_0 *v2;
+
+	v2 = (const struct smc_firmware_header_v2_0 *) adev->pm.fw->data;
+
+	ppt_offset_bytes = le32_to_cpu(v2->ppt_offset_bytes);
+	*size = le32_to_cpu(v2->ppt_size_bytes);
+	*table = (uint8_t *)v2 + ppt_offset_bytes;
+
+	return 0;
+}
+
+static int smu_v15_0_set_pptable_v2_1(struct smu_context *smu, void **table,
+				      uint32_t *size, uint32_t pptable_id)
+{
+	struct amdgpu_device *adev = smu->adev;
+	const struct smc_firmware_header_v2_1 *v2_1;
+	struct smc_soft_pptable_entry *entries;
+	uint32_t pptable_count = 0;
+	int i = 0;
+
+	v2_1 = (const struct smc_firmware_header_v2_1 *) adev->pm.fw->data;
+	entries = (struct smc_soft_pptable_entry *)
+		((uint8_t *)v2_1 + le32_to_cpu(v2_1->pptable_entry_offset));
+	pptable_count = le32_to_cpu(v2_1->pptable_count);
+	for (i = 0; i < pptable_count; i++) {
+		if (le32_to_cpu(entries[i].id) == pptable_id) {
+			*table = ((uint8_t *)v2_1 + le32_to_cpu(entries[i].ppt_offset_bytes));
+			*size = le32_to_cpu(entries[i].ppt_size_bytes);
+			break;
+		}
+	}
+
+	if (i == pptable_count)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int smu_v15_0_get_pptable_from_vbios(struct smu_context *smu, void **table, uint32_t *size)
+{
+	struct amdgpu_device *adev = smu->adev;
+	uint16_t atom_table_size;
+	uint8_t frev, crev;
+	int ret, index;
+
+	dev_info(adev->dev, "use vbios provided pptable\n");
+	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
+					    powerplayinfo);
+
+	ret = amdgpu_atombios_get_data_table(adev, index, &atom_table_size, &frev, &crev,
+					     (uint8_t **)table);
+	if (ret)
+		return ret;
+
+	if (size)
+		*size = atom_table_size;
+
+	return 0;
+}
+
+int smu_v15_0_get_pptable_from_firmware(struct smu_context *smu,
+					void **table,
+					uint32_t *size,
+					uint32_t pptable_id)
+{
+	const struct smc_firmware_header_v1_0 *hdr;
+	struct amdgpu_device *adev = smu->adev;
+	uint16_t version_major, version_minor;
+	int ret;
+
+	hdr = (const struct smc_firmware_header_v1_0 *) adev->pm.fw->data;
+	if (!hdr)
+		return -EINVAL;
+
+	dev_info(adev->dev, "use driver provided pptable %d\n", pptable_id);
+
+	version_major = le16_to_cpu(hdr->header.header_version_major);
+	version_minor = le16_to_cpu(hdr->header.header_version_minor);
+	if (version_major != 2) {
+		dev_err(adev->dev, "Unsupported smu firmware version %d.%d\n",
+			version_major, version_minor);
+		return -EINVAL;
+	}
+
+	switch (version_minor) {
+	case 0:
+		ret = smu_v15_0_set_pptable_v2_0(smu, table, size);
+		break;
+	case 1:
+		ret = smu_v15_0_set_pptable_v2_1(smu, table, size, pptable_id);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+int smu_v15_0_setup_pptable(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t size = 0, pptable_id = 0;
+	void *table;
+	int ret = 0;
+
+	/* override pptable_id from driver parameter */
+	if (amdgpu_smu_pptable_id >= 0) {
+		pptable_id = amdgpu_smu_pptable_id;
+		dev_info(adev->dev, "override pptable id %d\n", pptable_id);
+	} else {
+		pptable_id = smu->smu_table.boot_values.pp_table_id;
+	}
+
+	/* force using vbios pptable in sriov mode */
+	if ((amdgpu_sriov_vf(adev) || !pptable_id) && (amdgpu_emu_mode != 1))
+		ret = smu_v15_0_get_pptable_from_vbios(smu, &table, &size);
+	else
+		ret = smu_v15_0_get_pptable_from_firmware(smu, &table, &size, pptable_id);
+
+	if (ret)
+		return ret;
+
+	if (!smu->smu_table.power_play_table)
+		smu->smu_table.power_play_table = table;
+	if (!smu->smu_table.power_play_table_size)
+		smu->smu_table.power_play_table_size = size;
+
+	return 0;
+}
+
+int smu_v15_0_init_smc_tables(struct smu_context *smu)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct smu_table *tables = smu_table->tables;
+	int ret = 0;
+
+	smu_table->driver_pptable =
+		kzalloc(tables[SMU_TABLE_PPTABLE].size, GFP_KERNEL);
+	if (!smu_table->driver_pptable) {
+		ret = -ENOMEM;
+		goto err0_out;
+	}
+
+	smu_table->max_sustainable_clocks =
+		kzalloc(sizeof(struct smu_15_0_max_sustainable_clocks), GFP_KERNEL);
+	if (!smu_table->max_sustainable_clocks) {
+		ret = -ENOMEM;
+		goto err1_out;
+	}
+
+	if (tables[SMU_TABLE_OVERDRIVE].size) {
+		smu_table->overdrive_table =
+			kzalloc(tables[SMU_TABLE_OVERDRIVE].size, GFP_KERNEL);
+		if (!smu_table->overdrive_table) {
+			ret = -ENOMEM;
+			goto err2_out;
+		}
+
+		smu_table->boot_overdrive_table =
+			kzalloc(tables[SMU_TABLE_OVERDRIVE].size, GFP_KERNEL);
+		if (!smu_table->boot_overdrive_table) {
+			ret = -ENOMEM;
+			goto err3_out;
+		}
+
+		smu_table->user_overdrive_table =
+			kzalloc(tables[SMU_TABLE_OVERDRIVE].size, GFP_KERNEL);
+		if (!smu_table->user_overdrive_table) {
+			ret = -ENOMEM;
+			goto err4_out;
+		}
+	}
+
+	smu_table->combo_pptable =
+		kzalloc(tables[SMU_TABLE_COMBO_PPTABLE].size, GFP_KERNEL);
+	if (!smu_table->combo_pptable) {
+		ret = -ENOMEM;
+		goto err5_out;
+	}
+
+	return 0;
+
+err5_out:
+	kfree(smu_table->user_overdrive_table);
+err4_out:
+	kfree(smu_table->boot_overdrive_table);
+err3_out:
+	kfree(smu_table->overdrive_table);
+err2_out:
+	kfree(smu_table->max_sustainable_clocks);
+err1_out:
+	kfree(smu_table->driver_pptable);
+err0_out:
+	return ret;
+}
+
+int smu_v15_0_fini_smc_tables(struct smu_context *smu)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
+
+	kfree(smu_table->gpu_metrics_table);
+	kfree(smu_table->combo_pptable);
+	kfree(smu_table->boot_overdrive_table);
+	kfree(smu_table->overdrive_table);
+	kfree(smu_table->max_sustainable_clocks);
+	kfree(smu_table->driver_pptable);
+	smu_table->gpu_metrics_table = NULL;
+	smu_table->combo_pptable = NULL;
+	smu_table->boot_overdrive_table = NULL;
+	smu_table->overdrive_table = NULL;
+	smu_table->max_sustainable_clocks = NULL;
+	smu_table->driver_pptable = NULL;
+	kfree(smu_table->hardcode_pptable);
+	smu_table->hardcode_pptable = NULL;
+
+	kfree(smu_table->ecc_table);
+	kfree(smu_table->metrics_table);
+	kfree(smu_table->watermarks_table);
+	smu_table->ecc_table = NULL;
+	smu_table->metrics_table = NULL;
+	smu_table->watermarks_table = NULL;
+	smu_table->metrics_time = 0;
+
+	kfree(smu_dpm->dpm_context);
+	kfree(smu_dpm->golden_dpm_context);
+	kfree(smu_dpm->dpm_current_power_state);
+	kfree(smu_dpm->dpm_request_power_state);
+	smu_dpm->dpm_context = NULL;
+	smu_dpm->golden_dpm_context = NULL;
+	smu_dpm->dpm_context_size = 0;
+	smu_dpm->dpm_current_power_state = NULL;
+	smu_dpm->dpm_request_power_state = NULL;
+
+	return 0;
+}
+
+int smu_v15_0_init_power(struct smu_context *smu)
+{
+	struct smu_power_context *smu_power = &smu->smu_power;
+
+	if (smu_power->power_context || smu_power->power_context_size != 0)
+		return -EINVAL;
+
+	smu_power->power_context = kzalloc(sizeof(struct smu_15_0_dpm_context),
+					   GFP_KERNEL);
+	if (!smu_power->power_context)
+		return -ENOMEM;
+	smu_power->power_context_size = sizeof(struct smu_15_0_dpm_context);
+
+	return 0;
+}
+
+int smu_v15_0_fini_power(struct smu_context *smu)
+{
+	struct smu_power_context *smu_power = &smu->smu_power;
+
+	if (!smu_power->power_context || smu_power->power_context_size == 0)
+		return -EINVAL;
+
+	kfree(smu_power->power_context);
+	smu_power->power_context = NULL;
+	smu_power->power_context_size = 0;
+
+	return 0;
+}
+
+int smu_v15_0_get_vbios_bootup_values(struct smu_context *smu)
+{
+	int ret, index;
+	uint16_t size;
+	uint8_t frev, crev;
+	struct atom_common_table_header *header;
+	struct atom_firmware_info_v3_4 *v_3_4;
+	struct atom_firmware_info_v3_3 *v_3_3;
+	struct atom_firmware_info_v3_1 *v_3_1;
+	struct atom_smu_info_v3_6 *smu_info_v3_6;
+	struct atom_smu_info_v4_0 *smu_info_v4_0;
+
+	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
+					    firmwareinfo);
+
+	ret = amdgpu_atombios_get_data_table(smu->adev, index, &size, &frev, &crev,
+					     (uint8_t **)&header);
+	if (ret)
+		return ret;
+
+	if (header->format_revision != 3) {
+		dev_err(smu->adev->dev, "unknown atom_firmware_info version! for smu15\n");
+		return -EINVAL;
+	}
+
+	switch (header->content_revision) {
+	case 0:
+	case 1:
+	case 2:
+		v_3_1 = (struct atom_firmware_info_v3_1 *)header;
+		smu->smu_table.boot_values.revision = v_3_1->firmware_revision;
+		smu->smu_table.boot_values.gfxclk = v_3_1->bootup_sclk_in10khz;
+		smu->smu_table.boot_values.uclk = v_3_1->bootup_mclk_in10khz;
+		smu->smu_table.boot_values.socclk = 0;
+		smu->smu_table.boot_values.dcefclk = 0;
+		smu->smu_table.boot_values.vddc = v_3_1->bootup_vddc_mv;
+		smu->smu_table.boot_values.vddci = v_3_1->bootup_vddci_mv;
+		smu->smu_table.boot_values.mvddc = v_3_1->bootup_mvddc_mv;
+		smu->smu_table.boot_values.vdd_gfx = v_3_1->bootup_vddgfx_mv;
+		smu->smu_table.boot_values.cooling_id = v_3_1->coolingsolution_id;
+		smu->smu_table.boot_values.pp_table_id = 0;
+		break;
+	case 3:
+		v_3_3 = (struct atom_firmware_info_v3_3 *)header;
+		smu->smu_table.boot_values.revision = v_3_3->firmware_revision;
+		smu->smu_table.boot_values.gfxclk = v_3_3->bootup_sclk_in10khz;
+		smu->smu_table.boot_values.uclk = v_3_3->bootup_mclk_in10khz;
+		smu->smu_table.boot_values.socclk = 0;
+		smu->smu_table.boot_values.dcefclk = 0;
+		smu->smu_table.boot_values.vddc = v_3_3->bootup_vddc_mv;
+		smu->smu_table.boot_values.vddci = v_3_3->bootup_vddci_mv;
+		smu->smu_table.boot_values.mvddc = v_3_3->bootup_mvddc_mv;
+		smu->smu_table.boot_values.vdd_gfx = v_3_3->bootup_vddgfx_mv;
+		smu->smu_table.boot_values.cooling_id = v_3_3->coolingsolution_id;
+		smu->smu_table.boot_values.pp_table_id = v_3_3->pplib_pptable_id;
+		break;
+	case 4:
+	default:
+		v_3_4 = (struct atom_firmware_info_v3_4 *)header;
+		smu->smu_table.boot_values.revision = v_3_4->firmware_revision;
+		smu->smu_table.boot_values.gfxclk = v_3_4->bootup_sclk_in10khz;
+		smu->smu_table.boot_values.uclk = v_3_4->bootup_mclk_in10khz;
+		smu->smu_table.boot_values.socclk = 0;
+		smu->smu_table.boot_values.dcefclk = 0;
+		smu->smu_table.boot_values.vddc = v_3_4->bootup_vddc_mv;
+		smu->smu_table.boot_values.vddci = v_3_4->bootup_vddci_mv;
+		smu->smu_table.boot_values.mvddc = v_3_4->bootup_mvddc_mv;
+		smu->smu_table.boot_values.vdd_gfx = v_3_4->bootup_vddgfx_mv;
+		smu->smu_table.boot_values.cooling_id = v_3_4->coolingsolution_id;
+		smu->smu_table.boot_values.pp_table_id = v_3_4->pplib_pptable_id;
+		break;
+	}
+
+	smu->smu_table.boot_values.format_revision = header->format_revision;
+	smu->smu_table.boot_values.content_revision = header->content_revision;
+
+	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
+					    smu_info);
+	if (!amdgpu_atombios_get_data_table(smu->adev, index, &size, &frev, &crev,
+					    (uint8_t **)&header)) {
+
+		if ((frev == 3) && (crev == 6)) {
+			smu_info_v3_6 = (struct atom_smu_info_v3_6 *)header;
+
+			smu->smu_table.boot_values.socclk = smu_info_v3_6->bootup_socclk_10khz;
+			smu->smu_table.boot_values.vclk = smu_info_v3_6->bootup_vclk_10khz;
+			smu->smu_table.boot_values.dclk = smu_info_v3_6->bootup_dclk_10khz;
+			smu->smu_table.boot_values.fclk = smu_info_v3_6->bootup_fclk_10khz;
+		} else if ((frev == 3) && (crev == 1)) {
+			return 0;
+		} else if ((frev == 4) && (crev == 0)) {
+			smu_info_v4_0 = (struct atom_smu_info_v4_0 *)header;
+
+			smu->smu_table.boot_values.socclk = smu_info_v4_0->bootup_socclk_10khz;
+			smu->smu_table.boot_values.dcefclk = smu_info_v4_0->bootup_dcefclk_10khz;
+			smu->smu_table.boot_values.vclk = smu_info_v4_0->bootup_vclk0_10khz;
+			smu->smu_table.boot_values.dclk = smu_info_v4_0->bootup_dclk0_10khz;
+			smu->smu_table.boot_values.fclk = smu_info_v4_0->bootup_fclk_10khz;
+		} else {
+			dev_warn(smu->adev->dev, "Unexpected and unhandled version: %d.%d\n",
+						(uint32_t)frev, (uint32_t)crev);
+		}
+	}
+
+	return 0;
+}
+
+
+int smu_v15_0_notify_memory_pool_location(struct smu_context *smu)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct smu_table *memory_pool = &smu_table->memory_pool;
+	int ret = 0;
+	uint64_t address;
+	uint32_t address_low, address_high;
+
+	if (memory_pool->size == 0 || memory_pool->cpu_addr == NULL)
+		return ret;
+
+	address = memory_pool->mc_address;
+	address_high = (uint32_t)upper_32_bits(address);
+	address_low  = (uint32_t)lower_32_bits(address);
+
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_DramLogSetDramAddrHigh,
+					      address_high, NULL);
+	if (ret)
+		return ret;
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_DramLogSetDramAddrLow,
+					      address_low, NULL);
+	if (ret)
+		return ret;
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_DramLogSetDramSize,
+					      (uint32_t)memory_pool->size, NULL);
+	if (ret)
+		return ret;
+
+	return ret;
+}
+
+int smu_v15_0_set_driver_table_location(struct smu_context *smu)
+{
+	struct smu_table *driver_table = &smu->smu_table.driver_table;
+	int ret = 0;
+
+	if (driver_table->mc_address) {
+		ret = smu_cmn_send_smc_msg_with_param(smu,
+						      SMU_MSG_SetDriverDramAddrHigh,
+						      upper_32_bits(driver_table->mc_address),
+						      NULL);
+		if (!ret)
+			ret = smu_cmn_send_smc_msg_with_param(smu,
+							      SMU_MSG_SetDriverDramAddrLow,
+							      lower_32_bits(driver_table->mc_address),
+							      NULL);
+	}
+
+	return ret;
+}
+
+int smu_v15_0_set_tool_table_location(struct smu_context *smu)
+{
+	int ret = 0;
+	struct smu_table *tool_table = &smu->smu_table.tables[SMU_TABLE_PMSTATUSLOG];
+
+	if (tool_table->mc_address) {
+		ret = smu_cmn_send_smc_msg_with_param(smu,
+						      SMU_MSG_SetToolsDramAddrHigh,
+						      upper_32_bits(tool_table->mc_address),
+						      NULL);
+		if (!ret)
+			ret = smu_cmn_send_smc_msg_with_param(smu,
+							      SMU_MSG_SetToolsDramAddrLow,
+							      lower_32_bits(tool_table->mc_address),
+							      NULL);
+	}
+
+	return ret;
+}
+
+int smu_v15_0_set_allowed_mask(struct smu_context *smu)
+{
+	struct smu_feature *feature = &smu->smu_feature;
+	int ret = 0;
+	uint32_t feature_mask[2];
+
+	if (bitmap_empty(feature->allowed, SMU_FEATURE_MAX) ||
+	    feature->feature_num < 64)
+		return -EINVAL;
+
+	bitmap_to_arr32(feature_mask, feature->allowed, 64);
+
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetAllowedFeaturesMaskHigh,
+					      feature_mask[1], NULL);
+	if (ret)
+		return ret;
+
+	return smu_cmn_send_smc_msg_with_param(smu,
+					       SMU_MSG_SetAllowedFeaturesMaskLow,
+					       feature_mask[0],
+					       NULL);
+}
+
+int smu_v15_0_gfx_off_control(struct smu_context *smu, bool enable)
+{
+	int ret = 0;
+	struct amdgpu_device *adev = smu->adev;
+
+	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
+	case IP_VERSION(15, 0, 0):
+		if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
+			return 0;
+		if (enable)
+			ret = smu_cmn_send_smc_msg(smu, SMU_MSG_AllowGfxOff, NULL);
+		else
+			ret = smu_cmn_send_smc_msg(smu, SMU_MSG_DisallowGfxOff, NULL);
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+int smu_v15_0_system_features_control(struct smu_context *smu,
+				      bool en)
+{
+	return smu_cmn_send_smc_msg(smu, (en ? SMU_MSG_EnableAllSmuFeatures :
+					  SMU_MSG_DisableAllSmuFeatures), NULL);
+}
+
+int smu_v15_0_notify_display_change(struct smu_context *smu)
+{
+	int ret = 0;
+
+	if (!smu->pm_enabled)
+		return ret;
+
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT) &&
+	    smu->adev->gmc.vram_type == AMDGPU_VRAM_TYPE_HBM)
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetUclkFastSwitch, 1, NULL);
+
+	return ret;
+}
+
+int smu_v15_0_get_current_power_limit(struct smu_context *smu,
+				      uint32_t *power_limit)
+{
+	int power_src;
+	int ret = 0;
+
+	if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_PPT_BIT))
+		return -EINVAL;
+
+	power_src = smu_cmn_to_asic_specific_index(smu,
+						   CMN2ASIC_MAPPING_PWR,
+						   smu->adev->pm.ac_power ?
+						   SMU_POWER_SOURCE_AC :
+						   SMU_POWER_SOURCE_DC);
+	if (power_src < 0)
+		return -EINVAL;
+
+	ret = smu_cmn_send_smc_msg_with_param(smu,
+					      SMU_MSG_GetPptLimit,
+					      power_src << 16,
+					      power_limit);
+	if (ret)
+		dev_err(smu->adev->dev, "[%s] get PPT limit failed!", __func__);
+
+	return ret;
+}
+
+int smu_v15_0_set_power_limit(struct smu_context *smu,
+			      enum smu_ppt_limit_type limit_type,
+			      uint32_t limit)
+{
+	int ret = 0;
+
+	if (limit_type != SMU_DEFAULT_PPT_LIMIT)
+		return -EINVAL;
+
+	if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_PPT_BIT)) {
+		dev_err(smu->adev->dev, "Setting new power limit is not supported!\n");
+		return -EOPNOTSUPP;
+	}
+
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetPptLimit, limit, NULL);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] Set power limit Failed!\n", __func__);
+		return ret;
+	}
+
+	smu->current_power_limit = limit;
+
+	return 0;
+}
+
+static int smu_v15_0_set_irq_state(struct amdgpu_device *adev,
+				   struct amdgpu_irq_src *source,
+				   unsigned tyep,
+				   enum amdgpu_interrupt_state state)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+	uint32_t val = 0;
+
+	switch (state) {
+	case AMDGPU_IRQ_STATE_DISABLE:
+
+		/* For MP1 SW irqs */
+		if (smu->is_apu) {
+			val = RREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL_mp1_15_0_0);
+			val = REG_SET_FIELD(val, MP1_SMN_IH_SW_INT_CTRL, INT_MASK, 1);
+			WREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL_mp1_15_0_0, val);
+		} else {
+			val = RREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL);
+			val = REG_SET_FIELD(val, MP1_SMN_IH_SW_INT_CTRL, INT_MASK, 1);
+			WREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL, val);
+		}
+
+		break;
+	case AMDGPU_IRQ_STATE_ENABLE:
+		/* For MP1 SW irqs */
+		if (smu->is_apu) {
+			val = RREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_mp1_15_0_0);
+			val = REG_SET_FIELD(val, MP1_SMN_IH_SW_INT, ID, 0xFE);
+			val = REG_SET_FIELD(val, MP1_SMN_IH_SW_INT, VALID, 0);
+			WREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_mp1_15_0_0, val);
+
+			val = RREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL_mp1_15_0_0);
+			val = REG_SET_FIELD(val, MP1_SMN_IH_SW_INT_CTRL, INT_MASK, 0);
+			WREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL_mp1_15_0_0, val);
+		} else {
+			val = RREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT);
+			val = REG_SET_FIELD(val, MP1_SMN_IH_SW_INT, ID, 0xFE);
+			val = REG_SET_FIELD(val, MP1_SMN_IH_SW_INT, VALID, 0);
+			WREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT, val);
+
+			val = RREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL);
+			val = REG_SET_FIELD(val, MP1_SMN_IH_SW_INT_CTRL, INT_MASK, 0);
+			WREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL, val);
+		}
+
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+#define THM_11_0__SRCID__THM_DIG_THERM_L2H		0		/* ASIC_TEMP > CG_THERMAL_INT.DIG_THERM_INTH  */
+#define THM_11_0__SRCID__THM_DIG_THERM_H2L		1		/* ASIC_TEMP < CG_THERMAL_INT.DIG_THERM_INTL  */
+
+static int smu_v15_0_irq_process(struct amdgpu_device *adev,
+				 struct amdgpu_irq_src *source,
+				 struct amdgpu_iv_entry *entry)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+	uint32_t client_id = entry->client_id;
+	uint32_t src_id = entry->src_id;
+
+	if (client_id == SOC15_IH_CLIENTID_THM) {
+		switch (src_id) {
+		case THM_11_0__SRCID__THM_DIG_THERM_L2H:
+			schedule_delayed_work(&smu->swctf_delayed_work,
+					      msecs_to_jiffies(AMDGPU_SWCTF_EXTRA_DELAY));
+			break;
+		case THM_11_0__SRCID__THM_DIG_THERM_H2L:
+			dev_emerg(adev->dev, "ERROR: GPU under temperature range detected\n");
+			break;
+		default:
+			dev_emerg(adev->dev, "ERROR: GPU under temperature range unknown src id (%d)\n",
+				  src_id);
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static const struct amdgpu_irq_src_funcs smu_v15_0_irq_funcs = {
+	.set = smu_v15_0_set_irq_state,
+	.process = smu_v15_0_irq_process,
+};
+
+int smu_v15_0_register_irq_handler(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	struct amdgpu_irq_src *irq_src = &smu->irq_source;
+	int ret = 0;
+
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
+	irq_src->num_types = 1;
+	irq_src->funcs = &smu_v15_0_irq_funcs;
+
+	ret = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_THM,
+				THM_11_0__SRCID__THM_DIG_THERM_L2H,
+				irq_src);
+	if (ret)
+		return ret;
+
+	ret = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_THM,
+				THM_11_0__SRCID__THM_DIG_THERM_H2L,
+				irq_src);
+	if (ret)
+		return ret;
+
+	ret = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
+				SMU_IH_INTERRUPT_ID_TO_DRIVER,
+				irq_src);
+	if (ret)
+		return ret;
+
+	return ret;
+}
+
+static int smu_v15_0_wait_for_reset_complete(struct smu_context *smu,
+					     uint64_t event_arg)
+{
+	int ret = 0;
+
+	dev_dbg(smu->adev->dev, "waiting for smu reset complete\n");
+	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GfxDriverResetRecovery, NULL);
+
+	return ret;
+}
+
+int smu_v15_0_wait_for_event(struct smu_context *smu, enum smu_event_type event,
+			     uint64_t event_arg)
+{
+	int ret = -EINVAL;
+
+	switch (event) {
+	case SMU_EVENT_RESET_COMPLETE:
+		ret = smu_v15_0_wait_for_reset_complete(smu, event_arg);
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+int smu_v15_0_get_dpm_ultimate_freq(struct smu_context *smu, enum smu_clk_type clk_type,
+				    uint32_t *min, uint32_t *max)
+{
+	int ret = 0, clk_id = 0;
+	uint32_t param = 0;
+	uint32_t clock_limit;
+
+	if (!smu_cmn_clk_dpm_is_enabled(smu, clk_type)) {
+		switch (clk_type) {
+		case SMU_MCLK:
+		case SMU_UCLK:
+			clock_limit = smu->smu_table.boot_values.uclk;
+			break;
+		case SMU_GFXCLK:
+		case SMU_SCLK:
+			clock_limit = smu->smu_table.boot_values.gfxclk;
+			break;
+		case SMU_SOCCLK:
+			clock_limit = smu->smu_table.boot_values.socclk;
+			break;
+		default:
+			clock_limit = 0;
+			break;
+		}
+
+		/* clock in Mhz unit */
+		if (min)
+			*min = clock_limit / 100;
+		if (max)
+			*max = clock_limit / 100;
+
+		return 0;
+	}
+
+	clk_id = smu_cmn_to_asic_specific_index(smu,
+						CMN2ASIC_MAPPING_CLK,
+						clk_type);
+	if (clk_id < 0) {
+		ret = -EINVAL;
+		goto failed;
+	}
+	param = (clk_id & 0xffff) << 16;
+
+	if (max) {
+		if (smu->adev->pm.ac_power)
+			ret = smu_cmn_send_smc_msg_with_param(smu,
+							      SMU_MSG_GetMaxDpmFreq,
+							      param,
+							      max);
+		else
+			ret = smu_cmn_send_smc_msg_with_param(smu,
+							      SMU_MSG_GetDcModeMaxDpmFreq,
+							      param,
+							      max);
+		if (ret)
+			goto failed;
+	}
+
+	if (min) {
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetMinDpmFreq, param, min);
+		if (ret)
+			goto failed;
+	}
+
+failed:
+	return ret;
+}
+
+int smu_v15_0_set_soft_freq_limited_range(struct smu_context *smu,
+					  enum smu_clk_type clk_type,
+					  uint32_t min,
+					  uint32_t max,
+					  bool automatic)
+{
+	int ret = 0, clk_id = 0;
+	uint32_t param;
+
+	if (!smu_cmn_clk_dpm_is_enabled(smu, clk_type))
+		return 0;
+
+	clk_id = smu_cmn_to_asic_specific_index(smu,
+						CMN2ASIC_MAPPING_CLK,
+						clk_type);
+	if (clk_id < 0)
+		return clk_id;
+
+	if (max > 0) {
+		if (automatic)
+			param = (uint32_t)((clk_id << 16) | 0xffff);
+		else
+			param = (uint32_t)((clk_id << 16) | (max & 0xffff));
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxByFreq,
+						      param, NULL);
+		if (ret)
+			goto out;
+	}
+
+	if (min > 0) {
+		if (automatic)
+			param = (uint32_t)((clk_id << 16) | 0);
+		else
+			param = (uint32_t)((clk_id << 16) | (min & 0xffff));
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMinByFreq,
+						      param, NULL);
+		if (ret)
+			goto out;
+	}
+
+out:
+	return ret;
+}
+
+int smu_v15_0_set_hard_freq_limited_range(struct smu_context *smu,
+					  enum smu_clk_type clk_type,
+					  uint32_t min,
+					  uint32_t max)
+{
+	int ret = 0, clk_id = 0;
+	uint32_t param;
+
+	if (min <= 0 && max <= 0)
+		return -EINVAL;
+
+	if (!smu_cmn_clk_dpm_is_enabled(smu, clk_type))
+		return 0;
+
+	clk_id = smu_cmn_to_asic_specific_index(smu,
+						CMN2ASIC_MAPPING_CLK,
+						clk_type);
+	if (clk_id < 0)
+		return clk_id;
+
+	if (max > 0) {
+		param = (uint32_t)((clk_id << 16) | (max & 0xffff));
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMaxByFreq,
+						      param, NULL);
+		if (ret)
+			return ret;
+	}
+
+	if (min > 0) {
+		param = (uint32_t)((clk_id << 16) | (min & 0xffff));
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinByFreq,
+						      param, NULL);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
+int smu_v15_0_set_performance_level(struct smu_context *smu,
+				    enum amd_dpm_forced_level level)
+{
+	struct smu_15_0_dpm_context *dpm_context =
+		smu->smu_dpm.dpm_context;
+	struct smu_15_0_dpm_table *gfx_table =
+		&dpm_context->dpm_tables.gfx_table;
+	struct smu_15_0_dpm_table *mem_table =
+		&dpm_context->dpm_tables.uclk_table;
+	struct smu_15_0_dpm_table *soc_table =
+		&dpm_context->dpm_tables.soc_table;
+	struct smu_15_0_dpm_table *vclk_table =
+		&dpm_context->dpm_tables.vclk_table;
+	struct smu_15_0_dpm_table *dclk_table =
+		&dpm_context->dpm_tables.dclk_table;
+	struct smu_15_0_dpm_table *fclk_table =
+		&dpm_context->dpm_tables.fclk_table;
+	struct smu_umd_pstate_table *pstate_table =
+		&smu->pstate_table;
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t sclk_min = 0, sclk_max = 0;
+	uint32_t mclk_min = 0, mclk_max = 0;
+	uint32_t socclk_min = 0, socclk_max = 0;
+	uint32_t vclk_min = 0, vclk_max = 0;
+	uint32_t dclk_min = 0, dclk_max = 0;
+	uint32_t fclk_min = 0, fclk_max = 0;
+	int ret = 0, i;
+	bool auto_level = false;
+
+	switch (level) {
+	case AMD_DPM_FORCED_LEVEL_HIGH:
+		sclk_min = sclk_max = gfx_table->max;
+		mclk_min = mclk_max = mem_table->max;
+		socclk_min = socclk_max = soc_table->max;
+		vclk_min = vclk_max = vclk_table->max;
+		dclk_min = dclk_max = dclk_table->max;
+		fclk_min = fclk_max = fclk_table->max;
+		break;
+	case AMD_DPM_FORCED_LEVEL_LOW:
+		sclk_min = sclk_max = gfx_table->min;
+		mclk_min = mclk_max = mem_table->min;
+		socclk_min = socclk_max = soc_table->min;
+		vclk_min = vclk_max = vclk_table->min;
+		dclk_min = dclk_max = dclk_table->min;
+		fclk_min = fclk_max = fclk_table->min;
+		break;
+	case AMD_DPM_FORCED_LEVEL_AUTO:
+		sclk_min = gfx_table->min;
+		sclk_max = gfx_table->max;
+		mclk_min = mem_table->min;
+		mclk_max = mem_table->max;
+		socclk_min = soc_table->min;
+		socclk_max = soc_table->max;
+		vclk_min = vclk_table->min;
+		vclk_max = vclk_table->max;
+		dclk_min = dclk_table->min;
+		dclk_max = dclk_table->max;
+		fclk_min = fclk_table->min;
+		fclk_max = fclk_table->max;
+		auto_level = true;
+		break;
+	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
+		sclk_min = sclk_max = pstate_table->gfxclk_pstate.standard;
+		mclk_min = mclk_max = pstate_table->uclk_pstate.standard;
+		socclk_min = socclk_max = pstate_table->socclk_pstate.standard;
+		vclk_min = vclk_max = pstate_table->vclk_pstate.standard;
+		dclk_min = dclk_max = pstate_table->dclk_pstate.standard;
+		fclk_min = fclk_max = pstate_table->fclk_pstate.standard;
+		break;
+	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
+		sclk_min = sclk_max = pstate_table->gfxclk_pstate.min;
+		break;
+	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
+		mclk_min = mclk_max = pstate_table->uclk_pstate.min;
+		break;
+	case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
+		sclk_min = sclk_max = pstate_table->gfxclk_pstate.peak;
+		mclk_min = mclk_max = pstate_table->uclk_pstate.peak;
+		socclk_min = socclk_max = pstate_table->socclk_pstate.peak;
+		vclk_min = vclk_max = pstate_table->vclk_pstate.peak;
+		dclk_min = dclk_max = pstate_table->dclk_pstate.peak;
+		fclk_min = fclk_max = pstate_table->fclk_pstate.peak;
+		break;
+	case AMD_DPM_FORCED_LEVEL_MANUAL:
+	case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
+		return 0;
+	default:
+		dev_err(adev->dev, "Invalid performance level %d\n", level);
+		return -EINVAL;
+	}
+
+	if (sclk_min && sclk_max) {
+		ret = smu_v15_0_set_soft_freq_limited_range(smu,
+							    SMU_GFXCLK,
+							    sclk_min,
+							    sclk_max,
+							    auto_level);
+		if (ret)
+			return ret;
+
+		pstate_table->gfxclk_pstate.curr.min = sclk_min;
+		pstate_table->gfxclk_pstate.curr.max = sclk_max;
+	}
+
+	if (mclk_min && mclk_max) {
+		ret = smu_v15_0_set_soft_freq_limited_range(smu,
+							    SMU_MCLK,
+							    mclk_min,
+							    mclk_max,
+							    auto_level);
+		if (ret)
+			return ret;
+
+		pstate_table->uclk_pstate.curr.min = mclk_min;
+		pstate_table->uclk_pstate.curr.max = mclk_max;
+	}
+
+	if (socclk_min && socclk_max) {
+		ret = smu_v15_0_set_soft_freq_limited_range(smu,
+							    SMU_SOCCLK,
+							    socclk_min,
+							    socclk_max,
+							    auto_level);
+		if (ret)
+			return ret;
+
+		pstate_table->socclk_pstate.curr.min = socclk_min;
+		pstate_table->socclk_pstate.curr.max = socclk_max;
+	}
+
+	if (vclk_min && vclk_max) {
+		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+			if (adev->vcn.harvest_config & (1 << i))
+				continue;
+			ret = smu_v15_0_set_soft_freq_limited_range(smu,
+								    i ? SMU_VCLK1 : SMU_VCLK,
+								    vclk_min,
+								    vclk_max,
+								    auto_level);
+			if (ret)
+				return ret;
+		}
+		pstate_table->vclk_pstate.curr.min = vclk_min;
+		pstate_table->vclk_pstate.curr.max = vclk_max;
+	}
+
+	if (dclk_min && dclk_max) {
+		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+			if (adev->vcn.harvest_config & (1 << i))
+				continue;
+			ret = smu_v15_0_set_soft_freq_limited_range(smu,
+								    i ? SMU_DCLK1 : SMU_DCLK,
+								    dclk_min,
+								    dclk_max,
+								    auto_level);
+			if (ret)
+				return ret;
+		}
+		pstate_table->dclk_pstate.curr.min = dclk_min;
+		pstate_table->dclk_pstate.curr.max = dclk_max;
+	}
+
+	if (fclk_min && fclk_max) {
+		ret = smu_v15_0_set_soft_freq_limited_range(smu,
+							    SMU_FCLK,
+							    fclk_min,
+							    fclk_max,
+							    auto_level);
+		if (ret)
+			return ret;
+
+		pstate_table->fclk_pstate.curr.min = fclk_min;
+		pstate_table->fclk_pstate.curr.max = fclk_max;
+	}
+
+	return ret;
+}
+
+int smu_v15_0_set_power_source(struct smu_context *smu,
+			       enum smu_power_src_type power_src)
+{
+	int pwr_source;
+
+	pwr_source = smu_cmn_to_asic_specific_index(smu,
+						    CMN2ASIC_MAPPING_PWR,
+						    (uint32_t)power_src);
+	if (pwr_source < 0)
+		return -EINVAL;
+
+	return smu_cmn_send_smc_msg_with_param(smu,
+					       SMU_MSG_NotifyPowerSource,
+					       pwr_source,
+					       NULL);
+}
+
+static int smu_v15_0_get_dpm_freq_by_index(struct smu_context *smu,
+					   enum smu_clk_type clk_type,
+					   uint16_t level,
+					   uint32_t *value)
+{
+	int ret = 0, clk_id = 0;
+	uint32_t param;
+
+	if (!value)
+		return -EINVAL;
+
+	if (!smu_cmn_clk_dpm_is_enabled(smu, clk_type))
+		return 0;
+
+	clk_id = smu_cmn_to_asic_specific_index(smu,
+						CMN2ASIC_MAPPING_CLK,
+						clk_type);
+	if (clk_id < 0)
+		return clk_id;
+
+	param = (uint32_t)(((clk_id & 0xffff) << 16) | (level & 0xffff));
+
+	ret = smu_cmn_send_smc_msg_with_param(smu,
+					      SMU_MSG_GetDpmFreqByIndex,
+					      param,
+					      value);
+	if (ret)
+		return ret;
+
+	*value = *value & 0x7fffffff;
+
+	return ret;
+}
+
+static int smu_v15_0_get_dpm_level_count(struct smu_context *smu,
+					 enum smu_clk_type clk_type,
+					 uint32_t *value)
+{
+	int ret;
+
+	ret = smu_v15_0_get_dpm_freq_by_index(smu, clk_type, 0xff, value);
+
+	return ret;
+}
+
+static int smu_v15_0_get_fine_grained_status(struct smu_context *smu,
+					     enum smu_clk_type clk_type,
+					     bool *is_fine_grained_dpm)
+{
+	int ret = 0, clk_id = 0;
+	uint32_t param;
+	uint32_t value;
+
+	if (!is_fine_grained_dpm)
+		return -EINVAL;
+
+	if (!smu_cmn_clk_dpm_is_enabled(smu, clk_type))
+		return 0;
+
+	clk_id = smu_cmn_to_asic_specific_index(smu,
+						CMN2ASIC_MAPPING_CLK,
+						clk_type);
+	if (clk_id < 0)
+		return clk_id;
+
+	param = (uint32_t)(((clk_id & 0xffff) << 16) | 0xff);
+
+	ret = smu_cmn_send_smc_msg_with_param(smu,
+					      SMU_MSG_GetDpmFreqByIndex,
+					      param,
+					      &value);
+	if (ret)
+		return ret;
+
+	/*
+	 * BIT31:  1 - Fine grained DPM, 0 - Dicrete DPM
+	 * now, we un-support it
+	 */
+	*is_fine_grained_dpm = value & 0x80000000;
+
+	return 0;
+}
+
+int smu_v15_0_set_single_dpm_table(struct smu_context *smu,
+				   enum smu_clk_type clk_type,
+				   struct smu_15_0_dpm_table *single_dpm_table)
+{
+	int ret = 0;
+	uint32_t clk;
+	int i;
+
+	ret = smu_v15_0_get_dpm_level_count(smu,
+					    clk_type,
+					    &single_dpm_table->count);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] failed to get dpm levels!\n", __func__);
+		return ret;
+	}
+
+	ret = smu_v15_0_get_fine_grained_status(smu,
+						clk_type,
+						&single_dpm_table->is_fine_grained);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] failed to get fine grained status!\n", __func__);
+		return ret;
+	}
+
+	for (i = 0; i < single_dpm_table->count; i++) {
+		ret = smu_v15_0_get_dpm_freq_by_index(smu,
+						      clk_type,
+						      i,
+						      &clk);
+		if (ret) {
+			dev_err(smu->adev->dev, "[%s] failed to get dpm freq by index!\n", __func__);
+			return ret;
+		}
+
+		single_dpm_table->dpm_levels[i].value = clk;
+		single_dpm_table->dpm_levels[i].enabled = true;
+
+		if (i == 0)
+			single_dpm_table->min = clk;
+		else if (i == single_dpm_table->count - 1)
+			single_dpm_table->max = clk;
+	}
+
+	return 0;
+}
+
+int smu_v15_0_set_vcn_enable(struct smu_context *smu,
+			      bool enable,
+			      int inst)
+{
+	struct amdgpu_device *adev = smu->adev;
+	int ret = 0;
+
+	if (adev->vcn.harvest_config & (1 << inst))
+		return ret;
+
+	if (smu->is_apu) {
+		ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
+						      SMU_MSG_PowerUpVcn : SMU_MSG_PowerDownVcn,
+						      inst << 16U, NULL);
+	}
+
+	return ret;
+}
+
+int smu_v15_0_set_jpeg_enable(struct smu_context *smu,
+			      bool enable)
+{
+	struct amdgpu_device *adev = smu->adev;
+	int i, ret = 0;
+
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; i++) {
+		if (adev->jpeg.harvest_config & (1 << i))
+			continue;
+
+		if (smu->is_apu) {
+				ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
+								      SMU_MSG_PowerUpJpeg : SMU_MSG_PowerDownJpeg,
+								      i << 16U, NULL);
+		}
+
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
+int smu_v15_0_run_btc(struct smu_context *smu)
+{
+	int res;
+
+	res = smu_cmn_send_smc_msg(smu, SMU_MSG_RunDcBtc, NULL);
+	if (res)
+		dev_err(smu->adev->dev, "RunDcBtc failed!\n");
+
+	return res;
+}
+
+int smu_v15_0_gpo_control(struct smu_context *smu,
+			  bool enablement)
+{
+	int res;
+
+	res = smu_cmn_send_smc_msg_with_param(smu,
+					      SMU_MSG_AllowGpo,
+					      enablement ? 1 : 0,
+					      NULL);
+	if (res)
+		dev_err(smu->adev->dev, "SetGpoAllow %d failed!\n", enablement);
+
+	return res;
+}
+
+int smu_v15_0_deep_sleep_control(struct smu_context *smu,
+				 bool enablement)
+{
+	struct amdgpu_device *adev = smu->adev;
+	int ret = 0;
+
+	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_GFXCLK_BIT)) {
+		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_GFXCLK_BIT, enablement);
+		if (ret) {
+			dev_err(adev->dev, "Failed to %s GFXCLK DS!\n", enablement ? "enable" : "disable");
+			return ret;
+		}
+	}
+
+	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_UCLK_BIT)) {
+		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_UCLK_BIT, enablement);
+		if (ret) {
+			dev_err(adev->dev, "Failed to %s UCLK DS!\n", enablement ? "enable" : "disable");
+			return ret;
+		}
+	}
+
+	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_FCLK_BIT)) {
+		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_FCLK_BIT, enablement);
+		if (ret) {
+			dev_err(adev->dev, "Failed to %s FCLK DS!\n", enablement ? "enable" : "disable");
+			return ret;
+		}
+	}
+
+	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_SOCCLK_BIT)) {
+		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_SOCCLK_BIT, enablement);
+		if (ret) {
+			dev_err(adev->dev, "Failed to %s SOCCLK DS!\n", enablement ? "enable" : "disable");
+			return ret;
+		}
+	}
+
+	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_LCLK_BIT)) {
+		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_LCLK_BIT, enablement);
+		if (ret) {
+			dev_err(adev->dev, "Failed to %s LCLK DS!\n", enablement ? "enable" : "disable");
+			return ret;
+		}
+	}
+
+	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_VCN_BIT)) {
+		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_VCN_BIT, enablement);
+		if (ret) {
+			dev_err(adev->dev, "Failed to %s VCN DS!\n", enablement ? "enable" : "disable");
+			return ret;
+		}
+	}
+
+	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_MP0CLK_BIT)) {
+		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_MP0CLK_BIT, enablement);
+		if (ret) {
+			dev_err(adev->dev, "Failed to %s MP0/MPIOCLK DS!\n", enablement ? "enable" : "disable");
+			return ret;
+		}
+	}
+
+	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_MP1CLK_BIT)) {
+		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_MP1CLK_BIT, enablement);
+		if (ret) {
+			dev_err(adev->dev, "Failed to %s MP1CLK DS!\n", enablement ? "enable" : "disable");
+			return ret;
+		}
+	}
+
+	return ret;
+}
+
+int smu_v15_0_gfx_ulv_control(struct smu_context *smu,
+			      bool enablement)
+{
+	int ret = 0;
+
+	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_GFX_ULV_BIT))
+		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_GFX_ULV_BIT, enablement);
+
+	return ret;
+}
+
+int smu_v15_0_baco_set_armd3_sequence(struct smu_context *smu,
+				      enum smu_baco_seq baco_seq)
+{
+	struct smu_baco_context *smu_baco = &smu->smu_baco;
+	int ret;
+
+	ret = smu_cmn_send_smc_msg_with_param(smu,
+					      SMU_MSG_ArmD3,
+					      baco_seq,
+					      NULL);
+	if (ret)
+		return ret;
+
+	if (baco_seq == BACO_SEQ_BAMACO ||
+	    baco_seq == BACO_SEQ_BACO)
+		smu_baco->state = SMU_BACO_STATE_ENTER;
+	else
+		smu_baco->state = SMU_BACO_STATE_EXIT;
+
+	return 0;
+}
+
+int smu_v15_0_get_bamaco_support(struct smu_context *smu)
+{
+	struct smu_baco_context *smu_baco = &smu->smu_baco;
+	int bamaco_support = 0;
+
+	if (amdgpu_sriov_vf(smu->adev) ||
+	    !smu_baco->platform_support)
+		return 0;
+
+	if (smu_baco->maco_support)
+		bamaco_support |= MACO_SUPPORT;
+
+	/* return true if ASIC is in BACO state already */
+	if (smu_v15_0_baco_get_state(smu) == SMU_BACO_STATE_ENTER)
+		return (bamaco_support |= BACO_SUPPORT);
+
+	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_BACO_BIT) &&
+	    !smu_cmn_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT))
+		return 0;
+
+	return (bamaco_support |= BACO_SUPPORT);
+}
+
+enum smu_baco_state smu_v15_0_baco_get_state(struct smu_context *smu)
+{
+	struct smu_baco_context *smu_baco = &smu->smu_baco;
+
+	return smu_baco->state;
+}
+
+int smu_v15_0_baco_set_state(struct smu_context *smu,
+			     enum smu_baco_state state)
+{
+	struct smu_baco_context *smu_baco = &smu->smu_baco;
+	struct amdgpu_device *adev = smu->adev;
+	int ret = 0;
+
+	if (smu_v15_0_baco_get_state(smu) == state)
+		return 0;
+
+	if (state == SMU_BACO_STATE_ENTER) {
+		ret = smu_cmn_send_smc_msg_with_param(smu,
+						      SMU_MSG_EnterBaco,
+						      (adev->pm.rpm_mode == AMDGPU_RUNPM_BAMACO) ?
+						      BACO_SEQ_BAMACO : BACO_SEQ_BACO,
+						      NULL);
+	} else {
+		ret = smu_cmn_send_smc_msg(smu,
+					   SMU_MSG_ExitBaco,
+					   NULL);
+		if (ret)
+			return ret;
+
+		/* clear vbios scratch 6 and 7 for coming asic reinit */
+		WREG32(adev->bios_scratch_reg_offset + 6, 0);
+		WREG32(adev->bios_scratch_reg_offset + 7, 0);
+	}
+
+	if (!ret)
+		smu_baco->state = state;
+
+	return ret;
+}
+
+int smu_v15_0_baco_enter(struct smu_context *smu)
+{
+	int ret = 0;
+
+	ret = smu_v15_0_baco_set_state(smu,
+				       SMU_BACO_STATE_ENTER);
+	if (ret)
+		return ret;
+
+	msleep(10);
+
+	return ret;
+}
+
+int smu_v15_0_baco_exit(struct smu_context *smu)
+{
+	return smu_v15_0_baco_set_state(smu,
+					SMU_BACO_STATE_EXIT);
+}
+
+int smu_v15_0_set_gfx_power_up_by_imu(struct smu_context *smu)
+{
+	uint16_t index;
+	struct amdgpu_device *adev = smu->adev;
+
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
+		return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_EnableGfxImu,
+						       ENABLE_IMU_ARG_GFXOFF_ENABLE, NULL);
+	}
+
+	index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
+					       SMU_MSG_EnableGfxImu);
+	return smu_cmn_send_msg_without_waiting(smu, index, ENABLE_IMU_ARG_GFXOFF_ENABLE);
+}
+
+int smu_v15_0_set_default_dpm_tables(struct smu_context *smu)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+
+	return smu_cmn_update_table(smu, SMU_TABLE_DPMCLOCKS, 0,
+				    smu_table->clocks_table, false);
+}
+
+int smu_v15_0_od_edit_dpm_table(struct smu_context *smu,
+				enum PP_OD_DPM_TABLE_COMMAND type,
+				long input[], uint32_t size)
+{
+	struct smu_dpm_context *smu_dpm = &(smu->smu_dpm);
+	int ret = 0;
+
+	/* Only allowed in manual mode */
+	if (smu_dpm->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL)
+		return -EINVAL;
+
+	switch (type) {
+	case PP_OD_EDIT_SCLK_VDDC_TABLE:
+		if (size != 2) {
+			dev_err(smu->adev->dev, "Input parameter number not correct\n");
+			return -EINVAL;
+		}
+
+		if (input[0] == 0) {
+			if (input[1] < smu->gfx_default_hard_min_freq) {
+				dev_warn(smu->adev->dev,
+					 "Fine grain setting minimum sclk (%ld) MHz is less than the minimum allowed (%d) MHz\n",
+					 input[1], smu->gfx_default_hard_min_freq);
+				return -EINVAL;
+			}
+			smu->gfx_actual_hard_min_freq = input[1];
+		} else if (input[0] == 1) {
+			if (input[1] > smu->gfx_default_soft_max_freq) {
+				dev_warn(smu->adev->dev,
+					 "Fine grain setting maximum sclk (%ld) MHz is greater than the maximum allowed (%d) MHz\n",
+					 input[1], smu->gfx_default_soft_max_freq);
+				return -EINVAL;
+			}
+			smu->gfx_actual_soft_max_freq = input[1];
+		} else {
+			return -EINVAL;
+		}
+		break;
+	case PP_OD_RESTORE_DEFAULT_TABLE:
+		if (size != 0) {
+			dev_err(smu->adev->dev, "Input parameter number not correct\n");
+			return -EINVAL;
+		}
+		smu->gfx_actual_hard_min_freq = smu->gfx_default_hard_min_freq;
+		smu->gfx_actual_soft_max_freq = smu->gfx_default_soft_max_freq;
+		break;
+	case PP_OD_COMMIT_DPM_TABLE:
+		if (size != 0) {
+			dev_err(smu->adev->dev, "Input parameter number not correct\n");
+			return -EINVAL;
+		}
+		if (smu->gfx_actual_hard_min_freq > smu->gfx_actual_soft_max_freq) {
+			dev_err(smu->adev->dev,
+				"The setting minimum sclk (%d) MHz is greater than the setting maximum sclk (%d) MHz\n",
+				smu->gfx_actual_hard_min_freq,
+				smu->gfx_actual_soft_max_freq);
+			return -EINVAL;
+		}
+
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinGfxClk,
+						      smu->gfx_actual_hard_min_freq,
+						      NULL);
+		if (ret) {
+			dev_err(smu->adev->dev, "Set hard min sclk failed!");
+			return ret;
+		}
+
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxGfxClk,
+						      smu->gfx_actual_soft_max_freq,
+						      NULL);
+		if (ret) {
+			dev_err(smu->adev->dev, "Set soft max sclk failed!");
+			return ret;
+		}
+		break;
+	default:
+		return -ENOSYS;
+	}
+
+	return ret;
+}
+
+static int smu_v15_0_allow_ih_interrupt(struct smu_context *smu)
+{
+	return smu_cmn_send_smc_msg(smu,
+				    SMU_MSG_AllowIHHostInterrupt,
+				    NULL);
+}
+
+int smu_v15_0_enable_thermal_alert(struct smu_context *smu)
+{
+	int ret = 0;
+
+	if (!smu->irq_source.num_types)
+		return 0;
+
+	ret = amdgpu_irq_get(smu->adev, &smu->irq_source, 0);
+	if (ret)
+		return ret;
+
+	return smu_v15_0_allow_ih_interrupt(smu);
+}
+
+int smu_v15_0_disable_thermal_alert(struct smu_context *smu)
+{
+	if (!smu->irq_source.num_types)
+		return 0;
+
+	return amdgpu_irq_put(smu->adev, &smu->irq_source, 0);
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
new file mode 100644
index 0000000000000..683d204897458
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -0,0 +1,1352 @@
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#include "smu_types.h"
+#define SWSMU_CODE_LAYER_L2
+
+#include "amdgpu.h"
+#include "amdgpu_smu.h"
+#include "smu_v15_0.h"
+#include "smu15_driver_if_v15_0_0.h"
+#include "smu_v15_0_0_ppt.h"
+#include "smu_v15_0_0_ppsmc.h"
+#include "smu_v15_0_0_pmfw.h"
+#include "smu_cmn.h"
+
+/*
+ * DO NOT use these for err/warn/info/debug messages.
+ * Use dev_err, dev_warn, dev_info and dev_dbg instead.
+ * They are more MGPU friendly.
+ */
+#undef pr_err
+#undef pr_warn
+#undef pr_info
+#undef pr_debug
+
+#define mmMP1_SMN_C2PMSG_30			0x005e
+#define mmMP1_SMN_C2PMSG_30_BASE_IDX            1
+
+#define mmMP1_SMN_C2PMSG_31			0x005f
+#define mmMP1_SMN_C2PMSG_31_BASE_IDX            1
+
+#define mmMP1_SMN_C2PMSG_32			0x0060
+#define mmMP1_SMN_C2PMSG_32_BASE_IDX		    1
+
+/* MALLPowerController message arguments (Defines for the Cache mode control) */
+#define SMU_MALL_PMFW_CONTROL 0
+#define SMU_MALL_DRIVER_CONTROL 1
+
+/*
+ * MALLPowerState message arguments
+ * (Defines for the Allocate/Release Cache mode if in driver mode)
+ */
+#define SMU_MALL_EXIT_PG 0
+#define SMU_MALL_ENTER_PG 1
+
+#define SMU_MALL_PG_CONFIG_DEFAULT SMU_MALL_PG_CONFIG_DRIVER_CONTROL_ALWAYS_ON
+
+#define SMU_15_0_UMD_PSTATE_GFXCLK 700
+#define SMU_15_0_UMD_PSTATE_SOCCLK 678
+#define SMU_15_0_UMD_PSTATE_FCLK 1800
+
+
+#define FEATURE_MASK(feature) (1ULL << feature)
+#define SMC_DPM_FEATURE ( \
+	FEATURE_MASK(FEATURE_CCLK_DPM_BIT) | \
+	FEATURE_MASK(FEATURE_VCN_DPM_BIT)	 | \
+	FEATURE_MASK(FEATURE_FCLK_DPM_BIT)	 | \
+	FEATURE_MASK(FEATURE_SOCCLK_DPM_BIT)	 | \
+	FEATURE_MASK(FEATURE_LCLK_DPM_BIT)	 | \
+	FEATURE_MASK(FEATURE_SHUBCLK_DPM_BIT)	 | \
+	FEATURE_MASK(FEATURE_DCFCLK_DPM_BIT)| \
+	FEATURE_MASK(FEATURE_ISP_DPM_BIT)| \
+	FEATURE_MASK(FEATURE_NPU_DPM_BIT)	| \
+	FEATURE_MASK(FEATURE_GFX_DPM_BIT)	| \
+	FEATURE_MASK(FEATURE_VPE_DPM_BIT))
+
+enum smu_mall_pg_config {
+	SMU_MALL_PG_CONFIG_PMFW_CONTROL = 0,
+	SMU_MALL_PG_CONFIG_DRIVER_CONTROL_ALWAYS_ON = 1,
+	SMU_MALL_PG_CONFIG_DRIVER_CONTROL_ALWAYS_OFF = 2,
+};
+
+static struct cmn2asic_msg_mapping smu_v15_0_0_message_map[SMU_MSG_MAX_COUNT] = {
+	MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,				1),
+	MSG_MAP(GetSmuVersion,                  PPSMC_MSG_GetPmfwVersion,			1),
+	MSG_MAP(GetDriverIfVersion,             PPSMC_MSG_GetDriverIfVersion,		1),
+	MSG_MAP(PowerDownVcn,                   PPSMC_MSG_PowerDownVcn,				1),
+	MSG_MAP(PowerUpVcn,                     PPSMC_MSG_PowerUpVcn,				1),
+	MSG_MAP(SetSoftMinGfxclk,               PPSMC_MSG_SetSoftMinGfxclk,			1),
+	MSG_MAP(PrepareMp1ForUnload,            PPSMC_MSG_PrepareMp1ForUnload,		1),
+	MSG_MAP(TransferTableSmu2Dram,          PPSMC_MSG_TransferTableSmu2Dram,	1),
+	MSG_MAP(TransferTableDram2Smu,          PPSMC_MSG_TransferTableDram2Smu,	1),
+	MSG_MAP(GfxDeviceDriverReset,           PPSMC_MSG_GfxDeviceDriverReset,		1),
+	MSG_MAP(GetEnabledSmuFeatures,          PPSMC_MSG_GetEnabledSmuFeatures,	1),
+	MSG_MAP(SetSoftMinFclk,                 PPSMC_MSG_SetSoftMinFclk,			1),
+	MSG_MAP(SetSoftMinVcn,                  PPSMC_MSG_SetSoftMinVcn,			1),
+	MSG_MAP(EnableGfxImu,                   PPSMC_MSG_EnableGfxImu,				1),
+	MSG_MAP(AllowGfxOff,                    PPSMC_MSG_AllowGfxOff,				1),
+	MSG_MAP(DisallowGfxOff,                 PPSMC_MSG_DisallowGfxOff,			1),
+	MSG_MAP(SetSoftMaxGfxClk,               PPSMC_MSG_SetSoftMaxGfxClk,			1),
+	MSG_MAP(SetSoftMaxSocclkByFreq,         PPSMC_MSG_SetSoftMaxSocclkByFreq,	1),
+	MSG_MAP(SetSoftMaxFclkByFreq,           PPSMC_MSG_SetSoftMaxFclkByFreq,		1),
+	MSG_MAP(SetSoftMaxVcn,                  PPSMC_MSG_SetSoftMaxVcn,			1),
+	MSG_MAP(PowerDownJpeg,                  PPSMC_MSG_PowerDownJpeg,			1),
+	MSG_MAP(PowerUpJpeg,                    PPSMC_MSG_PowerUpJpeg,				1),
+	MSG_MAP(SetSoftMinSocclkByFreq,         PPSMC_MSG_SetSoftMinSocclkByFreq,	1),
+	MSG_MAP(AllowZstates,                   PPSMC_MSG_AllowZstates,				1),
+	MSG_MAP(GetSmartShiftStatus,            PPSMC_MSG_GetSmartShiftStatus,		1),
+	MSG_MAP(PowerUpUmsch,                   PPSMC_MSG_PowerUpUmsch,				1),
+	MSG_MAP(PowerDownUmsch,                 PPSMC_MSG_PowerDownUmsch,			1),
+	MSG_MAP(PowerUpVpe,                     PPSMC_MSG_PowerUpVpe,				1),
+	MSG_MAP(PowerDownVpe,                   PPSMC_MSG_PowerDownVpe,				1),
+	MSG_MAP(EnableLSdma,                    PPSMC_MSG_EnableLSdma,				1),
+	MSG_MAP(DisableLSdma,                   PPSMC_MSG_DisableLSdma,				1),
+	MSG_MAP(SetSoftMaxVpe,                  PPSMC_MSG_SetSoftMaxVpe,			1),
+	MSG_MAP(SetSoftMinVpe,                  PPSMC_MSG_SetSoftMinVpe,			1),
+};
+
+static struct cmn2asic_mapping smu_v15_0_0_feature_mask_map[SMU_FEATURE_COUNT] = {
+	FEA_MAP(CCLK_DPM),
+	FEA_MAP(FAN_CONTROLLER),
+	FEA_MAP(PPT),
+	FEA_MAP(TDC),
+	FEA_MAP(THERMAL),
+	FEA_MAP(VCN_DPM),
+	FEA_MAP_REVERSE(FCLK),
+	FEA_MAP_REVERSE(SOCCLK),
+	FEA_MAP(LCLK_DPM),
+	FEA_MAP(SHUBCLK_DPM),
+	FEA_MAP(DCFCLK_DPM),
+	FEA_MAP_HALF_REVERSE(GFX),
+	FEA_MAP(DS_GFXCLK),
+	FEA_MAP(DS_SOCCLK),
+	FEA_MAP(DS_LCLK),
+	FEA_MAP(LOW_POWER_DCNCLKS),
+	FEA_MAP(DS_FCLK),
+	FEA_MAP(DS_MP1CLK),
+	FEA_MAP(PSI),
+	FEA_MAP(PROCHOT),
+	FEA_MAP(CPUOFF),
+	FEA_MAP(STAPM),
+	FEA_MAP(S0I3),
+	FEA_MAP(PERF_LIMIT),
+	FEA_MAP(CORE_DLDO),
+	FEA_MAP(DS_VCN),
+	FEA_MAP(CPPC),
+	FEA_MAP(DF_CSTATES),
+	FEA_MAP(ATHUB_PG),
+};
+
+static struct cmn2asic_mapping smu_v15_0_0_table_map[SMU_TABLE_COUNT] = {
+	TAB_MAP_VALID(WATERMARKS),
+	TAB_MAP_VALID(SMU_METRICS),
+	TAB_MAP_VALID(CUSTOM_DPM),
+	TAB_MAP_VALID(DPMCLOCKS),
+};
+
+static int smu_v15_0_0_init_smc_tables(struct smu_context *smu)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct smu_table *tables = smu_table->tables;
+
+	SMU_TABLE_INIT(tables, SMU_TABLE_WATERMARKS, sizeof(Watermarks_t),
+		PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
+	SMU_TABLE_INIT(tables, SMU_TABLE_DPMCLOCKS, sizeof(DpmClocks_t),
+		PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
+	SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(SmuMetrics_t),
+		PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
+
+	smu_table->metrics_table = kzalloc(sizeof(SmuMetrics_t), GFP_KERNEL);
+	if (!smu_table->metrics_table)
+		goto err0_out;
+	smu_table->metrics_time = 0;
+
+	smu_table->clocks_table = kzalloc(sizeof(DpmClocks_t), GFP_KERNEL);
+	if (!smu_table->clocks_table)
+		goto err1_out;
+
+	smu_table->watermarks_table = kzalloc(sizeof(Watermarks_t), GFP_KERNEL);
+	if (!smu_table->watermarks_table)
+		goto err2_out;
+
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v3_0);
+	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
+	if (!smu_table->gpu_metrics_table)
+		goto err3_out;
+
+	return 0;
+
+err3_out:
+	kfree(smu_table->watermarks_table);
+err2_out:
+	kfree(smu_table->clocks_table);
+err1_out:
+	kfree(smu_table->metrics_table);
+err0_out:
+	return -ENOMEM;
+}
+
+static int smu_v15_0_0_fini_smc_tables(struct smu_context *smu)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+
+	kfree(smu_table->clocks_table);
+	smu_table->clocks_table = NULL;
+
+	kfree(smu_table->metrics_table);
+	smu_table->metrics_table = NULL;
+
+	kfree(smu_table->watermarks_table);
+	smu_table->watermarks_table = NULL;
+
+	kfree(smu_table->gpu_metrics_table);
+	smu_table->gpu_metrics_table = NULL;
+
+	return 0;
+}
+
+static int smu_v15_0_0_system_features_control(struct smu_context *smu, bool en)
+{
+	struct amdgpu_device *adev = smu->adev;
+	int ret = 0;
+
+	if (!en && !adev->in_s0ix)
+		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_PrepareMp1ForUnload, NULL);
+
+	return ret;
+}
+
+static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
+					    MetricsMember_t member,
+					    uint32_t *value)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+
+	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
+	int ret = 0;
+
+	ret = smu_cmn_get_metrics_table(smu, NULL, false);
+	if (ret)
+		return ret;
+
+	switch (member) {
+	case METRICS_AVERAGE_GFXCLK:
+		*value = metrics->GfxclkFrequency;
+		break;
+	case METRICS_AVERAGE_SOCCLK:
+		*value = metrics->SocclkFrequency;
+		break;
+	case METRICS_AVERAGE_VCLK:
+		*value = metrics->VclkFrequency;
+		break;
+	case METRICS_AVERAGE_DCLK:
+		*value = 0;
+		break;
+	case METRICS_AVERAGE_UCLK:
+		*value = metrics->MemclkFrequency;
+		break;
+	case METRICS_AVERAGE_FCLK:
+		*value = metrics->FclkFrequency;
+		break;
+	case METRICS_AVERAGE_VPECLK:
+		*value = metrics->VpeclkFrequency;
+		break;
+	case METRICS_AVERAGE_NPUCLK:
+		*value = metrics->NpuclkFrequency;
+		break;
+	case METRICS_AVERAGE_GFXACTIVITY:
+		if ((smu->smc_fw_version > 0x5d4600))
+			*value = metrics->GfxActivity;
+		else
+			*value = metrics->GfxActivity / 100;
+		break;
+	case METRICS_AVERAGE_VCNACTIVITY:
+		*value = metrics->VcnActivity / 100;
+		break;
+	case METRICS_AVERAGE_SOCKETPOWER:
+	case METRICS_CURR_SOCKETPOWER:
+		*value = (metrics->SocketPower / 1000 << 8) +
+		(metrics->SocketPower % 1000 / 10);
+		break;
+	case METRICS_TEMPERATURE_EDGE:
+		*value = metrics->GfxTemperature / 100 *
+		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		break;
+	case METRICS_TEMPERATURE_HOTSPOT:
+		*value = metrics->SocTemperature / 100 *
+		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		break;
+	case METRICS_THROTTLER_RESIDENCY_PROCHOT:
+		*value = metrics->ThrottleResidency_PROCHOT;
+		break;
+	case METRICS_THROTTLER_RESIDENCY_SPL:
+		*value = metrics->ThrottleResidency_SPL;
+		break;
+	case METRICS_THROTTLER_RESIDENCY_FPPT:
+		*value = metrics->ThrottleResidency_FPPT;
+		break;
+	case METRICS_THROTTLER_RESIDENCY_SPPT:
+		*value = metrics->ThrottleResidency_SPPT;
+		break;
+	case METRICS_THROTTLER_RESIDENCY_THM_SOC:
+		*value = metrics->ThrottleResidency_THM_SOC;
+		break;
+	case METRICS_VOLTAGE_VDDGFX:
+		*value = 0;
+		break;
+	case METRICS_VOLTAGE_VDDSOC:
+		*value = 0;
+		break;
+	case METRICS_SS_APU_SHARE:
+		/* return the percentage of APU power with respect to APU's power limit.
+		 * percentage is reported, this isn't boost value. Smartshift power
+		 * boost/shift is only when the percentage is more than 100.
+		 */
+		if (metrics->StapmOpnLimit > 0)
+			*value = (metrics->ApuPower * 100) / metrics->StapmOpnLimit;
+		else
+			*value = 0;
+		break;
+	case METRICS_SS_DGPU_SHARE:
+		/* return the percentage of dGPU power with respect to dGPU's power limit.
+		 * percentage is reported, this isn't boost value. Smartshift power
+		 * boost/shift is only when the percentage is more than 100.
+		 */
+		if ((metrics->dGpuPower > 0) &&
+		    (metrics->StapmCurrentLimit > metrics->StapmOpnLimit))
+			*value = (metrics->dGpuPower * 100) /
+				 (metrics->StapmCurrentLimit - metrics->StapmOpnLimit);
+		else
+			*value = 0;
+		break;
+	default:
+		*value = UINT_MAX;
+		break;
+	}
+
+	return ret;
+}
+
+static int smu_v15_0_0_read_sensor(struct smu_context *smu,
+				   enum amd_pp_sensors sensor,
+				   void *data, uint32_t *size)
+{
+	int ret = 0;
+
+	if (!data || !size)
+		return -EINVAL;
+
+	switch (sensor) {
+	case AMDGPU_PP_SENSOR_GPU_LOAD:
+		ret = smu_v15_0_0_get_smu_metrics_data(smu,
+						       METRICS_AVERAGE_GFXACTIVITY,
+						       (uint32_t *)data);
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_VCN_LOAD:
+		ret = smu_v15_0_0_get_smu_metrics_data(smu,
+							METRICS_AVERAGE_VCNACTIVITY,
+							(uint32_t *)data);
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_GPU_AVG_POWER:
+		ret = smu_v15_0_0_get_smu_metrics_data(smu,
+						       METRICS_AVERAGE_SOCKETPOWER,
+						       (uint32_t *)data);
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_GPU_INPUT_POWER:
+		ret = smu_v15_0_0_get_smu_metrics_data(smu,
+						       METRICS_CURR_SOCKETPOWER,
+						       (uint32_t *)data);
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_EDGE_TEMP:
+		ret = smu_v15_0_0_get_smu_metrics_data(smu,
+						       METRICS_TEMPERATURE_EDGE,
+						       (uint32_t *)data);
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_HOTSPOT_TEMP:
+		ret = smu_v15_0_0_get_smu_metrics_data(smu,
+						       METRICS_TEMPERATURE_HOTSPOT,
+						       (uint32_t *)data);
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_GFX_MCLK:
+		ret = smu_v15_0_0_get_smu_metrics_data(smu,
+						       METRICS_AVERAGE_UCLK,
+						       (uint32_t *)data);
+		*(uint32_t *)data *= 100;
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_GFX_SCLK:
+		ret = smu_v15_0_0_get_smu_metrics_data(smu,
+						       METRICS_AVERAGE_GFXCLK,
+						       (uint32_t *)data);
+		*(uint32_t *)data *= 100;
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_VDDGFX:
+		ret = smu_v15_0_0_get_smu_metrics_data(smu,
+						       METRICS_VOLTAGE_VDDGFX,
+						       (uint32_t *)data);
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_VDDNB:
+		ret = smu_v15_0_0_get_smu_metrics_data(smu,
+						       METRICS_VOLTAGE_VDDSOC,
+						       (uint32_t *)data);
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_SS_APU_SHARE:
+		ret = smu_v15_0_0_get_smu_metrics_data(smu,
+						       METRICS_SS_APU_SHARE,
+						       (uint32_t *)data);
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_SS_DGPU_SHARE:
+		ret = smu_v15_0_0_get_smu_metrics_data(smu,
+						       METRICS_SS_DGPU_SHARE,
+						       (uint32_t *)data);
+		*size = 4;
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+		break;
+	}
+
+	return ret;
+}
+
+static bool smu_v15_0_0_is_dpm_running(struct smu_context *smu)
+{
+	int ret = 0;
+	uint64_t feature_enabled;
+
+	ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
+
+	if (ret)
+		return false;
+
+	return !!(feature_enabled & SMC_DPM_FEATURE);
+}
+
+static int smu_v15_0_0_set_watermarks_table(struct smu_context *smu,
+					    struct pp_smu_wm_range_sets *clock_ranges)
+{
+	int i;
+	int ret = 0;
+	Watermarks_t *table = smu->smu_table.watermarks_table;
+
+	if (!table || !clock_ranges)
+		return -EINVAL;
+
+	if (clock_ranges->num_reader_wm_sets > NUM_WM_RANGES ||
+		clock_ranges->num_writer_wm_sets > NUM_WM_RANGES)
+		return -EINVAL;
+
+	for (i = 0; i < clock_ranges->num_reader_wm_sets; i++) {
+		table->WatermarkRow[WM_DCFCLK][i].MinClock =
+			clock_ranges->reader_wm_sets[i].min_drain_clk_mhz;
+		table->WatermarkRow[WM_DCFCLK][i].MaxClock =
+			clock_ranges->reader_wm_sets[i].max_drain_clk_mhz;
+		table->WatermarkRow[WM_DCFCLK][i].MinMclk =
+			clock_ranges->reader_wm_sets[i].min_fill_clk_mhz;
+		table->WatermarkRow[WM_DCFCLK][i].MaxMclk =
+			clock_ranges->reader_wm_sets[i].max_fill_clk_mhz;
+
+		table->WatermarkRow[WM_DCFCLK][i].WmSetting =
+			clock_ranges->reader_wm_sets[i].wm_inst;
+	}
+
+	for (i = 0; i < clock_ranges->num_writer_wm_sets; i++) {
+		table->WatermarkRow[WM_SOCCLK][i].MinClock =
+			clock_ranges->writer_wm_sets[i].min_fill_clk_mhz;
+		table->WatermarkRow[WM_SOCCLK][i].MaxClock =
+			clock_ranges->writer_wm_sets[i].max_fill_clk_mhz;
+		table->WatermarkRow[WM_SOCCLK][i].MinMclk =
+			clock_ranges->writer_wm_sets[i].min_drain_clk_mhz;
+		table->WatermarkRow[WM_SOCCLK][i].MaxMclk =
+			clock_ranges->writer_wm_sets[i].max_drain_clk_mhz;
+
+		table->WatermarkRow[WM_SOCCLK][i].WmSetting =
+			clock_ranges->writer_wm_sets[i].wm_inst;
+	}
+
+	smu->watermarks_bitmap |= WATERMARKS_EXIST;
+
+	/* pass data to smu controller */
+	if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
+	     !(smu->watermarks_bitmap & WATERMARKS_LOADED)) {
+		ret = smu_cmn_write_watermarks_table(smu);
+		if (ret) {
+			dev_err(smu->adev->dev, "Failed to update WMTABLE!");
+			return ret;
+		}
+		smu->watermarks_bitmap |= WATERMARKS_LOADED;
+	}
+
+	return 0;
+}
+
+static ssize_t smu_v15_0_0_get_gpu_metrics(struct smu_context *smu,
+						void **table)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct gpu_metrics_v3_0 *gpu_metrics =
+		(struct gpu_metrics_v3_0 *)smu_table->gpu_metrics_table;
+	SmuMetrics_t metrics;
+	int ret = 0;
+
+	ret = smu_cmn_get_metrics_table(smu, &metrics, true);
+	if (ret)
+		return ret;
+
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 3, 0);
+
+	gpu_metrics->temperature_gfx = metrics.GfxTemperature;
+	gpu_metrics->temperature_soc = metrics.SocTemperature;
+	memcpy(&gpu_metrics->temperature_core[0],
+		&metrics.CoreTemperature[0],
+		sizeof(uint16_t) * 16);
+	gpu_metrics->temperature_skin = metrics.SkinTemp;
+
+	gpu_metrics->average_gfx_activity = metrics.GfxActivity;
+	gpu_metrics->average_vcn_activity = metrics.VcnActivity;
+
+	memcpy(&gpu_metrics->average_core_c0_activity[0],
+		&metrics.CoreC0Residency[0],
+		sizeof(uint16_t) * 16);
+	gpu_metrics->average_dram_reads = metrics.DRAMReads;
+	gpu_metrics->average_dram_writes = metrics.DRAMWrites;
+
+	gpu_metrics->average_socket_power = metrics.SocketPower;
+	gpu_metrics->average_apu_power = metrics.ApuPower;
+	gpu_metrics->average_gfx_power = metrics.GfxPower;
+	gpu_metrics->average_dgpu_power = metrics.dGpuPower;
+	gpu_metrics->average_all_core_power = metrics.AllCorePower;
+	gpu_metrics->average_sys_power = metrics.Psys;
+	memcpy(&gpu_metrics->average_core_power[0],
+		&metrics.CorePower[0],
+		sizeof(uint16_t) * 16);
+
+	gpu_metrics->average_gfxclk_frequency = metrics.GfxclkFrequency;
+	gpu_metrics->average_socclk_frequency = metrics.SocclkFrequency;
+	gpu_metrics->average_vpeclk_frequency = metrics.VpeclkFrequency;
+	gpu_metrics->average_fclk_frequency = metrics.FclkFrequency;
+	gpu_metrics->average_vclk_frequency = metrics.VclkFrequency;
+	gpu_metrics->average_uclk_frequency = metrics.MemclkFrequency;
+
+	memcpy(&gpu_metrics->current_coreclk[0],
+		&metrics.CoreFrequency[0],
+		sizeof(uint16_t) * 16);
+	gpu_metrics->current_core_maxfreq = metrics.InfrastructureCpuMaxFreq;
+	gpu_metrics->current_gfx_maxfreq = metrics.InfrastructureGfxMaxFreq;
+
+	gpu_metrics->throttle_residency_prochot = metrics.ThrottleResidency_PROCHOT;
+	gpu_metrics->throttle_residency_spl = metrics.ThrottleResidency_SPL;
+	gpu_metrics->throttle_residency_fppt = metrics.ThrottleResidency_FPPT;
+	gpu_metrics->throttle_residency_sppt = metrics.ThrottleResidency_SPPT;
+	gpu_metrics->throttle_residency_thm_soc = metrics.ThrottleResidency_THM_SOC;
+
+	gpu_metrics->time_filter_alphavalue = metrics.FilterAlphaValue;
+	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
+
+	*table = (void *)gpu_metrics;
+
+	return sizeof(struct gpu_metrics_v3_0);
+}
+
+static int smu_v15_0_0_mode2_reset(struct smu_context *smu)
+{
+	int ret;
+
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GfxDeviceDriverReset,
+					       SMU_RESET_MODE_2, NULL);
+
+	if (ret)
+		dev_err(smu->adev->dev, "Failed to mode2 reset!\n");
+
+	return ret;
+}
+
+static int smu_v15_0_0_get_dpm_freq_by_index(struct smu_context *smu,
+						enum smu_clk_type clk_type,
+						uint32_t dpm_level,
+						uint32_t *freq)
+{
+	DpmClocks_t *clk_table = smu->smu_table.clocks_table;
+
+	if (!clk_table || clk_type >= SMU_CLK_COUNT)
+		return -EINVAL;
+
+	switch (clk_type) {
+	case SMU_SOCCLK:
+		if (dpm_level >= clk_table->NumSocClkLevelsEnabled)
+			return -EINVAL;
+		*freq = clk_table->SocClocks[dpm_level];
+		break;
+	case SMU_VCLK:
+		if (dpm_level >= clk_table->VcnClkLevelsEnabled)
+			return -EINVAL;
+		*freq = clk_table->VClocks[dpm_level];
+		break;
+	case SMU_DCLK:
+		if (dpm_level >= clk_table->VcnClkLevelsEnabled)
+			return -EINVAL;
+		*freq = clk_table->DClocks[dpm_level];
+		break;
+	case SMU_UCLK:
+	case SMU_MCLK:
+		if (dpm_level >= clk_table->NumMemPstatesEnabled)
+			return -EINVAL;
+		*freq = clk_table->MemPstateTable[dpm_level].MemClk;
+		break;
+	case SMU_FCLK:
+		if (dpm_level >= clk_table->NumFclkLevelsEnabled)
+			return -EINVAL;
+		*freq = clk_table->FclkClocks_Freq[dpm_level];
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int smu_v15_0_common_get_dpm_freq_by_index(struct smu_context *smu,
+						enum smu_clk_type clk_type,
+						uint32_t dpm_level,
+						uint32_t *freq)
+{
+		smu_v15_0_0_get_dpm_freq_by_index(smu, clk_type, dpm_level, freq);
+
+	return 0;
+}
+
+static bool smu_v15_0_0_clk_dpm_is_enabled(struct smu_context *smu,
+						enum smu_clk_type clk_type)
+{
+	enum smu_feature_mask feature_id = 0;
+
+	switch (clk_type) {
+	case SMU_MCLK:
+	case SMU_UCLK:
+	case SMU_FCLK:
+		feature_id = SMU_FEATURE_DPM_FCLK_BIT;
+		break;
+	case SMU_GFXCLK:
+	case SMU_SCLK:
+		feature_id = SMU_FEATURE_DPM_GFXCLK_BIT;
+		break;
+	case SMU_SOCCLK:
+		feature_id = SMU_FEATURE_DPM_SOCCLK_BIT;
+		break;
+	case SMU_VCLK:
+	case SMU_DCLK:
+	case SMU_VCLK1:
+	case SMU_DCLK1:
+		feature_id = SMU_FEATURE_VCN_DPM_BIT;
+		break;
+	default:
+		return true;
+	}
+
+	return smu_cmn_feature_is_enabled(smu, feature_id);
+}
+
+static int smu_v15_0_0_get_dpm_ultimate_freq(struct smu_context *smu,
+							enum smu_clk_type clk_type,
+							uint32_t *min,
+							uint32_t *max)
+{
+	DpmClocks_t *clk_table = smu->smu_table.clocks_table;
+	uint32_t clock_limit;
+	uint32_t max_dpm_level, min_dpm_level;
+	int ret = 0;
+
+	if (!smu_v15_0_0_clk_dpm_is_enabled(smu, clk_type)) {
+		switch (clk_type) {
+		case SMU_MCLK:
+		case SMU_UCLK:
+			clock_limit = smu->smu_table.boot_values.uclk;
+			break;
+		case SMU_FCLK:
+			clock_limit = smu->smu_table.boot_values.fclk;
+			break;
+		case SMU_GFXCLK:
+		case SMU_SCLK:
+			clock_limit = smu->smu_table.boot_values.gfxclk;
+			break;
+		case SMU_SOCCLK:
+			clock_limit = smu->smu_table.boot_values.socclk;
+			break;
+		case SMU_VCLK:
+			clock_limit = smu->smu_table.boot_values.vclk;
+			break;
+		case SMU_DCLK:
+			clock_limit = smu->smu_table.boot_values.dclk;
+			break;
+		default:
+			clock_limit = 0;
+			break;
+		}
+
+		/* clock in Mhz unit */
+		if (min)
+			*min = clock_limit / 100;
+		if (max)
+			*max = clock_limit / 100;
+
+		return 0;
+	}
+
+	if (max) {
+		switch (clk_type) {
+		case SMU_GFXCLK:
+		case SMU_SCLK:
+			*max = clk_table->MaxGfxClk;
+			break;
+		case SMU_MCLK:
+		case SMU_UCLK:
+			max_dpm_level = 0;
+			break;
+		case SMU_FCLK:
+			max_dpm_level = clk_table->NumFclkLevelsEnabled - 1;
+			break;
+		case SMU_SOCCLK:
+			max_dpm_level = clk_table->NumSocClkLevelsEnabled - 1;
+			break;
+		case SMU_VCLK:
+		case SMU_DCLK:
+			max_dpm_level = clk_table->VcnClkLevelsEnabled - 1;
+			break;
+		default:
+			ret = -EINVAL;
+			goto failed;
+		}
+
+		if (clk_type != SMU_GFXCLK && clk_type != SMU_SCLK) {
+			ret = smu_v15_0_common_get_dpm_freq_by_index(smu, clk_type, max_dpm_level, max);
+			if (ret)
+				goto failed;
+		}
+	}
+
+	if (min) {
+		switch (clk_type) {
+		case SMU_GFXCLK:
+		case SMU_SCLK:
+			*min = clk_table->MinGfxClk;
+			break;
+		case SMU_MCLK:
+		case SMU_UCLK:
+			min_dpm_level = clk_table->NumMemPstatesEnabled - 1;
+			break;
+		case SMU_FCLK:
+			min_dpm_level = 0;
+			break;
+		case SMU_SOCCLK:
+			min_dpm_level = 0;
+			break;
+		case SMU_VCLK:
+		case SMU_DCLK:
+			min_dpm_level = 0;
+			break;
+		default:
+			ret = -EINVAL;
+			goto failed;
+		}
+
+		if (clk_type != SMU_GFXCLK && clk_type != SMU_SCLK) {
+			ret = smu_v15_0_common_get_dpm_freq_by_index(smu, clk_type, min_dpm_level, min);
+			if (ret)
+				goto failed;
+		}
+	}
+
+failed:
+	return ret;
+}
+
+static int smu_v15_0_common_get_dpm_ultimate_freq(struct smu_context *smu,
+							enum smu_clk_type clk_type,
+							uint32_t *min,
+							uint32_t *max)
+{
+	if (clk_type != SMU_VCLK1 && clk_type != SMU_DCLK1)
+		smu_v15_0_0_get_dpm_ultimate_freq(smu, clk_type, min, max);
+
+	return 0;
+}
+
+static int smu_v15_0_0_get_current_clk_freq(struct smu_context *smu,
+					    enum smu_clk_type clk_type,
+					    uint32_t *value)
+{
+	MetricsMember_t member_type;
+
+	switch (clk_type) {
+	case SMU_SOCCLK:
+		member_type = METRICS_AVERAGE_SOCCLK;
+		break;
+	case SMU_VCLK:
+		member_type = METRICS_AVERAGE_VCLK;
+		break;
+	case SMU_VCLK1:
+		member_type = METRICS_AVERAGE_VCLK1;
+		break;
+	case SMU_DCLK:
+		member_type = METRICS_AVERAGE_DCLK;
+		break;
+	case SMU_DCLK1:
+		member_type = METRICS_AVERAGE_DCLK1;
+		break;
+	case SMU_MCLK:
+		member_type = METRICS_AVERAGE_UCLK;
+		break;
+	case SMU_FCLK:
+		member_type = METRICS_AVERAGE_FCLK;
+		break;
+	case SMU_GFXCLK:
+	case SMU_SCLK:
+		member_type = METRICS_AVERAGE_GFXCLK;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return smu_v15_0_0_get_smu_metrics_data(smu, member_type, value);
+}
+
+static int smu_v15_0_0_get_dpm_level_count(struct smu_context *smu,
+					   enum smu_clk_type clk_type,
+					   uint32_t *count)
+{
+	DpmClocks_t *clk_table = smu->smu_table.clocks_table;
+
+	switch (clk_type) {
+	case SMU_SOCCLK:
+		*count = clk_table->NumSocClkLevelsEnabled;
+		break;
+	case SMU_VCLK:
+		*count = clk_table->VcnClkLevelsEnabled;
+		break;
+	case SMU_DCLK:
+		*count = clk_table->VcnClkLevelsEnabled;
+		break;
+	case SMU_MCLK:
+		*count = clk_table->NumMemPstatesEnabled;
+		break;
+	case SMU_FCLK:
+		*count = clk_table->NumFclkLevelsEnabled;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int smu_v15_0_common_get_dpm_level_count(struct smu_context *smu,
+					   enum smu_clk_type clk_type,
+					   uint32_t *count)
+{
+	if (clk_type != SMU_VCLK1 && clk_type != SMU_DCLK1)
+		smu_v15_0_0_get_dpm_level_count(smu, clk_type, count);
+
+	return 0;
+}
+
+static int smu_v15_0_0_print_clk_levels(struct smu_context *smu,
+					enum smu_clk_type clk_type, char *buf)
+{
+	int i, idx, ret = 0, size = 0;
+	uint32_t cur_value = 0, value = 0, count = 0;
+	uint32_t min, max;
+
+	smu_cmn_get_sysfs_buf(&buf, &size);
+
+	switch (clk_type) {
+	case SMU_OD_SCLK:
+		size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
+		size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
+		(smu->gfx_actual_hard_min_freq > 0) ? smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq);
+		size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
+		(smu->gfx_actual_soft_max_freq > 0) ? smu->gfx_actual_soft_max_freq : smu->gfx_default_soft_max_freq);
+		break;
+	case SMU_OD_RANGE:
+		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		size += sysfs_emit_at(buf, size, "SCLK: %7uMhz %10uMhz\n",
+				      smu->gfx_default_hard_min_freq,
+				      smu->gfx_default_soft_max_freq);
+		break;
+	case SMU_SOCCLK:
+	case SMU_VCLK:
+	case SMU_DCLK:
+	case SMU_VCLK1:
+	case SMU_DCLK1:
+	case SMU_MCLK:
+	case SMU_FCLK:
+		ret = smu_v15_0_0_get_current_clk_freq(smu, clk_type, &cur_value);
+		if (ret)
+			break;
+
+		ret = smu_v15_0_common_get_dpm_level_count(smu, clk_type, &count);
+		if (ret)
+			break;
+
+		for (i = 0; i < count; i++) {
+			idx = (clk_type == SMU_MCLK) ? (count - i - 1) : i;
+			ret = smu_v15_0_common_get_dpm_freq_by_index(smu, clk_type, idx, &value);
+			if (ret)
+				break;
+
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, value,
+					      cur_value == value ? "*" : "");
+		}
+		break;
+	case SMU_GFXCLK:
+	case SMU_SCLK:
+		ret = smu_v15_0_0_get_current_clk_freq(smu, clk_type, &cur_value);
+		if (ret)
+			break;
+		min = (smu->gfx_actual_hard_min_freq > 0) ? smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq;
+		max = (smu->gfx_actual_soft_max_freq > 0) ? smu->gfx_actual_soft_max_freq : smu->gfx_default_soft_max_freq;
+		if (cur_value  == max)
+			i = 2;
+		else if (cur_value == min)
+			i = 0;
+		else
+			i = 1;
+		size += sysfs_emit_at(buf, size, "0: %uMhz %s\n", min,
+				      i == 0 ? "*" : "");
+		size += sysfs_emit_at(buf, size, "1: %uMhz %s\n",
+				      i == 1 ? cur_value : 1100, /* UMD PSTATE GFXCLK 1100 */
+				      i == 1 ? "*" : "");
+		size += sysfs_emit_at(buf, size, "2: %uMhz %s\n", max,
+				      i == 2 ? "*" : "");
+		break;
+	default:
+		break;
+	}
+
+	return size;
+}
+
+static int smu_v15_0_0_set_soft_freq_limited_range(struct smu_context *smu,
+						   enum smu_clk_type clk_type,
+						   uint32_t min,
+						   uint32_t max)
+{
+	enum smu_message_type msg_set_min, msg_set_max;
+	int ret = 0;
+
+	if (!smu_v15_0_0_clk_dpm_is_enabled(smu, clk_type))
+		return -EINVAL;
+
+	switch (clk_type) {
+	case SMU_GFXCLK:
+	case SMU_SCLK:
+		msg_set_min = SMU_MSG_SetHardMinGfxClk;
+		msg_set_max = SMU_MSG_SetSoftMaxGfxClk;
+		break;
+	case SMU_FCLK:
+		msg_set_min = SMU_MSG_SetHardMinFclkByFreq;
+		msg_set_max = SMU_MSG_SetSoftMaxFclkByFreq;
+		break;
+	case SMU_SOCCLK:
+		msg_set_min = SMU_MSG_SetHardMinSocclkByFreq;
+		msg_set_max = SMU_MSG_SetSoftMaxSocclkByFreq;
+		break;
+	case SMU_VCLK:
+	case SMU_DCLK:
+		msg_set_min = SMU_MSG_SetHardMinVcn0;
+		msg_set_max = SMU_MSG_SetSoftMaxVcn0;
+		break;
+	case SMU_VCLK1:
+	case SMU_DCLK1:
+		msg_set_min = SMU_MSG_SetHardMinVcn1;
+		msg_set_max = SMU_MSG_SetSoftMaxVcn1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = smu_cmn_send_smc_msg_with_param(smu, msg_set_min, min, NULL);
+	if (ret)
+		return ret;
+
+	return smu_cmn_send_smc_msg_with_param(smu, msg_set_max,
+					       max, NULL);
+}
+
+static int smu_v15_0_0_force_clk_levels(struct smu_context *smu,
+					enum smu_clk_type clk_type,
+					uint32_t mask)
+{
+	uint32_t soft_min_level = 0, soft_max_level = 0;
+	uint32_t min_freq = 0, max_freq = 0;
+	int ret = 0;
+
+	soft_min_level = mask ? (ffs(mask) - 1) : 0;
+	soft_max_level = mask ? (fls(mask) - 1) : 0;
+
+	switch (clk_type) {
+	case SMU_SOCCLK:
+	case SMU_FCLK:
+	case SMU_VCLK:
+	case SMU_DCLK:
+	case SMU_VCLK1:
+	case SMU_DCLK1:
+		ret = smu_v15_0_common_get_dpm_freq_by_index(smu, clk_type, soft_min_level, &min_freq);
+		if (ret)
+			break;
+
+		ret = smu_v15_0_common_get_dpm_freq_by_index(smu, clk_type, soft_max_level, &max_freq);
+		if (ret)
+			break;
+
+		ret = smu_v15_0_0_set_soft_freq_limited_range(smu, clk_type, min_freq, max_freq);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int smu_v15_0_common_get_dpm_profile_freq(struct smu_context *smu,
+					enum amd_dpm_forced_level level,
+					enum smu_clk_type clk_type,
+					uint32_t *min_clk,
+					uint32_t *max_clk)
+{
+	uint32_t clk_limit = 0;
+	int ret = 0;
+
+	switch (clk_type) {
+	case SMU_GFXCLK:
+	case SMU_SCLK:
+			clk_limit = SMU_15_0_UMD_PSTATE_GFXCLK;
+		if (level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
+			smu_v15_0_common_get_dpm_ultimate_freq(smu, SMU_SCLK, NULL, &clk_limit);
+		else if (level == AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK)
+			smu_v15_0_common_get_dpm_ultimate_freq(smu, SMU_SCLK, &clk_limit, NULL);
+		break;
+	case SMU_SOCCLK:
+			clk_limit = SMU_15_0_UMD_PSTATE_SOCCLK;
+		if (level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
+			smu_v15_0_common_get_dpm_ultimate_freq(smu, SMU_SOCCLK, NULL, &clk_limit);
+		break;
+	case SMU_FCLK:
+		if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(15, 0, 0))
+			smu_v15_0_common_get_dpm_ultimate_freq(smu, SMU_FCLK, NULL, &clk_limit);
+		else
+			clk_limit = SMU_15_0_UMD_PSTATE_FCLK;
+		if (level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
+			smu_v15_0_common_get_dpm_ultimate_freq(smu, SMU_FCLK, NULL, &clk_limit);
+		else if (level == AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK)
+			smu_v15_0_common_get_dpm_ultimate_freq(smu, SMU_FCLK, &clk_limit, NULL);
+		break;
+	case SMU_VCLK:
+		smu_v15_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK, NULL, &clk_limit);
+		break;
+	case SMU_VCLK1:
+		smu_v15_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK1, NULL, &clk_limit);
+		break;
+	case SMU_DCLK:
+		smu_v15_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK, NULL, &clk_limit);
+		break;
+	case SMU_DCLK1:
+		smu_v15_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK1, NULL, &clk_limit);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	*min_clk = *max_clk = clk_limit;
+	return ret;
+}
+
+static int smu_v15_0_common_set_performance_level(struct smu_context *smu,
+					     enum amd_dpm_forced_level level)
+{
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t sclk_min = 0, sclk_max = 0;
+	uint32_t fclk_min = 0, fclk_max = 0;
+	uint32_t socclk_min = 0, socclk_max = 0;
+	uint32_t vclk_min = 0, vclk_max = 0;
+	uint32_t dclk_min = 0, dclk_max = 0;
+	uint32_t vclk1_min = 0, vclk1_max = 0;
+	uint32_t dclk1_min = 0, dclk1_max = 0;
+	int ret = 0;
+
+	switch (level) {
+	case AMD_DPM_FORCED_LEVEL_HIGH:
+		smu_v15_0_common_get_dpm_ultimate_freq(smu, SMU_SCLK, NULL, &sclk_max);
+		smu_v15_0_common_get_dpm_ultimate_freq(smu, SMU_FCLK, NULL, &fclk_max);
+		smu_v15_0_common_get_dpm_ultimate_freq(smu, SMU_SOCCLK, NULL, &socclk_max);
+		smu_v15_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK, NULL, &vclk_max);
+		smu_v15_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK, NULL, &dclk_max);
+		smu_v15_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK1, NULL, &vclk1_max);
+		smu_v15_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK1, NULL, &dclk1_max);
+		sclk_min = sclk_max;
+		fclk_min = fclk_max;
+		socclk_min = socclk_max;
+		vclk_min = vclk_max;
+		dclk_min = dclk_max;
+		vclk1_min = vclk1_max;
+		dclk1_min = dclk1_max;
+		break;
+	case AMD_DPM_FORCED_LEVEL_LOW:
+		smu_v15_0_common_get_dpm_ultimate_freq(smu, SMU_SCLK, &sclk_min, NULL);
+		smu_v15_0_common_get_dpm_ultimate_freq(smu, SMU_FCLK, &fclk_min, NULL);
+		smu_v15_0_common_get_dpm_ultimate_freq(smu, SMU_SOCCLK, &socclk_min, NULL);
+		smu_v15_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK, &vclk_min, NULL);
+		smu_v15_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK, &dclk_min, NULL);
+		smu_v15_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK1, &vclk1_min, NULL);
+		smu_v15_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK1, &dclk1_min, NULL);
+		sclk_max = sclk_min;
+		fclk_max = fclk_min;
+		socclk_max = socclk_min;
+		vclk_max = vclk_min;
+		dclk_max = dclk_min;
+		vclk1_max = vclk1_min;
+		dclk1_max = dclk1_min;
+		break;
+	case AMD_DPM_FORCED_LEVEL_AUTO:
+		smu_v15_0_common_get_dpm_ultimate_freq(smu, SMU_SCLK, &sclk_min, &sclk_max);
+		smu_v15_0_common_get_dpm_ultimate_freq(smu, SMU_FCLK, &fclk_min, &fclk_max);
+		smu_v15_0_common_get_dpm_ultimate_freq(smu, SMU_SOCCLK, &socclk_min, &socclk_max);
+		smu_v15_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK, &vclk_min, &vclk_max);
+		smu_v15_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK, &dclk_min, &dclk_max);
+		smu_v15_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK1, &vclk1_min, &vclk1_max);
+		smu_v15_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK1, &dclk1_min, &dclk1_max);
+		break;
+	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
+	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
+	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
+	case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
+		smu_v15_0_common_get_dpm_profile_freq(smu, level, SMU_SCLK, &sclk_min, &sclk_max);
+		smu_v15_0_common_get_dpm_profile_freq(smu, level, SMU_FCLK, &fclk_min, &fclk_max);
+		smu_v15_0_common_get_dpm_profile_freq(smu, level, SMU_SOCCLK, &socclk_min, &socclk_max);
+		smu_v15_0_common_get_dpm_profile_freq(smu, level, SMU_VCLK, &vclk_min, &vclk_max);
+		smu_v15_0_common_get_dpm_profile_freq(smu, level, SMU_DCLK, &dclk_min, &dclk_max);
+		smu_v15_0_common_get_dpm_profile_freq(smu, level, SMU_VCLK1, &vclk1_min, &vclk1_max);
+		smu_v15_0_common_get_dpm_profile_freq(smu, level, SMU_DCLK1, &dclk1_min, &dclk1_max);
+		break;
+	case AMD_DPM_FORCED_LEVEL_MANUAL:
+	case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
+		return 0;
+	default:
+		dev_err(adev->dev, "Invalid performance level %d\n", level);
+		return -EINVAL;
+	}
+
+	if (sclk_min && sclk_max) {
+		ret = smu_v15_0_0_set_soft_freq_limited_range(smu,
+							      SMU_SCLK,
+							      sclk_min,
+							      sclk_max);
+		if (ret)
+			return ret;
+
+		smu->gfx_actual_hard_min_freq = sclk_min;
+		smu->gfx_actual_soft_max_freq = sclk_max;
+	}
+
+	if (fclk_min && fclk_max) {
+		ret = smu_v15_0_0_set_soft_freq_limited_range(smu,
+							      SMU_FCLK,
+							      fclk_min,
+							      fclk_max);
+		if (ret)
+			return ret;
+	}
+
+	if (socclk_min && socclk_max) {
+		ret = smu_v15_0_0_set_soft_freq_limited_range(smu,
+							      SMU_SOCCLK,
+							      socclk_min,
+							      socclk_max);
+		if (ret)
+			return ret;
+	}
+
+	if (vclk_min && vclk_max) {
+		ret = smu_v15_0_0_set_soft_freq_limited_range(smu,
+							      SMU_VCLK,
+							      vclk_min,
+							      vclk_max);
+		if (ret)
+			return ret;
+	}
+
+	if (vclk1_min && vclk1_max) {
+		ret = smu_v15_0_0_set_soft_freq_limited_range(smu,
+							      SMU_VCLK1,
+							      vclk1_min,
+							      vclk1_max);
+		if (ret)
+			return ret;
+	}
+
+	if (dclk_min && dclk_max) {
+		ret = smu_v15_0_0_set_soft_freq_limited_range(smu,
+							      SMU_DCLK,
+							      dclk_min,
+							      dclk_max);
+		if (ret)
+			return ret;
+	}
+
+	if (dclk1_min && dclk1_max) {
+		ret = smu_v15_0_0_set_soft_freq_limited_range(smu,
+							      SMU_DCLK1,
+							      dclk1_min,
+							      dclk1_max);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
+static int smu_v15_0_0_set_fine_grain_gfx_freq_parameters(struct smu_context *smu)
+{
+	DpmClocks_t *clk_table = smu->smu_table.clocks_table;
+
+	smu->gfx_default_hard_min_freq = clk_table->MinGfxClk;
+	smu->gfx_default_soft_max_freq = clk_table->MaxGfxClk;
+	smu->gfx_actual_hard_min_freq = 0;
+	smu->gfx_actual_soft_max_freq = 0;
+
+	return 0;
+}
+
+static int smu_v15_0_common_set_fine_grain_gfx_freq_parameters(struct smu_context *smu)
+{
+	smu_v15_0_0_set_fine_grain_gfx_freq_parameters(smu);
+
+	return 0;
+}
+
+static int smu_v15_0_0_set_vpe_enable(struct smu_context *smu,
+				      bool enable)
+{
+	return smu_cmn_send_smc_msg_with_param(smu, enable ?
+					       SMU_MSG_PowerUpVpe : SMU_MSG_PowerDownVpe,
+					       0, NULL);
+}
+
+static int smu_v15_0_0_set_umsch_mm_enable(struct smu_context *smu,
+			      bool enable)
+{
+	return smu_cmn_send_smc_msg_with_param(smu, enable ?
+					       SMU_MSG_PowerUpUmsch : SMU_MSG_PowerDownUmsch,
+					       0, NULL);
+}
+
+static int smu_v15_0_0_get_dpm_table(struct smu_context *smu, struct dpm_clocks *clock_table)
+{
+	DpmClocks_t *clk_table = smu->smu_table.clocks_table;
+	uint8_t idx;
+
+	/* Only the Clock information of SOC and VPE is copied to provide VPE DPM settings for use. */
+	for (idx = 0; idx < NUM_SOCCLK_DPM_LEVELS; idx++) {
+		clock_table->SocClocks[idx].Freq = (idx < clk_table->NumSocClkLevelsEnabled) ? clk_table->SocClocks[idx]:0;
+		clock_table->SocClocks[idx].Vol = 0;
+	}
+
+	for (idx = 0; idx < NUM_VPE_DPM_LEVELS; idx++) {
+		clock_table->VPEClocks[idx].Freq = (idx < clk_table->VpeClkLevelsEnabled) ? clk_table->VPEClocks[idx]:0;
+		clock_table->VPEClocks[idx].Vol = 0;
+	}
+
+	return 0;
+}
+
+static int smu_v15_0_common_get_dpm_table(struct smu_context *smu, struct dpm_clocks *clock_table)
+{
+	smu_v15_0_0_get_dpm_table(smu, clock_table);
+
+	return 0;
+}
+
+static const struct pptable_funcs smu_v15_0_0_ppt_funcs = {
+	.check_fw_status = smu_v15_0_check_fw_status,
+	.check_fw_version = smu_v15_0_check_fw_version,
+	.init_smc_tables = smu_v15_0_0_init_smc_tables,
+	.fini_smc_tables = smu_v15_0_0_fini_smc_tables,
+	.get_vbios_bootup_values = smu_v15_0_get_vbios_bootup_values,
+	.system_features_control = smu_v15_0_0_system_features_control,
+	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
+	.send_smc_msg = smu_cmn_send_smc_msg,
+	.dpm_set_vcn_enable = smu_v15_0_set_vcn_enable,
+	.dpm_set_jpeg_enable = smu_v15_0_set_jpeg_enable,
+	.set_default_dpm_table = smu_v15_0_set_default_dpm_tables,
+	.read_sensor = smu_v15_0_0_read_sensor,
+	.is_dpm_running = smu_v15_0_0_is_dpm_running,
+	.set_watermarks_table = smu_v15_0_0_set_watermarks_table,
+	.get_gpu_metrics = smu_v15_0_0_get_gpu_metrics,
+	.get_enabled_mask = smu_cmn_get_enabled_mask,
+	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
+	.set_driver_table_location = smu_v15_0_set_driver_table_location,
+	.gfx_off_control = smu_v15_0_gfx_off_control,
+	.mode2_reset = smu_v15_0_0_mode2_reset,
+	.get_dpm_ultimate_freq = smu_v15_0_common_get_dpm_ultimate_freq,
+	.od_edit_dpm_table = smu_v15_0_od_edit_dpm_table,
+	.print_clk_levels = smu_v15_0_0_print_clk_levels,
+	.force_clk_levels = smu_v15_0_0_force_clk_levels,
+	.set_performance_level = smu_v15_0_common_set_performance_level,
+	.set_fine_grain_gfx_freq_parameters = smu_v15_0_common_set_fine_grain_gfx_freq_parameters,
+	.set_gfx_power_up_by_imu = smu_v15_0_set_gfx_power_up_by_imu,
+	.dpm_set_vpe_enable = smu_v15_0_0_set_vpe_enable,
+	.dpm_set_umsch_mm_enable = smu_v15_0_0_set_umsch_mm_enable,
+	.get_dpm_clock_table = smu_v15_0_common_get_dpm_table,
+};
+
+static void smu_v15_0_0_set_smu_mailbox_registers(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	smu->param_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_32);
+	smu->msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_30);
+	smu->resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_31);
+}
+
+void smu_v15_0_0_set_ppt_funcs(struct smu_context *smu)
+{
+
+	smu->ppt_funcs = &smu_v15_0_0_ppt_funcs;
+	smu->message_map = smu_v15_0_0_message_map;
+	smu->feature_map = smu_v15_0_0_feature_mask_map;
+	smu->table_map = smu_v15_0_0_table_map;
+	smu->is_apu = true;
+
+	smu_v15_0_0_set_smu_mailbox_registers(smu);
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h
new file mode 100644
index 0000000000000..8365b9fea77ea
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h
@@ -0,0 +1,28 @@
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+#ifndef __SMU_V15_0_0_PPT_H__
+#define __SMU_V15_0_0_PPT_H__
+
+extern void smu_v15_0_0_set_ppt_funcs(struct smu_context *smu);
+
+#endif
\ No newline at end of file
-- 
2.52.0

