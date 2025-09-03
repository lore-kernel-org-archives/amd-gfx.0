Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1BBECA1009
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Sep 2025 08:40:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78BE710E517;
	Wed,  3 Sep 2025 08:40:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mrdPFqSP";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37C2710E517
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Sep 2025 08:40:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hTYi9KTUpCQe7jIOUGBrLSjwNE2MRQAlXb24Xc0VQaqKceDAR7dXquWVWH7sxKfeRcMwQ+46+L+5b06V4cX2uV8gSLJbP+uejjoQnfzsiJJW15IARJvH8phUcCTf6oV99sPf8hAg/qxVAXrgt4RhbEml260Omu37Lp/iwWroL+dMv4m+C5rLEjdo41v4acer7Ycf49zBGLdxx/4KIHdZlPavXpgt7oHkMI8/r2dmO7sFT7HJ6TgxUhEB9wiqN9GDCFuE2GBa8HyRu/ubd5NZKjnRdqxRLqSC2kLfLb8KZxxgBQt7iV7sUvmqYCLj1y56au2QtXOyo4+6BEC6GLJV2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMrYPrxEB+QFbSs183EO/yOJethtzolfTwEwPZnihl4=;
 b=lY3e38FShbSAYe0GLlyAPVJZWMjRkGsyOgPb+Z+mav4hrnxNLi/lK90XNVggFdicLy6EIpg/9uDtAlkrtJi2j42J27RCGelSDG10U7yXcFjpBIgWPBOkd4cJfP6RyCcQsdp77xAK+iMg5G8ZPyylGAtDXMdE/v37rJBae/NAKSsDb+4iTv5qcRhGgqQmN8K+1hIkbQSwb9yTV1kHpXDxf8p25fPn9ohoweDJiiMQtDr2GgQOlSZ+Ei7WGYNIZmzEss9wuPZrzeUBqrKtLfMlNEDxuhbe2qu3uVLHK5yqDhPGnsJ+Jmqq9+KIPgy9bCJStqzPl0kDJaXIv22xd7AxeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMrYPrxEB+QFbSs183EO/yOJethtzolfTwEwPZnihl4=;
 b=mrdPFqSPL2MKrrniVKA4mKy4H79ZToigBlsAuQ7vAYn9tcpj6UUd/pLv0XkkNeRuTVLvO608ay9PzKcFXi0/Wv9NQUNJSDV8fArEZoObDvKzhYfEdIuNQXM4LnJMpN9u7KSMabtDMmq4KaX+d1wo3T2Za7qIP6mxvbEHlCELZGY=
