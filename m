Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 012F7EB64DD
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jul 2023 17:14:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A717610E5BB;
	Wed, 12 Jul 2023 17:14:48 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::616])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 666C110E5BF
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jul 2023 17:14:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JvkMAkLiL3OGlk86jrp9zNBzZjtTCXRFJLeeotRow1u6bevhAoBVGWrWRAIjHMchRDNjkT94242I9FqyckqscEfvEmrIgV5ptsHrfxluLC9lf9LkeFkbDpNlgiUbwNHZ4Cs8VjBC5dtt4v1xsQMXgm5BcFdQAuqY0gBosuLuIkJa9Mh0n6Ou1m9TI5suOgWi8aCWZOC1ME1pcC8K2KoX9NMh/YpCa4NNVQWoHtGGN0iHQXbHMb4nf1yRSixbrZiDokp5BUkJxCRizUeskVycx9v60nM/hBhF/mvVp3LNSJh65tjAHyStI50b5WVzUFqi92CFp88jtVt7J282fM0ruA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JR4kjWtolqayfp6Int+MZah3cniDsgRORK6ogeed6Kg=;
 b=Gakm62AIJhz2IS7pbtLkica2/d68APgLPLl3gp7BtWn5xTQpXdbAmNI9tDHVKdAPVUpaksgsAFQnLpZ2FS6/16A9FILXKQQ/lMPcFarTozoUOFn7sEfIa08mnCQcKSCHltfN3bc3X2IfSdtzo2/kfSIHZ5MWmY/8jaU6l4GHmJMTAJJFIFWCd2qrdHCTqhUjrelTiDGIo2Yw8rfHtYTmZTEKHIrW9lMViUfdksU+rwOGrfJDbHNPXDFX0ATo33RK4lNKkCrEcEbZdv3a6Md8uIPTOSsDrWlxI3wLbcwaL4NWVFmcPD5+p7mgWoAlaErnU/KYfWTA8MGcPaLGuUP8vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JR4kjWtolqayfp6Int+MZah3cniDsgRORK6ogeed6Kg=;
 b=CekkYXP626ec518O3UhbtjmCOAd9Su/sgI11lX1NVgzwedwzJb+YJc8p/Q7UtMNDJAhtQXz4swgcV8OLaUtC0Suun1ONVq4CJ9yECdfplF2kRGQupNDPLuJmmw9w2lbQfcB1+bDrLTuJwBX4xmucrsI0AkmZVO1wfzdIngtrtYg=
