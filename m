Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB39C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Oct 2022 01:32:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AA0210E37B;
	Thu, 13 Oct 2022 01:32:09 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CEFB10E37B
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Oct 2022 01:32:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clZ0o2/zzorpHSfFR5yrCa+YIMyy4Jiy+AY74GEAe1WemXbVMYfoGTHwuhxaxZTKB5Iq02w9GmOV2E8B1aOgRfgz9fTOTnCrYW5c1bktfWtIR5BwzJosKxqwGxcs5iGTejCxq67O3ZGC2SFN1Y4Jzxjuxt4P089GgznvQppZ0FKkZSIfUYw8zZGRLLwXZBzsCTngbctSaoYCL9EGlT9Dqpk9bfbSQ0GQG2pG3uSMAa9Dq0j3oa7ntpodWk+yrk6Dqgm2cruBxwyKj4PKzNrE/qIdS3AgletoApi46Vxhboi40NBH7B6S4SWQ/QlJhlhQPwknLAFU0dss5TATWCkTMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KfKQZzy0iGJiJdt/urwms+7/kcwXKx73h0+kIfQge+I=;
 b=Q0koyPfgvBFROvZwpYLi6buj22KeuPGZbqdu1mX2EFwA73DIYposrgFQHlmAoh7k47k7DPBBJXzK596RaAtXS/tx30xCtqmocKnDcLh39oWzJL07KupwD38uGZaBs52HraZl1Q0QWPlhPe2IXQbf+Qmo+TJb3Ce+NgeSZApc/jWoap00LDrzeQhWiPMz2fQXUkKxfs9ZCJdvkv7wJgCDry7aaQuoE6RfEfLV4fRov6nGlBwEsYaUeNBl2zVusE/OUHtu1n9NERdKhSRhRzLAKohfPwWi3Q1o4FneCvatVpkBefzGTLbgkopP9xuzxTrA5mL5wpwxgC4Lfg+diOOeWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfKQZzy0iGJiJdt/urwms+7/kcwXKx73h0+kIfQge+I=;
 b=2pSPitLrxZYX2A9QtXXTw2HtXjpwUv+G7s1JR3LoZyLAR6Xaa4z7mCmV7nEUUfngHSADsFSrGK6Lk+xkkNSCuxZokwUrpYawLtTi7cVxyYPemhsKaV8MuO5viD5gmtL9CDfnP1yhbwErfXW0r/4l6mP0Oi0Uar/EC3lPXaufbCI=
Received: from CY5PR17CA0004.namprd17.prod.outlook.com (2603:10b6:930:17::35)
 by SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Thu, 13 Oct
 2022 01:31:59 +0000
Received: from CY4PEPF0000B8EF.namprd05.prod.outlook.com
 (2603:10b6:930:17:cafe::44) by CY5PR17CA0004.outlook.office365.com
 (2603:10b6:930:17::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.19 via Frontend
 Transport; Thu, 13 Oct 2022 01:31:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8EF.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.13 via Frontend Transport; Thu, 13 Oct 2022 01:31:58 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 12 Oct
 2022 20:31:56 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 1/3] drm/amd/pm: fulfill SMU13.0.0 cstate control interface