Received: from BN9PR03CA0221.namprd03.prod.outlook.com (2603:10b6:408:f8::16)
 by DS0PR12MB7996.namprd12.prod.outlook.com (2603:10b6:8:14f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 08:40:14 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:408:f8:cafe::a1) by BN9PR03CA0221.outlook.office365.com
 (2603:10b6:408:f8::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.17 via Frontend Transport; Wed,
 3 Sep 2025 08:40:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Wed, 3 Sep 2025 08:40:14 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 03:40:08 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 03:40:08 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 3 Sep 2025 03:40:02 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [v14 08/11] drm/amdgpu/userq: add force completion helpers
Date: Wed, 3 Sep 2025 16:34:26 +0800
Message-ID: <20250903083914.2604482-8-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250903083914.2604482-1-Jesse.Zhang@amd.com>
References: <20250903083914.2604482-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|DS0PR12MB7996:EE_
X-MS-Office365-Filtering-Correlation-Id: d5762914-c72a-42d2-ad3b-08ddeac5807a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aUxRYjNoV1h6K28wNHVhbWVNZGs0b3FweGJQR2c4eHNLWUcwVVlNZEdURVVa?=
 =?utf-8?B?bDNFWHRXYTJoZkdxMXBjeDIyQklrN1ozN29Bek96Z0lOK0ZuOVFWb2J0cmI5?=
 =?utf-8?B?ZnR6aDVCZzdYNUFZRDNXQnJEY21KaFcxRjZqNHduZmJQQ3ZXZ3ExYjFMOTNp?=
 =?utf-8?B?a0dWemMxaGlqK3NWSS95SEpvMkpVUENQS09MYVF5RHhoMFQ5QzNuK21Yc3Bx?=
 =?utf-8?B?M3YxdU9vVFoxN2RwU2JOclZEVTM2RGZvNHBER0M5WnluTmdjaU1tL0YrajhM?=
 =?utf-8?B?UDJxcnhkRlMwVVV6bi9VMlJvYy9LQWFNWjdrNnJjRytTelNUcnUxNCszZXIy?=
 =?utf-8?B?L09uNGJoVkJLc0Qxd29DdG41cVl5VlFCNFRWeFZRcHRlTGUzbGs3YTYvaDhX?=
 =?utf-8?B?ckdBYlBJNG5CM1pjR3FJRXVCOHhTRzh6ZjFVMXJvVG9YcTRrUWxybmRTNlJS?=
 =?utf-8?B?S1F6SkRKRWlZUjVzWnloZU1oSy9yZlQzbmJWekQ4NmtpWEdiTjRSeTVFV1N0?=
 =?utf-8?B?VjFtbVpXRmNuaFFQME03TERJcUdhMDhrZzMvZ00zME1zZ05aR3U4ajNuRTJZ?=
 =?utf-8?B?VCtQdXI2NVo3VTN5RlZ4dHpKRWlONzZicWdaS1owd1pnYlZsOG5PckRrSjZ4?=
 =?utf-8?B?Ty91QkZIMHBGQndwaXB6NjhFOVpXaGo4bDVXYnBpUUNkbVc4K0tuVXVCOU1i?=
 =?utf-8?B?dy9IOFpWTTVyVnV0anlvSTgxSDJwenNRQWxHS1dDU0ZMNkM4M1cvWmhidzNT?=
 =?utf-8?B?Yy9pUGRJTklqNFYvaVB0QWd1eGdQQlZmL3ovRlYvbmhVUDdmWVBZNjdLcmxz?=
 =?utf-8?B?SEFNVkNDRko1d0pQTFhDa0pZcUdITDlseWtzME5QTlZHK0xaZWF1TDhnSFNG?=
 =?utf-8?B?YmhaTXNYdEdjSzZrcmNEYno1UENOeWFIMVNaRkNrYnQvRkdNRTREajZHd2M1?=
 =?utf-8?B?VmM3WTJKdDQ1MUpQVDl3ZTNxSVpBNC9ybzdSNERsdStvL0drMm1OdEd2b0hX?=
 =?utf-8?B?NXJFU2NlaDZtbGNPeStJck1OMWtHVjhFL0dMRnZOYnozcTV0OHhSK0lpenFQ?=
 =?utf-8?B?WW84Mmd0ZklxdndxKzl2alpTQUNmenBVRzd5UUo3bHZJOTBjM0lHaGQ5cktT?=
 =?utf-8?B?TzNuVWhSZzhYcFJ3cHQ1OVQxbTFyMnpJOUE0UlZuYlVyMzNUbVprU0hYdEx5?=
 =?utf-8?B?VDgxV3R5TFZOVjJ4Rk1RV05VT0RiWi9ZY3QwTmIwRzJzbXYvTHJkY1ZzeTJ1?=
 =?utf-8?B?bDlmemlFd1d5dnVNWHdKaGlycHBuQkVkbi9YcXdpWlNZYnZMV1lRTllwTkRR?=
 =?utf-8?B?Mmx5dVpGQ3ZaUExuRkJNMUw4d256ZWpiUVhSZlQ4bTJDQkl5YnFFQlcrTytQ?=
 =?utf-8?B?aUg1QVVWM3dPRXlWYndOcGNyZ1RyN3BtR3VBRVNEbVozcmtxV2duNFZxY2tn?=
 =?utf-8?B?MG10U21Hbm9CS2hQVTFYc2FYbWNxK3ZHWnprVzBUdVorREZCaGZxL0NHVTJy?=
 =?utf-8?B?alBnekowNkd5YnJwL1IyN0x3cTdncFNORnhoZlhhOCtMQk55eDhwS1EyZDlQ?=
 =?utf-8?B?K0JOeFBLYlFhaUtWVUhMWXZheGNENnI0cXI3cXdrZUEvcXhHdXdQRHRkeTAy?=
 =?utf-8?B?QjJTNmV5RjVodjMzSUp5bXBiVHcvaXF5VFVVaGVhVHRvZkk2SEJtVXN5aHpJ?=
 =?utf-8?B?Q0tXWGNyejZONG1veERHSUFRaUx3dmk2Ym5ac0wyVzZFZDdtUnQ4eVlOVEVx?=
 =?utf-8?B?VzkyWWhtWDJ2ZHpJWitnNDNuL2xNQ0lNUThXY2ZMdGhJUlJVOEhhMTdaazhO?=
 =?utf-8?B?NnBsRE1VSU8waHhiaUNvR2Vjc1lMQXRoVXB5MkNuaFJTYVVNNzZqT29Ibmp4?=
 =?utf-8?B?a1MvK2hMSmpiOG10dm4zRkJTQ3pCQmVkSkpkYzdBcjkxN1lZZ2dBSk5vVjR5?=
 =?utf-8?B?QWdod3I4bFRtMmpSaC8wckMwWkNEaDBBZUZEQzNnYVkvUXMxdFQwWUhONmor?=
 =?utf-8?B?SVYydFNrSjMwcVRCb3FCV2QwNjFncGRYamhlRFhPMzVqVnlvZlZxdWp0YTcv?=
 =?utf-8?Q?XEAqiF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 08:40:14.1029 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5762914-c72a-42d2-ad3b-08ddeac5807a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7996
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

