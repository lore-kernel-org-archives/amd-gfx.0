Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1845A606A321
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rOAYCiEI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E6F610F8BE;
	Wed, 11 Nov 2026 01:41:26 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012026.outbound.protection.outlook.com [40.107.209.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0926710F8B7
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:41:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k14wyrejnpau+3/euHxtLoXHeROziIrCUTJlHzjJgVLXW+Umw1tZgBVaZw2plCcN4sxsK+ooU0nOZqlDsBwcDyNT5V2c9PWbs2giYooACexDTwxWt0/1FZQt30MkFdXmrHN3o9ENeQIeF8hBGPNTrE3TOkh7SVL+CTgSpbHipKzjnUuH3WqyOGihISo8jezSghgdKZOUMEaEfsY9givyYwMwTYOUJR7zHooiRAYuuc2b/FpQEUYCiRo3V83r2Kmn0z3YjWAMZ0ojnSfjmvKNL2UDxSmFtwgh1RfuYkl/0eaqcW3ujIXO8v7VyEnPYvSQos7oUw8HH6CpA22ug3hwqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wnopd+CHqkQv0BIzfd+DtnT7gtdnRUjA04atyFAWPn4=;
 b=u4UcUp9XHh672afNjGZAUgG5M0fkkNJDAdK5OidJFNIMMqC2V1c27vHh8dTm/g0UOL5OTjsoANZHcEpQt8pLtKU82mfkIs4EYt3C+docZUfC/nyPfr6hJ7hUsZn0QVhczFKMLEBv82j7UxksnXGKmoFvoe7yWBFxHScFY873DbtbvBNN7nd+j1naDLS6duvpkZWzl34/myMMKPKSRLps4Ow8Gox2d52yda99P5QfalymUstO08D6dGeQjT5mUvFUbx6fjj5afhksB9CW7/iVJPq3ayTFQSlZk3PbUctvMf5XtQsH/B1HmcySNqkPrj2ikGjOECdTN9iTL5qGVK/Nyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnopd+CHqkQv0BIzfd+DtnT7gtdnRUjA04atyFAWPn4=;
 b=rOAYCiEIqMRQFzNXRGh0ZQWqd/V9B15tUnKNotGHb2EOtT5OxvLc/ve5Hkmj0YxoOqrsLnZZIaGgI8swY+Y7HdosR0iNPViO7dfcRUlrci/dJnh3Xnwkr6208ySho/u9H7KvocM9/dkTrxOihB61Uw3XKLH+va15vjdrFacKGS4=
Received: from BY5PR03CA0029.namprd03.prod.outlook.com (2603:10b6:a03:1e0::39)
 by DS0PR12MB7559.namprd12.prod.outlook.com (2603:10b6:8:134::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 11 Nov
 2026 01:41:17 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::8d) by BY5PR03CA0029.outlook.office365.com
 (2603:10b6:a03:1e0::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 01:41:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:41:16 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:41:08 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:41:05 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Sreeja Golui <Sreeja.Golui@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 12/74] drm/amd/display: Include Ramless Idle in stutter
 relaxation
Date: Wed, 11 Nov 2026 09:28:18 +0800
Message-ID: <20261111014100.3596072-13-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|DS0PR12MB7559:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b20efaf-9f8e-46fc-08ee-08df3f94e0de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|18002099003|22082099003|10067099003|261026140227099003|11063799006|56012099006|261021121427099003|261102123227099003|261022105027099003|261021123027099003|261009223027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: zMZtkQpw9e9CqOIq7U1zhoWJvE0Xd134kMeg+BlNQNNwt5+ZVadOH6BhmZoNPR7/z6WPhNVSP2wMLfMVKzuRs+e+QsTSKnSnPQOtL+WsJ7xZLQlt0XCC4QGkrH7E7Dq6pH3JTZsyYJkBZxje/pKgOfEeVfI48LUwI4UPRLYH4+8eeR/bLDEwHS649atBL3QMgXvFvWRcKLR2KQjZ1OpjmeuPByuwoSIO4XCClZ9pERf7E1h0GvUm+LBZ00lCo+Brv1sSZMt/rKwKHo4hQmyHKl3hT50ny9fAsDTIZoURalNLRKxWAiMkRFi3WDDrfuRt3wd9/TDGKGO96PmfnsCbm9pafWPYzMi8Noj8OLJUHLdPAm2kxBccbl0hjHEQk7I9eN3KONLQIb1X4JlIJ8sMeu3KFLekb979mZ7m33gHx/a/Xg00AbvfM+ZKGVBvbfreC5epU9tP1aw9XwAKKOuYlCTz20c4MrAvnPe7OFSVIKyXtMNlJY38bJFbi9ZzoL6AYzIRTi4XdrLBVjYteYg1Uu99FyTx/DCgPLdgN3afxqjxxRnvviANvP1bglhnZTQq+wIFlugyEVAwDjXsRowZdHr+Wsj5K/3uaVZYEXywnCyxrWurfwtX7VMkG3MDTceSZlJ6ihcnw/Z5+VeS7IxJmdY3hkzdG1aLdQfrNUEEPJDseA78m1QdHs2s0yg3tyC7MqbkAIQMUfVaHbqwsMbyNg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(18002099003)(22082099003)(10067099003)(261026140227099003)(11063799006)(56012099006)(261021121427099003)(261102123227099003)(261022105027099003)(261021123027099003)(261009223027099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iASRG0dfqqimXY4IMmQos2G2Hdvw0pPOeHdyJWPTzs5w/kpZKzxBdgdUlmMVoWUUSA477kyjZoR7YNBtXMiaVnHYUdfpla8GkRV2MPWErkb2pDICL04t1hmOzgj2+7ACid8XpoenSzbLD5e4ISO5ywcfZjkY3QU85Yfg/XNs63oNlMGXkJQw3azpT9Ms4Zm8G1KDNvMOmBaJqtSHZ6TiWzw8uXP2gudjJ5yfRkUmjI9EurQowu2OvQZW3iSwLd3wwrLTtAHmX4dV8tC0U2J5t01P/Pz0lRukvtWeWPp3upqo/DnToFR8nH7SCFdfzV7kxctMBgnYOXRML1Ai8TapnblMyNc2yx+Ob9osWQeEQbIB1RuUwKlWDFcALw7S73C9wM+B+pCBFRNxooXZEJX/2iGfVs0g+Fz+I64/3YYhPdMFTN9ooHyXJ0bp9il7ra1p
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:41:16.8998 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b20efaf-9f8e-46fc-08ee-08df3f94e0de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7559
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Sreeja Golui <Sreeja.Golui@amd.com>

Why:
Ramless Idle static-screen streams can also use extended blanking and
should receive the relaxed stutter constraint.

How:
Add a timing flag for Ramless Idle static-screen mode and treat it
like fixed DRR when deciding whether to relax the stutter factor.

Cc: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Sreeja Golui <Sreeja.Golui@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../display/dc/dml2_0/dml21/inc/dml_top_display_cfg_types.h  | 1 +
 .../dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c       | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_display_cfg_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_display_cfg_types.h
index 27ffe7ed11c7..816443c9427b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_display_cfg_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_display_cfg_types.h
@@ -289,6 +289,7 @@ struct dml2_timing_cfg {
 		bool disallowed;
 		bool drr_active_variable;
 		bool drr_active_fixed;
+		bool drr_active_idle_static_screen;
 	} drr_config;
 	unsigned long vblank_nom;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
index 3584dbe4c9fb..62ac29dfe9be 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
@@ -2361,9 +2361,10 @@ static bool should_relax_stutter_constraint_for_stream(const struct dml2_pmo_ini
 		unsigned int stream_index)
 {
 	// relax the stutter constraint when:
-	// 1. Stream has DRR fixed enabled (assumed blank is extended sufficiently beyond nominal)
+	// 1. Stream has fixed DRR or Ramless Idle static screen enabled (extended blank)
 	// 2. The option to relax stutter constraint is enabled in PMO options.
-	return in_out->base_display_config->display_config.stream_descriptors[stream_index].timing.drr_config.drr_active_fixed &&
+	return (in_out->base_display_config->display_config.stream_descriptors[stream_index].timing.drr_config.drr_active_fixed ||
+			in_out->base_display_config->display_config.stream_descriptors[stream_index].timing.drr_config.drr_active_idle_static_screen) &&
 			in_out->instance->options->relax_stutter_constraint_for_drr;
 }
 
-- 
2.43.0

