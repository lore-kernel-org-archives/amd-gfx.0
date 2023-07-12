Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC2EEB64DD
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jul 2023 17:14:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63F8610E5C2;
	Wed, 12 Jul 2023 17:14:52 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C20010E5C0
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jul 2023 17:14:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZuPwQywE03aoDo+CLlLZTTmxGpBQsUIBSFwhsVhEaZpDCipyF6ByKC/kqJo+PqwJZd/wpcPXsEMEokT9BSkzzdy+W4HSLLgMrp1wVRU7N9T9F3gAoH7cUQuw9Z2P2k23ap5v/8+551l9D8hXxbEEcEC8wRNpF6I+h8+LysRfLT5fUU/H4CA4X37xLfNtjeTscAotY+w5jE4eZ5k9Y7CcJAlXx52yCIaMGwrctaioXFPZK51HslBhfDi5MGxOEyn5dcAvumXeJv4vF4KhRHRELqJ4tN0eFxuDk/yUbzc2Vsd8BWEEt6dXnFT5ytBTp/UZXxjiYN2B4NEAa+e4cuYGyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XuO3aivTvWNOOs2ClqrC/U7W/6S0kEIiLjiAqiqIC2k=;
 b=Uq1e1xI9pCfqwwZ9xFnVq7LwaP84tUXTFLgp7pLdXhkpvfFBHaFvBKXtkEImI3+QcXq+wsJr2J/X+mHY9kSG7Lu85oFdv3L9TduSAj4AfQudTAOqxM8zrdQp8NXSG1CjXhq4CKj9GXUFvcfvPIXQxsN2fG6LrFhJ9z6Q8r4rkycnUU8mkB/121k9Ss0DmTw/YpsbUop8Z9BxRHhz4onl0Oii1l+qydXX+DsJeTAu9JvY9UWtPuLOHfCy4VYNi4qLJVAASmjbNaeG3gFE4XfJq3qor7ZhuDuPnUMc0eDUUkPMKyyd8mjjXQaMWHXpM8Mxj1yPu4BWKYJxMDP7l+o5AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XuO3aivTvWNOOs2ClqrC/U7W/6S0kEIiLjiAqiqIC2k=;
 b=zRZa/UUc79PDFZmRDTNV+g3/3kPRE3kmLLAhUi62gQajRnJB0dPuNMN0stNDtGJ0OBEBZiiUONRF62YfpiqOMRtYmBiFvD1iXottFAH9aJ2mGk3CQ0O6BZMZuvrmzODSOpAS30Rv2ywKKycVlT73j70q3oBRGaD805R7DrDDJmg=
