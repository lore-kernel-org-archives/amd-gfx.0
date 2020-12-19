Return-Path: <SRS0=C/bZ=FX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9429C4361B
	for <amd-gfx@archiver.kernel.org>; Sat, 19 Dec 2020 00:49:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A9292343F
	for <amd-gfx@archiver.kernel.org>; Sat, 19 Dec 2020 00:49:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A9292343F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42C1989C82;
	Sat, 19 Dec 2020 00:49:08 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B082889C6A
 for <amd-gfx@lists.freedesktop.org>; Sat, 19 Dec 2020 00:49:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKBYDIXrnn4SyNrxP5+01dsTtPXWrmAO31XcvsyjlFhWCj2NhVKN8kPKiRsVL+FeaLNgbhQC8EcVVDufms/Le8bSQQ2r8Nadf2dIULDIKaoUJBBhgZdxWqFnpqEb+G0zAT8AJmPEEVdza1U6ZbuZmcnBLvRYWyP3Ni0t/sbaMN0Mfw4/jFXGj8418pjPbCPCEQTf3jTpSqnNQr74j2bi/IjaZjKfW7ebWde1NeD97TQbIun+oy1R6nuayo/oeNYPQbe1gcbWUjiW+8QDQouwPgiFJyNGoVqoRUdhZDNq1H8kzx1Eek8TsNEKGKCOieY+4RFLyNnVaEsmr9JJtX7d4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEOssj22TV0O/jt1ja6BWdDosuYPcpqpRWggQSsgf6A=;
 b=IoeC9XGbx9tynwFrBjgP6+JrWVmuQoYAzGNZLIBie1KyrVuj/+xgLWJPPKs//buK1+fWNvqS0V1q3WvhdMQZtULQObtmFGhSmqg2AXpPe5sApppd0ZUWnVQZYE7dp/WtDBavcjNgG7s+GdcKajhOPsxb9AlJR16XYpMEO1pRGYlyTdvwuVysVte6OkQwSu0FqKEp84vCg+ksel4GOz79rJnuCoqPyZNl93P7nqc/gJqB32Tqz8JDPsFVSW/9CO+c14gwBwGUJ3XZQkWy1Jxr+YBOvCOH7kPp3aomrfxBJLIB92bk3wodMVyz3Fo2lp1FCP0Vy04Gx3hOIW9WZAjoFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEOssj22TV0O/jt1ja6BWdDosuYPcpqpRWggQSsgf6A=;
 b=D3cgPU4NWbYpsiowpeNH4ewe/G5K1p+0N99mOBv+LgVfeEyo1y5uQefxJmUrukB4whNgOgDMof7CrZQBSRSKV1G6p8wOcDtFrFaXMgHuqgEQ1cqjiN6pghTq+9xX4GR5iVWvzxLBeeF6qiqW0LknSAwN1OpvMk+KSGjl1AJbXP8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2959.namprd12.prod.outlook.com (2603:10b6:208:ae::29)
 by MN2PR12MB3279.namprd12.prod.outlook.com (2603:10b6:208:105::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.15; Sat, 19 Dec
 2020 00:49:05 +0000
Received: from MN2PR12MB2959.namprd12.prod.outlook.com
 ([fe80::dd1e:ce4b:cd7e:2804]) by MN2PR12MB2959.namprd12.prod.outlook.com
 ([fe80::dd1e:ce4b:cd7e:2804%7]) with mapi id 15.20.3654.020; Sat, 19 Dec 2020
 00:49:04 +0000
From: Darren Powell <darren.powell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/8] amdgpu/pm: Powerplay API for smu ,
 added get_performance_level
