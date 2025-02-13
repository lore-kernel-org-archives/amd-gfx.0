Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 741DFC021A7
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2025 05:47:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25B0A10E2A1;
	Thu, 13 Feb 2025 05:47:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lSAPJg/N";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2074.outbound.protection.outlook.com [40.107.100.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 269C510E2A1
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Feb 2025 05:47:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C/XaDnQuciDIl0+rirTtkL7GOvmCScvWIimedWkr3E7qTmkeB5iiqeZKb1zKoQAJ2LnaZ2e/Il28xr/yIznJZVDXZ8a5Iw3swGV3GJnczDvmPLyiOcjM3YSWmtyP1Qe1akoqy6apaWCPNCVxhkb5ppiDWvCFlFfj93EoQ9Ep8izdbzJ/fe+xQbNGwDu03jrEgUW3TGek9H6jdwqluaaPiNX1/ZkAfq2QMCBxOZr5wQlj4tzNUF/pyXvTJPMQaDkk3hZ39dP7qk2l//gA2y+rdsuxtZpyhSsCfpyToa+0UKRJaz7LMxIzlaKoJkUZAUvW2DA5MqrmCeEMNuk24aXiBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOQj/fVt1HcYr7RWVWAYwBs5RwEzFa+Bp0Yza3V5WJ0=;
 b=LdiuZmnjotB3VNeO42Wgb2TA8jKBTUd11Ium1fRCpbRt8BqoLkDnk7FuvsFV6yPSgZjFoB+MKjWcpyi45X1ieShapCoXJOSPthUUVGUrqqvyS0DakX07Lyd7LjKLhctZTVir588JPcKr28aDzB5pol4NuISc7lT98tAXyhXEGG+fvvwQ44U4l+X0Zl6VowIdZy+iuQKVVILwqzsad4aw0wJMYMAT9YVYFZNc27VkDLIiB64IeqQ5NmzGBCX3VGnC199Pe2PWZIU3bBHK8ar12X9FFiurCFsECzRKnv6+ZPqLVGPPtscsw48psJyI6+TeZCAqtIEoY6xFYTOZNOXkBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOQj/fVt1HcYr7RWVWAYwBs5RwEzFa+Bp0Yza3V5WJ0=;
 b=lSAPJg/N36UVJw/dWLXvMdSQGVe2xGIViGJpDvoxv3W289sRPBD7QJrmce2QdeFbjJ1fZJG60nNLw3pt6PWCrpImq+NIioj5Xcn5rQQmq9NvMhRQGmi4VOOioz0cfQlhH14pSoi0t6TEfNUEarv/i4mEOJFk6UyWz9+fUSMVT9g=
Received: from DS2PEPF0000455C.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::514) by DM4PR12MB6640.namprd12.prod.outlook.com
 (2603:10b6:8:8f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 05:47:41 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:2c:400:0:1007:0:4) by DS2PEPF0000455C.outlook.office365.com
 (2603:10b6:f:fc00::514) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.7 via Frontend Transport; Thu,
 13 Feb 2025 05:47:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 05:47:41 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Feb
 2025 23:47:40 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Feb
 2025 23:47:40 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 12 Feb 2025 23:47:28 -0600
From: <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>, Jonathan Kim
 <Jonathan.Kim@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>,
 "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v7 2/9] drm/amdgpu/sdma: Refactor SDMA reset functionality and
 add callback support
