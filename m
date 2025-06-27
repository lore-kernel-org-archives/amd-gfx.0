Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9AADC7EE31
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 03:40:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C1BB10E939;
	Fri, 27 Jun 2025 03:40:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IeUhPkPj";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2049.outbound.protection.outlook.com [40.107.212.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 905A010E936
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 03:40:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pQizhhjVB2d7GzLGwC5SVFGk6IQioD0XmzcvwmtIZenDcemAB35WqP+gdz+4Usnai8nAbROjtB0Nfj//FviC8y8FYM6ABIh/V66vRmjMRznblb1TmViNvsp1MRKNAAlAqA3Og8rk9MxrMBUrcP5qZKJjmpU0PuAdUKnChXILnAdMrK3rAxLPtzh+z8R1oyAPZciRZeZAoLQ5tFAYWxyfF6ZcZIaEQ0UcEiU7kM3GlMQC/qbSveVqkOV+LwtfdSY/Nb5ET83S41x9RsYYlBT+g9KSo3mHXq2CsKTQPfIF1b2m4uI3I9SoMoOrf8AdRYOVTQVRILHeeF7j1ZzAKr3Cjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AhxCiKDO9jHYFF5Fp+tCq07AedpJOM0Go4i4smDNz4Y=;
 b=ntReGQb0BLI8b847g04utIXOZcauEpbPmFg48zyE7uZ3hyUwkyA9xzC6ks8U2llueyRyw69+xurwOdfNEYez7RmuMVbzgV5Z6c2xFhTiy4Hh053wKlKhouO2uDqmhXf7u6OTP3eAdIKv18zgJPYh43rJmchrZCaXoqvLjp2RX4y5oYGfQP0ohcQcQ3xjSMKWp7ud21m85uUdI43rJDGNCMvAVEBwfsFVIYx0OZrFjl03G6+gI3OjpOPLx3rXN4CjpwWsht8NaI3TpOmczMMcDtNdSZvw+0x4IuufVWxjR4nOvmAB+iq02yVteZdSKywB32AnM/LfB7eDln9sBsTi/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AhxCiKDO9jHYFF5Fp+tCq07AedpJOM0Go4i4smDNz4Y=;
 b=IeUhPkPjQjKHPTQa0W40eQFBmup1YeawMqtuC61Qj8n/ouewcXYMXqjtxi3kcP5qyAfr3ccAp7Nc+0k3Lw3fMUZptSHmu7deBElBR2nQci5rRQtRVzhq2Dt6YL4v1e+o8rmlVBpZTHrcJE7sYP/9wfeozTsswGec0LEaFGXOHSE=
