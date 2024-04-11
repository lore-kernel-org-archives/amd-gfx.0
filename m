Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37BDBC4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Apr 2024 22:09:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93E1610F3F0;
	Thu, 11 Apr 2024 22:09:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HV91nS4m";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34F4510F401
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Apr 2024 22:09:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i4zmQ9CYMcMoK6ECoftJQl8E9DMiX78umwq6aMa5H/dNUOFmVC9FI9UUfakE+8tnn0Q/Yyv6+lo578SOIzBaVyB1FUBQSl5KizvfjGnoc/1ejRcWoAEBUKYKJ6d6igkqU4xNGJVAZ9g3ujDGQHd2VHx47nAXVdkfYQju+9YL0qCkwtIDpIynanC4GTKV+IaZWqaObCDJ9Wy+UEspk9I6ynWaFU/i6W8AftmU0HcA9ZVDZbuh9RYkDJtT6BxllT+r9SzOeqYJ4ze6FMA82sdIQs3DLHn0hfh6M/tF4GouAlu4z9kMRjfKeOm1q+p1+8jpIIZh/yhLF9F5uaPiq4lkGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mr53MU7GpbnLkYU+pgGbYNqf8X2uFckk0FQR5JgI+jc=;
 b=VXnfJsEm+CEAnXCuLf6xbiZJDI9WmI2VBZc59DlpXLkQC2BhFKulNox2C/fTcvi/9Q7WqA4O4LJtWY6sqgFCHcEEemd/vRK+W/NZfyuDykPsDvOMohx53iPfPzbEn6Vl8Z8AQf1qD3O20mbKe2xNJ6BlEZGLq88JZ81LL6+KeEmP8/t9Zot6M9p7dwYLkyFzfRlV4Rlzx2eUGTYcBGE7ZdM2lXcngH7ss5qUeyHRnjxujz0wnYcuEhG6jvkXYZ7GpJ7bNS0TiHJwSqRuebtUysfLQsPS9WT7m7qmdrXAiNNQ2wX/AC4jM9O5sArHSIibFPzAQ9IOqBmqFA6UrN2tTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mr53MU7GpbnLkYU+pgGbYNqf8X2uFckk0FQR5JgI+jc=;
 b=HV91nS4mG/mBc1OY0CB4Q+tr01QuCERP4h3tSI4j8nc8AzvNi5HvXwC/+XRzpGahGSPUHIN5avuLf11/aBjflkxp05gyP5h9qn3nYijwc35Ylu0bKi+UORk8KrXI1Tzt8qZxql7hb6HMYGTdWRfBNfO4iB9Zuid4Au9rO6Bv9Y8=
Received: from CH0P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::13)
 by SA1PR12MB6821.namprd12.prod.outlook.com (2603:10b6:806:25c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Thu, 11 Apr
 2024 22:08:57 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::59) by CH0P221CA0005.outlook.office365.com
 (2603:10b6:610:11c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.25 via Frontend
 Transport; Thu, 11 Apr 2024 22:08:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 11 Apr 2024 22:08:57 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 11 Apr
 2024 17:08:56 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Melissa Wen
 <mwen@igalia.com>, Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH] Revert "drm/amd/display: Enable cur_rom_en even if cursor
 degamma is not enabled"
Date: Thu, 11 Apr 2024 16:08:22 -0600
Message-ID: <20240411220837.1985770-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|SA1PR12MB6821:EE_
X-MS-Office365-Filtering-Correlation-Id: d5162668-7c21-4cf7-3f26-08dc5a73fbf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gWpZaSKXikrNEJVUHPFu63z/gDtSYWFaZB37C3MBReNdYTilUo4WmADX3IWxsGyQcw7t15vAQhK/jI30S66RjNM7inwDbqMDqTUSLmO+4a7qJtGXTnsg7EBLdvjzdVtUfTIzL3Lf6LIWTfiGvRNc1cxP/F9vamJzKTvSyHWZkNYxwNIIxkfavevvk5E3kN1IQUKfKvUEvrXtzRABmZrnUaLmFoPLVD9JeZ25opaAU7CJDyMM593MjkWMxMLxo2HyakPPPxMqBGOB5K2wFzzh0lZQbv2RcTg9TWyl/p8S47wPcbpEwK2E0wWeYn6R9uSzeaEvJHHYfuAKH7VpTGpd25e4sJ+P7D8WE9jOEFBMWMkDBVRehujUaoSi08BeaQE9Qoj8ITBo/geIHBZd0RSpYbOJtZ59TN2p37TCIU+O5U5uzta7d3EyEe8Pl84uHl4F5rAPK3u8OTkT+UCrGGrCGZ4LDhIDMlbUEZryswgEVyMbCLQPGFq9gSsXXTm33zdICyEYzATUtGQFSdWZ7MX3ttFz8R49Q//9LlBaHWijEmF14dXtAXmadgI8c9xDthVt5Ih09E/tiSZwzOYP5ZwUh8X8EANaiRiIDIYQ8QrtiXcDNeNH7WQn+8P/r6HunmSe304MEPCdSrplhfr3jcT6nrQp9OeFNQn1PIvpPP3XMlhj0xorgrnIZaTSpAZNSTLOOGZYoKYbUVH77s08j108SP2mNBaf3O0vhK+RMU3l9hRKXYK9Gq9O5FJrcICJAufM
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 22:08:57.4166 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5162668-7c21-4cf7-3f26-08dc5a73fbf7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6821
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

This reverts commit 5aba567a2988400d4e01d44493c84bed92820d8d.

The original patch introduces cursor gamma issue to multiple
Linux compositors. For this reason this commit reverts this change.

Cc: Melissa Wen <mwen@igalia.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
index ed1e2f65f5b5..f8c0cee34080 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
@@ -395,7 +395,9 @@ void dpp3_set_cursor_attributes(
 
 	if (color_format == CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA ||
 		color_format == CURSOR_MODE_COLOR_UN_PRE_MULTIPLIED_ALPHA) {
-		cur_rom_en = 1;
+		if (cursor_attributes->attribute_flags.bits.ENABLE_CURSOR_DEGAMMA) {
+			cur_rom_en = 1;
+		}
 	}
 
 	REG_UPDATE_3(CURSOR0_CONTROL,
-- 
2.43.0

