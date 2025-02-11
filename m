Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DECA3C021A0
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2025 05:15:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 598A610E062;
	Tue, 11 Feb 2025 05:15:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m3KvvbF+";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A88910E062
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2025 05:15:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OLh9q6+iVFJUrH7FXdGVcnEulXRYQssgJxZy6Cd7sYZWZMjo5RQjHX4eDWJHNcKUtfsMQ3Is/HyltMbtSz2wv2mAJnpy/ecpEVZILHv5+9HK789pPKEtV2XopL5eroPeox8ckvvKtkYOtrqXlwo1YX4x9qqPJdhRl+Yw3CORd9owYVOnqnY9SDERAiBBDZNlJpYBNCM34V7DNQnLtmqQ6Pydp7LQtGug8lfhHEucTqxwRqUul0xOa+76wVzS1sSSdmw9hreyTeQFcFRwYKyk/5+BsKNay07fUWe4pxmeV2Anqj0bwkQhxKXOgrRL5EyFjTn9LbZC65+BWx6zlofoAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djC1UeIYB6qPpdSU1Qm9w7zUBRfvZYtYyLY32a7qA5Y=;
 b=Fc1kEHXE8VSSSeh+wgv9ozvZoHsHj9SOd9YdmGs83BG+EsrHmwobtBQhVkDnOjhv51ZAFpC8MN4fE9T2VXxDgQ3kZFFDpwfwEUtNiJzV1O0uOnmSsX95F7emy9a1QgFCZHUdpkWNcGkg9gB73e676B9HUbGaFORqM/mCFjnJq9t7IfOovbitlordr52B8kcFpLJIdTAjpJEMqzZfETx/l4NmQ/WJCuNl9t5j1dGueBZHmGysBL5c0a9R+6o9RzBWLWELBlJacCC1W7KYfsR70MWWqMDQC2r8VM6sMbFnfXjjFI2gRKKkZVf9wPsl6i+OmFnu/HqjgkQi3DFcAFPlxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djC1UeIYB6qPpdSU1Qm9w7zUBRfvZYtYyLY32a7qA5Y=;
 b=m3KvvbF+RUE9Yw/r7uPTQihfLmKqk5PKLAmGP1B/PO70ECQ7ytx/SImoxxzM3aiK3rz5QP59TesXq6Rp4D5f/uEeVlutvB8VX50z1zy+Va6wq4OaIMShU+bZjY0dGf34sMK7HZQdh2sfYsoRzpnJ9DFpZS61MzNnw6zkppFVP9M=
