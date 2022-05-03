Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E05C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:09:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5763E10E996;
	Tue,  3 May 2022 20:09:12 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF44D10E996
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:09:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKYW0a8LxprTYsuvUJK0/wMtr48/m4nWOn8N5QprcyTutKxST5Ut/zxRLwAxUV4rkE6Cja2nwE65yf4VqDNbuhXmU+crEpQ7dnA7c4Sbob0CzzjTTeSK9xEwUvFXr4SSMpa/oSg/yuS9f7PvUvfhFSkW6swOTQwohU27avnykVKrpcG5gG6hIYXpvSQN4saWMxnXU4On6FCiM3dIX7dxcaxYVPtOcX9BjKGMELFkVdd5CD5nFVZnueeapFZZ9vJhCsermag1t6bp4tV0W9r4XzBlCWCdK0jX/kvmkM64QOw9LwI8rLJSmBKAct+atIEuYbb+OreCTLEV9oXn/e/tmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rh6ayJ9YFl6Zlt/2935O9hbo+nkR3pbgJLxI2PoMuBk=;
 b=PZI0hY6KI7ile5MAes4DtQrgWsuvNE0gXBu+rRzPKOi/xfGNOTJISXBnCxwzJfmBLqYruCASWan7vw1qhEEmP6btODfIjFy+QDoUIOOWwHgRkhxZXCt3+TrtIvz79kg+rn4MeGNaKNNbIkHtDuiP2a5TEAwIanIWDtzjrH5gug89NNozudnP63Wft7kuh9truHWOTsKJM5l/zbEq5yJKKacj1MY9YlFslnvl+MLOjn21bOESiF0werQQ5bWiCJ8AwRCuZe6/r1uH24WXm+Au+KWnt5OjRA4BwRMIA6QU36mLon+kBU+tDdtP4UaRMjmy4BJDex/S9AeKwSZ1zc+oqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rh6ayJ9YFl6Zlt/2935O9hbo+nkR3pbgJLxI2PoMuBk=;
 b=II/MvEeeJK9UstoMUU0ZHrnQHmMUPY+7EMJSmEZj+dPmc3MhKjckdo2Tp1uiekKUQumX7kwiL6fk5Kx1t4nanuK+GECcYipTHiHpSBFbeK4yyEKbwu3SM5j12VSU2wo0RvB17ukVl//Er5ixDtXwPzZFrcLZvSGWlV27De8PKkM=