Date: Fri, 18 Dec 2020 19:48:24 -0500
Message-Id: <20201219004831.13527-2-darren.powell@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201219004831.13527-1-darren.powell@amd.com>
References: <20201219004831.13527-1-darren.powell@amd.com>
X-Originating-IP: [142.126.168.115]
X-ClientProxiedBy: YT1PR01CA0114.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::23) To MN2PR12MB2959.namprd12.prod.outlook.com
 (2603:10b6:208:ae::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (142.126.168.115) by
 YT1PR01CA0114.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.28 via Frontend Transport; Sat, 19 Dec 2020 00:49:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b3229867-0839-4e47-f92c-08d8a3b7e2a4
X-MS-TrafficTypeDiagnostic: MN2PR12MB3279:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB327931969FBCC5221878CC31F0C20@MN2PR12MB3279.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j4bUb9AS3ohauXFRRS+FSKjDiYWN6F4Mip5ojYhVcIXUUZbAHt3yZXNtfyW7LWbifIfqpZkzSo8FcG7q/CYLkra3hgmZKMTTYREj/fJC8b3+0vj64euCturcORgFVVhnxiEQRjMoEU79/SSTfb1PrqrJMiKN8zJVklDKzRYRrAeTv394EOF+spjvfxKpp/swT1SxOhgLH4gqZk/YrHjB55v0d3bfzXUua9xmaD3NCoFs2tTcGF4+iTZhw7ajR4F9jecM8hjpfDRmuqMBhb7Hw7m7QkDXaSI5Ey0eszTAcOn46qwkRmGzmdnklekrATTaUo1mxj2Xma+ewi6DAGhtuqdKI8GzcaVTatU6DyhCCuuMh6bRTk7f6fn6bVNOJ8Mz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2959.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(956004)(2616005)(44832011)(26005)(66476007)(66946007)(6506007)(6666004)(86362001)(66556008)(5660300002)(69590400008)(36756003)(1076003)(83380400001)(186003)(316002)(16526019)(52116002)(6916009)(2906002)(4326008)(8936002)(6512007)(8676002)(6486002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?+SgT4F5zb72od4SwnPnDcPncXggBRTA9lA0fmupi6GrrmpntvuSG7PjtdaMp?=
 =?us-ascii?Q?gd9avt+lKeoGQGxJty8x9V0nXPfDll0WmckgWliFZOmyeuvB5n483GDTMbIs?=
 =?us-ascii?Q?EFafs6uEe5mg+L8iqFeUan6IryAjul0ydCR6mtYiZh0/C4KRcBOvG0QpSInD?=
 =?us-ascii?Q?spvO6NRMdlO4r2YcznKvYU2hkctGH9qyAMRjKinIN31T/o5qF9YzA6jdnI/j?=
 =?us-ascii?Q?f2xdvQ1uSGYFlrZNy2HOq5hA4bjmNAQu8OlWzpMR2lRDeqNU19IriM1XXlCc?=
 =?us-ascii?Q?yfeacbCP81OAdwlowSQaG23Y805qek0gj0ixtIaB5J4f3Yz76dZfzEZzPnO6?=
 =?us-ascii?Q?L+myxFqQW2vPMYLu3ayAvRWG4tKN6OhW0Pp0gHHpsHcb/zd+QQ3FN0OveeKQ?=
 =?us-ascii?Q?TnrtDCsKm0Pg424pURjY85IIWIxaS3sCDS3anwLZu268h3FunnNlS8LR6PB/?=
 =?us-ascii?Q?oLkJIZppQsADmHtFeh2AZ+MaGkVUBg068V+7BBrG1bNvfsRteA+ly8GneymF?=
 =?us-ascii?Q?7F1dRjIKwaxj38mDnmaspNMy82G5F8PsioNzWhWgpOXm8Y1lPIf89FDRtRQL?=
 =?us-ascii?Q?XnzMsHy4/GVuFNs+vdKLkUXnkxWzvzVkclWS+/fJOHs4M07wcL3yuzLpv+Kh?=
 =?us-ascii?Q?tEPVhFtGGwsHogSqGe/bYuYg2q/r7yPWCGbvSQaeLr/XWjh6KcIRpppOqCNq?=
 =?us-ascii?Q?UAfCG3BPAezhyt2yxivr4qWM0Yk9uDuMmlbZ0cyqlWzutWVG9q9Shtq0LuRN?=
 =?us-ascii?Q?UVR00E7X87kco3GxVKQskEltcOpwmjsIeCrHWZhUpqfvLayxZWy5uNm0kYPd?=
 =?us-ascii?Q?QLmDbtlggWAOqxgPYXtE3HUzvVIo467dAVPog9289lU4nwuVvtgls4poeH1Y?=
 =?us-ascii?Q?gr50gRy0lIj1RnubXK5HPnprpHc/iD2IxGt5WZjtmybRXPSpnloW7jVv2fFX?=
 =?us-ascii?Q?ApvBdszaY+qudVnRV6R5DQxG05lNWRbxn3HmDz3qf9ZCBiaxcq+my5x1qsF/?=
 =?us-ascii?Q?FrY+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2959.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2020 00:49:04.9010 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: b3229867-0839-4e47-f92c-08d8a3b7e2a4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MK/sciW6RSBNDidolL3P8eDSHgOHVa9oe8xBCc4Ef5miX0ZRSDethF3DQ79Mw7TqthClgK7u8cLAsORQXmKeww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3279
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
Cc: Darren Powell <darren.powell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Modified Functions
  smu_get_performance_level() - modifed arg0 to match Powerplay API get_performance_level

Other Changes
  added a new structure swsmu_dpm_funcs to hold smu functions for Powerplay API
  removed special smu handling from amdgpu_get_power_dpm_force_performance_level

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c        |  4 +---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 12 +++++++++++-
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 7b6ef05a1d35..0008bbe971d6 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -280,9 +280,7 @@ static ssize_t amdgpu_get_power_dpm_force_performance_level(struct device *dev,
 		return ret;
 	}
 
-	if (is_support_sw_smu(adev))
-		level = smu_get_performance_level(&adev->smu);
-	else if (adev->powerplay.pp_funcs->get_performance_level)
+	if (adev->powerplay.pp_funcs->get_performance_level)
 		level = amdgpu_dpm_get_performance_level(adev);
 	else
 		level = adev->pm.dpm.forced_level;
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 89be49a43500..10914f3438ac 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -743,7 +743,7 @@ int smu_get_dpm_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
 			   uint32_t *min, uint32_t *max);
 int smu_set_soft_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
 			    uint32_t min, uint32_t max);
