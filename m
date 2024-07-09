Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C03CC2BD09
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jul 2024 05:56:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB9B810E2A4;
	Tue,  9 Jul 2024 05:56:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WonIMSo+";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CCEA10E481
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jul 2024 05:56:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n8w3i4FjyBxhzxXRFaKJSM3kPxDj+WfNxXGrLyVPOpijKrQpQf7+ea0ia/7pkkNBw+H3HaZhdbTmu+tv+E5NE5wZPXPJql8KqcFzntdzpXJUP5dFD6+yPrcuL2xEqv4VRzU/oWsYHSjfTZIiZQ2exSwR7b/THqPjtz3vvcAhltK+OFVV0nxrxFDr98meP0Mush0pABshCZrsi56MgBlWjhCqRI3U+kmC9d0R9ek7BRwdrt+jWf/j5R6WdM5otxPV9bsGFOSnDwTMvHQUpzN9SGuxsBuvAJs+ppRAuYxNKnbw8BIrCMwzqUrkS57h9tGD28ZzfqdmMxi2oKhtZcrnKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XadFJXwTHdQzSonJIjZXFBc7ooOiFZt3t7ILuwD3PbU=;
 b=dLyqW5+ouRz7UyW5NSEzEPt+Qpv1BNoHnyyK1LUhEvLEIW655tbKgsrYD/8vJa8YIMsBhpVVOLRA6rLuvAkNQHLaXD497d+jgLvzJ9BcZA4rhdDeXEGe6EnHDWYp1SuAqO6b9W7l4EgFpfabZjMqhKbiV0QP9QAho/NMK4FHBqGsBA4gznQPd/cu47BGpGoAPwFdae40DVet+UjSPU+mZOiAGTzwn2duR6OeWq9Z+pvLgmjoPpgepTkZzf6Ck5CDsnRIERfSM70QcZsahVTb/9KAEZYyaShQ84Y33WWybInYDr9bDRtuVzVk4we6CWxt4EVBBrqNtfZo/Qj/DjZmIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XadFJXwTHdQzSonJIjZXFBc7ooOiFZt3t7ILuwD3PbU=;
 b=WonIMSo+PemBFoMCXakdgldkLrO61xtwx4gvo9ahieraJNZvDToheh2OnYasmun0DbBl0v/kZ/iiQhVzbmGOefIb90I4WB5MQOplIKLMlaiP84stPEtXjwpKqNPbnSRXW63sJ0ZimTE0R6dd5qiJA0S2mrqZ4tHTZDnwNbN0NtA=
Received: from BL0PR01CA0003.prod.exchangelabs.com (2603:10b6:208:71::16) by
 DM4PR12MB6062.namprd12.prod.outlook.com (2603:10b6:8:b2::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.26; Tue, 9 Jul 2024 05:56:45 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:71:cafe::9f) by BL0PR01CA0003.outlook.office365.com
 (2603:10b6:208:71::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Tue, 9 Jul 2024 05:56:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Tue, 9 Jul 2024 05:56:45 +0000
Received: from amd-02.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 9 Jul
 2024 00:56:42 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH V2 1/2] drm/amdgpu: flush all cached ras bad pages to eeprom
Date: Tue, 9 Jul 2024 13:56:05 +0800
Message-ID: <20240709055606.53567-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|DM4PR12MB6062:EE_
X-MS-Office365-Filtering-Correlation-Id: e251dbb7-68b7-4cca-c37a-08dc9fdbe9fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h9UK7aXqbrV3EFE5de83i35XceYTBwWTyc6/w3qFLrQIcegSCl2sgaGn6ffU?=
 =?us-ascii?Q?0s4616wXho8FIFqtVh8zHM/lZ5C+PVJwA/C6GDal+HFzl0zWRiXiOAsDlRTk?=
 =?us-ascii?Q?yOdq/XU+46+uqhctvWPfzyTs/CDj7MvaN2k9H4MUcn8KV52hEIHQB1kEFcUt?=
 =?us-ascii?Q?s4IrKlkoDDKagnKXMWWc9OEeIonMoodyh4tjezjJOpE8UC+eAGMrKyzMdrJg?=
 =?us-ascii?Q?Ln7PJY552JRBDPaU/dtJ4h5Q3WAHtkquricyOyWmGK4DL8E0819UkvQsPPk4?=
 =?us-ascii?Q?9Fy66f6ROeyRSctdvfGeq+053R+uRCPjojYl+hKKVHFHV127R9dG+xXiB4+9?=
 =?us-ascii?Q?3Uu6I0B79J6COlRR7YPUjk0NUZfQLfAuWyqkBmh8mBckkWV0ezVAaxKvUzj/?=
 =?us-ascii?Q?OOPc7oXXsU0NFhXYlO3pkqUX8ZsqqHstOW7GSYoiBJzO2sGaMBl5fFb6nsQw?=
 =?us-ascii?Q?kVM0234rGknwQO5TQXKjFI7PjH39+TyC6Se9D0BORXO+IyRRHsC8cR3Gu2Ho?=
 =?us-ascii?Q?JxQF2396buL5xZEqtGEbsW/3FLZRnpa1W/zljyitn2QArELEP2CpP/DxnsdZ?=
 =?us-ascii?Q?W7vaeajNyz6kmPb3kZg3Y5xJsti24jMazp4lHqRK9fQRMu+vK4XRnac3CBgY?=
 =?us-ascii?Q?CXLyQK7+nbyt2QxwfBN3eId+0iZaw5vchQ0ZBaIK9XhLQVtiGvqdUFUH4NCz?=
 =?us-ascii?Q?ZJ8HoAy3vqTlZKQHVTJ/crEvmihrnBtiM2k2bMVBEoR3ld5PsB0chi6TxUwY?=
 =?us-ascii?Q?CFxjrDi0CP6mmfUd+suop+PVZQyrHSEzTOTky4izQSDsMwVVMJGiCM6rReEb?=
 =?us-ascii?Q?V4TzrVNk9wizerLqGeAilYKUHLd+3UN2VhLOvFH0SV8HVMdJ9gaTMvuT0U68?=
 =?us-ascii?Q?ULj9Gmf2YLVHYPS6gQ96HOuhoNetOjADtNztRvMxuSKseAYrFeYm/7jA6Vr8?=
 =?us-ascii?Q?3h2gBUiFr28PYef7rpCh2hLBZrRr49/V97fJYGIns4z0E89teV4C05ngb9iy?=
 =?us-ascii?Q?+QpAmLBIymdloqXV7jMrv0wCVjy+QHzgGPp9t6ihcEXW5arA+AvI4sf20d5B?=
 =?us-ascii?Q?fjXbkDESY1MWuWROGOqiSM6mtUQQj11p3Jbuiw5X+5fCPXLpwEpyRbvGU2MK?=
 =?us-ascii?Q?8+INsVY+JQpyKfJAwulNaYXs0kn+KLXhxH+sIrOmaA5TepTR2/3WZdDPQmE+?=
 =?us-ascii?Q?eqw2nX5tirZ919a6TnIPYXkDPj+xpJRfHdOBhWutAMUCuRH2rt4HQHJA5vm7?=
 =?us-ascii?Q?K5MLA6gcL6KAo5TNyaMskhAquXSgUNNJFEhmk7H9poEtVcfbwlnn1Vs21BFb?=
 =?us-ascii?Q?j/iIPTFQep3g8FGDL3QgbhZZ1kX4SoKD5Z0QtrNeqMK/fjvFqzKOYh/L+njv?=
 =?us-ascii?Q?WIt/OqNd/KSOtqb3qyLOtSGh/ntPcdaY/NxWVLnVAIacUTnvp/L/6bUcZA7q?=
 =?us-ascii?Q?5OtcMJFscwRx+qE4GPk9H0TO7I/Ck6vk?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 05:56:45.0047 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e251dbb7-68b7-4cca-c37a-08dc9fdbe9fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6062
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

