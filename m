Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA99E7717D
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Dec 2024 15:44:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 714C010E2A9;
	Mon,  9 Dec 2024 15:44:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NO/lfWv+";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BEDD10E2A9
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Dec 2024 15:44:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A6Ry41S3O+GWxLYxdD23avs/osmijtY6Kh3pEwM/8qllBTDmtXULFpt2Rv/UdhWjzctZk2Fu3WniomXmflnA7uGmvzMdKkJt6IPNtximRfoG3Vquv8GL8W17/kpD/lxHLSM149/qmaBg9E2X5A4oEMb/O4elTzFzToFcise/uLpvN8o8vzvbiDenJOPZcqPyw391QdukuuQEqXOloTpVLn51nz8TYpNSyPyURVaEWQPZ9GNragHiIToaJSxfwC1aVLXVo29EMS8SaLHzRxqyCYxzcn/jl3LvKYyzrJfFD1NVxfuB/2zC4lSZsg/p0yWp93TRDsLkrhKH60OB/LgxaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3EoL6THHKh5P1y1lFdV7OSbobs2nQm4rDbQ/yPxsFI=;
 b=aaCq2yvYwIDmWfDMOxexJQxbQxVhiS6XVuQIC9aE7F73Gblfa/enL9d8e7KN4N0i92bpZv5LEQ0HQygnaZAoI85WCVBDBDyhIQc5FVUv/NOqLcupFQ5LrRTkrMuN4yMiC22J2pfPIjl9HjhGZjEi+m6NDsr6mltZZjDvE7kzMdtyG0Xdtel4tbmJvOUqZCs+faEq+d9jdCuTDMs8GdXw/3QFxjEXgIv2dZA5jw72qKqvwBENGcrObNVOyWq+6gFlZPvVhVB4PramsKSeMij5zSWPEpZBPQmWLsdUkxaw78kZj9yr6LEVptGxf7NcANm6WwZDx18kLWsR+nmXlSya8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3EoL6THHKh5P1y1lFdV7OSbobs2nQm4rDbQ/yPxsFI=;
 b=NO/lfWv+//MIr69FRTQE4Xa/mo37/1eTE+FgS7+yPkQtkR/6dtgOemrY/646XqUCx4wZPUVpf/nN5317ImJ0dQVTkN6KbZeH7WcQD4naIpqAQzd3cAqu431rX1sjBB7RHZocYvrhICmJtVB+bJIArLmuM+ZRw8MJyZ5zHMBeSf0=
