Return-Path: <SRS0=khk6=AO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42689C433DF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 08:59:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 192B7207DA
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 08:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CSpSZz5N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 192B7207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C93086E1E0;
	Fri,  3 Jul 2020 08:59:03 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C6536E1FB
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jul 2020 08:59:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADEc/gb70VAc/kyPnMco4omX0uW1uz2y3zVX/aXkRiUVb0N7RfFg/S0jsZHhr22BzyhhYq8gwsm7Fx7XYi145peJHNz0SyME564bJQhPPRkemCnBezrfNy+hWGY9ta20laBGP66167Hzo/za8u0xKBvlJ3Mj3Kh3mLa7k53VLZG5XpHrIiinh24nmlRXj7uMJy79uK8CZP7hywyU+MURdnKzMzRed+6uKwIzqdn3GNJnEkEuuIIq63wrdV8Sq5RaXfAOiTtNle2dFJ7GaRTvqVTyCBwPDAvc6x6iLgda3IPUAlBdMx9rjdGcx8041FgXUDqp2APW2KHw6Bjeb42o/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsWl1lRe1U4mOFkt6c/QltoGWLHAaW5s2uJJ3KkQTFU=;
 b=PflNK+IScA6pQoko1zDlm5OZ5d43QNQL7vNNwFQ5bn5K9ahyitXu4DcJLKNon1/n+aLUTEzx8zh/e1LRtNgKVkCh5cKkt6nm/Q2HqBv7p49N5nMSXdSpJrr8sz3VzitwX7BauR+4TFJhYVmyRd8wXrKAxKkgHgyI4xN2fO8lNF/iw0V4YQcCSFqkcIaCcMjj9rcZ5IFfQ/xDqfBsYknwsPpFmyHyhin2ApAH9BZnL/kLQqNTYPA0nFtD3qENow7DKrysC8MjvIK0NrTBhipXtVFloiSPEB6vuxXlFv8s/Rw/toyIQXYsV+91QRLYAiE1QwqRFuUVbzHXzdJrvZv+SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsWl1lRe1U4mOFkt6c/QltoGWLHAaW5s2uJJ3KkQTFU=;
 b=CSpSZz5Nsz3LDOqCKUXNJg3AcrQYWQxK80VgdRoxYr7P+rDiiIhRBha4T1//+TWH8kgGzxOaVopd7wWSXLY8SbMiPXjn1RrP8BuaLeBgsUOc0lL31nIXoQ3A9zsLho3Yh5WEEJwLHXKQe2E67zXOaUOBWZCjj0R7IvDYjh6Qo7A=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4353.namprd12.prod.outlook.com (2603:10b6:5:2a6::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.20; Fri, 3 Jul 2020 08:59:01 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3153.023; Fri, 3 Jul 2020
 08:59:01 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/6] drm/amd/powerplay: drop unused code around thermal range
 setting
Date: Fri,  3 Jul 2020 16:58:18 +0800
Message-Id: <20200703085818.7800-6-evan.quan@amd.com>
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
 15.20.3174.1 via Frontend Transport; Fri, 3 Jul 2020 08:58:59 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: aa0278e5-3a70-4a84-0df1-08d81f2f5436
