Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43728C433EF
	for <amd-gfx@archiver.kernel.org>; Sun, 23 Jan 2022 18:21:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F7D610E90C;
	Sun, 23 Jan 2022 18:21:27 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECE2310E857
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Jan 2022 18:21:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hco23QEjkpbFPLejpZPgotQQ0QR0fvEhxCPEujMrOSTc/P9/pLfZ/2V6dol1qu8caa6mHqw5g7pFIfamyPTnSquhlH30jcnRgzYLWm9JknOhSAmmq/+GkC5cL+uLjlv8/3/19hGTnYX8U2PjFAXqYS4YWh+p33y1tgW5kKiVc12l1YlKP8KlqISZU1K58FqB3MgnhwB+3+AR1h69kdJPNhHJNgD0EokiqGkn29es/CY+nWI14qlEueNlYQKwgkZTTpf9Aqs6eLgj7x8GA3RTLf46oo1+SAWCWllaK5oZ21Cky4X5uN5/NGflXa4BYWusBwQFmLHYvEvIyD54zJgpsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WbjoR6iOa+z8Jmfz7uFbD8J2I4cSroZreOGxh+z0yjM=;
 b=dhna0A0h0qWEXcTa16LrN49WzL8DHI4XdM3I9YpB5c0tJqXPiW1oQD8PFtKhOEzvdbgf1yF+Wug01EBWgKDA4pnC7Dua6mEOQrLupHJfKQacdqtB/FWp3gf1SJpnIvcJ59vQKiNSzxr5xOHgEAGMWhdd87Tww5MYP7vwcRhViPPdZnrQp6Mev+Pz0ChDq5vnT4Es2DAValfn35/kDZruGZr+6yGoamGenx9hD6oSnneKFsJ54HQPV+skpD9e14H7L33rG01QLYQxYZouqbODTjIAnsqa0lTbut2yum31/NuiYq5ggu8yBKffQDGpJUSQ1nSniwpn0FW2bPsBL8luOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbjoR6iOa+z8Jmfz7uFbD8J2I4cSroZreOGxh+z0yjM=;
 b=EPLByZoEOPt+cFecmLsPJs1RUYU3AHNYYmCHqnJSCRy3HlzuVnd1SgbnrmmQuGX2UcMOnz9sSjJeGqAavcUIhQVSRlfoTpGfbFODAvo1t57QXFh10T3xms2RVJTl1V9uRISougdvuKNS5dmua6zfr2IyQKLnL8+Il4x4pc3xbXE=
Received: from BN9PR03CA0966.namprd03.prod.outlook.com (2603:10b6:408:109::11)
 by DM6PR12MB2795.namprd12.prod.outlook.com (2603:10b6:5:41::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Sun, 23 Jan
 2022 18:21:16 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::85) by BN9PR03CA0966.outlook.office365.com
 (2603:10b6:408:109::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10 via Frontend
 Transport; Sun, 23 Jan 2022 18:21:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Sun, 23 Jan 2022 18:21:15 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 23 Jan
 2022 12:21:13 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/24] drm/amd/display: allow set dp drive setting when stream
 is not present
