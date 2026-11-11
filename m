Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9510C606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=iuUaQ9ja
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AC2710F8D5;
	Wed, 11 Nov 2026 01:42:48 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011027.outbound.protection.outlook.com [40.107.208.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C367510F8D3
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:42:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ttGIU2TmNUHYEayqrHBjilz5eUIonQ8exIVvNco3FVAYKpy6ScyyGvZpwS5Ap5Nul4OcqMW/GyO7rbIOEva2MyJwwB0P9xfSY0eCPr3jblgX7KxaW7r47nTBjdXlPI2lVUGU8N3rtsVsEB6PufwBLCB8lRAHsdCBv2DfMY+YuNEkf4pAPNvonrsc07OSwSrzKU8giw3G8oRmadvNaW/a+6j2xSKQzGtIZ+JULO6dKdPS0ijJ3oyqxzSXfN9J5wKEpsDofEFSdJZXIQAZJwzUFNgKQkJs466vdWWk/zyG7mVwIfDlVpUrNoCFFCPx/YZIO7jK6nF8rKvjNAqG3PMxyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ulay33d2KshaZ0i9FtsR1DjcI8lTnOpKIITJdxAeIzo=;
 b=WnNmuBAr4O3wE/ZPLpM1zBRQNbHC9FqNzz95ag1Ku9PamwgYu6RjHzUfOl/g8cnf2zQXWMoVzkRVp4Apwg47DXYHzdUVwODa/wntmEcLcUupKDZ8YakOFBHROnVVT8UoWIPScAH6VD+PqCTLAU7VDsLiEMRVS1Gdwd9eFR2eGMJDvp9A6UAHLLBw0jslJ/HKcHB+n7kTaROkgsBzpGvwGpMCgZooeqU4wqDovVjfRYLfUKSkZ9TXT8euDwKtKNaVexeYmbTozgc1bdO2M4Oq6lSg3SpgMgT9+jEqsZg/OpU4iASqKCc3m/oII6FG/1ZvvesNzNbTu3RIDq0SO9h2uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ulay33d2KshaZ0i9FtsR1DjcI8lTnOpKIITJdxAeIzo=;
 b=iuUaQ9jaAsiVleDP2g8QFZJ098KSSvKLQ8I/OPu3B48H/TJR1IbeYniyFQe+/LnC1TzTwfuMLQvwV87NmsCLIAvHGSbB1Nwmk1JUEpd4sCNdEpIb9TM+FmR7PhLJq8tC81pXE/rLusUDvKw0+m7x5mh+yhTN8BlWMRUqD/anOss=
Received: from CH0PR03CA0379.namprd03.prod.outlook.com (2603:10b6:610:119::6)
 by DS0PR12MB8071.namprd12.prod.outlook.com (2603:10b6:8:df::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.8; Wed, 11 Nov 2026 01:42:37 +0000
Received: from BN2PEPF0000A801.namprd02.prod.outlook.com
 (2603:10b6:610:119:cafe::21) by CH0PR03CA0379.outlook.office365.com
 (2603:10b6:610:119::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 01:42:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000A801.mail.protection.outlook.com (10.167.245.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:42:37 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:42:36 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:42:33 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Dillon Varone <Dillon.Varone@amd.com>
Subject: [PATCH 35/74] drm/amd/display: Enable DRR stutter constraint
 relaxation on DCN42
Date: Wed, 11 Nov 2026 09:28:41 +0800
Message-ID: <20261111014100.3596072-36-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A801:EE_|DS0PR12MB8071:EE_
X-MS-Office365-Filtering-Correlation-Id: d46a3108-7c55-44f9-1568-08df3f951098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|10067099003|11063799006|56012099006|261021121427099003|261022105027099003|261022075727099003|261009223027099003|261102123227099003|261026140227099003|261028144727099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: ngq8KF+LwufMSLOEJL3BklsH3d9NnvoB8ygvFU4ickXuD5TN+K2wEn8+XiDVD57iJJSxZIHrpyduNQHJMV/eDXtTGs08zNT/LMdX6kopdN6x7Ffbskt510VExwCPvHG7AYILPXDVQHNZ4EojtX1aJgxCN2Rqxvlcu+hAAMyoxNKRtjFlzoDomyGWdp1R+MMdDRXrc7VtmBar/zCcy7WSxZtLw2VzswfUWYNvmUQiJRiYJIj7KVSHwyuS5sph2JBijhJH8g2Al7CFjCGprfWKmo1h8dVA3EMevyaEJgXuPt843lKH4mz9jpsi6Jtsp4PPOJRhq5mvHPrT1A6vaZD3Y+AqB0j3F7pYeUfSAt9aRE1H1lfGFCFNHylAAoenfonxYhLIiUQsgqKhzc/iyM3zVqcdkKvOm3GbYDTCvsyCwuJS+Oo1wPMCaf7/BZ0wH54G1h0fUyne0HUXWpsRSuRqXTqxWaQC3f9LKsGTJvMhIGon+AdOrcRXcKdTw2VRUuh4czLsYVWRa1u3Zzja91hFMPa3Ws4NfQiPPmcs9OtDYkXQsIVjINUX9r+AfN7xn93l7Q2yC5vBx/Q3kJ7qvVJ5BaULuR5DV6JV4TYDar58Uk4W7XZbW2mm81m/AE7rFzA8Pdpfy19jkSVoUj8Q0eEKRrtMZY/ES07GcnEnNKYb0XrBCfQD+eth9GpEI2KQSpc5PX308ztkkGsGrFunhzag7Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(10067099003)(11063799006)(56012099006)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(261102123227099003)(261026140227099003)(261028144727099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mrDMK5UiHAast6+6KXBtVnxwJP/HOSd8K68NbIZiZaxICALAIhUkUpVacKWTquhfvix2uH26sSyjUme1XY0H6Jbal0J8X2jVuBoDj8lsu8IG+7csW8PbUtxwUq8AjoDvIQxiHRzQDUiSd9D3cKYQ5dQQt/CRl0oCwcVUWRo/M4o4oc3m/fDQ7IEZO0y+H3gLWWwymbKLBseA1Ykr18AGxYcQR0GxNpydTKFEP9VWkLzyMyS6Qr5TjR9d8H1RsHeaC2g/w9vmgiRnBMvW5qgOdLV8rBhKOua/V2P/i2aUAPG62U520edetSG5K/3j4XP3Pw9w8ZfZT1KTpoimDU+wmCeHjA4PC8dJJ7zyUHjIKQNv8sNMgD6bV3cWhi95+CBA36WYo+S7B5qwAOBhbjiW7AKn+NN3CIQImNIqJn2bVwUie5PrG4nR5VTj7AR6m6IC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:42:37.0556 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d46a3108-7c55-44f9-1568-08df3f951098
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A801.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8071
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

From: Dillon Varone <Dillon.Varone@amd.com>

why:
Fixed-refresh DRR extends blanking and can use a relaxed stutter
constraint to improve Z8 optimization eligibility.

how:
Add the wrapper PMO option for DRR stutter constraint relaxation.
Pass the option into DML21 initialization and enable it for DCN42.

Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../dc/dml2_wrapper/dml21_wrapper/dml21_translation_helper.c   | 3 +++
 drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml2_wrapper.h     | 1 +
 drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_translation_helper.c
index 6a9f822b2b33..dc65750a7fe3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_translation_helper.c
@@ -40,6 +40,9 @@ static void dml21_populate_pmo_options(struct dml2_pmo_options *pmo_options,
 
 	pmo_options->force_mandatory_uclk_pstate_support = config->pmo.force_mandatory_uclk_pstate_support;
 	pmo_options->force_optional_uclk_pstate_support = in_dc->debug.force_optional_uclk_pstate_support;
+
+	// stutter
+	pmo_options->relax_stutter_constraint_for_drr = config->pmo.relax_stutter_constraint_for_drr;
 }
 
 static enum dml2_project_id dml21_dcn_revision_to_dml2_project_id(const struct dc *in_dc)
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml2_wrapper.h b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml2_wrapper.h
index 68ae013b026e..c1eb8cdfc9a4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml2_wrapper.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml2_wrapper.h
@@ -242,6 +242,7 @@ struct dml2_configuration_options {
 	struct {
 		bool force_mandatory_uclk_pstate_support;
 		bool force_pstate_method_enable;
+		bool relax_stutter_constraint_for_drr;
 		enum dml2_force_pstate_methods force_pstate_method_values[MAX_PIPES];
 	} pmo;
 	bool map_dc_pipes_with_callbacks;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
index c01614005281..a6fd956d12e9 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
@@ -2468,6 +2468,8 @@ static bool dcn42_resource_construct(
 
 	dc->dml2_options.pmo.force_mandatory_uclk_pstate_support = true;
 
+	dc->dml2_options.pmo.relax_stutter_constraint_for_drr = true;
+
 	/* SPL */
 	dc->caps.scl_caps.sharpener_support = true;
 
-- 
2.43.0

