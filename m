Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E322D5E15F
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2024 11:14:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1116E10E26D;
	Fri,  8 Nov 2024 11:14:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5ih3JWA7";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7F5F10E26D
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2024 11:14:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Assn/povku6yziMRS+oamE3leMkDQU+3Y0ZYcc2wuR6PPr0qap9baTJeCQ76IeLOInSefYdTGUFLn80DEeVoWQ/Z733TeyxtBoWXAbw4t303rJcR0PBDrnLjN70wMIUh/wN6BGTV7MNmLtjqCYNK2FoZhUYQXEjyGk685jYt1dTFyjTDhoPWdejZBAjM9WFff6BO7MACPVTT2g1nwe0EeDOY0yndnGZiVLZ7ySM5Sk7Y4WXwLbnMUelIW8b1E3hpWGeNPWrkb0wKwI0mCAtZcjcKGLur4TbePvoUbh81lyjazXcwCpgESvz1BIV4hlU3XkESOFWzIrCOMIOwd2jXDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9Di3nGxw/I+M8D+7JWjXGzlVox9aZEYlzmIzaSPN0E=;
 b=IUwf46VhB0qOoi/6G9XfnsLJ07zYOnuOQpUtF7LQherq3iTa3pqji7dK8W9CqfWbbPccp4Et03pLfSXTUz6dfkMdUy6gUP0Km/qDa5cw8bruJQLdIppSw+YcZ6vaK8GdQ3OTIsjd4/uOixdvureo93uN4IhwudS2M+Um1Q7ZbqgbndnX3KwQBFpmjvvbHa8KX49vJP4nbUpo+7MAYuFEIUh0CIBYVxT0UhmzWOj5MjyNrMD/bdnTAiN6+4SCFFHXBRPuOPbB+sLVSprwboyU8PAUi2/pMu7clzkZSvcQtG75wetCIpY3/dE5GaOAjSRBTyJI9RBz46rHJJNftkqrOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9Di3nGxw/I+M8D+7JWjXGzlVox9aZEYlzmIzaSPN0E=;
 b=5ih3JWA7XYgu8+pXU0y+xZ59DJqxtj8A8H9jWDoeIi5c6cLzb2tECsCBC3mrjHaVzJbwTJDkgZQky7e9IPBlC2rxAZBeXUsohV9EO4wE6WUmFkCAoVpSevtFsFdRPAu6mY2mCCO6+/B/VirEVPpZATL4k9M447LHcoiI3Iiapp8=
Received: from BL1PR13CA0190.namprd13.prod.outlook.com (2603:10b6:208:2be::15)
 by IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Fri, 8 Nov
 2024 11:14:39 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:2be:cafe::17) by BL1PR13CA0190.outlook.office365.com
 (2603:10b6:208:2be::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Fri, 8 Nov 2024 11:14:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Fri, 8 Nov 2024 11:14:39 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 05:14:37 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 06/23] drm/amdgpu: make convert_ras_err_addr visible outside
 UMC block
