Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35183C27C44
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 10:49:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BF1310E3DC;
	Fri, 31 May 2024 10:49:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4stvtjpe";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E427610E31F
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 10:49:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FfDlnpfpbJhQfomoSR0WdPziU2Bj94eS4SPlNypQInZQQ64dGnLVFMLspeaWv0xT2JY9a/eliachqj27pvgptMrqfxndMVPJ442A6Qf68LcSwN3LCKLKy+kGekzyuqICLcNTkFCIR4wj4Mg4hE/JRFXt4WYLHuxnU1ADnH+Td8XDJtaeKmg+wz30Iz91ZINYuUm5a5ZlgXqRvfK03uPeFXm67sjiIu1ag2xIl1yrcIXISsqBD+q5G6G+YR0ngbKhOEaq3DFWhiYue0VSoXY+9KnAHUwev2fqXOYxnMeuu00FuB6ZOtyrleDqrc6IJDjw1KEoOQihF9MD2fidfTl3RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MMFiWr5MGF9KnGhRr+FoCb2y+VfTnBA7aWcz7LgtGY4=;
 b=W7gdlbQCUidMNZX5jgASqRUolCM9HGls3v1Uw+uUCwm2RIwcq86UDOAi+R9iYCVGPm/KUiK4FdBg9j9TtjlUKzaOdI4Nh71DMMOyA7B0a7+ihtG+4I9PPqq1jvvF1u77e0US3/ZvHtxOseFFTVkdsnd97r7Zxgg/9BiauyRSOmqmhHtQSks/tYgIhOI5Md2stfZU/4wBC0PG2owbpq4sJDU3d8YkDICLV/SvGcdVe91o9yEoABMfH8oeMZsisqCn/m4oP0d/Zvs1VeftwKQycN0fmoYaMSbuCaN9W3QtAePF7kkZYdqjSPZPeAlqYijZdAtPLhQNS/MNImF6YV1L0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMFiWr5MGF9KnGhRr+FoCb2y+VfTnBA7aWcz7LgtGY4=;
 b=4stvtjpe6JjXoYKXIHhGz+D2uSE1GCRLgHHZSTuuXKqf9LjXfokiugqSxCFLRMHjATZO9YlXUNt4wwpv+dwC4QeGQ4u/nR0xDETYNG4B5T+Mqt5OQpnNBNZBz9bIWeU7Uo9yBuSwsYR+KdWLvv1GJZK39SXy78PH+Z7ApAyUnuk=
Received: from CH0PR07CA0016.namprd07.prod.outlook.com (2603:10b6:610:32::21)
 by SJ0PR12MB7458.namprd12.prod.outlook.com (2603:10b6:a03:48d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Fri, 31 May
 2024 10:49:26 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::94) by CH0PR07CA0016.outlook.office365.com
 (2603:10b6:610:32::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25 via Frontend
 Transport; Fri, 31 May 2024 10:49:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 10:49:25 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 05:49:24 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 4/5] drma/amdgpu: set fatal flag for RAS recovery
