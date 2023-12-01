Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B154CC10DCE
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 13:29:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D76410E8A8;
	Fri,  1 Dec 2023 13:29:57 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48A1210E891
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 13:29:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dWgp3tktTO99mnJjI4oDcecfP8uPg1ajxPPpuec7pqQe9kVlNKYvw/J0FfZJh69YTG3/8wf84C/duAJQVXyDroVPpkAIVegAuQs2FlM1kDH4TE3CgoX/6lrU0VHjGKrx1yzb4+V2lC8yhTqZtph5Lel+za74SL7LbLfWds3hIXvnIjikls2Ppnwmr5sHuzpRIzW0KzGh55/pf9b5QDA6/IpK/LBihpNV8C/rDZnZ8YcJnym1e956GijXvJMXyy2Ti14DKBLQE1j2O9affNBidYPENx3qjxl+yuV62REoTxT1s4DixF4EaBWrvGmfb6yNOTVIYgY+naRtHfZCTnfYKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nzfv7qIxUUmRetpoc2mIjpcRBAYbj3E48a0m3o1H8eA=;
 b=dJjZw+5s1oryWDpiI0ir0opQarXa9S23uqe9TkQigUib9QLbsvuRsty7rYVmTQR2tvUeRVDWvl8FsmCmn64E5rOzDsREt+rT0jYpqECCpundD6b8hY7qvZWBIi0ZFxVHnJgOwCsYR2zqbCitRdFP7Yw6BtZPJkoQ38likFxMddky41mdm3O/llPOLnI6AN8+lwg7RG56C+bENtTyxr1AK+f+djxNoSi62AAQ7j8wWFVc+f0BacBTvpZaLKD7Xj5qCWOPzx57E+ub6BqFcYQzW3745QnIJWtq0QZHjbFc+3x1/sSQARMHcmtjxV1vkhDqecTOgzF5eo3MOm77eakbaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nzfv7qIxUUmRetpoc2mIjpcRBAYbj3E48a0m3o1H8eA=;
 b=fG/jiXkKgHJ5vzlTcwAn7ZfbNRmQn+0Y5JVPU6U8nM5xSB6T3f53sd4Nksx5pn0TtAp+1a1ZHCGSjdTCnDqK6mfJgA+z67pcyx10lvJsnpvSa6xW7AwGKcnw0XHl105AGTBd58w5A2IK3kCn748j5HBVY3AWBFWUhk6NkntLMuQ=
Received: from CH2PR16CA0014.namprd16.prod.outlook.com (2603:10b6:610:50::24)
 by DS0PR12MB7701.namprd12.prod.outlook.com (2603:10b6:8:133::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 13:29:19 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:610:50:cafe::92) by CH2PR16CA0014.outlook.office365.com
 (2603:10b6:610:50::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27 via Frontend
 Transport; Fri, 1 Dec 2023 13:29:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 13:29:19 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 1 Dec
 2023 07:29:14 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 34/47] drm/amd/display: Create fake sink and stream for
 writeback connector
