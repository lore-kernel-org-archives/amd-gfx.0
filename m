Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BBE5EB64DB
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jun 2023 17:58:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61EEC10E14A;
	Wed, 14 Jun 2023 17:58:29 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2050.outbound.protection.outlook.com [40.107.102.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3A1C10E14A
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jun 2023 17:58:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IcJelUYMPPvqNouWYs//LN73Clhnby/b1rFOA7Jc1zPyiXRLdq9gkiJ+7USZIMid68H4Ni8q8gnmorJa3iwRDGNF5EaOKxN9LX6hTJOpadT26OqyI7YU0oMFK9d6EncJR3g0LYDFJ0Ygy6vYzgp70VwR3o3N51g0/8EPkartz0etsyLzSTaOyW9o3ssZNrmx7J087n0Or/uPoFU/1hlmVQ7czxIyiYeQK3SnT3K7gwd/1I7EP3OCv3JbbKIRZP/yCz7DG0Gc3dc8kPmpRZkOT42rFh92L/9vNqmvDzIpw6SDP4hNHCmZxVijDhARkXtndtwGzD9fvl29iJDkVdZTvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pabIbx5WrTtbzgo8Wlh104zljzk1OjKUbEHoJ99wyZY=;
 b=IdstCPx2BkHEkQpgS/5cr7F17TgoUJIE/wgdmvnf98G7XqLCJRMNXrRyakJqCE8rJqZdVIZOVyGAChsX2GRSdQWEBMOPpCYIwV4Opf0SXGy4y53wtLSnEpoyEbT7DRZnr36LQEOB4S0hNMlD6adznmvtC6riLBPaDCqyek4pUr3sMdwPG0KE8L5Wn2c+5Q02gPQYL4GVd8MsVzDWCOIxV3NBs1HatxlmOOT79A5pKP/dO7uOkCi86tM+/5yuPSGGBjIpFQ0eEu3N5s+0WgBosGirdwcF6mCLN9C1OYP9SRj02mQX5mWQ9h8nB04X4ZS8wIXyQam0IbIEtiH3k1pADQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pabIbx5WrTtbzgo8Wlh104zljzk1OjKUbEHoJ99wyZY=;
 b=DTXF8ln++YAoSnDURin4ycdU4CWtyKc1uoM4uUozTHoMFXUzB75eDlOzm/pmTyy0uGuZhWrDiIji625InuGRcqMIqqpvP7FzetsSz6kkcsdYtu+jLyjE4S1MsLHvQcVJrHf8NWJoSoHXfctd0dQt/EoDTAAwsYpZB6QhKjE4tpA=
Received: from MW4PR04CA0223.namprd04.prod.outlook.com (2603:10b6:303:87::18)
 by SJ0PR12MB8089.namprd12.prod.outlook.com (2603:10b6:a03:4eb::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Wed, 14 Jun
 2023 17:58:21 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::7) by MW4PR04CA0223.outlook.office365.com
 (2603:10b6:303:87::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.36 via Frontend
 Transport; Wed, 14 Jun 2023 17:58:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.25 via Frontend Transport; Wed, 14 Jun 2023 17:58:21 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 14 Jun
 2023 12:58:19 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/17] drm/amd/display: Prevent dcn314 RCO from enabling on
 unsupported chips
Date: Wed, 14 Jun 2023 13:57:40 -0400
Message-ID: <20230614175750.43359-8-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614175750.43359-1-hamza.mahfooz@amd.com>
References: <20230614175750.43359-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT006:EE_|SJ0PR12MB8089:EE_
X-MS-Office365-Filtering-Correlation-Id: 08d073fa-9f79-4932-b378-08db6d00f10f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TjDty6ZpPynQfmje5IW/8kFlebP0lV72dyB31aEONcTFIK/7gmxaqrNvO5XGzhjdj0Bf5XB0nIJrtCfNr82KvKro1m1Gjn+4Ssb+7oihKfpcKKCDVMnzwdzvjIajPcKW9VtjXtRM2dUb/QcZ6KKrla2YD2sc9BaFpx6teLORol67sckrmCr1nmB38ho5fQt0hxzJxepCuolXaWV0AIM9TDL2qCtHPcjxV5/lkqwImGm8Xed+rzvVWY6QZYhhRkua5K60mAwsOytYHucwTNGV4asIjlhj/wPA72vPub8YCoMD+ISD7TbGZWRBDq1PpXStA3N6HdufrraJmbiHJM4fomboaKPuE76DeJbP5YPA0OpVNhybw2PG3LPlP6l+qGGGoZfnKOszFi1BR/CcS52/b3xZW5uTx6GbDiW+v8YfMgI5Lol1sVuJEUM1F2Bw+ugL6UEgUNOQOEsW6TM2EZXOVE/MJG8NGYsI3XV+X2DMFPqaRtYU8pyIRgov7DoXWjZBHPhHlVVrq2mPF5K2+qEvarNZv+nUoOy1E1dnmlILc6POFtf9heNjGn7pp55/+a7hbaa2okbsX/D6KKIzNYOwKhi6VEDq/0K+nQ0J9c7hH4dJdLntVTHxqPu6TmdxjUL1c+vjp8AgkiM+0yCaijxouR6udXYWv/Ds8n6NzQH4wJ0eMx1Jzv7gw0qZ5/hZJFFwQe9RqA1Rwc2aaEfU581HwpGaHBF2DF+ObI2mkPIjOP/w6wYEnILZPm3gqNJddRm5MkukvnFgLYVHEVl5vSrlojlnu8rUW+Uev3oRKqE711XUsAyVDdYGa6RhEzwc50xL
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199021)(40470700004)(36840700001)(46966006)(2616005)(316002)(40460700003)(336012)(41300700001)(16526019)(82310400005)(36860700001)(47076005)(86362001)(26005)(1076003)(186003)(83380400001)(2906002)(356005)(82740400003)(81166007)(40480700001)(44832011)(4326008)(426003)(5660300002)(8936002)(8676002)(70206006)(70586007)(6916009)(54906003)(36756003)(6666004)(478600001)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 17:58:21.3416 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d073fa-9f79-4932-b378-08db6d00f10f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8089
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
Cc: stylon.wang@amd.com, Daniel Miess <daniel.miess@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Hamza Mahfooz <hamza.mahfooz@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Daniel Miess <daniel.miess@amd.com>

