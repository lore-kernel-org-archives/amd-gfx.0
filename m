Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4036C47083
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:51:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DD0761C68
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:51:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DD0761C68
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BD626EDA7;
	Wed,  2 Jun 2021 16:51:15 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08EE46EDA7
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:51:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbrA87tgvbAp5A/lrUjPVM8NFw4saUgVHisfYqPK/wm9uZ3FN7BRE+fMvjJwNE+mBl/W9KgbxUTlu7D/hES4XC84VloZ4cTARoapmCh9qO6loGs4jChkV0E+t8D0HDGZf45c94u8YpgbrhXLfZFGoxwyhp14JUjO1GLgHamTYnPxSnxiXLHraUSs6g1U+IwpqGq9DRJqEDDqcOI/2Irx0ws1yqM+NE9TYgONMwCwKPCFuI/GEGaK4ur2qa/6YGWoWJ1xr/T6u0sz6P7s4j/cud2isofLrKJZ7NE73qaKcKj7idlFTZq0g25amvyXb2xEiwQ51EJn3NqzbyqxtSyD3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mfy1cEpJvdK5IBVRmgZkAWt5Khu7cyP0VNNEUG7rCL4=;
 b=QNS2Cndk67VjDH5kIPgupiRU5QwJGtwBXrXsi59QIzZub8M6LbH54fA0/Pr6OpQJJn53H5PARINNppQl1DfTiL4Y1Isb/+0RU4hKtnH7+1xuxBCdVUnybNL8fJbDyYtu3AppO81IiFzrbQgMxu6iy2na9cXsLPg2gzAZoMsuOmWFvwzGD2MmNFIaSct7ZfnIRMPYNipylYjdr2PmY5grA6wy1UY4O7mMAwQwaqKIismq1ji0W2+DgeB3wlI2x823IO8vCVy9Oi6slMu4YQGyBnYWmCOzi/sP9lPC7FeFPmW/1x0Rm8dxgmiKBDjXLaPhOv/+0STF7Yc23XqMRGCEyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mfy1cEpJvdK5IBVRmgZkAWt5Khu7cyP0VNNEUG7rCL4=;
 b=Ie/eikI6HFdAppUvcAfUUAIeglHmkLw3/Kd3ZxZTYmV8r3iremH15OfUR80nUFYjJi+Z5QrHFsiT41kRGka+N47YgHNrQ9Pa9+ZmdNNlj2/+6/LeXiOtWEIWsx68/1Nc33YXFZGzKUcsh7vu5JlRQ1399orBNjyvTNdn/278Xgs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4675.namprd12.prod.outlook.com (2603:10b6:207:35::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 2 Jun
 2021 16:51:12 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:51:12 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 61/89] drm/amd/pm: add callbacks to read/write sysfs file
 pp_power_profile_mode
