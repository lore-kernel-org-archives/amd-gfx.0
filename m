Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F787C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 01:35:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5F4E10F544;
	Wed, 24 Apr 2024 01:35:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0r60MgDq";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8AB510F544
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 01:35:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJbu1no2Vrbvxs/F/Ipi5oGD5YIr8+hECuwpHLBgYsBFbI28RWY3VVFZk9lSqSpqoeEOOMwIhWXh9i70Bbn2uVyR1Z35ZJD1I1wyGRsx6z3TMLss7uceR6YFd44eQd7WQvOAb7xyjbLOLibhkY8PH/sLEb+D5XhX1R9oqF+LfN7FdglcYSArv5WiT9RBceakIdGzkAl3fb7l7e7j6JD9WIzQNuQI9ejG8g+hfTE/h+TnOI/YRkkbeIJ1vwikawgmq+vwLEWXB+8712Hi1wGCEEk0prDg5DEaad759jnDhiUBEmpevzfDOR1nc1CIeuvlKjkLbblgGb4Pfc/SVHYaKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vU2pkjzmX8GBO+DxAbkfTIyIxRoOgXrFJIBWTxd07MQ=;
 b=fRBPCcOwMRAyR880BlSeUutQ4UAgUr2SDAMCzSVpUY/E8A1ZDfMeO4Mgc3DmyhvOlDjKhPo184zqeYKvUoAAcsVU205C9J6osmYiGR9Lw5jolSL1DMTYLBWxBP+2BkD7vdzCrw8G2BKfCHKpY4KZmkb7oDuhJP++RNhHix3Ij/tK+JFNVbdQERpS7JYgik2k8RUfzN/LzPuAk+Pa8K74jkoyVdnc4LMK0xrOLg7sjENsQh8d9uxrfqwADsadfx6tpCXBnrxfm6Ay9sgo43BNY0jnz73ImUXfszt2NtPR9lowS0HVPFXjXCqCQhNN8SqczzIArT2w4ZfKTVEkzzDduQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vU2pkjzmX8GBO+DxAbkfTIyIxRoOgXrFJIBWTxd07MQ=;
 b=0r60MgDqUogTDolB4KI/bfXBXWtc0oNFKV94uQY/SesbTXDlhSiff0sGWs9UZ3JoCOrk5ZxSChi75bFxHZ8BeibB1aL5eDklmrascOBL+Na68lvch3JYto7dzj/BMDP3mIdtZFe9KFjt4GGmt+hGqlkOFCSMMVb4QbURHwo2iM4=
