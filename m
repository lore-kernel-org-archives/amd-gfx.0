Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB54C677C4
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 06:44:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39A2A10E958;
	Fri,  6 Jun 2025 06:44:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5k4uTfVt";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64BC410E90C
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 06:44:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQJrDC6GaHi37LU36nwE5nc9FFB/0w0AT9K9Xh1ocqEAy9qUy4W3nW0WEKlnh5s3H2jn1BNcHOKWrcz5MRsW6VYM19QLBxpCsTukai8MZCo/Akk53exXZLAgMDATG980E60+vi8ldtXbTfbzWMmYhOfRMbiHNKVHEdwkfZ7xIsZxqe5pyvcE06APYeRRKRAgCwLlS8pCu0HF7jRxy9+ZrbtCEWsONBDsI2VAG7zIMX31936K+VAiAp8sOAoMaETNb63lZXgHrkQ+btM4d9jxdfFwFN/PRHznFeumjhWXfDG5KxXmu/hSlmsfK0XKjZoHYmALxziCcyXik7u1wMT1LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUt9HGA50n+uOozCLjAAnnR7+rZPYN6SDjujI5jpAok=;
 b=esRlZKAVizNfyyM4eQAx2Wd8eITdeHq2ddXMD7ywY1jRR6MQIsMhG+gpdbUk94PGfzZJiy9uLqKZakTK+M6Lz9Di75PKSd4yg91g7z0RwDnwsKnp4fwUEd/oM9GfLUHEn+Ghdf86+JiXgTcZ/Lx6Dlc8OiEzn73RfCLtKqUmQKXCQXR8S3N+p3rbIJOBNiZJuFHYx1YhDO4MdvddZQGDaJdvTtLO9oyeqKSTPktLgt2rnNabvxbEqMQjNEldofnlquhPiu/BR1LsF0uVANlLS4ocgmoOkKwZzyg/1n5Vbqwz/mmFlyLqhmIikn6aZCQCz2tPVYqdFvFtXM+BjDj1Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUt9HGA50n+uOozCLjAAnnR7+rZPYN6SDjujI5jpAok=;
 b=5k4uTfVtDbSM9gb6HYO6LMDsbcCeZhK6hyeEBg2TyJkeV7VdMkg04cYq2/vEaOAFhb+JMmGOUdfPHcelOWPNrJqPVHtPp0hDMMK5sNNXFYRh294nT1yMsDzXExryI01g59pLiRP3BTpYfAw8vSEp+aY/IrLPdGVnN/plDy6oTL4=
Received: from SJ0PR05CA0082.namprd05.prod.outlook.com (2603:10b6:a03:332::27)
 by LV3PR12MB9165.namprd12.prod.outlook.com (2603:10b6:408:19f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Fri, 6 Jun
 2025 06:44:19 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::45) by SJ0PR05CA0082.outlook.office365.com
 (2603:10b6:a03:332::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.9 via Frontend Transport; Fri, 6
 Jun 2025 06:44:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Fri, 6 Jun 2025 06:44:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Jun
 2025 01:44:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 12/29] drm/amdgpu/gfx9.4.3: re-emit unprocessed state on kcq
 reset
