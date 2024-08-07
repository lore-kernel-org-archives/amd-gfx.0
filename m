Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA97CC52D6F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 09:39:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 989CF10E4AB;
	Wed,  7 Aug 2024 09:39:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N0aZbJpT";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2050.outbound.protection.outlook.com [40.107.96.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7363F10E4AB
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 09:39:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OM0duJvQHMsmG1OQ5ZwNgVwRhuCmBArf1xrkLRW3aUxNPFp4ZB37mPB351O9pgPJm5gbHUzWyFWva9sSaRM+ojGQQojOgadLfOpM06gLf8LW0DTtQmUnyXk0FPxhKN2Wr0da0RbWZH/lTsgMnVZE6h3IM95PEbTPqhQuyFr2ge/L4eXBq3g+wUY2YqcDX4QEPrrbr4YPN8LApuxplfTdj1OaOarvlFPLTKD1g+RM87ajXZw+Dh6TI6tFlUFgT8RNgt7pjkTXQU0bTwMbP5gltN8louwxwqu6rnaH9Z4s8PFLeEGAs2DEMOqNRkCPzBe5qObXZhXaPEIncHT78VPZ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EyT8XzX5AkTajtDH7i/HZPr/6AU3KH7734mqrbwLkHI=;
 b=K7zUs2JEwqAMJmyGL2gd+fOStl1lYrzLIqkEnG5H/0m4A4FL8XYwTfNxjfnl3Kvu0OGWdJADBrmRaljYcHJ0zuYzUpeBN2YJMdQTdW4vFjagNsdNTph6QIZtcZ2rJujaS2FlHAzM0iIU+6WYWzJFwaMJpRzN1w+rKGSPYOwbrIBzq+8y6fuGyhAtfLuk4RA5MxnwxduIqLopWWGZmUvMEsLW+qdGkXa1wwd7D1XYtc+tJAszn12Trtm2rgc7nQxJ++cUxOxFpLtVDrOOFzWMcwVSnV50wA479wR1MHHFlD+b94+lmwymQ3kHXWu9uMcSll2FDKHEQshi2pBCNFby6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyT8XzX5AkTajtDH7i/HZPr/6AU3KH7734mqrbwLkHI=;
 b=N0aZbJpT8iIr88b5+b7Bd7ErYcxyDg5bw5H+L9pw1P3/+vlPT/CJaEftqADd7o+8nEvL+gsParPPJKIpbHDt/gG9tSVyiioW37w1w/9qr7sTbmuE0ffoaXHwXvvYmKufLwwJKjGoX1Cq3GXoPdJ2Nv6Auodxo23DpN9lmZCq0PE=