-enum amd_dpm_forced_level smu_get_performance_level(struct smu_context *smu);
+enum amd_dpm_forced_level smu_get_performance_level(void *handle);
 int smu_force_performance_level(struct smu_context *smu, enum amd_dpm_forced_level level);
 int smu_set_display_count(struct smu_context *smu, uint32_t count);
 int smu_set_ac_dc(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index cf999b7a2164..36d18668ec99 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -46,6 +46,8 @@
 #undef pr_info
 #undef pr_debug
 
+static const struct amd_pm_funcs swsmu_dpm_funcs;
+
 size_t smu_sys_get_pp_feature_mask(struct smu_context *smu, char *buf)
 {
 	size_t size = 0;
@@ -428,6 +430,9 @@ static int smu_early_init(void *handle)
 	smu->smu_baco.state = SMU_BACO_STATE_EXIT;
 	smu->smu_baco.platform_support = false;
 
+	adev->powerplay.pp_handle = smu;
+	adev->powerplay.pp_funcs = &swsmu_dpm_funcs;
+
 	return smu_set_funcs(adev);
 }
 
@@ -1569,8 +1574,9 @@ int smu_switch_power_profile(struct smu_context *smu,
 	return 0;
 }
 
-enum amd_dpm_forced_level smu_get_performance_level(struct smu_context *smu)
+enum amd_dpm_forced_level smu_get_performance_level(void *handle)
 {
+	struct smu_context *smu = handle;
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
 	enum amd_dpm_forced_level level;
 
@@ -2549,3 +2555,7 @@ int smu_gfx_state_change_set(struct smu_context *smu, uint32_t state)
 
 	return ret;
 }
+
+static const struct amd_pm_funcs swsmu_dpm_funcs = {
+	.get_performance_level = smu_get_performance_level,
+};
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
