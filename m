Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32584CDB47E
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Oct 2023 13:14:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07AF910E4CB;
	Thu, 12 Oct 2023 13:14:30 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C41110E120
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Oct 2023 13:14:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0PyZAGPfSku6cIoXbGuZXCWymZPjTicQdg+ug1WO3oiDVSHW+j3iIT5EZurnhq4Eb0t2mtD49FbyQzAC5wr86+ctLeEWvRrKaCNrfCXSGNETs2Bl8UEQMqkReTn6xpoMQ+3eqnC9mQQGBLG9IRwjulFKZAOTRwxpGHwBARY/vY88PKuk9EpW5YKZoU6rE15PHUUQYT5Iwmo+l31xgYuCIeoRQqcXC1BQiKiVjBfzbgbvh7gUfOi0t73TgWsdL8XulhGn/2Lyg7524zYE721D33zJAoXNI/RYttzz3MjjfFNNQV8uP+Ca7VPfKg4ZO+CQ1NrOG2DYvRRCie8m9Bbuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0assFhnOKVN9IKb3I5z24m5N6GmwIz/pcKN27GWSm9U=;
 b=gdIDphvp/TTxW4E9RqjhSbFzFMHn62Q0I7uo+efeN5f/eOWdTFvNnlAxkWV45iFmdqcxeAqUZVzL7xlbqfawvMxUD+101QkfAfVgHzv8hw5VjUi6cX8mtDoLpR7jSPdYR1Oz2CSglQOeYe2F7n9bX/vq0XgUBDk7LrNW+J2dKqf/29z/rXQiFi/eyEsh1pGNmuzs6gnc0iyvsAcuI6fOk5P/At7HXmRqP3zjvBRAhGHvpu/aghjUpbi3SjjxQe6eujSYM4vrwsMG1yOxpFEhYbZwxNYODP66BDAoQCs0qG+0wPQbul1/8AHkEiTNGnVVCqnHuBwr/RXlJMF7zYGofg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0assFhnOKVN9IKb3I5z24m5N6GmwIz/pcKN27GWSm9U=;
 b=jGF4Ci+C7QgnqenycE1n0Z0BV3047Ho3RPosIFiz7d7h4oLF8Q0x5Ob+EuYkWMDtFgBl3goFVvlcC95hbmnjs2erbyZ6XxMhMim9IbeYhSmVVudRnTlMZFObosjdwzQiEqVyxM8AyUSoBePE0s/pQjLqMubsP4t9nbCYjnohywQ=
Received: from PH8PR07CA0019.namprd07.prod.outlook.com (2603:10b6:510:2cd::18)
 by CYXPR12MB9386.namprd12.prod.outlook.com (2603:10b6:930:de::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 13:14:25 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:510:2cd:cafe::f3) by PH8PR07CA0019.outlook.office365.com
 (2603:10b6:510:2cd::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.30 via Frontend
 Transport; Thu, 12 Oct 2023 13:14:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 12 Oct 2023 13:14:24 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 08:14:20 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/6] drm/amdgpu: add ras_err_info to identify RAS error source
