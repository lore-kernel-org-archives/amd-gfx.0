Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E295C021AA
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2025 23:13:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5013810E156;
	Tue, 18 Feb 2025 23:13:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g78+UAI1";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6C5E10E156
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 23:13:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJTwIrkhHUIN8eG659FrA7ms7gcaPRzM2p2fuVm+CXll6Sxcrr11EjiP9ONQJw1N1Ait7Xon1p4UfvX6vHsGfP32DwbcaldbY+crnE2IvtkFHlSl5+C8xo9HKcnfBbytjxa9dvjYELkmB+t337NO8iwR4AxwNa+VB+G4Cm+o2fK+z/vmeRGsWEk1RfeFgNcwOqiw2w2u4HMzSOKEF/h+q4jxR68uJNA6/yeOqAoMyBFrKyH2ML68Np2EeVfT0lWt4Pq/zK0x1gWd+SKji2Yj03v2YvjW9BWq1XrqgcfAdeY9OJgtWV8X+d1bFA1E4GJA6qebbrtUjD0PbzUlMxJ7dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9g1QtY5GNu5ASbXZJfzB8YQHlfrZEZ+vyNsJvv6nJbQ=;
 b=XGDIMrEbEQMp1Ib6RrIwiLrOElN6CtZT9T9p+qWjZqEGEGnqb5eKjyPPPtI3ywCaxAWaX+AD4dmyn76pj071VmE7HuhiT/8q0QeU7ciDoVDxwL/7AKFDIGWqPqF3verr06p//YK6MUl1omColAqt3bc3gWyR325hfgu90FY+e42kpGTEe9n6kiCUMa/L/poozJyCrKUQzfpUC8A904nOGwWFSuIv5X6XUwnGJRjGtNoSsJo2DjLYtfW/OoS2ggfDR0sNQhXDiI0L2VoeHftvZ35FBeCJM4r9vOUuklQzEToqBdh45A8Ok9orSRGmhaFX+xF2cUeDtj37CSeY52chiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9g1QtY5GNu5ASbXZJfzB8YQHlfrZEZ+vyNsJvv6nJbQ=;
 b=g78+UAI1ECymdcy+MnasPvkKNGxDVCFu79MvxjKFGPFgAnrO+qoim+gR+rGFcEpqnBJUkyN1Q/sMhr5a8qvTfi5WsKGPd3mgi9d63PpR61saeyjYDW6TlE/RTrHYvl+UCQ+y43OMUgd0tzLvNup3rH49QaOT0lNZSu9YhmEAljE=
