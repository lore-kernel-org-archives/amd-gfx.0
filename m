Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C06D6E2B7
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Dec 2025 22:42:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5D4410EBC6;
	Thu, 18 Dec 2025 22:42:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B+Qufrqk";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012050.outbound.protection.outlook.com [52.101.43.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 608C610EBB8
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Dec 2025 22:42:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c7MibpjXzswju3N9RJYQJehMc/Q5gq2krzc3GyfdFXDKm/XdtMxFx3Oaq8/TooSXvD1XM6S4RyJ/gPy07bni+3DVealKyZRyO1PVWw882Dgxw+yk2Y+FQu1n8v4LkYPjjAvfrXSTevW8+P4Z7TqmwTCjDtlMxQLAKzxrIapH4foV4h8AB4fHc/AySxcbWgZlZ0Jx6q8Va6ONVbwR2j9bgnwzpWRRsoLkwAw279ZCEIzWLg0IyI5ST+X4QWLDeTwXzHFsTWEq1XHrjmxIceBwsdWpDj6CLyEXuI//4G6nzAtcY881iwk0PU/NUZjO5Vks+zBarzafWyjQzXJcl1RNDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wlcKQSXdKqR64mExaG3o2nOkxmnfDYaZ/Q+/SwGnx8=;
 b=HsaHXckE4by5jGhIZV0prOkMmaBM31yMuCk9FUcOoVg+Fk+p4Ett95KvO6D6xBQndTt58+IpYBp+PMzN8hizHKKdAJN1jKJ5clVmgWmIw+9doRD1yOzMUn9qEq7NNV1Pe/BTw1rn2NtF/SFVFoPi5t3WcdmDR9juyc8Pxpp4EOZoq3H5XRg/IsaRXiFjTcgHBn1qkm1QbVdY22MazpnDgwui9IkB98x7MR5xHtXzBX13CoqJCiIOZ/G5plX2xP6zmFOfTYRrV11yiAOZZoU5fK66LOPHo74kmN+pBRRYxkCywRRmmlCY4qPv8ny2zzLH9iT9lb3YrC2y74lxNtWnfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wlcKQSXdKqR64mExaG3o2nOkxmnfDYaZ/Q+/SwGnx8=;
 b=B+QufrqkttDM1CcRfXmnbzu/zfvG9j5+A3nqJCuLUGCNe623fA00cY7OfAEGX5iXPjAtyMJmVd7ElTcH0PowKczv/q2tKHTkKLDlDhuxkCPdxkHyNJCDOohkOJqsFAqO/X1pqjOZ+hKyHZZHFffulhS1s/0wTCj8Le4PouqUea4=
