Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE97C47077
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jan 2024 11:49:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EB0510E453;
	Thu,  4 Jan 2024 11:49:39 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7248910E453
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jan 2024 11:49:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oj5Pz/iDMsgvNBEx6WpGBZglXi2j033NDN01I2WXwhEbsdVTKBZkGrco//wxWQbs7emO/8J64Nz/LEDYqI+5sUTFC106zX/eGvRJqafD6WMJLElGTlx9MrQkkrnNkpJqoHKvoize5J7JV1uKxSuNsiSA/nl+RXbinW6I4CcyQld92WUZ1OCkTw9QP619UXNMjFslxHSvu5hOu2PL20IPcvDC2oQoF3uZ4oKO6GnRCxBAaT7Jgo5GyK3/cyje2LD005MAWUGWJvJa3lWmerU+N7OY41tdWrgWfZ1s67oB1bPX7Gmrg4+nIKYYSI6WXV1OBf8Ih8tBD1cF410PkV810Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vgp2PLTp6T8WVppWhyzxmpnqUjiht8Lh4N3V6VNTUM4=;
 b=gd+zNR1yCkvXYQwcf//RZbBmQBAHHMIzJtzxMy56akA9TuglVF8H1yphJYqn78LWX7ZqHy0f0XUTVj7fJITAnYoHHWD7AwSlbTtXLPTthe++7TUY/I/79JadTaxpriWH8LGEiw2EyXo9JvwxpdEZRH5qpRx98mGvaiDseW2uJI+xbDqrfbJzPyTwdj1rr2mJXLpPQ7C8cNsfhD7NhW5/RmTLqmpmNkw41n6fDKjC0KxMVFYJnzueFH1HUYhtSgrfZOl7NsI6b6umhAaOjyZ+qhOMLv5F06eqg3LW8QPrxCQkSlqmVxZNPuBQfSQW5EvpyyDYrMm3dWLstpc7oFBkYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgp2PLTp6T8WVppWhyzxmpnqUjiht8Lh4N3V6VNTUM4=;
 b=p+6f1PQn/L5UJHsV7A66fJXDBhmC60sJJkhFN6FoKZOtUmTlpGQU/Thx2SlWjmaNma2YEYvXHfhSpEBj3JqqrI1Nutomf8iNxvS/rN38cLh0uigLpBOF7BKmmqyZyNpYZRLsdYp+9aSl7gapaF2gsnuVsueYHCbDaSBz7cq+VPI=
Received: from SJ0PR13CA0124.namprd13.prod.outlook.com (2603:10b6:a03:2c6::9)
 by SN7PR12MB8102.namprd12.prod.outlook.com (2603:10b6:806:359::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 11:49:33 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::c3) by SJ0PR13CA0124.outlook.office365.com
 (2603:10b6:a03:2c6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13 via Frontend
 Transport; Thu, 4 Jan 2024 11:49:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 11:49:32 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 4 Jan
 2024 05:49:29 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 06/12] drm/amdgpu: add amdgpu ras aca query interface
