Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43187E8383D
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Feb 2026 21:14:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9628D10E3F1;
	Mon, 16 Feb 2026 21:14:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="35Zfcybd";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012065.outbound.protection.outlook.com
 [40.107.200.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C65F10E3EA
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 21:14:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BHUYmgSrCeMLaQcUG9P9S7iclW3cEwNJUwrq7MD+Z8VoTNeTge/bHDGTORqH8JwEJ98XVTDFlA6KfEsxKrkChhFCu9AMBXAZO85jYf2TBYUglbLpLHilZXz52+o5M7NgBsY7tQWcl8ySTJ+M4Zg5CR+b6awnigk6RtxfMZS1/OEX2u6XoPcjq4wgCaFdQZnD4S1f1WFSeLZR12vL0JqY6DBMwXjynGAlFPeaLf7aKFuDZMNpYJ1YXvK1c4gCFW5Xb2SONfO6o7/rohzG17k7kgIScmPv2ms4DSuI7yfLgLHj1t0qRkKX93U+7VoNByYNfFaRfK+pelBt1/ejw31agQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2tlXtyjhRBIcxWrDBODmI603IRG+muZg4XeY5wk1+o=;
 b=CqooA+Cur6fOC66BbHefYpqKUMx9zOw8uxWk+tTAOs9Q8PhnAyVDEnetWu2ZT3b7o4oGXav1txGInD0gcrsOdIjTmubKUKMt2qT0hKZs9nxfT5EdzV1Fy4Yu5xmtKQglL1/P4g5zrPQCVKQh4tvy83mgi+r8DxJl9P8t0byFDGz+b7Cj4N2OKVWQ1MgKGVgFpuDRrb/k2ZkJbMztqp0a8Qtjmp5ighSQrp8wHeYoeteID2BBedHMPPaC/sJU4zCNZhutWUoluz5wNSoQVBi843HlR9dbw404ZuDd51wmLEa7Ai7fS/wJbyL4/gqD84PGJJTb9iRDBK9vkczRNiiW2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2tlXtyjhRBIcxWrDBODmI603IRG+muZg4XeY5wk1+o=;
 b=35Zfcybd/MKnmYAKO+K3g+5/3rmJV4bcll4OoNtgGC/y3DLx0Na6PVEZXfmztqmv5morEbNA9WCiBxjkzGeWeBnN1gkWGgB9NdM+mfZ6TLYqijWtM+wsYhvj6Sxha+8RcixTwm1ftUCypbHOlfD6U7Xm6dkVYUZ3OkHfSgX/laI=
Received: from SJ0PR03CA0157.namprd03.prod.outlook.com (2603:10b6:a03:338::12)
 by PH7PR12MB6859.namprd12.prod.outlook.com (2603:10b6:510:1b5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 21:13:56 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::89) by SJ0PR03CA0157.outlook.office365.com
 (2603:10b6:a03:338::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Mon,
 16 Feb 2026 21:13:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 21:13:55 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Feb
 2026 15:13:53 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 16 Feb 2026 15:13:53 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 8/8] drm/amdgpu: Call drm_sched_increase_karma() for ring
 resets
Date: Mon, 16 Feb 2026 16:13:40 -0500
Message-ID: <20260216211340.16364-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260216211340.16364-1-alexander.deucher@amd.com>
References: <20260216211340.16364-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|PH7PR12MB6859:EE_
X-MS-Office365-Filtering-Correlation-Id: ea8fdbfd-a666-44df-8afe-08de6da04b6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ssUf+06qOjdj8jk9On4+9u9Fq+sezh1SsNDM3/YJOC6buCfrKeK/LLhCs0Xn?=
 =?us-ascii?Q?tCq4jwFtpZs5OoUHzec6Z9V03kDJv6yDf7iEC9O9iEKfIVDHN6mgi54qsOxD?=
 =?us-ascii?Q?BwYafAwH4feo5wzExz645HQQ/Evc+gi1VFmSA6zSB25I81NxRYIATZoK5xGt?=
 =?us-ascii?Q?FM8jtMjkqxQ6hn/ppozYtsIqBNHcmyCHdimxXS5ApPmenC3/6I25ZANgWs5i?=
 =?us-ascii?Q?R0+57Cr3i9BqwqR5RGSs5B+qIg9q4us0dlQVXBDzcODnJDfnK/dIZrW8T28x?=
 =?us-ascii?Q?b80P0LDytlTxmW7WX0jFSs+HCxRzNetJQvrs369vw6ozkwWWjqpGBKegQE03?=
 =?us-ascii?Q?0+s5GmDyjrQ0BbvKaGnvi5GYs/jqJ1HU/n8RsKSG5hAk4eyZ3DbTAy84diD4?=
 =?us-ascii?Q?QkqsKyWoZQNSGviANRK6TufzrZqpIsFjGyF0zLYta/oFXhbqySxBptQ/SfYn?=
 =?us-ascii?Q?RctW18uZbzX1Y/s8keD5zoBPCBoXHfv7WSmKThvuYvUNnx2kD/hGcXamjak+?=
 =?us-ascii?Q?25Ta/9mRkDNwzA9MLnsY51NN/718mczHGLGH8jiF/1W/pp4RoeDbYmT16LC9?=
 =?us-ascii?Q?3K9JpE3UJMucQWmla6kCQtMlbY6LAp/WSESifdi4YBu4w8OrUSxbbttjHKxM?=
 =?us-ascii?Q?9HYL/Wac/sTk93hNZsmW4ekdqQntNhFv2MGvCZCO7XkiE2ldOagEozgbRWxh?=
 =?us-ascii?Q?7Ov240WOe7qfhWb0ddsx63iglgm3wZp0gq03jBEml9WCgF1IYnMNYFkH0PGK?=
 =?us-ascii?Q?BEneWQxg5d+DW1Ot+Ed72bZL/VWbBICtfEyPLRMkL0bPZJJtPCyq6pLdpQaK?=
 =?us-ascii?Q?c1w5SZkiVoUoQiIhhe1KmUGWaUDuXV9rEqDTnBtBC3dS9jY0Jp9dEL67I00C?=
 =?us-ascii?Q?v4WpG4BX+saGiA3xLgKADpsN2G1NsCti/4YrzXiFXkghLnBenYpHLYibAyLA?=
 =?us-ascii?Q?TKL2FR4oRoUnK42SgpfErYcHQ800yyjhPgbC0slukUr4doFVUFuEbx2+UX4a?=
 =?us-ascii?Q?yZkGPxTOfzT4P6f5+X3hXLXzKxgpjmVgPOwktecXOL4oB0fDJv1whRw5yMPj?=
 =?us-ascii?Q?hUQqt52gYW6/rWQxX5BTR+o2UVzq4p4W6EZZLxGPmf07tnC1Md1ZCyRa9wSU?=
 =?us-ascii?Q?+B6SLMUFao7IOBzeqh1MGjLwZVLfv/veSuTjmtI18h3xqxjBMID64CeP360d?=
 =?us-ascii?Q?/VEJYSnSH2kVt+ws3ZJNIc9pHsaD1CehK+/0OXXF/euXhNEiGrZSLrRPWzii?=
 =?us-ascii?Q?RxYWZr4j4DPnq9XerbZ/8nMEe/s5dGa6dNt1lL5AcE1R1Pm8V1Chj5Oxwir1?=
 =?us-ascii?Q?4PO/Mq+JO2gziuo/KCEt628eXaIL8BlCjSGUpFSQQSC1oguq0fFUbNLcDbMM?=
 =?us-ascii?Q?6q3ogspPMC+UmqdH3xTA3262SV4gARfqEavWDTxysJvXjoaCcVSwDITGZT+0?=
 =?us-ascii?Q?dz0RFuhs4pqQx4+O7mAuJHE7Fo4+/dgwUSH1KKukrDQPEn6LcHyNCLqSPvl4?=
 =?us-ascii?Q?FzJpnh6WqhaCBrs5phSuUse+aKwVJnGniEyV/O7dIQNpuWXmZ7DztZFN549a?=
 =?us-ascii?Q?itoP7Wz9ror0dvMdTrFNESw2eZ+CoAyLesDletTGlN+A05RPrlIaRc6QInbu?=
 =?us-ascii?Q?P4Cyzi3dWER/h/JVKkblp5SLDgU1WEDIJKxRbNAx4QvUZu9uTnnTQ9W8Vug6?=
 =?us-ascii?Q?D1cjIQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HG8QCFfx7ZxXa2q4nI8YQldRR3L+E7sBC1gDY78IFiHRI4nXPqUq+gglzSwAjI1VpiDs9UDt2xyl3+EobBUwxQVGeOWNbExlPMr43MRh3jr5iFL47+0WJwGgjivUUzd5E/O66eX/D3Vw4Xnj2n3VbgIV40S4aVgR+yd8/paft2/RfROeu3GQcyZugLb4I4gxI1wrAn8fXfjbfL5+DfaPf1qauXmUY6HAK0UbED0TKzg/3tWrUpBuJnVEp96JSO/Seu/jZSIhccmL2aEQri2thXjet+U4i9BzUfQ6B/k0RwAzK2ujdzroSWamdGcKYOSRs6SJkzV9PoijJ3VpDwiSoNyjeIBw+FpC0qDf52xM+3ErgdAnW6Ie/ivVAyFdVft5hEFaKu3GyJ3gY59M6qle+28Fhs+sRolxaFLYEthp9sTjVy2imqjeQwpaiS4I6xWz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 21:13:55.9439 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea8fdbfd-a666-44df-8afe-08de6da04b6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6859
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

Mark the entity as guilty.  Align with adapter resets.
This only makes sense now that the CS IOCTL returns -ETIME
rather than -ECANCELED.  Without that patch, this would
break userspace.

Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index cd0707737a29b..dd9b649cf88e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -137,6 +137,8 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 			s_job->sched->name);
 		/* Stop the scheduler to prevent anybody else from touching the ring buffer. */
 		drm_sched_wqueue_stop(&ring->sched);
+		if (job->vm)
+			drm_sched_increase_karma(&job->base);
 		r = amdgpu_ring_reset(ring, job->vmid, job->hw_fence);
 		if (!r) {
 			/* Start the scheduler again */
-- 
2.53.0

