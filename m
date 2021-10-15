Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7BDC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:44:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F97F61040
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:44:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2F97F61040
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FF7E6EDEB;
	Fri, 15 Oct 2021 18:44:19 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2064.outbound.protection.outlook.com [40.107.101.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C61236EDE7
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 18:44:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFxmtzF8BgWBrq1sjMdz9HFFvGYv0bg2BxB5+6Pi1t3awTpBlZ0H74Of8uW8lvFzApXESEgyrC6n4g218tg3iQfpmQj+tfb9VSrU6hbfpmk1sN7cBJ1WKP+kPND9RugPDFNeROfaqz351OoSG0cPT4nD6S9l9mSTeq4vr1MGgHK7nUzZp8loDcck9ymodgZn1Pty4zSHVIlc5iIqp3X31fgaUF7WlHdAF5cyYxT1abBa0C3PUmKLivFaaIuW3unKuayqe1Yb8APC8qZWQ7LxAKtCABma6F+bneRSCO9XzSy6PWA29e7Ydh9+MaZGoyHR0NTwMopGYxn8+fFWVZtkTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8D+C+lTXTumsaLZ0T+6SNfiYGtRcvD0TiOrLhU/G9NU=;
 b=RE9tu5BSZs1XGlYUNIrw1dImfbYLMH9DlrPXa8hrb9xCgsCnra7PNw8Ply8wzyslEkn4w+CegGegvaa5VwiX4YtCpT31I0EwMD6M5K4V4Smk5pjTME3EWOO8eSJikKPVw+N4BJfLfVp1PqbIv4LWqJ2YV28eITRPoZhmPS4q+gZ2//xJOKvdSZRYUdQXtSapUqWis7FXdDCYvI/VtAM+o3kKslCIXtvgh1ECAETI30TBotNdrcHn8mKebSRakeRF8mQ1cYcM9R1AxWJvzStWVpVmMkMMajSHXu/0pd/A35Gj0VO7w/upEiUI5+Oh8m0a2jFErPGJGDPRNz1f1XQDTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8D+C+lTXTumsaLZ0T+6SNfiYGtRcvD0TiOrLhU/G9NU=;
 b=rhwkinp2dbtDZo60dJqI6j2v4hAtVTZhu0VPKZ5J+cVv4slJZ295qo15vWLIQ5qlavu6Z7k5ycGLNgwIbXq3l9cTpFFArKlfhOGE63v9kxLHBOsoU8HB76p0kS/RFy6rGOAJAU5kMc4PvGxcZZbAxe48M59FCMniP4hoIVdw6Fw=
Received: from DS7PR06CA0029.namprd06.prod.outlook.com (2603:10b6:8:54::29) by
 SN6PR12MB4621.namprd12.prod.outlook.com (2603:10b6:805:e4::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.16; Fri, 15 Oct 2021 18:44:14 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::16) by DS7PR06CA0029.outlook.office365.com
 (2603:10b6:8:54::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14 via Frontend
 Transport; Fri, 15 Oct 2021 18:44:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 18:44:13 +0000
Received: from ubuntu.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 15 Oct
 2021 13:44:11 -0500
From: Agustin Gutierrez <agustin.gutierrez@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Anthony Koo <Anthony.Koo@amd.com>
Subject: [PATCH 25/27] drm/amd/display: [FW Promotion] Release 0.0.88
Date: Fri, 15 Oct 2021 14:43:30 -0400
Message-ID: <20211015184332.221091-26-agustin.gutierrez@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211015184332.221091-1-agustin.gutierrez@amd.com>
References: <20211015184332.221091-1-agustin.gutierrez@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2006bf3-6360-400c-6b8f-08d9900bc8db
X-MS-TrafficTypeDiagnostic: SN6PR12MB4621:
X-Microsoft-Antispam-PRVS: <SN6PR12MB4621B834581F8FC660B385EAF5B99@SN6PR12MB4621.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cxizPrh3n4EG5SNif2XsQNlDR7TY968Kx1ASdsu3PY2h3smqh7q8wSMi5lCx4FZ8Q0sWVtVeXjnMaj4HG6ia2BxxY/8dZXIz4F7QWggKrAiZ9u3SxE2go8dQVjyvBi9cD4eVHvc9XOeDDlp6GynzCfkhQvjEvEOh4T4SAA0YVfCl58nafHS/mYuu5WFkXZxg+KlOfagMjQj/lHHNY1BbviyZh3YkB6L1cY56IjgCiD2YdaeFpTQ3PHNL0wEOQlTiFrPkGCOQ9W3uRaIpm1gzR9UcfQiyBvX/14vnF3LWvtlU7MIjNcYUh31zc21HO5Pj8l01nzIsL06w8E6rBUQ1nM1mcGO+4MIC1BMg5moEaZyxXfKVE5S/tkbOrFR7zHDVL6TfCyUC1xcJNC9GZl9sz7C+juaxIWGZIwhH95DHX+gFFrJzj5hoiYOT+tvW4KI0s8uP1wIIRANkQdZClO9RfHBjTVGIEt8lqEfFbH+5sCwjesorpXafHqRwZpJvvChQvmcwUDsCpQ0VgmlSP/dpAJxzjm1Q1/nqdzbYZXImcKbIm3xIooe2ez8Ilvw1A/aigkEEj1esZXEy5sCPjWeAlMwpNM0qc+czY6mex7lOoaN0GUFUw601+VhPfmKH9TJJWvwRh4/UhztEgyp2oRGUy61DUByEFyM3MI2fhbOa/yXaqAI1ZoEMZeA09i/h1lgqQJyW3AsFmr7u1EOol7y8yCvju/B+HDzHLzrzym6feec=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(82310400003)(47076005)(356005)(26005)(70206006)(70586007)(16526019)(6916009)(316002)(81166007)(5660300002)(54906003)(83380400001)(36756003)(426003)(508600001)(8936002)(336012)(44832011)(8676002)(1076003)(86362001)(186003)(4326008)(6666004)(4744005)(36860700001)(2616005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 18:44:13.7689 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2006bf3-6360-400c-6b8f-08d9900bc8db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4621
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

From: Anthony Koo <Anthony.Koo@amd.com>

Acked-by: Agustin Gutierrez Sanchez <agustin.gutierrez@amd.com>
Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index b37a485fcba5..bfe052afc518 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0xf0c64c97
+#define DMUB_FW_VERSION_GIT_HASH 0xd146258f
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 87
+#define DMUB_FW_VERSION_REVISION 88
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
-- 
2.25.1

