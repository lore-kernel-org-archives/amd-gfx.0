Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B133BC433E2
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 14:17:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86EA620748
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 14:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="w52/65nF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86EA620748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C3F96EC5A;
	Fri, 10 Jul 2020 14:17:04 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79E7F6EC55
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 14:17:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWZyZKJWqFD1IOGn5jOnsu+87W/zsBF1VdoyGdlQDE6mcsZvfRbFdyoA+tZCk+n85zOy6KONjXiCmRfSkEPv/jr1rtW++ljY4rzJVrbTs+nyK1K00jVTSe+RhWEClHULnVuqYV9VAVvYvgk/WZO9PFMTgzYW2axjxLlu0T04zViFAQQtePJH6yqAxhee9h/wTfWhtg/K63CkE5QFemEvZl5oI7Hw3TNmzuJwHXk3xhh8T/2yA5nAqjghqrHit9SKWBLCQiUt7Cq9rhbjAwI/BYH4VQpA/9R6jyrDHDIO5Dwo+CqGZE6Ls1o1pTp2BrLRUdHGqk9RBIBG4AmarZ/H3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZFxvqbeiYXY7gBY2//9MkOhCafIXtDBGq14bij3IVNQ=;
 b=BWX4AkW173aVPuUb1o/OMmAqeruYbGoUX8ktP6NGa9CGnqFIzCtFwjYvYR2G7nJpr0PgiFzpoma7qFlFxqehNjieieV33gjdNJp0aNR2GWy3qh0cg0i5GUV7wv7Tikomdn1SLYkMUpIMutZZ2j/hytfXo4xW5XEnXjsSQJLAY6T+ih47MmDfLQrAEmTFDOQ9kEhBwJejZRFg5a+k2n93bSxS7y0uGa4jBcyBwwZmp/ABc/EkB4zaDvrRpMg/udTxiB00V1TVSPKSNVbngaVoV0UdvGnKeKHZtia0hg7w0I+lXxJ7oCAWOVv9ZNnq1WRtHXRLzZiJSQLr9Vt1Yy6u1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZFxvqbeiYXY7gBY2//9MkOhCafIXtDBGq14bij3IVNQ=;
 b=w52/65nFtnFyIGEC4n591M3wT+xpL4aeBhEYCN8/xv7mTU0Kd+VsDnv/eh4g3Q5hWs1fy7X7avMCc47x6PJ61F6ivrY9u3FLzBkpSkcuKaKyLva/95TJYphk20aEvhyeClis6+TxtX8JSTkCABSZ7bDvjLpp2r5dWkX5GaZUJBI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 by CH2PR12MB3831.namprd12.prod.outlook.com (2603:10b6:610:29::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Fri, 10 Jul
 2020 14:17:00 +0000
Received: from CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d]) by CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d%8]) with mapi id 15.20.3174.021; Fri, 10 Jul 2020
 14:17:00 +0000
