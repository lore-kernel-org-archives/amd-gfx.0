Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 177C8C3ABB2
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 04:20:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C0B510E57C;
	Wed, 28 May 2025 04:20:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0CvmAWFL";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F08B10E57C
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 04:20:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q156iFeyi+c3y4gtGBBCX7bUdmQo7cTui7ckpTou99LxuBcapk6umbKk1dJxy3F/MGkDsFUP5/WYsTR4WT/chsNQLkeSEhD64o/bAY8UrpOkiKLr+D++Rg7RXogE4/6B4x5DD0br0V/TNO5Gk7KvgDggSH0t/+e1hvRB3p3PGhSfQ/0dhEWHP3IEyprOduDtUaip5QE7kYED+XZwAV7+T24nht2liUKE4wB7z7l2/am2oPTW4xbVy6o1aGKt+VQxM/PmGIRTYCQ0TD3GJks0vkuKgUWSkeB3KJe3SegCbZky1rj49Jcjm/8M2ax934UW9Z492lhLiriEKJS/j6T4Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/niIq6kZHuHpJB5Ue/wsc0r+pm/2tpuhWdA/QkEZA4=;
 b=ney//n8pdr+Wtl8OcvgvgUwu6KW6wywzvmdFxkSmiNcTnd3UJbByk7JgCtBClFAYrDn4MJ/x6wLWBsZb7JGLOEq+6oL+V0QGkalgQqUru1SoU/sESPe2TZhktSROHGDucmG3i79cloHJyjeCycZBga7G85lHme6EtmjkEu74e+NO3JgX3WO3rQa2OY5Mthk9qojM7Cud5ZPaCvYbRdV6aft5wPFcGIaqjwFJMsv9NG3GWvz03vUcMRE7/Dt0/xapNxstPBS0aWgUIjzUgEvdFApfV7NvS9hZ8oTdWPFGulay/HLxjdyTnf5L9h9uldjlbyDzzE0mkMmyMsmn0wctQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/niIq6kZHuHpJB5Ue/wsc0r+pm/2tpuhWdA/QkEZA4=;
 b=0CvmAWFLh30lbst0yrxTaPHmwoa8hIlBDmeOKxIj9Obzzfj1/gTqk44/qvabvIdCDeQkGfHy8bdEnPI+dbixDq1WxKu7XeJLPt8IobuVHqEEsF927ICiHTStth/guJyAC86DHm0gMRFhmt7UdFX/2HXVVtHWzh5eony78RyYtxo=
Received: from CH3P221CA0030.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::31)
 by CY8PR12MB8411.namprd12.prod.outlook.com (2603:10b6:930:6e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Wed, 28 May
 2025 04:20:09 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:610:1e7:cafe::e4) by CH3P221CA0030.outlook.office365.com
 (2603:10b6:610:1e7::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 28 May 2025 04:20:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 04:20:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 23:19:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 09/19] drm/amdgpu/ring: add helper for padding the ring