Date: Thu, 4 Jan 2024 19:48:52 +0800
Message-ID: <20240104114858.3475783-7-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240104114858.3475783-1-kevinyang.wang@amd.com>
References: <20240104114858.3475783-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|SN7PR12MB8102:EE_
X-MS-Office365-Filtering-Correlation-Id: b2c21a9a-af66-419d-23e8-08dc0d1b37db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y2rRw8v7AcJ0VtghmzsNT84eZbQQUXjd8bJzfecOVGmrY4vXilL/Sz8wQnObXWbch9jpb3UVV1fwVeCUAkSjqpenp/CiXRMd4woIfOHJXIqDbx4iwBoY8oTvVh+UizRJKHDATlsVrUapRMfXBw4imRJlc8jajiQCCLi7Ecue4+KuTKZX4oX6w2uodFSuAEKVDVlPuF1VSAjUYxftISF05RzXbXcUx4HdWPn297ZAg5FLQpEEivG/gkUi+/M3O7fh1eiKVDNtOuSJLiqSEke6eeCU9tKzJY1b+hLy/waX0K9pvM7WlsDxipgddp4yXWXZnAHgZoUDtvffBNOoSpYnw2I9kV+9rOWL7inTDsl64mO4+YvA1Or/BNH2KwdjdGkFPz31rqBRlKtkoGM0ea0KnTmDBDsy15/kGjhCfGp7T34GcQK3OSuD7QL0+zDwV/nnCH/sIyHpPhnIDzA+KF2JLVr2OihB/fztbn2HbuaxVvAPrpnCNhWc4ihc1Lom6Dl+ZOaCVNqqRurrHLPdgH+tE+RNVRY9gjLnJgzrdwyws/pwVh5+Cb6/rq/zlD6KNAB2+snJiaBVmSBg4Il9rzjAWscoLRFR9PNSYkyCzzmQFhsk4luAjZCsOHOt+9HU8cqa0RPXP4gPiN0tqe6ELXlgwpoP8DCnjcZPqVVAVUhBFJqsbyo2QtthkpyvlUQRQ6Z8gXiywj6jQtnaIpq4H9sfYm+8ZnzaVdPuX9KfrlRFxeH/l9iRaPW2n8k2oHX1BFUnUBgP8WPYeYZF5NWFmMDzwQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(82310400011)(186009)(46966006)(40470700004)(36840700001)(83380400001)(356005)(41300700001)(81166007)(26005)(1076003)(336012)(16526019)(426003)(82740400003)(36860700001)(47076005)(40480700001)(70206006)(6666004)(40460700003)(6916009)(70586007)(7696005)(5660300002)(36756003)(30864003)(2906002)(86362001)(478600001)(316002)(8936002)(8676002)(54906003)(2616005)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 11:49:32.9966 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c21a9a-af66-419d-23e8-08dc0d1b37db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8102
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
Cc: yipeng.chai@amd.com, tao.zhou1@amd.com, Yang
 Wang <kevinyang.wang@amd.com>, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

v1:
- add ACA error query interface
v2:
- Add a new helper function to determine whether to use ACA or MCA.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c |   8 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 105 ++++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  12 ++-
 4 files changed, 109 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index a460cde20cf2..2ad06f87de8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -594,6 +594,9 @@ int amdgpu_aca_add_handle(struct amdgpu_device *adev, struct aca_handle *handle,
 	struct amdgpu_aca *aca = &adev->aca;
 	int ret;
 
+	if (!amdgpu_aca_is_enabled(adev))
+		return 0;
+
 	ret = add_aca_handle(adev, &aca->mgr, handle, name, ras_info, data);
 	if (ret)
 		return ret;
@@ -634,6 +637,11 @@ static void aca_manager_fini(struct aca_handle_manager *mgr)
 		remove_aca(handle);
 }
 
+bool amdgpu_aca_is_enabled(struct amdgpu_device *adev)
+{
+	return adev->aca.is_enabled;
+}
+
 int amdgpu_aca_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_aca *aca = &adev->aca;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
