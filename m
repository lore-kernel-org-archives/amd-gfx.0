Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B005ED637AE
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 21:04:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B60510E5C0;
	Tue, 16 Dec 2025 21:04:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gRm9ZI7e";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011016.outbound.protection.outlook.com [52.101.52.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1771B10E5C0
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 21:04:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sZAR02PubT5XpDUVw6b9hmOUqY6FwdYgQ+c8AmDWoKx/IL1hMZCB7uWJ0ByQUAX3wqNrunXFUj9LMm9b+k4Gpa9TUJ62i5aStJgB7KGwwnZCRkNC2EoPdvT76JAD6kw3UGb9vZisHQSBaUWZ2AuhmSDZFymFiVi5vIj82Tg506XOYKdDqLjUG5zBwjp91P89jBg5isr6tFIRmzvU9jIVWDle283SQ9dcNaa/FntZ0IxS0GQguumiillTvhLsXlyxYtxIStMgAdGJdAf7olfZFmrHnXxzkKY/9wNIY7a9bPfv+m35aCDX9M3ga7HUHey76g3GgGOsT1QTbc9A7jW6RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5MFptAlvH7fMg0P++5oFe2ETzkl5SXVz8qPCla2Cyb8=;
 b=xpS/pa5J/gX1DyE3svznj/o+1xslN9rKR6huAPJY5qtNg03BgpZDcyKjcWUHKcAekb4f4YCJZBfGvYEb17E96cYRszAR8iXQxds8mHMmGEWJK5kdDQgGm2bwE4KR9A387H4Vu7QbGs0TMviPPcJ+IGuen0iXaTo1iKXk6HMOPmuAR3kafp8LT0VYGsGtOvLXagfeLC5yVXvDmKkAkMUfMgu4B6BTuY0rAR/0T0p+teuQUKwC96sqTOYcLuLxZ+ng1lVMbtGZjw5RNAqV8x/9KLOUgt+47fLngzw3PTH61mWy84VjfFWeyY4cloQ48Dt/bO2cFLo6MCbAMUOLuNzr7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5MFptAlvH7fMg0P++5oFe2ETzkl5SXVz8qPCla2Cyb8=;
 b=gRm9ZI7eVHYcHyUAUZg1QpNYmk45RXN302fE6YhrFBOOYbPIqg3VPwYuhtl/yTHIwtyCUqU6jYG24LD5nzJLwC2i9S7je+ep2LEgokcR9pQqZixb4J3oH1CXpChnNQf+S5VlkLuBdc/9QzdattM3qiMjGk77ud8RjDs1nbzQMH0=
