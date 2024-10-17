Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ABABD3748B
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 13:21:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34E1C10E831;
	Thu, 17 Oct 2024 13:21:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3P0yDGnp";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2062.outbound.protection.outlook.com [40.107.212.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A510410E81D
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 13:21:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pbDDnpoDHVpWRJnxDLJbWawZVnQ+eqdoJbgy1cq2wg8iRnluJRxP5DFMzIy35yBWjWYemcoOmK15ebVM4HUqt2RHYa3YXaBZE4jTfgeW0RcykETly+gHAcwRseHUUykT1D6546hgYGk4kNPIyYGYujyxQaEihuAIKRufU9qlMZ+zEXgirrxaZYUqr2Ef+0UDoxHHZPn9V6iUYxp+Ko4+Jym/HunGpAceXt+Wf6lCr1XcC0CUeX5knZHmHnM3uVJGtzfUGCK/EdLAD0CbJA8Ct9/wNjjEFqkkZGBKMHInZH5JbgRcbY2mHeFZe2Ds3xgwtvXQe8WZRJsPjXsqjeAISg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XT7jcobAkFcC/r3KlIDhp9xC8yUzLRF5jcbGDlewVvU=;
 b=harzstqONJmCD+rG2G1moSQAk4TNNIFqZG29ns4eFn6vNKJ6zMdqp621JpSnVadxEZ24SWcJ/OuFGZSvFRvf3L5PTNKNiLtMywfmSAmZPQ8VlYRB9shVaqn0Hp77ZAPoE8C0Th/Y5cqUA5CatnNI+BJ7waaD/SNafZN1lmEoljILIwCgEmWD4EyC1g7Uq4Lw/HxNR5U14mlSTSk8O6nes2rBMkLDFZAxD2UtSbENCYCSa+1uPJbj/o0D+FdDp7ajsH7t23p32q0/N1XCjNhTCWT7/1rV46BXXgxmRqs/shI3T1dtrGjnS5zaESDq/0rqx75Sxy3Q2fJkzrr3u/37Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XT7jcobAkFcC/r3KlIDhp9xC8yUzLRF5jcbGDlewVvU=;
 b=3P0yDGnp5U+eOj/fG4RjtQPxxRLQC5vVaMqCqu4aq2YMT9RWH4cM0LmpBgF0Zk/s74BTp+L8SJdKGQDGA4USJ/87Q+a1FNN/bxPPNrqcEMMLPEf7beEl89e5nmrVKIib9Q5xyJ5H/RCHKuNJm6dahZnSaWFoKvIBDyn8S0igBHw=
Received: from BN9PR03CA0883.namprd03.prod.outlook.com (2603:10b6:408:13c::18)
 by MN2PR12MB4141.namprd12.prod.outlook.com (2603:10b6:208:1d5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Thu, 17 Oct
 2024 13:21:26 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:13c:cafe::7a) by BN9PR03CA0883.outlook.office365.com
 (2603:10b6:408:13c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20 via Frontend
 Transport; Thu, 17 Oct 2024 13:21:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 13:21:25 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 08:21:22 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 11/32] drm/amdgpu/vcn: separate gating state by instance
