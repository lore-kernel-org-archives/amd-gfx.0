Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A78F4E9A047
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Feb 2026 18:05:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BF3610E301;
	Wed, 18 Feb 2026 18:05:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YujtE899";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011067.outbound.protection.outlook.com [52.101.62.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEA1D10E301
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Feb 2026 18:05:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JQgEWotKKh9QAcnMJDKnMf8On55MB2U3H2qPJJQXRQVZ3SLHNkW5EO3WC+XLgY3+ZQZNs0Szo464suX6FFflU8LOQmA7KnTOo59qe8Vyiu2DXltlA/nrl6sQEXrkDN9kzfXCQ3Hb+aTS40yYjhFfWF1RO7sVsI6VJZTrD9S6Abkkw7Lrt3TSDy09svLMqMcjWtcum1S8CiWoUeB+1KudAkKyG0s/w3roKQnrLLhMF9LqZiSHlCdrmsKeIY3K0lNayP25e0quWxpx8VzPDdWqkTd7OYhVhWhIkt+bPUbs7VvedcYK+7ByCY3ooKl2DwskduSdIni4mtw1cGibXlhVTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nzn3KxgLCSWshe6ykC9pyvXEJUT9pCMWhuoe5j14kNA=;
 b=MnanYhLU3HKQLvLMDyOIHNMM83zY12nHpKaGPyG+/KdN5IVmKeyixgsT5tHjbDxM98hf1Vyos6/MJ8ntJtGCXoVi89k4RE8zsgJ/pnLyWLFCL5LdA+DgPj67JJGgsWCVTaAy9a3YTqDDQmFgjNCa0MnPPgobahZihYsBt89cnDlbb5CaYFnbRZpMNSMf3y9dn3BYBhl0zR8zI5dtchsc6kK6onmTcrWCd23zOLHSFsLb3uLsJCJnv9o6k1DGCkgFPp8QDF8lZv2YOY/W/kT/iU8h4ibzCEG4eN4Lynw+LN8m8JzQOAUI8w6tOJjJUAa45aUFZIasTP1F5mmA2xULeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nzn3KxgLCSWshe6ykC9pyvXEJUT9pCMWhuoe5j14kNA=;
 b=YujtE899YqDmquykNODXSer6QcfvUJTZXR3VPDbbyRBLXbR9pmgwwvrDUmlyyPC4O90r9dPIIsxTXvBmLx5myIEjz8wAP2qzxuPJrow6fJ4wEO74Jzd0HKdVqCrgBMp1ushz/bTvKcoqF1MKc/lNd/pLsp0UE8zmeoGuARvW3I4=
