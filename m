Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C87F1C71135
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 06:54:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D0EA10E2B5;
	Mon, 16 Jun 2025 06:54:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XyfoJgee";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A85D10E2B6
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 06:54:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQf6lvGKg9MHNtg61FohM44JZAmeAolGx+C56z97M8HZr/453G4F1PsYqyCvDmSetdA9fNe9xCdWvP/qB81YKwFpWmtNfd46L2YOu1+IvZlwFvZMmX5WtyQVrZC5alguOxtI5G6BciHHZOvETppkVgvFb586ce+A90uzzK5XYGoVBfD8vptFfCEX5rHcGBDCEK6GRb3ImOdOERpN9U+InXSX4Z9efCExMKNyIjezuEWtZDid4Hstx4+Q5elMHO0ay0GhfuhHAE7szJYwSGf+rwDXhXMlRvh1KLedDqBznNuhMQtbTD4x4MgZSTjflr5VBvVHLvyOsZJOMpdmQEcrNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qLzNpd0DjsSb17RnGqm4j0ayC6EqT0HxN1o8JKHKJg=;
 b=mpJnM/xdosa3tlwNBBmNrFBoyByVQthdZ2wRZUF9TR9EzgJ8zWnnnOQL7asrucJhkxMUmUPy5YcKEAMw25aH0nd816NOvr1pLqHBEx2N1gilbHGOVdP5AK1C8x0BybBCwJmF0nObn0l/a8iE1pVcUEW38Bj/rHFKk9pwOo0Dof0lMogVDrLo8d9B8B/818aW/IKTkfwFCyd20o0U86DmfTbuiqVS/h4L1V+f2UqeMkmu/LTpKD7W/QwL+/SGgvmqm+Lu3OStdy1pdNlI8tvMcyK+4g+lPfiQRbtydUpbK7JOJpQmyDrnfmobcw37lL4PTmHl/Hcfn5XNdw2jWIjfNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qLzNpd0DjsSb17RnGqm4j0ayC6EqT0HxN1o8JKHKJg=;
 b=XyfoJgee4AupoOsIbGBxjqA22StA4pFXzEU6jXGbX3kpKpOgE9jeEgNLOwut+whEpsjXo3eNslzajTWkdm9ri9vc2go67YvqgIMXRIp/3IDoS63QfE8Tsi+htQTr+bA7rktCG8LYEop2MmHdwPLvElOt3McBXAHtvsjrLi1PyA8=
Received: from SA1P222CA0124.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::12)
 by DS7PR12MB6263.namprd12.prod.outlook.com (2603:10b6:8:95::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 06:54:23 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:3c5:cafe::e) by SA1P222CA0124.outlook.office365.com
 (2603:10b6:806:3c5::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Mon,
 16 Jun 2025 06:54:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 06:54:23 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 01:54:20 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 4/4] drm/amd/pm: Fetch SMUv13.0.12 xgmi max speed/width
Date: Mon, 16 Jun 2025 12:24:00 +0530
Message-ID: <20250616065400.868818-4-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250616065400.868818-1-lijo.lazar@amd.com>
References: <20250616065400.868818-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|DS7PR12MB6263:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eeff9a6-0916-4cbd-28fc-08ddaca2a04f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SvO+2rjokmIh7lhLCTNtAtLojME9uUSRPSH9QRCWIy5HHC5anvw6tp7tSzFo?=
 =?us-ascii?Q?yegrwKXTJuglQcrUwcSAtCxv7r6GyOLcc1d8SGJYMK43zcCpWd7oBILkR7WT?=
 =?us-ascii?Q?RUXzgGnM6IPXkamxT9Dnj7yvvUM3GNgnLPX8lWFEpPR0N0jZqWgRuMETGlUp?=
 =?us-ascii?Q?ns9i128UAJhHn4mG4/0IjmZ+JGthLI5GIO+v8ckE9YvIWYvVxqkrCiWqWWGJ?=
 =?us-ascii?Q?xg6bTS4T03c3+f3yPoWXI2A7WDwd9RsOygbCUqYHq9ZkLVh+B/cLkhomy4Ah?=
 =?us-ascii?Q?Sg5WnDS8Unk6RzWyeBzE6eShnHvYclO8w/BF/ov23befaoUIC0T1hu7V0DaA?=
 =?us-ascii?Q?zpsiRpZ3oDOYa8VBgwZ0dacZkht1HZdv6qjhTiYXlAqflYnxVMXJxGwE+JOx?=
 =?us-ascii?Q?Qg1nE1tbttUMB/KcKldCa4rt8TunyaAn42AEBlAa84RyZYqo+jFQP2p5M46i?=
 =?us-ascii?Q?DLeafoRYS9Q7SxjifY7WYznzCLX5HgH4e0VMgVibtBtfji7571IefUU+mm+1?=
 =?us-ascii?Q?ybw28NsQCO6JWhe9oTdvz6oh3X9KnhskfDkPw+rWXcYL8Pf7R5MPnl4KO64I?=
 =?us-ascii?Q?30HEgbxM2fG8Ri9aJ+sQk/QkNAzrpaUZIc5j5shig6TFPFzv5ND1+cucR7HX?=
 =?us-ascii?Q?dHtFRmJuUynKbarKTnoJ0yIRfE+4oUAAaEuEXQifONVH7wcTt43ej/JoSlpm?=
 =?us-ascii?Q?zm4+zhMM87F1llsewXjdcC1RufXBTSYURZOU9+TieCzmKH35/5oEp1chGGeB?=
 =?us-ascii?Q?U1bmxG+y3XuQ+cPUMSic2Hrf5c7kouGWJSPHeS62pG0OjzzxeEj6bwkyVRmq?=
 =?us-ascii?Q?4oheEO1cyezeYHUK0biN2hwhGj3yFmcZUE98rWReu8IZClHrGpkFj1K9mW6e?=
 =?us-ascii?Q?kDvFg0Lr3dnRjU2MUjZuH5eUN/eSUVGCVB9h2rbfeLI3fl+zCMcwC+P784nV?=
 =?us-ascii?Q?nPjG9SCC6DLehADhyuqGyS2U6Xbi8EVKS0TFTVJWJHHEOrgPlwaIalgkF5PT?=
 =?us-ascii?Q?lt6rqDNNsXPxw0e6CgXGtinm+cJHWwh2Ha9M7IUkzKCPGExFoIXH2Vn1gM1y?=
 =?us-ascii?Q?zj5LKAypT2LxvcHTzFO43qfIYKXr/JdwZbO2M1N6HhhJNMTvogbw5aZs5MXC?=
 =?us-ascii?Q?PkTGdY/p0BVLTmQjMoo4h/nd8uBU/sn27XgXtfTcjqTDX/mDk0P2PC6q7W4k?=
 =?us-ascii?Q?VGFTxWj6PjBi/fVZWHc1JvQ3cAjeKT+cMP/77k7ZAHsYyKtJe2rHell/VFNL?=
 =?us-ascii?Q?P6d8UfWYxMwSuGZkmmnYxmCHGmxjqrVybDE9LsoGzG7PJr6DUaoBQDSnv1AH?=
 =?us-ascii?Q?Sv9N0COT7J9OCX0LNcKOhCLMkjRUrHeDR+g3tiOdt93+EESPlFXrvgxRh0R0?=
 =?us-ascii?Q?aQ1a8ow1EgFRGiC3qVIvLav/xS9zNSeIWdQuRr8niUgUlzgoES9+17OvO+KD?=
 =?us-ascii?Q?QgzfI/sMwol9wX/Nb8C7xcDae/0j8+wcmuic5HsnpN57KOlNfWLJHbmVFEmv?=
 =?us-ascii?Q?C33zqXZ6k/1wNSxmD/COFN35jm41wvrVSqzr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 06:54:23.0049 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eeff9a6-0916-4cbd-28fc-08ddaca2a04f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6263
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