From: Wenhui Sheng <Wenhui.Sheng@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amd/powerplay: add SMU mode1 reset
Date: Fri, 10 Jul 2020 22:16:42 +0800
Message-Id: <20200710141644.1601-1-Wenhui.Sheng@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR04CA0063.apcprd04.prod.outlook.com
 (2603:1096:202:14::31) To CH2PR12MB4101.namprd12.prod.outlook.com
 (2603:10b6:610:a8::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from HUI.amd.com (58.247.170.242) by
 HK2PR04CA0063.apcprd04.prod.outlook.com (2603:1096:202:14::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21 via Frontend Transport; Fri, 10 Jul 2020 14:16:58 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f28634cb-01ef-483e-0d73-08d824dbe934
X-MS-TrafficTypeDiagnostic: CH2PR12MB3831:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3831650821EF37749BD49A7B8C650@CH2PR12MB3831.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:632;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KNuovmqa7r9t/U3qGWIveVgzK6s4mqvFR+9+ZgIej7NdlrL/Sxw4gc3O8tnw6krkzTTEgBTIJHtOoFPZY8w0Fx/c7Pf3QKyMPPczrKDtIBAYcqLoMwFd+MTOLQh2hgx107HGnYYy65T+a6DXbqniSPIBd8qjhhmy56yk4Bs0QUCypEj9Mz1FetWZt3jgCBSHHMbizIbk2eZ2fDywJdevQxRMmrRQdxRszDMKggFOtJIcRNRPCyc+d8KILkM9wQ4cIVbMbj9p9kTngfr1Yl5+NV2jjWkxLrAtnywI0mhrz79IzirVD+d4+9Sh5flfYCFS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(86362001)(6666004)(6916009)(1076003)(83380400001)(66476007)(8936002)(66556008)(52116002)(7696005)(6486002)(66946007)(2906002)(478600001)(54906003)(36756003)(316002)(5660300002)(8676002)(186003)(16526019)(26005)(956004)(4326008)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ziWhVK6V0ZRVUmL2WqOizefH7s1MGih5kuO+eXbYZmMV5e7iXFSkJeOq90KZBPqzKCIxNdk+qg1lOp63GLPAZu9wrnaWRZKQfbAdlICbwIs5jHE2pRw4GApn1e5v1qsVcmSfA2Cxm051tta0HNLFfhZzKJo1Xmcv30yheTNz15/LyThiJRIAqDCCCZJ32kszqfqhbKEv7p8POkiASQBuRcVog6N3IIMA7sNQ6hfyD3eu8Plsz8/ZuBlOhFBcI8OOTOUnR5q0A83fUvktqcJwpKe3h2IdHmdIgMXYt6NWe1Zwppedxxy2p3qXDheMxcQFbIVsC/SnhQhH7hfQZfNR/7uUGaL1qoh32Pkk0h98Pxy1+mqn6ijjwqVniPFGfb2RhJ5+fpbBO7VhlLnYKTUcIqv3g2yni7prnH3/GWsFGH49poBLBWwuUbkmeiLz35XaN77Fzpe9YEAdb9XSKTlorVqVdOAeHZYxXwfBg6Ny51vWefAa/m6pF6yQ3HnWBHqH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f28634cb-01ef-483e-0d73-08d824dbe934
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 14:17:00.4185 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EcxXkQiepbV24taT6Bdht3uZPfxamDRE3z0JM4VetHDMzFBc9WzgNPFHWGVUJvoEtwnkvIgUiyeUdN+1N1NQNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3831
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
Cc: Likun Gao <Likun.Gao@amd.com>, Wenhui Sheng <Wenhui.Sheng@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From PM FW 58.26.0 for sienna cichlid, SMU mode1 reset
is support, driver sends PPSMC_MSG_Mode1Reset message
to PM FW could trigger this reset.

v2: add mode1 reset dpm interface

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c       | 20 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h       |  3 ++
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 34 +++++++++++++++++++
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  4 +++
 drivers/gpu/drm/amd/powerplay/inc/smu_types.h |  1 +
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |  2 ++
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    | 31 +++++++++++++++--
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 13 +++++++
 8 files changed, 105 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
index 65472b3dd815..16668fc52d0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
@@ -1141,6 +1141,26 @@ int amdgpu_dpm_baco_reset(struct amdgpu_device *adev)
 	return 0;
 }
 
+bool amdgpu_dpm_is_mode1_reset_supported(struct amdgpu_device *adev)
+{
+	struct smu_context *smu = &adev->smu;
+
+	if (is_support_sw_smu(adev))
+		return smu_mode1_reset_is_support(smu);
+
+	return false;
+}
+
+int amdgpu_dpm_mode1_reset(struct amdgpu_device *adev)
+{
+	struct smu_context *smu = &adev->smu;
+
+	if (is_support_sw_smu(adev))
+		return smu_mode1_reset(smu);
+
+	return -EOPNOTSUPP;
+}
+
 int amdgpu_dpm_switch_power_profile(struct amdgpu_device *adev,
 				    enum PP_SMC_POWER_PROFILE type,
 				    bool en)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
index 6a8aae70a0e6..7f3cd7185650 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
@@ -529,6 +529,9 @@ int amdgpu_dpm_mode2_reset(struct amdgpu_device *adev);
 
 bool amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev);
 
