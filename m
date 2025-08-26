Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D224CA0FE9
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 09:25:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39F6B10E2E0;
	Tue, 26 Aug 2025 09:25:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xgOeoysr";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C456110E2E0
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 09:25:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IeIoI/2jCQsSspybIyNkUFwyAqi2poVREZy/IajtANkEOQzGbTuQcmQhPqxEP8ZrjRf60Q8ULzgpdAeIxc1DSDS11UufZK2JtL1JWq0r8CjZ4rjapqWh7Z/JRNXQ/GKhIxXEwelt3CrczP42hUW7YXuf4hqQPZxMCZRpZhrykco5uuuCurpenxIcoyu7OPr+hFpupPwnzy+AsZZUpNxzJWuBvbuxymQ2769hr001NN4+wFUv6MJM++ToI609gcZbtwrKUaI9oWazXYzTxioYJTEFXggnvYkPqr9Gx+W0MxhPkPRFV0rlkpA+IVanV9ddVdlSDhMFUg0m2cCSop+MhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZdyraiVYJsIEnPcvvib4j4f21MiPnu+1/XJ5UOAkWA=;
 b=bo4PMPyDnhQg6P2dRNEZDd5x/0uEAq8Efg8USuG3ordFQIXFaADjqejfpur6GvLeaeNu2roTuw58S/274YyMvNTuqqJyhGOzv3x2RlZ/LjTZ01S6XiCN/WRJDqA8I82UBZvofW1Oslib0bp3GEkknsWrLsgWQ8u1BrTvfgAEiM7lRwWmr8mj8+a22V2jKKAz/pIGj8pY7l8L/obgv3Wk5nW4be2B0QQ4tvMP458MkF9rnjA0obt1E7LK/tJvH44zNTx8A756kpsd8tNBDBpnBSqI0uYWGoDFT0SH4fRsvNRDmf1OlMez/H4Dw009SzpejDliOP+BdZCmOLhLIu+gbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZdyraiVYJsIEnPcvvib4j4f21MiPnu+1/XJ5UOAkWA=;
 b=xgOeoysrwdANZY4anSlbvDGeQCYUV9It4OtSqengQIrk/cczuIgHCMiRLLDKDPDqonSP/MNq6iUvKdJgXjszM2qjM7jrtxCyaKputQfREDwn2hlipa5+AjEf8fw3oL7tfnomk+8IucA20z3RUpUvX4OSt7QEOobPeZ/FSlVG8C0=
