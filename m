Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41CC2F9D0F3
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 19:46:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C697E10E119;
	Tue, 14 Apr 2026 19:46:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zc0v5z8J";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012052.outbound.protection.outlook.com
 [40.93.195.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A87710E119
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 19:46:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VVfk7yacBfYmwM/QmANivxo+VuGlWdsSESoPFTQE4PEc+cTyu1q6fFbWzFQjOddjuYohfANA9dq6qpZx31q0pJjQ7msRPb9Ldkz8B178GyWYbFqNewdkGUKY6AwCvpiYnewE2EMasQXObKuUeHB+NJsfv90WYBrxYicpm6itrCFd2cmmgz7xD1nuZGYhxh6myUWA0EuaGcSzh1/bxRbckKdIz65QkA4rMEOVhgkv6Fvs7Wlv6zLibO67c4oAPBT1RPfs3PzfHJYTSQzmhqU/78gRzUF9oX3qEVxy8f1tHEFXEnhMuNXTo7vUGOkMQLadLt7QlcEJYHfk6WgeJ9a1kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUrwEas+/oloPitaLS+aN0N0Uaca9YkbJtaI1Unm0KU=;
 b=YeY1A9U/0Xmp65dgiFKS3DL8nEkKzrCJSQfMBSnaz9Rzu5hyhi75OQKsQIWVAawBirO900p3uo1EiGKmUrWReAO8k4ahPzjUCfc2tSlVlZUJwGvyoiSQiK6U7hpDGaKNU34E/0VSutBDqxx1K0WZ6wNE5b0IiZcmI38IQRlpd8f/YF+CyLKinOnXUF1li31sfPkKHEcQ79O+AjfHDxMGdKOOElSEaBJCrACmKQA5mFFHMi4urPPx17MoBCp3sMBKpgEHEyUovj+1HERGoorkKBMPUqxU5nTXkC4P2WQxa+Y7IWi/TdU+8tdKTxXofRsqTeDAPmKN0rxHpYnfSvIS5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUrwEas+/oloPitaLS+aN0N0Uaca9YkbJtaI1Unm0KU=;
 b=zc0v5z8J68yKhrfw/0ww5hmKC81MmdyuNszZYxDCMdMK/iDhA2El0K+OABxNLHzsdVbdrOWS27qxh0nHj/8AYxatlU7tickPOunhgOy2dBGcEoG2DS7CNvcoBHM4bVMJpQuhKa6r9j4yFKulsTmS9/ftffajWrEMtdEPGD2Nvn8=
Received: from DM6PR05CA0057.namprd05.prod.outlook.com (2603:10b6:5:335::26)
 by IA0PR12MB7749.namprd12.prod.outlook.com (2603:10b6:208:432::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 19:45:56 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:335:cafe::70) by DM6PR05CA0057.outlook.office365.com
 (2603:10b6:5:335::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Tue,
 14 Apr 2026 19:45:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 19:45:55 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 14 Apr
 2026 14:45:55 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 14 Apr
 2026 14:45:55 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 14 Apr 2026 14:45:54 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lijo Lazar <lijo.lazar@amd.com>, Asad Kamal <asad.kamal@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 1/4] drm/amd/pm: Enable thermal alert on SMUv15.0.8
Date: Tue, 14 Apr 2026 15:45:44 -0400
Message-ID: <20260414194547.2213525-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|IA0PR12MB7749:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e4437fd-1780-4e58-3db9-08de9a5e71a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: rLn4yWW6open5u40M0sG3WmRE/JMBZDrmIlJPcvtGkopIPFXMUt7oOnD1QkhmW2qrgXnXTnJk+Mvbdp2wq3F3wn8ByQG2CGRTgyyWY9nnAMpOsogmL3lOPUrnnlw4yA6EQRbvUcQhAk/cxYM+NOs2/4bRxdY8+L57gN6S4JOQhuMgSNj2ByviMcI55RVdBjvM7L4EDZ8e23h56Y2XHy9JH9q8PNwFvtCtDq/tfYS+vHXg3mFqUhWa0j0zabojxzdEHqhNI5V5vVtKbiYyCT0lFqsVPIc6D1Ty6yNy+X2cG5Z23cXHCZij3/z7+/fWpSWj3Z6aCE0sB53RScLDECXkrD4Lvt+yY3bvhHTyAAel45O/PKS97ADbwdQ+TV+AjPO8KTB0PJwi46BQgGgOXR2iZN+GSlmunNToaIc7NIHxYA7c9QS9/t3bv1VLCyJFaVE0qNNh3aAnmOYIjdQda+bGrpMAwoeYADS/AvTZYiwE/MhnSk2H7wqFciltfdSFFnXnZaB78Lu/VcTJdRNWP9JTnktvi7/FhJrE8yLxUkJsmffusaCO0GhsiOndYATBLzjr4h0Xy4Zve/h8a3UJKPIEit4M6B0kbbwQOcsALgCGX6+4cNzrqSnlpLESvJOdtgfl7DOhyIO90zT/2Z2/auI4RPiyuZ5nXqgDKwozyrZ3bH17Aua7quGeTHqZbw3JLh8PXNYFmNQmAI3AmtZfU/OpxTIX54DF2gQhJvo/DH5tPl7grZC48H9zWgknGII6qlLmDli+KLMtF73r7fLDV5A+A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xYraDOLVtZb3cCuBZSbaufXCb3KUITLQ6HWg8DHOwU9Jl/hsboBIig6hVk7/azTC0/ZHssikb3q1oQ5bSUMaFTh63+/WbtoAnyretDkEQamH/AXUVpCtcK4vocbgAWvYqxDlBCGmpCIW5I+SAPfGMaU5eUmIT9ERhUG/hcV0tpEXSQUjopC3VFggpUNKzqyzIdcDCBiktKqt22p63NA+lvXaNMzFNszAH9KUcgL/NCGS9QUOSbsWhzwcF0Te3qCwDLKrxxGwF1cDapqD8IUawLY1MQzkrrXU5rvwIRiQWbZZfoLO4rpRuvWoEDCOQZ6a0UEKmGH4jBkYuyWwMfNayeegDrnBxhbUmkZKyLUUSNypcxoAXqeeYYYoRowggmASSyOcZ4YryJGaQ7abWspS5ySia5b7GxkcmFOFu5skTVNatp9G/NRVsKkb+kfRJ5g5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 19:45:55.7015 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4437fd-1780-4e58-3db9-08de9a5e71a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7749
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Enable thermal alert interrupts on SMUv15.0.8

v2: squash in cleanups

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index 25cfb051d0c6e..912a1e1e0cd6a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -2191,6 +2191,14 @@ static int smu_v15_0_8_get_ppt_limit(struct smu_context *smu,
 	return -EOPNOTSUPP;
 }
 
+static int smu_v15_0_8_enable_thermal_alert(struct smu_context *smu)
+{
+	if (!smu->irq_source.num_types)
+		return 0;
+
+	return amdgpu_irq_get(smu->adev, &smu->irq_source, 0);
+}
+
 static const struct pptable_funcs smu_v15_0_8_ppt_funcs = {
 	.init_allowed_features = smu_v15_0_8_init_allowed_features,
 	.set_default_dpm_table = smu_v15_0_8_set_default_dpm_table,
@@ -2208,6 +2216,8 @@ static const struct pptable_funcs smu_v15_0_8_ppt_funcs = {
 	.get_enabled_mask = smu_v15_0_8_get_enabled_mask,
 	.feature_is_enabled = smu_cmn_feature_is_enabled,
 	.register_irq_handler = smu_v15_0_8_register_irq_handler,
+	.enable_thermal_alert = smu_v15_0_8_enable_thermal_alert,
+	.disable_thermal_alert = smu_v15_0_disable_thermal_alert,
 	.setup_pptable = smu_v15_0_8_setup_pptable,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.wait_for_event = smu_v15_0_wait_for_event,
-- 
2.53.0

