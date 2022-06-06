Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D6ECCA47B
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jun 2022 03:11:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 293B310EDB1;
	Mon,  6 Jun 2022 03:11:58 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 232F210EF7C
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jun 2022 03:11:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnHCnTLKeY9oIpHJku/iZHx0LB4G5KI31+5Q0M1srf+D3xER503Ty6Zdyr32ffimGALGMTzmtNMJDf+LZbtlv9c3znkkOaochZLoNMKwoXrLxJmvQy4164kZF3AYXOWrVPEcNFYzjsjSLKSBU0wWqfOjBokDX7JUhueea1zquuXSNVfbk1guV4XaTUF0G0S1XYRVIsITRIC36ortgZwhPRDe0MrYdwThJD08bE88Wr4lkPAdCrh5ZOEqPQun5Nrht7eBVW13BIUb0i+k4lnbSyKfcHvv2KkimdMfCJH8w/yHQtm71xyoL5ZWsMbznT3LTRb9D2q7Ni+0IYgv1wIwnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cltVKoraeGc2ph0UoGpkyhInpwJ+Z483K+fvjWFUZNk=;
 b=GZKN0/ViweHgZxgGYAwjhcnnSdSoO65UMSru6F+6fvG2lpIS5KyAuKio6QeASGHg9Sxc+guezovKal8K1vsiBwINkhnAg83IOlnl8qkJ1ydQuuwxhu5e0WqQpvlkmwOHuLnxe3+vQL70ZXSNWHHIXECRdHqpVuOQXuocIUcySSbM9Cqx3bFDHWy6GRw8eFMxsOGO2Hsu4Vn6sZ/FEghTyC8vASgrOFwIhOC/rLsUiW2uPl2HXIzSYFCe4mPY5TGGbCaJpuOa8TDBZSwB/cl5pQ+ZytbuBaESs/Zpo2zfIStDjFvS3spfyQ1uh+ghkR2fQsc4Vq025iLc6F0tzfQkjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cltVKoraeGc2ph0UoGpkyhInpwJ+Z483K+fvjWFUZNk=;
 b=iWri3pyMp6w96FDU8CPEXSNRbGBtmG9HQPokRF9087rul/Ry7Su2/mEWnzwI23nUUBPrNpxuz6qvP63ENaYGUq08OmG79lZtfzHtBWXhp+Z0sW16Sfu4dG+6tuM8za28nVJUsHAF+63TuCMwCl6gVF2BU8HWj26zpFeQEfYVVdc=
Received: from MW4PR04CA0255.namprd04.prod.outlook.com (2603:10b6:303:88::20)
 by DM5PR12MB1193.namprd12.prod.outlook.com (2603:10b6:3:70::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.17; Mon, 6 Jun 2022 03:11:54 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::66) by MW4PR04CA0255.outlook.office365.com
 (2603:10b6:303:88::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Mon, 6 Jun 2022 03:11:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Mon, 6 Jun 2022 03:11:53 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sun, 5 Jun
 2022 22:11:50 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 3/6] drm/amd/pm: enable mode1 reset support for SMU 13.0.0
