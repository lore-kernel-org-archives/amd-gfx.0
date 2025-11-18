Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3431CED24E
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Nov 2025 09:17:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D01410E469;
	Tue, 18 Nov 2025 09:17:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4GTZxJY0";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012033.outbound.protection.outlook.com
 [40.93.195.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFA9C10E45E
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 09:17:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=op7KhloTTqcun3x/ZPNd/yEmoRxpIYLp+x0ff3E7yyvKKl3E8W1x2fj5zn6Qm0gJSsCKkWiZ2MuYE1YfzPDME+R3ATLUOq9ITOxmLwfW0GucMa/6OEN4q+Z1L6Xv+7Hty69Lh7b4gZuwAXIKNAM3h9C3xbSRnclv5IPwSThoAdwYbPRVrHVB5Vtd/VqF/ObW1LLU0jAaLKfCxiw7LXf1J/02ZVdMl8LxXhUbc5akwE7q/YwxjJtflR7xHiwbI7bKvGjw0TKuiNhDtmlDFCfX2sGumrq0lXMa8LGEQAqb2AyhfL7EPexyb/9wudM7fhx4a61Rxo5HsyczsPQmsw8dKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RxV1vU4awhu/bbFai0c2Yop7DO7AcxYOQxMaRkmpILk=;
 b=Lre/K2ABc3nM4tT9SUhF/kVwczwi3jBLAzAFboWAziLqrJ81/RA5zQPwLwkDG9nKO4avtYpQ+po1HrqxoKVnpvF+8bG4UCjkVVgSJ02/KfM7WQ3nyDAj/P+DIlnYKcPQh1LsDmlR/kd2EbrLGZ/LTOf5uBHnd89Pp8vISbYXfOUjhPotPZJXp4t+OE/62/ieaC0sfR1niXpmR4/zhY6DT9RiQm4AzpaUmXMTop2UbRFP6lt8nRs2GAtyuHigDWNloa9qSz6LHJ8I9StgQ3Ku77r4MiswH0crg+jNBA+Jl6fLxhMk3mt1YuNQT4WxpiuciQEzjEiYtAFz9vtrCA0f5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxV1vU4awhu/bbFai0c2Yop7DO7AcxYOQxMaRkmpILk=;
 b=4GTZxJY0dPYFS6yzCq4E3yhTykRj8pCrd0DMuyqx1PPpAPsCED50elaV20wFqTC8Z9R4v5Gu8TZ/KQBD70WJlaCFiQsd9WkBHYSwTKy6andHoi/kg26wDBOTZ2i+qdy+nP4YwJvtMCdKZPWKVPiA6eqZAG7y2ugZAbbzFn5SnUY=
Received: from MN2PR19CA0070.namprd19.prod.outlook.com (2603:10b6:208:19b::47)
 by SJ1PR12MB6364.namprd12.prod.outlook.com (2603:10b6:a03:452::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 09:17:04 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:19b:cafe::70) by MN2PR19CA0070.outlook.office365.com
 (2603:10b6:208:19b::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Tue,
 18 Nov 2025 09:17:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 09:17:03 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 18 Nov
 2025 01:17:01 -0800
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, <Jinzhou.Su@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>, Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 4/7] drm/amd/ras: Support high-frequency querying sriov ras
 block error count
Date: Tue, 18 Nov 2025 17:15:56 +0800
Message-ID: <20251118091559.959683-4-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251118091559.959683-1-YiPeng.Chai@amd.com>
References: <20251118091559.959683-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|SJ1PR12MB6364:EE_
X-MS-Office365-Filtering-Correlation-Id: a4a8f517-8613-44a3-f7ff-08de26833d04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P7CBbuchFcTy61uoIO9HUnKWZ8AZZSrisKoUuPLaMhz4iq+6+hKHAHDRjdTs?=
 =?us-ascii?Q?Ege12r+wFPOYXmLV5/BcRKFusgnKonDlOZB9m3MDbssn+lCPNDsjt81KMEIa?=
 =?us-ascii?Q?Kuju2BDzTT/bk2UM81m1n6Nfy2BohSM2HMUJ80r9WW+FoZkWZEs3YN70ga3H?=
 =?us-ascii?Q?iWou5K9zNGI9oz8RpuEpVVRbUz+He8fmM7hZriyruEqxA7jwYqU7HGoxeqcz?=
 =?us-ascii?Q?vV5dmHg7YKxR3y9Gcrg+KWnt5VXr3U1mF9onvaKAj3Uc6mKHv42d3BrwJtRI?=
 =?us-ascii?Q?QIYx+NovLTJDQ3mypfOCFnEFzhhpwIuggKw0t3gp4GKgK4IiVZfdSRFRvJqv?=
 =?us-ascii?Q?TcgP+Zz4d7OdQIxTxHpJlhW2JiTeHkyw/blg8/AO0OvbTaogwuGlR2pEN7PF?=
 =?us-ascii?Q?+nYAtEVchOo2G9WPWAYeOyIJTO8hjXX/dhtk8UVK1juIF7cHaJhIoBZjKxaq?=
 =?us-ascii?Q?tlqBF3SbDXMJAMLMCMuY44OXixLWs+Nkbi53tvUmSKidrOyiBRf4hlm80HXi?=
 =?us-ascii?Q?z/MzMA++OLiK/DnoFBeBi2bKr1eQabYsQFK3b7pxtkl96SB9sFWMXhjFgXUf?=
 =?us-ascii?Q?8QPtyATMOe5UEJYynFmnFUJY6sCUnLn2O1aFk1f9TvuW8v0LGqCN0x0Hlvv/?=
 =?us-ascii?Q?DE/WhGRMxde2WAa3nfQ2HtRLWTmbEy8Gye5jGPV/ixhp03N7WoilKHUECPJs?=
 =?us-ascii?Q?H6lWV+Ime3YsdERoU2stmunIRI8HYVdrmxju9g0KgZnih5wurZ1TqnhcyaJi?=
 =?us-ascii?Q?VtIJdqYvlBq2BbrSLxQrRzwPWxmICyBJ4Hq/ZaVpqTV76fcizF0NA6NqldU9?=
 =?us-ascii?Q?V2ABrY5m8zTObFeVLWSqqm2c7iJd49iFlk/dxDhmpWpSINiSLNfkQ1fz2+qE?=
 =?us-ascii?Q?WF2KT4DUxO+qaFkM7Wj9vhGZ7h2xvTa8wvOyruLIsgsCdj29BRJjSQGHLVOH?=
 =?us-ascii?Q?w6hZZa9ZRfn7UZGNOS40b2sIOdjYLKPfEqLIInTXeX66FwA/RJtds2J/dIDC?=
 =?us-ascii?Q?X4E5U+W64xeOHGOJwhmPZNEW5Oe/PjgjYjEWicJjkLfZVJPARU9RiKDDEBR+?=
 =?us-ascii?Q?UVt3QmQW5/B5R+Z6KfggcW4W7q+Uc7O7AuEWSqacnUGAe926YyXanE6F/cpx?=
 =?us-ascii?Q?x07Pz0q86rTUNZ30gz3jjMNgd4JnHVEy5Z6+Ow3x1Bp3a0UXiEOtGRCbMx2c?=
 =?us-ascii?Q?Ujn+P5+x8uLItN+jSB8OHMh/X2IZ4y4AsXTez+XN2CVEZcDd6KasHicfh2P+?=
 =?us-ascii?Q?0jNVJE7QpUskamG0HOj0C/1ljYbWj9LWeq+PNTREQnr1I5dCdIhmIkTmhdv9?=
 =?us-ascii?Q?Dh1mzZ9DDogSXaqnVkikgkf+Q1q+6Kpv9OtDj5SIlqXuDcdj0SG9cw1KdVKe?=
 =?us-ascii?Q?xiV1CltjZQMUZlWUOUh89Q/JV04IZ19NVIwcL76AeiZdtBn7XngJjqpcfgKE?=
 =?us-ascii?Q?LLuos8aIUWjTL0kOXRnR9XX3nMYoTP3Z1zlZWfRFtkqhyBFp7QcnCF6oBoxN?=
 =?us-ascii?Q?o3dphkMNOHd9MohoIXdp0cVE3g4vDFKXgxYFazmE9Nu1UXTySQZ/uReFNDCg?=
 =?us-ascii?Q?kethETboPp6tBLHgawU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 09:17:03.9064 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a8f517-8613-44a3-f7ff-08de26833d04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6364
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

Support high-frequency querying sriov ras block error count:
1. Create shared memory and fills it with RAS_CMD__GET_LAL_LOC_STATUS
   ras command.
2. The RAS_CMD_GET_ALL_BLOCK_ECC_STATUS command and shared
   memory are registered to sriov host ras auto-update list
   via RAS_CMD_SET_CMD_AUTO_UPDATE command.
3. Once sriov host detects ras error, it will automatically execute
   RAS_CMD__GET_ALL_BLOCK_ECC_STATUS command and write the result to
   shared memory.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 .../drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c | 112 ++++++++++++++++++
 .../drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.h |   9 ++
 drivers/gpu/drm/amd/ras/rascore/ras_cmd.h     |  33 ++++++
 3 files changed, 154 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
index 992ff214f30a..73568a6e3463 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
@@ -235,9 +235,90 @@ static int amdgpu_virt_ras_get_cper_records(struct ras_core_context *ras_core,
 	return RAS_CMD__SUCCESS;
 }
 
+static int __fill_get_blocks_ecc_cmd(struct amdgpu_device *adev,
+			struct vram_blocks_ecc *blks_ecc)
+{
+	struct ras_cmd_ctx *rcmd;
+
+	if (!blks_ecc || !blks_ecc->bo || !blks_ecc->cpu_addr)
+		return -EINVAL;
+
+	rcmd = (struct ras_cmd_ctx *)blks_ecc->cpu_addr;
+
+	rcmd->cmd_id = RAS_CMD__GET_ALL_BLOCK_ECC_STATUS;
+	rcmd->input_size = sizeof(struct ras_cmd_blocks_ecc_req);
+	rcmd->output_buf_size = blks_ecc->size - sizeof(*rcmd);
+
+	return 0;
+}
+
+static int __set_cmd_auto_update(struct amdgpu_device *adev,
+			enum ras_cmd_id cmd_id, uint64_t gpa_addr, uint32_t len, bool reg)
+{
+	struct ras_cmd_auto_update_req req = {0};
+	struct ras_cmd_auto_update_rsp rsp = {0};
+	int ret;
+
+	req.mode = reg ? 1 : 0;
+	req.cmd_id = cmd_id;
+	req.addr = gpa_addr;
+	req.len = len;
+	ret = amdgpu_ras_mgr_handle_ras_cmd(adev, RAS_CMD__SET_CMD_AUTO_UPDATE,
+		&req, sizeof(req), &rsp, sizeof(rsp));
+
+	return ret;
+}
+
+static int amdgpu_virt_ras_get_block_ecc(struct ras_core_context *ras_core,
+				struct ras_cmd_ctx *cmd, void *data)
+{
+	struct amdgpu_device *adev = ras_core->dev;
+	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
+	struct amdgpu_virt_ras_cmd *virt_ras =
+			(struct amdgpu_virt_ras_cmd *)ras_mgr->virt_ras_cmd;
+	struct vram_blocks_ecc *blks_ecc = &virt_ras->blocks_ecc;
+	struct ras_cmd_ctx *blks_ecc_cmd_ctx;
+	struct ras_cmd_blocks_ecc_rsp *blks_ecc_rsp;
+	struct ras_cmd_block_ecc_info_req *input_data =
+			(struct ras_cmd_block_ecc_info_req *)cmd->input_buff_raw;
+	struct ras_cmd_block_ecc_info_rsp *output_data =
+			(struct ras_cmd_block_ecc_info_rsp *)cmd->output_buff_raw;
+	int ret = 0;
+
+	if (cmd->input_size != sizeof(struct ras_cmd_block_ecc_info_req))
+		return RAS_CMD__ERROR_INVALID_INPUT_SIZE;
+
+	if (input_data->block_id >= MAX_RAS_BLOCK_NUM)
+		return RAS_CMD__ERROR_INVALID_INPUT_DATA;
+
+	if (__fill_get_blocks_ecc_cmd(adev, blks_ecc))
+		return RAS_CMD__ERROR_GENERIC;
+
+	if (!virt_ras->blocks_ecc.auto_update_actived) {
+		ret = __set_cmd_auto_update(adev, RAS_CMD__GET_ALL_BLOCK_ECC_STATUS,
+				blks_ecc->mc_addr - adev->gmc.vram_start,
+				blks_ecc->size, true);
+		if (ret)
+			return ret;
+
+		blks_ecc->auto_update_actived = true;
+	}
+
+	blks_ecc_cmd_ctx = blks_ecc->cpu_addr;
+	blks_ecc_rsp = (struct ras_cmd_blocks_ecc_rsp *)blks_ecc_cmd_ctx->output_buff_raw;
+
+	output_data->ce_count = blks_ecc_rsp->blocks[input_data->block_id].ce_count;
+	output_data->ue_count = blks_ecc_rsp->blocks[input_data->block_id].ue_count;
+	output_data->de_count = blks_ecc_rsp->blocks[input_data->block_id].de_count;
+
+	cmd->output_size = sizeof(struct ras_cmd_block_ecc_info_rsp);
+	return RAS_CMD__SUCCESS;
+}
+
 static struct ras_cmd_func_map amdgpu_virt_ras_cmd_maps[] = {
 	{RAS_CMD__GET_CPER_SNAPSHOT, amdgpu_virt_ras_get_cper_snapshot},
 	{RAS_CMD__GET_CPER_RECORD, amdgpu_virt_ras_get_cper_records},
+	{RAS_CMD__GET_BLOCK_ECC_STATUS, amdgpu_virt_ras_get_block_ecc},
 };
 
 int amdgpu_virt_ras_handle_cmd(struct ras_core_context *ras_core,
@@ -294,10 +375,41 @@ int amdgpu_virt_ras_sw_fini(struct amdgpu_device *adev)
 
 int amdgpu_virt_ras_hw_init(struct amdgpu_device *adev)
 {
+	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
+	struct amdgpu_virt_ras_cmd *virt_ras =
+			(struct amdgpu_virt_ras_cmd *)ras_mgr->virt_ras_cmd;
+	struct vram_blocks_ecc *blks_ecc = &virt_ras->blocks_ecc;
+
+	memset(blks_ecc, 0, sizeof(*blks_ecc));
+	blks_ecc->size = PAGE_SIZE;
+	if (amdgpu_bo_create_kernel(adev, blks_ecc->size,
+			PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM,
+			&blks_ecc->bo, &blks_ecc->mc_addr,
+			(void **)&blks_ecc->cpu_addr))
+		return -ENOMEM;
+
 	return 0;
 }
 
 int amdgpu_virt_ras_hw_fini(struct amdgpu_device *adev)
 {
+	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
+	struct amdgpu_virt_ras_cmd *virt_ras =
+			(struct amdgpu_virt_ras_cmd *)ras_mgr->virt_ras_cmd;
+	struct vram_blocks_ecc *blks_ecc = &virt_ras->blocks_ecc;
+
+	if (blks_ecc->bo) {
+		__set_cmd_auto_update(adev,
+			RAS_CMD__GET_ALL_BLOCK_ECC_STATUS,
+			blks_ecc->mc_addr - adev->gmc.vram_start,
+			blks_ecc->size, false);
+
+		memset(blks_ecc->cpu_addr, 0, blks_ecc->size);
+		amdgpu_bo_free_kernel(&blks_ecc->bo,
+			&blks_ecc->mc_addr, &blks_ecc->cpu_addr);
+
+		memset(blks_ecc, 0, sizeof(*blks_ecc));
+	}
+
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.h b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.h
index addc693c2926..ae7bf67b3a3b 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.h
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.h
@@ -30,8 +30,17 @@ struct remote_batch_trace_mgr {
 	struct ras_cmd_batch_trace_record_rsp  batch_trace;
 };
 
+struct vram_blocks_ecc {
+	struct amdgpu_bo *bo;
+	uint64_t mc_addr;
+	void *cpu_addr;
+	uint32_t size;
+	bool auto_update_actived;
+};
+
 struct amdgpu_virt_ras_cmd {
 	struct remote_batch_trace_mgr batch_mgr;
+	struct vram_blocks_ecc blocks_ecc;
 };
 
 int amdgpu_virt_ras_sw_init(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_cmd.h b/drivers/gpu/drm/amd/ras/rascore/ras_cmd.h
index 48a0715eb821..b9833812c31f 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_cmd.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_cmd.h
@@ -75,6 +75,8 @@ enum ras_cmd_id {
 	RAS_CMD__GET_CPER_RECORD,
 	RAS_CMD__GET_BATCH_TRACE_SNAPSHOT,
 	RAS_CMD__GET_BATCH_TRACE_RECORD,
+	RAS_CMD__GET_ALL_BLOCK_ECC_STATUS,
+	RAS_CMD__SET_CMD_AUTO_UPDATE,
 	RAS_CMD__SUPPORTED_MAX = RAS_CMD_ID_COMMON_END,
 };
 
@@ -411,6 +413,37 @@ struct ras_cmd_batch_trace_record_rsp {
 	struct ras_log_info records[RAS_CMD_MAX_TRACE_NUM];
 };
 
+struct ras_cmd_auto_update_req {
+	struct ras_cmd_dev_handle dev;
+	uint32_t mode;
+	uint32_t cmd_id;
+	uint64_t addr;
+	uint32_t len;
+	uint32_t reserved[5];
+};
+
+struct ras_cmd_auto_update_rsp {
+	uint32_t version;
+	uint32_t reserved[4];
+};
+
+struct ras_cmd_blocks_ecc_req {
+	struct ras_cmd_dev_handle dev;
+};
+
+struct ras_cmd_block_ecc {
+	uint32_t ce_count;
+	uint32_t ue_count;
+	uint32_t de_count;
+};
+
+#define MAX_RAS_BLOCK_NUM  20
+struct ras_cmd_blocks_ecc_rsp {
+	uint32_t version;
+	uint32_t reserved[5];
+	struct ras_cmd_block_ecc blocks[MAX_RAS_BLOCK_NUM];
+};
+
 #pragma pack(pop)
 
 int ras_cmd_init(struct ras_core_context *ras_core);
-- 
2.34.1

