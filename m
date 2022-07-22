Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF861C43334
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jul 2022 20:42:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E25F8E766;
	Fri, 22 Jul 2022 20:42:45 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2074.outbound.protection.outlook.com [40.107.100.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC5BC8EB86
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 20:42:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXcQnpNX9NFxyG3cBUV7yKkOmyxmcakpeC0gHaAa3iMN4Ugd2bv4wBiyNP8XTOunOoMpD+g/idU8eduQODFi/bc5xMHsln2hz+jdngXKTi1ouiN73eOOYuzxnpZJA88dG1ejkgq/gd5aLKozJd5IfYCaJyNXoocHzjGel+LVdpCSL5ekFXFDekYjfBWforCivhuZk+WpwQ9aYM33EfzPyOWExpZSqN+YLYSDaeaXRXC4HBiSm7dyFuF9gDnklljbOOl7yDSSwNYkuQlVpjxPmnSxKr5MN8qkINKowPQUKbV2gp6FCLQPA2redYDU8EWnc7fLP4EkNYuu4QfthDkQbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dmhovNtU8J856tHwoGudJtaLyKr9DqRrlunx0F4kOHw=;
 b=CmVYJuwkl9ISsllgXEiO6z6PFMXrmy+k/OaOKY2oUwIb+nDVZ979hZ1PIESlUfL+74/ro0UijL7unfC9NbDbLBsIWkzWgftkSnLEkEL/OIRQjzG0qGBE2s0+1Ujh/ZRhrPc7T58QUn+fDlhKePX80ndeDodU8uCANTHiCd8UDy1K9PrhN74oFIaO0qKZmd9zg1/zTsRIG42bk9BYgrEQq2qGqLDr1LtdLVyP6kpfpXc4XbkIlvFh27F8SnFPt/RBzevd0hx3pfKSqjlxyCjG7QyRxf1Hglhc9BQCkMQyHYS6c4NhL/0az2Gg78EtPzj1HU8oD7O+pgsVw4gSfwAsAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmhovNtU8J856tHwoGudJtaLyKr9DqRrlunx0F4kOHw=;
 b=LXrPOBzjG0O6VjvaS1qGWCAqzI3D3ypO3xaFHPHAdFZI13AgsKnmjJqdshCkUTNVE5qYjhzGVFugOWNbd9QHV4A/geslBqYFpqdwh+6XsvSBH3ewA0Ao4kG2zf8/9H6lieoC4FnZqbdJ7GAS2wxHRMIf1KFWdpwEUuD4v4vFmTQ=
Received: from MW2PR2101CA0030.namprd21.prod.outlook.com (2603:10b6:302:1::43)
 by MWHPR12MB1344.namprd12.prod.outlook.com (2603:10b6:300:9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 20:42:38 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::b8) by MW2PR2101CA0030.outlook.office365.com
 (2603:10b6:302:1::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.6 via Frontend
 Transport; Fri, 22 Jul 2022 20:42:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Fri, 22 Jul 2022 20:42:37 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 22 Jul
 2022 15:42:33 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 23/31] drm/amd/display: Cache cursor when cursor exceeds 64x64
Date: Fri, 22 Jul 2022 14:31:29 -0600
Message-ID: <20220722203137.4043516-24-alex.hung@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220722203137.4043516-1-alex.hung@amd.com>
References: <20220722203137.4043516-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14b2c7eb-486a-4908-3b42-08da6c22b6f8
X-MS-TrafficTypeDiagnostic: MWHPR12MB1344:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VA1oke9Jw/1nyYCLfcNi4meHjPnByTw+uLPMyOxF+nkTmhjlqVmm356PPFUUIH7Z1E45jLA/0GTW8DTwdnm9x5a0gc4H/SqklPxpeRpzpkezFKFhYV0dADc0X7MQQ0yRAH1ViYOGv8boNiILjhfh4jRT1wTUTYlDwO51y9mhKXrdh0dfdHyuf5Twkt9tBrEA9bOLfPwKSURZL1Cu6kkKLB2shmTOFG3UK3p2r8vc47lz7mLnmVamT7lHl99wtnNdTsYix7o6BsahgPwaFGWoZ5WaoTAXeLGP40fRaxIXWeliJ9Y1E7ykofoj5Y/fa8PsCM/2eHsGA2V+Zwaoxu0MrkKIsWwzB0uTYt44B/yqihPocysXaKSkA3llgFkE96Jhg3bWke2NUTDKT/JAL9JNxzY+IOhgG7Um/OkJCptFtgdE7qozBdyIwXFmg3Tm5E6j2jedgs8udF/Vnk4h6TmA+QrQU58O+7RaxyilXmV6JdeLmTTwN8/r7T8pUbI88gNKRWp3u0A8fqe+yp3mVP6rSClVButGzzoh/Fq+4w2MhCr0+wbI/+ZyCBXfK0g6pUAtkAdbxiCm0onlj1Kef1ka7wSGL1CeAHPB1SW8IJhxCN2pN3Pj72OEnLwef1XSAq9V8p2zjTU0M0ir94iQetm7feXxD2v19qFXGjHVUJVqHTeBOyGX+daY3+0hyDST0zd0/AAZtYSAFg12JiTgj38r8yYgqxYJS5IifHoC7gOzjzEXrhgIwJHDX8Jwstj4h6t0tTVRSR6AdEq+IUWW5kXUHN2h+PDcj/MueFZqbzT3MXVCsWeMsit4QiwqFUrS+/OPJVZd2BSI3qGQePXZ1lZ0Uw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(136003)(376002)(346002)(40470700004)(46966006)(36840700001)(478600001)(5660300002)(86362001)(40480700001)(8936002)(47076005)(426003)(6666004)(2616005)(2906002)(1076003)(26005)(41300700001)(44832011)(16526019)(7696005)(186003)(336012)(40460700003)(36756003)(83380400001)(82310400005)(81166007)(70586007)(82740400003)(356005)(70206006)(36860700001)(54906003)(8676002)(6916009)(4326008)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 20:42:37.8880 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b2c7eb-486a-4908-3b42-08da6c22b6f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1344
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>,
 mark.broadworth@amd.com, Chris Park <chris.park@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, daniel.wheeler@amd.com,
 Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chris Park <chris.park@amd.com>

[Why]
When Static screen from MALL, the cursor needs to be
cached if cursor exceeds 64x64 size.

[How]
Program the bit that cache cursor in MALL when size
of the cursor exceeds 64x64.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chris Park <chris.park@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c  | 4 ++--
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.h  | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 9 +++++++--
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h       | 2 +-
 4 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c
index 3176b04a7740..6ec1c52535b9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c
@@ -47,13 +47,13 @@ void hubp32_update_force_pstate_disallow(struct hubp *hubp, bool pstate_disallow
 			DATA_UCLK_PSTATE_FORCE_VALUE, 0);
 }
 
