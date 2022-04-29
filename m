Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B28C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:46:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ACF810F119;
	Fri, 29 Apr 2022 17:46:54 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5E2310F119
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:46:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLnbau9f4jQ2bUbC7UAYGyAEceRUqQizdSjNneapPskl3/wm2GSNEehSCSxMZfcKHzt9T3B9YLGljne6Q/biWP6uO58o9lVkDXhsic8jGU6OeUJGitzX3U8riKL+05tkbmFAOD9OwsT3NPuyUnJGNcAh0ou4MqxJTSxt9phGyLH7AhvHWGjr8EhKJKeYlECtBXL/kRphKpmPtUB6nzRGVihJH8KnI+/5JUmgvQw4U0vDTHQmdHJMHoNPAjE7xsK37hvGmmuY+kwqrNhhHxXnJh6VLAURy+ws73nrczvLicFLrK3nuAzr2brH0z4R3VBBi2cLsEDff6hMnrd49jSgQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOp8u2DFwZ8DkE1rxFURet+z5qF9VjdAYjMuJHWPgAg=;
 b=f7LnKeI+4l/JzfLtE3JQFDG/Ur9lH57fOD3U378hl5NRCiyrkq8hKUykdytXFa4KDk3Ujoa5DE1YNHGdhRNgOlS8NQ+GAUb1mNpbwxBJAGi7OavNMTc3/CPPFcl9nhtLI+m471WEvPrd1sAFSeMjwwJKeyP5u68bfw9mG+1X3DQH3SPNE5Dz3VZV0XzY4kckqNtzLqDuG6VNQY/qRKzNQs4y5FZQDW+kMRbBLuOlc+7gWzI8jgceWRBEf+qAKXUSV+/FQDlFztIV4aILUz/wzyXWqqT5RIbGyjsOiI/f+1WiJUDFIrDjkia8t3vNuqz0plWMTrFIjtSgnZyisCiQyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOp8u2DFwZ8DkE1rxFURet+z5qF9VjdAYjMuJHWPgAg=;
 b=yFuxzzrcTr73fsUyS2GEHkvc8fCLnFQIDEy2t1iTuIdxTz5U9kPgzdiHXiRKcLgFmHzsQfGaH7uCEYF+gFaNM4BjvmTJQKBE+gKsMWUqK2KA/2uS2r0Jm6PTwNXOnO16oW3DGRsUAyaRzGG+Xk0hSaY3MsfvDXlbENrb4uTsFIA=
Received: from DM6PR12CA0001.namprd12.prod.outlook.com (2603:10b6:5:1c0::14)
 by MN0PR12MB6003.namprd12.prod.outlook.com (2603:10b6:208:37f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 29 Apr
 2022 17:46:50 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::65) by DM6PR12CA0001.outlook.office365.com
 (2603:10b6:5:1c0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Fri, 29 Apr 2022 17:46:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:46:50 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:46:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 22/73] drm/amdgpu/gfx10: add mes support for gfx ib test
