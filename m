Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E32C7115D
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jun 2025 15:55:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13A5D10E8C4;
	Wed, 18 Jun 2025 15:55:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qo62r1zz";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B70D210E8C3
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jun 2025 15:54:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rqKLCNE8mL975XAIEldpilWgYbNXzqAdQ4gXPptgggAFVt0ip+4WW9qf2V9V7nwFd+4r03LqPXFatZ7nQ35J6bHapgXxOgLk/HlIX8hm78LOAXOf/zDeDPjv4rcHEaF08qUgjSPqqtkzydcw9ZS79SQpTGlx4FoE02uZtlKFwvLQIK5qZZEs32HMZJ9VZkAPQNp8yWRL1jnBpv9TY90WF2rquQmLJYbbjjiDdrd2mWBmbCGOr1EdcAMJYw6nJEKIUm9qVRANzWPVLJLtaKzNME1rjhRDvKb/60om64SQ7jvbTMsheI1Ta3uyqxx/dnBBrSskr+cSrt0Z0HsQRhxf/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1eurJWHb75P9PZZGZUmEqPeczS8uc17s+uFB34N1pQ=;
 b=wFNsWT9w5Cs+J3ismw3ka/DZY+bAy8qpAWcQyulwFEQQDES1F2PVJwJA4AEPrCxrtm4la0Eqpre6JiYJ1xABJqNUvRnk0Xa7XHfZcP0ny2oB+s3NQkV/gYErUOj5RV5EePMf1Jtd5NvygdJkDxuLBmEmhUbduIZFhENZtplwF38hy/X/CZdNJKQrIVAeTDO8uH704VSPabQr+sAzXqGx02wILc9XJuXTNn9gJmtLNxvncALv9J3a35Lp+FXzRMC5SCqf/fLfKb0Tj6TdOeE1haZG8YRN+zC4b7m0BA3NOpYAc+7tFdiTyuaYzrIDTMzp2p0+CMniZ9vU3h0gAoqFlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1eurJWHb75P9PZZGZUmEqPeczS8uc17s+uFB34N1pQ=;
 b=qo62r1zzANf/4B8dNVBowuCrZQgRsmfAV1uYsyCibnUG/vBdL1nO+rjjY1sJMKHafwwSE66BxpSZCFFPnNKXzmrIvPloq7uUvD2VTeS7uGUg05kNXPkT33h80/LUHM8xyQddrZLO1ebdPQ2iPOCELriKmYWpFQD9iFuImRw5u8o=
