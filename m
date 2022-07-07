Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B3E3C43334
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jul 2022 18:43:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DB7412A8CB;
	Thu,  7 Jul 2022 18:43:05 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2417712A8E7
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jul 2022 18:43:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dWN1ZYdxmqxfuNFJzusSOJ8RSDYJBGEOpmancn+hcSEZtqBpqFkoW0iJ9d+qJbAvybb32bysNK3a5Ax8AnR58i8HP8474j4dPrOfBEsBpnXTRN6zhqnn8qPYMlpHk8XwW52ASObzuuuKC5RWQfTxLz1rnnSgJqrimBJ7S2EJKaw5YZd+uuVseDppcp/9Qi7g/uQ35zuhV6PG5J2vq8xIk6/8+OrYbuPOzN/RiI7IAgIIb1FcBSwQc4V1l3m16GejM1PJ4Mb8NfyC6QH1LZh/zz/uvZhC5C+/GyG/9uYTBFgwDKkEDfXiTgixlKAMN5IhuhPv/cYwdhUcBDyvO1tEbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkrDEez6bNpFv8a3Ag1JA4nEXCX9WG12ZlBe0FCzGV4=;
 b=YROE+NOoIlMW5AY3Byh6gIaEx3X+CC5wm9N3x5NBeIVN1g0/fLANE4rlKEy8cLNo4Q4Z2Urd41mR37egGTNIoqe/uzJf5Pku+29c7P32PUexKk+B4Hv7aOyZzfGGa/TvqtvkTx0e6hjThp2vusvZKvWGQ8KhBWQ6fjAmfR/+gabAra8WeByLkn5ndP8NZdCtryz9jUN2fVwiZ9bHq3fGSSD+YiX0TMvpKb2HEaiVfWaRUqsTZk9lHgzW+8deRtdDdyGE3F+yghoeXmLQfq7UnVVcX9shDyNmy4NjSdprxc5BFCvgW37VCeY8yK6Aqrd2/fvJxBRSausFeeTsjHur5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkrDEez6bNpFv8a3Ag1JA4nEXCX9WG12ZlBe0FCzGV4=;
 b=t0P00Or54Z/QJct1RlDr9fs4IkyK0ujJcWCnv3RhD/y5pIGIlqJVg7gzxK/SG1EGwLMyQR4/nf+1go4hBvmSaaEduEcQrvlHFkHtSQq6twQxtviitFE7zcZDmGI2kKk94EajfPa9VymQuPBmrnlQNIGwHXFizFLWjWGYtAsea4k=
Received: from BN9PR03CA0961.namprd03.prod.outlook.com (2603:10b6:408:109::6)
 by MW3PR12MB4492.namprd12.prod.outlook.com (2603:10b6:303:57::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 7 Jul
 2022 18:43:02 +0000
Received: from BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::b9) by BN9PR03CA0961.outlook.office365.com
 (2603:10b6:408:109::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15 via Frontend
 Transport; Thu, 7 Jul 2022 18:43:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT042.mail.protection.outlook.com (10.13.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Thu, 7 Jul 2022 18:43:01 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 7 Jul
 2022 13:43:01 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 7 Jul
 2022 11:43:01 -0700
Received: from aaurabin-elitedesk-arch.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Thu, 7 Jul 2022 13:43:00 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Enable ODM combine default policy
Date: Thu, 7 Jul 2022 14:42:59 -0400
Message-ID: <20220707184259.1610514-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 637b2f39-9aad-453e-06a4-08da6048856e
X-MS-TrafficTypeDiagnostic: MW3PR12MB4492:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xJYSTTjg5JWdIt7CSq/7at9CKu4HiU0bpp4Xp4O9IyigeLItHnuNGyXehsWIVVoZtqUnvTYi3VHJKOJ4cP/Bff7duOA0feBZz1uPV4AarfHeWfH4zjEjxN/RIJE1fhHTDRAhXD+YDM6WLzTS3CIovixDNHf4CzJ+0t84noIeosRe7oou4ImwmaJhRatsmTwzIgyq0XPYtPmD0AIXUmRhYcL9cLlfDjEjRbnnJBrV7WcC5OKhrDLQ1bIrGj88mnnI0G1kxzzBIjKfIIhoCWpThcLGjpc4GLxOr+BN8h/Rw4hO2SC+ltBvd6W9+919GRjKK5JjaXHbJ+Z9AkKSaAI2KZqSfyYg37fZlolCuxZxsMxr9wI9dZbzOCaO2ViQIp2H2p1YqRdyXAoBSnA/TXw+FBnOO/Z58C/V5EOHsnl0Qvhigzz2VTp630rPc6Qf4yFzwe5Mu4PIi3swrekuwDCmvWTtsijIlw81i1sUyUPKwcwL6OruIgYHVNCP5VPewFPFNGfimxMwiNeYuj5nop40n/6Z/x1x/Kco31BDXk1BaZWe4YupNuVHwC3lviISH1tynpc+hh8Ed2NjBn4bKTC2IB4zvZaGxfGD9i0HeB0s5BXasTt141ze4tAzHRpV1C61Om+aXolUr/K233HA8wt9xYtjTq7Mi0E6gdzRdRjCF0yJdfisw/cMQRngj6rTByOAUTvbO+KUJV+23f9sbFS9ZTIDJnbpZ8OKh/F/rb0stEpCGj73l9Pjvk2iq9BklrIpIBu3EnxZ7DqxqQZI3zO7OJUFU9bt5U3jjfqhqKCdZYg1Z/jlWpA3F+5FK+yKS7StdK09fFMrQ4ejHS11BLwsRORuL98uGvMoyJFVTox37WDlv0uennKj40Hx6VuiRl7G
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(136003)(396003)(376002)(46966006)(40470700004)(36840700001)(26005)(1076003)(2616005)(41300700001)(83380400001)(34020700004)(5660300002)(8936002)(54906003)(36756003)(6916009)(426003)(336012)(186003)(7696005)(47076005)(81166007)(82310400005)(478600001)(86362001)(2906002)(356005)(40460700003)(36860700001)(82740400003)(40480700001)(44832011)(70206006)(70586007)(4326008)(8676002)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 18:43:01.8057 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 637b2f39-9aad-453e-06a4-08da6048856e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4492
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
Cc: alexander.deucher@amd.com, Rodrigo.Siqueira@amd.com,
 aurabindo.pillai@amd.com, Harry.Wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why&How]
Output Data Mapping is a power saving feature that allows us to run at
reduced DPP and DISP clocks compared to what could be achieved with a
single pipe.

Set the default policy for single display use case to use 2 to 1 ODM combine.
The options are queried by DC and appropriate register programming sequence
is initiated to enable this feature.

Fixes: e40fcd4afb3fc ("drm/amd/display: add DCN32/321 specific files for Display Core")
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c   | 4 +++-
 drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 86d1a0785a31..b166ab187264 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -997,7 +997,9 @@ static const struct dc_debug_options debug_defaults_drv = {
 		}
 	},
 	.use_max_lb = true,
-	.force_disable_subvp = true
+	.force_disable_subvp = true,
+	.enable_single_display_2to1_odm_policy = true,
+	.enable_dp_dig_pixel_rate_div_policy = 1,
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index f8c9aceb2e85..f0eff4c94616 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -994,7 +994,9 @@ static const struct dc_debug_options debug_defaults_drv = {
 		}
 	},
 	.use_max_lb = true,
-	.force_disable_subvp = true
+	.force_disable_subvp = true,
+	.enable_single_display_2to1_odm_policy = true,
+	.enable_dp_dig_pixel_rate_div_policy = 1,
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
-- 
2.37.0

