Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF226C3DA49
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:01:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2406410E861;
	Thu, 25 Jul 2024 15:01:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fnJuS6fZ";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2939210E850
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:01:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N2GqW2jAB2yajkJNOpm3draU+4pXVXELA7YLr22V+5qcaDKo7ejGfOr/agflBYvLl5l+rpHzYIHTXiUygXNZRirXsd4+zK3OQNNGCVHjWYKuBuDN9dWY6SdnJyJ1LqfDx1fNd+VdilOHwUYrJHfkKS+P3OIeOzzDRW77H8pXnvjJHmr6VDT/JhO4Wgzw+6EfFKIWThItZ4kPFIL1c9D1TcprxELwFIb8YlVrmwJ5nJ7d/7ZRAimhhG6b+Zxct243A+BduAz0rmM0ZKYtYYHbD8WP6qsSn9rx9bSL0Gczf7qvrnbLL7gB15imwVPzPczL2F2jlTZ0IWteK/dhSWhxrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6YixcA9bd0nc4wPHXzbcKiktoEcfmgisqPzXrMZyWo=;
 b=x8uESSY5f1bpgssa9rEY43P3BH4E9vxnETJbDFwMVqQlYFjnCaawhjtzcbXrf4TfIb5Jaol+9ceIsKWBgYsmYOxZ3Nynhond+mNvXX7i7e8Gge4VJ6/I84/dnmPaHfFD5KcUG2hYawczcBdjl4GJ2HzjL2wYU8fWsFBU7kNaH6gEO4hE7KPFJpDOpTEAB5F2SoxxF+STOsHO0tddCusi+PAwuLr5S0BuRSOy7Z1z+nyAT8Pij8BBdl4X7efBS+9hGGVo7j0SUfShbPzZvlwcsvqJDNSwmXTe3FqqZThD6qOdWsaQHwxe0Wa6SzdD9SFIr3lODvLy4pDULkD5/fTPNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6YixcA9bd0nc4wPHXzbcKiktoEcfmgisqPzXrMZyWo=;
 b=fnJuS6fZSPhPAX27Ep1uuS5TzrG7kSA9NITQ3gjwILxYmOGYOPQXZoKO85X5koQUge/+GgbKHtEdkKn7lB2+n5l0d630LmF3pdvSYzQBqXMZlHc7ZwAC2SyHL13D+NU75E6BfHqU2+Ck0/NGvdVT2nYWWOYZyLQj7USF6nLxoaI=
Received: from PH7P220CA0096.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::25)
 by CY8PR12MB8267.namprd12.prod.outlook.com (2603:10b6:930:7c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.24; Thu, 25 Jul
 2024 15:01:19 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:510:32d:cafe::a5) by PH7P220CA0096.outlook.office365.com
 (2603:10b6:510:32d::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29 via Frontend
 Transport; Thu, 25 Jul 2024 15:01:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 15:01:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 10:01:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 10/53] drm/amdgpu: add per ring reset support (v5)
