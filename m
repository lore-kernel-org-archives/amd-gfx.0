Return-Path: <SRS0=S25v=LM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96790C48BDF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 18:38:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47ABA613E2
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 18:38:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47ABA613E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 051E16EA6B;
	Fri, 18 Jun 2021 18:38:18 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2087.outbound.protection.outlook.com [40.107.101.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58EFA6EA6B
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jun 2021 18:38:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrAIjVlt7f69TI9fg+lxtMa3cyArBGZCnbyevBBd6mkU8oFz4+7A5TI/5ama212d5ap4wZ3Ccd87L4iD3KfdD4HitraSivAehmFLghLa6GVxPQW5+3NdgcBhNadfzBC47tK385bWnv0tduj8giG+JqXmBHHL0rMT6ZtsbrZT/RcG3qKAIL5orrGVn4Q2wusm6P5QAyu7+GflTg1XH8zMt0rj0s3ipGnh5B1PVPYoNqo3WSZ5/UwyV20y6BQGN2pU+KacbMiuQTW5zSGTN5dtkN2DH/mjc82RZVUaTDJNA3bilS3BWnK+ixhrwybFY6YKsW5nW8GMaqYLT69RHKgK2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QdYpX0libJ3gnf94y8JvOBm7eAryvdZhdi9yhyUIuQ=;
 b=GWSw+2JEbEjsW/YK6nd2FVLqyBLbPSNKMe3HXr9Yyy3cB3HDTff8921z8wDD1JGvG3wtI4FbUjRwyJEAkWZBcw3wRUOqZuXOk5BYQwJMgLAZhR/KgqOg1KG+6V9oAZnTfDsRfPktmXOCpTU48x7bw2TiaxJs4SwxKnkg/9HN/jE3vcBqwSVW+2dJYAfZ7iQsQYx8+mIKtaUoTQnsnsFfPLrmd02O4qQhEsB3+x66ie1R6I7I0Ig+4vEAyZso0rZEgc5B6pmCywqQbQdswqF2UNq1FYSL0eKvoVaZCJPTxv7kypl0K/9IWttb1lC0U1KK9kA4HN2vWUtMUIDI/Fnf4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QdYpX0libJ3gnf94y8JvOBm7eAryvdZhdi9yhyUIuQ=;
 b=1tea0LuQ/U2qmgYsny+1j1S4z2y2fM9Z/vrKMi3WFVSD8nkfj7yw6wFvUFZ6bfIFKOPm8NFfExIe96tPP9AXL3o4T013UZWu+7VNJaF2/f0FrwvjS+uouzS6oCMdVm++zYuE5OCds7QICuY7st5ZMWpSXheOoOqGzkd6Z69bsQc=
Received: from MW4PR03CA0217.namprd03.prod.outlook.com (2603:10b6:303:b9::12)
 by MW2PR12MB2505.namprd12.prod.outlook.com (2603:10b6:907:4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Fri, 18 Jun
 2021 18:38:13 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::13) by MW4PR03CA0217.outlook.office365.com
 (2603:10b6:303:b9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend
 Transport; Fri, 18 Jun 2021 18:38:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Fri, 18 Jun 2021 18:38:12 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 18 Jun
 2021 13:38:12 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 18 Jun
 2021 11:38:11 -0700
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Fri, 18 Jun 2021 13:38:10 -0500
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/12] drm/amd/display: do not compare integers of different
 widths
Date: Fri, 18 Jun 2021 14:37:34 -0400
Message-ID: <20210618183736.647268-10-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210618183736.647268-9-bindu.r@amd.com>
References: <20210618183736.647268-9-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c673b156-d782-4a05-97c1-08d932883aa5
X-MS-TrafficTypeDiagnostic: MW2PR12MB2505:
X-Microsoft-Antispam-PRVS: <MW2PR12MB25057ABEE127CD965E39F7C9F50D9@MW2PR12MB2505.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dm22FdRyXEO7xj83wjxCPk/k9TmO3pc676t3j4jXnraOKAQMo63hYZfiAZfaqnGFHUsGxlB0WSoODFVhOsCZVdWhNylEXID6THrdPnmxNeiGCb3KKOJjBP80vXsRQpGUJgQbJC6MZruW1kfdohEtietbM3MO831AMcjpGn/d+WNBy1JunEP+Bjj/1BLOxH/PZiACKFy4AmD7r+C61oFgaMKtMR9fFa451EcuUSyZ0CahHX3yNHiEXBKXS2487CBseAjucA0abKc8PguHVjyoPZ33qGqooAZRIjYyEy91kt1+yjehZ8d84gufI52kPSHw6d+oyZoe5Py/3ApgjrBv91DxVYC0JSMTi1HTdOvuXPGvdtX9eLyTAhONQP4yDJbQCTtrwPIHTaRAqovn1ySrnci9W3hsQ5tuCR2XlVjKPwDRPFpUk8v8dOaWaawhG6BSKCBe1dRKWJcJuNE/A8AzpDG+R3q/kvL0YrCE2K/lBLtXM+mGwURVyCGlHklVqjnsuYxf5CfsZDF8wCmgOlNsauTZKwjKTddLPjlFNwm3RJrHHeIcgyeKDM+78H+jTi2Eg+x22NfCMGJeqUeiKzAi3mrEifxSSNUevm6Jns9ob3XQozYsZ/z+p/e4+2dzuzToYDVBY2ynFtR25bAyI1JkpOM6O1E++89bilYCZf5bRZYYwfTVH6K2OsFL/tWpLnZ6
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(46966006)(36840700001)(4326008)(316002)(26005)(36860700001)(70206006)(186003)(5660300002)(70586007)(47076005)(86362001)(82310400003)(7696005)(54906003)(2616005)(8676002)(82740400003)(81166007)(356005)(336012)(83380400001)(36756003)(1076003)(8936002)(2906002)(6666004)(426003)(6916009)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 18:38:12.8958 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c673b156-d782-4a05-97c1-08d932883aa5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2505
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
Cc: Josip Pavic <Josip.Pavic@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aric Cyr <Aric.Cyr@amd.com>, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Josip Pavic <Josip.Pavic@amd.com>

[Why & How]
Increase width of some variables to avoid comparing integers of
different widths

Signed-off-by: Josip Pavic <Josip.Pavic@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c    | 2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 9058e45add92..a033bec2cc4c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -821,7 +821,7 @@ static bool dc_link_detect_helper(struct dc_link *link,
 {
 	struct dc_sink_init_data sink_init_data = { 0 };
 	struct display_sink_capability sink_caps = { 0 };
-	uint8_t i;
+	uint32_t i;
 	bool converter_disable_audio = false;
 	struct audio_support *aud_support = &link->dc->res_pool->audio_support;
 	bool same_edid = false;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 10b749ef7fbb..6af6247ae055 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1768,7 +1768,7 @@ bool perform_link_training_with_retries(
 	enum signal_type signal,
 	bool do_fallback)
 {
-	uint8_t j;
+	int j;
 	uint8_t delay_between_attempts = LINK_TRAINING_RETRY_DELAY;
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	struct dc_link *link = stream->link;
@@ -2307,7 +2307,7 @@ bool dp_verify_link_cap_with_retries(
 	struct dc_link_settings *known_limit_link_setting,
 	int attempts)
 {
-	uint8_t i = 0;
+	int i = 0;
 	bool success = false;
 
 	for (i = 0; i < attempts; i++) {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
