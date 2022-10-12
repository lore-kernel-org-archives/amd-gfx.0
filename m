Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62317C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Oct 2022 06:35:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5DA810E360;
	Wed, 12 Oct 2022 06:35:00 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8792B10E360
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Oct 2022 06:34:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+TPMvgJZFjqyJrPispG5cmdyxYWqxu4C4jcbkg8qY96k3Id81OKLLnkYvHQm0n1iSujr70PFWpFmSOhxkq6je8iSoUlltAY7qlu15l10VBnK/PqWs/QhcdpBG4HVNTIBUGxNgpCoVyXRG+GgSkWTDpz0SdTBBAlUzQvk99WhCN++IFVClZTjhDM4P7L6ilQOqAOIDMqFTbAyJPh/zva9kjTv4+DfeA3IgZDSE7+7001dVLMPJJK0n2vTX+xHYxEXJAm1GXU5wvJMSIuFP4g4A7kAIIxJiijZzzUuC7qtNZnNQ7zUVXSFI4Z3kOM6QE8ndw28uaVg9kLUaHrjzk3aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ofn15G4J339GUYL4cr+Wj7XvH+UXEU0Csna1HGzmYAs=;
 b=j+Tr8K3IniWCBrAbNA5b71Mc3XWmzB7bRvb/V9VjZeFqGrFOuCYPYJA1YFl0SfkgUyMsCn8ySyLuWlVIA65D8XQrnoVSZS0JXrS02YJW9CKsKsHEfT5/axj2x+w13CeyUUUU1Qgdu2XRfj0EXSIr3noFvxrkXQDjXicXdNO6FwHBDQJqZNFbmVwDiJyt8/Gu+RC2/lP2nKcuoFcCGe68xurgDKn+wKHfqCXvi5CQCkvZt6a2MfoeoTOEgbfRIPPBGhW/ujTABGywKfKQAvnEXpPwv1jZ4awnJ6fb1ei8IUv3SGLtaya9wzOty5Sl/ZFrmOZVc1RDQl1tj3dBpd78sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofn15G4J339GUYL4cr+Wj7XvH+UXEU0Csna1HGzmYAs=;
 b=MHyoJJx84HG4yjcmm2KBJWQxvie56yP99Pnj1DckkdsCXKUluor+79dUoFVDUQ6/Y0VA1rThMBsfHcFAHVl8MC3YWEUmZ/f0t2QF28LT2MpphzGxamWjih1PwYxv7QlBNqZ5cNylRP8Vym4H0vDYIGZivEOP5Z7R+paa0XCIrqM=
Received: from BN1PR13CA0015.namprd13.prod.outlook.com (2603:10b6:408:e2::20)
 by BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 06:34:56 +0000
