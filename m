Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B519FC04FFE
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 15:12:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAAD2112D11;
	Mon, 29 Apr 2024 15:12:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hB6tpkEr";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2065.outbound.protection.outlook.com [40.107.95.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DB0210E9FC
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 15:12:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GbxFIwjbXtRp6Kyskwfw4CVqUva9kmEbZR7ZLhLh0n8uRoGa7yseVkemo8Y9OYdvYYkJJ98JW0nihk1l592RdNu8b/nlvr9S7OW+4z2/zOIam7V5vt3N1kI8rB6iMWC/FcvJovLCyXDBv3EOHqIi2WZ83oG3NWlTxoqMIpwZ0ZG6ZVavJ17/xXwCwQFGmb++1ivgPFHbNTkmHFAr6t6zD2RGwBuoGtaOEL/cero1dGI+JN2hRZ8AmFD6CM88TCPohj/k3z7RIAOhq0XsWfHEJj1A605Bzax17dckuuFRWEuIeRSemx2Ods3aEdraukGgS17fg5KG4pD+Tw23uqfTmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JumqnqN1vDrDH47aJSoV5eDukXKtVpBaqeYq5aVR6w=;
 b=RaA0AiiCqJLqaPvVgKJa66kJ0F4wbfe9m5LoaYxcsWZYbO3M4wtx5TMr7LhXAKniR815g+RAhSpKVKpHAil7oeSUte5/PRqngTC6Pe6j6k93IQ6+ky48udkdPB/DNODPwRB8rWcBs13lE9gWOfFNekdQh4NFEbPYJZkt/bj4HSW0lD+Ynih2PU8nATrdn1ojy9jwsqf+PR7wzHRqxw6rD1KrfR50LrrDwMkyi5u8B0I0wP20fy2eSDM4SwWeMYp5tTITK+zCTqE/9H3c8leFIcApVXxUHgxU/JBpNa7E7Y5fL4BcRaQbbT7dxXLtMHPaWDOWecMdDAHgIpFqGPBoyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JumqnqN1vDrDH47aJSoV5eDukXKtVpBaqeYq5aVR6w=;
 b=hB6tpkEr+VLz08E+9SDJuloMJHhS+fMWZKnNEokS834OloeHN/Zj8nz1ZPIkBCsfT+pywNJgyogOvjbMFwYUhsvE5NfLioYXFgOnBBccj1/pyMsW/9GPt8iMA4VND0Y+bxz3OkLQbaXwmvjQ6JYI8jSHqZATuIVTOkAigw1LE6w=
Received: from BL1PR13CA0195.namprd13.prod.outlook.com (2603:10b6:208:2be::20)
 by CY8PR12MB8337.namprd12.prod.outlook.com (2603:10b6:930:7d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Mon, 29 Apr
 2024 15:12:40 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:2be:cafe::2e) by BL1PR13CA0195.outlook.office365.com
 (2603:10b6:208:2be::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.22 via Frontend
 Transport; Mon, 29 Apr 2024 15:12:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 15:12:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 10:12:37 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jack Xiao <Jack.Xiao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 05/11] drm/amdgpu/gfx: enable mes to map legacy queue support
