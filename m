Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F6CD38FF0
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 16:47:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B0F910E642;
	Wed, 14 Jan 2026 16:47:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qGmaknfI";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011002.outbound.protection.outlook.com
 [40.93.194.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB76110E62A
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 16:47:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k3Io7A/tvGAg2jww1vSmHbJSqFlf4Tvq59K8ujjOvTKklUadk7P2L2Co1oPpDa5dugF+GVCzV2L6NE6kuaMFZffObqc1ZgH45+Nt2h3P4UfQDeuUv6WCRmYfLXCD8I15FMUCZC6jYu9AnbFrjhctQf/aMf+RRiyjZ9GfrmQLq4HK6rz2NAGYDafugnlguk7qSrJh+zsxxhz74bm3BW3Dt9stKGPMfZOyEz9gJ8HrHyYmwg7uMhIEbc/agyU+CycwEqSHx0XZjrRHO9H2E/oOLYZzj/fmm5UTPizFab7gPtiRtM8UQfaD3hRBp1zbm5J76lvSaSCQ5LTSqmt+mowPsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cICRdvIpgg/Z4PUyrSEjyXgj7HXC+SRNHSv5JMo0vCE=;
 b=kKlbbhiuabtMUh/iqVwzk4T3QTSmG2rgcKG3UdGnH6c4oIQZodobA1Ft8ndU6BDzNWnke8h+mMp+w0TFccfXOFJuXN1dtg/XOZoK6kWkztNSoIdifGBKw+fW242cvegVY1pWb3OpWZsRmtkoHDnNkLgb1UUHHnrL0kY1t9wjK/adRJEQk03lMmfG73pTpoDqCOECKdIDlQZ8M/2lBXfqKZnEsxK8bVQmzf+Dp0UuUjfZGmdND6wlIa/mgQclYbd8pvXIrhdTn3JxkujLQAru/lYmJllzzXh4ZFn2yVz3vZJ93dIj1icz6f4rN5nZFjyimvSW7RTtmlT2TCIE2a5ubw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cICRdvIpgg/Z4PUyrSEjyXgj7HXC+SRNHSv5JMo0vCE=;
 b=qGmaknfIIt6+gb4hqs9ENS43ncPbOn/6PdXvjzVxNgzL+l5+ogDoKPL6qEqIv+tKaO0mJCmnSuX10IE4BOUrGeNgV+U6ywBMQqgxBKyHcLtrLF3Ep/p1uCv/ZWqmJwuIts4G8y+M66tmiU8rGiZohxOE3UjM2PiKunMzZQ0l/kU=
Received: from PH8P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::23)
 by CY8PR12MB7564.namprd12.prod.outlook.com (2603:10b6:930:97::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 16:47:41 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:510:2d8:cafe::a1) by PH8P221CA0006.outlook.office365.com
 (2603:10b6:510:2d8::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 16:47:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:47:41 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 10:47:37 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 10:47:37 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 03/42] drm/amdgpu/gfx6: switch to using job for IBs
