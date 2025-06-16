Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 001FEC71135
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 03:46:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9499B10E26D;
	Mon, 16 Jun 2025 03:46:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LsSIePzb";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2053.outbound.protection.outlook.com [40.107.102.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B55710E26D
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 03:46:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BCi8TDk8l4ZB6tbU10eI5uSMR89CRqBUOmchZwlBpG24DRUFeNqa2T+l2MNZljqjll7q6DYZ1aLhdNQDtKM5eRkePxHrFl6djbqW/8u4iZY81R0FKpXR/JXGLihctzySQLLim53gWGgAsiOzNPgRK4KFhcIQRdaKzgdmm2feakJuRUlcaFTNb/jnJX6olyk3bC1edkpZIPvuvnj1WGW9/p1n/qqgnhyS6Wocch+pmjzX3+n8qfBxlFNalfjNhj/ila0ZXesedmYteoP6cPQhUDUCqEoE1m9aXCr8dRZNV+o9m2mtBZbNPIE+o+eA9fpjskUVg6hAIsKziJVUyjkZjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2VvV7guvyKYG6yUqeTTISJIlnH1qv3invQdAJFlplJ8=;
 b=PBnPFKQgpwl0OSFUxWsZYsumGRNU0/DR3M7CtQjRr2/IajmSNThJTVYc0OPwoglOHxZQRaah2zJazyX5GaehOvx7KJ215rPMxSRBrXxi/QLkwXf2LUYYA/qTnq1qT36CBl6wz0htqX0rPB42lWDeZo+I07LNg22SOJspQS6v0XtDMz9iTwax6S7q4YqgdWTMpmfsvsc2zXq8O3EIK5yNzegNZzRqNpFRxltxHctUXZlk4Sjf3cxMxop+b1Y8KbdWNzoocRImpMjQnQxuX/kKrIqH+HbmVA+RpC/fdN4LENZOZ8oURo/JOYw1NH/V2BVtZwG9BYw+EF5BTUnyjuY8ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2VvV7guvyKYG6yUqeTTISJIlnH1qv3invQdAJFlplJ8=;
 b=LsSIePzbEYLRQXMQpcTlS0UNUKZSDAagbHzCDGyETgU1RPmO1r0wIHhmTAR0ck+FCjR5at0A9MRqq/5EskNtJUJnqLWkiW5fft50F8dy75Wo7mUteHHLP8tEAubCvuH9csYzWqnfPXpM1KjuH5fSuW9oUyGzHkO2giJLMKhFqR8=
