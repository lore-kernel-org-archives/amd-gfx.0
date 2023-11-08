Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E97C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 12:58:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4482210E0A1;
	Wed,  8 Nov 2023 12:58:10 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2059.outbound.protection.outlook.com [40.107.101.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7886310E72F
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 12:58:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2XztVguDwziaFEM2koXJQGL8QY4yVJRm4vnnveY04zzDDwMfumBCDPHPGNsY+fSfRRE9qgnLXSso69CRGBJn11hCIZs0xKkxwmQxOyZlkmBGHkP1ox8vt2xJ24e1gGrXCBmJDtZLvRg0ydTtLS4wX2gwBNRtjBvQHM46APwIQDD5ppfi5z5sMdpCXdN2l512+veOTRYFl3r2KXDRZLEzAdeE076s9jCsFHDQad4kQT4+JOTfJyHXYFZW4TZBlzWhmOnWKYOXW3fFcyvyqc2y8DlPqSReVA42z8pBXh+c84Xhpok/m1XriUIZyE765cg94lQ3d20b8x3Pf4/lXBhWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ikO7okW7HtjjBcpHyV3TVdyc7hnxfvYZkBfsnsoc9Qg=;
 b=LNrvs8FR/UVESCvgcFY12YFppkwf4o4Vl7XYTuOyVDkNcsCvDrCyg4z/jO2P2VCsrYMS78ciotaaPE+LilU2LTAmv8e3gBzyutOCO+nclrKSy8Fb/q98ibCf/jxcYDOLonFi5CBdtiEugo9JOEUDV6YhmMenRIVh5BJUht4EkTElFFpgp538fYd0xoxYTaqwwXwC6Ie4syBLEbOZuoBGMD7mLHo+z2B02mIyC70kOvsqjZbLfuy3mn8epJY5fCOWj6O/VBmCJ/PZouRWP9OzLh264dvXW7sdehA2onwwHh+YbQAVYIWCA1MZOwWNLSayTV2jMGZ7a3Jhsk9HQ/TEGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikO7okW7HtjjBcpHyV3TVdyc7hnxfvYZkBfsnsoc9Qg=;
 b=m3M6xp860se3fhEwgkfy/3ftjTT6ka+72ffV7/7sm40KQ7OldtU0Os3HO0iECWvVz0YtzsX8o2wUFZWwELylesNFvgX2Bb/NEmQF6BkjyRfFmt8UUAJ4eg97niR+EYuuN77ZhPAAD+IbTsUfLmRhbfLaly7HtPEJAbRE1V5BTAw=
Received: from SN4PR0501CA0123.namprd05.prod.outlook.com
 (2603:10b6:803:42::40) by MN0PR12MB6079.namprd12.prod.outlook.com
 (2603:10b6:208:3c9::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Wed, 8 Nov
 2023 12:58:05 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:803:42:cafe::79) by SN4PR0501CA0123.outlook.office365.com
 (2603:10b6:803:42::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Wed, 8 Nov 2023 12:58:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Wed, 8 Nov 2023 12:58:04 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 8 Nov
 2023 06:58:01 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/7] drm/amdgpu: Support multiple error query modes
Date: Wed, 8 Nov 2023 20:57:31 +0800
Message-ID: <20231108125735.2497856-3-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231108125735.2497856-1-kevinyang.wang@amd.com>
References: <20231108125735.2497856-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|MN0PR12MB6079:EE_
X-MS-Office365-Filtering-Correlation-Id: 71cb5096-0215-491f-6cb3-08dbe05a58ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HU6ZRqGVJDbdt5pirKTSAYBmJwJILbcukGCUR/y/+vdNSRdSpyFBT3dMJVixCHT4gJb4VysAaoeEmdsyMScnRFm8L6P7PtT32VPquAZxeBzES3BrSfYPxDmsQC317dEjuBEJIW6qsUDj1urgoBAkzgoMpFQJ2VMUiWd5Enn/A7rojDsWBNSaH7Dw0JJDtPrXbTga91FIVZXbfOVQ6GFDhOY/178SysYzLflTleyb2+ImQdCTFM4I/0hFFCs1McJJx3HnCe31X+BoJxjQvtDum+FM1qb8s2uUAksXRyhRti92VEbzXw3JedywZgkqfOcosTxY8IAUJWfJe4gHRAxZETGwzC8rQoVoouvgEF3TW0x5eeEaPchUZI4pAsXHNeO6WyLNA+/NduUwmMi2C3uXFqqT/Z6BkG/bwPEF+1HB/4qtajYApSTfSOZYFWhYh4uVtL8oaJSadVEOADICHtz4bX0sk08fyawfs4Mi89LpoLKgHaoX7DFZyOg/N5Rw6JYnksjYIILWLVhbT7ZzMf8uSMVrfEUMOMl5Y5GKWzOZtV1LL393EJ2zkncUqZ5HVi7cObXwjPm/MWOiI14Z37FHyRCq1UPt0i6FW0+3YSkCBdsNYshqFdiuK3qBiCKbPJWmujHLrxOaUuyfgZ8zz4ljONi0ekV73EOjkTuqFNTQfbpH4fBwy2UUkZAtn8p6oOCBxS7Y+5HuUmVpmu1qLjZ9FbcCOUC7vRA2Ld2ZFJDr1/vxtVxR3XFibVmXmF/Z4QRufrXgs6q5bfxK/DMhjFqtZQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(376002)(396003)(346002)(230922051799003)(82310400011)(186009)(1800799009)(64100799003)(451199024)(46966006)(36840700001)(40470700004)(2616005)(5660300002)(47076005)(1076003)(54906003)(26005)(16526019)(6916009)(478600001)(40480700001)(316002)(6666004)(7696005)(70206006)(70586007)(336012)(40460700003)(426003)(8936002)(83380400001)(4326008)(8676002)(36756003)(2906002)(41300700001)(86362001)(82740400003)(81166007)(356005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 12:58:04.5999 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71cb5096-0215-491f-6cb3-08dbe05a58ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6079
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Direct error query mode and firmware error query mode
are supported for now.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 93 +++++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  8 +++
 2 files changed, 78 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index cfb361cd0320..11055e0856bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1165,13 +1165,53 @@ static void amdgpu_rasmgr_error_data_statistic_update(struct ras_manager *obj, s
 	}
 }
 
-/* query/inject/cure begin */
-int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
-				  struct ras_query_if *info)
+static int amdgpu_ras_query_error_status_helper(struct amdgpu_device *adev,
+						struct ras_query_if *info,
+						struct ras_err_data *err_data,
+						unsigned int error_query_mode)
 {
+	enum amdgpu_ras_block blk = info ? info->head.block : AMDGPU_RAS_BLOCK_COUNT;
 	struct amdgpu_ras_block_object *block_obj = NULL;
+
+	if (error_query_mode == AMDGPU_RAS_INVALID_ERROR_QUERY)
+		return -EINVAL;
+
+	if (error_query_mode == AMDGPU_RAS_DIRECT_ERROR_QUERY) {
+		if (info->head.block == AMDGPU_RAS_BLOCK__UMC) {
+			amdgpu_ras_get_ecc_info(adev, err_data);
+		} else {
+			block_obj = amdgpu_ras_get_ras_block(adev, info->head.block, 0);
+			if (!block_obj || !block_obj->hw_ops) {
+				dev_dbg_once(adev->dev, "%s doesn't config RAS function\n",
+					     get_ras_block_str(&info->head));
+				return -EINVAL;
+			}
+
+			if (block_obj->hw_ops->query_ras_error_count)
+				block_obj->hw_ops->query_ras_error_count(adev, &err_data);
+
+			if ((info->head.block == AMDGPU_RAS_BLOCK__SDMA) ||
+			    (info->head.block == AMDGPU_RAS_BLOCK__GFX) ||
+			    (info->head.block == AMDGPU_RAS_BLOCK__MMHUB)) {
+				if (block_obj->hw_ops->query_ras_error_status)
+					block_obj->hw_ops->query_ras_error_status(adev);
+			}
+		}
+	} else {
+		/* FIXME: add code to check return value later */
+		amdgpu_mca_smu_log_ras_error(adev, blk, AMDGPU_MCA_ERROR_TYPE_UE, err_data);
+		amdgpu_mca_smu_log_ras_error(adev, blk, AMDGPU_MCA_ERROR_TYPE_CE, err_data);
+	}
+
+	return 0;
+}
+
+/* query/inject/cure begin */
+int amdgpu_ras_query_error_status(struct amdgpu_device *adev, struct ras_query_if *info)
+{
 	struct ras_manager *obj = amdgpu_ras_find_obj(adev, &info->head);
 	struct ras_err_data err_data;
+	unsigned int error_query_mode;
 	int ret;
 
 	if (!obj)
@@ -1181,27 +1221,14 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 	if (ret)
 		return ret;
 
-	if (info->head.block == AMDGPU_RAS_BLOCK__UMC) {
-		amdgpu_ras_get_ecc_info(adev, &err_data);
-	} else {
-		block_obj = amdgpu_ras_get_ras_block(adev, info->head.block, 0);
-		if (!block_obj || !block_obj->hw_ops)   {
-			dev_dbg_once(adev->dev, "%s doesn't config RAS function\n",
-				     get_ras_block_str(&info->head));
-			ret = -EINVAL;
-			goto out_fini_err_data;
-		}
-
-		if (block_obj->hw_ops->query_ras_error_count)
-			block_obj->hw_ops->query_ras_error_count(adev, &err_data);
+	if (!amdgpu_ras_get_error_query_mode(adev, &error_query_mode))
+		return -EINVAL;
 
-		if ((info->head.block == AMDGPU_RAS_BLOCK__SDMA) ||
-		    (info->head.block == AMDGPU_RAS_BLOCK__GFX) ||
-		    (info->head.block == AMDGPU_RAS_BLOCK__MMHUB)) {
-				if (block_obj->hw_ops->query_ras_error_status)
-					block_obj->hw_ops->query_ras_error_status(adev);
-			}
-	}
+	ret = amdgpu_ras_query_error_status_helper(adev, info,
+						   &err_data,
+						   error_query_mode);
+	if (ret)
+		goto out_fini_err_data;
 
 	amdgpu_rasmgr_error_data_statistic_update(obj, &err_data);
 
@@ -3397,6 +3424,26 @@ bool amdgpu_ras_get_mca_debug_mode(struct amdgpu_device *adev)
 		return true;
 }
 
