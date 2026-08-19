Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C8CAC5DF6D
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2026 11:40:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA8C010EE03;
	Wed, 19 Aug 2026 11:40:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AjmjN8RD";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010004.outbound.protection.outlook.com [52.101.46.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 521C310EE03
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2026 11:40:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WM3I0sXVW547rWp6qUdZ3QYEZd32we43Yvj5aFEHmQSQ1iclWFQisJAfqLDvHrxuKuoCMJePBcs2gqsy7ewi4Dhkm/puzOGU+TipEHkmSShnyUv1OZUCjftTneSO2He9drFs270M/pkqU4YsmUu7eWF1VjPuWKKvKswHbcUZPwOSwojnupKTcGf0Lo5/e17zU0wxzbHMuidZ40lzxIckj8Uj2Bo4ZjO1kj/vbJgjDuKzuVwVVRGflggLQWB3xPsykHicaw4seTOgu/i8zzdbL4YlOetSrxzGQ+B9mHqlosRyYoVqt4NyJY7PJQwAI9P3cZF6C+8wf6M/+JMPTEM8aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iViElLcWcgwCFUbLcfVpeD6gRXflTgPywRl9HuidjDI=;
 b=KjEyCd7HFz8zqdLaeXsaTK4QRAVuJLnK+wBkU8lTm6XOuEOKjIrmwijonO03rvXfVbpHDyfYrPqNpdjALiJlGR2cPC6TLbPblXp8dy6RvilSCkC14SGDn8IwYOS851u4pwtr7Q9ptvdgd541nc1HE6AHnjiH0jt/K/JRY1Q1S2iFEjIWCNmQTr4cRuUrat8or0TFbaRp6TBOXLd0fvZjj6/jR8h82zExdRp/KttHohtfIoO9H7AxZ63n1IWijruLTQiHSO3VrbBm5rxPqpIiSiYlc6WslDBX3Tv4HfQVJOk/OpIJrkD4g9tnhEkGVzjNK+9GCqJP8iwSbPonzZrftw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iViElLcWcgwCFUbLcfVpeD6gRXflTgPywRl9HuidjDI=;
 b=AjmjN8RDoQq81F+X2LGJ3m2oi2TpKV8hQuyCrS3e+q9k+BKf7xhZq+kKE2MOzNg4z5Xr8V4kOtSStj0HloYv8Q+5P0/YoXB8vBk4BywYsZB1+vLbd2VIYcb8OyEOxbeE7Stfz0H+1EJKFauIAR5MpbXQ8IRWpzgTm+EpGgSCdwk=