Date: Thu, 17 Oct 2024 09:20:32 -0400
Message-ID: <20241017132053.53214-12-boyuan.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|MN2PR12MB4141:EE_
X-MS-Office365-Filtering-Correlation-Id: fca11b82-5d48-44eb-2ed6-08dceeae9a42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3tF5XFwG89wFdD6uPTNZCL1mxokrix5W/bOduy3ZbE2E+nAkHzSckxkx7a7N?=
 =?us-ascii?Q?uuxmiulO+YyJebX6HIYFHKpklJJmyCEaZswa8Kae/6NfyFHyVgP1N800Guxr?=
 =?us-ascii?Q?yyWnkqqI1NOK3G0+9EOKWLk1jP8Wr+6N9f4lhgULtPoHX0kO0Byi/GaPpMqR?=
 =?us-ascii?Q?CAp7mAcU15xPZg3MBbFSNoq4SgTvrNRjy5IjBwQCvWS/0uUa/jStFvXkH7Bb?=
 =?us-ascii?Q?+9BKdEoBPFvIo5cNKHeD+TzaxZwtV5yPBIYaozx3kes1AUBfKZeN82cME+mA?=
 =?us-ascii?Q?RCWIujYwiB5LOPSgVPs66RKyZU0MVSDFq/A6udy9D35SYJ0H84nCjS22NUaT?=
 =?us-ascii?Q?soo5jYq1dXeuoVAO7ltznyDCM52JsXaJY9R7ed1UUZ2907wu9XlZhH4NlLsE?=
 =?us-ascii?Q?h11yzTDzYFZ++DHDg9PrwTmhuz5UCZOC25gbvc1pnT0ZRESpr1yPg2POhmZT?=
 =?us-ascii?Q?FCKInQBkR54onf3lK+i6FMhLws2WKZWmx6PBbT2U6/25D9tO9vhFAYN5nn/e?=
 =?us-ascii?Q?+4APm8Dh3rbY//y6b1RJ4w+y/JcZuZfXkIGS/hRkZhj71yDcmVv8NZdaCF/8?=
 =?us-ascii?Q?TW6Rua4VlREwJ1RezSGoIa4WxRRcePV+IU/nywQJ3f84Vbh4xNzIRBCcOllO?=
 =?us-ascii?Q?0uWUgCuOZJ6KFIxMy48g3OR6h1ePJxCEMWo+9XIHXySYaDJlO95DxrvSO7rl?=
 =?us-ascii?Q?cImL/1Lkt/kOATC82JYO6k11wlDWWT28AOY08RVuWDKoq2L/EmWlyb4xkaEl?=
 =?us-ascii?Q?HI5aA6rjfLkIH3BfZJOnwAPhZTQefQuW951qz1ymDlaED/77yDp+isnJasiO?=
 =?us-ascii?Q?tO+elKZXW39QhqEvuNalGV6999UrHUfmvPn/5XZpeb585eYp9qXh6mkhO9gU?=
 =?us-ascii?Q?olP1QJEns/ETYFildyiHyh3+byKW7/Z29QArEio1xFOeJkGyyw5NfplrvOUz?=
 =?us-ascii?Q?iHYm+9N9L2l1O2LEenbkFogzwYZvAUP1PDLaBcEn5ju2ojCnxo4kPXkylymQ?=
 =?us-ascii?Q?8V+VpatP0XDAtO3ko9VCq7Jo5FA/i3+DQm4a8qNLkoEYLrQ5pagM6nU/55wG?=
 =?us-ascii?Q?gJ1fy2oSLJgGMK0eWa9SGUNcmMqy+vDcRx3G4s7nY44BvyOe7oCj+rKShaX7?=
 =?us-ascii?Q?Nbgzp7CvArAIA1NgX9MdfMEDicLkFvLVzL7lQb/J6wbP+mtIFDYw1V+yQw/A?=
 =?us-ascii?Q?GzfhaAtkotEbCntu4gwqMk2qEySsHTq5yk7hYTNHFu7b3MxjUD/LuDB93HPU?=
 =?us-ascii?Q?KfCMLaU9BhTAluLuAx8TMDTlbYd+QenBD45hlG1T7G2AqwG/vtT7q5ENY7NC?=
 =?us-ascii?Q?kurgTaNAjBntd7E3Ez4sJsfqACupMB9H3Z1od9cC8PBie17RgHq/CGuFAYvN?=
 =?us-ascii?Q?uPSUmP8oNLYLDTo9Xl4QK83pVr/Rj6Bers2iUda3zMDHO2YVtA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 13:21:25.8891 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fca11b82-5d48-44eb-2ed6-08dceeae9a42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4141
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

vcn gating state should now be based on instance. For example, instance 0
can be gated while instance 1 is ungated, or vice versa.

Therefore, change the cur_state to be an array, so that it can track the
gating status for each vcn instance now.

v2: remove redundant codes in v1.

