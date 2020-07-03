Return-Path: <SRS0=khk6=AO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47066C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 08:58:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FA38207DA
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 08:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="njFelv0A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FA38207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7E8D6E1C0;
	Fri,  3 Jul 2020 08:58:50 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37B056E1C0
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jul 2020 08:58:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DsyL3qOadpnhUqlcj3HbiXIoBCOM5m+dix9tzIB57L75ZpSdli8tAmwneWvQpdu2NUNHLb8axViu6dg5Vs62zjATp+C8Zhw0OtKPHUf9kxmI4TwuG6UzApMCfIFnqP7ZBXrJ3LNRreeu3pVECioft1CBM4k22zRcDj7POcl9NxLYVwkjon33yAhHsfcZj71bq53ba1/W8gNSHw7u4ATNoGUddGSc9khwxYM/aat5aiip8rkLHTWARHxtAPHUuFjiG9zhVJxKwDCU7qzzL+OFlGl32/OdIHJ9pM4A9gyg3+RMBIm2jiCuEFu2lB2D+BBkcl3WhdOusjImkiBJcJYG0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uXQ8C+3v47teiHwB2FLiKCUXt3PaNEBMoUDukxOr+c=;
 b=YtkcMjItHF+IwAgaQB+pCz3AvK/WZV+gt8lX7n9h1fZ1+wpL6It0QkIB5IGASRHIzB+U5kD541c3AMDEEORH3MBHMY/S7SEvgnYwtwKyrHYdTqeWCd4OQLobqluheVkdm5MMtNCgL6rJgvgJQX2OMq4HXNuLaCltIM9rWlBMMOyRWEa/AoPrHoLgtMDV/W0fGNxZ9rChq2OrFJr7Fcgn1o/eQgLy6E4QXALw8ePKDWHgXRl0proNnCvA+lDb/wwM4HUVMeJ5I8g2pByvcRCp4/8QuI7EHc21AtifsGfqt8Ev7IPMDWZlhI9F43sKbFpYH4o0udNerBY7d0YXDtXGUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uXQ8C+3v47teiHwB2FLiKCUXt3PaNEBMoUDukxOr+c=;
 b=njFelv0AKam9svSBh5FyTDfyXSIOAFUkyU1OCc76RBISAoiNQUpaiNygLZzh4mBI2Uh3Ou+StVBkXIHZQf8JoATGYRYEWl3HfaXWJACqs9oCcgLMj6zk5zKAPhZbVu7DiU+k93B53feOLqFPUi2fwrTSksmsYXOsyWfp2y1DHyI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4353.namprd12.prod.outlook.com (2603:10b6:5:2a6::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.20; Fri, 3 Jul 2020 08:58:49 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3153.023; Fri, 3 Jul 2020
 08:58:49 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/6] drm/amd/powerplay: cache the software_shutdown_temp
Date: Fri,  3 Jul 2020 16:58:15 +0800
Message-Id: <20200703085818.7800-3-evan.quan@amd.com>
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
 15.20.3174.1 via Frontend Transport; Fri, 3 Jul 2020 08:58:47 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b6cd5f0d-9449-4a16-6ce1-08d81f2f4cf3
