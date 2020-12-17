Return-Path: <SRS0=AWwP=FV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53525C4361B
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Dec 2020 04:15:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA5522376F
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Dec 2020 04:15:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA5522376F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 524D189D58;
	Thu, 17 Dec 2020 04:15:31 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98A2C89D58
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Dec 2020 04:15:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUr7GEzIMV4p/8vvRsvJ/HzQpfIHVbBKU8hMq4luutEsV//v0C2JrjNyS+J1GLSG0wRBLn9+ZGGalHHmUQyzprxaIzvSd/9B1YJ+DAOe7kWA3Mrbyqyg9LyRhaSqCb0iL9hlHOS7gUE9C/sQnTmrOsrmqaGJXp2tg5SdurwEAAoLYNwz3qzzbfSWlIuaz+P2aARmHFuJmXJ0sVPERz/h91cnS/sTLnK4I5qkhKaAj2XNZy+wFacOg5l6lOgUKkqejl7Zyd5FuyttGGoPfi9InL2TK2/9/MBv/M1AawLVAJawKU0KCEtG7Gmq0mCTbhwH2hdRBU6ZH3j4IN9HlH0cow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMLER0ulCRkryMrz98vtEkH6eFzIOldjUIQ5KtabaKo=;
 b=fSWNmSXrXiGSUu4B0Ycaher9Acm1F4qsZ6rLS26RQQXfzWrmDYeJxeBRsHhk/+UfZI3Xru7mGPlTtWb5duq61ETcbHiefXd4AwccS88v3oQo4RtEtwM7Zt4hhprlwhZCW7wYu9s4vJQug/ztg9xhCzvrY1rDs49AbxFC89zRqhfghN41C48QG47pDTvCiQvt0os6TCYmSUHr7zaPaQ2/J7oKbm5TJOZKpzRrRLv9xM7Z7UYZuU6JgMlMob1SJlkuSwdnIdTlakKmELqAuyY8hGY1a+lr6o5CLNnxg065zmPefFm/8xXO5u/Tju/970ZpvC4XaRc7TqobmDF6Mpq3tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMLER0ulCRkryMrz98vtEkH6eFzIOldjUIQ5KtabaKo=;
 b=NEp/WYon7d3YWT6q79CnF7uPVJ5/J0fPGX2MSJp8s1vMqWQkQNDD4XIgZmTOcJYb/Y8WCMxZdFGcmayv+B7xO3yB3hUtlwsAtNBSUVvqTjoFwOtYBPi4Sg5JuVp9eYgaYFuVm+CaZqjcutnRxMusGDJrKHjI+GkbbC94t5NGNlQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB2359.namprd12.prod.outlook.com (2603:10b6:4:b4::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.25; Thu, 17 Dec 2020 04:15:28 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3654.026; Thu, 17 Dec 2020
 04:15:28 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amd/pm: enable Sienna Cichlid overdrive support
Date: Thu, 17 Dec 2020 12:14:54 +0800
Message-Id: <20201217041455.87870-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201217041455.87870-1-evan.quan@amd.com>
References: <20201217041455.87870-1-evan.quan@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HKAPR03CA0009.apcprd03.prod.outlook.com
 (2603:1096:203:c8::14) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HKAPR03CA0009.apcprd03.prod.outlook.com (2603:1096:203:c8::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.9 via Frontend Transport; Thu, 17 Dec 2020 04:15:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c1b0b1a6-ce5f-4881-0b1f-08d8a24262c4
X-MS-TrafficTypeDiagnostic: DM5PR12MB2359:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB23590F5018F11955CE1BAAFCE4C40@DM5PR12MB2359.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vGCNGKPs+EanPatwbqHjH862OGGnpBB93kc/ye45t6Q+HYHdzufRjhiMNVH/lhYBhvbP1eq70w33/hh+9parj/fwMQzZ8uiC9MXgdjMVKFl+ewfGuuqRTHP3j88tMkrcG+AZR7G2daJxqbD2naCldALnGRyowFYH5NNmER1NtMqwreNfBteXvogCRfdyzGRmwjLKdfpFshKMpTakGAgMtrMr3FTATvP0DfFS0JN3lm9UPdH1FRngQGN2fDtPkzzlvBsvotVEnt5Gp62YZuGbPkKMfG+oxQ+0IEoHUs/xkhpmz/v0OGhwf07NNpF91Edde6pb66dTZ94Ba8cCLStiyqvQA2ZBHNHvgN28Xl1/WV6gZZvKxXAwpcFhwLHkZQj8AI8gxmhvp58JU+ETTweLCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(66476007)(66556008)(8936002)(54906003)(36756003)(1076003)(26005)(8676002)(316002)(83380400001)(186003)(16526019)(66946007)(86362001)(7696005)(52116002)(6486002)(2906002)(5660300002)(4326008)(478600001)(6916009)(44832011)(956004)(66574015)(6666004)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?iql8GMzyMls08vbduHhUo+4CpuFJZRttyVBt7hIcnUP/KGoDbs6bTeLPUnTT?=
 =?us-ascii?Q?6zC0gCmfd5qAAGjSMR8Vg1NJSx+xpOJhvYyeOOoOnJJ1CQCXy5kCVCpW0FdA?=
 =?us-ascii?Q?TL2hDIxhcUIw/YtciK8yN9RquVXnKy7nWYt/at/DzFDoJZkv4IEVRaScLN42?=
 =?us-ascii?Q?ChYTlVWU7TrtzQT1q3Q485CiyS4qqoyiO0CKgAwdcVIlQ0G8WQs64lP7YqgB?=
 =?us-ascii?Q?oH2t6N6L2w73CtFQviXHg3Fs4/eynwDvEQar2fnJOxF4JiMLdihe1BJDlKZC?=
 =?us-ascii?Q?eIc55HXxNbd7eachunurmcQwxrjaIAcfcS693fjx8tiVU+I+Vl2JXSoM68pP?=
 =?us-ascii?Q?97DppUVhkFVS6O4pvUy2NdvasxfeznwS9ZwvYu1reGSBZA5vHySVoOf4IqJZ?=
 =?us-ascii?Q?IwehjoBQegtmNF3D7bgXJMLDn7TqbWS3WRz/xULaVR/bJmhPEjhxgZbUC9cr?=
 =?us-ascii?Q?e4dbFCMU3RCt0zlpJKBB+ReWVgQL0sno7RRBCyqVKhLkDlWcu5yXBRO7DfwQ?=
 =?us-ascii?Q?tV0Hho0+oImF6PaUs9PkPAOv/sJ9Y2+lnC4N3oZLCynPez7btlAp4qpqY6Vx?=
 =?us-ascii?Q?mASqpj6J3tIF43DjzhGDykI+pwAsZLgbuWxPbUQYt7b+JnUHxluxwkF8RqX1?=
 =?us-ascii?Q?uZOfOF5eGvvN+q4JdX52J0eMdowhboaZRwWZjst9Iz6G5lT/sAeKNCdzNK8I?=
 =?us-ascii?Q?V1YxPWWJZ7qhJn8pknVBWStdMroTjyquveyNM412JCIrwy8D6mJ9p7k7ypvT?=
 =?us-ascii?Q?p4XJVuJ1ISmsPdWL5jCN5HT0l6/pz71LaHbnkK5gZzBmlcqXnk2g/wW/GYaV?=
 =?us-ascii?Q?D7atcxvIDvFpmB7afSQHAz9E5yIucEqUS2iTy7hghDBSdGG9BaOCB01GeWMk?=
 =?us-ascii?Q?PUyC4nRBYU2RSzcQEyQhgkSmRPPMoWjWEY8rZqfPKwi84ae8/7vxpP7Blsx1?=
 =?us-ascii?Q?xMiotsfuCDgh+i3NGgSETQEh2zxqi4g5A0FfOGUZ3Ef3Azi0L4QuxFzyYJDr?=
 =?us-ascii?Q?6Bzy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2020 04:15:28.0592 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b0b1a6-ce5f-4881-0b1f-08d8a24262c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o7AtsbSgXvvAZYdoWXB0LTnSeDv4PA1SXijLNbmRAM2wtCSOyMWNNTbzsYfjvdc3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2359
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

Enable Sienna Cichlid gfxclk/uclk overdrive support.

Change-Id: I93535076f5857c0dfeb012a993bc85a16ca4df84
Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |   3 +-
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 241 ++++++++++++++++++
 2 files changed, 243 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 7b6ef05a1d35..73aa78a158a6 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -730,7 +730,8 @@ static ssize_t amdgpu_set_pp_table(struct device *dev,
  *
  * - minimum and maximum engine clock labeled OD_SCLK
  *
- * - maximum memory clock labeled OD_MCLK
+ * - minimum(not available for Vega20 and Navi1x) and maximum memory
+ *   clock labeled OD_MCLK
  *
  * - three <frequency, voltage> points labeled OD_VDDC_CURVE.
  *   They can be used to calibrate the sclk voltage curve.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index cbee4ca43707..d1de617e85c6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -913,6 +913,22 @@ static bool sienna_cichlid_is_support_fine_grained_dpm(struct smu_context *smu,
 	return dpm_desc->SnapToDiscrete == 0 ? true : false;
 }
 
+static bool sienna_cichlid_is_od_feature_supported(struct smu_11_0_7_overdrive_table *od_table,
+						   enum SMU_11_0_7_ODFEATURE_CAP cap)
+{
+	return od_table->cap[cap];
+}
+
+static void sienna_cichlid_get_od_setting_range(struct smu_11_0_7_overdrive_table *od_table,
+						enum SMU_11_0_7_ODSETTING_ID setting,
+						uint32_t *min, uint32_t *max)
+{
+	if (min)
+		*min = od_table->min[setting];
+	if (max)
+		*max = od_table->max[setting];
+}
+
 static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 			enum smu_clk_type clk_type, char *buf)
 {
@@ -921,11 +937,15 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
 	struct smu_11_0_dpm_context *dpm_context = smu_dpm->dpm_context;
 	PPTable_t *pptable = (PPTable_t *)table_context->driver_pptable;
+	struct smu_11_0_7_overdrive_table *od_settings = smu->od_settings;
+	OverDriveTable_t *od_table =
+		(OverDriveTable_t *)table_context->overdrive_table;
 	int i, size = 0, ret = 0;
 	uint32_t cur_value = 0, value = 0, count = 0;
 	uint32_t freq_values[3] = {0};
 	uint32_t mark_index = 0;
 	uint32_t gen_speed, lane_width;
+	uint32_t min_value, max_value;
 
 	switch (clk_type) {
 	case SMU_GFXCLK:
@@ -1001,6 +1021,53 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 					(lane_width == dpm_context->dpm_tables.pcie_table.pcie_lane[i]) ?
 					"*" : "");
 		break;
+	case SMU_OD_SCLK:
+		if (!smu->od_enabled || !od_table || !od_settings)
+			break;
+
+		if (!sienna_cichlid_is_od_feature_supported(od_settings, SMU_11_0_7_ODCAP_GFXCLK_LIMITS))
+			break;
+
+		size += sprintf(buf + size, "OD_SCLK:\n");
+		size += sprintf(buf + size, "0: %uMhz\n1: %uMhz\n", od_table->GfxclkFmin, od_table->GfxclkFmax);
+		break;
+
+	case SMU_OD_MCLK:
+		if (!smu->od_enabled || !od_table || !od_settings)
+			break;
+
+		if (!sienna_cichlid_is_od_feature_supported(od_settings, SMU_11_0_7_ODCAP_UCLK_LIMITS))
+			break;
+
+		size += sprintf(buf + size, "OD_MCLK:\n");
+		size += sprintf(buf + size, "0: %uMhz\n1: %uMHz\n", od_table->UclkFmin, od_table->UclkFmax);
+		break;
+
+	case SMU_OD_RANGE:
+		if (!smu->od_enabled || !od_table || !od_settings)
+			break;
+
+		size = sprintf(buf, "%s:\n", "OD_RANGE");
+
+		if (sienna_cichlid_is_od_feature_supported(od_settings, SMU_11_0_7_ODCAP_GFXCLK_LIMITS)) {
+			sienna_cichlid_get_od_setting_range(od_settings, SMU_11_0_7_ODSETTING_GFXCLKFMIN,
+							    &min_value, NULL);
+			sienna_cichlid_get_od_setting_range(od_settings, SMU_11_0_7_ODSETTING_GFXCLKFMAX,
+							    NULL, &max_value);
+			size += sprintf(buf + size, "SCLK: %7uMhz %10uMhz\n",
+					min_value, max_value);
+		}
+
+		if (sienna_cichlid_is_od_feature_supported(od_settings, SMU_11_0_7_ODCAP_UCLK_LIMITS)) {
+			sienna_cichlid_get_od_setting_range(od_settings, SMU_11_0_7_ODSETTING_UCLKFMIN,
+							    &min_value, NULL);
+			sienna_cichlid_get_od_setting_range(od_settings, SMU_11_0_7_ODSETTING_UCLKFMAX,
+							    NULL, &max_value);
+			size += sprintf(buf + size, "MCLK: %7uMhz %10uMhz\n",
+					min_value, max_value);
+		}
+		break;
+
 	default:
 		break;
 	}
@@ -1731,6 +1798,179 @@ static int sienna_cichlid_set_default_od_settings(struct smu_context *smu)
 	return 0;
 }
 
+static int sienna_cichlid_od_setting_check_range(struct smu_context *smu,
+						 struct smu_11_0_7_overdrive_table *od_table,
+						 enum SMU_11_0_7_ODSETTING_ID setting,
+						 uint32_t value)
+{
+	if (value < od_table->min[setting]) {
+		dev_warn(smu->adev->dev, "OD setting (%d, %d) is less than the minimum allowed (%d)\n",
+					  setting, value, od_table->min[setting]);
+		return -EINVAL;
+	}
+	if (value > od_table->max[setting]) {
+		dev_warn(smu->adev->dev, "OD setting (%d, %d) is greater than the maximum allowed (%d)\n",
+					  setting, value, od_table->max[setting]);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int sienna_cichlid_od_edit_dpm_table(struct smu_context *smu,
+					    enum PP_OD_DPM_TABLE_COMMAND type,
+					    long input[], uint32_t size)
+{
+	struct smu_table_context *table_context = &smu->smu_table;
+	OverDriveTable_t *od_table =
+		(OverDriveTable_t *)table_context->overdrive_table;
+	struct smu_11_0_7_overdrive_table *od_settings =
+		(struct smu_11_0_7_overdrive_table *)smu->od_settings;
+	enum SMU_11_0_7_ODSETTING_ID freq_setting;
+	uint16_t *freq_ptr;
+	int i, ret = 0;
+
+	if (!smu->od_enabled) {
+		dev_warn(smu->adev->dev, "OverDrive is not enabled!\n");
+		return -EINVAL;
+	}
+
+	if (!smu->od_settings) {
+		dev_err(smu->adev->dev, "OD board limits are not set!\n");
+		return -ENOENT;
+	}
+
+	if (!(table_context->overdrive_table && table_context->boot_overdrive_table)) {
+		dev_err(smu->adev->dev, "Overdrive table was not initialized!\n");
+		return -EINVAL;
+	}
+
+	switch (type) {
+	case PP_OD_EDIT_SCLK_VDDC_TABLE:
+		if (!sienna_cichlid_is_od_feature_supported(od_settings,
+							    SMU_11_0_7_ODCAP_GFXCLK_LIMITS)) {
+			dev_warn(smu->adev->dev, "GFXCLK_LIMITS not supported!\n");
+			return -ENOTSUPP;
+		}
+
+		for (i = 0; i < size; i += 2) {
+			if (i + 2 > size) {
+				dev_info(smu->adev->dev, "invalid number of input parameters %d\n", size);
+				return -EINVAL;
+			}
+
+			switch (input[i]) {
+			case 0:
+				if (input[i + 1] > od_table->GfxclkFmax) {
+					dev_info(smu->adev->dev, "GfxclkFmin (%ld) must be <= GfxclkFmax (%u)!\n",
+						input[i + 1], od_table->GfxclkFmax);
+					return -EINVAL;
+				}
+
+				freq_setting = SMU_11_0_7_ODSETTING_GFXCLKFMIN;
+				freq_ptr = &od_table->GfxclkFmin;
+				break;
+
+			case 1:
+				if (input[i + 1] < od_table->GfxclkFmin) {
+					dev_info(smu->adev->dev, "GfxclkFmax (%ld) must be >= GfxclkFmin (%u)!\n",
+						input[i + 1], od_table->GfxclkFmin);
+					return -EINVAL;
+				}
+
+				freq_setting = SMU_11_0_7_ODSETTING_GFXCLKFMAX;
+				freq_ptr = &od_table->GfxclkFmax;
+				break;
+
+			default:
+				dev_info(smu->adev->dev, "Invalid SCLK_VDDC_TABLE index: %ld\n", input[i]);
+				dev_info(smu->adev->dev, "Supported indices: [0:min,1:max]\n");
+				return -EINVAL;
+			}
+
+			ret = sienna_cichlid_od_setting_check_range(smu, od_settings,
+								    freq_setting, input[i + 1]);
+			if (ret)
+				return ret;
+
+			*freq_ptr = (uint16_t)input[i + 1];
+		}
+		break;
+
+	case PP_OD_EDIT_MCLK_VDDC_TABLE:
+		if (!sienna_cichlid_is_od_feature_supported(od_settings, SMU_11_0_7_ODCAP_UCLK_LIMITS)) {
+			dev_warn(smu->adev->dev, "UCLK_LIMITS not supported!\n");
+			return -ENOTSUPP;
+		}
+
+		for (i = 0; i < size; i += 2) {
+			if (i + 2 > size) {
+				dev_info(smu->adev->dev, "invalid number of input parameters %d\n", size);
+				return -EINVAL;
+			}
+
+			switch (input[i]) {
+			case 0:
+				if (input[i + 1] > od_table->UclkFmax) {
+					dev_info(smu->adev->dev, "UclkFmin (%ld) must be <= UclkFmax (%u)!\n",
+						input[i + 1], od_table->UclkFmax);
+					return -EINVAL;
+				}
+
+				freq_setting = SMU_11_0_7_ODSETTING_UCLKFMIN;
+				freq_ptr = &od_table->UclkFmin;
+				break;
+
+			case 1:
+				if (input[i + 1] < od_table->UclkFmin) {
+					dev_info(smu->adev->dev, "UclkFmax (%ld) must be >= UclkFmin (%u)!\n",
+						input[i + 1], od_table->UclkFmin);
+					return -EINVAL;
+				}
+
+				freq_setting = SMU_11_0_7_ODSETTING_UCLKFMAX;
+				freq_ptr = &od_table->UclkFmax;
+				break;
+
+			default:
+				dev_info(smu->adev->dev, "Invalid MCLK_VDDC_TABLE index: %ld\n", input[i]);
+				dev_info(smu->adev->dev, "Supported indices: [0:min,1:max]\n");
+				return -EINVAL;
+			}
+
+			ret = sienna_cichlid_od_setting_check_range(smu, od_settings,
+								    freq_setting, input[i + 1]);
+			if (ret)
+				return ret;
+
+			*freq_ptr = (uint16_t)input[i + 1];
+		}
+		break;
+
+	case PP_OD_RESTORE_DEFAULT_TABLE:
+		memcpy(table_context->overdrive_table,
+				table_context->boot_overdrive_table,
+				sizeof(OverDriveTable_t));
+		fallthrough;
+
+	case PP_OD_COMMIT_DPM_TABLE:
+		sienna_cichlid_dump_od_table(smu, od_table);
+
+		ret = smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE,
+					   0, (void *)od_table, true);
+		if (ret) {
+			dev_err(smu->adev->dev, "Failed to import overdrive table!\n");
+			return ret;
+		}
+		break;
+
+	default:
+		return -ENOSYS;
+	}
+
+	return ret;
+}
+
 static int sienna_cichlid_run_btc(struct smu_context *smu)
 {
 	return smu_cmn_send_smc_msg(smu, SMU_MSG_RunDcBtc, NULL);
@@ -2855,6 +3095,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.get_dpm_ultimate_freq = sienna_cichlid_get_dpm_ultimate_freq,
 	.set_soft_freq_limited_range = smu_v11_0_set_soft_freq_limited_range,
 	.set_default_od_settings = sienna_cichlid_set_default_od_settings,
+	.od_edit_dpm_table = sienna_cichlid_od_edit_dpm_table,
 	.run_btc = sienna_cichlid_run_btc,
 	.set_power_source = smu_v11_0_set_power_source,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
