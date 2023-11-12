Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC677C4332F
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Nov 2023 04:01:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDD5E10E074;
	Sun, 12 Nov 2023 04:01:35 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1AA010E074
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Nov 2023 04:01:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKKfyhV2cuBT28TXZK4TeVa6SVQEhhVHM4ZQgByeqeKPDrIQU6vU+f7oeZtFNqN30TkatZ+jG7VXylgiis6jFFt4cmBjRxuchX8TahNWhnQrrCK+kkXA674A/1h7wiF7fOscUUh2dgPWSg81EclzR6NfUlLEs8ZHfDheej6THLgaxeJMBS9MbwcJ2LDBR2HYgwfnaA+KvYlrq2//7r73pdCt+9LS1GcJTmAnoxyEVPuuxG8g6KX4djAMogTPs0/YG8BR1k3EfAgHL34cqzVRSAOKJzX971j3eeKjgt5w3GgGseTw3RP64UuKydXgYTEOalOT13p6PPjCLifmEMYp2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VahrQiAruDAkk7cKofpo5+bqYXzAdsZqqxKthlfaxjg=;
 b=AL8b5hleB/BHdOm2wroAoqLK08VloOnK5HCnfDgBhuVQv46Vn8rPe1is813RvUVL8KW1pZBCOmOubL0dQ9RFokv5oORnHMdDTeOjU48IX6TX0dhF58RJbtKDrxDousiXffIGlCO/y12yHkiTqo7VuBNnMs8rRFPCiIQlXxZSYxtVeAVEV4KU4lWkqiLxCdTqwRNq/uGDR4ZX/0jnwP1YDt/aWgCZqMaUtY9aEtkENjIEdlNM65RGfwJw7timbrHJGKHW7ixCYvijao/PEtxrqOK7YYtRT8efyDl6kcWsKOZJg2HAokdI0/kp/AA8ou+t4NK6ubHdfGewIR71HRjZcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VahrQiAruDAkk7cKofpo5+bqYXzAdsZqqxKthlfaxjg=;
 b=kVMzP7Oy7TjGXZvIH1aivogUKhQj+fDg5nOmjw0wQZ3X+Gyi6IQT37sCyXk9yPAqUUv3iKS+SKS1yS9T3RHu13dRI6IB0uNW4Sgg8bhmfilIzxwSEFBghCmpAdPET5gq0CUorTVVygAolBgFSICq/G2tfrEMiRgRazp+bs4iG/I=