X-MS-TrafficTypeDiagnostic: DM6PR12MB4353:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB43533D0E3148A7E594CC99F0E46A0@DM6PR12MB4353.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:65;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g4esk1Na7JnG6R5lfxx9exuaurFHkgz+DoWF4c5uJYAIUGUzlHY2d5FwFa7akDCFfXh+TfD8fiGe19syzhtXYKMJu41jDqz3ZV5f1A0mNNzP+01ryCkIrNJS7Gt7At2PP/Hh4LYTjUNlJ5Jp5Dl1JF99d73piYrYvLyXpVbDkXcx/UTbn3MQJg8rg6QVA4rCrdvAiOgqrs+9j3EubdncJ38Ote5icTZucxrVig//F3rYEtDLPiHzy95ApAU5Ty1MUgxB4dBdeLOPt6384RkKblOy0mOVlxnqppUMxpFmKBN+ihLIOO6lPekmBw8p7cLuHAP3U1sOoZY0R4DqNd47OQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(956004)(478600001)(30864003)(86362001)(4326008)(6486002)(8676002)(2906002)(8936002)(5660300002)(36756003)(83380400001)(6666004)(66574015)(2616005)(6916009)(186003)(316002)(44832011)(66476007)(52116002)(1076003)(26005)(66946007)(66556008)(16526019)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: e37n5h9+s7ThARRabZb6Zi4wnRrLO4e/LuVQrS0HD70+IunrFEpOMngXnMsgTHBcF0ME0VrNuOmPyCNPg+zgCLExMp/usGn1QWO7wBn8dVslg1ih/OeIoZynDed9S0iYKQNWmgjsHh6AbRRO3OoM3xFH2iuY3GY/FfXVUqEndjAp3fMjXycIRB9qe5Df8TgOQqEYeg9vjrAJcjAl4bWP0nZGez65MLEanwKxlOYUneKN61mLQgnIerzJht+5txwRitR7UYCvGrwfdwHxIYhMT/62OO440qQVHvXexEILGHpQpPnXLs/EeCxB9SKyFIDqe+UXjH8ncBnrSY3vjTKlKiFWLrgaHqMQjOp8gsCaAJMVGk9jrk1qpKiaJsRoy+MmZedeyiSKov6LovJGE9pDbYWG8mgReJ7fHEDwq/Px/rXgeM3P1OyCp2RXy3MVAzbJxX1KKUD7CHoM0OFUof6TV6r6kfTEveh9qcV93urppegf2cwcdi6SbRO68va6dTlb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa0278e5-3a70-4a84-0df1-08d81f2f5436
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 08:59:01.2536 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UheMSUdJwqZcBnwhA9ii6Ir4+6eYk8p16iz/8PqkabCrkyafC1qRoIpYPSsaG7VT
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

Leftover of previous cleanups.

Change-Id: I36a018349647125513e47edda66db2005bd8b0c5
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  | 32 -------------------
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  2 --
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    | 32 -------------------
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    | 32 -------------------
 drivers/gpu/drm/amd/powerplay/smu_internal.h  |  2 --
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 16 ++--------
 6 files changed, 3 insertions(+), 113 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 209ccf38c020..56dc20a617fd 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -2314,37 +2314,6 @@ static void arcturus_log_thermal_throttling_event(struct smu_context *smu)
 			log_buf);
 }
 
