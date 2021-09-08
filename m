Return-Path: <SRS0=RbrA=N6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470E5C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:55:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 170C160E77
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:55:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 170C160E77
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4FF86E200;
	Wed,  8 Sep 2021 14:55:20 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2044.outbound.protection.outlook.com [40.107.212.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5828C6E1F1
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Sep 2021 14:55:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DF7FGhdSitGMh6EoHdISUBSm0aQRi+P89mywuf029IyvdRWKuwi6kuvzTfnYn1mcxUO+NvdxIgNOGBH7dQ50wOXZsgnOJmArEV+NhQ04z5sorHpi47cC8u+/YdwKkH9KsZtJCFrMpfoveRS9BVeV7EwqZX9JlyHfcZWJqK7/pU3Nt9Ckrw7b8UWCzKMUqpEkTN+wNwT/fbxBICQLDsLIlwBHauElC7NZSBCoRNJEPUYBB/0v+ftucKEdjcrRTvtEbnwvx0ZB0s/7o4NLZt5mgeO5ZOIR1wJh810Rbo0wVXyU1sAMQfwrWqUt4UsaAyHfqdJ9SL85xefneWztmG3Ytg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=aaI2N/L38AuBSOFtHClWRG+3YPD0k+4qYGC353z9/MM=;
 b=GHJnNK2nG9vF/BURPg4D8bWpzdnanhs38htjlfSm/26g5FoI576gPy9KnxpaTBAqF8Db8N8r6ETFj/+2OFVJbdv2V3sSEdvw5u5vps5qafglC/quIkCnrv7rTjmL3ci+A92+Bvip9/Wz23NzH+sQsa0l/TNLVH7EU4sR1wpFqCkq+OwhCOSgoaVcDgimBdy+pvUy6TBeOtACRs1h/z8sCkoDvFkRgFb7cLmI6GIu+x3mnAi59r1B4fIvcJqkAYnOygQbonDtwMnOhVJlSBTClAQI8JdamGrpmF6NvL2UXCuXsah+ZanJLn5P6PZJ1AaQHqbXKfoWWmN9VsfYx4WSnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aaI2N/L38AuBSOFtHClWRG+3YPD0k+4qYGC353z9/MM=;
 b=iH1di8bZs6MLhP/f1Zw3H+xzlbAumA1qhcS5AvQxWPD+QYjd1VEwbUTI56KobFFWjWmrfaIedn7hM/76ViFZeXZl1oBC/lRO7g0kWVA0J+vwuH15ClCj3Ci+teBS2hNbtRy3NFq6xova4uLPdiUoSd/m/QApZVLzMXOBMKmExTQ=
Received: from DM3PR12CA0072.namprd12.prod.outlook.com (2603:10b6:0:57::16) by
 BYAPR12MB2966.namprd12.prod.outlook.com (2603:10b6:a03:df::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.25; Wed, 8 Sep 2021 14:55:17 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:57:cafe::74) by DM3PR12CA0072.outlook.office365.com
 (2603:10b6:0:57::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 14:55:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 14:55:17 +0000
Received: from DESKTOP-9DR2N9S.localdomain (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 8 Sep 2021 09:55:13 -0500
From: Mikita Lipski <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Michael Strauss
 <michael.strauss@amd.com>, Eric Yang <eric.yang2@amd.com>
Subject: [PATCH 33/33] drm/amd/display: Enable mem low power control for
 DCN3.1 sub-IP blocks
Date: Wed, 8 Sep 2021 10:54:24 -0400
Message-ID: <20210908145424.3311-34-mikita.lipski@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210908145424.3311-1-mikita.lipski@amd.com>
References: <20210908145424.3311-1-mikita.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 610ac1e6-ab55-4f7c-6663-08d972d8abdd
X-MS-TrafficTypeDiagnostic: BYAPR12MB2966:
X-Microsoft-Antispam-PRVS: <BYAPR12MB296639F38EAE45D78D748EEDE4D49@BYAPR12MB2966.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jTagdPXenVUefDjt7crOlMNyVZCnGVtL8b77NHNVV+BlDbBT23p0FHlQZkGFVAw3s+fsUnH1LAkZynAUtb3tuwGhdUTZV+uvzWWiKQamJLcJ8LYspw1Ubz9i6jNF0R2CuVJ6A8YbW9VlpUDl3WO7lA+pWvbC5kDiECotQb5wrkr21wQv6EWPGfMEc3HXbuYnOPEbBMhmr0hYfdBTaByShNWgkhtbbcEzrQxPwdZjcZabc3J1SVqYJFHpNxnirrnhYnnqD2z9YqMglNtX4e4WctcG5K6hB0bmT4m5bM64qqmnnCj+vB6wiE8LdDr5UoZIXIQl9PNNQkNL0z0WNF9GnnxV6jkfAur89bDgJcTk9tkszMEAZBT0yRGZ5Agga3qPLnya1h9KMr4PhSnFOR65iDpsRccOW74o6YFiv0mvMht6J7PLcQ6pUtLQ2ZdJBB+WrA1I69Ur1DhVQnZUc1XTPny3uGhghSnHHGWN/CRGbKZUMPq0fb63fs6Z+/QrNquVca0uXSfoETWUQGKU6o1MZ2FuLHYWnveR2kOVUCzXbp2Fuxr2pU3R007JjpYi5PFDoU8LP0R03PlTBQ1XRT0HhfbNrenSfxh6pYYc4hoarPgQDUgxg10/rU0y0QeJ/gZx/9Rg8GsFGCE+Q6Kr7Tc285MWrOCNUAnr9s8HFlZUYDfCvsUbTA5rImTvbmfmKpggGbsu9IwNOpYHS14PsYMW3DjmxwtU7sHvUgw+0vPvBYA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(396003)(376002)(36840700001)(46966006)(6916009)(83380400001)(6666004)(70586007)(36860700001)(70206006)(54906003)(1076003)(2906002)(316002)(4326008)(336012)(81166007)(356005)(44832011)(82740400003)(36756003)(8936002)(47076005)(86362001)(478600001)(16526019)(426003)(26005)(5660300002)(186003)(8676002)(2616005)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 14:55:17.0568 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 610ac1e6-ab55-4f7c-6663-08d972d8abdd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2966
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

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
Sequences to handle powering down these sub-IP blocks are now ready for use

Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Mikita Lipski <mikita.lipski@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
---
 .../drm/amd/display/dc/dcn31/dcn31_resource.c    | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index cf6392eadaf2..613d34bde7dd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1009,15 +1009,15 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.use_max_lb = true,
 	.enable_mem_low_power = {
 		.bits = {
-			.vga = false,
-			.i2c = false,
+			.vga = true,
+			.i2c = true,
 			.dmcu = false, // This is previously known to cause hang on S3 cycles if enabled
-			.dscl = false,
-			.cm = false,
-			.mpc = false,
-			.optc = false,
-			.vpg = false,
-			.afmt = false,
+			.dscl = true,
+			.cm = true,
+			.mpc = true,
+			.optc = true,
+			.vpg = true,
+			.afmt = true,
 		}
 	},
 	.optimize_edp_link_rate = true,
-- 
2.25.1