Date: Fri, 8 Nov 2024 19:14:06 +0800
Message-ID: <20241108111423.60169-6-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108111423.60169-1-tao.zhou1@amd.com>
References: <20241108111423.60169-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|IA1PR12MB9030:EE_
X-MS-Office365-Filtering-Correlation-Id: 551797c7-c146-4f1d-83c9-08dcffe68961
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jziwuJ72mB0qES7XAwqX+KZZt4BLQul0xrVV+1N82oPGwfv4i1UeYapLYnyt?=
 =?us-ascii?Q?ezumJXu7ydK592qPOzCFxQXeBt9PPxmmaFB00kD8Is5GsN7iHvGWdw/grPjQ?=
 =?us-ascii?Q?dUKdO0wfjb4cEZGJwFIJkFtXnzjzwFJlarhVasi/mKzRH23N2Zadyo1V3+55?=
 =?us-ascii?Q?AH+jQnLqjw1+X/VShm2aaoE0lmIrpcRzo+099nKGk4ty1QQgPH2CPmPUNJcb?=
 =?us-ascii?Q?I6I8kjH5saRCPgBXWKnyZyu5RTepTgRbcB3/3lN3ijhsQq5lSLJJ3wBbvbAO?=
 =?us-ascii?Q?uTUz5gaJ+mrI4lRmfBGJzXdiLg8p6cbeRrQNavmdIHd0JGwyc9v/mR9iWQrJ?=
 =?us-ascii?Q?iDP44Wx76kd2FO2Kk9lfUc9nItJPsIc9d1Cn8J5UK+RgC2fttGE27ycufSF5?=
 =?us-ascii?Q?xFrB1P7sSp2q6/5xSXnQx+EPUWF1NcZXRZIh88RRSYMn7NOc1y+43MPN1dxD?=
 =?us-ascii?Q?qVs2+Fzr2+t+1HcD9PoolW7iepExrQp5f0eEk4TpIHtbSeFfiWf7DBk2JgsX?=
 =?us-ascii?Q?mPW5mjRxLuyasXtZV7LZo714gLzFY/Q55QvKYZqGfjDEuDH/vzT8G2jVouC8?=
 =?us-ascii?Q?WlCCOAY3iO7vQXIu0oCurOoZeYgbh6XK7Y0piCaE5YcPhjHjXIeNW1dxwsoG?=
 =?us-ascii?Q?sSIfe9F1SOYW6/9EItvdK57PhUEmu/BYNs1B9dO06QTgcqOpwnt7gJWP9Hc/?=
 =?us-ascii?Q?EhZ2eieDem/DKFHYYyc4txN18HkN8aY3oqsvhOYmy+a7P56rq15dp0bkG9T4?=
 =?us-ascii?Q?V/o8zSKbMdebJpgXk6MB7ffdb0pi0p1/YARUAfGeBkvII5sp7buSbki5PWFb?=
 =?us-ascii?Q?3ajJWN9i+51FwZV97NgxyuHQPciaLGshpPhS1JPI38Een03ByrhKb4vA/dQP?=
 =?us-ascii?Q?YRiLTWTIfbv7k3TU6HvLisiJLKfRoSroxyfN2FMnryQqeqk2x5GBK4CJIBaD?=
 =?us-ascii?Q?cTZHE53sLc77YZHjz7qKxGgoNsWRWWituiSp6in8FHn8sxR7TMeIrPrz+XxW?=
 =?us-ascii?Q?OvHl5ilJRtxQtqHsHOkKu9hQ5OqLUYMBPupi7ds5EZm/o4Ze/GxP+M4K3LXk?=
 =?us-ascii?Q?4y1LoMa+b0tKDE1PqXPCMTXDAyuUUcibgOjMr6gt0n5IKAN9etADuAcjzXKH?=
 =?us-ascii?Q?DNOVEBf8p8aooWKRhXlm/LZQM34rv3t06QHqVemV9z4Z0rk65/rqKFzsZvLk?=
 =?us-ascii?Q?978aGmy2fQeEE2XXqIl+C8XP2rSyfCKTXrmTsmC7kSftUR8AICcjpsi69GXI?=
 =?us-ascii?Q?YUKMiHkJZ2HigPqhwbTY+W4uscZRqsgPZrdzol3a/r6zNf0VEIBFIn/ZZJ6y?=
 =?us-ascii?Q?M0AI/Pu9RhRZeKzUs5hCCUlEYs8o0PcA7juMc8eFO6ANvH9ugUu4i6w9I87H?=
 =?us-ascii?Q?OVzMofK/rnHNpvSV9W4TBxLos1T/8OYpv6G+rQszqVC44PRSow=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 11:14:39.1573 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 551797c7-c146-4f1d-83c9-08dcffe68961
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9030
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

And change some UMC v12 specific functions to common version, so the
code can be shared.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 63 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h | 11 +++++
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  | 62 ++----------------------
 3 files changed, 78 insertions(+), 58 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 9e70a7b3aa64..75ded3904ee7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -445,3 +445,66 @@ int amdgpu_umc_logs_ecc_err(struct amdgpu_device *adev,
 
 	return ret;
 }
