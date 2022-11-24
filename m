Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C8ECC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Nov 2022 21:14:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8605110E278;
	Thu, 24 Nov 2022 21:14:32 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA0E210E278
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Nov 2022 21:14:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BuSBKMu6DOHeFRr7e6wcxiJ9kvh2ngLZ7r99yNpjFQjzrWvCDNp2UvrsPpirWai4GDhYJam0hB1MebuJ5lV4r/Wih+TTaQUz3rWXfijDY8mr9se2VvF/u0pKVmoUzwIoCcYpWrkwj2fwyhPYStgaExoDW8lQEdXT3lZhjsAc5uFZDlhwRuIioJzOIRwE95gecYoSPhcrsnDXR/qZZK78lwXOjTwEEwoF6vzjlgPatSTUGfY8/pHKI03UL7HXABOQ6/NcOpU64sYEAGwNbw2VWcZR2btY4HPzbXVcsIY711BO9pVzVsHewKixy2nTd9xji5cW7FATqaNbas+CSZTLBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jz5ZhyinHiaOOqv6u8h8N2zxNDo40f6K3GdH51Dnek0=;
 b=G/CEPOgzDOUaDfzBMWF2g6gyuIznO1G2kvDvnOorntIm/T40ep8C2VeJkFM9wvImG6MTQfQBQBSHd5yHIB1mER9/DLQ1uUchguheCw044PyN1fkGIjccfm/chFQ0hfZvk6uYXWVLsxXMMZth6WaX4qwmCviR7Vf0oCxvnVA8KnkfD4I33Vj8U1I6VJcb61nBCbn1UV4MG+4GgQVqQYW+VHjqDWUUaHgszTDZnxRdWYAUdxzl+WUrZsNI7/vZ0i6DlJyNQCNZn8A4lB8RuQXwAPrRZdKthjeG3jpPhGPwgCLHzTeidcvxa+64cJfVW3oTTJhYjzuNWlB8KBlKmu0yHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jz5ZhyinHiaOOqv6u8h8N2zxNDo40f6K3GdH51Dnek0=;
 b=f/Urumikek1egzx/r53zNG3zb8FYNKP3IDCjjxV5V+09AyyGa2y8ahfa0F6SLV6jY78XfCTdUB7rdLHa4s6zCneVEf9s/Xw8hopRPntbAJLyiLB6IKlW2xDddG2WEDEvMmhBdnDjSoHeNNkUysEGMwiyCntVVRwot8AqFe5PpOo=
Received: from BN1PR10CA0028.namprd10.prod.outlook.com (2603:10b6:408:e0::33)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Thu, 24 Nov
 2022 21:14:15 +0000
