Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A42CDE002
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 08:20:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89A6210E689;
	Thu, 25 Jun 2026 08:20:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uD+D6fJi";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010003.outbound.protection.outlook.com
 [52.101.193.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F7AA10E1F1
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 08:20:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZBp6FE8OBHXdFhj3gwHzvIZHRyXPnN3/gp2sa/USkL0XFYZWtESoEBLDsce9KBhkOEcaGVXwskl0JzImSmZoIBzit+YpzGzyipZ5Z5rHXcDt+j9IW6oL62rP5uRHh5n5dOLye+YgbexPMZ2TSFlAgzROA8LzYzFH3i3b4n5OEQwZxjyZlC3PCvwDkbSCC/fjQcyHTJWP4jPTT2ilqhMyTeWCdejq/4GFy6CZVroOf0+hhKyTRChmzWtVkRuQTN+QIPtmkKTcDbKMYwD0C26XCozamEbY8T6c35S6XzjqzpXf3IsRqkiDdgwObNKaCovoyMuRvbMLku9aOfa6EJ1LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDuEN861brzQijDoQFvXnEfd1kgo2UVjTF/LvuY+Jx8=;
 b=yNENit+ZN2KbaR00FUJYVHF010dG+8fF85vzdFMF1LtnHvG1uBM2S8JO9zQsnWg/eMqgt4IvASINgWctMtbU/unL3Yw/TP4DyzxRymbqS7aw043j7loXcdlt4p9knc3IaNb2jVSd59d9lyZDDwUQ7AkAoPEii3E5PdfSQZmeHAEqDTSCHRBjV8ezdXvr0D5X+0q498vyCZPQDOqrusK0z9Sqc6TZ0MGA2t8p95oXSZz2xpZUhEKNZFtkIPRT1tbp2VNzByaIy/l+8rbkxFzk8scDbt38LllKt7Eys5foqDByVXnIBsq3MlCn8mr9Mw9HOL4r+NBn5XyB3l6ewmy15g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pDuEN861brzQijDoQFvXnEfd1kgo2UVjTF/LvuY+Jx8=;
 b=uD+D6fJisyadRp132KnBHVUq2J/ZMwrB2+KsPMMQZhrDEW39PL1DB7p/5yyzoTBxEbjZBs9vPbamxw5LAhT8/QsMVpuWgqkfNBlEoPT5wIXMwj+tVyCDGx8Bc1NIArZoF+au8i5sZIqRTJDbxpZBRY1x6UsfJB5RInPGqqu+95o=
Received: from PH7P221CA0045.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::17)
 by DM3PR12MB9327.namprd12.prod.outlook.com (2603:10b6:0:42::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 08:20:13 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:510:33c:cafe::37) by PH7P221CA0045.outlook.office365.com
 (2603:10b6:510:33c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.16 via Frontend Transport; Thu,
 25 Jun 2026 08:20:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 08:20:12 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 03:20:09 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v3 02/44] drm/amdgpu: Drop legacy ACA log RAS error data code
