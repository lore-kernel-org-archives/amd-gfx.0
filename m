Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DEC2C52CD8
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:01:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34EF310E851;
	Thu, 25 Jul 2024 15:01:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XuDpFlCE";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04EB610E850
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:01:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wSjeAwvQVGund+cFELh+axH59NBmSV5Geq8T2MJgq+iJTvgvjL5VY+Czd7iPVZ/uu2/8TaRTFChw/xlOKWDiBP0u4EL7a32+JDbYoABAitgQ+OKZEFZAS/KhvvVHOKl58zQvT6PAPqhydWtSVmrBOM7Gkucu+DClbXFEYJGPb03WYLyUPRrsv5JNjjVaKNh07zNcnlJ7NX76zpNO6S3OQd1QlWklEDT3xBFAOoc/WuFF+o2gCWRf8YRXdSL3S5YcP5BnGTjsVKDywLeIqTmjgozBRvhLqfWeYWEpHcrwZEazQhPDa6RtFDp/2iRG0wacKCIXDypIeEUUSTL6MtTSsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QEJV0YC8ur0ZjNJT/hYbKhC207yNLUWxjBhZyipwlgI=;
 b=vAqYVKI1MatT8bqmErdszC8wgo0vPuiiMJWzDzYO4tK+qOqXx3gtg/TbT6kpaxRAz8oMcfKjpitJGFkgdTMaKwVGpG1zoRZAmho+FnX44Y+FDh3bShFB8Ly+Cvz27w0v936+uF/lP236XcknQ+xCMvLdCLu+XJp+CW23UNcpSUwu4s9S47FhG8ZdVTjlfkKxCg+qu0+whk6u9FHNAdwGdCHXRbPyu8gd4nYYQwJY89j0bI2lt7L7UB87b/lT8juqh28J1K+FJz7YCW9CdyE2+qCOwWkhBVFNeTDl2A3GgXxz19ReigaFIyosXPc4mcPv1/inUD2jVgwDyOoPFbIGwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QEJV0YC8ur0ZjNJT/hYbKhC207yNLUWxjBhZyipwlgI=;
 b=XuDpFlCEl6OfxJenUrmdBgNwOjiPd5aSYCbkWpgHAAmTemds43pYGQrFXukSFhrUyBo7XiOA+kH23CwVYPMKM9VIuvnprLMsjVGPDLcFibPlkddHYexD2gcMqM4tXUEdsIBnEuF2h4RfyUeW8vAJuVFPTf056qdZ6Vh92RuR8p0=
Received: from PH7P220CA0117.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::34)
 by SJ2PR12MB8806.namprd12.prod.outlook.com (2603:10b6:a03:4d0::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Thu, 25 Jul
 2024 15:01:23 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:510:32d:cafe::cb) by PH7P220CA0117.outlook.office365.com
 (2603:10b6:510:32d::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28 via Frontend
 Transport; Thu, 25 Jul 2024 15:01:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 15:01:23 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 10:01:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 20/53] drm/amdgpu/gfx9: add ring reset callback
