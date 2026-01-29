Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1127D3566C
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jan 2026 04:39:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90CCB10E7C6;
	Thu, 29 Jan 2026 04:39:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zCEyD6+J";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012045.outbound.protection.outlook.com [52.101.53.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C83B410E7C6
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 04:39:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NVF+SHj/JBTrXPkAP5O16BTI5rgoTZb6RpBomANmvg4SrA1RqOW8vtYChj2wC5NjYytYF+9Qb8dSp3qy7n29K13UrW1dMxPflcixybWXtU2cJ2bg7aL0/F29tNHTCd19hAUM66qQqdwl1d2ZMXKSA5n4vh79VPpjGXARYZ4jQUpeCW6GTD7uPAjhRfbI6/P5KA4pa8qDSVpXzwKGPdOAohqn35XaiOtudYUyoJEoc7CJyodE0dtK1tqEooGA1m0FpI3LX1I0T2I8dhjjgmNkNYGB69e/Pi5LFmUuaa9x2pmLgo8oFH5E7bwDtgyyFjJH4LU5k6gG4XzPiQMok9iQ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HYpWcakkuGVCJUVCG6s7oXiSkX5T+Qg/8lXs22t7JI=;
 b=fg7u3zD76GDI4Jx9zFKuVI5VBd4f7oprHQ+8tmQdq8tVbRfamysaAC43S0hvxk2Id5oSqFfryiclmm1Imv1Zz7R5nYszFg8nByEZjppkYgzLdxAjO9p7aIXUOs5uN8kayskApUzBtMU19Ozp5EQjZ1f9ko8JMdl2zrlHW8QE9GwpD/hb/v6HviPGK6PJ2qWU4htnQeh+/e+sijft/y4KdnEaQoK5yDeAL+mtRKGYjPm17SG6tZrz+V3CvKiX3Xlp9x3zXvchbbrXWPMN52PIr+qO5VuHbMIJkb++JbzllaicNPZI/XCXzZGeQUMb+7/IB4UDOryGBUi/etufa27fZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HYpWcakkuGVCJUVCG6s7oXiSkX5T+Qg/8lXs22t7JI=;
 b=zCEyD6+J2gqA9GOw3aMh19gBctt6Kf4PjIy7vKAbPJbHD8bO1PsTtGmfvK3iu2TD/Ty7Eojh1LKxfLROGKFL4nQKyXlTTgqpypK8iPIuj24YPjYB+BK4zA8TsjTSTf2j7cPeiTS5e+8tPQ5+ebx8fKHsfTx78sQoxd2Cj/Ne368=