Received: from BYAPR08CA0002.namprd08.prod.outlook.com (2603:10b6:a03:100::15)
 by MW6PR12MB8760.namprd12.prod.outlook.com (2603:10b6:303:23a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Mon, 9 Dec
 2024 15:44:25 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:a03:100:cafe::1f) by BYAPR08CA0002.outlook.office365.com
 (2603:10b6:a03:100::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.10 via Frontend Transport; Mon,
 9 Dec 2024 15:44:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Mon, 9 Dec 2024 15:44:24 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 09:44:24 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 09:44:23 -0600
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 9 Dec 2024 09:44:23 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <sunpeng.li@amd.com>, <harry.wentland@amd.com>,
 <alexander.deucher@amd.com>, <aurabindo.pillai@amd.com>
Subject: [PATCH] drm/amdgpu: rename register headers to dcn_2_0_1
Date: Mon, 9 Dec 2024 10:44:23 -0500
Message-ID: <20241209154423.1861675-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|MW6PR12MB8760:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d85f69c-c2e7-4faa-fc9e-08dd18685bb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?F4h0PSZ2osUxm7xA9sUKuWhAEornH3+/PR5Mw9MmJiYkX4nN++SviS1WTLHS?=
 =?us-ascii?Q?yVu5tUWbIic1FInA79xkIBRiMFHsBElnbEe4M6Nzc0fH4NemkUMhWBZhIgfk?=
 =?us-ascii?Q?Qco9MIPO3QdYmLO5MMch3eevUfrbaCnvcT77C8CG73EQdro/joEtvks70Qma?=
 =?us-ascii?Q?0nfK1f2l91B+KbCv7AWklkJYN51TKEHn+W460Dmtpgi0XEYkh3qPRL4fuSfc?=
 =?us-ascii?Q?Av8tlQmahGb04k2vTe0hK3SRhiysGOwgXn7aVE0RdSkXbvl40IFlBAXwvDpK?=
 =?us-ascii?Q?lxwPyDk9OT7nj0pTDhyy/xHiu0HOLPeaRjWQwivg9XqEqpNvfEOHS6B0wW8d?=
 =?us-ascii?Q?1laNz5pGaanSXI8dgYMG2HEQVLeRh+ZT7VqKohDQVZ+ZGYerNBb9GoePrfUj?=
 =?us-ascii?Q?kzq4cEILquEI8LpYGCZy6mct0XoffAN/0OyqU9xqpa7ulEgn/JiE4SJG5VxL?=
 =?us-ascii?Q?qjKC0SUEFXzBhErgHiKkp6Y0i7SrWCWUBz2mS6vWKpyRplbC5JqDtmOKZkjV?=
 =?us-ascii?Q?Cv2y9wbnH5JABlITA3TFAn6ZGnhnmiXRzRrH8iytt8/HWkbHoro1ZvZBxP0q?=
 =?us-ascii?Q?0rof6HyiD/rPDda64saC/t/9X3ssbf+CV5fyPB0BbC9BKNvwXCSFd+5nBUNU?=
 =?us-ascii?Q?96Q4dlsbpLDzl9rkSBRgtOCLCeX6esQ3fz/VlruHZtJQrZnwtjH20uJQ92Uk?=
 =?us-ascii?Q?EJzGg4PMOaIb6TbzzwJYdse7VqnTtdNSFVMKq4ob4S2FZyA8lk5tiRexGDUh?=
 =?us-ascii?Q?TkhnHyVMF8uELRNlY8wZpDI1r+vBzBFyLtzEgCnPk653D6oD1Z9jpNYlqT7U?=
 =?us-ascii?Q?3Y3R1B/bhwt79KKHbF2RYfoKu3QHWCYmpKawVZUTya6Yp00VRYiBBSCfuq4B?=
 =?us-ascii?Q?0kErZtVaT7TuVTqsvDq3SPebjXjwCG5sgPuu8+2rFKMSzYh51I21tHttDjna?=
 =?us-ascii?Q?/+67xceM+TDoI/FWcKKIjGpJamieI6HBwGNYfBV10Rf/EG5Lhi8vfUgtDFaI?=
 =?us-ascii?Q?6oCwpaW42f4ic6Tva61EYN8TBJq9Wob66N8El62jut2BVEpkIZAVJIIoc9ZG?=
 =?us-ascii?Q?19MrpRkEpbXV5timxTDr+OOR2MawOOn2vg575XCU7eLRmN/taC4tbYnsTH+w?=
 =?us-ascii?Q?7xyzHSAVkZ+OxnlENZZBuFx02dJ96eyhJr/IqlkoCNMxE83Nh0EvwkuxEm41?=
 =?us-ascii?Q?5JNBLiw6FQC0OuanWq321RTW6VvN0q/a3ffe6S/dpaugMh9Ry9Ivfcgl1xqB?=
 =?us-ascii?Q?TYyKpsS0FIYWS+doTICxsMyhi5ROxSsVKJ3LTG0v9ntSenzMmduVJo43r/fd?=
 =?us-ascii?Q?cFJtvI1nGCKyPQPO34gxeRAS0rt9Y8+IKE/+Tq6rzkiWe9fq3HNY739KT6qB?=
 =?us-ascii?Q?BGaZB+/V5JY/Ge93j0AX6lRZyggV39nDWAxuLi5cb+uYgU+O3jm4UMeKa3rt?=
 =?us-ascii?Q?MB2F/EVaAyNccOjES/BzgDPIuKlHuV3U?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 15:44:24.9038 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d85f69c-c2e7-4faa-fc9e-08dd18685bb2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8760
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

From: Leo Li <sunpeng.li@amd.com>

They were named with the incorrect dcn version.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c    | 4 ++--
 .../gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c    | 4 ++--
 .../gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c  | 4 ++--
 .../asic_reg/dcn/{dcn_2_0_3_offset.h => dcn_2_0_1_offset.h}   | 4 ++--
 .../asic_reg/dcn/{dcn_2_0_3_sh_mask.h => dcn_2_0_1_sh_mask.h} | 4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)
 rename drivers/gpu/drm/amd/include/asic_reg/dcn/{dcn_2_0_3_offset.h => dcn_2_0_1_offset.h} (99%)
 rename drivers/gpu/drm/amd/include/asic_reg/dcn/{dcn_2_0_3_sh_mask.h => dcn_2_0_1_sh_mask.h} (99%)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