Date: Sun, 23 Jan 2022 13:20:17 -0500
Message-ID: <20220123182021.4154032-21-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220123182021.4154032-1-Rodrigo.Siqueira@amd.com>
References: <20220123182021.4154032-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9859bfb1-27ce-4551-b56b-08d9de9d24db
X-MS-TrafficTypeDiagnostic: DM6PR12MB2795:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB279523D7F220654142F4F8B2985D9@DM6PR12MB2795.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cpf+84neuUMXarai+U59fWGbgke53Uq9XIda8ZokOYHBNHlY9Fc7j1H3hS9ABS1eUqe0qml1gneHLFc0MgcTH1cvxKTRroo2nnU17xr8MYBu+khvfMpI5k0teB5U0EeoNwjft4o9HabXIWRDzl92q2upmRyjqdjSvT+1kOgJSxRC4ENifxec70thQ5cyipIAPMOM0Hy5wY3uamnuEQ9YDbjwfdjUGw3VqDFq8aaUrEZqwEvmzWB/SK2zt3kyc/X8XiAnlJCrshpKHWMqRhn5D9okA+2bAY6602ASepf6X90jUtGfw99qDuZP93n/H4ORb58yX+UTDRNDRBz+EcpsDJafyqgX65MtkE/GJXbifxWnCu4qjY1KAiegG0X4Ha0hk04WzDSJN4MkdYAQHbNjGS1/mkPyFHeu0EThb5JNGurAQf8juRIbHbx11aTSXUuH+KJrpolLmuQNzbl89uhoe+HdNQthWxbjgoByP+HtxCDhsOzJJRIpKpqqALGoyxzJg/l1zWTMw+CuVOCxDejx3fENgYdLG4ZR0YtnZYQmKr71NM8wKnVwGLpGnRrhB48+3ezLF470zV8L0YX9lE9321RqWf30VRXdZASOXzk2HYVhPElvwQwOAZ9xlGcHuzR4hQ2dBNv0jB/FK6sOiWYbG4J7JpDpkDcYgfdsLidigDKnMlLz4gh3fGS0V82EYCYdt3V2X55GilFtIFsBXdVEztjELKUcbyHsq5yF/8hH1QesdHuHxyqNsyg9zxSYxx1/xom4p7MvUv2LecjJHBGYfGBt3lGKfv/pMODk7oO2sHA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700004)(54906003)(1076003)(6916009)(5660300002)(26005)(316002)(2616005)(36860700001)(70206006)(86362001)(508600001)(70586007)(40460700003)(186003)(36756003)(83380400001)(336012)(47076005)(426003)(356005)(81166007)(8936002)(2906002)(8676002)(4326008)(16526019)(82310400004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2022 18:21:15.8933 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9859bfb1-27ce-4551-b56b-08d9de9d24db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2795
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
 Wenjing Liu <wenjing.liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Wayne Lin <Wayne.Lin@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
There is a change previously to disallow DM to set dp drive setings when
stream is not present. The logic might not work well with DP PHY
complaince scenario with a PHY test fixture attachment. We need to make
the method allow DP link drive settings changes even without stream
attached to it.

[how]
revert back to previous code in set drive setting function then add an
empty link_resource structure, then assign link resource based on
current link resource if link resource is allocated to the current pipe.

Reviewed-by: Wayne Lin <Wayne.Lin@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 30 ++++++++-----------
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  3 +-
 2 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index d0aba8d7b1c3..6be2ae743cc5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -4454,22 +4454,17 @@ void dc_link_set_drive_settings(struct dc *dc,
 {
 
 	int i;
-	struct pipe_ctx *pipe = NULL;
-	const struct link_resource *link_res;
+	struct link_resource link_res;
 
-	link_res = dc_link_get_cur_link_res(link);
+	for (i = 0; i < dc->link_count; i++)
+		if (dc->links[i] == link)
+			break;
 
-	for (i = 0; i < MAX_PIPES; i++) {
-		pipe = &dc->current_state->res_ctx.pipe_ctx[i];
-		if (pipe->stream && pipe->stream->link) {
-			if (pipe->stream->link == link)
-				break;
-		}
-	}
-	if (pipe && link_res)
-		dc_link_dp_set_drive_settings(pipe->stream->link, link_res, lt_settings);
-	else
+	if (i >= dc->link_count)
 		ASSERT_CRITICAL(false);
+
+	dc_link_get_cur_link_res(link, &link_res);
+	dc_link_dp_set_drive_settings(dc->links[i], &link_res, lt_settings);
 }
 
 void dc_link_set_preferred_link_settings(struct dc *dc,
@@ -4711,23 +4706,24 @@ uint32_t dc_bandwidth_in_kbps_from_timing(
 
 }
 
-const struct link_resource *dc_link_get_cur_link_res(const struct dc_link *link)
+void dc_link_get_cur_link_res(const struct dc_link *link,
+		struct link_resource *link_res)
 {
 	int i;
 	struct pipe_ctx *pipe = NULL;
-	const struct link_resource *link_res = NULL;
+
+	memset(link_res, 0, sizeof(*link_res));
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe = &link->dc->current_state->res_ctx.pipe_ctx[i];
 		if (pipe->stream && pipe->stream->link && pipe->top_pipe == NULL) {
 			if (pipe->stream->link == link) {
-				link_res = &pipe->link_res;
+				*link_res = pipe->link_res;
 				break;
 			}
 		}
 	}
 
-	return link_res;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index b1c79b3f26aa..6c02244e7fe7 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -459,7 +459,8 @@ bool dc_link_should_enable_fec(const struct dc_link *link);
 uint32_t dc_link_bw_kbps_from_raw_frl_link_rate_data(uint8_t bw);
 enum dp_link_encoding dc_link_dp_mst_decide_link_encoding_format(const struct dc_link *link);
 
-const struct link_resource *dc_link_get_cur_link_res(const struct dc_link *link);
+void dc_link_get_cur_link_res(const struct dc_link *link,
+		struct link_resource *link_res);
 /* take a snapshot of current link resource allocation state */
 void dc_get_cur_link_res_map(const struct dc *dc, uint32_t *map);
 /* restore link resource allocation state from a snapshot */
-- 
2.25.1

