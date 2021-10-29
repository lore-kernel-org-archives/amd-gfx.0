Return-Path: <SRS0=vl2N=PR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F5AC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 15:15:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D20B61165
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 15:15:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8D20B61165
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E94046E147;
	Fri, 29 Oct 2021 15:15:25 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50AD46E135
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Oct 2021 15:15:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNfLYzKAjEBu4IsqX8Ti+cjr87HAVM26B8s5dRFu6uMwniX2E/H/EuAxk/iGsLSg4MGkcZEO2y88YyoAfg6t1aYhhss/9lSaFP7uAX/ILr/8FId9iiyrb9RzBkRSv8EcfomV80I+1NimRcvEoCWStSm5aSyufiAgnSU0mcFPz10qkuG/MZetvJnpm6fm8Js80Kf/N9e/BfZfBnJg5OafrQcoDMugTYapuGZF9xd8pb82PMtTsqZtaotos59agENcAjF/T/PFCqQgqCU7i4WOxssswIeeL+u5KqvDkav8RiAw9QmHjjHNoiFOVJ9uds0Jf06al3YuFD+QwX6BKhrPaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fiBtXxojrRKmkP48pdKag3iWBCIbx4VR5LgC61h9ewU=;
 b=GrC7exoNbaNZf2WK1FBszb31pUigGA57pDsPYtXAf3WWoH14avq+f32yM9BTh2at2Qy7210x1YqDf06JMNZD7mbWA6SPLK7ix1wH2/+8jtJJSkarObYU3jAm3aDxSIdBCX8WFRVbTjonW7fEnJhlfhKn5I0CSzgW79DDou6DyWe4bqvSSZrpobMN3EUTFuIas7kLca1fjhqMjuk8Gzo0ppuccuccE9l3oPebpJXtElC4YZ/JOOWZiUCpFQZuSccBdJ4mRJIJjuS1P/OyixIKfhkChoTdsltbsia08PoaKyEmNR4tL+GO0/EuV8p2LkQv1Rt+CWJGT0suJ0UVHrzPQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fiBtXxojrRKmkP48pdKag3iWBCIbx4VR5LgC61h9ewU=;
 b=D65D0MjPnKrTq9iTxNcvX7EuYKSDB+x58wwFHH5j3jyD80EtJ+MxCLZNHtXXqdUqlNI9UNniXOsweJMrQGuUKmtmnixbF1cTcniFkt1mn+wS1NV8wmzq391r+wWHjC5cwZcgP3XAQXrBtTcTRoUgzfyLY9o2PduBhYxgQnGc4Wg=
