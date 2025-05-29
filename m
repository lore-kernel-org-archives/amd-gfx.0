Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88357C5B553
	for <amd-gfx@archiver.kernel.org>; Thu, 29 May 2025 20:08:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F2F310E76F;
	Thu, 29 May 2025 20:08:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D3G9dIZZ";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF78710E24D
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 20:08:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sfdot4jjptRR7+TBsZDDz9ihdQGJOMiQZwEO5rW0PeLHuNcrVFCY9kgDV6EtyXcFgFiEbjE/n7IqcibMLk4ENT21BHsk1ZD/MXoqnpXyl++5nEprUXmIPrstXPODkQV5SAHbNAibDVqj+w6qdUmshiRVcfQT4jV5ffqrQNfsTftsPTewM4Mul315Uuqp7l2htj/vLrLlObNJMTPF5FtMuJsi0DJztqdr8nhuephYAts+rpPkRT6SfA54Ya5Z21mDGsU8giWb5t5F0czbb6r4kpIkLK0hRDwCqeu9wn+yEAYCZupfZPgzTNpGVdwqnIgwmONdcrG+qo6o1p3hub7UVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYy8c6MCt6tPokaiw6M0GKn1JsqdXX5yBCvzziC0f3U=;
 b=IK3GyjoPTd49KQUm2W72BSDL/MHtOQN3gJr10ILhdNSKzspcQfAbtGrQioQoRL77FJNAff55TYeGyFDz5cvEYcaq4q9w+jP77DA4wzeaAVFo6uajNhX3biw8kg25JU3ykjIxykN7wM17MvdiA8kLXiHkmpD5+RTXsNYtZKL9sJEyRF3xICZ0LQaKK5S8TCDhlf5IqK6tHpulSLlGN/oEeAYudIBdjbczoaUD7a9cxNgb1S8vLwteWREc5BoghoPyyG+wt7NDYILyi2ogMmVguEeh2GmgFRejBIzldhB3Hhbxx+HmgqxxjavtoqeUM+ZGzAD45jwtxgwIsOQp9DYO0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYy8c6MCt6tPokaiw6M0GKn1JsqdXX5yBCvzziC0f3U=;
 b=D3G9dIZZ4AjjwGRYi6ogOF17mRpq401LV9dV2h43s87CBpaw37zfu6iTA8FXjoBafv/Sbq46WujoXLeAH9d8ArhrUersgpEnTASnxLDKIz1a7F7SFeXan6EwYG1Cd5s2IoqAgbmEPvMBYqK5zeH3xbuQ+JAnFoRKR5FbukfFeNk=
Received: from MW4PR03CA0054.namprd03.prod.outlook.com (2603:10b6:303:8e::29)
 by DM6PR12MB4434.namprd12.prod.outlook.com (2603:10b6:5:2ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Thu, 29 May
 2025 20:08:29 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:303:8e:cafe::38) by MW4PR03CA0054.outlook.office365.com
 (2603:10b6:303:8e::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.23 via Frontend Transport; Thu,
 29 May 2025 20:08:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 20:08:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 15:08:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 16/28] drm/amdgpu/sdma7: re-emit unprocessed state on ring
 reset
