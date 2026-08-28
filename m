Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7CD4C61DBD
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 09:53:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FE7310E20C;
	Fri, 28 Aug 2026 09:53:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GZGGbGOe";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010065.outbound.protection.outlook.com [52.101.201.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E21910E20C
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 09:53:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cyK01SaAK55bmp6bsOjfcSYXeXYrgSjdZ5zqNa/j3xoU5oZTTmQYxJXNgA7wCg60AmZ6WNKGqBW4OmYBBWh76Ksid+Ub9CbludiSRWUY6G/bJJPjgse9gsu/aBegpKu9mZMk6y1b0gFgR2kef7hhW0BWcuhcmZnqlV6uUqHw0YDoqu31NYG+Bx6r/bGeHEbsMAtZTmhJWflNagtiUS9n+UcTkLHnzKiM8IQ7CCwTgzTdifbmNzoe2jV15adASP05IneubqubRRd6KiFHIL9yazHlsow/YW6RC/GFwztEcgImBre9qAdT55/6PdlmQy4RC8xpIDFmpYWLCBSccRf3FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97B38uJBFUcLaKqpT8DZmZHyBDxkDiAb2RtIXmL9Fq0=;
 b=BI7kHzR0dw/9kPWsjFwlfcuxHNU5OQylAX76vnPcFFIaN5s53QSGLMYa9Dj6jyTOfZhf4AfG3u2GhoF13qBzHXshmQ+cQB56/TQz2YSVEeig2ZP7R/nkloilwibB9KRT5m3w3Oyzhgzp4N47RRqiZXeBnnnli8cxLn4YFnEWAwNmuQjOX72c8lspgLTkNlipk+7qoD1Iu6rMiw09IWglhAM4WJ88wCwUGNRBlnl9YbT6vgXrwSR5MgZf/z9wSko/cFY0din8zaZuirjN5HePuRHmTu6eq73DZ+FU9PFNOT9obZ99TddC6t57qaWyVA3JFGsKxrSB7GuPe5C6ucwZYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97B38uJBFUcLaKqpT8DZmZHyBDxkDiAb2RtIXmL9Fq0=;
 b=GZGGbGOeInKfEN//dApFSPlBWHKpnGVGSPLTYGnPfECxeCUWL5iO0wBpHWPcvtUy1z3tienQv6uzlTnDSGSuaUKUvFilDi7BvfxkbCDxDbMtfl5LQ2PjMmQd0MK1fQbnUe0w9i8jCNbr79TGF4CSVCjDTclWB1a3YUI8GiB96Gw=
Received: from DS1P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:242::14) by
 DS5PPF1ADAD2878.namprd12.prod.outlook.com (2603:10b6:f:fc00::646)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 09:53:42 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:8:242:cafe::44) by DS1P221CA0024.outlook.office365.com
 (2603:10b6:8:242::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.11 via Frontend Transport; Fri,
 28 Aug 2026 09:53:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 28 Aug 2026 09:53:41 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 28 Aug
 2026 04:53:39 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <felix.kuehling@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH 01/10] drm/amdgpu: introduce amdgpu_lookup_queue_by_doorbell
