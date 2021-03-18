Return-Path: <SRS0=NRDG=IQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B6EC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 09:21:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D47A664F10
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 09:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D47A664F10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1620C6E8D1;
	Thu, 18 Mar 2021 09:21:20 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 884C36E8C8
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Mar 2021 09:21:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NCkxv151ijygEQS+wj1LmRvoCFX2qMOwXGUL3iTSeHTXKqewz56VOvjf4ELsBb72ffht0S0WsBj+Hb+ys1R2uYVRCVWAoy2ze88Z6YHtXcy/AhEybNc1BsAKfjQZHZFyIMp5MixNPUpA5RA7KuhK1nm1zANel5dYnBTUkFCVqOaJ5DKoxzcilHLMDbuTF7d0zSQQeDf/nkztbzWdcDdCl5sYWxjmeDsLo1a0yMtMLPQ6WdFCDJIMpXNP6d5buJFLUCaPQoWqJ+54yXR6g78sIdiPxx5wBM1NznvVk0Dx29oSeWKJ6VaEan7/+luIt5JefmeuRMTRg8W8IkrTO/QH+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6nUNiXMW5hf/aaEn2B0OvhcWAystwTTOo6QVp2pOgU=;
 b=HYF9YmostQqZ8/wDunCT3l9hiYiELn7BOkLc0yasWqmn29vi7nOsQ89DmG3S5sm2z74aT9rkMOLZ9EVZjTjfq2YXlFcWWS9/hJgxjrSLpgZVWeQG+knynb3Bl498MzNLJhVn+cUjdITXM4BYqXiAq+C+Cyn8c8i6ZwWWL9NjDZcGAaTeNOUkTuwMQNmq4F6qLjcJ1HcJZId8QSMSQ+JMTAFRtOwAmC4UN0rDHc5qGXQvRtuQrHhHXU83VzRHEglpbyPDW8Rmc6Za3dQ3hedGtwsC/+2YEFgsPgxZPkMLfEI9M6vz/e4ZMux2PyX/57ZkBqWoDkLre+dG4FdJ+9NqDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6nUNiXMW5hf/aaEn2B0OvhcWAystwTTOo6QVp2pOgU=;
 b=Z1vya9vLfZL1vtmPgE50d31zVD7qXXW3wEaXjBSenU26TvGTsBQZJDHBF0S/50c223cV12uDd6YqRpQgNtNLsEqyIr1uS8MVObTIGswp/DxoRlTcIkbGh7sh0ssRwKW4NvAKh09MinqIJQNqqnPPxEXWhorcQM1C7MQAaV14EcY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4960.namprd12.prod.outlook.com (2603:10b6:5:1bc::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32; Thu, 18 Mar 2021 09:21:16 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8%7]) with mapi id 15.20.3933.032; Thu, 18 Mar 2021
 09:21:15 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: fix Navi1x runtime resume failure V2
