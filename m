Return-Path: <SRS0=gI7v=7R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143E1C433DF
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 04:47:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDD772072E
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 04:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AljqIpkl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDD772072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A887B6E199;
	Thu,  4 Jun 2020 04:47:21 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65A776E1A4
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2020 04:47:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhhfarxNESqKtrvtXJ6wjziEC9vbW5OFeMjOWFOZJQagrm/2j/dyeHcPIawcSLxZo8j18uEBVfivirLNlsayr2eFkx3BFwLj1oZegJ0RCtxfAu4CWrZP2ER4K/dtmpO+3+G2GuIxUyGDRmZh2ZzYjCHfgVJTnonFXmRt10s9TYrB4/Gul4Z9VyioGtjehaGCSkUwHJfYUixX+P6jWigem4aJD6PN3jsLuY0dF+nisx23JucS3Wxxzoy9zFDQJDFP38oAHSZ5/SjgxkGYkMWF+1rTNqCVSb3vO2+VLrptvJSadOcJoDibcs9x+IhVywo8BNas+D9Ijzdc3GMlcETz5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdGcbS8UCsdTXE6Qeb41qouiqwiUt7/JERRfdH/qE9s=;
 b=MeSZ0yuCaPyiBPANGMPVuxBTTJKDAxanTH+4MnZorTwPTh4mxjN1Y8AXCtwWQN5woClTJfV/CLBeDcO5DisOog/lF0z/WqRFu6EcOVyCy8d4UhFfNryLTYGMH99oAvCNlj3jCYpe2P9TB4BM07TcCaCE4AY28wKzuowXuzbQnarutfAnl2NjDp6YSc3sGwYEDQM83R8GuTdG63rByPbNr8d0/ISfrFgN+QIXId/u+5wuVvfRQn5WV414Ite/Hkj0rtNayGLrRItrF1nf63/D+KfzquNnngxTciDZHMVXqEYJLWEvSM7rMqHBSUKh4r2EEh3DrmJ+pQP5/R/bhSpu9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdGcbS8UCsdTXE6Qeb41qouiqwiUt7/JERRfdH/qE9s=;
 b=AljqIpklipCK+i2WpGnWAg4KqsJWQ3F0srJu6Etep3AEH75rdlcBjXHED0JPFvZZ+m6g+V5x4o2/cR+m2sGnfZ5yom6nGsRjpEKEW/zrKcmcGP0FNDZlQfH3arvIFfayrDqM1VHKWjxDUiIOIO+pqglNAYcC11tVwDn9bIwaaY4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3212.namprd12.prod.outlook.com (2603:10b6:5:186::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19; Thu, 4 Jun 2020 04:47:18 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3045.022; Thu, 4 Jun 2020
 04:47:18 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 15/16] drm/amd/powerplay: add firmware cleanup on sw_fini
Date: Thu,  4 Jun 2020 12:46:18 +0800
Message-Id: <20200604044619.18658-15-evan.quan@amd.com>
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
 Transport; Thu, 4 Jun 2020 04:47:17 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 15a6a16b-2827-42ef-6abd-08d808425c39
X-MS-TrafficTypeDiagnostic: DM6PR12MB3212:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3212E2064B0556F5C3DECE2EE4890@DM6PR12MB3212.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:53;
X-Forefront-PRVS: 04244E0DC5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zg5vX1/usyLFM0KR7xXIJkyYQOVvPU/SGO+R29hhSmsMx302EhBXPrJTik20J5L0XqUpGGxs2P2Fz0GqImPEctP8PWMTRmvqGdjlNdxu9lbm2CgEhpc8VKcK4O/s3AeAizb0hnA3ivZKFTp+MsvCgxblG6Fk0dxrR9K2kluKkHak+4kxQy3+pAmMAHoLcJwjI8UC0XVIF/5ApwPDVT7zLcL+7HXH93Bnouu5xdYB9q5xtg3yK9VeHWFdRUIIV75mw91jqTWFgycg+RUaO9PIsBPJ70B1SSmFxbDtbVrgilZWn6H2egzykM3vhioGVXAY1ECtO3NqrD2LuyJ16/zSbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(8936002)(8676002)(316002)(2906002)(6916009)(956004)(186003)(66556008)(1076003)(6486002)(16526019)(478600001)(52116002)(7696005)(4326008)(83380400001)(36756003)(2616005)(66476007)(66946007)(5660300002)(86362001)(26005)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 7SF2tX1VnDVGulLRtmXZA1Io9NfunhKXltG60NeElU9qbl4XU6KSf6DZOaCw584u6O717pfAEACSAttMzOrimHzGBVZG6lCqn/R5inRjw3+DzAgK26UwsS3G2FX1J3ko2qlKu4AAykmKu/0KzzUvKV8aR512agTZonSWrCTgfJQGTDe6Sx9DSHTyJKJjVLbrJjLETW6BTMLmOu32s2IEoriWZ3rhvV2+cUJGBqFHTZKYANtE6B9COEQyxcgmT1l2b7XnJuQGPImuxl/JA5wv5XYEI973/kGLa7OKVQfEBczq5VR4iEq6BQrccVSg0iJFMoW2bnx8O2jn2ythz3/XvQCY73RBJH58Q0w5BhIB7tICFRTf63MZVg8cKnGm75CpANNVTK/YOj1UCCi2Zlfm8Vv5BJNg4YTfMVE/2eiNIcgTRhE+RGcS6Hdh+LuOIWfpwUgfwkxUw9M8wtytQgS7V8XWnG7KDcj8t/s8ab6oiqZ4+VeSp5lt0KRVWhzse8zK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a6a16b-2827-42ef-6abd-08d808425c39
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2020 04:47:18.2744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d/SQ54cRvdYyzXDre16hm4YIAWnBfxhNIHIG12EgIBPBC0IBSWj3BX34sJX1KZTS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3212
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

