Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D1EC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 07:52:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAA1C10E9FE;
	Fri, 11 Feb 2022 07:52:44 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2050.outbound.protection.outlook.com [40.107.100.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 192E710E9FE
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 07:52:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frIeZj0cgnXgJy9MFYdv+CcrrPju2BOdpvVwKEP2b+AzlkR3GcfufDwpOLp+/rpWR017gG9d5AxXJkeYevgWmmrPwyk9dUr42VuE8BDEdG+t6/bRBn1jUetf3K95QNXibKUBlGHZpXiTtr5nsWcZJNr654s9SMcBYQ2v+f3ucnttKG/ymNRvddd9Am/jPbqO7g+NpT+woHMudHiiRcmDVuU1BQsoEu/WsQRLGhviNYtJahsOGHn/1ktfoFtHxhDeIrpRMLMoknrBAK5ax8i6LSrSdrip5t76tcmPZtrQ3tVmOdTu+PWXk04FUsAkvBoOcUPcu6yuLB6Eb4b5OYXSMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJy4MHV8jiwNHwB+h+n7lsfTVeqABFaGEj+Z7cVDKjk=;
 b=ZZwJ8ialM4h5un7fBtZOV7vIXLcLWJmux+Wru9t8MZ5yzGEVJl8vMIcdEQciPKoPb9ta0uc8RuVYzBb7hhcQUsQT+DyEf2vbl2CDIXaG3hWW/u5ZMmaDxwGSchfwxmZhfwOvKjPW7b9thjpcJBI4mzurtdVwCncnmh2B/LLj1a/rHDD/z+RwQyQM9N2kD0kmgC0fGtaNCKMqJuUuEVw9uVWLKwLqwbg4/MbKMZoZ7IUEAAWYt5IIVuCBY6GxR7GZGohRuwuv3a/dRbVkRVx2MiXhEcnjWehub2L976u4hpejTg+0F8Gy1xByGH/xpGegDFPXZtC7sCbdTeudF6zggw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJy4MHV8jiwNHwB+h+n7lsfTVeqABFaGEj+Z7cVDKjk=;
 b=dEvsKbmWNQkylnQtaLObBV+r9/f/mxUyrX8bLb0uv3R49l3bQNE0x1SDvTp/UENd5YkSkEOg/94ST6RqYcDECmBXtynEal3HfIs/IJnYroGjASanoOZMIKLkKuV4mcOFXlCFCmfITbZnVDAq7OjeQwE4CBiednI3L+xwIlSoq7M=
Received: from DM5PR21CA0033.namprd21.prod.outlook.com (2603:10b6:3:ed::19) by
 MN2PR12MB4566.namprd12.prod.outlook.com (2603:10b6:208:26a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Fri, 11 Feb
 2022 07:52:40 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ed:cafe::ea) by DM5PR21CA0033.outlook.office365.com
 (2603:10b6:3:ed::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.8 via Frontend
 Transport; Fri, 11 Feb 2022 07:52:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 07:52:40 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 11 Feb
 2022 01:52:37 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/12] drm/amd/pm: drop unused interfaces
Date: Fri, 11 Feb 2022 15:51:59 +0800
Message-ID: <20220211075209.894833-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220211075209.894833-1-evan.quan@amd.com>
References: <20220211075209.894833-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8e439a0-0a57-4f60-83fd-08d9ed337a9f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4566:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB45665CC07AC0884F08EE1244E4309@MN2PR12MB4566.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bz+A5/sC/GMJfuvh7H+h7tPKD69JR6/2nwsGQBnT7ZYjRx4hJ1wzNb1YbdqQ7qNJDafHyEvMbfJBAKNrX9ozM7w0MbtumEWGmxB6uJL1zdAU6Sru/hxDkM0Mp2SN7zKl3T02y5ZTkkirHYAogXAWWfLBJCNKWhrqgYDARjjFMMJOTq0sCX+kSdG/no/VZrOOXOL/6z+NopFRgxizsAu8Bg/RGh5q97EqNjwijkmTmStXzjDE28Y+arnqKXuxvrx4+7Ko8R70jnbq/38MxWk8iB6TDGfCVJR3hVRsrl62ZIe9JwXOq/RWFDx90pVjcxIDlBZrEEH6jyE83cJHwdFnq0NBvMwG8fZpCsDtabAjSp4XF907HQug8yN59XwU7NeLFwc0t64mX9k39KOCNveTkl5gtfestszuqeYwjz8oCY5/jCZo5GEZyQ+oLXt8fflROpZ1ivBKs7zBhvbvfpcg0h5PhvLyO6ktS9R0RfM4OMCIIme87pmx2qtQ6RhOEtu6HPFB/xkYztSmGZSRQ3ydOzFeVT+5UvKcKoMND98dNseK53xcf6eDf0UPZ9GozQnYwUV+cIjFkdyhmtcsnz9DiD9YZyyXKq5O/MYEQogT3mQaJ29Rw4mUy4SsVvF9b5GyLmKMj8RYk2bPlKSs3sHvnUVfBE9vtP16d/4l2gNW4+GVhbt8S1NMiDDzK9hxJOfhPBmeGDew3leojEnS3s4Neg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(5660300002)(336012)(426003)(2616005)(508600001)(8936002)(83380400001)(1076003)(6666004)(36756003)(16526019)(186003)(26005)(7696005)(2906002)(40460700003)(36860700001)(86362001)(82310400004)(47076005)(44832011)(356005)(6916009)(54906003)(316002)(8676002)(4326008)(70586007)(81166007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 07:52:40.5087 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e439a0-0a57-4f60-83fd-08d9ed337a9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4566
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>, rui.huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Drop those interfaces which never get used.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Ia22d395145a1003faca5ac792dca6a30ef2cae54
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 13 ---------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  5 ----
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |  4 ---
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  6 -----
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 27 -------------------
 5 files changed, 55 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 6535cf336fa5..1c3a5ccd100c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2686,19 +2686,6 @@ bool smu_mode1_reset_is_support(struct smu_context *smu)
 	return ret;
 }
 
-bool smu_mode2_reset_is_support(struct smu_context *smu)
-{
-	bool ret = false;
-
-	if (!smu->pm_enabled)
-		return false;
-
-	if (smu->ppt_funcs && smu->ppt_funcs->mode2_reset_is_support)
-		ret = smu->ppt_funcs->mode2_reset_is_support(smu);
-
-	return ret;
-}
-
 int smu_mode1_reset(struct smu_context *smu)
 {
 	int ret = 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index fb32846a2d0e..39d169440d15 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1143,10 +1143,6 @@ struct pptable_funcs {
 	 * @mode1_reset_is_support: Check if GPU supports mode1 reset.
 	 */
 	bool (*mode1_reset_is_support)(struct smu_context *smu);
-	/**
-	 * @mode2_reset_is_support: Check if GPU supports mode2 reset.
-	 */
-	bool (*mode2_reset_is_support)(struct smu_context *smu);
 
 	/**
 	 * @mode1_reset: Perform mode1 reset.
@@ -1397,7 +1393,6 @@ int smu_get_power_limit(void *handle,
 			enum pp_power_type pp_power_type);
 
 bool smu_mode1_reset_is_support(struct smu_context *smu);
-bool smu_mode2_reset_is_support(struct smu_context *smu);
 int smu_mode1_reset(struct smu_context *smu);
 
 extern const struct amd_ip_funcs smu_ip_funcs;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index 44af23ae059e..10f41cab796e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -156,12 +156,8 @@ int smu_v13_0_notify_memory_pool_location(struct smu_context *smu);
 int smu_v13_0_system_features_control(struct smu_context *smu,
 				      bool en);
 
-int smu_v13_0_init_display_count(struct smu_context *smu, uint32_t count);
-
 int smu_v13_0_set_allowed_mask(struct smu_context *smu);
 
-int smu_v13_0_notify_display_change(struct smu_context *smu);
-
 int smu_v13_0_get_current_power_limit(struct smu_context *smu,
 				      uint32_t *power_limit);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 890acc4e2cb8..d7e619728e60 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1967,11 +1967,6 @@ static bool aldebaran_is_mode1_reset_supported(struct smu_context *smu)
 	return true;
 }
 
-static bool aldebaran_is_mode2_reset_supported(struct smu_context *smu)
-{
-	return true;
-}
-
 static int aldebaran_set_mp1_state(struct smu_context *smu,
 				   enum pp_mp1_state mp1_state)
 {
@@ -2052,7 +2047,6 @@ static const struct pptable_funcs aldebaran_ppt_funcs = {
 	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
 	.get_gpu_metrics = aldebaran_get_gpu_metrics,
 	.mode1_reset_is_support = aldebaran_is_mode1_reset_supported,
-	.mode2_reset_is_support = aldebaran_is_mode2_reset_supported,
 	.smu_handle_passthrough_sbr = aldebaran_smu_handle_passthrough_sbr,
 	.mode1_reset = aldebaran_mode1_reset,
 	.set_mp1_state = aldebaran_set_mp1_state,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index f0ab1dc3ca59..b4fd148754ac 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -703,19 +703,6 @@ int smu_v13_0_set_tool_table_location(struct smu_context *smu)
 	return ret;
 }
 
-int smu_v13_0_init_display_count(struct smu_context *smu, uint32_t count)
-{
-	int ret = 0;
-
-	if (!smu->pm_enabled)
-		return ret;
-
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_NumOfDisplays, count, NULL);
-
-	return ret;
-}
-
-
 int smu_v13_0_set_allowed_mask(struct smu_context *smu)
 {
 	struct smu_feature *feature = &smu->smu_feature;
@@ -768,20 +755,6 @@ int smu_v13_0_system_features_control(struct smu_context *smu,
 					  SMU_MSG_DisableAllSmuFeatures), NULL);
 }
 
-int smu_v13_0_notify_display_change(struct smu_context *smu)
-{
-	int ret = 0;
-
-	if (!smu->pm_enabled)
-		return ret;
-
-	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT) &&
-	    smu->adev->gmc.vram_type == AMDGPU_VRAM_TYPE_HBM)
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetUclkFastSwitch, 1, NULL);
-
-	return ret;
-}
-
 	static int
 smu_v13_0_get_max_sustainable_clock(struct smu_context *smu, uint32_t *clock,
 				    enum smu_clk_type clock_select)
-- 
2.29.0

