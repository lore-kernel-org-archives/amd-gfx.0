Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36485C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 13:29:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B13F010E891;
	Fri,  1 Dec 2023 13:29:34 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 680D510E889
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 13:29:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JgQfgRfp1G8q4PRepU3G9ylk+8ExLEzZ/LlkRFnSX9n4a+my1YjCZdz79/H89Is5hmnavyqr4QvkvKVzUtXAqJVSgEzo1PLwvWfneWPM6DrvhPWdDbtqQBziEYuT4KOTacVzPG4O5NW9Je6FVCG3AYNXZgvUs1TWL06G+J/foHBBUtOovt5ixqc7wrAwGAhoKfJZ/P24ELxc/45GMTC0+uKNGTlLQpn9TlI1mAO+gwmFgtaftN3yDfaizdsMGBUxODvGNlCkh64xK5Q2Bt7KusJKNCZijgOQ79/WrqpBo0XTLukZpA5nUKu9FQgJg1rAcGoM7+KuD2dU7XwQqhq6Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyjpvZH0xN5CgvCWDxJLCIjs1+6Z36hRoi1o3oneuYc=;
 b=NhE0ba9/VYN/+lvKgKDfpKP4lWrF3U7G4OOw3C8ILkeQjNv7odGrolq1fIfrWcNNEknoRGcOkICcGXxPXEpvwjIeFykMlNCV5uiPyYgCtpkAIhfhZPGMcaNACABc/PvGYwPrqZLw0fAEjvoAPMDRyOQkjnNWaiLlNLHLLTWxu7jxTZQWkhO9kWvWtfwkWG7gpF0o5hkSznsEn7VJpWD6uCX9EZK/gQuqCiaKh1NDQi21bZVwTBWwoVGRLUhzQWx7MlvugTApQMF3+m0iLwAkpKY3SGMTr/c5Lbxm/rNCGTZT9Ye1KAtJaYM03rl86XGjV2xRC856qasD/7vwCbntbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyjpvZH0xN5CgvCWDxJLCIjs1+6Z36hRoi1o3oneuYc=;
 b=fchUEIWDwjxIVOCMSlhPKnNUabz4IkiHNJdFqAeDx+Ach8q+5etWwxK7Jlxi5h2WNQlXOJ/VgykCnyBHODStsImSXHetw9oSyEbqnKdpS3F86kcHb7LjnyFWc1wxMX9RTgnANw+SIzchh2kUDacHCxjbTbvZ0ynf5NxD4unLkoM=
Received: from DS0PR17CA0005.namprd17.prod.outlook.com (2603:10b6:8:191::6) by
 MN6PR12MB8514.namprd12.prod.outlook.com (2603:10b6:208:474::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 13:29:09 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:8:191:cafe::ad) by DS0PR17CA0005.outlook.office365.com
 (2603:10b6:8:191::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.29 via Frontend
 Transport; Fri, 1 Dec 2023 13:29:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 13:29:08 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 1 Dec
 2023 07:29:06 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 30/47] drm/amd/display: Return drm_connector from
 find_first_crtc_matching_connector
