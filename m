Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 199EDC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jun 2022 15:38:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AB13113563;
	Wed, 22 Jun 2022 15:38:04 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2081.outbound.protection.outlook.com [40.107.100.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D70B113563
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jun 2022 15:38:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jp4SEq5DdXWtDtKs/LOCcqP3wFImGkYfrZcH/hzPPK3yq1sTti26rSg5ibJEZBNKtyN8VA91UyRe1VmETfTUrbyNKFM1U5SITud5aiH6+WfB4Bnch9GWnTPQ+nQgKd+1KQ8n4iJL4EpmwBOOmKOHpoPq7aT62IlEI4I1v99RKHOxpXErif34ESQNtMAnGFRfRadiZxm2og+m0jXzPTnc1kL5VUK8h/BkHDTJAnUQLeg9/50wmGwk2Cqit7nza9qfR1oKStHJ16pa6VmoQCKOobyLj9UbICSK2cLyzx/JVU2K+F0TAVWPcqJfNHgUn2nQBbniscGF1C/Qn2IMtL9FTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kpQ44/Pc41xcgSGi3sZ0Wbot90sgq6gVcgTsPUOs1b0=;
 b=YFIAjsl4lEDs3YPOq//ekUWnr0Jp9E+3P4++fuKA1qHA0VUi4QCgJaqUuWzxZ/oYJBhrJtWer5YK61DAOwAPMBA/+u+T4ZV15nCqXQI4cLFRNVN+zYmqJRpV4y5kRydhv+EEJS7anv4wS6YaHELcZ8BlP+EDYSjDJgI3l9hqldxXal6uItI16sMuTN6xPziYrBGLiZrt4Iszc6bhdfLeJ6/zMJROcbBAtNZ4zfOlBXMBn3ZSkyu9O3Z+L5XNpATR2SR/Ecxmx5Qb+DyLYyiNLzZaCEyMGz5pQhU9BngHfG0bc7jK6HiTXqhSHjp10ztpb122nJNYDtbQ+4qP3rBkBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpQ44/Pc41xcgSGi3sZ0Wbot90sgq6gVcgTsPUOs1b0=;
 b=tGIbxswmrVPZFithmU9BqF/PJ64xPhIPTQqae7MYu/S4gg4pK4ASunrNKSRvGFEjm8Qmb0GnKUQUUYWFbnw8UHB5BCqt14bLDw9YkYwxjV3xayIotK2wmHcPlYC7iWKt474wOnIQJ/SEDLi0A2ly/gp3A3LMDtUJm6uArqRDdxs=
Received: from DM5PR16CA0032.namprd16.prod.outlook.com (2603:10b6:4:15::18) by
 CH2PR12MB3671.namprd12.prod.outlook.com (2603:10b6:610:23::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.15; Wed, 22 Jun 2022 15:37:59 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:15:cafe::1) by DM5PR16CA0032.outlook.office365.com
 (2603:10b6:4:15::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15 via Frontend
 Transport; Wed, 22 Jun 2022 15:37:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Wed, 22 Jun 2022 15:37:59 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 22 Jun
 2022 10:37:55 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 3/3] drm/amdgpu: Update mes_v11_api_def.h
Date: Wed, 22 Jun 2022 11:37:36 -0400
Message-ID: <20220622153736.174749-3-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b24b084b-c1d1-464c-adbc-08da54652fd9
X-MS-TrafficTypeDiagnostic: CH2PR12MB3671:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB3671CEF8342716DC41610B3E8AB29@CH2PR12MB3671.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qVDPdtAs9vp9+n+L95wRs4YfuqbJ3cbZiKQTzhYsie90BHfIbToh3Jul1GQykiICIuLPGm5FuD73rG4jgC38L2zPYPmUV6EMZL30dABtMoUtVqJLSPQgTgzD0C9yNeB7jI0ld3ypY1eheH0nNtFxIVyk+gpiqpRZkH33sSnX69d6Bhl5in4WpHkrdbLPuWMKBDuC/9VdYfzOmhk/u6B0K7U6xPIGqWyKBKd0SEo2NON6dXcckI/q4q56lvs82Eljy40TnwQ1qVGVmcpxqrqHwt+AmyS+BedaSbOZRBtlkeMEon3QUTyHvMp0xMGDxJYWff6FP8vyv6krD5NNoh5BiRH35ZyrmmcxaUGTIAr+N+mlwUX/KYYUJj9wxI4C23OY9pBFxVTsOPxfTBouXYveaZnpx6DF8640PehKe4lprPoR+yf4CLD7hgkmMn1s+c4grfMTn2UMJwwukIAdK+biTNWGo3iBdpirGN8VUOIhHH3YphLOBKrorcY8SQN7O3T1Y3K5I1HGrn/90zh7JGpb+dBRV5ltzP+UngW9pCHqXxq5XfBvBYdl1Ccws5/73PxlH1eS0REGxqQB2i+4ZC8hTePlhWY1XvpMOe0CPwqIetglYbMW/c/ASnHjSEgNu/jWZ71YOeGReLM9o7x4PAiLVOhhXoGKYjqB8GcXkELStQjQASt1VOM3Nb9m4MAlUdgGg88XKMCk1VmFJRDA7XISkVUEdh69byS3HO5E8DRo26DQcFFb6Ercn3uz2suGce1QRAp9ytCBxDge6LRaBV6Y1ZI70sq7/tgyFeYRINCZJ0E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(376002)(346002)(136003)(46966006)(36840700001)(40470700004)(70206006)(5660300002)(26005)(6916009)(478600001)(70586007)(2906002)(1076003)(54906003)(7696005)(316002)(4326008)(41300700001)(8936002)(8676002)(82310400005)(6666004)(81166007)(336012)(40460700003)(86362001)(47076005)(426003)(186003)(16526019)(15650500001)(36860700001)(36756003)(2616005)(356005)(83380400001)(40480700001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 15:37:59.6477 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b24b084b-c1d1-464c-adbc-08da54652fd9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3671
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
Cc: Felix Kuehling <Felix.Kuehling@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 Graham Sider <Graham.Sider@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update MES API to support oversubscription without aggregated doorbell
for usermode queues.

v2: Change oversubscription_no_aggregated_en to is_kfd_process (align
with MES)

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c               | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h               | 1 +
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c                | 2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 2 ++
 drivers/gpu/drm/amd/include/mes_v11_api_def.h         | 4 +++-
 5 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 69a70a0aaed9..521e35d93d67 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -677,6 +677,7 @@ int amdgpu_mes_add_hw_queue(struct amdgpu_device *adev, int gang_id,
 	queue_input.wptr_addr = qprops->wptr_gpu_addr;
 	queue_input.queue_type = qprops->queue_type;
 	queue_input.paging = qprops->paging;
+	queue_input.is_kfd_process = 0;
 
 	r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
 	if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 137a2cc2e807..5fdc4fbde3bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -213,6 +213,7 @@ struct mes_add_queue_input {
 	uint32_t        gws_size;
 	uint64_t	tba_addr;
 	uint64_t	tma_addr;
+	uint32_t	is_kfd_process;
 };
 
 struct mes_remove_queue_input {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index ead1860744d8..7dfc6ea21397 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -165,6 +165,7 @@ static int mes_v11_0_add_hw_queue(struct amdgpu_mes *mes,
 	mes_add_queue_pkt.gws_size = input->gws_size;
 	mes_add_queue_pkt.trap_handler_addr = input->tba_addr;
 	mes_add_queue_pkt.tma_addr = input->tma_addr;
+	mes_add_queue_pkt.is_kfd_process = input->is_kfd_process;
 
 	mes_add_queue_pkt.api_status.api_completion_fence_addr =
 		mes->ring.fence_drv.gpu_addr;
@@ -312,6 +313,7 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 	mes_set_hw_res_pkt.disable_reset = 1;
 	mes_set_hw_res_pkt.disable_mes_log = 1;
 	mes_set_hw_res_pkt.use_different_vmid_compute = 1;
+	mes_set_hw_res_pkt.oversubscription_timer = 50;
 
 	mes_set_hw_res_pkt.api_status.api_completion_fence_addr =
 		mes->ring.fence_drv.gpu_addr;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 299927a4959b..74a1f8a6f53f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -204,6 +204,8 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	} else
 		queue_input.wptr_addr = (uint64_t)q->properties.write_ptr;
 
+	queue_input.is_kfd_process = 1;
+
 	queue_input.paging = false;
 	queue_input.tba_addr = qpd->tba_addr;
 	queue_input.tma_addr = qpd->tma_addr;
diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
index f9d02d7bdf77..fa1b9e0d299a 100644
--- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
@@ -226,6 +226,7 @@ union MESAPI_SET_HW_RESOURCES {
 			};
 			uint32_t	uint32_t_all;
 		};
+		uint32_t	oversubscription_timer;
 	};
 
 	uint32_t	max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
@@ -265,7 +266,8 @@ union MESAPI__ADD_QUEUE {
 			uint32_t is_gang_suspended	: 1;
 			uint32_t is_tmz_queue		: 1;
 			uint32_t map_kiq_utility_queue  : 1;
-			uint32_t reserved		: 23;
+			uint32_t is_kfd_process		: 1;
+			uint32_t reserved		: 22;
 		};
 		struct MES_API_STATUS		api_status;
 		uint64_t                        tma_addr;
-- 
2.25.1