-static int arcturus_set_thermal_range(struct smu_context *smu,
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
 static const struct pptable_funcs arcturus_ppt_funcs = {
 	/* translate smu index into arcturus specific index */
 	.get_smu_msg_index = arcturus_get_smu_msg_index,
@@ -2427,7 +2396,6 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.set_df_cstate = arcturus_set_df_cstate,
 	.allow_xgmi_power_down = arcturus_allow_xgmi_power_down,
 	.log_thermal_throttling_event = arcturus_log_thermal_throttling_event,
-	.set_thermal_range = arcturus_set_thermal_range,
 };
 
 void arcturus_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index dede24959652..52e5603dcc97 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -480,7 +480,6 @@ struct pptable_funcs {
 	int (*set_cpu_power_state)(struct smu_context *smu);
 	bool (*is_dpm_running)(struct smu_context *smu);
 	int (*tables_init)(struct smu_context *smu, struct smu_table *tables);
-	int (*set_thermal_fan_table)(struct smu_context *smu);
 	int (*get_fan_speed_percent)(struct smu_context *smu, uint32_t *speed);
 	int (*get_fan_speed_rpm)(struct smu_context *smu, uint32_t *speed);
 	int (*set_watermarks_table)(struct smu_context *smu, void *watermarks,
@@ -570,7 +569,6 @@ struct pptable_funcs {
 	int (*disable_umc_cdr_12gbps_workaround)(struct smu_context *smu);
 	int (*set_power_source)(struct smu_context *smu, enum smu_power_src_type power_src);
 	void (*log_thermal_throttling_event)(struct smu_context *smu);
-	int (*set_thermal_range)(struct smu_context *smu, struct smu_temperature_range range);
 };
 
 typedef enum {
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index a04a0ba632a9..41bd6d157271 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -2340,37 +2340,6 @@ static int navi10_disable_umc_cdr_12gbps_workaround(struct smu_context *smu)
 	return navi10_dummy_pstate_control(smu, true);
 }
 
-static int navi10_set_thermal_range(struct smu_context *smu,
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
 static const struct pptable_funcs navi10_ppt_funcs = {
 	.tables_init = navi10_tables_init,
 	.alloc_dpm_context = navi10_allocate_dpm_context,
@@ -2452,7 +2421,6 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.run_btc = navi10_run_btc,
 	.disable_umc_cdr_12gbps_workaround = navi10_disable_umc_cdr_12gbps_workaround,
 	.set_power_source = smu_v11_0_set_power_source,
-	.set_thermal_range = navi10_set_thermal_range,
 };
 
 void navi10_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 4180b9196504..ebe8b5a88f0b 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -1795,37 +1795,6 @@ static bool sienna_cichlid_is_baco_supported(struct smu_context *smu)
 	return (val & RCC_BIF_STRAP0__STRAP_PX_CAPABLE_MASK) ? true : false;
 }
 
-static int sienna_cichlid_set_thermal_range(struct smu_context *smu,
-				       struct smu_temperature_range range)
-{
-	struct amdgpu_device *adev = smu->adev;
-	int low = SMU_THERMAL_MINIMUM_ALERT_TEMP;
-	int high = SMU_THERMAL_MAXIMUM_ALERT_TEMP;
-	uint32_t val;
-	struct smu_table_context *table_context = &smu->smu_table;
-	struct smu_11_0_7_powerplay_table *powerplay_table = table_context->power_play_table;
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
 static void sienna_cichlid_dump_pptable(struct smu_context *smu)
 {
 	struct smu_table_context *table_context = &smu->smu_table;
@@ -2563,7 +2532,6 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.baco_exit = smu_v11_0_baco_exit,
 	.get_dpm_ultimate_freq = sienna_cichlid_get_dpm_ultimate_freq,
 	.set_soft_freq_limited_range = smu_v11_0_set_soft_freq_limited_range,
-	.set_thermal_range = sienna_cichlid_set_thermal_range,
 };
 
 void sienna_cichlid_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index db11b9e28646..8c5cf3860e38 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -60,7 +60,6 @@
 #define smu_populate_umd_state_clk(smu)					smu_ppt_funcs(populate_umd_state_clk, 0, smu)
 #define smu_set_default_od8_settings(smu)				smu_ppt_funcs(set_default_od8_settings, 0, smu)
 #define smu_tables_init(smu, tab)					smu_ppt_funcs(tables_init, 0, smu, tab)
-#define smu_set_thermal_fan_table(smu)					smu_ppt_funcs(set_thermal_fan_table, 0, smu)
 #define smu_enable_thermal_alert(smu)					smu_ppt_funcs(enable_thermal_alert, 0, smu)
 #define smu_disable_thermal_alert(smu)					smu_ppt_funcs(disable_thermal_alert, 0, smu)
 #define smu_smc_read_sensor(smu, sensor, data, size)			smu_ppt_funcs(read_sensor, -EINVAL, smu, sensor, data, size)
@@ -90,7 +89,6 @@
 #define smu_asic_set_performance_level(smu, level)			smu_ppt_funcs(set_performance_level, -EINVAL, smu, level)
 #define smu_dump_pptable(smu)						smu_ppt_funcs(dump_pptable, 0, smu)
 #define smu_update_pcie_parameters(smu, pcie_gen_cap, pcie_width_cap)	smu_ppt_funcs(update_pcie_parameters, 0, smu, pcie_gen_cap, pcie_width_cap)
-#define smu_set_thermal_range(smu, range)				smu_ppt_funcs(set_thermal_range, 0, smu, range)
 #define smu_disable_umc_cdr_12gbps_workaround(smu)			smu_ppt_funcs(disable_umc_cdr_12gbps_workaround, 0, smu)
 #define smu_set_power_source(smu, power_src)				smu_ppt_funcs(set_power_source, 0, smu, power_src)
 #define smu_i2c_eeprom_init(smu, control)				smu_ppt_funcs(i2c_eeprom_init, 0, smu, control)
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 86a118a3a80c..f711c1da1cad 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1085,20 +1085,10 @@ int smu_v11_0_set_power_limit(struct smu_context *smu, uint32_t n)
 
 int smu_v11_0_enable_thermal_alert(struct smu_context *smu)
 {
-	int ret = 0;
-	struct amdgpu_device *adev = smu->adev;
-
-	if (smu->smu_table.thermal_controller_type) {
-		ret = amdgpu_irq_get(adev, &smu->irq_source, 0);
-		if (ret)
-			return ret;
+	if (smu->smu_table.thermal_controller_type)
+		return amdgpu_irq_get(smu->adev, &smu->irq_source, 0);
 
-		ret = smu_set_thermal_fan_table(smu);
-		if (ret)
-			return ret;
-	}
-
-	return ret;
+	return 0;
 }
 
 int smu_v11_0_disable_thermal_alert(struct smu_context *smu)
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
