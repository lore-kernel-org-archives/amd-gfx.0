Return-Path: <SRS0=r7JW=B7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978F7C433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 22:58:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 684682067C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 22:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ryKDoZUi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 684682067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F33F6EC1E;
	Fri, 21 Aug 2020 22:58:00 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 224916EC1E
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2020 22:57:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HEkrXwzLq7uRn404ll0M+HdEfeQm4tsxNoYzp6uPMiaVKDLk1idIWur4HAeUJ04I1qGXUidPEXbIrUf6HZDeR6XidBRjnB/Nk/t3xjnKnRCh+udEc7ezpMqCJ5raAWDe6G9ZBkqPorQM0P5lmuU1xnwpzVzkQr2gaoL/xWPp3/sKOqsz0BbnkaItgUdqlvAQYQlZnGMM9NZXHj5rY5fpLu64LnN2ECdYbcAE8qBZMgv2MvuqSljj3RtrdNtphtENMv8Bnwv9DzTEzX327NlZ6a88DYRjVnP2NvytxHPBcseuDGufqIVBammjEVPFnMY1N89DJdG6b8MjlPE1jzfZag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwCAnVq4KP6tK1xIpc2+kbm0Rxk9StLUNMq5asC14JU=;
 b=N/06YSeLuxKP9JjMtGhK5VogEPZDLZ5UPgzMtg3U05yFc+/BaTjEq4yjw5R4x8hzyqaCtlYRsHRQztvODcLEYOv68LzRsF2KPKf2j8S5f89xGKrZlHck0cr932FFkUghYIaS1wzycdeVsGPs9PJvdoeARIGMoXOd+woe5cMEasUe5+uEqy7c+LVHPWSPmBhINfEIVvjzH9qjHkn+XexJyQ3EjogRjbn8chheu4MHuyGK22mRwc1DP5Sq9rLQ2y28WuQSLpPQRLaZdFrUrkBbVwY9+s42Ql91osSGhYMg4CnZfbyKDDY0ciwwbUJ4tl9DiJKQWrnfRPLuGxsaeI3+jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwCAnVq4KP6tK1xIpc2+kbm0Rxk9StLUNMq5asC14JU=;
 b=ryKDoZUiu4vWTQzKUjREBTu+E9k0PvqV7VW1tFxd6M9MKx4+s2/Es5VIfwJXZ/VrF4QQkL3Tr8HbBRCOGE1Dodob8gIFyDPe0hsQt/GUGObPbmFkrZhzeT+wyOKQU2nAUAQKTvS4E0zuZHh6L/i+OW0AvY2rQFOiakP3yQ36S/Y=
Received: from BN7PR06CA0049.namprd06.prod.outlook.com (2603:10b6:408:34::26)
 by BN8PR12MB3473.namprd12.prod.outlook.com (2603:10b6:408:65::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Fri, 21 Aug
 2020 22:57:57 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::13) by BN7PR06CA0049.outlook.office365.com
 (2603:10b6:408:34::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend
 Transport; Fri, 21 Aug 2020 22:57:57 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3305.24 via Frontend Transport; Fri, 21 Aug 2020 22:57:55 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 21 Aug
 2020 17:57:55 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 21 Aug
 2020 17:57:54 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 21 Aug 2020 17:57:49 -0500
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/9] drm/amd/display: Call DMUB for eDP power control
Date: Fri, 21 Aug 2020 18:57:02 -0400
Message-ID: <20200821225709.136571-3-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821225709.136571-1-eryk.brol@amd.com>
References: <20200821225709.136571-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b66264e2-db78-48b7-2505-08d84625a42c
X-MS-TrafficTypeDiagnostic: BN8PR12MB3473:
X-Microsoft-Antispam-PRVS: <BN8PR12MB347317E1FAE3E0DFD0F8E97AE55B0@BN8PR12MB3473.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AqpD1ZPSBH6iem426jzPy6jviQmY2UgCd/XVnooqi1M0atdoJsNbkD6U4KqE0icko55l2DO86JlU6wPs/HxUqU033iRLxXwYAhyf3tmxlEmNYqvbyXmZ9mJXPWwAyQR7Y3HkOoGxmmM/3K2bkMT99wbl9R8avha63bGTQ4F4TD6aueWWp7zCUdlqb4EeXGCWgrEwjYAGjvzw04lKvK89T1/NqF/WU59WZVC7TYFewUg+QXTjFyd3spsuZosdz9YbBa9gU170IP9rKpyJ24vQRHAb4JJmus7q4eheDbp7PUbA/S+jZidKmcz0mreQgK0Md6qicb6r9+uWdn27VibO/E8c+i/BSN56Dp87wR/5Cdthf8abZOcgq4n3SypoRBLoyYDVmghytbMgcQOxea6K4A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(46966005)(83380400001)(8676002)(26005)(6666004)(336012)(82310400002)(8936002)(186003)(86362001)(2616005)(426003)(70586007)(70206006)(36756003)(44832011)(6916009)(82740400003)(2906002)(356005)(47076004)(478600001)(5660300002)(81166007)(316002)(54906003)(1076003)(4326008);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 22:57:55.4566 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b66264e2-db78-48b7-2505-08d84625a42c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3473
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
Cc: Chris Park <Chris.Park@amd.com>, Eryk Brol <eryk.brol@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chris Park <Chris.Park@amd.com>

[Why]
If DMUB is used, LVTMA VBIOS call can be used to control eDP instead
of tranditional transmitter control. Interface is agreed with VBIOS
for eDP to use this new path to program LVTMA registers.

[How]
Expose DAL interface to send DMUB command for LVTMA control that VBIOS
currently uses.

Signed-off-by: Chris Park <Chris.Park@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 .../drm/amd/display/dc/bios/command_table2.c  | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
index a91d7be5d86e..25bdf1c38e0a 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
@@ -920,11 +920,39 @@ static void init_enable_lvtma_control(struct bios_parser *bp)
 
 }
 
+static void enable_lvtma_control_dmcub(
+	struct dc_dmub_srv *dmcub,
+	uint8_t uc_pwr_on)
+{
+
+	union dmub_rb_cmd cmd;
+
+	memset(&cmd, 0, sizeof(cmd));
+
+	cmd.cmd_common.header.type = DMUB_CMD__VBIOS;
+	cmd.cmd_common.header.sub_type =
+			DMUB_CMD__VBIOS_LVTMA_CONTROL;
+	cmd.cmd_common.cmd_buffer[0] =
+			uc_pwr_on;
+
+	dc_dmub_srv_cmd_queue(dmcub, &cmd);
+	dc_dmub_srv_cmd_execute(dmcub);
+	dc_dmub_srv_wait_idle(dmcub);
+
+}
+
 static enum bp_result enable_lvtma_control(
 	struct bios_parser *bp,
 	uint8_t uc_pwr_on)
 {
 	enum bp_result result = BP_RESULT_FAILURE;
+
+	if (bp->base.ctx->dc->ctx->dmub_srv &&
+	    bp->base.ctx->dc->debug.dmub_command_table) {
+		enable_lvtma_control_dmcub(bp->base.ctx->dmub_srv,
+				uc_pwr_on);
+		return BP_RESULT_OK;
+	}
 	return result;
 }
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
