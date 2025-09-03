Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A75D5CA0FF2
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Sep 2025 08:39:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5836810E50A;
	Wed,  3 Sep 2025 08:39:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="swN0NO7u";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2067.outbound.protection.outlook.com [40.107.212.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CD2010E50A
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Sep 2025 08:39:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v/4CwM8W5llO1WyWRPPOwtEUuNDownlrYg08yMR71ocCZeVc8xYxzuep3xTyrfto4GIrdYlGXMq67rQIgC7O9NhgcFEONws0hD75MwoCsmbZowZAuxZ5AELngpKWTTPlsGznrIqpKxolIK/xdkTf5TcAIlVOWejfyhAb+CaOamMk5qrTsdXfUMEZKVHlTe4Lz4jKAdkupnSrM/4ye7bsLaTA7JsCROcxSShCn3pNt7BNhMrNgXdjqtw38HPJGrTMpXFhE6kIk4FXNUS9KtCnuCaVoS0/o0jdMOGb0d4C8YZhTNbkGDAJcJkx1IQYDGxAbbwI9LK3BdMQ/euhIc+uJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qyVCWlftDAdPIDu1Gk1I0z7PgskphbcEYfA6lIxgG0=;
 b=jYWrpdCev5p4FY7iH8dVTgInxxcznFv5UpaqG5bxh2MoneHQDLOv81akjD4dbH4pt8tTqKcp7hBQ7YV/xveLY3pxodMyRAXuZw/hrXgi2SRAIOyM5NkhqNsrOUQ3dq816ug5giVK/zgo5mdc9IPbainFOB0xWYmoA94DMVyjr70H4Qn94WU/8NyJPaOSDIf/JiWf+gb4B4W5M4nLR2bdl33xDndONk03byL0dtZgKJYeCiRaEyYPBQZLyPPyrJQvTHdK9Ewv4EHerCu1gunFce69QTOHgtiMF/kjeWPbsjDp1yn6PlzN1yvwEawU62nrbivqDNCbQqsVRdUD9i84YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qyVCWlftDAdPIDu1Gk1I0z7PgskphbcEYfA6lIxgG0=;
 b=swN0NO7ub5Km+gLohs5xOAkxqrQ1GSs0xQsWdov5Mj6VslFc9EnX5BHXmpXMqj7Jr+sLo6Qj17T4gwLMIsC5jXkaKydTX/QAULV6vorrd07IALguXI0IxMZDfizDk9e6Sxs9R1QW9sAbwF/M8E+0Zr1FGyJCVlhIXfPpIFdvEiU=
Received: from SA1P222CA0061.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::14)
 by DS7PR12MB6119.namprd12.prod.outlook.com (2603:10b6:8:99::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.27; Wed, 3 Sep 2025 08:39:49 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:2c1:cafe::b2) by SA1P222CA0061.outlook.office365.com
 (2603:10b6:806:2c1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.17 via Frontend Transport; Wed,
 3 Sep 2025 08:39:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Wed, 3 Sep 2025 08:39:49 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 03:39:48 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 3 Sep
 2025 01:39:48 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 3 Sep 2025 03:39:42 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [v14 05/11] drm/amdgpu/mes11: implement detect and reset callback
Date: Wed, 3 Sep 2025 16:34:23 +0800
Message-ID: <20250903083914.2604482-5-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250903083914.2604482-1-Jesse.Zhang@amd.com>
References: <20250903083914.2604482-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|DS7PR12MB6119:EE_
X-MS-Office365-Filtering-Correlation-Id: d8747848-6d7a-4903-a5cd-08ddeac57197
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Dd0Ba140avL6jDVF5D27SaAcJ8gxBowug3XGvVdKzuq0M8kNwDZFRLL8jg1C?=
 =?us-ascii?Q?OtyBDyvGN10YOrd8TV3YfL/9+T9jpzI6G502luEY+Hr9L4NEdhkNahu88E8G?=
 =?us-ascii?Q?ZfD5U8d6R13UujkV3eACJHy5tX85c9FhZ1Zn2AtaoQ42jN++XrEnR4AajwgX?=
 =?us-ascii?Q?kE3drZBGb0xLGaXW+m7j82AbfMXh5NZhMfoUD51e/z+V1QfpcL8rzf+6b7Ua?=
 =?us-ascii?Q?yFA+q142ZV+PSm1arbutmq0cqg8keyu5mDUwvSxxsOI0tZ/iDD/yeTOjyB+p?=
 =?us-ascii?Q?IAU3FALOVDRuVCWUusk52qFfA6Nt9l/QOUJ3o/dTA9GGCmIGlEiu+HEN4F0M?=
 =?us-ascii?Q?LyfYIoeZsMWv+8Y0ObXu74EeuOdUZxAb1NqXxw3YBs8t3XVKiuezMjSJNW5/?=
 =?us-ascii?Q?nTksc6sGmYRiBPXnFAO69LDDYgWApUR+3sCBJVXJCGkgzWIJLFtxv8JOmuke?=
 =?us-ascii?Q?MPeONMw6b/DC5BscZnpldYuQJdj1IfYDRBFDypSweXX8dyiQeF9P21iCyWuD?=
 =?us-ascii?Q?X2tYtBpm69JU6uTvP08iBgdbrJpeADl7288WQYuIlAk+muoiDmMKkS3XcPEG?=
 =?us-ascii?Q?9OlL5Ez6XS3K5WiV1E265QKI6BfYPkem8fhrcr2xi6r7ubnww85PAGurFUv+?=
 =?us-ascii?Q?1pV6TzC4oibXKY5mDuh8mYwu9cP5M4OvZmyb5wKG19FGljjq14py6V02fok2?=
 =?us-ascii?Q?hROCw021pGtrrbu33LIXWWUvInYF0WJltO9GG4mDsFaA3a6eLw8SpltXz8+R?=
 =?us-ascii?Q?DlZ4Q8qmSiuQ5UWUxXhvr4wKjipcBAKFZ8VZzKtlzd7/OQ/F9mPoiLDnTRGh?=
 =?us-ascii?Q?fIZd3YoMDVLZImMWoVWGJrtl3URUZVscEKYahzSeTLyvOlyYfN5bdPmlVQrq?=
 =?us-ascii?Q?R8qHBkvD47ZQ+Qe6lpdFXBj2QlMTz2jLhEJFDyPHgo2NcEXuJnLXvBt4E0Qp?=
 =?us-ascii?Q?2sXUCnZz67Q3bgjgpbYbpGyTP5TMCVKOrnNDXZp7Na+5sbSaeHGeZ4TcHRGe?=
 =?us-ascii?Q?kusb0vW9gq2yKC53z+Lks6k2PIy+Rra+AdIuWuVnNvzoWeD4CU/Oh7BdG39J?=
 =?us-ascii?Q?FdGwLnS1sAZre9rNlrpCqC1AoiN2Rjx8zJDzC24FbnkXwdMgjYL0YJ9msjzX?=
 =?us-ascii?Q?zFuAFa5u3NuHfZlZ234QymqzwMYMzaIntCHJtloUj3EhjC+0WPyETlMYL9VH?=
 =?us-ascii?Q?CQEvjwPQaKa2XzqDEj4LK6X3hYF2PkquoyuqIXzahDKDXdgInEq3unvhgxvY?=
 =?us-ascii?Q?iJtfebhrZiC9hGGg8VQIYmmFCj+rKHmdVVmR2DQhJe+9+Pg39R8Tp7wyagTD?=
 =?us-ascii?Q?lsp4dVqKe+s6ONLs8VSD4UCiyNdvdTv8Uqjx1yONuzf0NV9D13LmtpDpTcYZ?=
 =?us-ascii?Q?sPpTY9viPVgu40ce24Y89I0CumDAqJRW2hVd0vNN9OL1V3otofW6I8b++N9B?=
 =?us-ascii?Q?4i3SU8lBjljDkRsvc0rOm/FTmW31e/7XcENxugWp6B1sPe80bxpRdgZ+Leja?=
 =?us-ascii?Q?ZuAQJdAxxdA8yiCwcFq2WAEFIcKGRH9p9JVS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 08:39:49.1029 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8747848-6d7a-4903-a5cd-08ddeac57197
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6119
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

