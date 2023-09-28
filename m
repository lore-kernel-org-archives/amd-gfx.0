Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC0EE732E7
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Sep 2023 16:11:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15FDA10E060;
	Thu, 28 Sep 2023 16:11:16 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC12C10E060
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Sep 2023 16:11:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L8DrMC7oMIBfdX43SoU8nxzlZK/dz6u7wuC8N/S6XtZKM9nWrkgo+cUDTnfTQzQS08ytBRuJTdwu5A7wRqWlfLQtyt3b6rcLe0wEOCpypFW8P1BoGSr95l/KpfWNoSvT3UAPjv11iUBXSuUlq/1korMnC+Qkou00y/ru7o6EkcShpGJ1nsk9NTzi61VXrbJwYp9T5ULcahEyRj7V1OW6ZfmFtvBzYCDAEQeocpYtKsyYAWouc3+JeZTEaYJT/QcogGKxMTnXuZucqK2f095JmkpRs13b/oGaK9EFDOCafG/tL6qIhOQvHMQul4JMI89ozHIYKKmQ5SP+EiytATE2XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13wAVPKrRjQs3O6e4FA02U+vKWKq75cObHyNdoTcu6w=;
 b=cOy6V/tGi6IgfJhKJKrMD+xL9noXumVaquELAwE19nsLGqWu2BYvqhB0e9TvBpHpXpdkgIBCCvsmAHjguFvpj4swKZaXfQoV+ZLrEuPd3fQk6AukwvSUEuJGBgZteSQYh5Q1OPH/aknorag4yUQSP1iokBCmCVqhmi78LsAlGV8kbKjQB0Rb1HCEoQuAJ8+KX4dRs8gK1LOUZtmyUfYIiZmELRLXuDBg2PvjTSvssTqTR8ndRrrWYctH1JWGtXc1kvCk+d52fo546mJt6VWaZnLBV0pXnqWTHUQW8B8h57F5QLP4OU1wqv6AKN6frwQ4uGC+OVnOeFFz43HIzfw+Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13wAVPKrRjQs3O6e4FA02U+vKWKq75cObHyNdoTcu6w=;
 b=wqOtC3/oP9SftOvkRZ3Q8BPz7gn0GLzvotVzdowX84wZ/+FWd/zr1FYekY8bbESaBT9KcXW7SKyDTqpgqm4REq4Qw8LovFUB9bmoqV5+Y/ka7ue3wk8oZnni0KBCxYbYiFxVHIdpcE4txVRBfSQAcwQDzvumiZUJKRL0i6HikmI=
Received: from DS7PR03CA0268.namprd03.prod.outlook.com (2603:10b6:5:3b3::33)
 by MN0PR12MB5929.namprd12.prod.outlook.com (2603:10b6:208:37c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 28 Sep
 2023 16:11:10 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:5:3b3:cafe::dd) by DS7PR03CA0268.outlook.office365.com
 (2603:10b6:5:3b3::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Thu, 28 Sep 2023 16:11:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Thu, 28 Sep 2023 16:11:10 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 28 Sep
 2023 11:11:05 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Remove set df cstate for SMUv13.0.6
Date: Fri, 29 Sep 2023 00:10:50 +0800
Message-ID: <20230928161050.400527-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|MN0PR12MB5929:EE_
X-MS-Office365-Filtering-Correlation-Id: 41d327e1-4643-4e3e-a2c4-08dbc03d87af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NVpCKgDMCKBmd0mRmO2mHujh4nT/GPNEdacLilfLCWLJYwVA9hUfLrEXnIqbFWzDMlWvOqy1AyUQQXSPNLpYqTVcL0507O1B+vWaMJvrzbPAQFwMNaTKqN1ruAOHUJkJYDwuv4bQ23/FdLJN0wL8FbtoyQm8Jr/y2fBUt/1bbsedvZMyF0gvTNnufB0tAs+mCdN9iexCDK+YvKINAWRMIJk88xIKyGi9sn3tDWWpU3nyZ5GRqh667ad0Q6cYhB46jwX3xhLeucnD4cD5h8lnQQosej+OhyGBWA0ZHj024t03wjBfCot/NYMoYOAHz7TAiN0n1cp1xnQnmLWnz4oMy5sDOyO3zvzYEBQfyewO5FlYheOQAYUHdqdHJFYY8n+cbx41goTpy/1/vUjYPfgGi86CgKw+Rwmu5fD5Skrq7qPeyFmYx0UY/rQFdHnZg5Zzn09eZuuPlwsp+7Lj5rzY3yFRLWHD4jWmYm6rXTciOBoYrEn9D7HT9VZTNyDek82CtnIuWuE2Y/U6r7a4PDJPvCk/xMw5SUBhgzidow5yk4Gu4/c7/hAPyHRoPefX9IVSYbbA1zgjZY8KxuJB0Kmit7uwiE81Qy/+O0mxtKGb7tFh1M6H219ak7rjYaZi5dEBuaMHLmhSzdlzeBUJgekRUZOr0LyBNTxKigA9HkBzNiSXEFxyePhPHwRcSDvqyeDthdCukejsr3TdczQpKBiUoUBRrIsFZxuyfU2pLgzlwzUHqGSIAWp5f+E3cDlY00Sgh/B3s5AEy/H9qsBedj/imw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799009)(40470700004)(36840700001)(46966006)(478600001)(40460700003)(1076003)(336012)(426003)(16526019)(2616005)(40480700001)(26005)(81166007)(6666004)(7696005)(82740400003)(356005)(41300700001)(2906002)(47076005)(8676002)(54906003)(4326008)(8936002)(316002)(86362001)(6916009)(70206006)(44832011)(5660300002)(70586007)(36860700001)(83380400001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 16:11:10.3936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41d327e1-4643-4e3e-a2c4-08dbc03d87af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5929
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
Cc: le.ma@amd.com, Lijo Lazar <lijo.lazar@amd.com>, asad.kamal@amd.com,
 shiwu.zhang@amd.com, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove set df cstate as disallow df state is
not required for SMUv13.0.6

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 11a6cd96c601..652688316d68 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1889,13 +1889,6 @@ static bool smu_v13_0_6_is_baco_supported(struct smu_context *smu)
 	return false;
 }
 
-static int smu_v13_0_6_set_df_cstate(struct smu_context *smu,
-				     enum pp_df_cstate state)
-{
-	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_DFCstateControl,
-					       state, NULL);
-}
-
 static int smu_v13_0_6_allow_xgmi_power_down(struct smu_context *smu, bool en)
 {
 	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GmiPwrDnControl,
@@ -2754,7 +2747,6 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.get_dpm_ultimate_freq = smu_v13_0_6_get_dpm_ultimate_freq,
 	.set_soft_freq_limited_range = smu_v13_0_6_set_soft_freq_limited_range,
 	.od_edit_dpm_table = smu_v13_0_6_usr_edit_dpm_table,
-	.set_df_cstate = smu_v13_0_6_set_df_cstate,
 	.allow_xgmi_power_down = smu_v13_0_6_allow_xgmi_power_down,
 	.log_thermal_throttling_event = smu_v13_0_6_log_thermal_throttling_event,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
-- 
2.34.1

