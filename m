Return-Path: <SRS0=1d99=JN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F2DC43461
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 14:34:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2CE0610FC
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 14:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2CE0610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 494CB6EB98;
	Fri, 16 Apr 2021 14:34:51 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F21256EB90
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 14:34:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZkxovkxFPGofkcobpz5Nw22Sr9h7ZkzixpvSBFzZs54zR0/ztdv42hDUnW/VnegPbwQt8HfnATIN/cCgt9NHKPeQljCI1eTx0K66lrZLnd+8yv0zR21X6I3x2eKxNJsNn1IMSw6ZogRptpQBt51GNBiSM3sZ6whiWwTubt+KHh0zkqUF0rnVSqDfOpYL2+i7FG5qTjHqRZusNG+nD/l+jWkOu9ZnlQWly8RKGVbGlSZhi3h7b5hmMGKPmRMCfphWZylSGoJrv1uYry6ss0z1FBkhXLckTFmAENtbWfFbwI3i+gxYr3J8one2S5sIf4nrYsN6ifdpLr6zf6pI7MWu0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XuzbZBmrcQiiCd83skFCS53Vn8cSJ8/9gJV7JmBSk6k=;
 b=GliqDQzixPgqM3ihCLWgfdkMeIpiWQE66Kb9Ety7jYidjRAyUJmnAahKrNhTlLGrSxhzM47sYQYHTWRXkc443tSETGKub0ufurJSqxJjfNXtDdOQIKVpnGt39YL4suUluwRjpe1WyJI065inAJm8Et/gKRj3tLXmJOTITywPiwulpFkOWQ8rWOcUMkz1zI8Sz66VqDNLXqBuUPQGjLKVVmLrMffM7zur9NKnM8JxJcbL3NkjMonQjMPQgD1Zw78HmbPpL81Nuv3Ro0Wat2kxmVubEuiFEMNUatvQtHSKXXd1Sq1b3cHwcpYGNWIhoPFVWPXukdLYM1gYlhLUJJlwig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XuzbZBmrcQiiCd83skFCS53Vn8cSJ8/9gJV7JmBSk6k=;
 b=t57tOGIVZC0pE9g7A1gOS5MBZj5gc3Ods+rbmNIQ4N7JXeRxTdKpq26PMfNj+YKXRG1EDqYCellpqS+OGBlloH7JTepGUQKeWqG315qp1W3KnEt1yc7DYnseIlYwj/e9GqYtb279sp3QxvJZ3NFX1rlcXOWS6GVeO5RKQ723QEM=
Received: from BN6PR13CA0043.namprd13.prod.outlook.com (2603:10b6:404:13e::29)
 by MWHPR1201MB0127.namprd12.prod.outlook.com (2603:10b6:301:58::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Fri, 16 Apr
 2021 14:34:47 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13e:cafe::ad) by BN6PR13CA0043.outlook.office365.com
 (2603:10b6:404:13e::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.7 via Frontend
 Transport; Fri, 16 Apr 2021 14:34:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 14:34:47 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 16 Apr
 2021 09:34:47 -0500
Received: from elite-desk-aura.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4 via
 Frontend Transport; Fri, 16 Apr 2021 09:34:46 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/19] drm/amd/display: add helper for enabling mst stream
 features
Date: Fri, 16 Apr 2021 10:34:15 -0400
Message-ID: <20210416143417.611019-18-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210416143417.611019-1-aurabindo.pillai@amd.com>
References: <20210416143417.611019-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 425d75a5-21ba-46ff-cc8c-08d900e4c92d
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0127:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB01279D6975DF7D21D95878118B4C9@MWHPR1201MB0127.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:240;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7qjTFT7JaMfVxbI4CevfzPb9i5lnTKws4x8ugLc8ejwOdBaEhqB08wwdZuz9FKPuIbOfDlY/ulh8+Z6yfXdtyCfKuEvY0DgE+ZZtyJWYOwSgPLv8akcVhpSClGPktT4ZZ2i3V2oxpz8MR/WuPE7oG6bVOPdom/Xl0Sv3AvrwXwRVSAmKKJY9STaaAMonANFyGadhV+eZbS7pn1fa1KlFUaDHyY9PAwdbaWyeSTDkPwLl9iP1G9llhrVm60ew1J3/rDNkyrshJ85vC/L1eVlls7RUM6knQOUQhRZCcpbigTaOKE46Xb3lw3XQ1D/HIEFWuNhXbDhS5cZBZgRwQaLO5q8WcfsaXsoIOBYEQlGbQN1Qj5u1DksLv4eWh6htjmlJLhurjb0AKNLmA3pp5MKbJUX5VGZWEExztSn1Q6mcTEg9SVCkW8uBvO3JF+9q4E1YMwRk/eq22H5xDbVEAlIzyYzLJtIt/f2g9OvDB2zfuKuVhUeD3Xf1rMhfaycrzZN7Kxi06nF0OZVLtBLoPalHZeFQUT5b25dQErslQtuSaw82HdBZg2E8rngHbJLAva9VIr0xI7dheLgE2YOVs3oSat3RFUaFdsJI0fEiRPWPgXIQVsEhBN8U0g/otfEyYAuvauXW+6vEJxFuXuliyIv7SE/yMCW5Cfi1C0bmYoM+Lt3eIFUrFgWWOmprg/PnRgak
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39860400002)(396003)(346002)(36840700001)(46966006)(47076005)(2906002)(70586007)(36860700001)(82310400003)(83380400001)(8936002)(6666004)(26005)(336012)(478600001)(2616005)(6916009)(36756003)(8676002)(316002)(186003)(5660300002)(4326008)(7696005)(54906003)(86362001)(356005)(81166007)(1076003)(82740400003)(70206006)(426003)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 14:34:47.6951 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 425d75a5-21ba-46ff-cc8c-08d900e4c92d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0127
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
Cc: Anthony Koo <Anthony.Koo@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bing Guo <bing.guo@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Bing Guo <bing.guo@amd.com>

