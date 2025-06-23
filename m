Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72BDAC77B7F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 16:15:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15DA310E419;
	Mon, 23 Jun 2025 16:15:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U156X33n";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD8D710E416
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 16:15:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gj0fk8XRX9dsvAByzvs4K5Bn30eTZ1gdbLTnJL0JYA8r2+PXFWtQe1z6b4VJ/UEGlO7MGd984W/U8VazWa8cMHBkEQxacFj7isWe7Eutg9wjhpQPBUwWeoSBD8L0juBtwhWVQjDPRmSyuU5RHhwV79x0pmWLAT5sA8gdXWk8VbtrMN92XBJ+vYcARG6TCIfKozex8bUVD+N+yu+yWZ/1lX6xsjCPnKuX45LOYBZOZhOO5hz9YsYWKaKkAfK4uI7RHgnftfzbtVP8qt547qy55s6BXo7Ye/rwod2n0nb7yOfTFRAAemdvdt2pXoww7T+HKNZS5eAz+xgJtSf3dpnSiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+BVcSOWzuwk0rtOk6ezCyguc/eYvIwAGX0l6tCej3Lg=;
 b=f1Jx0w3z+CXM5rvNyEqxWrHQRRgDfM0FtQK2CMOq82X1uL1QXAcAZlxSWCpz1B1N83IT/+uU5aZoyWt2bghrMEouJGRRCjP87J/zBI4tSWabq/XQrCc4ixI6MuMkqr7hWQbixnl+N1Dj/FbrBk7R5He5W8ExfsZCQWAyozAbUGulbeUoWoVQcPwvbjJTzUMs81tYSapO8v9dL+Ln4dmUwn5/YJ5GlDPcXAWZysCUDtNlLgp0jZVZb5xv8nbBPRtvq7MuPQXXrmrGshEPJgKFW+/aEeDu48ov0i5szHQhG4zmGYfjhQICoXaaPuiGWgFbMh1Z6UMM+qqmikkMpNVZvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BVcSOWzuwk0rtOk6ezCyguc/eYvIwAGX0l6tCej3Lg=;
 b=U156X33n3Q0kxz2udCAKPiMW9Zb90DV2hhR3vV2cZzibdRIucUtZB4FYvtP/RxDQy4VEzJ4SO8U9qihnnyZ6/i1zuflxHqHTUv0Q+NQx7l9TT0s8C+XW+3Qc0jdj1My4kWJvHLQirht59SqRJG81fzS3y6FMWUgUx5qNOVRfQzQ=
Received: from BN9PR03CA0950.namprd03.prod.outlook.com (2603:10b6:408:108::25)
 by IA1PR12MB6625.namprd12.prod.outlook.com (2603:10b6:208:3a3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Mon, 23 Jun
 2025 16:15:12 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:108:cafe::cc) by BN9PR03CA0950.outlook.office365.com
 (2603:10b6:408:108::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Mon,
 23 Jun 2025 16:15:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 16:15:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 11:15:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 25/31] drm/amdgpu/vcn4.0.3: re-emit unprocessed state on ring
 reset
