Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04969D1CA26
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 05:39:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3A3010E508;
	Tue,  5 Nov 2024 05:39:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TRY2bAeR";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2071.outbound.protection.outlook.com [40.107.96.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0541F10E508
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 05:39:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FxvAaKyrOH9FPgBvv9gkfQhsmRAT07fVTo2yPjnxnfchX/WBiGjGLWevxXGeUppneqs9DydS6h3vpvruyD+UwWh993ZNF/K9xBmZyJWsleBWEbgUil5l4+gYQdIyuUFt4T+0gLAJpKC1earKd4jF4v2+EDO04ocMg+5kUjm71iJsSjQMWBoGEt9WW4PE/9eGot8QPWxGmyyFi6Y9yD66hFNZSnd2C1/HBRZC+2bXniLP/1W5a/RpnnBjmgY/6umWQ/P0okArN1Uy05deTuSThOIcACBOpHWxlBQXbYb3upuo6qYAEwODb0tM7STiJkewxP4BGhuOEIBCMSQ4oTcndA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33Gv/4UZV4N+8WyAXGq9P/LcmSspdsfEhpUNnHxiiDE=;
 b=HSt8oKmuLUxunOwkgUWyAUOpSaoYSGyfUmQAyT9hkUw3VVE+mDc5AWYlWjO2mwiajdTPIJMMbHBcgpPasgFXBdcASMg22mkWJYFGhZPD99I8SNxmlWIvZ6JCalR0osiLPPOaluj4V3vM6VtemHFssxcHMq0SYfVdR7B4Tk1kZZZm4at/Ug7oFRvsxOfutNB50mewR08BD43F4SAs3faQWIgBRu/GXwL9Ud7kUSXtjqQzHTBPZRSeYZnE9ktStJoMguaLnFe4yRprPOYV+9qLvAR+NdTMxXKfGnynmGcZ4laiPPX+f+etxnsgvj23NuhWtojrXNJwvhNXXj5zmFLB4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33Gv/4UZV4N+8WyAXGq9P/LcmSspdsfEhpUNnHxiiDE=;
 b=TRY2bAeR2Kwr0kbCkix3Yu/Mt1ltKniA5fL8LKs4w9wsnOrmvrXYHCTpxfwGHhObOa6DVVkdm1CHTla06AsaEo8QP+ar1lDxekQqKz3h7MQ9OIHxzQ2tFIhqBHDY3L6bEXYdja119d2iWHdagSTpyZeAguPNaxrZEsRBvvT9hcg=
