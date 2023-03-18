Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FEC5C76195
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Mar 2023 07:58:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE46410E455;
	Sat, 18 Mar 2023 07:58:03 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2990A10E455
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Mar 2023 07:58:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JvVK61sfFqpNsFRH+4RIlyK7CfGa4IkcEEb1Zv9pLDKr/Irv6wx0RmHSiSygZiSpBbnhMgcOohFVGDeW/YSprvjnjt76J+8ULnjgHQ32dExeJhWq9nO9J5Hyx/cpkJHrLZP0zVhvdtT9SkopBkv1+Ok07L+wn6y5OA2D+Ggcj49OZa9bYxoR5PP/VjozKyZgo1H0zrx06GgOKgnssSf80/f+oUB0cjHP+KCJBvpp9x/n6Syc7kbOp+/bBfSRBLbKcCUidcIEygzGFmondPzGjOEucOEmFWsUEd7M0kssfervS/nr6cnM4hHi11z7GPdtq/AmROE0uF9+hdaiK7z+dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+g9kewt+CqQlZBGCSHSiv2FMDWwiBqXtmVPG/xl5TA=;
 b=PTdJdUByAQ7VnJnhvyRVjXhpsju1lMTJsfXR+CMewxbO5Hj2eHeTUkR1LvSelPX8V8NnFw5jHlcPAsCcmBcbzHUVk0J7X9bhw79uchggprYJC9cEgkykNlfTlHVVKne7uuk27mW9iPJqbxAb8DKBoBajBE8wsI4tIG1S+28kULlMzAbArYPlrhtz5xW9opWPvgmss+09JWezSSk5XjCQr27pmMZxckuHbmgjez/0mzVKXswjzBeGsrXLFVminymQULFCJ3SMr2dVtQAS63rG65LmoY4wDPTyierGAcjjRFxr6LoL7OqDqLR2Fd9zG4azi30SOS6nuLWwgFBJRu7w2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+g9kewt+CqQlZBGCSHSiv2FMDWwiBqXtmVPG/xl5TA=;
 b=SCqieHdDNGExzmmm3Krsxh6Ume0pwbyOJV8dumUJAwVqMemjEB2IYpbUdkGGbiuhXSQ5NonXeDjQ3JP1OCicEIym90mRM7YHJNMKU15VGrmC+FnX5NHHQ8+sYpzNm08W+CN4yZlYSp4P8XfE//3ME1Je5Tcjj1FFcC8GvZnGU1o=
Received: from BN9PR03CA0462.namprd03.prod.outlook.com (2603:10b6:408:139::17)
 by CYYPR12MB8732.namprd12.prod.outlook.com (2603:10b6:930:c8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36; Sat, 18 Mar
 2023 07:57:57 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::43) by BN9PR03CA0462.outlook.office365.com
 (2603:10b6:408:139::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36 via Frontend
 Transport; Sat, 18 Mar 2023 07:57:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.11 via Frontend Transport; Sat, 18 Mar 2023 07:57:57 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 18 Mar
 2023 02:57:53 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/19] drm/amd/display: Set dcn32 caps.seamless_odm
Date: Sat, 18 Mar 2023 03:56:13 -0400
Message-ID: <20230318075615.2630-18-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230318075615.2630-1-qingqing.zhuo@amd.com>
References: <20230318075615.2630-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT046:EE_|CYYPR12MB8732:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f11fcbc-62cd-4366-0160-08db27867ce3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ADNv2xAhhcIWnb//GG343ZHEWHuR5RiI5HoaUg84qd9cClve5NV7oOGqc2IfPGihU6QOmfQGRQa9gfRBthGRbBo6eEbKJ3A8Ivde5mDE3TNjzFHQCtUzPX0FAwFJOzf9yGkkMg8LQYnsjcc8hVqB7BIT+FOWqVGNOJHTVtOm0n6AehTLoOVLIPHCD4NjxUfImxl6b34l0M80YRFrXz0+2C6YtKHg8pf3IpRTLxF1G6+DlXYmcQVaD/k38XmIjvRVk6IHI8Uti3svC37MgZDS9q42FsnNumO6jyZsCYyNLCMM/J9yyA9eDQM7S/7Mz/pgTNO5vJptJjdLfmhIT1oE2V+gmYXD1/iRom/0/hqCM4Pgi1VyKkMyektW7vft0dmYUBA1IhLNQouQXM4iy5h9w0BHFfn78iaFt3QkE9e8HexJKQYv6FQiM24TAhDmSzQl3/MYbyQ848esNn6W1LTPXe+qGluTwfxpBCpYyfPgVNeUqXQavSbrpqwDRZ24JqazAeZUd2zmhr1+V5ntcXKFYBOYR6ar9o8XPs9UbcpJD2nKvvvjXWW2rqwi22nsIxT58mRN8oLsIrzeItAXeVcmTXjwkZCQSvJJ6kh1ZzW5bw4lmUZdVn6EpiosuKUyeGpL5DhczGt3zg4lEPVzfEwthxVJOa1c/qPxyI+Q91burpBmHClIZLoO7ykj5euqY4HZX1aYsbMlKlKAK+S36T8g5rWgP7Mluo3lR/qxYqukioA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199018)(40470700004)(46966006)(36840700001)(86362001)(40460700003)(356005)(36756003)(8936002)(41300700001)(44832011)(2906002)(5660300002)(4326008)(6916009)(54906003)(478600001)(8676002)(70206006)(316002)(70586007)(82310400005)(36860700001)(40480700001)(81166007)(82740400003)(6666004)(1076003)(26005)(336012)(47076005)(426003)(16526019)(186003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2023 07:57:57.6941 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f11fcbc-62cd-4366-0160-08db27867ce3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8732
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Hersen Wu <hersenxs.wu@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hersen Wu <hersenxs.wu@amd.com>

[Why & How]
seamless_odm set was not picked up while
merging 2d017189e2b3 ("drm/amd/display:
Blank eDP on enable drv if odm enabled")

Fixes: 2d017189e2b3 ("drm/amd/display: Blank eDP on enable drv if odm enabled")
Reviewed-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 633491331722..1715909b1225 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -2185,6 +2185,7 @@ static bool dcn32_resource_construct(
 	dc->caps.edp_dsc_support = true;
 	dc->caps.extended_aux_timeout_support = true;
 	dc->caps.dmcub_support = true;
+	dc->caps.seamless_odm = true;
 
 	/* Color pipeline capabilities */
 	dc->caps.color.dpp.dcn_arch = 1;
-- 
2.34.1

