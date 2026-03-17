Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4813CFD708D
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 20:13:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D058510E63D;
	Tue, 17 Mar 2026 20:13:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e3TR8Y01";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011055.outbound.protection.outlook.com [52.101.57.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E46FB10E64A
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 20:13:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gx4RasXFKXbsQVQRDq+p4L/IfR2CT9obQ0fWMSxmYRNK3BOVDzMKGF406ZOJpKDFO2EJ2dgVPMnfEQM4n/qUbAlNl1zioWDO5QDt27YoRSmb4N8FCIu8NfMTpmJ7w2x8X0WVs0bM6waDhADJ8moV9KpsgHRxpTwAf+z57YBplI4uMzBpT/VR/IDO+1evtG1iYv15PsTK1x94MiphP3aAgegfsWO94Bp1BAo3cYCv+Ie2b44WIkRCgxyqmHDQmxol7KOcZ4JI9Up5Z/kLvhLPmaLIdADPoJh4GpWFIDn0U9gfZM1jXKkDI8x2+RfUUmGXjoSIYHStuqItcZPKnCx3fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2npkWYfZZKC8gypZopglQw5FfEs4qBc1tYCr6Z06wA=;
 b=fkGPXaa5Fh88g3EfI4k0x0ZUVychVD5eA3Qtv3zqBzKedElhUSf1cQBPju+Bb9D2jq4KvZ84SH5EgKMf3dx8LpNV1iRbumZ4960b1Yuer9p+GhQBE4Y0c1U1+krYlqXR7VYqgUXYFMuRSVAXd7ARcfOTgA7/QGzhX55XuVDd+ZpL7SdfNou/moi4HpZtcgWsYmaUesb5u5/0EiNVOcTnmCS9u1m2tkTgqnGKlvvvJf7uZLeaGvaN1ev2Z1klH0TXKQMPQYybl6PVkMq2lu6S4XSWIdkgr/vmYIgkDdE8Sm9pQ/Zb2HErbmMPK4ddkDVYqqe3PSuFTevAYoeQFM6GBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2npkWYfZZKC8gypZopglQw5FfEs4qBc1tYCr6Z06wA=;
 b=e3TR8Y01SIZRJnP2FfJwslddwMAnFruNewEh3ET7TRZsRoG+X9euqda1WqgE9a3FJHb/FiDDrXE9HjuYcslfwknkgtPilIDQntRTrtJN4sORG9PkHE9CnTEqwI1AbOK0WeUseYTxc4Kw6F5Mf6L4R/g9SPLacEAaSZg8CRXuNRg=