Received: from SA9PR11CA0005.namprd11.prod.outlook.com (2603:10b6:806:6e::10)
 by CY3PR12MB9630.namprd12.prod.outlook.com (2603:10b6:930:101::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 18:05:25 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:806:6e:cafe::c2) by SA9PR11CA0005.outlook.office365.com
 (2603:10b6:806:6e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Wed,
 18 Feb 2026 18:05:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 18 Feb 2026 18:05:22 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 18 Feb
 2026 12:05:20 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Feb
 2026 12:05:20 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Feb 2026 12:05:20 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: check if dml21_add_phantom_plane() is
 successful
Date: Wed, 18 Feb 2026 13:05:12 -0500
Message-ID: <20260218180512.1463023-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|CY3PR12MB9630:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a1f3e64-7d73-40c3-e8c6-08de6f184907
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sSYCzZ9sImOCNY1Pd/KKiGucd0DSF0EuymZ5N5j/Hzs9k04GnkbrgO9PJxyV?=
 =?us-ascii?Q?G8mceS4PHWKkkiIblQ1ms0hoGqHIl8FnKqgY+jbsZmAvIR24E3kXTeHUoDQs?=
 =?us-ascii?Q?hNsVGm3XDifWtTIUcrHwjl+eyx71iTqs+0ECINB4wnyuetrVkfBM71YL+H1P?=
 =?us-ascii?Q?BjfRSW5pLRoJd2jZH6Gzmd6A5WxX299sQwTGAQovzw+u2hUFB3hQ3sFjYL5e?=
 =?us-ascii?Q?kje1dH3iG4gkGVf3ukkUtKD+STUxQkPLcACPIboGd1Aj3i3m8qnDOtT2kWNg?=
 =?us-ascii?Q?JS/BTNsDCg5RxLImwy74dOE6rdc6a/BJ37AlofdwIVzFqhOdaNuBH64xJfci?=
 =?us-ascii?Q?G3r3yH8oP/o2l2vMg7V/Ktfeu3cD/m2XYGJ3dNkN7s/fWZOHWsAAQyYDJZcO?=
 =?us-ascii?Q?wvqdlhZtl7h3JmO2ZbR8N8rwxEk7DCW/dUFgdSJr6mkNVSoXk/GJ8i7ChWSk?=
 =?us-ascii?Q?JKaKa+qILQt/WGF9jWBjckzqspaayZNExZXIkKJEd4sIms6YM7kYyljPufvc?=
 =?us-ascii?Q?j02EBwzVw5d91DRFLsq1s99JWcEiFwWVzwU6pvV6mzSPIF5r2cRrnNHk8oJf?=
 =?us-ascii?Q?9I8vmakVv5fs74O3ZsQa6OBTpljObtscfsEP/ebXYkSR8xfgLgPOOy252s+A?=
 =?us-ascii?Q?zUgn6Z3UsCwqRq3gTIgKk7TXKUx/N0jsablNFkO5A8PKmNKX8YZCKeQ9oqDY?=
 =?us-ascii?Q?FnGvrcVQgO6g/jgvbmEiSE/TpPbeRlve26C8VSRPCr+z96ymRt1UJkr6pspp?=
 =?us-ascii?Q?U3jRPXvYMZXWX0i+gGQpUsrS5g/zYtJvIn4f95qmABTS4rVYz+oBrbX9tvgx?=
 =?us-ascii?Q?DQbSQWzg5bxcfPugF62QiyV4hLq0TX/E9ta5TNecE54VJxbNnZMjPRy2kdIU?=
 =?us-ascii?Q?TOz1FE+k02/QpqNQBk7ULGD+Fqu0SXdAk5ZbXF3q8SqizZq4UgFos3Lmo6ug?=
 =?us-ascii?Q?V36aFb+WcquQgQmaJ4pQ3DAKdJ0n4Ze1cmYoAMlPZPEaD+Y/4hr6aRfEMEpy?=
 =?us-ascii?Q?Smw9chInrbu2KWjtfbwdSLmMxmhVDPWw0J4z71PRt8ji5v+AYhobQ4jxN6jT?=
 =?us-ascii?Q?L6eXjyfkx2QycrBaJE/PxeEMcBMA2BNGWX3hBWbPspYkq24XW7W+Gr7WZl3I?=
 =?us-ascii?Q?yg1uXElXZgQMmQ+xxjrlUYMCd4SJG6nM4zMuGxpdipBqAGMIMsfOYK71W18j?=
 =?us-ascii?Q?/+ss4oA7wzpiVsgE93CF3ieMADZtJ0Q9NUeLji20q0AJDSBmSsyKDE3YUq+T?=
 =?us-ascii?Q?tod1E/+Rz1Pu0GheWa2BxAX0hvtZ97AfAugyeWALQ94WZOMANTbNWhx3tic+?=
 =?us-ascii?Q?9zuEwxcVlOb9NVm5SCQ9xHpfjp0stQEseZh7TMM9HqZJyrhqRowlhXJ0A6Np?=
 =?us-ascii?Q?cEcEAxCE31r6sp1hqHPJv3oewM0u7n9YGPH3rbcJ0zF+MbwRXndtgstvI5dK?=
 =?us-ascii?Q?nuxnMwF0TTaxvIjpV+L9sf2zzim7+Xn/pn9IHs7LVzvNOr+Az2oBkTPhvNlr?=
 =?us-ascii?Q?iUROMLmf2BAAtDD5koVG9qMnxN4PkQZYfSk2Nh6J22vwML3z2Os4hrls+rLd?=
 =?us-ascii?Q?NG0eb+AFHUfTTZU8HLYcGbSuFBEXtrw9qT0lMxquH0W9iD2j1lPEBW4wDASO?=
 =?us-ascii?Q?Nw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DRVA7bv/mij3stpIaOAWkYqGnp7pVNnhlXopcSNvfTSq+pSetJunX2IS6OmmIKTrKmF1SsS5CH0tWOBmOk0mFhRZceqbWTu9cxSs8itOwGkP5q4TPErjyIXd580zNm4Y5tfJ3lFTQnmiLA1NRbCBOPm0X1+sJ5OmQwbBugtQiYTvQTD+dIVLW16sSVylkonrhK4GetaR4HXFa3ecge1E8ppZWIs21NUlGfWXey+oi8ULbvBnE4PT9AArG+ptDclWRJi1pVrK6TUbVApAMMqpRQ3cxOkcAPVjsQ1MRmRJMHWH+rtpWMagZCn0aJaEO/Wxk0vWaApOjg2bqDtHhuhedn/1OfY+1H/JS03+RzDWbkNdD0gTtgAfQZz42HWVaERN2p/Q+lwxVxFjtQrb3yjsfKhOrO4UWLUQKZ+ZQN0HrBbKk5HcYduKspaDMJbXlOuH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 18:05:22.7683 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a1f3e64-7d73-40c3-e8c6-08de6f184907
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9630
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

Verify that the phantom plane was allocated to avoid a later
segfault.

Fixes: 70839da63605 ("drm/amd/display: Add new DCN401 sources")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4970
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/display/dc/dml2_0/dml21/dml21_utils.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c
index 732b994b88643..bd841741c1567 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c
@@ -357,14 +357,13 @@ void dml21_handle_phantom_streams_planes(const struct dc *dc, struct dc_state *c
 					main_plane = main_stream_status->plane_states[dc_plane_index];
 
 					/* create phantom planes for subvp enabled plane */
-					dml21_add_phantom_plane(dml_ctx,
-							dc,
-							context,
-							phantom_stream,
-							main_plane,
-							&dml_ctx->v21.mode_programming.programming->plane_programming[dml_plane_index]);
-
-					phantoms_added = true;
+					if (dml21_add_phantom_plane(dml_ctx,
+								    dc,
+								    context,
+								    phantom_stream,
+								    main_plane,
+								    &dml_ctx->v21.mode_programming.programming->plane_programming[dml_plane_index]))
+						phantoms_added = true;
 				}
 			}
 		}
-- 
2.53.0