Date: Fri, 1 Dec 2023 06:25:30 -0700
Message-ID: <20231201132731.2354141-35-Rodrigo.Siqueira@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|DS0PR12MB7701:EE_
X-MS-Office365-Filtering-Correlation-Id: e61133fa-9b52-4cc1-3f70-08dbf27185dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A4ucSutiVcL2vQU1eUQY0bBb9qrKV+nvlQM8aA2DZDVLtQx1F/hr2IYO1QeekUt4SSZtC7AIShWlSn2ZPkry7IiwNNYv/mEv4Z81Xz6nGXBpUGFSEBhdB8QWIc+vvxpXyZc+DFOTAs/BQymsaGy7+IooBHJ0QWYSKZKmHZ+y3zG0UKGkkAhrMO88Tfvu0hawF2buSwLEC1ePv9YLAGYdhv+tT8J2j5K8PT8QVW91UKOdHaMGWGtcHOQSSekTJHnjYzsnOLTu2NQcUcO9hPHVym2lhs3dGfPcs0zQSzJpkK92I7WeNgW7DTRf01p0JzKnkV4zNSoKg5TfTbRmj52I0bTlXw9JplhCbAVfJeQm9cmGdGReotAvuNvqLHH8H3swdr2Z9lOy1+TE/yQFEbV7XZh2NhwvJ56cEfB7Ijt2NkKOF9WUJ3KClbn5REjuvMBMVzhmAQJk1AT8m4Mg1qeB/GbmZ4OmOwcSFwUbm5YwMbFNPvRRM4e9+mWhe/ICKIbuNfFoZrUNspPvjjt674SlF9967rB1QMxY8GUuQMSFUJpqkaCrUDpp1A9n2XVv8a1w1iTdaqMlosZHIuraQwkLpJamnlnrhFjqKUfNxyh+7lCk6126G5bBX0gnNQie+mRGJKsriOwf3pIhAiO5Fs0aoYHkZdgPGTgNJ9f678M943h0Bxfqy8aGBMwovvwJuvv+QPb9BSp8LBnVq5Pqjga235pUkdoMBiKmF/TMPMsgXPf9bI/0pIsfA/iESsB/9JLrtzq4bUipL32d6E/rd6uAcQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(451199024)(1800799012)(82310400011)(186009)(64100799003)(46966006)(36840700001)(40470700004)(426003)(336012)(83380400001)(82740400003)(16526019)(26005)(478600001)(6666004)(2616005)(1076003)(40480700001)(8936002)(70586007)(70206006)(4326008)(316002)(54906003)(6916009)(8676002)(36860700001)(81166007)(356005)(47076005)(5660300002)(2906002)(86362001)(36756003)(41300700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 13:29:19.3371 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e61133fa-9b52-4cc1-3f70-08dbf27185dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7701
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

[WHAT]
Writeback connectors don't have a physical sink but DC still
needs a sink to function. Create a fake sink and stream for
writeback connectors

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 33 ++++++++++++-------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6df23fa9c3ae..aeb4a4e25450 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5695,13 +5695,13 @@ decide_crtc_timing_for_drm_display_mode(struct drm_display_mode *drm_mode,
 }
 
 static struct dc_sink *
-create_fake_sink(struct amdgpu_dm_connector *aconnector)
+create_fake_sink(struct dc_link *link)
 {
 	struct dc_sink_init_data sink_init_data = { 0 };
 	struct dc_sink *sink = NULL;
 
-	sink_init_data.link = aconnector->dc_link;
-	sink_init_data.sink_signal = aconnector->dc_link->connector_signal;
+	sink_init_data.link = link;
+	sink_init_data.sink_signal = link->connector_signal;
 
 	sink = dc_sink_create(&sink_init_data);
 	if (!sink) {
@@ -6072,6 +6072,7 @@ create_stream_for_sink(struct drm_connector *connector,
 	enum color_transfer_func tf = TRANSFER_FUNC_UNKNOWN;
 	struct dsc_dec_dpcd_caps dsc_caps;
 
+	struct dc_link *link = NULL;
 	struct dc_sink *sink = NULL;
 
 	drm_mode_init(&mode, drm_mode);
@@ -6085,14 +6086,24 @@ create_stream_for_sink(struct drm_connector *connector,
 	if (connector->connector_type != DRM_MODE_CONNECTOR_WRITEBACK) {
 		aconnector = NULL;
 		aconnector = to_amdgpu_dm_connector(connector);
-		if (!aconnector->dc_sink) {
-			sink = create_fake_sink(aconnector);
-			if (!sink)
-				return stream;
-		} else {
-			sink = aconnector->dc_sink;
-			dc_sink_retain(sink);
-		}
+		link = aconnector->dc_link;
+	} else {
+		struct drm_writeback_connector *wbcon = NULL;
+		struct amdgpu_dm_wb_connector *dm_wbcon = NULL;
+
+		wbcon = drm_connector_to_writeback(connector);
+		dm_wbcon = to_amdgpu_dm_wb_connector(wbcon);
+		link = dm_wbcon->link;
+	}
+
+	if (!aconnector || !aconnector->dc_sink) {
+		sink = create_fake_sink(link);
+		if (!sink)
+			return stream;
+
+	} else {
+		sink = aconnector->dc_sink;
+		dc_sink_retain(sink);
 	}
 
 	stream = dc_create_stream_for_sink(sink);
-- 
2.42.0

