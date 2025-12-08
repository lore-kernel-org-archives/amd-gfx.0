Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58451D3B7F3
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 17:17:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F016610E46A;
	Mon,  8 Dec 2025 17:17:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SXvLhUUw";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012044.outbound.protection.outlook.com [52.101.48.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8873510E46A
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 17:17:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DSaSrnw4sW2OCrLxnaE7SgnMJqjXY6/Yx3lnW6EwtSDjV67J63mJ7fYObpyLvyT/HwUcEDmclqZYQZxUSIod4F7VaqwDszV7fYaaRcWfD8FovEbUC4dJZIRHNr/87ygL/c9e+DncvTjtFITM/WOm3tEGX6Yg43h+7NVv3+PNCIuL4SB+4/wfRgC1guhrEaExlei8lJPhPoJCgEaoI60BFSP55N2lO40cb8q/sTNBTufQ10RAlBl08O6NabtUotM+d/dBdl4amI69YOLQMnGprEpKZ6wK+2j94MJYSoOYYFiMFrj7FJAavXTjl2h1gZzk33sIaI2n2/ciGvZIlbnyVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UCORsmNlAmouEKxBZk6ib9E+Hk9NGQBYTMDXldcqxw=;
 b=VQs78emyh7rv8uYrRhiCmWBqWset43HsdPfLOns4xcVw98S6xIHKLH1rbV4Ytvt0yIRVSIToBil6F7wKfOpY3nyhK37HcycTNfx1x4pGCsz8CIIoROsml8eGxKVaDJnc9+Xr8m79unBM1qGbgCOq5sTaFzh4VFIB7pihiZlZaKXVGsw/e8r54J4FGNaiajOQxTd71SfIwKZu8rId1J1Su8Mfki2B1YHawuoN97E/s1DutVVquUWnd7hgD95CCd5pBqXp5myl3vYRK7IIH8nHe1dfMycjLYSEvsQOUq3IFdIebAiTbNq3QV1Ekw+YBJ2RfNkM2WfAel1HCgWRTNhVDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UCORsmNlAmouEKxBZk6ib9E+Hk9NGQBYTMDXldcqxw=;
 b=SXvLhUUwT98wZI73jxJtZUDKzal4mfJhu/sFOSq+XoV+oqoD+ihzJNddbZLR8tY5lWBkVvyDNK+sX8pwZWEUFpUXNnHWFk9K3U2PfEK2/1ZBF2vyt6BNfRADW6NaNunCnE4AiKRVIsO/2J3g5Chfa4pVue1e7420igH318yM6xU=
