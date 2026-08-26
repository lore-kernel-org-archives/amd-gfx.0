Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EAA0C61DBE
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:16:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE77510EE2B;
	Wed, 26 Aug 2026 23:16:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r509V4ti";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010027.outbound.protection.outlook.com [52.101.56.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 775DF10EE2B
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:16:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OVLoCVLGfRAPa8gNh08AsOqZfVZugdu8aCiPbmjOgx1707Lqzp57hE/GQLLQkviZ3cyv01oLjq+wRWx628I+AMei/fFoWZqorpP7IDpJ8NZp1L5LraZr+Lf+cJ9A7WkUOwAzbgVbd2pdHIYOFUySdYJoZw0bsebB2nFlKHhojyz3KjxGmZ9Zh+G+C1Usajs9r8AOKNyBLVi7MdtBGPF6iMz/aLWIEvpVxrYGSuKz6yUaOAPDL6Gf2t4KW2AqDYTl0XHgrhmv0Kj7xlfzxcI5hU7RLixC2YhJF7IXwtkCIOIsd5MzLD9Smo5HLH0cJ8VXv1mFjbFkZhSl9c9ExGi57A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lRg7inxNitfmfeu3UKgbDg35m5CddsvDbZxq5qjIXo8=;
 b=EGXECRNowZPQiBI8sEzIgKSj6uK4Sxd26SDSNusk0K0D8mvoL/7iyuWXKLn7kTm4owK98F5ZSaLz2VVlw/d+glB8io9nO3hOfcwAnoMfi81IyksjvIqsczoM88Rn/GIK0iLm5hukU2hH6WKMWn3iPVevRsAlEvj5ANEtFv3rm+iYANHh6JvOvlca5n70msnVkldEHW3R7moM1bnTLzjCCbA9ZBpRJXM4p+lNyXwDX/7sLLAAgHPweAOIMe4R1IasmmWR+K0q64MS9VA7PJpGJ8U93RL4U0WF3N2/TJ2O7gESWq93KYaf8cbjrX9iDvcouZ+oq5vwWXSSGoYhpSfV5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRg7inxNitfmfeu3UKgbDg35m5CddsvDbZxq5qjIXo8=;
 b=r509V4ti6Yc0WDOrdH6ZndMqKfnQmrslrLDWrnajopQKZXiQhVXPtQBc/mHaOo3ond2xcaqNdby2wEruD1UDQwOlscMEkRTsGad9JIhFYKEdFltqn9rePfgoKMwMfB48mm+joN9+/49VLdORXNWat0WCp29oMQ43AJe9j2iUdaQ=