Date: Thu, 12 Oct 2023 21:14:02 +0800
Message-ID: <20231012131406.61101-2-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012131406.61101-1-kevinyang.wang@amd.com>
References: <20231012131406.61101-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|CYXPR12MB9386:EE_
X-MS-Office365-Filtering-Correlation-Id: 39b5a5d4-ad37-4646-9373-08dbcb2527cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MTc5zpUx6WFQlym48m50dJAleTOG4e+ZbKhTAhdcyrK1rcXyS0dZANeK5CuXUIsPoEWP6VlfZLohD12lEcwOWnrJdYSaZOtIuM264Lga3CsKcBYBQlpHmv4EhzvhAYejqMI6VfINHU/YV4xLSdCz5RYOPBAYcJaMjXSnO93TxCBfEul87VTphEFVgL/2c+CbuErF5OkOL1cbthfc9sN3dB1KZX0mt4uqJBeRjR/ht6mOpClSTaE0fnQyuoUzFjugGUjEH1bj6f1kAmRcs+8ry57bZdG/o5+FrdKb8VatwRVAnR6rYX8Yx8ILvH9gpGmwfJVCwjfiztfGSp1P+kU/rKrcKslElQ/Nbjqcm6CyA05e0kMI7EFxRl3S+z8X83oNW48Kf3bxwLkWMez3f6ej/z6NChPxlc9p+phN5ctcgPTHUbqnSiWUvWv49Q842NVjqpuRiPL+gYLdNNKm+Rzw30RjCFRWV3hY/zmqUS0xr3vEmrhYwOHYO/7j/mmvhTbfFfH7DmVgFQA8LpdwvXzw/5so/OFUETW7f3fXuqmClt7MeTLBxq3K8af07+Tx7JQRKBPxRRvK8LpGBHEtEQbaZRqVBpmC7k9RVKQNoeGuknQMsQuCKtob35/81eTl2rFwRW+l5tnlNDOmj3sOmsRxiVToT9sT//JhldTSTL9tmujEgbx7SmJ5lMgzRgqSuW9FJORe6p9kaOeBRJb0UMQDcQsCS1TAr/BVKWOrDfiZwYUIC8DUz0082OdFVRPvaCWAY7pRiePX9RMt7aD8vMRJhw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(64100799003)(186009)(1800799009)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(16526019)(26005)(47076005)(426003)(336012)(82740400003)(40480700001)(7696005)(36756003)(6916009)(316002)(83380400001)(54906003)(70206006)(70586007)(86362001)(81166007)(2616005)(1076003)(356005)(36860700001)(40460700003)(478600001)(2906002)(6666004)(5660300002)(8936002)(8676002)(4326008)(30864003)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 13:14:24.4379 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b5a5d4-ad37-4646-9373-08dbcb2527cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9386
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
Cc: Tao Zhou <tao.zhou1@amd.com>, Yang Wang <kevinyang.wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

introduced "ras_err_info" to better identify a RAS ERROR source.

NOTE:
For legacy chips, keep the original RAS error print format.

v1:
RAS errors may come from different dies during a RAS error query,
therefore, need a new data structure to identify the source of RAS ERROR.

v2:
- use new data structure 'amdgpu_smuio_mcm_config_info' instead of
  ras_err_id (in v1 patch)
