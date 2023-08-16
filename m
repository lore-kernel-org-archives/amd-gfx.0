Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 254D9C27C42
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 21:30:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C828D10E3CA;
	Wed, 16 Aug 2023 21:30:30 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CEB589153
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 21:30:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5VL/VWmpWYAG7hwSvq/SzwWCuCQ6Wo6lCFOT1vg2psUqUyTHBF942cjUCgKNC5l99g4/EDKddwEUyFgsrSQGoIVz9QTpXvjwsM93sfCOIhqB4rzquJ8nDMhXZtlB882qOnyATJMCpqw8lIhbRNxLa9qgfVnQeuP9TMDuPqVYnmrTauYR+zgR5m+LwqjnUL80LyZta8bSdjHSBxdDb605cm7CitZ4etm/jEbIOb7bdshi5imF/20590Wah/TrDTDI48+IyHw75RaoYT1fy8rYDT/ZMCcT3hMkiAuSlQNPOxhEAtc4H3ofXl1pRiNuL3lCwLaVpWh+w/ijhZqxf+9Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sReKxB8vBtvi+jJL5rsZVGgnyuOH7J5+/9lLTtck4go=;
 b=FMmzffHv2TkL7RJfRcD5RRY1lGLiSOAi1jD/BcX4deuTBLAKlglyWGpgMg2kQiNdCSzGOMJc08nXT0hAQisjUMFBTMnOjgSYBWQovrmMlVvvYwY7f1+ujWxZUI2LKK0xFlKU5l3oAgDp855Zwg7Py7IAReP1a+6IU3CCVlf6TmLJemEsWQ6kbH/zXcbhRC5Pqvnu3N5h5BLPbG6R+SSJFGHqxFOZn5NIMrrxqpXqtxZs+vuTuXw35YIncm8FwCG/mxiEsUvCzHPjlOoAiy+b1kJ2PeuJUpESLzQA0DCI9o1KJFyAgUgeTKvbyJUvJu1S7+tFXcYW1p3bIGoibvpORw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sReKxB8vBtvi+jJL5rsZVGgnyuOH7J5+/9lLTtck4go=;
 b=IQ0rDkRWXC7gi+qCgcfC6t0G/H76m3b6Bw0yjXh9MJY13d6rUfXqTla1i6q++TCUPeARA6tojMf44vuBpw4lMGsLgQckO9YvWZYUer91ILmRj4JE62G0eodAoEPHPBvV/LKvND6IDkAO84JBNA7iwL5D2HHltJXACRPlGEnvx8A=
Received: from CY5PR19CA0118.namprd19.prod.outlook.com (2603:10b6:930:64::22)
 by CH2PR12MB4053.namprd12.prod.outlook.com (2603:10b6:610:7c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 21:30:27 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:930:64:cafe::96) by CY5PR19CA0118.outlook.office365.com
 (2603:10b6:930:64::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 21:30:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.77) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 21:30:27 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 16:30:25 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/18] drm/amd/display: Create fake sink and stream for
 writeback connector
Date: Wed, 16 Aug 2023 15:26:17 -0600
Message-ID: <20230816212626.987519-10-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|CH2PR12MB4053:EE_
X-MS-Office365-Filtering-Correlation-Id: 889b485e-2b70-4315-1647-08db9ea0023c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tAvRDPKUsFWAZ9s1wF/sEiyjAYTfd9VatxTHlRkXV5uVG8lS4QvkyVAZ4bhKxuR9KgjSBgTymOoy0tKxPUES1Hm5GCZT02ANzAsG47sChbqkIBOmG1AGFaYgiqiXRBTjlEu07E9Nyw4lWYpcAFwkZStWVwy/h1IGYvfZDW/a8wmyvEf2uJr5Jo4Fcncqt1qF3PaWlydbGPHO0ODypkEqc7tNoOkTGn309wPl9H/s2hylO5YUeo+mmDPd2Ix/B2O7cutbltRmtyfz2uQhjbvkch1EB0WwHqYMfx/vsivdt46B+8uCdxAas/5czZ/AkLEy5K/08eOwGbSIK8jPa94ezdt99aOHVWjvlggapXOBzxBjOA/27dknE+Kej+zFfn3m55bFovoABtXgrQYIydpn8o/vN1Wq0THr9OlcsTgylepYVwDbdQKyTgZ0wG5nnZ47I+ayy913yzgN2FRMgsS2bQgSOLUKdbB0EG23glBmuGXkDL5F2DoMmSs8W13HE5PouKprRvPCJubbaj1K+X/2NzEgy4OQu5cbWknC/f3M4RRFi9VMFNSNcRjyAjw0FbaNGPOAAnghHOuEuGtmiTbh98vU44TGKYEUrEQyWKy9n1ozUfAY+AeukYy4avBiHIrR/HQ7Tf0+MP+KHkeybdWs5lm7IS5mKAsXldAUDFY0zFoi3XhNG9v3qXKSe+8hT5rb3heWPvi0FY/sm5sZxoQhvqpfFlRmiMj9VaIPQdXbN69dMWQzINgi3NVpF4zBaU6IEXfwFJaGIcTAZUQdz4Y/fg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(376002)(39860400002)(1800799009)(451199024)(82310400011)(186009)(40470700004)(36840700001)(46966006)(2906002)(40460700003)(83380400001)(86362001)(40480700001)(478600001)(426003)(336012)(36756003)(7696005)(2616005)(6666004)(1076003)(26005)(16526019)(44832011)(5660300002)(36860700001)(41300700001)(54906003)(82740400003)(356005)(316002)(81166007)(70206006)(70586007)(6916009)(8676002)(8936002)(4326008)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 21:30:27.1411 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 889b485e-2b70-4315-1647-08db9ea0023c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4053
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

[WHAT]
Writeback connectors don't have a physical sink but DC still
needs a sink to function. Create a fake sink and stream for
writeback connectors

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 33 ++++++++++++-------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b12e8393fef3..82f00af14ada 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5611,13 +5611,13 @@ decide_crtc_timing_for_drm_display_mode(struct drm_display_mode *drm_mode,
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
@@ -5988,6 +5988,7 @@ create_stream_for_sink(struct drm_connector *connector,
 	enum color_transfer_func tf = TRANSFER_FUNC_UNKNOWN;
 	struct dsc_dec_dpcd_caps dsc_caps;
 
+	struct dc_link *link = NULL;
 	struct dc_sink *sink = NULL;
 
 	drm_mode_init(&mode, drm_mode);
@@ -6001,14 +6002,24 @@ create_stream_for_sink(struct drm_connector *connector,
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
2.41.0

