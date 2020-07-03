Return-Path: <SRS0=khk6=AO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1F6C433E1
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 08:58:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 140FC207DA
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 08:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="E33SrS5m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 140FC207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD5C46E1ED;
	Fri,  3 Jul 2020 08:58:56 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 990A56E1ED
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jul 2020 08:58:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rujoyz45dg+a8cSTXyKWv4/k//6HhMCdcoNMWESoFayRtfIWLNgxxg9TSRIo05O4vUzSd3IeRbnqfoZ+7ye9Vf6t1RyQMEMyQWGm1WnqylZqkL2X3PyRcHnLDC78BgNbb4GMXvwy3WmVTLegEd6enlVGOKBjPynv8US6aINbwv7UcyWvo1wyyKMruvvr2bqvTv7n8PY21f2M6jNm1HhoP30YyvJ673Ow9/jimSmB6apTbkaoNUJuPMaL78gChJK8FECW2+1ng57yigI+AIzgqbqBN5npJGi5Vmcf5a28XYwrnR5DPlfvMOXO4xfPZta96orm8lQ1BkwbPCXjGF4+8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbBo0026jU6LnZ1kiyPBzdGJMDc2f5S0Z887Nlg8cZI=;
 b=Di0JzcOwbrfdQy2YpIvDl36LTeGslgHBT1JiSh9hgJQu/lGLVJbWXmnACmoiMpWN9QcVxAYmjXr5JOWdgI4DK/diFBSXfBcIeFqLrdPADNeCmn4+fYV7jJCSlin29u9XySEpBDSXYW2cp1k29krbbIcF0ZI8RqGJB52oY2/tUu0Sj0LTnp0ciFsApdwP5aYQPXl5ifolBixV2lgVEgw2w2ZRaMeJIsNK53QzuS/1f0j9dmvUHeEF/QR7RQr6r6SdjzeIeflwtWsbdfRnxiHad+hy7PuUq/HIO60zhKBDUmrwAbFyKilzvxQRHGA/4GKWY6a+teO9TDOW3eHUXhsqfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbBo0026jU6LnZ1kiyPBzdGJMDc2f5S0Z887Nlg8cZI=;
 b=E33SrS5mi+wTyoqrAOeB+K5v+BnWR4aCoaTEtDNzhND4yDSanM+xumiDUX8w3BEhFz/IW+ICgUVlxJEMWZHYky/8ereQaD583NaHEktnfoZAIr/oiIQLR51Td5Ca1rpPIOJRLfLXUq6qbUcRwrWuPEZcv/LhZ/up9tYB27RibVM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4353.namprd12.prod.outlook.com (2603:10b6:5:2a6::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.20; Fri, 3 Jul 2020 08:58:54 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3153.023; Fri, 3 Jul 2020
 08:58:54 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/6] drm/amd/powerplay: sort the call flow on temperature
 ranges retrieving
Date: Fri,  3 Jul 2020 16:58:16 +0800
Message-Id: <20200703085818.7800-4-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200703085818.7800-1-evan.quan@amd.com>
References: <20200703085818.7800-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2P15301CA0023.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::33) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2P15301CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.1 via Frontend Transport; Fri, 3 Jul 2020 08:58:53 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 429bae2f-26de-41af-1249-08d81f2f503b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4353:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4353FCA937551DF2F19E7FA6E46A0@DM6PR12MB4353.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:70;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RwYBvOaC2yDmkog9B7fVSHrhtl5dSKiMneQkiuniZxQs1d3dlDrJp8Th28LjuMP5XxvYVRY7zPTIvPKNJ+iSFW2V6uyARCeXFdjdCv7jSzjvdDjsiIkSaI9swfusv0C0wet/2iLLbXATHr23XJLfyrpusBtl1x8BVbocH9JKBtPtSxKWeC6AZYyKqSAERLMrsCidjqbXXkUUePhbAMTFH0ZdmRg7LaLKwCbZMVtdK/00B+h6gNZdvWCAUYJKkrvoULzszZMRCL8YSqWwpzfYlS9dmyayhMm1ClNqrsni8zuIAAnx7X09trDNcONOUM74keNF15tKEQD5aExw7ovzzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(956004)(478600001)(86362001)(4326008)(6486002)(8676002)(2906002)(8936002)(5660300002)(36756003)(83380400001)(6666004)(2616005)(6916009)(186003)(316002)(44832011)(66476007)(52116002)(1076003)(26005)(66946007)(66556008)(16526019)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: NRIt49uw9HMzVoJgU7fimqc3ZIRdZEAvdpIacciRn0v/qTgbBP8CHyEV2kZSJc3sqXFKwLeJm2DOCjXckALxXbeYfuC5OyNTxp4QLKaS4x+dRkYcsQa1QLCaHsdkNmGDa3FMM5AJ7wpDriEF2vGeW7PmTfYlGpy2oNIRuiBC2zHDxM0S9Pn3W3MvWMTdspkXnBz1Hj20Qx+4EDAddNUxkMKpfhvgYwdymdtKzy5ciY5dKwn8TmEff4KczFg+qoyp+DPcqqutM8QQCwAyGC4bqj1P8r3LR0p817z+liu0vjbRngokPjIacEfghpWttfmcH23Qs0he1WMGyeACF7gf08GZZKeG+MC1pwcS5XlV/YzUrLelYScH+sAY3H0r4e5lnMli9AnRzDK0cCwb3FvR9IhvabQ3yGxpgCRe8W6LNAH7VCjYy000k4B3eZuxugJ4tw8XtN6Px3o3LV+TkGjtfabAvqzKPT3KOcw6wiYpRoEiw1O1dPT1f6EIfsX3fSz0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 429bae2f-26de-41af-1249-08d81f2f503b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 08:58:54.5716 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DDtM3BsYnUZdbifDO96N/nM5UTt3sgNNUBeevBBpTGiJU3CYC2gd9UiAvN8m1QnO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4353
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This can help to maintain clear code layer.

