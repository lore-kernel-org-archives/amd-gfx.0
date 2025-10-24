Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CDECCD1A5
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Oct 2025 09:45:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 572F110EA15;
	Fri, 24 Oct 2025 09:45:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k3HlahTz";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011060.outbound.protection.outlook.com [52.101.62.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E64210EA05
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 09:45:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ToLxYYdJ1a9n3itJat14Di3yqq0nL+HLIw5iBNvBomV6EO8AvGXKX6FO+wIvn50mg301xxmTzCfvQHXgDzLXnYoBP5Gy6xYyx6LZ5yrI5vhrpWP46Fy7vR8R4skjnvi4+js3ICKEMfl2/6mpP93XO0jgak2+u+IAtCgZbGZlrqjfUg6fim50VmY5Dc6pm3p8qw9IkRyEyIry8G9ALulf/2dLvYtP3N0MYP1Bq9cr5KVEJb7SHc7Qrr9AhVP1YW/xBAg89jteDGXWfhO3AJ0boEMYhQpZmIQF30bxULc7EJf9hjn3kDbzCjsk4iEXxSffDdXmano1LFNLG4NyehUUZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q085d4tQBg7gIftOEXA7QF7Bo1XMjqFTVwRTgic9eeU=;
 b=NX7vrNWbgBG7zKCUr8EWqAaxzI3t6+z0UYYClNNduCfqtGmWoFbyUGlxGVQ2VJu9BMIPnnrW1d64pyyIRgfNyPDjBXOx8gRH0Ffz9hM55uspGYOLXtY/T94+1qWBiB6GSrPBv+DJvytDw+XCCzD6m2D8uZTv1rDyF5Hya9nMtB9MjA7mZuTrhL240Z4uebu+Wbi8dyyDjl9RRE/joeiPbOiUMVT8eTfKL4DOYpBqXGSzonBbiW7StnbizATrVO1dE9Gdk1Qb+0sT1p+DyJBlgHP+dRPN5NiN0/y8dibVGwfWgJSHjkj4SmVAruyN9meQnkrahoJX0rew1yu4WGitKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q085d4tQBg7gIftOEXA7QF7Bo1XMjqFTVwRTgic9eeU=;
 b=k3HlahTzfU8UZaQOw08GsMfZ8dW6OFtkYA4X0y4zVuW++Czkh+SwdJ+1gQJWthOW6kniEVgJ4HTu81DZC9zBxkcB51IPXFAG0DEjxYvYwGbHVvraaVrecxuj6sCwCvsLs2lZxQ1zlQ9bSCK6TwJAKHzXnbY5deZctRPeW+aZ1nI=
