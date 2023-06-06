Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ECD8C7EE2F
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 09:18:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0423810E318;
	Tue,  6 Jun 2023 09:18:00 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AADA10E30E
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 09:17:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzhCiWqukVAP+33Q5guFGSQXhpls3PACBDFfJxDL8GAdMWrGL3UXsY9611wOEkSEw2leHEWD9caevzwtpQOFKFc0CGSELBDGgmUBV0MSW9nLEerQ3c/fAsczh1GSZ/iD9+YQ7CTe0K5nXmbPiHxwySQI5/9wPQ1wvs8tmvvFQGX0JmbTJKmuhtvFcoFncjpAb1Z1PUo2KpBf0XUXE+nCtLnnTXdWhBhAPq15rNHgxOfuDYHsV2TwP6fAtESwYG35WE8BbS9p179T2bF2z40VN9Foh5/o43Fh/knFHk0Jqjw9kjgoFVSB1fvIYojk2A5TlS+dNdb4JrWJ3PQ7Xp7ghg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZ0I934wqBy3quAF1k2+eP5t+w68UWjJcMMC2wzeNRs=;
 b=cWtVdAdN+we4uVdo+5IQCSLzqylfZ7PY4q5lCSMpHMkSwprAavxV4NB6YFvdUbrsYU3J5GKHPVk730NW9w44jW3gq/gnswDswGUhInHJRTIF7GTpLBPFCOWcH0diAcfH8suoJ9Qq/1xjGG5jRIMElM4pm3OFn5YHza6G0u0Z/tZ3Kp8ou9wusmt81xRUyqN3k5Xr6UBbPNNWm5DiuCDE/zWj9MoyEkGdyqkMkPxcqpRj5eit+hh1eMQo+OZaGL7d1Wjr9dNFx+0ck8ozPC+JZSb1TCGWzAaotQEOo5KnK09Bhs3hiaVhLlxGowVH11PP4OysBI80sGQ0ycG24ZZFXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZ0I934wqBy3quAF1k2+eP5t+w68UWjJcMMC2wzeNRs=;
 b=ckkAcaOiyH/tZ5Spd1Qfcyv5diSVlPiAD3pg6M4h10WgY4CXn7bW7Ia6LPZWo2Wn3srpyPu20JZUdDxJ+OfXSNd9Hf63mwLX1xMr8DUY6vrFhnNp38Z2CN6A4cI85bQNMemu61YEqyr3xLZ2cASiURGLtXAKo0MGqTnvJwNLOgg=
