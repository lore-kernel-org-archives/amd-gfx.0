Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A92F1CDB466
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 08:46:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 464E710E567;
	Mon, 22 Jun 2026 08:46:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0iXrOiFk";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011030.outbound.protection.outlook.com [52.101.57.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27E6410E567
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 08:46:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q5BIA16XQq98+pYsQf6WhqCuzZTCz4y9SPI+ygg9fdkGsCHEdFqeDhgSpFSkZev5lNfSs/XEzeJeXy4XTVDM+lLIi6+PkJc/EDblUeycQrlOxKNZNJIhoFm/inINV2X/X/pq7lQaD0VTfi6h4Z2HK/SMIoAlAPa25+9+GU/83bNKe2BzFbq92Z/R6POHZF7N+uqyK+e+GEzN3VksZfnFEEuwNoTVVDqEDBuuOeSaMuViIxwVwf6ODDLzXJmfCskLyG6JZZW48h/c5aBYN6bkSlTVYZ1JRI0CwJQrFb6DaoN31N62ppN50ka423dwShXMkRSTDbr8d8wFl69dLp574g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FjVlr5U5jnvucmTqwtasVvgMZApSwA0qstmCeJvG5I=;
 b=YwcLlciGzJTRc49E1kP2RzARKItGds1PsvyQcSscy2n/CSTjxLAB8VQEcQ26imVcBquJ6i1wQK0WapEfGYyj/f5lA/Pa+JaA+bikWVIMUZSN4dpdSjPpsv2Mf7y3BDaA9o40cK6DOdGgrGE8iNInfrcAzB9rHjC/D4nIjzlDNj9yfMYfluZzdG8EegVqd379IG6t4GljxfFM6sbtxvCb4XErEbOp9IsnfWmks40c6ui17rRC3/uGk1p4cclcV4xLVLP6cknqmcV6CGvPCiUUNdOuKwvmmlCdgF4Fo7gQ6H08+NWy+2nvxzGJzgyETj/yvXrB9iHocbIWUBRv4rQgFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FjVlr5U5jnvucmTqwtasVvgMZApSwA0qstmCeJvG5I=;
 b=0iXrOiFkIVmG3x6Qh9RhiAWTIj93Vp3PXAvdmzm67JRf618uZJobWRMhzA52K8SIj/xY8EaU5CV4YcqdKJDuAdZtqCIqyZgy0jRfYqv3gbzP8tI1aT2ep0gLAOHiDXfDeWgt4iTUBymwE3p7OQTa02R/z4T9M1gDHsP5VIcZDj8=
Received: from PH8P223CA0001.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::32)
 by DS0PR12MB7512.namprd12.prod.outlook.com (2603:10b6:8:13a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 08:46:07 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:510:2db:cafe::2) by PH8P223CA0001.outlook.office365.com
 (2603:10b6:510:2db::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 08:46:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 08:46:06 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 03:46:04 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v2 29/48] drm/amdgpu: remove operations related to legacy
 address
