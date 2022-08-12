Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2363C00140
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Aug 2022 02:14:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E741AFB7A;
	Sat, 13 Aug 2022 02:13:28 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D39F2ADEAE
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Aug 2022 02:13:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfVqYUfiXvpsVJUhnj3JAdr0sF3UKbeD7AcIb2gMt+s15p4Na2bhNCfOjICasW9m09CvAZ2O+N3hjPVdO2A/ggFLG+7jvzjWinFrywPC/UDY7RjPUKFOk+Ibh5FhVZ/mZ6fjxBJXxpK0MOSFDJOJcKpALMeJZ/D3U3V/zp0kq+fktDZ15Vy1Psf5Yk+P1kcCO7d3A4A+FkCbcvDM5rcx3yfcSp57F2q3VmpAV1rZIy189J2qDZWq1EdOgDXlwpMeFuxN3+nUgljToj2/IePCAjh41SbAzRwz4AF/zjD4+NMllbrRQ3h2C72q0pveWRwGi+UoCA/qu+5V/GROQQSzPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggUsKx6DFZ+ZpLT7zbA5jIKQSzlmxzExqS2G3EkTu/s=;
 b=lyNIuCWzF2D0dg5OQgQTTPMZq9L8mW3Jery4rcrgxNrG9k+Q0pW6AN2x5pv9z4lSWYxa71iinSbD8a5PpiWmmnUFtKc4ZJbMnxBw9DlJZegyndgEKCIpHZy7YhLinPZqmPI5YWukan7/0qC+Yu9VzNHhz4XAwUxe/d6XcGNW58WC7xIItv661WVu4opsTs77sxClk2mMeIG1B9hpgew7J/XkNGVu1G67A0AbbrQ6ax2/Oox8WqxYwJJhkwZ6vypHBav/pWA/5nyDyhfSSOD3W3Tybt19l1rQxgU3eHdkzzWaBb/sClUg90di7R9e8Koiu5pRsyIu714q5OwZ1XsdrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggUsKx6DFZ+ZpLT7zbA5jIKQSzlmxzExqS2G3EkTu/s=;
 b=FEOBJvaNyj9w8lVRQAWGeS2pTpQWAmS1phOPjSiD3deq0330b3Z5+6u2MdkxnAl4KXtRe5KQvVt9QlS18HkTM/jxMfweyDyTXYrwxhoAA7A6oU1faj/l61NsmjntBI7CoPmidFfi9j1VG3OkePjDtSzCDJkBjZ5G4uE4i41DFE4=
Received: from BN0PR04CA0009.namprd04.prod.outlook.com (2603:10b6:408:ee::14)
 by BN8PR12MB3553.namprd12.prod.outlook.com (2603:10b6:408:42::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Sat, 13 Aug
 2022 02:13:04 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::ce) by BN0PR04CA0009.outlook.office365.com
 (2603:10b6:408:ee::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Sat, 13 Aug 2022 02:13:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Sat, 13 Aug 2022 02:13:04 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 12 Aug
 2022 21:13:03 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 12 Aug
 2022 21:13:03 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 12 Aug 2022 21:12:59
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/14] drm/amd/display: Fix plug/unplug external monitor will
 hang while playback MPO video
