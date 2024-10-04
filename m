Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F79CF8855
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Oct 2024 18:45:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77F3410EA92;
	Fri,  4 Oct 2024 18:45:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="st60yJyQ";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2087.outbound.protection.outlook.com [40.107.100.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41F1710EA8A
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Oct 2024 18:45:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8T5vYNEok/xJVB27x0xdYLewDkVqYzZ1Bn9vH5drYz7bhDaxSpQgHEmO1ZV+yD4+v1tx5OZAppumxDvqgkoi9U7KzcpYylFCjF1q7fCnYeZKpQvf+mqrIRsRxRFYcANRPgvp/Xlv/5irz6K1lwasf6WY83R1tjK+QS9my7zcK+MRdB2OlXmIrU8DnhLszqKin5zrXilKc+AtnwmG3m6N4+eJIKWcRuSXOnUXIYTc/jImIe/mmSPDoKBrtniSFEAUfpkeUDfVxSK8lwhGlS7Ydg1G0OlmCTIZPlvmjEpexg0cEyKnARWejkEQCqTCh8xkLbzxK0dGJb9dfBJVqx3Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUCIrt/mqR1zZlPjBl7jnj1SxxAljCBx23DmLaz/CP0=;
 b=VqxbjfkpEqwiH31CTyXCnXbMtvM//8FjYn56jVji1XZ7AbgsWgK283N3rYJbv4GFWqbgdyobVWE1nCXm75CZt6kCkEaLRUF67XI9MJZ6KAwacjnZIHl3POJ9SJPRtmUNeFCXcGiycmk9Q9HBt2TYVUS1qWTQNjsn3J4gOmOt9UGmEIjlaVIFfivr2zrPSutjiOWIj6w0FaLCmmZSlVSYDy5c3UAc43nkeV5MAqJT1ZF28397lK8TSSc27+uKIUkqrhHjZuuUBEjArTuLJcHBI6yJPAYOlwn+1PDGUDPg4nnaXXRea15W2TGhe8N020Atn3Og/wMxorJIhNJ4RS9TNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUCIrt/mqR1zZlPjBl7jnj1SxxAljCBx23DmLaz/CP0=;
 b=st60yJyQw0KgapUm9dKUxHetnEMatxEBKHSZF5EeNoNRijTPHFIh9fHzTsxP9+JjZ3OUAC4g7ujh0nz46Iokz+PuMHuQLtB+uGWrIRBIsVikoVN7yY0O/Twitf+I9mVlFsWu7OLlUn6yVCyX3i40L9SiZU6CIDopcUvb6CgOxss=
Received: from MN0P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::19)
 by IA0PR12MB7628.namprd12.prod.outlook.com (2603:10b6:208:436::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Fri, 4 Oct
 2024 18:45:07 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:52e:cafe::79) by MN0P220CA0026.outlook.office365.com
 (2603:10b6:208:52e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19 via Frontend
 Transport; Fri, 4 Oct 2024 18:45:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Fri, 4 Oct 2024 18:45:07 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 13:45:04 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 10/18] drm/amdgpu/vcn: separate gating state by instance