Received: from MN0P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::6)
 by MN0PR12MB6343.namprd12.prod.outlook.com (2603:10b6:208:3c0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Tue, 18 Feb
 2025 23:13:35 +0000
Received: from BN3PEPF0000B36E.namprd21.prod.outlook.com
 (2603:10b6:208:52a:cafe::fd) by MN0P221CA0003.outlook.office365.com
 (2603:10b6:208:52a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.19 via Frontend Transport; Tue,
 18 Feb 2025 23:13:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36E.mail.protection.outlook.com (10.167.243.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.2 via Frontend Transport; Tue, 18 Feb 2025 23:13:34 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 17:13:34 -0600
From: David Yat Sin <David.YatSin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <harish.kasiviswanathan@amd.com>, <jay.cornwall@amd.com>,
 <philip.yang@amd.com>, David Yat Sin <David.YatSin@amd.com>
Subject: [PATCH v2] drm/amdkfd: Preserve cp_hqd_pq_control on update_mqd
Date: Tue, 18 Feb 2025 23:13:22 +0000
Message-ID: <20250218231322.420275-1-David.YatSin@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36E:EE_|MN0PR12MB6343:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bb89571-58ea-4324-1b81-08dd5071de4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6PqPEWem3Igfw1Vk0IpHJhkl7ZHknylnsopkt5JEdICiZ9534QBloDPwj7wk?=
 =?us-ascii?Q?t3kDNiUy72NN4bCEHZcjDlueg+hCOKmRCI6tV5O6n2Q3Z/Ux7DqGFchQnFDE?=
 =?us-ascii?Q?yVaNoZ8uf3PI/AeEawYDW+2Xb16FWeyXpna02UpZind0qmB0HQqDnLAogt0m?=
 =?us-ascii?Q?/ntQpiNRgRasN7PoTjh/5PTaD76tjH7SeIqOThUmISibEVC3cmNDoV+GtLlv?=
 =?us-ascii?Q?R/P+xpd9u6i5+ss+ke9E5B3kchFbLyfMyL9Y37uCrG5aN4sI/T6Aho0emh3O?=
 =?us-ascii?Q?mRL5POpWdu/M02L+9nEawqUyEL8dskFjcbpOXpeN6cTugNNj5pHFXfbTFNj2?=
 =?us-ascii?Q?tqR4GF6EjcrvOcCyIZBdDM3RK9uzl75xNDlTI7GkPB396LfJwvIOXCfM3nui?=
 =?us-ascii?Q?g2t9NK9NbLDQb+a6xHmLOm2bWqcpYNlDNlvkfEWHtJQ1pvBWAfAVIRpM23f1?=
 =?us-ascii?Q?iD5ix5v7vKviTGsTLlLD1hUOX/KGZhANppw18Niujg8VcHwLezuNrukzjLab?=
 =?us-ascii?Q?AfxyJnthIZ6EPlMP8YHNN+CTc3J8UyoCDcP3OUGTbFQGPmfOdStU7O001ssr?=
 =?us-ascii?Q?zgk7pFnjwUk4aCHktlv1Onjmq2damuCyzgiT7sdyJ+Nlc00G8nXDanq8L8MJ?=
 =?us-ascii?Q?XXIUkQg/5Ns0ymOn/+XhL2ZHmKJfRhUsgSC2fNxqMq8m6bCis9BA76GZLMEx?=
 =?us-ascii?Q?0GyZbq0DT6CZxKDt8x6ub+26I3uttIpmv3UpSGWIo9L0eTyw1L+wpLfhSfXy?=
 =?us-ascii?Q?20SAA6Xhnfjw8ohhkd0/Ub2kr4ycK4ER4neDcio4T4lnDoGszxl6OobguuaW?=
 =?us-ascii?Q?CSfqsOoKCU6OTDJ1JjJFWJv2Z7HcUGSQIwzU2bcaMIiIA/6ZPGotBBdq2Dnj?=
 =?us-ascii?Q?1K+fA6qGufDf20PVDKOyJBzqyXdbfHK7MauAiXJF7q5S4x0lBuSdwtjT3Xet?=
 =?us-ascii?Q?STwP3X0pWJ/zKxYLhw9DNBGWsa+6rhuy15RB4uAAK/iBcAlH4T5O9vyq4S9o?=
 =?us-ascii?Q?slmu9lzFTiLmWc1Nfuun91pnWlzUE7KqmwejF/Wnw2GNdibWT9n4jpQCTLlV?=
 =?us-ascii?Q?vf+mJrJf3XkWIy42mhl4KbwTgKQg279Kswq2henQSX+PClolN2zjZROrug7b?=
 =?us-ascii?Q?1XAnD569dcT1cZWq+Vs9jDQmop9ueA7CT9jkjgi42YjTPi9ruPMFuskOPAYx?=
 =?us-ascii?Q?NfDVPIsKCLsYgeN2rBSRouJAYJLWDNHtq6ntrsKJsuBCk2WTpRlDu+KfXJON?=
 =?us-ascii?Q?p8crxCwc3yHf8bN5qQgFW2qUoSiOg9M0lvcOy2KKhUlQpkmRjnuWIKAMYC8a?=
 =?us-ascii?Q?8dpq5MXFjXBFFeuaD8XK1UhHEOmTzDKlTy/StBga0tpdtR/KjO4Cv3Tavy8O?=
 =?us-ascii?Q?cx25doFxWZ47j9SvhzwNZxkw/hfRpgHwA1u1q6Uq93NuS31OVDXORyyGzBYQ?=
 =?us-ascii?Q?NeGe7h7u0tgtaRYjmp2Ycw2I+C/k1C2G4MXJbLB1Ygi9wwE1HFmatHNdcYKf?=
 =?us-ascii?Q?kzoM3ihGvOeBir8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 23:13:34.7131 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb89571-58ea-4324-1b81-08dd5071de4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6343
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

When userspace applications call AMDKFD_IOC_UPDATE_QUEUE. Preserve
bitfields that do not need to be modified as they contain flags to
track queue states that are used by CP FW.

Signed-off-by: David Yat Sin <David.YatSin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c | 4 +++-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c  | 3 ++-
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
index 2eff37aaf827..f28358ba1703 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
@@ -107,6 +107,7 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
 	m->cp_hqd_persistent_state = CP_HQD_PERSISTENT_STATE__PRELOAD_REQ_MASK |
 			0x53 << CP_HQD_PERSISTENT_STATE__PRELOAD_SIZE__SHIFT;
 
+	m->cp_hqd_pq_control = 5 << CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE__SHIFT;
 	m->cp_mqd_control = 1 << CP_MQD_CONTROL__PRIV_STATE__SHIFT;
 
 	m->cp_mqd_base_addr_lo        = lower_32_bits(addr);
@@ -167,7 +168,7 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 
 	m = get_mqd(mqd);
 
-	m->cp_hqd_pq_control = 5 << CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE__SHIFT;
+	m->cp_hqd_pq_control &= ~CP_HQD_PQ_CONTROL__QUEUE_SIZE_MASK;
 	m->cp_hqd_pq_control |=
 			ffs(q->queue_size / sizeof(unsigned int)) - 1 - 1;
 	m->cp_hqd_pq_control |= CP_HQD_PQ_CONTROL__UNORD_DISPATCH_MASK;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
index 68dbc0399c87..13511bf4db02 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
@@ -154,6 +154,7 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
 	m->cp_hqd_persistent_state = CP_HQD_PERSISTENT_STATE__PRELOAD_REQ_MASK |
 			0x55 << CP_HQD_PERSISTENT_STATE__PRELOAD_SIZE__SHIFT;
 
+	m->cp_hqd_pq_control = 5 << CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE__SHIFT;
 	m->cp_mqd_control = 1 << CP_MQD_CONTROL__PRIV_STATE__SHIFT;
 
 	m->cp_mqd_base_addr_lo        = lower_32_bits(addr);
@@ -221,7 +222,7 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 
 	m = get_mqd(mqd);
 
-	m->cp_hqd_pq_control = 5 << CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE__SHIFT;
+	m->cp_hqd_pq_control &= ~CP_HQD_PQ_CONTROL__QUEUE_SIZE_MASK;
 	m->cp_hqd_pq_control |=
 			ffs(q->queue_size / sizeof(unsigned int)) - 1 - 1;
 	m->cp_hqd_pq_control |= CP_HQD_PQ_CONTROL__UNORD_DISPATCH_MASK;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
index 2b72d5b4949b..eb63fafead80 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
@@ -121,8 +121,10 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
 	m->cp_hqd_persistent_state = CP_HQD_PERSISTENT_STATE__PRELOAD_REQ_MASK |
 			0x55 << CP_HQD_PERSISTENT_STATE__PRELOAD_SIZE__SHIFT;
 
+	m->cp_hqd_pq_control = 5 << CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE__SHIFT;
 	m->cp_mqd_control = 1 << CP_MQD_CONTROL__PRIV_STATE__SHIFT;
 
+
 	m->cp_mqd_base_addr_lo        = lower_32_bits(addr);
 	m->cp_mqd_base_addr_hi        = upper_32_bits(addr);
 
@@ -184,7 +186,7 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 
 	m = get_mqd(mqd);
 
-	m->cp_hqd_pq_control = 5 << CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE__SHIFT;
+	m->cp_hqd_pq_control &= ~CP_HQD_PQ_CONTROL__QUEUE_SIZE_MASK;
 	m->cp_hqd_pq_control |=
 			ffs(q->queue_size / sizeof(unsigned int)) - 1 - 1;
 	m->cp_hqd_pq_control |= CP_HQD_PQ_CONTROL__UNORD_DISPATCH_MASK;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index ff417d5361c4..33de399f2f7e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -183,6 +183,7 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
 	m->cp_hqd_persistent_state = CP_HQD_PERSISTENT_STATE__PRELOAD_REQ_MASK |
 			0x53 << CP_HQD_PERSISTENT_STATE__PRELOAD_SIZE__SHIFT;
 
+	m->cp_hqd_pq_control = 5 << CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE__SHIFT;
 	m->cp_mqd_control = 1 << CP_MQD_CONTROL__PRIV_STATE__SHIFT;
 
 	m->cp_mqd_base_addr_lo        = lower_32_bits(addr);
@@ -245,7 +246,7 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 
 	m = get_mqd(mqd);
 
-	m->cp_hqd_pq_control = 5 << CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE__SHIFT;
+	m->cp_hqd_pq_control &= ~CP_HQD_PQ_CONTROL__QUEUE_SIZE_MASK;
 	m->cp_hqd_pq_control |= order_base_2(q->queue_size / 4) - 1;
 	pr_debug("cp_hqd_pq_control 0x%x\n", m->cp_hqd_pq_control);
 
-- 
2.17.1

