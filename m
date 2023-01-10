Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D22C54EBC
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 16:58:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C90510E617;
	Tue, 10 Jan 2023 16:58:27 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1519D10E615
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 16:58:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OM0zhriipYzauu6iTB3GbBWQNggAflLKOYHdmc7voCSoG1heAPvysWNDKOL8xO8+waPZY723dc8eqUREWbhbfhKQsj17ne7dgRqSNBSwFm4wKHkwW1AO8M1nSjuC8eLV7uTomup5UdtX4KFyfMnX3BYbJsxUnD/iqJYDOznNNNBX/BAicoVGgfpOHY1cs7GzzcrBVt0tccGOFX8I/we3UXodnw+8M/KZHWOFBOIAfopkibTJFzEFbKFgzWk5ufNq6aM4NQI4QEAAyEPi/MHWQUzUvQ1LH7/ZcDyPDX8fBFrDu75vzqZIg0HOffWB4VeDO1H8ZyKq5bOexzF4Xnhq8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQG6rzEArMo90WOBBCRdiZnWwO5rTiQcpA2Yq7PY2SY=;
 b=aYrj0vkeT58l5opv0E/vpj+/Tc23GIG0mn7ki6wY0Plg06x4uCuTsdyfGiuVEAiBMOzYG3UkH88UmDeVqBdfM2zT4I4bqWSCKWQSb1/SfqZyiOeQJUitcXk4NeTTMoLtwGh/PY/PKlQCMopSkzTCPNnt0h3FQh70oMSlvP0HAzA+StQW7OGioXyuZGXGWLcYvqz+g6AJs/n+N7hhUIhrdhUORm2nRxwaP4lWpC3jpYqJg5XJ08Vs8OTSH6AlW0afzj+bM6FRZ1uCU3zMtsIG8DX0BjCRKAXfS7KXFqlZmyjmDyZpGmegFouMB42btExhUIYyjzl4PbHjFYyXtlG0FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQG6rzEArMo90WOBBCRdiZnWwO5rTiQcpA2Yq7PY2SY=;
 b=AzZur9HzXeBsop+MfjVawd91NFRPZzzpIho/rWHv703c/YJHsGMc6CnMBVV+Sew+x9n/Cp4C3CO85F/30jPbmAPu1GyOIsnE0mziezaNSQ+cOM/nbHKZfbuBr0ABzaH0w05IeWX4dz32M2xXltFLzxnL8jasJbtn+QZbJHae/BU=
Received: from MW4P223CA0012.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::17)
 by SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 16:58:23 +0000