Date: Fri, 31 May 2024 18:49:10 +0800
Message-ID: <20240531104911.14748-4-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531104911.14748-1-tao.zhou1@amd.com>
References: <20240531104911.14748-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|SJ0PR12MB7458:EE_
X-MS-Office365-Filtering-Correlation-Id: a943c7aa-41af-4c41-476b-08dc815f56bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JaVB0Ntkq0jDjUOZ+X+T9ptB0ULcavuoVW4SFrNEvfCvuPuwlFUhZSNGpGNF?=
 =?us-ascii?Q?47wHOGVtbyj5FhfsBHLq7yAsrOAyTxE56mjDfOLyAUXhLtpRGAUxRTOLm4v0?=
 =?us-ascii?Q?dfWIZ/lSEnfg0f1z2LY9euAQMm0BsiDtKQ/AeT5cR0gO7/SasVKABedPJScV?=
 =?us-ascii?Q?WgEZbOnjxPz6B7TeYYO1NJZI1xMvlASbU89K2Ogs2LOOQzxr7GLJY4DgfAJx?=
 =?us-ascii?Q?dyjcmFvM8LOHHHqBDISQDkSQnKGmY78ebIOr5icQm5TcL/TJNAlSeKnbVUWO?=
 =?us-ascii?Q?LMIimQFnWLukbZzo+fhwQc05/vBG3xWR973oZKUkD45QIpTz4qEauZJ0nqnI?=
 =?us-ascii?Q?kWtXndb9n3TJgY4I7+0YcEy9XnKC0F37CdDY5WsqHL5arSOESmLVrCXitPWZ?=
 =?us-ascii?Q?Sixm/dvr5QzUySquQkHmFcyRdanS/+DGgN9bgI9RgyCSCTWVHYGBHjpGn/qZ?=
 =?us-ascii?Q?QERjNF7k2xWD8EVw45UvPpn1rTwYYweVSHxvUCWeR2HK+3HKVccfk/P4OO8M?=
 =?us-ascii?Q?z58moMOTKGptwyniR5vBrGnj5aUDmHd7uTaTGvwaTjFBTFuV+AZBznClOtDO?=
 =?us-ascii?Q?6NCNSGIOXpkagLAAKpdTqos6Z75ibMVWR6h8/+BFd+8xKvSQERAeJD2eu5uN?=
 =?us-ascii?Q?stGCkjXV97LFUB5zWtHceXvH4BCBurajpVMoCme61x/7AmAEhnopeyW3lKZp?=
 =?us-ascii?Q?260KqntokCw8b+YW822kOnji0LYnTo4vLg9Cp/OYzZOGP1LN46pF7v58S/Hv?=
 =?us-ascii?Q?X2SzbkHfVH9GApJgENJEBxd6F9nA159xi5Dx3BWV9nzdIIFxlpcaNclP1Y8w?=
 =?us-ascii?Q?Kc2uyjsnKIvgaSx6nrOdSM4WgTJw6VdX9RB44snaQ0kpPPiNONIlaWwLFfGw?=
 =?us-ascii?Q?nmYbM9tUyNyN0BxpPNGvs0IJhEbM43WVtI1boAZFyfHeix4Aum2VLCK5yDK7?=
 =?us-ascii?Q?wFfip4QVgtrH9PXNM4dAJU7gURzYlk/YAeEBfPcXhhVGOCQDkub/lRf/gOV4?=
 =?us-ascii?Q?KJbGNUqAfwban7/QqdSl78FaNOftubijZ3u5a3L4H/o/LokLN/irU5d29sX/?=
 =?us-ascii?Q?uw1VSSizGH+DnFrZljcbZW6FKxbgs9F0+6BEtI4n1A00bTgNd61k5uOWezZg?=
 =?us-ascii?Q?gp4EEQGFY2sb2SxdtgZnuTFc+GFIxNvgzPT6mrwHMRIpQjmnJ+NLFcs2iVl5?=
 =?us-ascii?Q?kP8860qlwbwVtKGSvcli7B2qWzl/5ZrSFDNJmx+toQSrhul96UlZPxZTRLKm?=
 =?us-ascii?Q?R5I6BHB1wctd1J6w8pv0tlSiPkKzExlGTKjyOUxKFntiBieyJov8ElHtQ3To?=
 =?us-ascii?Q?Vfpl2R544zBVWCzkSIqeo45ApLx12mH+I5/vHpfEddXBz09oGEOuYUkbi2zi?=
 =?us-ascii?Q?Kml7ssSctSBoPegEWCqxvd6NACE0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 10:49:25.5886 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a943c7aa-41af-4c41-476b-08dc815f56bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7458
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

