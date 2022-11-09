Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F5CC4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Nov 2022 06:16:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B473910E580;
	Wed,  9 Nov 2022 06:16:58 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2086.outbound.protection.outlook.com [40.107.102.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B94610E581
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Nov 2022 06:16:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kNB+CxJvkrjtb0uMKwj4Zde36Kbv8umtse2G1SNIcmjAgOpZV92kOGzY4HZsTDVepwrQ4Zw8ObdjpSnRCz8sxrb4RTzwsdXprSlKff6ls0A0y/PwNDP28GM+29bVQQ2KIm2648W/apa7BHbONCyHuxfTDekLBsLe5nk0zYxO9bJaSOwinUiWXFu5zyJYrVHTOq/x1bYk7CyEHAn9fqtIeGWYRPBRqoZ7duKAImPTTquGJtVraF+c8bj+j7Fp0SzMKY5FJt1tXatN9QiUfbe4mh+8bNh1tSbuJmlyz5Xqj2HoJXRqhpZ2tkSgOEpp9qU2bLlQ/V3ClqZZZ8JO+ZX12A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qp3A20nBGrRhWeDDlUOYGktszXERmG6e2KtI3aQLvQw=;
 b=c2ZLr7kjr+IZJaL5jttH/PbRmXYW5mDFzMqnCnrve/N8eKUJbFlEH2xTEjEoSstoGJ5F7Q9DtvpidtPCzE6H1ecnEDcT/1CNh5sODocwjRIiN31Mke3L0x3rptHYfFg+piJd2hWa4xc7sAoucHBNMDm5INOocNLLhNpIUbnofUkbjwON5Jd7WZR7LidaMXMXUz6iSwFVeLBo9+NhC7TmTMUXjYHXHvrpxwUFOwYnHiB9RcvV6qvASB2Xi5BW0kDPP6bBCicE1AqLo39199MDPmPtFOwAGUo/lsacCw3VHX0oEGk+psvTGKc/77n2RliZrcLrVBoiACE5ActqvXDYmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qp3A20nBGrRhWeDDlUOYGktszXERmG6e2KtI3aQLvQw=;
 b=wvLlJt5I9IEhJxhBpB7P+AeJAmq1UFflk0o7n7o2kJHH7hLcs8+WBdEVYmaUnaA/y/1y3TLa5ASqt7gPoXraz4YW0vWt+w0ot4qNxIapvwg7GoxcQj07VzZyloXmkj4/H2+A96HRXxBIV9+49R9aqVemAI6x5i0bFwpt+BKxuV0=
Received: from BN9P223CA0029.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::34)
 by BL0PR12MB4900.namprd12.prod.outlook.com (2603:10b6:208:1c1::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 06:16:53 +0000
Received: from BN8NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::36) by BN9P223CA0029.outlook.office365.com
 (2603:10b6:408:10b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27 via Frontend
 Transport; Wed, 9 Nov 2022 06:16:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT091.mail.protection.outlook.com (10.13.176.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 06:16:52 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 00:16:52 -0600
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 9 Nov 2022 00:16:47 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/29] drm/amd/display: revert Disable DRR actions during
 state commit
Date: Wed, 9 Nov 2022 14:13:09 +0800
Message-ID: <20221109061319.2870943-20-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
References: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT091:EE_|BL0PR12MB4900:EE_
X-MS-Office365-Filtering-Correlation-Id: 70dffbd8-79e4-42e8-4b34-08dac219feac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RgjSH9fQ6azNXa76usiMb0ek/NqkcQcmTEBuAJY0iyI1bc8N10OlAZH1c+RGOObKZBF6p/qF5aGlIKIT59SlLHWE9gRWVZ/3z0jY8dXLsH/jM/htHVdU15DLobyuZpDY859aF07AiasJAPC/P5TTR4Oe15qCpSh5tLpYREgxhTYJlly+lrpgRimJmxb+cO4jOrvVgpfQb/U1C/AAXrynKVVIg74WiO+p2K0yi72gXWq2FPKOa0nMpJAyUgMBGo4Gvbb/F+0Q3IUn0LPey5LbWRCD+0JtokVCdETVyVrqEaScIg94IsOQIqetwCmxf7zuufdUQvMcBWRn9wSPO+xkjOwXl4TYJbja81DXIX1R2Gs2mMSoUUfDaYHXgwGtf38v/ke7GH6CkW7MXB6w2Cpbw/3qXC0U7HmPq0+AQPhR57RXAMqJfZLAQOen/PIk9VXYIxJrxjvuenCMBHd3umzuJiQJ1oys5awQmePaieE8jRPap7dtNPD9rZm3dLuoKF3SEMjOwCzyyvud1BReia+UrxdWv6q1IIzzFOrGo8rzfEpua2SeT2acxJzQoJbjPdiIRzKcoQxe7wbTqspExVKyuuguJfEi6B81zTMdA7teyJaWIDOE8UE8q5oMlBmI0EyNoty4LFLVMl3ESwar1ATh2zCICvIFZIYt+FODxWuHLpeNCdzJBQtaML8Q2ZdMQ8gVJ+pkOaHbTsxr+iO7e5ZLW2PAAmHYSdCkkdiSRiaks5PgJDGCVoKyK8bXZG2XTQIzLKM/viSV4w51lroTqBN+VZ3/Wjtq0iRhiyi1vOrWPpEtfzaC5771c9mlnyEtidGg
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199015)(40470700004)(36840700001)(46966006)(70586007)(70206006)(41300700001)(5660300002)(40480700001)(2906002)(8676002)(4326008)(81166007)(356005)(40460700003)(426003)(186003)(478600001)(1076003)(2616005)(82740400003)(316002)(6916009)(86362001)(54906003)(47076005)(36756003)(8936002)(26005)(6666004)(336012)(7696005)(82310400005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 06:16:52.8553 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70dffbd8-79e4-42e8-4b34-08dac219feac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4900
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
 Wesley Chalmers <Wesley.Chalmers@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Martin Leung <Martin.Leung@amd.com>

why and how:
causes unstable on certain surface format/mpo transitions

This reverts commit 480c320055c475b342703d4b53f6ed1d922adf21

Reviewed-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Martin Leung <Martin.Leung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index c20e9f76f021..8c5045711264 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -992,5 +992,8 @@ void dcn30_prepare_bandwidth(struct dc *dc,
 			dc->clk_mgr->funcs->set_max_memclk(dc->clk_mgr, dc->clk_mgr->bw_params->clk_table.entries[dc->clk_mgr->bw_params->clk_table.num_entries - 1].memclk_mhz);
 
 	dcn20_prepare_bandwidth(dc, context);
+
+	dc_dmub_srv_p_state_delegate(dc,
+		context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching, context);
 }
 
-- 
2.25.1