On SMU v13.0.12 SOCs, fetch the max values of xgmi speed/width from
firmware.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 26 +++++++++++++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  4 +--
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h  |  2 ++
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 99663165363e..7ae0ced7fa13 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -187,6 +187,31 @@ int smu_v13_0_12_get_max_metrics_size(void)
 	return max(sizeof(StaticMetricsTable_t), sizeof(MetricsTable_t));
 }
 
+static void smu_v13_0_12_init_xgmi_data(struct smu_context *smu, StaticMetricsTable_t *static_metrics)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	uint16_t max_speed;
+	uint8_t max_width;
+	int ret;
+
+	if (smu_table->tables[SMU_TABLE_SMU_METRICS].version >= 0x13)
+	{
+		max_width = (uint8_t)static_metrics->MaxXgmiWidth;
+		max_speed = (uint16_t)static_metrics->MaxXgmiBitrate;
+		ret = 0;
+	} else {
+		MetricsTable_t *metrics = (MetricsTable_t *)smu_table->metrics_table;
+
+		ret = smu_v13_0_6_get_metrics_table(smu, NULL, true);
+		if (!ret) {
+			max_width = (uint8_t)metrics->XgmiWidth;
+			max_speed = (uint16_t)metrics->XgmiBitrate;
+		}
+	}
+	if (!ret)
+		amgpu_xgmi_set_max_speed_width(smu->adev, max_speed, max_width);
+}
+
 int smu_v13_0_12_setup_driver_pptable(struct smu_context *smu)
 {
 	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
@@ -249,6 +274,7 @@ int smu_v13_0_12_setup_driver_pptable(struct smu_context *smu)
 			static_metrics->pldmVersion[0] != 0xFFFFFFFF)
 			smu->adev->firmware.pldm_version =
 				static_metrics->pldmVersion[0];
+		smu_v13_0_12_init_xgmi_data(smu, static_metrics);
 		pptable->Init = true;
 	}
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 55316c96d6d3..a1f0ea91f3b0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -690,8 +690,8 @@ static int smu_v13_0_6_get_allowed_feature_mask(struct smu_context *smu,
 	return 0;
 }
 
-static int smu_v13_0_6_get_metrics_table(struct smu_context *smu,
-					 void *metrics_table, bool bypass_cache)
+int smu_v13_0_6_get_metrics_table(struct smu_context *smu, void *metrics_table,
+				  bool bypass_cache)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 	uint32_t table_size = smu_table->tables[SMU_TABLE_SMU_METRICS].size;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index d38d6d76b1e7..67b30674fd31 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -74,6 +74,8 @@ enum smu_v13_0_6_caps {
 extern void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu);
 bool smu_v13_0_6_cap_supported(struct smu_context *smu, enum smu_v13_0_6_caps cap);
 int smu_v13_0_6_get_static_metrics_table(struct smu_context *smu);
+int smu_v13_0_6_get_metrics_table(struct smu_context *smu, void *metrics_table,
+				  bool bypass_cache);
 
 bool smu_v13_0_12_is_dpm_running(struct smu_context *smu);
 int smu_v13_0_12_get_max_metrics_size(void);
-- 
2.25.1

