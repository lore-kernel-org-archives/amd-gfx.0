Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E96C88E5C
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2026 02:41:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D897F10E4DE;
	Mon, 14 Sep 2026 02:41:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IVpUocbw";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011045.outbound.protection.outlook.com [52.101.62.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7402D10E4DE
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 02:41:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hHvyNx6J9lAJa45utZeO2cqfd7a5Z0IySUPksGuTMlElEh5skNAKfa8ZulZVudqJmxWar8NXJxf2kU0j0ndquQLybN97qyvpX+lMHfiTAuaJReLGHIb0ZEsJ/mM6z2qwOc7R4rld+SXgpDfsXJf4iiR8MeBOIrR9wMH/Ax6b8+RjHrjJbKTg6jGaxNneKa3qCbI3DOMNVcx1bNkZ+pgnPz1h3AZjdU0Awifkvxxl0OOVcnDMsxTb8/UKVPCA1yNjC6N2fEcWJYVF+JLUo7B4OEQuauOpij84y1remsZa4aHX8W7BuFPl+AhGZIuxQVFzTdFJFKJJOu7wFT7QaE+GXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LesDkK6HqD3r+VvRCjh1JvTIMDijNN2oXNfgyBmJQeA=;
 b=S7koa5ZfQbwzz94Ib6HbyFayecnp67VeQYFUr1zK4NOfeNZsAZ+u2EF+JZ7V195Q7r9HoVNXTIiMxDPUuGFBLMuCPmFF0XgzGhd0uGDUZxiGOt8P85BsMfi95rL3ikN3H+l8t4QWHw5Qdttp3+SsWVy/lr9OR7Swg++HWsNLrmU7vqGQGV3xOk2mKUUMWuXdbaCxnOYqS/Uv4khT2QHnay/CJVMUowvomaFyNjlkr6k/rxN+rWv6JvYVvHqtmWtdvyZIRmn3k2zsJx8Bj+6VS/cO6R8ZbeXUh4MG+Upg2ibnOSy3YFPDp4IaWPxImtcu62rooPyeH4LzWcVLxEwRAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LesDkK6HqD3r+VvRCjh1JvTIMDijNN2oXNfgyBmJQeA=;
 b=IVpUocbwL7cF+avbqhAmSRzIMtNGp1arkRkTy9d1cGAn5yTHyx8n0+94IwwU2V89xRTiq253lPWoQTDW3CiVnsr+5MZ0jq4uHdPaW4Cpo01cnlTjRgeKmcJYRdwD56XR0nm/VJfi7nRGd/i27Mof8bl1E7Jxlwn/wa7MbnuqS1o=
