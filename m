Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C30C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 16:20:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 881D410E7E0;
	Wed, 25 May 2022 16:20:30 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E867310E7E0
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 16:20:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bdc/7WI8acq4cT/9aZG1dZw7mmCj7k4XuUvsaOs6H790Nd9TYjjhyQNjfV1up2RsGbcdfdCNlrfJ6DyqHRlBMg4i7UBCovH3TwbEeuFuX/dM++OrjbQg0K4GLNAa/5jp8R0V6ynxaFv1Pg/6BnNvTKgcbZ7V5Ra+x7jj/llrF+XNYGmTYzpj2Bwx8mZ1kEXpBSFBcQITa/NYx5tPuMEFzph/we1AeKlUN4AITEjYT2ev+kj0e4SYKi0Rd0slblMQyS5yt+EFPwrwFBUNQeT1Eg0hk7o9R+wQxfz9+oKklY/EIjBfZ5/WqE4DsSF0M7/QyjWkycvMnmh0R4hfkFSkxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OcISoZH1xvdGKAkQ1Cv5yuQi6Kj1tsnNJ7M/qdEjmdk=;
 b=kRc2DL+2m+b3Kf9lU5FgglDqCZESOMaXuLJfqJXhStYgxxjSK210hoXRwEvDAMhayIWmNJV1jHIVxwppZhAby1SA9pMNbAj4dH/4gI1SvCAXUyEREdX86vQvzUYEvCP5WTQHIX9f2XZiYLJUlDlAZ5IJLcwQUbzXa8jJQIrGBDYOb8jzTHWeVGYg+A6sBOWpEDYI3/hZnkgCGj0nAmabtgCdwMAXCIpErFJ9eexXJ1PRfZrjDjKeE2nG45WZCX0NhzZ9OaqAq4BsfAs6blPDsrF7cl6XS8SM5/mzKeaTEEjheepVT6/j4pFUpTsImVrrg9X2Rxmgd7BnIDUh5N5tZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OcISoZH1xvdGKAkQ1Cv5yuQi6Kj1tsnNJ7M/qdEjmdk=;
 b=lMM6WZE+bEy8BJoMoB2V9ySVo0wPS0JpZNAx8Rk/mYD2BbJvyAXgvkdn7QfUIWc+BjW/0RhIGfiKhHnk34i3o8tQm72cdaJ4pfPLhaJOysZdM0289o8d5uA65kWsIe18wa2aOr2UXcqaoBY7JRSWBl0cx9DS8yn3Tz8Kt88yfCo=
Received: from DM5PR05CA0022.namprd05.prod.outlook.com (2603:10b6:3:d4::32) by
 DM4PR12MB5723.namprd12.prod.outlook.com (2603:10b6:8:5e::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.19; Wed, 25 May 2022 16:20:19 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:d4:cafe::31) by DM5PR05CA0022.outlook.office365.com
 (2603:10b6:3:d4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.5 via Frontend
 Transport; Wed, 25 May 2022 16:20:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 16:20:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 11:20:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 32/43] drm/amd/display: Remove W/A for ODM memory pins
Date: Wed, 25 May 2022 12:19:30 -0400
Message-ID: <20220525161941.2544055-32-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220525161941.2544055-1-alexander.deucher@amd.com>
References: <20220525161941.2544055-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd73e75f-7725-4426-cf65-08da3e6a7609
X-MS-TrafficTypeDiagnostic: DM4PR12MB5723:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5723B6C12E5402D369B892A3F7D69@DM4PR12MB5723.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kjzx+4V2zmWxCpFr8EXNkKxEx03nPfFg5e7/VJZ5E55/O1/qWWMV/0X9uZirt93bHhH5KEszdMP5Fbtl58mULJc2NbEmNeoujxyteqEHqD6xGw0l4dm6L7YLiHHmrsD0MzDUfmD5Y9TKrRpCCpNlIgTXolHRSZyxfP7HZ5nuExHUhHZjg+8AnWlchDHp7rCiT2NgkEDHJGCmIWfkD7OTktmdf6iUgHO3XHPRziKETAIEpYfb52fVUs00Ro3jcP2OqaCtqFcsT5prtjkupCh63xw90ZxPZ8WoJY+f9oH5H82mw0JZAfzyJSAO/XkItmnAzYLRhm5zMSAhTDDUMMfHbtN3zy2j0K851MaruM4ILv1DKhyPSschEUAH+jW0KrSd3e4VZk36guAfTQNGeZv3VlFXgbQx+H3dSKDBoMg2xIsTifcEnWDl91JDTXFst4Fysh3y1vBeY+9+wnfY6ekfNn2rlf7Kh6AuSgdN4ghT5GL7egKcDpMBM9QF0eaNNGMLolNMi4zB++8iTub0LV+JpVeRvxzmjL125ZGyfi2pB05+kChzpZVmet28rCbMJWTn7KBr1xKReUaw5bMmT7dDtZ4GHTU811x2mpNmlyFCo7sCrQx6VZRlNK2PoSiCgAC6wq6Z2HfR3j4hTH5Gf5Y6VrKdOK+ksfPjiMrqcvAnNIPiM38hyt3M/R7Q4lxcYz3BC6b7lnBvqmB4CvSOw1GoiA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(16526019)(356005)(1076003)(26005)(7696005)(6666004)(8936002)(54906003)(40460700003)(316002)(2906002)(36860700001)(5660300002)(82310400005)(6916009)(186003)(81166007)(36756003)(4326008)(508600001)(426003)(47076005)(86362001)(336012)(2616005)(70206006)(70586007)(8676002)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 16:20:19.3063 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd73e75f-7725-4426-cf65-08da3e6a7609
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5723
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
By default we can now set
ODM_MEM_VBLANK_PWR_MODE=1

Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index f2850071478c..b492eb424d19 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -997,7 +997,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 			.dscl = false,
 			.cm = false,
 			.mpc = false,
-			.optc = false,
+			.optc = true,
 		}
 	},
 	.use_max_lb = true,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index 376dd586b643..780409eb0e98 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -994,7 +994,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 			.dscl = false,
 			.cm = false,
 			.mpc = false,
-			.optc = false,
+			.optc = true,
 		}
 	},
 	.use_max_lb = true,
-- 
2.35.3

