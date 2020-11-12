Return-Path: <SRS0=wW4+=ES=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771A7C2D0A3
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 07:06:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F350D20791
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 07:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1KDFERfL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F350D20791
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 899D36E147;
	Thu, 12 Nov 2020 07:06:53 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B76786E14B
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2020 07:06:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CPDi3MBTiZZueLhnlGu/xqHppACtujSMGnM2UR1/DwKzWbI3aLpRmHmlrk5OxYOxdlJ2RjFYrn7+CSY7/p/iDmzzaFEG6UpyChyXx8oI03+6JCFhNPGRYH9KEuoDzmvm3gS8sOQEyxIXU+n+ZSZMRoAG8D7NIEvNaiAeyy2SEU4Z9KgZhFJn5Op7hdaZNw42zNC71NpeixsjAmE18NlGWrWMWQCERDGbvgEsxJyaz5TOOeV78IPGqOOGdJyVwhO/yjPyRgDIzTqd4owCA8hrnweSduAgNSkjCow5qWsd++e7r3gP300Tc+7u4POfQ3Mnn+TdgLOJdFJSDUD8PIi5JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Sb5tK0Motd8O6RoCxTjRx8K36uGQxww9R8tIf8CjpQ=;
 b=LiBIzeqG5XZrLHocVzDc7oaTq6LUeG5cKlHh7iL/SswZid7P+cl3t/7vQ3VbFDpqICsOB18vj6ZCMl1EUjdo2ILdFR9qe3c7PFXsjRloVhgpgDhfI8zBji2IP34LcjARQF4cAeg/RV3Hy4K66gavpPI2tWKy2WBqaSRO/WhdwmvJHvBz4sZd6CTPPbsCllfxVgR04XCyyfGPgv8OVVLmHrRfPyXwWi2Xe23nXKx5LjsAyCa4vSn6S8pR3SZlg6IN5kfcF53yJjQ/tKtd5Ch1cDZKPE8RXIxavSgK196LPi2fEmF+E853UmiuVr8H0faQf+S7TObCF/hdxULueu/uZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Sb5tK0Motd8O6RoCxTjRx8K36uGQxww9R8tIf8CjpQ=;
 b=1KDFERfLzxaO7o0xW6xSszEQTRpKa0rEi/f0N+IXdbaCpLqbC6Aj+wa29R5NKO1vzoU/ltpJWcQluJly2HRewx1Qbl/f7sVAe6FsYlMPynVJRkwpyR3zCuFoolRKnuUdiMmZocUPHpDmGhd1WqLl3wRqFhFCIv1MmNczD1/tfZQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BYAPR12MB4789.namprd12.prod.outlook.com (2603:10b6:a03:111::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Thu, 12 Nov
 2020 07:06:51 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::9866:32dc:79cb:d695]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::9866:32dc:79cb:d695%7]) with mapi id 15.20.3541.025; Thu, 12 Nov 2020
 07:06:51 +0000
From: Prike Liang <Prike.Liang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/5] drm/amd/pm: add gfx_state_change_set() for rn gfx power
 switch
