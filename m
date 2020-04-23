Return-Path: <SRS0=mx+S=6H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E08C55191
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 07:02:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DE38208E4
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 07:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cu0kmHi7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DE38208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A47089E9B;
	Thu, 23 Apr 2020 07:02:00 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8E5289E59
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2020 07:01:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jtnsqrmy7DRt+7VIUCUNz/CW2OFsa3vg0Guy3ISDD2VBFG6WhzY6y5eegCgNvUMeRPaBB0LlmpmFR4hthTaepzeJj7AF8NiGJ3QSFd53q1WfX1eEPZABphbEG+QIfbA+vCT/CrRPzfr+Fzchgqi/uYqPeDqlmvIYOkIuGkG3KHpaI/b9BID3hdlobYu5tS2ILvVqmAWAqTVifzGR2ZgKK+g9z8j7+KWaZTKVyWNPzsH8EcbupM6HjrqFWZCywW9izcq//Zrv6hy/jCPdFfL2OD81rEO8l5ygvi6qz7YU3VaIGXJ1073q6ll8jZm49WTCkCE3ZrZ0tykU4VSI8YcIAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddJu/EDcLHjIJnUrFR4Wdp1J5Qbr1ddDF230PEch3E8=;
 b=PtuMYcnLeMznMInu3z5JhVLA21LppZahr2k1hk6QRY9/BdQ5jr9a9bmpGVScUQT7NbfHxykFqBdq60lQkuWY07k0RwqGUKtMIEc/FL5RRxpddiytsZnRRyQdqggkcS92Gplww7YmEFqDGVDeZPGJ3Wjdj3JdHwjqqb91Cqe54uxHkixPUXiq7WeqWU/GvA9v6kKQfJonqyAs/c5ksf20/w74mqBZtEqKMu9UYz2ZyX3BeoUw7dSX2GaO6tjo3vZLMogmfDUsuBOoMyt6y+bqxaysELnEAZFjLhusA167SkdS6pVMdiE0PGPuATn37MkFCkQNvYHM+hGO6z+D9VYK0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddJu/EDcLHjIJnUrFR4Wdp1J5Qbr1ddDF230PEch3E8=;
 b=cu0kmHi7RDQ0NPZr6CrlsBGQMi6lXXJoOU+RSvbQaOC/hTO4YZ5Smc7/n0BMA2FFFs5OnRCOo2taMoPl8BPg/9u5LbbpF5ch+AsXT6OtiwUn2U9/D8D3qoiXUTvzHoBQkp/5NXhz3bPq4H61CiDq5vlpU0LmS/3PJCF4lsOYAQQ=
Received: from MN2PR16CA0050.namprd16.prod.outlook.com (2603:10b6:208:234::19)
 by BY5PR12MB4305.namprd12.prod.outlook.com (2603:10b6:a03:213::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.26; Thu, 23 Apr
 2020 07:01:59 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:208:234:cafe::c6) by MN2PR16CA0050.outlook.office365.com
 (2603:10b6:208:234::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Thu, 23 Apr 2020 07:01:58 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2937.15 via Frontend Transport; Thu, 23 Apr 2020 07:01:58 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 23 Apr
 2020 02:01:56 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 23 Apr
 2020 02:01:56 -0500
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 23 Apr 2020 02:01:55 -0500
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/8] drm/amdgpu: enable one vf mode for nv12
Date: Thu, 23 Apr 2020 15:01:44 +0800
Message-ID: <1587625306-20704-6-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587625306-20704-1-git-send-email-Monk.Liu@amd.com>
References: <1587625306-20704-1-git-send-email-Monk.Liu@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(376002)(396003)(39860400002)(346002)(428003)(46966005)(426003)(6666004)(4326008)(82740400003)(2616005)(8676002)(81156014)(478600001)(26005)(47076004)(2906002)(8936002)(82310400002)(316002)(356005)(81166007)(7696005)(6916009)(186003)(70586007)(86362001)(336012)(36756003)(70206006)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5484a7f9-7409-4b85-2c3a-08d7e7543719
X-MS-TrafficTypeDiagnostic: BY5PR12MB4305:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4305841CA39E0CADD76B686F84D30@BY5PR12MB4305.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 03827AF76E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gw8e5dGfeYYK67tT4JLJ/uVRZ40dBimOcQTkIpW1xk1M11lzSK2dkQ+fo5SMZWHgLSFhBYJ4y9JzasowEjIzD4b17OP7Kx3Q6phs+9bxJzjumHV2nHqvDUEKkMfISUoNK9RpjHrYMuSmdtPuuCn5t08R/a6RmdOV9u62ZQvHjtBPe/M+cXoZXcgVwSUP6ltVYk0Y6W3afxjNu2NUwtegonezwfcehmSA8Q9SgRsQES0TTFgRuiR9B1fqd4hd3+84A9aKWlceaQikLWvV4vOGe6t1WdOQqhFnnuAdcq/HlxvWL2QGVWwzI5qAhRbL371qrZcH7G+k7D9r8QaWg1TXpvdizLzM5GjKPb3XUQHkwxghUx/+I+i6R8JG+J0WUTdjXvt3ft8RPMOcG7buUsQm1IadNTRaEPWFXNsDUXulMuta3XWuanN2mQBqKrdYPmucLQebGmeD6I4+sQNDmbksRFg2xP8AO9T9D9hEtq5H8lGJfUeN+uityeZazbmK9SSgBEYDvcMpScT7zj/Qm7aHsQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2020 07:01:58.3440 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5484a7f9-7409-4b85-2c3a-08d7e7543719
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4305
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
Cc: Monk Liu <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 12 +++-----
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c |  6 +++-
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c  | 49 +++++++++++++++++++++++++-----
 3 files changed, 52 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 361a5b6..5964d63 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -347,13 +347,13 @@ int smu_get_dpm_freq_by_index(struct smu_context *smu, enum smu_clk_type clk_typ
 	param = (uint32_t)(((clk_id & 0xffff) << 16) | (level & 0xffff));
 
 	ret = smu_send_smc_msg_with_param(smu, SMU_MSG_GetDpmFreqByIndex,
-					  param, &param);
+					  param, value);
 	if (ret)
 		return ret;
 
 	/* BIT31:  0 - Fine grained DPM, 1 - Dicrete DPM
 	 * now, we un-support it */