Received: from BL1P223CA0009.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::14)
 by SA1PR12MB9489.namprd12.prod.outlook.com (2603:10b6:806:45c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 21:04:04 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::e9) by BL1P223CA0009.outlook.office365.com
 (2603:10b6:208:2c4::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Tue,
 16 Dec 2025 21:04:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 21:04:04 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Dec
 2025 15:04:03 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: update mcm_addr_lut data for imu v12_1
Date: Tue, 16 Dec 2025 16:03:30 -0500
Message-ID: <20251216210349.1963466-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216210349.1963466-1-alexander.deucher@amd.com>
References: <20251216210349.1963466-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|SA1PR12MB9489:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a122809-53ee-4208-4e3c-08de3ce6a567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e8x5NYlDsU71qlxJeJKn6M+To8fWfoIkxfys7mTSpBtZiePuvB5unv0j2ELV?=
 =?us-ascii?Q?UVSPRDXvmVQwdPgjhRMQOopCM4SeGeSX+blU/MG4F5Xh62fFGF9BqCt4HcIp?=
 =?us-ascii?Q?KMNV5uj4D7UYHOf/iHcXOhG2t09lnBpq+BrjGVPbq/HlLEelH6rGp/cv5HZZ?=
 =?us-ascii?Q?VRTk1iaek53tGFAndclVAEVnD79+cti+IN7+r8jTKi+YWyLrp2edux1j+g7E?=
 =?us-ascii?Q?a5u5V7/q7jaaGLx/OIra1l8EzLDGAozRWe/NPsqcag5ndCQ/IGLs3725Iq5l?=
 =?us-ascii?Q?a4xSFg4pXnL6nCVVE0YyypCT38KXAZSznhtUI6AMAaPnxKSKck/Op/X/Eprk?=
 =?us-ascii?Q?MI32JNUoTZJphtiMxpLj6K8njmKXWBZFJJz/zAjY31O2DrhxtT36uqXKFD3Z?=
 =?us-ascii?Q?K1cjPM16w19dJBLdAm8V+mrmUn5bGW5PfpYC2zpf4JBGFq9XPHwq8nhrDSTG?=
 =?us-ascii?Q?7oLUMc27bVOGl44Ax8OzDkUBpaRGDMM2O9IHA9VMpOTiMel+aSA5dO4ehcMQ?=
 =?us-ascii?Q?VirrfHsQwNXCUhnYuAiKe0QCsFpMp0qVAG2C/R8V66KArgYACobx0Kv26tZ2?=
 =?us-ascii?Q?IRjtVZSiUpYUVnKnR3plz0cpxKaZzlZMi0TyUXKwo4JU3O87hgQrAsqy7Qi9?=
 =?us-ascii?Q?yTFpubWaEzmV4mQUh4U2/IyHKNZfHddMmjOg9ZrkMdpG2oYYeGGywpRcGoHv?=
 =?us-ascii?Q?oEQ8V1hMmPt7WGyHXON0Tm+sBayRU+G+g0lpdFpl84IHAYGspqsEAAvW2fZM?=
 =?us-ascii?Q?854Ode60MURmuWgtkdyBvPUVj40jHdwwkKwwEdCKxcz88i5Iar+5qw6yFD5k?=
 =?us-ascii?Q?kq+SARlRWu8o5UTUhKH7LvoLOfqbXjxeCdGsSw0gXylGR7BMcBfcx4t2XSo2?=
 =?us-ascii?Q?WqLVwGf0twZGmHzcLuoBBBvtQTF+1tA076Y+FJrQpnKBzPzXBXdmvmzVfGs4?=
 =?us-ascii?Q?OBoRCwqrnnJYC3mvtc2QsNtV10PF5IPxE3ktcH5GAGlQhytj31em6BAC0Aag?=
 =?us-ascii?Q?z+JOkRIyq6ocbWoTBeZ0X5Yoc9W38qXn/rfJXJOXqppTiftUdzBapQNVqxAo?=
 =?us-ascii?Q?q482f/xDaKwa7AZC1t9XcX9zqa6H3CraXWjyL660vLo5+fkO3NaeL8IBesxs?=
 =?us-ascii?Q?5RLSRt+vjDbP2dLtL++jcfE0LpxjULgfUVVxqufnZ15EB4QRcup4BVSRwFvH?=
 =?us-ascii?Q?4yEk/S/D9Q/pRl3NWCKPMXh3ard4GImyp44BL8xN7laVLHSP8PWmO/RkWCUn?=
 =?us-ascii?Q?mPAG3pcywt+JmYFLhcbM7+vUZmdGt83A8XS5vNctAgdQSX2E2OUfAfJd8130?=
 =?us-ascii?Q?4YqtJMsbXI+Z4HBrN6A2wT+bJZIsaEj06Vtf+VcdrXQiUZrE+oclv6I0qXQv?=
 =?us-ascii?Q?2aCBv5FV0HZCJl6S/qn2Dr1ef2h3Aci1Bs7DMhIVB4Cq9y84zLN+n92ymxDd?=
 =?us-ascii?Q?a8+KXWCtq6gMa9Xt/zSPqh4fiD7D4nvTwQT4ZaE5CvSTI8aXPJZH/ud3ww72?=
 =?us-ascii?Q?wZqixzUfcRDdza1950Pa2lYSoWStesjjJXwvfLBf1KbGOphzV27bSGo+0B+z?=
 =?us-ascii?Q?g+Zhetno4ARVyvZWTq4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 21:04:04.7919 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a122809-53ee-4208-4e3c-08de3ce6a567
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9489
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

From: Likun Gao <Likun.Gao@amd.com>

Support for partition mode to program MCM_ADDR_LUT.

v2: clean up (Alex)

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c |  5 -----
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c  | 11 +++++++++--
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 73ca4921ae5a6..c2c4cb6154fb7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -2666,11 +2666,6 @@ static void gfx_v12_1_init_golden_registers(struct amdgpu_device *adev)
 		gfx_v12_1_xcc_enable_atomics(adev, i);
 		gfx_v12_1_xcc_setup_tcp_thrashing_ctrl(adev, i);
 	}
-
-	if (adev->gfx.imu.funcs &&
-	    adev->gfx.imu.funcs->init_mcm_addr_lut &&
-	    amdgpu_emu_mode)
-		adev->gfx.imu.funcs->init_mcm_addr_lut(adev);
 }
 
 static int gfx_v12_1_hw_init(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index baa353ee7d1c1..628abd25ac091 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -658,8 +658,15 @@ static int soc_v1_0_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
 
 	num_xcc_per_xcp = __soc_v1_0_get_xcc_per_xcp(xcp_mgr, mode);
 	if (adev->gfx.imu.funcs &&
-	    adev->gfx.imu.funcs->switch_compute_partition)
-		adev->gfx.imu.funcs->switch_compute_partition(xcp_mgr->adev, num_xcc_per_xcp, mode);
+	    adev->gfx.imu.funcs->switch_compute_partition) {
+		ret = adev->gfx.imu.funcs->switch_compute_partition(xcp_mgr->adev, num_xcc_per_xcp, mode);
+		if (ret)
+			goto out;
+	}
+	if (adev->gfx.imu.funcs &&
+	    adev->gfx.imu.funcs->init_mcm_addr_lut &&
+	    amdgpu_emu_mode)
+		adev->gfx.imu.funcs->init_mcm_addr_lut(adev);
 
 	/* Init info about new xcps */
 	*num_xcps = num_xcc / num_xcc_per_xcp;
-- 
2.52.0

