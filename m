Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F8BDEF8FF1
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2026 15:13:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACBB710EA46;
	Wed,  4 Mar 2026 15:13:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Tf29p4CF";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010023.outbound.protection.outlook.com [52.101.201.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97DF010EA4D
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2026 15:13:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FnBoCUX8E1KatDlXmEPAoOv653hVuRjtBfbEVseHt1v09njVmsFQTXIZRn5eblr7vGMVNyennoBQaphZWBuzxz6s72kOsVvD6VHmaMCu5yIDvbDCZBDT9TRapKU6uUo63FsFJo/oemi3fNRBhGYkKc2UCMeiIbtQ0ckeFqrb7UMUHTWHo3GCp/QvZ/AYfrha9eVuxn1HSSbS4xDPuP/VWa1baLBIgGHdm1fw4td+WsUrOj2wptvxpzRn+j1/An1hGnkSnQiGraRxZRYhQ3a+/YmbKV44ii71bC8+0GoMfSO731I+rH/6Ixsq272sOcKTPQ/3Uy8qdMNou9MjNQuYKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9mjBrtDnhi40PeDxc9Qre4TLTZZb5bLbOStd1W0Azc=;
 b=b927ldSjnNH+8pt1WTzB9y6Z7ff5B8Qnfjwo5SmR7t6G/YwEvnGAyDWFWsRIhvuRRAYTTjuun3Fqmdz8xxyiZFDQvVG+lkZcSZU4iW6ySKJPUO4toApv675Pc0dPD3yGhby9491R6cx39jmzuSpGjP6FqP11IQWnfNU8cX3/cVt1dfrpPyjSjHQJ/2QpHr7bIhUW2PGCSFEp3Sl2zujNYvCJxPPIHsVJPgAL/5RMs3iUlM+Ja/w5BrH5qj6aEXSVAwi8KA+QrUcr7mW2iiwDFNSbiuoES9z//1mHwRCpkpxSS/laFsFjuQvHmOtoIxqQdtQpPXZ3IuxRqilDv/UgeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9mjBrtDnhi40PeDxc9Qre4TLTZZb5bLbOStd1W0Azc=;
 b=Tf29p4CF0SYMvb0nBXmZn6ovBTOEG3+GSFIXwrpj4yGUpz2SjoHskTcNsKxQOH5jbgVDrVedbxsGjXsA9IpxtDy8qyp7JuZulr1XnWeIKu/ebEDB7BCXWTrgk5kooVO3Fw4QQDqhiFKX4H0xmK8HJNsEX8huarNuysyUJZVur/U=
