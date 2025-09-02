Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8652FCA0FFE
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 08:08:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 331F410E5CA;
	Tue,  2 Sep 2025 08:08:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bE3UG7UT";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA34310E5CA
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 08:07:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kpsC8gcyDUuiaFM9KewlnWA793V6KkZaynwxnze04TJ1jgyVFNewsYHM2KSGSXg7XBWdSzgg7dvFpZ9akMyaUmAKwksNM2OlUBTW3Nt4z3G0uhm1YA/lWFL/h17+UfDa3rTUJpi3WpJVSaKnsVNZxjaRJzAX0rwc5R3Q8xxY6QET/Jfn9/INlZrxp7iocXXsKI6xnqslcPJXLnqJDoSV5usVT8h1IdSQxhIBH/va8EgDpWCdlP9p/seMVBA3NiBhpl7eLAc/E6MNM7MaEehjJNczsr7BBoaMK8klhXHSGvMfKLOB4CHLyrEde19fy+oXDkGjavwK0z6M8Cbej/C/ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGYlBhcFsIPeTEtvMhQcBjnoBR+5GP1Av64ziVrRl7s=;
 b=ZEREcqt2qFwhqwdKbW+qp4UpSaHuLfWn4DETY6ktFLB8NohkoqdPjiYCltOutE1bK1lqbUYml4rhHunqRqdz85TMSfg+cHdWtMWtgwc1I20t0sKp7nWFig55qPZRinhlI5iNQ03WkGLf8IrlYqcV3vuLo3q7mczP/9IRti7IDLdiwrMPcSdzKN4Lt+OeQ+93H5sXt7LxYhIrNz4rAjFBzmWxvxdHiy89M9biFl6qLnEIVHyoktHuyCA9Pr3Xi+LJ6NWbfjfRDJZoXCxyfcQWumdwv+zmdvWSpmS0/9qD1LOhINpCilCEqmcBEBoC0S83VVskXWC9SJpn/Naa5l2xnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGYlBhcFsIPeTEtvMhQcBjnoBR+5GP1Av64ziVrRl7s=;
 b=bE3UG7UT9m+yo7m+uoVXIb2JSaGBlLYLONhip0CUL/MwrLRchzld+pngc8rv4tmn/T8OrDocb9EWA5SgE5Rp8vodIhVu1ui/KcBjVCY35IhaDd13GvP1w7ZC74sh/7WrfTp0Z/f8xkSOOtppVLxZq83WcUswoQnnD/8H9rivLxY=
