Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80D4CD6E55
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 14:25:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C2EF10E7EF;
	Mon,  1 Jun 2026 14:25:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E+t6WwT3";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013056.outbound.protection.outlook.com
 [40.93.196.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56AF010E7F7
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 14:25:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ge+U6lovlpp5t9T/YEr2XnqoLERTEmJ6scsSngT45uwcrzpUVFGvry5otyLiQ3qQcPKlbxJwGCUXFoKSC99Bc4LYTqD0/hLBDOkJ4MWO3FFHZYxAfT21Pnd9hW1tRrxmj9a4gui5PYVkBwLfE+l/tBfWx76BoK2bbP6JjuhKglictIWZi2CGhiG8u9AuBXGLlPAqMkj6RaQAGXJ5Ab0R658yTInnqAuMyl/e3j7HD/2p2G3fDwruXQl5AijjqaB8Z/aPcYeN1huOhwOTvw9A5r5H1gnV1shfPi6Z+D9Y/nh6z+2avvSRCoaQ9TAd3MYd9abvoQXilljyhvEuI/AqZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRe6zzbjGTzjx0iO6Bs8L9bBoYsnDO3I5I4i9dX4Bds=;
 b=VmwPmG25UBispd1wTnVxRAfeqxHY4VZHmZsTTegpvmIVcThabaoi6ykFJUIGg5I2aUEpxdYhThi6xA1bNkfdhk7epkA/UXYVc6wsMvGxOy9aLwzfYvDl7p5q/Dxs8wcQAqHNKFRRNevKZu25fF1vIPNXggvT+KDt8CSEW8bLiTw1bG4m5rKrhOlMRG+wTYwykDY1eaW6fKoGUlrVe5FocjjqDVGWQw2dGfz2CjLD1uPgIvoEx/uIcpk1hbPR14WMJV7PXKjAlen5zUzr7XM5dlj5m6PQK/e2hJRtBebiUWmKRXIXORFSQGH7IW5/tZpVUMKuB6IXUXWv0yzMIKwopg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRe6zzbjGTzjx0iO6Bs8L9bBoYsnDO3I5I4i9dX4Bds=;
 b=E+t6WwT3PYHbizRy6Z6XbiBj5bLUVFFg0CYLnlCXkLVZtC6SC6bb3d6fxXmgq97dgaWZAlP98QYpFY3ZAtjgTYW0dnDFwipE8/5vaekEAcgPuf52/WvwvYFS1YF5qvM7eorJoJoRn3fgoJXTRBdbxchWn14r9+EcuD/9q/MR11w=
Received: from SA0PR11CA0075.namprd11.prod.outlook.com (2603:10b6:806:d2::20)
 by BY1PR12MB8445.namprd12.prod.outlook.com (2603:10b6:a03:523::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Mon, 1 Jun 2026
 14:25:13 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:d2:cafe::28) by SA0PR11CA0075.outlook.office365.com
 (2603:10b6:806:d2::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 14:25:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 14:25:12 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Mon, 1 Jun 2026 09:25:01 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, "Roman
 Li" <roman.li@amd.com>, Tom Chung <chiahsuan.chung@amd.com>
Subject: [PATCH] drm/amd/display: Fix kdoc parameter names for DSC padding
 helper
Date: Mon, 1 Jun 2026 19:54:49 +0530
Message-ID: <20260601142449.2648037-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|BY1PR12MB8445:EE_
X-MS-Office365-Filtering-Correlation-Id: 687e2b11-4cdd-4712-8dfa-08debfe997d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|18002099003|56012099006|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: Trh9mvX6Xt7POKJttL08IFovMF0IodGUScB9MtU2NLgvz23k42aU/nAGIcYasIHPMpDf7zv2cfcrA+ObVP5Z69hAApLXeybzq33YLjkQvvtUagCUDVXqLilDn+bySqkxlAdQAtBlsmvOJYyhQ4PSA07zJv+iwOA3srCScdikR3XaVsmyAzmTJK6Q9Ik0mrxM3EEtFSNj5g0Nlotu7stycV2v4sIKK3C9NlxGG0pa4VL10q/F48wEWfsFZxVbKVqq7JX7FEC0JsWAWTdnWKSlcmondrLJPeTi/S7Ja0MAMTni8p/SHCZdVGc56/THd0ZtIkGGJxp1S5poPpVFoMwG7iCiJePYz6GblabtsBN5dn3aU79gPzeZCdEy0oLkAt5kgtm/1Ur/ht/gsw1OpYQiVuqFIIjGwm0cKGQxi4Q0PHAv+5S1by/1CCJPvP6nq6RV9APqh+Ab8kPvZE/EuiOzAOkVWgaKwmmohR6ZFtDyv9he/mHZnirsCKv8oz/Ed4pdcx0YFGlXRenENxFWYyZ4jFltfkawMQRlCHLcfU7A/5rxkmJZivXby46T6vvQawtCZel0QTLuEGtMEgoU4+adaFwVxnvip/CfgfNa2eDizv2WPHJMGrzk+AnZba84dj5L9fwMbs45BRc+0RiFV6oSrcPn//nEkKma1zPF1OZcFhBGNbrjASAB4weSqN1lco089ENqYH/0ALEaw7sR514ssNbMXCrhgYCc5Mg7Dvnbr8g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(56012099006)(11063799006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: f5XTVFtpYKDgOS42CX45PfbAIHo+o/sRgUEHeFF1spkKlQwgfppwg7xyhhmqa7rQaAPdQe0afs3brZXyXyrKdSqHfG6/+5RbQTmhKO2bxETwdXDD/Fy9YkibXBJA3LDOSLmJRj+vahEq67p58nvjrvS3abSwhy757u3MLMsiFfdocCMp4yO3Ne0VPSb1VVhDUglK8HZ9kfmSBjmEA0WRXCsSY/LHRDL5AINw3PFyNNTpCuD5EPZCyq762TxAVLviE4VUFzmj5vyA5PVyy6gZ1KU7JwA4Z9AJb1EIbBHF5jxEPM2kBBEXNNrDqCnYCaIn+fkuE+Q1aQeBcSxi381WJPGU29Tz9FMZo4vTDxS4CWdAzd4YWq8xvrMYEsA9/Aa+ne4iFqnqvfbzr/dB8uXSSsV4IoeeifKT93NRB9dEIFecYpjPMPIxgMmaAMF0jNvL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 14:25:12.8285 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 687e2b11-4cdd-4712-8dfa-08debfe997d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8445
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

Replace incorrect kdoc parameter names with the actual function
parameter names used by
dc_update_modified_pix_clock_for_dsc_with_padding().

Fixes the below with gcc W=1:
../display/dc/core/dc_resource.c:4616 function parameter 'stream' not described in 'dc_update_modified_pix_clock_for_dsc_with_padding'
../display/dc/core/dc_resource.c:4616 function parameter 'timing' not described in 'dc_update_modified_pix_clock_for_dsc_with_padding'
../display/dc/core/dc_resource.c:4616 function parameter 'stream' not described in 'dc_update_modified_pix_clock_for_dsc_with_padding'
../display/dc/core/dc_resource.c:4616 function parameter 'timing' not described in 'dc_update_modified_pix_clock_for_dsc_with_padding'

Fixes: 3bd4001e8d1d ("drm/amd/display: add HDMI 2.1 DSC over FRL support")
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>
Cc: Dan Wheeler <daniel.wheeler@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index e5565a61ef12..5f6cc1b1f788 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -4603,8 +4603,8 @@ enum dc_status dc_validate_with_context(struct dc *dc,
 /**
  * dc_update_modified_pix_clock_for_dsc_with_padding() - update pix_clk for dsc with padding
  *
- * @dc_stream_state: Pointer to the stream structure.
- * @dc_crtc_timing: Pointer to the stream dc_crtc_timing structure.
+ * @stream: Pointer to the stream structure.
+ * @timing: Pointer to the stream dc_crtc_timing structure.
  * @dsc_padding_params: Pointer to the DSC padding parameters structure.
  *
  * This function updated the pix_clk for dsc with padding stored in pipe_ctx
-- 
2.34.1