v3: move cur_state from amdgpu_vcn to amdgou_vcn_inst since it's a per
instance variable.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h   |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c     |  7 ++---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c     |  9 ++++---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c     | 29 ++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c     | 25 +++++++++---------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c     | 31 ++++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c   | 10 +++++---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c   | 24 +++++++++---------
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c   | 24 +++++++++---------
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c |  3 ++-
 10 files changed, 84 insertions(+), 80 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index fc2efa53f3f4..0d882ba59b22 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -298,6 +298,7 @@ struct amdgpu_vcn_inst {
 	struct amdgpu_vcn_fw_shared fw_shared;
 	uint8_t			aid_id;
 	const struct firmware	*fw; /* VCN firmware */
+	enum amd_powergating_state cur_state;
 	uint8_t			vcn_config;
 	uint32_t		vcn_codec_disable_mask;
 };
@@ -310,7 +311,6 @@ struct amdgpu_vcn {
 	unsigned		fw_version;
 	struct delayed_work	idle_work;
 	unsigned		num_enc_rings;
-	enum amd_powergating_state cur_state;
 	bool			indirect_sram;
 
 	uint8_t	num_vcn_inst;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 553ad1efef03..407b0b5146cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -280,7 +280,7 @@ static int vcn_v1_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	cancel_delayed_work_sync(&adev->vcn.idle_work);
 
 	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-		(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
+		(adev->vcn.inst[0].cur_state != AMD_PG_STATE_GATE &&
 		 RREG32_SOC15(VCN, 0, mmUVD_STATUS))) {
 		vcn_v1_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 	}
@@ -1813,7 +1813,7 @@ static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	int ret;
 	struct amdgpu_device *adev = ip_block->adev;
 
-	if (state == adev->vcn.cur_state)
+	if (state == adev->vcn.inst[0].cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -1822,7 +1822,8 @@ static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		ret = vcn_v1_0_start(adev);
 
 	if (!ret)
-		adev->vcn.cur_state = state;
+		adev->vcn.inst[0].cur_state = state;
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 670b8b4c89f9..03eaae64c356 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -316,7 +316,7 @@ static int vcn_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	cancel_delayed_work_sync(&adev->vcn.idle_work);
 
 	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-	    (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
+	    (adev->vcn.inst[0].cur_state != AMD_PG_STATE_GATE &&
 	      RREG32_SOC15(VCN, 0, mmUVD_STATUS)))
 		vcn_v2_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 
@@ -1810,11 +1810,11 @@ static int vcn_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	struct amdgpu_device *adev = ip_block->adev;
 
 	if (amdgpu_sriov_vf(adev)) {
-		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
+		adev->vcn.inst[0].cur_state = AMD_PG_STATE_UNGATE;
 		return 0;
 	}
 
-	if (state == adev->vcn.cur_state)
+	if (state == adev->vcn.inst[0].cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -1823,7 +1823,8 @@ static int vcn_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		ret = vcn_v2_0_start(adev);
 
 	if (!ret)
-		adev->vcn.cur_state = state;
+		adev->vcn.inst[0].cur_state = state;
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index f9d34b8de874..8f9e5535429f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -388,24 +388,22 @@ static int vcn_v2_5_hw_init(struct amdgpu_ip_block *ip_block)
 static int vcn_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i;
+	int inst = ip_block->instance;
 
 	cancel_delayed_work_sync(&adev->vcn.idle_work);
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-
-		if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-		    (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
-		     RREG32_SOC15(VCN, i, mmUVD_STATUS))) {
-			vcn_v2_5_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
-		}
+	if (adev->vcn.harvest_config & (1 << inst))
+		return 0;
 
-		if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
-			amdgpu_irq_put(adev, &adev->vcn.inst[i].ras_poison_irq, 0);
+	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
+	    (adev->vcn.inst[inst].cur_state != AMD_PG_STATE_GATE &&
+	     RREG32_SOC15(VCN, inst, mmUVD_STATUS))) {
+		vcn_v2_5_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 	}
 
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
+		amdgpu_irq_put(adev, &adev->vcn.inst[inst].ras_poison_irq, 0);
+
 	return 0;
 }
 
