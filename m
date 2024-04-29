Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 841CCC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 15:13:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB418112D17;
	Mon, 29 Apr 2024 15:13:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gBIVmjIf";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2046.outbound.protection.outlook.com [40.107.212.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A4AB112D20
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 15:12:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q7vWmvEWbQQvgBmaof1PriO491a2dlVGw4p1j9mnIyKzpppmqfEOtS1LSQ78YqiVr7AcAT9Sgb6RWez/FuyRz1LtytTwEF7MZCOS9lIoVDt5St5VYSYNla0xiQusqsGL4QsoF6xyd6T2j2mAwQrUbAkHjzYw2gbwcBy2cpOqmst3aGWQakpZr1vQXbeSMyxPZCLrq1k6b0fNk2qkb3VCK6jnEeYT+OypquVYuz+juzIdDNFD0WsBkW3VTRSO5i7Fo6EMQ7103A3NIiIR9+hlWyhGQxCdtt9Agpv/GvP/HjgaEFgLBpRptfXIRP8LX0zuBoxjPAMVr2xq8FlxOnifAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWJDwUoUAGWCC8Wpa/cY5m4CGo/YOiPUezD4MmteOCk=;
 b=cCRfM7RFTmpCRQOtRHWQIXViWuFn+4TcerAy5sh2o5j+4ny9PY6g1PMETfFxIj+hch85/WYlGShjG7LSurWCswod+SNHiPpGSCyiWTmB2RzzOkamj0mxTFmXMLwm1sWrgEOuL2xxPS2ryM4WdznVUWpoS2MxA7M+gDbYNcyccfH5ERPbIr8QU4chpfTGsmc0pXExpmVQTFrHa2mOZ1orHoLCxiDaq712RuJf1MIZ/EOwE9XdhQt5IvY9NFn5tio5PaKjr88tkyl2ewyxDjJyqcoigmZejfKXCKRcJ8j/UjTBWCbhH2/Kq8zD6jOPbwbkee/l8U4rkkQu+uu0nDPO6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWJDwUoUAGWCC8Wpa/cY5m4CGo/YOiPUezD4MmteOCk=;
 b=gBIVmjIfpvzMQplsLoGHhoY0otPZketMkPBjYeZOAIzAa8CiJgOVnhxEJvkWaN/mOXL4++9/nKywDEi0Ih4LifmAYS6+9qgLvohoQI/wfotlFgL/mZqHGtGzFREUfwXV2t+uzSEZh9dMsshyLPKDNLIcokuOZgOPvoA7Oem6IqQ=
Received: from BLAPR03CA0135.namprd03.prod.outlook.com (2603:10b6:208:32e::20)
 by IA0PR12MB8086.namprd12.prod.outlook.com (2603:10b6:208:403::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 15:12:40 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:208:32e:cafe::33) by BLAPR03CA0135.outlook.office365.com
 (2603:10b6:208:32e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34 via Frontend
 Transport; Mon, 29 Apr 2024 15:12:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 15:12:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 10:12:36 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jack Xiao <Jack.Xiao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 04/11] drm/amdgpu/mes12: add mes mapping legacy queue support
