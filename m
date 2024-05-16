Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF43C25B78
	for <amd-gfx@archiver.kernel.org>; Thu, 16 May 2024 01:11:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5153710E227;
	Thu, 16 May 2024 01:11:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mdDhaFI0";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFB9A10E227
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 01:11:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3yTPA6sEgHHz6gTspSWr6EqLmVJGAEn/62TE0VzlEM9j+6yo+eY2esKi1MZzYdDDDzPB6Cv0Kb0vmIx5Gw8l/NSBeRlzVLJoF0s/LR6atpLZgzT2fC/2pgz+OFipu9p9TRTuYn/XaU4FC+0P5lnNB7UNMCj/UVJW94hACP+spz1xeQNJPjczADCokQZuvsnr/3mkhqfyu8aYa2AsOtfss48mirWESdTeaPdGC3BQ2Lf6IEblks55w0vTm66yXkyLw9aauT7LSh8WjFI/BXUfsnVY9L4QkF1WDYdWh3ZqtGLRg7kG8qVD+dnWZlAX5Sx8CJOaQvKtGRLT5cSgwnNYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihU/VFxmU7m6nz1zO4JuX5liEUYPl5JZ8Dxx6TbCZ24=;
 b=DRo4vETOJLEwCv+5N4zo0prFR2oiYTxxP+DaB8c/pm7iiGYcxpqbLuy/O0eD7rY6vX0LOMxT9VlCBzaRBFCVa9RAptIa9gQxYvwkJuUizLVuxhsjqGTQ7HHJQStyXaopM+wYiQY3LXCZoP116VUx7Xlx4naq40LNre1xFs/OyFBCXMOyIN8pEmS0rU6e9W+jBrwIqqeoRee8pv/A2ff2suSa71+bSahYvc7ZVReJj3baEducgfysUVKRLuVm7Nc9QcFRLExOF2MeWhlg8+NVk+P96RWSBJWAVGcGysu9sIw3XrIRqNG1GReDanCU3oTOFzKk4GkeGPGSqKtwUvG/Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihU/VFxmU7m6nz1zO4JuX5liEUYPl5JZ8Dxx6TbCZ24=;
 b=mdDhaFI0Unl2aH9+HPZzTrDDcYn7uFcK5RghCD8BcBVRSgHcEmj6ZzG284UGJFVvj4RKf4XYSHTS70KQ0wZK7ar2jk9DXT+Zwagys+QGZPn+/9K345ifuUjwUcgTGfoAxDgTMotqYQNFWKdcfMuhrKJh92J5e7VbsacZITjaKVY=
Received: from PH8PR02CA0006.namprd02.prod.outlook.com (2603:10b6:510:2d0::23)
 by SJ0PR12MB6855.namprd12.prod.outlook.com (2603:10b6:a03:47e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.26; Thu, 16 May
 2024 01:11:52 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:510:2d0:cafe::3a) by PH8PR02CA0006.outlook.office365.com
 (2603:10b6:510:2d0::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28 via Frontend
 Transport; Thu, 16 May 2024 01:11:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.211) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 01:11:51 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 15 May
 2024 20:11:46 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 15 May
 2024 20:11:46 -0500
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via
 Frontend Transport; Wed, 15 May 2024 20:11:45 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <likun.gao@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: enable thermal alert on smu 14.0.2/3
