Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9DE4D37485
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 13:21:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70EC210E81D;
	Thu, 17 Oct 2024 13:21:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q73Jwjq5";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 179A710E826
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 13:21:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tk0hML+jNIIOnGUWdqeyGbvhC1VOYKZAQQJ9cnioDJhQUunpTyHW+ZyPO3PP9HsQUVfYXZ+lLe6/AaUjY72ScG3YiCnzWV0DDMXPmOup1Jeop1UDVYmO5saRGahQW0o1u4SZsmCGWvo7lU8WPo9A7jAq7YCNGtSYx2U7nvTC4x0BRq2dxJykpdPTPLpaIw5GuIQxbRiD33B3PgZQXO8rlAVuX8120GgLE5ufd+lGxV3kUAdysLHL0fwy2MwnAIpo7e08gMy/W0wbCRoJYhYyMtuysLQAhnFIjzYZcAeia6QCDjfY4mcFG2zyyiWYorOTKp36ZROeYYfy5Bm+RWeegg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TFGwixck59Pbe42gNRP7hcc+ag25QJaiuoOsUNA14wU=;
 b=Uk6nwQLlD7T+m/ZGrNl3tw/7VIKKdIGU0+QYzcz4tJVcvbqEPwerBI97RNEgHUbPZYV17HHpCEHCtUCjT4KClPSCZ6MGiOF3CZC2qeMQHl8absxxj4SjGBt1Kn7gXZHkQmffnZi53Ht5jjgkzT5iteZuv6kgZ10BZw9cSStj0aJVePdV/lnoUcw6GaOfaTwpRTBQi0E+LQg8bwBFZn7rVKN4YzmEcwGcpXrX5SN771u6uWhPNWcmM9LLEiM6ylq1BOfknPklgiLl+rBiD6tEdkCnq0ZPCa/Nds11Yx+4NVsg/bbdPsFglLp+Nn2QJz9o8/BF3NPHuL0z/UVvmUlr4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFGwixck59Pbe42gNRP7hcc+ag25QJaiuoOsUNA14wU=;
 b=Q73Jwjq5qHn/NGVMlOLg7dMWDZs+Ca9RWg8xVOfI2L3D0aDv+GmnB4EMgo4a+4WGbxYFfLxVz9VIrD7xmx/WS3ED8dY4CpAF1FZ9ufb4atFgX6oSg2oObJTqlK7+aBr5RxtTp+X8QLkdaopHG3WJVoujmhEePV5KH3Ghv64k+AE=
Received: from BN9PR03CA0890.namprd03.prod.outlook.com (2603:10b6:408:13c::25)
 by PH7PR12MB7937.namprd12.prod.outlook.com (2603:10b6:510:270::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Thu, 17 Oct
 2024 13:21:21 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:13c:cafe::78) by BN9PR03CA0890.outlook.office365.com
 (2603:10b6:408:13c::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20 via Frontend
 Transport; Thu, 17 Oct 2024 13:21:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 13:21:21 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 08:21:19 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 06/32] add inst to amdgpu_dpm_enable_vcn
