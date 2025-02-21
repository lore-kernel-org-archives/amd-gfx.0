Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE557C021AA
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 13:00:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CD9110E2E5;
	Fri, 21 Feb 2025 13:00:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QPNk9vki";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A3FE10E2E5
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 13:00:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MgYkPz59NEX/UHOHi9VA/eIlFuHGNeCRPJO7EhZnyspcbYowHjbW1PxQdYg1le6/so/XNP2ZVjzAvURNPplHCNsKQWjEUNhnUaGT4OAmG3QkfKzNFTtTdhkn0gzwIGm2ef1OAwWD8Hd0wAaaoYT26C9f6T+0R8EHJ0CQk8GUmX2rwRgdRwU8IhXuWVpnv9Uu1WnSCEWIYxSu4PguXFjKERtD6zWdkt8XQ/hwzfWw/vjYKHqClMuARsZWIUZuXOiGJHfiYCWA53xqoh8LlLsZt2/YOUIvO1jQJ2xd8fS63PbxSzHD+MeUHWEHPAo5+Z3I7gTzmQtiK58i51vSqlfECA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i4CgPok5Xkm7yJqN4zoSH7OibxPujygH5jj5Wc7HWIU=;
 b=LGa2vcAKcdvqC67EWl3PcXMycp4kHMi8xh1oM/gdRtxrjdf0MsKS8s8WJV5emqEWJa1zbuqlvX1UKWU/JkImIvvv7LnAo8Sy7QG5qpV9T4ePskgBgHP3/dLJDVNFAhRglH/yddtyIeL06cSHZzAPaSfhU23B2cix+illvM27JjwqQuWOIy5jXfeAKyKI2Ohw7oWpXaZjx0YRKvzOAMPd7FLNJAYzeQVZBLrtTmM+NLwOV52wSiX1omNaTip41z91uF2WczS7Kvr2OntXsUCIa9e5h4hCuNTIOnk7kbEI9m3YFyVWX+QrKjG3k/BkoRPXME5ouWkE7xL9TtJ9TgyhyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4CgPok5Xkm7yJqN4zoSH7OibxPujygH5jj5Wc7HWIU=;
 b=QPNk9vkiAVBVt17tKA1F+YDHuHx6sTbKTCmzIiTBfU0PIBkZbZMaxeRGeoxkz3GENhUV9+KW5AykhryfLsDydPk9DM6gHoRMZB2esQKIQ0c7Vd0XLCi9BIoAX2nUF1RNC8EqGbMtMjiOw1miyI7u01aRl2govKekdcntmcEjOHU=
Received: from CY5PR16CA0024.namprd16.prod.outlook.com (2603:10b6:930:10::9)
 by MW4PR12MB7482.namprd12.prod.outlook.com (2603:10b6:303:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 13:00:44 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:930:10:cafe::5d) by CY5PR16CA0024.outlook.office365.com
 (2603:10b6:930:10::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.17 via Frontend Transport; Fri,
 21 Feb 2025 13:00:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 13:00:42 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 07:00:40 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH v2 1/4] drm/amdgpu/gfx11: Implement the GFX11 KGQ pipe reset
