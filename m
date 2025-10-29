Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9407CCF9EE
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 17:52:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4341510E216;
	Wed, 29 Oct 2025 17:52:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lHx4eV5N";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011045.outbound.protection.outlook.com [40.107.208.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87F7210E216
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 17:51:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IedOr/9O9DqftYQdwPypSKvFgzra0B2idtVGq6V+KTzW5e0+ex/0WvbkHiin2tRN+E/2ZT7iR9tZtHo97CI5n3KRDP9mnXt4x45/TZ35I+qKczBauyXZ9KSpfeoSEv3vihEARCm7LWkNRH8fMZqfSLXELGZefXPhHa3m2uq8B/SLpmXzJ+fbzsCSZQZHYrKJY8eI3gmvH1gmSiRfh6sICUsu3ashemnKaCXqK9jS8WuHBdTX5vsIaliAE34L332A/aZXeCb/dhqbSlN38Iafa4t6rVaFnjbv84foVilGkhEwzRAi2R/cFtsvmwHhH1M/1u8xjXrIVz+VfmNhIu6irw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q4zx77Z7JY3QPFRL77dJ7e0UchxPWdJpS4CxPrVM2Ac=;
 b=xj5cgPi72D2Hb51v8GEAx3PgYb/muivF5zXE5Wf7JWFGCXkMgdeQTQkeoISduMJLucWQEgvPxUwov6PXAbfiG4gIuGx1oS/4BzzGxs87lkdYovaNeNiVP076c9+R2M0bS8aGOmz3PIncG/ALX/Tzv37wOgnKGkt8+Xs5Ufli1WQFlxD/iJwV8mdyGFIDAY5NjXRLcS/Q5O7uQcu1jGjQNTxQNAuCGD93/WptHC/V7/Q3JiusoHfo63bJM2DyDE10TIACNuj1T6X6xQD46vYsRL0CcaSwlZJ9zMEcFHV23Ut5GDToZv72j1VzFoMHNM9m9iW1TGH9X6F1Dd6qnvlLtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4zx77Z7JY3QPFRL77dJ7e0UchxPWdJpS4CxPrVM2Ac=;
 b=lHx4eV5NDoixoNChqsnRHWxCKaDrD22IAVI4Ea6ZL8OMgs1/EOOlPVo8w6hApuEXLOYaRY+9sBIY/4la2Owhyj2wp8pjxPH+MT8MqmDoMsDCexdj1t15fqyJSAUbAiIJY+11cqGcm/MCS/WNMMxBAHN2tpEkihlczzExfRLGAxM=