PMFW needs the flag to know the reason of mode1.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c  |  6 +++---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c   |  2 +-
 7 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index fb5fc1fe6ad0..f55bff59052f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -940,7 +940,7 @@ int amdgpu_gfx_process_ras_data_cb(struct amdgpu_device *adev,
 		if (adev->gfx.ras && adev->gfx.ras->ras_block.hw_ops &&
 		    adev->gfx.ras->ras_block.hw_ops->query_ras_error_count)
 			adev->gfx.ras->ras_block.hw_ops->query_ras_error_count(adev, err_data);
-		amdgpu_ras_reset_gpu(adev);
+		amdgpu_ras_reset_gpu(adev, true);
 	}
 	return AMDGPU_RAS_SUCCESS;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index ff2d34dc9718..2071e30d7e56 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2070,7 +2070,7 @@ static void amdgpu_ras_interrupt_poison_consumption_handler(struct ras_manager *
 	if (poison_stat && !con->is_rma) {
 		dev_info(adev->dev, "GPU reset for %s RAS poison consumption is issued!\n",
 				block_obj->ras_comm.name);
-		amdgpu_ras_reset_gpu(adev);
+		amdgpu_ras_reset_gpu(adev, false);
 	}
 
 	if (!poison_stat)
@@ -2825,7 +2825,7 @@ static void amdgpu_ras_do_page_retirement(struct work_struct *work)
 	amdgpu_ras_error_data_fini(&err_data);
 
 	if (err_cnt && con->is_rma)
-		amdgpu_ras_reset_gpu(adev);
+		amdgpu_ras_reset_gpu(adev, false);
 
 	mutex_lock(&con->umc_ecc_log.lock);
 	if (radix_tree_tagged(&con->umc_ecc_log.de_page_tree,
@@ -2888,7 +2888,7 @@ static int amdgpu_ras_poison_consumption_handler(struct amdgpu_device *adev,
 		flush_delayed_work(&con->page_retirement_dwork);
 
 		con->gpu_reset_flags |= reset;
-		amdgpu_ras_reset_gpu(adev);
+		amdgpu_ras_reset_gpu(adev, false);
 	}
 
 	return 0;
@@ -3815,7 +3815,7 @@ void amdgpu_ras_global_ras_isr(struct amdgpu_device *adev)
 
 		amdgpu_ras_set_fed(adev, true);
 		ras->gpu_reset_flags |= AMDGPU_RAS_GPU_RESET_MODE1_RESET;
-		amdgpu_ras_reset_gpu(adev);
+		amdgpu_ras_reset_gpu(adev, true);
 	}
 }
 
@@ -3996,7 +3996,7 @@ int amdgpu_ras_is_supported(struct amdgpu_device *adev,
 	return ret;
 }
 
-int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)
+int amdgpu_ras_reset_gpu(struct amdgpu_device *adev, bool fatal)
 {
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 37e1c93c243d..ed5793458a70 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -878,7 +878,7 @@ bool amdgpu_ras_is_poison_mode_supported(struct amdgpu_device *adev);
 
 int amdgpu_ras_is_supported(struct amdgpu_device *adev, unsigned int block);
 
-int amdgpu_ras_reset_gpu(struct amdgpu_device *adev);
+int amdgpu_ras_reset_gpu(struct amdgpu_device *adev, bool fatal);
 
 struct amdgpu_ras* amdgpu_ras_get_context(struct amdgpu_device *adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 151f83ea803b..f976b6deb42d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -129,7 +129,7 @@ int amdgpu_sdma_process_ras_data_cb(struct amdgpu_device *adev,
 	if (amdgpu_sriov_vf(adev))
 		return AMDGPU_RAS_SUCCESS;
 
-	amdgpu_ras_reset_gpu(adev);
+	amdgpu_ras_reset_gpu(adev, true);
 
 	return AMDGPU_RAS_SUCCESS;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 4a72ff8d8d80..2596a1c2a64e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -198,7 +198,7 @@ static int amdgpu_umc_do_page_retirement(struct amdgpu_device *adev,
 	if ((err_data->ue_count || err_data->de_count) &&
 	    (reset || (con && con->is_rma))) {
 		con->gpu_reset_flags |= reset;
-		amdgpu_ras_reset_gpu(adev);
+		amdgpu_ras_reset_gpu(adev, false);
 	}
 
 	return AMDGPU_RAS_SUCCESS;
@@ -247,7 +247,7 @@ int amdgpu_umc_bad_page_polling_timeout(struct amdgpu_device *adev,
 
 	if (reset || (err_data.err_addr_cnt && con && con->is_rma)) {
 		con->gpu_reset_flags |= reset;
-		amdgpu_ras_reset_gpu(adev);
+		amdgpu_ras_reset_gpu(adev, false);
 	}
 
 	return 0;
@@ -266,7 +266,7 @@ int amdgpu_umc_pasid_poison_handler(struct amdgpu_device *adev,
 			 * let MCA notifier do page retirement.
 			 */
 			kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
-			amdgpu_ras_reset_gpu(adev);
+			amdgpu_ras_reset_gpu(adev, false);
 		}
 		return ret;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
index 9cd221ed240c..07c24704c4b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
@@ -98,7 +98,7 @@ static int gfx_v11_0_3_poison_consumption_handler(struct amdgpu_device *adev,
 		}
 
 		if (con && !con->is_rma)
-			amdgpu_ras_reset_gpu(adev);
+			amdgpu_ras_reset_gpu(adev, false);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index b8fc9e126e0d..0935ed57a906 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -414,7 +414,7 @@ static void nbio_v7_4_handle_ras_controller_intr_no_bifring(struct amdgpu_device
 		/* ras_controller_int is dedicated for nbif ras error,
 		 * not the global interrupt for sync flood
 		 */
-		amdgpu_ras_reset_gpu(adev);
+		amdgpu_ras_reset_gpu(adev, true);
 	}
 
 	amdgpu_ras_error_data_fini(&err_data);
-- 
2.34.1

