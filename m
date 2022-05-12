Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E4AC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 12 May 2022 03:09:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F1A410E118;
	Thu, 12 May 2022 03:09:16 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA41C10E118
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 May 2022 03:09:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOC280V7Z9c4jBz+qyT5tNvsbYw+x7dqhO96zYyG5gmX+LLFPgke09xNOXuT3eDa2Y73S+E6C2L3/vaEuwoxmUlOwGc/o53xdFgTjurk7iarbAHIKQcE90SqRbJYm/v+XHBQo9PtkzoFnDaQ7w24cj6Yi1tK8qs5N11Rlz5ZwUg0uoZ6CgFai6pLxGoPE749RO4XO9vBY00nkSPPRQGipI02dSdxSsh/yWwgS8NGMVLc3qcnd1DWTXI13IGqdxiBuznm6XIWJxBcvOglejW8ru6XnOQ78YUV9DJm3lg3c9SoJVi4XdnYvcqe4rMgMYJiqeT9FcP9TMSx3FFC/4tEuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RIpYkVDaWJ5PgzBg/evD8+Vi7O2XdAtq/Esa6tY5sJY=;
 b=c3XQNMnRMOt928J46RWHuNfKmWUik2EBSN6L9ApLOu0TNCLVpoj/am+iew1b2eoOAL0oNu577j7YEHSkNepj3lZhpLAna3HmJmogEoGcgN+RAci5bH5XXjcnD8MrCN3rK8zDb7jybv9M2qwsrzI++hGUvvHsmw+hgVTYx9ox2PUnU+CQ6UTnmeBYLlahUA0zieuU02jmuET95VO1cenNGD8fQxvFAXa4r9R7F1pYcCjNvqjCgg2CZdmZz1P3rb9s3dHrQD3X1lPFXvgNKn6J4+lgBsHVt/3hRkFcDd1zzknnV5jdD7GpHqX20YVV8RvgEA6JsU77vjRKjEnjc7DUew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RIpYkVDaWJ5PgzBg/evD8+Vi7O2XdAtq/Esa6tY5sJY=;
 b=unQwhDLasCzEkyYOqQaiu0tcsRLylv1DL4F8kYIiX/geGsAbGM4Cp7JAm4/WvXmGkEh9dcFBnXNaegBmBGCwnG8ER7RBYg41RU39i3OjgC8owSVo26QCGq38/LJT3GEvwKqszMSdTBUsk+yn3/pBJP+/fLaurztL4sazyMxwSTM=
Received: from DM6PR14CA0063.namprd14.prod.outlook.com (2603:10b6:5:18f::40)
 by BYAPR12MB2968.namprd12.prod.outlook.com (2603:10b6:a03:ab::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Thu, 12 May
 2022 03:09:13 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::80) by DM6PR14CA0063.outlook.office365.com
 (2603:10b6:5:18f::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Thu, 12 May 2022 03:09:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Thu, 12 May 2022 03:09:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 22:09:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/gfx11: fix me field handling in map_queue packet
Date: Wed, 11 May 2022 23:08:55 -0400
Message-ID: <20220512030857.525411-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4046b795-c14b-4aa6-91e2-08da33c4ca6b
X-MS-TrafficTypeDiagnostic: BYAPR12MB2968:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2968CEA4859280F824D7E52DF7CB9@BYAPR12MB2968.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: phKlKsbdbMPUVHghl+jarKrKs8mvEOLZpBmLeoH9eqbWbiK5f6ZOcVUqlceDSaxlF3ywyaoIQavXexUCIKuKg8JNuNq5puM/nH/dIAmTCFIKaTXYqnikl9E2jPCU6J5AP4TkPlm5AbQbBcICp0InOWq7+wqIKEH+fzNqQybj97St+O9YafLYHRRpUb4zlAC2oJ4cvAwvym6snp1QghY2+wIPZ2CvDWk2cUzPVB5cMsbcTzGNsYRqZJfQAxx0j5KEGR6KLTtd17dNTNK9+n9XmZMrao3OMe5LokHGIg+QQYd9Miob0xEvcFQ+3StmUwZgDrDvs4e204PXKOstagqy30G+FBty/9jS5uVz4cY/l56uzqacoTH8MawhHaf5CWH7SkEieQh+qlKkh5xKxlyDXQGY8Hssg5kzwP+jKlIlPRjKwapxniLE6ZBjvGS9Y9etaR5om0EgsndqQNm9cfAJzUL4+RhBBrr9iPWqKlVGnZpP2Ailw8EfVM73cEcVrANRDuxGNpfzqge8qXLY+3YZZh6RrM26HTKyIW7zWV5AU2jNOiQdpHNdrHHaqHKp2nRvmqisQwmewCe5nudPHVY4OQATUq16P8Fu4QUPV1lpF1pUecUhAnI0adZuJ+Q1vDwz0jfKPk4byxn7UANVArD2fF8SnQbmsqFTZ4V6WXqElTKQahw+rL47HinryJbHVH6avs+Q1fY8V9PPPWLYd15CuQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(36756003)(186003)(47076005)(426003)(16526019)(70206006)(336012)(8936002)(36860700001)(5660300002)(40460700003)(83380400001)(26005)(2616005)(1076003)(8676002)(4326008)(70586007)(82310400005)(54906003)(86362001)(6916009)(7696005)(81166007)(2906002)(6666004)(356005)(316002)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 03:09:12.8062 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4046b795-c14b-4aa6-91e2-08da33c4ca6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2968
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
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

Select the correct microengine (me) when using the
map_queue packet.  There are different me's for GFX,
compute, and scheduling.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 7614f38ff381..8a1bec70c719 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -145,16 +145,19 @@ static void gfx11_kiq_map_queues(struct amdgpu_ring *kiq_ring,
 {
 	uint64_t mqd_addr = amdgpu_bo_gpu_offset(ring->mqd_obj);
 	uint64_t wptr_addr = ring->wptr_gpu_addr;
-	uint32_t eng_sel = 0;
+	uint32_t me = 0, eng_sel = 0;
 
 	switch (ring->funcs->type) {
 	case AMDGPU_RING_TYPE_COMPUTE:
+		me = 1;
 		eng_sel = 0;
 		break;
 	case AMDGPU_RING_TYPE_GFX:
+		me = 0;
 		eng_sel = 4;
 		break;
 	case AMDGPU_RING_TYPE_MES:
+		me = 2;
 		eng_sel = 5;
 		break;
 	default:
@@ -168,7 +171,7 @@ static void gfx11_kiq_map_queues(struct amdgpu_ring *kiq_ring,
 			  PACKET3_MAP_QUEUES_VMID(0) | /* VMID */
 			  PACKET3_MAP_QUEUES_QUEUE(ring->queue) |
 			  PACKET3_MAP_QUEUES_PIPE(ring->pipe) |
-			  PACKET3_MAP_QUEUES_ME((ring->me == 1 ? 0 : 1)) |
+			  PACKET3_MAP_QUEUES_ME((me)) |
 			  PACKET3_MAP_QUEUES_QUEUE_TYPE(0) | /*queue_type: normal compute queue */
 			  PACKET3_MAP_QUEUES_ALLOC_FORMAT(0) | /* alloc format: all_on_one_pipe */
 			  PACKET3_MAP_QUEUES_ENGINE_SEL(eng_sel) |
-- 
2.35.3