Date: Thu, 16 May 2024 09:11:23 +0800
Message-ID: <20240516011123.2112909-2-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240516011123.2112909-1-kenneth.feng@amd.com>
References: <20240516011123.2112909-1-kenneth.feng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: kenneth.feng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|SJ0PR12MB6855:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e9d3974-9237-4ca0-815e-08dc75452b58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?siXGloF0NHPmsjUijtj4DFzk1PIUvMtMYupJHF2mnjBhc94bHbq0QHPebZk9?=
 =?us-ascii?Q?XdekuoCAl0B7ojr9jWCOQ8wtCS0LrSOdyPVF8TecG337810odfDPIv3DLgZH?=
 =?us-ascii?Q?SnH4P/CzcDBm12+lIpH3A7t/T5oo9o5ZXkQQ4tDdgeNKEVxvgT8Im/GqpmFB?=
 =?us-ascii?Q?fxXgXfWftEiMdGau2gWoLNxr74dxnr/6wgme7/M9uLvMhilobd6fNFlprq4e?=
 =?us-ascii?Q?YFNMB6BAwYnoU7bXQJXmtf2DFGCjt6a1JAsYbRAq5/zdM+xGIZuyeCpmisUr?=
 =?us-ascii?Q?o7USkaUKzlNAHKkjYcwc9sk0TXQnXTxS6sw6aXQzMpi2m61GR5FKEjZz/CY6?=
 =?us-ascii?Q?O5F77dT2mngx9bAsxSnmjuQ4ocYLXlJ3LGfMsRzYxmpwOarofIjbXsImMeMh?=
 =?us-ascii?Q?7nx47EdyfqxI4dJ2XyWNmL+8sjrEvd9P1d7k2oS7wWMEZOIzUzUkBrPZdmRf?=
 =?us-ascii?Q?sBqC/x0bs4oNf42cK+f5NXJsKcqtbflNWP4cy3rnGh/ZVBBft0f4Kg6ERykW?=
 =?us-ascii?Q?RWuhEsSyxI2RT+bxlu2G6jUJkr+OR+qS4DpTQNHi3sSBf9uzklyM9NF51Vzj?=
 =?us-ascii?Q?DNL6Ktxl3iNaPwfCxmImdlCW384ILKOOTDKYNWHjoykVCm+TbyrSaAo4RDSk?=
 =?us-ascii?Q?M8frcBkzRvY4I16p3ESeLjJ5PQjv/yl1uohE3WIFG/feJ1N8fTeQhJ/3IPcx?=
 =?us-ascii?Q?S2+0di+ny9WwYqza2/pRUabblGUIC3cTMyTkk6OGEWLm0O03MfdKx48gBx4b?=
 =?us-ascii?Q?DYP+TxxTp6EnEivuvUDCTEPFHLfDL53OF4H8si/IQFwpwEz2Hf7jtFmUzlHC?=
 =?us-ascii?Q?UMXIB3AOtGQka5XXYSxozzU+UUkPsr08xDkGPh08g+IWjhK/BKd1SvcFdLgY?=
 =?us-ascii?Q?+nlHxS1Dfb9p/QfyRPX0tdfs0ReYXFQ08maxeDRqCP/uhnmxdNIw9znJ/Pnr?=
 =?us-ascii?Q?Vbv1m/mS4lHELnN/F8LlnpWIw9z11cd9hiYKWDuesfZqp4QIDlkGS7HHWFEI?=
 =?us-ascii?Q?Pfe3Cy8tmd//1ygu4B6AdI/gRgVWZ70KoDUjOPCpfSLnJoJ69xu0OPGUEThH?=
 =?us-ascii?Q?4ui4aAD+qWBrT2g0/hcoYsmPlu8+ahXoniJVERm00lOFmxiKkaW74/mn5Gq7?=
 =?us-ascii?Q?2FmuyGG6t8dto8mOGv+bPUrfD4LOzD1DlWLh4dnntjPvt/gRIDcoiDgeyXPA?=
 =?us-ascii?Q?ZZqwKFsecucK9WFyFKWOFSaOc6gd1l/7ehwhjFYkAskh2Gj3vEQo6b/BCTzu?=
 =?us-ascii?Q?p+HTMlvw3+/5oKpwk3QZgKlexyMyMUWuxXuM7zhnCHu+M46eBplNoKiy0izL?=
 =?us-ascii?Q?5pduLmKsCRQcRtv8Qf9QK9FWJP/Q9PHKn00wuhZ6fL/EtCBHrYObKjvbJLCB?=
 =?us-ascii?Q?/rN9+5y5Z8Qgun9kogDuq9krIVG7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 01:11:51.9087 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e9d3974-9237-4ca0-815e-08dc75452b58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6855
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

