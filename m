Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE8DC87FD2
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Aug 2025 10:00:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95D6810E406;
	Mon, 11 Aug 2025 10:00:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vxf7eYBp";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E2B110E406
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Aug 2025 10:00:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qtF4sqTiO6kMkmtNeCcy0BFPczThRpma0Lgezs8GzKZCahLkKEyG4Z+FU7RB45ZzAny/P++SOIFl0l4Q/APjwq88zPJE/00L3PLC0uT7ey8xvjUeWU7nqLbvc84a9ZY70bROJo3zd8Aj7UyL5DoD1HJkmdn23MT/mWRpUI1wi59KyKSYmH/K4Uhw5UlQZaW1z6zhlhNG8bUY/4Zxtw/zrLwyq99y/AalScnUAPS34RmzKTP3AuY+76c1EJJYwxbjU2cAN5Bd58yHpVa1kJtI+fcZcxqzamIfbkziTQlTQTvP2E4RHJt/niKwS19PUoDsqybHMedFc0e7fOA4Xws1Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qyVCWlftDAdPIDu1Gk1I0z7PgskphbcEYfA6lIxgG0=;
 b=MmJNljlpKH1eV0MTdmpFiPP7ldEFmYcCYSKJ5UOe25pe5+1RtmGi4/87N9s/aHHC4G7QbdUySTL7vvfW3olaAT6BXTVpQ4nDVTpuvO2kyd0qS4dBsWeGT7Zkbx2t/+G8XRsqSbWEED1C5G5S6FWduU273Om9Nu0Y0HVp5Dv6YWwOf45fEQ7GKGEq1LHgPgmPQTPymjucebGdlGAvjM2kSN6Rj+jidxZfLyz898I5LPe8pz/f90QHK/kstW6veYYbvagGX15zEDt9J6jUBTr5P+27t4MzRm8i12salAU3n9JWYjCTngbnDz4QLCnC6LLH31KfRN+zBK5ZxHCO6kzyhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qyVCWlftDAdPIDu1Gk1I0z7PgskphbcEYfA6lIxgG0=;
 b=Vxf7eYBpDYLE/qizHo5OvReM4sJGo7E61uNy4ArCuN53HvqAdkQ8xoR1pkF3PsZ7hEnp2zBknR4r9KsJdUyZWlHAEtrjgF5xiBTRYb6d0UVhQN0/M8qw4mF0XPu5cy7bKZDUQF92zxwGwvNQVxbKYQrgYvrakmCZNAbn5YSDc5M=