Date: Thu, 17 Oct 2024 09:20:27 -0400
Message-ID: <20241017132053.53214-7-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017132053.53214-1-boyuan.zhang@amd.com>
References: <20241017132053.53214-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|PH7PR12MB7937:EE_
X-MS-Office365-Filtering-Correlation-Id: be8a9e35-2730-4f75-c602-08dceeae976f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RMm617AlVe7XHpcCe6DOjFfD9kgkmrIEAmhMPrn6hC0b6GgLR9/y6o7oTb9M?=
 =?us-ascii?Q?OVbDPmlrAL61wiEnzK7NG+QzI9Gfc6YR+zMkTBCIbRRcOO20AalbsdwRhTLw?=
 =?us-ascii?Q?mg2dpQMvrjY2XkwlLheKzfTu20EZQCKMe+jvrcrCiS2o4zmUwGHW8/+VhIl+?=
 =?us-ascii?Q?I1ycflFCHlWQSyAjOasfgmxkx1bSIE1SExgWspVXCnnN+ktg+dJyp4FoEFPz?=
 =?us-ascii?Q?Q6RqZ91/gqy0Qljg/SxPATkOQN0+dIR2ZMlOJ0jYXNYrujoRdEM72j2sxMYI?=
 =?us-ascii?Q?wCOKWCT4EXDNStweoHbnd1RHykvo/Fk6psSARN447ZNA/rRM0YpCfVYzvesy?=
 =?us-ascii?Q?9EFIE3awfMnvYZ2OOv/RDaAYD3pAhrMNaf4M6XxnARuN71VhI6S7yKIbS7dp?=
 =?us-ascii?Q?mZ/v7+PqFpg3W9sD5KpZ1eJKDW7KRzfJ7l2TrNBjYfsksPGARdnbykUjckVr?=
 =?us-ascii?Q?L+1bMt8Bn7xiHO9cIdnTS6xC6+B27GkRARw8pl/KKRxrKbi+ggwkkg0/CS9M?=
 =?us-ascii?Q?WWPIxqFyRdRglbEgOUxjYBA8pYuKSC77mJo7IlE/w7uSELUnQilC6XpgLgMy?=
 =?us-ascii?Q?i4T17u71rzTjY1C6OaAKrzs8/Kp4CDmy888BjQjMl9RLXNmfqW8K79xlEY0t?=
 =?us-ascii?Q?px3rA9cHckX29tcddNZ/nkSc0aOKp0fiF7zZVXf+L/Te8jRnMNOnwlmumEpr?=
 =?us-ascii?Q?KAwkRgYFelDCetGhsrdiP15uSuhn+rQlS+iAxFZlpYtwwCGXfHfwkZdJApzk?=
 =?us-ascii?Q?hZqvvYq8w2u4ElmOR58NI37Osi8a5WrSE4AWxkDroNk3D+7CHQ6uXqvjgdOA?=
 =?us-ascii?Q?2kTGWwEx7fb81B1gjAW6rf+Kj0V9zJNJQFiuyHK196nACU/eNOLtOLWkKUd6?=
 =?us-ascii?Q?ka3oBiTQqaV3qKx5upYCI8XHMUyX1IkGaSrCcLMu+uvn+nlR0B1xme/0xRNU?=
 =?us-ascii?Q?dF72i6A1sWNNpi2N7gStIdJiP/YdH36j6rxjndHS9vxPl4qpShr5CAR6NyFP?=
 =?us-ascii?Q?e7L/yPI7Yo8fOE7aYYvvsywro9zt+JoKv3weojv7UhNBbUL8GqgOpsSJ0+xG?=
 =?us-ascii?Q?E6PYmyriP99FkVal/p9Hf0LxjbsQL+yEsbyOrsONeOGfCqGAzJ7dHJKwknWp?=
 =?us-ascii?Q?EZmGLnT0+Sg4uJ5dNjFx0eB4hsruuWRdskFPNvEyPk4cdZzlzNonrVUlOhao?=
 =?us-ascii?Q?oX/49YWxp4KFntZgmEbUW6OUF36VDYdsxs6RK/7F+ZxyX0EpO6fIsK3jyyNi?=
 =?us-ascii?Q?Zm4DA42bEUVEuN2hyRVQ2eXQwXgqMVG6S6S2NSwgJf0n4zw4HqTZpf1G8DlU?=
 =?us-ascii?Q?OJ6hIRnuJ2I9UUcsSvtBA6qkEb5OIVzm+dQNfa+JanF0OROTsGiIGhVuuWIB?=
 =?us-ascii?Q?ZpfHIZa2WSjkKhuKz8O1MKU8eZlGakExEduU81dmhca6oYoKrg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 13:21:21.1391 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be8a9e35-2730-4f75-c602-08dceeae976f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7937
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Add an instance parameter to amdgpu_dpm_enable_vcn() function, and change
all calls from vcn ip functions to add instance argument. vcn generations
with only one instance (v1.0, v2.0) always use 0 as instance number. vcn
generations with multiple instances (v2.5, v3.0, v4.0, v4.0.3, v4.0.5,
v5.0.0) use the actual instance number.

v2: remove for-loop in amdgpu_dpm_enable_vcn(), and temporarily move it
to vcn ip with multiple instances, in order to keep the exact same logic
as before, until further separation in next patch.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  6 +++---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 12 ++++++++----
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 12 ++++++++----
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 12 ++++++++----
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 12 ++++++++----
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 12 ++++++++----
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 12 ++++++++----
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c     | 12 +++++-------
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h |  2 +-
 10 files changed, 59 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 746b3d282ca3..1d5b0f4e5b1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -303,7 +303,7 @@ static int vcn_v1_0_suspend(struct amdgpu_ip_block *ip_block)
 	idle_work_unexecuted = cancel_delayed_work_sync(&adev->vcn.idle_work);
 	if (idle_work_unexecuted) {
 		if (adev->pm.dpm_enabled)
-			amdgpu_dpm_enable_vcn(adev, false);
+			amdgpu_dpm_enable_vcn(adev, false, 0);
 	}
 
 	r = vcn_v1_0_hw_fini(ip_block);
@@ -1856,7 +1856,7 @@ static void vcn_v1_0_idle_work_handler(struct work_struct *work)
 	if (fences == 0) {
 		amdgpu_gfx_off_ctrl(adev, true);
 		if (adev->pm.dpm_enabled)
-			amdgpu_dpm_enable_vcn(adev, false);
+			amdgpu_dpm_enable_vcn(adev, false, 0);
 		else
 			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
 			       AMD_PG_STATE_GATE);
@@ -1886,7 +1886,7 @@ void vcn_v1_0_set_pg_for_begin_use(struct amdgpu_ring *ring, bool set_clocks)
 	if (set_clocks) {
 		amdgpu_gfx_off_ctrl(adev, false);
 		if (adev->pm.dpm_enabled)
-			amdgpu_dpm_enable_vcn(adev, true);
+			amdgpu_dpm_enable_vcn(adev, true, 0);
 		else
 			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
 			       AMD_PG_STATE_UNGATE);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index d0c3895dcf6b..d87e5505cf51 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -978,7 +978,7 @@ static int vcn_v2_0_start(struct amdgpu_device *adev)
 	int i, j, r;
 
 	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, true);
