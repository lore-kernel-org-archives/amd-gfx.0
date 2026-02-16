Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F17EE63F3F
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Feb 2026 09:45:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D857510E1F5;
	Mon, 16 Feb 2026 09:45:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R++xxcVH";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012055.outbound.protection.outlook.com
 [40.93.195.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C120E10E1F5
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 09:45:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hk35Rdn9N/9ldRL8xBmFBhilrNKb9/5SahEveunLnlH4X//UthlQroDGgroZt8daXoFFcHuKMfnm2SaDAXcpDzDRTlOcIalYQFZSW8UV8WkqwYOZx+WTdfq7dNAor+4d4l4rcru3UBioYbGKBj9ML+v+C5ZZCHEPhJJ97+Ndf6hyZpDvSaLJhNOdEQqAp/Hukm8dgDftLNqXgNZIIISxLQxk0mYc7s5Hh1sShXSOBPMQ9nuttCBu2PfzKF1h3ydhybDTASreF+cZ2hqeUWeqcPx/Ox7gLYGivsCbxCis5etQxGGn4AMlu6Ec6OksW071tDt+yn2fiPzPYbkBygtDQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ifvEhXSQ7awkf/zxOqptTNborTB5i2VtTD+CB1xlcU=;
 b=s3H7rOZTJ85Qe5/aDZTFQUj7SPxB3KmS3jKmhLXfVM67fhYCsM1m2kdND73RkvegTIu8nGUyPzJXbBTGglYIZDxlIE06WJYk9ECBqxBMfDYohrWihCBh9EnSqfJNpMOHgXkktPM9DINFWHNhPbpdEDDuoJe67kyKyw+hAAPK/C+egKLB1vqOUgmcnJFCWvNVYDs41CYUNHAv1PCv69lDxGjoC7fQwlwWUdwLjvg0sbUIXsNShFBT3yDX852ItO6PnTFdo45iGEgvDMw2ugcSxEKnLsDvSMoaQVa4E/+VzdWtYk2qsjlEw3FDlkkpcGbNoNMKVaPaDin4B1fnL7ANFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ifvEhXSQ7awkf/zxOqptTNborTB5i2VtTD+CB1xlcU=;
 b=R++xxcVHCtWyOFN4GMCqkT9swpuEGtPWHM7Edqkuhqbk+NI6AU+k2X/NpI5GTC54RikaFb5g95AmM7s+EtDEwgl6B3GjYwpwbvG+Buyu9M8uGYZrutPQFlCr/7FMskArBN97pzMyJ8k1lhE85wFD2sHwoq/zQy0doWaVNbMutDY=
Received: from MN0PR05CA0015.namprd05.prod.outlook.com (2603:10b6:208:52c::28)
 by SA1PR12MB8988.namprd12.prod.outlook.com (2603:10b6:806:38e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 09:45:34 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:52c:cafe::e) by MN0PR05CA0015.outlook.office365.com
 (2603:10b6:208:52c::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Mon,
 16 Feb 2026 09:45:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 09:45:33 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 16 Feb 2026 03:45:31 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: Add per-drm_file eventfd registry for render
 node
Date: Mon, 16 Feb 2026 15:14:45 +0530
Message-ID: <20260216094447.1581407-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260216094447.1581407-1-srinivasan.shanmugam@amd.com>
References: <20260216094447.1581407-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|SA1PR12MB8988:EE_
X-MS-Office365-Filtering-Correlation-Id: e45e329f-b0ee-451b-ab8d-08de6d40216b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d0svdWpmSjB2dDNNNHJEOFkxaWEwRm1LY2hsMjVQcjEzRzBtQ3FoYzcvbjhv?=
 =?utf-8?B?N3dkZjU1Q3FUb1pTTmRjZmJ3R0ZzMVRJcWt0WTJvOGtXbFByci9DWW9wY1FM?=
 =?utf-8?B?Y2x6SmNIbDZoWDg3ZSt4TkViMDNWODh6Q2FKOExKSzR2N0p4a2RnY21wSEQ5?=
 =?utf-8?B?VWxEQ292UDh4QUVwaHVDL3ZZdU1rY1dQSGNvdGR2UjM1UmxXcTVjdmFRS1VP?=
 =?utf-8?B?MTg4VTc2QTRmblVXaC9lNjRBMitQZE9IWFRuc0gzNlB4UzlOVi9PYWQzU1A5?=
 =?utf-8?B?ekEvQVNvYmxPck9QUEdCTitUa2ZaYkNyaEdyMExaci9hODhaeDZUZmFpajZu?=
 =?utf-8?B?amREOFJTMlpPL1hyZ0FTN3BaQXBreCtVWWo0Z1YyQWNqOURtM1JJaHJNbDlk?=
 =?utf-8?B?L0l2V2FBWHQrVnRFa0E2TnFMN2tvU2QzSThkNTZia0ZUUHorNFFUeEFwbEtU?=
 =?utf-8?B?d01TNFZ4dXZHMll5UHBRcnBsWHhia2dIMmZjQ3NyTjFKWU1sbVFKZHVOd0U5?=
 =?utf-8?B?VHQxVHlSS0F1dEc2V0VEZWNZdnZvT0REUEFIZU14UFl0bXk0cjJCTDJHRUVm?=
 =?utf-8?B?cXBHUkZNbVFhWXR1MFdDR3FKWHFkazdZWXM3d0FWU3pVTEtyUFErSWpONU8z?=
 =?utf-8?B?M2hjTG1lSzB2RkhTTVkvTjJBand6djhpOC9KVTZDT2dxRGdhVEk1ZHptQ0hQ?=
 =?utf-8?B?QU55T1FWaEZCU1ZuRU9tVjNqeG9iOWxYS2c4cjdodHZoTHhDSitpTU5WckJw?=
 =?utf-8?B?YnRvSTZCclN0SkMrdkhFMFBUbk1Uc0RRbDRKSXkvWnBHWnZ1S0t0SFRJNU90?=
 =?utf-8?B?THhlSGpPMHluVVFvVlViVzc3WmV3NVVBelhXU2c5MDVQaHd2SE4zMnI1WjdO?=
 =?utf-8?B?M0FPY3BaZ1NJbjMwNDFMQXAyTmJRa1VuaW9VN3JldlFGM2NBMUNOOHphSTJi?=
 =?utf-8?B?QXZWVVdrZEl2dzJZZmdTNkdjV1NRTFVSUm9OVGRkanNKNGlZTkhFYzI3RDBn?=
 =?utf-8?B?TWRmcjlwRzhIN1FLSXNUOEJDcGF5dVlvMjBUU1RMMDBkSXd5TU5yT1ZZdjl3?=
 =?utf-8?B?VHRCamFNL1kzLzVwS1F5ZUlIUWl6L04xQzdHZy9LOVQvRFZBQ0xPbXdpNnNI?=
 =?utf-8?B?bVhkL1poR0V4UUlGZU9uOVNHRk03aDFMNWp2WUtldFdNbkdadkc5Rmg5dmVM?=
 =?utf-8?B?aVp3d3FReGlBM0xReVBnRERJVHRZSGU2WUJVdENGTHM2Qi9ONVRaUWYzSDM3?=
 =?utf-8?B?RVhRS2doYlgvcmoxQ2NwUmdwR2tVQUdqcDM1NTlWWTNXVzBRRzlaaDBVUk11?=
 =?utf-8?B?UFBtcW1zc1gzQU8vOWp6VjBsYUQ4NUZhMzl4YkVVNmNhUmFzUzJSWWxKN3pE?=
 =?utf-8?B?V2ZUWHhJanBCSmVKOUh3bkdPTThwV3dnOTV6WnRpbGg0VnZSTDRneVppQjhj?=
 =?utf-8?B?bW9TL2g5UzA3bXFka1FxNXJFZ3pSWlAzRUVnVU1oekNKUXpUMm5MZXYzTjZO?=
 =?utf-8?B?Y3ZTSlcwTFdPeldLUExFcUVueUNWT3YzR3R5b2E2Wm8xNTVnb2o2UVhoUitz?=
 =?utf-8?B?WG5WY1JRcUNtbFp1ak90WTlXdGc3ZjZTdDA1Z3p5RW41aDU0akY0a21qOWUr?=
 =?utf-8?B?dlhLaTc2ZVVXdnVmWWcxVFNyMHFyZzNKSmZ4NHJvSE1IZnNQK2QrdklBZVVZ?=
 =?utf-8?B?alZTWEFiMC9meDd5S2o3T0t0UDlPaHJzRVBKOFFwZkNSa25XTlNvdUg0Qnp5?=
 =?utf-8?B?MWJ5M0EyZ3ljR3F3UVRRVENoTTBGeGdrYVFHQXUzeVZFMy9IT3U2THoyKys4?=
 =?utf-8?B?RFVQb0ZVRjJSOHhTSVZVWVJMSk1tZjdDRkp4NVBQZytEa1NCVHpCMUcwc05Y?=
 =?utf-8?B?NGZjNk9hbURuZm4vMXVKMDZ0ZW9YUXRFa3RDR3pLRjZRMWFtb3NQWU9PdHM2?=
 =?utf-8?B?S202TjhyVHNPTWlsdHJ2U0dRb2tVaXplNTFQWXdFc2FtSmdHc05aZXhRRFBI?=
 =?utf-8?B?bmU5Z0EyWXRlQUlkVEVHK2hQVVRSK0dFb0ZwaURCOFk5Y3pmMzVQU29EUlVC?=
 =?utf-8?B?NWdtZlRYaFNIazREYkxoaXRYaERGNGx1amk5K2VIYTBCaUN1VnJaT3ZxSkxK?=
 =?utf-8?B?T2ovVTU5SStReS9JSGZEdTJrRkFrRWIzVGh6MUZjMHRBTEF0M1pqa1Z6dHVT?=
 =?utf-8?B?NzVnSmUyaVo1Uk1oa0l0RDA1c1ByRlhIMWZGNHRIUHBpVUFiNjkrUEF1Rk91?=
 =?utf-8?B?ZDB5dlQ5SWpxckRDQ3ZFNE90bnNBPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XTWlBQTxXJyaDNeILaS33orauNnIq7B4UqQwvZV4d47r4/lxjKoIkzwknTcl4WPH+uBJpGdtKR5E6k81jDb0cdlZ5f1zL22+hmcG3aCZAaibudaqxYvaAkXxyrn7kR1qB2HeymPevb8LzIwxPqwNjlL+R4zw4zMCtKrJbIVuV7zFQpbfcI1cKOSQtbogxZGXwteVTeF13BNae4wGPMOnMK6ZGA6FXGq0+GM176Qy51dVsk38HqhlxkEQZdTTa7BOpcciTHcPcPVuXbUCRNkUMjr8nCl2iT+NtfICUI+Y0N0sjsuDdEUnP/qUpj6JYJFZfkTcgMThNZVGzl40LpqBFkUH7IptdrLgdb8gy2TX892kbGhhw1WvUQjF+UifmlvBreGE/NZf/FxponsSihy0HmfZ0ayXuZrSOgjLg2C3VqTUTcEZgm/09lSl0mX6PLCa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 09:45:33.8792 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e45e329f-b0ee-451b-ab8d-08de6d40216b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8988
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

Add a per-drm_file eventfd registry to amdgpu and wire up the new
render-node IOCTLs:

  DRM_IOCTL_AMDGPU_EVENTFD_BIND
  DRM_IOCTL_AMDGPU_EVENTFD_UNBIND

This allows userspace to bind an eventfd to an event_id on a per-file
basis. The mapping is stored in an xarray protected by a mutex inside
amdgpu_fpriv.

Each event_id maps to a struct amdgpu_eventfd_entry containing the
associated eventfd_ctx. Bind replaces any existing binding for the same
event_id. Unbind removes the mapping and drops the eventfd reference.

The registry is initialized during driver open and fully cleaned up
during DRM release to ensure proper lifetime handling and to avoid
leaking eventfd references. Entries are freed via RCU so future IRQ-side
users can do lockless lookups.

Cc: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Change-Id: I78635bba4772843138a51a6152a3fa621cb07353
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  20 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 116 ++++++++++++++++++++++++
 3 files changed, 139 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 0f6e9cdbe7d8..2baeb0b20df1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -44,6 +44,8 @@
 #include <linux/hashtable.h>
 #include <linux/dma-fence.h>
 #include <linux/pci.h>
+#include <linux/xarray.h>
+#include <linux/rcupdate.h>
 
 #include <drm/ttm/ttm_bo.h>
 #include <drm/ttm/ttm_placement.h>
@@ -452,8 +454,26 @@ struct amdgpu_fpriv {
 
 	/** GPU partition selection */
 	uint32_t		xcp_id;
+
+	/* eventfd registry for KFD-event unification (per drm_file) */
+	struct mutex eventfd_lock;
+	struct xarray eventfd_xa; /* key: event_id (u32) -> struct amdgpu_eventfd_entry* */
+};
+
+struct amdgpu_eventfd_entry {
+	struct rcu_head rcu;
+	struct eventfd_ctx *ctx;
 };
 
+struct drm_device;
+struct drm_file;
+
+int amdgpu_eventfd_bind_ioctl(struct drm_device *dev, void *data,
+			      struct drm_file *file_priv);
+int amdgpu_eventfd_unbind_ioctl(struct drm_device *dev, void *data,
+				struct drm_file *file_priv);
+void amdgpu_eventfd_registry_fini(struct amdgpu_fpriv *fpriv);
+
 int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 03814a23eb54..98e2fa78c787 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2955,6 +2955,7 @@ static int amdgpu_drm_release(struct inode *inode, struct file *filp)
 		fpriv->evf_mgr.fd_closing = true;
 		amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
 		amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
+		amdgpu_eventfd_registry_fini(fpriv);
 		drm_dev_exit(idx);
 	}
 
@@ -3062,6 +3063,8 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_EVENTFD_BIND, amdgpu_eventfd_bind_ioctl, DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_EVENTFD_UNBIND, amdgpu_eventfd_unbind_ioctl, DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index f69332eed051..43da5bc36b7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -39,6 +39,10 @@
 #include <linux/uaccess.h>
 #include <linux/pci.h>
 #include <linux/pm_runtime.h>
+#include <linux/eventfd.h>
+#include <linux/rcupdate.h>
+#include <linux/eventfd.h>
+#include <linux/slab.h>
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_gem.h"
 #include "amdgpu_display.h"
@@ -634,6 +638,113 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 	return 0;
 }
 