Date: Thu, 13 Feb 2025 13:47:08 +0800
Message-ID: <20250213054715.3121445-2-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250213054715.3121445-1-jesse.zhang@amd.com>
References: <20250213054715.3121445-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|DM4PR12MB6640:EE_
X-MS-Office365-Filtering-Correlation-Id: 29991914-5e10-4c25-8ef9-08dd4bf1ee45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AutyolTBkZ3fyvaetI7GEaMUQrOgtmthw5+xA0Mor2H6x3t5DYF3hhRMXyy2?=
 =?us-ascii?Q?mrPHEmqJcQ1qKhbrHgba+jIcPeA/5TZN6X6+9o5al6N4q4KR5t6t0NrR7nuM?=
 =?us-ascii?Q?naSxlpgr85i/oL8HPEH5fmPzJPgnR3ScZJuc2v8kT01JUWskdba/gBIfAbKK?=
 =?us-ascii?Q?Xmjmf+YltvNpw2zqXCUcSWW5bNO6eE17LzEKx8upIxqCS0yDbqyOkwTQk8pU?=
 =?us-ascii?Q?8nm7zdjDsjGVVhq9CoWOISApXy0dSdqDuqn7VmfWhI9jDBl+kT+qfckGS2Mb?=
 =?us-ascii?Q?2EyADgkZ4l8o+2U3M5inWFN/SuhMM8oE3ecmv0cosl2njFLNCf0CFrOsubht?=
 =?us-ascii?Q?ORBEMNeJGJu3R87+L+Q2gv4YY90zGX23bamzW3O7ndI2s4yK/WQ+brpLaJYc?=
 =?us-ascii?Q?Fblu1DUim5y3PxK+ceyBnY1M3O2tcs4/ilfgI/t2UCfjtUKZ3cDcPL76kpda?=
 =?us-ascii?Q?9z0e/+t11Y6rYIOzqeQYFkeGB0I0UTok/0m3lPONFmIVpYgwgokPv2L1joVm?=
 =?us-ascii?Q?rKB8i5Yuws8MQ5mIhv58tJzyPCdZslNNdyrXuO42dDxP1J1xBea8l1ntsyfb?=
 =?us-ascii?Q?kjHWo7MmGujqMHvcUiYgL1kADjLzvKv/JeaK4+cP4KHMNzvyQiNm/+Uwudgs?=
 =?us-ascii?Q?BMlua4a9WL35fbZK/6qA8zTD9Le9QapJPxc/OKtAjp0ADc8jd/obdAQJ+hWA?=
 =?us-ascii?Q?/5tl9isHsyvHWbTLZkBo5XAxcn3cDLDEH/Hm7dcccmWRl+m1b9nN6cKDhFQk?=
 =?us-ascii?Q?jsHJCRiP1vTDBvUL7ey9onOzH4xx8Ioc3eLkHsguQJJ0ToSZmN3kWPs8JKm9?=
 =?us-ascii?Q?H6z7r3iV/8rMQGxhQCIbL9VAP53F3MKljyc8r5hQkDE6AJ4kmxP+wfyNOq51?=
 =?us-ascii?Q?1n/cm5+AkKRSfejt6gP83Wp0FCgOQCdwRsTOcu1Hs47QAOcDphZW+eMblGIR?=
 =?us-ascii?Q?6QBt3YAlRor7MAl7Y6ivH9tErz3dr2GfdN0TDxsl7+cGe8c85aBA0JM/fuKQ?=
 =?us-ascii?Q?OfJ7zijk7hIUELnbcfn601mspqGED6mhqvkMGJEnL8yhT+dHzqC5YNsUf6EL?=
 =?us-ascii?Q?Q8Oz1WhxNmZWmf4q/awysItNr4ZmJFhUTb3o6KnIupAd/zkSt1CjutU6AOOq?=
 =?us-ascii?Q?FtOPNXRfElcn9T51GvL5gUX2pA5CM01BOalyFFyNpTXyBc7rvRQIdq+Hw8NT?=
 =?us-ascii?Q?fUhIvgtX75w96Th8qKtqEs6X8ZwebPLspH7KzttvU1bBIlmlFClIQzUrQ/NN?=
 =?us-ascii?Q?JAbfIQA5Oo2dMJmLKOL7THgix34Ca4SyHhVlU31spAzaE78KowGiKruA/6yT?=
 =?us-ascii?Q?y5vkEcxcr65XVk9NQ6TPAE7ZXGhFupnwLzL4NV659aCcVC7rq8uSRPrQUyXY?=
 =?us-ascii?Q?oIWshglCUoQIq70xfJddlUYCVEXYUMG07LKQsCsJjHlc3yx7IU87K+MtyOSk?=
 =?us-ascii?Q?6nOV90Begp0jY2rrSkFaSbk2rht5BBEzbY/ypPSqeM2dt5E252FsXle2bwVT?=
 =?us-ascii?Q?eyszhmtJbSASzNI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 05:47:41.2122 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29991914-5e10-4c25-8ef9-08dd4bf1ee45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6640
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

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

This patch refactors the SDMA reset functionality in the `sdma_v4_4_2` driver
to improve modularity and support shared usage between AMDGPU and KFD. The
changes include:

1. **Refactored SDMA Reset Logic**:
   - Split the `sdma_v4_4_2_reset_queue` function into two separate functions:
     - `sdma_v4_4_2_stop_queue`: Stops the SDMA queue before reset.
     - `sdma_v4_4_2_restore_queue`: Restores the SDMA queue after reset.
   - These functions are now used as callbacks for the shared reset mechanism.