Received: from MW4PR03CA0030.namprd03.prod.outlook.com (2603:10b6:303:8f::35)
 by LV8PR12MB9689.namprd12.prod.outlook.com (2603:10b6:408:296::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 09:45:12 +0000
Received: from CO1PEPF000066EB.namprd05.prod.outlook.com
 (2603:10b6:303:8f:cafe::3a) by MW4PR03CA0030.outlook.office365.com
 (2603:10b6:303:8f::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.13 via Frontend Transport; Fri,
 24 Oct 2025 09:45:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066EB.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 24 Oct 2025 09:45:11 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 24 Oct
 2025 02:45:05 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 24 Oct
 2025 02:45:04 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 24 Oct 2025 02:44:58 -0700
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Add user queue reset mask support
Date: Fri, 24 Oct 2025 17:43:41 +0800
Message-ID: <20251024094445.3090110-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251024094445.3090110-1-Jesse.Zhang@amd.com>
References: <20251024094445.3090110-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EB:EE_|LV8PR12MB9689:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c4c2808-51d5-47b2-0a5e-08de12e206b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wESH8C+tsw+ngwN9E0nq2L9vsY+pX1kc25O+nUIkUJxIA9bLCuaaHJ3Ie9iD?=
 =?us-ascii?Q?tfkuzO9LuUHgxJDjb9buEdnRUeqaRu0D7GoHIfdQvkUt9b0RKpVrJodOcoal?=
 =?us-ascii?Q?zAjCBgyxp2yJPya4HRUu3NqEiKCgpvKiz8jfA2jwKdTU2isO2zy//Qkx9b3p?=
 =?us-ascii?Q?KqkUuGdmIwYL+awUz8dbQ0TLejTuhVox2bv9L7/zs9A6KqfDVJ8dgeUqPYsV?=
 =?us-ascii?Q?xOhSTU2LytPSpES2YotuIvVdI9JSX1KEZgynhwsa2LV2+fNYeo/5bWOItiDs?=
 =?us-ascii?Q?IR261m6AZdKIZF9Q+laJm0WKohE+hJuSyi5jC9SavCUG1KT3Zuj/1vXj2xQN?=
 =?us-ascii?Q?wnb6NeasSZhcgmnpaUdvs6Q6kBN1haNjuqrH075j0nhTWe9meuf/lZKiy3Wv?=
 =?us-ascii?Q?TZ2CYGz6zpuiFOWN95iUyDHlaHU5d7p38CqLFvUVQvHy50QI0sE01MCNHB+5?=
 =?us-ascii?Q?pQagyeARU3EljyXBG45ws5mdZAt2wrSFGIgdrNe4K5AlNNQ37gwPHrl+4fUQ?=
 =?us-ascii?Q?E9wzQer45NF1ZTmj3tIdAasJgQWSSMYcNHrlXDdAb1RMNodeOeT3dkeMKw7E?=
 =?us-ascii?Q?S1+SUkcV+sKtomp33GuxEsshwDucVK3n3j7uNgMb6qnlXoqkiyENvDaeAjoc?=
 =?us-ascii?Q?sAvd14gTZE/IGTWeWMYNNdj76yRbdmPqEc20lC8DRfHCsC+2/hc8co6/pkfE?=
 =?us-ascii?Q?36WV+gPMY6YavW3tMxyo54sDemHdR0vzjvxGQ2rItftqb5frTqX7wsQnF2zy?=
 =?us-ascii?Q?MrDfH+EzZ0DBY9kGyOyntLz2NYULG12VswaFpfF+nncMM2FuDDIBG1CkSkHa?=
 =?us-ascii?Q?FSqWkKtdM0jBPzldEldKdifXShjPKq+5K5RMYeBqCUNUhaxp0o/QZC2HwWqK?=
 =?us-ascii?Q?2zb6N5t4ji2P/BbmxnJuJA5U4MT0Si8SEhMMMOUWjjpkmlv3vex1aFEJ6EUw?=
 =?us-ascii?Q?nYpdndXoTIfzKwEpWK0Y+241XJ5MxEWl2DdlGAEn/JXf8zG6UnNHkkfnVhPd?=
 =?us-ascii?Q?czqIk5IUPCHO1Hz7ncnTY5PK1v2iZDS9TvbUNPLMtmeIJL0ZCrL+sJHKm0Yr?=
 =?us-ascii?Q?c7O01E1Qwt49SEeE9AuoBTPUbecTLoGrZ7Ibg29uF2KoXbv03VinucFsBi2D?=
 =?us-ascii?Q?Z7nR7KRdvZuyh0cWNP+Y2SmwPDzk2tULiUynlMkIiMLbiFfKRgLBknvJLqfh?=
 =?us-ascii?Q?l6F+27wjzcpGtsW2HlzO1IrV8turRgnKZi1dPZx5D304fZ6k0gNSZjAnWpaZ?=
 =?us-ascii?Q?P+/QjWSbxIXSu2w///8pSHR/wB74A0H/EAwrmjDDh+gRe2loLrn3QbLYUGR3?=
 =?us-ascii?Q?GAzmeC6sESDN098w5vKTP9RWnMWpVBGk6CeMBbvd++jUZy28XdUXRv6dE98O?=
 =?us-ascii?Q?p3N0/d2CF5rnHJryTPnRqE0QIMcYBPO4rH+u7pT7wMX47b5YyTwQuNXuFpdo?=
 =?us-ascii?Q?KpklGe4kjRy7YcnA4QWg3Sc57VBsj+JmRe16SvGFJyS1r0bJptke0t2VKjZs?=
 =?us-ascii?Q?o5FbvE31W6pKA/TSTbx7e4RCzbQDaOYOXKuWO3Flz9fkZ4LjwNde7S1Kh5b2?=
 =?us-ascii?Q?I9kzny7U6hXUpQHhUpo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 09:45:11.6475 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c4c2808-51d5-47b2-0a5e-08de12e206b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9689
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

This commit adds support for tracking and exposing the reset capabilities
of user mode queues across different IP blocks (GFX, Compute, SDMA).

These changes allow userspace to query the reset capabilities of user
mode queues and ensure reset operations are only attempted when supported
by the hardware and driver.

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 17 ++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 44 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c   | 21 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 13 +++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 17 +++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     | 12 ++++++
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c     | 34 ++++++++++-------
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c     | 24 ++++++++----
 9 files changed, 163 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index d0fb4eb1d7c4..48b21863065e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1182,6 +1182,7 @@ struct amdgpu_device {
 	 * Value: struct amdgpu_usermode_queue
 	 */
 	struct xarray userq_doorbell_xa;
+	u32 userq_supported_reset[AMDGPU_RING_TYPE_MAX];
 
 	/* df */
 	struct amdgpu_df                df;
@@ -1612,6 +1613,8 @@ struct dma_fence *amdgpu_device_enforce_isolation(struct amdgpu_device *adev,
 						  struct amdgpu_ring *ring,
 						  struct amdgpu_job *job);
 bool amdgpu_device_has_display_hardware(struct amdgpu_device *adev);
+ssize_t amdgpu_userq_get_full_reset_mask(struct amdgpu_device *adev,
+				    int ring_type);
 ssize_t amdgpu_get_soft_full_reset_mask(struct amdgpu_ring *ring);
 ssize_t amdgpu_show_reset_mask(char *buf, uint32_t supported_reset);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 8480b72258f2..a0064c5314df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -7649,7 +7649,8 @@ ssize_t amdgpu_get_soft_full_reset_mask(struct amdgpu_ring *ring)
 	if (!ring || !ring->adev)
 		return size;
 
-	if (amdgpu_device_should_recover_gpu(ring->adev))
+	if (amdgpu_device_should_recover_gpu(ring->adev) &&
+	    unlikely(!ring->adev->debug_disable_gpu_ring_reset))
 		size |= AMDGPU_RESET_TYPE_FULL;
 
 	if (unlikely(!ring->adev->debug_disable_soft_recovery) &&
@@ -7659,6 +7660,20 @@ ssize_t amdgpu_get_soft_full_reset_mask(struct amdgpu_ring *ring)
 	return size;
 }
 
+ssize_t amdgpu_userq_get_full_reset_mask(struct amdgpu_device *adev, int ring_type)
+{
+	ssize_t size = 0;
+
+	if (!adev || !adev->userq_funcs[ring_type])
+		return size;
+
+	if (amdgpu_device_should_recover_gpu(adev) &&
+	    unlikely(!adev->debug_disable_gpu_ring_reset))
+		size |= AMDGPU_RESET_TYPE_FULL;
+
+	return size;
+}
+
 ssize_t amdgpu_show_reset_mask(char *buf, uint32_t supported_reset)
 {
 	ssize_t size = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 3d24f9cd750a..5597753ec61a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1826,6 +1826,32 @@ static ssize_t amdgpu_gfx_get_compute_reset_mask(struct device *dev,
 	return amdgpu_show_reset_mask(buf, adev->gfx.compute_supported_reset);
 }
 
+static ssize_t amdgpu_userq_get_gfx_reset_mask(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+
+	if (!adev)
+		return -ENODEV;
+
+	return amdgpu_show_reset_mask(buf, adev->userq_supported_reset[AMDGPU_HW_IP_GFX]);
+}
+
+static ssize_t amdgpu_userq_get_compute_reset_mask(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+
+	if (!adev)
+		return -ENODEV;
+
+	return amdgpu_show_reset_mask(buf, adev->userq_supported_reset[AMDGPU_HW_IP_COMPUTE]);
+}
+
 static DEVICE_ATTR(run_cleaner_shader, 0200,
 		   NULL, amdgpu_gfx_set_run_cleaner_shader);
 
@@ -1845,6 +1871,12 @@ static DEVICE_ATTR(gfx_reset_mask, 0444,
 static DEVICE_ATTR(compute_reset_mask, 0444,
 		   amdgpu_gfx_get_compute_reset_mask, NULL);
 
+static DEVICE_ATTR(gfx_userq_reset_mask, 0444,
+		   amdgpu_userq_get_gfx_reset_mask, NULL);
+
+static DEVICE_ATTR(compute_userq_reset_mask, 0444,
+		   amdgpu_userq_get_compute_reset_mask, NULL);
+
 static int amdgpu_gfx_sysfs_xcp_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
@@ -1928,6 +1960,18 @@ static int amdgpu_gfx_sysfs_reset_mask_init(struct amdgpu_device *adev)
 			return r;
 	}
 
+	if (adev->userq_funcs[AMDGPU_HW_IP_GFX]) {
+		r = device_create_file(adev->dev, &dev_attr_gfx_userq_reset_mask);
+		if (r)
+			return r;
+	}
+
+	if (adev->userq_funcs[AMDGPU_HW_IP_COMPUTE]) {
+		r = device_create_file(adev->dev, &dev_attr_compute_userq_reset_mask);
+		if (r)
+			return r;
+	}
+
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 8b8a04138711..2fb288b2bfc4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -471,6 +471,21 @@ static ssize_t amdgpu_get_sdma_reset_mask(struct device *dev,
 static DEVICE_ATTR(sdma_reset_mask, 0444,
 		   amdgpu_get_sdma_reset_mask, NULL);
 
+static ssize_t amdgpu_get_sdma_userq_reset_mask(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+
+	if (!adev)
+		return -ENODEV;
+
+	return amdgpu_show_reset_mask(buf, adev->userq_supported_reset[AMDGPU_HW_IP_DMA]);
+}
+static DEVICE_ATTR(sdma_userq_reset_mask, 0444,
+		   amdgpu_get_sdma_userq_reset_mask, NULL);
+
 int amdgpu_sdma_sysfs_reset_mask_init(struct amdgpu_device *adev)
 {
 	int r = 0;
@@ -484,6 +499,12 @@ int amdgpu_sdma_sysfs_reset_mask_init(struct amdgpu_device *adev)
 			return r;
 	}
 
+	if (adev->userq_funcs[AMDGPU_HW_IP_DMA]) {
+		r = device_create_file(adev->dev, &dev_attr_sdma_userq_reset_mask);
+		if (r)
+			return r;
+	}
+
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 188de848c229..15ae72e2d679 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -47,6 +47,16 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 	return userq_ip_mask;
 }
 
+bool amdgpu_userq_is_reset_type_supported(struct amdgpu_device *adev,
+                                         int ring_type,
+                                         int reset_type)
+{
+    if (ring_type < 0 || ring_type >= AMDGPU_RING_TYPE_MAX)
+        return false;
+
+    return (adev->userq_supported_reset[ring_type] & reset_type) != 0;
+}
+
 static void amdgpu_userq_gpu_reset(struct amdgpu_device *adev)
 {
 	if (amdgpu_device_should_recover_gpu(adev)) {
@@ -94,6 +104,9 @@ amdgpu_userq_detect_and_reset_queues(struct amdgpu_userq_mgr *uq_mgr)
 		int ring_type = queue_types[i];
 		const struct amdgpu_userq_funcs *funcs = adev->userq_funcs[ring_type];
 
+		if (!amdgpu_userq_is_reset_type_supported(adev, ring_type, AMDGPU_RESET_TYPE_PER_QUEUE))
+				continue;
+
 		if (atomic_read(&uq_mgr->userq_count[ring_type]) > 0 &&
 		    funcs && funcs->detect_and_reset) {
 			r = funcs->detect_and_reset(adev, ring_type);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 252517ce5d5a..82b7c365d720 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1815,6 +1815,11 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 		amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
 	adev->gfx.compute_supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0]);
+	adev->userq_supported_reset[AMDGPU_HW_IP_GFX] =
+			amdgpu_userq_get_full_reset_mask(adev, AMDGPU_HW_IP_GFX);
+	adev->userq_supported_reset[AMDGPU_HW_IP_COMPUTE] =
+			amdgpu_userq_get_full_reset_mask(adev,AMDGPU_HW_IP_COMPUTE);
+
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(11, 0, 0):
 	case IP_VERSION(11, 0, 2):
@@ -1824,12 +1829,24 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 		    !amdgpu_sriov_vf(adev)) {
 			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 			adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+			if (adev->userq_funcs[AMDGPU_HW_IP_GFX] &&
+			    adev->userq_funcs[AMDGPU_HW_IP_GFX]->detect_and_reset)
+				adev->userq_supported_reset[AMDGPU_HW_IP_GFX] |= AMDGPU_RESET_TYPE_PER_QUEUE;
+			if (adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] &&
+			    adev->userq_funcs[AMDGPU_HW_IP_COMPUTE]->detect_and_reset)
+				adev->userq_supported_reset[AMDGPU_HW_IP_COMPUTE] |= AMDGPU_RESET_TYPE_PER_QUEUE;
 		}
 		break;
 	default:
 		if (!amdgpu_sriov_vf(adev)) {
 			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 			adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+			if (adev->userq_funcs[AMDGPU_HW_IP_GFX] &&
+			    adev->userq_funcs[AMDGPU_HW_IP_GFX]->detect_and_reset)
+				adev->userq_supported_reset[AMDGPU_HW_IP_GFX] |= AMDGPU_RESET_TYPE_PER_QUEUE;
+			if (adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] &&
+			    adev->userq_funcs[AMDGPU_HW_IP_COMPUTE]->detect_and_reset)
+				adev->userq_supported_reset[AMDGPU_HW_IP_COMPUTE] |= AMDGPU_RESET_TYPE_PER_QUEUE;
 		}
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 35d5a7e99a7c..c5ac42a30789 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1543,6 +1543,11 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 		amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
 	adev->gfx.compute_supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0]);
