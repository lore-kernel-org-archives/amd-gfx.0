Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC2C2ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 06:46:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3A2910E883;
	Wed, 14 Sep 2022 06:46:45 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D53D010E883
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 06:46:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XppeeQSNRumEzaE8ZunkYdcSX+mqnOvVg9rOK1g/aDoetbpCKJlVCg8bkmeb/sNxBjoXJCrbgCOGJDyBlRSBeNk4gnJCRyhgPA8QomkmKxMzm2cS37S9hN4ZGHZ/FS7CUx0eP1eP0+uwLaiL7QmMEaKUUrhn2I9OV68BNZxx0n7QHnWhHOjGrkXtkLf8Ro+Li/n3HtlqN/vv4mX8SH/1fXw39uKbqrcu8djM8q/6C9YYzsoo2216CLbn/h/n2zLN4Wiph8fGhcf5JicTZu+iEt8ReFMU/dVpXqPlFiPPJqNkDtIdGKiIMFPVGlup7BVpH24b537J/sbu1iqRi+pwHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1WReNdpWC/uPyTTUOojtmH+GumQcThxdmyWB6KwiXi8=;
 b=Yk2YPg+HyRMIfR+JiOOCSkqlGiCxtfzO9X2L/TVP0gHa0b0mQ6FQWpiE0/seCcrSCn6AhT78k2L5xIy5vlfGE/MZcagyfdkPPufnnoeJV7G/cDu+9qYq/5IYY+qC6oKOs1XxQhUWs1QT1eKrJSKJGrjsP25jg/K5EAjmDgrQc/yhORQyObZnsOZdDDCVaptwM6Ti/xGA8b9tyJH69oQTCRQyJJmEgRoPT8T4epYjTyxo27k6NMbhfK3vD82c+HCi6yH3/ESDtEZucuPXt9Klbj7eoAOvCGmnY17WjUwD0ItAbYAT6JA6uieGsPVOsu3/xShP2Jtvas/HCEYgLvJCEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WReNdpWC/uPyTTUOojtmH+GumQcThxdmyWB6KwiXi8=;
 b=o45VW+5V6GrPtAxQk3OKWIcBwzisrXEty5mMesySAZRFAjRbn79Jfl+KKhEJ/pSz+OULzRLAikjuNW+4VKchdn6ZI3FOBt/SZntGeXVSlJEoDCSgx3Tou9FrvDm+AmF7NgNqL53LJrUoJq4mP6bLrm8sWrjsPfo2KMeikvZuL5I=
Received: from BN9PR03CA0249.namprd03.prod.outlook.com (2603:10b6:408:ff::14)
 by CH0PR12MB5297.namprd12.prod.outlook.com (2603:10b6:610:d4::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 14 Sep
 2022 06:46:39 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::fb) by BN9PR03CA0249.outlook.office365.com
 (2603:10b6:408:ff::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.14 via Frontend
 Transport; Wed, 14 Sep 2022 06:46:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 06:46:39 +0000
Received: from lnx-ci-node.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 01:46:36 -0500
From: Shiwu Zhang <shiwu.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Use the consolidated MQD manager functions for
 GFX11
Date: Wed, 14 Sep 2022 14:46:04 +0800
Message-ID: <20220914064604.31906-1-shiwu.zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT063:EE_|CH0PR12MB5297:EE_
X-MS-Office365-Filtering-Correlation-Id: 6df03a55-0d38-4a74-9ba2-08da961ce04d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a1K/xoKiKZAMF2zAw6OQ7ZK2nheZkuYe9sXo0MvEz+OJ/fNJfXArsHHbDz2D/Q/HKuLzMOPjLhJq6dwtOhGdg5I/Mrs4RrXBeRFvODvhTTbl0su3GqlSiVkpQ73Nwi4V0pBemNoFYW1OvoGm30ewUPnerM+qCsu6dFR6OX8oINrNLvfRCrXye1JuufAEx870HLor74Nkn5ObQpVLHsJ6+SuvZwQVQcNkmw1bQrkEf8G6e5AmqMOeiui+yaOezG2xHsTnSKsCOjCilsrk7lLMI3LE4NW8CWucXy6gua4qlBbKjKgRgrpkdTMvX2yIAUA+AYRHvKdzBo9OGP5iMlREDRt65FhIXUafgcl4EqGdUOvdcyUVZNYgLQinDZ9Brbr9AmDiGCFi8yKWVc/XLzns04fTWjrMYLGLsTVBKA++IfetCnWhsHZvRuBwIUS2cSvHfiAcn7I5qAmOofxqiP7WuJEei9XnTN3iUCMUH6mYkWT0ghzs6OKM6NDWzZZ05NcGYdOSBZQJaRXrARZvLlS+stCnp2dZbTJtTU61hv0+dC0cweFF89yeU8NYdydx6Rh2ycwiQUfoUR8Vo8pazYafUL2hA29tz5tTVswor36nISeCT5j3xzqgBqGODu6wGNFnW6FMndIcHmitXjPA3eRm13DT36K974s9yZ6wA+1Hai90yabxRX2MCBjseByUuMEflhg4SGy4y2XD2eX8kgsrPNTkAaz6qJh9GrDZUgdx55o9GGyVvg6AwETyWismTTTXboBcDIeEkuqzbCXGKNy7f/N1evg2yLBa6vanYTFZFvg8er3hnLWKEUWVPFX5koMa
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199015)(36840700001)(40470700004)(46966006)(40480700001)(7696005)(5660300002)(6916009)(86362001)(6666004)(44832011)(336012)(70586007)(426003)(36756003)(41300700001)(82310400005)(2906002)(82740400003)(70206006)(26005)(40460700003)(16526019)(478600001)(36860700001)(316002)(81166007)(8936002)(47076005)(83380400001)(356005)(8676002)(2616005)(186003)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 06:46:39.1998 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df03a55-0d38-4a74-9ba2-08da961ce04d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5297
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