[Why]
Some MST devices uses different method to enable mst
specific stream features.

[How]
Add dm_helpers_mst_enable_stream features. This can be
modified later when we are ready to implement those features.

Signed-off-by: Bing Guo <bing.guo@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 25 +++++++++++++++++
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 28 +++++++++++--------
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |  2 ++
 3 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 103e29905b57..e8b325a828c1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -711,3 +711,28 @@ bool dm_helpers_dmub_outbox0_interrupt_control(struct dc_context *ctx, bool enab
 			 enable ? "en" : "dis", ret);
 	return ret;
 }
+
+void dm_helpers_mst_enable_stream_features(const struct dc_stream_state *stream)
+{
+	/* TODO: virtual DPCD */
+	struct dc_link *link = stream->link;
+	union down_spread_ctrl old_downspread;
+	union down_spread_ctrl new_downspread;
+
+	if (link->aux_access_disabled)
+		return;
+
+	if (!dm_helpers_dp_read_dpcd(link->ctx, link, DP_DOWNSPREAD_CTRL,
+				     &old_downspread.raw,
+				     sizeof(old_downspread)))
+		return;
+
+	new_downspread.raw = old_downspread.raw;
+	new_downspread.bits.IGNORE_MSA_TIMING_PARAM =
+		(stream->ignore_msa_timing_param) ? 1 : 0;
+
+	if (new_downspread.raw != old_downspread.raw)
+		dm_helpers_dp_write_dpcd(link->ctx, link, DP_DOWNSPREAD_CTRL,
+					 &new_downspread.raw,
+					 sizeof(new_downspread));
+}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index fa384923cfc1..f4374d83662a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1679,21 +1679,27 @@ void link_destroy(struct dc_link **link)
 static void enable_stream_features(struct pipe_ctx *pipe_ctx)
 {
 	struct dc_stream_state *stream = pipe_ctx->stream;
-	struct dc_link *link = stream->link;
-	union down_spread_ctrl old_downspread;
-	union down_spread_ctrl new_downspread;
 
-	core_link_read_dpcd(link, DP_DOWNSPREAD_CTRL,
-			&old_downspread.raw, sizeof(old_downspread));
+	if (pipe_ctx->stream->signal != SIGNAL_TYPE_DISPLAY_PORT_MST) {
+		struct dc_link *link = stream->link;
+		union down_spread_ctrl old_downspread;
+		union down_spread_ctrl new_downspread;
+
+		core_link_read_dpcd(link, DP_DOWNSPREAD_CTRL,
+				&old_downspread.raw, sizeof(old_downspread));
 
-	new_downspread.raw = old_downspread.raw;
+		new_downspread.raw = old_downspread.raw;
 
-	new_downspread.bits.IGNORE_MSA_TIMING_PARAM =
-			(stream->ignore_msa_timing_param) ? 1 : 0;
+		new_downspread.bits.IGNORE_MSA_TIMING_PARAM =
+				(stream->ignore_msa_timing_param) ? 1 : 0;
 
-	if (new_downspread.raw != old_downspread.raw) {
-		core_link_write_dpcd(link, DP_DOWNSPREAD_CTRL,
-			&new_downspread.raw, sizeof(new_downspread));
+		if (new_downspread.raw != old_downspread.raw) {
+			core_link_write_dpcd(link, DP_DOWNSPREAD_CTRL,
+				&new_downspread.raw, sizeof(new_downspread));
+		}
+
+	} else {
+		dm_helpers_mst_enable_stream_features(stream);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dm_helpers.h b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
index f41db27c44de..7617fab9e1f9 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_helpers.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
@@ -147,6 +147,8 @@ bool dm_helpers_dp_write_dsc_enable(
 bool dm_helpers_is_dp_sink_present(
 		struct dc_link *link);
 
+void dm_helpers_mst_enable_stream_features(const struct dc_stream_state *stream);
+
 enum dc_edid_status dm_helpers_read_local_edid(
 		struct dc_context *ctx,
 		struct dc_link *link,
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
