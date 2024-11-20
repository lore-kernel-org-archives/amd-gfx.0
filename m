Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B102D6C2BA
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2024 00:33:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E69510E37D;
	Wed, 20 Nov 2024 00:33:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BiUEO1aN";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEFA110E37D
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2024 00:33:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BB4BJKCR5Le0y9n7+vn+9h1ajdfOYPEGYnJHjODmCpHsSEDrm0tpzt2jtxswYZ4VUNbgTNVPq8WLhoGku4FnVBJGW95I7n6lWqP2Ur+DbBuDj5dEO0DkOORhEDOXf47iku9vH9SGXdNtq1J3RKMyQj7UxsQwyZe9u70/TQLbLqVLjrDGMcfZDtHWc8RaMDpR7gIgVNQMJxw6yfomQdgxn6DZn/9ccBsInmFKYQRaFgtdQ7OkgKBc2MsikrTLR0GwZcGpmX2v7LmZWGjD1gIOaVYRbSfCMADAkBYunXgg2wnJepjtRbej2SLhetM7SHlr4K49VrFDFCqRClR5NuKeug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9w7C/QW7+KQqQx0hGiWNXyByl79fPVB8Nqy4+jM6+8=;
 b=w3WkydZqv3/RlS+yg95GP0wgqq6J8QuqKKS509hTGwTEcuELfep/OkCeXCViyvrve3m5q9/vDmp6AOGyx7EhPZkdaoElcf0Nim7L3367K9fNxS6ErkJwZw9PDysN8Bwf8CgxnELnKf4AlIm3abBJurmzxlrrzFdMOsavcGyRh/ezAsbVDjQgq25QaMpJC0iW+9kyceoE7StDIQH+PcNDMdTiptoRCd70pbU8h1xPiJy7A+s/xuy/BJyt0OHKFBU1Sj7jABcdS+itY/5za1w/zLTDqopx8bhXZkEsLCmd7LVjBArj+4fMJXi8Rs7KbavccMCtHVfZlRBGOeBdkm0rew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9w7C/QW7+KQqQx0hGiWNXyByl79fPVB8Nqy4+jM6+8=;
 b=BiUEO1aN1N94Mg7m4pHO/cIh5FqtGWb60dDWeJbINi3HUZC4YEq19BtZEtFQV+SkJGrBe2oL+KaLoTdTMcpG85skJ48VGeGzf/Hh6aGdK8StnrwsQOzUqR+OkXYeSSL77LaUsg7hDMZhKLlvVvntjl8e7iYNJyQiXlPIjo34uQ0=
Received: from SJ0PR05CA0057.namprd05.prod.outlook.com (2603:10b6:a03:33f::32)
 by CY8PR12MB7657.namprd12.prod.outlook.com (2603:10b6:930:9d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Wed, 20 Nov
 2024 00:33:08 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:33f:cafe::6e) by SJ0PR05CA0057.outlook.office365.com
 (2603:10b6:a03:33f::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Wed, 20 Nov 2024 00:33:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 20 Nov 2024 00:33:08 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 18:33:03 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Samson Tam
 <Samson.Tam@amd.com>, Alvin Lee <alvin.lee2@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 2/9] drm/amd/display: Enable EASF based on luma taps only
