Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CBCCC71159
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 03:08:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07F4810E495;
	Tue, 17 Jun 2025 03:08:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fJycSEBE";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F20A810E496
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 03:08:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RTLVZoUW8TbPolIcs8uFZV1bBqdbN607QKnRRe8r4xwmHyMride+DSBB3LJcdiW89RNIbAq/U5+LsT74cy3LrqMtiLO6KMtOd9NgSE/RvV9gRUWxMdqUttNrd/dD4Ln4dU0ngPOJIi9s9luxFXPltrYfSFseqW5QDwsGDf1uMBFQlAFLrLIL4yixM+hd2Anek2slCzEA9Yx59BmLWe+wl8nRs5EdPY3aVLNwxZEAY2untyXQNLXlEEV/n6zuLxKH046EAOxAwmsfu0qprw3CN1isXryPdrwUgA/kgIv5FemOXYks3tf0wNerClnhBFOy5RV3T0O8/t47j0LQrqtldw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GhAwyVEUVF5F5ITYCduzyNN0m/H6Bzw9RI7rbGQED5o=;
 b=SF1QzPdLJVfdzhxoeVnMu1/6Wj6ZO0n34JPVH5PZ4JJpfaCZMtMo2i/p7NEEqkMRke92at9lEhQmhldX8R/y/cvGPBC1zARJGDLw8hRoTggVkNEV6bpIgrQTGYUx8r+OENdIClpl+roX1Q9BnPxp5Nn6/wSxx7zSLkOUn9fB+xmhcwel2jn/xf3ZmTvDl/9jklNkyOIr5NC3ywtUTNvtVzZ4ttuhqGMu9DylbdkqX6A+vGL1Q53L2zB5Ke0P+Q1wiYW4MBnmtZBofILGXVVxWupDST8A72Qms1HUETzfICbZQIKmS7EluqJKSh6sHrF8jLBg+lszcj7mdsuSqKuslw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GhAwyVEUVF5F5ITYCduzyNN0m/H6Bzw9RI7rbGQED5o=;
 b=fJycSEBE6Krdt4usHxOLrSj+NvqG3lC5RklmTRSZj0qd9CNikxTbAbKknR4i0I6GCWjtqW5QwuRtwR9+ytpH1p3RHdQCDLxupAvBbhCWHfASYSJMuQmtdudvq3/bzDxXCzPZega9z5hgwR35tFdwrXoH8NjfvODeOvG7oEjtzws=
Received: from MW4PR03CA0030.namprd03.prod.outlook.com (2603:10b6:303:8f::35)
 by PH7PR12MB5925.namprd12.prod.outlook.com (2603:10b6:510:1d8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Tue, 17 Jun
 2025 03:08:48 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:303:8f:cafe::80) by MW4PR03CA0030.outlook.office365.com
 (2603:10b6:303:8f::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.30 via Frontend Transport; Tue,
 17 Jun 2025 03:08:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 03:08:48 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 22:08:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 21/36] drm/amdgpu/jpeg2: re-emit unprocessed state on ring
 reset
