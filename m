Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD82CD3C526
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 06:36:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D79B10E671;
	Wed, 10 Dec 2025 06:36:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AAl5XaMF";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010017.outbound.protection.outlook.com [52.101.61.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CF7E10E670
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 06:36:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nS5TMFJXLr1oAealOwQJQfcnCEozS3/ijbFkizr/Cnl0ZOQ38R+WJ6k5XIYytI6Dt6rlDLWDzb2g2yufp5PWG2ECeVJhZdLleQkrfESRPKqudGSojJHN6Yrt+OIAvZiCGecsfOem6N+9Zqvp9P/9a6suFEy263H/JlMYuNeqR/apbgvnD+D0UgGRITm+eIqPn6FnDUdcIPQMO112Iq0DXnvR2UNM1C7g9wpy3kVHomuUh245wNkFrSoqvs3UFHAwg0p6tktvTirkDHHJQiY0k2R09HpPavcg/lKh9aerqT6SdFsS8en4bWlLHMKSdobEh0C2E0SJdJmgYl2zTLTc4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdYZK0kLWRR8gk3mO5JjyCSB6dOsRfgr9Bzc5s6RmC8=;
 b=DZcxzzCeoHH9LmQrBXSolDC75QWEaFkM5yrR+iXCkNVTFvyFwnzVO/0gRtDdl5YHZlbcuaFsL1FhCKRC3IyH0NM8iOkw5ejFhGaFt2Jn1cYcvY/cYCxZ0KRXIICoVVslRB4tLT8mwF0GoXx0A19NKXZr79vNHAzbHX44lLGx9EXwxDVnwXXqLnc9IHKcOtSQM7kcmYq7IdSEucMsZCyzKga/IzrlHivmQvYoNJXqCTNGOMwAcqpCvcIajjlayiaDNSRf2plrtyss55U90XgCHJkv1yvlRdWJ5sqOcHzfOhmvfs6imhsPStlg8bwziFQtMrLuts7PfmnZeqTZ15yNwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdYZK0kLWRR8gk3mO5JjyCSB6dOsRfgr9Bzc5s6RmC8=;
 b=AAl5XaMFTAnH3VRFCjO0yhoz6epp9XNuzooQNaGBknk/IVE2DXFL1oAm3Sa1dLmoMGN6AbHcnwTdnnLZaCLIBpOk3F7vgtTVoIaexfPmSRBbMt8eduZryPVqmODCeANbxpvg3HIJB886AVWWQMhL8pDG4qBTGeml2XSBNAWXjps=
