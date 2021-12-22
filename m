Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DBB6C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Dec 2021 22:05:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF9ED10E325;
	Wed, 22 Dec 2021 22:05:48 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3E1310E325
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Dec 2021 22:05:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBNHQ8FqKMcCtNwvVOhLSAKxOasbTFwBO7MEuOLsYr4jMgLZEY5GMUvr29vP4A7V134ad8MBnkZGVvGV4CPizgRTzo3U8a8AEvsKRjXZYVWSiSgpJZwPLn11BU6+6pRODcNswJAistDvgn2zgtdgwj45I5d5ws3jgS0BmkkBHM6TOwqxKH6CIbxcMQW7fT9qHZkqsqqFRi1Jlw9ybG816CKMqNE1QGjwuSsp1oKNnGqGeIsvIlQdQ5LcCrr4pBODp1GU/jnsy6e/pWd7HGYyTSEChtOQN46+QvGUYwb6kvlz/EBpAg1xICdvJ9+QnusjiZc1/u8BahBQHoVBGCSf/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unZ1JYv6NJXN9E9lomHVN8IEUAmAOaZxuq0saFjF1pw=;
 b=B4X4ClU6bIVKvzYqTlwY+iGXTALewV+eHmA6txEtMedmhLw4dme4Edw2evDqFHFf7CyFLnKIE+5ajGjvPUTuwpfMuXWUz4RKT5EYFc2RSYoU0mgqg57OxH9SLDC+ixki2qMAYO/Vue3XGZ3Hrg3ao2dz8cDw3Ngj4PQZvaSkPKupGjW8ZQtWN4h56z/yPgQuzGq/KGiBdfrbHYafUsWyllJJWmcsOu5zERR6Xe+WqNzs1bk5qz49629/hLUmCIMZqD0VA0vT1nD/pxxDAHlczErCeq7G0m+LtbNNh135ozdKzbRvChzsharqbIn62vQmx+RCYHXVUi7YxzgKijsSaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unZ1JYv6NJXN9E9lomHVN8IEUAmAOaZxuq0saFjF1pw=;
 b=AWURuP63aXi2SwOYl7SP7v8CM7sSVekUc9K5yuCDCvr3NAyjpyzXM3XrS6BjRymE/0hC7ZayiVdWEkBZl6DECHWriuAm1MMaVA3JMynSzZsOUVWXtzOimlC8sPlo59hezkB4KxklxTbj8xyuxTzqPn1CwspazuzPOn/ik0lLRIw=
Received: from MWHPR22CA0065.namprd22.prod.outlook.com (2603:10b6:300:12a::27)
 by DM5PR12MB1418.namprd12.prod.outlook.com (2603:10b6:3:7a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.19; Wed, 22 Dec
 2021 22:05:44 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::14) by MWHPR22CA0065.outlook.office365.com
 (2603:10b6:300:12a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17 via Frontend
 Transport; Wed, 22 Dec 2021 22:05:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4823.18 via Frontend Transport; Wed, 22 Dec 2021 22:05:44 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 22 Dec
 2021 16:05:43 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/6] drm/amd/display: Fix underflow for fused display pipes
 case
Date: Wed, 22 Dec 2021 17:05:14 -0500
Message-ID: <20211222220519.1682537-2-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211222220519.1682537-1-Rodrigo.Siqueira@amd.com>
References: <20211222220519.1682537-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 424e9f1e-0c8a-47e2-4f9f-08d9c59733b1
X-MS-TrafficTypeDiagnostic: DM5PR12MB1418:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB14184AF4B296962726D2439A987D9@DM5PR12MB1418.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q/0ptm2wlQ3SGUpG4ZWFY69P514wBpN7hlYUpoMBCciWunYOOxfw4ewnTb4ZRQh6fKWpql6gfPGkwmLDEj+HxXiu6iqxz67m4oicK30frv9S8/m9iUX58lJu1BqS56IxNolHsbZffumMgkOqVt/V5Nx0mIDjvFnQuWFflhgx/EjuLiAKDVt89FTFKHsBjddpQfbzx0tRy+5EHhjpcIaBsYWxWDq4DXBFVrXIp4PmX6/TcvOjAUppWGC4w434po6sHmdW3LkpGJ1ljyTVX5aVOkP29K/pSZ8xTgnOnc/vtH/l1tJmB31sVDdEWOyesXvlPefFdiKvU/uKuwWg7C88ZWL003u//jjgsXEA3cT2TfJp50aA22WPOAHL9rsXk2nJUrq+phoRxn3rA2HR/8ZcfBI9aOzLseSAKzV+ML0P5sV6xCaT3SsWggeALLzx7EAIEcGWW1dZAlS20yMF0FIRJbleW+XcNmIaQJHjB+bNYnvZzb2JKEngJ8Xccbt2YTAHXxRp8k+Iuc075yum2D3v1VpSVwTMObs/uE6j2GTT67zgKhYZ7blUlBNgW5xiRKK725V6h4gDDtIYos3nftCLsPIZDV5vQ1qVtLNB+OaLrgnpye4unGmguo7217NGzB95dUD0+QztG4lYMfhbX++UXW+v/kHNqnlSSsSbkJg3NrPtCP4hPMk3R3I6axYDks8bvjXWPPuTWJV+ma/xca0iKZK5znFX7AH4zWmPdWdq+/OIp/O7SfLcBW+RRWGiMt+htHhNy8yaKM03te5P7p09syaAmsUCVbuSBrSF9MEoIQY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700002)(16526019)(8676002)(86362001)(186003)(81166007)(4326008)(356005)(1076003)(6916009)(70586007)(5660300002)(2616005)(70206006)(426003)(316002)(83380400001)(36860700001)(54906003)(40460700001)(8936002)(6666004)(508600001)(26005)(47076005)(36756003)(82310400004)(2906002)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 22:05:44.5909 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 424e9f1e-0c8a-47e2-4f9f-08d9c59733b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1418
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
Cc: stylon.wang@amd.com, Anthony
 Koo <Anthony.Koo@amd.com>, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Yi-Ling Chen <Yi-Ling.Chen2@amd.com>, wayne.lin@amd.com, mikita.lipski@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yi-Ling Chen <Yi-Ling.Chen2@amd.com>

[Why]
Depend on res_pool->res_cap->num_timing_generator to query timing
gernerator information, it would case underflow at the fused display
pipes case.
Due to the res_pool->res_cap->num_timing_generator records default
timing generator resource built in driver, not the current chip.

[How]
Some ASICs would be fused display pipes less than the default setting.
In dcnxx_resource_construct function, driver would obatin real timing
generator count and store it into res_pool->timing_generator_count.

Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Yi-Ling Chen <Yi-Ling.Chen2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index f19015413ce3..530a72e3eefe 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1365,7 +1365,12 @@ void dcn10_init_pipes(struct dc *dc, struct dc_state *context)
 		uint32_t opp_id_src1 = OPP_ID_INVALID;
 
 		// Step 1: To find out which OPTC is running & OPTC DSC is ON
-		for (i = 0; i < dc->res_pool->res_cap->num_timing_generator; i++) {
+		// We can't use res_pool->res_cap->num_timing_generator to check
+		// Because it records display pipes default setting built in driver,
+		// not display pipes of the current chip.
+		// Some ASICs would be fused display pipes less than the default setting.
+		// In dcnxx_resource_construct function, driver would obatin real information.
+		for (i = 0; i < dc->res_pool->timing_generator_count; i++) {
 			uint32_t optc_dsc_state = 0;
 			struct timing_generator *tg = dc->res_pool->timing_generators[i];
 
-- 
2.25.1