index bb0a3be72cc8..ada4f6c4660f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
@@ -175,6 +175,7 @@ struct aca_smu_funcs {
 struct amdgpu_aca {
 	struct aca_handle_manager mgr;
 	const struct aca_smu_funcs *smu_funcs;
+	bool is_enabled;
 };
 
 struct aca_info {
@@ -186,6 +187,7 @@ struct aca_info {
 int amdgpu_aca_init(struct amdgpu_device *adev);
 void amdgpu_aca_fini(struct amdgpu_device *adev);
 void amdgpu_aca_set_smu_funcs(struct amdgpu_device *adev, const struct aca_smu_funcs *smu_funcs);
+bool amdgpu_aca_is_enabled(struct amdgpu_device *adev);
 
 int aca_bank_info_decode(struct aca_bank *bank, struct aca_bank_info *info);
 int aca_bank_check_error_codes(struct amdgpu_device *adev, struct aca_bank *bank, int *err_codes, int size);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 7048bf853cf6..602bfe2f682e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1183,6 +1183,53 @@ ssize_t amdgpu_ras_aca_sysfs_read(struct device *dev, struct device_attribute *a
 			  "ce", info.ce_count);
 }
 
+static struct ras_manager *get_ras_manager(struct amdgpu_device *adev, enum amdgpu_ras_block blk)
+{
+	struct ras_common_if head;
+
+	memset(&head, 0, sizeof(head));
+	head.block = blk;
+
+	return amdgpu_ras_find_obj(adev, &head);
+}
+
+int amdgpu_ras_bind_aca(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
+			const struct aca_info *aca_info, void *data)
+{
+	struct ras_manager *obj;
+
+	obj = get_ras_manager(adev, blk);
+	if (!obj)
+		return -EINVAL;
+
+	return amdgpu_aca_add_handle(adev, &obj->aca_handle, ras_block_str(blk), aca_info, data);
+}
+
+int amdgpu_ras_unbind_aca(struct amdgpu_device *adev, enum amdgpu_ras_block blk)
+{
+	struct ras_manager *obj;
+
+	obj = get_ras_manager(adev, blk);
+	if (!obj)
+		return -EINVAL;
+
+	amdgpu_aca_remove_handle(&obj->aca_handle);
+
+	return 0;
+}
+
+static int amdgpu_aca_log_ras_error_data(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
+					 enum aca_error_type type, struct ras_err_data *err_data)
+{
+	struct ras_manager *obj;
+
+	obj = get_ras_manager(adev, blk);
+	if (!obj)
+		return -EINVAL;
+
+	return amdgpu_aca_get_error_data(adev, &obj->aca_handle, type, err_data);
+}
+
 static int amdgpu_ras_query_error_status_helper(struct amdgpu_device *adev,
 						struct ras_query_if *info,
 						struct ras_err_data *err_data,
@@ -1190,6 +1237,7 @@ static int amdgpu_ras_query_error_status_helper(struct amdgpu_device *adev,
 {
 	enum amdgpu_ras_block blk = info ? info->head.block : AMDGPU_RAS_BLOCK_COUNT;
 	struct amdgpu_ras_block_object *block_obj = NULL;
+	int ret;
 
 	if (blk == AMDGPU_RAS_BLOCK_COUNT)
 		return -EINVAL;
@@ -1219,9 +1267,19 @@ static int amdgpu_ras_query_error_status_helper(struct amdgpu_device *adev,
 			}
 		}
 	} else {
-		/* FIXME: add code to check return value later */
-		amdgpu_mca_smu_log_ras_error(adev, blk, AMDGPU_MCA_ERROR_TYPE_UE, err_data);
-		amdgpu_mca_smu_log_ras_error(adev, blk, AMDGPU_MCA_ERROR_TYPE_CE, err_data);
+		if (amdgpu_aca_is_enabled(adev)) {
+			ret = amdgpu_aca_log_ras_error_data(adev, blk, ACA_ERROR_TYPE_UE, err_data);
+			if (ret)
+				return ret;
+
+			ret = amdgpu_aca_log_ras_error_data(adev, blk, ACA_ERROR_TYPE_CE, err_data);
+			if (ret)
+				return ret;
+		} else {
+			/* FIXME: add code to check return value later */
+			amdgpu_mca_smu_log_ras_error(adev, blk, AMDGPU_MCA_ERROR_TYPE_UE, err_data);
+			amdgpu_mca_smu_log_ras_error(adev, blk, AMDGPU_MCA_ERROR_TYPE_CE, err_data);
+		}
 	}
 
 	return 0;
@@ -1270,6 +1328,7 @@ int amdgpu_ras_reset_error_count(struct amdgpu_device *adev,
 	struct amdgpu_ras_block_object *block_obj = amdgpu_ras_get_ras_block(adev, block, 0);
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
+	const struct aca_smu_funcs *smu_funcs = adev->aca.smu_funcs;
 	struct amdgpu_hive_info *hive;
 	int hive_ras_recovery = 0;
 
@@ -1280,7 +1339,7 @@ int amdgpu_ras_reset_error_count(struct amdgpu_device *adev,
 	}
 
 	if (!amdgpu_ras_is_supported(adev, block) ||
-	    !amdgpu_ras_get_mca_debug_mode(adev))
+	    !amdgpu_ras_get_aca_debug_mode(adev))
 		return -EOPNOTSUPP;
 
 	hive = amdgpu_get_xgmi_hive(adev);
@@ -1292,7 +1351,8 @@ int amdgpu_ras_reset_error_count(struct amdgpu_device *adev,
 	/* skip ras error reset in gpu reset */
 	if ((amdgpu_in_reset(adev) || atomic_read(&ras->in_recovery) ||
 	    hive_ras_recovery) &&
-	    mca_funcs && mca_funcs->mca_set_debug_mode)
+	    ((smu_funcs && smu_funcs->set_debug_mode) ||
+	     (mca_funcs && mca_funcs->mca_set_debug_mode)))
 		return -EOPNOTSUPP;
 
 	if (block_obj->hw_ops->reset_ras_error_count)
@@ -1788,7 +1848,10 @@ void amdgpu_ras_debugfs_create_all(struct amdgpu_device *adev)
 		}
 	}
 
-	amdgpu_mca_smu_debugfs_init(adev, dir);
+	if (amdgpu_aca_is_enabled(adev))
+		amdgpu_aca_smu_debugfs_init(adev, dir);
+	else
+		amdgpu_mca_smu_debugfs_init(adev, dir);
 }
 
 /* debugfs end */
