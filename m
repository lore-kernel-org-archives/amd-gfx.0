Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0023C3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 08:03:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4694410E248;
	Wed,  3 Jan 2024 08:03:54 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1707510E242
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 08:03:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NM5XzPiytWE4pKDax7mtHDdoZyGKnypaHARPGGxfw3T7rV/96agoz2LhcSGSrQjBQzJwoxF/+FIPSHu+PVEQ1fESSH2T3VXD9lN9lb83e75DSe8VArMt4NNMle0BftWcEp7Dxv6ouKWOAs77lKkc5Z2BIZ68CUO5uVqKWzzFyu924hU+WTHxv71UUeMvDKnp+Zimnr48hUz+qYAvOcUcp8pt4iMMLIJla+JGqHoBDKwldeoAa2FTXHfs/21zso1GVFinKbGKUPm0hWFL12Un/23OAURbgeZ86fghF47VkyxalZS2FHrCrkYC9Dhj0yDevnLi26TuStWZg5eRv8bz9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3LUM1aqBhERlv2jzAvja6JO+t3rN+sqvPhcSkE+6T6M=;
 b=jyvBzV+/7ZYj/1k+03vmw3P6JkUwoV35ji8hA1NL6P8RTCn0rNwmLfCtvoFVXQs4wn3q1JkAXQkBnCBmePlOF3zDVXa7X47kXb4rhja77M5OGGaDnrWNEdn/ZBteIZY3C6GEivX8RJMBT4zGL7+9A3EKoyC7JRnpPsM98NNhb7yvXZpaU/fdZQ2+2/sOO2oWU06N0b3jrtmUVbYlfy/EPmhZOpJLY7Bw/lBecAx/SokLpWLfGhSGWLi5QBYCMOC3w+53wYbBqMgqj3G7wgQz0SeM9DjY7zzCre1iVvS2aM3vKwVcP0ydjR6JHrqVgwJSmNh+LQXJGrrLAKJi/DAtDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LUM1aqBhERlv2jzAvja6JO+t3rN+sqvPhcSkE+6T6M=;
 b=x+Hs4q/W42WZX6lwciSuYoKufWyXHJt2pjWobkyu7b33mobkUSspUVuYrNmIiXw8joZc/6mHFz/lsTVpgv7+x3jqrANCazO+zZk50AUWvlAG/MFCdzDrb5uyaJe2z65k0ktwpUJ+puWV+Mexk0eXU8mF3U0jrRoKqGttyh9v9Nc=
Received: from SJ0PR05CA0036.namprd05.prod.outlook.com (2603:10b6:a03:33f::11)
 by PH8PR12MB6794.namprd12.prod.outlook.com (2603:10b6:510:1c5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 08:03:50 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::72) by SJ0PR05CA0036.outlook.office365.com
 (2603:10b6:a03:33f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.12 via Frontend
 Transport; Wed, 3 Jan 2024 08:03:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Wed, 3 Jan 2024 08:03:50 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 3 Jan
 2024 02:03:47 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/14] drm/amdgpu: add amdgpu ras aca query interface
