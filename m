Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A734C10F05
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 13:28:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2011910E874;
	Fri,  1 Dec 2023 13:28:19 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECFCE10E874
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 13:28:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3kYluCbdr6CyvYia6oesNFrZUWLdruGst3LOeLe+tBUZvb0HlxCv6sJOF3lTWm9dUozPLts83PV/wME3yyHK3DjMlhBh3puL9GLseIIpHstfyu/2lv413ppIB2HCVl4vAC0NJPQUXhvGPqbgLdZorqznFzio7i52tCPU+l3uUeFEjfvHj0ky+CZABdykMqLqo+Itt5uEKaQqzMP7Y2wnKhVCyIfuaNCjTragslzYtBcp7mv2GG41tEyneXbg1sIq4Fm/uZv4d7XlYTPl7jA0gOjc23BmtqwWtiAPjKN91BE9PrNvjeE0XLBo4WPoWZaOqIrQdsvtvJAe1lOGeQ6iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tB19tQMEosiKl7+8nhiCxor3DnTW6XO4LsRABjXadU=;
 b=NWDsAQ63/Co4pbIbHaY0wIrnNXwTknQ5zSibOrA2z+oTgq7bT4Jty4rY09xJKfIJjEoDti61bJ0ZDfyKtPdU6RSOlh38UGv4imKAA3U43bj5gA2IPFV5/ulA21luCAk98aZfg2GSU54IuAan9kjAtPzxxtd2TmL9xj/bYoZJKfEIFk2BtBGmgchJ5LkeY4OC++FQAUuHBJcVMg/3jgygnPQ93c0w1HSTiLlgZi13/g4CfJjz6uQiLi0G9MsO+tOBvU/cGcgAoQHagxjxVbwIvEVLwcvWZN21RR66JeaJfq+/EkbNRrFq0LouwuyJgoGPk/dtFEfoTJdsf5jzD4cMiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tB19tQMEosiKl7+8nhiCxor3DnTW6XO4LsRABjXadU=;
 b=ajbnaP9bFaaWN+myVCXCEQ0Ze5Z3wi8+Zw/VdwvlqgEchUHdwKiqKBnAi4b4t3mFuhKXNPV6x9PUwZZK0MsdWRNhOlxN80ybXvhmK80nhS9CZN4CSPPRxwpEMwgVqS3xDHBWjk6vb9wLLiSu0PEbx7g6R94Ua3N/eckXeFdzuMQ=
Received: from CH2PR16CA0003.namprd16.prod.outlook.com (2603:10b6:610:50::13)
 by DM6PR12MB4861.namprd12.prod.outlook.com (2603:10b6:5:1bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 13:28:09 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:610:50:cafe::ab) by CH2PR16CA0003.outlook.office365.com
 (2603:10b6:610:50::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27 via Frontend
 Transport; Fri, 1 Dec 2023 13:28:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 13:28:09 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 1 Dec
 2023 07:28:07 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/47] drm/amd/display: Change dither policy for 10bpc to round
Date: Fri, 1 Dec 2023 06:25:03 -0700
Message-ID: <20231201132731.2354141-8-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
References: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|DM6PR12MB4861:EE_
X-MS-Office365-Filtering-Correlation-Id: accd7a8f-3250-498a-6e57-08dbf2715c51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yrlIBu6J9NVtbfcVuxEi2Rp/TMqRsQ1LJXYK5vwWy1/BmcFla3rJKUHGDmbfmnoX0nLfsSULoZ9jnCjjvg/uiywNn0pF/rC0HrDeFWrja3txY8uD6/FYnTc5IZTZAPlbTH1P4anghnkRT7W4vaWG4Cy63WV+WQtsteh5IRPoMyo8D8RYplw3h4u+aCypW7vuxL0GEHrSve0qHjw5YYJNpJ4l62O4PuW6KeSjiLBEvJJG26LrL4QQ5deU9SXfDO/V9eRzYPhrvMGWrdk6fweeEhbcKpYqnFfH/0fhnE+zSa0DZnFOMhKv/TICVO3thabFCZ9kmv0sO6YI8HzeUQLJIEHP9+vyHn0Ip9YXJWJmZQVP9TVMsvm87iGBa7ckoOV+G/RIIb0ZksJEjx2MzcQ8MHbV7w4hQ88PyVCXgJIruGkK0Sjjpx7sWuOuNoKy3yhOuE9iaxM23JdSr04KrXqfh8yBlbYEx+LF/S/1L/hWBC1FIfG+0MfKh+VVixpCorE2F6zksYXt3WFAuucR9kyXM/wk7PYC4VDBxEEMfVo0LJgvCzvQo5JMaZm5iUYiZCylJVr8ZMLwpKTCmPHKVHFo0Lzm6YbSQWNm4YS9zDK9Ow8NLm7n3LQuw6Fs7zwXahAZmuWbTcRLzNVwmVg8S4hleL7NkY0Fx1L4GOWnA3ye4gi5W25iFsjt1USy5dQEUq24fP/7TqnPeUAqlOK6FEo47dKc1R2GW7np/npc7Jm7RzZqO9h1h4B+BxiF4Bo7+ajpTocGc6pMccSYjScVkk8QaQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(82310400011)(186009)(36840700001)(46966006)(40470700004)(40460700003)(426003)(336012)(83380400001)(82740400003)(36756003)(86362001)(81166007)(356005)(47076005)(36860700001)(70586007)(70206006)(4326008)(8676002)(8936002)(54906003)(6916009)(316002)(40480700001)(5660300002)(2906002)(2616005)(1076003)(16526019)(478600001)(26005)(6666004)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 13:28:09.6342 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: accd7a8f-3250-498a-6e57-08dbf2715c51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4861
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>,
 Krunoslav Kovac <krunoslav.kovac@amd.com>, Anthony Koo <anthony.koo@amd.com>,
 jerry.zuo@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 roman.li@amd.com, solomon.chiu@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Krunoslav Kovac <krunoslav.kovac@amd.com>

We use spatial dither by default for all output bpc (6/8/10). While it
makes some sense for FP16, for ARGB2101010 surfaces it makes little
sense as even if we skip color pipeline to preserve bit accuracy,
spatial dither adds random noise so a few percent pixels are 1 bit off.
This commit chages the 10bpc out dither policy to rounding.

Also, in Polaris/Vega times, policy used to be round for 10bpc out; it
looks like it got inadvertently changed for Navi. Difference is only
detectable with capture cards.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Anthony Koo <anthony.koo@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Krunoslav Kovac <krunoslav.kovac@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index f3a9fdd2340d..0a63dcd1cff3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -4773,7 +4773,7 @@ void resource_build_bit_depth_reduction_params(struct dc_stream_state *stream,
 			option = DITHER_OPTION_SPATIAL8;
 			break;
 		case COLOR_DEPTH_101010:
-			option = DITHER_OPTION_SPATIAL10;
+			option = DITHER_OPTION_TRUN10;
 			break;
 		default:
 			option = DITHER_OPTION_DISABLE;
@@ -4799,6 +4799,8 @@ void resource_build_bit_depth_reduction_params(struct dc_stream_state *stream,
 			option == DITHER_OPTION_TRUN10_SPATIAL8_FM6) {
 		fmt_bit_depth->flags.TRUNCATE_ENABLED = 1;
 		fmt_bit_depth->flags.TRUNCATE_DEPTH = 2;
+		if (option == DITHER_OPTION_TRUN10)
+			fmt_bit_depth->flags.TRUNCATE_MODE = 1;
 	}
 
 	/* special case - Formatter can only reduce by 4 bits at most.
-- 
2.42.0

