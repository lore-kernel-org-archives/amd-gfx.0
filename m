Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 732FEC25B7F
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 21:29:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F40A710E3C4;
	Wed, 16 Aug 2023 21:29:41 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC4DC10E3C4
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 21:29:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqXs80tbx0lJ0kKafvfd74NsJO9TxOao64DKvY/wQZm6vUuLWmYMvDzzXT6qtgXbh2mgJzZRauxR35lY0frW23GRBHsOYUBqt447BJRwEnC9fHIAR5DaTq/eEVT0G7zmw/Qb4IDvJPgJ671o758SoEMchie4vmwt5SWucg27Y08Rl6olt5u3leoC7EzOMnROpnBxwKsyD3bZJ9FXYd81/Ib4nBjvERpCO5X7Tus4GyTT0xB8AnKBnED1RQX+/jygcLE7alhgtCqNrXdQQGH4/2lDfdKoG8f80/VGscQ6vEqYE41Fjw5f+q5HcOwgqthuxabHrXb1EPJu/DbyuRcCYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z466M8ut7jSO496kIgLqZEOu1FVwAg7oCRSkfnKGhAU=;
 b=aVjoH8wlPAKnwgrPFB1IbfgLQEbWvkvcSv1bqthloX1eep2Qxg4R77qjbVauEMLRP8fnEvOSRRrfTTIT4rrnOD64cac9/g/tYQBgxcFpnGsle7oL7/Yqmlp3Hkv6N8yhMUtoQ7QgkNtOCzMXi5+otb85FAsD7N3nsvIG//S/89s5ciaqCR6m0WZ8N7ZRQTuhw1UwSKhsCzdPVl3CW0vMbrgZ+hUPKCLa6EZWvZgVE5DM98jYmEL/p36aPWxPTW8949/AeOO87OD2Zzl82UiAIcZKev33GS2jrLl+SO79Nw0LQ1ai0u6VszNRQt9HZfRw8Z+plyhHDGxOkUFMo8fabg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z466M8ut7jSO496kIgLqZEOu1FVwAg7oCRSkfnKGhAU=;
 b=EYpw0ZYFsmxmkO86K9w6iB9xZuR/PHyA8NKDe6pE3S2BTkdLPfYjmRRvuj3AWI9zmU57vRf3KEf1aaGTE2PzC/AES174hbeeG5R/eTZS7XwgkclodvwfxLSH9ruRq6IT1biGBgzK00pGZCDum/lY5ZUs6J0Fl5b9HhAGwnDgwK4=
Received: from CY5P221CA0029.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:b::41) by
 PH7PR12MB6978.namprd12.prod.outlook.com (2603:10b6:510:1b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Wed, 16 Aug
 2023 21:29:37 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:b:cafe::5a) by CY5P221CA0029.outlook.office365.com
 (2603:10b6:930:b::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 21:29:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 16 Aug 2023 21:29:37 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 16:29:35 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/18] drm/amd/display: Return drm_connector from
 find_first_crtc_matching_connector
Date: Wed, 16 Aug 2023 15:26:13 -0600
Message-ID: <20230816212626.987519-6-alex.hung@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816212626.987519-1-alex.hung@amd.com>
References: <20230816212626.987519-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|PH7PR12MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: cb24a697-7326-4eef-1900-08db9e9fe45b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W27Myf3MGVtT44QHfu75zIZnIIBnwr+gZgy8A1jKdbEy9JkfG+z6etttVEJEPHA86XrOpjxaW4shAoDdAq2CyBW/AeHrcL99ZGGgzlktPj3T91rCL2/CzOstdVLPwk6aVQjZfJJbKy4yPLo9lN3sNV/LGBB73LyLj6TPFBWuk+h/NEQ3riVWVeUkBBw5M9Y5vnlWe7CfCFdW99OeaHlHY8iR6UCZY+WxgwW3G1pFApnb3vZO9JWXOyWTigYD2TZE3pTgPdrxdykP8rOx2w54tW1CdQRTDeRVzNZNxvdNKCsvDOSYQt1iGKcIjkHyhjYp3Qc5tifbastfCAc1TVfDNOu4VsT4ydYO8u3zjvavGdG56Y2679puXaxXKoUpuGjzTmAAcUOdJStE48wsy1CLuWQXlwwJ2zglBr6tbbCzitG2i7yqqCk54ProsRscpMw2m2Sfu2a7V30H4oCqAGofXWcTmNZBEn4YSXVywxIU0SlXQJp6PWTl6N+ETqV/enz3445TAm9L/5eHCLPh1k9ZTv2ZwNTi8Zne2pFrzQ8TnlPOT9VnrwBpIJHB35rnfp7ydG3NHEa6GjuQIVvRn/YRB21NJCPvda6q0RQzLZ+wISUNmUYAQASiUqnu7UWVrYWoPaN8ZzKPVpg/N7jeEshWa2vGvshV1u+zWGrQONzwP8g58F7F2D8WWHp6/wJifbVlrXUhRdd1vB24xFSFqBFI2RVlSMaHLuo3Uy3/mRC+3DF5NcL6CN6V8GPMJvfyLN/VdEfHgQl8CtJPSfY/8adCbQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(376002)(39860400002)(1800799009)(451199024)(82310400011)(186009)(40470700004)(36840700001)(46966006)(2906002)(40460700003)(83380400001)(66899024)(86362001)(40480700001)(478600001)(426003)(336012)(36756003)(7696005)(2616005)(6666004)(1076003)(26005)(16526019)(44832011)(5660300002)(36860700001)(41300700001)(54906003)(82740400003)(356005)(316002)(81166007)(70206006)(70586007)(6916009)(8676002)(8936002)(4326008)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 21:29:37.0283 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb24a697-7326-4eef-1900-08db9e9fe45b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6978
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
Cc: alexander.deucher@amd.com, Alex Hung <alex.hung@amd.com>,
 harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Harry Wentland <harry.wentland@amd.com>