+
+int amdgpu_umc_lookup_bad_pages_in_a_row(struct amdgpu_device *adev,
+			uint64_t pa_addr, uint64_t *pfns, int len)
+{
+	uint32_t i, ret = 0, pos = 0;
+	struct ta_ras_query_address_output addr_out;
+	struct ras_err_data err_data;
+
+	err_data.err_addr =
+		kcalloc(adev->umc.max_ras_err_cnt_per_query,
+				sizeof(struct eeprom_table_record), GFP_KERNEL);
+	if(!err_data.err_addr) {
+		dev_warn(adev->dev, "Failed to alloc memory in "
+				"bad page lookup!\n");
+		return 0;
+	}
+
+	addr_out.pa.pa = pa_addr;
+
+	if (adev->umc.ras && adev->umc.ras->convert_ras_err_addr)
+		adev->umc.ras->convert_ras_err_addr(adev, &err_data, NULL,
+				&addr_out, false);
+	else
+		goto out;
+
+	for (i = 0; i < adev->umc.max_ras_err_cnt_per_query; i++) {
+		if (pos >= len)
+			goto out;
+
+		pfns[pos++] = err_data.err_addr[pos].retired_page;
+	}
+	ret = pos;
+
+out:
+	kfree(err_data.err_addr);
+	return ret;
+}
+
+int amdgpu_umc_mca_to_addr(struct amdgpu_device *adev,
+			uint64_t err_addr, uint32_t ch, uint32_t umc,
+			uint32_t node, uint32_t socket,
+			uint64_t *addr, bool dump_addr)
+{
+	struct ta_ras_query_address_input addr_in;
+	struct ta_ras_query_address_output addr_out;
+
+	memset(&addr_in, 0, sizeof(addr_in));
+	addr_in.ma.err_addr = err_addr;
+	addr_in.ma.ch_inst = ch;
+	addr_in.ma.umc_inst = umc;
+	addr_in.ma.node_inst = node;
+	addr_in.ma.socket_id = socket;
+
+	if (adev->umc.ras && adev->umc.ras->convert_ras_err_addr)
+		adev->umc.ras->convert_ras_err_addr(adev, NULL, &addr_in,
+				&addr_out, dump_addr);
+	else
+		return 0;
+
+	*addr = addr_out.pa.pa;
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index ce4179db2a6d..abde7597bda8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -70,6 +70,11 @@ struct amdgpu_umc_ras {
 			enum amdgpu_mca_error_type type, void *ras_error_status);
 	int (*update_ecc_status)(struct amdgpu_device *adev,
 			uint64_t status, uint64_t ipid, uint64_t addr);
+	void (*convert_ras_err_addr)(struct amdgpu_device *adev,
+			struct ras_err_data *err_data,
+			struct ta_ras_query_address_input *addr_in,
+			struct ta_ras_query_address_output *addr_out,
+			bool dump_addr);
 };
 
 struct amdgpu_umc_funcs {
@@ -134,4 +139,10 @@ int amdgpu_umc_logs_ecc_err(struct amdgpu_device *adev,
 
 void amdgpu_umc_handle_bad_pages(struct amdgpu_device *adev,
 			void *ras_error_status);
+int amdgpu_umc_lookup_bad_pages_in_a_row(struct amdgpu_device *adev,
+			uint64_t pa_addr, uint64_t *pfns, int len);
+int amdgpu_umc_mca_to_addr(struct amdgpu_device *adev,
+			uint64_t err_addr, uint32_t ch, uint32_t umc,
+			uint32_t node, uint32_t socket,
+			uint64_t *addr, bool dump_addr);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 65336ae12585..9b93ff769b86 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -243,61 +243,6 @@ static void umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 	}
 }
 
