Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58857C44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 14:27:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAFC210F0E4;
	Wed, 15 Jul 2026 14:27:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nL/NoZ85";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012047.outbound.protection.outlook.com [52.101.48.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A90AB10F0E3
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 14:27:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h42XjxFMuOusFptURnWWtXjAoUF+TU+BeRYsA7k5uKU3PC7lIkiR2vnDth8zHSFE3vCVOS9H+SvTlH8xV0EEpaWDDLHusfOUrXKCiy1rxbzIhFWHH7uloz0mNH3yR6kjO6xZrNiGzoGRQAiIlpHhdSOotk77RNCg9feJhQe+KZ1tJlXw78IZIKudpqCox8iJJVHzVJ0prlojDn4ClXz9pL/U/SNt25RvxEwytUPMvXbd6wDK34HiqHaDDYfftD9BB3tmXiFKE+qz0ZRaeqa1g0d5O6JZ3j8hdkEMSzIQvnzzWK1OJBC7GiavpaZ1MQxpO8TSvRtGQ8XCFp5L5Hk+Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjurBTJ6zN3mTHWfe/dHasyldm6MN+dOW9Y3k07mAcs=;
 b=qRtqW+veDE12mbwAtJdlQCE8V2Z4SvXDwJNQ7zRUN+c53WxRNmhie/+qj+p38uJU9WJf1+5THGR7UpUaIeort7rM/6vkmFhd0+koya0L8I+/AWg+a3lJzwIqmEd0UySBO/P1xCpztK7vEBDqSn7PLRR5032iO2Z2vq2AFjTajxhp8MZZV3F/Mye0mdWpOCapKjPNJzxAPHzEm/kwn5ZXJ+B21jDfBPP82uRAWeKwaztrC6abi7dQjk8M5xEB42R22xz+0TCw1FpuQieREQPg38P7z+0gEL6/nLxkUHwAtP/lWDKFYoDtyhyfDkvNL3UbzNbCmG5oCY4Dz+GcxJNUnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjurBTJ6zN3mTHWfe/dHasyldm6MN+dOW9Y3k07mAcs=;
 b=nL/NoZ85rNOJj5JDFsXV/ebvlbKcjjFUzYllc4s6uq0eT1nksAoEqTlp1U5xHuyTeZehLsSpnRqdNeb9OnW+9EmsMIdvPh327zaDLFOPINXw2pxItZ8+uiOwaEP/qJdIhof0502//WsA9zQWzqSL00zJhpAsXCKxGczxvprNbdQ=
Received: from MW4PR03CA0074.namprd03.prod.outlook.com (2603:10b6:303:b6::19)
 by MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Wed, 15 Jul
 2026 14:27:42 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:303:b6:cafe::8c) by MW4PR03CA0074.outlook.office365.com
 (2603:10b6:303:b6::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Wed,
 15 Jul 2026 14:27:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 14:27:42 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 15 Jul 2026 09:27:40 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v5 1/4] drm/amdgpu: Signal USERQ_EOP EVENTFD notifications
Date: Wed, 15 Jul 2026 19:57:27 +0530
Message-ID: <20260715142730.3475371-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260715142730.3475371-1-srinivasan.shanmugam@amd.com>
References: <20260715142730.3475371-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|MN2PR12MB4342:EE_
X-MS-Office365-Filtering-Correlation-Id: 188f1ce9-d1e2-423a-77a8-08dee27d3b40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|10067099003|11063799006|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: H7vS0iXOmXr8H/PZi2pHKl7LgUpw+vDthn3n7TXpYt0sOkdg7oVT0TjAlV58/2F18FQ+cxQWcOtCNXLywZ2gCLPb6mEVb3d266kMv6KjA+6nuumhJdWsEGrX2/GJahZXG1uYA70IKa1rH8iCHbv1p4dndp0EKs9XRrcsaVIvonDWCgVedw6W8CePrc7oOrvMSLfUcuZuMdNrkX/c4snRsjMsUohavGenu5qXYDMdaoHbERS0MbUDVHMAoIQz0bbdznfd4vUFcMyzZrYarZmPB+JJyZoLAOYzpxYaTFn1mym+8L44zI083Av9TLjgmrqLvpIIkKo9gRnZ+lk17i70hfUaffEBczIHAon8caXs88jyW1Gt+gzAWRo8ryMEc040aRJnOfMjTWmMY7n2NcFFu0vv5bNIwZ5bR45CR7AarV8y7+kGEdwwPQELAbJBluGbXxptaYhng0vkFUw8WLtMthdub12bns+siMexMsFv2lWIu+SSdXjoYv1ROQ44tr7WNjhixFp7dM/hJLcSJCAjVFSMd8kzpAi2+xeprsby3toQc0vb1Tg6CWBciWllWkQ5oDVfkF+EDO2rPH4iV3LXRI0AeJ7YUAkgq7ygpWP6uzKLwXuU99zJ7vpS3jh5i/1Wn1P5AxicVXcxhvXd5b8xWMLaark3AwwHGtPcmh8zaT1k4uWnP9gL59ZRoWqB9XXnliiK1UZpfA7XdxNNCw2hjA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(10067099003)(11063799006)(22082099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8GiD5qRwfzsiJ1Ld3Xy6eQr6joRKlkeYsLMeXz/GjmXH1k6RJbsO0ZOUu/5RglzcmZoUEXo/Fel4yro7u2lKtFB9uaNBImkTbXPGozmI1WV9siYW/xN7jOHdNDDFFU3cYirI+71w/GymucRRd+TLbYYaEChw97CUb2vjWkm83uU4f/WVg0ypjpp+6hTpoaS7hmq1RZ4KbArPSx/t0YDp0NboRmrNBc2FwNgamAIF41FfvileSpr1TkFuDDYJCbPRTy1qeyAL1sWuJBD8fwCM+SodyWtt1xObi8uNujo5waKput1CCRDlya8cgKZKOD15ZGFDo3iuDghRuCZ4j1v/M7GNXNq11QTC3Y8cL1BTSFoWckh93L+rau/6lSIpvktZDgEBZQ0NZgXWmcwB9JgfUnovxHiiDPbK3kQqvPjdR77y36AD1vezmpggLC77I4AI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 14:27:42.4788 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 188f1ce9-d1e2-423a-77a8-08dee27d3b40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4342
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

