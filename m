Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99AC2C61DB2
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 06:44:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3E3510E893;
	Fri,  6 Jun 2025 06:44:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MIbQKyhl";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 140CC10E893
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 06:44:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JzDG8V2iH2GKaLCwyGEMtYUz2I8jJDyqUYUCTAs9i8iMI/wdjy7XfGML267BweyMZlkfLhYHX87vjbTppDZsLv0h0vSCpyKHXcJdokUUCxDbuUsleUNO/jUM4XZJRZuudwiORO6OOz9GSnRLglhbVCQU6Sf6FOtGgdrLmKaDtf2+wFMyxgnKy1eRViJsP1j2YEdOsb7i/AibkN4kRS5xM9p9taBzoi8tXpVzNfLaEkC0ZVrhrcVD3Wy10FDi0a6z9mRwt4ZuUnNTV4V/OFVZ4gKaSv0DO/eWIVR6O/vi9Xbj0Ue5PbnCbgW5uQca6P1GPmFmH64AaaMqBuzr7j+QYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWTZt5rC2yV8yaw/oaqat4Cw39Bnjs7O/wuis2jIkR8=;
 b=V9wYdTNeANbbvZrKKosE37DT9Ub9e0JhUa5geq6sN6q7S3Duqzx0SNjEBaJ0kYeEYTMKl2fMMfq82vnVnI52edmJtkuwXuukPFfghH0p9QgZjnFPY8tw9p3PE3W9kzGURy6zL8RiKec94k+DdG0v7b1HmpBYTP6ovMSVCVg9aVp2e9Cp6ah3u/7Z2hnAvTXq0RQRfb2/ifWtjR7Iu5fI6PzyC6cBCHjW8nnbPlAM0z7tKe5eASdoGIIj7FOCJViMRV4mqhjkZKyAUclXl71Ks97o7N7ELKB9rMWhRRn/MGLw4nsjuZpAOU0oBmchH5NFFMlJsUJIFsMV1/L/as7HwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWTZt5rC2yV8yaw/oaqat4Cw39Bnjs7O/wuis2jIkR8=;
 b=MIbQKyhlH86Hes6NHzL96so8MkRjlnqnW8sp4D6Gn41cytHymfmBxrxGA6I0iIUkm+iJZlWdMK8D2WRWeYmQlA4IlQk/LWkC2musl5hY5IeTEcqzE02btMdVS2+St0AWUTfNCSmZmLRfroNyvZUdDPsQEUuOYrcOkncz1zuXFCA=
Received: from SJ0PR05CA0090.namprd05.prod.outlook.com (2603:10b6:a03:332::35)
 by LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Fri, 6 Jun
 2025 06:44:18 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::bf) by SJ0PR05CA0090.outlook.office365.com
 (2603:10b6:a03:332::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.10 via Frontend Transport; Fri,
 6 Jun 2025 06:44:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Fri, 6 Jun 2025 06:44:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Jun
 2025 01:44:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 11/29] drm/amdgpu/gfx9: re-emit unprocessed state on kcq reset