Received: from BN9PR03CA0317.namprd03.prod.outlook.com (2603:10b6:408:112::22)
 by CH2PR12MB4135.namprd12.prod.outlook.com (2603:10b6:610:7c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13; Fri, 29 Oct
 2021 15:15:17 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::fd) by BN9PR03CA0317.outlook.office365.com
 (2603:10b6:408:112::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Fri, 29 Oct 2021 15:15:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 15:15:17 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 10:15:16 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 10:15:16 -0500
Received: from elite-desk-aura.lan (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Fri, 29 Oct 2021 10:15:15 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Jimmy Kizito <Jimmy.Kizito@amd.com>, Jun Lei
 <Jun.Lei@amd.com>
Subject: [PATCH 07/14] drm/amd/display: Clear encoder assignments when state
 cleared.
Date: Fri, 29 Oct 2021 11:14:49 -0400
Message-ID: <20211029151456.955294-8-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211029151456.955294-1-aurabindo.pillai@amd.com>
References: <20211029151456.955294-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 711aad2b-dd7a-453d-85a6-08d99aeeea86
X-MS-TrafficTypeDiagnostic: CH2PR12MB4135:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4135B6BF2FD18C2BB90969778B879@CH2PR12MB4135.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 184Rt5GmLpJVFkmcy4R1ET9wZFVxRblbadp4C4+8Q1NE2g7QOZafRoQsNilq9PdT2bT0mAGMkHGzeAltZILPg3RAzkbEghmEAhXs6LYDbJE8uWBHZo4xq5LSa8YNrIsjH4YwDEwKWAqOELnWEe9kjOtqTiDFYPIqblILTSxSEWijd7J3uoAY9gwRYWTu6uaKtWmUsw5jNlGtwfF6bLw0mVajgZBN464zBx5yd+wQn3/PHVzSN5Udt1wqhGf3vi0Qa92vf2PB7xnwGmfvmFx5kQH8dyVRnee1m/yyJ97c76KoQ49Ij/pL8i6LVmYhoGCRtEpPYUMRomNxovpqj4mWNT0naVujgZm9Hb2vYeiMjKb4rlEudn0R3KXP8MXfXx4aXDKyhHKizw5hC/FA5su//oKpFPVbzqnA7vESeyzcOzm6rvX3qAmoP79ArXxJBOpXLRMzuHFQZwELYtq/U0XTr6bgexZI1dVySdknFaaymZS4wD9tDgUkrnEKJ4c+05hC0z8Mfs44IbRV50qZBnu1bEG19o/TpSydUFShy/g9Ar03EfklS5n1YjMePSaMuJKeidzyn/ms5I5jH7csBA2fExuNLuPpwq4wTt/ECQ67Lyu7qFRridFi2y05zfh9x+PVSUTrTgOe68LE1xC4eemAdhMqfVc2oSyq8kxlrnaRr8WMu5DnQhoq08TI8SwbY0kBOy0gt0tqKWU7CPDmgVAHYFJ3Zkm2A+9UzZphyek8QG29eUfBBdtOfdAKaJsWO4ok6QTzW1VPbOCOOaGUd7H96g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(426003)(316002)(47076005)(4326008)(81166007)(186003)(36860700001)(70206006)(1076003)(6916009)(70586007)(54906003)(336012)(26005)(8936002)(6666004)(86362001)(44832011)(82310400003)(36756003)(356005)(8676002)(2616005)(2906002)(508600001)(5660300002)(117716001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 15:15:17.6784 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 711aad2b-dd7a-453d-85a6-08d99aeeea86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4135
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

From: Jimmy Kizito <Jimmy.Kizito@amd.com>

[Why]
State can be cleared without removing individual streams (by
calling dc_remove_stream_from_ctx()). This can leave the
encoder assignment module in an incoherent state and cause
future assignments to be incorrect.

[How]
Clear encoder assignments when committing 0 streams or
re-initializing hardware.

Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
---
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
index 72b0f8594b4a..25e48a8cbb78 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
@@ -236,6 +236,23 @@ static struct link_encoder *get_link_enc_used_by_link(
 
 	return link_enc;
 }
+/* Clear all link encoder assignments. */
+static void clear_enc_assignments(struct dc_state *state)
+{
+	int i;
+	enum engine_id eng_id;
+	struct dc_stream_state *stream;
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i].valid = false;
+		eng_id = state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i].eng_id;
+		stream = state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i].stream;
+		if (eng_id != ENGINE_ID_UNKNOWN)
+			state->res_ctx.link_enc_cfg_ctx.link_enc_avail[eng_id - ENGINE_ID_DIGA] = eng_id;
+		if (stream)
+			stream->link_enc = NULL;
+	}
+}
 
 void link_enc_cfg_init(
 		struct dc *dc,
@@ -250,6 +267,8 @@ void link_enc_cfg_init(
 			state->res_ctx.link_enc_cfg_ctx.link_enc_avail[i] = ENGINE_ID_UNKNOWN;
 	}
 
+	clear_enc_assignments(state);
+
 	state->res_ctx.link_enc_cfg_ctx.mode = LINK_ENC_CFG_STEADY;
 }
 
@@ -265,6 +284,9 @@ void link_enc_cfg_link_encs_assign(
 
 	ASSERT(state->stream_count == stream_count);
 
+	if (stream_count == 0)
+		clear_enc_assignments(state);
+
 	/* Release DIG link encoder resources before running assignment algorithm. */
 	for (i = 0; i < stream_count; i++)
 		dc->res_pool->funcs->link_enc_unassign(state, streams[i]);
-- 
2.30.2

