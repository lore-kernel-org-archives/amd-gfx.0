Return-Path: <SRS0=nuNM=HA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356F1C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 663BC64E06
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 663BC64E06
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FF686EC1F;
	Fri, 29 Jan 2021 21:28:07 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BF1E89D43
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jan 2021 21:28:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZNf1me7+ZcwShlEFh6DLN0d60W+8nQIaOJ9Tnmivqgi1h4t9beyyWuGFtVncMAB7X18MdPxdqBY6TWDs4bfxICu3Jq6NcihkBgImcFmkWMKpRyipARI+WtbmLaPpgGMiahUWQj0GeJWoCgVpkz672gqXgVBE5s2g0nB8M/s9GpyQBJSCl3xnYzqzKinLpwxkCaSMpFv5eBrLHclmClACGzvQEY7qzsfKj0y2FIofSJibodW1SOFr40xSp0W85hqziG8C6l4uWRhjzkeK7uoW+TOOEdU9TOiJhKMYGYCIU24fUSrQK13xvjA32Gkj6p050P3GbLt0ViZGTuez25Nlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oL3s6oaGAPilqz6ey/1fSP6UA84MaB4YrVTHvaGYmqs=;
 b=d0E/wURyNX6pquX/qf98mhlx3bI4fY7bpVk9uY1my0V++Gn14fE4vcUWjZ94LGAXD7/mHH0tr6U5Dm23fRRMEiST4hEVH/KLbKSTR000USd8uGOyapxa2nV9EaUoOanzZVUubYXuzlJfUIavarkwlSt7q6hHgRDoWgIVCFbUVpBwX5rDQU3ug2vX7RvuKJkjrHt3+VLCzOuIcYKmizjCSWga8iZCc36yLLZI1T6jIiCEwggEjr4NsnzgWosxLhG+Uq40x8Y5XCDflqgabbeiNCTKfHBSz1p5Bx/tvpYXN7r7LYUVuyQUP61Z28q+RoU5W5OzB5t2W6kAa1u/gg9ypA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oL3s6oaGAPilqz6ey/1fSP6UA84MaB4YrVTHvaGYmqs=;
 b=RTh+7/Sp6Zvse4rV9nwQ19KYoej312lSK33v+BAcsjC8EPVhwIMauWBujqKuYPFLnJXC9AjrNd0UEvKqU0pP6yn5bD68xpGgm8DDnwkAgYH/DHhOIi6BO2LILPKkjQncq26A0nETXtvL7u8VVySyYXem6XnPiuPVtzoziGjrUQE=
Received: from BN6PR03CA0078.namprd03.prod.outlook.com (2603:10b6:405:6f::16)
 by BN7PR12MB2756.namprd12.prod.outlook.com (2603:10b6:408:29::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Fri, 29 Jan
 2021 21:28:02 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:6f:cafe::be) by BN6PR03CA0078.outlook.office365.com
 (2603:10b6:405:6f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend
 Transport; Fri, 29 Jan 2021 21:28:02 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 29 Jan 2021 21:28:01 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 29 Jan
 2021 15:28:01 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 29 Jan
 2021 15:28:01 -0600
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 29 Jan 2021 15:28:00 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/27] drm/amd/display: Fix DPCD translation for LTTPR
 AUX_RD_INTERVAL
Date: Fri, 29 Jan 2021 16:27:27 -0500
Message-ID: <20210129212752.38865-3-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210129212752.38865-1-Anson.Jacob@amd.com>
References: <20210129212752.38865-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21f0c09a-84cc-40c0-df56-08d8c49cc1ce
X-MS-TrafficTypeDiagnostic: BN7PR12MB2756:
X-Microsoft-Antispam-PRVS: <BN7PR12MB27567F0311798D5E4F37E3FBEBB99@BN7PR12MB2756.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hXOQwqk4uEoOeZwE5JLoQscS6IdUavEDi97RGBK3tdFnSJJugV1ZggpO5ckSDjUx1UN7IzsOeAyaCcQRd1ii9OgBRfdzcKkfDpQ3H1ukiczbmGgDWXt1JlnoT3QnJNgCgX6TThLKcUjzjimjiIrDIMhktVWshXVYS6kFJPD8UaOMQ5+LBPX/We4Le6SPr777bJFHPqYRlw4zMgMNg6v2N8WgMgjF8DX7z593CpLhRu0PPFy9eyj0c/Iyw+9T3gmvu34heFVGeXAM8N7gN4MkS9clCLgurrFB45zNIJUEBNK+OqG1sWXjux+B3xWEOk8MNAQiAMdLq7Epse/yQkDllVUu9mYumG7NEN8rsLEtTWybEXyMgp/UNlY2VeFxbyXeJZOtR/5jvYjdjkblY50ahQIxpTAKQlOkWbxI29stQ2wNf0SrZ0G4zZjdGKiczZEuwZCkNDv7YwU/0ZekWk4jAsidNV6GbGlWcH8PqhrEOm2Oj4Vim/0i7VtffHqEz/0Oe78yoMvq723SR7FqTsHI2lD0SIO4mO/3uVrAuU2ZDu1JnndJi6HMFuqiR5hzDBvDiLfKJdNz04niKTLk+xh+jw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(396003)(376002)(46966006)(70586007)(86362001)(6666004)(7696005)(26005)(356005)(336012)(426003)(2616005)(5660300002)(70206006)(1076003)(81166007)(186003)(316002)(478600001)(54906003)(82740400003)(2906002)(8676002)(83380400001)(6916009)(47076005)(4326008)(36756003)(82310400003)(8936002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2021 21:28:01.7987 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21f0c09a-84cc-40c0-df56-08d8c49cc1ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2756
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
 Wenjing Liu <Wenjing.Liu@amd.com>, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, George Shen <george.shen@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <george.shen@amd.com>

[Why]
The translation between the DPCD value and the specified AUX_RD_INTERVAL
in the DP spec do not match.

[How]
Update values to match the spec.

Signed-off-by: George Shen <george.shen@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 4149b8771462..78857c97289d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -892,13 +892,13 @@ static uint32_t translate_training_aux_read_interval(uint32_t dpcd_aux_read_inte
 
 	switch (dpcd_aux_read_interval) {
 	case 0x01:
-		aux_rd_interval_us = 400;
+		aux_rd_interval_us = 4000;
 		break;
 	case 0x02:
-		aux_rd_interval_us = 4000;
+		aux_rd_interval_us = 8000;
 		break;
 	case 0x03:
-		aux_rd_interval_us = 8000;
+		aux_rd_interval_us = 12000;
 		break;
 	case 0x04:
 		aux_rd_interval_us = 16000;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
