Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31BDAC3DA49
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 14:08:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBA6A10E8C1;
	Thu, 18 Jul 2024 14:08:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Trw4txa7";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF7A510E8C1
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 14:08:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iM7KrRUnXQsnC2ntjKepKFWiCu53ixl7jAFTemnxSW9rjRwH6Efw+ENYARsR4laHnlXmaj0u1cBf7L2edpg6yZJwRUETgWm/OmLU6vOazBYKaPiAvf8gAvYliQdfbfqpAs6ZON7tGX++gwI8BIz1lSst/hlnKlS/WnPVX7hG/o3kYJN+o9/QoqS5IHYvP0LmC1iGLv4OM2k5vTKVmeyv97Q3hCN1bCqeE/UeL0YekAq8gPWz4ZwY/NdJD1WxTF5gGGvuFjPWR5sBeRBTo4arUC3O+U1bqrMyXQZ5ONYHh3dmX/E0i5rAsPH+iCPZFxZQbYeeCbTJip6XchUURXlhZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hG4Di87fxhyvp/UUpOAOVPm7LDntMGGJqcet07kamvw=;
 b=jjB98rdcENSXVXGD9Zh6W7FIUk2ShXRoCmEMUjjJ+dQGfRWf2Lq/awVfWgqU36b5iCVGgYCaWTpZecDI986ZsuwSSTztjGknRGMsUacWkLWbTaXnp0VwJ/EqMbF/7U9QhzPF1eTQNCA9EpSJIPA1yztnfTEVg+KSw9YlHPXpQblLmMLMGUyoUjn4exwXVp06E9bIyemWPMu7DbrOc5BC7Wt+9IhdHN/7DLVo7daUxx0RvrMQf6vc6oIL6Pf8CffU9wxlv/LCHzijhGKRzJ3nNtCNtdLx86cNfADNy6EwRgAIenFlmtK89JQoK+1oYzR1L0ZVN486ZXnhD9U5+xV+tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hG4Di87fxhyvp/UUpOAOVPm7LDntMGGJqcet07kamvw=;
 b=Trw4txa7fLOkGNNvGK4ja2uzbafS103ehmekOfPd2gdO9cwObh0KVF2dbnBqW49yvB2jrEZwz7aMYMQ/yCvPzVt8DzFK/W5VwoPTmDFX4iMaHgeTML/MWebrpkM9QoCDXottRuGNzNewpkICa9wKGRpgXbQd4ztLlbdlRUykgJU=
Received: from BL0PR02CA0010.namprd02.prod.outlook.com (2603:10b6:207:3c::23)
 by SJ2PR12MB9210.namprd12.prod.outlook.com (2603:10b6:a03:561::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Thu, 18 Jul
 2024 14:07:59 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:207:3c:cafe::82) by BL0PR02CA0010.outlook.office365.com
 (2603:10b6:207:3c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18 via Frontend
 Transport; Thu, 18 Jul 2024 14:07:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 14:07:59 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 09:07:54 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 06/34] drm/amdgpu/mes12: add API for user queue reset
