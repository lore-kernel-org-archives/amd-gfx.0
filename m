Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 960C7ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 05:16:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98B6410E83B;
	Wed, 14 Sep 2022 05:16:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A500E10E83B
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 05:15:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=noS/4uLLU8OxR/PD6Q1JBCxwTK3Q5SMrVKtRJlcdIA4pc6wzmvoYq3CHhxEk/zMirnkqD+QzUOhwPFB7hNP9DrzKSKL0YcOaXqZ+UvBck5JpXf7a6EXnKw/v7bpA3V4qMXF0GhnCmMo+TmTsP5snZPwPhUNnzz1wi4oNuBeSnf8T6GPnY7uWYl6GFZwKUF8+Dw1jBMdP2jVYa+BUVAxl70hmy4xE4wRC5QkA/ZdGY+1q7rk514MGWW2zXUF1F443Z02aA//ygnGz2Tr82Fy77eIpTGzvRpJRBajcdcTBlDFjjCrF39Ncl4+Xo/VhLTnUAUIS+aBMoE92xN4Ar3vwhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=imNo3zM/gwrUIf9cLgfhPV2Dr1ioekFYOCt5TEUgt5c=;
 b=AbNr7aPSevksh4mKvnlvzfHspk5TX03k/+IvHYhbKZqKK9NsAvSA6DykHDJM2hDJA2jgqLccLk1EikB+zE3GMUDU/UcR7S7pxM3J3xA5bz0nk9yppqkInyeJO7312qVct3i/Cr0wQNA0pr0nPVX6CHodCp4YrdAm5F/PkRTO6/pQC14b8U9dS1BLXREgQ0yNyNGbbarS0RSL9UpLtEyMEdBtcNb3yLUFNICxBybjhWi129+pp83vXLfX6JczsnY86KJj363DfxrZ5N9+d1ImOLWIoJ3tpPq03aKWNvQJqQfhQCNEagsqAo1llYWJXKQ2oLqz5/67jz64AZ+XsS2XXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imNo3zM/gwrUIf9cLgfhPV2Dr1ioekFYOCt5TEUgt5c=;
 b=Reszwo+zY4qR20OsRLkwTqeFYcCqOvOMnBygHtMYceWbYe+Iau1wvu7yUqpqk2esl/E7BVc+ezP9fywBEh0eh9CvM/I3D5nAdHxXFls4o4XIzvk+bLknpODtBMZeRNWJD8dZUslU5gXtPVLLYU0A1zekc5W+D/hMITt0z5E5/PQ=
Received: from MW4PR04CA0186.namprd04.prod.outlook.com (2603:10b6:303:86::11)
 by DM4PR12MB5167.namprd12.prod.outlook.com (2603:10b6:5:396::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Wed, 14 Sep
 2022 05:15:51 +0000
Received: from CO1PEPF00001A5D.namprd05.prod.outlook.com
 (2603:10b6:303:86:cafe::38) by MW4PR04CA0186.outlook.office365.com
 (2603:10b6:303:86::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19 via Frontend
 Transport; Wed, 14 Sep 2022 05:15:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A5D.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.12 via Frontend Transport; Wed, 14 Sep 2022 05:15:50 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:15:48 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:15:31 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 14 Sep 2022 00:15:22 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 26/47] drm/amd/display: Removing 2 phys
Date: Wed, 14 Sep 2022 13:10:25 +0800
Message-ID: <20220914051046.1131186-27-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914051046.1131186-1-Wayne.Lin@amd.com>
References: <20220914051046.1131186-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A5D:EE_|DM4PR12MB5167:EE_
X-MS-Office365-Filtering-Correlation-Id: 12f7c042-4e41-43a2-de49-08da961030b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7LlfRBh3N+P2F4UggrwYI3l5d0QyiN/5dQ/MwPY2f4O7WiSP8k0qDC5KWWqD3256IzLLwIVUvA9Bre3D8w0CkH4OOfHCAb1UhKgiSANFubByohrDvgvdSyZ7SK/L1YCsydwaTq5nFtcKejsGl/PIbN7ij1u/bs1kio5zdiOOAZK00fNsrDMgXNJjXm2bXy0PsIR1CUvB+sFm9toVfJv7vmqmfCF4vXQJw9f9mFyUM0VclH7aqn0OSuTOYCjXZnS/uMFye84Ncm5UKihH3CFPNYQiXptQXSolXyp37wRSzoe1HAOCXmPM+8+7WQHi9XdgxjMLQnaSE+fmx0u5dRrL0W0FntZmOywoG5l0k+UmXDk3l3x4tCikeB/uGOxjxGtjC13s5Uk8q0nPR5aJ2MYRQWjN0ecmlJXsa3CYeUkWS5ACzq3ozLfHWg80LiqW0T+3ZBfZou3lyjBqhMHFZ4AVJ4qTP8Zo0/34Ud0+mvMCFmJhJDOfz4gMmm084YFpQKKJcjQjBTycSDYC+cJvnpS7TivfszOU+gerVFqNaJaH2BhiNj1jy++0RmQu1GDXro1PP5f53ZPalyqf2UoHGmCjgFIE0iDWtsgO9B2yaeD8NLeUFPnXcre0R5fOWR2eEFueeuumtiTCFZSd3bJCS3C3e0zraz1o4IOORPtmlLPLg3BhqPbLaOZ5ufJK3gFbnCPoj71a45YMG/EhwtkdHnIqQU/Rp7YC0NAXvNlX+SRkIJJ5ivx/iUIYT99Ce1U7QyjOHXceHzSo1UL7uSLgNIeUMlvFj7kFGVPKAHN8yLSC0Bo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(8676002)(2906002)(356005)(82310400005)(40480700001)(81166007)(86362001)(41300700001)(316002)(1076003)(186003)(47076005)(8936002)(2616005)(70586007)(26005)(336012)(426003)(5660300002)(82740400003)(54906003)(83380400001)(478600001)(36860700001)(36756003)(7696005)(4326008)(40460700003)(70206006)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:15:50.5602 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f7c042-4e41-43a2-de49-08da961030b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A5D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5167
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Pavle Kotarac <Pavle.Kotarac@amd.com>

[WHY]
New dcn301 has 2 less phys

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index db172677d613..0c2b15a0f3a7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -634,7 +634,7 @@ static const struct dcn20_vmid_mask vmid_masks = {
 		DCN20_VMID_MASK_SH_LIST(_MASK)
 };
 
-static const struct resource_caps res_cap_dcn301 = {
+static struct resource_caps res_cap_dcn301 = {
 	.num_timing_generator = 4,
 	.num_opp = 4,
 	.num_video_plane = 4,
@@ -1429,6 +1429,8 @@ static bool dcn301_resource_construct(
 
 	ctx->dc_bios->regs = &bios_regs;
 
+	if (dc->ctx->asic_id.chip_id == DEVICE_ID_VGH_1435)
+		res_cap_dcn301.num_pll = 2;
 	pool->base.res_cap = &res_cap_dcn301;
 
 	pool->base.funcs = &dcn301_res_pool_funcs;
-- 
2.37.3

