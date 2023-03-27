Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 207F7C761A6
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 19:36:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E46D10E730;
	Mon, 27 Mar 2023 19:36:58 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D65D10E720
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 19:36:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SEDRD1vLdOfan84QdojfBHH/d4HVADXOfQETqgDZDEFVVtvsUMNSERlrBS5E8tSnkk5QdiGP8Ouk82oslvUGw7oAaN4aZ6mVn810N0lcNNKgQkgJuQTN+safMLwX1QmI74Hu2UrlnIDc2c5apFww2CjEjNCAulojL5H7uhQHL3xo+/zIuZLqGYz4AOEDOtdE+e3pmlxLbSArZm/X9oCiX7rwTa/ocX5Z3W8VklFB6KR5l3I9JhJQ6xpS95/H6JTMWiQqpb7XFNdXTlM6sL3t2IikIc5bJk/ZlPnG102uOhpJpGw4nJBJwC504XoLzadAadCQQGq5FYZETaYFN4uHog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4bBRBgBjEU23rKHqJdNf94rFICg1GbOQTfyKByAThU=;
 b=ftX99opVKHeGiQq9F42m3Z6njegRwUDTCRke5EuMslKvnqVyqs8w9eovim2SUxb/k+b+EhlFYwTVIyASlsSjPYdBzJuDKfAKELyZ08Mk84NFbDHjSwyOQcf6KndHqHsRrpVGXVxieaUBl9bxZ3+H4EoKAXzFyXTBlG889SlB8uE5Ox/pyhnQLxq0mEo27TktIwpDEvE+gu/ZdRBZiqbn1DVThLfAMn137C3iRQa/O/fdB5YQR1wUoJwbvxn16ZqZ9XeWnWM4mYaDUwz8/Uc1f70eAoRWN9gMTU5oMnWpkBoN6ldRJANgUqFMKoHeVBqyV7HjM0FkXRdL92M10YboVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4bBRBgBjEU23rKHqJdNf94rFICg1GbOQTfyKByAThU=;
 b=hUyWFnnHhZCdgqIntAB4rN7V9hKLVLfl+VJ1zwns0LMt1Ggm0s8b6OBQUrQfvX9E3RYZ+v4qjU37bkCoGZk0UTnjz+B1q0s3ibpJ/4b2Apl7AQzdrDHFGuduIJ6K8nj1NqKrJQp5t4RS++bWiWeHp3M/Pj3hZvnVjXOxqpm8f1k=
