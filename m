Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B6EC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Nov 2021 07:43:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E6B56F38C;
	Tue, 30 Nov 2021 07:43:39 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8BAB6F37F
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Nov 2021 07:43:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q4iEvzE4txQGYpHs9gErR2Q8W0N6/Es/IQjlDSgQZCwF3ImyM5ZAq6wtKrL/3ncyey+yi3YVjnjaEZpVS11ovloz892eEJx8NPfIsGqYKwOsLGxbYehE8WY6x/yrKPyp0vV6fBlbdfrqBxwoZsi8hQjYQn6dlfaLEQ5Hnfo2Ra+jEdWmNn1B75XWmlVZAC5k5Lnw1HH4ZEAesWBMSM+Tj+uDhw8HbRsZuiz6nqNi11Be6hlKASQggN/2pV9sh4ZvVehJ6qM9vpskHX8C1MWbVg5tJaUJMgN9QdrV/h/eHnZrpUF/u0hw3B83PVP3IALUvW/ArxRs92PWejNeX6ZZcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65srdeqfxm6+oY4T8MGAWCK9ua7nvyyI9JpU038NKAQ=;
 b=UY0mlR3CbTM7jB8hwhudvzav2VcRXdHKL7Brs/mE332LHehj5XfJsbtvL9P2TZH17xzaYz70zNv5XEyjwFspNFZ4E9vTVl5DUPNt3Jm9PbRqZd7i5fhP2UyfF4npc0qAjz/L9gamznzBv1MoT5R05R1WVWiZIdFU5CLPWuNoRSC5e4jHCf3c8zqn2R99qCOZvZp0EIm30uCv+ykL8agwl2GqFH4SpbbczuADWTLQFXVcDZMKKtUSpowjv1w2ATzGxrY7dHO0u9CiqC2ZKW4hMFkUnn+3qaz+genVspKFdXm+aUwpntJtythk2P0oK+s5IkYElZ7Ui1y1kXFpD4J42g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65srdeqfxm6+oY4T8MGAWCK9ua7nvyyI9JpU038NKAQ=;
 b=smuhSsKs/l8/Sp+of9nlWIiNOFFdYXeGbLcgSUwNR75wVukkFHiVGjRNoMyRly1EMFzPsc7lVxqYDGJLgJH9nREVu0h9r5rWGJNmTsrjJLe4eNVq5wKBGeudx7FuFDOx6CTy7zC9s9skvzUF5GK6BPsUN4dU/eAyqLMutgp+KbQ=
Received: from BN6PR11CA0012.namprd11.prod.outlook.com (2603:10b6:405:2::22)
 by BL1PR12MB5285.namprd12.prod.outlook.com (2603:10b6:208:31f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 07:43:35 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:2:cafe::23) by BN6PR11CA0012.outlook.office365.com
 (2603:10b6:405:2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Tue, 30 Nov 2021 07:43:35 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 07:43:33 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 30 Nov
 2021 01:43:31 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 05/17] drm/amd/pm: do not expose those APIs used internally
 only in si_dpm.c
Date: Tue, 30 Nov 2021 15:42:47 +0800
Message-ID: <20211130074259.1271965-6-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211130074259.1271965-1-evan.quan@amd.com>
References: <20211130074259.1271965-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 397bf108-80b2-45b1-aae6-08d9b3d51cac
X-MS-TrafficTypeDiagnostic: BL1PR12MB5285:
X-Microsoft-Antispam-PRVS: <BL1PR12MB528536D78B15D3358FF5FC63E4679@BL1PR12MB5285.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tb/spqt68EwXaE2Sk+jCzbzrJLSzDAEFgSnXK1+BF9mYJALFbhctctKtCi1bw7ZHv5Y9oMAHBgoX/A5F18uslSx/SP8+3eg3cmzk6rhB685bVsBXGKC64e7BgRFFjNj/pXBji9sBbx33+ggQg8QZ/3BgefsWJRoiDBDPkXnksEX+5gxgvnYfU3ZicEx4AStZUL1bybxkxYxdYBRK5eyzdTCCL4DKsyMAPOF6vca0Xs3q6d2eXvFqBK/xah/AnXG2a3E88/l/tvffEgdVA9hlMQvhLjZ8YUnx2BQHTu6yMRafQuPE1jcJm7G6WK/9n2q1u4/Pe+ofOsS+SBtG6Wjd31W1Z78yg9KH+3KVJCFlLSkKXk2tj/GZq71WpEXw4tkTVMRwaWYO/RSF8y0YvPLkSUZkPk5/dIaOmM5eeSaVIe5l/UeJJx8oh/OpcDYmS0a29gPP+UhbfaUrYRRvD5ZI2HzQaDMwmxDd5ou9jEiL4g3upads5m9EIPuMW7+vZWFB6ZTyoXMRF1NTUF9sGFnZZTKzSC1tWGfbT85y9s+J/DyWBbPpkIQ3c2p+IeRpg/WxY1gWU8q94TCBENA/GUOK8W9U8EkCOWrc40G1vbH72Gj0OTihrZwGc5pB+l6KIyR84BqahocqlbEzyVyrxFU5DTSEGfweRfiobMrHvaYYiV3kw4PU7O50dQ9nWFa5090dAj8MzaKXLK0C02lINOgIQ6Ky+FmXhgGQu9ZOGl4ap8psMLCnxXp3hu3MgKpUvZPTP3RxznuzZEezP6BALguqOmC1FAdcJJxIAakpU6J368w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(2906002)(508600001)(356005)(26005)(81166007)(4326008)(70586007)(36860700001)(336012)(5660300002)(70206006)(186003)(16526019)(6666004)(82310400004)(1076003)(54906003)(316002)(63350400001)(426003)(8936002)(86362001)(47076005)(8676002)(36756003)(63370400001)(2616005)(7696005)(44832011)(83380400001)(40460700001)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 07:43:33.9690 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 397bf108-80b2-45b1-aae6-08d9b3d51cac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5285
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
Cc: Alexander.Deucher@amd.com, lijo.lazar@amd.com, Kenneth.Feng@amd.com,
 christian.koenig@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Move them to si_dpm.c instead.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I288205cfd7c6ba09cfb22626ff70360d61ff0c67
