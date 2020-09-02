Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839CCC433E6
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 08:32:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52E6720773
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 08:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="iHnUPlp5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52E6720773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 430936E311;
	Wed,  2 Sep 2020 08:32:15 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9551A6E311
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 08:32:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqRMLERwrwW1LBdEzxURtHuWjoyl/GesEH6oFCx+rKU+tSRRv0S5zA0FPc4FrTtJ779qPAwpeVtwmwRr20dFDRE5sRG8Cm+TEprwLsA+QhVn9cZ83vFj3YR9JSI5siDwDG11SOFIq4kKJfjytmEGxvmidxC1c+XBvfCawa749yGujOnLVnuYfn1cH1mqbYTm4OYDGu0xDG12LufyHIbPWqwsWh57ebnWjocM9jj39WDYp3UKZfjmVsREg/pMCcSAGCKcsDB44RtfmFqNrPB0sSY2/DOO+S3TEFVtJHtca+op53Wl1brjNZuzI79ukLSJtcQqXMYRJ6OFepoHVPaIgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FlBb9DjYqwlFjxB8l77OYDjsEuTSOix5dIM9ZuElng=;
 b=WY2pWytkVNOCgAmUAIokC6VEND1jPgcgbgJdXuP6gk06otOxYqQdTb1RoJZmQiFOV4IDSdCUwewEcrlTfWGLlyXy+DwjIgP+ApcMbKNF0kUJADthnmLWuMIZdVTxJHNC1NwPN/+CQyaj4zoq41LCf3jOHe8vfbSC87RvFxYN2q7taZwgSH3wP1ta4JZ5NxJsgHh8R9pWlmeWIm0vs95NSYLKLbcUkQAI31Wft7djx/PphMjsQn7phAgX8jq9Pirip3PLu8B1A6rTUwgWmC3yjo65Uoz4ty6AYS20qbvQrprms8n8xdR8iXIfodKhlMyTwdm/3N0cG0azkotK7i0/jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FlBb9DjYqwlFjxB8l77OYDjsEuTSOix5dIM9ZuElng=;
 b=iHnUPlp5xorzrU7mW9dU4fvBEkjNsnittG1MPFqXgc8kroXfn3HhhxvpHleDjy8zFok09Ln1Yy8E6YG8Z2eYftwsLlaiJ/AaoecC4rTcyIIAWz/VwuRrCgZkoVEXPw/DWNkt1Rj+O11Omee7oT4cewu8NYVojfTNpHxHG4f9GDA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3868.namprd12.prod.outlook.com (2603:10b6:5:1c8::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.23; Wed, 2 Sep 2020 08:32:14 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3348.015; Wed, 2 Sep 2020
 08:32:14 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 7/9] drm/amd/pm: apply the CDR workarounds only with some
 specific UMC firmwares
