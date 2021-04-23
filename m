Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA84C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 02:40:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84323613F5
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 02:40:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84323613F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 272D16EB29;
	Fri, 23 Apr 2021 02:40:28 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8AB06EB29
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 02:40:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYpdcxMKm9CDhhfYhZvzRf1m6LucISLBLiPMgVLirmE3z/wCXbFBB2skdostuzNihacnSD829Vc5fw6bXf+UD2XU9wRwIZxG/2aL57eq7x4U3tALPTGxElfjE4oOFJWsIRrwB4sLMQtC9cvAYKLJHMTqZIjzsx+p1NwKf34nL0VYLTvpVqtEafGdx+6PlWzgPafpNKEX79Po3ZcLjk8Z5aWqNMrU9TlR3epyCBQiZi9zuZHzpMC301+SLrAM1i92kBUIVecPAh8CCZaWr1jBTLo3ic2V6fjgXpGbkRt2gfSiCdDCz+2rvE7hz79qCleHc050+pR68XXABECNMeF6VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdHJM2D5+9W/GNnqPcGAIinSnP/vJRHOawFB2Npv+f8=;
 b=e6/6CtRchzVQ1qAiBn/4lM9yu4Y+43VzCZdqAr2qjpt2KxTUY9O42XkJUg2rXMbG638FHvAZ/g+XkaNnAt+MK/NeK2Wtcm+xavE0SdEknrlV9oAV4tqZqkdG6oiIiAQMZAz/e987jYG3tv/fe+lZ5BkX5n+xTsZ+P/KLnRFbexvMpJ9qqMER7FdZyyDDujs8fVEXirq6MRilGGdkEwJTikrm71k6VK1RVL+qUq+MwKoLnJZkgjv9gjUILZpieS1oGoVs8cTU58soID75XXhfcKgeQBi+35WR9QL2FcAFOqg9I4BUimNgUW8D3jSee/ueLbotiyqogjHxXHmXwibCgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdHJM2D5+9W/GNnqPcGAIinSnP/vJRHOawFB2Npv+f8=;
 b=4LN7DyA4Lrg/7HbVvgrmLQjlvH4BlhRGXCxrcUvim3Dn9crEtK+B+7v/DZKNXpfR3dfz3PzG/OSBFqKGQ0wodHqptuWNWFuft00IZhzj30VjmoGOV1ZV0jjLmkehlR4QBPRIrKmP0qeSIUcpiNjW5ioDTVo3dDNO3HrLEwyEcJ0=
Received: from MWHPR20CA0009.namprd20.prod.outlook.com (2603:10b6:300:13d::19)
 by DM6PR12MB4987.namprd12.prod.outlook.com (2603:10b6:5:163::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.21; Fri, 23 Apr
 2021 02:40:24 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:13d:cafe::b1) by MWHPR20CA0009.outlook.office365.com
 (2603:10b6:300:13d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend
 Transport; Fri, 23 Apr 2021 02:40:24 +0000
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
 15.20.4065.21 via Frontend Transport; Fri, 23 Apr 2021 02:40:23 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 22 Apr
 2021 21:40:23 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 22 Apr
 2021 21:40:22 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Thu, 22 Apr 2021 21:40:20 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/16] drm/amd/display: Add new DP_SEC registers for
 programming SDP Line number
Date: Fri, 23 Apr 2021 10:37:07 +0800
Message-ID: <20210423023714.22044-10-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423023714.22044-1-Wayne.Lin@amd.com>
References: <20210423023714.22044-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 427c1d10-a157-44a6-79a3-08d90601254b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4987:
X-Microsoft-Antispam-PRVS: <DM6PR12MB498792573A6A863055DC234BFC459@DM6PR12MB4987.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ++xh/9TgZS+xCiYL55dUR4Y3zZfiWq9yGTg8uoyLY2WwolV9Aru/8eESXr7b9vHDApp5WsNeafnwhWY+VtQuRqNzCFNoQ2blc6DPMJzr20M7N2WFGNiPw27FxSq47an3Vnth0UUmj2TAe9+1efQ7g5v/awyyHZTmyyrtU+Ujx7Acy1FL/cM8O93DXaJRjWPrxCmRA1uVp7l0h1ROEBQHLH5Qlyh4ohCDUtzpWZAw5lmkNMbB7AB3woz1D7XZdAegN2f5laKrO0SAKWybh8G0Kh/Ts0Eoxlvg9lUkryHBQ1MkMcCFHhAyIpEVZ2GOClpdVETODYEDg4V/KbO56xZCp7CqmF8gf28n1KiTSsWrnolXpOk9jRzslxUbna+kaogcPG/rSBk5B5uNftAGw23Iz3M2pRL28M2INaBqw4U7iLT3P3V1vWq0R3YLben7l1dyalSnzCq3qv40E56TgifhGMgMF2JCkSHi+PRnJiC6RmtboHgEpeq4KbbdvK4JvZXX9DtnlTpWnifkuiaHlJfesmFKWr2b6Kf46JoA1xEk5f6drG6EeiOXAtxCF89/xy1F0UzJvlnEkICS+7o9siGkSB0gG7SvEdt18VIBhogIg/F29mmyU5qFnqhVIbj1rsWuAgDa923YvjJ2W9re/A1svLHVYImAIrpqp/eIl62NI97mfVGWFM+No8wyy8o7o+U/
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(39860400002)(346002)(36840700001)(46966006)(8936002)(336012)(47076005)(26005)(36860700001)(82310400003)(8676002)(7696005)(5660300002)(426003)(356005)(186003)(54906003)(1076003)(6666004)(70206006)(6916009)(81166007)(82740400003)(70586007)(2906002)(4326008)(478600001)(2616005)(86362001)(36756003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 02:40:23.8523 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 427c1d10-a157-44a6-79a3-08d90601254b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4987
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 "Max.Tseng" <Max.Tseng@amd.com>, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Max.Tseng" <Max.Tseng@amd.com>

[Why]
Add register for programming in new platform

Signed-off-by: Max.Tseng <Max.Tseng@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Wayne Lin <waynelin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.h
index 0b1755f1dea8..a8f49ecb84ba 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.h
@@ -169,7 +169,9 @@
 	SE_SF(DP0_DP_SEC_CNTL, DP_SEC_GSP5_ENABLE, mask_sh),\
 	SE_SF(DP0_DP_SEC_CNTL, DP_SEC_GSP6_ENABLE, mask_sh),\
 	SE_SF(DP0_DP_SEC_CNTL, DP_SEC_GSP7_ENABLE, mask_sh),\
+	SE_SF(DP0_DP_SEC_CNTL1, DP_SEC_GSP5_LINE_REFERENCE, mask_sh),\
 	SE_SF(DP0_DP_SEC_CNTL2, DP_SEC_GSP7_SEND, mask_sh),\
+	SE_SF(DP0_DP_SEC_CNTL5, DP_SEC_GSP5_LINE_NUM, mask_sh),\
 	SE_SF(DP0_DP_SEC_CNTL6, DP_SEC_GSP7_LINE_NUM, mask_sh),\
 	SE_SF(DP0_DP_SEC_CNTL2, DP_SEC_GSP11_PPS, mask_sh),\
 	SE_SF(DP0_DP_GSP11_CNTL, DP_SEC_GSP11_ENABLE, mask_sh),\
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