@@ -2769,6 +2832,9 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev)
 
 	adev->ras_enabled = amdgpu_ras_enable == 0 ? 0 :
 		adev->ras_hw_enabled & amdgpu_ras_mask;
+
+	/* aca is disabled by default */
+	adev->aca.is_enabled = false;
 }
 
 static void amdgpu_ras_counte_dw(struct work_struct *work)
@@ -3153,7 +3219,10 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	amdgpu_ras_set_mca_debug_mode(adev, false);
+	if (amdgpu_aca_is_enabled(adev))
+		amdgpu_ras_set_aca_debug_mode(adev, false);
+	else
+		amdgpu_ras_set_mca_debug_mode(adev, false);
 
 	list_for_each_entry_safe(node, tmp, &adev->ras_list, node) {
 		if (!node->ras_obj) {
@@ -3436,7 +3505,7 @@ int amdgpu_ras_set_mca_debug_mode(struct amdgpu_device *adev, bool enable)
 	if (con) {
 		ret = amdgpu_mca_smu_set_debug_mode(adev, enable);
 		if (!ret)
-			con->is_mca_debug_mode = enable;
+			con->is_aca_debug_mode = enable;
 	}
 
 	return ret;
@@ -3448,24 +3517,29 @@ int amdgpu_ras_set_aca_debug_mode(struct amdgpu_device *adev, bool enable)
 	int ret = 0;
 
 	if (con) {
-		ret = amdgpu_aca_smu_set_debug_mode(adev, enable);
+		if (amdgpu_aca_is_enabled(adev))
+			ret = amdgpu_aca_smu_set_debug_mode(adev, enable);
+		else
+			ret = amdgpu_mca_smu_set_debug_mode(adev, enable);
 		if (!ret)
-			con->is_mca_debug_mode = enable;
+			con->is_aca_debug_mode = enable;
 	}
 
 	return ret;
 }
 
-bool amdgpu_ras_get_mca_debug_mode(struct amdgpu_device *adev)
+bool amdgpu_ras_get_aca_debug_mode(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	const struct aca_smu_funcs *smu_funcs = adev->aca.smu_funcs;
 	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
 
 	if (!con)
 		return false;
 
-	if (mca_funcs && mca_funcs->mca_set_debug_mode)
-		return con->is_mca_debug_mode;
+	if ((amdgpu_aca_is_enabled(adev) && smu_funcs && smu_funcs->set_debug_mode) ||
+	    (!amdgpu_aca_is_enabled(adev) && mca_funcs && mca_funcs->mca_set_debug_mode))
+		return con->is_aca_debug_mode;
 	else
 		return true;
 }
@@ -3475,15 +3549,16 @@ bool amdgpu_ras_get_error_query_mode(struct amdgpu_device *adev,
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
+	const struct aca_smu_funcs *smu_funcs = adev->aca.smu_funcs;
 
 	if (!con) {
 		*error_query_mode = AMDGPU_RAS_INVALID_ERROR_QUERY;
 		return false;
 	}
 
-	if (mca_funcs && mca_funcs->mca_set_debug_mode)
+	if ((smu_funcs && smu_funcs->set_debug_mode) || (mca_funcs && mca_funcs->mca_set_debug_mode))
 		*error_query_mode =
-			(con->is_mca_debug_mode) ? AMDGPU_RAS_DIRECT_ERROR_QUERY : AMDGPU_RAS_FIRMWARE_ERROR_QUERY;
+			(con->is_aca_debug_mode) ? AMDGPU_RAS_DIRECT_ERROR_QUERY : AMDGPU_RAS_FIRMWARE_ERROR_QUERY;
 	else
 		*error_query_mode = AMDGPU_RAS_DIRECT_ERROR_QUERY;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 8c487f3bfbf1..4503cc6eec66 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -442,7 +442,7 @@ struct amdgpu_ras {
 	/* Indicates smu whether need update bad channel info */
 	bool update_channel_flag;
 	/* Record status of smu mca debug mode */
-	bool is_mca_debug_mode;
+	bool is_aca_debug_mode;
 
 	/* Record special requirements of gpu reset caller */
 	uint32_t  gpu_reset_flags;
@@ -530,6 +530,8 @@ struct ras_manager {
 	struct ras_ih_data ih_data;
 
 	struct ras_err_data err_data;
+
+	struct aca_handle aca_handle;
 };
 
 struct ras_badpage {
@@ -781,9 +783,9 @@ struct amdgpu_ras* amdgpu_ras_get_context(struct amdgpu_device *adev);
 
 int amdgpu_ras_set_context(struct amdgpu_device *adev, struct amdgpu_ras *ras_con);
 
-int amdgpu_ras_set_aca_debug_mode(struct amdgpu_device *adev, bool enable);
 int amdgpu_ras_set_mca_debug_mode(struct amdgpu_device *adev, bool enable);
-bool amdgpu_ras_get_mca_debug_mode(struct amdgpu_device *adev);
+int amdgpu_ras_set_aca_debug_mode(struct amdgpu_device *adev, bool enable);
+bool amdgpu_ras_get_aca_debug_mode(struct amdgpu_device *adev);
 bool amdgpu_ras_get_error_query_mode(struct amdgpu_device *adev,
 				     unsigned int *mode);
 
@@ -824,4 +826,8 @@ int amdgpu_ras_error_statistic_ue_count(struct ras_err_data *err_data,
 ssize_t amdgpu_ras_aca_sysfs_read(struct device *dev, struct device_attribute *attr,
 				  struct aca_handle *handle, char *buf, void *data);
 
+int amdgpu_ras_bind_aca(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
+			       const struct aca_info *aca_info, void *data);
+int amdgpu_ras_unbind_aca(struct amdgpu_device *adev, enum amdgpu_ras_block blk);
+
 #endif
-- 
2.34.1

