Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2407C43334
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jul 2022 20:38:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48C718BFCD;
	Fri, 22 Jul 2022 20:38:38 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8D008BED8
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 20:38:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOqSV923vUFOLVGFL/760C4ip/pf+j+NzM+KPhc8Gg3P23nB4m+qKbezJZtDnauqH3CoeGUoB5FMzov5GX8rFHGf1xKsBlNuj7NMxWE/C8dlNYapzmwIg1ZUkAiCdvnmbQJkuooxgU5tKXUuuwcnEYmf+401BEpQNBbcCModgk/QT9icSw7hqi3/a0ELu3FN248AahPz1i9EkvTYY/gFtbEKAE1FrJ7Tpsr82TGKrGGntdFRuMZ2FHyaOdAgxpJjsab8k3Hn1fnbeDNpy6UvmDmZOyzTkojhMJdo5H5tyyNuCFbxmUzZM5aj2kzw9211lmhONfGdpdype98Ap8VWmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8fZyFUi/elYzHpNTSNE6MSJEzOcmO4i4dsDltaDYg9Q=;
 b=ZQ6qCTJSFq/5lTvBaN0RJ0fSxwAHfBA1jlzSc7V+FPAFIu/KtGp6bca5wDbY4Xr3F0Z4JCWIAtpzmA/gmBaG3RWnHSC8BErdT4g0O8ERdRWpOS4Np6b3mDsv4m8RllVciIYES0ox6KhfOtn55yfnB/HQwNEjTEt8BfosgE+THqXozksHEDMHRJtgF57RU9Y/3MwSYxSx+g1xAe9J3zAS4iHCdFVLm0d9X9taf4q5LbwTKCmYF1HaS0yKf5mmspv8mT3n403y379lrgydjlAA+4zZseucnKLxte5h/CzzVXjmLY+a0O2khuFoqvG/3tBpZnqSvgm5N6wy5njDZZnAIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fZyFUi/elYzHpNTSNE6MSJEzOcmO4i4dsDltaDYg9Q=;
 b=4dPNovhqRWaR6dIYAMWQ6AjHHCsRqawhPvTBcsDbAsiWM1s/SauF1d5litNpsn+tni9zwQQlWvKINjYjKSVDccSjXB+1SFn3sx4+J9dUOyqbROwnw5W8RKHLh7Ovg+uLxXyaDojPdDBGoZ47gnuCg9VSVazU44BXlZ4FM/6U/ZE=
Received: from MW4PR04CA0058.namprd04.prod.outlook.com (2603:10b6:303:6a::33)
 by IA1PR12MB6353.namprd12.prod.outlook.com (2603:10b6:208:3e3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21; Fri, 22 Jul
 2022 20:38:35 +0000
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::c5) by MW4PR04CA0058.outlook.office365.com
 (2603:10b6:303:6a::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23 via Frontend
 Transport; Fri, 22 Jul 2022 20:38:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT021.mail.protection.outlook.com (10.13.175.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Fri, 22 Jul 2022 20:38:33 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 22 Jul
 2022 15:38:31 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/31] drm/amd/display: Guard against zero memory channels
Date: Fri, 22 Jul 2022 14:31:11 -0600
Message-ID: <20220722203137.4043516-6-alex.hung@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220722203137.4043516-1-alex.hung@amd.com>
References: <20220722203137.4043516-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccd427cc-de0c-40df-32dc-08da6c222591
X-MS-TrafficTypeDiagnostic: IA1PR12MB6353:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t/ZOUoowTLPYwZ+wLjeMA9JHV91TRJxRHIy1B/4mUkATQra47ihleaZNxE+NHUQkQPMYF+V9svMyMQyZ1RT7+D1tRwEAwUQOw9adAchbRTH530LocS5rrlfrfhrrkSnd7aSzRaTxfSrzXROBzjo1iz07KW+xIlp0tqiOWACH2f4wHgkPeTj23sCeKPD5Jsygr3tS9jlCNPTHzL5AaVoTDjVpMRcjT97UEzoXKizoqtX9ZJWbLbHBy4ANTChHNl+Aoj5en5OM1R9UMGxIgyUj+n92AlNczOAw7orOGNCaLEZuuRsLLMsVewPRZJP33QPun1KaG4ETlVahR07kFGmo8UeYcnwvlXzCOJ3UpFFuXfPrARrKE7zfidOxkgvf2T9U6xTuRX17vC/nQ0tBTpm8FAvEPmHvnXr2liQha0sed5n+xva9VkbUW7jbuNGSuenr9viMaD+cwxkFmE4+w5xp3DcfWSvkAgu1lI6ddQU8Ru6J7CTGgVky9OSlcWUP8sauW1A0wu2uRwHdnVKQO/Z4QjFEzsC3ALutmoDx0ZYZbob3SlDIvTn/w50PCpvwZ16lavkFpCXpmMz0N+2C8bfZfgV7dfzrNcZvbnHj2yFROBTNsqZ5BQyCHy/bRX/xw1KGCrNJ2hve0trTud3MkfGLPb6ZPeVvtMeVGNqdLLM/c/bX0X2bCDoPRu1nAy5eSkswtS5qmyHGNNBWEXzXmfiIBCBz4wFb6HCM2zulcMQLa+DW8W79jdlHQS4soVuzmA9hFwPU1Wn7MQndQkws7TatobyhqlMdv3oqZhEVnMo7Z1ODRv5IcRh8JDy7g+v904b3VxSHPqZZS6KlG7kbS8+j5w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(376002)(136003)(39860400002)(40470700004)(46966006)(36840700001)(316002)(70586007)(36860700001)(82310400005)(336012)(36756003)(70206006)(40460700003)(6916009)(86362001)(4326008)(356005)(82740400003)(2906002)(40480700001)(6666004)(44832011)(81166007)(2616005)(16526019)(426003)(26005)(41300700001)(47076005)(8676002)(54906003)(478600001)(83380400001)(186003)(5660300002)(8936002)(1076003)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 20:38:33.9588 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd427cc-de0c-40df-32dc-08da6c222591
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6353
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
Cc: stylon.wang@amd.com, mark.broadworth@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, daniel.wheeler@amd.com,
 Aurabindo.Pillai@amd.com, Michael Strauss <Michael.Strauss@amd.com>,
 wayne.lin@amd.com, Alex Hung <alex.hung@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
If BIOS doesn't specify number of memory channels then bandwidth
validation will fail due to insufficient BW in DML.

[How]
If BIOS is setting zero channels then use the default in the table.
If no entry is in the table and no BIOS value is specified then
throw an ASSERT for future developers to look into.

Reviewed-by: Michael Strauss <Michael.Strauss@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index 450ebd838505..56ada096c89d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -1916,8 +1916,11 @@ static void dcn314_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *b
 
 		dcn3_14_ip.max_num_otg = dc->res_pool->res_cap->num_timing_generator;
 		dcn3_14_ip.max_num_dpp = dc->res_pool->pipe_count;
-		dcn3_14_soc.num_chans = bw_params->num_channels;
 
+		if (bw_params->num_channels > 0)
+			dcn3_14_soc.num_chans = bw_params->num_channels;
+
+		ASSERT(dcn3_14_soc.num_chans);
 		ASSERT(clk_table->num_entries);
 
 		/* Prepass to find max clocks independent of voltage level. */
-- 
2.37.1

