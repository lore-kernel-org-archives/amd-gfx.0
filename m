Return-Path: <SRS0=tf5m=GQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98960C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 03:28:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3740122EBE
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 03:28:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3740122EBE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6224089C56;
	Wed, 13 Jan 2021 03:28:12 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69FEA89B22
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 03:28:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBmecjJ3TYWOgTLcHtSPqzRZzD39lznZKYglRFamIyYvQ5VL9GGp+o/JmQaYivo7epjsdWB1IyAQvEn+/oivZYgTWTOyAN0k2jZ+tZSWQF59CbwQlGeocVz4ASHTHM41amjU2OJKP6avE2MihjmZbx737IYHF5jit+w06BzXpHw0IiQt58L8f7jKE6/9eTtShNkGeFA4HnPzpISxjArddOqiFfklwIaqgYr9Oc36hzIsIu/AdCQj6J+u8dfXLS01RMm5xwEIfbMp5JsskZ/rK9yesjTwhIMK2tRz69bvPDp0ycj2p9ifjcKi2sMoBjFCWiEkgx/sL3ztbOH9Ahqe1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8eCSOZLmjE4METjun+wGpHLKppvr/N/4ACcqThvQFo=;
 b=muN3pfYUyqMJfSGNkq/HYz+DHJvFyCnC/v3i0/D81ClDFENEYoldNsV7+zKOtlmIp2XtVyIBchUf8xC2F0xjzkz8O/foDj7Z+kmzAG0FTqBvhMQD3ErkC1Auo1sgQtaRDWHsLGEGPh4aTjP3Ad5yhq9cimBECzNQQJirK+N/Y2rESgirWAtiSG7HmGLpR4GMtBGL6KmHGYL7rEl+Cqb6dWK1XXeIefGJoa2Enq/CMUBfD8XlJKOFq+/hDsPeVasuY+KBUENHZsA/QkbXYL945cdtcO0DCTZ0vr5AJj3rZQTEvpoO94cu+LbuqVa7+jgWBbm0ZXCm0aIyqS02gR+FbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8eCSOZLmjE4METjun+wGpHLKppvr/N/4ACcqThvQFo=;
 b=w63yl4PvX2klYhdYIWX2hjSWH4kqGFst/0xVHxih1N7LgPXUTrKizf8hg3HnImW696GAYx6rAOXroAN9zVXMiDamem9uQwUqBiSePnZ8YPf+dx5G7VmFAVCmuc/iJXjFKcvmicRU+Rmc5qi4JbFfF78iqnQhRD+fPrYI1l62l3s=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2954.namprd12.prod.outlook.com (2603:10b6:5:188::22)
 by DM6PR12MB3817.namprd12.prod.outlook.com (2603:10b6:5:1c9::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Wed, 13 Jan
 2021 03:28:03 +0000
Received: from DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::19b:66f9:83d9:7cb1]) by DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::19b:66f9:83d9:7cb1%3]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 03:28:03 +0000
From: Darren Powell <darren.powell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/8] amdgpu/pm: Powerplay API for smu ,
 added get_performance_level
