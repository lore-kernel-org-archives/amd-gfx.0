Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA4DC677F1
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 16:57:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33E2C10E618;
	Tue, 10 Jan 2023 16:57:22 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF5C010E614
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 16:57:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKp7hakc60cl1PnXUvVNibDXf/R6Cs4ErmkfmiVYnk7RkFKNs/z2tXOOuPHZr8J8nT52pXBd1LgOhvx1P3Cz6DiPesNO0D7gGVdn6CjsjyAcswXrizSQPweSRoLQqgNDid+IdhBT8CieGVDe8glnP5FXqvAxlgMUuYr/1sNelE6JpjTHJt/tLUST8yDTrLum0tfx1OGpsFzziExmaiO4+BigTbUuophjVYGMFTiuLOw3aNTG9v9KPbh4JLXbaAf+HUPwACNa9v/2ZKnKxu7nf3g+mVBIt0OKs/6zxCdBXf2q/5JwfhPFjisnMIysuoZXXdrGQV4hSm7sIJG4ztSBLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9z2MK6Zq/R8L4VHTToQunJrj/HJH1nUj71J4HRLcr0Q=;
 b=SeJ3IOTKaAyQvPzDh6stdQHW78aUWwodG8haqcxwSikZSUs+nciIHRgLpm0hDG7TdEcg71fG/OXjdt9qrPSlISCkACHeMR5OEFnlxX01NN8twVutMX1v9sHktCEL852Wmp7Ec7t+OL1Dz3ZGRwhyqLjlckjwxuvYuFDUTnDPb9/pnyG3KatyRbGHSEh6CiIfJs/9/71+jLsL9nzm+BMvUXSxhVhsTModugM8j6xmzRPntJxf5CqY31la4rkxEFeZUYs5hKczch805I6yKfgKo+Yu0kElZkdYO3kIio4ZA0I0BNOYCoPwdtC3XuONzIQUJtcFBnRVWny3U7IxNq8ZGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9z2MK6Zq/R8L4VHTToQunJrj/HJH1nUj71J4HRLcr0Q=;
 b=V9DcKlCR/qlcMbPEtDEAkqXmx6WCjXoYN9Oz28mMr5VXvryb1g8TDDBg/sB/SJVTJlSGtVCPlEyk1jdSqKurE5LJ93zfMqq/FIgoOIrtwSOcaTFmPXQQTnmv93GKo+YoPLuMSoWhCkz0azyH3KFqxMAGOjSGhmNGZOxsc3z+how=
Received: from MW4PR04CA0204.namprd04.prod.outlook.com (2603:10b6:303:86::29)
 by PH0PR12MB5419.namprd12.prod.outlook.com (2603:10b6:510:e9::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 16:57:17 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::af) by MW4PR04CA0204.outlook.office365.com
 (2603:10b6:303:86::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Tue, 10 Jan 2023 16:57:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Tue, 10 Jan 2023 16:57:17 +0000
Received: from atma-again.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 10:57:14 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/37] drm/amd/display: Account for DCC Meta pitch in DML MALL
 surface calculations
Date: Tue, 10 Jan 2023 11:55:11 -0500
Message-ID: <20230110165535.3358492-14-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
References: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT028:EE_|PH0PR12MB5419:EE_
X-MS-Office365-Filtering-Correlation-Id: 15605b4e-e5ef-4fd4-6cbf-08daf32bbb25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H7KBYPM2coRTHuT6sA0RdiIV3iNqKUoKhiudLhxfdFSkVj+fIejzy738qBUm5gZKpmyOyekRp/X6n/ZfG7BcY7c8B+oQfiC4QOw/dwDbG0qkUzBGHYY7RXdu+Bqejox58z0lFQVMF9kN3grRHXx+qCD7vqFnS9UzRS27w8HhRimvVLq/u/7rZ60KhAGGBI3DpM+ksW4FQwxG+d+AE6l1Qf54BFsWgJSMT7uPJkqnFFdAPBZlEC54baVMGcIRMhh+axwGGCHZ944wwxQ39LMEwmW4KTgTtkfVS0nIIcG3hLRuyfXVUn5yTiRD6h8R+AovZErt4WK4g1vYzCES1l7568vMWK1zJ5npfNR5GkKBsh52nGq5exjd7JWQyXv6qLFA4ExZ/BZlmJO2f5ZtL5nhAy7zypP/utb97lHCEXX1j6LsYaSBpT3W9m9QGz+7braJ/2SfNNRj08ovhRiSckzNzDM/7VFdqkWLH+uCjxILbTnVY/I/4iEClj3YwWIag0irkBibbb85LGmbuoPWuRxzTTaysc4GMinVVGnBMLOVEpc7WEBog2jFuVBf1Yj8XxYQ7bREM3R1pHLYjmJJxNRoGgaadmjpz9xUfuNRKQBm2fX19/wBZqVH75uEx1IJjk/bybXSMAOpXuRxIjbR+JLduvvJoYZjeofOE9RvURQNAQJGw0hdRzchiwmZoZA1Q6Z1Mv/16tQMeF8ZGMjCAVUc7SmfgNYY0nTLL7tE4cIR0ak=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(40460700003)(426003)(41300700001)(2616005)(47076005)(54906003)(316002)(70586007)(4326008)(336012)(36756003)(1076003)(6916009)(70206006)(8676002)(86362001)(82310400005)(36860700001)(40480700001)(83380400001)(81166007)(356005)(82740400003)(8936002)(5660300002)(2906002)(478600001)(186003)(16526019)(7696005)(6666004)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 16:57:17.3719 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15605b4e-e5ef-4fd4-6cbf-08daf32bbb25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5419
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
Cc: stylon.wang@amd.com, Dillon Varone <Dillon.Varone@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <Dillon.Varone@amd.com>

