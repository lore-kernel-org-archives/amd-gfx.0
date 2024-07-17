Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72196C3DA42
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 08:16:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E685110E9F3;
	Wed, 17 Jul 2024 08:16:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xT3Xq8Hj";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E33428911F
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 08:16:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ROLXnU9IAARZ4j3brImW1xixbJWp3SOD7ZzTIr+w6PTz3xnrNrvJhqqaWdKdNPI90LvXYACmEbiNDGFyRJcaT/hBGcqqDBeAbiTr5PCDdrfoqHEjWPCiibxn41CsCoE5L9OPOZa0YQWUQG165x2UqN+rdaNpuigygbxvc9Llk+t0QW71aD+DdbDujHQS0B60Ep0DyxML8ePM6T3fA9IVPVMze9boXTvbOP/L8m9a/2G1KUw/MnOcBQQ98DjWxkMHsCvTkTAt5Gh0MmXrnFx7smlG8v4Saq8vKzehDfNqkpSCIB8ucw3Xq5TX7agExIAOrU6Y4cAl6BM7o5ZRjZbe6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEzjUGWvLfVr2oCbwyDnl4+m0faBlRcwe67Z8pzpm2s=;
 b=pez3v+eQVyOcbkv/XBEe1qFfnhrVdkpgfbdCnEXJZhFKeNVePFA2ERH7mqteQlGfWvdIWbd+ZwEDhZxBFPq3oCxKetqg1GSGVJIg3RVateHiF24NAqr19+kqYlDBcq6VznW9R23ITNFFBZraE6oPBTAvI92P4y11L8sIxIwcv2j4YVr4NJyJCQu9tfLfI3PonJa3XZZXaPUloo+kvv1CGePXfxPnIxbe7AattwWGQsAFc5AtZV0tOZNqMM8euZYsIXG8ogQsvnWkrfdzhre+QNBcreBGClupoP3+3OwYH0/pATiOD6eUd8LPkJS/2g7K782tKbN2tEZtaZ9nSLEhoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEzjUGWvLfVr2oCbwyDnl4+m0faBlRcwe67Z8pzpm2s=;
 b=xT3Xq8HjRiuDd7twWdaCNBHSc7A+wLWXDw/V+C5TDNmsOvsALSBVToWeLhFcLDBwP8S/1cdICbIxO7f+BEkBGFxg5FCevj2km2SAdx0M/Z69bKmCUi80+Ic6wgQAi5PtZJZnXf5ZY+lWdYgvi9A9MGogQfBr3S0iXX2r/vNvo4Y=