@@ -1831,12 +1829,13 @@ static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	int ret;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	if(state == adev->vcn.cur_state)
+	if (state == adev->vcn.inst[inst].cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -1844,8 +1843,8 @@ static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	else
 		ret = vcn_v2_5_start(adev);
 
-	if(!ret)
-		adev->vcn.cur_state = state;
+	if (!ret)
+		adev->vcn.inst[inst].cur_state = state;
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 79e5adddd97c..a5648089ba05 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -420,20 +420,18 @@ static int vcn_v3_0_hw_init(struct amdgpu_ip_block *ip_block)
 static int vcn_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i;
+	int inst = ip_block->instance;
 
 	cancel_delayed_work_sync(&adev->vcn.idle_work);
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return 0;
 
-		if (!amdgpu_sriov_vf(adev)) {
-			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
-				 RREG32_SOC15(VCN, i, mmUVD_STATUS))) {
-				vcn_v3_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
-			}
+	if (!amdgpu_sriov_vf(adev)) {
+		if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
+		    (adev->vcn.inst[inst].cur_state != AMD_PG_STATE_GATE &&
+		     RREG32_SOC15(VCN, inst, mmUVD_STATUS))) {
+			vcn_v3_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 		}
 	}
 
@@ -2163,6 +2161,7 @@ static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	int ret;
 
 	/* for SRIOV, guest should not control VCN Power-gating
@@ -2170,11 +2169,11 @@ static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	 * guest should avoid touching CGC and PG
 	 */
 	if (amdgpu_sriov_vf(adev)) {
-		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
+		adev->vcn.inst[inst].cur_state = AMD_PG_STATE_UNGATE;
 		return 0;
 	}
 
-	if (state == adev->vcn.cur_state)
+	if (state == adev->vcn.inst[inst].cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -2183,7 +2182,7 @@ static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		ret = vcn_v3_0_start(adev);
 
 	if (!ret)
-		adev->vcn.cur_state = state;
+		adev->vcn.inst[inst].cur_state = state;
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 8ab02e5bcdd0..14640d9352a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -348,24 +348,24 @@ static int vcn_v4_0_hw_init(struct amdgpu_ip_block *ip_block)
 static int vcn_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i;
+	int inst = ip_block->instance;
 
 	cancel_delayed_work_sync(&adev->vcn.idle_work);
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-		if (!amdgpu_sriov_vf(adev)) {
-			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
-				 RREG32_SOC15(VCN, i, regUVD_STATUS))) {
-				vcn_v4_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
-			}
+	if (adev->vcn.harvest_config & (1 << inst))
+		return 0;
+
+	if (!amdgpu_sriov_vf(adev)) {
+		if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
+		    (adev->vcn.inst[inst].cur_state != AMD_PG_STATE_GATE &&
+		     RREG32_SOC15(VCN, inst, regUVD_STATUS))) {
+			vcn_v4_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 		}
-		if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
-			amdgpu_irq_put(adev, &adev->vcn.inst[i].ras_poison_irq, 0);
 	}
 
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
+		amdgpu_irq_put(adev, &adev->vcn.inst[inst].ras_poison_irq, 0);
+
 	return 0;
 }
 
@@ -2042,6 +2042,7 @@ static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	int ret;
 
 	/* for SRIOV, guest should not control VCN Power-gating
@@ -2049,11 +2050,11 @@ static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	 * guest should avoid touching CGC and PG
 	 */
 	if (amdgpu_sriov_vf(adev)) {
-		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
+		adev->vcn.inst[inst].cur_state = AMD_PG_STATE_UNGATE;
 		return 0;
 	}
 
