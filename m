Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E35C7EE3A
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 03:40:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4238C10E948;
	Fri, 27 Jun 2025 03:40:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NIKmG6W/";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B802710E954
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 03:40:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qHApKzfEqZTai1GYbLCJc7pHjudA0GeijCeIMHyyoRVE/T5YJt59q8+e9u5KEpfeg/8toYSYtITtdtvW44in6A7AY4E3EBTCF60VODavqn2fRb4TpiwvXcwXcunYQtvnqOvx/cLR+odi+NXmuA0uxiaeMhiht1sTH6UGYrYgIubbp4KmCv+dpy14CsjsnixnTF/VYQmLn94Mv6Nq6oQp+InIrKIfxDAQJyz6CyVh/cDfJJpR1n908CPWdLeTGv+a4clh2qpezH9VyOT1rytTPX236WiZWaC/E3MRucZ2/fNlXJNEgD2kXybZ9Bj3/HW6XCjbjhP9wC2LMDlYiDWX0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkhJvXl/pC+CLMKZq53qCXqXywc7N2TtGMSJte2M6y0=;
 b=K9g3a4gezj+Iy7e5ENeYDLD8iDUboUXoCH2mjISQAYZ+I0qeU8Ec9ZfB3YURio3dOYdsivwaVVoj9hJsouiqvB9t8g3WzlzjwazpNLutMf67UZb/u67ep76BQU+moUsiVal/LtcpFECBBa6fnBBCRHx2JfcoCe8as6b+OjBNJR/inNOzP3J/HowZ1gpXP0S4sA8hqaUeGX8UXS2FuoLLB5eJbMn2JlOoH/PQIiMopGOUNOL9hgYm/5tqVFl49yUstUWyY93AW9NpagGJHAo/dD1PRHlaSQLc7SR9B1w1DESBaBJUkpW30SjslcYUYGED9SVvx3YQGFM9GbHAn808mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkhJvXl/pC+CLMKZq53qCXqXywc7N2TtGMSJte2M6y0=;
 b=NIKmG6W/dXlR3XKsSFzMLA7zAzHBLu8eQv6Ygs6Hms8505zNYsIhxpbZMty+uM4RpaG0srI+cipBV/08PXlYaU4ayJa1PHnzkrZl85ldjm8RNejjyLMkzCwFZt8ifKgrlYSL67yeWo37lKDQ8PzCLYw1AiE0Np0WPCFtSnESoQ8=
Received: from BL1PR13CA0186.namprd13.prod.outlook.com (2603:10b6:208:2be::11)
 by PH8PR12MB7184.namprd12.prod.outlook.com (2603:10b6:510:227::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Fri, 27 Jun
 2025 03:40:32 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::40) by BL1PR13CA0186.outlook.office365.com
 (2603:10b6:208:2be::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.7 via Frontend Transport; Fri,
 27 Jun 2025 03:40:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 03:40:32 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 22:40:30 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 17/33] drm/amdgpu/sdma7: re-emit unprocessed state on ring
 reset
