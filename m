Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D910CD6E4C
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 05:53:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F070D112DCE;
	Mon,  1 Jun 2026 05:53:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RG/Yn8Ds";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012027.outbound.protection.outlook.com [40.107.209.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A76CB112DCE
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 05:53:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gt1djkuQFeQDA+ZtJrpwb2Y+VDXPYJLxx8oGafh3c8DLPJCJyItPI4M0k7Q4zZtKdnexBrejJOy8qpNk2QeFhVVmnJ4fmF+x1DaZgZRbQdz7yfxia8ObPReEJk6aIGtZmtMKouCMP99nPs6r7vBCCU57rKIUYAa5cuX/ckHIL/swpYZo7MZVX9IjfG+vMpfmubNKu3RFIPw6TSqeVPuS7ipT9inym8+6wl1Bz96baDAZrrjg2rv70ojAoFDr19vgQRDNf4KDOn7MhwiTZldTbCb+OYvfnzKb2uAnIz8knLUVZfFHSe0WhRsxsdcINwh797eW7d4RrRc/uSAFBjcHog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DEj8yqvyp+1aHcEUrbFgrvUo+J3RcGkrTBjLLQInSCk=;
 b=vjzB0zkRU4E9epusr9nXaK/PzbmPJMJX7JDsPUOuq3T8y2+irsOStAeTtqoEIH0N0sIe0rWaV6hMd93vD8rwrPblUwZwGSGWFvDl4Ye0c5QIKZjdQN7TFJesGjFjm4H3NU9LCMUtODQqGJz+YCo+3Pa7jmH9gNFJhIhIVf0WuZqEYvd59s6S/EPXfyCAifurOLtgPrZMLNKjbGUjvDqUEJiVcQOJ3ELkH6vjfL6KlzsMP2uG7DHkTKG4LknmKc6FPSS7DhjuhMmWStl8xqq8WslPlnvmm+jD+u8WDIVmwJgiPA5tRfVGKwfUenUIJ4x+A+q8zBUmNEXdz0qjfBjSmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEj8yqvyp+1aHcEUrbFgrvUo+J3RcGkrTBjLLQInSCk=;
 b=RG/Yn8DskjJJFy8UGujZ2k/VD0Qr1BDn7QetijmZiFinRpr5Iqs5VgUluEq++xTIFFpIDLniXUCSC/LB5m4vJcpxC+JN2d+/XDeXO7LzWtkJnjs4SXvNprW5vLHNCPCMA1xvjQwecfuYcqhq00uyHPJIOJy5jM7nAyYOq/kwtfo=
Received: from BN9PR03CA0760.namprd03.prod.outlook.com (2603:10b6:408:13a::15)
 by CY3PR12MB9630.namprd12.prod.outlook.com (2603:10b6:930:101::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Mon, 1 Jun 2026
 05:53:33 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:408:13a:cafe::16) by BN9PR03CA0760.outlook.office365.com
 (2603:10b6:408:13a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 05:53:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 05:53:33 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:53:32 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:53:32 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 1 Jun 2026 00:53:26 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2 23/42] drm/amdgpu/userq: drop detect_and_reset callback
