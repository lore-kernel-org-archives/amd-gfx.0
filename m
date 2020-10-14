Return-Path: <SRS0=q64Q=DV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5717C433E7
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 07:18:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 719022078A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 07:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aPY0MSV9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 719022078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 135016EA17;
	Wed, 14 Oct 2020 07:18:51 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD6566EA1A
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2020 07:18:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqKsX1YTMRPDPQ5xPCmqjy8oXvyrZsUOgzGBXhbvowp/DqatL5nAe2dX5nWLlop7gvrmsRovhjmwQw88T4+bAHNf6LZgAHgi23pZd1q8k7wcvaUCMXqPQMKvV2kpSC/Eh25MAOahxCwVZNIFKrWghOoJwT6ZbpBgtwSaDPFAxSKYOXBbBp/8ZT+MsG5r8GQKd1IWDI24sDCV+UA8xXf3UT72MNXlYn3+qhJ8R3ZzLAOHIPUu5ocVdJeitPyUFoxbfskctxTK+lsHv9g32Xo4G1k2h9oDxHqgR+ogDrWmaqcpJ7FWKt/UsYDqQRRIgibLvYwwPOWPeLrPPeZsj/uoqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwLLbIzKpkj5Nzuz5hX5nMgs4lwsF2ueL6CBNL/IzTE=;
 b=E0Xls73raxmyCqHOswU5hCPORFnHAWtupp4+LChtlbkDk2mBNgmC0ghuxXOH+1YkN9ZuQ3Okfakxpvw6cKsBQeGkkzXKehH6T1Xl9Qzs9+Rg6l3okgQXIdZpvTwnjBgYzhXYv5wtg2bVOSmgFPi3jtE3+L6XVKlDhnvGmzIbn0UTvMjtn+l4P/XglbkUluJLfxFTHcaLEDj+2NYQgTw5jdfLU6zY8GwTSUCfA+68zUjoS71Vgo5QtWHZiixqrW4uVLlchQ77Y8HsYqOpiTaR3XU8AMNLVpq2EGr92JRt5tkK4dOmXJnqyG/hUizaqTmgpQpHJ7pJ5NF6zwb3YJUYWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwLLbIzKpkj5Nzuz5hX5nMgs4lwsF2ueL6CBNL/IzTE=;
 b=aPY0MSV9PyHbr7LxsfK88YyANplpoH14SVNmuOGAFL4jMUikgOk4Vg4yeCQ+SUc4xyEzIU0LeFadv666wyta1MCeDynmQJkYGYCnV8PXIAR7u6cAs6gfcpGoIqMtHJLQzjRUnKPgD0U7OMBOAB4Bob1UEdyhVPXn/SSlfnlY7jI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2891.namprd12.prod.outlook.com (2603:10b6:5:188::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.27; Wed, 14 Oct 2020 07:18:47 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3455.031; Wed, 14 Oct 2020
 07:18:47 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/5] drm/amd/pm: properly setting GPO feature on UMD pstate
 entering/exiting
Date: Wed, 14 Oct 2020 15:18:12 +0800
Message-Id: <20201014071812.8396-5-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201014071812.8396-1-evan.quan@amd.com>
References: <20201014071812.8396-1-evan.quan@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0302CA0012.apcprd03.prod.outlook.com
 (2603:1096:202::22) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0302CA0012.apcprd03.prod.outlook.com (2603:1096:202::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.11 via Frontend Transport; Wed, 14 Oct 2020 07:18:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 827feb84-acc9-4040-30bc-08d870116403
X-MS-TrafficTypeDiagnostic: DM6PR12MB2891:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2891113E0588550C173448CBE4050@DM6PR12MB2891.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fYa6NkLeZ5TjJRQEEIWFV+4AR2nYjQbmc4F0d0Fwpkm3eRdrOwFCDUvViyK9FaGsfIh6pXLZSEKx/pZqVE40A3tgDcV13O6V3I47tMhpEP+Lf3aybEFQvI1kYa2SiinEICKcpQklITRn3zmheNAPBFRFW82G/5og3XaQVhce3jmUrGA7whTxjpji8DBf7RVOR/vphV6KSGTyNO/K9GM2tPQFaeP+7PpRP8Q5LkyHRNsSrLtiIh0ZFoNttC2S/udvImYBRwx8ZCaEfCLEVO+qufAOWXeER3KWSf0oYJ9Z7YVdLJOzEiY9zr/IPUjptRN1A64Giu4YPln/l0NAkA4ZBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39850400004)(366004)(396003)(376002)(136003)(44832011)(4326008)(7696005)(52116002)(83380400001)(86362001)(66476007)(66556008)(66946007)(6666004)(26005)(16526019)(316002)(5660300002)(8676002)(186003)(8936002)(478600001)(956004)(6916009)(2616005)(2906002)(6486002)(36756003)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ckzIMsYpXa4V0kVhZ4/nONJjS9BobMl9FUBesMjXVXeK4CNooOwjqFls9W8KjeSSyBUqWN965DVzxDp7Y0GXqv0AYKT8fAacnSRqrYfngBGDLrhrKMLN+0zjNtsU3SMCNTuklcVoebJBn2ufkPLBiw7hzwEd9cdmD9PRLAHX9/DH1JHc8piL5dx7HdsXn/WBwjw7/Nr2XogpLIfgGW+WU1jKl4aY7kOQADBQ1BrEvG9b9L9bl3d9J74KkqlZlRqtf3DA28Ys8BpidPCF7VJsIbUWoxMyZ8Dj6NpDvC3rWL68SokMekKl+ngcQF8BLz32QV7lT1BKQ0k1qTP65GHUgYRP2w1Ee24jTrMuG+WhicdKudUX3aRYLoZBOvWCep+OgqOYKZIv6AXM/UGgy0B5+PQmcfor9Wh28kbZaP1R4lPRc+i/MSWwhyIJ3yx8i+XVG9fk2XNiK+SuQIq/pQ1a3bEq4F2xyaSMFshJm0iSh3Bw/lL2EBZ4eAoLmzGFNqbFHLpQ+zBTjZumRX2iprjRkuWEsPyK2O+vTi7AimGL0rISQTviSsPUUPxaIKxiom1eJStcMwTnSPWMSpQYTQkxcKXPMpcO+xF6oz9cH80TBRfri98qrFSH5xtgrxnBRmrqtd4/eq7VCgm6HZJacSQBMA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 827feb84-acc9-4040-30bc-08d870116403
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 07:18:47.0359 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uJ8aN6lncYPB/4JKFwuVLHvcp/xQi8kYPA4KFa7q6ffNZXaEeRzHbz4BSYHV1hmg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2891
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Disable/enable the GPO feature on UMD pstate entering/exiting.

