Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC90CF9C6F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Sep 2024 14:16:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73A6410E6F6;
	Tue, 24 Sep 2024 14:16:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ApXKQ7ZN";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8CB610E6F6
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Sep 2024 14:16:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sN6yMIT/qLx31N5SMi9S+g4nsPXJnLwajhhJYGDeukwiDqUzYns3tx3rfrpyPktWD2nfrEAHFxgPS5FaawwtdyFRIXvyGwA/qIUIw3s/bOxbKrugPyz9Gl0sb49ZjxlJuRaEYwrJZQibs9wl5aPf+FefjZ0f4SsFJQg5XiqdnWFHN04zqqpe5C8Jdpo18V1xe8Tk1rWQB1sTCVp/fC44ZryI/izoc0KrnEcd84i9kiJdcOFkxD2yqOM47l317PtcnG+Bqw0cU5tkLacJwH9tlp8v2yZk40xZn3m43rnCrRP3Ro/e0cLRxFAsSBn4JJSrQ80areqrAC1f3Ti4eH+s/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VpDB4DKWZY8gAXdMK1M9CwWrq6xFB1J+Es9iLKjSMg0=;
 b=O0NgdJ9qLcQN9/by7hOzAreMPOe5l2IfcxDTOAFYebn9uD7CD+WaqwijTxpFrYao3C7J2hsiKtOnyw+z+w8RS1AZ0UNBqIZyIf3nXCoIygfT19oWdV36vS0kBDwSrJoGJ1cMOL6Ayd2qK5W+17pd8o37y+8jQy6qm1gPaFXwLpbyTromFzBfOzFC6i5CQCYcyu4uf6vyhh3DopX19vWJg3J0koAEbkNoXHyUzLvR4sJ4TQRxtFy6TD7d7ZrfF/cLSOcv/OsfVZAGDm1WNFBimoF21q8o7mwKEJz/OnhPBqGCjYiMQ0ckcBnQnGKFDXt9mE5cKzJP6DgCzNqZ4ijjJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpDB4DKWZY8gAXdMK1M9CwWrq6xFB1J+Es9iLKjSMg0=;
 b=ApXKQ7ZNfOYLaTfCMxvE4j3wWEGsNv4PzBd1wH4rLlRJDAp1J6dNPlEitljbStuGxij2NfxUl33DXlnJYTGJfX3QL3X3uq6nb4Yi3r0Dz25qQc0GeTcnQAnB4iuxxUEYs2sRapOuhtysNW2G2mMlHeOVec+Sq54TPIriQ86Y9Z8=