Received: from BL1PR13CA0261.namprd13.prod.outlook.com (2603:10b6:208:2ba::26)
 by DM6PR12MB4074.namprd12.prod.outlook.com (2603:10b6:5:218::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 08:16:18 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::a6) by BL1PR13CA0261.outlook.office365.com
 (2603:10b6:208:2ba::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14 via Frontend
 Transport; Wed, 17 Jul 2024 08:16:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 08:16:18 +0000
Received: from amd-02.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 03:16:15 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Remove unused code
Date: Wed, 17 Jul 2024 16:15:47 +0800
Message-ID: <20240717081547.224193-3-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240717081547.224193-1-YiPeng.Chai@amd.com>
References: <20240717081547.224193-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|DM6PR12MB4074:EE_
X-MS-Office365-Filtering-Correlation-Id: 33bc14cb-a37a-4305-5793-08dca638bbfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kPutzZHnQPpcMGXLDZrx19/CEl0lHBRIPvvQ8pDkkdQSlifalYkfZa7GGZ1q?=
 =?us-ascii?Q?beDPiw/12X24x+5ji24hGeacgj15WPxXfnTjTariytF5uX2IC8QmwGL3sWQG?=
 =?us-ascii?Q?6TMgLiaxVRtI9oVJuqCuQFvF3T4rbsWjC+qvyqPRPlYZHr2Ace4JCLwHQ7CW?=
 =?us-ascii?Q?c4r+Wdd1g87E/7K3B/kFhgq1//L4sozGDfDy9zY0lwKn3OIlHsiG/2lBTC9A?=
 =?us-ascii?Q?GFwTcsqMjWNcl6k2ln3jcm3+MFjwcLgja7OyTghaNqtL1Y2fjUdNVbPlu1ut?=
 =?us-ascii?Q?nTZNPERjZa4kyQhXPjuaWRwVqnH/+CGBqcnK9VejihTANwP+riAVvz889nUn?=
 =?us-ascii?Q?e8tXbPILV6HcRRWPxLeZLNmfovWNyENZe7Hjvg49gzanFNpqz800o2e/mnML?=
 =?us-ascii?Q?S/DfAWmbGdJg8/uEtw/MO9bisSvGZVj9TRbMVuBRiqeO9CMcoitBxeWI0T+5?=
 =?us-ascii?Q?OFnQJC/B/n890tNBLo1tOPmxurnowMXSP8h8r+v1P2aCitMA+vQW7PrbMXjV?=
 =?us-ascii?Q?Ej8NbEO9OGEM3UFx7C+8WjQXV+uENFscTj7n6ae263F9xcOjKKOr50L38HN5?=
 =?us-ascii?Q?dk90fRM2jfg5FLUpApu9pJu289yh7nb+NYt70358HoKeCN2YkG1pKKhxZfg/?=
 =?us-ascii?Q?iaib+SXIvvbYirh8LDjOIS0rsbyFHVjtab9/tnekIgAI2Q+3o4czW/2zNRzk?=
 =?us-ascii?Q?TlWM9b9Jb4AsbiSOpi7yACfNrvRIDV3O3LXlKPH/67G3PDRy9NmjACpdyfqX?=
 =?us-ascii?Q?0Qd1QqWEDbkpmyRQybiFAmHtMhKExS6EY7eXJ2J2y1vnkXV3keoqUNrbaEkX?=
 =?us-ascii?Q?t36PH5rHoeAdqvBD6xfhZxuo2AvayldCIpwofdaqEo4ks3TB8M85+e87kAEG?=
 =?us-ascii?Q?hAaGko/dpjFgERLP0oITEiGiMJ0wIQlorJFLD2WtjCHgkCPXYl5jDnwZyw9V?=
 =?us-ascii?Q?0f2iwND0BkPqZY3eCxwqVWbMe70pBAYmS0Th1QagqNXP9lvWH2F3CP3wfyZE?=
 =?us-ascii?Q?WPg/GuV0LdgCTB9vJ2pXsgloAs7VXHeutdLAP1NM4MsR04jCgYl+7ltNtiTW?=
 =?us-ascii?Q?QA6LjQ2tqQDAWIrp1CoyTPwzO4XDCH7WEjxEAo0GyWuOwiQr3TjG2eESCnrp?=
 =?us-ascii?Q?u39tTBZzkHQlzsAYzXpKgJANGonccDRQeVebrJZ8P1a8losCHKfmcv/UUXOk?=
 =?us-ascii?Q?6BOVpGics9pm0eyxBBskqi5UiN1CRXGLGS/+LQyWUQCj4o97goR8M8grasE5?=
 =?us-ascii?Q?hq2n7CZvjl9zmaC984BUfpJDj8AbtW3c9bd72U4E/23ZwuxBeYjZ672PAJjj?=
 =?us-ascii?Q?HNEU8igbsUvW2n+nSV1161kD7TXb5xXOIXerahV8IxgC5m6BVhKL5/XOgl7H?=
 =?us-ascii?Q?P8WfIreP7waAxXPghuhfwD+xmuaRUzXBjlW6aQYLaZFyukx1yW7HAh1x4ws4?=
 =?us-ascii?Q?SSx8D2Io1dv1tZFjJdJbZGYMIHrzYV17?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 08:16:18.1333 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33bc14cb-a37a-4305-5793-08dca638bbfb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4074
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

Remove unused code.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 29 ---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 10 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 86 -------------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |  5 --
 4 files changed, 130 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 95f2c3ac185f..12ab48f26bd5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2886,9 +2886,6 @@ static void amdgpu_ras_ecc_log_init(struct ras_ecc_log_info *ecc_log)
 {
 	mutex_init(&ecc_log->lock);
 
-	/* Set any value as siphash key */
-	memset(&ecc_log->ecc_key, 0xad, sizeof(ecc_log->ecc_key));
-
 	INIT_RADIX_TREE(&ecc_log->de_page_tree, GFP_KERNEL);
 	ecc_log->de_queried_count = 0;
 	ecc_log->prev_de_queried_count = 0;
@@ -3153,12 +3150,6 @@ static int amdgpu_ras_page_retirement_thread(void *param)
 			/* Wake up work to save bad pages to eeprom */
 			schedule_delayed_work(&con->page_retirement_dwork, 0);
 		}
-#else
-        dev_info(adev->dev, "Start processing page retirement. request:%d\n",
-                    atomic_read(&con->page_retirement_req_cnt));
-
-        amdgpu_umc_bad_page_polling_timeout(adev,
-                        0, MAX_UMC_POISON_POLLING_TIME_ASYNC);
 #endif
 	}
 
