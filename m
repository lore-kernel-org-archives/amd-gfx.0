Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 267A9F94CA1
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2026 17:59:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEA5310ED60;
	Tue, 21 Apr 2026 17:59:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qYfMUny4";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012071.outbound.protection.outlook.com [52.101.53.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8886810ED42
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 17:59:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tCvIf9tl35eaVgvPEehqxwnloh5thPeAqqaHEkiI9MXgK4RlDefMUDANCyPGFNvNcieRXi8kXxSZlXIDKaIY37sbQ9oSZE5evQTJPsikLah4RT59tNVP1ZIJToOpAL7ZuAA9SQhjTRUzisgN6Gcz0dbG6xp7HU6tSB0eW3ZZSyepg36rT7XJ9vprjHwIAeU3gSybQejEOCLaWNrdWnSwEoDZrQGHq7qcLJ7WPubeAKZmYxGLmQs40eElOMReSho09SJ/Ewfp1vylvf2ndKqe5WPubk6grjwqmnTxhmzpcmeSSyVxMW3jA2ft4pxd+JCuySoiVE2g7jtvmSWGfpxgSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQml/bKVo87LkuAGWgjfZpIyv8Jpl/XyDRa26mRcDXQ=;
 b=nD7Mnu5OOyU+Rhf3EnScPcQ4+DUP8XPgnIy5OUnvEZzA15Km9Sh9/pgYmWau99yTKwyiNc/i3Zf0U5fbH+zRJxqz2Km2xPbPN+ovfFdEiSxkJ8d+1Z0asTcJBWQonJ3On48X5VMIvS5UCfEBQcW/ZIeuwTY1BtajF9j8jngF5xva3E++J+iHkAdejfaY5YUTXqWiTqwEjJikC4omMFhvh7Po99sYIIkbUrCbzmR3EVvgAWYunhZgKvpgcEpBl/59cbFcxHX2+FTBAF3/VlsbQvkOXB6AAExWz8vwFp6bE+7Ksd0uhWoMXAjxLClObYXYXdvrBUMhVnU/DSvdrDU4pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQml/bKVo87LkuAGWgjfZpIyv8Jpl/XyDRa26mRcDXQ=;
 b=qYfMUny44RMI8GHNQcVyja2IEGDopIwnIdEmyppDhlozDW0AdnCYTYNaQ2xssNAxxa9E3VlvYND22lYoFPmQ3n+10rdWv3f/eji16fpEGZDFzFdkdIFISF4RPKMSm67H5IvdjXC64lG3UIq8RDDtJ5TaCqNogt5oqbTBI4PjFOI=
