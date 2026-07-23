Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB11BC531D0
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 20:19:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36AD610E5EF;
	Thu, 23 Jul 2026 20:19:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="odadg8os";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012016.outbound.protection.outlook.com
 [40.107.200.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C16D810F1C5
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 20:19:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ShPc3foteqobtuZsW/G4R1PXMWKwsC0U2fEaZ7773A5cdFtmzQly3z0zANU2uOXmi3fYTPDDGeSOvkar4fk7RHwXlh+bZ2+gj4sBmksBtReHuLXuUxiD6vleNaiE3aoHIxiBn1B8q7hGhEp0T9EcVc3MjI4rEbsxDF8sklNKXbt2Rh098+g0lCxHzZHu4e9AKAMm8l/K2VNLmw4lQyCj6yKPA9kCLnhP628HKbelCoo1KbHYcfYdIR9STZxx0elCRFd0xR7oCF+29AFePf/MgRaCM+BWOWEmYIjrYhCRtuIbQ+bCUsqs9ZgkGC2RIHtryIZGyURT+P2Bwn3KzQCnBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynYQ9tfiungUwZGPpF/2e+UPZa8On0AcUSyPEMGWGNc=;
 b=f1VVDpyO7SBha5awLUp7sput/os3yAMBWsP66DD3pgg8KusAaJ0lY7+Bqqoi20AWul4sBgg9OVX1S8eKnYarWDLZI8OdAL63jfe7ZArwni3E7nfrO716WIJJntzNz8LFGry/g0DJGzCKcWcdAQcIGUQ6Aa86VzDnJL5lLoeCciTbB1JEoTUFnClDgwRc+uIb8khPArhlyHUIIn3sbUrIKwvnnnhNnzhUaRX+k/BLQ8kOHu+TdqxWApWCaLn4QK2EASWe1e+dAlP7L+BrgGsja70GcE7S3m4VFRylGllw5fmkyjrNd6RKzsdIQyY6Vs3B7O2PY7jSfLF+e5UwiAsj1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynYQ9tfiungUwZGPpF/2e+UPZa8On0AcUSyPEMGWGNc=;
 b=odadg8osbdrnndxn+cJVzar/1EM6AnwRGUcy6lpnrkW3TImSF4JXzWKRafEAbrOqLmyYwYK0gJBgZXEMakDkWGlUgLLzFCaasFptzqPwkl/5mmP++LLdGq4NWGUSeEckLRCLiXfB4X3ioGAfmz1FSCrOl7Y6Q4ksyrX58q778Zo=
Received: from MN0P223CA0017.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::8)
 by DM4PR12MB8521.namprd12.prod.outlook.com (2603:10b6:8:17e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 20:18:59 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:52b:cafe::14) by MN0P223CA0017.outlook.office365.com
 (2603:10b6:208:52b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 20:18:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:18:58 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:18:55 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 10/49] drm/amd/display: Add AV mute wait frames to
 dce110_set_avmute
