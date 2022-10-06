Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E28C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Oct 2022 21:28:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69EC510E8BD;
	Thu,  6 Oct 2022 21:28:01 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A65310E8B1
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Oct 2022 21:27:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCE+M1TdQVOgp+PgvQQsMJrpS8UPp4ekJsSfvVJr29i+gxTwVZ+7sDJiqybAhfON7IksUlxfOURWVrVWWOiUzPIWlOBgD555iQ67KEs7ubBhkSo/Hq+K6j6m0iABqUR9GLqRU3jFEqXB8Upa9Uq8mbwa5y79c/mpRgdo2mJscfuwIG55TL+OgtKtu12KZpINn1PHqbb15D6t/EWOyFVsOjfEttgLMt15cjMzSCLzdhIiUdpusXGdttHlhU16lj8KWZpIuJm3z5rd37uZ26kT25s8jwJ9kAWlL7XSuD+8/HExJE9zd0OVVKM5RbMQ2RtyiIo8/1Zxty8G+PIY+8y2Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oyINGrOLgV5aYXoEVfajfNchRSZnlZmnPgPc7RhRp64=;
 b=GGlCvNHqwFR1kcvgphHvNO7FLlL9u0rkpz6SIwjT3pWiPKYnykgINHUg2HWTa1xNFVj7tbkRceFibFUwpPBvBIoQyuMxkpJioPARFB5YH917BPotB3oc73kc6fJXajC4DOxC5nJkhR1AGPjytPTvKx2y1KYJh2Jub4PhhtuLy9LTTpPiQavLXxTnRsoaAeD9eoGIEj1aX8b74/bdoeA2EjIcDhfXnFoIDxzgOkHzVf09w5/r7wkuV9Htuhs6NikDuoZOTmOKMM4zKFEzIFiRLeiwksVXqyzGs5144d13eD0174zNDiWPa6Ga0V42YHrKabQaGTpgAuJFK7QiNhi72Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyINGrOLgV5aYXoEVfajfNchRSZnlZmnPgPc7RhRp64=;
 b=am+0Moka2UkUbaxIbcxLhsy08vz8bnoATkc+VeadmqOr3+swRHHvsRwieMKrp77PruA4e8ntQuQJS+SAB1TdTxywKhUBTTWbpFx55SwcaYW6CKI6QZQ9pyMW9B5YTHfLNu1k9zjFdRc/vR1HW1/xKTZWWwR9ePWBH5Olf6/6MxU=
Received: from BN9PR03CA0276.namprd03.prod.outlook.com (2603:10b6:408:f5::11)
 by PH7PR12MB7235.namprd12.prod.outlook.com (2603:10b6:510:206::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Thu, 6 Oct
 2022 21:27:49 +0000
Received: from BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::23) by BN9PR03CA0276.outlook.office365.com
 (2603:10b6:408:f5::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24 via Frontend
 Transport; Thu, 6 Oct 2022 21:27:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT078.mail.protection.outlook.com (10.13.176.251) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 21:27:49 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 6 Oct
 2022 16:27:48 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/23] drm/amd/display: Add a missing hook to DCN20
Date: Thu, 6 Oct 2022 17:26:43 -0400
Message-ID: <20221006212650.561923-17-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221006212650.561923-1-qingqing.zhuo@amd.com>
References: <20221006212650.561923-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT078:EE_|PH7PR12MB7235:EE_
X-MS-Office365-Filtering-Correlation-Id: 18a9eb4d-5936-4448-465d-08daa7e19e4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: stxYuo8Ci2/F0DPO8TwZFeKrD+v5CO4zJfwy0FjsLpyFaiC8jx6gbrVmhgUXHJpwao0QYQqSLnl4iLVYgq2wu2Nq0gVsdz2AYP9vHgoDIXNJLF2l6onk3K+BFJ8Uav+XKdqe+L/ZDLArU/DO2G97RgCdueFN/x+l+EJ3Om96tVX16kf2G/X9fYAJSMVnzWfVcnoZkPSEybdmD/uAunygTu9lJhehez3vGQeFXVLYThRW5g1sTO779Ftgit6Xju0AMIyWXHwoZwnJ3OW3LA5zeRg/EJytroRELYeUlKaVUbBiIO1TfWC1jDQdRzQLEIZitcO2R74Lxc4lRcSNtPwacKIvz7/e+/IWS9DVZJSbO4cFsH91IU0/TSSc6Sg7MHoCEC8F+Sd8NCB+mbVV0Vk9eXJB1pljw2GqxxIr+aiI1EXSDNZZHxa65EKmy+5qZOkb3svkLnW9ZKjJbEgr3hc+kKDCm84vJ0Hl5IAw+yuUl2zTINaPlM58gV38pDSwJtORW3HK5R/UGxbmN5BSTuoRO1IqkqV913MiiRtFErZj8uuOw9rh2i3NWb6NCCI3DyLiVKwjIT9X6rDOVNvQ6+95YptfLN08ZMz5xVtYf0PpcbOSOlWcNTp9WkJT20ef6qPg0FhbTDxnv9n57Glaxm1+XZmg9BLvoxbHNMtyjGDCLtwCp98JOm2676eueMVykHNRkZxLyXTh6gaZAQFdlghs5zQw0SH5KbnmEDSKch165XH6RZnzyVOqzXJsEENoDsMqIUkIoXhmO2oxOuYyg/1A42plhM1IkhwBsn0o8k2Y+9OeOSGo1qE3OziT9s8NrDxo
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199015)(40470700004)(36840700001)(46966006)(16526019)(336012)(426003)(83380400001)(186003)(47076005)(1076003)(2616005)(5660300002)(26005)(2906002)(44832011)(356005)(82310400005)(82740400003)(40460700003)(81166007)(8936002)(40480700001)(36860700001)(86362001)(36756003)(6916009)(316002)(54906003)(478600001)(70206006)(41300700001)(4326008)(6666004)(70586007)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 21:27:49.0975 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a9eb4d-5936-4448-465d-08daa7e19e4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7235
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

The struct timing_generator_funcs provides a hook
for setting up the maximum possible vertical
dimension of display for OTG, as the panel
supports. DCN10 has a standard function named
optc1_set_vtotal_min_max which all ASICs can use
to set the aforementioned hook. Since we did not
set it for DCN20, this commit initializes the
set_vtotal_min_max with the DCN10 function.

Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
index 0340fdd3f5fb..a08c335b7383 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
@@ -529,6 +529,7 @@ static struct timing_generator_funcs dcn20_tg_funcs = {
 		.enable_optc_clock = optc1_enable_optc_clock,
 		.set_drr = optc1_set_drr,
 		.get_last_used_drr_vtotal = optc2_get_last_used_drr_vtotal,
+		.set_vtotal_min_max = optc1_set_vtotal_min_max,
 		.set_static_screen_control = optc1_set_static_screen_control,
 		.program_stereo = optc1_program_stereo,
 		.is_stereo_left_eye = optc1_is_stereo_left_eye,
-- 
2.25.1

