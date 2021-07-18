Return-Path: <SRS0=r+dI=MK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AE5C636CA
	for <amd-gfx@archiver.kernel.org>; Sun, 18 Jul 2021 14:06:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A23C60C40
	for <amd-gfx@archiver.kernel.org>; Sun, 18 Jul 2021 14:06:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A23C60C40
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF2DA89DEC;
	Sun, 18 Jul 2021 14:06:30 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D54089DE3
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Jul 2021 14:06:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CM+3ENAlv5or0q72957OFCMCSz5gWxMBkzgZRX5NQRlNb4cmg0O2z63bJjUWN9YOQWRiT14VStNoFK+Wl2J7o7tYzibRsvW3cayPFgOi54VM5fiSuLF4Zjpc9SKj/+H//R5pFCTgEk8e8oJYSnXRXnhA8V7M+61lYqeO+4oMbDDxKxI48Q2nJDTg+R0xxqyaNGTUdNof2xlgrHUch672qnPKK3AD6fo2eApVCP0zZG0VeDefuqMWfwjujVaRpmLjhM3hZAPYef6htZsdEWjGcM9UkEpNhJ81MRJE3cptBLsYz3kUeHvz6XS/Kv7l+3jCLHgHRwdW1xHaJ964E9jxGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ht93eC1X17+FJB0W0XJd/rsW6QcK5kVfJM5PEdDpTIo=;
 b=mB1S0OARzhkW2Xsm7uUN0avNx5JbNwow342Sek0LokUeTk0cy72qO4+8utRMEL35uMDiO44zD6QZgyY4RzB0DuQPUzQOrF+mSjItegt1+OIPy31f4qZ+WSfu6CP5/1IgE1uQLzyoRpgjLwpVJktpLHg64VN8bIY3gLCf536+rcI2Ncfg8WvVg9d2BN8zW9cf26vEjaCY9YW3Buzzl6s14jEqknSW0i5Qzi8DcAG7OvI8Pg4ZWazhkUUo7I+B0Jc6jfr85F77xoEoX8I/4D302dGJmLi9B0lxNxOlltfElsO7bp/xWKbZ8qnjl5aZhF4JWc2f8ZHi4xZmrrCFdmscSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ht93eC1X17+FJB0W0XJd/rsW6QcK5kVfJM5PEdDpTIo=;
 b=tDz/JrCp0Gkj3V6sSO31RDrRhQQ6KJaRpsct6zumij7eRR9gDjxFApxDA408aNZT+VdJukGVlQ9BuYnIInTBvUlzqCk9jPMe8o+Q6NkaVV3FrbgGI19uJuJ8M+x20Mp7yX+h/jZQ43fOoQgx/LW10eTV8mOtcFRlrYDkHay584o=
Received: from MW3PR05CA0021.namprd05.prod.outlook.com (2603:10b6:303:2b::26)
 by CY4PR12MB1240.namprd12.prod.outlook.com (2603:10b6:903:3f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Sun, 18 Jul
 2021 14:06:27 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::79) by MW3PR05CA0021.outlook.office365.com
 (2603:10b6:303:2b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.9 via Frontend
 Transport; Sun, 18 Jul 2021 14:06:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Sun, 18 Jul 2021 14:06:27 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sun, 18 Jul
 2021 09:06:24 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/32] drm/amd/display: Prevent Diags from entering S2
Date: Sun, 18 Jul 2021 10:05:42 -0400
Message-ID: <20210718140610.1584616-5-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210718140610.1584616-1-Rodrigo.Siqueira@amd.com>
References: <20210718140610.1584616-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a8c6587-d90a-4038-0fdf-08d949f53c14
X-MS-TrafficTypeDiagnostic: CY4PR12MB1240:
X-Microsoft-Antispam-PRVS: <CY4PR12MB12409E04C130CFCD0C8D3D4898E09@CY4PR12MB1240.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:335;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TgrpwTG86bqwAc8tGj1gXLeqVQzx3APf49TRjnK6RSBMC8+Y5YVFD1CxkWsd0ldJ13pkliiY0ED9HVD4TQSb6/g/mZDXVFhnMND7C8YRM6JJQvE27lK/ioL2D9xDJoeYDw2QaF6ntgK1MQCN5rlLS1YmIMr6KvqRaOHZmOEMfXLbqNuNWMf4i+pJLBhkxpGH6ZYIbCQtR0NmZqX5kHQVNqRgbR5pPu+Gvdb4MAMYD7MEGlGExy/5lRzT+q3YXFaTUm76Rrq/u5zUHzqskKvm9+Upa7RaY4wo8/yEH1wJQr6rvVCy8RFYdVN1NX/wAt/bpQ+7f9jELKOOXJDmsqZxdqOJcgwMv1tlIjXjJmqTyb/bn6B4sA2TjO5LKROy9jP9qgqPbIPdKqrrI9QscwjSGITv8dPi0XzZ+GHseblagaMuT3FCc4bbf210XN8gEQ3YaRSjOnX6a2nMeWlADN1VYp/oNfvUwsQaGHl//RlpOyQ3jSNiiqRRU1Uz7qAKhLd96yWaKVuYszEEUd1rXQYR2aJ1Cq3SdjacgbegNVICJA3hoVj8v3UJexrhXOCrNhXPATWf3i11KWQ28w565BMRa+j5NBAXVnPOgX16MVolt+O7+QnRzbFbeVd3Snf4/6Ox0Jmc4QzMamUoE7nfrTdk7EAkar1KGMVti1NBiIotfy0SmZoAgZzTiUVhYN0I+/tQ9HfdpCJIdnec0duoaTzVaOfmzn8J6NbhvsyWXm5fM3Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(39860400002)(136003)(36840700001)(46966006)(316002)(36756003)(1076003)(2906002)(47076005)(6666004)(16526019)(36860700001)(82310400003)(356005)(81166007)(5660300002)(4326008)(8676002)(54906003)(8936002)(6916009)(336012)(426003)(478600001)(86362001)(186003)(82740400003)(2616005)(70206006)(26005)(70586007)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2021 14:06:27.1689 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a8c6587-d90a-4038-0fdf-08d949f53c14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1240
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Mikita Lipski <mikita.lipski@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mikita Lipski <mikita.lipski@amd.com>

[why]
Lowering clocks when entering S2 Idle state causes DMUB to hang with
Diags.

[how]
Do not enter S2 optimization with Diags on dcn301 to prevent DMUB hang.

Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
index c636b589d69d..7046da14bb2a 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
@@ -114,7 +114,7 @@ void vg_update_clocks(struct clk_mgr *clk_mgr_base,
 
 			display_count = vg_get_active_display_cnt_wa(dc, context);
 			/* if we can go lower, go lower */
-			if (display_count == 0) {
+			if (display_count == 0 && !IS_DIAG_DC(dc->ctx->dce_environment)) {
 				union display_idle_optimization_u idle_info = { 0 };
 
 				idle_info.idle_info.df_request_disabled = 1;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
