Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5915BC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:46:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E193D10F1C3;
	Fri, 29 Apr 2022 17:46:53 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B6AF10F119
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:46:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/xmSKO7BHc9p/jtsIQYdxYNgHcVm7FrkmWd3kDKXMQO89rD81U3oeS6mN/AyTEk+CDjHIIQ/nhMVT5P9OhIx/+1z6pwHJm0yRNFenpzXagXAVzF1Ka2ZrA2VJ1ODMrzE9kMc27wYZ+LGENcCLjHnZAvDmYreZRZgzU+RUtLarvMQ/K/erAbRNAMxblaxQ3fwmFlVThsx6NZWlpUCxJpLD4k7BGWhxf/F3SwzmixcN3QC/PAkVoBtgSY/4WXopxjdtWrAgF63+qXEPvxyQxR5K6YMTq8/6t/x5SSK1TbNzEKm/WMqVtY9ltdqYTgs1rmxRYZJKuT/lWFJ/50qigf6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=paCK/K7gp21x0W9uqY4aoqL6ieJM19Ufts9wIkRNW/0=;
 b=nOqrOjgdYgeg1Zj/0x/BblgAfbMm3BIlAZQ4cBEgITWeG3QB9VUe0SO+yAVUs5tQ5dI1k19HsSRuAWZ9a3L59uF56MTwN4xamRiig6/XkLqd3gY4ZeG1LBRTuHywy7rCzdg/+4yoTPBhDUKdvO6tqkM2n9uX2AWgERM2uJorTBhG1t98XDPUGd+tPkES7q+1itwg/AtZuNFnCoHYWGFSpqwPXXUo4OGEJRcYFKGYPJ1LkwxqeOfD34sCfJijR2GlC8LB5K6bxTBKxxwBo5FMlmrvkxWfdYWxlK/1/2Z/U0YI5iUG24NqIl3WpO5uBNyl4t9/Autdq6U0iyLbsYr/RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=paCK/K7gp21x0W9uqY4aoqL6ieJM19Ufts9wIkRNW/0=;
 b=Qk4zde06m0EuMzwOVqn2DU0VQwa7TDbYMli1zrE3/FQsrNjLehiz9rSn+Vk0rJlOKI1wq4ymHPLFaFGkMIFzFftDnHHzIGIgiSVM8V3EtCsZnUzDczXDJ0W1TC2YxZSgweIuUwh1qQ4nxe8j2GDH3MppqCJPtwBmhxyRTvPMWpA=
Received: from DM5PR08CA0031.namprd08.prod.outlook.com (2603:10b6:4:60::20) by
 MN2PR12MB4471.namprd12.prod.outlook.com (2603:10b6:208:26f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 29 Apr
 2022 17:46:44 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::17) by DM5PR08CA0031.outlook.office365.com
 (2603:10b6:4:60::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Fri, 29 Apr 2022 17:46:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:46:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:46:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/73] drm/amdgpu/gfx10: use per ctx CSA for de metadata
Date: Fri, 29 Apr 2022 13:45:22 -0400
Message-ID: <20220429174624.459475-12-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: d2ca1914-2158-4afb-1854-08da2a0839c5
X-MS-TrafficTypeDiagnostic: MN2PR12MB4471:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4471BDC9750C0350F55C1756F7FC9@MN2PR12MB4471.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fYOukrw65h70DvVG3f8FxYLQtgjqw/SkiJNKn0a6H/U5Wuc1ZM4Vdt0+O0aXzQaESr9cT3vuGaWSUAcds3LtLlXmX1edb+GGxKNC1z5g4xE2LPDwbd9wh9pgLlWjv64Vlv+ZkZk8k2/XCvWLv3npDHxzqMluTaDLJ758d8HhTjTfewSLgAvM987Ry2MLiAb/o4PP8eieGLI5MKVe3XKbwQr6oGtvk/Jk/5y9j7dV+h4JjrMs28paTjSdYsRietnyRCf+pCbbLSxLOqjzdIQmsGgzMP53z11NPpcK0bq4KVbHrKP8T0uPV6cPq/T9hwvmjkK7FR/Zee1ruQSa3ZGTJBBzEdKC7ELdsErtpvk2tI1T/RQUJLjws+DH/FMybpkkKGEnjxznYQf/mfWhBjuoe1dRCt/dzRz7on0IM3nDicorUclFJBHYPhXHaa4ywyjYOMnL4VssM13CIR4Cnn/3L0KTNnSncX1flhqYVLFJ1NsJ1+N4eQr1tXWGy7jbNY3EFAvhVi7K7lz7PrjEq7ox0bMu4pKcTFS4CtQSE+loYq4mud83Hb9iLADAoBZydZ1vwbJ2QXFZkrKRIPM78Pv+rhNmyK7eFb6Vg3ba93/s/Usk2FZlS9DgZUWGug0+0l8KFLQFaDGa/Z1+cJyjVULDAmADGmnLZ4tD/slnert+TLTN08IKUEv/yvoeFwn4xjghENyfQQ2tuqg8DH2oVff9NQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(36860700001)(8676002)(1076003)(4326008)(6666004)(36756003)(66574015)(5660300002)(2906002)(336012)(426003)(47076005)(26005)(186003)(16526019)(356005)(8936002)(508600001)(40460700003)(86362001)(83380400001)(316002)(7696005)(54906003)(6916009)(2616005)(82310400005)(70586007)(70206006)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:46:44.2732 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ca1914-2158-4afb-1854-08da2a0839c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4471
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