Received: from CY8PR11CA0024.namprd11.prod.outlook.com (2603:10b6:930:48::24)
 by DS7PR12MB5934.namprd12.prod.outlook.com (2603:10b6:8:7d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 23:16:10 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:930:48:cafe::a2) by CY8PR11CA0024.outlook.office365.com
 (2603:10b6:930:48::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Wed,
 26 Aug 2026 23:16:10 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:16:09 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:16:04 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Hansen Dsouza <Hansen.Dsouza@amd.com>, Leo Chen
 <leo.chen@amd.com>
Subject: [PATCH 01/59] drm/amd/display: Add debug bit for force p2cpm
Date: Wed, 26 Aug 2026 17:04:32 -0600
Message-ID: <20260826231519.881949-2-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826231519.881949-1-alex.hung@amd.com>
References: <20260826231519.881949-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|DS7PR12MB5934:EE_
X-MS-Office365-Filtering-Correlation-Id: 98c74ffa-647d-4575-b446-08df03c80398
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|11063799006|10067099003|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: 3sVUOhqvYWWXKuSK6OBBb8syGqx+7Svf+ZZOPrqHAr6MBRHvo7s85HCKWo45tzAdkfxIEXwjU8q/R31HyGeLmk3H+KG2aE/etQ6PS2EeiTfyohc1QN3PvIWd7tvikWREO7C8nK/tKbpjVblPHSc98EVaf6WNQgjGf0DADPXyHEC7aaTQ4JwKI+2DwmbA7smiU0SNqTNyo/5BMCx18R2LBmA4DR6qzHHUH1aX9o5+mn6UghE4VHhigWAkApj9Hoc5FZr2EBnqV84u4fwqcSkjNvO4DAAySWk59XUvMojDCapNHf1QCPc0sWMJKlvzrolY8dBLTcjB0Jl1lqyrVX5qxi19BpwGa6im6Q/terzdOHZf1P5eRwd3JYDipVyUXSeGZJL4pkHWJ49kI0qZ78oFk/7sJX1ZF5XL3ZbWPLsbp1IYvGOfm1qb/XDNQUdiooQ3qv0+NWXjhdYcuvOZb/Fhp6/u4aQw/wNX4w8n6eMmKCZFo5nuYy+W0lWyiSWPh32xZMg+FMgd041DtAeRTcGm4ia4OABZ4LGFXZHpYGMXnHdD9phMYtppb2qNTweKg8KQh+hJBP4UzdTYcq73XAdp+/bfeS01xxJ9yhEL+C5IMlgQ9bYDKG5yr3mnoUvTQQ9oIvTRH+rN+nwhB7PvGJLCaLtcKE57NEgA4ymZmi47EuaiRDgyC4KPl3afIJdhbjorb3TjmRAZ2CQhwEudBpEZww==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3x5xWGHSkHvO3zkn5lLOtYNiOlRiap4FL14AX9HqyxcQidvVaidRYcT6jliyK2eLWD+uxyEM+aaHlgUdP7afAkkUIR4XQceM+59J9c+5TxGf72UrAC7PMeQy3aWGiPrHzq/UCkXALUMBZIfN83n51ke17CtBKz0gjizzs2b8xRWJdlurvzqu6Z9mT6dwUePhAbFCzA0E2zEZ7fpAt3DkhgBAtXOK0Eb4XyCxU7EEwDPV9YPadoh44e2hfEjbP4y9HPW5IrFKFHLg6sdjXbwadqoLhTu2OWGN8T02poaujSSsx8WXuHl1ZPMqp3yoAYSwNCe8z0G40BcGotdteuqgQZmSlhvmp7xY7Qs7SWX1ZAUq/3haLU+7mRNnO9SdhlrXpvzM263te4FgbUNGUVquEPxTtCJRJIJnDgs/PL681O70qMU4yt42/n4+T4MBJsgw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:16:09.7702 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c74ffa-647d-4575-b446-08df03c80398
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5934
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

From: Hansen Dsouza <Hansen.Dsouza@amd.com>

[WHY]
To allow per panel control of PHY settings.

[HOW]
Extend panel workaround bits and fields.

Reviewed-by: Leo Chen <leo.chen@amd.com>
Signed-off-by: Hansen Dsouza <Hansen.Dsouza@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                            | 1 +
 drivers/gpu/drm/amd/display/dc/dc_types.h                      | 3 ++-
 .../drm/amd/display/dc/link/protocols/link_edp_panel_control.c | 3 +++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index a5a9791ee100..1ccd10533e0b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1321,6 +1321,7 @@ struct dc_debug_options {
 	bool enable_replay_esd_recovery;
 	uint8_t iommu_mismatch_temp_wka;
 	bool disable_dynamic_expansion_for_test_pattern;
+	bool psr_phy_force_phy_power_down_up_level_2;
 	uint32_t dml21_custom_derate_num_dpms;
 	uint32_t dml21_custom_derate_at_dpm[DML2_MAX_NUM_DPM_LVL];
 	bool override_utm_client_qc_profile;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 64b4adee36c4..01f7c9addc6c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -689,7 +689,8 @@ union dmcu_psr_level {
 		unsigned int SKIP_SINGLE_OTG_DISABLE:1;
 		unsigned int DISABLE_ALPM:1;
 		unsigned int ALPM_DEFAULT_PD_MODE:1;
-		unsigned int RESERVED:20;
+		unsigned int FORCE_P2CPM:1;
+		unsigned int RESERVED:19;
 	} bits;
 	unsigned int u32all;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index e3527b14686b..5a8b480bb9dc 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -883,6 +883,9 @@ bool edp_setup_psr(struct dc_link *link,
 
 	psr_context->os_request_force_ffu = psr_config->os_request_force_ffu;
 
+	if (dc->debug.psr_phy_force_phy_power_down_up_level_2)
+		psr_context->psr_level.bits.FORCE_P2CPM = 1;
+
 	if (psr) {
 		link->psr_settings.psr_feature_enabled = psr->funcs->psr_copy_settings(psr,
 			link, psr_context, (uint8_t)panel_inst);
-- 
2.43.0

