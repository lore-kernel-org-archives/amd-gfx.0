Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7799BC07E97
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 13:28:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80F4D10E870;
	Fri,  1 Dec 2023 13:28:32 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E4A810E88B
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 13:28:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kz+doMiqIqKjzwYT5RHba/TDKMcffTkq3STSv2wOuo3r4vZNWsXpYYEnwfv8bT0PLC8sBA3Z5R3p6+vn1nlQzfLChddE1bxDcnNlHddVvJ9kVmbgWQwdPZzAfHprCX29hwbJy0NlTqKvVIgAkmXXyFibhq8lDljZV05MXQhlZMbJXK7jXXHkS9VG6tgWpBFud+naC5VykeGiQgCjFZLEc5DipuDrI7wTEiF2YijRcHGTErMmUsjLbSj+Eua0lDHZUGVJ/tvTGdsEK9Sdhk3H/6K66im5H5qnbrJ5mNJLtURWIjD4NG1bGPeI4zzhqqJIEiqu2Pgm5YQFWy5/2qpD9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLEKZAGTyHCkcP9zZi3gLlLFYNIohzUkYc4QFAO+16s=;
 b=JATBiaInpF1MtrqX4cLLiGCHJnkzTrA5il0JeRzCmqsPgGCvh3R/b5HcbAOyiarI+WoXaTsXKM5Rioqdxk26kOdtLNiRmt9os88EJnBoh9TxPYnZ8fu/h09OluLFPih9cdB8dW1JzHJW1Tb0J87RYEsHb+KjSx/fkjpw4umBi1Wg6BqITN24KQsDJraxcVPbbHc1ct9+97Hncg8/HP/KOYMIsySG4wCPmIalVidnzSFfPZl2H7SAvbmZ+mxbLSLOJpqnNLIJra0rmZnGhRaVCDFKCyiHsFYW2F7QbCvj6uk2VY5C5NePd51sYTweZlfr1+I9nMSzHyGg03/VBjThpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLEKZAGTyHCkcP9zZi3gLlLFYNIohzUkYc4QFAO+16s=;
 b=e12gmTNBOnx9htgCsMAI3gd4uoYVGyu8rG4fgZybfNxPo79ioUjizbeDN8ifvSXafi5Qta4uiVavwLmH/dVojZ386MTFdnqwfvDgzyU4SPw3rBuBBpMHYnesPZEoVA9YYj6hNQKnzrDReK9wrZ2Kpp08AK5REkthrZEQxUhINcs=
Received: from CH2PR08CA0027.namprd08.prod.outlook.com (2603:10b6:610:5a::37)
 by IA0PR12MB9045.namprd12.prod.outlook.com (2603:10b6:208:406::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 13:28:17 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::d4) by CH2PR08CA0027.outlook.office365.com
 (2603:10b6:610:5a::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27 via Frontend
 Transport; Fri, 1 Dec 2023 13:28:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 13:28:16 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 1 Dec
 2023 07:28:13 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/47] drm/amd/display: Fix MST PBN/X.Y value calculations
Date: Fri, 1 Dec 2023 06:25:06 -0700
Message-ID: <20231201132731.2354141-11-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
References: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|IA0PR12MB9045:EE_
X-MS-Office365-Filtering-Correlation-Id: 67e7cc96-3f23-4265-d346-08dbf2716031
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1yIaBBaTH2IhHoeTrsAZvO0qcqOc+bKxOVD08wvu1dMKGdap40/a92nyGR43h7PaxtpPMPGdkHReCftoDio/OZ62GFCUTgvxP103I+csrpxEAI7yFYDVZzp1AFwdNYV5jLZ/I25NnxyCTRpqTTEpX1VBPy4mop2IOzsYLl4H9PhdUi94UuqYwela61xPwe30WWqLAjSyQ9kfARxxf64XK/zLpHxHYp3deHmq6KdGCT+JM45MptoEVyDWGEpdrCnfyC73NS2QF7TVdw6CKHtgvJnrkfruGTCWku8B8tdFeDV8XVDuZ5g6XWyJa1v4pI6Eif3xSQ3yR8b8OSYrrWD+fsvUDlqHBUOGRss31wTIVVu7mcD/+B6iJ9ygl93TLylkuKRc1DNTBFF4I163fFabdIqbq4tuEhOBTDr5t3PdYJEsMq7V/m27E82h7UyTjGqKK2r9ql9qTxU0KWYvMbGj+6485YsJBAFVoc4zauCiv1hsPw31KEQPwIsMZgwyngUWAz5r/SVC/8SZZgM0bdUCowPbCdKLb1c7dsX/dl4HAns28B6lz/QGiVc+ni/kga6PW79iQVZpA3Mjsbjopz7+3clTJaVOjM8hzJokgb/XZ1YUblYV/A1rbBgePPukZtNv35q2Z4mYqIfpUSXSpimxMFoj+S5MVeu7boKEIeUrEsi9x3S33mMVRmCGhJku5SDOAjZc6IF0JnNaEjpmmKjA7iQC9Ks3Q2VuiasyacvsLRyCXMqf+apP/S1Wl3KXYCH833FoFhdLvBP0bz5pfpY6Bw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(82310400011)(186009)(451199024)(1800799012)(64100799003)(46966006)(40470700004)(36840700001)(5660300002)(2906002)(8936002)(8676002)(4326008)(6916009)(54906003)(316002)(70206006)(70586007)(40480700001)(16526019)(26005)(41300700001)(6666004)(478600001)(2616005)(1076003)(83380400001)(426003)(336012)(40460700003)(47076005)(36860700001)(82740400003)(81166007)(356005)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 13:28:16.1380 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e7cc96-3f23-4265-d346-08dbf2716031
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9045
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
Cc: stylon.wang@amd.com, Ilya Bakoulin <ilya.bakoulin@amd.com>,
 jerry.zuo@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>, solomon.chiu@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ilya Bakoulin <ilya.bakoulin@amd.com>

Changing PBN calculation to be more in line with spec. We don't need to
inflate PBN_NATIVE value by the 1.006 margin, since that is already
taken care of in the get_pbn_per_slot function.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Ilya Bakoulin <ilya.bakoulin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index aa0a086aa7fc..b16b2e14312e 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -1057,18 +1057,21 @@ static struct fixed31_32 get_pbn_from_bw_in_kbps(uint64_t kbps)
 	uint32_t denominator = 1;
 
 	/*
-	 * margin 5300ppm + 300ppm ~ 0.6% as per spec, factor is 1.006
+	 * The 1.006 factor (margin 5300ppm + 300ppm ~ 0.6% as per spec) is not
+	 * required when determining PBN/time slot utilization on the link between
+	 * us and the branch, since that overhead is already accounted for in
+	 * the get_pbn_per_slot function.
+	 *
 	 * The unit of 54/64Mbytes/sec is an arbitrary unit chosen based on
 	 * common multiplier to render an integer PBN for all link rate/lane
 	 * counts combinations
 	 * calculate
-	 * peak_kbps *= (1006/1000)
 	 * peak_kbps *= (64/54)
-	 * peak_kbps *= 8    convert to bytes
+	 * peak_kbps /= (8 * 1000) convert to bytes
 	 */
 
-	numerator = 64 * PEAK_FACTOR_X1000;
-	denominator = 54 * 8 * 1000 * 1000;
+	numerator = 64;
+	denominator = 54 * 8 * 1000;
 	kbps *= numerator;
 	peak_kbps = dc_fixpt_from_fraction(kbps, denominator);
 
-- 
2.42.0

