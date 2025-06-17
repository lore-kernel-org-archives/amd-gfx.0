Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71825C7115C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 03:08:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC28510E496;
	Tue, 17 Jun 2025 03:08:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pwKeB3Xt";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 764AF10E495
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 03:08:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jQCogTEjti8zTT4kM3zt5VxymuIokEGMwfeH7Ikfe/z0IaJakfI43M5fxU5FR0YFTB7LaZGlA5zGvFOpoDVAygkOyBh0K3ROD2IQKGh3ykVwDCRaOrNESbB+PQrRJXSqWp1CwOVwe8mYx37fb3bkFcUqrw35hcIEa1w1MSBObL8maoLlSAnmCn+2p2D2q7L5xl9xAizX4WGZ2Gt+c8w5t4ksUy7hMLz5u3pSM929rm6sTUpbj25HxJGK5DSCYusQh30lGrVrV7LYyDXvodldU6ZJtw2p+Sd8cFa12O4grSAh3ILixj+mnwbvJsLcVfZtAKXVqNRVxZOhc9Gr9bnxoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItKVGYdJMw5nVOesCFqnBWI3oneX8yGBIXpZnR4wKzg=;
 b=OUxk2Psg8IoJ9pKC42SR/n1XxFjS0ZzLMu7jjTw2jvfRUuRxDUYWMwbKwT2LU84Zp08jj/80MaCULQ/k+1hSW6e3rlvGL6i/ZEsr7D4TBmD1xBi2AaAUD6UynpdxtvjT3bHwt5N8okA4Kx2tcZ4L8fPcRsh+dPAOHfjBGyFb4NSGIsqGiXAaWOyrJIyFjApRkDbnhomHUFvXDKIkAtqmsb8AAd38JJTN4/A4/g8dAMv8RnEEminu3+JmP4cMZQzbK9qnQwyhhTO7O2vcHz/Hy8h288LtiJqwIBjFiAppOzIExajKAfCf5RFGWMEdVCuleuUieUL63VSIB2avWu2vVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItKVGYdJMw5nVOesCFqnBWI3oneX8yGBIXpZnR4wKzg=;
 b=pwKeB3XtbNkKVLtnlyHnc2xcbzYYX38cF5n0gyAAR4ZKisp8EsveAIYIvG68OEl70gbw24HHKmw0rho/jiQjSkNtG+UhODP+cEEl8fhqlf9XQ1gNVbiH2JmEDaT0srSyKURrvxGMUAnDIY9XeDbbyAQqgxHgxHnGCE3PaPXKeVE=
Received: from MW4PR03CA0158.namprd03.prod.outlook.com (2603:10b6:303:8d::13)
 by BY5PR12MB4178.namprd12.prod.outlook.com (2603:10b6:a03:20e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 17 Jun
 2025 03:08:48 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:303:8d:cafe::f7) by MW4PR03CA0158.outlook.office365.com
 (2603:10b6:303:8d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Tue,
 17 Jun 2025 03:08:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 03:08:47 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 22:08:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 20/36] drm/amdgpu/sdma7: re-emit unprocessed state on ring
 reset