Date: Sat, 13 Aug 2022 06:12:16 +0800
Message-ID: <20220812221222.1700948-9-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812221222.1700948-1-Brian.Chang@amd.com>
References: <20220812221222.1700948-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9114fdc6-1d5f-4033-f319-08da7cd15ae9
X-MS-TrafficTypeDiagnostic: BN8PR12MB3553:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7kI/gBdVMYkJPHiOrWZVRy1RRsRINdTuqiy6pB58Un0M4cvVe1IGWmofFBRcMoFQ5BG5YY4AEKRuujYgFLLFIQDIwksccQs0scxVeNKUVCKsr79Tq6nfxv3jCD7/PdqtHUUVthVMAUUm9VC7pOLGIJM893q2OlqxdF3c50KJFrRfcSu95gtSxaXGi6MwFnIbBxx1aQExwlphS4Wg2xpWs6hYmWbhQGysAWf/hcqxS5JT0M1ftX+YNPdhjQ+xcfFZZJBuVXHar6WAuyN2Nxo4EJ7H8YAjLWqHgsoFKJNFAK08LPUf0zJFbt+V6eNji9euKTU9X5Yej9xSc/l7KSbhz87O/Pg3xPq93WadJs9ooXX/3b2j5rDiQArDhp6iW0Q5XxvWCHh4hfGbjoWr/re4WHzR6G8DtzZHTY59Vtx1yT/Lqhc3GJQwwzdSS5lz7SR5tO7ExH5B1c7n3rhaCnE+1y68enO+TLKXY3+hX7xZMKbMpqffL/nb8CeWfCh9LXHve5OXm6x4o9EeobMpwYCJPfOI1rqGNfMmekaiPxumlbZPqU8SFeCwLCD/k2EGu/Bf3R2bHK7yWa3TBjgLI7yEbW1pYhRvO7pkCahSooZVgREw2D5Vjeznx0CllBVMZqA6egZPVcQHYIVfcgmgDRe94M6plyJdiFfusP2TtdZEZGZ8uqhfQTHV2RwBk38hVB4hTCgNlsz6SDwxi4nc8zHAJKycRLMQZChhDjsP66D3M6u7oqBnAR2SOtdFkHQgivz5zPc9qYFMmHo/PUB+e5mafOF1vdv32iaE9qDpIGTLOPvuYIPHrIGC6NbXuryZS2cnNHDapGmu/FC151GN58VYZAxc1++InLGnmtxR/lD5TSA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(396003)(39860400002)(376002)(136003)(40470700004)(46966006)(36840700001)(356005)(83380400001)(47076005)(81166007)(5660300002)(82740400003)(7696005)(40480700001)(6666004)(26005)(2906002)(186003)(8936002)(8676002)(36860700001)(6916009)(40460700003)(316002)(36756003)(41300700001)(70586007)(70206006)(4326008)(336012)(478600001)(1076003)(426003)(2616005)(82310400005)(86362001)(54906003)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2022 02:13:04.1012 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9114fdc6-1d5f-4033-f319-08da7cd15ae9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3553
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
 Tom Chung <chiahsuan.chung@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tom Chung <chiahsuan.chung@amd.com>

[Why]
Pipes for MPO primary and overlay will be power down and power up during
plug/unplug external monitor while MPO video playback.
But the pipes were the same after plug/unplug and should not need to be
power down and power up or it will make page flip interrupt disabled and
cause hang issue.

[How]
Add pipe split change condition that not only check the top pipe pointer
but also check the index of top pipe if both top pipes are available.

Reviewed-by: Sun peng Li <Sunpeng.Li@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index b3e7361cd158..0fade2f1efb5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1077,8 +1077,15 @@ static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
 		struct dc_stream_state *old_stream =
 				dc->current_state->res_ctx.pipe_ctx[i].stream;
 		bool should_disable = true;
-		bool pipe_split_change =
-			context->res_ctx.pipe_ctx[i].top_pipe != dc->current_state->res_ctx.pipe_ctx[i].top_pipe;
+		bool pipe_split_change = false;
+
+		if ((context->res_ctx.pipe_ctx[i].top_pipe) &&
+			(dc->current_state->res_ctx.pipe_ctx[i].top_pipe))
+			pipe_split_change = context->res_ctx.pipe_ctx[i].top_pipe->pipe_idx !=
+				dc->current_state->res_ctx.pipe_ctx[i].top_pipe->pipe_idx;
+		else
+			pipe_split_change = context->res_ctx.pipe_ctx[i].top_pipe !=
+				dc->current_state->res_ctx.pipe_ctx[i].top_pipe;
 
 		for (j = 0; j < context->stream_count; j++) {
 			if (old_stream == context->streams[j]) {
-- 
2.25.1