Date: Fri, 6 Jun 2025 02:43:36 -0400
Message-ID: <20250606064354.5858-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606064354.5858-1-alexander.deucher@amd.com>
References: <20250606064354.5858-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|LV8PR12MB9620:EE_
X-MS-Office365-Filtering-Correlation-Id: bc2b4401-c289-4be7-f2cd-08dda4c58f86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MC+34V4kfMZRJjoEK794B1uCx0YaQ02oUgKl4sMszzp9JkuWfnQcTKgVD0OQ?=
 =?us-ascii?Q?452YedDVcPM2mTwGme90gY1qz1Cjo95Rsr2gWeYF8+b+fGDCAXK0OxqR8o5V?=
 =?us-ascii?Q?OZ7bNHM1jrPEc3sb7zRGf/31nfkl2AqVb8InZvAK2hy+rWwhZlHFQ+b68mmk?=
 =?us-ascii?Q?H6ZBSVeqgIyq4aRvaosKBP+x2CC2rFVN0hvDwODv008lky8vP40D62/TFC7D?=
 =?us-ascii?Q?tPtD+KVQgGrIXrdKPTX+7m8q9adK+6J8r9kpGgoMsI27ELUl87GZorR2o2J1?=
 =?us-ascii?Q?PUXuSaYHfqS4UVmkQKSeBJDbvf97P5GEnKwqA06CGo6+qK7BwTHFdsijBkiK?=
 =?us-ascii?Q?MGh4B9h6YH8T0G/0c+e+f7+NXUCI9w4c9G4SCr2y/jFw7C4e+e+4784uUept?=
 =?us-ascii?Q?gaomoYy2OPYNB39L1FhOS5lNawBG9+vZ4g6gbyYl5wtLjBnhKWiF/FFyCIXK?=
 =?us-ascii?Q?gsQE0cMSifzNPEbo+dxHRDBrTSAh4l3zPE4dyHfiN9rNYrSl6iNPujK1zoEd?=
 =?us-ascii?Q?iF0lSPizsvQDQfPW2ibte2i8nQoqzwNcHysJR+Lapjbz7woRYWcYgSCCEE94?=
 =?us-ascii?Q?k/C4g1TS+zjY/BVDZNVdRXbYT6uhbzVN0JhYpH7r4Ddx6YDpWpAX8ygI8oyO?=
 =?us-ascii?Q?XjcFtmxDXZWg3LFpSYAH5/dfYlhdb0eMCRQQNxesHInMLimS1hBDK7MLdS6F?=
 =?us-ascii?Q?KkQCJ9tklkXEpI3ofe4zC6d/t95fCyGhYICnGyrqgqyqmUyGD+G0kTJDmD/A?=
 =?us-ascii?Q?gRIy9Khf4GF96iN1FkMBtK6N3BmB72IGFuOJEL/O3GMp+ajQjsPFb8VcaEA7?=
 =?us-ascii?Q?2nwpZ5pm+Flyp7wJQcsoHPC5mOm6SJNIbgFECVjIOFUqdUD1BqpfhLO+UXBQ?=
 =?us-ascii?Q?ViTX3Jyw928LcHbt5qpQQEXMQVyOxduPrBMxEuzS6yjwMk97k+oAXPbAgSp4?=
 =?us-ascii?Q?BmQN+OAr9hz2MFUAVbrEILEUw1U6xvECksnIC62/CCzFxDLRRk79gQtL+EZY?=
 =?us-ascii?Q?Gt4ID8cL9XBMy3iKVYYuey5YuE2eIAuiBf5457weVxQGKliIqHVLnPDXKeLq?=
 =?us-ascii?Q?NNKNbNOxxB+4SsCsQytm2zTWmhi7vfz6ZTlUijxeBfaHyQJzs+bMptKJsmlC?=
 =?us-ascii?Q?9Mf1VYDAdd7UdJAVYQWuUggIDypePwBulRHupTHzqNT2+vkkyu3z/4lXohEN?=
 =?us-ascii?Q?powi7mRYImU42WLsnazyx+hUbX1+rFnQTUZq/bUydiLnvEipq79T6PaltVnQ?=
 =?us-ascii?Q?3fGvpn8O6frDL7Ja+5IhilDQmLItYBeThaM7b3g8A4imUCeQUq4pFVUp93g9?=
 =?us-ascii?Q?oSKYmN9XpguLKT+VhJoYMOz9U3Vf4ZigG0j/zMLnXnt8WYBWYUkfo+PADPZG?=
 =?us-ascii?Q?fJsXPV5vuWOv5nStLj/vXn51QhXPnxJ6EGUwvZRf70IEpXqaQMZ9zqA5N6Mk?=
 =?us-ascii?Q?5tYMdtATWeN668rBrPVN8K0+SDBXH83UCf1ek3AojY8Pu4Rh95nBXjhfL3QU?=
 =?us-ascii?Q?3vC0XTjj+LsM3xdZmMeRNUF65VgZiEunM+cF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 06:44:17.8706 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc2b4401-c289-4be7-f2cd-08dda4c58f86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9620
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
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index f699c8b0f7488..f56354a1a8a96 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7167,6 +7167,8 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
+	amdgpu_ring_backup_unprocessed_commands(ring, &job->hw_fence.base, true);
+
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
 	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
@@ -7216,19 +7218,25 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 	}
 	kiq->pmf->kiq_map_queues(kiq_ring, ring);
 	amdgpu_ring_commit(kiq_ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r) {
 		DRM_ERROR("fail to remap queue\n");
 		return r;
 	}
-
 	r = amdgpu_ring_test_ring(ring);
 	if (r)
 		return r;
+
 	dma_fence_set_error(&job->base.s_fence->finished, -ETIME);
-	amdgpu_fence_driver_force_completion(ring);
+	/* signal the fence of the bad job */
+	amdgpu_fence_driver_guilty_force_completion(&job->hw_fence.base);
 	atomic_inc(&ring->adev->gpu_reset_counter);
+	r = amdgpu_ring_reemit_unprocessed_commands(ring);
+	if (r)
+		/* if we fail to reemit, force complete all fences */
+		amdgpu_fence_driver_force_completion(ring);
+
 	return 0;
 }
 
-- 
2.49.0

