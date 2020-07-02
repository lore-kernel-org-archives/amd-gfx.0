Return-Path: <SRS0=uuOW=AN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB0AC433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2020 09:45:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DB6720760
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2020 09:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NhH2k666"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DB6720760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 434026EABB;
	Thu,  2 Jul 2020 09:45:16 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760057.outbound.protection.outlook.com [40.107.76.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31D0F6EAB9
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jul 2020 09:45:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDKyAIuahY8J8qCOH5tpvETacbgwsJMchexVoZSYSoxdStOPpzzoozg/61iq5WHSFYneaj7AuNPaUhUpiZm4NIT/Si6Gv3MDYbBephl7zwAapgyHguEer479QnXDJmKJY0o66Ik4+E7jtawiwnVXnJWsTHbhYbA47/lDa9qgTWcMOeuENLaE7ea/UOuoqaRxXX9LOeveY9d5jnHrQW/UB1bcVGpMFN7u+UYKdFh34SbhSeiWCm51o0+SsD6Ctlv9jby6kegPvgInL3Wfnp2tg6MIOLailKvWC7Uw/gLdZxLtfYt4FXg9jUAZTMxnyWlCCR3DxeXfZ/saeC0bg7M1aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVG/AJI3KxWa+0Wpt0rNiV0fD5u8aMDtX/NegHkO2H4=;
 b=ABsR7bK2fNznFSzpZvswn/6Oc+tK4dZaeeASyTONJOwU6NzvIgCcYuUUNS3iP27Chm/CB3pVJ3EvXEdkcE/AB8NT996Uu+UGLHW03VMlV6jgR6TaguyJaQtdDpP+cYNjjDCO9MphjeQsyzcptIhH/9GtUcS+Iqa9jusUBpP/ac9xexEZjq8MRPa1pl4nFLCI/80/VV0ZU9c7RRed3NSnog0ekkUMlFVK+9bLDw9eHypMJvB6c4tOCOzu49yOmUfr5PklG7mwPbXFdWAor5NiE+ymGJ6Kywsv7Cv9ub3jwIblETxLMGCq5fa1cjK70JRpgHncX8wDmanG906Ch9jL5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVG/AJI3KxWa+0Wpt0rNiV0fD5u8aMDtX/NegHkO2H4=;
 b=NhH2k666kCfsC1+P+F79Es8lIaMadxLHr6R9dUCDgS14EtKmdRUzgB4ZNGGPS2grI6D5HPJM2rjdwLpSYQGPBrVRg19HrwsIdg7HsmA8SoOCCPJpGN7dYBFOI2pNPfNKfCfKZja0x5bra5OSBMwgUKscQX1aAZnpqqqnRfXFxKE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB0219.namprd12.prod.outlook.com (2603:10b6:4:56::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.21; Thu, 2 Jul 2020 09:45:13 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3153.023; Thu, 2 Jul 2020
 09:45:13 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] drm/amd/powerplay: bypass wrapper on retrieving current
 clock frequency
Date: Thu,  2 Jul 2020 17:44:45 +0800
Message-Id: <20200702094447.8158-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702094447.8158-1-evan.quan@amd.com>
References: <20200702094447.8158-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR02CA0186.apcprd02.prod.outlook.com
 (2603:1096:201:21::22) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR02CA0186.apcprd02.prod.outlook.com (2603:1096:201:21::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.21 via Frontend Transport; Thu, 2 Jul 2020 09:45:12 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fc4bc7c0-5b93-4adf-e12c-08d81e6c9e4e
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0219:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB02198778C4305D44CF1BCF39E46D0@DM5PR1201MB0219.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v31so4sJS0wRWBt4+XNzBUi68kNN387oPBPasedq2oApuV4Jf4F+G5nlIhwCfNXTfHOaBKhx/cFCdk+g8gHFAi00M3gfa9aqqrK4ctRuDb5lx9hdq1iRzlUNDrmdQ3YNy6nPVeLm0D1U3o89RXRFh+yjXbT0Crn/8rR6D1DeYm+zHZEUg88POa4TRibnJ3jtzXLj+ecuosn02EHbfv1uiSidtuBH1YDzCdr2I4Vzk8ob3ejLOQqY7UXiaBnn/ROn0ErA3Aw3q5xOlA0UB2fJMq8JOUP8l6J+F5gGucGSUfdwCls2SvtlC4c2X1gkHkW4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(7696005)(52116002)(5660300002)(83380400001)(26005)(8676002)(186003)(16526019)(86362001)(6916009)(2616005)(316002)(6486002)(36756003)(956004)(8936002)(66556008)(66476007)(2906002)(66946007)(1076003)(44832011)(30864003)(6666004)(478600001)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: a64ojn00Z1vsaMsW2f9aDvQ4lPpELeLKM35pd4zCzeJ2spRtKMdj9+t7NU90eUZv6pATDVLAMeOOZEcT0JQbMBalGzrsLX51pe7fEQwIqCmLY0bq/75CY6ZsfWoDlHfNd/FjLRaHbtzQTGs7GnDxnOAJCufLMVmSZ5/7vRS8ETZzt4IowxgVYjy3cR8+jeqfV6UVsSEfOsRIqMYyIOgAmt4By7nJ5VZ6/5gHAqT+bWgMorysn81EkLIsgdgDgbm0pfnIPVuNYT4O8yNN394nhB8DIznbhsdr9ZwzSCzS6vPtEdfgftmFDMqxH7gB+BsFnZNRP/7ZG1yBVvBmreLmEQPNsSeCrkkqvFW1uIF4c6tlqDNKoZXvTmL4HiewwpNBBsGRXsxsAkLmJ9alZ5y5AoCOf9G0s03r7bD+WEr5SwgrTO3lnm/eW1Ex+zWDzA/OoQu8vRRFYy5a2HWxrXn5ReUGZLyXgqAT03mSI7gz4yuegZDIUC6lJa89PGB8RjM0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc4bc7c0-5b93-4adf-e12c-08d81e6c9e4e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 09:45:13.8373 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zHN5wG4PFoBLNueiKXJE6yHqj3G4mr72L/iu7sA/cb3qNYXxcKGX79WJS/+0K7E0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0219
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

By calling the target API(asic specific) directly.

Change-Id: I711a57f46cd471928b7700b3a651ebfee9bf8206
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  | 363 +++++++++---------
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    |   5 +-
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    |   5 +-
 3 files changed, 184 insertions(+), 189 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index dc0178349c28..ae4bc56ec320 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -644,6 +644,180 @@ static int arcturus_freqs_in_same_level(int32_t frequency1,
 	return (abs(frequency1 - frequency2) <= EPSILON);
 }
 
+static int arcturus_get_smu_metrics_data(struct smu_context *smu,
+					 MetricsMember_t member,
+					 uint32_t *value)
+{
+	struct smu_table_context *smu_table= &smu->smu_table;
+	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
+	int ret = 0;
+
+	mutex_lock(&smu->metrics_lock);
+
+	if (!smu_table->metrics_time ||
+	     time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(1))) {
+		ret = smu_update_table(smu,
+				       SMU_TABLE_SMU_METRICS,
+				       0,
+				       smu_table->metrics_table,
+				       false);
+		if (ret) {
+			dev_info(smu->adev->dev, "Failed to export SMU metrics table!\n");
+			mutex_unlock(&smu->metrics_lock);
+			return ret;
+		}
+		smu_table->metrics_time = jiffies;
+	}
+
+	switch (member) {
+	case METRICS_CURR_GFXCLK:
+		*value = metrics->CurrClock[PPCLK_GFXCLK];
+		break;
+	case METRICS_CURR_SOCCLK:
+		*value = metrics->CurrClock[PPCLK_SOCCLK];
+		break;
+	case METRICS_CURR_UCLK:
+		*value = metrics->CurrClock[PPCLK_UCLK];
+		break;
+	case METRICS_CURR_VCLK:
+		*value = metrics->CurrClock[PPCLK_VCLK];
+		break;
+	case METRICS_CURR_DCLK:
+		*value = metrics->CurrClock[PPCLK_DCLK];
+		break;
+	case METRICS_CURR_FCLK:
+		*value = metrics->CurrClock[PPCLK_FCLK];
+		break;
+	case METRICS_AVERAGE_GFXCLK:
+		*value = metrics->AverageGfxclkFrequency;
+		break;
+	case METRICS_AVERAGE_SOCCLK:
+		*value = metrics->AverageSocclkFrequency;
+		break;
+	case METRICS_AVERAGE_UCLK:
+		*value = metrics->AverageUclkFrequency;
+		break;
+	case METRICS_AVERAGE_VCLK:
+		*value = metrics->AverageVclkFrequency;
+		break;
+	case METRICS_AVERAGE_DCLK:
+		*value = metrics->AverageDclkFrequency;
+		break;
+	case METRICS_AVERAGE_GFXACTIVITY:
+		*value = metrics->AverageGfxActivity;
+		break;
+	case METRICS_AVERAGE_MEMACTIVITY:
+		*value = metrics->AverageUclkActivity;
+		break;
+	case METRICS_AVERAGE_VCNACTIVITY:
+		*value = metrics->VcnActivityPercentage;
+		break;
+	case METRICS_AVERAGE_SOCKETPOWER:
+		*value = metrics->AverageSocketPower << 8;
+		break;
+	case METRICS_TEMPERATURE_EDGE:
+		*value = metrics->TemperatureEdge *
+			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		break;
+	case METRICS_TEMPERATURE_HOTSPOT:
+		*value = metrics->TemperatureHotspot *
+			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		break;
+	case METRICS_TEMPERATURE_MEM:
+		*value = metrics->TemperatureHBM *
+			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		break;
+	case METRICS_TEMPERATURE_VRGFX:
+		*value = metrics->TemperatureVrGfx *
+			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		break;
+	case METRICS_TEMPERATURE_VRSOC:
+		*value = metrics->TemperatureVrSoc *
+			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		break;
+	case METRICS_TEMPERATURE_VRMEM:
+		*value = metrics->TemperatureVrMem *
+			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		break;
+	case METRICS_THROTTLER_STATUS:
+		*value = metrics->ThrottlerStatus;
+		break;
+	case METRICS_CURR_FANSPEED:
+		*value = metrics->CurrFanSpeed;
+		break;
+	default:
+		*value = UINT_MAX;
+		break;
+	}
+
+	mutex_unlock(&smu->metrics_lock);
+
+	return ret;
+}
+
+static int arcturus_get_current_clk_freq_by_table(struct smu_context *smu,
+				       enum smu_clk_type clk_type,
+				       uint32_t *value)
+{
+	MetricsMember_t member_type;
+	int clk_id = 0;
+
+	if (!value)
+		return -EINVAL;
+
+	clk_id = smu_clk_get_index(smu, clk_type);
+	if (clk_id < 0)
+		return -EINVAL;
+
+	switch (clk_id) {
+	case PPCLK_GFXCLK:
+		/*
+		 * CurrClock[clk_id] can provide accurate
+		 *   output only when the dpm feature is enabled.
+		 * We can use Average_* for dpm disabled case.
+		 *   But this is available for gfxclk/uclk/socclk/vclk/dclk.
+		 */
+		if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT))
+			member_type = METRICS_CURR_GFXCLK;
+		else
+			member_type = METRICS_AVERAGE_GFXCLK;
+		break;
+	case PPCLK_UCLK:
+		if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT))
+			member_type = METRICS_CURR_UCLK;
+		else
+			member_type = METRICS_AVERAGE_UCLK;
+		break;
+	case PPCLK_SOCCLK:
+		if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT))
+			member_type = METRICS_CURR_SOCCLK;
+		else
+			member_type = METRICS_AVERAGE_SOCCLK;
+		break;
+	case PPCLK_VCLK:
+		if (smu_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT))
+			member_type = METRICS_CURR_VCLK;
+		else
+			member_type = METRICS_AVERAGE_VCLK;
+		break;
+	case PPCLK_DCLK:
+		if (smu_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT))
+			member_type = METRICS_CURR_DCLK;
+		else
+			member_type = METRICS_AVERAGE_DCLK;
+		break;
+	case PPCLK_FCLK:
+		member_type = METRICS_CURR_FCLK;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return arcturus_get_smu_metrics_data(smu,
+					     member_type,
+					     value);
+}
+
 static int arcturus_print_clk_levels(struct smu_context *smu,
 			enum smu_clk_type type, char *buf)
 {
@@ -661,7 +835,7 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
 
 	switch (type) {
 	case SMU_SCLK:
-		ret = smu_v11_0_get_current_clk_freq(smu, SMU_GFXCLK, &now);
+		ret = arcturus_get_current_clk_freq_by_table(smu, SMU_GFXCLK, &now);
 		if (ret) {
 			dev_err(smu->adev->dev, "Attempt to get current gfx clk Failed!");
 			return ret;
@@ -684,11 +858,11 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
 					(clocks.num_levels == 1) ? "*" :
 					(arcturus_freqs_in_same_level(
 					clocks.data[i].clocks_in_khz / 1000,
-					now / 100) ? "*" : ""));
+					now) ? "*" : ""));
 		break;
 
 	case SMU_MCLK:
-		ret = smu_v11_0_get_current_clk_freq(smu, SMU_UCLK, &now);
+		ret = arcturus_get_current_clk_freq_by_table(smu, SMU_UCLK, &now);
 		if (ret) {
 			dev_err(smu->adev->dev, "Attempt to get current mclk Failed!");
 			return ret;
@@ -707,11 +881,11 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
 				(clocks.num_levels == 1) ? "*" :
 				(arcturus_freqs_in_same_level(
 				clocks.data[i].clocks_in_khz / 1000,
-				now / 100) ? "*" : ""));
+				now) ? "*" : ""));
 		break;
 
 	case SMU_SOCCLK:
-		ret = smu_v11_0_get_current_clk_freq(smu, SMU_SOCCLK, &now);
+		ret = arcturus_get_current_clk_freq_by_table(smu, SMU_SOCCLK, &now);
 		if (ret) {
 			dev_err(smu->adev->dev, "Attempt to get current socclk Failed!");
 			return ret;
@@ -730,11 +904,11 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
 				(clocks.num_levels == 1) ? "*" :
 				(arcturus_freqs_in_same_level(
 				clocks.data[i].clocks_in_khz / 1000,
-				now / 100) ? "*" : ""));
+				now) ? "*" : ""));
 		break;
 
 	case SMU_FCLK:
-		ret = smu_v11_0_get_current_clk_freq(smu, SMU_FCLK, &now);
+		ret = arcturus_get_current_clk_freq_by_table(smu, SMU_FCLK, &now);
 		if (ret) {
 			dev_err(smu->adev->dev, "Attempt to get current fclk Failed!");
 			return ret;
@@ -753,7 +927,7 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
 				(clocks.num_levels == 1) ? "*" :
 				(arcturus_freqs_in_same_level(
 				clocks.data[i].clocks_in_khz / 1000,
-				now / 100) ? "*" : ""));
+				now) ? "*" : ""));
 		break;
 
 	default:
@@ -918,117 +1092,6 @@ static int arcturus_get_thermal_temperature_range(struct smu_context *smu,
 	return 0;
 }
 
-static int arcturus_get_smu_metrics_data(struct smu_context *smu,
-					 MetricsMember_t member,
-					 uint32_t *value)
-{
-	struct smu_table_context *smu_table= &smu->smu_table;
-	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
-	int ret = 0;
-
-	mutex_lock(&smu->metrics_lock);
-
-	if (!smu_table->metrics_time ||
-	     time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(1))) {
-		ret = smu_update_table(smu,
-				       SMU_TABLE_SMU_METRICS,
-				       0,
-				       smu_table->metrics_table,
-				       false);
-		if (ret) {
-			dev_info(smu->adev->dev, "Failed to export SMU metrics table!\n");
-			mutex_unlock(&smu->metrics_lock);
-			return ret;
-		}
-		smu_table->metrics_time = jiffies;
-	}
-
-	switch (member) {
-	case METRICS_CURR_GFXCLK:
-		*value = metrics->CurrClock[PPCLK_GFXCLK];
-		break;
-	case METRICS_CURR_SOCCLK:
-		*value = metrics->CurrClock[PPCLK_SOCCLK];
-		break;
-	case METRICS_CURR_UCLK:
-		*value = metrics->CurrClock[PPCLK_UCLK];
-		break;
-	case METRICS_CURR_VCLK:
-		*value = metrics->CurrClock[PPCLK_VCLK];
-		break;
-	case METRICS_CURR_DCLK:
-		*value = metrics->CurrClock[PPCLK_DCLK];
-		break;
-	case METRICS_CURR_FCLK:
-		*value = metrics->CurrClock[PPCLK_FCLK];
-		break;
-	case METRICS_AVERAGE_GFXCLK:
-		*value = metrics->AverageGfxclkFrequency;
-		break;
-	case METRICS_AVERAGE_SOCCLK:
-		*value = metrics->AverageSocclkFrequency;
-		break;
-	case METRICS_AVERAGE_UCLK:
-		*value = metrics->AverageUclkFrequency;
-		break;
-	case METRICS_AVERAGE_VCLK:
-		*value = metrics->AverageVclkFrequency;
-		break;
-	case METRICS_AVERAGE_DCLK:
-		*value = metrics->AverageDclkFrequency;
-		break;
-	case METRICS_AVERAGE_GFXACTIVITY:
-		*value = metrics->AverageGfxActivity;
-		break;
-	case METRICS_AVERAGE_MEMACTIVITY:
-		*value = metrics->AverageUclkActivity;
-		break;
-	case METRICS_AVERAGE_VCNACTIVITY:
-		*value = metrics->VcnActivityPercentage;
-		break;
-	case METRICS_AVERAGE_SOCKETPOWER:
-		*value = metrics->AverageSocketPower << 8;
-		break;
-	case METRICS_TEMPERATURE_EDGE:
-		*value = metrics->TemperatureEdge *
-			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
-		break;
-	case METRICS_TEMPERATURE_HOTSPOT:
-		*value = metrics->TemperatureHotspot *
-			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
-		break;
-	case METRICS_TEMPERATURE_MEM:
-		*value = metrics->TemperatureHBM *
-			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
-		break;
-	case METRICS_TEMPERATURE_VRGFX:
-		*value = metrics->TemperatureVrGfx *
-			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
-		break;
-	case METRICS_TEMPERATURE_VRSOC:
-		*value = metrics->TemperatureVrSoc *
-			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
-		break;
-	case METRICS_TEMPERATURE_VRMEM:
-		*value = metrics->TemperatureVrMem *
-			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
-		break;
-	case METRICS_THROTTLER_STATUS:
-		*value = metrics->ThrottlerStatus;
-		break;
-	case METRICS_CURR_FANSPEED:
-		*value = metrics->CurrFanSpeed;
-		break;
-	default:
-		*value = UINT_MAX;
-		break;
-	}
-
-	mutex_unlock(&smu->metrics_lock);
-
-	return ret;
-}
-
 static int arcturus_get_current_activity_percent(struct smu_context *smu,
 						 enum amd_pp_sensors sensor,
 						 uint32_t *value)
