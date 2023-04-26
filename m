Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49447C77B7F
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Apr 2023 21:22:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E958A10EA43;
	Wed, 26 Apr 2023 21:22:13 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 315E910EA29
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Apr 2023 21:22:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8+6c/mxyGq4FKxwkGN59soppnOJzjIwHcSU8CxiwKcNuQ2P+EJCh/EErSitRj3rwlyV6tuXTz7hhU2ijcv7pQGNmN+AmolS1Mj3Y6SmuIsqSJMssjPi8iWYgeh47tIpAa2FgA2+UgE5ntw9YmJ5O/9b0jjVWBFdK3/kJUIHKK0qcErhDp5ZyD0ZCHz2h60nQgB/cWIPLRFzeogsGNJyn+xqzTOJ/8ahgF+vJEKMpu2yB5KvJ/9qV+yyVv+VZVCuF9eBAd3hpMZ6Nf8TMQo4y8cjE4YPrS+JogpDuIz6USP/xM3/VT7sQsvrhi1Hw5Z4EcXEh5ZMPZH19xO03t+K0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZXfF9d1z6a6uhJue73xZPaFfyAfX5WLl3VFLARfNsY=;
 b=G3b/4FW2PgC5xoewGZ1eK6ufEcusz0jcYSsHpxJUIjgqHrfRghREb/r18AnTdVUi8M0i2RTcN9tlAv/fK1vgx9tDj72WQnxeLBh0VMIe50s+xHELaefNrwG70vVlk3ph6mPTwC1/MtVIvXYgclOGf16/LOUHSEgyOMFyvgOcjFQmqzLB8YkFOPnEYhVD2vnE2vjRivR1ERWFLMcQUQfZ2zZhlhpp8DKO+KiIhcNBy4RsimOlLLZt3DJeYh2JyQCSA9Gzfh4phUvLi0UWRGXR2JJprG/hdvnyY4Ay6GvxTpSIOozd9D06Vw5SqQuht9RFbiLWV0rSBy/s9yJ8YY4Sug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZXfF9d1z6a6uhJue73xZPaFfyAfX5WLl3VFLARfNsY=;
 b=WAEyiBuV91V+wzQm0U7tJUCM7j4GDw/6ZK3//51z7UKlw0/n2QKdpbCklPKdS8gL0HE9CpMcH/ghARKfDhfagLw77Xf6BQhIOVJmbgOfdnD8Jn2js870n3I4xKq8Qy5T3Wz4DX7fKx2saQsPo97ygZLcWo5vuDP0EGOGW4acXAQ=
