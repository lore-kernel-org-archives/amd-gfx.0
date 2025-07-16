Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F33C83F27
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jul 2025 06:49:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E02E710E38B;
	Wed, 16 Jul 2025 06:49:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pgaCiACy";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2046.outbound.protection.outlook.com [40.107.101.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11FF610E38B
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jul 2025 06:49:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ce5S0Iia4i61QGl7rW6PhLKTYVIVyUobDmqGhbNUoBmIbeeTxLTpTcULA5mCI4VOR2EOLNh/QjQ8maW10cK2QJPxVS2wiQUYgxgZJyyqItlNSFRp2ghMaEPw4rIuvGKuU4b6uvk79ZmkXjpzMfLvjw0vx37sofigXWjmx61LcSl1LJT+nBK2t4BMMlkrIUXVJ953JORlteHJ0NPfJ0O/QLoRFLbvf0ViGYPesPGdmvgT/m4zQgewEJytjR3PP2MnMLQd88+oG5Es0O0A9uM6PigSzCwjI/RKbWfx5xWU42u9ID3r6pcjBnoyhAoKXw/SklF1Wv19aCkXtxf05Gt9eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7F1tE19xmlVl4a3xR2IYUsJ7dg7IodGrY5aq4VsxqU=;
 b=qv1mWkLNOIdCoAyAZaSGj863o3fefPHCHqedsOs96fgVgJnbBArepYjE9yYi6xyfpV8lKkFBYmu756cm1iJMy+GcPjHgxFFxsfiaqq67CVMNnjcmnwVy0xFYPolVBg/lCf0yKiIOPz7HiP9MrqXhT2YM8FU102xe01zapw9+A551Rod+8tO7fUAPXfabTTomzGnoGmYhEuJ2PmwAOndxV6hoyhkx1lzlgexXF7/gK9QKP0hKWxBeXTV1lrAMhJYADZTXGHIqB5i5f4LZXuAVGONYp+oZrHpN0XkDEKC2UrICktMhxecOwZeTRllDDA2FOo2+9DoPDRTcxzvbV+EprA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7F1tE19xmlVl4a3xR2IYUsJ7dg7IodGrY5aq4VsxqU=;
 b=pgaCiACy2EEO16TC2MTte3OqcbCUK9rrY+G7zw4pX5GVFarLBqCybmDoR9kOaTFpCFXvvWI8OTKvAJhLFCJtcqSKJ6deF2MNV+dTJezJx90PaA4Fbd8RQA8NxwHpwJG7sCkWyw5b1LSyrm6yYP7cXZA5NMkyewyjzG26iQZBbUQ=
