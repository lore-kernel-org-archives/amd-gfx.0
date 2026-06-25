Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8129BCDB47F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 08:21:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10D6410F188;
	Thu, 25 Jun 2026 08:21:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="02mKPDaW";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010058.outbound.protection.outlook.com
 [52.101.193.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9AF510F188
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 08:21:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QLcW5mEF0uQUwfA4hbiW+uWlTTS4AtvVqkLstsbNdYOLzGD2eOqZpG2o5b4/hvv9MbVwMmxFw2elQag42vcd98jerkZZ9rwXl+Gf/2bTH1qEEi/RYsbtxdSrKV34pAaLsdvcqQjxDDpJLXR+kE9F+FnF2uSoi/6j3/brxqT24ChKMxlcdeISmFRCOaBpfe0ZIs2HIdqE2NPWh5A6WcnfQMSq5bvh3xX0FZM2A5xuaEyK9vnJrHJIoA2tZOBa08MWD257YNMkUAxsNR6d4Y1lyAPdKGrpHE25QUBBEu4QG1AHByKwJ0pNrhxz1HWWYJOFFHXjgqQ2Vb5lWycq7wawCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wdi3h09jcf/e7lkG97M21FeFKlscK4LB4asa/9a3lws=;
 b=LhvwVoM57gF2OlztO5hm3Ltvw05vh7BUBYe+Wa4stlcZ6P0X2Bhvv5OETDaLMCbigzRr0Y1BEinuuPTKP68kMiDDzW4gDQ/vODqkcnt/dBC9ZHOpOwcAYTQmMRhs1Ow3Kc56LPaBHep9YtbuHK4BG8Jt23xcp2c/bvtUD/hbaOWqsEFLevwsUm8/VCz14c3JhtlIZNK8BAptIRw/J8mwvY0k7AoXNduSkZSfWLlzrDogrDz4WbzYayT2hkKQYCooTNw0mAgiqbNNB3bVfmKEfOOpngLHzJlLeQwesw/CChzn2SimmgUgRYWA6GJRChfHt3N67WfNKbZ70CoH2ClU0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdi3h09jcf/e7lkG97M21FeFKlscK4LB4asa/9a3lws=;
 b=02mKPDaWX+8iRjBMqpdhvRTlRqs2/oBOR9r+Cf+h3chTxHoPjoTs4b3QORQ8QD4C/zKVbEQi0xPyvIqA2nh8EhD+yHJiAu0f2M18Kd4s8X4OVycpvPJAL/TJ8h6utMg+q6ag+TJm+xo5nU8uJmb7AAkHzl/8+4Kij4Nat0gtJ9s=
Received: from PH8PR07CA0029.namprd07.prod.outlook.com (2603:10b6:510:2cf::27)
 by DS7PR12MB6192.namprd12.prod.outlook.com (2603:10b6:8:97::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.11; Thu, 25 Jun 2026 08:21:09 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:510:2cf:cafe::1) by PH8PR07CA0029.outlook.office365.com
 (2603:10b6:510:2cf::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.17 via Frontend Transport; Thu,
 25 Jun 2026 08:21:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 08:21:08 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 03:21:06 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v3 29/44] drm/amdgpu: retire legacy PMFW bad page loading in
 page
Date: Thu, 25 Jun 2026 16:19:22 +0800
Message-ID: <c7c4234d9286837238a59f05e4a2f57fda6f4cf0.1782373702.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <b5587fca5f57f8f352245edf2c76606ad3307923.1782373701.git.cesun102@amd.com>
References: <b5587fca5f57f8f352245edf2c76606ad3307923.1782373701.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|DS7PR12MB6192:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a36dab3-84d7-44a8-8b22-08ded292b58c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: cMAFMXo58kN38w+BxxZdCUzERwIOCO9491In3UldVsA2C/arhtKeAIRbCEo86yKyuu60XsuVZQaQJjzzY0lfmZ3nnDfh6AlYs5Pmb5GAxUZ9lUL4H0NYLGol6oFKg0dTEkApizEIKEdnLoLNEzcrDNeK1zOSd4LrO9mmXluB8PYr1ZCy4yLMPruAEtvmzVn9/VgFg3389qUp5LHrAffZHyGBfwBgdioS/l+eRCsFNLKDu5PvpEboWrGk34MKbqJhV5j1CX0oA0+uiZhUvwYim4KX8LrMOfcxfnAg8pp/FEbvbFeVDw3frHL+9sBCJhQN29S2BX1Xhn6Qe3lqpYISDJAwGMnC6DvBAetzboFuZnKorh2Qe0bYHKoLO32yWZ1mEipkR6YguqCyp/j2eTpGSubBkCF1mpMkI82FOmIzBBjf14fAxCnt9tekcF6L979Av0xMtP0KWpHg5kiCv7L5fOUf87KySgTyxQMo9qH7ocy8z4Cqv6DVpcTZvtuOfn666yp0sejRVDfBrOLLzHUaTB6aJLdXYgC3x5GIXH2DCh//WuFR3fxZ0SuDLpZ2y/anleCpdTffOg136d1NHwZuSVifAw3xv/phGjWJis87OLBZg4719rHZAX/yfRxRC3ASfilx+tYH/BPLbuzZtRreYHfhVVsZ2kryj5YDpwk66/FaTtiGa6+ouaj59f3QEzH0ONpYoldZE39+wqyRQbyyrw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7LyxdEVH61ZEO80Cx7PIXgDDb4tNbvUsczuaEQ4QaHs4TYZBEzR2EQgIKRzUWKQ1FOGx+s3rcJ5ijpil32N742XVmLmpoNKS7NlA9sk3bhf6pza7uxa0BCX6OZ76AHXJiGXT847T18rYH/e1je5lS8kkJuljkq/SPVW4wC9+NC0skkeOMeVZKYFDk0ZXoX8Bmfbo8zV0g9QqLqutyMYen3A4gDdKkpcqyWiAjrCGONovGMWBvW0iv13wkC2mhCrOTD8Z/p4EBw+xcsaRbv+/Mlw+HnEFkBO4Aw3Yyem8GjdE21hxl2afTfnGKJERpVEWA52wippL2a1cfWJNOSn7oysYIm/P6B/mLsG3N8rW9klb5T8tS8n4owYIQtMM2OWkpJtx9biFfVHmHVMTipYH/Z/nfwCa3RIDCaZSifadN8aduElbqKEvd/dbGIT8bud2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 08:21:08.5478 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a36dab3-84d7-44a8-8b22-08ded292b58c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6192
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

Remove the legacy logic that loads RAS bad pages from PMFW during
page retirement

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 130 +++++++++++-------------
 2 files changed, 60 insertions(+), 77 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 69fca6aacdc7..996152dadd86 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3045,12 +3045,7 @@ int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev,
 	mutex_lock(&con->recovery_lock);
 	control = &con->eeprom_control;
 	data = con->eh_data;
-	if (amdgpu_ras_smu_eeprom_supported(adev))
-		unit_num = control->ras_num_recs -
-			control->ras_num_recs_old;
-	else
-		unit_num = data->count / adev->umc.retire_unit -
-			control->ras_num_recs;
+	unit_num = data->count / adev->umc.retire_unit - control->ras_num_recs;
 
 	save_count = con->bad_page_num - control->ras_num_bad_pages;
 	mutex_unlock(&con->recovery_lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index a99f1bae7a8f..7f893dd803b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -97,7 +97,6 @@ void amdgpu_umc_handle_bad_pages(struct amdgpu_device *adev,
 {
 	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-	struct amdgpu_ras_eeprom_control *control = &con->eeprom_control;
 	unsigned int error_query_mode;
 	int ret = 0;
 	unsigned long err_count;
@@ -118,77 +117,66 @@ void amdgpu_umc_handle_bad_pages(struct amdgpu_device *adev,
 		err_data->err_addr_len = adev->umc.max_ras_err_cnt_per_query;
 
 	mutex_lock(&con->page_retirement_lock);
-	if (!amdgpu_ras_smu_eeprom_supported(adev)) {
-		ret = amdgpu_dpm_get_ecc_info(adev, (void *)&(con->umc_ecc));
-		if (ret == -EOPNOTSUPP &&
-		    error_query_mode == AMDGPU_RAS_DIRECT_ERROR_QUERY) {
-			if (adev->umc.ras && adev->umc.ras->ras_block.hw_ops &&
-			    adev->umc.ras->ras_block.hw_ops->query_ras_error_count)
-				adev->umc.ras->ras_block.hw_ops->query_ras_error_count(adev,
-								ras_error_status);
-
-			if (adev->umc.ras && adev->umc.ras->ras_block.hw_ops &&
-			    adev->umc.ras->ras_block.hw_ops->query_ras_error_address &&
-			    adev->umc.max_ras_err_cnt_per_query) {
-				kfree(err_data->err_addr);
-				err_data->err_addr =
-					kcalloc(adev->umc.max_ras_err_cnt_per_query,
-						sizeof(struct eeprom_table_record), GFP_KERNEL);
-
-				/* still call query_ras_error_address to clear error status
-				 * even NOMEM error is encountered
-				 */
-				if (!err_data->err_addr)
-					dev_warn(adev->dev,
-						"Failed to alloc memory for umc error address record!\n");
-				else
-					err_data->err_addr_len =
-						adev->umc.max_ras_err_cnt_per_query;
-
-				/* umc query_ras_error_address is also responsible for clearing
-				 * error status
-				 */
-				adev->umc.ras->ras_block.hw_ops->query_ras_error_address(adev,
-								ras_error_status);
-			}
-		} else if (error_query_mode == AMDGPU_RAS_FIRMWARE_ERROR_QUERY ||
-		    (!ret && error_query_mode == AMDGPU_RAS_DIRECT_ERROR_QUERY)) {
-			if (adev->umc.ras &&
-			    adev->umc.ras->ecc_info_query_ras_error_count)
-				adev->umc.ras->ecc_info_query_ras_error_count(adev,
-								ras_error_status);
-
-			if (adev->umc.ras &&
-			    adev->umc.ras->ecc_info_query_ras_error_address &&
-			    adev->umc.max_ras_err_cnt_per_query) {
-				kfree(err_data->err_addr);
-				err_data->err_addr =
-					kcalloc(adev->umc.max_ras_err_cnt_per_query,
-						sizeof(struct eeprom_table_record), GFP_KERNEL);
-
-				/* still call query_ras_error_address to clear error status
-				 * even NOMEM error is encountered
-				 */
-				if (!err_data->err_addr)
-					dev_warn(adev->dev,
-						"Failed to alloc memory for umc error address record!\n");
-				else
-					err_data->err_addr_len =
-						adev->umc.max_ras_err_cnt_per_query;
-
-				/* umc query_ras_error_address is also responsible for clearing
-				 * error status
-				 */
-				adev->umc.ras->ecc_info_query_ras_error_address(adev,
-								ras_error_status);
-			}
+	ret = amdgpu_dpm_get_ecc_info(adev, (void *)&(con->umc_ecc));
+	if (ret == -EOPNOTSUPP &&
+	    error_query_mode == AMDGPU_RAS_DIRECT_ERROR_QUERY) {
+		if (adev->umc.ras && adev->umc.ras->ras_block.hw_ops &&
+		    adev->umc.ras->ras_block.hw_ops->query_ras_error_count)
+			adev->umc.ras->ras_block.hw_ops->query_ras_error_count(adev,
+							ras_error_status);
+
+		if (adev->umc.ras && adev->umc.ras->ras_block.hw_ops &&
+		    adev->umc.ras->ras_block.hw_ops->query_ras_error_address &&
+		    adev->umc.max_ras_err_cnt_per_query) {
+			err_data->err_addr =
+				kcalloc(adev->umc.max_ras_err_cnt_per_query,
+					sizeof(struct eeprom_table_record), GFP_KERNEL);
+
+			/* still call query_ras_error_address to clear error status
+			 * even NOMEM error is encountered
+			 */
+			if (!err_data->err_addr)
+				dev_warn(adev->dev,
+					"Failed to alloc memory for umc error address record!\n");
+			else
+				err_data->err_addr_len =
+					adev->umc.max_ras_err_cnt_per_query;
+
+			/* umc query_ras_error_address is also responsible for clearing
+			 * error status
+			 */
+			adev->umc.ras->ras_block.hw_ops->query_ras_error_address(adev,
+							ras_error_status);
 		}
-	} else {
-		if (!amdgpu_ras_eeprom_update_record_num(control)) {
-			err_data->err_addr_cnt = err_data->de_count =
-				control->ras_num_recs -	control->ras_num_recs_old;
-			amdgpu_ras_eeprom_read_idx(control, err_data->err_addr,
-				control->ras_num_recs_old, err_data->de_count);
+	} else if (error_query_mode == AMDGPU_RAS_FIRMWARE_ERROR_QUERY ||
+	    (!ret && error_query_mode == AMDGPU_RAS_DIRECT_ERROR_QUERY)) {
+		if (adev->umc.ras &&
+		    adev->umc.ras->ecc_info_query_ras_error_count)
+			adev->umc.ras->ecc_info_query_ras_error_count(adev,
+							ras_error_status);
+
+		if (adev->umc.ras &&
+		    adev->umc.ras->ecc_info_query_ras_error_address &&
+		    adev->umc.max_ras_err_cnt_per_query) {
+			err_data->err_addr =
+				kcalloc(adev->umc.max_ras_err_cnt_per_query,
+					sizeof(struct eeprom_table_record), GFP_KERNEL);
+
+			/* still call query_ras_error_address to clear error status
+			 * even NOMEM error is encountered
+			 */
+			if (!err_data->err_addr)
+				dev_warn(adev->dev,
+					"Failed to alloc memory for umc error address record!\n");
+			else
+				err_data->err_addr_len =
+					adev->umc.max_ras_err_cnt_per_query;
+
+			/* umc query_ras_error_address is also responsible for clearing
+			 * error status
+			 */
+			adev->umc.ras->ecc_info_query_ras_error_address(adev,
+							ras_error_status);
 		}
 	}
 
-- 
2.34.1

