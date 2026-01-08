Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49660D1D469
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 14:49:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1722110E75A;
	Thu,  8 Jan 2026 14:49:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bblIuE3X";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010016.outbound.protection.outlook.com [52.101.56.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74FBE10E303
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 14:48:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BDVxoBuDrnv7NXy54O5qIjROhsE0aMimi2IzHTre6a4VpF/8PzDfmAQfF8RzXlVNo9XV0RM1SzWSlXO8C4NM0EKDhtAvBZY5Clmjm4xYMtMk/58K+PDPlN5KNlzuy+lutyIB9QUh9sdpllSon6KX60BbmSXWskRpi6WYhssKZqT2UJrgUePL+Xl2k/NvusXm+Ry271Nq0XpoRPH9X9JTp8GVfWJwzX0U+VfeLc5CSDSbUpFl5CigZ0zvbTevXU5idGDU39CrvtROxRVBnjlhTaDDBkoHiW2WzkN8Wnl+rBCxCCc228+PjdupnIV8eaoi/OKYJpuIcvqZeBsBI7C4mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FavRQ46zQE/WaERTejoN0/xIdjfT4SBsn6aYqPekttE=;
 b=iUywkmxhKEvXBu+ZTaqTls3Bw8Yd9R+nI/x8FEIxZxVjJv6Q1HcxheRn1t2FPgvrQyeN+REeakiLdqJKbnd8ptkN7eFfXxqcyEGPmIvl6ja/OIow0wrw+iy3WwzdwkfGau2iar5tyrLyHhl+Gp6Wjd08GgKrRE7OY94uz3cXAgKIwytuj3pBljXHj1rqAWvx0M/3x+iW7mOk3g2u0U1J9xZUZC9OmfpHY6dFwGUmvN19RaR54FIDpRodUL/bWljZ7pltMXdBg6R0mtKjag89drxH0v452rQj2QwKTJvcz9s5mQshs9ToPDfnC7Mw5E3HFUuMXCmDEK8ffq0TUGtOXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FavRQ46zQE/WaERTejoN0/xIdjfT4SBsn6aYqPekttE=;
 b=bblIuE3X3pMaEsoC56ElULrIxTv+eD9DwBF5c3G6JyHC2I4t7bHv1FQ6zbNZnr4b7OCA0WPVMvSbD9zaIs5jtCkmjQ3XTAARUiQ+Wgsh6M3ajYzKk/1iHyqDfNGtfd2V+IP154UTf02dHs1ws3Pyzb3HT/iTv52OcdHwBCAqmdc=
