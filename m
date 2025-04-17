Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB190C369B2
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Apr 2025 16:37:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E71210E2C8;
	Thu, 17 Apr 2025 16:37:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PVlelPNG";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6B6410E2C8
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Apr 2025 16:37:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IYPwAAstMsmf0bxhUNs9S/0WfZAeKJ2rY5bOzDy+duqO+KoZdZEMd3tSzeVaGEFK8OBzCCaVSJ0h6XjezSUbEzvHMUcK4zKk5186cHdEZ0U0xkTDAYPz2oygyXTNwLwb5L1ulQPEGsMAv91p6D3JDk56oAAL3NRWfZ1S/v1x3WWYsDHY7PySbbNXK1UGg+pv/VrsblLKzPfu2pyYkWvQoBDGqh1Tv0Tn5CpCUqJbyHCL+IeH451/F/pOUd+pSMzPiQQ9wqc/CNy/CcStmPKan7J+kedQQ9T8EqolhO0pjk6YYsU6gQ+yIT5k2uB0s4P9/u/W4U72VhkgPADpd6DT7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OrYIEGZs8OSSnAIiV4WwTJagM/xJWRRNa3NLiH/M+9w=;
 b=VqFseWuAITkrOdiZ7HDjn/gl3sYc5/ofDFvu3m+/ezrfydAw7d7usa49/w29H7tjWdw5uDoC2mzSL4TCCviUxvoC+9Cx0IFVW4AGPeb5ltkeXBC+pCSay2mxPcMraPrgBB/bo68ciLLBHnaYexkRc/UjcKWHagBa/2ia4sse0mj4JqfqdqsLwNXu3VgMMT1IXV/MReaUVyvoTyxbxEjSHSk9Tusp9AXVNNQrAVozYrAjIjsXT5tfPzBt8ujdHMBr+Ws9EcrtgWvTtyBnExcjhqwUnSSZsge5bTfk4IAFY+FdCzHMtggHnzu0Ib10j7mB6Y7QFFhDfpdGL4c2pXfu6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrYIEGZs8OSSnAIiV4WwTJagM/xJWRRNa3NLiH/M+9w=;
 b=PVlelPNGPBFe1XzYdHyJtXDAhdmuD7J9d9ek7BrSUCY7VJs9CIfHlqPlnExTpqQpdS2pasEdy5XUmVc3EhVk+djRSx+WgiGQrNFE3Pk2AUC0Qt2Not2xGHgg0V9FrqXxeyteFooXa1M9HN6MrOuv/TtwLFHp3IqhSrseiCgH6WQ=