@@ -1177,68 +1240,6 @@ static int arcturus_get_fan_speed_percent(struct smu_context *smu,
 	return ret;
 }
 
-static int arcturus_get_current_clk_freq_by_table(struct smu_context *smu,
-				       enum smu_clk_type clk_type,
-				       uint32_t *value)
-{
-	MetricsMember_t member_type;
-	int clk_id = 0;
-
-	if (!value)
-		return -EINVAL;
-
-	clk_id = smu_clk_get_index(smu, clk_type);
-	if (clk_id < 0)
-		return -EINVAL;
-
-	switch (clk_id) {
-	case PPCLK_GFXCLK:
-		/*
-		 * CurrClock[clk_id] can provide accurate
-		 *   output only when the dpm feature is enabled.
-		 * We can use Average_* for dpm disabled case.
-		 *   But this is available for gfxclk/uclk/socclk/vclk/dclk.
-		 */
-		if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT))
-			member_type = METRICS_CURR_GFXCLK;
-		else
-			member_type = METRICS_AVERAGE_GFXCLK;
-		break;
-	case PPCLK_UCLK:
-		if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT))
-			member_type = METRICS_CURR_UCLK;
-		else
-			member_type = METRICS_AVERAGE_UCLK;
-		break;
-	case PPCLK_SOCCLK:
-		if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT))
-			member_type = METRICS_CURR_SOCCLK;
-		else
-			member_type = METRICS_AVERAGE_SOCCLK;
-		break;
-	case PPCLK_VCLK:
-		if (smu_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT))
-			member_type = METRICS_CURR_VCLK;
-		else
-			member_type = METRICS_AVERAGE_VCLK;
-		break;
-	case PPCLK_DCLK:
-		if (smu_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT))
-			member_type = METRICS_CURR_DCLK;
-		else
-			member_type = METRICS_AVERAGE_DCLK;
-		break;
-	case PPCLK_FCLK:
-		member_type = METRICS_CURR_FCLK;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return arcturus_get_smu_metrics_data(smu,
-					     member_type,
-					     value);
-}
 
 static uint32_t arcturus_find_lowest_dpm_level(struct arcturus_single_dpm_table *table)
 {
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 6046cb6db4a1..87f110b16e55 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -877,13 +877,10 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 	case SMU_UCLK:
 	case SMU_FCLK:
 	case SMU_DCEFCLK:
-		ret = smu_v11_0_get_current_clk_freq(smu, clk_type, &cur_value);
+		ret = navi10_get_current_clk_freq_by_table(smu, clk_type, &cur_value);
 		if (ret)
 			return size;
 
-		/* 10KHz -> MHz */
-		cur_value = cur_value / 100;
-
 		ret = smu_get_dpm_level_count(smu, clk_type, &count);
 		if (ret)
 			return size;
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index cbd596475d19..ad338984d6c0 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -781,13 +781,10 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 	case SMU_UCLK:
 	case SMU_FCLK:
 	case SMU_DCEFCLK:
-		ret = smu_v11_0_get_current_clk_freq(smu, clk_type, &cur_value);
+		ret = sienna_cichlid_get_current_clk_freq_by_table(smu, clk_type, &cur_value);
 		if (ret)
 			goto print_clk_out;
 
-		/* 10KHz -> MHz */
-		cur_value = cur_value / 100;
-
 		/* no need to disable gfxoff when retrieving the current gfxclk */
 		if ((clk_type == SMU_GFXCLK) || (clk_type == SMU_SCLK))
 			amdgpu_gfx_off_ctrl(adev, false);
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
