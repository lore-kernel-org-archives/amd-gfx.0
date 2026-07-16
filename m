Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A57AC4450A
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2026 09:27:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB38010F250;
	Thu, 16 Jul 2026 09:27:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aPP/KXPZ";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013066.outbound.protection.outlook.com
 [40.93.196.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B39410E765
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2026 09:27:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QDOGzmi8N5sf7Nolh8zU400r1ybvAp3jeD7uTPshbcpMd2PMViCOXP/vR4S7WhbaqLJYy0f0YSsgntimsSrJUsZKaRpo3aMb/vXDAhkoXgHHOBfrXUnAjfkzEo6B0nW3vy6Z93a5l5l/jD9WDyOVVrofgdSy3NQfffqeVqHVPoHRx0iQcz5dyaO5ACXKhQbbAOu2+eidBWnehlybWVmyNr35PswxUA1THplqqIQZ8H6khLEOXO9kc9b90extNUtaNc0r7ReoBVr2uncpSdpcRfggmIkRsbuPJvo6aRf9EfQMullPXVR8ibWhFYJRucG2Z5IZAsQwpFa8SkwIAGjuAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5lh80ewdYSKbHuDwv2yOcoqmWm3wnXKNE6EZdFFsTS0=;
 b=n3gkJTW4HxNYIADQ0iawZuFbTQl5EyWc3Amr+r+pb6WUGj9vhpbd2cpP4j67uOAN3/QGxl9JDw1SovjGTifxgchlxJgbBuNdhWEb7zk/ratfbyOifgWpce9yS7yzHabjFfZ8SI574tk/fIpc7ujUOa6TS0CbEIuyFXV+kjOxxuDnbvi0bBfk+O+jVphE00Ca4oIKI3LQwn9aiSW6V6OItJXKYVF5pGD6oeIDwtDJG63CWtupOxLHnS/s6SZR7NFewQzdNp0uVdw5uGTr3g7HMKuZ2iWS/OH56EKSBZqOioozv6q3wN9JMIEbggfVagq8whlVXqgWdjzkUpFCbontXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lh80ewdYSKbHuDwv2yOcoqmWm3wnXKNE6EZdFFsTS0=;
 b=aPP/KXPZ7SWjPeF342GuVuOGpWsALdk+rBkhoFoc92cJTWvR9yzTp+v12S1vDYSqhrjInvqwh0mp4XZk6UP/tTxlj1u8QFn/EDxG79lRmP9+smAP+2d1vqswOWXUDcdI0y93frr4AD8uO91P09PQb6cC8Fez2pcCILjaaOgmqtQ=
Received: from PH8P221CA0065.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:349::13)
 by PH7PR12MB5998.namprd12.prod.outlook.com (2603:10b6:510:1da::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Thu, 16 Jul
 2026 09:27:13 +0000
Received: from SN1PEPF00036F3C.namprd05.prod.outlook.com
 (2603:10b6:510:349:cafe::3d) by PH8P221CA0065.outlook.office365.com
 (2603:10b6:510:349::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 09:27:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F3C.mail.protection.outlook.com (10.167.248.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Thu, 16 Jul 2026 09:27:12 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 16 Jul
 2026 04:27:10 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH V4] drm/amdgpu/ras: Add debug mask to disable CE logs for
 uniras
Date: Thu, 16 Jul 2026 17:26:56 +0800
Message-ID: <20260716092656.1057364-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3C:EE_|PH7PR12MB5998:EE_
X-MS-Office365-Filtering-Correlation-Id: b55c6f6b-e38b-4dec-ea02-08dee31c6aeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|11063799006|56012099006|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: qeiWTOxffm0CGEI33GDVd044OAp9fDBAHmnFA4sfCJ7aE0bC30IEjk9yFq6telRco3r493mmdYZeq4csZ6kmsSxcfwbtwhvmpUNOrkJbNHGuKuufj6rFK8i3to9s48DgspiTiwXj6WCTC4q44bCBTqKqxfhwalOqGT4dnqMZmeh952nel85EobGcsemwxhr5ZM0d+HoWQdF62pIFf4WwopoPbrtYML49Bk34VK2EvgY8mKiEUJ6VuOiUbdTOSMKZkQRWZ/aTe7GvlCQ3fp1oNDxUPuco/EInn0bzzfhsBJKtPTImMMOjtMJpru06AMJ2Tqg73Uo/NNEd1NQzoXrzlYR0HL7G/lxZHhrvKCQKMM+J16pBdrg5KhBO6dp8bh3BcFYO3dEhSAfOlIVEvBX4r28rnMYu16RkfMDK3hRSMYe5HrUX0/SDRQ5Q41QKDkfLTNye5BAyd0lrnU82ZN8fLrdEJri+PWWh+9Xrb3NxE51drBBF367JmC/9XZF/hYDX9ih/q1ZpdpltRvLAJX4LbzzZMHjVSdmt9s9o1oVNb4V70z9A913sfIeXUAtEOJ19zPrLNYWEb8MyqcM1XEKUy5QU0D+LW+P30Erw6Eeo4ZtDTZOkT8ezeAh/t3WcfavIq+aC5uj2JgDUUAaPm9VQ4E/A6o2j1EjN1CncITU62XxzMbog0f5wOTIotlH+Y0UhTX8y3/OLNAi3rot7YgE9FA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(11063799006)(56012099006)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ph3hDbibuZLFtYHi/OfpjiuKoRa4Yly/fp1eoSrGjmUjC8FUSyjuciXoM7MgVtsujI2udhrspggVKc2pghs5Gj+Ry1kALInawXODY3o0QoJ/MQRT+U6Z5C0wIg3IEDypSiGw6plpwgYw1/lBAOfy7CnF+vwdsdnkntb3/dofG8IiHhT8GlWXjCXVcvy02jwNhsBbEfyRfsDddyw+1cGSuTOVSRajWB5f5ylhbZHKqf7Isz/jlwP7a4/q9SW3aIhKLOyR+IwvaOy4EM5A5oEAQ3bc6QdXzLB9N94d3FKxbFdICxVsnbVRBv82fqKtRPyOiDeQJYG3VD5P3CXh0f88FdoYv0kMOefFc2FBXv077fR3n8N5Za4JWY/bHj+IizSEpjioh8A+0YIJbrX0lvcSpBb7np121Oye3TbMQvZtr2WjR+vHcZB2QACjo9vnMGQO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 09:27:12.4975 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b55c6f6b-e38b-4dec-ea02-08dee31c6aeb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5998
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

Add debug mask to disable kernel logs of RAS correctable errors,
including both ACA and CE error counter kernel messages.

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h             |  1 +
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c    |  1 +
 drivers/gpu/drm/amd/ras/rascore/ras.h           |  2 ++
 drivers/gpu/drm/amd/ras/rascore/ras_aca.c       | 17 ++++++++++-------
 drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c  |  2 +-
 drivers/gpu/drm/amd/ras/rascore/ras_core.c      |  9 +++++++++
 6 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index a3dafdca7eb3..bc6b7da3914f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -226,6 +226,7 @@ extern int amdgpu_use_xgmi_p2p;
 extern bool pcie_p2p;
 extern int amdgpu_mtype_local;
 extern int amdgpu_enforce_isolation;
+extern uint amdgpu_debug_mask;
 #ifdef CONFIG_HSA_AMD
 extern int sched_policy;
 extern bool debug_evictions;
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index ea95e0f93d1c..0db755ba7037 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -309,6 +309,7 @@ static struct ras_core_context *amdgpu_ras_mgr_create_ras_core(struct amdgpu_dev
 		amdgpu_ras_mgr_eeprom_is_supported(adev);
 	init_config.poison_supported =
 		amdgpu_ras_is_poison_mode_supported(adev);
+	init_config.ras_debug_mask = amdgpu_debug_mask;
 
 	amdgpu_ras_mgr_init_aca_config(adev, &init_config);
 	amdgpu_ras_mgr_init_eeprom_config(adev, &init_config);
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras.h b/drivers/gpu/drm/amd/ras/rascore/ras.h
index 878dfdfcb18a..88b0bac158af 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras.h
@@ -301,6 +301,7 @@ struct ras_core_config {
 
 	bool poison_supported;
 	bool ras_eeprom_supported;
+	uint ras_debug_mask;
 	const struct ras_sys_func *sys_fn;
 
 	struct ras_aca_config aca_cfg;
@@ -403,4 +404,5 @@ int ras_core_convert_soc_pa_to_cur_nps_pages(struct ras_core_context *ras_core,
 int ras_core_check_address_sanity(struct ras_core_context *ras_core, uint64_t addr);
 
 int ras_core_set_debug_mode(struct ras_core_context *ras_core, bool enable);
+bool ras_core_is_ce_log_disabled(struct ras_core_context *ras_core);
 #endif
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_aca.c b/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
index 67a35409ff0e..a1fb9a5f72cf 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
@@ -83,22 +83,20 @@ static void aca_report_ecc_info(struct ras_core_context *ras_core,
 			seq_no, skt, aid, ecc_count.total_ue_count, blk_name(blk));
 	}
 
-	if (ecc_count.new_de_count) {
+	if (ecc_count.new_de_count && blk == RAS_BLOCK_ID__UMC) {
 		RAS_DEV_INFO(ras_core->dev,
-		"{%llu} socket: %d, die: %d, %u new %s detected in %s block\n",
+		"{%llu} socket: %d, die: %d, %u new deferred hardware errors detected in %s block\n",
 			seq_no, skt, aid, ecc_count.new_de_count,
-			(blk == RAS_BLOCK_ID__UMC) ?
-				"deferred hardware errors" : "poison consumption",
 			blk_name(blk));
 		RAS_DEV_INFO(ras_core->dev,
-		"{%llu} socket: %d, die: %d, %u %s detected in total in %s block\n",
+		"{%llu} socket: %d, die: %d, %u deferred hardware errors detected in total in %s block\n",
 			seq_no, skt, aid, ecc_count.total_de_count,
-			(blk == RAS_BLOCK_ID__UMC) ?
-				"deferred hardware errors" : "poison consumption",
 			blk_name(blk));
 	}
 
 	if (ecc_count.new_ce_count) {
+		if (ras_core_is_ce_log_disabled(ras_core))
+			return;
 		RAS_DEV_INFO(ras_core->dev,
 		"{%llu} socket: %d, die: %d, %u new correctable hardware errors detected in %s block\n",
 			seq_no, skt, aid, ecc_count.new_ce_count, blk_name(blk));
@@ -114,6 +112,11 @@ static void aca_bank_log(struct ras_core_context *ras_core,
 {
 	int i;
 
+	if(ras_core_is_ce_log_disabled(ras_core) &&
+	   bank->ecc_type == RAS_ERR_TYPE__CE &&
+	   !bank_ecc->de_count)
+		return;
+
 	RAS_DEV_INFO(ras_core->dev,
 		"{%llu}" RAS_HW_ERR "Accelerator Check Architecture events logged\n",
 		bank->seq_no);
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c b/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c
index 840610538c1f..288fad0862a2 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c
@@ -265,7 +265,7 @@ static int aca_parse_bank_default(struct ras_core_context *ras_core,
 	ecc->bank_info.addr = bank->regs[ACA_REG_IDX__ADDR];
 
 	if (aca_check_bank_is_de(ras_core, status)) {
-		ecc->de_count = 0;
+		ecc->de_count = 1;
 	} else {
 		if (bank->ecc_type == RAS_ERR_TYPE__UE)
 			ecc->ue_count = 1;
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
index 08e17a83ad5b..c90db914aa5f 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
@@ -28,6 +28,10 @@
 
 #define IS_LEAP_YEAR(x) ((x % 4 == 0 && x % 100 != 0) || x % 400 == 0)
 
+enum RAS_DEBUG_MASK {
+	RAS_DEBUG_DISABLE_RAS_CE_LOG = 9,
+};
+
 static const char * const ras_block_name[] = {
 	"umc",
 	"sdma",
@@ -545,6 +549,11 @@ bool ras_core_is_enabled(struct ras_core_context *ras_core)
 	return ras_core->ras_core_enabled;
 }
 
+bool ras_core_is_ce_log_disabled(struct ras_core_context *ras_core)
+{
+	return !!(ras_core->config->ras_debug_mask & BIT(RAS_DEBUG_DISABLE_RAS_CE_LOG));
+}
+
 uint64_t ras_core_get_utc_second_timestamp(struct ras_core_context *ras_core)
 {
 	if (!ras_core)
-- 
2.34.1

