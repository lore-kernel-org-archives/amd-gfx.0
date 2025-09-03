Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15FD1CA1009
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Sep 2025 08:40:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A89BB10E50B;
	Wed,  3 Sep 2025 08:40:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xjt1W9HR";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C60B010E50B
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Sep 2025 08:40:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jeX3fGzmZzeskTTthwKGt0hMiCi8/U8eFScjgtcF9JOqEmDZX3u5naoAWGT9eK551KFw+ol5F5tAMqVOTupC0zg/GZypCarHJBbm4QOvmLVh9bsJc4Pxw6P6RG96yXioGjvjKytZ28niVCyTiVi16R9aQ0dIPkXhaNa0yXULAYVWGkTQCoQR9ZcAAwCzNAquCzWrRhjuIcQm0Hs3COo7yrQyLCOqQbNvC+I8gQDZ5UphiRcj8mAj/EGzQXDrJcS5KI56I6RA3d+wMisOtlq6g+MhKFwFUf7goXasO838vm+z0z6MPkmsv6tMkZ4EDG+uBhwbjtlLgTS3QF2YnQsOpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGYlBhcFsIPeTEtvMhQcBjnoBR+5GP1Av64ziVrRl7s=;
 b=pgi841HWjb8UTfv3Uqe9faKiWhPWcmrzOKmpIOwHqeJWg0+SbtWJ2AcwJq2xYulbt76nLli0vb5YikATtNQC76ldAZju+WlpoLDjpeO/EUXU8PmAlGkWleddM8cgAyTjNWj5dud9701ciFwER4GbsSSpIc1j9cRTLVgcopu13h5k09YpbhObXIthMhtrfV9ZRqE56FtGlKTKluwmFfnlUNJ5aOL1ujoF5fIARCZY6tkTxO+IEYAGpVIDO6296LZPZP0DrSxpllDetB3mFmbOxKVaYssVneJJQ2qUVFap8lpZUAgg4lJYAMBxvnxoUyMTXC1RwZrMftk3D6tiKrWRkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGYlBhcFsIPeTEtvMhQcBjnoBR+5GP1Av64ziVrRl7s=;
 b=xjt1W9HRLZE18F2gg4WuOUwFVl4ZBJE4no9mQTjHr3vexlqswbH+q2bmGlIolQAu+qXnOtjW0HSIk3jEv7qVhJr8H+fiSOaSBVkRL28rwr0dgWqUC2YO5AZt4qOKpCqPXfkp422R9GiKIFzDoq6yV1ViESw0zGCN5WtadXepF9E=
