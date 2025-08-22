Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE57ACA0EEB
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Aug 2025 08:55:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74E9F10EAA2;
	Fri, 22 Aug 2025 08:55:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hFOpPAG+";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C37D10EAA0
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Aug 2025 08:55:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AefvoyNqBG/XPQn4iQ/DPYfNXFYZlN7gN9WzoVwK1U/no5CDYZZj2j52fuexQ1eOXP2jUiKca4YyTJh+ft4kKjhtPWheeeGBx22xWTvBb0tpYzJ2VT+8pSrWwnb7wWmmZXS3YTTPfsmNPNVnroWJ14tzhCxrXMDVwUAtW5oqCaFKxCrjIJ7HufSMPrUy6apNutRw1xuRNSg24EvIJm9wHeQ7K+fDB0gp9YrotASduYwAn597yRQ/hrwEVcqZ09T/DCuOdc+6vVvgfIszZ0UulmsGLZMZL9wOs5c70KoPJj99XtHh42UdxrW/tUd/eFXQQV8xEoVpwt0KzCNk0oencQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGYlBhcFsIPeTEtvMhQcBjnoBR+5GP1Av64ziVrRl7s=;
 b=fLjv8n6RNaMlF369n3XzaSnFblkA3FewiYAetxBLsfFyeQVLyT4azhyEfgcKVWdIa5FvzjFoJDebXH4mXuljKZ/A9wAPMIeUdV1Sh7PkR3qR8o+0D29ZHrlDhCAngJmwvOtEDcCFRIr6/eOrh0gOA/XlWEBfMyG1MdkK1MIsTYBw8drXhMfIM3UwyXi4mVyUeNwLCUCGBfowWSv84d+dcdGbBaynmhhgMs7DQNfmN2jJGrxZjrmI0zKX1k5o6i+B0EKLPrHYqwhagzAUTtg9Eow8aOO34nRwXYJQ/7n2tjsUY8Dh4fXJXKfBtTcrvaqlJhZcJE6j5qQ9aebRmsYlQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGYlBhcFsIPeTEtvMhQcBjnoBR+5GP1Av64ziVrRl7s=;
 b=hFOpPAG+cHC+BYlW7u/Vz/SMQygxgsQ5IB2ZA4VrhcxjWCZtmpDkc0PGalEoXZM4+FpB7Br54LVcOe4SkG6x6h1xhtlmOyj6Ls0ezIydJBebmpQZ86eIJEtR4k/va6l9xCqg86f4R+ncO3GPgCb0Yq5gnmxGbYMSKwl9jbvthwU=