Date: Fri, 6 Jun 2025 02:43:37 -0400
Message-ID: <20250606064354.5858-13-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|LV3PR12MB9165:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bc97023-3355-4a00-c5fe-08dda4c58ff9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qs2d7FMWHuQq8/nbZKnYTE+x6IUaZhzMloLOgljC8ZFlKuZNmRTcw7qCXDht?=
 =?us-ascii?Q?LX6g2qf871LETfQZ2NAT8fcFmX8JKkW/fKNnA1Wo+0JrSzD1dAM932CdYoP1?=
 =?us-ascii?Q?k9IvC0GvjVdxKhkF8Cp3mAHX0hl8jNMMIQQrta6skbCdmv4sS9JKod2c8YIz?=
 =?us-ascii?Q?gAGU9inL+LqKRtINThkFp1DuMspzkSGgZvMxGloFhnXNT5yKizu+5Pt7CrjM?=
 =?us-ascii?Q?31mdPzB5MMp4GeDSzSN2zzDJTsXCK7Arp8yDzmKdS6Pl7f6PR3ZkLMjgLdmG?=
 =?us-ascii?Q?td+dtWTB+Dzak1VbfnD8OQQSQYfMQMnyyF3rDpEiqWgsuwl/pX6fk1QjzCG7?=
 =?us-ascii?Q?efNXJ/SGTMDeKwdPd+9Z7CrLq7DMH14FtGGSg1IPKSmZs3dSVzj5nEXbVR4u?=
 =?us-ascii?Q?6p1dui6Dr4GjR6NS+Bg8fdjaj02bMsyiqqkFUmoQe8kGufLN/cqnflO6DUCi?=
 =?us-ascii?Q?Nw15dRF6p+cCQ1lj3+r6Pm3kNYuh0vep5DBLCe1iScYSzJzTd8oZbJoOfYJC?=
 =?us-ascii?Q?+g7KeV3hHDCQdvamWpHcuvBeBeQ8xJY0RsJ89UU+wpsb+AeAZrzhqPiBpDNw?=
 =?us-ascii?Q?QeuQPvK/0fKZGmUhSBDrM+f15MDti23rCL+X6PrM6GUiHpUWdqZkXMVGl6Rv?=
 =?us-ascii?Q?vhYCULVySpwBuADiMl8QowMgmLc1N9i+P2bF+iMUMaPIFKmgcp2zkC3uzav/?=
 =?us-ascii?Q?Or1zoQnh6V5VIhdcBewwO25xHKDVHheMiFRDtWolN1QUqVJJYXSxxlQEkFcd?=
 =?us-ascii?Q?6bPBgw9p8YuI5WEziGLNHBlztDlCRWzQRPShTahRy8pE3r/QEVfqKsC7zbQS?=
 =?us-ascii?Q?rUe5buYexBeTklXsQyu3Ob/FYG6ZGWcEhqlJ4W2UQjphoj1fdHpd5yOmMJ8X?=
 =?us-ascii?Q?GgzJUSvjQ5odL/3EqpZnqSr/BnKjtPHr5wK05xkddOqEWb0p4Hc3FiNjiLhh?=
 =?us-ascii?Q?pX21hPuf1+xwyG1Om9bAgCzKg0cbXH1FboOUCx9BWSQhir0JfVoBLTsq16N/?=
 =?us-ascii?Q?WGYnY0xiPXky1QOzNOLAM4vdtAvOw6zoZn9wGLsvb3et1p6hW68KYz14JNrw?=
 =?us-ascii?Q?lqbtGUHykHMZkb+V1wynpGW6gm9p46uGq6WV/GGgDIPuJo6Yxjq7UXKy93lb?=
 =?us-ascii?Q?JkwIj99wMAci/Odq4OkEBTzKMKa8dz9JW2aOqM/Iryw0eZ+HABrLfFh58CF7?=
 =?us-ascii?Q?8E/0b8QKnBBzJ7Dck7Re7o9ZRuwP1KT92LWbivaeqY9LL1L67zWFBwwS5YFa?=
 =?us-ascii?Q?eFZHoS4si2VSZp/Uj5m8iUXGU5IGeADEvdS/hgZj2s+AyQeHH0PTI78La6Aq?=
 =?us-ascii?Q?LTPLVcv56mY+OUyF8xV2zvKbpIh9kZHeUHEGgqvITjueh7qqsAlhh/QrOswB?=
 =?us-ascii?Q?4m5pAfKmGQZE/nzqHqmqFXjc7xX42gfGR6rOw21QVM/Pgj9WstrwG4raXqIO?=
 =?us-ascii?Q?R0oCAgJyFuuKsPwT2AF61ir4PbRB2XKo/GfN9xkglO/O5OYGmkmifsKj+B9U?=
 =?us-ascii?Q?/I++cAPRGbpep2vJLI/pRpgRIodAjpvXpMYz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 06:44:18.6235 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc97023-3355-4a00-c5fe-08dda4c58ff9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9165
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
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index d9eea11f52fec..637d261231898 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3566,6 +3566,8 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
+	amdgpu_ring_backup_unprocessed_commands(ring, &job->hw_fence.base, true);
+
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
 	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
@@ -3612,9 +3614,8 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	}
 	kiq->pmf->kiq_map_queues(kiq_ring, ring);
 	amdgpu_ring_commit(kiq_ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r) {
 		dev_err(adev->dev, "fail to remap queue\n");
 		return r;
@@ -3623,9 +3624,16 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
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

