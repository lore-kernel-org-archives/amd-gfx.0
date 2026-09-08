Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B87C79FA1
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:38:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EECF910EB54;
	Tue,  8 Sep 2026 11:38:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ujBHAYFy";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012063.outbound.protection.outlook.com [52.101.48.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD35A10EB54
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:38:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lJGtW+pUFucYipNLq72xrsZXOXeegOPRqx/+aua7/bqK4F1H5lNcixfdkfoCCAkYUTQD8+EarUTlhTpC9PiEWQT96zJGVA2lvYaZAAe/IiY/qnp6rbsgVu5FLzEtOBC1qhXKOXWGM2QEPVKcrF11k3SFs8jxSHut1GN6xNPvU+eDCx3a4mWPgp25wgbRECzwSwb3q5sAvwtLJS6EjF0vDJKUS/tXTzxIx8eFRTvF3Ow/wSLO599G2ON87cXJGuUR/7xskTICOALRD+ofBeSbVMz1EcdeQrKTuMUSADnscuNjcd3xwBZgFZTEvZDcAGpDFinKtbGrv0YIiG0axmX/gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcN+iM4A7rW445kDGsQ8AfI3otuP6QV0LTDnoRnOCSs=;
 b=A9418oSpgy2IZ76tIY449LeHwOnF+T8SBTQl+sE288ixb8pOipv9HReTZ9aAUifxF7TSN949cdMkd4EdKmxPdgnXpbf99Jc/0qMv/aYPSrF6/hUqn9lXBZH2IhYZ+cpDi1agnfnsGvL3PHYL3obejyEueiu3wVhx1ROw8vuOJrFo0TVeBTpkWlbQTBGxtoOfiFj/WCpWcpMiTcce3nE77SjKqmiI/zelZHt9f0Yq431DEHUjPU3qTWOFOOvK6f8GRsapjDZounHUZsVWu206od4Y+7AQ9De8U2bqW4G+q7LaQCYbvLIP1RBJEXmYyTxI2QqagakF1zCXCWy/Bq/WiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcN+iM4A7rW445kDGsQ8AfI3otuP6QV0LTDnoRnOCSs=;
 b=ujBHAYFyIilbUUT/PAlef9CuqD6PElm7S+f7nHWGhouM0lE+M/yhD5m+Q1d938XbgthbLXEa/ZgTBAYU6bW2J/4YSqoS1fbioXFa2nnvyqiXMR7LTtVHk6hW9gPO+TvqdT8Z+e7loEy+0Le6o4U25P46fxuFpN7b6jpQADwV8fc=
Received: from SJ0PR03CA0193.namprd03.prod.outlook.com (2603:10b6:a03:2ef::18)
 by PH7PR12MB7332.namprd12.prod.outlook.com (2603:10b6:510:20f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.13; Tue, 8 Sep
 2026 11:38:33 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::82) by SJ0PR03CA0193.outlook.office365.com
 (2603:10b6:a03:2ef::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 11:38:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:38:32 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:38:31 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:38:23 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 32/66] drm/amd/display: Add debug option to force optional
 UCLK support
Date: Tue, 8 Sep 2026 19:31:25 +0800
Message-ID: <20260908113338.2433445-33-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|PH7PR12MB7332:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b9061bb-4e13-422c-f0a0-08df0d9db5f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: rTeeqYZKJR8dayozIQrF08IezqgN9FHZCjeJT/XBnKZ1SkyImsiCbgmDdIxxbOELFiEk/Xi0E1RfOk22MparHqXMKIg43tgsQJWUxwJMm1yqkVJL6qv/KG7ER0kXNud/nfrXhUZYhGZsdNHhM4uDFVenNGfwyG588/iil8hT5nhJaZMax01u8CCR2KKIN6nOkKQsEPxbE4HZB5W9OPdDalf+AOP/SGmj/69BuQ5rYxKtf/ois4Kb4xVnMSwrw3b6l/9CA7ciV8WXDgCVgBE1qjpz6O53y4GbB2SCsVvuM2/AoHB8cuD5YbI6cgN0eC869l9th9qWTPTI2EDTYMB8SCf1CPrsUrqncsbpEG+cfOdiD+mFL8DxusrzOGvFk9MHSDy49XsaqrVaG+dbabMkatBxRvfxwo9ddXRL/JHm+m1wMajVPTPmTHnZp+ySsptDLa1yMcz8U0fRPlQYaqiswRdwAn6JpTp605NW8+YAmvnT4mRGT5Qgi2sULy5BTat6+Fc3TfToFaLJjllYPOPcKewXnw5vVAsVSxU35IV1pWIwlKYaQHuMoDEM/syMYh/wHycgP0rPdua0OP7eIKDrWFMgnMimGD/QJzW/fZ2DQs6W9u4f2Z4d3eZuECOVAWv4ZnlvFQHRae5QT3cfk9RBSrpoXqVybrrx5EmVzdeDFiAbXXWVGqT54t2qBNOu3aibmyXLT1pH0/VPU6SMEAtaEw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XryI45O7JvJi690FgCWhvNU0UhjTb5izg1rGemedgAb2AZmjHiti75afaVO+fgGk8P43wPr6bHoichdHXD8R3BKdHodFfWPPGE6RUKikfGgcjUVIldNjDrcNdXIKUKtI2VrIPY1KamwmrIIbkBhG+YIxm9RVnXKUNrtNlh16BtnhlJt+qprKXQ7rMJKcSw5J0B0gZWqQzsi6LnWz+HtepGCJMDScZzjEMzoOIokU3oZZtCshYeYOLu96QZb+Sn4MdWkLTgEElJUxJlW+JRx2/4jJv/UYSExBpzahRKTd88DvuFYlgFQlYULVA5BTQlnYw3mwoXRmsm9DQtw+v5nd0uzDPCMSxWp2Sc8nczgox7F1cUHSpPDl5mXOR1i6Ru4ngJ4IDYJGCs5C4/vGXYdRePgXF1qTKZxtMvj5fAucoj8fVFPs4co60aiHmxe2Jlxz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:38:32.2920 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b9061bb-4e13-422c-f0a0-08df0d9db5f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7332
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

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
Add debug option to force optional uclk support

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                              | 1 +
 .../dc/dml2_wrapper/dml21_wrapper/dml21_translation_helper.c     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index ab8c67ad1b50..1e25ed4eea80 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1288,6 +1288,7 @@ struct dc_debug_options {
 	bool dml21_force_pstate_method;
 	uint32_t dml21_force_pstate_method_values[MAX_PIPES];
 	uint32_t dml21_disable_pstate_method_mask;
+	bool force_optional_uclk_pstate_support;
 	union fw_assisted_mclk_switch_version fams_version;
 	union dmub_fams2_global_feature_config fams2_config;
 	bool fams2_imm_restore_drr;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_translation_helper.c
index 3c25de54d55b..366767f4413e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_translation_helper.c
@@ -39,6 +39,7 @@ static void dml21_populate_pmo_options(struct dml2_pmo_options *pmo_options,
 	pmo_options->disable_drr_clamped_when_var_active = in_dc->debug.disable_fams_gaming == INGAME_FAMS_DISABLE;
 
 	pmo_options->force_mandatory_uclk_pstate_support = config->pmo.force_mandatory_uclk_pstate_support;
+	pmo_options->force_optional_uclk_pstate_support = in_dc->debug.force_optional_uclk_pstate_support;
 }
 
 static enum dml2_project_id dml21_dcn_revision_to_dml2_project_id(const struct dc *in_dc)
-- 
2.43.0

