Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C816CCD1AB
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Oct 2025 09:45:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B124B10E1A4;
	Fri, 24 Oct 2025 09:45:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LRsXNGHT";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010002.outbound.protection.outlook.com [52.101.85.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E041D10EA18
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 09:45:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aLcj9ZAiGfGq88w50MJo1nrN2PXofJ5O/k0aSMiwZzArFDKrx968C5TaPltrj+S6WQHeluO0KjEW7S7Wj11K+8sniaw2TpEBvMqCdVfaWO+SPAda4JfIjZgtqzEa2G4Yp0MZp4WD8aBq2+iS5FbSJMivN1mS3i98xbkO0Q7EuRJq/2kYhV870xVPENItjbvvZIf4gQeUTqjzb1ednv0btoMtXuNtaNf7YBGjOsZ0sbOAvfVYRDqETByaLBlIlHlnDctERLoppH6X/JHT89wjxIr/V5gyBmPVXlBHlomOGmVPCGMYKxCkKHrLXiFKoMjyjSxBtpoQJFXtrfyUqP47Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExtlbcLEQ+F5v9p8vFwRlO7Jkv2XAv+mkZIkTZYvOmc=;
 b=mH/tKd0sOfUzU/JWt+v4+VAqra6UsUc6xopleMl+YAXTSvB4CTyfSLEhiMbEJ2HrfkMyE+MZbElYeTxl9eRucZAY9R1W/1EhiMKOTT2jyJLQI0VnO3JpgfH0K1NznkvlW8JhWJuRpV9kgNoO1njlLcjJ3rCCFvlIdXZ2CxeCIqJ1I/XRvDLPS7qFwG/sWvBLnJ6d2LwMpC97xFF1XSEgiAwRNlqKpGjSAtLvGes6QpZksNOT+TKfr8CEkXLcq6xlIn4kD0mY2ySeC5mVwkFcIEwZ0VTa9OdVwpstXCZRFuqoJojZzmYkhZjKXBdFdk4hU44hoASKvniQBmRF82DNqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExtlbcLEQ+F5v9p8vFwRlO7Jkv2XAv+mkZIkTZYvOmc=;
 b=LRsXNGHTjUkhQF4qgF8r94OQ9V10b3mxxxfbTAroJu7oNs2BzEhHDD2EEVKapqJShI0NbXWjeHr/o7biut3ysnOQeQLpmrWqQ8iY0fElEWHsdwrG+TVa7YLrKS2Bv+26x9QDLXPOt/mCejvu6gUmAJF/9hvLV+2E/LaLf3SilH8=
