Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0049ECCF9EE
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 10:38:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E1C110E78C;
	Wed, 29 Oct 2025 10:38:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="luaT9je5";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012017.outbound.protection.outlook.com [52.101.43.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD3C010E788
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 10:38:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GE/ed8ddB10Pb3Nwkf73dC6OwG12pfRDxT+iqg8ltVxFRoz1PWd2T6InBEYPH5T5xzka3nbzEBmTEMdvNk4a49a0DiyUW2j0yC6z3BKu6HkZntNHD0EPIu76PWejJJkKpFxJqaEFEaMVIcN4Ftkq5IMBF49FkqfP1E8Ia3cJfU5WlQruPdTBUQRSF0OTMU/zdcI4tsSAkh+WZ4T6vXnH9xy9yYKvr4q1tOuGTFHiLLxiySuUub0DAPUCV44dSXUU5X7tnZujVXhbzn22InwrCVVj0l36pfGMd5LRAOdeONLsJ59DrPFbx/lCEhFMR6bsUWqgG79DDnXvqmtxmPRuNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3OtYrfVvbJHyFyawZ7wEPcuE65QXE+PquCIsjbz40Wg=;
 b=fDUpiWcRbBh7kG4OULylFp026HG4ngy6TLSg+auFyqqVZag5CaaTOiSCt2wLV7TBBhu4gaBIN2s7STfaftlV2bIZA+YACrrWp4GB531xdYwgQzDHknWAl3V6HE0xEjKrotLuHZs5tEwjkrCKcJ/QzZgzuVYqlfBxPD64viac/dNaWHzEo2KQumMUzynzhZEuWwO+HuTBLg6wGHMbNujgiAXWr8dC3j2C7XQgZkTXi1WNc0Ri9errvbzDYX+ZxgYUF2J0FcISJW3bWlBm339yPFv9G8EvTm+CvH1yAMzIFl1hzKj9eJsvUZrEOo7CdvUWsXdc9vceb7OipdzJoY192Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3OtYrfVvbJHyFyawZ7wEPcuE65QXE+PquCIsjbz40Wg=;
 b=luaT9je5zdYSihHxbNqyw2UlNQQK4er2vEurj08JGFkXeYaKuw1GUwG2O9nREppYNaJmruzv9OfMR5HhV01+E6dcWW7sC97S5wKdB+OUk9TcO5xtCn3zg5Pq5IrEL88+FuqVtGnVoN4mmyKUXYC2p2bJu5DV3x5/h973jCkE0zM=
Received: from BN9PR03CA0355.namprd03.prod.outlook.com (2603:10b6:408:f6::30)
 by CH2PR12MB4149.namprd12.prod.outlook.com (2603:10b6:610:7c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Wed, 29 Oct
 2025 10:38:16 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:408:f6:cafe::9e) by BN9PR03CA0355.outlook.office365.com
 (2603:10b6:408:f6::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Wed,
 29 Oct 2025 10:38:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Wed, 29 Oct 2025 10:38:16 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 03:38:15 -0700
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 5/8] drm/amdgpu: load RAS bad page from PMFW in page retirement
Date: Wed, 29 Oct 2025 18:37:59 +0800
Message-ID: <20251029103802.1402199-5-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029103802.1402199-1-tao.zhou1@amd.com>
References: <20251029103802.1402199-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|CH2PR12MB4149:EE_
X-MS-Office365-Filtering-Correlation-Id: d4ca0191-7e22-4b9b-274a-08de16d74514
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FmlamCjTcTy6BWw7JwfpQt/Th5Qexv8x/oOeAJvBUsR91d8Ul4tatOzbO1a8?=
 =?us-ascii?Q?oL1rTQaaHdY8Z0UwHxy39vJt11U7+xPV5nFXSoAf3fBfmWhT5RHqrDfzI3G5?=
 =?us-ascii?Q?Vag/mV+R3OpbYYd1KFxpvEdN3CUDISRW6kfID6aIixbMqjmXzjzVz6qQWSiL?=
 =?us-ascii?Q?X7+xmgdmWeZESNvRkctY+Sko3Z7R7e7iKv4uorubBcSRgt4W2iZU2xD+bnfh?=
 =?us-ascii?Q?J5L3G4V72cOFEKmy+Ha9JRYFFRtXzr8NeD1mrMU5kJqOwmUgEGSk7REsRtl5?=
 =?us-ascii?Q?4m86o1+vSL0OKrtuzjwzQa8rHfgu0dnO6CeTiIsThiBRmVcWQc7K3BgwPsX4?=
 =?us-ascii?Q?qYHua/pD98c3TQ1/XJGV20zJkz1diQh2/ovp4vlZlywx+tT8i7ZojX1sKR+x?=
 =?us-ascii?Q?j3VrJ4SmfLFp5GVCrKDZoyUrjyg+k+1DEqWHB/P2ceUcOHTa+LJfo5CwtoGT?=
 =?us-ascii?Q?sg4/31mFx+7U0CI8LqIiOfB9Lq9Q3wnHcIeZlspQBN9e5czG3HYZmbbuCLjq?=
 =?us-ascii?Q?xVsUQXu66sUnLngS7zpx3yRkhx2Ax9XPhsjcUdG2hWLMGQ3WDRA6XzFB5Ic6?=
 =?us-ascii?Q?AqlusUTzLJmOMirHmr6Q+NQcvcw40o28Iz4DFJyf8aa+kba4BCFoMf0VdAni?=
 =?us-ascii?Q?a5vvZBXxl7w5znw/6IJqFJlLh9oaWXoyljdGW2wgRY/7oXUNPnZrw46NQLxW?=
 =?us-ascii?Q?ES8Ynz/t3R05YgqMCEEmVILiJygSFE01OAYdvIu9/1Q0Z89nq4+FEQpXZRof?=
 =?us-ascii?Q?TMUq+lh3nofbmpKg2+5vjbnpOPWgwLlnP5yHfGhMskOP3zJAcem0VInqpB/C?=
 =?us-ascii?Q?8oqRQOPx4Uq5eQKGfiHuNqsljfU7A5ogeARbfzcoxgPc3RlA8KowVGVTZwO8?=
 =?us-ascii?Q?b4WCg3SYSxMOXe13ZCJ5VqXAtyDsT0JSHwWTPg5wMOZ6i9tuVUPcgtWG8Bh2?=
 =?us-ascii?Q?j4lqmMGrE5nKB3VeVCmwW0AETRV8yEI58LapQapFjaEl9+3yp3yNXy/U5+3B?=
 =?us-ascii?Q?qS6ImF491ksjqFtE5hRXo0UKq82+6o08+xBSt86lF7arKs6QxGVa/jEfTMjg?=
 =?us-ascii?Q?I5BAyLeHhv7Ss1X5W/j61JDG4tzM2OYfrfTxIuOt90tbKS0fb6WfmwdikM1x?=
 =?us-ascii?Q?7qWy2j1HvUvqxGXOKk6dsSJJEyr4LTX1WVkcYlXvW7a3mSd5gtq2R8UZAWdF?=
 =?us-ascii?Q?9JHWhVv7lpWK6XaywpOg1vmpBE5yVm0T5R+jzZyDSvoJuSG3ZYs7bnhINyGF?=
 =?us-ascii?Q?iCEtN0AKA3L6s/XDHUQCZU23WkSUnrcXifQD8Mpe5YksB/BxEZD1QEJdcM4s?=
 =?us-ascii?Q?vBsAJchTJlegzrQEniubWOrw7M0ld1vb0rFeTJJBgqyvKpqx7/z5bCFOrDNV?=
 =?us-ascii?Q?0lP9I0acmL57uMwFhMDTE/mrCTSlmNNcMBigZ+KgjWGomGfomIeiY3vh1bbv?=
 =?us-ascii?Q?97ZORwBdtYAEpzZLOXbVpGWICQCbXRKbiIMfHnQWT0bKXnlOk4UPqkxs5FbA?=
 =?us-ascii?Q?6mlmtHQH0PblEGe/2WqgBXr5oIJVK9pomV5G4IRlgZAxwvKGpb/eVxnBOJju?=
 =?us-ascii?Q?ZeDlIH0ZcHGWsHHBqiQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 10:38:16.5495 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ca0191-7e22-4b9b-274a-08de16d74514
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4149
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

In legacy way, bad page is queried from MCA registers, switch to
getting it from PMFW when PMFW manages eeprom data.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 137 ++++++++++++++----------
 2 files changed, 90 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index e7c36166e889..23d421b8ba54 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3296,7 +3296,13 @@ int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev,
 	mutex_lock(&con->recovery_lock);
 	control = &con->eeprom_control;
 	data = con->eh_data;
-	unit_num = data->count / adev->umc.retire_unit - control->ras_num_recs;
+	if (amdgpu_ras_smu_eeprom_supported(adev))
+		unit_num = control->ras_num_recs -
+			control->ras_num_recs_old;
+	else
+		unit_num = data->count / adev->umc.retire_unit -
+			control->ras_num_recs;
+
 	save_count = con->bad_page_num - control->ras_num_bad_pages;
 	mutex_unlock(&con->recovery_lock);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 2e039fb778ea..3eb252de343b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -96,67 +96,96 @@ void amdgpu_umc_handle_bad_pages(struct amdgpu_device *adev,
 {
 	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	struct amdgpu_ras_eeprom_control *control = &con->eeprom_control;
 	unsigned int error_query_mode;
 	int ret = 0;
 	unsigned long err_count;
 
 	amdgpu_ras_get_error_query_mode(adev, &error_query_mode);
 
+	err_data->err_addr =
+		kcalloc(adev->umc.max_ras_err_cnt_per_query,
+			sizeof(struct eeprom_table_record), GFP_KERNEL);
+
+	/* still call query_ras_error_address to clear error status
+	 * even NOMEM error is encountered
+	 */
+	if (!err_data->err_addr)
+		dev_warn(adev->dev,
+			"Failed to alloc memory for umc error address record!\n");
+	else
+		err_data->err_addr_len = adev->umc.max_ras_err_cnt_per_query;
+
 	mutex_lock(&con->page_retirement_lock);
-	ret = amdgpu_dpm_get_ecc_info(adev, (void *)&(con->umc_ecc));
-	if (ret == -EOPNOTSUPP &&
-	    error_query_mode == AMDGPU_RAS_DIRECT_ERROR_QUERY) {
-		if (adev->umc.ras && adev->umc.ras->ras_block.hw_ops &&
-		    adev->umc.ras->ras_block.hw_ops->query_ras_error_count)
-		    adev->umc.ras->ras_block.hw_ops->query_ras_error_count(adev, ras_error_status);
-
-		if (adev->umc.ras && adev->umc.ras->ras_block.hw_ops &&
-		    adev->umc.ras->ras_block.hw_ops->query_ras_error_address &&
-		    adev->umc.max_ras_err_cnt_per_query) {
-			err_data->err_addr =
-				kcalloc(adev->umc.max_ras_err_cnt_per_query,
-					sizeof(struct eeprom_table_record), GFP_KERNEL);
-
-			/* still call query_ras_error_address to clear error status
-			 * even NOMEM error is encountered
-			 */
-			if(!err_data->err_addr)
-				dev_warn(adev->dev, "Failed to alloc memory for "
-						"umc error address record!\n");
-			else
-				err_data->err_addr_len = adev->umc.max_ras_err_cnt_per_query;
-
-			/* umc query_ras_error_address is also responsible for clearing
-			 * error status
-			 */
-			adev->umc.ras->ras_block.hw_ops->query_ras_error_address(adev, ras_error_status);
+	if (!amdgpu_ras_smu_eeprom_supported(adev)) {
+		ret = amdgpu_dpm_get_ecc_info(adev, (void *)&(con->umc_ecc));
+		if (ret == -EOPNOTSUPP &&
+		    error_query_mode == AMDGPU_RAS_DIRECT_ERROR_QUERY) {
+			if (adev->umc.ras && adev->umc.ras->ras_block.hw_ops &&
+			    adev->umc.ras->ras_block.hw_ops->query_ras_error_count)
+				adev->umc.ras->ras_block.hw_ops->query_ras_error_count(adev,
+								ras_error_status);
+
+			if (adev->umc.ras && adev->umc.ras->ras_block.hw_ops &&
+			    adev->umc.ras->ras_block.hw_ops->query_ras_error_address &&
+			    adev->umc.max_ras_err_cnt_per_query) {
+				err_data->err_addr =
+					kcalloc(adev->umc.max_ras_err_cnt_per_query,
+						sizeof(struct eeprom_table_record), GFP_KERNEL);
+
+				/* still call query_ras_error_address to clear error status
+				 * even NOMEM error is encountered
+				 */
+				if (!err_data->err_addr)
+					dev_warn(adev->dev,
+						"Failed to alloc memory for umc error address record!\n");
+				else
+					err_data->err_addr_len =
+						adev->umc.max_ras_err_cnt_per_query;
+
+				/* umc query_ras_error_address is also responsible for clearing
+				 * error status
+				 */
+				adev->umc.ras->ras_block.hw_ops->query_ras_error_address(adev,
+								ras_error_status);
+			}
+		} else if (error_query_mode == AMDGPU_RAS_FIRMWARE_ERROR_QUERY ||
+		    (!ret && error_query_mode == AMDGPU_RAS_DIRECT_ERROR_QUERY)) {
+			if (adev->umc.ras &&
+			    adev->umc.ras->ecc_info_query_ras_error_count)
+				adev->umc.ras->ecc_info_query_ras_error_count(adev,
+								ras_error_status);
+
+			if (adev->umc.ras &&
+			    adev->umc.ras->ecc_info_query_ras_error_address &&
+			    adev->umc.max_ras_err_cnt_per_query) {
+				err_data->err_addr =
+					kcalloc(adev->umc.max_ras_err_cnt_per_query,
+						sizeof(struct eeprom_table_record), GFP_KERNEL);
+
+				/* still call query_ras_error_address to clear error status
+				 * even NOMEM error is encountered
+				 */
+				if (!err_data->err_addr)
+					dev_warn(adev->dev,
+						"Failed to alloc memory for umc error address record!\n");
+				else
+					err_data->err_addr_len =
+						adev->umc.max_ras_err_cnt_per_query;
+
+				/* umc query_ras_error_address is also responsible for clearing
+				 * error status
+				 */
+				adev->umc.ras->ecc_info_query_ras_error_address(adev,
+								ras_error_status);
+			}
 		}
-	} else if (error_query_mode == AMDGPU_RAS_FIRMWARE_ERROR_QUERY ||
-	    (!ret && error_query_mode == AMDGPU_RAS_DIRECT_ERROR_QUERY)) {
-		if (adev->umc.ras &&
-		    adev->umc.ras->ecc_info_query_ras_error_count)
-		    adev->umc.ras->ecc_info_query_ras_error_count(adev, ras_error_status);
-
-		if (adev->umc.ras &&
-		    adev->umc.ras->ecc_info_query_ras_error_address &&
-		    adev->umc.max_ras_err_cnt_per_query) {
-			err_data->err_addr =
-				kcalloc(adev->umc.max_ras_err_cnt_per_query,
-					sizeof(struct eeprom_table_record), GFP_KERNEL);
-
-			/* still call query_ras_error_address to clear error status
-			 * even NOMEM error is encountered
-			 */
-			if(!err_data->err_addr)
-				dev_warn(adev->dev, "Failed to alloc memory for "
-						"umc error address record!\n");
-			else
-				err_data->err_addr_len = adev->umc.max_ras_err_cnt_per_query;
-
-			/* umc query_ras_error_address is also responsible for clearing
-			 * error status
-			 */
-			adev->umc.ras->ecc_info_query_ras_error_address(adev, ras_error_status);
+	} else {
+		if (!amdgpu_ras_eeprom_update_record_num(control)) {
+			err_data->err_addr_cnt = err_data->de_count =
+				control->ras_num_recs -	control->ras_num_recs_old;
+			amdgpu_ras_eeprom_read_idx(control, err_data->err_addr,
+				control->ras_num_recs_old, err_data->de_count);
 		}
 	}
 
@@ -166,7 +195,7 @@ void amdgpu_umc_handle_bad_pages(struct amdgpu_device *adev,
 		if ((amdgpu_bad_page_threshold != 0) &&
 			err_data->err_addr_cnt) {
 			amdgpu_ras_add_bad_pages(adev, err_data->err_addr,
-						err_data->err_addr_cnt, false);
+				err_data->err_addr_cnt, amdgpu_ras_smu_eeprom_supported(adev));
 			amdgpu_ras_save_bad_pages(adev, &err_count);
 
 			amdgpu_dpm_send_hbm_bad_pages_num(adev,
-- 
2.34.1