+static void amdgpu_eventfd_entry_free_rcu(struct rcu_head *rcu)
+{
+	struct amdgpu_eventfd_entry *e =
+		container_of(rcu, struct amdgpu_eventfd_entry, rcu);
+
+	if (e->ctx)
+		eventfd_ctx_put(e->ctx);
+	kfree(e);
+}
+
+void amdgpu_eventfd_registry_fini(struct amdgpu_fpriv *fpriv)
+{
+	unsigned long index;
+	struct amdgpu_eventfd_entry *e;
+
+	if (!fpriv)
+		return;
+
+	/*
+	 * Serialize with bind/unbind via eventfd_lock,
+	 * and use xa_lock to safely erase while iterating.
+	 */
+	mutex_lock(&fpriv->eventfd_lock);
+
+	xa_lock(&fpriv->eventfd_xa);
+	xa_for_each(&fpriv->eventfd_xa, index, e) {
+		__xa_erase(&fpriv->eventfd_xa, index);
+		call_rcu(&e->rcu, amdgpu_eventfd_entry_free_rcu);
+	}
+	xa_unlock(&fpriv->eventfd_xa);
+
+	mutex_unlock(&fpriv->eventfd_lock);
+
+	/* Wait for any RCU readers before destroying the xarray. */
+	synchronize_rcu();
+	xa_destroy(&fpriv->eventfd_xa);
+}
+
+int amdgpu_eventfd_bind_ioctl(struct drm_device *dev, void *data,
+			      struct drm_file *file_priv)
+{
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
+	struct drm_amdgpu_eventfd_bind *args = data;
+	struct amdgpu_eventfd_entry *e, *old;
+	struct eventfd_ctx *ctx;
+
+	if (!fpriv || !adev)
+		return -ENODEV;
+	if (args->flags)
+		return -EINVAL;
+	if (args->eventfd < 0)
+		return -EINVAL;
+
+	ctx = eventfd_ctx_fdget(args->eventfd);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
+	e = kzalloc(sizeof(*e), GFP_KERNEL);
+	if (!e) {
+		eventfd_ctx_put(ctx);
+		return -ENOMEM;
+	}
+	e->ctx = ctx;
+
+	mutex_lock(&fpriv->eventfd_lock);
+	old = xa_store(&fpriv->eventfd_xa, args->event_id, e, GFP_KERNEL);
+	mutex_unlock(&fpriv->eventfd_lock);
+
+	if (xa_is_err(old)) {
+		int ret = xa_err(old);
+
+		eventfd_ctx_put(ctx);
+		kfree(e);
+		return ret;
+	}
+
+	/* Replace existing binding for same event_id. */
+	if (old)
+		call_rcu(&old->rcu, amdgpu_eventfd_entry_free_rcu);
+
+	return 0;
+}
+
+int amdgpu_eventfd_unbind_ioctl(struct drm_device *dev, void *data,
+				struct drm_file *file_priv)
+{
+	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
+	struct drm_amdgpu_eventfd_unbind *args = data;
+	struct amdgpu_eventfd_entry *e;
+
+	if (!fpriv)
+		return -ENODEV;
+	if (args->flags)
+		return -EINVAL;
+
+	mutex_lock(&fpriv->eventfd_lock);
+	e = xa_erase(&fpriv->eventfd_xa, args->event_id);
+	mutex_unlock(&fpriv->eventfd_lock);
+
+	if (!e)
+		return -ENOENT;
+
+	call_rcu(&e->rcu, amdgpu_eventfd_entry_free_rcu);
+	return 0;
+}
+
 /*
  * Userspace get information ioctl
  */
@@ -1469,6 +1580,8 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 		goto out_suspend;
 	}
 
+	mutex_init(&fpriv->eventfd_lock);
+	xa_init(&fpriv->eventfd_xa);
 	pasid = amdgpu_pasid_alloc(16);
 	if (pasid < 0) {
 		dev_warn(adev->dev, "No more PASIDs available!");
@@ -1538,6 +1651,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 	if (pasid)
 		amdgpu_pasid_free(pasid);
 
+	xa_destroy(&fpriv->eventfd_xa);
 	kfree(fpriv);
 
 out_suspend:
@@ -1568,6 +1682,8 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	if (!fpriv)
 		return;
 
+	amdgpu_eventfd_registry_fini(fpriv);
+
 	pm_runtime_get_sync(dev->dev);
 
 	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_UVD) != NULL)
-- 
2.34.1

