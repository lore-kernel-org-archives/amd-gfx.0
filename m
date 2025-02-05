Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D51C02192
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 18:41:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FC1A10E39B;
	Wed,  5 Feb 2025 18:41:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rzPrmJkn";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC73510E3B8
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 18:41:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UpS6LNazT7Teit1nhldmYPPv7Vh8oenrpW8SMx08NHpUv8xCKqpFYKDCmtF2F56WmnXPrgu94wsYweuNhNIkurHh5d46nQ79TjCqXWO0EUf4gVru+ltEHekZz3SNOqUimVRE0y1UrbukaY9psUEXhOCb2mBbooB/iPcsj2EoHvnSiYSE41M5MiPXwBWhZhVdpWhrWRWuWA2rmqIubj4gvxlg1vA4SH2F/kCakeyapkgI9JQSG2VDjoeXPGaxASJAto5H5uVEi/9k4GqRMJnEN0EtDDGVQsFUzf2Xx/D3nVZVWmxiBC9wCPQh89KqpyzHravBs6Rn2azAQ/iuZlOQMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfnJOKE9cZGcBkTByJX4fzgwoJIvVys3fN7TLhWfnKs=;
 b=Q5ri0Z1/m2gsO+7XJGZ1j5soohumxdfZBeJ6B2JA2PC5LoeJlfd8eQl1+wI4gC1q/u+OuQ1yLwSimEtFbLqrAHKxnvJlfcPDYLUaM5Hq/tFSzU1BSTuSOuXujC0tLHrbEplt1aICGyT0upTNms+P0gfkMi1+WCn/iXiQcSi+4GBKix1ID9d2BGzAkLetpcdHkWFMpUDIxe4JMQ94O+3R+l4QWH0K+vYRRUnFPvNzKUrofeJOtUWc+gryEU5X9ZGZgP0yfz7gn/l8WHoNXLEQm0b54x0ek67u/qa1lcZzPRLyQqed6gTKKvMZDMi2819a7+9A3cUhs475+NGwkSb/Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfnJOKE9cZGcBkTByJX4fzgwoJIvVys3fN7TLhWfnKs=;
 b=rzPrmJknmGtXEqBZyBsXTw37nBOY+RzuN0rPE6kePJcnJ7WieyM6MBqF6rYw0BYBbpn6wqAxWOq+gy58XughRVfS1135uwMrREdZch2wJqIf+0W10fCdJI3A6p2KMuFdx/VKXIRcNVGGMinrxKOZMUcwqAhXWt2h3dfNqCwf8sQ=
Received: from PH0PR07CA0062.namprd07.prod.outlook.com (2603:10b6:510:f::7) by
 BL1PR12MB5730.namprd12.prod.outlook.com (2603:10b6:208:385::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.18; Wed, 5 Feb 2025 18:41:00 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:510:f:cafe::1f) by PH0PR07CA0062.outlook.office365.com
 (2603:10b6:510:f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Wed,
 5 Feb 2025 18:40:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 18:40:59 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 12:40:58 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 12:40:58 -0600
Received: from aaurabin-cachy.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 5 Feb 2025 12:40:57 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Samson Tam
 <Samson.Tam@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 05/14] drm/amd/display: use s1_12 filter tables in SPL