Date: Mon, 29 Apr 2024 11:12:13 -0400
Message-ID: <20240429151219.3466531-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429151219.3466531-1-alexander.deucher@amd.com>
References: <20240429151219.3466531-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|CY8PR12MB8337:EE_
X-MS-Office365-Filtering-Correlation-Id: cb032607-218d-4d57-5f88-08dc685ecfa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|82310400014|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?78cVjuoJ/UOnQ6N6KT2QZF1MDkhG+ZzMXu+FnKPIxi/SeXbpq7vTY9zfs4hK?=
 =?us-ascii?Q?ptqwXh7ani/zZ2OdIl0BEEZ0QmFk0EVR1zFY5/fAVMzYTBY2PVmnDYCHh0yA?=
 =?us-ascii?Q?NPxX0JHDQqtv+2h0aSqzvsfLOBHCaD0lRtckcZh0pcU9J+2gnD6K5nySjz1b?=
 =?us-ascii?Q?+vkMNbtmJQCcZWLOIq25Jmtm6xCf/jrPtlWh+5RevUaRjLw/642rnjwOOiuq?=
 =?us-ascii?Q?nUNY9bgvyGsdpIpExP6X2vE9qqjilIYGPjXeIAlDICFpDWeyus8FcFHYMFPD?=
 =?us-ascii?Q?FczTorf0yewqBucoXPXqYVVi/6be7R/OzGaFUrXlRBbOAiQijmBSObbyFH5K?=
 =?us-ascii?Q?8JzmyWZ4L1xQYcztvbKASAPK6F7oPNtZGuF0NL1/modt6o2b/TFGHJQXB46g?=
 =?us-ascii?Q?Goy1f+3DwqOl8wzLBqFXxTJhrIcln0MsA/+7QM16pcwpFMdEEzQ9O4Oq+rt0?=
 =?us-ascii?Q?VDQI5PYgrMC/Y1zHna9ZV0X/2Sqff3/Sa6YvQZN/7l/O1NFeM1wV3sdfus6n?=
 =?us-ascii?Q?qE9T8DYjkHf1WqzehTV3jbIHrJXwoXFtRgcKE10ynZ6XC3vlcyDUhQfTSjd1?=
 =?us-ascii?Q?egVP3Opnf/3AC/0bBoD61V1Cu5VMqOFLSVh33nE5TWR81dhLc2z2YrXczIYv?=
 =?us-ascii?Q?VZhcANhuvyn9BiRotNNb4uoAAI0ejMPO16YvpcPlmhl7t70gAmyQ2UcN8vhC?=
 =?us-ascii?Q?jo6fNxokRn4cZVi+cdjzORM5auAjaq4/qKCchEOy6FKH0D3/V2bryU5JxeTK?=
 =?us-ascii?Q?j3+Vo9NNxqa4qaL4kx66xxxH6U3wGJUAUhXa8FKTWY4Rc8MzkT+VBLhgJW47?=
 =?us-ascii?Q?8q1UkSZdWt29BVMOxZ/OCfb0pIwtC5YAV59+s5jvCz1gzjBQhvRRQjWed8dH?=
 =?us-ascii?Q?89sugepPXtMnVsa1ctAaDh9q+6Fd8R+6GvGf1RC4vf41YeB2uJ+JMStQ+FRz?=
 =?us-ascii?Q?Djq6U9Wd4IPlnWEqwBR7ab+qoC9p9qcTxYnZhwEgjTxaKtt6Y9m2jjOOSpri?=
 =?us-ascii?Q?Jefr/iP3fPAleyXwenBhtEmwmwrwuhxfS85px3SUEkwZe4xGb2fRw4eGPcvR?=
 =?us-ascii?Q?BumjAfMKbLSqDcTsxCYMSNEDLX4kuXRnPrK3ReumFglXPlHloIMj+Q4rMGnG?=
 =?us-ascii?Q?CLB6guimQzqFqFEcrO2qQ4lo/3NWvHLfxqjegEdYn5Jx8WRS8Z71uZbWgedA?=
 =?us-ascii?Q?XRR3X8lstw+aeeHo62hVwrRjDTBjM8PMIgQ64iU3laJUj5DNcLCzWtYZQsTk?=
 =?us-ascii?Q?EPUXCKT8+8XWhV9cvshrUS7zpyFKev/pmCDIPoMg/WbtZS42clGkpOUuOFEv?=
 =?us-ascii?Q?OqxUcKsFqssflFSgYVdM08SYNPWvJXXg+SiuzLaNN8BPBfJTVul1Y3HjoTu0?=
 =?us-ascii?Q?1o2DWTo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 15:12:39.8206 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb032607-218d-4d57-5f88-08dc685ecfa6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8337
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

From: Jack Xiao <Jack.Xiao@amd.com>

Enable mes to map legacy queue support.