enable thermal alert on smu 14.0.2/3

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h  |  8 +++
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    | 68 ++++++++++++++++++-
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 35 +++++++++-
 3 files changed, 108 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
index 3d34b3869df6..9b97a4e95c0f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
@@ -48,6 +48,10 @@
 
 #define SMU14_TOOL_SIZE			0x19000
 
+#define CTF_OFFSET_EDGE			5
+#define CTF_OFFSET_HOTSPOT		5
+#define CTF_OFFSET_MEM			5
+
 extern const int decoded_link_speed[5];
 extern const int decoded_link_width[7];
 
@@ -236,5 +240,9 @@ int smu_v14_0_od_edit_dpm_table(struct smu_context *smu,
 
 void smu_v14_0_set_smu_mailbox_registers(struct smu_context *smu);
 
+int smu_v14_0_enable_thermal_alert(struct smu_context *smu);
+
+int smu_v14_0_disable_thermal_alert(struct smu_context *smu);
+
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index fbfe9cae0e05..8cce17d1f230 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -38,6 +38,8 @@
 #include "amdgpu_ras.h"
 #include "smu_cmn.h"
 
+#include "asic_reg/thm/thm_14_0_2_offset.h"
+#include "asic_reg/thm/thm_14_0_2_sh_mask.h"
 #include "asic_reg/mp/mp_14_0_2_offset.h"
 #include "asic_reg/mp/mp_14_0_2_sh_mask.h"
 
@@ -853,12 +855,19 @@ static int smu_v14_0_set_irq_state(struct amdgpu_device *adev,
 				   unsigned tyep,
 				   enum amdgpu_interrupt_state state)
 {
+	struct smu_context *smu = adev->powerplay.pp_handle;
+	uint32_t low, high;
 	uint32_t val = 0;
 
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
 		/* For THM irqs */
-		// TODO
+		val = RREG32_SOC15(THM, 0, regTHM_THERMAL_INT_CTRL);
+		val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_INTH_MASK, 1);
+		val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_INTL_MASK, 1);
+		WREG32_SOC15(THM, 0, regTHM_THERMAL_INT_CTRL, val);
+
+		WREG32_SOC15(THM, 0, regTHM_THERMAL_INT_ENA, 0);
 
 		/* For MP1 SW irqs */
 		if (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 0) ||
@@ -875,7 +884,24 @@ static int smu_v14_0_set_irq_state(struct amdgpu_device *adev,
 		break;
 	case AMDGPU_IRQ_STATE_ENABLE:
 		/* For THM irqs */
-		// TODO
+		low = max(SMU_THERMAL_MINIMUM_ALERT_TEMP,
+			  smu->thermal_range.min / SMU_TEMPERATURE_UNITS_PER_CENTIGRADES);
+		high = min(SMU_THERMAL_MAXIMUM_ALERT_TEMP,
+			   smu->thermal_range.software_shutdown_temp);
+		val = RREG32_SOC15(THM, 0, regTHM_THERMAL_INT_CTRL);
+		val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, MAX_IH_CREDIT, 5);
+		val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_IH_HW_ENA, 1);
+		val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_INTH_MASK, 0);
+		val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_INTL_MASK, 0);
+		val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTH, (high & 0xff));
+		val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTL, (low & 0xff));
+		val = val & (~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK);
+		WREG32_SOC15(THM, 0, regTHM_THERMAL_INT_CTRL, val);
+
+		val = (1 << THM_THERMAL_INT_ENA__THERM_INTH_CLR__SHIFT);
+		val |= (1 << THM_THERMAL_INT_ENA__THERM_INTL_CLR__SHIFT);
+		val |= (1 << THM_THERMAL_INT_ENA__THERM_TRIGGER_CLR__SHIFT);
+		WREG32_SOC15(THM, 0, regTHM_THERMAL_INT_ENA, val);
 
 		/* For MP1 SW irqs */
 		if (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 0) ||
@@ -1849,3 +1875,41 @@ int smu_v14_0_od_edit_dpm_table(struct smu_context *smu,
 	return ret;
 }
 