+bool amdgpu_dpm_is_mode1_reset_supported(struct amdgpu_device *adev);
+int amdgpu_dpm_mode1_reset(struct amdgpu_device *adev);
+
 int amdgpu_dpm_set_mp1_state(struct amdgpu_device *adev,
 			     enum pp_mp1_state mp1_state);
 
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index fe4948aa662f..b5a7422d9548 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -2737,6 +2737,40 @@ int smu_baco_exit(struct smu_context *smu)
 	return ret;
 }
 
+bool smu_mode1_reset_is_support(struct smu_context *smu)
+{
+	bool ret = false;
+
+	if (!smu->pm_enabled)
+		return false;
+
+	mutex_lock(&smu->mutex);
+
+	if (smu->ppt_funcs && smu->ppt_funcs->mode1_reset_is_support)
+		ret = smu->ppt_funcs->mode1_reset_is_support(smu);
+
+	mutex_unlock(&smu->mutex);
+
+	return ret;
+}
+
+int smu_mode1_reset(struct smu_context *smu)
+{
+	int ret = 0;
+
+	if (!smu->pm_enabled)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&smu->mutex);
+
+	if (smu->ppt_funcs->mode1_reset)
+		ret = smu->ppt_funcs->mode1_reset(smu);
+
+	mutex_unlock(&smu->mutex);
+
+	return ret;
+}
+
 int smu_mode2_reset(struct smu_context *smu)
 {
 	int ret = 0;
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 7b349e038972..ba59620950d7 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -561,6 +561,8 @@ struct pptable_funcs {
 	int (*baco_set_state)(struct smu_context *smu, enum smu_baco_state state);
 	int (*baco_enter)(struct smu_context *smu);
 	int (*baco_exit)(struct smu_context *smu);
+	bool (*mode1_reset_is_support)(struct smu_context *smu);
+	int (*mode1_reset)(struct smu_context *smu);
 	int (*mode2_reset)(struct smu_context *smu);
 	int (*get_dpm_ultimate_freq)(struct smu_context *smu, enum smu_clk_type clk_type, uint32_t *min, uint32_t *max);
 	int (*set_soft_freq_limited_range)(struct smu_context *smu, enum smu_clk_type clk_type, uint32_t min, uint32_t max);
@@ -672,6 +674,8 @@ int smu_baco_get_state(struct smu_context *smu, enum smu_baco_state *state);
 int smu_baco_enter(struct smu_context *smu);
 int smu_baco_exit(struct smu_context *smu);
 
+bool smu_mode1_reset_is_support(struct smu_context *smu);
+int smu_mode1_reset(struct smu_context *smu);
 int smu_mode2_reset(struct smu_context *smu);
 
 extern int smu_get_atom_data_table(struct smu_context *smu, uint32_t table,
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_types.h b/drivers/gpu/drm/amd/powerplay/inc/smu_types.h
index dff2295705be..7b585e205a5a 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_types.h
@@ -173,6 +173,7 @@
 	__SMU_DUMMY_MAP(GmiPwrDnControl), \
 	__SMU_DUMMY_MAP(DAL_DISABLE_DUMMY_PSTATE_CHANGE), \
 	__SMU_DUMMY_MAP(DAL_ENABLE_DUMMY_PSTATE_CHANGE), \
+	__SMU_DUMMY_MAP(Mode1Reset), \
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index d07bf4fe6e4a..38599112ae59 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -252,6 +252,8 @@ int smu_v11_0_baco_set_state(struct smu_context *smu, enum smu_baco_state state)
 int smu_v11_0_baco_enter(struct smu_context *smu);
 int smu_v11_0_baco_exit(struct smu_context *smu);
 
+int smu_v11_0_mode1_reset(struct smu_context *smu);
+
 int smu_v11_0_get_dpm_ultimate_freq(struct smu_context *smu, enum smu_clk_type clk_type,
 						 uint32_t *min, uint32_t *max);
 
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index dc5ca9121db5..319480550bb7 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -39,8 +39,8 @@
 #include "nbio/nbio_2_3_sh_mask.h"
 #include "thm/thm_11_0_2_offset.h"
 #include "thm/thm_11_0_2_sh_mask.h"
-
-#include "asic_reg/mp/mp_11_0_sh_mask.h"
+#include "mp/mp_11_0_offset.h"
+#include "mp/mp_11_0_sh_mask.h"
 
 /*
  * DO NOT use these for err/warn/info/debug messages.
@@ -116,6 +116,7 @@ static struct smu_11_0_cmn2aisc_mapping sienna_cichlid_message_map[SMU_MSG_MAX_C
 	MSG_MAP(PowerDownJpeg,			PPSMC_MSG_PowerDownJpeg),
 	MSG_MAP(BacoAudioD3PME,			PPSMC_MSG_BacoAudioD3PME),
 	MSG_MAP(ArmD3,				PPSMC_MSG_ArmD3),
+	MSG_MAP(Mode1Reset,			PPSMC_MSG_Mode1Reset),
 };
 
 static struct smu_11_0_cmn2aisc_mapping sienna_cichlid_clk_map[SMU_CLK_COUNT] = {
@@ -1760,13 +1761,35 @@ static bool sienna_cichlid_is_baco_supported(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t val;
 
-	if (!smu_v11_0_baco_is_support(smu))
+	if (amdgpu_sriov_vf(adev) || (!smu_v11_0_baco_is_support(smu)))
 		return false;
 
 	val = RREG32_SOC15(NBIO, 0, mmRCC_BIF_STRAP0);
 	return (val & RCC_BIF_STRAP0__STRAP_PX_CAPABLE_MASK) ? true : false;
 }
 
+static bool sienna_cichlid_is_mode1_reset_supported(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t val;
+	u32 smu_version;
+
+	/**
+	 * SRIOV env will not support SMU mode1 reset
+	 * PM FW support mode1 reset from 58.26
+	 */
+	smu_get_smc_version(smu, NULL, &smu_version);
+	if (amdgpu_sriov_vf(adev) || (smu_version < 0x003a1a00))
+		return false;
+
+	/**
+	 * mode1 reset relies on PSP, so we should check if
+	 * PSP is alive.
+	 */
+	val = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81);
+	return val != 0x0;
+}
+
 static int sienna_cichlid_set_thermal_range(struct smu_context *smu,
 				       struct smu_temperature_range range)
 {
@@ -2538,6 +2561,8 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.baco_set_state = smu_v11_0_baco_set_state,
 	.baco_enter = smu_v11_0_baco_enter,
 	.baco_exit = smu_v11_0_baco_exit,
+	.mode1_reset_is_support = sienna_cichlid_is_mode1_reset_supported,
+	.mode1_reset = smu_v11_0_mode1_reset,
 	.get_dpm_ultimate_freq = sienna_cichlid_get_dpm_ultimate_freq,
 	.set_soft_freq_limited_range = sienna_cichlid_set_soft_freq_limited_range,
 	.override_pcie_parameters = smu_v11_0_override_pcie_parameters,
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 48e15885e9c3..c620dccb82e5 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -63,6 +63,8 @@ MODULE_FIRMWARE("amdgpu/sienna_cichlid_smc.bin");
 
 #define SMU11_VOLTAGE_SCALE 4
 
+#define SMU11_MODE1_RESET_WAIT_TIME 500  //500ms
+
 static int smu_v11_0_send_msg_without_waiting(struct smu_context *smu,
 					      uint16_t msg)
 {
@@ -1741,6 +1743,17 @@ int smu_v11_0_baco_exit(struct smu_context *smu)
 	return ret;
 }
 
+int smu_v11_0_mode1_reset(struct smu_context *smu)
+{
+	int ret = 0;
+
+	ret = smu_send_smc_msg(smu, SMU_MSG_Mode1Reset, NULL);
+	if (!ret)
+		msleep(SMU11_MODE1_RESET_WAIT_TIME);
+
+	return ret;
+}
+
 int smu_v11_0_get_dpm_ultimate_freq(struct smu_context *smu, enum smu_clk_type clk_type,
 						 uint32_t *min, uint32_t *max)
 {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