Received: from CH5P222CA0020.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::12)
 by LV3PR12MB9185.namprd12.prod.outlook.com (2603:10b6:408:199::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 11:40:09 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::22) by CH5P222CA0020.outlook.office365.com
 (2603:10b6:610:1ee::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Wed, 19
 Aug 2026 11:40:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Wed, 19 Aug 2026 11:40:09 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 06:40:08 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Wed, 19 Aug 2026 06:40:06 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu/mes_userqueue: add MODIFY support for SDMA user
 queues
Date: Wed, 19 Aug 2026 19:39:52 +0800
Message-ID: <20260819114001.718908-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|LV3PR12MB9185:EE_
X-MS-Office365-Filtering-Correlation-Id: 65a33438-49ed-48a5-fbb6-08defde69f5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: kztepl1HLlWZxaWjNCSvGwHcQAP0ts73QWp/2A8zfwS00z7BKQFgCOGG7Cnh5rSpe2EA/TpC67QnkydZ3YCUlFW41hoRVl/H35KkhAwe8jAZ5YDmDlYnbJT1bPgRreaavSDJvKBPdWn5dEX+hpMuZtAz7zKiIMTFt+c2ZgoUlJ85zwwjAA/RoAOIXRpFoHFxgnfzKi/+ZyFVkzePbeR2J56uA75ckNwZ3pmAJ4jxsxn72N5SoCqIW2+OGbYY+RtB/Rkl3lIwXcMeYESvwEJUtM7ZoP/asY4mHHhivOfsox/WZ+632U1dBtnEmNHlONwF0nfrXp5Lo+VWtRg7fzdEjUsfJzKyN4s6hVSwOiBTiskUcf3BoSVn6/vEK9dPrdgGZVUo+kcFym51tatRB7yL5G+xK5kfwzBbHB2P/50VgRvICjbit5vpz0O3sHPp8SihkP4sGIZduGWfZ1Mpxxc5zj6KK5WF7Q8NfWqtUx7IADruvi3EapPVFNX/fThlPSEmqm04kxTFbGjENBXclJuOFymdtfhThV+sY1Pm1yk502SeE48y7fbMAKlv2XEyapfdoMWss6zd62UklYcLSmJHs5EO/KMwEZNYWGAu80YrtqHrw6QMBaPCV5bojK2r/B5Oa+NoQMbGBgrR9HaanaEvAi/X8DH+GZ55b2cfiL2lloSjG7naCU3ryKyat7u+LEQ9lieDtMUQBK0R+zqHECKjCQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /HV0nqoJZ3YgsGlJLzV4BaCE+Pp4NK0lK4zXYavcZ/1uWlueLbNO73x8ttBkbo3cw6pa5Vd1bsCxlk7kJyBSa5/xIehRI28+U1ZXVfBYExUWBSYolULOnfk2BJGmJolcQI0qO/MSnVN8JwrI+BDAYheUTppSkL2gfH1Nsy+6fLFxQ2xp0uQkgEhFB+7gfBUFz7Oc9CYoCzbRkJHVwMIjU2ELMacdL8qTzCwLbiAZI36ssWVGmTtJpMuYJYqAu3KTiIOu/03GUxCymO3yIAdxSOyyOkwzJJXxpSzROrjalyNLNKvFWOB9iLScKCPdu4Ae2rAkgaagxnK0hcsFY73DcgkJvkw+oojicgi3eqMVnkaCXlUOw8u8luMbXNXQaD2YpZ6VsajS7eAfi7djNcecxeUIbcj5TbFc9vb2cpvuWU3ph2gvlXn6Dxbw99E6r2+V
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 11:40:09.0547 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a33438-49ed-48a5-fbb6-08defde69f5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9185
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

mes_userq_mqd_update() only handled compute user queues and rejected
every other queue type with -EINVAL, so an SDMA user queue could not be
updated at runtime.

Add mes_userq_sdma_mqd_update() to update an SDMA queue's MQD from a
drm_amdgpu_userq_mqd_sdma_gfx11 (csa address, queue size and ring base)
and re-init the MQD. Validate the queue type up front, then dispatch to
the SDMA or compute path based on queue_type.

This aligns KGD user queues with KFD, which already supports updating
SDMA queues via update_mqd_sdma.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 36 +++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index ad72ced472dd..03f6b5ab32ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -681,6 +681,36 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 	return r;
 }
 
+static int mes_userq_sdma_mqd_update(struct amdgpu_usermode_queue *queue,
+				     struct drm_amdgpu_userq_in *args_in)
+{
+	int retval = 0;
+	struct amdgpu_device *adev = queue->userq_mgr->adev;
+	struct amdgpu_mqd_prop *userq_props = queue->userq_prop;
+	struct amdgpu_mqd *mqd_hw_default = &adev->mqds[queue->queue_type];
+	struct drm_amdgpu_userq_mqd_sdma_gfx11 *sdma_mqd_v11;
+
+	if (args_in->mqd_size != sizeof(*sdma_mqd_v11)) {
+		DRM_ERROR("Invalid SDMA IP MQD size\n");
+		return -EINVAL;
+	}
+
+	sdma_mqd_v11 = memdup_user(u64_to_user_ptr(args_in->mqd), args_in->mqd_size);
+	if (IS_ERR(sdma_mqd_v11)) {
+		DRM_ERROR("Failed to read user MQD\n");
+		return -ENOMEM;
+	}
+
+	userq_props->csa_addr = sdma_mqd_v11->csa_va;
+	userq_props->queue_size = args_in->queue_size;
+	userq_props->hqd_base_gpu_addr = args_in->queue_va;
+
+	retval = mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_ptr, userq_props);
+
+	kfree(sdma_mqd_v11);
+	return retval;
+}
+
 static int mes_userq_mqd_update(struct amdgpu_usermode_queue *queue, struct drm_amdgpu_userq_in *args_in)
 {
 	int retval = 0;
@@ -692,9 +722,13 @@ static int mes_userq_mqd_update(struct amdgpu_usermode_queue *queue, struct drm_
 	if (!queue || !userq_props)
 		return -EINVAL;
 
-	if (queue->queue_type != AMDGPU_HW_IP_COMPUTE)
+	if (queue->queue_type != AMDGPU_HW_IP_COMPUTE &&
+	    queue->queue_type != AMDGPU_HW_IP_DMA)
 		return -EINVAL;
 
+	if (queue->queue_type == AMDGPU_HW_IP_DMA)
+		return mes_userq_sdma_mqd_update(queue, args_in);
+
 	if (args_in->mqd_size != sizeof(*compute_mqd_v11)) {
 		DRM_ERROR("Invalid compute IP MQD size\n");
 		return -EINVAL;
-- 
2.49.0

