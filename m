Return-Path: <SRS0=42b/=GZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9304FC433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jan 2021 20:07:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F79923AFC
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jan 2021 20:07:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F79923AFC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E87D76EA50;
	Fri, 22 Jan 2021 20:07:18 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760074.outbound.protection.outlook.com [40.107.76.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7C7A6EA50
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jan 2021 20:07:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+Idh0VOYmkoZ+EtSy2Bqqs7fkncJB0qBRMPHol0FvP58uyY/P7eibh5tQzYxE4Or2LKTbCQ/2nzfNrDzTp0yDHLTtUuSocCj5bRfXjM5dY2z2A31vESxIV8WB/OK8wswsiOl/L+L8HGoS49NuziYrADizH1egz6/Wl+MpGXWEMLq1z7jGtB9fCrfsEScIF10M0BnDUyXapTWmMEeh1jRm/Q+JOcv8lS3K8Mkfs2ctt1Nwm9P6EzLlV9CZe9pTqBIKBXaS/3FBYlKSWk85CAuFCipifh7IDQszHmcOYHrA3j2gmHJYvfFgFGx8bTpjkPzLlRauhoMNFXs4sVVQHDuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BkSLWSuj5j2u3pTBUf3XXlkdd8u2qj0yyTRRso5bH6k=;
 b=mDbWZ3YKjyVQdBwLRzD0Ol2TI8ouJyEflb7+3s+7H4A7YhG7vTJD83NeDNBH9oskbbsCzO8Hbg/EJdd0wMRyUzZ+pPj55tSswWlllv0JQNVCwRTwq93WrCShVCQ3lNpmDxrEH6ilGKmTJ7+Pr2x3v27a7V8u1edtDvUmdcE+h0iKU5hJqSi5MK4wCKPmgOLpotR1n9or4rjcrcJGOK8ShFN6nr/gNNpl+jKoJ4j2NmMziRzft3wzjDfNK36gq7o1Mrqi73ZnKGOGTGwWLWKnNSL3m7/Dd9oM3ry8h6n/hVtAWBHJiGg/F9ojBHc0qr6tsi0Ks1Yg5Fpyuk/MA07k5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BkSLWSuj5j2u3pTBUf3XXlkdd8u2qj0yyTRRso5bH6k=;
 b=eAIc5vUeIqDzbRwYlNAFQW/LLeq+YB0pwBQFxvAS+bq6txHOkhDCS39e1VelUFjZ5bISYV4J5ybBnSrM+eF/kVQOmyFv0EayAp1FnJLqyI9bTZa437t6lM2vwepynaDjlWXu/hZgyEWqoNWtH/xlRF2AyU7K1nQU1O64EXX58L8=
Received: from MWHPR1201CA0008.namprd12.prod.outlook.com
 (2603:10b6:301:4a::18) by MW2PR12MB2521.namprd12.prod.outlook.com
 (2603:10b6:907:8::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.9; Fri, 22 Jan
 2021 20:07:12 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4a:cafe::3d) by MWHPR1201CA0008.outlook.office365.com
 (2603:10b6:301:4a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend
 Transport; Fri, 22 Jan 2021 20:07:12 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 22 Jan 2021 20:07:11 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 22 Jan
 2021 14:07:06 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 22 Jan
 2021 14:07:06 -0600
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 22 Jan 2021 14:07:05 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/12] drm/amd/display: Add more Clock Sources to DCN2.1
Date: Fri, 22 Jan 2021 15:06:48 -0500
Message-ID: <20210122200652.197934-9-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210122200652.197934-1-Anson.Jacob@amd.com>
References: <20210122200652.197934-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44a6e6e2-44cc-4f7d-340a-08d8bf114dec
X-MS-TrafficTypeDiagnostic: MW2PR12MB2521:
X-Microsoft-Antispam-PRVS: <MW2PR12MB2521E3707412B106DD88E6D0EBA00@MW2PR12MB2521.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4tXLtyENq0KK6J8fj5ttaU0oenma1O8KpGCzqWlr+Eo1MY9qKOqiRMS6g8x0WRtCRO46a0bG0an0pYuoLTM9Cdq7kUwpMLDa0w2ukqvEyZux1APjYVoyvN3ofsTg79EO00a5MWtyBKQUc1qyYq6zEPISUV4B9ItoeJJfoMqM0lIiZ/2L6ySrOySxS8IFjELtNvAyknC7p+iRlfLXhtr+swxe95SQz17Z2LuiQYzt5Tlzyby1z6N7rLnVcIA926SMvqaggmPHLRz1jMkAKtj2uOaLNSM3V7/+5QZyK2kQqy4NMMajH/ZTpI0/lmp/6G7HRRa/9dgJqxk6CWO1sxIG75e2qQ+BMQFfhCKyQiaRDINfrM611K0yLGXdYiTh7E2o+6aW7gRV0e/m+EWjJ5lJFE3LiBL3Ke9DK47FqPP3MAKX5zRNiU6AkI+e3RmLaxDCwit3pmVAe2vY610+P2A187UpkHXy2Cq/orcp/U0GFKHgbNXuAVN+UgkAXpmza1wQ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(39860400002)(376002)(46966006)(6916009)(47076005)(54906003)(316002)(356005)(2616005)(7696005)(336012)(82310400003)(426003)(83380400001)(8936002)(478600001)(186003)(1076003)(26005)(81166007)(36756003)(82740400003)(6666004)(4326008)(2906002)(8676002)(86362001)(70586007)(5660300002)(70206006)(36610700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2021 20:07:11.3910 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a6e6e2-44cc-4f7d-340a-08d8bf114dec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2521
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
Cc: Sung Lee <sung.lee@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Tony
 Cheng <Tony.Cheng@amd.com>, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Lee <sung.lee@amd.com>

[WHY]
When enabling HDMI on ComboPHY, there is not
enough clock sources to complete display detection.

[HOW]
Initialize more clock sources.

Signed-off-by: Sung Lee <sung.lee@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index b000b43a820d..674376428916 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -906,6 +906,8 @@ enum dcn20_clk_src_array_id {
 	DCN20_CLK_SRC_PLL0,
 	DCN20_CLK_SRC_PLL1,
 	DCN20_CLK_SRC_PLL2,
+	DCN20_CLK_SRC_PLL3,
+	DCN20_CLK_SRC_PLL4,
 	DCN20_CLK_SRC_TOTAL_DCN21
 };
 
@@ -2030,6 +2032,14 @@ static bool dcn21_resource_construct(
 			dcn21_clock_source_create(ctx, ctx->dc_bios,
 				CLOCK_SOURCE_COMBO_PHY_PLL2,
 				&clk_src_regs[2], false);
+	pool->base.clock_sources[DCN20_CLK_SRC_PLL3] =
+			dcn21_clock_source_create(ctx, ctx->dc_bios,
+				CLOCK_SOURCE_COMBO_PHY_PLL3,
+				&clk_src_regs[3], false);
+	pool->base.clock_sources[DCN20_CLK_SRC_PLL4] =
+			dcn21_clock_source_create(ctx, ctx->dc_bios,
+				CLOCK_SOURCE_COMBO_PHY_PLL4,
+				&clk_src_regs[4], false);
 
 	pool->base.clk_src_count = DCN20_CLK_SRC_TOTAL_DCN21;
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
