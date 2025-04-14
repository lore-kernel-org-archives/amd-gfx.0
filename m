Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E82AC369B2
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Apr 2025 10:48:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3528310E568;
	Mon, 14 Apr 2025 10:48:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="of7rwP2I";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40A8010E568
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 10:48:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vjW2yq//bUpcJj+HzeEP+mMFlg5P/OmczRDs/5d6wv2MaCqMfZxsvg0KYX53h+iedWAgzTy5A5qQLdquePy93Ze5vU8Sy+eIn/sdivcqPS2p4vlfZurhdRV+bxVX2xjApTPRtYxOQvV0C5o8lS7tL47gjzB7q/8CoYQ6H51I/fyDkSxX5cRVu8khzwwa34pxL6vHqYy2fuZt0Trgi0oCMl2+cRGeyLfqCO624L6RLOiuuQYOwD2vc9+/6lu1AW/1NOKCFZvQvln9rVN8WjgMOtLY/yzffgEBMWA3iWgtifdXiWeSNaVTcgi9IuLsIuBdu6Tw+oxiWS5pUwY99plbCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=01l8dodLKAL4BbMCYeBMebN0R44kl0e7Iwv+y8sU6+E=;
 b=tw0S/5gCkNhDzR8532qbOFco0pbe95Qmje2mpU/j4i9fYUnhDvXmsCgTz2lV0jCA+JB0tqbkIRevr3jUNyaPEuJ+ICZdm5PorMKLJVUVMEEcLE+ndE4mAN/f5wEW7+PthW5+1/aZ3hCOInWwCwwF77EOIe/pNDSXLJVlpjkMMO/xLkF3AompBdBY+B8x53cQtzGJt9rVyQGFslmF+32flMseJOauoq954tQNoLQROip6qO20ppHqoHHkHdgD/n6A4PO3oNfQXYmjV4P6C/mVSbhe87XMyO+rSeTLjdbxnecdMDz08PKg9BMVFt6R9PDvnuEAWfmKlZHITw1fBMSaPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01l8dodLKAL4BbMCYeBMebN0R44kl0e7Iwv+y8sU6+E=;
 b=of7rwP2IxsptoHqWHXAREKTMUN27rZwSMF7nXx1bEKvAsDzTxyKeyxWmWm8vvEsGrr8phc61Dj2KiqKONtiwtrDgaIHpr+8/EIE8qDwLEGMgcpnwVUpYbk62ST1loyfJPLmk473/Ee/QIJZjJJTGFtdIwUeAI/ZcXIQQsOyIdQE=
