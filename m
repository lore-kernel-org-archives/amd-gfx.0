Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19EA4EE0212
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 02:02:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B414210E4E2;
	Thu, 14 Sep 2023 02:02:18 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2062.outbound.protection.outlook.com [40.107.101.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 385B310E4E2
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 02:02:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDWrUFPdstGnrh/PNI1lBNvwOH4D7+iTKvjZjGvTkZZpSEwxVvbc3TpVY0285DH/4Xjg/sUdcFnf7deFUnL92e3kDYBvVFyihz/ZQvw2yweU8Jr4jh/e/qDGnOyZr28zwk8WBuaWyLLGbbKPGpKMcoCDjBC70c6SjTMDENWIPglErFfUXP4ylyuhodi3E584y/xXCByC3yV9Nb4Tctxfgpt3wOzGfHH0xyDNJGOTl6o87XtOpuOIaCfKHRS8tc/rBl0Jrd/9ynzujbCQ8tCNR+tkn46IG8wdcGzPbaAf0cIDnOk5CJYksm9PMRlu/C42RbuaXFFettOgbS4I7jKOWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k06/EVpbxq9BGivgyZHgh0Deq9rp6nu98PEVBMVoW70=;
 b=W3AZ5LSDQvhNldNDQNZMfVQhn5rFwTE/pBim//rHopcKxmhDGtGOgT/NG0Ce0Ush4g6g8Dj6zZjaIRG9Wc9aarBXUUovVU7/2PrH28wkKYjEVCcehdFrFbHQXfZleEWnBCSMkk3dZ93vjjFbBXeN/IELrbDsznVlQSLMtaFW5Ryiw0mz0dyHG/PIaXEzQNB+1AnsKxMVwjCCHyVi+RjhPrm4ldxQQr5d5Y5cikyVVS+L9GvWvu4rvcUGi9GLf3QyPdt+x1pAM+xtLhwQ1NNLqkcWY3NBZKvu1hHA7e19cLQP5HSJ+9BJbwVfEwRd7aCa0GBGeWXeAp5MAsg4vlH/6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k06/EVpbxq9BGivgyZHgh0Deq9rp6nu98PEVBMVoW70=;
 b=JCai06R6Pu/Ohm8/YuC1KChm2JSJ4oLUdvU5ILobCXJ+81Fsg0lLLZfMRsGNvgRMgkLgwxG/aRNGqYGusDuIfKNwt30kNyktLcrW0fMee738iSGUFQhI5NPIXYUKz8A0vql1nh2TSHqeGD7cOPTuRTmHUleNLQ65TqY3E+o1pO4=
Received: from SA0PR11CA0083.namprd11.prod.outlook.com (2603:10b6:806:d2::28)
 by SA1PR12MB6917.namprd12.prod.outlook.com (2603:10b6:806:24c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Thu, 14 Sep
 2023 02:02:14 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:806:d2:cafe::6d) by SA0PR11CA0083.outlook.office365.com
 (2603:10b6:806:d2::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Thu, 14 Sep 2023 02:02:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Thu, 14 Sep 2023 02:02:14 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 13 Sep
 2023 21:02:02 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 23/28] drm/amd/display: Optimize OLED T7 delay
Date: Wed, 13 Sep 2023 20:00:16 -0600
Message-ID: <20230914020021.2890026-24-Rodrigo.Siqueira@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|SA1PR12MB6917:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d7ef290-f496-4ed2-7f52-08dbb4c69da7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XhFgzxrdSOSef3MAidzk6nDd2JvZ4K1+PNoSDdxr+8v64X8YIBUVeDDzitstG6ZXCYrCatR2wF3DozL5lcJ6cIYr6v+u2NvG9sJJ+eNTgKoqw494nFhIH/SFhB3fGPghcKktk7qXzjivFTh8QM9ptwlQ1T2J+2iPoMBLEPNJqnLlxHG4c/gfDKyhxJJ0TjQ/6CC1ldiy5uxray0RRMA9Yfc0AXBve7u6Q7lQQdKbROV4Agi9bDbrLUGmZLE3/+/R4QIzu/qVYdbPkGE9rbkjIOJZvlkWzqAKO2DklN53haViVM2AsFdlinxQqz9EcO0Xot1AXi4T3K548sA37qqKomEKfN9g/WrOTOpv9jmXiyPT+WCDYhtdJ6VoNXKtgW4yC5quurlEtitKwQAsRm5TnzGsQdkwtV750EPM35o8wm3Qu62V4lTGc4DfQERG4rv+tctjU9CEnpMEUmQPeBaYvdAqUpVMCFfAgpkiqr0pC7nNxGGZF0MvVpJbBNXMbpCZJQsH8mC8clqRB7jL5d5D6NABDhhRvleaZcO+IBE6gRmIafu6iCt3JCFcCdUxEMM7sVGTEc2VkBijlvB3pASiCYvqfyxu3c6ugbqbeqhWczY/AGbU0/qFQb/5/PUUJ9hDnv+nEsb0/EXcutnXlqTj1vd7m+3M7biwMeer/R5DUWZv6GodYSiZsPX0VOncITm8DrNAjGFl7oDQVu+bRxnXePqpmTT5sua8aWQDdMN4a7mKQB5gDcv6Ok4A/gX4fTX1XqdpGINzpy1wu6ck5Jei1w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(82310400011)(186009)(451199024)(1800799009)(36840700001)(40470700004)(46966006)(70206006)(316002)(6916009)(40480700001)(6666004)(70586007)(54906003)(478600001)(41300700001)(8936002)(8676002)(4326008)(2616005)(1076003)(40460700003)(26005)(5660300002)(16526019)(36756003)(36860700001)(82740400003)(81166007)(426003)(336012)(2906002)(47076005)(356005)(83380400001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 02:02:14.3956 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d7ef290-f496-4ed2-7f52-08dbb4c69da7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6917
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
 Swapnil Patel <swapnil.patel@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo
 Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Agustin Gutierrez <agustin.gutierrez@amd.com>

[Why]
Driver doesn't need T7 delay for OLED panels, since it doesn't control
power sequence.

[How]
This delay can be skipped to optimize resume times.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Reviewed-by: Swapnil Patel <swapnil.patel@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 2701620350af..baecaaf96968 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1041,7 +1041,8 @@ void dce110_edp_backlight_control(
 
 	link_transmitter_control(ctx->dc_bios, &cntl);
 
-	if (enable && link->dpcd_sink_ext_caps.bits.oled) {
+	if (enable && link->dpcd_sink_ext_caps.bits.oled &&
+	    !link->dc->config.edp_no_power_sequencing) {
 		post_T7_delay += link->panel_config.pps.extra_post_t7_ms;
 		msleep(post_T7_delay);
 	}
-- 
2.40.1

