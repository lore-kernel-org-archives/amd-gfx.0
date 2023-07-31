Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 087C3C00528
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Jul 2023 20:41:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9357E10E2E2;
	Mon, 31 Jul 2023 20:41:36 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::622])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F93610E2E4
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Jul 2023 20:41:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HpsWh3oFruZpV1KXSy3UqpMHLpArse0ClJHKz9lwLr50A44Ge3q4kOsfBYOD0qphxY2X9gD/GymFCXTiEqK9yVWKZxfeWC24pkeIfHEPcmHZLKuiTH5eV6sdAclLnBqCcm+9pedKklOkNoFPKnB27wu9aeshG3Z3M20E6jlQr05cpcCRQ4tnhEw3wRbYDFNZNO0PTyuVldjTtsIKuUtwu1R1KQwY6sHkWt0Glv0BziVqXJp56it/WlaAzlKIN0Pmq6r40MSL5ZzZ+9VPIO94kibmcIWWCogI5WlB3DscbBGcTDIQBms3o0zgAZqg6l3NWT4PPQwQpNJc6LwChrFIMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVLU5PZydikCVG0gz/eo76l7V2YjsSL8UD54DGykGlg=;
 b=ocxT74ngVC/BkdTZTtYzsv8CukdB+INcqbb+2bIYyP2MbxecEvWbbjbnF2MAwioj2Rnxzuxqhksz87asHdCexMj2KDAs4Ulp/2tnJj7lM79+dO8rzkdmGNdFkoBP9I6WeplB3eR121GFzlBQKfL4a567lUYrBfytEh8BXr6HrcQcEU87A9KEI4VuHB2MV7Nh0KQPC9O34hUnY0Cax9uoFPlI2OHnuorXqOb7RNI1zUCRZJ3J1vomKuPlvJWFi+1OD4ERBiptFA87/7KUGgx0n7rHbTyUEb2VoD4J3xmS4Tkp4/ON+JJWMyJx9KRGKN+nbk2DYBFRBjMCOVTdaxqufw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVLU5PZydikCVG0gz/eo76l7V2YjsSL8UD54DGykGlg=;
 b=kBi5ITNGT/tvqQl5HQaWL7FPOlZ8YrQLTXr/t65CLZyFv2trkR1tedRdWbJ/387PLQGgEQtTz2+AZ5exl54bClFRDYEDm2O5Y88DitBfP30tHOCZhSlfBefg6WVFry6h7lpXS3YO+aD6F7Cd69HurGuEbb4k586kCtS1uKv/99Y=