Received: from SA9PR03CA0012.namprd03.prod.outlook.com (2603:10b6:806:20::17)
 by SA3PR12MB9129.namprd12.prod.outlook.com (2603:10b6:806:397::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 16:37:21 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:20:cafe::58) by SA9PR03CA0012.outlook.office365.com
 (2603:10b6:806:20::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.22 via Frontend Transport; Thu,
 17 Apr 2025 16:37:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 17 Apr 2025 16:37:21 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 11:37:20 -0500
From: Felix Kuehling <felix.kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: Fail DMABUF map of XGMI-accessible memory
Date: Thu, 17 Apr 2025 12:37:07 -0400
Message-ID: <20250417163707.1288027-1-felix.kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|SA3PR12MB9129:EE_
X-MS-Office365-Filtering-Correlation-Id: 60967da8-19e1-420f-753a-08dd7dce200f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bpvUNaM6dtt5LFNrGwGcxCDty3o5n5sh5kutpuoHDMOR2lXbBZAVCou9AauD?=
 =?us-ascii?Q?7fFap32SB+KrukZVH0+0ZeJz+r0iNub/Sjx7uyzk7h7Egl4g5qhfaZCJp1WN?=
 =?us-ascii?Q?sVqB9K1o2HxE9pp77UigBgmSG2heo1ByxEFzl7ij/MLrNckqaSvtaLsQV2Lx?=
 =?us-ascii?Q?n+6hyyNUY++8G9HSD2I28opQAVgQPGzzrggl+U9pxolZ363ssqC9OZZeeYxj?=
 =?us-ascii?Q?I38XKEwgqQxXeDu7/zRrtvOD2F75uFXOzd8o/viT3k+DFHiyHfQNIM3GMUgv?=
 =?us-ascii?Q?5PAQIV+jifsYlwJxIYf3ijD8X4kzt1akP73Xw56Qrwt8U08USEW7BPdcN6wZ?=
 =?us-ascii?Q?9TUeoCRv8/pkqTm0CK1DqUxw2gnRgrG25dNEPF+BAUR9mXMulms4xuFdq+72?=
 =?us-ascii?Q?YAJ2JmCNyEwd7TAPJkwtryyGib8nb+OEESJOT/7uysX8AEYsNcX8CWgWWFvf?=
 =?us-ascii?Q?asK9BnD8tUo9znIw9oeNAQuAEtYaNi1uQnW8hadSqQxo+Cln3aGJf6MBZl7Y?=
 =?us-ascii?Q?euCJjVsu/Lhzbd/68OXuS9onG45g0fHIQbu2f0p1h2T2fjVbdCnyAkNW0xqu?=
 =?us-ascii?Q?4d/18f7TbGgZqH26RTL9vFi+0fasE5/+FveuTzLGjUSaT6gPn+ySASCU6JSH?=
 =?us-ascii?Q?zQSMoALkdsHsZmbTB9lQUqJtoInKT8QVGz37Z2fN6A9cA+mAxrjh9hQtPTfF?=
 =?us-ascii?Q?s27m1WZKa5paRL3uXFDAqn08WhFFbk0zmGDgeK41kLN9GylUL1dZvOjIe5Wh?=
 =?us-ascii?Q?WcZnxabYq85QcoBIRHyRWr8g+IXSmFsLHIHu9/mhUOkrzUyDPG4IIZLOclsH?=
 =?us-ascii?Q?lEgVScuUAY/biy0e8iCL5+kIA5A/cm4DEx9qsFqAHdBCHLWMHY96Xfd/o2h2?=
 =?us-ascii?Q?LUwgZybAIN/ddfdLQn14Jy2PbK0yLbVZvL9BqYpjx0v8p/+HsgS46sLTvn6S?=
 =?us-ascii?Q?9SHBYy8XnonvsRE6wNP8PXtQVZz1h2p2v3aTi8KQegX7ulpD0kWCT4mfBhAw?=
 =?us-ascii?Q?x7rrGnol400uOXRgfX9spNBEnoVJFhnfKDy5qUkffXKppcQ6CoPYmboYFDD8?=
 =?us-ascii?Q?DqDIFnoMDXDl2RWNokTWqF9SHfPEtXhomNKlrXAnkTq1dW3C1Ye0NYPmH3H2?=
 =?us-ascii?Q?5W1zaFQndyxhofF7BFS8/glhory3boVbgWCZuyUIVtR+doObPr2VyzzqsXvX?=
 =?us-ascii?Q?yeDWEP0BIC2d1B+9R+wEgYe3Qkg6P08b2Ysaic0hVRBpexjLq7f92vZLegV8?=
 =?us-ascii?Q?/a1nHupZaA1NBB3RLOLeYbycDg7f7TjN/LJosCD9Mqm+Q+wS48C4sWd5HoGA?=
 =?us-ascii?Q?ZpRgnv41xKWSXeCaOjdwQofttxsd7OT1Ai0tOGPY3Xj5NjYM/ByWngPSqvSU?=
 =?us-ascii?Q?0RbOZ4KecVbR1mHjQbPo7E3Fj5vHDgNnZpvD9VQgZRxObPp8q4hAYCRp/UMK?=
 =?us-ascii?Q?cG2xhJeE0Wk+fNlbswHVtz+OlM9z7kc5/s518udZ/9XXDDflj62pN+Kj+m7Q?=
 =?us-ascii?Q?Q9z4g8iGIjjdgq0oZ9eYVixXWSIoydPUppza?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 16:37:21.0472 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60967da8-19e1-420f-753a-08dd7dce200f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9129
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

If peer memory is XGMI-accessible, we should never access it through PCIe
P2P DMA mappings. PCIe P2P is slower, has different coherence behaviour,
limited or no support for atomics, or may not work at all. Fail with a
warning if DMABUF mappings of such memory are attempted.

Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index e6913fcf2c7b..44e120f9f764 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -199,6 +199,11 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
 		break;
 
 	case TTM_PL_VRAM:
+		/* XGMI-accessible memory should never be DMA-mapped */
+		if (WARN_ON(amdgpu_dmabuf_is_xgmi_accessible(
+				dma_buf_attach_adev(attach), bo)))
+			return ERR_PTR(-EINVAL);
+
 		r = amdgpu_vram_mgr_alloc_sgt(adev, bo->tbo.resource, 0,
 					      bo->tbo.base.size, attach->dev,
 					      dir, &sgt);
-- 
2.34.1

