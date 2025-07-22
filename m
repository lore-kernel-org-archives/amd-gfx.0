Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7658AC83F1A
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 17:31:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17D6310E6E0;
	Tue, 22 Jul 2025 17:31:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4xOq2Bvk";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77E5710E6E0
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 17:31:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zCdWXqk3T56AXhoJnGoEJJDr6g6NAhLISORT91diwPZ5Q8YLqGDYVh6OheV5zyeyQSRbETEYh7ZH36k6mQzvz2s6SwxySm+GN5/DzfeACIn/bxd9S2XPwXOQOPy77a9/a7/Q5jaWU5fKKCW29zZxA/7PL9+CtmtcUeWEIw65UY8ON/wLz0L+J4BobWU7zJw0dR8PsHWbXU62G+BxL071IVj7XVv1uk31Dmh8+Ri1bBglShj0pA93ZUn2FTLklasrKkkw0kMG3fzot6gk3fkV2PvtF3AbwFVGooOpxjecfDt1NhEiblPMtdn5zjle8+LgWCQsEm5bJDrVzvE5Fw3oiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gB38N/TvUK6YWn9uVBQW+pLHPv9LRqiLqytGr+V52k8=;
 b=Ks6cV1e7A73/2uYe/jNiYdQox/NQyhMPhwf3RDrv1EnPIpSu/7/1HG7P/gG/yxG/UAGMTTqERbmslqGAdtI8iGDK4q3MYiSoYTSef6yRi/MMEmGQ03JKXh84Z/bC/l3ufv4hazP+XfBiKcPquPX9ouHkWxjy9rWgaE3roMqaxHwx4iiHP0RNyOGICVslNvaEWBB5gCRFePJ0HgxD4eYTXF3iC4D/AUWzluMNBrcrr+qdfMvrZtkBkHvIvU1+SDi4XHShjtm+KrQKZ49KRP5nrrqjTDLyL6HHAsREwzWWkxHIvSTSLqnw9Tvp7nXtGeBHV6CSjphZgyoenCH0RDG2LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gB38N/TvUK6YWn9uVBQW+pLHPv9LRqiLqytGr+V52k8=;
 b=4xOq2BvkCaumH46X3tlJ8SN/OpbXjZsvb17lSeQa0PTIy0SotNpm1fKa2Hl0D9dwMzk2uOoqrOdzlKi5wOUEGO6id/aMKhOJQl7V6Tkt43yrXU8cjAKO8+TjHunx5LRuhqZxKyEhZOu6YzNFRshxr+lWIsoYMdAureoZinkATvU=