index 7920f6f1aa62..76c612ecfe3c 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
@@ -34,8 +34,8 @@
 #include "dm_services.h"
 
 #include "cyan_skillfish_ip_offset.h"
-#include "dcn/dcn_2_0_3_offset.h"
-#include "dcn/dcn_2_0_3_sh_mask.h"
+#include "dcn/dcn_2_0_1_offset.h"
+#include "dcn/dcn_2_0_1_sh_mask.h"
 #include "clk/clk_11_0_1_offset.h"
 #include "clk/clk_11_0_1_sh_mask.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c b/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c
index 4fb9cd6708d5..1d61d475d36f 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c
@@ -30,8 +30,8 @@
 #include "../dce110/irq_service_dce110.h"
 #include "irq_service_dcn201.h"
 
-#include "dcn/dcn_2_0_3_offset.h"
-#include "dcn/dcn_2_0_3_sh_mask.h"
+#include "dcn/dcn_2_0_1_offset.h"
+#include "dcn/dcn_2_0_1_sh_mask.h"
 
 #include "cyan_skillfish_ip_offset.h"
 #include "soc15_hw_ip.h"
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
index d3d67d366523..9f37f0097feb 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
@@ -59,8 +59,8 @@
 
 #include "cyan_skillfish_ip_offset.h"
 
-#include "dcn/dcn_2_0_3_offset.h"
-#include "dcn/dcn_2_0_3_sh_mask.h"
+#include "dcn/dcn_2_0_1_offset.h"
+#include "dcn/dcn_2_0_1_sh_mask.h"
 #include "dpcs/dpcs_2_0_3_offset.h"
 #include "dpcs/dpcs_2_0_3_sh_mask.h"
 
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_3_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_1_offset.h
similarity index 99%
rename from drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_3_offset.h
rename to drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_1_offset.h
index cae1a7e74323..73c5dd5e83d4 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_3_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_1_offset.h
@@ -19,8 +19,8 @@
  * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#ifndef _dcn_2_0_3_OFFSET_HEADER
-#define _dcn_2_0_3_OFFSET_HEADER
+#ifndef _dcn_2_0_1_OFFSET_HEADER
+#define _dcn_2_0_1_OFFSET_HEADER
 
 
 // addressBlock: dce_dc_dccg_dccg_dispdec
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_3_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_1_sh_mask.h
similarity index 99%
rename from drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_3_sh_mask.h
rename to drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_1_sh_mask.h
index ca1e1eb39256..290d807800a6 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_3_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_1_sh_mask.h
@@ -18,8 +18,8 @@
  * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
  * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  */
-#ifndef _dcn_2_0_3_SH_MASK_HEADER
-#define _dcn_2_0_3_SH_MASK_HEADER
+#ifndef _dcn_2_0_1_SH_MASK_HEADER
+#define _dcn_2_0_1_SH_MASK_HEADER
 
 
 // addressBlock: dce_dc_dccg_dccg_dispdec
-- 
2.47.1