Date: Mon, 16 Jun 2025 23:07:59 -0400
Message-ID: <20250617030815.5785-21-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617030815.5785-1-alexander.deucher@amd.com>
References: <20250617030815.5785-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|BY5PR12MB4178:EE_
X-MS-Office365-Filtering-Correlation-Id: 97b0290c-da55-47e5-9e96-08ddad4c4732
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gLvZQEzrQggL3sHBu8fvsXl35hoPDLj4Z18C6kouyqs8HksuhDV8/r6jRo0U?=
 =?us-ascii?Q?oJJNVzFte1A7zc00h5lLjPrihyZ7xp5xDp7lmxS4fItpC9+WkHu2U1JdCd2K?=
 =?us-ascii?Q?qT6tlD6rBIpqDy/wvQrV6Pfh/BA+UhA8K1C6LR1xOcTA/KTFecS1MT2gWYVN?=
 =?us-ascii?Q?GwQ3qvq4OEZ54B6C7lIJuvv24dzEvUhpv/hiFRreoJg8VM26BMSZ+emgNZSx?=
 =?us-ascii?Q?0iLpT9cy/9uIl26n4wbJ3nTQH34sACcEIxsHRSC3y3Utbfhki1w0VuAbFFzN?=
 =?us-ascii?Q?rUk6GX7s2RCWiFkev2L3ZWel7Tw/H95aunJWTvOMbMtzXwYtoj6492s+9rKh?=
 =?us-ascii?Q?65GgCoseAonV4ClsnE6PWcOUkaflUby5Kt3mL0Z9+9ykOhkDdjZcSrS88wbz?=
 =?us-ascii?Q?fgsD7PYeAfXqd2byiIq+NbefYmGDWrj06mGgh5pIpk/wVhblgf8xk8ezZvbO?=
 =?us-ascii?Q?ONxYdx0Gps0g6FnR1JTXLE/0gzjOH7nsNrCe9jliwejT9VKN/IlRKu1glL6R?=
 =?us-ascii?Q?1TR/T4qDEXLiGJInzpPogB9UweXb2/WakSTn179BkiHSRvW6zEaz13/uMyHi?=
 =?us-ascii?Q?l0Uc/fPgxNHo6zj8vI5FuWz0ETaO+BW6NR1a1IN6pkHhCGlM4OszKy8u0A1J?=
 =?us-ascii?Q?Y4jMSJqi40abKADPJHWCvqUSRtpqev0/sWSvijt0lp/SyvqpEKrWMfHEEaSy?=
 =?us-ascii?Q?h3XEAMLlzOQrbQE1AQ6uOfTVLkYXicuVmA18Hw7lVWZM/B+oo8+8JctAcnq6?=
 =?us-ascii?Q?p46UDgZ15Z2jWXrJ/7RWds6RLgnY7T5v3+wlc+xKIwB4Ljxer8Qw2AekTvkH?=
 =?us-ascii?Q?EeJmgsYcxDpCdPUiqcyzK3QCwKvy00uvRrSY3IO1dspmXA0DAJguq31iX0h5?=
 =?us-ascii?Q?EjvESVh9TYf2yHfSkTFNck4bycVjPBwn6mv2U6C9Y0Y6HE4eQbhpM4aEaQC/?=
 =?us-ascii?Q?Rr9jnVaw4YXz4fDKOqfoRd+/mDz2WTssgCnTf31k20hlyWR8rU4rsJ53K8Eb?=
 =?us-ascii?Q?yWlfm/KG5zgD04eaNAK0Krpw/LLRrxD8ygIYYgC9qE2hLzvD1j8r7N5Y9xcn?=
 =?us-ascii?Q?6dn53+sH4HQMWnwQVKbegcWb2InNHMQUjt2lQovPj5+aV3alEcwkXP1M8pwY?=
 =?us-ascii?Q?D+zJ/E879H4rAaXjOjxXsJh+oUzBT9VAcxjkPn/IiZo0+SiuxvZljAE/SrrQ?=
 =?us-ascii?Q?g4WY1oiDqtFZqOsGrlTe/mtz0hqHwXL/jJJ0uq/vyoWvCSlYWu7BUGY9oWyF?=
 =?us-ascii?Q?XimZXK8sEr9Zoe0sbogKBY7BFqmqxi8Ef5jrQLqUXtVUNMFQ78fn0BJALKc7?=
 =?us-ascii?Q?8wznNSxyeqWSbvZDPCF1cmnJ6kNsowWaG7vbQO9RXQxRggEZsztlOx7R4q2A?=
 =?us-ascii?Q?X0Tc4MbyPJwYp5pcB1efgP/vMEDthjXFnxDcIA74sl426mIkfUhbDGCbJPjh?=
 =?us-ascii?Q?Wd7fOaWRKoaFdbCaq44YKV11UpeTkxmQRM8PsJAgG8qG9SrZlGvoPvsse4i6?=
 =?us-ascii?Q?sXbGw6iW/3QT4BhdaMq8QqfNpBi1wrM+tlcc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 03:08:47.8770 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b0290c-da55-47e5-9e96-08ddad4c4732
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4178
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
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 40416f2d03238..2b8e9239ad0ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -802,11 +802,23 @@ static bool sdma_v7_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
 	return false;
 }
 
+static bool sdma_v7_0_is_queue_selected(struct amdgpu_device *adev,
+					uint32_t instance_id)
+{
+	/* we always use queue0 for KGD */
+	u32 context_status = RREG32(sdma_v7_0_get_reg_offset(adev, instance_id,
+							     regSDMA0_QUEUE0_CONTEXT_STATUS));
+
+	/* Check if the SELECTED bit is set */
+	return (context_status & SDMA0_QUEUE0_CONTEXT_STATUS__SELECTED_MASK) != 0;
+}
+
 static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
 				 unsigned int vmid,
 				 struct amdgpu_fence *guilty_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
+	bool is_guilty;
 	int i, r;
 
 	if (amdgpu_sriov_vf(adev))
@@ -822,7 +834,8 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
 		return -EINVAL;
 	}
 
-	drm_sched_wqueue_stop(&ring->sched);
+	is_guilty = sdma_v7_0_is_queue_selected(adev, i);
+	amdgpu_ring_reset_helper_begin(ring, is_guilty ? guilty_fence : NULL);
 
 	r = amdgpu_mes_reset_legacy_queue(adev, ring, vmid, true);
 	if (r)
@@ -831,9 +844,8 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
 	r = sdma_v7_0_gfx_resume_instance(adev, i, true);
 	if (r)
 		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+
+	return amdgpu_ring_reset_helper_end(ring, is_guilty ? guilty_fence : NULL);
 }
 
 /**
-- 
2.49.0

