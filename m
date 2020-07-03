Return-Path: <SRS0=khk6=AO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5373EC433DF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 08:34:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29620207FF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 08:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Nmd2unHO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29620207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D92E06EB37;
	Fri,  3 Jul 2020 08:34:09 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27F846EB37
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jul 2020 08:34:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJG5BvYLOw+BnkzOuHJixZ87AUbAfcZZhMLw1oHcGxyzbOD1bk0SkgsI1bFAdnHEP4FcxJ+dT9d5hAYAdLMeHpeQfA+hhEwBhdeZi3HgPlJNaGweitEhYcX5QUgHphwgUBgEia02swOyri87cg9FcIO0FhVTinlFkKTKk3TLLkO9efZf04k4xO01dpcoDFPRDy9TU/Q2JeE50cPh8+iF0XeUzPhJsxJs6MZALi6IhWfj16ksRL3xRldvbzDaw3c1cGmv5hMcQM9FSGHRJSQR+pUz+mC0W0xxpRcCIpcRgcIdQWbc449OHVipYuow6eu/XoB+tcWkhQy93L4a1Av/6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pEyIxb79pp6Ywt2kLVSEGKvbOPJL2pK1ck+c4EL79c=;
 b=aBLHUi1IiBQGnv6zWPPmyb9lQ5Ewo5VXjk787l/ZMDZj95h8cKJwqRTak/c4qoYPMYRZPAt0n8yu05yJoAx+NTbxT0bTmBI/ZzXYe4+FmVSd5yQKMkMmqWZrRkiyThzLGkP59n3tovn5EQL7yMPOD6Sh13yLGhSlHpI7PV4dfzSS1Kz7HroJfuLH6LSVUrzQMh36NQTsRq5IGiW0SmuCj0EkSSwZwwaU0MEgOHd0GlRNqxJFFD5KDEidqXwzdoiUra5Dl9p+MJn1N1IRo0nXrdtj9xFznmQlpwvebl8f6CaoVykq3EP+58oM3O8bM8G8BLxf+w8PSl5KXWke6KAA4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pEyIxb79pp6Ywt2kLVSEGKvbOPJL2pK1ck+c4EL79c=;
 b=Nmd2unHOSlTa1yfJ9RTHlDqNQzBYHGWMNuyPB7mNMkFSCjf1MzuCMX46r0iK1ewg/h33TM5fzY5MnDO1hiiO8qrzcCYddVc9Y4dsw+M8xEC3cLJyPUjwLBDfSRu50VQBRHj1yee0fOkgMPnnWbD9/uZLqxD0c4sIziFUuT4zf2Y=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.27; Fri, 3 Jul 2020 08:34:07 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3153.023; Fri, 3 Jul 2020
 08:34:07 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 12/14] drm/amd/powerplay: drop unnecessary wrappers