Date: Thu, 25 Jul 2024 11:00:12 -0400
Message-ID: <20240725150055.1991893-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725150055.1991893-1-alexander.deucher@amd.com>
References: <20240725150055.1991893-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|CY8PR12MB8267:EE_
X-MS-Office365-Filtering-Correlation-Id: eff54f06-2d09-43f8-fbc6-08dcacbaa36e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RmWDkdQkmYhI9TME1naTbSs6rS1V80jelH4KpsK2fXL7QktBvNK7jbJUkmVj?=
 =?us-ascii?Q?GQfxMoD39FAZrrh+mIR893fcsAVkf7rX//P6P7ScO0MAN33XTU/RQ7p9NbdN?=
 =?us-ascii?Q?tPpQhSNBvAJuRK+K8q9aQ/fDRDgvFHIj4uVvcAN7IA5NTUPnE2jJU3GrdheE?=
 =?us-ascii?Q?a3uDGtLgQIgrs0ImfROvyC5+XRmlPQknbYzFO6wFoiAZnYl9QG4RzzEtY1U9?=
 =?us-ascii?Q?a1SwwHWR5VBMIt0/mYdFl7YihErHHTicKeRHu2P7T8a2a9z+QKz40ZMCxaOX?=
 =?us-ascii?Q?sDg/2fidbKdhzFJi4tu/pnm2F8XZ158eSjluxfNE5d0HrubxWS/Nr49I2Hmv?=
 =?us-ascii?Q?xyYaMzr9WDf2cvtiwGFA2KrSVi+BiCviHh5blhxfkWxO6KI9MvCvLyBDVfTZ?=
 =?us-ascii?Q?Da05XwOnErwOqZmTSKyF2RzEx8QaWwI//FmxCAN39ucdNyJ2bmsjR7O0YNN5?=
 =?us-ascii?Q?stUuZyJQfAq4tG6SZYFHwduawzTUDkJT5g02jAnBSKQoSCsAO+RqOK/uR28C?=
 =?us-ascii?Q?vuc/xdgadtiPAhZjKZujZDHzJo5ttl9mkCdagW2YyFn54gbB9bti+MohjQ4c?=
 =?us-ascii?Q?mVuk1PL3IPlmewPYcJgZSB8vxWJkfrZKpcvkl2WGc7G69rYRSqv3HT5Hk1cK?=
 =?us-ascii?Q?inBpWlAdK70M0t1eDqERVIvo8bm+ZxP0wHd3COL/NLxbQ79VIt3AlIE5URpH?=
 =?us-ascii?Q?WLsoZRSYm4tLI++/ldFucXkusBn7v5K9vXS7upVLKqKxcm0j5ukor4qhHnnZ?=
 =?us-ascii?Q?DruvSxuhpNUQTUzouxzWPQxD2tJ+8wafdDl5UyQVAEniLKB+MPbU30jo+Xsa?=
 =?us-ascii?Q?iYO4/7ZAFSAFM82Dx6CJ3dxtXD8apMDbzkb7lIi+OPa/l9xw5YJ1JhDBdfYn?=
 =?us-ascii?Q?XkL7Bif/eAMRJFdPRvUDwGl6B5Rut3b0jU17tVrVBmPSvK2abx5yrfJmwTST?=
 =?us-ascii?Q?gPr2v8uYKQ6CH0KNd/yQZmdlBc5iZ3JaBeGkCnDs8clzKS/objwYbvXexkVH?=
 =?us-ascii?Q?0FYS71nIOCuHdvqqQNs7IK8E6wt9QApV9V+TyhhqfcsvGT24jDKoKNmq1UCG?=
 =?us-ascii?Q?c5AQw+6SbtNk2AlzZGWYWGOIXhtNYspswBnnNIvRdVsXmhtJrdtj9bW+IW5G?=
 =?us-ascii?Q?H2VHvaLlqiOr39V5n8SqZe5woPuVzWV3UPfYpDRlQQid2zx9fGwTsnsEwqI5?=
 =?us-ascii?Q?4gjDEAuClwTYBn6hlWF0Mn8Ubcv/UtTkf4aklDx95acmeEh/ThdF8jxzBEml?=
 =?us-ascii?Q?c3LAWQXh/Hd/U0bRr8oKUIvQ74IAbkTUfec/l+RIMYPOdkclYD0Jm0ipCxVg?=
 =?us-ascii?Q?laW/OpTdyy3k3SEqVVmHOFRPdxI0uyNXs64ruKWXoj2Z4MAG4jOPzj/qv55d?=
 =?us-ascii?Q?CiS65RuQXTP1ptwS2Q364vreH0yzt+j+VJVfOgLAMJbrMcgrDLeYB+9/8BHa?=
 =?us-ascii?Q?R1KAI5lWHwJci4tYnSY3nf1joUW721Ky?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:01:18.4371 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eff54f06-2d09-43f8-fbc6-08dcacbaa36e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8267
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

If a specific job is hung, try and reset just the
ring associated with the job.

v2: move to amdgpu_job.c
v3: fix drm_sched_stop() handling when ring reset fails
v4: drop unnecessary amdgpu_fence_driver_clear_job_fences() and
    drm_sched_increase_karma()
v5: rework sched_stop handling

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index e238f2832f65..c104768cb787 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -72,6 +72,25 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 
 	dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
 
+	/* attempt a per ring reset */
+	if (amdgpu_gpu_recovery &&
+	    ring->funcs->reset) {
+		/* stop the scheduler, but don't mess with the
+		 * bad job yet because if ring reset fails
+		 * we'll fall back to full GPU reset.
+		 */
+		drm_sched_wqueue_stop(&ring->sched);
+		r = amdgpu_ring_reset(ring, job->vmid);
+		if (!r) {
+			if (amdgpu_ring_sched_ready(ring))
+				drm_sched_stop(&ring->sched, s_job);
+			amdgpu_fence_driver_force_completion(ring);
+			if (amdgpu_ring_sched_ready(ring))
+				drm_sched_start(&ring->sched, true);
+			goto exit;
+		}
+	}
+
 	if (amdgpu_device_should_recover_gpu(ring->adev)) {
 		struct amdgpu_reset_context reset_context;
 		memset(&reset_context, 0, sizeof(reset_context));
-- 
2.45.2

