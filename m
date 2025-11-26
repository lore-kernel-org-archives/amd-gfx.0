Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39599D10F50
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 13:29:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB84B10E602;
	Wed, 26 Nov 2025 13:29:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jg5VWL+a";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012062.outbound.protection.outlook.com [52.101.43.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEE7110E602
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 13:29:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jIIuMU22zxVA/x+JlnybyRQcMGpOz9hL6eBgUOTXxmCIjiCG24gGtLcilJXWbVmpqXXEwZddEy5OpGyT7wmKhq2aRQQazGiar6d8y/Cw3oG82Gyhe5jWANbgNqHgam2tpWJjbxrJ2+9NbYV2NI3K6AnmxhzASjB7YOShaL1Did3tcmVTdl+//Vwz6sEytl1PLe1E/oqnFROr/BN2B003Sa8F+F/mqOUbGzBfsh2wCBrBmSuZ9ynJnQo7NdL0wGny9cyGVrVaSeVY/MCa3fPAzwoqigWBjzB6uuxgpsn1HcO6zGWYe1McIZ4P3ousRCwtFyRJYcp1SawHKkln/ajIgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8JsQJIP4ZNiVuCwi6KeuPC8mUrLHVcHihprLXU+Fac=;
 b=Ne1FUCPJgi3zvpLcoh3wLkYSdsw7QzWyO9yUBSW9iaqat79cHo+GQeEiiIs5ElvLTgf3kOCYaCS2VLgRbGnuiNU5hAcijJ5Plkbyh0ymy1faJgUhBQaeif63bIw5CRfCHMNX51uuYZroF38M+Y70KgGLsZP4nEisDxdMojnSCCVMvkhBdW+Pv2aQGJnqSwcngzJzuvT4Riunv2Q8w6tqwVeNpD6UnehYtWahL20eYhhwXx6sYCy81yFvUZGt4sRN51LyStZkYsI5kTx5QymEOGJAIWhS43nN1QWwVvkz9RqzOBdaWPPApOr2Gq2/VYl5MpjaVl0IQmPj8Qeqo4J9sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8JsQJIP4ZNiVuCwi6KeuPC8mUrLHVcHihprLXU+Fac=;
 b=Jg5VWL+aT3aTxxT8C891JXXazEvEMU8gx/Bwa04HgWG3d+fyj9InpoAXEzK6tq6uMPrMU4BwaNTtCK7psdhCFSZU7gq3d1z/FaxC2QYnqBsBPofj6rpqxwvSMpnuVJBONVfBjQBJw+5TWhGXPDNIt2UreZHLbnL9u+hH/965RXQ=
