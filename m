Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C3CC43458
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2026 10:27:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40DA010E281;
	Wed,  1 Jul 2026 10:27:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e8NYauTF";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013021.outbound.protection.outlook.com
 [40.93.201.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C10710E281
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jul 2026 10:27:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sSvurLt9VxM9n3DUB2FDuce0CoIW140ecynYZoGTKekhAeMUp1i+6VkbBYxDrGf24/1h1FdaoA+Ziuoa4226dsscZ3mMjpDtoUrtG64OBARcyBUE+YbgiC52VzsktqfXJ1yIxvtJc6L4pQDvDrG3lc3zF+ki5SqK0MrRjzI5iIfRN7ceVrd4lz6cEpPQYHQvS8BK+Bg8UuJeWZww6e7jBsHE5jz8c9+7uyHTs/P9oL9RNw+gFyYwGujESmvpp6vd9kC4IeJ/ZChw7ZWTR9XgCC/GPL8BtuBIUinQKF9F9AaWDuavRi077Yx2tvIsXWkYFktW2EQXvDew2qBWWddcOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+jMbWndEacOtH5eOL38YnhBt/krSKkgRcKDBCk9tpo=;
 b=THRKHVWdYcHRxXLrEbJ69DAAmDXOOUDJyEOhk1ZqHLyALmx3ZveuKtJzXzX9wUIwrxRwAGN4seqAGrhx9VPBaKTswfPjOlimnNoPe6REal6NrlnzTCZdOHUPrTWx6qivBZo7e69GfqpCfcwkRO9NmaxC3sqXLlu1K2VCttefqySZ5PxXq7VxLsOPyuug1uaSq4qR1RjVkW9IEUjQFN5dEELXLSJMQD/eiItcgAMa8aDF5gzHspZXnKxhpVI6TUlbY6Y8RlVk/cagBHOms/QH9NnxACzjeQaknqk0sY7prRLYSog5lyhGG8CljcQgkfcdQljakLY677ejDti8rYyLfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+jMbWndEacOtH5eOL38YnhBt/krSKkgRcKDBCk9tpo=;
 b=e8NYauTF/Ix/jPRVxQlSe0KL8z2svz9lW8HQdAyI1n8MPAx18j90rjjo3BhyTnYaDBxtSUWM8rKlSFgplMieu/Ct0ajRrYiQdnFdoUO7Bj/TB8HPBwYKSvNo59fQGOR5hBX98sQjecsEA36TnyDQX7+MM+X0Jjtcz8P6oBMPmPI=
Received: from SN7P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::25)
 by DS0PR12MB7898.namprd12.prod.outlook.com (2603:10b6:8:14c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 10:27:51 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:123:cafe::a1) by SN7P220CA0020.outlook.office365.com
 (2603:10b6:806:123::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Wed, 1
 Jul 2026 10:27:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 10:27:50 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 05:27:50 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 05:27:49 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 1 Jul 2026 05:27:48 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: trigger GPU recovery when userq destroy fails to
 unmap a hung queue
Date: Wed, 1 Jul 2026 18:27:41 +0800
Message-ID: <20260701102748.1261029-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|DS0PR12MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eeae806-7598-4d9e-15ef-08ded75b671d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|1800799024|36860700016|18002099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: rINGWOuXulMDpRL3EJcLMk4NpCe+j+HRewzyPsm4ywM1rfedwb/Gyfv3zprBUBjkIJ6xegXYX1SFykqfF7gXSxABOsIbqEMloHx/eskWu2J4CRe65rRdhk6oAoMjOT6Uwm4j5Y0VAhlgl82+TLZewEEZ8ePZdZWbqfjxEIdHO5m/YYsrV2lmVN7BboudIrfV27Z/DHc34oEZipqm3FQvucRKUlpjaYJIn92DizA2Z9YMMTFJ9/oQkfbzk8kb80hkoRCZAuwO7JmPTMAD4XPneadZyu/7YERYQmioyN929DeZ3zVbzBmP6Mk8v9NcGGkcp848O8RY8tUZCqe10sDj2e7oNQiC0m6dnF+wroc0yS65BcaIAl8F9rVitP3szaFoVYEefs8jUn3dk3XiCOzfMGGqYyKn2RXhQXeFBOXuzq8bDhqf+q8eW5eHeKkglobSlcIScrEaNUhll1vXR6oWpfefty9jbim3it1UmnfXCcbAjXyQlshiwJhji3X+ixab7KV4xIIZuaIV5zbxiWBwpF3YItauMs/SmhMSK40za80R/H2j68HeMcEledfgdG9WsRZKKbq9QzPHYTdinSdB0ciL1yHzYQ9lVlbfyGVFSTwPA4YwzAQVNiY5xW7OcKc7tX9aBi1/pAbj4Z8oFxUxGE0D0qG2W4cS+4EPuzFMfRQjnKbuGBvaJjbQBM8E50nQmyl+2YOGSsEmRxnVeQueEA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(1800799024)(36860700016)(18002099003)(11063799006)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WIA+EIe2jqtyrXE+a1hyYVLFqTZ4GTV/+y/WNYv5tZ3Z1lTEdduQ+K8IHn0HsIUz64lX35m1zvw1DsV4qnMf6YHZBtrqtsQTSNg3tD/p/UyNUioB9VhFQ5dbiFprMDqZfDhdkGHZnhQsKAFLxh8u5WzrzTmc7hXj4y/YDe1o9mdLaMy1iF8eZh6oUvG4+vqrVcXjWgb/YzNDgCAkjq3Wb3XlVGW50Rb09/2KDAuTvFD4Aqfqi45KKIm68MSqfWdXWPdN99pvL3Q3mTLnKvheuY3IDUYmaOK/14bsG2I7+yj1OqviNBalY5QBzlh5EwjRrIRAUjwzhd6XzV7tfEPOpKySSdTDiYtgBWHFdGtL6rGpRxSuSJbmX0nsLAfztBnM2PrLcanG86CqlDs3NdYf6HK7N7SJz4D5WZvx5MptYJ4+Bfj3hh2G8Zg71bnkG46P
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 10:27:50.4520 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eeae806-7598-4d9e-15ef-08ded75b671d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7898
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

Destroying a hung user queue issues a MES REMOVE_QUEUE that times out,
The destroy path only logged the error and freed the queue, so the
next userq submission failed and forced a GPU reset attributed to an innocent workload.

Kick the userq reset work when unmap fails so the GPU is recovered at
destroy time.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index fb7e18c841ee..aa5cc5642e87 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -542,6 +542,15 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 	amdgpu_userq_cleanup(queue);
 	mutex_unlock(&uq_mgr->userq_mutex);
 
+	/*
+	 * A failed unmap means MES could not remove the hung queue and is now
+	 * unresponsive.  Recover the GPU here so the wedged MES does not fail
+	 * the next, unrelated queue submission and trigger a reset attributed
+	 * to an innocent workload.
+	 */
+	if (r)
+		queue_work(adev->reset_domain->wq, &uq_mgr->reset_work);
+
 	cancel_delayed_work_sync(&queue->hang_detect_work);
 	uq_funcs->mqd_destroy(queue);
 	queue->userq_mgr = NULL;
-- 
2.49.0