Date: Fri, 1 Dec 2023 06:25:26 -0700
Message-ID: <20231201132731.2354141-31-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
References: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|MN6PR12MB8514:EE_
X-MS-Office365-Filtering-Correlation-Id: e8320ede-ce31-460a-19a6-08dbf2717f8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JTivxqxW0eJJk9HOj1Lrvn1OWYiuaiSTPnkeuGAMtti+fLe/iQYOVcZhN5dUMQjvPKqMY6GXw18Lqtb+cHLHlyJerKGUFWjwXocJcEW4LZ9QI0mMK/DGJPaZK2MEN0oHLINPtr3x91GTEzQi4P6zLMSTHZfQsLo6S8ddydFjRAU1yum5g0Tpggc6HNAjFId//MJJfIdXr9vIu1s1/Sq6copazT1J05/Et/ujbqkXnKFt/5UXgY7hO6kEHUCIdekA5lxaZA6Le52rxRUSvusJPxMU69Vpw2d/WQUDP1dp+h58kgtPWvSgstTfgbooYfdT+KYZ2kRetw49uMUgZd7F+hhTsLGd8hCgdyvwr4c0Td4Wm2tkowVa0hzcbvcIJiGciphedYuYjI6yFWdO8S64tmU4ghE96eH9e5gUXV5/7Gf7PhHcoDATN0Cula82ZyAavi45uipGGxW1YSljBCsNyzI6lGW1x2kY6CV1XMuxOmmB5NzoPSDjwVWoHz/o4ZPXBn0ymZmy1qywLtRcUxTa+k/F3WRf8HmU75aGcm1dpxB41tpeTEYf930QA7ZCYkJPlo95aEV33IjhGGOeBk0EcUyS3xt4wGWRKjCFINdkXX+Q8zuJb9pwkrWNyR4IJwJoatlt6ieGYnogDUO07I0NVJ1QiJcIUwx9HYfnV4a7LVoBIwzSism4Ytc+1DaKnMmmVweo2IztJLL9WTdKxzDBeGk0R5bfghYgGs9byWLf2Ph7Qa9SLZSP5pXSbFEsP+43ZTJa5VyWcN7dbRuzSWNQkQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(82310400011)(186009)(451199024)(1800799012)(64100799003)(46966006)(36840700001)(40470700004)(1076003)(5660300002)(2906002)(8676002)(316002)(6916009)(54906003)(4326008)(70586007)(70206006)(8936002)(40480700001)(16526019)(26005)(41300700001)(6666004)(478600001)(2616005)(83380400001)(426003)(336012)(66899024)(40460700003)(47076005)(36860700001)(82740400003)(356005)(81166007)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 13:29:08.7521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8320ede-ce31-460a-19a6-08dbf2717f8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8514
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
Cc: stylon.wang@amd.com, jerry.zuo@amd.com, Sunpeng.Li@amd.com,
 Harry Wentland <harry.wentland@amd.com>, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Aurabindo.Pillai@amd.com,
 Alex Hung <alex.hung@amd.com>, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Harry Wentland <harry.wentland@amd.com>

[WHY]
We will be dealing with two types of connector: amdgpu_dm_connector
and drm_writeback_connector.

[HOW]
We want to find both and then cast to the appriopriate type afterwards.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c         | 8 +++++---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h         | 2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c   | 4 +++-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b94aceb6e677..944b1ce7f30a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2661,7 +2661,7 @@ static int dm_suspend(void *handle)
 	return 0;
 }
 
-struct amdgpu_dm_connector *
+struct drm_connector *
 amdgpu_dm_find_first_crtc_matching_connector(struct drm_atomic_state *state,
 					     struct drm_crtc *crtc)
 {
@@ -2674,7 +2674,7 @@ amdgpu_dm_find_first_crtc_matching_connector(struct drm_atomic_state *state,
 		crtc_from_state = new_con_state->crtc;
 
 		if (crtc_from_state == crtc)
-			return to_amdgpu_dm_connector(connector);
+			return connector;
 	}
 
 	return NULL;
@@ -9387,6 +9387,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 	 * update changed items
 	 */
 	struct amdgpu_crtc *acrtc = NULL;
+	struct drm_connector *connector = NULL;
 	struct amdgpu_dm_connector *aconnector = NULL;
 	struct drm_connector_state *drm_new_conn_state = NULL, *drm_old_conn_state = NULL;
 	struct dm_connector_state *dm_new_conn_state = NULL, *dm_old_conn_state = NULL;
@@ -9396,7 +9397,8 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 	dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
 	dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
 	acrtc = to_amdgpu_crtc(crtc);
-	aconnector = amdgpu_dm_find_first_crtc_matching_connector(state, crtc);
+	connector = amdgpu_dm_find_first_crtc_matching_connector(state, crtc);
+	aconnector = to_amdgpu_dm_connector(connector);
 
 	/* TODO This hack should go away */
 	if (aconnector && enable) {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 3d480be802cb..3710f4d0f2cb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -834,7 +834,7 @@ struct dc_stream_state *
 int dm_atomic_get_state(struct drm_atomic_state *state,
 			struct dm_atomic_state **dm_state);
 
-struct amdgpu_dm_connector *
+struct drm_connector *
 amdgpu_dm_find_first_crtc_matching_connector(struct drm_atomic_state *state,
 					     struct drm_crtc *crtc);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index a6995688d7ad..94d59117c43c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1499,14 +1499,16 @@ int pre_validate_dsc(struct drm_atomic_state *state,
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
2.42.0

