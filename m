Return-Path: <SRS0=75wA=7W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2665C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2020 10:10:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC8CE2078D
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2020 10:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HO4fuf+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC8CE2078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EBB46E059;
	Tue,  9 Jun 2020 10:10:16 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82C316E059
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jun 2020 10:10:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CNYAQY2l/bYInWhqv2P0g6QyDKNQ4eQJcQ7/+A1NVSTsuDPCrjMd1+8vW1I3O3xgCdCZUrHpbtM39GyoAqsmDGl7Tb7K3VqvRMeWS9F7G0OQ1bYmy3U6NYCmr2TtDoda+Jt6qy3HdSuluzOqTXYCPOoimg3GcEz0jeZMEWjL11DF5ccb2kPkhAJYRw1Psfvtrom8GNj8zIA1MZ/V+Kyoh829wSqpW7Alv3vLfvbrOB+tnz3creyOYrLUu3EHXvP6JRjwoHH2vWxJT2PeHW2Yq/knDlWbVpsZp3GjOtGFaIBxrffkKylG/Dq5uj3yiOqZajUOshS3z1wv1WwqOxundw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4GkgkgdseHBzPXYgG/NUtnteuYTyoS38x322D6Rzjg=;
 b=bG8ix3qbj3sF3DF8XWUl4ZeLqO6tbe8bhDm/qQjY1Ho/8ymF74dLxz4d8uhXoWcm6MND0gVO+DE0uDUdOsegJCH47oBft0rU7yH2URMN6tEn0cwwjcHB3++5KWZ7/6Tj+nqatHcqkdb+vmglUzUmOts643uSOm46cEnzGYoDUsX8x2sZDUhIT6dzsB1Te5AxjByBXML+D7hEWaVgS9kCcgsxbxGjd+Lr8xshWYsnNKvGuHuc6PBP2e3QzSw65NVKwo7pZ04yZs4jT/xsvfODCb/fVNnyXRFyy3A2LMbVjgrMljHJ1Y32Vf+3x45j0xUCnYys+ufQXJZFi98nZPXgfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4GkgkgdseHBzPXYgG/NUtnteuYTyoS38x322D6Rzjg=;
 b=HO4fuf+sxQlOyebPczcBkVEzU/7tL5D6qt7D8QJyW9Fn6dP1hbvGWGNRVjrOHRr1VK9p3usi2w/3HlINZQLNqlrXt2Ko7difRf1WI1EXgbNF5zmn0093UpHBFXOrTmTqIboM+CKm1Z30tGRe0Qms5fbOCSsislrHv06DmDHUbwM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3595.namprd12.prod.outlook.com (2603:10b6:5:118::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.22; Tue, 9 Jun 2020 10:10:13 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3066.023; Tue, 9 Jun 2020
 10:10:13 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/powerplay: drop redundant
 .set_min_dcefclk_deep_sleep API
Date: Tue,  9 Jun 2020 18:09:52 +0800
Message-Id: <20200609100953.11866-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
X-ClientProxiedBy: HKAPR04CA0005.apcprd04.prod.outlook.com
 (2603:1096:203:d0::15) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HKAPR04CA0005.apcprd04.prod.outlook.com (2603:1096:203:d0::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Tue, 9 Jun 2020 10:10:11 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e0a38bf3-1879-432c-f1d4-08d80c5d4c79
X-MS-TrafficTypeDiagnostic: DM6PR12MB3595:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB35957B11118CF2FF70F401CEE4820@DM6PR12MB3595.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:318;
X-Forefront-PRVS: 042957ACD7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: raGXV2kxGGjRzQEYBm9sOwi6NfzNDAec5VHY9wq8eFqnMMkUpFxBHxH7qr+GWtFmpeO8xR3JONeV0dt/d5/k0tytXbmXmDmNMr4c64JfTQ+bBUgQyjDId7AwwjiXuoJukDNzvP3+S8vlTovRdCPOQUEHAKavMUDu4SF84cjPze/KyQW02FDpG3fRWcHWpsABfZIp/iCgviRfdnF4ziGelYMWp3pVvfrZhuTYqccHwPBCNRp7UXdXci6es9sbDHbGSmBIPzNnYuZheUkfhBb+nvlKHu7mhMsKVgYmrSYA4+ehMxCR21+vBu0o7L/WJ85IFooC07Cr1vItHdDzKTMZgt0SbBXoiua+GxY0ysmfv8dDS4yNJkljbiYlwjCxuKtj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(136003)(39860400002)(396003)(346002)(366004)(83380400001)(1076003)(6666004)(2906002)(5660300002)(478600001)(52116002)(316002)(7696005)(8676002)(36756003)(66556008)(86362001)(2616005)(4326008)(6486002)(66476007)(6916009)(956004)(8936002)(66946007)(16526019)(186003)(44832011)(26005)(142923001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: fw/ycQ4T5jDqEpiJn9IAn1tG72iPMnyXQCX6MHu44WIBDn6A6sDC45yqWvN7vHHQhZNKrfEqOrnCO/M0NCXS0JaxZ8LbQpmW9nB0eFjNLnkdTp5oBAhbZGBiffqa2z1pYH7PKe495zODGWEVKPFxgoz5vYi0boQtB2rqYvChvgFfkEhYzBijy5l9UKaHwxTyyArAjtQCD4pkTcHiZ06SQU5dk/TLzu54xB4rZk2aKk3GTfFwVwK9fzkcRSqXwHoxbJudusJfk1/wgmVT6Uv2emvtqwdhcNQtzgSCAPhfXpQCHJiMjSoPu8t8s7+lIW1f7NDGDUl48n0C/4lRKQcNbBs+AA1qnA8siV58Mmel+O3p1Kz1b0d3/MUw1FZ3aoAR3oKtvoK61qbW84jiz6Lq2RZzKj6x+L7ztcfyPcUTKrpdEtxTQNxmX19C6WjhC5TUZNUESYJW2gEw44gss1g4974zn870Y4i1d51oH7UAttyutcWCPy743jVt43ev0Dq6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a38bf3-1879-432c-f1d4-08d80c5d4c79
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2020 10:10:12.9576 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: acX4W8c3b7JUEOW9AjfCT9JDbuu2BaI7A+pnAL35EGWizIR4HBnArHmunKd7D6Mp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3595
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

It has exactly the same functionality as .set_deep_sleep_dcefclk.

Change-Id: Ib4d2d604ca014e194cb2b61ac770e4370ecad74d
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c         | 11 +++++------
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c       |  3 +--
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h     |  1 -
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h      |  2 --
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c         |  1 -
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c |  3 +--
 drivers/gpu/drm/amd/powerplay/smu_internal.h       |  4 ++--
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c          | 10 ----------
 8 files changed, 9 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 6beae3b496be..89dd12536d58 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1269,7 +1269,8 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 	 * Set min deep sleep dce fclk with bootup value from vbios via
 	 * SetMinDeepSleepDcefclk MSG.
 	 */
-	ret = smu_set_min_dcef_deep_sleep(smu);
+	ret = smu_set_min_dcef_deep_sleep(smu,
+					  smu->smu_table.boot_values.dcefclk / 100);
 	if (ret)
 		return ret;
 
@@ -1584,9 +1585,8 @@ int smu_display_configuration_change(struct smu_context *smu,
 
 	mutex_lock(&smu->mutex);
 
-	if (smu->ppt_funcs->set_deep_sleep_dcefclk)
-		smu->ppt_funcs->set_deep_sleep_dcefclk(smu,
-				display_config->min_dcef_deep_sleep_set_clk / 100);
+	smu_set_min_dcef_deep_sleep(smu,
+				    display_config->min_dcef_deep_sleep_set_clk / 100);
 
 	for (index = 0; index < display_config->num_path_including_non_display; index++) {
 		if (display_config->displays[index].controller_id != 0)
@@ -2482,8 +2482,7 @@ int smu_set_deep_sleep_dcefclk(struct smu_context *smu, int clk)
 
 	mutex_lock(&smu->mutex);
 
-	if (smu->ppt_funcs->set_deep_sleep_dcefclk)
-		ret = smu->ppt_funcs->set_deep_sleep_dcefclk(smu, clk);
+	ret = smu_set_min_dcef_deep_sleep(smu, clk);
 
 	mutex_unlock(&smu->mutex);
 
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index c104844b28f1..96c9a348f8b3 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -2590,7 +2590,6 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.populate_smc_tables = smu_v11_0_populate_smc_pptable,
 	.check_fw_version = smu_v11_0_check_fw_version,
 	.write_pptable = smu_v11_0_write_pptable,
-	.set_min_dcef_deep_sleep = NULL,
 	.set_driver_table_location = smu_v11_0_set_driver_table_location,
 	.set_tool_table_location = smu_v11_0_set_tool_table_location,
 	.notify_memory_pool_location = smu_v11_0_notify_memory_pool_location,
@@ -2605,7 +2604,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.init_max_sustainable_clocks = smu_v11_0_init_max_sustainable_clocks,
 	.enable_thermal_alert = smu_v11_0_enable_thermal_alert,
 	.disable_thermal_alert = smu_v11_0_disable_thermal_alert,
-	.set_deep_sleep_dcefclk = smu_v11_0_set_deep_sleep_dcefclk,
+	.set_deep_sleep_dcefclk = NULL,
 	.display_clock_voltage_request = smu_v11_0_display_clock_voltage_request,
 	.get_fan_control_mode = smu_v11_0_get_fan_control_mode,
 	.set_fan_control_mode = smu_v11_0_set_fan_control_mode,
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 8eaa6338ad44..3420a58fad03 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -510,7 +510,6 @@ struct pptable_funcs {
 	int (*powergate_sdma)(struct smu_context *smu, bool gate);
 	int (*set_gfx_cgpg)(struct smu_context *smu, bool enable);
 	int (*write_pptable)(struct smu_context *smu);
-	int (*set_min_dcef_deep_sleep)(struct smu_context *smu);
 	int (*set_driver_table_location)(struct smu_context *smu);
 	int (*set_tool_table_location)(struct smu_context *smu);
 	int (*notify_memory_pool_location)(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index 2e9939beb128..9ccf62e99dcb 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -170,8 +170,6 @@ int smu_v11_0_check_fw_version(struct smu_context *smu);
 
 int smu_v11_0_write_pptable(struct smu_context *smu);
 
-int smu_v11_0_set_min_dcef_deep_sleep(struct smu_context *smu);
-
 int smu_v11_0_set_driver_table_location(struct smu_context *smu);
 
 int smu_v11_0_set_tool_table_location(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 115794557190..abbfcce6d9ad 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -2426,7 +2426,6 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.populate_smc_tables = smu_v11_0_populate_smc_pptable,
 	.check_fw_version = smu_v11_0_check_fw_version,
 	.write_pptable = smu_v11_0_write_pptable,
-	.set_min_dcef_deep_sleep = smu_v11_0_set_min_dcef_deep_sleep,
 	.set_driver_table_location = smu_v11_0_set_driver_table_location,
 	.set_tool_table_location = smu_v11_0_set_tool_table_location,
 	.notify_memory_pool_location = smu_v11_0_notify_memory_pool_location,
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 81cc04de9b06..6a9d04cac240 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -2596,7 +2596,6 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.populate_smc_tables = smu_v11_0_populate_smc_pptable,
 	.check_fw_version = smu_v11_0_check_fw_version,
 	.write_pptable = smu_v11_0_write_pptable,
-	.set_min_dcef_deep_sleep = NULL,
 	.set_driver_table_location = smu_v11_0_set_driver_table_location,
 	.set_tool_table_location = smu_v11_0_set_tool_table_location,
 	.notify_memory_pool_location = smu_v11_0_notify_memory_pool_location,
@@ -2611,7 +2610,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.init_max_sustainable_clocks = smu_v11_0_init_max_sustainable_clocks,
 	.enable_thermal_alert = smu_v11_0_enable_thermal_alert,
 	.disable_thermal_alert = smu_v11_0_disable_thermal_alert,
-	.set_deep_sleep_dcefclk = smu_v11_0_set_deep_sleep_dcefclk,
+	.set_deep_sleep_dcefclk = NULL,
 	.display_clock_voltage_request = smu_v11_0_display_clock_voltage_request,
 	.get_fan_control_mode = smu_v11_0_get_fan_control_mode,
 	.set_fan_control_mode = smu_v11_0_set_fan_control_mode,
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index 094db34ddbd1..86c09098963a 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -51,8 +51,8 @@
 	((smu)->ppt_funcs->check_fw_version ? (smu)->ppt_funcs->check_fw_version((smu)) : 0)
 #define smu_write_pptable(smu) \
 	((smu)->ppt_funcs->write_pptable ? (smu)->ppt_funcs->write_pptable((smu)) : 0)
-#define smu_set_min_dcef_deep_sleep(smu) \
-	((smu)->ppt_funcs->set_min_dcef_deep_sleep ? (smu)->ppt_funcs->set_min_dcef_deep_sleep((smu)) : 0)
+#define smu_set_min_dcef_deep_sleep(smu, clk) \
+	((smu)->ppt_funcs->set_deep_sleep_dcefclk ? (smu)->ppt_funcs->set_deep_sleep_dcefclk((smu), (clk)) : 0)
 #define smu_set_driver_table_location(smu) \
 	((smu)->ppt_funcs->set_driver_table_location ? (smu)->ppt_funcs->set_driver_table_location((smu)) : 0)
 #define smu_set_tool_table_location(smu) \
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 06e3799aa923..5590dab46e8c 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -782,16 +782,6 @@ int smu_v11_0_set_deep_sleep_dcefclk(struct smu_context *smu, uint32_t clk)
 	return ret;
 }
 
-int smu_v11_0_set_min_dcef_deep_sleep(struct smu_context *smu)
-{
-	struct smu_table_context *table_context = &smu->smu_table;
-
-	if (!table_context)
-		return -EINVAL;
-
-	return smu_v11_0_set_deep_sleep_dcefclk(smu, table_context->boot_values.dcefclk / 100);
-}
-
 int smu_v11_0_set_driver_table_location(struct smu_context *smu)
 {
 	struct smu_table *driver_table = &smu->smu_table.driver_table;
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
