Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC7AC6FA82
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 18:02:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2665810E002;
	Thu, 22 Sep 2022 18:02:38 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 284AF10E002
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 18:02:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCnHVD0bItN5k7vmKq8UoNkXEYeULCtavDE9zi3TQurCmb2Xgg+gzFzREJH4953GUgtOihoS3h9vj2Uij6VGMF8D6VPIysxSlKl5kW/M5JFpS0uyzbb9V9R3SLj9NVVeMCrTvCFd2jyZaU/47yXEHODUozMwue9eBf8xyq2Wd7b2rp64iyONSwKCHcWxlOfbKi2lNfyxs54JdWoh19K6TByH+hIW3Tn2RtzgiMHcPgjOEywofgKUKXlazy5qnRIaFMxzl/cIND7kir2hQW9+XmnwjgPTtWuBMvj2JPIsHZwY9TWS32Z/S7m6A1vHZn90h7j5n04DCVvCLb7wQTYvyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lS3UKQeYEVpo+Btou7fyE360tAJ/BAOlx2aJyU6MV3I=;
 b=FAlFYt7xbIVzsnzJ61EjfterJt0Arv/Rk4IHXz2vGBBurU7euG6fb6LPvGpdTtlcp9PoiY/gVf9Z7JoT2TXd+81SHXhjGvdhCNXmLZh4o7MRU17dsiBOja5UhTGLIZ8Sjk34nXVQ3ebRCh8Edwkwm8kqUeGZRepUSq8jMxGAblGfbWC269bOwwruP0m7A81kyyUQbObXZtiMUf6NiF3K0JW7kJRmUkDez5RX7Ae4ez/JtcDFUm1eIhhyLkBbN04aSjyEqLFlT36H5WSR8kopmTqxUhCa/L1kWUsVjSJU2+EXPvCLG7Umx4bdTlntllgBDDWf6yb32mYN0ZsdUlw3+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lS3UKQeYEVpo+Btou7fyE360tAJ/BAOlx2aJyU6MV3I=;
 b=Ea3zJi6FYwTklV9vxD3GVRhsQ0KonXufeN2VXQ0I8pIb3PUnzwW2Gzl2re5HDdYl5zegp21q3f0vFgYgjduyxPjVlKt8/T/SuZ0Nz5JSg8YXxNd35yRnF444Iewwflf/xVGlNHRRN4Rq6Cxbl4ApWeJ1FWBbrvXcVtcUY6KzaIw=
