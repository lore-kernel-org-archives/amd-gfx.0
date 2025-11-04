Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E21CCFA07
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 08:47:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 602EF10E570;
	Tue,  4 Nov 2025 08:47:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O3LEnaHg";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010036.outbound.protection.outlook.com [52.101.85.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D62B710E570
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 08:47:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wkCVwwNtnia+hX5y71kfDKrgV5sI7V49YFruv6RdvKcCfJKSk7L0uVXZCElow0YLRFtFSEnC3SUFowGPcJwVv93MOGzJHiKPxOlnog1keaN/ujRQ7B31NiC/ygnVRq/MeVPFDP2G6/S2lCLJCz4K8EsExqzAwAyAeP30BjQjxU2kfxIi1rJuqESxIROuwe2hT+L5z3Yfke240mS+P+iL8eukC6mPkjojzJQ8ILhDHqKSIXlGhccVtJvpSVZdZuPOX9WWM8P2RK+sKvY7zPuA5+W+rd7tIqKNRSV7cRraVXY/aXa+ICDRLqaEie5qtCCNQ+NTnyf6ZM2Ticymsmnw2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emELqJd3AlAespmUv+ldqDALeKYBcmtyGLk9SJKJ2j8=;
 b=nY2L+RQ0QOQj9OackU34If2Ubn6lPxcPUZVmcs0+XtxMAay/ajFYJU48j6DqZIR8CEpkHMAqH3WQPtpYeYLkVsNS+PumAoWgs0ATHVgjUiQEJ6xFmujr14aC+r+ugFggk3wL1OMnvWJpQXJV4CCWDkJfP0dE6Qot1ZoszPfkx5pQ4WlPaa9AQeKHpBXEbPriF6oNhRNdLv3oTmbfSsjqN39pS4ksx3UNROM3KBwTp29rlOQ1nm7LVwasWYFcSfLPTydeX/tCJ7ANvgGjla04CgEmk6pAuEoBQJhL2S+x3OC7vfw4TA4uZu98++I5Ohc+44ac72YbX50Dhc7y9DJEfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emELqJd3AlAespmUv+ldqDALeKYBcmtyGLk9SJKJ2j8=;
 b=O3LEnaHgF+rzCh4ckzw8NoJEv46fC7YkjM56qxCyEVZCXQDMoTdpacWeivTZ6MMT2t9JUmlbS7u/pel8wxfRWCCO7xJ3jg0rFH0VRqO1YTyTnrf4HFsEKKvGMAGrx8GoPuHC49tt2O+kxGFCzNdEEkV8gLY/2EIqMg1xcKSxsmw=