Date: Thu, 13 Oct 2022 09:31:39 +0800
Message-ID: <20221013013141.75369-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EF:EE_|SA1PR12MB7272:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fdc5653-7607-4fe2-aecd-08daacbab883
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YOrQWSIwVRWZyM9STCcE7xlb3j2bVpgkABSPSSsFVQMyDwTVuFWVtonNuVgR8qawlincmbJqrTRqD1yZHPtoPPxwNHe5r7gYusiwyDPH1dedcWj8zJ5kvvddVOBUCbuHh16l5uebSJqsjfy+JpUYYpc5X+4skimMJiVISGP4JEYhwBwtZ0xgJFl3Z2m1LYQYrQtTjAmVg6LO8EZT7eLhP8k8L14LAhqJz58z0Ezosv0BMQkh0XXahrDBnTp6+HLdjqhxjmhcaUpp8wFbkCyy19fiBDCiAlaBKLHpunkQjdrX8hkwyMaAV4LJe02ck4uZejd39Q+O06RqrcES2dn2KLRXkJFI/3zraTyDiAPLiW8rAStKy7oEuB/0aWNZ1S4NPDaXAqzYbYyWlKBm2RDr2VxehnvVtlFm2St8tgS/Xoo5LnVg09PZ13LdwtmxKei6uZzdLfQA1rszQCn3iJBqOS8jT7cUx4Ryp9ZkuCCPZctEmo71XPVaOKIlS9GZJ9WV6BBAnMMXXhJLa5L01M4qLpuPENHLWl6SWYOy/D0DZ7V6rlkI/fJqGCyek0vAc9Ja/65FQ8FfOSzBm9k69YABr+EyaXxSJ4V6NOnIwm9/hLUqNSwKX3lHIeDKXZ44sHTSuK0Aaom+5PhvsHXqLXZQfHC4jj/nMDVYrEMsX18JvxI5I4EBLvP84wOUBMNzh4jxaYhWWPnXeNhlRBgPnIB3xwUOB++c73WjAmupU9ZEZHJYsI48mhLEzTEE2CeMaYOYiakf8SqMp/aldRPrGfAuQxDebeqzoNY56R9BnA9W4JbKY+BVtaXgy74wyiI890px
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199015)(36840700001)(46966006)(40470700004)(54906003)(316002)(6916009)(81166007)(82740400003)(356005)(2906002)(4326008)(8676002)(70586007)(70206006)(5660300002)(44832011)(8936002)(41300700001)(7696005)(83380400001)(26005)(336012)(1076003)(16526019)(186003)(2616005)(426003)(47076005)(40480700001)(36860700001)(478600001)(6666004)(40460700003)(86362001)(36756003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 01:31:58.4784 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fdc5653-7607-4fe2-aecd-08daacbab883
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7272
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
 Evan Quan <evan.quan@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fulfill the functionality for cstate control.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Change-Id: I2b7253898503b8051bbf90f429b46221410146b0
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 1d454485e0d9..29529328152d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -119,6 +119,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(NotifyPowerSource,		PPSMC_MSG_NotifyPowerSource,           0),
 	MSG_MAP(Mode1Reset,			PPSMC_MSG_Mode1Reset,                  0),
 	MSG_MAP(PrepareMp1ForUnload,		PPSMC_MSG_PrepareMp1ForUnload,         0),
+	MSG_MAP(DFCstateControl,		PPSMC_MSG_SetExternalClientDfCstateAllow, 0),
 };
 
 static struct cmn2asic_mapping smu_v13_0_0_clk_map[SMU_CLK_COUNT] = {
@@ -1753,6 +1754,15 @@ static int smu_v13_0_0_set_mp1_state(struct smu_context *smu,
 	return ret;
 }
 
+static int smu_v13_0_0_set_df_cstate(struct smu_context *smu,
+				     enum pp_df_cstate state)
+{
+	return smu_cmn_send_smc_msg_with_param(smu,
+					       SMU_MSG_DFCstateControl,
+					       state,
+					       NULL);
+}
+
 static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.get_allowed_feature_mask = smu_v13_0_0_get_allowed_feature_mask,
 	.set_default_dpm_table = smu_v13_0_0_set_default_dpm_table,
@@ -1822,6 +1832,7 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.mode1_reset_is_support = smu_v13_0_0_is_mode1_reset_supported,
 	.mode1_reset = smu_v13_0_mode1_reset,
 	.set_mp1_state = smu_v13_0_0_set_mp1_state,
+	.set_df_cstate = smu_v13_0_0_set_df_cstate,
 };
 
 void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
-- 
2.34.1

