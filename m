Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A765C43334
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jun 2022 11:33:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73327113DBD;
	Thu,  9 Jun 2022 11:33:44 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 363E310FF54
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jun 2022 11:33:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mlci2sZ7tFt/Ec6LW3tNvDHp7tbHrQ7LKftWvF3iRphke7C0SRnI+sGR23YefL5FjINsp7OJovSTyulnbuzsQhBR347Mq6M4U7N5IAZCckmOaQbaHFDQweUe4fxzXx4a7Ey/gjjBt669yyWCPI66R7edU2KWqXkuG7OSvGDvc1wikuePXBS2h8ol1wjFP41U3VgWsDmcsHuGUA8MJglo3RsU3XSrcux1n3a5UcjXTu7TcY0v69/4QJxwY7w/qpHePPFFSH5k21pAqwz1KPLK6PzxTZ5aF6Jy18jl8WZkE9s/3EsREVIPCFtugStyl+ZMU5qsISLCq6pZ2WzkbWh4UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FJqFDXmCy4Iiwe8Q/zfvhtObL1iVKL/xw/pVBEPhTc=;
 b=UgjlOPXIWcU8mrKO57K475E8fMNdIFFMWZ3cpqeeen9/UYr7iILF3yuepSmoINIoWp/YZ9p+BrED66gikbLEviWKLMtBMyWjoFBn6Al5lgqsfVAOWIFe2L2BjBRfxelQMCEJycZMxsHVWPGfzoVzKroQG4ZPSP0Z6tvqkbtRTSsZQdDMaP9Q67YusWQFKVEOETJjrL+qQXqCpDcyC1rpQMtllJEd7H4yrOuO/HwAjS46v/2pGDseP2dNs1wN8N8G5XkNw7f5rMCoRkMGhqnnrkYwxY3TKCXz2FsJAixJbgGkfwMiNKyAZz00Irv5BP8Xhhq5lMaj+vsZpyuhF/Breg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FJqFDXmCy4Iiwe8Q/zfvhtObL1iVKL/xw/pVBEPhTc=;
 b=OZ5Qvuzw90E+juTU3O3gR95QbyzZgFWluZ8aUQ9qMLXUOLFXRrsxVTiSyFNfo78uaZGyM6JrAILgBPkv8VR9D2uWJpJ3xUDaiZhPtblLd3iH7y8PwUUrPlzppYK8WU9RHOeqwju5cZ48tz1NAxDZoDsjNv8VC0+QFnxJaztcUFg=