-	*value = param & 0x7fffffff;
+	*value = *value & 0x7fffffff;
 
 	return ret;
 }
@@ -535,7 +535,6 @@ int smu_update_table(struct smu_context *smu, enum smu_table_id table_index, int
 	int table_id = smu_table_get_index(smu, table_index);
 	uint32_t table_size;
 	int ret = 0;
-
 	if (!table_data || table_id >= SMU_TABLE_COUNT || table_id < 0)
 		return -EINVAL;
 
@@ -691,7 +690,6 @@ int smu_feature_is_enabled(struct smu_context *smu, enum smu_feature_mask mask)
 
 	if (smu->is_apu)
 		return 1;
-
 	feature_id = smu_feature_get_index(smu, mask);
 	if (feature_id < 0)
 		return 0;
@@ -1339,6 +1337,9 @@ static int smu_hw_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct smu_context *smu = &adev->smu;
 
+	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
+		return 0;
+
 	ret = smu_start_smc_engine(smu);
 	if (ret) {
 		pr_err("SMU is not ready yet!\n");
@@ -1352,9 +1353,6 @@ static int smu_hw_init(void *handle)
 		smu_set_gfx_cgpg(&adev->smu, true);
 	}
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	if (!smu->pm_enabled)
 		return 0;
 
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index c94270f..2184d24 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -1817,7 +1817,8 @@ static int navi10_get_power_limit(struct smu_context *smu,
 	int power_src;
 
 	if (!smu->power_limit) {
-		if (smu_feature_is_enabled(smu, SMU_FEATURE_PPT_BIT)) {
+		if (smu_feature_is_enabled(smu, SMU_FEATURE_PPT_BIT) &&
+			!amdgpu_sriov_vf(smu->adev)) {
 			power_src = smu_power_get_index(smu, SMU_POWER_SOURCE_AC);
 			if (power_src < 0)
 				return -EINVAL;
@@ -1960,6 +1961,9 @@ static int navi10_set_default_od_settings(struct smu_context *smu, bool initiali
 	OverDriveTable_t *od_table, *boot_od_table;
 	int ret = 0;
 
+	if (amdgpu_sriov_vf(smu->adev))
+		return 0;
+
 	ret = smu_v11_0_set_default_od_settings(smu, initialize, sizeof(OverDriveTable_t));
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index a97b296..3e1b3ed 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -57,7 +57,7 @@ static int smu_v11_0_send_msg_without_waiting(struct smu_context *smu,
 					      uint16_t msg)
 {
 	struct amdgpu_device *adev = smu->adev;
-	WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66, msg);
+	WREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_66, msg);
 	return 0;
 }
 
@@ -65,7 +65,7 @@ static int smu_v11_0_read_arg(struct smu_context *smu, uint32_t *arg)
 {
 	struct amdgpu_device *adev = smu->adev;
 
-	*arg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
+	*arg = RREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_82);
 	return 0;
 }
 
@@ -75,7 +75,7 @@ static int smu_v11_0_wait_for_response(struct smu_context *smu)
 	uint32_t cur_value, i, timeout = adev->usec_timeout * 10;
 
 	for (i = 0; i < timeout; i++) {
-		cur_value = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
+		cur_value = RREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_90);
 		if ((cur_value & MP1_C2PMSG_90__CONTENT_MASK) != 0)
 			return cur_value == 0x1 ? 0 : -EIO;
 
@@ -83,7 +83,10 @@ static int smu_v11_0_wait_for_response(struct smu_context *smu)
 	}
 
 	/* timeout means wrong logic */
-	return -ETIME;
+	if (i == timeout)
+		return -ETIME;
+
+	return RREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_90) == 0x1 ? 0 : -EIO;
 }
 
 int