Received: from BN9PR03CA0238.namprd03.prod.outlook.com (2603:10b6:408:f8::33)
 by CY8PR12MB7562.namprd12.prod.outlook.com (2603:10b6:930:95::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 08:39:56 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:408:f8:cafe::7c) by BN9PR03CA0238.outlook.office365.com
 (2603:10b6:408:f8::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Wed,
 3 Sep 2025 08:39:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Wed, 3 Sep 2025 08:39:55 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 03:39:55 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 03:39:55 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 3 Sep 2025 03:39:48 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [v14 06/11] drm/amdgpu/mes12: implement detect and reset callback
Date: Wed, 3 Sep 2025 16:34:24 +0800
Message-ID: <20250903083914.2604482-6-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250903083914.2604482-1-Jesse.Zhang@amd.com>
References: <20250903083914.2604482-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|CY8PR12MB7562:EE_
X-MS-Office365-Filtering-Correlation-Id: c34cd23c-a0d1-44ae-1a84-08ddeac5759c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?u3m22ocMKLb2NvZql/N/rzAkX8WCQzJMzWhKjlMeJJmxkGnwhBJhRRJ04EVP?=
 =?us-ascii?Q?2v+BS/G7R0f33GuwSpcYQZnTxTD1Pqh1DB29+3ZYWOXTLVJKyC432YQZGP66?=
 =?us-ascii?Q?Q3Qus+yDigw5lBqTEq94utSaUDuGAo7RolzC7wHh9CR7QsMdJ+97UnYt7mkG?=
 =?us-ascii?Q?/GMmGjuiOk5dlrypZvjfGHxmT1OJqfOQdbivmv0eqV7NU6cJvbUFsQ/Psr0r?=
 =?us-ascii?Q?mRvrcUN1Y6JEuC89wgISB/mVpjFBw0Hi1eRzIJELBc9oGK0BnzwwBtycNdmX?=
 =?us-ascii?Q?/1pNAngDsr6ysK+FH5i6NTyiGZOoyW1xU6REwDzeZY0I2vbLChgQjVG3RsZI?=
 =?us-ascii?Q?tb89cNzMtSAbq5q6CNzaj0jGvZR2V6gaS6Mdqv8BggzikhKaAMyO1HvfAlJN?=
 =?us-ascii?Q?b7df/r0jlSV++j1oYCA1R8nwsj0YzeUfkZ7vrxg1lYwViUpL4lWaQfMzHFF3?=
 =?us-ascii?Q?MnVj0vK7osfe9iIXlDp3S5a6Z2MDCzX4Dt+Wx6QA8x0RGez8BAv3rWDI6LPt?=
 =?us-ascii?Q?NNeMt92v9JwoQ+wz+lL4Gs2lL/xWWYfMsiCt9PzbZeguS3F5gtpB2aLA7RmS?=
 =?us-ascii?Q?ThqP7J2ACKEC/CJl1XzoL4q7vZUX4zi6zkewWODL/I5VGCxB0RQM5tkToQA4?=
 =?us-ascii?Q?njbr4+0hoC+Pe2FLQmkdBtFodm90DN3TbLA/njFHjdLOjzjUGQBODuBRNn0r?=
 =?us-ascii?Q?REOxeYnB9NDvrc7FnPEgKihgT7sy+tFZLCTTJtc/NKnTjrNj7PGAjd3JMqfR?=
 =?us-ascii?Q?2DgYCJnpBmB2rSmdBc5EJgnZr1wJKoXX7vYaVOO06eoX9pxrRoCiu/M/FZqo?=
 =?us-ascii?Q?+E6KAQ1Nth9Qul55xFOx2IqVBbcJGcE+GgNE3m0MrPGSqB7K57o6ERYz5ui9?=
 =?us-ascii?Q?aNOq5x2nhPiNniWR7qpalKRLO9Mdoe8mKRVjoom8qXdtCkHRKE3pMpXJEbqZ?=
 =?us-ascii?Q?Y/6jELgkpse34kA1fYdV3G6JW0i6g7N8jG5qGBrQmCitiYB90GwVW6voHxMa?=
 =?us-ascii?Q?zdlXu6+bfY8q79IVfZkV7Ixf2p7xV/TV0Smv7270WsSrxfIpXCJJadaJvAaq?=
 =?us-ascii?Q?lb2YAzpnjCVBNkpbq4hNPNXuUL6cWuQtoh0xgzO+ddP4pACh+voKdco3mD2O?=
 =?us-ascii?Q?BXY6WW1zTsFveFpc4h51r4NwzRmzLvySMMU5wz/oyooFPBPcI5CiQBv5PD0I?=
 =?us-ascii?Q?Lb1y+0TRAboxyfK0xUG1farUqqwkcVyvCLK31RZLQueDP7MxkrZxCkRmAncd?=
 =?us-ascii?Q?s6ddj09BGZ9+AR+wn5n4zw7s0aSIUXyXfw/3BNwpJAphD2kSQlKjPM80kfgt?=
 =?us-ascii?Q?gw+9kndJHnSdt0E4fAR0z3hfyUWH3eaG2nIOTxYBBQDCGiQQCIsw43RbgEzI?=
 =?us-ascii?Q?12XmVxfNnOI/1hg1f4mNY7X02jLRfL65PgYZ1Fn0uAT1onWrwoekdB5uKrM8?=
 =?us-ascii?Q?fvOwXVuVDV2qeoJPdOwz7+gC01k22KDkcPp3a3dhd4Fov4apm3bIoy2YyL2J?=
 =?us-ascii?Q?4PS2WGqUQJ1KJCcZOoxaywY2ibzLV6Bh+LoV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 08:39:55.8659 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c34cd23c-a0d1-44ae-1a84-08ddeac5759c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7562
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