DML incorrectly uses surface width for determining DCC meta size in MALL
allocation calculations.  Meta pitch should be used instead.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
---
 .../drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c |  4 ++++
 .../display/dc/dml/dcn32/display_mode_vba_util_32.c    | 10 ++++++----
 .../display/dc/dml/dcn32/display_mode_vba_util_32.h    |  2 ++
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index 4b8f5fa0f0ad..83765008dd5f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -411,6 +411,8 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 				v->BlockWidthC,
 				v->BlockHeightY,
 				v->BlockHeightC,
+				mode_lib->vba.DCCMetaPitchY,
+				mode_lib->vba.DCCMetaPitchC,
 
 				/* Output */
 				v->SurfaceSizeInMALL,
@@ -2650,6 +2652,8 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 			mode_lib->vba.MacroTileWidthC,
 			mode_lib->vba.MacroTileHeightY,
 			mode_lib->vba.MacroTileHeightC,
+			mode_lib->vba.DCCMetaPitchY,
+			mode_lib->vba.DCCMetaPitchC,
 
 			/* Output */
 			mode_lib->vba.SurfaceSizeInMALL,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index b53feeaf5cf1..4279cd481de1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -1796,6 +1796,8 @@ void dml32_CalculateSurfaceSizeInMall(
 		unsigned int ReadBlockWidthC[],
 		unsigned int ReadBlockHeightY[],
 		unsigned int ReadBlockHeightC[],
+		unsigned int DCCMetaPitchY[],
+		unsigned int DCCMetaPitchC[],
 
 		/* Output */
 		unsigned int    SurfaceSizeInMALL[],
@@ -1828,7 +1830,7 @@ void dml32_CalculateSurfaceSizeInMall(
 			}
 			if (DCCEnable[k] == true) {
 				SurfaceSizeInMALL[k] = SurfaceSizeInMALL[k] +
-						dml_min(dml_ceil(SurfaceWidthY[k], 8 * Read256BytesBlockWidthY[k]),
+						dml_min(dml_ceil(DCCMetaPitchY[k], 8 * Read256BytesBlockWidthY[k]),
 							dml_floor(ViewportXStartY[k] + ViewportWidthY[k] + 8 *
 							Read256BytesBlockWidthY[k] - 1, 8 * Read256BytesBlockWidthY[k])
 							- dml_floor(ViewportXStartY[k], 8 * Read256BytesBlockWidthY[k]))
@@ -1839,7 +1841,7 @@ void dml32_CalculateSurfaceSizeInMall(
 							* Read256BytesBlockHeightY[k])) * BytesPerPixelY[k] / 256;
 				if (Read256BytesBlockWidthC[k] > 0) {
 					SurfaceSizeInMALL[k] = SurfaceSizeInMALL[k] +
-							dml_min(dml_ceil(SurfaceWidthC[k], 8 *
+							dml_min(dml_ceil(DCCMetaPitchC[k], 8 *
 								Read256BytesBlockWidthC[k]),
 								dml_floor(ViewportXStartC[k] + ViewportWidthC[k] + 8
 								* Read256BytesBlockWidthC[k] - 1, 8 *
@@ -1872,7 +1874,7 @@ void dml32_CalculateSurfaceSizeInMall(
 			}
 			if (DCCEnable[k] == true) {
 				SurfaceSizeInMALL[k] = SurfaceSizeInMALL[k] +
-						dml_ceil(dml_min(SurfaceWidthY[k], ViewportWidthY[k] + 8 *
+						dml_ceil(dml_min(DCCMetaPitchY[k], ViewportWidthY[k] + 8 *
 								Read256BytesBlockWidthY[k] - 1), 8 *
 								Read256BytesBlockWidthY[k]) *
 						dml_ceil(dml_min(SurfaceHeightY[k], ViewportHeightY[k] + 8 *
@@ -1881,7 +1883,7 @@ void dml32_CalculateSurfaceSizeInMall(
 
 				if (Read256BytesBlockWidthC[k] > 0) {
 					SurfaceSizeInMALL[k] = SurfaceSizeInMALL[k] +
-							dml_ceil(dml_min(SurfaceWidthC[k], ViewportWidthC[k] + 8 *
+							dml_ceil(dml_min(DCCMetaPitchC[k], ViewportWidthC[k] + 8 *
 									Read256BytesBlockWidthC[k] - 1), 8 *
 									Read256BytesBlockWidthC[k]) *
 							dml_ceil(dml_min(SurfaceHeightC[k], ViewportHeightC[k] + 8 *
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
index 779c6805f599..83edfcee8851 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
@@ -358,6 +358,8 @@ void dml32_CalculateSurfaceSizeInMall(
 		unsigned int ReadBlockWidthC[],
 		unsigned int ReadBlockHeightY[],
 		unsigned int ReadBlockHeightC[],
+		unsigned int DCCMetaPitchY[],
+		unsigned int DCCMetaPitchC[],
 
 		/* Output */
 		unsigned int    SurfaceSizeInMALL[],
-- 
2.39.0

