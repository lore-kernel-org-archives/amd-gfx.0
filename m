Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D681C19F2E
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2025 17:15:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5072B10E967;
	Wed, 26 Feb 2025 17:15:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fsT0Peon";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0844510E0D1
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2025 17:15:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jcYkk6DbK1fQ73OYynKgPsxZdVb5zyj5rRz4snlgieIzj5UrkhPM2cmpfSbwepxwWLGJx2CdwQ80VbVGPjnkU0h1X1LcWHWkJM/EoFkel+9aLCJYzjoThTWXxbIA99S59VWuhmnYkYKfYfWt0So6ZT37GK4jxeixCGK/h59k5wZr2ckRMzL8mxAH0vlFB+LnY/XJy8oYlzOpB/ilQrv3DNjE+MPBWNl4UG5cEtDRsorBjJJIMF4AWiG67qSt1YsR2FV1z6Z0xn6FUHEcK5Ztyp6Acaj2EO5pm31PPk2yQ3zQ20xrNQTsvWnyKWxEUdbP/1Xqa25VJ5oI5QxNYkCcIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JzfhjHHkSM0ft+V8uhwP7/PQEArOSEFfn/2sBaKM7hU=;
 b=UHKwaxEVO/xlTikgq7IZYeBlt8tLuBxqqPFQmA55k6V4A7NCH3VlAaRenL2RD3rqGUm6sNOuJB+OCNoGjiQeTbkhkWktc+2SFc2oH2g+7gHl8hWGjsnataJwS9tPaNnqd2m7OITnXf4nZcCl16R3jd/KdK0GBSNmy/WThlTMx2E6AnEkn6L1DqqR9UjxNwmbb5D7Q84cgtgLzKR93Kl+9KNsdiISY6wYhiTPN9kO9Awg+smIvSx0ZSklcVt8K3caMwA10nD7/NSHL7rA3uFbj1Ft908LA9supKrQbv802+Gw7Sy4SqRlImJPsVT7Ry1pdCtT9pZ8O+gJpapm0GZO9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzfhjHHkSM0ft+V8uhwP7/PQEArOSEFfn/2sBaKM7hU=;
 b=fsT0Peon5vUjhuwaZlFs5Ry4oAUD9FCFCu3kbGOrG2kRALgZFcF1iM24rEX596kX6KYrjymaOeAJO9vspyQ0XYaQIFeTeSALjUsMme55Tu2bkDArw2qBsXpk+HMydtrhhLdeAKxHDORp1EW7r9kWijh8Rt614U+YbX4dnJyGwzE=
