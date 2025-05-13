Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19417C3ABC3
	for <amd-gfx@archiver.kernel.org>; Tue, 13 May 2025 02:25:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D462110E4CB;
	Tue, 13 May 2025 02:25:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ykcmFdO1";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC1C210E2B4
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 02:25:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lMeiat8VKwGapsZSELegxPkjBGzZYkvksvkBHnnmOX16E4E5zy+WOg7DkH+s6ZdN510zvf6N+gJwjeTlLmShR9bd4G99+x8mg1n0iOOSUjVxqTqdXX/S1zTqJ89RuKNw9nh7KgTZ3rT2VhtQ6aSlW1vkwwmx634dsdveIXz0OiBtveq7jv3r3DlNu//U9wRDD+3rnoBI6qtBICmILeIjXEKv1C7fgfiLn8pvfq1VJVrxgWyAUv85MgJkjyMUSXiwBOTjz8VMTT4M9LgHwY0TdcVP3juWZCWBtUzLLlIhfAv1eUHyfRA8SrK5HrovpuFjwVgvx3EeJvTwh5hdJvITsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jx/ivtudg5iyqAIR1Ssf3WhO1pI7kHwvloKMvwzeQ7w=;
 b=b57PYERHfPEnd5iiBWbA50SN9mLtcA6WhFAUIBZsy4NWxQa/f7vdb3C6tIHzcen4TbFQXauU/hny/CBQ7ZG64i2B6l/3G3sU+8+B9mA1+pQCEKrVERTxlkxxcvgYfKwCeC4mygAe35+85s14w1+8q5guN0DjYJ1bw/VRh+I9DuOoOfNgBZ5FpNQKVKE7NMCP7pjI/bMB3TSFWVR4aRIubC/Kt1mExuKwnD4OxzTmklPs3fxR7bw/53Bqfj8+TB5bEnD0TsyUYrQvP6Gd7wzURFcKJ1vQhZ569ACxfSQniOAtcztop37YCg+Y8w5auVy3nSD0KdoiRoAN9HRcraN7XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jx/ivtudg5iyqAIR1Ssf3WhO1pI7kHwvloKMvwzeQ7w=;
 b=ykcmFdO1D2duiWwuThtdI6+4kxBL6HJ22dQqKJTtP6Eh+2bPrTuVXIva65t8VCdy30cUsGfmiqTZ7gDYrpk1F1g1hbGL8svA9J1V8zAkt2nKauI5DbTIHZdP9VX9To0qpsEgRkfelsHjdceGc+K8x7PVmvadN21kAK+OLFeYaeA=