Received: from DM6PR02CA0157.namprd02.prod.outlook.com (2603:10b6:5:332::24)
 by MN0PR12MB5932.namprd12.prod.outlook.com (2603:10b6:208:37f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 05:39:51 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:5:332:cafe::7a) by DM6PR02CA0157.outlook.office365.com
 (2603:10b6:5:332::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Tue, 5 Nov 2024 05:39:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 05:39:50 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Nov
 2024 23:39:48 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Fix unmap queue logic
Date: Tue, 5 Nov 2024 11:08:43 +0530
Message-ID: <20241105053844.3242241-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|MN0PR12MB5932:EE_
X-MS-Office365-Filtering-Correlation-Id: 3427279a-9fd9-4d73-3a23-08dcfd5c44a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bLZ9sfL14AQDXcEuIMXLrm1ned/FQM+nBkA3Y5AyJM2EXGfx2Ml7bJfmDTXq?=
 =?us-ascii?Q?fNbgIlUx0kprnHEzbYHSl+UKEY88+nh8Gn9twk4J3W4hG0eJj57fqqF9KouS?=
 =?us-ascii?Q?WxbVGyWO7SppCC14yz7WKLv47CWYXiljw/OSGIONtlUPsqTrahT1JVaiGWx5?=
 =?us-ascii?Q?ZxrIHDiBhdsFuoWa1YwQd5Lfsd1cH/+bzfiMeYtSCyUKwBiWKbA60/kqTnND?=
 =?us-ascii?Q?AuZNFPs7ljNen76ldDr6BvnOYvjmZ9JM42mmVf4+h6FPqOq2xl0uQI+apagA?=
 =?us-ascii?Q?zUGK9Gv6Pxgp5TuLffpUth0dQu1hSryaCnG4oNU2cQnAvd/apTjdISua7hbW?=
 =?us-ascii?Q?hHzYATPkwqoVNyH2/M6z/NdgdxpIPknUuGohmt+rKXuEjncNg1padMSYwVFd?=
 =?us-ascii?Q?ye2k/YO+O1WP2MUMgcCPdbkvRl8bXkZVKcGKSp35GJspKHECR5hnV+7ZOXe3?=
 =?us-ascii?Q?S4PX5lQq/pOmGNVNQtzuD5GqOVikcukvhzJC2h/gdXV2gfzeGskDC5Kz9j3k?=
 =?us-ascii?Q?cR9IeCtmS/RDw6IhlNVUw6g0/Eii0HVaEc+zG0uSr1UdqWOL/txosrzlRDEm?=
 =?us-ascii?Q?JB6jjw399tcArac4j8ddNMI748F7M5Aqwxlz9CvieEbwpIGNvfelJtJfXDZJ?=
 =?us-ascii?Q?t9zRgbLtZmN0NrXMeFVRnl4K5B3tpnEPnPH5FIXBg99r57ACrs0QeDl4WOYC?=
 =?us-ascii?Q?I8iznhlURI6/bGFrfSQP6B51dbeIUQkGmnagqvrydtOW57oaVB8hLDNFbDwP?=
 =?us-ascii?Q?R3js4fGL3GiHUR1Eo0a0pCsBL0GxIMUD3kVOw7335UZVryP5/GEraYS9s6vp?=
 =?us-ascii?Q?id2sqC1LPTQJmKNaNryrVmZcK5i3yO4z8edNWM8SsZHdzNvoKBTwC226ZTzu?=
 =?us-ascii?Q?stCqodV4vAWAGBrwAnllByx5/7hGi+i6Q9vlgWuFw3LBHaWcgDJanogjBSDE?=
 =?us-ascii?Q?lEXS/gPgDp/+jhbcif+UA+8mGQP3SGSqtZvRv8me+w1eGxE4kVyda4CPfOoI?=
 =?us-ascii?Q?zjS+b5n6gE6aXWo5NmZyNJ1oc5ieg43MBfkfZOhJ9PcJglGwQRWd9idCiXjZ?=
 =?us-ascii?Q?czAhDIImv2eeraCJTuiflMnXCCUL+xTXqacLD2CbmVzLrFlKLjp4XPlp8R0j?=
 =?us-ascii?Q?FjAhMwuVEwIQ2SlHUCtnqrZm3GLwFlhAJVAe1X4C0ypLBAra7rzbFfFPlb3F?=
 =?us-ascii?Q?4OZuSkjXWeUNWiv2/btb8GuqfmxSh3kBP/aFyZcYWLjZN1DZARFegRuAozcV?=
 =?us-ascii?Q?z0YY8UN4cPPj/pTX1NPCCyi2vKrYVcjUaHF1QOL5MHY4Mm9NbipoNoCI87jA?=
 =?us-ascii?Q?76tG3cekC3Rsz6sEjJUKQ1OwS4qveU/yQ1GOfGu8c0atAeedG5KFm9QgPtWt?=
 =?us-ascii?Q?HvR2UOzRhp/e37Qihktdklq78USeKsqsK20kvxP3Si/k5v6ifg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 05:39:50.8415 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3427279a-9fd9-4d73-3a23-08dcfd5c44a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5932
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

In current logic, it calls ring_alloc followed by a ring_test. ring_test
in turn will call another ring_alloc. This is illegal usage as a
ring_alloc is expected to be closed properly with a ring_commit. Change
to commit the unmap queue packet first followed by a ring_test. Add a
comment about the usage of ring_test.

Also, reorder the current pre-condition checks of job hang or kiq ring
scheduler not ready. Without them being met, it is not useful to attempt
ring or memory allocations.

Fixes tag refers to the original patch which introduced this issue which
then got carried over into newer code.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Fixes: 6c10b5cc4eaa ("drm/amdgpu: Remove duplicate code in gfx_v8_0.c")
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 13 +++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 47 ++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      |  7 ++++
 3 files changed, 49 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index c218e8f117e4..2a40150ae10f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -844,6 +844,9 @@ int amdgpu_amdkfd_unmap_hiq(struct amdgpu_device *adev, u32 doorbell_off,
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
+	if (!kiq_ring->sched.ready || adev->job_hang)
+		return 0;
+
 	ring_funcs = kzalloc(sizeof(*ring_funcs), GFP_KERNEL);
 	if (!ring_funcs)
 		return -ENOMEM;
@@ -868,8 +871,14 @@ int amdgpu_amdkfd_unmap_hiq(struct amdgpu_device *adev, u32 doorbell_off,
 
 	kiq->pmf->kiq_unmap_queues(kiq_ring, ring, RESET_QUEUES, 0, 0);
 
-	if (kiq_ring->sched.ready && !adev->job_hang)
-		r = amdgpu_ring_test_helper(kiq_ring);
+	/* Submit unmap queue packet */
+	amdgpu_ring_commit(kiq_ring);
+	/*
+	 * Ring test will do a basic scratch register change check. Just run
+	 * this to ensure that unmap queues that is submitted before got
+	 * processed successfully before returning.
+	 */
+	r = amdgpu_ring_test_helper(kiq_ring);
 
 	spin_unlock(&kiq->ring_lock);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index dabc01cf1fbb..6733ff5d9628 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -515,6 +515,17 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev, int xcc_id)
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
+	if (!kiq_ring->sched.ready || adev->job_hang)
+		return 0;
+	/**
+	 * This is workaround: only skip kiq_ring test
+	 * during ras recovery in suspend stage for gfx9.4.3
+	 */
+	if ((amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
+	     amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4)) &&
+	    amdgpu_ras_in_recovery(adev))
+		return 0;
+
 	spin_lock(&kiq->ring_lock);
 	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size *
 					adev->gfx.num_compute_rings)) {
@@ -528,20 +539,15 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev, int xcc_id)
 					   &adev->gfx.compute_ring[j],
 					   RESET_QUEUES, 0, 0);
 	}