Before uninstalling gpu driver, flush all cached ras
bad pages to eeprom.

v2:
  Put the same code into a function and reuse the function.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 35 ++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 0e748cd55d43..d923151af752 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -124,6 +124,8 @@ const char *get_ras_block_str(struct ras_common_if *ras_block)
 
 #define AMDGPU_RAS_RETIRE_PAGE_INTERVAL 100  //ms
 
+#define MAX_FLUSH_RETIRE_DWORK_TIMES  100
+
 enum amdgpu_ras_retire_page_reservation {
 	AMDGPU_RAS_RETIRE_PAGE_RESERVED,
 	AMDGPU_RAS_RETIRE_PAGE_PENDING,
@@ -2837,6 +2839,23 @@ static void amdgpu_ras_ecc_log_fini(struct ras_ecc_log_info *ecc_log)
 }
 #endif
 
+static bool amdgpu_ras_schedule_retirement_dwork(struct amdgpu_ras *con,
+				uint32_t delayed_ms)
+{
+	int ret;
+
+	mutex_lock(&con->umc_ecc_log.lock);
+	ret = radix_tree_tagged(&con->umc_ecc_log.de_page_tree,
+			UMC_ECC_NEW_DETECTED_TAG);
+	mutex_unlock(&con->umc_ecc_log.lock);
+
+	if (ret)
+		schedule_delayed_work(&con->page_retirement_dwork,
+			msecs_to_jiffies(delayed_ms));
+
+	return ret ? true : false;
+}
+
 static void amdgpu_ras_do_page_retirement(struct work_struct *work)
 {
 	struct amdgpu_ras *con = container_of(work, struct amdgpu_ras,
@@ -2858,12 +2877,8 @@ static void amdgpu_ras_do_page_retirement(struct work_struct *work)
 	if (err_cnt && con->is_rma)
 		amdgpu_ras_reset_gpu(adev);
 
-	mutex_lock(&con->umc_ecc_log.lock);
-	if (radix_tree_tagged(&con->umc_ecc_log.de_page_tree,
-				UMC_ECC_NEW_DETECTED_TAG))
-		schedule_delayed_work(&con->page_retirement_dwork,
-			msecs_to_jiffies(AMDGPU_RAS_RETIRE_PAGE_INTERVAL));
-	mutex_unlock(&con->umc_ecc_log.lock);
+	amdgpu_ras_schedule_retirement_dwork(con,
+			AMDGPU_RAS_RETIRE_PAGE_INTERVAL);
 }
 
 static int amdgpu_ras_poison_creation_handler(struct amdgpu_device *adev,
@@ -3179,11 +3194,19 @@ static int amdgpu_ras_recovery_fini(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_err_handler_data *data = con->eh_data;
+	int max_flush_timeout = MAX_FLUSH_RETIRE_DWORK_TIMES;
+	bool ret;
 
 	/* recovery_init failed to init it, fini is useless */
 	if (!data)
 		return 0;
 
+	/* Save all cached bad pages to eeprom */
+	do {
+		flush_delayed_work(&con->page_retirement_dwork);
+		ret = amdgpu_ras_schedule_retirement_dwork(con, 0);
+	} while (ret && max_flush_timeout--);
+
 	if (con->page_retirement_thread)
 		kthread_stop(con->page_retirement_thread);
 
-- 
2.34.1