Date: Wed, 3 Jan 2024 16:02:11 +0800
Message-ID: <20240103080220.2815115-6-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240103080220.2815115-1-kevinyang.wang@amd.com>
References: <20240103080220.2815115-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|PH8PR12MB6794:EE_
X-MS-Office365-Filtering-Correlation-Id: 6782f1bf-43c3-4a2a-26e8-08dc0c328536
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1o1GK/eX7CMiCuB+5Vg3xjpkzOOPcHSDpSgrUqsknebIJQRf7rNcl1kHH4ZyWuE0utw3nQiblVpICMQxK2OlC/vzS3Q3WzLi09mOYQUEdxvAKhASUWW2Q4QMOW1JO6nB0z+KmVoUipYSOUaAOTCQUSKKdMJrZqrRBchCfn929AysRsyHSI8CCgbkqnuF+y10/dPABIAL9X2t8NTNIphXurDjzuOmHGYdF6sqQHIGy4JEV4ig19Nkc5y1/6/GyIT8XrkMnhnuMghvigc+UKQ5RXe8C34KIYY1FyjAhkIVED4oob+/AWbVeVipImvEq8YNyPN9IpRddqHk1rMlqx3j1RMGK+KgK7Qd1U7P5s+ZN1SnddP7ScogA/gbsjs5FJ7iLu7blHpeb+970ZK/cpY6dZ0ezpa0AFHJvuWMHTZ1ug4y4G1GR4kAEbGO/1PC2dAwzuOycyQIGym+7Uu0nfaYwq6YbLXzR6N26EgabBrOnQhSAGic3C2qLaMBjZzbNoI3s8fuG7hzZr3x4fZ17zOBM6V2O8JkDed7GYhZ942MD3hVYe8//Icm0B0KC9+pEO9oco4o4hkrkr7THIasBswahhe/oMQx/ER0InWgwo3WmikHa1npyFdKooiaSbIlzwJO7aqNHyiyxlN1O6vCXACsFIZow8Oho2kvwQ/g+clKQWHHbxFBxidBcI8m3GfTOtr6d0CKVbAdnlqznYXoQZk+trAiYXF4kb44GYyNgeP71VRa+QdLr1aLkP3nXNTYzjSqHvvbqc7a+jEiGjgTL5+6FQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(82310400011)(186009)(451199024)(64100799003)(1800799012)(46966006)(40470700004)(36840700001)(2906002)(82740400003)(5660300002)(81166007)(356005)(36756003)(1076003)(26005)(426003)(336012)(16526019)(478600001)(2616005)(6916009)(40480700001)(83380400001)(40460700003)(70206006)(70586007)(41300700001)(6666004)(7696005)(8676002)(8936002)(86362001)(4326008)(47076005)(316002)(54906003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 08:03:50.0553 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6782f1bf-43c3-4a2a-26e8-08dc0c328536
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6794
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

use new ACA error query interface to instead of legacy MCA query.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 88 ++++++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 12 +++-
 2 files changed, 79 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 038bd1b17cef..bbae41f86e00 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1168,6 +1168,53 @@ static void amdgpu_rasmgr_error_data_statistic_update(struct ras_manager *obj, s
 	}
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
@@ -1175,6 +1222,7 @@ static int amdgpu_ras_query_error_status_helper(struct amdgpu_device *adev,
 {
 	enum amdgpu_ras_block blk = info ? info->head.block : AMDGPU_RAS_BLOCK_COUNT;
 	struct amdgpu_ras_block_object *block_obj = NULL;
+	int ret;
 
 	if (blk == AMDGPU_RAS_BLOCK_COUNT)
 		return -EINVAL;
@@ -1204,9 +1252,13 @@ static int amdgpu_ras_query_error_status_helper(struct amdgpu_device *adev,
 			}
 		}
 	} else {
-		/* FIXME: add code to check return value later */
-		amdgpu_mca_smu_log_ras_error(adev, blk, AMDGPU_MCA_ERROR_TYPE_UE, err_data);
-		amdgpu_mca_smu_log_ras_error(adev, blk, AMDGPU_MCA_ERROR_TYPE_CE, err_data);
+		ret = amdgpu_aca_log_ras_error_data(adev, blk, ACA_ERROR_TYPE_UE, err_data);
+		if (ret)
+			return ret;
+
+		ret = amdgpu_aca_log_ras_error_data(adev, blk, ACA_ERROR_TYPE_CE, err_data);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
@@ -1254,7 +1306,7 @@ int amdgpu_ras_reset_error_count(struct amdgpu_device *adev,
 {
 	struct amdgpu_ras_block_object *block_obj = amdgpu_ras_get_ras_block(adev, block, 0);
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
-	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
+	const struct aca_smu_funcs *smu_funcs = adev->aca.smu_funcs;
 	struct amdgpu_hive_info *hive;
 	int hive_ras_recovery = 0;
 
@@ -1265,7 +1317,7 @@ int amdgpu_ras_reset_error_count(struct amdgpu_device *adev,
 	}
 
 	if (!amdgpu_ras_is_supported(adev, block) ||
-	    !amdgpu_ras_get_mca_debug_mode(adev))
+	    !amdgpu_ras_get_aca_debug_mode(adev))
 		return -EOPNOTSUPP;
 
 	hive = amdgpu_get_xgmi_hive(adev);
@@ -1277,7 +1329,7 @@ int amdgpu_ras_reset_error_count(struct amdgpu_device *adev,
 	/* skip ras error reset in gpu reset */
 	if ((amdgpu_in_reset(adev) || atomic_read(&ras->in_recovery) ||
 	    hive_ras_recovery) &&
-	    mca_funcs && mca_funcs->mca_set_debug_mode)
+	    smu_funcs && smu_funcs->set_debug_mode)
 		return -EOPNOTSUPP;
 
 	if (block_obj->hw_ops->reset_ras_error_count)
@@ -1773,7 +1825,7 @@ void amdgpu_ras_debugfs_create_all(struct amdgpu_device *adev)
 		}
 	}
 