[WHY]
We will be dealing with two types of connector: amdgpu_dm_connector
and drm_writeback_connector.

[HOW]
We want to find both and then cast to the appriopriate type afterwards.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c         | 8 +++++---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h         | 2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c   | 4 +++-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 363d91d49a3a..7bd3ec84ff2e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2630,7 +2630,7 @@ static int dm_suspend(void *handle)
 	return 0;
 }
 
-struct amdgpu_dm_connector *
+struct drm_connector *
 amdgpu_dm_find_first_crtc_matching_connector(struct drm_atomic_state *state,
 					     struct drm_crtc *crtc)
 {
@@ -2643,7 +2643,7 @@ amdgpu_dm_find_first_crtc_matching_connector(struct drm_atomic_state *state,
 		crtc_from_state = new_con_state->crtc;
 
 		if (crtc_from_state == crtc)
-			return to_amdgpu_dm_connector(connector);
+			return connector;
 	}
 
 	return NULL;
@@ -9263,6 +9263,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 	 * update changed items
 	 */
 	struct amdgpu_crtc *acrtc = NULL;
+	struct drm_connector *connector = NULL;
 	struct amdgpu_dm_connector *aconnector = NULL;
 	struct drm_connector_state *drm_new_conn_state = NULL, *drm_old_conn_state = NULL;
 	struct dm_connector_state *dm_new_conn_state = NULL, *dm_old_conn_state = NULL;
@@ -9272,7 +9273,8 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 	dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
 	dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
 	acrtc = to_amdgpu_crtc(crtc);
-	aconnector = amdgpu_dm_find_first_crtc_matching_connector(state, crtc);
+	connector = amdgpu_dm_find_first_crtc_matching_connector(state, crtc);
+	aconnector = to_amdgpu_dm_connector(connector);
 
 	/* TODO This hack should go away */
 	if (aconnector && enable) {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index a2d34be82613..5a8d07a27e9b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -836,7 +836,7 @@ struct dc_stream_state *
 int dm_atomic_get_state(struct drm_atomic_state *state,
 			struct dm_atomic_state **dm_state);
 
-struct amdgpu_dm_connector *
+struct drm_connector *
 amdgpu_dm_find_first_crtc_matching_connector(struct drm_atomic_state *state,
 					     struct drm_crtc *crtc);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 57230661132b..1975b9d96cb8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1494,14 +1494,16 @@ int pre_validate_dsc(struct drm_atomic_state *state,
 		int ind = find_crtc_index_in_state_by_stream(state, stream);
 
 		if (ind >= 0) {
+			struct drm_connector *connector;
 			struct amdgpu_dm_connector *aconnector;
 			struct drm_connector_state *drm_new_conn_state;
 			struct dm_connector_state *dm_new_conn_state;
 			struct dm_crtc_state *dm_old_crtc_state;
 
-			aconnector =
+			connector =
 				amdgpu_dm_find_first_crtc_matching_connector(state,
 									     state->crtcs[ind].ptr);
+			aconnector = to_amdgpu_dm_connector(connector);
 			drm_new_conn_state =
 				drm_atomic_get_new_connector_state(state,
 								   &aconnector->base);
-- 
2.41.0

