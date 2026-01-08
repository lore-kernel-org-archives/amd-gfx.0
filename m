Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DECDD1D467
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 14:49:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D38E310E76E;
	Thu,  8 Jan 2026 14:49:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2n446MdF";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013010.outbound.protection.outlook.com
 [40.93.201.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FA1810E766
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 14:49:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lkfMmlw4mE3pftUV5bS9dQBwJB7Jasurttf1LlhLT5cBQfzj2A4SsugfzjQyw2ZeYBMkXvmTUAlpw2BwPw56phCpM1ZSeTXcARU6Oh1il8iKxJV9t8HXo33f7WpG7g1Otyogvm7QKCopHL/60x+oqyEwUfkrunTPhwcB7dLiPqZU020Rcl/mxuqGFHjggT0gqwun6JIkLuwmDU9BR7VaZuYSUuNgwmHNPWUCCqthIBdqlKz7OBdD0AVxHnXunnnOiM0jaT+znM/E5OK9SGHs0y7ah5ZCf3UJgsejJfImrAXZBrkUtK8pY0ygndKoAqmn1ufJ8r+oPT7f7dO6W4dU2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36XO/5yHycsO0BpfUGL5MUBYAbmsecvoOX2cixyMNOM=;
 b=MnWBiCWFIAH00PsqqJYm+uZ/GM1Lxcl0hmS1TkKUEs+svx2TSFmgMh5PoOkE5k2JmiWxf2Ct444NXcX4qhw0rZLiYrdFBCCwW22fQ9Z7YBgfjJ9HD3GytYOpuCxo52RRLbIPGTQ21vny/Khc2S+1/JrFDIzvOEPCYMEapGm4DIF/gfppKyoIluhy242cdMP0b8kmIem9DgbZcc6ntx6EvmXZ+OzT8a0rbVBUloQBxQwyGBEunxNt5hoDIEwVtWDLPuLdd9fTjYKnbXBAYNe5Bm1VDCmZ4V2rxXoAPfCWtCLp6ZxNknzoS3FfygkjeCDgcccdJ4uFTISOeugtBLzEGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36XO/5yHycsO0BpfUGL5MUBYAbmsecvoOX2cixyMNOM=;
 b=2n446MdFExNT36tByVorVPSVUjHAdO/o/N+1EiNCcEGNf486RGu1883Ch0ZVT0MdOjGV5K6yDAS12VPqpRMmpf5B55UT7s1YUqr5RX8A8U72RYS0jqOyY47zPv/ib2Lydm85dDbkHEmYP2KYrtbDbrjmlXscu63q2BHTCYjdWZQ=
Received: from SJ0PR03CA0346.namprd03.prod.outlook.com (2603:10b6:a03:39c::21)
 by LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 14:48:59 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:a03:39c:cafe::36) by SJ0PR03CA0346.outlook.office365.com
 (2603:10b6:a03:39c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 14:48:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 14:48:59 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 8 Jan
 2026 08:48:56 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 Jan
 2026 08:48:56 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 8 Jan 2026 08:48:56 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 13/42] drm/amdgpu/gfx12: switch to using job for IBs