Date: Tue, 12 Jan 2021 22:27:19 -0500
Message-Id: <20210113032726.2475-2-darren.powell@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113032726.2475-1-darren.powell@amd.com>
References: <20210113032726.2475-1-darren.powell@amd.com>
X-Originating-IP: [142.126.168.115]
X-ClientProxiedBy: YT1PR01CA0155.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::34) To DM6PR12MB2954.namprd12.prod.outlook.com
 (2603:10b6:5:188::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (142.126.168.115) by
 YT1PR01CA0155.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.9 via Frontend Transport; Wed, 13 Jan 2021 03:28:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c719d0f4-369b-4608-13c2-08d8b7733c80
X-MS-TrafficTypeDiagnostic: DM6PR12MB3817:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3817990A56DCF654640C7B4FF0A90@DM6PR12MB3817.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OA7ro3V7Ji6MLV/EaEGlvToxMOF61GBeCYhz++6eHQTacPldt6KTYIRmvlFSJVjAOSSZyonWFG4fBIOaPX+0Q7FqQ7Dw7DRrcwhvB1M4MaOBKiUlAC4tpJSuv+OmKuPRIJv4RbHGhYIL+qvXWygLnUSabXtYWVAGXV3i0u9c3ZE3K36SDalNh8TNpK0jEmTqxrLKqhFTgUOq579Gp5fJrFs3yVjkTo3phBvVyzKbJy8WZFhbLNe61sTli+jTsKpxrSgUm9PIGEo/AjN4MISn+T/TtYoWHWGOLD6NkuYgvI3f6ddTqQFhWEgEOcDTr+JY7Py1eNbFX7gaBsHOP7m+cuB3t6oYseA4S+coU1Z94ZAJ96XH5TIJpP1OGwVWSMj+CgNRa65G/Y0G6GIWGTQP5thCSBDP0I+3pBIhPxm0SNeDRf+NHGi5vwiHDa+FYrAg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2954.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(5660300002)(69590400011)(66556008)(4326008)(6506007)(8936002)(36756003)(8676002)(6512007)(6486002)(6916009)(66476007)(186003)(44832011)(66946007)(86362001)(1076003)(26005)(956004)(52116002)(478600001)(16526019)(316002)(2616005)(6666004)(2906002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?wLmy0RPA533pvJFEF6oXwboip4qTHc98J22QmFIcE4QFbBMuwCsxlWQh8NBW?=
 =?us-ascii?Q?fLuj3M5x4szhcpBpvZeRwm0ogtcU3ATVsr4u38uorYwx9m/IGny0KmhkOxa5?=
 =?us-ascii?Q?usi4WrOt5CA10yGeDQEalxdlPkQ89Nt5RfIsAeoNOonSMVBjbmhrMZpO+qhQ?=
 =?us-ascii?Q?29wtyt5H+kcZ3qdun893qB/nGTlqCRjlcYVzXq5htQSazhLOHDv4YVwc0/og?=
 =?us-ascii?Q?F9Lgn8b7zG0cvNQfgz9r2QjmxeoRPjs1zjL4MbOADEeFrXpam7bNZtIBFV73?=
 =?us-ascii?Q?tadGq3vlJ/69eswfxBfTNMfFrfLkLBCBfw4SvyxhRIa74xlmgU/vBH7NeXt3?=
 =?us-ascii?Q?0cnDjAMAweuRnAPLqW1p8nlpciO70INWSjHG5ep2q90W7tEUlY+LJLXk38sm?=
 =?us-ascii?Q?H30ZNtZrLD7VgJdkl0j6GsMlMA8u4A0s0z8NexBaxzcI2CQDQ3VtxhnCMUWa?=
 =?us-ascii?Q?dhK7Xx6dMefYhECvm26Lv2m0oZIyhkvjoXXmlrOVxUKWgJx8vvLr3sdpK9kv?=
 =?us-ascii?Q?WFjeFpU+xiSsMhP2oxfI8BQFTISDCP3lRpyHg6/5Y3gnI+Y3TtdHnfyDMQ48?=
 =?us-ascii?Q?NFJ0bw/1RBtnuOJQU6b0sPfNuigaanIaYoKNJYYy4iq+WEQfXdFuACsdg61q?=
 =?us-ascii?Q?twomxVSYM1EMK9VmoSUbjT14YodDWyslsY4XFoa8SBLVI2FMjwqgrJgUNYmt?=
 =?us-ascii?Q?Yz94kCATHDduYTFfx9bAbaY7INrnLikSkytJMPutNtMV3jsspn6A65UbyziN?=
 =?us-ascii?Q?go5aJRyBr8AtdheQ1GLk9zgHQ1lcrGeb80riBefgvfjOD6gN2jVrNNgXHkGj?=
 =?us-ascii?Q?LFlzKY6xb7BdyMA8D/2PSHg255P8orq4rT27j/fP4T4PcimDflwyo31e8sKl?=
 =?us-ascii?Q?lqDgGaQH0bBR6lLtLIthFODt6Ep97sKxVY8V75Z+0Obfc9oMj8BjO7I/8CO5?=
 =?us-ascii?Q?Ewp7INsopsAYmG4K9mM7Ck30I+bvpVYf6ThwQN9HqBnReBeskfXeeSMihMoa?=
 =?us-ascii?Q?I+v+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2954.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2021 03:28:03.6574 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: c719d0f4-369b-4608-13c2-08d8b7733c80
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 26gEhCXsxgl9XMuvhTfpOVqiId8Kji3fQs1Cf4OgDYYq8qZmJZGvwPRV2UdslUp9vSHLrVbU/OdJv4UoONpTDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3817
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

v2: updated the structure name to swsmu_pm_funcs

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
index cf999b7a2164..d86535016b23 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -46,6 +46,8 @@
 #undef pr_info
 #undef pr_debug
 
+static const struct amd_pm_funcs swsmu_pm_funcs;
+
 size_t smu_sys_get_pp_feature_mask(struct smu_context *smu, char *buf)
 {
 	size_t size = 0;
@@ -428,6 +430,9 @@ static int smu_early_init(void *handle)
 	smu->smu_baco.state = SMU_BACO_STATE_EXIT;
 	smu->smu_baco.platform_support = false;
 
+	adev->powerplay.pp_handle = smu;
+	adev->powerplay.pp_funcs = &swsmu_pm_funcs;
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
+static const struct amd_pm_funcs swsmu_pm_funcs = {
+	.get_performance_level = smu_get_performance_level,
+};
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