@@ -4638,8 +4629,6 @@ static struct ras_err_info *amdgpu_ras_error_get_info(struct ras_err_data *err_d
 	if (!err_node)
 		return NULL;
 
-	INIT_LIST_HEAD(&err_node->err_info.err_addr_list);
-
 	memcpy(&err_node->err_info.mcm_info, mcm_info, sizeof(*mcm_info));
 
 	err_data->err_list_count++;
@@ -4649,18 +4638,6 @@ static struct ras_err_info *amdgpu_ras_error_get_info(struct ras_err_data *err_d
 	return &err_node->err_info;
 }
 
-void amdgpu_ras_add_mca_err_addr(struct ras_err_info *err_info, struct ras_err_addr *err_addr)
-{
-	/* This function will be retired. */
-	return;
-}
-
-void amdgpu_ras_del_mca_err_addr(struct ras_err_info *err_info, struct ras_err_addr *mca_err_addr)
-{
-	list_del(&mca_err_addr->node);
-	kfree(mca_err_addr);
-}
-
 int amdgpu_ras_error_statistic_ue_count(struct ras_err_data *err_data,
 		struct amdgpu_smuio_mcm_config_info *mcm_info,
 		struct ras_err_addr *err_addr, u64 count)
@@ -4677,9 +4654,6 @@ int amdgpu_ras_error_statistic_ue_count(struct ras_err_data *err_data,
 	if (!err_info)
 		return -EINVAL;
 
-	if (err_addr && err_addr->err_status)
-		amdgpu_ras_add_mca_err_addr(err_info, err_addr);
-
 	err_info->ue_count += count;
 	err_data->ue_count += count;
 
@@ -4724,9 +4698,6 @@ int amdgpu_ras_error_statistic_de_count(struct ras_err_data *err_data,
 	if (!err_info)
 		return -EINVAL;
 
-	if (err_addr && err_addr->err_status)
-		amdgpu_ras_add_mca_err_addr(err_info, err_addr);
-
 	err_info->de_count += count;
 	err_data->de_count += count;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index f607ff620015..7ddd13d5c06b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -28,7 +28,6 @@
 #include <linux/list.h>
 #include <linux/kfifo.h>
 #include <linux/radix-tree.h>
-#include <linux/siphash.h>
 #include "ta_ras_if.h"
 #include "amdgpu_ras_eeprom.h"
 #include "amdgpu_smuio.h"
@@ -485,7 +484,6 @@ struct ras_ecc_err {
 
 struct ras_ecc_log_info {
 	struct mutex lock;
-	siphash_key_t ecc_key;
 	struct radix_tree_root de_page_tree;
 	uint64_t	de_queried_count;
 	uint64_t	prev_de_queried_count;
@@ -573,7 +571,6 @@ struct ras_fs_data {
 };
 
 struct ras_err_addr {
-	struct list_head node;
 	uint64_t err_status;
 	uint64_t err_ipid;
 	uint64_t err_addr;
@@ -584,7 +581,6 @@ struct ras_err_info {
 	u64 ce_count;
 	u64 ue_count;
 	u64 de_count;
-	struct list_head err_addr_list;
 };
 
 struct ras_err_node {
@@ -957,12 +953,6 @@ int amdgpu_ras_unbind_aca(struct amdgpu_device *adev, enum amdgpu_ras_block blk)
 ssize_t amdgpu_ras_aca_sysfs_read(struct device *dev, struct device_attribute *attr,
 				  struct aca_handle *handle, char *buf, void *data);
 
-void amdgpu_ras_add_mca_err_addr(struct ras_err_info *err_info,
-			struct ras_err_addr *err_addr);
-
-void amdgpu_ras_del_mca_err_addr(struct ras_err_info *err_info,
-		struct ras_err_addr *mca_err_addr);
-
 void amdgpu_ras_set_fed(struct amdgpu_device *adev, bool status);
 bool amdgpu_ras_get_fed_status(struct amdgpu_device *adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 2fc90799bf8d..32be258d81e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -204,55 +204,6 @@ static int amdgpu_umc_do_page_retirement(struct amdgpu_device *adev,
 	return AMDGPU_RAS_SUCCESS;
 }
 
-int amdgpu_umc_bad_page_polling_timeout(struct amdgpu_device *adev,
-			uint32_t reset, uint32_t timeout_ms)
-{
-	struct ras_err_data err_data;
-	struct ras_common_if head = {
-		.block = AMDGPU_RAS_BLOCK__UMC,
-	};
-	struct ras_manager *obj = amdgpu_ras_find_obj(adev, &head);
-	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-	uint32_t timeout = timeout_ms;
-
-	memset(&err_data, 0, sizeof(err_data));
-	amdgpu_ras_error_data_init(&err_data);
-
-	do {
-
-		amdgpu_umc_handle_bad_pages(adev, &err_data);
-
-		if (timeout && !err_data.de_count) {
-			msleep(1);
-			timeout--;
-		}
-
-	} while (timeout && !err_data.de_count);
-
-	if (!timeout)
-		dev_warn(adev->dev, "Can't find bad pages\n");
-
-	if (err_data.de_count)
-		dev_info(adev->dev, "%ld new deferred hardware errors detected\n", err_data.de_count);
-
-	if (obj) {
-		obj->err_data.ue_count += err_data.ue_count;
-		obj->err_data.ce_count += err_data.ce_count;
-		obj->err_data.de_count += err_data.de_count;
-	}
-
-	amdgpu_ras_error_data_fini(&err_data);
-
-	kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
-
-	if (reset || (err_data.err_addr_cnt && con && con->is_rma)) {
-		con->gpu_reset_flags |= reset;
-		amdgpu_ras_reset_gpu(adev);
-	}
-
-	return 0;
-}
-
 int amdgpu_umc_pasid_poison_handler(struct amdgpu_device *adev,
 			enum amdgpu_ras_block block, uint16_t pasid,
 			pasid_notify pasid_fn, void *data, uint32_t reset)
@@ -476,43 +427,6 @@ int amdgpu_umc_update_ecc_status(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int amdgpu_umc_uint64_cmp(const void *a, const void *b)
-{
-	uint64_t *addr_a = (uint64_t *)a;
-	uint64_t *addr_b = (uint64_t *)b;
-
-	if (*addr_a > *addr_b)
-		return 1;
-	else if (*addr_a < *addr_b)
-		return -1;
-	else
-		return 0;
-}
-
-/* Use string hash to avoid logging the same bad pages repeatedly */
-int amdgpu_umc_build_pages_hash(struct amdgpu_device *adev,
-		uint64_t *pfns, int len, uint64_t *val)
-{
-	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-	char buf[MAX_UMC_HASH_STRING_SIZE] = {0};
-	int offset = 0, i = 0;
-	uint64_t hash_val;
-
-	if (!pfns || !len)
-		return -EINVAL;
-
-	sort(pfns, len, sizeof(uint64_t), amdgpu_umc_uint64_cmp, NULL);
-
-	for (i = 0; i < len; i++)
-		offset += snprintf(&buf[offset], sizeof(buf) - offset, "%llx", pfns[i]);
-
-	hash_val = siphash(buf, offset, &con->umc_ecc_log.ecc_key);
-
-	*val = hash_val;
-
-	return 0;
-}
-
 int amdgpu_umc_logs_ecc_err(struct amdgpu_device *adev,
 		struct radix_tree_root *ecc_tree, struct ras_ecc_err *ecc_err)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index 5f50c69c3cec..ce4179db2a6d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -127,13 +127,8 @@ int amdgpu_umc_page_retirement_mca(struct amdgpu_device *adev,
 int amdgpu_umc_loop_channels(struct amdgpu_device *adev,
 			umc_func func, void *data);
 
-int amdgpu_umc_bad_page_polling_timeout(struct amdgpu_device *adev,
-			uint32_t reset, uint32_t timeout_ms);
-
 int amdgpu_umc_update_ecc_status(struct amdgpu_device *adev,
 				uint64_t status, uint64_t ipid, uint64_t addr);
-int amdgpu_umc_build_pages_hash(struct amdgpu_device *adev,
-		uint64_t *pfns, int len, uint64_t *val);
 int amdgpu_umc_logs_ecc_err(struct amdgpu_device *adev,
 		struct radix_tree_root *ecc_tree, struct ras_ecc_err *ecc_err);
 
-- 
2.34.1

