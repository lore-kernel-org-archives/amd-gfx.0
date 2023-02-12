Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD107C05027
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Feb 2023 17:01:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3D2D10E2F2;
	Sun, 12 Feb 2023 17:00:56 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F44710E302
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Feb 2023 17:00:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXEXKUGzVSOaBkhb0GHQ3Gr9ce12bAWGcOjaoQ0gCKIiw+v0VOt3FUMwachROExolIDHSV6FIYM3T7nYuHr25N0I+YNi5vLKM15QkeEULgY6a0re+Egxb7UxRqeUoKHb2vVmc947v1+k1q0o70+2e24XhFMtROPm5/y7IdltWC2PpU6NnxjnvTRYKsIVuRnufxULk+lqZcIf5+BbyqbV06FFDncC6K27mQrslBIIm69aI5SIV7j2gfdX8G3LUAEYK6mkQ9yE1L71FgUNkMZ8hMyVlY6TUs3ZMMglNnp8lsTf0xky4wn5l9ivJcL1cpR3MfDKGynwDWmf/6aD/FOmnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCIfcPCh8/Wcvra+X5EriKwf0IY3CExwawvmU4spjNU=;
 b=l8HqsmIukwYzkmZ0oFBHGaTyPYwOGwC3wkuq71lKF+NJHnYQl291QTeFPvZK0AaNHbkGFAP0I+V54SE6eYGK6c+TEgRPKZ6wPyGVI9E4c/y50oPsyaxehKYC+gLggVOW0KanOHcHlKdHPEvmxZZahkVx/p7dNJlylS+Cu3FMd6g5s6tJiD/OQPp/IvduRQDDs7SyVZm2TLsYPFmebe7q26qFr8jbcwLNzuV+y/vAP6gPnCTlHYWwWKI0RRVU2LG3b/BM46Cp8I6xqE71FH6c/QVgZ+yP1hmelVsaw8gqdwMTxkjoGI1EvNt2U8ZM+DJ+0fkhs05hirVg/baMQLFUtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCIfcPCh8/Wcvra+X5EriKwf0IY3CExwawvmU4spjNU=;
 b=b4nX/CIjDde0XOFgfV3s0BDYGRQGvqnQgkwfHn3tXyT4JeACA8/Ha1srB9jy9RuPtG5UTs8bEpS3ihkTiyGGfzUrEVnfHXoeWTTTUhD+ALRJYnx0CsXCx7dmiNKO+pktbinB5iBV42XoVX1EBpp/v+ZVj1bIg2cM+X13sVmbiNc=