Received: from BL1PR13CA0184.namprd13.prod.outlook.com (2603:10b6:208:2be::9)
 by IA0PR12MB7602.namprd12.prod.outlook.com (2603:10b6:208:43a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Fri, 27 Jun
 2025 03:40:32 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::d7) by BL1PR13CA0184.outlook.office365.com
 (2603:10b6:208:2be::9) with Microsoft SMTP Server (version=TLS1_3,
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
Subject: [PATCH 16/33] drm/amdgpu/sdma6: re-emit unprocessed state on ring
 reset
Date: Thu, 26 Jun 2025 23:39:45 -0400
Message-ID: <20250627034002.5590-17-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|IA0PR12MB7602:EE_
X-MS-Office365-Filtering-Correlation-Id: dcb86162-1825-4dd2-947b-08ddb52c5e43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UKHPyTU6dLJPRjgPy/dyOPjaQ9PpB1pofEACZlCDOqSQJA10Tuuz8qbt0xCd?=
 =?us-ascii?Q?A9l6lARpIadZRgb9gxwSTRjbeBIb2QL7qSXiOduF2qts8GeApeqA6EWJ5Uli?=
 =?us-ascii?Q?nut3XTyWUSwMCrjuJWCTH2VGcmZlWRYwVKj9pvUfCpPf2aEL5KMiQNTJQtnu?=
 =?us-ascii?Q?LLTETy9AsBIkf698RqE4L3WsrTLXrtCU/POSBfkL6Q7PBxiPn+9AQrkcWJGS?=
 =?us-ascii?Q?wyl88QB6NU9ZSaptrt6zdQ6SBlK0QaMDkOuGR1pb2lF8udok80cCchhwg3MQ?=
 =?us-ascii?Q?g/HXNK844ZCCc/8cp9MDpGansVrRX56A1posTTKliJdrCOotlL6ll/LDVzA1?=
 =?us-ascii?Q?U/Mq2frNmZkE0eGQla+wyyARMkzy9/Eogz1GN+v65XnIdZoc1SK+//8QpGlD?=
 =?us-ascii?Q?nKPHpNCha0iD7qjxn6fMhqKaBzAmo5FNcFc0/YyIRmT7+uhlPFGxoTHYkpPg?=
 =?us-ascii?Q?HHEAWHH9n73WCHmYgfgdU/+0yCEXCFY0a6a82hh1D1WzOuZ6cpMKvcGhpjmz?=
 =?us-ascii?Q?D9dL9e0g6x+OUCy5f6EpU+NEFRrBADl3WNCsBHS6wsSreWvtqKGM8h23+3Qo?=
 =?us-ascii?Q?j7l+6n3NiaWEwjdaT/+mdyPEViK3i+B6Gvl9n4WW2wHUV+h6lvFSUt8xLExV?=
 =?us-ascii?Q?fTWF+bcdNEHf8Oyi34dHwxLihAwLBwc2YiPqpcVyJxD8trF8ok/VMh4QcbvC?=
 =?us-ascii?Q?LVGQ0+0XWYSKf5CGzVctGKUbe/G17BDDkYgEQyEee1t+OoZ/Jq1gZoHIKzNU?=
 =?us-ascii?Q?uiAdd1E6qoYeZS+xbrM7svQZTNRfLL/gvORqcTGrhtuSlJqU+I0I1SFJ06G4?=
 =?us-ascii?Q?snluoeM6GQ4JrmhniPzI8nZw7XzYEtFf2+bu0JB5zv15mi/M53MhHZtiuwdH?=
 =?us-ascii?Q?T67O49RstGeo4UkAfiEJbOXr4Tzuc9m9sfW0RVmHDsxNfx+XIGb2sItN3Ino?=
 =?us-ascii?Q?5YNNid+IIxNqxwold8SK1cdPKMxrgCs3gPvjbeEZusWsZ0ThmrdOyxSOXWEC?=
 =?us-ascii?Q?Jlj+F42c50cT9uWC5y2VUV+g2fainjDzSBltcSMW8Oa5/4dgpmo4JoQnSyBf?=
 =?us-ascii?Q?7eTHR75X3WXFr7wGJckxd9R680fKg8o6N5dMuEKB1dcVKGaAmb/4gVGfOzLc?=
 =?us-ascii?Q?lEKaOByj/gTjkh9JSi4eF+mkfeK0rupx4Uc1viO2hX9DA5xtq3ycjluv0d4X?=
 =?us-ascii?Q?O2ahc2M17TcvrrPvvDPu6Ce6UoYw2KjXuYpc4issoxqJgyorbrMliK5qLKGr?=
 =?us-ascii?Q?umdqMWA4xh0aAZWvuYAhuDdAPI6FyUtSLZHPakFVE+8UHoSUikQsG0tkjUjg?=
 =?us-ascii?Q?3ekS9pRh83A87KveSEe8ZCTHCBstYwvMdFS126lC0RXMmGxBv23oxX0Yj2w1?=
 =?us-ascii?Q?uzuXZquP13XO2qTfsAxZdPdF4HrbH83OR+QSV26WKBjLGu8No7i8gAdChKj1?=
 =?us-ascii?Q?QTbIBHlSTVbrA5ctg11/SJr03KLel7CmiMlezq1GwNIIqwTFlA7kxPCoNTXU?=
 =?us-ascii?Q?1uWfQM57UHz5TSzUDzFRr36JceenyAk5AIwr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 03:40:32.0703 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcb86162-1825-4dd2-947b-08ddb52c5e43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7602
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
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 455f1a8a07ad4..53cd5511407d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1562,33 +1562,27 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
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
 
-	r = sdma_v6_0_gfx_resume_instance(adev, i);
+	r = sdma_v6_0_gfx_resume_instance(adev, ring->me);
 	if (r)
 		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static int sdma_v6_0_set_trap_irq_state(struct amdgpu_device *adev,
-- 
2.50.0