Received: from CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::f3) by MW4P223CA0012.outlook.office365.com
 (2603:10b6:303:80::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Tue, 10 Jan 2023 16:58:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT112.mail.protection.outlook.com (10.13.174.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Tue, 10 Jan 2023 16:58:23 +0000
Received: from atma-again.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 10:58:20 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 22/37] Revert "drm/amd/display: Demote Error Level When ODM
 Transition Supported"
Date: Tue, 10 Jan 2023 11:55:20 -0500
Message-ID: <20230110165535.3358492-23-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
References: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT112:EE_|SA1PR12MB7199:EE_
X-MS-Office365-Filtering-Correlation-Id: dbde295f-76bf-461e-ba3c-08daf32be272
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ua3FkuV/238SuvpXX+wQ0QltebjdpP2rShFxfmE2HMlobGktd5RvlrshSN2JON4BZI9uYbKpTQylthK0tfo8H9zdeIu/p/IsnoPtSheX0720hVI1EgjFCRbbSTRPl7XeHRpY5sJVBL0/1Ry9rmmK/2r1oDm0XGDWkrfuSiQG4CNVPd352xNlHsb+z+hmtHcnwd9pp/wB7khawzPnNosdu2pHBmV/f17NHRhlhLKXvC7/9CCTmvt3d8Kpe5XkanuOGrVCuMGBiXnSU79Fkov4PM54Kheorhp1jI27ZUN5Y4kt3XEWmiglIZO8G52XJM43PvDyaYxxKQL6pypWJfrHYtywY3t1h40u5wqPn/1CCWM5KctBU0bgEyp+BgkYQ8UeemN/CTcqvDpnTe9ASM01Ocl3tefz1TYCfk3yWekwIvuVhDDO5l/SLDVVuABlpmoc87bMzdFYYQ0CBf8fBdiycbCeMWk1xmKHnHWs1NuHKkKgO7bVjrxyUtxA5mmgnLEQUsf0L/vIuLsEfsP8l666uSRpqOEoS+10WI4tl1eTomYSZNUc2Df10E448QwofJGgVGZyFgSFNAEbnX/bfnvdlX3BjzaYixp0SsU8PkzZBopuJ7oyEfU9paFf22aPam6kGaPNGOaXlrnZXM/VV+ws1T7nvmIaGgiWfhO7cNr163GfNHVM3qnvRSo5jlBzU6JtVFwPSNrQ1IhvYwDTwJvZjcXJhf3QBsqzb9lxQnLE27U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(6916009)(8676002)(70586007)(7696005)(316002)(70206006)(4326008)(54906003)(356005)(5660300002)(2906002)(40460700003)(8936002)(47076005)(81166007)(426003)(41300700001)(36756003)(36860700001)(83380400001)(478600001)(40480700001)(2616005)(1076003)(336012)(82740400003)(26005)(16526019)(86362001)(186003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 16:58:23.3096 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbde295f-76bf-461e-ba3c-08daf32be272
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7199
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
Cc: stylon.wang@amd.com, Dillon
 Varone <Dillon.Varone@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, jerry.zuo@amd.com,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

This reverts commit 08f4ff51e7667a473ae3d5435942a9dfda5953c4.

Reverting to put in a better solution which does not involve checking
DCN version.

Reviewed-by: Dillon Varone <Dillon.Varone@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index efbfb880f390..91d56a38a829 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -3811,8 +3811,6 @@ void check_syncd_pipes_for_disabled_master_pipe(struct dc *dc,
 	int i;
 	struct pipe_ctx *pipe_ctx, *pipe_ctx_check;
 
-	DC_LOGGER_INIT(dc->ctx->logger);
-
 	pipe_ctx = &context->res_ctx.pipe_ctx[disabled_master_pipe_idx];
 	if ((GET_PIPE_SYNCD_FROM_PIPE(pipe_ctx) != disabled_master_pipe_idx) ||
 		!IS_PIPE_SYNCD_VALID(pipe_ctx))
@@ -3823,16 +3821,9 @@ void check_syncd_pipes_for_disabled_master_pipe(struct dc *dc,
 		pipe_ctx_check = &context->res_ctx.pipe_ctx[i];
 
 		if ((GET_PIPE_SYNCD_FROM_PIPE(pipe_ctx_check) == disabled_master_pipe_idx) &&
-			IS_PIPE_SYNCD_VALID(pipe_ctx_check) && (i != disabled_master_pipe_idx)) {
-			/* On dcn32, this error isn't fatal since hw supports odm transition in fast update*/
-			if (dc->ctx->dce_version == DCN_VERSION_3_2 ||
-					dc->ctx->dce_version == DCN_VERSION_3_21)
-				DC_LOG_DEBUG("DC: pipe_idx[%d] syncd with disabled master pipe_idx[%d]\n",
-					i, disabled_master_pipe_idx);
-			else
-				DC_ERR("DC: Failure: pipe_idx[%d] syncd with disabled master pipe_idx[%d]\n",
-					i, disabled_master_pipe_idx);
-		}
+			IS_PIPE_SYNCD_VALID(pipe_ctx_check) && (i != disabled_master_pipe_idx))
+			DC_ERR("DC: Failure: pipe_idx[%d] syncd with disabled master pipe_idx[%d]\n",
+				i, disabled_master_pipe_idx);
 	}
 }
 
-- 
2.39.0

