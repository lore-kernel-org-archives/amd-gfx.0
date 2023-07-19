Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3801C001DE
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 18:33:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6606210E2DD;
	Wed, 19 Jul 2023 18:33:22 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49FA210E2DD
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 18:33:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9tepY6CXIAx7LDVdmPZuUk13gIzxCuFAJyjjyC2wvXZ9FCmC6EsfmCpCNJR04uZ4F9Syydxbqx8sAq/4eJqcgFpft90qih/p+9C6AFKeuXhLvS0xc0AMpF7bBYZIaREzX21Mhucu3G39aeLDrHTa0WLSV0kBS2lI0klyg0R+ui7y5teHxvH4scJqN/wenq2HzNgUq8wEQEWvyVESTFwxwaYvK5g450UMctZD9jONeIK91eq3Xg1bkV6FtWNi4W36HuFh8N3hJLt4an9L/gklKY93FoeBwEDFVEMKRNG8jsbl1eDQ6LEsRyyCE6AK8UTWyojnkyryAJiN4kp3O6RTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bu7aZ+od4eA2SnADa6J3IJbKmPFBvSeDGDmfp1remBo=;
 b=HDdHMUNQ5HuPRV+lHZUi5VEeTVHHVV9z9RxW9tkZAj5a4HJDUJA9InSJ40EUIyVHTvXVIXPcjidH46emIfbzYgIv2p9wR3wcMnFSiXiD8QY5YKAZIFtcoQ8h7VxFiaEx3dObQ5+59iCaTlv3TjFFxJRUn6Z432/gcKwonf/Xbe3GVpFXquGOuRGuOJlqGVc0iAY3tjI+tNQuBv73JOnTkmCzfDJVtxdm6JBeoS5Hvst4DX2Lp+WPpFRunyyaap0dRTxLBUzVrFQ0SLnqZ3NHlDMVDBUVTgKBnHnACZI9fytnXC73fZA/L39tydw3xdrWVpZ7yFxAt46UaQ7r+SgLBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bu7aZ+od4eA2SnADa6J3IJbKmPFBvSeDGDmfp1remBo=;
 b=ZbifvwiOHsu8q5sbs1aVXfoiGb+z0TGubY6EYYbzstI+8TZqIo9RvGsOy1TSVyLDNE6EcJFdaaSN1uZhDoRRqrntoMi7jW5cGT4SZ3Ii/YE2q1WMURf/08n1wz+yMulylNVFPwoHOITtdrn/Qs0Qq9LROd0mjfJhcencKOKFgOY=
Received: from BN9PR03CA0040.namprd03.prod.outlook.com (2603:10b6:408:fb::15)
 by SA0PR12MB4414.namprd12.prod.outlook.com (2603:10b6:806:9a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 18:33:18 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::4c) by BN9PR03CA0040.outlook.office365.com
 (2603:10b6:408:fb::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Wed, 19 Jul 2023 18:33:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 18:33:18 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Jul
 2023 13:33:16 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/16] drm/amd/display: Guard DCN31 PHYD32CLK logic against
 chip family
Date: Wed, 19 Jul 2023 12:27:52 -0600
Message-ID: <20230719183211.153690-3-alex.hung@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719183211.153690-1-alex.hung@amd.com>
References: <20230719183211.153690-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT015:EE_|SA0PR12MB4414:EE_
X-MS-Office365-Filtering-Correlation-Id: 46dad545-6f06-4f42-bb3a-08db88869f7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qBjtjHIUZqDJu2gmTG6obDICWvJ1OIk2COyxpjFi4h2wAvq4Tit0s8l380fjanyCz7mxIEpa20udQCAYnP+mVou1zZWAqjoL/wJlepWa1L46Ic66JmZuKrstNMdnr6Wi1Id3t1A50aawPcjJjg8D7lwYdyYN7XUwkNq5PL6D7j9ICklkq6XTLez6+8bnNreNEatw2fQ6nL9dSGKXCITfuY9Wd0R+BW1L22SpjO6rOIluhJP88oI23xm/dHsbt4NoDfWCOdYwhQvFQIMnUhZz8BCWrs3aPBAhR37T0yUe+PcnRcpnFLDdDEoQyPX1aCuE4Jr4Llyr4CZ4xry1uOq9LIvwKSBWJDlAZ9oLDms0le2NnfPmSX8+lVDej/6AT1G5eI/7q/h2CflX1LQ+loU1ON6fMkp4bXD/mWQouMx+6deLowWLNcCzX3okOIm5cok03wGMBiOLqlqNwYVgBQMr4CISvkbOm0N9Q2nJ10cVlERiGrb9SDt/fxcLJtBgKZRlDZ7v3a2MoWV8yUhDnjghR7f5qRu/14can81c578yeUo0ln891/BMUjkEblUsXWj7jwwkRR4NiASrUdvorlgWFwh1TuGesq9d+1oIkAeV9oB+Sb2exNaEKS8M6j9zNS7YSRO2QYCnSocF+Zf7EbeFjZmi1lQFqwBR1t2rjxYUflg8cgqWB0Ny8ibOMbVYvwvgZpubX73Pmgft/j/hP7LT5jhl7YHCoKPLvxWGJOowfvwA0u7gZcCr7QPKXKSxJrAEqNJmmSMmjHcgK4OPdDrSRw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(36756003)(54906003)(478600001)(7696005)(6666004)(40480700001)(1076003)(336012)(186003)(16526019)(26005)(40460700003)(86362001)(356005)(41300700001)(6916009)(4326008)(316002)(70206006)(70586007)(8936002)(44832011)(8676002)(82740400003)(5660300002)(2616005)(47076005)(426003)(2906002)(81166007)(83380400001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 18:33:18.5466 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46dad545-6f06-4f42-bb3a-08db88869f7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4414
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
Cc: stylon.wang@amd.com, Hansen Dsouza <hansen.dsouza@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 George Shen <george.shen@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <george.shen@amd.com>

[Why]
Current yellow carp B0 PHYD32CLK logic is incorrectly applied to other
ASICs.

[How]
Add guard to check chip family is yellow carp before applying logic.

Reviewed-by: Hansen Dsouza <hansen.dsouza@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
index 96b73d79f980..8664f0c4c9b7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
@@ -84,7 +84,8 @@ static enum phyd32clk_clock_source get_phy_mux_symclk(
 		struct dcn_dccg *dccg_dcn,
 		enum phyd32clk_clock_source src)
 {
-	if (dccg_dcn->base.ctx->asic_id.hw_internal_rev == YELLOW_CARP_B0) {
+	if (dccg_dcn->base.ctx->asic_id.chip_family == FAMILY_YELLOW_CARP &&
+			dccg_dcn->base.ctx->asic_id.hw_internal_rev == YELLOW_CARP_B0) {
 		if (src == PHYD32CLKC)
 			src = PHYD32CLKF;
 		if (src == PHYD32CLKD)
-- 
2.41.0

