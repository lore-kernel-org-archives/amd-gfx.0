Return-Path: <SRS0=yJoC=B3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B6EC433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 08:30:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 968792072D
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 08:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AwR2n9q8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 968792072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F0696E508;
	Mon, 17 Aug 2020 08:30:18 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 010226E508
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2020 08:30:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LS4rFx4ojJxjkNUHwUx8axLthsAlMUrJEW5BjGIiAngJh/+s/Bb8FG0d5tLIK9H3wLkgXd2+InIuaQ9o1u4b96csFxjznQyGptmPaGj2gorgijCNmpG8IGFknk/HqWOIfg0YJH3A6HmRHVxgpzyM172/sa51no0/OnoeVrUEwp2rCcumJnlkl98Iu+s/TaBbT7lUY4Nf4yyRJKfFPilAW2mAllR0ruW8Pm/mlJjth7JnFp5HQZnALCB1VONBKNkdw38w1F73VS9HRzcNmte7J7SvHIPUPyJC+B0viYPgIO5CcXQKrB4r1mT94Y3lZEE8G0IqE5rZtpOy+efnvOoytQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBD5PBV/+hET8pCxQbdCuEfeKM+s9WQJbfCFIUTPHdo=;
 b=Bui5ZXyFIgK8RJOLm80eYSR1c7rey3wyzLYnIV0ubVZiiJszqel/Wp1+5iBIt+ePDkDn32pQ4RAmMUBKhKQPuqHH767/Rmtsdq+ls8QsnmI8G2oaWyYypLy3Z1b9Y5mHYFniEl6k0YQD2dW93G3kautC36OhXgd5gQs0nroIrfLWJ3wZOciJ1DekYWJG6n2D2XqhNgE76xNwyWgGg7Pip7k+IuXVbB6Do8bSntjLZ/zjFnH11MeLflWBYNfQz+z5s4lQA1i5Im5aUpdMmg/aL7lceMe9fkeZF+63knG6aST1LcZfo9dogCRtQAKRypIsQu+DWyoHGn8d66vycYWCjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBD5PBV/+hET8pCxQbdCuEfeKM+s9WQJbfCFIUTPHdo=;
 b=AwR2n9q8FArIf6NykP2997tXx3i/CD0LD3202DIfbEkswHWcdggERS2wbbgoWMb0DivytgzKR/2NDmgO5TudUqelduR2U3Wb1F3Nn3r6g/Z5y0syPwRM4Cw1+OfhMpgBTqUJ0knuxMM5qc9hzwfDoVq7lTZwuE6MzOw/B104a/Q=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3177.namprd12.prod.outlook.com (2603:10b6:5:187::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.20; Mon, 17 Aug 2020 08:30:15 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3283.026; Mon, 17 Aug 2020
 08:30:15 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/5] drm/amd/pm: add Sienna Cichlid deep sleep control
 interface