Received: from PH7PR17CA0008.namprd17.prod.outlook.com (2603:10b6:510:324::8)
 by IA1PR12MB8520.namprd12.prod.outlook.com (2603:10b6:208:44d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 20:13:21 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:510:324:cafe::ed) by PH7PR17CA0008.outlook.office365.com
 (2603:10b6:510:324::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 20:13:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 20:13:19 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 17 Mar
 2026 15:13:07 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Mar
 2026 15:13:07 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 17 Mar 2026 15:13:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Asad Kamal <asad.kamal@amd.com>, Yang Wang <kevinyang.wang@amd.com>, "Lijo
 Lazar" <lijo.lazar@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 18/25] drm/amd/pm: Add get_thermal_temperature_range support
Date: Tue, 17 Mar 2026 16:12:34 -0400
Message-ID: <20260317201242.3808136-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317201242.3808136-1-alexander.deucher@amd.com>
References: <20260317201242.3808136-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|IA1PR12MB8520:EE_
X-MS-Office365-Filtering-Correlation-Id: 48532023-8008-45ba-7441-08de8461a20c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 5ztrCR1P2JpgStYLJKwHW1PElN6GcbR0bKjT0LyXcrTavukHJc4jFgR/oqGYOPy8ynwAywFNOA7/7DYcIKjFJzs1MLapZWBAPCMoUw1ZUXkXJsllP10rQKDW/iVDF0pqgroOotVcQTLgl/qud0Srq8oaGS7jl7/zOWPH7DMljI527cxISuLMJwIq7Akl2KYDN0MBNoX/79jNWrD5LVZle56gKEKBeqvkt9dnzvqdLfpkny/tj97N59k9T2nGT8jlGctwGdvaQS67NrPTxGClPCt4/EA7+AHBkaGJGzdkK2HmQHl/p6xqTAZeEGrZz0u/Icaw+3Rd+y+h2lMkVqGNPhd3EH5leMJmWlXe0jMNazXLgvDPZOdAHPXHZPN5V0DKYkZ7VbJqznOcVCm6EoDkSD/adw9SUWIaIOmdBOZM5wtNP+ZR4zYj0aCqZuVHrete2VftoGhm0UtHN5UVRX4rh40NmnUmlfDAyxYdek1IPY4pWm8Ypll48WrLxsvXbguqyCN8tH0W8gndZgykPValxEsFCjlfotdoHsyreNEOe6gnUmzHNjRoix0WLiWJG+K72LfOBnvLBemIbON/LInc9zbZKee7YdPCZTJwpD3Nfmk+oYHyua7zcMfznKBiyFRvzXbL9iVNIeoEsuU8Ya0afxShzBhJouN+2BpAX/DZwoopSflwlytm5OgygjypezNYOZtbicncqNpTl5PXIUChjBtDxqY+Ozh6OJNvoi1zgyz8jUc1lJKusektWOVVGCtyxGe5Isfg6JKdSPBxT/deEA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4Gz7iftS7h/mY58mXPNjy0PyD4XukXf0ftO6WheVaqjRK+OTP9+7ltupUfCcfVjNnwL6EfyHBf6awOtsW2rmJkdxSzZJMy7uF3S3WHb16C5yJ6htU6Sa2K4QPeYZdtdN2h8ipiNa+FvzOiZQ76jWrdyBnnMlw27tiNFJdHfp7pUBrVvkOygYK8oTT4QzEVLRxaMCQDWhfSmIgkSklNyPjBjqDdW++WBgQyhdY2D9A61o7KCzJkS3duPb6pNUxB2ec9Z3LDWHKjjbWNpTbAw3IdyUgqWKxt89caPY+1ZlinZXo3ZH+cUtU9XCcElFU8xowENKgPfngsu+dGQzUNd7iHFEeS6QRebn1WPzw5EipxQaJxTIbQYnM/8/m7nERh2m3mnvbgrUAMcpTV2gchZZws67QaPRXFu/Cc70Ww1/4S2w0QxB/0Bhht/iqhXqYmQc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 20:13:19.7082 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48532023-8008-45ba-7441-08de8461a20c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8520
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

From: Asad Kamal <asad.kamal@amd.com>

Add get_thermal_temperature_range support smu_v15_0_8

v2: Remove sriov check (Lijo)

v3: Restrict to 1VF mode(Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index 04f16fd0633b6..7a5582253f5d4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -1683,6 +1683,38 @@ static int smu_v15_0_8_od_edit_dpm_table(struct smu_context *smu,
 	return 0;
 }
 
+static int smu_v15_0_8_get_thermal_temperature_range(struct smu_context *smu,
+						     struct smu_temperature_range *range)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	PPTable_t *pptable = (PPTable_t *)smu_table->driver_pptable;
+	uint32_t max_ctf, max_thm;
+
+	if (amdgpu_sriov_multi_vf_mode(smu->adev))
+		return 0;
+
+	if (!range)
+		return -EINVAL;
+
+	/* CTF (Critical Temperature Fault) limits */
+	max_ctf = max3(pptable->CTFLimitMID, pptable->CTFLimitXCD,
+		       pptable->CTFLimitAID);
+	range->hotspot_emergency_max = max_ctf * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+
+	range->mem_emergency_max = pptable->CTFLimitHBM *
+				   SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+
+	/* Thermal throttling limits */
+	max_thm = max3(pptable->ThermalLimitMID, pptable->ThermalLimitXCD,
+		       pptable->ThermalLimitAID);
+	range->hotspot_crit_max = max_thm * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+
+	range->mem_crit_max = pptable->ThermalLimitHBM *
+			      SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+
+	return 0;
+}
+
 static const struct pptable_funcs smu_v15_0_8_ppt_funcs = {
 	.init_allowed_features = smu_v15_0_8_init_allowed_features,
 	.set_default_dpm_table = smu_v15_0_8_set_default_dpm_table,
@@ -1714,6 +1746,7 @@ static const struct pptable_funcs smu_v15_0_8_ppt_funcs = {
 	.populate_umd_state_clk = smu_v15_0_8_populate_umd_state_clk,
 	.set_performance_level = smu_v15_0_8_set_performance_level,
 	.od_edit_dpm_table = smu_v15_0_8_od_edit_dpm_table,
+	.get_thermal_temperature_range = smu_v15_0_8_get_thermal_temperature_range,
 };
 
 static void smu_v15_0_8_init_msg_ctl(struct smu_context *smu,
-- 
2.53.0