-	if (state == adev->vcn.cur_state)
+	if (state == adev->vcn.inst[inst].cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -2062,7 +2063,7 @@ static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		ret = vcn_v4_0_start(adev);
 
 	if (!ret)
-		adev->vcn.cur_state = state;
+		adev->vcn.inst[inst].cur_state = state;
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 323ad6e34a15..ef246bf9d15c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -315,10 +315,11 @@ static int vcn_v4_0_3_hw_init(struct amdgpu_ip_block *ip_block)
 static int vcn_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 
 	cancel_delayed_work_sync(&adev->vcn.idle_work);
 
-	if (adev->vcn.cur_state != AMD_PG_STATE_GATE)
+	if (adev->vcn.inst[inst].cur_state != AMD_PG_STATE_GATE)
 		vcn_v4_0_3_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 
 	return 0;
@@ -1627,6 +1628,7 @@ static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	int ret;
 
 	/* for SRIOV, guest should not control VCN Power-gating
@@ -1634,11 +1636,11 @@ static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	 * guest should avoid touching CGC and PG
 	 */
 	if (amdgpu_sriov_vf(adev)) {
-		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
+		adev->vcn.inst[inst].cur_state = AMD_PG_STATE_UNGATE;
 		return 0;
 	}
 
-	if (state == adev->vcn.cur_state)
+	if (state == adev->vcn.inst[inst].cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -1647,7 +1649,7 @@ static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		ret = vcn_v4_0_3_start(adev);
 
 	if (!ret)
-		adev->vcn.cur_state = state;
+		adev->vcn.inst[inst].cur_state = state;
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index eceed8cdb3bb..f0e48e9bd839 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -298,19 +298,18 @@ static int vcn_v4_0_5_hw_init(struct amdgpu_ip_block *ip_block)
 static int vcn_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i;
+	int inst = ip_block->instance;
 
 	cancel_delayed_work_sync(&adev->vcn.idle_work);
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-		if (!amdgpu_sriov_vf(adev)) {
-			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
-				RREG32_SOC15(VCN, i, regUVD_STATUS))) {
-				vcn_v4_0_5_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
-			}
+	if (adev->vcn.harvest_config & (1 << inst))
+		return 0;
+
+	if (!amdgpu_sriov_vf(adev)) {
+		if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
+		    (adev->vcn.inst[inst].cur_state != AMD_PG_STATE_GATE &&
+		     RREG32_SOC15(VCN, inst, regUVD_STATUS))) {
+			vcn_v4_0_5_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 		}
 	}
 
@@ -1536,9 +1535,10 @@ static int vcn_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		enum amd_powergating_state state)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	int ret;
 
-	if (state == adev->vcn.cur_state)
+	if (state == adev->vcn.inst[inst].cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -1547,7 +1547,7 @@ static int vcn_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		ret = vcn_v4_0_5_start(adev);
 
 	if (!ret)
-		adev->vcn.cur_state = state;
+		adev->vcn.inst[inst].cur_state = state;
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 234f245e2792..8e716165cc03 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -262,19 +262,18 @@ static int vcn_v5_0_0_hw_init(struct amdgpu_ip_block *ip_block)
 static int vcn_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i;
+	int inst = ip_block->instance;
 
 	cancel_delayed_work_sync(&adev->vcn.idle_work);
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-		if (!amdgpu_sriov_vf(adev)) {
-			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
-				RREG32_SOC15(VCN, i, regUVD_STATUS))) {
-				vcn_v5_0_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
-			}
+	if (adev->vcn.harvest_config & (1 << inst))
+		return 0;
+
+	if (!amdgpu_sriov_vf(adev)) {
+		if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
+		    (adev->vcn.inst[inst].cur_state != AMD_PG_STATE_GATE &&
+		     RREG32_SOC15(VCN, inst, regUVD_STATUS))) {
+			vcn_v5_0_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 		}
 	}
 
@@ -1263,9 +1262,10 @@ static int vcn_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		enum amd_powergating_state state)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	int ret;
 
-	if (state == adev->vcn.cur_state)
+	if (state == adev->vcn.inst[inst].cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -1274,7 +1274,7 @@ static int vcn_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		ret = vcn_v5_0_0_start(adev);
 
 	if (!ret)
-		adev->vcn.cur_state = state;
+		adev->vcn.inst[inst].cur_state = state;
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 15310f74c483..61c700e2c47f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2034,7 +2034,8 @@ static int smu_hw_fini(struct amdgpu_ip_block *ip_block)
 	smu_dpm_set_vpe_enable(smu, false);
 	smu_dpm_set_umsch_mm_enable(smu, false);
 
-	adev->vcn.cur_state = AMD_PG_STATE_GATE;
+	for (int i = 0; i < adev->vcn.num_vcn_inst; ++i)
+		adev->vcn.inst[i].cur_state = AMD_PG_STATE_GATE;
 	adev->jpeg.cur_state = AMD_PG_STATE_GATE;
 
 	if (!smu->pm_enabled)
-- 
2.34.1