Date: Thu, 8 Jan 2026 09:48:14 -0500
Message-ID: <20260108144843.493816-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108144843.493816-1-alexander.deucher@amd.com>
References: <20260108144843.493816-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|LV3PR12MB9265:EE_
X-MS-Office365-Filtering-Correlation-Id: 59de43f6-40b6-41fd-b03a-08de4ec50e82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4ZQtJYOeO7vbeeHkzbfSIAlyrmSuI00ntfyyB2+72OjV6SzWdDRNoXUTY1uF?=
 =?us-ascii?Q?oUjPxu9A5wbVXx877i6fYcrBG0AwC1IOvCN1tKONpzT6RT7KidsbFpyuqkCo?=
 =?us-ascii?Q?szwCTWwc06JOmKOBdPJF2cpOqmsHotYRRgEjSKcr5w/s9rO4GtoVDjPmN3yo?=
 =?us-ascii?Q?zDAgw8vJjnKveQg+FkVL8GZZ/fcWn8ZYByTnDcAgjb+RqVPKao6SRfuPZgwv?=
 =?us-ascii?Q?azRDdIQukxgUEGtMRljeFhbyMMx7FijYn2Pm2wiNbWzZgc2nPdMuWa4mTLqj?=
 =?us-ascii?Q?G5K4unZU8BrFc8g0/5KPvUwn9nqa0hpMxl3A2op3WkcixZ5hOHgXRL6fgF0M?=
 =?us-ascii?Q?sTsSgpvNJP44UnC4DmPUN4bKKl5Z0pMEGpf9rd6YNLBOiouXWRxu+PA+0lh+?=
 =?us-ascii?Q?VJn+neD2UzyvEGOJBwru5LNFe3ZVCZe51hohR6GQlXKOBWWkjsRSzNXQ3TYe?=
 =?us-ascii?Q?vHhS0yupaLmqVfEvSDMg+hgoMdoJlOMd3DhGh3fxmdIAu2NDAUBN+HMpTsk0?=
 =?us-ascii?Q?RMVwCy/Fh4G+DVeGaV4b2r4Cmr6VM8aAjyHi8Cth6SMHZQmEuNLH9DbzTfq3?=
 =?us-ascii?Q?LLVAoDrXjS1MSvd7o7tCqzUkZA9W6bZXCcXx9HAAT2lNHFW3Da5GaVxV9EHh?=
 =?us-ascii?Q?z33kQUdou9hkmKv4+ID/gauoy+cfGrDUSfjWVgnbhBN2Ir0xB1GG7aoGpYsZ?=
 =?us-ascii?Q?FmGI3lL6uOIsxONtg5+kL0eA4rA7jwGUklBBu+12tUMuSq6K6c7FtqYl0b4c?=
 =?us-ascii?Q?KLh4E/LtTZmC/OvoizJHn3FJPhTzXnzmwMv8icn4l69IAKOj5fIeDkZcnnkd?=
 =?us-ascii?Q?xB748M1NSqYm0zoUsPeMNwxPL+JtR3R+ZmK6o+0d/z6bFPxqhrFR5pgEFgvL?=
 =?us-ascii?Q?8wEz9IEJVffTAyrgDkTOMxHfMBaANlZzLc/+E9v/btJOH363VGRYV0JbWfRX?=
 =?us-ascii?Q?egcqqfvnjLTe0ZFJyUtHGQZOvNHMz36LDFIDmU+scOmFUXWPAaGLOfpUYe2x?=
 =?us-ascii?Q?fx+rP0Uu6GxR85pzK7RpmC5lxCTYWe6RqPDhZuwCnhRXwvsqt288li3LM8Cv?=
 =?us-ascii?Q?bs9x4JIWuyQApButMi03kNuWvnCRSAu5LqtTsrcxbJot3mdvhxQMxLHehSVs?=
 =?us-ascii?Q?hr3GMsffs+E39vXu+cR7XKDTYly5Jn5NF/jJS6+HqKEnf7yjclB/SpmtOdMU?=
 =?us-ascii?Q?JkWBB5aFI395XZvAWDM3h3M1lEtQ4N4xIF1IswEJIU2q5qCLL7c6wQlRHKov?=
 =?us-ascii?Q?E5F54iF3ZpDeOuV/ailXZrFw3BNNikKJU7vaUJ1yjKCwhuYI/j4IjpMn5ZTV?=
 =?us-ascii?Q?ZSMUSmDskNX1FQ0SVfsxnhT9y18BYSjJEkZp5IK7udv6R/+UKo7qGRy9C+ru?=
 =?us-ascii?Q?YLpjPOiw4B3cFd5bFjNqOpACe2urZ/vJ9ninQ+pNfCQZwTgbm4ZuszhddT7l?=
 =?us-ascii?Q?oosfwVWd90Zhsph5CTQYhKHeycufOIBXm/Zf52ze5VGcwYEFRLbjFcOk1FgX?=
 =?us-ascii?Q?iIaVc3lfA9vpmiqlWeLrcgpeCBFeeE/0tv3kVAXJWcyCpHcYywNGfWKBHePm?=
 =?us-ascii?Q?OHLQ1wFRqhCXZ30Sul8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:48:59.0788 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59de43f6-40b6-41fd-b03a-08de4ec50e82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9265
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
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 29 ++++++++++++++------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 6cd16f016c374..5862b5f60a6ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -494,7 +494,8 @@ static int gfx_v12_0_ring_test_ring(struct amdgpu_ring *ring)
 static int gfx_v12_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	unsigned index;
 	uint64_t gpu_addr;
@@ -506,8 +507,6 @@ static int gfx_v12_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	    ring->funcs->type == AMDGPU_RING_TYPE_KIQ)
 		return 0;
 
-	memset(&ib, 0, sizeof(ib));
-
 	r = amdgpu_device_wb_get(adev, &index);
 	if (r)
 		return r;
@@ -516,22 +515,27 @@ static int gfx_v12_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	adev->wb.wb[index] = cpu_to_le32(0xCAFEDEAD);
 	cpu_ptr = &adev->wb.wb[index];
 
-	r = amdgpu_ib_get(adev, NULL, 16, AMDGPU_IB_POOL_DIRECT, &ib);
+	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 16,
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_GFX_RING_TEST);
 	if (r) {
 		drm_err(adev_to_drm(adev), "failed to get ib (%ld).\n", r);
 		goto err1;
 	}
+	ib = &job->ibs[0];
 
-	ib.ptr[0] = PACKET3(PACKET3_WRITE_DATA, 3);
-	ib.ptr[1] = WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
-	ib.ptr[2] = lower_32_bits(gpu_addr);
-	ib.ptr[3] = upper_32_bits(gpu_addr);
-	ib.ptr[4] = 0xDEADBEEF;
-	ib.length_dw = 5;
+	ib->ptr[0] = PACKET3(PACKET3_WRITE_DATA, 3);
+	ib->ptr[1] = WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
+	ib->ptr[2] = lower_32_bits(gpu_addr);
+	ib->ptr[3] = upper_32_bits(gpu_addr);
+	ib->ptr[4] = 0xDEADBEEF;
+	ib->length_dw = 5;
 
-	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
-	if (r)
+	r = amdgpu_job_submit_direct(job, ring, &f);
+	if (r) {
+		amdgpu_job_free(job);
 		goto err2;
+	}
 
 	r = dma_fence_wait_timeout(f, false, timeout);
 	if (r == 0) {
@@ -546,7 +550,6 @@ static int gfx_v12_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	else
 		r = -EINVAL;
 err2:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err1:
 	amdgpu_device_wb_free(adev, index);
-- 
2.52.0

