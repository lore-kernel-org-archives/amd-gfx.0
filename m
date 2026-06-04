Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C12E2CD6E77
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2026 14:55:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A79B112853;
	Thu,  4 Jun 2026 14:55:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jDPTgh6e";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012016.outbound.protection.outlook.com
 [40.93.195.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5122112853
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2026 14:55:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pasi1CTnfCeEcIqGc/hSDCefsuBsE3bbnSGzqWVMXa/ieeF+6P2kcdq1OGLIBttNuKtpLkc6ALMmhQ8IWCeoywHuMWdFpMeI5wmU6363iCUExJHIBV+vYgZRIlmFYW4G6tya4ASMlmEg4QVh58xr6exqz2rI+3Fj0yBl8zZ4UKRUukfPIlVw0XVknCJ16ClSlKeQlmGyttRHX2lvRwXPkIm/GdmaLh75HYxfvDdjWAnTarKFQJDTMOYSL92fnDwPW6dX+EAtyBSB9PXtOKJtqjnyNjBJqTgoeg4wp9+mU5WyJv2XPcLNwuU9kzYC35pZl5td/HHPrD5yJMjHQb/oTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M044+T5/lzk3WR0rd34NqqdUdXwmwYUM90/HSgq8njQ=;
 b=AkE5e7T8Ihf81dMxpxn76FP1Cz06+ka7DBXQL+HPZ6hMQimRDwjvpliGq0efVIOl/Z6Zq+Pw0Z+7zBq1atwAzoRJPxcPQHIdWgp7/d+RViSEohbAeHLPzqalQ+ZDL95iI+qHvYafktDuQVBR3kI/uRr+wvgALwTDl0f0qo2bgW/sF/mzPFgnAghKSmPSrxgQ10bF0y++iH4eN4xR228rruZuUPEutdgEsU6m1p3i/2rQyFxJlOM3WI7PCYnFY40wNwA3D/5L0Gba7VrqIF1wULVyZKpzuox+/tXL+vHn77BgRnTDxhFg0PY/uMxemDP/D4uTE9NXx1gTWPFRDvhkMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M044+T5/lzk3WR0rd34NqqdUdXwmwYUM90/HSgq8njQ=;
 b=jDPTgh6eiPqaxnKoAFSuy3YIRuw0h2Nk9TuyXvbXaAy3vj6Nv2EoNQmp0DW7r5QoOojyUfghYvQ+rXab/W8J+U1wlgAk1svlxJwBC/zehhJVQh+oA1AyECs0M3GkASNLN2+ElrRvECoqRh0uDQ6/rjL3J/UnXXccOmKbUsmLt1s=
Received: from BL1PR13CA0366.namprd13.prod.outlook.com (2603:10b6:208:2c0::11)
 by SJ2PR12MB7824.namprd12.prod.outlook.com (2603:10b6:a03:4c4::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 14:55:31 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:2c0:cafe::4f) by BL1PR13CA0366.outlook.office365.com
 (2603:10b6:208:2c0::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Thu, 4
 Jun 2026 14:55:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 14:55:30 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 09:55:11 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 09:55:10 -0500
Received: from aaurabin-tumbleweed.king-squeaker.ts.net (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Thu, 4 Jun 2026 09:55:10 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Antonio Quartulli <antonio@mandelbit.com>
Subject: [PATCH 23/24] drm/amd/display: fix compressed buffer config routine
 waiting time
Date: Thu, 4 Jun 2026 10:52:17 -0400
Message-ID: <20260604145428.809959-24-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604145428.809959-1-aurabindo.pillai@amd.com>
References: <20260604145428.809959-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|SJ2PR12MB7824:EE_
X-MS-Office365-Filtering-Correlation-Id: 77118955-e052-49fa-5649-08dec2495259
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: EwwcBcdnS1EtL+Wrtf0wV2C4yS0QWuMsZRAWJlvpdF/MPBsvBG0LXUdS37dGUsiocTzW4o/T/5WuGPpGRzS1bBleCDLgVmsF4+8mbLwQs7uDmGfBRSse7KHWzg5g8qmlqlEvrNBQWkMMDnFaARLTk3QtLLEsSNkvmL7L7W8opgBoWsZwe7VONzsfJeg023FSFQGSbeLKSYX9GQYGNJsS6UtPmeca46n+TiHmBNr6/y/Z1pdCsMUFPrZjmDQCNtjCdghd2Ux7suhaLse7GtQIv+NzxzUJsjoTo1j7TU4jB5k+kyDEzA+fV/WCdixVaXf5Qz+X6dohjIhS/icV/5lK753tKbYsqh2k0Sb/7q9JguTBiFcPfrcRRtp7WttXxqWHtwKxVKyyXWS8Jo8T2OBI2DJ9607orkuWRezs+TsTX/jV3FrrR8XM7ZqTFyq7Rc99WxeSTGsv6Vjd9i+MHDftJu+kvXFSLedWpUVh5lLQv4PSSPoxiIJLmSr753I1MsGcdChfx5IyGrD+iFvfQ9E9r7FXbcebiTen4GXcfCKgEw+GJBf3gTpr5YYzt4+qbDekCCIT3IPsMp2VIJDfCiLVe3mqUkyxezX8sPfDmK1JkweMxqPXzkjLtv88MO4uiCjJ+XmMZYvifbE+jbxKT2AkpNLlRp++FQ6j9NRj/pf/W+WSmSc3WiY0y/pReipijoN33yKHr9YYyDGZqSfRm+B/jlB+fTqsf1O5xyR7nhA949w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KCkUVxyFIG0SNiXd15Zj65TRt282tBYHDwMRlWOFFhZItwzDFpUDfmbiCottuft7/rtduqb9CUk1XALVh17GGD5ekE94Q+JYXu88PD0zIyIJLtgtYVCjUHyruy42rA0WGACyjUSzLyagzvStNrYIotLGeCKiuqIX9CEm7q2qMOSxL7CySStnFxBEQj4MbFnTJnGNy68yu7zrfZ/BC6biIcGF2tVWzBzjrtpvXgRROzFLdpyUj/nBGn/6o0AHMHw2Ju61isIRuEOjTXbqRnFW6j4ouqe80FeVYNcSkEOeve3uFSFrIoQkUfAAEjlBpdoB7yvxC2bCdQ6bm1mG8GKwhgvA09RbU1bk2AjxdHmC2Z57A4vrE7pkW0zwg0HY8xX2hJ5gK6m4Jv1UNUSBfbZClIHA2vTIggTzkpPbOjTdOS1kMML4gt6YsVO40dSOve8S
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 14:55:30.2816 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77118955-e052-49fa-5649-08dec2495259
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7824
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

From: Antonio Quartulli <antonio@mandelbit.com>

Replace the four open-coded REG_WAIT calls with calls to
dcn31_wait_for_det_apply() so the compressed buffer (compbuf) sizing
path waits long enough for the DET size update to take effect, and the
wait timing stays consistent across the driver.

No functional change beyond the corrected timeout.

Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c    | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c
index 79cb506be5cb..cbcd22789013 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c
@@ -138,10 +138,10 @@ static void dcn31_program_compbuf_size(struct hubbub *hubbub, unsigned int compb
 
 	if (safe_to_increase || compbuf_size_segments <= hubbub2->compbuf_size_segments) {
 		if (compbuf_size_segments > hubbub2->compbuf_size_segments) {
-			REG_WAIT(DCHUBBUB_DET0_CTRL, DET0_SIZE_CURRENT, hubbub2->det0_size, 1, 100);
-			REG_WAIT(DCHUBBUB_DET1_CTRL, DET1_SIZE_CURRENT, hubbub2->det1_size, 1, 100);
-			REG_WAIT(DCHUBBUB_DET2_CTRL, DET2_SIZE_CURRENT, hubbub2->det2_size, 1, 100);
-			REG_WAIT(DCHUBBUB_DET3_CTRL, DET3_SIZE_CURRENT, hubbub2->det3_size, 1, 100);
+			dcn31_wait_for_det_apply(hubbub, 0);
+			dcn31_wait_for_det_apply(hubbub, 1);
+			dcn31_wait_for_det_apply(hubbub, 2);
+			dcn31_wait_for_det_apply(hubbub, 3);
 		}
 		/* Should never be hit, if it is we have an erroneous hw config*/
 		ASSERT(hubbub2->det0_size + hubbub2->det1_size + hubbub2->det2_size
-- 
2.54.0

