Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFBEEC4345F
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Apr 2024 03:33:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F405210EEBD;
	Sun, 28 Apr 2024 03:33:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MsM9ixPd";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4172C10E543
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Apr 2024 03:33:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COYKmv88gRo0oHc8NQwiT9lNG3TtrapymRYid/iEe+flZUepkHL4z1i5vPLtvt3TAFRyKu78c6BuKlRxv1aqwBUxTde7BG0gfyNIvIlS54PUbJjJwneJ/itJv1SV+iNJ6scUQlpTIEIuDORPnjqW2SATHVZNRlFgayyRnUvlC9rgcuEhNjPKCPNMgOHKk+bUYDqMu9hpIj366xHb4RgPiMIBYeYdNirAu/Iuz+4Y7l5MNP+H5Eu0yxrL0LwpFYgbb2vL5/qrUDuKCN5df0ygUuVqTrK/QNObgdd8nwRa1bXGc3v4toXtBrjktMo+YCU2D8m+VweMFeMcVKaz0M3ziA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CV2HlGInSiecn93dKVXHXhKvyRZcc07nV7XupP+xz3o=;
 b=HbMFvxMWGRhwMV7XIxlAA4QE/zBLP+4KElX5qCHnX0t+eTZ1pLeta3CKwuueNIOySwijk5btI1aXuLvrLWgGgYuGZkAh+vGRY8ETc5vSIsp2RjnmHucxp2tv1g1Y2zpVlglXx5A1l4r6HoFwwwe2sFbrHP2KDoI6w6pwIpzG/KcrNBPMVjF110KKCIpmE0RZqLlMTvlewiKqCP07s055JJPetWsAm6gBEvVPiPl9jGkUJD/TEcosEg2z0Vyv+holhG7NwTsZ0OqhR2806Vc4MF5gBbiqThlcahakZ32mlVZHjp4avhf95Xwcy9jnDC3rY/Q9QUMXsZDAixX+p43ovQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CV2HlGInSiecn93dKVXHXhKvyRZcc07nV7XupP+xz3o=;
 b=MsM9ixPdA96As/GtoK6JDcjBBGr6vl6iP65r9PQxRNS1vbVcVJRoFxae1NQhQVDTOCDPhOX1Ooc5ks365ped1T4XpMerUr3LAjCSJ9Q9CKY3HL1M4Ryo23mMAj0J3JX+yLCRoH/GV9tJl5dvyFWYWVa0v+tsP3MNm30vTIP5W9U=
