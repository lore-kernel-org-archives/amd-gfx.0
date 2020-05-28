Return-Path: <SRS0=qtCw=7K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C251CC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 03:05:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A7112084C
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 03:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yxsFslzb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A7112084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1F756E17B;
	Thu, 28 May 2020 03:05:36 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700080.outbound.protection.outlook.com [40.107.70.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AC9A6E174
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2020 03:05:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=blqqPP87hF3fiW6Fp+UCMIoal/XwOZDjzr8Ngsu+mDU3MsovDB1duaezrZ3Mx9wGw8KhHK1ESZSbPvyKRH+zTcNnsll1VBKBLw+qfHG2Pq7vlbSXLYv2C7iHQ9/EoDpRwnGUDdROs7stAReAxGHFB0Vu8540BmQDmq45f7JutpnJUGxv4sdVb7PuHty3tdBvG0/gmjhFO0pOD6xpl2yURsq5LBE7/9nMCei+DFt03RyR9UpMJOtB56vadnwTY49sZNRETdOjZTdkxhXn3X1QqMKSIs6jp/KWY1mbFbWKauy+gUWbw1SkOJuxOI+R3WHUuwQ4mfcbufz8K3iHPjcJeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0QnNkRMGq0NcD5cnRtyLPey5aM2j89uF6dXAzPmscII=;
 b=cwBoQQpA3374r+VJElXBeb3JJRBn1wD9GjyylJ/4pIpQ1ewnVFA8SF0MTenFRoNwDojB6yYPfZBiE0uSb+pLFtFWwXRBBi54Qj+erkpyfy1+rdR2YLxqV0IbzzZC2lUu4W34a8eiSFUgaB6KqxtSnWvdbi8l4wL+c3UzvmVVI/UsZWUSrVR0G9xfZQFu9GHn+tDCFQMc7WfPqmpoSYF6VrgVksh7Zi2TyLOnbQW30+HuxAoJaq6ZCFCf48pstaFyJqszmCYS79uGYZnJ059LxTBgl/1tW5GZfkVW+Oot694sdcPg69o8kR1VaTnErjfsBYqjlQP730XW/43R2wL2tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0QnNkRMGq0NcD5cnRtyLPey5aM2j89uF6dXAzPmscII=;
 b=yxsFslzbGDs0yzP0uREkf16GaFSIVDJnxZu8xim9iWBrnaYSsL0z4b0J//AKXdNrxjModxLccvIABQ2nZVn+KEsW1SE3XxC8v5ad6PSxa+XWWfniH8+rf0WphwJCG+kvttQJ9JHMBJHC07GgUx/iMTF7cRdn5fNdGQ/1IjyvWFQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3963.namprd12.prod.outlook.com (2603:10b6:5:1cd::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.23; Thu, 28 May 2020 03:05:34 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3021.029; Thu, 28 May 2020
 03:05:33 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] drm/amd/powerplay: implement ASIC specific thermal
 throttling logging
Date: Thu, 28 May 2020 11:04:42 +0800
Message-Id: <20200528030444.28735-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528030444.28735-1-evan.quan@amd.com>
References: <20200528030444.28735-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR04CA0067.apcprd04.prod.outlook.com
 (2603:1096:202:15::11) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR04CA0067.apcprd04.prod.outlook.com (2603:1096:202:15::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19 via Frontend Transport; Thu, 28 May 2020 03:05:32 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d39707ac-1931-4175-9897-08d802b3fc9d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3963:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB39636E4CB0450CFE407518CAE48E0@DM6PR12MB3963.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:215;
X-Forefront-PRVS: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sal9mcbb1nMR7LvpvUNQdrC5v1o+aPuNmAl7Om5e9XeKZcxky5qO/S9fHwYlTE0tn94mkWXGaX9RKaEGE8w8myb+STIf7tPW1tQSk3K8iI8yogr4+ozbrkRtxx9iNkoRh8JZA23nPrEotbN3aa5ZZM/AVsuk2vMbb629Vi4ZzxzeQDvAiy0c+R/IUiyvTm9w/HmfT5ZCmyX9035UU2p7Z9uyPiw3XPxQe4iuKslVTAo5vEjHyMkleAS3+OLxSbg9zP9Ttcdq4JFgFrHGPLOvj5FO9+/4LGZbxN0Xg/vb9iAOc3OMAZo4ag2wiPeNYNzed20d2HcKhEMAgbmpf5HmSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(36756003)(6916009)(54906003)(478600001)(6486002)(86362001)(83380400001)(316002)(186003)(16526019)(26005)(1076003)(66946007)(66556008)(66476007)(52116002)(956004)(5660300002)(7696005)(2616005)(4326008)(6666004)(8936002)(8676002)(2906002)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 3YhrcHdM4I4YDNacEM2cXB+1F9EF2ttpSN0vSllDXf8lQBytzauIHdkZW0UZBreJcchs5KoARYaqNoJd8o+fYB8ke+5aX69z7mh/BzKcVyGpnKgGng7yn86Koh69q+0TyA/AU4uAkKCuxQGZqXPxwD328rha3k8RFgcDhNrcZHSIqlfwbRYgTzv+94a19T7d94bwN5X8BTkOFvrvcPJdZipI41MlvXgwsCtMy2dJVElGAINUl5y5Wy5ERAIFUAegL354Q60ye1GmdqKHGuCzItQQfDIwKI2p65VqG4mJnBqUpkx+POyDrkAIDMOUytl6PX/fP22KQgj0pOBM05gXE5DWZb2HTcmH4xUxKBxmiYUxaMKYgiLcSum62Fs0EK1lkQDkye7PQHhDqCJRNgP2KOw1VedkvgTAPH8+x7jIm4BZcBcqboLY+pf8z/bUrIQgI7mkYYXu1KH2iq7akz/9ji8/RQS3TQt2McaeF94N6wVcTaPTooY6BnBk9XsZjqDz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d39707ac-1931-4175-9897-08d802b3fc9d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 03:05:33.5832 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4R0uP6H8ZwKsp14nnBWfRtXcq/Ro38ktdOBRtHHids2exOVaYtLqSHO1nDOs7kB5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3963
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

Enable this for Arcturus only for now.

Change-Id: I4ad4fbb4f932d748849574e0f4dde01bb7db487a
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  | 44 +++++++++++++++++++
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  1 +
 drivers/gpu/drm/amd/powerplay/smu_internal.h  |  2 +
 3 files changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 67980f50d8ec..5c1b2d7abcaa 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -2329,6 +2329,49 @@ static int arcturus_allow_xgmi_power_down(struct smu_context *smu, bool en)
 					   NULL);
 }
 
