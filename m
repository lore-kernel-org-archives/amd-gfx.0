Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB0AC46467
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 16:58:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 228F010E620;
	Tue, 10 Jan 2023 16:58:38 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C86BD10E61D
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 16:58:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gzrpQqThTk/rWUCJZBef4aZ6F9F1AyT7Perm2uzR8KdokviWX3+jiOxFizfeT39LKXucPsi/lSDIzwo4wcbURxAcA7ANDYrpg/z52tjciKeWFAFjkBWCsR9uL6vFa0j1ytXbsh33jVhUvljFoqlQc6kUHli0tErJkhg8LYU96Twiv9m/hAFGfZv7ntM61l7w+7yunKibtQvuXdn3YIA9OYuH0JCSp+q58iCf8haL6UFf6evP1RO9b0LwEsbL5I74eq8jBkRDnWJaVgH19IDFG6Z7fZRtV7WLRWHijsNcOljLKCNPRawbGCFvT+WgfBaNUhvVEfnI5aiH+po6Yf+gFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELuI+dPU7CketvU1eS+wRZIO7ZWkD2hs6R3Rh3O9o90=;
 b=jE2xX2QbSgaC9G/geN9iPLCHXd4DbLbGydgWTe5uEJQtpVt7rzoSmpxPWgdZdRrdCRQgBg+ZMV8cfxD+4Ppsou93rr6OnSdotpj/6/ftKHalSqaioZLLrOXD0uE/3yDP7t8yidlT2DBF1kpZm73rWHUK6ogrq4fblUStxkPERNLw1MdQZpnvXpowkEb3i0fM7PWFGtWZMm4agPEoAWV/1nwb9ZppeL+TvB0ZG7t9kDYEQ+QajbVUuNODIlPqdPESc31bVWe1TxZrsgBLFiKLGh8JWfdqN+poqcnRdI30QBhMQrEkFnzvszzCJ6lk7nc4djuHUIEfUH57hhx0RDKH5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELuI+dPU7CketvU1eS+wRZIO7ZWkD2hs6R3Rh3O9o90=;
 b=oVmF5NWpR3u3WeuxsGxcEuJXmI5/9NUJEU4qZxTv1wrVDL9YFQnMMiGPg9YAoPhfg7JgVcg7yOqaILsUujg58rrjO3I7fjsbtk2jNS8cfsTDRgVUuJY4QEb+S9D2sN6WigjI77WB2FfEvMvjLL5kZA5/pWgmpXJ6jIwF3T6l6ws=
