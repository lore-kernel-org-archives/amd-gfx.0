Return-Path: <SRS0=ZeSq=BX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BC9C433E5
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 09:08:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 868B32074D
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 09:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mzGIPKKN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 868B32074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA0FA6E96B;
	Thu, 13 Aug 2020 09:08:50 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B38EE6E96B
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2020 09:08:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OIFFBF/HkY/mFQZWW5hCjMldsm2GTmwwU6BOD1apFBRuLhl5ugUyqLU3Hzoj/GXZlu5keS+6igJjtk5VggN8ddortqPe1gReG/T4CXjcruW8mVIWW7Dhg3fiy2W+Eg+1gMJWupjw3LTB6v/v+igekFcShJiaupe5ICozLwifNGPRS4NcN/22n8SrxSIo8xoV9HvKMmqT3Rv4X/vKSE72vADrKdyOjAITFSwvEBLH4bNOv0J9+lz5CHZid5YF8m/PimpCdoB6gvz4m3phzExZoXSLk//YYUk9KMSX3EA3uSPaiDf0uNUtZ5iqZVV2TuWs1YMCVjlsifjXDM2q80tAWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GAUFOk5V/7CN0QRJTvW9hml1q3XUWDb87qKtpjNXWg=;
 b=od+Q/Bb5JlY9zxtIieeyH1FLGvLMbbwjcynx3uhriVRyDjX6+oCIg4lhgxiY51X6cMqN5wf24I4BIi4kPGwMnGzwyMS9gZBWnGIDisbe12QHY2vd70gzndjSf0rzEKY1rfA2EGLzbZ6L8Fu017jq8Eg/4oxI3xsGh82v/qcyF65MWySCitCk1Yl63OKLKEmQoSDtuRu8AIVvKvE+5Gl1tPGe+HCD4CI4zCOe1qLyvbXNv26w/Xh11d9abXp2Pe940gJwaPwaH24E2sgzCuM8+Y0YKyLeIZHCPg7232vl2blvipPlARwauvwyI9u3/gcfyeahpqguWLpXf2edLB5EcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GAUFOk5V/7CN0QRJTvW9hml1q3XUWDb87qKtpjNXWg=;
 b=mzGIPKKN1F2C05bFa4VcdeNVIyXFa/3ov+R1zxSAH80ClBTnPtaQICEBO7PTyptAgTGXZSObnPw8f8VffxSDIleYebgRok/TTS8gFXpaFENyZfEMlboqIYFZneEEKQrbLMlo6QFY+uhj9wndX4Xixcu8/2o7+sIyxdc0wDPrCTk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB2358.namprd12.prod.outlook.com (2603:10b6:4:b3::34) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.16; Thu, 13 Aug 2020 09:08:48 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3283.015; Thu, 13 Aug 2020
 09:08:48 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amd/powerplay: optimize i2c bus access implementation
Date: Thu, 13 Aug 2020 17:08:18 +0800
Message-Id: <20200813090819.32115-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200813090819.32115-1-evan.quan@amd.com>
References: <20200813090819.32115-1-evan.quan@amd.com>
X-ClientProxiedBy: HK0PR01CA0062.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::26) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK0PR01CA0062.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend
 Transport; Thu, 13 Aug 2020 09:08:46 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8103d895-ea8f-426e-eea1-08d83f687d2e
