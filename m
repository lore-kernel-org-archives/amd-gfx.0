Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB3A4CD98F6
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 04:42:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 651C810E46F;
	Mon, 22 Jun 2026 04:42:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1DInHBOD";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010020.outbound.protection.outlook.com [52.101.46.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B16FC10E477
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 04:42:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ry1P57hfo68Zud0sCT6VsWifC/82B3P0l5LssM+b3q4Tgl8b+PMbNOOc/nPzxj5kV5yTc61sG+qUzY+7weu9NR1+GuuDDzL6e9yf/d1YCHXrBAuMS+WRoz3RZcfCSqreMVIxLRKDTO0IWquwor+8JvUlkkQlOPLJBAWNlc6RqW/kG8rUrpghNw6Jurz4hf8bcxBqr7mjSQ+0o/hpXfeDJHzFaWq1Lfkv0353rh12cKKialJFHvY3djpD2kpj52abx6NdYatqJsUromaM9XNaE3vaPn8OZCRxvC+j1oLAErk6xXPQUxFaD5X7dg8IqbqJNavGkP0cY/JlnUB/xsDKaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1K1KueljFzEVfyFwMn7yUG382W3gyNDloVnle/IfqRs=;
 b=bG2Rnwzs4b/zmeWXCYsrSEM0XFL6ovQi8THAiSQjfBDkeULToLWOdKx7+txWwiX1Ai5W583WqU92XmgXbdh6aWVZXWVMHgD5BWlkEMNb5xLrDKUqJ5HdkSxZ84yrJFbD8r0+Owgwrn7XL3pDBOR3HM3/+Ol022L5O4FVoIYRGdJaowB/tkW041REtyw41sQ7vNTL4gl596g33hSilcutVv9DnmBAD8f8bIfNQva2XnYmj2XXAjErkFSil8ED9Jnt9KJET5KsX7bLA0gCFHw/OSBwwr0tXmTni0lm4fXXuYC8rSxJUfs5LtOMzSYrpy7lp5BvIFVsWlwGtV6Z1/UJyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1K1KueljFzEVfyFwMn7yUG382W3gyNDloVnle/IfqRs=;
 b=1DInHBOD9oUOFsf0wook6ze7wJdHwCEDcmrKnFx7XLuOibpFhnxZSfzVyFf6T0gOOtre/HUeY74rdoB2BBMxhjr61sq5L4ZftXOhbUnwMm5KcRah1ukiicylqiKP1CxDjQtmKafwxE5qQeGWZi61mv01fFbtc3wGIOFK4RTT0ms=