Received: from MW4P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::8) by
 SN7PR12MB8770.namprd12.prod.outlook.com (2603:10b6:806:34b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Mon, 31 Jul
 2023 20:41:31 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:303:8b:cafe::a8) by MW4P221CA0003.outlook.office365.com
 (2603:10b6:303:8b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42 via Frontend
 Transport; Mon, 31 Jul 2023 20:41:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.25 via Frontend Transport; Mon, 31 Jul 2023 20:41:31 +0000
Received: from jc-d.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 31 Jul
 2023 15:41:29 -0500
From: Jay Cornwall <jay.cornwall@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdkfd: Sign-extend TMA address in trap handler
Date: Mon, 31 Jul 2023 15:40:18 -0500
Message-ID: <20230731204019.9519-2-jay.cornwall@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230731204019.9519-1-jay.cornwall@amd.com>
References: <20230731204019.9519-1-jay.cornwall@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|SN7PR12MB8770:EE_
X-MS-Office365-Filtering-Correlation-Id: 01ee33a3-6b81-46c7-c8c0-08db92068596
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V1nXhXFmY8TjnnQg7h5sYysV/DAOFFI9CTseoS9/mJyZoouBuGFuySw+2eHcPf4WnWGA6Gz01uXxgun1Xg2w6R9oB1WG0KajdTAC4MKYRZv+0f70fArh8Z3q3+PDCQ/wjTVbHdv6Yyz5YSgZKIp29+fLzygLqUiKrrM+9wlLMUN4lW2/6rowjaAiR6+T3pO2WQ0t6E4i+fi9ROZOVyiIZAZLYUmfI2Fx2pycOBTuOVxvZDJGFmZQjJuRX/mZMf7EpxCmnNUvc9sB9BeA/kiBXo6iXMJa0fZWt6bFPAUW+rAT7WUqNo2YPEnQMEUPs3rbVIHMlj8UYlIgD5VJWFKYRE9SKLd/xXzMRdckk0yGdaH4HwkJX1WjPipT3D6Ou6Eow4ocRIJ5+PxS9bHEme/xN7jl2WvtHjxPCoCed6nh9Vesri/Iz4qvxS2jD+XJZXc/yexEhORDbTNBHd38MQ2xZSKDr6ZLT0szAj87onS9ql1JLHPfWQOb9hVMDfY4KDFzyoVA45y2RCUbEVOJVBCT1zVKMfaow2xGPH1px1L+36d05akZJbPdoXgBbj0BlzJs6PXtVyQWv6KtVgGcxQm+zjA7C/Iofo/AOZ7TwWZmIIXEe/t/BoLkT2PrEw1igm9gzDKPFC2Bb2P7p3KAAZfYYUW/I2YIRbtGS8KjgqpS407lKU4x/FCrAxSnp/2nZa3p+ZuKu7RxAJAnUWOt4gPV/V6IuZxJ9agfBkoqUz9DpVkzVqfg7aqanHTcmBySN6UlWtR1vHADGElK3xV8V8xeoA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(136003)(396003)(346002)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(2906002)(82740400003)(16526019)(1076003)(83380400001)(336012)(86362001)(26005)(186003)(426003)(2616005)(47076005)(356005)(36860700001)(81166007)(478600001)(7696005)(6666004)(36756003)(40480700001)(6916009)(4326008)(316002)(41300700001)(70206006)(70586007)(8936002)(8676002)(5660300002)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 20:41:31.0361 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ee33a3-6b81-46c7-c8c0-08db92068596
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8770
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
Cc: Jay Cornwall <jay.cornwall@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SMEM instructions can reach addresses above 47 bits but require
bit 47 to be sign-extended through bits [63:48].

This allows the TMA to be relocated in a following patch.

Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
---
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 58 ++++++++++++-------
 .../amd/amdkfd/cwsr_trap_handler_gfx10.asm    |  5 ++
 .../drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm |  5 ++
 3 files changed, 46 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
index 717ad0633dbe..d7cd5fa313ff 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
@@ -274,14 +274,14 @@ static const uint32_t cwsr_trap_gfx8_hex[] = {
 
 
 static const uint32_t cwsr_trap_gfx9_hex[] = {
-	0xbf820001, 0xbf820254,
+	0xbf820001, 0xbf820258,
 	0xb8f8f802, 0x8978ff78,
 	0x00020006, 0xb8fbf803,
 	0x866eff78, 0x00002000,
 	0xbf840009, 0x866eff6d,
 	0x00ff0000, 0xbf85001e,
 	0x866eff7b, 0x00000400,
-	0xbf850051, 0xbf8e0010,
+	0xbf850055, 0xbf8e0010,
 	0xb8fbf803, 0xbf82fffa,
 	0x866eff7b, 0x03c00900,
 	0xbf850015, 0x866eff7b,
@@ -294,13 +294,15 @@ static const uint32_t cwsr_trap_gfx9_hex[] = {
 	0xbf850007, 0xb8eef801,
 	0x866eff6e, 0x00000800,
 	0xbf850003, 0x866eff7b,
-	0x00000400, 0xbf850036,
+	0x00000400, 0xbf85003a,
 	0xb8faf807, 0x867aff7a,
 	0x001f8000, 0x8e7a8b7a,
 	0x8977ff77, 0xfc000000,
 	0x87777a77, 0xba7ff807,
 	0x00000000, 0xb8faf812,
 	0xb8fbf813, 0x8efa887a,
+	0xbf0d8f7b, 0xbf840002,
+	0x877bff7b, 0xffff0000,
 	0xc0031bbd, 0x00000010,
 	0xbf8cc07f, 0x8e6e976e,
 	0x8977ff77, 0x00800000,
@@ -676,14 +678,14 @@ static const uint32_t cwsr_trap_gfx9_hex[] = {
 };
 
 static const uint32_t cwsr_trap_nv1x_hex[] = {
-	0xbf820001, 0xbf8201f1,
+	0xbf820001, 0xbf8201f5,
 	0xb0804004, 0xb978f802,
 	0x8a78ff78, 0x00020006,
 	0xb97bf803, 0x876eff78,
 	0x00002000, 0xbf840009,
 	0x876eff6d, 0x00ff0000,
 	0xbf85001e, 0x876eff7b,
-	0x00000400, 0xbf850057,
+	0x00000400, 0xbf85005b,
 	0xbf8e0010, 0xb97bf803,
 	0xbf82fffa, 0x876eff7b,
 	0x00000900, 0xbf850015,
@@ -697,7 +699,7 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
 	0xb96ef801, 0x876eff6e,
 	0x00000800, 0xbf850003,
 	0x876eff7b, 0x00000400,
-	0xbf85003c, 0x8a77ff77,
+	0xbf850040, 0x8a77ff77,
 	0xff000000, 0xb97af807,
 	0x877bff7a, 0x02000000,
 	0x8f7b867b, 0x88777b77,
@@ -706,6 +708,8 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
 	0x8a7aff7a, 0x023f8000,
 	0xb9faf807, 0xb97af812,
 	0xb97bf813, 0x8ffa887a,
+	0xbf0d8f7b, 0xbf840002,
+	0x887bff7b, 0xffff0000,
 	0xf4011bbd, 0xfa000010,
 	0xbf8cc07f, 0x8f6e976e,
 	0x8a77ff77, 0x00800000,
@@ -1094,14 +1098,14 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
 };
 
 static const uint32_t cwsr_trap_arcturus_hex[] = {
-	0xbf820001, 0xbf8202d0,
+	0xbf820001, 0xbf8202d4,
 	0xb8f8f802, 0x8978ff78,
 	0x00020006, 0xb8fbf803,
 	0x866eff78, 0x00002000,
 	0xbf840009, 0x866eff6d,
 	0x00ff0000, 0xbf85001e,
 	0x866eff7b, 0x00000400,
-	0xbf850051, 0xbf8e0010,
+	0xbf850055, 0xbf8e0010,
 	0xb8fbf803, 0xbf82fffa,
 	0x866eff7b, 0x03c00900,
 	0xbf850015, 0x866eff7b,
@@ -1114,13 +1118,15 @@ static const uint32_t cwsr_trap_arcturus_hex[] = {
 	0xbf850007, 0xb8eef801,
 	0x866eff6e, 0x00000800,
 	0xbf850003, 0x866eff7b,
-	0x00000400, 0xbf850036,
+	0x00000400, 0xbf85003a,
 	0xb8faf807, 0x867aff7a,
 	0x001f8000, 0x8e7a8b7a,
 	0x8977ff77, 0xfc000000,
 	0x87777a77, 0xba7ff807,
 	0x00000000, 0xb8faf812,
 	0xb8fbf813, 0x8efa887a,
+	0xbf0d8f7b, 0xbf840002,
+	0x877bff7b, 0xffff0000,
 	0xc0031bbd, 0x00000010,
 	0xbf8cc07f, 0x8e6e976e,
 	0x8977ff77, 0x00800000,
@@ -1572,14 +1578,14 @@ static const uint32_t cwsr_trap_arcturus_hex[] = {
 };
 
 static const uint32_t cwsr_trap_aldebaran_hex[] = {
-	0xbf820001, 0xbf8202db,
+	0xbf820001, 0xbf8202df,
 	0xb8f8f802, 0x8978ff78,
 	0x00020006, 0xb8fbf803,
 	0x866eff78, 0x00002000,
 	0xbf840009, 0x866eff6d,
 	0x00ff0000, 0xbf85001e,
 	0x866eff7b, 0x00000400,
-	0xbf850051, 0xbf8e0010,
+	0xbf850055, 0xbf8e0010,
 	0xb8fbf803, 0xbf82fffa,
 	0x866eff7b, 0x03c00900,
 	0xbf850015, 0x866eff7b,
@@ -1592,13 +1598,15 @@ static const uint32_t cwsr_trap_aldebaran_hex[] = {
 	0xbf850007, 0xb8eef801,
 	0x866eff6e, 0x00000800,
 	0xbf850003, 0x866eff7b,
-	0x00000400, 0xbf850036,
+	0x00000400, 0xbf85003a,
 	0xb8faf807, 0x867aff7a,
 	0x001f8000, 0x8e7a8b7a,
 	0x8977ff77, 0xfc000000,
 	0x87777a77, 0xba7ff807,
 	0x00000000, 0xb8faf812,
 	0xb8fbf813, 0x8efa887a,
+	0xbf0d8f7b, 0xbf840002,
+	0x877bff7b, 0xffff0000,
 	0xc0031bbd, 0x00000010,
 	0xbf8cc07f, 0x8e6e976e,
 	0x8977ff77, 0x00800000,
@@ -2061,14 +2069,14 @@ static const uint32_t cwsr_trap_aldebaran_hex[] = {
 };
 
 static const uint32_t cwsr_trap_gfx10_hex[] = {
-	0xbf820001, 0xbf82021c,
+	0xbf820001, 0xbf820220,
 	0xb0804004, 0xb978f802,
 	0x8a78ff78, 0x00020006,
 	0xb97bf803, 0x876eff78,
 	0x00002000, 0xbf840009,
 	0x876eff6d, 0x00ff0000,
 	0xbf85001e, 0x876eff7b,
-	0x00000400, 0xbf850041,
+	0x00000400, 0xbf850045,
 	0xbf8e0010, 0xb97bf803,
 	0xbf82fffa, 0x876eff7b,
 	0x00000900, 0xbf850015,
@@ -2082,8 +2090,10 @@ static const uint32_t cwsr_trap_gfx10_hex[] = {
 	0xb96ef801, 0x876eff6e,
 	0x00000800, 0xbf850003,
 	0x876eff7b, 0x00000400,
-	0xbf850026, 0xb97af812,
+	0xbf85002a, 0xb97af812,
 	0xb97bf813, 0x8ffa887a,
+	0xbf0d8f7b, 0xbf840002,
+	0x887bff7b, 0xffff0000,
 	0xf4011bbd, 0xfa000010,
 	0xbf8cc07f, 0x8f6e976e,
 	0x8a77ff77, 0x00800000,
@@ -2496,7 +2506,7 @@ static const uint32_t cwsr_trap_gfx10_hex[] = {
 };
 
 static const uint32_t cwsr_trap_gfx11_hex[] = {
-	0xbfa00001, 0xbfa00221,
+	0xbfa00001, 0xbfa00225,
 	0xb0804006, 0xb8f8f802,
 	0x9178ff78, 0x00020006,
 	0xb8fbf803, 0xbf0d9e6d,
@@ -2506,7 +2516,7 @@ static const uint32_t cwsr_trap_gfx11_hex[] = {
 	0xbfa10009, 0x8b6eff6d,
 	0x00ff0000, 0xbfa2001e,
 	0x8b6eff7b, 0x00000400,
-	0xbfa20041, 0xbf830010,
+	0xbfa20045, 0xbf830010,
 	0xb8fbf803, 0xbfa0fffa,
 	0x8b6eff7b, 0x00000900,
 	0xbfa20015, 0x8b6eff7b,
@@ -2519,9 +2529,11 @@ static const uint32_t cwsr_trap_gfx11_hex[] = {
 	0xbfa20007, 0xb8eef801,
 	0x8b6eff6e, 0x00000800,
 	0xbfa20003, 0x8b6eff7b,
-	0x00000400, 0xbfa20026,
+	0x00000400, 0xbfa2002a,
 	0xbefa4d82, 0xbf89fc07,
-	0x84fa887a, 0xf4005bbd,
+	0x84fa887a, 0xbf0d8f7b,
+	0xbfa10002, 0x8c7bff7b,
+	0xffff0000, 0xf4005bbd,
 	0xf8000010, 0xbf89fc07,
 	0x846e976e, 0x9177ff77,
 	0x00800000, 0x8c776e77,
@@ -2939,14 +2951,14 @@ static const uint32_t cwsr_trap_gfx11_hex[] = {
 };
 
 static const uint32_t cwsr_trap_gfx9_4_3_hex[] = {
-	0xbf820001, 0xbf8202d7,
+	0xbf820001, 0xbf8202db,
 	0xb8f8f802, 0x8978ff78,
 	0x00020006, 0xb8fbf803,
 	0x866eff78, 0x00002000,
 	0xbf840009, 0x866eff6d,
 	0x00ff0000, 0xbf85001a,
 	0x866eff7b, 0x00000400,
-	0xbf85004d, 0xbf8e0010,
+	0xbf850051, 0xbf8e0010,
 	0xb8fbf803, 0xbf82fffa,
 	0x866eff7b, 0x03c00900,
 	0xbf850011, 0x866eff7b,
@@ -2957,13 +2969,15 @@ static const uint32_t cwsr_trap_gfx9_4_3_hex[] = {
 	0x866e6f6e, 0xbf850006,
 	0x866eff6d, 0x00ff0000,
 	0xbf850003, 0x866eff7b,
-	0x00000400, 0xbf850036,
+	0x00000400, 0xbf85003a,
 	0xb8faf807, 0x867aff7a,
 	0x001f8000, 0x8e7a8b7a,
 	0x8979ff79, 0xfc000000,
 	0x87797a79, 0xba7ff807,
 	0x00000000, 0xb8faf812,
 	0xb8fbf813, 0x8efa887a,
+	0xbf0d8f7b, 0xbf840002,
+	0x877bff7b, 0xffff0000,
 	0xc0031bbd, 0x00000010,
 	0xbf8cc07f, 0x8e6e976e,
 	0x8979ff79, 0x00800000,
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
index 8b92c33c2a7c..fdab64624422 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
@@ -276,6 +276,11 @@ L_FETCH_2ND_TRAP:
 #endif
 	s_lshl_b64	[ttmp14, ttmp15], [ttmp14, ttmp15], 0x8
 
+	s_bitcmp1_b32	ttmp15, 0xF
+	s_cbranch_scc0	L_NO_SIGN_EXTEND_TMA
+	s_or_b32	ttmp15, ttmp15, 0xFFFF0000
+L_NO_SIGN_EXTEND_TMA:
+
 	s_load_dword    ttmp2, [ttmp14, ttmp15], 0x10 glc:1			// debug trap enabled flag
 	s_waitcnt       lgkmcnt(0)
 	s_lshl_b32      ttmp2, ttmp2, TTMP11_DEBUG_TRAP_ENABLED_SHIFT
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm
index f2087cc2e89d..e506411ad28a 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm
@@ -283,6 +283,11 @@ L_FETCH_2ND_TRAP:
     s_getreg_b32    ttmp15, hwreg(HW_REG_SQ_SHADER_TMA_HI)
     s_lshl_b64      [ttmp14, ttmp15], [ttmp14, ttmp15], 0x8
 
+    s_bitcmp1_b32   ttmp15, 0xF
+    s_cbranch_scc0  L_NO_SIGN_EXTEND_TMA
+    s_or_b32        ttmp15, ttmp15, 0xFFFF0000
+L_NO_SIGN_EXTEND_TMA:
+
     s_load_dword    ttmp2, [ttmp14, ttmp15], 0x10 glc:1 // debug trap enabled flag
     s_waitcnt       lgkmcnt(0)
     s_lshl_b32      ttmp2, ttmp2, TTMP_DEBUG_TRAP_ENABLED_SHIFT
-- 
2.25.1

