Return-Path: <SRS0=gI7v=7R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3948EC433E2
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 04:47:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F65F2072E
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 04:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uBjBR7bw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F65F2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0A726E175;
	Thu,  4 Jun 2020 04:47:08 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F1D16E175
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2020 04:47:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ASPIVco2xELPSaElr/JE0yZmlE+O9Eda6tnVZssPrCkQ2yqh0JsLNUo62x4WOAvKJJUpDkQyjbt4eFP40ApbaTPccWMdt8lRpKH6yWzIu0VdsofnxbFXRR9lXmAi4p5L4U1hqz9w6Nzfh0UB7PtoQ66gl1beVZjOiBxB4l3pzldY0g/P86943wmvTiYNSUP+HUwjTMyWf/69OrzimL7FeP1IAXhcgejSRNN7gYoaLPoq+kgfgiOqYOe1ypR5YWTUxy+cNpy+cZW1w52Y9PpFxmIzrDtPAG7qd+w4U1xwDyf+ZziFRpNNIRUyChB+X16S0rz6a7i37A+oN5dJMN7GYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53IdNnRVaP8ePeDUs3YXhFaNdHZBWhftVRuiGyRe+SM=;
 b=IeFd23mZeCoUIBfA9Cwo8uWkHhLh1JujG0n2HOaWU0YtcNHGQ23jLAYqnRySUxrLeO4NECoT65X8yiN5mrLNmxxV+Kd7cWt12CkGqyYg1E6qQj74NpFgh3IkNMWge8YZ2Hg3TY7nr53QPGPCYjvTwm9qsXhcezKBzgX8Rqk3rIxtcDS7za6ISUZvkf19AB/xn7VDylyr6Cdz3SzJaBimMBfxR95eVeOEK7bkkL7I8/2HH7RMXbCULTYkXioE6AZ8sP7EXN5PND3fXYVmOeD+lil1kByxRrJvTflWMHhGT5cinCUkoR4SvmljiExukvLdXch/0p24anj/vTsvVdQkQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53IdNnRVaP8ePeDUs3YXhFaNdHZBWhftVRuiGyRe+SM=;
 b=uBjBR7bwkxDRIeCxjc6gfpAlSCHigT+eK1lqBWTRt4LXah6I9YzRAeSLjxIty773D+S7hgLVXyy2w+2neE19kL9zDSLudyOaQlvhwHirQi/6opVExSHl1WhU77NPHyDM85GBYhbN3TRI8rB6/PEiwelmT14S0oEdVlq0P8BrfH0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3002.namprd12.prod.outlook.com (2603:10b6:5:117::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18; Thu, 4 Jun 2020 04:47:07 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3045.022; Thu, 4 Jun 2020
 04:47:07 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/16] drm/amd/powerplay: postpone operations not must for hw
 setup to late_init
