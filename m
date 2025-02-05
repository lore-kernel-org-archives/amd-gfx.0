Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C32F9C0219C
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 03:14:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09A9F10E727;
	Wed,  5 Feb 2025 03:13:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kjo7IJyv";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72C1410E12C
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 03:10:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WzzJiAq3X2vElXTRZYgc+gvdSMlwJ6wLe+3XVsbWRQWcNpcxc0/yHWEd2/U52SKCX4Z0245VlmJg/OOVKx0Xkm5vdO5IGt+QaTpEFmuqMgO3VfjQa1+JGquvbpZVEOBKJ5+HplDfzXzwc1wPKCpR9ftgzz5wfPYD8XykNHwSKjrsg7og9KJke5Lsy9rvHg+U9xYzsW//WhutZj0sMKrjKmf9+ksksR/hvAtDywp8OEwtYEQgHXSj4TQ6j8I5YhO+53ih9CPtk9fxyGI+4CufuLUM3Mst9l2iRVZ4PuDed/Y1GtdlhiK+jHVyyjklfnLE7SPWRyvtuNMhHE7dnY0s0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=napOSjqNwnU5lifMNrz+7yaj1ruV/zAC99TYnDRYkcs=;
 b=Ez5/wIanp3yYP1UkzcXbmBPLqII4XpX6hsJ1dxYTolIGRu9qFtoRt4maANCk1jN7PRJRys1JuiowMbwKEklotaTByt3U+wSNSQ4PpjMXUqogKEkS0D3ZxFiNdT6gH+K2Je9A7g/hOX06Pk8+h7LYLFnXyusrxdJEjjTLMsl3XBD/yUf4ZE24newD7aL7mA5yFiax6zH0RskRg6ptKfPxKlJbD3yAos2JRHbUnjRmlwXzn98zuo3iZtQB8juCmEf37uFhhV9stebl0+ong4jIHlqSRxFP55OIxVJXcF62p8xp4KrHBIpeNso7d8TQ3jnmGNFKP7DzgCvaDTjaANqWHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=napOSjqNwnU5lifMNrz+7yaj1ruV/zAC99TYnDRYkcs=;
 b=kjo7IJyvY5ar4bswnm9kr5UtYuH+m1WBmLNL/M/loAtn8imAoISi7sscYxbZpNfv9PSrQuWrS2bDXjcJnJP18xkfwEgVqD6XA4yy7kkLes5DH29wz64hiktXQHs6SmYV6R2C/VeD4QMpn6JTBXN9Oqz1FTczsLoSJ3EiMboQRgE=
Received: from CH2PR20CA0013.namprd20.prod.outlook.com (2603:10b6:610:58::23)
 by DS0PR12MB8562.namprd12.prod.outlook.com (2603:10b6:8:164::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 03:10:42 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::73) by CH2PR20CA0013.outlook.office365.com
 (2603:10b6:610:58::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.26 via Frontend Transport; Wed,
 5 Feb 2025 03:10:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 03:10:41 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Feb
 2025 21:10:40 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 4 Feb 2025 21:10:36 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, Harry Wentland <harry.wentland@amd.com>, "Leo
 Li" <sunpeng.li@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 "Tom Chung" <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>,
 "Zaeem Mohamed" <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, 
 "Wayne Lin" <Wayne.Lin@amd.com>, Martin Leung <martin.leung@amd.com>, Taimur
 Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 04/12] drm/amd/display: Add DCN36 IRQ
