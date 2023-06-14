Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDDD4EB64D8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jun 2023 17:58:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AD6D10E144;
	Wed, 14 Jun 2023 17:58:19 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::627])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AA8A10E144
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jun 2023 17:58:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XX+a/W1r4KSuBjYVwLGbgfheAsDh4Q/Iv1Z3MXEg8cJMTpVPGeGzYpakD8tT6V+d6F9FZSX2lHb6OPMZqmFDYsG8mJhUu4Vg9/PBU7iTkPxeUX+EVNYa3qV/YG/doTIk9ozsvBScxpss/GwLWUK3uSCIcPVuRotiGgMpTKC89AZEKmmME0FXzqQ7ytPIdzzpNuc3e0Ca+/pPqtYmVnHE2iHaWFFlGt0A2DxkaP+Qx7YNubAHxz5ht8Gg8IXJjPPvUM9rR7oT2nGMU41LNUkS4GsNsKVJlvfuhNhr5j1mXACGnUEVOsz7CBBI4K+w+J6i8fZTm+xRQro/6rubYD0VDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0OJY4tBvUZb2GeDGI6gPJy5h1R3qq/+BH1phcvdA7B0=;
 b=PrUPU8AACjpu2WpOJAU0FgjBq5cnczblA3mMEWXRoaDSx8tXxO+Q6J/gUMlgl0yd/lC3tjNQpHbAzaHfRBjh6R1jsqIgxKKUHhYrOMjBQUl5VVhRj5fzE/cb1a6fYKB+wUFbmvzi+DvoVzeWAivRufLYJXSNtZAktd/eNJywCxXO8i5tnoxMMb9G0rfksVu+CTrUDJtGm3so79Djuc3BeBF8DWSzX5oE7kqSh1vANqR8B97475uWCbnL1LUhAWfJlw4JANiCnvpbJRj7rg7gnHqya7mkukKcyoKGLSbuyLBPFonmt96LQd+bVtborB4UQkJv7AfHfg+BfgxOlntY3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OJY4tBvUZb2GeDGI6gPJy5h1R3qq/+BH1phcvdA7B0=;
 b=i49Gt8zSXUVsAg3htO4tWdFbyJ0Yy5TcB24dL78R4vfhG9m6WHG+HfmcuFH3G9C+tfX8f6pwtxlOTU3wRn2S6LLo3kw7+4+QWanIc6tw1w+NXJIbtLy/zmZpCU/9F85wY4lfwbvaqWjYmA/GwKiAV9jY+aGrt9kU6359pmAJUBY=
Received: from MW2PR16CA0018.namprd16.prod.outlook.com (2603:10b6:907::31) by
 SN7PR12MB7811.namprd12.prod.outlook.com (2603:10b6:806:34f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Wed, 14 Jun
 2023 17:58:11 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::75) by MW2PR16CA0018.outlook.office365.com
 (2603:10b6:907::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37 via Frontend
 Transport; Wed, 14 Jun 2023 17:58:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.25 via Frontend Transport; Wed, 14 Jun 2023 17:58:11 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 14 Jun
 2023 12:58:09 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/17] drm/amd/display: add a NULL pointer check
Date: Wed, 14 Jun 2023 13:57:35 -0400
Message-ID: <20230614175750.43359-3-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614175750.43359-1-hamza.mahfooz@amd.com>
References: <20230614175750.43359-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT030:EE_|SN7PR12MB7811:EE_
X-MS-Office365-Filtering-Correlation-Id: b840b637-17e5-4576-f4bd-08db6d00eb1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x8Tu10ETBWC+4mwrcqDrDn9qWBFauPBUp3xWVEPgHu3xjSWjI8dIRFC9iiU7jWpG4XFKt7yQ+CYHPAtkG3TUuDspYYzEsKelJS9rU6AU2tVCnZx+rdhazAihj0fiwHRXAViPtUtjQMbfi9H4PnWN1+XY+qi6M/R0EbyWv2Iuu5Js+4N02zqq3yJLE4MMQCXsKBLZqg72KklkoOk7CFrJ6Ni+hMc6GnlESfdgkIf1wsERqxa6blH+T/d0w69pY6RjiGT3KwJA/R2FaKVerj7nCC4DG9ofwqhyK68fjUD2nZBTTxXicohz4KRxPfiGWZo4eyX+/luJWOTMOieJiwLzlnObNmeoh/ogPJzjWFWb/d2M4ETUgFKffweL1UzX59osoLKpiCG9UHI9kbYGtcbFjc24qtyxFmN4Q9+sjps56N6uWsaUhbzKZ7sf3OADPQhYIDzLSS78ZBUhn+b4qwFxAEft3fj42i7teVbU5RwNh0q9NxyyEakaPPkjaGSW7frxvqVhe8uwRcFp01vRnZUj2Fhm7PLrFrdQAxVMe6fAiwxOA3u3DyWvJIBOOp6qgU6rxMBhbKnNy6ZTKBtdOzh0+MppIdXf5TKpdA5VT1E7zs/O3F2iopt9FQCF6HYvAy9KfoYVIf+SRgfM82iiNH9h3YRpYRfQbjZjJleLn7lueVoakQOmTs8JMTX4aBYTXHtKigraOloaUSXJD7iaP/6atarXgOjCH3dWci6Ar8A2FDv+BIeOCurKMNJgg8JlPnT1V/JKBdosONHMoFeNa7aJy/J/z++6tUYd0BIRgHggYtT0nLrsLHVHEmOyd+ikLTC4
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199021)(46966006)(36840700001)(40470700004)(316002)(8936002)(6916009)(4326008)(44832011)(41300700001)(70586007)(70206006)(16526019)(186003)(54906003)(2906002)(478600001)(8676002)(5660300002)(6666004)(36756003)(40460700003)(1076003)(40480700001)(82740400003)(356005)(26005)(81166007)(426003)(336012)(83380400001)(47076005)(36860700001)(86362001)(82310400005)(2616005)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 17:58:11.3400 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b840b637-17e5-4576-f4bd-08db6d00eb1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7811
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 stable@vger.kernel.org, solomon.chiu@amd.com,
 Sung-huai Wang <danny.wang@amd.com>, Aurabindo.Pillai@amd.com,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung-huai Wang <danny.wang@amd.com>

[Why & How]

We have to check if stream is properly initialized before calling
find_matching_pll(), otherwise we might end up trying to deferecence a
NULL pointer.

Cc: stable@vger.kernel.org # 6.1+
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Sung-huai Wang <danny.wang@amd.com>
---
 .../gpu/drm/amd/display/dc/dce112/dce112_resource.c    | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
index 808855886183..e115ff91aaaa 100644
--- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
@@ -974,10 +974,12 @@ enum dc_status resource_map_phy_clock_resources(
 		|| dc_is_virtual_signal(pipe_ctx->stream->signal))
 		pipe_ctx->clock_source =
 				dc->res_pool->dp_clock_source;
-	else
-		pipe_ctx->clock_source = find_matching_pll(
-			&context->res_ctx, dc->res_pool,
-			stream);
+	else {
+		if (stream && stream->link && stream->link->link_enc)
+			pipe_ctx->clock_source = find_matching_pll(
+				&context->res_ctx, dc->res_pool,
+				stream);
+	}
 
 	if (pipe_ctx->clock_source == NULL)
 		return DC_NO_CLOCK_SOURCE_RESOURCE;
-- 
2.40.1

