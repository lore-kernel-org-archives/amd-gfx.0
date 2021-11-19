Return-Path: <SRS0=d+6m=QG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D56C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 19:44:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F17E261283
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 19:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F17E261283
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 702646E437;
	Fri, 19 Nov 2021 19:44:07 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2041.outbound.protection.outlook.com [40.107.96.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF6BC6E437
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Nov 2021 19:44:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FsToCkz4HBuLVgwaI/zR1aXG2wthLwglVprJGN04XysrSgjo35sX9CEzA3aEXmiG+96YGap1A+/Rzc7slTpKsPZ1bnV1vDWnAlXCON9HX8IDu/Hp+dgzfvpCv0cpPWCu9D7cwSYVdbZkSbEVNl83Q5OyLQ/G/Snq/SYK50w3308m1SQuM2u8+8NgC4Wl4AKGsrvKxOHL7O65vFZB7Yw1lE7gUtCDVAMJV5h5uHUjEuwkySSAlI6p7385mayHd/rH9JPdpO2eS5zZLpOptPr/l4cJSe5Wx4Xq47jJaWpj4nnDcAV8wuthW+hl+ZAytk4bSXcF5cN05F5mfnHfq7OEXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQVki30rhVebeRDiUh8ldiLS/7RFzZKRvIOC7hRzrHQ=;
 b=InD4y+c4x6j1kd1oomfd/zRaQ4yeN+0mCiSynC801GEItk5ofHPVCyyuB2XZ65KPBSNsPskq83YpukkPsfYIvRUX3uVkmcP91cHj8xMghlRSYRuW5bh0OqpddvmS+aneEm/i4ksEBT7psdCybwzpUtQWvhoW7fZ7TijKL8rapnR0kaSP7lfMQWplACs8J7lb/Nk/ei26dIqtDIkyCTsAF1RssMMsXW+bQNKmUmT2ROG5YlZ3o6aDKDb1mGB31H2tlvj/535fKfUGc3YZHzEJA6XD4Z6VyxOXPmI2pS1lpgvqofgHCR5GOm6x3rjmH6v1wlKkS1N/UDkA/A8gYGKU0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQVki30rhVebeRDiUh8ldiLS/7RFzZKRvIOC7hRzrHQ=;
 b=RCWPkJ1BUEB/c/MgvtRL6QyTfckUxLFzJtIIHkmUfaUXyQTQPPzI7dRaKti68a9G1cycQZeNfx5IobNor6jkuMHn+lSlZCcr2EVTT6Xq0fpuhusgtr0JuRqXxhFpLw5PnYEp6Ro/Gzx+5X1NlwSBEJp0aYK1X7H/+UVx4eNzBqk=
Received: from MW4PR03CA0293.namprd03.prod.outlook.com (2603:10b6:303:b5::28)
 by BL0PR12MB4929.namprd12.prod.outlook.com (2603:10b6:208:1c4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 19 Nov
 2021 19:44:03 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::6) by MW4PR03CA0293.outlook.office365.com
 (2603:10b6:303:b5::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.20 via Frontend
 Transport; Fri, 19 Nov 2021 19:44:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 19:44:00 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 13:43:57 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/16] drm/amd/display: retain/release at proper places in
 link_enc assignment
Date: Fri, 19 Nov 2021 14:43:32 -0500
Message-ID: <20211119194339.97573-10-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211119194339.97573-1-qingqing.zhuo@amd.com>
References: <20211119194339.97573-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ab5084e-cd8a-4487-2db1-08d9ab94ef66
X-MS-TrafficTypeDiagnostic: BL0PR12MB4929:
X-Microsoft-Antispam-PRVS: <BL0PR12MB492965CD1BEF1A037C1DB0BCFB9C9@BL0PR12MB4929.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: meqneU2pYSznInWUjy3qbcRv00pw8YXdFKjnqa5c4z1XxEJhTMEweP7YFfCPHpOnv773vsYsggVGpIP5jAB2wq5c09MUtCBkPFTMp8/QeFHSwKEZLwojPHajgEuo4gukjewrUSW0/hk2UiFRfpkB9czYxEtAjdmcXm/6MUCID4y4ZKR0aWl/6MKXtPNhAIVnI1sns6DxR8MEO37XXTQe7r0veqkKal1uJObq8E7t84QgBsye/s66by+5PQM47BGBdqmuSsz+78gs1ygaFr8Zasqrf1WPbf3yJOddolCnqx06BbFOHO9/WAglZlOAz2PrCBjy3+MPhHP8epiwNNAHWy4qGBi05Jpg6EzVRQZkjUYTwzuGGbXGEXynE1+fwT9Hy73TE1FtXfTanqaxKnD3QdZwQsyFNLkJfMG/NfySKbn5ebwgv7g0tGDSVNXw6f1vyeaaLekyPw+Fen+Jn/AJ5YWq5cRKiDWUMo26D55tug0r9pIYLKhCSmmibmrmekZqAXJvp7gI6Y+QMYDNMBZ3AqVR31c2ZmscofcapyyGqze/jU103N5torfOayJMH6rtW26uAuCt3rW8fevev/g+LpUBZEuQ99LzxkTyG+EM108CZXG8vvZ6O4qEarcKYVBFUYTQI2SokLzFwyFwO+EFzl88/ndLPEAd3LZGtUW0IQUZqZc14WDgfdsKqxkviJeaiqWr4wAEetrGwdRJApFpynxUFbsXiicQ/15EqP1L4qQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(2906002)(54906003)(81166007)(70206006)(316002)(8936002)(356005)(508600001)(70586007)(16526019)(186003)(83380400001)(47076005)(36756003)(36860700001)(44832011)(4326008)(8676002)(26005)(86362001)(336012)(426003)(82310400003)(1076003)(6916009)(2616005)(5660300002)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 19:44:00.8017 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab5084e-cd8a-4487-2db1-08d9ab94ef66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4929
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>, solomon.chiu@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, mikita.lipski@amd.com,
 Bhawanpreet.Lakha@amd.com, Sung Joon Kim <sungkim@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Joon Kim <sungkim@amd.com>

[why]
Need to keep track of number of
references to stream pointer.

[how]
Call stream retain/release whenever
necessary in link_enc table assignment
sequence.

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Sung Joon Kim <sungkim@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c              | 4 ++++
 drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c | 6 +++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index dd4ea98749b7..0bf49a1df8be 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -808,6 +808,10 @@ void dc_stream_set_static_screen_params(struct dc *dc,
 
 static void dc_destruct(struct dc *dc)
 {
+	// reset link encoder assignment table on destruct
+	if (dc->res_pool->funcs->link_encs_assign)
+		link_enc_cfg_init(dc, dc->current_state);
+
 	if (dc->current_state) {
 		dc_release_state(dc->current_state);
 		dc->current_state = NULL;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
index 8b319992c71d..a55944da8d53 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
@@ -151,6 +151,7 @@ static void add_link_enc_assignment(
 						.ep_type = stream->link->ep_type},
 					.eng_id = eng_id,
 					.stream = stream};
+				dc_stream_retain(stream);
 				state->res_ctx.link_enc_cfg_ctx.link_enc_avail[eng_idx] = ENGINE_ID_UNKNOWN;
 				stream->link_enc = stream->ctx->dc->res_pool->link_encoders[eng_idx];
 				break;
@@ -247,7 +248,10 @@ static void clear_enc_assignments(const struct dc *dc, struct dc_state *state)
 	for (i = 0; i < MAX_PIPES; i++) {
 		state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i].valid = false;
 		state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i].eng_id = ENGINE_ID_UNKNOWN;
-		state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i].stream = NULL;
+		if (state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i].stream != NULL) {
+			dc_stream_release(state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i].stream);
+			state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i].stream = NULL;
+		}
 	}
 
 	for (i = 0; i < dc->res_pool->res_cap->num_dig_link_enc; i++) {
-- 
2.25.1

