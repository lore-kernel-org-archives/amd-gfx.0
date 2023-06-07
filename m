Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB2F8C7EE25
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 12:16:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 260E710E4D4;
	Wed,  7 Jun 2023 12:16:59 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B07D210E4D5
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 12:16:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NomTiwIInLEHVpM+u9I+KEUZDqSTvqCcVggSNIlC8wCIu1GwxROGzzSkhouL4WMyOBeAvqxZda+K0hvgwlagTIA6iNaUgMOfV9xlChZ2wx1A4EJpHQ9gZ/OG/m5N+/3QxDUzXDecUw8Bdbhe5BcNySli7ZC4B5oyKCiH9aS3O/nJlSOiQLpnooVwKxqm8ECeq2J6a8+7U1/z7cjPdoQ8Nkz6epvhWk8pWCuljwktYnSo7gW86QGCymUOspmxs7oEB+hE/8eO/tY1594hv6oyRZMdawOrUekJlBMvSc2CkZ+h7QrFEam2aO99JyY3t6XpBGy2geypBItbWoD+PoYtgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=apcYwbIZ8YIit5HKCYh0dRzRK1nGRVoeNSibDBM6F0I=;
 b=ifPfiMDz+EtW0g1x1m4D8dKQvYOzlFRTrZc1MZ28dK2bIGZ49LrEaQ5B1lNplXUBb4iMCV26ZN442Dzfux9zGcfNJXPsg0DttP77xwPxkQJ8f8KsVLUMLmww+T5OPFlJfTQqQ0ZKPHN3Ym/8oMS61vQpFwaC3K0rvMDVgog55IU6BktUlivFjfero/hFQr7tYS+4koCGDZ1wxS73P0lzLy9hS/h5KcluzZS10xrHDOqaxzGKcW1GfU5ZFJaGdRoQYCherGXXBPtmQQz/sfjOkB0E8TQlJtUgjQ3urCoEdiZEHlBD34txdEcjzJkubAf8nL8Hpscegf3K7cyPMCsqrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apcYwbIZ8YIit5HKCYh0dRzRK1nGRVoeNSibDBM6F0I=;
 b=2XZDlaLYE9p02E8o6h3vvqRdBzbEDZNOybjvRdWT9NlLJi9HCUw27byWTU1Slp6hW2GTjbumgfp4inUwjoZ5TN4sYiOGkDSQ/tFJqSDFOyDP+fNBnDW4zzFnsGSNaPIBsKqYHKSKT3rsyNYoz/p0VvsmEWHZjkuhVa81PgO/z08=
Received: from DM6PR02CA0117.namprd02.prod.outlook.com (2603:10b6:5:1b4::19)
 by BY5PR12MB4100.namprd12.prod.outlook.com (2603:10b6:a03:200::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 12:16:52 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:5:1b4:cafe::30) by DM6PR02CA0117.outlook.office365.com
 (2603:10b6:5:1b4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 12:16:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 12:16:51 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 07:16:47 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/20] drm/amd/display: Re-enable SubVP high refresh
Date: Wed, 7 Jun 2023 20:15:38 +0800
Message-ID: <20230607121548.1479290-11-stylon.wang@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230607121548.1479290-1-stylon.wang@amd.com>
References: <20230607121548.1479290-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|BY5PR12MB4100:EE_
X-MS-Office365-Filtering-Correlation-Id: 68c8d60f-284c-485a-a4ab-08db67511350
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kFFvrjwcKqIUFBLsYjLwbG4i8N0ZuDANIcM0v2WaKbFGyYJmmNoitP23+kfBlJeOxZrgRjpmcit19fRbLB0ACFLnyhXAxRb2x2iV/NsyNKECaSKLQAPGGqXGPIq0oXXhIXLpoNIMAEjhWI/zLtpMF+xHiN270zvt961JZCZtSoKHFrvC1WG34+2wFvGDtduf4kria8IHkMhzH6kMz1cTkm63KuIM/XbS5CcjGLxjhj86y+ODOJW1WRL2SYXLeQ3A5m8sYrGFYKMsPLKAM7efeugczvJPN7pjM4TkGGt6wl019p4Qr883ljLrCs58U63+WFBK3ue7UdRIhRN3ROnndkR7LvUdll1JYJvqOrymQBH1eQ7Wz48xUYCJXHlAvE3xlprVxstNwiqxktTeLdv/Ph25X7NxO9xdHZsZgGS+17slyZqiDtzVgN5iZwuRSVjPxVgvsuvKbxxQzt0vR7zSE/+FBTDJA8EU1oBEJI+5/pQVvTi6uVwolP8ADpyEGxNB7nO4eEI3yNAGenIzWu5X14inDtwrE2gzoOmpgeVCR7niBeEVNsGlhkhHbpU1HKEzwHONbj3baMkwVg4T5lQbPWfelGSsZTkqbO3RMPECaYT7j+N9QdDTkhoDupm+ZxfFnNQ/nGhBuE4zuncC5PrQXbke+w3yBylMXzSS0wohxUFDASI5vNKfuAgOgLaxDkBr/VPoIi93f3uRRFpSfBywUriDyXgfUkSmBV9OzAhiKBY4Mo66jCFQgpg47PO4JKP+2B9LDk05KkrHOZrNadHfIw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199021)(46966006)(40470700004)(36840700001)(26005)(70206006)(82740400003)(70586007)(6916009)(356005)(4326008)(7696005)(2616005)(6666004)(82310400005)(36860700001)(47076005)(336012)(83380400001)(81166007)(426003)(478600001)(2906002)(36756003)(40460700003)(1076003)(41300700001)(40480700001)(44832011)(54906003)(316002)(8676002)(16526019)(8936002)(5660300002)(86362001)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 12:16:51.6027 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c8d60f-284c-485a-a4ab-08db67511350
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4100
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <alvin.lee2@amd.com>,
 wayne.lin@amd.com, Saaem Rizvi <SyedSaaem.Rizvi@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

Re-enable SubVP high refresh now that it is fixed
for displays with high refresh rates.

Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Reviewed-by: Saaem Rizvi <SyedSaaem.Rizvi@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 2e6b39fe2613..8c9e15952a49 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -728,7 +728,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.fpo_vactive_margin_us = 2000, // 2000us
 	.disable_fpo_vactive = false,
 	.disable_boot_optimizations = false,
-	.disable_subvp_high_refresh = true,
+	.disable_subvp_high_refresh = false,
 	.disable_dp_plus_plus_wa = true,
 	.fpo_vactive_min_active_margin_us = 200,
 	.fpo_vactive_max_blank_us = 1000,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index bbcd3579fea6..ee07ee340171 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -727,7 +727,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.fpo_vactive_margin_us = 2000, // 2000us
 	.disable_fpo_vactive = false,
 	.disable_boot_optimizations = false,
-	.disable_subvp_high_refresh = true,
+	.disable_subvp_high_refresh = false,
 	.fpo_vactive_min_active_margin_us = 200,
 	.fpo_vactive_max_blank_us = 1000,
 };
-- 
2.40.1

