Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2446BC3ABBC
	for <amd-gfx@archiver.kernel.org>; Tue,  6 May 2025 20:50:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 578F010E27A;
	Tue,  6 May 2025 20:50:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g+rJIafS";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F319010E0FB
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 May 2025 20:50:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tAxWuzetlSdaNetiF7IiTL0Kj0wQIqZi9pG0HZgOSSAioRg7nX4nFNpw78S1bRQco24m1HXbZHoLbde6NTQB2pfbOrQHmQRwwyJNGYDfU1fftWneHlaB5sj7BJvRTPCQY3PVQmT6CjUUd3Cv3/NES99JQzhkCKNSdnLbHuNGkJtHDydP1WkHbvSXqarp0ZCKR358QIlBKnsLDPsITPdGC5o1wfQ39qrcWG9dDTl2P6SrZ9aseWO9udaX/szmVfEzUEw9uYs1dRa9N986pmJw9kNFVqKMk1Q7qLUq8MpIarUkDLhTGkP29Um5+tk1kc2hYcStDjoK02Hwtekzhq7Z8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFaB9F4Dk4YARINHBNorWmwfTSSy2yN/+kkXZNAk384=;
 b=LVVpwARZ92l1L1gY3CZ4juzqD86PCet4dsKy7ZVfq8wwRbC02sUDm7z2PgTQTqHUPPvTF8huDQclh3pa5Wnr9GFShbPXqm0EDMIecl81WYSd85TudefZPtZhGNiuNxmjVCT+nVm3zC4hI4oxZWisPjbuO6+o6MALZHjvQ7DUxUJEAKoXn2OP5fEsZkNQFVlJbzmz807hHCFaH/A/VUFK3npnmmMHIF7ooLMM40c2NdyNUwuXtnvdqmWNv7kCrT9lDKIlbiobqE79eI4B7YQ51EWzn4MJz7vFHsXl8/+JbteCgh50YELk93ItOQLPinCqw3thlTs4xJEWfm/stS7Jkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFaB9F4Dk4YARINHBNorWmwfTSSy2yN/+kkXZNAk384=;
 b=g+rJIafShEdgi7OM7T20uuMis0cyeqi40+hV4ikRWptTPkGhoUvG5iQ62GzarKNh7xDpJ7Zd60CEeijGriEqN7807qaa935wBzg1umhQdDHaBzORoZ9Ze3BaWeyAGtkdXBsOd/zqWf8YxVjY3Z2dRFZVGyBvKvySP2AgtGVebU4=