Received: from DM6PR02CA0094.namprd02.prod.outlook.com (2603:10b6:5:1f4::35)
 by CY5PR12MB6058.namprd12.prod.outlook.com (2603:10b6:930:2d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Thu, 22 Sep
 2022 18:02:31 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::98) by DM6PR02CA0094.outlook.office365.com
 (2603:10b6:5:1f4::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18 via Frontend
 Transport; Thu, 22 Sep 2022 18:02:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Thu, 22 Sep 2022 18:02:31 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 22 Sep
 2022 13:02:30 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: pass queue size and is_aql_queue to MES
Date: Thu, 22 Sep 2022 14:02:19 -0400
Message-ID: <20220922180219.814212-1-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT016:EE_|CY5PR12MB6058:EE_
X-MS-Office365-Filtering-Correlation-Id: e91e0c09-260a-4df1-72a6-08da9cc49e81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pEuboWLPi4zaC4ETArRqCxf92Fz+BYzO19TvDF/W0w2KtnKt49Mr8tMl+iM+QCYBEdJ38PxcDeka8yrtYRIWDP14VgTZ0HHBZe7GCjGBfAUKWO8lrcol3Slp/DyKBOxo0hdB/YV1ZgJu7Pr54xTBqZHXM3VpY4BkMwfrYkTvdzdSijoFp/idv9UcD5B5QyPGSznXKPVHPSd1MM9ADx7t3pi2vvJcCB5NJ0YamKTfSpQaCBJrnFf3c19jzq4aSOCSYaSFGg8ZonxLdFK1S04y+0pKswhiyQnmpjJKEJsD3VzCWk9OMrZ3KU9gLEtJmy9mFx+tcPmMyQc/7EDSR7CGQAwzluzNBTNHcJlhfTQguDXJQii8RwOt0PCRO4adSgCKKHYd2dwfcyjVnZLAm6w041YqBuSE+/7F/C1F+OxP7v8dUAVcIxUe6QXJQQU0chrog4bj911OLqRSl8sLwJ7xrXs1YHW451q5VPQRxIFwHAxROBDxFhAPf4R9V2tRha9zr4kq/CdZUp5CQkMqJPcQ54r5niciCwwTuTfSK+Phb8OCT3kyVRo1Co84dQAXZ6b8R1VafzuPBQ4wpracIA2npImhokjT2wr2CTlEF7n0RIVsdgVbRdmpWs8p+L8gUt5txkkxhiJTzj8LLZ1ZBQu2q/lc3bpvl775kjMo3pClyujIpi0WomqpWjv7R7ehw4eJsTmoRKnLoVO8xYc49kTcneQSmMgnVOXyO+11Jbo44rzQ99CxOLIBemnhQ9uyHSUpEAETP68lsbCUQCypoT5PJf6eZ+1qbg00NYMeV7pfyv0TvTcRrMW2Ignip6CLUnmw
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199015)(46966006)(36840700001)(40470700004)(336012)(16526019)(47076005)(2616005)(8936002)(426003)(186003)(7696005)(6666004)(40460700003)(1076003)(36860700001)(26005)(5660300002)(83380400001)(2906002)(70206006)(478600001)(82310400005)(6916009)(54906003)(8676002)(41300700001)(70586007)(4326008)(40480700001)(316002)(81166007)(36756003)(356005)(86362001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 18:02:31.2059 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e91e0c09-260a-4df1-72a6-08da9cc49e81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6058
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
Cc: Felix.Kuehling@amd.com, Graham Sider <Graham.Sider@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update mes_v11_api_def.h add_queue API with is_aql_queue parameter. Also
re-use gds_size for the queue size (unused for KFD). MES requires the
queue size in order to compute the actual wptr offset within the queue
RB since it increases monotonically for AQL queues.

v2: Make is_aql_queue assign clearer

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h               | 2 ++
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c                | 4 ++++
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 2 ++
 drivers/gpu/drm/amd/include/mes_v11_api_def.h         | 3 ++-
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 7b46f6bf4187..ad980f4b66e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -222,6 +222,8 @@ struct mes_add_queue_input {
 	uint64_t	tba_addr;
 	uint64_t	tma_addr;
 	uint32_t	is_kfd_process;
+	uint32_t	is_aql_queue;
+	uint32_t	queue_size;
 };
 
 struct mes_remove_queue_input {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index b64cd46a159a..5581e03fc956 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -187,6 +187,10 @@ static int mes_v11_0_add_hw_queue(struct amdgpu_mes *mes,
 	mes_add_queue_pkt.is_kfd_process = input->is_kfd_process;
 	mes_add_queue_pkt.trap_en = 1;
 
+	/* For KFD, gds_size is re-used for queue size (needed in MES for AQL queues) */
+	mes_add_queue_pkt.is_aql_queue = input->is_aql_queue;
+	mes_add_queue_pkt.gds_size = input->queue_size;
+
 	return mes_v11_0_submit_pkt_and_poll_completion(mes,
 			&mes_add_queue_pkt, sizeof(mes_add_queue_pkt),
 			offsetof(union MESAPI__ADD_QUEUE, api_status));
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index e83725a28106..007a3db69df1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -205,6 +205,8 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	}
 
 	queue_input.is_kfd_process = 1;
+	queue_input.is_aql_queue = (q->properties.format == KFD_QUEUE_FORMAT_AQL);
+	queue_input.queue_size = q->properties.queue_size >> 2;
 
 	queue_input.paging = false;
 	queue_input.tba_addr = qpd->tba_addr;
diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
index 50bfa513cb35..7e85cdc5bd34 100644
--- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
@@ -269,7 +269,8 @@ union MESAPI__ADD_QUEUE {
 			uint32_t map_kiq_utility_queue  : 1;
 			uint32_t is_kfd_process		: 1;
 			uint32_t trap_en		: 1;
-			uint32_t reserved		: 21;
+			uint32_t is_aql_queue		: 1;
+			uint32_t reserved		: 20;
 		};
 		struct MES_API_STATUS		api_status;
 		uint64_t                        tma_addr;
-- 
2.25.1

