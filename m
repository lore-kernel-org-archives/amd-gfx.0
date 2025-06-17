Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95283C71157
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 09:23:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35E6310E592;
	Tue, 17 Jun 2025 09:23:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eFEL8wyt";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E3E610E579
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 09:23:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=db7YkknXJDenA5dA3neg9Hj3aSuY8a03xwlb4U1m3aGZ5bUAHutWpiX+l21beNydNBt0223WNOmJg3cAn2T/8lxj6Mvjy9+KZ1kAxUvQLNLvejfaXpn/sNwwKXHXMhvvDgtTc5kkUseXG9SkYGxJyFAKUnZPAppBRRcCoOY9GMehVsodFm+yaiuN2c/DdPJSYpg19I32zFEthVKZdAOme7FlCyKq+L8omSQvA5FPbC01+i/gkKpIz1L/dUKFoMoYyr9H+tFuuamzo1jlqhW3yXC9cQmbmuwW8yykIybNw2dJNtqqCkTbRv+U8bWwjUYbA5CgpcYSlBrrevXDFaCloA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2VvV7guvyKYG6yUqeTTISJIlnH1qv3invQdAJFlplJ8=;
 b=J/3EDN0c8+0gYnyxh37rwCCK8dq2AVJHVun8vqIKb7P+i1cPsNM05VuR1RRBb4+A0RVZI7uoHAb0/1kgJPln59WNfQ5vTQr6RE6gnjGVac6N7hSrpTI8n5R+AE9Bankmwl68ZE+2RIpu5qgwe0qlnh7Q0pN4L6aPbPQHD0sETRe5ZVCAuyjgiLEJNha0uahnK25r2kqaYU6Fjv0c6QPk/INJNxUNQ9vBMkJEzfrepGLhsoSo8LM0wwRRo43pkIsl/zbTtnR2IMUt0DAa8XXnrvUi2h/6VPq8srn2cLyI5ysljEN3uQsZlhd9QyLv853NW/WabX5s0giYa4dwBj1rVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2VvV7guvyKYG6yUqeTTISJIlnH1qv3invQdAJFlplJ8=;
 b=eFEL8wytwN9Fe276mCOPaEngnT0QwZzNzP9c6zJxbdbgiGzNYI04ccQPzCJlkF+z4UCPsNOxYY4+G108tKrUDwAvPuuzv39tZ063N0uru2xhRvke9xQyJvMnh+sh0Ye2X9c6ik3n23CDCKpaMleIIhcmv3FW9w33efko2inigpg=