Received: from DM5PR08CA0059.namprd08.prod.outlook.com (2603:10b6:4:60::48) by
 DM4PR12MB8572.namprd12.prod.outlook.com (2603:10b6:8:17d::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.16; Tue, 21 Apr 2026 17:59:43 +0000
Received: from DS3PEPF0000C380.namprd04.prod.outlook.com
 (2603:10b6:4:60:cafe::26) by DM5PR08CA0059.outlook.office365.com
 (2603:10b6:4:60::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 17:59:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C380.mail.protection.outlook.com (10.167.23.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Tue, 21 Apr 2026 17:59:43 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 21 Apr 2026 12:59:41 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v8 10/11] drm/amdgpu: Signal MEMORY_EXCEPTION eventfds
Date: Tue, 21 Apr 2026 23:29:07 +0530
Message-ID: <20260421175908.2402019-11-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260421175908.2402019-1-srinivasan.shanmugam@amd.com>
References: <20260421175908.2402019-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C380:EE_|DM4PR12MB8572:EE_
X-MS-Office365-Filtering-Correlation-Id: b141e2f8-86e9-4b04-b0bb-08de9fcfc428
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: P71MhqxFU9TZ7Td/MaHvOi9phRUQpnFbwl0UegIFc4Ir2M8oIykPxXKJBZ5hWZa80ppJSuToAptVPT2NKf+RoOG68yD1HlqMHyRfqz0/mFTjfI+5J/IGi7Dres1XWzHFmG8wO/kOkcruu3GDIYTEdMJsy4fBQCcRjRjYhrcf1i8usUgN5HCKvYvoKAwnVvwQd0GSQlCc0MN1Ud2aiO0QfTQ/h8OlKwA33pVpGFOHBfvChGIgqPdZI0ZonmbOt5hDmR3y3z72X8soCxy0Fzpb8nOnVcajdqNkgUZXzI6t109oxaWUIZAbrqpuGT0CayIjot/V7+EOuUb/dpGjSy4I5h8baa67vRhOAd/EEW9pGXWY5HLn6/dGCOl/nxa/HTyf9Mko6spw3ipovl6IAGtILfaNjQC5Ol71EAe0m+QZINMLkR99nRR0A4L2bNEdBkZpBdZ22eflH8QeVX7v6x37lNnIwVvVrUX0ld2s5Huk5c5SQQ6xOtbWuQbLacFENuFn8nsVfNhPWPqI1ilY2UTdkhnN4RetC9z3IqyWh2EDwOlCec15roY3MDgibF203EYzl4cXGHTB8v5cxZm0ZSOfQFanXetbg2NXRhoyT70/iiSMAjpZbKQ1IzCF04rhwvAeVomYhBxPikmG/HhUV2ZTrIUIG8+Pot68veH6pI1mwHgjeXVzerIdLzN7NMFiDFdtrhsXW2O5j+gECmS7YdYxaCeXu/8F00eHT1RPFIw4qTLoJFDkhx/q25HHWm4cFlKL0GmowGAX/qzVTYGcZYeXxA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BSRzhPkil/ddutsiZiWRJXXFTPa2D36KEftWdLBeGinCZ7d3MAWPD36oigFQxcoXoB98m4S0KqX+IAZH+PXZ1GkKmD7iuQyw04ojuIaX0O2dhSq0YdrqJFOQIyjmVFvCGGmTk/uhbNyotqs653V+qt4v4WxlZ+4mqT1Her/Dx4KwnxjTFudCRl1RiCBjP1G2h5BxFuL16N50aiAeacu4OGDI8qAfFpPrLUAadsQMpTq0FvhDpmKNtGXcghuZBZ0FPtHr/Wxyd0XstiscEvqu1DIOo0F2hVC7bWn53abTrhTo1iSZ0MPfjjroXqjVG68cyz56rnAT8niGALNaglIOvfirg/e4gvhwPzCAr0dtCCAewRhG5YdDgyZRa1FpffVVVQCwzpoNy2DacdaYxCmRgbX1SRZTaveY7/FF2x7hD8ZXhHfWoNQ03lOD523h9qWT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 17:59:43.0798 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b141e2f8-86e9-4b04-b0bb-08de9fcfc428
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C380.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8572
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

Signal MEMORY_EXCEPTION EVENTFD subscriptions from the KGD-side VM fault
interrupt handler.

Reuse the existing VM fault interrupt handler which already decodes the
fault address and status. MEMORY_EXCEPTION subscriptions are currently
GPU-scoped, so eventfd signaling uses queue_id = 0.

EVENTFD remains notification-only.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 94d6631ce0bc..d49fdb70045e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -135,6 +135,19 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
 
 		amdgpu_vm_update_fault_cache(adev, entry->pasid, addr, status,
 					     entry->vmid_src ? AMDGPU_MMHUB0(0) : AMDGPU_GFXHUB(0));
+
+		if (adev_to_drm(adev)) {
+			struct drm_file *file;
+
+			list_for_each_entry(file, &adev_to_drm(adev)->filelist, lhead) {
+				struct amdgpu_fpriv *fpriv = file->driver_priv;
+
+				if (fpriv)
+					amdgpu_eventfd_signal(&fpriv->eventfd_mgr,
+							      DRM_AMDGPU_EVENT_TYPE_MEMORY_EXCEPTION,
+							      0);
+			}
+		}
 	}
 
 	if (printk_ratelimit()) {
-- 
2.34.1

