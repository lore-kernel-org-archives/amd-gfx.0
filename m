Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2393BC001DF
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 07:01:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E5C510E588;
	Fri, 20 Oct 2023 07:01:00 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D645210E588
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 07:00:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IVi/FIa/Ghe1g7TkqPgQijDMFTY+89xskruofl4akVO8yCWghAbClCMpbQhGNQXQCgN9gC5GUa+ReV2+7YzCQKpQrkBUugRB31JA8PycA2IRgLfwZvycxHsab2m1tc+ZFL08VFTOQnXy5BIvqOsYbrnHOzAKxzPgcUzfWNekOFio1aaRqVA4+6PHTtKxN7tpZbgbiFic/GNIeiX/X7J7CumLdff7OHl2Hc2RJcNE4HgrZcwvQY1vyVycBrtFfUm2o0PmCN6zzYRbZWuqLntNe8iPb3T2n/5VAiopiDUPS9iTnZ7Uta5lAKHXo+N2PrHDh/SkwMlo0O5sOQFUZFKaBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5dGOdPFG0LwTzTrxZ8jPtHlrNgLOlcsLeqPhVzryis=;
 b=ErpRqHPjwWp7jzdJ3ySKQTnL4oixQ8bZcsViniutKk1U2dyrVshz1/57kNlNzr5bQe6DL+wieZuO7PvuNkV6Os+d2H4R0Ek33bMFDdhUsqeqWt3ofKLJqNLgzHrWIXZdiixYAqLuS0TUlfnR9I/dDsCMrDPvrtFRaT4bDsrfrp6wlR8yE6vsV/gpBr2oolKL2co2aRT5ozrEGDGJaVV9ADgrKHIUELVoiNRGygPM2JskVam2RiVCgzqt82CFH4C8NX10cakZS0EZF/ZTxlc5cIrD6tkXhkD11jWKlTLekjhR4i0BmIrYDrwuSIJEsQtboK7pv7hE0IiVwgVHznJQ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5dGOdPFG0LwTzTrxZ8jPtHlrNgLOlcsLeqPhVzryis=;
 b=x8s+Fhk09Oql9sb4ddGw0G+z3+r7wODeKrQbzRtD/7q6e+EkGSIchj8qNmx8rUfy9RtSq+CdhwmdVFwg8SOUjgxBtslHcWNUcpcS9dcx/9PpTyaOLILymW1n/dRBNwOPoyujC/vRMimfjmv/bAxwbP0yypqP7afYSP73oPXXHdU=