+	adev->userq_supported_reset[AMDGPU_HW_IP_GFX] =
+		amdgpu_userq_get_full_reset_mask(adev, AMDGPU_HW_IP_GFX);
+	adev->userq_supported_reset[AMDGPU_HW_IP_COMPUTE] =
+		amdgpu_userq_get_full_reset_mask(adev,AMDGPU_HW_IP_COMPUTE);
+
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(12, 0, 0):
 	case IP_VERSION(12, 0, 1):
@@ -1551,6 +1556,13 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 		    !amdgpu_sriov_vf(adev)) {
 			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 			adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+			if (adev->userq_funcs[AMDGPU_HW_IP_GFX] &&
+			    adev->userq_funcs[AMDGPU_HW_IP_GFX]->detect_and_reset)
+				adev->userq_supported_reset[AMDGPU_HW_IP_GFX] |= AMDGPU_RESET_TYPE_PER_QUEUE;
+			if (adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] &&
+			    adev->userq_funcs[AMDGPU_HW_IP_COMPUTE]->detect_and_reset)
+				adev->userq_supported_reset[AMDGPU_HW_IP_COMPUTE] |= AMDGPU_RESET_TYPE_PER_QUEUE;
+
 		}
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index db6e41967f12..8850eaf8d2c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1349,19 +1349,6 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
-	adev->sdma.supported_reset =
-		amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].ring);
-	switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
-	case IP_VERSION(6, 0, 0):
-	case IP_VERSION(6, 0, 2):
-	case IP_VERSION(6, 0, 3):
-		if ((adev->sdma.instance[0].fw_version >= 21) &&
-		    !amdgpu_sriov_vf(adev))
-			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
-		break;
-	default:
-		break;
-	}
 
 	if (amdgpu_sdma_ras_sw_init(adev)) {
 		dev_err(adev->dev, "Failed to initialize sdma ras block!\n");
@@ -1412,6 +1399,27 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 		break;
 	}
 
