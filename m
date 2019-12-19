Return-Path: <SRS0=793y=2J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC713C43603
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 06:45:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99E332146E
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 06:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RkTGKwkZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E332146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 251EF89CC1;
	Thu, 19 Dec 2019 06:45:44 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDE8B89CC1
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2019 06:45:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0KLXfU55uhCuSqXum8h8CXKTSt/MXVuggV9VrNQ1gXJpbt4XeTQX0eFHdI4OIglrih+FFZoeaI+vtq5SFaRvN0xk/XU3XJ7z8O+++j7VTtWndoOujGm+fPUz0T300yXhuw+nVYAKCKU0w3/IKuhML/7aVJmn3hxn5Y/nS9a1ZLeMON1HCbM61DYgHwJoJNTsCIac7A/XLTE04Alaw2swXz6bLkIMsBflMQUdNyiGiI5mJclgyCXUzyfG2RG9cSMVPnoDJ+OXo2GDZKhMyYJVbiY9abq7DUN0glIt2mc8X+Ii9qwLZvirqbBQ9/ihz+uDi+wwDhIQ+OYtHftVEpkZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zoNBN3DUwtAOh0zvX9EzRIM1IriE1W1Nbh+wsKXdeEc=;
 b=k5AEmCuQmZhbd7hU1acKhCbyCAMnxYYawx9evP4s8pXS6CXMn4OhCrDHnq/7KLdJzaDfyoPnW+LT06TiSUmt8SFNhgLPdL/meFg/TS+jW/oEksbtdMOtpG9aU4/XBp2HrLMTtkjgPq1B27oPQMbvU5XOIbo0DxT3yUkJILEJqU8cizukAGlZYOhqsh3zMFaWCaMgoDUqxHatmNqIhI6ImQbwW53NVXlrR4w8Y+YjtILoKv6A74Hq5hp4/bwBBcB6FpMpfp/Vd2u13SGmmNcbJlJbWiJWHwQmPtZdMrhS1EFbT5To5+MC3/4xelBk5UCOPwYH54L17imY0/Bf+7n0tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zoNBN3DUwtAOh0zvX9EzRIM1IriE1W1Nbh+wsKXdeEc=;
 b=RkTGKwkZWdxFNDGPo62gNXG1K4Dnk2PK6aS/XTnxVV8mU7BYm8VEtzeJ7OyLYeo2u2tJGr8eUs7+RPrlbnh02bNCgVu624alj7I6M95TC771iD/BmIYk76SPuoi5+9/++MQ2a03hpy2ASY762ploS/zIOkHWfx7y9uRllpr3kkM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Prike.Liang@amd.com; 
Received: from BYAPR12MB3525.namprd12.prod.outlook.com (20.179.94.90) by
 BYAPR12MB3432.namprd12.prod.outlook.com (20.178.196.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Thu, 19 Dec 2019 06:45:41 +0000
Received: from BYAPR12MB3525.namprd12.prod.outlook.com
 ([fe80::c930:bfdb:2507:b97f]) by BYAPR12MB3525.namprd12.prod.outlook.com
 ([fe80::c930:bfdb:2507:b97f%3]) with mapi id 15.20.2559.012; Thu, 19 Dec 2019
 06:45:40 +0000
From: Prike Liang <Prike.Liang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: suppress nonsupport profile mode overrun
 message
Date: Thu, 19 Dec 2019 14:45:30 +0800
Message-Id: <1576737930-20998-1-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: HK2PR02CA0145.apcprd02.prod.outlook.com
 (2603:1096:202:16::29) To BYAPR12MB3525.namprd12.prod.outlook.com
 (2603:10b6:a03:13b::26)
MIME-Version: 1.0
Received: from prike.amd.com (180.167.199.189) by
 HK2PR02CA0145.apcprd02.prod.outlook.com (2603:1096:202:16::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Thu, 19 Dec 2019 06:45:38 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9ce53922-decc-4e1a-d757-08d7844f0fed
X-MS-TrafficTypeDiagnostic: BYAPR12MB3432:|BYAPR12MB3432:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3432993022B6899E54BDD343FB520@BYAPR12MB3432.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:28;
X-Forefront-PRVS: 0256C18696
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(39860400002)(366004)(346002)(136003)(199004)(189003)(6666004)(36756003)(6916009)(66476007)(2616005)(86362001)(956004)(81156014)(8936002)(16526019)(186003)(66556008)(6486002)(8676002)(316002)(4326008)(7696005)(52116002)(5660300002)(66946007)(81166006)(478600001)(26005)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3432;
 H:BYAPR12MB3525.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZnUrNj9E5w+XJvB7TNEfCHk/HJ1d5xbBPPVAdcpSagzTlmqv2s7llYQxeSseEUD87dfeoC3W1IgfbKgJMCV1hxUKNKzifnQrwK2j2RIYucvgb1tecqRapZ3n5RNlnbyrKJUSvt1brOJsvcZT+sTCQ/9fXk3QPMe9t0tUwNNDLgpwBvYrJKNlxecryCTUyemp32CkSKFyJT0xEiG3pNrj01xueOXgDOpPfylILptV6+C49FtDxEEMANqdCoYTcW4j6pxoUwCWOq7GEAHOLGrGjxhFfso5E+aHokSAXynu3ka74YCyTEzxdC63MWfsCVf02Z+zatYZ1xDVU3dApEyyT8NhEBIkGhreywDT2bYpfdeotYYKxiRy4l5tk6q57qzAF7wTzqSFn0lLsuFMy7kFD47abBz0Fo6eNXPalp1x6mfn+V7zybOtdJe4O7blgDtr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce53922-decc-4e1a-d757-08d7844f0fed
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2019 06:45:40.5750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +D63xccuHai0od6bvz9zc9NLWCmNmm8nD0cXVZYH/5KBLntxd4vRMc+1GxNnaem2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3432
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
Cc: Prike Liang <Prike.Liang@amd.com>, Evan.quan@amd.com, ray.huang@amd.com,
 Yuxian.Dai@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SMU12 not support WORKLOAD_DEFAULT_BIT and WORKLOAD_PPLIB_POWER_SAVING_BIT.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index 784903a3..f9a1817 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -550,14 +550,18 @@ static int renoir_set_power_profile_mode(struct smu_context *smu, long *input, u
 	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
 	workload_type = smu_workload_get_type(smu, smu->power_profile_mode);
 	if (workload_type < 0) {
-		pr_err("Unsupported power profile mode %d on RENOIR\n",smu->power_profile_mode);
+		/*
+		 * TODO: If some case need switch to powersave/default power mode
+		 * then can consider enter WORKLOAD_COMPUTE/WORKLOAD_CUSTOM for power saving.
+		 */
+		pr_err_once("Unsupported power profile mode %d on RENOIR\n",smu->power_profile_mode);
 		return -EINVAL;
 	}
 
 	ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
 				    1 << workload_type);
 	if (ret) {
-		pr_err("Fail to set workload type %d\n", workload_type);
+		pr_err_once("Fail to set workload type %d\n", workload_type);
 		return ret;
 	}
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
