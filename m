Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F00C77B6E
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:18:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA47410EFC4;
	Thu, 30 Mar 2023 19:18:24 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 979C810EFB9
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:18:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ygv9fEpa+N/tfw4Py8UCCjZopGSwhPCpS3FlZw+IC66PA1GsqUzLCWtWQ/Akvg7g/q2n+UsL9qaAl214+kFBXBzCnLr5ce+gbUced0QrIHo8cxaXG4/RqBvJU+XkoStWlKoqS4Q5usPyiY1f5oo09K2elikjDeQtBuezki9h4vzZ1MsezWaS+4xfYiG7UueuByN7WPHhMZiMj859fX0LNnxsTZM/yPPkbsB2Q/+XPKm7YSdakUStp4txZdGZHOaYXF9vyQmhNOknYUVSrdo1uoPnDNAEXAvYHPFiy1CUyN4BRoi/X4P6p43MH1QcC8rHHF0kDoAUU7e87ivYzkirjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrISXvsuAG9cy68zMd5gnA8+upIvXr7s0PJj582zeSM=;
 b=I6191ctX3dUrcpIpLY59BbPnB1F45NV71JLEJGzdi6zwKt3BlL82+UEonCySFb+Y/kcXBCRVHPjb1VVRyPJX0FjRx+jsx+aiBDDT4Wa/huPt1moyVbTQ9J/xRgrQTYOWmM888QCstCKlSyzDKoU9QO1PVQBG0aIHd/rEGm8fMbnw72Dnf7rEvaglbJFdzwB6e+YOnA01gmgfVipy45tFvQpYHu3BvVVV3dO6oUaczzMXYKjLLlJDMMHUDT7iajCbafE1cpi2M7PddLk7/PHrDY4xfMFbJUaTXjTBnIWWVxQLwcLCCwOuX+fLqFsvTdiM0Ndl1K3rH4sF2E8iaMjoLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrISXvsuAG9cy68zMd5gnA8+upIvXr7s0PJj582zeSM=;
 b=psu13SEyNJwhnvT8smGu7YdVtHueEsp6kGS/TfLuLcB+1RFOJqZL56qYmnFDgDwVaQtOZVfrf0AyWBO2OsZkRmjX55MRrx8d6K3Rxcd0Xy0zTwIQbcyWOe0oH6NY+xmdH9kdj6Wd7iFB+qTl4m7fV9Xo0rC/j8x4nq0CerqG0y4=
Received: from BN9P223CA0022.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::27)
 by DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Thu, 30 Mar
 2023 19:18:06 +0000