Date: Thu, 18 Mar 2021 17:20:55 +0800
Message-Id: <20210318092055.437406-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HKAPR03CA0006.apcprd03.prod.outlook.com
 (2603:1096:203:c8::11) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HKAPR03CA0006.apcprd03.prod.outlook.com (2603:1096:203:c8::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.9 via Frontend Transport; Thu, 18 Mar 2021 09:21:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 08bb7f67-e04c-4f84-db60-08d8e9ef2e1f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4960:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB496085A85E50C675B4E37D49E4699@DM6PR12MB4960.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JsOXhYLR2hMAfoNva+ZMl716n579YUAtCdPOl5aDwZ/jdsovko8l/Xl1hhHPnqZ3CzmrYEhoEO5aqeFDZoJcO4hM37q8uY9UyMX0WO7kkoynkKm6H6X17V9WBFn/jwCvj/TWSr6QkEPuoFNpEq4ZfC/qElhtrXof0JUKpDqnlYl/wDgyddktYqxRzy5/D2wSqZRVEZ9NrJMz6vPaK6YsnQ+uoJ342oGOAQaCWAlMklslD6ufIge5pzpNdhBsWLt+gdPe2twsu3h8xQ3mESf9a5JWLTpBmL7yrQd8UF9t5kMAfjpFyoUZ2//PGItjH0za6vtM9x/T6p/RsNLKgWMBYNMxT8v7Qas0Ajd9+mLwtmoTxEAN0elU+thoLHIpgBIBp5fp2uF5sqg5ocZly481LjBvzyf0mLu8OdkSdS51NNRRbUuALL4zSv+CY4wRpWg0rQwy/ZP/HCbUeAkD2V+JmcP1O6TZUA9v2MjUvC1tyXfD2IN9PzU6SiHwYmVEmYu7U3wZ279En72/bw4dWCw0k37eNQYL3ixw7Jg9lsx0gVC3ViOdhYuLVe8zwluLFjfwhx2/gX0tqptGAKg1LqTXiKLPE5KjWZfL8WI4MskPF/rWlrKpaEKQOrHHQG85crjVvUCGdy+3hkOuT184/gDCGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(8936002)(52116002)(16526019)(26005)(186003)(478600001)(36756003)(4326008)(66946007)(66476007)(2906002)(7696005)(86362001)(5660300002)(66556008)(1076003)(6486002)(6666004)(6916009)(8676002)(83380400001)(956004)(38100700001)(44832011)(54906003)(316002)(2616005)(32563001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?qxTKxjkNhKPr2DLVdpFTlzBe9iCfodAtDsWvMrPyfmOIvRuEeEpXxfTCaK8C?=
 =?us-ascii?Q?jC8qDRu4bTm4XvlmnCvdVevW3Bj3ei3XImTcPqdH70ebsOCZkuFu9QCz5TGH?=
 =?us-ascii?Q?hivAWwvXwaRalWzIPvToqizSZNxl/jJdwZ4t5LTupYA8bW6t+aq6MlS31vdD?=
 =?us-ascii?Q?8w2yuZ5lrmAk8sjv/WNOKWlZCqkSI7nf3AEYFWa/ZewXJQK/a5aqDwtA6/uP?=
 =?us-ascii?Q?4Xgy0OnDTDVgBYQ4bUIVs6wiJPxa2VuwXe0cTMD6Ut2+zDRKRW19hyZYl6fN?=
 =?us-ascii?Q?chTPGRSv2saJqF2LQCLEWh9oHBcHmcDmyj98bVP9Bxu4hyMFYh7VkuWcsegG?=
 =?us-ascii?Q?TO2Is/opU/8EsolvyyluHboG33W4nOaxYUYQCE6zc6cJNrnar4pIPbb1ZHI0?=
 =?us-ascii?Q?52fGbhkjWuFpdnTgDzcrs7nA6TG3de5NhRDu0Vja6dFXUn7nH1t5/tmRwrbm?=
 =?us-ascii?Q?RwhFTdcZas9XkLV/QtzMR7RgOi32RrfyhsRL34cyDXKFBBTmTKLILARNAmo9?=
 =?us-ascii?Q?d8FRLJk6rprG+vYQ/M7MOoTplPPdDVTTaLwSMLOMwJ34jlOE/iQ4xu2SZCSo?=
 =?us-ascii?Q?DFfni+PV0DQUGu5DPmwC/EyCO6FuoMqxAlF4LFcKcoa6yRj+aO3eE25/WWAO?=
 =?us-ascii?Q?Jmw6iWoW2r5/nforkNnpNb5gPKKKq9UhgRtSWc31nU0yvUCNnTwXjBD4kzPh?=
 =?us-ascii?Q?ezSuUaTHzcwF+MQ2AJZLRL/cN27k5+F0miEVPZfj+fP6TUeeLDonrL93h4h6?=
 =?us-ascii?Q?IaWhx9QAeVeg6f8L6JM6AHv+EAGPXrnTkDUP3eIhbgndry1MIsg2NagnhNNw?=
 =?us-ascii?Q?8sVKcjhLYEILNHh13pBZGNk963r6f0er7z2XZ1K+sgZgz1i9/AE916EJgx40?=
 =?us-ascii?Q?uhMdVGYJ6yvB4+0DeXVmhy3RjdlXoReCG/a1uB5fAuBoqVmpZKQ9f2AWKqGI?=
 =?us-ascii?Q?gBNwgnw6jXLcZlMYBqdq966VocFB/pSsewa8j3a6Z4K9GigUaMWFM4sW4fFq?=
 =?us-ascii?Q?y407YIiUJG+83wdbPg2tIRiHM4RLfPs3qqqcZ818f5pAVKL355kDLZ5TQuwK?=
 =?us-ascii?Q?9/k3neyJDFhIvoQc6fvK8Y4JG7hW1hB/HHP1uFLd1hrv4t3oPSiBmxy7yi1e?=
 =?us-ascii?Q?VoYPTgJkfaL0GTog0pRXIlLBgQwMZsD2NoVYb4MWlbRr+fEMYf5nbsk6dG8V?=
 =?us-ascii?Q?NDjhuwEUli1MvaInPYi/0fxyz/VLLlK8LSftLAHic2EoGW/IEFnyU7NgBzhQ?=
 =?us-ascii?Q?If8rTJHzX2YfSCkHmqIbNLPPBu6FEbzWf6V6uyccwMB9WV7UD4iBeoHx3G5I?=
 =?us-ascii?Q?8VI+RkQ18jyrcnxhD8QRgGXQpKOReDS1Y8Jp5qQxGP+02w=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08bb7f67-e04c-4f84-db60-08d8e9ef2e1f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2021 09:21:15.8247 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v+MRRni3oMGlwCTFjJiPyJr78rdY/2p0MomlkH6qUFreImxTeEipYXBI2fkO1146
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4960
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
Cc: Lijo Lazar <lijo.lazar@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The RLC was put into a wrong state on runtime suspend. Thus the RLC
autoload will fail on the succeeding runtime resume. By adding an
intermediate PPSMC_MSG_PrepareMp1ForUnload(some GC hard reset involved,
designed for PnP), we can bring RLC back into the desired state.

V2: integrate INTERRUPTS_ENABLED flag clearing into current
    mp1 state set routines

Change-Id: I4eb3d5d76068412a6ab228af7fe7f794e53c1eaa
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  9 ++++--
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  7 +++++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 28 +++----------------
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  1 +
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 25 +++++++++++++++++
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 14 ++++++++++
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 14 ++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 28 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  3 ++
 9 files changed, 102 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 809f4cb738f4..ab6f4059630c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2160,9 +2160,12 @@ static int psp_load_smu_fw(struct psp_context *psp)
 	if (!ucode->fw || amdgpu_sriov_vf(psp->adev))
 		return 0;
 
-
-	if (amdgpu_in_reset(adev) && ras && ras->supported &&
-		adev->asic_type == CHIP_ARCTURUS) {
+	if ((amdgpu_in_reset(adev) &&
+	     ras && ras->supported &&
+	     adev->asic_type == CHIP_ARCTURUS) ||
+	     (adev->in_runpm &&
+	      adev->asic_type >= CHIP_NAVI10 &&
+	      adev->asic_type <= CHIP_NAVI12)) {
 		ret = amdgpu_dpm_set_mp1_state(adev, PP_MP1_STATE_UNLOAD);
 		if (ret) {
 			DRM_WARN("Failed to set MP1 state prepare for reload\n");
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 629a988b069d..21c3c149614c 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -836,6 +836,13 @@ struct pptable_funcs {
 	 */
 	int (*check_fw_status)(struct smu_context *smu);
 
+	/**
+	 * @set_mp1_state: put SMU into a correct state for comming
+	 *                 resume from runpm or gpu reset.
+	 */
+	int (*set_mp1_state)(struct smu_context *smu,
+			     enum pp_mp1_state mp1_state);
+
 	/**
 	 * @setup_pptable: Initialize the power play table and populate it with
 	 *                 default values.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index bae9016fedea..470ca4e5d4d7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1927,36 +1927,16 @@ int smu_set_mp1_state(void *handle,
 		      enum pp_mp1_state mp1_state)
 {
 	struct smu_context *smu = handle;
-	uint16_t msg;
-	int ret;
+	int ret = 0;
 
 	if (!smu->pm_enabled)
 		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
-	switch (mp1_state) {
-	case PP_MP1_STATE_SHUTDOWN:
-		msg = SMU_MSG_PrepareMp1ForShutdown;
-		break;
-	case PP_MP1_STATE_UNLOAD:
-		msg = SMU_MSG_PrepareMp1ForUnload;
-		break;
-	case PP_MP1_STATE_RESET:
-		msg = SMU_MSG_PrepareMp1ForReset;
-		break;
-	case PP_MP1_STATE_NONE:
-	default:
-		mutex_unlock(&smu->mutex);
-		return 0;
-	}
-
-	ret = smu_send_smc_msg(smu, msg, NULL);
-	/* some asics may not support those messages */
-	if (ret == -EINVAL)
-		ret = 0;
-	if (ret)
-		dev_err(smu->adev->dev, "[PrepareMp1] Failed!\n");
+	if (smu->ppt_funcs &&
+	    smu->ppt_funcs->set_mp1_state)
+		ret = smu->ppt_funcs->set_mp1_state(smu, mp1_state);
 
 	mutex_unlock(&smu->mutex);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 69aa60a2e8b7..e033aa6c7d9b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2367,6 +2367,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.get_fan_parameters = arcturus_get_fan_parameters,
 	.interrupt_work = smu_v11_0_interrupt_work,
 	.set_light_sbr = smu_v11_0_set_light_sbr,
+	.set_mp1_state = smu_cmn_set_mp1_state,
 };
 
 void arcturus_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 88634b44f8ff..bd95d41fe7a9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -431,6 +431,30 @@ static int navi10_store_powerplay_table(struct smu_context *smu)
 	return 0;
 }
 
+static int navi10_set_mp1_state(struct smu_context *smu,
+				enum pp_mp1_state mp1_state)
+{
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t mp1_fw_flags;
+	int ret = 0;
+
+	ret = smu_cmn_set_mp1_state(smu, mp1_state);
+	if (ret)
+		return ret;
+
+	if (mp1_state == PP_MP1_STATE_UNLOAD) {
+		mp1_fw_flags = RREG32_PCIE(MP1_Public |
+					   (smnMP1_FIRMWARE_FLAGS & 0xffffffff));
+
+		mp1_fw_flags &= ~MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED_MASK;
+
+		WREG32_PCIE(MP1_Public |
+			    (smnMP1_FIRMWARE_FLAGS & 0xffffffff), mp1_fw_flags);
+	}
+
+	return 0;
+}
+
 static int navi10_setup_pptable(struct smu_context *smu)
 {
 	int ret = 0;
@@ -3036,6 +3060,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.post_init = navi10_post_smu_init,
 	.interrupt_work = smu_v11_0_interrupt_work,
 	.get_gfx_off_status = smu_v11_0_get_gfxoff_status,
+	.set_mp1_state = navi10_set_mp1_state,
 };
 
 void navi10_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 00575d452f08..5a5771785e10 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3281,6 +3281,19 @@ static int sienna_cichlid_system_features_control(struct smu_context *smu,
 	return smu_v11_0_system_features_control(smu, en);
 }
 
+static int sienna_cichlid_set_mp1_state(struct smu_context *smu,
+					enum pp_mp1_state mp1_state)
+{
+	switch (mp1_state) {
+	case PP_MP1_STATE_UNLOAD:
+		return smu_cmn_set_mp1_state(smu, mp1_state);
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.get_allowed_feature_mask = sienna_cichlid_get_allowed_feature_mask,
 	.set_default_dpm_table = sienna_cichlid_set_default_dpm_table,
@@ -3369,6 +3382,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.interrupt_work = smu_v11_0_interrupt_work,
 	.gpo_control = sienna_cichlid_gpo_control,
 	.get_gfx_off_status = smu_v11_0_get_gfxoff_status,
+	.set_mp1_state = sienna_cichlid_set_mp1_state,
 };
 
 void sienna_cichlid_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 9813a86ca31a..7d38b92a78dc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1460,6 +1460,19 @@ static bool aldebaran_is_mode2_reset_supported(struct smu_context *smu)
 	return true;
 }
 
+static int aldebaran_set_mp1_state(struct smu_context *smu,
+				   enum pp_mp1_state mp1_state)
+{
+	switch (mp1_state) {
+	case PP_MP1_STATE_UNLOAD:
+		return smu_cmn_set_mp1_state(smu, mp1_state);
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static const struct pptable_funcs aldebaran_ppt_funcs = {
 	/* init dpm */
 	.get_allowed_feature_mask = aldebaran_get_allowed_feature_mask,
@@ -1518,6 +1531,7 @@ static const struct pptable_funcs aldebaran_ppt_funcs = {
 	.mode2_reset_is_support = aldebaran_is_mode2_reset_supported,
 	.mode1_reset = smu_v13_0_mode1_reset,
 	.mode2_reset = smu_v13_0_mode2_reset,
+	.set_mp1_state = aldebaran_set_mp1_state,
 };
 
 void aldebaran_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 917f8afbcee0..d423315aa2b3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -782,3 +782,31 @@ void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev)
 	header->structure_size = structure_size;
 
 }
+
+int smu_cmn_set_mp1_state(struct smu_context *smu,
+			  enum pp_mp1_state mp1_state)
+{
+	enum smu_message_type msg;
+	int ret;
+
+	switch (mp1_state) {
+	case PP_MP1_STATE_SHUTDOWN:
+		msg = SMU_MSG_PrepareMp1ForShutdown;
+		break;
+	case PP_MP1_STATE_UNLOAD:
+		msg = SMU_MSG_PrepareMp1ForUnload;
+		break;
+	case PP_MP1_STATE_RESET:
+		msg = SMU_MSG_PrepareMp1ForReset;
+		break;
+	case PP_MP1_STATE_NONE:
+	default:
+		return 0;
+	}
+
+	ret = smu_cmn_send_smc_msg(smu, msg, NULL);
+	if (ret)
+		dev_err(smu->adev->dev, "[PrepareMp1] Failed!\n");
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index c69250185575..155e2a68fa1c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -99,5 +99,8 @@ int smu_cmn_get_metrics_table(struct smu_context *smu,
 
 void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev);
 
+int smu_cmn_set_mp1_state(struct smu_context *smu,
+			  enum pp_mp1_state mp1_state);
+
 #endif
 #endif
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