Date: Thu, 23 Jul 2026 16:13:18 -0400
Message-ID: <20260723201908.373300-11-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723201908.373300-1-jerry.zuo@amd.com>
References: <20260723201908.373300-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|DM4PR12MB8521:EE_
X-MS-Office365-Filtering-Correlation-Id: dc16e7b4-8f3e-47a4-b17c-08dee8f7a08a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 8yLFIJEH43nFY+2eDQE0N2D5IGRXnZmw4JuJa/eRO+P7C6vAFNqkdwHrvUKrqxI8dycdZMgoOwgwNansgQd3EMN7lLVY09SaleZjarmbEpi+PN4rtneGsxbNnHDApsjQtDjQIHxwpWBiRl4OmlPWXkVnWQZr0mp4vhr2u74ejjUbbfv21+YhAZOxz9qZ2M0kGPus+5KHfc6YX7qcqYpiAaw2AvDvnKpU8oRiRgUC85VnLDrMcuLPoOYWYXYM2dIZLQI4T41Yc27vh2TKM6AznHevmN8E+u3YXp7R01syDON6F3Qb1iezkRNOKcfqoB7tgo/IUbpXlveaM8UAr+DGVSxnHSo8Y7NSLVcKDKuyuyDivGiIkih+2W97Y0vO+oL+6AyvPG5JfEBU/X3B8uVz5ErMb2yCx/gIZzaRFT1/cdIbQZWuNHLWqlD9SnXQWdMhFrxN6lK0w+LDCk5sjC8oazbrYtu1jZGRzOrUrwOOeG2uEl3Ds1kdZQLxg+aHNrp0gN0yR/UKmR1Qu3gT5MSi7Y/5TTpFXvIZ+TIc77m07T/qrzZDqGUTgdUNQmmB2v9cjo0yLMHU+NBRUtN3uG/bUcrX2bFasONCQleaHzHytWwWr+8htC23kfBiVEAQDGKPAH2nm/Y2QkSY18h8ImwQEKcKnXCxBQ81F9kXRTdHf5lzP2ksAwkEV90QUECd1hPpYHAFSPWU1iw5r1VDA7kTng==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3TGmXpJ1FuVOdI7I0v3+8/ZJN1oFQo/kpqZKCWnT1T9drxC7jzLXslP6ot9XkN14+07q8QoDsOycaZnh0xW3PXWfT6lbtcG3UR0xTq3Gkn7abddcCvOtLQKxdTzIdS9HuemznjxKUAn9d/MW7jcn4u8pc9dQCi+2QuVYNc7FHWzQLxDRXBQZ7SqcRd2tNOiKcNyuQ6lvPNpXaObu5HU2GRm7T2FC5bclmTxXJFuFhHK6uem7dxD08vzPkvfypNOssvJ7FsJaPqJPOmYZGUgdIU1Ekdu93zuEB6uSHtUMI+kY+iuxi+SU1oiiBg6V0xGKHBHBTVcBPWOUKdahVvNqsVPDqTpdCy0PWDO0c/9cOzZsL1ZhnJ+TgCbBj8QhG4ywUdmQZb7bEOA948elTtlFZ4HAgjw4pXaM559Oi0qcYCULwnlgxNgFa5PKoIl01BAB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:18:58.0754 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc16e7b4-8f3e-47a4-b17c-08dee8f7a08a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8521
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

From: Ray Wu <ray.wu@amd.com>

Port the three-frame wait logic from dcn30_set_avmute to
dce110_set_avmute so that older DCN versions (1.0, 2.0) also
wait for GCP packets to be sent out before proceeding.

This ensures HDMI sinks properly process the mute state,
preventing garbled display after link re-establishment.

Reviewed-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 21 ++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 262982ca5ad9..f91ce2b4b1bf 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1336,8 +1336,27 @@ void dce110_blank_stream(struct pipe_ctx *pipe_ctx)
 
 void dce110_set_avmute(struct pipe_ctx *pipe_ctx, bool enable)
 {
-	if (pipe_ctx != NULL && pipe_ctx->stream_res.stream_enc != NULL)
+	if (pipe_ctx == NULL || pipe_ctx->stream_res.stream_enc == NULL)
+		return;
+
+	if (dc_is_hdmi_signal(pipe_ctx->stream->signal)) {
 		pipe_ctx->stream_res.stream_enc->funcs->set_avmute(pipe_ctx->stream_res.stream_enc, enable);
+
+		/* Wait for three frames to make sure AV mute is sent out.
+		 * Some HDMI sinks need additional GCP packets to properly
+		 * process the mute state, especially after link re-establishment
+		 * with HDMI 2.0 scrambling enabled.
+		 */
+		if (enable && pipe_ctx->stream_res.tg->funcs->is_tg_enabled(pipe_ctx->stream_res.tg)) {
+			int i;
+
+			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VACTIVE);
+			for (i = 0; i < 3; i++) {
+				pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VBLANK);
+				pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VACTIVE);
+			}
+		}
+	}
 }
 
 enum audio_dto_source translate_to_dto_source(enum controller_id crtc_id)
-- 
2.53.0