Received: from BLAPR03CA0110.namprd03.prod.outlook.com (2603:10b6:208:32a::25)
 by SN7PR12MB7023.namprd12.prod.outlook.com (2603:10b6:806:260::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.25; Tue, 2 Sep
 2025 08:07:54 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:32a:cafe::93) by BLAPR03CA0110.outlook.office365.com
 (2603:10b6:208:32a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Tue,
 2 Sep 2025 08:07:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 08:07:54 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 03:07:53 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 03:07:53 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 2 Sep 2025 03:07:47 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [v13 06/11] drm/amdgpu/mes12: implement detect and reset callback
Date: Tue, 2 Sep 2025 16:04:07 +0800
Message-ID: <20250902080712.2515811-6-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250902080712.2515811-1-Jesse.Zhang@amd.com>
References: <20250902080712.2515811-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|SN7PR12MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b953719-7898-4479-dddb-08dde9f7d1cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?s430pHc5eWBLg8HdC5jyFsRItRHi6dN/LO/m14V4/ScJ8rKGuIdV5LKMmlsc?=
 =?us-ascii?Q?tRY0TE3aXtoZ0zLu5q2AEGaS66lfslA1ifWP0j+vYZ5g1LN2LEe4MUMOPvam?=
 =?us-ascii?Q?c4I3nEto3ODHDDoq4qRxLQbJf24TeY8YuqaNRBT1UGtfz7eo4oBlDtWONxHB?=
 =?us-ascii?Q?AqGyBe85rNeVgogJLSwioNBvdLW2Po+LsaCiCkxQkGVLAXyZ82F8/sz2KthB?=
 =?us-ascii?Q?nKlFIO+qOr6i2mXKYzFWZ/VtpCJbVTEJ3bdth5/ed5L9FxxMeYtU/bkqT+DR?=
 =?us-ascii?Q?YD/eXs84L6vk2TR3titJM/LbPw9INJlNeLC/54oCcmOGNucwkS5/ZKy4FrlA?=
 =?us-ascii?Q?GaOy0ioMzeFkvYXywpLgM9wmAdO6Nv9JVGuvPryhzokOabLZIJ13cwZ5eFzL?=
 =?us-ascii?Q?BwMiw1lpLEH8jb0LFC6WmqMhBoyYU0+ydSpg36Z+b328TZCsNwm54jRjrTfG?=
 =?us-ascii?Q?GkueVdROsFqaIfHlcOyjLToYUNN4umXzPAE8XZkKC4shXqXtizbpgFvJrhLX?=
 =?us-ascii?Q?ITCFKYdZK/urk+N5W4Kd8kHse8BWWpmbIvIYD4NMPdMQwuAX5NbxmOE/73FV?=
 =?us-ascii?Q?Au/G8F/RV2zEolbq/euoCf4duX8K/M4o3gtznjcpdQ06qjpPQdmSRRRrGX3z?=
 =?us-ascii?Q?Jf8M4+2xDUGGaMmZqbpliqc4qsWA9xq0qBkz1lyflITB4w/GwrrX05avJWUm?=
 =?us-ascii?Q?6HMcu6wGqxJo/E0cfGEfusm4TR66DJgSE/49+2wh8ZpiVBtdGrvdQ86vt3qg?=
 =?us-ascii?Q?me/MAFelHvggLXi0AnixWx2bPOEUTGn3CoqQjkWGpOwEUidKLZWxOcTOI7DI?=
 =?us-ascii?Q?a//iarbXwMHuwIJvuHPoZ5QC/u5Ie7KHKhO8NNnEEP3NvKmFR3Cy3bSHy0Q9?=
 =?us-ascii?Q?Upkjhkc1zPzwthapASvWDVQViiLFCn23O+erCTUL7Rp5WXduIE6C3mDUj14K?=
 =?us-ascii?Q?LfjmROreyhj/hfxwyExGLnTrqGZJ+dY96lzxFb9WYMS07t9puxTF25nlaJTm?=
 =?us-ascii?Q?2WzQZgSe+aTTtsnUKFDjZV4HFq8h2FxTfpQqUhjdynWNpt8X70MVA7+C+KzG?=
 =?us-ascii?Q?vgY3ZfaNUzVost/U3aEMh3KSTwGLKZyG/QKonG4zCPt+d5ZV7mQ0laBCz48q?=
 =?us-ascii?Q?YD1wiUmUXgSaulRV1zRfn+CaVAczd7VywOQngvFjPXhFrj4Wlsqh1HDNfrNM?=
 =?us-ascii?Q?jjyrRrjCA1p99C1MrZbJwGJz0vt72OW4Km4BrqG7Lq/jXG5SmS4KCBnUWCD6?=
 =?us-ascii?Q?Bls/1UTCc9VK8z8FTi+N8+MFVtSg51Xuc0iDEjKEcM9NnuXaNiCbr5/5ilyz?=
 =?us-ascii?Q?iuQbxMI0I3qNF9I7stVLLIAmzj+tBi8fLyQHPKD9fsyj/NDrsqucsrnFZ2xe?=
 =?us-ascii?Q?ke7gRor3aqUaRKArsxxFIyZSqE0heQHSwArXUaQJrSIVVwLZCBb4XiBYLNbb?=
 =?us-ascii?Q?TMTxK+t227U4bGiMdLEYQlBZaHk0IAZRVNi+8mwOQMznP324W8Xx2konEdb+?=
 =?us-ascii?Q?cAjEjlF6ldzIHRfutW1F3bv3dZxc2gmpcoe9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 08:07:54.2104 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b953719-7898-4479-dddb-08dde9f7d1cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7023
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

