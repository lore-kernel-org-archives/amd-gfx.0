Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E3FC83F03
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jul 2025 10:33:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C581810E9F5;
	Fri,  4 Jul 2025 10:33:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vpX7QTQ3";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2040.outbound.protection.outlook.com [40.107.95.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21FBF10E9F5
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jul 2025 10:33:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rnS3PQOiNMHVUu+X4KBsBCYBErw+teTSjOLKsJc8BPxcW/8LYfQXHsm/KTuahwHdbBd3a35XgIgxkRCwOPnJofRZdxRGFa8yqCUPr80JVUVhj7Bd6G9BCSZFZJhNEdvanRi2WB13S21v6gjI7OyCRkrjagtl9nmgprRmlK7zk59T+KEiEKpFE2RRWSTryEX6vgtp5f5GXThjYNtYiJE6WO1/EFktHJ7yl9Cs0xAgGyZtdTMR9i94WOJHn8p/fbATRmhcDVs0INNY5IBfgOiHqiTqwyjDRs1CWVKVHfbE0OBWAQQl1uMp8JAd2HYG/TmcF01d614F3AGe9x6shOxH5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbZgaXeoJWUMt0XjCV/ol4rW7myBqW+A79/ohHK7WWE=;
 b=MPraw2WeETDeJqhkb7FhvbIqAu2sGVhBg3n7kNcPlyFBXLFSOAIkj7bUnGRA6YYz6e9ha472+Dd4JUEvBFrXdkFPpUr2ZQ/N2H6QFRB0ratEtuB/Zn33ukn3Vs7TqQW/xc2iZk0YA6k73Qr5028fwgvcB/aRPVKx+K6ox78TdiwirFUjHy5Bi8NMmM9EVYYFEzcj5sYEOkjzhh/s4IF+ZDoLAmIbfy4fnsXeFa/SJtqqdDY5XHKGHMuHUMKUmkmzGCLee4gMIDayoQlFH8q8Z61O1Qf8eFi+2xjghRqeMMIWJrF2mldh2m5yrpf4zMENohTzLUaxRH3I3aTDLdNMmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbZgaXeoJWUMt0XjCV/ol4rW7myBqW+A79/ohHK7WWE=;
 b=vpX7QTQ3zOev1kazWOuBUCbJg+WTchy0yuMuNJ7huxUdC8NvLFT99i6LbA05ynFsrP1WammU/eaYme+lNkPgpSrSxROODDwphJh1+nLZ/6SmKtD7PUtqNNOfaJ2RTFa7wxul01d9Dp7zkKsSVRSyIVLTr4nmFo2N5T7n2McDrwM=
Received: from SJ0PR13CA0070.namprd13.prod.outlook.com (2603:10b6:a03:2c4::15)
 by BN7PPF8FCE094C0.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6d8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Fri, 4 Jul
 2025 10:33:31 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::ad) by SJ0PR13CA0070.outlook.office365.com
 (2603:10b6:a03:2c4::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.16 via Frontend Transport; Fri,
 4 Jul 2025 10:33:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Fri, 4 Jul 2025 10:33:31 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 4 Jul
 2025 05:33:29 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v5 8/9] drm/amdgpu: validate userq activity status for GEM_VA
 unmap