Date: Wed, 5 Feb 2025 11:08:49 +0800
Message-ID: <20250205030857.2608094-5-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250205030857.2608094-1-Wayne.Lin@amd.com>
References: <20250205030857.2608094-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|DS0PR12MB8562:EE_
X-MS-Office365-Filtering-Correlation-Id: e7067d8d-e332-4243-d2f5-08dd4592ac85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uXTg6i898YkQacTrpJwB04thHf+qtwxt95k5IFzYus6ySi7VN99lwv0qX3NH?=
 =?us-ascii?Q?lRXHq/51AANH2NSZB4RSUfPUd9SNKu5dgUwlDuP0nSuc428rXbNRUdUPxo9N?=
 =?us-ascii?Q?kT6vRACcTX7VSRXT/noScxq5wTc0AT7irfQVJe0QTNn/1P7bLr/4KRd98DQX?=
 =?us-ascii?Q?5Es63YrsPOzmxGnCLyilduGKKA0jNGhJcicDoykeCTCtJqv6TBommssxAIA7?=
 =?us-ascii?Q?ATj7ciWrnsYVC8y5Ym8Pct6s1uRBxoFR2o26QqsgdoP0ziK6oDZ97aFNbsvD?=
 =?us-ascii?Q?MGQQHJpl3yU2gJIP7iRurRGA1ZTJetU2bHC+Kv9FxMBOKFqOnLkIZQ58fRtR?=
 =?us-ascii?Q?uXPHeDW7ZkzhEozxXNPCqmbqC4hWsq8CnD+VmTshsgFkuO8tUq6SKy5aLWfs?=
 =?us-ascii?Q?B/FEH2eerOu7RffYYNqkLCUnAkBYSuZ8+4S4EgVTVnDbgGKceLlercAnvJjF?=
 =?us-ascii?Q?huMXa1ViUX/hehaXIQfv2uQYEcZYknB6bJDUPEjpIBavii7Tb0ViAYSZgdHB?=
 =?us-ascii?Q?4Vcxq26pU67XvjSu9BbuXH1isXo0xlG9snw5VRIbVUP6w7X2kSeUF9cdWCJN?=
 =?us-ascii?Q?zIYSQ6/STt6sHxCna1aHx68FPZVYtD8+bhmRlXluljWQZVctZ/9CkaZSPdjR?=
 =?us-ascii?Q?UzLSJPKd84EMzfM7a/k/t1kj/tJ5KuHQZckXR9UGAM6Kc0JxGLpombxLUVL2?=
 =?us-ascii?Q?MlgVUZ+0faA8a2LZRZ0f1KNEUqGYFxJm7/pDmLH5K31y2mKpxHl5KMMKU5/u?=
 =?us-ascii?Q?TUYaCdUpk4HAHGyEVEPmaNK/v9IHlM3NHEl0LJ1eifyFdAHU+02/TQyg0lL7?=
 =?us-ascii?Q?9c7yAi/NFPXs2ZP+ws1+lZQW/ETlk82BzbZm6H98fZp8YaAgE4TaN7/r2OZa?=
 =?us-ascii?Q?D3ymthR2uSLTUXqVDoo3+9Ilgteyz7WhHa9qanKp/kWNvudy6xe+l7a8VT6R?=
 =?us-ascii?Q?Kngs7JXM+Gj7nqD/007dNexP4NVyH7kNhvy2VW/NoStBqs/+DFcOp9BRXmFT?=
 =?us-ascii?Q?hPh7dJWfVlZBhurOJPFV+AIsiJg8U+hSfDxEXlKpTmDhbAO3QQQaJprs6tAo?=
 =?us-ascii?Q?97OjzDOaGQZg0CfnyDBJD+nq2ZZYpIpeLM89ccKruHOvsgHBcO15Jo/DpZNl?=
 =?us-ascii?Q?z/biEqC1pgUZt/KD4FFdYcZ08qwg9c+AIp4Tp9m/MzoksAxZuVLEr18EN3LB?=
 =?us-ascii?Q?2n3aViEu700sAr3gmk764m07L25NasxRDr4Ia0c3x3xhWC7y7OoAcFIuED0b?=
 =?us-ascii?Q?7lRWX9ap9UNy/CEfwvIlRMUTOIumOwkVpllUTeweO8U86W+n9OBWZsBDxlT3?=
 =?us-ascii?Q?yUy4raBsdPRDLq62gk+lbulVxufk8Hwd4kDMxCUg3r/HiUWhkx64tsTPCowt?=
 =?us-ascii?Q?y0Db89b4n0kJjgltUAMjP/trftq3P9jar0pDF/cScuhic3ghKJdGu2XvmVN9?=
 =?us-ascii?Q?7D/N9dZ3r0g8bEoo1nVVJJG+6A4qRVJkRwxF5j0hJbaA2n5qskrpDct+s8jm?=
 =?us-ascii?Q?lD86fYFQ7e4xnFc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 03:10:41.7690 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7067d8d-e332-4243-d2f5-08dd4592ac85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8562
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