Received: from BYAPR06CA0068.namprd06.prod.outlook.com (2603:10b6:a03:14b::45)
 by DS7PR12MB8346.namprd12.prod.outlook.com (2603:10b6:8:e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 09:45:13 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:a03:14b:cafe::9e) by BYAPR06CA0068.outlook.office365.com
 (2603:10b6:a03:14b::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.13 via Frontend Transport; Fri,
 24 Oct 2025 09:45:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 24 Oct 2025 09:45:12 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 24 Oct
 2025 02:45:06 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 24 Oct
 2025 02:45:06 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 24 Oct 2025 02:45:05 -0700
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: use irq-safe lock in
 amdgpu_userq_fence_driver_process
Date: Fri, 24 Oct 2025 17:43:42 +0800
Message-ID: <20251024094445.3090110-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251024094445.3090110-1-Jesse.Zhang@amd.com>
References: <20251024094445.3090110-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|DS7PR12MB8346:EE_
X-MS-Office365-Filtering-Correlation-Id: a6ca7d04-3603-4979-eba4-08de12e20701
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5Dbpl+FHf+qIlnBCJFcwf9Oe8IT0AOSzol30Zvlvm3qwsIP/S6DpB+5sH7f0?=
 =?us-ascii?Q?Mg+vOk1SGjv2L74uYBU5BPlYaW69KxodZ+vo17o+/WjCFQVR4OQ6P+Q3OHbD?=
 =?us-ascii?Q?4mBzDL+ja7vfNRlXL6R4+8+WKmbnUcq1Jk8w9zeqo2XMFkCAof9l3onRSfUu?=
 =?us-ascii?Q?1NjjwlmDhPIBDgEcsBt7bnrTbVSLDiyZDL6nEY2YhcR7mybQyPC5nFMFZdx8?=
 =?us-ascii?Q?+Ew5gjAqMM67h161Oj0LI5L7s6ThP+BH1uhwae3N3ujJbaKZzu00iNt5YDH0?=
 =?us-ascii?Q?HcTpKMxP86mvuXugl1T9h8BZ2qWOJnnz3mRts1J9otTtCYGmq2T3oVyBtgIr?=
 =?us-ascii?Q?/Bn7ta5/pnQe5780Keognt1gtW+bGZNzDJTQctdMDJme1qT/xTHYeb+/O/qd?=
 =?us-ascii?Q?wvKjUduO52mz09yb5ZbXfPFBzjj8+iI+0ER4NipaMgyXuBWn0p+1xb514pGl?=
 =?us-ascii?Q?S3IGH11E4p9r5mPDNkmrCpc6l6fgZbaf3GYVIhT337dUOwGcyNHRaTtkmoTM?=
 =?us-ascii?Q?W01lOJjrXM70CEafkIpg+vr/CWMTyvxKDDgfeZs/K7aCoD6zyaoktq/gG0Us?=
 =?us-ascii?Q?ywq5/u37WD/3wRoEq287cfrfCyYMVCezbgGNk1OTucKrHLfYuJbGLo64mCg2?=
 =?us-ascii?Q?QAgNqJUpjgQWOZmS0J1QKk2xGt/5wyIwfba/fPN4k2Sg0SpvHnqwSF2vYrWO?=
 =?us-ascii?Q?0AOs2Qv59zcRcJxxH/PX0teX356Lwr/CKPAp6UR4IHjRqgcOtVyV/is145Lt?=
 =?us-ascii?Q?ZZkkS2OsMkJqax9m+3+b7+Qy40HQJaAw85u4kYx0g2zN/tC58qB3mmsnSkbO?=
 =?us-ascii?Q?ISLP1Nsu2IWgAdmanrMcPKkmGuiRZyh9YdI1/n4w3MrrUf41tyqpSpJkiOz1?=
 =?us-ascii?Q?LTS/8z7zAsOEyDVn2K2yXajRM30Hqo83Jvfu4+3qVGq0SYozzRCwHo+Rh+23?=
 =?us-ascii?Q?OvdpYpwt9p4nm0xkoWmWLCujrFxYdv2PAVxD28MySviC284lSPCcXqrxMePK?=
 =?us-ascii?Q?m9tD6u+e8330BZWZhzLFMTBLvg0KLOdgKPGz5RFBeZ3W6PJdgpkEi96fzNk9?=
 =?us-ascii?Q?lfECAOg2KCWMmsEaLYGfeRUXg1KUWdS/G2r+B/jt2pLi/VDj9E2mg1z5O4Ts?=
 =?us-ascii?Q?f+JYYduhKRhCkzyIoJDFVR5FxkNyfHKbM1uwzSs162pcMvUsFtV0mCQPe/Go?=
 =?us-ascii?Q?TRXWBmbgLOqx2KS1cgkrhcuWwsbqqbR5zTWSL2GSVCHbkpCCLIWZ8/eGTrcc?=
 =?us-ascii?Q?wO4A8cvs3uW7jnrpcQJ8ATWe99O3zIdEc8VT2o3Q+XtGWJo6dNlpDh2wh4BV?=
 =?us-ascii?Q?r86lEh5mnbs+WQzuuXgw7MrJFZiyKyX9am/bsuD17yfXLqaUSEUAr6Bm7EY8?=
 =?us-ascii?Q?PlvUO9A3ScpdboXpRLSkyG0UX+oEuAfctpO+70FsgT0TtiVwQX8rjFMcNKC+?=
 =?us-ascii?Q?Fps4k9CHLJq9tYH/nuDFzZVrzLq8sU++Hd64uSFz37sGosQxILGwkdvlaXzO?=
 =?us-ascii?Q?1IfvmNiqd80KGGenIoSVDU50bmEtvnZRpu7q8Q9P41yOPASa/hC5BTZjit2X?=
 =?us-ascii?Q?4JX/Ug+xXlOz4C+j36w=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 09:45:12.1310 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ca7d04-3603-4979-eba4-08de12e20701
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8346
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

The amdgpu_userq_fence_driver_process() function can be called from
both interrupt context (IRQ handlers like gfx_v11_0_eop_irq) and
process context (workqueues like eviction suspend worker). Using
regular spin_lock() in interrupt context triggers lockdep warnings
and could lead to potential deadlocks.

Replace the regular spin_lock()/spin_unlock() with their interrupt-
safe variants spin_lock_irqsave()/spin_unlock_irqrestore() to
ensure proper locking semantics in all execution contexts.

This ensures:
- Interrupts are properly disabled when locking in interrupt context
- No lockdep warnings due to mixed context usage
- Safe execution across all code paths that process user queue fences

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 2aeeaa954882..69908b90d255 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -151,15 +151,16 @@ void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_d
 {
 	struct amdgpu_userq_fence *userq_fence, *tmp;
 	struct dma_fence *fence;
+	unsigned long flags;
 	u64 rptr;
 	int i;
 
 	if (!fence_drv)
 		return;
 
+	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
 	rptr = amdgpu_userq_fence_read(fence_drv);
 
-	spin_lock(&fence_drv->fence_list_lock);
 	list_for_each_entry_safe(userq_fence, tmp, &fence_drv->fences, link) {
 		fence = &userq_fence->base;
 
@@ -174,7 +175,7 @@ void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_d
 		list_del(&userq_fence->link);
 		dma_fence_put(fence);
 	}
-	spin_unlock(&fence_drv->fence_list_lock);
+	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
 }
 
 void amdgpu_userq_fence_driver_destroy(struct kref *ref)
-- 
2.49.0