To remove duplication for GFX11 as well, use the common MQD manager
functions defined in kfd_mqd_manager.c for all version of managers

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c  | 85 +++----------------
 1 file changed, 12 insertions(+), 73 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
index b8e14c2cc295..d982c154537e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
@@ -177,14 +177,6 @@ static int load_mqd(struct mqd_manager *mm, void *mqd,
 	return r;
 }
 
-static int hiq_load_mqd_kiq(struct mqd_manager *mm, void *mqd,
-			    uint32_t pipe_id, uint32_t queue_id,
-			    struct queue_properties *p, struct mm_struct *mms)
-{
-	return mm->dev->kfd2kgd->hiq_mqd_load(mm->dev->adev, mqd, pipe_id,
-					      queue_id, p->doorbell_off);
-}
-
 static void update_mqd(struct mqd_manager *mm, void *mqd,
 		       struct queue_properties *q,
 		       struct mqd_update_info *minfo)
@@ -256,31 +248,6 @@ static uint32_t read_doorbell_id(void *mqd)
 	return m->queue_doorbell_id0;
 }
 
-static int destroy_mqd(struct mqd_manager *mm, void *mqd,
-		       enum kfd_preempt_type type,
-		       unsigned int timeout, uint32_t pipe_id,
-		       uint32_t queue_id)
-{
-	return mm->dev->kfd2kgd->hqd_destroy
-		(mm->dev->adev, mqd, type, timeout,
-		 pipe_id, queue_id);
-}
-
-static void free_mqd(struct mqd_manager *mm, void *mqd,
-			struct kfd_mem_obj *mqd_mem_obj)
-{
-	kfd_gtt_sa_free(mm->dev, mqd_mem_obj);
-}
-
-static bool is_occupied(struct mqd_manager *mm, void *mqd,
-			uint64_t queue_address,	uint32_t pipe_id,
-			uint32_t queue_id)
-{
-	return mm->dev->kfd2kgd->hqd_is_occupied(
-		mm->dev->adev, queue_address,
-		pipe_id, queue_id);
-}
-
 static int get_wave_state(struct mqd_manager *mm, void *mqd,
 			  void __user *ctl_stack,
 			  u32 *ctl_stack_used_size,
@@ -349,15 +316,6 @@ static void init_mqd_sdma(struct mqd_manager *mm, void **mqd,
 	mm->update_mqd(mm, m, q, NULL);
 }
 
-static int load_mqd_sdma(struct mqd_manager *mm, void *mqd,
-		uint32_t pipe_id, uint32_t queue_id,
-		struct queue_properties *p, struct mm_struct *mms)
-{
-	return mm->dev->kfd2kgd->hqd_sdma_load(mm->dev->adev, mqd,
-					       (uint32_t __user *)p->write_ptr,
-					       mms);
-}
-
 #define SDMA_RLC_DUMMY_DEFAULT 0xf
 
 static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
@@ -389,25 +347,6 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
 	q->is_active = QUEUE_IS_ACTIVE(*q);
 }
 