Date: Fri, 21 Feb 2025 21:00:27 +0800
Message-ID: <20250221130030.3703750-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|MW4PR12MB7482:EE_
X-MS-Office365-Filtering-Correlation-Id: c687cdbe-d5a7-4fd4-da14-08dd5277bf5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MmjBldeNBsPy3SyI42ADzhQBfXhHP6YyLsPtcJ2n7aIKBOJDdvUzgUZsZJvY?=
 =?us-ascii?Q?/vIT6aCjYdLHJ0ezckWxu7lDTx1uAzBhdAPRLgtLc34CKTsla+SbiWKY+K9m?=
 =?us-ascii?Q?2NqkCS7h8qC4kHeoIZ3/Yzs5gK6zItoYweGPlF7dQ3mwXro+eW5M18E0/+g+?=
 =?us-ascii?Q?becNI7Mysqhhnd4ucYSKMJ1O+IRa8XsLBiMTVEZzLJIwn3zWXTsbuEBPy0sf?=
 =?us-ascii?Q?vGC8LAreg1jnipPEnA3AjXSY1d6oy7DWhApR3IrZNAZ06AYJdsZYIsJNk+1n?=
 =?us-ascii?Q?OnghWsniiHTeCEFdOJIBPXcoNoLXd6bsbvbOc3s9vasd1IDzk/43H2bHR86m?=
 =?us-ascii?Q?2Q0Ft107op/bqCtj38PqGXJd+bFz4aGsJQezf+V9THQ9tBZNLqaGlP/Psaah?=
 =?us-ascii?Q?6xa1jNyEe8HkYNKLWAvCdXqRkhhM8n0mAbj3mtyCcdggfKdVfCCgIBJyvH2Z?=
 =?us-ascii?Q?rReRFdGTYoD0ELxaw1XAIbr3R+657A5TVEMgsAQpy33BWyrtljcXQ+QLSy+p?=
 =?us-ascii?Q?LZu40IxiJkUmspA9aa753CHNoPFJgIv7U2+D7p8dYEzna1OILUY+c/W+v0rK?=
 =?us-ascii?Q?xRG69aZYoNCkYRo4/Nn557ShVNsRkZViAxuns1eRywnSYbGI79uPGRylwuib?=
 =?us-ascii?Q?VUaHhXeRl796UUsTRByjxw/9SU3ODoM+nnjliMiWMKqpVUgNRo+5IUlA4LrD?=
 =?us-ascii?Q?0GYq1l8INFXFFkz3+cXkrqc+4f64snZlcjYmdpvX1rWzvRFpW0uYCptRu2ek?=
 =?us-ascii?Q?5kx8/LsLPun/6HI3kMawJFdtre4Mw9cbAMVclRiEWKGwSHvFBq6SCTfE9jtD?=
 =?us-ascii?Q?RJkc/5lO/ad+VM1D+QKhVGnncOX0bwQy9+D0/KQG4P82xgbbk9q6Ydy72Dj/?=
 =?us-ascii?Q?TNnyoI17FPiVG4C1K0YfXlo/wv3GUToZYsbGbbNS+zX1N0WNC9VJLDHT6kQs?=
 =?us-ascii?Q?soIglsfxba/7N6SI7XoygBKeYV9dxxM5ziE1ZV1V0aOWWhCBVq2k0bRL1tA6?=
 =?us-ascii?Q?Oboq3OoP1JhiLFeTLgcOMP2C+YLc9w0hGfq++m4gThpgWgVzOv/oatpsons/?=
 =?us-ascii?Q?uonbmJ5K5UVsvsZ8q1LNrZ7dTpofZeKFNuQ433Ro0dt9J7oeBAgIkTMapZSh?=
 =?us-ascii?Q?WM4HR0HdtGwPoyvkoB+bqjpieVeKozQo8WkMU88N49gKoeERqcjEahz76mSq?=
 =?us-ascii?Q?bvDmSS9pRxf6B8AFH8jVYutMoVznFHoKdhyhzkA1NCQywKh8M+d6LS4mhnjr?=
 =?us-ascii?Q?qC3V0uWtjH++JoExormp+zAuPAOf2qQSewXGdCNQcqxesxiLkpFFjm8Y5n/L?=
 =?us-ascii?Q?LfUPdr4/dmxcMm0XsNB5JtiCwAKKwK5b4bZfUNNS6p9Ucpyu7XEuHcnBCN5Q?=
 =?us-ascii?Q?MyA4gj2GszKlvlGZXbYYZvXuA067QLr9lVfOHviAn7e6OjPYgAhcXSxwx0Wa?=
 =?us-ascii?Q?XmcRoTIUwlmvDTsWA4iR0vIZ+OMQqDYvR7qrw+xNsvqE2IZALVxAnfYhkJzn?=
 =?us-ascii?Q?CpYCR+JkHEnk/+A=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 13:00:42.0010 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c687cdbe-d5a7-4fd4-da14-08dd5277bf5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7482
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Implement the kernel graphics queue pipe reset,and the driver
will fallback to pipe reset when the queue reset fails. However,
the ME FW hasn't fully supported pipe reset yet so disable the
KGQ pipe reset temporarily.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h |  2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c    | 71 ++++++++++++++++++++++-
 2 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index 4eedd92f000b..06fe21e15ed6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -25,6 +25,8 @@
 
 #include "amdgpu_socbb.h"
 
