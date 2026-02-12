Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ACE7E9E31B
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Feb 2026 01:10:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D24C910E1F3;
	Thu, 12 Feb 2026 01:10:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bdjIoGf/";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010052.outbound.protection.outlook.com [52.101.201.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D956710E1F3
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Feb 2026 01:10:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ryAkshTkUyUPgzf052+RFz0SBPuFuHY5EFL7tFMAhLvJSmEY6axb7rGJaSeHQceekpnnzon93xiBUSchzz1d5aJgOAXo1rhicEXAI31nezq3d+JCoiqTXAXUbjh/UQaE95z5ANIwg31EXeQ2XSE462KPZBBFlipWGQAXHjcJ3yMxuyHUgXQ3y80y2r0ZCO6Zh223P68ceyXozl2xyBmet9wLmiocSDkHfKqGG0roLMqOx6v6OekHKsu8vX+szN9uqsrpaP9w/jmjhq2H6XlNSR9dZ8ALKROLOhNRZkrdf19+lZUXr0/ECDZRLohZJLMSxyUDLBfEPi+hZmARv3JR0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1O1x6v4NMOwdtBs7MlOiSxyCrPL4n0LEa7OgZIJb8bo=;
 b=ReXT99LULtA2jfNucpS4MxA8tuWXnTVnTWOn8bYZr+hjkqFjCALySQCSkNueVKhb+MapW5+liYSrivKLhAKNBxv+ipPho8cpURQMfS6SAp/QnAamjuC6Np2ZBQUpsuRFy9Zv4dIrQrIUnHWa8AyGWAsqy1x7Nr21dKyz9MQ/8M2hWMHUtm7mYvawaFhq2NkriIhzlBSibYBKhGfet/s/0I68z0PC1jLbijnzTF6qk3+MeMZ+epqEo+IULh+a00pQmBhrY8mVBITWlxUn6+OjnSXciddLQzzVmavtseKPvgQjmriX/5nxUbByfIAzKGETFxtZqPLqSrwfFNysZfGNKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1O1x6v4NMOwdtBs7MlOiSxyCrPL4n0LEa7OgZIJb8bo=;
 b=bdjIoGf/XMOdH2IU9wD4GKbi4nRCNdS/zdVkYKOq2ybuf+224rPrkfvhXdhHP7i8bOzYHtrgOHvlv4vOHzO4xBD8FXtwU4qvrYk7shO5vctrrkOx1MrZd0QG7g6fskyf9qywycIODz6HXk7sdwY9VVfmsXypxxXU0M9C2uUFT4Y=
