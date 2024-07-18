Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D2DC3DA6F
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 14:08:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0104C10E906;
	Thu, 18 Jul 2024 14:08:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d0qHmlfZ";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B436910E8C9
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 14:08:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tlY7oZtL8zHlXk4AgQCflqmhE3BCrA/wTWpMMR/V5OtnmctPk6zB9dk9X4iI7bd0pykpSjYlHJIk4gsqOapkDAqC2dCfjUanpKv8W8GE+c/8oQVNQxMgF4zMeUQpkYjrwFmGdcr15CReaWPpWuAaUI1J0BfJRs9pFKM58z/Ay1gTYJIClw946kHxL2ajR77YQzXG/wnafd70+m5JkW0FaaSMuFXrbzwgjq8ixcl6I/c1OwmjXom1e8ii5oytVPZ7nIjp16YhUD1R4QJ01CGtP4LCbTVzXnfYb1EioHHULYGrvo+YNl6+mLjnEFXA3CO/53qHh8c+UWOJHYBIrJWi9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MQWd67pf2REzA/opOE66gneeim5CG5dhUF+UiHCi3A=;
 b=KZs5uAKPs8PiygTQFVv4WK3i2YwOt5GbyLCJvVgo4rMfI0FkwDEM5VpeGR3oI5B3FfRpPIohATY+5KIrf9dv8xI7Jow+5LgBc5YFrXYXm13RHCcAlvyJ4d6bI3D5Gv6YvBOfyag+lvngC2p5exbRSt0YKahz9EFr1OSp1cRzzpT8zuRKWV/HnKDxq7QQKjMKUa0jpkh4uX+JS0JcfzejNLLwAlah3lZAQ1L67lM9Z+MqzxvFAol5zDvbkj1DjzP4evHhsvgq3ZhtZ3FGC/GXR3LUJ3VUYHVNLgw70zIjvV+es7ZnJBzFkHvPkRc5OGdoAGbRoQkUQoCJVKPrlJYTZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MQWd67pf2REzA/opOE66gneeim5CG5dhUF+UiHCi3A=;
 b=d0qHmlfZ9TwvMzlq5YwmYzXO7ym//lVJSJURzHjc2/MUMuNo6RM7DNBiJiTPTUkM30xQnW+GmbHmEu5nhlMdDH6oPXfDO2k/oMevmsGXICS9N9aM9uO/h4dsHG+itQQ5W2x0KZDoJowz44LxPgO5TRdJwf1Eav/m7Slx6xV2O4s=
Received: from BLAPR03CA0039.namprd03.prod.outlook.com (2603:10b6:208:32d::14)
 by CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.15; Thu, 18 Jul
 2024 14:08:09 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:32d:cafe::91) by BLAPR03CA0039.outlook.office365.com
 (2603:10b6:208:32d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16 via Frontend
 Transport; Thu, 18 Jul 2024 14:08:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 14:08:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 09:08:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 32/34] drm/amdgpu/gfx11: add a mutex for the gfx semaphore