X-MS-TrafficTypeDiagnostic: DM5PR12MB2358:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB23585050DD1760EAD22F207BE4430@DM5PR12MB2358.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:59;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4HmePa9UYabB7yky1Es+6hQS5mEVNOg3uhRhdsUiw2F5xHdwkv5VTIJbgPk4NNH5SK7Z3W0muXmI70gpZFi0PysKoFUxM9/vGYziwa0FT9nEJfHmDWO77sGderulqGlABq8w1WggHTxzu6vTXjtXJTiWqE/85i06v5hENVP3h1renSFtiCG487miqIsFnKAcakS4XFRIMSoiLHn1P5DODhqT+DEz/6yMPV31DijXzkeXUPsXC0rVjmNaUoQgHL4WbiYOPOmhoekkgDyFgNvnT4a1LVZmp6pL6ATVJRAyaeL7X+CLdjWm5kbtfCEQ1k/Y
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(5660300002)(66946007)(6916009)(4326008)(66476007)(66556008)(2616005)(16526019)(86362001)(2906002)(956004)(7696005)(6486002)(186003)(44832011)(52116002)(1076003)(83380400001)(8676002)(8936002)(316002)(478600001)(26005)(6666004)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: TecBLVLLmOOeEmEfT5RmeW3Dvgg1WsEYwhn4NSla3xGrdjo5zoKjungt6W7jrXWg8OlOeA8KnmXfqMIl4px/pRVmOkWbF8dsffMc9Vln4L/ODZkPG/E33yeUSuox8N7vmllvZDF+B+lw9o5DmgMtvNODKWJIlJj481z4NuOI+cg5pZFscGvEYXrxmZTqWVQSgbwa57rTI4+27dUqd9LkemY2OGwdI9rzp5ctdOBPMrbCy8lKDuoYqDtaL6fn8WYcjouffYDEMF2XbNqDLTPOtErDLH6JPhWR2LXgCTeduMcT3XO7Xguw1+WNBQ1FE++Z4dl6fWiS4KVLxGI15o/glpG/uQQl+odf0WS1u2oF9rI7IMsD8ZrAUjQLNAhW00h4AqL8id9Cic6lNUo7yJiL4NUYCq4L1YeiLCIgBCGAA57Y9v4nIq0BzAE/mVhKxcrlvgHFDnaB9//VaWdqifxrEQ+FIT4Cz4nT5xzkMA1u2UmgkA1NopE92/l0VtDpTp/8SGIQKAeLEjRtRuHwzCIcP6zmnHuy4m5pGCLJDwnA3wDu/uyVYf8VXPGqUdr0K+ksoAvCarlMdEmp6JiyvUxqzJzb7iP8cQTem6xj9d+vObFgz/IfKPYjZOGmi2QxMxDAn7Y81yUUYuqQitYnKwPs9w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8103d895-ea8f-426e-eea1-08d83f687d2e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 09:08:48.5319 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 68kroObItq2aSR8DXlo3mXy4+pAnXTwi3Ok6ByexLfS0mkV3XlOs4H95LotoLT6y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2358
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

The caller needs not care about the internal details how the powerplay
API implemented.

Change-Id: I942de0c9f78b2e2c0dfb7c67b82be2527c6825d3
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c    | 15 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h    |  3 +++
 drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c | 15 ++-------------
 3 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
index 2aa6f53fcae7..2198148319e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
@@ -1247,3 +1247,18 @@ int amdgpu_dpm_set_clockgating_by_smu(struct amdgpu_device *adev,
 
 	return ret;
 }
+
+int amdgpu_dpm_smu_i2c_bus_access(struct amdgpu_device *adev,
+				  bool acquire)
+{
+	void *pp_handle = adev->powerplay.pp_handle;
+	const struct amd_pm_funcs *pp_funcs =
+			adev->powerplay.pp_funcs;
+	int ret = -EOPNOTSUPP;
+
+	if (pp_funcs && pp_funcs->smu_i2c_bus_access)
+		ret = pp_funcs->smu_i2c_bus_access(pp_handle,
+						   acquire);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
index 672b73ad08c2..5a2344f839f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
@@ -545,4 +545,7 @@ int amdgpu_dpm_enable_mgpu_fan_boost(struct amdgpu_device *adev);
 int amdgpu_dpm_set_clockgating_by_smu(struct amdgpu_device *adev,
 				      uint32_t msg_id);
 
+int amdgpu_dpm_smu_i2c_bus_access(struct amdgpu_device *adev,
+				  bool acquire);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
index d55bf64770c4..7fb240c4990c 100644
--- a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
+++ b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
@@ -508,14 +508,9 @@ static bool smu_v11_0_i2c_bus_lock(struct i2c_adapter *control)
 	struct amdgpu_device *adev = to_amdgpu_device(control);
 
 	/* Send  PPSMC_MSG_RequestI2CBus */
-	if (!adev->powerplay.pp_funcs->smu_i2c_bus_access)
-		goto Fail;
-
-
-	if (!adev->powerplay.pp_funcs->smu_i2c_bus_access(adev->powerplay.pp_handle, true))
+	if (!amdgpu_dpm_smu_i2c_bus_access(adev, true))
 		return true;
 
-Fail:
 	return false;
 }
 
@@ -523,16 +518,10 @@ static bool smu_v11_0_i2c_bus_unlock(struct i2c_adapter *control)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
 
-	/* Send  PPSMC_MSG_RequestI2CBus */
-	if (!adev->powerplay.pp_funcs->smu_i2c_bus_access)
-		goto Fail;
-
 	/* Send  PPSMC_MSG_ReleaseI2CBus */
-	if (!adev->powerplay.pp_funcs->smu_i2c_bus_access(adev->powerplay.pp_handle,
-							     false))
+	if (!amdgpu_dpm_smu_i2c_bus_access(adev, false))
 		return true;
 
-Fail:
 	return false;
 }
 
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
