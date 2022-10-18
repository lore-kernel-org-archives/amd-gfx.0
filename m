Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F230FC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Oct 2022 12:28:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16DE810E896;
	Tue, 18 Oct 2022 12:28:26 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2052.outbound.protection.outlook.com [40.107.212.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D40C10EF2C
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Oct 2022 12:28:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bRri/ig77ETwfNXEvJne+lSPouh4ec0bqLXZFu+Ac+RZ8+wtwlJG/3sZR7pqq+gObaS+vWkmFOLsk2vI+NM2ZzL9nnE7vtUWYc2P8vjZNNtlICpfB4Xl3JPSBad5j/mx+ol/lVR2Etaw6xfeEGg5R39JlnJRHPyCZBw8T/FaUSq1ZqWruY1ANDjscg6yH1393cD3oi5h8rReVvoY3yzFw1owsfGKMD3gzvJ0ylehVRT1NE0YXvJnAnyhy20iu3b+v5be9xl0yAyQwKGd7tbjoYhFdA3SC1RZUZ7ahRBKclXc+t2Bnj8WBngpeaXLjL5DQ6ebo05FVjcsrEYlk+cPRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4j/4IEf8QQKx5iBFzDNQe0Z2aVV3bkHho1JVJvxTErY=;
 b=npG3eeLGgMox1HVGHoZtke5fzvTa+jfUznx3b/lLTU4gy/e8xauc3FfRzvvPIoWNJNlVcDOUtCstHtOxCLXBs4q8bDA/PmWVr5D1dndukRDBDYs8HOB7S4A5sotpWfsvc0zHk7WSyYOYqyfoKHXMebj/fL4dmzqPf+9gi1e3/bUcy5MuKkxRbcAW6zq9nBqiiXSS3pEoYMJyXjOO50utw0JsKnFODo1xvJgkTigo8RgFGrKha7/F6qogBtHKO4bXkZDE4be1mnSH7kMx4nBLYt/cPlD34ECtR7EFpT+j8Y20c1S3s/1CSzYCDuj8O9at9E9T/NrhWHkRG/DE4KxkSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4j/4IEf8QQKx5iBFzDNQe0Z2aVV3bkHho1JVJvxTErY=;
 b=EthZkCCwRFPqAEyOAznBebBSyrTJ5EXfFNboAz+DO5qzVlbqhMmKffk0xWPsY9QvQDQDmXj+MUnfo5BsSclWXN+dVfpq23FpjyilEd2GHoPGp6l5DJQvKPPTGlzM2Ktm9B2kuwqG6PWYV+PAt4WNQOoLmonI2cFAK9Ung6QF9Ao=
Received: from DM6PR06CA0050.namprd06.prod.outlook.com (2603:10b6:5:54::27) by
 SN7PR12MB7249.namprd12.prod.outlook.com (2603:10b6:806:2a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Tue, 18 Oct
 2022 12:28:16 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::75) by DM6PR06CA0050.outlook.office365.com
 (2603:10b6:5:54::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.31 via Frontend
 Transport; Tue, 18 Oct 2022 12:28:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 12:28:15 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 07:28:14 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 05:28:14 -0700
Received: from arch-sec.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via
 Frontend Transport; Tue, 18 Oct 2022 07:28:09 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 05/12] drm/amd/display: Include surface of unaffected
 streams
Date: Tue, 18 Oct 2022 08:28:19 -0400
Message-ID: <20221018122826.1790114-6-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221018122826.1790114-1-Rodrigo.Siqueira@amd.com>
References: <20221018122826.1790114-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT024:EE_|SN7PR12MB7249:EE_
X-MS-Office365-Filtering-Correlation-Id: ba1dcbe8-0333-4637-55e4-08dab1043b3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Bn/pClyOOdcZT6HiVaNmcFcTDZ8LYKixzdc7oYa1s7GSup4NtdhmFSgltmpM7BlD4WgpuNuLXD5315aygdpogQFQiCi8m/2Sjb81tfFNYEAzMbg7TF9LMz0OHAIE+JxS2X/qCTr6zb6sz4eyf7B/+j9cUu5VvZ92rmnKbuLOGy0PTAGbvUthHldPace0/R7C5wWPjkTIw0w8LKbCPhHEjh/J+Yd6OqMhQxp2tgKT7lE+qlKxyHkMadUwGIgMkk21/K7lcSj54/kQFVINhX3b+kgrjZQLiTiLpYAfdzmbbji/ol/YutuMKElg/OosMDA3HpefTRbIl8kC3jSX1J0VvdUAzQReDojwdCw/CJGYc6NpAtK97KotfEB13vWyrzG+Cqjow/O5AVdwNF9GiySkWh3CEGhPpw1A5KdEpOFjkpslmbKwlQnajs7E0cddFPuV+sP2K9uebdlLM78xf6C0EnmZ8pjUqytDxr58l40/1/w2+W4KbsL4XUgFOQ7FJimJPUvlsUDKc++n90oz2i1EEQeYXvFTN4XYOIQmZ68lwnY9ZqqlhyLDo0qrpL5vp5V77/0K7Bgvhys6TKi+t734NvONkbNCTXRtpYcw/xjM7QUwbQxV1TgvM/+iQuiVWIHRIcM3r48f4mP1E5uSkrShc8ondV7T5whv22+ujfEFqNZn9CqOVM/Ws7aJyRV7qybwj4YyYR7IEP3L0JMcqCi4TuCRytyzUp4NrNb668jwpRDmecFT5047zVfjsf9Ahg8cIKCwSH1XmGfPZvmyMcZiUA4qno68DCn89kkjjj6juQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199015)(46966006)(40470700004)(36840700001)(316002)(426003)(47076005)(186003)(2906002)(336012)(83380400001)(1076003)(82310400005)(82740400003)(81166007)(40460700003)(86362001)(356005)(36756003)(40480700001)(36860700001)(478600001)(54906003)(6916009)(41300700001)(2616005)(5660300002)(8936002)(26005)(70206006)(8676002)(4326008)(70586007)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 12:28:15.7648 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba1dcbe8-0333-4637-55e4-08dab1043b3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7249
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
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The commit stream function does not include surfaces of unaffected
streams, which may lead to some blank screens during mode change in some
edge cases. This commit adds surfaces of unaffected streams followed by
kernel-doc for documenting some of the fields that participate in this
change.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Co-developed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c   | 12 +++++++++++-
 drivers/gpu/drm/amd/display/dc/dc.h        | 15 +++++++++++++--
 drivers/gpu/drm/amd/display/dc/dc_stream.h |  4 ++++
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index af81c2835738..b904b03cf94e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1907,9 +1907,10 @@ enum dc_status dc_commit_streams(struct dc *dc,
 				 struct dc_stream_state *streams[],
 				 uint8_t stream_count)
 {
-	int i;
+	int i, j;
 	struct dc_state *context;
 	enum dc_status res = DC_OK;
+	struct dc_validation_set set[MAX_STREAMS] = {0};
 
 	if (!streams_changed(dc, streams, stream_count))
 		return res;
@@ -1918,8 +1919,17 @@ enum dc_status dc_commit_streams(struct dc *dc,
 
 	for (i = 0; i < stream_count; i++) {
 		struct dc_stream_state *stream = streams[i];
+		struct dc_stream_status *status = dc_stream_get_status(stream);
 
 		dc_stream_log(dc, stream);
+
+		set[i].stream = stream;
+
+		if (status) {
+			set[i].plane_count = status->plane_count;
+			for (j = 0; j < status->plane_count; j++)
+				set[i].plane_states[j] = status->plane_states[j];
+		}
 	}
 
 	context = dc_create_state(dc);
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 6adecb62e534..2555623b07df 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1269,12 +1269,23 @@ void dc_post_update_surfaces_to_stream(
 
 #include "dc_stream.h"
 
-/*
- * Structure to store surface/stream associations for validation
+/**
+ * dc_validation_set - Struct to store surface/stream associations for validation
  */
 struct dc_validation_set {
+	/**
+	 * @stream: Stream state properties
+	 */
 	struct dc_stream_state *stream;
+
+	/**
+	 * @plane_state: Surface state
+	 */
 	struct dc_plane_state *plane_states[MAX_SURFACES];
+
+	/**
+	 * @plane_count: Total of active planes
+	 */
 	uint8_t plane_count;
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 9e6025c98db9..73dccd485895 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -41,6 +41,10 @@ struct timing_sync_info {
 struct dc_stream_status {
 	int primary_otg_inst;
 	int stream_enc_inst;
+
+	/**
+	 * @plane_count: Total of planes attached to a single stream
+	 */
 	int plane_count;
 	int audio_inst;
 	struct timing_sync_info timing_sync_info;
-- 
2.38.0

