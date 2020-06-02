Return-Path: <SRS0=q3BR=7P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A178C433E3
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 09:09:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E71DE20734
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 09:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eVB7hVWo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E71DE20734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A224B89BE8;
	Tue,  2 Jun 2020 09:09:10 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31A4189BBE
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2020 09:09:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BbGB45fuyW3BmHsT8XrOso3j/61pcAKf7gg7jltoih+1eZsAa/U8hn/XoBKq+Ehjwin4ZkdcNtNbhu52cF97/jWyVgpVS2jlXyGtDEeiFsvR5lPiJcpBonQEgM3UiuEIiS0mq6s+QHjIViOuszS3MM5SrTFbrJxO5gKAvTkT6n1z3VDW3PimOsL8aehSRtc9017F4X/WsWQYwPrSepH6gBcKh/sOABaiitfG0KhLaZE1lVFWOdRINFVtV4J+n4vxWxoVSzjy334KtaPv/dgRRwAGi9la7IvoAQCoAm5OWcTocIQHDUutzCs/hqX42oMcMoL5GCJjkW9uTXdXvwrUbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vb5fMj2pV4zmcIXYxLWoQJAuVMdQAF0OOFYNpCOrNQQ=;
 b=Lr6j06JorWbhc+2uvf+8yd/vEp4ePirq5Q4RM7zzgjVBWZyvEC3IxT3nAFg8LPeiHnaUnFYjwp0qlU+bPGaEwWeQnfkKQuJpgwVTvi0COSF3fByzqhf8Bgw/IHWPkc4V4jHAHq9kKmzKApUTFPxnMegy7dEIYkoYkihgI9Nf1nlBtFlV86EmSKSOHIuraroOhppuRgF1V7F++3aNHvSsfLiuYLxE3svfD4jEJRcZ4RaLcPATwVCYz+PtRjP9bcVZ6uqD4T1Hhq5vjXt0vFu52NMrPDgzvWmjHEB5ZgduqkU/CIwHF4GLO4+iDLk0xuTRpMEeANS8x6NqDd5VRd6iWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vb5fMj2pV4zmcIXYxLWoQJAuVMdQAF0OOFYNpCOrNQQ=;
 b=eVB7hVWojSyL/DXYXn//b5ZGWXmIYhlUauhkR79fNSYdfeXNX8kSewarKzQyrBDrZfhKmHP41+ZLoUFFejDcS0yqJ3DPQ+ZUA4YkzGf6tbzObGWSKDj9uqSRzHtPKszMXZyLzaSJOqZaxNFwMpYWeXQ4TrP07S1bTkLdTgBpEOM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0136.namprd12.prod.outlook.com
 (2603:10b6:910:1a::19) by CY4PR1201MB2501.namprd12.prod.outlook.com
 (2603:10b6:903:d3::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.22; Tue, 2 Jun
 2020 09:09:07 +0000
Received: from CY4PR1201MB0136.namprd12.prod.outlook.com
 ([fe80::b1bf:dda1:dd1e:8e30]) by CY4PR1201MB0136.namprd12.prod.outlook.com
 ([fe80::b1bf:dda1:dd1e:8e30%5]) with mapi id 15.20.3066.018; Tue, 2 Jun 2020
 09:09:06 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: move powerplay table operation out of
 smu_v11_0.c
Date: Tue,  2 Jun 2020 17:08:40 +0800
Message-Id: <20200602090840.3318819-1-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: HK2PR04CA0052.apcprd04.prod.outlook.com
 (2603:1096:202:14::20) To CY4PR1201MB0136.namprd12.prod.outlook.com
 (2603:10b6:910:1a::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lnx-glk.amd.com (58.247.170.242) by
 HK2PR04CA0052.apcprd04.prod.outlook.com (2603:1096:202:14::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.22 via Frontend Transport; Tue, 2 Jun 2020 09:09:04 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 20c35ffa-1323-4488-6f05-08d806d49a2d
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2501:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB25011D2E48DFC5E4899B3B36EF8B0@CY4PR1201MB2501.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-Forefront-PRVS: 0422860ED4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZusG74BwhujWxDHj7h907p/FlzHnsrgXFyeeXG6u/XD6pc6nf45GPYym8P5We+VzJmZiK6dZlrn0ZekPZJESdqIaKjoUKvf4oP+Li9wGNpjkxzWAciH/SP+qfuzCvNFmLMjGApwo1Dn9snQVaj62IgUIpj3yIeN1OS/bgwn+CDx0qK8xWW+Bhzrvlv5hVfIWT2JuCk4m42jDmtOvjJiyUI5m6dOaXM1jlgIQqoRs5G4HEwNjm2l6+oCb1Hi9BAJ9o8LoPQkzS0D6+G3sYFli07hOXq9oT/SfXTeoMAZczZDSc3lpRbCvrVWewx6f5A9e
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR1201MB0136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(36756003)(186003)(4326008)(66946007)(66556008)(54906003)(5660300002)(66476007)(2906002)(52116002)(8936002)(7696005)(16526019)(6916009)(316002)(30864003)(6666004)(26005)(956004)(2616005)(66574014)(6486002)(478600001)(8676002)(1076003)(86362001)(83380400001)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: RWmrBueTLneuRjJCzJo4LmxHxKEQwRRbE07xwRTvxRZYXXd4mjDHz/OUa9TC1hlm0JHIccpl4Jn9w9HDn0UP0LabUbGG3xnCNBLLTwSMy6J8JbDs40IjXBTEs2XrSHgefQWEiOaaBP2/7hoQmyqmpPo08HticXbhcaerk81++PpMWwTVE7WHwD69o9EVKQG4QLKtx1BhxPUl53It23eytdEXtZ6+xjghU7r+LBwMUdZi3r9rFb9h+9LEA7eMYDsM1GKKGA7FXMYnzd3xfMj21pNB4SiXyF8XteV3mA3OheZswc2uuoBdkbkLXQnByiCphjRK6RgGA3fqCZLyzAtxkeZUZC86MFf3xJX4+gAalbqhAlwjJAZD6mfLgGxncYEWkvt/osWZqsoUduSQrp2j0nOVIZko3fUU98ccKEU8TbZT8oITEWcNu3zvDdKk9GCTZwiGHwOrjGwJKesOIuWdy1b5DHvJxPm2FTw06oJSnYFeI9xYzoXac4caefTdzjKf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c35ffa-1323-4488-6f05-08d806d49a2d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2020 09:09:06.7824 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aKKAstZO9A5h6P5sanbTFnVuVaFIp427Ytn4Dfi4hpsQ813FOAGie7dQrCWTuhTY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2501
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
Cc: Likun Gao <Likun.Gao@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 Kenneth Feng <Kenneth.Feng@amd.com>, Kevin Wang <Kevin1.Wang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

move smu_v11_0_get_max_power_limit and smu_v11_0_set_thermal_range
function from smu_v11_0.c to asic specific _ppt.c to avoid powerplay
table conflict with different ASIC with smu11.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: I194f44e9f59daf19fa4758ed746fa13ccece4308
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  | 64 ++++++++++++++++++-
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  2 +
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |  2 -
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    | 64 ++++++++++++++++++-
 drivers/gpu/drm/amd/powerplay/smu_internal.h  |  5 ++
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 63 +-----------------
 6 files changed, 135 insertions(+), 65 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 1c66b7d7139c..d5527e834a8e 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -37,6 +37,8 @@
 #include "arcturus_ppsmc.h"
 #include "nbio/nbio_7_4_offset.h"
 #include "nbio/nbio_7_4_sh_mask.h"
+#include "thm/thm_11_0_2_offset.h"
+#include "thm/thm_11_0_2_sh_mask.h"
 #include "amdgpu_xgmi.h"
 #include <linux/i2c.h>
 #include <linux/pci.h>
@@ -1324,7 +1326,7 @@ static int arcturus_get_power_limit(struct smu_context *smu,
 	}
 
 	if (cap)
-		*limit = smu_v11_0_get_max_power_limit(smu);
+		*limit = smu_get_max_power_limit(smu);
 	else
 		*limit = smu->power_limit;
 
@@ -2286,6 +2288,64 @@ static int arcturus_set_df_cstate(struct smu_context *smu,
 	return smu_send_smc_msg_with_param(smu, SMU_MSG_DFCstateControl, state, NULL);
 }
 
+static int arcturus_set_thermal_range(struct smu_context *smu,
+				       struct smu_temperature_range range)
+{
+	struct amdgpu_device *adev = smu->adev;
+	int low = SMU_THERMAL_MINIMUM_ALERT_TEMP;
+	int high = SMU_THERMAL_MAXIMUM_ALERT_TEMP;
+	uint32_t val;
+	struct smu_table_context *table_context = &smu->smu_table;
+	struct smu_11_0_powerplay_table *powerplay_table = table_context->power_play_table;
+
+	low = max(SMU_THERMAL_MINIMUM_ALERT_TEMP,
+			range.min / SMU_TEMPERATURE_UNITS_PER_CENTIGRADES);
+	high = min((uint16_t)SMU_THERMAL_MAXIMUM_ALERT_TEMP, powerplay_table->software_shutdown_temp);
+
+	if (low > high)
+		return -EINVAL;
+
+	val = RREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_CTRL);
+	val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, MAX_IH_CREDIT, 5);
+	val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_IH_HW_ENA, 1);
+	val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_INTH_MASK, 0);
+	val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_INTL_MASK, 0);
+	val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTH, (high & 0xff));
+	val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTL, (low & 0xff));
+	val = val & (~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK);
+
+	WREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_CTRL, val);
+
+	return 0;
+}
+
+static uint32_t atcturus_get_max_power_limit(struct smu_context *smu) {
+	uint32_t od_limit, max_power_limit;
+	struct smu_11_0_powerplay_table *powerplay_table = NULL;
+	struct smu_table_context *table_context = &smu->smu_table;
+	powerplay_table = table_context->power_play_table;
+
+	max_power_limit = smu_get_pptable_power_limit(smu);
+
+	if (!max_power_limit) {
+		// If we couldn't get the table limit, fall back on first-read value
+		if (!smu->default_power_limit)
+			smu->default_power_limit = smu->power_limit;
+		max_power_limit = smu->default_power_limit;
+	}
+
+	if (smu->od_enabled) {
+		od_limit = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+
+		pr_debug("ODSETTING_POWERPERCENTAGE: %d (default: %d)\n", od_limit, smu->default_power_limit);
+
+		max_power_limit *= (100 + od_limit);
+		max_power_limit /= 100;
+	}
+
+	return max_power_limit;
+}
+
 static const struct pptable_funcs arcturus_ppt_funcs = {
 	/* translate smu index into arcturus specific index */
 	.get_smu_msg_index = arcturus_get_smu_msg_index,
@@ -2379,6 +2439,8 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.override_pcie_parameters = smu_v11_0_override_pcie_parameters,
 	.get_pptable_power_limit = arcturus_get_pptable_power_limit,
 	.set_df_cstate = arcturus_set_df_cstate,
+	.set_thermal_range = arcturus_set_thermal_range,
+	.get_max_power_limit = atcturus_get_max_power_limit,
 };
 
 void arcturus_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 928eed220f93..0453482fb748 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -574,6 +574,8 @@ struct pptable_funcs {
 	uint32_t (*get_pptable_power_limit)(struct smu_context *smu);
 	int (*disable_umc_cdr_12gbps_workaround)(struct smu_context *smu);
 	int (*set_power_source)(struct smu_context *smu, enum smu_power_src_type power_src);
+	int (*set_thermal_range)(struct smu_context *smu, struct smu_temperature_range range);
+	uint32_t (*get_max_power_limit)(struct smu_context *smu);
 };
 
 int smu_load_microcode(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index 1f5830bbcc3e..4ad3f07891fe 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -262,8 +262,6 @@ int smu_v11_0_override_pcie_parameters(struct smu_context *smu);
 
 int smu_v11_0_set_default_od_settings(struct smu_context *smu, bool initialize, size_t overdrive_table_size);
 
-uint32_t smu_v11_0_get_max_power_limit(struct smu_context *smu);
-
 int smu_v11_0_set_performance_level(struct smu_context *smu,
 				    enum amd_dpm_forced_level level);
 
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 0c9be864d072..3641f059186e 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -37,6 +37,8 @@
 #include "smu_v11_0_ppsmc.h"
 #include "nbio/nbio_2_3_offset.h"
 #include "nbio/nbio_2_3_sh_mask.h"
+#include "thm/thm_11_0_2_offset.h"
+#include "thm/thm_11_0_2_sh_mask.h"
 
 #include "asic_reg/mp/mp_11_0_sh_mask.h"
 
@@ -1841,7 +1843,7 @@ static int navi10_get_power_limit(struct smu_context *smu,
 	}
 
 	if (cap)
-		*limit = smu_v11_0_get_max_power_limit(smu);
+		*limit = smu_get_max_power_limit(smu);
 	else
 		*limit = smu->power_limit;
 
@@ -2253,6 +2255,64 @@ static int navi10_disable_umc_cdr_12gbps_workaround(struct smu_context *smu)
 	return navi10_dummy_pstate_control(smu, true);
 }
 
