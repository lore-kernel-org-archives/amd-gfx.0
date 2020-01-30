Return-Path: <SRS0=GnFq=3T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B3AC33C9E
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2020 08:59:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF947206F0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2020 08:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WKOO9FZW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF947206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4248F6F903;
	Thu, 30 Jan 2020 08:59:11 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770087.outbound.protection.outlook.com [40.107.77.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9D506E134
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2020 08:59:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjZmcG8K0i8ex2DPBLr2+i7PHalFUlhn+z2GVrapAiG63AGuGxYDfRuKFzv3/UiFjrNP7mOcgbvO1DpjusejVJ22Qs2mWl//g8NZQyprE1NGzvluL9H0J0DcawoMYvoX3/lb7BsfFzxRQN7bu7ofvWqxBeYi4c4C8ScfIhTI/jqpNQlTI1/5uPr0wGnkcgRcOYamEOU5P8yDmWPvuoEHf84B4GtXsJcbWIYGaDPbSwBWRG5DuaP0pAcTGMHuNweW7/cIpb4reSwgObsU/YvUqec1g4QSnsHZX4fuIBI1drgaFx3qdOmfQbufW49GS4dHNk2GRX3lLNHrDvzK9gAd1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFxFWlBQAoCM+Jyk2d4EV44ImIVPJ+m3G9xiwg6IUIQ=;
 b=TksYYXUvRNCI4oCtz2VZ1n3+mp8JwAHzNW4XJGa8ispkb8kIcLgyCAW1EfK4DBHbuDOOgJlZP9c89DNHoKFOqEKXnuST+Dv4Iu3f9GzKPL9l7F/hbv07pIoXHavTEAFOwBiO4RuwKKnH6CjbrEVxJHoMIJZHWQ33fjTkiBEHy5doHbv7zUPP09FI9MG3gwuiTKhVApXCDQPVeVskgahg/HRoilO9ach8rtF8gSP8Cad7wJQQ0VV2NJRA4i/pEDT0kMVsSNfU1AfcXGszvQIxE0vzZKiPREd8a7u6NLwdKkpqxPf70XqPJ+GAH54Lw9BIVAJmfjXyuo8HGfIi4WlUFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFxFWlBQAoCM+Jyk2d4EV44ImIVPJ+m3G9xiwg6IUIQ=;
 b=WKOO9FZW6VHFOvEYh05uWNMGOkkBiIcDxdQjWf+Xdcsnpdz8lggYvTaF+LgbO3Sdyybo0K4oldvAaGfnyHO0MXyaYXsXDLBBz29z5cGSTAdOjQJJROI64rrLiIqEJQNtRaYBfEcVngs0FJYUH3OeuLEYjP39y0VU2Rd6fmgTiHE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB4189.namprd12.prod.outlook.com (52.135.49.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Thu, 30 Jan 2020 08:59:08 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2665.027; Thu, 30 Jan 2020
 08:59:07 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: fix navi10 system intermittent reboot issue
Date: Thu, 30 Jan 2020 16:58:47 +0800
Message-Id: <20200130085847.26004-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.24.1
X-ClientProxiedBy: HKAPR04CA0002.apcprd04.prod.outlook.com
 (2603:1096:203:d0::12) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HKAPR04CA0002.apcprd04.prod.outlook.com (2603:1096:203:d0::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20 via Frontend Transport; Thu, 30 Jan 2020 08:59:06 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4e2093de-938c-43e1-3c80-08d7a562aa06
X-MS-TrafficTypeDiagnostic: MN2PR12MB4189:|MN2PR12MB4189:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB41899670595E2B728ADB9EF2E4040@MN2PR12MB4189.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 02981BE340
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(199004)(189003)(478600001)(8676002)(2906002)(956004)(2616005)(7696005)(52116002)(316002)(5660300002)(44832011)(81166006)(81156014)(6916009)(36756003)(186003)(16526019)(8936002)(1076003)(66574012)(66946007)(86362001)(66556008)(66476007)(6486002)(19627235002)(4326008)(26005)(6666004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4189;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gnlDN4og0fBzIX02t4a4sy5lSzTuqPkeuEvzyuL4MNa4/y4XjZzeubgg4pI1MzwtGXC4EQww++FR2nUVgIMsM3ofmjXGWQ7mafZ5iOsKG7hmfrD8KP+k1CoHBbbmGYHufQ+zkuCpjlyWGMhX/rnU9ziucfy19lTat+8wo3khhIDZzyXD1NZTHkEe2geSjrh7kRETc4xfBBXjLVDElTIBzuyhjB5RM56sA9Z1uzLgWomaEgyEL5YNZK7FJznC7dZcCV3aGan6xK/a/i3zDG7i9ajneDLkg81u22tEXzTiQi+B/GISyLtxY77OZjoovdNFhEPTfp27J2csW+4wA76/aLMtG27iyMA4Bi1Bq4PjwwKwQq3jnszJLCIFDjfLGyXtQunF9W/9T6+gtFS6wVh5JD1+NR2INDj9nmcJN6z+klK3TBnAzkcbu1tZelNW2BJt
X-MS-Exchange-AntiSpam-MessageData: j7hv6CwnURiJZGM2t47b/SjkcYKB1y7hx2MayHazRzqyaeov5HiBQRoDZ0hPZX21LWR34iWicqLcilw+dPnNxXnfKChsY4Rwy8YHsXvireAPl6yF1/vOX+r2Fq1OO2ZVP/pJztBtcyqGAF7aUQIHHw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e2093de-938c-43e1-3c80-08d7a562aa06
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2020 08:59:07.8095 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0hLg2lMWR4qjys0DlzIoBDuYy4ME8EAgaUkfwXZmx0Y+4vf1VFcCZq3UAddLTDSt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4189
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This workaround is needed only for Navi10 12 Gbps SKUs.

Change-Id: I4bfcb8a8dbff785a159e6a1ed413d93063403ab3
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 18 +++++++
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  1 +
 drivers/gpu/drm/amd/powerplay/inc/smu_types.h |  2 +
 .../drm/amd/powerplay/inc/smu_v11_0_ppsmc.h   |  5 +-
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    | 49 +++++++++++++++++++
 drivers/gpu/drm/amd/powerplay/smu_internal.h  |  3 ++
 6 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index fabc46dfb933..9d1075823681 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -21,6 +21,7 @@
  */
 
 #include <linux/firmware.h>
+#include <linux/pci.h>
 
 #include "pp_debug.h"
 #include "amdgpu.h"
@@ -1138,6 +1139,23 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
 		ret = smu_system_features_control(smu, true);
 		if (ret)
 			return ret;
+
+		if (adev->asic_type == CHIP_NAVI10) {
+			if ((adev->pdev->device == 0x731f && (adev->pdev->revision == 0xc2 ||
+							      adev->pdev->revision == 0xc3 ||
+							      adev->pdev->revision == 0xca ||
+							      adev->pdev->revision == 0xcb)) ||
+			    (adev->pdev->device == 0x66af && (adev->pdev->revision == 0xf3 ||
+							      adev->pdev->revision == 0xf4 ||
+							      adev->pdev->revision == 0xf5 ||
+							      adev->pdev->revision == 0xf6))) {
+				ret = smu_disable_umc_cdr_12gbps_workaround(smu);
+				if (ret) {
+					pr_err("Workaround failed to disable UMC CDR feature on 12Gbps SKU!\n");
+					return ret;
+				}
+			}
+		}
 	}
 	if (adev->asic_type != CHIP_ARCTURUS) {
 		ret = smu_notify_display_change(smu);
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index b8781820cec1..75c79b52ef03 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -566,6 +566,7 @@ struct pptable_funcs {
 	int (*set_soft_freq_limited_range)(struct smu_context *smu, enum smu_clk_type clk_type, uint32_t min, uint32_t max);
 	int (*override_pcie_parameters)(struct smu_context *smu);
 	uint32_t (*get_pptable_power_limit)(struct smu_context *smu);
+	int (*disable_umc_cdr_12gbps_workaround)(struct smu_context *smu);
 };
 
 int smu_load_microcode(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_types.h b/drivers/gpu/drm/amd/powerplay/inc/smu_types.h
index d8c9b7f91fcc..a5b4df146713 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_types.h
@@ -170,6 +170,8 @@
 	__SMU_DUMMY_MAP(SetSoftMinJpeg),              \
 	__SMU_DUMMY_MAP(SetHardMinFclkByFreq),        \
 	__SMU_DUMMY_MAP(DFCstateControl), \
+	__SMU_DUMMY_MAP(DAL_DISABLE_DUMMY_PSTATE_CHANGE), \
+	__SMU_DUMMY_MAP(DAL_ENABLE_DUMMY_PSTATE_CHANGE), \
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_ppsmc.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_ppsmc.h
index 373861ddccd0..406bfd187ce8 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_ppsmc.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_ppsmc.h
@@ -120,7 +120,10 @@
 #define PPSMC_MSG_GetVoltageByDpmOverdrive       0x45
 #define PPSMC_MSG_BacoAudioD3PME                 0x48
 
-#define PPSMC_Message_Count                      0x49
+#define PPSMC_MSG_DALDisableDummyPstateChange    0x49
+#define PPSMC_MSG_DALEnableDummyPstateChange     0x4A
+
+#define PPSMC_Message_Count                      0x4B
 
 typedef uint32_t PPSMC_Result;
 typedef uint32_t PPSMC_Msg;
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index a0a342f6127f..3feb339a434e 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -119,6 +119,8 @@ static struct smu_11_0_cmn2aisc_mapping navi10_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(PowerDownJpeg,		PPSMC_MSG_PowerDownJpeg),
 	MSG_MAP(BacoAudioD3PME,		PPSMC_MSG_BacoAudioD3PME),
 	MSG_MAP(ArmD3,			PPSMC_MSG_ArmD3),
+	MSG_MAP(DAL_DISABLE_DUMMY_PSTATE_CHANGE,PPSMC_MSG_DALDisableDummyPstateChange),
+	MSG_MAP(DAL_ENABLE_DUMMY_PSTATE_CHANGE,	PPSMC_MSG_DALEnableDummyPstateChange),
 };
 
 static struct smu_11_0_cmn2aisc_mapping navi10_clk_map[SMU_CLK_COUNT] = {
@@ -2127,6 +2129,52 @@ static int navi10_run_btc(struct smu_context *smu)
 	return ret;
 }
 
+static int navi10_dummy_pstate_control(struct smu_context *smu, bool enable)
+{
+	int result = 0;
+
+	if (!enable)
+		result = smu_send_smc_msg(smu, SMU_MSG_DAL_DISABLE_DUMMY_PSTATE_CHANGE);
+	else
+		result = smu_send_smc_msg(smu, SMU_MSG_DAL_ENABLE_DUMMY_PSTATE_CHANGE);
+
+	return result;
+}
+
+static int navi10_disable_umc_cdr_12gbps_workaround(struct smu_context *smu)
+{
+	uint32_t uclk_count, uclk_min, uclk_max;
+	int ret = 0;
+
+	ret = smu_get_dpm_level_count(smu, SMU_UCLK, &uclk_count);
+	if (ret)
+		return ret;
+
+	ret = smu_get_dpm_freq_by_index(smu, SMU_UCLK, (uint16_t)0, &uclk_min);
+	if (ret)
+		return ret;
+
+	ret = smu_get_dpm_freq_by_index(smu, SMU_UCLK, (uint16_t)(uclk_count - 1), &uclk_max);
+	if (ret)
+		return ret;
+
+	/* Force UCLK out of the highest DPM */
+	ret = smu_set_hard_freq_range(smu, SMU_UCLK, 0, uclk_min);
+	if (ret)
+		return ret;
+
+	/* Revert the UCLK Hardmax */
+	ret = smu_set_hard_freq_range(smu, SMU_UCLK, 0, uclk_max);
+	if (ret)
+		return ret;
+
+	/*
+	 * In this case, SMU already disabled dummy pstate during enablement
+	 * of UCLK DPM, we have to re-enabled it.
+	 * */
+	return navi10_dummy_pstate_control(smu, true);
+}
+
 static const struct pptable_funcs navi10_ppt_funcs = {
 	.tables_init = navi10_tables_init,
 	.alloc_dpm_context = navi10_allocate_dpm_context,
@@ -2221,6 +2269,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.od_edit_dpm_table = navi10_od_edit_dpm_table,
 	.get_pptable_power_limit = navi10_get_pptable_power_limit,
 	.run_btc = navi10_run_btc,
+	.disable_umc_cdr_12gbps_workaround = navi10_disable_umc_cdr_12gbps_workaround,
 };
 
 void navi10_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index 783319ec8bf9..7bd200ffcda8 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -207,4 +207,7 @@ int smu_send_smc_msg(struct smu_context *smu, enum smu_message_type msg);
 #define smu_update_pcie_parameters(smu, pcie_gen_cap, pcie_width_cap) \
 		((smu)->ppt_funcs->update_pcie_parameters ? (smu)->ppt_funcs->update_pcie_parameters((smu), (pcie_gen_cap), (pcie_width_cap)) : 0)
 
+#define smu_disable_umc_cdr_12gbps_workaround(smu) \
+	((smu)->ppt_funcs->disable_umc_cdr_12gbps_workaround ? (smu)->ppt_funcs->disable_umc_cdr_12gbps_workaround((smu)) : 0)
+
 #endif
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