Date: Mon, 17 Aug 2020 16:29:41 +0800
Message-Id: <20200817082942.25733-4-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817082942.25733-1-evan.quan@amd.com>
References: <20200817082942.25733-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR04CA0047.apcprd04.prod.outlook.com
 (2603:1096:202:14::15) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR04CA0047.apcprd04.prod.outlook.com (2603:1096:202:14::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.16 via Frontend Transport; Mon, 17 Aug 2020 08:30:13 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5e3b6d8b-e19a-44ee-19c4-08d84287c402
X-MS-TrafficTypeDiagnostic: DM6PR12MB3177:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3177FFEB50C40B1F8EF925D3E45F0@DM6PR12MB3177.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:245;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dfoieJK8STO7+MschV3NwMNrsZPd47Z4glxts6nY5GGAuUpWUEqxnU9KOAPf8xA3OMf7esTDtDWiy0v+YdTiIxgiqlIIgbs/Ntyw9x1wR5/lZ2klxM9ISH1NbDZDiQ8a2pZvNrXZSGC5PouHDLM7MdrSVVUSeeflI1QauO9p+qZxD7vPJ6s+3MeTjvuZwr5ZYAl/EziIE1SY9raa+ediN+V8ZZ00yRQDa7gV26zksI4U7Szu4z+7F5B+DSq1/M/aRNaofNqUrsWtFDU2hXrdRmElwin0bd0uajNJsjhXgr31Y3daVNLTpTrQxm3NIrhj0VdWoWWhAa9BYSMk7Fetwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(66476007)(86362001)(66556008)(316002)(5660300002)(44832011)(4326008)(2906002)(36756003)(6666004)(8936002)(6486002)(8676002)(26005)(956004)(2616005)(6916009)(7696005)(52116002)(478600001)(186003)(16526019)(66946007)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: YHwiJ75nlCzqUxEMGu9U+b8o+kuAVf0zDztlCAalR9nZhwG2HTUjjPt1UxsID/FwVwxxhTuRfMZ7h8yVFWxOfOY/YBevLj4UiEYOauKk+I33VhXuoG//+UYzOb5Fr5XwdvvGRgv92UCUkwQdtHZlvNAUUuXF11so5nxhdFM0bROmIwXc9p1ms/2DckabIGEj78lFCDWQ2VbhMKXi7tiJ6LfkejfH8DB85g/lhruoEmN86yZFQK3vn3LuYn0rCmCDJGn3mUeMDLfDg1kz8MoSi8bjMsA5Jn7sf5mHYKoi5YminwZoPfKWwqVVsRtI72D3G3SR4m5i0A9TTu8MUkcnmtACYIzgG74KkdHdzElTdVu04CEOIUh4nLFfL9Ugt9GfL3hX7uEWuQMQav8+B4xvv+n1637KKyjdvd0aEypVh0gsgG3r1mEx8bZr8aKhfmroMcXYy06v8xR/cgmn3nibE4Y9VTNAZJXyeAzM429KgZnjd7Z7vZfJaq9Ocs0V05wdiua30kjx1xk2LjiUL4FXoUQXiiTgk3WgEaCZ2oQOf0ttSD3LfM4ly4LsNhjtnwhxb85atv994wpTevKgNd3oNasbUN9y1trCyv9XmCgN5tmmA5eTSeOurQfrF46GFE+eWJKgHmQE3CFVkP0uShGnKQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e3b6d8b-e19a-44ee-19c4-08d84287c402
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 08:30:15.3712 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +8OMPJcf90t4bS6M8SDvmE1FV747AEYcv+D+P5tZWRMSm6AkYArQrCuvZV4lFMO5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3177
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

This is needed for UMD pstate switch.

Change-Id: I97ee3af60f4a3e4c2f575ce8c8e1a2866ed37f02
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 45b9defebd07..b2ad6a5f6728 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -2718,6 +2718,39 @@ static int sienna_cichlid_enable_mgpu_fan_boost(struct smu_context *smu)
 					       NULL);
 }
 
+static int sienna_cichlid_deep_sleep_control(struct smu_context *smu,
+					     bool enablement)
+{
+	struct amdgpu_device *adev = smu->adev;
+	int ret = 0;
+
+	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_GFXCLK_BIT)) {
+		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_GFXCLK_BIT, enablement);
+		if (ret) {
+			dev_err(adev->dev, "Failed to %s GFXCLK DS!\n", enablement ? "enable" : "disable");
+			return ret;
+		}
+	}
+
+	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_SOCCLK_BIT)) {
+		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_SOCCLK_BIT, enablement);
+		if (ret) {
+			dev_err(adev->dev, "Failed to %s SOCCLK DS!\n", enablement ? "enable" : "disable");
+			return ret;
+		}
+	}
+
+	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_LCLK_BIT)) {
+		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_LCLK_BIT, enablement);
+		if (ret) {
+			dev_err(adev->dev, "Failed to %s LCLK DS!\n", enablement ? "enable" : "disable");
+			return ret;
+		}
+	}
+
+	return ret;
+}
+
 static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.get_allowed_feature_mask = sienna_cichlid_get_allowed_feature_mask,
 	.set_default_dpm_table = sienna_cichlid_set_default_dpm_table,
@@ -2797,6 +2830,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.get_gpu_metrics = sienna_cichlid_get_gpu_metrics,
 	.enable_mgpu_fan_boost = sienna_cichlid_enable_mgpu_fan_boost,
 	.gfx_ulv_control = smu_v11_0_gfx_ulv_control,
+	.deep_sleep_control = sienna_cichlid_deep_sleep_control,
 };
 
 void sienna_cichlid_set_ppt_funcs(struct smu_context *smu)
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