Received: from MW4PR04CA0115.namprd04.prod.outlook.com (2603:10b6:303:83::30)
 by PH7PR12MB7968.namprd12.prod.outlook.com (2603:10b6:510:272::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 22:41:55 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:303:83:cafe::e6) by MW4PR04CA0115.outlook.office365.com
 (2603:10b6:303:83::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Thu,
 18 Dec 2025 22:41:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Thu, 18 Dec 2025 22:41:55 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Dec
 2025 16:41:54 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Timur=20Krist=C3=B3f?=
 <timur.kristof@gmail.com>
Subject: [PATCH 2/7] drm/amdgpu: always backup and reemit fences
Date: Thu, 18 Dec 2025 17:41:36 -0500
Message-ID: <20251218224141.5841-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251218224141.5841-1-alexander.deucher@amd.com>
References: <20251218224141.5841-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|PH7PR12MB7968:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f8c09a4-6069-437e-8e8c-08de3e86a57b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NUpHOUpJR3ptNzROZnFGTXBxYk9wSUFPUFlTcXlNVnRqY3dyZVVtYUYvWFlB?=
 =?utf-8?B?eUVvL3BRdDlUZXJ0aUlzNkhRZFR0ZVlyT2sySk9XbnJ4eFdQUkdLNFFTdU8v?=
 =?utf-8?B?aWp5NlNORnNpT0dQSnBPSzZ3NlVZR2lyN2FZL1Rob2xvMC9yNFpteDhQd2Fm?=
 =?utf-8?B?Tm9FTS93cUJDZDFGSzlVdmgzMlE2aFNhWjc3VmV3b1VwcElsd3RYNVRjNnFC?=
 =?utf-8?B?eHl5Nm5HdTA0ZGwxS2ZLVzlyODFpZmtXQ1ZvUGpTa0ZYRFloL3JuMkJ0L2p3?=
 =?utf-8?B?dWFVa0VQRHBacW1RWXN1a1hwU2tQanY2cWQvRENQcHhKc2tySGo0Y0cvbTBD?=
 =?utf-8?B?NExkN1NXRmRjd3g3T2dhVmM3MnhnUEtockJERVFybWJSL3BmN3hnc3EyM3hR?=
 =?utf-8?B?Zng3czRTcnNUdnRSbXhYemE2RXJrbjY3MENacnJ3UDBlSDhlT3QwL2dGZGRD?=
 =?utf-8?B?eE5QQ0w3Mmg4NnVjZXF4Nnp6dmd1ZEtwTzRSMHlvZzRlMWRMTGNkcFl4QVRa?=
 =?utf-8?B?V29HQ3lEd2JaNVhqejIxY1Ntc080b0RqWUFlMXFQZkpTS0N3QTNjV3RWUjZs?=
 =?utf-8?B?RTlJRjQrL2JVTkFYUVRVTFVtQUtYYTNCWmIzc3ZHTW1oczBiNzgyTzhoRnQ1?=
 =?utf-8?B?Tjcrb1ZueFJvaERHbXp6Y2d5ck9Bdzh4dU1BaEdmOHJ1WnBmVk1Kc1pUY0lr?=
 =?utf-8?B?dWhEd0tpa2l6ZFhJdEJ5WWczSnlnMWRGVC93VS9tRCtyUW83UnZxbnJMTFUz?=
 =?utf-8?B?TXFhVDVrNS9XWkRodktNOFN0OWNkazYxejRMNmQ5QmNBb3F2Y1d3WnhaZkQw?=
 =?utf-8?B?NERsMFlUSFpwa216RW1wbVkxME5CazR5OWdYcjBuSks1MzN2Zi9iVzlWRkxa?=
 =?utf-8?B?d2JYWUJpKy9JTU14NGFrejRSYURjamo1cjIxOWt6Q2YwK0lOckxnbkRKK3Iw?=
 =?utf-8?B?Qy9vc0tKTy9ORjFOSFI4YlNnNTczVVhpV2tXTHBBc2E2Y2ppbWxlbmppQ2dy?=
 =?utf-8?B?WUJkdFNSR2k2LzF0VWNJM3EreUZzalAwT0I5V0g3Q0ZmRW42ZEdyYUdaUGhW?=
 =?utf-8?B?MTR6eW9uWlpVMlhzOWYrY3RSVG1ZUlhPdjEyVXBTMDlSZFdDc0hXK3BtK0p6?=
 =?utf-8?B?RWRBNUNhMktDWjN0QVdoelo4STU5MlhLRXFFZ3RzM0RXcUtVRVdKdGx5cThr?=
 =?utf-8?B?QTJtV2duc25kVlduWjNQblJBSGVZcmYvdUhic3prSHlXTjA4Z2FkNW51RnBy?=
 =?utf-8?B?VENWQ3hmdHorcSsxRDZwQkdRM09mTDRhczhRa1BhNisvOWVDYjc3d2tKMU95?=
 =?utf-8?B?YzBxcXp0N0VMTkp1dzlBQ3BSQUlJSUMyN09FRkNvK2pVMm9meXkzNE03eVE4?=
 =?utf-8?B?dmhmR1RpQjArTnVWTzRvM1lqcUFMZG1acUFLWGJZUUVuQ3Z2cTF6V2J2bDFn?=
 =?utf-8?B?TnRlVUxWZzJqcFRYQnFqY25GM01GN1AzaCtGN3pLSTROWmNRd2o1UG96dlY3?=
 =?utf-8?B?dGgxaHBzc0swWm04QjYvSkhYZXcyb0p3SGxFWU4zcWxEZjZna2xRM1JWTkNO?=
 =?utf-8?B?NGZzUnhmaDU2MHFqYUNYUDdSNkJENnp4MHVFeDNwS3pVbnFtV0I5VGtvZzRK?=
 =?utf-8?B?U0N0aFNiTDBjdjJGTWxUWjgvdnRUeWhYbEdyakZzR0txVWNBaTdyK2lxOWFP?=
 =?utf-8?B?RU9ZVUpMekhNT1VJbnhIT3hSNDhsdlZQZlhQU0FXczZGT1ZSZkNLTVlHTFNi?=
 =?utf-8?B?UVBSVlpUWkJ6K2FoSTZqUnZzdnA5dHFRb00xelNVS2VhK1lpY3RXeWI4RGhx?=
 =?utf-8?B?NzhvQlNNRVBVWjNobWJyditsQnlLZVZXOURoMytLcWQxT09mclpKQnNQVUhS?=
 =?utf-8?B?TnBuSHhLL3RlWUJvZ01qUDkzWmJ4WXpTdXprOE0zUzFlUXhvUHR2aExUN0dk?=
 =?utf-8?B?ZmovYlB1OFhNQWlKNTFjc0pVN1Q0ak9tZm1OZThET0JXSlJwTktSTDA5cUhP?=
 =?utf-8?B?V2xrV1ZkOUxCK3I0a3hDalcwNHg1Q0ppQVdNQWlObzJaOTNFcXljcGJjZDFv?=
 =?utf-8?B?QVlLMTNlb1daYVdtMXdGTExJUmNSSEdjMllYdkxTdGNRVFoxczA5T2lMQ1ZJ?=
 =?utf-8?Q?scVU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 22:41:55.4728 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f8c09a4-6069-437e-8e8c-08de3e86a57b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7968
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

If when we backup the ring contents for reemit before a
ring reset, we skip jobs associated with the bad
context, however, we need to make sure the fences
are reemited as unprocessed submissions may depend on
them.

v2: clean up fence handling, make helpers static

Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 24 ++++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  5 ++++-
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 334ddd6e48c06..3a23cce5f769a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -89,6 +89,16 @@ static u32 amdgpu_fence_read(struct amdgpu_ring *ring)
 	return seq;
 }
 
