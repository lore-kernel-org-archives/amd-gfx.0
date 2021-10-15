Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28083C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:39:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8EC161037
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:39:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D8EC161037
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F6AB6E550;
	Fri, 15 Oct 2021 18:39:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AD776E3AC
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 18:39:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AKZipEbfJvuE/PQ2P4QXjdj/ry01nTZN6dg1OC3xJ6eueUnFCJ5yFcx2eqL4mLrMA0+qLU3KgizNk+IAHWbBo5dokqBs9MwRZy/SAHI1b/cUKfTMAIT+PTBtJ23aI3QZnOjRPQCgfQcmyWlnXCm8wabDSfHXNrSHDxYRjWy422/hO1mV3PbtLdWZbfENwkVV6d9cJ9o6yHvQH/EsTHiRnvF2oSPVEqVZRGBwRyyg7yZOg4XPowmnvbiWQTFoFLuaPhpSUD8HLC+3xMWtuR2234XlfVnVi40m38wW8VY1NxQA+foQD/Z6mfy1rv/LmG2/mVjL+PDDa1Tt2MfLYsjvzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JrPsVu5/JPxiJaHo7HNgo7QQ+3RCTzntzyYihGTwyTY=;
 b=hgpVCqjFLMr4r74dLijGuE2YTndaoq/6q8TdPUSC6XDV39lpIvrQVraGby2t6haTvqOhIZizQMAXEKJZ4rGznCcplvnfFEqKCFxUxhUAjJitiNHJk6RwXGtxKNgq5hlSSLnpyQnVs6Tk1AbL6jza0B8iGVBfpqqMnWYQpiS3BY78lLVlzlGR1+XazYz/Z3POJkhiaDCbBlJJZU92dMtCTZKzKmkDm3oXkZTL9KUmRDKEaz2/SZ3v4SFcQ2a9Q3mwN/9rO+FT63e7fxuHThL8YMAd44tnxLMCYedK0rfQ/4zMNWJ2YY9lD4eyCWIjBEUHoZBXQtgvBAXXNzi9Ovldfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrPsVu5/JPxiJaHo7HNgo7QQ+3RCTzntzyYihGTwyTY=;
 b=uWZBGA/Ytv2thTLAyF0kezFWNighC2ECrbLL7Ki1kffpF5Zn4T4lgHg2P//OQPrYx6vQzefd8CAsebKjNlf6+AcAK7o6t2/7LPjGZcsgUwaawlqQO5Oc6d79WBe19jopMxNLDeEKaFZk384T+kOxcbCbQTE1a/rGJwqmUKqxyyA=
Received: from MW4PR04CA0228.namprd04.prod.outlook.com (2603:10b6:303:87::23)
 by MN2PR12MB4222.namprd12.prod.outlook.com (2603:10b6:208:19a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Fri, 15 Oct
 2021 18:39:14 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::18) by MW4PR04CA0228.outlook.office365.com
 (2603:10b6:303:87::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17 via Frontend
 Transport; Fri, 15 Oct 2021 18:39:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 18:39:13 +0000
Received: from ubuntu.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 15 Oct
 2021 13:39:10 -0500
From: Agustin Gutierrez <agustin.gutierrez@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, George Shen
 <george.shen@amd.com>
Subject: [PATCH 04/27] drm/amd/display: add DP2.0 debug option to set MST_EN
 for SST stream
Date: Fri, 15 Oct 2021 14:38:22 -0400
Message-ID: <20211015183845.220831-5-agustin.gutierrez@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211015183845.220831-1-agustin.gutierrez@amd.com>
References: <20211015183845.220831-1-agustin.gutierrez@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94d82da0-d31e-4d73-f055-08d9900b15df
X-MS-TrafficTypeDiagnostic: MN2PR12MB4222:
X-Microsoft-Antispam-PRVS: <MN2PR12MB42220143C4417926D6055E80F5B99@MN2PR12MB4222.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 061N1EBcIjMOACuetZ7VcxoYMeZkxmwJP2r+20exC2ZMG5bDnz3mg21C+obvrlGYIz3A/DPmQKWvnBG/Kxz27jEyCZ1NqChbY6IA8sVK27GH23q5dyzhC7aebbVFimq6x2H/XbYSFd0JGNdZpxUy54RNoo15w37bHYlIRwLkNAH2WNzvH+p/JW59+/qNR5wU2JP6oupvTIXYH/mTGCGzBzZB4rog66VFqJVuc4Ee8tPBKiKmB8bs78T3cTKKY2I1aaJrhPFygbbKqMds8j/g5nI9N9+poa4UYibOkA9Gselzt2/rHKyMcH8BzZ8oj60hDoEL6ECinn0Ro4eOfYq5Ie8TRJz2qpToNJE/Un51j0JeF5UHbPVWpIi2dHizoyPJCetsJY6fMLb2p7fwjwfQvCFZKBr7nF6MJMVD9GGqRuyoMPgQ2q7g+y29z4p8yydyR257N3kY4WHve0rR12yokRgzfa1WUD6S8fJZ04oSb/VjZJUfEn/QuXQOqQna4mPNb5HbOd2DT6LvfsxCvo6aaJB1wbrfyKG3Ds7lgQhswObG6Aus3rOlJByLZT+/bGlCKt7mOyrRbcrKPzm1fxhlRP8gf/e5JWQgIJUs0T40Tax8nswJ5MOppZbQlYq5pXNpZmsCIjDFj0oUMXJZxenf5HSw3qZfq61NPxFC7a16nKKWlv5yv3Q1HUFvyk7q9VFhTEqr46UH8so5HzEBZhaeSDxnqyghM4PoLhPvHR+Xbxg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(1076003)(83380400001)(2906002)(47076005)(8936002)(54906003)(36860700001)(508600001)(44832011)(16526019)(6916009)(4326008)(26005)(186003)(356005)(81166007)(36756003)(70206006)(82310400003)(5660300002)(336012)(2616005)(70586007)(426003)(316002)(86362001)(8676002)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 18:39:13.4041 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d82da0-d31e-4d73-f055-08d9900b15df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4222
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
Some DP2.0 RX requires us to set MST_EN even for SST configuration.
We added this debug option so we can configure this temporary workaround
for the RX.

Reviewed-by: George Shen <george.shen@amd.com>
Acked-by: Agustin Gutierrez Sanchez <agustin.gutierrez@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 7 ++++++-
 drivers/gpu/drm/amd/display/dc/dc.h           | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index ca5dc3c168ec..fa11a2b094ba 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1869,8 +1869,13 @@ static enum dc_status enable_link_dp(struct dc_state *state,
 		do_fallback = true;
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
+	/*
+	 * Temporary w/a to get DP2.0 link rates to work with SST.
+	 * TODO DP2.0 - Workaround: Remove w/a if and when the issue is resolved.
+	 */
 	if (dp_get_link_encoding_format(&link_settings) == DP_128b_132b_ENCODING &&
-			pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT) {
+			pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT &&
+			link->dc->debug.set_mst_en_for_sst) {
 		dp_enable_mst_on_sink(link, true);
 	}
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index dd995905b0cb..254b760ae91f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -664,6 +664,7 @@ struct dc_debug_options {
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	/* TODO - remove once tested */
 	bool legacy_dp2_lt;
+	bool set_mst_en_for_sst;
 #endif
 	union mem_low_power_enable_options enable_mem_low_power;
 	union root_clock_optimization_options root_clock_optimization;
-- 
2.25.1