Received: from BN0PR04CA0023.namprd04.prod.outlook.com (2603:10b6:408:ee::28)
 by IA1PR12MB6388.namprd12.prod.outlook.com (2603:10b6:208:388::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Wed, 12 Jul
 2023 17:14:47 +0000
Received: from BN8NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::32) by BN0PR04CA0023.outlook.office365.com
 (2603:10b6:408:ee::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Wed, 12 Jul 2023 17:14:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT091.mail.protection.outlook.com (10.13.176.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 17:14:47 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 12:14:46 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 12 Jul 2023 12:14:43 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 32/33] drm/amd/display: Update SW cursor fallback for subvp
 high refresh
Date: Thu, 13 Jul 2023 01:11:36 +0800
Message-ID: <20230712171137.3398344-33-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
References: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT091:EE_|IA1PR12MB6388:EE_
X-MS-Office365-Filtering-Correlation-Id: 385f24bd-a7e1-4cde-fabb-08db82fb7e72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bRyC3SJaSDOzG1ezhMQR2Xb1rZSyjcqVqEsIp03teF1Lgv1pZEwH9nTTaZnSZ2PjeNHVjRk/S31XrUL0Nk08Uab8slB0TQvF19ZTIKRSssfFqRYQgZpW+NMgd+PN8fm7RYZVVCt2yYBqQZbx2pD/XCgeYzqD9XIUPwEXAcxZJ5gS0RXUjdKhnsoNhU51jLd1YsuMLNk5xP/OpghQUllZmn0PRjkHh+1WWNn3EDqMczqIGD669HzxOJWUzOQch7FUSGSXZgH+6x+2DCt6v57pycdbG8sx9DuR3M+b4hxcdHylFSNDjmoHNLk9wmFpRA/Liz3q3xnKED+0REDMswMBfsTUZJvitw7GfjalQi0/OSYYCG2WkyAVrNVwv/pssbhyxicHdEWyLMvQSw0t/RNRaPfA92Uq3pAdvpOSqPLkCBxiqVIaFE14d0V/rw8TmtBZ5hsWx0S8nTH83PscDm7QzR7FzdRfCNJQu74QMiB2LJt6sNSGx16ppmooXMitDxjgCDtDDwjNEsV58wP1p5+ce6Dwe/Gy8L4cvMYt68qaPHZRMon/w9KRwdCoEIfa1cogSbEjh9hVWfSf08m+VR8rxxwZtMrFm/xbom3dfj3znpBFzDcZI4j/qE4vEfNx3nG1JpCeZzYq/lZbdW8zGGEaePeWdDuB2h7VKph9fgw6cEazh7vqCpyO26mDwP1pvsqI2hooTvVk6PEOhQvMXWwD75qXSpj71SFrqJ6Zw5zggXSwVPt0oYxonQ9A1iCwYEx4GKu0Qs2r2DilR7g5c8selw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199021)(40470700004)(36840700001)(46966006)(478600001)(54906003)(7696005)(6666004)(1076003)(26005)(426003)(186003)(36756003)(82310400005)(2906002)(70206006)(4326008)(70586007)(5660300002)(6916009)(8936002)(316002)(41300700001)(356005)(8676002)(82740400003)(81166007)(86362001)(40460700003)(36860700001)(83380400001)(336012)(47076005)(2616005)(40480700001)(15650500001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 17:14:47.2611 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 385f24bd-a7e1-4cde-fabb-08db82fb7e72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6388
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
Cc: stylon.wang@amd.com, Alan Liu <haoping.liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Samson Tam <samson.tam@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
Since SubVP high refresh is now enabled, we must
fallback to SW cursor under if we're in a SubVP
high refresh config

Reviewed-by: Samson Tam <samson.tam@amd.com>
Acked-by: Alan Liu <haoping.liu@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_stream.c   | 35 ++++++++++++++++---
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 6e11d2b701f8..ea3d4b328e8e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -306,6 +306,32 @@ bool dc_optimize_timing_for_fsft(
 }
 #endif
 
+static bool is_subvp_high_refresh_candidate(struct dc_stream_state *stream)
+{
+	uint32_t refresh_rate;
+	struct dc *dc = stream->ctx->dc;
+
+	refresh_rate = (stream->timing.pix_clk_100hz * (uint64_t)100 +
+		stream->timing.v_total * stream->timing.h_total - (uint64_t)1);
+	refresh_rate = div_u64(refresh_rate, stream->timing.v_total);
+	refresh_rate = div_u64(refresh_rate, stream->timing.h_total);
+
+	/* If there's any stream that fits the SubVP high refresh criteria,
+	 * we must return true. This is because cursor updates are asynchronous
+	 * with full updates, so we could transition into a SubVP config and
+	 * remain in HW cursor mode if there's no cursor update which will
+	 * then cause corruption.
+	 */
+	if ((refresh_rate >= 120 && refresh_rate <= 165 &&
+			stream->timing.v_addressable >= 1440 &&
+			stream->timing.v_addressable <= 2160) &&
+			(dc->current_state->stream_count > 1 ||
+			(dc->current_state->stream_count == 1 && !stream->allow_freesync)))
+		return true;
+
+	return false;
+}
+
 /*
  * dc_stream_set_cursor_attributes() - Update cursor attributes and set cursor surface address
  */
@@ -334,12 +360,13 @@ bool dc_stream_set_cursor_attributes(
 
 	/* SubVP is not compatible with HW cursor larger than 64 x 64 x 4.
 	 * Therefore, if cursor is greater than 64 x 64 x 4, fallback to SW cursor in the following case:
-	 * 1. For single display cases, if resolution is >= 5K and refresh rate < 120hz
-	 * 2. For multi display cases, if resolution is >= 4K and refresh rate < 120hz
-	 *
-	 * [< 120hz is a requirement for SubVP configs]
+	 * 1. If the config is a candidate for SubVP high refresh (both single an dual display configs)
+	 * 2. If not subvp high refresh, for single display cases, if resolution is >= 5K and refresh rate < 120hz
+	 * 3. If not subvp high refresh, for multi display cases, if resolution is >= 4K and refresh rate < 120hz
 	 */
 	if (dc->debug.allow_sw_cursor_fallback && attributes->height * attributes->width * 4 > 16384) {
+		if (!dc->debug.disable_subvp_high_refresh && is_subvp_high_refresh_candidate(stream))
+			return false;
 		if (dc->current_state->stream_count == 1 && stream->timing.v_addressable >= 2880 &&
 				((stream->timing.pix_clk_100hz * 100) / stream->timing.v_total / stream->timing.h_total) < 120)
 			return false;
-- 
2.34.1

