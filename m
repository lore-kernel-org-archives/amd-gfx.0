Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09146C072A2
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Nov 2023 19:56:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D2FA10E319;
	Fri, 17 Nov 2023 19:56:45 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::620])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9D5C10E319
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Nov 2023 19:56:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6meZ/ByOar+t1slpmbnu6nroVsvCbFGLyVZ+bMJAR1KMTe4sYMxLqdZbb/LZbcnHQX3NR5tqlcwBwFnCpxzLswOMrVqjRur0mUlBQD//GqEmtOLX7UgHH38jhtjMP/iZUJEIWSAdsnIw1KYp/TTDI9lqNtXiD1f+sPfy0I83oNKYnkCVgi+z3Sr9HXZ2sJwDGOi4BrOtNeNaRapaz9mNs1qi3xTbhJzUIozFbX634P4iZToE1pbDcsaCFDLSBZ3KRKnB3DIT2S4Or5bQxzf5VVxovz+Evmd1q0MQIUKWRBPAk9rdZHHOfg28GkXdU1soi4fGOwZCNAl2Ulqwb9x7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WR3CwHQMZSJYgoV5GRDR/M0z2cbSSjOPUfP6dBmwrws=;
 b=JPTaBrDLuQh60/rMi5IOThPSUvk9DmcEg019dOBlX2wt9mIFqUIZ5d7s8VeOWCMiFMY0uJ6rqv0nG8Z3eOKr77SDawW3woxwNyj6Vk98YmM8OKWU70DhKXoDm3OnklRtLogyHlRI0fh9uRPufjbQELJ3S3oIMdjFjdXgh5KCZikRog0I0K6TEZ6wuUvj4L36BCGYBuJ5/08VADE2dR6lI7hJNsJkNqetRvC2cZi2rKqBu8GDLXM8oyFX+IoTlFLoBCxbcF8S7fST+6hNO8GpOuRA/TDqCXy/qqV+9NRzrC0F8gDOKdupdEN16d6864568WjNp+UxaqZypSYwjjkSeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WR3CwHQMZSJYgoV5GRDR/M0z2cbSSjOPUfP6dBmwrws=;
 b=jGc5MVxTWI6dP+IC1mMqKoIrB2+Ju22LMACGCMXameMlSqvXsJjabe/9eNnSJiL59r1MjQJanXJ4yyE54UleWIs4z3By+FI5TrJhGUUALuUjH0CJnponyqNsveKx2crLR6Q6CTrZUDUBoOtwEg6lBFHNPO/oEZmdjgtftHr1enc=
Received: from BL1PR13CA0149.namprd13.prod.outlook.com (2603:10b6:208:2bb::34)
 by DS0PR12MB9423.namprd12.prod.outlook.com (2603:10b6:8:192::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Fri, 17 Nov
 2023 19:56:41 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:2bb:cafe::83) by BL1PR13CA0149.outlook.office365.com
 (2603:10b6:208:2bb::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.8 via Frontend
 Transport; Fri, 17 Nov 2023 19:56:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Fri, 17 Nov 2023 19:56:40 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 17 Nov
 2023 13:56:40 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add shared fdinfo stats
Date: Fri, 17 Nov 2023 14:56:26 -0500
Message-ID: <20231117195626.13599-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|DS0PR12MB9423:EE_
X-MS-Office365-Filtering-Correlation-Id: e018f4b5-302a-476b-a2e9-08dbe7a75125
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gg4dhPaU/NMPAL1zGVcQghBrJ0y33CUuN4tDjBWwTTgJH24fbZ40sgwvGg3Wq8Y2Z2IYKs8Dl0VTn2hwTpC1OipqnGakR5/VMt1Ep+Ax52VPKpP/STCGh4gHqL3wuDl5v/0yTu2f8WfLBGGaLI5RcnKohmvBbWEkPya6H8CLy50hd+qJpwlQ4vwId6d0+xz4cdivXFfTVXYG+E8YJYRrJJytp9YuoyfGMO8qc3wGnYqmPJaO1V7kQhvRkolnxMs6+owa0hdmhzcyFDJepDqA1imWbAcBwXX1HaotkMRb6jBX4hbZVMlyhI7+cpm41fJiZFXfvbJImzMfVK37nauuwz9z8I0FeHbQGaWpKr7mwkRI21TdoqgPjRGbYPCsukdC4unevA1ENsWWxJvcvECadFeykgGSre9kImqP2V8Wj4ROx15UNpVuYxC0Cs26SFCtIIvdeAeayypk8zawjajLz/C2irLClF7gjqrHYfRxaZJs14oq5HNon23MaJalJnmtN/ChtPF+MEWbqLVQcTeB8Q9YBR834oDrx4HG66Z3VsPAI6gxc5Eu0amO8pFYom6pB4fskFQkey3JC28HKQddvOW8s6JBA+enZwAIoodb8hR974KcQnXV67hWAH1BWUfFKY/h5AigBX0QtJF/0rtuFdmWlxA0b+9nMi4QFnERkRWY3BJtr2uRrDq/UcOYmWqnVzu8Foz14JACIxhUyoI1O0mXaruczqoIVtqRdnRzOxAcNF37cO4RGZ3kxG+fRhCgTb4MhHgCG3F3Cijt2wNA0Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(40460700003)(70586007)(70206006)(316002)(6916009)(7696005)(36756003)(6666004)(426003)(336012)(2616005)(16526019)(26005)(1076003)(478600001)(82740400003)(81166007)(356005)(83380400001)(36860700001)(86362001)(47076005)(2906002)(5660300002)(40480700001)(8676002)(8936002)(4326008)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 19:56:40.9564 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e018f4b5-302a-476b-a2e9-08dbe7a75125
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9423
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

Add shared stats.  Useful for seeing shared memory.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 11 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  6 ++++++
 3 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
index 5706b282a0c7..c7df7fa3459f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
@@ -97,6 +97,10 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struct drm_file *file)
 		   stats.requested_visible_vram/1024UL);
 	drm_printf(p, "amd-requested-gtt:\t%llu KiB\n",
 		   stats.requested_gtt/1024UL);