--
v1->v2:
  - rename the API with "si_" prefix(Alex)
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c       | 25 -----------
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h   | 25 -----------
 drivers/gpu/drm/amd/pm/powerplay/si_dpm.c | 54 +++++++++++++++++++----
 drivers/gpu/drm/amd/pm/powerplay/si_dpm.h |  7 +++
 4 files changed, 53 insertions(+), 58 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 52ac3c883a6e..fbfc07a83122 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -894,31 +894,6 @@ void amdgpu_add_thermal_controller(struct amdgpu_device *adev)
 	}
 }
 
-enum amdgpu_pcie_gen amdgpu_get_pcie_gen_support(struct amdgpu_device *adev,
-						 u32 sys_mask,
-						 enum amdgpu_pcie_gen asic_gen,
-						 enum amdgpu_pcie_gen default_gen)
-{
-	switch (asic_gen) {
-	case AMDGPU_PCIE_GEN1:
-		return AMDGPU_PCIE_GEN1;
-	case AMDGPU_PCIE_GEN2:
-		return AMDGPU_PCIE_GEN2;
-	case AMDGPU_PCIE_GEN3:
-		return AMDGPU_PCIE_GEN3;
-	default:
-		if ((sys_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3) &&
-		    (default_gen == AMDGPU_PCIE_GEN3))
-			return AMDGPU_PCIE_GEN3;
-		else if ((sys_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2) &&
-			 (default_gen == AMDGPU_PCIE_GEN2))
-			return AMDGPU_PCIE_GEN2;
-		else
-			return AMDGPU_PCIE_GEN1;
-	}
-	return AMDGPU_PCIE_GEN1;
-}
-
 struct amd_vce_state*
 amdgpu_get_vce_clock_state(void *handle, u32 idx)
 {
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 6681b878e75f..f43b96dfe9d8 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -45,19 +45,6 @@ enum amdgpu_int_thermal_type {
 	THERMAL_TYPE_KV,
 };
 
-enum amdgpu_dpm_auto_throttle_src {
-	AMDGPU_DPM_AUTO_THROTTLE_SRC_THERMAL,
-	AMDGPU_DPM_AUTO_THROTTLE_SRC_EXTERNAL
-};
-
-enum amdgpu_dpm_event_src {
-	AMDGPU_DPM_EVENT_SRC_ANALOG = 0,
-	AMDGPU_DPM_EVENT_SRC_EXTERNAL = 1,
-	AMDGPU_DPM_EVENT_SRC_DIGITAL = 2,
-	AMDGPU_DPM_EVENT_SRC_ANALOG_OR_EXTERNAL = 3,
-	AMDGPU_DPM_EVENT_SRC_DIGIAL_OR_EXTERNAL = 4
-};
-
 struct amdgpu_ps {
 	u32 caps; /* vbios flags */
 	u32 class; /* vbios flags */
@@ -252,13 +239,6 @@ struct amdgpu_dpm_fan {
 	bool ucode_fan_control;
 };
 
-enum amdgpu_pcie_gen {
-	AMDGPU_PCIE_GEN1 = 0,
-	AMDGPU_PCIE_GEN2 = 1,
-	AMDGPU_PCIE_GEN3 = 2,
-	AMDGPU_PCIE_GEN_INVALID = 0xffff
-};
-
 #define amdgpu_dpm_reset_power_profile_state(adev, request) \
 		((adev)->powerplay.pp_funcs->reset_power_profile_state(\
 			(adev)->powerplay.pp_handle, request))
@@ -403,11 +383,6 @@ void amdgpu_free_extended_power_table(struct amdgpu_device *adev);
 
 void amdgpu_add_thermal_controller(struct amdgpu_device *adev);
 
-enum amdgpu_pcie_gen amdgpu_get_pcie_gen_support(struct amdgpu_device *adev,
-						 u32 sys_mask,
-						 enum amdgpu_pcie_gen asic_gen,
-						 enum amdgpu_pcie_gen default_gen);
-
 struct amd_vce_state*
 amdgpu_get_vce_clock_state(void *handle, u32 idx);
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
index 81f82aa05ec2..4f84d8b893f1 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
@@ -96,6 +96,19 @@ union pplib_clock_info {
 	struct _ATOM_PPLIB_SI_CLOCK_INFO si;
 };
 
+enum amdgpu_dpm_auto_throttle_src {
+	AMDGPU_DPM_AUTO_THROTTLE_SRC_THERMAL,
+	AMDGPU_DPM_AUTO_THROTTLE_SRC_EXTERNAL
+};
+
+enum amdgpu_dpm_event_src {
+	AMDGPU_DPM_EVENT_SRC_ANALOG = 0,
+	AMDGPU_DPM_EVENT_SRC_EXTERNAL = 1,
+	AMDGPU_DPM_EVENT_SRC_DIGITAL = 2,
+	AMDGPU_DPM_EVENT_SRC_ANALOG_OR_EXTERNAL = 3,
+	AMDGPU_DPM_EVENT_SRC_DIGIAL_OR_EXTERNAL = 4
+};
+
 static const u32 r600_utc[R600_PM_NUMBER_OF_TC] =
 {
 	R600_UTC_DFLT_00,
@@ -4927,6 +4940,31 @@ static int si_populate_smc_initial_state(struct amdgpu_device *adev,
 	return 0;
 }
 
+static enum amdgpu_pcie_gen si_gen_pcie_gen_support(struct amdgpu_device *adev,
+						    u32 sys_mask,
+						    enum amdgpu_pcie_gen asic_gen,
+						    enum amdgpu_pcie_gen default_gen)
+{
+	switch (asic_gen) {
+	case AMDGPU_PCIE_GEN1:
+		return AMDGPU_PCIE_GEN1;
+	case AMDGPU_PCIE_GEN2:
+		return AMDGPU_PCIE_GEN2;
+	case AMDGPU_PCIE_GEN3:
+		return AMDGPU_PCIE_GEN3;
+	default:
+		if ((sys_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3) &&
+		    (default_gen == AMDGPU_PCIE_GEN3))
+			return AMDGPU_PCIE_GEN3;
+		else if ((sys_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2) &&
+			 (default_gen == AMDGPU_PCIE_GEN2))
+			return AMDGPU_PCIE_GEN2;
+		else
+			return AMDGPU_PCIE_GEN1;
+	}
+	return AMDGPU_PCIE_GEN1;
+}
+
 static int si_populate_smc_acpi_state(struct amdgpu_device *adev,
 				      SISLANDS_SMC_STATETABLE *table)
 {
@@ -4989,10 +5027,10 @@ static int si_populate_smc_acpi_state(struct amdgpu_device *adev,
 							      &table->ACPIState.level.std_vddc);
 		}
 		table->ACPIState.level.gen2PCIE =
-			(u8)amdgpu_get_pcie_gen_support(adev,
-							si_pi->sys_pcie_mask,
-							si_pi->boot_pcie_gen,
-							AMDGPU_PCIE_GEN1);
+			(u8)si_gen_pcie_gen_support(adev,
+						    si_pi->sys_pcie_mask,
+						    si_pi->boot_pcie_gen,
+						    AMDGPU_PCIE_GEN1);
 
 		if (si_pi->vddc_phase_shed_control)
 			si_populate_phase_shedding_value(adev,
@@ -7148,10 +7186,10 @@ static void si_parse_pplib_clock_info(struct amdgpu_device *adev,
 	pl->vddc = le16_to_cpu(clock_info->si.usVDDC);
 	pl->vddci = le16_to_cpu(clock_info->si.usVDDCI);
 	pl->flags = le32_to_cpu(clock_info->si.ulFlags);
-	pl->pcie_gen = amdgpu_get_pcie_gen_support(adev,
-						   si_pi->sys_pcie_mask,
-						   si_pi->boot_pcie_gen,
-						   clock_info->si.ucPCIEGen);
+	pl->pcie_gen = si_gen_pcie_gen_support(adev,
+					       si_pi->sys_pcie_mask,
+					       si_pi->boot_pcie_gen,
+					       clock_info->si.ucPCIEGen);
 
 	/* patch up vddc if necessary */
 	ret = si_get_leakage_voltage_from_leakage_index(adev, pl->vddc,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.h b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.h
index bc0be6818e21..8c267682eeef 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.h
@@ -595,6 +595,13 @@ struct rv7xx_power_info {
 	RV770_SMC_STATETABLE smc_statetable;
 };
 
+enum amdgpu_pcie_gen {
+	AMDGPU_PCIE_GEN1 = 0,
+	AMDGPU_PCIE_GEN2 = 1,
+	AMDGPU_PCIE_GEN3 = 2,
+	AMDGPU_PCIE_GEN_INVALID = 0xffff
+};
+
 struct rv7xx_pl {
 	u32 sclk;
 	u32 mclk;
-- 
2.29.0

