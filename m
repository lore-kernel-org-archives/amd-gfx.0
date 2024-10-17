Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CBF7D37489
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 13:21:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19A5C10E827;
	Thu, 17 Oct 2024 13:21:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TakNdj65";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2054.outbound.protection.outlook.com [40.107.212.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F06910E832
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 13:21:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wj2BzvEEaEskGDdVD8e/EBUHAvCJDv3OVvkWHLMjHKRSZS/EpdqI3j5NwNTJ/JZs7Iy07HdSVXxLWXxPCNFVB93qs3uqmkeFza24kHbT4j34sahmnd6BXN+gccD/6TFi+i4qTzObzbPHTj6OrGfP5GXpUP//5H4sFs0lhTmYF/FZzs0jGnJYQU3ozemUpUgBQaeJVLoelqQlk+XZXK8YVAH7LMK/qnewti+nOsR3betCFCYwZ3bnlPHMKuwxkVLkay9xKueiRRaAWjUUBov/CKDR0Hp+w2kBkdQEfpxlTK0aaEdTltkoW3InpQRx9azMx0jOHL8pulaqhNlPcPH6dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65fjtnw2qcXAhVUpMjqD3fZxOXFdWTZXBQ/sVFlov9U=;
 b=xM077RKzrrcZMch3kU10TyM70ZZJIgw/mryXeM9Kl79gwdD0vNdeIhoXBYCFew0X0sTYvtqaLzMkfn7ZbyuZY1cu/mOBSy4mDy2MqAkIAFPWQNyB+Ymph5Nc7g/qndRm29SxHBTMaN/bH/00nVigE91Ta9HpNICPWtLLcM4mU9BVwSRIxQct1zXwN5W4KwPIWcICioI4/sf1ol7gOxXYaRYeGm1XMvarCJA62ZI5k6cFysV3VDsJ02hpz/0f3WurYF1Kotz2bCXGQkNOB3luxapkFcoozaHePd+Pz8JhfVZdS/jlQMfR9m3vblybZ1gtFQUkH6iYhd7QRUjFDdXf9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65fjtnw2qcXAhVUpMjqD3fZxOXFdWTZXBQ/sVFlov9U=;
 b=TakNdj65VW+H30C0WEZEUrBPidZAnb9dzntazY7Zfq7/kS6dTcQYETJ/1tWJ30d4SxscD0Ivao6nN/ZLlEW2JOYc4cB2mViSRtuHlf1cgt8/nbSy6g5RisXN+/4pix939/yevczTu64+w33jUdf6kBIyKrPVGQAD98G6oT9jjvU=
Received: from BN9PR03CA0887.namprd03.prod.outlook.com (2603:10b6:408:13c::22)
 by CH3PR12MB8936.namprd12.prod.outlook.com (2603:10b6:610:179::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Thu, 17 Oct
 2024 13:21:31 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:13c:cafe::ee) by BN9PR03CA0887.outlook.office365.com
 (2603:10b6:408:13c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20 via Frontend
 Transport; Thu, 17 Oct 2024 13:21:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 13:21:31 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 08:21:29 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 23/32] drm/amdgpu: hw_init for each vcn instance
