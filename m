Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C34A6C6FD1F
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Mar 2023 09:16:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A20610E8CD;
	Wed, 22 Mar 2023 09:16:31 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::60b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4052310E8CD
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Mar 2023 09:16:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odHyvTgH6DcO3wNjwA7fNGzorCN+and9q88k4LA/EeKchDpbwTWWGJYR6jMX+WPVv1kGgE/REXAuwrxVh3WDHWsW1Ola2dsz96pdWAhn2qGSCH2wOlrtWhGtlT9qgGewYnhEsH2TZRdZ68MeP9+YiXvLR5W2MJrcGhIm+9fUG4Ec1SL6maJI5ukHySKAV6dp9YU4N/Yfhq0HeYBMU2MEkuT2FFnlMkaq95HO7lLoCwpOSgjJNwoKkZsJB+ebND9cZJBzfuMovIiDAolLIiULJZOxX+LcFJKr8z4AUICS53FWBXDuVk3Wd1VezuKKXISQ15rjVZkIdqz/B7nkHG57Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uib1Q83WH6fKzOEibd8vbfqsde8Vfj31/mJCiiCk1cY=;
 b=Z6FqneUrVgm6BSz5wsPBIsPIs7JAfFt07T1GVie+c9kjswhBrY9H3SDqOoh5/f+RiJIY8Yz+c9c/FgfUp78fKpYG1gUbhoEPc43zi8Ay7SkidTRaLxU6Mqut2dQWYbXyuKHVw8IbSLlJclERzOursfCvuj/bAwKRtqL5+gL7o7Ma/8ATVox9hvSkeKL7XB97GmVBYVLKu/4km0K/rrUuJ2isyle6+B7LJYT4/4YhbINoySN8FTuQH3S2Xla/F7uaXZ7D31/f5SC0SH8n7lTMvkxkxutKQavV8RxgN82CRv2rz4QQfA7G9cck4NNGKZbbFw4QLvosvA2qvZBMjflN3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uib1Q83WH6fKzOEibd8vbfqsde8Vfj31/mJCiiCk1cY=;
 b=CEetpP/7fxvj3QMOW8V1pLlCsx/ltjaAcVDdqgVlpHWBO9B8C0dJIXmbUI0hwiPTCfSDz6Mb0+0+Amib7TRNeDRd9JAjZVrz/3iDqWe4ew1cB16q8O17B8odnp2Y7pZjerW8lg/VeiBHecRP2VySbAwiwLoQ28Xr+TW7AvdTBkk=