+static const struct throttling_logging_label {
+	uint32_t feature_mask;
+	const char *label;
+} logging_label[] = {
+	{(1U << THROTTLER_TEMP_HOTSPOT_BIT), "GPU"},
+	{(1U << THROTTLER_TEMP_MEM_BIT), "HBM"},
+	{(1U << THROTTLER_TEMP_VR_GFX_BIT), "VR of GFX rail"},
+	{(1U << THROTTLER_TEMP_VR_MEM_BIT), "VR of HBM rail"},
+	{(1U << THROTTLER_TEMP_VR_SOC_BIT), "VR of SOC rail"},
+	{(1U << THROTTLER_VRHOT0_BIT), "VR0 HOT"},
+	{(1U << THROTTLER_VRHOT1_BIT), "VR1 HOT"},
+};
+static void arcturus_log_thermal_throttling_event(struct smu_context *smu)
+{
+	int throttler_idx, throtting_events = 0, buf_idx = 0;
+	struct amdgpu_device *adev = smu->adev;
+	SmuMetrics_t metrics;
+	char log_buf[256];
+
+	arcturus_get_metrics_table(smu, &metrics);
+
+	memset(log_buf, 0, sizeof(log_buf));
+	for (throttler_idx = 0; throttler_idx < ARRAY_SIZE(logging_label);
+	     throttler_idx++) {
+		if (metrics.ThrottlerStatus & logging_label[throttler_idx].feature_mask) {
+			throtting_events++;
+			buf_idx += snprintf(log_buf + buf_idx,
+					    sizeof(log_buf) - buf_idx,
+					    "%s%s",
+					    throtting_events > 1 ? " and " : "",
+					    logging_label[throttler_idx].label);
+			if (buf_idx >= sizeof(log_buf)) {
+				pr_err("buffer overflow!\n");
+				log_buf[sizeof(log_buf) - 1] = '\0';
+				break;
+			}
+		}
+	}
+
+	dev_warn(adev->dev, "WARN: GPU thermal throttling temperature reached, expect performance decrease. %s.\n",
+			log_buf);
+}
+
 static const struct pptable_funcs arcturus_ppt_funcs = {
 	/* translate smu index into arcturus specific index */
 	.get_smu_msg_index = arcturus_get_smu_msg_index,
@@ -2423,6 +2466,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.get_pptable_power_limit = arcturus_get_pptable_power_limit,
 	.set_df_cstate = arcturus_set_df_cstate,
 	.allow_xgmi_power_down = arcturus_allow_xgmi_power_down,
+	.log_thermal_throttling_event = arcturus_log_thermal_throttling_event,
 };
 
 void arcturus_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index bac7e13dc801..1223d298c03f 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -575,6 +575,7 @@ struct pptable_funcs {
 	uint32_t (*get_pptable_power_limit)(struct smu_context *smu);
 	int (*disable_umc_cdr_12gbps_workaround)(struct smu_context *smu);
 	int (*set_power_source)(struct smu_context *smu, enum smu_power_src_type power_src);
+	void (*log_thermal_throttling_event)(struct smu_context *smu);
 };
 
 int smu_load_microcode(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index c97444841abc..6b627d6e80b1 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -219,4 +219,6 @@ static inline int smu_send_smc_msg(struct smu_context *smu, enum smu_message_typ
 #define smu_i2c_eeprom_fini(smu, control) \
 		((smu)->ppt_funcs->i2c_eeprom_fini ? (smu)->ppt_funcs->i2c_eeprom_fini((control)) : 0)
 
+#define smu_log_thermal_throttling(smu) \
+		((smu)->ppt_funcs->log_thermal_throttling_event ? (smu)->ppt_funcs->log_thermal_throttling_event((smu)) : 0)
 #endif
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
