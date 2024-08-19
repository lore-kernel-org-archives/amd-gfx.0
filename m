Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67366C3DA4A
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Aug 2024 03:50:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD47910E193;
	Mon, 19 Aug 2024 03:50:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xlmlViLq";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2050.outbound.protection.outlook.com [40.107.95.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8417910E193
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Aug 2024 03:50:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LuAEaW8AulKAO/hu2SxtearrHqvOo4SSG3goS9laTBe/LXMbzipSlS+mPURmlGUTpB8Zoc3ZYUzQSdSlEQIErSWZGd2oogYwrAYNZHwIs/BATva+bwRJmft9GBlN6YYj2pydwZkTcqqNdU0fBiL45QyzDtcXWXojstxVp5VDZBQfxsAHtRSNWHzbJH7YizQI5K/7PX+KNgnkv0cHYgs2fm7v928VQ80+rtq8gH4aTAZ1DEbSJmolpM5rvJjpby0lrFurovXfUIPuyqg5+tO85Y1brXE9C4icKYgisUJWumU2a46oIVLrouv0J/Bp5gecrDJ6/z+afahygMb2ooOegQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJuCOwztPSPpSJ6QmFRwSi+LAOjrGdCLjhKY9CgjpJE=;
 b=GchNpIBemsbvApeq9cMkOPGLfdb+wXVe5shv8v1P3vJdAJ/TOu4/WBg1YYpvW5O+hhu48fuiBBSt01PIVZ8I9ZHZA8vfmyqe5TyyPyfCn7YriF+blVq1hdRfplxM0W1JqGxZzftdiWEl88gYneKea7y/+DIae/XH6Rl6bPYUbuu7rHokLridqtg4dSACgkW2OLxXUb/PToFzbJIbHU9db68+cVd53t+tw86rAdMFo+eAvMHphU2/Ckw2Nd/sHVbe4Vl+R7YrWgZ6WRcmS2VTx1R8cwKpL7DZHK3LmsXl5iUR/mbLz62X9YGm35RTwgQdzjX9r1Uhk/vg2zsgex20CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJuCOwztPSPpSJ6QmFRwSi+LAOjrGdCLjhKY9CgjpJE=;
 b=xlmlViLqN86+C5uMHmzwKvjl34N1amp9aE4FBVbc8lO1eyH3hqdmwnlLC4h+ob1fB+vds7Gdl0MbOBgYe2+lHp4gGi7DLA+qmawVLdCTDJB68MoMDfd58VRtyBeHY9G4gdW3AhgdCFJFALoX9vRlJQwUu86jTPmRaUq6T9P9TF8=
