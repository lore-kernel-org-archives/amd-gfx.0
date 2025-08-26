Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FBB8C8303F
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 01:47:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F310C10E5A5;
	Tue, 26 Aug 2025 01:47:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Tw6oBi3D";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C62C10E5A5
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 01:47:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yVwetjqAfDXNQl2Neig2lSNNExhpC6L3JgiRXvNCzdtAflegISMzaNt5fJdG4RoP6m/LmhQ29oFnqgzBgVYc7DIQolTVnEEDj9RE3vvjjg+yhyXEbxx/6CghwP0bgK4yEMrkvOVc38o5bPucHWXSQmKRb6kzTUDBR19r2YUtwR5WMbhEItvYf8EMwB0/Z9IQ3E8ndn3wJPwnzholtpdupOJfxzT6Y+s5mk0yVhWuMgtZvVBCmuIjIQZZfefHj4RubbUN4QOW/TMohbNVFEBfgSXmi1nclaNUEtr48bmYmOpL9sBMgAvI1jlkJMs5LKGRYqJzMMPvTOnZ2XRsYPsPBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GS7u0vRL2HiVTwFO9W8/2ObbCSb7pvCpsdKBTv8lRc0=;
 b=CU5karWcQgBH0TFSNRb7CrXRAZs6mERsBrHSBBLT6inb08nv6XP5eeYIaG5fRPCl/XjOnoAraWHgns7M3Wv7wTyNVo8uME9xYtI9+kbzmOZY3QZouhrD4YnqHcfR9BqDN3BvvNHzTbANWHCNxG4j/aaZtAO5jVAh77qWYHhoEMSkHvlc9vXUHRS1LrHG9njy4QIbXvn1dArHBmAarM181AHmGGBtZ/pqZ0FaqOrXEWqJEoEPSSJ96aUFR3+ooMcDMoHAOqkL6v/32u2sJ6AbyVpraJHvmVZynYy6eOLDl0QnkJUjMy5qJrXfQjTq0vhn1vOQ2q2h6MHX0yq+ZXcEvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GS7u0vRL2HiVTwFO9W8/2ObbCSb7pvCpsdKBTv8lRc0=;
 b=Tw6oBi3D+6jleqH2gFl5C5v+hrXc53dxmZsv0pfdDZQzYN9h2RMoeEuEAYhAAt2MLoGMBrgzAe2ZVSLgpCAA/m7bjt2oYyK3kEi3/AyG4TGHMpCyRTJWCgyRmKnpkxTNnGw+v1JMrNrowzE+/WStypDssRctDcHCALEY8aheep4=
