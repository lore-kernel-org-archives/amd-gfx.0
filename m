Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6302F9D0F4
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 19:48:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EBEF10E661;
	Tue, 14 Apr 2026 19:48:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T8xMZWl5";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012019.outbound.protection.outlook.com
 [40.93.195.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E0D210E661
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 19:48:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fUdD/48Ig9PiWgZPLJpwtlnFbggz8HsWAQ4rIowFzoyfQoVm8aVTYTLsqsPxoO3umvu3AhSrqxeNwsv6ofFEq116CyTi3btlcK+11BdcuJ87W0hxQq4GRe0V2CQ3r2FVNaAwbNK2NuF6f6rIkhFlTHdn1I3sUPtyZs46ouG6bou9C5KgkXdIX3l59RMMvVVwrJJ0SGyoVLqkVgj+VT9LYxr+JxkCTS5rXGAS5eYYHbVeY57vzo0GpQRklOTd/sHEBkBxmRJbvz7NP5u8C6+DyiU/WOHITVCkUUqlLAPDU32TdrO3osmFnHMiDr8znvLvcplGfW+5xfYQgXkQNId6MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=52rYztNrNL7PS+6u5qSr2wdSMQOAqlVvXF6jStfurrs=;
 b=v/ONXhhQ0zWvqZFJMIqU1WnPcQSNDNLczUhKpHMhTnrGCWIWHnBlE4B4FZgg+f7DbqhIO+whYHPe6nwBTrv2j1uococnMlJ1vXdbNGjUAajeRzCve6PI/4vHsebVTFlGWDpzFdDpA923xPQsqh+KSa/Je2F/CPoqpKRcoFFEOMgYqMCoK03ZTqGue/3PfXQ94AYeWrCs5EkjnC3Gp2rqqMckseCLwLi60FHpoxQfZAd7H/bfnWoDOQJrqPGyIBxj4DFeqzdmOKWbK3axIc/2p85+V1GlEx9iA1hw9OuQjL/qjsoJeUcr/8NkAtzs80B21Q5Z+bEbgEMMja3jK3Rsow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52rYztNrNL7PS+6u5qSr2wdSMQOAqlVvXF6jStfurrs=;
 b=T8xMZWl5dNByRHiBRUm/wxiN2jHmL+TEks94B/UJBWWYnk1MA4S4F+JO3IQTbF4Z2Rev7JLzsP1zc3mUoJjEjubhVIjzfDiCdkjCSJ+ApnpRGEI43e5RZ70uLWKJ97GXGoke8k/MPeOYbvEeHYn+OHHK5iS6t54RvXw3hQoQmg0=
Received: from BLAPR03CA0015.namprd03.prod.outlook.com (2603:10b6:208:32b::20)
 by DS0PR12MB8069.namprd12.prod.outlook.com (2603:10b6:8:f0::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.48; Tue, 14 Apr 2026 19:48:28 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:208:32b:cafe::a) by BLAPR03CA0015.outlook.office365.com
 (2603:10b6:208:32b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Tue,
 14 Apr 2026 19:48:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 19:48:28 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 14 Apr
 2026 14:48:28 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 14 Apr
 2026 14:48:27 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 14 Apr 2026 14:48:27 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/4] drm/amdgpu/mes: change gfx_hqd mask set for mes v12_1
Date: Tue, 14 Apr 2026 15:48:14 -0400
Message-ID: <20260414194817.2213993-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|DS0PR12MB8069:EE_
X-MS-Office365-Filtering-Correlation-Id: bbb4500b-e091-47f1-1a9a-08de9a5ecca7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 47ReWwzYKgse65KfBRVLWGov2W+0DO4OmmlAF6Xh8lEKC0wWhOarvVALtNZnx2RyBUJJgAETfgaSmGyx/erlHN1dMC0sxE0N6/Idq/a2C6yDgZHDRY9KMB2dmg/PICmO0HtR2E8QWafYLOKy0GBj+UBoEERmCbpRcxxtU6AUATBL7jZi0VklVQKMHvkNHj6EG8te7Au9tp4qwtwXIK93z4mxS5LUrXqA+jXo1YSxKN7+iyiEu2tjO3xcts4TNWNV/Y4vi5aLcjVFUoHXnhdnJrOzEacAFsnM7ahLSjvytrm6430M3MhlndPo8BPgXOKFXU7oVxoCsnXAVWT4iVbZJxLtWHJQ3/KtN96ct6BIIEYzVbOyOE7w9Dd7ptHlQo8HJ+QW/psPgwv4I1Wxh1F2aVLPdctkzaTGd6ilkSMYA1zBtyqUCjrHWc/j79PTiZM4Q2GuZR/iXNCELKxbbbCCbHK1DG68qXtnYCDA1yL91J6299K78tONTWo/o4OtAfSVlTTVFq6c3VlI/SYkXODLtdDBDDcWEstSAKBURfdfqELwVrkuCopFCiLBo6R17gI8oQnSCxKuSWBhb8pBevMhKjZTxbVTaRW+DT7v535yzkFiRsAJzfdSOB2qBvB4RX09mjwND1IRILfb8NmoJHHDIeqUmiFBzV2APgtXqCQrlPWgx31GTto6Aa1+IMgafCGak/ZKcc+FmNoFuk0LQmOEehOhrGSr7l5TiC1iX3eDD1oaf5zKPI1XT7cEvJyc+J9gTHS85t9uD+6pXB1ixCmVRA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0eJ3kMx/BAm19K/VzX7tG0CHNJ6Myj8RyB+Ke+q3dWMlwWrS21YilFrwUf5tZP530TuCqGC2Kj+y/4kHdeQ+t7aJU/a9Vnj3dQ2XrqfOYn1s+zCJBdWpL8OLXWoTmEYQ1A7te24wSHErJTAQKDuoiKDA5VU04dx7JigcMPhRcjqAtGqNITEKNUU08PUyjfDLlGBno85OFE2wbi8AfNwVc2xgnKe42KwYq2jWLcylgfx/xIH/+eDiDGWYvdjFNzXtSLtqnIul9bAQGHBRYJR3tJd4h//v1/myGWcRyCDjrDJCboqZs7fFlNwp49L0EOdEpkDbIKkRgXNJ7Yf520P/DH/AY1WoUHvUfaJ5SMXxG0kfuNkKZYyeja3LopL8yyN5KI9FVePyTPYVt3mymI1tqNhyp1Z0B9++R/zAWilVoGqLPEWjmf82Pvp0StFlKLYd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 19:48:28.3848 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbb4500b-e091-47f1-1a9a-08de9a5ecca7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8069
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

From: Likun Gao <Likun.Gao@amd.com>

Use mes->gfx_hqd_mask to set gfx_hqd_mask on mes hw res pkt
for mes v12_1 just same as other mes ip.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index cec8012781265..456dbbcfce1e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -633,17 +633,6 @@ static int mes_v12_1_set_hw_resources_1(struct amdgpu_mes *mes,
 			offsetof(union MESAPI_SET_HW_RESOURCES_1, api_status));
 }
 
