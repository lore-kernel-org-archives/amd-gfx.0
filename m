Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E2C1C44508
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jan 2026 22:33:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F413210E88F;
	Wed, 21 Jan 2026 22:33:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1bpAr257";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011031.outbound.protection.outlook.com [52.101.62.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5ED3A10E892
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jan 2026 22:33:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NiWDwicML5dSplEsQ1sVIA5ufCZNaZ2dJ2JcnWDdcwWoOY+6bugA/IzOCp2Z9V2B/H37WjMc+23ROLkSCSqOqBfxA8A9pF5tCaLTyhBRbeC8axevt1u7T7Xah8Pu1+T8JSt0xtg49Qkm/OgZ8SRyp1Q/b08ezq4I6wy6L3okhNphmZLMA8rtwuamtab2iDF2nieerGHrnaWNxJzmAFE54ppabOmBYrpETvnYMzFQvsIwVLQk21QbzqUZMIUYRGTof+6rfkp83YweYHaXmfETUt9ePpq84lWTfLKiBSKox/ws6V/rwctYK+6g8Ycz89NkgJ1h0MIA3fykTwbfOu4Rww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gnAaG4K4jJqV+iKzDumCFJzX5TCsnGnNAbU0nxh2Jw=;
 b=C7dRIaF3E+fi4+0CngufcYJCTtMMNWJ/29vom+oSiYD4a4cDBMGaSlL8KHgVUExFXQhL9GXWg0Xd5FpYRHwvX1QTFNDuZUqI3hAMJT0wpVZMXzaUZ/1lVAzETtHmdiVwpfA0/FFFIRjbAHcEnDdQklHq9KiYdVCAJ5oWgpWwmVCgwKrk38P+bffhXO5kbsm0E6Qmi1FPU18k4wnNrsvFDrZ0ihHtmp9sF6+uKMT6WmsNFfDJywrkHBWaG9bQXlYSRTPvgus45oKIZCKW7ctuZ5tXvfNKPKkPQpzuCeUHcmlXsLO9npmZiUmF5XgTkUG5HjqqHm4QwhJBR5srCCvR1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gnAaG4K4jJqV+iKzDumCFJzX5TCsnGnNAbU0nxh2Jw=;
 b=1bpAr257AMiCWxsw/mzmUfgxjan4pFBlzeO4wQAJAo0r5HOmp7BudhY/HBxCha7Da7lPxCjekBH75JrmuBe1oaM7bemNC76j8TvQqU5E9ps4Q8vzZAooVTXSjV7aWV2fhieXIAsXDL7R2Kg8N3XXz05jzpNhNYFCqbv/iRqspC4=