Received: from DM6PR03CA0026.namprd03.prod.outlook.com (2603:10b6:5:40::39) by
 SA0PR12MB4480.namprd12.prod.outlook.com (2603:10b6:806:99::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.34; Mon, 14 Apr 2025 10:48:31 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:5:40:cafe::cc) by DM6PR03CA0026.outlook.office365.com
 (2603:10b6:5:40::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Mon,
 14 Apr 2025 10:48:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 10:48:29 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 05:48:29 -0500
Received: from hjbog17.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 14 Apr 2025 05:48:27 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <emily.deng@amd.com>,
 <guoqing.zhang@amd.com>, Jiang Liu <gerry@linux.alibaba.com>
Subject: [PATCH 3/6] drm/amdgpu: update cached GPU addresses for SMU
Date: Mon, 14 Apr 2025 18:46:52 +0800
Message-ID: <20250414104655.336497-4-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250414104655.336497-1-guoqing.zhang@amd.com>
References: <20250414104655.336497-1-guoqing.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|SA0PR12MB4480:EE_
X-MS-Office365-Filtering-Correlation-Id: a4f8f9a1-6e4c-456b-a89d-08dd7b41e4ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NBUmk0I9tKOYixGzeHSet7ahQTTGO6cUoaBoNerjKZZaSCMEjVJz4G2++4v9?=
 =?us-ascii?Q?jp24co5BSTEe6hnQybjnq9R2tjn0e0mIWeEk7T/sN9IXsYFRSdQi6+RmJojf?=
 =?us-ascii?Q?W/3Trd/SfiVvmV+DN+BvE41nWKrgL2FonFNEc67C6IHzR5zn+a2e+M2UUwjb?=
 =?us-ascii?Q?jHQvYq7QIYg6EPjq1f5D2RNwKVUymzShmgmZA+g9kdhIQqpcVlFBkA+bez4R?=
 =?us-ascii?Q?wRY0xmIAUzmBwtMhWGBipGjCiPe5U0TaJLnFyJuVVArThhaqE7ZyN4XoCe7O?=
 =?us-ascii?Q?j0F+5kvCEXvYaKlqmJ5pK4nQPw6isRF87Sy1EcAdPexLP/6XKjHOl2/X0n3r?=
 =?us-ascii?Q?b8UYVuJIvyjkgWAXPC+uSSrFJ7yTaK5m/LHZPri5jbLCVWx112d63o9uAtG8?=
 =?us-ascii?Q?vr/RWc4yW7HhoGhLVMfF+rnJ4oQ+6n3VRelX0u6fWm23J50PaA4bTYk9DUCK?=
 =?us-ascii?Q?2H1kWa4trMlZFgI7l5Yv9b9Y0BtHudpy/LUW+V5VU87wq1oZVL3OHm07rfak?=
 =?us-ascii?Q?iKD4vR17xC5CEZLL7W92K1tAQKWl6CnEMvoI/J4GLlKL5hFt6O8s7H6NgrEH?=
 =?us-ascii?Q?yQwMrq267Gw3iPGkfPwvZGxReSI98ktAD9O9/FgrknVpWrk75NCEgrg1dt91?=
 =?us-ascii?Q?2MfVbI4XCp0HARMFB4PLaKl2HPGjEMXcGSYVCZKB27iZ6asJD3gZZ+cDo3Nc?=
 =?us-ascii?Q?AGUTVbLcDm5+qcMDk+BWt6YyOzeDwBcbKvEhR+uhSG3IFefKKkvllig3iXgg?=
 =?us-ascii?Q?jsVpay1EEKKwtLRw36dskGB95oXzxErzMWH9mIbrHW3jM2rQV6bauhktVIzq?=
 =?us-ascii?Q?7XE1QvBzjOmC2qfwa8DqpmL499bkrxikVMnFJGZmrfnsFRSoJoT+PJFJnyGE?=
 =?us-ascii?Q?yaOaq/cepF7X7EoD1UJiMYRIr5ixJj0ibiTWu86Fq4R50QeBcbFjtcq9is1V?=
 =?us-ascii?Q?58pwUa4riz0MsLW5pLPqsV43Lwl7YGIJUt2zwPHQK9tRVMkXk9c6RL3tgqXE?=
 =?us-ascii?Q?0HoU/tX9/pua4KZvDufPiPvPFV7HY+Q66nbZ9CzszeI9mDdaDaL49G75q/iE?=
 =?us-ascii?Q?UWiYQIuMzw5kG4NxJYD6gZ8bvukAkBf20C72Boed3My8u5TV5SxiMvRZjUBe?=
 =?us-ascii?Q?MgIMoLzvSoKLaCSnHpH04dCJ7gEFFv4fm3OKpPAsQb4Xud8v9u9wQpBgp5Lo?=
 =?us-ascii?Q?aQ59AQA2YKjd+UeNfIjWxO9eysGItcAlXpM3+wSyJt5Qr8Ud5IUynxWnMgDs?=
 =?us-ascii?Q?pb4utZQ9fT9z86p9oMS1BXSRhc31/dP7ciu9pFFWNG8l3pIX3QmzROsVohnQ?=
 =?us-ascii?Q?w1MCOF6XeLRGvVr/o3Wfz29JZHUV/BPZCYWNI4+rhibAm9bnqxDB2A1MUP4e?=
 =?us-ascii?Q?1jK/UnKsca3KZ2Bhj7cwJq/NlIou7nxQkG7LZq7CrdpihKnoK7G7+NYD2yJE?=
 =?us-ascii?Q?og5SFgEVALng6rPEAsKnb4/HSahwNslQlOdapVfx9m0278u/+pHKB/1GrLum?=
 =?us-ascii?Q?3LEi2Rce3ADVM5x/Y2hHzc2/U/e3Y+GGMhS3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 10:48:29.9371 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4f8f9a1-6e4c-456b-a89d-08dd7b41e4ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4480
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

2 reasons for this change:
1. when pdb0 is enabled, gpu addr from amdgpu_bo_create_kernel() is
based on pdb0, it is not compatible with SMU, it need to updated
to use original gpu address.
2. Since original gpu address will change after switching to new GPU
index after hibernation, it need to be updated after resume.

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
Change-Id: I5f9586ea156b9d5bb78596bb08681335de109c7b
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 30 +++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index f345c233bc47..72cd4374ca4c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1004,6 +1004,31 @@ static int smu_fini_fb_allocations(struct smu_context *smu)
 	return 0;
 }
 
+static int smu_resume_fb_allocations(struct smu_context *smu)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct smu_table *tables = smu_table->tables;
+	struct smu_table *driver_table = &(smu_table->driver_table);
+
+	if (tables[SMU_TABLE_PMSTATUSLOG].bo)
+		tables[SMU_TABLE_PMSTATUSLOG].mc_address =
+			amdgpu_bo_gpu_offset(tables[SMU_TABLE_PMSTATUSLOG].bo);
+
+	if (driver_table->bo)
+		driver_table->mc_address = amdgpu_bo_gpu_offset(driver_table->bo);
+
+	return 0;
+}
+static void smu_resume_dummy_read_table(struct smu_context *smu)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct smu_table *dummy_read_1_table = &smu_table->dummy_read_1_table;
+
+	if (dummy_read_1_table->bo)
+		dummy_read_1_table->mc_address = amdgpu_bo_gpu_offset(dummy_read_1_table->bo);
+}
+
+
 /**
  * smu_alloc_memory_pool - allocate memory pool in the system memory
  *
@@ -1780,6 +1805,11 @@ static int smu_start_smc_engine(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
+	/* Update cached GPU addresses of BOs, which may get staled. */
+	smu_resume_fb_allocations(smu);
+	smu_resume_dummy_read_table(smu);
+
+
 	smu->smc_fw_state = SMU_FW_INIT;
 
 	if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
-- 
2.43.5

