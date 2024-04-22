Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE49C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 15:31:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2327112C05;
	Mon, 22 Apr 2024 15:31:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z2+nYATU";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2054.outbound.protection.outlook.com [40.107.95.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16CB5112C05
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 15:31:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0bP4rHK+Ccmym2xfryDFGhit3TO99JXsjpTMxd62O0xEifeGyE2RihNTBJB226DbozG7kSlAHfGvQI8xfVoJesWr71ze6NvZesJ82oAdiF/2F01/6wqWsXIjmQlwMnzUXC83ZC2pJrGnNeB6ef5WjjL5NhAso0CuMpEyNRk64OZE7VXelcHkrFk8AK1Z3cGEdH60/Ovcst4Q2DsPsKcwzYXwXWPbN58FyUXqy2o5GvT1pSApqx6795M2W9BD3cR0oefyB3D28Y/QZGBBE/sPPF/AWLhGGT76BcMnyyZ55Z8HSKB1W1KuciqbqDjkadIizp7gfWAqszCP5qK+jE+oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9oyXjzD1F3M7I4pLfC0ZpMUDqYDzfPsCRkNCwb48pk=;
 b=QTEO/PHPLNmUapXrt8XlDhhpkZAd5f6GwJqN+aUd6W6oN1Auhs8/+f1uhmYMJhpgnnUGjZAcdVox9hAjXSOrhOLifCBwFAJhPKSKmpJrxBgDuB2ShANxhkNBolycyooyZz6s34o/HplH+7Ubzloj2BRbT4pkSUolXS0s/FuEYRpM6BVRJ1aDInqTcDudcZNLb715CUvPSqbtsA6O4tCXUVXBUSgamcq+6PQYn5eoWPuT4/GDujBisYfuwzmEzwKbf7X10xBosC4eEnWaDLT5NV/IfFA3IGTMFkzUuqqPLnLwThodWCP158yW4/E/MtOQw8nCJ9o71e/fl3MqhT90lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9oyXjzD1F3M7I4pLfC0ZpMUDqYDzfPsCRkNCwb48pk=;
 b=Z2+nYATUXg7XIOAEXsNy6/zbABhWmycEM0FL6/c6Qo8IuqMyOX8mBtRriBqk11ZcfH5oC8FpiBfY3An4OVHlJFWXpwoLuys7+IaeH4t6TDMv7MEhPD7AFTb3dsm6hO7OQ05X8DbSbVRYG1I272moBU0Ansg7luIEFdxQuhe8FGc=
