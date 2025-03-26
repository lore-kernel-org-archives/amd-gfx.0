Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF979C36019
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 19:53:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 374CE10E77D;
	Wed, 26 Mar 2025 19:53:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vUrZVuEK";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 290B110E77D
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 19:53:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S9oBLdNRzagu10kvmtiQ4jQLyDfsA7O4NQ6b0VOVWA2CqhJKTVlQc7h3Nr2NOfFBLZP0GKIOuXI6HEm70GEgQMInEJXpBMPGlyB5aJouu9s16xsL6SVUOpbuvo50GzfimmXtvxvsgf+vYA+xOaW57qryhApeFeIJxInDB5T3boILDsVGunpgRukLNC91kG0sPtY5SO5yMxMDU2hXSFqpnuFRqSrXMpIhlyaVP4GhD6OQ3dWKrJOACW5D23xoIPkOM4FLv6yyEylbUBMRG4B3I3iJlkXOBJ7DnCEXw24qFbFZ9Vu2stbSfpYhHB/YJsk5nbR6O/Evz7AxHhgTK+bKCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wf42/xy0Jr15nTNBk12AFfkF88CAfFOiSl7XNH4X1Gg=;
 b=kRIxNRvu82ylA5/LrQ2H4fKnF3WM8OUQ+EzYBJg2cNi1ulXFlhkj2oucEDT5PPQ1ncsxVpUYkq/U2ZO3eeXNAvM3tOEleDbPF0835nsSzABjC2FIgwwZr+loUnZyHJI77Z0c8i7ZRaKltusa1JPJ4JNs868tq+f3iaU7xVDMHoTPr/9eV/KGxpI4kuyR3vMCAZ96LsTfhl+Jm0jOOFAUOpMfpdhOBpIIrucgj9M+/yvm/zWCXQKtyTo0dFKUKpNP5eWDz4SIbke/q5w4Iiy2syic1HK91+EZsX23ZkPyhykpEROLzA1hd/3Exm/X5CIIg/MrY5QvTAfghI0zlNE5rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wf42/xy0Jr15nTNBk12AFfkF88CAfFOiSl7XNH4X1Gg=;
 b=vUrZVuEKF+Ab47sRq10jHqWKO/nVqp3EzPlfPvizJt4KWJ0W7uZkh1SZjBJ0t9wIqKwgHZgDSkrIuXGajOU8yMyQWVCSzXAOzTTqTnimnQ66DXaKMO89p7aRP6vOH5b2caDr2vP/NLnHys09t56kCoHxD4Gzw47oDhKFwSC4jh8=
Received: from PH1PEPF000132EB.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::2f)
 by DS0PR12MB9398.namprd12.prod.outlook.com (2603:10b6:8:1b3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 19:53:24 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2a01:111:f403:f912::5) by PH1PEPF000132EB.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.43 via Frontend Transport; Wed,
 26 Mar 2025 19:53:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 26 Mar 2025 19:53:23 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 14:53:22 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 26 Mar 2025 14:53:21 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Dillon Varone <dillon.varone@amd.com>, Aric Cyr
 <aric.cyr@amd.com>
Subject: [PATCH 16/17] drm/amd/display: Fix Vertical Interrupt definitions for
 dcn32, dcn401
