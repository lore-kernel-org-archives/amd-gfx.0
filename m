Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF6DC04A95
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 19:42:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96F0C10E9D5;
	Wed, 28 Sep 2022 19:42:38 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8F3B10E9B1
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 19:41:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCoDdbVDvOQ8BFS6qwPnh7mQMmDh5HKrBkAeih+7bZlLRSDE2+aJ+vCn4ChEtV7HDp8xEIwsIaUfF6MFEWRXmpigiueilmnPpZL5lYN+1OhiV0Ern3Jc9DWCtF5PUntuAFKqHhmIETJa0gWhGgAI33KymQdnJcbB3XF6DIaCPeDSZzIUndSh4gO0QO3WJ2XHDeND0vhv2YBBYxbJVHYMK8tGYKkD1e0D/A/AWadZvN5z0SkL5qltpKYI6aVPgDn5DP/dwXu4qYUhNPmZxoqrE398tHDN8l8rIm4C3HYtcSaPUBNN0a4hvuqjy1Liot/EUovzwKsNvwocIFJJJXNSJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTcw9ljdDCjRv1nBb6qGkRb/mhlBXZ+fmuiK46gt7hk=;
 b=c/rG7RMJof+ieRHzFTrko4j2aZH6yGjVODnXHWN8VvJnMzii0wZeEdHERRdc+NV8gcHUB1BYMduY95deKdffgJtf9Bz5jTiPv0TuwDpDtDe09XaTVe/gXdU1TIPBEP60qN1XJ2P7eLHugo33QMjkWuAW9TQaArJdv/V65KSWK0aDtWAF0q3PAVYrj140+oUcMgy5H1GX0ZwhfNwK0OZzyl7EjzzjbIGooGTCRbUi4GRvxVdioucl+9IeAWs9TyIPWo1+1yTIirAKxB/mbva4nmAT9jW1a8diHuTgfO5wiwcCnsoDfCPHJ6Tmq0uBb5G6MXFZ3zk0MwEA8u6nWgDN2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTcw9ljdDCjRv1nBb6qGkRb/mhlBXZ+fmuiK46gt7hk=;
 b=24kOEjdpZuFzamdnJAOBGGAnDhekFkG+tQKF1vGq7vCM3iwZdV6DUe0fysPXl3AtRr3LFUT2g1fDz+uac4lVMrLxc9mSaUavz5CWUPs8NZR4qhNW1bicDRXWnaC6b5P2C+rBpXvJkGWk08OBGavtQBYeS7148faQ2yNAOG+t+mQ=
Received: from BN9PR03CA0661.namprd03.prod.outlook.com (2603:10b6:408:10e::6)
 by CH0PR12MB5235.namprd12.prod.outlook.com (2603:10b6:610:d2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Wed, 28 Sep
 2022 19:41:47 +0000
Received: from BN8NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::18) by BN9PR03CA0661.outlook.office365.com
 (2603:10b6:408:10e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.18 via Frontend
 Transport; Wed, 28 Sep 2022 19:41:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT096.mail.protection.outlook.com (10.13.177.195) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 19:41:45 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 14:41:44 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 34/36] drm/amd/display: Disconnect DSC for unused pipes during
 ODM transition