Received: from SJ0PR03CA0357.namprd03.prod.outlook.com (2603:10b6:a03:39c::32)
 by SA1PR12MB5637.namprd12.prod.outlook.com (2603:10b6:806:228::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 14:48:55 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:a03:39c:cafe::12) by SJ0PR03CA0357.outlook.office365.com
 (2603:10b6:a03:39c::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 14:48:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 14:48:54 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 08:48:53 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 06:48:53 -0800
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 8 Jan 2026 08:48:53 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 06/42] drm/amdgpu/gfx7: switch to using job for IBs
Date: Thu, 8 Jan 2026 09:48:07 -0500
Message-ID: <20260108144843.493816-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108144843.493816-1-alexander.deucher@amd.com>
References: <20260108144843.493816-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|SA1PR12MB5637:EE_
X-MS-Office365-Filtering-Correlation-Id: 97d1bee2-6a05-4422-d674-08de4ec50bfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fR2RjGPCGUZrgkNpbT8IGANNFD8f3kWHRJMsNim3U0FCOQD7ZNG6d/bV4esj?=
 =?us-ascii?Q?X66ffshBzq9exOsVsMxLLzlk13lVB/dkLBOjoCHbB1qCtkxanmBJexFsFxAO?=
 =?us-ascii?Q?Qv5IEKiFIPGNU901OD+1z0q4TEG2veX5EbhK5IJaStttcLWnbGNTFXj/Fa7V?=
 =?us-ascii?Q?eQAeB0ZctyxJsg2uyS+PLJh4G3imj9aYU4XbA5p5xiJUXq9ff1j3IHYHO/cy?=
 =?us-ascii?Q?oe6jpYw0GJEAtuskYpJK1Yt+JGH6X6Zn5MmdXAB7nQgLgcHzlhMheC8uoSqx?=
 =?us-ascii?Q?is9WKH8LsOLS4Sp7wCXP6WwgIEUTkeTVzJiuL7wWmB66nO2TI7kQ+ILpJonR?=
 =?us-ascii?Q?jyEvtLg0V/O6Bev8qSEAccrD8OfKK7JUBqyvXbPOdOals5R1ejLk9W+pJpEG?=
 =?us-ascii?Q?/L7Cvq0QtEmDQqdZvkNPnO8SRFIexSp7p9psNbwD+aQP0cxMhARL/QIjOHj8?=
 =?us-ascii?Q?YHhtak71JULaG77++YcqbGo0vf85SCcTqsos5CxhxWtAEdMOZEoCB73dTD3T?=
 =?us-ascii?Q?8VXXWPIrPa2d1pXPtC/EpC1r663EmJGDq+Q6tsMohR/JNjb4DO+sZ+IiFZW6?=
 =?us-ascii?Q?Or0am0DnEaILfhDDxAWiSind63XfJnyn2lwOOYKLVxoH5njGbwP6edgg3712?=
 =?us-ascii?Q?u/tvr0Jqoi27wXDvNmx0aY9NCkmxM+X6PWDJ5ZQu8kp53pM4WHWDPqmByUHf?=
 =?us-ascii?Q?R6MUnGUPFSmYiIspm5JNlx6XW9fHGSeHTIXxKaBKzDjbBXLhW3/d7gc7Bz/4?=
 =?us-ascii?Q?+mzzrLKL4zqaYQlWVV/i6fv+K8dCmwceIVMi7qIFuTzKXRs0K8hFBaJ0jaT5?=
 =?us-ascii?Q?LDbJMdWu9NOnnZ1uFUebPECAJlttcSvKnb/Vk+aCcN0cg+mu8xmVvnmSPN6a?=
 =?us-ascii?Q?FhL64ZhgspaY/FaqDT47mGgMS5AqoM6VEjiuSM3WhDJ0uM7asmq+pZNd/yR9?=
 =?us-ascii?Q?p7clUSmbfh7XWwZ1UQDRlS3uT4a23HlJa2EnU2+dx7bEzxLlVNhiU77iExvX?=
 =?us-ascii?Q?7J6+fb1D+B7ixj/Mqy6jN7fOna0ntYjcSZ1Mz/CV6jind+PJHYF4hGSNDJB0?=
 =?us-ascii?Q?apmXfM6G2JhOEL4bamXS+B4p46Iz+rYswAU4/3SCDLe3wMXkHrx5PsfbNi9V?=
 =?us-ascii?Q?e4YImS3JN5vVGneSyTCbJxLoSv9NPZGlv7z9d/TM4WoHh9WYuyY3Ox8HKcBg?=
 =?us-ascii?Q?tBwyHjYAE+hm8YkpyFuiR5MQxK02wfRXyNL6gkKDSF+vD+xH8MMIwApgJK86?=
 =?us-ascii?Q?U+u2O2QhSXhPNllVJmmvZO/035vwLC9GfKLR20XEE9wAeuUO+Tramh3VCo64?=
 =?us-ascii?Q?RqukEK99DnO+3oD4tafTrtisR74737yO0xdYqDvumiHAEItoORH8sBTPOnLb?=
 =?us-ascii?Q?Atxr7RZ9xXYTQ96F9mLosLqoipgrNAjEwt0AVVSxNcXrHrJdmsm+qvzU0rdQ?=
 =?us-ascii?Q?BBoZjta8HKhJUfHSzVPLxR+iotGKRiVYM6blEr5BnO2usQGMWEEf/ylGosw1?=
 =?us-ascii?Q?XkwIWhlzdHJpQqAmkofVfIA4QxKbL/AvENrySeiWZ8fmxvhbHym1M30BrBVf?=
 =?us-ascii?Q?6I6FOGmuJ48mFZBUCBc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:48:54.8476 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d1bee2-6a05-4422-d674-08de4ec50bfc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5637
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
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 2b691452775bc..fa235b981c2e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -2291,25 +2291,31 @@ static void gfx_v7_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32_t flags)
 static int gfx_v7_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	uint32_t tmp = 0;
 	long r;
 
 	WREG32(mmSCRATCH_REG0, 0xCAFEDEAD);
-	memset(&ib, 0, sizeof(ib));
-	r = amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIRECT, &ib);
+
+	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_GFX_RING_TEST);
 	if (r)
 		return r;
 
-	ib.ptr[0] = PACKET3(PACKET3_SET_UCONFIG_REG, 1);
-	ib.ptr[1] = mmSCRATCH_REG0 - PACKET3_SET_UCONFIG_REG_START;
-	ib.ptr[2] = 0xDEADBEEF;
-	ib.length_dw = 3;
+	ib = &job->ibs[0];
+	ib->ptr[0] = PACKET3(PACKET3_SET_UCONFIG_REG, 1);
+	ib->ptr[1] = mmSCRATCH_REG0 - PACKET3_SET_UCONFIG_REG_START;
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
@@ -2325,7 +2331,6 @@ static int gfx_v7_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 error:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 	return r;
 }
-- 
2.52.0

