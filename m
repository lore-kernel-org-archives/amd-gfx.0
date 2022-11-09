Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D6C7C433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Nov 2022 06:17:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 985FC10E581;
	Wed,  9 Nov 2022 06:17:36 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 321EC10E581
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Nov 2022 06:17:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9SRlI4+/288L+uK0UUtzIGtvAdk0z0+2b3tIS5ZYBRVpw5T4oQSNbhTxjpcNg4lN/xqVBd3SFOVSLBp9MmR5lPFi75mbmk1bwMu9r9uQSqejNr1wrX+A+tfTK/zJXjwWSkt8GXTUfMPmFH6dVO6XYpHUBSvhFR3oi+wHpIeVUvtIGiGyM7JKg3bd1hDMKY/WeOPjQfzc4t+Evril2hJTiprCVkW2Ndif9Ht4BE2DzWkqLJfg97MUwNnDpi8py0e8JlyE5K8FLqQykIx8RSFRxyr+uc/LFMX86UrtPmYbjoZcemnE3s9+TmuqDfUC4iTdEWi8D54g/R9piubBVxukQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIiTSBtnNgmWCJql6H5PVyJOW6FaRDaaNjADcSSZAc8=;
 b=X8sVch5BHUmHK6ZMEdnD8n6SFKHvhDAg3PUvhA13IeHZdKBU0M0KFyccY8m2jgVuyhEXDsMcLp35G3QH9KuJH+FZszKCufixaEjke/iQAwcdeCBTQOpZwOc2/T7uUPYa75SFQEGDWvrFxqXlZoJ5bEwscSqe1gk3K2aZl0b16CbSLsOvjBEsUpOdfXt9KZKS7uHRiY3QpFX57Ks/ax+IGu810B5g00iQ8/iiHK4pvi1K8bVEkc9wJ9to+LgoDdZUgTP9yWvkb40//J0l5hJeADSv5xYXNynC2jE2jAgTsT0MBHDfcY0LeiSze/CRXOhfh7vj44Ylpb5xlfRiAuWTRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIiTSBtnNgmWCJql6H5PVyJOW6FaRDaaNjADcSSZAc8=;
 b=dexLdVmx6jTmV5wTPutEWk729ah1xlFBCfDqYWhkJlvba1WV5qPY+mvwvHK0UDvd+WdID29Io10t0tqswBxZzGtBkCcloleaHJQUTAs6GAA1DQXukULciG4tCHH6mXqvLEv+pGtFUaeefWt89mQMgZ2g4NEwFP4ZFri8WTJHtLQ=
Received: from MW4PR04CA0214.namprd04.prod.outlook.com (2603:10b6:303:87::9)
 by BL1PR12MB5351.namprd12.prod.outlook.com (2603:10b6:208:317::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 06:17:30 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::c) by MW4PR04CA0214.outlook.office365.com
 (2603:10b6:303:87::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27 via Frontend
 Transport; Wed, 9 Nov 2022 06:17:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 06:17:30 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 00:16:36 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 22:16:18 -0800
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 9 Nov 2022 00:16:13 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/29] drm/amd/display: Fix calculation for cursor CAB
 allocation
