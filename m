Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29FDC61CE7
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Jun 2025 05:56:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43CDD10E038;
	Wed, 11 Jun 2025 05:56:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BAh1bOiA";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAED210E038
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Jun 2025 05:56:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JARu2eXjN2olueCL8eMUyeXUQx2/gfHO60h5ljc57FDjSyy64r5CdM/y63zAfVqKaaW3VKOVWkqhG3Dv5tQYoGOQUVEbC2Z9zasHwjCrvDOH1AuQzyeY6lX/MFiHb+ys5mUdG/kSXPjniSVP9hcSwEtdoH3FD/ulhRKNb5YbNicRN0QpE2LsoEJL0F2CyrmexZwy6W0FL/MT//B7OnN3a4CMnWw8bVOHg3csND2RL03lp2oNsxkNndSxlrL89sJ3pJGOtHUJgFPydMOgXTD6+eY7yctkKlR6ZoMkBMeeAth4FPM/6G75O6b3fWa2WK7TXDH2tYw+Am7AjBPPs1QlKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fp0kwNW0BV/lvbmgCZZr4ahGuGF7SIgw4lZ2yDsOr2Q=;
 b=ixSyDH4SDhhTVgoBlxMpKCOn4mImYpAYkEgPpbCRzXG1kgk7MS9aSDDDtpKihS4rxDvJUFrCz1pu/OHThTqtW9gZqmQmue0A7uSF0Uczay+xY4FaAtwPZmTD8MQZJLnjalxwSY+nqZdmJf2Vzby0jRkHD+cNpjNZKpq6IqbRtPUoFetfNj3qO9jLX+Z6rmuzASsRUAwTuT3NaU+E58cifm9YAjBxwJ+ELmdJkF15Sv18y2cM9Ys8xxyJxzudO+dW193Z4bRiiqQQI2R2cHelKlw+y+Tigj5CWsjkW31gF7fhqpjAbuB8y2BG9I9Hlivq+u+OS9f0ljU5Wzc3N60kxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fp0kwNW0BV/lvbmgCZZr4ahGuGF7SIgw4lZ2yDsOr2Q=;
 b=BAh1bOiA8uTpjmgAugYJrGsr5+Qys9gk5396JiTYPnS0BgLKGvLCzQVsNXaUkmO613PWEhXizD1Zi5k5CWvI4v3rH5sZx6t15IKb8eYCQDfxZDn58hvvcMoY+jW4ZxTru9+YOqIcDqzzDIMMQyHXIoLkxmT8guV9FBfsl0B5/+s=