Received: from CH0PR13CA0040.namprd13.prod.outlook.com (2603:10b6:610:b2::15)
 by SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Tue, 26 Aug
 2025 09:25:20 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:b2:cafe::b9) by CH0PR13CA0040.outlook.office365.com
 (2603:10b6:610:b2::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.11 via Frontend Transport; Tue,
 26 Aug 2025 09:25:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Tue, 26 Aug 2025 09:25:20 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 04:25:20 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Tue, 26 Aug
 2025 02:25:19 -0700
Received: from lcaoubuntu-server.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 26 Aug 2025 04:25:18 -0500
From: Lin.Cao <lincao12@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Deucher
 Alexander" <Alexander.Deucher@amd.com>, Lin.Cao <lincao12@amd.com>
Subject: [PATCH] drm/amdgpu: fix memleak of ring sched and fence driver
Date: Tue, 26 Aug 2025 17:25:16 +0800
Message-ID: <20250826092516.3607290-1-lincao12@amd.com>
X-Mailer: git-send-email 2.46.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|SN7PR12MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: 13eb2276-5328-4caa-7e3e-08dde4827a51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CICgWDP5Fwygbl6oX1GXNOiGu3TYTgF1d4lYNeF/I4Na7Yqr41Uhd0XG+nCe?=
 =?us-ascii?Q?13rO6D9CfSGgyM/xMqRffSE0vfYXyJA0tGdxb1OeXEojI4CneQ+peps50BOo?=
 =?us-ascii?Q?k8yribChNbw/bqadsdTKiZQ6S9PtRjgG+qPsfxVeT55R7sE4GZZtQCrfpBK3?=
 =?us-ascii?Q?k1LalGBQgdsjlBC3A8FWQr8cjtXyeQLhS1L+k1bIQydlGliUKBFo9bZX7Ffd?=
 =?us-ascii?Q?D/PDSHm7UIVVtUFZdwTKQyubWqEfr49y3IqIfA+GagfTMNQ005ki6JC6z75+?=
 =?us-ascii?Q?s/KnWSJ6o5XcKOwXevLrmohlSotq1SQ3Enz1fHAI5ad1o8eApETNmx+wHUAG?=
 =?us-ascii?Q?UZkys7zSCsbfRzGbCWAwaiOxxG6NT9CqgOYdKciHo6xU1iGvPIhD9ZFO65Q1?=
 =?us-ascii?Q?LbdUmrrYrU1XXdkwc0dOCIe8Fv1PfvPh+ladY42ruYTBDqWDzDZ6pF0Yb+/j?=
 =?us-ascii?Q?Q35Uw1I3VJeSM1KGubeFOObMqAZYUIhw+YhaBk1EoHtgfPVtEPKcSUFE3bNJ?=
 =?us-ascii?Q?pi5QCp0IwFr5Hz2DgcZWpaG7FQ9LdBxsBC0SMTOAvAGEbBVKTfhO6f4NyBFa?=
 =?us-ascii?Q?CqaOF1ufMjYk38kHcIAoyL6zE34r82KjvJyU1JdxRytG3Bt9OcP1FafT/4r+?=
 =?us-ascii?Q?23vJYur12jBaK3XNRPU/vxcwCpgLtq2Nh0HzaTbiP/74bj7775W62REmNCtD?=
 =?us-ascii?Q?MJS8duZ1G0/SF0Q91n5O2EiTI2DFFq1odux/XDwF92cz6UKnd+/nR8z8bGms?=
 =?us-ascii?Q?h/i0TA6xCdeb/3Rg1nILMkG9Bv0xTInA1C0mjo8Qm1qwrZLQp6d3R+crc2pf?=
 =?us-ascii?Q?hRQQZ1WqNnQe7aOtPJ+6HsmBeF9uVivd9wQesbfJbqaSMU3OFVA3nddaaqra?=
 =?us-ascii?Q?0tYcwTs2H0ghQ/Vbv/QTyGR2mosy5dCqIeUrmmBXPs5ac0Z83sQruZkY+srH?=
 =?us-ascii?Q?UmhqyRryw36eWtHDgi6Ot7WeFsNmoMohgxo6qhQzWq1gkBwk9ekmwh9p9g43?=
 =?us-ascii?Q?cFNTQ/y7A11NmkC7byMuz92bQIT7uWo0kDQhBllolpgmu+G+i6lVUb2ihvJw?=
 =?us-ascii?Q?f5dRoWxlR0FKnbpB6epkflg/DkmIVDHtxGVAHagrgFaFldGyAhoOCvt1SRkE?=
 =?us-ascii?Q?Wh8qzXgj2UZocmbfrztEJIEaHvn+Q2HAQdfUOS7b4UYVFY3CENziDgq7jnjs?=
 =?us-ascii?Q?75Xi96Egz98nV3LjDUumcq3Dyi6Lo29IABYNIrr5Wlco1nnCft/RxjsDNf0z?=
 =?us-ascii?Q?quOAAwUtYAxUkR2KKwQiVfOxOZsFA2lBPkv81Vp2tqWX4Fwf2AQOBOJ8piBW?=
 =?us-ascii?Q?KrL6Dn8W4paaiSlgYP38bpNe1YqLUXGuIt+IxQLuQ+RKo0CqZvhWeyw+fgrd?=
 =?us-ascii?Q?TInhK9QQinvvItqfPrwVdRp41+XMfLdIoTCMoFweW7qnOSo1Zm2EIRsTIRBZ?=
 =?us-ascii?Q?WIsUU7zrZOgQu39o0m0v8z5LIv4AaisjH28+sjWrRagSbJzXGykcvhU8Mi0P?=
 =?us-ascii?Q?0Vbnue5ddDz1QCIEiKLEe7bOnG3VVOchvWP8?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 09:25:20.4976 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13eb2276-5328-4caa-7e3e-08dde4827a51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7954
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

commit 4220d2c7c41b ("drm/amdgpu: remove is_mes_queue flag") set
ring->adev->ring[ring-idx] as NULL at the end of function amdgpu_ring_fini()
which will cause function amdgpu_fence_driver_sw_fini() skip
drm_sched_fini() and free fence_drv.fence then cause memory leak.

Release these resource at the beginning of amdgpu_ring_fini() to fix
this issue.

Fixes: 4220d2c7c41b ("drm/amdgpu: remove is_mes_queue flag")
Signed-off-by: Lin.Cao <lincao12@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 6379bb25bf5c..cf6f19a122df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -406,6 +406,19 @@ void amdgpu_ring_fini(struct amdgpu_ring *ring)
 
 	ring->sched.ready = false;
 
+	if (ring->fence_drv.initialized) {
+		int i = 0;
+
+		if (ring->sched.ops)
+			drm_sched_fini(&ring->sched);
+
+		for (i = 0; i <= ring->fence_drv.num_fences_mask; ++i)
+			dma_fence_put(ring->fence_drv.fences[i]);
+		kfree(ring->fence_drv.fences);
+		ring->fence_drv.fences = NULL;
+		ring->fence_drv.initialized = false;
+	}
+
 	amdgpu_device_wb_free(ring->adev, ring->rptr_offs);
 	amdgpu_device_wb_free(ring->adev, ring->wptr_offs);
 
-- 
2.46.1

