Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F50CDB46B
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 04:41:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91AF610E45D;
	Mon, 22 Jun 2026 04:41:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O7ZxroPE";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010034.outbound.protection.outlook.com [52.101.201.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3B5610E45D
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 04:41:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u1idg2JYB731u1Zf85mhpil68F0JC4TC9zqfEBQRipyyExJORcRb4kNsV3fErXGG9rn28WCInnpX2exraP6vpkotWCQwggDiDirItyICJ3riZQnml/o8IPuVFsAAkdxYksuGhLAFZFstKN/oqrQ13vAx7YfBI/ESFbD+M4POI8G7+EvXj2WXM0cFyaF4KcBtNMEjLhknvFTBRA+N2R9orAS44Tbwqif3KmaOqon3kwuTkz0Fz3pPT3m07J7LtmvkHVQluJVo4YG+oi6nemAH1s1l2FiZO0sq/0x8SCLedLNISKW52NeHQZV5LSUd+ff6aIVb08WoUnhfNsp+RihQHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDuEN861brzQijDoQFvXnEfd1kgo2UVjTF/LvuY+Jx8=;
 b=jz0QJW5OP6BIRmK0nUQ1sg9UYmuGeG25+bJ6T/4REeuvTXRSBgfzgm11kohuqraOgE69+N4msSZGgqoNgXnvRrBxetbBtoYdoAHUNGR/+KNN++9a2DvROLWgHaVyK6voez73bmPjEzx0vBa7ISBQBpnb8HJdn9oD6mE/Hh0KnQczjj4Morbd2e6uwm+RIGC7Fco7YLKQ24/76/ythOa2/ak5LSFKP+7jX3DNpsdjeXTICmq42bBj7QJrcbjjjg3v9+YX88b7PCT6kyNCma7U1F5RwGvzIDoZQVyvi1kx0rPVbzeWHrCTQszIgmyIy4c2X1CZqXUZsLyP5Dqd83yrbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pDuEN861brzQijDoQFvXnEfd1kgo2UVjTF/LvuY+Jx8=;
 b=O7ZxroPEoYnDHBgwnueLpPnBKO6HV8Tmjenui5qRONUpRKX95qVtQlQGLJTsuo8o6eWsQC5XkVMXKnJnZBnI0ueMEb4+KG5v8L3QXdDtMHLlHUl4l4G17qHbpNNtAJL8s+hK60nTMstLMoApX0S9DIdk0SvJnyeVeqoO2DJuN1o=
Received: from MN0PR02CA0001.namprd02.prod.outlook.com (2603:10b6:208:530::21)
 by MN0PR12MB6127.namprd12.prod.outlook.com (2603:10b6:208:3c5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 04:41:50 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:208:530:cafe::98) by MN0PR02CA0001.outlook.office365.com
 (2603:10b6:208:530::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 04:41:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 04:41:50 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 21 Jun
 2026 23:41:48 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>, "Ce
 Sun" <cesun102@amd.com>
Subject: [PATCH v1 02/48] drm/amdgpu: Drop legacy ACA log RAS error data code
Date: Mon, 22 Jun 2026 12:39:51 +0800
Message-ID: <d7bd2b82fc600504f17c59d635c11ddd416df179.1782103073.git.cesun102@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|MN0PR12MB6127:EE_
X-MS-Office365-Filtering-Correlation-Id: d069b696-a18f-4832-b663-08ded018933a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|376014|36860700016|18002099003|22082099003|6133799003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: RMtpzqNQnTVpLFcm7EjhcLVH4OQJ+4BxF/AXIueo05WjBP6KHvWyqm0F17DdmeGygMBv7Gayj3OM+qLW8zZ55b+EkoCEPy2tA26QekEOqTEAHmIyP/jagIuqvRdRsZH3wm5RykP1mxZQP9D7//Y4G+sFWx/5VuLS83JfpXM9WKFEZQIQpj9RpFMYL6suhveKhKGcXRNcXSGTUzRdHsZ+/+QvYVmt5AXuYyq7pttzlJZWJbjwF8NNTXEm/jRVKN2ZsO5wfcN4bbJgmNzKJEreDL70809NcneZ4hTZPvkOMccNw90/A1liQTjKvJV9F0yj4vvW9+V8uOwsPewSdOQ7TszyLBWXQ0FfhhEoXx9r6oJ6dXRVZTD0+mCFaQFwaSuSxmEqfP1aUtEWQqLV+WerxzrwtGLkbrrb84m1fB6wk1qu0z1CAGmZTe0jFaOy9k5L8dpodLJmSuJRskBpIHVTpiGgIpsAWf/mnsoq5gDE6EEBa8UbqWG11mQoVre3lHIopqBEq4WsNJzn7i5WLh084hdIO0U/0/O2nkbz4UBWjYfNr8XOABjpt/xSsKYeF/GaQeUjObG4WT/ArSqm3fLtFrnYmb/t0mhRDdF62JRMJs0uVXFWDiRib4FW0sdY0Q2YC9xuf/hqjg7zjvEhOtA9kMoPdowjlMjDrHJLGH4uOzuPRp6LzMtuaFK50ZOoXpbVo6Wa2QYcDP4mQ8ZRfeDgEg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(376014)(36860700016)(18002099003)(22082099003)(6133799003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OIoWrqZI9t33CAmGvsZs/fPNPyxNQD1szanYdqjg8TZizjfv+xg50XtNyMU79VuPSXusZsjX5YXTPVVd3VG786SNbaOWX+TLVTYY4g9868lhle92sLKCOu5ax4RpP8EmR/a3TERYrm5cwPpD8BCSopAoYVBVMisCjjXoAA/vMkhETYeP4EOdu5RsDjPdpmbVDT7XikBgID4L2yTDqby6Q54YflbClqhhSlQFdDKlYYgZUCXksNRZQltk90EDklR3k4CcTcqz4nP7msntm56JzVzIFTGiGsrk0Y8FPwAvAkVgYxVSC4hrCVji5OogK9ybmZiHeirGXljqN824rld6dmIwsOsJe1OGwoNwCIHjSkyfgNy3BHNvP7O27W0OjBwnStZw9Na5m0GXFCsmAkORQh7iggUgmOC471I5rN7uIcACCzIKzHVt6x5Z5BAzBoTy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 04:41:50.0650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d069b696-a18f-4832-b663-08ded018933a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6127
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

