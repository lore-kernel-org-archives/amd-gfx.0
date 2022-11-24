Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E162C43219
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Nov 2022 21:14:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7524610E27C;
	Thu, 24 Nov 2022 21:14:17 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4849510E26E
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Nov 2022 21:14:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKdwJpPXiGkVMWdTTXUL2dB7XrWbOa3YbOd25l9dfT6G7Q2yh5KJDtSILBPaBDborKWZoVRxPNBjqQfZUDyrORw+SckNQ6sruDfjT7OUvdtj7TuYP+nN82OZgs7e7JbdyiHlfRLA6if/LuSWiRm92zziAIgZ9dBYfAkrErQy7n2c8XoIt7X8LhVALQqgiW9z464hF1gu8jNPSWg72eLdhsICJ16W3EgNsSdmhRbYCvbONX4BR4wwRDvJiXPye16XNHLnDnPgwpZaXc/i7d2pk0qehquUu903MCRtNkKn/WCO3IFawg3jD/rwyY6ePc/aE/Z1/J00s8HXqkSicHvDGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FcFf5aids6kcxKp4+cS6Qrf/t4U+X7sMaTwIx0rCgHE=;
 b=J1yO8ZRML8nwbdi+DSnwkk3SlsAypkOI3jisMQYIBgEsmJVVxxYhfndZEhuL89w4GA/20e3CU+BT3g25Iz1F4BO1UIS7ptaJ3P8VZb8S8ggmdszHApT7oKq3GrRrCMDW11UslR0RuXbgPpBiOq5p/DPxF0G5ZXNORHpgECFp6a2uQ7ro5AyfNtGoLBrWSaujpGw4FggxGXmp0feIIVBN1D/6bqivmpng0JeidezhisHJk19h/zx3y9kqCrdWz8ED2yDUpDcnU+PHPSn8s2GTB2r4RIZzn5E+XRAwKqyE4nowLGwjniRI6oCFoHOveQp5BLariPrMvNQZ13QB/Ug1zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FcFf5aids6kcxKp4+cS6Qrf/t4U+X7sMaTwIx0rCgHE=;
 b=MxRPn59nfWcd6LeWaCvrtgu1fxWlHR7+oMHIzKNfnjjYQBmJuBT3Y7wIRmWjwSRWDncdjIXn+vMYy5cGXBXM7+LkAfBPa990iUGvnmv6GUVVllv0tvU8dxUHg1ylHKPJf2YEerU/ctgEa8QrbKZaKnC/nfIRn7mN+xGO0KeC4qE=
Received: from BN1PR10CA0008.namprd10.prod.outlook.com (2603:10b6:408:e0::13)
 by MW3PR12MB4588.namprd12.prod.outlook.com (2603:10b6:303:2e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Thu, 24 Nov
 2022 21:14:06 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::68) by BN1PR10CA0008.outlook.office365.com
 (2603:10b6:408:e0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19 via Frontend
 Transport; Thu, 24 Nov 2022 21:14:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Thu, 24 Nov 2022 21:14:05 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 24 Nov 2022 15:14:04 -0600
From: jdhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/12] drm/amd/display: Use DCC meta pitch for MALL allocation
 requirements
