Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B760E77188
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2025 07:49:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35EFA10EFFB;
	Fri, 10 Jan 2025 07:49:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FjYnvxim";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B860F10EFFB
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 07:49:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tZxd7riWbGQSBcGQnfvwbDGPS22AvaoT+P/ng0BwQAitQppe6+c1PWZVmZ2Ju4f3b4YiL+79Vly4YpaOwS+H4ElQebcQoR1QKIFtbooIthi3P+j+yJHQmu6pqv7h6JkHhP9uY+GpsRf8RKAZPqvAlRQcQ8JQVrm1ezkYRSBQ+c7JT46u//4fEzhDtSD5wedQAY7RzsTeeVFWwsaysSzn5hdkoPnBgwYAnQm2Laa08S0ATkDv0uygoO4svwskL25j/qI8dTpWDojgWb2KY6eioCjanGAr7TL6ZhrZpFolzhd+ed+uuOSj1hZ6gVVDuLuQH1qLYThpm8mCjDdR9nkA7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1mZIWmLRoZs1zcbfkZcDr3N+/QjRPJ+d0G25BXQKIRg=;
 b=NT77hnWpJjtOU5ane6rLcSC56zsLscd4+A8RSkIfjMmy/5JvjlO4WfZzjJINg4ZrVjVyX+p+gWXHRmKVkk3ocE9UC4YXAcDPj0oSBfA9sH8r3P+xXWnURGguanQyD/DlMryP1TetA+jNt947pL70O0B9LrayBfkYXtyKDlZNuXLmfuoAaV9EWiYMRYDTRAr4IvfKfRuiUhD5vVHyxHp8NCB0poRz9vHAMK+/u5z/8/ql/ysv/M8sAP4z0jH2RTBpU6HLgT4JjrSbDBQKRPFY1Yv2HPpcCpZDekHiqqS/H7lxeMdUIW72oQ17K7WRvKQkW3xUid4ggD3MUBofyfSq/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mZIWmLRoZs1zcbfkZcDr3N+/QjRPJ+d0G25BXQKIRg=;
 b=FjYnvximcXD0dZf9/fSJalxXaHBLrHAClUfTEtKPYuEse2ajI+MLFiJHorjFHvZLXt1MOAMS/0uOCBwdQi+h6fEh5jyQealD5j3rXJ7izsuISuQmerEhCPH1yjcwtMDbNXw7OYp06bk1YBiw1NESrdm0QHcbSZMSOPqt999Ujd0=