Date: Mon, 16 Jun 2025 23:08:00 -0400
Message-ID: <20250617030815.5785-22-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617030815.5785-1-alexander.deucher@amd.com>
References: <20250617030815.5785-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|PH7PR12MB5925:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d74c26f-0b30-4cce-9a11-08ddad4c474c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xItkbEGy+FoHLVuROqgobLWl4GnU/jXCsYm5wC7Ctji5qNw7vxllCTl60BcA?=
 =?us-ascii?Q?PesFzoqR3gnWRToRabvcfOKSUzExhzhGay1wcDvWzZpwsSjhVY9tobs4XrSH?=
 =?us-ascii?Q?M8SZnNp/mk6nZIPzlPkPrwIQ2Wtxmed4lNMjmx4RzqVT7rRIduif8I4O2baO?=
 =?us-ascii?Q?6Qf8KhgivX/UZqZeHw6QIFJN4xChoQWy5l5Lrwuz/sutXFvYAaVWaoC0Mm2J?=
 =?us-ascii?Q?T50qSbD71FC+YgXI4LkNjYB90wzKm16IADE0oI4p9oiXdmQ6V7wL0oxeN9Vz?=
 =?us-ascii?Q?a1RhtIy4rQvHsTa68E+6FvboUQpg7dujdfTAgOtuqJSdt7HYOZZC6jW0/ux0?=
 =?us-ascii?Q?aXJI0md58MNC5NOXcrhz8ZeI+1PCuhhpN/YUC4E/nYKnNn+V3PjKfXNw6RiQ?=
 =?us-ascii?Q?5lqMkOkVFe3g3U9mnBcnZVpMa5pMLR7qeReFQm5KaK28B+jtRzBLlElyXifb?=
 =?us-ascii?Q?wdBYgKpVie7qCXT6HbkYFW4SfjzPGi1h+3XSlT5MYxmEbkXJMmy9QatTBQYu?=
 =?us-ascii?Q?rTIvzEgGXP4tr7iSfk/w3IYQkBnuQtaIJcWPvy8VgNQihqhiEH3e1tSUKcix?=
 =?us-ascii?Q?cLjomau+D173lXTdqBo7+FfqG8vK2ZP7Ikk486OKlD6xqXas/NTN8DsSvmPN?=
 =?us-ascii?Q?hgbq0IwHl86WFGcI7rYHM5ZrRPai0QC9Y5mk0EL2CGEzNQkK3CaBaZmGbAK2?=
 =?us-ascii?Q?EuuUQ+p6clEy95LO+MVpLjoCI1ku7WQ7a+mmrTBy1S11LBqmBpX3BuUEY22U?=
 =?us-ascii?Q?v/NkvY8f+JVUMUMOwj7yAymybCBWf1iNynzsOjiDIEyaFQHpSjkTUQNM1fjJ?=
 =?us-ascii?Q?ugb7Z7+WbHVyiu2FcWTn4KA4JMsuWWYIWJuZ5WSth6Kuu37/xQJgmIuWURSd?=
 =?us-ascii?Q?E1BG1Ot7vSh5cdEn9IGyoYMtlFTGvgD2btrG3Fyx30n1Z1jRUefv+YdLICk5?=
 =?us-ascii?Q?9khmTqsKXDpVHYOybP7sIIqfeVVGmILb29d9nnldKdWtYwfSMvJ30BQjzokv?=
 =?us-ascii?Q?JzDNsADbag78nmKu/ssMS43yurB/ldLBn3YFRVMAJxHMZ+NK3qOObKJ6IF/H?=
 =?us-ascii?Q?ZvmGxlPNQgKD7mgfxGCR87DsYi6sY/AxcX56dZ/GwLablr3FVVsMGk9wGr0r?=
 =?us-ascii?Q?O7+4axnWKgEsx3XnEW+8zPzte0SDBvM6GEkcwJkSPO5IMeUL+llr076QGK1q?=
 =?us-ascii?Q?Fuo3yr8iT4FWKfhXdmgPeOzf30C54dxkc6bs29x2j0CgFvj6dN+PDVNHQOBW?=
 =?us-ascii?Q?YANeBS4FbvcBsF4ywVB94SY4Go6Is2e76yXTiZhD8TPNQhw/jP0v6CNcrenA?=
 =?us-ascii?Q?i12pKFv7+YANfNBGiMmZ8QsQgd1T8tvLa+jkGpMsD+n3ccgxx/HEJRljoV4b?=
 =?us-ascii?Q?TcUXFzC1ZpcL6JRFymWTyXcmOs90SD2jzLcX/K6hqnWBOStfQ4u+B7+91IlI?=
 =?us-ascii?Q?+ub50vchxLNkw51FwCKOdwcgTAoidSjJqByO7hWJgUF7Pj5bYydXzCtZtyj9?=
 =?us-ascii?Q?EAm++bLcThBd9nCs4VAu5IBEM7rzpe0tRa9U?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 03:08:48.0446 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d74c26f-0b30-4cce-9a11-08ddad4c474c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5925
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

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 2b02ecb94eeae..13bdfb1ea2646 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -768,17 +768,10 @@ static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring,
 				unsigned int vmid,
 				struct amdgpu_fence *guilty_fence)
 {
-	int r;
-
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, guilty_fence);
 	jpeg_v2_0_stop(ring->adev);
 	jpeg_v2_0_start(ring->adev);
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, guilty_fence);
 }
 
 static const struct amd_ip_funcs jpeg_v2_0_ip_funcs = {
-- 
2.49.0

