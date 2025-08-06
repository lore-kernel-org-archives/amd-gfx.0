Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D10C87FD1
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Aug 2025 02:29:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97D0D10E708;
	Wed,  6 Aug 2025 02:29:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wWXqxrvm";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2209710E708
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Aug 2025 02:29:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hDqFR/RjID1gm0EZLK4ka+EnZSg16mwoAkRcOh1/NEWYvepgFm9s4pvPxwElRyNKSGGg9BvxcQEKP1WENTJdeMJR2DTRhFnJC/RMoty977ewbDtD7Uhv6/x4B1F46SQ7EFfMatXbcPfH3aA8MNaPZgd0HvSpd/yWuTFEwBaFrTXubGnqv1N1hd1Ovk3/cdgGoubVVKW7a/60TeIj7o3fxbnXbQDXGHBtzmnsnd4MDumLiDy2rq/koArCu7jGQOOg/EuOywP7xyCR94sGonjQ+4+iaAE6dsgs35/W+YyWOogzGQRHi4Ff0aTZXhH+mxiCy1YgJiOtHYKOrfT2DphdKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qyVCWlftDAdPIDu1Gk1I0z7PgskphbcEYfA6lIxgG0=;
 b=Mw9LuEU+r5c0TSQa/khjt5f80GSrw6AdHwLcooVuLJYqptS3VaZFXWw513EsBLGl+0vqHm6GO+8r9ZQ1rIR/tp5gYzvPWUZuAMnGfzMiZpifPMnSGpS7EerLGfgF5Cvwwl0u6/nykITSevbsrvHVAXBbN+dYDrSO6QW27ntmJF5oK05RXqYE8euQY0/dWCmDxuYZfpy19HfAydG3oah3j1tILGsWJU1GW0JdXXkonjw+BOGAP8KMBgbgi8h++rwq97nAW2bACzH3ExUD1jsIjW2fB7EEoC3BA4V2Pmqs0BqrZOu3+JzjFjnY9JYMlVY3iqN738eCp+9EQ+54J7Y09g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qyVCWlftDAdPIDu1Gk1I0z7PgskphbcEYfA6lIxgG0=;
 b=wWXqxrvmCTzbrz2jNbxGIM7zyXog0Nv0oiUu4yTwxFTehYxwV00PhWVL1wGafVwVqojR45TuJBm67aoJwsmO6Wm251mx3ydkyvivQ6Gv58PUWuc828pJQjT2UYJJ10zOjcSeL/exzNZmkn1sOEfSDgHrO1IKOhWKFa1RtXSRGqY=
