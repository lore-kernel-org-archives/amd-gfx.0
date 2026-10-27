Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950AD606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 23:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=aBkoYweB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3207910F89A;
	Tue, 27 Oct 2026 23:23:28 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010044.outbound.protection.outlook.com [52.101.56.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AB4F10F89A
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 23:23:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VAZ60LvwuU9evTkh7clzF/vBbyBMQU05xAot+Fa6B9rty8BPIE4/j+CQdRrkmP3ThumZDfDLrZBY3t6hyElPBt+h07IqnT9jrdQphPi6yXYQ8RVxzh/NK0WCs1z+xb6qMY/UjjjfZk4W7b6AJf1XjC4NQDFkrWf5LywdOWwVO031tXMH8FqRgWGMDRo+Df7PNDgLDn2KkKrUKPsIqRxT0BCwukU0yQiur5QOVIySBtPb2EOWah0pE6LlSsIZ1EINI9Wew+DKizpDtCUXv+++A9t3OjaPOLgBjvZdDM73zKC+nZNHOrIgPVTnmWNgtMaNsjj0Lo+2Dux8YpnfIdL99g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnOiFCcZPDBShcDGWdxv6vmrUd/WXIta4Sz1uJpMWI4=;
 b=woWV8P8RJrAPYf7aRzJqdVJu+3r8UwFFm3dho19Ib+bYQAvdw8drna8Nzid+sJN7uP9BTKHQC14lYHZcC5fsiQPnDTlWMDi7Uf/Ico94KMTfbbbgxmEFB2IHV0aS7ExBcYDdQ9kUxA3Vm3h4vL6sX09p8kIhYSNI7/KFufXxCXpdmlNASqJQyZLlpxpH4ZYkd8QMHkbUinRHFgIN5Fs/sMuhXvMVfKqzQ9qSThf+RMxEQUaU98hEwS+MahVZ5JwxFLN77TG2AXOGt0rzv79RlCtNU4PgVjfaHbSZ3F/44xxNgPTjyJnahMXK+Wy1z2I7XIoY3r9Zh/KphTSKYP+gcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnOiFCcZPDBShcDGWdxv6vmrUd/WXIta4Sz1uJpMWI4=;
 b=aBkoYweB7isrOTsOooVZroDKwIQVqGoastlUaSpX3kOp/Hd9piCa9OkkCZAvF+qUG5mieUTjOyG1b8nnnEbJehODRbuoDQqR7z8wkLbWMR50eh23k0tNy1Iq5RxIHpdV1/NJtje8HTYfBS3uhF5jrWxO3Pm/FLzdalNrGDTTLz4=
Received: from CH0P223CA0010.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::20)
 by IA4PR12MB176581.namprd12.prod.outlook.com (2603:10b6:207:141::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 23:23:18 +0000
Received: from CH01EPF000BE944.namprd02.prod.outlook.com
 (2603:10b6:610:116:cafe::6a) by CH0P223CA0010.outlook.office365.com
 (2603:10b6:610:116::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 23:23:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE944.mail.protection.outlook.com (10.167.244.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 23:23:18 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 18:23:16 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Austin Zheng <Austin.Zheng@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 13/28] drm/amd/display: Parameterize FCLK/PPT/Temp Read
 P-State Optimizer
Date: Tue, 27 Oct 2026 17:17:09 -0600
Message-ID: <20261027232005.2879750-14-alex.hung@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027232005.2879750-1-alex.hung@amd.com>
References: <20261027232005.2879750-1-alex.hung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE944:EE_|IA4PR12MB176581:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d7ec6bd-e632-4990-9baa-08df348148a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|22082099003|261026121527099003|18002099003|3023799007|10067099003|261026135527099003|261021133027099003|11063799006|261021121427099003|56012099006|261021135927099003|261022115727099003|261009223027099003|261021123027099003|261022075727099003|261021130227099003|261022105027099003|261022113327099003|261026140227099003|261026130827099003;
X-Microsoft-Antispam-Message-Info: q0wNyS2h/321AAXAkqw9siCJr+T82zl3FqXbdZ58ahkqhz6dN74PovGpcMS9PJ1rXxspgibXyiJAxe6CxBbMhl63VQbJuhNC39APuCMRKHGUs1eNdSeULBmNGRBMoqSANDTY+zBs0wmkpFxtJ6Ek+bKfnRVj7162FKstGCcO42FRdGOfxHhooC64RoeOn/9xfhrFyYS4svIEuyY0heycfRATlWeMaphKg41klcXtZb/kzrACU15PRGiYuL17soI0H0i0rqcrk8wTrsU554iu5wCrXL8g1q1X9ru0WUjWEEjAmM1mriXyjHEAHDEk6F3k9kxQoVNLS0iH08Ypj+f6arIEtnnDNIC8M0euZyKx7BHTc9Iv03xnIsa2uCDXtcW1WOBD/NysxhRrrUx8Kkfdx0I51FcdXa4/lLcQQQE/zo75w/j/eIEvzbQrOPnugbd70sRW9JCQYSsgw8ONbYuhIuOZJEhmmBcqAYo3K2rv1NPIhz2VBCzKb362GL3KReb83oIwtp/K4AOyLjvs8WSrJUOS8l2kxUrOV97RJUiVJmfA3tPcwp+/PiSGWp4ddLov1BHhzdie2nj7NxeM76HYwoqUhjcob9IoPS1wUpGW1NoFs5nc+C5eoAJEr8XDhhFMeqWVlVfLArD+TpvQw+oU3AUz0G2o/ioTyp4Mwg7/p4plkH3cSEaB0EvjOySC4AxKN8xg6DXRo+CX/Jxy1jXrZw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(22082099003)(261026121527099003)(18002099003)(3023799007)(10067099003)(261026135527099003)(261021133027099003)(11063799006)(261021121427099003)(56012099006)(261021135927099003)(261022115727099003)(261009223027099003)(261021123027099003)(261022075727099003)(261021130227099003)(261022105027099003)(261022113327099003)(261026140227099003)(261026130827099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 87AwTugj63hzddwYmMK185qKVPd2sbY1kXlCXQfEkGuXhTExJ9J4T07o1xcvkv+gPCjiyzdrH3NGKLSnKBhOp+FSKAWDFHGqNHX63lm9tRhwX+b6TNK30Lgl2O6MguIFn6UoiMDeP5xMn7KNEuqfbuopvX+cSIXhsNgQWm2tbWbvlXZD17tYUAfHIJtNKiQ4YtaZbpwaRzqFLIGf3DlMSSXDXCF7aCNtD2q5JhkIHUwzeZ8aWDuzCpBhiTlCTpiEmA4FndMDRyLsGCoqje3Vgrb+/Gwlj6yCVcQBdz1TMa0QCTiUJKiZ0x7nGGxEMOuLRoPx9xlVr0NXRf0KkR1i6i1qVyFMwxXpeTQuvHrIF6sIeqWEyjMXAoUgSn0IQBvpdTIOE8pl87aGP1x7JfW46ajsGaZqonhXkNq7lYHNa0z6eKeliMGTE6/eBe6jwKRn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 23:23:18.3636 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d7ec6bd-e632-4990-9baa-08df348148a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE944.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB176581
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Austin Zheng <Austin.Zheng@amd.com>

[WHY & HOW]
This optimizer is used to ensure mandatory pstates are supported.
So any other p-states can be passed in.
e.g.
UCLK p-state optimization can be done in this optimizer for a more
aggressive optimization.
Note that this will make the separate UCLK optimizer redundant.

Cc: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../dml2_pmo/dml2_pmo_dcn6_stage_optimizers.c | 25 ++++++++++++-------
 .../src/inc/dml2_internal_shared_types.h      |  3 +++
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6_stage_optimizers.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6_stage_optimizers.c
index 40dcaa6588ff..c4db8ff3ee30 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6_stage_optimizers.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6_stage_optimizers.c
@@ -1707,9 +1707,21 @@ static void dml2_pmo_dcn6_stage_optimizer_fclk_ppt_temp_read_pstate_init(
 		struct dml2_pmo_stage_optimizer *stage, struct dml2_optimization_worksheet *worksheet)
 {
 	DML_LOG_COMP_IF_ENTER();
+
+	static const enum dml2_pstate_type pstate_type_list[] = {
+		dml2_pstate_type_fclk,
+		dml2_pstate_type_ppt,
+		dml2_pstate_type_temp_read,
+	};
+
 	worksheet->fclk_ppt_temp_read_pstate.index = 0;
 	memset(&stage->func_locals->fclk_ppt_temp_read_pstate_optimize, 0,
 			sizeof(struct dml2_stage_optimizer_fclk_ppt_temp_read_pstate_optimize_locals));
+	memcpy(worksheet->fclk_ppt_temp_read_pstate.pstate_type_list, pstate_type_list,
+			sizeof(pstate_type_list));
+	worksheet->fclk_ppt_temp_read_pstate.num_pstate_types = ARRAY_SIZE(pstate_type_list);
+
+	DML_ASSERT_MSG(worksheet->fclk_ppt_temp_read_pstate.num_pstate_types < dml2_pstate_type_count, "Too many pstate types defined");
 	DML_LOG_COMP_IF_EXIT();
 }
 
@@ -1717,11 +1729,6 @@ static bool dml2_pmo_dcn6_stage_optimizer_fclk_ppt_temp_read_pstate_optimize_nex
 		struct dml2_pmo_stage_optimizer *stage, struct dml2_optimization_worksheet *worksheet)
 {
 	const struct dml2_pmo_instance *pmo = stage->pmo;
-	const enum dml2_pstate_type pstate_type_list[3] = {
-		dml2_pstate_type_fclk,
-		dml2_pstate_type_ppt,
-		dml2_pstate_type_temp_read,
-	};
 	struct dml2_stage_optimizer_fclk_ppt_temp_read_pstate_optimize_locals *l
 			= &stage->func_locals->fclk_ppt_temp_read_pstate_optimize;
 	const struct dml2_display_cfg *display_config = worksheet->orig_dispcfg;
@@ -1739,9 +1746,9 @@ static bool dml2_pmo_dcn6_stage_optimizer_fclk_ppt_temp_read_pstate_optimize_nex
 	if (display_config->overrides.all_streams_blanked)
 		goto exit;
 
-	for (i = 0; i < 3; i++) {
+	for (i = 0; i < worksheet->fclk_ppt_temp_read_pstate.num_pstate_types; i++) {
 		dcn6_get_params_for_pstate_type(pmo, worksheet,
-				pstate_type_list[i],
+				worksheet->fclk_ppt_temp_read_pstate.pstate_type_list[i],
 				&l->pstate_allow_delay_us,
 				&l->pstate_blackout_us,
 				&l->pstate_watermark_us);
@@ -1761,7 +1768,7 @@ static bool dml2_pmo_dcn6_stage_optimizer_fclk_ppt_temp_read_pstate_optimize_nex
 			dcn6_build_pstate_meta_per_stream(display_config,
 					pmo->ip_caps,
 					worksheet,
-					pstate_type_list[i],
+					worksheet->fclk_ppt_temp_read_pstate.pstate_type_list[i],
 					l->pstate_watermark_us,
 					l->pstate_blackout_us,
 					l->pstate_allow_delay_us,
@@ -1772,7 +1779,7 @@ static bool dml2_pmo_dcn6_stage_optimizer_fclk_ppt_temp_read_pstate_optimize_nex
 
 		/* always update the worksheet with latest requirements */
 		if (dcn6_update_worksheet_for_pstate_admissibility(worksheet,
-				l->per_stream_pstate_meta, pstate_type_list[i])) {
+				l->per_stream_pstate_meta, worksheet->fclk_ppt_temp_read_pstate.pstate_type_list[i])) {
 			modified = true;
 			DML_LOG_VERBOSE("fclk_ppt_temp_read pstate not admissible with current worksheet, adjusting the reserved vblank time\n");
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h
index 6f527760071c..fab9d149b3de 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h
@@ -644,6 +644,9 @@ struct dml2_optimization_worksheet {
 
 	struct {
 		unsigned int index;
+
+		enum dml2_pstate_type pstate_type_list[dml2_pstate_type_count];
+		unsigned int num_pstate_types;
 	} fclk_ppt_temp_read_pstate;
 
 	/*
-- 
2.53.0