Date: Wed, 5 Feb 2025 13:39:20 -0500
Message-ID: <20250205184036.2371098-6-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205184036.2371098-1-aurabindo.pillai@amd.com>
References: <20250205184036.2371098-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|BL1PR12MB5730:EE_
X-MS-Office365-Filtering-Correlation-Id: 700bdde5-0705-4a98-98ce-08dd4614a241
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?abAwxaLfKKuSjC5UqWb+M3UzmotJNfmx+udrzusQl46QE4rKUVmqyqcER9jK?=
 =?us-ascii?Q?p4v2JinKYu6Xk74hBI98dzsu4As46HbkD/y5QOXlt2D7tT8g8g0aHttb+uxD?=
 =?us-ascii?Q?EwSkMhQZ9+wsJSDnhid7Uf87KJFcEUahofQw1CGEnGgm5M7oL/QsiK8Msq8g?=
 =?us-ascii?Q?ikiJpFlqCjYlrcyrGx/ACo7uzjIwsYNtJz/A9m6OZdU3ZcG+fkMQ0l+dx0aI?=
 =?us-ascii?Q?a/FgWTuZvofdRU8HAhZTWZUlo9d2adAOMK45Xswgkm8Eb0i/KHgtvWlXO4Z7?=
 =?us-ascii?Q?9Y1L4Cg2SLgAkgxFnsPt+nztjf8kulKx4kqb7ZNr7b4KndznkFn3WNh/1jbg?=
 =?us-ascii?Q?PvrpdtoQQVZk6I+qwssOfwztlE6dNcdX9kc89HZHObVWuO2LX3Nw2GPXOZ9w?=
 =?us-ascii?Q?QtFiWkP51cL5/S1bjtlhcpw+LGeGi6u7N5mUscDua2vcBNOta1/kcBQeLlyU?=
 =?us-ascii?Q?dglH3XIzM65Klr0A+hBCVqzaCZVlf7HTh1+p+x6IgheK6XhUnNTd/3RjxTDF?=
 =?us-ascii?Q?7xsSd3FmFRgXNWK/PhJ1fEYCjmHwdIuteBGxqrlS+iwXvQLE+L6WBWPN6zfY?=
 =?us-ascii?Q?MNrA7ZHps4LEH/eFJMnmCSMh5vZGK/rO8nwWq+AwYT4G4TaxwZjZwXLhXDwo?=
 =?us-ascii?Q?WyNXIi34orp+7iS+G8rtkGPbTBP5Lu67nBe9pfHt8Rrx+tcYQcd70UINGv6/?=
 =?us-ascii?Q?uZVuszz4O/LeMnAzDkfK4zJONH7ThiiZ3a/gyh3vSxXlpRRKLBAl2HXPu9EK?=
 =?us-ascii?Q?vFNKc665F97ZCfziFpvSkT/cAXkCY+AhlbUXPBB3lBFHLJywXVQnReOtmV3a?=
 =?us-ascii?Q?qw7WOOQ+ysPBJq6ANPGunb6kYEUGeaHk6UO7MX2h1f2tYdUPryU28OaqFUSW?=
 =?us-ascii?Q?p0BdXrlkUHwOzGu1gvqYOc3xhorvDTm6FG6+TWbrXaN29zcKxq2g0iR/hDGh?=
 =?us-ascii?Q?iLosW6h7zTcnUDvYT9bxlWw1QkU+R5uBzemEL+pkW3VXBi7RsS58vhkXXBjQ?=
 =?us-ascii?Q?937EvcU4bHQUI+BP7LD9pYNCNUKUZpy29ytztXMD4H4UP+pjfun2h/O+0E9z?=
 =?us-ascii?Q?S5r9P/cHvsa7j5+mP4GWiRnTgvlAijXFFdY0n04NSBwStP6gAK3HUe1NdvQJ?=
 =?us-ascii?Q?IDKk3p6bGhrbUDM/cJT6pbglsli9bXjk8z+e1ETgP+TzlWfb8tCd/N6KVuFv?=
 =?us-ascii?Q?o1O8RvSC8o6qK07f4HIdhUlZzPVxlKUDG0K4OtqtRVhviqURvXoHz7J4/GxN?=
 =?us-ascii?Q?1WzJQF4+Ie9XGROq2T5qXQbkTEA29BcVif0PMIyrqH2FFoXjnbLWrLvr2K1E?=
 =?us-ascii?Q?x/nvNhd91sy+bcEecwwS131V73D9d8fa4VZgu+TxUTTDD2TUBxCOI5+4NAwr?=
 =?us-ascii?Q?TcIVIO4+6UonmpKsoqD6AJwziU0DQEbrZz9ZpbxCAxHugKA6G4wrSLI1ksl1?=
 =?us-ascii?Q?UnuM3a3i5zmESWOOcnij7x6RLAnXK5/ZzpFVsIw2IpOIo73dkPZCHa+v1u97?=
 =?us-ascii?Q?HQiGPU7smkGbFR8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 18:40:59.1195 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 700bdde5-0705-4a98-98ce-08dd4614a241
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5730
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

[Why & How]
Instead of converting tables from s1_10 to s1_12,
 added s1_12 tables instead in SPL
Remove init calls that do the conversion

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index 6ab194a86cb9..64f2153310df 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -76,9 +76,6 @@
 
 #include "dml2/dml2_wrapper.h"
 
-#include "sspl/dc_spl_scl_easf_filters.h"
-#include "sspl/dc_spl_isharp_filters.h"
-
 #define DC_LOGGER_INIT(logger)
 
 enum dcn401_clk_src_array_id {
@@ -2189,8 +2186,6 @@ static bool dcn401_resource_construct(
 	dc->dml2_options.det_segment_size = DCN4_01_CRB_SEGMENT_SIZE_KB;
 
 	/* SPL */
-	spl_init_easf_filter_coeffs();
-	spl_init_blur_scale_coeffs();
 	dc->caps.scl_caps.sharpener_support = true;
 
 	return true;
-- 
2.48.1

