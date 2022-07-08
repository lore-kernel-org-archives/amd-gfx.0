Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E311C43334
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jul 2022 15:50:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2505310E78B;
	Fri,  8 Jul 2022 15:50:56 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04DF710E78A
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jul 2022 15:50:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cACSFSaJEIxBFOx7cLi04ljzniOBGcFuRx7EK04KkcFrAp9zwBs76ATLbB4OqXtuqfPBN7yA/SplIaPe6o0zzxQJoLox53cQqOy3D+jbDESJG9UPX2K9qSJgwCpjNFIwH/LSwqow7qR/JCKJMkcGOF/UNn5Coy5/wEzIZvuTYc4VrXTxw1CbMycAZpY/n0JsRgBIIOv7xJs3n4OIhi+YlAOpZBUWRfijpFpXh0cBvZF0Ij69dTgutwe5V66iS2hse6GSSXBTY2EbyNtNicMdoe4bsWAxLUX79qIGUDgYqw2ZYcuW18fyBjS7T+7Bht4FYGUGll/BRGTHZL/OWu6ggA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRBGMHRfE17mCsACwgt3wYbHf8e9zwFDj5ekvGnVnBk=;
 b=ETAbdifc5U9Tf6+LeWR3mPYI4MHWXAMIpj14r5YvZsOA4Pa7IeB/hIJeQ9auBl4YJenUEZlG6A14IRbvppef+QBhgP92dFVNssYaWM64dr4MqhCbwLusgKL3RlNn8F22KW7+/LurgjM4Hg/L0nCzVpflcLdp0jtHnqJvMhLvpssxz93x709sO6B+wGo1sDAWAu+FiPO71ZkHVVTLiPVXOiZo0mL0VZuykuw/uPqR1pGQTKRDjGR0oxdeZs1Uek0enPCVuQX39c+/uP7DXzFp8q+MiHqY+FVCaLH+5sloWvhUfcRc+PQ70wbZieuQRVPPbOWgs1rCSqNcUFc8MNwnBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRBGMHRfE17mCsACwgt3wYbHf8e9zwFDj5ekvGnVnBk=;
 b=O9I9GysKFdlnBilP9QIyt0s+KeCqp3D/T/66MJMW/YejRB/pX5O9k53FN+I2gAQcnII0cGN4F+egTlTKkW9IiI7501GNRuUX8L91MaNfnw5nyYO1oq0tYb/6NBMsFeCvEdvXxogcoMHXQ4SKOWIQ24nn2CaHxZXejxaMn4pu9mo=
Received: from DM6PR08CA0029.namprd08.prod.outlook.com (2603:10b6:5:80::42) by
 DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.15; Fri, 8 Jul 2022 15:50:50 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::44) by DM6PR08CA0029.outlook.office365.com
 (2603:10b6:5:80::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15 via Frontend
 Transport; Fri, 8 Jul 2022 15:50:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Fri, 8 Jul 2022 15:50:49 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 8 Jul
 2022 10:50:48 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: make some dc_dmub_srv functions static
Date: Fri, 8 Jul 2022 11:50:36 -0400
Message-ID: <20220708155036.1092134-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32bac2e6-0fc7-4bc8-a596-08da60f9a18e
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zmaF05AscRQy+f76WScfdF8xzgiIzBRs5iN6fQwBpZmaQxmsb4EswjFSCeZWUluegE3r5b3u0tEAuXh0UsmRpFuYWP5ccCirsljtL8a6K8o9D2QV6/RDXmNI2Z2fCKae2g/kIicftZsbpSGkVVrW9PEN3r0Hun47y41d9XLNGAT7eaShOf7kUgtE4o0+RipmWFNgOE6VELG71HaQlGyyKEck5jzaw/oOLOX3EFpI6FyrGMKl68/vLfS9sH9LsfTpF6gOq0Fw4BORP/x5Ulp0V8uTTE+FOhWLXgP5D+8+JbJdeLFTDjuTD7tKDk7Ofr0W1Y7MXwrqGDIVs4diJ2qJtHewRG1P7GOe7swzaSc3SELZUUyVXrCPM9SbUr7FESDVlwCbRb+YUypVyploMjHZiPkUxpBXQplkrNVQRk68W825RutUFqNiCFetb+PwelTclGcfRHAfDiiwxo0MGLq7vfJ5SADVrBhmVoOHSUdx7LG4VV21Nr1rICPKpo326ZEpY3RqiSAoir8KFrHVqruyHNEEbAv4d4J8yDY1oj0+rTwYBYrCiAYsmMqZNDzO6gUXRzeTpvgxMrFN2QFgrVkYN186RiQdPB0R1Y8D1W2EoHiqgA66UuU69p/xLwpXBLhVT+TWUjlrbqB3lGrQyZ1Yp/qwGxiHj4jTmNUBW8jdb8k6d8pU3D2dvTH/+Y+0fGQoU0E9Bpme+lm3bQ7BLw560WVh+ea+idFW8kDl7ONGjToYdoG2Js/uFHkisink0brffbEvI8ZXICzeQ89zNp/0BWmycokvvjqGBJHyNqEMsJuPyfGyMFXPN49kCUibRM4FDKTH908ZZmP3WLml/tlYwWuib7t1buBxy81Iy2VVKH3gHPoGftuvskOvI7pj0EQK
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(39860400002)(376002)(396003)(40470700004)(36840700001)(46966006)(82310400005)(5660300002)(6916009)(86362001)(70206006)(36860700001)(8676002)(356005)(70586007)(8936002)(426003)(54906003)(41300700001)(6666004)(4326008)(316002)(47076005)(82740400003)(40460700003)(336012)(34020700004)(2616005)(36756003)(2906002)(7696005)(16526019)(81166007)(186003)(478600001)(26005)(1076003)(83380400001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 15:50:49.9012 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32bac2e6-0fc7-4bc8-a596-08da60f9a18e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6095
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
Cc: Alex Deucher <alexander.deucher@amd.com>, kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Not used outside of dc_dmub_srv.c.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 832f7a4deb03..39b426d04037 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -270,7 +270,7 @@ void dc_dmub_srv_drr_update_cmd(struct dc *dc, uint32_t tg_inst, uint32_t vtotal
 	dc_dmub_srv_wait_idle(dc->ctx->dmub_srv);
 }
 
-uint8_t dc_dmub_srv_get_pipes_for_stream(struct dc *dc, struct dc_stream_state *stream)
+static uint8_t dc_dmub_srv_get_pipes_for_stream(struct dc *dc, struct dc_stream_state *stream)
 {
 	uint8_t pipes = 0;
 	int i = 0;
@@ -284,7 +284,7 @@ uint8_t dc_dmub_srv_get_pipes_for_stream(struct dc *dc, struct dc_stream_state *
 	return pipes;
 }
 
-int dc_dmub_srv_get_timing_generator_offset(struct dc *dc, struct dc_stream_state *stream)
+static int dc_dmub_srv_get_timing_generator_offset(struct dc *dc, struct dc_stream_state *stream)
 {
 	int  tg_inst = 0;
 	int i = 0;
-- 
2.35.3

