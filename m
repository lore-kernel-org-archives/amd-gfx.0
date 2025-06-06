Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30CFEC5B559
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 06:44:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA87710E84B;
	Fri,  6 Jun 2025 06:44:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3606I2Ix";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B12310EA02
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 06:44:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZEQV0iyybeFjdrmzrIUSNh7B46zwoLbAm5PNOnVjCHP94nS/MupznKO+XaV3JreL/NySeHEEGZqmToIWFf4y4WYuLTX1KymRaOxIobDxVWQg4ruqTAnDV/+buU8eb11FmHvDJ5zVWtmbzi7uyoq/bFUuftkfsD3ff1B0AFW8UH81AnHqrbI7MjZdGMloZJL8mW26IYzRMpTPZyyQ9rUCv013A2rgEyUtXHrHAiuz3BHeoTZMkgiiebYydsEctZdyk7we0i/DJ9qnU3NsUC8KaaQtqGKbVWl7/h24koOkpMpx5W0GwvASSqDgf9lh2u7JCTq1XuANRG9LC1GXcIDlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gBQFXijR3wfegJbySjh+jdf6WJe67Br5JVCKmSK1cg=;
 b=UfFoGudL36NUCEb7o/PN93vLAlxSxK9pMsZYFUq4A6zd1ARDyA1mUOsr2JkOk+JhQfL0exkFIb8E+ZsoVlaWl3XSjqMNr7o+MoNsVJ95xjCKT9VJ+gmS5v3uD4cynNn+gGWjjXZvCK+3ucdIYVk8Mqf12M72zrwC4E8CHR3oE7Fr/eRmeEpevS7pGYPs+TxK77F3Fa+Zzp7i5sLU22CDZMScNxYyXd5b9uYGeBD5rOor+FnbNo8YvtW3dE3lJaUnQ8Pg/GpGGJAiHLCH+lxHs4FOWmVT7/3ULxKnv3CMtGOFAmQJd/6BAhgvFVg0+mXVMix9yezcNTr5D3uigcIpwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gBQFXijR3wfegJbySjh+jdf6WJe67Br5JVCKmSK1cg=;
 b=3606I2Ixi/451TJLUhwiIQ/Aw7DBMsN6TcrN+Fd0692aFGae8Z0Q9WxtjE5bts4O5wxinkfHPZtU/vRDqAHBXpAsq6Lpnu0B7zCpGpJQ4ACs1eX7tEXgAo+0q56Vngl2TcQJqt+cs/+hcwxugoeYrbARPNEMVfMJvWa9xElUVBw=
Received: from SJ0PR05CA0066.namprd05.prod.outlook.com (2603:10b6:a03:332::11)
 by IA1PR12MB6529.namprd12.prod.outlook.com (2603:10b6:208:3a6::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.35; Fri, 6 Jun
 2025 06:44:15 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::60) by SJ0PR05CA0066.outlook.office365.com
 (2603:10b6:a03:332::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.17 via Frontend Transport; Fri,
 6 Jun 2025 06:44:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Fri, 6 Jun 2025 06:44:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Jun
 2025 01:44:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 06/29] drm/amdgpu: update ring reset function signature