-static int umc_v12_0_lookup_bad_pages_in_a_row(struct amdgpu_device *adev,
-			uint64_t pa_addr, uint64_t *pfns, int len)
-{
-	uint32_t i, ret = 0, pos = 0;
-	struct ta_ras_query_address_output addr_out;
-	struct ras_err_data err_data;
-
-	err_data.err_addr =
-		kcalloc(adev->umc.max_ras_err_cnt_per_query,
-				sizeof(struct eeprom_table_record), GFP_KERNEL);
-	if(!err_data.err_addr) {
-		dev_warn(adev->dev, "Failed to alloc memory in "
-				"bad page lookup!\n");
-		return 0;
-	}
-
-	addr_out.pa.pa = pa_addr;
-	umc_v12_0_convert_error_address(adev, &err_data, NULL, &addr_out, false);
-
-	for (i = 0; i < adev->umc.max_ras_err_cnt_per_query; i++) {
-		if (pos >= len)
-			goto out;
-
-		pfns[pos++] = err_data.err_addr[pos].retired_page;
-	}
-	ret = pos;
-
-out:
-	kfree(err_data.err_addr);
-	return ret;
-}
-
-static int umc_v12_0_convert_mca_to_addr(struct amdgpu_device *adev,
-			uint64_t err_addr, uint32_t ch, uint32_t umc,
-			uint32_t node, uint32_t socket,
-			uint64_t *addr, bool dump_addr)
-{
-	struct ta_ras_query_address_input addr_in;
-	struct ta_ras_query_address_output addr_out;
-
-	memset(&addr_in, 0, sizeof(addr_in));
-	addr_in.ma.err_addr = err_addr;
-	addr_in.ma.ch_inst = ch;
-	addr_in.ma.umc_inst = umc;
-	addr_in.ma.node_inst = node;
-	addr_in.ma.socket_id = socket;
-	addr_in.addr_type = TA_RAS_MCA_TO_PA;
-
-	umc_v12_0_convert_error_address(adev, NULL, &addr_in, &addr_out, dump_addr);
-
-	*addr = addr_out.pa.pa;
-
-	return 0;
-}
-
 static int umc_v12_0_query_error_address(struct amdgpu_device *adev,
 					uint32_t node_inst, uint32_t umc_inst,
 					uint32_t ch_inst, void *data)
@@ -525,7 +470,7 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
 		MCA_IPID_2_UMC_CH(ipid),
 		err_addr);
 
-	ret = umc_v12_0_convert_mca_to_addr(adev,
+	ret = amdgpu_umc_mca_to_addr(adev,
 			err_addr, MCA_IPID_2_UMC_CH(ipid),
 			MCA_IPID_2_UMC_INST(ipid), MCA_IPID_2_DIE_ID(ipid),
 			MCA_IPID_2_SOCKET_ID(ipid), &pa_addr, true);
@@ -559,7 +504,7 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
 	con->umc_ecc_log.de_queried_count++;
 
 	memset(page_pfn, 0, sizeof(page_pfn));
-	count = umc_v12_0_lookup_bad_pages_in_a_row(adev,
+	count = amdgpu_umc_lookup_bad_pages_in_a_row(adev,
 				pa_addr,
 				page_pfn, ARRAY_SIZE(page_pfn));
 	if (count <= 0) {
@@ -602,7 +547,7 @@ static int umc_v12_0_fill_error_record(struct amdgpu_device *adev,
 		return -EINVAL;
 
 	memset(page_pfn, 0, sizeof(page_pfn));
-	count = umc_v12_0_lookup_bad_pages_in_a_row(adev,
+	count = amdgpu_umc_lookup_bad_pages_in_a_row(adev,
 				ecc_err->pa_pfn << AMDGPU_GPU_PAGE_SHIFT,
 				page_pfn, ARRAY_SIZE(page_pfn));
 
@@ -659,5 +604,6 @@ struct amdgpu_umc_ras umc_v12_0_ras = {
 	.ecc_info_query_ras_error_address = umc_v12_0_query_ras_ecc_err_addr,
 	.check_ecc_err_status = umc_v12_0_check_ecc_err_status,
 	.update_ecc_status = umc_v12_0_update_ecc_status,
+	.convert_ras_err_addr = umc_v12_0_convert_error_address,
 };
 
-- 
2.34.1