Received: from DM6PR14CA0061.namprd14.prod.outlook.com (2603:10b6:5:18f::38)
 by CH3PR12MB9249.namprd12.prod.outlook.com (2603:10b6:610:1bc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 20 Oct
 2023 07:00:54 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:5:18f:cafe::eb) by DM6PR14CA0061.outlook.office365.com
 (2603:10b6:5:18f::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26 via Frontend
 Transport; Fri, 20 Oct 2023 07:00:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Fri, 20 Oct 2023 07:00:53 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 20 Oct
 2023 02:00:51 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: refine ras error kernel log print
Date: Fri, 20 Oct 2023 15:00:26 +0800
Message-ID: <20231020070026.1380994-2-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020070026.1380994-1-kevinyang.wang@amd.com>
References: <20231020070026.1380994-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|CH3PR12MB9249:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c1f5358-6a6f-44b4-0f6b-08dbd13a4d62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KNbrtQtWpQsmrCCmh9nKPf5rKqQGoIEC4h9yav8brTb+DONuy2qN7hq/w9n+wKCsxmNUypU+Tbv5SdjYyggYFEnUeuhuxs6tNzXoUVPDgAZgetP31S+Ar1A4gFWZuuaIcM8PTutL1/YpCRG8Uh+NN+TVGhe3JokcVsquFYyVzg8IsRSLR2FVAoqP30OofFGDYOX3ApUlK3lrdi85tmABW6QXl9OfjWL+sHL/mSHjjnceuiEjGPbmAXRjri95af8nxLTIkCACmIGbAk2nj/Xh1op50FXJUFLTyneUFaq5Fi/VQK8pAqH0PNWMzHG0pIO2uGEKPZzqBjCwDyvjb8bp9qJsUmvEK6O5FNxMkTHuWSiRFQb45qpWIZleoR3cKeEj2bTMLvwny5ecIPcH0SKCFHeVfLBLt6XHCVIuJSSU5xSM4owSMZbsZ+KEoK9wAlxfUC3ylRY34mUagUXEDo3TzHVL+xyq2pG1R5az7QyXSYCxsvAkHyJp4iYJ/wlaIGN+tT/Oa0vqIzUuuea2EZRtAXimrGphyROAKC6GBrB88L/JMym7Q9CWBE3BhKu9CMEHaSePOSUpDduk42bPa/K4RiidHCGZyC7Y7owttR8qIiEUUMZnOMrJl4h5x5NdDYMyVNGMNcgYRKmdFhTh062nCGs/62HvHmoJ/bxjFkbbkyTWrSSF6FqXEUGKdCQ9C9maV7Kw6zHUwuxohPPwrUechwHyJYLso+VplQpD1dCFXmkmuQyZ0NYz5ofzqxBc7YcnshAYV32S/Th+JULU3FGnHg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(1800799009)(186009)(82310400011)(451199024)(64100799003)(36840700001)(46966006)(40470700004)(5660300002)(2906002)(7696005)(8676002)(8936002)(4326008)(41300700001)(6666004)(70206006)(70586007)(40460700003)(316002)(6916009)(82740400003)(478600001)(336012)(54906003)(36860700001)(26005)(1076003)(16526019)(2616005)(83380400001)(426003)(47076005)(40480700001)(36756003)(81166007)(86362001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 07:00:53.9012 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c1f5358-6a6f-44b4-0f6b-08dbd13a4d62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9249
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
Cc: yipeng.chai@amd.com, tao.zhou1@amd.com, candice.li@amd.com,
 Yang Wang <kevinyang.wang@amd.com>, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

refine ras error kernel log to avoid user-ridden ambiguity.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 116 +++++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |   5 +-
 2 files changed, 82 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index d5bcfcf4ced2..0cb60f71c14d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -635,8 +635,11 @@ static ssize_t amdgpu_ras_sysfs_read(struct device *dev,
 
 static inline void put_obj(struct ras_manager *obj)
 {
-	if (obj && (--obj->use == 0))
+	if (obj && (--obj->use == 0)) {
 		list_del(&obj->node);
+		amdgpu_ras_error_data_fini(&obj->err_data);
+	}
+
 	if (obj && (obj->use < 0))
 		DRM_ERROR("RAS ERROR: Unbalance obj(%s) use\n", get_ras_block_str(&obj->head));
 }
@@ -666,6 +669,9 @@ static struct ras_manager *amdgpu_ras_create_obj(struct amdgpu_device *adev,
 	if (alive_obj(obj))
 		return NULL;
 
+	if(amdgpu_ras_error_data_init(&obj->err_data))
+		return NULL;
+
 	obj->head = *head;
 	obj->adev = adev;
 	list_add(&obj->node, &con->head);
@@ -1023,44 +1029,68 @@ static void amdgpu_ras_get_ecc_info(struct amdgpu_device *adev, struct ras_err_d
 }
 
 static void amdgpu_ras_error_print_error_data(struct amdgpu_device *adev,
-					      struct ras_query_if *query_if,
+					      struct ras_manager *ras_mgr,
 					      struct ras_err_data *err_data,
+					      const char *blk_name,
 					      bool is_ue)
 {
-	struct ras_manager *ras_mgr = amdgpu_ras_find_obj(adev, &query_if->head);
-	const char *blk_name = get_ras_block_str(&query_if->head);
 	struct amdgpu_smuio_mcm_config_info *mcm_info;
 	struct ras_err_node *err_node;
 	struct ras_err_info *err_info;
 
-	if (is_ue)
-		dev_info(adev->dev, "%ld uncorrectable hardware errors detected in %s block\n",
-			 ras_mgr->err_data.ue_count, blk_name);
-	else
-		dev_info(adev->dev, "%ld correctable hardware errors detected in %s block\n",
-			 ras_mgr->err_data.ce_count, blk_name);
+	if (is_ue) {
+		for_each_ras_error(err_node, err_data) {
+			err_info = &err_node->err_info;
+			mcm_info = &err_info->mcm_info;
+			if (err_info->ue_count) {
+				dev_info(adev->dev, "socket: %d, die: %d, "
+					 "%lld new uncorrectable hardware errors detected in %s block\n",
+					 mcm_info->socket_id,
+					 mcm_info->die_id,
+					 err_info->ue_count,
+					 blk_name);
+			}
+		}
 
-	for_each_ras_error(err_node, err_data) {
-		err_info = &err_node->err_info;
-		mcm_info = &err_info->mcm_info;
-		if (is_ue && err_info->ue_count) {
-			dev_info(adev->dev, "socket: %d, die: %d "
-				 "%lld uncorrectable hardware errors detected in %s block\n",
-				 mcm_info->socket_id,
-				 mcm_info->die_id,
-				 err_info->ue_count,
-				 blk_name);
-		} else if (!is_ue && err_info->ce_count) {
-			dev_info(adev->dev, "socket: %d, die: %d "
-				 "%lld correctable hardware errors detected in %s block\n",
-				 mcm_info->socket_id,
-				 mcm_info->die_id,
-				 err_info->ce_count,
-				 blk_name);
+		for_each_ras_error(err_node, &ras_mgr->err_data) {
+			err_info = &err_node->err_info;
+			mcm_info = &err_info->mcm_info;
+			dev_info(adev->dev, "socket: %d, die: %d, "
+				 "%lld uncorrectable hardware errors detected in total in %s block\n",
+				 mcm_info->socket_id, mcm_info->die_id, err_info->ue_count, blk_name);
+		}
+
+	} else {
+		for_each_ras_error(err_node, err_data) {
+			err_info = &err_node->err_info;
+			mcm_info = &err_info->mcm_info;
+			if (err_info->ce_count) {
+				dev_info(adev->dev, "socket: %d, die: %d, "
+					 "%lld new correctable hardware errors detected in %s block, "
+					 "no user action is needed\n",
+					 mcm_info->socket_id,
+					 mcm_info->die_id,
+					 err_info->ce_count,
+					 blk_name);
+			}
+		}
+
+		for_each_ras_error(err_node, &ras_mgr->err_data) {
+			err_info = &err_node->err_info;
+			mcm_info = &err_info->mcm_info;
+			dev_info(adev->dev, "socket: %d, die: %d, "
+				 "%lld correctable hardware errors detected in total in %s block, "
+				 "no user action is needed\n",
+				 mcm_info->socket_id, mcm_info->die_id, err_info->ce_count, blk_name);
 		}
 	}
 }
 
+static inline bool err_data_has_source_info(struct ras_err_data *data)
+{
+	return !list_empty(&data->err_node_list);
+}
+
 static void amdgpu_ras_error_generate_report(struct amdgpu_device *adev,
 					     struct ras_query_if *query_if,
 					     struct ras_err_data *err_data)
@@ -1069,9 +1099,8 @@ static void amdgpu_ras_error_generate_report(struct amdgpu_device *adev,
 	const char *blk_name = get_ras_block_str(&query_if->head);
 
 	if (err_data->ce_count) {
-		if (!list_empty(&err_data->err_node_list)) {
-			amdgpu_ras_error_print_error_data(adev, query_if,
-							  err_data, false);
+		if (err_data_has_source_info(err_data)) {
+			amdgpu_ras_error_print_error_data(adev, ras_mgr, err_data, blk_name, false);
 		} else if (!adev->aid_mask &&
 			   adev->smuio.funcs &&
 			   adev->smuio.funcs->get_socket_id &&
@@ -1094,9 +1123,8 @@ static void amdgpu_ras_error_generate_report(struct amdgpu_device *adev,
 	}
 
 	if (err_data->ue_count) {
-		if (!list_empty(&err_data->err_node_list)) {
-			amdgpu_ras_error_print_error_data(adev, query_if,
-							  err_data, true);
+		if (err_data_has_source_info(err_data)) {
+			amdgpu_ras_error_print_error_data(adev, ras_mgr, err_data, blk_name, true);
 		} else if (!adev->aid_mask &&
 			   adev->smuio.funcs &&
 			   adev->smuio.funcs->get_socket_id &&
@@ -1118,6 +1146,25 @@ static void amdgpu_ras_error_generate_report(struct amdgpu_device *adev,
 
 }
 
+static void amdgpu_rasmgr_error_data_statistic_update(struct ras_manager *obj, struct ras_err_data *err_data)
+{
+	struct ras_err_node *err_node;
+	struct ras_err_info *err_info;
+
+	if (err_data_has_source_info(err_data)) {
+		for_each_ras_error(err_node, err_data) {
+			err_info = &err_node->err_info;
+
+			amdgpu_ras_error_statistic_ce_count(&obj->err_data, &err_info->mcm_info, err_info->ce_count);
+			amdgpu_ras_error_statistic_ue_count(&obj->err_data, &err_info->mcm_info, err_info->ue_count);
+		}
+	} else {
+		/* for legacy asic path which doesn't has error source info */
+		obj->err_data.ue_count += err_data->ue_count;
+		obj->err_data.ce_count += err_data->ce_count;
+	}
+}
+
 /* query/inject/cure begin */
 int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 				  struct ras_query_if *info)
@@ -1156,8 +1203,7 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 			}
 	}
 
-	obj->err_data.ue_count += err_data.ue_count;
-	obj->err_data.ce_count += err_data.ce_count;
+	amdgpu_rasmgr_error_data_statistic_update(obj, &err_data);
 
 	info->ue_count = obj->err_data.ue_count;
 	info->ce_count = obj->err_data.ce_count;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 3f9ac0ab67e6..55bcd93d5bc8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -513,10 +513,7 @@ struct ras_manager {
 	/* IH data */
 	struct ras_ih_data ih_data;
 
-	struct {
-		unsigned long ue_count;
-		unsigned long ce_count;
-	} err_data;
+	struct ras_err_data err_data;
 };
 
 struct ras_badpage {
-- 
2.34.1