Received: from BN0PR08CA0004.namprd08.prod.outlook.com (2603:10b6:408:142::22)
 by MN6PR12MB8592.namprd12.prod.outlook.com (2603:10b6:208:478::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 17:51:55 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::f0) by BN0PR08CA0004.outlook.office365.com
 (2603:10b6:408:142::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 17:51:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 17:51:54 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 10:51:53 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdkfd: Rework reserved SDMA queue handling
Date: Wed, 29 Oct 2025 13:51:25 -0400
Message-ID: <20251029175137.2861556-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|MN6PR12MB8592:EE_
X-MS-Office365-Filtering-Correlation-Id: adc53d57-e4ba-41b4-711d-08de1713d8cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ySaq5y7rW2UUhtG3XeNhgRlDHM67wuoqG2OiOOjdg0vLsByXDEvabqnBfaT6?=
 =?us-ascii?Q?GGB6EOzFg2hv01WAPkodHvcSrAGH4ZUVOWgs9e16c6fc9XfFSpuzx2IjTe0Y?=
 =?us-ascii?Q?QSBeA4+N/UmRio7pn7DDcuj8uunp+kkXmEUlBLfbCDePMj3heLUU4lhIYjzH?=
 =?us-ascii?Q?uVz/ewiB9kVJxHuTsEWyx2EUVM0zO2riCisKQy5aFgwdlj4EuZGb0eGtrIrt?=
 =?us-ascii?Q?DtSlsv1F/dN/DyWyyke+4th2pjOgmCMqZVfYtYM8zPV7zco+gpkrBxunswBc?=
 =?us-ascii?Q?qDsSEcwltbxdkcsRp6pIKzgpWWf2vfs0+257ERI/0+DT3dBrnkGqHCwb0QZc?=
 =?us-ascii?Q?sxpQ2e9NpW95+TGHE9uBrUhy327T/bHKztA29lXmxRLPlhKpWrtj9HXLCwnh?=
 =?us-ascii?Q?al9CyR7Z3AIYhDcDIVSP+h1SATLA5oxXDEYjHzym6DXEelEfuvyUKA802CUl?=
 =?us-ascii?Q?+QZI75i6fhzJpM98USasw76iRcxUetEVn5SA/8/ydQWeqfb1vZ8Kslf4g5G7?=
 =?us-ascii?Q?aV70f7ZZjMeK9v+OiBsuObck6Yx+cDmxKrMcQixrGTxJVliCYUzKPW7vJ4AW?=
 =?us-ascii?Q?EO0U19rGKS18XIqrO1iZb5oXcnL05TfhxizF95U0tfYbbd+coAy3C0o9u6MP?=
 =?us-ascii?Q?aTLdP3+cGf+9+RwfglTbXQPaKTlf81J/ynJn5vjtXMqDEzSV/V97Lsj29PMC?=
 =?us-ascii?Q?wnZZv8iZHU88T9sQIxp6gDt2Cy2S3Ul2CVLKrmqnTqJV45Deja088f+3wrXr?=
 =?us-ascii?Q?VXRD4Jd9qKMgN/TVk/AcupJo0Wtg23UxVPAQ9S/LY7Y6dBoM/Mo1i5QoVzQn?=
 =?us-ascii?Q?C65WrvBYq3djup+R/vpSB0815RZgQ8W63VosE1EzPpXZXxmfLImFQHsJshpn?=
 =?us-ascii?Q?15pLIiCr8RYO6pu9djdJAq0k+h1GOT9eECthisqCu/jLptXHNq3H9rz6smJ8?=
 =?us-ascii?Q?IjPrD2R7Pa3EWKeU9fwvl6m6ay4YsrwSSdQJPQMEMBnPDtJi176Kr5HMTY4t?=
 =?us-ascii?Q?T9fupYZuGQy2TkxPJ9b0awbZXKtOtv2GY0/mApI9yP32tQtIXB4ICNTHsNGZ?=
 =?us-ascii?Q?Ep3aZO6GxsF6BQtG/ugnqr50bZkYYpD5Agi6Yk/wiAZt258HzxV6Jxc9gKH5?=
 =?us-ascii?Q?fzYl3989kauNMRfRNERVS1dsru5vghrclHcUw4aXI7+aALt36il3NGJW1Pny?=
 =?us-ascii?Q?NvMuSAyxqfgQjkUyOsc1a+P3JeVRBBep7YOzKy34RHglddYTLYX70UAXoLMT?=
 =?us-ascii?Q?rs1PsQizY/yqVuWWysax0rb1Tv8tiWtuK2tDPNEFVI3j5/EhH4wTmlnYSfwx?=
 =?us-ascii?Q?yvhtkRf+Lqjqe2JpwxIj1O+EK9tGZrLfu1Eu0PutbB05buOUU+dApR0uziQv?=
 =?us-ascii?Q?OMvyMdI2PdG6/MyBT9P9YvhxlMTqxmvW7oZhV6F7fjwI6cKYnd3ukpD3buHQ?=
 =?us-ascii?Q?CJ6Tx3SsMJclPhb4ZzH5GEq+AJllgXW3FdravTNbLY+Dy95SekakQc1+4QqC?=
 =?us-ascii?Q?ywrqx5bN8Cb/fYkBv2NHPyM4wRltbJCpkb9W9fqvlIC3wd2T6ytkintLjqs+?=
 =?us-ascii?Q?oAQTCoZOiLKEsooSfkU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 17:51:54.2040 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adc53d57-e4ba-41b4-711d-08de1713d8cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8592
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

From: Mukul Joshi <mukul.joshi@amd.com>

We would need to reserve SDMA queues per KFD node.
As a result, rework the SDMA reserved queue handling to make it per
KFD node.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 28 +++----------------
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  7 +++--
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 -
 3 files changed, 8 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index e9cfb80bd4366..e3da2f149ae6f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -94,6 +94,8 @@ static void kfd_device_info_set_sdma_info(struct kfd_dev *kfd)
 	case IP_VERSION(5, 2, 2):/* NAVY_FLOUNDER */
 	case IP_VERSION(5, 2, 4):/* DIMGREY_CAVEFISH */
 	case IP_VERSION(5, 2, 5):/* BEIGE_GOBY */
+		kfd->device_info.num_sdma_queues_per_engine = 8;
+		break;
 	case IP_VERSION(6, 0, 0):
 	case IP_VERSION(6, 0, 1):
 	case IP_VERSION(6, 0, 2):
@@ -105,6 +107,8 @@ static void kfd_device_info_set_sdma_info(struct kfd_dev *kfd)
 	case IP_VERSION(7, 0, 0):
 	case IP_VERSION(7, 0, 1):
 		kfd->device_info.num_sdma_queues_per_engine = 8;
+		/* Reserve 1 for paging and 1 for gfx */
+		kfd->device_info.num_reserved_sdma_queues_per_engine = 2;
 		break;
 	default:
 		dev_warn(kfd_device,
@@ -112,30 +116,6 @@ static void kfd_device_info_set_sdma_info(struct kfd_dev *kfd)
 			sdma_version);
 		kfd->device_info.num_sdma_queues_per_engine = 8;
 	}