Received: from BYAPR11CA0099.namprd11.prod.outlook.com (2603:10b6:a03:f4::40)
 by BL3PR12MB6524.namprd12.prod.outlook.com (2603:10b6:208:38c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 09:23:10 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:f4:cafe::90) by BYAPR11CA0099.outlook.office365.com
 (2603:10b6:a03:f4::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Tue,
 17 Jun 2025 09:23:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 09:23:08 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Jun
 2025 04:23:03 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Jun
 2025 04:23:03 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 17 Jun 2025 04:22:57 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [v3 3/9] drm/amdgpu/mes11: implement detect and reset callback
Date: Tue, 17 Jun 2025 17:20:15 +0800
Message-ID: <20250617092243.2769580-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617092243.2769580-1-Jesse.Zhang@amd.com>
References: <20250617092243.2769580-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|BL3PR12MB6524:EE_
X-MS-Office365-Filtering-Correlation-Id: 89e8707a-4d05-4de5-eaf4-08ddad8092fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dijdBTXl+WorUimDuHObP7cuArPvDs57zN0hH+LcNKf4A/1TV9ZPj9ul8x2g?=
 =?us-ascii?Q?IRDYs0RFFX3C+EvtmeOI8bVys0SChdSSoYTMvJqzK1vOPaZLtCW7GOyaOrhy?=
 =?us-ascii?Q?+419eyKyEkTklWpvn58K2u+cwfRV3GSkZldKInjohrmKnKEbGrE+OQQHQz6L?=
 =?us-ascii?Q?vYSedoiz1bbIU6x6Dx8tvX5EwkYb6v5JofTH18lrY+QI/yBVYx9EDM6In32v?=
 =?us-ascii?Q?CxG9WwpQRfB2rat83uVmS2k72GIa26Yshzt5TS6yyGDVT3ONG/MtDrXSASmx?=
 =?us-ascii?Q?GayROeWuli3uG0L6Kby7HEA6lPUmKQnYuzNgZJiHWWuZVkLwipeTGOC3ZCSS?=
 =?us-ascii?Q?/y2XT4SLdihrJajTLiyH6uGntQHWU5vpxXhYlSbDhxxqsTrMbSKlQj0tNnn0?=
 =?us-ascii?Q?zO3O4Mm4n/T73+yU/RnwvLTFFx4IPG+okVZPuWF6Z63LJMYaEbFmKixDix+z?=
 =?us-ascii?Q?0TA+P1uoL9NFL+3Bqm9+SXapguUUk+UR3vhukUImikeVKPE3DmoT5fHXqN2c?=
 =?us-ascii?Q?cnq5wr+FG+259HZG4so8OtSNDX51wkLJgoBBSlzN+QU7N8CNop7KOJtJQcw/?=
 =?us-ascii?Q?ztrjfiWjSAm6PLODNl3Bx6oMEIEpMC5SXIAuNgTfYf7wwgtM0Y8vXkkwnl1G?=
 =?us-ascii?Q?wlpruQI581KTYLdwHcXNhQxps6dO1BjSWMgYds1hJ51qHPs/oFKahTFlP23y?=
 =?us-ascii?Q?mUraAJ8kJL1jwaeNKRItiEF63TLr095c75QAeIqV9wiw6QsxyaRtl5YGcbqL?=
 =?us-ascii?Q?ZYLienIwm2jK9NC7GHRDGUQuGYim35+Tp21Ll6m3/C2z+MqODtfwxkjMGUWz?=
 =?us-ascii?Q?HiPyiLBn9Qa/CAnXrMlJ9HknpIQgaaSoFwCZHWE/qUtPdpgpjmI/E/u1qKz6?=
 =?us-ascii?Q?GHtbZzwYPv47btQR9suC3YSCi0mSXqYL26Ivha2UTuyL6KbW8ICehPb9dWJ9?=
 =?us-ascii?Q?Hv312THuBc7BDt6hvtCOCRX5tHIR9LX0i7qTGGOMk8JDj9swVpKLPFJBp3P5?=
 =?us-ascii?Q?HRbjv8p5a28zCZjmnXEUyo0nlrpqgxZBry7hXeQx8OFM/z2LcVlezB4omKsZ?=
 =?us-ascii?Q?iXx/VJzO4TO8hEaUPxQIaYE2ZSdmHxhEcy9vv/phCqS8b/2uwx2D/ivRThLl?=
 =?us-ascii?Q?fSh28ZfJxMpDxt1QBKQvwSUPdWOudQXqTCrd0gYo2FmPovPMBZ7EwMw3OdtH?=
 =?us-ascii?Q?TwnWQijUqRMzP39+mvZDlLRolldSOcYnpXozWtdxx9DOE7A48EFdsqgQ/vff?=
 =?us-ascii?Q?+2QYgPOUN3/NylpEWFSHq1zrK9NhVF0uIA5sfr22aJXQBhpm4EGyhhMPoiXF?=
 =?us-ascii?Q?J8/1P5EkUjWl2WwhwHTQmKFMgCf0quowDQ6yAS3akvbRAXnbzMTNv7Fg2z8T?=
 =?us-ascii?Q?vptpDmEjdPhAyFMnRar3F9FEHVmEOjsNANjLxam99ktHrxw+mhnpaAYc3Mpa?=
 =?us-ascii?Q?gJXIajlFki2CpsQkXNYWdVcDRx8rBG6wiOxeMNyLIClBMLI7llRhLY2RIwLw?=
 =?us-ascii?Q?DQj0kBYYy9oDrVC9UTnw9iVi5JQ7Cs4rL/aj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 09:23:08.8709 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e8707a-4d05-4de5-eaf4-08ddad8092fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6524
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

