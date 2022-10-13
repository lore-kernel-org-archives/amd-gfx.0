Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E59C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Oct 2022 01:32:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F378310E38E;
	Thu, 13 Oct 2022 01:32:12 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66AD610E37B
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Oct 2022 01:32:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZrlG+AIHevyUWHtz7mMD6Jq2LVnPimWdmwO6nNKj3+44ZDiKi0AdDrwhqMUJNFKra/wASUeR+RYWz0Lrv2UQAmQLUM3kqyGRHlXpLvgF40fEypAr89ugghxOyYRrOoLG++Q/9x6qDh3q5Zi4J7LrNF8tjAfU6aaKeC9pu2rP46ot9PeXsT/e/65736XuJd8O7Pkz0QN2McP0vntLGcNrkc5u620r5++LxeUYh1erSAo6olzZGZ3lprGMOmFmi5ofFJcRsb/87VUihxbsGglMGhB5ZnnsKynad10zII8ebCxmPHI9f63jrGzs241TuMIORvw8+KAbFg425mTPKszKLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ofn15G4J339GUYL4cr+Wj7XvH+UXEU0Csna1HGzmYAs=;
 b=Mum/cGsvRFqSP/yIfrquyXbQXpRprencXSbIREoEa8qCggGFm4/J+VJO8w8VTWw4ew7DqwFUGowL7r47A3wADvzOO09F+AokE4+RV9tXPJMEVb5ihPdCtmonKF72him9G+D7aKEm0PcDRshQjo6YhPRjlR6xWF2xZkWK/rSbacfmGYk55vaIPZtY6zHDFSVYC+DHNjKuCnGurOwC9Pr9rSqgRc8acoskI0IBDJ1MR9zC5KpXqbseVutwE8ad2PFinls11G3PjyC79ojaoqkTSKxfGsoPwNLyKE06ruqEmQBqpXIoY2GSFHdNag7g/zJ4OeXKUGDB8TuR41nDM9QONg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofn15G4J339GUYL4cr+Wj7XvH+UXEU0Csna1HGzmYAs=;
 b=aNyETD4iTKMBsQgl1N53bhVtQqA0fuN0YS6jhrJFifbTbIt/TfcMui2e37UVxiXWX59YE7rzr15zMww3jGDK20RRZoPy6ugBy61lENEzC4CNPjhigHJ2Pj31ZCmap/pnM7HRaeJET0Y/3/2N8eoRlFu4mIT9kTz3vkjq7tggr+8=
Received: from CY5PR17CA0022.namprd17.prod.outlook.com (2603:10b6:930:17::12)
 by IA0PR12MB7773.namprd12.prod.outlook.com (2603:10b6:208:431::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Thu, 13 Oct
 2022 01:32:02 +0000
Received: from CY4PEPF0000B8EF.namprd05.prod.outlook.com
 (2603:10b6:930:17:cafe::19) by CY5PR17CA0022.outlook.office365.com
 (2603:10b6:930:17::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.25 via Frontend
 Transport; Thu, 13 Oct 2022 01:32:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8EF.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.13 via Frontend Transport; Thu, 13 Oct 2022 01:32:02 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 12 Oct
 2022 20:31:59 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 2/3] drm/amd/pm: fulfill SMU13.0.7 cstate control interface
Date: Thu, 13 Oct 2022 09:31:40 +0800
Message-ID: <20221013013141.75369-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221013013141.75369-1-evan.quan@amd.com>
References: <20221013013141.75369-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EF:EE_|IA0PR12MB7773:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f3944f6-cc3b-44be-a978-08daacbabb02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E3JwJB/1P3f1g/LbntnS2dC0927VMp482JAzNSItziQGJEd516TcOqCI6zy3drWstIl8a62ywlIg605dM+KX1psoQNp1fwlVJoAsv057K0oIq7YFW9huVSIY6fj7GtpXsE/Typ0zFD+mbeNwv+lTgLq+aVqKTbcN2UejCdDIEr4gHklOGEO9yOz/xPcL5QJ6wjPaQzPe6rbaRtapeLhgyELn/v4utf5ZEWeC0I/GRXA0BfqPYWI6U8cguKZmSFP2NUcj6XW9ApeDHNxKCxVJcs+8YWFOpe7vJ5ui1AKhPiCG/+Ep5m1TP7ngs8GJmYKtTXUebZ0pEpf2i/WUtDLbyu9/XQEA+fQ61ZdLj7aPfFDmJwWxia9KVz/z3Zc8KZkqoc/17YHGLD0BzvUZZo2NxlPFmkxWL74V2S8Fu6cHkFvCBTGKZw/+jI+Vmx9SQQ0rGMo3YP2iP28T1Y7dLpSxZl14xf1tKl1CDioxDmBbCmv6U8AKaUv5jbTvhAs4Y/mhPxUaXZR2cUOrIK/0vvmCT75UKF3UQzwqYSsGdCMdw+f8qeTQasJLVqiNS+CJKi4DBGKJsbHqcWGVikGGrUPsibZLDbKZI7tRau8pM545t+BRhkAFDpgKPwKCUQUai4RU2OUJDMeCLk3Ew3LIAQKoo7VMGLqDeE9zpOXjrD/+2VmsK1hOQktmQSEO3kWAwspfRAfcIro7Aqlx5SbzbA2MscPHa+8uZYSJktCQ2htVcJ6Mq9DNhzxbmi0hYgA5PMYHZMCRa8gAlfnf+rIjzvGqn6ujydcuB4DruUEQtOmdHRHzXwxLCQjShXvLqYi1WhII
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(26005)(7696005)(36860700001)(82740400003)(4326008)(316002)(8676002)(70206006)(70586007)(81166007)(86362001)(40460700003)(36756003)(40480700001)(356005)(186003)(83380400001)(16526019)(6666004)(47076005)(2616005)(478600001)(6916009)(54906003)(82310400005)(2906002)(41300700001)(5660300002)(336012)(1076003)(8936002)(426003)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 01:32:02.6660 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f3944f6-cc3b-44be-a978-08daacbabb02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7773
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

