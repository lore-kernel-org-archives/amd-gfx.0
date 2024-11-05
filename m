Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D88D1CA3A
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 07:08:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7311110E524;
	Tue,  5 Nov 2024 07:08:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AIXAypzD";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA65810E524
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 07:08:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yP8loijFCDr730yQrgEP3jQgB+crqaS48LXyqwzERO6n8NYV1yah2YWSBw5dRFY3/ftPT3ZluMTC9jM7OichF5syMYSBbHKNrhk8DXQzSxR6uY1sY894WbMfXnIv2E5PAa1AnvN0czuIcRdnRfPY1FceTaFDG839zN1wGi0Ecy3pebla0fe7H4mdqsbzrYE0WWQshSviRgxPv2RBoP27cOUeMVnonfEBUMiExpRwnMbtOVl8qZYIiPOFN7W/xbMlYDUpFsrFH4lKYoT1n+EVKoi5v7KCguQzF5OK9PfpRJR6T8Smn/SiYwrdyCPrieJ+9PdTJkVnyvygDfdSn0ebxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AB8wKNYSMF0Wo0Rhy1mrZm6HasQj43XD1Ia7aFHMVck=;
 b=PWzfFrvyOdKltjfMSOL/UQ+jwirTG766/YVvw0gvIY65Jn0eqAOTrRqTDWR+iO1zkNE3U1f3+JR4QQhqNjgRkw+warNZIvZMGGlxEzCep0SAUdTU/fpkEO40seMg0wNeI3RGKKphwqFuxqyIBg8wwluU3I4OP8RED6fU4aY5DHwo4cnrvmHS1e9PWEh0SePSv1eOMmPeVKsmlQzAkFCUwYy7xWYtT5z3I6q20dQwZme2tcOjE8VRaJ2aNz3MYqjZgvWmaEFpDOixV0tP1pQTQisUFMrz5gfQ9FoBb8gFvoZR9m+CaNROYO/qWlPDAJjDWeVd0I0SSixItI56JLB7GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AB8wKNYSMF0Wo0Rhy1mrZm6HasQj43XD1Ia7aFHMVck=;
 b=AIXAypzDeWjsJTW8mMM+K5sqyuMFwOiVTO5zQiU04xQf6N9GF5+BzL0N53ZRrmKn24sBC/2LI1tGd77tfDcmphLJcu1xjSf/K9x3nIX/6M/77fGcbt6xm4ZswDQDYQCvvZp3N6jSIouVCFLcKBoDV48O68f5dO1wPLoYWzhCjbo=
Received: from PH3PEPF000040A1.namprd05.prod.outlook.com (2603:10b6:518:1::52)
 by DS0PR12MB8767.namprd12.prod.outlook.com (2603:10b6:8:14f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 07:08:48 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2a01:111:f403:f90f::3) by PH3PEPF000040A1.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.7 via Frontend
 Transport; Tue, 5 Nov 2024 07:08:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 07:08:47 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 01:08:45 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <Le.Ma@amd.com>