Date: Wed, 9 Nov 2022 14:13:06 +0800
Message-ID: <20221109061319.2870943-17-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
References: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT023:EE_|BL1PR12MB5351:EE_
X-MS-Office365-Filtering-Correlation-Id: 65228c8d-f191-47b4-07de-08dac21a1516
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /YM0e/ofN/e5R5pxH43h0L+ZC2jkfT1Tv5ZhPI0EPZ4C+AisA5NkcQdXjwssRw6VcGgXK0VuQMNjOUG7r4VUMQCtV0vn6u2xX0ppKQP1WCNUaAC6BXK+9WCctck/pkEFlBM91EX/jDDa2N5T9ZBjC/8oqfrLqw7qR4anUxhVB16L2IfaM7irloR/dALnPyFdyLzTi6Wzw63h1JaKy0VppzZeE8RTxfccFSr6HCfvoaXJF1OjrfcjL4N3Fdh9dLHstHRGxJy2Cl3xhrLYiq+YZI/6S+xlFuoyPev+XwlMQri/weH9w32+EMjeyyv3IleywYrW0eT6vCmexeNGzIS9RQuU3OEiXmASv7N4EJ8XB0ZE6l2nQ0VUuInLTYfQM+TlXECgPeeC+BqNnauGdxhyFI/UdBFuSfALR9d8GbS4Scc9sNCtWmBGvJx0NYxIHLjrf1sxgo9cGn2IEeNwNZH25mDqv7wlQiDEBRJ1A5sazz31ZLvveLN0kdKSBdS+ravYJRDvMSghIazXghOlTBEgNqkKOreVo/uXl6n8Js0uRbkKHQCw12poLKr1P2PKU/hhf+w/c6I4Xpq9/Askz64JFsZnbz7Z0gL5uCUqn55yE7pj/0c/q4XhLLV1xkF3QvwZbE5TdoJkWDOJKyjOlJPL83crc4c2xugYgcNi+CqzvygNL1+dkbLpLSs2iNe382+dC3y4qdT3C8RvQJk9Er34LhfRUaqTKEbxsPR1/kfGToWbRol3nkRjbgzX2BMTe1cl7duulXVWoNZaE/RUEx6Bx6v5pDMTTf0Ad5hS75I+OQ7pZMfD8HmaSS7/f2w/WlV+
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199015)(46966006)(40470700004)(36840700001)(4326008)(8676002)(70206006)(70586007)(82740400003)(316002)(7696005)(40480700001)(336012)(36860700001)(40460700003)(83380400001)(2906002)(47076005)(41300700001)(86362001)(26005)(36756003)(186003)(1076003)(2616005)(426003)(5660300002)(8936002)(82310400005)(478600001)(356005)(6666004)(54906003)(6916009)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 06:17:30.3487 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65228c8d-f191-47b4-07de-08dac21a1516
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5351
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 George Shen <george.shen@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <george.shen@amd.com>

[Why]
The cursor size (in memory) is currently incorrectly calculated,
resulting not enough CAB being allocated for static screen cursor
in MALL refresh. This results in cursor image corruption.

[How]
Use cursor pitch instead of cursor width when calculating cursor size.
Update num cache lines calculation to use the result of the cursor size
calculation instead of manually recalculating again.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index c8fb28f09de3..7eb47ea9d4bb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -283,8 +283,7 @@ static uint32_t dcn32_calculate_cab_allocation(struct dc *dc, struct dc_state *c
 			using the max for calculation */
 
 		if (hubp->curs_attr.width > 0) {
-				// Round cursor width to next multiple of 64
-				cursor_size = (((hubp->curs_attr.width + 63) / 64) * 64) * hubp->curs_attr.height;
+				cursor_size = hubp->curs_attr.pitch * hubp->curs_attr.height;
 
 				switch (pipe->stream->cursor_attributes.color_format) {
 				case CURSOR_MODE_MONO:
@@ -309,9 +308,9 @@ static uint32_t dcn32_calculate_cab_allocation(struct dc *dc, struct dc_state *c
 						cursor_size > 16384) {
 					/* cursor_num_mblk = CEILING(num_cursors*cursor_width*cursor_width*cursor_Bpe/mblk_bytes, 1)
 					 */
-					cache_lines_used += (((hubp->curs_attr.width * hubp->curs_attr.height * cursor_bpp +
-										DCN3_2_MALL_MBLK_SIZE_BYTES - 1) / DCN3_2_MALL_MBLK_SIZE_BYTES) *
-										DCN3_2_MALL_MBLK_SIZE_BYTES) / dc->caps.cache_line_size + 2;
+					cache_lines_used += (((cursor_size + DCN3_2_MALL_MBLK_SIZE_BYTES - 1) /
+							DCN3_2_MALL_MBLK_SIZE_BYTES) * DCN3_2_MALL_MBLK_SIZE_BYTES) /
+							dc->caps.cache_line_size + 2;
 				}
 				break;
 			}
@@ -727,10 +726,7 @@ void dcn32_update_mall_sel(struct dc *dc, struct dc_state *context)
 		struct hubp *hubp = pipe->plane_res.hubp;
 
 		if (pipe->stream && pipe->plane_state && hubp && hubp->funcs->hubp_update_mall_sel) {
-			//Round cursor width up to next multiple of 64
-			int cursor_width = ((hubp->curs_attr.width + 63) / 64) * 64;
-			int cursor_height = hubp->curs_attr.height;
-			int cursor_size = cursor_width * cursor_height;
+			int cursor_size = hubp->curs_attr.pitch * hubp->curs_attr.height;
 
 			switch (hubp->curs_attr.color_format) {
 			case CURSOR_MODE_MONO:
-- 
2.25.1