Received: from BN9PR03CA0643.namprd03.prod.outlook.com (2603:10b6:408:13b::18)
 by IA1PR12MB8262.namprd12.prod.outlook.com (2603:10b6:208:3f6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Fri, 10 Jan
 2025 07:49:27 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:13b:cafe::97) by BN9PR03CA0643.outlook.office365.com
 (2603:10b6:408:13b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.12 via Frontend Transport; Fri,
 10 Jan 2025 07:49:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Fri, 10 Jan 2025 07:49:27 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 10 Jan
 2025 01:49:26 -0600
Received: from emily-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 10 Jan 2025 01:49:26 -0600
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Emily Deng <Emily.Deng@amd.com>
Subject: [PATCH v4] drm/amdkfd: Fix partial migrate issue
Date: Fri, 10 Jan 2025 15:49:24 +0800
Message-ID: <20250110074924.1441364-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Emily.Deng@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|IA1PR12MB8262:EE_
X-MS-Office365-Filtering-Correlation-Id: 4158cd45-77ef-4bce-1e84-08dd314b4f24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OdRkBU+21HeLZJfZSHdllgQahgNfp6ruzsuHpUHr58aY20354e76T15KRrAt?=
 =?us-ascii?Q?0+G6fCPtuHzYgf2RotczExUp2pAez5jock/4cRGi1PrTio0glSpO+DjPyaDr?=
 =?us-ascii?Q?vebv/Od6+Ndlpo0xfsHfGT1hU1HKH+dW+2JR8joot+q3uFErzfh2Kv3tNJGF?=
 =?us-ascii?Q?157fah/w07i520QP4BydWQvCWKFOOZcMTy97idoBjNUiq8njWDhwf/+APQgG?=
 =?us-ascii?Q?RJp6eapcMlvD/srC56qhz+DbMmD8A/bNInESIu0OzMYJBQCG9U8AbF6N3JJK?=
 =?us-ascii?Q?3PfTW08gFkYP0Qz1CkRuf7rSomlw4XDEIrEUvpGEZJ0dsrFqRpDmemhkUfgB?=
 =?us-ascii?Q?iIlNZ+d93DARGLnfdY5iomh5132fGulftp0E793EzAVJdoitb+mdXfIKMG47?=
 =?us-ascii?Q?2gJcuDUjMSIkuL8+2BXiGJpBBno+XFxItWX0de7BcO97Jiwi2ZtEFQK6Y15J?=
 =?us-ascii?Q?SNaYbq/j6GH5lL4jPZHWrWjaf9x4Z+KMThbAlG9p9Zf2xr3OBrrpxWpWOuKe?=
 =?us-ascii?Q?U28GW9Dzp28S6sUDjcyRvQSSJtylfkvTJzcQ5555xPJSQjR5JnY3xapm9COA?=
 =?us-ascii?Q?Jx+XLIKl6OH/imtvS19HIUjI+S3JTcXdc5Gye9HKrGR9uot3OwxcjZe3ZnnA?=
 =?us-ascii?Q?ojfX5EEaNDsEouoNotzgFiCN75hqlL4rG8DlcFWxrbzhVl7GTaO4VwKI1/17?=
 =?us-ascii?Q?tO4bV2wmiKL+giH1pQNfPk9pe+Wc2qsszbwLIvlFSIFo+eNsGlxwVZLTMYkV?=
 =?us-ascii?Q?YOAvWrxd+2yEvOvfnJCCmgR5G/TNLHw9HiS2kl6t760POkzS6MkgqYzw7W1B?=
 =?us-ascii?Q?2WDxArM+ViC1g2zID9eJt+jMlw98Qs5KY88OnSlY7WZxf3QuiNqohmhrouoy?=
 =?us-ascii?Q?zN8pVvI088QAMoVHRTZUavKNBqjySH+srt4DxMOkG7Sv/InJkKWICZJWKcFx?=
 =?us-ascii?Q?9kKSx9s6I4XHssHbiCswThS2vgr+tWFoSpJ5yRNSeGqvSOO0+yj9U8LiU1f0?=
 =?us-ascii?Q?FvRV8YPYMkE9fCZqy/HaeWGA/AHlfnYYaaR19NMO90CiNbBhhZv3yPXJ/Tvg?=
 =?us-ascii?Q?vP9ejonDkukyiacfGVu5E8SREwZP2hnfM1lCEAdRwclWSXRBtzVlKj3yD4gF?=
 =?us-ascii?Q?gdyHkSkCwcmFwwkZhcD2cU90NaO2v7duOwQm9uPJLQ477ykP+IhfnG1ivmOS?=
 =?us-ascii?Q?bfzCx5o2g1AVcZlZt0Vxx5OadjkHbL7jwTDGgdERO7Ld3NLC6Au0B2nurZUc?=
 =?us-ascii?Q?RyNNhDVnmVQo2i61vdwADqrXEOvA6EEBPxwG//Q2I/UHNdly7NPbog9GnyCS?=
 =?us-ascii?Q?FS4i0hfYj5slgXeWtEnZ8Dcgmo4B+rkBtsa6JDpN5cmWvfRMqTgNiHZKIops?=
 =?us-ascii?Q?vjNSdZkRFM2kZSFCPU725J7so6U8vTlBa9ZzaUpkOvrROY1yotZAB1PS1n6r?=
 =?us-ascii?Q?JJzOyZ/Ua7SltCnhT3KknE6M/JNShYIvSUGrl2snrmYtfOGrmK84pA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 07:49:27.5928 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4158cd45-77ef-4bce-1e84-08dd314b4f24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8262
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

For partial migrate from ram to vram, the migrate->cpages is not
equal to migrate->npages, should use migrate->npages to check all needed
migrate pages which could be copied or not.

And only need to set those pages could be migrated to migrate->dst[i], or
the migrate_vma_pages will migrate the wrong pages based on the migrate->dst[i].

v2:
Add mpages to break the loop earlier.

v3:
Uses MIGRATE_PFN_MIGRATE to identify whether page could be migrated.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 4b275937d05e..bfaccabeb3a0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -278,10 +278,11 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 			 struct migrate_vma *migrate, struct dma_fence **mfence,
 			 dma_addr_t *scratch, uint64_t ttm_res_offset)
 {
-	uint64_t npages = migrate->cpages;
+	uint64_t npages = migrate->npages;
 	struct amdgpu_device *adev = node->adev;
 	struct device *dev = adev->dev;
 	struct amdgpu_res_cursor cursor;
+	uint64_t mpages = 0;
 	dma_addr_t *src;
 	uint64_t *dst;
 	uint64_t i, j;
@@ -295,14 +296,16 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 
 	amdgpu_res_first(prange->ttm_res, ttm_res_offset,
 			 npages << PAGE_SHIFT, &cursor);
-	for (i = j = 0; i < npages; i++) {
+	for (i = j = 0; (i < npages) && (mpages < migrate->cpages); i++) {
 		struct page *spage;
 
-		dst[i] = cursor.start + (j << PAGE_SHIFT);
-		migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
-		svm_migrate_get_vram_page(prange, migrate->dst[i]);
-		migrate->dst[i] = migrate_pfn(migrate->dst[i]);
-
+		if (migrate->src[i] & MIGRATE_PFN_MIGRATE) {
+			dst[i] = cursor.start + (j << PAGE_SHIFT);
+			migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
+			svm_migrate_get_vram_page(prange, migrate->dst[i]);
+			migrate->dst[i] = migrate_pfn(migrate->dst[i]);
+			mpages++;
+		}
 		spage = migrate_pfn_to_page(migrate->src[i]);
 		if (spage && !is_zone_device_page(spage)) {
 			src[i] = dma_map_page(dev, spage, 0, PAGE_SIZE,
-- 
2.34.1