Date: Wed, 28 Sep 2022 15:40:26 -0400
Message-ID: <20220928194028.144879-35-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220928194028.144879-1-hamza.mahfooz@amd.com>
References: <20220928194028.144879-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT096:EE_|CH0PR12MB5235:EE_
X-MS-Office365-Filtering-Correlation-Id: ffb37ab5-381f-4fe7-87eb-08daa1897a09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KSbvn3ldeiJeiwRMGTrWHwmnpmBA5t1oxNpuPwNOq54/+bCRDSvNcgi65QNR/00Rrz3WfjXtrUHozy4WMocxcgNqYqwpCanaTEnE8OXKWpPrAIwtQUkX1qrn1wC2ZVl3A+PaDL2oJW7wmWaW5zMHYGzgptq2W3JJT1eamysncuiR6dWQ5qW1l7Il5sAx1ahFPMoRj3TTXHwbPIAdwn+WrAkE89gfzJorHUHms6+IjgMN+HzgR8rUPRofhGUo377jNFB+jzxtos5dUfa/0/TbG0t9FSj8pxCyvJns7qLmcdtggrJFaPjwb1s3t6sjb5Oc8vh8oQ+n98wiQU0T2jT835t+wTXydLui8lGz6mJlfG5iiRnzDUv1IwoqePzvrDNulAi0ACYnfFDItpff/pvXNT7BX7PX6sw3AVCzefspdF+BkKWQByJgjHo2UmzFkSKgVT0sbm45ql5W2zqeUEsMS9B4RzRxMFqQ5C52SgkxM52UeHYUFkqIkiIMGbKkYMlFia/YRuSPbwcXU7of35WlpNy9G4je2M5JEoCXmdk5glBWIFJGDoNpQFWK7Av8IjuFwhFi1cL2xGO/Sz9r8pYmKkXb1j85axmi3k9dEcsrOvq8ok6HAe/kWoHcaKsCBGbAs3rmYwe1DiGCcSIRohTuiA9FwtFNxis4gYASyPyHkKihMrXX/XluUIDBg/dmdvDxb/xd0rcnC+/fc0lOo8IFVZuBwF8+BXXzhx1nzTwvYt0+f9eV3uAuscbPQuDYr5cle0k7gG2vUJ8RjMlpehv8hfEM1w34deJLlsal1b7gt/OM0K+5QEKV4kzToNx6kghr5EraDyZ44Ht/HADsM1o2ew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199015)(40470700004)(46966006)(36840700001)(36756003)(82310400005)(356005)(5660300002)(54906003)(2906002)(316002)(8936002)(41300700001)(70206006)(86362001)(4326008)(44832011)(426003)(70586007)(6916009)(47076005)(40480700001)(186003)(40460700003)(16526019)(478600001)(83380400001)(336012)(1076003)(7696005)(82740400003)(36860700001)(81166007)(6666004)(26005)(2616005)(8676002)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 19:41:45.5757 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb37ab5-381f-4fe7-87eb-08daa1897a09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5235
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

[Why]
During transition from ODM combine to ODM bypass, if DSC is enabled need
to disconnect the DSC mux for pipes no longer in use.

[How]
During ODM update, detect pipes with DSC that are no longer being used
for new state and call new DSC interface to disconnect.

Add new DSC interface to disconnect from pipe

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 33bdf56b2b3a..955ca273cfe1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -1148,16 +1148,19 @@ void dcn32_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *
 				true);
 	}
 
-	// Don't program pixel clock after link is already enabled
-/*	if (false == pipe_ctx->clock_source->funcs->program_pix_clk(
-			pipe_ctx->clock_source,
-			&pipe_ctx->stream_res.pix_clk_params,
-			&pipe_ctx->pll_settings)) {
-		BREAK_TO_DEBUGGER();
-	}*/
+	if (pipe_ctx->stream_res.dsc) {
+		struct pipe_ctx *current_pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[pipe_ctx->pipe_idx];
 
-	if (pipe_ctx->stream_res.dsc)
 		update_dsc_on_stream(pipe_ctx, pipe_ctx->stream->timing.flags.DSC);
+
+		/* Check if no longer using pipe for ODM, then need to disconnect DSC for that pipe */
+		if (!pipe_ctx->next_odm_pipe && current_pipe_ctx->next_odm_pipe &&
+				current_pipe_ctx->next_odm_pipe->stream_res.dsc) {
+			struct display_stream_compressor *dsc = current_pipe_ctx->next_odm_pipe->stream_res.dsc;
+			/* disconnect DSC block from stream */
+			dsc->funcs->dsc_disconnect(dsc);
+		}
+	}
 }
 
 unsigned int dcn32_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsigned int *k1_div, unsigned int *k2_div)
-- 
2.37.2

