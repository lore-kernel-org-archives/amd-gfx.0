Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46292C61DA4
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Feb 2023 15:25:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B139210E7F0;
	Fri,  3 Feb 2023 15:25:33 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11E8D10E7EF
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Feb 2023 15:25:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JyNhB4DGq+0TCZRzYkp1U5ZxX8kDqe2cKttYFANog77dyQQVTuNRmJDbToUFEVWEQitdxYdFXA21VYBighmt7r7vhGxoYx/7ZhbJEhWhZteG1JfT1agK4+Av2ULZ1oMMtDFIsW4+CO8KeKPzssJBpxjPXeVdbUGoCIwZr0F54P4xLO4Ko44URxYqDeCZv/drf2UQX5Y8bb/oe814bGd8kkCpNkbqMJ8nzgvU/0ElSVcufC3vd1J0D7l+iLTKl2MVScpD3Wh7NWXBrZFwOaDgJQ9ZAVMV5r6rtjVA1sFn5bSeZRO3+RPMAq0Ll72PQ1jJOmpUVsfeSd7iqvp59ABZNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gZaBKFLbLQ19Ykuw5JWI5Xi0BtY2ogLjkR0S6q953M=;
 b=RSW1u++MLCBYG4+vLjwLVkpQZZnPlz7FQ/5wuYfTIGr9uWa/Z8aZLOpREQa41QbNgyuLyVJsYxQXBKJlBlLVPv9EZ6qnDjCIcSwWNTiKE0cKASTsY79tanpo0fNBtyfW1NRWb+amNKyYBZnYLsEW7ysUocYMRkyK5cmiCSwfz1U/BvX4OQB2Z86Z9Lxt4VvWl1b6LJv6M4b52tQe0YB5CO+UgsC9bm0i2B99kotfnCzXFhB0yV1vA7kZ4nCtqpJovVr6Mi4764Aoi8pDGAFHtgOC+rNqO0yVsa/wDZLp7gO1Fe2A0jBBngqofMOnYFwQEzjUe4gwPO9MTAlPzwfH6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gZaBKFLbLQ19Ykuw5JWI5Xi0BtY2ogLjkR0S6q953M=;
 b=Pqs3DSWwT1rZIYuFNPjkAzuc6bqhlQy8Kj/myMYF9xS3LgEokQe0zb74fzF8BEvuYUEGNzIQG9LpNoK8Gr9AIg29dac3iRQ7T96OFPdg16YWE3uA1Yr9Ln/cY2G00Gp48FSKd2O4lmIWB+XwqEzHszoJKcuWM9sSmVVOzFemP/U=