Date: Wed, 26 Mar 2025 15:49:13 -0400
Message-ID: <20250326195202.17343-17-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250326195202.17343-1-Jerry.Zuo@amd.com>
References: <20250326195202.17343-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|DS0PR12MB9398:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aeca8e9-d327-4073-4327-08dd6c9fde08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+fAqrapRphglYRtr4TCha7bzLNcdNfi/JEDEkcL36IwLN+3BmyepPIa1cMyZ?=
 =?us-ascii?Q?sAtkiVWKbTv/HmfUMubNp2eEDPSqc30HTholo0a0aysGrWjZhaVxPllKLeXN?=
 =?us-ascii?Q?gxbolNNz06D/AvqRYpD3rPPTSvS/6vJ6t5qKVZz4lNQ+SyLPR3AM5LxsgwfP?=
 =?us-ascii?Q?pppIJJL1uqn9RjcftiG0LsUfO6boDnBXlS/SzxiSrFIDkXjY0vmQMI+oHA5t?=
 =?us-ascii?Q?WmPNVab+uPsvMzcvWiEBBRZrFZ8edg1qjKeetBWu+lxxN6u1hf6JmYUF7waF?=
 =?us-ascii?Q?5yvVrcqbhDURCvZ5to301bcrlCB6+xLE0JBK0XwDdsbQUySKq/i90ScmC+16?=
 =?us-ascii?Q?1f3ONfeR1LXBcqJmdwB48GXR+n+8llx9iw0FjzyTGHpyGEh6X7UIiTPpGH0L?=
 =?us-ascii?Q?nZ1Q6RpTky3LnDBCXXyISS9dXduDMb8fh94pN9pu1/R7rJTukTFeW9/bwAQL?=
 =?us-ascii?Q?aX1+MkThF2FWf1uR/XO5nI78I86ejngU9Sd7kdePkj1+bx7ZkBlCz5FbJ5jT?=
 =?us-ascii?Q?spbnov9vbzyip7ZVL69c9bIoxRTxLBjdB9AEbVCFXhCyXoD11ysVORwdKhHL?=
 =?us-ascii?Q?4TsmFLu8h6ps6ZuGA5d1Ces7qFATytDfOH22sXcrProsFBX+jo5QT6KDsni/?=
 =?us-ascii?Q?Pp3v87NHS5CNvzH1KGnar2FyxmpyOwvobpbxURM/U88ucwstf7WzCFwfIXWc?=
 =?us-ascii?Q?9bbw8FQTvZ/iOULYu/YjQsH/jkcmyz2fN6gNNs6GqZu6zxR9h1nn7YH4lmf1?=
 =?us-ascii?Q?+Z5Q5tJy8NNJ8/osDqdLTp4KELsEOMoL1uojccQnmIfGyx5Du4rDLcRXK22e?=
 =?us-ascii?Q?H/qMRQlHCbUEts8i/cK+AK32YaEzJCnBIMLJ7Z6U/GHdPR+H226qdBe0tXJM?=
 =?us-ascii?Q?gJC+CnupQM9KX07lS13YPqTfF4gRYbWqk4lH19fOwQv1tHk68Yv1DALRyi2X?=
 =?us-ascii?Q?OfePuk/9bva+tmo6MKiHPejJ6H0Fv7gbCHjFH92Jh8+2mF61VW5QFIhINdhp?=
 =?us-ascii?Q?BU6eKS2ew0Bglz5O1DMWVH03ZusGi+7Ka4z3aACwc1mOUrqPWwVW0ZO8tnKk?=
 =?us-ascii?Q?4JJSQ21GnEjnZ4z9w8XQKBedIiXzoGUpdbiQnIEPaJlToEzKzKKSr80Yq9/j?=
 =?us-ascii?Q?RW8bfNKwoQHFakQUMTnb+yoPBgICbcFAszi3ZAAh+rsmpbp0vSFEhzRbTun3?=
 =?us-ascii?Q?OK5rhOVbLO8dTtctqTXLCdygEIiUZzDkwC+qAncH7coRzTOP5Un0Cr6GTJHM?=
 =?us-ascii?Q?UShEARFBTED6kxPfi0IygxwHgYE3lHD+sbtj4LklTsPxJqm8PgBWGj7PiqgF?=
 =?us-ascii?Q?mGrrAJ0HAEjto9vZzGs/gc5X58Ch7ub7yS5MmNS00s9vkTmfVYd9PyRIUR39?=
 =?us-ascii?Q?m5eDK5qxptoSdvl7LgL3qdi1GFzaihI10jyJQWvWyChW8Do9al1bVoUZJuT5?=
 =?us-ascii?Q?RXyIwvQQgrDM4c2kjHed006SeA6PCkHT9ehZaGczwnmO11B60iCbljZygtb6?=
 =?us-ascii?Q?giWULMZkFpOb6i0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 19:53:23.5599 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aeca8e9-d327-4073-4327-08dd6c9fde08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9398
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

From: Dillon Varone <dillon.varone@amd.com>

[WHY&HOW]
- VUPDATE_NO_LOCK should be used in place of VUPDATE always
- Add VERTICAL_INTERRUPT1 and VERTICAL_INTERRUPT2 definitions

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 .../display/dc/irq/dcn32/irq_service_dcn32.c  | 61 ++++++++++++++-----
 .../dc/irq/dcn401/irq_service_dcn401.c        | 60 +++++++++++++-----
 drivers/gpu/drm/amd/display/dc/irq_types.h    |  9 +++
 3 files changed, 101 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c b/drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c
index f0ac0aeeac51..f839afacd5a5 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c
@@ -191,6 +191,16 @@ static struct irq_source_info_funcs vline0_irq_info_funcs = {
 	.ack = NULL
 };
 