-static void mes_v12_1_set_gfx_hqd_mask(union MESAPI_SET_HW_RESOURCES *pkt)
-{
-	/*
-	 * GFX V12 has only one GFX pipe, but 8 queues in it.
-	 * GFX pipe 0 queue 0 is being used by Kernel queue.
-	 * Set GFX pipe 0 queue 1-7 for MES scheduling
-	 * mask = 1111 1110b
-	 */
-	pkt->gfx_hqd_mask[0] = 0xFE;
-}
-
 static int mes_v12_1_set_hw_resources(struct amdgpu_mes *mes,
 					int pipe, int xcc_id)
 {
@@ -667,7 +656,9 @@ static int mes_v12_1_set_hw_resources(struct amdgpu_mes *mes,
 			mes_set_hw_res_pkt.compute_hqd_mask[i] =
 				mes->compute_hqd_mask[i];
 
-		mes_v12_1_set_gfx_hqd_mask(&mes_set_hw_res_pkt);
+		for (i = 0; i < MAX_GFX_PIPES; i++)
+			mes_set_hw_res_pkt.gfx_hqd_mask[i] =
+				mes->gfx_hqd_mask[i];
 
 		for (i = 0; i < MAX_SDMA_PIPES; i++)
 			mes_set_hw_res_pkt.sdma_hqd_mask[i] =
-- 
2.53.0