Received: from MW4PR03CA0080.namprd03.prod.outlook.com (2603:10b6:303:b6::25)
 by CY8PR12MB7513.namprd12.prod.outlook.com (2603:10b6:930:91::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 09:16:26 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::b5) by MW4PR03CA0080.outlook.office365.com
 (2603:10b6:303:b6::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Wed, 22 Mar 2023 09:16:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.17 via Frontend Transport; Wed, 22 Mar 2023 09:16:25 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 22 Mar
 2023 04:16:24 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 22 Mar
 2023 04:16:24 -0500
Received: from archlinux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 22 Mar 2023 04:16:22 -0500
From: Wenyou Yang <WenYou.Yang@amd.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Xinhui.Pan@amd.com>
Subject: [Resend PATCH v1 3/3] drm/amd/pm: vangogh: support to send SMT enable
 message
Date: Wed, 22 Mar 2023 17:16:07 +0800
Message-ID: <20230322091607.1609145-4-WenYou.Yang@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230322091607.1609145-1-WenYou.Yang@amd.com>
References: <20230322091607.1609145-1-WenYou.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT017:EE_|CY8PR12MB7513:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b3cd652-b6bb-4c31-4a40-08db2ab61ccf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5W1Lr95AkzG1zAGGImMam/MyQ6KwvEPogvxpHI4twnX6eHDXGPfmfduKnIAOE/T4sh+fjTnkBM+Dgtgo/j8nSutTffRBnSR/MHrwU0fyYjMUW/tjWrch4oeKl9phMywjCrNqdDzUOBk1R8fbRRn1eJvBcUQqUzvjkYRJ9AdJpnsYnseNPC+h65m/KSGBPxrLGId12oyJ9dKZCCNTdj6qcM6yzHY9HRcxqfQ2BVgRx/WZehkXrCpAfo6ynlApNXDS/9ePZvsqqhwmGK9IPIDg1RQC4l+VOcFdSOfgHp2jwc84OGryfyk5lVQQrHHUEbA1bIz62AWwDnLZBfhYp0YT4CrYigU3iOmHuIr3vhymlOuPCEKrm/txQ8Pq1YCpyucZ0200mE+vETm76z5o8YnPfXmA7WkEYWQmJHQxIuLxZKY5x6yAdAgnUlOWWJQxGywy7tBM+d49pjmraibpv+rP7TsP2JomYcYXJWFwTNxJy3uFvEe3Ap0GeZz/0Oy45JCtM/XQTaLjn8jVTR/d0ehBacRVulFULJ7LQmzXnWWakQoVhFYicb6Ou/IMHdbN6ZzKX7b5I00W+GK4ZZIA2hfxp+SPz5zQLHuKEdGzpn7BlapLXArUfUpEICn+W3U1P1HtMoUKZxc25QN5org9QwJtzhxtSPfHObAs0wJhIFRrfROvzd61DpQB35P7OK4oR8s0BmLMM5YCL44h1fzzVFk+TRvNjcOKe9E2Vmb/0RzahU0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199018)(36840700001)(40470700004)(46966006)(41300700001)(8936002)(40480700001)(8676002)(4326008)(70206006)(70586007)(36756003)(81166007)(15650500001)(2906002)(82740400003)(36860700001)(40460700003)(82310400005)(1076003)(336012)(6666004)(47076005)(7696005)(356005)(186003)(426003)(2616005)(5660300002)(26005)(86362001)(83380400001)(316002)(110136005)(478600001)(6636002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 09:16:25.7099 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b3cd652-b6bb-4c31-4a40-08db2ab61ccf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7513
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
Cc: weiyuan2@amd.com, ying.li@amd.com, amd-gfx@lists.freedesktop.org,
 Wenyou Yang <WenYou.Yang@amd.com>, kunliu13@amd.com, richardqi.liang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add the support to PPSMC_MSG_SetCClkSMTEnable(0x58) message to pmfw
for vangogh.

Signed-off-by: Wenyou Yang <WenYou.Yang@amd.com>
---
 .../pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h    |  3 ++-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  3 ++-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 19 +++++++++++++++++++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
index 7471e2df2828..2b182dbc6f9c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
@@ -111,7 +111,8 @@
 #define PPSMC_MSG_GetGfxOffStatus		       0x50
 #define PPSMC_MSG_GetGfxOffEntryCount		       0x51
 #define PPSMC_MSG_LogGfxOffResidency		       0x52
-#define PPSMC_Message_Count                            0x53
+#define PPSMC_MSG_SetCClkSMTEnable		       0x58
+#define PPSMC_Message_Count                            0x54
 
 //Argument for PPSMC_MSG_GfxDeviceDriverReset
 enum {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index 297b70b9388f..820812d910bf 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -245,7 +245,8 @@
 	__SMU_DUMMY_MAP(AllowGpo),	\
 	__SMU_DUMMY_MAP(Mode2Reset),	\
 	__SMU_DUMMY_MAP(RequestI2cTransaction), \
-	__SMU_DUMMY_MAP(GetMetricsTable),
+	__SMU_DUMMY_MAP(GetMetricsTable), \
+	__SMU_DUMMY_MAP(SetCClkSMTEnable),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 7433dcaa16e0..f0eeb42df96b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -141,6 +141,7 @@ static struct cmn2asic_msg_mapping vangogh_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(GetGfxOffStatus,		    PPSMC_MSG_GetGfxOffStatus,						0),
 	MSG_MAP(GetGfxOffEntryCount,		    PPSMC_MSG_GetGfxOffEntryCount,					0),
 	MSG_MAP(LogGfxOffResidency,		    PPSMC_MSG_LogGfxOffResidency,					0),
+	MSG_MAP(SetCClkSMTEnable,		    PPSMC_MSG_SetCClkSMTEnable,						0),
 };
 
 static struct cmn2asic_mapping vangogh_feature_mask_map[SMU_FEATURE_COUNT] = {
@@ -2428,6 +2429,23 @@ static u32 vangogh_get_gfxoff_entrycount(struct smu_context *smu, uint64_t *entr
 	return ret;
 }
 
+static int vangogh_set_cpu_smt_enable(struct smu_context *smu, bool enable)
+{
+	int ret = 0;
+
+	if (enable) {
+		ret = smu_cmn_send_smc_msg_with_param(smu,
+						      SMU_MSG_SetCClkSMTEnable,
+						      1, NULL);
+	} else {
+		ret = smu_cmn_send_smc_msg_with_param(smu,
+						      SMU_MSG_SetCClkSMTEnable,
+						      0, NULL);
+	}
+
+	return ret;
+}
+
 static const struct pptable_funcs vangogh_ppt_funcs = {
 
 	.check_fw_status = smu_v11_0_check_fw_status,
@@ -2474,6 +2492,7 @@ static const struct pptable_funcs vangogh_ppt_funcs = {
 	.get_power_limit = vangogh_get_power_limit,
 	.set_power_limit = vangogh_set_power_limit,
 	.get_vbios_bootup_values = smu_v11_0_get_vbios_bootup_values,
+	.set_cpu_smt_enable = vangogh_set_cpu_smt_enable,
 };
 
 void vangogh_set_ppt_funcs(struct smu_context *smu)
-- 
2.39.2