Date: Thu, 25 Jul 2024 11:00:22 -0400
Message-ID: <20240725150055.1991893-21-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725150055.1991893-1-alexander.deucher@amd.com>
References: <20240725150055.1991893-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|SJ2PR12MB8806:EE_
X-MS-Office365-Filtering-Correlation-Id: dd732716-d776-4ce6-b381-08dcacbaa64f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9FMe/0pyyXWIKooXznrGEfz9I4Kqzflo5eHlsM3u9FGyd/E8yw/xPv8Eq/OW?=
 =?us-ascii?Q?BZgZxUEhwb1er+ZcK4AO0jNkoRcVrU2rhmFjI3ZG8J+hkjTTGjA3lwXw91Ni?=
 =?us-ascii?Q?/5ZeCck8UxPGU9jXKPClZSeJMcqqTS7K7wEGxiwb4txj9TfDg4qZjhocdi7c?=
 =?us-ascii?Q?8qEuhbKEhKfS610mFqbQx34UR7zwD3befSONrt7oacB5BdSnAgtGPKMP2HKH?=
 =?us-ascii?Q?5aSKzucP3JWLGgDv90scwESV3l0aJ3sEXBxkRCZLTCjjA5E3pFyr8lbYyqkm?=
 =?us-ascii?Q?vZvEwil8BsZhXuXBnh/fC6TrbtGGVZOu/zuiPBq3XcJiJATN+RapW4R5/cK0?=
 =?us-ascii?Q?r3ilXX0r5xWLMVwodyasHEntKGatRU18Qc+Bq5cPxDR7GE/Obq6WtxDu1u0+?=
 =?us-ascii?Q?yDIYRxkXVDjF81KzmePA4kc6tmEnnDpxknOTsnmgLOfIcV6KDoCKVVruYGxS?=
 =?us-ascii?Q?AsppiIeOxvQF1+QksBmbKuvJLhDpBo4PmpxHDIY7022M6IMgoVNVzvuXlNVR?=
 =?us-ascii?Q?mBwXzPKNr02vEGkW3E7Zd76N/KmKGhFYPM0u2GolT3j6ufcn3iUpbBvAnl6r?=
 =?us-ascii?Q?H+5Qb9XvzLD+s6+Jaax40V3X4/oYg8knyJCV0oXnTONhcwFgtyNeC8yb2fr9?=
 =?us-ascii?Q?Rye4Qhw9PzuwcXF9EyQTeZdaSi6NxZBeQsogM4ix2N1MyaS7RD2PReUCzktO?=
 =?us-ascii?Q?EK2cFFaEnh+pTeryUZ42NH0qtJNo2lkE8vPv42kN+yU/z2Rkg0i0cmU4adJ7?=
 =?us-ascii?Q?hdkT5sqrEU9IkwuoOe9Iy+QxDcuWFafs9YzgNGwRO6CxQSsJgnb3duJRiOcK?=
 =?us-ascii?Q?66WqqD5uEU1+RI9nVzF3/GlF+4Z8DK2qQX6CV19p75FlwYuSVPeNRQznQj+k?=
 =?us-ascii?Q?phWVDa/YCQDwTkUvbuXbrc9fiV3OmE/4KYHHq67YC9m5AjSY4JSnAYxJ5fxO?=
 =?us-ascii?Q?qwdwYHKUN+ZgcljSW2M4643kmUk7LlkwUrzx7C4+A8FFLUnJjGEgHXLsI5L/?=
 =?us-ascii?Q?5W7HZ1AbQ+YgK2Q88oS7IfDE2/1Zc47oHz3SsQXmrYP7b/ngYvrBpclDp1rK?=
 =?us-ascii?Q?m9KjK7HFHp2guFDNrJ3ERrD1JTXgW9m/FZxJHwz+PCaUr+sgDBYFLfl15S9r?=
 =?us-ascii?Q?31RwKoTWX/oZAkcLpLRA35B/ZQTkJ8WNaa8LL9kvJA9LWOVjwMpWeCidoCCx?=
 =?us-ascii?Q?TWkLQc3ymj15gAH+F+chYiNygMG4Gzb8liKgJRhCsja4RhCyyJO71uSA0OCp?=
 =?us-ascii?Q?w4qVCt2FTUpCCEJPEjNtlu6s8j5SY2hlN6nvCZ33glqCQSI3CTZMjxgspi8q?=
 =?us-ascii?Q?Ku+VXbcOLqst+XJfYpvT7tge0NrknRXUlqwSR3sICMVjT0KJFf2zuMifNchY?=
 =?us-ascii?Q?Py9Zw7YROrY9Dwjv4lT3BnkiQodBJCrLC2Atj+hKMTLr320phjWvbGJQLMpl?=
 =?us-ascii?Q?AAQ83KcwHHn2d7tKLY6lD0eN0qsuGQqK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:01:23.2653 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd732716-d776-4ce6-b381-08dcacbaa64f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8806
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

Add ring reset callback for compute.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 38 +++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 675a1a8e2515..78495df29b5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7100,6 +7100,43 @@ static void gfx_v9_0_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
 	}
 }
 
+static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
+			      unsigned int vmid)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
+	struct amdgpu_ring *kiq_ring = &kiq->ring;
+	unsigned long flags;
+	int r;
+
+	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
+		return -EINVAL;
+
+	spin_lock_irqsave(&kiq->ring_lock, flags);
+
+	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
+		spin_unlock_irqrestore(&kiq->ring_lock, flags);
+		return -ENOMEM;
+	}
+
+	kiq->pmf->kiq_unmap_queues(kiq_ring, ring, RESET_QUEUES,
+				   0, 0);
+	amdgpu_ring_commit(kiq_ring);
+
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
+
+	r = amdgpu_ring_test_ring(kiq_ring);
+	if (r)
+		return r;
+
+	/* reset the ring */
+	ring->wptr = 0;
+	*ring->wptr_cpu_addr = 0;
+	amdgpu_ring_clear_ring(ring);
+
+	return amdgpu_ring_test_ring(ring);
+}
+
 static void gfx_v9_ip_print(void *handle, struct drm_printer *p)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -7346,6 +7383,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
 	.soft_recovery = gfx_v9_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v9_0_emit_mem_sync,
 	.emit_wave_limit = gfx_v9_0_emit_wave_limit,
+	.reset = gfx_v9_0_reset_kcq,
 };
 
 static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_kiq = {
-- 
2.45.2