Date: Mon, 22 Jun 2026 16:44:31 +0800
Message-ID: <1b65dd5d93604af44f5a452271d8b840eb7bb1e5.1782117608.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <594f7cbae0387b60f8af49505b57c1a5a604db2f.1782117608.git.cesun102@amd.com>
References: <594f7cbae0387b60f8af49505b57c1a5a604db2f.1782117608.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|DS0PR12MB7512:EE_
X-MS-Office365-Filtering-Correlation-Id: a3fddd62-21c6-4668-dab8-08ded03ab343
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|11063799006|6133799003|3023799007|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ulDEE1sctnB3WmtwRtTmQ7isW/hlUanPz+l9FDl4/ASN0ix0BzV3WWW5sV+QoI9JTYx8bGeAuP5NmA280Hz2RIy+nMjOPnp0NO4ywupSMTAbFIuj1J6+4W3ypBx76EIT7f5IfZrqJCJsqX8ZC3Vcp+Zr+9I3pdLSEskxXN8IysUiZoNaWmF0AKRIdcZcjA6G2XrLGo4q7lrC690R2Ai6jgDPO44llo1rJRFGjkQvGBkNzErIbI3KEDX4HzLlf2U578n7o09AEXGdLMoC02UHdMJ6xHts2wKnfGeYhaXtxI5kn+ndpsdVBSRh/nV1pHWeWVmngdwMLvw9smmyfmln1eIAeZ1Hl9UISA5lOSFnVTLOGyeVjJHCfa5CTX1emP7OzqY8S4vsfAVj5736oO3d2SUtPm3GXji/ndDYTqBrG5LQCI8YWUGp4lI58gAUZhzNpYkY3spQlfSRBkoDIF43j3AbVX9Biw0XgK7pXMgDs02P3CbA7cWXnFhUE8nnPycBkdU4TBnH+cIQ9XCmdrAJpHZcK8IZRKwZFQJM0IAQNszIEq/czD+FQfeQ4mW+RhGUaBXyqgIxFKHAJpKv7KAe6EajeuGtvhI3grpwfCw0Bvh06VzdtQyfHsEMsQ8aGqN5ycd0nIvVhOspq4Lt/loN1Jv+7CxxSm5TreoCEG3RhEF1lJXia0a7TwZJ8UnfKZs9xoSDMBs+u2cXxeoezvd8xg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(11063799006)(6133799003)(3023799007)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3aHA7DaSAD+RL+2ErCCRI/rWaaePirfVcmiJNm4Q7Y9WLCIKNDo0e2dK4uHV+7hvyyN7Zu6cH7JR4bggVJmzbmvMxC2SOdbYj1hjLrrrVrIzdhf/v5FkLtTmJbRTmT5RctSaNETEYyRDlKrnh5zB52LNxp0XhKETJlHWxQpoKxzy5tZjM5UdV+tymzzXgpMVVQ3DL7kdaGTdEs2k/bJoh1tg26FfhyH7RzEzdGfQciO5hbPwgrkevfuRZdducRy+qDQYhYFL5XChu6IXeSSenZKx4D6G7wldEIMlfsQ/+QtXl6UeBLp9bj+6mKl1XrXivYYSbLlbmjvjsUu8QPT6wqNaXuRI7KUuIgBWn1ETpjJ7qFZ4GtPYE3yioZ3nO1+W+Nya5ieA+pwwg6w5JTfX+7kTgq6s+uzqtRnGcfLjqn+E+QP57b9XyUlXDFxQyKGj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:46:06.6565 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3fddd62-21c6-4668-dab8-08ded03ab343
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7512
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