Date: Fri, 4 Jul 2025 18:33:07 +0800
Message-ID: <20250704103308.1325059-8-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250704103308.1325059-1-Prike.Liang@amd.com>
References: <20250704103308.1325059-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|BN7PPF8FCE094C0:EE_
X-MS-Office365-Filtering-Correlation-Id: fc5aa490-0298-43dd-01f1-08ddbae638de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MonMvNQfK6t12x/kAt4yGBlaXlPGIIxF47IRIki/wLXpcdkokV2tjVWjcRZK?=
 =?us-ascii?Q?WOZZWavMd2xXB9fwKytzgT7iTTrQjUtxBaCy3BWZPkJS2FSfW4Xqx69YQCce?=
 =?us-ascii?Q?QD0QCFKQ8vQvu9pprpVWAGJJqZiZE/gkHZb3VIYxp88DB2s/zj1FDaMCi92X?=
 =?us-ascii?Q?+oHv5DIZ2wuytPt8OXzy0N9MXsm9E9LzGAlSaMqzDW/ZbQNrbZ2LdL30UwNi?=
 =?us-ascii?Q?iJXWAovJWkUjvD8/7t/yf4LKO7lI7t62Qe+Hf3quLywW3QE4coDQvygDFjjO?=
 =?us-ascii?Q?ePTNfIcRYaE6IDNe92gYGPsO36Wck96tbJ7iOoHe17uz4fKpECEdv0skYR3l?=
 =?us-ascii?Q?YlrovoUy2eruJ4YptYhNVMRYwayWRiFChqkhtrStpUtdFYeiCaiR3M8qqUkS?=
 =?us-ascii?Q?qhanvb4S8kn3znhJvjz2kmCrZtr7j25o3r5v9Jf+OQtoX5XeMdgBDozZf4vp?=
 =?us-ascii?Q?Y2UjA/V3WCcsn6Tg06+0G/BCa3O5m+Pm1fbCVvkxWiMt5Ws9nzs+VsGd3Ctt?=
 =?us-ascii?Q?REI2Rln/KRmqW7wBfFJjlfivmdYd5PQoPdSPnXz2+bp+f9O/XtjKVLpCpLG4?=
 =?us-ascii?Q?dJodqM+sTtReB1lppcrmiNNqQCZqZXhRvPOMcrTV82Q5uCSsNpZGGY0GlwzL?=
 =?us-ascii?Q?yvU57seGB/gA1SgtacnMlzk5113rFn+w0OXMjJ9YPSrdm4b4Xc2k2b+EOEG7?=
 =?us-ascii?Q?NDuxYApqvDfXTKQopIVKXxtTIqsFZ3OfPXcjXuUDLLIh17v9tUrB+nPF94SX?=
 =?us-ascii?Q?or7Mn3yyqOBXPx/tyLASeAWiJjGgYWnMyJ3FAIsf5aGHdgAw+SXEvQkaqVMM?=
 =?us-ascii?Q?K27N99pCQjxtDnEnlO/eNW1iDgIUR9dg5uzbdYhv+PtXt2vwOI9b90UnT51D?=
 =?us-ascii?Q?tC4VTPeN3e23IcmbpYKzEqtw0XnvyERFQezaHx3DTWF5UP3ww+tbFromukOZ?=
 =?us-ascii?Q?/tFvUf6Q27WBIfqKi3SEUohxrIMFADJR1yh81mI86ddf2fHeiP/Owm1x2DT0?=
 =?us-ascii?Q?FcKzFLVj7NwgeGZDa1VHZSX6j5WduaD2pvAa0UcuTju/pQq3FYLF8xSatwAy?=
 =?us-ascii?Q?hhYzk8pUemzONuCfP8kJWzRkyc5clyvbHmvZgCXcGQqm9CnFhntYQD5gGBRj?=
 =?us-ascii?Q?1FbjixAGc/mNVoftMcos0Xc4e1t665ydEKc6fYMG7JOh1fdYfi0ZDbgYTOGA?=
 =?us-ascii?Q?OAIrcDCxb9qfzSUZY3SKJ8AkxG3ZNPoLID5fIg4dQmqFGyV7UJMVVLRb+Ozq?=
 =?us-ascii?Q?kK6PI4RFm1fDsQLmcOx2Gtm09wB1HLziOP/XekryfZByQDsPVpsM9xpJRCpR?=
 =?us-ascii?Q?rRkxOsutrDjxE/D3D4GPwS6oM+u/jh20Mu6AHtxwA1PH0eMMusIBrynxGAYS?=
 =?us-ascii?Q?H4DZOUyrkkjaody4kR5RtbupeJI4PEZ6BZIO2EXkkE6lJVTVSO0e5inB+9gb?=
 =?us-ascii?Q?46WX6lODFUzfpEklBAT0pEXKJRK/b5KYLy6G0CXQiCPzofR8lwPdYBYBP9gd?=
 =?us-ascii?Q?A6289DbDc4Rtj2wPHgfn1/6W+vNO7NgWcoDy?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 10:33:31.4452 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc5aa490-0298-43dd-01f1-08ddbae638de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF8FCE094C0
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

The userq VA unmap requires validating queue status before unamapping
it, if user tries to unmap a busy userq by GEM VA IOCTL then the
driver should report an error for this illegal usage.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 16 +++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  9 +++++++++
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 30838e5279bd..221292b6417a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -281,7 +281,7 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq_mgr,
 	return r;
 }
 
-static void
+static int
 amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
 				 struct amdgpu_usermode_queue *queue)
 {
@@ -290,10 +290,14 @@ amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
 
 	if (f && !dma_fence_is_signaled(f)) {
 		ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
-		if (ret <= 0)
+		if (ret <= 0) {
 			drm_file_err(uq_mgr->file, "Timed out waiting for fence=%llu:%llu\n",
 				     f->context, f->seqno);
+			return -ETIMEDOUT;
+		}
 	}
+
+	return 0;
 }
 
 static void
@@ -509,7 +513,13 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 		mutex_unlock(&uq_mgr->userq_mutex);
 		return -EINVAL;
 	}
-	amdgpu_userq_wait_for_last_fence(uq_mgr, queue);
+
+	if (amdgpu_userq_wait_for_last_fence(uq_mgr, queue)) {
+		drm_warn(adev_to_drm(uq_mgr->adev), "Don't destroy a busy userq\n");
+		/* For the fence signal timeout case, it requires resetting the busy queue.*/
+		r = -ETIMEDOUT;
+	}
+
 	r = amdgpu_bo_reserve(queue->db_obj.obj, true);
 	if (!r) {
 		amdgpu_bo_unpin(queue->db_obj.obj);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index f042372d9f2e..c8cdd668a8f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1929,6 +1929,7 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
 	struct amdgpu_bo_va_mapping *mapping;
 	struct amdgpu_vm *vm = bo_va->base.vm;
 	bool valid = true;
+	int r;
 
 	saddr /= AMDGPU_GPU_PAGE_SIZE;
 
@@ -1949,6 +1950,14 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
 			return -ENOENT;
 	}
 
+	/* It's unlikely to happen that the mapping userq hasn't been idled
+	 * during user requests GEM unmap IOCTL except for forcing the unmap
+	 * from user space.
+	 */
+	r = amdgpu_userq_gem_va_unmap_validate(vm, saddr);
+	if (unlikely(r && r != -EBUSY))
+		dev_warn(adev->dev, "Here should be an improper unmap request from user space\n");
+
 	list_del(&mapping->list);
 	amdgpu_vm_it_remove(mapping, &vm->va);
 	mapping->bo_va = NULL;
-- 
2.34.1