Date: Thu, 29 May 2025 16:07:46 -0400
Message-ID: <20250529200758.6326-17-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250529200758.6326-1-alexander.deucher@amd.com>
References: <20250529200758.6326-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|DM6PR12MB4434:EE_
X-MS-Office365-Filtering-Correlation-Id: 44542704-ed18-45d7-820e-08dd9eec9442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T6sQ8OeBDaAeEAFlB2LTo9NfoyUJt3AUlW9ToCw8S3OueZaS5iFbL/mtu19F?=
 =?us-ascii?Q?uXQBvWGCwfNHdGOCFamwossPZM0ZMKSLhROqveq/E+qG/kX4EH2iEX5Q5TLl?=
 =?us-ascii?Q?ATx/rtYiy/yI8C7BJlxCg2Ziocy1plHDnI6ORq5D9hoF/QsMs5xffg2aSDdq?=
 =?us-ascii?Q?EmIOZceYjd/aMWWNdryYINzcb6B9ApFHzZPepF58o7cZdD6LICDIxd4va25T?=
 =?us-ascii?Q?ZXGx6oRo3Z2jnCc2RH/OhpedHwSg8IoWCIIoGISe/sia1eeA89gfvWDea1AZ?=
 =?us-ascii?Q?1Dzcckwb3GCFu5zashoMvoLEbzh6VYMCWnEEhFrEincXr5nXD2oG1/jWguxL?=
 =?us-ascii?Q?E3XSr2hNNaQfv8Ft1QSe3pexXL+Z7hZV1ytiAbs6CmCN1IBp1Gy6Kalp1qqM?=
 =?us-ascii?Q?anH6ATvpoIgH6ag8nJ5NX++0a+Picn0kvOIc5TBVMc687IHlwjDAYDd6wvGC?=
 =?us-ascii?Q?dxV0Brt+oay0I/Dcq3v8EMopT541OtDXTYEhpJtxeo5J5nvK9ImUWVULHiw2?=
 =?us-ascii?Q?6AUzCKAIri8db/jpD+oiYG7SyiyeBO0ooyyB88j8fQWaUwZsSb3DzVg1Pl5s?=
 =?us-ascii?Q?SGUUEKQ6KIj1Z88V3LIlQBI/sGb0uhFB5uIeCYhAaQeA5jEUcpiHfBkDB98b?=
 =?us-ascii?Q?A8wwog+YnAYHRbLKdVRnJr1C8V9aikhY3aS/KEsFFJ1+HHShXttHbNxjQZZj?=
 =?us-ascii?Q?ZLBqe8X1bpsxgJP4wZ0fNplJOAFbpM2Ij9miRCJ9Rm7+7NVypZmw8a6S1ZoH?=
 =?us-ascii?Q?jiSuHmBi+JqR1wcRvGbOKAoSEQTnv0YkbDFDz5fybqsiyvPfaLfJN+cDe1bE?=
 =?us-ascii?Q?7nrlMqiretrMwfbFlOzqzBHiHaq1NoYnYb+0BixmLJpss0xQGh7tKaWMDqA9?=
 =?us-ascii?Q?QJm6cRkYMrnqDtET92gvdpNUkDdGhIDKt+QbHYVDrqFOpzYYKyalts2Vfii8?=
 =?us-ascii?Q?pR+GgYuU2PLLuqEhTpXP4QNhBWTXyC4zksgL03t8Pi1mQyVejWoPS9RUEJrv?=
 =?us-ascii?Q?tPsj1iHs0BSBl195PkcTU1OwiT0F7ffs5N6DzgIQx6nvLn86PXRFSjkWbbg4?=
 =?us-ascii?Q?w8yywJYSqFd7XL0yqJklMvsk5eEJVM1HSHfkCSu8LdePOz3IAgA9/YrGccpJ?=
 =?us-ascii?Q?ys40yplhZYmytj8PfugL9Ff0nkctrhZGArCRA0rARzFc6CUMrG9o+BXVOHfL?=
 =?us-ascii?Q?rZLERmYCQ3V6xETrFCeVWC4Wols8Ou4W40g+0bq8Yzev3+sU3IEIOi3+gBTT?=
 =?us-ascii?Q?OcmWdj2hzVspytLwrE4zfAZht0U2Xssa2M/6J5JBL3RPz51uY0l9YHShiArg?=
 =?us-ascii?Q?y0JwZgsH3UouxbBprOufj2bRlcu6KOw7KEjQBS1C4lHLA5WaDRDCAnUWYCdi?=
 =?us-ascii?Q?4DTzj7Ub03qvMVelzO78rRnqCJ9NYrAJa3iKCp9StYId3X4qGVufZbpgEqLY?=
 =?us-ascii?Q?76mAfCpeWjPzmqxY9Yd6FzIxwUYFaswPIbudUMWyEJwS0D6jCGTi4znla9GN?=
 =?us-ascii?Q?pUfxEhfh+JzVnazBjjYRPavs8xZDNKKyps0D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 20:08:29.2078 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44542704-ed18-45d7-820e-08dd9eec9442
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4434
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
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index c9993424b3923..808fc658dc040 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -823,8 +823,11 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 	if (r)
 		return r;
 
-	amdgpu_fence_driver_force_completion(ring);
-	return sdma_v7_0_gfx_resume_instance(adev, i, true);
+	r = sdma_v7_0_gfx_resume_instance(adev, i, true);
+	if (r)
+		return r;
+
+	return amdgpu_ring_reemit_unprocessed_jobs(ring);
 }
 
 /**
-- 
2.49.0