Received: from SN7P222CA0023.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::31)
 by CY8PR12MB8362.namprd12.prod.outlook.com (2603:10b6:930:7e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 29 Jan
 2026 04:39:47 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:806:124:cafe::29) by SN7P222CA0023.outlook.office365.com
 (2603:10b6:806:124::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.8 via Frontend Transport; Thu,
 29 Jan 2026 04:39:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 29 Jan 2026 04:39:46 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 28 Jan
 2026 22:39:46 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 28 Jan
 2026 22:39:45 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 28 Jan 2026 22:39:45 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/gfx12: adjust KGQ reset sequence
Date: Wed, 28 Jan 2026 23:39:36 -0500
Message-ID: <20260129043936.33607-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129043936.33607-1-alexander.deucher@amd.com>
References: <20260129043936.33607-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|CY8PR12MB8362:EE_
X-MS-Office365-Filtering-Correlation-Id: 704c5929-5f8b-4c02-65f0-08de5ef06e4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RIHSpFlORef/BGtzOwWJSDicsOg9QODh2+hZDDY0Dq+jK5kiL6BmpI/MhLie?=
 =?us-ascii?Q?69Rc/OBAbVw28i1C+ivSQAK3BBLYbu31j9gQq/7ZB7q3Gb0ApVWLsW0Xc2se?=
 =?us-ascii?Q?hbx+qRWqG4KXRXiGUem5YrbgjZZLs9gVFLLl5Jo98rubu7Qtqb8H90uK8UTN?=
 =?us-ascii?Q?ZfvodUJ2UrVS/+CUn+gopZlX/Pd7stonZCGIVfsOvjnoZp+KsjXn5LQwPUxd?=
 =?us-ascii?Q?8tnpSQngcQPFnGzipem5rFJne4OKVD5akitK5Qvqk0DxnOXtqjFZKA0y6XVs?=
 =?us-ascii?Q?CkbQo2hrgBfmzZvPxtsCTTFP0I53soso6Sjmy0AjUMwOorIszXiwuTgHeIaB?=
 =?us-ascii?Q?80wRvla/JQakWB+K67/SzzZsHGO+q2n228T4jTvk/ryBRFIdvoqgS2+JbaOy?=
 =?us-ascii?Q?evSP7QYNyNQhFrC9kfwnPF74GaI3OgzG1jBVMGbwtZ8y7HNtr6DzQ8GSOomI?=
 =?us-ascii?Q?dy43dhkW/IbFvVd+nMUAeb8CcrSt7NP1G0aWQsC8vzFsOKBjDyb53mTGGZx2?=
 =?us-ascii?Q?75GvT6ZfzJieLkSlumDjAi0Rs8YjJQpGtFLeq+/S1Chkd4T1JRYfzi3+h18g?=
 =?us-ascii?Q?2eY2P2eLH+s3elsIcw5bTVmCv0Y9PEYEwaJ8GBeWIdP8kfgOYRJ2K7J4T7nL?=
 =?us-ascii?Q?tCsR57ef82TEI21yv4ZnpWwr+p7RvZs7TzOKYxCgsAbBZn5echSqF/4DHjoY?=
 =?us-ascii?Q?lUVBjPRCuQtXJpMwhJxkZx/PN22QKGTHzPSgmqgyim9amFh1yl1XfzZPIda7?=
 =?us-ascii?Q?CnLTRfevhKhNsCCu+AvgNGizXXo5fTv1UCYHYMvt4XANewi7FcShfHBDVqfq?=
 =?us-ascii?Q?KHU6shPnvjV12BelBzcyMWX/92QTRuV8VB0P/gjEDJZxXy7W8wyurSf7Hunq?=
 =?us-ascii?Q?qpON8rcJRgJXaJFHHOwbM/EI/BwKOP0DxRUb5Yb05drmQRtsxjhvjo0mAo+g?=
 =?us-ascii?Q?gmRBX/Ap7I24+OYgpOmZTIb1wEYfsVsyNXc1/9eZ2fHHjA8DSk6Z+RMqUWui?=
 =?us-ascii?Q?q7ZGqf8h19KWPa2Cjg/QUh2VfNHIPIh58JQUs3w/uoPp6BdxmysWrkjsZrc0?=
 =?us-ascii?Q?7hkJ0fz2h5yK2guueLQPl1R+l+9J/u+A7P0sBO3KGNXiedQ2STzyaUpwiRpF?=
 =?us-ascii?Q?E8zZDepPfjaF/ZXhopl8eZ1Ijfww/G8X0cLisBzzAoYfs3osDm0iC0qqmPaM?=
 =?us-ascii?Q?LXwjaZ/iuBnI6jlNS/y7/lBPIWMO/sKztLRQjTpixpWmSp7FEuL41OGvBM/N?=
 =?us-ascii?Q?oacK1xBuF5P0u535MM3FrlhTzQ5SO7mAIwEsBe/C3dBTTLl+h7YnXLmERSjy?=
 =?us-ascii?Q?iwwzTrd7SrButJUtQ7tJcq1RddqVXxkuLDnnyKs3nviJ57mO/ql33DBmcjlL?=
 =?us-ascii?Q?+4hJYk/aC+jxB2QA06/J2Wtt9uq6UmE0u+U7RTZ9b198UXUNq+yqxZKH6maG?=
 =?us-ascii?Q?+f3BTclYCZDhXtCQGeaTye5jsQhEGMnkmORpKp6fcst3OhyQ5/+8ryJiAkKv?=
 =?us-ascii?Q?RnSngR+Y4E9WNAJVatvOqTqeEHva0GEENxr5+J/8wvfWm93CDz1QOCixCvQU?=
 =?us-ascii?Q?2udlprVElVgmtL328JvbBCpAJKoFAHTzl3VLfiEPTrbjIwISfyc6+Sk1A7M3?=
 =?us-ascii?Q?WG4yRB04p0Ghp/CSGKGG7KRoYN8Vkl8ek92zVZCQ59XT+4TQ9dQz5kDiiiaO?=
 =?us-ascii?Q?UPinjw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 04:39:46.7647 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 704c5929-5f8b-4c02-65f0-08de5ef06e4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8362
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

Kernel gfx queues do not need to be reinitialized or
remapped after a reset.  Align with other gfx11.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index d8ab93c82366d..c87f5040d25a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5318,18 +5318,6 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
 			return r;
 	}
 
-	r = gfx_v12_0_kgq_init_queue(ring, true);
-	if (r) {
-		dev_err(adev->dev, "failed to init kgq\n");
-		return r;
-	}
-
-	r = amdgpu_mes_map_legacy_queue(adev, ring, 0);
-	if (r) {
-		dev_err(adev->dev, "failed to remap kgq\n");
-		return r;
-	}
-
 	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
-- 
2.52.0