Date: Tue, 19 Nov 2024 17:28:30 -0700
Message-ID: <20241120003044.2160289-3-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241120003044.2160289-1-alex.hung@amd.com>
References: <20241120003044.2160289-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|CY8PR12MB7657:EE_
X-MS-Office365-Filtering-Correlation-Id: bb99df50-151c-4f03-7d10-08dd08fae811
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Cpw7imBepGFIc6Jl81EmwzCze3qdmLJ6SWsxbozOkFqfz4P/rEYA9EEmFGX5?=
 =?us-ascii?Q?uAFZDjMww4JpUkqz2tTHVnwjmq4+zlU6ndMxsgsKzYKa3kBkdHW6OK1OfAj1?=
 =?us-ascii?Q?dRryZLntSdIEmvtPtf9rOQQMOrI2Qu9sOG6YgMSbfr+SU2GVarQCzQ4Uf0dU?=
 =?us-ascii?Q?u6L2Cy/ZWYte/ViWKOBfXj1qXUCWF0R0PJQJiLlRVNtz3WbaR9bGZP2081aG?=
 =?us-ascii?Q?pb1wGM6pDGJlrUg//3GS4+3IcByXj/4PIS0m4ohJAByZV4E6lkQoCvL4zaVW?=
 =?us-ascii?Q?eJLnZCFwWwgaC98qNrwqytTjYQ51eqmA0MPfhlLCtU/tr0zywiDSButPtCM6?=
 =?us-ascii?Q?yJ50ARsaknYrT7yDP1XlteP+gnAmsqWfWUBZu8AhqZgYPoohiBdkCOO+v79Q?=
 =?us-ascii?Q?Hbep2QsUHJi2BwMXN9v1dDrN/H3V9FNfFSiAHcxjYvHSyCZqixRomOPH+wpH?=
 =?us-ascii?Q?N6Sz39zVmn6LMyPnBhW2rxYF3zRt/Ci4jp+5OdAAidO+aKjaf6bkItgPu+81?=
 =?us-ascii?Q?Xi7wlS0vEQttmi4Xr2waId40epd4szwMw27T5Ou+MC/H1WxMEFl7sVhDec/b?=
 =?us-ascii?Q?cYPr+KP0kWljmHwLntywTp1meqnOyZIEdIREz5qwLFayDbA65ZDIYP8lPQv3?=
 =?us-ascii?Q?aKN6K6lKVYdrQaq5WvveT7YUFlmckIRLSyy+TcMjvFsY9vqZCr0H3NMbp9w+?=
 =?us-ascii?Q?PdBEOc68IiWRJTvFXTD6qS7ftAm/b2VOcsVIO/aLcWPElHDb99CeuluEaZIT?=
 =?us-ascii?Q?AXHn+4/2JY1zgyY7tUAahRpmBqw8NgAsmcVGEjNo8H9UwodQU7Cf15DyCICX?=
 =?us-ascii?Q?WExl7GZvrsmpMy9K6gd9qZkhACofABiVxnuO/zMJedjv3C+cyMeoEQ9QQxJe?=
 =?us-ascii?Q?iAzCkMqBXIcYK7/IwziNOJiyKnBJWG8M8kVGmxGr+MljTWHjBZnS4pUPSjKU?=
 =?us-ascii?Q?5lyLlYCuY6F9H8hAWVTqayBGXuO83I1na8jvBAuMxBCqmM1KFJElXrPHV3cV?=
 =?us-ascii?Q?AnahEPlgEqpYbhF79GGfQulo1zUG046MIgw1eqM0SAYOpcYB49rxAoEVXkOB?=
 =?us-ascii?Q?g2x2cTWb8JN1VRN8XsaGDG+KdrtybHOLbFMZZShkYUL6ABWjpulGlV+yeqSt?=
 =?us-ascii?Q?pl6Stl9vmVttvVrMbuggOkNIxCmRpoeUwmWSXzaedNlcERCfwfbnM0UP8GEm?=
 =?us-ascii?Q?TsK72YYSBsN2qZPjtIcfWwAhVmiWxWkZ1HE69v2SxAJCJbNO9EkTJyueEb8f?=
 =?us-ascii?Q?Ty7djZOZF2IFkmfYfN93DyzPrZ+gN9qOS1TKS4PgDrP6m9FSg3gJNLmixVTT?=
 =?us-ascii?Q?cAm3Hwrdb2QTFZrr3QB2HOvUXk2s9M3E8Y0RdhOdOdxQrZsS8wMgx2qY9LBD?=
 =?us-ascii?Q?I2iDSQlqpPK1Dp3ftnDUrINxotiNgBI0T3GRcWehzVFjgHd1Sg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 00:33:08.3222 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb99df50-151c-4f03-7d10-08dd08fae811
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7657
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

From: Samson Tam <Samson.Tam@amd.com>

[WHY]
EASF only applies to luma. Previously both luma and chroma taps
were checked to determine whether to enable EASF.

[HOW]
Only check if luma taps are supported before determining whether
to enable EASF or not.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
index 73a65913cb12..27fd20fa2942 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
@@ -1040,12 +1040,10 @@ static bool spl_get_optimal_number_of_taps(
 			spl_scratch->scl_data.taps.h_taps_c = 4;
 
 		if (spl_is_yuv420(spl_in->basic_in.format)) {
-			if ((spl_scratch->scl_data.taps.h_taps <= 4) ||
-				(spl_scratch->scl_data.taps.h_taps_c <= 3)) {
+			if (spl_scratch->scl_data.taps.h_taps <= 4) {
 				*enable_easf_v = false;
 				*enable_easf_h = false;
-			} else if ((spl_scratch->scl_data.taps.v_taps <= 3) ||
-				(spl_scratch->scl_data.taps.v_taps_c <= 3)) {
+			} else if (spl_scratch->scl_data.taps.v_taps <= 3) {
 				*enable_easf_v = false;
 				*enable_easf_h = true;
 			} else {
-- 
2.43.0