Received: from PH7PR17CA0055.namprd17.prod.outlook.com (2603:10b6:510:325::16)
 by SJ0PR12MB6712.namprd12.prod.outlook.com (2603:10b6:a03:44e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.20; Wed, 26 Feb
 2025 17:15:17 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:510:325:cafe::f2) by PH7PR17CA0055.outlook.office365.com
 (2603:10b6:510:325::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.19 via Frontend Transport; Wed,
 26 Feb 2025 17:15:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.0 via Frontend Transport; Wed, 26 Feb 2025 17:15:16 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Feb
 2025 11:15:14 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <lijo.lazar@amd.com>, Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>
Subject: [PATCH 1/5] drm/amdkfd: Remove kfd_process_hw_exception worker
Date: Wed, 26 Feb 2025 12:14:17 -0500
Message-ID: <20250226171421.14436-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250226171421.14436-1-Philip.Yang@amd.com>
References: <20250226171421.14436-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|SJ0PR12MB6712:EE_
X-MS-Office365-Filtering-Correlation-Id: ab13ce6b-9330-4506-1a6a-08dd568923d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BGf45HpwtHfsABnQFkkrSuHdFVrL2UrAeElzNX2xlZONeahxxerxWLMEEbFX?=
 =?us-ascii?Q?t2Ba3wMTbIn6+Sm/JSuhzz0tUJMSntlOiNERDO/6Ql0vcK/bReIn4E27Wzoi?=
 =?us-ascii?Q?b+JaacHq/i/3ux3d1o7o8YWNSAzvSeZaMDf/b8COF35602yNbKr5seSk/JWF?=
 =?us-ascii?Q?GxSGm83mKAwkV6ym69sc33YsclddZt44XP2jPjYqTzYmZuZalTlnBBbbYiM5?=
 =?us-ascii?Q?5IGPkGbw42UsvXP7Eg5y4T6XcB61lHB2Vo1AHhB0aLJom/2zfAyK4vnfEyg7?=
 =?us-ascii?Q?gOdovLmZNftlElMEjZv6tDVlQ0yu5rf8pWK7c9CP1P6vSCqj6XgfppT0uFUO?=
 =?us-ascii?Q?IaYyXNNPIHf1cstIZ81JjuovCky7hizxf6jlGlAth8YrOw9qTPlFEVlNXcLe?=
 =?us-ascii?Q?3UCo82tV9U3SY4lEoNxTYqu1LyXY30/NYp2bCs/vhhAa7IzLTxx6g5UQsqQY?=
 =?us-ascii?Q?nxoM5R4xpSZ0UkO4BoXDWj7y/DutkiaglwX30U0CMlRv/OxeRthlnl3Ye+k4?=
 =?us-ascii?Q?rh+JA4Cq3gIo/eW0xgLZiM2Byw5QKmImncVAGgp/Z8B3ne0liOWjNBA/qoin?=
 =?us-ascii?Q?dKeZqTQHHp0vNEr2dUgb4GaX1pCAZH0/EZIBaENt6nh7TENQch9OLzBOioWM?=
 =?us-ascii?Q?/2+0r0mCPk+yLgeBm0ASRND4NOknu28o0aRFHWQk2pPOXsZHEMru3bgeMVFZ?=
 =?us-ascii?Q?X9z4J3KR0DvaeDi3N3xK0kY+pyWJri42Fy0+E5Mc+STxvl5SpXJPcLmAgnH6?=
 =?us-ascii?Q?R+lW+fjza7hetHGGNvD5Ozu12UBRSYz4cwzEqHKZG2k3jTlOGwWUS7f3hZf1?=
 =?us-ascii?Q?Tdnj9b2C8bwUazq2anZmBYMl5XO0d0fVCRhr1EBYZREAUANgZ9HuN5VyR53r?=
 =?us-ascii?Q?FEtXeKvKFWCq7JWmRgP6b2cf46wSx5RQ8wXlctDvNlTCDvJMQMpmSxDKRsWN?=
 =?us-ascii?Q?h/JWBpfDXyjj8Oc1blXtk3Jk2Zg0ldlhEyTv7I2P+sEnOtwd+5F1pNETIeuX?=
 =?us-ascii?Q?ONU6rUxW0pK6LKEwmO9VHemBW2W2xIqKxBNFhEZpwIyI8pC8ginXfLDd2Uww?=
 =?us-ascii?Q?pUSRpnTbkzsRTR7GAVfNVqai8S2xt1J/07uKkJ02tZTVjFFkJyXW01swAsUj?=
 =?us-ascii?Q?5rvQSklomNXsZDMkKW8wDEQyckItp4cM/IOKFNKKoa7axE0l0Y5abUfX8s9C?=
 =?us-ascii?Q?yMaLpmo/rqfiLUXE+fQHwhUat80a9vNxASUsIIb2rJ3fqTdglKHZtiAbrF5O?=
 =?us-ascii?Q?ImVZenae7wNgV1ROGtuu6XMjUYdpOXX5i2l3lIsscghEAd2V6/yTq3NgfunQ?=
 =?us-ascii?Q?tdip2IeCBaQPTXeuf6TCQVe1GpObTtyySwuPrbOuIusywdinlJOEvrfmW3/3?=
 =?us-ascii?Q?TYu0EdrPiKnFmycoMLEkX2v3qbm8WHxokUxI5FjADjkZ5foFhxjvME9p2YvL?=
 =?us-ascii?Q?7RVwrF+PY7uthSCz4lAv8gCjOatwKlGM6uugnIqQkXqy1vy6iyp4nB8pDLnw?=
 =?us-ascii?Q?EdEU/lPgVfBjiio=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 17:15:16.6330 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab13ce6b-9330-4506-1a6a-08dd568923d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6712
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

With GPU reset-domain worker implemented, KFD hw_exception worker is not
needed any more, just call amdgpu_amdkfd_gpu_reset directly from
kfd_hws_hang.

Suggested-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 11 +----------
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h |  1 -
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 94b1ac8a4735..91e4988dc1e3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -66,7 +66,6 @@ static inline void deallocate_hqd(struct device_queue_manager *dqm,
 static int allocate_hqd(struct device_queue_manager *dqm, struct queue *q);
 static int allocate_sdma_queue(struct device_queue_manager *dqm,
 				struct queue *q, const uint32_t *restore_sdma_id);
-static void kfd_process_hw_exception(struct work_struct *work);
 
 static inline
 enum KFD_MQD_TYPE get_mqd_type_from_queue_type(enum kfd_queue_type type)
@@ -170,7 +169,7 @@ static void kfd_hws_hang(struct device_queue_manager *dqm)
 	/*
 	 * Issue a GPU reset if HWS is unresponsive
 	 */
-	schedule_work(&dqm->hw_exception_work);
+	amdgpu_amdkfd_gpu_reset(dqm->dev->adev);
 }
 
 static int convert_to_mes_queue_type(int queue_type)
@@ -1740,7 +1739,6 @@ static int initialize_cpsch(struct device_queue_manager *dqm)
 	dqm->active_cp_queue_count = 0;
 	dqm->gws_queue_count = 0;
 	dqm->active_runlist = false;
-	INIT_WORK(&dqm->hw_exception_work, kfd_process_hw_exception);
 	dqm->trap_debug_vmid = 0;
 
 	init_sdma_bitmaps(dqm);
@@ -3080,13 +3078,6 @@ int kfd_evict_process_device(struct kfd_process_device *pdd)
 	return ret;
 }
 
-static void kfd_process_hw_exception(struct work_struct *work)
-{
-	struct device_queue_manager *dqm = container_of(work,
-			struct device_queue_manager, hw_exception_work);
-	amdgpu_amdkfd_gpu_reset(dqm->dev->adev);
-}
-
 int reserve_debug_trap_vmid(struct device_queue_manager *dqm,
 				struct qcm_process_device *qpd)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index 09ab36f8e8c6..7146e227e2c1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -269,7 +269,6 @@ struct device_queue_manager {
 	/* hw exception  */
 	bool			is_hws_hang;
 	bool			is_resetting;
-	struct work_struct	hw_exception_work;
 	struct kfd_mem_obj	hiq_sdma_mqd;
 	bool			sched_running;
 	bool			sched_halt;
-- 
2.47.1