Date: Fri, 6 Jun 2025 02:43:31 -0400
Message-ID: <20250606064354.5858-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606064354.5858-1-alexander.deucher@amd.com>
References: <20250606064354.5858-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|IA1PR12MB6529:EE_
X-MS-Office365-Filtering-Correlation-Id: 01be61ac-b179-4ae3-cc16-08dda4c58d66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/Y/rd3ON8CRYMO8QCWp6MlSokd1sVhBktbydS7mvug8VIUf1TUAh/tAzNOCp?=
 =?us-ascii?Q?FyOMsmS87EPmavjtK7h7kPLwlE1eGrgsZdHi2yhYVAMwYlhZdS/ZnKFXQMhX?=
 =?us-ascii?Q?NQ6kYynpQOvytoumrnkrQvjr1FAy+bPbtbgCyzR3uJ923v+ovio//UM0+1RR?=
 =?us-ascii?Q?Q+Dn35RPauAafVucuTHMhJ0gd9z5Wo116XFIa6z6KAPBmIDx4Iu7Zjw3p3gZ?=
 =?us-ascii?Q?3Y8n5oryKU3TE7h4kEafKOfWD1gfbLSxRQ9Md5dtwtLiJ9MimoNLToMVEF0h?=
 =?us-ascii?Q?a5DmPqO0JWzU7PnEUEaf37z4VgjNZgH8TXFnLunqrvyutZPzmCw6+7KfxHvS?=
 =?us-ascii?Q?57bgH18nUDED4UEBT+MLLr7h0fdiyAhwCAMPvzojhw30Qrzq/UXKhrzTu4Wu?=
 =?us-ascii?Q?RdbfsjaHtCQtMeFB3lKw49ZknF89ENUF6sKPPiwrwKJswFlseWsM8VoM9GfN?=
 =?us-ascii?Q?NcLJfvTpbLDiLY5yokkx+loyAyKe+8d30K9gJNRh+A0bfbwDy9Ua+3s4Y4I3?=
 =?us-ascii?Q?XY75w3a6RRXvmWbUMJbV6AGnFic4UI1SwRLjSgC8Z9OUFS0DPguXkrmsTXHB?=
 =?us-ascii?Q?cys0vZbmS2JEytsU5b4isj4aHG4o3OPeQKZghlGlZdzIML1HOVE/c/bB3opn?=
 =?us-ascii?Q?O5/GP+Mu/w/yqxLI1OYTF5Ytn41cauFvyExPjyKok3rqN0KIjKiHHVZ43Sol?=
 =?us-ascii?Q?0fmykhLmrZqQ3iPzWG7iiyeGK3s+eDlcUaVnpUE+R7co38MUP/tK5sGsuisP?=
 =?us-ascii?Q?OI7FcyUFNPqkDlAwYPtrB+sjw6S/ExoeZPvtCnN6ZoKTgAtv5SNNlHQlZIyK?=
 =?us-ascii?Q?KlsD0Sr5BsCtEGBJz9vglz3NZy+GhrWL0TSCKhfiCfUqfOqj/69t4pbMLm8N?=
 =?us-ascii?Q?X9NGCZAXciS0ytaU/OfxyeN8zvpD8+rBvmrJHtMCx0s92bzu9EJVu4dOUIQl?=
 =?us-ascii?Q?DnON3mT70ysfeAVNVDODlr6aQ3mJwl99IWCIMVZ9s1by55c5B09X/i/o62e9?=
 =?us-ascii?Q?0Qojaay8piwPxgh7kWv/heldw5xGFSS8IjA1gQQk7jr8bbU3hlBLH0JoEoeC?=
 =?us-ascii?Q?3pNsVaEjL+UARBYt/Y5ChNv0G1x34e/WK3B9Eog+MJZg15U4ENIeXaLW+3lR?=
 =?us-ascii?Q?Ea47cAinrfXokZLqPLSCzaKXuaYY94vJAyY1X1Y3cX2C71eAbQ0LIt17OF81?=
 =?us-ascii?Q?epEqjkOjDXx2fJnt4EKuUPlleAo/egTat3H2HXjxTVSAywfMqnFYJSMwlnJM?=
 =?us-ascii?Q?EmaNLI9ZCAOENVa+hRYmEnUOCZwFAkqhx+7heK0Uh3IEtVThto3hauT2sl+Q?=
 =?us-ascii?Q?f3QZo6BsDtGNyJdXxg/Fjm0dWR76MbU2EiP1SbTbdijd1mNL0Ekw5MlMn1/L?=
 =?us-ascii?Q?80lJvpUDPmzG98BeuFhl8AESzzauHuGYpsIsrsv99AoD+jzlpeY81oQNVJGW?=
 =?us-ascii?Q?AYh0Zi5gIZvRN06BNL/TKwsOeZHPXkByARoFurUJccyk1AQ8yr8Cht8/fyQU?=
 =?us-ascii?Q?SbCZZW7fsMgnWbU03/dwE44E4J81Z51Z8AZC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 06:44:14.3045 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01be61ac-b179-4ae3-cc16-08dda4c58d66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6529
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

