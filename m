Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA548C46CD2
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Dec 2023 16:37:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58B7210E5FC;
	Wed, 20 Dec 2023 16:37:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E51CB10E5FC
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Dec 2023 16:37:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9jdunAH9Acs0PYYisuv/DYRxbO26cpybz07OUqZN2jGue7aAUanQMFd+w4TbbAA3CMG6F394s+wlDDp9bjsPIPYV/7MvCGsf1AshjDOMiycILSMB8kIpbBfC8p2qAYxCxcX6SRJrZ3sT6iR26YcYY6aUOyuYlAoloUSR/wVAoKI1EypkMaTLp8ZUDF07wH9XFZJRHrSL2h4TmaXZF9OcoZknzV51WfS6XknLyuBVYDFKocxZIjlj18p9gw4uppnojNBuMr5TxMSFsxlw7K8UMbDxoxP1F5CWr2KpbAsUN9O6Hqw1deAVCntV/hD8ezeSNDM1vCk/HV1K5GTw1JdGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGrJhXFfpyQ98OBy7qg3N3EvgQ044XAUenJQve5O+As=;
 b=WMBKF+F3LXahKgil95M++i+DyDtW6Xc/+7ZYZc91mMpe1jcVv1ojH+nO+AFZhNNmtoXMb040dIm5XGVEYngweMl88iMQ6uqhHHLwxmcLZu6CPqeuFNBlP1S8iSbc8wVu8awl4AMZo1QHOPAjW1eZ+EWKP21GoO10+DQeG2m5vURltA2oDOv8Ld9EMMOQw51Q2pIrS2YhCuVe8m1+fUqxlAJLmhQOXjLAPKy4VazwX9Pm0yXRNcvN4quwnCn6ocZ+bn+D/7NAUguTlTDzLMeJSwVvC+Exi8/1+6KttL4fThdkHB6vYdpOMJSXSeV9sdPPswVZEo6ccdOp6WkZBuLcfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGrJhXFfpyQ98OBy7qg3N3EvgQ044XAUenJQve5O+As=;
 b=N1LY4CZ/1nSS5XAd++1eii3t09dNjxdUUHu0qr8wsI3HOaD6/MlNLlVSaX+kRSKPbUdXyjxV0w+ouboJwPgRaq9M5gIzVcMhN+qWIdymq97lRgQeNR3doewvU0CvG1ulCeBlR9RWozohm+DDaFnA2MsGNcKdrFykwRcJoCNwPR0=
Received: from BL1PR13CA0121.namprd13.prod.outlook.com (2603:10b6:208:2bb::6)
 by PH7PR12MB5687.namprd12.prod.outlook.com (2603:10b6:510:13e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 16:37:19 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:2bb:cafe::ef) by BL1PR13CA0121.outlook.office365.com
 (2603:10b6:208:2bb::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Wed, 20 Dec 2023 16:37:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Wed, 20 Dec 2023 16:37:18 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 20 Dec
 2023 10:37:13 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/20] drm/amd/display: Fixing stream allocation regression
Date: Wed, 20 Dec 2023 09:33:51 -0700
Message-ID: <20231220163538.1742834-20-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231220163538.1742834-1-Rodrigo.Siqueira@amd.com>
References: <20231220163538.1742834-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|PH7PR12MB5687:EE_
X-MS-Office365-Filtering-Correlation-Id: e89efe5b-a757-4d23-96db-08dc0179eedd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YOo8nxoi4EGQSBdcaGkuG2WqCsscFi2sNBRW0HwLSj5nWkrs4upzWQq2lh3/A7vWz2rpg68hZkkrHIrp8SXMI9wSIOM7Y7cXJXLI5yK6ZpD8XlV8CAnOLh//XxOls20NsHXPdKCqlmliDcA4OXeB/82OxQK+cKN9W/dsc1lVqCSkKzEZQFz2R88KfSaZLgOx5vu+bpNlyQUbS4Y3BBaJ5x+4VtiqBFMyTuBGmnwNFeWqtBXGxAsYa9P+daEhiUIzQ/kZ3RbokkpSEysC/g86EnO5DiftQsm0AUlL/fP99cwdtrT5ECQPtj3OBEcr+NwSYqtYUpDDw4xnrzJyTZMZyvSGrWZP4mOOe7XXOpktLd/6Gb0+X9j6Yzs1GRrNEIE0OY52gwJpDRqSByPYEv3NzwlylcS+hjw4yzJOqMg5FpQx8lIGBES0gnNAYVl+4PRg8DlMz7Fmm45ZZRyLfTC4gBJujPl2/EgWL60oTUjwA2NCcWuORJbZ0WfieoyoWki2NcxMSKk5U21I97zim1aqEwKl7Abi+eEA2HAsKmIdrKaMdsLyFNjBP1MOags0xnQKFQtrv4kNnYPq0vDakUoALDtAwTfmoIsdthIZVtrVTSjOT9trRXSCUi7mzMgzWau4Sa3ILt6NEVJb7VOGbYw+rN/p6E9uq+jKXuQOC1nW4iZPMQ7dEm9g2ox8CIlDpTsiXnI52BcVRCAHZvuMajoh+9sd93Ei2tu/oqo9reduUeM3PjODPsnIYZfQ4uiOD1aIW+VR2jjlJubhQeIAi6x7KA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(64100799003)(82310400011)(186009)(451199024)(1800799012)(36840700001)(40470700004)(46966006)(4326008)(8676002)(1076003)(316002)(2616005)(336012)(8936002)(47076005)(41300700001)(426003)(36860700001)(83380400001)(2906002)(36756003)(16526019)(26005)(5660300002)(86362001)(40460700003)(478600001)(82740400003)(40480700001)(81166007)(6916009)(6666004)(54906003)(356005)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 16:37:18.9469 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e89efe5b-a757-4d23-96db-08dc0179eedd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5687
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
Cc: stylon.wang@amd.com, Relja
 Vojvodic <relja.vojvodic@amd.com>, Dillon Varone <dillon.varone@amd.com>,
 chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Martin Leung <martin.leung@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Relja Vojvodic <relja.vojvodic@amd.com>

For certain dual display configs that had one display using a 1080p
mode, the DPM level used to drive the configs regressed from DPM 0 to
DPM 3. This was caused by a missing check that should have only limited
the pipe segments on non-phantom pipes. This caused issues with detile
buffer allocation, which dissallow subvp from being used

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Reviewed-by: Martin Leung <martin.leung@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Relja Vojvodic <relja.vojvodic@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index 44ba1edb7f53..e4a328b45c8a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -276,7 +276,7 @@ static void override_det_for_subvp(struct dc *dc, struct dc_state *context, uint
 		for (i = 0; i < dc->res_pool->pipe_count; i++) {
 			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
 
-			if (pipe_ctx->stream && pipe_ctx->plane_state && dc_state_get_pipe_subvp_type(context, pipe_ctx)) {
+			if (pipe_ctx->stream && pipe_ctx->plane_state && dc_state_get_pipe_subvp_type(context, pipe_ctx) != SUBVP_PHANTOM) {
 				if (pipe_ctx->stream->timing.v_addressable == 1080 && pipe_ctx->stream->timing.h_addressable == 1920) {
 					if (pipe_segments[i] > 4)
 						pipe_segments[i] = 4;
-- 
2.42.0