Received: from BN8PR15CA0044.namprd15.prod.outlook.com (2603:10b6:408:80::21)
 by IA0PR12MB8747.namprd12.prod.outlook.com (2603:10b6:208:48b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 19:36:30 +0000
Received: from BL02EPF000100D0.namprd05.prod.outlook.com
 (2603:10b6:408:80:cafe::25) by BN8PR15CA0044.outlook.office365.com
 (2603:10b6:408:80::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41 via Frontend
 Transport; Mon, 27 Mar 2023 19:36:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Mon, 27 Mar 2023 19:36:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 14:36:29 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/28] drm/amdgpu: allocate doorbell index for multi-die case
Date: Mon, 27 Mar 2023 15:35:49 -0400
Message-ID: <20230327193602.7901-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327193602.7901-1-alexander.deucher@amd.com>
References: <20230327193602.7901-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D0:EE_|IA0PR12MB8747:EE_
X-MS-Office365-Filtering-Correlation-Id: e2d0fb13-5e05-4aa2-2bf2-08db2efa9070
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A5Tb+3XG8e7oEAPFZ9jtkKJvG2wymQR8EhsMovAHtLp4MSl3q+kUF0junN/PFkWt+1/wqF3GvLYa/6N3ocnvlvZHRI4uZYFOijrm2/xo9SM/jDg08RuWDTzaXegfGwa/3VGLSULsVQO5ugJhPaI2Za7yd6ZUbVC42UUJTNtJ/GCI1q8STIsdylrp24eAUIQBBArB7k3OGiQVR+2Xeg+iJaVcAi6dyObKH8oWyaGcMouV3WYN71HiEF+aDxwu1gKtL+cFGrBRAxLyg+kCnDTTWzFJ1HShXxgw4+C+isoPMKlb1vNcn+4zmpX9M82k0sAObXVdJU9r5WYe6kMdcN6c9Oaq+yA/VlkIChSEIp+sJBUEWY1KvUX+64PCZL1gUijHTCtkkGtC3KaxIz34jinK1qluOghhJjKrQDiMhCCsTGhBL3Ld1w0a61Ssxvo6nf0H+sQ3s6MtR0ymXV1YTOW6vuRrMhgjelvUW8IhaKoul3mBZ1wSNOb6LDr76nt4Gj4Ozlw3TSlOmlfKRT+EkamQBbTsnQN9cUtodgB7gjcJSgrd14qjAKBeEtFXc1Q/eGM86IOX+nPRn7T4yYdxKz+IGEtjDWwyLEoaxLE532w6VPoMd2i1ZHTvEy/wjZC7fZCbNQoN7tV7+2aYkwWwlxsd10Sse6cVLUcUQ8Rnf8F6Ss8SBhNyD9dM/DiQ5g0wYmsOzrk99ItrA3ah2ZZVyMeZ0hUnRdnC54qUI2CO6WgH1o4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199021)(46966006)(40470700004)(36840700001)(16526019)(26005)(426003)(1076003)(40480700001)(41300700001)(186003)(6666004)(7696005)(83380400001)(336012)(2616005)(47076005)(478600001)(54906003)(316002)(36860700001)(40460700003)(4326008)(70206006)(2906002)(70586007)(8676002)(6916009)(81166007)(82740400003)(356005)(36756003)(82310400005)(86362001)(5660300002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 19:36:30.2560 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2d0fb13-5e05-4aa2-2bf2-08db2efa9070
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8747
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

Allocate different doorbell index for kiq/kcq rings
on each die

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h | 9 ++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c      | 5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c       | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h      | 1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c      | 8 +++++++-
 5 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
index 7199b6b0be81..711bdeaa7417 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
@@ -78,6 +78,8 @@ struct amdgpu_doorbell_index {
 	};
 	uint32_t first_non_cp;
 	uint32_t last_non_cp;
+	uint32_t xcc1_kiq_start;
+	uint32_t xcc1_mec_ring0_start;
 	uint32_t max_assignment;
 	/* Per engine SDMA doorbell size in dword */
 	uint32_t sdma_doorbell_range;
@@ -159,7 +161,12 @@ typedef enum _AMDGPU_VEGA20_DOORBELL_ASSIGNMENT
 	AMDGPU_VEGA20_DOORBELL64_FIRST_NON_CP            = AMDGPU_VEGA20_DOORBELL_sDMA_ENGINE0,
 	AMDGPU_VEGA20_DOORBELL64_LAST_NON_CP             = AMDGPU_VEGA20_DOORBELL64_VCE_RING6_7,
 
-	AMDGPU_VEGA20_DOORBELL_MAX_ASSIGNMENT            = 0x18F,
+	/* kiq/kcq from second XCD. Max 8 XCDs */
+	AMDGPU_VEGA20_DOORBELL_XCC1_KIQ_START             = 0x190,
+	/* 8 compute rings per GC. Max to 0x1CE */
+	AMDGPU_VEGA20_DOORBELL_XCC1_MEC_RING0_START       = 0x197,
+
+	AMDGPU_VEGA20_DOORBELL_MAX_ASSIGNMENT            = 0x1CE,
 	AMDGPU_VEGA20_DOORBELL_INVALID                   = 0xFFFF
 } AMDGPU_VEGA20_DOORBELL_ASSIGNMENT;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index c83fb4277233..465ad0b7cddb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -316,6 +316,11 @@ int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev,
 	ring->doorbell_index = adev->doorbell_index.kiq;
 	ring->xcc_id = xcc_id;
 	ring->vm_hub = AMDGPU_GFXHUB_0;
+	if (xcc_id >= 1)
+		ring->doorbell_index = adev->doorbell_index.xcc1_kiq_start +
+					xcc_id - 1;
+	else
+		ring->doorbell_index = adev->doorbell_index.kiq;
 
 	r = amdgpu_gfx_kiq_acquire(adev, ring, xcc_id);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
index 1d5af50331e4..d58353c89e59 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
@@ -270,6 +270,7 @@ void amdgpu_ih_decode_iv_helper(struct amdgpu_device *adev,
 	entry->timestamp = dw[1] | ((u64)(dw[2] & 0xffff) << 32);
 	entry->timestamp_src = dw[2] >> 31;
 	entry->pasid = dw[3] & 0xffff;
+	entry->node_id = (dw[3] >> 16) & 0xff;
 	entry->pasid_src = dw[3] >> 31;
 	entry->src_data[0] = dw[4];
 	entry->src_data[1] = dw[5];
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
index e9f2c11ea416..7f78340f3572 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
@@ -53,6 +53,7 @@ struct amdgpu_iv_entry {
 	uint64_t timestamp;
 	unsigned timestamp_src;
 	unsigned pasid;
+	unsigned node_id;
 	unsigned pasid_src;
 	unsigned src_data[AMDGPU_IRQ_SRC_DATA_MAX_SIZE_DW];
 	const uint32_t *iv_entry;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index b9b02fa15c7b..21eaec02fa7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -753,7 +753,13 @@ static int gfx_v9_4_3_compute_ring_init(struct amdgpu_device *adev, int ring_id,
 
 	ring->ring_obj = NULL;
 	ring->use_doorbell = true;
-	ring->doorbell_index = (adev->doorbell_index.mec_ring0 + ring_id) << 1;
+	if (xcc_id >= 1)
+		ring->doorbell_index =
+				(adev->doorbell_index.xcc1_mec_ring0_start +
+				ring_id - adev->gfx.num_compute_rings) << 1;
+	else
+		ring->doorbell_index =
+				(adev->doorbell_index.mec_ring0 + ring_id) << 1;
 	ring->eop_gpu_addr = adev->gfx.mec.hpd_eop_gpu_addr
 				+ (ring_id * GFX9_MEC_HPD_SIZE);
 	ring->vm_hub = AMDGPU_GFXHUB_0;
-- 
2.39.2

