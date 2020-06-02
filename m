Return-Path: <SRS0=q3BR=7P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E924BC433E1
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 10:29:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B313206C3
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 10:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oodlmZhx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B313206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 454806E39E;
	Tue,  2 Jun 2020 10:29:12 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00CE86E39C
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2020 10:29:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDtDnyNAiTZqZWbw/BYd1wtHNwKKEtDw1Oa5u+JK1md7MXmNCxsFEKgUS1T5icaC2YtIIiuzuZvubECvP0TIyZub2F1HSo9S2nqVr6c3lb7V/DfxsXuaIrCbqrhsplBZB7msJMsO4f3UlwFHOY+FbfvuzFXW0/3IvTcdE2wxTG6jnsrxM2oFA83BMuqFOjv/LUeBNF7DmsdMsNgH3bESxD6VDMquV3aHM4sPDmHEG7baca8aqaOh/YnT7MLdemnyX3+JoWjIiZkiwu2K6MoIeGMoYiS+qb9AkCL3YpFxP+U3R3lJf1t8j7OWYV9zJTs/D7N9gN8sEkpdpphOJ0U0nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYVADRpTCTam5Z6QhmwQei8ZvH9lbFlDUJM9m4q+7BA=;
 b=Uwq6mVfjV+Ur0vubXjfwPRZpryYGwacQhlyiaoCk61JiPZmT+Mm8d6E2t/ETtPgB3y6nmngMvpeEKUIWTTPBzxOfuMDqclhGvXhYa4YQNHXSAnkRrqPz468cvhynFvTXIRNsvSK/0xClmnt66f7FHX6ECh9F+42lw549W0aj+ZvVlcqrfOJd01//ymj2inyc5xj3EmYAa+ff19KWQMta9PPxLwhjp8HP+DOyy45rGRwXw/X17yGNx5dNNgF4g5rAk2Ude+toLgXYLYFh101xJuc+eWcwDKRYszEW74pgmts4ROYLBBxlkxR68I6Wre/AGsyya1uivLs4WEq/8KYoCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYVADRpTCTam5Z6QhmwQei8ZvH9lbFlDUJM9m4q+7BA=;
 b=oodlmZhxP7CsmLoskY3nYmad/azHED1ygJIwPmqWSwRGoaOodSb8CHcWOBaRGd3i9K3eYq7deMjV3TIxmdL7TAEIDqkFbLf4sZaSi5jEBuE/kV+zWLa26Fxl2LLaA8zRFedDtrhJPlTbVqNLjKUSMgNo8Cyl5pq2L4M74oG5BPk=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2763.namprd12.prod.outlook.com (2603:10b6:5:48::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.22; Tue, 2 Jun 2020 10:29:08 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3045.022; Tue, 2 Jun 2020
 10:29:08 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: move powerplay table operation out of
 smu_v11_0.c
Thread-Topic: [PATCH] drm/amd/powerplay: move powerplay table operation out of
 smu_v11_0.c
Thread-Index: AQHWOL14NcGP7rh4wEKnwGBTi4sh4qjFHUaA
Date: Tue, 2 Jun 2020 10:29:08 +0000
Message-ID: <DM6PR12MB261963682C7FD45C2286E376E48B0@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200602090840.3318819-1-likun.gao@amd.com>
In-Reply-To: <20200602090840.3318819-1-likun.gao@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=785f52bd-8453-41cd-9a19-00005d778d07;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-06-02T10:20:03Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8a9b8c22-2e11-4099-6dd1-08d806dfc87e
x-ms-traffictypediagnostic: DM6PR12MB2763:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB276301343661325916C7B723E48B0@DM6PR12MB2763.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:792;
x-forefront-prvs: 0422860ED4
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T56vi0s5Trvm/rh4QbE1SkV204rH6+/Cugg0SQeQWz05GbnRHwY79SUhYjsRHzMEJIPvdW8NWf0hKVa+xX7+0ssuXuOMeJMA1JPDME60nDd3hTEVpeSCRvLtII8Muhcbp0zxs0sDcQKfTn3x1uFzIJbzoOqyvTzTlZkvBfJp4K/XmIRgRd5TQ+hPvgfLv74J9YOvA9kTsG3ezm5kYLCDDHn7uOxLARNPIPNgyfv0+MHKR38lMjQW1UO6RjprEoUDBdlPKfb7zRWXu4oHD6UMPz3iPyhoUg7kyIByPldXXaRYhVZ79JREfOm1lAvh1kez
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(55016002)(53546011)(9686003)(6506007)(8936002)(76116006)(66446008)(71200400001)(66476007)(66946007)(33656002)(66556008)(64756008)(8676002)(7696005)(26005)(5660300002)(54906003)(110136005)(186003)(83380400001)(30864003)(316002)(4326008)(2906002)(52536014)(478600001)(86362001)(66574014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: pOWtr4NX8Q7+HB89tJ23N1II3pe7+RGoh5w5+TyTkjE84x8oqZazordR3z5Eqq4mGH5ZjNWfVdYTK/r33h0DXaiOeG0E/n9OMHPGraoZpYlF44lkWApLUDf6aXPzPfNB+17WzyN7B3+Ze8mH+r2t0iVyQtzwFYL3WsQGOCiAkPVlsh/fv1R4ToAHuD82BbuVlqEMug8I6olm7pP3uDdJ/cyRtA1/n976zqFXo2d7hByVmwnZG6TQcSHSb9spTUc4U/w2GNFAtuFJ1cXU846acBqUMqxiP6wFNd+LeAL5ekxCinYfpPE5s6/lk4mX40X/kOykG8AOw/no/HiDCDYR+dPmWVofXhlktqzgmHxxGIKhGJBAnS2LSzXlj3XBC00NjMEl4SfQp+CRIJZXvxvGSTlzz2y/97bBMt6M2yDoyGA4moSKwW+7DpDZwK+u54j6xYOug3YeyoveYeT9vP9AJOk6PzDMykShSoOR+DIJn/rl/G0eEy+3dE9rsP0fapeq
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a9b8c22-2e11-4099-6dd1-08d806dfc87e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2020 10:29:08.3268 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fs9OkLMG3Wrf6CP1ZWsFaITYll/ZUETH055TnwQHGdHT4A/njm/iUZ32PfxLKO7s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2763
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
Cc: "Wang, Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

-----Original Message-----
From: Gao, Likun <Likun.Gao@amd.com>
Sent: Tuesday, June 2, 2020 5:09 PM
To: amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Gao, Likun <Likun.Gao@amd.com>
Subject: [PATCH] drm/amd/powerplay: move powerplay table operation out of smu_v11_0.c

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
-*limit = smu_v11_0_get_max_power_limit(smu);
+*limit = smu_get_max_power_limit(smu);
[Quan, Evan] I think you can just call atcturus_get_max_power_limit directly here without need of another wrapper.
 else
 *limit = smu->power_limit;

@@ -2286,6 +2288,64 @@ static int arcturus_set_df_cstate(struct smu_context *smu,
 return smu_send_smc_msg_with_param(smu, SMU_MSG_DFCstateControl, state, NULL);
 }

+static int arcturus_set_thermal_range(struct smu_context *smu,
+       struct smu_temperature_range range)
+{
+struct amdgpu_device *adev = smu->adev;
+int low = SMU_THERMAL_MINIMUM_ALERT_TEMP;
+int high = SMU_THERMAL_MAXIMUM_ALERT_TEMP;
+uint32_t val;
+struct smu_table_context *table_context = &smu->smu_table;
+struct smu_11_0_powerplay_table *powerplay_table = table_context->power_play_table;
+
+low = max(SMU_THERMAL_MINIMUM_ALERT_TEMP,
+range.min / SMU_TEMPERATURE_UNITS_PER_CENTIGRADES);
+high = min((uint16_t)SMU_THERMAL_MAXIMUM_ALERT_TEMP, powerplay_table->software_shutdown_temp);
+
+if (low > high)
+return -EINVAL;
+
+val = RREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_CTRL);
+val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, MAX_IH_CREDIT, 5);
+val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_IH_HW_ENA, 1);
+val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_INTH_MASK, 0);
+val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_INTL_MASK, 0);
+val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTH, (high & 0xff));
+val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTL, (low & 0xff));
+val = val & (~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK);
+
+WREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_CTRL, val);
+
+return 0;
+}
+
+static uint32_t atcturus_get_max_power_limit(struct smu_context *smu) {
+uint32_t od_limit, max_power_limit;
+struct smu_11_0_powerplay_table *powerplay_table = NULL;
+struct smu_table_context *table_context = &smu->smu_table;
+powerplay_table = table_context->power_play_table;
+
+max_power_limit = smu_get_pptable_power_limit(smu);
+
+if (!max_power_limit) {
+// If we couldn't get the table limit, fall back on first-read value
+if (!smu->default_power_limit)
+smu->default_power_limit = smu->power_limit;
+max_power_limit = smu->default_power_limit;
+}
+
+if (smu->od_enabled) {
+od_limit = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+
+pr_debug("ODSETTING_POWERPERCENTAGE: %d (default: %d)\n", od_limit, smu->default_power_limit);
+
+max_power_limit *= (100 + od_limit);
+max_power_limit /= 100;
+}
+
+return max_power_limit;
+}
+
 static const struct pptable_funcs arcturus_ppt_funcs = {
 /* translate smu index into arcturus specific index */
 .get_smu_msg_index = arcturus_get_smu_msg_index,
@@ -2379,6 +2439,8 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 .override_pcie_parameters = smu_v11_0_override_pcie_parameters,
 .get_pptable_power_limit = arcturus_get_pptable_power_limit,
 .set_df_cstate = arcturus_set_df_cstate,
+.set_thermal_range = arcturus_set_thermal_range,
+.get_max_power_limit = atcturus_get_max_power_limit,
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
+int (*set_thermal_range)(struct smu_context *smu, struct smu_temperature_range range);
+uint32_t (*get_max_power_limit)(struct smu_context *smu);
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
-*limit = smu_v11_0_get_max_power_limit(smu);
+*limit = smu_get_max_power_limit(smu);
[Quan, Evan] Use navi10_get_max_power_limit() here.
 else
 *limit = smu->power_limit;

@@ -2253,6 +2255,64 @@ static int navi10_disable_umc_cdr_12gbps_workaround(struct smu_context *smu)
 return navi10_dummy_pstate_control(smu, true);
 }