Date: Mon, 23 Jun 2025 12:14:31 -0400
Message-ID: <20250623161438.124020-26-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623161438.124020-1-alexander.deucher@amd.com>
References: <20250623161438.124020-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|IA1PR12MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: d8c33408-1be9-4525-95cb-08ddb271218f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gdMsVi++/ih+WnJdVpzYw06+aXRPoonU6dtHcb29mvnd1Met34nUh43DTClP?=
 =?us-ascii?Q?OG/AsLK2JNJYxL1cIJOl74m6Dmx+U4MmVkf68ejqlG6jO6zE+SeTiOYCo61O?=
 =?us-ascii?Q?Om2eIVcU35QZ6soR/G0JcGtE+jwI/1M9eLtRh5z9NgpiZRae0iS2WOsHpgPV?=
 =?us-ascii?Q?RK9iBDfB8xKqQp3kDivDERJRWCqqLl6cQY9/zB9xmjym7mcQ2sQlgAQt3tzR?=
 =?us-ascii?Q?sXWCeNfkEpHNynG/7ax2eaRqsn7cpfnlDUjDhkJ0oZ2qPVMdOmUSnqR+5Mxk?=
 =?us-ascii?Q?F1QpjYmsiitQX7zbwl2370l31UuesytELYO2c0whs29wPlRtjHDQvcJOz0Vj?=
 =?us-ascii?Q?1dSI4Q5KKQktAvwyoYmP3mH6Gkms0XG3wS3/AqzldreaE1JuyELvKlFBnvkP?=
 =?us-ascii?Q?Br9yiavcVj9pft9ZFcXSj9zTFylJ25QGQQKw6nT8E8FyJjt8Gclcy6CCXHQ4?=
 =?us-ascii?Q?TK9dnsXvQ61B81GokD2yzjiCuWLT4TN0ATPCqDHgpp/StIDyPOaqMkX/2sFR?=
 =?us-ascii?Q?1YqqIRuZ7auvkC8agddIVRhnq2MOYJy1ctTViqF/bL2HGTLD6IN9kM1w+xDq?=
 =?us-ascii?Q?uSifC245nqUf7YJQo/2yaoj8pe2PFbr7AR+vX68/ABMFlkiy0TM44+7ffBTL?=
 =?us-ascii?Q?IvupTo5qrRENdLXyCi9oT60YSrPnAIcFfR/OCM7b2/WHdWtDMMPlve4AtQYQ?=
 =?us-ascii?Q?oSIee5We3Q9toY2vuWdJNo7G01ANR+VjVigkCpokrH2EFk8Zqe9vx9hehZi1?=
 =?us-ascii?Q?a3OvpNgY0Yj8XtFD5+pREiOTVGUIROQxkTG+Mt6+6Ss/pXhBY/ZaUIo6IiPk?=
 =?us-ascii?Q?8WQFMt+0ydGYerOhyC4qkBo8s68Jqb9rHX5mDETo9nYhD0B8sLI0eGe9NFF9?=
 =?us-ascii?Q?edAv4GrqW+h0xHH4qPqWLNg93PksauKcVUCJvQyPRD9ZsRmd3nO1uOR731pn?=
 =?us-ascii?Q?xUDL2UKBZSf79jfcHY69mV+2+ImmlXhyAZpHPVCPiK29enQjfXomH0B78tn9?=
 =?us-ascii?Q?n6gk0Bq0SO9153Z/wVqYGq2oiOWjOhoREgLM2flm633cNVyV2DhcO++KQD1D?=
 =?us-ascii?Q?brD0jg+H32rAV/ARblA7aD1a50RZfcd9+d3314tf0flKqfkS4OMnQleU4Uaw?=
 =?us-ascii?Q?P6j9IGIDAjLlGrKQWbsRHAWzrm1Nei6DMqV++nCZAXvta6KNPx7gq8sCUuY+?=
 =?us-ascii?Q?yJMxcPx6T8wSo8qjtuJ9WPx9Uv6wAOLE6P+tS7QBP+1z5H0v4AzWPb+jHVRH?=
 =?us-ascii?Q?k8zb21eZuYI13E8reEcKpeDo11EZr9YNMYU6R9l9TLyEBkthMZ3LpoAtzPcK?=
 =?us-ascii?Q?fw8SvI40SrznvBhOUAQxHfQ+w4fv9HL6TbYSTdn1smmnNbX4xm5EKDWwhrt3?=
 =?us-ascii?Q?MkAO9oOBAQJvbdygrqP7Uv9GLQSjn9wmCzpq56IhMST1Sq2TwgbRc9Q6zTZ2?=
 =?us-ascii?Q?Ld/mN19QoKC1W//VZxKWPuYtvEyPTgB7KIEFxG7WGTSTdBgK7cwrK5eeweYL?=
 =?us-ascii?Q?xkwTUZuA4mZR4CupZ5txuYKv5NTESq4gzgvK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 16:15:12.0190 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c33408-1be9-4525-95cb-08ddb271218f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6625
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

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index d8fd32c1e38ec..3bda19b92cde7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1609,7 +1609,7 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	vcn_inst = GET_INST(VCN, ring->me);
 	r = amdgpu_dpm_reset_vcn(adev, 1 << vcn_inst);
@@ -1624,12 +1624,8 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 		adev->vcn.caps |= AMDGPU_VCN_CAPS(RRMT_ENABLED);
 	vcn_v4_0_3_hw_init_inst(vinst);
 	vcn_v4_0_3_start_dpg_mode(vinst, adev->vcn.inst[ring->me].indirect_sram);
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static const struct amdgpu_ring_funcs vcn_v4_0_3_unified_ring_vm_funcs = {
-- 
2.49.0