+bool amdgpu_ras_get_error_query_mode(struct amdgpu_device *adev,
+				     unsigned int *error_query_mode)
+{
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
+
+	if (!con) {
+		*error_query_mode = AMDGPU_RAS_INVALID_ERROR_QUERY;
+		return false;
+	}
+
+	if (mca_funcs && mca_funcs->mca_set_debug_mode)
+		*error_query_mode =
+			(con->is_mca_debug_mode) ? AMDGPU_RAS_DIRECT_ERROR_QUERY : AMDGPU_RAS_FIRMWARE_ERROR_QUERY;
+	else
+		*error_query_mode = AMDGPU_RAS_DIRECT_ERROR_QUERY;
+
+	return true;
+}
+
 /* Register each ip ras block into amdgpu ras */
 int amdgpu_ras_register_ras_block(struct amdgpu_device *adev,
 		struct amdgpu_ras_block_object *ras_block_obj)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 665414c22ca9..19161916ac46 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -320,6 +320,12 @@ enum amdgpu_ras_ret {
 	AMDGPU_RAS_PT,
 };
 
+enum amdgpu_ras_error_query_mode {
+	AMDGPU_RAS_INVALID_ERROR_QUERY		= 0,
+	AMDGPU_RAS_DIRECT_ERROR_QUERY		= 1,
+	AMDGPU_RAS_FIRMWARE_ERROR_QUERY		= 2,
+};
+
 /* ras error status reisger fields */
 #define ERR_STATUS_LO__ERR_STATUS_VALID_FLAG__SHIFT	0x0
 #define ERR_STATUS_LO__ERR_STATUS_VALID_FLAG_MASK	0x00000001L
@@ -769,6 +775,8 @@ int amdgpu_ras_set_context(struct amdgpu_device *adev, struct amdgpu_ras *ras_co
 
 void amdgpu_ras_set_mca_debug_mode(struct amdgpu_device *adev, bool enable);
 bool amdgpu_ras_get_mca_debug_mode(struct amdgpu_device *adev);
+bool amdgpu_ras_get_error_query_mode(struct amdgpu_device *adev,
+				     unsigned int *mode);
 
 int amdgpu_ras_register_ras_block(struct amdgpu_device *adev,
 				struct amdgpu_ras_block_object *ras_block_obj);
-- 
2.34.1