Date: Thu, 25 Jun 2026 16:18:55 +0800
Message-ID: <f88722904ad5b3a2c0867ca9b479f8304983b373.1782373701.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <b5587fca5f57f8f352245edf2c76606ad3307923.1782373701.git.cesun102@amd.com>
References: <b5587fca5f57f8f352245edf2c76606ad3307923.1782373701.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|DM3PR12MB9327:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ea02aa3-1637-4813-8448-08ded292942b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|22082099003|11063799006|18002099003|56012099006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: jcgwfAMC6fMDSP7HUNsU4WGGnv4HUM2TSKabZmynw59FJGOvMFDLyZLZqpgfWGkJaVsjt3gCbJW2rFZ31AhxQ8mocBW6Fl1qtzSZpPVoe6UJJ66j2gIvF4qgOmr9PDlOfstoRXzpQnWVhAeC8G716miWWSnl+SJ7KR8ZPx8BB+uEf2nf/IpZ1iTkVLa7tMeDiPgUX7Ng95DAj9biHMKISeviMRjLDn4my3SH0dkf8iAIHHjbZiS7lO9oV8dOYgWXMOI8BW7g+HsaOUA2sPIeeoy6ZccQugrZQL97kPQ7e6PXGjb/W+1NEjiLADUO+KgB+RWQwMQt5j+0zrYZK6Barmxa8HtciWkquxgjSZ9s48rge83PPXwPbBKgTPDZ2/zoWTcAnmoQ4oc66pbOr26AVoiaEFxjrCOCfGFLvO/VrXhperkm0L319LguHFGbxsUNxeqhZ7UzFFT3wAc0JcxL83QNlfA1QmnuhWBjHyymN2MWDtbPlFlPonqBDN2fuJgq2fdxkcrkS8/RLBuvuyUatWwPX5CTXY7Gvdy5xv15mePBJfBuavBARElFZRRLPXH11djcUEhZWhgEwpa+WSyfq9JJwWYhcepuCzXocvELfn5TqvYk3acVu1I/BFiAJhs0WlKjuwN5mcCZhy/A98rTgg0+B2trPbkfOBBvSyA6k/Z8qDoQ9IcTMCJxSgZczZDGWZyQwL759+qKknRwfw1AWg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(22082099003)(11063799006)(18002099003)(56012099006)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tg2b3TA0ey1ZRZLyIDMSkIH0l4l7q4oXOzKRoSZmOf+Whwlrsle+hBX2BZkiKyWLG9DBotamdritYmuqapKWSo+lFi693H9g3EbL0NRcbmtWVQRlbrE3YwSU3tEzdsF1371QIUS+PIB/gScdjKk8H/dCJS0y2rVuYkvr77vFPf42yhb9jZgxZuiC2FzBxyhneeQkHUYY1lfqDNkFQ3WQeuOosEIazKyHz1OuB9P0sMKT9BAVt8m7b/dcBNFl32b8ht29jO6VgDKvkt5p1Hyy0QzdqqoadbuDWKd9/YJhLdgBSfDOZ7bABcwrAB4sSriM++rOrWbJ+1k+RbnZ7ccSvRKY1TMxDgdF4Cpdkfy+9mlrcAxJhSa3rQwZNKk1DNa+hA65dTqKZRVC8sLzTiuK4s731KlGEbi5kaNPbR8EZwtzVOVnU1eXy9j04mLWLN+9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 08:20:12.5226 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea02aa3-1637-4813-8448-08ded292942b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
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

The legacy code for parsing RAS error data from ACA logs is obsolete
and has been replaced by the unified RAS module

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 537 +-----------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h |   3 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |  34 +-
 3 files changed, 4 insertions(+), 570 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index 3f9b094e93a2..a5d053b20911 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -26,206 +26,6 @@
 #include "amdgpu_aca.h"
 #include "amdgpu_ras.h"
 
