Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D0BC77B62
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:43:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B20010EFF0;
	Thu, 30 Mar 2023 19:43:01 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45B3610EFF0
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:42:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UkW+DfWG0APgbRIVJkkqHFVsW01skGSzEwUqfLprZbFVDRJ3WSsodfffCAOizxRNBmAHfGPGkRrxw9sWoTex5j69RUYNdu6m5vWa2X+MlUurI3cPtWxb6xcKbDkARcmJFFpOQQpdx1jr9XyuCuENylf1t5uOEaawByxcWgG+/rr5yzpe4kHuXQzUFYhBuoOsVcrsNvW/AxoC1Kht3w/tB1OsUwY5DMjf27P+/EP5eFSHxvIzi25sQowc2AJxbK8tNdC3APGbyqFYYqr+BgFXEPOo/hoA6bNSMkD/cmvuGcdyXh629W0BiJE4jTmrqDSJ3Ss+JWVla/lIpyQ4wCqbrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sT4WCvA/ronbc+vXPpKLTWsU2Ii4a6p/PIj+/f4p1lg=;
 b=U8aCYo5uOUvXz0LQcBGREDt20gjucOUvd/KQcjsXxMj4M4ncWWIEhWA2CcaPUSmNX3sYhMTBpp8CuYkt3cxSbx4GSvqRKg5FZTUoLg6/DfKcNdn4lhOmMSJpxUNoJhMfsdYak+59TndyrTQc9m/Q8cVtECycOrqnzrg0yAnD2gxN2Dr58OVuia9BfgJ6dS2E8BF2pfsncEAE0PWpf5BmSEGjd4khd9s1bOLYnEiZ7qhac41tZKXt6pHqD6GXKNgRS2u/7qb+g8KimhcD9n4ZOmToXXGqMnUmvrf8cdDHiU+WPEHUvizygYIICAzLTQ41BLpmgDxhfTHMSVP3bodfOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sT4WCvA/ronbc+vXPpKLTWsU2Ii4a6p/PIj+/f4p1lg=;
 b=q7rDWrt15ysyecY21+/Pq7EUfnwgXhsWBNTx30Gh9sinCVe91VFb0FKxfhViZGHcYsc7yR7Fq/P31OEXn4Q/25+07pUcPgbNLO79nvq0OcUsTXhg+7Vt9QE2FsRZIUtBN28ZohihqkT493w6Mwb6FHbFeS4J7IvSKaEnmdndXzI=
Received: from DM6PR08CA0005.namprd08.prod.outlook.com (2603:10b6:5:80::18) by
 DM4PR12MB6182.namprd12.prod.outlook.com (2603:10b6:8:a8::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.32; Thu, 30 Mar 2023 19:42:54 +0000
Received: from DS1PEPF0000E63B.namprd02.prod.outlook.com
 (2603:10b6:5:80:cafe::ed) by DM6PR08CA0005.outlook.office365.com
 (2603:10b6:5:80::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 19:42:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E63B.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 19:42:54 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:42:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/23] drm/amdkfd: Setup current_logical_xcc_id in MQD
Date: Thu, 30 Mar 2023 15:42:23 -0400
Message-ID: <20230330194234.1135527-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330194234.1135527-1-alexander.deucher@amd.com>
References: <20230330194234.1135527-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63B:EE_|DM4PR12MB6182:EE_
X-MS-Office365-Filtering-Correlation-Id: 96b2f709-affe-4cae-b07e-08db3156f4b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: amqzJHu9PKyUZq+hHAkB4MW32qeETLoQxhkDXS0jbb5KHANSO4F4c/ubpVb1PuQJdPL9yXZRD9TOeEC0Et/eFVHTVEGZI5TiGyAr8rodn1oWBhGIBSmig3uzPI/xM7VvecgmLRXYAHE0XtiMLs+csUjSPFwnS0bSL9MAzxl7qtG81ccwlpgbHsJ/aK5lzcrSh5hhgwu7k1KfWnYIgWdrfvXngWpqg2BbJ2fICq0zeYciFW4Ampm4ah8AWmkke9zjWS1I7S5WodAtwcWCUzpgvCk6/VGwFLtyZvR90EHvcrLoWMm9lvXyT3qIuctMZwTmnLHZwZ8oHZO1kt+tkeASnHx4005YUkghl41DnTGS/280ABDrAH2tISM54OQieib9mb6QzoA7L9WYEEMTk1+7ZChaN3jGUmj7iFxiWdqPHmgtXD3WuVmh0ESTTYXZSQrVxFOlYKUEx1FcUHGT1YT8wAyHPnPHM6VFqBcrfrpE932JuLoNifV5N9uAw+/jrlODBAQny5J9X3wpKuEl+yliecUCxoebxJ0SkA7P4CxgeKfWl06yNq/DU2/FpcfJrhq9Xjfm+7wh+CWlVRegl3XOrz6A5MBObkyxPHrYCogDUZwcOoobcE9Q+brd8BVyZoVbUSZQrH0b2KTPu+ahEejjIEBmdXMV1cyXVshvJx/XJarVF05/bJ428wq8AuUy5TNYCcdtN0z6wMV8zUHActjfGAEZRdT5vXliAc08iq1zSe4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199021)(36840700001)(40470700004)(46966006)(478600001)(2906002)(36756003)(86362001)(82310400005)(40480700001)(40460700003)(2616005)(426003)(6666004)(336012)(83380400001)(47076005)(7696005)(6916009)(81166007)(316002)(26005)(70206006)(8676002)(8936002)(4326008)(36860700001)(54906003)(16526019)(5660300002)(41300700001)(186003)(356005)(1076003)(82740400003)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:42:54.4706 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96b2f709-affe-4cae-b07e-08db3156f4b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E63B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6182
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
Cc: Alex
 Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Joseph Greathouse <Joseph.Greathouse@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mukul Joshi <mukul.joshi@amd.com>