Date: Mon, 29 Apr 2024 11:12:12 -0400
Message-ID: <20240429151219.3466531-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429151219.3466531-1-alexander.deucher@amd.com>
References: <20240429151219.3466531-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|IA0PR12MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: f280c4b5-f4f5-482b-b85c-08dc685ecf97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|82310400014|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Yiyh7a0m4HkBbaE+HScfxuA3GlGGJD20f4BKkszgWw+wbAYA26ziAh17/6mu?=
 =?us-ascii?Q?dd8XBVaZW9eL/FZfhyxcmHcjRM8/ec7lsw+o5LHv4xD2lMmsYwqYuQPgE1l8?=
 =?us-ascii?Q?MNZl3vUWUHz6JyM6WhA+tecUifPBktM0M3IiLY0E65mK5q1EEyhsfizbR41f?=
 =?us-ascii?Q?Y/63jo+K6WG69dXR7fYpFHJo7DjBhJOntuAYpbtnPnZY4dQghMrZm2pFxk56?=
 =?us-ascii?Q?LwxFUO3tKr4DYfagFlspXYhQzuz9vw1ICGnv1zIDaXVtREHGljnO1yPIvsgT?=
 =?us-ascii?Q?qKX1PC3r2KS28NDja/FggS6SEixwU+pdP8Ce7/WgsXpYpB/uijxTfe7p1HQk?=
 =?us-ascii?Q?4U0FHPrnN0Lu2/fwOfjRsyXfT+Dz8lOypWPzYFM2HnvhqwoVRJAwbICOyXPW?=
 =?us-ascii?Q?n86HyM38Dvjosq1rMhm/WQc2MvTbaVUdo2e9TlOYW2SPKdl/W0JYDsINxFOT?=
 =?us-ascii?Q?eB4z7vvEymG7xVp3gXq/qgfc1TL8QhjSQd3lyJI17Z/IqZHVE0uFzEWOxiOH?=
 =?us-ascii?Q?CMHrR/vi8N1wNKVhYBUhXBfzJ1FacjXcCR8aGeKgLbWjFDPBGqQeGb/n59Oz?=
 =?us-ascii?Q?C1v6fhlNPIEus3TBe1wLZYf56gAP980y/Yhyv75rHgs/paqdI9XUOj63fZ5j?=
 =?us-ascii?Q?VRyKVvtpHZ0ueTlxRCu1iXnWehzeQ83Y6E3+jWBSJZs6Wj/ajA1mMWz528yO?=
 =?us-ascii?Q?h3w/DuHWZoFwFs+XwoMlGfkQ1RX3gotGO58H5vmHvVVRhn9qqVypEYw8NQ3Z?=
 =?us-ascii?Q?WWPHiw1ZyztrmOdhA5s3a1WcjzwFwqCm0SAapHmKzte4ptnByxAPIJ3kuy1B?=
 =?us-ascii?Q?VWDAqfI07762EGhtb/2LxuYBQV98BAxPr5Eluy0t9CCT0k16fKWgxiXNttv1?=
 =?us-ascii?Q?eoCHre/nu4jtljdtYZYvNe09q1e/JcqJiFvwo4FWs5P+Sj+ECq3KR3QAvn0r?=
 =?us-ascii?Q?U/kD+lOU0ThQ+3S+WbSQTBGBkEAXDlv9liDdHxS0tc+xJ67MjufrO5YSE0no?=
 =?us-ascii?Q?N+mFL6qmkIDZrmDVF253zbcVvVmz8eYnnYc+uh+HPpYp92vxQtJd9uz+8ohr?=
 =?us-ascii?Q?uUsWKG+vDN6GlSoz6oPtXzXUC4IVM3WyNL2TRqP7lnlmKCoJ1HnQv7hGeMQ6?=
 =?us-ascii?Q?WiUaVHVZNNsKgZnEja7VG3oMAVsMyPdnxFKi8vank0iOtguvCH2XjUazEdhi?=
 =?us-ascii?Q?PQfarXtJUhKDyrbY7MNFcYVJ2UWBI4ygzBdRdyNTHRciPsYjImIbVwQRUk2s?=
 =?us-ascii?Q?3o7fnnUjp8tUWyfu91DtUBInXkxQlyaql3j+SV0OCh+9VAZ1C3Gch8YF2arm?=
 =?us-ascii?Q?iJUfzKBBJ9X8dditLdFJSapoaZp43Njge8Q+SkYqW8HIQTcBODnq3Z6G1vtU?=
 =?us-ascii?Q?FNxMf0soBtFIsO24aE1DuXaUTaPa?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 15:12:39.6465 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f280c4b5-f4f5-482b-b85c-08dc685ecf97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8086
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

From: Jack Xiao <Jack.Xiao@amd.com>

Add mes12 map legacy queue packet submission.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index b60ed178114e9..132868b8db198 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -230,6 +230,31 @@ static int mes_v12_0_remove_hw_queue(struct amdgpu_mes *mes,
 			offsetof(union MESAPI__REMOVE_QUEUE, api_status));
 }
 
+static int mes_v12_0_map_legacy_queue(struct amdgpu_mes *mes,
+				      struct mes_map_legacy_queue_input *input)
+{
+	union MESAPI__ADD_QUEUE mes_add_queue_pkt;
+
+	memset(&mes_add_queue_pkt, 0, sizeof(mes_add_queue_pkt));
+
+	mes_add_queue_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_add_queue_pkt.header.opcode = MES_SCH_API_ADD_QUEUE;
+	mes_add_queue_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_add_queue_pkt.pipe_id = input->pipe_id;
+	mes_add_queue_pkt.queue_id = input->queue_id;
+	mes_add_queue_pkt.doorbell_offset = input->doorbell_offset;
+	mes_add_queue_pkt.mqd_addr = input->mqd_addr;
+	mes_add_queue_pkt.wptr_addr = input->wptr_addr;
+	mes_add_queue_pkt.queue_type =
+		convert_to_mes_queue_type(input->queue_type);
+	mes_add_queue_pkt.map_legacy_kq = 1;
+
+	return mes_v12_0_submit_pkt_and_poll_completion(mes,
+			&mes_add_queue_pkt, sizeof(mes_add_queue_pkt),
+			offsetof(union MESAPI__ADD_QUEUE, api_status));
+}
+
 static int mes_v12_0_unmap_legacy_queue(struct amdgpu_mes *mes,
 			struct mes_unmap_legacy_queue_input *input)
 {
@@ -493,6 +518,7 @@ static void mes_v12_0_enable_unmapped_doorbell_handling(
 static const struct amdgpu_mes_funcs mes_v12_0_funcs = {
 	.add_hw_queue = mes_v12_0_add_hw_queue,
 	.remove_hw_queue = mes_v12_0_remove_hw_queue,
+	.map_legacy_queue = mes_v12_0_map_legacy_queue,
 	.unmap_legacy_queue = mes_v12_0_unmap_legacy_queue,
 	.suspend_gang = mes_v12_0_suspend_gang,
 	.resume_gang = mes_v12_0_resume_gang,
-- 
2.44.0