+static int navi10_set_thermal_range(struct smu_context *smu,
+				       struct smu_temperature_range range)
+{
+	struct amdgpu_device *adev = smu->adev;
+	int low = SMU_THERMAL_MINIMUM_ALERT_TEMP;
+	int high = SMU_THERMAL_MAXIMUM_ALERT_TEMP;
+	uint32_t val;
+	struct smu_table_context *table_context = &smu->smu_table;
+	struct smu_11_0_powerplay_table *powerplay_table = table_context->power_play_table;
+
+	low = max(SMU_THERMAL_MINIMUM_ALERT_TEMP,
+			range.min / SMU_TEMPERATURE_UNITS_PER_CENTIGRADES);
+	high = min((uint16_t)SMU_THERMAL_MAXIMUM_ALERT_TEMP, powerplay_table->software_shutdown_temp);
+
+	if (low > high)
+		return -EINVAL;
+
+	val = RREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_CTRL);
+	val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, MAX_IH_CREDIT, 5);
+	val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_IH_HW_ENA, 1);
+	val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_INTH_MASK, 0);
+	val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_INTL_MASK, 0);
+	val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTH, (high & 0xff));
+	val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTL, (low & 0xff));
+	val = val & (~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK);
+
+	WREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_CTRL, val);
+
+	return 0;
+}
+
+static uint32_t navi10_get_max_power_limit(struct smu_context *smu) {
+	uint32_t od_limit, max_power_limit;
+	struct smu_11_0_powerplay_table *powerplay_table = NULL;
+	struct smu_table_context *table_context = &smu->smu_table;
+	powerplay_table = table_context->power_play_table;
+
+	max_power_limit = smu_get_pptable_power_limit(smu);
+
+	if (!max_power_limit) {
+		// If we couldn't get the table limit, fall back on first-read value
+		if (!smu->default_power_limit)
+			smu->default_power_limit = smu->power_limit;
+		max_power_limit = smu->default_power_limit;
+	}
+
+	if (smu->od_enabled) {
+		od_limit = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+
+		pr_debug("ODSETTING_POWERPERCENTAGE: %d (default: %d)\n", od_limit, smu->default_power_limit);
+
+		max_power_limit *= (100 + od_limit);
+		max_power_limit /= 100;
+	}
+
+	return max_power_limit;
+}
+
 static const struct pptable_funcs navi10_ppt_funcs = {
 	.tables_init = navi10_tables_init,
 	.alloc_dpm_context = navi10_allocate_dpm_context,
@@ -2348,6 +2408,8 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.run_btc = navi10_run_btc,
 	.disable_umc_cdr_12gbps_workaround = navi10_disable_umc_cdr_12gbps_workaround,
 	.set_power_source = smu_v11_0_set_power_source,
+	.set_thermal_range = navi10_set_thermal_range,
+	.get_max_power_limit = navi10_get_max_power_limit,
 };
 
 void navi10_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index c97444841abc..093b63d405e5 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -208,6 +208,11 @@ static inline int smu_send_smc_msg(struct smu_context *smu, enum smu_message_typ
 #define smu_update_pcie_parameters(smu, pcie_gen_cap, pcie_width_cap) \
 		((smu)->ppt_funcs->update_pcie_parameters ? (smu)->ppt_funcs->update_pcie_parameters((smu), (pcie_gen_cap), (pcie_width_cap)) : 0)
 
+#define smu_set_thermal_range(smu, range) \
+		((smu)->ppt_funcs->set_thermal_range ? (smu)->ppt_funcs->set_thermal_range((smu), (range)) : 0)
+#define smu_get_max_power_limit(smu) \
+		((smu)->ppt_funcs->get_max_power_limit ? (smu)->ppt_funcs->get_max_power_limit((smu)) : 0)
+
 #define smu_disable_umc_cdr_12gbps_workaround(smu) \
 	((smu)->ppt_funcs->disable_umc_cdr_12gbps_workaround ? (smu)->ppt_funcs->disable_umc_cdr_12gbps_workaround((smu)) : 0)
 
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 4c2d98becc16..5133110dc5c8 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -32,7 +32,6 @@
 #include "atomfirmware.h"
 #include "amdgpu_atomfirmware.h"
 #include "smu_v11_0.h"
-#include "smu_v11_0_pptable.h"
 #include "soc15_common.h"
 #include "atom.h"
 #include "amd_pcie.h"
@@ -1093,33 +1092,6 @@ int smu_v11_0_init_max_sustainable_clocks(struct smu_context *smu)
 	return 0;
 }
 