+	adev->sdma.supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].ring);
+	adev->userq_supported_reset[AMDGPU_HW_IP_DMA] =
+		amdgpu_userq_get_full_reset_mask(adev, AMDGPU_HW_IP_DMA);
+
+	switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
+	case IP_VERSION(6, 0, 0):
+	case IP_VERSION(6, 0, 2):
+	case IP_VERSION(6, 0, 3):
+		if ((adev->sdma.instance[0].fw_version >= 21) &&
+		    !amdgpu_sriov_vf(adev)) {
+			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+			if (adev->userq_funcs[AMDGPU_HW_IP_DMA] &&
+			    adev->userq_funcs[AMDGPU_HW_IP_DMA]->detect_and_reset)
+				adev->userq_supported_reset[AMDGPU_HW_IP_DMA] |= AMDGPU_RESET_TYPE_PER_QUEUE;
+
+		}
+		break;
+	default:
+		break;
+	}
 	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 326ecc8d37d2..9de46ac8b1db 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1335,14 +1335,6 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
-	adev->sdma.supported_reset =
-		amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].ring);
-	if (!amdgpu_sriov_vf(adev))
-		adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
-
-	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
-	if (r)
-		return r;
 	/* Allocate memory for SDMA IP Dump buffer */
 	ptr = kcalloc(adev->sdma.num_instances * reg_count, sizeof(uint32_t), GFP_KERNEL);
 	if (ptr)
@@ -1360,6 +1352,22 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 		break;
 	}
 
+	adev->sdma.supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].ring);
+	adev->userq_supported_reset[AMDGPU_HW_IP_DMA] =
+		amdgpu_userq_get_full_reset_mask(adev, AMDGPU_HW_IP_DMA);
+
+	if (!amdgpu_sriov_vf(adev)) {
+		adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+		if (adev->userq_funcs[AMDGPU_HW_IP_DMA] &&
+		    adev->userq_funcs[AMDGPU_HW_IP_DMA]->detect_and_reset)
+			adev->userq_supported_reset[AMDGPU_HW_IP_DMA] |= AMDGPU_RESET_TYPE_PER_QUEUE;
+
+	}
+	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return r;
 }
 
-- 
2.49.0