+static int navi10_set_thermal_range(struct smu_context *smu,
+       struct smu_temperature_range range)
+{
+struct amdgpu_device *adev = smu->adev;
+int low = SMU_THERMAL_MINIMUM_ALERT_TEMP;
+int high = SMU_THERMAL_MAXIMUM_ALERT_TEMP;
+uint32_t val;
+struct smu_table_context *table_context = &smu->smu_table;
+struct smu_11_0_powerplay_table *powerplay_table = table_context->power_play_table;
+
+low = max(SMU_THERMAL_MINIMUM_ALERT_TEMP,
+range.min / SMU_TEMPERATURE_UNITS_PER_CENTIGRADES);
+high = min((uint16_t)SMU_THERMAL_MAXIMUM_ALERT_TEMP, powerplay_table->software_shutdown_temp);
+
+if (low > high)
+return -EINVAL;
+
+val = RREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_CTRL);
+val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, MAX_IH_CREDIT, 5);
+val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_IH_HW_ENA, 1);
+val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_INTH_MASK, 0);
+val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_INTL_MASK, 0);
+val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTH, (high & 0xff));
+val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTL, (low & 0xff));
+val = val & (~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK);
+
+WREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_CTRL, val);
+
+return 0;
+}
+
+static uint32_t navi10_get_max_power_limit(struct smu_context *smu) {
+uint32_t od_limit, max_power_limit;
+struct smu_11_0_powerplay_table *powerplay_table = NULL;
+struct smu_table_context *table_context = &smu->smu_table;
+powerplay_table = table_context->power_play_table;
+
+max_power_limit = smu_get_pptable_power_limit(smu);
+
+if (!max_power_limit) {
+// If we couldn't get the table limit, fall back on first-read value
+if (!smu->default_power_limit)
+smu->default_power_limit = smu->power_limit;
+max_power_limit = smu->default_power_limit;
+}
+
+if (smu->od_enabled) {
+od_limit = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+
+pr_debug("ODSETTING_POWERPERCENTAGE: %d (default: %d)\n", od_limit, smu->default_power_limit);
+
+max_power_limit *= (100 + od_limit);
+max_power_limit /= 100;
+}
+
+return max_power_limit;
+}
+
 static const struct pptable_funcs navi10_ppt_funcs = {
 .tables_init = navi10_tables_init,
 .alloc_dpm_context = navi10_allocate_dpm_context,
@@ -2348,6 +2408,8 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 .run_btc = navi10_run_btc,
 .disable_umc_cdr_12gbps_workaround = navi10_disable_umc_cdr_12gbps_workaround,
 .set_power_source = smu_v11_0_set_power_source,
+.set_thermal_range = navi10_set_thermal_range,
+.get_max_power_limit = navi10_get_max_power_limit,
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
+((smu)->ppt_funcs->set_thermal_range ? (smu)->ppt_funcs->set_thermal_range((smu), (range)) : 0)
+#define smu_get_max_power_limit(smu) \
+((smu)->ppt_funcs->get_max_power_limit ? (smu)->ppt_funcs->get_max_power_limit((smu)) : 0)
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
-uint32_t od_limit, max_power_limit;
-struct smu_11_0_powerplay_table *powerplay_table = NULL;
-struct smu_table_context *table_context = &smu->smu_table;
-powerplay_table = table_context->power_play_table;
-
-max_power_limit = smu_get_pptable_power_limit(smu);
-
-if (!max_power_limit) {
-// If we couldn't get the table limit, fall back on first-read value
-if (!smu->default_power_limit)
-smu->default_power_limit = smu->power_limit;
-max_power_limit = smu->default_power_limit;
-}
-
-if (smu->od_enabled) {
-od_limit = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
-
-pr_debug("ODSETTING_POWERPERCENTAGE: %d (default: %d)\n", od_limit, smu->default_power_limit);
-
-max_power_limit *= (100 + od_limit);
-max_power_limit /= 100;
-}
-
-return max_power_limit;
-}
-
 int smu_v11_0_set_power_limit(struct smu_context *smu, uint32_t n)
 {
 int ret = 0;
@@ -1128,7 +1100,7 @@ int smu_v11_0_set_power_limit(struct smu_context *smu, uint32_t n)
 if (amdgpu_sriov_vf(smu->adev))
 return 0;

-max_power_limit = smu_v11_0_get_max_power_limit(smu);
+max_power_limit = smu_get_max_power_limit(smu);

 if (n > max_power_limit) {
 pr_err("New power limit (%d) is over the max allowed %d\n",
@@ -1186,37 +1158,6 @@ int smu_v11_0_get_current_clk_freq(struct smu_context *smu,
 return ret;
 }

-static int smu_v11_0_set_thermal_range(struct smu_context *smu,
-       struct smu_temperature_range range)
-{
-struct amdgpu_device *adev = smu->adev;
-int low = SMU_THERMAL_MINIMUM_ALERT_TEMP;
-int high = SMU_THERMAL_MAXIMUM_ALERT_TEMP;
-uint32_t val;
-struct smu_table_context *table_context = &smu->smu_table;
-struct smu_11_0_powerplay_table *powerplay_table = table_context->power_play_table;
-
-low = max(SMU_THERMAL_MINIMUM_ALERT_TEMP,
-range.min / SMU_TEMPERATURE_UNITS_PER_CENTIGRADES);
-high = min((uint16_t)SMU_THERMAL_MAXIMUM_ALERT_TEMP, powerplay_table->software_shutdown_temp);
-
-if (low > high)
-return -EINVAL;
-
-val = RREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_CTRL);
-val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, MAX_IH_CREDIT, 5);
-val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_IH_HW_ENA, 1);
-val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_INTH_MASK, 0);
-val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_INTL_MASK, 0);
-val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTH, (high & 0xff));
-val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTL, (low & 0xff));
-val = val & (~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK);
-
-WREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_CTRL, val);
-
-return 0;
-}
-
 static int smu_v11_0_enable_thermal_alert(struct smu_context *smu)
 {
 struct amdgpu_device *adev = smu->adev;
@@ -1244,7 +1185,7 @@ int smu_v11_0_start_thermal_control(struct smu_context *smu)
 return ret;

 if (smu->smu_table.thermal_controller_type) {
-ret = smu_v11_0_set_thermal_range(smu, range);
+ret = smu_set_thermal_range(smu, range);
[Quan, Evan] It seems you were not working on the latest code. And the sequence here can be revised a little to avoid cross calling.
smu_enable_thermal_alert (from smu.c)
|
|-- navi10_enable_thermal_alert (from navi10_ppt.c)
      |-- naiv10_get_thermal_temperature_range()
      |-- navi10_set_thermal_temperature_range()
      |-- smu_v11_0_set_thermal_alert()

 if (ret)
 return ret;

--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