X-MS-TrafficTypeDiagnostic: DM6PR12MB4353:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4353B97DDA6BA04CE572D1BFE46A0@DM6PR12MB4353.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4u3wWQGlmhJcBsivnR9K3NKoP6EqAR9Tlx2oNrPsx+klkAsMwm/r1ERdUNJvzp0iDjuwZRWwENh4tDCDiO/yf8Qg2HQm+DNuHdtKo3EHJa9WwaBjQ+Sncz7DY1tC3QpIVddVwHQRHIPMJatMw0GRQJm2g0gDVwzWrkBTRR4P8VZY4KszXPAiIH3TNs1nRCXinFVVOaqcixWwm0RxYscWlWpbAlQoP4lpiYpjWpMJXJQemPjpRFCL7yMgRgdVFV1LDfYCTeMxdtQM/Sr/sXPUehlmRCmxtk8ls0odv7XxNoeSFw16ELiZNja4A12mTlUD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(956004)(478600001)(86362001)(4326008)(6486002)(8676002)(2906002)(8936002)(5660300002)(36756003)(83380400001)(6666004)(2616005)(6916009)(186003)(316002)(44832011)(66476007)(52116002)(1076003)(26005)(66946007)(66556008)(16526019)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: xxPjtMKKdLm5kYmsRfm81DPX5TN+Z/RREPqZYWWGfu+Eba8k+yJuf/KttGaSZXrjjmlQJ3CVXAS67LDtNZ1sM9gBUmrhfnchlKk3j+CKsTveXYy9u44jcxfGh31z1CQbeVUD59iyjnWDGYjDodeOBxUkOF1wvzfPOVQah/FgjWfBARf8yp03GEf32o1QfiWid5ET+qVJE9jXHjeiIjNU8YneeCqj4gLTO9ooKqxrhXXtkEKb6D0T5+FDDtPa5aoBl2aEQd1oUe7fYBFAzBg0bb2OqkamWpRm3K9YICD+0mbu1Yv78jNqTxGanHHbcfeq+GiZe5gccaerWe/xbOfmnaprIglT/cdsZqK9RWBZkaZbNPnbWe/mn/GC6sTuSVNj9Cs8SUvngpBF7lpnVsAIgjvh7tzQOEJbvG5zPOCHq9XLIn8eD4S8q1uT5fF+eiz64rxuDOiWH3s39W2h8McWjT1khUQfDLm7npkNyEoTVfceStCdwVIdRDCIlO4SXkzJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6cd5f0d-9449-4a16-6ce1-08d81f2f4cf3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 08:58:49.0599 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 25VsTwbAyJ+1OpyqJ3Seasy/cV6ldAVLvbknspN1qK2SZYl+NHpUwWZasO4K8Lb3
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

As it's needed in the succeeding thermal irq setting.

Change-Id: Iee34fb6515a88a684c7f1214e40edb7e65245f8d
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c       | 4 ++++
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h     | 1 +
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c         | 4 ++++
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c | 4 ++++
 4 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 0b33cde05133..6518acf4df0a 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -1029,6 +1029,9 @@ static int arcturus_force_clk_levels(struct smu_context *smu,
 static int arcturus_get_thermal_temperature_range(struct smu_context *smu,
 						struct smu_temperature_range *range)
 {
+	struct smu_table_context *table_context = &smu->smu_table;
+	struct smu_11_0_powerplay_table *powerplay_table =
+				table_context->power_play_table;
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
 
 	if (!range)
@@ -1046,6 +1049,7 @@ static int arcturus_get_thermal_temperature_range(struct smu_context *smu,
 		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 	range->mem_emergency_max = (pptable->TmemLimit + CTF_OFFSET_MEM)*
 		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+	range->software_shutdown_temp = powerplay_table->software_shutdown_temp;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index ba8e162f44ab..4251f7dc3d68 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -119,6 +119,7 @@ struct smu_temperature_range {
 	int mem_min;
 	int mem_crit_max;
 	int mem_emergency_max;
+	int software_shutdown_temp;
 };
 
 struct smu_state_validation_block {
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 350b469646bd..0a1e1835f455 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -1856,6 +1856,9 @@ static int navi10_get_uclk_dpm_states(struct smu_context *smu, uint32_t *clocks_
 static int navi10_get_thermal_temperature_range(struct smu_context *smu,
 						struct smu_temperature_range *range)
 {
+	struct smu_table_context *table_context = &smu->smu_table;
+	struct smu_11_0_powerplay_table *powerplay_table =
+				table_context->power_play_table;
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
 
 	if (!range)
@@ -1873,6 +1876,7 @@ static int navi10_get_thermal_temperature_range(struct smu_context *smu,
 		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 	range->mem_emergency_max = (pptable->TmemLimit + CTF_OFFSET_MEM)*
 		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+	range->software_shutdown_temp = powerplay_table->software_shutdown_temp;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index afa8e46cd2ab..18a7b695b128 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -1644,6 +1644,9 @@ static int sienna_cichlid_get_uclk_dpm_states(struct smu_context *smu, uint32_t
 static int sienna_cichlid_get_thermal_temperature_range(struct smu_context *smu,
 						struct smu_temperature_range *range)
 {
+	struct smu_table_context *table_context = &smu->smu_table;
+	struct smu_11_0_7_powerplay_table *powerplay_table =
+				table_context->power_play_table;
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
 
 	if (!range)
@@ -1661,6 +1664,7 @@ static int sienna_cichlid_get_thermal_temperature_range(struct smu_context *smu,
 		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 	range->mem_emergency_max = (pptable->TemperatureLimit[TEMP_MEM] + CTF_OFFSET_MEM)*
 		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+	range->software_shutdown_temp = powerplay_table->software_shutdown_temp;
 
 	return 0;
 }
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