Received: from MW3PR05CA0023.namprd05.prod.outlook.com (2603:10b6:303:2b::28)
 by LV8PR12MB9155.namprd12.prod.outlook.com (2603:10b6:408:183::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 22 Jul
 2025 17:31:31 +0000
Received: from SJ5PEPF0000020A.namprd05.prod.outlook.com
 (2603:10b6:303:2b:cafe::4a) by MW3PR05CA0023.outlook.office365.com
 (2603:10b6:303:2b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Tue,
 22 Jul 2025 17:31:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF0000020A.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 17:31:30 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 12:31:29 -0500
From: David Yat Sin <David.YatSin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Rajneesh.Bhardwaj@amd.com>,
 <david.yatsin@amd.com>, David Yat Sin <David.YatSin@amd.com>
Subject: [PATCH 1/2] drm/amdkfd: Restore SDMA queues with engine_id
Date: Tue, 22 Jul 2025 13:31:14 -0400
Message-ID: <20250722173115.436932-1-David.YatSin@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF0000020A:EE_|LV8PR12MB9155:EE_
X-MS-Office365-Filtering-Correlation-Id: e7376e52-9cc0-476a-95cd-08ddc9459882
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RyabTI+Wvy+TYO/QFBNwiNpWf4bmbCzLGjMRWRp8oruSeBNNdJTupANhHRyO?=
 =?us-ascii?Q?OmUHWhQMKal2fQTls4IyeSMKKJgUSRbCQdCkMZcnDmNm5bwjK/TA6GJi2Eke?=
 =?us-ascii?Q?uc047yRE8EP1Gm4gkj6PIM3q2BB7nx3KBPOOMQQ3pvqZnuxsfwZzSCToqzY8?=
 =?us-ascii?Q?c8hDtrcEqdoPiOWGpSINWRR4GPs1/nAP1IwDR2cuqFhVsdX6fA9kkGGEiuYr?=
 =?us-ascii?Q?SVpSodTYmbN/RXV9kD7jVE0xvFEvx//EvEwdv9v2YQltcS7mgBOZ6609jX3H?=
 =?us-ascii?Q?ARW2df/EqxoXnjdmwThQzG4wAVtI4Ee43PG+27qB9o+79uSl7/wSTyrTlR0w?=
 =?us-ascii?Q?shLV7P4ZAHN1R1MjIhSv0orQlqY4Dchw/W8EjytmmncRrPUHzuD9jeMY5r9c?=
 =?us-ascii?Q?3Gkyic9VBkAm8hR5W2+JgmHBvbCThO6M56TnqAU5HJkD3nAF4tczzeVTqziJ?=
 =?us-ascii?Q?ck2SUnPOex5j40H4f0DODaJcRhGWEMYiPIbxHcxsnzzgFcc+QSMc7VK+NRxy?=
 =?us-ascii?Q?K7k9D0xC5q32JuQXd67ry6GL8sqsSpPwDpSqSU8aUSmBfi9v0GckDrld3a3k?=
 =?us-ascii?Q?N6VJ0ELNh/1MIRSK2764mGWSxD8jhP/rl3d0JIipiIGQHEKCDZUwl3aijMUI?=
 =?us-ascii?Q?61jauCz7PE2IAaejhHUUpAcLMOLBqRb8M4UrZ0+AqIWd3xgWtr06H63n1UGI?=
 =?us-ascii?Q?aSgzsSOleoiX+Rw3PoBwvzB6fplZ/TslPoI/OjGTjQRJekvtKfZkkgxR7UHi?=
 =?us-ascii?Q?94gjTI+61tPfcBIKW7PJQSHmPL6e/zInHRXtkYpMJI0qB8CJ+v2lHDuXY6co?=
 =?us-ascii?Q?Rv4DVqtF0e4dVM59pBGaBBCaKsn/9VRPCcDXsBETrh9y3H5MgkLufGsshwEi?=
 =?us-ascii?Q?RKvICTKZwCswDSb80PXmNTDng76l9a08ATfImNnWZAE1Qh+1PXdVimnSaD/b?=
 =?us-ascii?Q?+7VkjCBouBxkYnKvT/Z5plpegS8XqfkWrHXN8hf5hKLvUHiZqTTR5qX4mB3M?=
 =?us-ascii?Q?F/Z7SvBQRTLhZgLvKAWScseJpdCJDFqeK33pLCE74TiPLTlNC171kcnhqShP?=
 =?us-ascii?Q?o1KVHvddt6LxHKCnkDTVfm1Eq9tKvhgRJIC9uurfY5PGt9jVZFkq9SIB7Fin?=
 =?us-ascii?Q?1AlbSOFv4MAEB/kd3301EZz0sVpW4dHzxaXeZP6C36BgyaorpwpbacxCQ6dA?=
 =?us-ascii?Q?XS44MJTTF3Hq83C+i+craWFgiS67MxcM8Ww+2HuTSzVVTAecjNdNIdyYXuyu?=
 =?us-ascii?Q?lkDwAx29cRw3oTtUwKo6bAPT2OsIu0Oks7YfLqPjKPteN1rPxXKqq3pgXnrL?=
 =?us-ascii?Q?nsuSoBXSsNed1EdshanwY5febhfz7ZcZETSASlewQYI9AjB4cNmWBUEFM9OC?=
 =?us-ascii?Q?aOHklR4gMn8kZzEUAcTUfugi6U2Q84H+r7q784fkTN0a6LFuWfdBFfQbTgGU?=
 =?us-ascii?Q?7ieID7kFKE+059QSUZZdG189nrDbFI8BGhs6u1YPxC9k2esHaS33OWuiiAs+?=
 =?us-ascii?Q?FWTEMTgaoyGdMx6Ox2VlZL/vDRdNzlfd4i/p?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 17:31:30.3751 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7376e52-9cc0-476a-95cd-08ddc9459882
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF0000020A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9155
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

Add support for checkpoint/restore for SDMA queues of type
KFD_QUEUE_TYPE_SDMA_BY_ENG_ID.

Signed-off-by: David Yat Sin <David.YatSin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                  | 1 +
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 67694bcd9464..837da09b5bec 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1261,6 +1261,7 @@ struct kfd_criu_queue_priv_data {
 	uint32_t doorbell_id;
 	uint32_t gws;
 	uint32_t sdma_id;
+	uint32_t sdma_engine_id;
 	uint32_t eop_ring_buffer_size;
 	uint32_t ctx_save_restore_area_size;
 	uint32_t ctl_stack_size;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index c643e0ccec52..b64bc47748f1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -846,6 +846,14 @@ static int criu_checkpoint_queue(struct kfd_process_device *pdd,
 
 	q_data->sdma_id = q->sdma_id;
 
+	if ((q->properties.type == KFD_QUEUE_TYPE_SDMA ||
+		 q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
+		&& q->properties.sdma_engine_id) {
+		q_data->type = KFD_QUEUE_TYPE_SDMA_BY_ENG_ID;
+	}
+
+	q_data->sdma_engine_id = q->properties.sdma_engine_id;
+
 	q_data->eop_ring_buffer_address =
 		q->properties.eop_ring_buffer_address;
 
-- 
2.34.1