Received: from SN6PR2101CA0024.namprd21.prod.outlook.com
 (2603:10b6:805:106::34) by MN2PR12MB4080.namprd12.prod.outlook.com
 (2603:10b6:208:1d9::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Tue, 24 Sep
 2024 14:16:11 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:805:106:cafe::59) by SN6PR2101CA0024.outlook.office365.com
 (2603:10b6:805:106::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.4 via Frontend
 Transport; Tue, 24 Sep 2024 14:16:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Tue, 24 Sep 2024 14:16:11 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Sep
 2024 09:16:06 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <le.ma@amd.com>, <hawking.zhang@amd.com>, <shiwu.zhang@amd.com>,
 <Asad.Kamal@amd.com>, <charis.poag@amd.com>, <donald.cheung@amd.com>,
 <sepehr.khatir@amd.com>, <daniel.oliveira@amd.com>
Subject: [PATCH v2 2/4] drm/amdgpu: Add callback get xcp resource info
Date: Tue, 24 Sep 2024 22:15:47 +0800
Message-ID: <20240924141549.244754-2-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240924141549.244754-1-asad.kamal@amd.com>
References: <20240924141549.244754-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|MN2PR12MB4080:EE_
X-MS-Office365-Filtering-Correlation-Id: fbcf29dd-0565-4f21-5ce9-08dcdca37120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JR3FqLCXa0eR55B+1iC0yIpq9DPG2yam/YkCDwDS1SrlHojhKUbHg3AYdhFW?=
 =?us-ascii?Q?Il+IM0diJULrlf0Ox3XsGhaGlkHoOfWWaY7dFee2BeO9sO6w1MXkWejaZhhf?=
 =?us-ascii?Q?YUpERCdcEnqqy8As+Qbxmh1+bypdyr/vRv+Bb7TiTVD2B4ygzo/FuV5JI7xP?=
 =?us-ascii?Q?fcFu2tTAaqlHMRGtTNG5qBiQilyrWEtDrfQCksX5jVpFEIP2VILjk+6rwfed?=
 =?us-ascii?Q?RJrAMFRI3bm7vnWby6LbxkZrZN8XFVrb0mG0j4PZ80AqZ/5CTAp4EQzC+eC5?=
 =?us-ascii?Q?sYGwP4zXeHFvDSyO8mDPrnSJBccuaKJT1l1Ob34ABIPLwuocxERbbyRUy11f?=
 =?us-ascii?Q?z0VqCKOaQv24LMrbSjpAfMtv39279kUXByRuLpQXhwKmSXyJJmF7ck9lYlbP?=
 =?us-ascii?Q?YnzpUwcpFmTPXv8YwbzQ1oW1z+sDcEVZeQ+Y3JDN9IuSlnd3SNI7uVgWE9rx?=
 =?us-ascii?Q?DcluuDp+VMxKOaHwEiMRC7CUr5oWuBVO92YmgInpvJRwotpNQRt7WOHCjwhN?=
 =?us-ascii?Q?fbrcjGjtrOqQjSIR5QrJ9WNyiWO3MtztwIK6zqLeOUx5lBkVvo7IsnGbVVcE?=
 =?us-ascii?Q?p+71Z688KnLNkWhvmExXAFCkjIGT+wh8UdkWq7Utn6FKClEaVOzQAoEfka5r?=
 =?us-ascii?Q?evALiAukbfMYp4BHUnlzkJKjnwcwUr8Oye8oZr68hH/VlpuyBTAaCfWpLQ0M?=
 =?us-ascii?Q?rR+gHB2/dGqn/y1zxL3Hz8xUL6eHVGKZl+5nY3/rKBEyUKSlrgiQgjxTfcNF?=
 =?us-ascii?Q?Bdt9gG93bHHZvFtU81ZQmlBmLRBQLHRvand4b4yJu0Zp5C2Gavboegw49JQS?=
 =?us-ascii?Q?kiPF0ed6bc3BlmnKzCSxYq1uvci8DpzMSB135aKqJpdrftI9QQc/VVMLMNxC?=
 =?us-ascii?Q?RDM14h0nWqYPoByA+wq5vv2oD5ZCx5slJ4EGlk/Awp7IN6Cv3NGsEGAfKsYF?=
 =?us-ascii?Q?hvo0aTJCWOCYVWF0s8UgGeZJVRMZfgSZFSFSDsS0ZcfB9xF9k9OAi/iKxo2Z?=
 =?us-ascii?Q?udVsBPFmlIRCDs8Q+1bLKQ5A6yAr79/R+keKbrvFdV877q3tDmiz9PsZ/r4D?=
 =?us-ascii?Q?DdFDPGHVcyjTF6XhxCHJ/A26v6YWwI/DlNEtaEx2LBjR2GDHBtqTkv9FO5Ty?=
 =?us-ascii?Q?90HAWC6p1zNof5X+4MLARt07bMNMdJeyuNVdefXJyb+XDUHvxXut/IvOT0+X?=
 =?us-ascii?Q?QjJAUaxOSL/5E3UygMUAzcI86REqbjdPoy1hGXVq7HzMWeNdOwQJzGNukv1z?=
 =?us-ascii?Q?/ptJ//socU04DBDDdWqZgMla9hac3tEBh5yUslpc1uKXdI8/P9shfnJj5goB?=
 =?us-ascii?Q?rW8mkJr1rxe/Z8v8sfW1jJCR3j3n8URURk3ha00FJa4WDsJAtpsI37gRnAMq?=
 =?us-ascii?Q?OWFdJbZCiEXWK+5IAfRZ8JyTy6UOkEttkZFRz7F4i07Iv0Q40+1PQnxYEFtz?=
 =?us-ascii?Q?c3Po63uHD6aOlSF4poU5gUvBC1u5BY0Q?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 14:16:11.4556 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbcf29dd-0565-4f21-5ce9-08dcdca37120
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4080
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

From: Lijo Lazar <lijo.lazar@amd.com>

Add a callback interface to get the resource information of a partition
mode. Presently the information has number of resources and number of
entities sharing the resource.

Add the implementation for aquavanjaram SOCs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h    | 26 +++++++++-
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 59 +++++++++++++++++++++-
 2 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
index 2c54c05f2c16..648237f27d1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
@@ -56,6 +56,27 @@ enum AMDGPU_XCP_STATE {
 	AMDGPU_XCP_RESUME,
 };
 
+enum amdgpu_xcp_res_id {
+	AMDGPU_XCP_RES_XCC,
+	AMDGPU_XCP_RES_DMA,
+	AMDGPU_XCP_RES_DEC,
+	AMDGPU_XCP_RES_JPEG,
+	AMDGPU_XCP_RES_MAX,
+};
+
+struct amdgpu_xcp_res_details {
+	enum amdgpu_xcp_res_id id;
+	u8 num_inst;
+	u8 num_shared;
+};
+
+struct amdgpu_xcp_cfg {
+	u8 mode;
+	struct amdgpu_xcp_res_details xcp_res[AMDGPU_XCP_RES_MAX];
+	u8 num_res;
+	struct amdgpu_xcp_mgr *xcp_mgr;
+};
+
 struct amdgpu_xcp_ip_funcs {
 	int (*prepare_suspend)(void *handle, uint32_t inst_mask);
 	int (*suspend)(void *handle, uint32_t inst_mask);
@@ -97,6 +118,7 @@ struct amdgpu_xcp_mgr {
 
 	 /* Used to determine KFD memory size limits per XCP */
 	unsigned int num_xcp_per_mem_partition;
+	struct amdgpu_xcp_cfg *xcp_cfg;
 	uint32_t supp_xcp_modes;
 	uint32_t avail_xcp_modes;
 };
@@ -110,7 +132,9 @@ struct amdgpu_xcp_mgr_funcs {
 			      struct amdgpu_xcp_ip *ip);
 	int (*get_xcp_mem_id)(struct amdgpu_xcp_mgr *xcp_mgr,
 			      struct amdgpu_xcp *xcp, uint8_t *mem_id);
-
+	int (*get_xcp_res_info)(struct amdgpu_xcp_mgr *xcp_mgr,
+				int mode,
+				struct amdgpu_xcp_cfg *xcp_cfg);
 	int (*prepare_suspend)(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id);
 	int (*suspend)(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id);
 	int (*prepare_resume)(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id);
diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index 2255ddbb51ce..890976b7ce77 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -447,6 +447,61 @@ static int __aqua_vanjaram_get_xcp_ip_info(struct amdgpu_xcp_mgr *xcp_mgr, int x
 	return 0;
 }
 
+static int aqua_vanjaram_get_xcp_res_info(struct amdgpu_xcp_mgr *xcp_mgr,
+					  int mode,
+					  struct amdgpu_xcp_cfg *xcp_cfg)
+{
+	struct amdgpu_device *adev = xcp_mgr->adev;
+	int max_res[AMDGPU_XCP_RES_MAX] = {};
+	bool res_lt_xcp;
+	int num_xcp, i;
+
+	if (!(xcp_mgr->supp_xcp_modes & BIT(mode)))
+		return -EINVAL;
+
+	max_res[AMDGPU_XCP_RES_XCC] = NUM_XCC(adev->gfx.xcc_mask);
+	max_res[AMDGPU_XCP_RES_DMA] = adev->sdma.num_instances;
+	max_res[AMDGPU_XCP_RES_DEC] = adev->vcn.num_vcn_inst;
+	max_res[AMDGPU_XCP_RES_JPEG] = adev->jpeg.num_jpeg_inst;
+
+	switch (mode) {
+	case AMDGPU_SPX_PARTITION_MODE:
+		num_xcp = 1;
+		break;
+	case AMDGPU_DPX_PARTITION_MODE:
+		num_xcp = 2;
+		break;
+	case AMDGPU_TPX_PARTITION_MODE:
+		num_xcp = 3;
+		break;
+	case AMDGPU_QPX_PARTITION_MODE:
+		num_xcp = 4;
+		break;
+	case AMDGPU_CPX_PARTITION_MODE:
+		num_xcp = NUM_XCC(adev->gfx.xcc_mask);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	xcp_cfg->num_res = ARRAY_SIZE(max_res);
+
+	for (i = 0; i < xcp_cfg->num_res; i++) {
+		res_lt_xcp = max_res[i] < num_xcp;
+		xcp_cfg->xcp_res[i].id = i;
+		xcp_cfg->xcp_res[i].num_inst =
+			res_lt_xcp ? 1 : max_res[i] / num_xcp;
+		xcp_cfg->xcp_res[i].num_inst =
+			i == AMDGPU_XCP_RES_JPEG ?
+			xcp_cfg->xcp_res[i].num_inst *
+			adev->jpeg.num_jpeg_rings : xcp_cfg->xcp_res[i].num_inst;
+		xcp_cfg->xcp_res[i].num_shared =
+			res_lt_xcp ? num_xcp / max_res[i] : 1;
+	}
+
+	return 0;
+}
+
 static enum amdgpu_gfx_partition
 __aqua_vanjaram_get_auto_mode(struct amdgpu_xcp_mgr *xcp_mgr)
 {
@@ -709,9 +764,11 @@ struct amdgpu_xcp_mgr_funcs aqua_vanjaram_xcp_funcs = {
 	.switch_partition_mode = &aqua_vanjaram_switch_partition_mode,
 	.query_partition_mode = &aqua_vanjaram_query_partition_mode,
 	.get_ip_details = &aqua_vanjaram_get_xcp_ip_details,
+	.get_xcp_res_info = &aqua_vanjaram_get_xcp_res_info,
 	.get_xcp_mem_id = &aqua_vanjaram_get_xcp_mem_id,
 	.select_scheds = &aqua_vanjaram_select_scheds,
-	.update_partition_sched_list = &aqua_vanjaram_update_partition_sched_list
+	.update_partition_sched_list =
+		&aqua_vanjaram_update_partition_sched_list
 };
 
 static int aqua_vanjaram_xcp_mgr_init(struct amdgpu_device *adev)
-- 
2.46.0