Date: Fri, 4 Oct 2024 14:44:36 -0400
Message-ID: <20241004184444.435356-11-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241004184444.435356-1-boyuan.zhang@amd.com>
References: <20241004184444.435356-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|IA0PR12MB7628:EE_
X-MS-Office365-Filtering-Correlation-Id: 75b8947c-7593-4e08-9257-08dce4a4ab0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?N/azGQOit8Au9aMavq7VpOKlMWv5TRNSOg3aqYl52Xf0diguL23OllVVcLLo?=
 =?us-ascii?Q?S+cjGXWjhCodSQS/mtMvSwHRAj0xihiUbWC/rFK+YWEAw3upNNDcOpJZvGs9?=
 =?us-ascii?Q?ldMnoKLM+QEYifMwswxQNb7BTe/mi9S/oIwL53c9yzCECd8t+jiGVOZ/+wrV?=
 =?us-ascii?Q?2bANzq7lWwdNL8zreV6qTw7DoMlGSXu1RPpM4AE81Sk18ZQSikWP3RxJnPv+?=
 =?us-ascii?Q?bPCXrfTxtsCalRqelpqkiyHqBO7WYdN5jDqB3emldCWL+h7Yl3H9SxtCDIFh?=
 =?us-ascii?Q?7rtlXcHqoX0WKmCuCiUNW8RhSY7Q0pZTZQMQgPt5oHrwuUzlcNicNeH4WOAp?=
 =?us-ascii?Q?79eeyyRwXQ5DQ6/o7WMl093at9aLyHD/xv9uTHbgwxkfq4Eyw2ln3QmvXPe/?=
 =?us-ascii?Q?iHrsrzbxYL1AK4g+5Rwj+pS/m0La1kTM2cn5E7K/X9dvwrobK4vVX6NSn4FK?=
 =?us-ascii?Q?t2ioiDJwPEXO/bST1P/KRqB0EUkyyU3JegXVtFEs7NLnzLvgO+TybsaG72dj?=
 =?us-ascii?Q?zVN9/UAJRDVxhI68omuFt8pYdvnDmpqj9aC4HaFfTn2jkjpA4h6KIrQqs4Md?=
 =?us-ascii?Q?/IbdgkBgCGsAHVHZEnQN6i83pEIr9wS2DWG1N7CA/BKdj3ionJwFlaXdLDtQ?=
 =?us-ascii?Q?hvjp5u8C96ZgX/t49qHk1/hrT2Zs3PjDNLLKr4mqQAGnVqzwZvR+BdHHzzMd?=
 =?us-ascii?Q?vSo1qZaXMExm4aoyRl0w/n7JDP4lsgFWEHVy1z2m4aFHNDQczfedVp9n3xMS?=
 =?us-ascii?Q?wPSyRftPbIQ1TPT50bKYu2QCROiEA9mJFinyJ2bGMjR5stzepU/y6uw1u1UW?=
 =?us-ascii?Q?MeIEVv9ln7gYwG1HxzSCXMkqORtC1GK5uchYcKWaubsQN/22zvo1fswre9YQ?=
 =?us-ascii?Q?isvPa7EILCi5jVKRO8l0XB+rpgAxD3QXnQ25/qE52VPEeCHiXmMpBee+oHQX?=
 =?us-ascii?Q?UiDbcHN/dTdfUxskXraRkcU1I1zKvd3Uxis/HXmxvY0f/BzvBD1r6WlzZ9FV?=
 =?us-ascii?Q?rheKV3XWsfKC48xqEorK4lA/f+xo2puTcn3SG7OpXn9hUgK0x+jL5R6szmAc?=
 =?us-ascii?Q?9c1oh9Kofo/X2505v3CWoFJP6/CKmcqvJ0AH/1K5LkSDvrXr8QFoie2tmu/v?=
 =?us-ascii?Q?kfCr3cQwE2MNidUgzqlE49UWTxonK0r7BCSQV7RCFbV2EPy7AZBJ9Oemms9T?=
 =?us-ascii?Q?UG5MahIFWuA6FjwZWgOxSgdQ3iWEpfb71X/lCbRXj9r22KNQJg6PP0qq3vkY?=
 =?us-ascii?Q?Lpef9qKJ98ro5PeNPk0R1JETFBwqhuQIIGzuHT292KbJVoqYvWz4zvq9bNzv?=
 =?us-ascii?Q?1ONWG4tUlTfea7qsD3a8/56+CW/HFOctIl+8wQAU6sM5KIRJ1lqQLvKWzCD0?=
 =?us-ascii?Q?JCJ9wEY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 18:45:07.4171 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b8947c-7593-4e08-9257-08dce4a4ab0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7628
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
index 2a1f3dbb14d3..f6717f780acd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -308,7 +308,7 @@ struct amdgpu_vcn {
 	struct delayed_work	idle_work;
 	const struct firmware	*fw[AMDGPU_MAX_VCN_INSTANCES];	/* VCN firmware */
 	unsigned		num_enc_rings;
-	enum amd_powergating_state cur_state;
+	enum amd_powergating_state cur_state[AMDGPU_MAX_VCN_INSTANCES];
 	bool			indirect_sram;
 
 	uint8_t	num_vcn_inst;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 34b1e55a907a..4f768c6097d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -280,7 +280,7 @@ static int vcn_v1_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	cancel_delayed_work_sync(&adev->vcn.idle_work);
 
 	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-		(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
+		(adev->vcn.cur_state[0] != AMD_PG_STATE_GATE &&
 		 RREG32_SOC15(VCN, 0, mmUVD_STATUS))) {
 		vcn_v1_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 	}
@@ -1813,7 +1813,7 @@ static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	int ret;
 	struct amdgpu_device *adev = ip_block->adev;
 
-	if (state == adev->vcn.cur_state)
+	if (state == adev->vcn.cur_state[0])
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -1822,7 +1822,8 @@ static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		ret = vcn_v1_0_start(adev);
 
 	if (!ret)
-		adev->vcn.cur_state = state;
+		adev->vcn.cur_state[0] = state;
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 6c1f5d05f90a..1b9085ddc00f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -316,7 +316,7 @@ static int vcn_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	cancel_delayed_work_sync(&adev->vcn.idle_work);
 
 	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-	    (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
+	    (adev->vcn.cur_state[0] != AMD_PG_STATE_GATE &&
 	      RREG32_SOC15(VCN, 0, mmUVD_STATUS)))
 		vcn_v2_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 
@@ -1810,11 +1810,11 @@ static int vcn_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	struct amdgpu_device *adev = ip_block->adev;
 
 	if (amdgpu_sriov_vf(adev)) {
-		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
+		adev->vcn.cur_state[0] = AMD_PG_STATE_UNGATE;
 		return 0;
 	}
 
-	if (state == adev->vcn.cur_state)
+	if (state == adev->vcn.cur_state[0])
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -1823,7 +1823,8 @@ static int vcn_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		ret = vcn_v2_0_start(adev);
 
 	if (!ret)
-		adev->vcn.cur_state = state;
+		adev->vcn.cur_state[0] = state;
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 35ded346771d..d00df51bc400 100644
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
+	    (adev->vcn.cur_state[inst] != AMD_PG_STATE_GATE &&
+	     RREG32_SOC15(VCN, inst, mmUVD_STATUS))) {
+		vcn_v2_5_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 	}
 
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
+		amdgpu_irq_put(adev, &adev->vcn.inst[inst].ras_poison_irq, 0);
+
 	return 0;
 }
 
