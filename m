Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2EB606A319
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 11:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=34oCdbFA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83FC610FD34;
	Wed, 21 Oct 2026 11:09:36 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011060.outbound.protection.outlook.com [52.101.57.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CE0B10FD7B
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 11:09:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j0Nor40kjxMb0fQRoESCI+Srjk+KnSTHEEmPB8GVRzDDmb0/b/d5JK4fLQk+XyHieSNcrL6jUli6wMSv3WochOgjzlD7NAOJr6q05NKnT6FfnE3P5W/Qo0E+FYeZQvKpz6N5bV6XgcFnzeofwrHAeobj00rr8rFWeWMtCfMR3tVTKOAS5QRZ+1kjEnF5JA0LCIkV9wF4K3sQQdhel0DvheqDnTMvaMUUmNj/07i1UWy0TQ+hNBuHGblpuNCpW0VvnAExvI/SyKj+dCao1RU/63MYMz/1rVrrZBthJ1Hz67uVP3Ad2t6lGyX8xYvuDnmSYizDBhZnLIpCpnH7O5qtxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=znlrhIXIyLlVcd4QAXWmlGtkcDdxMcrj86Bvf2KB/Ag=;
 b=rPiJzYJP0iNJEZeXO7vC8cOLEyVCiqRRUGqtoY8nMK6NCa0bWCtU1CNZG7fFzTmjCSaIMIwkCxd6ExhEG8oO07HGDeAXWQZFK3YOcTq/dQgmrNHeBm6HlPw5o/HzMl6misoc1TnKOSe2PJ6BVnCgwskfa/ew4886BbDDuFlaRZ8Y62n/+xuc0rw2rGRfJW4pBpHgtG+DaJZ1youWd+aq0qz88YFb3FKj1NjL6CMvXdywUs2sQ76pXD1i/JF9ZeMAKcl6rVwmibMVOvbQBwoKfyXZ5a+iN0cT4ND9vQps0pRPGlK2NLq9S2wuA8j9KhzRSUCnWYbAMbOWTVW+0Pj/kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znlrhIXIyLlVcd4QAXWmlGtkcDdxMcrj86Bvf2KB/Ag=;
 b=34oCdbFASnd2AfJcEJRbNXszBmAzk16fwyjYXbkkcDSqwdb3MByARBGAYCNT9K+1dqMh1TlSm4Wnl3FJy2/MpFgHaoulKwnxNNWnitVYprVQ6Ii2aIDU9BFTeOjbV5J/P+PCKloeKKC2T65RB+p3bvmI4YwQV4kEO/K1ryZly5c=
Received: from BN9PR03CA0520.namprd03.prod.outlook.com (2603:10b6:408:131::15)
 by LV3PR12MB9354.namprd12.prod.outlook.com (2603:10b6:408:211::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Wed, 21 Oct
 2026 11:09:26 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:131:cafe::39) by BN9PR03CA0520.outlook.office365.com
 (2603:10b6:408:131::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 21
 Oct 2026 11:09:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 11:09:26 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 06:09:24 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>
CC: <Benjamin.Welton@amd.com>, <Ray.Huang@amd.com>,
 <amd-gfx@lists.freedesktop.org>, Zhu Lingshan <lingshan.zhu@amd.com>
Subject: [PATCH 02/12] drm/amdgpu: introduce new helper amdgpu_userq_xa_find
Date: Wed, 21 Oct 2026 19:09:53 +0800
Message-ID: <20261021111003.3371005-3-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021111003.3371005-1-lingshan.zhu@amd.com>
References: <20261021111003.3371005-1-lingshan.zhu@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|LV3PR12MB9354:EE_
X-MS-Office365-Filtering-Correlation-Id: b7ca018c-ceb1-4562-32d9-08df2f63c528
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|10067099003|18002099003|261009223027099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: MTXawaKE8Vj3OINrROpt9X5K12zE3wPIQ+HWFQejeyD4n9JmdJKMrlHwGk8FPOe5/3bL3Lkdnqt2Lnl+ioWaT5L36B2tAlBULFg7+COreVH1AQ1kKtD5QAC7CTYbLNSL2UI4q9LlPgU26uBIE5uh7S7UJ81INvcgy0ZNUdbNpmSRxoiiigzpuaBiJQd7PMYY9s+1wc+25tWELAYh/Syk2TfACodE2L7Zr6rODcdUlV2Q9o+QRA0LiZV6gwBeIKU6T+MQT+kQ7b56F4mUwIK3jshI1llWFooLygrogjaSbehFsFfXu3vz88JJUdxez5YiUY1GJKGKY4DSmnyOsge5G10gug7hGnvnMSYJbmhNw+ScCx0/5wpt02iqLL1X3ox1mNMyUd9huInu6zYPEDuHvjDnEJMED54WlJ/55a5sBLSQPvYSg7cBqdsJ0nWaVSennqj++O9xxkYqPkW/nIgXMVXJzEhNehZnEJVaWgJgkbdwtd1sNDB4ZUdbn75rtimWwb87AX6T0nlneRVWOc6bmJMTG7WabtpjlfdXYCsZDhiRGCD2TBhOsp0lpv3S+k8sxSh7jtursxLce5YKuM3QPr42eBw9rvAbeR92kRL10dnuqYhHo7Q6vGbze8cSM0CvHd1jbko5pUSrDtuiUfxtL2YSK3R4rQuec1NgJXkhoGzrqSRbDIT5V0WZ8yV0Nfl6m4JclGc2Q/5FDHCJjn8tPw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(10067099003)(18002099003)(261009223027099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0M9yf0eLe3ZuaM7Z6qbrGAiLkLRSILtdFqMNginOad7MQR0rvGk0lCKittUEW9iW3HBRDHBmWagx5oepPIKAeT6ArMKD4XE7DzgMhpRsb1PHX+FQDd7Vt22srJjUQ+JZvyYlTec5xGhETKuzeAT2gVUS0PWQwd4SC4zUFEFn+xQWmn18xg9ETU2foq2OcJlTnidxDwwfSztcDGwI6pX9U3YW/Tp76uzd9i2vz91FWCiopInlshNePJQlo8Y35XsE5LBJDXx7YjkXmlOkT8B3D+e6aN+9h++yAIdrHuvjmeVCZ6zV3JSQhvtKiQEB93WqrWEUOQl99ghKTawWVPNPVIHQ/3fQo//0VfHUgme06ZaIz5sy0eidiAkuE2K0z53SsWanTeHURSbCoIg7Gg1jkDGnAdCRTABwQvgG/Rkug0y7ooV2qGamOrtdzefns3h4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 11:09:26.5493 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ca018c-ceb1-4562-32d9-08df2f63c528
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9354
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This commit introduces a new helper amdgpu_userq_xa_find.
This helper finds a queue from a XArray which has
the lowest index that is at least the given index,
and hold its kref.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 48 +++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index f592aa9b50c8..42039d3aaf77 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -653,6 +653,54 @@ void amdgpu_userq_put(struct amdgpu_usermode_queue *queue)
 		kref_put(&queue->refcount, amdgpu_userq_kref_destroy);
 }
 
+/**
+ * amdgpu_userq_xa_find - search the XArray for a queue
+ * @xa: user queue XArray
+ * @index: first index to search, updated by every iteration of the search
+ *
+ * Return: a queue which has the lowest index that is at least @index,
+ * or NULL when no queue was found.
+ *
+ * The caller must release the kref of a queue with amdgpu_userq_put() after use.
+ */
+static struct amdgpu_usermode_queue *
+amdgpu_userq_xa_find(struct xarray *xa, unsigned long *index)
+{
+	struct amdgpu_usermode_queue *queue;
+	unsigned long flags;
+
+	xa_lock_irqsave(xa, flags);
+	queue = xa_find(xa, index, ULONG_MAX, XA_PRESENT);
+	while (queue) {
+		/*
+		 * If found a queue but failed to get a kref,
+		 * it means the queue is in destruction process,
+		 * so skip it by continuing the loop.
+		 *
+		 * If get a kref of the queue, break the loop and return it.
+		 */
+		if (kref_get_unless_zero(&queue->refcount))
+			break;
+
+		/*
+		 * If the index is ULONG_MAX, we have reached the end of the XArray.
+		 * Break the loop and return NULL because ULONG_MAX + 1 = 0,
+		 * which is the start of the XArray.
+		 */
+		if (*index == ULONG_MAX) {
+			queue = NULL;
+			break;
+		}
+
+		(*index)++;
+		queue = xa_find(xa, index, ULONG_MAX, XA_PRESENT);
+	}
+
+	xa_unlock_irqrestore(xa, flags);
+
+	return queue;
+}
+
 static int amdgpu_userq_priority_permit(struct drm_file *filp,
 					int priority)
 {
-- 
2.53.0

