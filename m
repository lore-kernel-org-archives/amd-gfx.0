Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70172C04AA5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Aug 2022 20:01:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56E67C549B;
	Wed, 24 Aug 2022 20:01:57 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 580DE18A3F2
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Aug 2022 13:59:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZl319ab+qPOwiUsU+bkL854svotfKBVXlG4nEopbjkET/CQSxGN9ln9Ajl/nU27Cs6OKz9qSKDGMIhyhqBGo+oCdqv97aKMcMb8oeGalvq3cKra8jFbYS/FKdPw7V+nr7d30m6UiOvnyUMV3KU0WbEA04KHjfIbp7yiPnhXuHNbijaYf1dNcJYjE2lKvu1+zVt07vQi5Yq+2xWOeeyfmmmH4Ivzp26sR5TkLHMG1wRs46t/QCfCX0iMjEXoRyC2rQ+n65xU7J5/KDtPhOaHMrdJHdiXjZy/L92BtqzXNQFJK4GPQZtMJA7FraFA3tx0jFT3df42Qzq+NPc608W0JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAORAZBB8oekA4RBSAbcwZxje/mNApK0e3jwi5KwXnA=;
 b=lcn1QdHJKx4k7yWC3mHf//gErswLso0kxfbl6ntI6WKN7NKQPub54+xirlfhA3VWVnRW8yWKKJy4VzxdBizmWddxuOXCb5lNjN0LSl7AqtLq2sRRf9XEMYWtg73ukq6An0wV96lPoDd7cevuLPD95lhTceecHpdHnNjsthUIw3u2zDlziHD9uk6Wji/9YjVXL/SErIPdmAIwXNtDDHoxmyCz8tINTrgMaUWro3pFHx3hFChkik5JdJQgPpRCzlkGDzyZf4bk7KJkMAgW5qMC6x8rx7bru+TujCxWycFGHAjk0+TDyWN3dXs5cJHQ/u0eymkK1uz/70sJlFu+0D2qvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAORAZBB8oekA4RBSAbcwZxje/mNApK0e3jwi5KwXnA=;
 b=SrAwZWM2+F8qQJXQCCX65o10kDBghRpdBQaCmhKNVBEyqBAN9OwPNmtBwtEVO0N1YACViRatcDB6zq9hRgiYuSTcQ+zYD/cuijGXC5rjhaZdgn5dE0/itf6TAVurz12bK0mJnpjFusDrUBbl9Ep9WZ5z81IFY3vD4cwWmi/CjOc=
Received: from MW4PR04CA0050.namprd04.prod.outlook.com (2603:10b6:303:6a::25)
 by DM6PR12MB4137.namprd12.prod.outlook.com (2603:10b6:5:218::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Mon, 22 Aug
 2022 13:59:45 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::28) by MW4PR04CA0050.outlook.office365.com
 (2603:10b6:303:6a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.20 via Frontend
 Transport; Mon, 22 Aug 2022 13:59:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.15 via Frontend Transport; Mon, 22 Aug 2022 13:59:44 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 22 Aug
 2022 08:59:44 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 22 Aug
 2022 06:59:44 -0700
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Mon, 22 Aug 2022 08:59:40
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/14] drm/amd/display: Free phantom plane and stream properly
Date: Mon, 22 Aug 2022 17:57:48 +0800
Message-ID: <20220822095752.3750614-11-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220822095752.3750614-1-Brian.Chang@amd.com>
References: <20220822095752.3750614-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2aebce4-43c1-4b9a-247f-08da84469181
X-MS-TrafficTypeDiagnostic: DM6PR12MB4137:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9YNnL1YmM2VpESDafKdryP5D8pnWUYz5nh4Jk4FSfTAuB850dpeM6UISlQJmSrBkdFjf/BnhYLqV16xP7ZRU2D2Qgk43+oU0ENpEPDXqsFpgD4YBT0GHxsCDamdyBsilu0MgKY7XyqF5uFxGSeO3bF30ombQa9QkWGGTzqmiVFLzXvS5824WgyXWlKMjmtpACX26VlkGlWyCQCXak0RwQ4RSqRxxZslxpFXQcsyB7RQ7DLJk7RyH3wSruTic1/xmHMaE3cPd4JgvfqG3/IQYFwUCxEe3Wqyf7b5dvuUWEvswNNcwxLVn9wPt5ZzewFqgdRxI8stKiTv9+s4PZwurymWvQd7qWEb5zvy+Ae7XjNYI3sXB2D9GwbTtK0FWth5QUDliauEwtQ3+PpLAz8WApyt6OA0UsJRJKq0rxZ4wv/r+h386K20tL+l7Ua0qnX170yuqho4abmPxIC866a2pAuHO3nmEOOVME69FMqpAjOXGzos73lcgWFBDDgSXaCl9q1W6WKBYrPBLq+FcaXS1zBJ0DF6jxAO5v6KXeegWkUGkNEArPlD1krC97b20Bt8eXx9txZ52N+fWpxxrA4gWYV9trh4fLcbKidL9zpoY2JwQ7ttyx+jQsQv45i96R4jLhECVW2V0nFgjUL0PmtHm10qYvP3pk7xmi5AUlbPy98qyIrzoxHRi2mPolf4frCbyHl6TMx51Sd1aDz3S+Ye9rZt2JAyKSmbz7gQp3wkY/59Cr6Mgaoub9vfGkru/HwaU1Y5b6bPiIw+k/zTVkU/523AjYIyLIY6BxBTxpeZAqRTt/oL877yE5C2HCwoQOlyVL2rI6QHU3HDxVfsm1YAceA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(376002)(136003)(346002)(40470700004)(46966006)(36840700001)(47076005)(426003)(26005)(2616005)(7696005)(336012)(2906002)(1076003)(186003)(356005)(81166007)(40460700003)(86362001)(82740400003)(36860700001)(82310400005)(70586007)(70206006)(41300700001)(5660300002)(316002)(8676002)(36756003)(6916009)(54906003)(478600001)(40480700001)(8936002)(4326008)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 13:59:44.8364 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2aebce4-43c1-4b9a-247f-08da84469181
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4137
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
Cc: stylon.wang@amd.com, Brian Chang <Brian.Chang@amd.com>,
 Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
Refcount is incremented on allocation and
when adding to the context. Therefore we must
release the phantom plane and stream after
removing from the context.

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn32/dcn32_resource.c   | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index b8a9606863f8..194d7dbdbcd7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -1729,13 +1729,26 @@ bool dcn32_remove_phantom_pipes(struct dc *dc, struct dc_state *context)
 {
 	int i;
 	bool removed_pipe = false;
+	struct dc_plane_state *phantom_plane = NULL;
+	struct dc_stream_state *phantom_stream = NULL;
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 		// build scaling params for phantom pipes
 		if (pipe->plane_state && pipe->stream && pipe->stream->mall_stream_config.type == SUBVP_PHANTOM) {
+			phantom_plane = pipe->plane_state;
+			phantom_stream = pipe->stream;
+
 			dc_rem_all_planes_for_stream(dc, pipe->stream, context);
 			dc_remove_stream_from_ctx(dc, context, pipe->stream);
+
+			/* Ref count is incremented on allocation and also when added to the context.
+			 * Therefore we must call release for the the phantom plane and stream once
+			 * they are removed from the ctx to finally decrement the refcount to 0 to free.
+			 */
+			dc_plane_state_release(phantom_plane);
+			dc_stream_release(phantom_stream);
+
 			removed_pipe = true;
 		}
 
-- 
2.25.1