Date: Thu, 24 Nov 2022 16:13:41 -0500
Message-ID: <20221124211348.214136-6-jdhillon@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221124211348.214136-1-jdhillon@amd.com>
References: <20221124211348.214136-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT018:EE_|MW3PR12MB4588:EE_
X-MS-Office365-Filtering-Correlation-Id: 84b92827-b2cc-4165-d347-08dace60d1d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oVZWanYv16sD5NomTiaLQ4247hMsP9hljHe4uzOnylNwJn3IBB5TUd8efm6ZKwmwPGCwBeK5TukxF9oS6wXaRNY4nmmOmRRw/A18UV0z91hVIm0lEmWJvLiZfqB1xHvmwYsKQ6pu7U97cRnFNUt2BN3bzIPM6iU/rPbc9FoX0F9eb+H7fCKfZoXPI/cEY7hOAajxl5ascyxM6OVVc7fN0vhE+elrJNxWiuoGKkyiE8ejRQCThj5nFwvi4Hfx4+U6/CyyMDSE4VBdI/E5GSX/LDXIEjp5kVxFbp4/tf3O/kqw7igsXYBTrSBIit5ZEDbxAljcR8O2mJ6RlTpi5TQT7Ctcf190bd5rU64zUrnFJLCHheiywG9naE+Nd4UQd1RDJi2wN8+aeDjFepkdu5aZP1B5/G0iW3+P32TQ4w8LrKiXWmFdjjqxH2EDt2jX/HkdSxH6uOyNjJRASyjUtaV8izzbs9VHKGsS/D9FpOXeZgKUy9kHyc+zlzdnNfck91C0yMBFJNZa8RUtfSiNRaIK2nhTV+lEyfU0W0rVBH19fXRyw4K9WA3wuuEyTRXm2t1nz6hILwA6E3OiqO8j+pezQxzE/diKWskXl0jmcMEEGdC8vTbIPfuRnPk9c/NU04IRdqutyuKl0IJ14OWnPzriQtLM5LY+oWV/IuqKbirG0r+MHUFV72o3s8jYut+26uGzu4YLHR08i1lXlGfD1nBDJIw3M1HA88zNp7AlprwbNzk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199015)(36840700001)(40470700004)(46966006)(47076005)(83380400001)(426003)(336012)(40460700003)(54906003)(6916009)(6666004)(40480700001)(81166007)(356005)(36756003)(82740400003)(36860700001)(82310400005)(1076003)(2616005)(16526019)(186003)(5660300002)(26005)(478600001)(8676002)(70206006)(316002)(70586007)(2906002)(41300700001)(4326008)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 21:14:05.8249 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b92827-b2cc-4165-d347-08dace60d1d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4588
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
 Jasdeep Dhillon <jdhillon@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <Dillon.Varone@amd.com>

[Description]
Calculations for determining DCC meta size should be pitch*height*bpp/256.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c    |  6 +++---
 .../drm/amd/display/dc/dcn32/dcn32_resource_helpers.c | 11 ++++++++---
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 76548b4b822c..c9b2343947be 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -262,11 +262,11 @@ static uint32_t dcn32_calculate_cab_allocation(struct dc *dc, struct dc_state *c
 		num_mblks = ((mall_alloc_width_blk_aligned + mblk_width - 1) / mblk_width) *
 				((mall_alloc_height_blk_aligned + mblk_height - 1) / mblk_height);
 
-		/* For DCC:
-		 * meta_num_mblk = CEILING(full_mblk_width_ub_l*full_mblk_height_ub_l*Bpe/256/mblk_bytes, 1)
+		/*For DCC:
+		 * meta_num_mblk = CEILING(meta_pitch*full_vp_height*Bpe/256/mblk_bytes, 1)
 		 */
 		if (pipe->plane_state->dcc.enable)
-			num_mblks += (mall_alloc_width_blk_aligned * mall_alloc_width_blk_aligned * bytes_per_pixel +
+			num_mblks += (pipe->plane_state->dcc.meta_pitch * pipe->plane_res.scl_data.viewport.height * bytes_per_pixel +
 					(256 * DCN3_2_MALL_MBLK_SIZE_BYTES) - 1) / (256 * DCN3_2_MALL_MBLK_SIZE_BYTES);
 
 		bytes_in_mall = num_mblks * DCN3_2_MALL_MBLK_SIZE_BYTES;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index fa3778849db1..94fd125daa6b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -121,14 +121,19 @@ uint32_t dcn32_helper_calculate_num_ways_for_subvp(struct dc *dc, struct dc_stat
 			 */
 			num_mblks = ((mall_alloc_width_blk_aligned + mblk_width - 1) / mblk_width) *
 					((mall_alloc_height_blk_aligned + mblk_height - 1) / mblk_height);
+
+			/*For DCC:
+			 * meta_num_mblk = CEILING(meta_pitch*full_vp_height*Bpe/256/mblk_bytes, 1)
+			 */
+			if (pipe->plane_state->dcc.enable)
+				num_mblks += (pipe->plane_state->dcc.meta_pitch * pipe->plane_res.scl_data.viewport.height * bytes_per_pixel +
+								(256 * DCN3_2_MALL_MBLK_SIZE_BYTES) - 1) / (256 * DCN3_2_MALL_MBLK_SIZE_BYTES);
+
 			bytes_in_mall = num_mblks * DCN3_2_MALL_MBLK_SIZE_BYTES;
 			// cache lines used is total bytes / cache_line size. Add +2 for worst case alignment
 			// (MALL is 64-byte aligned)
 			cache_lines_per_plane = bytes_in_mall / dc->caps.cache_line_size + 2;
 
-			/* For DCC divide by 256 */
-			if (pipe->plane_state->dcc.enable)
-				cache_lines_per_plane = cache_lines_per_plane + (cache_lines_per_plane / 256) + 1;
 			cache_lines_used += cache_lines_per_plane;
 		}
 	}
-- 
2.34.1

