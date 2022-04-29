Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D07ECC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:46:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2364310F136;
	Fri, 29 Apr 2022 17:46:45 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 892C110F10B
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:46:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpHWGIrHBhR66m+KNpj9w624IgEgdVUT3iZne3mrpkY/dMSOsvK1VwLDjwNY89QEFW0A3U8F20Dhv1155MTOSdnFPuVWQjo04UNWGCQKCpAEZrHEnEaq6hFLS9Q0yeok6EYBg/jTbvdS1wsfH+PHlPMQ6dbT/c7g/iKLImWLZVpR1dxs4TaLqiOBwHab+yUBL3019+fcO0/QjOsqcHy4p68mswXpBQQ9z/JushQDsX29QNgYNI8xG//50I2QrWoX4iuUVH+BnESxKasAFQlSwOXgkqljWsrQO0rgrFK/NejzZtDgEsZFUwSEt2CpZ+kNrC8Nn9HzEOxgAEQFBG2FWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMivSDxcRuJ9M0aMipP9s58pPs/wwC4HgviGGR0Co9A=;
 b=ft+eWscjDc5GUaxCUL4kqD59UV51q19QL18yF+8qIe0QmFxtDsDDYfhG3O6bgzX2d2+wu4rNBeDIkrU0qDXiXuK7oftNt96fUs9owW0ZBf146UsoB3AASt+snMKz3zA6kOsbD0M1GPUtSBNKoDm2ptCRp7ZFaBGwbQmyljSC6K57eemFXROqchOiRz8dCQpCfCdIH5+xPJycDzpOi88OSFieaL4cgv168ooLLx5ICnMHEuBED24o7Qwvk1beCwdPlPYdUq0/1jn+fTZBTivHFQYt+Uz/vb46bhFhIVD2HK3STJIKS5gdJYzPM4LFOtqKgjY9frJVgdBvViY0lMtOyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMivSDxcRuJ9M0aMipP9s58pPs/wwC4HgviGGR0Co9A=;
 b=SEL5TS1659e4fSaWUU+xFiEaAOaQdOYLMcFHozn4sQ7RXWC1FxNoo1qInaBBZVfXv6GxNL9kZWOc53OqU3jqlAj+mDiQQg7Cy3ctGZWZLC5qLTERVSvGI8YAKzl8mtPOCmaThtI+37zx2vg3qGkJ/79jpJs9qMXvRzAt3V7KMws=
Received: from DM5PR08CA0035.namprd08.prod.outlook.com (2603:10b6:4:60::24) by
 MN2PR12MB3983.namprd12.prod.outlook.com (2603:10b6:208:169::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 29 Apr
 2022 17:46:39 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::1c) by DM5PR08CA0035.outlook.office365.com
 (2603:10b6:4:60::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Fri, 29 Apr 2022 17:46:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:46:38 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:46:37 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/73] drm/amdgpu: add helper function to initialize mqd from
 ring v4