Received: from BL1PR13CA0404.namprd13.prod.outlook.com (2603:10b6:208:2c2::19)
 by DM4PR12MB5748.namprd12.prod.outlook.com (2603:10b6:8:5f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 04:42:46 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:2c2:cafe::6b) by BL1PR13CA0404.outlook.office365.com
 (2603:10b6:208:2c2::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.11 via Frontend Transport; Mon,
 22 Jun 2026 04:42:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 04:42:45 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 21 Jun
 2026 23:42:44 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>, "Ce
 Sun" <cesun102@amd.com>
Subject: [PATCH v1 23/48] drm/amdgpu: retire legacy RAS reset/query operations
 for vcn v4.0.3
Date: Mon, 22 Jun 2026 12:40:12 +0800
Message-ID: <a87dd6840b34711482f06c1fdce6f830e59be9c7.1782103074.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1782103073.git.cesun102@amd.com>
References: <cover.1782103073.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|DM4PR12MB5748:EE_
X-MS-Office365-Filtering-Correlation-Id: e8a87856-1c3f-4045-1cb3-08ded018b479
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: jngi/5kFvE4jLs9ko/nbVgV5REh2El8OjKOm40eKK/LM4QFZYq9u9VAAXzFNxR681iPHOXUXtDzL305saqWVvvd30FBVxPUATknZrKluJPf51Qoej0bwGAfdOjA5lbO+Y8V5C/EvlFYBlOhBo1c+l0srTp77f543eMlJ5MOoszkCkv7VOhsV8K95Q8AltsuBOuGPytZqEKMrSfO0wHQ2G0xrE6X3ZbCgbP5hqY2GJilwMK+ZVPm7osDBhG2/vwZwO0rwWMozSC550J4/1W8v1UCpR6M8AyAkdA7+uI+99B30L+5O4S4DRDUSsNSZ4/pp6a9lVVLInLh9AqUx40IJIAUlefCVMwi3yqd7TROjJVSdvMRXFoHH2C1CjJe4ZQKCQBJQfnnGjMHC/d58ytzEsTW2XCVGYDOfHN8MhGCYOioQbVpe28RD8M1mbmFwQEkcYOtzVpU8AA/T06YzvEz4foROSmfLS+V9tQ7DZVqcNK2hopYj+LPVd88zBty7fXrW40kxJHno4sLFsC3FIAAUjiY8rOIR9qfUfQfmO/jQvtRVlXPncXbmRzFdVDIWrGm+KjIgLUiYVRK457Jj5b0pe4fupOw6jv0fBou28oiYJdaScxl2hGgUJ2P3cxH+sWPRmU4gPX3K86R4QGf6j/aT+9EH/yGBMx2nprCO2kai7dZmSADTH8Nu//lY90aSzA+hk4r1vUEMWzfsMxEaP6wZkw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /hMqYE2TEMaJfUG10L+UCtJBDaRP6tlG3ayuzLK5F6hY/at/8bzLGCLz9wKia83cAJJDVg83TG5r5OeiBfyCjOZrr57kz8QRn9rlDO8UuHzYEjUnwpprHmLgCtFOobIUKneHW6w2U9jpUIe7sEc6sKcWACFiv7U7Lgh2+dHHXW0ZnpDjrdE9Nem6CUWQHK5NgUA7vo8nQRheXhFGHk697xFu/HhsM/2HTIthc+tlflJ/ynqOl6RwMjrhZ2zTxVvW/pMHYtDQ25uwVYfsnr3zzKbhDPkZfSzIdau0CoMqla3UrBrqZvFlv5KK9Nqjbqt/dVbbIP84TdMSwcSsBPXHInswhBZHsSjVyrUl1CWRGenaXEFuZkyl/wZ6E1bnhgty6wrSihrcEeEZxCU29wJ9MjbOSEoREPSNxpEUjZIPq6ZSm/XCVJpruJv2pgGOohTC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 04:42:45.8395 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a87856-1c3f-4045-1cb3-08ded018b479
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5748
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

retire legacy RAS reset/query operations for vcn v4.0.3

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 60 -------------------------
 1 file changed, 60 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 728946911f00..1733c613deb4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -2065,64 +2065,6 @@ const struct amdgpu_ip_block_version vcn_v4_0_3_ip_block = {
 	.funcs = &vcn_v4_0_3_ip_funcs,
 };
 
-static const struct amdgpu_ras_err_status_reg_entry vcn_v4_0_3_ue_reg_list[] = {
-	{AMDGPU_RAS_REG_ENTRY(VCN, 0, regVCN_UE_ERR_STATUS_LO_VIDD, regVCN_UE_ERR_STATUS_HI_VIDD),
-	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "VIDD"},
-	{AMDGPU_RAS_REG_ENTRY(VCN, 0, regVCN_UE_ERR_STATUS_LO_VIDV, regVCN_UE_ERR_STATUS_HI_VIDV),
-	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "VIDV"},
-};
-
-static void vcn_v4_0_3_inst_query_ras_error_count(struct amdgpu_device *adev,
-						  uint32_t vcn_inst,
-						  void *ras_err_status)
-{
-	struct ras_err_data *err_data = (struct ras_err_data *)ras_err_status;
-
-	/* vcn v4_0_3 only support query uncorrectable errors */
-	amdgpu_ras_inst_query_ras_error_count(adev,
-			vcn_v4_0_3_ue_reg_list,
-			ARRAY_SIZE(vcn_v4_0_3_ue_reg_list),
-			NULL, 0, GET_INST(VCN, vcn_inst),
-			AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE,
-			&err_data->ue_count);
-}
-
-static void vcn_v4_0_3_query_ras_error_count(struct amdgpu_device *adev,
-					     void *ras_err_status)
-{
-	uint32_t i;
-
-	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN)) {
-		dev_warn(adev->dev, "VCN RAS is not supported\n");
-		return;
-	}
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
-		vcn_v4_0_3_inst_query_ras_error_count(adev, i, ras_err_status);
-}
-
-static void vcn_v4_0_3_inst_reset_ras_error_count(struct amdgpu_device *adev,
-						  uint32_t vcn_inst)
-{
-	amdgpu_ras_inst_reset_ras_error_count(adev,
-					vcn_v4_0_3_ue_reg_list,
-					ARRAY_SIZE(vcn_v4_0_3_ue_reg_list),
-					GET_INST(VCN, vcn_inst));
-}
-
-static void vcn_v4_0_3_reset_ras_error_count(struct amdgpu_device *adev)
-{
-	uint32_t i;
-
-	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN)) {
-		dev_warn(adev->dev, "VCN RAS is not supported\n");
-		return;
-	}
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
-		vcn_v4_0_3_inst_reset_ras_error_count(adev, i);
-}
-
 static uint32_t vcn_v4_0_3_query_poison_by_instance(struct amdgpu_device *adev,
 			uint32_t instance, uint32_t sub_block)
 {
@@ -2158,8 +2100,6 @@ static bool vcn_v4_0_3_query_poison_status(struct amdgpu_device *adev)
 }
 
 static const struct amdgpu_ras_block_hw_ops vcn_v4_0_3_ras_hw_ops = {
-	.query_ras_error_count = vcn_v4_0_3_query_ras_error_count,
-	.reset_ras_error_count = vcn_v4_0_3_reset_ras_error_count,
 	.query_poison_status = vcn_v4_0_3_query_poison_status,
 };
 
-- 
2.34.1