Date: Thu, 26 Jun 2025 23:39:46 -0400
Message-ID: <20250627034002.5590-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250627034002.5590-1-alexander.deucher@amd.com>
References: <20250627034002.5590-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|PH8PR12MB7184:EE_
X-MS-Office365-Filtering-Correlation-Id: f07abb27-c74d-4ec9-b28e-08ddb52c5e67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WvIKjDQW/t7ymdHpDl79HevIhWPeOJLtaQnD+7wj3EVUfL76enHWJa9gefJq?=
 =?us-ascii?Q?tx8mf4Zkw8kdA0dtYWVnF47oflyMXdCeiAWi8e3ajpi6berv1vNNI9Rfg7BU?=
 =?us-ascii?Q?mj8/aIEXMM4H7IcJdyb+GLi044lxs6xUiQsdOMaanowXlPfcHL6qO6K7jIEX?=
 =?us-ascii?Q?n/P+be58wOPCD4gB2bpWHRYHZUewHD7dZYYBqOXykgpd+ISdhnloMnIJcx4s?=
 =?us-ascii?Q?5fT+vslIjGdeo7Tm8LVN6ad5ZBUyBoh+0hhaUbf724vXdPpeDjRDY+5fqR9g?=
 =?us-ascii?Q?Nq5HDHM5JAgSO8HHXpdVu+RveZqSfLAZE2+tOp/84Hu8/Q5ugOSYdmk/21Wp?=
 =?us-ascii?Q?1duMi8itM1PV18SxQWGtNlLwJwtpWTHlhz+PnI1xPsgBy1W8PB1ptAEbR02f?=
 =?us-ascii?Q?H4qXIMG48DlLFjX1d1g1Y5iGUwaQMV1T+C/v8cSoC3f9JpznAMKX5oldbaB6?=
 =?us-ascii?Q?BwDVWOmgHmYOMOOnFw3UEfJxOwbtWLhkL+XPC8YTm5E9Nt1LtFRW8QlRkg5g?=
 =?us-ascii?Q?lgUDqW3a37O4sE7BTbjv0zxjg38lpTsbPoM/SvrnHTXT2t/cYLo5ZBfZKndi?=
 =?us-ascii?Q?mnfyYUb61PsUmY7t9ix9T0VuP9Al4ms5IiESUpk7y8hSur1Z+xBKZl717v1c?=
 =?us-ascii?Q?lYh8k/fJniCcOMDFz3nOpYwBt8ovcj7wFpeLoIf6kxf9ySzgpO237V//fGT1?=
 =?us-ascii?Q?uY0V9r8OdvW+eONLSwu82zvLsDykp6TT1h3xuXUXGSv/iw2+oCfIVx2eBext?=
 =?us-ascii?Q?z7DwsIWZaiLIq1WXB4s5Ed7mYwKoU+XyfIXBnfjoYjYphvR5B+SW/Eu0PUos?=
 =?us-ascii?Q?nO8tJYe7eq7/80uhWelXJhDfl8Xg5ArnrMeBgExUkHHVsoCKxmtKQTI/aznc?=
 =?us-ascii?Q?gu+iGV/BS0nEeRW2L/85lh4Mr5Aq7baPf5A75Pq+GJh3WC1Q7OT+OriYFyuL?=
 =?us-ascii?Q?SphVq8dOERFzH2IlzGYXlLVNyzhD77jXvc8y63/AmuFsOV0TIOdNpewWwh6S?=
 =?us-ascii?Q?HPIeeS5X8IJgzsBVhElCIgSVpyZ+f7RNu2bEXxZbXTFFKwwKDEANbywxAvhw?=
 =?us-ascii?Q?Y4mEeRnDAeZ56pMpFGqgF84GqkENIe5vCWg9nH7m36CSIDrn7LJ3XVaB9HcI?=
 =?us-ascii?Q?5y6/20MB8fKX6QbTSZSbk1bwU4+e8XWnJ4Eowd43Odi5fmdRZEi+D/r2YnVE?=
 =?us-ascii?Q?B+YtPuZb7TLnil754wsF9gBd13cGQnZWZaKPHf+BwbpRoH/ZWY3ypWz/JLVw?=
 =?us-ascii?Q?37UC9JVPd0KeqeRAhMGJMdt4YWLxx8SJ+or6zT7Z/1HEq5AFfINQyk6uk2bY?=
 =?us-ascii?Q?ddcOIzcyePEa70jnU18xxtvb1aA0+yTf6hvW7/TA7jCycsXUgZk38XWI4RCt?=
 =?us-ascii?Q?S2wkaWMaIZK+1LIr92qJKSpC0Rx9TB5G36YmAP1I3XEiPINOK/8UITyWvlES?=
 =?us-ascii?Q?H+5x09IpAXnCQpCrkrd+xr7Ni/GuYokiDKTNC6yiE5dVtWw+NM5XRpuHJFyP?=
 =?us-ascii?Q?LIwSVxDhgy/qsgYmLfXM5OlVUQ5QkkIOVngs?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 03:40:32.3083 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f07abb27-c74d-4ec9-b28e-08ddb52c5e67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7184
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
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 95e54a1180ec6..9ed1e00de1760 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -799,33 +799,27 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
 				 struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
-	int i, r;
+	int r;
 
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		if (ring == &adev->sdma.instance[i].ring)
-			break;
-	}
-
-	if (i == adev->sdma.num_instances) {
+	if (ring->me >= adev->sdma.num_instances) {
 		DRM_ERROR("sdma instance not found\n");
 		return -EINVAL;
 	}
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	r = amdgpu_mes_reset_legacy_queue(adev, ring, vmid, true);
 	if (r)
 		return r;
 
-	r = sdma_v7_0_gfx_resume_instance(adev, i);
+	r = sdma_v7_0_gfx_resume_instance(adev, ring->me);
 	if (r)
 		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 /**
-- 
2.50.0

