Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE1A8CA100F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Sep 2025 21:33:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2925210E06A;
	Mon, 22 Sep 2025 21:33:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jjhdQgT/";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012032.outbound.protection.outlook.com
 [40.107.200.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A00A910E06A
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Sep 2025 21:33:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8QHJAuYL+5fT8/8iQtk8TxBywdtIIpeRmrriVF7u8CRjTlxawsrTItl6DPYxkheYdq8F+rmcqEqeEKVs07AeMF1SMoeIaDvdetnm4/4HeVoGgtbtls1fv+myah9FXFA/zrGnKM55G0u5rvPGzfhIe1L5x93UFE68FYyr7SFem0nsohqmZ410R83D2NPJWjMFD1Lt6nuGU/uS5KRIdpk7qx36NvRUok9At+WqfY8PXtl2Be3nFVc1v9NjeAhq5ikDryqElr360PX7Jg/cYSBdmKPI+u+/Sw1J2r/PCDRRyDjYAM8woDNjCX3paj8Yl75YWu1+dmnZSltBErjs21dGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCMPJT3Dg2TZZtAinvefXPuXXCpIbpwd2/smRFWYkCU=;
 b=wx6KmeoApTbWZ7l8rufhtrmIEDgPeW2dtwiMZo+ZU0AwX+YB5qZovns0WTyTcOEFvDLl3YLOJ9CgIaMr/v5rWICoJRPR5aGgjzHIf4hsdUdXEYR2xXHrjvIc98STiSarbN4/9iXIU599r/PNoaVInH9E2edhjXoPDR/R3sU6zP4sW5CIMhpxdPmHnjizLgMXHjPUYKjbMmDGPfiDNerT6YDmYMfmi+7pycJIagqZnkJ7GsG7wrOE6GLscQY6kK0dwLgCfFYQT/5A0UTtoIaU/D6YfJY4/fxcKVOhVynZUCFENO34ayKR6HQUqS/4SW5aTMNbOu5zSQEgRVjBhtmouQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCMPJT3Dg2TZZtAinvefXPuXXCpIbpwd2/smRFWYkCU=;
 b=jjhdQgT/stoBErUP++p5ZfBUrEEahqVWJmHHJA7s5w1n07KIbIfYadjL33KxofBws+8UnsDITnA+KuSwjW2nzYkB+zdyNjJ0kSdg4G3MkM+IMDpOv4s7rp/VnEHKqix3aYNzDLbQazfppeZ1AlWC5tcXqWjzTHB72reUkhv+Gz4=
Received: from MW3PR06CA0027.namprd06.prod.outlook.com (2603:10b6:303:2a::32)
 by SA1PR12MB8985.namprd12.prod.outlook.com (2603:10b6:806:377::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 21:33:28 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:303:2a:cafe::c3) by MW3PR06CA0027.outlook.office365.com
 (2603:10b6:303:2a::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.19 via Frontend Transport; Mon,
 22 Sep 2025 21:33:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 22 Sep 2025 21:33:26 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 22 Sep
 2025 14:33:25 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: handle wrap around in reemit handling
Date: Mon, 22 Sep 2025 17:33:03 -0400
Message-ID: <20250922213305.3661288-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|SA1PR12MB8985:EE_
X-MS-Office365-Filtering-Correlation-Id: dbea22f7-7357-4361-96ed-08ddfa1faa54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NXg+anWIBr2UVYALZZYzaKwVY7AcZPlueeJjipX+uViVWRPpeCUVTxBY3Mw0?=
 =?us-ascii?Q?KDz8+raF7EvrErCl0SxzYneCNTqvazwZPcHZv6HqHKzfe0Oqj0nc2/JktWBR?=
 =?us-ascii?Q?oufu146ObQp2smIJ+x5XiHol7R2QR0AKqSbZW9iuuBe3zecAQsWnn1xyqTBH?=
 =?us-ascii?Q?CvzSv3O41Gi7yKtbOPW+AG3sgCphd4amN15dAdBl1DiJqnRwIYhgHAGahS63?=
 =?us-ascii?Q?ao8Z6CGCfW0N2B9qOAXPNNvCN1Yfz24cOpXWkrVMRW6V5QiJGwdz1c04Lkrn?=
 =?us-ascii?Q?nd/B41zp+KWmd6CZSIqFonU00CRJd2x+pxmda9IpTt8ek+QBMTQe2cyF+Hst?=
 =?us-ascii?Q?nEAnvcdKQ4nHqGV9mO9FELXroDTmuNNUUfikSs7f/hocj/9GoRx2P6V6KRPH?=
 =?us-ascii?Q?GwfWzK5R9GEGUADIA84ikGAFBtO3iODmTVJW8RTUjZ4qzzaNyqAi+cNwdT2q?=
 =?us-ascii?Q?kyBRWYw9VVkWkomunN5VMkNAD2VGlSL24Kd4Fm91eseszVifGiFm1Zp+YjD7?=
 =?us-ascii?Q?NByzXhSST0dNayIi7fdukJS+JdUPmkGpuKxDKT0Yng5cyiowgj5J7cZZ307d?=
 =?us-ascii?Q?XNA4+gmd80oh0VdC/dSK/SN5Qzt7DTTRPwfA9rAm+Pw2GPcCa7CKLevNC79X?=
 =?us-ascii?Q?1v8dO0b8Vmg4ZhbX/SBsiY16dRH/P8VRvdT4VrSjKBpEGzShntCJUg7lGzdW?=
 =?us-ascii?Q?rLpGri+EBEiBqSHGsaEbkTK7IQwLna1w58DHpixCzWxI3FuWNL1UvLwsXDh3?=
 =?us-ascii?Q?u7Mam2FD/g2gSJDxfvkq3+u4F8II8V5oB3am9kiv+H+ZCXuIpklmBxbnREYZ?=
 =?us-ascii?Q?c7yCjesZsuKlF9SX5bjvC1VibBXfRxRPLNTqeYuLPfPnaKYv1RbGEjrbZjjl?=
 =?us-ascii?Q?FqfPZ0LRbgbrKQTl3BwxzsMrAcs6ctKSHCB4Gv3qsyyDE1tTY97VNVclFpGI?=
 =?us-ascii?Q?ZnyqTvqRtV9nsDOsEN0ze3/H1GYujzjoL9197GA82GzA4l7ONf3EHw8ustOu?=
 =?us-ascii?Q?6BOHUv/cpcFSVoHdBFfO8hWgRB1dQ/DZEV7SWkXgDsZzTtQhT4wtPS2ALjVb?=
 =?us-ascii?Q?6YcNJz02EEsaDZALJJJmvonMDDIKt9mhVCe7TBU/mx3DnnpuVJBdA1X+wBeb?=
 =?us-ascii?Q?zRO0eSGdBY6BKILAWAPF10zi2JyVqLUebbDxmfv0jI2YUm5UTd22LwEF/1c6?=
 =?us-ascii?Q?cc5/eiWs2jZbVN/VDvCnFR1oJw+x1vuLTnAnFCpmVuXHkM/FE99/lHdz8lmF?=
 =?us-ascii?Q?Z/Mxn8zNJE0mpY94oDo+omZtae/gdzx6fPrEGedyd040g0s0g/fBrLn6FqtV?=
 =?us-ascii?Q?nRQAjfqdDeOUMOgqvmOat97oLOkOJz/gXMT0oh1kOULWtxn7ZutaCZtmD920?=
 =?us-ascii?Q?/FUyffWy8mfkRKsG8CeJpHEL0ltKo3amRZPsV+78foW26jaCLNlSpHVn1adi?=
 =?us-ascii?Q?VxZX7F28tpldzHzS9le2/Zneig/RDuLNRyaqY0utnpIvh1bCeV/BbZl1+tG1?=
 =?us-ascii?Q?p16JH6KdrwG2YaUVVFwiWYpq98VSVeWdlS9b?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 21:33:26.3735 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbea22f7-7357-4361-96ed-08ddfa1faa54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8985
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

Compare the sequence numbers directly.

Fixes: 77cc0da39c7c ("drm/amdgpu: track ring state associated with a fence")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index fd8cca241da62..e270df30c2790 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -790,14 +790,19 @@ void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
 	struct dma_fence *unprocessed;
 	struct dma_fence __rcu **ptr;
 	struct amdgpu_fence *fence;
-	u64 wptr, i, seqno;
+	u64 wptr;
+	u32 seq, last_seq;
 
-	seqno = amdgpu_fence_read(ring);
+	last_seq = amdgpu_fence_read(ring) & ring->fence_drv.num_fences_mask;
+	seq = ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mask;
 	wptr = ring->fence_drv.signalled_wptr;
 	ring->ring_backup_entries_to_copy = 0;
 
-	for (i = seqno + 1; i <= ring->fence_drv.sync_seq; ++i) {
-		ptr = &ring->fence_drv.fences[i & ring->fence_drv.num_fences_mask];
+	do {
+		last_seq++;
+		last_seq &= ring->fence_drv.num_fences_mask;
+
+		ptr = &ring->fence_drv.fences[last_seq];
 		rcu_read_lock();
 		unprocessed = rcu_dereference(*ptr);
 
@@ -813,7 +818,7 @@ void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
 			wptr = fence->wptr;
 		}
 		rcu_read_unlock();
-	}
+	} while (last_seq != seq);
 }
 
 /*
-- 
2.51.0