Change-Id: I4bd4b560b945227044df918c9066ffbbc17728ca
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  1 +
 drivers/gpu/drm/amd/pm/inc/smu_types.h        |  1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  2 ++
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 22 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |  1 +
 5 files changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index f21d8dcac9ae..32f3738a6a6f 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -574,6 +574,7 @@ struct pptable_funcs {
 	int (*get_fan_parameters)(struct smu_context *smu);
 	int (*post_init)(struct smu_context *smu);
 	void (*interrupt_work)(struct smu_context *smu);
+	int (*gpo_control)(struct smu_context *smu, bool enablement);
 };
 
 typedef enum {
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/amd/pm/inc/smu_types.h
index b1a18fbb7682..f6403881f265 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_types.h
@@ -184,6 +184,7 @@
 	__SMU_DUMMY_MAP(SetSoftMinSocclkByFreq),         \
 	__SMU_DUMMY_MAP(PowerUpCvip),                    \
 	__SMU_DUMMY_MAP(PowerDownCvip),                  \
+	__SMU_DUMMY_MAP(SetGpoFeaturePMask),             \
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 92869eb297d8..18e0db34a3ee 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1407,6 +1407,7 @@ static int smu_enable_umd_pstate(void *handle,
 		if (*level & profile_mode_mask) {
 			smu_dpm_ctx->saved_dpm_level = smu_dpm_ctx->dpm_level;
 			smu_dpm_ctx->enable_umd_pstate = true;
+			smu_gpo_control(smu, false);
 			amdgpu_device_ip_set_powergating_state(smu->adev,
 							       AMD_IP_BLOCK_TYPE_GFX,
 							       AMD_PG_STATE_UNGATE);
@@ -1432,6 +1433,7 @@ static int smu_enable_umd_pstate(void *handle,
 			amdgpu_device_ip_set_powergating_state(smu->adev,
 							       AMD_IP_BLOCK_TYPE_GFX,
 							       AMD_PG_STATE_GATE);
+			smu_gpo_control(smu, true);
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index c27806fd07e0..71cb000306a4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -127,6 +127,7 @@ static struct cmn2asic_msg_mapping sienna_cichlid_message_map[SMU_MSG_MAX_COUNT]
 	MSG_MAP(ArmD3,				PPSMC_MSG_ArmD3,                       0),
 	MSG_MAP(Mode1Reset,                     PPSMC_MSG_Mode1Reset,		       0),
 	MSG_MAP(SetMGpuFanBoostLimitRpm,	PPSMC_MSG_SetMGpuFanBoostLimitRpm,     0),
+	MSG_MAP(SetGpoFeaturePMask,		PPSMC_MSG_SetGpoFeaturePMask,          0),
 };
 
 static struct cmn2asic_mapping sienna_cichlid_clk_map[SMU_CLK_COUNT] = {
@@ -2714,6 +2715,26 @@ static int sienna_cichlid_enable_mgpu_fan_boost(struct smu_context *smu)
 					       NULL);
 }
 
+static int sienna_cichlid_gpo_control(struct smu_context *smu,
+				      bool enablement)
+{
+	int ret = 0;
+
+	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_GFX_GPO_BIT)) {
+		if (enablement)
+			ret = smu_cmn_send_smc_msg_with_param(smu,
+							SMU_MSG_SetGpoFeaturePMask,
+							GFX_GPO_PACE_MASK | GFX_GPO_DEM_MASK,
+							NULL);
+		else
+			ret = smu_cmn_send_smc_msg_with_param(smu,
+							SMU_MSG_SetGpoFeaturePMask,
+							0,
+							NULL);
+	}
+
+	return ret;
+}
 static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.get_allowed_feature_mask = sienna_cichlid_get_allowed_feature_mask,
 	.set_default_dpm_table = sienna_cichlid_set_default_dpm_table,
@@ -2795,6 +2816,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.deep_sleep_control = smu_v11_0_deep_sleep_control,
 	.get_fan_parameters = sienna_cichlid_get_fan_parameters,
 	.interrupt_work = smu_v11_0_interrupt_work,
+	.gpo_control = sienna_cichlid_gpo_control,
 };
 
 void sienna_cichlid_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
index c7e1fe5f442d..f7be2d1a0ff2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
@@ -89,6 +89,7 @@
 #define smu_deep_sleep_control(smu, enablement)				smu_ppt_funcs(deep_sleep_control, 0, smu, enablement)
 #define smu_get_fan_parameters(smu)					smu_ppt_funcs(get_fan_parameters, 0, smu)
 #define smu_post_init(smu)						smu_ppt_funcs(post_init, 0, smu)
+#define smu_gpo_control(smu, enablement)				smu_ppt_funcs(gpo_control, 0, smu, enablement)
 
 #endif
 #endif
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