Change-Id: I9c95dd70273ab56c1ddb40592574ed283a34737f
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 33 +++++++++++++++++++
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  |  2 ++
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  2 +-
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    |  2 ++
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    |  2 ++
 drivers/gpu/drm/amd/powerplay/smu_internal.h  |  1 -
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 19 +----------
 7 files changed, 41 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 3d62a99bad84..16ff64644e2e 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -991,6 +991,33 @@ static int smu_sw_fini(void *handle)
 	return 0;
 }
 
+static int smu_get_thermal_temperature_range(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	struct smu_temperature_range *range =
+				&smu->thermal_range;
+	int ret = 0;
+
+	if (!smu->ppt_funcs->get_thermal_temperature_range)
+		return 0;
+
+	ret = smu->ppt_funcs->get_thermal_temperature_range(smu, range);
+	if (ret)
+		return ret;
+
+	adev->pm.dpm.thermal.min_temp = range->min;
+	adev->pm.dpm.thermal.max_temp = range->max;
+	adev->pm.dpm.thermal.max_edge_emergency_temp = range->edge_emergency_max;
+	adev->pm.dpm.thermal.min_hotspot_temp = range->hotspot_min;
+	adev->pm.dpm.thermal.max_hotspot_crit_temp = range->hotspot_crit_max;
+	adev->pm.dpm.thermal.max_hotspot_emergency_temp = range->hotspot_emergency_max;
+	adev->pm.dpm.thermal.min_mem_temp = range->mem_min;
+	adev->pm.dpm.thermal.max_mem_crit_temp = range->mem_crit_max;
+	adev->pm.dpm.thermal.max_mem_emergency_temp = range->mem_emergency_max;
+
+	return ret;
+}
+
 static int smu_smc_hw_setup(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -1095,6 +1122,12 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 		return ret;
 	}
 