Date: Thu, 18 Jul 2024 10:07:31 -0400
Message-ID: <20240718140733.1731004-33-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718140733.1731004-1-alexander.deucher@amd.com>
References: <20240718140733.1731004-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|CY8PR12MB7705:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d3e442c-a709-4355-6dce-08dca7330da6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ixQDwBrXaRFKuIa+zBfrSpK4k62mgUlGM6aX522TSd0hscChjCFbDsLaRnNf?=
 =?us-ascii?Q?g0VSJGcrlO1yXac1GSZ/ZFrH4gXj9POsPYCtFe7hrP0luOrksdfX8YX1Cxof?=
 =?us-ascii?Q?+KXE1rqv5wlMYc86vbtbr87OlSUcPsniThSsysk30BOQHRruXWHcb2GFR68o?=
 =?us-ascii?Q?ORvR4wkPx9pO7EJq78xGwqND9V0mjD5feXAMQntgPrSv+d5DXZcxQxkelaVw?=
 =?us-ascii?Q?L83RH96k9mxQkJFGa3O/gLj9ep3ZBd11cUfjXxWICfo3SAyobhEamlXPwTTP?=
 =?us-ascii?Q?9Tb9ETkjS3dwkNqC9Egm0kWeYC5Mg/sxWlgUeNxT0QMhIdCnUZoZ8qiTs2K/?=
 =?us-ascii?Q?WMm5tgyyWFcqevXqFUcQzwWIAlMcX9lhvw9DGVfb9HMGCKUsbzuSqkF+UWjE?=
 =?us-ascii?Q?ESQZT8cXcaF/4ye6Pt9Y93ADlJhtKfIg6j83z9WT9BrZ9tLMsKgz4DXGkplh?=
 =?us-ascii?Q?6fG62hRL7VLBVyLHNwkY59fPpR6ZdMUC5pejMPk2AUu7cTh+4boRAXKwg5tT?=
 =?us-ascii?Q?gYTeeR37p1EnDu/3u60AtUFhEzyWdymcS5V0tlZbEHMFnkQ1+HkvqPCuDhtV?=
 =?us-ascii?Q?gxy5KiGLAfdAqiUr0B7kHDEtsTLBrkDp+48xyG0DbelG/0wPz+ZKA7TVJcJv?=
 =?us-ascii?Q?FT0N/GptulpFag6YbDePiHqYsvvcWMyNWsplRDnzIMxlH+Q/d7pWNcbd7yzf?=
 =?us-ascii?Q?rdvf45U9Mhtc41Az2PYybIuetO4ESbMLTyU2rpCbTAm1wfOaxiGt9Uu++z3+?=
 =?us-ascii?Q?g3asy3nQC+PLRLVz2nFuweS1zUVHCcwSyeNneZIL8CV8eXxdx5wVHc4X1mmK?=
 =?us-ascii?Q?UjisydcnrdIMTVeCMokFPYlv2XC6YdlbDcBxDy/5sh5gS/hFr3RIQRfyR5rL?=
 =?us-ascii?Q?G5IrScsA3hXNeCswiHg6I3qVS0eYmk45Xne00nb9OZVG7mH+uJtB2RUKLtZH?=
 =?us-ascii?Q?DofwZQ63+I9BsnZkTp5R1IRNuByX15P8nz1I8IceWwe183IOEY+ySxO6W5Jj?=
 =?us-ascii?Q?YqpZtx0BUS+I5qRFlfBPeniKL11RKfQ0ENmLMo7DV3ZHWX/r0+zxetGZH5s+?=
 =?us-ascii?Q?jJQIGAM2c7dNqCfr0UX1GC27VMtSNpwVAw836Exl1OlJjLjkH/zzMGdY77FD?=
 =?us-ascii?Q?kglGb12ZJUHljMPi6HZaZR948veBsVXYMdeRNYJSqNVPPOYVLT7ZI4lICBRS?=
 =?us-ascii?Q?fnOxHFNwTHNM7iIGlzie7+wDdBCXftzkq5JyZmevu1uWUtTpg2f1OFx7c9Yz?=
 =?us-ascii?Q?yzHaSPruar0KhNSgmHLflWiljKHkMkHAioIRxRekwoTNRTK1pkLNrk6HOSk2?=
 =?us-ascii?Q?TwXVoGHg6DzxkDsIqlSP0TAmKmsrmpZZQ7BNtT62HvBUltuJMeYargp1VLeN?=
 =?us-ascii?Q?/oZnjwuENsad/PfzmLVLvID+5ak+G9tKlsKh1H+fhxdZHuN21XccBl1u6AWE?=
 =?us-ascii?Q?IJX/hIj8N8L3BgNJcGvgNYvKpFGTGGX+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 14:08:09.3324 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d3e442c-a709-4355-6dce-08dca7330da6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7705
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

This will be used in more places in the future so
add a mutex.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 10 +++++++---
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index bcacf2e35eba..dcffd57da8db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4055,6 +4055,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	mutex_init(&adev->notifier_lock);
 	mutex_init(&adev->pm.stable_pstate_ctx_lock);
 	mutex_init(&adev->benchmark_mutex);
+	mutex_init(&adev->gfx.reset_sem_mutex);
 
 	amdgpu_device_init_apu_flags(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 6fe77e483bb7..17b945b545b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -444,6 +444,8 @@ struct amdgpu_gfx {
 	uint32_t			*ip_dump_core;
 	uint32_t			*ip_dump_compute_queues;
 	uint32_t			*ip_dump_gfx_queues;
+
+	struct mutex			reset_sem_mutex;
 };
 
 struct amdgpu_gfx_ras_reg_entry {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 9bd42533ce61..37af298d0918 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4725,10 +4725,12 @@ static int gfx_v11_0_wait_for_idle(void *handle)
 }
 
 static int gfx_v11_0_request_gfx_index_mutex(struct amdgpu_device *adev,
-					     int req)
+					     bool req)
 {
 	u32 i, tmp, val;
 
+	if (req)
+		mutex_lock(&adev->gfx.reset_sem_mutex);
 	for (i = 0; i < adev->usec_timeout; i++) {
 		/* Request with MeId=2, PipeId=0 */
 		tmp = REG_SET_FIELD(0, CP_GFX_INDEX_MUTEX, REQUEST, req);
@@ -4749,6 +4751,8 @@ static int gfx_v11_0_request_gfx_index_mutex(struct amdgpu_device *adev,
 		}
 		udelay(1);
 	}
+	if (!req)
+		mutex_unlock(&adev->gfx.reset_sem_mutex);
 
 	if (i >= adev->usec_timeout)
 		return -EINVAL;
@@ -4796,7 +4800,7 @@ static int gfx_v11_0_soft_reset(void *handle)
 	mutex_unlock(&adev->srbm_mutex);
 
 	/* Try to acquire the gfx mutex before access to CP_VMID_RESET */
-	r = gfx_v11_0_request_gfx_index_mutex(adev, 1);
+	r = gfx_v11_0_request_gfx_index_mutex(adev, true);
 	if (r) {
 		DRM_ERROR("Failed to acquire the gfx mutex during soft reset\n");
 		return r;
@@ -4811,7 +4815,7 @@ static int gfx_v11_0_soft_reset(void *handle)
 	RREG32_SOC15(GC, 0, regCP_VMID_RESET);
 
 	/* release the gfx mutex */
-	r = gfx_v11_0_request_gfx_index_mutex(adev, 0);
+	r = gfx_v11_0_request_gfx_index_mutex(adev, false);
 	if (r) {
 		DRM_ERROR("Failed to release the gfx mutex during soft reset\n");
 		return r;
-- 
2.45.2

