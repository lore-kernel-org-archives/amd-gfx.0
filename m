Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC26C982D7
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jan 2026 16:20:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 834A910E8D8;
	Fri, 16 Jan 2026 16:20:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="akb0xdpd";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011026.outbound.protection.outlook.com [52.101.52.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 673DB10E8D6
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jan 2026 16:20:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CqOdGuftRNRa6R+PcIEF/l+jDX/VelCFwOzSPo2xfLOf6oW7PiTQJtzOOqo4ozcL5BAqO2PP4Dubzw1MDfn/pZpRSCijUO9C6Oa9ov7v9+ahWsKLeJ885IGDMGZEaq60tp6vk/hmzk9COi20u2Uu60dpb4r27VEhCUlrQJFuS8sdsqEiSphBApBKWktDiBoe9HiFouBwatubqo14LDRFwsnw0C28E9h8fBFr5tSemd2i9XpYKxU99BDhto+nZo1RtD2liG6Z7rDDKejHukdDwZZB/k5WCUP9svqEOAcE9YV6VsQJKG8WDbfLWEos4VGJp4e9iFwTD4ysUauwvgvNTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ghWefmk86EBFVpdTnQGGSnuJKcmL2tNhcfTGPW9jBc=;
 b=VBTC5CF+t5jyNJZrpUYsLPuqFi4Em3xW1gsn0d9rdxQUVBJ+Eo1ui7lf16nOgsW+8RrdMrVbnIefIJSNkEjBHGY2UHCjnA6MF/F3cEbRLrYoP5ey9Z0hZuZ4/D6A9XvRd2/ndxO36voVi7M3/BodeUox0RM1Srr3UtVvkuNXY2mTtQ7A7c6hNx0/jCkWr60uWtFGkOa1JPbc57Vu0hsVeXUsVuKljSlfjv4moGVdDYuZ8/LQ6Kz7fITdX8ampeUnI5CtTE/9hBX57/oEEZcQntVoQrRUVCG7xFSlVwl3Chuw8rL3JGE5pBtvNJNgx+o0F9vjLUrJasZH4FwfQRztEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ghWefmk86EBFVpdTnQGGSnuJKcmL2tNhcfTGPW9jBc=;
 b=akb0xdpdi8DH51bry7mNyjLrO4g3D1PvK95LN4K7oMpAyyHH+k+J9jrW0EErRssQr/XNPGmEabTHte2nraBuP68TWcVDN3lDoTdBq3RVegFKpNWUptsjf8rjpBma7hf9k2tbhotLryjdgGxAaio+mBYI45ICj1NDVWC0O6/1t/4=
Received: from BL1PR13CA0332.namprd13.prod.outlook.com (2603:10b6:208:2c6::7)
 by BY5PR12MB4145.namprd12.prod.outlook.com (2603:10b6:a03:212::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 16:20:43 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:2c6:cafe::c5) by BL1PR13CA0332.outlook.office365.com
 (2603:10b6:208:2c6::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.2 via Frontend Transport; Fri,
 16 Jan 2026 16:20:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 16:20:41 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 16 Jan
 2026 10:20:41 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 16 Jan 2026 10:20:41 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 02/10] drm/amdgpu: rename
 amdgpu_fence_driver_guilty_force_completion()
Date: Fri, 16 Jan 2026 11:20:19 -0500
Message-ID: <20260116162027.21550-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116162027.21550-1-alexander.deucher@amd.com>
References: <20260116162027.21550-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|BY5PR12MB4145:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ca4426b-353f-4604-0eba-08de551b31b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ILWJ1UWS224Kn2znNnNR3H7sK9jXhxHYtt/o0I6RTrJlkSA0ugRvCSg9CeRH?=
 =?us-ascii?Q?te45bI6MdTyhG6Y7SJT6S8Xh3VuDERiB7QsSN1F0atxOiXaRRT/fcnX7JXy3?=
 =?us-ascii?Q?bgS8RFGeLNCL+VH0WhTP3UWU/XWALaxZBovgFNfKM/yW8QJpKNoaoBUsBDAH?=
 =?us-ascii?Q?LSeGz6VWOiM1h9bvM5J/KFPtqnXMk3CgP4tY2mJ+dXG/x/iz+JBXOe/o48JL?=
 =?us-ascii?Q?TIRXiMa/KpC/j63eJOYIhUPMYLGMOMWLI7yf91iKyaozqvcc48WrOXr7+JZ9?=
 =?us-ascii?Q?JlS0a71K62YgVpv4zaLIjoOFR1O/yfrcTMyL82zvMxugbxy6i1HmiobdcDfe?=
 =?us-ascii?Q?hRTjO/rN1T3jcAs2wPEK0eEXVQJgbey70NA7Q+wQnbsyBSVXs6xtc+XQQzVt?=
 =?us-ascii?Q?qJLomGx3JAlc/Zyvyr96l5JT1VH84r4+TH3Hic9mqj9G9AUI7oCg7kbDnLe/?=
 =?us-ascii?Q?xPUdwSe5+P3RPOd+skwPQWUkMtlRHhQtQmpsBIZqs99BIqYhiMSV1qwDhXhg?=
 =?us-ascii?Q?pxb8td53jPQ+aw2lPO/pbrLT9yIF3jfwfO95MR3CuLSvlvbREqqvVnZF2wDA?=
 =?us-ascii?Q?lz6sIj+76HcZEkGdU6VXbgObQrCImPYDsW8kC+wIiuU9+Nm5jK54bWAPTQp5?=
 =?us-ascii?Q?wPYz5gCstoQZEdy1ncGaa/mLTH+MNYfK/X7NWL2f6MfAhUwCMqNBHzEY1JEs?=
 =?us-ascii?Q?6XSaRhlbkwwNNeoPI1UIcnd15UQHE+LNh69XcYMCMhs84fAJ2yIKsKYl68IP?=
 =?us-ascii?Q?U9qYWx0v9UPBsCEPGD0dwPF53YejCrktyStiYh6fRhR+RUKaBTHPCOnCCcxG?=
 =?us-ascii?Q?EpmSmFMpdWXiWPaxxBgInI5dh0HMc3nro3vI1fZe8awbXFMKVeTn+ddFhnmG?=
 =?us-ascii?Q?tP9Flw8/rPLLD0syVii7skxc0cxUuRnYisdkWXmBJxzTgqxAUgi+sUqY143t?=
 =?us-ascii?Q?2ptaZbIrhuCsexj3b6JamxqSlnJ4Z313LDdvsjO39jVB+bHpjH1h/3QyDY8Q?=
 =?us-ascii?Q?TZRQkwQqjSekuv/CThSigXst4qhS2lK91DPLJLhBrXxQZhLFmlxwWzpJ6lg1?=
 =?us-ascii?Q?7bN7AcC48Uuo5rBa0tCuhelzu3z11+1mjshQ//uwVe9+lRnPS8zZ14bRkMD+?=
 =?us-ascii?Q?Fdjz299qu47kHujJemXl1Yx4qzMru+IxJKT+chv5Eben+Ls9MfjhF0wZFM+m?=
 =?us-ascii?Q?FU6RjhegtsLohdfYsOzlMB/tCv0JJ5F9Jq0Vmo9qGt0c4g8pJcvIUg7Omx7W?=
 =?us-ascii?Q?8+ViDo1hDyUx9bU8baBEO70S9+4KXei3tb5Do3sD1dnybzTS4dvJykrnrHRE?=
 =?us-ascii?Q?WTBCHjTVtI3lrBoyF6dVW+lR/Go0wSSQniyfZLc0jSgVOO1uIPkr3wp5RLef?=
 =?us-ascii?Q?QERA6VQ9bVSbjtG/hjwgB0Uv0MbYwVGvQF6KAtcPesPtiNtTFrXrSEghmBi0?=
 =?us-ascii?Q?fXD05E/3Hb5omsLUZuj9mkEqNp/GNXChceffnwF2LE3490nYe6G3IRGqzklZ?=
 =?us-ascii?Q?YCPryMcbEPyUT+00AZHduIXIyzJBSnPpdprD7PTCS/07ezwQxbuEdtLrrsfP?=
 =?us-ascii?Q?5mLk+tEtdTsJ38fj8ugMdTdOap7Fus5XLojI+bcJhNG55Qpb3rI1ZctaeMXu?=
 =?us-ascii?Q?yqM0NM+xZUgsvQZSMqnDmiIYlultz9zrchi3VmXzy3f6A0P77/BnFuzQSYsQ?=
 =?us-ascii?Q?WOqFwQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 16:20:41.9438 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca4426b-353f-4604-0eba-08de551b31b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4145
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

The function no longer signals the fence so rename it to
better match what it does.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index f2f0288b7dce4..c7a2dff33d80b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -709,12 +709,12 @@ void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring)
  */
 
 /**
- * amdgpu_fence_driver_guilty_force_completion - force signal of specified sequence
+ * amdgpu_fence_driver_update_timedout_fence_state - Update fence state and set errors
  *
- * @af: fence of the ring to signal
+ * @af: fence of the ring to update
  *
  */
-void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af)
+void amdgpu_fence_driver_update_timedout_fence_state(struct amdgpu_fence *af)
 {
 	struct dma_fence *unprocessed;
 	struct dma_fence __rcu **ptr;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 600e6bb98af7a..b82357c657237 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -885,9 +885,9 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 
-	/* signal the guilty fence and set an error on all fences from the context */
+	/* set an error on all fences from the context */
 	if (guilty_fence)
-		amdgpu_fence_driver_guilty_force_completion(guilty_fence);
+		amdgpu_fence_driver_update_timedout_fence_state(guilty_fence);
 	/* Re-emit the non-guilty commands */
 	if (ring->ring_backup_entries_to_copy) {
 		amdgpu_ring_alloc_reemit(ring, ring->ring_backup_entries_to_copy);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 87c9df6c2ecfe..cb0fb1a989d2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -161,7 +161,7 @@ extern const struct drm_sched_backend_ops amdgpu_sched_ops;
 
 void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
 void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
-void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af);
+void amdgpu_fence_driver_update_timedout_fence_state(struct amdgpu_fence *af);
 void amdgpu_fence_save_wptr(struct amdgpu_fence *af);
 
 int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
-- 
2.52.0