Date: Thu, 17 Oct 2024 09:20:44 -0400
Message-ID: <20241017132053.53214-24-boyuan.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|CH3PR12MB8936:EE_
X-MS-Office365-Filtering-Correlation-Id: f401c2c6-e159-4f26-bbac-08dceeae9d59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?63tFkwi4OUbY/QP3dLDr2eAMiPD12Vu+8i2zOjo+mld3COUXEbnYE8O8p3IN?=
 =?us-ascii?Q?yWMVxhfHWYVFohcipZ/wRWHE0OsoOFvrOFEFxoYg4JZfDCjxcXXZHrJiNzXP?=
 =?us-ascii?Q?O/OwgKTU3HvFlSQUPOQu3XJlQqMtso6W+SC/MkL0rrhTveojDxo5Ck1DRn9n?=
 =?us-ascii?Q?pZa1MAkX1JAD8nulut8lJeyMg4g/9tNr/jKFVLiJZpK11p1kFaXxX8GAyDle?=
 =?us-ascii?Q?Ba5j0GuShvqpzPuMuIiZIKEn1VthFYkTPCN59cv2XuPEatUB4ATIuA1hStr8?=
 =?us-ascii?Q?1mPZIJnrQR40W+yPRi35SgMtQGKJ+SujNlXlZ4Ay+OJHwXvoxCAy3ONcGIgD?=
 =?us-ascii?Q?TCjgZS8x4SqqW7iT9JiwquL0kwWtZh8fkdy2vQkTjAJegagn8XDwzWbTf4Fp?=
 =?us-ascii?Q?zb2E4557dxK4XMmBVusyp8U8rwNEo1ghGJd4XRXskmk0aDscY5/H2QrtKBFu?=
 =?us-ascii?Q?6oQ9XkAA73xED3vRe+BmphRjGuNpZQJ8DjaduJ4vLcbwA/arPfPCr7n3m2ht?=
 =?us-ascii?Q?q/L2QMe9Ys4U6zqGnfappsMKaOs9XorKlTZeyYqqvIhG3wwUITwXz7EfsAgz?=
 =?us-ascii?Q?5uwsGZb/U3v9U7q/RwW3qFFy2sjPLDHXaPX8jzvt5DWKl2NCCgbH/nUU81tV?=
 =?us-ascii?Q?D/iL47ALV0pGeqjEiaoOzNhFynqHkku8n/uz4vOALb/9qSsjJgwRJuarX+mh?=
 =?us-ascii?Q?jpzfKfBNMGB7o+hRGJajg2qu39qFErx7z61ovJpCZ/sCDpipOVPF67E1hYHf?=
 =?us-ascii?Q?yrlAAbBkl/oHx8lqhglJZoKkiBiQxuw/0VMUKRgXgAndcS3UsNWpoVqzj/4j?=
 =?us-ascii?Q?fKhVopdXts+RYtFNpc5jCm0euQnkz1GdaKO6R/ixsl3jVejbuGxGfCrBdZ01?=
 =?us-ascii?Q?W8TiMlXP20DzzoAY/SppgE6wu1Fbig2HfV4XpTubF/F2c7g4t4dqXqKKdsiM?=
 =?us-ascii?Q?MEUqZUzX5cmddfQZJ+qBUuZb/hM1a9odSnLLRRkhaAs2FTEdPZoSonLEVAxW?=
 =?us-ascii?Q?YlTjk/B4t5hif8CVuIA4mlgxqtxhVS4Rsbny3RjLxevqkJPAmxv1hS8eaHRO?=
 =?us-ascii?Q?4kkdidHYdyVWSsbMMx5QSjO0GFQBNycd496T8PKYXL+D+G4r8lZLYsAiXPbu?=
 =?us-ascii?Q?SiGYr5ES2573a1shaGwlu0TGPk4/GGi3z3W1t71FJHr4Z4GAuUZnA0vHhHdU?=
 =?us-ascii?Q?H84pjQ2jNFqIWzfa+lz1/EH0rRRJjw5LvuWI9GslK5j2PvMKy/QQxf5ZmQRE?=
 =?us-ascii?Q?4/xiVfpDjVFeW+yGDyT9vepuboH9igXjwYE7gJy4qNXX+AkIoM5Msr5aQwaX?=
 =?us-ascii?Q?YX5FikL3JmWGjmYpM80Akf1MNl8gfGQo6QP91C9Eq/XhQBkdNCTAe5dHzub1?=
 =?us-ascii?Q?LDl/9o/qWDipr/HvAtoO6sp/86lgKieBNmOrODwreSecTwaS8g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 13:21:31.0766 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f401c2c6-e159-4f26-bbac-08dceeae9d59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8936
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

