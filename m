Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93CE1C3DA6F
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 21:59:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 221C110E5E3;
	Thu, 24 Aug 2023 21:58:59 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::61b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4999C10E5DE
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Aug 2023 21:58:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhE+FNrhyKvePBK69UA3YX7vFEf8Y6dfGdV/UcAET71BJdd3hUnhGqsNjJN8uVjsScmTYtwrSj+1oXQApGYGEoP/QQWP8sRoMpjZYA1+00WaHBDtKb6kYr8rBoB+ohamURLsY8JdFlPdDta2a6S5kODRWU0wmNuDjxjZ4nDexw+eg/tQsjKXTsEkZ/Z8MCthXI5QVSdR6sX44KFAw4r2qXWi4EG09TWDKprJncL90hNsOtcG+fSBBhcP0C0QS40rdiszBFrMsp+dxInNtjrFQKXAPo0DpCTmb3qh3R5x1ifizjoGPJA34RM+YtjIg0MmyR+DjE564e82D8GrplMR6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQJaMj6tLjOWWN/vOEodIFpgfvs9jmiPX3RoFo6O10o=;
 b=bwylNrWndwq+XMDWlcSGOPEfiK0+PDvqEg1KO3rmUU/F2KgHkmU+e0IFHr21C5pVYwtmr7Q56SVOzr9cjqEgS4FRUNEmsZvhqfgQqXhUp8tKqm8imIOhtrncF1stKVN279w+UuPHO1d+JjtNI/kCf2wY5Ur8/57man6EcXpVH/TyCuQxD/YayZmbI1BhHtIPUSCqpXM6gi/NhsF7/FCzZAMGPgPaaj8VYDn8Z4l8fCFdzOtba0mLnfe6poIm6/IfvC2ZzmvwlU6Lb+hZgBVkhnVJKdLQbG6u2soJi7DAhLoQa3je6QTB8vqlP+DMALLBcTHR7khnzjacSQC+UaV2Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQJaMj6tLjOWWN/vOEodIFpgfvs9jmiPX3RoFo6O10o=;
 b=pbUEBTh3zkqQ83Ikfyg4blQk7UoqzQiE+NOw0TLnXLrG9w2oStx1XutDa55J62C+h3xdCBe5VlLxW0ON94f82s+ZWsPUMDCLZ32MuxAHObhT+rFOXLX5bKyZjJN/cA7m5D52RzwsETjW+FHNfRjH5ghjArFLXFeroX7u1d0/3jg=
Received: from DS0PR17CA0013.namprd17.prod.outlook.com (2603:10b6:8:191::11)
 by DS0PR12MB7677.namprd12.prod.outlook.com (2603:10b6:8:136::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 21:58:55 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:8:191:cafe::e5) by DS0PR17CA0013.outlook.office365.com
 (2603:10b6:8:191::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 21:58:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 21:58:54 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 16:58:53 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/14] drm/amdgpu: add VPE queue submission test
