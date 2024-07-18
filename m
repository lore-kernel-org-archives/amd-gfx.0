Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22568C49EA1
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 14:08:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0EAE10E905;
	Thu, 18 Jul 2024 14:08:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O/g9UG5E";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEC9310E8C9
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 14:08:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U5EhYBPAYfFibxRAx7IKAt7/yQzId6MQ/j6eexhDPfxw8H/r2UI/6+ll9Rr362i9sxqQOOKR1RZ4utn4CSmjzhluIVnp94n8dZy6zmgIyqbxMZZbNpVBqxOjD8szE4wht66FqPUG4I1KBn9KKjNX41QxUVzZWaqr5g7Vj15abbRVWNtFrJbiYiFAQLezrBprM4wAyPjc0wER9Uq8aHHY5IyZcxgTtamWh+8zQ+1nUILBaOr0dJNkyY+9agLAj8qvrtFvV2FKfU5v2ZsNfuElWtnetnun+4VJygIvs1OmtZLGQ1IH4jmQyOrd0iNyUS8ftW6/DlyQc6/nbPDTAWX2Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6OxtzGvkEJUGQGn+Fts5CNy81mkAOo/qty04SElX7hc=;
 b=gfMHBLxi/NgmtugouUyaOeDpnkOUziTNY9JXHbQ/HybFOQPVTS8Sir9XRaYrxW/n0viDa95CbW2F/VJ3x2P33RVA0EfgpqBj3kzr5wVI60/OkvAOik5Gqb6jPfeat4LpJN03bcqqb4MwLvuK77Lxfveftga4uCWgbRQoQvRkRi0VimabkIPo5QXBBwmIiU2rJjI9BuDJrOSUixn67ZWoGyjQNbKRtEFSlFLGNdSqzARvHdbQV87+/wJ4A9x3LZ9h0Wpxknu8gbtPJZYSoxr8QBS8vj9kg0s9jNUPTMe1IWh+siS7R0lWEiNF+O7SFjz1bt/yEMvf4zikuikUtxW2Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OxtzGvkEJUGQGn+Fts5CNy81mkAOo/qty04SElX7hc=;
 b=O/g9UG5EnCmoqpJe++o/3dmC6Rtj3R/lOd7lyamqiEQ2MWkEXPFlIyacT1XrXAtLtYOmWL752PF0Pk4Vrv6nj/b0VaEWNjwdqyPk2dvreT3vsc1YCa7Z7I+RUAom2yDdCQTcL7LSXhs6Ns6SwQy8gOHfikFNfz0/H4HhFvsP3hY=
Received: from BL1PR13CA0068.namprd13.prod.outlook.com (2603:10b6:208:2b8::13)
 by IA1PR12MB7757.namprd12.prod.outlook.com (2603:10b6:208:422::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Thu, 18 Jul
 2024 14:08:08 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:2b8:cafe::47) by BL1PR13CA0068.outlook.office365.com
 (2603:10b6:208:2b8::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.15 via Frontend
 Transport; Thu, 18 Jul 2024 14:08:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 14:08:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 09:08:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jiadong Zhu <Jiadong.Zhu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 30/34] drm/amdgpu/mes: implement amdgpu_mes_reset_hw_queue_mmio