Received: from SJ0PR05CA0104.namprd05.prod.outlook.com (2603:10b6:a03:334::19)
 by CY5PR12MB6528.namprd12.prod.outlook.com (2603:10b6:930:43::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 13:29:10 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::3e) by SJ0PR05CA0104.outlook.office365.com
 (2603:10b6:a03:334::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.9 via Frontend Transport; Wed,
 26 Nov 2025 13:29:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 13:29:09 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 26 Nov
 2025 07:29:07 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Jesse.Zhang@amd.com>
Subject: [PATCH 16/20] drm/amd/pm: Use emit_clock_levels in SMUv10.0
Date: Wed, 26 Nov 2025 18:54:03 +0530
Message-ID: <20251126132822.3266730-17-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|CY5PR12MB6528:EE_
X-MS-Office365-Filtering-Correlation-Id: 8636df44-b902-4cf4-ac02-08de2cefc7cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uGLvqSlieHDJoZYLEsBrNZbJN20z1uKDpu4/LaQh0y62srSkscat5Ki9Li8O?=
 =?us-ascii?Q?ITMNGxvgSNpcIj4VeTbgG8uAXQO7oob4iDVIX2G1JtAs7CVCyLSuPU9seEA1?=
 =?us-ascii?Q?PeMkZEgufVZCMZT99NnIjO5vX3vQUTL1C2pApFwIfVxii9OvyHJbytGbYea8?=
 =?us-ascii?Q?jn/SsrI928p63vBrzTOMY8CGAg1xvnMbVEvRZvfvpAomh1yoxI8/n32D+FLH?=
 =?us-ascii?Q?KorDvBCdFH3aAKh4zQWB5yxCBQR7K/uAuX/i2JAHEjw3DHJpRQPXPeMa/VV7?=
 =?us-ascii?Q?miJ8drHc+1PtWRcg5XKArketnSHQ3wKAOt/RdZ2CZzaUsX8er4GrlZCprfvB?=
 =?us-ascii?Q?sHkXWi/SXKxVyK3fdoSz6mtChmcbMrysKWK5+i/OEko6bAsNzziIzsKadPP/?=
 =?us-ascii?Q?+CsrSVHrsnY0pKm9yxKjdDzhlJra4KQULqqvateL4Pztbk69Clgts+GKfzdA?=
 =?us-ascii?Q?Zctdm/KU3ULjrEYXtuaaFeiZJm/gGHZJP34INtOQ0s7lfJKzR+9L9SsHM5IO?=
 =?us-ascii?Q?dQ4Cn82wSMveb+aUc/nvMLpL2hNdj+4FwrP2rOsn9NFv4hZx9tFOqSfFlyEY?=
 =?us-ascii?Q?iTgNo+8ruZEYPfbt3xSzU+zQE0kB2UZDXRJswZ4aUMt/0AI5vz+Q6/suQxba?=
 =?us-ascii?Q?96X9AeUFC4sz1GkRQkHBoAH27Us9DMyj5WSIjaE+acWEwMU3n5DoCDIOcikT?=
 =?us-ascii?Q?j6oHNkJpumGQRxpjTqroUVRz6zYmOfFqMyOG8Z5Zs00zxxE35uJA6CLIzze+?=
 =?us-ascii?Q?omjK3hib/xxX5rYDYnU/1jF2/rjfNa5TLxRwdVsFyNOU08ot73OWwXpFTXoO?=
 =?us-ascii?Q?a5XaPzDSCV7oFKlcGLotpPJKSWSfp34HksoBtlH/158Lx3sygnZuvrnXl21b?=
 =?us-ascii?Q?t5sJ+DbDytMwrl8RAc0ZAOnk5llm0+uQkMfeFEOVYPv+Sq2ijut4xwmhvQoF?=
 =?us-ascii?Q?vfF+G0lkge3vAPTUp1NMvfr5lE/RpWbH18bHm+WVNYBkE4E0wPRErt261RKC?=
 =?us-ascii?Q?KRgGP5sSKkgeZg/tlxbdgYKnLqJEzr0EXydXJ1vjvepeJT5J7flHaHjMvyMf?=
 =?us-ascii?Q?qbQr+MTTbR8/O5d8XleF5siQt8yxYhu0ZMMvA17JyZIvGFcruEpQ2dHSt/e4?=
 =?us-ascii?Q?9sA7JglABQjdDHRgk1vZeXUpdggn6DKR91PXGxNBf1C4FY3KyZVISkyszGa1?=
 =?us-ascii?Q?DPfcyv/8JNkHZcgB97xVPsZUmimI2rAr1OqEa8cA66W9hHpw79IIz0o8+MsB?=
 =?us-ascii?Q?eQgXFfKcOzM8TIXPAdbDG+03lqZ58WhR368ozGNyioD/hyDNyJHA4I62VfkP?=
 =?us-ascii?Q?IMeHRvck2RmIC6Jiz/r9y2lDOLu5eYUTs30/Ocr2PFAr50t8ZwDS/6D6PgkP?=
 =?us-ascii?Q?Gr4RU0VIpznh2MnH12fKql7mrXq72eVWEPVyz7zxjdN5QsUTzmK7ZPA63wY4?=
 =?us-ascii?Q?2OVfwWhTJW/i27oUiPgQ9wBs1u7t3bVY4wJhr0yT/T6snBVSSaptI7en37uv?=
 =?us-ascii?Q?Tn5Wk+WUTFEXsQEzikkfqxA7E2tDO36xY16O2mYjfPsu6TgUeqiqW78EPbBN?=
 =?us-ascii?Q?tclWJ8jMTIpttStFuBE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 13:29:09.2735 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8636df44-b902-4cf4-ac02-08de2cefc7cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6528
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
 .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  | 65 +++++++++++--------
 1 file changed, 38 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index 14ccd743ca1d..8de8d66df95f 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -1024,13 +1024,14 @@ static int smu10_force_clock_level(struct pp_hwmgr *hwmgr,
 	return 0;
 }
 
-static int smu10_print_clock_levels(struct pp_hwmgr *hwmgr,
-		enum pp_clock_type type, char *buf)
+static int smu10_emit_clock_levels(struct pp_hwmgr *hwmgr,
+				   enum pp_clock_type type, char *buf,
+				   int *offset)
 {
 	struct smu10_hwmgr *data = (struct smu10_hwmgr *)(hwmgr->backend);
 	struct smu10_voltage_dependency_table *mclk_table =
 			data->clock_vol_info.vdd_dep_on_fclk;
-	uint32_t i, now, size = 0;
+	uint32_t i, now, size = *offset;
 	uint32_t min_freq, max_freq = 0;
 	int ret = 0;
 
@@ -1048,15 +1049,15 @@ static int smu10_print_clock_levels(struct pp_hwmgr *hwmgr,
 		else
 			i = 1;
 
-		size += sprintf(buf + size, "0: %uMhz %s\n",
-					data->gfx_min_freq_limit/100,
-					i == 0 ? "*" : "");
-		size += sprintf(buf + size, "1: %uMhz %s\n",
-					i == 1 ? now : SMU10_UMD_PSTATE_GFXCLK,
-					i == 1 ? "*" : "");
-		size += sprintf(buf + size, "2: %uMhz %s\n",
-					data->gfx_max_freq_limit/100,
-					i == 2 ? "*" : "");
+		size += sysfs_emit_at(buf, size, "0: %uMhz %s\n",
+				      data->gfx_min_freq_limit / 100,
+				      i == 0 ? "*" : "");
+		size += sysfs_emit_at(buf, size, "1: %uMhz %s\n",
+				      i == 1 ? now : SMU10_UMD_PSTATE_GFXCLK,
+				      i == 1 ? "*" : "");
+		size += sysfs_emit_at(buf, size, "2: %uMhz %s\n",
+				      data->gfx_max_freq_limit / 100,
+				      i == 2 ? "*" : "");
 		break;
 	case PP_MCLK:
 		ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetFclkFrequency, &now);
@@ -1064,11 +1065,12 @@ static int smu10_print_clock_levels(struct pp_hwmgr *hwmgr,
 			return ret;
 
 		for (i = 0; i < mclk_table->count; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
-					i,
-					mclk_table->entries[i].clk / 100,
-					((mclk_table->entries[i].clk / 100)
-					 == now) ? "*" : "");
+			size += sysfs_emit_at(
+				buf, size, "%d: %uMhz %s\n", i,
+				mclk_table->entries[i].clk / 100,
+				((mclk_table->entries[i].clk / 100) == now) ?
+					"*" :
+					"");
 		break;
 	case OD_SCLK:
 		if (hwmgr->od_enabled) {
@@ -1079,11 +1081,17 @@ static int smu10_print_clock_levels(struct pp_hwmgr *hwmgr,
 			if (ret)
 				return ret;
 
-			size += sprintf(buf + size, "%s:\n", "OD_SCLK");
-			size += sprintf(buf + size, "0: %10uMhz\n",
-			(data->gfx_actual_soft_min_freq > 0) ? data->gfx_actual_soft_min_freq : min_freq);
-			size += sprintf(buf + size, "1: %10uMhz\n",
-			(data->gfx_actual_soft_max_freq > 0) ? data->gfx_actual_soft_max_freq : max_freq);
+			size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
+			size += sysfs_emit_at(
+				buf, size, "0: %10uMhz\n",
+				(data->gfx_actual_soft_min_freq > 0) ?
+					data->gfx_actual_soft_min_freq :
+					min_freq);
+			size += sysfs_emit_at(
+				buf, size, "1: %10uMhz\n",
+				(data->gfx_actual_soft_max_freq > 0) ?
+					data->gfx_actual_soft_max_freq :
+					max_freq);
 		}
 		break;
 	case OD_RANGE:
@@ -1095,16 +1103,19 @@ static int smu10_print_clock_levels(struct pp_hwmgr *hwmgr,
 			if (ret)
 				return ret;
 
-			size += sprintf(buf + size, "%s:\n", "OD_RANGE");
-			size += sprintf(buf + size, "SCLK: %7uMHz %10uMHz\n",
-				min_freq, max_freq);
+			size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+			size += sysfs_emit_at(buf, size,
+					      "SCLK: %7uMHz %10uMHz\n",
+					      min_freq, max_freq);
 		}
 		break;
 	default:
 		break;
 	}
 
-	return size;
+	*offset = size;
+
+	return 0;
 }
 
 static int smu10_get_performance_level(struct pp_hwmgr *hwmgr, const struct pp_hw_power_state *state,
@@ -1652,7 +1663,7 @@ static const struct pp_hwmgr_func smu10_hwmgr_funcs = {
 	.set_cpu_power_state = smu10_set_cpu_power_state,
 	.store_cc6_data = smu10_store_cc6_data,
 	.force_clock_level = smu10_force_clock_level,
-	.print_clock_levels = smu10_print_clock_levels,
+	.emit_clock_levels = smu10_emit_clock_levels,
 	.get_dal_power_level = smu10_get_dal_power_level,
 	.get_performance_level = smu10_get_performance_level,
 	.get_current_shallow_sleep_clocks = smu10_get_current_shallow_sleep_clocks,
-- 
2.49.0

