Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8DB9D10F4F
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 13:28:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E18D10E5F4;
	Wed, 26 Nov 2025 13:28:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X/8t/kZC";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013054.outbound.protection.outlook.com
 [40.93.201.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 882E710E2B7
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 13:28:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d1+lrmB/fYCfvFJEtjQtx1LpsN5KyOttz+ktS1KyLOKF3HLT+IRCBoC4xWmQ33Q6v7KMR/BAe4S4rztkP3prqxjGg1/Cp5TuXoQztpUGal4/0P4D5t4KXzDHUcaRm5CPWq05YNNa5lg17A4tYnstL7Nsepnq04ZLjV42hN9eC02wDkuqECLcQkODKMm2j01vTjT+WRNcJI040/E1LT5YmzG8VJ8k4gm99xVE+UlcgztHWmlFYUtbe29LgIiXIsQTwyPg4drj0DEZJb2twEMSk9i4aTNFi6n2qrsIoE/eyIJq5etyAed3DfI3BfV/IQvz7q7nHVVafLFZAr4ol+AqVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llgit0zGEKCm040U59LgE3QV0Tg1+uj3qgV11s0jvEA=;
 b=k6MLsCuRsehBBaWgpvGAMQI1Zor2gE353OhYE2jedmPVBz7B00q1pUEDHJFo9f3bt2HjEkkcwGfShS63NP6LvbMBkm5XcBn33K8lQLENqy6OMzgwlmsOeEfDP+raKwSaC5YjvJos1hSASmpIMlKPE8ewIH5AGhm4gCVBbnJj+TE6T2qVcSOEMMIUkMu0N3tyzZCnNr7DLF2xNvVFWVrq7CZHzNeCHGONxJnQU+QH7oaT46E0mjKGCfn4HCxfP5Uki3cPtEKTq73Re9xnsLfXrYc9A8PcfLOwLghQpy0tjQzrvUVTGsFKVnF/x2i9mneLmM/HT5zUQZZ0slQHGpn0Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=llgit0zGEKCm040U59LgE3QV0Tg1+uj3qgV11s0jvEA=;
 b=X/8t/kZCXqJQGNwB0odXHU6jt3cbk+UrFVyxumlAtJ6oYgl5hykeP959JOYejRFe7uYII/YyjOv6dFolsnG0eSfcCCyaYpm8lNmQF77+hEzKAXX1U38wrLtcf62PBGn7OcAVE0R1bcHGu7xZQcR+Sv9BWgrZnIopROeBUxuPBIk=
Received: from SJ0PR03CA0233.namprd03.prod.outlook.com (2603:10b6:a03:39f::28)
 by BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 13:28:45 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::e5) by SJ0PR03CA0233.outlook.office365.com
 (2603:10b6:a03:39f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.18 via Frontend Transport; Wed,
 26 Nov 2025 13:28:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 13:28:45 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 26 Nov
 2025 07:28:43 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Jesse.Zhang@amd.com>
Subject: [PATCH 02/20] drm/amd/pm: Use emit_clk_levels in sienna_cichild
Date: Wed, 26 Nov 2025 18:53:49 +0530
Message-ID: <20251126132822.3266730-3-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|BL3PR12MB9049:EE_
X-MS-Office365-Filtering-Correlation-Id: fa0412bc-8a18-4904-d5ce-08de2cefb956
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TGAGu0m0dXh4m936kOuOfCfcsduBkZeNXgFpOukFN/KF+1E9Jd5B/0hFhVCH?=
 =?us-ascii?Q?Pat4OqBiZ6PZHj/evC4rudXcqPou/PRzkVfDeTGWuQ664R0GHidADTpwxfKQ?=
 =?us-ascii?Q?JHqAUgwxK5sSN1oKPTfnYSNvhcO3nloJCoeMe/mnTFf3ERNry6VlmrlZm28H?=
 =?us-ascii?Q?oGT0d57lnASfw5+XrppOvIP6Jv6oGu82H/zzoKsbOJiJkoUME3Ek7hGcdYOD?=
 =?us-ascii?Q?9oW2iJOLGrfFIYROg/V4fHVDwtsZh4qnP8zAL8xgtjc17qEtbOh5RKiBmTqZ?=
 =?us-ascii?Q?TorlkPqFr6iqBRRqUoUOH+8vYqCxsT8I7dSnB5KxhnsPBMBNO2I+PkPgWnR9?=
 =?us-ascii?Q?uXy5Y9FZHG5OFcIAVZgduA6ad1/jVOaSpDjrFK1cVaqpbgkgPEIGbtbld/de?=
 =?us-ascii?Q?UPPZUgZd7TNnjIOBN2AfWm9jQgNoXFRMVnqTEXnAhZrMK/armFi6Jt2dRM6y?=
 =?us-ascii?Q?VFJAzCT9/tJq7nTpme/DnMVFaaeYVhm3+AoP37QDpz0kwWDW1gv1IiHhGZPD?=
 =?us-ascii?Q?9b9JhrDItbPvGWYEWV30ZL1gOcj5vGBRphS5IN1TXceYNJ06uN74xjN7rWAD?=
 =?us-ascii?Q?uNqD9Yji99AOtWR7FuQAO6OAbk0lugr77hLPUqDkfcU+AtXmyzmstK49TOeb?=
 =?us-ascii?Q?veVBDC125ntBlb/vzXWwRZtsblu0vBejIyvWoLllWFd4tEWiLjLMNOJApRK5?=
 =?us-ascii?Q?0J5SFwPkJjnEgkJjOswxEhj3W6PQS5IYesmqh3q+FXI8aBuW1S/Ru+PoUWKL?=
 =?us-ascii?Q?pTr8Ioh7GK1alIRGRIlIgEp4sdtairaPZi2CDiCjFPYFIL5d4WNAmfLCfmH9?=
 =?us-ascii?Q?fkqu+qLa/U/RGKvO8PtsosAGDei6S6Y5K0uXa9GFEyFQsNWW6Lce96RbsRVZ?=
 =?us-ascii?Q?11zSibSOlxuuzz5PdKazZj4Ewl6TY0ve7q9Og5+FsMJhnFUhG/rDvXzLel0w?=
 =?us-ascii?Q?IKQulG1SG9saAI2FQU0cAyaE5Ol949Ba90nVFGAZwVKXtP9h8yacJQyQ+6JE?=
 =?us-ascii?Q?E4B+8hKqjm/L8UxnTE0xFZqsVYjaTaeplBogT22puTs0mF2AoEJ6KIWIGHBE?=
 =?us-ascii?Q?/cAhlv+gRYDtt2Lfn20DlDfx7ZY9scYt4qiwvYiXaxolzGuYnYi+N+aJqwJ/?=
 =?us-ascii?Q?gmD5N/YQFIFkkq8Xl2/sWK7eCdxohNMacQUiOYX7zFu8EmsASLYoxKXFkDHU?=
 =?us-ascii?Q?ki4q0+KmZ6TH4TeazbQUkLN0qQvD8nyUd11k2KP27vqugS/2gQxyCGt03H0h?=
 =?us-ascii?Q?T1JTWAflS3R9ZIXuEl/A659FEN12SNXhJ1q1HDx5O0vFpDmfaJ0hDBtb2ceV?=
 =?us-ascii?Q?Gevzn0FsUlZya/AXhb4rWGGP607X9g3OL0xf7YSKhlCom5ZkQ8rReCMMuQgl?=
 =?us-ascii?Q?UkARQG1Qeh/oP5uwrgcb03wIy0L6nyOzwGnLqjTsyFYBsE2W7b8NGrieMLl1?=
 =?us-ascii?Q?A2ZXJVnzVnxfPi8XLe8vCLzwd0AyfuJjfI02AA/BoT/TalWTgngziUONI7z0?=
 =?us-ascii?Q?igPomI2i6rsl2VelHABtfV5UgKPVUGmQ7rVf3Y0a4j4Dey4DElAkTeqhOj1r?=
 =?us-ascii?Q?WY4F4or7DOPu/x4FiCA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 13:28:45.0103 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa0412bc-8a18-4904-d5ce-08de2cefb956
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9049
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
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 27 +++++++++----------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 774283ac7827..1530a25f7237 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1269,8 +1269,9 @@ static void sienna_cichlid_get_od_setting_range(struct smu_11_0_7_overdrive_tabl
 		*max = od_table->max[setting];
 }
 
-static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
-			enum smu_clk_type clk_type, char *buf)
+static int sienna_cichlid_emit_clk_levels(struct smu_context *smu,
+					  enum smu_clk_type clk_type, char *buf,
+					  int *offset)
 {
 	struct amdgpu_device *adev = smu->adev;
 	struct smu_table_context *table_context = &smu->smu_table;
@@ -1281,16 +1282,13 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 	struct smu_11_0_7_overdrive_table *od_settings = smu->od_settings;
 	OverDriveTable_t *od_table =
 		(OverDriveTable_t *)table_context->overdrive_table;
-	int i, size = 0, ret = 0, start_offset = 0;
+	int i, size = *offset, ret = 0, start_offset = *offset;
 	uint32_t cur_value = 0, value = 0, count = 0;
 	uint32_t freq_values[3] = {0};
 	uint32_t mark_index = 0;
 	uint32_t gen_speed, lane_width;
 	uint32_t min_value, max_value;
 
-	smu_cmn_get_sysfs_buf(&buf, &size);
-	start_offset = size;
-
 	switch (clk_type) {
 	case SMU_GFXCLK:
 	case SMU_SCLK:
@@ -1305,17 +1303,17 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 	case SMU_DCEFCLK:
 		ret = sienna_cichlid_get_current_clk_freq_by_table(smu, clk_type, &cur_value);
 		if (ret)
-			goto print_clk_out;
+			return ret;
 
 		ret = smu_v11_0_get_dpm_level_count(smu, clk_type, &count);
 		if (ret)
-			goto print_clk_out;
+			return ret;
 
 		if (!sienna_cichlid_is_support_fine_grained_dpm(smu, clk_type)) {
 			for (i = 0; i < count; i++) {
 				ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, i, &value);
 				if (ret)
-					goto print_clk_out;
+					return ret;
 
 				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, value,
 						cur_value == value ? "*" : "");
@@ -1323,10 +1321,10 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 		} else {
 			ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, 0, &freq_values[0]);
 			if (ret)
-				goto print_clk_out;
+				return ret;
 			ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, count - 1, &freq_values[2]);
 			if (ret)
-				goto print_clk_out;
+				return ret;
 
 			freq_values[1] = cur_value;
 			mark_index = cur_value == freq_values[0] ? 0 :
@@ -1434,8 +1432,9 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 		break;
 	}
 
-print_clk_out:
-	return size - start_offset;
+	*offset += size - start_offset;
+
+	return 0;
 }
 
 static int sienna_cichlid_force_clk_levels(struct smu_context *smu,
@@ -3129,7 +3128,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.dpm_set_jpeg_enable = sienna_cichlid_dpm_set_jpeg_enable,
 	.i2c_init = sienna_cichlid_i2c_control_init,
 	.i2c_fini = sienna_cichlid_i2c_control_fini,
-	.print_clk_levels = sienna_cichlid_print_clk_levels,
+	.emit_clk_levels = sienna_cichlid_emit_clk_levels,
 	.force_clk_levels = sienna_cichlid_force_clk_levels,
 	.populate_umd_state_clk = sienna_cichlid_populate_umd_state_clk,
 	.pre_display_config_changed = sienna_cichlid_pre_display_config_changed,
-- 
2.49.0

