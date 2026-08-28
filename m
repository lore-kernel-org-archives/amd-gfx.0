Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C75C7C61DB9
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 09:54:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 525DB10E40A;
	Fri, 28 Aug 2026 09:54:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JalZ0x/H";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011039.outbound.protection.outlook.com
 [40.93.194.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77A5910E40A
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 09:54:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P4H7kqiubT3IniJCSMq83niFtMc0RU7Dyo5fvzJy1aid/0iSFNH9eoXvXmTFKMtn5S+zAWLvIydHUxAZQj6ivWeeLjXoKcNEXiLyQOWoBy/p4hHyvFTHvEfywgDrEmC1DBIYUCSbmVBq9RFdKTyGEIlBTnq75znNuyLQXD+dA3LZtP1sNZeGHCMlkoMa4aH4Shw2zFPzT6epw1U23kkIgsQBvcBwxGntnIpcVWyTy7q/ltAbkh5OJHQjkb9bbw+tnrnIQ/Fm2qia+D4F03gkzjd93YjApj+HBtr8PqGJ8S+fBOpUJ+9SnU59ui9Tjz16C+TCd4+SHIZpvrUv5KSC6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1AeXC0ryIVW6k2iX69yZhudqcQiLEO1TcIqZE8p4p7k=;
 b=SPrixN0PibTnaFv2EBWNgd1Kdfe6fA7uQMG1IuVnEwYrGiqD26W9kToNmCD/upaRj79LTwEwix6FuA8musO1omOSxLj8gz3hmDWCSvyjBbqweF0RUgzy2Bk//N+2hoW9eX9eVHDr4JVsX3U2UU1TeNoNr6qXtP3Xc8JZRsaqSAT9WGsoorpVmFo0vWLhbz1lnprU0lcM8iv2wrB3OmcC4kenrvlI7LMyNGEegU1dYBXiJUOpp7jrO6uyEww4VUkpxf+b9Gvi/XgDds/BVdyOWQt5Cg21DmO6j1KbP3g3UWOyYeDV6PvZy94KKyRtpMhwq1RnUywgvHuD7DurCdPX3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1AeXC0ryIVW6k2iX69yZhudqcQiLEO1TcIqZE8p4p7k=;
 b=JalZ0x/HEVN9X2nlSxwM7XsM35ZByJclWC7RG+miYf3MSfhnz+OdtdhXvIuvmq4TiId1MTsgxlCCdNTpPbZWn0+ChqvKLvcsyETHVqHZlun5JvKMQ553QBYsMVKVjNjGESgXzgE2XUUtVz3j7XuAPqT2hvwzNd8qzUvx/uP17JM=
Received: from DS7PR03CA0183.namprd03.prod.outlook.com (2603:10b6:5:3b6::8) by
 LV0PR12MB999092.namprd12.prod.outlook.com (2603:10b6:408:32e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 09:53:59 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:3b6:cafe::ae) by DS7PR03CA0183.outlook.office365.com
 (2603:10b6:5:3b6::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.11 via Frontend Transport; Fri,
 28 Aug 2026 09:53:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 28 Aug 2026 09:53:59 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 28 Aug
 2026 04:53:57 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <felix.kuehling@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH 10/10] drm/amdgpu: take queue kref in userq_create to avoid UAF
Date: Fri, 28 Aug 2026 17:53:49 +0800
Message-ID: <20260828095349.9797-11-lingshan.zhu@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|LV0PR12MB999092:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a44218e-7c64-4d7b-a8d3-08df04ea4892
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|10067099003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: QSmbGnJ8pLw1OeRu2t/UXaYv1L8ZQmHPeb8nT4ipDiGdpvIMVrpgKtfekenz49/uo9DthdyJTMDikDFa5XNme503MVlfjTXcd7l8Uajg0V6nm5Q2fzW1LgG/g0OqsUNVA3f5xk/vwjZlXUJoeH/aBOPvG2UJSV8h5RPD1Kze26ZOw10qdi0yYAHPwflE6jsJKOIaCNx3B7ERoAzFIdLm6B/94sDX6fSZoEJEzMXQ899SgjDNiulNguZlZ8R7tUt6QRBpaS9W8CzPWeBekK787QDwtWu635Rpri2lqMiZDzGkgTotM+fmqBouk9FsADQtegaqiR2M0oBPOFN8B5+V4ilTgKTGCv7JaHIs1zZ0EzbxFD4ScMsPb+OXCPfTmEN20dzB53URvo5P3D53VTmWMsCVaPyY9CuCqWcBD0b+ugT86IHPagztrmVwl4vYBShG7d8pnnr+7OD+2IC3827D9kNt1xlsEKIJHxZrYtEiMTF7HGzp4+mwOfJWXvgcoPntzTjBIyZZfFQs03/ZLwNQbZ/QSH8Y103UiOAcGxKXj6hpiWjX224k+AtsTbawXeXsKMGXQsoBnGfxUCyG8SZnKbc9OdcvUoHQNYF7FUVJ0o3V+NHgF5Gpz2MJiTeJyKYaomEGcLiOz4hqxQn7uHdbC6n/WZcNYfSgn7xuqFUXvX8ZZsRBiUeLNK9LQF9FVaXagDs5cqV5k6383/3EmO9kjw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0F8FxM8VKjBcErAPrEZ6spniTRS3fC58mR1evu8UGl+kMDyK6OBvmUWZuU/p8oZMrJzk9U0RBCN+JWDdKe5pmZn3STb4IL9hGiaSWK/mPvhUGNOpXp+g86I0OXKQJpJkqUJjwTFy6R3xWLPs0ZqxzveIETbppwNhprr2g8NJWslmfQSb2iI13UsVhiqT2Z4Zhbug20k6aKSdDLJ1nHq8jJqP+UET2YPriAojc+j5iYFiw2baDzJ7yHFW90tOH5wOr6qlQwOSj+ujiCC1kGUdR7sgWnHsVu49xwuw/mHLkWhdLYExq/NQkJ0b6SROrooliQWqDbKdqj8FT2skpSs8CUlbxXkhvUrKBBBi5kPcKZGAagBeur5MzI41gimoFZRvJjPnAb+S3kry2vLAhMOcT04kNoAK4hEuPqOvrjoH8lRU1saH1r7PQ5zn4L/IrAU0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 09:53:59.5524 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a44218e-7c64-4d7b-a8d3-08df04ea4892
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999092
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

In amdgpu_userq_create(), once a newly created
user queue has been assigned a qid and published
to userq_xa, a concurrent AMDGPU_USERQ_OP_FREE ioctl
can free the queue, resulting in use-after-free
issues in amdgpu_userq_create.

This is surely a user space bug, but kernel should
not crash. This commit fixes this issue by
taking an additional kref before xa_alloc()

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 21a9a2138fc8..83e6c87a5940 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -871,22 +871,32 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 
 	mutex_unlock(&uq_mgr->userq_mutex);
 
+	/*
+	 * A concurrent AMDGPU_USERQ_OP_FREE ioctl can free the queue once
+	 * xa_alloc() publishes it and assigne a qid to it.
+	 * Take a kref to avoid use-after-free issues.
+	 */
+	kref_get(&queue->refcount);
 	r = xa_alloc(&uq_mgr->userq_xa, &qid, queue,
 		     XA_LIMIT(1, AMDGPU_MAX_USERQ_COUNT),
 		     GFP_KERNEL);
 	if (r) {
 		/*
-		 * This drops the last reference which should take care of
+		 * This drops the last two references which should take care of
 		 * all cleanup.
 		 */
 		trace_amdgpu_userq_create_end(queue, r);
 		amdgpu_userq_put(queue);
+		amdgpu_userq_put(queue);
+
 		return r;
 	}
 
 	amdgpu_debugfs_userq_init(filp, queue, qid);
 	trace_amdgpu_userq_create_end(queue, 0);
 	args->out.queue_id = qid;
+	amdgpu_userq_put(queue);
+
 	return 0;
 
 clean_mqd:
-- 
2.53.0

