Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0523C4742C
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 06:53:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88E5220A8B
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 06:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nAXoF6hi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88E5220A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DCC56E3F0;
	Fri, 13 Nov 2020 06:53:38 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 419BE6E3F0
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 06:53:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dX5MKHxQCumwE+FpM2cUFDkOS4muf25g7bloAphLF6Cq11WvCFoymsFU5ILpqKRlMhGUVutA3nHAuR8nvXclN+D6uXhGUemc9QTmB2P+Bekuo4ZcLI3rwonuZIjXEkwxqYhK6lKCQH0M2k//pHHp8NPEYXnPvIanjsqJrb/uVAjMMtnqZcFYkz1c1rnb8QYeMIqDSSJXy/S+WZ0dTxiDbs1ztu890UHVW2ezBqAPodQB2H6dertTExcIIHd4kwtZDAmSAy0kicc1IuIonH3MLFG1nQG9uGuhSyD4M85hFe3aSpVlYkSLy585tTVfmU9WLloxJAgIM/0+0qt6dOpMHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0Qkq0xq8wAV8Q5LGAEChnz/i9Hom3BR2y4R3bXc1ME=;
 b=ifsdpv3ESWdfBXxgonOREPtnpI2kqyrz5kfJ2w4HElZ0trVt17bJxcC3NxJ+2AAc17dtZATHCILDuJtrt1jW41snb4rn+w7BJWHNzQxqfXmHqSDCK1/2fvODs6VxsuZrV1QOfy/0QDSSN/lz+lsWkgT3r15Hb6pigAm+2CozLoz/GdgHj831UYjwqZTLsc3M8JGHkBa8Ef87CrEebXMSsXC2b1RsORgLUFZVGfqYVK4ZNmWuZ8owCqi5kyG4KAkUd0UzaLFquHBD3bubIvF+6huyoTaV2cCeRx0d+SVanfkHiWoHHKXZMdX8im3GAzj5xSxOdvMTrDWqpLrF7AuLcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0Qkq0xq8wAV8Q5LGAEChnz/i9Hom3BR2y4R3bXc1ME=;
 b=nAXoF6hiDxz1H0tyvhwVYB2ULQ1rD0+d4QbVVLT+d4RPUHxkEitxG+Y0kSry/e9gQ1YVAHVLyIjO0DB3r/12QUQYvp5vXP8iR8FdoJ6cCTKJ25ZqHXt9q2oIpxAma9ig+yM0aSB7E1P1PcjDCbgft4Ke4mlbSd+IfKle2B9VChs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BYAPR12MB3333.namprd12.prod.outlook.com (2603:10b6:a03:a9::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 13 Nov
 2020 06:53:35 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::9866:32dc:79cb:d695]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::9866:32dc:79cb:d695%7]) with mapi id 15.20.3541.025; Fri, 13 Nov 2020
 06:53:35 +0000
From: Prike Liang <Prike.Liang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/amd/pm: add gfx_state_change_set() for rn gfx power
 switch
