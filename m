Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA43FCA0FE7
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 01:47:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5138410E5A7;
	Tue, 26 Aug 2025 01:47:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EItftmEq";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39BC710E5A7
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 01:47:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dNFig4Jq4Tr/EMOjveKTHCi+T+CMEUPHMqnUjhmP31lb9Zu5q3crXYSEjk/HHmZoCfPJob3m0DKHwwTntkQUXgyj7Vno3NDYf86B7g5Y/L2xZuAXOpduslsGJiK5w+3r+MaAhvdB2jBwA3jq2fqhJbIvgXjyZM0EjuSYIewBdx+YODAEIhK6J/B79xchBYQu3KJK7ca3k+cHzrBooqxdjHZvVGWqvdNgNoyOrJIpL7YhEBDUNCy+xHoLHorQTPsFMrZrIA3CAkjipX0HaiVIEmAVg1h+dflwSZjUkiJR6qZf7ySCycUirahbx/Qlbvf+GW/GBHeLEYzUq39E1UfK/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMrYPrxEB+QFbSs183EO/yOJethtzolfTwEwPZnihl4=;
 b=Bt3midA1aTYgXyu6bhHL/N82ngHRWny8noM19N2eNcUqrPw6pCTetg0i5rCWONbEJwkH281C65FcZGJNkrzmQSwVNbg6X8is0y1qm6bIuTBwth4Q9dlzW/E1zmpGn11QTEx/py+3haG3UodiE9Fw7IPDfX5Vf7e3NK4tz/u6/iEs8nUIcpQ9Nyeo4mfDnyYMHar8fn+JidZma/2ZJXME4vT0+6NNjHNUOtdq0BdooR1iwG9BLNGoSoNHLdqvN8FPbmu6tXmEWSf9ssLcG8R97DU3HqRtQiLj/XWLfbae5ylxEYrK1eFMVCEbiIR7WJDv5C6ucyJwV7eLb0/M9m6UrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMrYPrxEB+QFbSs183EO/yOJethtzolfTwEwPZnihl4=;
 b=EItftmEqzCI99GTUHM2dUhG0XZSNHzdHavGIXpgQzv6Qkqyt04hLBX87Fvb+Bd1yocREUb1Dh6QbtXLG4MV6+bCpasEoGGi/9qmBWMXZrxpCSJoKOmzAk7pWqUrO+pkiEnQ+vRuvD3AQXT1FKNb8Uj8pyII7UZ5KA6Jfr//L8WM=