Received: from BYAPR02CA0043.namprd02.prod.outlook.com (2603:10b6:a03:54::20)
 by DM6PR12MB4420.namprd12.prod.outlook.com (2603:10b6:5:2a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Wed, 11 Jun
 2025 05:56:13 +0000
Received: from BY1PEPF0001AE18.namprd04.prod.outlook.com
 (2603:10b6:a03:54:cafe::cb) by BYAPR02CA0043.outlook.office365.com
 (2603:10b6:a03:54::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 11 Jun 2025 05:56:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BY1PEPF0001AE18.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Wed, 11 Jun 2025 05:56:13 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Jun
 2025 00:56:12 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Jun
 2025 00:56:12 -0500
Received: from jessevm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 11 Jun 2025 00:56:05 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <jonathan.kim@amd.com>, <jiadong.zhu@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Implement instance ID remapping for harvested
 SDMA engines
Date: Wed, 11 Jun 2025 13:56:03 +0800
Message-ID: <20250611055604.3303818-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE18:EE_|DM6PR12MB4420:EE_
X-MS-Office365-Filtering-Correlation-Id: 472b21c5-7027-4e4c-4b43-08dda8acac42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5lvPkQ1zOudOhf01VFijBEhFEGAcoHaXN6im7FXR0tvNOASFOua3HTyNQGuV?=
 =?us-ascii?Q?hVUylEYJjoa/T1QPKBejUEHk24UXBWB5iBr80NeGAA3za0w4qXudFm9UTmyS?=
 =?us-ascii?Q?XeMAojABnN7d64uSxNftPJFWkLQ6CKj2hDpGeyfTvCSrnKxNNtDpQYD84cMZ?=
 =?us-ascii?Q?CCTA3AH42LVAUDg3KLpMNasUTcR+w+wWrPM7qz+P1pKRLZUGjloWW1cL7b1P?=
 =?us-ascii?Q?WmMJB5HG2JfRTvf21O9M3/rb4E9hCxIz2+KqYC16aKklE3qPAE3UOBMJeZzN?=
 =?us-ascii?Q?UsXBESN073Idrlw5STK4OkQBLdFaCLquiRAYPLbrh17ukA6gkaDXpSlTRBGP?=
 =?us-ascii?Q?xNjXJiIlM1YY3l7HYxrP5xjWZiAWsLgwHXFvdLl9IQzBHTJ4nAbnT57NNia/?=
 =?us-ascii?Q?wmXfF3pOwBWBlzerY4dmHqJqfMFhxiBZ11+zTkXnIaCForGZFleCZKmDzNJd?=
 =?us-ascii?Q?Ot1byZisIwLxefmSQjqDAH0gTmp5bFWYf31r9Qwnb1fl4mVhrAPAujMHM86J?=
 =?us-ascii?Q?IvzPZVpiTEwOGW85DCY74ppZKjyp0pRNzT4NDd64Ybupg+5FTVU1AMP3A6Hc?=
 =?us-ascii?Q?XhQSwlPksickH7hPVgm0W+ckUf9yOLjMwsBygKUUE60JOinjFVzYOvCEvlp1?=
 =?us-ascii?Q?3iiIkd1OoDKM40HXPqlbV/GH3d3RRYHFrxQUqhjQEQsMgWYXLG8Hv0oWx2qm?=
 =?us-ascii?Q?/JL5KThVmfaAdTP5BAKerI6X7qBT7jcyxxorkmeXTUzXD69hE3EGUUWtb0T1?=
 =?us-ascii?Q?OmoFvEO5nErRHLbMIhAWytQJKnZkdSYciffnExWLMFAKfPV+AjGXXX/QlTVm?=
 =?us-ascii?Q?OPAI9YO8ApPHb66n4wUMz60v1NXwQDj8M5owadQjKfePsCzxKWITwjmztkW/?=
 =?us-ascii?Q?jdQ4oMVcLAha3Tz0TMnsf/bgXs2ErSubXzrK49Duzh1KMNF5W4LYByKJrwgR?=
 =?us-ascii?Q?M/jpRxuZoF17ONcz3vINAlQAX284+dwJFekWFg51QPgxiCqUVzt78vxrXnrE?=
 =?us-ascii?Q?+8b0V1LoM5Cw0rqWW2fGpB4Eig1SGVWj/dNdU+l5Kgv147ZsKI1QML2mLi3N?=
 =?us-ascii?Q?4SQnM+6gAUXnvrgm6ef+oBsGcCxwkRpunUyCoH0MKfmxchmq0SyDQrKjbZZn?=
 =?us-ascii?Q?7Zd0wNAd9ka+W0/gyYdgCsVfBq8F7gt4J5JHoFqmgKkfAeRLNeditbC+5jk5?=
 =?us-ascii?Q?GCLvr0h0ycWabJeQP683Gk7GJ7m0Czy50BWBZNdvnkpjJJ4UuFGCICJegE3B?=
 =?us-ascii?Q?0umG8wQlqaOWpdKtXZ2sGynE6tf1ORsldUneFNb6i2U8tO7aecHxXnrKaq3T?=
 =?us-ascii?Q?HhOlb+q0dnpJfVLzsNLvWJ9KTFG0JGtoWBwAEixZG/NvIr4g3nZFlV2KEQQ4?=
 =?us-ascii?Q?pxd+t1xf0i+KDfMIE4Ts1NUriCLaSXqLTsBMkuLNkxc2RyBAl/8nGjqtNTVg?=
 =?us-ascii?Q?/PhcNaCZ6b0fEU/ifZf64mSXnKWhpdOpFNGey/U+qNJ63fyqGjhbY0QGv9Zc?=
 =?us-ascii?Q?qF+1eNV7HFCyru/Jv3aCeGb3aQ/ntDrAVtS1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 05:56:13.3080 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 472b21c5-7027-4e4c-4b43-08dda8acac42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE18.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4420
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

Adds logic to handle instance ID conversion during SDMA engine reset
when harvest_config is active. This ensures correct physical engine
addressing when some SDMA instances are harvested.

Changes include:
1. Added instance ID remapping using GET_INST macro when harvest_config
   is non-zero
2. Conversion happens before engine reset procedure begins
3. Maintains existing reset flow for non-harvested configurations

This fixes hardware initialization issues on devices with harvested
SDMA instances where the logical instance IDs don't match physical
hardware mapping.

Suggested-by: Jonathan Kim <jonathan.kim@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c      | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h      | 1 +
 3 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index a0e9bf9b2710..4282f60a0cef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -759,6 +759,7 @@ static void amdgpu_discovery_read_from_harvest_table(struct amdgpu_device *adev,
 				~(1U << harvest_info->list[i].number_instance);
 			break;
 		case SDMA0_HWID:
+			adev->sdma.harvest_config |= (1U << harvest_info->list[i].number_instance);
 			adev->sdma.sdma_mask &=
 				~(1U << harvest_info->list[i].number_instance);
 			break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 6716ac281c49..0bfd2c138d24 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -581,6 +581,9 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
 	bool gfx_sched_stopped = false, page_sched_stopped = false;
 
 	mutex_lock(&sdma_instance->engine_reset_mutex);
+
+	if (adev->sdma.harvest_config)
+		instance_id = GET_INST(SDMA0, instance_id);
 	/* Stop the scheduler's work queue for the GFX and page rings if they are running.
 	* This ensures that no new tasks are submitted to the queues while
 	* the reset is in progress.
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index e5f8951bbb6f..fed00854a1a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -123,6 +123,7 @@ struct amdgpu_sdma {
 
 	int			num_instances;
 	uint32_t 		sdma_mask;
+	uint32_t		harvest_config;
 	int			num_inst_per_aid;
 	uint32_t                    srbm_soft_reset;
 	bool			has_page_queue;
-- 
2.34.1