-uint32_t smu_v11_0_get_max_power_limit(struct smu_context *smu) {
-	uint32_t od_limit, max_power_limit;
-	struct smu_11_0_powerplay_table *powerplay_table = NULL;
-	struct smu_table_context *table_context = &smu->smu_table;
-	powerplay_table = table_context->power_play_table;
-
-	max_power_limit = smu_get_pptable_power_limit(smu);
-
-	if (!max_power_limit) {
-		// If we couldn't get the table limit, fall back on first-read value
-		if (!smu->default_power_limit)
-			smu->default_power_limit = smu->power_limit;
-		max_power_limit = smu->default_power_limit;
-	}
-
-	if (smu->od_enabled) {
-		od_limit = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
-
-		pr_debug("ODSETTING_POWERPERCENTAGE: %d (default: %d)\n", od_limit, smu->default_power_limit);
-
-		max_power_limit *= (100 + od_limit);
-		max_power_limit /= 100;
-	}
-
-	return max_power_limit;
-}
-
 int smu_v11_0_set_power_limit(struct smu_context *smu, uint32_t n)
 {
 	int ret = 0;
@@ -1128,7 +1100,7 @@ int smu_v11_0_set_power_limit(struct smu_context *smu, uint32_t n)
 	if (amdgpu_sriov_vf(smu->adev))
 		return 0;
 
-	max_power_limit = smu_v11_0_get_max_power_limit(smu);
+	max_power_limit = smu_get_max_power_limit(smu);
 
 	if (n > max_power_limit) {
 		pr_err("New power limit (%d) is over the max allowed %d\n",
@@ -1186,37 +1158,6 @@ int smu_v11_0_get_current_clk_freq(struct smu_context *smu,
 	return ret;
 }
 
-static int smu_v11_0_set_thermal_range(struct smu_context *smu,
-				       struct smu_temperature_range range)
-{
-	struct amdgpu_device *adev = smu->adev;
-	int low = SMU_THERMAL_MINIMUM_ALERT_TEMP;
-	int high = SMU_THERMAL_MAXIMUM_ALERT_TEMP;
-	uint32_t val;
-	struct smu_table_context *table_context = &smu->smu_table;
-	struct smu_11_0_powerplay_table *powerplay_table = table_context->power_play_table;
-
-	low = max(SMU_THERMAL_MINIMUM_ALERT_TEMP,
-			range.min / SMU_TEMPERATURE_UNITS_PER_CENTIGRADES);
-	high = min((uint16_t)SMU_THERMAL_MAXIMUM_ALERT_TEMP, powerplay_table->software_shutdown_temp);
-
-	if (low > high)
-		return -EINVAL;
-
-	val = RREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_CTRL);
-	val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, MAX_IH_CREDIT, 5);
-	val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_IH_HW_ENA, 1);
-	val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_INTH_MASK, 0);
-	val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_INTL_MASK, 0);
-	val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTH, (high & 0xff));
-	val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTL, (low & 0xff));
-	val = val & (~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK);
-
-	WREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_CTRL, val);
-
-	return 0;
-}
-
 static int smu_v11_0_enable_thermal_alert(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -1244,7 +1185,7 @@ int smu_v11_0_start_thermal_control(struct smu_context *smu)
 		return ret;
 
 	if (smu->smu_table.thermal_controller_type) {
-		ret = smu_v11_0_set_thermal_range(smu, range);
+		ret = smu_set_thermal_range(smu, range);
 		if (ret)
 			return ret;
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
