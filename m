Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BFD0ECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:51:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F28AC10E809;
	Wed, 14 Sep 2022 03:51:52 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D296710E808
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:51:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RBXd0eVZH6Isrus4l6TJ8DZc2m/PAyp2FJLN0nmTKllE4xlKEtnnDCVGzAKRw6dg+rsxpE2cTgnL0z+u90B0i7ZpUXpQTdsYQahKJ0OTP/Jvs45YzQLc0zef2M8DftolttzRpTr0ZEvpD/6Th00zDIiGzp6PCT8F7CbmviFofJ/dlrKonaSvHmoB28BcLgOKt09ocbbnZq0oI8M8Qn/EPropKKU9Kj/tG89QfgtNQgqBxyw9gxoPJg6cTCeeNVj65d8IhVAM05cAtILsHdNrLVyEnY8O1mP+f4lNL+DdrCP3EIX/qtlkyV/vgv8l8eFCtnTUXnU6X1agqs/TXiteng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOhRbySf138h7l8a++kqxKUjWUYsB4r8XnJQ/PR6BuI=;
 b=km01u34eFVdMQlAjueiDExb/4P1eqgIA4xZa3Z6KN+B7JADaxcG3V+LyP6CcVmZmbS+xo4HZRX/3glUIcYCXH+OuwFqlVXnXWlJaqCXQFKn/+kWMUx/jZPyn/imFXw+kH6qjLUjpaQlfVwtCZ+OmwUDWIN3a5S2tl0vVEEAOUiCWGs5beiwSbgXDveJEqiBacDHCIDrPA+v5zYSIG0WtPjxzm5hJx5BAr0DuDmKElnvkAs5PUBCS2+lctdsb177F7OFl1At0vQrnTdNUUIMcvavuETZqJFEwbJerfyI4owWnhLmnt9FJZzYpfY2f2GaPKVZ4BC3rZL0duV0+Vf1F5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOhRbySf138h7l8a++kqxKUjWUYsB4r8XnJQ/PR6BuI=;
 b=vcFs6oV+uki2gcdpFCEowiDy2u0Cm2aR+/KD2RRn+GY3oZsXmKmZIqTNeePAMBeCy2npEUL8yq1y2RBotFAhcu7di6KzUSMvq9gWKRrtXXr3pZwHEJLST0vIemEfTKvNZtIcrmerwSn7TSYpigY9HTm2xI0PBlgmeJawR5lTFxc=
Received: from DM6PR06CA0053.namprd06.prod.outlook.com (2603:10b6:5:54::30) by
 DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.22; Wed, 14 Sep 2022 03:51:43 +0000
Received: from DS1PEPF0000B077.namprd05.prod.outlook.com
 (2603:10b6:5:54:cafe::d0) by DM6PR06CA0053.outlook.office365.com
 (2603:10b6:5:54::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.12 via Frontend
 Transport; Wed, 14 Sep 2022 03:51:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0000B077.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.12 via Frontend Transport; Wed, 14 Sep 2022 03:51:43 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:51:42 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:51:15 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:51:11 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 16/47] drm/amd/display: Fix SubVP way calculation
Date: Wed, 14 Sep 2022 11:47:37 +0800
Message-ID: <20220914034808.1093521-17-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914034808.1093521-1-Wayne.Lin@amd.com>
References: <20220914034808.1093521-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B077:EE_|DM4PR12MB6566:EE_
X-MS-Office365-Filtering-Correlation-Id: e6c4ca08-8616-4ae3-bc8c-08da9604703d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 27UeQ9tU6YUEJF9LegqfDQDZnzEHf27Y7LzSnmpNJAhVEpANldtZmK0VPerOF2jtdlTu4gzEex2+EXic6FIk06leWZw8Uls+4Nb0ULSyX6LLqURXXIWl/ts/UiVqxiTmFkXPoAMGOsmPqvDcoWUEMDRJznhEmr2Tytt8qaZ6uZXlR1VWnlR31uRw5mqz/kJdoBeNTxhXqxBA+YbdPCdA1wI46RW721ZMEQLv5rAglDCphQK75ZmjLz/x6/N2gjVQuxcjYW3nSbgBxpMsbax1iTQxwZjwIvvJCeDsBVpGlOXmisi0lxqUknCF4sbcM0JwiN910sW6p5p5vd4NPVPfrb56NeLvoXTJvu6mqdo4+Vp62HKjKuvdNih8umqCT7NeeBqd1GLUUBEfR8Yj5Pf9TDsnpAGJTl/pLGq1Nz1x+FBxwDcZz1zhHhnHJAkG7mmf6nXdH0/2uzMdCfvAoY0Ww/xOtiJpw9q1qNbYjdz6KUEkANA1Uc9ua6dUAtWgd5wIP/DEah6k0Lqb+N/4DRYxo+1dOR7qLUfvXKLeSL6lBdOE/85eycMjCYFo42a53bhqUXaQCpZwFHbyaEuMK+cfgUxjfKjjNGy+d9DytnFg1H4j9hlN7YDNQp2NJfljW9DvdUQRS8qR5qLXfS5XIM6p2UPSaA3ce9q/n2U24SnMxWuRc0xWs+k65QnaMD/fC0Wf07QYpQ+bqml3s3GVcZ6vYcLaXxzm/XsRHsa2Fh0RvBwjIO8wwOfSGEXt34M4bBRA3NSU//CJQNsW4TNwZhAWtMuQ90U1iiMdLBR1E5n+OvP90RJ/Fw4WiRc2n6RX9MlH
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(36756003)(356005)(41300700001)(81166007)(86362001)(426003)(47076005)(40480700001)(83380400001)(478600001)(7696005)(54906003)(5660300002)(26005)(1076003)(36860700001)(186003)(336012)(4326008)(2906002)(82740400003)(8936002)(40460700003)(316002)(6916009)(70586007)(82310400005)(6666004)(2616005)(70206006)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:51:43.2382 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6c4ca08-8616-4ae3-bc8c-08da9604703d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B077.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6566
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Why and How]
- Don't skip bottom and next odm pipe when calculating
  num ways for subvp
- Don't need to double cache lines for DCC (divide by 256)

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 .../drm/amd/display/dc/dcn32/dcn32_resource_helpers.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index 237f71d9304e..14787e0f0b6e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -66,8 +66,11 @@ uint32_t dcn32_helper_calculate_num_ways_for_subvp(struct dc *dc, struct dc_stat
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
-		// Find the phantom pipes
-		if (pipe->stream && pipe->plane_state && !pipe->top_pipe && !pipe->prev_odm_pipe &&
+		/* Find the phantom pipes.
+		 * - For pipe split case we need to loop through the bottom and next ODM
+		 *   pipes or only half the viewport size is counted
+		 */
+		if (pipe->stream && pipe->plane_state &&
 				pipe->stream->mall_stream_config.type == SUBVP_PHANTOM) {
 			struct pipe_ctx *main_pipe = NULL;
 
@@ -118,9 +121,9 @@ uint32_t dcn32_helper_calculate_num_ways_for_subvp(struct dc *dc, struct dc_stat
 			// (MALL is 64-byte aligned)
 			cache_lines_per_plane = bytes_in_mall / dc->caps.cache_line_size + 2;
 
-			// For DCC we must cache the meat surface, so double cache lines required
+			/* For DCC divide by 256 */
 			if (pipe->plane_state->dcc.enable)
-				cache_lines_per_plane *= 2;
+				cache_lines_per_plane = cache_lines_per_plane + (cache_lines_per_plane / 256) + 1;
 			cache_lines_used += cache_lines_per_plane;
 		}
 	}
-- 
2.37.3

