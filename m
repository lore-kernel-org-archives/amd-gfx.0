Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83888C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Dec 2021 06:33:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0DEF10E36F;
	Wed, 29 Dec 2021 06:33:09 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2047.outbound.protection.outlook.com [40.107.101.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 956AB10E3C0
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Dec 2021 06:33:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dL2NL584I3DUTHtztv1vFwSCL4d13AdhIMWzf58YqV+b5lJmZavOBuNGrTJOg78//Ndv07bFTs+gKo2Wi4W38AESx+2e2am0vTB/+rySppFF8rfaQorhOC0Ut5TY/0dCFV2PJhghK8IZ1Ts4QNEMuFC3+9S1zYMHR+7WpeBhmoXPIyKlT5Cxy7MNeRVwcNFoZkfXMTmIeIUWWrqdluZPikrCUJMxf4KuAixNuHlflbm9OjC2wVOpltikk2wEpcarWtRt5v+6JY9hFguyo298REOwLdYzoMv/MWtTi14H8F4nygxFVwAe02RMZnijDr7HzmNXYdQOTNtzHhg2FKeQhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmNMWfPEC336YWZzTQApTInhCquGHj4ghTt7vRV1r8s=;
 b=f7B/8oKkaYTUW+h/xGB0GdEgKNqE7aPv3X6x42FCLfAYrNDYrIJtIcYl0XdiLbkFe+KQNuS4Y+EDbCyUCClqaWThrR9l9cGJpcu4ruVDdIsSst3L8xQBeMqRp+QPXbb7JdGj17uSzhdXzSILQsXc7Uh3a/1KNjkX/zVJc+pS2JjW+n0e3s+Bc/Ktyk+b0XzBZ+EW4e2TYKyUYkKXcYtEbMFYgmYK0WKTIoMlm2Qd2cNpol7UbwXkfUyMfA+1UxPnYP7RaNq/D19SqlhDZz21YpULPW6L+E/4BzKWsZjGKawDgL80/tLnrB6Pzp/NbLld33BA3VchwLiiYYaMicIjtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmNMWfPEC336YWZzTQApTInhCquGHj4ghTt7vRV1r8s=;
 b=J+PjqwaSwkNTJz0JfZphVNEXlxPCwfUq+coe8oP0pQ9u7w9SaKlUyXR3+rxp92fGCbtFynQ1YT4yM5+TmxhZ+THpz/wiwb/Jh2pMmHkw99TrRO0Y8FkiX4o0mjIuTxLnCw4tR86RTpdsr+oSZnbENnJQcBOYj8z7MmCRgYLTcSY=
Received: from MW4PR04CA0044.namprd04.prod.outlook.com (2603:10b6:303:6a::19)
 by BYAPR12MB3032.namprd12.prod.outlook.com (2603:10b6:a03:dd::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.13; Wed, 29 Dec
 2021 06:33:03 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::94) by MW4PR04CA0044.outlook.office365.com
 (2603:10b6:303:6a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19 via Frontend
 Transport; Wed, 29 Dec 2021 06:33:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4823.18 via Frontend Transport; Wed, 29 Dec 2021 06:33:03 +0000
Received: from thomas.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 29 Dec
 2021 00:33:00 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 06/12] drm/amdgpu: Modify mmhub block to fit for the
 unified ras block data and ops
Date: Wed, 29 Dec 2021 14:32:05 +0800
Message-ID: <20211229063211.43840-6-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211229063211.43840-1-YiPeng.Chai@amd.com>
References: <20211229063211.43840-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af481fe0-a896-4f2d-ad57-08d9ca9510f0
X-MS-TrafficTypeDiagnostic: BYAPR12MB3032:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3032B956D8E0540F44A8046EFC449@BYAPR12MB3032.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VWjmaeMupJObO0uSnOuDBJQdtULHY0riZLvUwCYUHITu+Dsnj79qneAi+xybaqFjrhFPAyMl0Vhwc1iw/AKjpQXtJDPgVoJFe3lYf6n9YM0SvSU3/6KfC5eXIdzdRihBM8WEi94ET0SqXLat7T7y8dwIcrN6yE1XFp2ynD7rbDR2ZlheaFD+LiNIaLFcxT0aKbFGggM4jRkpazemCy/J7i+JmuRasMtzdW8vJVvn8J8DkO5ESWbHeLbnW0NCUxxFpJd162EuoqMA3HJVJ8/EBi0U7IFxRMpuxdiyNu2+/e+x/8oTmf0Ozau7FL1IA2XCeHLCIa/vRPk13RL6RGcY4BcjiD/Bc1Trk/qP2Tcr9sLFMT52gVuKhUVPPyBuKbrvin/T8U8S6ka3iiij8dgmPmn8uTnRX9URNN31tlDuudx3mh2T1eGKNT94SUi4gxk3fwNqj+VahCSTX+oPGcy6QQsimMknVUp0tCUHtvkJeiwUOxHQH0rIhoMYg4N2A65PBwbbm29KDVIpsnQptCALFHy7hVGkZ8UrwfZpyU/BG/e1y0IR6RnHkCdx1urYdh/cggTshoYIAln6L5oRauD3WHitvAhSsyyncM43TUodOzink7PkUPhVo/kmpUx/40ZyD8YJz47aWPnYNdOYvG+EhtxKNL87DjRBFz4F+XdiJDc86+k2KsDmt7g3FnYBnJ7NXHdaJOQQRBxFsoq5lW5YKwWR8IwpIWSfnSwQDphtgtvFUzb1QEn+oJB8ib8PevtBkxDMekiXHrllNYj+yCGFD5f99LbUhR6jq8phZat13NqmKUvF2LCO4y7znadPi6+JiHFjfNzjF7yvpPzBzugjIw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(36840700001)(46966006)(82310400004)(508600001)(2906002)(47076005)(36756003)(4326008)(1076003)(30864003)(86362001)(5660300002)(36860700001)(336012)(316002)(16526019)(6916009)(81166007)(426003)(2616005)(54906003)(8936002)(8676002)(7696005)(40460700001)(356005)(70206006)(70586007)(186003)(83380400001)(26005)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2021 06:33:03.0751 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af481fe0-a896-4f2d-ad57-08d9ca9510f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3032
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1.Modify mmhub block to fit for the unified ras block data and ops.
2.Change amdgpu_mmhub_ras_funcs to amdgpu_mmhub_ras, and the corresponding variable name remove _funcs suffix.
3.Remove the const flag of mmhub ras variable so that mmhub ras block can be able to be inserted into amdgpu device ras block link list.
4.Invoke amdgpu_ras_register_ras_block function to register mmhub ras block into amdgpu device ras block link list. 5.Remove the redundant code about mmhub in amdgpu_ras.c after using the unified ras block.
5.Remove the redundant code about mmhub in amdgpu_ras.c after using the unified ras block.
6.Fill unified ras block .name .block .ras_late_init and .ras_fini for all of mmhub versions. If .ras_late_init and .ras_fini had been defined by the selected mmhub version, the defined functions will take effect; if not defined, default fill them with amdgpu_mmhub_ras_late_init and amdgpu_mmhub_ras_fini.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    | 10 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h  | 14 ++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 47 ++++++----------------
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 28 ++++++++++---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c    | 10 +++--
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.h    |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c    | 10 +++--
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.h    |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c    | 10 +++--
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.h    |  2 +-
 12 files changed, 74 insertions(+), 75 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0980396ee709..feb93880c63d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3377,9 +3377,9 @@ static void amdgpu_device_xgmi_reset_func(struct work_struct *__work)
 		if (adev->asic_reset_res)
 			goto fail;
 
-		if (adev->mmhub.ras_funcs &&
-		    adev->mmhub.ras_funcs->reset_ras_error_count)
-			adev->mmhub.ras_funcs->reset_ras_error_count(adev);
+		if (adev->mmhub.ras && adev->mmhub.ras->ras_block.hw_ops &&
+		    adev->mmhub.ras->ras_block.hw_ops->reset_ras_error_count)
+			adev->mmhub.ras->ras_block.hw_ops->reset_ras_error_count(adev);
 	} else {
 
 		task_barrier_full(&hive->tb);
@@ -4705,9 +4705,9 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 
 	if (!r && amdgpu_ras_intr_triggered()) {
 		list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
-			if (tmp_adev->mmhub.ras_funcs &&
-			    tmp_adev->mmhub.ras_funcs->reset_ras_error_count)
-				tmp_adev->mmhub.ras_funcs->reset_ras_error_count(tmp_adev);
+			if (tmp_adev->mmhub.ras && tmp_adev->mmhub.ras->ras_block.hw_ops &&
+			    tmp_adev->mmhub.ras->ras_block.hw_ops->reset_ras_error_count)
+				tmp_adev->mmhub.ras->ras_block.hw_ops->reset_ras_error_count(tmp_adev);
 		}
 
 		amdgpu_ras_intr_cleared();
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index b8902ad7e375..b12da46c483a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -441,9 +441,8 @@ int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
 			return r;
 	}
 