Received: from DS0PR17CA0008.namprd17.prod.outlook.com (2603:10b6:8:191::15)
 by DM3PR12MB9327.namprd12.prod.outlook.com (2603:10b6:0:42::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.31; Sun, 28 Apr
 2024 03:33:25 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:8:191:cafe::e6) by DS0PR17CA0008.outlook.office365.com
 (2603:10b6:8:191::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32 via Frontend
 Transport; Sun, 28 Apr 2024 03:33:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Sun, 28 Apr 2024 03:33:24 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sat, 27 Apr
 2024 22:33:17 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Remove unused code
Date: Sun, 28 Apr 2024 11:32:37 +0800
Message-ID: <20240428033238.16508-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|DM3PR12MB9327:EE_
X-MS-Office365-Filtering-Correlation-Id: dca46516-323f-439a-bb90-08dc6733f61f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|82310400014|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vOCxojWCbzBDlVlRlRfLeRBuN4QLJAuRNF+r+lyoYk1ZcUIFKQFhS7K2H94r?=
 =?us-ascii?Q?v7nqs5GXgWx6/9vxsu2KC8MFnMEj4A7TP/4ARCfmkZKkqtZ8l9BRB1LUoghw?=
 =?us-ascii?Q?f+AdhwuZ504x5244Ab9MUC1pYu3AqsxbFmw1ABKz0wM6UMelEMdkazCDnYy0?=
 =?us-ascii?Q?hsGvQulwuQZLKF48/tj8CH0Eq/dMakBxQfUHicwTZAEaLuIj60/1S/YtxIG1?=
 =?us-ascii?Q?68hgX7ZsDe8C/wYj3FWANV6nHmDIax7d8wi0Lw/CKvtB1aXw2NI8VSPZkNiF?=
 =?us-ascii?Q?kRofrzal89MBxDlMDGLcTE4Z732xJn6xZ32FXm9FWqZnMWIebyUASa4F1iOM?=
 =?us-ascii?Q?5Ddk1iTnrq/sqvxF/pe4Y646u9T8qItuQ/+6e+DVj3JTr6qFbikFlObfsF3o?=
 =?us-ascii?Q?zMcmbWeWbjbLeKZ2IRzxm2ChlSQVuiddYK9mGblOzMwfWLgeFwLew6yQy8de?=
 =?us-ascii?Q?cCC75H6/pBFNpX664JVz2vGVZIIzb2EWKLFimVhE/oKQlgjlSxKgB4hJ6Iwp?=
 =?us-ascii?Q?i2r5PmIH7mgIDqk67DAEp7G4nSubXjX/r+0l54d4kV3P3J+D42WpgSNVKu3V?=
 =?us-ascii?Q?kenm+JABBBByMT1IKrpcoPgLBACD6GVtAEHa3m2aeiY7PH7ozXUc4oltZ1wd?=
 =?us-ascii?Q?5vSHifvo6txIFvLJpTVNxdyKuMhtnG8FiqMo7PMO4wuOBXxnUmLC6cb+Hwk7?=
 =?us-ascii?Q?e50WQoohVRDtFs1IgBu/CF1txE5PLMSNykL4zMbih18NqW/JGL22PMQfE32y?=
 =?us-ascii?Q?cWeGEYMb28eG55IXokLm6ejln1kBO4GOyuecV9I0IGjfko4zxLr9/Lp0FvhK?=
 =?us-ascii?Q?PeKB2M7nr28LUs2+HpnwL/jyaNVy8Ubk0qQjmTKfhXDNUze0cfPUIAJt+7xU?=
 =?us-ascii?Q?LyvIoS/rXnYksYnrN9y/HhB5EySUb/o783vSfJ9BHfMwe0o/+DqX1l0v1da0?=
 =?us-ascii?Q?LNMO2Xr/Q26cHxx6S9tBnzm9WWfOHcRrwoMGFuu6R7whqfoOD4tzzkp+8dAT?=
 =?us-ascii?Q?UGYXDbMwMmzk0hGhG6xJksYVropwyB9OHPvZ+SsaR5HWJl+qTd4Wv21RLwz+?=
 =?us-ascii?Q?nX7vJCxJMAMwpfBq40QBwZKJr8V1vBg9kMrQyhrfhWQAvjjGECZM7JGWFY8o?=
 =?us-ascii?Q?1KYjnV+X40s0iKWjvAOsgVRONB05W0/GrDUJ+X6ioFfV6/GpLGCsVgiIR/5k?=
 =?us-ascii?Q?Y0zciQczFzyHwZ/3EgmwQgvHYvI4uD7txkpiplKJbB6u2sKAeoAJiPdKeAvR?=
 =?us-ascii?Q?Zi6GUnZf8CPICvswvcDEJCYbdCgO7bCB3SKOy6lhXAYrvYFgQ2iDHdgN2SEW?=
 =?us-ascii?Q?/deAGCFV7gBNYYoEC2StImh0S4sEszbvVobpzIXuK9/+uhSCKxmAqAUlX6e4?=
 =?us-ascii?Q?oX4G+pu5Jt4uzKdHPE+H5faOTE/7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2024 03:33:24.9098 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dca46516-323f-439a-bb90-08dc6733f61f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9327
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

Remove unused code.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 69 --------------------------
 1 file changed, 69 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 8df84feaf046..12bae67be91c 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -376,75 +376,6 @@ static int umc_v12_0_err_cnt_init_per_channel(struct amdgpu_device *adev,
 	return 0;
 }
 
-static void umc_v12_0_ecc_info_query_ras_error_count(struct amdgpu_device *adev,
-					void *ras_error_status)
-{
-	struct ras_query_context qctx;
-
-	memset(&qctx, 0, sizeof(qctx));
-	qctx.event_id = amdgpu_ras_acquire_event_id(adev, amdgpu_ras_intr_triggered() ?
-						    RAS_EVENT_TYPE_ISR : RAS_EVENT_TYPE_INVALID);
-
-	amdgpu_mca_smu_log_ras_error(adev,
-		AMDGPU_RAS_BLOCK__UMC, AMDGPU_MCA_ERROR_TYPE_CE, ras_error_status, &qctx);
-	amdgpu_mca_smu_log_ras_error(adev,
-		AMDGPU_RAS_BLOCK__UMC, AMDGPU_MCA_ERROR_TYPE_UE, ras_error_status, &qctx);
-}
-
-static void umc_v12_0_ecc_info_query_ras_error_address(struct amdgpu_device *adev,
-					void *ras_error_status)
-{
-	struct ras_err_node *err_node;
-	uint64_t mc_umc_status;
-	struct ras_err_info *err_info;
-	struct ras_err_addr *mca_err_addr, *tmp;
-	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
-	struct ta_ras_query_address_input addr_in;
-
-	for_each_ras_error(err_node, err_data) {
-		err_info = &err_node->err_info;
-		if (list_empty(&err_info->err_addr_list))
-			continue;
-
-		addr_in.ma.node_inst = err_info->mcm_info.die_id;
-		addr_in.ma.socket_id = err_info->mcm_info.socket_id;
-
-		list_for_each_entry_safe(mca_err_addr, tmp, &err_info->err_addr_list, node) {
-			mc_umc_status = mca_err_addr->err_status;
-			if (mc_umc_status &&
-				(umc_v12_0_is_uncorrectable_error(adev, mc_umc_status) ||
-				 umc_v12_0_is_deferred_error(adev, mc_umc_status))) {
-				uint64_t mca_addr, err_addr, mca_ipid;
-				uint32_t InstanceIdLo;
-
-				mca_addr = mca_err_addr->err_addr;
-				mca_ipid = mca_err_addr->err_ipid;
-
-				err_addr = REG_GET_FIELD(mca_addr,
-							MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
-				InstanceIdLo = REG_GET_FIELD(mca_ipid, MCMP1_IPIDT0, InstanceIdLo);
-
-				addr_in.ma.err_addr = err_addr;
-				addr_in.ma.ch_inst = MCA_IPID_LO_2_UMC_CH(InstanceIdLo);
-				addr_in.ma.umc_inst = MCA_IPID_LO_2_UMC_INST(InstanceIdLo);
-
-				dev_info(adev->dev, "UMC:IPID:0x%llx, aid:%d, inst:%d, ch:%d, err_addr:0x%llx\n",
-					mca_ipid,
-					err_info->mcm_info.die_id,
-					MCA_IPID_LO_2_UMC_INST(InstanceIdLo),
-					MCA_IPID_LO_2_UMC_CH(InstanceIdLo),
-					err_addr);
-
-				umc_v12_0_convert_error_address(adev,
-					err_data, &addr_in);
-			}
-
-			/* Delete error address node from list and free memory */
-			amdgpu_ras_del_mca_err_addr(err_info, mca_err_addr);
-		}
-	}
-}
-
 static bool umc_v12_0_check_ecc_err_status(struct amdgpu_device *adev,
 			enum amdgpu_mca_error_type type, void *ras_error_status)
 {
-- 
2.34.1