Received: from CH2PR02CA0026.namprd02.prod.outlook.com (2603:10b6:610:4e::36)
 by CH1PPF351A22FF6.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::60c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Tue, 6 May
 2025 20:50:07 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:4e:cafe::1a) by CH2PR02CA0026.outlook.office365.com
 (2603:10b6:610:4e::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Tue,
 6 May 2025 20:50:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 6 May 2025 20:50:06 +0000
Received: from AUS-V14-AI-23.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 15:50:04 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <David.Wu3@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 2/3] drm/amd: Add per-ring reset for vcn v4.0.0 use
Date: Tue, 6 May 2025 15:49:47 -0500
Message-ID: <20250506204948.12048-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506204948.12048-1-mario.limonciello@amd.com>
References: <20250506204948.12048-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|CH1PPF351A22FF6:EE_
X-MS-Office365-Filtering-Correlation-Id: 58a1f0b1-ab26-4148-d6aa-08dd8cdf9577
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DyWmYHzKAHjqDV7wPv2LKAs38EDTaJY6BjdzXuuxEGLN2sF3vVDUT1KnwGSN?=
 =?us-ascii?Q?p7EA40xfv0FV1t219eeh1u8o6f9cOzvbYSf6jx75KPYupkA22895Dhub+4/T?=
 =?us-ascii?Q?R/HoEcxaFsSeJcpjLpzbInqXoqbcNCy9lwf/HCekENibi1Mg8cJFaGHG4YXB?=
 =?us-ascii?Q?AsFc4a+fMO7DQpzHK0niTAIUo9UnrJsBVm9QGYvtkl+O2uP6LALzIbnrANm4?=
 =?us-ascii?Q?uv9kRAlh8sxOQtj14jFdQmencwPlp8Kug6TsOPGvIxwfHT0rzPyVEhv8C5be?=
 =?us-ascii?Q?XDg3T/oCIfOmY4/kpTWhk1LbBjHyn+KRtqPwPz5crxojWwneDFF+IwJ1HNnD?=
 =?us-ascii?Q?kJwEx/NURZFQlPiiOli++2Vapzs1bR9XZrqlmkQF7wKgFZJPrda3mzM7Zybr?=
 =?us-ascii?Q?rkLDYDM2a3KZ3XpN3ckWR6WrGl40J7l0JfpQZOwpYvUUkDPTQa+/11PUfEDR?=
 =?us-ascii?Q?1+rL3USNh1AqiTR9EqcYGCRQ4GoWcfrv6xD4sma9dhKcDG4FMPTBOzXX0AAh?=
 =?us-ascii?Q?UTfHSmkib8avYUZlqOOFmsdRI9noPC/5FqIz1tmH5Hg4312Iti4zb0k4Lo7K?=
 =?us-ascii?Q?uaGibV8jbczRf+7q8irzMDirpK5yjTCUMSeLVNDpuHKErT1eOVfA+EIJQR6Q?=
 =?us-ascii?Q?KJ4aXsY5+FWHHeDpjlJ8MH0v4778ozUUcaKFkYulOEjyTY/DSN6nu1bfctwb?=
 =?us-ascii?Q?PH7SY+o/ivr8Elb2QM/drOOXEookfWbn0VjNr/K9nLC1My9HJ9sNYE5ZZyCy?=
 =?us-ascii?Q?DntDNO1ILdH/R01F01hDcMQHNDIsxmolQQh7cSv3y2D4PpuDh9GfEXxA0ciC?=
 =?us-ascii?Q?03Iq+p8m0Frx1u6+jgowY8BxFL9IHVTbboCuCLdkfB528D5HyTXhAf8v+XuN?=
 =?us-ascii?Q?hSz5LMzXVlBQUGuxHlnHnxWizectoho1wYni8my+Aw8zFM4JwWZxnEosogum?=
 =?us-ascii?Q?GdzfrwpU4f+XfR9G/yLyg/A4rpwJwg3iIDJd0eXDFvAtcqn8cDLGQ2DPK9nv?=
 =?us-ascii?Q?bZUaTzDtJ96+3wYt1H37DpQk0ej6W+Ju/5pohkH+2kX+B745DxhXpLkqESbT?=
 =?us-ascii?Q?56fJlgX+WI9XYgCO/vaGJsyFSPmzzmlzQucGyYZOfCjgepNu8hLWqnuuJmNk?=
 =?us-ascii?Q?PWIweJJ0kVqyA3aWxQ2tO0RH7eZPt5KDc1AMWGqpcbPurXd8tWUOcR9iLV/f?=
 =?us-ascii?Q?8F/qyAdvbn/gG+olnOE18oubU4uCat0wgT8FOAdQXbpaL9BeU++GIq42QnvG?=
 =?us-ascii?Q?i46026bvVUVXz0JqLW7MjVv9MNGyI7HAjbKZcMbGVbC2IcTI2Ix8Py57Gjr6?=
 =?us-ascii?Q?LYOYQucXi3I4+251pLwcROupwKXxUVkoL0C2ziX/kctlJWbYltDBaC6xFJQm?=
 =?us-ascii?Q?ajM6hhakdPugZ3HSNyvvEl6kePtrM10nD+AeT+TH+ktYDtXvvLN4HNaxCRC4?=
 =?us-ascii?Q?vZAL9ZbK2RdmfFrHw6LVtRQQK4Ayhy58pbz2X8+8wl5vP9HalI5XYtV6nZjv?=
 =?us-ascii?Q?uh8nwMQeptqq6fGF+lYmnWWZtXOomzV20B8j?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 20:50:06.8879 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a1f0b1-ab26-4148-d6aa-08dd8cdf9577
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF351A22FF6
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

If there is a problem requiring a reset of the VCN engine, it is better to
reset the VCN engine rather than the entire GPU.

Add a reset callback for the ring which will stop and start VCN if an
issue happens.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 1f777c125b00..8fff470bce87 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -239,9 +239,9 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 			adev->vcn.inst[i].pause_dpg_mode = vcn_v4_0_pause_dpg_mode;
 	}
 
-	/* TODO: Add queue reset mask when FW fully supports it */
 	adev->vcn.supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
+	adev->vcn.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 
 	if (amdgpu_sriov_vf(adev)) {
 		r = amdgpu_virt_alloc_mm_table(adev);
@@ -1947,6 +1947,20 @@ static int vcn_v4_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
 	return 0;
 }
 
+static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
+
+	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
+		return -EOPNOTSUPP;
+
+	vcn_v4_0_stop(vinst);
+	vcn_v4_0_start(vinst);
+
+	return amdgpu_ring_test_helper(ring);
+}
+
 static struct amdgpu_ring_funcs vcn_v4_0_unified_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
@@ -1976,6 +1990,7 @@ static struct amdgpu_ring_funcs vcn_v4_0_unified_ring_vm_funcs = {
 	.emit_wreg = vcn_v2_0_enc_ring_emit_wreg,
 	.emit_reg_wait = vcn_v2_0_enc_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = vcn_v4_0_ring_reset,
 };
 
 /**
-- 
2.49.0