Received: from DM6PR21CA0017.namprd21.prod.outlook.com (2603:10b6:5:174::27)
 by IA1PR12MB7712.namprd12.prod.outlook.com (2603:10b6:208:420::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Wed, 7 Aug
 2024 09:39:17 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:5:174:cafe::bf) by DM6PR21CA0017.outlook.office365.com
 (2603:10b6:5:174::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.7 via Frontend
 Transport; Wed, 7 Aug 2024 09:39:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 09:39:16 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 04:39:14 -0500
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>
CC: Jack Xiao <Jack.Xiao@amd.com>
Subject: [PATCH 5/8] drm/amdgpu/mes12: adjust mes12 sw/hw init for multiple
 pipes
Date: Wed, 7 Aug 2024 17:38:44 +0800
Message-ID: <20240807093847.2084710-6-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240807093847.2084710-1-Jack.Xiao@amd.com>
References: <20240807093847.2084710-1-Jack.Xiao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|IA1PR12MB7712:EE_
X-MS-Office365-Filtering-Correlation-Id: 54bca1d8-f9bd-4e52-bfcc-08dcb6c4ce1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LlUGO9o5sArLnCHpm9lcZGCbmSwfrjAOQdCfC/pxXIgTEi2Sd3X2+CBqSZMt?=
 =?us-ascii?Q?iFhdRns03Pie64D0yeEaCk8ykw4+xbHku2mdVGJVXmGD2OISD6gwzigo2GS2?=
 =?us-ascii?Q?34BXjNeAMafi4D7zDYHHkU5oKPHCEdYsucMzxqYaZZfVBNFXnw5kv8gL2wIP?=
 =?us-ascii?Q?8xEvXoh0mRc/a8yNwQEkAL0bj4qe6aDmz6ojsjSiz9muLoMw4JrKgM82PVbZ?=
 =?us-ascii?Q?qZg9Ec2pjS1V+yBMuRyPvpo6NVO5810xShrqNoagSSdGJz/7sLCMHssIIcH6?=
 =?us-ascii?Q?sshw+chNUj1UNywuh+W9KinProXAxqnXtrO3gHi8TJxh5e/FhC4DAdDZC9iW?=
 =?us-ascii?Q?jbGoIHRldlHGIBL5rcwTas0cRprYTQxAritp0GkBDgru4mzyStnQba9+e8X6?=
 =?us-ascii?Q?yDr274n/atqARGwUoDPwWGFRxIddmwFHa25UFXbffkevAi6JUhgmdf+S6oWi?=
 =?us-ascii?Q?sbpK0rlBkNd4ys4FLjOVAGEkvO8AmOYSBx3c9sQ9ZD3+gr4smH0IM6ST6sbl?=
 =?us-ascii?Q?u8SpE2udCESUZGc/reNTx4uLxYigl1tQc336B3P3W2oc66ncuqcO9xgDPqSl?=
 =?us-ascii?Q?k9kWt/U+7JJvKIaXAQR6Fo7HZLm6aEFT7b99QDd8kuFFz8RbuzL//8NpwF/8?=
 =?us-ascii?Q?3ImRY21YiFQEi3bBXkX4UY8h5r88A18jfyLudvvTPxnFIZU8RN6SxtXM3Rc9?=
 =?us-ascii?Q?UuN+EjLplQ7MqRMZGcecmXhWwuj9ea0RhXbZ5p6sOJPWNNgShoKLHpVZwE+J?=
 =?us-ascii?Q?NakX0OeTL15EXYFt7kfv9IREKDh4vynNk/M8JV0IPFywXziZGQ1Y1nRUgjmD?=
 =?us-ascii?Q?xn0U3xe2l9EnjUhW6r/on5lCi5X62355tVTd88dd85SwaMWIYg2q3O/ZjcfY?=
 =?us-ascii?Q?D3hm4McCGfS89zzyGlI8WwM2W9Y3OCMbSArgcTfpEYg7h4q1+xz9qH5PBYA7?=
 =?us-ascii?Q?fhxN3ACOn6adipglY+VKGWYu4vA4dKf87iSBP9p+pX9ZeBnu8aKb+ASbPYKJ?=
 =?us-ascii?Q?DCDkCwUR8GenubCkHaCxpkcq15xQU1qujOBxSlR8thhKCSm2UvE17w/huCA6?=
 =?us-ascii?Q?g+5LpksqZKNfWmSMRTg+agJUnb7dGZWzd2saAubmYQqkMomYw2TSB4q6EmDx?=
 =?us-ascii?Q?p1ovAte2yIToju1YMB9cRvIZOIwyuUnVv3orQLjFSNW8YCEjc7d6xdiikjlP?=
 =?us-ascii?Q?aVTNYc/y1kGxV6Wf48KrXue2z670Mx6bXoPLs+i8kgdmkHOFU/qEXzHW5eE3?=
 =?us-ascii?Q?UF07eXaLbZ9G6ijS1M9p7xc16AkG9HaZGbfSebJWJdCG3hPWsrkJU3kVIFUI?=
 =?us-ascii?Q?WBjTDj5iHRSUbtJ4gZQxigVDaOXG4kjkWZ+k1s7qO2bRgmqKsjHVjeB8CHyp?=
 =?us-ascii?Q?oKgpYwx247ipAhx2X0rTLdr6DBXFZ9eZynqCnglUxVR83ThzMdq2wZN1RLmx?=
 =?us-ascii?Q?5+9XMRzU65ORn6HxghK3quWFBmGkSOFT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 09:39:16.6288 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54bca1d8-f9bd-4e52-bfcc-08dcb6c4ce1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7712
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

Adjust mes12 sw/hw initiailization for both pipe0 and pipe1
enablement. The two pipes are almost identical pipe. Pipe0
behaves like schq and pipe1 like kiq, pipe0 was mapped by pipe1.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 106 +++++++++++++++----------
 1 file changed, 62 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 88b0997fa377..4218ac7d4372 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -266,6 +266,8 @@ static int convert_to_mes_queue_type(int queue_type)
 		return MES_QUEUE_TYPE_COMPUTE;
 	else if (queue_type == AMDGPU_RING_TYPE_SDMA)
 		return MES_QUEUE_TYPE_SDMA;
+	else if (queue_type == AMDGPU_RING_TYPE_MES)
+		return MES_QUEUE_TYPE_SCHQ;
 	else
 		BUG();
 	return -1;
@@ -352,6 +354,7 @@ static int mes_v12_0_map_legacy_queue(struct amdgpu_mes *mes,
 				      struct mes_map_legacy_queue_input *input)
 {
 	union MESAPI__ADD_QUEUE mes_add_queue_pkt;
+	int pipe;
 
 	memset(&mes_add_queue_pkt, 0, sizeof(mes_add_queue_pkt));
 
@@ -368,8 +371,12 @@ static int mes_v12_0_map_legacy_queue(struct amdgpu_mes *mes,
 		convert_to_mes_queue_type(input->queue_type);
 	mes_add_queue_pkt.map_legacy_kq = 1;
 
-	return mes_v12_0_submit_pkt_and_poll_completion(mes,
-			AMDGPU_MES_SCHED_PIPE,
+	if (mes->adev->enable_uni_mes)
+		pipe = AMDGPU_MES_KIQ_PIPE;
+	else
+		pipe = AMDGPU_MES_SCHED_PIPE;
+
+	return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
 			&mes_add_queue_pkt, sizeof(mes_add_queue_pkt),
 			offsetof(union MESAPI__ADD_QUEUE, api_status));
 }
@@ -378,6 +385,7 @@ static int mes_v12_0_unmap_legacy_queue(struct amdgpu_mes *mes,
 			struct mes_unmap_legacy_queue_input *input)
 {
 	union MESAPI__REMOVE_QUEUE mes_remove_queue_pkt;
+	int pipe;
 
 	memset(&mes_remove_queue_pkt, 0, sizeof(mes_remove_queue_pkt));
 
@@ -402,8 +410,12 @@ static int mes_v12_0_unmap_legacy_queue(struct amdgpu_mes *mes,
 			convert_to_mes_queue_type(input->queue_type);
 	}
 
-	return mes_v12_0_submit_pkt_and_poll_completion(mes,
-			AMDGPU_MES_SCHED_PIPE,
+	if (mes->adev->enable_uni_mes)
+		pipe = AMDGPU_MES_KIQ_PIPE;
+	else
+		pipe = AMDGPU_MES_SCHED_PIPE;
+
+	return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
 			&mes_remove_queue_pkt, sizeof(mes_remove_queue_pkt),
 			offsetof(union MESAPI__REMOVE_QUEUE, api_status));
 }
@@ -439,6 +451,7 @@ static int mes_v12_0_misc_op(struct amdgpu_mes *mes,
 			     struct mes_misc_op_input *input)
 {
 	union MESAPI__MISC misc_pkt;
+	int pipe;
 
 	memset(&misc_pkt, 0, sizeof(misc_pkt));
 
@@ -491,8 +504,12 @@ static int mes_v12_0_misc_op(struct amdgpu_mes *mes,
 		return -EINVAL;
 	}
 
-	return mes_v12_0_submit_pkt_and_poll_completion(mes,
-			AMDGPU_MES_SCHED_PIPE,
+	if (mes->adev->enable_uni_mes)
+		pipe = AMDGPU_MES_KIQ_PIPE;
+	else
+		pipe = AMDGPU_MES_SCHED_PIPE;
+
+	return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
 			&misc_pkt, sizeof(misc_pkt),
 			offsetof(union MESAPI__MISC, api_status));
 }
@@ -1105,14 +1122,12 @@ static int mes_v12_0_queue_init(struct amdgpu_device *adev,
 	struct amdgpu_ring *ring;
 	int r;
 
-	if (pipe == AMDGPU_MES_KIQ_PIPE)
+	if (!adev->enable_uni_mes && pipe == AMDGPU_MES_KIQ_PIPE)
 		ring = &adev->gfx.kiq[0].ring;
-	else if (pipe == AMDGPU_MES_SCHED_PIPE)
-		ring = &adev->mes.ring[0];
 	else
-		BUG();
+		ring = &adev->mes.ring[pipe];
 
-	if ((pipe == AMDGPU_MES_SCHED_PIPE) &&
+	if ((adev->enable_uni_mes || pipe == AMDGPU_MES_SCHED_PIPE) &&
 	    (amdgpu_in_reset(adev) || adev->in_suspend)) {
 		*(ring->wptr_cpu_addr) = 0;
 		*(ring->rptr_cpu_addr) = 0;
@@ -1124,13 +1139,12 @@ static int mes_v12_0_queue_init(struct amdgpu_device *adev,
 		return r;
 
 	if (pipe == AMDGPU_MES_SCHED_PIPE) {
-		if (adev->enable_uni_mes) {
-			mes_v12_0_queue_init_register(ring);
-		} else {
+		if (adev->enable_uni_mes)
+			r = amdgpu_mes_map_legacy_queue(adev, ring);
+		else
 			r = mes_v12_0_kiq_enable_queue(adev);
-			if (r)
-				return r;
-		}
+		if (r)
+			return r;
 	} else {
 		mes_v12_0_queue_init_register(ring);
 	}
@@ -1150,25 +1164,29 @@ static int mes_v12_0_queue_init(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int mes_v12_0_ring_init(struct amdgpu_device *adev)
+static int mes_v12_0_ring_init(struct amdgpu_device *adev, int pipe)
 {
 	struct amdgpu_ring *ring;
 
-	ring = &adev->mes.ring[0];
+	ring = &adev->mes.ring[pipe];
 
 	ring->funcs = &mes_v12_0_ring_funcs;
 
 	ring->me = 3;
-	ring->pipe = 0;
+	ring->pipe = pipe;
 	ring->queue = 0;
 
 	ring->ring_obj = NULL;
 	ring->use_doorbell = true;
-	ring->doorbell_index = adev->doorbell_index.mes_ring0 << 1;
-	ring->eop_gpu_addr = adev->mes.eop_gpu_addr[AMDGPU_MES_SCHED_PIPE];
+	ring->eop_gpu_addr = adev->mes.eop_gpu_addr[pipe];
 	ring->no_scheduler = true;
 	sprintf(ring->name, "mes_%d.%d.%d", ring->me, ring->pipe, ring->queue);
 
+	if (pipe == AMDGPU_MES_SCHED_PIPE)
+		ring->doorbell_index = adev->doorbell_index.mes_ring0 << 1;
+	else
+		ring->doorbell_index = adev->doorbell_index.mes_ring1 << 1;
+
 	return amdgpu_ring_init(adev, ring, 1024, NULL, 0,
 				AMDGPU_RING_PRIO_DEFAULT, NULL);
 }
@@ -1182,7 +1200,7 @@ static int mes_v12_0_kiq_ring_init(struct amdgpu_device *adev)
 	ring = &adev->gfx.kiq[0].ring;
 
 	ring->me = 3;
-	ring->pipe = adev->enable_uni_mes ? 0 : 1;
+	ring->pipe = 1;
 	ring->queue = 0;
 
 	ring->adev = NULL;
@@ -1204,12 +1222,10 @@ static int mes_v12_0_mqd_sw_init(struct amdgpu_device *adev,
 	int r, mqd_size = sizeof(struct v12_compute_mqd);
 	struct amdgpu_ring *ring;
 
-	if (pipe == AMDGPU_MES_KIQ_PIPE)
+	if (!adev->enable_uni_mes && pipe == AMDGPU_MES_KIQ_PIPE)
 		ring = &adev->gfx.kiq[0].ring;
-	else if (pipe == AMDGPU_MES_SCHED_PIPE)
-		ring = &adev->mes.ring[0];
 	else
-		BUG();
+		ring = &adev->mes.ring[pipe];
 
 	if (ring->mqd_obj)
 		return 0;
@@ -1248,9 +1264,6 @@ static int mes_v12_0_sw_init(void *handle)
 		return r;
 
 	for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
-		if (!adev->enable_mes_kiq && pipe == AMDGPU_MES_KIQ_PIPE)
-			continue;
-
 		r = mes_v12_0_allocate_eop_buf(adev, pipe);
 		if (r)
 			return r;
@@ -1258,18 +1271,15 @@ static int mes_v12_0_sw_init(void *handle)
 		r = mes_v12_0_mqd_sw_init(adev, pipe);
 		if (r)
 			return r;
-	}
 
-	if (adev->enable_mes_kiq) {
-		r = mes_v12_0_kiq_ring_init(adev);
+		if (!adev->enable_uni_mes && pipe == AMDGPU_MES_KIQ_PIPE)
+			r = mes_v12_0_kiq_ring_init(adev);
+		else
+			r = mes_v12_0_ring_init(adev, pipe);
 		if (r)
 			return r;
 	}
 
-	r = mes_v12_0_ring_init(adev);
-	if (r)
-		return r;
-
 	return 0;
 }
 
@@ -1364,10 +1374,10 @@ static int mes_v12_0_kiq_hw_init(struct amdgpu_device *adev)
 {
 	int r = 0;
 
-	mes_v12_0_kiq_setting(&adev->gfx.kiq[0].ring);
-
 	if (adev->enable_uni_mes)
-		return mes_v12_0_hw_init(adev);
+		mes_v12_0_kiq_setting(&adev->mes.ring[AMDGPU_MES_KIQ_PIPE]);
+	else
+		mes_v12_0_kiq_setting(&adev->gfx.kiq[0].ring);
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
 
@@ -1394,6 +1404,14 @@ static int mes_v12_0_kiq_hw_init(struct amdgpu_device *adev)
 	if (r)
 		goto failure;
 
+	if (adev->enable_uni_mes) {
+		r = mes_v12_0_set_hw_resources(&adev->mes, AMDGPU_MES_KIQ_PIPE);
+		if (r)
+			goto failure;
+
+		mes_v12_0_set_hw_resources_1(&adev->mes, AMDGPU_MES_KIQ_PIPE);
+	}
+
 	r = mes_v12_0_hw_init(adev);
 	if (r)
 		goto failure;
@@ -1425,7 +1443,7 @@ static int mes_v12_0_hw_init(void *handle)
 	if (adev->mes.ring[0].sched.ready)
 		goto out;
 
-	if (!adev->enable_mes_kiq || adev->enable_uni_mes) {
+	if (!adev->enable_mes_kiq) {
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
 			r = mes_v12_0_load_microcode(adev,
 					     AMDGPU_MES_SCHED_PIPE, true);
@@ -1445,6 +1463,9 @@ static int mes_v12_0_hw_init(void *handle)
 		mes_v12_0_enable(adev, true);
 	}
 
+	/* Enable the MES to handle doorbell ring on unmapped queue */
+	mes_v12_0_enable_unmapped_doorbell_handling(&adev->mes, true);
+
 	r = mes_v12_0_queue_init(adev, AMDGPU_MES_SCHED_PIPE);
 	if (r)
 		goto failure;
@@ -1458,9 +1479,6 @@ static int mes_v12_0_hw_init(void *handle)
 
 	mes_v12_0_init_aggregated_doorbell(&adev->mes);
 
-	/* Enable the MES to handle doorbell ring on unmapped queue */
-	mes_v12_0_enable_unmapped_doorbell_handling(&adev->mes, true);
-
 	r = mes_v12_0_query_sched_status(&adev->mes, AMDGPU_MES_SCHED_PIPE);
 	if (r) {
 		DRM_ERROR("MES is busy\n");
-- 
2.41.0