-void hubp32_update_mall_sel(struct hubp *hubp, uint32_t mall_sel)
+void hubp32_update_mall_sel(struct hubp *hubp, uint32_t mall_sel, bool c_cursor)
 {
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
 
 	// Also cache cursor in MALL if using MALL for SS
 	REG_UPDATE_2(DCHUBP_MALL_CONFIG, USE_MALL_SEL, mall_sel,
-			USE_MALL_FOR_CURSOR, mall_sel == 2 ? 1 : 0);
+			USE_MALL_FOR_CURSOR, c_cursor);
 }
 
 void hubp32_prepare_subvp_buffering(struct hubp *hubp, bool enable)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.h
index c4315d50fbb0..56ef71151536 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.h
@@ -52,7 +52,7 @@
 
 void hubp32_update_force_pstate_disallow(struct hubp *hubp, bool pstate_disallow);
 
-void hubp32_update_mall_sel(struct hubp *hubp, uint32_t mall_sel);
+void hubp32_update_mall_sel(struct hubp *hubp, uint32_t mall_sel, bool c_cursor);
 
 void hubp32_prepare_subvp_buffering(struct hubp *hubp, bool enable);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index bf9ac9dfc7dd..1f845e9ac406 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -670,18 +670,23 @@ void dcn32_update_mall_sel(struct dc *dc, struct dc_state *context)
 {
 	int i;
 	unsigned int num_ways = dcn32_calculate_cab_allocation(dc, context);
+	bool cache_cursor = false;
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 		struct hubp *hubp = pipe->plane_res.hubp;
 
 		if (pipe->stream && pipe->plane_state && hubp && hubp->funcs->hubp_update_mall_sel) {
+			if (hubp->curs_attr.width * hubp->curs_attr.height * 4 > 16384)
+				cache_cursor = true;
+
 			if (pipe->stream->mall_stream_config.type == SUBVP_PHANTOM) {
-					hubp->funcs->hubp_update_mall_sel(hubp, 1);
+					hubp->funcs->hubp_update_mall_sel(hubp, 1, false);
 			} else {
 				hubp->funcs->hubp_update_mall_sel(hubp,
 					num_ways <= dc->caps.cache_num_ways &&
-					pipe->stream->link->psr_settings.psr_version == DC_PSR_VERSION_UNSUPPORTED ? 2 : 0);
+					pipe->stream->link->psr_settings.psr_version == DC_PSR_VERSION_UNSUPPORTED ? 2 : 0,
+							cache_cursor);
 			}
 		}
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
index 906818e792dd..44c4578193a3 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
@@ -198,7 +198,7 @@ struct hubp_funcs {
 	void (*hubp_soft_reset)(struct hubp *hubp, bool reset);
 
 	void (*hubp_update_force_pstate_disallow)(struct hubp *hubp, bool allow);
-	void (*hubp_update_mall_sel)(struct hubp *hubp, uint32_t mall_sel);
+	void (*hubp_update_mall_sel)(struct hubp *hubp, uint32_t mall_sel, bool c_cursor);
 	void (*hubp_prepare_subvp_buffering)(struct hubp *hubp, bool enable);
 
 	void (*hubp_set_flip_int)(struct hubp *hubp);
-- 
2.37.1

