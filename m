Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE1EE81A3D
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Feb 2026 15:50:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DA6310E3A3;
	Mon, 16 Feb 2026 15:50:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QxiAiXhf";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013024.outbound.protection.outlook.com
 [40.107.201.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E40010E3A3
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 15:50:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eLTdoSa6yQV4IOESKwoT2pipbYj4hmT5yjkhgwOLYmowUJHiYSZhDalEHeWWztEVOCLJmkCspH9sW1e18W5aTHHoVDpjkFwUXOzAgEcbMh1Ca6EK9f2b+jf+loAmh3166wu+R1IRLOBga9/jCC+/dsuH9F0SOIFK85fjLpPWelB8ndWFk2xj6u//yrCvikTP264i4RV2xIO615gMQr16jhJQpI27cQb55t9uDM5ipDGgXkbhYBt2/mYJNp2rtRHqoH7j7l9eo7RBvmx16IkmeETqnB167GVRh+PP7bJktigbk6Z6K61G8EIqCaVSVp2ds6wl0KXhoM130gU+QSEFkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ifvEhXSQ7awkf/zxOqptTNborTB5i2VtTD+CB1xlcU=;
 b=pCR3XBTrnwOYDSF+4V2RCnNr5ZhiKueQDZrgMV+9MJQwEAC5qf/LONlzQw6AmU0e5OKV2KJN3tsO0IhQQs9WRvSmBP2mxF/VZxwZGnozZe/jxb1gkU00bfix4OCMVTw1oyaAqI8sWrNZkBOsDq68VoC88jml9ui8MDM8Ke9gSvjGV5OsEH9qMnCTjIMQFWaAEu1g/5bNUGz0I5uVBrym0sUdBl5Pdw7q5lG1dlKOJ6xBIoWxk6ZXcBOHw4JnsjuFJWYf5yqAumWizTDvlEb3OHZHUIy5qPXqpBKJ2Wb6nnY1h1dUx3h83WOZeQsO23T4Z6U2OczhDeRcFa7tKyGYDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ifvEhXSQ7awkf/zxOqptTNborTB5i2VtTD+CB1xlcU=;
 b=QxiAiXhfCQMUkt5xrONWDGDUBX5G5/bQZwzYlDXiE0gfpXi7kStFGG3wpnRNRGHUgI8NEfa77qq/pKDl7uzp/M8Do6u5jRatNcMB5gq7oA7oQ5ZmHvOkef6W4pYOpmjiq8Nhe0JpXp4N3KgHNY6HYYs+nEdQG11ByFOonUE3TLE=
Received: from BYAPR07CA0105.namprd07.prod.outlook.com (2603:10b6:a03:12b::46)
 by DS2PR12MB9749.namprd12.prod.outlook.com (2603:10b6:8:2b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 15:50:09 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::65) by BYAPR07CA0105.outlook.office365.com
 (2603:10b6:a03:12b::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Mon,
 16 Feb 2026 15:50:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 15:50:09 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 16 Feb 2026 09:50:03 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH v2 2/8] drm/amdgpu: Add per-drm_file eventfd registry for
 render node
Date: Mon, 16 Feb 2026 21:19:37 +0530
Message-ID: <20260216154943.1582412-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260216154943.1582412-1-srinivasan.shanmugam@amd.com>
References: <20260216154943.1582412-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|DS2PR12MB9749:EE_
X-MS-Office365-Filtering-Correlation-Id: 463ee0c7-f49e-4bae-442f-08de6d731074
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R2JJcG9LRllEQW1SbXd0dmRkcWMxVEszSU90V2VTQXV2MEVGTzFmcjVGcDM2?=
 =?utf-8?B?MUJNNm5wU2haMFFXLzk5WExrUjFKaWluWm9RVXp1VG1RNXNvQ3E2TjEyLzdY?=
 =?utf-8?B?TGNWSnBoOXMyV05MdTFDK2lic3Z2ck9jR1dtSDMvcWc0Y1htTlk3a1NsVWsz?=
 =?utf-8?B?Q210UWhoQkpDUFF1bFJ4NzZTTE1GQUxoTklnT3FOY2dMKzIvZURwYXpEcjFx?=
 =?utf-8?B?MmFmSjlsVGprMlNiUXhlcWZuQ0hRb2g3MUd3R2NsN1hzclp5TmMwMWJjMDI2?=
 =?utf-8?B?M3NTSlNDS0FQcTVXNEZEODJQbTdaQmp6TmVIU2dSRjRKQlhwMmRNL1VKd1o0?=
 =?utf-8?B?ZmFlR1JmVmdoWTZEWlN1dGI4SkNuRmJYajQ5OGxpcC95QXVIRWsvUTZJK0FF?=
 =?utf-8?B?aE5LaDNINnhkbHlENW5NR0lLTFg5T0pPRHV1VFRrUEx2VDhKUGx2WnE5Wi9q?=
 =?utf-8?B?VjJ2MXpIRlFvTVJrMWN0Mkh3THVNV08vckJTNG5SaGtrNE9kY0NIYUNKcEpK?=
 =?utf-8?B?Ui9scUFWMDROQ0tqQ0JNVFhRNXhkTm45TlFEMVFuYkRrbUxMM2l3UFc0WDFa?=
 =?utf-8?B?V2hXWUFpTW1remxBZlJTUGZVUFNXbHVBSVJtWjJ5SXRWTnhBMFZnUTNCV0xi?=
 =?utf-8?B?UnF0SGdXbEJPTnl1SFJYb2RWNnhVZjVBblRYbVEwUE1JaCtrbEhnVzJQWWJn?=
 =?utf-8?B?a2hIdk5tSTBXcTJBWVcwWjVWVWJIWVBUMWc3d0YxdCswMkk4dnBnUERDYWpD?=
 =?utf-8?B?c0h5eGJXU09JTyt3ck45c0JQN1pYR20yTlowZ3ZTS0VtcFlGc3R5d2FxWWNM?=
 =?utf-8?B?MCtmM21ENE4zd2V6S0htQ285cGtoTTUyRy9Vb1lXVTluaHY1dkRLVlVVenBy?=
 =?utf-8?B?aDhhVUMxeDZvVDFrQmZxcHUzSmRBdXYyNVpndFo2T0c1amw4TkFHdThUTDRl?=
 =?utf-8?B?ZWpLS3dkQjA1RDkxcUV3YWt2YTM2eFhTSlRMTE9BeGFSbWtCK3lJbjNRRlJi?=
 =?utf-8?B?cVlBMnhHKzZ3eFpPMHJkN0twbk1vK2hweU1SWGJqT0xSUjBtODlkNE5tQXhs?=
 =?utf-8?B?L1lxY1RnSUJSWVVrd2JCemVyMURkSkdqSVlLM0Q1Ukw2N1ZwY1NZckdJenhK?=
 =?utf-8?B?bXY5Qmdsd1d0YURUS2Y4SGtuZUVlcEpvRCtvNWpoSURQVVJZSElBbHp1L3h4?=
 =?utf-8?B?Y0V0WkVWMU5JbXJvcUQ1aGtlRjZCVFdUVW5OclhQeWZYTVloMHZjYVdTVkQy?=
 =?utf-8?B?WjZPbHRrZ3ZkNUtxM28yVXYrdHdBdFNEMGt5UTZuWW8yaXRlbkQ5MkVhMWJN?=
 =?utf-8?B?c21wZUk1Vm9nZjA3V0tiVGFXNFNJbkwySENyWlhWQmdiTVpVRXVFV1YxMlBu?=
 =?utf-8?B?bmxacW12RXdmWXhWd05zU21iMWhSSlNmQ0pzYWJDdnczYzcvUXNKaHRmWFlw?=
 =?utf-8?B?aWcwQ3NuTXU5dm8wTXNWdlpKWUdYeWVmYVk3Mk9NMXBqeTQraklRdUVXenIz?=
 =?utf-8?B?amNaYXNMVitBUkIvRVRsSlE5WHU2NS9vZWQraUliN1NwSHkwcnFyM25KMWZM?=
 =?utf-8?B?S3hscklNTTg4TGlaZEtvWHJMdzZaV1htTU4vZzVmUklnQ0FoNmxwNjJXSHUr?=
 =?utf-8?B?ZlFBcmhBaWRkWUwxTTE2OThTaHpHZDh1WFYzbTZtNitnbEpHMDIwVHhVUTk4?=
 =?utf-8?B?MkpuTW1DU2ZBc1Y1ckNkV2J2NzRqR0xJQlZwc2t2NDh2WllkakVZc1c5cUZX?=
 =?utf-8?B?WDVxVDcvdXM4RVpnaDBZQmxsVllVaXp1ZnQwTUN2NHAyTmxHRE5MQkFMeE9I?=
 =?utf-8?B?NThzdUtaNmk0V3kweElFZ0FTaGJPS1FtaWpPZHhraHYwVnZYOU81ZURkbVMr?=
 =?utf-8?B?a1JRT0ZFMVlOVy9qQkVrVnpSTGdmTllqd3Job0ZvcFR3S1djMEJSOXJROE9U?=
 =?utf-8?B?c09uNTNuT3JyV3dXcjRCQzhxbE1PMTJha1VLTmNSd2NIRFJpUDc5UVJEZnp1?=
 =?utf-8?B?MXBDcitxTGV2dExsZjlpaVdJZDJJT1ZEN01sRlFweWUwNmhBM0pxdThqY2Zi?=
 =?utf-8?B?a1FPUDZmVVBoTEZlN2lGemdGdk9NM01naDFiTk5JL3J1ZXhNa3FZS0dKYVYr?=
 =?utf-8?B?RTJPeWRubWllOUNXRzYxenJCck1IUmtic1hDYkJORk16MmNPWkwrUE1iemZG?=
 =?utf-8?B?bXZsL2NUc0tJbTR0N1J6OHJ2NTdOOU53SGkydDJEUFk3Z3ptNGFyTnFiUXNY?=
 =?utf-8?B?OEpaUW12eDZUZnppSWNta2VtRlpRPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EC0gM3y0Z4dAjgUJBDYVavWOAhJeX03K/t7CiaG+PbH3vBcnFTSI2uqq1P7SlEDiyumvhR3+dI0f0BbYMs/nn101L15bCuN+rhisxUGOmiF+GHqqN8Md5xHWrY1G8JSsPVBfPKGc4VEVYSHCVWU9wC3EvXrUwBgJTf5pMbB3KgMM0LZP+ro47Z+NJEPqtzH80hDv7Bu5HuZQlCoVq8bKlMViu+DwGE3eGS8hnQ/dYY/i0qSpQpZSy3hergEURc9JbkGLA/Xhd5dtZw1g/j5hjo/zrXXZNkqNWeZPCGVP4GENe4yoTmF6oOAS5nl0s3NWeSGX3mY8LG6Dceh0RlTwWl+ulIBGH+SHdPxlHzejMVOsQ1+azpsf9fiKkR+BRhsmtNritfq20kAEwsKTisNTqnaJ0a/AkysIPAVGM9fFuNZeazh+9k/Xh27yBi+8mHrv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 15:50:09.6562 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 463ee0c7-f49e-4bae-442f-08de6d731074
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9749
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

