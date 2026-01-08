Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4095D1D469
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 14:49:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AE6D10E77B;
	Thu,  8 Jan 2026 14:49:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="umwGjMV+";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012003.outbound.protection.outlook.com [52.101.53.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDE6610E770
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 14:49:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U7m42enbrmyrAeWC9dqyvcAEu+Olph4D70rZRWUqlKJJAWWasqHPlR4oBjOsNK+ifIw2586ZtcoQ6HYXQahya8nFYEdilAEkkq9sSQokMZZDpjU20VnZ252CFFueu4nvKtWlV40LrdwDtZa6CFAFcvmNCNS79Z28F84OezQRDRwT5u8S2F1vFpzSvMc+vEW28six7YO4Ox4oxyjQpqchJ0BradqLL6RpcnFTJh4/ucUVLhBw+K9DYv+kpIrxm/zZ8cQJHZv3fyyW3BalAIyZJZkTDEsYVcy+uz8KKO8KG+dcHZWCF1csokMbYM3ZpFanWWN1OdHOTJImGO8HdeImNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQ/s0sgg+AfZ75VwMisDGeCCtQIyfBGRKZfUyorhqIo=;
 b=PwLj8+REKSQytezWjIqtFD1wwYLl83uOEOlmcUWJozwCFf7hcuHSfX0nqrA7lEFk/7FLU/oxuBBaDTE94Vtqirf4JHB6cCaVLhSSZMlCYH1KlMPRCfMmpRNBzLdO9HVLOtwExUQBbYZxDqFeFdZ/Fi46aRtSctv+okgeWTizV46XsXXles6ENtHvTsDAnE+PhwZAokwpCnaWYbREs5lwNcWxMoazfswI54twg7qx95bTJvaUL6NO0sw6eVh3+trArPE2d2GqB+7gh1e+sWVuJIU6eC+bguop1c7CQMGca9NMsDCGky2VcBAedkUHs899zZRfHIjVS+ezdDxshDJxBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQ/s0sgg+AfZ75VwMisDGeCCtQIyfBGRKZfUyorhqIo=;
 b=umwGjMV+4UmIdsLW+ojaIiFg740D1Eh7bg4x1NB054yGTJkVi6chFwvLrYUSbgtG+d6zWEplnj5oG9WW1KzUktY85tKxk3Ez/R7Rdg4VNXDXo+XIiCd7Z1U1gLaatcfwyuPw3MJ6RcXJhQb68n9JObgDOqb0l4i117hXMylUAbw=
Received: from BL0PR02CA0142.namprd02.prod.outlook.com (2603:10b6:208:35::47)
 by SA1PR12MB5637.namprd12.prod.outlook.com (2603:10b6:806:228::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 14:49:12 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:35:cafe::9b) by BL0PR02CA0142.outlook.office365.com
 (2603:10b6:208:35::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 14:49:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 14:49:12 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 08:49:02 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 8 Jan 2026 08:49:02 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 27/42] drm/amdgpu: mark fences with errors before ring reset
Date: Thu, 8 Jan 2026 09:48:28 -0500
Message-ID: <20260108144843.493816-28-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108144843.493816-1-alexander.deucher@amd.com>
References: <20260108144843.493816-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|SA1PR12MB5637:EE_
X-MS-Office365-Filtering-Correlation-Id: 81b948f1-e006-4a13-3d1c-08de4ec5165b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pboqGOCy3rSOaAE08YZZucw6flCPgrgTlUNIepupN9sbca4zN+ztVuW32DqW?=
 =?us-ascii?Q?lXKdKENUbGnGZOeXiFMYInsjXQLcKtA6VZOZt13/XBlpC1TPiEizilT8beU0?=
 =?us-ascii?Q?0bibATMr5isq+nFyODn5GNKt8k2vaAxi4saC0rBWU21BhSsplASJSPrgVPBp?=
 =?us-ascii?Q?2Z4XkxuZ5O/E8iLQ6AvojAl2jjKc2poU5LyLL/sMIXyM6GWM3ST3jDMd0h9V?=
 =?us-ascii?Q?1xXhqIJELiNgK+4J7aPpJZJ1VrKywMlY44cyHTx2xn0bBesvKKwa1zFTnyHP?=
 =?us-ascii?Q?o0LY+wrfblQxPo8XifY8Yq37gZwsIl/KlA5mkrX5TA9OeJaxFz70pIdR8CeB?=
 =?us-ascii?Q?CpeOQZNPKVs0AWNJJrHprjq3pWc8XGP71D//vJoYNEtbI1kGuo2TgcvOPcu2?=
 =?us-ascii?Q?Gi0OYIdv743addteidOV6xcvY03IRwpFm/ejc3fy+qolVKPYIgBT6C5EXbej?=
 =?us-ascii?Q?V8Q4gFPtXYPXXtlN8ud5MW951SM+wrwCJF/RLBogfnEU2xYGEOEsvKNcRTUX?=
 =?us-ascii?Q?071CoR7Z+wJEoAa+t1CsxMxIoR9pHqYSiRzWSxRkda9AhnF8XRYwV7auyyJG?=
 =?us-ascii?Q?vhxto7+MFJJtUgYUFlpm2wwsoDqrTxsBRaU0nRIwJFSsZjoHHJMA+dLVHDkL?=
 =?us-ascii?Q?+rflqVlSwqhedVtgDJ0Ho1cfPV2jl4vo3U9Mnm7Xx8GGPgAmUS3Rm0y+9hdy?=
 =?us-ascii?Q?f+1zn5q7TFyz8FPKlADnHN/OvrzggYO1bU13GxTfNhCgjE3JMyZXRU0oWB3Y?=
 =?us-ascii?Q?c7yhlgMJVpVYRS9KUwa/+ipVgpFi/KhkqWRNEaYzT5J+xcWbxZFKJNQjHSkC?=
 =?us-ascii?Q?epsqFRXd65/ceg3xbTDpWOmekS9SpwditUx2zAVAyJa+Y/VjlxWDw2FoeJA/?=
 =?us-ascii?Q?oLBixAOj9OTX7c33CAZDxoZF6rXyA8hrsPGNJj2Li1L89hBrid8JefQTyrSs?=
 =?us-ascii?Q?jRAeSGqKJ+/1UgI58fW5PdHvUfOI2fv6hTe2ZM9t8Gg15h0VhrNJ0h6ajMRi?=
 =?us-ascii?Q?DQvjz118YgZ2mAr9LFeniUD2ASniEJWX2Qx8NCbw4fqq3zVQJpRN1RBLtFMS?=
 =?us-ascii?Q?9kqvxbB3KUKjRrSsVCxr7qS4ybh67K0cRx2LRPQBTkP9KgKzMb6FSYVBIb0N?=
 =?us-ascii?Q?iQs4KVv2X8hYoBdc2/QPn96BzNGkZEjFkCYZsSO4B68sqgrKWepJkRfO3YyW?=
 =?us-ascii?Q?JlkLrym7nSDPnNtSj0sMAfW43np1OLnzJJgGkcJ3gNd3IaG8ovil4O9goc4d?=
 =?us-ascii?Q?W2IOw3RvmeMzEZpo4mZLY8WHPT8j8SLcrEv6hxsNMTpNB32OfXI2FqPmDaHj?=
 =?us-ascii?Q?Fob0/SBSUXSGDYwsSr3yVDIGfDmU5vlJAzdFovMoY+yZgsrGw3IXC8wA4I6O?=
 =?us-ascii?Q?orVtkeb4IQjR/4ZaNyeQKodIEMM4Q/KeZ5OT15CpIF+/YCaA+XnfrzjdabGd?=
 =?us-ascii?Q?Rz/vPqbWfqR7ONytR3hcehanSEA0T4Ax300rVAaRJTrme8g3iOFQn/Uofzn1?=
 =?us-ascii?Q?xetZhw3WYW/CKuzHUVohSucq4D1HzTkvjzvb4HdCI0sErBlP1VgAweWLdPiQ?=
 =?us-ascii?Q?HZ6/ljjGCOaH/Wq0Hw8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:49:12.3349 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b948f1-e006-4a13-3d1c-08de4ec5165b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5637
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

Mark fences with errors before we reset the rings as
we may end up signalling fences as part of the reset
sequence.  The error needs to be set before the fence
is signalled.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 600e6bb98af7a..5defdebd7091e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -872,6 +872,10 @@ void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
 	drm_sched_wqueue_stop(&ring->sched);
 	/* back up the non-guilty commands */
 	amdgpu_ring_backup_unprocessed_commands(ring, guilty_fence);
+	/* signal the guilty fence and set an error on all fences from the context */
+	if (guilty_fence)
+		amdgpu_fence_driver_guilty_force_completion(guilty_fence);
+
 }
 
 int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
@@ -885,9 +889,6 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 
-	/* signal the guilty fence and set an error on all fences from the context */
-	if (guilty_fence)
-		amdgpu_fence_driver_guilty_force_completion(guilty_fence);
 	/* Re-emit the non-guilty commands */
 	if (ring->ring_backup_entries_to_copy) {
 		amdgpu_ring_alloc_reemit(ring, ring->ring_backup_entries_to_copy);
-- 
2.52.0