Received: from CH2PR18CA0001.namprd18.prod.outlook.com (2603:10b6:610:4f::11)
 by PH7PR12MB6954.namprd12.prod.outlook.com (2603:10b6:510:1b7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 01:35:03 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::71) by CH2PR18CA0001.outlook.office365.com
 (2603:10b6:610:4f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 01:35:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 01:35:02 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 20:34:55 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Alvin Lee <alvin.lee2@amd.com>, Roman Li
 <roman.li@amd.com>, Hersen Wu <hersenxs.wu@amd.com>, Alex Hung
 <alex.hung@amd.com>, Harry Wentland <harry.wentland@amd.com>, Dan Carpenter
 <dan.carpenter@linaro.org>
Subject: [PATCH v2] drm/amd/display: Remove redundant NULL check in
 dcn10_set_input_transfer_func
Date: Wed, 24 Apr 2024 07:04:31 +0530
Message-ID: <20240424013431.2125336-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|PH7PR12MB6954:EE_
X-MS-Office365-Filtering-Correlation-Id: 82fe04f6-8d59-48fd-a95a-08dc63fec311
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jcnjHJyE/ijsWCLkzF49doAtXTCGsKXGnPVsuOo0Aifog3QjJgoKWQtvQqWS?=
 =?us-ascii?Q?R20Xw3arefylPAK5XXmXHebIplgojWW1CwWU4v/1eeYknxyam6TvKYc6mjTr?=
 =?us-ascii?Q?sTNkja+P6sXWaVNym7jkxzMbdWmZ64DAZt37O1cbmyeP116YOt+iJjchXZl+?=
 =?us-ascii?Q?XOYlFTcPAxce57C7tvEMtiKDyiJPiy9fRbhS8QN4CKV87gCOHMMI4K42dS+8?=
 =?us-ascii?Q?K1qHEqj0Q3OWalyF7QMxsd6/ibPCw6ieInpstO2CfqItDS+TGpKVFXFguXlI?=
 =?us-ascii?Q?RGhgV1HttA7FlJ2w1aqxWoOv1e6XlMn/9UecWGfUZgei7MUAMBM1Ham4AQea?=
 =?us-ascii?Q?SZeX6Muti2jvaQoeFfYvuonshViKn1pprmsABbv3hp/WrTaKu3S6Rko3LH8G?=
 =?us-ascii?Q?nG0H5SlutfSYMjSZ6B4SRvhUTnDEh6oYNksBd2EdjrRSOf2qxyplIUoVgbZG?=
 =?us-ascii?Q?drjNeH5v+LqD3Tl39Ir0CIVrferyKujFwRsOqnObHEeGgt6RsZ1/ntxmwiHw?=
 =?us-ascii?Q?5XZbyfVJdqQPtoqOVUlpO4sprJkoT3Fm1LJCVZwnmg6rMrISarxEWPK8AI2i?=
 =?us-ascii?Q?kb1bCIRefxt7Zswm2QYeM1wVFdgP6nhC4sPueenBbUHEbEiIIaRStCquQ9jA?=
 =?us-ascii?Q?+H7RtPzsqLPT0we4+V8bhzR1LHa0R7XT9EDPsDjF/m6yAO4aZ5WbqAs5AFbL?=
 =?us-ascii?Q?dLTE16qVixbaVoDHgOMblRjkhoO/FWl0yW59R1W6Vhho3tZ2uas3JOARZC3v?=
 =?us-ascii?Q?vRgl7kcmlxcNTWbhvfbQCs5otvrGi9VC80bfZozDyGrtMF31BT1F7EQpCMqE?=
 =?us-ascii?Q?kr7wAnx/U69gnBVFgNIwPjCY9LaQh4ScjmjqD4yXq8lSEXKSxwbkBL3Y+4AH?=
 =?us-ascii?Q?Se75SX2RIXEmS+FoOgilw/LxzSNbrWQQJ7FKAxkznZKt1TDibcle8ZoxxNql?=
 =?us-ascii?Q?SzAKFbjVVD/641xqwdcKEydkb4GmIseWBFjn8zH8aI0/UlHXzAkyJH45PtFu?=
 =?us-ascii?Q?SQMhEuRoqmVCFmwzYh+n3xE/Pi8XEQaFK4Zk7uzoLtMelr8Jkn1SvbnOhbux?=
 =?us-ascii?Q?JUKwAikWmQ1FnaOJhfkcWpXUCjxDyoPmkcJf078LzFdM2M8AQFl3MCcE9oNd?=
 =?us-ascii?Q?rm3rMa1unNh424wh3Osn9x3XQa3OsDnOrqkcaQ0eUJLugViF3TK+3LsKx2Yp?=
 =?us-ascii?Q?MTT1wu17/F9JLg/cxe0+bntZXsFoZb3+JDzyEmla/JGs32/9sWZcYbwiH0ld?=
 =?us-ascii?Q?MGOzoIR98MSVK8Mvt+SoKCwfSkg1O12Sro7mepuCkQblezLtOk7iQJgc8YP+?=
 =?us-ascii?Q?OcFd91/d8CqlanZNLSx/p7AswJf/8hOqgw/yFdhNIB7qmKGGqmhG8ztNSS/W?=
 =?us-ascii?Q?CAtIangHn2pGbd8DVggBiyjI7E7c?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 01:35:02.4700 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82fe04f6-8d59-48fd-a95a-08dc63fec311
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6954
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

This commit removes an unnecessary NULL check in the
`dcn10_set_input_transfer_func` function in the `dcn10_hwseq.c` file.
The variable `tf` is assigned the address of
`plane_state->in_transfer_func` unconditionally, so it can never be
`NULL`. Therefore, the check `if (tf == NULL)` is unnecessary and has
been removed.

Fixes the below smatch warning:
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn10/dcn10_hwseq.c:1839 dcn10_set_input_transfer_func() warn: address of 'plane_state->in_transfer_func' is non-NULL

Fixes: 285a7054bf81 ("drm/amd/display: Remove plane and stream pointers from dc scratch")
Cc: Wenjing Liu <wenjing.liu@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Alvin Lee <alvin.lee2@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Hersen Wu <hersenxs.wu@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
v2:
  - s/dcn20/dcn10 in commit title

 drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 32a07ab74c51..f258914a4838 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -1837,9 +1837,7 @@ bool dcn10_set_input_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx,
 			&& dce_use_lut(plane_state->format))
 		dpp_base->funcs->dpp_program_input_lut(dpp_base, &plane_state->gamma_correction);
 
-	if (tf == NULL)
-		dpp_base->funcs->dpp_set_degamma(dpp_base, IPP_DEGAMMA_MODE_BYPASS);
-	else if (tf->type == TF_TYPE_PREDEFINED) {
+	if (tf->type == TF_TYPE_PREDEFINED) {
 		switch (tf->tf) {
 		case TRANSFER_FUNCTION_SRGB:
 			dpp_base->funcs->dpp_set_degamma(dpp_base, IPP_DEGAMMA_MODE_HW_sRGB);
-- 
2.34.1

