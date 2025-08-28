Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BEA3C8303F
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 09:17:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E38CF10E951;
	Thu, 28 Aug 2025 09:17:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rLRJo1WS";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4167D10E95D
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 09:17:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f4v1o60Y4ElE8Cqj6Q+QmrFoLfQH6VZ6sp09Wm7HFnQBx1OyAChE7uxpZAQopqU6sHDi7nWzEnIHl3dYjR7FE7z+NY25JSOb/gFFxal3XlGFB7by9V0ZxPcMPAEU1py8bZR/uegwES9/qKUbp1zTuOGyuF+AdSgOrHVnof1LSseARwQYYgIU9whShnEoqguBC8KMsELeiOSEZ13KRcvjjp0wW2futJS1I0raIjJGDKwO+7Oz5kqGuzaD+hAtT8wUrrjP2R/lrZ1hsnRiv3YhaOWfvDoRCwQ6/loDfjzQihlkH519tUr2SaGP4SfbIvuFBFQW14u1cO9YH3bhWJhefQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qyVCWlftDAdPIDu1Gk1I0z7PgskphbcEYfA6lIxgG0=;
 b=CVXqVn9mPzxgHP+I+s3z9FDUBWwRqhl75lcrdjpaO4gI0wTuoRb7r+skuJ9O001QzbgPrObOIkjOzbsdVDtVCQEriWTWh9c/3xI0T7Imwn3aM0b7KNYLhMK1QiDdzqy8lQkP5aWIYmQMj18lQRmNb4JZzaKANaZ99La52mYK556WL7TwbZsSR5FhLVNgWtv4iplLk6DQj/Md1OpTl1/6E2Y7S4AF7ghL4e5lMqNLDS26lbJrpdYT53kpm1Mww0bFXWOJIgr1+NCKQBMAoAH//Z7b6HeUSbnaxNchdm3u7h2CLN5IPJo8Dgv40WW+LPEv0hYE4DMCY5YFnbVXCbXaaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qyVCWlftDAdPIDu1Gk1I0z7PgskphbcEYfA6lIxgG0=;
 b=rLRJo1WS+HlVHlXQrcQow8WjXD1ADPrah/pHcdF/GyrVj51BP1V/P6L6lCz5oFG6meNTFlTaKhogfJazvmMWQYJvX5gN5zGwBjEYRxH2nzN+0BTr13kzdAdnewkPWRp8ZjBb8njAGi1dTLMUAF6QxfCZrXO31FMqDSwac2vHdaI=