Date: Wed, 14 Jan 2026 11:46:48 -0500
Message-ID: <20260114164727.15367-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114164727.15367-1-alexander.deucher@amd.com>
References: <20260114164727.15367-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|CY8PR12MB7564:EE_
X-MS-Office365-Filtering-Correlation-Id: 39024291-cc63-4174-f076-08de538ca218
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?X19dbCnAuoZAWbCZJM2iHEpdCwFRoWII35J5mfBuGg56iL/WcFHkvnrDDclH?=
 =?us-ascii?Q?Ye7zWoXhFDgybZbvGYm6qb7l7katGEZke04IDXlqhoHN3fChQvgdr7U1ZoFM?=
 =?us-ascii?Q?41z+wNUti/ibkFl4MW8WSLp6PhMo8GyL71xpEl7dUrCtlKq4+SDdTFVqZlEA?=
 =?us-ascii?Q?OkRXoKGyRIW3sGWqr5Q1tldWEw8o6OsRWCF24G+Ci4IbiPSbae8er+Ntm2aD?=
 =?us-ascii?Q?S0GLDiBQuIE8trpo4C0Ar/He1vbd+CEKAjnCXl5J+02r+SEvYyEvcV0Xa+7m?=
 =?us-ascii?Q?nvZjw+fza8paWSZ//ZwnHJl/NSIjh/CfVTgeK5XdIos8P+9oYX17cDATo3+J?=
 =?us-ascii?Q?aagbw4rUbS3eNb7TkIXci6oO2V0ZLqn+nCfu0yGpxc6VsAVY9ET2z5m6kkms?=
 =?us-ascii?Q?6qLGp3vbd2ftHl2EOX205OdlQm3sj5r1o4I2w7SMn68PH/NOsZnhh0liII2E?=
 =?us-ascii?Q?4eU9a52RFaAAcAVC7/VHyzSts6Mf0q+gjlgRg+p52QH7zXnHqy+5yMxBV6Ex?=
 =?us-ascii?Q?toD6jky/6JLjPIz3KaSnNXk+Ssz9v/I3vvnBv+8l2BxHDw79osHtXQmKjV9S?=
 =?us-ascii?Q?OO/n8d1LQ6KVWCyCMCQKEIVJVAFumtC6DCK8EprgXzK5er5I6tDkBk2KQZgB?=
 =?us-ascii?Q?rdGpgC6Dyxr5cMG9G5f6JO8xQs5jFECzjR1rgq88M3s0/Hm7m1UYbnr4mNPr?=
 =?us-ascii?Q?Fb7SvFgk/7MlAr864xmq2f3ZrJpqlj8FzabQALu3OJiWo2ay3e56tFKa/wM/?=
 =?us-ascii?Q?ib3zqnEeEmNrx0T2um+NtU2rfdr5Vu0uKmd5arERlXq/QEBqupqSLpEYwtLJ?=
 =?us-ascii?Q?b4vWLu7Bz7jJq/CgFon6cbiJj+kK8vLpVZ9YrGdVeIZ/D0cB1jj2t4vehPUh?=
 =?us-ascii?Q?l+a2bex7jpLNMvEqVfSkrW0H7ZAaUkMpyF17c4rSc1SegItwTaRz0pkXziYL?=
 =?us-ascii?Q?ykeq8CYnH6pH3diXno800LE3lw2og54UVRbqFA1YYpCZfmOZwElObT19ZZUZ?=
 =?us-ascii?Q?odQf4h0BGNQytJ3jHtTc47hbpZUKhs56LmgukkS65p6sZbipdM+REhfi/AsL?=
 =?us-ascii?Q?RXT64U+SCPiKAuI1ADCS5R3RjmwcVdkb57h4v505KFImNdlozN2wEtKL/c0B?=
 =?us-ascii?Q?QHq6kmed4psnnvMbUeg0zaNQre0dyUh24tdglwZza0gt7AQIw3nZdBNci50I?=
 =?us-ascii?Q?vSlo2Zcbot3b+U9B3mkUg4UbnHpuLomgUKgzm8MXysRzos7DizGrp9dYnc8k?=
 =?us-ascii?Q?982T1y1TdU7kdNYuv2sGgnpPx4w5+t6avMXcFupj4Vc8PBWFch14zmNaJodW?=
 =?us-ascii?Q?eKYGUyzkk3A2CwJXfUauCqVTyUEfp8sYilRpPY/8INiwqh+rntwwSON/cmo2?=
 =?us-ascii?Q?VSP6ZphAdBzO5H4IcfkaoAATRGlHfQIltnJtwWB+Yn7S/kRv4TXzh8dZ1bny?=
 =?us-ascii?Q?0qCwY+Jex9bvRizXtU6v1ceumSO9jBWEJ8ejTmf5iSZsBtppdO8/acv95Biu?=
 =?us-ascii?Q?bFd7WY8pvF463Qe0DPiXILfEFwWbqcFOJz7iFstp28JWRFQ8EQuyB1y0GqFg?=
 =?us-ascii?Q?v2gF3bF3gWCpq51F1dcxnUE8jtWX7aABoKOmXazxtMgTjKqi4gasRNs0WEIL?=
 =?us-ascii?Q?itCBnQsH5ENMZoXLDiy8w3PrRErOHFAhMngoHdm82PdvmB1jwCn/wLeId9+G?=
 =?us-ascii?Q?0l+znQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:47:41.2389 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39024291-cc63-4174-f076-08de538ca218
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7564
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

Switch to using a job structure for IBs.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 73223d97a87f5..2f8aa99f17480 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -1895,24 +1895,29 @@ static int gfx_v6_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct dma_fence *f = NULL;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	uint32_t tmp = 0;
 	long r;
 
 	WREG32(mmSCRATCH_REG0, 0xCAFEDEAD);
-	memset(&ib, 0, sizeof(ib));
-	r = amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIRECT, &ib);
+	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_GFX_RING_TEST);
 	if (r)
 		return r;
 
-	ib.ptr[0] = PACKET3(PACKET3_SET_CONFIG_REG, 1);
-	ib.ptr[1] = mmSCRATCH_REG0 - PACKET3_SET_CONFIG_REG_START;
-	ib.ptr[2] = 0xDEADBEEF;
-	ib.length_dw = 3;
+	ib = &job->ibs[0];
+	ib->ptr[0] = PACKET3(PACKET3_SET_CONFIG_REG, 1);
+	ib->ptr[1] = mmSCRATCH_REG0 - PACKET3_SET_CONFIG_REG_START;
+	ib->ptr[2] = 0xDEADBEEF;
+	ib->length_dw = 3;
 
-	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
-	if (r)
+	r = amdgpu_job_submit_direct(job, ring, &f);
+	if (r) {
+		amdgpu_job_free(job);
 		goto error;
+	}
 
 	r = dma_fence_wait_timeout(f, false, timeout);
 	if (r == 0) {
@@ -1928,7 +1933,6 @@ static int gfx_v6_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 error:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 	return r;
 }
-- 
2.52.0