Date: Wed, 28 May 2025 00:19:04 -0400
Message-ID: <20250528041914.5844-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250528041914.5844-1-alexander.deucher@amd.com>
References: <20250528041914.5844-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|CY8PR12MB8411:EE_
X-MS-Office365-Filtering-Correlation-Id: 75e6ea02-d0d5-437a-0a11-08dd9d9eeede
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2kgObm38XLNX3udnwhOAEo5IYakAqrEAtbpbcNjGzzfnU/5rRaiLbauOCFyC?=
 =?us-ascii?Q?0+kk06RIfVDZ+1EQmwysOholBlaznaOX03oqG4fjwxji+jxxPEAQY7KH4F2P?=
 =?us-ascii?Q?zLsKZ6PQ39ypkQgqVik5GLoOGUP74g3SEjmPmTFRoaZtU2FbZgu3XGqvQfso?=
 =?us-ascii?Q?t72BHKthFmNniKleXdNR9CFbY7MTK13d+bcaS2OXIIagnEF1mDI1iGOnzqjZ?=
 =?us-ascii?Q?iOC4FZ88kaYdabMuTST1ywbA2pqlE/wbAKBLkEwo0AkKAa+jLjjffiSHNBqc?=
 =?us-ascii?Q?4pE/0SXxxtII/gupRQEXrqCFracgiVtyUb/u1ygZdq5VUP9RL3Bic4FA+fWD?=
 =?us-ascii?Q?AUVO5GWI2Nb9lyiYJ6SUzh55Qqz72ezyADROE2Nhe8vGXorD8E5zbmO+8Jjk?=
 =?us-ascii?Q?lK9oSJC2xa8hBowjDPga7MDzTMkuXfaEVKkckII63V3o93CARnTcekj481bi?=
 =?us-ascii?Q?s8Mrxj6Un097XwGTn2ej21rausipo3LR8NtbTbwMPJaxTv15CjJkYnoU/D9e?=
 =?us-ascii?Q?MJvR4Aff55HoVV1icDJy+n+TUvRVzGuFzm72HD57fm7Jwlo+xy5Jk+OXgktI?=
 =?us-ascii?Q?76Ej7GW9zO73xEyBuSYzagWy0wqh7oLqDDXDKLT+M6Sm2KEa+5Aq/wU91Ahe?=
 =?us-ascii?Q?7AkZwwl+wCUp0b/ub39VTFiDxQkmvxoT6k1Xsb3ZAYpeHqaV4xFEPsBQz+Rx?=
 =?us-ascii?Q?f/o/uAWvs7jm0tKNoVtrjhW7oOvoL5LknyEqI5hX66WwCvFv5QYQ/s+cBcob?=
 =?us-ascii?Q?cEzfAAEdzwW0HsKahv0CVJrESQc7RWehNup8ztt24mVkAkA2g+I3ZN8jePIG?=
 =?us-ascii?Q?b8kLYEqC9VrLF62WYSYUEjKYt+fnCBQHk/tRPFIwHmUdOA0GNExArLo90waD?=
 =?us-ascii?Q?C1V3ylSWxH1/lbvpgdCwyHuHYRerFgxf0IFzfq16QymnS5VWvWRZC/J7U9om?=
 =?us-ascii?Q?osD1Z25DilPtisFBJ8XyWTlHs9cAjbpBWsRPBR7yBRaFecdzi6QErr00IvVp?=
 =?us-ascii?Q?WwXJ08QQ2zCyqiUGhVLD08W0jQGClzoIJFm20s1fY8LAMCS99XllimrXqe8o?=
 =?us-ascii?Q?3Vj3MDG3JpClpuj6HFm5o3ix5entY7tcojSav4qMSHwVmQeyGShohX1RXo2q?=
 =?us-ascii?Q?/xcX+MTrByYcJHGfCQLRKs0vfsSr6FNzqwEqJcO+gAweJj74GsHV3JfBHzSf?=
 =?us-ascii?Q?EHcnzurZzHady2llXKRYsKvIS3bl5YGBOT5moW6sN0KdTCbBga63mQ1R8XSi?=
 =?us-ascii?Q?tF2tymh+tBoMZGcCr2/rBeRKmtu0Xy9ADD2zmXbn6Z6UhmVKLbHveNr8CUVQ?=
 =?us-ascii?Q?N6kHz7K8LUkflfhIVOQ+WkwDxp///XU6O058ucGBqy30hPa/2zL51Elw10jr?=
 =?us-ascii?Q?9Rf9qkfZOFCt3MwC6xRUxjDel+49bS2QHxFoPC9yo17lHvyCXWmoC15RWZLP?=
 =?us-ascii?Q?1FfFq5LAOvvqt7GUMhvBZ484+gBM9Nt3+ANLDO2qJgJz3lx7Eo0zI2mvBNHW?=
 =?us-ascii?Q?Vsv1QWDMTg6H9O3aYcdl1cDE23GbeI+wwRaB?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 04:20:09.3593 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75e6ea02-d0d5-437a-0a11-08dd9d9eeede
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8411
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

Add a helper to pad the ring to a multiple of the fetch size.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 29 +++++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  1 +
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 426834806fbf2..6a13ef9145447 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -141,21 +141,17 @@ void amdgpu_ring_generic_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 }
 
 /**
- * amdgpu_ring_commit - tell the GPU to execute the new
- * commands on the ring buffer
+ * amdgpu_ring_pad_to_fetch_size - pad the ring with nops
+ * to the fetch size.
  *
  * @ring: amdgpu_ring structure holding ring information
  *
- * Update the wptr (write pointer) to tell the GPU to
- * execute new commands on the ring buffer (all asics).
+ * Pad the ring with nops to align with the hardware fetch size.
  */
-void amdgpu_ring_commit(struct amdgpu_ring *ring)
+void amdgpu_ring_pad_to_fetch_size(struct amdgpu_ring *ring)
 {
 	uint32_t count;
 
-	if (ring->count_dw < 0)
-		DRM_ERROR("amdgpu: writing more dwords to the ring than expected!\n");
-
 	/* We pad to match fetch size */
 	count = ring->funcs->align_mask + 1 -
 		(ring->wptr & ring->funcs->align_mask);
@@ -163,6 +159,23 @@ void amdgpu_ring_commit(struct amdgpu_ring *ring)
 
 	if (count != 0)
 		ring->funcs->insert_nop(ring, count);
+}
+
+/**
+ * amdgpu_ring_commit - tell the GPU to execute the new
+ * commands on the ring buffer
+ *
+ * @ring: amdgpu_ring structure holding ring information
+ *
+ * Update the wptr (write pointer) to tell the GPU to
+ * execute new commands on the ring buffer (all asics).
+ */
+void amdgpu_ring_commit(struct amdgpu_ring *ring)
+{
+	if (ring->count_dw < 0)
+		DRM_ERROR("amdgpu: writing more dwords to the ring than expected!\n");
+
+	amdgpu_ring_pad_to_fetch_size(ring);
 
 	mb();
 	amdgpu_ring_set_wptr(ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index b95b471107692..235af37145dd3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -421,6 +421,7 @@ void amdgpu_ring_ib_on_emit_de(struct amdgpu_ring *ring);
 
 void amdgpu_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count);
 void amdgpu_ring_generic_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib);
+void amdgpu_ring_pad_to_fetch_size(struct amdgpu_ring *ring);
 void amdgpu_ring_commit(struct amdgpu_ring *ring);
 void amdgpu_ring_undo(struct amdgpu_ring *ring);
 int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
-- 
2.49.0

