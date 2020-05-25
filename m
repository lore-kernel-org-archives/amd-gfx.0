Return-Path: <SRS0=Ro4j=7H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84120C433E3
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2020 18:13:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F50C20723
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2020 18:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FYNboDXA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F50C20723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95C856E115;
	Mon, 25 May 2020 18:13:21 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 668CE89C21
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2020 18:13:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6UdAN2hUqgDZjy1Az+3fz41vQ+gYCZnWQOFUCKAuuHDD4TqyNZMUl2AKtepwbV8Iof9aY4lDbkbboxsQW/7Io2jjohVpsRHExYvHkB8JAyTK8S6HMUa3kMdM1PTjwQYIC4Ny+aU/TP0CldDXUHgEecQoLxZdvjuFali9f89pPLD00rBzJI/cLMR/Io36LHV+fgz+RwDgI2xpAnd2mX2awukxDCX10zFBbvdTDiMgI00kTG438/VItPnIKGSxdX8zbZyPuaShz7m7xitWFZginJN9nc0sgjiFtjt00cpD5MTczAVtO0XAdU9eItmcGtubUf4Q0BEsrTj59ZfopG+cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgN1RZjkmteZLrKnyPo5CucXYFOM2qyz9kTYrdMQ134=;
 b=Nv+MeFH5B2mRRtKnRT8Q3MyiIKCn8+D8qXP/G+ROHbhTkw40YCMVP8g/laKY0HleXRTZh2rjzmnJg2UQcrxQYsLKUNd17lVgu8zN0BUdOaLIvJlKat1Q8oLsVphLO6biRfQDpbQMMr0XC4b2oSHYi7CEWkNQhYuGNWYi7kjB0J5pwMiTSOcNS5k5e54gCIvMwqUOrjezaE/ssP/T5Ut9L8Gthx6ZIe9I7MS0Xb/sNl0z5L11EsRTNe3hrqQGiZHRJIcwwRv1HCPR3/+YSU38Hx5ZoG7JXdq3Uhykigh7gG6m5XzNMmc7qnr4X6AiUC/482V+UVAzNkoKw+iEmu1rxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgN1RZjkmteZLrKnyPo5CucXYFOM2qyz9kTYrdMQ134=;
 b=FYNboDXA504MtttCPjEKzszymE4Al19J/dx3ZvGdhAGkzSdISWrqKnV06V/uxK8+Omp8Cbpq00tp0WqckvjqznUIMoku4X50ncrQP4ofetCrmwquoM8s2RwLbbekH+aue/+B1r0yPgDKio3JaXmokrSDUw1HlBlhr5PRWDbW6qU=
Received: from DM5PR20CA0003.namprd20.prod.outlook.com (2603:10b6:3:93::13) by
 MN2PR12MB3070.namprd12.prod.outlook.com (2603:10b6:208:c1::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.24; Mon, 25 May 2020 18:13:19 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:93:cafe::c4) by DM5PR20CA0003.outlook.office365.com
 (2603:10b6:3:93::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24 via Frontend
 Transport; Mon, 25 May 2020 18:13:18 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3021.23 via Frontend Transport; Mon, 25 May 2020 18:13:18 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 25 May
 2020 13:13:14 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 25 May 2020 13:13:13 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/16] drm/amd/display: Allow Diagnostics test with eDP not
 connected
Date: Mon, 25 May 2020 14:13:01 -0400
Message-ID: <20200525181306.3749-12-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200525181306.3749-1-qingqing.zhuo@amd.com>
References: <20200525181306.3749-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(39860400002)(376002)(396003)(46966005)(70586007)(70206006)(8936002)(86362001)(1076003)(2616005)(44832011)(82740400003)(82310400002)(478600001)(47076004)(356005)(81166007)(26005)(336012)(54906003)(4326008)(36756003)(6666004)(6916009)(5660300002)(316002)(2906002)(8676002)(186003)(426003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31e22876-8a8f-473a-24fd-08d800d74d24
X-MS-TrafficTypeDiagnostic: MN2PR12MB3070:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3070BA1EAF0B412E9FC1D8E2FBB30@MN2PR12MB3070.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-Forefront-PRVS: 0414DF926F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XYWvtyAqN6jMIiVf8FJG+BP+zRDrWoRDQQzM0Z75KLcMidYbYHHYlny6x9UKVpGiKdl6+B4JtohA3a0O4jCytztXWNtMjWED7MO2YJwEJa9AT5hg3xvcMPLiQKLZ3/zwq2atRwMvkEimSOhFStw+yTb2i0f+0MJzjuNaLUSAQhpLAue3JLN+FkZVa4P5jbe9PY7RmHXkLN6y2XTS7ns15QGC3bzMvKCnx83uNGHVuMls85Zt/fZnKacnNZmVaBnr5R2TJQNlopntjdyzG51mWf2ZNstjKOgLQL/eVFX2dkvp+KfLn/6kFCupNLIdzdMtq5xE834FiVoQ27uHIFqsijrJJigGhuHd8BsJhnAQDNxGMllXYDrWQRZ0e6LZD+vZUI0A/BZM5Hn1v/NqPBEUxQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2020 18:13:18.4138 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e22876-8a8f-473a-24fd-08d800d74d24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3070
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Eric Bernstein <eric.bernstein@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Bernstein <eric.bernstein@amd.com>

[Why]
Diagnostics DIO test with eDP not connected is required to run

[How]
Allow Diagnostics test with eDP not connected to skip link detection but
still execute DIO test

Signed-off-by: Eric Bernstein <eric.bernstein@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 45cfb7c45566..04c3d9f7e323 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -186,9 +186,10 @@ static bool create_links(
 			bool should_destory_link = false;
 
 			if (link->connector_signal == SIGNAL_TYPE_EDP) {
-				if (dc->config.edp_not_connected)
-					should_destory_link = true;
-				else if (dc->debug.remove_disconnect_edp) {
+				if (dc->config.edp_not_connected) {
+					if (!IS_DIAG_DC(dc->ctx->dce_environment))
+						should_destory_link = true;
+				} else {
 					enum dc_connection_type type;
 					dc_link_detect_sink(link, &type);
 					if (type == dc_connection_none)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