Going forward, we'll need more than just the vmid.  Everything
we need in currently in the amdgpu job structure, so just
pass that in.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |  7 ++++---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 10 ++++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   | 10 ++++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  3 ++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  3 ++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  3 ++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  3 ++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  3 ++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c |  3 ++-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c |  3 ++-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |  3 ++-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   |  3 ++-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |  5 +++--
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   |  5 +++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    |  3 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  |  3 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  |  3 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  |  3 ++-
 22 files changed, 53 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index ddb9d3269357c..80d4dfebde24f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -155,7 +155,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		if (is_guilty)
 			dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
 
-		r = amdgpu_ring_reset(ring, job->vmid);
+		r = amdgpu_ring_reset(ring, job);
 		if (!r) {
 			if (amdgpu_ring_sched_ready(ring))
 				drm_sched_stop(&ring->sched, s_job);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index e1f25218943a4..ab5402d7ce9c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -268,7 +268,7 @@ struct amdgpu_ring_funcs {
 	void (*patch_cntl)(struct amdgpu_ring *ring, unsigned offset);
 	void (*patch_ce)(struct amdgpu_ring *ring, unsigned offset);
 	void (*patch_de)(struct amdgpu_ring *ring, unsigned offset);
-	int (*reset)(struct amdgpu_ring *ring, unsigned int vmid);
+	int (*reset)(struct amdgpu_ring *ring, struct amdgpu_job *job);
 	void (*emit_cleaner_shader)(struct amdgpu_ring *ring);
 	bool (*is_guilty)(struct amdgpu_ring *ring);
 };
@@ -425,7 +425,7 @@ struct amdgpu_ring {
 #define amdgpu_ring_patch_cntl(r, o) ((r)->funcs->patch_cntl((r), (o)))
 #define amdgpu_ring_patch_ce(r, o) ((r)->funcs->patch_ce((r), (o)))
 #define amdgpu_ring_patch_de(r, o) ((r)->funcs->patch_de((r), (o)))
-#define amdgpu_ring_reset(r, v) (r)->funcs->reset((r), (v))
+#define amdgpu_ring_reset(r, j) (r)->funcs->reset((r), (j))
 
 unsigned int amdgpu_ring_max_ibs(enum amdgpu_ring_type type);
 int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned ndw);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 75ea071744eb5..c58e7040c732a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9522,7 +9522,8 @@ static void gfx_v10_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_nop)
 	amdgpu_ring_insert_nop(ring, num_nop - 1);
 }
 
-static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
+static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
+			       struct amdgpu_job *job)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
@@ -9547,7 +9548,7 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 
 	addr = amdgpu_bo_gpu_offset(ring->mqd_obj) +
 		offsetof(struct v10_gfx_mqd, cp_gfx_hqd_active);
-	tmp = REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << vmid);
+	tmp = REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << job->vmid);
 	if (ring->pipe == 0)
 		tmp = REG_SET_FIELD(tmp, CP_VMID_RESET, PIPE0_QUEUES, 1 << ring->queue);
 	else
@@ -9579,7 +9580,7 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 }
 
 static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
-			       unsigned int vmid)
+			       struct amdgpu_job *job)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index afd6d59164bfa..0ee7bdd509741 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6806,7 +6806,8 @@ static int gfx_v11_reset_gfx_pipe(struct amdgpu_ring *ring)
 	return 0;
 }
 
