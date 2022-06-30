Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F941C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 19:14:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0825113AD1;
	Thu, 30 Jun 2022 19:14:52 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BABB412A915
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 19:14:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQazbI6L8/KGY6EuvKVmjaKFUuFUOE+DXgwaM+og7da5fvpW+SCjVGzqJD+BlVanAuA7EfDZR4fDEyfLw03PNdJ2y5W1FAHDTRlk2RZ/FQElK5uQUBelZQpOG/1P8cpszxuWRTPBLd4rWNbHivpz/a05V+i/HlBPY5QzeYYLFz9hwIhB75nkI3Pc5haYp7gtwJKPu8XRbkxwIYsMIJNDqo9IYyYXUnUhV62ElP0wFpYqxIh+Cdc2FV7/hbgXD5b+y5+GQntAGX5imHbnnorM09gaCfIKnWDm0wmsBNiu6/fkiy/5nzBSIjUVEVx+Kk1Pfx+DqgB+QSz3j/tkWzJpxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sunpC8T0+i2S4IKux8rVGNY52zw58ViarviakApA90I=;
 b=AeFvmtxwNFK587VNyaErhTT+0cE7Gvd5MYtQbp4SvJhBXNaWRgzljv5mtJIMap75r4b3LqQL8eyYK7tHsfHr/m4GYW7akDN5EX1GClfIKvZoTSCB8ekm30osxGJ0iucyzhVd1Mz4x/hed60RA40T7IPF8/XPv8Vb7k9zkSRUT9Q9kTVVi4C6bk1k2L52gQWRbfFc7el1AclGlWHp5ZZGOXFbELMaayh7ee+/8hzhV80TlECFSmJpDOEncUFyNujiJm/dBSl7oxrpNQlGzVTHo9DI8ionLiV76nYn0gIf9cmAWYwP/xoOWEODfRS5WpBDSUx98oGLT3UTJUxzdRYaPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sunpC8T0+i2S4IKux8rVGNY52zw58ViarviakApA90I=;
 b=JgQ4ampNXoA0u0ZZSIR4hb+6B5ZGwwYD1lG4dFIbDJZNThs5ptTg03gaGOcjzFQIdOPuateyDepSVFQhyQB2fMOnhAH3P8CZEiN6VnImZ4EbnZEGQKiVET+XJKWZ9WiOVmC9q3S46IvNZavn9RveFTsmJM1ZpIKRU/zf9M8CBXo=
Received: from BN6PR17CA0050.namprd17.prod.outlook.com (2603:10b6:405:75::39)
 by CH2PR12MB3863.namprd12.prod.outlook.com (2603:10b6:610:2b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 30 Jun
 2022 19:14:28 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::d3) by BN6PR17CA0050.outlook.office365.com
 (2603:10b6:405:75::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Thu, 30 Jun 2022 19:14:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 19:14:28 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 14:14:27 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 39/40] drm/amd/display: Maintain old audio programming sequence
Date: Thu, 30 Jun 2022 15:13:21 -0400
Message-ID: <20220630191322.909650-40-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
References: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 000ec994-98bb-4ab6-875c-08da5accc133
X-MS-TrafficTypeDiagnostic: CH2PR12MB3863:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6LPWzv7vKLLlOFusFUy2+GPYqviT0Jz4WHsW87+VxCCLmJc6KxPNSL78RDRTqNc1BCkCzeM/c/EkywpzjSxYHzsoQYMtgb/LBARVpYKoUsU43zCtPHCvxpa3U7z1XHYmbshZu8pmBfKlQhpkpxXxB8sO9thaClu0VNp+xOA4tY93w821/w4vqDRGPbqyxezEbZSlXepQuNfeIeMnMfNuGw4x3ZnB5B1o6yzmyxnppTxexaw+HvGnf/vOBqJfdoBatMJsgeDCsbxNSQ0pjyxZd9+y1WzgEUh5xk0uuy2U3YD/RJKIBG5gwVvCBElVhhufmaDzF01xJhaXI8RcssH2VkxSA/mT8gVCbWXbqOygFsZLYDcT/KXkljH3V47Kusxy+aT8ohg/1tQnqgWJR3xChEgVxsGcR/7EMee9ZZ68P4jyj3G4p+AL35WSqxpJQ9HSfoMUMPpMAz5NVybzj5b1+YEox4OCIipDc7k8LXjhJDXmzSExQFjDxOjuTBJRnec14Ru+zYxyjztUOIOIoAWV5cKf1ShjTiObsBbqv2Y3xW6W9gAJGA0hWqKK5pniSioblhGl5pxCGiRt32Zw/gdhCa7DP90NRfRNyNH79FeOTnmTGZu9u3XclPtOlcY36xttFiNw9gweA3g2LgE+mPL27yhS4Rcqw3Y7olTHei5b5BqxnZ2+x82hWK+QgWKAi0cLCn1oO5ZyzbtfFG57sRDSjv86QA4UmABA317AtkirYODp56XKP60Jd4sxi3a/cTBcTyts7nrTi5l2CbGDDlOd7vbEPJosxcjBf6Vh6ErbO2NyyoqUdJOTueIpN+btWd0EpJOU9NQFUqfFfPBnXQjRdOkQsQdCnbKiBPla9pFZKaU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(376002)(39860400002)(396003)(40470700004)(36840700001)(46966006)(1076003)(2616005)(8936002)(356005)(478600001)(6666004)(41300700001)(426003)(6916009)(16526019)(336012)(186003)(36756003)(47076005)(36860700001)(54906003)(86362001)(70586007)(8676002)(4326008)(70206006)(83380400001)(81166007)(82740400003)(2906002)(7696005)(26005)(40480700001)(82310400005)(316002)(40460700003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 19:14:28.6773 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 000ec994-98bb-4ab6-875c-08da5accc133
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3863
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
 qingqing.zhuo@amd.com, Martin Leung <Martin.Leung@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
Program audio DTO before wall dto for audio

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 .../gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c   | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 76e1e0966064..e69c942c8345 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -2171,16 +2171,14 @@ static void dce110_setup_audio_dto(
 			if (dc->res_pool->dccg && dc->res_pool->dccg->funcs->set_audio_dtbclk_dto) {
 				struct dtbclk_dto_params dto_params = {0};
 
+				dc->res_pool->dccg->funcs->set_audio_dtbclk_dto(
+					dc->res_pool->dccg, &dto_params);
+
 				pipe_ctx->stream_res.audio->funcs->wall_dto_setup(
 						pipe_ctx->stream_res.audio,
 						pipe_ctx->stream->signal,
 						&audio_output.crtc_info,
 						&audio_output.pll_info);
-
-				/* disable audio DTBCLK DTO */
-				dc->res_pool->dccg->funcs->set_audio_dtbclk_dto(
-					dc->res_pool->dccg, &dto_params);
-
 			} else
 				pipe_ctx->stream_res.audio->funcs->wall_dto_setup(
 					pipe_ctx->stream_res.audio,
-- 
2.25.1

