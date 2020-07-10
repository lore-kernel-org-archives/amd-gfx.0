Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D61C433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 04:48:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3434820720
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 04:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CVq0ZWin"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3434820720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEEA26EB6D;
	Fri, 10 Jul 2020 04:48:25 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 533E36EB6C
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 04:48:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F4u2Bd92W9mOm1Cgzw2g0JiVV7vH7IWY1zG0AnixX7fgdRX/6AvUoFa/my5YKYBBZ1kDdxLvDAV+ay07Hz+Jbke37fEpOwcb/0LkGQ5JSQCCvTb4lRG32X6uyDpaBT6djo1iwzuOxIjMcyQeHchHZGIXqGZ0sXjz616wFNh4TcfkCkhFp0E4MsfBG/bPn6gFwNkj83DjadEVxHsTY4MGmgc6h6O/ejn0vTUTPiES8MowxTGaQ9xRysOP3uTbVlt2OFFTWUF2aXfL3IjJu1QLz5RGHpmH5a3AoPOmMmFII2UoWTY00PVqG6m6MBm2YgDVAW/7GljfIlVqX0ckuR/rrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GStVVfk+3RSzyHnXhW9l2k/rj0MdL9Pw/JOk+J0OjYE=;
 b=jhlulsNARQMjQKzlpol9fcpO2/32L1ucWSJI1z9oz6UVPj652FxW24n0i6e7RvOxYusYZLHB1E8foD0Tf6nxtRZFgZf+dJQ7isIZSSLWbMSB5yWiDmoEZnYgjxrqeXYxGWG23Z5Ot1Ygj7XLZ8GvSm0SCBYhsLmnQsLDmRjEJkS28A81NA7DvVxhy84PpCkgcCBdzjBp5nIS0w86u7jLB/dUw/nTIvAK/VNbX2/AvisFll+WFsc1f/WXWbW35sW73Vpu7vURypSj0ivAvLacDoqtFO1rWAC5lZ3qN5mdduk/1DRSsMupzJ43Eu1ODoAn7cylKz82Nrc0d29aOKFwOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GStVVfk+3RSzyHnXhW9l2k/rj0MdL9Pw/JOk+J0OjYE=;
 b=CVq0ZWinHsm8F3B76k0XeWtp409AlLGIlFZlDDhhR417Sseypplop60ewPUbaq2Akf76BYQgL/MLbBQj/LI/Gfteujfy6X9+BRGlfBs5z5my0i27XhZwd+bcTNA/orD8BlXsKEKm6xgWguvLm4oSdsUzwdfeTjtdAEZprIxRrik=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB2360.namprd12.prod.outlook.com (2603:10b6:4:bb::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21; Fri, 10 Jul 2020 04:48:22 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 04:48:22 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/16] drm/amd/powerplay: update the common API for
 performance level setting