Received: from DM6PR07CA0049.namprd07.prod.outlook.com (2603:10b6:5:74::26) by
 BN8PR12MB2978.namprd12.prod.outlook.com (2603:10b6:408:42::30) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.13; Tue, 3 May 2022 20:09:08 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::60) by DM6PR07CA0049.outlook.office365.com
 (2603:10b6:5:74::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12 via Frontend
 Transport; Tue, 3 May 2022 20:09:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:09:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:09:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: enable power limit retrieving and setting for SMU
 13.0.0
Date: Tue, 3 May 2022 16:08:31 -0400
Message-ID: <20220503200855.1163186-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 584ffdca-3696-46be-be2e-08da2d40c7e1
X-MS-TrafficTypeDiagnostic: BN8PR12MB2978:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB29789DE01F2A3DFD79012CFFF7C09@BN8PR12MB2978.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K6zMF2nf8cbtNHI2uChq7ph0E/CS+OqJ1EfzVf/ipOy8DwvlMUKLey7yBw6hdiYilJKYJeg2Mtrcg2rhaGfUbQzC8IpsO7KpEIAY4D1nCVdvkzfbd3MDY6lYCR7GHOPhgakNds+zF4+Iu4/5lYC+ZzcZ0DFtx2mJzpOqaKKqpA+1g6Z2WDQ/l8OTeXYFulR0CTw5Fpfz2eAuOpAaajZhNT38qEpjBYuu3YN+DAUYrvZhhnFN7KrkmZTtN3Wu9aZSgIT/Kgk/oj9lrQSet3rIQcU0AjAceQ/AZd2bFc/+G94d6KkpQm2mfft8Nv3dAARbZGPnCW+FOFe2l6/PMkJh4Fw5C0h4onZYPIuk/8ndLkFyH16eC5Ps6DvnZjqmNKcQoXmAOL3HJKTxn6huiw+IsE7xeXFaiP5bWU+OJ/ESEbNLhioGO66aY7fWLQsJ1mfm/2en76Jn+iKy0s5b9Ija9/cvUdVJenkydiJSN5ZlgDTUl4g85g80E2mbXHN65MoCvSOE0GhKNbPG5dfk1xLLrghLyXnvqkSX5icKxCB/g4vAXAtwm0pSEBJ2yiYR6g4eRCLNDSKNgorwa6k4CNw0pLUTk+8ajXXtNbNFP1gkW9YJg/K9+SH4BRVtnydEHwLEU2I4dpLN7xcfknVwiKDgyV5vvWf4MDP9FOkhSeRahdw+wUDNoftg2PW3J1oKxGKldwXhNI5Gb8vQwh3EacItjg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(70206006)(8936002)(4326008)(508600001)(6916009)(8676002)(54906003)(16526019)(83380400001)(47076005)(86362001)(36756003)(1076003)(36860700001)(316002)(70586007)(336012)(40460700003)(2616005)(2906002)(81166007)(186003)(426003)(5660300002)(7696005)(6666004)(26005)(356005)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:09:07.9869 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 584ffdca-3696-46be-be2e-08da2d40c7e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2978
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
Cc: Lijo Lazar <lijo.lazar@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Evan Quan <evan.quan@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evan Quan <evan.quan@amd.com>

Fulfill the interfaces for retrieving and setting power limit on
SMU 13.0.0.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index e4bc8d85b151..f4184ea90e86 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -114,6 +114,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(AllowGfxOff,			PPSMC_MSG_AllowGfxOff,                 0),
 	MSG_MAP(DisallowGfxOff,			PPSMC_MSG_DisallowGfxOff,              0),
 	MSG_MAP(SetMGpuFanBoostLimitRpm,	PPSMC_MSG_SetMGpuFanBoostLimitRpm,     0),
+	MSG_MAP(GetPptLimit,			PPSMC_MSG_GetPptLimit,                 0),
 };
 
 static struct cmn2asic_mapping smu_v13_0_0_clk_map[SMU_CLK_COUNT] = {
@@ -138,6 +139,7 @@ static struct cmn2asic_mapping smu_v13_0_0_feature_mask_map[SMU_FEATURE_COUNT] =
 	[SMU_FEATURE_DPM_VCLK_BIT] = {1, FEATURE_MM_DPM_BIT},
 	[SMU_FEATURE_DPM_DCLK_BIT] = {1, FEATURE_MM_DPM_BIT},
 	[SMU_FEATURE_FAN_CONTROL_BIT] = {1, FEATURE_FAN_CONTROL_BIT},
+	[SMU_FEATURE_PPT_BIT] = {1, FEATURE_THROTTLERS_BIT},
 };
 
 static struct cmn2asic_mapping smu_v13_0_0_table_map[SMU_TABLE_COUNT] = {
@@ -1305,6 +1307,44 @@ static int smu_v13_0_0_enable_mgpu_fan_boost(struct smu_context *smu)
 					       NULL);
 }
 
+static int smu_v13_0_0_get_power_limit(struct smu_context *smu,
+				       uint32_t *current_power_limit,
+				       uint32_t *default_power_limit,
+				       uint32_t *max_power_limit)
+{
+	struct smu_table_context *table_context = &smu->smu_table;
+	struct smu_13_0_0_powerplay_table *powerplay_table =
+		(struct smu_13_0_0_powerplay_table *)table_context->power_play_table;
+	PPTable_t *pptable = table_context->driver_pptable;
+	SkuTable_t *skutable = &pptable->SkuTable;
+	uint32_t power_limit, od_percent;
+
+	if (smu_v13_0_get_current_power_limit(smu, &power_limit))
+		power_limit = smu->adev->pm.ac_power ?
+			      skutable->SocketPowerLimitAc[PPT_THROTTLER_PPT0] :
+			      skutable->SocketPowerLimitDc[PPT_THROTTLER_PPT0];
+
+	if (current_power_limit)
+		*current_power_limit = power_limit;
+	if (default_power_limit)
+		*default_power_limit = power_limit;
+
+	if (max_power_limit) {
+		if (smu->od_enabled) {
+			od_percent = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
+
+			dev_dbg(smu->adev->dev, "ODSETTING_POWERPERCENTAGE: %d (default: %d)\n", od_percent, power_limit);
+
+			power_limit *= (100 + od_percent);
+			power_limit /= 100;
+		}
+		*max_power_limit = power_limit;
+	}
+
+	return 0;
+}
+
+
 static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.get_allowed_feature_mask = smu_v13_0_0_get_allowed_feature_mask,
 	.set_default_dpm_table = smu_v13_0_0_set_default_dpm_table,
@@ -1351,6 +1391,8 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.get_fan_control_mode = smu_v13_0_get_fan_control_mode,
 	.set_fan_control_mode = smu_v13_0_set_fan_control_mode,
 	.enable_mgpu_fan_boost = smu_v13_0_0_enable_mgpu_fan_boost,
+	.get_power_limit = smu_v13_0_0_get_power_limit,
+	.set_power_limit = smu_v13_0_set_power_limit,
 };
 
 void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
-- 
2.35.1

