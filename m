Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B573FC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Dec 2021 22:05:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8570F10E33C;
	Wed, 22 Dec 2021 22:05:53 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2047.outbound.protection.outlook.com [40.107.95.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3013B10E33B
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Dec 2021 22:05:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DF3N9PpugFV0itMYBXwKm8niBuLcxwYf91g5fPib1y6tJO6dXCn7t3Q6OZvQ5uCPRvWdMmQf/rctNpLyajasdf+Lc8LGv4jyErBBvGIUSTs68kQNDO3FeGknkOPIsLcamwySY08jjzsGVUYgoOwwhxH5SeZw9UEmKS5sCnI9MXvDv9aakjqi86XQvV02oIBiQPBgpbcQ9xGzqK/gJ89Wn7chVZS0wOzW3Q47MPVEESmg1TLVC3jeH9SSb8FNKvaG1qz3pAcEUCfssyZhxHi8wSJfm1q0H/poVeZJhnuTi1YvCbVilT/Z8PQYroOArqnD84t32BCo8YcptJESLjG1lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5pAzydFjsm2vhfXiX+ysNN8yoPwDoSvsFc0NOjHMro=;
 b=HJFNAYnJx6FH/IfXNy1EU8gfNxSle+u4iELsvwznZWxoDKMyaaXF3xRcBvErluIXLuZa1fFS320J0TdNfqb11xux92cIwogT3h8s45cgtBMkx1X13k8dEoOSoRECv0v7ySflTlWBABT6qmLtKPTzaW/YDLDSp4oTFU8cOrqvHPKMj6tDId0Ug/j6QDvygVuXc/sKdTZfTcj9cUdf8kp7XV9ECkpsnu50h2bF5QhETZc9jMI0AZ8NuIHsEugRwF/Nqhg0GDt9kLafsVi6sVNfhRNgqDNzu4huyt5M0iz1zxK4Ji8F00bpWNf6hHR2NYKgvLeL5KWDI6vcOsKgcpuq2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5pAzydFjsm2vhfXiX+ysNN8yoPwDoSvsFc0NOjHMro=;
 b=X8EQ0gFQtJPJl/lSVhjzF7i9l88mw1a0Zw/OLbfH4oEZcO5LBSdpBot4lzW1vCgq9JjQ9a8SkCUYvgAJW7WJ70Mk+JRPmxxf1KQt5/nE3QG/UharuK6V6ki1vmEAGfWhiiAWPDuTiLLMFbph8VdMXgVnOC8WZGYmZU3obyLKeNY=
Received: from MWHPR13CA0018.namprd13.prod.outlook.com (2603:10b6:300:16::28)
 by MN2PR12MB3582.namprd12.prod.outlook.com (2603:10b6:208:cd::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Wed, 22 Dec
 2021 22:05:49 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:16:cafe::4e) by MWHPR13CA0018.outlook.office365.com
 (2603:10b6:300:16::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.7 via Frontend
 Transport; Wed, 22 Dec 2021 22:05:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4823.18 via Frontend Transport; Wed, 22 Dec 2021 22:05:48 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 22 Dec
 2021 16:05:46 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/6] drm/amd/display: Add check for forced_clocks debug option
Date: Wed, 22 Dec 2021 17:05:17 -0500
Message-ID: <20211222220519.1682537-5-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211222220519.1682537-1-Rodrigo.Siqueira@amd.com>
References: <20211222220519.1682537-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4c69da9-a71b-4667-dc42-08d9c597361e
X-MS-TrafficTypeDiagnostic: MN2PR12MB3582:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3582E2E9EE43D40C3709E1F1987D9@MN2PR12MB3582.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IjLOrBZDEbhCM7r5gyRG38bL9uG+f+N7VE+ncIGuUbIOIsxA2feEo+ok54FXT8KYMe409jVobmSrRf+R8FQbM62yiO5JfQ9R1Li3PcOPjk8LuA+PptURAp8UyCr+bN9WYYLKdC4FJyB9+VNxnq4GZQaUjhtj33C4Zn95CqahW6hjaR4znje85fOEUoZ1im6C+AQgfCjNCE3WGcx4ioLUaOiIVeL01pSI+wzpFp08GxzuTSZ19r9HI4i80kKdmlWYvbFeE5XbqfC8VqLwJfmzjc+mQmsRFaXWf/KXM4pXt/QJdGFp/z4KBkwILOOtiNYQ2/O39R5EcxWzSyF0mNqO3T0J4G/xEofxUcKTFEBWxIrQwGjGcQ/QprYAoh6lpaYR/OqAZs/b+h1rasoGh73VkA6xwBBwAX2LSoY+DfGCTS1c+ca6k9S1+PlDZwrcLOfWO9Jfv0EUPF0WqGxEsWxV35muGpBTIeQxB+tpC9L8qN5QsEWtN7o1bjl3Q13deUw66sWMqYuEygeS/jO83CdBasX4Q+ZB0MekGCHQNkUKeISmXi87njJEa3IIdnj2gRf4FtEfv6JkFURNoS7WTjeKDKB2tjr2XSSEzZ9RzR6BPqyryH3gMYFT5Mg6yH5X+irWJnPk08fDQNju9eSpB8nMr5zeTGAUZLM5RBwthTVtzXnc7ORVi5dx6N78biiO+Q4SIPeoZGqrAFzXKpyMApBkeZ2yXYbhnJNZIsJBmerrkO4R4WFV6tNXQx8Roca4u54RvDy8MhLwsDQIIZNYUfPjD2CqKouzLZnCAf4wEd18JhY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700002)(46966006)(86362001)(83380400001)(6666004)(336012)(5660300002)(186003)(16526019)(8676002)(316002)(426003)(54906003)(6916009)(8936002)(356005)(82310400004)(81166007)(26005)(2616005)(70586007)(508600001)(36860700001)(70206006)(36756003)(4326008)(40460700001)(2906002)(47076005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 22:05:48.6799 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c69da9-a71b-4667-dc42-08d9c597361e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3582
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>, Dmytro
 Laktyushkin <Dmytro.Laktyushkin@amd.com>, solomon.chiu@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, mikita.lipski@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
driver missed the check.

[how]
add the check.
add min display clock = 100mhz check based on dccg doc.

[note]
add SetPhyclkVoltageByFreq as confirmed with smu, but not enabled in
this change.

Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 7c64317a56f7..40778c05f9b3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1978,7 +1978,7 @@ static void dcn31_calculate_wm_and_dlg_fp(
 		pipes[pipe_idx].clks_cfg.dispclk_mhz = get_dispclk_calculated(&context->bw_ctx.dml, pipes, pipe_cnt);
 		pipes[pipe_idx].clks_cfg.dppclk_mhz = get_dppclk_calculated(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx);
 
-		if (dc->config.forced_clocks) {
+		if (dc->config.forced_clocks || dc->debug.max_disp_clk) {
 			pipes[pipe_idx].clks_cfg.dispclk_mhz = context->bw_ctx.dml.soc.clock_limits[0].dispclk_mhz;
 			pipes[pipe_idx].clks_cfg.dppclk_mhz = context->bw_ctx.dml.soc.clock_limits[0].dppclk_mhz;
 		}
-- 
2.25.1

