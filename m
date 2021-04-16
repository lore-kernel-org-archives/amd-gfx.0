Return-Path: <SRS0=1d99=JN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E201BC433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 14:34:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C9A3610CB
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 14:34:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C9A3610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1EC16EB89;
	Fri, 16 Apr 2021 14:34:35 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0B026EB85
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 14:34:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezCVDetJ9xDXNCyAaj9ezDyapUis/1tViITiNn8hAm1lJ1Pi3BDmW/vJC7H2FNtZp0DxJqXhN//2QVXIPTUWKK4cIc/XcYieUJfTnhCSCHb8y1c5/NUcqOwWerttgcAnqsV9hBDhjT2HTkUde+PpbEYab/gI5c72dSYrCREW/c1KQOdeAHv7pTYyOY8L6woQ38U9KvUecKjEOW2l9Bi+3dzHcnTTc33RRuMSnLFlKFqToOhbSNBLipRFDz2Vv2pgYeUJSu98lGXDhkfueQeHI87Hm3FQ/b2eL42fjIsW5OK0W+pGgW+EN2Px82NuW5l1cD+8llwG3cKOWvlpLRKmlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87T7D6J6MHpaULZ2j0HzsnKs8ZidiwesoZUzwwAPCLM=;
 b=ZJXtqtbRgII9hEsK4mkMOSwJkXt27Klu6qXGuSiue9xiLVtfCU7gAhpDXt462jMDfwfG20m/yg7WzCMkTLCaY/mLuJ/+lFemETqp/ApreeO+7UwG86ZmOKfF9KUzfDuGkM7gib2MpmBpUr4bKoEoVRP0CBT9Wm59rKdUOfIwav3+mnSYUYMpZmwwozLyNtFE7jyrduNx0FPTpisycxjtggYrcc4mLLs3kKuYEk8FztHHaGwq4NfdXNpOSnd15N7t4qfPFcF8h9jGzbH+moxylesoyuc6KH4pR0f51Neqvid2qROgpm1mXqd/zxr8lp5NSzZ30Ok/WPlViAwHPR16Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87T7D6J6MHpaULZ2j0HzsnKs8ZidiwesoZUzwwAPCLM=;
 b=HCHRF+vaBu4qmBE5CkTFxvqBWbYR/PJpXYGjc8R0PyVNDq0wr0JXxslnikLyrm5QhbH90Q9bO5S3NF2X2xWxYPTbr801ViGk9uFb0yw+FDqXcbpeUoqXiPLtfhCVYnmFapyFVTg3n7LdbLnyyx8iSGNBbGOQoeyEN7+W3Wt6rS0=
Received: from BN6PR2001CA0018.namprd20.prod.outlook.com
 (2603:10b6:404:b4::28) by DM5PR1201MB0107.namprd12.prod.outlook.com
 (2603:10b6:4:55::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 16 Apr
 2021 14:34:30 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:b4:cafe::b7) by BN6PR2001CA0018.outlook.office365.com
 (2603:10b6:404:b4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Fri, 16 Apr 2021 14:34:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 14:34:30 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 16 Apr
 2021 09:34:29 -0500
Received: from elite-desk-aura.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4 via
 Frontend Transport; Fri, 16 Apr 2021 09:34:29 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/19] drm/amd/display: Fix FreeSync when RGB MPO in use
Date: Fri, 16 Apr 2021 10:34:06 -0400
Message-ID: <20210416143417.611019-9-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210416143417.611019-1-aurabindo.pillai@amd.com>
References: <20210416143417.611019-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1a179f0-bcf4-44d0-d2f3-08d900e4bee7
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0107:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0107A533DE1863FF93D32B0C8B4C9@DM5PR1201MB0107.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:454;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +sz29mYN0QHdznAO9O93PhlIsOpHk327If250cCCpLymOzwzfE6sIQpysBL/Jxrjm4FHBMO2BUvn46HcAXTGj6UnXZbfxSe0eMzjoTcqoKib5SBM01aFKzrmZuqNFczUOX/jw2WDSP3bVfaMy1FfNQZXEucMuLnbhvGEfEb4IC2lEqwuroNpcW7tn57pLqlPpFmwi/irp0RIp519SfQc+k9XzCkzGUOn2lIfOCS1PLCEy0sExn5Y1C6aUsFfxk2aNIRl110HrPcowBF0uGsN+ZiL1ceYh8oFlBuIPr9RM9rNq7a/YFur4378TDf+87c69PXRyKhRMi8HKXknpfxphijIULMwTPTrVslOw3jkPPkopVIATE0sNSZrz5o3lQJTD0KroBwiU2K1t/be0n0vDRNH0Yvtsln0SGLxNaMoxbjRtaOXyunmtZ0WEf9ew9oG4OmfoCuiZk8iHrbZl/Gtt6gzkdrn9AQ2JOhVCR1usfm06C4Yd4XYMSH7vSvGX7vGmUZvZ7R+N+KK3Z8uXVBL808vlo+nWlIsoSueRTT0+qlEQSnEvSemmNNaF2AQkpOiBvs9YbJ30yWXx/FSllsjBGGE0yg9LrxRw6S93sTkUdSfwHdRj2UfaGQEuvXAXLehM+JioDhjYlsm3bMbvQ3JuoIIVP4q87UDOb5r/YSY3HFO1rHBIvlnYoROUpI9FxBA
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(36840700001)(46966006)(356005)(316002)(83380400001)(2906002)(336012)(426003)(6916009)(54906003)(186003)(26005)(47076005)(44832011)(82310400003)(478600001)(7696005)(4326008)(2616005)(81166007)(86362001)(82740400003)(8676002)(1076003)(36860700001)(5660300002)(6666004)(8936002)(36756003)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 14:34:30.4573 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a179f0-bcf4-44d0-d2f3-08d900e4bee7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0107
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
Cc: Aric Cyr <aric.cyr@amd.com>, Krunoslav Kovac <Krunoslav.Kovac@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

[WHY]
We should skip programming manual trigger on non-primary planes when MPO is
enabled.

[HOW]
Implement an explicit mechanism for skipping manual trigger programming
for planes that shouldn't cause the frame to end.

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Acked-by: Krunoslav Kovac <Krunoslav.Kovac@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 ++-
 drivers/gpu/drm/amd/display/dc/dc.h      | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index ee4970491d7b..79c652eaddb6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2833,7 +2833,8 @@ static void commit_planes_for_stream(struct dc *dc,
 
 		if (pipe_ctx->bottom_pipe || pipe_ctx->next_odm_pipe ||
 				!pipe_ctx->stream || pipe_ctx->stream != stream ||
-				!pipe_ctx->plane_state->update_flags.bits.addr_update)
+				!pipe_ctx->plane_state->update_flags.bits.addr_update ||
+				pipe_ctx->plane_state->skip_manual_trigger)
 			continue;
 
 		if (pipe_ctx->stream_res.tg->funcs->program_manual_trigger)
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 870cd7c6a387..ed19b9b39af0 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -907,6 +907,8 @@ struct dc_plane_state {
 
 	union surface_update_flags update_flags;
 	bool flip_int_enabled;
+	bool skip_manual_trigger;
+
 	/* private to DC core */
 	struct dc_plane_status status;
 	struct dc_context *ctx;
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
