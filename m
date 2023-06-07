Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98547C8300C
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 17:32:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B69210E528;
	Wed,  7 Jun 2023 17:32:29 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2068.outbound.protection.outlook.com [40.107.212.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A19510E528
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 17:32:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dBD+B9QBiuR02PW1Czvx1gJsN37OiBRWgnFrgN3rP5u206r/dr65cKhoYnJV9mKlA/AiJ1Ba++B8Ps6fK3iSwJVJsP0EkEMDQgUfxl0e/08TDJABmpxhn0brIqGoG9vVxDE4v74fm1XQopWvrsjdLIT97PojgNFXfCSM5ZJpEkLA4T9Ysd9gqlFae7iQJ3hku9HmSAscCdxHOy49oC/k4UHInZN6ODm8B9TR92ISfBO9pDOMOaHhJF/kyAtgKVf4VrlfJFQzuD2GRzF+ywYegdd+44LNBujlxOnixv7EK+tsHOtrJctjWSDu33dkZv0D+wRteRiRmhqZl1a/9VrG8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7Bv5yAWlCAJAQS86So816FFxpY0sHaiVhAeibXd1Pw=;
 b=oaiR3zNyEOKcsHCrudyYE5RvRyiaupwKvSqYYBFNItNhQUqjpzM4fSjzMk6L+lwZ25XBQXBnKS9fsjygIrH6x2qftjXMNZCM5sDnY1BBPJeh5WvCAzqS9Zuy4NLBSKwMy7KCJpvLMhQB7sbVgOCkas2cJ7TxK89hZrn2NcCEXtl0C4O0EyN2WfGfoDbzTh10FpuC+1LSR2ADDzG42jBjmuGJOfhkyWPgPK42Ws9aqlLIx9l/5sHekLBpXN55reU++VfcopBWRvGMuHMsQ7JHl86UdfPbrja3Dz+cwHI0Y2UIcLzrwMGMsnx8CSgZ9Pk5whUDqUDbNucRRTC2OIQRQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7Bv5yAWlCAJAQS86So816FFxpY0sHaiVhAeibXd1Pw=;
 b=pL6LKib0N5QydTOZSKQSgt4vV+8Md0gLtk16B69ldi1VxllWByxXn67nB2a0U4OF/B4E8hRyM+hRlTzJpRGPOYuz+ycQPs/6K0+3ChxJMbawWvlSnTPiyCiyx0njf7xBHhePxJV8wG8zSGou3PgqPPatgTn+O5L7OLdaY2efGxE=
Received: from DS7PR03CA0124.namprd03.prod.outlook.com (2603:10b6:5:3b4::9) by
 SJ1PR12MB6244.namprd12.prod.outlook.com (2603:10b6:a03:455::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Wed, 7 Jun
 2023 17:32:23 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::af) by DS7PR03CA0124.outlook.office365.com
 (2603:10b6:5:3b4::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 17:32:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.24 via Frontend Transport; Wed, 7 Jun 2023 17:32:22 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 12:32:22 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: optimize gfx off enable toggle for debugging
Date: Wed, 7 Jun 2023 13:32:11 -0400
Message-ID: <20230607173211.1824941-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT067:EE_|SJ1PR12MB6244:EE_
X-MS-Office365-Filtering-Correlation-Id: 4efdd8ca-15f5-4d6f-e2b1-08db677d273b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3A3NRUB+75SUPR28lPhSkJvF3ehrh22n4ThWtZnZSEcOyOaO5LnMxBW/bWz7x/W0HZpOm3BDv8ueKLWgq08yjjJkbyJn7ldj9xJq1HUxI4wJg15uFXSVI+0BUjUvPK4Whoqk4Joxa08HLMvgDbi0q+OZ0g/jmgx5HTZHtMuPe+GSMV7lQlcTnl7/+Ld4M36/4HjEVHt0x1KoIIfD9l/MkrakNS9mGRvlKZkjilyItmYEmySz20YPqAH9dmjHEUDED8MLvxsXhRupJWzTLzaCZMFLQwqpZou18pUf/dkwt85tL14jzR8pKwZZwFm3Ca5pVTO+44Y2tAFlMVuoHYGRJdBv/aybtJj8sDch2wZZrMqHoNRHIOZY6IKTCYh5BCvyEGVQKjr63uKxplClRwIy+38MyXdsXkoFlMfYyH2jWIh35pJDuDLGQKjciyd2IaFkRfjoQHyUoe6vWKCHsdreegboVi1R6tzXuqcPyrzSWvUArSde7RhC//O7plwKvsRH3Lr4QP6WL4CEYrPtZhID5S+8QwElTEOrQUGB6FCXqrCr7tPKtrI0CiBgjncf4T0oxLsXUb3VIX8pIxgbCzWp9UbbZMBlQxtgeukwtc6AFprVp3qJxj6uF0hUd0uUUZ3iGcpAh6uUC2gmHYxSfZv4U8OpLWuqDed8ucYMQTpTKO1TqU+ZNDg3ZBcExB9ZsPVw4YYcQ1khxml5uJdZ4OEX8stzYnCXMvAsNeK93DSnD1HI8x1vmKN5e9po9fO/FxsCvMP6tncaOMXpgy0o3J5iA8jtoG7X/v1po7w+4w2EotY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199021)(46966006)(40470700004)(36840700001)(478600001)(30864003)(40460700003)(2906002)(83380400001)(2616005)(426003)(36860700001)(336012)(47076005)(82310400005)(186003)(1076003)(26005)(86362001)(16526019)(82740400003)(356005)(81166007)(7696005)(36756003)(40480700001)(6666004)(5660300002)(8936002)(8676002)(41300700001)(70586007)(6916009)(4326008)(70206006)(316002)(54906003)(44832011)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 17:32:22.9084 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4efdd8ca-15f5-4d6f-e2b1-08db677d273b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6244
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
Cc: JinHuiEric.Huang@amd.com, Felix.Kueling@amd.com,
 Jonathan Kim <jonathan.kim@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Legacy debug devices limited to pinning a single debug VMID for debugging
are the only devices that require disabling GFX OFF while accessing
debug registers.  Debug devices that support multi-process debugging
rely on the hardware scheduler to update debug registers and do not run
into GFX OFF access issues.

Remove KFD GFX OFF enable toggle clutter by moving these calls into the
KGD debug calls themselves.

v2: toggle gfx off around address watch hi/lo settings as well.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c  |  4 +++
 .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   |  7 ++++
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    | 33 ++++++++++++++++++-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c    |  4 +++
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 24 ++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 22 +++----------
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c        | 21 +-----------
 7 files changed, 77 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
index 60f9e027fb66..1f0e6ec56618 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
@@ -150,6 +150,8 @@ static uint32_t kgd_gfx_aldebaran_set_address_watch(
 			VALID,
 			1);
 
+	amdgpu_gfx_off_ctrl(adev, false);
+
 	WREG32_RLC((SOC15_REG_OFFSET(GC, 0, regTCP_WATCH0_ADDR_H) +
 			(watch_id * TCP_WATCH_STRIDE)),
 			watch_address_high);
@@ -158,6 +160,8 @@ static uint32_t kgd_gfx_aldebaran_set_address_watch(
 			(watch_id * TCP_WATCH_STRIDE)),
 			watch_address_low);
 
+	amdgpu_gfx_off_ctrl(adev, true);
+
 	return watch_address_cntl;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
index 625db444df1c..a4e28d547173 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
@@ -350,6 +350,8 @@ static uint32_t kgd_arcturus_enable_debug_trap(struct amdgpu_device *adev,
 				bool restore_dbg_registers,
 				uint32_t vmid)
 {
+	amdgpu_gfx_off_ctrl(adev, false);
+
 	mutex_lock(&adev->grbm_idx_mutex);
 
 	kgd_gfx_v9_set_wave_launch_stall(adev, vmid, true);
@@ -362,6 +364,8 @@ static uint32_t kgd_arcturus_enable_debug_trap(struct amdgpu_device *adev,
 
 	mutex_unlock(&adev->grbm_idx_mutex);
 
+	amdgpu_gfx_off_ctrl(adev, true);
+
 	return 0;
 }
 
@@ -375,6 +379,7 @@ static uint32_t kgd_arcturus_disable_debug_trap(struct amdgpu_device *adev,
 					bool keep_trap_enabled,
 					uint32_t vmid)
 {
+	amdgpu_gfx_off_ctrl(adev, false);
 
 	mutex_lock(&adev->grbm_idx_mutex);
 
@@ -388,6 +393,8 @@ static uint32_t kgd_arcturus_disable_debug_trap(struct amdgpu_device *adev,
 
 	mutex_unlock(&adev->grbm_idx_mutex);
 
+	amdgpu_gfx_off_ctrl(adev, true);
+
 	return 0;
 }
 const struct kfd2kgd_calls arcturus_kfd2kgd = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 8ad7a7779e14..415928139861 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -754,12 +754,13 @@ uint32_t kgd_gfx_v10_enable_debug_trap(struct amdgpu_device *adev,
 				bool restore_dbg_registers,
 				uint32_t vmid)
 {
+	amdgpu_gfx_off_ctrl(adev, false);
 
 	mutex_lock(&adev->grbm_idx_mutex);
 
 	kgd_gfx_v10_set_wave_launch_stall(adev, vmid, true);
 
-	/* assume gfx off is disabled for the debug session if rlc restore not supported. */
+	/* keep gfx off disabled for the debug session if rlc restore not supported. */
 	if (restore_dbg_registers) {
 		uint32_t data = 0;
 
@@ -784,6 +785,8 @@ uint32_t kgd_gfx_v10_enable_debug_trap(struct amdgpu_device *adev,
 
 	mutex_unlock(&adev->grbm_idx_mutex);
 
+	amdgpu_gfx_off_ctrl(adev, true);
+
 	return 0;
 }
 
@@ -791,6 +794,8 @@ uint32_t kgd_gfx_v10_disable_debug_trap(struct amdgpu_device *adev,
 					bool keep_trap_enabled,
 					uint32_t vmid)
 {
+	amdgpu_gfx_off_ctrl(adev, false);
+
 	mutex_lock(&adev->grbm_idx_mutex);
 
 	kgd_gfx_v10_set_wave_launch_stall(adev, vmid, true);
@@ -801,6 +806,16 @@ uint32_t kgd_gfx_v10_disable_debug_trap(struct amdgpu_device *adev,
 
 	mutex_unlock(&adev->grbm_idx_mutex);
 
+	amdgpu_gfx_off_ctrl(adev, true);
+
+	/*
+	 * Remove the extra gfx off disable reference from debug restore call
+	 * for asics that do not support rlc restore for debug registers.
+	 */
+	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 1, 10) ||
+	    adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 1, 1))
+		amdgpu_gfx_off_ctrl(adev, true);
+
 	return 0;
 }
 
@@ -832,6 +847,8 @@ uint32_t kgd_gfx_v10_set_wave_launch_trap_override(struct amdgpu_device *adev,
 {
 	uint32_t data, wave_cntl_prev;
 
+	amdgpu_gfx_off_ctrl(adev, false);
+
 	mutex_lock(&adev->grbm_idx_mutex);
 
 	wave_cntl_prev = RREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_WAVE_CNTL));
@@ -853,6 +870,8 @@ uint32_t kgd_gfx_v10_set_wave_launch_trap_override(struct amdgpu_device *adev,
 
 	mutex_unlock(&adev->grbm_idx_mutex);
 
+	amdgpu_gfx_off_ctrl(adev, true);
+
 	return 0;
 }
 
@@ -863,6 +882,8 @@ uint32_t kgd_gfx_v10_set_wave_launch_mode(struct amdgpu_device *adev,
 	uint32_t data = 0;
 	bool is_mode_set = !!wave_launch_mode;
 
+	amdgpu_gfx_off_ctrl(adev, false);
+
 	mutex_lock(&adev->grbm_idx_mutex);
 
 	kgd_gfx_v10_set_wave_launch_stall(adev, vmid, true);
@@ -877,6 +898,8 @@ uint32_t kgd_gfx_v10_set_wave_launch_mode(struct amdgpu_device *adev,
 
 	mutex_unlock(&adev->grbm_idx_mutex);
 
+	amdgpu_gfx_off_ctrl(adev, true);
+
 	return 0;
 }
 
@@ -916,6 +939,8 @@ uint32_t kgd_gfx_v10_set_address_watch(struct amdgpu_device *adev,
 			VALID,
 			0);
 
+	amdgpu_gfx_off_ctrl(adev, false);
+
 	WREG32((SOC15_REG_OFFSET(GC, 0, mmTCP_WATCH0_CNTL) +
 			(watch_id * TCP_WATCH_STRIDE)),
 			watch_address_cntl);
@@ -938,6 +963,8 @@ uint32_t kgd_gfx_v10_set_address_watch(struct amdgpu_device *adev,
 			(watch_id * TCP_WATCH_STRIDE)),
 			watch_address_cntl);
 
+	amdgpu_gfx_off_ctrl(adev, true);
+
 	return 0;
 }
 
@@ -948,10 +975,14 @@ uint32_t kgd_gfx_v10_clear_address_watch(struct amdgpu_device *adev,
 
 	watch_address_cntl = 0;
 
+	amdgpu_gfx_off_ctrl(adev, false);
+
 	WREG32((SOC15_REG_OFFSET(GC, 0, mmTCP_WATCH0_CNTL) +
 			(watch_id * TCP_WATCH_STRIDE)),
 			watch_address_cntl);
 
+	amdgpu_gfx_off_ctrl(adev, true);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
index 91c3574ebed3..bb6ad733b3d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
@@ -768,6 +768,8 @@ static uint32_t kgd_gfx_v11_set_address_watch(struct amdgpu_device *adev,
 			VALID,
 			1);
 
+	amdgpu_gfx_off_ctrl(adev, false);
+
 	WREG32_RLC((SOC15_REG_OFFSET(GC, 0, regTCP_WATCH0_ADDR_H) +
 			(watch_id * TCP_WATCH_STRIDE)),
 			watch_address_high);
@@ -776,6 +778,8 @@ static uint32_t kgd_gfx_v11_set_address_watch(struct amdgpu_device *adev,
 			(watch_id * TCP_WATCH_STRIDE)),
 			watch_address_low);
 
+	amdgpu_gfx_off_ctrl(adev, true);
+
 	return watch_address_cntl;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 51d93fb13ea3..e30d1f9f5564 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -704,6 +704,8 @@ uint32_t kgd_gfx_v9_enable_debug_trap(struct amdgpu_device *adev,
 				bool restore_dbg_registers,
 				uint32_t vmid)
 {
+	amdgpu_gfx_off_ctrl(adev, false);
+
 	mutex_lock(&adev->grbm_idx_mutex);
 
 	kgd_gfx_v9_set_wave_launch_stall(adev, vmid, true);
@@ -714,6 +716,8 @@ uint32_t kgd_gfx_v9_enable_debug_trap(struct amdgpu_device *adev,
 
 	mutex_unlock(&adev->grbm_idx_mutex);
 
+	amdgpu_gfx_off_ctrl(adev, true);
+
 	return 0;
 }
 
@@ -727,6 +731,8 @@ uint32_t kgd_gfx_v9_disable_debug_trap(struct amdgpu_device *adev,
 					bool keep_trap_enabled,
 					uint32_t vmid)
 {
+	amdgpu_gfx_off_ctrl(adev, false);
+
 	mutex_lock(&adev->grbm_idx_mutex);
 
 	kgd_gfx_v9_set_wave_launch_stall(adev, vmid, true);
@@ -737,6 +743,8 @@ uint32_t kgd_gfx_v9_disable_debug_trap(struct amdgpu_device *adev,
 
 	mutex_unlock(&adev->grbm_idx_mutex);
 
+	amdgpu_gfx_off_ctrl(adev, true);
+
 	return 0;
 }
 
@@ -768,6 +776,8 @@ uint32_t kgd_gfx_v9_set_wave_launch_trap_override(struct amdgpu_device *adev,
 {
 	uint32_t data, wave_cntl_prev;
 
+	amdgpu_gfx_off_ctrl(adev, false);
+
 	mutex_lock(&adev->grbm_idx_mutex);
 
 	wave_cntl_prev = RREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_WAVE_CNTL));
@@ -789,6 +799,8 @@ uint32_t kgd_gfx_v9_set_wave_launch_trap_override(struct amdgpu_device *adev,
 
 	mutex_unlock(&adev->grbm_idx_mutex);
 
+	amdgpu_gfx_off_ctrl(adev, true);
+
 	return 0;
 }
 
@@ -799,6 +811,8 @@ uint32_t kgd_gfx_v9_set_wave_launch_mode(struct amdgpu_device *adev,
 	uint32_t data = 0;
 	bool is_mode_set = !!wave_launch_mode;
 
+	amdgpu_gfx_off_ctrl(adev, false);
+
 	mutex_lock(&adev->grbm_idx_mutex);
 
 	kgd_gfx_v9_set_wave_launch_stall(adev, vmid, true);
@@ -813,6 +827,8 @@ uint32_t kgd_gfx_v9_set_wave_launch_mode(struct amdgpu_device *adev,
 
 	mutex_unlock(&adev->grbm_idx_mutex);
 
+	amdgpu_gfx_off_ctrl(adev, true);
+
 	return 0;
 }
 
@@ -852,6 +868,8 @@ uint32_t kgd_gfx_v9_set_address_watch(struct amdgpu_device *adev,
 			VALID,
 			0);
 
+	amdgpu_gfx_off_ctrl(adev, false);
+
 	WREG32_RLC((SOC15_REG_OFFSET(GC, 0, mmTCP_WATCH0_CNTL) +
 			(watch_id * TCP_WATCH_STRIDE)),
 			watch_address_cntl);
@@ -874,6 +892,8 @@ uint32_t kgd_gfx_v9_set_address_watch(struct amdgpu_device *adev,
 			(watch_id * TCP_WATCH_STRIDE)),
 			watch_address_cntl);
 
+	amdgpu_gfx_off_ctrl(adev, true);
+
 	return 0;
 }
 
@@ -884,10 +904,14 @@ uint32_t kgd_gfx_v9_clear_address_watch(struct amdgpu_device *adev,
 
 	watch_address_cntl = 0;
 
+	amdgpu_gfx_off_ctrl(adev, false);
+
 	WREG32_RLC((SOC15_REG_OFFSET(GC, 0, mmTCP_WATCH0_CNTL) +
 			(watch_id * TCP_WATCH_STRIDE)),
 			watch_address_cntl);
 
+	amdgpu_gfx_off_ctrl(adev, true);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index cf1db0ab3471..f597e1c8ebee 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2766,7 +2766,6 @@ static int runtime_enable(struct kfd_process *p, uint64_t r_debug,
 			struct kfd_process_device *pdd = p->pdds[i];
 
 			if (!kfd_dbg_is_rlc_restore_supported(pdd->dev)) {
-				amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
 				pdd->dev->kfd2kgd->enable_debug_trap(
 						pdd->dev->adev,
 						true,
@@ -2823,33 +2822,22 @@ static int runtime_disable(struct kfd_process *p)
 			return ret;
 	}
 
-	if (was_enabled && p->runtime_info.ttmp_setup) {
-		for (i = 0; i < p->n_pdds; i++) {
-			struct kfd_process_device *pdd = p->pdds[i];
-
-			if (!kfd_dbg_is_rlc_restore_supported(pdd->dev))
-				amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
-		}
-	}
-
 	p->runtime_info.ttmp_setup = false;
 
 	/* disable ttmp setup */
 	for (i = 0; i < p->n_pdds; i++) {
 		struct kfd_process_device *pdd = p->pdds[i];
 
-		if (kfd_dbg_is_per_vmid_supported(pdd->dev)) {
-			pdd->spi_dbg_override =
-					pdd->dev->kfd2kgd->disable_debug_trap(
-					pdd->dev->adev,
-					false,
-					pdd->dev->vm_info.last_vmid_kfd);
+		pdd->spi_dbg_override =
+				pdd->dev->kfd2kgd->disable_debug_trap(
+				pdd->dev->adev,
+				false,
+				pdd->dev->vm_info.last_vmid_kfd);
 
 			if (!pdd->dev->kfd->shared_resources.enable_mes)
 				debug_refresh_runlist(pdd->dev->dqm);
 			else
 				kfd_dbg_set_mes_debug_mode(pdd);
-		}
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index e7bc07068eed..5b381018407a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -441,11 +441,9 @@ int kfd_dbg_trap_clear_dev_address_watch(struct kfd_process_device *pdd,
 			return r;
 	}
 
-	amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
 	pdd->watch_points[watch_id] = pdd->dev->kfd2kgd->clear_address_watch(
 							pdd->dev->adev,
 							watch_id);
-	amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
 
 	if (!pdd->dev->kfd->shared_resources.enable_mes)
 		r = debug_map_and_unlock(pdd->dev->dqm);
@@ -476,7 +474,6 @@ int kfd_dbg_trap_set_dev_address_watch(struct kfd_process_device *pdd,
 		}
 	}
 
-	amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
 	pdd->watch_points[*watch_id] = pdd->dev->kfd2kgd->set_address_watch(
 				pdd->dev->adev,
 				watch_address,
@@ -484,7 +481,6 @@ int kfd_dbg_trap_set_dev_address_watch(struct kfd_process_device *pdd,
 				*watch_id,
 				watch_mode,
 				pdd->dev->vm_info.last_vmid_kfd);
-	amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
 
 	if (!pdd->dev->kfd->shared_resources.enable_mes)
 		r = debug_map_and_unlock(pdd->dev->dqm);
@@ -599,15 +595,11 @@ void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind, int unwind
 
 		kfd_process_set_trap_debug_flag(&pdd->qpd, false);
 
-		/* GFX off is already disabled by debug activate if not RLC restore supported. */
-		if (kfd_dbg_is_rlc_restore_supported(pdd->dev))
-			amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
 		pdd->spi_dbg_override =
 				pdd->dev->kfd2kgd->disable_debug_trap(
 				pdd->dev->adev,
 				target->runtime_info.ttmp_setup,
 				pdd->dev->vm_info.last_vmid_kfd);
-		amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
 
 		if (!kfd_dbg_is_per_vmid_supported(pdd->dev) &&
 				release_debug_trap_vmid(pdd->dev->dqm, &pdd->qpd))
@@ -699,14 +691,10 @@ int kfd_dbg_trap_activate(struct kfd_process *target)
 			}
 		}
 
-		/* Disable GFX OFF to prevent garbage read/writes to debug registers.
+		/*
 		 * If RLC restore of debug registers is not supported and runtime enable
 		 * hasn't done so already on ttmp setup request, restore the trap config registers.
-		 *
-		 * If RLC restore of debug registers is not supported, keep gfx off disabled for
-		 * the debug session.
 		 */
-		amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
 		if (!(kfd_dbg_is_rlc_restore_supported(pdd->dev) ||
 						target->runtime_info.ttmp_setup))
 			pdd->dev->kfd2kgd->enable_debug_trap(pdd->dev->adev, true,
@@ -717,9 +705,6 @@ int kfd_dbg_trap_activate(struct kfd_process *target)
 					false,
 					pdd->dev->vm_info.last_vmid_kfd);
 
-		if (kfd_dbg_is_rlc_restore_supported(pdd->dev))
-			amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
-
 		/*
 		 * Setting the debug flag in the trap handler requires that the TMA has been
 		 * allocated, which occurs during CWSR initialization.
@@ -851,7 +836,6 @@ int kfd_dbg_trap_set_wave_launch_override(struct kfd_process *target,
 	for (i = 0; i < target->n_pdds; i++) {
 		struct kfd_process_device *pdd = target->pdds[i];
 
-		amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
 		pdd->spi_dbg_override = pdd->dev->kfd2kgd->set_wave_launch_trap_override(
 				pdd->dev->adev,
 				pdd->dev->vm_info.last_vmid_kfd,
@@ -860,7 +844,6 @@ int kfd_dbg_trap_set_wave_launch_override(struct kfd_process *target,
 				trap_mask_request,
 				trap_mask_prev,
 				pdd->spi_dbg_override);
-		amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
 
 		if (!pdd->dev->kfd->shared_resources.enable_mes)
 			r = debug_refresh_runlist(pdd->dev->dqm);
@@ -887,12 +870,10 @@ int kfd_dbg_trap_set_wave_launch_mode(struct kfd_process *target,
 	for (i = 0; i < target->n_pdds; i++) {
 		struct kfd_process_device *pdd = target->pdds[i];
 
-		amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
 		pdd->spi_dbg_launch_mode = pdd->dev->kfd2kgd->set_wave_launch_mode(
 				pdd->dev->adev,
 				wave_launch_mode,
 				pdd->dev->vm_info.last_vmid_kfd);
-		amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
 
 		if (!pdd->dev->kfd->shared_resources.enable_mes)
 			r = debug_refresh_runlist(pdd->dev->dqm);
-- 
2.25.1

