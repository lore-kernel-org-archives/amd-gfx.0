Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3754C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:46:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6ECBD10F1D0;
	Fri, 29 Apr 2022 17:46:47 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5987E10F138
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:46:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LYWnvOyUnZZC2OB7cYGwVZQ7F5zCfPtqPOnZJPfMTJve0Nh69kikT5WZPHAGwIS77RWlMcdsK8YI51e1xvJjPRUgXBu81gBenp53ZCk9JHEwrGu5rmmwFf9r1Qtrd5Pqs5ckhig86IAuuC6ZSmrcunha461id9oU85XTNeXXro8dvdQcb/8LJlPuxZflQ9mxkVQv84vaHSRrLOwlOx9pAG7oO0eYnK8FFoAcglOQItCoIRhbj/mWOT3kzW3GJfauNgPbcbUbKkSUVJbehrU7bUS+VwlRegToxrliHMlB4hvyHj9WQruERMk/Jy3Dnt/UYxo2DCSuJDbWdUGb4p8Ulg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmqGV/FPAI/58ngyBy4CvTCq500JRAeDLp8cYu8oLok=;
 b=VXmV7kv45+AlqgnGGvDY+meTTn7YEw6mtJsC/UVdQY44QAjBvhkQRL8y1XMoAWc1D7S4Vv7xcqczgjeI5JJLREw/RkkpxlV83gF/ZOhuJ/Lw3I0vn5MTKVyVU+UPAqVl7BwWTn0Ru35HiVFrdKgJ6EG8AiE9Kg4TB8Y0Yo0ENuc3abTXo0GuhLyF9T7aj8xZ4NK8PIMqTXGCh1Nxu/g9i95erx7kHX07ceNQoxydhecGZHsbZ/33sW5eqKcCQzfC3UyJAqmAqyQmPRrJoY6onB7lsjso+2xPatvHb6YO4WILoMOH/RkSC4gF14ejsk+WVeLTFujrJZsBZMszMnxshg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmqGV/FPAI/58ngyBy4CvTCq500JRAeDLp8cYu8oLok=;
 b=dvzPScR80kSUXFcsIeA1iA3eHyyZOarRTD259eg4mMfXwkZmWj4gOx9u2y1SCHbJMjHgHDXZ6MYF5HGQ/4NItxDmaEQXHXOjq1mL0oB+jWEKK8SV4SB9IuhTqARbJe35DUIPx47/tnuSM7E1/UoaI0FEZYjVluDGx/SLkY3w68o=
Received: from DM5PR08CA0028.namprd08.prod.outlook.com (2603:10b6:4:60::17) by
 BN9PR12MB5353.namprd12.prod.outlook.com (2603:10b6:408:102::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 29 Apr
 2022 17:46:43 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::6c) by DM5PR08CA0028.outlook.office365.com
 (2603:10b6:4:60::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Fri, 29 Apr 2022 17:46:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:46:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:46:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/73] drm/amdgpu/gfx10: use per ctx CSA for ce metadata