Received: from MN2PR08CA0004.namprd08.prod.outlook.com (2603:10b6:208:239::9)
 by DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.36; Wed, 16 Jul
 2025 06:49:02 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:208:239:cafe::43) by MN2PR08CA0004.outlook.office365.com
 (2603:10b6:208:239::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.19 via Frontend Transport; Wed,
 16 Jul 2025 06:49:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 06:49:01 +0000
Received: from amd-02.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 01:48:58 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yipechai@amd.com>, <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, "YiPeng
 Chai" <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdgpu: add command to check address validity
Date: Wed, 16 Jul 2025 14:48:23 +0800
Message-ID: <20250716064823.1272183-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|DM4PR12MB6566:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f282e31-1aad-4316-9c2f-08ddc434d94c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kkLl6qqd6V9Mr6npu+6MtzxiBvFbsxOE8IaGgOyIgNGGWlIlRzNpMOo0EHL5?=
 =?us-ascii?Q?WyX0000R3WalTh7II9Fcx28HwXSFw1nPNb8mWN3vFiUJnvoRdwU8b9S2FGvZ?=
 =?us-ascii?Q?/o3UrR0NbJPBdMfBNcG3E9LnfU4dU9g24SSUXPMu2NbKa9YmM4xDBIkyWEem?=
 =?us-ascii?Q?Tx2Nzh4sSB5UE/i18WDAXf2swWIAZZZvf6MdyNMQHlCCMyzts+rLtFkanTMa?=
 =?us-ascii?Q?mEXSOTxZhd3PfYl6zV6j7BrfmindsIDvHxgTGbla8UK/luF6kLggBJGDc0hz?=
 =?us-ascii?Q?mqf9XlDNOuw0DFnmyGHtlp2fanj95lKjJxvgRdilVTIUHcCFhDF2WxtCUfxH?=
 =?us-ascii?Q?1q60AXmmp//UGx4rwsU3fBaJp4mf/8XebZC19TEMlhjgS4JHkCGl6Oa95GDI?=
 =?us-ascii?Q?q7MxNvj502fCgzMt132iezbyxiT8G0UfGJuvuA+8FEChxKqQF0tuOCWLdoae?=
 =?us-ascii?Q?Be8IHaDEuA2Qb5jUs9GziIgn1sd2/srA9jpmqOeK/Gofj3+eRaYOyabar854?=
 =?us-ascii?Q?lTVFzEkn/NcOO3a7fUSPJrruf2Wp90OzKLqLk5dSbo8wvNxjPSFePHkW1n8U?=
 =?us-ascii?Q?6AoVWRhJ49q+Iy6HQXm+11NC5PUY5t+WW3QAI3xUX/944SqIbgVpqsXz/fNS?=
 =?us-ascii?Q?U6V1rXx+29RrGBQOMxS702bjyMk4brGLxDjAoHpV7k1molEiYTdI9ie6lh2N?=
 =?us-ascii?Q?Iw6uAdwnWPhvXb8J7pik3n8vDblsuA5CXNYMaDdtzfRJyUyd5MShjVfk/7zn?=
 =?us-ascii?Q?2kSY5XyQmyx52mhldNWXu3SgswyAKjOFRoAwoy/wxu7LhKI+b/C3WW0GnXal?=
 =?us-ascii?Q?YmdAd8G5UL6LSBYPooR15Fbc3aB50TM2AcouLpHTo5MvtbXTJcrAeIedZBPA?=
 =?us-ascii?Q?wLPFe9tmeh+vBCr4jydzfdo8dBGhzoJN4X8bs0HTqzF52Hv65OmKB6/gTQkY?=
 =?us-ascii?Q?3wFKLwa7fa1khWV5KBsOMtVTeypMbfM0OSg8JZ0MHnYy3AdxIfEz9qFsYBhC?=
 =?us-ascii?Q?XSiUzy1k9LZFO+xwpGc5CBTjFe5OJgKj+ZAeEx/zyIjExDeCT5oVUjelXHIA?=
 =?us-ascii?Q?MGaFOGlolJmmr9pDs6jw4ozDYJYhLAwIIlRUnRxN7pIEHBcgJ0v+if7BY69j?=
 =?us-ascii?Q?EpUjVDq+9aFCRG+dlIug6DiOHz7Zfst+ogdiQlcyV7w8ZQSDZy6TPjN5nUA7?=
 =?us-ascii?Q?PpiPyauAfpk1NsrIJ1pZJ9yutUdICPvBrte8Witqq4ZCoM26tCHD6FO+dptM?=
 =?us-ascii?Q?Pj0SG++xZAK9FtKZNpB77x+dZwkdxK/2T9nzCdDuv+pa2lyHKRsMhmb2btA+?=
 =?us-ascii?Q?8/KscrvP7YfhwP9FX3R+ZegKsG7l9l/sNygAAy+BrRZS5m2SfQBXzlWnkhMi?=
 =?us-ascii?Q?QQUCzEnFwIu4+s6DIbkzu599oBJMtFvCHlmvlaRU6RLgz6GAp535jPSz7nXJ?=
 =?us-ascii?Q?L7u2AVlf1zRKDQtClyGS2NRGg2mM48OvIfutsnq4czXvY/ilOUZVld3/UXsJ?=
 =?us-ascii?Q?TrR+fJ2ZI5TnrHrnO/GPfY7Z8QT2xM5C1sSc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 06:49:01.9076 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f282e31-1aad-4316-9c2f-08ddc434d94c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6566
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

Add command to check address validity and remove
unused command codes.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 58 +++++++++++--------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  3 ++
 2 files changed, 29 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 15bde4904996..68feec0956f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -163,47 +163,38 @@ static bool amdgpu_ras_get_error_query_ready(struct amdgpu_device *adev)
 	return false;
 }
 