Date: Fri, 29 Apr 2022 13:45:33 -0400
Message-ID: <20220429174624.459475-23-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: ddcadb5f-885b-4cba-9f46-08da2a083d68
X-MS-TrafficTypeDiagnostic: MN0PR12MB6003:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB60036A07211CF11DE2BBFAFEF7FC9@MN0PR12MB6003.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mUgHLW/c2WV/afIQiSkm99Jr/sE4dGzVF2jnO/sTkw/CcC+O14a+YLT/rMzJX1d2xoCp12s7zXaj8R3hRMMfI8xBQYYtTdXar3UqhWRuXAg1eixb6+J9oaZ7vXe4NSM+nMPxlbrF0cogPg1NtYv9n9v9q+kzLZxuGrnbMdEbLTbBklo2+YPxci0uCIQfq2llgBr4QEYSRud012FXDdhLEJrdeWEbihEQuj8KpLJc/s/MNoRFVpq/qxv3pA4SLIujgE+JiFFS58z4oWfMmlgjL7KiKR79+WBCI6re1MwXlx3AtmyOPuUgNZ1TUEBUNX3vPUq3jGZ4PSmalRkz2nWTI591X/yVJIpmH/M32bUBXCi7WtWj85YWRF4I+/WugdICFMJmxqBOgfz/IThkgdegfJNSF265yTWx5B/M26bawL2aX5mBfzm8vtUUGn9sg6TnSfufLj5Ozr6e/PVDFfn2XQJphpLwQK1GMrgzEw+PPAnrfQh/wDx4MIrx/2KZJY2PRwN8AIIBEFwAlqkqoUo/PQWHtepa2k9fqpiWZixW+BmFd9sVLInvSXqxXDYN6PPXt+5KxTAe9M+MOR+cdPY7aPIbC12MHfTUoFj3/6Jwo/HiTu0aqbz6eS/CxSncdMMOK1Yk9Mq585/cAnNbYefVyvpyyrNd4U09+CeKzo33pI9J+8FKuFKtFK36lKUnAWfskGXWq8PzDZLmEnYXbKj3zg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(26005)(83380400001)(8936002)(40460700003)(186003)(5660300002)(1076003)(36860700001)(70206006)(2906002)(7696005)(2616005)(70586007)(6666004)(356005)(508600001)(316002)(82310400005)(86362001)(54906003)(6916009)(47076005)(36756003)(66574015)(16526019)(426003)(336012)(8676002)(4326008)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:46:50.3780 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddcadb5f-885b-4cba-9f46-08da2a083d68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6003
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

Add mes support for gfx ib test.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 46 ++++++++++++++++++--------
 1 file changed, 33 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 0e009bd69a9b..1208d01cc936 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3818,19 +3818,39 @@ static int gfx_v10_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	struct dma_fence *f = NULL;
 	unsigned index;
 	uint64_t gpu_addr;
-	uint32_t tmp;
+	volatile uint32_t *cpu_ptr;
 	long r;
 
-	r = amdgpu_device_wb_get(adev, &index);
-	if (r)
-		return r;
-
-	gpu_addr = adev->wb.gpu_addr + (index * 4);
-	adev->wb.wb[index] = cpu_to_le32(0xCAFEDEAD);
 	memset(&ib, 0, sizeof(ib));
-	r = amdgpu_ib_get(adev, NULL, 20, AMDGPU_IB_POOL_DIRECT, &ib);
-	if (r)
-		goto err1;
+
+	if (ring->is_mes_queue) {
+		uint32_t padding, offset;
+
+		offset = amdgpu_mes_ctx_get_offs(ring, AMDGPU_MES_CTX_IB_OFFS);
+		padding = amdgpu_mes_ctx_get_offs(ring,
+						  AMDGPU_MES_CTX_PADDING_OFFS);
+
+		ib.gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
+		ib.ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
+
+		gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, padding);
+		cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, padding);
+		*cpu_ptr = cpu_to_le32(0xCAFEDEAD);
+	} else {
+		r = amdgpu_device_wb_get(adev, &index);
+		if (r)
+			return r;
+
+		gpu_addr = adev->wb.gpu_addr + (index * 4);
+		adev->wb.wb[index] = cpu_to_le32(0xCAFEDEAD);
+		cpu_ptr = &adev->wb.wb[index];
+
+		r = amdgpu_ib_get(adev, NULL, 20, AMDGPU_IB_POOL_DIRECT, &ib);
+		if (r) {
+			DRM_ERROR("amdgpu: failed to get ib (%ld).\n", r);
+			goto err1;
+		}
+	}
 
 	ib.ptr[0] = PACKET3(PACKET3_WRITE_DATA, 3);
 	ib.ptr[1] = WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
@@ -3851,13 +3871,13 @@ static int gfx_v10_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		goto err2;
 	}
 
-	tmp = adev->wb.wb[index];
-	if (tmp == 0xDEADBEEF)
+	if (le32_to_cpu(*cpu_ptr) == 0xDEADBEEF)
 		r = 0;
 	else
 		r = -EINVAL;
 err2:
-	amdgpu_ib_free(adev, &ib, NULL);
+	if (!ring->is_mes_queue)
+		amdgpu_ib_free(adev, &ib, NULL);
 	dma_fence_put(f);
 err1:
 	amdgpu_device_wb_free(adev, index);
-- 
2.35.1

