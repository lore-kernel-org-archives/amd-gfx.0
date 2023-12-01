Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EBB7C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 13:28:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11C3010E87E;
	Fri,  1 Dec 2023 13:28:54 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34C2C10E890
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 13:28:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/UivdNOhBHhr/PN+f0HhLPipsnB8xBvCDFG8x9I+1ydUKKkOtR8pbKtmonttJlw0+afBjbKjYURUay468IjQ7bCCkEcTzRQqxVM7JsPzKtwxm2UcIX43GBm6n43LJRyIwPcrfbfiTJcHTJXhMCWJMyU291bmrQlyNW495Vv4au9GEYldJ1+8EJuv9f/OEO810PtJn4Vf2n1BTOxNxenBidR9ExrWURkoSV7/GsFuGXshg7fzCWmNTxhMpNR3hQflz/KXZsttMFqJGChH9tTurc+F8sTSzWOuDUBgfaQnHh+VQVB0HCK9yfBX63gn5jA2g+atcXYXs864aODS3wZOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFlRoMV17JpAEJ54kYonQuAHYmyUFbpt5m4khlqjd+8=;
 b=CLe6qmcZq9VuHMTWUG2QZ5RIP1gIjCqXzAssV/i5wxSDyV2iOEK0s+fERLs1RPPQYUKkA4PMZBozueOWCFVWVDg7/0mPCC831MjfeVGOxouT8BoSpSunC8j4hvOEPslu2ZCWndrgra269aPQj2MO3K2sePGPDfEOwT+J0+QtZkKpeVY4zT3JOt/I2wGz2wOn8n4vwyj1lt0fdfmpLcpnW84uHBUyL9T49EO49QuZi2VetvoV9F8Qa77DhcC/23Ag9s1gQSiUOr+nUNWe1pdT2hgRJ/F+J1JFK6XIruirtBZTXNZ60/zYkoSBfwRFPRnnIGExjKXTA5ZqXqW7Evbn3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFlRoMV17JpAEJ54kYonQuAHYmyUFbpt5m4khlqjd+8=;
 b=dJQkPcA0G59pq9lOVru4Twy2v04AmDCqnFVv447lzI64I03sKHSCTJJguTblK3B+CniGe86qV3HJTPSysEIDptR21xydoQnAYXjl+1Fg4fuomqLGhOqCugQYqwZZOY6BKep4ESIyq1C8rFs6jRPpbixOAvuzKfnqIRquSVXfeUs=
Received: from CH2PR05CA0016.namprd05.prod.outlook.com (2603:10b6:610::29) by
 CH2PR12MB4120.namprd12.prod.outlook.com (2603:10b6:610:7b::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.27; Fri, 1 Dec 2023 13:28:20 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::2f) by CH2PR05CA0016.outlook.office365.com
 (2603:10b6:610::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.18 via Frontend
 Transport; Fri, 1 Dec 2023 13:28:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 13:28:20 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 1 Dec
 2023 07:28:17 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/47] drm/amd/display: Fix null pointer
Date: Fri, 1 Dec 2023 06:25:08 -0700
Message-ID: <20231201132731.2354141-13-Rodrigo.Siqueira@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|CH2PR12MB4120:EE_
X-MS-Office365-Filtering-Correlation-Id: 11a30505-6275-4e47-503d-08dbf27162ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 33FyPutB43HuznMq4U/mYfQ4Gxx/os8YiHlAsMhr3X4xsM9yTz7peUQ3qxIOJ9XAVIF1jDDd76PAa5x1eGEIi32TY5i5Muf5QjIb0zA/mkaJuGSi/hQxKIWmN45vLNsz782/QiTT893bLa5oR2L69J0qXWxn+Ip0LylMZwgevT5BwkPY3NcVbjTHvDzt1Vd7ino0jE9pqvGPUWUpTLn5sGxYdXOGtNHjY829ICxAMBiMsPmSc6dCw74GJFyHQix0nRfJr9cbhxgSpqH19U+Mn7EZa/Xgr4ItcHUxaP4DJtzjWEJLZrZqyn7TCG/Hho123RVBs4y7MEI8TpALXyDiDSyo+X1Z5xAJGhl19QVTj4dyrnMGSKGOqh3PlHIDDkRWS+X3Pl/oyAuAS8SEbJpl+OwnQ8ppGA9k4FlWRhu+0Jp6uhvRHkgY8rQXBmOvaSKsy3ONFZo36TfAppcHc3lXC7A+mxRsO/4A33q4gWh4rVRpg4x2xYc8WwvFfOOPzBAyLyeu5WDTK8j5fzvoCgzWfSjQlc2IOMWxUtuDJBqdZ2zaDf0NMWMMYAJPaYQWVRcN+HRq8sdseNBwz+SMQWzjzEaQRoAhBOIWr8jAPiEp1pvht9la/Ce/xfDHs0EQ9eKl6X3TnIhVKFNpRLU2QCZ2+tGBxNEsd81z37811tE1XHumTgMnG3li7srvXC0izhWiR/eWV4mRUY6l3znL8H1xRkmdtPxW9mDjIuPR1QR8cNtS9ODkqX5WpRB3KRKnFe1OV6Hn7rS9xT2kWLrntKhCLA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(186009)(82310400011)(1800799012)(451199024)(64100799003)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(36860700001)(5660300002)(356005)(47076005)(81166007)(86362001)(2906002)(82740400003)(83380400001)(336012)(426003)(1076003)(6666004)(2616005)(26005)(16526019)(478600001)(36756003)(41300700001)(70206006)(54906003)(4326008)(70586007)(316002)(8936002)(8676002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 13:28:20.2896 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a30505-6275-4e47-503d-08dbf27162ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4120
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>, jerry.zuo@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 solomon.chiu@amd.com, Daniel Wheeler <daniel.wheeler@amd.com>,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, Johnson Chen <johnson.chen@amd.com>,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Johnson Chen <johnson.chen@amd.com>

Add guard for NULL pointer access

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Johnson Chen <johnson.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
index 6ba393e5b8ee..38fa7441df51 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
@@ -158,6 +158,8 @@ bool is_dp2p0_output_encoder(const struct pipe_ctx *pipe_ctx)
 	/* If this assert is hit then we have a link encoder dynamic management issue */
 	ASSERT(pipe_ctx->stream_res.hpo_dp_stream_enc ? pipe_ctx->link_res.hpo_dp_link_enc != NULL : true);
 
+	if (pipe_ctx->stream == NULL)
+		return false;
 	/* Count MST hubs once by treating only 1st remote sink in topology as an encoder */
 	if (pipe_ctx->stream->link && pipe_ctx->stream->link->remote_sinks[0]) {
 			return (pipe_ctx->stream_res.hpo_dp_stream_enc &&
-- 
2.42.0