-#define ACA_BANK_HWID(type, hwid, mcatype) [ACA_HWIP_TYPE_##type] = {hwid, mcatype}
-
-typedef int bank_handler_t(struct aca_handle *handle, struct aca_bank *bank, enum aca_smu_type type, void *data);
-
-static struct aca_hwip aca_hwid_mcatypes[ACA_HWIP_TYPE_COUNT] = {
-	ACA_BANK_HWID(SMU,	0x01,	0x01),
-	ACA_BANK_HWID(PCS_XGMI, 0x50,	0x00),
-	ACA_BANK_HWID(UMC,	0x96,	0x00),
-};
-
-static void aca_banks_init(struct aca_banks *banks)
-{
-	if (!banks)
-		return;
-
-	memset(banks, 0, sizeof(*banks));
-	INIT_LIST_HEAD(&banks->list);
-}
-
-static int aca_banks_add_bank(struct aca_banks *banks, struct aca_bank *bank)
-{
-	struct aca_bank_node *node;
-
-	if (!bank)
-		return -EINVAL;
-
-	node = kvzalloc(sizeof(*node), GFP_KERNEL);
-	if (!node)
-		return -ENOMEM;
-
-	memcpy(&node->bank, bank, sizeof(*bank));
-
-	INIT_LIST_HEAD(&node->node);
-	list_add_tail(&node->node, &banks->list);
-
-	banks->nr_banks++;
-
-	return 0;
-}
-
-static void aca_banks_release(struct aca_banks *banks)
-{
-	struct aca_bank_node *node, *tmp;
-
-	if (list_empty(&banks->list))
-		return;
-
-	list_for_each_entry_safe(node, tmp, &banks->list, node) {
-		list_del(&node->node);
-		kvfree(node);
-		banks->nr_banks--;
-	}
-}
-
-static int aca_smu_get_valid_aca_count(struct amdgpu_device *adev, enum aca_smu_type type, u32 *count)
-{
-	struct amdgpu_aca *aca = &adev->aca;
-	const struct aca_smu_funcs *smu_funcs = aca->smu_funcs;
-
-	if (!count)
-		return -EINVAL;
-
-	if (!smu_funcs || !smu_funcs->get_valid_aca_count)
-		return -EOPNOTSUPP;
-
-	return smu_funcs->get_valid_aca_count(adev, type, count);
-}
-
-static struct aca_regs_dump {
-	const char *name;
-	int reg_idx;
-} aca_regs[] = {
-	{"CONTROL",		ACA_REG_IDX_CTL},
-	{"STATUS",		ACA_REG_IDX_STATUS},
-	{"ADDR",		ACA_REG_IDX_ADDR},
-	{"MISC",		ACA_REG_IDX_MISC0},
-	{"CONFIG",		ACA_REG_IDX_CONFIG},
-	{"IPID",		ACA_REG_IDX_IPID},
-	{"SYND",		ACA_REG_IDX_SYND},
-	{"DESTAT",		ACA_REG_IDX_DESTAT},
-	{"DEADDR",		ACA_REG_IDX_DEADDR},
-	{"CONTROL_MASK",	ACA_REG_IDX_CTL_MASK},
-};
-
-static void aca_smu_bank_dump(struct amdgpu_device *adev, int idx, int total, struct aca_bank *bank,
-			      struct ras_query_context *qctx)
-{
-	u64 event_id = qctx ? qctx->evid.event_id : RAS_EVENT_INVALID_ID;
-	int i;
-
-	if (adev->debug_disable_ce_logs &&
-	    bank->smu_err_type == ACA_SMU_TYPE_CE &&
-	    !ACA_BANK_ERR_IS_DEFFERED(bank))
-		return;
-
-	RAS_EVENT_LOG(adev, event_id, HW_ERR "Accelerator Check Architecture events logged\n");
-	/* plus 1 for output format, e.g: ACA[08/08]: xxxx */
-	for (i = 0; i < ARRAY_SIZE(aca_regs); i++)
-		RAS_EVENT_LOG(adev, event_id, HW_ERR "ACA[%02d/%02d].%s=0x%016llx\n",
-			      idx + 1, total, aca_regs[i].name, bank->regs[aca_regs[i].reg_idx]);
-
-	if (ACA_REG__STATUS__SCRUB(bank->regs[ACA_REG_IDX_STATUS]))
-		RAS_EVENT_LOG(adev, event_id, HW_ERR "hardware error logged by the scrubber\n");
-}
-
-static bool aca_bank_hwip_is_matched(struct aca_bank *bank, enum aca_hwip_type type)
-{
-
-	struct aca_hwip *hwip;
-	int hwid, mcatype;
-	u64 ipid;
-
-	if (!bank || type == ACA_HWIP_TYPE_UNKNOW)
-		return false;
-
-	hwip = &aca_hwid_mcatypes[type];
-	if (!hwip->hwid)
-		return false;
-
-	ipid = bank->regs[ACA_REG_IDX_IPID];
-	hwid = ACA_REG__IPID__HARDWAREID(ipid);
-	mcatype = ACA_REG__IPID__MCATYPE(ipid);
-
-	return hwip->hwid == hwid && hwip->mcatype == mcatype;
-}
-
-static int aca_smu_get_valid_aca_banks(struct amdgpu_device *adev, enum aca_smu_type type,
-				       int start, int count,
-				       struct aca_banks *banks, struct ras_query_context *qctx)
-{
-	struct amdgpu_aca *aca = &adev->aca;
-	const struct aca_smu_funcs *smu_funcs = aca->smu_funcs;
-	struct aca_bank bank;
-	int i, max_count, ret;
-
-	if (!count)
-		return 0;
-
-	if (!smu_funcs || !smu_funcs->get_valid_aca_bank)
-		return -EOPNOTSUPP;
-
-	switch (type) {
-	case ACA_SMU_TYPE_UE:
-		max_count = smu_funcs->max_ue_bank_count;
-		break;
-	case ACA_SMU_TYPE_CE:
-		max_count = smu_funcs->max_ce_bank_count;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	if (start + count > max_count)
-		return -EINVAL;
-
-	count = min_t(int, count, max_count);
-	for (i = 0; i < count; i++) {
-		memset(&bank, 0, sizeof(bank));
-		ret = smu_funcs->get_valid_aca_bank(adev, type, start + i, &bank);
-		if (ret)
-			return ret;
-
-		bank.smu_err_type = type;
-
-		/*
-		 * Poison being consumed when injecting a UE while running background workloads,
-		 * which are unexpected.
-		 */
-		if (type == ACA_SMU_TYPE_UE &&
-		    ACA_REG__STATUS__POISON(bank.regs[ACA_REG_IDX_STATUS]) &&
-		    !aca_bank_hwip_is_matched(&bank, ACA_HWIP_TYPE_UMC))
-			continue;
-
-		aca_smu_bank_dump(adev, i, count, &bank, qctx);
-
-		ret = aca_banks_add_bank(banks, &bank);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
-static bool aca_bank_is_valid(struct aca_handle *handle, struct aca_bank *bank, enum aca_smu_type type)
-{
-	const struct aca_bank_ops *bank_ops = handle->bank_ops;
-
-	/* Parse all deferred errors with UMC aca handle */
-	if (ACA_BANK_ERR_IS_DEFFERED(bank))
-		return handle->hwip == ACA_HWIP_TYPE_UMC;
-
-	if (!aca_bank_hwip_is_matched(bank, handle->hwip))
-		return false;
-
-	if (!bank_ops->aca_bank_is_valid)
-		return true;
-
-	return bank_ops->aca_bank_is_valid(handle, bank, type, handle->data);
-}
-
 static struct aca_bank_error *new_bank_error(struct aca_error *aerr, struct aca_bank_info *info)
 {
 	struct aca_bank_error *bank_error;
@@ -315,303 +115,6 @@ int aca_error_cache_log_bank_error(struct aca_handle *handle, struct aca_bank_in
 	return 0;
 }
 
-static int aca_bank_parser(struct aca_handle *handle, struct aca_bank *bank, enum aca_smu_type type)
-{
-	const struct aca_bank_ops *bank_ops = handle->bank_ops;
-
-	if (!bank)
-		return -EINVAL;
-
-	if (!bank_ops->aca_bank_parser)
-		return -EOPNOTSUPP;
-
-	return bank_ops->aca_bank_parser(handle, bank, type,
-					 handle->data);
-}
-
-static int handler_aca_log_bank_error(struct aca_handle *handle, struct aca_bank *bank,
-				      enum aca_smu_type type, void *data)
-{
-	int ret;
-
-	ret = aca_bank_parser(handle, bank, type);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
-static int aca_dispatch_bank(struct aca_handle_manager *mgr, struct aca_bank *bank,
-			     enum aca_smu_type type, bank_handler_t handler, void *data)
-{
-	struct aca_handle *handle;
-	int ret;
-
-	if (list_empty(&mgr->list))
-		return 0;
-
-	list_for_each_entry(handle, &mgr->list, node) {
-		if (!aca_bank_is_valid(handle, bank, type))
-			continue;
-
-		ret = handler(handle, bank, type, data);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
-static int aca_dispatch_banks(struct aca_handle_manager *mgr, struct aca_banks *banks,
-			      enum aca_smu_type type, bank_handler_t handler, void *data)
-{
-	struct aca_bank_node *node;
-	struct aca_bank *bank;
-	int ret;
-
-	if (!mgr || !banks)
-		return -EINVAL;
-
-	/* pre check to avoid unnecessary operations */
-	if (list_empty(&mgr->list) || list_empty(&banks->list))
-		return 0;
-
-	list_for_each_entry(node, &banks->list, node) {
-		bank = &node->bank;
-
-		ret = aca_dispatch_bank(mgr, bank, type, handler, data);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
-static bool aca_bank_should_update(struct amdgpu_device *adev, enum aca_smu_type type)
-{
-	struct amdgpu_aca *aca = &adev->aca;
-	bool ret = true;
-
-	/*
-	 * Because the UE Valid MCA count will only be cleared after reset,
-	 * in order to avoid repeated counting of the error count,
-	 * the aca bank is only updated once during the gpu recovery stage.
-	 */
-	if (type == ACA_SMU_TYPE_UE) {
-		if (amdgpu_ras_intr_triggered())
-			ret = atomic_cmpxchg(&aca->ue_update_flag, 0, 1) == 0;
-		else
-			atomic_set(&aca->ue_update_flag, 0);
-	}
-
-	return ret;
-}
-
-static void aca_banks_generate_cper(struct amdgpu_device *adev,
-				    enum aca_smu_type type,
-				    struct aca_banks *banks,
-				    int count)
-{
-	struct aca_bank_node *node;
-	struct aca_bank *bank;
-	int r;
-
-	if (!adev->cper.enabled)
-		return;
-
-	if (!banks || !count) {
-		dev_warn(adev->dev, "fail to generate cper records\n");
-		return;
-	}
-
-	/* UEs must be encoded into separate CPER entries */
-	if (type == ACA_SMU_TYPE_UE) {
-		struct aca_banks de_banks;
-
-		aca_banks_init(&de_banks);
-		list_for_each_entry(node, &banks->list, node) {
-			bank = &node->bank;
-			if (bank->aca_err_type == ACA_ERROR_TYPE_DEFERRED) {
-				r = aca_banks_add_bank(&de_banks, bank);
-				if (r)
-					dev_warn(adev->dev, "fail to add de banks, ret = %d\n", r);
-			} else {
-				if (amdgpu_cper_generate_ue_record(adev, bank))
-					dev_warn(adev->dev, "fail to generate ue cper records\n");
-			}
-		}
-
-		if (!list_empty(&de_banks.list)) {
-			if (amdgpu_cper_generate_ce_records(adev, &de_banks, de_banks.nr_banks))
-				dev_warn(adev->dev, "fail to generate de cper records\n");
-		}
-
-		aca_banks_release(&de_banks);
-	} else {
-		/*
-		 * SMU_TYPE_CE banks are combined into 1 CPER entries,
-		 * they could be CEs or DEs or both
-		 */
-		if (amdgpu_cper_generate_ce_records(adev, banks, count))
-			dev_warn(adev->dev, "fail to generate ce cper records\n");
-	}
-}
-
-static int aca_banks_update(struct amdgpu_device *adev, enum aca_smu_type type,
-			    bank_handler_t handler, struct ras_query_context *qctx, void *data)
-{
-	struct amdgpu_aca *aca = &adev->aca;
-	struct aca_banks banks;
-	u32 count = 0;
-	int ret;
-
-	if (list_empty(&aca->mgr.list))
-		return 0;
-
-	if (!aca_bank_should_update(adev, type))
-		return 0;
-
-	ret = aca_smu_get_valid_aca_count(adev, type, &count);
-	if (ret)
-		return ret;
-
-	if (!count)
-		return 0;
-
-	aca_banks_init(&banks);
-
-	ret = aca_smu_get_valid_aca_banks(adev, type, 0, count, &banks, qctx);
-	if (ret)
-		goto err_release_banks;
-
-	if (list_empty(&banks.list)) {
-		ret = 0;
-		goto err_release_banks;
-	}
-
-	ret = aca_dispatch_banks(&aca->mgr, &banks, type,
-				 handler, data);
-	if (ret)
-		goto err_release_banks;
-
-	aca_banks_generate_cper(adev, type, &banks, count);
-
-err_release_banks:
-	aca_banks_release(&banks);
-
-	return ret;
-}
-
-static int aca_log_aca_error_data(struct aca_bank_error *bank_error, enum aca_error_type type, struct ras_err_data *err_data)
-{
-	struct aca_bank_info *info;
-	struct amdgpu_smuio_mcm_config_info mcm_info;
-	u64 count;
-
-	if (type >= ACA_ERROR_TYPE_COUNT)
-		return -EINVAL;
-
-	count = bank_error->count;
-	if (!count)
-		return 0;
-
-	info = &bank_error->info;
-	mcm_info.die_id = info->die_id;
-	mcm_info.socket_id = info->socket_id;
-
-	switch (type) {
-	case ACA_ERROR_TYPE_UE:
-		amdgpu_ras_error_statistic_ue_count(err_data, &mcm_info, count);
-		break;
-	case ACA_ERROR_TYPE_CE:
-		amdgpu_ras_error_statistic_ce_count(err_data, &mcm_info, count);
-		break;
-	case ACA_ERROR_TYPE_DEFERRED:
-		amdgpu_ras_error_statistic_de_count(err_data, &mcm_info, count);
-		break;
-	default:
-		break;
-	}
-
-	return 0;
-}
-
-static int aca_log_aca_error(struct aca_handle *handle, enum aca_error_type type, struct ras_err_data *err_data)
-{
-	struct aca_error_cache *error_cache = &handle->error_cache;
-	struct aca_error *aerr = &error_cache->errors[type];
-	struct aca_bank_error *bank_error, *tmp;
-
-	mutex_lock(&aerr->lock);
-
-	if (list_empty(&aerr->list))
-		goto out_unlock;
-
-	list_for_each_entry_safe(bank_error, tmp, &aerr->list, node) {
-		aca_log_aca_error_data(bank_error, type, err_data);
-		aca_bank_error_remove(aerr, bank_error);
-	}
-
-out_unlock:
-	mutex_unlock(&aerr->lock);
-
-	return 0;
-}
-
-static int __aca_get_error_data(struct amdgpu_device *adev, struct aca_handle *handle, enum aca_error_type type,
-				struct ras_err_data *err_data, struct ras_query_context *qctx)
-{
-	enum aca_smu_type smu_type;
-	int ret;
-
-	switch (type) {
-	case ACA_ERROR_TYPE_UE:
-		smu_type = ACA_SMU_TYPE_UE;
-		break;
-	case ACA_ERROR_TYPE_CE:
-	case ACA_ERROR_TYPE_DEFERRED:
-		smu_type = ACA_SMU_TYPE_CE;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	/* update aca bank to aca source error_cache first */
-	ret = aca_banks_update(adev, smu_type, handler_aca_log_bank_error, qctx, NULL);
-	if (ret)
-		return ret;
-
-	/* DEs may contain in CEs or UEs */
-	if (type != ACA_ERROR_TYPE_DEFERRED)
-		aca_log_aca_error(handle, ACA_ERROR_TYPE_DEFERRED, err_data);
-
-	return aca_log_aca_error(handle, type, err_data);
-}
-
-static bool aca_handle_is_valid(struct aca_handle *handle)
-{
-	if (!handle->mask || !list_empty(&handle->node))
-		return false;
-
-	return true;
-}
-
-int amdgpu_aca_get_error_data(struct amdgpu_device *adev, struct aca_handle *handle,
-			      enum aca_error_type type, struct ras_err_data *err_data,
-			      struct ras_query_context *qctx)
-{
-	if (!handle || !err_data)
-		return -EINVAL;
-
-	if (aca_handle_is_valid(handle))
-		return -EOPNOTSUPP;
-
-	if ((type < 0) || (!(BIT(type) & handle->mask)))
-		return  0;
-
-	return __aca_get_error_data(adev, handle, type, err_data, qctx);
-}
-
 static void aca_error_init(struct aca_error *aerr, enum aca_error_type type)
 {
 	mutex_init(&aerr->lock);
@@ -890,47 +393,9 @@ static int amdgpu_aca_smu_debug_mode_set(void *data, u64 val)
 	return 0;
 }
 
-static void aca_dump_entry(struct seq_file *m, struct aca_bank *bank, enum aca_smu_type type, int idx)
-{
-	struct aca_bank_info info;
-	int i, ret;
-
-	ret = aca_bank_info_decode(bank, &info);
-	if (ret)
-		return;
-
-	seq_printf(m, "aca entry[%d].type: %s\n", idx, type ==  ACA_SMU_TYPE_UE ? "UE" : "CE");
-	seq_printf(m, "aca entry[%d].info: socketid:%d aid:%d hwid:0x%03x mcatype:0x%04x\n",
-		   idx, info.socket_id, info.die_id, info.hwid, info.mcatype);
-
-	for (i = 0; i < ARRAY_SIZE(aca_regs); i++)
-		seq_printf(m, "aca entry[%d].regs[%d]: 0x%016llx\n", idx, aca_regs[i].reg_idx, bank->regs[aca_regs[i].reg_idx]);
-}
-
-struct aca_dump_context {
-	struct seq_file *m;
-	int idx;
-};
-
-static int handler_aca_bank_dump(struct aca_handle *handle, struct aca_bank *bank,
-				 enum aca_smu_type type, void *data)
-{
-	struct aca_dump_context *ctx = (struct aca_dump_context *)data;
-
-	aca_dump_entry(ctx->m, bank, type, ctx->idx++);
-
-	return handler_aca_log_bank_error(handle, bank, type, NULL);
-}
-
 static int aca_dump_show(struct seq_file *m, enum aca_smu_type type)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
-	struct aca_dump_context context = {
-		.m = m,
-		.idx = 0,
-	};
-
-	return aca_banks_update(adev, type, handler_aca_bank_dump, NULL, (void *)&context);
+	return 0;
 }
 
 static int aca_dump_ce_show(struct seq_file *m, void *unused)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
index 38c88897e1ec..93a70a350f34 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
@@ -222,9 +222,6 @@ int aca_bank_check_error_codes(struct amdgpu_device *adev, struct aca_bank *bank
 int amdgpu_aca_add_handle(struct amdgpu_device *adev, struct aca_handle *handle,
 			  const char *name, const struct aca_info *aca_info, void *data);
 void amdgpu_aca_remove_handle(struct aca_handle *handle);
-int amdgpu_aca_get_error_data(struct amdgpu_device *adev, struct aca_handle *handle,
-			      enum aca_error_type type, struct ras_err_data *err_data,
-			      struct ras_query_context *qctx);
 int amdgpu_aca_smu_set_debug_mode(struct amdgpu_device *adev, bool en);
 void amdgpu_aca_smu_debugfs_init(struct amdgpu_device *adev, struct dentry *root);
 int aca_error_cache_log_bank_error(struct aca_handle *handle, struct aca_bank_info *info,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 8095f284d531..098731cf2bf4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1414,19 +1414,6 @@ int amdgpu_ras_unbind_aca(struct amdgpu_device *adev, enum amdgpu_ras_block blk)
 	return 0;
 }
 
-static int amdgpu_aca_log_ras_error_data(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
-					 enum aca_error_type type, struct ras_err_data *err_data,
-					 struct ras_query_context *qctx)
-{
-	struct ras_manager *obj;
-
-	obj = get_ras_manager(adev, blk);
-	if (!obj)
-		return -EINVAL;
-
-	return amdgpu_aca_get_error_data(adev, &obj->aca_handle, type, err_data, qctx);
-}
-
 ssize_t amdgpu_ras_aca_sysfs_read(struct device *dev, struct device_attribute *attr,
 				  struct aca_handle *handle, char *buf, void *data)
 {
@@ -1453,7 +1440,6 @@ static int amdgpu_ras_query_error_status_helper(struct amdgpu_device *adev,
 {
 	enum amdgpu_ras_block blk = info ? info->head.block : AMDGPU_RAS_BLOCK_COUNT;
 	struct amdgpu_ras_block_object *block_obj = NULL;
-	int ret;
 
 	if (blk == AMDGPU_RAS_BLOCK_COUNT)
 		return -EINVAL;
@@ -1485,23 +1471,9 @@ static int amdgpu_ras_query_error_status_helper(struct amdgpu_device *adev,
 			}
 		}
 	} else {
-		if (amdgpu_aca_is_enabled(adev)) {
-			ret = amdgpu_aca_log_ras_error_data(adev, blk, ACA_ERROR_TYPE_UE, err_data, qctx);
-			if (ret)
-				return ret;
-
-			ret = amdgpu_aca_log_ras_error_data(adev, blk, ACA_ERROR_TYPE_CE, err_data, qctx);
-			if (ret)
-				return ret;
-
-			ret = amdgpu_aca_log_ras_error_data(adev, blk, ACA_ERROR_TYPE_DEFERRED, err_data, qctx);
-			if (ret)
-				return ret;
-		} else {
-			/* FIXME: add code to check return value later */
-			amdgpu_mca_smu_log_ras_error(adev, blk, AMDGPU_MCA_ERROR_TYPE_UE, err_data, qctx);
-			amdgpu_mca_smu_log_ras_error(adev, blk, AMDGPU_MCA_ERROR_TYPE_CE, err_data, qctx);
-		}
+		/* FIXME: add code to check return value later */
+		amdgpu_mca_smu_log_ras_error(adev, blk, AMDGPU_MCA_ERROR_TYPE_UE, err_data, qctx);
+		amdgpu_mca_smu_log_ras_error(adev, blk, AMDGPU_MCA_ERROR_TYPE_CE, err_data, qctx);
 	}
 
 	return 0;
-- 
2.34.1