+		amdgpu_dpm_enable_vcn(adev, true, 0);
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
 		return vcn_v2_0_start_dpg_mode(adev, adev->vcn.indirect_sram);
@@ -1235,7 +1235,7 @@ static int vcn_v2_0_stop(struct amdgpu_device *adev)
 
 power_off:
 	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, false);
+		amdgpu_dpm_enable_vcn(adev, false, 0);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index d4c062983bfe..ad0922eb16c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -1012,8 +1012,10 @@ static int vcn_v2_5_start(struct amdgpu_device *adev)
 	uint32_t rb_bufsz, tmp;
 	int i, j, k, r;
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, true);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, true, i);
+	}
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
@@ -1485,8 +1487,10 @@ static int vcn_v2_5_stop(struct amdgpu_device *adev)
 			~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
 	}
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, false);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, false, i);
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 1da9a7dfb667..19c7f9cd4c15 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1141,8 +1141,10 @@ static int vcn_v3_0_start(struct amdgpu_device *adev)
 	uint32_t rb_bufsz, tmp;
 	int i, j, k, r;
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, true);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, true, i);
+	}
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
@@ -1632,8 +1634,10 @@ static int vcn_v3_0_stop(struct amdgpu_device *adev)
 		vcn_v3_0_enable_static_power_gating(adev, i);
 	}
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, false);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, false, i);
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index a04a64442809..e97d7f4ae371 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1088,8 +1088,10 @@ static int vcn_v4_0_start(struct amdgpu_device *adev)
 	uint32_t tmp;
 	int i, j, k, r;
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, true);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, true, i);
+	}
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
@@ -1614,8 +1616,10 @@ static int vcn_v4_0_stop(struct amdgpu_device *adev)
 		vcn_v4_0_enable_static_power_gating(adev, i);
 	}
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, false);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, false, i);
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index d433d2703995..ba22913398ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1091,8 +1091,10 @@ static int vcn_v4_0_3_start(struct amdgpu_device *adev)
 	int i, j, k, r, vcn_inst;
 	uint32_t tmp;
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, true);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, true, i);
+	}
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
@@ -1365,8 +1367,10 @@ static int vcn_v4_0_3_stop(struct amdgpu_device *adev)
 		vcn_v4_0_3_enable_clock_gating(adev, i);
 	}
 Done:
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, false);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, false, i);
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 133ebb3c14db..873672f64778 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1000,8 +1000,10 @@ static int vcn_v4_0_5_start(struct amdgpu_device *adev)
 	uint32_t tmp;
 	int i, j, k, r;
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, true);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, true, i);
+	}
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
@@ -1277,8 +1279,10 @@ static int vcn_v4_0_5_stop(struct amdgpu_device *adev)
 		vcn_v4_0_5_enable_static_power_gating(adev, i);
 	}
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, false);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, false, i);
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index c57894f1734a..893e66c2b9a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -761,8 +761,10 @@ static int vcn_v5_0_0_start(struct amdgpu_device *adev)
 	uint32_t tmp;
 	int i, j, k, r;
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, true);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, true, i);
+	}
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
@@ -1008,8 +1010,10 @@ static int vcn_v5_0_0_stop(struct amdgpu_device *adev)
 		vcn_v5_0_0_enable_static_power_gating(adev, i);
 	}
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, false);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, false, i);
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 8531e0993b17..5a9006bfc3cd 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -581,7 +581,7 @@ void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable)
 			  enable ? "enable" : "disable", ret);
 }
 
-void amdgpu_dpm_enable_vcn(struct amdgpu_device *adev, bool enable)
+void amdgpu_dpm_enable_vcn(struct amdgpu_device *adev, bool enable, int inst)
 {
 	int ret = 0;
 
@@ -599,12 +599,10 @@ void amdgpu_dpm_enable_vcn(struct amdgpu_device *adev, bool enable)
 		return;
 	}
 
-	for (int i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VCN, !enable, i);
-		if (ret)
-			DRM_ERROR("Dpm %s uvd failed, ret = %d. \n",
-				  enable ? "enable" : "disable", ret);
-	}
+	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VCN, !enable, inst);
+	if (ret)
+		DRM_ERROR("Dpm %s uvd failed, ret = %d. \n",
+			  enable ? "enable" : "disable", ret);
 }
 
 void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable)
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index e7c84d4a431a..251b389dcf6e 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -442,7 +442,7 @@ void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev);
 
 void amdgpu_dpm_compute_clocks(struct amdgpu_device *adev);
 void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable);
-void amdgpu_dpm_enable_vcn(struct amdgpu_device *adev, bool enable);
+void amdgpu_dpm_enable_vcn(struct amdgpu_device *adev, bool enable, int inst);
 void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable);
 void amdgpu_dpm_enable_jpeg(struct amdgpu_device *adev, bool enable);
 void amdgpu_dpm_enable_vpe(struct amdgpu_device *adev, bool enable);
-- 
2.34.1