Received: from BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::c7) by BN1PR10CA0028.outlook.office365.com
 (2603:10b6:408:e0::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19 via Frontend
 Transport; Thu, 24 Nov 2022 21:14:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT094.mail.protection.outlook.com (10.13.176.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.17 via Frontend Transport; Thu, 24 Nov 2022 21:14:14 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 24 Nov 2022 15:14:11 -0600
From: jdhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/12] drm/amd/display: set per pipe dppclk to 0 when dpp is
 off
Date: Thu, 24 Nov 2022 16:13:47 -0500
Message-ID: <20221124211348.214136-12-jdhillon@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221124211348.214136-1-jdhillon@amd.com>
References: <20221124211348.214136-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT094:EE_|SA0PR12MB4431:EE_
X-MS-Office365-Filtering-Correlation-Id: ec06984e-03c3-4bcc-bf6c-08dace60d715
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: thfq1o5bfYATip2BTILl+d/yJCbo0+XSK0aeOIUWJcW5LC/ml7huDJHqGMk2amqN6xR1t1sKwMw7aDhQaoU/21FZ1wfedHI67aQFrV1lwaWxmBseZVKbri+5xlujNMoQcdUEpMBGB+gORkytGm1GKDoCZTi3YqUYoMIHZxhZ7IAnW8TWEiRKrAfMg2BvLA4LS3lw4Y3CmGapW1jZ+JMkKu1jtukHPsafT0vKt9aDzWN1Kdr4d3hsnvDhT1YfnKB4WVw7DbtDXGLmXcCq6iC250eH0QRcy+cMY8Wod+7C1mkFb7lwZWTq0Q240+GqVF6OoyCsTqCMYPE4qb8kFur4JaJ4Zg0nJBR2JM/29YrxZPLv1JCDYy01XNdh3nWLFv9TZDa2jYFC6EHzomY3S6XfHmdDUVB7bzY61MU+hccezUWW46YeillnAe15uVyE83mw2uW+7TFBM1cCwaznOooX2LzW00PySPkVO+HH5fjUwjLnfbBa3lw/4rVsIZv/Ii+0hZAHyFAQvINv2w0gv4UTrQ0JvJUvEueQmeO7lKe4lHldAZniJZT2qos7RPi91TZc60EFDIz/uVlKpTOoeG2oZHqAbNWA5Ne/o83GouqOzaXid1vGhwAeg4Cil8srfQfwCnMA3Dk4d2KVknyLxzv05yUWR97V6fGnDp4fDpxHtjRJQsN1SluaqvDly3QeS9W5+G9uBipF29A/Mvi9+mIl5mm8Q/ZIN7kZDMUYawcBtuA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(83380400001)(26005)(2616005)(47076005)(186003)(16526019)(1076003)(336012)(82740400003)(426003)(356005)(81166007)(36860700001)(2906002)(5660300002)(40480700001)(8936002)(40460700003)(478600001)(41300700001)(6666004)(8676002)(4326008)(70206006)(316002)(70586007)(54906003)(6916009)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 21:14:14.6586 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec06984e-03c3-4bcc-bf6c-08dace60d715
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431
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
Cc: stylon.wang@amd.com, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Mark Broadworth <mark.broadworth@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

The 'commit 52e4fdf09ebc ("drm/amd/display: use low clocks for no plane
configs")' introduced a change that set low clock values for DCN31 and
DCN32. As a result of these changes, DC started to spam the log with the
following warning:

------------[ cut here ]------------
WARNING: CPU: 8 PID: 1486 at
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dccg.c:58
dccg2_update_dpp_dto+0x3f/0xf0 [amdgpu]
[..]
CPU: 8 PID: 1486 Comm: kms_atomic Tainted: G W 5.18.0+ #1
RIP: 0010:dccg2_update_dpp_dto+0x3f/0xf0 [amdgpu]
RSP: 0018:ffffbbd8025334d0 EFLAGS: 00010206
RAX: 00000000000001ee RBX: ffffa02c87dd3de0 RCX: 00000000000a7f80
RDX: 000000000007dec3 RSI: 0000000000000000 RDI: ffffa02c87dd3de0
RBP: ffffbbd8025334e8 R08: 0000000000000001 R09: 0000000000000005
R10: 00000000000331a0 R11: ffffffffc0b03d80 R12: ffffa02ca576d000
R13: ffffa02cd02c0000 R14: 00000000001453bc R15: ffffa02cdc280000
[..]
dcn20_update_clocks_update_dpp_dto+0x4e/0xa0 [amdgpu]
dcn32_update_clocks+0x5d9/0x650 [amdgpu]
dcn20_prepare_bandwidth+0x49/0x100 [amdgpu]
dcn30_prepare_bandwidth+0x63/0x80 [amdgpu]
dc_commit_state_no_check+0x39d/0x13e0 [amdgpu]
dc_commit_streams+0x1f9/0x3b0 [amdgpu]
dc_commit_state+0x37/0x120 [amdgpu]
amdgpu_dm_atomic_commit_tail+0x5e5/0x2520 [amdgpu]
? _raw_spin_unlock_irqrestore+0x1f/0x40
? down_trylock+0x2c/0x40
? vprintk_emit+0x186/0x2c0
? vprintk_default+0x1d/0x20
? vprintk+0x4e/0x60

We can easily trigger this issue by using a 4k@120 or a 2k@165 and
running some of the kms_atomic tests. This warning is triggered because
the per-pipe clock update is not happening; this commit fixes this issue
by ensuring that DPPCLK is updated when calculating the watermark and
dlg is invoked.

Fixes: 52e4fdf09ebc ("drm/amd/display: use low clocks for no plane configs")
Reported-by: Mark Broadworth <mark.broadworth@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c | 3 +++
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
index 12b23bd50e19..b37d14369a62 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
@@ -559,6 +559,9 @@ void dcn31_calculate_wm_and_dlg_fp(
 		context->bw_ctx.bw.dcn.clk.dramclk_khz = 0;
 		context->bw_ctx.bw.dcn.clk.fclk_khz = 0;
 		context->bw_ctx.bw.dcn.clk.p_state_change_support = true;
+		for (i = 0; i < dc->res_pool->pipe_count; i++)
+			if (context->res_ctx.pipe_ctx[i].stream)
+				context->res_ctx.pipe_ctx[i].plane_res.bw.dppclk_khz = 0;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 5a4cdb559d4e..f94abd124021 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1320,7 +1320,10 @@ static void dcn32_calculate_dlg_params(struct dc *dc, struct dc_state *context,
 
 		if (context->bw_ctx.bw.dcn.clk.dppclk_khz < pipes[pipe_idx].clks_cfg.dppclk_mhz * 1000)
 			context->bw_ctx.bw.dcn.clk.dppclk_khz = pipes[pipe_idx].clks_cfg.dppclk_mhz * 1000;
-		context->res_ctx.pipe_ctx[i].plane_res.bw.dppclk_khz = pipes[pipe_idx].clks_cfg.dppclk_mhz * 1000;
+		if (context->res_ctx.pipe_ctx[i].plane_state)
+			context->res_ctx.pipe_ctx[i].plane_res.bw.dppclk_khz = pipes[pipe_idx].clks_cfg.dppclk_mhz * 1000;
+		else
+			context->res_ctx.pipe_ctx[i].plane_res.bw.dppclk_khz = 0;
 		context->res_ctx.pipe_ctx[i].pipe_dlg_param = pipes[pipe_idx].pipe.dest;
 		pipe_idx++;
 	}
-- 
2.34.1