Subject: [PATCH v2 1/2] drm/amdgpu: Fix map/unmap queue logic
Date: Tue, 5 Nov 2024 12:38:28 +0530
Message-ID: <20241105070829.3243486-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|DS0PR12MB8767:EE_
X-MS-Office365-Filtering-Correlation-Id: a7cdc557-8fd6-4833-38f2-08dcfd68b1a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4DVekxaRVLQbzhB682SjlCLii7TiJtWQ4jzYDsO6Bo5UP5ChyUOloEFGnbgf?=
 =?us-ascii?Q?x/0rJTeI0W9/SVN/VFZKmn+CKXQY8PGpVauw8s07NPCD0VdKv0F6AK7pmQfa?=
 =?us-ascii?Q?KvQMG8hp9Iflo6rmTlsn+n6nTPdg8U+c5FOU9YqMwLBud27eVd7VqhlMSpL1?=
 =?us-ascii?Q?99AsnmjH7E63heQLbjPPIWk9lQpIEeD5mbOkYV+83io4KDQ3mxWGs7URoOpj?=
 =?us-ascii?Q?uBToxwOcvKTnsikiSjdrmpJz3M2uGbGF9rYLRVfypbtfgG4Br0FZbi9YuLQI?=
 =?us-ascii?Q?h7x20kBUVHawFVlQkiCUaCGNRFYI++JP3RukG+VKtAubiYG1RKU8XngcKAJJ?=
 =?us-ascii?Q?zzbNHStseTIqTqmFXJedmVaKx9NdyIqADW8drEFK0VS2Cvj9ybIdXYUAeExl?=
 =?us-ascii?Q?D6VAcHzXq1dpGPr6kqc11FUZd5tOyjPAc0pvp1mPhiXSL3q89FtunCnCEPyX?=
 =?us-ascii?Q?AkbNH3g2nxUnXDtLb0CLDyJCe161jfSljwO5/9h7JdmweEY+boqSDejRqM76?=
 =?us-ascii?Q?2y2tpnMqWBdY1qz8HtTN5hgXdgVaHvbCeb+/QCLQwx3Zm2ZNnT5dyz0NCN8G?=
 =?us-ascii?Q?K7vCh5B++szuue5g+SBg6/Uoz++KHSv3TPcmsQeWN43neEtOZRF+tZ4lAgL+?=
 =?us-ascii?Q?i6b9mr/cEC4MAFFxmZhm+3Bc2L2EtQc8K105Uzbs0d57ji6BFtevdZ7R89pd?=
 =?us-ascii?Q?8W0sqaBzCvszUgp2F/o7yabflgoQQt3izvWp7NyGGZIR7jXFGrg1hjxT33w0?=
 =?us-ascii?Q?igCBsUKyexT3cIl8IbF5rC3EErfmQf+BGdmIijv+Pp8Z4YGaWbywnqMp84zK?=
 =?us-ascii?Q?I7scYbPH6L1FGHWx464AvEQVKlrxUT+gTNEVNSi7ACEiBbz96VCmnh2UNqsu?=
 =?us-ascii?Q?AiBolS68foOc3v5z5/sbpLILH5WyB7uQ+pcR9cJd14U+YxX572SNYE7Ven4Y?=
 =?us-ascii?Q?32sSQ078hBvz6Ltx5GjMv4Gv68cd4ydTnUo8sUsnam9xITSLHfK64nHBUHUx?=
 =?us-ascii?Q?EnHMfa4fOj81XzPDjcDiJr88E5ZCwF4VKzx9wCq94x5mG9sP+KbEMmT3hOkw?=
 =?us-ascii?Q?TOlOq1Y9HIHYpzB59AmohuyWTS/YyaAXP0lHA4UEhY3HZQ5mSGsz0xF3FrOx?=
 =?us-ascii?Q?i6KXsR9jBb09Vc2sz9oEFzz2/Mtui9lcvAozS4rtT9LOUNJTWcCDVFe6/oEI?=
 =?us-ascii?Q?RXaimTMpWc050iwVB4WqeZ1ORbai7MBZEOm7EJZfsvZ7dvLdbiEJ6bBxlhu5?=
 =?us-ascii?Q?dRPGMJYv9EMRDWrhT9lD+2p/YKhP8uOq1UQ842Y5rDzbVyAwHAVyNotiWc6v?=
 =?us-ascii?Q?pDGwHtn/lTCma19+lzgf+mPaCdQNzlVgx8jptCrNDlsQ2tqZDvpbWYJWtRTP?=
 =?us-ascii?Q?4Z9xA/Qw4e0Ot7tD4h4+2TIBcFrbc7YWHioriRS20DR06XTrtQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 07:08:47.7939 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7cdc557-8fd6-4833-38f2-08dcfd68b1a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8767
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
to commit the map/unmap queue packet first followed by a ring_test. Add a
comment about the usage of ring_test.

Also, reorder the current pre-condition checks of job hang or kiq ring
scheduler not ready. Without them being met, it is not useful to attempt
ring or memory allocations.

Fixes tag refers to the original patch which introduced this issue which
then got carried over into newer code.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Fixes: 6c10b5cc4eaa ("drm/amdgpu: Remove duplicate code in gfx_v8_0.c")
---
v2: Add same changes to map queue also (Le Ma)

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 13 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 63 +++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      |  7 +++
 3 files changed, 63 insertions(+), 20 deletions(-)

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
index dabc01cf1fbb..445220e9773e 100644
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
@@ -692,7 +707,13 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev, int xcc_id)
 		kiq->pmf->kiq_map_queues(kiq_ring,
 					 &adev->gfx.compute_ring[j]);
 	}
-
+	/* Submit map queue packet */
+	amdgpu_ring_commit(kiq_ring);
+	/*
+	 * Ring test will do a basic scratch register change check. Just run
+	 * this to ensure that map queues that is submitted before got
+	 * processed successfully before returning.
+	 */
 	r = amdgpu_ring_test_helper(kiq_ring);
 	spin_unlock(&kiq->ring_lock);
 	if (r)
@@ -743,7 +764,13 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev, int xcc_id)
 						 &adev->gfx.gfx_ring[j]);
 		}
 	}
-
+	/* Submit map queue packet */
+	amdgpu_ring_commit(kiq_ring);
+	/*
+	 * Ring test will do a basic scratch register change check. Just run
+	 * this to ensure that map queues that is submitted before got
+	 * processed successfully before returning.
+	 */
 	r = amdgpu_ring_test_helper(kiq_ring);
 	spin_unlock(&kiq->ring_lock);
 	if (r)
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