Received: from CH0PR13CA0038.namprd13.prod.outlook.com (2603:10b6:610:b2::13)
 by SA1PR12MB6870.namprd12.prod.outlook.com (2603:10b6:806:25e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 08:47:18 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::6c) by CH0PR13CA0038.outlook.office365.com
 (2603:10b6:610:b2::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 08:47:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 08:47:18 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 00:47:11 -0800
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 5/8] drm/amdgpu: load RAS bad page from PMFW in page retirement
Date: Tue, 4 Nov 2025 16:46:54 +0800
Message-ID: <20251104084657.1412130-5-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104084657.1412130-1-tao.zhou1@amd.com>
References: <20251104084657.1412130-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|SA1PR12MB6870:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ec7d9ea-4c9f-4d86-4358-08de1b7ec2da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/U8Vxf83iGGl33ERaEXExcNH1LQKi3I19SZ8b9DGBhMGCFtrMrfiu3vnVl3o?=
 =?us-ascii?Q?XUnArqiUqE4qul/GWsVub4R409tQLmfa4Erj3jA0JQwIJtW1zsma6rf/qKrl?=
 =?us-ascii?Q?nHjYO7y7Qs7m3fytls6IrGFWUFM6U9fi3GNvZGOncF99KA5DWYS3qYG0qlhE?=
 =?us-ascii?Q?1GEF+LbD0/Ul8mb78vG3oLZyR2LhUGBKPibURf/E2lVhNe/3tZWoPnX+r5AR?=
 =?us-ascii?Q?2fvhVAAj11gHcQSUXytFzEFzStUH00Cl84Yx8FWF5EEQiPVMAUYDY8/sSx+G?=
 =?us-ascii?Q?jYyH6vQM5zm/yNvw5n5LpUuy6nQ2jyPUWwAvUWYf1RDeC8RFRDFRFFGjQI/N?=
 =?us-ascii?Q?JZlEBNzYtK/N1r60mZjHq9WGJGlB7eXsC1wkXiijXlyB/IbAT1INGNujy4CK?=
 =?us-ascii?Q?eu5lzKl37YxFwjxmE8f8FvBGqH3VW65PxMn/naHs5hHtmsevfo7swBvZCqa7?=
 =?us-ascii?Q?Gz1KJYMX743WET7ybcZlQMsF7JXUg4lbLsB39mRgwuT2pUZ/q2PZWT/MYJFy?=
 =?us-ascii?Q?mogM1cmXpTrXMt9PBvyZ47M7w8XEIQmOv17aH4dpLkQY1LkeCPQUWbmvaF7k?=
 =?us-ascii?Q?OCwh2uGb2bn2312F18DoGCA84k59IWMhvfuFCkH+HDufXy5fO09vZcVPS6Tl?=
 =?us-ascii?Q?Ycy0wBJSpluxTCGB3/ORJesq3pUUXNkonc0XegkhAbAPmaduKgvefW2njWyt?=
 =?us-ascii?Q?+VonNmhdnSl3SbCTZcVTxqv0qzMQvY/yRPLHF9/T6jZytP827b5B7R178SDQ?=
 =?us-ascii?Q?xAR8QC2W7FIXJUup8yHCyDTpXJ9RLh0xVJ+/+Qon1Cf8oPPSZrLKAsaDdyCN?=
 =?us-ascii?Q?LX6Lqx0GFYUAQbKu79WzbE5TouWJcOuJxcL1enxB1FgqoC1Fx1qNS/6iayUE?=
 =?us-ascii?Q?ZYIRh0ueHT/WgvIkW8xb9kQmasln+GfPS0t5LM30reki2b8GGtAkDkGKzZtT?=
 =?us-ascii?Q?SYcbsqJMd8Y1jokDOBAVnfaahPzgDB5rV/vX4r+S/9L5ok35kVvMKsa5ZTgS?=
 =?us-ascii?Q?i66+nTLYDN2YPryeD8QrLBda8V6F5SP4ew84/b7czx9sinx3XbwpYq9Ne7ho?=
 =?us-ascii?Q?06Cw0a5Lj1RAfXUgQJnNBKvwuTT/Pyj6y+eqgGYCNDlf2wiiQhiI2GBczYlj?=
 =?us-ascii?Q?9i51qYqPySZBdx60bxLuej72w5Dmcfea+PgAIpDMEF6Pa56c7BtHsiT2FPfv?=
 =?us-ascii?Q?wfvpGPwZ5ZdXhZLVEWyJvrqIoHx4lQCGAHUajC74zuSz9XtV3k+Pf+ZqPl4B?=
 =?us-ascii?Q?yaL69hBMmRiYQBuriW5M2zw6mi5C5gGUhEg5PGenNY6VZyYN25PViPb+fSAn?=
 =?us-ascii?Q?CpmFf+/G1igx0kdNdPUaxx2HOpjWm390TSV/J2cVG7G+aVi16RvWC42Rh/CT?=
 =?us-ascii?Q?EPkdHdQJfjtWUWrnJ7+ShM9pyLcRsQZEmICqLO0WSZgdEpFK8Kz3gBGxp3V/?=
 =?us-ascii?Q?KxR95oP+LO6G7Ude5MyW+ZrCGf6LjXP5UIqgApd8SBs8DmiE8YVXRLiKLFFW?=
 =?us-ascii?Q?1OtN81zXeNZ1W5qaVOGnkNFxmV87PsGsMuTHAm71Zoa3ECv2We3IIysdk3ff?=
 =?us-ascii?Q?l0iH6+P+RfesqnBFaIU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 08:47:18.1518 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec7d9ea-4c9f-4d86-4358-08de1b7ec2da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6870
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
index 3d2d1468c531..3e372c254bd9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3310,7 +3310,13 @@ int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev,
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
index 983a428eddd4..f540ee37a4ac 100644
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