-/*
- *  * preempt type here is ignored because there is only one way
- *  * to preempt sdma queue
- */
-static int destroy_mqd_sdma(struct mqd_manager *mm, void *mqd,
-		enum kfd_preempt_type type,
-		unsigned int timeout, uint32_t pipe_id,
-		uint32_t queue_id)
-{
-	return mm->dev->kfd2kgd->hqd_sdma_destroy(mm->dev->adev, mqd, timeout);
-}
-
-static bool is_occupied_sdma(struct mqd_manager *mm, void *mqd,
-		uint64_t queue_address, uint32_t pipe_id,
-		uint32_t queue_id)
-{
-	return mm->dev->kfd2kgd->hqd_sdma_is_occupied(mm->dev->adev, mqd);
-}
-
 #if defined(CONFIG_DEBUG_FS)
 
 static int debugfs_show_mqd(struct seq_file *m, void *data)
@@ -445,11 +384,11 @@ struct mqd_manager *mqd_manager_init_v11(enum KFD_MQD_TYPE type,
 		pr_debug("%s@%i\n", __func__, __LINE__);
 		mqd->allocate_mqd = allocate_mqd;
 		mqd->init_mqd = init_mqd;
-		mqd->free_mqd = free_mqd;
+		mqd->free_mqd = kfd_free_mqd_cp;
 		mqd->load_mqd = load_mqd;
 		mqd->update_mqd = update_mqd;
-		mqd->destroy_mqd = destroy_mqd;
-		mqd->is_occupied = is_occupied;
+		mqd->destroy_mqd = kfd_destroy_mqd_cp;
+		mqd->is_occupied = kfd_is_occupied_cp;
 		mqd->mqd_size = sizeof(struct v11_compute_mqd);
 		mqd->get_wave_state = get_wave_state;
 #if defined(CONFIG_DEBUG_FS)
@@ -462,10 +401,10 @@ struct mqd_manager *mqd_manager_init_v11(enum KFD_MQD_TYPE type,
 		mqd->allocate_mqd = allocate_hiq_mqd;
 		mqd->init_mqd = init_mqd_hiq;
 		mqd->free_mqd = free_mqd_hiq_sdma;
-		mqd->load_mqd = hiq_load_mqd_kiq;
+		mqd->load_mqd = kfd_hiq_load_mqd_kiq;
 		mqd->update_mqd = update_mqd;
-		mqd->destroy_mqd = destroy_mqd;
-		mqd->is_occupied = is_occupied;
+		mqd->destroy_mqd = kfd_destroy_mqd_cp;
+		mqd->is_occupied = kfd_is_occupied_cp;
 		mqd->mqd_size = sizeof(struct v11_compute_mqd);
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd;
@@ -476,11 +415,11 @@ struct mqd_manager *mqd_manager_init_v11(enum KFD_MQD_TYPE type,
 	case KFD_MQD_TYPE_DIQ:
 		mqd->allocate_mqd = allocate_mqd;
 		mqd->init_mqd = init_mqd_hiq;
-		mqd->free_mqd = free_mqd;
+		mqd->free_mqd = kfd_free_mqd_cp;
 		mqd->load_mqd = load_mqd;
 		mqd->update_mqd = update_mqd;
-		mqd->destroy_mqd = destroy_mqd;
-		mqd->is_occupied = is_occupied;
+		mqd->destroy_mqd = kfd_destroy_mqd_cp;
+		mqd->is_occupied = kfd_is_occupied_cp;
 		mqd->mqd_size = sizeof(struct v11_compute_mqd);
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd;
@@ -491,10 +430,10 @@ struct mqd_manager *mqd_manager_init_v11(enum KFD_MQD_TYPE type,
 		mqd->allocate_mqd = allocate_sdma_mqd;
 		mqd->init_mqd = init_mqd_sdma;
 		mqd->free_mqd = free_mqd_hiq_sdma;
-		mqd->load_mqd = load_mqd_sdma;
+		mqd->load_mqd = kfd_load_mqd_sdma;
 		mqd->update_mqd = update_mqd_sdma;
-		mqd->destroy_mqd = destroy_mqd_sdma;
-		mqd->is_occupied = is_occupied_sdma;
+		mqd->destroy_mqd = kfd_destroy_mqd_sdma;
+		mqd->is_occupied = kfd_is_occupied_sdma;
 		mqd->mqd_size = sizeof(struct v11_sdma_mqd);
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd_sdma;
-- 
2.17.1