Date: Thu, 24 Aug 2023 17:58:30 -0400
Message-ID: <20230824215835.2740115-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824215835.2740115-1-alexander.deucher@amd.com>
References: <20230824215835.2740115-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|DS0PR12MB7677:EE_
X-MS-Office365-Filtering-Correlation-Id: 298ea459-7b62-400a-5895-08dba4ed4f70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bHicXLwCCGGOShjKh6K/L4wneyf2VBluoRMX/Crc43V/rcWDR8igzEZLuKkMyrFx/z5T8gmItJkbPvgfZt20Z7SyurGony/STx8L61tFV9mzkhVr15JWIzw6m0ZuVneQR6KkI7bGDYIJfDxJmAHoIHpQOsv2cgoADq9/e6ZvjXC/j8rGXys0prnxZRIUbGCOyG1Hwb8tBL7AwFu0XHGjz4AjeFTu1GYnSOVNfm9hq4v/guPqPhOsLJobIuWcYVNUBxUBzlb+yC+PmLN5iNqN0xJmNDV4wTEEaQsnRjBdvkkIy4yDNCkGePsnV2fAPob24NopMAVZsv3ak8mxCNMPVydYiB363hUBwWncpoBfaALJaWCTIFR9KPMPuOyvC+iIJUp8/P3Z+DqDIHoGDhg0I9F97evERDAC+VIAR74dwkWrZTZREHMzEtnLSW9Cnt3GC7UUHgIWDTBXXI/JR9tK78psMyjBTiOFjTfswMGmGNmvNne9SJdSLWxyzZRYkiwdjy4Fq96Ccf884XS+nqkdIcpFLKRNZpkxQN9Yhuq2QGk5+zmD44E5mxooCivvPM2Hgm0QR0jtgEmZmF4mfxltNGIEsRiqbyrIZPTkRed1YiHhzpyhypV+jZ6fxKWZrN2POU09mLfKaexzZi28leXtW240cf72byBR5WBe3MUfeYCtWpcZKRhCk7xoT2t1Apm6gpj8RNHwcA8befSZVgxYBMFCEa3OtOGvzdM9hOUToEbCJlatI8Omw94fQxOI/EKSgrCPBwJw1tzK2YHjHOIitg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(186009)(1800799009)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(1076003)(40460700003)(2616005)(5660300002)(8936002)(4326008)(8676002)(336012)(426003)(47076005)(36756003)(83380400001)(7696005)(36860700001)(26005)(16526019)(40480700001)(82740400003)(356005)(6666004)(81166007)(70206006)(70586007)(54906003)(6916009)(316002)(478600001)(41300700001)(2906002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 21:58:54.9086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 298ea459-7b62-400a-5895-08dba4ed4f70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7677
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Leo Liu <leo.liu@amd.com>,
 Lang Yu <Lang.Yu@amd.com>, Veerabadhran
 Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <Lang.Yu@amd.com>

Submit a fence command through indirect buffer.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Reviewed-by: Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c | 56 +++++++++++++++++++-
 1 file changed, 54 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
index ced963aaf7cf..21ba2c695b9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
@@ -180,6 +180,21 @@ static void setup_vpe_queue(struct amdgpu_device *adev,
 			    struct umsch_mm_test *test,
 			    struct umsch_mm_test_queue_info *qinfo)
 {
+	struct MQD_INFO *mqd = (struct MQD_INFO *)test->mqd_data_cpu_addr;
+	uint64_t ring_gpu_addr = test->ring_data_gpu_addr;
+
+	mqd->rb_base_lo = (ring_gpu_addr >> 8);
+	mqd->rb_base_hi = (ring_gpu_addr >> 40);
+	mqd->rb_size = PAGE_SIZE / 4;
+	mqd->wptr_val = 0;
+	mqd->rptr_val = 0;
+	mqd->unmapped = 1;
+
+	qinfo->mqd_addr = test->mqd_data_gpu_addr;
+	qinfo->csa_addr = test->ctx_data_gpu_addr +
+		offsetof(struct umsch_mm_test_ctx_data, vpe_ctx_csa);
+	qinfo->doorbell_offset_0 = (adev->doorbell_index.vpe_ring + 1) << 1;
+	qinfo->doorbell_offset_1 = 0;
 }
 
 static void setup_vcn_queue(struct amdgpu_device *adev,
@@ -248,7 +263,42 @@ static int remove_test_queue(struct amdgpu_device *adev,
 
 static int submit_vpe_queue(struct amdgpu_device *adev, struct umsch_mm_test *test)
 {
-	return 0;
+	struct MQD_INFO *mqd = (struct MQD_INFO *)test->mqd_data_cpu_addr;
+	uint32_t *ring = test->ring_data_cpu_addr +
+		offsetof(struct umsch_mm_test_ring_data, vpe_ring) / 4;
+	uint32_t *ib = test->ring_data_cpu_addr +
+		offsetof(struct umsch_mm_test_ring_data, vpe_ib) / 4;
+	uint64_t ib_gpu_addr = test->ring_data_gpu_addr +
+		offsetof(struct umsch_mm_test_ring_data, vpe_ib);
+	uint32_t *fence = ib + 2048 / 4;
+	uint64_t fence_gpu_addr = ib_gpu_addr + 2048;
+	const uint32_t test_pattern = 0xdeadbeef;
+	int i;
+
+	ib[0] = VPE_CMD_HEADER(VPE_CMD_OPCODE_FENCE, 0);
+	ib[1] = lower_32_bits(fence_gpu_addr);
+	ib[2] = upper_32_bits(fence_gpu_addr);
+	ib[3] = test_pattern;
+
+	ring[0] = VPE_CMD_HEADER(VPE_CMD_OPCODE_INDIRECT, 0);
+	ring[1] = (ib_gpu_addr & 0xffffffe0);
+	ring[2] = upper_32_bits(ib_gpu_addr);
+	ring[3] = 4;
+	ring[4] = 0;
+	ring[5] = 0;
+
+	mqd->wptr_val = (6 << 2);
+	// WDOORBELL32(adev->umsch_mm.agdb_index[CONTEXT_PRIORITY_LEVEL_NORMAL], mqd->wptr_val);
+
+	for (i = 0; i < adev->usec_timeout; i++) {
+		if (*fence == test_pattern)
+			return 0;
+		udelay(1);
+	}
+
+	dev_err(adev->dev, "vpe queue submission timeout\n");
+
+	return -ETIMEDOUT;
 }
 
 static int submit_vcn_queue(struct amdgpu_device *adev, struct umsch_mm_test *test)
@@ -403,7 +453,9 @@ static void cleanup_test_queues(struct amdgpu_device *adev,
 
 static int umsch_mm_test(struct amdgpu_device *adev)
 {
-	struct umsch_mm_test_queue_info qinfo[] = {};
+	struct umsch_mm_test_queue_info qinfo[] = {
+		{ .engine = UMSCH_SWIP_ENGINE_TYPE_VPE },
+	};
 	struct umsch_mm_test test = { .num_queues = ARRAY_SIZE(qinfo) };
 	int r;
 
-- 
2.41.0