Received: from SJ0PR13CA0206.namprd13.prod.outlook.com (2603:10b6:a03:2c3::31)
 by SN7PR12MB8028.namprd12.prod.outlook.com (2603:10b6:806:341::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Mon, 14 Sep
 2026 02:41:42 +0000
Received: from SJ1PEPF000037B6.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::7f) by SJ0PR13CA0206.outlook.office365.com
 (2603:10b6:a03:2c3::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.8 via Frontend Transport; Mon, 14
 Sep 2026 02:41:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037B6.mail.protection.outlook.com (10.167.244.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 02:41:41 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sun, 13 Sep 2026 21:41:39 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, <Yifan1.Zhang@amd.com>, <perry.yuan@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: destroy mutex when tearing down ttm buffer
 entity
Date: Mon, 14 Sep 2026 10:41:25 +0800
Message-ID: <20260914024125.443258-2-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260914024125.443258-1-perry.yuan@amd.com>
References: <20260914024125.443258-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037B6:EE_|SN7PR12MB8028:EE_
X-MS-Office365-Filtering-Correlation-Id: cc8975de-aab2-4369-43d8-08df1209b545
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: KBjlskuLT0gykWV/PvCUzPLEYojPrcfpNYElBat7Tdc/nRMx6xZSuoPERLvmC++MNkPbpDb7VYziJ2dnvttXoGMeyeEUYQtewVVDM8XMKaxqm7uM2gjNW50nn/Sd1tEDl4SYRyOoSpM7PN0B5Ol1JCdATUJ2jBGcEvwarkPxllENYXVFZWue98dBsRpLbpE7r+BOCWFYiyiT0b8n8/Mf8zLMAl7FuIImGNW69O0/PIwzQcypKNyJbuvdBJ1tLrZlHc+62qgmMtb7XoFu4O3nR3ryXa6xl+uOEbffUGlETrG13lYPbwMDt8nonu1k5dws19R4Z+1Yo/kAa4YYk415KsVT+23Bk+NF8dd2YwMAJ626aafgi2cnG3sr7Xj06ZKyNb3If4EcnuBiN3SRH4nOI+3Ct0ZUCaFhHU8x6u4iU9IuGZD8k+ONy3ErMBwRddlHtgrgJo5AH/BT8ZhvM+ccM0nh6NjFDRZXbuZUAQG7DItFu6GAivsvtzbZn6cqwS0TTe+3GEWL7EtpJJzA1Du69gGgHkEwL0OwWRyUoTCEqH3poINFYpZ7koN2/TKykHDdHto8t8NGlO3TVKd1e/CqYFEA9Q5IgmQtJEwEZODffeZEFxr17IZud8HhN/EDtwAtoW4LFWUADGOGDrdeTull82aT36bokfvT3BKW2ud2cAuCcNMqrZMK8AYqYzeq1IzBZ638kI9usV7dJfWwlARecw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uRW0bVQMfiQV4GZyPetTBC1PIehLPtfYo6zwzqIqXoO7zUQOVVNlk7P0BGkSXHZg7oEY9reZdmgZ0Zzn6kRQZ67LojrKVfQflSO8Yg3/NWMLCrTWhOYjzmqRAo+71wYOt6hjVMmbce32RrKe3dedvodeE9Z0X4KQOS5h6amV2kGC08N9Ta2rwnEnjcyV+kdjL++rB6nPv2rPFLBygmw0ulJ6CCAkQSepZHAxhyqtvWvtkeu8vfff0jgjILOUhvw0U+qv1r+rzTk9DhefupbbC6YO+UZpRnVZM7vp2lB2bxwQtZfSORIoMLsf3/sZI9jcz9ZEHOUOKk/RdXPok4j/h6SAyfaSP8k1oHjte0t+tKAcx8TlgMsIRn77JglACsux7TkUM81xLiQyc80hagjxUa2tdKWBwkgk45JEeCIHgaz2G4I8YtRWavi4AYnIeoOd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 02:41:41.3845 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc8975de-aab2-4369-43d8-08df1209b545
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037B6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8028
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

Pair mutex_init() with mutex_destroy() on the GART window allocation
failure path and in amdgpu_ttm_buffer_entity_fini(). This is a no-op
without CONFIG_DEBUG_MUTEXES, but it keeps lockdep from seeing a live
mutex after the entity is freed or re-initialized.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 5465787f730a..a083c42eb111 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2092,6 +2092,7 @@ static int amdgpu_ttm_buffer_entity_init(struct amdgpu_gtt_mgr *mgr,
 	r = amdgpu_gtt_mgr_alloc_entries(mgr, &entity->gart_node, num_pages,
 					 DRM_MM_INSERT_BEST);
 	if (r) {
+		mutex_destroy(&entity->lock);
 		drm_sched_entity_destroy(&entity->base);
 		return r;
 	}
@@ -2109,6 +2110,7 @@ static void amdgpu_ttm_buffer_entity_fini(struct amdgpu_gtt_mgr *mgr,
 					  struct amdgpu_ttm_buffer_entity *entity)
 {
 	amdgpu_gtt_mgr_free_entries(mgr, &entity->gart_node);
+	mutex_destroy(&entity->lock);
 	drm_sched_entity_destroy(&entity->base);
 }
 
-- 
2.34.1

