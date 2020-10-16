Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B007C43457
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:29:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB2D4206ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nGbzXFQW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB2D4206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D5246EA8B;
	Fri, 16 Oct 2020 03:29:06 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94D416E9BD
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 03:29:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rt5YHzbZZLzoBR8bVXnpUp4ZhSMuDmK1p8qmscxjvQ/d8vEh5F5kA5GfGnyRCQ/eKyFxeWHzQ4b7C1HbQ/1LGVPzhfQxYoLTrwVXMeG6CispEvwYICS3lefh6KJQGo1YiItCfN6xw7cDTtlaFK/I86wdrVdjllBxE6zqvruyeJp6SYW7MNOakRLyLAU5/XaC4JpJTICOau74YCNG2mKPTf4ahzElsMEIWa30dW8zC3kFzpmdvN6W7yVwdAR4XGqvW/kfqao0qUKDfnkttCYq3B3a+Wte1kxyuYKNlwTd3X8SUCuQeqoVt2gTSXpIkL0MjlilqGkqqKCbxj2YbVIjVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxNh2CLvyHBLwGi0PamhY60mSsQUudZjXGgn2C2rUMs=;
 b=asKc8t1u8hEEbSmIzN+paGmC2fep3QfepxSImTNmNa5aIR+28EpTGXkjN214l5mhyyVHb9qWbfGows1PT2cmal0Y+k1vy8IphMLIr9kg+1u2Uuk8YTmmlBbTk5sPR/qrkTudWW5mKkvcTxKgOZEfD0dnmruvYPTszaXIM7EUk94x/VozA7NSA01SQHhCol+40VKBGQr/Ufxw3toq23tbess8qSQFgRGhCone4ONvZE5TRiw72egofnBaKt+EkQai4pLNloZB8caKKUW5eLKu+KDbGBXJ2/xAZy2kMTYEpi5Xw2dnnMaZyAmILCmQxxVnSd78B6v9IbRVQxWpsMlPiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxNh2CLvyHBLwGi0PamhY60mSsQUudZjXGgn2C2rUMs=;
 b=nGbzXFQWve0I4JrslcyUN6HWlcoN/XRHiZlec0+M7qXCx2lb1lVkD329+MxcTIL8D8v0Ohs7mDwpK2ucurCjSF5QJ+0PPSUjPlYGRrCMF9Jq+vrslLMTLypzZLG50GHTQMdBYV5myirwK0IUVcGXBswPkaMp29qj96z0nG2kfvQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1354.namprd12.prod.outlook.com (2603:10b6:3:7a::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Fri, 16 Oct 2020 03:29:04 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.023; Fri, 16 Oct 2020
 03:29:04 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 37/40] drm/amd/pm: enable Polaris watermark table setting