Date: Fri, 10 Jul 2020 12:47:38 +0800
Message-Id: <20200710044746.23538-8-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200710044746.23538-1-evan.quan@amd.com>
References: <20200710044746.23538-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR03CA0059.apcprd03.prod.outlook.com
 (2603:1096:202:17::29) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR03CA0059.apcprd03.prod.outlook.com (2603:1096:202:17::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.9 via Frontend Transport; Fri, 10 Jul 2020 04:48:21 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5dc99250-97ee-4990-bdfb-08d8248c7987
X-MS-TrafficTypeDiagnostic: DM5PR12MB2360:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2360F27C4191A8421B18472AE4650@DM5PR12MB2360.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:820;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZfzJgZPUHwU+Kpo2sdpeDIgnP7iLeF3haU+GtlOx0eDcWCvnYZfckxpKHZxw7kx9/9zr57jpfSLAYcx24bKIeO6Gd7A4+YeFY0h/GMfdD4zUwqMOtYjpsy/b6GkDSnq4BAoqN1Dg6hHuW3JfKgVfo4JeL3gk3Ek7sCZYsHYA7wbasrTWUj3V0FEqW6WTwpfQpdSt19pa46c20IbMhtE87SUmlYlDaSJpPGIBW0N+wjALlC/t03yfnnyp7/zOV8VJ40fRgQKRMQQkw6tAriBu1NW0YNb2Qke3BLKU1DCanC1mq73SzgQt097qVJHqtCAJG2C9/oaQjpeVM/wJ0n63ng==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(2906002)(4326008)(8676002)(8936002)(83380400001)(6486002)(44832011)(7696005)(52116002)(186003)(16526019)(956004)(2616005)(26005)(6916009)(316002)(478600001)(86362001)(6666004)(5660300002)(66556008)(1076003)(66476007)(36756003)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: fOO6xCg264uqoYry+Nc36wUY3GIUDJNKfDGrCk4Y0NttSe8UTxaXqM2g/9lrkKxEFSxzO+Wm4QIi46qGimr53c+9YonFHFWMouCkXIRkJ67tE5WfkJ/43FEE70mdglm/hEFQU0cfE+g1CF4kjvlATfIfbhNG4C9mTlIWOa6rXG1rfhf649KkBG5r4TCB37yIuFvyq79/xMQnHGEbDb7zK3NyERIV8vOTw98OPh7qe1TC6U/0uMaX10N75PRAOdNwtVkhJT5jDN5hUtzDUtDQI0WJ3teRn/cc16d/nre3bizlKKhwhgQQPXvNktFGKX9E87E3JnrQsMssgNG7jvflzigJumLuPQ8ihV/dW2DXBWZYDtgjT7Rhw+hFKBm8lI/MC9obCWxax/pe89KjjqmG2A1BbK2aQpjYXllLO7czNeaOua93xuKzCnDFlPBYWFYJVHU94BpCzEraABFLr2ElJs6DxeI5EgDvErILQ6UEqG7LITfVh2yL4mCdA5PmoRZx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dc99250-97ee-4990-bdfb-08d8248c7987
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 04:48:22.8344 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HIuFQLnl9s04Y9h5FsOOWHqBUnA/CgZRxFeU9WSn2uRSvBAv2tvbyYIr3PK+IOaw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2360
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

So that it can be more widely shared around SMU v11 ASICs.

Change-Id: Ie110edf2ec519699448d3ff3215188ba243d2415
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 91 +++++++++++++++++++----
 1 file changed, 77 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 7206b9f76042..f96ff062eb64 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1855,38 +1855,101 @@ int smu_v11_0_override_pcie_parameters(struct smu_context *smu)
 int smu_v11_0_set_performance_level(struct smu_context *smu,
 				    enum amd_dpm_forced_level level)
 {
+	struct smu_11_0_dpm_context *dpm_context =
+				smu->smu_dpm.dpm_context;
+	struct smu_11_0_dpm_table *gfx_table =
+				&dpm_context->dpm_tables.gfx_table;
+	struct smu_11_0_dpm_table *mem_table =
+				&dpm_context->dpm_tables.uclk_table;
+	struct smu_11_0_dpm_table *soc_table =
+				&dpm_context->dpm_tables.soc_table;
+	struct smu_umd_pstate_table *pstate_table =
+				&smu->pstate_table;
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t sclk_min = 0, sclk_max = 0;
+	uint32_t mclk_min = 0, mclk_max = 0;
+	uint32_t socclk_min = 0, socclk_max = 0;
 	int ret = 0;
-	uint32_t sclk_mask, mclk_mask, soc_mask;
 
 	switch (level) {
 	case AMD_DPM_FORCED_LEVEL_HIGH:
-		ret = smu_force_dpm_limit_value(smu, true);
+		sclk_min = sclk_max = gfx_table->max;
+		mclk_min = mclk_max = mem_table->max;
+		socclk_min = socclk_max = soc_table->max;
 		break;
 	case AMD_DPM_FORCED_LEVEL_LOW:
-		ret = smu_force_dpm_limit_value(smu, false);
+		sclk_min = sclk_max = gfx_table->min;
+		mclk_min = mclk_max = mem_table->min;
+		socclk_min = socclk_max = soc_table->min;
 		break;
 	case AMD_DPM_FORCED_LEVEL_AUTO:
+		sclk_min = gfx_table->min;
+		sclk_max = gfx_table->max;
+		mclk_min = mem_table->min;
+		mclk_max = mem_table->max;
+		socclk_min = soc_table->min;
+		socclk_max = soc_table->max;
+		break;
 	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
-		ret = smu_unforce_dpm_levels(smu);
+		sclk_min = sclk_max = pstate_table->gfxclk_pstate.standard;
+		mclk_min = mclk_max = pstate_table->uclk_pstate.standard;
+		socclk_min = socclk_max = pstate_table->socclk_pstate.standard;
 		break;
 	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
+		sclk_min = sclk_max = pstate_table->gfxclk_pstate.min;
+		break;
 	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
+		mclk_min = mclk_max = pstate_table->uclk_pstate.min;
+		break;
 	case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
-		ret = smu_get_profiling_clk_mask(smu, level,
-						 &sclk_mask,
-						 &mclk_mask,
-						 &soc_mask);
-		if (ret)
-			return ret;
-		smu_force_clk_levels(smu, SMU_SCLK, 1 << sclk_mask, false);
-		smu_force_clk_levels(smu, SMU_MCLK, 1 << mclk_mask, false);
-		smu_force_clk_levels(smu, SMU_SOCCLK, 1 << soc_mask, false);
+		sclk_min = sclk_max = pstate_table->gfxclk_pstate.peak;
+		mclk_min = mclk_max = pstate_table->uclk_pstate.peak;
+		socclk_min = socclk_max = pstate_table->socclk_pstate.peak;
 		break;
 	case AMD_DPM_FORCED_LEVEL_MANUAL:
 	case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
+		return 0;
 	default:
-		break;
+		dev_err(adev->dev, "Invalid performance level %d\n", level);
+		return -EINVAL;
+	}
+
+	/*
+	 * Separate MCLK and SOCCLK soft min/max settings are not allowed
+	 * on Arcturus.
+	 */
+	if (adev->asic_type == CHIP_ARCTURUS) {
+		mclk_min = mclk_max = 0;
+		socclk_min = socclk_max = 0;
 	}
+
+	if (sclk_min && sclk_max) {
+		ret = smu_v11_0_set_soft_freq_limited_range(smu,
+							    SMU_GFXCLK,
+							    sclk_min,
+							    sclk_max);
+		if (ret)
+			return ret;
+	}
+
+	if (mclk_min && mclk_max) {
+		ret = smu_v11_0_set_soft_freq_limited_range(smu,
+							    SMU_MCLK,
+							    mclk_min,
+							    mclk_max);
+		if (ret)
+			return ret;
+	}
+
+	if (socclk_min && socclk_max) {
+		ret = smu_v11_0_set_soft_freq_limited_range(smu,
+							    SMU_SOCCLK,
+							    socclk_min,
+							    socclk_max);
+		if (ret)
+			return ret;
+	}
+
 	return ret;
 }
 
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