v2: drop unused gfx_v12_0_kiq_enable_kgq() (Alex)

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 39 +++++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 25 ++--------------
 2 files changed, 36 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 1d955652f3ba6..8e7cc44143857 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -623,10 +623,28 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev, int xcc_id)
 		queue_mask |= (1ull << amdgpu_queue_mask_bit_to_set_resource_bit(adev, i));
 	}
 
-	DRM_INFO("kiq ring mec %d pipe %d q %d\n", kiq_ring->me, kiq_ring->pipe,
-							kiq_ring->queue);
 	amdgpu_device_flush_hdp(adev, NULL);
 
+	if (adev->enable_mes)
+		queue_mask = ~0ULL;
+
+	if (adev->enable_uni_mes) {
+		for (i = 0; i < adev->gfx.num_compute_rings; i++) {
+			j = i + xcc_id * adev->gfx.num_compute_rings;
+			r = amdgpu_mes_map_legacy_queue(adev,
+							&adev->gfx.compute_ring[j]);
+			if (r) {
+				DRM_ERROR("failed to map compute queue\n");
+				return r;
+			}
+		}
+
+		return 0;
+	}
+
+	DRM_INFO("kiq ring mec %d pipe %d q %d\n", kiq_ring->me, kiq_ring->pipe,
+		 kiq_ring->queue);
+
 	spin_lock(&kiq->ring_lock);
 	r = amdgpu_ring_alloc(kiq_ring, kiq->pmf->map_queues_size *
 					adev->gfx.num_compute_rings +
@@ -637,9 +655,6 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev, int xcc_id)
 		return r;
 	}
 
-	if (adev->enable_mes)
-		queue_mask = ~0ULL;
-
 	kiq->pmf->kiq_set_resources(kiq_ring, queue_mask);
 	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
 		j = i + xcc_id * adev->gfx.num_compute_rings;
@@ -666,6 +681,20 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev, int xcc_id)
 
 	amdgpu_device_flush_hdp(adev, NULL);
 
+	if (adev->enable_uni_mes) {
+		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
+			j = i + xcc_id * adev->gfx.num_gfx_rings;
+			r = amdgpu_mes_map_legacy_queue(adev,
+							&adev->gfx.gfx_ring[j]);
+			if (r) {
+				DRM_ERROR("failed to map gfx queue\n");
+				return r;
+			}
+		}
+
+		return 0;
+	}
+
 	spin_lock(&kiq->ring_lock);
 	/* No need to map kcq on the slave */
 	if (amdgpu_gfx_is_master_xcc(adev, xcc_id)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 51955a4e47d59..3e2a6806f1c19 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -2707,28 +2707,6 @@ static int gfx_v12_0_gfx_init_queue(struct amdgpu_ring *ring)
 	return 0;
 }
 
-static int gfx_v12_0_kiq_enable_kgq(struct amdgpu_device *adev)
-{
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
-	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[0].ring;
-	int r, i;
-
-	if (!kiq->pmf || !kiq->pmf->kiq_map_queues)
-		return -EINVAL;
-
-	r = amdgpu_ring_alloc(kiq_ring, kiq->pmf->map_queues_size *
-					adev->gfx.num_gfx_rings);
-	if (r) {
-		DRM_ERROR("Failed to lock KIQ (%d).\n", r);
-		return r;
-	}
-
-	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
-		kiq->pmf->kiq_map_queues(kiq_ring, &adev->gfx.gfx_ring[i]);
-
-	return amdgpu_ring_test_helper(kiq_ring);
-}
-
 static int gfx_v12_0_cp_async_gfx_ring_resume(struct amdgpu_device *adev)
 {
 	int r, i;
@@ -2751,7 +2729,8 @@ static int gfx_v12_0_cp_async_gfx_ring_resume(struct amdgpu_device *adev)
 		if (r)
 			goto done;
 	}
-	r = gfx_v12_0_kiq_enable_kgq(adev);
+
+	r = amdgpu_gfx_enable_kgq(adev, 0);
 	if (r)
 		goto done;
 
-- 
2.44.0

