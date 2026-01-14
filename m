Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E69A3D38FEE
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 16:48:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FFA010E64F;
	Wed, 14 Jan 2026 16:48:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o6qzlJs3";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010045.outbound.protection.outlook.com [52.101.56.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3ED510E64F
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 16:48:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RwxU0q30ib3DMaCTVTuhKJPIArrVoRnb4iA3mo+IBuusmKU+nxOxQoMUBZEZ3MFTamXi+9rU0fp4KS97jKe2GrjB7zMKd9Gseor8d7nEJmnO2/zz3QELrOh9M5TxMBPlA4LLxB2+w2s65iWV+RXLU7/+41QZv79XH1b7+Vpp/URdialbQ1CrBkvVI2jMdHygA0EUFBd5yrW7XazTYboQw6JVMsRk1Np5L6avJWYV92is9Eyde71STWTOATAPwydCtWO0wTWg8MRERDEJ4cfq8yn/PhQT08UyboPlgKSNXZn3ZX9soU7I4ouxx88/6JPIZ9Ite7hEhZaxZxgF2r00zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIbaSiUtry7zaqeyB3Sj8SNU6pn0dRA8QtY8zD9mM/w=;
 b=Qo9hFuippVKJbpI5UqorOrEjXy55beyuxoSoWEG3w/Kbde2XlYkvkCK+S4S/BFvFxUrzlUiztsf7wx2pp+ZbxIazuL8jd56hqksoUrl3bUGanLkxk0Yvud6hvlS7FyeFXL4u1rbVQojIPWz1CHymK5Ud1nQz9iZiwjluSIKi765vVp2TsDkes4fcxjw4Xhg7+RQFxJnZciqUHDLjNqQdkX4MZu8InFP75ZJRSgdIax/XIPVnuvOdTZ5cNrNjR4yqwl05RbBnHB6OiVmAfB7OzxvtV7N5FBflzRdDmP31FqjmBxiV76YT+JlwDjx4X1aW2VNBGaX39DTHUVQeKdLhRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIbaSiUtry7zaqeyB3Sj8SNU6pn0dRA8QtY8zD9mM/w=;
 b=o6qzlJs3Luj/1xXh71THAQ6voXE8ISet+RXVuhrTG0fyPi+fLsTua8Th/wXE7WUppHjZ1ZNKyM0J/gY0Gz+Uldgomxqhu1E7Q2Thq23YBGbB9KZ7wnbhrJTOnk+KB1TGFKwERddLlmp6qkz9sU3bVtcS0Ss515YjYB8i9svg8Pk=