Received: from SJ0PR05CA0100.namprd05.prod.outlook.com (2603:10b6:a03:334::15)
 by BY5PR12MB4145.namprd12.prod.outlook.com (2603:10b6:a03:212::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 02:28:58 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:a03:334:cafe::6d) by SJ0PR05CA0100.outlook.office365.com
 (2603:10b6:a03:334::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.13 via Frontend Transport; Wed,
 6 Aug 2025 02:28:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Wed, 6 Aug 2025 02:28:58 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Aug
 2025 21:28:57 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 5 Aug 2025 21:28:51 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [v7 06/11] drm/amdgpu/mes11: implement detect and reset callback
Date: Wed, 6 Aug 2025 10:24:51 +0800
Message-ID: <20250806022816.1050823-6-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250806022816.1050823-1-Jesse.Zhang@amd.com>
References: <20250806022816.1050823-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|BY5PR12MB4145:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b1f2ca3-58e4-4ebc-9cf7-08ddd490ff98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tMEIZ/5vVhGKowlXEFr8ROelOaeWvXyuy+aQz03ktPUu53tvXBZVK4WUixfW?=
 =?us-ascii?Q?s5rpK+3597+Qsgj2cmib4ZKi6KtZyxjsC3GbqFZjsrlFHNUWCyprCFo/AiTx?=
 =?us-ascii?Q?DnD/UE0OQDlwE7fSes9pXj5wKoGwlKVw98Gf5mwrhiK4UPf2qrmNofK7bXee?=
 =?us-ascii?Q?QrVAavMFfMgIlp6hq12MbRdF1E8NkZpq0etXW85CATCi8ppNHQlnBAxBn+02?=
 =?us-ascii?Q?T5s3jW53wwBqNp0Gm2TvZS6wZ2H8Xb8+jnoPwFBSmcsxiId7ikDp0+/SIrr/?=
 =?us-ascii?Q?jOJoQNTcPYgFGMj3f12Fm9eJDLYDipqubmJy7hWrO1xtmL/MNjEeTreja1eP?=
 =?us-ascii?Q?6LhF9p/KAH8/FCXMYcf0ZoktizyROIWC/eq4nMRgJK2ZjfFkM8YrRyP8m3BA?=
 =?us-ascii?Q?zaY71oNN/ByvP4iqLfEyp3yZG6X5D6OatcC+AfQKecP0STuLf6YDwGyrci0k?=
 =?us-ascii?Q?cxkJJSlLT9gK5m4KUcWl8Cxx1oImV3BWtF71oP83KlfoEEWQpOyoiuIwuMrE?=
 =?us-ascii?Q?rbf6Atjvyvd7OBbTrUQRnyDbKtHOz3mdmPLwQ30FOP0ovSjIx2X5907np+q9?=
 =?us-ascii?Q?sF/FPLLaa5CkexHfrXHXeApQu6kwE1mKLQpTvdblpQM0m1PF8sfORRuqpZCv?=
 =?us-ascii?Q?UWe0L6VRhvyjdDfLfftyrhpRdb/vq1v4m1XbsD5AdO7AHtJYcXS3h7b6pARy?=
 =?us-ascii?Q?9eRgQkjUXLYeTEQ54Rf3pVv2WpzMf5OUFLwb53bpWTzxh2uKzr4rbvz13UL+?=
 =?us-ascii?Q?mVhKJUFukuZeBW/FawTmWyCZt+hvwWej9YTMlDtk2nAFpcgdy59JeVAsaJ3t?=
 =?us-ascii?Q?j7D466Go3av6qmqGpBbvoNy0AU1PB10iE+Ot5XNQWla5sJi9MrLpIwBBUZVU?=
 =?us-ascii?Q?kHGg10S6h9lsM6QdHv9xl4jXfZd0GG2DRgDj2Jvmcdzfmz4PeZbwfCHywS9Y?=
 =?us-ascii?Q?Kmt9Nw8cJAnVxxm/kCJlofsU1wi0n+rojZP420utSaAsTj4FUOwT88H6gjGk?=
 =?us-ascii?Q?ePaEbWNbZWFGbQ7biQhNQOU3F1Ceb3kuaJ1Sf5FJiqvb7iIvsWmfkpP+BBIp?=
 =?us-ascii?Q?J0K8FPSAThHmqATCKWz7v/0BW6vroGRKZDN7ahdaUpleFB6VM9qCqlTkx3He?=
 =?us-ascii?Q?N+3iXr4FqnyeBo0PJ2uvSPGBRS+8/YB1Gxe7snalli7tYb6bEr4gGtMSUwVd?=
 =?us-ascii?Q?GqDahog1qN0qPT/qlZcEmlu9X+NADy9M6miK4a031ULpFgkWirZZOKHZ+YQ3?=
 =?us-ascii?Q?4RkmtwMfi1rBDWSXkvDGlZf3rvR2M6FUm9416SliZ5F7eYIioQq4R0Ha3R+z?=
 =?us-ascii?Q?GQUK37p8iHUhGFElwtV9bnQyRzs/ndRlPzmfmdWGVGB8HxYMsi01kWhZqKQD?=
 =?us-ascii?Q?Dm3Qg7oguSHfLJtNIuEV4T0qQ6BKySTGjih21pi3bTpU4Q/id+xd/GoiMkH5?=
 =?us-ascii?Q?IRlwGYTqwUWsWHoYiexirdSOwgvathJq7MlYqSkocx2/zGzoKr7DK9NEaA/a?=
 =?us-ascii?Q?00fp6JN9OR/QOxeqyY//cJOFGzhGrdRJwUoD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 02:28:58.3711 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b1f2ca3-58e4-4ebc-9cf7-08ddd490ff98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4145
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