2. **Added Callback Support**:
   - Introduced a new structure `sdma_v4_4_2_reset_funcs` to hold the stop and
     restore callbacks.
   - Added `sdma_v4_4_2_set_reset_funcs` to register these callbacks with the
     shared reset mechanism using `amdgpu_set_on_reset_callbacks`.

3. **Fixed Reset Queue Function**:
   - Modified `sdma_v4_4_2_reset_queue` to use the shared `amdgpu_sdma_reset_queue`
     function, ensuring consistency across the driver.

This patch ensures that SDMA reset functionality is more modular, reusable, and
aligned with the shared reset mechanism between AMDGPU and KFD.

v2: Renamed sdma_v4_4_2_set_reset_funcs to sdma_v4_4_2_set_engine_reset_funcs.
    Renamed sdma_v4_4_2_reset_funcs to sdma_v4_4_2_engine_reset_funcs.(Alex)

Suggested-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 32 +++++++++++++++++++++---
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 64c163dd708f..29a123be90b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -105,6 +105,7 @@ static void sdma_v4_4_2_set_buffer_funcs(struct amdgpu_device *adev);
 static void sdma_v4_4_2_set_vm_pte_funcs(struct amdgpu_device *adev);
 static void sdma_v4_4_2_set_irq_funcs(struct amdgpu_device *adev);
 static void sdma_v4_4_2_set_ras_funcs(struct amdgpu_device *adev);
+static void sdma_v4_4_2_set_engine_reset_funcs(struct amdgpu_device *adev);
 
 static u32 sdma_v4_4_2_get_reg_offset(struct amdgpu_device *adev,
 		u32 instance, u32 offset)
@@ -1330,6 +1331,7 @@ static int sdma_v4_4_2_early_init(struct amdgpu_ip_block *ip_block)
 	sdma_v4_4_2_set_vm_pte_funcs(adev);
 	sdma_v4_4_2_set_irq_funcs(adev);
 	sdma_v4_4_2_set_ras_funcs(adev);
+	sdma_v4_4_2_set_engine_reset_funcs(adev);
 
 	return 0;
 }
@@ -1605,8 +1607,14 @@ static int sdma_v4_4_2_soft_reset(struct amdgpu_ip_block *ip_block)
 static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
-	int i, r;
+	u32 id = GET_INST(SDMA0, ring->me);
+	return amdgpu_sdma_reset_engine(adev, id);
+}
+
+static int sdma_v4_4_2_stop_queue(struct amdgpu_device *adev, uint32_t instance_id)
+{
 	u32 inst_mask;
+	struct amdgpu_ring *ring = &adev->sdma.instance[instance_id].ring;
 
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
@@ -1617,10 +1625,16 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 	if (adev->sdma.has_page_queue)
 		sdma_v4_4_2_inst_page_stop(adev, inst_mask);
 
-	r = amdgpu_dpm_reset_sdma(adev, 1 << GET_INST(SDMA0, ring->me));
-	if (r)
-		return r;
+	return 0;
+}
 
+static int sdma_v4_4_2_restore_queue(struct amdgpu_device *adev, uint32_t instance_id)
+{
+	int i;
+	u32 inst_mask;
+	struct amdgpu_ring *ring = &adev->sdma.instance[instance_id].ring;
+
+	inst_mask = 1 << ring->me;
 	udelay(50);
 
 	for (i = 0; i < adev->usec_timeout; i++) {
@@ -1638,6 +1652,16 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 	return sdma_v4_4_2_inst_start(adev, inst_mask, true);
 }
 
+static struct sdma_on_reset_funcs sdma_v4_4_2_engine_reset_funcs = {
+	.pre_reset = sdma_v4_4_2_stop_queue,
+	.post_reset = sdma_v4_4_2_restore_queue,
+};
+
+static void sdma_v4_4_2_set_engine_reset_funcs(struct amdgpu_device *adev)
+{
+	amdgpu_sdma_register_on_reset_callbacks(adev, &sdma_v4_4_2_engine_reset_funcs);
+}
+
 static int sdma_v4_4_2_set_trap_irq_state(struct amdgpu_device *adev,
 					struct amdgpu_irq_src *source,
 					unsigned type,
-- 
2.25.1