Pass instance parameter to amdgpu_vcn_hw_init(), and perform
hw init ONLY for the given vcn instance, instead of for all
vcn instances. Modify each vcn generation accordingly.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 39 +++++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 73 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 37 ++++++-------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 67 +++++++++++------------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 21 ++++---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 21 ++++---
 6 files changed, 123 insertions(+), 135 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index ed972d843f93..f225a0b214d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -338,37 +338,36 @@ static int vcn_v2_5_hw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_ring *ring;
-	int i, j, r = 0;
+	int inst = ip_block->instance;
+	int i, r = 0;
 
 	if (amdgpu_sriov_vf(adev))
 		r = vcn_v2_5_sriov_start(adev);
 
-	for (j = 0; j < adev->vcn.num_vcn_inst; ++j) {
-		if (adev->vcn.harvest_config & (1 << j))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return r;
 
-		if (amdgpu_sriov_vf(adev)) {
-			adev->vcn.inst[j].ring_enc[0].sched.ready = true;
-			adev->vcn.inst[j].ring_enc[1].sched.ready = false;
-			adev->vcn.inst[j].ring_enc[2].sched.ready = false;
-			adev->vcn.inst[j].ring_dec.sched.ready = true;
-		} else {
+	if (amdgpu_sriov_vf(adev)) {
+		adev->vcn.inst[inst].ring_enc[0].sched.ready = true;
+		adev->vcn.inst[inst].ring_enc[1].sched.ready = false;
+		adev->vcn.inst[inst].ring_enc[2].sched.ready = false;
+		adev->vcn.inst[inst].ring_dec.sched.ready = true;
+	} else {
+
+		ring = &adev->vcn.inst[inst].ring_dec;
 
-			ring = &adev->vcn.inst[j].ring_dec;
+		adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
+						 ring->doorbell_index, inst);
 
-			adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
-						     ring->doorbell_index, j);
+		r = amdgpu_ring_test_helper(ring);
+		if (r)
+			return r;
 
+		for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
+			ring = &adev->vcn.inst[inst].ring_enc[i];
 			r = amdgpu_ring_test_helper(ring);
 			if (r)
 				return r;
-
-			for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
-				ring = &adev->vcn.inst[j].ring_enc[i];
-				r = amdgpu_ring_test_helper(ring);
-				if (r)
-					return r;
-			}
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index c45bebeb0aaa..2d1835d06ecb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -345,8 +345,9 @@ static int vcn_v3_0_sw_fini(struct amdgpu_ip_block *ip_block)
 static int vcn_v3_0_hw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	struct amdgpu_ring *ring;
-	int i, j, r;
+	int j, r;
 
 	if (amdgpu_sriov_vf(adev)) {
 		r = vcn_v3_0_start_sriov(adev);
@@ -354,57 +355,53 @@ static int vcn_v3_0_hw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 
 		/* initialize VCN dec and enc ring buffers */
-		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-			if (adev->vcn.harvest_config & (1 << i))
-				continue;
+		if (adev->vcn.harvest_config & (1 << inst))
+			return 0;
+
+		ring = &adev->vcn.inst[inst].ring_dec;
+		if (amdgpu_vcn_is_disabled_vcn(adev, VCN_DECODE_RING, inst)) {
+			ring->sched.ready = false;
+			ring->no_scheduler = true;
+			dev_info(adev->dev, "ring %s is disabled by hypervisor\n", ring->name);
+		} else {
+			ring->wptr = 0;
+			ring->wptr_old = 0;
+			vcn_v3_0_dec_ring_set_wptr(ring);
+			ring->sched.ready = true;
+		}
 
-			ring = &adev->vcn.inst[i].ring_dec;
-			if (amdgpu_vcn_is_disabled_vcn(adev, VCN_DECODE_RING, i)) {
+		for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
+			ring = &adev->vcn.inst[inst].ring_enc[j];
+			if (amdgpu_vcn_is_disabled_vcn(adev, VCN_ENCODE_RING, inst)) {
 				ring->sched.ready = false;
 				ring->no_scheduler = true;
 				dev_info(adev->dev, "ring %s is disabled by hypervisor\n", ring->name);
 			} else {
 				ring->wptr = 0;
 				ring->wptr_old = 0;
-				vcn_v3_0_dec_ring_set_wptr(ring);
+				vcn_v3_0_enc_ring_set_wptr(ring);
 				ring->sched.ready = true;
 			}
-
-			for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
-				ring = &adev->vcn.inst[i].ring_enc[j];
-				if (amdgpu_vcn_is_disabled_vcn(adev, VCN_ENCODE_RING, i)) {
-					ring->sched.ready = false;
-					ring->no_scheduler = true;
-					dev_info(adev->dev, "ring %s is disabled by hypervisor\n", ring->name);
-				} else {
-					ring->wptr = 0;
-					ring->wptr_old = 0;
-					vcn_v3_0_enc_ring_set_wptr(ring);
-					ring->sched.ready = true;
-				}
-			}
 		}
