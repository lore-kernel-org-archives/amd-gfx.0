Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E925AD10F4F
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 13:29:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DFE610E5F7;
	Wed, 26 Nov 2025 13:29:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JE1urIVP";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012055.outbound.protection.outlook.com
 [40.107.200.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4637310E5FF
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 13:29:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XLcotS1vVaqef07yYzMaU/q6By+6MuYiS/ze0O/BJnFSQSs0lxxHIeyxLx06VRuvSrnFEecOW/Xh++LTkWWhgTidy1pxbUQdOBkh+Wilgzh95WePYrA0WbWlwGFhgHoiLWV3q4OU/SFA2Pxm0J15vmSdF+RDlAgd3GQdHuchnyLfkQ3UP9I115BGSJCbiEuF9fp7QHZK3p3QfGjCjn0lDejmNFl8v5kUffMFjbV4Ndi570ETs/tPUA3Hk22ZfwdtbQ0ih4urK9WDEJu6Ufsk1JsYXon+584dvAmLA5LFtV7eig05HQ89FrEAN1C+HkkeIttMHH500n256uFMkMCvHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDFFkwmzJ9X7v/EBkXKdw2Sh+2hO91cwduC2VYb7n5Y=;
 b=pvmsBi1xwVqqJbi4DqAfJZ8r/zcD4VFdpzgBofwvx+D636FT2mPbXcSG10AYU7C1KsOzPMdexAq7jD696k4G0ye2OotaCyYV1ihTqwguFZvsxjIIhFmL5ehkTA0Ip+AH0K2JSMa1Vkybp3mVwOy0vT4b4K/bhDckXY3CxJfynV1Y2/TNDwIjx11UJOcF6WgsuEl0dSuFYFlMJ3VkyEIr4KjrIJcVcQ1nLFIYcna81Wxp28nrNPLs6n8UHooI1aivt8RyFawjaODadErppLxuzxtN/MQvKy/crkHvG8V1C4GpAEyuLYHbVp08zmOGC5eU3C2cvtqcxAfsjk03Y/2Xww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDFFkwmzJ9X7v/EBkXKdw2Sh+2hO91cwduC2VYb7n5Y=;
 b=JE1urIVPyA0APRqgG14ISgYgStNjOPS5x8qVLqLb8rANLMlzQeBQfgyh+V4HL/8lj2bOV+wGQ/Ybr+InnNyXdJ5lslEMlfeRzI1TQlLu1moY38qF4nRlu+quyNWm8gcLSCqqNAJt2ZemQ8tSvRKF1xzvVxjRPg81hF6o7LMydH0=
Received: from SJ0P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::14)
 by CY8PR12MB8243.namprd12.prod.outlook.com (2603:10b6:930:78::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 13:29:06 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::ee) by SJ0P220CA0010.outlook.office365.com
 (2603:10b6:a03:41b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.18 via Frontend Transport; Wed,
 26 Nov 2025 13:29:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 13:29:06 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 26 Nov
 2025 07:29:03 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Jesse.Zhang@amd.com>
Subject: [PATCH 14/20] drm/amd/pm: Use emit_clock_levels in SMUv7.0
Date: Wed, 26 Nov 2025 18:54:01 +0530
Message-ID: <20251126132822.3266730-15-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251126132822.3266730-1-lijo.lazar@amd.com>
References: <20251126132822.3266730-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|CY8PR12MB8243:EE_
X-MS-Office365-Filtering-Correlation-Id: 9427c859-4230-48dd-0bc6-08de2cefc5f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dNYrd+3o9p3aceiJzJsdoGlqIjtnauAdtaVUZ1/ButZU63n+SSDZPOZaxZ+w?=
 =?us-ascii?Q?OLx3Q11G78NtbrcSPDbpo+ZqhPJcZddkNp8g4QjfjPNryXYAtO4bNJ3jjCZ+?=
 =?us-ascii?Q?n3kt4X9m6t6erOZFcMnFRd9lHHel8p++8V3GgJpP/a/adunUPl1lbrFiUet2?=
 =?us-ascii?Q?FNlgp5JOq5U4NOuNxvGIAWEq+osA2+3cyvPh2Bm4fqOMymPPYr8J00B36HDR?=
 =?us-ascii?Q?UcE1OAGc30YwU/HpefkPT/+G08MBKqNzGYMNZKGkuLLPXK0ZnUCxyvnacT/q?=
 =?us-ascii?Q?6/IyDWIlI65l4A9w8YZk6kuC4NgqmCy8Js5aFO5ilTNRkFEKu0LaAJjqlIAj?=
 =?us-ascii?Q?jAh0b6fSrI7xkmZPYV7LrDztRbGZYzJ+0Aos/iAoZqh+YqsNdPK3L6j9A4tl?=
 =?us-ascii?Q?Xpozgy8vKzFc9IyYAaigQkSORdbf32xKJHv1mHpIl0MR0qnss4VSzqFHZM12?=
 =?us-ascii?Q?BnyqMvqhTa/mHiJx4s02z5urKTvTgoM7vzOmzuFcMptXq/qaCw6jk9haXfWA?=
 =?us-ascii?Q?wMfcYLlFLiDbqq2AxUhIoEsvQsUKiICwUkR7z/4fBjip4PslBEScv3XKnPVd?=
 =?us-ascii?Q?HOH5XP5fl2Czan4aRT0GHA4cVG3QGp0i/kCPpAIuJ0XMMrdK2CPMFutDlG4+?=
 =?us-ascii?Q?RT5BfeP2AzZ4DK14KqfoDYp959AO6g3u8CrsHHQclufAYO3hDhtb2XQQc5sX?=
 =?us-ascii?Q?vHBObyYmh6b6k1a7TI83vSdtNvhk5iLakZRB8vxyGRMHqyzKmA/4GVP6PeYL?=
 =?us-ascii?Q?PArx3CKjkq0gsKsmMNrsagrJUEzBjgjJuDvNrfsOEQybLHUzzxR/E/OCcYEY?=
 =?us-ascii?Q?8CCdi8wB2krieL9n8T6G9k2qGI4LrvXrgt4Uw4b1/gAwm8Ri/F2tMwmLFBkW?=
 =?us-ascii?Q?AuyqytqpoIFgawwB3/cl33HxrDyg7TVHezKa93adf9JIfFfb4MfvD39ykUBq?=
 =?us-ascii?Q?A/j/osdzR+tSN9Fh7PkX5/s1ud3nPQ5b0/xl00rEbrlWvq8ZT8vMpID8KRbD?=
 =?us-ascii?Q?IxqBdPhrdDdfsO8GL8kNibE447Jrpvpg/ymz8STUbgQQO3ycVxaRjyfZn4kJ?=
 =?us-ascii?Q?2lQRv8SqkSOpZ6icqjnUcxlWoj4KA3zMwUZ2Az0O1YW8vJyHI+vLUm11zZ33?=
 =?us-ascii?Q?eBAt6dvz+H+Htl6lgb6YpZIuHj5fbKWJX9YiAXyRez7gxtpDB56ucNngnupE?=
 =?us-ascii?Q?0xF7Li0j/jeyVxK6Vu9fXeCOqQ8RrBKALYLk7oYNWEptatuICmfOcxsgqSqs?=
 =?us-ascii?Q?pcOCsgMGw3ExaH2lec5iKkq21re1/TK1HgSyzUAsJWVYdfNrB6nm2xAvHN3k?=
 =?us-ascii?Q?xqrOQvJMHKtR/TS8yosHP/RUlNUm8TX26nhNpphUFzf17nlQS4dVYoC1ZEPW?=
 =?us-ascii?Q?Q1kcYvqrMuptYDH6W7Ldt3ulqQAOsfUpfcMhB1teUm9iFo266iMEW1A852qU?=
 =?us-ascii?Q?WG++FMIixwfhUCiMTm+T9tRn08I3G1EAEN0K6zOrS31InZBGJxa2KNdZUIxw?=
 =?us-ascii?Q?29+ReOpcDdC+5M256uVg/xxXaH4a5edhkYyI8E97GE0/ZgkAc/F6r7LynhjT?=
 =?us-ascii?Q?5mL+LDhgk/cvxfUwqNM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 13:29:06.2228 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9427c859-4230-48dd-0bc6-08de2cefc5f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8243
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

Move to emit_clock_levels from print_clock_levels

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 87 ++++++++++++-------
 1 file changed, 55 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 9b28c0728269..2be584aefd0a 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -4961,8 +4961,9 @@ static int smu7_force_clock_level(struct pp_hwmgr *hwmgr,
 	return 0;
 }
 
-static int smu7_print_clock_levels(struct pp_hwmgr *hwmgr,
-		enum pp_clock_type type, char *buf)
+static int smu7_emit_clock_levels(struct pp_hwmgr *hwmgr,
+				  enum pp_clock_type type, char *buf,
+				  int *offset)
 {
 	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
 	struct smu7_single_dpm_table *sclk_table = &(data->dpm_table.sclk_table);
@@ -4971,7 +4972,7 @@ static int smu7_print_clock_levels(struct pp_hwmgr *hwmgr,
 	struct smu7_odn_dpm_table *odn_table = &(data->odn_dpm_table);
 	struct phm_odn_clock_levels *odn_sclk_table = &(odn_table->odn_core_clock_dpm_levels);
 	struct phm_odn_clock_levels *odn_mclk_table = &(odn_table->odn_memory_clock_dpm_levels);
-	int size = 0, ret = 0;
+	int size = *offset, ret = 0;
 	uint32_t i, now, clock, pcie_speed;
 
 	switch (type) {
@@ -4987,9 +4988,10 @@ static int smu7_print_clock_levels(struct pp_hwmgr *hwmgr,
 		now = i;
 
 		for (i = 0; i < sclk_table->count; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
-					i, sclk_table->dpm_levels[i].value / 100,
-					(i == now) ? "*" : "");
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i,
+					      sclk_table->dpm_levels[i].value /
+						      100,
+					      (i == now) ? "*" : "");
 		break;
 	case PP_MCLK:
 		ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_API_GetMclkFrequency, &clock);
@@ -5003,9 +5005,10 @@ static int smu7_print_clock_levels(struct pp_hwmgr *hwmgr,
 		now = i;
 
 		for (i = 0; i < mclk_table->count; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
-					i, mclk_table->dpm_levels[i].value / 100,
-					(i == now) ? "*" : "");
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i,
+					      mclk_table->dpm_levels[i].value /
+						      100,
+					      (i == now) ? "*" : "");
 		break;
 	case PP_PCIE:
 		pcie_speed = smu7_get_current_pcie_speed(hwmgr);
@@ -5017,48 +5020,68 @@ static int smu7_print_clock_levels(struct pp_hwmgr *hwmgr,
 		now = i;
 
 		for (i = 0; i < pcie_table->count; i++)
-			size += sprintf(buf + size, "%d: %s %s\n", i,
-					(pcie_table->dpm_levels[i].value == 0) ? "2.5GT/s, x8" :
-					(pcie_table->dpm_levels[i].value == 1) ? "5.0GT/s, x16" :
-					(pcie_table->dpm_levels[i].value == 2) ? "8.0GT/s, x16" : "",
-					(i == now) ? "*" : "");
+			size += sysfs_emit_at(
+				buf, size, "%d: %s %s\n", i,
+				(pcie_table->dpm_levels[i].value == 0) ?
+					"2.5GT/s, x8" :
+				(pcie_table->dpm_levels[i].value == 1) ?
+					"5.0GT/s, x16" :
+				(pcie_table->dpm_levels[i].value == 2) ?
+					"8.0GT/s, x16" :
+					"",
+				(i == now) ? "*" : "");
 		break;
 	case OD_SCLK:
 		if (hwmgr->od_enabled) {
-			size += sprintf(buf + size, "%s:\n", "OD_SCLK");
+			size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
 			for (i = 0; i < odn_sclk_table->num_of_pl; i++)
-				size += sprintf(buf + size, "%d: %10uMHz %10umV\n",
-					i, odn_sclk_table->entries[i].clock/100,
+				size += sysfs_emit_at(
+					buf, size, "%d: %10uMHz %10umV\n", i,
+					odn_sclk_table->entries[i].clock / 100,
 					odn_sclk_table->entries[i].vddc);
 		}
 		break;
 	case OD_MCLK:
 		if (hwmgr->od_enabled) {
-			size += sprintf(buf + size, "%s:\n", "OD_MCLK");
+			size += sysfs_emit_at(buf, size, "%s:\n", "OD_MCLK");
 			for (i = 0; i < odn_mclk_table->num_of_pl; i++)
-				size += sprintf(buf + size, "%d: %10uMHz %10umV\n",
-					i, odn_mclk_table->entries[i].clock/100,
+				size += sysfs_emit_at(
+					buf, size, "%d: %10uMHz %10umV\n", i,
+					odn_mclk_table->entries[i].clock / 100,
 					odn_mclk_table->entries[i].vddc);
 		}
 		break;
 	case OD_RANGE:
 		if (hwmgr->od_enabled) {
-			size += sprintf(buf + size, "%s:\n", "OD_RANGE");
-			size += sprintf(buf + size, "SCLK: %7uMHz %10uMHz\n",
-				data->golden_dpm_table.sclk_table.dpm_levels[0].value/100,
-				hwmgr->platform_descriptor.overdriveLimit.engineClock/100);
-			size += sprintf(buf + size, "MCLK: %7uMHz %10uMHz\n",
-				data->golden_dpm_table.mclk_table.dpm_levels[0].value/100,
-				hwmgr->platform_descriptor.overdriveLimit.memoryClock/100);
-			size += sprintf(buf + size, "VDDC: %7umV %11umV\n",
-				data->odn_dpm_table.min_vddc,
-				data->odn_dpm_table.max_vddc);
+			size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+			size += sysfs_emit_at(
+				buf, size, "SCLK: %7uMHz %10uMHz\n",
+				data->golden_dpm_table.sclk_table.dpm_levels[0]
+						.value /
+					100,
+				hwmgr->platform_descriptor.overdriveLimit
+						.engineClock /
+					100);
+			size += sysfs_emit_at(
+				buf, size, "MCLK: %7uMHz %10uMHz\n",
+				data->golden_dpm_table.mclk_table.dpm_levels[0]
+						.value /
+					100,
+				hwmgr->platform_descriptor.overdriveLimit
+						.memoryClock /
+					100);
+			size += sysfs_emit_at(buf, size, "VDDC: %7umV %11umV\n",
+					      data->odn_dpm_table.min_vddc,
+					      data->odn_dpm_table.max_vddc);
 		}
 		break;
 	default:
 		break;
 	}
-	return size;
+
+	*offset = size;
+
+	return 0;
 }
 
 static void smu7_set_fan_control_mode(struct pp_hwmgr *hwmgr, uint32_t mode)
@@ -5775,7 +5798,7 @@ static const struct pp_hwmgr_func smu7_hwmgr_funcs = {
 	.set_fan_control_mode = smu7_set_fan_control_mode,
 	.get_fan_control_mode = smu7_get_fan_control_mode,
 	.force_clock_level = smu7_force_clock_level,
-	.print_clock_levels = smu7_print_clock_levels,
+	.emit_clock_levels = smu7_emit_clock_levels,
 	.powergate_gfx = smu7_powergate_gfx,
 	.get_sclk_od = smu7_get_sclk_od,
 	.set_sclk_od = smu7_set_sclk_od,
-- 
2.49.0