Date: Fri,  3 Jul 2020 16:33:01 +0800
Message-Id: <20200703083303.478-12-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200703083303.478-1-evan.quan@amd.com>
References: <20200703083303.478-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR02CA0139.apcprd02.prod.outlook.com
 (2603:1096:202:16::23) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR02CA0139.apcprd02.prod.outlook.com (2603:1096:202:16::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.22 via Frontend Transport; Fri, 3 Jul 2020 08:34:05 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 92e8b243-414a-4094-8b12-08d81f2bd9b8
X-MS-TrafficTypeDiagnostic: DM6PR12MB3962:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3962FB93343359DD01A5B69FE46A0@DM6PR12MB3962.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZKvoXMSOczZ60QnRjJEZwaevgxZHYLekberPhUw848pXhM5i7WPlJNAKuSM+zHGoa9xBvdV3d3Xs0SRO1+kzQwyB9D4S3ydkbCWOcUwfk8n+JWrr+4VtF2V7nu8XuzucxiOWhC83DCmNK80QhE5ocMwUI3FrdDJLt3tJ3az+ygiAa94a3Y29v0fS+ay8/3RHqRQM8PUIRKOcnEc1Tr4OQ4O2Y5oOl9OSsrbUYqyUQAGxNJhIMQZfIqncnM+Q6taiZVLIycP+kIuxFZcVRTgsY4Avvtm2L+kO/Gw3BFplo8Zo3ATUA3/xXc1IMKjRptvvJhXGyjBzCogSvNFQ83SA2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(83380400001)(44832011)(4326008)(36756003)(8936002)(7696005)(956004)(2616005)(6486002)(52116002)(478600001)(6666004)(66946007)(16526019)(26005)(186003)(66476007)(5660300002)(1076003)(66556008)(8676002)(316002)(86362001)(6916009)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: aGviV9KT2DjYbmf65euiyV37Dm6xQ400frsNMUVx+V0AW6oLUuHtWrwDAr7v5udKAQANlSN/giDTFUt6kuqt3h2Cr7XpBywQY7u7e2PS7AN+Z5N0T/Ev69xkGMkB1HuF1NLpgbymDz4/es30KM/8IcIhqbDF5cGEEkhqZKqEt0dI0AcC2en5iOh0WPvS/4+NytuHjWniSn2yvsGvzIgn1pqKQ9/GqWDmJHfi/kPi3fYEsYM88dLyRQit2IWsgPqEh98Yx5WDmFAmVf9VQ2lXVo5R56xWEmF7kJVSie+6odHt6eAm4OV6fhPvPmnAcbqaSgCn0jn8sGp0hpRMc2Fr0iXj1tnFqtEqIOpaBNlquo2OtC9VfDrEaiyI8Nckov88MrJMdIim0gMjw/G9AbDDK43hFGOr6Jy4IAX0rnUWoVFbbuwnPMDcEnLMV2ydtygskipAuW1Auv44AYtFIDKNdSyYCdt/kQCqMyzkrUVzr/wFp/QdP0vv8zIURRFu1TIJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e8b243-414a-4094-8b12-08d81f2bd9b8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 08:34:07.2208 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oLoMabED/0RLkF/n/Oj8aeZOXUAfGGxQeq1lWDhoyauX3AMSCcx1ZbM7tp75JufS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3962
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

By calling the target APIs directly.

Change-Id: I0f24f603d2fcb94d2078a35c405a1406093ba5e3
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index d4aa01a05c54..49a8d636ef4d 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -743,26 +743,26 @@ static int renoir_set_performance_level(struct smu_context *smu,
 
 	switch (level) {
 	case AMD_DPM_FORCED_LEVEL_HIGH:
-		ret = smu_force_dpm_limit_value(smu, true);
+		ret = renoir_force_dpm_limit_value(smu, true);
 		break;
 	case AMD_DPM_FORCED_LEVEL_LOW:
-		ret = smu_force_dpm_limit_value(smu, false);
+		ret = renoir_force_dpm_limit_value(smu, false);
 		break;
 	case AMD_DPM_FORCED_LEVEL_AUTO:
 	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
-		ret = smu_unforce_dpm_levels(smu);
+		ret = renoir_unforce_dpm_levels(smu);
 		break;
 	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
 	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
-		ret = smu_get_profiling_clk_mask(smu, level,
-						 &sclk_mask,
-						 &mclk_mask,
-						 &soc_mask);
+		ret = renoir_get_profiling_clk_mask(smu, level,
+						    &sclk_mask,
+						    &mclk_mask,
+						    &soc_mask);
 		if (ret)
 			return ret;
-		smu_force_clk_levels(smu, SMU_SCLK, 1 << sclk_mask, false);
-		smu_force_clk_levels(smu, SMU_MCLK, 1 << mclk_mask, false);
-		smu_force_clk_levels(smu, SMU_SOCCLK, 1 << soc_mask, false);
+		renoir_force_clk_levels(smu, SMU_SCLK, 1 << sclk_mask);
+		renoir_force_clk_levels(smu, SMU_MCLK, 1 << mclk_mask);
+		renoir_force_clk_levels(smu, SMU_SOCCLK, 1 << soc_mask);
 		break;
 	case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
 		ret = renoir_set_peak_clock_by_device(smu);
@@ -942,8 +942,6 @@ static const struct pptable_funcs renoir_ppt_funcs = {
 	.get_current_power_state = renoir_get_current_power_state,
 	.dpm_set_vcn_enable = renoir_dpm_set_vcn_enable,
 	.dpm_set_jpeg_enable = renoir_dpm_set_jpeg_enable,
-	.force_dpm_limit_value = renoir_force_dpm_limit_value,
-	.unforce_dpm_levels = renoir_unforce_dpm_levels,
 	.get_workload_type = renoir_get_workload_type,
 	.get_profiling_clk_mask = renoir_get_profiling_clk_mask,
 	.force_clk_levels = renoir_force_clk_levels,
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
