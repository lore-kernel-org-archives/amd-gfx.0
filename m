Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC11C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:27:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10317206ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="um9FA4J5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10317206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E2F66E9B1;
	Fri, 16 Oct 2020 03:27:43 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DDCF6E9B1
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 03:27:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=npwZV2z/0ct5LwJf5LrJcjT5pEXRfz9fWbuDVDaix3NPDMj1khpflY3GJuOECQf7T3ixK61n+uW6v0dqBDJseFtt/3ZHIsGnQ7PSY+RUx2rM4qwjcx+iQH/lJyCovI0bGSDK5y+wvkL4ttTnCDd0Xv/40m1U5DxZJFx+uU9T3Typ5Af9B5lGjTYFqM3gBwOe0edx321xhALJ3Pd/djj32+jd+bbGvEKptIO+r/xoKSYIBnh/HuxE84HCwuSySRE1vibS9O71RbVvTA7ZET1VWyh3pcu0EiXBTVrPxuoAp8ORp3+WTPtegE0DLXP6ffvopvGX6I7pP5W1pnZ1jMAxWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JNxnwMYjT685XHZMJkOTA0HGS90+f1iL7ZdmV+vZP2g=;
 b=RwljrGXYsyR5RJcOrm4J/P+xNwq71QZhV+dzaTDlfCDvsa9AIK+QsgmSAcYqfN4PurWGEmPGmGsjwsmaMbnmLBzihjLl/E3seuvZVJs6RM20B5/Rnkk+vCSC5Z3kZqRLVKok/UyQt3hUjDNVJcLaATzgiyhaOPGz/JB+SE5p8bdLZuzRg/nIc78g7LX2JyNHajbH9U1RjQFPyQO2IqPia2WdO/0QWjpAQsc3ue2DGmgXlLBN6+CBL0vPEY3Vn67O/kEnvLq0qxldQ+VqmlI0dltSzX9OeKEoimJE+fIoTTcx6IaThw/b7lpzo/xk/GfWnuIFbdGRy9GAD+tvl1R/ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JNxnwMYjT685XHZMJkOTA0HGS90+f1iL7ZdmV+vZP2g=;
 b=um9FA4J5bmk36ujWxeil7OueAOkMdxEwva+SzSMkgjAoRlUChzfhgRZGqktkaFqkzApXcnAqGLWKJeZKrlswpusjcX5uj+/1MKmNB/nadBC1H0Jjs6FiKjNu32LEO6l/wr+0F0lrxyQ0P8s88rySAk780OG4b04cNs7jzkZ1ghk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB4680.namprd12.prod.outlook.com (2603:10b6:4:a6::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Fri, 16 Oct 2020 03:27:41 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.023; Fri, 16 Oct 2020
 03:27:41 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/40] drm/amd/pm: correct sclk table setup