-static int amdgpu_reserve_page_direct(struct amdgpu_device *adev, uint64_t address)
+static int amdgpu_check_address_validity(struct amdgpu_device *adev, uint64_t address)
 {
-	struct ras_err_data err_data;
-	struct eeprom_table_record err_rec;
-	int ret;
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	struct amdgpu_vram_block_info blk_info;
+	uint64_t page_pfns[32] = {0};
+	int i, ret, count;
+
+	if (amdgpu_ip_version(adev, UMC_HWIP, 0) < IP_VERSION(12, 0, 0))
+		return 0;
 
 	if ((address >= adev->gmc.mc_vram_size) ||
 	    (address >= RAS_UMC_INJECT_ADDR_LIMIT)) {
 		dev_warn(adev->dev,
-		         "RAS WARN: input address 0x%llx is invalid.\n",
-		         address);
+		    "RAS WARN: input address 0x%llx is invalid.\n",
+		    address);
 		return -EINVAL;
 	}
 
-	if (amdgpu_ras_check_bad_page(adev, address)) {
-		dev_warn(adev->dev,
-			 "RAS WARN: 0x%llx has already been marked as bad page!\n",
-			 address);
-		return 0;
-	}
-
-	ret = amdgpu_ras_error_data_init(&err_data);
-	if (ret)
-		return ret;
+	count = amdgpu_umc_lookup_bad_pages_in_a_row(adev,
+				address, page_pfns, ARRAY_SIZE(page_pfns));
+	if (count <= 0)
+		return -EPERM;
 
-	memset(&err_rec, 0x0, sizeof(struct eeprom_table_record));
-	err_data.err_addr = &err_rec;
-	amdgpu_umc_fill_error_record(&err_data, address, address, 0, 0);
-
-	if (amdgpu_bad_page_threshold != 0) {
-		amdgpu_ras_add_bad_pages(adev, err_data.err_addr,
-					 err_data.err_addr_cnt, false);
-		amdgpu_ras_save_bad_pages(adev, NULL);
+	for (i = 0; i < count; i++) {
+		memset(&blk_info, 0, sizeof(blk_info));
+		ret = amdgpu_vram_mgr_query_address_block_info(&adev->mman.vram_mgr,
+					page_pfns[i] << AMDGPU_GPU_PAGE_SHIFT, &blk_info);
+		if (!ret && (blk_info.task.pid == con->init_task_pid) &&
+			!strncmp(blk_info.task.comm, con->init_task_comm, TASK_COMM_LEN))
+			return -EACCES;
 	}
 
-	amdgpu_ras_error_data_fini(&err_data);
-
-	dev_warn(adev->dev, "WARNING: THIS IS ONLY FOR TEST PURPOSES AND WILL CORRUPT RAS EEPROM\n");
-	dev_warn(adev->dev, "Clear EEPROM:\n");
-	dev_warn(adev->dev, "    echo 1 > /sys/kernel/debug/dri/0/ras/ras_eeprom_reset\n");
-
 	return 0;
 }
 
@@ -295,7 +286,7 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
 		op = 1;
 	else if (sscanf(str, "inject %32s %8s", block_name, err) == 2)
 		op = 2;
-	else if (strstr(str, "retire_page") != NULL)
+	else if (strstr(str, "check_address") != NULL)
 		op = 3;
 	else if (str[0] && str[1] && str[2] && str[3])
 		/* ascii string, but commands are not matched. */
@@ -495,7 +486,7 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct file *f,
 		return ret;
 
 	if (data.op == 3) {
-		ret = amdgpu_reserve_page_direct(adev, data.inject.address);
+		ret = amdgpu_check_address_validity(adev, data.inject.address);
 		if (!ret)
 			return size;
 		else
@@ -4103,6 +4094,9 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 			goto release_con;
 	}
 
+	con->init_task_pid = task_pid_nr(current);
+	get_task_comm(con->init_task_comm, current);
+
 	dev_info(adev->dev, "RAS INFO: ras initialized successfully, "
 		 "hardware ability[%x] ras_mask[%x]\n",
 		 adev->ras_hw_enabled, adev->ras_enabled);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 927d6bff734a..7f10a7402160 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -570,6 +570,9 @@ struct amdgpu_ras {
 	struct ras_event_manager *event_mgr;
 
 	uint64_t reserved_pages_in_bytes;
+
+	pid_t init_task_pid;
+	char init_task_comm[TASK_COMM_LEN];
 };
 
 struct ras_fs_data {
-- 
2.34.1