Date: Mon, 6 Jun 2022 11:11:21 +0800
Message-ID: <20220606031124.1818265-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220606031124.1818265-1-evan.quan@amd.com>
References: <20220606031124.1818265-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6fbbddf-c1c4-4b58-6fb0-08da476a4e7b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1193:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1193CC6727D8E694C94BA4AAE4A29@DM5PR12MB1193.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ETnikM/iYsh9boi9ZyNz2ldsdtetZZ9U4WBxlXiy6c/4NvtirJJeWnPYwFDDSbu/BDhNFdYcNS9+CIkbYSk74Qn6PP5XTKftm6IOBlO3EYFIINSLY2F/b/iN49nEFrwjZoNBzqsXB18Jz+V17VdoBgN02FDU3XoRo9Fb/PVMeb8jw/pDvIlngYSSlt9r7ELGkT7ZPpov6QxjZKvym8AqhJ3y7V1+XW+NCNEpVC21A8SMfyeDkidLneFPOlScJ99trKFRohHblmvOM6cqj6Q+69hrKrDKxBFCHqu3Rx9L/ldRHo5D9kB+3Pvyhb/RevapfJ+tCMdkLW/1sTTkKZgLn1i3ddpbqyK9w6H7mN+unE69vg7/ovzqDGSSjWMH7eQk26dvvwHA/XbpPfYkWz35Ha9zp/JWzzaSb2DCMJhUuqyB+xwEqHHLPYjoasZf1fELrPy3LiGlrynDgj1h3ubBlSVn+fK2yIutKvp3qHZ096hjGXClJv4r8bdtSTCAJFcmh4eYHbAJ93szEjxREZD5eZk70W9pVYL1OuwRgOSMMqtNMCCq55o+apraigt1kzh3UBIwVA/QUTpzMPJo+rYXIYseU/KoCBp4WQf+Tcc7UgbWu+I6mRCVlT/UY09Mwhh/M7JuJu55PAf7FxH89IqOKas+1Vo59B0EBw7IM3WhxKHWhZs5X9lvPDG5WScveKBnQJulseNZqpL9TOlIrkiPew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(40460700003)(83380400001)(82310400005)(36860700001)(86362001)(81166007)(356005)(8936002)(6666004)(508600001)(4326008)(8676002)(44832011)(70206006)(70586007)(5660300002)(54906003)(6916009)(2906002)(316002)(26005)(426003)(36756003)(47076005)(186003)(16526019)(336012)(1076003)(2616005)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 03:11:53.3289 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6fbbddf-c1c4-4b58-6fb0-08da476a4e7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1193
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
Cc: Alexander.Deucher@amd.com, Likun.Gao@amd.com, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fulfill the interfaces for mode1 reset related.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I03bb1f7f3b88bf304a188bb6939c043805df8f10
--
v1->v2:
  - drop invalid psp alive check(Lijo)
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |  1 +
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 11 ++++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 20 +++++++++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index fa544c551b0e..37f1752c7eb1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -294,5 +294,6 @@ int smu_v13_0_baco_enter(struct smu_context *smu);
 
 int smu_v13_0_baco_exit(struct smu_context *smu);
 
+int smu_v13_0_mode1_reset(struct smu_context *smu);
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 367ebc8c8dde..cd183c60742d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2326,3 +2326,14 @@ int smu_v13_0_baco_exit(struct smu_context *smu)
 	return smu_v13_0_baco_set_state(smu,
 					SMU_BACO_STATE_EXIT);
 }
+
+int smu_v13_0_mode1_reset(struct smu_context *smu)
+{
+	int ret = 0;
+
+	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_Mode1Reset, NULL);
+	if (!ret)
+		msleep(SMU13_MODE1_RESET_WAIT_TIME_IN_MS);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 99cc49ae6beb..cb17fa928790 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -117,6 +117,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(SetMGpuFanBoostLimitRpm,	PPSMC_MSG_SetMGpuFanBoostLimitRpm,     0),
 	MSG_MAP(GetPptLimit,			PPSMC_MSG_GetPptLimit,                 0),
 	MSG_MAP(NotifyPowerSource,		PPSMC_MSG_NotifyPowerSource,           0),
+	MSG_MAP(Mode1Reset,			PPSMC_MSG_Mode1Reset,                  0),
 };
 
 static struct cmn2asic_mapping smu_v13_0_0_clk_map[SMU_CLK_COUNT] = {
@@ -1586,6 +1587,23 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 					       NULL);
 }
 
+static bool smu_v13_0_0_is_mode1_reset_supported(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	u32 smu_version;
+
+	/* SRIOV does not support SMU mode1 reset */
+	if (amdgpu_sriov_vf(adev))
+		return false;
+
+	/* PMFW support is available since 78.41 */
+	smu_cmn_get_smc_version(smu, NULL, &smu_version);
+	if (smu_version < 0x004e2900)
+		return false;
+
+	return true;
+}
+
 static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.get_allowed_feature_mask = smu_v13_0_0_get_allowed_feature_mask,
 	.set_default_dpm_table = smu_v13_0_0_set_default_dpm_table,
@@ -1648,6 +1666,8 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.baco_set_state = smu_v13_0_baco_set_state,
 	.baco_enter = smu_v13_0_baco_enter,
 	.baco_exit = smu_v13_0_baco_exit,
+	.mode1_reset_is_support = smu_v13_0_0_is_mode1_reset_supported,
+	.mode1_reset = smu_v13_0_mode1_reset,
 };
 
 void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
-- 
2.29.0

