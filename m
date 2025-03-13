Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9518DC28B28
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Mar 2025 03:28:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 394BE10E1AC;
	Thu, 13 Mar 2025 03:28:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NHFX34b5";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB0D910E1AC
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Mar 2025 03:28:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dZQkSawtL5XLgWJO7HNXBgKxGDWwCYlWs7gyD3o6SADjEmjgFyO3PRU7K0mUxQyeBXpjTdgeVROixlQltgDPMqmN7fMAksSsrBaaIlrCw8EVjokQbVYP9X0iVUnHqzKEK7sif+h8HclvU6KdYxWUrXLWLLROxePxrYmH+Kl3orT6AQndFU+jOpbX0JF8aTNE4EYmKKufgJBeKyzY7kdS3W8kIO6jedQYqlQ6Xd9PmUAE7eq4nQi3yNkppPabfz1eO2cmfWRJ/dZhkC8fnGKWGyFHaZlJK5AKXdIIFiRBzsvKQPciQkTNJIXfWPhK3NP69OVznlVd5spJxHynYcauGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bK4pgNc8OeFCdQcgvzjqBacm+couQM9mBiXXgZpmDN8=;
 b=k0A5ZzdnDzTGmPEYWGhJSkUmlB+O7VuoGE47ui43cASOEprSn6t56PJtNNyjYKs7XsyFY1g20RqQwPdh3Y1/4JZ8ur5ns0drf1+NGxkCDvChHvQIuWuJ40JF6kVr84gWyVVUS09Na8rBfEPWBK3jJpsh40NBvmmaj6ID/mSXz+x8YYvl3GmldQ/IScRHa7raXffjV4nfmG6CdLG5UqxGz0ZdhMma0kcc9/jlbJLqz/xv0SkwUCtRRQWMIYXEzvHP7W8W1bFL3d6eNY3eKQZNCJnrWmoOo21CKUYNih0E8e10xG+S0ub8aYwl5/HEbpQQmgd1Ha0VAcOi1VoEKybpEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bK4pgNc8OeFCdQcgvzjqBacm+couQM9mBiXXgZpmDN8=;
 b=NHFX34b5ZH0VEuXDhhi9D08Jy9ZE9C1w7euqqXq3VvlDkMxiuxEdOsodrPvNLbLjo0RZUriYvETH/DD8D57HIE4cBGb+9/rK+STVPDSD9/S6ZOofUGy94u6OJ76zKbC97Q8oyenuxLMaYgtLinQsEoMRQlDtOxiV1rqCa/3+kIM=
Received: from BY5PR04CA0002.namprd04.prod.outlook.com (2603:10b6:a03:1d0::12)
 by DS0PR12MB6656.namprd12.prod.outlook.com (2603:10b6:8:d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 03:28:12 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::da) by BY5PR04CA0002.outlook.office365.com
 (2603:10b6:a03:1d0::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.26 via Frontend Transport; Thu,
 13 Mar 2025 03:28:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 13 Mar 2025 03:28:11 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Mar
 2025 22:28:09 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH] drm/amdgpu: Fix computation for remain size of CPER ring