Received: from MW4P223CA0017.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::22)
 by MN2PR12MB4437.namprd12.prod.outlook.com (2603:10b6:208:26f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 16:58:30 +0000
Received: from CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::3f) by MW4P223CA0017.outlook.office365.com
 (2603:10b6:303:80::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Tue, 10 Jan 2023 16:58:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT112.mail.protection.outlook.com (10.13.174.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Tue, 10 Jan 2023 16:58:30 +0000
Received: from atma-again.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 10:58:27 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 27/37] drm/amd/display: Add extra mblk for DCC
Date: Tue, 10 Jan 2023 11:55:25 -0500
Message-ID: <20230110165535.3358492-28-Rodrigo.Siqueira@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT112:EE_|MN2PR12MB4437:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ca62f7d-2c83-44db-52cf-08daf32be689
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fix3bXMnFtnMis4TNOsOoVOXOrOC4a9bEyroGF8M+PBYw+jf7tvVME9Y2L5C9BWu/Bipd2C1pEqckNrvbt8wq18VybM1MN2A3mLrDcFSKSq0xoAI8PrPZX/hkuG1FRGUUewF5fNHWJYNCu5EztkfwtYxSdaqxfQjD3Z19ijBdDdQqKCvxpHn5GweslfywTDDGJ6QWHvf5v27P8erQVyDUvC8FDkFgfL5dlJhtbn/2oW36PZCpBIoDbIMbGornjI/azIs0vE4KDObdPcbkMXgq02hmtMfOEVEF53jooOeyfell401I7ZY6ez0pMZr3Rhmi8cqMZHl0A5OP6ZSx35kRVuQoOHjhjwelANW81jnMu9jbH7W6yewO/oSrF97CitrAuBwHv+FJudYo0bfI4tkua0Ude0r21gu+y/7gIMwtgXk8+gKz5r42H1Wdxf+j2FnoX6FEBH5VbZh9zrJkjsmDv0MxSXnqr/24k4GZxpE7AeDZJwsZY8QLyfABTZi2PXJ9mrfaY5StGLvmhkptNgzA4ehSb+eylRzL9EgETRFF2hLenVaCTCqlE2Sk26f4j4GN43SWLTQl4trWDunVadvNTBvb+aDeFdD6EtiSmqmMEgqEXI1UD3oSN6TA+t00FikBp1jxD7ugQiRG7H1hBKSWHPK26VaMdtvC/tsy90wi4ck4PbYJ4ZIfmT7jz726YYVLFqHNZ16h5kvrwc3xrEUHiOOkIVHjxomNqz1NsaMSv4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(82740400003)(356005)(81166007)(8676002)(54906003)(86362001)(6916009)(70206006)(83380400001)(4326008)(70586007)(40460700003)(41300700001)(426003)(5660300002)(2906002)(8936002)(316002)(2616005)(1076003)(82310400005)(40480700001)(336012)(16526019)(186003)(26005)(47076005)(7696005)(36860700001)(478600001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 16:58:30.1530 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca62f7d-2c83-44db-52cf-08daf32be689
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4437
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
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Saaem Rizvi <SyedSaaem.Rizvi@amd.com>,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Saaem Rizvi <SyedSaaem.Rizvi@amd.com>

[Why]
DCC meta was found to be detached from usable pixel data. Due to this
DCC meta and the end of the fetched part of the frame will be on not
be on the same mblk. Furthermore if the meta is not aligned to the mblk
size, then we require an extra mblk in MALL to account for this.

[How]
Always add an additional mblk when DCC is enabled for detachment and
misalignment.

Reviewed-by: Dillon Varone <Dillon.Varone@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Saaem Rizvi <SyedSaaem.Rizvi@amd.com>
---
 .../display/dc/dml/dcn32/display_mode_vba_util_32.c    | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index a089be99b2d0..0932f49cd819 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -1833,15 +1833,15 @@ void dml32_CalculateSurfaceSizeInMall(
 			}
 			if (DCCEnable[k] == true) {
 				SurfaceSizeInMALL[k] = SurfaceSizeInMALL[k] +
-						dml_min(dml_ceil(DCCMetaPitchY[k], 8 * Read256BytesBlockWidthY[k]),
+						(dml_min(dml_ceil(DCCMetaPitchY[k], 8 * Read256BytesBlockWidthY[k]),
 							dml_floor(ViewportXStartY[k] + ViewportWidthY[k] + 8 *
 							Read256BytesBlockWidthY[k] - 1, 8 * Read256BytesBlockWidthY[k])
 							- dml_floor(ViewportXStartY[k], 8 * Read256BytesBlockWidthY[k]))
 							* dml_min(dml_ceil(SurfaceHeightY[k], 8 *
 							Read256BytesBlockHeightY[k]), dml_floor(ViewportYStartY[k] +
 							ViewportHeightY[k] + 8 * Read256BytesBlockHeightY[k] - 1, 8 *
-							Read256BytesBlockHeightY[k]) - dml_floor(ViewportYStartY[k], 8
-							* Read256BytesBlockHeightY[k])) * BytesPerPixelY[k] / 256;
+							Read256BytesBlockHeightY[k]) - dml_floor(ViewportYStartY[k], 8 *
+							Read256BytesBlockHeightY[k])) * BytesPerPixelY[k] / 256) + (64 * 1024);
 				if (Read256BytesBlockWidthC[k] > 0) {
 					SurfaceSizeInMALL[k] = SurfaceSizeInMALL[k] +
 							dml_min(dml_ceil(DCCMetaPitchC[k], 8 *
@@ -1877,12 +1877,12 @@ void dml32_CalculateSurfaceSizeInMall(
 			}
 			if (DCCEnable[k] == true) {
 				SurfaceSizeInMALL[k] = SurfaceSizeInMALL[k] +
-						dml_ceil(dml_min(DCCMetaPitchY[k], ViewportWidthY[k] + 8 *
+						(dml_ceil(dml_min(DCCMetaPitchY[k], ViewportWidthY[k] + 8 *
 								Read256BytesBlockWidthY[k] - 1), 8 *
 								Read256BytesBlockWidthY[k]) *
 						dml_ceil(dml_min(SurfaceHeightY[k], ViewportHeightY[k] + 8 *
 								Read256BytesBlockHeightY[k] - 1), 8 *
-								Read256BytesBlockHeightY[k]) * BytesPerPixelY[k] / 256;
+								Read256BytesBlockHeightY[k]) * BytesPerPixelY[k] / 256) + (64 * 1024);
 
 				if (Read256BytesBlockWidthC[k] > 0) {
 					SurfaceSizeInMALL[k] = SurfaceSizeInMALL[k] +
-- 
2.39.0

