Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D1C3C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 15:54:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D75A710E74D;
	Fri, 10 Dec 2021 15:54:43 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0C4D10E74D
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 15:54:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqbe/dtaohXNEfR7XGzwb8L1cHEorQ2UKQpZG+n74mddXjVbyECgM7USzqjM10YgKfJajnAzMEKmQAxsLjzNwqGDB2/hg69WNcIAYolwTmXKLpRRD3GXQDI4u0woS3410zU0Ng68hTqdMUyniUi85EIIyfTbMcWWaYnGV67bIFN6e5froVxQor0Frvrd3EE1Pr831jfUtko2a0ZWM6ccM7RmkzYOldC4JwdUTMhIOhqdmxGzuwd9YtwLUGTTISygvmAytwIqNTumF+f2guHOjWUlag3DN5uM4yFBNGCZ155CtMUfztKurKlqE93HmQt2ts5QPUIXB5MX/wHtm7IRfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJuGAo17PnGn1ukWepRFT+xOPaiLsm9aOo93WQe+MHE=;
 b=ogPcCY3mVGo4c+N0rpHcVT80uxx29idOImZwt/5PSQc630nSLkLU5jSRYnFnkxcrnGAoYrCv67KCSYVfP3mi93jVm+xCwDZCBYjTJgUEqfjte7jMP8dV3m3aASB7pAJMqXCK2WLmEx1v4RXNTHa4MFgDE75MCOuU5yLUqU/HzfzYQ+LN8Pgwkf6SlnG7wIuLEwzvrNUPDDNTMHa006d7kSE6XvPAoqqYEJLBBTopcwvafDqZkiJANixawwUSw7LZWxVvpj5LX7kojj/js1Of6P0j3fScIISZayKWVk4U5clpT9yAcrcv/20jDBvpGG7S8CLt41UDvgyspHVDcdfhbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJuGAo17PnGn1ukWepRFT+xOPaiLsm9aOo93WQe+MHE=;
 b=2tmNgMXcJRG6WEVdbuaZ7XYW2Ea8JOsQl5/liXfm7ajppmjqxMkx+c7kzbDeqXLlZe/SzhS9CkHzcke3uFSVNiEEwRmX1SomYpzKdlXKrP4VshqyfKDv/GZTFGCZbToRhx/ldK5bK5aofjrJKzLkBdHI55vrIRLuMQuVRdZf+EU=
Received: from DM6PR18CA0022.namprd18.prod.outlook.com (2603:10b6:5:15b::35)
 by CY4PR1201MB2519.namprd12.prod.outlook.com (2603:10b6:903:d7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Fri, 10 Dec
 2021 15:54:41 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::be) by DM6PR18CA0022.outlook.office365.com
 (2603:10b6:5:15b::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21 via Frontend
 Transport; Fri, 10 Dec 2021 15:54:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 15:54:41 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 09:54:40 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd: move variable to local scope
Date: Fri, 10 Dec 2021 09:54:15 -0600
Message-ID: <20211210155415.11867-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211210155415.11867-1-mario.limonciello@amd.com>
References: <20211210155415.11867-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21cb6cf0-ffa8-4422-708d-08d9bbf5609c
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2519:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB2519C66BF1493BFF335B24A2E2719@CY4PR1201MB2519.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K2UnJRpBwkE/KGmqErXTaIVhVzn77iV7ztD7jkXBbgEnsuf6q5WMHkg1x0knaeVvJCNNP+/HOn8rdHvS8wquGrGJ51pyp5osBGt9xm09QLTMrhkqlaMVGPGmCsCiRTTco86oCvW1qiIV1As4n6yTX3wA1+crcPCMT2gxcFT1g/r9PHAdheKTxl2KKXGTGxbqorYE+tl+4nYboVvWpv4hjkHMY6+Dznox3k5Ni/CXS7H5lXheb857LwglIirN/HkGmNg8X/RUSOwsc/ozVY9BZ9efWqQmMh1YBv/UXBVdijP8TjOURU5OAu1wvSGG9vgfFNye2RFi4znGVP+wgEgbxr5ROreZHbXiegxtVZW4QU/xoIKrvfg0Ru/IPhRKgSxJ/77QoSXu54C2n3vr7p/0EC/zxnjV+VKV5BwNRMIu2jjo+ZT0CzsmCsySYfNjgpnnIeCf7lLfUXEczKrkbZIbpVR82+VJ58533LA+t4yXO1evzG2uCp6B7qC9vNSsSEJMH1KBvTMY7v4/d8RbSrqgnf6XaqpFn5bAX8YPfB0Ytj7Hs8t5wzVaQRoZ3xgomvxELfMPn1rKD89LEtMmMtAY70i1IQD0r7AUAiSyHH3mNvXOCcoJAxOH/rmvmYhbSU57E7xiKyutxWDFEtvPCXvA6ClneMaPYriKHxHcxdvrc2n5qCLu5b3uErG7XWPCZZO6bw9Wj8MijHPjagKigG+wZ0FcvCV1M95DGCz56Fb8wPqjRSUsWdPnZMoiJ2sRiZT9izOoCNRCduADbX5J5XHXe2ZNZdTUm3hZSNgSdybJEU0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(40460700001)(508600001)(356005)(44832011)(82310400004)(2906002)(6666004)(36756003)(8676002)(8936002)(70206006)(70586007)(81166007)(336012)(2616005)(4326008)(426003)(6916009)(7696005)(36860700001)(16526019)(186003)(5660300002)(316002)(26005)(86362001)(1076003)(83380400001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 15:54:41.0945 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21cb6cf0-ffa8-4422-708d-08d9bbf5609c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2519
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

`edp_stream` is only used when backend is enabled on eDP, don't
declare the variable outside that scope.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 0d6dc329dddb..fb578b311b98 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1798,7 +1798,6 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 	struct dc_stream_state *edp_streams[MAX_NUM_EDP];
 	struct dc_link *edp_link_with_sink = NULL;
 	struct dc_link *edp_link = NULL;
-	struct dc_stream_state *edp_stream = NULL;
 	struct dce_hwseq *hws = dc->hwseq;
 	int edp_with_sink_num;
 	int edp_num;
@@ -1830,7 +1829,7 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 			if (edp_link->link_enc->funcs->is_dig_enabled &&
 			    edp_link->link_enc->funcs->is_dig_enabled(edp_link->link_enc) &&
 			    edp_link->link_status.link_active) {
-				edp_stream = edp_streams[0];
+				struct dc_stream_state *edp_stream = edp_streams[0];
 				can_apply_edp_fast_boot = !is_edp_ilr_optimization_required(edp_stream->link, &edp_stream->timing);
 				edp_stream->apply_edp_fast_boot_optimization = can_apply_edp_fast_boot;
 				if (can_apply_edp_fast_boot)
-- 
2.25.1