Received: from SJ0PR13CA0233.namprd13.prod.outlook.com (2603:10b6:a03:2c1::28)
 by DS7PR12MB8322.namprd12.prod.outlook.com (2603:10b6:8:ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 17:17:45 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::6d) by SJ0PR13CA0233.outlook.office365.com
 (2603:10b6:a03:2c1::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.4 via Frontend Transport; Mon, 8
 Dec 2025 17:17:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 8 Dec 2025 17:17:45 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 11:17:42 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdkfd: Enable per-process XNACK for GFX 12.1.0
Date: Mon, 8 Dec 2025 12:17:05 -0500
Message-ID: <20251208171720.153355-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251208171720.153355-1-alexander.deucher@amd.com>
References: <20251208171720.153355-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|DS7PR12MB8322:EE_
X-MS-Office365-Filtering-Correlation-Id: 44a4bc58-b093-4420-929d-08de367db402
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xzUKL/tH39kby/YyYxqDgv5HuwPdGr3A0//8kYDGrglr44LbV24LP4M/EYTT?=
 =?us-ascii?Q?46oR5adCFzy6NvJNyXzIp35ExNKKxCkKKYKGOQT6mQLT2qPh4826Cx7XFP4X?=
 =?us-ascii?Q?4zkxWMrSzKmWjJU+vONMkcthoJv1ys/cMOIAnWr2EdENgs17M7zwkYAaMMWU?=
 =?us-ascii?Q?gX3RkOshBhy3gJ4u5Q+wQBOs5ChBByPSeTTLMwAXHuVbqFs1O5xycBPK8MYs?=
 =?us-ascii?Q?IV4sG6Xij9mbLQz/g2SNqxaHVw9yIIZW+squBvWDTs7ByleRW4KXNb8dQvm6?=
 =?us-ascii?Q?rqetigoNJPSTfC/xUW71jYlTG9YgE5wbviQizjM6WI/SUO2zfwOCGZi/9+Ee?=
 =?us-ascii?Q?Ot67DaIDL2xliKwbTUeMVYgHXTkWN4G24ZU6uR3BO0bCcTc2NrS4F/vOQne3?=
 =?us-ascii?Q?tg/7gNtieuQQ+mpe7rNr2lIQGRrZoPW79SBPjpoEHEfM2dgCeL0TcBvKaLd5?=
 =?us-ascii?Q?vypns8w6y4h40W6zUFtilhyMBbyuN0fjajCeh4WzaYqHAOndBnr3/QY8QniG?=
 =?us-ascii?Q?dak5+lXns41pgvxIRKD51EBXJfzWs8FlVrCk8s3GcvXFqyMQNq2sHnp1ZcH3?=
 =?us-ascii?Q?mphwVEvixQ0CDtOL4/3OnOqNGuMzqcgoGp6kMksoBLx2kE2zeqq515nUnDsF?=
 =?us-ascii?Q?77Jky0+VEhi6GyE5eVIM40SI272pcTpvSTcfCVRPpByO3ogtzUZjJH5PedqX?=
 =?us-ascii?Q?MPqaWYBTY4bK3akYqWucOg9izRMD8oXPmB+b7G7nr3owofqta7zBPdEGbKiO?=
 =?us-ascii?Q?MXrzcR+phTpIYO8rtA5CyVr0zgLQ1IkTVLluA/Lsv858O3RvD21gS84o4hIl?=
 =?us-ascii?Q?xAHcv9Sq8OEPr9XIVRNeLrnJphVAIXQPfyM1+d1/3/6DiuaC35y7FPW1nqQ1?=
 =?us-ascii?Q?Ptqc57rM8o1q2HTHyyx2h/frhk5COMZXoHNMrSEV8Y2Bd+z4A2+1zhvtvrMP?=
 =?us-ascii?Q?/1l7mBnNSe5cauE5jNVR9a86u3Em9ogQEJ2FtU3T1k5ICrK97IaJHfRNsgYF?=
 =?us-ascii?Q?q7v5eARKfyDUXHXHCnfYRjWMvEkXkAT9TRCCQCnSZWncY8eDybSnu3YSwcFe?=
 =?us-ascii?Q?rvThyiCtkBD0CdSEdtmkxipX4F4mS9s4n3Rtv+EIh2BoecyHAa1HCB3+jlb7?=
 =?us-ascii?Q?lVaFKOAVe7+K2FcpbS3KCDbWi3CrVLgC8CgzSEx5gH/IsD/y4gRi7BUsuV8M?=
 =?us-ascii?Q?tlft1bYrcM/LPYpqm+nR9IJE9dDcWeIkU76Tnkj+u1oZjdyfhoBgqRn37leO?=
 =?us-ascii?Q?STXbJxXKrfgbIGAs8tXqh8Bllim9AMkEyxssr7KZhOELtaFUFCoUGXautRdq?=
 =?us-ascii?Q?UDipDAdjsJCP+CCq7Ie2tEXv4Jnzk6+4/NaVcS10pQBlls70LH/SKoNVflXQ?=
 =?us-ascii?Q?yr3yBdu1s4qgTBpGJMMxEDAzmYxkauznJg6FMn5P2m/foysne5n3kx/GALeR?=
 =?us-ascii?Q?zYVYdCJAKGEsXFvgUyXVMyamGchD7UhlcFDKRqxt6MF6CG6fM0EyI5XiKadL?=
 =?us-ascii?Q?zJ8rh9dKu7CUp9RRQ3TwC7lYjt/gHys0iwUMaKjZdFFr16yBqKWZB/gyll7U?=
 =?us-ascii?Q?NRMFMgEVi9Qf2So72k4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 17:17:45.0728 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a4bc58-b093-4420-929d-08de367db402
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8322
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

GFX 12.1.0 will support enabling/disabling XNACK on a per-
process basis. This change enables the per process XNACK feature.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Philip Yang <Philip.Yang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h               | 1 +
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c                | 2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 1 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                 | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c              | 3 ++-
 5 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index d503127e45d5e..f99de1592921c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -253,6 +253,7 @@ struct mes_add_queue_input {
 	uint32_t	is_aql_queue;
 	uint32_t	queue_size;
 	uint32_t	exclusively_scheduled;
+	uint32_t	sh_mem_config_data;
 };
 
 struct mes_remove_queue_input {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index cc2a715f373fd..15b467b4aae40 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -339,6 +339,8 @@ static int mes_v12_1_add_hw_queue(struct amdgpu_mes *mes,
 	mes_add_queue_pkt.is_aql_queue = input->is_aql_queue;
 	mes_add_queue_pkt.gds_size = input->queue_size;
 
+	mes_add_queue_pkt.full_sh_mem_config_data = input->sh_mem_config_data;
+
 	return mes_v12_1_submit_pkt_and_poll_completion(mes,
 			xcc_id, AMDGPU_MES_SCHED_PIPE,
 			&mes_add_queue_pkt, sizeof(mes_add_queue_pkt),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 39800280543c4..824d73ab5b283 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -255,6 +255,7 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	queue_input.queue_type = (uint32_t)queue_type;
 
 	queue_input.exclusively_scheduled = q->properties.is_gws;
+	queue_input.sh_mem_config_data = qpd->sh_mem_config;
 
 	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 12f640a9370ad..7b70f794f3d0c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -215,7 +215,8 @@ enum cache_policy {
 	((KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2)) ||	\
 	 (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 3)) ||	\
 	 (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 4)) ||	\
-	 (KFD_GC_VERSION(dev) == IP_VERSION(9, 5, 0)))
+	 (KFD_GC_VERSION(dev) == IP_VERSION(9, 5, 0)) ||	\
+	 (KFD_GC_VERSION(dev) == IP_VERSION(12, 1, 0)))
 
 struct kfd_node;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index aec7522407dbb..2a72dc95cc0f6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1558,7 +1558,8 @@ bool kfd_process_xnack_mode(struct kfd_process *p, bool supported)
 		 * management and memory-manager-related preemptions or
 		 * even deadlocks.
 		 */
-		if (KFD_GC_VERSION(dev) >= IP_VERSION(10, 1, 1))
+		if (KFD_GC_VERSION(dev) >= IP_VERSION(10, 1, 1) &&
+		    KFD_GC_VERSION(dev) < IP_VERSION(12, 1, 0))
 			return false;
 
 		if (dev->kfd->noretry)
-- 
2.51.1

