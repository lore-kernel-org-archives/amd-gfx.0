Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E85EE0213
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 02:01:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF9FF10E23C;
	Thu, 14 Sep 2023 02:01:54 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::619])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 280B210E222
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 02:01:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bYQPKuXgNYRqHUOo39O4IwxpoTWK/B2Bx7j6D01P/mI3WsOzsJlNsZ3frA0nUpeYihLHemXmpAYQ8f1wmj3tYjbHyC4KOuqZ+5Vd+2ZvmQYfxJYQ3h6W0oNHoMyRQBv444I3sCQeb6vBBoDNfRt4BHYO0K4qKwYQcU3jzf8ofkOxU2FjNUIB1aWU0ZO0w8HH5YEoTJk3z5O84MljeWZ4uXyq9Gll5guhVcFXv951lMYUPW/bTg1pwiJaBUeu/CvWKE9LFBRUdiuHPRe4WXHdJaSEhX8IaHag02XVZ+m4BG06r+yYD54v91vKF4e5KFcxB1dOqM2gXSJuHGHjg5JzNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Ga/7mpek8KXJy4LwmHtWymMQdCtTqVBpsFVS9Q1iGY=;
 b=b/K53eAhKANgYTPj92ZW8KQSkwvCK1q3tWVkN7im5HbIVQA3KeeMHXM21rOZ+OWAj34UaMr20LtXI0/gZI6qoVGeCZGvEaZCdMnu5whsb9d540zGUkuQDNBes5QjRhYOV51vXUb5ohEJNX23lauV68ZnZpF58qihJMG3l46c4CTB8t5gnrgS/5S8m/yHuqr8fnC6BCOuSdwRmviH6wYQGe3CFik3H+U41XATA4vv8eAWUWd51zR9ctr7MPxQi5/AtKBedA1jhLpHiR9j6zS1uBIyYkYmAIXgeasjBKnXf7u79pImlzJOPOO5arhInC1u4IieQ8AV8O5jFCbcwRT16g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Ga/7mpek8KXJy4LwmHtWymMQdCtTqVBpsFVS9Q1iGY=;
 b=AHDFErMwk+Sd6w8bm1YRFCBQtcx9ZgwxbGPfUvVeiW5vKv98JSdPlzzFupwD5wh3q0v0ZOqOYYDvDQ4vgZAxsJG4XO5TFOlF3YJ+ekHiaHbBO/rQTI7fTbuRVEgj/YuNT7crTgShQkjlHrg2W8uHG81JkMD6Yp9dhG6TFiQ/AoU=
Received: from PA7P264CA0161.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:36c::18)
 by LV8PR12MB9272.namprd12.prod.outlook.com (2603:10b6:408:201::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Thu, 14 Sep
 2023 02:01:48 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10a6:102:36c:cafe::e0) by PA7P264CA0161.outlook.office365.com
 (2603:10a6:102:36c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19 via Frontend
 Transport; Thu, 14 Sep 2023 02:01:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 02:01:47 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 13 Sep
 2023 21:01:43 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/28] drm/amd/display: Update driver and IPS interop