Received: from BN8NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::dd) by BN1PR13CA0015.outlook.office365.com
 (2603:10b6:408:e2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.20 via Frontend
 Transport; Wed, 12 Oct 2022 06:34:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT099.mail.protection.outlook.com (10.13.177.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Wed, 12 Oct 2022 06:34:56 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 12 Oct
 2022 01:34:25 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 2/3] drm/amd/pm: fulfill SMU13.0.7 cstate control interface
Date: Wed, 12 Oct 2022 14:32:54 +0800
Message-ID: <20221012063255.67878-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221012063255.67878-1-evan.quan@amd.com>
References: <20221012063255.67878-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT099:EE_|BL1PR12MB5995:EE_
X-MS-Office365-Filtering-Correlation-Id: a3f33112-c48e-4c95-765a-08daac1be0d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ACbPe9WfvxnEIvWEiatgAJMx8MCANz6HMpNduXF7f9CXpJQscl+wRSVC4Y5Ufmp/k4HmNCbFH/mF3KI3m2S2W1QjMdCuiWjxZPT7bPC0VDbpBbFypwiLdet7bUDbOgMnivfheKG7EYfodHD2b82c6DoV2NBUHdqrX6rKV+y5PrskTQrgP6yOTBJFRIRztUP6n+sFcgp0SflO3XdCd6Q+pQAbgqeUSthJSyfNnegh2SUa2xZRw7SsTQ4Ofxfbmdu1i9gM+36V+F1ILjCFwXUBRScYvjl6bW9LyyYrGLGd5vNTVYjCbdgAcOUbYSZ8PNQa0BZ478Puk9rWDdMt4qKWrkUJqv/kPb7NM6NZNeoV9i9Z8Fu/2AtlJzktyhE1b63+C4LvC6VVAC2+hQPP3FA0B7RcjF2OYcxNypOX/wdVXiy6CvuS/AXZBueoQuyCyeoftz8+Yyzo+ijKAWlYam3KsAcKLHuQXTRCVmmS2gI+1Ecmnk7qZAOw5I/QyFwqqcGklmWoYp7MPqNBzyNewzdt7wcFb12sc5sb4ytpxblds01y0dudb8RWYdzeNrnbyCcCztlccdOfd2kA5bgVKfeQ8+8QqUhzmONQeiVgzwyJUN3Fr23H83GxShrHBQnQl91k2o1AokTGHsKIySMzYYobAbnoUN4Lx9nArbagRUYOe/F3VYCQf7Jv4m3cUH4kT+BURLzHpF1o11Pu0ON+jTqzzH7kKt/7pfd6ttmdNVHnx2qR7EPyd4B1AGksP50NQjQwdXfQD+N8jeZPiHuUFEupGxc0ZJfUMj4xBY8dkNaxNkPAgdc/fILyfg39yVZ5F2U5
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199015)(46966006)(40470700004)(36840700001)(83380400001)(2616005)(336012)(1076003)(16526019)(186003)(26005)(70206006)(70586007)(4326008)(2906002)(86362001)(5660300002)(8676002)(82310400005)(7696005)(6666004)(478600001)(36860700001)(316002)(54906003)(44832011)(47076005)(426003)(356005)(6916009)(8936002)(82740400003)(40480700001)(40460700003)(41300700001)(36756003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 06:34:56.2254 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3f33112-c48e-4c95-765a-08daac1be0d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5995
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
Change-Id: I3e7ec7d0434d3b34855a9267ab1989a3b85d5206
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index c422bf8a09b1..c4102cfb734c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -121,6 +121,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_7_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(Mode1Reset,             PPSMC_MSG_Mode1Reset,                  0),
 	MSG_MAP(PrepareMp1ForUnload,		PPSMC_MSG_PrepareMp1ForUnload,         0),
 	MSG_MAP(SetMGpuFanBoostLimitRpm,	PPSMC_MSG_SetMGpuFanBoostLimitRpm,     0),
+	MSG_MAP(DFCstateControl,		PPSMC_MSG_SetExternalClientDfCstateAllow, 0),
 };
 
 static struct cmn2asic_mapping smu_v13_0_7_clk_map[SMU_CLK_COUNT] = {
@@ -1587,6 +1588,16 @@ static bool smu_v13_0_7_is_mode1_reset_supported(struct smu_context *smu)
 
 	return true;
 }
+
+static int smu_v13_0_7_set_df_cstate(struct smu_context *smu,
+				     enum pp_df_cstate state)
+{
+	return smu_cmn_send_smc_msg_with_param(smu,
+					       SMU_MSG_DFCstateControl,
+					       state,
+					       NULL);
+}
+
 static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.get_allowed_feature_mask = smu_v13_0_7_get_allowed_feature_mask,
 	.set_default_dpm_table = smu_v13_0_7_set_default_dpm_table,
@@ -1649,6 +1660,7 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.mode1_reset_is_support = smu_v13_0_7_is_mode1_reset_supported,
 	.mode1_reset = smu_v13_0_mode1_reset,
 	.set_mp1_state = smu_v13_0_7_set_mp1_state,
+	.set_df_cstate = smu_v13_0_7_set_df_cstate,
 };
 
 void smu_v13_0_7_set_ppt_funcs(struct smu_context *smu)
-- 
2.34.1

