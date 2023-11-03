Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD14C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Nov 2023 13:12:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCCC910E9DA;
	Fri,  3 Nov 2023 13:12:21 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13CA610E9CD
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Nov 2023 13:12:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RzQDXMxSUQzj6uEaCFbzmqVpeyMqjhUtVzR+qNjlEEncHzhQfIUA06cEPzApD7mBe3Jd5z+MlM4vstePiMbPkqfKxS66BOywjh+i+k16LxTpJb/lTs451HqW3EwCwSYYwUjMy9mDNRtvPI9poJA04Gd/7oIO8V5EsHOQi68ITn3EEbjrif0UpnpHI3NpY5R0UQjcAwz+O2iTSLVq4Z0nhV5NdU+VWWMThOPyTWkJqoSgUFTNv6nzEziWys4lQqFPZr+Qsqr+DyF5V+tpGNVhGEjipE4e/kG5DztknY0hGSCPrNQOZQV6EJpoQo2uELzDaKjbtVLtZbZbXDH0JnFIhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/ZY7qnizrGxcQhhkJ+yKu3ECBnT2yPxcGo62qrePIY=;
 b=E3sEKtPrCwakvltQMLSj6QNzvPEd1GBg5n3fvMfDrqhoewLLobZhRUJdlymsVvMCoPE8cXOf74PTTo8O5HKLzO6DjdB/9qpv12NotsYvL09ONQC12iZg3KnDdbKvA00A4J4DZhNPE3PnX0T/ZB251Dy15ESEGqNWajZrBrp6EQrU2/UvJDluZF4uS0PBwgyRyA7L9uCN4qRijjdJNiGite9UGfvvtIlSfj0XsvWNgmqDADJlidYVk0PskdsoHeiAb0gqQ2AXo9uaMj/aznJSp7AB0gnqeSYak8PllGGzEGYXMUQ5SYdRVeJDLGvokSOl98iWSmaKQt6Ff3wxv5ms1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/ZY7qnizrGxcQhhkJ+yKu3ECBnT2yPxcGo62qrePIY=;
 b=YwSMBl/EklRssADGjy+h7Fr0exm8ZqsreH4GCgLckBn+5YhM2+iXFi5asIeMxdUUnpgw2qCEJrktMkDqQRAtzXWgRY18kG8oDY3vnFjTkxbfz+ThqZGwMrQnODLTpkBlL9kODdvW9BXW6xeLSlroIonlNZFvoH85jOkVEjTgeVw=
Received: from DS7PR03CA0115.namprd03.prod.outlook.com (2603:10b6:5:3b7::30)
 by DS7PR12MB6144.namprd12.prod.outlook.com (2603:10b6:8:98::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.21; Fri, 3 Nov 2023 13:12:10 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:3b7:cafe::f1) by DS7PR03CA0115.outlook.office365.com
 (2603:10b6:5:3b7::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.22 via Frontend
 Transport; Fri, 3 Nov 2023 13:12:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Fri, 3 Nov 2023 13:12:10 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 3 Nov
 2023 08:12:08 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/24] drm/amdkfd: add queue remapping