Date: Fri, 29 Apr 2022 13:45:21 -0400
Message-ID: <20220429174624.459475-11-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6d47aba9-2113-4a0a-5d64-08da2a083925
X-MS-TrafficTypeDiagnostic: BN9PR12MB5353:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5353F346543041D371BCA600F7FC9@BN9PR12MB5353.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zemBhV5Z/eoHiL/fspu+I7DFoEitLV9I2LW+iA3ITr3H96Li3hvhmam7vRsgrPOx34/DxVnJr4UWMbet0PpqT5sFp3SQnCNCwgUNUkWJP/f6ET8Mqh3EjPDbsS9VKzMu0+XEj3v5LIA4Z3fA8rfHeBHO5qtRd2yXPtZpu14IATv0RJUlqIwrG+WsNRteo6Ya/PDXoMjB6ZwKXF+ejGxMjv2KiacEffWlH2FiKT8MIcWq6U9khBXVnNbJMOPsUpvsYUE16xid5SWHqmTrrfxJa9noGAAsyRwvaAt6/6x7V7pvNHqzPOgj7nxSjUWybABsPW1x7lHuh8ScmrQAsX9rSlKDG0wNCbr8CyCkwdUqQU85jp+hi8E65mXMymPZ23P3p75eTqvlWAO498jxwclg1InjuPi1u7DNRXp1y1/pUrWJLu5HJ/Cr5YYw2/siV0HFrmjZwUwCEPzhod9I2M6zW2KBsALXgvbMCqEyAeDp8VV8UT4U0S57IbWQyerT71sXD6TEIGM7sjFKphho4qhm8Dsq1caqIjKMlWB7A+k1yczqLDukdTdTC4VJoPQ7yUAqG01EsMr5lJGesSRRa00z68P0hl6oii5GMXz1+m8J/RbkoSj0KBZ+GTrwTRV3eXo5egXu/mbgfYRrYAACXGKYcdDuped1HL5fd97mxcBZPl5bbgzFV7ygpS1l3X5ZtlJ2HkuJHJnOLARJIT/Aprl+ng==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(2616005)(1076003)(40460700003)(83380400001)(81166007)(356005)(336012)(426003)(47076005)(54906003)(70586007)(70206006)(66574015)(4326008)(8676002)(36860700001)(36756003)(316002)(6916009)(26005)(82310400005)(7696005)(6666004)(508600001)(2906002)(86362001)(5660300002)(186003)(8936002)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:46:43.2264 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d47aba9-2113-4a0a-5d64-08da2a083925
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5353
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
for CE metadata to correctly enable context MCBP preemption.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 28 +++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index cc70594d7e4c..56a7153474c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -8849,26 +8849,36 @@ static void gfx_v10_0_ring_emit_ce_meta(struct amdgpu_ring *ring, bool resume)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct v10_ce_ib_state ce_payload = {0};
-	uint64_t csa_addr;
+	uint64_t offset, ce_payload_gpu_addr;
+	void *ce_payload_cpu_addr;
 	int cnt;
 
 	cnt = (sizeof(ce_payload) >> 2) + 4 - 2;
-	csa_addr = amdgpu_csa_vaddr(ring->adev);
+
+	if (ring->is_mes_queue) {
+		offset = offsetof(struct amdgpu_mes_ctx_meta_data,
+				  gfx[0].gfx_meta_data) +
+			offsetof(struct v10_gfx_meta_data, ce_payload);
+		ce_payload_gpu_addr =
+			amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
+		ce_payload_cpu_addr =
+			amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
+	} else {
+		offset = offsetof(struct v10_gfx_meta_data, ce_payload);
+		ce_payload_gpu_addr = amdgpu_csa_vaddr(ring->adev) + offset;
+		ce_payload_cpu_addr = adev->virt.csa_cpu_addr + offset;
+	}
 
 	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, cnt));
 	amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(2) |
 				 WRITE_DATA_DST_SEL(8) |
 				 WR_CONFIRM) |
 				 WRITE_DATA_CACHE_POLICY(0));
-	amdgpu_ring_write(ring, lower_32_bits(csa_addr +
-			      offsetof(struct v10_gfx_meta_data, ce_payload)));
-	amdgpu_ring_write(ring, upper_32_bits(csa_addr +
-			      offsetof(struct v10_gfx_meta_data, ce_payload)));
+	amdgpu_ring_write(ring, lower_32_bits(ce_payload_gpu_addr));
+	amdgpu_ring_write(ring, upper_32_bits(ce_payload_gpu_addr));
 
 	if (resume)
-		amdgpu_ring_write_multiple(ring, adev->virt.csa_cpu_addr +
-					   offsetof(struct v10_gfx_meta_data,
-						    ce_payload),
+		amdgpu_ring_write_multiple(ring, ce_payload_cpu_addr,
 					   sizeof(ce_payload) >> 2);
 	else
 		amdgpu_ring_write_multiple(ring, (void *)&ce_payload,
-- 
2.35.1

