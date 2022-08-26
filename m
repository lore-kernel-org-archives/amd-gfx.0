Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A946ECAAD4
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Aug 2022 02:52:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D845510EB81;
	Sat, 27 Aug 2022 02:52:17 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E66D10EB81
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Aug 2022 02:52:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xcfx+kjzcqwSlFwX1XPG/rHneVc3TWCEhiELQ0QR32kUr6ff9pggCQk2y8zJltugtZ1ndENBkl3lHejgeEstCOUOkAyv52DB7I2thUPdBFNRVqrJiNeyULgSSdL7/ApH32PyImK9lpBqTqDRx9mhz9xLOvkxW+AtaMDAVex0oRZmTYkXkyybM6jaelseOZZYyl1yy6oZI7qgiEbh2u4muULUCdihkZINPEVWwYUFMZ8eszeHHgqy3rPs54v1RpjW/cPkKEwg1DNy/681FdCVrfIBr1OJoTtgqoMLa+9Ms9TofvgBfgmEoFIUnpzDhyAJCLucejr6rEHmgl5w+BTzkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2qzsnIQJssoAgE47t6x5RUqh3NeybF5NpQNa2PMOm8=;
 b=ZnsVOlxsKo0r4wJ+Y3CLC3sdyhINrJhIKbl2WmJVah4FVykS9BsrSOjYDO2X445AsnpbbOIWXeLjH303fBSkCyjMb3kc7RQoxEkZeeER/DSkOaPSEZkbhPKaQupGCeI8IcHZVBWf6WMxBd5WR/Ot9zFrkMDRK84Z3GM0Xi3nLn0DG+yrGaW8OTRO1LR63bE8/44QeCEW5LLqtufcTZ8+EP4pMtt42uJggk2z8KX4U9fVQL+3t/rBXUKw/gzwPW5th/iOBUgSVF5cZGjkzzUiXmAgF5FHYxxtn0r9LpmGF2wOyqo+Gvvm0OdbZpR6qk82By7ES2sbiQh4rjEntGMjJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2qzsnIQJssoAgE47t6x5RUqh3NeybF5NpQNa2PMOm8=;
 b=1L/d30yOJBUJRtzkJ7wGj/Ih/SRR725+JkJzM+oqi3PtdAnwNPmWX0AUrN2/Tc0EuFPcDjOScu58ZfAsMpBu93uz3H5A8NtgPsrBR46qE/pvZqdesLcAfMD2PB5QnG88rlKvHtnf02Hgt9Kx7+FQB6OkjcXWTVua8Xe7SeWxWAE=
Received: from DM6PR13CA0006.namprd13.prod.outlook.com (2603:10b6:5:bc::19) by
 DS7PR12MB5815.namprd12.prod.outlook.com (2603:10b6:8:77::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.19; Sat, 27 Aug 2022 02:52:11 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::9c) by DM6PR13CA0006.outlook.office365.com
 (2603:10b6:5:bc::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.7 via Frontend
 Transport; Sat, 27 Aug 2022 02:52:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Sat, 27 Aug 2022 02:52:11 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:52:10 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:52:10 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 26 Aug 2022 21:52:06
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 23/33] drm/amd/display: fix wrong register access
Date: Sat, 27 Aug 2022 06:50:43 +0800
Message-ID: <20220826225053.1435588-24-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826225053.1435588-1-Brian.Chang@amd.com>
References: <20220826225053.1435588-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 932871ae-550e-4de4-b5bc-08da87d723a9
X-MS-TrafficTypeDiagnostic: DS7PR12MB5815:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZTAALP9W4+n+GziB4180BIhpolHOa8U1Dkni8KvEmA02elekCrkhWTaCvUEiCZz1PpA3wvBUArh5tPMl+yO7yklVHMg4V91KoiyOGDBz6Yufo3GACK2OG/YRShiDaYcGYxRn/eYQdBSqU/b0UX1Jax8cFoPkvsfiEUIjELni7Hb2riIh/H+qWgTcM+CAij+hf5hYccnPzTqC6RtXlvh5Ww/1/GRghLNohjawT/5+mkQhdE131Xx4k8wm73Benj/G7YzhDxnqgJ/Q/0S02an7nUtWIH+YVVYgj6l0zvCwAbl2VXJX2/ElfpudH/tkRqBiw3nA7RNa0OWdy0QaEAYLfhPptdbOBRvnZh056W0CLjfrTKvoU5a40wPKAR/e6/mm7Fm9aEg56QQSUxx7GBWw780O2YhoBiGnO174LoUIKNDh3yXgqTcF/Xk1iIbtalOCdQ32n5VT3mnyQFE/tdIyhjdom55/s2L2c6rus9U28f/GdIQ7VwBBgYuAN3YjPapuxXlwMOyc7bgos4uhcTcWwtv2jDJlHV3egFh5fVYai5dqnKbVIZb6DpJK1eRon1JC2sm7BT5blFrQBeZN0N4vm/UvyNscFpJJjlVhtYatGLWn8npcsZdnvbejlck3MSJIK3UGg7I1692VXIR4et9m8BsTgtXLBtm6/GUR1zXx0qwMTFmM07ik5NE72I61gQ+aXmFnWfO7EpfPSWYfTMWt8z/VYqcj1Tt1sQse/QqA8RDcFGLRJzLBp5XtA+HEzEd7vaYTyzqO1hKKvLjfa9aD57qJzMfM+xWkDdM65p8dxTy1iKhPzY1qPi11Fw7omdie2vRSpya2S/9pAzX8g76rMQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(136003)(39860400002)(396003)(46966006)(36840700001)(40470700004)(186003)(1076003)(426003)(47076005)(2616005)(336012)(83380400001)(81166007)(356005)(86362001)(36860700001)(82740400003)(40460700003)(8676002)(4326008)(36756003)(40480700001)(70586007)(70206006)(6916009)(316002)(54906003)(82310400005)(5660300002)(8936002)(2906002)(41300700001)(478600001)(7696005)(26005)(6666004)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 02:52:11.1295 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 932871ae-550e-4de4-b5bc-08da87d723a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5815
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Hansen Dsouza <hansen.dsouza@amd.com>, Brian Chang <Brian.Chang@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
fw version check was for release branch.
for staging, it has a chance to enter wrong code path.

Reviewed-by: Hansen Dsouza <hansen.dsouza@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c  | 3 +++
 .../gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c  | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
index a788d160953b..ab70ebd8f223 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
@@ -104,6 +104,9 @@ static bool has_query_dp_alt(struct link_encoder *enc)
 {
 	struct dc_dmub_srv *dc_dmub_srv = enc->ctx->dmub_srv;
 
+	if (enc->ctx->dce_version >= DCN_VERSION_3_15)
+		return true;
+
 	/* Supports development firmware and firmware >= 4.0.11 */
 	return dc_dmub_srv &&
 	       !(dc_dmub_srv->dmub->fw_version >= DMUB_FW_VERSION(4, 0, 0) &&
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c
index b384f30395d3..e3351ddc566c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c
@@ -317,6 +317,7 @@ static void enc314_stream_encoder_dp_unblank(
 	/* switch DP encoder to CRTC data, but reset it the fifo first. It may happen
 	 * that it overflows during mode transition, and sometimes doesn't recover.
 	 */
+	REG_UPDATE(DIG_FIFO_CTRL0, DIG_FIFO_READ_START_LEVEL, 0x7);
 	REG_UPDATE(DP_STEER_FIFO, DP_STEER_FIFO_RESET, 1);
 	udelay(10);
 
-- 
2.25.1