-	amdgpu_mca_smu_debugfs_init(adev, dir);
+	amdgpu_aca_smu_debugfs_init(adev, dir);
 }
 
 /* debugfs end */
@@ -3138,8 +3190,8 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	/* enable MCA debug on APU device */
-	amdgpu_ras_set_mca_debug_mode(adev, !!(adev->flags & AMD_IS_APU));
+	/* enable ACA debug on APU device */
+	amdgpu_ras_set_aca_debug_mode(adev, !!(adev->flags & AMD_IS_APU));
 
 	list_for_each_entry_safe(node, tmp, &adev->ras_list, node) {
 		if (!node->ras_obj) {
@@ -3422,7 +3474,7 @@ int amdgpu_ras_set_mca_debug_mode(struct amdgpu_device *adev, bool enable)
 	if (con) {
 		ret = amdgpu_mca_smu_set_debug_mode(adev, enable);
 		if (!ret)
-			con->is_mca_debug_mode = enable;
+			con->is_aca_debug_mode = enable;
 	}
 
 	return ret;
@@ -3436,22 +3488,22 @@ int amdgpu_ras_set_aca_debug_mode(struct amdgpu_device *adev, bool enable)
 	if (con) {
 		ret = amdgpu_aca_smu_set_debug_mode(adev, enable);
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
-	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
+	const struct aca_smu_funcs *smu_funcs = adev->aca.smu_funcs;
 
 	if (!con)
 		return false;
 
-	if (mca_funcs && mca_funcs->mca_set_debug_mode)
-		return con->is_mca_debug_mode;
+	if (smu_funcs && smu_funcs->set_debug_mode)
+		return con->is_aca_debug_mode;
 	else
 		return true;
 }
@@ -3460,16 +3512,16 @@ bool amdgpu_ras_get_error_query_mode(struct amdgpu_device *adev,
 				     unsigned int *error_query_mode)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
+	const struct aca_smu_funcs *smu_funcs = adev->aca.smu_funcs;
 
 	if (!con) {
 		*error_query_mode = AMDGPU_RAS_INVALID_ERROR_QUERY;
 		return false;
 	}
 
-	if (mca_funcs && mca_funcs->mca_set_debug_mode)
+	if (smu_funcs && smu_funcs->set_debug_mode)
 		*error_query_mode =
-			(con->is_mca_debug_mode) ? AMDGPU_RAS_DIRECT_ERROR_QUERY : AMDGPU_RAS_FIRMWARE_ERROR_QUERY;
+			(con->is_aca_debug_mode) ? AMDGPU_RAS_DIRECT_ERROR_QUERY : AMDGPU_RAS_FIRMWARE_ERROR_QUERY;
 	else
 		*error_query_mode = AMDGPU_RAS_DIRECT_ERROR_QUERY;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 408e21c3cc88..2afac9aa381a 100644
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
 
@@ -821,4 +823,8 @@ int amdgpu_ras_error_statistic_ue_count(struct ras_err_data *err_data,
 		struct amdgpu_smuio_mcm_config_info *mcm_info,
 		struct ras_err_addr *err_addr, u64 count);
 
+int amdgpu_ras_bind_aca(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
+			       const struct aca_info *aca_info, void *data);
+int amdgpu_ras_unbind_aca(struct amdgpu_device *adev, enum amdgpu_ras_block blk);
+
 #endif
-- 
2.34.1