+static struct irq_source_info_funcs vline1_irq_info_funcs = {
+	.set = NULL,
+	.ack = NULL
+};
+
+static struct irq_source_info_funcs vline2_irq_info_funcs = {
+	.set = NULL,
+	.ack = NULL
+};
+
 #undef BASE_INNER
 #define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
 
@@ -259,6 +269,13 @@ static struct irq_source_info_funcs vline0_irq_info_funcs = {
 		.funcs = &pflip_irq_info_funcs\
 	}
 
+#define vblank_int_entry(reg_num)\
+	[DC_IRQ_SOURCE_VBLANK1 + reg_num] = {\
+		IRQ_REG_ENTRY(OTG, reg_num,\
+			OTG_GLOBAL_SYNC_STATUS, VSTARTUP_INT_EN,\
+			OTG_GLOBAL_SYNC_STATUS, VSTARTUP_EVENT_CLEAR),\
+		.funcs = &vblank_irq_info_funcs\
+	}
 /* vupdate_no_lock_int_entry maps to DC_IRQ_SOURCE_VUPDATEx, to match semantic
  * of DCE's DC_IRQ_SOURCE_VUPDATEx.
  */
@@ -270,14 +287,6 @@ static struct irq_source_info_funcs vline0_irq_info_funcs = {
 		.funcs = &vupdate_no_lock_irq_info_funcs\
 	}
 