Date: Wed,  2 Jun 2021 12:48:40 -0400
Message-Id: <20210602164908.2848791-61-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602164908.2848791-1-alexander.deucher@amd.com>
References: <20210602164908.2848791-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Wed, 2 Jun 2021 16:50:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb75954a-65e4-40ae-4fe2-08d925e67bb4
X-MS-TrafficTypeDiagnostic: BL0PR12MB4675:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB46755F76581A1DAB454CFF5EF73D9@BL0PR12MB4675.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:53;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B4FAQ1c9QpeO/vyrCiUgDzDHb6rNrVLclQwA4FajLmtbBRW10YTG6GHGIvS4nYk+7ksR5fNnknW7h1W2yjhRioVJyvFkr5jfcVwq2855Tt+M2zMEcFw//6qBBBDsRKJlA5dMnm9jTRSr1sChk7K8Q4GP+K8j9pbhWQeSc3KWOQGhMl/+pSK5D3OLSpA8yzpLejY4oyjkowqn8atIXW/tBuSgQoaSBDw/ypcMB9xsXaqi/oBhZldp9ZXFM8SXVESbfDatUzbXiZKBNWYvxWdfHEISKU7DBEzM/B96UUsuB5bgTxo6RD9XWr84rWzLGSmZfaaB267YIihAOcXQu/luxCg7nqbKQPJXBuAPriAUrR/DuM7YJYT9LPf3g1tVwHE712OguxE31cdIjbQ4nzdogwgV1QxMYRJ7X0zKLJRBDYilFgUsZIPH+NUqvffGhafMNdYZjSEkWrA7ei91jW12OMIuR7+74khKP7ZavI/SqnPpBUC2Hm+ywrX6eRg3dAvw2yk+HKAgOfaVwWKCKj9dmmN62gFyZpMxNceUYtQeLWcGmjahO2oupFFHCCm+4o4cs0VGzA7PlVBoXpQvOP/cUNdqa+Pk+asqJYgL7afMKgDqREYcEcPG48GuqGQMQLWVzbGckUIwc7c7VQsFLpNxvpKNls5nOzpJP8SMkER5/ZDh6eBceVuJAVnT6oYijTcF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(366004)(52116002)(6486002)(956004)(6666004)(26005)(5660300002)(6506007)(2616005)(36756003)(6512007)(478600001)(38350700002)(66476007)(66556008)(83380400001)(8676002)(2906002)(4326008)(86362001)(1076003)(16526019)(316002)(186003)(54906003)(6916009)(66946007)(38100700002)(8936002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?F8jmmBCJx+62ZQOEl3lWgJ4BWCC4oFAEOkFtF8pEwkJnCzWr04kZT9QHEW0Q?=
 =?us-ascii?Q?lI5zzMqhH1XTjPr8NhHD4le2VbYyAo+6JX4w2IT3daGUNGnxzoy3xjqgZjnF?=
 =?us-ascii?Q?34YMZvcerY1eq+OZn/aJtMcdRislz0a3Rvm9MsnczuFADn2f3elTSBtdxQEa?=
 =?us-ascii?Q?rZPSaVK28tdKYALs5edxFGlyCUQeRVBGBxJDtSzWdRFXgS8Tf3RbvQehpTFZ?=
 =?us-ascii?Q?BeyeLTQPxbzdirmMsYpYY4L+lXeobkxASTsJiSD0TpA5AegOpp4T2BbFNuwj?=
 =?us-ascii?Q?pWJjfQ0uPp27F7djGMMbV/TSOC5GFnbuR1wjwulrd6xnKsHK5kt2+dBnsMli?=
 =?us-ascii?Q?ogVO66sgt+es+lfDu00MEMI4IaWC/UNaY7LaG99movkcBES6NEcEIjKNrt+D?=
 =?us-ascii?Q?D4snJ39Tx1Txgk8XgLngpfXLjuUyhpSEZurTV9N2dnvYjecEKbR8Br5zO1OV?=
 =?us-ascii?Q?tna9MIGtxsakaaJvsN470ioshhkY8qRxXiHghebJdU9+J8y5DZuXtYWIaN7/?=
 =?us-ascii?Q?tuZnINOyz0RV+o1AHgCbzgvDlPLM6krGLi+5D81gcl/lipuWxEvQ0Wrp6Ng7?=
 =?us-ascii?Q?ptLVooLhhZm0JaXOFNbp+A33MineZgXwj/y2C5pVjPhRA+cFHevzWCY3s3hX?=
 =?us-ascii?Q?Su4Gw35po9CNxtzptdoCpQZugUW1+9iZFSlYA8rAhpBplxRALBmRsYh3t4Ec?=
 =?us-ascii?Q?J0jPP+BlStGyJAHupe5hQqiviGTbv62W8G7wfU2YL4GBBZn0zwp5JBJhmemi?=
 =?us-ascii?Q?5n6lTQrLP4aeX5ajtBWXfZvdenUimmQq7Oc8HyCyP/XHDoJHPOWeXh6cgFmy?=
 =?us-ascii?Q?c1j1ZxlSzaaswF7Ai2j2GmF/KFMpEbNHSx6G6L2gIUjWa+38uDLrf0z0RIMc?=
 =?us-ascii?Q?tUWkDo+54Cap8tSNbVEqGFih+8ME3gcZcbCz6VPdB5D16Y/1kfc39OznfSUS?=
 =?us-ascii?Q?Pvel67k1ezsi+wqqboLh27e8dTmIZsd8BAJ+Ns/zJJ0PWaoG+VzHvkH+pSVZ?=
 =?us-ascii?Q?h0MPr0FAApu8nY4wyfvyv/43FKkMncRES/YW8wlKwsCOJXcTa+tWsarX7XiT?=
 =?us-ascii?Q?jT9E2SIjqsn8zyMtW5kT+sNLjDkonhh0usKA105j8AiKYSTiB7GG6DXzXOzw?=
 =?us-ascii?Q?DFpcvbewm8MG7g+LHW90+s6CJWazTMrnCH9ELGZ7SvHvQIAf7jBCeHGSClGQ?=
 =?us-ascii?Q?FK9/xnyroIocC5qSou+1bXaDbmvAIxJMqLMB3o2ddZtWeeHqUgsBB1dlByMw?=
 =?us-ascii?Q?sBazxWxwZruJ2ap73uxMenm6UQWG5Wcq2eT8Yyk2Ko0ag5IuP/HxioCfzTWz?=
 =?us-ascii?Q?pi0/H+f5JE1oQVo69MGkrPoa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb75954a-65e4-40ae-4fe2-08d925e67bb4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:50:09.9120 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ixFclYlhFk7ILFreVP0Pc90+ZlVJk232NUoTSmFeFUimc0tUCO8ggZITzHzk/9vVTdoM+AHPqp/TLXHAjiZN/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4675
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Xiaomeng Hou <Xiaomeng.Hou@amd.com>, Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaomeng Hou <Xiaomeng.Hou@amd.com>