Received: from DS7P222CA0009.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::11) by
 CY5PR12MB6249.namprd12.prod.outlook.com (2603:10b6:930:23::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.21; Wed, 26 Apr 2023 21:22:06 +0000
Received: from DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::41) by DS7P222CA0009.outlook.office365.com
 (2603:10b6:8:2e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.20 via Frontend
 Transport; Wed, 26 Apr 2023 21:22:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT076.mail.protection.outlook.com (10.13.173.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.22 via Frontend Transport; Wed, 26 Apr 2023 21:22:06 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 26 Apr
 2023 16:22:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/12] drm/amdgpu: put MQDs in VRAM
Date: Wed, 26 Apr 2023 17:21:43 -0400
Message-ID: <20230426212143.7696-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230426212143.7696-1-alexander.deucher@amd.com>
References: <20230426212143.7696-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT076:EE_|CY5PR12MB6249:EE_
X-MS-Office365-Filtering-Correlation-Id: ee3dc4fc-19ea-4407-217d-08db469c494e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D9DsHSJCtShwpiuwi1h+DTzJFR9ZR2x8MPllh/5zHnpVjYZ/jVPqcvlxJd3AyTA4qgjFlaoYNl237CkWrHyZKY57cpoChq0Tq/TS2S13nC6f6LyByDoB1onGmUAovWS+XdP0bmb0CucdE967qZmwl4rNE4HK+7H78D7O5FiIZ11sKbDw0r5APXSsSVE1CV4Mhux6CePC8AmZmGTskoUZ7UduJv2OPpfGmxIlEh/V8sOo9SHXvUgiyI0oepZAFtxscge22wB73xSLKOaHDYEvLfN8MF6Gj6f1IrtoXnm48arBVb4asLwJFi/oj3Npblrg6dC74YeR1YMjYP7epiWl6Gw+aVNTjzu4QCG0GJQKf2LauzUotoF5zmsvdmdWn3QIxEtaB0VF50IeouQHtG2ozt3wsQh+OT7KBW4kNBrx5bJRBygq3QNrE+NSRhO9igzoa7e8bbbiqI4dw+qA4yV9+UleZ276P06s+vxF9XPDh43HCG98jrZi8zuKz6Nr6dbzAZjpp1XA0UYN4q+iwxtlJR4Pqsdflo3A8cMx8mhPmfW8pSbwu5vSDVt/LEk9R1a+u6N1eiCOSwUbzcAgziltibXaUMKN6l5E8t2L5q3gg2tMrYj+lvAI00oiq2sdvFuN3+Z4JValmKFX6RdmzoqhvJLJw+Ezl9V1PXz1w7zPg68Mg2By2yPYnP4wCrzudNTePtADj0nW+POMnFqWFYiSmDPXCSFFTAsrj2IqTjUkNV0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(2616005)(4326008)(82740400003)(70586007)(70206006)(316002)(6916009)(336012)(186003)(36860700001)(47076005)(426003)(16526019)(6666004)(7696005)(478600001)(356005)(81166007)(41300700001)(8676002)(8936002)(5660300002)(26005)(1076003)(2906002)(82310400005)(86362001)(36756003)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 21:22:06.0975 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee3dc4fc-19ea-4407-217d-08db469c494e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6249
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reduces preemption latency.

v2: move MES MQDs into VRAM as well (YuBiao)
v3: enable on gfx10, 11 only (Alex)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c  | 1 +
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 1 +
 3 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 0560568b3925..92c5f0ce8bbb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -382,6 +382,8 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 	int r, i;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
 	struct amdgpu_ring *ring = &kiq->ring;
+	u32 domain_vram = adev->ip_versions[GC_HWIP][0] >= IP_VERSION(10, 0, 0) ?
+		AMDGPU_GEM_DOMAIN_VRAM : 0;
 
 	/* create MQD for KIQ */
 	if (!adev->enable_mes_kiq && !ring->mqd_obj) {
@@ -413,6 +415,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 			ring = &adev->gfx.gfx_ring[i];
 			if (!ring->mqd_obj) {
 				r = amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
+							    domain_vram |
 							    AMDGPU_GEM_DOMAIN_GTT, &ring->mqd_obj,
 							    &ring->mqd_gpu_addr, &ring->mqd_ptr);
 				if (r) {
@@ -434,6 +437,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 		ring = &adev->gfx.compute_ring[i + xcc_id * adev->gfx.num_compute_rings];
 		if (!ring->mqd_obj) {
 			r = amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
+						    domain_vram |
 						    AMDGPU_GEM_DOMAIN_GTT, &ring->mqd_obj,
 						    &ring->mqd_gpu_addr, &ring->mqd_ptr);
 			if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index 0599f8a6813e..4560476c7c31 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -901,6 +901,7 @@ static int mes_v10_1_mqd_sw_init(struct amdgpu_device *adev,
 		return 0;
 
 	r = amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
+				    AMDGPU_GEM_DOMAIN_VRAM |
 				    AMDGPU_GEM_DOMAIN_GTT, &ring->mqd_obj,
 				    &ring->mqd_gpu_addr, &ring->mqd_ptr);
 	if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index e853bcb892fc..3adb450eec07 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -999,6 +999,7 @@ static int mes_v11_0_mqd_sw_init(struct amdgpu_device *adev,
 		return 0;
 
 	r = amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
+				    AMDGPU_GEM_DOMAIN_VRAM |
 				    AMDGPU_GEM_DOMAIN_GTT, &ring->mqd_obj,
 				    &ring->mqd_gpu_addr, &ring->mqd_ptr);
 	if (r) {
-- 
2.40.0