-static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
+static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
+			       struct amdgpu_job *job)
 {
 	struct amdgpu_device *adev = ring->adev;
 	int r;
@@ -6814,7 +6815,7 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
-	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false);
+	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, job->vmid, false);
 	if (r) {
 
 		dev_warn(adev->dev, "reset via MES failed and try pipe reset %d\n", r);
@@ -6968,7 +6969,8 @@ static int gfx_v11_0_reset_compute_pipe(struct amdgpu_ring *ring)
 	return 0;
 }
 
-static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
+static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
+			       struct amdgpu_job *job)
 {
 	struct amdgpu_device *adev = ring->adev;
 	int r = 0;
@@ -6976,7 +6978,7 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
-	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true);
+	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, job->vmid, true);
 	if (r) {
 		dev_warn(adev->dev, "fail(%d) to reset kcq and try pipe reset\n", r);
 		r = gfx_v11_0_reset_compute_pipe(ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 1234c8d64e20d..a26417d53411b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5307,7 +5307,8 @@ static int gfx_v12_reset_gfx_pipe(struct amdgpu_ring *ring)
 	return 0;
 }
 
-static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
+static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
+			       struct amdgpu_job *job)
 {
 	struct amdgpu_device *adev = ring->adev;
 	int r;
@@ -5315,7 +5316,7 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
-	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false);
+	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, job->vmid, false);
 	if (r) {
 		dev_warn(adev->dev, "reset via MES failed and try pipe reset %d\n", r);
 		r = gfx_v12_reset_gfx_pipe(ring);
@@ -5421,7 +5422,8 @@ static int gfx_v12_0_reset_compute_pipe(struct amdgpu_ring *ring)
 	return 0;
 }
 
-static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
+static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
+			       struct amdgpu_job *job)
 {
 	struct amdgpu_device *adev = ring->adev;
 	int r;
@@ -5429,7 +5431,7 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
-	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true);
+	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, job->vmid, true);
 	if (r) {
 		dev_warn(adev->dev, "fail(%d) to reset kcq  and try pipe reset\n", r);
 		r = gfx_v12_0_reset_compute_pipe(ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index d50e125fd3e0d..5e650cc5fcb26 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7153,7 +7153,7 @@ static void gfx_v9_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_nop)
 }
 
 static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
-			      unsigned int vmid)
+			      struct amdgpu_job *job)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index c233edf605694..a7dadff3dca31 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3552,7 +3552,7 @@ static int gfx_v9_4_3_reset_hw_pipe(struct amdgpu_ring *ring)
 }
 
 static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
-				unsigned int vmid)
+				struct amdgpu_job *job)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[ring->xcc_id];
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 4cde8a8bcc837..6cd3fbe00d6b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -764,7 +764,8 @@ static int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring,
+				struct amdgpu_job *job)
 {
 	jpeg_v2_0_stop(ring->adev);
 	jpeg_v2_0_start(ring->adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 8b39e114f3be1..8ed41868f6c32 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -643,7 +643,8 @@ static int jpeg_v2_5_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring,
+				struct amdgpu_job *job)
 {
 	jpeg_v2_5_stop_inst(ring->adev, ring->me);
 	jpeg_v2_5_start_inst(ring->adev, ring->me);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 2f8510c2986b9..3512fbb543301 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -555,7 +555,8 @@ static int jpeg_v3_0_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring,
+				struct amdgpu_job *job)
 {
 	jpeg_v3_0_stop(ring->adev);
 	jpeg_v3_0_start(ring->adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index f17ec5414fd69..c8efeaf0a2a69 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -720,7 +720,8 @@ static int jpeg_v4_0_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring,
+				struct amdgpu_job *job)
 {
 	if (amdgpu_sriov_vf(ring->adev))
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 79e342d5ab28d..8b07c3651c579 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -1143,7 +1143,8 @@ static void jpeg_v4_0_3_core_stall_reset(struct amdgpu_ring *ring)
 	WREG32_SOC15(JPEG, jpeg_inst, regJPEG_CORE_RST_CTRL, 0x00);
 }
 
-static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring,
+				  struct amdgpu_job *job)
 {
 	if (amdgpu_sriov_vf(ring->adev))
 		return -EOPNOTSUPP;
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index 3b6f65a256464..0a21a13e19360 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -834,7 +834,8 @@ static void jpeg_v5_0_1_core_stall_reset(struct amdgpu_ring *ring)
 	WREG32_SOC15(JPEG, jpeg_inst, regJPEG_CORE_RST_CTRL, 0x00);
 }
 
-static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring,
+				  struct amdgpu_job *job)
 {
 	if (amdgpu_sriov_vf(ring->adev))
 		return -EOPNOTSUPP;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 9c169112a5e7b..ffd67d51b335f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1667,7 +1667,8 @@ static bool sdma_v4_4_2_page_ring_is_guilty(struct amdgpu_ring *ring)
 	return sdma_v4_4_2_is_queue_selected(adev, instance_id, true);
 }
 