Received: from BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::cd) by BN9P223CA0022.outlook.office365.com
 (2603:10b6:408:10b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 19:18:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT073.mail.protection.outlook.com (10.13.177.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.22 via Frontend Transport; Thu, 30 Mar 2023 19:18:06 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:18:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/13] drm/amdgpu: add gfx11 emit shadow callback
Date: Thu, 30 Mar 2023 15:17:42 -0400
Message-ID: <20230330191750.1134210-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330191750.1134210-1-alexander.deucher@amd.com>
References: <20230330191750.1134210-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT073:EE_|DS0PR12MB6560:EE_
X-MS-Office365-Filtering-Correlation-Id: 9023db6c-0b54-4e60-070d-08db31537da4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DGJepqtEeYooEfBP1nb7M+Mxcz4sJQ8MZHKtaxk+biaAdweTcff4kzbdwgoAqLr90i9Zf6U4IKJAIb0JGcax29H2WQivgp5KJGV6o1WpJn0M14J25hgYrPiheQcwFNwJY2Ay1mz1zfbh1bs80tWA0nLsK0kqPREHmY5pcQqKj8dX8QlXF2juqtoTgZ3XwUJahd0ORd/K7zNFDVGqMtfYuYUJD8PK4Tz8HZwLD8f7hHcwN0JTnb0vWlCm5eaqGZyDHYwD0bWgvzUZEeHborXRtz5pa24u1kMhnsIDwuuFCks3LmIlyzDKc47VFeLonH+AdSV092N/LscOKeYc2FOm58OKbZelFR+FK9aCGFp/K/o2euOI74J44gcNCkucMkKYjdRN/CDY7Ylheceo1gb9ORoiEpVy6hAH8Gr/SyC5B61iwGyiiPSOD1bDYYdV8FRn/SMdgHiRVMbdRGOkc2B4iF2L6R9tqXBdJsQJEXSi4vPrVbSU8+yV6tAL8hxG686U/I2Nhir4kCIdRcgnk2fMNza3/AMU43/UQ1OY/JIZsc7jKL3M5cCnHhwHFOGUIsgL68dZwJEm2g59IATse/LV1pccFlTRvtLRakW0lhwWIsf5g52mXc1wCcoV1MmuE4O7E+MN/5fi3TXHjHgUlJwv5Ru7PPj5MHXs0KxEnngr9drQMbhpuDwiY6ijmJZY8e9u3OzKUXukfi6BRooPJ6dln5r3VZGeeNXdPsDz+1iGY7U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(376002)(451199021)(46966006)(36840700001)(40470700004)(82310400005)(26005)(426003)(47076005)(2906002)(83380400001)(86362001)(66574015)(40480700001)(36756003)(186003)(2616005)(41300700001)(4326008)(8676002)(6666004)(40460700003)(336012)(36860700001)(6916009)(8936002)(81166007)(356005)(70206006)(82740400003)(70586007)(316002)(1076003)(7696005)(478600001)(5660300002)(16526019)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:18:06.2536 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9023db6c-0b54-4e60-070d-08db31537da4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6560
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Christian König <christian.koenig@amd.com>

Add ring callback for gfx to update the CP firmware
with the new shadow information before we process the
IB.

v2: add implementation for new packet (Alex)
v3: add current FW version checks (Alex)
v4: only initialize shadow on first use
    Only set IB_VMID when a valid shadow buffer is present
    (Alex)
v5: Pass parameters rather than job to new ring callback (Alex)

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 25 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/nvd.h       |  5 ++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 4a50d0fbcdcf..1fc1e941f7df 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5598,6 +5598,29 @@ static void gfx_v11_0_ring_emit_cntxcntl(struct amdgpu_ring *ring,
 	amdgpu_ring_write(ring, 0);
 }
 
+static void gfx_v11_0_ring_emit_gfx_shadow(struct amdgpu_ring *ring,
+					   u64 shadow_va, u64 csa_va,
+					   u64 gds_va, bool init_shadow,
+					   int vmid)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	if (!adev->gfx.cp_gfx_shadow)
+		return;
+
+	amdgpu_ring_write(ring, PACKET3(PACKET3_SET_Q_PREEMPTION_MODE, 7));
+	amdgpu_ring_write(ring, lower_32_bits(shadow_va));
+	amdgpu_ring_write(ring, upper_32_bits(shadow_va));
+	amdgpu_ring_write(ring, lower_32_bits(gds_va));
+	amdgpu_ring_write(ring, upper_32_bits(gds_va));
+	amdgpu_ring_write(ring, lower_32_bits(csa_va));
+	amdgpu_ring_write(ring, upper_32_bits(csa_va));
+	amdgpu_ring_write(ring, shadow_va ?
+			  PACKET3_SET_Q_PREEMPTION_MODE_IB_VMID(vmid): 0);
+	amdgpu_ring_write(ring, init_shadow ?
+			  PACKET3_SET_Q_PREEMPTION_MODE_INIT_SHADOW_MEM : 0);
+}
+
 static unsigned gfx_v11_0_ring_emit_init_cond_exec(struct amdgpu_ring *ring)
 {
 	unsigned ret;
@@ -6219,6 +6242,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_gfx = {
 	.set_wptr = gfx_v11_0_ring_set_wptr_gfx,
 	.emit_frame_size = /* totally 242 maximum if 16 IBs */
 		5 + /* COND_EXEC */
+		9 + /* SET_Q_PREEMPTION_MODE */
 		7 + /* PIPELINE_SYNC */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
@@ -6245,6 +6269,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_gfx = {
 	.insert_nop = amdgpu_ring_insert_nop,
 	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.emit_cntxcntl = gfx_v11_0_ring_emit_cntxcntl,
+	.emit_gfx_shadow = gfx_v11_0_ring_emit_gfx_shadow,
 	.init_cond_exec = gfx_v11_0_ring_emit_init_cond_exec,
 	.patch_cond_exec = gfx_v11_0_ring_emit_patch_cond_exec,
 	.preempt_ib = gfx_v11_0_ring_preempt_ib,
diff --git a/drivers/gpu/drm/amd/amdgpu/nvd.h b/drivers/gpu/drm/amd/amdgpu/nvd.h
index fd6b58243b03..631dafb92299 100644
--- a/drivers/gpu/drm/amd/amdgpu/nvd.h
+++ b/drivers/gpu/drm/amd/amdgpu/nvd.h
@@ -462,6 +462,9 @@
 #              define PACKET3_QUERY_STATUS_ENG_SEL(x)          ((x) << 25)
 #define	PACKET3_RUN_LIST				0xA5
 #define	PACKET3_MAP_PROCESS_VM				0xA6
-
+/* GFX11 */
+#define	PACKET3_SET_Q_PREEMPTION_MODE			0xF0
+#              define PACKET3_SET_Q_PREEMPTION_MODE_IB_VMID(x)  ((x) << 0)
+#              define PACKET3_SET_Q_PREEMPTION_MODE_INIT_SHADOW_MEM    (1 << 0)
 
 #endif
-- 
2.39.2