@@ -107,9 +110,9 @@ smu_v11_0_send_msg_with_param(struct smu_context *smu,
 		goto out;
 	}
 
-	WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);
+	WREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);
 
-	WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82, param);
+	WREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_82, param);
 
 	smu_v11_0_send_msg_without_waiting(smu, (uint16_t)index);
 
@@ -119,6 +122,7 @@ smu_v11_0_send_msg_with_param(struct smu_context *smu,
 		       smu_get_message_name(smu, msg), index, param, ret);
 		goto out;
 	}
+
 	if (read_arg) {
 		ret = smu_v11_0_read_arg(smu, read_arg);
 		if (ret) {
@@ -728,8 +732,9 @@ int smu_v11_0_parse_pptable(struct smu_context *smu)
 	struct smu_table_context *table_context = &smu->smu_table;
 	struct smu_table *table = &table_context->tables[SMU_TABLE_PPTABLE];
 
+	/* during TDR we need to free and alloc the pptable */
 	if (table_context->driver_pptable)
-		return -EINVAL;
+		kfree(table_context->driver_pptable);
 
 	table_context->driver_pptable = kzalloc(table->size, GFP_KERNEL);
 
@@ -769,6 +774,9 @@ int smu_v11_0_set_deep_sleep_dcefclk(struct smu_context *smu, uint32_t clk)
 {
 	int ret;
 
+	if (amdgpu_sriov_vf(smu->adev))
+		return 0;
+
 	ret = smu_send_smc_msg_with_param(smu,
 					  SMU_MSG_SetMinDeepSleepDcefclk, clk, NULL);
 	if (ret)
@@ -812,6 +820,9 @@ int smu_v11_0_set_tool_table_location(struct smu_context *smu)
 	int ret = 0;
 	struct smu_table *tool_table = &smu->smu_table.tables[SMU_TABLE_PMSTATUSLOG];
 
+	if (amdgpu_sriov_vf(smu->adev))
+		return 0;
+
 	if (tool_table->mc_address) {
 		ret = smu_send_smc_msg_with_param(smu,
 				SMU_MSG_SetToolsDramAddrHigh,
@@ -831,6 +842,12 @@ int smu_v11_0_init_display_count(struct smu_context *smu, uint32_t count)
 {
 	int ret = 0;
 
+	if (amdgpu_sriov_vf(smu->adev))
+		return 0;
+
+	if (!smu->pm_enabled)
+		return ret;
+
 	ret = smu_send_smc_msg_with_param(smu, SMU_MSG_NumOfDisplays, count, NULL);
 	return ret;
 }
@@ -842,6 +859,9 @@ int smu_v11_0_set_allowed_mask(struct smu_context *smu)
 	int ret = 0;
 	uint32_t feature_mask[2];
 
+	if (amdgpu_sriov_vf(smu->adev))
+		return 0;
+
 	mutex_lock(&feature->mutex);
 	if (bitmap_empty(feature->allowed, SMU_FEATURE_MAX) || feature->feature_num < 64)
 		goto failed;
@@ -870,6 +890,9 @@ int smu_v11_0_get_enabled_mask(struct smu_context *smu,
 	struct smu_feature *feature = &smu->smu_feature;
 	int ret = 0;
 
+	if (amdgpu_sriov_vf(smu->adev) && !amdgpu_sriov_is_pp_one_vf(smu->adev))
+		return 0;
+
 	if (!feature_mask || num < 2)
 		return -EINVAL;
 
@@ -925,6 +948,12 @@ int smu_v11_0_notify_display_change(struct smu_context *smu)
 {
 	int ret = 0;
 
+	if (amdgpu_sriov_vf(smu->adev))
+		return 0;
+
+	if (!smu->pm_enabled)
+		return ret;
+
 	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT) &&
 	    smu->adev->gmc.vram_type == AMDGPU_VRAM_TYPE_HBM)
 		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetUclkFastSwitch, 1, NULL);
@@ -1084,6 +1113,9 @@ int smu_v11_0_set_power_limit(struct smu_context *smu, uint32_t n)
 	int ret = 0;
 	uint32_t max_power_limit;
 
+	if (amdgpu_sriov_vf(smu->adev))
+		return 0;
+
 	max_power_limit = smu_v11_0_get_max_power_limit(smu);
 
 	if (n > max_power_limit) {
@@ -1809,6 +1841,9 @@ int smu_v11_0_override_pcie_parameters(struct smu_context *smu)
 	uint32_t pcie_gen = 0, pcie_width = 0;
 	int ret;
 
+	if (amdgpu_sriov_vf(smu->adev))
+		return 0;
+
 	if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN4)
 		pcie_gen = 3;
 	else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