Date: Thu,  4 Jun 2020 12:46:11 +0800
Message-Id: <20200604044619.18658-8-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200604044619.18658-1-evan.quan@amd.com>
References: <20200604044619.18658-1-evan.quan@amd.com>
X-ClientProxiedBy: HK0PR01CA0071.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::35) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK0PR01CA0071.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Thu, 4 Jun 2020 04:47:05 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 11a64bdc-f809-404c-5769-08d80842557a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3002:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3002E103C8B32DF4D0461D52E4890@DM6PR12MB3002.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 04244E0DC5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OEW6Epn6kqhzqKnuaCWEpy9uwziOlb1FvxOsEKQKIlA40KR5dImCeKfk0LhkHwsD6YcT/tmnx/Rcu1WD2k6pgO00013xadaNxsH6s7sCoqsfr052l+ZaJCyz3IPTC8pyXL1fUOLPe8KBdj5LQh0s10Cpyj0Xymj3AB+NatcXkyIK3K3fnpb+dMfsapmhxuOZ+43BYs6jFslYeNLDeMtkqt1sI2mRhTJo0ig2j0jy+6o341XG7noJHSvB4Z0X9WlbmaZ7B9wthjPoIlV4DsW5bm9FXa+nHS016Z2RBPLDhBGgDmBTHLhNB0q/zMRgDsN4Nm1AlT6pphQmbR/XKP2CKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(7696005)(1076003)(52116002)(36756003)(2616005)(26005)(316002)(16526019)(83380400001)(6666004)(6486002)(86362001)(5660300002)(186003)(956004)(6916009)(4326008)(66946007)(2906002)(44832011)(8936002)(66476007)(66556008)(478600001)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: udeZdlSKJvsAlf5Ih9bWAqIbL13XKk9c0JyzdL2vzpnH5VLz9shuoZS63KbXJhP1EWI2O0wNG8QRYH23upVlH4xkmPArYNeJ8u1iWfAQsYg7n3yRBfUSBF2ch3Cv0I7+k10tMLN5SoiQsHV0oUOd1QWrBORkIPgdY8c83Vt7rAgSmjOXM72Gqg1k6/rvA73IxvpAkgffthwVI/UK3AcIuTNLsPg+8EgLn36wnidVF6BbaVEflDsz6GqPUKYJJWSGs1Gee4u84if9rEw8Pl/BFQywZZTbczOJ9WGhuKBHqTfkrnav3ojRQtbXxHsNKETLxyqR11CGILy9F4zc8YXUYtzTYpqfLUyFrnWARl8BeLZ0avRZKMugszaU16UdMqpNiyTdaXBtWSptMSGFTFvHnbVLp/ei1yckGsGagJnOpRVDEVPV4qqtwqGh4ytpoO3UrlFNPu8YYvVIc+scLoqcJj/CbIwFlmpACi+AZEb2mJWaRHNG2iY8oQ3ylcSlo/R7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a64bdc-f809-404c-5769-08d80842557a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2020 04:47:06.9489 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OsfOUTu4R3bNmAKTxWs/wuIpfRtCJlC9Bd9cGTwHqNPUFc9a8IwXTgtMQyDOelKe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3002
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

So that we do not need to perform those unnecessary operations again on
resume.

Change-Id: I90f8a8d68762b5f88d7477934128a17bf67e3341
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 57 +++++++++++-----------
 1 file changed, 28 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index cd7a3d3efa23..78fb2b42fc93 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -769,10 +769,36 @@ static int smu_late_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct smu_context *smu = &adev->smu;
+	int ret = 0;
 
 	if (!smu->pm_enabled)
 		return 0;
 
+	ret = smu_set_default_od_settings(smu);
+	if (ret)
+		return ret;
+
+	/*
+	 * Set initialized values (get from vbios) to dpm tables context such as
+	 * gfxclk, memclk, dcefclk, and etc. And enable the DPM feature for each
+	 * type of clks.
+	 */
+	ret = smu_populate_smc_tables(smu);
+	if (ret)
+		return ret;
+
+	ret = smu_init_max_sustainable_clocks(smu);
+	if (ret)
+		return ret;
+
+	ret = smu_populate_umd_state_clk(smu);
+	if (ret)
+		return ret;
+
+	ret = smu_get_power_limit(smu, &smu->default_power_limit, false, false);
+	if (ret)
+		return ret;
+
 	smu_get_unique_id(smu);
 
 	smu_handle_task(&adev->smu,
@@ -1178,39 +1204,10 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	/*
-	 * Set initialized values (get from vbios) to dpm tables context such as
-	 * gfxclk, memclk, dcefclk, and etc. And enable the DPM feature for each
-	 * type of clks.
-	 */
-	if (initialize) {
-		ret = smu_populate_smc_tables(smu);
-		if (ret)
-			return ret;
-
-		ret = smu_init_max_sustainable_clocks(smu);
-		if (ret)
-			return ret;
-	}
-
 	ret = smu_override_pcie_parameters(smu);
 	if (ret)
 		return ret;
 
-	ret = smu_set_default_od_settings(smu);
-	if (ret)
-		return ret;
-
-	if (initialize) {
-		ret = smu_populate_umd_state_clk(smu);
-		if (ret)
-			return ret;
-
-		ret = smu_get_power_limit(smu, &smu->default_power_limit, false, false);
-		if (ret)
-			return ret;
-	}
-
 	/*
 	 * Set PMSTATUSLOG table bo address with SetToolsDramAddr MSG for tools.
 	 */
@@ -1428,6 +1425,8 @@ int smu_reset(struct smu_context *smu)
 	if (ret)
 		return ret;
 
+	ret = smu_late_init(adev);
+
 	return ret;
 }
 
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