Received: from SN6PR08CA0003.namprd08.prod.outlook.com (2603:10b6:805:66::16)
 by DM6PR12MB4468.namprd12.prod.outlook.com (2603:10b6:5:2ac::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Mon, 11 Aug
 2025 10:00:14 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:805:66:cafe::83) by SN6PR08CA0003.outlook.office365.com
 (2603:10b6:805:66::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.21 via Frontend Transport; Mon,
 11 Aug 2025 10:00:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 10:00:13 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 05:00:12 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 05:00:11 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 11 Aug 2025 05:00:05 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [v8 05/11] drm/amdgpu/mes11: implement detect and reset callback
Date: Mon, 11 Aug 2025 17:56:52 +0800
Message-ID: <20250811095937.1978747-5-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250811095937.1978747-1-Jesse.Zhang@amd.com>
References: <20250811095937.1978747-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|DM6PR12MB4468:EE_
X-MS-Office365-Filtering-Correlation-Id: 17d3c9b8-7bc2-4234-368b-08ddd8bdddca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?x7X4Uz+OA4/lZJgGFjoRLLG7ryz3UnPxqPyg6iHZTxhPYab51yufCW3Gmbm+?=
 =?us-ascii?Q?zkwToVSkb1WxfDBJ+ws9LttDNzrgtarrWiKIiI6ThcjSO9sgFC93QmkoTWRp?=
 =?us-ascii?Q?VYp6ACizsDNQ7N0B/JNDX3qc4u7+52LrUROVZ7TBh9XDeeYpTcv9t5yZAFr0?=
 =?us-ascii?Q?Z4CiYXSTTUTF5Wy/LoIZIlcYXCc/D6e3MqbSaEWp0bdB+/SV1NA9qPlSG8LZ?=
 =?us-ascii?Q?wprGp3t+zHVGev7POp3rA5hp4AaqxHjVs9ssoht6rowEOkkPHMSyPZWtP6DH?=
 =?us-ascii?Q?4kTHwydnfa39Sqe4dYaaTjAyxkHyMIux2p1ggNzNxUiPVTo76MmvNkMD5QfB?=
 =?us-ascii?Q?qi13bTS1icQHfB4oJX6L/gAhFYTH0C94yxhX3XF3BUfDPVKGYf7ocslKQ0Lp?=
 =?us-ascii?Q?3iJ3tv3Ah8/6zboVtaea4gjxto547H5pt1A147EXh1WDB1HYreDoVNUBv3FY?=
 =?us-ascii?Q?9fZ4RdEkVBuCDhVmHpLmItEziCk96AJvh9JmeSjMjo0zVhYXGC+wf2jeyMqk?=
 =?us-ascii?Q?ejVdqX3nzjgfZqQwUpZkzUAP45lz9RENR3dQyZeAE5CxPZGaIP1V+t5Cl6hQ?=
 =?us-ascii?Q?0/dlVrirguhvPHgkCbU+VGqJgRmTj8cDTIqRM1F1vbW0ss59oMGA+hbQVEGh?=
 =?us-ascii?Q?XA/PXpeb0jlxgdUpLuCBtFQteUtO6SuwVx3bpvmhobc7y7Fo3Bj2XhhqXl6Y?=
 =?us-ascii?Q?vvscJb4FOs80wOuXefgs0yRRhCkPcLRSbEY0iK4nithTWPURN6wEn2zOkAsn?=
 =?us-ascii?Q?8kYclaMBuwT2uUhIBMde07WhFO70h2XTIdAr2PwCnaQwu14s0eGnjhsrgv1x?=
 =?us-ascii?Q?Ahojbz8SBE9oRdf4gg+VPzwgymjVxrcoNxYmoqf1K2PZ1oqJAR44f04NbSjR?=
 =?us-ascii?Q?kwtNxpUGlYb8V/0QiCYF0KybQt6PxZvuq4HW1mJhipXbqXgUPxdPhFs9Sh4B?=
 =?us-ascii?Q?l7Bz2l/hJPP5ScLkUGMrb3tOqDJ6FsPMAfvz/eKOzzRW/DrAzDhMPPHnPWwO?=
 =?us-ascii?Q?SW4JFwdDmh7XzYY4N+ffVD2nJ/rQwLe9IB0h3hKOMZ3u0ebB1LnEbLlB9dTy?=
 =?us-ascii?Q?hmPSVZVfP1DSs5KEsVkqOzckmDVolXZ6PpXZYZB5AL4T0P1xW/z8TEjsjxo5?=
 =?us-ascii?Q?HHAhvzhoex+uyxmN2Vru7zyYoIRsQz7tdGFN6Tx9WNxAcCcuXqZKXRAX5XAk?=
 =?us-ascii?Q?FgUcbJl5pLAhv7TizGwnqQYwWxshg4wOyGeQjL8HbJEqdEj0a3ash9dxoI/U?=
 =?us-ascii?Q?rE/Q0GdalqcyZr3v/WpSbP2+ibzSNBIx6nqKJhdGWEwPTpKQ2of4X3DGGl1F?=
 =?us-ascii?Q?Qf67d6jCdD12eK7he2yS+pgcRAMYP58PdVyoBILSGycw7cgMdDWONnTGn1QR?=
 =?us-ascii?Q?Lo2epIcdQBJf2R7bRcwPwAnjgFqWrkALyJPM/wwCIFQJOl3K/6hdXkYkubZi?=
 =?us-ascii?Q?k5RaQ4NvANdPLjB5gbu12zKrzcrZXfcJfzp62QCweXQSlCBKhzx8JBXUGNaY?=
 =?us-ascii?Q?LpX4mF7O1N3GC8MhRaNGVm1m1FiktknvTdzr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 10:00:13.7269 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d3c9b8-7bc2-4234-368b-08ddd8bdddca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4468
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