Received: from DM5PR07CA0108.namprd07.prod.outlook.com (2603:10b6:4:ae::37) by
 SA3PR12MB7808.namprd12.prod.outlook.com (2603:10b6:806:31b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 01:10:03 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:4:ae:cafe::e5) by DM5PR07CA0108.outlook.office365.com
 (2603:10b6:4:ae::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.10 via Frontend Transport; Thu,
 12 Feb 2026 01:10:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.0 via Frontend Transport; Thu, 12 Feb 2026 01:10:03 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Feb
 2026 19:10:01 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 11 Feb 2026 19:10:00 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>, Roman Li
 <Roman.Li@amd.com>
Subject: [PATCH 5/7] drm/amd/display: Enable dcn42 DMUB
Date: Wed, 11 Feb 2026 20:09:47 -0500
Message-ID: <20260212010949.654686-6-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260212010949.654686-1-Roman.Li@amd.com>
References: <20260212010949.654686-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|SA3PR12MB7808:EE_
X-MS-Office365-Filtering-Correlation-Id: 4529a26e-435c-4bc3-7f0e-08de69d373c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Acw41u6W7OswpvvdC7d2nhPA3x0/cZqQsq9FpKtxUe2VdbwcodE+9H4gs4Vi?=
 =?us-ascii?Q?YlnKKl9Q25uDgMkyPyuKTJ1vdsrlB83RkH3pF/zheZhlBj/2EcJtumCMVx5v?=
 =?us-ascii?Q?EF2LACk0gp31X/2WrYiksWvUZiTD6p9DLYfbFx4SxE4MoGFX1DXPOllM792P?=
 =?us-ascii?Q?cdD5I9OC7aRDxludlxUmej9g/SHiGrq/RSsxOOWD3y4OBS9gz4+ATiTaoZCu?=
 =?us-ascii?Q?nmJ7Yomh05w9N6osgexgZLDCh9HXWBaU45jjZnL//XTZ9D/bFKZ8gXUDC20R?=
 =?us-ascii?Q?hYa0xUjI/L6i0ZCv89ANwn34r2cwj+RVR8v2wPa3sxFwrqgo0q5VRKUg4NhF?=
 =?us-ascii?Q?If49eUaDcFYOo3SmWwRUA2FDypHWmOSz1ZnUjHpty5BI+5tR0XhutDmyVMRn?=
 =?us-ascii?Q?bCpc3pVBEvm86VjICL2PpaTlDW9YGAziwmJRgOF+45vNpMZmMS0OOwFhwXz/?=
 =?us-ascii?Q?t7k2LueSwAHygRuvvO3gBVZesJfIAJxS6mMlR3cSTOToWdA77+YxoJQnF8d7?=
 =?us-ascii?Q?IrLMzJmbpW8H8OUZjqjY8IpkOoRb2o043NdIDYByKT5V5r5ZfexZaiH/7SIM?=
 =?us-ascii?Q?3Mw1S7KsNSSYXBIWa/Yka6x8arHdSAt4MVB1pdYY1VJYa5mvoVO4x9/NpIhf?=
 =?us-ascii?Q?mfmRARGCy+WFF+uHKd5uusEAuhiYmwtGXR0Z8K1My33Yk7kBLYeOqfnjnSFW?=
 =?us-ascii?Q?vltUXdDIKmqXRpbhAC9OinF4TMDflirRWTH2R4Bm3ulvuN2GnpZVN2lqihax?=
 =?us-ascii?Q?wR/vxEbIkTF5FumRQJ51qVk+lPfY87O2ioMDx/HiI7yg8po2NtSMMtPh6NGX?=
 =?us-ascii?Q?ElpTkckoBnrqVZXy3rc33XKWB+s7UtMQ6IwTl42J7wwzqO9FoSDNu4kQ0SCR?=
 =?us-ascii?Q?cHDgJo3tMzCgtnAcJhPWwxjHn8HDGPeLNj1xXX2D1FgmFtwpe6AZZ4Ayrizi?=
 =?us-ascii?Q?iY5S6uvUZm0AIPs39ogjAINEDR+zG5CYT3sjY3HiP0/aJUtCvQZo09hmfDPb?=
 =?us-ascii?Q?T/mMidZ9j+u6UhiSc8ZiiGC0tUAdcAcfXn3ykNViINdCZE66F3/xHAJe5sKh?=
 =?us-ascii?Q?xBoqpi4GrZka9pdfK/ZwIdIIskvOgdHuqHV+dHtfBHIV4Qi0rQuydvnRYzGt?=
 =?us-ascii?Q?E8MSn4KyxOHy9f+SERAE9ipzgsEoLiY2b7q97ZtRskIKi5Vil0vxLQKHMyOW?=
 =?us-ascii?Q?mMItLJWG7O3T947JYCFT8Dwnz4AsYYzoRy8jhR22JKXejvXs6+TR9XPUS21o?=
 =?us-ascii?Q?4wkRkvqQrVcxcTf7Y3roI+iqbDpjwWhX33SGdBH7d06e0sFxMuia/ktLr8L9?=
 =?us-ascii?Q?6kwcq9BzIcsLQcWrRYiul+GvIZxZac1cv/3ltIsj0Wgxhuo0lbzBopefRnWt?=
 =?us-ascii?Q?mSMomDzEcmWMhrdayt8B76pjY1vD2bgHlr5CPS+aIVGBqBcYXycoZzKKKk0C?=
 =?us-ascii?Q?5KfbtniPMAFRu7le5qIcW5JkdUvXvfw8/5+HIs+nQywang2WG+oLBrVeMAlm?=
 =?us-ascii?Q?9qX6P51CGStVgZZVUpQI/xORn+i01V0J/OLhBifT7cm51tDAaXkisBCM5sit?=
 =?us-ascii?Q?eJ9X7iHSZmTmO+pHJqmmQifOJVWHdxezYTweg//n4/0GzKWuEQV8wYOrs0xV?=
 =?us-ascii?Q?5wZZId+Vdg/fLHYXijzhOQTvLEd2+wozOBma7gbyFovHVzDRw4c7gYR8O+Nj?=
 =?us-ascii?Q?/TI2MA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dtnDTt/zB2Odof4ybn1N7RaG7uRZcYJGh/HSAX/iT6+EC0p87uO3uwwuNsnR37aZO0ftKH1UwqAcYZpvS10zcg2s76NvAyA5szyCCqevO6VjL6Q1lk73Hvj9i+vRo0OR6yEPiylnOkvAaesqKMDrAcX2iAgFBARcwKbfIm7zWtpkPE8GUYZIbV74phr08hVfvu4Mhg2rirCIR2bOt6hfN9ou0Uj+wCZbZbvjKa62CKSkkukte7MJtD/fQOAGt1EE1sO9OKD6gwepM/U0ncECe7jag8Vm7H+rR8TVpYXchQLn3pCyXnQz1vfX/MU7+I4fZaRYoXslFYQtMZBpOhyb9wwFNFUtJ3MDz5ipAmJx2lfg2DRsu8SIo7Q31lhPIi6NP95yUNIepLl569pyKLW1GqDQ1Ysfft8Y6y7hpWCKZ/vHrlb1ul1koe/gIeIqxGdw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 01:10:03.4011 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4529a26e-435c-4bc3-7f0e-08de69d373c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7808
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

From: Roman Li <Roman.Li@amd.com>

Enable DMUB support for DCN 4.2

Signed-off-by: Roman Li <Roman.Li@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  5 +-
 drivers/gpu/drm/amd/display/dmub/src/Makefile |  3 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 64 ++++++++++++++++++-
 3 files changed, 68 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 3b6bba017040..c18ff8f00bb8 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -1,5 +1,6 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * Copyright 2019 Advanced Micro Devices, Inc.
+ * Copyright 2019-2026 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
@@ -119,6 +120,7 @@ enum dmub_asic {
 	DMUB_ASIC_DCN351,
 	DMUB_ASIC_DCN36,
 	DMUB_ASIC_DCN401,
+	DMUB_ASIC_DCN42,
 	DMUB_ASIC_MAX,
 };
 
@@ -602,6 +604,7 @@ struct dmub_srv {
 	struct dmub_srv_dcn32_regs *regs_dcn32;
 	struct dmub_srv_dcn35_regs *regs_dcn35;
 	const struct dmub_srv_dcn401_regs *regs_dcn401;
+	struct dmub_srv_dcn42_regs *regs_dcn42;
 	struct dmub_srv_base_funcs funcs;
 	struct dmub_srv_hw_funcs hw_funcs;
 	struct dmub_srv_inbox inbox1;
diff --git a/drivers/gpu/drm/amd/display/dmub/src/Makefile b/drivers/gpu/drm/amd/display/dmub/src/Makefile
index 468b768c11ae..ac7b17d8fb0f 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/Makefile
+++ b/drivers/gpu/drm/amd/display/dmub/src/Makefile
@@ -1,5 +1,5 @@
 #
-# Copyright 2019 Advanced Micro Devices, Inc.
+# Copyright 2019-2026 Advanced Micro Devices, Inc.
 #
 # Permission is hereby granted, free of charge, to any person obtaining a
 # copy of this software and associated documentation files (the "Software"),
@@ -28,6 +28,7 @@ DMUB += dmub_dcn35.o
 DMUB += dmub_dcn351.o
 DMUB += dmub_dcn36.o
 DMUB += dmub_dcn401.o
+DMUB += dmub_dcn42.o
 
 AMD_DAL_DMUB = $(addprefix $(AMDDALPATH)/dmub/src/,$(DMUB))
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 83cf4888fb54..3bba256a288d 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -1,5 +1,6 @@
+// SPDX-License-Identifier: MIT
 /*
- * Copyright 2019 Advanced Micro Devices, Inc.
+ * Copyright 2019-2026 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
@@ -22,7 +23,6 @@
  * Authors: AMD
  *
  */
-
 #include "../dmub_srv.h"
 #include "dmub_dcn20.h"
 #include "dmub_dcn21.h"
@@ -40,6 +40,7 @@
 #include "dmub_dcn351.h"
 #include "dmub_dcn36.h"
 #include "dmub_dcn401.h"
+#include "dmub_dcn42.h"
 #include "os_types.h"
 /*
  * Note: the DMUB service is standalone. No additional headers should be
@@ -87,6 +88,7 @@
 
 static struct dmub_srv_dcn32_regs dmub_srv_dcn32_regs;
 static struct dmub_srv_dcn35_regs dmub_srv_dcn35_regs;
+struct dmub_srv_dcn42_regs dmub_srv_dcn42_regs;
 
 static inline uint32_t dmub_align(uint32_t val, uint32_t factor)
 {
@@ -410,6 +412,64 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 			funcs->is_hw_powered_up = dmub_dcn35_is_hw_powered_up;
 			funcs->should_detect = dmub_dcn35_should_detect;
 			break;
+	case DMUB_ASIC_DCN42:
+			dmub->regs_dcn42 = &dmub_srv_dcn42_regs;
+			funcs->configure_dmub_in_system_memory = dmub_dcn42_configure_dmub_in_system_memory;
+			funcs->send_inbox0_cmd = dmub_dcn42_send_inbox0_cmd;
+			funcs->clear_inbox0_ack_register = dmub_dcn42_clear_inbox0_ack_register;
+			funcs->read_inbox0_ack_register = dmub_dcn42_read_inbox0_ack_register;
+			funcs->reset = dmub_dcn42_reset;
+			funcs->reset_release = dmub_dcn42_reset_release;
+			funcs->backdoor_load = dmub_dcn42_backdoor_load;
+			funcs->backdoor_load_zfb_mode = dmub_dcn42_backdoor_load_zfb_mode;
+			funcs->setup_windows = dmub_dcn42_setup_windows;
+			funcs->setup_mailbox = dmub_dcn42_setup_mailbox;
+			funcs->get_inbox1_wptr = dmub_dcn42_get_inbox1_wptr;
+			funcs->get_inbox1_rptr = dmub_dcn42_get_inbox1_rptr;
+			funcs->set_inbox1_wptr = dmub_dcn42_set_inbox1_wptr;
+			funcs->setup_out_mailbox = dmub_dcn42_setup_out_mailbox;
+			funcs->get_outbox1_wptr = dmub_dcn42_get_outbox1_wptr;
+			funcs->set_outbox1_rptr = dmub_dcn42_set_outbox1_rptr;
+			funcs->is_supported = dmub_dcn42_is_supported;
+			funcs->is_hw_init = dmub_dcn42_is_hw_init;
+			funcs->set_gpint = dmub_dcn42_set_gpint;
+			funcs->is_gpint_acked = dmub_dcn42_is_gpint_acked;
+			funcs->get_gpint_response = dmub_dcn42_get_gpint_response;
+			funcs->get_gpint_dataout = dmub_dcn42_get_gpint_dataout;
+			funcs->get_fw_status = dmub_dcn42_get_fw_boot_status;
+			funcs->get_fw_boot_option = dmub_dcn42_get_fw_boot_option;
+			funcs->enable_dmub_boot_options = dmub_dcn42_enable_dmub_boot_options;
+			funcs->skip_dmub_panel_power_sequence = dmub_dcn42_skip_dmub_panel_power_sequence;
+			/*outbox0 call stacks*/
+			funcs->setup_outbox0 = dmub_dcn42_setup_outbox0;
+			funcs->get_outbox0_wptr = dmub_dcn42_get_outbox0_wptr;
+			funcs->set_outbox0_rptr = dmub_dcn42_set_outbox0_rptr;
+
+			funcs->get_current_time = dmub_dcn42_get_current_time;
+			funcs->get_diagnostic_data = dmub_dcn42_get_diagnostic_data;
+			funcs->get_preos_fw_info = dmub_dcn42_get_preos_fw_info;
+
+			/*carried from dcn401*/
+			funcs->send_reg_inbox0_cmd_msg = dmub_dcn42_send_reg_inbox0_cmd_msg;
+			funcs->read_reg_inbox0_rsp_int_status = dmub_dcn42_read_reg_inbox0_rsp_int_status;
+			funcs->read_reg_inbox0_cmd_rsp = dmub_dcn42_read_reg_inbox0_cmd_rsp;
+			funcs->write_reg_inbox0_rsp_int_ack = dmub_dcn42_write_reg_inbox0_rsp_int_ack;
+			funcs->clear_reg_inbox0_rsp_int_ack = dmub_dcn42_clear_reg_inbox0_rsp_int_ack;
+			funcs->enable_reg_inbox0_rsp_int = dmub_dcn42_enable_reg_inbox0_rsp_int;
+			default_inbox_type = DMUB_CMD_INTERFACE_FB; /*still default to FB for now*/
+
+			funcs->write_reg_outbox0_rdy_int_ack = dmub_dcn42_write_reg_outbox0_rdy_int_ack;
+			funcs->read_reg_outbox0_msg = dmub_dcn42_read_reg_outbox0_msg;
+			funcs->write_reg_outbox0_rsp = dmub_dcn42_write_reg_outbox0_rsp;
+			funcs->read_reg_outbox0_rdy_int_status = dmub_dcn42_read_reg_outbox0_rdy_int_status;
+			funcs->read_reg_outbox0_rsp_int_status = dmub_dcn42_read_reg_outbox0_rsp_int_status;
+			funcs->enable_reg_inbox0_rsp_int = dmub_dcn42_enable_reg_inbox0_rsp_int;
+			funcs->enable_reg_outbox0_rdy_int = dmub_dcn42_enable_reg_outbox0_rdy_int;
+			funcs->init_reg_offsets = dmub_srv_dcn42_regs_init;
+
+			funcs->is_hw_powered_up = dmub_dcn42_is_hw_powered_up;
+			funcs->should_detect = dmub_dcn42_should_detect;
+			break;
 
 	case DMUB_ASIC_DCN401:
 		dmub->regs_dcn401 = &dmub_srv_dcn401_regs;
-- 
2.34.1