To avoid possible memory leak.

Change-Id: I4740eac7fc2c6e934ec8f503e5a98057f0902f4a
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c     | 2 ++
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c   | 1 +
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h | 1 +
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h  | 2 ++
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c     | 1 +
 drivers/gpu/drm/amd/powerplay/smu_internal.h   | 2 ++
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c      | 9 +++++++++
 7 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 23eb64ae7432..d9a9d9723be1 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1108,6 +1108,8 @@ static int smu_sw_fini(void *handle)
 		return ret;
 	}
 
+	smu_fini_microcode(smu);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 9eb57bec27e1..05abfdedcf37 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -2469,6 +2469,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.get_unique_id = arcturus_get_unique_id,
 	.init_microcode = smu_v11_0_init_microcode,
 	.load_microcode = smu_v11_0_load_microcode,
+	.fini_microcode = smu_v11_0_fini_microcode,
 	.init_smc_tables = smu_v11_0_init_smc_tables,
 	.fini_smc_tables = smu_v11_0_fini_smc_tables,
 	.init_power = smu_v11_0_init_power,
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 90bb61c159fb..c0e761d4b31a 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -496,6 +496,7 @@ struct pptable_funcs {
 	int (*get_dpm_clock_table)(struct smu_context *smu, struct dpm_clocks *clock_table);
 	int (*init_microcode)(struct smu_context *smu);
 	int (*load_microcode)(struct smu_context *smu);
+	void (*fini_microcode)(struct smu_context *smu);
 	int (*init_smc_tables)(struct smu_context *smu);
 	int (*fini_smc_tables)(struct smu_context *smu);
 	int (*init_power)(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index c442fc992d2e..91fe6f9b4c98 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -146,6 +146,8 @@ enum smu_v11_0_baco_seq {
 
 int smu_v11_0_init_microcode(struct smu_context *smu);
 
+void smu_v11_0_fini_microcode(struct smu_context *smu);
+
 int smu_v11_0_load_microcode(struct smu_context *smu);
 
 int smu_v11_0_init_smc_tables(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 4c1c4af2249b..8dd916a8e8f8 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -2310,6 +2310,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.update_pcie_parameters = navi10_update_pcie_parameters,
 	.init_microcode = smu_v11_0_init_microcode,
 	.load_microcode = smu_v11_0_load_microcode,
+	.fini_microcode = smu_v11_0_fini_microcode,
 	.init_smc_tables = smu_v11_0_init_smc_tables,
 	.fini_smc_tables = smu_v11_0_fini_smc_tables,
 	.init_power = smu_v11_0_init_power,
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index 9dce366a6f5f..927d75ff1ac9 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -27,6 +27,8 @@
 
 #define smu_init_microcode(smu) \
 	((smu)->ppt_funcs->init_microcode ? (smu)->ppt_funcs->init_microcode((smu)) : 0)
+#define smu_fini_microcode(smu) \
+	((smu)->ppt_funcs->fini_microcode ? (smu)->ppt_funcs->fini_microcode((smu)) : 0)
 #define smu_init_smc_tables(smu) \
 	((smu)->ppt_funcs->init_smc_tables ? (smu)->ppt_funcs->init_smc_tables((smu)) : 0)
 #define smu_fini_smc_tables(smu) \
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 6c53488acd68..87132a58c985 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -199,6 +199,15 @@ int smu_v11_0_init_microcode(struct smu_context *smu)
 	return err;
 }
 
+void smu_v11_0_fini_microcode(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	release_firmware(adev->pm.fw);
+	adev->pm.fw = NULL;
+	adev->pm.fw_version = 0;
+}
+
 int smu_v11_0_load_microcode(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
