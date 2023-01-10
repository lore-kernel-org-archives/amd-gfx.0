Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB8FC54EBC
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 16:59:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1725410E621;
	Tue, 10 Jan 2023 16:59:03 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2069.outbound.protection.outlook.com [40.107.95.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8470C10E621
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 16:59:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJbEmudTlUNo4y7NORuMUQR8Nln4rTRIsi93KY5pg4lVaGHB7sLt5fcgCPeLVstdczTvxaIDRE1dsFUv6avB6nYkp9bhwOFPH9re8ufIF8nbCIeTwugpT5Ir8oHMvDtVt/3AMwwTNFf/y9FC2kSiBDHPH43/FQlCb2aKqkTjFgzvggAhe6pL0GtSJIzYSxWrf2QnSbWCe/Cy/ykvaGoJZRjYmT3BWUQyxNOkYs/COtdZCMnNCI1g2zr0PQVSmsgZWDyAqHa3bUIA5/bGSQu/oSccnBMNXnF0AwEHIe9llj2U8GD1xasFD51hlZF8dReztCMO/pwVBKHChH9OFSnzJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHB+HGtphnw5O28+lU0TRY4Q4joHVHvLUPmt1L/0IHs=;
 b=BsW1Zp2Fip/MGct68HphXPqgR4g+NAI+FMg7+pGKSjT3RblrNnWRkoFhziqb6NNvtXp9nEOFIvBVKiBfI12scw6Id5QxE2YvN9ammzt+W5EZ+2UX0vE202fo4aKLZ+YV9DKhgLMR+dfESQQuryw4rB1HnA7fQgA/jizKf7vQ5JDUP8UPKgroJHEAjU8AqzGQ7EClObK+EwqhdyB65uQ5JyXWzcWyLUEEJVU0hLFNLmUtufECIl/cJhCLAxfquLQlidRd6UQoCkp8PLqlYpDWd2YjcFL5FJla3A6xDcEq0dn6lzX7cUE6taAuT1jQQSy+DNiEQlP5raid3LM2ICNDGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHB+HGtphnw5O28+lU0TRY4Q4joHVHvLUPmt1L/0IHs=;
 b=SBYWoFqL+NicV0FOx6tf/mZH/CbQEan858cOIoVtlSGT6m4tFNAXFJEU7E7Y947BoJaDStGp43sNY6uSdsXq7u1jVwfL+y85KQimhQ5O5JjQJ/cc/sPrRTiHCypz9e0mMpcbpSsQb4/SWi+CetKAGa5sxpsW/+W8wW5b0HA7+m8=
Received: from MW4PR03CA0019.namprd03.prod.outlook.com (2603:10b6:303:8f::24)
 by DS7PR12MB5983.namprd12.prod.outlook.com (2603:10b6:8:7e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 16:58:59 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::d1) by MW4PR03CA0019.outlook.office365.com
 (2603:10b6:303:8f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Tue, 10 Jan 2023 16:58:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.12 via Frontend Transport; Tue, 10 Jan 2023 16:58:58 +0000
Received: from atma-again.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 10:58:56 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 34/37] drm/amd/display: Account for MPO planes in dcn32 mall
 alloc calculations
Date: Tue, 10 Jan 2023 11:55:32 -0500
Message-ID: <20230110165535.3358492-35-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
References: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|DS7PR12MB5983:EE_
X-MS-Office365-Filtering-Correlation-Id: ae5dc67b-f039-478e-abb4-08daf32bf7a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BeIVqhTLTyznLBQY38rO6CUt1N20Z1miW6M9sBYjtGm9pryf1YBq/DNmBSaNoryKufXXVPV1cLYDHXt2pAvLjfJFD3rFCCDLakG81Ma9TgmN7M7GgnEkjVjeY2Egh/01vL9HyEN2JzZEND0B099JUiyU73LLp5FBYcPHp1ZyLr8gtXcCnHl2M22UB8aEC4VwYK6vw65Wq9BvcdaBD+6yujc4lt0bWlwGhmyMS0ooZ6faLs13FCFNfn9cawHhEnDC4470m5/qnSMRfDEb5tR6lKotwxWFxU7sf6ap7jATpw77jasCVEWbarRZ3FP6iY6f6ufChbk+X+koOuH7TzMpqIBxPX0lurkH/nYNPQyzka7uWiulq98B9a9UKYJa3Or3rjcQqxD6Q42GilmpS/6CCz2LNHA3CboplVFZufCZlGTJUa/LIEhhlmBU3zlGhFcSAAYKS+bgMYmkebouzio0jjk5DbAsCpMr92i3hijgjMw6qcy2XXCDvMVl+geL3hNnFg3kIOldNg4egv3D2+Ip0E5U9XKsaCD6iEn9pwp/QIHm8OrnklE3ADceik+/wRnNjlt8QPyxSHmatkw9zllqv6N1H3QMUce4NUs2Tm0AF2Vlo6fttIQ5I2s7H4OXgr+D7NfyDrFfrHRqxLQdTaX5as5t6CXZaJ7s4nNGf8uzsVIB00zBNNrcfMh906xDwVFJbnUrP9yWZQ6cDCyPZhUwlXG/CIfnznXCaZ4bUlWm/a8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199015)(36840700001)(40470700004)(46966006)(36860700001)(82740400003)(6666004)(81166007)(2906002)(356005)(478600001)(2616005)(1076003)(16526019)(26005)(7696005)(186003)(5660300002)(316002)(40480700001)(83380400001)(8936002)(82310400005)(36756003)(86362001)(40460700003)(47076005)(426003)(41300700001)(8676002)(336012)(54906003)(70586007)(4326008)(6916009)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 16:58:58.8953 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae5dc67b-f039-478e-abb4-08daf32bf7a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5983
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
Cc: stylon.wang@amd.com, Dillon Varone <Dillon.Varone@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, Nevenko
 Stupar <Nevenko.Stupar@amd.com>, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY?]
Cannot only consider the MALL required from top pipes because of the MPO
case.

[HOW?]
Only count a pipe if it fits the following criteria:
1) does not have a top pipe (is the topmost pipe for that plane)
2) it does have a top pipe, but that pipe is associated with a different
   plane

Reviewed-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 5b928f3b719d..7feb8759e475 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1356,9 +1356,10 @@ static void dcn32_calculate_dlg_params(struct dc *dc, struct dc_state *context,
 		context->res_ctx.pipe_ctx[i].surface_size_in_mall_bytes = get_surface_size_in_mall(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx);
 
 		/* MALL Allocation Sizes */
-		/* count from active, top pipes only */
+		/* count from active, top pipes per plane only */
 		if (context->res_ctx.pipe_ctx[i].stream && context->res_ctx.pipe_ctx[i].plane_state &&
-				context->res_ctx.pipe_ctx[i].top_pipe == NULL &&
+				(context->res_ctx.pipe_ctx[i].top_pipe == NULL ||
+				context->res_ctx.pipe_ctx[i].plane_state != context->res_ctx.pipe_ctx[i].top_pipe->plane_state) &&
 				context->res_ctx.pipe_ctx[i].prev_odm_pipe == NULL) {
 			/* SS: all active surfaces stored in MALL */
 			if (context->res_ctx.pipe_ctx[i].stream->mall_stream_config.type != SUBVP_PHANTOM) {
-- 
2.39.0