Received: from CH2PR11CA0005.namprd11.prod.outlook.com (2603:10b6:610:54::15)
 by SA1PR12MB9514.namprd12.prod.outlook.com (2603:10b6:806:458::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Tue, 13 May
 2025 02:25:45 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:54:cafe::d0) by CH2PR11CA0005.outlook.office365.com
 (2603:10b6:610:54::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.28 via Frontend Transport; Tue,
 13 May 2025 02:25:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 13 May 2025 02:25:45 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 21:25:43 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 12 May 2025 21:25:42 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Fix circular locking in userq creation
Date: Tue, 13 May 2025 10:21:24 +0800
Message-ID: <20250513022542.97292-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|SA1PR12MB9514:EE_
X-MS-Office365-Filtering-Correlation-Id: 28eec98e-9751-4772-1559-08dd91c5776b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8BqBMTTPJLk66rFZK9F7/rOoywRGwrZ1nM01xDdJtQ5xOVBS46G4jlvUpv3Z?=
 =?us-ascii?Q?DxAV8/rCiYeaNQqujpYEK/hnAG5rOxu+90JwayaVq2zPeKwTVwbJSSdV6GBQ?=
 =?us-ascii?Q?b1Nk15u0QV9y12w/Up906Id/XACR891YKNOJHz6MxEtsdMk6RX+QMITV0ETY?=
 =?us-ascii?Q?CQTbruDwLbw9gRY60hW/Y4A19F6irfegee01R8Pb0NlrWTd0r3T8VoxeoBUJ?=
 =?us-ascii?Q?fUqrcU5jV5fjQfpVFvujR9iA8bFMeEleQRx3Q0z8fWXMbW+vX8xd+TracbAA?=
 =?us-ascii?Q?3Otya9zApJQgWWOmVRHN5R7TqWDi3w290MK1LIP4eukZYe8mnW1CkwNwGyZm?=
 =?us-ascii?Q?S5XX0t7uCxOcKelsWtOTFh1EC7S55OxnLmBYKF7zx0OHV0gaHNADASXTby7q?=
 =?us-ascii?Q?I1dMEGYX7FAruF/cbj51i7slHlvnVD0dhl/2ZPZ364GzkBxFUyfLhWqx1UQC?=
 =?us-ascii?Q?7v4gXTFD0NkmKgcCnYO2R7x1FJ78xJDAdf41D8r7EruzxAGu6io3G+FJtTZ0?=
 =?us-ascii?Q?BUClGy2qX/HE5DyV6Jf2ZbY01e4v82BoanA2DwmJMttj6rrAsNQlTC8Hs0Lc?=
 =?us-ascii?Q?9Z0ya2XuNfSzGh7XZgHlk4qrE2NWUZa/UJxPT2sQv5vHdOJVsUOcskL6E/OJ?=
 =?us-ascii?Q?RNsZw80vYX90bcLofTSiuqReJs164n8T3cBClgxg657wI6LNVj+7yWlu9LXB?=
 =?us-ascii?Q?WwJ9mQy0o73Ujm2rK4Q87pmLUbsmsRE0IkM6XxPpkVDr0BZJTD+a2w58Imh/?=
 =?us-ascii?Q?EvgTxzcE+QDa1L2Efs/3nC+KmYp7P5SeeLxsxwlQHzrsmUrEMIcZwOfp6zb0?=
 =?us-ascii?Q?tTIccr8G+/q2BmpNKUEgJ+l12U53HmFxjOONGoEiRuccl+Ru0RB9VP+msHuV?=
 =?us-ascii?Q?c+Iiw+A9UQV5Y1+tdViooaRdyc3ipa4PICZs40PI9/65bOlUROkhq9agY6XW?=
 =?us-ascii?Q?91tXqDf1OGw8Me2WtBMdByrJSd7WyOGUnN9iosPm66Qx2ckKj3wieyFCMUrU?=
 =?us-ascii?Q?n/aCPV4XpIzqPPP0KxVijcgP/apSXwfbYWyZQ/gUxDRzy8mXKhiBN8I0KTvy?=
 =?us-ascii?Q?gYcfXNoPP0vVShWu9zq4dTe6Ft8KnKbfTRe5CdcUnmuIJ8UOarlgaJQdTEX/?=
 =?us-ascii?Q?dppwvW2xhuBBNoXvqs8jLnVouoLD4mYMChA8jBzmiEsWJbafYA6RonozbCeR?=
 =?us-ascii?Q?jvf9LHGcyXtbeoqSz3GpXA7183mPqQxGSBZviHFufHFu6KiI+eyZhvzcmxgF?=
 =?us-ascii?Q?rjDngO7NiYDnmxdjjIBU9cSVQpisSCJze6SkDkLpb5OOO9ZJUfWLJaNuOpqf?=
 =?us-ascii?Q?q5B9JdNfxMpLjMeyYPqPD6mBi3XNMvg8rUrJ475Qu3KVyJmtXdgdIe42xJbh?=
 =?us-ascii?Q?MwkOPsjVGbrHRegAyQ5qHIyNTULUlKYNVTWZgzhadaMUDpp2eEiiKXI59v+N?=
 =?us-ascii?Q?Hn7zUcukYhteJ71MdkXRLewJ93EruAEttrYvf+f1k+01em+Mo/IetLDX8MYM?=
 =?us-ascii?Q?/BiCY4FUEFGQSpW1Nat68aL3pcHeRazMOWAI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 02:25:45.4006 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28eec98e-9751-4772-1559-08dd91c5776b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9514
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

A circular locking dependency was detected between the global
`adev->userq_mutex` and per-file `userq_mgr->userq_mutex` when
creating user queues. The issue occurs because:

1. `amdgpu_userq_suspend()`and `amdgpu_userq_resume` take `adev->userq_mutex` first, then
   `userq_mgr->userq_mutex`
2. While `amdgpu_userq_create()` takes them in reverse order

This patch resolves the issue by:
1. Moving the `adev->userq_mutex` lock earlier in `amdgpu_userq_create()`
   to cover the `amdgpu_userq_ensure_ev_fence()` call
2. Releasing it after we're done with queue creation 
3. Maintaining consistent lock ordering (adev->userq_mutex always before
   userq_mgr->userq_mutex) in all code paths

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 697dd3cbd114..6ba3c0b14279 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -531,6 +531,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	 *
 	 * This will also make sure we have a valid eviction fence ready to be used.
 	 */
+	mutex_lock(&adev->userq_mutex);
 	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
 
 	uq_funcs = adev->userq_funcs[args->in.ip_type];
@@ -594,7 +595,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	}
 
 	/* don't map the queue if scheduling is halted */
-	mutex_lock(&adev->userq_mutex);
 	if (adev->userq_halt_for_enforce_isolation &&
 	    ((queue->queue_type == AMDGPU_HW_IP_GFX) ||
 	     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)))
@@ -613,13 +613,13 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 			goto unlock;
 		}
 	}
-	mutex_unlock(&adev->userq_mutex);
 
 
 	args->out.queue_id = qid;
 
 unlock:
 	mutex_unlock(&uq_mgr->userq_mutex);
+	mutex_unlock(&adev->userq_mutex);
 
 	return r;
 }
-- 
2.49.0