Setup rolling current_logical_xcc_id in MQD for GFX9.4.3
to ensure each queue starts at a different place and prevent
hotspotting issues. Also, remove updating current_logical_xcc_id
during queue update.

Suggested-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.h   |  3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c     | 13 +++++--------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index b11c474d4067..cd4383bb207f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -256,6 +256,9 @@ struct device_queue_manager {
 	struct work_struct	hw_exception_work;
 	struct kfd_mem_obj	hiq_sdma_mqd;
 	bool			sched_running;
+
+	/* used for GFX 9.4.3 only */
+	uint32_t		current_logical_xcc_start;
 };
 
 void device_queue_manager_init_cik(
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 2085054be3be..ac978141ebea 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -32,6 +32,7 @@
 #include "gc/gc_9_0_sh_mask.h"
 #include "sdma0/sdma0_4_0_sh_mask.h"
 #include "amdgpu_amdkfd.h"
+#include "kfd_device_queue_manager.h"
 
 static void update_mqd(struct mqd_manager *mm, void *mqd,
 		       struct queue_properties *q,
@@ -568,6 +569,7 @@ static void init_mqd_v9_4_3(struct mqd_manager *mm, void **mqd,
 	uint64_t xcc_gart_addr = 0;
 	uint64_t xcc_ctx_save_restore_area_address;
 	uint64_t offset = mm->mqd_stride(mm, q);
+	uint32_t local_xcc_start = mm->dev->dqm->current_logical_xcc_start++;
 
 	memset(&xcc_mqd_mem_obj, 0x0, sizeof(struct kfd_mem_obj));
 	for (xcc = 0; xcc < mm->dev->num_xcc_per_node; xcc++) {
@@ -595,18 +597,17 @@ static void init_mqd_v9_4_3(struct mqd_manager *mm, void **mqd,
 
 		if (q->format == KFD_QUEUE_FORMAT_AQL) {
 			m->compute_tg_chunk_size = 1;
+			m->compute_current_logic_xcc_id =
+					(local_xcc_start + xcc) %
+					mm->dev->num_xcc_per_node;
 
 			switch (xcc) {
 			case 0:
 				/* Master XCC */
 				m->cp_hqd_pq_control &=
 					~CP_HQD_PQ_CONTROL__NO_UPDATE_RPTR_MASK;
-				m->compute_current_logic_xcc_id =
-					mm->dev->num_xcc_per_node - 1;
 				break;
 			default:
-				m->compute_current_logic_xcc_id =
-					xcc - 1;
 				break;
 			}
 		} else {
@@ -641,12 +642,8 @@ static void update_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
 				/* Master XCC */
 				m->cp_hqd_pq_control &=
 					~CP_HQD_PQ_CONTROL__NO_UPDATE_RPTR_MASK;
-				m->compute_current_logic_xcc_id =
-					mm->dev->num_xcc_per_node - 1;
 				break;
 			default:
-				m->compute_current_logic_xcc_id =
-					xcc - 1;
 				break;
 			}
 			m->compute_tg_chunk_size = 1;
-- 
2.39.2