Date: Mon, 1 Jun 2026 13:49:09 +0800
Message-ID: <20260601055034.3700921-23-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
References: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|CY3PR12MB9630:EE_
X-MS-Office365-Filtering-Correlation-Id: e8330818-0e70-4dff-daca-08debfa21d51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: L5fewWm+Q0xM8c7S9ZWqG9eyZ0dp7t0H8pTkEW/wV3en6CDwXip2uSBZZVoErNOzGxAdUYt7rFyTgwAMIbdhXsUve5CGdoeEYEG6fa1hnoY4jU3PxneFqtqIZXXaHxf/BvXrzj/Q3v39Q8pY5aqfRbs8aaDrdasZe3twhuWh0pFzwMGDjiwC763MmwFXtyVXXap31Gjldum203UzBnbCP+keBr4ypYI/w4IqBtKLLYuR+4L2yo7rgDfHW6dKnHebxx1BEkJFGKKwZ5DDc5i1l89mI+bOZFTGhfjuc6K8ivO4CZv7HSllNqHmzyO1CDiSxhF7Z7sUJneABA4Qq2ZSn3eUiCvzeHn7u+eJHjMtHm2jwMkgoSFF+ixkBSNVbY1MemyH2CQvb5m19ORG+JMpiP5R+LNw1Uh97ifSICOzslBusXGAh9dAHNA0YazaH3gSfejKo+yKKuG0EP5XiZpkz3lo13PhaBpdWOcm9ZrrYGb+7zOVVxr042YBeL3579C5T7AqT0EosR/jbXNZ5lyJeJkc8OisKBWiIsR+bYkf351jUyMxMDO1+mRrws0deKbvz2YcKHziISe2zqgIuuY+yAn2C3940agcCgQwBpHO+vFaL87nDguLA5BFFLbhfEyfKXVflNYklTLmdKT9icJdn+zMzzCCjLS2YmORPf9tjl6wW4j2f5AkDfn83/7uhISR2n9elaPF8pEZp/QYuZQ2e7jQ1vS9hneQV/A3j1ZxW4Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1L00h9YgXyN7jKKlgrKBhEUhBFmXzWE2jHSlZkgbQCKr+0GZ5m86MkVOE0VsVr5gkGLnjA+H43F/BD4LiiE+XtQjJx3chrQNUdqWWJuQcKINhuEaZLdMev1jPSHJBjdYsxBH0ozEssgoQVkHrHtMxk1WPYG+X0cXLQREouwpv9GhXWAuSVA+ARx4Dti0U/lDEr7VrjZ/rakfE36djYVvzXd2BYjrdHys2X8tDzrGBXNMUK35cQB2Drk/6Te8cMUJSl7qUAxRhuP3xLYmFSASybsuAJ+pYbtA0LnQr0MRTz9JgAc5GnfIi0kLuuzCljL0XmytzE3BtkuEchWuX4r4EX1/suyt3+YwW03gDnouPiFSv2xIGXPkDK1eL6WNjDrwYcA1K6skRbI7xvkbCcU5YjZdmjyuPumaark0XZGXE7LLshXUXvAowArG57zXktEM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 05:53:33.0277 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8330818-0e70-4dff-daca-08debfa21d51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9630
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

No longer needed.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  2 -
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 53 ----------------------
 2 files changed, 55 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 2403a5d990f2..631315f89bb1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -106,8 +106,6 @@ struct amdgpu_userq_funcs {
 	int (*map)(struct amdgpu_usermode_queue *queue);
 	int (*preempt)(struct amdgpu_usermode_queue *queue);
 	int (*restore)(struct amdgpu_usermode_queue *queue);
-	int (*detect_and_reset)(struct amdgpu_device *adev,
-		  int queue_type);
 	int (*reset)(struct amdgpu_usermode_queue *queue);
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 4f285a8218dd..cf7e2ab66d10 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -219,58 +219,6 @@ static int mes_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
 	return 0;
 }
 
-static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
-				      int queue_type)
-{
-	int db_array_size = amdgpu_mes_get_hung_queue_db_array_size(adev);
-	struct mes_detect_and_reset_queue_input input;
-	struct amdgpu_usermode_queue *queue;
-	unsigned int hung_db_num = 0;
-	unsigned long queue_id;
-	u32 db_array[8];
-	bool found_hung_queue = false;
-	int r, i;
-
-	if (db_array_size > 8) {
-		dev_err(adev->dev, "DB array size (%d vs 8) too small\n",
-			db_array_size);
-		return -EINVAL;
-	}
-
-	memset(&input, 0x0, sizeof(struct mes_detect_and_reset_queue_input));
-
-	input.queue_type = queue_type;
-
-	amdgpu_mes_lock(&adev->mes);
-	r = amdgpu_mes_detect_and_reset_hung_queues(adev, queue_type, false,
-						    &hung_db_num, db_array, 0);
-	amdgpu_mes_unlock(&adev->mes);
-	if (r) {
-		dev_err(adev->dev, "Failed to detect and reset queues, err (%d)\n", r);
-	} else if (hung_db_num) {
-		xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
-			if (queue->queue_type == queue_type) {
-				for (i = 0; i < hung_db_num; i++) {
-					if (queue->doorbell_index == db_array[i]) {
-						queue->state = AMDGPU_USERQ_STATE_HUNG;
-						found_hung_queue = true;
-						atomic_inc(&adev->gpu_reset_counter);
-						amdgpu_userq_fence_driver_force_completion(queue);
-						drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, NULL);
-					}
-				}
-			}
-		}
-	}
-
-	if (found_hung_queue) {
-		/* Resume scheduling after hang recovery */
-		r = amdgpu_mes_resume(adev, input.xcc_id);
-	}
-
-	return r;
-}
-
 static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 				struct drm_amdgpu_userq_in *args_in)
 {
@@ -545,7 +493,6 @@ const struct amdgpu_userq_funcs userq_mes_funcs = {
 	.mqd_destroy = mes_userq_mqd_destroy,
 	.unmap = mes_userq_unmap,
 	.map = mes_userq_map,
-	.detect_and_reset = mes_userq_detect_and_reset,
 	.preempt = mes_userq_preempt,
 	.restore = mes_userq_restore,
 	.reset = mes_userq_reset,
-- 
2.49.0