Date: Wed,  2 Sep 2020 16:31:32 +0800
Message-Id: <20200902083134.25569-7-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200902083134.25569-1-evan.quan@amd.com>
References: <20200902083134.25569-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR0302CA0004.apcprd03.prod.outlook.com
 (2603:1096:202::14) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 HK2PR0302CA0004.apcprd03.prod.outlook.com (2603:1096:202::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.7 via Frontend Transport; Wed, 2 Sep 2020 08:32:12 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cfba1e00-758b-4fef-554f-08d84f1ab170
X-MS-TrafficTypeDiagnostic: DM6PR12MB3868:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3868F591BCFAD362693CCFBAE42F0@DM6PR12MB3868.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jvaXQ7Z0AQm2KHvgRz5aMwDvgpulTWqHC5Lk7BCWKYPpGlXZxBdC4h0XKkRsKlbd6F9Ahh7HuvwlNPJ7MtY6NMnT53MI52oo5aBeIA3iOdvhiPEh+Stc8oM/YOH8zmN8lOJ/oX98lv1cnknNvzh8fhn6FsLwrOApajp9T+iQgKdDRwEbUoGKw/xSur7/IZ996fHSA4JSF1ZDxIawQMHb7MGm1bpxaKI6hD70K56U09CKon4XJKsCZa7AVvG+Oo2nMeqKxW+6NC+LrxF9/hEUJ8QruxbGmIXqYzyYtwXzlO4DRfmK0eD4QogiaT+T+26q1pzOJwHoc4FjBaZDbMoFnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(83380400001)(66946007)(2906002)(36756003)(16576012)(66556008)(4326008)(44832011)(316002)(186003)(66476007)(5660300002)(6486002)(8676002)(86362001)(6666004)(26005)(2616005)(956004)(6916009)(478600001)(52116002)(8936002)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 0vZJq8o6HDmiQCT7CbdLFq/gY4ChU39AYsZbTyWVeIVqUDFHp8jPy4iEt1G/jzIonzBTZkf0O+aq76hEgVLVBjto0QD1ztRWedJYg0ve88xuJdqDbFf7AyjeaEyac9EWialYI6WrQbmpQnS3Wkl1XGqkjVpQ26q6gYIlWpcJisMnRcsFwOFs3zkjPaPGW9fwgEFBzFC/q0iiUi+NqMTPLpedhFVccSihqllEwRMNyEk1JY3gGDcbc7vEgtZjA30KKI3QSMFCkUFqiLu3ylh+dJ6MbmS03nYM8D8avG+x0L7gsruYgiX84kHvYH2rnsgkCkksg2YsdJ9BXLEhOW5SYp9f6I/gl9qmpk8qFriHxHYITa/9AO2BQzHcsnGQNX0OP5Q60HGwLqmIzaMleU2y0oKWuX4yfpdk3UIsY1KqSxIMVNUcty4r40Gh3KWSpIzQdAPItV9vIrW5EAy+DkC5G2p/gbyifL83odxnlfkMzndRw7++r7VwumFldVBGGsdPaZADUbHUre3Hk6dLRPZZF51qgwSQwgKMK59ZWqDY6xdVH4yN64DK8jzqLGHJALHpQfwzsXPUirlLQXC/ybOTz3woWY5RNZLHbDP9RlgY65InW/5ky+55FHgT5naAdB6xfKAOvNYnqUC9BNJ+5MRRlw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfba1e00-758b-4fef-554f-08d84f1ab170
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 08:32:13.9067 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vImhbxFyl5OzghhgXmu22pACwzqUJE6QWEut8xepP7VQf0uzVurAqO5q9Eq2lbrA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3868
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

And different workaround will be applied based on hybrid cdr bit.

Change-Id: I828dc3605dbe0bb5a5e1a0db409658608ff21888
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_types.h        |  1 +
 drivers/gpu/drm/amd/pm/inc/smu_v11_0_ppsmc.h  |  4 ++-
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 28 +++++++++++++++----
 3 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/amd/pm/inc/smu_types.h
index 4a8655a20ef6..35fc46d3c9c0 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_types.h
@@ -175,6 +175,7 @@
 	__SMU_DUMMY_MAP(DAL_ENABLE_DUMMY_PSTATE_CHANGE), \
 	__SMU_DUMMY_MAP(SET_DRIVER_DUMMY_TABLE_DRAM_ADDR_HIGH), \
 	__SMU_DUMMY_MAP(SET_DRIVER_DUMMY_TABLE_DRAM_ADDR_LOW), \
+	__SMU_DUMMY_MAP(GET_UMC_FW_WA), \
 	__SMU_DUMMY_MAP(Mode1Reset), \
 
 #undef __SMU_DUMMY_MAP
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0_ppsmc.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0_ppsmc.h
index fc8594e9b2bd..26181b679098 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0_ppsmc.h
@@ -128,7 +128,9 @@
 #define PPSMC_MSG_SetDriverDummyTableDramAddrHigh 0x4E
 #define PPSMC_MSG_SetDriverDummyTableDramAddrLow  0x4F
 
-#define PPSMC_Message_Count                      0x50
+#define PPSMC_MSG_GetUMCFWWA                     0x50
+
+#define PPSMC_Message_Count                      0x51
 
 typedef uint32_t PPSMC_Result;
 typedef uint32_t PPSMC_Msg;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 061eee1a4c32..e02d036fb298 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -142,6 +142,7 @@ static struct cmn2asic_msg_mapping navi10_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(SetMGpuFanBoostLimitRpm,	PPSMC_MSG_SetMGpuFanBoostLimitRpm,	0),
 	MSG_MAP(SET_DRIVER_DUMMY_TABLE_DRAM_ADDR_HIGH, PPSMC_MSG_SetDriverDummyTableDramAddrHigh, 0),
 	MSG_MAP(SET_DRIVER_DUMMY_TABLE_DRAM_ADDR_LOW, PPSMC_MSG_SetDriverDummyTableDramAddrLow, 0),
+	MSG_MAP(GET_UMC_FW_WA,			PPSMC_MSG_GetUMCFWWA,			0),
 };
 
 static struct cmn2asic_mapping navi10_clk_map[SMU_CLK_COUNT] = {
@@ -2278,21 +2279,36 @@ static int navi10_set_dummy_pstates_table_location(struct smu_context *smu)
 
 static int navi10_disable_umc_cdr_12gbps_workaround(struct smu_context *smu)
 {
-	uint32_t smu_version;
+	struct amdgpu_device *adev = smu->adev;
+	uint8_t umc_fw_greater_than_v136 = false;
+	uint8_t umc_fw_disable_cdr = false;
+	uint32_t param;
 	int ret = 0;
 
-	if (!navi10_need_umc_cdr_12gbps_workaround(smu->adev))
+	if (!navi10_need_umc_cdr_12gbps_workaround(adev))
 		return 0;
 
-	ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
+	ret = smu_cmn_send_smc_msg_with_param(smu,
+					      SMU_MSG_GET_UMC_FW_WA,
+					      0,
+					      &param);
 	if (ret)
 		return ret;
 
-	/* This workaround is available only for 42.50 or later SMC firmwares */
-	if (smu_version < 0x2A3200)
+	/* First bit indicates if the UMC f/w is above v137 */
+	umc_fw_greater_than_v136 = param & 0x1;
+
+	/* Second bit indicates if hybrid-cdr is disabled */
+	umc_fw_disable_cdr = param & 0x2;
+
+	/* w/a only allowed if UMC f/w is <= 136 */
+	if (umc_fw_greater_than_v136)
 		return 0;
 
-	return navi10_umc_hybrid_cdr_workaround(smu);
+	if (umc_fw_disable_cdr && adev->asic_type == CHIP_NAVI10)
+		return navi10_umc_hybrid_cdr_workaround(smu);
+	else
+		return navi10_set_dummy_pstates_table_location(smu);
 }
 
 static void navi10_fill_i2c_req(SwI2cRequest_t  *req, bool write,
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