- refine ras error dump function name
- refine ras error dump log format

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c   | 289 ++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h   |  28 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c   |  27 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c    |   7 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c    |   7 +-
 6 files changed, 310 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 5fb57419ef77..2522d29806dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -152,8 +152,9 @@ static bool amdgpu_ras_get_error_query_ready(struct amdgpu_device *adev)
 
 static int amdgpu_reserve_page_direct(struct amdgpu_device *adev, uint64_t address)
 {
-	struct ras_err_data err_data = {0, 0, 0, NULL};
+	struct ras_err_data err_data;
 	struct eeprom_table_record err_rec;
+	int ret;
 
 	if ((address >= adev->gmc.mc_vram_size) ||
 	    (address >= RAS_UMC_INJECT_ADDR_LIMIT)) {
@@ -170,6 +171,10 @@ static int amdgpu_reserve_page_direct(struct amdgpu_device *adev, uint64_t addre
 		return 0;
 	}
 
+	ret = amdgpu_ras_error_data_init(&err_data);
+	if (ret)
+		return ret;
+
 	memset(&err_rec, 0x0, sizeof(struct eeprom_table_record));
 	err_data.err_addr = &err_rec;
 	amdgpu_umc_fill_error_record(&err_data, address, address, 0, 0);
@@ -180,6 +185,8 @@ static int amdgpu_reserve_page_direct(struct amdgpu_device *adev, uint64_t addre
 		amdgpu_ras_save_bad_pages(adev, NULL);
 	}
 
+	amdgpu_ras_error_data_fini(&err_data);
+
 	dev_warn(adev->dev, "WARNING: THIS IS ONLY FOR TEST PURPOSES AND WILL CORRUPT RAS EEPROM\n");
 	dev_warn(adev->dev, "Clear EEPROM:\n");
 	dev_warn(adev->dev, "    echo 1 > /sys/kernel/debug/dri/0/ras/ras_eeprom_reset\n");
@@ -1015,17 +1022,113 @@ static void amdgpu_ras_get_ecc_info(struct amdgpu_device *adev, struct ras_err_d
 	}
 }
 
+static void amdgpu_ras_error_print_error_data(struct amdgpu_device *adev, struct ras_query_if *query_if,
+					      struct ras_err_data *err_data, bool is_ue)
+{
+	struct ras_manager *ras_mgr = amdgpu_ras_find_obj(adev, &query_if->head);
+	const char *blk_name = get_ras_block_str(&query_if->head);
+	struct amdgpu_smuio_mcm_config_info *mcm_info;
+	struct ras_err_node *err_node;
+	struct ras_err_info *err_info;
+
+	if (is_ue)
+		dev_info(adev->dev, "Total %ld uncorrectable hardware errors detected in %s block\n",
+			 ras_mgr->err_data.ue_count, blk_name);
+	else
+		dev_info(adev->dev, "Total %ld correctable hardware errors detected in %s block\n",
+			 ras_mgr->err_data.ue_count, blk_name);
+
+	for_each_ras_error(err_node, err_data) {
+		err_info = &err_node->err_info;
+		mcm_info = &err_info->mcm_info;
+		if (is_ue && err_info->ue_count) {
+			dev_info(adev->dev, "socket: %d, die: %d, "
+				 "%lld uncorrectable hardware errors detected in %s block\n",
+				 mcm_info->socket_id,
+				 mcm_info->die_id,
+				 err_info->ue_count,
+				 blk_name);
+		} else if (!is_ue && err_info->ce_count) {
+			dev_info(adev->dev, "socket: %d, die: %d, "
+				 "%lld correctable hardware errors detected in %s block\n",
+				 mcm_info->socket_id,
+				 mcm_info->die_id,
+				 err_info->ue_count,
+				 blk_name);
+		}
+	}
+}
+
+static void amdgpu_ras_error_generate_report(struct amdgpu_device *adev, struct ras_query_if *query_if,
+					     struct ras_err_data *err_data)
+{
+	struct ras_manager *ras_mgr = amdgpu_ras_find_obj(adev, &query_if->head);
+	const char *blk_name = get_ras_block_str(&query_if->head);
+
+	if (err_data->ce_count) {
+		if (!list_empty(&err_data->err_node_list)) {
+			amdgpu_ras_error_print_error_data(adev, query_if, err_data, false);
+		} else if (!adev->aid_mask &&
+			   adev->smuio.funcs &&
+			   adev->smuio.funcs->get_socket_id &&
+			   adev->smuio.funcs->get_die_id) {
+			dev_info(adev->dev, "socket: %d, die: %d "
+				 "%ld correctable hardware errors "
+				 "detected in %s block, no user "
+				 "action is needed.\n",
+				 adev->smuio.funcs->get_socket_id(adev),
+				 adev->smuio.funcs->get_die_id(adev),
+				 ras_mgr->err_data.ce_count,
+				 blk_name);
+		} else {
+			dev_info(adev->dev, "%ld correctable hardware errors "
+				 "detected in %s block, no user "
+				 "action is needed.\n",
+				 ras_mgr->err_data.ce_count,
+				 blk_name);
+		}
+	}
+
+	if (err_data->ue_count) {
+		if (!list_empty(&err_data->err_node_list)) {
+			amdgpu_ras_error_print_error_data(adev, query_if, err_data, true);
+		} else if (!adev->aid_mask &&
+			   adev->smuio.funcs &&
+			   adev->smuio.funcs->get_socket_id &&
+			   adev->smuio.funcs->get_die_id) {
+			dev_info(adev->dev, "socket: %d, die: %d "
+				 "%ld uncorrectable hardware errors "
+				 "detected in %s block\n",
+				 adev->smuio.funcs->get_socket_id(adev),
+				 adev->smuio.funcs->get_die_id(adev),
+				 ras_mgr->err_data.ue_count,
+				 blk_name);
+		} else {
+			dev_info(adev->dev, "%ld uncorrectable hardware errors "
+				 "detected in %s block\n",
+				 ras_mgr->err_data.ue_count,
+				 blk_name);
+		}
+	}
+
+}
+
 /* query/inject/cure begin */
 int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 				  struct ras_query_if *info)
 {
 	struct amdgpu_ras_block_object *block_obj = NULL;
 	struct ras_manager *obj = amdgpu_ras_find_obj(adev, &info->head);
-	struct ras_err_data err_data = {0, 0, 0, NULL};
+	struct ras_err_data err_data;
+	int ret;
 
 	if (!obj)
 		return -EINVAL;
 
+	ret = amdgpu_ras_error_data_init(&err_data);
+	if (ret)
+		return ret;
+
 	if (info->head.block == AMDGPU_RAS_BLOCK__UMC) {
 		amdgpu_ras_get_ecc_info(adev, &err_data);
 	} else {
@@ -1033,7 +1136,8 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 		if (!block_obj || !block_obj->hw_ops)   {
 			dev_dbg_once(adev->dev, "%s doesn't config RAS function\n",
 				     get_ras_block_str(&info->head));
-			return -EINVAL;
+			ret = -EINVAL;
+			goto out_fini_err_data;
 		}
 
 		if (block_obj->hw_ops->query_ras_error_count)
@@ -1053,48 +1157,12 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 	info->ue_count = obj->err_data.ue_count;
 	info->ce_count = obj->err_data.ce_count;
 
-	if (err_data.ce_count) {
-		if (!adev->aid_mask &&
-		    adev->smuio.funcs &&
-		    adev->smuio.funcs->get_socket_id &&
-		    adev->smuio.funcs->get_die_id) {
-			dev_info(adev->dev, "socket: %d, die: %d "
-					"%ld correctable hardware errors "
-					"detected in %s block, no user "
-					"action is needed.\n",
-					adev->smuio.funcs->get_socket_id(adev),
-					adev->smuio.funcs->get_die_id(adev),
-					obj->err_data.ce_count,
-					get_ras_block_str(&info->head));
-		} else {
-			dev_info(adev->dev, "%ld correctable hardware errors "
-					"detected in %s block, no user "
-					"action is needed.\n",
-					obj->err_data.ce_count,
-					get_ras_block_str(&info->head));
-		}
-	}
-	if (err_data.ue_count) {
-		if (!adev->aid_mask &&
-		    adev->smuio.funcs &&
-		    adev->smuio.funcs->get_socket_id &&
-		    adev->smuio.funcs->get_die_id) {
-			dev_info(adev->dev, "socket: %d, die: %d "
-					"%ld uncorrectable hardware errors "
-					"detected in %s block\n",
-					adev->smuio.funcs->get_socket_id(adev),
-					adev->smuio.funcs->get_die_id(adev),
-					obj->err_data.ue_count,
-					get_ras_block_str(&info->head));
-		} else {
-			dev_info(adev->dev, "%ld uncorrectable hardware errors "
-					"detected in %s block\n",
-					obj->err_data.ue_count,
-					get_ras_block_str(&info->head));
-		}
-	}
+	amdgpu_ras_error_generate_report(adev, info, &err_data);
 
-	return 0;
+out_fini_err_data:
+	amdgpu_ras_error_data_fini(&err_data);
+
+	return ret;
 }
 
 int amdgpu_ras_reset_error_status(struct amdgpu_device *adev,
@@ -1744,12 +1812,16 @@ static void amdgpu_ras_interrupt_umc_handler(struct ras_manager *obj,
 				struct amdgpu_iv_entry *entry)
 {
 	struct ras_ih_data *data = &obj->ih_data;
-	struct ras_err_data err_data = {0, 0, 0, NULL};
+	struct ras_err_data err_data;
 	int ret;
 
 	if (!data->cb)
 		return;
 
+	ret = amdgpu_ras_error_data_init(&err_data);
+	if (ret)
+		return;
+
 	/* Let IP handle its data, maybe we need get the output
 	 * from the callback to update the error type/count, etc
 	 */
@@ -1766,6 +1838,8 @@ static void amdgpu_ras_interrupt_umc_handler(struct ras_manager *obj,
 		obj->err_data.ue_count += err_data.ue_count;
 		obj->err_data.ce_count += err_data.ce_count;
 	}
+
+	amdgpu_ras_error_data_fini(&err_data);
 }
 
 static void amdgpu_ras_interrupt_handler(struct ras_manager *obj)
@@ -3383,3 +3457,128 @@ void amdgpu_ras_inst_reset_ras_error_count(struct amdgpu_device *adev,
 		WREG32(err_status_hi_offset, 0);
 	}
 }
+
+int amdgpu_ras_error_data_init(struct ras_err_data *err_data)
+{
+	memset(err_data, 0, sizeof(*err_data));
+
+	INIT_LIST_HEAD(&err_data->err_node_list);
+
+	return 0;
+}
+
+static void amdgpu_ras_error_node_release(struct ras_err_node *err_node)
+{
+	if (!err_node)
+		return;
+
+	list_del(&err_node->node);
+	kvfree(err_node);
+}
+
+void amdgpu_ras_error_data_fini(struct ras_err_data *err_data)
+{
+	struct ras_err_node *err_node, *tmp;
+
+	list_for_each_entry_safe(err_node, tmp, &err_data->err_node_list, node) {
+		amdgpu_ras_error_node_release(err_node);
+		list_del(&err_node->node);
+	}
+}
+
+static struct ras_err_node *amdgpu_ras_error_find_node_by_id(struct ras_err_data *err_data,
+							     struct amdgpu_smuio_mcm_config_info *mcm_info)
+{
+	struct ras_err_node *err_node;
+	struct amdgpu_smuio_mcm_config_info *ref_id;
+
+	if (!err_data || !mcm_info)
+		return NULL;
+
+	for_each_ras_error(err_node, err_data) {
+		ref_id = &err_node->err_info.mcm_info;
+		if ((mcm_info->socket_id >= 0 && mcm_info->socket_id != ref_id->socket_id) ||
+		    (mcm_info->die_id >= 0 && mcm_info->die_id != ref_id->die_id))
+			continue;
+
+		return err_node;
+	}
+
+	return NULL;
+}
+
+static struct ras_err_node *amdgpu_ras_error_node_new(void)
+{
+	struct ras_err_node *err_node;
+
+	err_node = kvzalloc(sizeof(*err_node), GFP_KERNEL);
+	if (!err_node)
+		return NULL;
+
+	INIT_LIST_HEAD(&err_node->node);
+
+	return err_node;
+}
+
+static struct ras_err_info *amdgpu_ras_error_get_info(struct ras_err_data *err_data,
+						      struct amdgpu_smuio_mcm_config_info *mcm_info)
+{
+	struct ras_err_node *err_node;
+
+	err_node = amdgpu_ras_error_find_node_by_id(err_data, mcm_info);
+	if (err_node)
+		return &err_node->err_info;
+
+	err_node = amdgpu_ras_error_node_new();
+	if (!err_node)
+		return NULL;
+
+	memcpy(&err_node->err_info.mcm_info, mcm_info, sizeof(*mcm_info));
+
+	err_data->err_list_count++;
+	list_add_tail(&err_node->node, &err_data->err_node_list);
+
+	return &err_node->err_info;
+}
+
+int amdgpu_ras_error_statistic_ue_count(struct ras_err_data *err_data,
+					struct amdgpu_smuio_mcm_config_info *mcm_info, uint64_t count)
+{
+	struct ras_err_info *err_info;
+
+	if (!err_data || !mcm_info)
+		return -EINVAL;
+
+	if (!count)
+		return 0;
+
+	err_info = amdgpu_ras_error_get_info(err_data, mcm_info);
+	if (!err_info)
+		return -EINVAL;
+
+	err_info->ue_count += count;
+	err_data->ue_count += count;
+
+	return 0;
+}
+
+int amdgpu_ras_error_statistic_ce_count(struct ras_err_data *err_data,
+					struct amdgpu_smuio_mcm_config_info *mcm_info, uint64_t count)
+{
+	struct ras_err_info *err_info;
+
+	if (!err_data || !mcm_info)
+		return -EINVAL;
+
+	if (!count)
+		return 0;
+
+	err_info = amdgpu_ras_error_get_info(err_data, mcm_info);
+	if (!err_info)
+		return -EINVAL;
+
+	err_info->ce_count += count;
+	err_data->ce_count += count;
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 46b0dcf846dc..d6a37d5b9809 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -28,6 +28,7 @@
 #include <linux/list.h>
 #include "ta_ras_if.h"
 #include "amdgpu_ras_eeprom.h"
+#include "amdgpu_smuio.h"
 
 struct amdgpu_iv_entry;
 
@@ -443,13 +444,30 @@ struct ras_fs_data {
 	char debugfs_name[32];
 };
 
+
+struct ras_err_info {
+	struct amdgpu_smuio_mcm_config_info mcm_info;
+	uint64_t ce_count;
+	uint64_t ue_count;
+};
+
+struct ras_err_node {
+	struct list_head node;
+	struct ras_err_info err_info;
+};
+
 struct ras_err_data {
 	unsigned long ue_count;
 	unsigned long ce_count;
 	unsigned long err_addr_cnt;
 	struct eeprom_table_record *err_addr;
+	uint32_t err_list_count;
+	struct list_head err_node_list;
 };
 
+#define for_each_ras_error(err_node, err_data) \
+	list_for_each_entry(err_node, &(err_data)->err_node_list, node)
+
 struct ras_err_handler_data {
 	/* point to bad page records array */
 	struct eeprom_table_record *bps;
@@ -773,4 +791,14 @@ void amdgpu_ras_inst_reset_ras_error_count(struct amdgpu_device *adev,
 					   const struct amdgpu_ras_err_status_reg_entry *reg_list,
 					   uint32_t reg_list_size,
 					   uint32_t instance);
+
+int amdgpu_ras_error_data_init(struct ras_err_data *err_data);
+void amdgpu_ras_error_data_fini(struct ras_err_data *err_data);
+int amdgpu_ras_error_statistic_ce_count(struct ras_err_data *err_data,
+					struct amdgpu_smuio_mcm_config_info *mcm_info, uint64_t count);
+int amdgpu_ras_error_statistic_ue_count(struct ras_err_data *err_data,
+					struct amdgpu_smuio_mcm_config_info *mcm_info, uint64_t count);
+
 #endif
+
+
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h
index 5910d50ac74d..ff4435181055 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h
@@ -30,6 +30,11 @@ enum amdgpu_pkg_type {
 	AMDGPU_PKG_TYPE_UNKNOWN,
 };
 
+struct amdgpu_smuio_mcm_config_info {
+	int socket_id;
+	int die_id;
+};
+
 struct amdgpu_smuio_funcs {
 	u32 (*get_rom_index_offset)(struct amdgpu_device *adev);
 	u32 (*get_rom_data_offset)(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 24fcc9a2e422..f74347cc087a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -45,8 +45,12 @@ static int amdgpu_umc_convert_error_address(struct amdgpu_device *adev,
 int amdgpu_umc_page_retirement_mca(struct amdgpu_device *adev,
 			uint64_t err_addr, uint32_t ch_inst, uint32_t umc_inst)
 {
-	struct ras_err_data err_data = {0, 0, 0, NULL};
-	int ret = AMDGPU_RAS_FAIL;
+	struct ras_err_data err_data;
+	int ret;
+
+	ret = amdgpu_ras_error_data_init(&err_data);
+	if (ret)
+		return ret;
 
 	err_data.err_addr =
 		kcalloc(adev->umc.max_ras_err_cnt_per_query,
@@ -54,7 +58,8 @@ int amdgpu_umc_page_retirement_mca(struct amdgpu_device *adev,
 	if (!err_data.err_addr) {
 		dev_warn(adev->dev,
 			"Failed to alloc memory for umc error record in MCA notifier!\n");
-		return AMDGPU_RAS_FAIL;
+		ret = AMDGPU_RAS_FAIL;
+		goto out_fini_err_data;
 	}
 
 	/*
@@ -63,7 +68,7 @@ int amdgpu_umc_page_retirement_mca(struct amdgpu_device *adev,
 	ret = amdgpu_umc_convert_error_address(adev, &err_data, err_addr,
 					ch_inst, umc_inst);
 	if (ret)
-		goto out;
+		goto out_free_err_addr;
 
 	if (amdgpu_bad_page_threshold != 0) {
 		amdgpu_ras_add_bad_pages(adev, err_data.err_addr,
@@ -71,8 +76,12 @@ int amdgpu_umc_page_retirement_mca(struct amdgpu_device *adev,
 		amdgpu_ras_save_bad_pages(adev, NULL);
 	}
 
-out:
+out_free_err_addr:
 	kfree(err_data.err_addr);
+
+out_fini_err_data:
+	amdgpu_ras_error_data_fini(&err_data);
+
 	return ret;
 }
 
@@ -182,18 +191,24 @@ int amdgpu_umc_poison_handler(struct amdgpu_device *adev, bool reset)
 	}
 
 	if (!amdgpu_sriov_vf(adev)) {
-		struct ras_err_data err_data = {0, 0, 0, NULL};
+		struct ras_err_data err_data;
 		struct ras_common_if head = {
 			.block = AMDGPU_RAS_BLOCK__UMC,
 		};
 		struct ras_manager *obj = amdgpu_ras_find_obj(adev, &head);
 
+		ret = amdgpu_ras_error_data_init(&err_data);
+		if (ret)
+			return ret;
+
 		ret = amdgpu_umc_do_page_retirement(adev, &err_data, NULL, reset);
 
 		if (ret == AMDGPU_RAS_SUCCESS && obj) {
 			obj->err_data.ue_count += err_data.ue_count;
 			obj->err_data.ce_count += err_data.ce_count;
 		}
+
+		amdgpu_ras_error_data_fini(&err_data);
 	} else {
 		if (adev->virt.ops && adev->virt.ops->ras_poison_handler)
 			adev->virt.ops->ras_poison_handler(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index 7d6d7734dbec..6d24c84924cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -365,9 +365,12 @@ static void nbio_v7_4_handle_ras_controller_intr_no_bifring(struct amdgpu_device
 {
 	uint32_t bif_doorbell_intr_cntl;
 	struct ras_manager *obj = amdgpu_ras_find_obj(adev, adev->nbio.ras_if);
-	struct ras_err_data err_data = {0, 0, 0, NULL};
+	struct ras_err_data err_data;
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
+	if (amdgpu_ras_error_data_init(&err_data))
+		return;
+
 	if (adev->asic_type == CHIP_ALDEBARAN)
 		bif_doorbell_intr_cntl = RREG32_SOC15(NBIO, 0, mmBIF_DOORBELL_INT_CNTL_ALDE);
 	else
@@ -418,6 +421,8 @@ static void nbio_v7_4_handle_ras_controller_intr_no_bifring(struct amdgpu_device
 		 */
 		amdgpu_ras_reset_gpu(adev);
 	}
+
+	amdgpu_ras_error_data_fini(&err_data);
 }
 
 static void nbio_v7_4_handle_ras_err_event_athub_intr_no_bifring(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index cc034a740605..eccb006e78aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -560,9 +560,12 @@ static void nbio_v7_9_handle_ras_controller_intr_no_bifring(struct amdgpu_device
 {
 	uint32_t bif_doorbell_intr_cntl;
 	struct ras_manager *obj = amdgpu_ras_find_obj(adev, adev->nbio.ras_if);
-	struct ras_err_data err_data = {0, 0, 0, NULL};
+	struct ras_err_data err_data;
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
+	if (amdgpu_ras_error_data_init(&err_data))
+		return;
+
 	bif_doorbell_intr_cntl = RREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_DOORBELL_INT_CNTL);
 
 	if (REG_GET_FIELD(bif_doorbell_intr_cntl,
@@ -607,6 +610,8 @@ static void nbio_v7_9_handle_ras_controller_intr_no_bifring(struct amdgpu_device
 		 */
 		amdgpu_ras_reset_gpu(adev);
 	}
+
+	amdgpu_ras_error_data_fini(&err_data);
 }
 
 static void nbio_v7_9_handle_ras_err_event_athub_intr_no_bifring(struct amdgpu_device *adev)
-- 
2.34.1