Received: from CH0PR03CA0196.namprd03.prod.outlook.com (2603:10b6:610:e4::21)
 by SN7PR12MB8434.namprd12.prod.outlook.com (2603:10b6:806:2e6::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Tue, 26 Aug
 2025 01:47:49 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::b5) by CH0PR03CA0196.outlook.office365.com
 (2603:10b6:610:e4::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Tue,
 26 Aug 2025 01:47:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Tue, 26 Aug 2025 01:47:48 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Aug
 2025 20:47:48 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Aug
 2025 20:47:47 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 25 Aug 2025 20:47:41 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [v12 08/11] drm/amdgpu/userq: add force completion helpers
Date: Tue, 26 Aug 2025 09:42:18 +0800
Message-ID: <20250826014648.1711926-8-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250826014648.1711926-1-Jesse.Zhang@amd.com>
References: <20250826014648.1711926-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|SN7PR12MB8434:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bbc2e85-cdf9-4cf2-99bb-08dde4428faf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bThBZWw3SjZGZndWZ0syaUdGa1NzMjdDdFlVbHZIa2s0ZU5sNXZSeXRES09o?=
 =?utf-8?B?Tml2NTZxZUtOeHZBNTdaU2JMaVFySmV0NDN3YWdSbGdENVpEU3JuWUVSL2Fa?=
 =?utf-8?B?YkVBTlpIRG9OL3RoY1p4WmNTK05hWE1MUzVVcTRWdnQzWXl0OFZ2a0hQRFZW?=
 =?utf-8?B?M1dtVC8zbnAvRUxvZmtjRUFXWmljZUs2Zzd4R3RkSjZnNzJGVU5RdTJ3N0hs?=
 =?utf-8?B?T3dWWnVZRmZQaXNRbndTSm83RkF5aGpWRGZvQlpkQkV6bFl4LzN2WmZMREo2?=
 =?utf-8?B?Q1RmZVNvOVFLMjRVWm1OU3JxaE9oeWJGUnZDRUVOYUdIMStzY1ZnMlJrd3ph?=
 =?utf-8?B?MVd0U0ZRTkVtVW82czVETUxJYUFENDZ3RGNTclpQTFA1YWhXcnlNaUFJRVhu?=
 =?utf-8?B?cEpucnc2QU1pWURyUHRVWEVRWk04dnhac0lLYld6ZTh6VzdJL3NkV24vbzNM?=
 =?utf-8?B?c3FqVlYxUEVyUnlBRDBVekVidWZlc3pDMkM4WHFqczhJTWgvWUxLanhZZGpw?=
 =?utf-8?B?ditMVnF4MS9abWwxa1JpVjhZZUdlQk1IRFVSdXVVSXdOb0R0TnNxWjVqbWpz?=
 =?utf-8?B?eFErRWVWUUYwb3F0ODJBd2JaZisrZFpPYnFRWjdoL3pzZHlFR2lUd0UzVkxn?=
 =?utf-8?B?R3diTzhWbE5uaWd5MFZOVlorZGNyWk0rZ2JYQ01odGxJTlFLc25Yb2R6VlVC?=
 =?utf-8?B?V1BSaGUxSXV5ZVBwbDEzYjhLZWNKMEdWSW1QdXcwQmpObzN3NUZqYkgvVU5D?=
 =?utf-8?B?ekQ0emVWL0djNlo5Wjd2NDJHU3dRdkRSQ1VtM2RTd2ZSWFVla2xGL2JXODBx?=
 =?utf-8?B?SzB1a0R1enlXRElQUWZnTDBCY3ZMVlp2Umw2RHgyVCt1M3Mzc3Y5SGNjZkxx?=
 =?utf-8?B?VnNrdnE2Y0tvVFdjdDJJV0taOTk1VGhzSXVadkIxMkEzZHU4VTZNakhWYjk1?=
 =?utf-8?B?c0l3V25ZSjVCVWJEZnJJV3BTTUpFb2kreTJMeDBqQWJUMzlHZDUyT2NjN0p1?=
 =?utf-8?B?YVJBeUllVEJlTDBRVG9HeVRtQndRVW9IbDI1SGxVazI4U0FpMDJtSGxveHQ3?=
 =?utf-8?B?NGhmNDloajNGd21oWGtiOTIxYlZCL3l0OUVrM3ZOd0hnZ2RyaWZDb1dEY013?=
 =?utf-8?B?aE1kOHRvNmIvREs0Rk9TK1ZCQWQ4ZEd5VjB1TlQ0T3VQeGMremFmcGthSFUw?=
 =?utf-8?B?TGMyYURqc0xuMHExTncwVUJpVHdrMTlaSXdFd29nTjE3OFhRVjFQbm5ZNGRK?=
 =?utf-8?B?VXFvNWlua2l6aHBhWk4xNHZRZUl2QmloUEowVkRWejZQR05GT0VxNVRSbnZC?=
 =?utf-8?B?UkxmaFZjWEdBSUZ2VEc0R21VbjVsRW5xZUVqcUN1NHpqQkZhY0xERi9OYnBV?=
 =?utf-8?B?bk04NG9BVDRtY0NKWEJLblBWQjMwNTVYMjBHNTJEQ3FiSlBrREYzbTJIVVJq?=
 =?utf-8?B?a3ROQURwVE1XQWllUkpsMEczKzM5MTZqTDZwSTdTN3lydUdZalRBRXk1RVlH?=
 =?utf-8?B?aytsMnNyZmpCbjNBM2JMbVFKN3RXbmtCSS9mVEUzS1VmZFJrZWI4THUvTlhB?=
 =?utf-8?B?QUNoK0IrSFVueFRnVWpqMlczdUZ2REpXc3hZZnErak13QVMwWFZ3eVFseHhk?=
 =?utf-8?B?ZGQ1bFZ5VzBMTmNBYUNYOWhWNEEvV1JwaE51N2RWMmwyZ0hwZnl5d3BMYm9H?=
 =?utf-8?B?VzV5TVVPbXJwdDE1WVl0OU5jWm40OEU2YmNhTElRR0wwSEhPWkZoMWNvZjFy?=
 =?utf-8?B?RU1rRStCUVlxQjkzTzcxUkhPaU1peUlLYWVUQlQ4MUxhRkJzd1Y3ZHg3VTQx?=
 =?utf-8?B?VXVEUmNBNTlGT1d5aStwTE9NYWlPc28wdndLMmlLTmlZejZPSFZleGVoaFlh?=
 =?utf-8?B?dENwTVdHZy9KQ0w5R2VuUkxvUlNJUWIzZEg2TTBPRFF6UnpGYUpjM2ptQ3o4?=
 =?utf-8?B?VXRxTVRYK2ZXZlRNYXZqRXJhWTU1R2NLeGJZUFFVdHZnOW1zdnQ2OGNxQmVP?=
 =?utf-8?B?Q2lXRmRMcGFrNTZ5aVFldUowZXlFMm5rZkt0VmFpMW03bUo5enUvWmFPbms0?=
 =?utf-8?Q?A28a0m?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 01:47:48.5553 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bbc2e85-cdf9-4cf2-99bb-08dde4428faf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8434
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

From: Alex Deucher <alexander.deucher@amd.com>

Add support for forcing completion of userq fences.
This is needed for userq resets and asic resets so that we
can set the error on the fence and force completion.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 42 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  1 +
 2 files changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index a86616c6deef..01688bbf3f56 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -67,6 +67,14 @@ static u64 amdgpu_userq_fence_read(struct amdgpu_userq_fence_driver *fence_drv)
 	return le64_to_cpu(*fence_drv->cpu_addr);
 }
 