-
-	bitmap_zero(kfd->device_info.reserved_sdma_queues_bitmap, KFD_MAX_SDMA_QUEUES);
-
-	switch (sdma_version) {
-	case IP_VERSION(6, 0, 0):
-	case IP_VERSION(6, 0, 1):
-	case IP_VERSION(6, 0, 2):
-	case IP_VERSION(6, 0, 3):
-	case IP_VERSION(6, 1, 0):
-	case IP_VERSION(6, 1, 1):
-	case IP_VERSION(6, 1, 2):
-	case IP_VERSION(6, 1, 3):
-	case IP_VERSION(7, 0, 0):
-	case IP_VERSION(7, 0, 1):
-		/* Reserve 1 for paging and 1 for gfx */
-		kfd->device_info.num_reserved_sdma_queues_per_engine = 2;
-		/* BIT(0)=engine-0 queue-0; BIT(1)=engine-1 queue-0; BIT(2)=engine-0 queue-1; ... */
-		bitmap_set(kfd->device_info.reserved_sdma_queues_bitmap, 0,
-			   kfd->adev->sdma.num_instances *
-			   kfd->device_info.num_reserved_sdma_queues_per_engine);
-		break;
-	default:
-		break;
-	}
 }
 
 static void kfd_device_info_set_event_interrupt_class(struct kfd_dev *kfd)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 4fbe865ff2796..5d3d10b9b4b7f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -137,9 +137,10 @@ static void init_sdma_bitmaps(struct device_queue_manager *dqm)
 	bitmap_set(dqm->xgmi_sdma_bitmap, 0, get_num_xgmi_sdma_queues(dqm));
 
 	/* Mask out the reserved queues */
-	bitmap_andnot(dqm->sdma_bitmap, dqm->sdma_bitmap,
-		      dqm->dev->kfd->device_info.reserved_sdma_queues_bitmap,
-		      KFD_MAX_SDMA_QUEUES);
+	bitmap_clear(dqm->sdma_bitmap, 0, kfd_get_num_sdma_engines(dqm->dev) *
+			dqm->dev->kfd->device_info.num_reserved_sdma_queues_per_engine);
+	bitmap_clear(dqm->xgmi_sdma_bitmap, 0, kfd_get_num_xgmi_sdma_engines(dqm->dev) *
+			dqm->dev->kfd->device_info.num_reserved_sdma_queues_per_engine);
 }
 
 void program_sh_mem_settings(struct device_queue_manager *dqm,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 70ef051511bb1..6c05d7f57196e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -241,7 +241,6 @@ struct kfd_device_info {
 	uint32_t no_atomic_fw_version;
 	unsigned int num_sdma_queues_per_engine;
 	unsigned int num_reserved_sdma_queues_per_engine;
-	DECLARE_BITMAP(reserved_sdma_queues_bitmap, KFD_MAX_SDMA_QUEUES);
 };
 
 unsigned int kfd_get_num_sdma_engines(struct kfd_node *kdev);
-- 
2.51.0