Received: from CH5PR04CA0019.namprd04.prod.outlook.com (2603:10b6:610:1f4::8)
 by SJ5PPF3487F9737.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::990) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.13; Wed, 10 Dec
 2025 06:36:35 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::a4) by CH5PR04CA0019.outlook.office365.com
 (2603:10b6:610:1f4::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.8 via Frontend Transport; Wed,
 10 Dec 2025 06:36:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 10 Dec 2025 06:36:35 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Dec
 2025 00:36:34 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: always backup and reemit fences
Date: Wed, 10 Dec 2025 01:36:18 -0500
Message-ID: <20251210063620.5816-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210063620.5816-1-alexander.deucher@amd.com>
References: <20251210063620.5816-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|SJ5PPF3487F9737:EE_
X-MS-Office365-Filtering-Correlation-Id: 86d5a668-441f-49f3-501a-08de37b6770d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PF1kv+eoda3fUr132bF4J/8ZlppsRnUtiFnV/7YqdGIWe5gtP8TIMH4XQJHD?=
 =?us-ascii?Q?J44KE4uvjQiCzoZkFjkVOQhLyWtWJYHExNkEio8mxvJZTyF/EQ+CE0DtLXTu?=
 =?us-ascii?Q?zTU5AO0kPNWdrKMNDBteY76/htkOCH3JyF5xehFNRhCDTXvTOsuc4cBdVw8g?=
 =?us-ascii?Q?blYwZbp/3O/Rj4kAVi2gdvmprYx/nfy2qFOqquLwT0VtiLNnPLVv/B8iJErF?=
 =?us-ascii?Q?BVJw2Bj0Ik4n0kEGLhtaOSDV8684+0CemQ2mhwPTfhXT1Ep+UObvqIT7Apos?=
 =?us-ascii?Q?UuR5KA02XsymgMAuT4WvimYUcP90WVibFXr5KwAg+loz3VN9NNI/wijjtgJH?=
 =?us-ascii?Q?6nqhM4dSo/PWEcjInex2x9MH2JV7slCmL0qV74N5pRfwvyufJMHkB/vZsGo3?=
 =?us-ascii?Q?d3N1597Vuq3JVDVbDRO/06WvmPRGFSPRhPQF8bCm2uYZmrHAraVpVdXbwTta?=
 =?us-ascii?Q?P9w9cYRM4P0nGt3a3ks7WS/mu1znQA2U8qbcr6YvkMkpW2beYWxMyXSMWeV9?=
 =?us-ascii?Q?p/uv1mjxxMiNMEW6RkLOs1ZxTeVZVoiJi3+hNR7L6+LLYS1gBo+L7tqU5RN/?=
 =?us-ascii?Q?lVFqrnJ/yTTzAtThTI5ri9r4LnidWRkhX/0Ox8m+afXhaM3iAYWSpXuzBowX?=
 =?us-ascii?Q?42CsjouhJfElfkhKn8dNSikp9ZsBDHTbxMM//3WU4Sy+460hQjDsRa1xQXfR?=
 =?us-ascii?Q?WxrzfeVn9y3HLKkH+ypw71A+y8Aac9z7pKnQVjMzozRVVN3n4shbZEbjhaYb?=
 =?us-ascii?Q?KrVvox42ji/viezbyqkIcGU0/Xnn9U5CPsiCi+cUrrqEBBV0WhtB2V6UoLX4?=
 =?us-ascii?Q?5pXgsGNMF5+Wu7yGO1eBufgwwoZWaGrziswdLHEYywx02y5SfWrX9BBpSswc?=
 =?us-ascii?Q?pPsn5RvMYHVksK/C2/utHYK9/W9amEf3/fLbWaELVqwmeZbRnBNlqPYvypnz?=
 =?us-ascii?Q?epLmhLSe/dvLwdKUoxOfjUryTAcfKK4HdzvzQMgPYFbvRKA0T9CgK4Wlp268?=
 =?us-ascii?Q?U1CKt7nnfUmWEf6PR3CbfAZZ2pQXkH9yICppANsucdP0+nb2Tfdp8eB2KAVv?=
 =?us-ascii?Q?cz4oVNI5M+5OxO+2UK3OLBwibOffXxHLjJ4nE0oqRNEUtQ7EzFCt9n9F6vL7?=
 =?us-ascii?Q?IjW47cgxIlsyCcVF7VsTbEUbw0UHGueI22Be92/c4VTKHF4It3JFwC2CDGOa?=
 =?us-ascii?Q?fZjTtExWC3IH8NXdigQbJOoYsQhklEdmE/lbUj+uWiVAmFSpGUwJpZvgFBVU?=
 =?us-ascii?Q?upxVNSH6x6hIy+G8n6ZwtGwxj/15SxjAAo/CskGXTc0qbVqS6QGg41HSYnZg?=
 =?us-ascii?Q?EU5SmFkRKrIpYTZDHyRnBiMqbrRgYlCq4XfxpIbp2hHum2kBs9Mva0u9wfqs?=
 =?us-ascii?Q?BQDn57fUFfYScyNWhmt4N5g3LFktXCdFnGBWqp7JhKnjk0WxYYvf+t/w4POS?=
 =?us-ascii?Q?Pqk8QeGdKpSCPdFOJAUvN2rS+atEU2UiyR2yvGCDE5birtHyc9tny6kLYpC/?=
 =?us-ascii?Q?4gu6KSW5hlY5plGpSQVK2lTncrYm0g664jua644XlyD0zAk7lkTeiAkvV02+?=
 =?us-ascii?Q?K40F9UTSxZkBuRAyF0E=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 06:36:35.3599 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86d5a668-441f-49f3-501a-08de37b6770d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF3487F9737
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