Date: Fri, 13 Nov 2020 14:53:17 +0800
Message-Id: <1605250397-15043-4-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605250397-15043-1-git-send-email-Prike.Liang@amd.com>
References: <1605250397-15043-1-git-send-email-Prike.Liang@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK0PR01CA0060.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::24) To BYAPR12MB3238.namprd12.prod.outlook.com
 (2603:10b6:a03:13b::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from prike.amd.com (58.247.170.242) by
 HK0PR01CA0060.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3564.25 via Frontend
 Transport; Fri, 13 Nov 2020 06:53:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 78626e29-bddb-44ac-7e72-08d887a0d72d
X-MS-TrafficTypeDiagnostic: BYAPR12MB3333:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB33332F4E807552621C39407DFBE60@BYAPR12MB3333.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:608;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ThmytEC4yzreHttfGpQm8C4Uh/tw7Ivf7YeT1zqfTUCjIs0lxpbSJ4SMfV4V8d2I82jb6VmopQbMuHBVkdowLmCTTdvcM4fdVt5Q6FqsAYWW01JPJzr/KeQpL0qPCcRjPhE8lI0DkQTPe6nV2OQTTOAE5Leol6oO16lexoXTA6JiYoK04m7ihxETqAGywvOHy6NGF58yo9VM9mp4pD29cFvmaGs3nBhy2msMivW+RCaJW6Pok1PEMOElf4gbX+Poln9HPnn8I70P1SurzVm7GObYlM2g8Ei9kQGsi3b4D6/LfWP+PYM2JOkhZ53lLYsBCWH+Cg9RBdcI1p0Wgt4PXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(2906002)(8936002)(66476007)(956004)(36756003)(186003)(478600001)(2616005)(86362001)(83380400001)(5660300002)(6916009)(66556008)(6666004)(4326008)(66946007)(8676002)(26005)(16526019)(7696005)(52116002)(6486002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: zqcAEz/B1anQjP1EXf9ZUUipmv8O65KuA9cYsxFuxgUrGRLMZZvJKEU+voZLwC626sC0ac0HhcB3Pb4PyiocSnSynmK+OPmZBuHIVVwXSnu7BhGGbjmWCj5twFmU+jVFBNYhYZwJsjWZAAqiHzurNCMkxYXQnubia5KBQbqB/p+Ow4kCrUIWEGNnjQF89R17fsZYGI+hH0Fk8oNaP9szULI0lSTeXRMIACr8Sr3NILomHN976BdDvFCuAYaN9FV8+VF9gw4tfgKjCMnj1mJDtlxzoDKRdhlnX10HUu9Wqhd+i4B68dOngToRiAqr+f75O/n760i2m2OrNWWYGFOIPQLti8spaXl/mqPq62cTa3JzAMF+9GdOEHwK7KGuI4Yz9rtYud0xVTkBF6vwz7Yp7836M0o/KrV+i3tyuU0I3/PfcXOLnefp9WmOm2lPjQWjvg0WFs2tBZNU/pGbMgN8Jkhc2FqCFFAjIeL40pww9o9/2uRgdFAzi6eOeM9wLqQSQ2k00ME2qNhpkArXcmThY3w+oBUlJY/EKwVay4TkeR9CT3BwP+WRInIboKv81uY84F3+sojbVLTt6oPawSzV5ZqLWkRWSvl2Fb9KOWZSrRvgL47uYgmbn7PyHWMQnsTgGOleZvy9D655fgN4N4SxUkvImbsef+6NYrYo+MzlBwg67pIp/ewJgP1pVM+zjftdk5y2JZgbwM/WwAFSQ58xc58JMw97wABD1G9UiVEE4QAzPcvinjytlPf4qfP4IdSwPOYQGjpjbOqMZql8g/5VAhsnhMtsv6JtHLYAlNJyKCa1AftlJ3xkIrPdA2wfEu4/JTg1jYUlGj16gMbPR9GTn9HDNF9m2RksXzLUFzjp+z0qwtVNFzNAZC3B4AWVsCUePY4cL1JmWuguiv10qkzeIg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78626e29-bddb-44ac-7e72-08d887a0d72d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2020 06:53:35.6350 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tL5xXD6UYw1gWNhPeLuX8kbydkT/xBv5M8rGB9wPU24AmHxq3++c+8AW5cXZ73pv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3333
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
Cc: Alexander.Deucher@amd.com, Prike Liang <Prike.Liang@amd.com>,
 ray.huang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The gfx_state_change_set() funtion can support set GFX power
change status to D0/D3.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c         | 18 +++++++++---------
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h         |  2 ++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c       | 12 ++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c |  7 +++++++
 4 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 380dd3a..cd2c676 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -828,14 +828,14 @@ int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev)
 
 void amdgpu_gfx_state_change_set(struct amdgpu_device *adev, enum gfx_change_state state)
 {
-
-	mutex_lock(&adev->pm.mutex);
-
-	if (adev->powerplay.pp_funcs &&
-	    adev->powerplay.pp_funcs->gfx_state_change_set)
+	if (is_support_sw_smu(adev)) {
+		smu_gfx_state_change_set(&adev->smu, state);
+	} else {
+		mutex_lock(&adev->pm.mutex);
+		if (adev->powerplay.pp_funcs &&
+		    adev->powerplay.pp_funcs->gfx_state_change_set)
 			((adev)->powerplay.pp_funcs->gfx_state_change_set(
-					(adev)->powerplay.pp_handle, state));
-
-	mutex_unlock(&adev->pm.mutex);
-
+				(adev)->powerplay.pp_handle, state));
+		mutex_unlock(&adev->pm.mutex);
+	}
 }
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 9724d6f..ae8ff7b 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -576,6 +576,7 @@ struct pptable_funcs {
 	int (*post_init)(struct smu_context *smu);
 	void (*interrupt_work)(struct smu_context *smu);
 	int (*gpo_control)(struct smu_context *smu, bool enablement);
+	int (*gfx_state_change_set)(struct smu_context *smu, uint32_t state);
 };
 
 typedef enum {
@@ -764,6 +765,7 @@ int smu_get_status_gfxoff(struct amdgpu_device *adev, uint32_t *value);
 ssize_t smu_sys_get_gpu_metrics(struct smu_context *smu, void **table);
 
 int smu_enable_mgpu_fan_boost(struct smu_context *smu);
+int smu_gfx_state_change_set(struct smu_context *smu, uint32_t state);
 
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 3999079..7b698c5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2529,3 +2529,15 @@ int smu_enable_mgpu_fan_boost(struct smu_context *smu)
 
 	return ret;
 }
+
+int smu_gfx_state_change_set(struct smu_context *smu, uint32_t state)
+{
+	int ret = 0;
+
+	mutex_lock(&smu->mutex);
+	if (smu->ppt_funcs->gfx_state_change_set)
+		ret = smu->ppt_funcs->gfx_state_change_set(smu, state);
+	mutex_unlock(&smu->mutex);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 66c1026..46c44f0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -1136,6 +1136,12 @@ static ssize_t renoir_get_gpu_metrics(struct smu_context *smu,
 	return sizeof(struct gpu_metrics_v2_0);
 }
 
+static int renoir_gfx_state_change_set(struct smu_context *smu, uint32_t state)
+{
+
+	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GpuChangeState, state, NULL);
+}
+
 static const struct pptable_funcs renoir_ppt_funcs = {
 	.set_power_state = NULL,
 	.print_clk_levels = renoir_print_clk_levels,
@@ -1171,6 +1177,7 @@ static const struct pptable_funcs renoir_ppt_funcs = {
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
 	.get_gpu_metrics = renoir_get_gpu_metrics,
+	.gfx_state_change_set = renoir_gfx_state_change_set,
 };
 
 void renoir_set_ppt_funcs(struct smu_context *smu)
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