Received: from SN7PR04CA0083.namprd04.prod.outlook.com (2603:10b6:806:121::28)
 by IA0PPF95ABFC125.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdb) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 22:33:07 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:806:121:cafe::a5) by SN7PR04CA0083.outlook.office365.com
 (2603:10b6:806:121::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 22:33:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 22:33:06 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 21 Jan
 2026 16:33:01 -0600
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 21 Jan 2026 14:32:55 -0800
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Subject: [PATCH 04/13] drm/amd/display: Enable bootcrc on FW side
Date: Wed, 21 Jan 2026 17:31:40 -0500
Message-ID: <20260121223247.186241-5-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121223247.186241-1-aurabindo.pillai@amd.com>
References: <20260121223247.186241-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|IA0PPF95ABFC125:EE_
X-MS-Office365-Filtering-Correlation-Id: 53e55a92-c69b-4bb2-739b-08de593d0c55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Y9geF7xC3WgoVEE8a4FTfDD/AD4I0KyeqBYlaUOzefLp/I9bkb8K2N+nzzpH?=
 =?us-ascii?Q?IA80aKnha5/AflkddGVUtBcQ6fimfTDG05fb+9VMpQNpq38vIJUE7KcA0kQ1?=
 =?us-ascii?Q?IRbNCYkWxu+/BrRoocT45MrGA9I1IAFIYO6jtp+lVQP/L1wh1Q1kLj0b4RbL?=
 =?us-ascii?Q?iXv0+96lLSEyeAeLygGU9+tsENADXF4wfvWaMMXorkHZVAcRYUf/RnBh7qSO?=
 =?us-ascii?Q?AkWFzFRs5fTzQbyTGEoirMv+jmq1tpMSzCUhmA3K2W9sVZqe5KqkeCZ1shZE?=
 =?us-ascii?Q?93e1pB6nSPQX4X70mN4QJjrPtwOfQfH2/oqxLLVrXthUeWOM9dgb0IqjfYMU?=
 =?us-ascii?Q?/OGod9R5kU1nrcVDOAV1zxR2Hi/7crBP0fMprt46dA6zqVfIwEqPZa7STjkG?=
 =?us-ascii?Q?3dbSMm6Cs+a3su2ydcnh5Ph94so+IEtMXRYgG6DZYCMKqQidHp2A1uq78j3G?=
 =?us-ascii?Q?vFXOTkSVQFfA/2JdjiWTiQhpsQ3/S8Mp2j6l0BXXWAi9+lyFMkbPI5bgCPKf?=
 =?us-ascii?Q?D0ag1SGJUwWFa+GAJMOltbr6l+nwFm6vZogOQXGhz5GG/gN43LHjR+0BvKMm?=
 =?us-ascii?Q?3FCuNXicT67BjTYudvIcC7ji2YXFO8XO/+tddFvosVX2KiWPU7VKG1WM15nx?=
 =?us-ascii?Q?u0hIqM8F90U4WIO+AsjRz8G6qI7ePTELKFkrk4cVtcFxRHj1UY/tKR057jl7?=
 =?us-ascii?Q?7qa/v3zHxGE2/7IdthfoJRKJXSd8NS8LJHB707UOu9FvNTGCNz8+V+y/ddaE?=
 =?us-ascii?Q?8QYXiTehx0NwzLqt0wiPU5o2Xzxv69GcT7HbSSRmpzbeUwwMztbZhsQI0P/Q?=
 =?us-ascii?Q?I0vrP6JmwylTadGc0s5mpHxfJmqaWMKC9hbN7H3/F5FfqYEQ5Pg8M++QMrNB?=
 =?us-ascii?Q?qdrni36rqSZgydBOv7Jw1XZ2g6RdghGMOYZskcovnesvGLQhcPlBvb7heO5H?=
 =?us-ascii?Q?hgpWH94+4RFCn1TAWLLxt8eDahIGnl8PjzkHsJTm6Mos2iXgVRS3HllmDKAa?=
 =?us-ascii?Q?7xj7cVaBwBj+4z+DPZSPmM6X4Jv5QbXpSNLgNmNRhNyZPcC15p/sNHAolVej?=
 =?us-ascii?Q?U8h8VWEBlV440F+l5OPKS7DInO0+yPmMlB9mxpODVOSGu4d2PIra+Eojdorp?=
 =?us-ascii?Q?89YJ/yID6vV7IVvPad9diDPNlLRV+2q/h9mIq0qQtRDA6St0fxI24YiftvMR?=
 =?us-ascii?Q?MYCHAaSuBiuVSSW+Kvo/X0VxmRAzft8sJFFX7BaN05hqYoWjbyPqNjw2+R/5?=
 =?us-ascii?Q?/4N6ESl8n5y6nUG8bzzUXs2OYmQpMibOULlzr8e6c4p24NIgwCR5OFR2RZUI?=
 =?us-ascii?Q?LD7GmR3RXMuze7PYrKH4JPECPIajUizojyy3QC+8g7OM1VqJc1HM4ANq4we0?=
 =?us-ascii?Q?aeT9SyXbOzISsGtYgCRLlCRUxv/r1a0/i3TGYsbDA7s2n5vLYVxHiKhaJo5E?=
 =?us-ascii?Q?4C5IhHWyVQzqkSyXTQVl0UwyPwuj52GSY8/j9LguDgRayZz/eaNn+8y/xv33?=
 =?us-ascii?Q?McPerBavp4z099SADRk/YaWqKCGUyb1j2AXrEsbnBFV2FHLdsJHUP4bkN6ru?=
 =?us-ascii?Q?d/ZDVJvhzddlCeLb0WUWaamHFaDPzQUeakWpXcCol6fvTpG+zJbAG+1kHTug?=
 =?us-ascii?Q?yCGM/6DPoYjwEq/yk1gLDk2VcM/6/5CwKSPkXNRraDpZrlPnfZ1+4AVjOPLj?=
 =?us-ascii?Q?pug0Kw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 22:33:06.7364 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e55a92-c69b-4bb2-739b-08de593d0c55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF95ABFC125
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

From: Wayne Lin <Wayne.Lin@amd.com>

[Why]
The bootcrc feature is controlled on the FW side.

[How]
Pass the control bits in boot options to FW.

Reviewed-by: ChiaHsuan (Tom) Chung <chiahsuan.chung@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
index 6a2d35756c8c..639f9835e5e9 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
@@ -419,6 +419,9 @@ void dmub_dcn35_enable_dmub_boot_options(struct dmub_srv *dmub, const struct dmu
 	boot_options.bits.enable_non_transparent_setconfig = params->enable_non_transparent_setconfig;
 	boot_options.bits.lower_hbr3_phy_ssc = params->lower_hbr3_phy_ssc;
 	boot_options.bits.disable_dpia_bw_allocation = params->disable_dpia_bw_allocation;
+	boot_options.bits.bootcrc_en_at_preos = dmub_dcn35_get_fw_boot_option(dmub).bits.bootcrc_en_at_preos;
+	boot_options.bits.bootcrc_en_at_S0i3 = dmub_dcn35_get_fw_boot_option(dmub).bits.bootcrc_en_at_S0i3;
+	boot_options.bits.bootcrc_boot_mode = dmub_dcn35_get_fw_boot_option(dmub).bits.bootcrc_boot_mode;
 
 	REG_WRITE(DMCUB_SCRATCH14, boot_options.all);
 }
-- 
2.52.0