As MES requires per context preemption, use per context CSA address
for DE metadata to correctly enable context MCBP preemption.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 39 ++++++++++++++++++--------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 56a7153474c6..d06807355f5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -8889,12 +8889,33 @@ static void gfx_v10_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct v10_de_ib_state de_payload = {0};
-	uint64_t csa_addr, gds_addr;
+	uint64_t offset, gds_addr, de_payload_gpu_addr;
+	void *de_payload_cpu_addr;
 	int cnt;
 
-	csa_addr = amdgpu_csa_vaddr(ring->adev);
-	gds_addr = ALIGN(csa_addr + AMDGPU_CSA_SIZE - adev->gds.gds_size,
-			 PAGE_SIZE);
+	if (ring->is_mes_queue) {
+		offset = offsetof(struct amdgpu_mes_ctx_meta_data,
+				  gfx[0].gfx_meta_data) +
+			offsetof(struct v10_gfx_meta_data, de_payload);
+		de_payload_gpu_addr =
+			amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
+		de_payload_cpu_addr =
+			amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
+
+		offset = offsetof(struct amdgpu_mes_ctx_meta_data,
+				  gfx[0].gds_backup) +
+			offsetof(struct v10_gfx_meta_data, de_payload);
+		gds_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
+	} else {
+		offset = offsetof(struct v10_gfx_meta_data, de_payload);
+		de_payload_gpu_addr = amdgpu_csa_vaddr(ring->adev) + offset;
+		de_payload_cpu_addr = adev->virt.csa_cpu_addr + offset;
+
+		gds_addr = ALIGN(amdgpu_csa_vaddr(ring->adev) +
+				 AMDGPU_CSA_SIZE - adev->gds.gds_size,
+				 PAGE_SIZE);
+	}
+
 	de_payload.gds_backup_addrlo = lower_32_bits(gds_addr);
 	de_payload.gds_backup_addrhi = upper_32_bits(gds_addr);
 
@@ -8904,15 +8925,11 @@ static void gfx_v10_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume)
 				 WRITE_DATA_DST_SEL(8) |
 				 WR_CONFIRM) |
 				 WRITE_DATA_CACHE_POLICY(0));
-	amdgpu_ring_write(ring, lower_32_bits(csa_addr +
-			      offsetof(struct v10_gfx_meta_data, de_payload)));
-	amdgpu_ring_write(ring, upper_32_bits(csa_addr +
-			      offsetof(struct v10_gfx_meta_data, de_payload)));
+	amdgpu_ring_write(ring, lower_32_bits(de_payload_gpu_addr));
+	amdgpu_ring_write(ring, upper_32_bits(de_payload_gpu_addr));
 
 	if (resume)
-		amdgpu_ring_write_multiple(ring, adev->virt.csa_cpu_addr +
-					   offsetof(struct v10_gfx_meta_data,
-						    de_payload),
+		amdgpu_ring_write_multiple(ring, de_payload_cpu_addr,
 					   sizeof(de_payload) >> 2);
 	else
 		amdgpu_ring_write_multiple(ring, (void *)&de_payload,
-- 
2.35.1