Received: from MN0P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::25)
 by CY8PR12MB7268.namprd12.prod.outlook.com (2603:10b6:930:54::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 03:46:28 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:531:cafe::8) by MN0P222CA0019.outlook.office365.com
 (2603:10b6:208:531::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Mon,
 16 Jun 2025 03:46:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 03:46:27 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 15 Jun
 2025 22:46:26 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Sun, 15 Jun 2025 22:46:20 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [v2 3/9] drm/amdgpu/mes11: implement detect and reset callback
Date: Mon, 16 Jun 2025 11:43:36 +0800
Message-ID: <20250616034605.2683434-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250616034605.2683434-1-Jesse.Zhang@amd.com>
References: <20250616034605.2683434-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|CY8PR12MB7268:EE_
X-MS-Office365-Filtering-Correlation-Id: 4630a083-9717-4342-3b33-08ddac885f99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mtaYT+xdN8g5Ut0x84Fq6hQAancScXf3zrgimED3fgvSBvSkjTa5Bbi1eoAM?=
 =?us-ascii?Q?EU07SPzCCqsuyOtfkcHPejUNMY/8BVRtHfWhv23vW6J8eR/ppXOYpx4KqcRI?=
 =?us-ascii?Q?RSzT+tSUwsNRKZH7kNJJa0Nnr8bRaRW+1bTSnVBHdKJMfq4RXeyNacySyJ+t?=
 =?us-ascii?Q?WWvHhumVn3FrzcaUzkZoZEkAO/1TXtyilC6zwPMGwOSmhpwo6Wctj7mq5Jwc?=
 =?us-ascii?Q?GYDYxUef3vOMMtZU7ywu7NQO66M2G6+VrGdjvrABjsjvs6VKWiqMssGBJf/V?=
 =?us-ascii?Q?Bo2NVYlweVw7dyo5E3K/7JyRvzw4juRTAiPfCBAajwlkmY5+f8h9ixC5Jf0n?=
 =?us-ascii?Q?FGjRp2O1o35iE3WLaCYNecbuIluljFCCMt+IgUFNAcNFujkYSvLiTc1Arwh+?=
 =?us-ascii?Q?rvXQALTYFsYZBAlDsbNUkpO43/bHQ6zTJVKqBgFVy40v63c5PH2B6b9HDtyV?=
 =?us-ascii?Q?OkWPfexSd7wDTTKFFHDu6dgMe1lWSnV4laNDdz0PHD384NBCmNzu9LMXfNgN?=
 =?us-ascii?Q?XFiZck6Tx0vkDzgEMFJutMDanldSd/45eZMAoVSNEbjoEEbghecfJ3UDBUIV?=
 =?us-ascii?Q?CDcQiVJ/I26LekpfUh6TiMVLBqhWGtBuXbJkhiE71W2ecf4+fejumJJx6SnY?=
 =?us-ascii?Q?K9/YEyrBk/j6L0zfjituWaL9yf8dDUI7E+dkpXGf1HEzdIIQtR/3EzvG8I5P?=
 =?us-ascii?Q?m01PlnMXfKvzDEHFk1P5Kx6j3G3ul59EDh51Z+a6FJuJF0aOBMvLDeyHeepT?=
 =?us-ascii?Q?SniHUsj/4l5D9wvpIZuYshCNEst137xBNdwXTItx6+O4Q7OHjkl7c4zCPnan?=
 =?us-ascii?Q?ohz35YbCnCPdnUl2DAhzT43aG6KrKb+aUlXw1qrI0NHxqnKjLZRgxhAjKxM8?=
 =?us-ascii?Q?XQWedSBdlP7K90VtsZW4uLIwVyPuAIuCPqfU4bjD2JssQJKzCfA546/Pbg4c?=
 =?us-ascii?Q?CD3diBzRai1okJtH3qmOKLqbJmdQXd1vG+ZhYlyUSqKxwWfvo3nMJkWinhlE?=
 =?us-ascii?Q?3gqbqHVHTv9QLHJgdddVPpPNLWvCWBt/C/NZwbug4n/Uey3HEMZnfuHiNZDx?=
 =?us-ascii?Q?DMXHauJXhh5tcH/oauCZNtgbsqpDruaPIu6xcppmXhAOcfQ3L0UcQtbzbt8j?=
 =?us-ascii?Q?DpYY36SDfLdc+/cLc4oWFmzZK7jSpePaqkFRLugSG79OXo1AeMlilTJL3MFC?=
 =?us-ascii?Q?oH+EdXTawTVLvuvBB7ozWdA54cRunZ0gpspZyNQJi2vsP86avArEV6w4vxk+?=
 =?us-ascii?Q?pthO3pYbmjTF1srOgQbS3pfGkHQlrEMJgHt/uFdoVA3cFxGl/p5S+Lh+F62M?=
 =?us-ascii?Q?B+mLd0C0nLuhr1ZYsIRpIm1PLyxSVZAD/D7qIweZaJg+j7EpUn8Rkg6Aol+R?=
 =?us-ascii?Q?ttGvzQIVMWJGtMKN4BG9TkYj2Gs07pSd78e6iA2WtFDKNyht1iPjMmseOPlG?=
 =?us-ascii?Q?6Eeie38cVh/sYWM5dlegBDRGSOSTTcGnhWKzHq2QfxETmCbttZW94sB94O2K?=
 =?us-ascii?Q?YdFL6ExcI+SDTqGCFiN0HhRb34d2PfUrMBGq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 03:46:27.5443 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4630a083-9717-4342-3b33-08ddac885f99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7268
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
index c9eba537de09..cded31da3f31 100644
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
@@ -1682,6 +1711,8 @@ static int mes_v11_0_early_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int pipe, r;
 
+	adev->mes.hung_queue_db_array_size =
+		MES11_HUNG_DB_OFFSET_ARRAY_SIZE;
 	for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
 		if (!adev->enable_mes_kiq && pipe == AMDGPU_MES_KIQ_PIPE)
 			continue;
-- 
2.49.0

