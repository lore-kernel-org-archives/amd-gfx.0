Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE99ECD5BAF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2026 00:21:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E64810E57C;
	Fri, 22 May 2026 00:21:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eeguUNbP";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010011.outbound.protection.outlook.com
 [40.93.198.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 043C510E57A
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2026 00:21:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J0mFfcgv4pugp2qgIKA1EJ00sVwQe8lTUq9MhhZz0Dicomu9PyvrKuzswVm7CnYkKrlcribE96ItUSn/n8y3AODfW02s23AtyiSs/H5rk6owDa+ttrxWBGBVIKGtogw5LGASXa++Zby860bfd62B8yNgCgQjRPLpmWmwxwWmRNsq4Hw1y+EMCeRGnGoNBrhiMWxlthER68NynNc3JBTRSHF1OG1SdcU7e0pTLQrUgi7pMnDrYusdXhDHHnp6v3x9UZgO6Bei8xbPZsu9c6jBr0rhOu/aBtzCt9Brte6kk2JFX+1oOTYp2LD9Ti6+jos7wkoRSaf5cMS8hcijKM5akw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQxlCAta+Z6kCv3WaIJdR48+fB91sHgyQtm9mN2Im+4=;
 b=cniJXIq1PBZWM8Wb3GVOoIHfdt3lN8co9tGixYV5YyN/C+eNPLdxHTf86DtaDh7jcfXQ4gpDQjuiA3F3z94vthRgNv1Gu+8cfFBAF5lJkWwfGRvBQM9AOhop3nUGNcDtyZhnn2Vgn0nKERm6/VqBjrb4SVJ9NwYmolxl61QRTnLfcwUzZMpM6uzNLCHi0v99RBI/4FtflDw7RZ2dOmVxI42VG+WoQhbectymEuXLfs+1rdGiqr8sziCaIJ5JEz2L8nZIVe5zFfvJTDMuo8fA5B2ccuuQt87Lk2YLQVjGGWdsE184oRqR3nCGwl3mTu6bKTXLY9++VIbwfhSYmk3Ueg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQxlCAta+Z6kCv3WaIJdR48+fB91sHgyQtm9mN2Im+4=;
 b=eeguUNbPdTxPBPsDBzTwzwOMfny3cLRn4YPvb8n8Ax4hhSlU7Sy0sOATpMsUEb8D+T+kTg8xvDL4I3KB66QEnsmjyWX88dsMmXmiMIklabXQjmG1RcGlWJeof3DzBX9/x8nXJTq+auu6vTDiooi2ydH4/bi/Cy6rUx5zRXaNArk=
Received: from DM6PR17CA0007.namprd17.prod.outlook.com (2603:10b6:5:1b3::20)
 by SA1PR12MB999086.namprd12.prod.outlook.com (2603:10b6:806:49f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Fri, 22 May
 2026 00:21:39 +0000
Received: from DM2PEPF00003FC3.namprd04.prod.outlook.com
 (2603:10b6:5:1b3:cafe::23) by DM6PR17CA0007.outlook.office365.com
 (2603:10b6:5:1b3::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Fri, 22
 May 2026 00:21:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC3.mail.protection.outlook.com (10.167.23.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 00:21:39 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 19:21:38 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 21 May 2026 19:21:27 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sunil.khatri@amd.com>, <Amber.Lin@amd.com>, <Jesse.Zhang@amd.com>,
 <Shaoyun.Liu@amd.com>
CC: Michael Chen <michael.chen@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Shaoyun Liu <shaoyun.liu@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>
Subject: [PATCH 12/42] drm/amdgpu/mes_v12_1: use mes schedule pipe for legacy
 queues on unified MES
Date: Thu, 21 May 2026 20:20:18 -0400
Message-ID: <20260522002048.98506-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522002048.98506-1-alexander.deucher@amd.com>
References: <20260522002048.98506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC3:EE_|SA1PR12MB999086:EE_
X-MS-Office365-Filtering-Correlation-Id: ddc0ed4e-d803-402e-cce0-08deb79817b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|11063799006|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: DbKgmSQYMZjy1DqLq4HCL4oFMJ/RsArvxbzpwIvO8KbS3H18Ti9tXhPF+BfuxdZej2OJFgDbXhLfFanoWd6nvBsEfZKCOLAchRY/MuPtA45NdcqFcjp9mRXvrh/rVvJGIOc8HBQmtP7EA4a6POEMf318fsC9C62o0B8/W130LeE7ngJvoW/8Ajg3SRX255fuyTNoN7JpX0FFLR+3pPOj88/1nniP6K9GgUlHhRIXsZysLIldjeCNM2vWPfqQ40343U+HzkuYbJ7266dC399Ytbkl0E0hvplapbBIDyzW03H1ly5ZdxGpd1+437woq4k8Sx7VRcf0pKKLDug/5OSmk9zEsqUVMI+qh54HIB7J6wuq3Kp2NLjGHalDwkix2srZbswDsM5r1NxSX44dBw+kwvr3OvIljKETPKlaqDSzyHGVeBSHiQpjsFJF490bSLg69bza+TqU6fgcyXYyNBq4XYzkwr886ZydZD03c1GdNSW/Eoxt0lBUTcZtHjdFtEQukH/CTmrbnuyZKiXzLOuYpYDiVS0aIKuDlJ7enQDIYIzb/g6jDLPusvcjAo/ryl3DkegD4gDQdnDtHDuGvSO3QdjlYZA736yztgfQ0UQn2BRGLrzl5BcTv3S/J0zzEMGbfAU7bzAg6zX5cB35VXu3Z1HZtNfH95WqvShTyAZHE9cgeXz+fu9oVD6SN0EZSKHp+D+dbrxziDMTxkEB0E0kDu17U8PMtZcipaDHTPnopZ0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(11063799006)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 97nKX/MNFw1NCUNy4x371c6VUjnPO9vuLx+7A2p9Mgl1ArETnfOPSrK19v+wGEsbEU3N6fih7zeKWmY4yM3dbjlgk++KT4TVE6YtVYpEM5viCyFok91FcTTSNtuGuijV7di6Fx+ymBhQFF3jplE55iy2p7zEPRuEldlulGJj95/9VNY8x6cGh7fy6A8P9j/uF/SM0n7SvksgGNLj3UIg6GcWJgrp2jDU8Dw0Ekr74yqJYRL4Za3G1TRxHZMT4djOqea6Pj2IkKI/Z2dkSWWgepoXroe08BwLR9Zhz059XrukR+1RSYYeLTZAUiNwUJ/q8gcXKrokjOVZkgAwYn14fr+mbsdSQ+1eypmDdQRaie6qVxIm026VA2Jvxm95KgmZ49scIpfKJLYHhGAL7oPNFLoGxQTvsrld0WTiewf5tIBNWcdewtD/tBePc8JdlhST
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 00:21:39.3715 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddc0ed4e-d803-402e-cce0-08deb79817b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999086
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

From: Jesse Zhang <Jesse.Zhang@amd.com>

when suspend_all_gangs is issued to pipe0 MES during system suspend or runtime PM, pipe0 can only suspend and resume queues it has tracked.
KCQs registered with a non-zero pipe slot may not be correctly handled, leaving them in an inconsistent state after resume.

v3: fix the schedule pipe issue

Suggested-by: Michael Chen <michael.chen@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Shaoyun Liu <shaoyun.liu@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index b169e577e5838..2099beedd5755 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -417,10 +417,15 @@ static int mes_v12_1_map_legacy_queue(struct amdgpu_mes *mes,
 		convert_to_mes_queue_type(input->queue_type);
 	mes_add_queue_pkt.map_legacy_kq = 1;
 
-	if (mes->adev->enable_uni_mes)
-		pipe = AMDGPU_MES_KIQ_PIPE;
-	else
+	if (mes->adev->enable_uni_mes) {
+		/* Keep scheduler queue on KIQ pipe; map all other kernel queues on sched pipe. */
+		if (input->queue_type == AMDGPU_RING_TYPE_MES)
+			pipe = AMDGPU_MES_KIQ_PIPE;
+		else
+			pipe = AMDGPU_MES_SCHED_PIPE;
+	} else {
 		pipe = AMDGPU_MES_SCHED_PIPE;
+	}
 
 	return mes_v12_1_submit_pkt_and_poll_completion(mes,
 			input->xcc_id, pipe,
@@ -457,10 +462,15 @@ static int mes_v12_1_unmap_legacy_queue(struct amdgpu_mes *mes,
 			convert_to_mes_queue_type(input->queue_type);
 	}
 
-	if (mes->adev->enable_uni_mes)
-		pipe = AMDGPU_MES_KIQ_PIPE;
-	else
+	if (mes->adev->enable_uni_mes) {
+		/* Keep scheduler queue on KIQ pipe; map all other kernel queues on sched pipe. */
+		if (input->queue_type == AMDGPU_RING_TYPE_MES)
+			pipe = AMDGPU_MES_KIQ_PIPE;
+		else
+			pipe = AMDGPU_MES_SCHED_PIPE;
+	} else {
 		pipe = AMDGPU_MES_SCHED_PIPE;
+	}
 
 	return mes_v12_1_submit_pkt_and_poll_completion(mes,
 			input->xcc_id, pipe,
-- 
2.54.0

