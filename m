Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0541DC44501
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 823F210F6CC;
	Thu,  9 Jul 2026 21:02:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ahfKItmY";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012000.outbound.protection.outlook.com
 [40.93.195.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BBF610F6C5
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jersloydP8L4fZbKOy8xuJ67en4gJVCOZmHgstZAojrAZZaqUilJU1PbSgRBFOCMbusc8pkUHzhB0oBIuL8PgHnWdn+EiMh6cnj/+c5D2uIxGYqlgY4T4/x9/0GSlSQ6b5tfHO/kX9nJ5h67cjzyyKGCZ16eLnCeyHnf4YxSsNnCDrVOrJcpCH8Uc5EufEbKHZICUyRuP+0qnlNUU3vwQkLMdQs0SnTdDu6xOGYCJzARfUh0H7GB2ZwyBZMNSQkFzT4d1cNVfkv3/pWzNgK5w2hHNFegTqhANU6KGqUwbUenh25a98xMA0b1rvr2wPnI6NFgfgqUu68Q3mOH+QVRfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SS51OGYF63c0D/iy4jhrWNB0JzkR5mV/AKTm1ig6eZ4=;
 b=QSfbQeCSF0VfnxVtD/X5SANNLJ0Bemt8iH9lLIH/byxD2dXNDIpwt5aA5/ZIxQfq6f1/OX5eUGXfj4xsLy+6tF6U4TyMhOqTwKfDxCRCOYfbdenMcJIwUTCSSLXuHzN77NFsBauxI/R3HAV5KrPxXyUKid0ZpvN+nE6LaDyIMtuZoqGk/IVLP4ziQ73VeIX9a7/xbBxFD6KPnMPf4PAyHUj3onUIcPNIRQ3SwYHkWkWlD1GfcdFqqao+n+WqikyK/YWZGJHvNWzdLBmTgKaU1fIwDCIzb+3lwhswAyAKgaZWO7wS+HUr1lnJbESx6qgrIavf7euct/Jxhq0UuuwWsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SS51OGYF63c0D/iy4jhrWNB0JzkR5mV/AKTm1ig6eZ4=;
 b=ahfKItmY5QxyKPaDJGrQZidBmxfaVVrmkbiHprSMWkgcY7rkexHrfo9JE7iA9aVQgiGca+rAiGStnV4F1Q8qS5EnGnu9dA+0/4Cj+GCzTgEunfIsb3LGPZyZdrxsl/4IC1ie4LT4LZ5oax+oIR8i8EUcvzIsMJAbJtGnVipFU5M=
Received: from MN0PR04CA0026.namprd04.prod.outlook.com (2603:10b6:208:52d::17)
 by MN2PR12MB4285.namprd12.prod.outlook.com (2603:10b6:208:1d7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 21:02:11 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:52d:cafe::56) by MN0PR04CA0026.outlook.office365.com
 (2603:10b6:208:52d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 21:02:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:11 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:01:49 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Gabe Teeger
 <gabe.teeger@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 18/80] drm/amd/display: add null pointer access check
Date: Thu, 9 Jul 2026 16:47:46 -0400
Message-ID: <20260709205936.5719-19-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|MN2PR12MB4285:EE_
X-MS-Office365-Filtering-Correlation-Id: 1af895db-39cd-4b2c-c696-08deddfd588d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|6133799003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: jQrQMdSTHqnDRrLqcUuiYYxTNqLiypjOjL0cMuSOrLdlqqoAGRK+O03ttYHmOXapK9nxjcret8bchspYUjpsyXymFAOftCC5fhQmBXzLrBpSdyqqPfG1Ud/dmB6uzZ0B/koaq9VwZuU3LjGJqy72Jn3n5vm9apAAfrkzg5KQhgU8f9+oYhUphwxYx20TENJGBK9F1YYQ78AzJLENG9TmIZaL3SN6E+idXpE49VBid4YsGJu15jmVyuhxF3Bx08sOChi9CDpwuA2jpQC3a7SJOLbB7sxHdvGYBf+oJ00j5IzfaYjCN05IpWBShFkHQLUpBTOGfbgXeu1P3cFDZmUIIAQ07EDxICBH3oPyZEYkApxcD1BphZhU3MIYdWEbvCiYi3K3wc6pwIfWprd2O/Y5/tHAkuYlVuPcDe+ddeB+GKTQbcezjIrItfxmrArR241Z0UUi3OyW24bMa4KSJ2Sqw0eFfZS2BhHwjzwlem/NJNZ73VWeCyTRLmEjZIJtGvikFMZyLQTrRqhn+1frC1OWKgfTBMDd5v85GtQ7hGW8KyY8XQ4qGsvrp5FUagvs0qZAWdSexdfFfILxlzcSTQt6eUt3FGHhNFbEvGAUJznYC6aTYbi+E9J6fJlFnqUnjE21npnze3rhVvsw3lwacYFGQWXi/AgPKBwipl4zNUjAPEgRGu7Tjp2EmYYx0pXQtPO5oF5k4MfkTn1CQ8ai+c4C6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: x+GTl6n6BxRlCLejXHdHuPJip7Cry04Jma7vSICdeY1x3egW9lte4VcOeGgAheuQ9LqkPKSaJz3F15u/wQ+qaHfqP7C7uc3SrM+Mnx+fc+kC9lmNwpYQvWMVsrkOAQ4Bc17FYyu4Rczxi7Aeyfvs1UyszxGOzTNAfpOLYQMUfqXcNKr3FoyIuq/D5NfMo+XJV5nvg0j2z4aSvRx+VzB3jYbiFPGrJ3r/xaS41Rl3qPOGAnMV4+kb7Kx4zfvCUHXyI/QcvnlFjdzJuVst1qtsEkxHE4zEqqVsLtHxvLAvy4WdT/FC5Ll2QiVF9AiI8bfMvxeUuPPXvjHL/MrLR2eB/T9Bvq83omBBaqsCdudLI4cVVjYXKbjDAWYhtodMu1L7R8mYKMe8UWJdDtZHnP/MQ0p9KZMXKEsvavxAXtmhIWSO8ttkFVGF/j63fzT3RQRn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:11.4999 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af895db-39cd-4b2c-c696-08deddfd588d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4285
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
need to add null pointer access check

Reviewed-by: Gabe Teeger <gabe.teeger@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.c  | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.c
index 4b36c01a9e7a..00e82d627d91 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.c
@@ -1189,8 +1189,9 @@ void dcn10_link_encoder_dp_set_phy_pattern(
 		set_dp_phy_pattern_prbs7(enc10);
 		break;
 	case DP_TEST_PATTERN_80BIT_CUSTOM:
-		set_dp_phy_pattern_80bit_custom(
-			enc10, param->custom_pattern);
+		if (param)
+			set_dp_phy_pattern_80bit_custom(
+				enc10, param->custom_pattern);
 		break;
 	case DP_TEST_PATTERN_CP2520_1:
 		set_dp_phy_pattern_hbr2_compliance_cp2520_2(enc10, 1);
@@ -1202,8 +1203,9 @@ void dcn10_link_encoder_dp_set_phy_pattern(
 		set_dp_phy_pattern_hbr2_compliance_cp2520_2(enc10, 3);
 		break;
 	case DP_TEST_PATTERN_VIDEO_MODE: {
-		set_dp_phy_pattern_passthrough_mode(
-			enc10, param->dp_panel_mode);
+		if (param)
+			set_dp_phy_pattern_passthrough_mode(
+				enc10, param->dp_panel_mode);
 		break;
 	}

--
2.55.0

