Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 025ECC43458
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2026 12:08:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 966BC10E390;
	Wed,  1 Jul 2026 12:08:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xoOE6+iO";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012007.outbound.protection.outlook.com
 [40.93.195.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A473010E390
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jul 2026 12:08:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sc+TwmiBegqBpcIV7+xDo16xubcytTiCRhjsx/nWEuuWtuKNxKPOnkVk8bBuV7lRjfg594OrQClH57lPu1qLkQ0QJ9U+3TnDlYM8+LZtEBrwV5+ZiHN3UqhJb1V1lofZGlTLVZ2fROSmvhM9jr80gNB6q6CewkcnYQZjkd3LBwi0mJT+zY4SpBY8YRUpbaRlwlbldOPlu6H5iIvhiP4CArHK+Dbtz1XOhVYgOPqtWoG6kec+kp5QjkceVtm1X3QABX31ivj0jIg7mgJQyKKmazDIi3Uejg8k2aZ0dgL/25DM9K5DFzNHK+H/70wtlkqRfNKlasLy7Ezk2FdMT6Tygg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDld18UzX39mwyShxCJ3RbNNrZ6EsP+lS+qPfOfv+mY=;
 b=ClC6YIq6aedDz6iSlhabRC+jFX7jfoIlNWHiwjq/xxzhZ6myP+NLks1mtDvMhnl+sFI8G2OTm6Qx7gWkT2w5AObefBAec8gCO+lu9NLE3K9CiyQN0b21Rr5RtiqMTb32cJ30Q7DM64X18Z2I3k7403Jb8YMnwOWQlGBpBnmUXTd62FY8Xt7tN8fKmcy88rXq0SZrRLFgk7/BAQMgOgklW6ayTRqfD3WMhRZLJwUhPs6N5eun1Z+tJZQoFDJNDiyWWa9e9M3sd35quHfoNCXwN6Hkcv7OlLaevkhbJTJEYO7eqXo6cITjTdUDkQmwQYTvvVUQ3Rtzswyz11HwRIRBAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDld18UzX39mwyShxCJ3RbNNrZ6EsP+lS+qPfOfv+mY=;
 b=xoOE6+iOD4k9CxBrZPFTZAUplh8+FonHMfbh9kB+Uuw/w45ekHdBEoWZ/gORyjbTNjW+9qXho5XNSfGPVZSwsJqfGcFsC6AmsTTzSt7x2M2vdEChOnGOAJ+Xx4uIkAeBEkS/rOaZfKZN/0ZHDVX1eIJ1Hxh3y2c7ACykBrzRHMg=
Received: from PH0PR07CA0030.namprd07.prod.outlook.com (2603:10b6:510:5::35)
 by DM4PR12MB8570.namprd12.prod.outlook.com (2603:10b6:8:18b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Wed, 1 Jul
 2026 12:08:10 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:510:5:cafe::94) by PH0PR07CA0030.outlook.office365.com
 (2603:10b6:510:5::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Wed, 1
 Jul 2026 12:08:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 12:08:08 +0000
Received: from stanley-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 07:08:06 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Stanley.Yang <Stanley.Yang@amd.com>
Subject: [PATCH 1/1] drm/amdgpu/ras: only check bad page for address-based UMC
 injection
Date: Wed, 1 Jul 2026 20:07:52 +0800
Message-ID: <20260701120752.289190-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|DM4PR12MB8570:EE_
X-MS-Office365-Filtering-Correlation-Id: 947394ec-e676-4505-e091-08ded7696a0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|6133799003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: srNmmM/gzdsGudXJ89lJAPRY8sSqqxMWGyJGl846/RUM31j1p10EUTJTecAeRTqAf2wOaGhiry7DX9+2wv5M0LTjw40x59u1hy5+URRpANmFen53QGYiUBCY7PoFOWPKOlhe/D6x4XPy0ErT3MoILv7DNhA/IwEDB+9vtu0au7ydJvRzCRjkLlz8/IrAmSC69beoJL/U9SnUyGgHsQ7nA47xiNqnZBwAWXVoveem+ka8rKIuaFWH0w63+Li0/S/P0UsTsGKSfsl8/wq4BGQvFbB7Pi4p852PFmgs6ToF1SKGEjpxbFZs8h77yooLL8QSaF2B5lng0Sf+ZXs6Mfa8ptuKyT3Dq8mMlE8aC+BdzOYm2mzrj66Io7HeU4eN+XOWwj/B2Ipc0lXUqY+SX9EwTZXx3zSjk/9AKcR+dy5h1lJO9x37su4Br2Htl7oenet7BVAHMTvjV/zpsEJrLQ9nlnODfRZvECLDieoW8bIMqzg4285WbOvzD4fep/RLmmQ1nfBJxRx2apTWql+j7sVES/zrTeK4+OjqlY6M2TpwvvEJpy1eW6KDwYXgSmF2qCp7Sfj65kekW4mImhL5yD5YRxn3wzttvSbFP7i0mcO4Fw8S9o9hpJtnAgjfVff6V8dVniIg0LdBtnn7pYq5Kw3mbLzUghtnBJ2a4r012jWRtYAG75wkNELn2UTyJlMcR0JvcefY66RE7sPOeS7AmV9EHA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(6133799003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0sq7DAPwyE9UXTYDufnCNOFrDb7Hs1VRvREQGh0lA5uUpc5MkWSmmKAbealcbN8chsCSGv88CKXMafrMcbWV8e3HirOvXo46FxuOqV3vOmLQq+xCPwxrXo06m0b9VgP1Stu65Xlrk+GsL6RaXgUn7LG3wk8h3NlbUuXHRplV3D52Ju/EG1W8HWqbz8vLzFeIKfLNuO2IhUUS5w6xZpiJtudI+s5znFn0gxkk7ut7rLl3KYIUvr5qZdQiCQfHWKZPJ6pRzllU7obJW/ZjCeZiBRVwuiAF9vunHZOd0VDmY418jDPddays0ErVK2VpGwtvS1yZ/SfPp6JoVWAh4W9JS8epRZ2H6M6nCiNyjFDTU4w6CHynpre8LtGHVfSYj59m7taGZsy43REXeXvQAVV6JbiqOFXWnxhxYt47RzS4vSb2pgCZWQGJVA/laVXuf3MZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 12:08:08.3240 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 947394ec-e676-4505-e091-08ded7696a0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8570
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

UMC error injection on MI300 series is dispatched by the RAS TA via
the (sub-block, method) pair; only the "coherent" methods are address
based, the single-shot/persistent/ac-parity ones ignore the address.

The debugfs control path validated the injection address against the
bad page list for every UMC injection. Restrict that check to
address-based injections and warn when a non address-based one is
given a non-zero address. Other ASICs keep injecting by address.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 94 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  3 +
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c  |  3 +-
 3 files changed, 97 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index af48dd2ebd16..c563e2d96809 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -485,6 +485,91 @@ static void amdgpu_ras_instance_mask_check(struct amdgpu_device *adev,
 			inst_mask, data->inject.instance_mask);
 }
 
+/*
+ * UMC error injection on MI300-class ASICs is dispatched by the RAS TA using
+ * the (sub-block, method) pair passed in struct ta_ras_trigger_error_input as
+ * sub_block_index (enum error_sub_block_umc) and value (enum inject_method_umc).
+ * Only the "coherent" methods program an explicit injection address.
+ *
+ * Keep the values below in sync with the RAS TA.
+ */
+enum umc_error_sub_block {
+	UMC_ERROR_CRC			= 0,
+	UMC_ERROR_SRAM			= 1,
+	UMC_ERROR_ODECC			= 2,
+	UMC_ERROR_PARITY_DATA		= 3,
+	UMC_ERROR_PARITY_CMD		= 4,
+};
+
+enum umc_inject_method {
+	UMC_METH_COHERENT		= 0,
+	UMC_METH_SINGLE_SHOT		= 1,
+	UMC_METH_PERSISTENT		= 2,
+	UMC_METH_PERSISTENT_DISABLE	= 3,
+	UMC_METH_COHERENT_NO_DETECTION	= 4,
+	UMC_METH_COHERENT_WR		= 5,
+	UMC_METH_SINGLE_SHOT_WR		= 6,
+	UMC_METH_PERSISTENT_WR		= 7,
+	UMC_METH_SINGLE_SHOT_CLEAN	= 8,
+};
+
+/*
+ * Return true if a UMC error injection using @sub_block (enum error_sub_block_umc)
+ * and @method (enum inject_method_umc) is address-based, i.e. it programs an
+ * explicit injection address. On MI300 series the non address-based methods
+ * ignore the address; other ASICs always inject by the given address, so return
+ * true there to keep validating it.
+ */
+bool amdgpu_ras_umc_is_address_based(struct amdgpu_device *adev,
+				     u32 sub_block, u64 method)
+{
+	/*
+	 * The (sub-block, method) classification below follows the MI300 RAS
+	 * TA injection ABI and does not apply to other ASICs.
+	 */
+	switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
+	case IP_VERSION(13, 0, 6):
+	case IP_VERSION(13, 0, 12):
+	case IP_VERSION(13, 0, 14):
+		break;
+	default:
+		return true;
+	}
+
+	switch (sub_block) {
+	case UMC_ERROR_CRC:
+		return method == UMC_METH_COHERENT ||
+		       method == UMC_METH_COHERENT_NO_DETECTION ||
+		       method == UMC_METH_COHERENT_WR;
+	case UMC_ERROR_ODECC:
+		return method == UMC_METH_COHERENT;
+	case UMC_ERROR_PARITY_DATA:
+		return method == UMC_METH_COHERENT ||
+		       method == UMC_METH_COHERENT_WR;
+	default:
+		return false;
+	}
+}
+
+/*
+ * Wrapper for the legacy debugfs inject path: classify @data and warn when a
+ * non address-based injection was given a non-zero address (which is ignored).
+ */
+static bool amdgpu_ras_umc_inject_is_address_based(struct amdgpu_device *adev,
+						   struct ras_debug_if *data)
+{
+	bool address_based = amdgpu_ras_umc_is_address_based(adev,
+					data->head.sub_block_index,
+					data->inject.value);
+
+	if (!address_based && data->inject.address)
+		dev_warn(adev->dev,
+			 "RAS WARN: non address based injection, ignore the injection address 0x%llx\n",
+			 data->inject.address);
+
+	return address_based;
+}
+
 /**
  * DOC: AMDGPU RAS debugfs control interface
  *
@@ -606,8 +691,13 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct file *f,
 		ret = amdgpu_ras_feature_enable(adev, &data.head, 1);
 		break;
 	case 2:
-		/* umc ce/ue error injection for a bad page is not allowed */
-		if (data.head.block == AMDGPU_RAS_BLOCK__UMC)
+		/*
+		 * UMC ce/ue error injection for a bad page is not allowed, but
+		 * only address-based injections actually use the address, so
+		 * limit the bad page check to those.
+		 */
+		if (data.head.block == AMDGPU_RAS_BLOCK__UMC &&
+		    amdgpu_ras_umc_inject_is_address_based(adev, &data))
 			ret = amdgpu_ras_check_bad_page(adev, data.inject.address);
 		if (ret == -EINVAL) {
 			dev_warn(adev->dev, "RAS WARN: input address 0x%llx is invalid.",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index ad24c7cf8936..69a1600ad1a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -917,6 +917,9 @@ int amdgpu_ras_reset_error_status(struct amdgpu_device *adev,
 int amdgpu_ras_error_inject(struct amdgpu_device *adev,
 		struct ras_inject_if *info);
 
+bool amdgpu_ras_umc_is_address_based(struct amdgpu_device *adev,
+		u32 sub_block, u64 method);
+
 int amdgpu_ras_interrupt_add_handler(struct amdgpu_device *adev,
 		struct ras_common_if *head);
 
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
index bfbfdffbfbe6..31486ceecc72 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
@@ -90,7 +90,8 @@ static int amdgpu_ras_inject_error(struct ras_core_context *ras_core,
 		(struct ras_cmd_inject_error_req *)cmd->input_buff_raw;
 	int ret = RAS_CMD__ERROR_GENERIC;
 
-	if (req->block_id == RAS_BLOCK_ID__UMC) {
+	if (req->block_id == RAS_BLOCK_ID__UMC &&
+		amdgpu_ras_umc_is_address_based(adev, req->subblock_id, req->method)) {
 		if (amdgpu_ras_mgr_check_retired_addr(adev, req->address)) {
 			RAS_DEV_WARN(ras_core->dev,
 				"RAS WARN: inject: 0x%llx has already been marked as bad!\n",
-- 
2.43.0