Date: Fri, 16 Oct 2020 11:26:49 +0800
Message-Id: <20201016032652.507-38-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016032652.507-1-evan.quan@amd.com>
References: <20201016032652.507-1-evan.quan@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0302CA0007.apcprd03.prod.outlook.com
 (2603:1096:202::17) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0302CA0007.apcprd03.prod.outlook.com (2603:1096:202::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.8 via Frontend Transport; Fri, 16 Oct 2020 03:28:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 51d41ff8-2829-48b6-5eb6-08d871839279
X-MS-TrafficTypeDiagnostic: DM5PR12MB1354:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB135437671CDC4F7F2AA6F0A9E4030@DM5PR12MB1354.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f1L608K5MRuPx+fr5kNQjG7VdTGfsL3k1zigardqfBVWKlfobUuqT0r00yHlJYS63YpL3IAKRVbwYt0oCRuDtM+EyPQwtfYPdx9A47rKAE8hvQkA9St33mjP6Ez6vF5Ar0O9tHIq7gtbLQnots9gefH3JlSCRwuUANHEisIg5YWGKFDbf5I3eQz9DnMKmYDkPkpI0AyhsMCE8sDv5Zgu5CrVDtgjTU1fxzoPEh8Wz4OsJyQ051CBEq3Lv2Uk1BsJBcM6ysjjLuQr2Kv/C/m2R+CwceOb8QysY+0vq6E2retEdvX0oUwG9FFDc2SL3n9rFiQE6kjSSqK/keGQERmglKaYyCNYsv9wnjeTIOvfG41AH6+Dap2FaJD70J1FfGaD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(66476007)(66946007)(83380400001)(1076003)(8676002)(6486002)(5660300002)(8936002)(66556008)(6916009)(86362001)(52116002)(36756003)(7696005)(4326008)(2616005)(34490700002)(478600001)(316002)(6666004)(44832011)(16526019)(186003)(54906003)(2906002)(19627235002)(26005)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: uoh/GLPll/+aGJ6eIHVNpCIRX+L0XzXEJD1er7/jzeT2pmLMIh9NAmGKTsxCRN0YRoLvb/qsjhzM8d3IQMok6KNdXu/U8EsWeMosHY9wa16zn98TZhjNuZ7K4R7CZFfyyF6U7H3E99gZQfqyK7HLvuXYoNiaYXg2/Atx4ZhXER/RXMSwPBu8fKmzQkXy4MtfMMtK8XyYRiH2/N4JcnT8f6V20XaeM04Th8oQb36zL6hF6bTeCjJrInOBDW4KsG3Bu/DABUrLmUBesbnZ5mWPmVZx1B96gxDQ9N7LLh+J2CtyL3OazMrXFQrXKqU8CORV4j0lDKYFEEDSYRqGuKmgDzLoBYv7FT7QQSEvyxCg/m4GBMV8eUZuHZfxp1K+MgjlH54dWqJb+IX1dHTz80y4mZlXbxSwfkCwlF0vTWnRBIc5nlrC6Q5d73fJw57naNd/hh2tG/e/ZO/IGCjaLd/+j1U94KlKAXUOhDh7T6i+S6z1Llmj9gC0J3RBinh57ZHq51o5anLNXwWIegBnTHyddnMm2BBBMiIaTFjxR+r7RBh1Ha+OrH3nz0YBKobW60P3bAvvn9pSBj8uo54+9KjCWffYQCiwNkvzbhhSO83CraKCtqE5lFF0xTpwHaMo0PFT+M60Gl2HK1CW+yBKfj5ZCQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d41ff8-2829-48b6-5eb6-08d871839279
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 03:28:38.6196 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mcpvn6NgVeVxwlgHvNmjZpRZVlISQVzVdi4IisABx6oMZB3KOqq59z7L3aelKtvI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1354
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable watermark table setting for Polaris.

Change-Id: I395b74f2ce5b74e6d1c7659816ee386ba556e14c
Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  | 11 +++-
 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 50 +++++++++++++++++++
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
index deb9164eb5fe..fd39dd67bfa4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
@@ -458,7 +458,16 @@ bool dm_pp_notify_wm_clock_changes(
 	const struct dc_context *ctx,
 	struct dm_pp_wm_sets_with_clock_ranges *wm_with_clock_ranges)
 {
-	/* TODO: to be implemented */
+	struct amdgpu_device *adev = ctx->driver_context;
+	void *pp_handle = adev->powerplay.pp_handle;
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+
+	if (pp_funcs && pp_funcs->set_watermarks_for_clocks_ranges) {
+		if (!pp_funcs->set_watermarks_for_clocks_ranges(pp_handle,
+						(void *)wm_with_clock_ranges))
+			return true;
+	}
+
 	return false;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 3700352286c5..ce8f368c0a8c 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -49,6 +49,8 @@
 #include "processpptables.h"
 #include "pp_thermal.h"
 #include "smu7_baco.h"
+#include "smu7_smumgr.h"
+#include "polaris10_smumgr.h"
 
 #include "ivsrcid/ivsrcid_vislands30.h"
 
@@ -5107,6 +5109,53 @@ static int smu7_get_clock_by_type_with_latency(struct pp_hwmgr *hwmgr,
 	return 0;
 }
 
+static int smu7_set_watermarks_for_clocks_ranges(struct pp_hwmgr *hwmgr,
+						 void *clock_range)
+{
+	struct phm_ppt_v1_information *table_info =
+			(struct phm_ppt_v1_information *)hwmgr->pptable;
+	struct phm_ppt_v1_clock_voltage_dependency_table *dep_mclk_table =
+			table_info->vdd_dep_on_mclk;
+	struct phm_ppt_v1_clock_voltage_dependency_table *dep_sclk_table =
+			table_info->vdd_dep_on_sclk;
+	struct polaris10_smumgr *smu_data =
+			(struct polaris10_smumgr *)(hwmgr->smu_backend);
+	SMU74_Discrete_DpmTable  *table = &(smu_data->smc_state_table);
+	struct dm_pp_wm_sets_with_clock_ranges *watermarks =
+			(struct dm_pp_wm_sets_with_clock_ranges *)clock_range;
+	uint32_t i, j, k;
+	bool valid_entry;
+
+	if (!(hwmgr->chip_id >= CHIP_POLARIS10 &&
+	      hwmgr->chip_id <= CHIP_VEGAM))
+		return -EINVAL;
+
+	for (i = 0; i < dep_mclk_table->count; i++) {
+		for (j = 0; j < dep_sclk_table->count; j++) {
+			valid_entry = false;
+			for (k = 0; k < watermarks->num_wm_sets; k++) {
+				if (dep_sclk_table->entries[i].clk / 10 >= watermarks->wm_clk_ranges[k].wm_min_eng_clk_in_khz &&
+				    dep_sclk_table->entries[i].clk / 10 < watermarks->wm_clk_ranges[k].wm_max_eng_clk_in_khz &&
+				    dep_mclk_table->entries[i].clk / 10 >= watermarks->wm_clk_ranges[k].wm_min_mem_clk_in_khz &&
+				    dep_mclk_table->entries[i].clk / 10 < watermarks->wm_clk_ranges[k].wm_max_mem_clk_in_khz) {
+					valid_entry = true;
+					table->DisplayWatermark[i][j] = watermarks->wm_clk_ranges[k].wm_set_id;
+					break;
+				}
+			}
+			PP_ASSERT_WITH_CODE(valid_entry,
+					"Clock is not in range of specified clock range for watermark from DAL!  Using highest water mark set.",
+					table->DisplayWatermark[i][j] = watermarks->wm_clk_ranges[k - 1].wm_set_id);
+		}
+	}
+
+	return smu7_copy_bytes_to_smc(hwmgr,
+				      smu_data->smu7_data.dpm_table_start + offsetof(SMU74_Discrete_DpmTable, DisplayWatermark),
+				      (uint8_t *)table->DisplayWatermark,
+				      sizeof(uint8_t) * SMU74_MAX_LEVELS_MEMORY * SMU74_MAX_LEVELS_GRAPHICS,
+				      SMC_RAM_END);
+}
+
 static int smu7_notify_cac_buffer_info(struct pp_hwmgr *hwmgr,
 					uint32_t virtual_addr_low,
 					uint32_t virtual_addr_hi,
@@ -5525,6 +5574,7 @@ static const struct pp_hwmgr_func smu7_hwmgr_funcs = {
 	.set_mclk_od = smu7_set_mclk_od,
 	.get_clock_by_type = smu7_get_clock_by_type,
 	.get_clock_by_type_with_latency = smu7_get_clock_by_type_with_latency,
+	.set_watermarks_for_clocks_ranges = smu7_set_watermarks_for_clocks_ranges,
 	.read_sensor = smu7_read_sensor,
 	.dynamic_state_management_disable = smu7_disable_dpm_tasks,
 	.avfs_control = smu7_avfs_control,
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