Received: from BN0PR02CA0020.namprd02.prod.outlook.com (2603:10b6:408:e4::25)
 by CH1PPF4C9628624.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::60d) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Wed, 18 Jun
 2025 15:54:54 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:408:e4:cafe::32) by BN0PR02CA0020.outlook.office365.com
 (2603:10b6:408:e4::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.35 via Frontend Transport; Wed,
 18 Jun 2025 15:54:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.21 via Frontend Transport; Wed, 18 Jun 2025 15:54:54 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Jun
 2025 10:54:52 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 18 Jun 2025 10:54:51 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, weiguali
 <wei-guang.li@amd.com>, Robin Chen <robin.chen@amd.com>
Subject: [PATCH 06/13] drm/amd/display: Remove redundant macro of refresh rate
Date: Wed, 18 Jun 2025 11:33:54 -0400
Message-ID: <20250618153936.6472-7-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618153936.6472-1-Jerry.Zuo@amd.com>
References: <20250618153936.6472-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|CH1PPF4C9628624:EE_
X-MS-Office365-Filtering-Correlation-Id: ab8328af-f481-47c2-39a9-08ddae80779a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UGs6miRHHyEWWio5yEob2fw9cepuug3MfRZ6U874rwOxs9wAA0itpt/qX9Zk?=
 =?us-ascii?Q?1LRfMtFuYquoxBBnR5YmWwWBPrlL88+BkiVnqOiLDoD2HgZGKzE5cxoXq2Ay?=
 =?us-ascii?Q?pUCJkpM9TtUj3uS5x5x2rEvd2OVeqzgPVJ6tqgyUoDb/SBhvHGdTDkW9id5j?=
 =?us-ascii?Q?4YkaaXBe339LC+QWvJgtObW0O+rDGHHnI9b3mkrbbIuujEe4hoatFpChggO/?=
 =?us-ascii?Q?4QNVD+v6GFadxAzzX+DNEJSNMIXJtbRo+xTK8S3zgIFSinKXP+qtFX68NdSj?=
 =?us-ascii?Q?AkNBmnhgJRKCG0yMyGVOFAc7IcQcUL6/8B8XKn41jbrFN/R1E5M26YFRL8/2?=
 =?us-ascii?Q?t0F3hxjlSI6NNFi/6ZFo0P3G7M2RxSVNwbzYQnFuRI093Yn4A/hcDifCIQOI?=
 =?us-ascii?Q?Ai/4J3ygQkpneTWs7hPHi0KL7MX0hw9bIKO1yLrfosrAnvRpc/t+dmeNO/g9?=
 =?us-ascii?Q?u//Q0RoFvUzgQd6XqF9HWqG/ia31aTQv4Cte0sbAz4RBNnrI1bse+vj/IpC6?=
 =?us-ascii?Q?PJ3hfJoBULY5wDkpsu0c4QTLkfx/N13EwgDMpj9RkEbulgFXk17KBbfBCjSg?=
 =?us-ascii?Q?ysgkiXhJplqKhii+P5FeGLELY0ySrzqAgrD2AXXQQmY+Jg4Zihi0ptTV3qJa?=
 =?us-ascii?Q?3Me3fvMfdlk1Vpqs8/MwBrVtT2cZwN/AqT1kipDIL2zQF0k/xC0pcXKOoDdW?=
 =?us-ascii?Q?9EcSCy91wEFkmQP8EDSz2QHK+Q+lpQcTb7wTMjdHlMrClAty1y7sXiaRsqIZ?=
 =?us-ascii?Q?g8+cfakjmJ5+SVU74TTB5dW71F5UC/LP4cTxeVrdFElwC4tDHe1+aOIskW0l?=
 =?us-ascii?Q?HIuO0iY6VqDEnu0DVLnYGHDKQ1r9Ox5QjlOk4thDPw9Sft149pwX3J3YTFz8?=
 =?us-ascii?Q?/EdKcbWcihdRFfo3rtQhHJTZoZtGW/HMTELk5u+/ZhKn4xef0c/dXd7nvV7k?=
 =?us-ascii?Q?R3m4LbMhX7F0J/PKrpWQ0vprjgylZQ6/9DpyIAJ/S0VMoynS48DOK5CVFb1X?=
 =?us-ascii?Q?k3VoG83lp0qGwb8JWimzkJTgtzlmcHFlkDNRb8mzebTjYrGAc1ssltRXkXmK?=
 =?us-ascii?Q?HwhrF1n7jCAWGuhBcWGSE4yo6y0wx2IexttB/+8JsMkp88fPYMTxOztxpSRK?=
 =?us-ascii?Q?aW8pN6kQAcFmMfsu2lVOfYL2cNj1T0dcbSG7cd7qMVrPJV9L89RF1nN8YXgB?=
 =?us-ascii?Q?v84J7okRFqQ/iUgdjmKqtW13Qnevbj0LgpaQzsg4LrYOGfmjJ++08nTO0kFx?=
 =?us-ascii?Q?moiANP6Awl5R29lEpSz2kh/TfmWNhBZ6LVFqwyRDbs8ZIhy10O28mLrp7m1s?=
 =?us-ascii?Q?er/NFAseq+DLjTtxaLsVaEkgrcpVSITIioPkB9RRIOEtMaN/Wt8PTTRSxS3I?=
 =?us-ascii?Q?TcNFkYKM15FasLw7dLhvy9WfGps96gTtKYta6uUXHHnVkLgl3VIF5xhajplM?=
 =?us-ascii?Q?lpp8MLBTa543ug/hVOLQg8XaisBQa4+OMGm8tW1leoTFsXo0V+JZIF+7w/1Y?=
 =?us-ascii?Q?7XdsXVTTxSH1Ml2J1iztUH68wb9q8H1852vM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 15:54:54.1687 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab8328af-f481-47c2-39a9-08ddae80779a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF4C9628624
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

From: weiguali <wei-guang.li@amd.com>

[Why&How]
Found that we add redundant macro on refresh rate when calculating vtotal,
so we remove it.

Reviewed-by: Robin Chen <robin.chen@amd.com>
Signed-off-by: Weiguang Li <wei-guang.li@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index 3ba9b62ba70b..6a939f2f2fb9 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -147,7 +147,7 @@ unsigned int mod_freesync_calc_v_total_from_refresh(
 			((unsigned int)(div64_u64((1000000000ULL * 1000000),
 					refresh_in_uhz)));
 
-	if (MICRO_HZ_TO_HZ(refresh_in_uhz) <= stream->timing.min_refresh_in_uhz) {
+	if (refresh_in_uhz <= stream->timing.min_refresh_in_uhz) {
 		/* When the target refresh rate is the minimum panel refresh rate,
 		 * round down the vtotal value to avoid stretching vblank over
 		 * panel's vtotal boundary.
-- 
2.43.0