@@ -1830,12 +1828,13 @@ static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	int ret;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	if(state == adev->vcn.cur_state)
+	if (state == adev->vcn.cur_state[inst])
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -1843,8 +1842,8 @@ static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	else
 		ret = vcn_v2_5_start(adev);
 
-	if(!ret)
-		adev->vcn.cur_state = state;
+	if (!ret)
+		adev->vcn.cur_state[inst] = state;
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index c02c9ef8ddeb..e7d681773b62 100644
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
+		    (adev->vcn.cur_state[inst] != AMD_PG_STATE_GATE &&
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
+		adev->vcn.cur_state[inst] = AMD_PG_STATE_UNGATE;
 		return 0;
 	}
 
-	if (state == adev->vcn.cur_state)
+	if (state == adev->vcn.cur_state[inst])
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -2183,7 +2182,7 @@ static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		ret = vcn_v3_0_start(adev);
 
 	if (!ret)
-		adev->vcn.cur_state = state;
+		adev->vcn.cur_state[inst] = state;
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 319eb5a3d061..535d513752f4 100644
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
+		    (adev->vcn.cur_state[inst] != AMD_PG_STATE_GATE &&
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
 
@@ -2041,6 +2041,7 @@ static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	int ret;
 
 	/* for SRIOV, guest should not control VCN Power-gating
@@ -2048,11 +2049,11 @@ static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	 * guest should avoid touching CGC and PG
 	 */
 	if (amdgpu_sriov_vf(adev)) {
-		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
+		adev->vcn.cur_state[inst] = AMD_PG_STATE_UNGATE;
 		return 0;
 	}
 
-	if (state == adev->vcn.cur_state)
+	if (state == adev->vcn.cur_state[inst])
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -2061,7 +2062,7 @@ static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		ret = vcn_v4_0_start(adev);
 
 	if (!ret)
-		adev->vcn.cur_state = state;
+		adev->vcn.cur_state[inst] = state;
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index b6c1135d6fec..deb13a376c6d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -315,10 +315,11 @@ static int vcn_v4_0_3_hw_init(struct amdgpu_ip_block *ip_block)
 static int vcn_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 
 	cancel_delayed_work_sync(&adev->vcn.idle_work);
 
-	if (adev->vcn.cur_state != AMD_PG_STATE_GATE)
+	if (adev->vcn.cur_state[inst] != AMD_PG_STATE_GATE)
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
+		adev->vcn.cur_state[inst] = AMD_PG_STATE_UNGATE;
 		return 0;
 	}
 