Received: from BN6PR12CA0034.namprd12.prod.outlook.com (2603:10b6:405:70::20)
 by BN6PR12MB1618.namprd12.prod.outlook.com (2603:10b6:405:b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Thu, 9 Jun
 2022 11:33:40 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:70:cafe::12) by BN6PR12CA0034.outlook.office365.com
 (2603:10b6:405:70::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13 via Frontend
 Transport; Thu, 9 Jun 2022 11:33:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Thu, 9 Jun 2022 11:33:40 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 9 Jun
 2022 06:33:09 -0500
From: Yang Wang <KevinYang.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: fix driver reload SMC firmware fail issue for
 smu13
Date: Thu, 9 Jun 2022 19:32:55 +0800
Message-ID: <20220609113255.2124596-1-KevinYang.Wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea73a6b2-d4df-48cc-86be-08da4a0be6f9
X-MS-TrafficTypeDiagnostic: BN6PR12MB1618:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1618CDED3811BE73506B251482A79@BN6PR12MB1618.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 450PqpU2hLBsM54Q2uUIFloQ0XVk4m/OembaxoBSFA3rhNoyQiGftvFZSr51/Gy6sLs/9ewNVUJkXm2wDB5isJCwziVO2q9PcZ62BcgMfgfFB5hk6Lb2wdKgUvkyRCjbt8tmEB12HHm0ES46Dvt5+osRHNM/B5abBHgid46c1zmvHoLKBm3C9k/E/ORLMk5pV3WaBChtNYn9CdYwsp8oOwrMikaxn6skLqfg6fKoj7hl/peceiOQMisesqotrY9pIQl2HkKf8iidGl2GTiGBOmwml/y5+stuwWPIU9/uGpMlI3Hgfua5BHOqP+ADZIz/+YEzodBgbBtyZfaRMThCEFwOVXOOzc56WC/z3mthlpVvT8rTaEFAq7Z/ITBAJN2gVm5HfWIf+n8p0wRTTLad6Z9/fzdTE+XifaH65iQOx3wAE0736AkRQKDrHvXDhaxy44qNQZjpt7i8rDz4NorOSvJbJ6J4jigx5XkvHh4rbzRoeT377W3lmNvjvw6qOzI4x5076UjYTfVyXUB3yEgBPsJ7M2NPnQgAJDr2L2QJsjSceEkR9dFDx/yAE/M5NBrnuti85robuggTfRLVnGXKJvKnX6R+19iURJS5a9GDZ+Fx0Rs8VJ2rHsgrJISJkjwOumWo7RU07AM5ixoh15qIBHIAczHOQ3And9vAVTg3/HhjuRdZz8LyNUMLYgvBkjdMSq3aBvNcbacuT9L6EPQKsg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(83380400001)(8936002)(6666004)(6916009)(316002)(16526019)(70206006)(82310400005)(70586007)(7696005)(8676002)(336012)(426003)(47076005)(4326008)(40460700003)(26005)(86362001)(356005)(508600001)(36756003)(1076003)(81166007)(54906003)(186003)(19627235002)(2906002)(2616005)(5660300002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 11:33:40.5929 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea73a6b2-d4df-48cc-86be-08da4a0be6f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1618
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
Cc: kenneth.feng@amd.com, Yang Wang <KevinYang.Wang@amd.com>,
 hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

issue calltrace:
[  402.773695] [drm] failed to load ucode SMC(0x2C)
[  402.773754] [drm] psp gfx command LOAD_IP_FW(0x6) failed and response status is (0x0)
[  402.773762] [drm:psp_load_smu_fw [amdgpu]] *ERROR* PSP load smu failed!
[  402.966758] [drm:psp_v13_0_ring_destroy [amdgpu]] *ERROR* Fail to stop psp ring
[  402.966949] [drm:psp_hw_init [amdgpu]] *ERROR* PSP firmware loading failed                                                                                                                                                                   [  402.967116] [drm:amdgpu_device_fw_loading [amdgpu]] *ERROR* hw_init of IP block <psp> failed -22
[  402.967252] amdgpu 0000:03:00.0: amdgpu: amdgpu_device_ip_init failed
[  402.967255] amdgpu 0000:03:00.0: amdgpu: Fatal error during GPU init

if not reset mp1 state during kernel driver unload, it will cause psp
load pmfw fail at the second time.

add PPSMC_MSG_PrepareMp1ForUnload support for smu_v13_0_0/smu_v13_0_7

Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c            | 8 ++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 2 ++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index f57710790b8c..14ebc35d9cf0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -66,6 +66,8 @@ static int smu_set_fan_control_mode(void *handle, u32 value);
 static int smu_set_power_limit(void *handle, uint32_t limit);
 static int smu_set_fan_speed_rpm(void *handle, uint32_t speed);
 static int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled);
+static int smu_set_mp1_state(void *handle, enum pp_mp1_state mp1_state);
+
 
 static int smu_sys_get_pp_feature_mask(void *handle,
 				       char *buf)
@@ -1414,6 +1416,12 @@ static int smu_disable_dpms(struct smu_context *smu)
 	switch (adev->ip_versions[MP1_HWIP][0]) {
 	case IP_VERSION(13, 0, 0):
 	case IP_VERSION(13, 0, 7):
+		ret = smu_set_mp1_state(smu, PP_MP1_STATE_UNLOAD);
+		if (ret) {
+			dev_err(adev->dev, "Fail set mp1 state to UNLOAD !\n");
+			return ret;
+		}
+
 		return 0;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 26fb72a588e7..fda89e309b07 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -118,6 +118,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(GetPptLimit,			PPSMC_MSG_GetPptLimit,                 0),
 	MSG_MAP(NotifyPowerSource,		PPSMC_MSG_NotifyPowerSource,           0),
 	MSG_MAP(Mode1Reset,			PPSMC_MSG_Mode1Reset,                  0),
+	MSG_MAP(PrepareMp1ForUnload,		PPSMC_MSG_PrepareMp1ForUnload,         0),
 };
 
 static struct cmn2asic_mapping smu_v13_0_0_clk_map[SMU_CLK_COUNT] = {
@@ -1662,6 +1663,7 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.baco_exit = smu_v13_0_baco_exit,
 	.mode1_reset_is_support = smu_v13_0_0_is_mode1_reset_supported,
 	.mode1_reset = smu_v13_0_mode1_reset,
+	.set_mp1_state = smu_cmn_set_mp1_state,
 };
 
 void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index a92ab3266091..185058637f7d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -116,6 +116,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_7_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(DramLogSetDramSize,		PPSMC_MSG_DramLogSetDramSize,          0),
 	MSG_MAP(AllowGfxOff,			PPSMC_MSG_AllowGfxOff,                 0),
 	MSG_MAP(DisallowGfxOff,			PPSMC_MSG_DisallowGfxOff,              0),
+	MSG_MAP(PrepareMp1ForUnload,		PPSMC_MSG_PrepareMp1ForUnload,         0),
 };
 
 static struct cmn2asic_mapping smu_v13_0_7_clk_map[SMU_CLK_COUNT] = {
@@ -1647,6 +1648,7 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.baco_set_state = smu_v13_0_7_baco_set_state,
 	.baco_enter = smu_v13_0_7_baco_enter,
 	.baco_exit = smu_v13_0_baco_exit,
+	.set_mp1_state = smu_cmn_set_mp1_state,
 };
 
 void smu_v13_0_7_set_ppt_funcs(struct smu_context *smu)
-- 
2.25.1

