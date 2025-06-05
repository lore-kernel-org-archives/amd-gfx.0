Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF543C5B543
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jun 2025 01:46:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C10B10E9DD;
	Thu,  5 Jun 2025 01:46:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uIL2JLye";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89CB010E9D9
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jun 2025 01:46:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D39U9hhLcA3Q3YOfcKvzj4kH4YREjrGjvMW+IlagbwaUwr7im618l1T0UVTbCXE9AoWVYYCuR5a2g5kRlA0NzXMukHFA/+dzQJebBWp+k5X98r4ARUlSV4KU2EpJ1s0tscH4Fu8A3rUyAhgIXfNHiI4SEVw2OVOAuANMTJsYnb3Ar9nsGgYidd/WrVA88C51DT3OqS0NcodpopuPAPqw/XekRZEcrKrY4pOL2J732x6phYfqz9/zoKCKsU472KM4SIDyOlPKwyPDQt0+zmOw6uuw5oS1IFHv97LNXpe6RPmH4GM1jf0u7ocWNuDY1M59IURJPvl0e5AatMDaQcZvGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ag5S+sAJLmukocxrVGu1c6ZRNLjFTfHsX1Sdp9iPgjc=;
 b=kP76aE3O9ebrdwJ1vypMspIJIcTEHVpoRo4Qslf6y9z3iy2Q+JwgLGEcxjqRdenzQQnZZFPdnwDlYeabzMdAyTvJTTwzYQBpFzGL1ymhTMhcR70e1dXOYU/8MD1w+SaGkdzlBaD38E29tfB5mILOouDpeCUlUA9PHkjhf2XWWgoLRZwBYH/0hV03rVKtvSLMEVBrVJMoYPzLG2bhsPVk1a+qdYFkUNOe9JrYBrpf+MTQ2+G2p/w8nhH59rD6D0vh0+wK3c0K6tTJXQZen8rK4FI+PvxETQuM1Op+Nknrj55kDFwNThia6VXg6GoKhEj7lSjpLuXKeMLFN2XMyWoQ4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ag5S+sAJLmukocxrVGu1c6ZRNLjFTfHsX1Sdp9iPgjc=;
 b=uIL2JLyeguroQuwn+YLAI6H4p/PMf3+ZIw5Q0kDjgOfqCnvHVQCGiAzZQGx5nv9WgZQWduHx92hyo36WXzYZgacfH3QugoNrmOBg15LLt6xqgc69KObihnS1c1bik7+aaVa2XM4VS2KpfB4VTdVd6QzOFsB245vnB9Qyl8UI0dU=
Received: from SJ0PR03CA0138.namprd03.prod.outlook.com (2603:10b6:a03:33c::23)
 by MW4PR12MB5643.namprd12.prod.outlook.com (2603:10b6:303:188::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Thu, 5 Jun
 2025 01:46:36 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::c9) by SJ0PR03CA0138.outlook.office365.com
 (2603:10b6:a03:33c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Thu,
 5 Jun 2025 01:46:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Thu, 5 Jun 2025 01:46:35 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 20:46:31 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 25/31] drm/amdgpu/jpeg5.0.0: add queue reset