Date: Thu, 13 Mar 2025 11:27:38 +0800
Message-ID: <20250313032738.428588-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|DS0PR12MB6656:EE_
X-MS-Office365-Filtering-Correlation-Id: 9724d98b-077d-4e39-8509-08dd61df150f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zd9xEJ5tS00m+YSByXu8NsnwZtlzMhif7/WcqzxzAHbNh2/zsgesGV6MO0Ju?=
 =?us-ascii?Q?WNYLlYBdqRlTnETgYQZd4QK5uqV+WplWSHz0mrno9l6op+GSzVDgDuVTyWfi?=
 =?us-ascii?Q?i/GpGclo83LaHZIaIxSR76hzGurGFj8nQjRHjYyf3F84v4e6xbIqrG6qb1a8?=
 =?us-ascii?Q?DLXpKfhJNNx+ipG0vd5L+/3vGzdGlxNvq/ijQaIeJqRfv2KvvA1cB6CR72kp?=
 =?us-ascii?Q?Wms/9tC/ILZ54MMHEwy678J8UApB4I6mnPzE9n8Mlyz+cVMczbfGhApu/AWC?=
 =?us-ascii?Q?eHWzX5G+Aq6TWXyUq7UoyOCQyDOvhgewX2Aq1b03v2KHflR2bdbiRyBdEK7P?=
 =?us-ascii?Q?HuaOQoUq+cK1vbPM9uWTXgVdD/QJUbRocv67iFCznnmzY6OJzIW88tZK0X5L?=
 =?us-ascii?Q?mDfCNvnFgI3f1YMyKqiSHbEhuG2KaH/C+/4x2hfdTE8aMSMjxPbm2sE965bh?=
 =?us-ascii?Q?ipTgyOG11DB/NsCF+tyVzOLx5jhre6PfMwgYNLtAh6dy8XsvG5AWBwTbHflv?=
 =?us-ascii?Q?rIpgfdtXoRQErTVGSp5Wj+GQcezjRSU9yHfFBzF3ep96/vzZB6Z3vQ7QNLgf?=
 =?us-ascii?Q?1sAGjqDt0qDREiWzyqLJalSHguEInOLOs1rVBOi+z2hSio4TZrG/z8qdHi1+?=
 =?us-ascii?Q?2pUvu2FCt1nCxNBQM3bIRQDYTHAR6nHmiTPjOkCGoIuVsRUqfgdVQE7KB2rI?=
 =?us-ascii?Q?m63s0Ymk7hRu4a8Ffhb7l3ttH/io1g4H48FQRuKsqFTELHxvFTalyx6ZUs/H?=
 =?us-ascii?Q?uTI9vfGiV3c19Gh/KKyHaf10IFHPt6xLxusAhQJW/v1g1PidIMRrJaV+LeC1?=
 =?us-ascii?Q?u/mHe/KfxYygdklAsy/SPij8/JZxiK4YLb0qHFkgcxt/E3ZPaHNhKhFJcEHz?=
 =?us-ascii?Q?Vl5O0Ia8e5DEQngfePU7pT0h8MiBrLxUrXPttsK9iUsxshICFVPMqqIzxzZV?=
 =?us-ascii?Q?XsWHwUdrdsXCJCLJ2pZKB8qcUOwV1MMhwEhWwY1T1LWiFXSjWafnMmUuEdJJ?=
 =?us-ascii?Q?X9U3wf+3+CY5sezG1gf5sZuMCWgbZE0+FUKa4C/g4QLGcjEz1AzgnoUW9rtx?=
 =?us-ascii?Q?UCh2uw1JuVKVKSGP1kts22SYTtsyzNue2bUn/3wzzQ5xqFtXYy8ks7lKKtUE?=
 =?us-ascii?Q?N35NKQiVEIINo1WfxGexDKtQ+ZSnMMdsu2NmE853IqRyPe/Yuk8s4jNbC36T?=
 =?us-ascii?Q?8z4ip9w0o/qCgTnMOmzs90EZ0GRSB/nvmU2+PJsJxLvruf4VjQ6Oodj5g1rC?=
 =?us-ascii?Q?sXjtr75cj6i+r0bZX4v2y2g4m2B9y5nU+M+iVD+SQMOXlOTlJDL8k8J+D8rS?=
 =?us-ascii?Q?WpoxgCPvOCW5fdKa0jrWXoAcYmy0uMfgn7KlLtgzdgX/JodnGo6+sfy0LzJM?=
 =?us-ascii?Q?kNaOSyfZbx7+gngXbzYH7eRr67Re2zlUWyEuOMXwUiGE2SdRsEJMcQbJAuPA?=
 =?us-ascii?Q?/sJxiKADnJLOdT1z+cn3THUmCyzA/u3xaDPtS/TCfBWML2X2DgEgew=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 03:28:11.4167 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9724d98b-077d-4e39-8509-08dd61df150f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6656
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

The mistake of computation for remain size of CPER ring will cause
unbreakable while cycle when CPER ring overflow.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
index 47fe8a04e26a..d4e90785ee33 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
@@ -452,10 +452,10 @@ static u32 amdgpu_cper_ring_get_ent_sz(struct amdgpu_ring *ring, u64 pos)
 		return umin(rec_len, chunk);
 }
 
-void amdgpu_cper_ring_write(struct amdgpu_ring *ring,
-					      void *src, int count)
+void amdgpu_cper_ring_write(struct amdgpu_ring *ring, void *src, int count)
 {
 	u64 pos, wptr_old, rptr = *ring->rptr_cpu_addr & ring->ptr_mask;
+	int rec_cnt_dw = count >> 2;
 	u32 chunk, ent_sz;
 	u8 *s = (u8 *)src;
 
@@ -482,6 +482,9 @@ void amdgpu_cper_ring_write(struct amdgpu_ring *ring,
 		s += chunk;
 	}
 
+	if (ring->count_dw < rec_cnt_dw)
+		ring->count_dw = 0;
+
 	/* the buffer is overflow, adjust rptr */
 	if (((wptr_old < rptr) && (rptr <= ring->wptr)) ||
 	    ((ring->wptr < wptr_old) && (wptr_old < rptr)) ||
@@ -498,12 +501,10 @@ void amdgpu_cper_ring_write(struct amdgpu_ring *ring,
 			pos = rptr;
 		} while (!amdgpu_cper_is_hdr(ring, rptr));
 	}
-	mutex_unlock(&ring->adev->cper.ring_lock);
 
-	if (ring->count_dw >= (count >> 2))
-		ring->count_dw -= (count >> 2);
-	else
-		ring->count_dw = 0;
+	if (ring->count_dw >= rec_cnt_dw)
+		ring->count_dw -= rec_cnt_dw;
+	mutex_unlock(&ring->adev->cper.ring_lock);
 }
 
 static u64 amdgpu_cper_ring_get_rptr(struct amdgpu_ring *ring)
-- 
2.34.1

