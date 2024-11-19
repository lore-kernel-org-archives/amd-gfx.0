Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E353BD591D4
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2024 06:36:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5CDA10E5CA;
	Tue, 19 Nov 2024 06:36:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="odLaKAwZ";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2074.outbound.protection.outlook.com [40.107.102.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0B8610E5C9
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2024 06:36:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zS3rsqyktvPCHKXd0ukqQO7++9+ODUG6ICQf6OwfPbltdPEYxTzYXEDM0YrzOkgJmXtARNHkOfX7U6k9KfRrxNKY328SWxDmar/4ssSFkS1YuvA8ktwwd5Kf6ET7l7rs+Do9rS1idronPN5gl+Vnl+jnuRFwbnCzPG2wcNuFHwqQ7ZbIwdTM1SUceMIrvcgsfGZV73R5Z1bSu2WeAmkQGWDkRr8Dlw/xTRh8csxBr8M88YLaSxBhiBHr3KqSvq5pPWOG/BQ4DFebnpiicS6IeumOuUsrbYPkJYCRqv7nkV0fXE9Hx8wnMEZf4YEFTrha/T4CHnAfatZ0c+8TxA/8Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+l+/79f5ZGHedQ039MhPHmkGImA9ylWS6RcT6JBvdEA=;
 b=dwv3nLeboB+a7yKhwA5PotdzQWYzF1eFdxGOrGohxToe138DaBcdCdu/k5T2Fj+E8cv8raWT7/bLMc8PHCSjaKwU8HxhuowjPYyBWwYzPiTf47naRO9OvkjtEKQufXezB3A5GfsUgit2ecvgzXgL6fwINnyhWD748gykfwjOSmUjjBadbzyIv3h3SHD+x7vlBKzfu14EYyF6iQy2BNw9CGfE5TpA5CgEZUm4S+gjZtEZmom0AErlYoyyX/VHtTyf54BB8DVw5GEcLdLDALrYiceWuQhNvtssAY2wbWyN2nfbZqLTDeSFLUpky7DMJgniaDlWQdxhmbl16VC7kTmi6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+l+/79f5ZGHedQ039MhPHmkGImA9ylWS6RcT6JBvdEA=;
 b=odLaKAwZt55x5AhRenRoHs2jdwoa7UI3bOxJyjOipP/8Not+myj8O7pZVgDuSSn1S8dQ8n+L91ac8rtD3GzVsFWbUWViHDj32E4Q/wK3PeVfhY45noxK6U5CHWG030L8SawHjpHn5sgpYGCusM71wPNI3wltA5lnnTQBNyJvw28=
Received: from MW4PR03CA0055.namprd03.prod.outlook.com (2603:10b6:303:8e::30)
 by IA1PR12MB7544.namprd12.prod.outlook.com (2603:10b6:208:42c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 06:36:32 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:303:8e:cafe::db) by MW4PR03CA0055.outlook.office365.com
 (2603:10b6:303:8e::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20 via Frontend
 Transport; Tue, 19 Nov 2024 06:36:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 06:36:31 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 00:36:28 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 06/21] drm/amdgpu: add return value for convert_ras_err_addr
Date: Tue, 19 Nov 2024 14:35:49 +0800
Message-ID: <20241119063604.81461-6-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119063604.81461-1-tao.zhou1@amd.com>
References: <20241119063604.81461-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|IA1PR12MB7544:EE_
X-MS-Office365-Filtering-Correlation-Id: 45823476-d1b6-4397-f410-08dd086481ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qk7gKfA7wDOwogzenPzgETAXINw+FDdf6ZZ+jHsLT+/CcrlfC85iqyP/KYVK?=
 =?us-ascii?Q?CDqeggcv1vNsTrpGRwRVAaKAOT/AjIBo3lYT0l7FP6Def2PoebVY88WkaC6m?=
 =?us-ascii?Q?yGj4jUZq5xljbIqCIFz3AEvZXShcBgtR/tormrxXfOvTwwcP25mWI/fQHTC3?=
 =?us-ascii?Q?p2jjnjwNX3dfuRfZdooiyrYLG8Yjo3dO1A7NoYSGhRXnZo2aiEfYcNNwtk3s?=
 =?us-ascii?Q?yhlxDMji7E7aOUlwC+Cy/tCip5iVXdK1XffSitYpbIW6Jyap8Ke5CfFnPR2w?=
 =?us-ascii?Q?Q32jhKCyB42n/TS6vSO38DEAEovBwIOX5ZX2glFWJXGmU1pLV/Duy1HL72vV?=
 =?us-ascii?Q?BedD49pnQpwjtxSBWEKOc3zPhRW525ZPuqg33f+7iYlwf6aF2BDAY/vvHHJn?=
 =?us-ascii?Q?3q6uHMTqe2Hl7uOSMWbycdXepjSDMjdj+tOxbiP30DFBZZ7TnfHMj4x2hZ6x?=
 =?us-ascii?Q?Gn5M5Q7q/RrcbHjplKnxh9sMZyMEq82xgbytL4GLbZWm4CIx5Rm05f/p82S3?=
 =?us-ascii?Q?AccHVZaanUYCgAMno7isZIFIjHXOL0nlZUH6Td2rg4f/IJ/j/gzcD2f4Ulyt?=
 =?us-ascii?Q?W07QNnrVJgTEKTnGddJYyG3k7ybKTZ9/JnPMYUwwKyoNhutgjTjDwzDJunaN?=
 =?us-ascii?Q?q4+fxnxHZnTfdygnI+mD4EkDvObi9F35/+mVuRCREQ0seKEIUHAMYyvT1SOJ?=
 =?us-ascii?Q?pfqAXqHjQIUEhTkZXxxVKWzw4rxMWUqMi2zGJJYPJmpCCjKfxBA+BK1HLP+I?=
 =?us-ascii?Q?B8S9e2Lsda4tNADm0EeSeNRf6CGAXtXwj7VM5l8phPIC0gXcr3jvSajYI2en?=
 =?us-ascii?Q?lwZJmkC/MD5Mxea93PLMo9/0WFKtyeBvd2BrMHhomL8/bs4pwFzkRCZV7tsJ?=
 =?us-ascii?Q?rtQEFoDVgu++wkzjSXRKhdnC0ADmK2Xgj6A+KnfW3eA8fuSy5upmEF6FD2Zz?=
 =?us-ascii?Q?4JIbhIPKsPKz31rcBx1iTq8/Ko/LGSUWC9fSuWdFVEaa/MMijibYqoM0P9F2?=
 =?us-ascii?Q?kKS928BhnahUsa70DeV5NbYrw3svnB1BCB7nIq+ZNbf5u0dMRK2+1nHyqg1L?=
 =?us-ascii?Q?NYWTZT57CbVPuRa/8LvjxCZHcQ4aALP2egkTduf7oLVJOk3EMeL4E7dFGqVF?=
 =?us-ascii?Q?GWC0dogFdCktoKoNwhm5mh55++7a6vbWKJlBTMz5/JYuaKe9CuqiNgMZMIxs?=
 =?us-ascii?Q?lCeMW+VT7XItYNUlH5HOZM13pVgSBqHyOIC6bXLUUNUSMIQRJAcWZhkIVj7M?=
 =?us-ascii?Q?fez+sX4PNnyPmFXl4jIokm/aU6M4fcXLUWGv59FsE3P66V6t5Rp7ioqotg25?=
 =?us-ascii?Q?Nzt9z+WB5JBNqrm11UEGWlcn0/kt67kh2NK8UqyCwe3QtWq4Dgh+DWAykwov?=
 =?us-ascii?Q?jSf9WglnO9RDKgBKTcBgSDnvD6GGzhUkFqZgu/mDVkLElnd44Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 06:36:31.9950 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45823476-d1b6-4397-f410-08dd086481ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7544
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

So upper layer can return failure directly if address conversion fails.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 19 +++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  | 12 ++++++++----
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index c0433e6471f5..3199dca8f1ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -464,11 +464,14 @@ int amdgpu_umc_lookup_bad_pages_in_a_row(struct amdgpu_device *adev,
 
 	addr_out.pa.pa = pa_addr;
 
-	if (adev->umc.ras && adev->umc.ras->convert_ras_err_addr)
-		adev->umc.ras->convert_ras_err_addr(adev, &err_data, NULL,
+	if (adev->umc.ras && adev->umc.ras->convert_ras_err_addr) {
+		ret = adev->umc.ras->convert_ras_err_addr(adev, &err_data, NULL,
 				&addr_out, false);
-	else
+		if (ret)
+			goto out;
+	} else {
 		goto out;
+	}
 
 	for (i = 0; i < adev->umc.retire_unit; i++) {
 		if (pos >= len)
@@ -490,6 +493,7 @@ int amdgpu_umc_mca_to_addr(struct amdgpu_device *adev,
 {
 	struct ta_ras_query_address_input addr_in;
 	struct ta_ras_query_address_output addr_out;
+	int ret;
 
 	memset(&addr_in, 0, sizeof(addr_in));
 	addr_in.ma.err_addr = err_addr;
@@ -498,11 +502,14 @@ int amdgpu_umc_mca_to_addr(struct amdgpu_device *adev,
 	addr_in.ma.node_inst = node;
 	addr_in.ma.socket_id = socket;
 
-	if (adev->umc.ras && adev->umc.ras->convert_ras_err_addr)
-		adev->umc.ras->convert_ras_err_addr(adev, NULL, &addr_in,
+	if (adev->umc.ras && adev->umc.ras->convert_ras_err_addr) {
+		ret = adev->umc.ras->convert_ras_err_addr(adev, NULL, &addr_in,
 				&addr_out, dump_addr);
-	else
+		if (ret)
+			return ret;
+	} else {
 		return 0;
+	}
 
 	*addr = addr_out.pa.pa;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index abde7597bda8..f45408a6ff03 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -70,7 +70,7 @@ struct amdgpu_umc_ras {
 			enum amdgpu_mca_error_type type, void *ras_error_status);
 	int (*update_ecc_status)(struct amdgpu_device *adev,
 			uint64_t status, uint64_t ipid, uint64_t addr);
-	void (*convert_ras_err_addr)(struct amdgpu_device *adev,
+	int (*convert_ras_err_addr)(struct amdgpu_device *adev,
 			struct ras_err_data *err_data,
 			struct ta_ras_query_address_input *addr_in,
 			struct ta_ras_query_address_output *addr_out,
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 9b93ff769b86..ce60fd6675ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -173,7 +173,7 @@ static void umc_v12_0_query_ras_error_count(struct amdgpu_device *adev,
 	umc_v12_0_reset_error_count(adev);
 }
 
-static void umc_v12_0_convert_error_address(struct amdgpu_device *adev,
+static int umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 					struct ras_err_data *err_data,
 					struct ta_ras_query_address_input *addr_in,
 					struct ta_ras_query_address_output *addr_out,
@@ -183,6 +183,7 @@ static void umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 	uint64_t soc_pa, retired_page, column, err_addr;
 	struct ta_ras_query_address_output addr_out_tmp;
 	struct ta_ras_query_address_output *paddr_out;
+	int ret = 0;
 
 	if (!addr_out)
 		paddr_out = &addr_out_tmp;
@@ -193,11 +194,12 @@ static void umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 	if (addr_in) {
 		err_addr = addr_in->ma.err_addr;
 		addr_in->addr_type = TA_RAS_MCA_TO_PA;
-		if (psp_ras_query_address(&adev->psp, addr_in, paddr_out)) {
+		ret = psp_ras_query_address(&adev->psp, addr_in, paddr_out);
+		if (ret) {
 			dev_warn(adev->dev, "Failed to query RAS physical address for 0x%llx",
 				err_addr);
 
-			return;
+			return ret;
 		}
 
 		bank = paddr_out->pa.bank;
@@ -209,7 +211,7 @@ static void umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 	soc_pa = paddr_out->pa.pa;
 
 	if (!err_data && !dump_addr)
-		return;
+		return ret;
 
 	col = (err_addr >> 1) & 0x1fULL;
 	/* clear [C3 C2] in soc physical address */
@@ -241,6 +243,8 @@ static void umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 			amdgpu_umc_fill_error_record(err_data, err_addr,
 				retired_page, channel_index, umc_inst);
 	}
+
+	return ret;
 }
 
 static int umc_v12_0_query_error_address(struct amdgpu_device *adev,
-- 
2.34.1