Received: from BN9PR03CA0409.namprd03.prod.outlook.com (2603:10b6:408:111::24)
 by SA1PR12MB7444.namprd12.prod.outlook.com (2603:10b6:806:2b3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 15:13:10 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:408:111:cafe::bc) by BN9PR03CA0409.outlook.office365.com
 (2603:10b6:408:111::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Wed,
 4 Mar 2026 15:13:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 4 Mar 2026 15:13:09 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Mar
 2026 09:13:09 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Mar
 2026 07:13:09 -0800
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 4 Mar 2026 09:13:09 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: gfx 12.1 cleanups
Date: Wed, 4 Mar 2026 10:13:01 -0500
Message-ID: <20260304151302.62594-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|SA1PR12MB7444:EE_
X-MS-Office365-Filtering-Correlation-Id: 132129ac-0b2c-4f8e-a940-08de7a008beb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: Bfcs7qDibAeaR9YzEEY6LCzRLczhpT8OJh+OAFy5am+hwR3thoELmQXwtZC+aCo4XjA2GR8psxaSU3tHXImWcOADxLLPr0t8QVIORSitFbZSMxnAzou6gBmeapLWU+l7hMdbgrcggIuFdfvL0PZjzZFsEvzOJbUtBnWMLX+QG45w7Jcf44UIIP8o+aezIjeNT3fiSg3O8i03Fl8aqanhxxnIqTbIHbbNyj2G/inVJElyGwnmAZ8ffyySyRb5fxXR5Ls1S4iceZf6dATMD8eUcJw/mHaDutxjQtuOky3sPGEaM7XzT5SZlHgqs+Fj7DMugAkTYyqwU+lQIoOAgH4IOHDsj48DeZdQm94ve5MukBNseEN8dloq0U5I8kCwqugbGbGHlW7qqBNe0CujchRMxZkMlgENAzlItR4na/R/a3ThiUbcXSh8fRWvkVWM8wZJ2SGt2vWMZrS31zi6DHfuRY7TznE6zCZByw9216UBEw6MiqCYLxq+zqvJmaN0GF3+F+44g1JVhjeFY/rgYOj4r2i6fX59LD2krHbrSGsrt5qJlLYCwwZ/Xy3BcXV+y8ZD3wubGdho6YFfLhpJ48+13johnpSxpa762mjn2IipZmEQyUck6giZyYXwZ8kD2yFseXlqbwv9Vz0WHwpuaZtni3WxDDw8MtsVHmmnnaZ8lnXVI0SS6TLpxlJGGIIotXMzk6mBhd6zIGvuK06Gc8xNhl8v9MaEkWqDxP39VjpGNQ0STxSAe1d1lOe5+GM3InUxpgts9HAs3fab/e6Xz3GSPg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: g0Fm87w0U8HX/9sQwqS1vu8H2w5VUzJHNF8uug5zmEXLMsSrgxY7KfL2DpPNY7vl0PKABv4k5ilvOMF75J+a26nJMOLxo6nL54iEuzfc/VBKHAvAI2gYeepH1Vz3xuZvZZ0NJTL1HPDbIT5fWV9rNfr9iPREr3MTeHq7YFEIpGvzIvd4xIILGI4/cmac5KSb+cNhRg8XnBv5GOZ0u56wcLOh3oClkMBgPw8yykDy7TFnItx15VCccGQEyc4RYORH7cDEOL9OFgOiS2gvP8bob5nkMMnS9Q9FbbcyV8yJ5WHA8SBb7gkzvDWnMhX9RABNA7KAzN9a7NLDETxVzrX1dfB7rRvzWXuVLCCZOLh9kp33QOFIE30qc13paZu8m2WKNyH7xW8g9LQ+/lr0gaygnp5SJYVItGBo9oe9N+e46zPlWzeaOqu6Itg8DrhM4qID
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 15:13:09.8860 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 132129ac-0b2c-4f8e-a940-08de7a008beb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7444
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

Remove some remnants from when the code was forked
from gfx 12.0.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 557d15b90ad27..a0ec38f35c449 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -3630,12 +3630,6 @@ static int gfx_v12_1_eop_irq(struct amdgpu_device *adev,
 			return -EINVAL;
 
 		switch (me_id) {
-		case 0:
-			if (pipe_id == 0)
-				amdgpu_fence_process(&adev->gfx.gfx_ring[0]);
-			else
-				amdgpu_fence_process(&adev->gfx.gfx_ring[1]);
-			break;
 		case 1:
 		case 2:
 			for (i = 0; i < adev->gfx.num_compute_rings; i++) {
@@ -3652,6 +3646,8 @@ static int gfx_v12_1_eop_irq(struct amdgpu_device *adev,
 					amdgpu_fence_process(ring);
 			}
 			break;
+		default:
+			break;
 		}
 	}
 
@@ -3720,14 +3716,6 @@ static void gfx_v12_1_handle_priv_fault(struct amdgpu_device *adev,
 		return;
 
 	switch (me_id) {
-	case 0:
-		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
-			ring = &adev->gfx.gfx_ring[i];
-			/* we only enabled 1 gfx queue per pipe for now */
-			if (ring->me == me_id && ring->pipe == pipe_id)
-				drm_sched_fault(&ring->sched);
-		}
-		break;
 	case 1:
 	case 2:
 		for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-- 
2.53.0