Received: from MW4P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::17)
 by BL0PR12MB4963.namprd12.prod.outlook.com (2603:10b6:208:17d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 09:17:53 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::5a) by MW4P221CA0012.outlook.office365.com
 (2603:10b6:303:8b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Tue, 6 Jun 2023 09:17:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.33 via Frontend Transport; Tue, 6 Jun 2023 09:17:52 +0000
Received: from kullatnunu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 04:17:51 -0500
From: =?UTF-8?q?Nicolai=20H=C3=A4hnle?= <nicolai.haehnle@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tom St Denis <tom.stdenis@amd.com>
Subject: [PATCH umr 08/17] gfx11: wave limit is 16
Date: Tue, 6 Jun 2023 11:17:16 +0200
Message-ID: <20230606091725.20080-9-nicolai.haehnle@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230606091725.20080-1-nicolai.haehnle@amd.com>
References: <20230606091725.20080-1-nicolai.haehnle@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|BL0PR12MB4963:EE_
X-MS-Office365-Filtering-Correlation-Id: 7693fda3-c7c6-4d3b-9d26-08db666ee831
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aAp8DasnrnVPYKEYJn4EQXpkPkIqLgMUbD2bqmaZJvMoHJR+CJgz36lhFwq/kIZ/AZiv1/3OgYRhvCNBBIUM4fU7kRQi0Hq0f6s7ON0uiH0sbm9FTD5sNFi5IMYWEWYPvz7kRNGUlpzOJ5GKkDlg6wSvCoYcZE8w1phul37cL3+jqyiNQR5+V8Wr4ah+/A433VgH7nIBpRfLxvjPqUQrQMkC7x3bWr5yEHBdSd76uzam4zYAa7ocAxkkPmnavtwLHIgZBI42853SaV/n35o5gfJWHWC7LxN4HjTfqOn0KLrVHwuKGo6E+S3Y2tL2Amcw9ycVslDvGhQW1QfxKtGy10nhKVuyS9GutgwhoQ7bgmA9tRxH2YYF0BQ7AFQSGa5xshPmMiOQQLkL6/QMhfGMbXi+mAQHdB6t6mja+e4BoeAHwsHxaprWAnrVfMPLRS956feags8fhTaoJDPWANrpqDAFCotQcNaquImuBwt+7ejv2kuKQqQi/a3IM9YU6SCTTAQvnaW0n9LvBC8QbSaaRVwbujoGfMM3UZxitoLCCeFTE5kf98d+92mvmtC5JB0KcuKAXKA+UZLaS8O4FBmRazMQ5ATuHgAzRugi+EFrz4whlwyLn07Cp6mcHpd30K6Wh4HY+i4FWPwLu6YIEoKzsVHFnLAeoBQf3tl8EQpTDw52t1Wig5HPI6uMb1x0cm5Yiz7NMLJxwEBBTCvdaGNCXLdXxL7CNUaHUY8ro0vrcVJ9ThDdJ4rx1FNo0al7lHuATGs3KJDvNMRwqyI/mkBz7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199021)(40470700004)(36840700001)(46966006)(7696005)(82310400005)(40460700003)(6666004)(16526019)(26005)(40480700001)(83380400001)(47076005)(66574015)(426003)(336012)(36860700001)(1076003)(36756003)(2616005)(86362001)(186003)(81166007)(82740400003)(356005)(110136005)(5660300002)(316002)(478600001)(41300700001)(8936002)(8676002)(70206006)(4326008)(6636002)(70586007)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 09:17:52.9652 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7693fda3-c7c6-4d3b-9d26-08db666ee831
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4963
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
Cc: =?UTF-8?q?Nicolai=20H=C3=A4hnle?= <nicolai.haehnle@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Nicolai Hähnle <nicolai.haehnle@amd.com>
---
 src/lib/scan_waves.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/lib/scan_waves.c b/src/lib/scan_waves.c
index 3279cc2..37ebcff 100644
--- a/src/lib/scan_waves.c
+++ b/src/lib/scan_waves.c
@@ -593,21 +593,26 @@ static int umr_scan_wave_slot(struct umr_asic *asic, uint32_t se, uint32_t sh, u
  * \param pppwd points to the pointer-to-pointer-to the last element of a linked
  *              list of wave data structures, with the last element yet to be filled in.
  *              The pointer-to-pointer-to is updated by this function.
  */
 static int umr_scan_wave_simd(struct umr_asic *asic, uint32_t se, uint32_t sh, uint32_t cu, uint32_t simd,
 			       struct umr_wave_data ***pppwd)
 {
 	uint32_t wave, wave_limit;
 	int r;
 
-	wave_limit = asic->family <= FAMILY_AI ? 10 : 20;
+	if (asic->family <= FAMILY_AI)
+		wave_limit = 10;
+	else if (asic->family == FAMILY_NV)
+		wave_limit = 20;
+	else
+		wave_limit = 16;
 
 	for (wave = 0; wave < wave_limit; wave++) {
 		struct umr_wave_data *pwd = **pppwd;
 		if ((r = umr_scan_wave_slot(asic, se, sh, cu, simd, wave, pwd)) == 1) {
 			pwd->next = calloc(1, sizeof(*pwd));
 			if (!pwd->next) {
 				asic->err_msg("[ERROR]: Out of memory\n");
 				return -1;
 			}
 			*pppwd = &pwd->next;
-- 
2.40.0

