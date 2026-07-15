Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD08C44508
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 14:26:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 357DE10F0E0;
	Wed, 15 Jul 2026 14:26:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OM3Zh3xX";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013010.outbound.protection.outlook.com
 [40.93.196.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ACBB10F0E0
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 14:26:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qGlrNH45XulwwSbt+F6FlckPJasOd//Mpb4wNUzw5dM5QnZEKjxxYNEM7lOIuVWTX4d+n2up8Zb958JvwiWDqUiPnA+JsNswdbApL8HI+KqEpu6WZ8yetY3nRDAUTTw2nRF6Xs1kw77NjgPP4VbYcTt/Hb5rELtvCqQEFO6UMx9+V5Uji3WymMfrxn60/UvTYQXCLe0LYUBk5EagX4/FTvjCAmQaNqbvJE9FbRv8q9WQxU6XYW6IWACntzJfaXGoYRSjXtR1lRCr/MV3vmBWmADNRQ+edc639E5DblSyVj2Z+uZtPwuRJBeiR6mdYlUpC2wMlOlZegOG2Km4xpLhWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjurBTJ6zN3mTHWfe/dHasyldm6MN+dOW9Y3k07mAcs=;
 b=yLhtzs5OH0Ugw1U2uhHTuH3tCKe41hMuSHYmjoe0O/SkgK15f9zTI0glmzz27aNh3e00TIImwS0AoE1FN2GNvWfnKjCJ5xbPGvDCout8ToZAU/zCCszLy4wHAZKJIiq0M1WJ1mLjoq5GGdZVRq4Usi1oVgZlD4z9F9VZ3B9AgDBxZYwGGQ0nVVeLhL8lOyG0NZWbh+HdKuwFYrZxHFdHWS+bYZ1glhXfY62qT0ubh5vAdV/UUrssWuTGXVRBLbnUCRk3d09o8zIoNKlDcYgwehLulJxRVaHCqst2/vYzv9Ija0t7NHoAGrnQBqqkK8BN2C04kNGKOWat5Kvhk/rERg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjurBTJ6zN3mTHWfe/dHasyldm6MN+dOW9Y3k07mAcs=;
 b=OM3Zh3xXBDc/cisfpydMUhdI8J/s8bwePKCC/RTwOpDKJKiYtXhUOVIYSEakkqTDYOpfSPNuQpp8m+Q0SgHNOaGXh9ePXSSxrv6LVV+pqZomYgM7qX3/DSqkayDfaZuw18qdOOIsjJJq2zEJzsN945ZkQfyC1lbZcaCqRqiu9JY=
Received: from SJ0PR13CA0048.namprd13.prod.outlook.com (2603:10b6:a03:2c2::23)
 by LV3PR12MB9258.namprd12.prod.outlook.com (2603:10b6:408:1bb::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Wed, 15 Jul
 2026 14:26:29 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::56) by SJ0PR13CA0048.outlook.office365.com
 (2603:10b6:a03:2c2::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Wed,
 15 Jul 2026 14:26:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 14:26:29 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 15 Jul 2026 09:26:27 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v5 1/4] drm/amdgpu: Signal USERQ_EOP EVENTFD notifications
Date: Wed, 15 Jul 2026 19:56:14 +0530
Message-ID: <20260715142617.3475314-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260715142617.3475314-1-srinivasan.shanmugam@amd.com>
References: <20260715142617.3475314-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|LV3PR12MB9258:EE_
X-MS-Office365-Filtering-Correlation-Id: 22cca09b-4f41-48ff-c54a-08dee27d0fc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|376014|36860700016|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 9iSCv2yveO/Bhr4xNOYji5D+Swe989J7xC9gul24buvExbNYRZbS/t+bQ9yS60kk7N+pQrgLiU5Oaxh1P0GmOxNSvBcmBJI1WgYunxas/5umvc+PEYWVfgBqKVTNxigOwPdg557hVQsSAFXPIrbXR4FmAhPcvpWv7mEmDJ52JVGNgJzEkZkCqirvnJ5xUsWbEWea5gb9d4H2EMfmUzqK37v9komkD6nUHz1bx2+PRS4mP7RqR4NcN8vz0EPYgppP0GiGFZQPIS8ru4WKLFoU5AJg3QJfu6VgVXLZT6pFIb+aH3JLsc4fhkqN4DshF91EAsNtasw86CZVNnRB9vfqcOXRjLYj0UjWpp9GVnehPcdY8TD8A4Rxf70uoOS3IHuxJL8UmgjPTjIfUWRi+KvMXVeiTPrcDpOaF+NC/EZub2on4t6OBTZFvN/bRgEEiX5AlDkgbrAxZt39v2no3oXeloznyu+8wRSrCYKxeQ37Np/zota+Mv9H+xkofw9VjuUc7xqNkFCT+7a6iYv3liKquO8VrnqBpp0EVnQ6Mqs+O8yRatuLuDsA1rW0pN7kon4nWufmVOXAlgBqXTcmqNf5jhJzvmOnLcKagW9AWqgxQ4DglZcxQ8ZSh6W8uH8We4ubSfUPTJ/C/Rn9UGYfoEBm1xbqjJ7c/krMGt5+kp4uOrlj+WmTS1JlyNwFuY71U0jtDaX6Xfm5Z72zsPDpe7/GVA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(376014)(36860700016)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: s0Hom8bKD6N6dKOYFtbUQpKHIEGH/Jl2f5EiAJLyBE2qyHZZXnniBVxYzvfi0qgpnSl8hJdkshCcPrIX9tXOTk28O3Lbg3mAxxCyU+QdghpjlhLVyQWZNxBKlT/54npFHnphBI7dDgU3diLEsa1r8HBYglyRGk9Wpk7jqroG+V+8YeEu4Q1A9KWJSkz8udonH6UaUb5wnwzEw5y8FFjk4QmKyZc6aVmTTqywcRYAooV3pvgvbv5jYJvG55ken4dMS+6oMrvYlDtLulZC/gvCa1WwcAacnvySNxJnwojNuvuO+jH1AG8kq3XeKG0CIFrqVqRk4JoGFMIclTSW2+FKvEWw3nusn/t4UGctDRT6mMxOeoIaBJ2NaKiTzd9pCz+fjGEtSmFDtqoynVVbyP1BT3QfOKgfMMtcCtnRHj3gnF50Q+c1NEX+8qIAcQxDa6hP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 14:26:29.6062 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22cca09b-4f41-48ff-c54a-08dee27d0fc7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9258
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

Signal USERQ_EOP EVENTFD subscriptions from the USERQ interrupt path.

The EOP interrupt already identifies the queue that completed. Use the
queue object directly to notify matching EVENTFD subscribers.

Routing notifications through the queue object keeps delivery tied to
the queue instance that generated the completion event, avoiding
ambiguities from reused queue identifiers or doorbell indices.

EVENTFD remains notification-only and carries no event payload.

v2: (per Christian)
- Move USERQ_EOP EVENTFD signaling into amdgpu_userq_process_fence_irq().
- Reuse the existing doorbell-to-queue lookup instead of duplicating it
  in the interrupt handler.
- Keep fence processing and EVENTFD notification handling together in a
  single helper.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index fbf783946f6d..ab3ef3a9f655 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -215,6 +215,7 @@ void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell)
 {
 	struct xarray *xa = &adev->userq_doorbell_xa;
 	struct amdgpu_usermode_queue *queue;
+	struct amdgpu_eventfd_mgr *eventfd_mgr;
 	unsigned long flags;
 	int r;
 
@@ -232,6 +233,11 @@ void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell)
 		/* Restart the timer when there are still fences pending */
 		if (r == 1)
 			amdgpu_userq_start_hang_detect_work(queue);
+
+		eventfd_mgr = amdgpu_userq_eventfd_mgr(queue->userq_mgr);
+		amdgpu_eventfd_signal(eventfd_mgr,
+				      DRM_AMDGPU_EVENT_TYPE_USERQ_EOP,
+				      queue);
 	}
 	xa_unlock_irqrestore(xa, flags);
 }
-- 
2.34.1

