Return-Path: <SRS0=hpB+=NE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB41C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Aug 2021 06:35:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90D5160F57
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Aug 2021 06:35:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 90D5160F57
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3ABA06E51B;
	Fri, 13 Aug 2021 06:35:58 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FA826E51B
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Aug 2021 06:35:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibaYHtTQHVuQTderoK2cCxyi/lKFdT53AtWvc6Yq6X6K+WIpz0fYLlvRk9X9/HIdtyJAaG841KVIYLDeGyzfdRHAF/I6dGd01C8X71gykk7pfk2yxh+WWPeZtj6Tn1J1foDEX2LrEopLnPOZnNPxXM6isaYM03cAWyxOJAZlSDSpONbclLUUgICPKhYW7TPd16fCRbSSlXn0aB0K7c1mvtoPJBAwCcyn7NkGVe8tWM4ftmAgJOYUgNdf2McYOlS+zSXHw2d8fILvXHlt2asqH9ZFj2t7mXXqjVHGwy4c9FCHZWKYZxVml/35Bn3ICYytwPcqxAU03AmqnI0MzYvuPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ueSjKO9JKYrfcq/ondxVPuHzSiqE5Q4PTu2/0KWM9vI=;
 b=mQjL4zLm1BBGnLArG1SQMsEmxoG1+Li8G3acKxVozxOrSnnLLMx/zlHK3rBR2Er3h4nrdoUAcUUmJg637YZVpn9+qxuGuLbXdP7OH+XEkpFOZ9SbwrVO3XEfVl/be377ur3J+gvFHCpbhHkqNcLVDniHc/SJ7hik6ANW8zW1X0fyK7ixEa66ALlmf+OlrPb13DyldcGQYGsAbIN7c2whkI1YL/V38SKmImO8JVZiNA/MFk3L0Xi3hZmM4k2ExmZ/hgclfDuBqlXAp/j6zqPUa9M/mv03beeKZ7HgB3FeHdmFLEngf+hWz1f6QQ1xSV666kw1a5JS9XnA1331blk2vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ueSjKO9JKYrfcq/ondxVPuHzSiqE5Q4PTu2/0KWM9vI=;
 b=RWPfum5RL9Hf4V85xO08heKoVdbf029RdBAlRSlm4mr6OpNKFHYlNIp6tG1vGr/vUSS31rEC5Lii6RDjvJXFFq59g8sydV0XBFbR3FqwzzKVLAy7YrFTQmZ5ozRAss23aVLUTvV3lGUdsKzq9ZABR5FvEQsPCk8MjdMpe5U67X8=
Received: from DM6PR07CA0081.namprd07.prod.outlook.com (2603:10b6:5:337::14)
 by CY4PR12MB1941.namprd12.prod.outlook.com (2603:10b6:903:11a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Fri, 13 Aug
 2021 06:35:55 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::cd) by DM6PR07CA0081.outlook.office365.com
 (2603:10b6:5:337::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16 via Frontend
 Transport; Fri, 13 Aug 2021 06:35:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.14 via Frontend Transport; Fri, 13 Aug 2021 06:35:54 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 13 Aug
 2021 01:35:53 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12
 via Frontend Transport; Fri, 13 Aug 2021 01:35:51 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <Qingqing.Zhuo@amd.com>, <bindu.r@amd.com>,
 <Anson.Jacob@amd.com>, Aric Cyr <aric.cyr@amd.com>, Wayne Lin
 <wayne.lin@amd.com>
Subject: [PATCH 7/7] drm/amd/display: 3.2.149
Date: Fri, 13 Aug 2021 14:35:02 +0800
Message-ID: <20210813063502.3106309-8-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210813063502.3106309-1-Wayne.Lin@amd.com>
References: <20210813063502.3106309-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9d11c2a-5d1a-4c20-75e4-08d95e249a2f
X-MS-TrafficTypeDiagnostic: CY4PR12MB1941:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1941B5266EAEF984ADF79E7BFCFA9@CY4PR12MB1941.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yDfMfaH1G5MVUKut/fysM+YICxWbAzDT2+QbCVrVsXUI7cDXiXc/6ECdDolM6IPj+8G2nTdOU5oz7/7jlFzKZzYhplNkY4XCSqJ6/p4o5lkYCpCzWTqQL7z7+bggO7f8RlVZ4yx+8o8v+UuLCkxNoUv2WA7SOxSh+Au5HR52Yatmt/uZACZiMewDz0HkJA+otu35Kc7TxO0EpMHBGkeqmIennKHqijuxhNCMEDjGmVJ4cl/MMgos0tg4V/lTGhWXvjGVo7wlsd+KLWpZBE1Oq2fnJuZ0Dsn6yUK8a9TY8GMxakPxM+62o46L5KbhOUy0nIad27PsGeVa2tCv8hPzAD401MlOr3NhkOVnIMldN4YaOmDlcTZQjVZ/rJMHI9N3tSTVxjUl6PEcAIwg4sHgt0qM9RInV4BlIqzNtbLqIlutOT4XsA5vnFuIraw5SZHpmndNLGbKXFJfxqez2qnUQSpb4XtEwZ3u9yHzJJiNJpLlP6mWN3SFw0j1SZUdvvuhh/XZ+oZgB4aJdR831N7QClyC5eFeIQuex4U6QtM7UEu0ITu0b9JkFnGgx+U1sKowpPqypT4gkbo5xotsxCH7EFREK7aQlq8AbYt7dvfRt8PFtflRh1PjdKHsx53ycyxDo0IIr23hCeQlCkhpxfNmyTCgpsC8ELf0pRPxEozP+OV9Rl0zYuoxqUCtFqrrM+gtQdEQoU+adk5HmiNYQGxUeiqTRXnsKN5UG1RylyRAwSzlz8cNPAxzP7BRZ4ygzqnRAMDt1kKpIBGCzaUPYbunMw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(36756003)(508600001)(4744005)(8936002)(36860700001)(186003)(2906002)(6666004)(5660300002)(81166007)(2616005)(356005)(7696005)(336012)(26005)(82310400003)(86362001)(34020700004)(54906003)(316002)(1076003)(83380400001)(4326008)(47076005)(6916009)(426003)(70206006)(8676002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 06:35:54.7331 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d11c2a-5d1a-4c20-75e4-08d95e249a2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1941
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following fixes:
* Ensure DCN save init registers after VM setup
* Fix multi-display support for idle opt workqueue
* Use vblank control events for PSR enable/disable
* Create default dc_sink when fail reading EDID under MST

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 0494e6dcf4dc..3ab52d9a82cf 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -45,7 +45,7 @@
 /* forward declaration */
 struct aux_payload;
 
-#define DC_VER "3.2.148"
+#define DC_VER "3.2.149"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