-
-	/**
-	 * This is workaround: only skip kiq_ring test
-	 * during ras recovery in suspend stage for gfx9.4.3
+	/* Submit unmap queue packet */
+	amdgpu_ring_commit(kiq_ring);
+	/*
+	 * Ring test will do a basic scratch register change check. Just run
+	 * this to ensure that unmap queues that is submitted before got
+	 * processed successfully before returning.
 	 */
-	if ((amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
-	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4)) &&
-	    amdgpu_ras_in_recovery(adev)) {
-		spin_unlock(&kiq->ring_lock);
-		return 0;
-	}
+	r = amdgpu_ring_test_helper(kiq_ring);
 
-	if (kiq_ring->sched.ready && !adev->job_hang)
-		r = amdgpu_ring_test_helper(kiq_ring);
 	spin_unlock(&kiq->ring_lock);
 
 	return r;
@@ -569,8 +575,11 @@ int amdgpu_gfx_disable_kgq(struct amdgpu_device *adev, int xcc_id)
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
-	spin_lock(&kiq->ring_lock);
+	if (!adev->gfx.kiq[0].ring.sched.ready || adev->job_hang)
+		return 0;
+
 	if (amdgpu_gfx_is_master_xcc(adev, xcc_id)) {
+		spin_lock(&kiq->ring_lock);
 		if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size *
 						adev->gfx.num_gfx_rings)) {
 			spin_unlock(&kiq->ring_lock);
@@ -583,11 +592,17 @@ int amdgpu_gfx_disable_kgq(struct amdgpu_device *adev, int xcc_id)
 						   &adev->gfx.gfx_ring[j],
 						   PREEMPT_QUEUES, 0, 0);
 		}
-	}
+		/* Submit unmap queue packet */
+		amdgpu_ring_commit(kiq_ring);
 
-	if (adev->gfx.kiq[0].ring.sched.ready && !adev->job_hang)
+		/*
+		 * Ring test will do a basic scratch register change check.
+		 * Just run this to ensure that unmap queues that is submitted
+		 * before got processed successfully before returning.
+		 */
 		r = amdgpu_ring_test_helper(kiq_ring);
-	spin_unlock(&kiq->ring_lock);
+		spin_unlock(&kiq->ring_lock);
+	}
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index f85e545653c7..553a6113fa67 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -4823,6 +4823,13 @@ static int gfx_v8_0_kcq_disable(struct amdgpu_device *adev)
 		amdgpu_ring_write(kiq_ring, 0);
 		amdgpu_ring_write(kiq_ring, 0);
 	}
+	/* Submit unmap queue packet */
+	amdgpu_ring_commit(kiq_ring);
+	/*
+	 * Ring test will do a basic scratch register change check. Just run
+	 * this to ensure that unmap queues that is submitted before got
+	 * processed successfully before returning.
+	 */
 	r = amdgpu_ring_test_helper(kiq_ring);
 	if (r)
 		DRM_ERROR("KCQ disable failed\n");
-- 
2.25.1

