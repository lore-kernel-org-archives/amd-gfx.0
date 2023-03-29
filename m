Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B7DC761AF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 15:26:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBE0110EB42;
	Wed, 29 Mar 2023 15:26:02 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::617])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D41A10EB09
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 15:25:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PfOqKuFh7bee1C6p9WPMYxvLSAIEqbCI4LGbrtwROHIH8yuXXBmE/QOdZlvqOHQOQaIQUlmX6LfwBLX3w8SmAZJu+GO4KcBdtzUjXU2XUQOisyllYAtVnAXyVSlkV42+TugVSB2c+VBRXQaKgEWTlNn8vZOXnYtHoc8bPNwIe5TsWEThnR/IP5pY3tlzihqPM+LcE7xWKFj5Zo3kIubLaOF2UJzmL/jgj6/Bi9PJEe8z1gJKjQHzAHZY0kXDl1iWoX2emFidrigP+XH6rz6YBppt1R4HBv3EMT4sIAc/ReO2aWD2zTw5LfslqmR501PjyN1Aa1qX78Utj96iaPk9OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwLCOUlqnN4l3TF49gr8QeNqZDXCnaa2974sGYRrxbI=;
 b=cmXVIHsk0UcF8gpHM+Av9OdM42xs6eQw1FlhjlXZ+7hD6o3UFLXrHiFYCLIZT46FEkrMWneoMjeEmBTkfLqiqYNqRvz8pzeeJAEqibQOv1HNkMiFiliMJux/8qXwwGe6InVjeLw64UpoZI6d+aEQsm7FRMZn+pR22Z/aW3fTwd3Gn3CLjt0/TEnIwmU8JLXXha5J4yAvgFftYp2LvKhaYZ+4M+07JaPixvjV/MEIjuEBkJnEM0ywZZru9eC1jilDYGTd6P7XV26+FvzdGIP58Spa0VugXoohPNz87vX01PS+7ZFKJjjcXNxqW1iTPh3/mzdnSXPBk2As7wAPXo4HjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwLCOUlqnN4l3TF49gr8QeNqZDXCnaa2974sGYRrxbI=;
 b=GmR0HrSNyq0kkT74lsrg1OSHnmFiDreHnDAW1VYGYuNnSBvfLMl4xvPDYO7SrKz3aZKb2It4u725OkgyPTvUsNW5qPJ/MYC8WzPzOZMe5fxWXOyrctjj0Zp0rAAnqxyw9tuXLghtelfFseL+p1w+AydwNJhg1eBkyXOZcFDdzio=
Received: from BL0PR02CA0134.namprd02.prod.outlook.com (2603:10b6:208:35::39)
 by IA1PR12MB6140.namprd12.prod.outlook.com (2603:10b6:208:3e8::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Wed, 29 Mar
 2023 15:25:37 +0000
Received: from BL02EPF0000C402.namprd05.prod.outlook.com
 (2603:10b6:208:35:cafe::ed) by BL0PR02CA0134.outlook.office365.com
 (2603:10b6:208:35::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 15:25:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C402.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Wed, 29 Mar 2023 15:25:37 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 10:25:36 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/13] drm/amdgpu: add gfx11 emit shadow callback
Date: Wed, 29 Mar 2023 11:25:13 -0400
Message-ID: <20230329152521.1980681-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329152521.1980681-1-alexander.deucher@amd.com>
References: <20230329152521.1980681-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C402:EE_|IA1PR12MB6140:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a465b42-9196-49f5-7c75-08db3069d91b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qy3E2GczA83apltx58b1WHvpE9xCr2E12srnW0FM4/QSSb2YUNmg2chmDoafhFGYVfZP14eFKGKCM8hCi21nCvJLDigSmOFiOQN+KsImSNIvnw0UF+POi224UjvgJA6xMu4x+LnznxSjm3ay7K+kRluIs1AOl64MvglpQ9v/B8ufGgGRl58WqPQ8JPempwOrzRnMb+A4uYHBI1rYMPTsxRhF5tcOetx9hQtJqtsC/Un30j8f0X5dyo8xxcvFmky6u0yFzZKMtf6nZNQL0/W+MsjOIIdXG1bHLZefXqPDd2eZeLlafQnQGojKq1IQB4cR2PJLy5DH+WqNQZ472Bc4TJenoH7bYjZCrETE/5wBLaK9sja3kldlkYaZo9UZx1M3xoy2eIJiZWVbxBUyzcK/Ubt3lkJrvFbZENmXQrNlDulLPaEnopPvb3L659NZ/v5CgX49LoDTGqvQmq8ohvE31/WcJHb+2tpR09No0WMSPTEQJR5/k1kGpMFCXVVdNLrrVgRFkirEp1CZCvV20kGz2peCLZZa5K72whF6Y/IMhKfdmF500BvK92UDZkekRI6se2ic35SDxD36hQdxw6bFhONBc84iN9d7BFVlTVtn+mHdH+UAcCF6aE7FeFV01dH0IyaH4vdDda61a1jaYE6zjbNdXqGoGKWOdBbu52oDB+kEG4VCq/T/wib8XCnZyvPwjaFsPW/HOxK7+YN4WxRU1ytYIRdFwkRORXKagTaG6DM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199021)(46966006)(40470700004)(36840700001)(86362001)(6666004)(81166007)(356005)(7696005)(36860700001)(82310400005)(478600001)(2906002)(36756003)(54906003)(47076005)(1076003)(83380400001)(66574015)(316002)(26005)(426003)(336012)(41300700001)(40460700003)(8936002)(8676002)(16526019)(40480700001)(5660300002)(186003)(70586007)(70206006)(82740400003)(6916009)(4326008)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 15:25:37.4744 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a465b42-9196-49f5-7c75-08db3069d91b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C402.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6140
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

