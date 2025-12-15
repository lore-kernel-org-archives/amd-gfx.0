Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9272CD5B84D
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 16:08:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 057AB10E739;
	Mon, 15 Dec 2025 16:08:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1pzP/BmH";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012032.outbound.protection.outlook.com [52.101.48.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB21410E755
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 16:08:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KfxQ/H+kIXcCrlNPIl+U4yt/Rceka4mLfwCWOrwEDWJv45O94Kll9M9GsnaAm/JlI77J0f7R1UHnYMcKjYSFrePJlQM92308qu+J+ZdDCFCw3XTsYl3NOnjwlq6UkUi1F52y8kVnqVSDYqLLZ3TiRGYzuj3i6DHijotZSn+Vy61lQHF9EA4PgM4wL4M5V0DmF7AlaXItZX2pV7mXCNoRQvYt4XfIbNV/0XXzWMg/l/Iu0857Fh8uhp/AzB+xXLJjr1isxgnoNiCPodrtAC8nsGSuDOn3h/vVH8gzThGgi99f+MWJ7LaQGQr8ip52AQXNx9wq8iCJLDDiT5VtcZcquQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0e+7mgq2vAWN/jqWnUSnVIBT26Gf0U+fv1YIvTTp5K0=;
 b=CxybsDVCt1FnZfRQbWyZqjqjkw0F53T/NgcO1Cy8HFwd+0a0zVxjW1CJQ6ci3qld9wMmZVRIJT1ImNIIbP5XSyc7F8cD+/4LV1uLdryFQy8kKkZGQLh+g5YF4vIGFcGRsawa1N1omPrV37Ex+7issSAAaB//BycubcZanDhxXiP1XUO0hb929sq+GGvVuTEc1m6/AXsytg5SjV4wwWyhq1t4PmDSoSEYrviVEcBD1IPRhmQGLvV9ogYaNijlL/4G11HULXa02bVgXpxNmmuN7jSpbfUV6EcbkYiyO30lwFCPif5Wr5wf9zNufSi2VLk2odwuric9iYkeY/8qMNOkbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0e+7mgq2vAWN/jqWnUSnVIBT26Gf0U+fv1YIvTTp5K0=;
 b=1pzP/BmH26UrjirJ2jooDKbvt6kf2mXkkaugVfwx2N/GdzkUYxNQEwT94yniQ2GTA41c48eSV5reQyAxVpkV2QRO6Pp7KUWqLtwM2ry03ypYzKKH5OCh3Gbevj6LJIMVmTLB6COGeu/EoOKabRRVBsp3iF4770800Zf495AwpUY=
Received: from PH8P220CA0035.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::7)
 by DS0PR12MB8294.namprd12.prod.outlook.com (2603:10b6:8:f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 16:08:42 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:510:348:cafe::25) by PH8P220CA0035.outlook.office365.com
 (2603:10b6:510:348::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Mon,
 15 Dec 2025 16:09:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 16:08:41 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 10:07:23 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/6] drm/amdgpu: don't reemit ring contents more than once