Received: from MN2PR07CA0022.namprd07.prod.outlook.com (2603:10b6:208:1a0::32)
 by DS0PR12MB8415.namprd12.prod.outlook.com (2603:10b6:8:fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.28; Sun, 12 Nov
 2023 04:01:29 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:1a0:cafe::f4) by MN2PR07CA0022.outlook.office365.com
 (2603:10b6:208:1a0::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.28 via Frontend
 Transport; Sun, 12 Nov 2023 04:01:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.14 via Frontend Transport; Sun, 12 Nov 2023 04:01:28 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sat, 11 Nov 2023 22:01:25 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>, Roman Li <roman.li@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Harry Wentland <harry.wentland@amd.com>, "Hamza
 Mahfooz" <hamza.mahfooz@amd.com>
Subject: [PATCH] drm/amd/display: Remove redundant DRM device struct in
 amdgpu_dm_, mst_types.c
Date: Sun, 12 Nov 2023 09:30:51 +0530
Message-ID: <20231112040051.1621934-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|DS0PR12MB8415:EE_
X-MS-Office365-Filtering-Correlation-Id: 70491815-68dc-480c-ba24-08dbe3340c56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ODHMziD9TzNYdl3bIGlBZ+B4Zb/Ho13uBOTSeDk+J3nYRIMsh3P2snnxrs+Tps9wIzgvPiWXUDudXnFgUgvB2o57yUqZLSH4tlEm5h3/Tqzk0UWdOtkSG0EMB1uc7xSqqwHUsh8DHh/gDzazmeVwDBxA4Gnm9tmayZ+uicl+o5HtZr+MTG4j2FyJEefnUxMvUB0dX24aoBEe1uYU4uPzESFu2qTH3TvBeWpE8OA9B1q3cnf47+y1zPhOPf/j7LI9hFr12VDitPpqzC9XDmxoYUvUSHDdJyalLdwkK5G5jIE770etYoaohLNUdmy2XIrAO6p0iMT5a7qSK2azZTHW9cYD5JJBLzVGfUNB1nKw3SIx8vSElTHmuuFFv5IxYSoa3NpvMx1M3d3hdxS7E8CnreH3TghcTqm3PO4p32n6eoqe6SLZqMUz2/FzHN3XFp2KVs/MJa7WS9S2TsYBlcIEOK96R0m0mlbbvFOqzuP9jXUyBxZTau8UwQaDUg864rfHvKIXqDT80HGeKmNSRq6xXez9tQPA59/ZKCDspWAZE6Ni9wqbwL+Z2CkZ6bz8reLDuMPkvJ6EMID1n08SGAyMvfBxFPScW0RXzVWY9Cak8HqvYTxsnZcFgndltho40VOPGDylU1g9sFzv81iCanRDgsXzWgHBPqiliZMGcemjuk4uobRZX8CxHElT6gjypMalQv5qkAhbLoJ0Os/wF7rWXpJWT7ibtmJZJ5PwKfdX5NosNF3xEdjm3bY3CSTaEmuQ2Q+30OjKM3GeHxmfpukFqQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799009)(46966006)(36840700001)(40470700004)(40460700003)(16526019)(336012)(426003)(1076003)(26005)(7696005)(6666004)(2616005)(36860700001)(83380400001)(47076005)(44832011)(5660300002)(4326008)(8936002)(8676002)(41300700001)(2906002)(478600001)(316002)(6636002)(110136005)(54906003)(70206006)(70586007)(86362001)(36756003)(82740400003)(356005)(81166007)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2023 04:01:28.7247 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70491815-68dc-480c-ba24-08dbe3340c56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8415
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Declaration of 'struct drm_device *dev' is redundant, as
'connector->dev' & 'dev_get_drvdata(kdev)' can be directly passed to
'drm_to_adev', without intermediate DRM device 'dev' variable

Cc: Roman Li <roman.li@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c        | 9 +++------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c  | 3 +--
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index adbeb2c897b5..39c73e5321c3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -893,8 +893,7 @@ static int dm_early_init(void *handle);
 /* Allocate memory for FBC compressed data  */
 static void amdgpu_dm_fbc_init(struct drm_connector *connector)
 {
-	struct drm_device *dev = connector->dev;
-	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct amdgpu_device *adev = drm_to_adev(connector->dev);
 	struct dm_compressor_info *compressor = &adev->dm.compressor;
 	struct amdgpu_dm_connector *aconn = to_amdgpu_dm_connector(connector);
 	struct drm_display_mode *mode;
@@ -988,8 +987,7 @@ static int amdgpu_dm_audio_component_bind(struct device *kdev,
 static void amdgpu_dm_audio_component_unbind(struct device *kdev,
 					  struct device *hda_kdev, void *data)
 {
-	struct drm_device *dev = dev_get_drvdata(kdev);
-	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct amdgpu_device *adev = drm_to_adev(dev_get_drvdata(kdev));
 	struct drm_audio_component *acomp = data;
 
 	acomp->ops = NULL;
@@ -10766,8 +10764,7 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	struct dm_connector_state *dm_con_state = NULL;
 	struct dc_sink *sink;
 
-	struct drm_device *dev = connector->dev;
-	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct amdgpu_device *adev = drm_to_adev(connector->dev);
 	struct amdgpu_hdmi_vsdb_info vsdb_info = {0};
 	bool freesync_capable = false;
 	enum adaptive_sync_type as_type = ADAPTIVE_SYNC_TYPE_NONE;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index d3b13d362eda..e4dd0037bcb7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -424,8 +424,7 @@ dm_mst_atomic_best_encoder(struct drm_connector *connector,
 {
 	struct drm_connector_state *connector_state = drm_atomic_get_new_connector_state(state,
 											 connector);
-	struct drm_device *dev = connector->dev;
-	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct amdgpu_device *adev = drm_to_adev(connector->dev);
 	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(connector_state->crtc);
 
 	return &adev->dm.mst_encoders[acrtc->crtc_id].base;
-- 
2.34.1