Date: Fri, 16 Oct 2020 11:26:17 +0800
Message-Id: <20201016032652.507-6-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016032652.507-1-evan.quan@amd.com>
References: <20201016032652.507-1-evan.quan@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0302CA0007.apcprd03.prod.outlook.com
 (2603:1096:202::17) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0302CA0007.apcprd03.prod.outlook.com (2603:1096:202::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.8 via Frontend Transport; Fri, 16 Oct 2020 03:27:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b73ab47f-ae3e-4b4e-830f-08d871837017
X-MS-TrafficTypeDiagnostic: DM5PR12MB4680:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB46809CE3CF3C9CDFC14BDA2FE4030@DM5PR12MB4680.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uMQHq0+AGoS90C+5gSTqmxVepVTWjibI7MKEmiIqfHvpbUY2njenmYzLw03F791vv3D28RnTOUNLe/YZA4g4EEp0tWM0S/vOApso20d9bnV74Xa3iZNveffPdt96nGhW/2BpDY/HGYj5LBaCXL9g64WqhgGSnVSVy0ZvOndVx2KmJfoj2r/y5CLX3s23zIsc8rUgk7HFnBKgdjEC0V2i+UtkSj9ObPtjNNGn1kSinvfdVUlORgzoFJ4sdLM3Cn6JnJc+o1veOfrBcF63Lqt7HAd66XXQUzntQ24YUQJWU4DKbxwMXOrJS1BKFcJtY9A2PeG1V8pDbx4XfwSDK+QppMIENd4dkznNIliHdoMQgBNS00OifG6p0Ri5KzjRq8Kr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(478600001)(4326008)(83380400001)(6666004)(36756003)(316002)(34490700002)(66946007)(6916009)(5660300002)(956004)(66556008)(66476007)(2616005)(44832011)(186003)(52116002)(7696005)(86362001)(8676002)(2906002)(6486002)(26005)(16526019)(1076003)(8936002)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: kGZjA3/kQHhSTr79/lTd58LG6jFG4Csoiv9jzyNzOdm4CykmzzjWo7I8eSVhNhz5w0nB8H7LQYNjwPwuA4DiB5dbPAOArydlV25M6eN8OKwz3joiGGc/DyCQWnydS0hWVowGVhgNHOr2yz9jt6sdu2SnYZN8j/kgF/3ZRejTCspTKIu05LbfWpYaqGImLVYR5EaJpVEdkM8SqiPghfq1HPzXlENNuPUk8aPZur5wxahIwf41SIdgRFxrTMov8V1qrTvxAtwOp/TJR3YxmnYu55kCrluTZdzHQrIsdFQbt4BySHpxHkeuS4haAXLUwiwiVO2SB5fdTzhoPc7h9k1uxBN5+udD/01p9EGlncL6IZsYrrNO6G/NbOuq16mgIpA0+l254EKyD1KPCuz89Zbpe6tuL7/lH7xGJ7RMqleooZYcXBStwUVNAvIgV4O+MR+djTBgYRbQQnhEY+7WU5pB/fFZqD5T5wFHgwuA0BtWsc5bslnUbWhHQh7QPjS+anW+OM8NoRDHgOuHqFbBkC5T4bB6zL6Q72L/dJ6YPHMvWYokdqb1Q3UK3iTPSRxzqnxWJGHWf8GaoYbmoI827ikkZvHZMie70jDIetgSZBESCXeQq6FSWF9LnP1X1SFdPQh/c775oHn3+Zr2fSW4WhHMpw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b73ab47f-ae3e-4b4e-830f-08d871837017
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 03:27:40.9607 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cJ7IVYs/bP5FGGjDpr4VLu14jNIxjENEGTkfuKneKAI7YqgzJKLRLOusSRvA5Dri
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB4680
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

Correct Polaris10 sclk table setup.

Change-Id: I1685f3608b7113f7e9713c343ca33b8676693707
Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../pm/powerplay/smumgr/polaris10_smumgr.c    | 23 +++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
index 34cf3bedfc11..b2f2fb9da4e9 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
@@ -1022,6 +1022,9 @@ static int polaris10_populate_all_graphic_levels(struct pp_hwmgr *hwmgr)
 		lowest_pcie_level_enabled = 0,
 		mid_pcie_level_enabled = 0,
 		count = 0;
+	struct amdgpu_device *adev = hwmgr->adev;
+	pp_atomctrl_clock_dividers_vi dividers;
+	uint32_t dpm0_sclkfrequency = levels[0].SclkSetting.SclkFrequency;
 
 	polaris10_get_sclk_range_table(hwmgr, &(smu_data->smc_state_table));
 
@@ -1038,15 +1041,31 @@ static int polaris10_populate_all_graphic_levels(struct pp_hwmgr *hwmgr)
 			levels[i].DeepSleepDivId = 0;
 	}
 	if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
-					PHM_PlatformCaps_SPLLShutdownSupport))
+					PHM_PlatformCaps_SPLLShutdownSupport)) {
 		smu_data->smc_state_table.GraphicsLevel[0].SclkSetting.SSc_En = 0;
+		if (dpm0_sclkfrequency != levels[0].SclkSetting.SclkFrequency) {
+			result = atomctrl_get_dfs_pll_dividers_vi(hwmgr,
+					dpm_table->sclk_table.dpm_levels[0].value,
+					&dividers);
+			PP_ASSERT_WITH_CODE((0 == result),
+					"can not find divide id for sclk",
+					return result);
+			smum_send_msg_to_smc_with_parameter(hwmgr,
+					PPSMC_MSG_SetGpuPllDfsForSclk,
+					dividers.real_clock < dpm_table->sclk_table.dpm_levels[0].value ?
+					dividers.pll_post_divider - 1 : dividers.pll_post_divider,
+					NULL);
+		}
+	}
 
-	smu_data->smc_state_table.GraphicsLevel[0].EnabledForActivity = 1;
 	smu_data->smc_state_table.GraphicsDpmLevelCount =
 			(uint8_t)dpm_table->sclk_table.count;
 	hw_data->dpm_level_enable_mask.sclk_dpm_enable_mask =
 			phm_get_dpm_level_enable_mask_value(&dpm_table->sclk_table);
 
+	for (i = 0; i < smu_data->smc_state_table.GraphicsDpmLevelCount; i++)
+		smu_data->smc_state_table.GraphicsLevel[i].EnabledForActivity =
+			(hw_data->dpm_level_enable_mask.sclk_dpm_enable_mask & (1 << i)) >> i;
 
 	if (pcie_table != NULL) {
 		PP_ASSERT_WITH_CODE((1 <= pcie_entry_cnt),
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