[Why]
In some cases enabling RCO on older dcn314 chips leads to underflow

[How]
Explicitly disable RCO on unsupported dcn314 chips

Fixes: 0e1961c93839 ("drm/amd/display: Enable dcn314 DPP RCO")
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Daniel Miess <daniel.miess@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c     | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
index cf23d7bc560a..0746ed31d1d1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
@@ -332,7 +332,7 @@ static void dccg314_dpp_root_clock_control(
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
-	if (dccg->dpp_clock_gated[dpp_inst] == clock_on)
+	if (dccg->dpp_clock_gated[dpp_inst] != clock_on)
 		return;
 
 	if (clock_on) {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index 03c5690ff54b..1290c294d47e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -1904,11 +1904,15 @@ static bool dcn314_resource_construct(
 	else
 		dc->debug = debug_defaults_diags;
 
-	/* Disable pipe power gating when unsupported */
+
 	if (ctx->asic_id.hw_internal_rev == 0x01 ||
 			ctx->asic_id.hw_internal_rev == 0x80) {
+		/* Disable pipe power gating when unsupported */
 		dc->debug.disable_dpp_power_gate = true;
 		dc->debug.disable_hubp_power_gate = true;
+
+		/* Disable root clock optimization when unsupported*/
+		dc->debug.root_clock_optimization.u32All = 0;
 	}
 
 	// Init the vm_helper
-- 
2.40.1