Received: from CH0PR03CA0265.namprd03.prod.outlook.com (2603:10b6:610:e5::30)
 by CH1PPF84B7B0C96.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::618) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Tue, 26 Aug
 2025 01:47:36 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::38) by CH0PR03CA0265.outlook.office365.com
 (2603:10b6:610:e5::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Tue,
 26 Aug 2025 01:47:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Tue, 26 Aug 2025 01:47:36 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Aug
 2025 20:47:34 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Mon, 25 Aug
 2025 18:47:34 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 25 Aug 2025 20:47:28 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [v12 06/11] drm/amdgpu/mes12: implement detect and reset callback
Date: Tue, 26 Aug 2025 09:42:16 +0800
Message-ID: <20250826014648.1711926-6-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250826014648.1711926-1-Jesse.Zhang@amd.com>
References: <20250826014648.1711926-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|CH1PPF84B7B0C96:EE_
X-MS-Office365-Filtering-Correlation-Id: c46d1330-e151-4eca-8acf-08dde4428852
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HmyXQHGAhIeAJJGA1b0emX0BLsN8x2ge9B49wDaArXsm1vckaCPZggMpu3Oq?=
 =?us-ascii?Q?CBUDc1PeICncDN+BuLnZXKYew2eVdOmGX076yJUTEIcucbmUQN2WyDkMQevm?=
 =?us-ascii?Q?TGyeFc9m0Sd7Nzg1qtvccShr5W1+vHv+WA0/I2AMHPRVvNMexPvYH72DEM4k?=
 =?us-ascii?Q?ZoAyVYiXRWPx4Tl2XFvN51OltVgsYzDbkY3cO+Vxz9RzO390kgWbNG2A4gFO?=
 =?us-ascii?Q?WN/qASErj87mpB6aE5rd4OrJ+pnkWEqpmnjoiWSFaOeeqtlXh5IJRg+C978a?=
 =?us-ascii?Q?XmVdeJWOoh2qa2rgy+iTt6Ut3mpkHPKcYL/YhiXB5uYaZn+7BR2Zc1u4os1M?=
 =?us-ascii?Q?xjjZ+f7UZTD+G+NIrGWESVUFGIPvr3aD0pTUEy0UpYage5fMXMfd3wJ8q9g2?=
 =?us-ascii?Q?ugoo7jve+RKOnO5B9Vja1ASZ4InnIx+KGxERIq78dtpDLTvV6J7HxIgcCcsf?=
 =?us-ascii?Q?m3/sL4++GnvX89sG91X7UsbYbt+/9kR5mOL5iZnScDJhCAde4USrDcRG9ljF?=
 =?us-ascii?Q?iga2+h3lt9q9+mwXIdNukTLW+3ivEC5dDBCBotjf6+ts4unM/PMuezyWAeUa?=
 =?us-ascii?Q?gWi8xtePb0vLbXhdFeSmsm3XmzGjL2IujmtFiMYfgA9h08oO1x5SQB08NFN+?=
 =?us-ascii?Q?jwc8+bx9reHaM7Ox/7SQiYXQEzN/EiakvlmHVK9eBK4PFE3RNlzNU37RAS2T?=
 =?us-ascii?Q?2JMVwmYrC4zL+mWJt+ltmAS9NuTz7AwNpjEnX8F0kkSfLyYZWISfdMvi9lIP?=
 =?us-ascii?Q?brR+ZmgaQJamSN2+f/NW0mkyOQmiQPRRov4S6DVqTfk+5tgRKS8P8G8mQRJM?=
 =?us-ascii?Q?w5UPyvnkFCk79NldoRWpsgmE/3dQ+n4ERbWpA73PNbN50dPzn4Pe0eMRI4lU?=
 =?us-ascii?Q?UWpApf/WuGKImhjAnNiV8IGNWHtJvVlAUk+yeZUOjyqWbaSkJwjlTLsbsXw6?=
 =?us-ascii?Q?REAyF9MlifxM5c32PI9Z5QFxmTkFQONVeLZBdXHiN5FqCvJVoUTM06Izys61?=
 =?us-ascii?Q?uF2ESb9WUui+wmS9Z5X9+cDhclmELem0f2fa2uvkuYC+viDD++nifzwiw9ty?=
 =?us-ascii?Q?rPJH/DPJG/5foYwUKfglEXkELE4PIx+8uv2tcF7taYH8ON0nQblg9NJsVImm?=
 =?us-ascii?Q?tK87Wel49y/Es/3lWEFk2wcdYj31UcwrLff9UBd5erBdnCDxz/M02H1MowUd?=
 =?us-ascii?Q?5lVM1voqmgE2rMa+IWl0nzXeogiLgV593cOjdqmGM6H0B0SC+SOYhKgLdamd?=
 =?us-ascii?Q?yj/Dv82/oQmb9OXMjVZLg5drmSRUdvBwKjg5k7JzjO7WXRoQZurzzUZ5MbIS?=
 =?us-ascii?Q?isDuUeNMHbD4rOF0AlNzmboLp6ezmhFQykz5ljErjGnEHsFCYfTBp+QJ61aL?=
 =?us-ascii?Q?hIGTg+za5jAhwdA0nsEawcXQj0WFWfWn5VTgH+3buKkn60n0Ai8BAujneyUr?=
 =?us-ascii?Q?VQkxFOhe4ekjwFQUMN5NF7uyCylPG5dxKEuTPJwaQ7vJNFchvnAnzDVnmXw1?=
 =?us-ascii?Q?GvBBBLFbvvQ4EAkO70PM7OGfrveqBJF37OHS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 01:47:36.2021 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c46d1330-e151-4eca-8acf-08dde4428852
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF84B7B0C96
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

v2: Always use AMDGPU_MES_SCHED_PIPE

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 31 ++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 24c61239b25d..ca06046c5d68 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -47,6 +47,8 @@ static int mes_v12_0_kiq_hw_fini(struct amdgpu_device *adev);
 
 #define MES_EOP_SIZE   2048
 
+#define MES12_HUNG_DB_OFFSET_ARRAY_SIZE 4
+
 static void mes_v12_0_ring_set_wptr(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -907,6 +909,32 @@ static int mes_v12_0_reset_hw_queue(struct amdgpu_mes *mes,
 			offsetof(union MESAPI__RESET, api_status));
 }
 
+static int mes_v12_0_detect_and_reset_hung_queues(struct amdgpu_mes *mes,
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
+	return mes_v12_0_submit_pkt_and_poll_completion(mes, AMDGPU_MES_SCHED_PIPE,
+			&mes_reset_queue_pkt, sizeof(mes_reset_queue_pkt),
+			offsetof(union MESAPI__RESET, api_status));
+}
+
 static const struct amdgpu_mes_funcs mes_v12_0_funcs = {
 	.add_hw_queue = mes_v12_0_add_hw_queue,
 	.remove_hw_queue = mes_v12_0_remove_hw_queue,
@@ -916,6 +944,7 @@ static const struct amdgpu_mes_funcs mes_v12_0_funcs = {
 	.resume_gang = mes_v12_0_resume_gang,
 	.misc_op = mes_v12_0_misc_op,
 	.reset_hw_queue = mes_v12_0_reset_hw_queue,
+	.detect_and_reset_hung_queues = mes_v12_0_detect_and_reset_hung_queues,
 };
 
 static int mes_v12_0_allocate_ucode_buffer(struct amdgpu_device *adev,
@@ -1821,6 +1850,8 @@ static int mes_v12_0_early_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int pipe, r;
 
+	adev->mes.hung_queue_db_array_size =
+		MES12_HUNG_DB_OFFSET_ARRAY_SIZE;
 	for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
 		r = amdgpu_mes_init_microcode(adev, pipe);
 		if (r)
-- 
2.49.0