+static void
+amdgpu_userq_fence_write(struct amdgpu_userq_fence_driver *fence_drv,
+			 u64 seq)
+{
+	if (fence_drv->cpu_addr)
+		*fence_drv->cpu_addr = cpu_to_le64(seq);
+}
+
 int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 				    struct amdgpu_usermode_queue *userq)
 {
@@ -409,6 +417,40 @@ static void amdgpu_userq_fence_cleanup(struct dma_fence *fence)
 	dma_fence_put(fence);
 }
 
+static void
+amdgpu_userq_fence_driver_set_error(struct amdgpu_userq_fence *fence,
+				    int error)
+{
+	struct amdgpu_userq_fence_driver *fence_drv = fence->fence_drv;
+	unsigned long flags;
+	struct dma_fence *f;
+
+	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
+
+	f = rcu_dereference_protected(&fence->base,
+				      lockdep_is_held(&fence_drv->fence_list_lock));
+	if (f && !dma_fence_is_signaled_locked(f))
+		dma_fence_set_error(f, error);
+	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
+}
+
+void
+amdgpu_userq_fence_driver_force_completion(struct amdgpu_usermode_queue *userq)
+{
+	struct dma_fence *f = userq->last_fence;
+
+	if (f) {
+		struct amdgpu_userq_fence *fence = to_amdgpu_userq_fence(f);
+		struct amdgpu_userq_fence_driver *fence_drv = fence->fence_drv;
+		u64 wptr = fence->base.seqno;
+
+		amdgpu_userq_fence_driver_set_error(fence, -ECANCELED);
+		amdgpu_userq_fence_write(fence_drv, wptr);
+		amdgpu_userq_fence_driver_process(fence_drv);
+
+	}
+}
+
 int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 			      struct drm_file *filp)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
index 97a125ab8a78..d76add2afc77 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
@@ -67,6 +67,7 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 				    struct amdgpu_usermode_queue *userq);
 void amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq);
 void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv);
+void amdgpu_userq_fence_driver_force_completion(struct amdgpu_usermode_queue *userq);
 void amdgpu_userq_fence_driver_destroy(struct kref *ref);
 int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 			      struct drm_file *filp);
-- 
2.49.0