+static void amdgpu_fence_save_fence_wptr_start(struct amdgpu_fence *af)
+{
+	af->fence_wptr_start = af->ring->wptr;
+}
+
+static void amdgpu_fence_save_fence_wptr_end(struct amdgpu_fence *af)
+{
+	af->fence_wptr_end = af->ring->wptr;
+}
+
 /**
  * amdgpu_fence_emit - emit a fence on the requested ring
  *
@@ -116,8 +126,10 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
 		       &ring->fence_drv.lock,
 		       adev->fence_context + ring->idx, seq);
 
+	amdgpu_fence_save_fence_wptr_start(af);
 	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
 			       seq, flags | AMDGPU_FENCE_FLAG_INT);
+	amdgpu_fence_save_fence_wptr_end(af);
 	amdgpu_fence_save_wptr(af);
 	pm_runtime_get_noresume(adev_to_drm(adev)->dev);
 	ptr = &ring->fence_drv.fences[seq & ring->fence_drv.num_fences_mask];
@@ -743,10 +755,6 @@ void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af)
 		/* if we've already reemitted once then just cancel everything */
 		amdgpu_fence_driver_force_completion(af->ring);
 		af->ring->ring_backup_entries_to_copy = 0;
-	} else {
-		/* signal the guilty fence */
-		amdgpu_fence_write(ring, (u32)af->base.seqno);
-		amdgpu_fence_process(ring);
 	}
 }
 
@@ -796,9 +804,15 @@ void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
 			 * just save the content from other contexts.
 			 */
 			if (!fence->reemitted &&
-			    (!guilty_fence || (fence->context != guilty_fence->context)))
+			    (!guilty_fence || (fence->context != guilty_fence->context))) {
 				amdgpu_ring_backup_unprocessed_command(ring, wptr,
 								       fence->wptr);
+			} else if (!fence->reemitted) {
+				/* always save the fence */
+				amdgpu_ring_backup_unprocessed_command(ring,
+								       fence->fence_wptr_start,
+								       fence->fence_wptr_end);
+			}
 			wptr = fence->wptr;
 			fence->reemitted++;
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index d881829528976..87c9df6c2ecfe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -146,12 +146,15 @@ struct amdgpu_fence {
 	struct amdgpu_ring		*ring;
 	ktime_t				start_timestamp;
 
-	/* wptr for the fence for resets */
+	/* wptr for the total submission for resets */
 	u64				wptr;
 	/* fence context for resets */
 	u64				context;
 	/* has this fence been reemitted */
 	unsigned int			reemitted;
+	/* wptr for the fence for the submission */
+	u64				fence_wptr_start;
+	u64				fence_wptr_end;
 };
 
 extern const struct drm_sched_backend_ops amdgpu_sched_ops;
-- 
2.52.0