Date: Thu, 18 Jul 2024 10:07:29 -0400
Message-ID: <20240718140733.1731004-31-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718140733.1731004-1-alexander.deucher@amd.com>
References: <20240718140733.1731004-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|IA1PR12MB7757:EE_
X-MS-Office365-Filtering-Correlation-Id: b55b233e-58f2-4791-665a-08dca7330d52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EU5XB8JPK28iINhtyvoiuWEFAl8q3LvAAO/zqPUkhUVmz5D6M/Jbc4Z+1GW8?=
 =?us-ascii?Q?x6OTfwAIaYyFR7oc4jajAlHWW2jmzUP4GPp6qPL84OZsJcLnGo+qbTcqWz0L?=
 =?us-ascii?Q?WSIulUvQ55Pk8r56zWnnf9mzappufeLLMIf2uPV2mq8Bm4BC1t8Razy3LIU/?=
 =?us-ascii?Q?ZNSX7hkeeUfaFxBj+z0YC/xK1sIHnheNBV2pr/VxCipu4AiloVP0XEVCoz8H?=
 =?us-ascii?Q?x4YE/lRpdQLZPeJ+3XzZ0BkW3FDA7QTb6SeYmPVuYdeAOxZNkSbb0uiUebIv?=
 =?us-ascii?Q?uqHQgEffckI/UPeZXbB/X+UN5MtblPz27hC8wo8vA2ha5HQzBxo2A6pNRV0I?=
 =?us-ascii?Q?+Cyj+6jD95aViVhwz0NdQbP1B5sMSNfLt/hAUYj/KKD40T7U3IV2/qheshzp?=
 =?us-ascii?Q?LAaNdvQrfAeCCdoNUudURYEqpQqDzIa9HniBU2ZYt8Ysf7E+2LxNZhou1Ln8?=
 =?us-ascii?Q?K8KIMWIlvpWEgTMOVsb27z2jykoGCbQh6cUsNk2UwNxwlZ5ltRaBp8j8lWoU?=
 =?us-ascii?Q?qzBDIqAUS2EfGhgCA7eEs/lrgvN0oToNV2OrOnRwtQwlwT4Vgs4RyqpsVySL?=
 =?us-ascii?Q?u1fkEz2wEYL61twx788p/If3vsBIb3yJcyakpUJjSG1U7g06PnPqUsDcXAa0?=
 =?us-ascii?Q?Cr1LLqm2dBhLdFknqgr1vwrNn6xfny3mDGEWfaNtDWuVu1XDfk9c8IH2Pv0l?=
 =?us-ascii?Q?ffXsCzrO+BU/cbX9FeD8Qdzfup7HXKSCiSyg4xrCgVs5XAAI6/4vI1utR+D/?=
 =?us-ascii?Q?BNQ1G7+LLMiOAJKJ2j5PVxhokNqANA69C6vXDQk2zOJYLKDHim13bgNLPTOh?=
 =?us-ascii?Q?YMW4GqNOUZXFwnxtR4LXvQ11ie+FVMVBGKcKm+mweDPwB5EF/vHXCc0jkuDq?=
 =?us-ascii?Q?Tc1GSQmAa2C2Jn7qED3qlxh9rbycKxXlaEnjaIw14q3wipxJtKStj95nyka8?=
 =?us-ascii?Q?vEx0KhKJa+nCMaHlNGPCpgM7bl2X/nES/aocwNPpomDnKE7lDi9aeBnonBWw?=
 =?us-ascii?Q?iCZiiR6Mv+2wJpubaQlTOxFsyQ4760Q90NmnsbZOMzMTg2ugqTNdGwVe8Jk7?=
 =?us-ascii?Q?aTxJ98n5JL7g9XYBTVHLzH1+0ZDReVu19TjuPsDedoj+3bJFRhZeVkI/JLhB?=
 =?us-ascii?Q?lIZa3c2j4imv7KIzb1xcPQHu/rL2vUaf5ys+Lp9ITrZMbUy8gXB9unyF2vpu?=
 =?us-ascii?Q?qO8bG5kni9dE8LDbNSoWIRJGoaklBqzfG038EzDW0dCRcVYWMK1uC/eJZJv2?=
 =?us-ascii?Q?h6SldI9/I7zpZV/kv//7BBxFeaDjgN8qwdRVkEszGl65fnJfuCmmQq64J6GY?=
 =?us-ascii?Q?KpBIqdS+OYFBcwKmDAhymR5j9y69efVdnHz1J0m1k9jZseWAi4TxYNsTJkj3?=
 =?us-ascii?Q?5FBBG6tmYku/F+s4zOlzmVo7UlGP3gT3v5RLmKGhieS20QC7tbe8+WD+0qby?=
 =?us-ascii?Q?vhhYp/usj2s2m7QxzKQHCst4fMB8dgkS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 14:08:08.7817 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b55b233e-58f2-4791-665a-08dca7330d52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7757
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

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

The reset_queue api could be used from kfd or kgd.

v2: add use_mmio parameter for mes_reset_legacy_queue.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 950c26ee3fb8..0bc6ce26ce45 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -817,6 +817,24 @@ int amdgpu_mes_reset_hw_queue(struct amdgpu_device *adev, int queue_id)
 	return 0;
 }
 
+int amdgpu_mes_reset_hw_queue_mmio(struct amdgpu_device *adev, int queue_type,
+				   int me_id, int pipe_id, int queue_id, int vmid)
+{
+	struct mes_reset_queue_input queue_input;
+	int r;
+
+	queue_input.use_mmio = true;
+	queue_input.me_id = me_id;
+	queue_input.pipe_id = pipe_id;
+	queue_input.queue_id = queue_id;
+	queue_input.vmid = vmid;
+	r = adev->mes.funcs->reset_hw_queue(&adev->mes, &queue_input);
+	if (r)
+		DRM_ERROR("failed to reset hardware queue by mmio, queue id = %d\n",
+			  queue_id);
+	return r;
+}
+
 int amdgpu_mes_map_legacy_queue(struct amdgpu_device *adev,
 				struct amdgpu_ring *ring)
 {
@@ -874,11 +892,13 @@ int amdgpu_mes_reset_legacy_queue(struct amdgpu_device *adev,
 
 	queue_input.queue_type = ring->funcs->type;
 	queue_input.doorbell_offset = ring->doorbell_index;
+	queue_input.me_id = ring->me;
 	queue_input.pipe_id = ring->pipe;
 	queue_input.queue_id = ring->queue;
 	queue_input.mqd_addr = amdgpu_bo_gpu_offset(ring->mqd_obj);
 	queue_input.wptr_addr = ring->wptr_gpu_addr;
 	queue_input.vmid = vmid;
+	queue_input.use_mmio = use_mmio;
 
 	r = adev->mes.funcs->reset_legacy_queue(&adev->mes, &queue_input);
 	if (r)
-- 
2.45.2