Received: from DS7PR06CA0011.namprd06.prod.outlook.com (2603:10b6:8:2a::6) by
 LV8PR12MB9405.namprd12.prod.outlook.com (2603:10b6:408:1fa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 15:31:26 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:8:2a:cafe::a9) by DS7PR06CA0011.outlook.office365.com
 (2603:10b6:8:2a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Mon, 22 Apr 2024 15:31:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 15:31:26 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:31:25 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:31:25 -0500
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Mon, 22 Apr 2024 10:31:19 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Sung Joon Kim
 <sungjoon.kim@amd.com>, Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>
Subject: [PATCH 31/37] drm/amd/display: Fix recout calculation for stereo
 side-by-side
Date: Mon, 22 Apr 2024 11:27:40 -0400
Message-ID: <20240422152817.2765349-32-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
References: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|LV8PR12MB9405:EE_
X-MS-Office365-Filtering-Correlation-Id: c17b0fd1-976d-4859-56e2-08dc62e14614
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RITExDoobBlYaXynRPre0BkRpAXQXkKcQt3gsCHRxRKf8Wj5RrKIhOI7eoLO?=
 =?us-ascii?Q?sT/qSTMhAUUWl9K9a3C224p6FpyfsouWcuV9fZbn7eTRWyZGm+R++n7moajb?=
 =?us-ascii?Q?wMEkY0ltMwv+2mnP/bVCOqxOv6Qay+CXADM2T9HkvazApuQYAwVEWKLSFt4I?=
 =?us-ascii?Q?GYXCztPcNIPEA/n9bvzFPy4xMrEKGjDZDQ/5N+/W2988kGNYoDQ2mAI5TFut?=
 =?us-ascii?Q?ivFAV+DwyHRR1wPXb7EqqWr5Y0J+Tnlv3GdJAH2ZkzGi3VJ3Rt5ouciuZUFJ?=
 =?us-ascii?Q?+PVXwZpdCmjVWfqb00vAJu2FsMCMcTB9SsHgjazFYVuKkxiGOwZDcdSc+ZhG?=
 =?us-ascii?Q?3D9EElfD0p66kZOFS9Y99SLQLquhfgpk8eZuL5AN89nORW9z28rrHB0lTTt/?=
 =?us-ascii?Q?W3qP8laEEn6i5g9uiSwLdlN4Ap3aZgqzAhK5cnyOqLr4I2OQd3M/eAjPm0dG?=
 =?us-ascii?Q?oyR6taFp6NqewvMG2B+EhVK3cnzOyc6+Jb2HUJOT6rZYbZQb+BgpYnSOsAVu?=
 =?us-ascii?Q?egetcpJgeJcLc6lK1+FtmToql4wnDDe207KOKOAPwZfAAVtiHN/HWJjQTWks?=
 =?us-ascii?Q?hpj3n0Q5cUCePvKA+tqiSfaDZ/lzLzJsPDrj7PcSglmBVKin6xuKlRxXH1ix?=
 =?us-ascii?Q?YPatA9px7XN06w4FXoN5tttrjB1HMV8kpV70C+Ig20OcKMHU8FxG7wHSjLHE?=
 =?us-ascii?Q?FY0m1Q3yjCe9va5go+zoSkcgkQDy25fu6a045T4T1St4AnO8USOmx5Pq3mUF?=
 =?us-ascii?Q?b7GqmB5Xwp8Q0buaMo+BPiZ4jDSXvDzOn8UIDU3y+DMs6eryuUu//h5QDRni?=
 =?us-ascii?Q?35XgMxGvPLz8O582n++xbt+Ux80WRYOurxFlIfambv6wiuQB5fCMRJFHAPgW?=
 =?us-ascii?Q?XEtBAWpaVEpqhl0ahEiB2yghIrosix8rjyNW24HNK6MsZhZwaLJ81OEBeNol?=
 =?us-ascii?Q?5qMvvtyf5pNT2lD0DaaHPnezlzTx+c4+2lUhh4o4ltVL481tFEpRrID7f8+Q?=
 =?us-ascii?Q?H8ETdkEgJPpiBtMDra71s4w2aCGD2BHUvz40ICuO1ejfi+81N7zdEvefzv5i?=
 =?us-ascii?Q?RgfMh3x6D1x1KMK4NvZWQHbrgiAjWyjRENfMOqYNRZPVPVQlQUfO7pivzCRS?=
 =?us-ascii?Q?IF5jygNLY7JRI+uDUw0cLYz+x4o6K/7t08j3ZjtG0HORXnXRBBasFTIH+3I1?=
 =?us-ascii?Q?lRwEELH5gIdcP0toPFIYhwHbam5+Nn1Qhb1WvM7IyFvLl29ZFOMaqvCOMOAi?=
 =?us-ascii?Q?/TqLr9VGojuNvDn3wK7u/BCpIEPeQb3nSzxbzs+U8MNY3SqTyuUoAoYlIzIy?=
 =?us-ascii?Q?DW5BIHb1p2WGuDxGOn07WHumsa/h3msEuHMeWWis8WyqUsTs9CCtbkgI8RKV?=
 =?us-ascii?Q?jKpLuOw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:31:26.2044 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c17b0fd1-976d-4859-56e2-08dc62e14614
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9405
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

From: Sung Joon Kim <sungjoon.kim@amd.com>

[why & how]
The recout x offset was incorrect which led to
wrong viewport calculation. For stereo
side-by-side case, the slice index should be
0 for both split pipes.

Reviewed-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Sung Joon Kim <sungjoon.kim@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 77c9c3ee755d..8ebeb012abd9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -950,6 +950,9 @@ static struct rect calculate_mpc_slice_in_timing_active(
 			stream->view_format != VIEW_3D_FORMAT_SIDE_BY_SIDE ||
 			mpc_rec.width % 2 == 0);
 
+	if (stream->view_format == VIEW_3D_FORMAT_SIDE_BY_SIDE)
+		mpc_rec.x -= (mpc_rec.width * mpc_slice_idx);
+
 	/* extra pixels in the division remainder need to go to pipes after
 	 * the extra pixel index minus one(epimo) defined here as:
 	 */
-- 
2.44.0

