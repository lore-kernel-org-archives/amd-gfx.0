Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26BEEC76195
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Mar 2023 17:38:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D78E10E606;
	Mon, 20 Mar 2023 17:38:35 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::617])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 652D210E614
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Mar 2023 17:38:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHagYzhQNoFAaG7G25Xcsm+gfr3HYKy0ILdBIETNezacRsTTYlnS8JhmLlmNDEXcSZT2OOQzFFvZoea0EdeaDJqDaG8bHB9sV2VXJMrc+YTYLXY6G6JQj1nG9yLgiUceycD27Wt6Z5qjDUrd+5uYxpx4z6HC5xldjuyyeUrZwOq+TWydKi7kjVUQvk80jpiplampBeWI55m5EWwOxhS/YE9v7FwGbbBUZRLT7NdJpNlZL2Op4FIJ0VEoUXLo9+hSuRnZtweGmKLhy/NQ85WxDmYbliPeik8d+8Lwp/w6w1xVHvXxfmQdi6n+1eUqGEVNKl0JEftGOyc5eQUI/YFYqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwLCOUlqnN4l3TF49gr8QeNqZDXCnaa2974sGYRrxbI=;
 b=k1Sv9CTxs/jA+qZWoMVRncXjJ/P6+iBt3q62BUdqhjQHn8HJfd2Kfc2I2ZFAfV2b/Ka+EH35dMHim85L7I/wzmlUH9EiPSWbrnkAUSJlkZMtlShcO2lX7d6qnty3IKBGBxK2A8r3wyK+DuXr3+vQEtLuDlbJYjZzvNUzVWnjInocbH0oMrtekXuuvZBlLNEXn51niv9nm/nl+ZvwjuGPPikQdi2qyLZH5blaA7+6vvy9mIGQyjVGlszaynGq8mRoJsA6V400PDzIdATSoKv+Sqmyza1x7o30oES4WYWWUOqm3DsIBumc92YP1DMF3rmGgNbCA0WE5gyKTN32rnCffA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwLCOUlqnN4l3TF49gr8QeNqZDXCnaa2974sGYRrxbI=;
 b=I0aPz5hkY42MG2JRbdOn8A2EaT9NP9UnjfU2Yn6hF18AMDf7V0qv27MybcSyCieLte4NqrleYAw2Em5M+F8OMvwASi4Vo/NzrV4m1gbOeN87J5E5b7/0QZgniBFbqFxw5kXhNQKTiEjUmlLkllvj1r5L6RP8QY8pOaQf25/9Bw8=
Received: from MW4PR03CA0168.namprd03.prod.outlook.com (2603:10b6:303:8d::23)
 by DM6PR12MB4313.namprd12.prod.outlook.com (2603:10b6:5:21e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 17:38:30 +0000
Received: from CO1NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::fe) by MW4PR03CA0168.outlook.office365.com
 (2603:10b6:303:8d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Mon, 20 Mar 2023 17:38:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT078.mail.protection.outlook.com (10.13.175.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.15 via Frontend Transport; Mon, 20 Mar 2023 17:38:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 20 Mar
 2023 12:38:27 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/11] drm/amdgpu: add gfx11 emit shadow callback
Date: Mon, 20 Mar 2023 13:38:04 -0400
Message-ID: <20230320173810.250835-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230320173810.250835-1-alexander.deucher@amd.com>
References: <20230320173810.250835-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT078:EE_|DM6PR12MB4313:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b4d37f3-6f64-4688-79fe-08db2969eb7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ez2jxpGiCMDm4K04p+NTQ9R7iware6FpybQqDuqd3+DJIeEL4QCemqP0lVuMthUzLGJ2zHGMnRRnfjky5rKQKZ8t/kjmfShvsSmKI+eHe0f4wNtI5zJ8bFsk15gK2/J9joKwee+LJz25LdnGoC3PSg7lyp+iJWWGI8I9Z1QWau30YYF2N9pna5ILFWPcIUnRJOJkZ96N0O+VA4/dHoMUO4Pt6GZsQIQm9QjmFkfxzG04t8jSHxhX9an4vSnPSlmGhgHc4KpWxIcIpv+x2R396KliftBVnoNygXWRIFWDHcxhqvwm/RcjM3IxUWWVFtzrtN1BrKZowc+JjriMxYbEBZGqZGJo9pziK4HXlaCGLAlBq12LsssVHPVeQ8FIoylf17SMoZHwABc3msME5RZ5pfa5xRgl9uX+Mp6fMQ90QebxV0Loo10l8QKTB54m5sLBE4tvePVbJsjTIixlvlWENwRJ9eiVUs+EYXYHmARl+TGhHE1v6bC3EqkAQbn4lnrrKUHd3vpDA87RujBnC478fPXvIZrqQKzwPw4K6y+WqjG7Q8LlFFP2sXS1x2VkP5Gn37Fv7hsXIaAL3daBAg8PVO6fJGwW16gGtXRJ0xTd7vWfWKCUJGhQXvkNX8E4g0jCqcumtu70Ms43/K6saz7G0OMMBrIz8snjbjkSHZzEI9U24tzMBgSrUatCY9Q/meK38d5ti/Xp0DNj4V4WEjlH9/CVCaTNSWQWH8kUHRcUz2k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199018)(36840700001)(46966006)(40470700004)(54906003)(316002)(7696005)(478600001)(4326008)(8676002)(70206006)(6666004)(70586007)(6916009)(41300700001)(1076003)(26005)(16526019)(186003)(8936002)(83380400001)(2906002)(5660300002)(2616005)(426003)(336012)(47076005)(40460700003)(66574015)(356005)(36860700001)(36756003)(40480700001)(81166007)(82740400003)(86362001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 17:38:30.0643 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b4d37f3-6f64-4688-79fe-08db2969eb7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4313
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