-	if (adev->mmhub.ras_funcs &&
-	    adev->mmhub.ras_funcs->ras_late_init) {
-		r = adev->mmhub.ras_funcs->ras_late_init(adev);
+	if (adev->mmhub.ras && adev->mmhub.ras->ras_block.ras_late_init) {
+		r = adev->mmhub.ras->ras_block.ras_late_init(adev, NULL);
 		if (r)
 			return r;
 	}
@@ -495,9 +494,8 @@ void amdgpu_gmc_ras_fini(struct amdgpu_device *adev)
 	    adev->umc.ras_funcs->ras_fini)
 		adev->umc.ras_funcs->ras_fini(adev);
 
-	if (adev->mmhub.ras_funcs &&
-	    adev->mmhub.ras_funcs->ras_fini)
-		adev->mmhub.ras_funcs->ras_fini(adev);
+	if (adev->mmhub.ras && adev->mmhub.ras->ras_block.ras_fini)
+		adev->mmhub.ras->ras_block.ras_fini(adev);
 
 	if (adev->gmc.xgmi.ras && adev->gmc.xgmi.ras->ras_block.ras_fini)
 		adev->gmc.xgmi.ras->ras_block.ras_fini(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
index ead3dc572ec5..d7e7708f0360 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
@@ -24,7 +24,7 @@
 #include "amdgpu.h"
 #include "amdgpu_ras.h"
 
-int amdgpu_mmhub_ras_late_init(struct amdgpu_device *adev)
+int amdgpu_mmhub_ras_late_init(struct amdgpu_device *adev, void *ras_info)
 {
 	int r;
 	struct ras_ih_if ih_info = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
index b27fcbccce2b..7deda9a3b81e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
@@ -21,14 +21,8 @@
 #ifndef __AMDGPU_MMHUB_H__
 #define __AMDGPU_MMHUB_H__
 
-struct amdgpu_mmhub_ras_funcs {
-	int (*ras_late_init)(struct amdgpu_device *adev);
-	void (*ras_fini)(struct amdgpu_device *adev);
-	void (*query_ras_error_count)(struct amdgpu_device *adev,
-				      void *ras_error_status);
-	void (*query_ras_error_status)(struct amdgpu_device *adev);
-	void (*reset_ras_error_count)(struct amdgpu_device *adev);
-	void (*reset_ras_error_status)(struct amdgpu_device *adev);
+struct amdgpu_mmhub_ras {
+	struct amdgpu_ras_block_object ras_block;
 };
 
 struct amdgpu_mmhub_funcs {
@@ -50,10 +44,10 @@ struct amdgpu_mmhub_funcs {
 struct amdgpu_mmhub {
 	struct ras_common_if *ras_if;
 	const struct amdgpu_mmhub_funcs *funcs;
-	const struct amdgpu_mmhub_ras_funcs *ras_funcs;
+	struct amdgpu_mmhub_ras  *ras;
 };
 
-int amdgpu_mmhub_ras_late_init(struct amdgpu_device *adev);
+int amdgpu_mmhub_ras_late_init(struct amdgpu_device *adev, void *ras_info);
 void amdgpu_mmhub_ras_fini(struct amdgpu_device *adev);
 #endif
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index ecb35d9994ee..fa0ebd484c7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -956,6 +956,7 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 		}
 		break;
 	case AMDGPU_RAS_BLOCK__GFX:
+	case AMDGPU_RAS_BLOCK__MMHUB:
 		if (!block_obj || !block_obj->hw_ops)   {
 			dev_info(adev->dev, "%s doesn't config ras function \n",
 						get_ras_block_str(&info->head));
@@ -967,15 +968,6 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 		if (block_obj->hw_ops->query_ras_error_status)
 			block_obj->hw_ops->query_ras_error_status(adev);
 		break;
-	case AMDGPU_RAS_BLOCK__MMHUB:
-		if (adev->mmhub.ras_funcs &&
-		    adev->mmhub.ras_funcs->query_ras_error_count)
-			adev->mmhub.ras_funcs->query_ras_error_count(adev, &err_data);
-
-		if (adev->mmhub.ras_funcs &&
-		    adev->mmhub.ras_funcs->query_ras_error_status)
-			adev->mmhub.ras_funcs->query_ras_error_status(adev);
-		break;
 	case AMDGPU_RAS_BLOCK__PCIE_BIF:
 		if (adev->nbio.ras_funcs &&
 		    adev->nbio.ras_funcs->query_ras_error_count)
@@ -1059,6 +1051,7 @@ int amdgpu_ras_reset_error_status(struct amdgpu_device *adev,
 
 	switch (block) {
 	case AMDGPU_RAS_BLOCK__GFX:
+	case AMDGPU_RAS_BLOCK__MMHUB:
 		if (!block_obj || !block_obj->hw_ops)   {
 			dev_info(adev->dev, "%s doesn't config ras function \n", ras_block_str(block));
 			return -EINVAL;
@@ -1070,15 +1063,6 @@ int amdgpu_ras_reset_error_status(struct amdgpu_device *adev,
 		if (block_obj->hw_ops->reset_ras_error_status)
 			block_obj->hw_ops->reset_ras_error_status(adev);
 		break;
-	case AMDGPU_RAS_BLOCK__MMHUB:
-		if (adev->mmhub.ras_funcs &&
-		    adev->mmhub.ras_funcs->reset_ras_error_count)
-			adev->mmhub.ras_funcs->reset_ras_error_count(adev);
-
-		if (adev->mmhub.ras_funcs &&
-		    adev->mmhub.ras_funcs->reset_ras_error_status)
-			adev->mmhub.ras_funcs->reset_ras_error_status(adev);
-		break;
 	case AMDGPU_RAS_BLOCK__SDMA:
 		if (adev->sdma.funcs->reset_ras_error_count)
 			adev->sdma.funcs->reset_ras_error_count(adev);
@@ -1784,24 +1768,19 @@ static void amdgpu_ras_error_status_query(struct amdgpu_device *adev,
 	 * Only two block need to query read/write
 	 * RspStatus at current state
 	 */
-	switch (info->head.block) {
-	case AMDGPU_RAS_BLOCK__GFX:
-		if (!block_obj || !block_obj->hw_ops)   {
-			dev_info(adev->dev, "%s doesn't config ras function \n", get_ras_block_str(&info->head));
-			return ;
-		}
+	if ((info->head.block != AMDGPU_RAS_BLOCK__GFX) &&
+		(info->head.block != AMDGPU_RAS_BLOCK__MMHUB))
+		return ;
 
-		if (block_obj->hw_ops->query_ras_error_status)
-			block_obj->hw_ops->query_ras_error_status(adev);
-		break;
-	case AMDGPU_RAS_BLOCK__MMHUB:
-		if (adev->mmhub.ras_funcs &&
-		    adev->mmhub.ras_funcs->query_ras_error_status)
-			adev->mmhub.ras_funcs->query_ras_error_status(adev);
-		break;
-	default:
-		break;
+	block_obj = amdgpu_ras_get_ras_block(adev, info->head.block, info->head.sub_block_index);
+	if (!block_obj || !block_obj->hw_ops) {
+		dev_info(adev->dev, "%s doesn't config ras function \n", get_ras_block_str(&info->head));
+		return ;
 	}
+
+	if (block_obj->hw_ops->query_ras_error_status)
+	block_obj->hw_ops->query_ras_error_status(adev);
+
 }
 
 static void amdgpu_ras_query_err_status(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 22ea77817dd9..59829bd3aeb1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1202,18 +1202,34 @@ static void gmc_v9_0_set_mmhub_ras_funcs(struct amdgpu_device *adev)
 {
 	switch (adev->asic_type) {
 	case CHIP_VEGA20:
-		adev->mmhub.ras_funcs = &mmhub_v1_0_ras_funcs;
+		adev->mmhub.ras = &mmhub_v1_0_ras;
 		break;
 	case CHIP_ARCTURUS:
-		adev->mmhub.ras_funcs = &mmhub_v9_4_ras_funcs;
+		adev->mmhub.ras = &mmhub_v9_4_ras;
 		break;
 	case CHIP_ALDEBARAN:
-		adev->mmhub.ras_funcs = &mmhub_v1_7_ras_funcs;
+		adev->mmhub.ras = &mmhub_v1_7_ras;
 		break;
 	default:
 		/* mmhub ras is not available */
 		break;
 	}
+
+	if (adev->mmhub.ras) {
+		amdgpu_ras_register_ras_block(adev, &adev->mmhub.ras->ras_block);
+
+		strcpy(adev->mmhub.ras->ras_block.name,"mmhub");
+		adev->mmhub.ras->ras_block.block = AMDGPU_RAS_BLOCK__MMHUB;
+
+		/* If don't define special ras_late_init function, use default ras_late_init */
+		if (!adev->mmhub.ras->ras_block.ras_late_init)
+				adev->mmhub.ras->ras_block.ras_late_init = amdgpu_mmhub_ras_late_init;
+
+		/* If don't define special ras_fini function, use default ras_fini */
+		if (!adev->mmhub.ras->ras_block.ras_fini)
+				adev->mmhub.ras->ras_block.ras_fini = amdgpu_mmhub_ras_fini;
+	}
+
 }
 
 static void gmc_v9_0_set_gfxhub_funcs(struct amdgpu_device *adev)
@@ -1297,9 +1313,9 @@ static int gmc_v9_0_late_init(void *handle)
 	}
 
 	if (!amdgpu_persistent_edc_harvesting_supported(adev)) {
-		if (adev->mmhub.ras_funcs &&
-		    adev->mmhub.ras_funcs->reset_ras_error_count)
-			adev->mmhub.ras_funcs->reset_ras_error_count(adev);
+		if (adev->mmhub.ras && adev->mmhub.ras->ras_block.hw_ops &&
+		    adev->mmhub.ras->ras_block.hw_ops->reset_ras_error_count)
+			adev->mmhub.ras->ras_block.hw_ops->reset_ras_error_count(adev);
 
 		if (adev->hdp.ras && adev->hdp.ras->ras_block.hw_ops &&
 		    adev->hdp.ras->ras_block.hw_ops->reset_ras_error_count)
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
index b3bede1dc41d..ab48dc7eb689 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -774,13 +774,17 @@ static void mmhub_v1_0_reset_ras_error_count(struct amdgpu_device *adev)
 	}
 }
 
-const struct amdgpu_mmhub_ras_funcs mmhub_v1_0_ras_funcs = {
-	.ras_late_init = amdgpu_mmhub_ras_late_init,
-	.ras_fini = amdgpu_mmhub_ras_fini,
+struct amdgpu_ras_block_hw_ops mmhub_v1_0_ras_hw_ops = {
 	.query_ras_error_count = mmhub_v1_0_query_ras_error_count,
 	.reset_ras_error_count = mmhub_v1_0_reset_ras_error_count,
 };
 
+struct amdgpu_mmhub_ras mmhub_v1_0_ras = {
+	.ras_block = {
+		.hw_ops = &mmhub_v1_0_ras_hw_ops,
+	},
+};
+
 const struct amdgpu_mmhub_funcs mmhub_v1_0_funcs = {
 	.get_fb_location = mmhub_v1_0_get_fb_location,
 	.init = mmhub_v1_0_init,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.h b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.h
index 4661b094e007..dae7ca48bd8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.h
@@ -24,6 +24,6 @@
 #define __MMHUB_V1_0_H__
 
 extern const struct amdgpu_mmhub_funcs mmhub_v1_0_funcs;
-extern const struct amdgpu_mmhub_ras_funcs mmhub_v1_0_ras_funcs;
+extern struct amdgpu_mmhub_ras mmhub_v1_0_ras;
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
index f5f7181f9af5..3b901f941627 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -1321,15 +1321,19 @@ static void mmhub_v1_7_reset_ras_error_status(struct amdgpu_device *adev)
 	}
 }
 
-const struct amdgpu_mmhub_ras_funcs mmhub_v1_7_ras_funcs = {
-	.ras_late_init = amdgpu_mmhub_ras_late_init,
-	.ras_fini = amdgpu_mmhub_ras_fini,
+struct amdgpu_ras_block_hw_ops mmhub_v1_7_ras_hw_ops = {
 	.query_ras_error_count = mmhub_v1_7_query_ras_error_count,
 	.reset_ras_error_count = mmhub_v1_7_reset_ras_error_count,
 	.query_ras_error_status = mmhub_v1_7_query_ras_error_status,
 	.reset_ras_error_status = mmhub_v1_7_reset_ras_error_status,
 };
 
+struct amdgpu_mmhub_ras mmhub_v1_7_ras = {
+	.ras_block = {
+		.hw_ops = &mmhub_v1_7_ras_hw_ops,
+	},
+};
+
 const struct amdgpu_mmhub_funcs mmhub_v1_7_funcs = {
 	.get_fb_location = mmhub_v1_7_get_fb_location,
 	.init = mmhub_v1_7_init,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.h b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.h
index a7f9dfc24697..629f49052137 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.h
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.h
@@ -24,6 +24,6 @@
 #define __MMHUB_V1_7_H__
 
 extern const struct amdgpu_mmhub_funcs mmhub_v1_7_funcs;
-extern const struct amdgpu_mmhub_ras_funcs mmhub_v1_7_ras_funcs;
+extern struct amdgpu_mmhub_ras mmhub_v1_7_ras;
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
index ff49eeaf7882..619106f7d23d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
@@ -1655,14 +1655,18 @@ static void mmhub_v9_4_query_ras_error_status(struct amdgpu_device *adev)
 	}
 }
 
-const struct amdgpu_mmhub_ras_funcs mmhub_v9_4_ras_funcs = {
-	.ras_late_init = amdgpu_mmhub_ras_late_init,
-	.ras_fini = amdgpu_mmhub_ras_fini,
+const struct amdgpu_ras_block_hw_ops mmhub_v9_4_ras_hw_ops = {
 	.query_ras_error_count = mmhub_v9_4_query_ras_error_count,
 	.reset_ras_error_count = mmhub_v9_4_reset_ras_error_count,
 	.query_ras_error_status = mmhub_v9_4_query_ras_error_status,
 };
 
+struct amdgpu_mmhub_ras mmhub_v9_4_ras = {
+	.ras_block = {
+		.hw_ops = &mmhub_v9_4_ras_hw_ops,
+	},
+};
+
 const struct amdgpu_mmhub_funcs mmhub_v9_4_funcs = {
 	.get_fb_location = mmhub_v9_4_get_fb_location,
 	.init = mmhub_v9_4_init,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.h b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.h
index 90436efa92ef..a48329d95f71 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.h
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.h
@@ -24,6 +24,6 @@
 #define __MMHUB_V9_4_H__
 
 extern const struct amdgpu_mmhub_funcs mmhub_v9_4_funcs;
-extern const struct amdgpu_mmhub_ras_funcs mmhub_v9_4_ras_funcs;
+extern struct amdgpu_mmhub_ras mmhub_v9_4_ras;
 
 #endif
-- 
2.25.1