Date: Fri, 29 Apr 2022 13:45:13 -0400
Message-ID: <20220429174624.459475-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429174624.459475-1-alexander.deucher@amd.com>
References: <20220429174624.459475-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14ff4c64-3dc4-4288-af14-08da2a083682
X-MS-TrafficTypeDiagnostic: MN2PR12MB3983:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB398355E2AA5C73F85E2DAD48F7FC9@MN2PR12MB3983.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t5VCQOS/px/4fG6WAlL+c3antdvefGkUcRrEbXFhf16BfIa3ZblVmErvIXpjcEOUxsFlKnEIBwOjsSYYToBtJIbjFg9bB2cwbjY66UC/oVG7/3Wat5NhBWOJYMpg9/zZov2XrZp+udiV3c6vEddLPHYL7S9Yv5Nv7236g7uABc+JoPCzrwnKA2pZ5iq2vSto4yElB3MCSdkiwYA8h0EDDE/V4lEA67EKnxiCrRPDVHYrB9gr9ECg5CdqnVZ/P58lEhsRSgoJ0D9mmaoGgPbB+lyU3cq9Sr/ffhsACYF0GR4qq0Eme0B71Gn6aeC0fvcQo+Y4UQJUH4aAvs1RudxsKwz1AGfbhG6DAWM8084bc/nb0YUt7UtuRkhs60jnDoJ/NzAabONxmnIznYSAt8BiHSwOWGEtUW3Mz8yH5Qe/5Cfphb1GeyfaFiKTBLE9SjhpaBIzCmDXKoH6ftzKy4nvc2USjyYDXVM9zVRi4WdevcdKZMn76eFvUHciICsESBQQKKKLlB+0X4zEig6ll6KjztBW2516J7dzgkpQy5CP/zhRffAsZokAoXs4uxWywyqownPJ4awuOx0n4fH4ehriKiV8hd8Q4gp5ZOOUIevoc0kT40bwTHDdSyMwluQmy/Gi5qXatTPJMkS8RrxQNc3yC6M7PtHUq3LdZ+Fel6duereAzbEnNaxU2WLHAxU/PYmJrMjKWGuGySfJW7I8tKy5kA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(508600001)(36860700001)(8676002)(4326008)(40460700003)(70206006)(70586007)(86362001)(81166007)(316002)(356005)(54906003)(7696005)(26005)(2906002)(6916009)(5660300002)(6666004)(1076003)(426003)(336012)(47076005)(66574015)(2616005)(82310400005)(16526019)(83380400001)(186003)(36756003)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:46:38.8048 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14ff4c64-3dc4-4288-af14-08da2a083682
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3983
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

Add the helper function to initialize mqd from ring configuration.

v2: use if/else pair instead of ?/: pair
v3: use simpler way to judge hqd_active
v4: fix parameters to amdgpu_gfx_is_high_priority_compute_queue

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 48 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  2 +
 2 files changed, 50 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 7f33ae87cb41..773954318216 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -458,3 +458,51 @@ int amdgpu_ring_test_helper(struct amdgpu_ring *ring)
 	ring->sched.ready = !r;
 	return r;
 }
+
+static void amdgpu_ring_to_mqd_prop(struct amdgpu_ring *ring,
+				    struct amdgpu_mqd_prop *prop)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	memset(prop, 0, sizeof(*prop));
+
+	prop->mqd_gpu_addr = ring->mqd_gpu_addr;
+	prop->hqd_base_gpu_addr = ring->gpu_addr;
+	prop->rptr_gpu_addr = ring->rptr_gpu_addr;
+	prop->wptr_gpu_addr = ring->wptr_gpu_addr;
+	prop->queue_size = ring->ring_size;
+	prop->eop_gpu_addr = ring->eop_gpu_addr;
+	prop->use_doorbell = ring->use_doorbell;
+	prop->doorbell_index = ring->doorbell_index;
+
+	/* map_queues packet doesn't need activate the queue,
+	 * so only kiq need set this field.
+	 */
+	prop->hqd_active = ring->funcs->type == AMDGPU_RING_TYPE_KIQ;
+
+	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
+		if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring)) {
+			prop->hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_HIGH;
+			prop->hqd_queue_priority =
+				AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;
+		}
+	}
+}
+
+int amdgpu_ring_init_mqd(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_mqd *mqd_mgr;
+	struct amdgpu_mqd_prop prop;
+
+	amdgpu_ring_to_mqd_prop(ring, &prop);
+
+	ring->wptr = 0;
+
+	if (ring->funcs->type == AMDGPU_RING_TYPE_KIQ)
+		mqd_mgr = &adev->mqds[AMDGPU_HW_IP_COMPUTE];
+	else
+		mqd_mgr = &adev->mqds[ring->funcs->type];
+
+	return mqd_mgr->init_mqd(adev, ring->mqd_ptr, &prop);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 317d80209e95..20dfe5a19a81 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -369,6 +369,8 @@ int amdgpu_ring_test_helper(struct amdgpu_ring *ring);
 void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
 			      struct amdgpu_ring *ring);
 
+int amdgpu_ring_init_mqd(struct amdgpu_ring *ring);
+
 static inline u32 amdgpu_ib_get_value(struct amdgpu_ib *ib, int idx)
 {
 	return ib->ptr[idx];
-- 
2.35.1

