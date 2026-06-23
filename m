Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB9BCD4F26
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 04:23:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA17410E927;
	Tue, 23 Jun 2026 04:23:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XgJP/1sd";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010001.outbound.protection.outlook.com
 [40.93.198.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA64C10E927
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 04:23:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SbKJqhyfZewIE+wKyOfCG6sgxFhXqSTCLaKicjX6cpD68i3wBNGyXo55tvQ38M04FyYOIVU2FzgNGbo4flVO0zIsY/ZCHjSvNlgdgXNW3yAGOdu3uKxrwxkbllkuZNTfqyZELp2N+E96jacapaVkvihc3YTAUjSPELPZJs8KrKFJFPXdMoSuKYSwFPt+jwbk5kHVe5EXM1PmDOxQPIjDZvkVEs2IaOUAZJUsMpDaa8m3l3vEHHVFERr48jlNIBCH2r48g18w12QbAoDtoB8+XSQfiQ9iT2GmB+fhkkpvhI5bSiI/fx2pEeYnw+FRGLptxwoXtF0RdcuTWss8fETSoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0Qv48W2hWDaCayIF34+KOZv6t73xIakw7ChrEH01io=;
 b=my8KgCOR73h9ldxgTHfUPGTAmuZum3BEBWdsd2tLSFeSVZQ0K9UvU7zwcXirGkr00KY0QUHXRBTjaWDYpPUGtVbNou9gC6h+PvrNulcxrhtHwiWYiqEg+yD1Uet8FVVfVqroFdhfE7rCIPkm/LySWvSuOhbFj7bzGgS/v6FY/ivzs40DlVWxECyFze9Rd079aju4PUIwAUK03rX8GwQTv6Wqk8iHGbBgbohtEryCZT6u6iloun2cBs5vWpiM4PaH7m0E0/z/VtXW275YcdRIukrxfTbDmIiupPSpRa/Whn75VS4ngRrKNVtIQ/IATMSLrwUFZ7jNGDADcrnvqmBrBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0Qv48W2hWDaCayIF34+KOZv6t73xIakw7ChrEH01io=;
 b=XgJP/1sdIkvLF4ZQADtNMIEVhhXxgYlO6vwVQjWLVyRutOrt7fI59mrcgqutRpbhFPhAuC5TNDG4W6gr/wY0FPfWOHH4fMZkOYwRI9gKtA4hoWQCSPwdduUMfugl0EUjDfsUvUlhapTRVlNpqLV53Z5xcMP4A+hNwXLkcoFyWQI=
Received: from MN2PR20CA0054.namprd20.prod.outlook.com (2603:10b6:208:235::23)
 by SN7PR12MB8170.namprd12.prod.outlook.com (2603:10b6:806:32c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Tue, 23 Jun
 2026 04:23:45 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:208:235:cafe::52) by MN2PR20CA0054.outlook.office365.com
 (2603:10b6:208:235::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Tue,
 23 Jun 2026 04:23:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 04:23:45 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 23:23:42 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 <YiPeng.Chai@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH] drm/amdgpu: protect XCP scheduler selection
Date: Tue, 23 Jun 2026 12:23:19 +0800
Message-ID: <20260623042319.561959-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|SN7PR12MB8170:EE_
X-MS-Office365-Filtering-Correlation-Id: c26cdbf9-9399-49e9-a5b1-08ded0df36e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: JAaMm6kFwNFaN5+ZbArwHZ1KmwL32VTqAwv0IalQKb4unFn270E0zZALhwvahJOkPW5tXF5Cg9g+2HlzTPOynAFIeRqyWUnq2fyUC3PSxKGe/hkTcWKHUy1t7YQ/4Ua5eQ12I9Ksdw3DySUKXi+L8z2zcF7gfnUiuION2TVcfPQ7zTZjGHrl7q7fYeYDF/n98VJZqjpu73//pRwo91XJ3e31pOEC72ayWYINTzpT1OjW33EBSXske9PFWgKWff2weQqXYEsz2G02R4kB519kjDb5wh5V2LRxhqnnfh9jYHVqm+p90O+9QAYwPM9zPgnMTHYt+6YPaW+UT8TLeXuMDqAXxdbO5wOc8A3Amzr/qg5Lhhi76IwG8naYdgPAMqBtKmDi60efjKJNfidlKR90Jw9usCFqGo8GlNK6TlnlpAAD6McRC1AJOIwjRhDoOZIuUehgTA2nBIPx3bhvg8y8lpffoxDIiPSr+OJz5v7MwRZfs3x4mqF1uSLBR6CsdfaDXr9dGxGIBf5dci1X0PLZY3zL41VzGE5QFMXfG/uNRy3si38K+Fig6f+Wh/7wLQ8SeRUUDuObDjJ70hoePhZlCw1u1Rkqvkw0c4Bass+nAiwmNhnACfPzsFRnp07He8W9ciylyq9GP0QIvD2ZPKXN/M4e6wyl5aehjuFVu1GAH9cfUZIpMHRi5hCT8e2aQ5Fw
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KwjnuntzqP6QZcmQPMmmkdelXGFYeg2l7Sdq1YlXxoUPq4LLHEANLJ+LjotBWhc8U4oQiZX2UFS1T/Eor0PwrnP19+8BwL6uCwwEhf7+uQQas4G7ZdyO90AEbEYL+qT/jowM4/RmDCJS73bKQMR47qOVuU6SATSLvB17l7bGEyKj7ardnx7RNIDfUnaF6GYhxP0V8mPfknx8a0IpMT09QVA5e7wGnAPSCJEsvQ2rt0iE02yvgt3Hd9NU/4SqpxHq7zgtQd4qmfuERCx5ZMrEr6/e9fTnpbgsdKTdZMapZxIOBu3bcaBdizIHvs01by5SnhPz4lmwMcfExZusnWufAqZ3Oe7biw/vbvlZYquIDIyIy/0MtF7hy78t7CIHQbvk5UXm7LfeRkJU7wFSxXqMNYxiTeyMGRPlAYmORkD0R1fV5hNhbJfN6/5MhJWrEW/6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 04:23:45.0409 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c26cdbf9-9399-49e9-a5b1-08ded0df36e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8170
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

amdgpu_xcp_select_scheds() reads the per-XCP scheduler list.
Partition switching rebuilds the same table under xcp_lock.

Take xcp_lock around XCP scheduler selection and release.
This prevents readers from observing partially rebuilt state.

Also revalidate the selected XCP id before indexing the table.
An open file can outlive a switch to another partition mode.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 37 +++++++++++++++++--------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index 88e6eab91bc6..1db7d2ad01fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -469,16 +469,21 @@ void amdgpu_xcp_release_sched(struct amdgpu_device *adev,
 {
 	struct drm_gpu_scheduler *sched;
 	struct amdgpu_ring *ring;
+	struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
 
-	if (!adev->xcp_mgr)
+	if (!xcp_mgr)
 		return;
 
 	sched = entity->entity.rq->sched;
-	if (drm_sched_wqueue_ready(sched)) {
-		ring = to_amdgpu_ring(entity->entity.rq->sched);
-		if (ring->xcp_id < MAX_XCP)
-			atomic_dec(&adev->xcp_mgr->xcp[ring->xcp_id].ref_cnt);
-	}
+	if (!drm_sched_wqueue_ready(sched))
+		return;
+
+	ring = to_amdgpu_ring(sched);
+
+	mutex_lock(&xcp_mgr->xcp_lock);
+	if (ring->xcp_id < xcp_mgr->num_xcps && xcp_mgr->xcp[ring->xcp_id].valid)
+		atomic_dec(&xcp_mgr->xcp[ring->xcp_id].ref_cnt);
+	mutex_unlock(&xcp_mgr->xcp_lock);
 }
 
 int amdgpu_xcp_select_scheds(struct amdgpu_device *adev,
@@ -490,7 +495,9 @@ int amdgpu_xcp_select_scheds(struct amdgpu_device *adev,
 	u32 sel_xcp_id;
 	int i;
 	struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
+	int r = 0;
 
+	mutex_lock(&xcp_mgr->xcp_lock);
 	if (fpriv->xcp_id == AMDGPU_XCP_NO_PARTITION) {
 		u32 least_ref_cnt = ~0;
 
@@ -507,19 +514,27 @@ int amdgpu_xcp_select_scheds(struct amdgpu_device *adev,
 	}
 	sel_xcp_id = fpriv->xcp_id;
 
+	if (sel_xcp_id >= xcp_mgr->num_xcps || !xcp_mgr->xcp[sel_xcp_id].valid) {
+		dev_err(adev->dev, "Selected partition #%d is not valid.", sel_xcp_id);
+		r = -ENODEV;
+		goto out;
+	}
+
 	if (xcp_mgr->xcp[sel_xcp_id].gpu_sched[hw_ip][hw_prio].num_scheds) {
 		*num_scheds =
-			xcp_mgr->xcp[fpriv->xcp_id].gpu_sched[hw_ip][hw_prio].num_scheds;
+			xcp_mgr->xcp[sel_xcp_id].gpu_sched[hw_ip][hw_prio].num_scheds;
 		*scheds =
-			xcp_mgr->xcp[fpriv->xcp_id].gpu_sched[hw_ip][hw_prio].sched;
-		atomic_inc(&adev->xcp_mgr->xcp[sel_xcp_id].ref_cnt);
+			xcp_mgr->xcp[sel_xcp_id].gpu_sched[hw_ip][hw_prio].sched;
+		atomic_inc(&xcp_mgr->xcp[sel_xcp_id].ref_cnt);
 		dev_dbg(adev->dev, "Selected partition #%d", sel_xcp_id);
 	} else {
 		dev_err(adev->dev, "Failed to schedule partition #%d.", sel_xcp_id);
-		return -ENOENT;
+		r = -ENOENT;
 	}
 
-	return 0;
+out:
+	mutex_unlock(&xcp_mgr->xcp_lock);
+	return r;
 }
 
 static void amdgpu_set_xcp_id(struct amdgpu_device *adev,
-- 
2.34.1