Implement the sysfs API for getting/setting pp_power_profile_mode for
yellow carp.

Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index 080dd761a328..db1252424f0f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -135,6 +135,14 @@ static struct cmn2asic_mapping yellow_carp_table_map[SMU_TABLE_COUNT] = {
 	TAB_MAP_VALID(CUSTOM_DPM),
 	TAB_MAP_VALID(DPMCLOCKS),
 };
+
+static struct cmn2asic_mapping yellow_carp_workload_map[PP_SMC_POWER_PROFILE_COUNT] = {
+	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_FULLSCREEN3D,		WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT),
+	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VIDEO,		WORKLOAD_PPLIB_VIDEO_BIT),
+	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VR,			WORKLOAD_PPLIB_VR_BIT),
+	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_COMPUTE,		WORKLOAD_PPLIB_COMPUTE_BIT),
+	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,		WORKLOAD_PPLIB_CUSTOM_BIT),
+};
 	
 static int yellow_carp_init_smc_tables(struct smu_context *smu)
 {
@@ -463,6 +471,81 @@ static int yellow_carp_set_watermarks_table(struct smu_context *smu,
 	return 0;
 }
 
+static int yellow_carp_get_power_profile_mode(struct smu_context *smu,
+						char *buf)
+{
+	static const char *profile_name[] = {
+					"BOOTUP_DEFAULT",
+					"3D_FULL_SCREEN",
+					"POWER_SAVING",
+					"VIDEO",
+					"VR",
+					"COMPUTE",
+					"CUSTOM"};
+	uint32_t i, size = 0;
+	int16_t workload_type = 0;
+
+	if (!buf)
+		return -EINVAL;
+
+	for (i = 0; i <= PP_SMC_POWER_PROFILE_CUSTOM; i++) {
+		/*
+		 * Conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT.
+		 * Not all profile modes are supported on yellow carp.
+		 */
+		workload_type = smu_cmn_to_asic_specific_index(smu,
+							       CMN2ASIC_MAPPING_WORKLOAD,
+							       i);
+
+		if (workload_type < 0)
+			continue;
+
+		size += sprintf(buf + size, "%2d %14s%s\n",
+			i, profile_name[i], (i == smu->power_profile_mode) ? "*" : " ");
+	}
+
+	return size;
+}
+
+static int yellow_carp_set_power_profile_mode(struct smu_context *smu,
+						long *input, uint32_t size)
+{
+	int workload_type, ret;
+	uint32_t profile_mode = input[size];
+
+	if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
+		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
+		return -EINVAL;
+	}
+
+	if (profile_mode == PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
+			profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING)
+		return 0;
+
+	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
+	workload_type = smu_cmn_to_asic_specific_index(smu,
+						       CMN2ASIC_MAPPING_WORKLOAD,
+						       profile_mode);
+	if (workload_type < 0) {
+		dev_dbg(smu->adev->dev, "Unsupported power profile mode %d on YELLOWCARP\n",
+					profile_mode);
+		return -EINVAL;
+	}
+
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
+				    1 << workload_type,
+				    NULL);
+	if (ret) {
+		dev_err_once(smu->adev->dev, "Fail to set workload type %d\n",
+					workload_type);
+		return ret;
+	}
+
+	smu->power_profile_mode = profile_mode;
+
+	return 0;
+}
+
 static int yellow_carp_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TABLE_COMMAND type,
 					long input[], uint32_t size)
 {
@@ -940,6 +1023,8 @@ static const struct pptable_funcs yellow_carp_ppt_funcs = {
 	.read_sensor = yellow_carp_read_sensor,
 	.is_dpm_running = yellow_carp_is_dpm_running,
 	.set_watermarks_table = yellow_carp_set_watermarks_table,
+	.get_power_profile_mode = yellow_carp_get_power_profile_mode,
+	.set_power_profile_mode = yellow_carp_set_power_profile_mode,
 	.get_enabled_mask = smu_cmn_get_enabled_32_bits_mask,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_driver_table_location = smu_v13_0_1_set_driver_table_location,
@@ -958,5 +1043,6 @@ void yellow_carp_set_ppt_funcs(struct smu_context *smu)
 	smu->message_map = yellow_carp_message_map;
 	smu->feature_map = yellow_carp_feature_mask_map;
 	smu->table_map = yellow_carp_table_map;
+	smu->workload_map = yellow_carp_workload_map;
 	smu->is_apu = true;
 }
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