Date: Mon, 15 Dec 2025 11:07:06 -0500
Message-ID: <20251215160711.11832-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|DS0PR12MB8294:EE_
X-MS-Office365-Filtering-Correlation-Id: e1d5966f-6865-430f-48d2-08de3bf43761
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aC+nlrL4kms9QvY5nT/zE2U9jRCUPMnfzqumLB+a3d0GouCg+BpPPJzwpxZy?=
 =?us-ascii?Q?I5IxWAus+xrGVsadAA/6KKdKe94aZ554lE6Ow1O6wE9XZi09rJzUqWGfoBLR?=
 =?us-ascii?Q?a3YtAbifDOl41Ar46zpcp6qi4Kd0QiJtntdM0wa+JNhUAi5nfrPJIDXEylHL?=
 =?us-ascii?Q?dxz4ARCfvMGpOokSUnFzipZ8VhlQjqX0b1pK5ehPdkJzivxkmsF/Ffk+6wsW?=
 =?us-ascii?Q?IBGna4n94e4vgNb5bXl93/f96k2UJUIbbhowXzVHmgvvQz20pquQSIcjAeYz?=
 =?us-ascii?Q?98qx2bYeiYK46Qbous8Bj6QAWOCQ5mYp6s9roFy3i5n5nFg0LTnr+qVj6bFk?=
 =?us-ascii?Q?Bj/NiwN8PmrsGnOtgRAKbpkRTbvWMN1TzCJUaEJjMrz9TPJ7RtXOgXiiz8ip?=
 =?us-ascii?Q?yFhZKNJGNA4YNsQ4UMoSBdVw8z31WkDi6GC6oiaZuVbh77QiN7KNXCRUi3hN?=
 =?us-ascii?Q?f2gqSj5N4e0K77r0svTsEPsj3XN1mSThgzZRYkA6mGL6Hjw6WwHKYhYJv5bP?=
 =?us-ascii?Q?4wo5eRVBiaC7WNBUuorfKcDSD5jcWG5iyoqiG1yubw8bVUqfdGsRUwH7/Q2j?=
 =?us-ascii?Q?wT/tSNS9QhaxdHgWDjBsjLJCLiBoaoG7tzE36v0MM5/T+C1XWojLhS5GxdD1?=
 =?us-ascii?Q?qeCQ99amtRNYEgj8wl5AjqfTolegg84QlPvqrzdZtUAQ8/ODlNHHNuMPNlZu?=
 =?us-ascii?Q?Pi5mZA1jKTAE/ggc60UnGV8/6WtzWCydjm7703cp5xZnTUUWOwKc4phvhxWX?=
 =?us-ascii?Q?tW5aYBjJpNMjJqbv82MiYXoa/+HCz2jmOvMWGE78sNRdhrUY+4tdXmisNVWT?=
 =?us-ascii?Q?TD/1T5ka1R49VUiJ2GAAR/tQiE15+7LI5KMMGeOZQGWXWHX6RJanLv+Phw3V?=
 =?us-ascii?Q?QRUr55JuJBrKcOSQaGxDniLQpoiExJiaobfKO36OxB6eH1YYikuH0AaeGCKX?=
 =?us-ascii?Q?tVcITmTSgYfs4kRE+WBlYSYPy1mYYyuUIZcUNcZlMPXKB4QTUhoIF/Jj6oaS?=
 =?us-ascii?Q?eSTCIkcYYHQAPM5ged+UXBLzbSaaC88+BVDIpChoKbXSxdbgD2yek9IraObu?=
 =?us-ascii?Q?HC/AdNWozQmeN6sIgY+6xqTkymECxx3oJq/AM/hnhhEAEijoEhExSMy+5AmR?=
 =?us-ascii?Q?iqSv91HDr6esuNky+G3vWgYnUNYiMjJrH4uxt6cw4Yhhx5TMNVmfEFgZNRMj?=
 =?us-ascii?Q?D540prMHo4qypdAElmhE8CBM3pTCBidD2PixuN+bL7Va2XWDgdO8R3/+9SA7?=
 =?us-ascii?Q?QC5ZL0MpQYxiEUexgELNRI0x61w7vRroE3aZj0hNoUk8KD9dPLDXFEWiGLZc?=
 =?us-ascii?Q?SoT6TmXP0+tUizbtHQ4enRojKPQMe8JlL1OUl+yFlI+66+XAQIANycQXTwkh?=
 =?us-ascii?Q?oyDr0y1BoEIf7hHfABpY3iNW7PvUXDB+rE1N+OQKg0hvUiuRz2GuVaGo1DuI?=
 =?us-ascii?Q?iNN1Yg4qz5lcQRT7GlATQUn7HTLp3rH8l9EvTwPNFgsJotOv5+jTxo0O+dHb?=
 =?us-ascii?Q?4GENq3mhmYVhCww3wggCyd8+ZcbHAj03mwMdMT2V8FGxjsRnCH8d9eYg+m5F?=
 =?us-ascii?Q?a9jqNDXnNCzxWnIMtV0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 16:08:41.9498 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d5966f-6865-430f-48d2-08de3bf43761
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8294
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

If we cancel a bad job and reemit the ring contents, and
we get another timeout, cancel everything rather than reemitting.
The wptr markers are only relevant for the original emit.  If
we reemit, the wptr markers are no longer correct.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 22 +++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  2 ++
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 1fe31d2f27060..334ddd6e48c06 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -710,6 +710,7 @@ void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af)
 	struct amdgpu_ring *ring = af->ring;
 	unsigned long flags;
 	u32 seq, last_seq;
+	bool reemitted = false;
 
 	last_seq = amdgpu_fence_read(ring) & ring->fence_drv.num_fences_mask;
 	seq = ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mask;
@@ -727,7 +728,9 @@ void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af)
 		if (unprocessed && !dma_fence_is_signaled_locked(unprocessed)) {
 			fence = container_of(unprocessed, struct amdgpu_fence, base);
 
-			if (fence == af)
+			if (fence->reemitted > 1)
+				reemitted = true;
+			else if (fence == af)
 				dma_fence_set_error(&fence->base, -ETIME);
 			else if (fence->context == af->context)
 				dma_fence_set_error(&fence->base, -ECANCELED);
@@ -735,9 +738,16 @@ void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af)
 		rcu_read_unlock();
 	} while (last_seq != seq);
 	spin_unlock_irqrestore(&ring->fence_drv.lock, flags);
-	/* signal the guilty fence */
-	amdgpu_fence_write(ring, (u32)af->base.seqno);
-	amdgpu_fence_process(ring);
+
+	if (reemitted) {
+		/* if we've already reemitted once then just cancel everything */
+		amdgpu_fence_driver_force_completion(af->ring);
+		af->ring->ring_backup_entries_to_copy = 0;
+	} else {
+		/* signal the guilty fence */
+		amdgpu_fence_write(ring, (u32)af->base.seqno);
+		amdgpu_fence_process(ring);
+	}
 }
 
 void amdgpu_fence_save_wptr(struct amdgpu_fence *af)
@@ -785,10 +795,12 @@ void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
 			/* save everything if the ring is not guilty, otherwise
 			 * just save the content from other contexts.
 			 */
-			if (!guilty_fence || (fence->context != guilty_fence->context))
+			if (!fence->reemitted &&
+			    (!guilty_fence || (fence->context != guilty_fence->context)))
 				amdgpu_ring_backup_unprocessed_command(ring, wptr,
 								       fence->wptr);
 			wptr = fence->wptr;
+			fence->reemitted++;
 		}
 		rcu_read_unlock();
 	} while (last_seq != seq);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index a1fb0fadb6eab..d881829528976 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -150,6 +150,8 @@ struct amdgpu_fence {
 	u64				wptr;
 	/* fence context for resets */
 	u64				context;
+	/* has this fence been reemitted */
+	unsigned int			reemitted;
 };
 
 extern const struct drm_sched_backend_ops amdgpu_sched_ops;
-- 
2.52.0

