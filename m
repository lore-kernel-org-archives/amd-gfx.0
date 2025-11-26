Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA7D6D10F4D
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 13:29:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AEE610E5E8;
	Wed, 26 Nov 2025 13:29:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="otmaOOlL";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010002.outbound.protection.outlook.com [52.101.201.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4A6410E5FA
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 13:29:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mFfipwTlxF0hy9QdO/0elQo1jg3ikoLeFdjb6Q/hMXJjuTJ8U9DBsiGVZrfUK2DcJj00nWbwZcJv7c+h5B64T8Vn8NYSVat0gpPudgZJvTQhzAThlP/zR/IokDlcw2U01QiP3Hj7xVqRaNXg9Xh/M5jlJTmaDwWUUY4SHttT2fwEM5vmKqSmrHWo+Q/A+lUeczMX1nzHK0EbGRDj6fQ1EDgAq5/t93ASQ8AE7LLmu+TkeoVB3N18mC7d6JT9ZjkyIa+YS2o1c0CHOxTMHQ0jYj15TxHv77gU2XMTXX7IoUR4w8kSDx7PwlktvC5IELboOyaJC9grSlxbiJr7TFt7Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3DeyNpVCaX31gy3+9dseAseGhsv98RqYff+HV9OZkGU=;
 b=APP67EXgEgiMGavbc4vqFrXdvgF9Sm1qpOhK+SocMgrn0tUUw07mQY6GkaBgbbnEQ/7xR1fBe8k8O79J5l9okLg4053nluHlG3K6PHWQTs9cbgRPFRb14QfipboqOcld7AyRX6BYpN32aozuPdGW0CpSis2vRshzwCseoCR0xks7jl8Q1z8aIPEN3csRFXNmA9tf/L8GySpunJDwkV87Uu8HM6dLSQznhT9iog3F4Ue7sUZvwf7n5HaVavcSwpkLU5HIaaUzDlUuJfjLGHRl/AHoeATMvw3mY3f4oOsSw4lteV2Or5JTxrC27v3Cck21CCYp65kLwkQYtpKzygQ6mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DeyNpVCaX31gy3+9dseAseGhsv98RqYff+HV9OZkGU=;
 b=otmaOOlL+5Ey5mRh8wJNT28q/yfQH1yKMuhy987HVaxac3bmM0fBQqlLAsncx9NgdwiD7Z/jtfoR5FqOMH32WWTGAeYTD5xCBvk3X9Hy5I1EdJ28N5JtlNW0S72sKF0y5/IGUyz5lWWERM7zctD+bkz1li0xvu0NVE1S13aW5D0=
Received: from SJ0PR03CA0300.namprd03.prod.outlook.com (2603:10b6:a03:39e::35)
 by PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 13:28:58 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::84) by SJ0PR03CA0300.outlook.office365.com
 (2603:10b6:a03:39e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.12 via Frontend Transport; Wed,
 26 Nov 2025 13:28:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 13:28:58 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 26 Nov
 2025 07:28:56 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Jesse.Zhang@amd.com>
Subject: [PATCH 10/20] drm/amd/pm: Use emit_clk_levels in SMUv13.0.7
Date: Wed, 26 Nov 2025 18:53:57 +0530
Message-ID: <20251126132822.3266730-11-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|PH7PR12MB8796:EE_
X-MS-Office365-Filtering-Correlation-Id: bbe7d393-91b3-4c7c-533a-08de2cefc164
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lfxC/HkUIjsK6K+iaIOAeJ+LZNQm2x2P5EPOWncdyioixS+4pRSokbrxw/ui?=
 =?us-ascii?Q?uC4tUWyNNw08cwVLoz17SvfQEojYMIvohuVBc09O+YBD8H8a05yLJjKFaI5F?=
 =?us-ascii?Q?1r0ntdeRUQ8vBlcmVzPojnUeilgLewWXPqWo8SfR+yaU5BU86mpyRvaMXXtI?=
 =?us-ascii?Q?ULigKIeJLEMKDt3PNck3FrBrLI7N+kKNnnxt1IIL9Yggd64yhcYgAuirTtOT?=
 =?us-ascii?Q?S+BqvBWMUdoTMy2Q6yOLTdVqv8PrkGkjiJ6TshKoeX8S/agAWJdifv9mZ0Cq?=
 =?us-ascii?Q?NvjP0z8pfTFVRjLL29jwHsK/Y3vbGOyY+raZmajRJdJfaUySIMXhdRGvxKiO?=
 =?us-ascii?Q?5H6wmV/g+IMh2tIhAqSDtaF3QpGRTNsk4zWvoPiZx6xPS9kvg7D28S/imchd?=
 =?us-ascii?Q?0Glv74GctrOmTHUvTWkCA9Q3TMOZU/P8hOWZJUdmxsyx8UwnW76x240wlWP2?=
 =?us-ascii?Q?YQVuasgFJ6S4pz9Pq2dhpftWJ+pPsN1+kAIq3DXt6ObVnLY9FvewGV4D91Lo?=
 =?us-ascii?Q?pjSk/M3w5cHIH7xYO2xpC2+y5vnDHuinxOCzrz6xnKoO9x/0UYklXDffwct1?=
 =?us-ascii?Q?j5dEK3zjiyZDtcjzEAiRWurNjs9dezzAoMn0oniLRCuCQfczxTh/v0yQEtWv?=
 =?us-ascii?Q?bM883a5Vepwav8phOvH15YBp3ecYH9fr4LQpXw/0vLi1CJ4Efa70ay25UUsn?=
 =?us-ascii?Q?StHZweH5yhnAHxvfBMaB+BdJuYTnJpxGmXfgAQ94JLT3S5IZ40YnprsQCffK?=
 =?us-ascii?Q?+22TRlycqFRjx5xDG9G8H9Fh0wcNnpNhKPF94s6pONCjW8OgD0p9EtVh2amK?=
 =?us-ascii?Q?TYn1P+vQxVHgi4x7K8YHIwlfKO2w5ArxJJMaLdj4F4qat/7Rn3x+iizIIaMt?=
 =?us-ascii?Q?ghtY305iV0+bgPC7EAYmOBtFl1QQnK4YkdqPDX4gCTbSqZZCqOMu+QOovEKX?=
 =?us-ascii?Q?N4fwt9frTf6lCBE8nAgaxZCW2gUaPksfkZLh4CXqO3N9Hmv8m0RW0ZdzugmM?=
 =?us-ascii?Q?aJyTq5EcrFmes5p3P3JZevyCvAQPTf+1dZHyBxhtI5NMGZo//cvFNsqZRkFP?=
 =?us-ascii?Q?DDgDGPRUBMZxQpf1Z6EIUY4So9mc3Y4qoFLyVHHDRYfu0YT2g74zPSZ9jqpJ?=
 =?us-ascii?Q?2T7OspijZ8WLINXk0uUIIE9S3C8/rOc4LqtnCq7HqE4ne5B1GI0jSRV0Vyc2?=
 =?us-ascii?Q?tMd7zdr/XbAF/68L6qWcIlLF+V6NwC5/SfqVzrsTPMY+JT/0D4Coa4skUIv6?=
 =?us-ascii?Q?gNuD7Zdf11otsfM6cKrHyP1L2iBoeM7GixjlcatoOKoaLIrwYgEm6jMUOjRm?=
 =?us-ascii?Q?H32xZPRqutY89sR6+8T/RtK/kU6j+8fPZmtNBfwt+O8i3EfSjabLjkxtxBpy?=
 =?us-ascii?Q?MNu7XokRsfFLdu57i3BtBC/l0XK5/4FAXFyS76h9R+aYtURgkmWxKZhkbGCa?=
 =?us-ascii?Q?kE9pUaGPTTa36Bh9vY0UEDkLd3OEX4qTOx9V/bzgHzdsL98ZHx6y3gZB4zDA?=
 =?us-ascii?Q?vtutLDquhuc9XVK6com6DAkAUjdSNguGWiRuSDQe3SgS2OvzQEOw3GGKjsLm?=
 =?us-ascii?Q?mVrYKvTwR1+UnQMmWO4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 13:28:58.5457 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbe7d393-91b3-4c7c-533a-08de2cefc164
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8796
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

Move to emit_clk_levels from print_clk_levels

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 21 +++++++++----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index a3fc35b9011e..4e699d3ab1e3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1173,27 +1173,24 @@ static int smu_v13_0_7_upload_overdrive_table(struct smu_context *smu,
 	return ret;
 }
 
-static int smu_v13_0_7_print_clk_levels(struct smu_context *smu,
-					enum smu_clk_type clk_type,
-					char *buf)
+static int smu_v13_0_7_emit_clk_levels(struct smu_context *smu,
+				       enum smu_clk_type clk_type, char *buf,
+				       int *offset)
 {
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
 	struct smu_13_0_dpm_context *dpm_context = smu_dpm->dpm_context;
 	OverDriveTableExternal_t *od_table =
 		(OverDriveTableExternal_t *)smu->smu_table.overdrive_table;
+	int i, curr_freq, size = *offset, start_offset = *offset;
 	struct smu_13_0_dpm_table *single_dpm_table;
 	struct smu_13_0_pcie_table *pcie_table;
 	uint32_t gen_speed, lane_width;
-	int i, curr_freq, size = 0, start_offset = 0;
 	int32_t min_value, max_value;
 	int ret = 0;
 
-	smu_cmn_get_sysfs_buf(&buf, &size);
-	start_offset = size;
-
 	if (amdgpu_ras_intr_triggered()) {
-		size += sysfs_emit_at(buf, size, "unavailable\n");
-		return size - start_offset;
+		sysfs_emit_at(buf, size, "unavailable\n");
+		return -EBUSY;
 	}
 
 	switch (clk_type) {
@@ -1524,7 +1521,9 @@ static int smu_v13_0_7_print_clk_levels(struct smu_context *smu,
 		break;
 	}
 
-	return size - start_offset;
+	*offset += size - start_offset;
+
+	return 0;
 }
 
 static int smu_v13_0_7_od_restore_table_single(struct smu_context *smu, long input)
@@ -2830,7 +2829,7 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.get_vbios_bootup_values = smu_v13_0_get_vbios_bootup_values,
 	.read_sensor = smu_v13_0_7_read_sensor,
 	.feature_is_enabled = smu_cmn_feature_is_enabled,
-	.print_clk_levels = smu_v13_0_7_print_clk_levels,
+	.emit_clk_levels = smu_v13_0_7_emit_clk_levels,
 	.force_clk_levels = smu_v13_0_7_force_clk_levels,
 	.update_pcie_parameters = smu_v13_0_7_update_pcie_parameters,
 	.get_thermal_temperature_range = smu_v13_0_7_get_thermal_temperature_range,
-- 
2.49.0