+	ret = smu_get_thermal_temperature_range(smu);
+	if (ret) {
+		dev_err(adev->dev, "Failed to get thermal temperature ranges!\n");
+		return ret;
+	}
+
 	ret = smu_enable_thermal_alert(smu);
 	if (ret) {
 		dev_err(adev->dev, "Failed to enable thermal alert!\n");
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 6518acf4df0a..209ccf38c020 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -1037,6 +1037,8 @@ static int arcturus_get_thermal_temperature_range(struct smu_context *smu,
 	if (!range)
 		return -EINVAL;
 
+	memcpy(range, &smu11_thermal_policy[0], sizeof(struct smu_temperature_range));
+
 	range->max = pptable->TedgeLimit *
 		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 	range->edge_emergency_max = (pptable->TedgeLimit + CTF_OFFSET_EDGE) *
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 4251f7dc3d68..dede24959652 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -146,7 +146,6 @@ struct smu_power_state {
 	struct smu_state_pcie_block                   pcie;
 	struct smu_state_display_block                display;
 	struct smu_state_memroy_block                 memory;
-	struct smu_temperature_range                  temperatures;
 	struct smu_state_software_algorithm_block     software;
 	struct smu_uvd_clocks                         uvd_clocks;
 	struct smu_hw_power_state                     hardware;
@@ -386,6 +385,7 @@ struct smu_context
 	struct smu_feature		smu_feature;
 	struct amd_pp_display_configuration  *display_config;
 	struct smu_baco_context		smu_baco;
+	struct smu_temperature_range	thermal_range;
 	void *od_settings;
 #if defined(CONFIG_DEBUG_FS)
 	struct dentry                   *debugfs_sclk;
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 0a1e1835f455..a04a0ba632a9 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -1864,6 +1864,8 @@ static int navi10_get_thermal_temperature_range(struct smu_context *smu,
 	if (!range)
 		return -EINVAL;
 
+	memcpy(range, &smu11_thermal_policy[0], sizeof(struct smu_temperature_range));
+
 	range->max = pptable->TedgeLimit *
 		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 	range->edge_emergency_max = (pptable->TedgeLimit + CTF_OFFSET_EDGE) *
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 18a7b695b128..4180b9196504 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -1652,6 +1652,8 @@ static int sienna_cichlid_get_thermal_temperature_range(struct smu_context *smu,
 	if (!range)
 		return -EINVAL;
 
+	memcpy(range, &smu11_thermal_policy[0], sizeof(struct smu_temperature_range));
+
 	range->max = pptable->TemperatureLimit[TEMP_EDGE] *
 		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 	range->edge_emergency_max = (pptable->TemperatureLimit[TEMP_EDGE] + CTF_OFFSET_EDGE) *
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index 5deb30452ff8..db11b9e28646 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -85,7 +85,6 @@
 #define smu_dpm_set_jpeg_enable(smu, enable)				smu_ppt_funcs(dpm_set_jpeg_enable, 0, smu, enable)
 #define smu_set_watermarks_table(smu, tab, clock_ranges)		smu_ppt_funcs(set_watermarks_table, 0, smu, tab, clock_ranges)
 #define smu_thermal_temperature_range_update(smu, range, rw)		smu_ppt_funcs(thermal_temperature_range_update, 0, smu, range, rw)
-#define smu_get_thermal_temperature_range(smu, range)			smu_ppt_funcs(get_thermal_temperature_range, 0, smu, range)
 #define smu_register_irq_handler(smu)					smu_ppt_funcs(register_irq_handler, 0, smu)
 #define smu_get_dpm_ultimate_freq(smu, param, min, max)			smu_ppt_funcs(get_dpm_ultimate_freq, 0, smu, param, min, max)
 #define smu_asic_set_performance_level(smu, level)			smu_ppt_funcs(set_performance_level, -EINVAL, smu, level)
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 34bb0f0320f6..3404db490eb3 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1086,17 +1086,10 @@ int smu_v11_0_set_power_limit(struct smu_context *smu, uint32_t n)
 int smu_v11_0_enable_thermal_alert(struct smu_context *smu)
 {
 	int ret = 0;
-	struct smu_temperature_range range;
 	struct amdgpu_device *adev = smu->adev;
 
-	memcpy(&range, &smu11_thermal_policy[0], sizeof(struct smu_temperature_range));
-
-	ret = smu_get_thermal_temperature_range(smu, &range);
-	if (ret)
-		return ret;
-
 	if (smu->smu_table.thermal_controller_type) {
-		ret = smu_set_thermal_range(smu, range);
+		ret = smu_set_thermal_range(smu, smu->thermal_range);
 		if (ret)
 			return ret;
 
@@ -1109,16 +1102,6 @@ int smu_v11_0_enable_thermal_alert(struct smu_context *smu)
 			return ret;
 	}
 
-	adev->pm.dpm.thermal.min_temp = range.min;
-	adev->pm.dpm.thermal.max_temp = range.max;
-	adev->pm.dpm.thermal.max_edge_emergency_temp = range.edge_emergency_max;
-	adev->pm.dpm.thermal.min_hotspot_temp = range.hotspot_min;
-	adev->pm.dpm.thermal.max_hotspot_crit_temp = range.hotspot_crit_max;
-	adev->pm.dpm.thermal.max_hotspot_emergency_temp = range.hotspot_emergency_max;
-	adev->pm.dpm.thermal.min_mem_temp = range.mem_min;
-	adev->pm.dpm.thermal.max_mem_crit_temp = range.mem_crit_max;
-	adev->pm.dpm.thermal.max_mem_emergency_temp = range.mem_emergency_max;
-
 	return ret;
 }
 
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