Received: from BL0PR02CA0082.namprd02.prod.outlook.com (2603:10b6:208:51::23)
 by MW4PR12MB6923.namprd12.prod.outlook.com (2603:10b6:303:208::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 03:50:03 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:208:51:cafe::44) by BL0PR02CA0082.outlook.office365.com
 (2603:10b6:208:51::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Mon, 19 Aug 2024 03:50:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Mon, 19 Aug 2024 03:50:02 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 18 Aug
 2024 22:50:01 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 18 Aug
 2024 22:49:51 -0500
Received: from victor-x86-02.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 18 Aug 2024 22:49:50 -0500
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Emily.Deng@amd.com>, Victor Zhao <Victor.Zhao@amd.com>
Subject: [PATCH] drm/amd/amdgpu: allow use kiq to do hdp flush under sriov
Date: Mon, 19 Aug 2024 11:49:37 +0800
Message-ID: <20240819034937.1181639-1-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Victor.Zhao@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|MW4PR12MB6923:EE_
X-MS-Office365-Filtering-Correlation-Id: e10ed56e-94b1-485d-6af9-08dcc0020168
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LoaviqblE3x8GaAkgV0vrinaTdS/z2+OroOIsU0KU2VvTSXt1a1cASnSQBR1?=
 =?us-ascii?Q?yjHsMMWtfsYcX9WvhRoRvgNYmNv9FJCsXl6WFVqRxNDvD6Cw+9B0czStaTMX?=
 =?us-ascii?Q?QiMdCuKOdili0Udoy3ppeiz0efAyAso6Gadas41EzObLWAg97oKrTsCj3Wjv?=
 =?us-ascii?Q?SwSgdanVTU2g6kFvCVygkwlQLDKe2BzBjC/VVK6USsymf27n90/NZxuDxfV5?=
 =?us-ascii?Q?JMZfwC+VJUtWyc1Ig8892TRjDyW7eQois2YIyXkJHJ0GxvB+lXj0ipE4nAfT?=
 =?us-ascii?Q?1rB9oF4ivGXN0MFsa1LDPYT4J9er47XenGuDzuCCDA/c33aUYlKwho5o69Fv?=
 =?us-ascii?Q?J21zA1QkTo5RiMHn7Fv7Vch7YYoU3sQIdzB0M0ZR34gCzSrJ9uI2zAb+EZYU?=
 =?us-ascii?Q?3AvO7Hi+Qjd9G7xOlHajLpsWAY3zVPQ0eW5TrpsxIjWbMRbsrDY6wKqFgEKd?=
 =?us-ascii?Q?5RqOxgE0XD0naU2prAZShDSuU6Qu+OGc+Bp9VSn0fsRG4U5SRuC7lFwWXQwu?=
 =?us-ascii?Q?xUREWRQN5UfL7yyAjUOwOAQKCpjFeoPzeWHZqWTuDnjgksoiVhFlOjGbXhf9?=
 =?us-ascii?Q?OkscXWJj+e5gI73AG4KaDC2Dt7P2XiLm8Jm1Y3Im/GaxM94wbA8QceSPwUCD?=
 =?us-ascii?Q?oFRtHvfriXx0OPR37O/+BiCF4hqNDEROfi5tljULj+Tkb0peLhzOwDfeywaU?=
 =?us-ascii?Q?s0/EAzEOGQE5xbg8uP/pAj9AAktsShKjsnu/op6E6bKVqIF/bucWJCkWI8v+?=
 =?us-ascii?Q?w89R66fMTrEI/CxwGfd7rDxSQBSCBm1rKDBMiYofntJdWa+jIFGQvlztkuBi?=
 =?us-ascii?Q?X0EWVUkF0PF8h+uC2g+LwIU13NvaTQ+m2IxevHUjNpAF5xqKafmz0X67g86x?=
 =?us-ascii?Q?+aaOvoiMBl/Mkxyr72wEcrrj4+hu/npD/dnTuVEbk03+6bvOo5GyEbo81MQR?=
 =?us-ascii?Q?KMQhrvSh0MbLkLRFwYqY0OFCkPvAHIdft955JwxtR0sLIpW7G2VlQmCGSIbe?=
 =?us-ascii?Q?4DPzah/Ans9kSdbj+jqFQPTOoeUi+ZDtwsnlgNDcwtkTJcXOaNUf71Z+lHf5?=
 =?us-ascii?Q?+ky/gAKuNjBZNPH0Yl5Tw//NMvvxB/oRWa3qXNmlDL5SsmO4m66RwUy/I69i?=
 =?us-ascii?Q?m7rXtQsLMDzmHxzpz+ltSEpXb3fRNVUimNJkrQ+Z7mEuFBQpMnQlTBbdXD92?=
 =?us-ascii?Q?/UkUvsyJ4y4KRm5o6+9AI7bdyMMi7F8tqiMzuh6m2I1Wy73shMqA6P7+kkqa?=
 =?us-ascii?Q?69PV/NGZPU/sEg+Q/lnfdSC/WEEbFal9gC8F1GrwP120AUaHnvHp/ToYH53n?=
 =?us-ascii?Q?Z8XaixhHvOtcG+IwgoqHkWrSuw6UDxcR7Wbfwj0rkiu6Ia3/bJSHE+lMwUcP?=
 =?us-ascii?Q?DSnBLcPGouA+YyEMy+SASq8MKFnd+ZcPYhNxznn84JjZ5jWrStVyGHeOdja5?=
 =?us-ascii?Q?Bk2TBvQ7bxh1N6epz/pyhFQqCsI1wAWV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 03:50:02.5230 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e10ed56e-94b1-485d-6af9-08dcc0020168
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6923
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

when use cpu to do page table update under sriov runtime, since mmio
access is blocked, kiq has to be used to flush hdp.

change WREG32_NO_KIQ to WREG32 to allow kiq.

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
index 077c6d920e27..e019249883fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
@@ -41,7 +41,7 @@ static void hdp_v4_0_flush_hdp(struct amdgpu_device *adev,
 				struct amdgpu_ring *ring)
 {
 	if (!ring || !ring->funcs->emit_wreg)
-		WREG32_NO_KIQ((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
+		WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
 	else
 		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
index a9ea23fa0def..ed7facacf2fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
@@ -32,7 +32,7 @@ static void hdp_v5_0_flush_hdp(struct amdgpu_device *adev,
 				struct amdgpu_ring *ring)
 {
 	if (!ring || !ring->funcs->emit_wreg)
-		WREG32_NO_KIQ((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
+		WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
 	else
 		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
index ab06c2b4b20b..33736d361dd0 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
@@ -35,7 +35,7 @@ static void hdp_v6_0_flush_hdp(struct amdgpu_device *adev,
 				struct amdgpu_ring *ring)
 {
 	if (!ring || !ring->funcs->emit_wreg)
-		WREG32_NO_KIQ((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
+		WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
 	else
 		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
index 8d7d0813e331..1c99bb09e2a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
@@ -32,7 +32,7 @@ static void hdp_v7_0_flush_hdp(struct amdgpu_device *adev,
 				struct amdgpu_ring *ring)
 {
 	if (!ring || !ring->funcs->emit_wreg)
-		WREG32_NO_KIQ((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
+		WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
 	else
 		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
 }
-- 
2.34.1