Date: Thu, 18 Jul 2024 10:07:05 -0400
Message-ID: <20240718140733.1731004-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718140733.1731004-1-alexander.deucher@amd.com>
References: <20240718140733.1731004-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|SJ2PR12MB9210:EE_
X-MS-Office365-Filtering-Correlation-Id: fc33d1e7-1c59-4147-0d99-08dca733078d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bE3DRTr4KBPm3h03JouEjNZQwIA3t0a13l5qiGm3Ih9Lep0mycZsN7Hw4qMS?=
 =?us-ascii?Q?+owxKxB5BopgN3IO92aQwgyXokPFUPHow1ifi+fs0dT6cshX/7vcrZC6G8gZ?=
 =?us-ascii?Q?KzMIVtLtn8fwjSBoQVJ9aLfTEQE1X0HKcqtperSbw/UqNh7dTeDAESDshpN6?=
 =?us-ascii?Q?OxcNjnaoECcpizErxYphFHYtw1zD4rwR5xD88It7hRbjKpITyW/2ujOV4yii?=
 =?us-ascii?Q?h2F9THT/upK5OJ0eA4NglqOzyzUgfLOt/8heNHPHDQ2GP4azwdny2xAjAAux?=
 =?us-ascii?Q?UyWVLdt+nkYyx6+8c5s5GoSMwUzAEJ4i0DgM0kjU0qmXWhjPo3W+e77IX2Rw?=
 =?us-ascii?Q?gS8S4jGdYYIQQekATBpxt62nZWYcI9wdZ95b7hIZxkSUPcQ5DJv2iBCTm9Qj?=
 =?us-ascii?Q?EE99/aA8XlJoYUyByXivU+VbKnQofbLFQ818QiK3vQupPRcoKivhQPBZ8Kp2?=
 =?us-ascii?Q?UrW9gVo464DV+/mIXH+HhJ7pQUzx4/Zi4Vk+etexQgZLlcil4JQ93hShBo15?=
 =?us-ascii?Q?SLanq6BttjTAydZ0i9MbNnhEl8WQML2OmmpzYqvHvUy3/2cNsl/Ghrckxfoq?=
 =?us-ascii?Q?6qL9HdqhT/e7QmYX9iI31uovrSxdWEyOXSQ7PCg5Th7kVf38OBOWG253G1Ce?=
 =?us-ascii?Q?dlg8RqGY1fbV7o4gGwFhhnouFRn7D9khj4IGNxq3rM222TbHFfdyUi5MCQl6?=
 =?us-ascii?Q?nv/0S0glT6DOYhxKkNraXfvKUP4c89I/IiefXmuERSrtFhPxspPhwDuteWOk?=
 =?us-ascii?Q?n5YLrhUmMNj6JyLucLlCP6aq4U76kgTqNOVgF0np1I3XSuwzmdQoE741qsoy?=
 =?us-ascii?Q?VUZXnunZlaT05fJnSYKEQhG9Yv99RifDtEfh85sfHEkHrbuAovo5882zJFJC?=
 =?us-ascii?Q?pTRIt8+ZqisXAc1OVHm2RorGihJ9KpVCaNAxAf7C29wfflSgrXoikmEpLA4I?=
 =?us-ascii?Q?5ZjwlEYLrzg/jBcw7znQuPIKGDNkEW70O5A4d+PKpfGrD14M4uE7fjb8SVi8?=
 =?us-ascii?Q?TSxXvVcF3OPU9nYkFvgSYkhiYQKH+4c6gdzLz+VGSyy+hZkyfYmnAx0qW0I1?=
 =?us-ascii?Q?JuOt3egvWggQMbn30Sxmft2uh0iNYEjzs4InQjRRd8LcLfN+J845BAtg8HAw?=
 =?us-ascii?Q?0em/RowhCn9V5BVRrP81YNN2w14NIDaiyFzNSPMUu4BOKdZx0YbfVWmZoAzp?=
 =?us-ascii?Q?Wk2HUdbh2ck8pCYtpkhKiLcepMorm9lGpprPLlTQ4esJD0JJk6BulULXQBee?=
 =?us-ascii?Q?rDnkqFZxcIHwOKz01PYbTA88zIJf2JwPlH+u47vR6IqKI1QUsNItK5wN0g/6?=
 =?us-ascii?Q?dnKcy0ZOAxn1zy6wG6eYLCK89lWf1KWQk0tlAeVVL+MAISP7NVz9bsiwQyvi?=
 =?us-ascii?Q?HOEHNFl+U3SFSKnCxPeSbY7ij1pfM3JHDgIJli6s7vXm9wbDuderOKuA3tD5?=
 =?us-ascii?Q?sWKNjIHvM8C1RmB4DnI0HizgjzBcMGIw?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 14:07:59.0998 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc33d1e7-1c59-4147-0d99-08dca733078d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9210
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

Add API for resetting user queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 14b8c88fb0e0..aea6225df539 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -334,6 +334,26 @@ static int mes_v12_0_remove_hw_queue(struct amdgpu_mes *mes,
 			offsetof(union MESAPI__REMOVE_QUEUE, api_status));
 }
 
+static int mes_v12_0_reset_hw_queue(struct amdgpu_mes *mes,
+				    struct mes_reset_queue_input *input)
+{
+	union MESAPI__RESET mes_reset_queue_pkt;
+
+	memset(&mes_reset_queue_pkt, 0, sizeof(mes_reset_queue_pkt));
+
+	mes_reset_queue_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_reset_queue_pkt.header.opcode = MES_SCH_API_RESET;
+	mes_reset_queue_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_reset_queue_pkt.doorbell_offset = input->doorbell_offset;
+	mes_reset_queue_pkt.gang_context_addr = input->gang_context_addr;
+	/*mes_reset_queue_pkt.reset_queue_only = 1;*/
+
+	return mes_v12_0_submit_pkt_and_poll_completion(mes,
+			&mes_reset_queue_pkt, sizeof(mes_reset_queue_pkt),
+			offsetof(union MESAPI__REMOVE_QUEUE, api_status));
+}
+
 static int mes_v12_0_map_legacy_queue(struct amdgpu_mes *mes,
 				      struct mes_map_legacy_queue_input *input)
 {
@@ -675,6 +695,7 @@ static const struct amdgpu_mes_funcs mes_v12_0_funcs = {
 	.resume_gang = mes_v12_0_resume_gang,
 	.misc_op = mes_v12_0_misc_op,
 	.reset_legacy_queue = mes_v12_0_reset_legacy_queue,
+	.reset_hw_queue = mes_v12_0_reset_hw_queue,
 };
 
 static int mes_v12_0_allocate_ucode_buffer(struct amdgpu_device *adev,
-- 
2.45.2