Date: Fri, 3 Nov 2023 09:11:36 -0400
Message-ID: <20231103131139.766920-22-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231103131139.766920-1-James.Zhu@amd.com>
References: <20231103131139.766920-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|DS7PR12MB6144:EE_
X-MS-Office365-Filtering-Correlation-Id: f006d77d-b32e-4ac0-8be5-08dbdc6e7d0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zsr/SyPqzcj2fEPX6vPHgGnggcqPJslWgmZ3KzNgTJszJCzmZdr78y9xEx9uDKZJySPuuQUJNC+tahn7sxenjtaFBj3+eO/ydzqT5WclVVWbLKufCWmhgaiDHqm+l4tezvCRyB24+wbxSYAWbsszBopPPZ+58p4fmKbFWv7qk4gkkkFxXWUD7EXZ1vxhhn9CJeiWnnbEOMvJXISNv4HJWKTPgs56aB2YegV7B2Li8BmkpcZN2Uh27Pj57KRGLIpYQGj8Gj9nCj1LCWJy9nkqQ7OvuqqFfd0oUpIfJ7HP1z9tzRqbt8/59uMl4VvYZ4ukJIc22z8MEIVPta/gMXZoJSzid1yNpWBcmeZhRNMWYJjSS1fTEGSx7Me4u3Mm8jt5cBjzQPj1vzWPn6T5fDZhsFKknpXnT/+7BWx/Nsdfx9vWoihCbY4Fbz1y410R8LMSzottQHuGNYUzQC/pR9BheTSd/Cb/T+FsMaO2oWf+cEI3URU34lBOxUNyEeI3soTUnpeK7YD/+jlHzfCyONJhLttwJBP4Kl6Mqf2nIwIvsafvAPWIXl9Wp2nTqbcOKzHKfI5QmsZqmIZlVxbBp55d3/3nU3xF4vILbkIBSYmxyyRWjFEbY4Yfork4S/mi9FkqKwxMkIRHfrgy/l67utqrfdfmnQbewr9DCFaQY7ZE4XEX6AtnEoYkE2qvmCQmHOn7ftB7w9s6IerEPoonjfZNEczDt7VQqh2OZqgTEGwlaaJ7zkoswgLhYil87qsBhGl/lAyBk/jZ+TKm0AWaF9zxXQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(376002)(39860400002)(346002)(230922051799003)(82310400011)(1800799009)(186009)(451199024)(64100799003)(36840700001)(40470700004)(46966006)(26005)(83380400001)(426003)(336012)(5660300002)(16526019)(40480700001)(2616005)(1076003)(2906002)(47076005)(4326008)(8936002)(8676002)(36756003)(86362001)(70586007)(54906003)(81166007)(82740400003)(6916009)(6666004)(70206006)(356005)(7696005)(41300700001)(36860700001)(478600001)(40460700003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 13:12:10.3735 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f006d77d-b32e-4ac0-8be5-08dbdc6e7d0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6144
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
Cc: Felix.kuehling@amd.com, joseph.greathouse@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add queue remapping to force the waves in any running
processes to complete a CWSR trap.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 11 +++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h |  5 +++++
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c          |  3 +++
 3 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index c0e71543389a..a3f57be63f4f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -3155,6 +3155,17 @@ int debug_refresh_runlist(struct device_queue_manager *dqm)
 	return debug_map_and_unlock(dqm);
 }
 
+void remap_queue(struct device_queue_manager *dqm,
+				enum kfd_unmap_queues_filter filter,
+				uint32_t filter_param,
+				uint32_t grace_period)
+{
+	dqm_lock(dqm);
+	if (!dqm->dev->kfd->shared_resources.enable_mes)
+		execute_queues_cpsch(dqm, filter, filter_param, grace_period);
+	dqm_unlock(dqm);
+}
+
 #if defined(CONFIG_DEBUG_FS)
 
 static void seq_reg_dump(struct seq_file *m,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index cf7e182588f8..f8aae3747a36 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -303,6 +303,11 @@ int debug_lock_and_unmap(struct device_queue_manager *dqm);
 int debug_map_and_unlock(struct device_queue_manager *dqm);
 int debug_refresh_runlist(struct device_queue_manager *dqm);
 
+void remap_queue(struct device_queue_manager *dqm,
+				enum kfd_unmap_queues_filter filter,
+				uint32_t filter_param,
+				uint32_t grace_period);
+
 static inline unsigned int get_sh_mem_bases_32(struct kfd_process_device *pdd)
 {
 	return (pdd->lds_base >> 16) & 0xFF;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
index e8f0559b618e..66670cdb813a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
@@ -24,6 +24,7 @@
 #include "kfd_priv.h"
 #include "amdgpu_amdkfd.h"
 #include "kfd_pc_sampling.h"
+#include "kfd_device_queue_manager.h"
 
 struct supported_pc_sample_info {
 	uint32_t ip_version;
@@ -164,6 +165,8 @@ static int kfd_pc_sample_stop(struct kfd_process_device *pdd,
 		cancel_work_sync(&pdd->dev->pcs_data.hosttrap_entry.base.pc_sampling_work);
 		kfd_process_set_trap_pc_sampling_flag(&pdd->qpd,
 			pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info.method, false);
+		remap_queue(pdd->dev->dqm,
+			KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD);
 
 		mutex_lock(&pdd->dev->pcs_data.mutex);
 		pdd->dev->pcs_data.hosttrap_entry.base.target_simd = 0;
-- 
2.25.1