-	} else {
-		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-			if (adev->vcn.harvest_config & (1 << i))
-				continue;
+	}
 
-			ring = &adev->vcn.inst[i].ring_dec;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return 0;
 
-			adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
-						     ring->doorbell_index, i);
+	ring = &adev->vcn.inst[inst].ring_dec;
 
-			r = amdgpu_ring_test_helper(ring);
-			if (r)
-				return r;
+	adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
+					 ring->doorbell_index, inst);
 
-			for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
-				ring = &adev->vcn.inst[i].ring_enc[j];
-				r = amdgpu_ring_test_helper(ring);
-				if (r)
-					return r;
-			}
-		}
+	r = amdgpu_ring_test_helper(ring);
+	if (r)
+		return r;
+
+	for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
+		ring = &adev->vcn.inst[inst].ring_enc[j];
+		r = amdgpu_ring_test_helper(ring);
+		if (r)
+			return r;
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index c87b4e46f2b0..afe2eba9aac4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -299,37 +299,34 @@ static int vcn_v4_0_hw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_ring *ring;
-	int i, r;
+	int inst = ip_block->instance;
+	int r;
 
 	if (amdgpu_sriov_vf(adev)) {
 		r = vcn_v4_0_start_sriov(adev);
 		if (r)
 			return r;
 
-		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-			if (adev->vcn.harvest_config & (1 << i))
-				continue;
+		if (adev->vcn.harvest_config & (1 << inst))
+			return 0;
 
-			ring = &adev->vcn.inst[i].ring_enc[0];
-			ring->wptr = 0;
-			ring->wptr_old = 0;
-			vcn_v4_0_unified_ring_set_wptr(ring);
-			ring->sched.ready = true;
-		}
+		ring = &adev->vcn.inst[inst].ring_enc[0];
+		ring->wptr = 0;
+		ring->wptr_old = 0;
+		vcn_v4_0_unified_ring_set_wptr(ring);
+		ring->sched.ready = true;
 	} else {
-		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-			if (adev->vcn.harvest_config & (1 << i))
-				continue;
+		if (adev->vcn.harvest_config & (1 << inst))
+			return 0;
 
-			ring = &adev->vcn.inst[i].ring_enc[0];
+		ring = &adev->vcn.inst[inst].ring_enc[0];
 
-			adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
-					((adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 * i), i);
+		adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
+				((adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 * inst), inst);
 
-			r = amdgpu_ring_test_helper(ring);
-			if (r)
-				return r;
-		}
+		r = amdgpu_ring_test_helper(ring);
+		if (r)
+			return r;
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 0b55d801ae88..0dc26dc173cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -257,49 +257,46 @@ static int vcn_v4_0_3_hw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_ring *ring;
-	int i, r, vcn_inst;
+	int inst = ip_block->instance;
+	int r = 0, vcn_inst;
 
 	if (amdgpu_sriov_vf(adev)) {
 		r = vcn_v4_0_3_start_sriov(adev);
 		if (r)
 			return r;
 
-		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-			ring = &adev->vcn.inst[i].ring_enc[0];
-			ring->wptr = 0;
-			ring->wptr_old = 0;
-			vcn_v4_0_3_unified_ring_set_wptr(ring);
-			ring->sched.ready = true;
-		}
+		ring = &adev->vcn.inst[inst].ring_enc[0];
+		ring->wptr = 0;
+		ring->wptr_old = 0;
+		vcn_v4_0_3_unified_ring_set_wptr(ring);
+		ring->sched.ready = true;
 	} else {
-		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-			vcn_inst = GET_INST(VCN, i);
-			ring = &adev->vcn.inst[i].ring_enc[0];
-
-			if (ring->use_doorbell) {
-				adev->nbio.funcs->vcn_doorbell_range(
-					adev, ring->use_doorbell,
-					(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
-						9 * vcn_inst,
-					adev->vcn.inst[i].aid_id);
-
-				WREG32_SOC15(
-					VCN, GET_INST(VCN, ring->me),
-					regVCN_RB1_DB_CTRL,
-					ring->doorbell_index
-							<< VCN_RB1_DB_CTRL__OFFSET__SHIFT |
-						VCN_RB1_DB_CTRL__EN_MASK);
-
-				/* Read DB_CTRL to flush the write DB_CTRL command. */
-				RREG32_SOC15(
-					VCN, GET_INST(VCN, ring->me),
-					regVCN_RB1_DB_CTRL);
-			}
-
-			r = amdgpu_ring_test_helper(ring);
-			if (r)
-				return r;
+		vcn_inst = GET_INST(VCN, inst);
+		ring = &adev->vcn.inst[inst].ring_enc[0];
+
+		if (ring->use_doorbell) {
+			adev->nbio.funcs->vcn_doorbell_range(
+				adev, ring->use_doorbell,
+				(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
+					9 * vcn_inst,
+				adev->vcn.inst[inst].aid_id);
+
+			WREG32_SOC15(
+				VCN, GET_INST(VCN, ring->me),
+				regVCN_RB1_DB_CTRL,
+				ring->doorbell_index
+						<< VCN_RB1_DB_CTRL__OFFSET__SHIFT |
+					VCN_RB1_DB_CTRL__EN_MASK);
+
+			/* Read DB_CTRL to flush the write DB_CTRL command. */
+			RREG32_SOC15(
+				VCN, GET_INST(VCN, ring->me),
+				regVCN_RB1_DB_CTRL);
 		}
+
+		r = amdgpu_ring_test_helper(ring);
+		if (r)
+			return r;
 	}
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index b88fdb00cc5e..36e4477c99f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -268,21 +268,20 @@ static int vcn_v4_0_5_hw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_ring *ring;
-	int i, r;
+	int inst = ip_block->instance;
+	int r;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return 0;
 
-		ring = &adev->vcn.inst[i].ring_enc[0];
+	ring = &adev->vcn.inst[inst].ring_enc[0];
 
-		adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
-				((adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 * i), i);
+	adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
+			((adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 * inst), inst);
 
-		r = amdgpu_ring_test_helper(ring);
-		if (r)
-			return r;
-	}
+	r = amdgpu_ring_test_helper(ring);
+	if (r)
+		return r;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 15cdc7be9062..687d413a50b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -232,21 +232,20 @@ static int vcn_v5_0_0_hw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_ring *ring;
-	int i, r;
+	int inst = ip_block->instance;
+	int r;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return 0;
 
-		ring = &adev->vcn.inst[i].ring_enc[0];
+	ring = &adev->vcn.inst[inst].ring_enc[0];
 
-		adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
-			((adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 * i), i);
+	adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
+		((adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 * inst), inst);
 
-		r = amdgpu_ring_test_helper(ring);
-		if (r)
-			return r;
-	}
+	r = amdgpu_ring_test_helper(ring);
+	if (r)
+		return r;
 
 	return 0;
 }
-- 
2.34.1