+	drm_printf(p, "drm-shared-vram:\t%llu KiB\n", stats.vram_shared/1024UL);
+	drm_printf(p, "drm-shared-gtt:\t%llu KiB\n", stats.gtt_shared/1024UL);
+	drm_printf(p, "drm-shared-cpu:\t%llu KiB\n", stats.cpu_shared/1024UL);
+
 	for (hw_ip = 0; hw_ip < AMDGPU_HW_IP_NUM; ++hw_ip) {
 		if (!usage[hw_ip])
 			continue;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index d79b4ca1ecfc..c24f7b2c04c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1287,25 +1287,36 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
 			  struct amdgpu_mem_stats *stats)
 {
 	uint64_t size = amdgpu_bo_size(bo);
+	struct drm_gem_object *obj;
 	unsigned int domain;
+	bool shared;
 
 	/* Abort if the BO doesn't currently have a backing store */
 	if (!bo->tbo.resource)
 		return;
 
+	obj = &bo->tbo.base;
+	shared = obj->handle_count > 1;
+
 	domain = amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type);
 	switch (domain) {
 	case AMDGPU_GEM_DOMAIN_VRAM:
 		stats->vram += size;
 		if (amdgpu_bo_in_cpu_visible_vram(bo))
 			stats->visible_vram += size;
+		if (shared)
+			stats->vram_shared += size;
 		break;
 	case AMDGPU_GEM_DOMAIN_GTT:
 		stats->gtt += size;
+		if (shared)
+			stats->gtt_shared += size;
 		break;
 	case AMDGPU_GEM_DOMAIN_CPU:
 	default:
 		stats->cpu += size;
+		if (shared)
+			stats->cpu_shared += size;
 		break;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index d28e21baef16..0503af75dc26 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -138,12 +138,18 @@ struct amdgpu_bo_vm {
 struct amdgpu_mem_stats {
 	/* current VRAM usage, includes visible VRAM */
 	uint64_t vram;
+	/* current shared VRAM usage, includes visible VRAM */
+	uint64_t vram_shared;
 	/* current visible VRAM usage */
 	uint64_t visible_vram;
 	/* current GTT usage */
 	uint64_t gtt;
+	/* current shared GTT usage */
+	uint64_t gtt_shared;
 	/* current system memory usage */
 	uint64_t cpu;
+	/* current shared system memory usage */
+	uint64_t cpu_shared;
 	/* sum of evicted buffers, includes visible VRAM */
 	uint64_t evicted_vram;
 	/* sum of evicted buffers due to CPU access */
-- 
2.41.0