Remove operations related to legacy address conversion

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 248 +-----------------
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       |  40 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h       |  13 -
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c        |  26 --
 5 files changed, 12 insertions(+), 321 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index e7156b85e727..69fca6aacdc7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2882,77 +2882,6 @@ static int amdgpu_ras_realloc_eh_data_space(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int amdgpu_ras_mca2pa_by_idx(struct amdgpu_device *adev,
-			struct eeprom_table_record *bps,
-			struct ras_err_data *err_data)
-{
-	struct ta_ras_query_address_input addr_in;
-	uint32_t socket = 0;
-	int ret = 0;
-
-	if (adev->smuio.funcs && adev->smuio.funcs->get_socket_id)
-		socket = adev->smuio.funcs->get_socket_id(adev);
-
-	/* reinit err_data */
-	err_data->err_addr_cnt = 0;
-	err_data->err_addr_len = adev->umc.retire_unit;
-
-	memset(&addr_in, 0, sizeof(addr_in));
-	addr_in.ma.err_addr = bps->address;
-	addr_in.ma.socket_id = socket;
-	addr_in.ma.ch_inst = bps->mem_channel;
-	if (!amdgpu_ras_smu_eeprom_supported(adev)) {
-		/* tell RAS TA the node instance is not used */
-		addr_in.ma.node_inst = TA_RAS_INV_NODE;
-	} else {
-		addr_in.ma.umc_inst = bps->mcumc_id;
-		addr_in.ma.node_inst = bps->cu;
-	}
-
-	if (adev->umc.ras && adev->umc.ras->convert_ras_err_addr)
-		ret = adev->umc.ras->convert_ras_err_addr(adev, err_data,
-				&addr_in, NULL, false);
-
-	return ret;
-}
-
-static int amdgpu_ras_mca2pa(struct amdgpu_device *adev,
-			struct eeprom_table_record *bps,
-			struct ras_err_data *err_data)
-{
-	struct ta_ras_query_address_input addr_in;
-	uint32_t die_id, socket = 0;
-
-	if (adev->smuio.funcs && adev->smuio.funcs->get_socket_id)
-		socket = adev->smuio.funcs->get_socket_id(adev);
-
-	/* although die id is gotten from PA in nps1 mode, the id is
-	 * fitable for any nps mode
-	 */
-	if (adev->umc.ras && adev->umc.ras->get_die_id_from_pa)
-		die_id = adev->umc.ras->get_die_id_from_pa(adev, bps->address,
-					bps->retired_page << AMDGPU_GPU_PAGE_SHIFT);
-	else
-		return -EINVAL;
-
-	/* reinit err_data */
-	err_data->err_addr_cnt = 0;
-	err_data->err_addr_len = adev->umc.retire_unit;
-
-	memset(&addr_in, 0, sizeof(addr_in));
-	addr_in.ma.err_addr = bps->address;
-	addr_in.ma.ch_inst = bps->mem_channel;
-	addr_in.ma.umc_inst = bps->mcumc_id;
-	addr_in.ma.node_inst = die_id;
-	addr_in.ma.socket_id = socket;
-
-	if (adev->umc.ras && adev->umc.ras->convert_ras_err_addr)
-		return adev->umc.ras->convert_ras_err_addr(adev, err_data,
-					&addr_in, NULL, false);
-	else
-		return  -EINVAL;
-}
-
 static bool __check_record_in_range(struct amdgpu_device *adev,
 			struct eeprom_table_record *bps, int count)
 {
@@ -3013,117 +2942,13 @@ static int __amdgpu_ras_convert_rec_array_from_rom(struct amdgpu_device *adev,
 				struct eeprom_table_record *bps, struct ras_err_data *err_data,
 				enum amdgpu_memory_partition nps)
 {
-	int i = 0;
-	uint64_t chan_idx_v2;
-	enum amdgpu_memory_partition save_nps;
-
-	save_nps = (bps[0].retired_page >> UMC_NPS_SHIFT) & UMC_NPS_MASK;
-	chan_idx_v2 = bps[0].retired_page & UMC_CHANNEL_IDX_V2;
-
 	/*old asics just have pa in eeprom*/
-	if (IP_VERSION_MAJ(amdgpu_ip_version(adev, UMC_HWIP, 0)) < 12) {
-		memcpy(err_data->err_addr, bps,
-			sizeof(struct eeprom_table_record) * adev->umc.retire_unit);
-		goto out;
-	}
-
-	for (i = 0; i < adev->umc.retire_unit; i++)
-		bps[i].retired_page &= ~(UMC_NPS_MASK << UMC_NPS_SHIFT);
-
-	if (save_nps || chan_idx_v2) {
-		if (save_nps == nps) {
-			if (amdgpu_umc_pages_in_a_row(adev, err_data,
-					bps[0].retired_page << AMDGPU_GPU_PAGE_SHIFT))
-				return -EINVAL;
-			for (i = 0; i < adev->umc.retire_unit; i++) {
-				err_data->err_addr[i].address = bps[0].address;
-				err_data->err_addr[i].mem_channel = bps[0].mem_channel;
-				err_data->err_addr[i].bank = bps[0].bank;
-				err_data->err_addr[i].err_type = bps[0].err_type;
-				err_data->err_addr[i].mcumc_id = bps[0].mcumc_id;
-			}
-		} else {
-			if (amdgpu_ras_mca2pa_by_idx(adev, &bps[0], err_data))
-				return -EINVAL;
-		}
-	} else {
-		if (bps[0].address == 0) {
-			/* for specific old eeprom data, mca address is not stored,
-			 * calc it from pa
-			 */
-			if (amdgpu_umc_pa2mca(adev, bps[0].retired_page << AMDGPU_GPU_PAGE_SHIFT,
-				&(bps[0].address), AMDGPU_NPS1_PARTITION_MODE))
-				return -EINVAL;
-		}
+	memcpy(err_data->err_addr, bps,
+		sizeof(struct eeprom_table_record) * adev->umc.retire_unit);
 
-		if (amdgpu_ras_mca2pa(adev, &bps[0], err_data)) {
-			if (nps == AMDGPU_NPS1_PARTITION_MODE)
-				memcpy(err_data->err_addr, bps,
-					sizeof(struct eeprom_table_record) * adev->umc.retire_unit);
-			else
-				return -EOPNOTSUPP;
-		}
-	}
-
-out:
 	return __amdgpu_ras_restore_bad_pages(adev, err_data->err_addr, adev->umc.retire_unit);
 }
 
-static int __amdgpu_ras_convert_rec_from_rom(struct amdgpu_device *adev,
-				struct eeprom_table_record *bps, struct ras_err_data *err_data,
-				enum amdgpu_memory_partition nps)
-{
-	int i = 0;
-	uint64_t chan_idx_v2;
-	enum amdgpu_memory_partition save_nps;
-
-	if (!amdgpu_ras_smu_eeprom_supported(adev)) {
-		save_nps = (bps->retired_page >> UMC_NPS_SHIFT) & UMC_NPS_MASK;
-		chan_idx_v2 = bps->retired_page & UMC_CHANNEL_IDX_V2;
-		bps->retired_page &= ~(UMC_NPS_MASK << UMC_NPS_SHIFT);
-	} else {
-		/* if pmfw manages eeprom, save_nps is not stored on eeprom,
-		 * we should always convert mca address into physical address,
-		 * make save_nps different from nps
-		 */
-		save_nps = nps + 1;
-	}
-
-	if (save_nps == nps) {
-		if (amdgpu_umc_pages_in_a_row(adev, err_data,
-				bps->retired_page << AMDGPU_GPU_PAGE_SHIFT))
-			return -EINVAL;
-		for (i = 0; i < adev->umc.retire_unit; i++) {
-			err_data->err_addr[i].address = bps->address;
-			err_data->err_addr[i].mem_channel = bps->mem_channel;
-			err_data->err_addr[i].bank = bps->bank;
-			err_data->err_addr[i].err_type = bps->err_type;
-			err_data->err_addr[i].mcumc_id = bps->mcumc_id;
-		}
-	} else {
-		if (save_nps || chan_idx_v2) {
-			if (amdgpu_ras_mca2pa_by_idx(adev, bps, err_data))
-				return -EINVAL;
-		} else {
-			/* for specific old eeprom data, mca address is not stored,
-			 * calc it from pa
-			 */
-			if (bps->address == 0)
-				if (amdgpu_umc_pa2mca(adev,
-					bps->retired_page << AMDGPU_GPU_PAGE_SHIFT,
-					&(bps->address),
-					AMDGPU_NPS1_PARTITION_MODE))
-					return -EINVAL;
-
-			if (amdgpu_ras_mca2pa(adev, bps, err_data))
-				return -EOPNOTSUPP;
-		}
-	}
-
-	return __amdgpu_ras_restore_bad_pages(adev, err_data->err_addr,
-									adev->umc.retire_unit);
-}
-
 /* it deal with vram only. */
 int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 		struct eeprom_table_record *bps, int pages, bool from_rom)
@@ -3156,8 +2981,7 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 
 	if (from_rom) {
 		/* there is no pa recs in V3, so skip pa recs processing */
-		if ((control->tbl_hdr.version < RAS_TABLE_VER_V3) &&
-		    !amdgpu_ras_smu_eeprom_supported(adev)) {
+		if (control->tbl_hdr.version < RAS_TABLE_VER_V3) {
 			for (i = 0; i < pages; i++) {
 				if (control->ras_num_recs - i >= adev->umc.retire_unit) {
 					if ((bps[i].address == bps[i + 1].address) &&
@@ -3174,10 +2998,8 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 				}
 			}
 		}
-		for (; i < pages; i++) {
-			ret = __amdgpu_ras_convert_rec_from_rom(adev,
-				&bps[i], &err_data, nps);
-		}
+		for (; i < pages; i++)
+			bps[i].retired_page &= ~(UMC_NPS_MASK << UMC_NPS_SHIFT);
 
 		con->eh_data->count_saved = con->eh_data->count;
 	} else {
@@ -3202,7 +3024,7 @@ int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev,
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_err_handler_data *data;
 	struct amdgpu_ras_eeprom_control *control;
-	int save_count, unit_num, i;
+	int save_count, unit_num;
 
 	if (!con || !con->eh_data) {
 		if (new_cnt)
@@ -3239,21 +3061,10 @@ int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev,
 	/* only new entries are saved */
 	if (unit_num && save_count) {
 		/*old asics only save pa to eeprom like before*/
-		if (IP_VERSION_MAJ(amdgpu_ip_version(adev, UMC_HWIP, 0)) < 12) {
-			if (amdgpu_ras_eeprom_append(control,
-					&data->bps[data->count_saved], unit_num)) {
-				dev_err(adev->dev, "Failed to save EEPROM table data!");
-				return -EIO;
-			}
-		} else {
-			for (i = 0; i < unit_num; i++) {
-				if (amdgpu_ras_eeprom_append(control,
-						&data->bps[data->count_saved +
-						i * adev->umc.retire_unit], 1)) {
-					dev_err(adev->dev, "Failed to save EEPROM table data!");
-					return -EIO;
-				}
-			}
+		if (amdgpu_ras_eeprom_append(control,
+				&data->bps[data->count_saved], unit_num)) {
+			dev_err(adev->dev, "Failed to save EEPROM table data!");
+			return -EIO;
 		}
 
 		dev_info(adev->dev, "Saved %d pages to EEPROM table.\n", save_count);
@@ -3272,7 +3083,7 @@ static int amdgpu_ras_load_bad_pages(struct amdgpu_device *adev)
 	struct amdgpu_ras_eeprom_control *control =
 		&adev->psp.ras_context.ras->eeprom_control;
 	struct eeprom_table_record *bps;
-	int ret, i = 0;
+	int ret;
 
 	/* no bad page record, skip eeprom access */
 	if (control->ras_num_recs == 0 || amdgpu_bad_page_threshold == 0)
@@ -3286,33 +3097,6 @@ static int amdgpu_ras_load_bad_pages(struct amdgpu_device *adev)
 	if (ret) {
 		dev_err(adev->dev, "Failed to load EEPROM table records!");
 	} else {
-		if (adev->umc.ras && adev->umc.ras->convert_ras_err_addr) {
-			/*In V3, there is no pa recs, and some cases(when address==0) may be parsed
-			as pa recs, so add verion check to avoid it.
-			*/
-			if ((control->tbl_hdr.version < RAS_TABLE_VER_V3) &&
-			    !amdgpu_ras_smu_eeprom_supported(adev)) {
-				for (i = 0; i < control->ras_num_recs; i++) {
-					if ((control->ras_num_recs - i) >= adev->umc.retire_unit) {
-						if ((bps[i].address == bps[i + 1].address) &&
-							(bps[i].mem_channel == bps[i + 1].mem_channel)) {
-							control->ras_num_pa_recs += adev->umc.retire_unit;
-							i += (adev->umc.retire_unit - 1);
-						} else {
-							control->ras_num_mca_recs +=
-										(control->ras_num_recs - i);
-							break;
-						}
-					} else {
-						control->ras_num_mca_recs += (control->ras_num_recs - i);
-						break;
-					}
-				}
-			} else {
-				control->ras_num_mca_recs = control->ras_num_recs;
-			}
-		}
-
 		ret = amdgpu_ras_add_bad_pages(adev, bps, control->ras_num_recs, true);
 		if (ret)
 			goto out;
@@ -3424,9 +3208,6 @@ int amdgpu_ras_init_badpage_info(struct amdgpu_device *adev)
 	ret = amdgpu_ras_eeprom_init(control);
 	control->is_eeprom_valid = !ret;
 
-	if (!adev->umc.ras || !adev->umc.ras->convert_ras_err_addr)
-		control->ras_num_pa_recs = control->ras_num_recs;
-
 	if (adev->umc.ras &&
 	    adev->umc.ras->get_retire_flip_bits)
 		adev->umc.ras->get_retire_flip_bits(adev);
@@ -3446,13 +3227,6 @@ int amdgpu_ras_init_badpage_info(struct amdgpu_device *adev)
 				adev, control->bad_channel_bitmap);
 			con->update_channel_flag = false;
 		}
-
-		/* The format action is only applied to new ASICs */
-		if (IP_VERSION_MAJ(amdgpu_ip_version(adev, UMC_HWIP, 0)) >= 12 &&
-		    control->tbl_hdr.version < RAS_TABLE_VER_V3)
-			if (!amdgpu_ras_eeprom_reset_table(control))
-				if (amdgpu_ras_save_bad_pages(adev, NULL))
-					dev_warn(adev->dev, "Failed to format RAS EEPROM data in V3 version!\n");
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 36f584f05e2f..292d76021644 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -665,7 +665,6 @@ amdgpu_ras_eeprom_append_table(struct amdgpu_ras_eeprom_control *control,
 			       const u32 num)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(to_amdgpu_device(control));
-	struct amdgpu_device *adev = to_amdgpu_device(control);
 	u32 a, b, i;
 	u8 *buf, *pp;
 	int res;
@@ -770,10 +769,7 @@ amdgpu_ras_eeprom_append_table(struct amdgpu_ras_eeprom_control *control,
 		% control->ras_max_record_count;
 
 	/*old asics only save pa to eeprom like before*/
-	if (IP_VERSION_MAJ(amdgpu_ip_version(adev, UMC_HWIP, 0)) < 12)
-		control->ras_num_pa_recs += num;
-	else
-		control->ras_num_mca_recs += num;
+	control->ras_num_pa_recs += num;
 
 	control->ras_num_bad_pages = con->bad_page_num;
 Out:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 516ae7a5cfeb..a99f1bae7a8f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -501,43 +501,3 @@ int amdgpu_umc_loop_channels(struct amdgpu_device *adev,
 
 	return 0;
 }
-
-int amdgpu_umc_pages_in_a_row(struct amdgpu_device *adev,
-			struct ras_err_data *err_data, uint64_t pa_addr)
-{
-	struct ta_ras_query_address_output addr_out;
-
-	/* reinit err_data */
-	err_data->err_addr_cnt = 0;
-	err_data->err_addr_len = adev->umc.retire_unit;
-
-	addr_out.pa.pa = pa_addr;
-	if (adev->umc.ras && adev->umc.ras->convert_ras_err_addr)
-		return adev->umc.ras->convert_ras_err_addr(adev, err_data, NULL,
-				&addr_out, false);
-	else
-		return -EINVAL;
-}
-
-int amdgpu_umc_pa2mca(struct amdgpu_device *adev,
-		uint64_t pa, uint64_t *mca, enum amdgpu_memory_partition nps)
-{
-	struct ta_ras_query_address_input addr_in;
-	struct ta_ras_query_address_output addr_out;
-	int ret;
-
-	/* nps: the pa belongs to */
-	addr_in.pa.pa = pa | ((uint64_t)nps << 58);
-	addr_in.addr_type = TA_RAS_PA_TO_MCA;
-	ret = psp_ras_query_address(&adev->psp, &addr_in, &addr_out);
-	if (ret) {
-		dev_warn(adev->dev, "Failed to query RAS MCA address for 0x%llx",
-			pa);
-
-		return ret;
-	}
-
-	*mca = addr_out.ma.err_addr;
-
-	return 0;
-}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index f65f3e082c64..cdaee4a049c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -103,13 +103,6 @@ struct amdgpu_umc_ras {
 					void *ras_error_status);
 	bool (*check_ecc_err_status)(struct amdgpu_device *adev,
 			enum amdgpu_mca_error_type type, void *ras_error_status);
-	int (*convert_ras_err_addr)(struct amdgpu_device *adev,
-			struct ras_err_data *err_data,
-			struct ta_ras_query_address_input *addr_in,
-			struct ta_ras_query_address_output *addr_out,
-			bool dump_addr);
-	uint32_t (*get_die_id_from_pa)(struct amdgpu_device *adev,
-			uint64_t mca_addr, uint64_t retired_page);
 	void (*get_retire_flip_bits)(struct amdgpu_device *adev);
 	void (*mca_ipid_parse)(struct amdgpu_device *adev, uint64_t ipid,
 			uint32_t *did, uint32_t *ch, uint32_t *umc_inst, uint32_t *sid);
@@ -179,10 +172,4 @@ int amdgpu_umc_loop_channels(struct amdgpu_device *adev,
 
 void amdgpu_umc_handle_bad_pages(struct amdgpu_device *adev,
 			void *ras_error_status);
-int amdgpu_umc_pages_in_a_row(struct amdgpu_device *adev,
-			struct ras_err_data *err_data, uint64_t pa_addr);
-int amdgpu_umc_lookup_bad_pages_in_a_row(struct amdgpu_device *adev,
-			uint64_t pa_addr, uint64_t *pfns, int len);
-int amdgpu_umc_pa2mca(struct amdgpu_device *adev,
-		uint64_t pa, uint64_t *mca, enum amdgpu_memory_partition nps);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 4d6197c0efb1..beb89b0f9f3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -197,31 +197,6 @@ static bool umc_v12_0_check_ecc_err_status(struct amdgpu_device *adev,
 	return false;
 }
 
-static uint32_t umc_v12_0_get_die_id(struct amdgpu_device *adev,
-		uint64_t mca_addr, uint64_t retired_page)
-{
-	uint32_t die = 0;
-
-	/* we only calculate die id for nps1 mode right now */
-	die += ((((retired_page >> 12) & 0x1ULL)^
-	    ((retired_page >> 20) & 0x1ULL) ^
-	    ((retired_page >> 27) & 0x1ULL) ^
-	    ((retired_page >> 34) & 0x1ULL) ^
-	    ((retired_page >> 41) & 0x1ULL)) << 0);
-
-	/* the original PA_C4 and PA_R13 may be cleared in retired_page, so
-	 * get them from mca_addr.
-	 */
-	die += ((((retired_page >> 13) & 0x1ULL) ^
-	    ((mca_addr >> 5) & 0x1ULL) ^
-	    ((retired_page >> 28) & 0x1ULL) ^
-	    ((mca_addr >> 23) & 0x1ULL) ^
-	    ((retired_page >> 42) & 0x1ULL)) << 1);
-	die &= 3;
-
-	return die;
-}
-
 static void umc_v12_0_mca_ipid_parse(struct amdgpu_device *adev, uint64_t ipid,
 		uint32_t *did, uint32_t *ch, uint32_t *umc_inst, uint32_t *sid)
 {
@@ -240,7 +215,6 @@ struct amdgpu_umc_ras umc_v12_0_ras = {
 		.hw_ops = NULL,
 	},
 	.check_ecc_err_status = umc_v12_0_check_ecc_err_status,
-	.get_die_id_from_pa = umc_v12_0_get_die_id,
 	.get_retire_flip_bits = umc_v12_0_get_retire_flip_bits,
 	.mca_ipid_parse = umc_v12_0_mca_ipid_parse,
 };
-- 
2.34.1

