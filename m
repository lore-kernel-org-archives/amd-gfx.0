Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2521CC61DB8
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jun 2025 01:46:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6BE410E9C8;
	Thu,  5 Jun 2025 01:46:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZL47Qvjr";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A77D10E9AE
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jun 2025 01:46:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BfxvCqrT51/CABEDLuOBkLMcv4hklcsNaFHnoK2Nn7tO0W0/Chy6/FVv4ltGH4HkSEf2tB1xmqc8+lHKrA4d4z8QK2ry0PinMdu/1Eoyg34kGGm2f0EPDk/EWAAi7wBgJODJ3gZLtskWC/EUxR7rNX1GIZndD+DtEL/tAak1kGBfDppSPqqDtVGWTeRKpOzbefxCl68feqKrddl9U7VRZhY1Q0BdTbDDXxqGo+opIVwu4LK3g1LWzT8uWPKsu0ZqfyridJp0Pn0/WZXsarp2gKXhxPFNkudQ95e4aZiyr3ePP7g8djCbGsrmqyrYMUNU9UXyDfRuPtJ2R7rNNvdheg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6SKO93GHruJw605bCasSDc+xe3gI4G8n2MhAE3cmWQ=;
 b=KScTucBF8pJ9sXOd0RroxPrzneHM6NdOfObjZlITYJ66Mw2Iu/9UEb5ADnAhQm2z0DTLI+qVF6aI2MmkBFZGzOsgW8qfdT34K/IXHjdaEVsi5+e7eOaS+D3N2xdKxH4meHTeYupyWTlLCKiI1U8yyWj0XQ4nFnvjQI/aWepCFGdPoCdbfpCEtKbpdzUfG9oyS3daTUHg1yMW9vCciJAqbqGlMZMJAYsLbWmJYXDm2ICjary5H+I9unFPj9ULAyDieXwtZvASzmk8qgLYrKJ/I0b11Yc1Xw7OqFQ4wv5mD8/3SF9WVHQybOqcvCHvkoZB8c00JPWQXgxQpdxsxCvy8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6SKO93GHruJw605bCasSDc+xe3gI4G8n2MhAE3cmWQ=;
 b=ZL47QvjrUL9OGxc9P1yWMnnT1qoBzAFihaalRfivV36xf2/0lTWJm6MY1OYk3kl/Mq2yVdW4Mcu/bmbIjbPWn2UDuu0xMqhepHdYId7JKyts9JsFg85q4/QC9WQODjQkbuO0azbMNyORYXcGjPlEu5QkfMDx97Pau8X7eWzii6Y=
Received: from SJ0PR03CA0298.namprd03.prod.outlook.com (2603:10b6:a03:39e::33)
 by IA0PR12MB8896.namprd12.prod.outlook.com (2603:10b6:208:493::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Thu, 5 Jun
 2025 01:46:32 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::50) by SJ0PR03CA0298.outlook.office365.com
 (2603:10b6:a03:39e::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.25 via Frontend Transport; Thu,
 5 Jun 2025 01:46:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Thu, 5 Jun 2025 01:46:31 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 20:46:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 20/31] drm/amdgpu/jpeg2: re-emit unprocessed state on ring
 reset