+static int smu_v14_0_allow_ih_interrupt(struct smu_context *smu)
+{
+	return smu_cmn_send_smc_msg(smu,
+				    SMU_MSG_AllowIHHostInterrupt,
+				    NULL);
+}
+
+static int smu_v14_0_process_pending_interrupt(struct smu_context *smu)
+{
+	int ret = 0;
+
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_ACDC_BIT))
+		ret = smu_v14_0_allow_ih_interrupt(smu);
+
+	return ret;
+}
+
+int smu_v14_0_enable_thermal_alert(struct smu_context *smu)
+{
+	int ret = 0;
+
+	if (!smu->irq_source.num_types)
+		return 0;
+
+	ret = amdgpu_irq_get(smu->adev, &smu->irq_source, 0);
+	if (ret)
+		return ret;
+
+	return smu_v14_0_process_pending_interrupt(smu);
+}
+
+int smu_v14_0_disable_thermal_alert(struct smu_context *smu)
+{
+	if (!smu->irq_source.num_types)
+		return 0;
+
+	return amdgpu_irq_put(smu->adev, &smu->irq_source, 0);
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 1fbceb85d319..2b874e1ba4ea 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1276,10 +1276,41 @@ static int smu_v14_0_2_update_pcie_parameters(struct smu_context *smu,
 	return 0;
 }
 
+static const struct smu_temperature_range smu14_thermal_policy[] = {
+	{-273150,  99000, 99000, -273150, 99000, 99000, -273150, 99000, 99000},
+	{ 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000},
+};
+
 static int smu_v14_0_2_get_thermal_temperature_range(struct smu_context *smu,
 						     struct smu_temperature_range *range)
 {
-	// TODO
+	struct smu_table_context *table_context = &smu->smu_table;
+	struct smu_14_0_2_powerplay_table *powerplay_table =
+		table_context->power_play_table;
+	PPTable_t *pptable = smu->smu_table.driver_pptable;
+
+	if (amdgpu_sriov_vf(smu->adev))
+		return 0;
+
+	if (!range)
+		return -EINVAL;
+
+	memcpy(range, &smu14_thermal_policy[0], sizeof(struct smu_temperature_range));
+
+	range->max = pptable->CustomSkuTable.TemperatureLimit[TEMP_EDGE] *
+		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+	range->edge_emergency_max = (pptable->CustomSkuTable.TemperatureLimit[TEMP_EDGE] + CTF_OFFSET_EDGE) *
+		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+	range->hotspot_crit_max = pptable->CustomSkuTable.TemperatureLimit[TEMP_HOTSPOT] *
+		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+	range->hotspot_emergency_max = (pptable->CustomSkuTable.TemperatureLimit[TEMP_HOTSPOT] + CTF_OFFSET_HOTSPOT) *
+		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+	range->mem_crit_max = pptable->CustomSkuTable.TemperatureLimit[TEMP_MEM] *
+		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+	range->mem_emergency_max = (pptable->CustomSkuTable.TemperatureLimit[TEMP_MEM] + CTF_OFFSET_MEM)*
+		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+	range->software_shutdown_temp = powerplay_table->software_shutdown_temp;
+	range->software_shutdown_temp_offset = pptable->CustomSkuTable.FanAbnormalTempLimitOffset;
 
 	return 0;
 }
@@ -1866,6 +1897,8 @@ static const struct pptable_funcs smu_v14_0_2_ppt_funcs = {
 	.update_pcie_parameters = smu_v14_0_2_update_pcie_parameters,
 	.get_thermal_temperature_range = smu_v14_0_2_get_thermal_temperature_range,
 	.register_irq_handler = smu_v14_0_register_irq_handler,
+	.enable_thermal_alert = smu_v14_0_enable_thermal_alert,
+	.disable_thermal_alert = smu_v14_0_disable_thermal_alert,
 	.notify_memory_pool_location = smu_v14_0_notify_memory_pool_location,
 	.set_soft_freq_limited_range = smu_v14_0_set_soft_freq_limited_range,
 	.init_pptable_microcode = smu_v14_0_init_pptable_microcode,
-- 
2.34.1