Received: from DS7PR05CA0078.namprd05.prod.outlook.com (2603:10b6:8:57::24) by
 SA0PR12MB4461.namprd12.prod.outlook.com (2603:10b6:806:9c::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.23; Sun, 12 Feb 2023 17:00:49 +0000
Received: from DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::96) by DS7PR05CA0078.outlook.office365.com
 (2603:10b6:8:57::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.9 via Frontend
 Transport; Sun, 12 Feb 2023 17:00:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT082.mail.protection.outlook.com (10.13.173.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.23 via Frontend Transport; Sun, 12 Feb 2023 17:00:48 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 12 Feb
 2023 11:00:45 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 12 Feb
 2023 11:00:44 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/22] drm/amd/display: Fix FreeSync active bit issue
Date: Sun, 12 Feb 2023 11:59:48 -0500
Message-ID: <20230212165955.1993601-16-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230212165955.1993601-1-qingqing.zhuo@amd.com>
References: <20230212165955.1993601-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB06.amd.com
 (10.181.40.147)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT082:EE_|SA0PR12MB4461:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ca2fb8b-76eb-437d-f7ed-08db0d1ab0bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I/xQ+qR14hkebUo1gfRnEs96p5yTQ9Nyyg0Xz8nfIFRdUmEHmOnlxv9hfAkXAMGAUfXFVimqA2V8Kab5er1Gkhe12kHqv6evm92Lruz0tSmECI90TcpDxt3Im5WCfHf/kciM4oY6vufGRchihXEXknSAnlmS49g23IdBKVmcXJfQ77eWl+xZ/G/8zoxGLChm7xMUwflrj0t9Yb8g63U2e2lpw4vjAWlwino517N81V1nu3h8BxYEMJf8pz/EhB6qYkEZ9/nYzeLcedXR3KHpNiopqd7h5vUl62x6mhhnlH8MHeOBIv1Dggz+Y2OlK3wh+3Gck4DvNpQVAFRCpBVIL/jFII38Dn283bU3w0Z68TXm49hTXJ/1KheXxnEmPvSy7Vw46eyXImom1TQbTpWkafR8yyFW/nHVFQrm4vH/wudrmqz8Q/8RDp+jLgMTp1ey9OTbKQc4VEmBUSsvCC4kk/mq46MtM8XQecwDQG3lsRkxiRbF26hwIB4ll2JWEeo1jzbroL6r0fVzpBh5MDCZ+wenbOdNCER7LFzNOfBmmJLkPhn1RgQD4vaRhl+sXQwQGJ5OIHmz6tN5MWKMK4KcKSn1tSwvHgGPKfoSwd87MTyrgrlb8YXLUMr5UPPccqRWfFaI75qUzT/TbVhGaY31xwBcPcSdKcTi5Fq4pwmk5dIcsd0kDI28r9i9EFMENAdAqEPsX1uR4qP6XMyqGII2hn5u+1GA1xmg7n8mJVrxs2w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(83380400001)(5660300002)(41300700001)(8936002)(44832011)(47076005)(426003)(81166007)(36860700001)(82740400003)(82310400005)(86362001)(36756003)(40480700001)(356005)(40460700003)(2906002)(316002)(54906003)(1076003)(26005)(16526019)(186003)(4326008)(6916009)(336012)(478600001)(2616005)(8676002)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2023 17:00:48.7826 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ca2fb8b-76eb-437d-f7ed-08db0d1ab0bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4461
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
Cc: stylon.wang@amd.com, Felipe Clark <felipe.clark@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 "Leo \(Hanghong\) Ma" <hanghong.ma@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Leo (Hanghong) Ma" <hanghong.ma@amd.com>

[Why]
The FreeSync active bit unconditionally set in HDMI VSIF.

[How]
Set this bit to true when FAMS is enable on desktop.

Reviewed-by: Felipe Clark <felipe.clark@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Leo (Hanghong) Ma <hanghong.ma@amd.com>
---
 .../gpu/drm/amd/display/modules/freesync/freesync.c  | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index 315da61ee897..2be45b314922 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -955,20 +955,26 @@ void mod_freesync_build_vrr_infopacket(struct mod_freesync *mod_freesync,
 	 * Check if Freesync is supported. Return if false. If true,
 	 * set the corresponding bit in the info packet
 	 */
+	bool freesync_on_desktop;
+	bool fams_enable;
+
+	fams_enable = stream->ctx->dc->current_state->bw_ctx.bw.dcn.clk.fw_based_mclk_switching;
+	freesync_on_desktop = stream->freesync_on_desktop && fams_enable;
+
 	if (!vrr->send_info_frame)
 		return;
 
 	switch (packet_type) {
 	case PACKET_TYPE_FS_V3:
-		build_vrr_infopacket_v3(stream->signal, vrr, app_tf, infopacket, stream->freesync_on_desktop);
+		build_vrr_infopacket_v3(stream->signal, vrr, app_tf, infopacket, freesync_on_desktop);
 		break;
 	case PACKET_TYPE_FS_V2:
-		build_vrr_infopacket_v2(stream->signal, vrr, app_tf, infopacket, stream->freesync_on_desktop);
+		build_vrr_infopacket_v2(stream->signal, vrr, app_tf, infopacket, freesync_on_desktop);
 		break;
 	case PACKET_TYPE_VRR:
 	case PACKET_TYPE_FS_V1:
 	default:
-		build_vrr_infopacket_v1(stream->signal, vrr, infopacket, stream->freesync_on_desktop);
+		build_vrr_infopacket_v1(stream->signal, vrr, infopacket, freesync_on_desktop);
 	}
 
 	if (true == pack_sdp_v1_3 &&
-- 
2.25.1