-#define vblank_int_entry(reg_num)\
-	[DC_IRQ_SOURCE_VBLANK1 + reg_num] = {\
-		IRQ_REG_ENTRY(OTG, reg_num,\
-			OTG_GLOBAL_SYNC_STATUS, VSTARTUP_INT_EN,\
-			OTG_GLOBAL_SYNC_STATUS, VSTARTUP_EVENT_CLEAR),\
-		.funcs = &vblank_irq_info_funcs\
-}
-
 #define vline0_int_entry(reg_num)\
 	[DC_IRQ_SOURCE_DC1_VLINE0 + reg_num] = {\
 		IRQ_REG_ENTRY(OTG, reg_num,\
@@ -285,6 +294,20 @@ static struct irq_source_info_funcs vline0_irq_info_funcs = {
 			OTG_VERTICAL_INTERRUPT0_CONTROL, OTG_VERTICAL_INTERRUPT0_CLEAR),\
 		.funcs = &vline0_irq_info_funcs\
 	}
+#define vline1_int_entry(reg_num)\
+	[DC_IRQ_SOURCE_DC1_VLINE1 + reg_num] = {\
+		IRQ_REG_ENTRY(OTG, reg_num,\
+			OTG_VERTICAL_INTERRUPT1_CONTROL, OTG_VERTICAL_INTERRUPT1_INT_ENABLE,\
+			OTG_VERTICAL_INTERRUPT1_CONTROL, OTG_VERTICAL_INTERRUPT1_CLEAR),\
+		.funcs = &vline1_irq_info_funcs\
+	}
+#define vline2_int_entry(reg_num)\
+	[DC_IRQ_SOURCE_DC1_VLINE2 + reg_num] = {\
+		IRQ_REG_ENTRY(OTG, reg_num,\
+			OTG_VERTICAL_INTERRUPT2_CONTROL, OTG_VERTICAL_INTERRUPT2_INT_ENABLE,\
+			OTG_VERTICAL_INTERRUPT2_CONTROL, OTG_VERTICAL_INTERRUPT2_CLEAR),\
+		.funcs = &vline2_irq_info_funcs\
+	}
 #define dmub_outbox_int_entry()\
 	[DC_IRQ_SOURCE_DMCUB_OUTBOX] = {\
 		IRQ_REG_ENTRY_DMUB(\
@@ -387,21 +410,29 @@ irq_source_info_dcn32[DAL_IRQ_SOURCES_NUMBER] = {
 	dc_underflow_int_entry(6),
 	[DC_IRQ_SOURCE_DMCU_SCP] = dummy_irq_entry(),
 	[DC_IRQ_SOURCE_VBIOS_SW] = dummy_irq_entry(),
-	vupdate_no_lock_int_entry(0),
-	vupdate_no_lock_int_entry(1),
-	vupdate_no_lock_int_entry(2),
-	vupdate_no_lock_int_entry(3),
 	vblank_int_entry(0),
 	vblank_int_entry(1),
 	vblank_int_entry(2),
 	vblank_int_entry(3),
+	[DC_IRQ_SOURCE_DC5_VLINE1] = dummy_irq_entry(),
+	[DC_IRQ_SOURCE_DC6_VLINE1] = dummy_irq_entry(),
+	dmub_outbox_int_entry(),
+	vupdate_no_lock_int_entry(0),
+	vupdate_no_lock_int_entry(1),
+	vupdate_no_lock_int_entry(2),
+	vupdate_no_lock_int_entry(3),
 	vline0_int_entry(0),
 	vline0_int_entry(1),
 	vline0_int_entry(2),
 	vline0_int_entry(3),
-	[DC_IRQ_SOURCE_DC5_VLINE1] = dummy_irq_entry(),
-	[DC_IRQ_SOURCE_DC6_VLINE1] = dummy_irq_entry(),
-	dmub_outbox_int_entry(),
+	vline1_int_entry(0),
+	vline1_int_entry(1),
+	vline1_int_entry(2),
+	vline1_int_entry(3),
+	vline2_int_entry(0),
+	vline2_int_entry(1),
+	vline2_int_entry(2),
+	vline2_int_entry(3)
 };
 
 static const struct irq_service_funcs irq_service_funcs_dcn32 = {
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn401/irq_service_dcn401.c b/drivers/gpu/drm/amd/display/dc/irq/dcn401/irq_service_dcn401.c
index b43c9524b0de..8499e505cf3e 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn401/irq_service_dcn401.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn401/irq_service_dcn401.c
@@ -171,6 +171,16 @@ static struct irq_source_info_funcs vline0_irq_info_funcs = {
 	.ack = NULL
 };
 
+static struct irq_source_info_funcs vline1_irq_info_funcs = {
+	.set = NULL,
+	.ack = NULL
+};
+
+static struct irq_source_info_funcs vline2_irq_info_funcs = {
+	.set = NULL,
+	.ack = NULL
+};
+
 #undef BASE_INNER
 #define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
 
@@ -239,6 +249,13 @@ static struct irq_source_info_funcs vline0_irq_info_funcs = {
 		.funcs = &pflip_irq_info_funcs\
 	}
 
+#define vblank_int_entry(reg_num)\
+	[DC_IRQ_SOURCE_VBLANK1 + reg_num] = {\
+		IRQ_REG_ENTRY(OTG, reg_num,\
+			OTG_GLOBAL_SYNC_STATUS, VSTARTUP_INT_EN,\
+			OTG_GLOBAL_SYNC_STATUS, VSTARTUP_EVENT_CLEAR),\
+		.funcs = &vblank_irq_info_funcs\
+	}
 /* vupdate_no_lock_int_entry maps to DC_IRQ_SOURCE_VUPDATEx, to match semantic
  * of DCE's DC_IRQ_SOURCE_VUPDATEx.
  */
@@ -250,13 +267,6 @@ static struct irq_source_info_funcs vline0_irq_info_funcs = {
 		.funcs = &vupdate_no_lock_irq_info_funcs\
 	}
 
-#define vblank_int_entry(reg_num)\
-	[DC_IRQ_SOURCE_VBLANK1 + reg_num] = {\
-		IRQ_REG_ENTRY(OTG, reg_num,\
-			OTG_GLOBAL_SYNC_STATUS, VSTARTUP_INT_EN,\
-			OTG_GLOBAL_SYNC_STATUS, VSTARTUP_EVENT_CLEAR),\
-		.funcs = &vblank_irq_info_funcs\
-	}
 #define vline0_int_entry(reg_num)\
 	[DC_IRQ_SOURCE_DC1_VLINE0 + reg_num] = {\
 		IRQ_REG_ENTRY(OTG, reg_num,\
@@ -264,6 +274,20 @@ static struct irq_source_info_funcs vline0_irq_info_funcs = {
 			OTG_VERTICAL_INTERRUPT0_CONTROL, OTG_VERTICAL_INTERRUPT0_CLEAR),\
 		.funcs = &vline0_irq_info_funcs\
 	}
+#define vline1_int_entry(reg_num)\
+	[DC_IRQ_SOURCE_DC1_VLINE1 + reg_num] = {\
+		IRQ_REG_ENTRY(OTG, reg_num,\
+			OTG_VERTICAL_INTERRUPT1_CONTROL, OTG_VERTICAL_INTERRUPT1_INT_ENABLE,\
+			OTG_VERTICAL_INTERRUPT1_CONTROL, OTG_VERTICAL_INTERRUPT1_CLEAR),\
+		.funcs = &vline1_irq_info_funcs\
+	}
+#define vline2_int_entry(reg_num)\
+	[DC_IRQ_SOURCE_DC1_VLINE2 + reg_num] = {\
+		IRQ_REG_ENTRY(OTG, reg_num,\
+			OTG_VERTICAL_INTERRUPT2_CONTROL, OTG_VERTICAL_INTERRUPT2_INT_ENABLE,\
+			OTG_VERTICAL_INTERRUPT2_CONTROL, OTG_VERTICAL_INTERRUPT2_CLEAR),\
+		.funcs = &vline2_irq_info_funcs\
+	}
 #define dmub_outbox_int_entry()\
 	[DC_IRQ_SOURCE_DMCUB_OUTBOX] = {\
 		IRQ_REG_ENTRY_DMUB(\
@@ -364,21 +388,29 @@ irq_source_info_dcn401[DAL_IRQ_SOURCES_NUMBER] = {
 	dc_underflow_int_entry(6),
 	[DC_IRQ_SOURCE_DMCU_SCP] = dummy_irq_entry(),
 	[DC_IRQ_SOURCE_VBIOS_SW] = dummy_irq_entry(),
-	vupdate_no_lock_int_entry(0),
-	vupdate_no_lock_int_entry(1),
-	vupdate_no_lock_int_entry(2),
-	vupdate_no_lock_int_entry(3),
 	vblank_int_entry(0),
 	vblank_int_entry(1),
 	vblank_int_entry(2),
 	vblank_int_entry(3),
+	[DC_IRQ_SOURCE_DC5_VLINE1] = dummy_irq_entry(),
+	[DC_IRQ_SOURCE_DC6_VLINE1] = dummy_irq_entry(),
+	dmub_outbox_int_entry(),
+	vupdate_no_lock_int_entry(0),
+	vupdate_no_lock_int_entry(1),
+	vupdate_no_lock_int_entry(2),
+	vupdate_no_lock_int_entry(3),
 	vline0_int_entry(0),
 	vline0_int_entry(1),
 	vline0_int_entry(2),
 	vline0_int_entry(3),
-	[DC_IRQ_SOURCE_DC5_VLINE1] = dummy_irq_entry(),
-	[DC_IRQ_SOURCE_DC6_VLINE1] = dummy_irq_entry(),
-	dmub_outbox_int_entry(),
+	vline1_int_entry(0),
+	vline1_int_entry(1),
+	vline1_int_entry(2),
+	vline1_int_entry(3),
+	vline2_int_entry(0),
+	vline2_int_entry(1),
+	vline2_int_entry(2),
+	vline2_int_entry(3),
 };
 
 static const struct irq_service_funcs irq_service_funcs_dcn401 = {
diff --git a/drivers/gpu/drm/amd/display/dc/irq_types.h b/drivers/gpu/drm/amd/display/dc/irq_types.h
index 110f656d43ae..eadab0a2afeb 100644
--- a/drivers/gpu/drm/amd/display/dc/irq_types.h
+++ b/drivers/gpu/drm/amd/display/dc/irq_types.h
@@ -161,6 +161,13 @@ enum dc_irq_source {
 	DC_IRQ_SOURCE_DPCX_TX_PHYE,
 	DC_IRQ_SOURCE_DPCX_TX_PHYF,
 
+	DC_IRQ_SOURCE_DC1_VLINE2,
+	DC_IRQ_SOURCE_DC2_VLINE2,
+	DC_IRQ_SOURCE_DC3_VLINE2,
+	DC_IRQ_SOURCE_DC4_VLINE2,
+	DC_IRQ_SOURCE_DC5_VLINE2,
+	DC_IRQ_SOURCE_DC6_VLINE2,
+
 	DAL_IRQ_SOURCES_NUMBER
 };
 
@@ -170,6 +177,8 @@ enum irq_type
 	IRQ_TYPE_VUPDATE = DC_IRQ_SOURCE_VUPDATE1,
 	IRQ_TYPE_VBLANK = DC_IRQ_SOURCE_VBLANK1,
 	IRQ_TYPE_VLINE0 = DC_IRQ_SOURCE_DC1_VLINE0,
+	IRQ_TYPE_VLINE1 = DC_IRQ_SOURCE_DC1_VLINE1,
+	IRQ_TYPE_VLINE2 = DC_IRQ_SOURCE_DC1_VLINE2,
 	IRQ_TYPE_DCUNDERFLOW = DC_IRQ_SOURCE_DC1UNDERFLOW,
 };
 
-- 
2.43.0

