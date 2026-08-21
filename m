Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB027C5DF8C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:51:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64F5010F427;
	Fri, 21 Aug 2026 19:51:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zhAJIhgw";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010004.outbound.protection.outlook.com [52.101.201.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7327810F420
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:51:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yXbxXeDUly7YN6gPSYdMoI0b0VG2qqnZaNnoBXYoWWBuqBlN9x1JmDOmW28caKVcXAdyOBgLt7kGLoT/gx3VgnuvmDAKF78sd2TjiQDkqD+I5XVLVNbInSpKkNmgPp7hUPZRYKmsbGxRothPsI5yFHkXNzG7lnTtVZ7cQ2yDomaypfT88sGp0iI2IFC0v6Ua6F4N6YGmYBz14mfc3BJjsQoclnN7kgWhONzmfN6voMB/P8NHQcmdQWAReiu62hfQ2RICY6sW5EwglnQBwTHBLJHACPb1prphn9Z84R4cmX64umHnPUhsu/NijyGYhbgVu6OmzxKzAv3vAyYyb83hFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sr8VWGxUvWJZJs7zVsyVBGtSzeSA0XenomLuM2A4eps=;
 b=IxXuCr464EPZu0kM09JiK8YIWFEBIiR8G1V+dP8aQloHlvWviGUdMujL4ytMv/GJoXG8zDBVMuy2k64XHypa6+L/aqF2/+gPaj6UQ/vmq8ElbbO3cZkq5+Bs+zp8tLsyQa0b/oqAGxkybL9lJ9mvy2eEKHbwArrOiqiOrgMkPS70+pTDWoliwdhvZ4L4j5pB8Pk1RuzJPugcTco0MxX4UqCSEwj4Ylheyl2F/wSseeVSGs3zF9NRIdvtasVryDSoTNqSIoDM80bVdEbSOfK1JVZ0c5vTKdO6gc5q5jhWijknSPYZSkOwSZakC+2BPtymhVIgT2ensrvZa26+uog7/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sr8VWGxUvWJZJs7zVsyVBGtSzeSA0XenomLuM2A4eps=;
 b=zhAJIhgwNX9tGNGLsugDr3KVT5TsKC2+RXNczm+8JAgFCr/gftnZSmJiQNEJk5Yc0mB8Jai6ZA3gfxRudTykgwwiwcY2zGEm98oE13t0DGytFT+nOXltVJyAiiXXic4ExdsnPACTfIfkgOn1Px/18C1I7ZKSLftsjNpFDz+PDe8=
Received: from DS1P222CA0008.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:454::13) by
 PH7PR12MB9075.namprd12.prod.outlook.com (2603:10b6:510:2f0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 19:35:57 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:8:454:cafe::51) by DS1P222CA0008.outlook.office365.com
 (2603:10b6:8:454::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:56 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:51 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:51 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:50 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 65/95] drm/amdgpu: initialize UALink importer node list head
Date: Fri, 21 Aug 2026 15:34:28 -0400
Message-ID: <20260821193458.808626-66-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|PH7PR12MB9075:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d6a3101-96fb-40e8-d00b-08deffbb6c14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: YBJLqFGYiM/RdYfYOri+Dj2bHGcFwGroBtHIHYYbTw9Lghks7rE4dEWUsyB/r94K8dPxf4PCmsmgiXlnqUgFpxME5UrN53Qlr6KwwOhaVXL06/e8dV+c4YFdMEXSoaNmqzJB50lDW4mMkLjsuelzqh+x5JWvUj95MQUssY5T4B8oQ5Izdf6FQKao0WRG+7zx28vkMII60ao6vw7XhTYM9wWdyUXcLfnKQ26V88saWALR/MDYixXEieYt5mq0tiPE32MRDOSPDvrabt1DIJBfsicEwF+zsAsscQ2xvk8J3k76tjZ4ibpcTFNXib+hH2nDQjN2qubUWhqO8w64N11gIYVOCRcYSjrqOKjiOCjRmyh5LgSoAg6QRcSlRDz0GOHWWfEJ1kMLhKMIAbKxGfRHYsjYjDO2mREcXLTnNUgIPtAfkpvegHAWXEZyP2J6C0JRVS/KmoBGrWgC1RuU3EW21PRrAPeBE/0QuLWHHEwmKhOC03xMycvhtUUY7TNz71VmrhE7jN4cyJ4TyP/Z/QkBKeaLKw/hb8K20PXEHUV/RNhs0jBDtAxuKcW6vZYtfLQ8ltQDZEJBdZAZsfdlLWz1QN+8dZShB90MWYarAw1vh2dj5PEHrIJJ8dz5CE9eBkPMTI6LB8fctvXAdClQFTDQPrqhv+qIaX2e2tUn/1V6ktxLMZV015tcUEqVYLohFhTmf5Lp4qoK/waKGFXUWnB3uQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hQS3weMmDp8Czws77pSFRFTU4kBBDuiTzwkD2XHh5NjvQvWP/ZUxq1BYE0xCddU3A9g47cLg7+JHO1OvCctvFlNXYuKdSY+I4DV7Ulm67exIzSAqH4wQ3mkYah4TW1LS08V7jfOe8LOQzV2ddqiMqC2K0ibgWRALVThHLd2KAkOIHaQp1lt1bbd5Tp0MZHZfjlPXdIe7bGAtLK8bgdLXdgHm/zzV+I/W11jsmecpzMaN6st2pGWc8LVicWLb7xVbiXlikTrJ0LxNeTCkzZx+h5f5wE10lrdUdVSruhG6JhH8GC+r1+POjuk3PLYNjEKXP8yLmnsIC6qAopn1FX6ilaPdHRSwt7HH2RdzvdSvdJOQirlM92AtQdAIJoR5lBUWmgmshzuUelIT6pJMnF4gWw5JZm4slFgRO/Z7jjEaMnxfypdzrL/f9hMOoqhxJiyQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:56.9609 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d6a3101-96fb-40e8-d00b-08deffbb6c14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9075
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

From: Mukul Joshi <mukul.joshi@amd.com>

Initialize the list head at node creation so list_del_init() is safe
on a node that has not yet been added to imp_handles_list.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 2d1d4eae5b242..b374cb6b05352 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -3216,6 +3216,7 @@ int amdgpu_ualink_import_handle(struct drm_device *dev,
 		imp_xa_node->node_state = AMDGPU_UALINK_NODE_NOT_READY;
 		imp_xa_node->handle = handle;
 		init_completion(&imp_xa_node->npa_done);
+		INIT_LIST_HEAD(&imp_xa_node->list);
 		kref_init(&imp_xa_node->refcount);
 
 		/* Take an extra reference to store in the Xarray. The error
-- 
2.55.0