-static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
+static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
+				   struct amdgpu_job *job)
 {
 	struct amdgpu_device *adev = ring->adev;
 	u32 id = GET_INST(SDMA0, ring->me);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 9505ae96fbecc..46affee1c2da0 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1538,7 +1538,8 @@ static int sdma_v5_0_soft_reset(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
+static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring,
+				 struct amdgpu_job *job)
 {
 	struct amdgpu_device *adev = ring->adev;
 	u32 inst_id = ring->me;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index a6e612b4a8928..581e75b7d01a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1451,7 +1451,8 @@ static int sdma_v5_2_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return -ETIMEDOUT;
 }
 
-static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
+static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring,
+				 struct amdgpu_job *job)
 {
 	struct amdgpu_device *adev = ring->adev;
 	u32 inst_id = ring->me;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 5a70ae17be04e..d9866009edbfc 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1537,7 +1537,8 @@ static int sdma_v6_0_ring_preempt_ib(struct amdgpu_ring *ring)
 	return r;
 }
 
-static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
+static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
+				 struct amdgpu_job *job)
 {
 	struct amdgpu_device *adev = ring->adev;
 	int i, r;
@@ -1555,7 +1556,7 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 		return -EINVAL;
 	}
 
-	r = amdgpu_mes_reset_legacy_queue(adev, ring, vmid, true);
+	r = amdgpu_mes_reset_legacy_queue(adev, ring, job->vmid, true);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index ad47d0bdf7775..c546e73642296 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -802,7 +802,8 @@ static bool sdma_v7_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
 	return false;
 }
 
-static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
+static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
+				 struct amdgpu_job *job)
 {
 	struct amdgpu_device *adev = ring->adev;
 	int i, r;
@@ -820,7 +821,7 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 		return -EINVAL;
 	}
 
-	r = amdgpu_mes_reset_legacy_queue(adev, ring, vmid, true);
+	r = amdgpu_mes_reset_legacy_queue(adev, ring, job->vmid, true);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index b5071f77f78d2..47a0deceff433 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1967,7 +1967,8 @@ static int vcn_v4_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
 	return 0;
 }
 
-static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring,
+			       struct amdgpu_job *job)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 5a33140f57235..d961a824d2098 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1594,7 +1594,8 @@ static void vcn_v4_0_3_unified_ring_set_wptr(struct amdgpu_ring *ring)
 	}
 }
 
-static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
+				 struct amdgpu_job *job)
 {
 	int r = 0;
 	int vcn_inst;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 16ade84facc78..10bd714592278 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1465,7 +1465,8 @@ static void vcn_v4_0_5_unified_ring_set_wptr(struct amdgpu_ring *ring)
 	}
 }
 
-static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring,
+				 struct amdgpu_job *job)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index f8e3f0b882da5..7e6a7ead9a086 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1192,7 +1192,8 @@ static void vcn_v5_0_0_unified_ring_set_wptr(struct amdgpu_ring *ring)
 	}
 }
 
-static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring,
+				 struct amdgpu_job *job)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
-- 
2.49.0