Date: Wed, 4 Jun 2025 21:45:55 -0400
Message-ID: <20250605014602.5915-26-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605014602.5915-1-alexander.deucher@amd.com>
References: <20250605014602.5915-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|MW4PR12MB5643:EE_
X-MS-Office365-Filtering-Correlation-Id: f7dbf366-c995-448e-0eaf-08dda3d2ce5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rzNskgddqLa4xyMOXnz8GLfpgtNvfP3CtHfSX+W26LF5D10yJLxwZYOVOSSm?=
 =?us-ascii?Q?57E/vEm+o9Tfib20UF7DssWXcXiw3ygfMs3oY1rHP/kymxfiZZW88LG5/ODx?=
 =?us-ascii?Q?tgEWNWD86ZUv2KOowwHV1mVcwK5zWvgSMJ7YY7PKbwt4iex+fFr4AOzuFKv6?=
 =?us-ascii?Q?o99+2UOPUnI36OqDi4bSFkXiPOAbCK4Scki0eB7NCKhzKX5h5F0NPq+pt3c+?=
 =?us-ascii?Q?20bsWT6fjDl010AiDhhCsm61jtpvskXpoduPL9ZC7WSYg9PjFxsax2/jZjz5?=
 =?us-ascii?Q?bXKm+ajbw+sjR/ZQ49Vfw+MRO8PkZVsxMQrXR3+uJqDCz4U1Eh+IHljQ+wFA?=
 =?us-ascii?Q?/wvoEsHLt1ziJ4P0jq685jPpfWMG8HFXvjm1p7PH44gEl4O21y1JbSnJk+Fr?=
 =?us-ascii?Q?jL7FXqk7wIU8r1Kj7n0a+ZKubY/uGSaR1cG7DRElXhY2RUgG0/8D/AIAM0QQ?=
 =?us-ascii?Q?3w5RBC0gUDvxz2js5YtQlF6Po6j5NBXOTjF86ZIl8ZjCbz7paM/w0LYoYFWr?=
 =?us-ascii?Q?Wo2ywazrIXYGPE90ZtHUeKP3Mp/ONRRhs+GVZovrw5F/9GOzMyh0aLyeInjw?=
 =?us-ascii?Q?23dELfwfe+D2w5+AEfEK1rs6A/C6qV7fyRLNH94aPG+9t7NVV2sFXvybJVsf?=
 =?us-ascii?Q?SKQQY7eUZD+JjLlHr92YlnC2A/sTLF7vyuuMAO6MFmB963oaTZ0L5Od1FosW?=
 =?us-ascii?Q?v+inoWyx24ThCy2CffWsHuw6iGXp9bJSTc2D2+k3bl2aVzz44+IQTGMo8NQX?=
 =?us-ascii?Q?RBfW7GPXh4I7remWc/gx3K9YrcBCg7ZiCvUjKmcWrmZBZ3cA/GKJmP4e6nDU?=
 =?us-ascii?Q?RTt5pKISN/SAuKH54CucfTxOL63+gioj80WZox4c7J+9viP+zNEv3DblZ93T?=
 =?us-ascii?Q?XMLgmu0KBKpqtb15s3rE6LesZYIAyDaabKQZHco9L//NFGOxXSFPcTiWr4ak?=
 =?us-ascii?Q?XJ1CjTbeb4S9hC+5lh/ulKe50AhspB3eRPY2JdD/SxeIYjCR9nu5b+FNvBQ8?=
 =?us-ascii?Q?93tgly7o1SwAg8deFCRsOZQuW8IAZxZMZ14XbV/k9MOuohTD48nkcoUeW7Ae?=
 =?us-ascii?Q?eFOPGrrcevVSqpvMM1uekvkYZmEoYZWFJ8nraWvx+q0hef/IxT+SrODeM+0z?=
 =?us-ascii?Q?jYH46Nwuq6iX4a7nK0wLZeell+lMLGRleCLLKRWeZGwlTgX3+5Y8T0tu8GXj?=
 =?us-ascii?Q?g02G5mdoQ8QIduufRajDx9I+fy6pLUS69kf8K4muT25RuJ+ta2yDIs/FW77V?=
 =?us-ascii?Q?lFEe1z5mcNk0yDghJFVpOXaeyhEIzZ66fxinFLGyMelum/+siOt4yGqBW4wP?=
 =?us-ascii?Q?Mq5YvlfuGcH0Bamvp9+0bW+YWlxPPz/94NHZBGfp4+/B5HZopOFQIDl3bVSe?=
 =?us-ascii?Q?IirNvmaHySIe/+Dmv/uBvI6KhYEfxGjnFOnO0aZwxWhFJpcjPxdjmjs0O/T0?=
 =?us-ascii?Q?mXW9MnP+8qTsadvTFGb4obH5LVPoYmGdYowYlxhSIM4K5+y4oZ4cegTcC/Xx?=
 =?us-ascii?Q?VMcI+cRVSjY5uC8gwBMdEoz06PDakfLZ6+aF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 01:46:35.6467 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7dbf366-c995-448e-0eaf-08dda3d2ce5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5643
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

Add queue reset support for jpeg 5.0.0.

Untested.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index 31d213ccbe0a8..231639f2ef0d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -644,6 +644,17 @@ static int jpeg_v5_0_0_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int jpeg_v5_0_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+{
+	if (amdgpu_sriov_vf(ring->adev))
+		return -EINVAL;
+
+	jpeg_v5_0_0_stop(ring->adev);
+	jpeg_v5_0_0_start(ring->adev);
+	amdgpu_fence_driver_force_completion(ring);
+	return amdgpu_ring_test_helper(ring);
+}
+
 static const struct amd_ip_funcs jpeg_v5_0_0_ip_funcs = {
 	.name = "jpeg_v5_0_0",
 	.early_init = jpeg_v5_0_0_early_init,
@@ -689,6 +700,7 @@ static const struct amdgpu_ring_funcs jpeg_v5_0_0_dec_ring_vm_funcs = {
 	.emit_wreg = jpeg_v4_0_3_dec_ring_emit_wreg,
 	.emit_reg_wait = jpeg_v4_0_3_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = jpeg_v5_0_0_ring_reset,
 };
 
 static void jpeg_v5_0_0_set_dec_ring_funcs(struct amdgpu_device *adev)
-- 
2.49.0