Date: Wed, 13 Sep 2023 20:00:07 -0600
Message-ID: <20230914020021.2890026-15-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230914020021.2890026-1-Rodrigo.Siqueira@amd.com>
References: <20230914020021.2890026-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|LV8PR12MB9272:EE_
X-MS-Office365-Filtering-Correlation-Id: e92cb265-919f-4bbc-08ba-08dbb4c68dd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zJTyjWQx70AP5YSLQAUPjJ3awTFfHKgAMq7nsayIpo1aElZm2Ad0/a4yPHWgVgs0E2iNDUH3iLjkQdXh2KNR2W983JV86I0WJL5cV+gevyBM+aF9FmG7EvQCKjDjaJG3WF8gJj+qQ6w5MI1riED3NTw/jx8qRreA8imWPwzcMyOfdsr8YCss90cEFqsNkLJK1qiQJkzKnEkBU3bJ02YzBBkcRGqmc1dijlS64kWWe3uMQ8NwwUjmKOfQGHOWKnMgekkKuqRhpaTMEbSQwAmZvhJGLP8qmduH8KAwp/Hd6G9h/Ib/GI5Zf9ibop17xWB9CzfOcP8g94hXE+jcW00/CXzIjiSL2mVbN5+thTHisHilCepqwm3vQTezD6G8Jq1uCjEeGK3SXXGDOr0yg5rsqDpZdzbmyeGN6NZDhWIsSDfm8XCfApRN+oLs29hWZ/xtrMorsSyjnBlKLTz52PrBEyQQ+sIWuu5QpshUqpjjrVeaGVKi7JKNiwZOkESC/zVG1/RVkwgFf4FEhP/8nkqM57zK4cHoXMUyqg3UBJ0BCSY62Gm3OQkTWopqDBZhDk0sdC6hfRYTCzPdCuf6BSFd1PpPvkeUWXzHiIYq2ExgnSCNyXS7KrEdS8frceZKkBOGpQ/qUFfX1V1gVkx18cSWJy6uS05VLBceaz7WBhYc1aDv1DDK/xrPugQqJ0h3C9vci8WzGalD34EmQs5MZQ6A6SuDgHu8kM9atDiCBH4lzn+qQ5mTU2hwr6qkivxXm40R5kP6YbqmMVRVtzbD3hqrHQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199024)(186009)(82310400011)(1800799009)(40470700004)(46966006)(36840700001)(83380400001)(86362001)(4326008)(5660300002)(316002)(40460700003)(6916009)(8676002)(36756003)(2906002)(70586007)(54906003)(41300700001)(70206006)(8936002)(47076005)(36860700001)(82740400003)(478600001)(2616005)(81166007)(356005)(336012)(6666004)(426003)(26005)(40480700001)(16526019)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 02:01:47.8243 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e92cb265-919f-4bbc-08ba-08dbb4c68dd1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9272
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>,
 Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Duncan Ma <duncan.ma@amd.com>, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Jun Lei <jun.lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Duncan Ma <duncan.ma@amd.com>

[Why]
Two issues fixed:

1. Currently, driver does not allow idle prior to PSR entry. Once
   PSR1+IPS is enabled, there is intermittent hang due to DCN access
from IrqMgr during IPS2.

2. Driver is sending multiple commands to PMFW and dmcub to exit IPS
   even during IPS0.

[How]
1. Set driver allow optimization prior to entering PSR mode with the
   condition for eDP display only.  Unregister all interrupts before
   allowing driver idle and re-register interrupts when exiting from
   idle. This will prevent IrqMgr to access DCN during IPS2.

2. Block sending PMFW and dmcub exit low power state commands when
   driver is not in idle state.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Reviewed-by: Jun Lei <jun.lei@amd.com>
Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Duncan Ma <duncan.ma@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c       | 4 ++++
 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hwseq.c | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 2f98dfa06dad..91b3a4610957 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1110,6 +1110,10 @@ void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 {
 	if (dc->debug.dmcub_emulation)
 		return;
+
+	if (!dc->idle_optimizations_allowed)
+		return;
+
 	// Tell PMFW to exit low power state
 	if (dc->clk_mgr->funcs->exit_low_power_state)
 		dc->clk_mgr->funcs->exit_low_power_state(dc->clk_mgr);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hwseq.c
index 025849143254..06960fada059 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hwseq.c
@@ -651,6 +651,8 @@ bool dcn35_apply_idle_power_optimizations(struct dc *dc, bool enable)
 		// Tell PMFW to exit low power state
 		if (dc->clk_mgr->funcs->exit_low_power_state)
 			dc->clk_mgr->funcs->exit_low_power_state(dc->clk_mgr);
+
+		dc_dmub_srv_is_hw_pwr_up(dc->ctx->dmub_srv, true);
 	}
 
 	dc_dmub_srv_notify_idle(dc, enable);
-- 
2.40.1