Received: from CH0PR03CA0290.namprd03.prod.outlook.com (2603:10b6:610:e6::25)
 by BN7PPF48E601ED5.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6ce) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Fri, 22 Aug
 2025 08:55:17 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::c) by CH0PR03CA0290.outlook.office365.com
 (2603:10b6:610:e6::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.17 via Frontend Transport; Fri,
 22 Aug 2025 08:55:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 08:55:16 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 03:55:15 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 03:55:15 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 22 Aug 2025 03:55:09 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [v10 06/11] drm/amdgpu/mes12: implement detect and reset callback
Date: Fri, 22 Aug 2025 16:51:09 +0800
Message-ID: <20250822085434.970798-6-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250822085434.970798-1-Jesse.Zhang@amd.com>
References: <20250822085434.970798-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|BN7PPF48E601ED5:EE_
X-MS-Office365-Filtering-Correlation-Id: c93a67c9-5b26-48c6-545b-08dde1599dae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?H35gmKOkJFvFnjy/aWv8ylUZ2BakKtOCWFRhNyBYbf3T7wmXqSvQkB35OKae?=
 =?us-ascii?Q?FhdrnrX1U2xWVcitMbJA61M26KfuvtmxqxJNOZbpF9sBbGVpHvS4Gqfq4dOc?=
 =?us-ascii?Q?bVPbHow6lK0lpOlz8L29VvL2fnK6Bx97PuezWhlf6sQifonQuh6HFHW/l3sG?=
 =?us-ascii?Q?c5gBU0ROlPNI7j6H/CEUKHKvFGC1W10t+tewNTdjCYHoEbf8PiROYB+h+oD8?=
 =?us-ascii?Q?ah+F0hkz0XAAZ+4NhR0vktTRjjdj8aFUX99xaxRuOpgp1XcVdu/kICfXPoTV?=
 =?us-ascii?Q?l7p6kCoUADKh5gUMJOhZC8Oe3VG7nQkjinxxrprQNcH/W/vim3J9tvfAn6pl?=
 =?us-ascii?Q?3Y9KOvoYP4ie0ttiNWMPcLW0orxs0tgEwtmXQSKqUh+90Dlvzejuz39V4zEr?=
 =?us-ascii?Q?p+fZpVFfGEl8UcxQKtPyKSaObyGb2h9TX9uQBZ21InG5LMYzj1q9twkqR6gH?=
 =?us-ascii?Q?h4aPCSyFHis+ovG0Qjm16LTjpbzh3cKUxBLRzsrqX9IYXoojmlcS3C8gROFY?=
 =?us-ascii?Q?3BoHoRSv/f7dOLJyk44r8GFUePlEgvmv0wS5LVwEYC42sRScrn+BEIKS4Vfy?=
 =?us-ascii?Q?FBCthpbhr/799RAEktCwJVHX95HUGdLRqa/wFoJlHAKfXWBDza8ZnJIrj96u?=
 =?us-ascii?Q?7ZMllEuHQK/kczy9gvW2pahFiqR7oavlDwL1f9/tcMSQXXwFTz50q34NB0cb?=
 =?us-ascii?Q?Jp0ynWnEGw8yUdto+YRLSqBJSPa6OKGphrKoeYny0K41+ZOE8BZD7iISKPgS?=
 =?us-ascii?Q?pzyLoOVXOO74NQ2CGoBosLtgNSUawbrMKQ3Uml/rpzlHEE7ryGfBKCQ5XcmI?=
 =?us-ascii?Q?AK+6tN1OtajD2E0Bct/k/c20sSXKKe4D0A0WeFeRnRGwxjcnlykEwJzAYmm2?=
 =?us-ascii?Q?RX6MBK45aHF2nXFLOM+esXmVJ10I9xjopZke0WhpyorFyTfhbwX/SRTrtMCu?=
 =?us-ascii?Q?7QAbk/Mj+sxQrqVw53UNsBc7EYK3Tgm5BQdrkfTTYcnkH4yrtUlGUMiuwHXG?=
 =?us-ascii?Q?YDIBPM6u4IeOcS96Wz/Nk61tkIb7wnXxIPAhrA8EcMJ4mHgrsmWO5RJm27pL?=
 =?us-ascii?Q?dzwM9GWlwo37ukr11KUT3E0rK4OPSx9uEfM6xWTqjl/uK471hDT2dVLmpUVx?=
 =?us-ascii?Q?PtXzzl4RkN4ikDkSw2VaEYcRN5jjHcdpUjMqtUhuCsmqMHLVlXxTc+Ft5Jap?=
 =?us-ascii?Q?1U7cbHkfsHdek1riRfS3zhLo3uO3319pMa/NO2XL63Sgk5hZskp+Du6yFmzl?=
 =?us-ascii?Q?vv58gdJOl2XXVt/6f1XMd25LkBQISaIq0AaozpUcWEwaLu5tllJjyC/xU0By?=
 =?us-ascii?Q?B2+qKmBQ7F52Vmz3XBlpEaLRgg36ThfPdBxQuhMWUS3vap0AydX+rp9jYgJx?=
 =?us-ascii?Q?VkSLxzsEKin90ZsxWiRG/0h7d0ojHgoN0UjFr5ozLc1qdP7X+ylu6mrK5KkY?=
 =?us-ascii?Q?YsL6fcfdjZ9P+XsmYzNtX5k3nRHiZ16i/mDsPdSszFyhIqvO19WYWC+y9BbO?=
 =?us-ascii?Q?WNQk6dbjE2SYnNXB9d160kW5dloV2zKUk+TH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 08:55:16.9727 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c93a67c9-5b26-48c6-545b-08dde1599dae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF48E601ED5
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