Date: Fri, 28 Aug 2026 17:53:40 +0800
Message-ID: <20260828095349.9797-2-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828095349.9797-1-lingshan.zhu@amd.com>
References: <20260828095349.9797-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|DS5PPF1ADAD2878:EE_
X-MS-Office365-Filtering-Correlation-Id: f74bcd60-b32d-4daa-520e-08df04ea3e04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: JqGoSByunIS9Ow+DUNycHHDRklhWf5jXS+3chrV1BeVHCnW+j0wZLv4qj9iyRRABNbhOCJl+hdwjlLRPYT01cgbnmU7B2+JN1NKWAe7y0q8gHR9Uh1BPlL+WWGmd1DFyUgvR5eO3Ui+ewyztzogK5fOez9y0lFIKVDKqVByCZ6vaFihAvRXUTIBYVnjgVK/ZOAomLmq5tZA/78fHghUPMWq2oMUDuO8dxv+VJFAjKh5qRodx+N0RmjaaCs0AMTw0KNFMMOuhbuTQG5BztfoaiS0zhYEleQj89+vgdeEMV3qB1MAuNRD3XUu/toEs/rj/XgCq9ObLnYGNfvK4mgXZPQDjb3ZsgcQXj7O27GbvmGuSwwsC4YV3opqhJWNdOzsw+9IT4zFockMmKPT7p7LFhKuDkNCLuNScMHX28LFI5sSpz47GtiiNLBvkVdNbhIptJb2/nTXpiUjls+TDj1v7E1Fbl/E6OWjoH5ZRADfZjKA3tn/bE0crYmJq7f2MGhlKf4dhFmbmuVM7RLUrBJw/VuV7iYyFnv3bI1HkbqkAGL4Drvf/rYxj55XdCbRy8Xm7FrtoPr78Ll/6JTpgSxPAmRwj6PHSRDDiTSdh+mo6dgfZVBZoIpYrHEwWZfK1Mkd4rjS29BuU4eXjk4FD/0a1Xd4Ey7PKs8kUMBxdVgG9M36f3YNE/3fUQyoSYMEZkWVugVAr7f/s/OjHgP9poIQyvA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: D9XXf0wZttBXmD0HrgqRiJafgOC05TbfbUijDQa23BNNBDjqsdYCOFERwLCOOmqlSbzJZeEh1ICQj84zktEsF7uQE3mZOLIIR58IGmXpIHzLWW+ajJk1EpaHXTZ5P+tOKf7bOcVAopEuqPvLNUna+jao8eaSTXbbCgdJFCVCu0HhH+8qqGimzFoG3e2jTQ8XT4Ia2n/eWKRKITlwst1iXtCHci3s4acyac6x9FWaqkfvTTVgn/q3ebEw9uOy4uYDMRxPu4EGkkBhtyGfm2dZVHI+6CoyZ0n8IC1BPqRXIoP5u5FFB0o/ntzYKlG/1O0bW6Y96KWXbxizzibIfettJAsv7nuaP1xu/Vg0srw4+pGiPARv8+Fbmgb9b5Y6WXjEqmP4z5FRars//F3PLSO/pEXrDxBD0hMQVay86CfQtPTrYM5LllNFGu7pLkXkT+JK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 09:53:41.8473 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f74bcd60-b32d-4daa-520e-08df04ea3e04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF1ADAD2878
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

This commit introduces a new helper
amdgpu_lookup_queue_by_doorbell which helps
look up a user queue with the given doorbell id
in a xarray.

This function takes a kref of the user space queue.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 30 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  2 ++
 2 files changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 0a816b3c5ff9..e0639f844a8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -609,6 +609,36 @@ struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr,
 	return queue;
 }
 
+/**
+ * amdgpu_lookup_queue_by_doorbell - look up a user queue by doorbell
+ * @xa: user queue XArray indexed by doorbell
+ * @doorbell: doorbell index
+ *
+ * Return: A queue with the doorbell indexed, or NULL if no such a queue found.
+ *
+ * This function increases kref of the queue, the caller
+ * must release the reference with amdgpu_userq_put().
+ */
+struct amdgpu_usermode_queue *
+amdgpu_lookup_queue_by_doorbell(struct xarray *xa, u32 doorbell)
+{
+	struct amdgpu_usermode_queue *queue;
+	unsigned long flags;
+
+	xa_lock_irqsave(xa, flags);
+	queue = xa_load(xa, doorbell);
+	if (!queue)
+		goto out_unlock;
+
+	if (!kref_get_unless_zero(&queue->refcount))
+		queue = NULL;
+
+out_unlock:
+	xa_unlock_irqrestore(xa, flags);
+
+	return queue;
+}
+
 void amdgpu_userq_put(struct amdgpu_usermode_queue *queue)
 {
 	if (queue)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 6412a7f7b6ef..8fc73862f64e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -151,6 +151,8 @@ struct amdgpu_db_info {
 };
 
 struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr, u32 qid);
+struct amdgpu_usermode_queue *
+amdgpu_lookup_queue_by_doorbell(struct xarray *xa, u32 doorbell);
 void amdgpu_userq_put(struct amdgpu_usermode_queue *queue);
 
 int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
-- 
2.53.0