Received: from PH8PR05CA0017.namprd05.prod.outlook.com (2603:10b6:510:2cc::29)
 by IA1PR12MB6652.namprd12.prod.outlook.com (2603:10b6:208:38a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 05:15:21 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:510:2cc:cafe::35) by PH8PR05CA0017.outlook.office365.com
 (2603:10b6:510:2cc::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.11 via Frontend Transport; Tue,
 11 Feb 2025 05:15:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 05:15:20 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Feb
 2025 23:15:19 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Feb
 2025 23:15:19 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 10 Feb 2025 23:15:12 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>, Jonathan Kim
 <Jonathan.Kim@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>,
 "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>
Subject: [PATCH 2/4 v6] drm/amdgpu/sdma: Refactor SDMA reset functionality and
 add callback support
Date: Tue, 11 Feb 2025 13:14:52 +0800
Message-ID: <20250211051454.2811943-2-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250211051454.2811943-1-jesse.zhang@amd.com>
References: <20250211051454.2811943-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|IA1PR12MB6652:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d3ec6a6-9bbb-4f68-b0b5-08dd4a5b14bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fMXbE218blvJtH+NcK675oi5OIfxyLdP8aA7euNBHVhag1TXOGDYyzC+Yc9Y?=
 =?us-ascii?Q?Avzv6luTu3ZsContoGz7evnCSbHMXVdEnAD/i5Hf+r8p+Z79c6sa/FZPBVAR?=
 =?us-ascii?Q?rvu4mzwm97Icj7jeGPVSZSzP6enjHJ+kLxVVbRtz8sdbcc8URb0uve6GtC+B?=
 =?us-ascii?Q?amQ7LRZmAXZiolRrleMUfH0VRDB5t1bx9gQQ+92LR68dSn8VVzfw2fTDLyg1?=
 =?us-ascii?Q?iQGtnAu9f42r3F1KBWO3wpKVz5SgErF2j2wt5lf3oTgA4chjws+i89mux6rU?=
 =?us-ascii?Q?p8Gy+q6ySb3mY+YaAVmHb3g5KSkYDZyvwMK12qATwcuQ45zquSY6hrFVda+4?=
 =?us-ascii?Q?xWmCRadusDRNBAYYW8CbqzP/My0HtTEUwMxPWoml+1zy1WUEAT3PX+R+WmXO?=
 =?us-ascii?Q?/ziYQ4gcxLQfyxA5lLB7wBbgXWi+tOvx3tIUmU7/Zj0vY4cQAOoPkPchPzSi?=
 =?us-ascii?Q?Npr9pYc/xti1NpL1lAOd7BzHKXXTiPx32lHKVE24uKwv4/BSJikdzI1DdQtB?=
 =?us-ascii?Q?KkvOfF/+tq3VIXrCr5rmzGgeFBEaX7KOqtBSNVx48sTB6X5vEjFST3Zkcig8?=
 =?us-ascii?Q?emMunfu2+tRxWX5CMJ0Z5+80s3TddE26akO9ZqfxoLdnMSvM35MGRK6HGzpi?=
 =?us-ascii?Q?KK0NzTbRPTKbL3KB8Z9BwB+BOWawwFoI/Mms9SxQqeROOCKov9OBQpUfYhOn?=
 =?us-ascii?Q?2eiLNGdf7a1j0mDhRBYpIDA7dAmkQ2Ft534AJARq0kVlPqvRDtWVg447QLdg?=
 =?us-ascii?Q?Iihao1o5q2w/zLK4qQf8+Glo1nHm72UdgLWiCR3CevsTHY9GjOXEqPXcvxwP?=
 =?us-ascii?Q?JPfZ1FRLRiUhIM9cNycMuJsFxFhsT/QwllTXDvi2fEMItdmkY5zNi8S+MP9H?=
 =?us-ascii?Q?Wg0HcLEVKP+o60WIpc0bbbbWjfnrpUErcjgB03uKuTxWjnU6FK4RrJNuQRCx?=
 =?us-ascii?Q?RheqdYpCvzGkw5/hQnW/SeRda05mvHGPRBI7bZJ/TUiOXXbwMKiXOQH8pK0A?=
 =?us-ascii?Q?bCRtnMF/y9qba9KzMy2pjPMzFLpf7y0pe3IfYTMGA7dzBE5Wk9HVuY4JEiE6?=
 =?us-ascii?Q?9HUE0e3R7q7NmGPuSsu2nCT3rURCFuRFlY4mfEOsR+xMA41q3FEnjfuQfEB9?=
 =?us-ascii?Q?qONw5t45DR1nzGbbuVQguPM/IOaK41uJQF6hpegLE7hFUNJrS0wMqEbsH/qi?=
 =?us-ascii?Q?AhmW2YKfyG+2omz7MKUnUv0AGN0GhdQ72FESLUnDK7GdJX5VqPeucyfdn3fN?=
 =?us-ascii?Q?7gRCohgzOHhDxVCQH/LEsPK/vOJ/kkjlqb9JLNKQLaFR2NIqoOZYOOm6kIhl?=
 =?us-ascii?Q?Brrv5sQyx1eWh4AnSDfKaxJwCFSb8MXofiMa895uCbzLLyHZdbxhsoc+uBb/?=
 =?us-ascii?Q?CD/xtrPzoTxHQYNhZg1FnAyGAmJexuAt5oMgzDiAQKpp+4njI6shWELImucH?=
 =?us-ascii?Q?RChrzDTh1Cfkxgumq+3tPgMZrkp13cVKPwC9VBFc9p2CIcAVqtQrUA8Dhrh2?=
 =?us-ascii?Q?FUv+8kQUJjtCDac=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 05:15:20.5214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d3ec6a6-9bbb-4f68-b0b5-08dd4a5b14bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6652
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

Suggested-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 32 +++++++++++++++++++++---
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 64c163dd708f..3e60456b0db0 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -105,6 +105,7 @@ static void sdma_v4_4_2_set_buffer_funcs(struct amdgpu_device *adev);
 static void sdma_v4_4_2_set_vm_pte_funcs(struct amdgpu_device *adev);
 static void sdma_v4_4_2_set_irq_funcs(struct amdgpu_device *adev);
 static void sdma_v4_4_2_set_ras_funcs(struct amdgpu_device *adev);
+static void sdma_v4_4_2_set_reset_funcs(struct amdgpu_device *adev);
 
 static u32 sdma_v4_4_2_get_reg_offset(struct amdgpu_device *adev,
 		u32 instance, u32 offset)
@@ -1330,6 +1331,7 @@ static int sdma_v4_4_2_early_init(struct amdgpu_ip_block *ip_block)
 	sdma_v4_4_2_set_vm_pte_funcs(adev);
 	sdma_v4_4_2_set_irq_funcs(adev);
 	sdma_v4_4_2_set_ras_funcs(adev);
+	sdma_v4_4_2_set_reset_funcs(adev);
 
 	return 0;
 }
@@ -1605,8 +1607,14 @@ static int sdma_v4_4_2_soft_reset(struct amdgpu_ip_block *ip_block)
 static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
-	int i, r;
+	u32 id = GET_INST(SDMA0, ring->me);
+	return amdgpu_sdma_reset_instance(adev, id);
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
 
+static struct sdma_on_reset_funcs sdma_v4_4_2_reset_funcs = {
+	.pre_reset = sdma_v4_4_2_stop_queue,
+	.post_reset = sdma_v4_4_2_restore_queue,
+};
+
+static void sdma_v4_4_2_set_reset_funcs(struct amdgpu_device *adev)
+{
+	amdgpu_sdma_register_on_reset_callbacks(adev, &sdma_v4_4_2_reset_funcs);
+}
+
 static int sdma_v4_4_2_set_trap_irq_state(struct amdgpu_device *adev,
 					struct amdgpu_irq_src *source,
 					unsigned type,
-- 
2.25.1