-	if (state == adev->vcn.cur_state)
+	if (state == adev->vcn.cur_state[inst])
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -1647,7 +1649,7 @@ static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		ret = vcn_v4_0_3_start(adev);
 
 	if (!ret)
-		adev->vcn.cur_state = state;
+		adev->vcn.cur_state[inst] = state;
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index ebf6301b13be..fe2f57bb389f 100644
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
+		    (adev->vcn.cur_state[inst] != AMD_PG_STATE_GATE &&
+		     RREG32_SOC15(VCN, inst, regUVD_STATUS))) {
+			vcn_v4_0_5_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 		}
 	}
 
@@ -1535,9 +1534,10 @@ static int vcn_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		enum amd_powergating_state state)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	int ret;
 
-	if (state == adev->vcn.cur_state)
+	if (state == adev->vcn.cur_state[inst])
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -1546,7 +1546,7 @@ static int vcn_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		ret = vcn_v4_0_5_start(adev);
 
 	if (!ret)
-		adev->vcn.cur_state = state;
+		adev->vcn.cur_state[inst] = state;
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 50c102f1b5fe..1af137e98070 100644
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
+		    (adev->vcn.cur_state[inst] != AMD_PG_STATE_GATE &&
+		     RREG32_SOC15(VCN, inst, regUVD_STATUS))) {
+			vcn_v5_0_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 		}
 	}
 
@@ -1262,9 +1261,10 @@ static int vcn_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		enum amd_powergating_state state)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	int ret;
 
-	if (state == adev->vcn.cur_state)
+	if (state == adev->vcn.cur_state[inst])
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -1273,7 +1273,7 @@ static int vcn_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		ret = vcn_v5_0_0_start(adev);
 
 	if (!ret)
-		adev->vcn.cur_state = state;
+		adev->vcn.cur_state[inst] = state;
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index c58a377a5146..10f4473d91ca 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2034,7 +2034,8 @@ static int smu_hw_fini(struct amdgpu_ip_block *ip_block)
 	smu_dpm_set_vpe_enable(smu, false);
 	smu_dpm_set_umsch_mm_enable(smu, false);
 
-	adev->vcn.cur_state = AMD_PG_STATE_GATE;
+	for (int i = 0; i < adev->vcn.num_vcn_inst; ++i)
+		adev->vcn.cur_state[i] = AMD_PG_STATE_GATE;
 	adev->jpeg.cur_state = AMD_PG_STATE_GATE;
 
 	if (!smu->pm_enabled)
-- 
2.34.1