Date: Thu, 12 Nov 2020 15:06:36 +0800
Message-Id: <1605164796-22215-5-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605164796-22215-1-git-send-email-Prike.Liang@amd.com>
References: <1605164796-22215-1-git-send-email-Prike.Liang@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR02CA0187.apcprd02.prod.outlook.com
 (2603:1096:201:21::23) To BYAPR12MB3238.namprd12.prod.outlook.com
 (2603:10b6:a03:13b::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from prike.amd.com (58.247.170.242) by
 HK2PR02CA0187.apcprd02.prod.outlook.com (2603:1096:201:21::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3541.21 via Frontend Transport; Thu, 12 Nov 2020 07:06:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 92c5a2ff-686c-428b-0dcb-08d886d9874c
X-MS-TrafficTypeDiagnostic: BYAPR12MB4789:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB478917713C7D56AF24EAC3BFFBE70@BYAPR12MB4789.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:608;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /NAHKdSQdevHM67jPcguXbtkOvy1XUpRRzbFe+V3DnMqjcZjaMloNfHJlbHCsezlpro2hdfmZaqrgEeXwh6QfvkcjNRnxLTQpZDdZJH9735TkIRlMrHu8/KOx2nbo7uU4umJhl9eo3aVC9Bd2b+5n493p2ZZ1VTWlWYojS6IJCgleyhY4zIHSvrHkuD91xWYs3LAH4jXXYPvMopOaZ7YWd1p4rxTKLdGEJpnec9KZYq7necRBc8UtOHI/8lGYxM2hb7ClRHY7FFkdE85jyBGBbWrC05jT8me3dVFA6b9zrh3OHOW5bozVafxaN4FN/ldktCSQfS/gJkuCSRLQlBEWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(7696005)(478600001)(316002)(86362001)(6916009)(6486002)(66476007)(4326008)(66946007)(66556008)(5660300002)(52116002)(83380400001)(36756003)(2616005)(2906002)(6666004)(8676002)(16526019)(186003)(956004)(8936002)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 3av8ADd0iDFmordQZ1PdYT+oXRDq7N91CKQEysfyvXQwI8gEqVkdV51LTRGoitQqVJiFbZ8AQJXqSL5QuBi6G0RVGDIoiATYwvwjLHJo66Cvy4WK+yUxBYL8Z0f024ZQUSCBayTVDilpr13oy1IjgzpPcgltvod+BqY+RpCPBuFp+oZjciNGxNpwllmY0YlW0FJp11vpp4lRIBEE7G/YoqfF74ucRGPrjkPub42qT6tkMTca57/8LZbgJGSe3Y8jonmUEZqubUb2co04yWFU1CxbLNDgDUNQnFHuY7dbrcxLbLq5yzuXyl2oPVSnIs37MkVLb5FnLS6Re7uj6EHX23naAVYMowfuXLaMddJo8nd3hrXCuFkv68B2/VDf8ES0IgWcSHZUFmxpoymXUkENSVOIbx3yvvcMaeJ8ULXzDev9Dm2sk3ku/U3pUu4tiaPbVLVsnHs9Ssw2KXjsaErlsoS/NDvioZJEAXFxVQl+xbAzJjK5VIZnH4zogA80gbrRk2q9FmMbigCFG6M7oBh76ry5pF3CdFQtRhtEslHPs/uE2GiBybTnIJKYbLYdnTt+k1hGlEwlvH2c6XgYeukKHB6kLKLe7mdQEMzOUvU6/AQSyunLPtfj9hwDnKkIjt4hXubAxJLtAycZ4Sky9UydCK+hnX0rUQXFFtMghv4HFI0Zshp7eGahEQF4L/pdC3J2YKMtieyZv78YjGfVc0O/IfJehuwkkg+CfHm+ZGwQf/3psx+5Wpas56wdZS2AKtiDTvCKtdwgsQ8/EQ6GuVYBuj/9elq/4kLpr0w50CCi2nvlENq0a6vm/zgIpos8J40ewumRCfCqKP50zYtoF4UqtSWAtSrhUq4p9xEOxlbDGbMyKcnkQAFb9FJSWfZtEcNtBQv5agkny148pTBvKxat8w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c5a2ff-686c-428b-0dcb-08d886d9874c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2020 07:06:51.1337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TKpCKlmoc4VqmdFv5rhRyVu602WnUmi3jx6Hzfu3a7sH34cEd6KPdvq+e2ErjyYw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4789
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c         |  3 +++
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h         |  2 ++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c       | 10 ++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c |  7 +++++++
 4 files changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 380dd3a..60c0a6d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -838,4 +838,7 @@ void amdgpu_gfx_state_change_set(struct amdgpu_device *adev, enum gfx_change_sta
 
 	mutex_unlock(&adev->pm.mutex);
 
+	if (is_support_sw_smu(adev))
+		smu_gfx_state_change_set(&adev->smu, state);
+
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
index 3999079..35465a6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2529,3 +2529,13 @@ int smu_enable_mgpu_fan_boost(struct smu_context *smu)
 
 	return ret;
 }
+
+int smu_gfx_state_change_set(struct smu_context *smu, uint32_t state)
+{
+	int ret = 0;
+
+	if (smu->ppt_funcs->gfx_state_change_set)
+		ret = smu->ppt_funcs->gfx_state_change_set(smu, state);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 66c1026..9423f36 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -1136,6 +1136,13 @@ static ssize_t renoir_get_gpu_metrics(struct smu_context *smu,
 	return sizeof(struct gpu_metrics_v2_0);
 }
 
+static int renoir_gfx_state_change_set(struct smu_context *smu, uint32_t state)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GpuChangeState, state, NULL);
+}
+
 static const struct pptable_funcs renoir_ppt_funcs = {
 	.set_power_state = NULL,
 	.print_clk_levels = renoir_print_clk_levels,
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