Received: from CH0PR08CA0025.namprd08.prod.outlook.com (2603:10b6:610:33::30)
 by CY8PR12MB7756.namprd12.prod.outlook.com (2603:10b6:930:85::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 09:17:35 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:33:cafe::34) by CH0PR08CA0025.outlook.office365.com
 (2603:10b6:610:33::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.17 via Frontend Transport; Thu,
 28 Aug 2025 09:17:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 28 Aug 2025 09:17:35 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 03:45:31 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 28 Aug
 2025 01:45:31 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 28 Aug 2025 03:45:24 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [v12 05/11] drm/amdgpu/mes11: implement detect and reset callback
Date: Thu, 28 Aug 2025 16:42:11 +0800
Message-ID: <20250828084457.1999535-5-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250828084457.1999535-1-Jesse.Zhang@amd.com>
References: <20250828084457.1999535-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|CY8PR12MB7756:EE_
X-MS-Office365-Filtering-Correlation-Id: 44d5eb98-40db-460b-03fc-08dde613ba09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?W8Ot6Oyzhta4lOf3tyi6OAJrc8vXOEVtA602JVUk6iReT0gFG0eq68ijcr6k?=
 =?us-ascii?Q?KkfFPHQ0AblpNV9pei4vTFAIzUWBwf4K/xyOXIUYZNthtdXrnVY6+3+wVlkJ?=
 =?us-ascii?Q?yfvM6WpxU1Gvsb1WJu1SXm/MFH6D2CZpV+jUoroVRP7bi5TGPg1/WEbUvSnS?=
 =?us-ascii?Q?HU0YqUcXoUWXic+OXwun09S6kKMngHxXOgyFQWMQI4iFn/Lw7NOrHrS2JuSH?=
 =?us-ascii?Q?51e78mf+t6Oru/honzKd80xziZ5bptKqUxOkUElS5czAqIKA6Saz7GjNpPk5?=
 =?us-ascii?Q?GyOQbqq+G5K20m9tBj4W+oifl63C3dZwhoI47/XX6TvbSrz3ip7m30tn45li?=
 =?us-ascii?Q?q/17zE/K8ZQCVsf+P+UL01VJ9avr5brCRDQPq4bVuRm1Nn9x5bhGLS9k47w2?=
 =?us-ascii?Q?GsA6I8vFs1KpPDAHTcdO5a6kdXUfDeWTBXAFFDKXh6T5vV87uZH7FLs+rcbY?=
 =?us-ascii?Q?p4+o67yzeIycFBjXBm1e4QxKTj9bn/Aj8Vg5+tEvRq+oBrhwKMA6wrWHXj/l?=
 =?us-ascii?Q?eEWOPl3pDSHzeGBJcT1PD3b8GTmkKUwkBE/LpuqvNrXb3KqdRuFQKrNHY++o?=
 =?us-ascii?Q?Fiqv5bRL3h/Ai2D6dzK1XH+1cc4SvUq9YdZeXPSjKjC36NzlvwUi9PYVa4Xs?=
 =?us-ascii?Q?zfo9LgDCTswq/5azy5xdzOt5l4PQUa4VF311uApmAChCZHuZPYLHsTyeN3u5?=
 =?us-ascii?Q?+cnYsBr5nHf2stG+j+gwI1/XHlYs5O1xWjbeb1jFwAGybVpBly+dR/RggqoX?=
 =?us-ascii?Q?be6KzqFZzmUO6O2m+TAcWrIm7bAC2em+ekOyv5qUl0oLwMVmHyfQp40gFYHB?=
 =?us-ascii?Q?rNvB7X8k/xKbVxoyhz03UPDqSptt/JbN/Qi7htachngdZKSuJBuet/uyMAWm?=
 =?us-ascii?Q?uTtSJ2Hjfk5p6bwDGmGhMAWWteJLgHgFq5FY0laHCs5r6qLiscW7oeehNrSa?=
 =?us-ascii?Q?Vhn30kWbDIJ+1fZW9xffC7M5BiSNlm6oaMF9hoieZrFeDK43QvzmGKWYkPkL?=
 =?us-ascii?Q?aghEh9g96VaKAY6uIZEXpgGLfKSwdYNI4xcbgAaDvfGo4FvH56o0nzk5giBf?=
 =?us-ascii?Q?kT6OmIM4aiFSV/LLfI5RVcoFtVZvH8m2NzJU3MZX6h61kngBBhhZIl2A/OOe?=
 =?us-ascii?Q?kjRQzdW0hAwqh9YhLxzplG0aXKIqBxaUMiUJb72HE21G7QriCbl382hBLZcN?=
 =?us-ascii?Q?p8E5ahcFqO8H1+X9AF18oll+u5LfujD40oIHgOogIys2+YmuOdM8k6kyJflr?=
 =?us-ascii?Q?KLL8M06jhtKrVB/sGJJpjaa73KriaiREe2PXkQb9/sEYuqovEitdSKXlqD/C?=
 =?us-ascii?Q?XiTLbAHozUTLAZ4NgQ8uBsESoeBe3LespsUpqiFoD2RfEJoWqmCq42cyTMly?=
 =?us-ascii?Q?9N4mLQHsy/vNELEA7w0ZTdGvZnn+rXAjjAWWY+idDcPzW8Tuw5A712kuB0Me?=
 =?us-ascii?Q?ZTta6F66e/vpl2MURDKfcQlZ4iSeG0Y/saRxT+LzuVcFeQVcQEClNMHBx7rU?=
 =?us-ascii?Q?q5Q3pu+g/+m8lDGGIy9k8LXgUZTYJLS91Dyl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 09:17:35.5798 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d5eb98-40db-460b-03fc-08dde613ba09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7756
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

From: Alex Deucher <alexander.deucher@amd.com>

Implement support for the hung queue detect and reset
functionality.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 31 ++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 28eb846280dd..ed6a7f8af544 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -66,6 +66,8 @@ static int mes_v11_0_kiq_hw_fini(struct amdgpu_device *adev);
 #define GFX_MES_DRAM_SIZE	0x80000
 #define MES11_HW_RESOURCE_1_SIZE (128 * AMDGPU_GPU_PAGE_SIZE)
 
+#define MES11_HUNG_DB_OFFSET_ARRAY_SIZE 4
+
 static void mes_v11_0_ring_set_wptr(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -783,6 +785,32 @@ static int mes_v11_0_reset_hw_queue(struct amdgpu_mes *mes,
 			offsetof(union MESAPI__RESET, api_status));
 }
 
+static int mes_v11_0_detect_and_reset_hung_queues(struct amdgpu_mes *mes,
+						  struct mes_detect_and_reset_queue_input *input)
+{
+	union MESAPI__RESET mes_reset_queue_pkt;
+
+	memset(&mes_reset_queue_pkt, 0, sizeof(mes_reset_queue_pkt));
+
+	mes_reset_queue_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_reset_queue_pkt.header.opcode = MES_SCH_API_RESET;
+	mes_reset_queue_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_reset_queue_pkt.queue_type =
+		convert_to_mes_queue_type(input->queue_type);
+	mes_reset_queue_pkt.doorbell_offset_addr =
+		mes->hung_queue_db_array_gpu_addr;
+
+	if (input->detect_only)
+		mes_reset_queue_pkt.hang_detect_only = 1;
+	else
+		mes_reset_queue_pkt.hang_detect_then_reset = 1;
+
+	return mes_v11_0_submit_pkt_and_poll_completion(mes,
+			&mes_reset_queue_pkt, sizeof(mes_reset_queue_pkt),
+			offsetof(union MESAPI__RESET, api_status));
+}
+
 static const struct amdgpu_mes_funcs mes_v11_0_funcs = {
 	.add_hw_queue = mes_v11_0_add_hw_queue,
 	.remove_hw_queue = mes_v11_0_remove_hw_queue,
@@ -792,6 +820,7 @@ static const struct amdgpu_mes_funcs mes_v11_0_funcs = {
 	.resume_gang = mes_v11_0_resume_gang,
 	.misc_op = mes_v11_0_misc_op,
 	.reset_hw_queue = mes_v11_0_reset_hw_queue,
+	.detect_and_reset_hung_queues = mes_v11_0_detect_and_reset_hung_queues,
 };
 
 static int mes_v11_0_allocate_ucode_buffer(struct amdgpu_device *adev,
@@ -1684,6 +1713,8 @@ static int mes_v11_0_early_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int pipe, r;
 
+	adev->mes.hung_queue_db_array_size =
+		MES11_HUNG_DB_OFFSET_ARRAY_SIZE;
 	for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
 		if (!adev->enable_mes_kiq && pipe == AMDGPU_MES_KIQ_PIPE)
 			continue;
-- 
2.49.0