Received: from MN2PR03CA0005.namprd03.prod.outlook.com (2603:10b6:208:23a::10)
 by MN2PR12MB4360.namprd12.prod.outlook.com (2603:10b6:208:266::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31; Fri, 3 Feb
 2023 15:25:29 +0000
Received: from BL02EPF0000C407.namprd05.prod.outlook.com
 (2603:10b6:208:23a:cafe::9c) by MN2PR03CA0005.outlook.office365.com
 (2603:10b6:208:23a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31 via Frontend
 Transport; Fri, 3 Feb 2023 15:25:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C407.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.17 via Frontend Transport; Fri, 3 Feb 2023 15:25:29 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Feb
 2023 09:25:26 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/12] drm/amd/display: Fix null pointer deref error on
 rotation
Date: Fri, 3 Feb 2023 10:24:44 -0500
Message-ID: <20230203152452.1441747-5-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230203152452.1441747-1-qingqing.zhuo@amd.com>
References: <20230203152452.1441747-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C407:EE_|MN2PR12MB4360:EE_
X-MS-Office365-Filtering-Correlation-Id: 236547d6-daa1-4f05-97bf-08db05fae1cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8tO90ONSP5F1N45D15G54+tNkzQKbXO/8kAgbGXq5CKU0MpPH51qsyBdXoZtnwvn4lwYn+rvsgL+9+A01PZYBWixMZQ9+7a/bQIfJO6PcZ+A4tx4WAl1HIBW4Q4Mh91NGqDAovO5Y/mMPjmvZ79PBkn0j7pgvQdeWgQwhN57sXQ2ANBIbwg4lmJrqsXKoy11+06sxCJIrCpU5PeJjuTUoNulWJR0jap/6j2jbRsF2C4tPDwF2EvkL+rIuEZVfn6IcjG6d/wKifF1BJikM9a5tzI3F789JRs/I0V6iVr1uFwJ22dQy/l7aYFA5WDv/FmxWAUEi+zkKV0r+q7Pvhr5xfoP2qVvk1YF0dVEIAMKqAvSyNvLjvy8SGnjaef27ZBTvU5naXTNkozo0GS1u8Y0FOvtMbiq2fUIX+l7SXm87ifCbb6a+HZhPcVpVta1GCWHpOTATQdugPb15E11L8sExl2OZLS4KFhV5pppbD9KfsQPQFD2GBaT7vYlVeB1JVsl++iCbh5XkJNsWwX/T5aNFcUUanjyOr4dm8g24Zr3IO3yFGmxcmlIie1SF8E9oAwwa24dP8cU5ZjaDie1r9jqfF+A58XmE2+msSzzfobr2d6G16zCRhhE6bd/sgNmXjv5mnVNN9IrNNxC6iv0lSMBeRWJxm8dZQoncfT80cz7m4C1QFRhjiIc4tI9iNpkQP+jkG/zh8AZ6+cPy9Y9dfV5WbNviB8luPnnrg85rKz4obE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199018)(36840700001)(40470700004)(46966006)(8936002)(5660300002)(41300700001)(40480700001)(86362001)(82310400005)(36756003)(356005)(81166007)(36860700001)(44832011)(82740400003)(40460700003)(2906002)(47076005)(426003)(54906003)(2616005)(478600001)(16526019)(186003)(26005)(8676002)(70586007)(70206006)(4326008)(6916009)(1076003)(316002)(83380400001)(336012)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 15:25:29.0298 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 236547d6-daa1-4f05-97bf-08db05fae1cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C407.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4360
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
 Samson Tam <Samson.Tam@amd.com>, solomon.chiu@amd.com,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why&How]
Fix the null pointer dererefence error when rotating the monitor on
a DCN32 variant, which causes a call trace like:

[   42.469548] RIP: 0010:dcn20_program_front_end_for_ctx.cold+0x68/0x435 [amdgpu]
[   42.477140] Code: c1 4c 01 e8 48 8b b0 f0 01 00 00 e8 b6 1c 4c f9 42 f6 84 2b a0 0a 00 00 02 74 30 4d 03 ac 24 68 04 00 00 49 8b 85 f0 01 00 00 <83> b8 50 06 00 00 02 75 18 49 8b bd e0 02 00 00 48 8b 07 48 8b 40
[   42.496225] RSP: 0018:ffffaf744326f6a0 EFLAGS: 00010282
[   42.501539] RAX: 0000000000000000 RBX: ffff948765180000 RCX: 0000000000000000
[   42.508797] RDX: 0000000000000000 RSI: ffffffffbaea5329 RDI: 00000000ffffffff
[   42.516055] RBP: ffff948701674400 R08: 0000000000000000 R09: ffffaf744326f538
[   42.523312] R10: 0000000000000003 R11: ffff948a1d33ffe8 R12: ffff948708700000
[   42.530569] R13: ffff94876e901180 R14: 0000000000000002 R15: 0000000000000001
[   42.537825] FS:  00007f1c7c04a5c0(0000) GS:ffff948a05a80000(0000) knlGS:0000000000000000
[   42.546055] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   42.551898] CR2: 0000000000000650 CR3: 0000000127dd6000 CR4: 00000000003506e0
[   42.559155] Call Trace:
[   42.561645]  <TASK>
[   42.563782]  commit_planes_for_stream+0x8b1/0x1410 [amdgpu 2059945d14fb66c82032430b723fcb84d8250d46]
[   42.573298]  dc_update_planes_and_stream+0x3f9/0x9f0 [amdgpu 2059945d14fb66c82032430b723fcb84d8250d46]
[   42.582986]  amdgpu_dm_atomic_commit_tail+0x19be/0x3270 [amdgpu 2059945d14fb66c82032430b723fcb84d8250d46]
[   42.592944]  ? vsnprintf+0x35e/0x550
[   42.596593]  commit_tail+0x94/0x130
[   42.600146]  drm_atomic_helper_commit+0x112/0x140
[   42.604931]  drm_atomic_commit+0x96/0xc0
[   42.608922]  ? drm_plane_get_damage_clips.cold+0x1c/0x1c
[   42.614326]  drm_mode_atomic_ioctl+0x97b/0xb90
[   42.618848]  ? drm_atomic_set_property+0xb40/0xb40
[   42.623633]  drm_ioctl_kernel+0xc9/0x170
[   42.627694]  drm_ioctl+0x22f/0x410
[   42.631157]  ? drm_atomic_set_property+0xb40/0xb40
[   42.636031]  amdgpu_drm_ioctl+0x4a/0x80 [amdgpu 2059945d14fb66c82032430b723fcb84d8250d46]
[   42.644537]  __x64_sys_ioctl+0x90/0xd0
[   42.648355]  do_syscall_64+0x5b/0x80
[   42.651992]  ? do_syscall_64+0x67/0x80
[   42.655808]  ? exit_to_user_mode_prepare+0x1e/0x140
[   42.660773]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   42.665913] RIP: 0033:0x7f1c7f31aaff
[   42.669550] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <41> 89 c0 3d 00 f0 ff ff 77 1f 48 8b 44 24 18 64 48 2b 04 25 28 00
[   42.688635] RSP: 002b:00007fff29eca1a0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[   42.696334] RAX: ffffffffffffffda RBX: 00007fff29eca250 RCX: 00007f1c7f31aaff
[   42.703591] RDX: 00007fff29eca250 RSI: 00000000c03864bc RDI: 0000000000000009
[   42.710848] RBP: 00000000c03864bc R08: 000000000000000e R09: 000000000000000e
[   42.718104] R10: 0000000000000007 R11: 0000000000000246 R12: 00005643f0991d70
[   42.725361] R13: 0000000000000009 R14: 00005643f22d0c50 R15: 00005643f0a74550
[   42.732621]  </TASK>

Reviewed-by: Samson Tam <Samson.Tam@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index c657f34df0d3..da6d776e2f44 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1833,15 +1833,17 @@ void dcn20_program_front_end_for_ctx(
 	/* When disabling phantom pipes, turn on phantom OTG first (so we can get double
 	 * buffer updates properly)
 	 */
-	for (i = 0; i < dc->res_pool->pipe_count; i++)
-		if (context->res_ctx.pipe_ctx[i].update_flags.bits.disable
-				&& dc->current_state->res_ctx.pipe_ctx[i].stream->mall_stream_config.type == SUBVP_PHANTOM) {
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct dc_stream_state *stream = dc->current_state->res_ctx.pipe_ctx[i].stream;
+
+		if (context->res_ctx.pipe_ctx[i].update_flags.bits.disable && stream &&
+			dc->current_state->res_ctx.pipe_ctx[i].stream->mall_stream_config.type == SUBVP_PHANTOM) {
 			struct timing_generator *tg = dc->current_state->res_ctx.pipe_ctx[i].stream_res.tg;
 
 			if (tg->funcs->enable_crtc)
 				tg->funcs->enable_crtc(tg);
 		}
-
+	}
 	/* OTG blank before disabling all front ends */
 	for (i = 0; i < dc->res_pool->pipe_count; i++)
 		if (context->res_ctx.pipe_ctx[i].update_flags.bits.disable
-- 
2.25.1