Received: from PH8PR02CA0001.namprd02.prod.outlook.com (2603:10b6:510:2d0::19)
 by CY8PR12MB8411.namprd12.prod.outlook.com (2603:10b6:930:6e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 16:48:06 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:510:2d0:cafe::b4) by PH8PR02CA0001.outlook.office365.com
 (2603:10b6:510:2d0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Wed,
 14 Jan 2026 16:48:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:48:04 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 10:47:42 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 08:47:41 -0800
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 10:47:41 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 12/42] drm/amdgpu/gfx12.1: switch to using job for IBs
Date: Wed, 14 Jan 2026 11:46:57 -0500
Message-ID: <20260114164727.15367-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114164727.15367-1-alexander.deucher@amd.com>
References: <20260114164727.15367-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|CY8PR12MB8411:EE_
X-MS-Office365-Filtering-Correlation-Id: 698d765f-61ef-411c-bb85-08de538cb03f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YiFqWkE7UTwf5CwXwGZ+ana4tB4TX/7zuxRI1Qw+9m2Js6lTTQJMl6YiJwFd?=
 =?us-ascii?Q?lOaHGQsrrzSuc+YRzBItSpCI57fBub3CY2fsXeY/HdFyDKtAnheR8Q2SXKeM?=
 =?us-ascii?Q?t2Q13CZb0vTRvUq4ebDKGfjYm8o2RamVFvlaJAV5OA0TY5taV/6nzm0X6+DZ?=
 =?us-ascii?Q?TpcPT8F9ZDG33UeDdxMaTYqoD/EyBI687lolb324KvAfw5/BfgqoITYqt85A?=
 =?us-ascii?Q?7jkPHuJzzzldJ7KPYnPPteoIn70L3aRlGGhrysJEzsJTBrV02EM85aLqBKJO?=
 =?us-ascii?Q?O0ASL3yKLx1lb+e+vuqvJ08z0mBDWoi8Qy6u4SfwcmIqjp3a3uL0hoSahqBM?=
 =?us-ascii?Q?gBS91D4tNHnfqAxBGOT3VuOhTtaQzwqjTwv72gdnSKPNEJvrbuRwD6Dyt6DR?=
 =?us-ascii?Q?VtCKck29uBFWjV4psCrAB6+Au9bksMe5W0yY4ubOsXztklUQ4bupLa6wf+8p?=
 =?us-ascii?Q?9uJQZx+QXmgg5PpYgM1v5wUZ01IUkUlCvFDSuvUmT/V7XP1c3is2F/H28Ny6?=
 =?us-ascii?Q?2EejadWFvDP4JmTKTnE24FG2AZ1/7U+9Im6Qcj4z3ynhr/m1VPrJ/renCQBX?=
 =?us-ascii?Q?pYsK9OvNxSuQeSepW6VXh4mNmv1kkmpout5imTWGBUJrH8trGYWCJAJIymcj?=
 =?us-ascii?Q?MatFTwQ1yHI8hD7clfvydGtvQ8N7mAjjgOPKfjK/5yajbGgrYlGfuaoA+jr4?=
 =?us-ascii?Q?7dUxEI8qIzcjQNKygyx+duTFUHqY4D0D8b+WdL0nykKQUqQC5AqVchtcCHD6?=
 =?us-ascii?Q?5ewmMQZv/9AkSB6F7zxLEA4lB+fQbYN6+/DV/BtqDlh616xJVxB818BCvu0P?=
 =?us-ascii?Q?ZFdVuOQBeDV81f9MdmX9fs1kdAlWAY2AmM5JnHkvZ3kcUljdFqQgqewggDkw?=
 =?us-ascii?Q?0ViLY59y55f7rBXOPN/LixFNoXa52mpvDdIjEC3H80j0E2IZu2X2suuuDN09?=
 =?us-ascii?Q?LkCP3dk2Wb0ZtaBCVPumJHIKFrqocfrsQ3zuhdf1PtPQjrVZXJanMdBsYNpe?=
 =?us-ascii?Q?YABj3q+hDPxRtDhgJnP0Nh2gE0kxiSkWmYTMm7OWdv7mNl4xEZtdjbl/wRkq?=
 =?us-ascii?Q?cScrUmqnZMUy71BHOtRmJkXoyl57C8tYkfttggyTpFmq/EYa3PJ8qcL4RGYo?=
 =?us-ascii?Q?WH1ypUV+4xKm7GrzNz4g7GpHsAUFsrPDNeOkrpazJhCXzF+bEtwjUjox904R?=
 =?us-ascii?Q?xBH8Ugyr4YpRdzGRdkIVctdFXJJ1nRhwukBn33ISH4AhGRXecivIv4gPY3dC?=
 =?us-ascii?Q?R+V10z9KnyvJ58UOw+/k5zphMIGnD8f1rp76DfjQINe0hW90po+CXJ44mqdo?=
 =?us-ascii?Q?O0hiA/aIugHTHMvm3HNBWcGJN5bcnuKOsymk8xQ13WGSykzELGww6YkonwwR?=
 =?us-ascii?Q?LhC6wFd2HPtZ5yDDjZa1YX/msVU0BnauFDbNdmv0G8H0EzAvT03BwdVYLI1+?=
 =?us-ascii?Q?AlNlptNkyIDLqyqV2MvpJOBoNM8ScKmxO+7eeD1Vw04fChB85B9LBc0rcV1I?=
 =?us-ascii?Q?bG6AuCA2DD7xdTl9ycMcod6ARFe4AtNZNadfpDxABUCV6G86CVUlmiPK8m9N?=
 =?us-ascii?Q?atN6eEBH/XDuHn4MVBEBeP1lBqeiEaRqAssstLbIkPrT7pvsi6sSIvoKbUro?=
 =?us-ascii?Q?BKP6p1usSws5j7X60AnUYqRx55vhfLGrz9ofPP/k1PgFGpT3yw13dr4bEODW?=
 =?us-ascii?Q?l7R3Rw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:48:04.9844 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 698d765f-61ef-411c-bb85-08de538cb03f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8411
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
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 29 ++++++++++++++------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 86cc90a662965..7d02569cd4738 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -306,7 +306,8 @@ static int gfx_v12_1_ring_test_ring(struct amdgpu_ring *ring)
 static int gfx_v12_1_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	unsigned index;
 	uint64_t gpu_addr;
@@ -318,8 +319,6 @@ static int gfx_v12_1_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	    ring->funcs->type == AMDGPU_RING_TYPE_KIQ)
 		return 0;
 
-	memset(&ib, 0, sizeof(ib));
-
 	r = amdgpu_device_wb_get(adev, &index);
 	if (r)
 		return r;
@@ -328,22 +327,27 @@ static int gfx_v12_1_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	adev->wb.wb[index] = cpu_to_le32(0xCAFEDEAD);
 	cpu_ptr = &adev->wb.wb[index];
 
-	r = amdgpu_ib_get(adev, NULL, 16, AMDGPU_IB_POOL_DIRECT, &ib);
+	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 16,
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_GFX_RING_TEST);
 	if (r) {
 		dev_err(adev->dev, "amdgpu: failed to get ib (%ld).\n", r);
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
@@ -358,7 +362,6 @@ static int gfx_v12_1_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	else
 		r = -EINVAL;
 err2:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err1:
 	amdgpu_device_wb_free(adev, index);
-- 
2.52.0