Date: Wed, 4 Jun 2025 21:45:50 -0400
Message-ID: <20250605014602.5915-21-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605014602.5915-1-alexander.deucher@amd.com>
References: <20250605014602.5915-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|IA0PR12MB8896:EE_
X-MS-Office365-Filtering-Correlation-Id: 5224e2af-2159-4082-30ed-08dda3d2cc11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tGoMLMOqRn2eEzJEAnhL9ylooF6uK1qv4SLBGdENrbOp0QR+drvBk6q0Xz2z?=
 =?us-ascii?Q?i9ak77uxQPmlRHjod/RXhxVyMyTyr5LnsYzxftwV40pbESI6UF46zjk9BTgp?=
 =?us-ascii?Q?MjC4IHMMMvBq4wygZtw2AMweqClMSnse0kbEtIDNXqLmGbRB5h0o4evqPZ0z?=
 =?us-ascii?Q?+sxqy6SiLR3OWbOTUA1TpyhrFZf/cLl/Aa0GvNosqC3MfjvBJz512P0zlvlC?=
 =?us-ascii?Q?Xak7KwztFAa9zQNsDbnYKhGBhD0Nng0vqWpZt+v8e7epwPyCVX2puNd3MURx?=
 =?us-ascii?Q?T75M3ZYzTkrCtbEkIDBlxfCJYAuVg1Ot4Luwgc7g6Ys2whuP+mZBuhFTptSi?=
 =?us-ascii?Q?jknZmvi+M3kcMwB1+bdDSxraYJj5+GXticptFCsRLEtvVaA7dlWA354bphNm?=
 =?us-ascii?Q?OXXWMgu1vzLTFNrbAn1x0h6ZeT05aoN0LgNnPWL6WqlCjjCYsSn1MCC73Ily?=
 =?us-ascii?Q?9s+EPXudcqgVxk7owdTfWJhnfXpc++/GdVbYKDgcAdZzwG/vFtolfdNVUuZf?=
 =?us-ascii?Q?BOXMUmbEp0au+p12Hzl1YEqIimT0zxK4dgAiYvGc+WoY9dJMQaKdYVY5Sol2?=
 =?us-ascii?Q?nRfxgp4KEjx7t+BxS+gmjR3n0Gx0wJfURT4tlIRO5zaUx1rrK95jAUuWKgGL?=
 =?us-ascii?Q?qq79vJHCLn955Qor8QhPS0bxzL7IAMtRAGNux2hVoyYkp/9dnLsFtNZwy2S0?=
 =?us-ascii?Q?W9eB2Kjw4O5eQV71RcRz9sntnAIkjryZRLu1PUSUISrn+Gnf8sD3ng3u2Qm7?=
 =?us-ascii?Q?xH2xqbAEgMferasJ5MohvTASdi/3c00/pGQBCq1RQDZExZchBYJ3T2wmh3My?=
 =?us-ascii?Q?mFBR52+zHhyYLiWHBNtaKBASRaWXPY/QIzAAjvPFV+lxYzT/2K8sQWZv4mha?=
 =?us-ascii?Q?uYA9a2wIlg/IQVhpJ3iKV2ajfoJOCP6QAscWT2aRWINWkogA/U7dnfu0rt8V?=
 =?us-ascii?Q?ZN26xOD1yaz5y/dePLP2OOEJiPTY1mzq92vrdfVBxFDK4Y7rFRxp+SvawOVS?=
 =?us-ascii?Q?g+QcCQ0evfEj0N+OLorYoA7aZYGmRg6cYUo31lwmF4fkUJU3K6JkFRKw3eBu?=
 =?us-ascii?Q?gv0gxXaB4z1KTrcE7xTlZuXTl7e1WhS3D6XvIELh92Dv3GJwyifh0VHJpT01?=
 =?us-ascii?Q?dhJQYg/Fj54WA4G2qBoejnMXGobn5B9RentH9XxZ2j5JBuom7hQX4XwC5RkV?=
 =?us-ascii?Q?79HC0x4TLANbklLoeXwu5eDCayIuBScPE6yJnjqPegfaUuj1lflNx7Bxxc2Q?=
 =?us-ascii?Q?8504pBEWZEDAE0QmWQHPI99z2SN5YfyPMTUgcSSeFIhwS2I6Zpx86eEdf5GP?=
 =?us-ascii?Q?UE1bG96b8VUEQGHULx6NpQk05zX9hh2QJhm7T1N8oytqLixST/CzoNWmjvC7?=
 =?us-ascii?Q?pI0uyiqb/Yb+WI4XPmNCFnZCobkm2epJ8HHGpkomVe3ISXOCV3O0Jz1RkUvb?=
 =?us-ascii?Q?JaUXHFhS7oQ9QhBhT53UcTAq9kBQ7mC79dNJQM4Lk4piBftkMr06G/vWmhmG?=
 =?us-ascii?Q?YgL4MPlIdxKC5Bbm39FoN/ne9POvOKx50ZID?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 01:46:31.7871 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5224e2af-2159-4082-30ed-08dda3d2cc11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8896
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
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 336ca44950dfa..aa3f587e2004d 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -768,8 +768,8 @@ static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	jpeg_v2_0_stop(ring->adev);
 	jpeg_v2_0_start(ring->adev);
-	amdgpu_fence_driver_force_completion(ring);
-	return amdgpu_ring_test_helper(ring);
+
+	return amdgpu_ring_reemit_unprocessed_jobs(ring);
 }
 
 static const struct amd_ip_funcs jpeg_v2_0_ip_funcs = {
-- 
2.49.0