Add IRQ services for DCN36.
This allows us to create/init and manage irqs for DCN3

V2: adjust copyright license text

Acked-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Martin Leung <martin.leung@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/irq/Makefile   |   9 +
 .../display/dc/irq/dcn36/irq_service_dcn36.c  | 408 ++++++++++++++++++
 .../display/dc/irq/dcn36/irq_service_dcn36.h  |  12 +
 3 files changed, 429 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dcn36/irq_service_dcn36.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dcn36/irq_service_dcn36.h

diff --git a/drivers/gpu/drm/amd/display/dc/irq/Makefile b/drivers/gpu/drm/amd/display/dc/irq/Makefile
index 8ac36bdd4e1e..b5e14d792378 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/irq/Makefile
@@ -181,6 +181,15 @@ AMD_DAL_IRQ_DCN351= $(addprefix $(AMDDALPATH)/dc/irq/dcn351/,$(IRQ_DCN351))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_IRQ_DCN351)
 
+###############################################################################
+# DCN 36
+###############################################################################
+IRQ_DCN36 = irq_service_dcn36.o
+
+AMD_DAL_IRQ_DCN36= $(addprefix $(AMDDALPATH)/dc/irq/dcn36/,$(IRQ_DCN36))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_IRQ_DCN36)
+
 ###############################################################################
 # DCN 401
 ###############################################################################
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn36/irq_service_dcn36.c b/drivers/gpu/drm/amd/display/dc/irq/dcn36/irq_service_dcn36.c
new file mode 100644
index 000000000000..ea958628f8b8
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn36/irq_service_dcn36.c
@@ -0,0 +1,408 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright 2025 Advanced Micro Devices, Inc. */
+
+#include "dm_services.h"
+#include "include/logger_interface.h"
+#include "../dce110/irq_service_dce110.h"
+
+#include "dcn/dcn_3_6_0_offset.h"
+#include "dcn/dcn_3_6_0_sh_mask.h"
+
+#include "irq_service_dcn36.h"
+
+#include "ivsrcid/dcn/irqsrcs_dcn_1_0.h"
+
+static enum dc_irq_source to_dal_irq_source_dcn36(
+		struct irq_service *irq_service,
+		uint32_t src_id,
+		uint32_t ext_id)
+{
+	switch (src_id) {
+	case DCN_1_0__SRCID__DC_D1_OTG_VSTARTUP:
+		return DC_IRQ_SOURCE_VBLANK1;
+	case DCN_1_0__SRCID__DC_D2_OTG_VSTARTUP:
+		return DC_IRQ_SOURCE_VBLANK2;
+	case DCN_1_0__SRCID__DC_D3_OTG_VSTARTUP:
+		return DC_IRQ_SOURCE_VBLANK3;
+	case DCN_1_0__SRCID__DC_D4_OTG_VSTARTUP:
+		return DC_IRQ_SOURCE_VBLANK4;
+	case DCN_1_0__SRCID__DC_D5_OTG_VSTARTUP:
+		return DC_IRQ_SOURCE_VBLANK5;
+	case DCN_1_0__SRCID__DC_D6_OTG_VSTARTUP:
+		return DC_IRQ_SOURCE_VBLANK6;
+	case DCN_1_0__SRCID__OTG1_VERTICAL_INTERRUPT0_CONTROL:
+		return DC_IRQ_SOURCE_DC1_VLINE0;
+	case DCN_1_0__SRCID__OTG2_VERTICAL_INTERRUPT0_CONTROL:
+		return DC_IRQ_SOURCE_DC2_VLINE0;
+	case DCN_1_0__SRCID__OTG3_VERTICAL_INTERRUPT0_CONTROL:
+		return DC_IRQ_SOURCE_DC3_VLINE0;
+	case DCN_1_0__SRCID__OTG4_VERTICAL_INTERRUPT0_CONTROL:
+		return DC_IRQ_SOURCE_DC4_VLINE0;
+	case DCN_1_0__SRCID__OTG5_VERTICAL_INTERRUPT0_CONTROL:
+		return DC_IRQ_SOURCE_DC5_VLINE0;
+	case DCN_1_0__SRCID__OTG6_VERTICAL_INTERRUPT0_CONTROL:
+		return DC_IRQ_SOURCE_DC6_VLINE0;
+	case DCN_1_0__SRCID__HUBP0_FLIP_INTERRUPT:
+		return DC_IRQ_SOURCE_PFLIP1;
+	case DCN_1_0__SRCID__HUBP1_FLIP_INTERRUPT:
+		return DC_IRQ_SOURCE_PFLIP2;
+	case DCN_1_0__SRCID__HUBP2_FLIP_INTERRUPT:
+		return DC_IRQ_SOURCE_PFLIP3;
+	case DCN_1_0__SRCID__HUBP3_FLIP_INTERRUPT:
+		return DC_IRQ_SOURCE_PFLIP4;
+	case DCN_1_0__SRCID__HUBP4_FLIP_INTERRUPT:
+		return DC_IRQ_SOURCE_PFLIP5;
+	case DCN_1_0__SRCID__HUBP5_FLIP_INTERRUPT:
+		return DC_IRQ_SOURCE_PFLIP6;
+	case DCN_1_0__SRCID__OTG0_IHC_V_UPDATE_NO_LOCK_INTERRUPT:
+		return DC_IRQ_SOURCE_VUPDATE1;
+	case DCN_1_0__SRCID__OTG1_IHC_V_UPDATE_NO_LOCK_INTERRUPT:
+		return DC_IRQ_SOURCE_VUPDATE2;
+	case DCN_1_0__SRCID__OTG2_IHC_V_UPDATE_NO_LOCK_INTERRUPT:
+		return DC_IRQ_SOURCE_VUPDATE3;
+	case DCN_1_0__SRCID__OTG3_IHC_V_UPDATE_NO_LOCK_INTERRUPT:
+		return DC_IRQ_SOURCE_VUPDATE4;
+	case DCN_1_0__SRCID__OTG4_IHC_V_UPDATE_NO_LOCK_INTERRUPT:
+		return DC_IRQ_SOURCE_VUPDATE5;
+	case DCN_1_0__SRCID__OTG5_IHC_V_UPDATE_NO_LOCK_INTERRUPT:
+		return DC_IRQ_SOURCE_VUPDATE6;
+	case DCN_1_0__SRCID__DMCUB_OUTBOX_LOW_PRIORITY_READY_INT:
+		return DC_IRQ_SOURCE_DMCUB_OUTBOX;
+	case DCN_1_0__SRCID__DC_HPD1_INT:
+		/* generic src_id for all HPD and HPDRX interrupts */
+		switch (ext_id) {
+		case DCN_1_0__CTXID__DC_HPD1_INT:
+			return DC_IRQ_SOURCE_HPD1;
+		case DCN_1_0__CTXID__DC_HPD2_INT:
+			return DC_IRQ_SOURCE_HPD2;
+		case DCN_1_0__CTXID__DC_HPD3_INT:
+			return DC_IRQ_SOURCE_HPD3;
+		case DCN_1_0__CTXID__DC_HPD4_INT:
+			return DC_IRQ_SOURCE_HPD4;
+		case DCN_1_0__CTXID__DC_HPD5_INT:
+			return DC_IRQ_SOURCE_HPD5;
+		case DCN_1_0__CTXID__DC_HPD6_INT:
+			return DC_IRQ_SOURCE_HPD6;
+		case DCN_1_0__CTXID__DC_HPD1_RX_INT:
+			return DC_IRQ_SOURCE_HPD1RX;
+		case DCN_1_0__CTXID__DC_HPD2_RX_INT:
+			return DC_IRQ_SOURCE_HPD2RX;
+		case DCN_1_0__CTXID__DC_HPD3_RX_INT:
+			return DC_IRQ_SOURCE_HPD3RX;
+		case DCN_1_0__CTXID__DC_HPD4_RX_INT:
+			return DC_IRQ_SOURCE_HPD4RX;
+		case DCN_1_0__CTXID__DC_HPD5_RX_INT:
+			return DC_IRQ_SOURCE_HPD5RX;
+		case DCN_1_0__CTXID__DC_HPD6_RX_INT:
+			return DC_IRQ_SOURCE_HPD6RX;
+		default:
+			return DC_IRQ_SOURCE_INVALID;
+		}
+		break;
+
+	default:
+		return DC_IRQ_SOURCE_INVALID;
+	}
+}
+
+static bool hpd_ack(
+	struct irq_service *irq_service,
+	const struct irq_source_info *info)
+{
+	uint32_t addr = info->status_reg;
+	uint32_t value = dm_read_reg(irq_service->ctx, addr);
+	uint32_t current_status =
+		get_reg_field_value(
+			value,
+			HPD0_DC_HPD_INT_STATUS,
+			DC_HPD_SENSE_DELAYED);
+
+	dal_irq_service_ack_generic(irq_service, info);
+
+	value = dm_read_reg(irq_service->ctx, info->enable_reg);
+
+	set_reg_field_value(
+		value,
+		current_status ? 0 : 1,
+		HPD0_DC_HPD_INT_CONTROL,
+		DC_HPD_INT_POLARITY);
+
+	dm_write_reg(irq_service->ctx, info->enable_reg, value);
+
+	return true;
+}
+
+static struct irq_source_info_funcs hpd_irq_info_funcs = {
+	.set = NULL,
+	.ack = hpd_ack
+};
+
+static struct irq_source_info_funcs hpd_rx_irq_info_funcs = {
+	.set = NULL,
+	.ack = NULL
+};
+
+static struct irq_source_info_funcs pflip_irq_info_funcs = {
+	.set = NULL,
+	.ack = NULL
+};
+
+static struct irq_source_info_funcs vupdate_no_lock_irq_info_funcs = {
+	.set = NULL,
+	.ack = NULL
+};
+
+static struct irq_source_info_funcs vblank_irq_info_funcs = {
+	.set = NULL,
+	.ack = NULL
+};
+
+static struct irq_source_info_funcs outbox_irq_info_funcs = {
+	.set = NULL,
+	.ack = NULL
+};
+
+static struct irq_source_info_funcs vline0_irq_info_funcs = {
+	.set = NULL,
+	.ack = NULL
+};
+
+#undef BASE_INNER
+#define BASE_INNER(seg) ctx->dcn_reg_offsets[seg]
+
+/* compile time expand base address. */
+#define BASE(seg) \
+	BASE_INNER(seg)
+
+#define SRI(reg_name, block, id)\
+	BASE(reg ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
+			reg ## block ## id ## _ ## reg_name
+
+#define SRI_DMUB(reg_name)\
+	BASE(reg ## reg_name ## _BASE_IDX) + \
+			reg ## reg_name
+
+#define IRQ_REG_ENTRY(base, block, reg_num, reg1, mask1, reg2, mask2)\
+	REG_STRUCT[base + reg_num].enable_reg = SRI(reg1, block, reg_num),\
+	REG_STRUCT[base + reg_num].enable_mask = \
+		block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK,\
+	REG_STRUCT[base + reg_num].enable_value[0] = \
+		block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK,\
+	REG_STRUCT[base + reg_num].enable_value[1] = \
+		~block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK, \
+	REG_STRUCT[base + reg_num].ack_reg = SRI(reg2, block, reg_num),\
+	REG_STRUCT[base + reg_num].ack_mask = \
+		block ## reg_num ## _ ## reg2 ## __ ## mask2 ## _MASK,\
+	REG_STRUCT[base + reg_num].ack_value = \
+		block ## reg_num ## _ ## reg2 ## __ ## mask2 ## _MASK \
+
+#define IRQ_REG_ENTRY_DMUB(base, reg1, mask1, reg2, mask2)\
+	REG_STRUCT[base].enable_reg = SRI_DMUB(reg1),\
+	REG_STRUCT[base].enable_mask = \
+		reg1 ## __ ## mask1 ## _MASK,\
+	REG_STRUCT[base].enable_value[0] = \
+		reg1 ## __ ## mask1 ## _MASK,\
+	REG_STRUCT[base].enable_value[1] = \
+		~reg1 ## __ ## mask1 ## _MASK, \
+	REG_STRUCT[base].ack_reg = SRI_DMUB(reg2),\
+	REG_STRUCT[base].ack_mask = \
+		reg2 ## __ ## mask2 ## _MASK,\
+	REG_STRUCT[base].ack_value = \
+		reg2 ## __ ## mask2 ## _MASK \
+
+#define hpd_int_entry(reg_num)\
+		IRQ_REG_ENTRY(DC_IRQ_SOURCE_HPD1, HPD, reg_num,\
+			DC_HPD_INT_CONTROL, DC_HPD_INT_EN,\
+			DC_HPD_INT_CONTROL, DC_HPD_INT_ACK),\
+		REG_STRUCT[DC_IRQ_SOURCE_HPD1 + reg_num].funcs = &hpd_irq_info_funcs;\
+		REG_STRUCT[DC_IRQ_SOURCE_HPD1 + reg_num].status_reg = SRI(DC_HPD_INT_STATUS, HPD, reg_num);\
+
+#define hpd_rx_int_entry(reg_num)\
+		IRQ_REG_ENTRY(DC_IRQ_SOURCE_HPD1RX, HPD, reg_num,\
+			DC_HPD_INT_CONTROL, DC_HPD_RX_INT_EN,\
+			DC_HPD_INT_CONTROL, DC_HPD_RX_INT_ACK),\
+		REG_STRUCT[DC_IRQ_SOURCE_HPD1RX + reg_num].status_reg = SRI(DC_HPD_INT_STATUS, HPD, reg_num);\
+		REG_STRUCT[DC_IRQ_SOURCE_HPD1RX + reg_num].funcs = &hpd_rx_irq_info_funcs;\
+
+#define pflip_int_entry(reg_num)\
+		IRQ_REG_ENTRY(DC_IRQ_SOURCE_PFLIP1, HUBPREQ, reg_num,\
+			DCSURF_SURFACE_FLIP_INTERRUPT, SURFACE_FLIP_INT_MASK,\
+			DCSURF_SURFACE_FLIP_INTERRUPT, SURFACE_FLIP_CLEAR),\
+		REG_STRUCT[DC_IRQ_SOURCE_PFLIP1 + reg_num].funcs = &pflip_irq_info_funcs\
+
+/* vupdate_no_lock_int_entry maps to DC_IRQ_SOURCE_VUPDATEx, to match semantic
+ * of DCE's DC_IRQ_SOURCE_VUPDATEx.
+ */
+#define vupdate_no_lock_int_entry(reg_num)\
+		IRQ_REG_ENTRY(DC_IRQ_SOURCE_VUPDATE1, OTG, reg_num,\
+			OTG_GLOBAL_SYNC_STATUS, VUPDATE_NO_LOCK_INT_EN,\
+			OTG_GLOBAL_SYNC_STATUS, VUPDATE_NO_LOCK_EVENT_CLEAR),\
+		REG_STRUCT[DC_IRQ_SOURCE_VUPDATE1 + reg_num].funcs = &vupdate_no_lock_irq_info_funcs\
+
+#define vblank_int_entry(reg_num)\
+		IRQ_REG_ENTRY(DC_IRQ_SOURCE_VBLANK1, OTG, reg_num,\
+			OTG_GLOBAL_SYNC_STATUS, VSTARTUP_INT_EN,\
+			OTG_GLOBAL_SYNC_STATUS, VSTARTUP_EVENT_CLEAR),\
+		REG_STRUCT[DC_IRQ_SOURCE_VBLANK1 + reg_num].funcs = &vblank_irq_info_funcs\
+
+#define vline0_int_entry(reg_num)\
+		IRQ_REG_ENTRY(DC_IRQ_SOURCE_DC1_VLINE0, OTG, reg_num,\
+			OTG_VERTICAL_INTERRUPT0_CONTROL, OTG_VERTICAL_INTERRUPT0_INT_ENABLE,\
+			OTG_VERTICAL_INTERRUPT0_CONTROL, OTG_VERTICAL_INTERRUPT0_CLEAR),\
+		REG_STRUCT[DC_IRQ_SOURCE_DC1_VLINE0 + reg_num].funcs = &vline0_irq_info_funcs\
+
+#define dmub_outbox_int_entry()\
+		IRQ_REG_ENTRY_DMUB(DC_IRQ_SOURCE_DMCUB_OUTBOX, \
+			DMCUB_INTERRUPT_ENABLE, DMCUB_OUTBOX1_READY_INT_EN,\
+			DMCUB_INTERRUPT_ACK, DMCUB_OUTBOX1_READY_INT_ACK),\
+		REG_STRUCT[DC_IRQ_SOURCE_DMCUB_OUTBOX].funcs = &outbox_irq_info_funcs
+
+#define dummy_irq_entry(irqno) \
+	REG_STRUCT[irqno].funcs = &dummy_irq_info_funcs\
+
+#define i2c_int_entry(reg_num) \
+	dummy_irq_entry(DC_IRQ_SOURCE_I2C_DDC ## reg_num)
+
+#define dp_sink_int_entry(reg_num) \
+	dummy_irq_entry(DC_IRQ_SOURCE_DPSINK ## reg_num)
+
+#define gpio_pad_int_entry(reg_num) \
+	dummy_irq_entry(DC_IRQ_SOURCE_GPIOPAD ## reg_num)
+
+#define dc_underflow_int_entry(reg_num) \
+	dummy_irq_entry(DC_IRQ_SOURCE_DC ## reg_num ## UNDERFLOW)
+
+static struct irq_source_info_funcs dummy_irq_info_funcs = {
+	.set = dal_irq_service_dummy_set,
+	.ack = dal_irq_service_dummy_ack
+};
+
+#define dcn36_irq_init_part_1() {\
+	dummy_irq_entry(DC_IRQ_SOURCE_INVALID); \
+	hpd_int_entry(0); \
+	hpd_int_entry(1); \
+	hpd_int_entry(2); \
+	hpd_int_entry(3); \
+	hpd_int_entry(4); \
+	hpd_rx_int_entry(0); \
+	hpd_rx_int_entry(1); \
+	hpd_rx_int_entry(2); \
+	hpd_rx_int_entry(3); \
+	hpd_rx_int_entry(4); \
+	i2c_int_entry(1); \
+	i2c_int_entry(2); \
+	i2c_int_entry(3); \
+	i2c_int_entry(4); \
+	i2c_int_entry(5); \
+	i2c_int_entry(6); \
+	dp_sink_int_entry(1); \
+	dp_sink_int_entry(2); \
+	dp_sink_int_entry(3); \
+	dp_sink_int_entry(4); \
+	dp_sink_int_entry(5); \
+	dp_sink_int_entry(6); \
+	dummy_irq_entry(DC_IRQ_SOURCE_TIMER); \
+	pflip_int_entry(0); \
+	pflip_int_entry(1); \
+	pflip_int_entry(2); \
+	pflip_int_entry(3); \
+	dummy_irq_entry(DC_IRQ_SOURCE_PFLIP5); \
+	dummy_irq_entry(DC_IRQ_SOURCE_PFLIP6); \
+	dummy_irq_entry(DC_IRQ_SOURCE_PFLIP_UNDERLAY0); \
+	gpio_pad_int_entry(0); \
+	gpio_pad_int_entry(1); \
+	gpio_pad_int_entry(2); \
+	gpio_pad_int_entry(3); \
+	gpio_pad_int_entry(4); \
+	gpio_pad_int_entry(5); \
+	gpio_pad_int_entry(6); \
+	gpio_pad_int_entry(7); \
+	gpio_pad_int_entry(8); \
+	gpio_pad_int_entry(9); \
+	gpio_pad_int_entry(10); \
+	gpio_pad_int_entry(11); \
+	gpio_pad_int_entry(12); \
+	gpio_pad_int_entry(13); \
+	gpio_pad_int_entry(14); \
+	gpio_pad_int_entry(15); \
+	gpio_pad_int_entry(16); \
+	gpio_pad_int_entry(17); \
+	gpio_pad_int_entry(18); \
+	gpio_pad_int_entry(19); \
+	gpio_pad_int_entry(20); \
+	gpio_pad_int_entry(21); \
+	gpio_pad_int_entry(22); \
+	gpio_pad_int_entry(23); \
+	gpio_pad_int_entry(24); \
+	gpio_pad_int_entry(25); \
+	gpio_pad_int_entry(26); \
+	gpio_pad_int_entry(27); \
+	gpio_pad_int_entry(28); \
+	gpio_pad_int_entry(29); \
+	gpio_pad_int_entry(30); \
+	dc_underflow_int_entry(1); \
+	dc_underflow_int_entry(2); \
+	dc_underflow_int_entry(3); \
+	dc_underflow_int_entry(4); \
+	dc_underflow_int_entry(5); \
+	dc_underflow_int_entry(6); \
+	dummy_irq_entry(DC_IRQ_SOURCE_DMCU_SCP); \
+	dummy_irq_entry(DC_IRQ_SOURCE_VBIOS_SW); \
+}
+
+#define dcn36_irq_init_part_2() {\
+	vupdate_no_lock_int_entry(0); \
+	vupdate_no_lock_int_entry(1); \
+	vupdate_no_lock_int_entry(2); \
+	vupdate_no_lock_int_entry(3); \
+	vblank_int_entry(0); \
+	vblank_int_entry(1); \
+	vblank_int_entry(2); \
+	vblank_int_entry(3); \
+	vline0_int_entry(0); \
+	vline0_int_entry(1); \
+	vline0_int_entry(2); \
+	vline0_int_entry(3); \
+	dummy_irq_entry(DC_IRQ_SOURCE_DC5_VLINE1); \
+	dummy_irq_entry(DC_IRQ_SOURCE_DC6_VLINE1); \
+	dmub_outbox_int_entry(); \
+}
+
+#define dcn36_irq_init() {\
+	dcn36_irq_init_part_1(); \
+	dcn36_irq_init_part_2(); \
+}
+
+static struct irq_source_info irq_source_info_dcn36[DAL_IRQ_SOURCES_NUMBER] = {0};
+
+static struct irq_service_funcs irq_service_funcs_dcn36 = {
+		.to_dal_irq_source = to_dal_irq_source_dcn36
+};
+
+static void dcn36_irq_construct(
+	struct irq_service *irq_service,
+	struct irq_service_init_data *init_data)
+{
+	struct dc_context *ctx = init_data->ctx;
+
+#define REG_STRUCT irq_source_info_dcn36
+	dcn36_irq_init();
+
+	dal_irq_service_construct(irq_service, init_data);
+
+	irq_service->info = irq_source_info_dcn36;
+	irq_service->funcs = &irq_service_funcs_dcn36;
+}
+
+struct irq_service *dal_irq_service_dcn36_create(
+	struct irq_service_init_data *init_data)
+{
+	struct irq_service *irq_service = kzalloc(sizeof(*irq_service),
+						  GFP_KERNEL);
+
+	if (!irq_service)
+		return NULL;
+
+	dcn36_irq_construct(irq_service, init_data);
+	return irq_service;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn36/irq_service_dcn36.h b/drivers/gpu/drm/amd/display/dc/irq/dcn36/irq_service_dcn36.h
new file mode 100644
index 000000000000..21ff95f6562d
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn36/irq_service_dcn36.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright 2025 Advanced Micro Devices, Inc. */
+
+#ifndef __DAL_IRQ_SERVICE_DCN36_H__
+#define __DAL_IRQ_SERVICE_DCN36_H__
+
+#include "../irq_service.h"
+
+struct irq_service *dal_irq_service_dcn36_create(
+	struct irq_service_init_data *init_data);
+
+#endif /* __DAL_IRQ_SERVICE_DCN36_H__ */
-- 
2.37.3