+#define RS64_FW_UC_START_ADDR_LO 0x3000
+
 struct common_firmware_header {
 	uint32_t size_bytes; /* size of the entire header+image(s) in bytes */
 	uint32_t header_size_bytes; /* size of just the header in bytes */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 2c7f0bb242ff..7e53c0b63f88 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6653,6 +6653,68 @@ static void gfx_v11_0_emit_mem_sync(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
 }
 
+static bool gfx_v11_pipe_reset_support(struct amdgpu_device *adev)
+{
+	/* Disable the pipe reset until the CPFW fully support it.*/
+	dev_warn_once(adev->dev, "The CPFW hasn't support pipe reset yet.\n");
+	return false;
+}
+
+
+static int gfx_v11_reset_gfx_pipe(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	uint32_t reset_pipe = 0, clean_pipe = 0;
+	int r;
+
+	if (!gfx_v11_pipe_reset_support(adev))
+		return -EOPNOTSUPP;
+
+	gfx_v11_0_set_safe_mode(adev, 0);
+	mutex_lock(&adev->srbm_mutex);
+	soc21_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
+
+	switch (ring->pipe) {
+	case 0:
+		reset_pipe = REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
+					   PFP_PIPE0_RESET, 1);
+		reset_pipe = REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
+					   ME_PIPE0_RESET, 1);
+		clean_pipe = REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
+					   PFP_PIPE0_RESET, 0);
+		clean_pipe = REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
+					   ME_PIPE0_RESET, 0);
+		break;
+	case 1:
+		reset_pipe = REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
+					   PFP_PIPE1_RESET, 1);
+		reset_pipe = REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
+					   ME_PIPE1_RESET, 1);
+		clean_pipe = REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
+					   PFP_PIPE1_RESET, 0);
+		clean_pipe = REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
+					   ME_PIPE1_RESET, 0);
+		break;
+	default:
+		break;
+	}
+
+	WREG32_SOC15(GC, 0, regCP_ME_CNTL, reset_pipe);
+	WREG32_SOC15(GC, 0, regCP_ME_CNTL, clean_pipe);
+
+	r = (RREG32(SOC15_REG_OFFSET(GC, 0, regCP_GFX_RS64_INSTR_PNTR1)) << 2) - RS64_FW_UC_START_ADDR_LO;
+	soc21_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+	gfx_v11_0_unset_safe_mode(adev, 0);
+
+	dev_info(adev->dev,"The ring %s pipe reset to the ME firmware start PC: %s\n", ring->name,
+			r == 0 ? "successfuly" : "failed");
+	/* FIXME: Sometimes driver can't cache the ME firmware start PC correctly, so the pipe reset status
+	 * relies on the later gfx ring test result.
+	 */
+	return 0;
+}
+
 static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -6662,8 +6724,13 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 		return -EINVAL;
 
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false);
-	if (r)
-		return r;
+	if (r) {
+
+		dev_warn(adev->dev,"reset via MES failed and try pipe reset %d\n", r);
+		r = gfx_v11_reset_gfx_pipe(ring);
+		if (r)
+			return r;
+	}
 
 	r = amdgpu_bo_reserve(ring->mqd_obj, false);
 	if (unlikely(r != 0)) {
-- 
2.34.1