Received: from BN9P222CA0020.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::25)
 by DS0PR12MB7946.namprd12.prod.outlook.com (2603:10b6:8:151::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Wed, 12 Jul
 2023 17:14:43 +0000
Received: from BN8NAM11FT087.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10c:cafe::42) by BN9P222CA0020.outlook.office365.com
 (2603:10b6:408:10c::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24 via Frontend
 Transport; Wed, 12 Jul 2023 17:14:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT087.mail.protection.outlook.com (10.13.177.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 17:14:43 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 12:14:42 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 12 Jul 2023 12:14:39 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 31/33] drm/amd/display: refine to decide the verified link
 setting
Date: Thu, 13 Jul 2023 01:11:35 +0800
Message-ID: <20230712171137.3398344-32-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
References: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT087:EE_|DS0PR12MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: 997ef829-204c-4278-e1fd-08db82fb7c17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qQheqTRBRT9o47mtwUhi7Kif6RJb/fjpnvo4tfRmkwwntGR2h/paiEEr5+N57g/FerkgJeYHrevxQzAykx/YnPt41k1/2EuM9TxhDJZnuot+pIXUnxO5czBJAF6Wryuwt8zlBTxcRBtl5X2X84iLy4Xcct1gin7c0n6c5MIOs75j2LDLOLtpRo7LWoxkNa6F3QqQkbXJYdcoSHBSOrc8+8tbiAPbrtHJas6+4qtB1EgkdzinYYeu/4o2Tbyu11KyiT1vAxlw2d0HDFqamnLPbaU/FjxM+O3An5M0cV3JkKgFdxPUmWS2um5zBUeRLU/9Js3fgwXaynYEcoVyISaSoaGmAIf+sG6bLAckM2nhJ6NRbY66aHwC1umTUi/6DEsbFm2S3lDLyaOZkOSZnOA7X9CBRHBKkhitm4+Qdq0h6CMORnvhAs1NduEnmWluotZFCOsVME7I7vyobV6nRYF2uw0BN6K+RJKxUERrbbn8vHdrz0SKp9r5mfjSKF/1s80zsBhrfZo7NT3vqd2cxQEPzinCPcuS9fe5GP1NxNkVKWyQjy1WMPfKmpWWkhhUpPNFI5RP+wv9Dr3hZgp4trhOGtF5q0xJ9CEWdOTtDWzPlzmnQ8ZI3au8yyscOdC3IGBFBPEy2DbR6Mp6KuHjpkPwlUEdCQ8FM147IZpZAmNf0M80p9J8mAyzzNgTAel8PN5jLRaoNn0vScm2RvVMgMa1V6XTCnERuDPiDrQocCsmmiBn5Fu2O3yegfLouw4WNFo6EYH1eIY+mpkBlpBxjYluOA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199021)(36840700001)(46966006)(40470700004)(6916009)(7696005)(4326008)(70586007)(70206006)(478600001)(356005)(6666004)(82740400003)(81166007)(26005)(40480700001)(54906003)(316002)(41300700001)(1076003)(82310400005)(8676002)(8936002)(86362001)(40460700003)(83380400001)(5660300002)(15650500001)(186003)(2616005)(2906002)(36756003)(47076005)(36860700001)(426003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 17:14:43.3086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 997ef829-204c-4278-e1fd-08db82fb7c17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT087.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7946
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
Cc: stylon.wang@amd.com, Alan Liu <haoping.liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Zhikai Zhai <zhikai.zhai@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Zhikai Zhai <zhikai.zhai@amd.com>

[WHY]
We return false by default when link training fail at link loss.
It will cause we get a fail verified link caps directly.

[HOW]
Record the highest verified link caps. Use the recorded value as
the verified link caps if it is not successful in the last attempt
to avoid to use the lowest link setting.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Alan Liu <haoping.liu@amd.com>
Signed-off-by: Zhikai Zhai <zhikai.zhai@amd.com>
---
 .../dc/link/protocols/link_dp_capability.c      | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 08a1961e00a4..b38ac3ea06b0 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -2166,7 +2166,9 @@ static bool dp_verify_link_cap(
 							link,
 							&irq_data))
 				(*fail_count)++;
-
+		} else if (status == LINK_TRAINING_LINK_LOSS) {
+			success = true;
+			(*fail_count)++;
 		} else {
 			(*fail_count)++;
 		}
@@ -2189,6 +2191,7 @@ bool dp_verify_link_cap_with_retries(
 	int i = 0;
 	bool success = false;
 	int fail_count = 0;
+	struct dc_link_settings last_verified_link_cap = fail_safe_link_settings;
 
 	dp_trace_detect_lt_init(link);
 
@@ -2205,10 +2208,14 @@ bool dp_verify_link_cap_with_retries(
 		if (!link_detect_connection_type(link, &type) || type == dc_connection_none) {
 			link->verified_link_cap = fail_safe_link_settings;
 			break;
-		} else if (dp_verify_link_cap(link, known_limit_link_setting,
-				&fail_count) && fail_count == 0) {
-			success = true;
-			break;
+		} else if (dp_verify_link_cap(link, known_limit_link_setting, &fail_count)) {
+			last_verified_link_cap = link->verified_link_cap;
+			if (fail_count == 0) {
+				success = true;
+				break;
+			}
+		} else {
+			link->verified_link_cap = last_verified_link_cap;
 		}
 		fsleep(10 * 1000);
 	}
-- 
2.34.1

