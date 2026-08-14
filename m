Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 189ACC5CFCF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F64A10F729;
	Fri, 14 Aug 2026 21:03:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kvCGZ8l+";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012027.outbound.protection.outlook.com [40.107.209.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 570B710F710
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fUwVtcOYk1njj2J6u7vqsTYK+7a0RvN+rAiGY95OOb+qjPZbvcM+CEi/O1o/VfyI92Bb+Jx8Eyy9Uty+XQJQ6F8W03D+StTJz//QRNhs2j4ziERHnJ+gL4dGLAguVoe4Qc+ngSaGuwIqo2pPi3sip+5l9HXM+1FrujHbJhRCTgN+7YZ6dYM0MYDEf7jBXMjpke+IQu8GlsyyKKMprfB6SVkjfujfhUX992SGBGGJ+4vt7G0fCb1uoiiiw0K+gfEBjWhsHt67elzNGB6wP86VHiKnY4wZYWw5F8DPG0D+XGYEQ1ER6zObfo5rlcodirHifgXfBxYaGXnvdv0Kk9goCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yOw4qGC0Ljft0Mq91iaH2NCSBSwMFg6tlnTWbBbj+Ts=;
 b=T/ofwG67DDRaPbP0PA+Yj1pwiHBW935pzJjEmgyXh02ggMpvLzaT4aZ/Dh8tURCg8BDOoxW2fkdEIbHh6ZFDEpW0+Sq50unKzRlwTr1Ua4sYG3qESaHQSoDQsEvd3jB/VorZ8GKQpVaOzpuedf9Ab+NFl0NRVFL8hYn20+mkHdoqwNCnXjc5v+oPvALioLTxcleYMot/mLZ/zySj9S6e87aHRPyeq+t3B0kmOcUndslP+93rSqVziFdzcA7L4y5QgwfScDZnmlHc7kJShFQ69Jgob57WEbnUWLXbeFUjzKy2SKRL3nkCd4veGeizbS8berneLnAzBvSC6ZIkH31qwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yOw4qGC0Ljft0Mq91iaH2NCSBSwMFg6tlnTWbBbj+Ts=;
 b=kvCGZ8l+1FoX3owemaQjijSinkX5+QqEQvjvvvDR+5eUPCmIMtO2VnVxi34HTVdBlAclqpB664YMZ6gvPtL1k34XKl/0Yh1I5ALtXbUh4BJiXaE3TbdgQaEkgn9fHkenkSIFRtQtkzGleBBuVXacVZrrCVnRgDhDZ2saBm2c1b0=
Received: from DS1PR07CA0015.namprd07.prod.outlook.com (2603:10b6:8:44d::16)
 by SA3PR12MB9199.namprd12.prod.outlook.com (2603:10b6:806:398::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 21:03:32 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:8:44d:cafe::5c) by DS1PR07CA0015.outlook.office365.com
 (2603:10b6:8:44d::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:03:31 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:24 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 045/109] drm/amdgpu/ras: Rework fw eeprom handling for new
 management interface
Date: Fri, 14 Aug 2026 17:01:42 -0400
Message-ID: <20260814210246.3067612-46-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|SA3PR12MB9199:EE_
X-MS-Office365-Filtering-Correlation-Id: e433d314-2658-48ad-4058-08defa477f27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|376014|82310400026|10067099003|6133799003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ZEoELx0Iq0z4BFn2XRkefj0V4QN0Z9U7eAfMoFQvbAzZx5Hdc+0uTW8BJAfAObcVJMt8P99gnmoQuPdSHF9yZ/XZqXhJbOsQlNvIJhtL6dVjFvxuVVoSJkbTKLeh6q51E0wX1hyxB2WsaP5PHff7rLtahdziEOAx/IR4X8u8r8IrlFbb5N2K1vHg6si9+pyUqkvN+1e0L+HnnRVnPfy2fdB1lq5JYltduD+k2T+yLSdeQRIb8mNQc5uth4W8KhJ5TcJ/4pIhxEemeXIKqxhgBiXIY26hyyvNqSJfrr0Y7ZsBfVSI/rrrJBKP9rwjYYeSdxpR2XJs7KgLZuOsmyM3A92NnWl0t6wMk70coYeU9aZVTbC5r5Z3+shRot+N3s/4d8aJGYSxzJbv8kkYAJaNTN3nRYMk/+kM+87KBun0yR8JMf9EU2o6zX3h482Qb/8KilvvtdnPOs7K3qh5tWLl9PUbZn/p52U4fYQAk40S86UtwC9mj0vCY96LYGyMeSd4ayWAgSXJhA7vacttDOQpIsg8GwMTgbkKtRK37IPok9g1RmKkPrAE1CYxw/gsRElIm53vGbZ8O6HtLiPe2y4edQcF/9cjfzukv49G/KEaey8Cw+hhHGm6UjlsBozX5zWg25tcKgzBwIXNadMa61Ya8IRt7I8DJDwBKgNsoWIssYQOEOem1ayXSiVTLCUSMz3PlzLh9/8CRKF6zbWc9HNDWA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(376014)(82310400026)(10067099003)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yAv2csXhhOSf2KBcTJowksP0nkI9wRNdSs0QyoKauiY7eWVzNsM3lEBvUMqh93Tjq5Du6cwWD5SkzjcHeaPgtBSUBUJrEFLKBiTEOIhUSWWQDKSUr6UK1Te/CrKiCVvswuej+4NrB/znwSbWrT+HUGlAIkIojzWc4xHIMddj7gkWdUzUSBZqeM2wlGSkQShNsFZ2SbVxiVf6L6ON4h7IIKKrUQwpKHGc/uOiXtmxI0stHEhG8pOlm7wEMCH5vo6XJ8XrgqGnZ3GOjy9En+zk/+JAOBGjRw2dIcFt3xpQA/+Ta34tmp+RiY7yU5DaZmPvxV6Xv/JWUAzvR/cCAP95Hheb5poevovzNTRikj4RXx7LFcX5ojM4RaW2FozclDWgrjTH/VZMMIhRLFNEs3x918cNQ70AumLEOhMCuRXv5/wCHI8hx3oi2G/oMPAPOQx8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:31.5745 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e433d314-2658-48ad-4058-08defa477f27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9199
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

From: YiPeng Chai <YiPeng.Chai@amd.com>

Rework fw eeprom handling for new management interface:
- Support new eeprom management interfaces.
- Use ras_mp1 common interfaces to retrieve bad page information
- Keep a local backup to reduce the interaction frequency with MP1.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/eeprom_fw.c      | 565 +++++-------------
 drivers/gpu/drm/amd/ras/core/eeprom_fw.h      |  67 +--
 drivers/gpu/drm/amd/ras/core/ras.h            |   1 -
 drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c |   5 +
 drivers/gpu/drm/amd/ras/core/ras_umc.c        |   3 +-
 5 files changed, 169 insertions(+), 472 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/eeprom_fw.c b/drivers/gpu/drm/amd/ras/core/eeprom_fw.c
index 59e195652e427..f7fb2dd7afe72 100644
--- a/drivers/gpu/drm/amd/ras/core/eeprom_fw.c
+++ b/drivers/gpu/drm/amd/ras/core/eeprom_fw.c
@@ -23,156 +23,18 @@
  */
 
 #include "ras.h"
+#include "ras_mp1.h"
+#include "eeprom_fw.h"
+#define MAX_EEPROM_ERR_RECORD_NUM 1024
 
-#define RAS_SMU_MESSAGE_TIMEOUT_MS 1000 /* 1s */
-
-void ras_fw_init_feature_flags(struct ras_core_context *ras_core)
-{
-	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
-	const struct ras_mp1_sys_func *sys_func = mp1->sys_func;
-	uint64_t flags = 0ULL;
-
-	if (!sys_func || !sys_func->mp1_get_ras_enabled_mask)
-		return;
-
-	if (!sys_func->mp1_get_ras_enabled_mask(ras_core, &flags))
-		ras_core->ras_fw_features = flags;
-}
-
-bool ras_fw_eeprom_supported(struct ras_core_context *ras_core)
-{
-	return !!(ras_core->ras_fw_features & RAS_CORE_FW_FEATURE_BIT__RAS_EEPROM);
-}
-
-int ras_fw_get_table_version(struct ras_core_context *ras_core,
-				     uint32_t *table_version)
-{
-	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
-	const struct ras_mp1_sys_func *sys_func = mp1->sys_func;
-
-	return sys_func->mp1_send_eeprom_msg(ras_core,
-				RAS_SMU_GetRASTableVersion, 0, table_version);
-}
-
-int ras_fw_get_badpage_count(struct ras_core_context *ras_core,
-				     uint32_t *count, uint32_t timeout)
-{
-	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
-	const struct ras_mp1_sys_func *sys_func = mp1->sys_func;
-	uint64_t end, now;
-	int ret = 0;
-
-	now = (uint64_t)ktime_to_ms(ktime_get());
-	end = now + timeout;
-
-	do {
-		ret = sys_func->mp1_send_eeprom_msg(ras_core,
-			RAS_SMU_GetBadPageCount, 0, count);
-		/* eeprom is not ready */
-		if (ret != -EBUSY)
-			return ret;
-
-		usleep_range(10000, 15000);
-		now = (uint64_t)ktime_to_ms(ktime_get());
-	} while (now < end);
-
-	RAS_DEV_ERR(ras_core->dev,
-			"smu get bad page count timeout!\n");
-	return ret;
-}
-
-int ras_fw_get_badpage_mca_addr(struct ras_core_context *ras_core,
-					uint16_t index, uint64_t *mca_addr)
-{
-	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
-	const struct ras_mp1_sys_func *sys_func = mp1->sys_func;
-	uint32_t temp_arg, temp_addr_lo, temp_addr_high;
-	int ret;
-
-	temp_arg = index | (1 << 16);
-	ret = sys_func->mp1_send_eeprom_msg(ras_core,
-			RAS_SMU_GetBadPageMcaAddr, temp_arg, &temp_addr_lo);
-	if (ret)
-		return ret;
-
-	temp_arg = index | (2 << 16);
-	ret = sys_func->mp1_send_eeprom_msg(ras_core,
-			RAS_SMU_GetBadPageMcaAddr, temp_arg, &temp_addr_high);
-
-	if (!ret)
-		*mca_addr = (uint64_t)temp_addr_high << 32 | temp_addr_lo;
-
-	return ret;
-}
-
-int ras_fw_set_timestamp(struct ras_core_context *ras_core,
-				 uint64_t timestamp)
-{
-	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
-	const struct ras_mp1_sys_func *sys_func = mp1->sys_func;
-
-	return sys_func->mp1_send_eeprom_msg(ras_core,
-			RAS_SMU_SetTimestamp, (uint32_t)timestamp, 0);
-}
-
-int ras_fw_get_timestamp(struct ras_core_context *ras_core,
-				 uint16_t index, uint64_t *timestamp)
+static int fw_eeprom_reset_ras_table(struct ras_core_context *ras_core)
 {
-	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
-	const struct ras_mp1_sys_func *sys_func = mp1->sys_func;
-	uint32_t temp = 0;
-	int ret;
-
-	ret = sys_func->mp1_send_eeprom_msg(ras_core,
-			RAS_SMU_GetTimestamp, index, &temp);
-	if (!ret)
-		*timestamp = temp;
-
-	return ret;
-}
-
-int ras_fw_get_badpage_ipid(struct ras_core_context *ras_core,
-				    uint16_t index, uint64_t *ipid)
-{
-	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
-	const struct ras_mp1_sys_func *sys_func = mp1->sys_func;
-	uint32_t temp_arg, temp_ipid_lo, temp_ipid_high;
-	int ret;
-
-	temp_arg = index | (1 << 16);
-	ret = sys_func->mp1_send_eeprom_msg(ras_core,
-			RAS_SMU_GetBadPageIpid, temp_arg, &temp_ipid_lo);
-	if (ret)
-		return ret;
-
-	temp_arg = index | (2 << 16);
-	ret = sys_func->mp1_send_eeprom_msg(ras_core,
-			RAS_SMU_GetBadPageIpid, temp_arg, &temp_ipid_high);
-	if (!ret)
-		*ipid = (uint64_t)temp_ipid_high << 32 | temp_ipid_lo;
-
-	return ret;
-}
-
-int ras_fw_erase_ras_table(struct ras_core_context *ras_core,
-				   uint32_t *result)
-{
-	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
-	const struct ras_mp1_sys_func *sys_func = mp1->sys_func;
-
-	return sys_func->mp1_send_eeprom_msg(ras_core,
-			RAS_SMU_EraseRasTable, 0, result);
-}
-
-int ras_fw_eeprom_reset_table(struct ras_core_context *ras_core)
-{
-	struct ras_fw_eeprom_control *control = &ras_core->ras_fw_eeprom;
+	struct fw_eeprom_control *ctl = ras_core->eeprom_mgr.ras_eeprom;
 	u32 erase_res = 0;
 	int res;
 
-	mutex_lock(&control->ras_tbl_mutex);
-
-	res = ras_fw_erase_ras_table(ras_core, &erase_res);
+	mutex_lock(&ctl->record_lock);
+	res = ras_mp1_reset_ras_table(ras_core, &erase_res);
 	if (res || erase_res) {
 		RAS_DEV_WARN(ras_core->dev, "RAS EEPROM reset failed, res:%d result:%d",
 									res, erase_res);
@@ -180,343 +42,220 @@ int ras_fw_eeprom_reset_table(struct ras_core_context *ras_core)
 			res = -EIO;
 	}
 
-	control->ras_num_recs = 0;
-	control->bad_channel_bitmap = 0;
-	ras_core_event_notify(ras_core, RAS_EVENT_ID__UPDATE_BAD_PAGE_NUM,
-		&control->ras_num_recs);
-	ras_core_event_notify(ras_core, RAS_EVENT_ID__UPDATE_BAD_CHANNEL_BITMAP,
-		&control->bad_channel_bitmap);
-	control->update_channel_flag = false;
+	ctl->record_count = 0;
+	memset(ctl->records, 0,
+		sizeof(*ctl->records) * MAX_EEPROM_ERR_RECORD_NUM);
 
-	mutex_unlock(&control->ras_tbl_mutex);
+	ctl->ras_table_format_version = 0;
+	ctl->eeprom_status = 0;
+	ctl->rma_status = 0;
+	ctl->bad_channel_bitmap = 0;
 
 	return res;
 }
 
-bool ras_fw_eeprom_check_safety_watermark(struct ras_core_context *ras_core)
+static int fw_eeprom_sync_data(struct ras_core_context *ras_core,
+		struct fw_eeprom_control *ctl)
 {
-	struct ras_fw_eeprom_control *control = &ras_core->ras_fw_eeprom;
-	bool ret = false;
-	int bad_page_count;
-
-	if (!control->record_threshold_config)
-		return false;
+	struct eeprom_err_record err_rec = {0};
+	u32 fw_err_rec_num;
+	u32 idx;
+	int ret = 0;
 
-	bad_page_count = ras_umc_get_badpage_count(ras_core);
+	mutex_lock(&ctl->record_lock);
+	ret = ras_mp1_get_record_count(ras_core, &fw_err_rec_num);
+	if (ret)
+		goto out;
+
+	if (!fw_err_rec_num || fw_err_rec_num == ctl->record_count) {
+		goto out;
+	} else if (fw_err_rec_num < ctl->record_count) {
+		RAS_DEV_ERR(ras_core->dev, "EEPROM ECC error count mismatch!\n");
+		ret = -EFAULT;
+		goto out;
+	}
 
-	if (bad_page_count > control->record_threshold_count)
-		RAS_DEV_WARN(ras_core->dev, "RAS records:%d exceed threshold:%d",
-			bad_page_count, control->record_threshold_count);
+	for (idx = ctl->record_count;
+			idx < fw_err_rec_num; idx++, ctl->record_count = idx) {
+		ret = ras_mp1_get_record(ras_core, idx, &err_rec);
+		if (ret)
+			goto out;
 
-	if ((control->record_threshold_config == WARN_NONSTOP_OVER_THRESHOLD) ||
-		(control->record_threshold_config == NONSTOP_OVER_THRESHOLD)) {
-		RAS_DEV_WARN(ras_core->dev,
-			"Please consult AMD Service Action Guide (SAG) for appropriate service procedures.\n");
-		ret = false;
-	} else {
-		ras_core->is_rma = true;
-		RAS_DEV_WARN(ras_core->dev,
-			"Please consider adjusting the customized threshold.\n");
-		ret = true;
+		memcpy(&ctl->records[idx], &err_rec, sizeof(*ctl->records));
 	}
 
+out:
+	mutex_unlock(&ctl->record_lock);
 	return ret;
 }
 
-int ras_fw_eeprom_append(struct ras_core_context *ras_core,
-			   struct eeprom_umc_record *record, const u32 num)
+static u32 fw_eeprom_get_record_count(struct ras_core_context *ras_core)
 {
-	struct ras_fw_eeprom_control *control = &ras_core->ras_fw_eeprom;
-	int threshold_config = control->record_threshold_config;
-	int i, bad_page_count;
-
-	mutex_lock(&control->ras_tbl_mutex);
-
-	for (i = 0; i < num; i++) {
-		/* update bad channel bitmap */
-		if ((record[i].mem_channel < BITS_PER_TYPE(control->bad_channel_bitmap)) &&
-			!(control->bad_channel_bitmap & (1 << record[i].mem_channel))) {
-			control->bad_channel_bitmap |= 1 << record[i].mem_channel;
-			control->update_channel_flag = true;
-		}
-	}
-	control->ras_num_recs += num;
+	struct fw_eeprom_control *ctl;
 
-	bad_page_count = ras_umc_get_badpage_count(ras_core);
+	if (!ras_core->eeprom_mgr.ras_eeprom)
+		return 0;
 
-	if (threshold_config != 0 &&
-		bad_page_count > control->record_threshold_count) {
-		RAS_DEV_WARN(ras_core->dev,
-			"Saved bad pages %d reaches threshold value %d\n",
-			bad_page_count, control->record_threshold_count);
+	ctl = ras_core->eeprom_mgr.ras_eeprom;
 
-		if ((threshold_config != WARN_NONSTOP_OVER_THRESHOLD) &&
-			(threshold_config != NONSTOP_OVER_THRESHOLD))
-			ras_core->is_rma = true;
+	if (!ras_core_gpu_in_reset(ras_core))
+		fw_eeprom_sync_data(ras_core, ctl);
 
-		/* ignore the -ENOTSUPP return value */
-		ras_core_event_notify(ras_core, RAS_EVENT_ID__DEVICE_RMA, NULL);
-	}
-
-	mutex_unlock(&control->ras_tbl_mutex);
-	return 0;
+	return ctl->record_count;
 }
 
-int ras_fw_eeprom_read_idx(struct ras_core_context *ras_core,
-			 struct eeprom_umc_record *record_umc,
-			 struct ras_bank_ecc *ras_ecc,
-			 u32 rec_idx, const u32 num)
+static int fw_eeprom_get_record(struct ras_core_context *ras_core,
+		u32 idx, struct eeprom_umc_record *rec)
 {
-	struct ras_fw_eeprom_control *control = &ras_core->ras_fw_eeprom;
-	int i, ret, end_idx;
-	u64 mca, ipid, ts;
-	u32 cu, mem_channel, mcumc_id;
-
-	if (!ras_core->ras_umc.ip_func ||
-	    !ras_core->ras_umc.ip_func->mca_ipid_parse)
-		return -EOPNOTSUPP;
+	struct fw_eeprom_control *ctl;
+	struct ras_bank_ecc bank = {0};
 
-	mutex_lock(&control->ras_tbl_mutex);
-
-	end_idx = rec_idx + num;
-	for (i = rec_idx; i < end_idx; i++) {
-		ret = ras_fw_get_badpage_mca_addr(ras_core, i, &mca);
-		if (ret)
-			goto out;
-
-		ret = ras_fw_get_badpage_ipid(ras_core, i, &ipid);
-		if (ret)
-			goto out;
+	if (!ras_core->eeprom_mgr.ras_eeprom)
+		return -EINVAL;
 
-		ret = ras_fw_get_timestamp(ras_core, i, &ts);
-		if (ret)
-			goto out;
+	ctl = ras_core->eeprom_mgr.ras_eeprom;
 
-		if (record_umc) {
-			record_umc[i - rec_idx].address = mca;
-			/* retired_page (pa) is unused now */
-			record_umc[i - rec_idx].retired_row_pfn = 0x1ULL;
-			record_umc[i - rec_idx].ts = ts;
-			record_umc[i - rec_idx].err_type = RAS_EEPROM_ERR_NON_RECOVERABLE;
-
-			ras_core->ras_umc.ip_func->mca_ipid_parse(ras_core, ipid,
-				&cu, &mem_channel, &mcumc_id, NULL);
-			record_umc[i - rec_idx].cu = (u8)cu;
-			record_umc[i - rec_idx].mem_channel = (u8)mem_channel;
-			record_umc[i - rec_idx].mcumc_id = (u8)mcumc_id;
-
-			/* update bad channel bitmap */
-			if ((record_umc[i - rec_idx].mem_channel < BITS_PER_TYPE(control->bad_channel_bitmap)) &&
-				!(control->bad_channel_bitmap & (1 << record_umc[i - rec_idx].mem_channel))) {
-				control->bad_channel_bitmap |= 1 << record_umc[i - rec_idx].mem_channel;
-				control->update_channel_flag = true;
-			}
-		}
-
-		if (ras_ecc) {
-			ras_ecc[i - rec_idx].addr = mca;
-			ras_ecc[i - rec_idx].ipid = ipid;
-			ras_ecc[i - rec_idx].ts = ts;
-		}
+	if (!rec || idx >= ctl->record_count)
+		return -EINVAL;
 
-	}
+	bank.timestamp = ctl->records[idx].timestamp;
+	bank.status = 0;
+	bank.ipid = ctl->records[idx].ipid;
+	bank.addr = ctl->records[idx].mca_addr;
+	bank.nps = ras_core_get_curr_nps_mode(ras_core);
 
-out:
-	mutex_unlock(&control->ras_tbl_mutex);
-	return ret;
+	return ras_umc_bank_to_umc_record(ras_core, &bank, rec);
 }
 
-uint32_t ras_fw_eeprom_get_record_count(struct ras_core_context *ras_core)
+static int fw_eeprom_sw_init(struct ras_core_context *ras_core,
+			struct ras_eeprom_param *param)
 {
-	if (!ras_core)
-		return 0;
+	struct ras_eeprom_mgr *mgr = &ras_core->eeprom_mgr;
+	struct fw_eeprom_control *ctl;
+	int ret = 0;
 
-	return ras_core->ras_fw_eeprom.ras_num_recs;
-}
+	if (!param)
+		return -EINVAL;
 
-int ras_fw_eeprom_update_record(struct ras_core_context *ras_core,
-				struct ras_bank_ecc *ras_ecc)
-{
-	struct ras_fw_eeprom_control *control = &ras_core->ras_fw_eeprom;
-	int ret, retry = 20;
-	u32 recs_num_new = control->ras_num_recs;
-
-	do {
-		/* 1000ms timeout is long enough, smu_get_badpage_count won't
-		 * return -EBUSY before timeout.
-		 */
-		ret = ras_fw_get_badpage_count(ras_core,
-			&recs_num_new, RAS_SMU_MESSAGE_TIMEOUT_MS);
-		if (!ret &&
-		    (recs_num_new == control->ras_num_recs)) {
-			/* record number update in PMFW needs some time,
-			 * smu_get_badpage_count may return immediately without
-			 * count update, sleep for a while and retry again.
-			 */
-			msleep(50);
-			retry--;
-		} else {
-			break;
-		}
-	} while (retry);
+	ctl = kzalloc(sizeof(*ctl), GFP_KERNEL);
+	if (!ctl)
+		return -ENOMEM;
 
-	if (ret)
-		return ret;
+	mgr->ras_eeprom = ctl;
+	memset(ctl, 0, sizeof(*ctl));
 
-	if (recs_num_new > control->ras_num_recs)
-		ret = ras_fw_eeprom_read_idx(ras_core, 0,
-					ras_ecc, control->ras_num_recs, 1);
-	else
-		ret = -EINVAL;
+	ctl->eeprom_ip_version = param->eeprom_ip_version;
+	ctl->records = kzalloc(sizeof(*ctl->records) * MAX_EEPROM_ERR_RECORD_NUM, GFP_KERNEL);
+	if (!ctl->records) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
+	ctl->max_record_count = MAX_EEPROM_ERR_RECORD_NUM;
+	mutex_init(&ctl->record_lock);
+
+	return 0;
+
+out:
+	kfree(ctl->records);
 	return ret;
 }
 
-static int __check_ras_fw_table_status(struct ras_core_context *ras_core)
+static int fw_eeprom_sw_fini(struct ras_core_context *ras_core)
 {
-	struct ras_fw_eeprom_control *control = &ras_core->ras_fw_eeprom;
-	uint64_t local_time;
-	int res;
-
-	mutex_init(&control->ras_tbl_mutex);
-
-	res = ras_fw_get_table_version(ras_core, &(control->version));
-	if (res)
-		return res;
-
-	res = ras_fw_get_badpage_count(ras_core, &(control->ras_num_recs), 100);
-	if (res)
-		return res;
+	struct fw_eeprom_control *ctl;
 
-	local_time = (uint64_t)ktime_get_real_seconds();
-	res = ras_fw_set_timestamp(ras_core, local_time);
-	if (res)
-		return res;
+	if (!ras_core->eeprom_mgr.ras_eeprom)
+		return -EINVAL;
 
-	control->ras_max_record_count = 4000;
+	ctl = ras_core->eeprom_mgr.ras_eeprom;
 
+	kfree(ctl->records);
+	mutex_destroy(&ctl->record_lock);
 
-	if (control->ras_num_recs > control->ras_max_record_count) {
-		RAS_DEV_ERR(ras_core->dev,
-			"RAS header invalid, records in header: %u max allowed :%u",
-			control->ras_num_recs, control->ras_max_record_count);
-		return -EINVAL;
-	}
+	kfree(ctl);
+	ras_core->eeprom_mgr.ras_eeprom = NULL;
 
 	return 0;
 }
 
-int ras_fw_eeprom_hw_init(struct ras_core_context *ras_core)
+static int fw_eeprom_hw_init(struct ras_core_context *ras_core,
+			struct ras_eeprom_param *param)
 {
-	struct ras_fw_eeprom_control *control;
-	struct ras_eeprom_config *eeprom_cfg;
-	struct ras_mp1 *mp1;
-	const struct ras_mp1_sys_func *sys_func;
-
-	if (!ras_core)
-		return -EINVAL;
-
-	mp1 = &ras_core->ras_mp1;
-	sys_func = mp1->sys_func;
+	struct fw_eeprom_control *ctl;
 
-	if (!sys_func || !sys_func->mp1_send_eeprom_msg)
+	if (!ras_core->eeprom_mgr.ras_eeprom)
 		return -EINVAL;
 
-	ras_core->is_rma = false;
-
-	control = &ras_core->ras_fw_eeprom;
-
-	memset(control, 0, sizeof(*control));
+	ctl = ras_core->eeprom_mgr.ras_eeprom;
 
-	eeprom_cfg = &ras_core->config->eeprom_cfg;
-	control->record_threshold_config =
-		eeprom_cfg->eeprom_record_threshold_config;
+	ras_mp1_get_table_version(ras_core, &ctl->ras_table_format_version);
 
-	control->record_threshold_count = 4000;
-	if (eeprom_cfg->eeprom_record_threshold_count <
-		control->record_threshold_count)
-		control->record_threshold_count =
-			eeprom_cfg->eeprom_record_threshold_count;
-
-	control->update_channel_flag = false;
-
-	return __check_ras_fw_table_status(ras_core);
+	return 0;
 }
 
-int ras_fw_eeprom_hw_fini(struct ras_core_context *ras_core)
+static int fw_eeprom_hw_fini(struct ras_core_context *ras_core)
 {
-	struct ras_fw_eeprom_control *control;
-
-	if (!ras_core)
-		return -EINVAL;
-
-	control = &ras_core->ras_fw_eeprom;
-	mutex_destroy(&control->ras_tbl_mutex);
-
 	return 0;
 }
 
-int ras_fw_eeprom_check_storage_status(struct ras_core_context *ras_core)
+static int fw_eeprom_get_records(struct ras_core_context *ras_core, u32 start,
+		struct eeprom_umc_record *record, u32 num)
 {
-	struct ras_fw_eeprom_control *control = &ras_core->ras_fw_eeprom;
-	int bad_page_count;
-
-	bad_page_count = ras_umc_get_badpage_count(ras_core);
-
-	if ((control->record_threshold_count < bad_page_count) &&
-	    (control->record_threshold_config != 0)) {
-		RAS_DEV_ERR(ras_core->dev, "RAS records:%d exceed threshold:%d",
-				bad_page_count, control->record_threshold_count);
-		if ((control->record_threshold_config == WARN_NONSTOP_OVER_THRESHOLD) ||
-			(control->record_threshold_config == NONSTOP_OVER_THRESHOLD)) {
-			RAS_DEV_WARN(ras_core->dev,
-			"Please consult AMD Service Action Guide (SAG) for appropriate service procedures\n");
-		} else {
-			ras_core->is_rma = true;
-			RAS_DEV_ERR(ras_core->dev,
-			"User defined threshold is set, runtime service will be halt when threshold is reached\n");
-		}
-		return 0;
-	}
+	struct fw_eeprom_control *ctl = ras_core->eeprom_mgr.ras_eeprom;
+	int i, ret = 0;
 
-	RAS_DEV_INFO(ras_core->dev,
-			"Found existing EEPROM table with %d records\n",
-			bad_page_count);
-	/* Warn if we are at 90% of the threshold or above
-	 */
-	if (10 * bad_page_count >= 9 * control->record_threshold_count)
-		RAS_DEV_WARN(ras_core->dev,
-			"RAS records:%u exceeds 90%% of threshold:%d\n",
-			bad_page_count,
-			control->record_threshold_count);
+	mutex_lock(&ctl->record_lock);
+	for (i = 0; i < num; i++) {
+		ret = fw_eeprom_get_record(ras_core, start + i, &record[i]);
+		if (ret)
+			break;
+	}
+	mutex_unlock(&ctl->record_lock);
 
-	return 0;
+	return ret;
 }
 
-enum ras_gpu_health_status
-	ras_fw_eeprom_check_gpu_status(struct ras_core_context *ras_core)
+static int fw_eeprom_get_eeprom_info(struct ras_core_context *ras_core,
+		struct ras_eeprom_info *eeprom_info, bool fast_mode)
 {
-	struct ras_fw_eeprom_control *control = &ras_core->ras_fw_eeprom;
+	struct fw_eeprom_control *ctl = ras_core->eeprom_mgr.ras_eeprom;
+
+	if (!eeprom_info)
+		return -EINVAL;
 
-	if (!control->record_threshold_config)
-		return RAS_GPU_HEALTH_NONE;
+	eeprom_info->record_count = ctl->record_count;
+	eeprom_info->max_record_count = ctl->max_record_count;
+	eeprom_info->bad_channel_bitmap = ctl->bad_channel_bitmap;
 
-	if (ras_core->is_rma)
-		return RAS_GPU_RETIRED__ECC_REACH_THRESHOLD;
+	if (!fast_mode) {
+		if (!ctl->ras_table_format_version)
+			ras_mp1_get_table_version(ras_core,
+				&ctl->ras_table_format_version);
 
-	return RAS_GPU_HEALTH_USABLE;
-}
+		eeprom_info->rma_status = ras_mp1_rma_detected(ras_core);
+		ctl->rma_status = eeprom_info->rma_status;
+	} else {
+		eeprom_info->rma_status = ctl->rma_status;
+	}
 
-void ras_fw_eeprom_sync_info(struct ras_core_context *ras_core)
-{
-	struct ras_fw_eeprom_control *control;
+	eeprom_info->record_format_version = ctl->ras_table_format_version;
 
-	if (!ras_core)
-		return;
+	if (eeprom_info->rma_status)
+		eeprom_info->eeprom_status = RAS_EEPROM_LOCKED;
+	else
+		eeprom_info->eeprom_status = RAS_EEPROM_OK;
 
-	control = &ras_core->ras_fw_eeprom;
-	ras_core_event_notify(ras_core, RAS_EVENT_ID__UPDATE_BAD_PAGE_NUM,
-		&control->ras_num_recs);
-	ras_core_event_notify(ras_core, RAS_EVENT_ID__UPDATE_BAD_CHANNEL_BITMAP,
-		&control->bad_channel_bitmap);
+	return 0;
 }
+
+struct ras_eeprom_ops ras_fw_eeprom_ops = {
+	.sw_init = fw_eeprom_sw_init,
+	.sw_fini = fw_eeprom_sw_fini,
+	.hw_init = fw_eeprom_hw_init,
+	.hw_fini = fw_eeprom_hw_fini,
+	.reset_table = fw_eeprom_reset_ras_table,
+	.get_records = fw_eeprom_get_records,
+	.get_record_count = fw_eeprom_get_record_count,
+	.get_eeprom_info = fw_eeprom_get_eeprom_info,
+};
diff --git a/drivers/gpu/drm/amd/ras/core/eeprom_fw.h b/drivers/gpu/drm/amd/ras/core/eeprom_fw.h
index 803d3ccdaddbd..8fc8773732ece 100644
--- a/drivers/gpu/drm/amd/ras/core/eeprom_fw.h
+++ b/drivers/gpu/drm/amd/ras/core/eeprom_fw.h
@@ -23,65 +23,18 @@
  */
 #ifndef __EEPROM_FW_H__
 #define __EEPROM_FW_H__
+struct fw_eeprom_control {
+	u32 eeprom_ip_version;
+	struct mutex record_lock;
+	struct eeprom_err_record *records;
+	u32 record_count;
 
-struct ras_fw_eeprom_control {
-	uint32_t version;
-	/* record threshold */
-	int record_threshold_config;
-	uint32_t record_threshold_count;
-	bool update_channel_flag;
-
-	/* Number of records in the table.
-	 */
-	u32 ras_num_recs;
-
-	/* Maximum possible number of records
-	 * we could store, i.e. the maximum capacity
-	 * of the table.
-	 */
-	u32 ras_max_record_count;
-
-	/* Protect table access via this mutex.
-	 */
-	struct mutex ras_tbl_mutex;
-
-	/* Record channel info which occurred bad pages
-	 */
+	u32 ras_table_format_version;
+	u32 eeprom_status;
+	u32 rma_status;
+	u32 max_record_count;
 	u32 bad_channel_bitmap;
 };
 
-void ras_fw_init_feature_flags(struct ras_core_context *ras_core);
-bool ras_fw_eeprom_supported(struct ras_core_context *ras_core);
-int ras_fw_get_table_version(struct ras_core_context *ras_core,
-				     uint32_t *table_version);
-int ras_fw_get_badpage_count(struct ras_core_context *ras_core,
-				     uint32_t *count, uint32_t timeout);
-int ras_fw_get_badpage_mca_addr(struct ras_core_context *ras_core,
-					uint16_t index, uint64_t *mca_addr);
-int ras_fw_set_timestamp(struct ras_core_context *ras_core,
-				 uint64_t timestamp);
-int ras_fw_get_timestamp(struct ras_core_context *ras_core,
-				 uint16_t index, uint64_t *timestamp);
-int ras_fw_get_badpage_ipid(struct ras_core_context *ras_core,
-				    uint16_t index, uint64_t *ipid);
-int ras_fw_erase_ras_table(struct ras_core_context *ras_core,
-				   uint32_t *result);
-int ras_fw_eeprom_reset_table(struct ras_core_context *ras_core);
-bool ras_fw_eeprom_check_safety_watermark(struct ras_core_context *ras_core);
-int ras_fw_eeprom_append(struct ras_core_context *ras_core,
-			   struct eeprom_umc_record *record, const u32 num);
-int ras_fw_eeprom_read_idx(struct ras_core_context *ras_core,
-			 struct eeprom_umc_record *record_umc,
-			 struct ras_bank_ecc *ras_ecc,
-			 u32 rec_idx, const u32 num);
-uint32_t ras_fw_eeprom_get_record_count(struct ras_core_context *ras_core);
-int ras_fw_eeprom_update_record(struct ras_core_context *ras_core,
-				struct ras_bank_ecc *ras_ecc);
-int ras_fw_eeprom_hw_init(struct ras_core_context *ras_core);
-int ras_fw_eeprom_hw_fini(struct ras_core_context *ras_core);
-int ras_fw_eeprom_check_storage_status(struct ras_core_context *ras_core);
-enum ras_gpu_health_status
-	ras_fw_eeprom_check_gpu_status(struct ras_core_context *ras_core);
-void ras_fw_eeprom_sync_info(struct ras_core_context *ras_core);
-
+extern struct ras_eeprom_ops ras_fw_eeprom_ops;
 #endif
diff --git a/drivers/gpu/drm/amd/ras/core/ras.h b/drivers/gpu/drm/amd/ras/core/ras.h
index 9c87037454d5c..a08f83ed05857 100644
--- a/drivers/gpu/drm/amd/ras/core/ras.h
+++ b/drivers/gpu/drm/amd/ras/core/ras.h
@@ -385,7 +385,6 @@ struct ras_core_context {
 	bool ras_eeprom_supported;
 	struct ras_eeprom_control ras_eeprom;
 	struct ras_eeprom_mgr eeprom_mgr;
-	struct ras_fw_eeprom_control ras_fw_eeprom;
 
 	struct ras_psp ras_psp;
 	struct ras_umc ras_umc;
diff --git a/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c b/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
index d56e065ccfc74..1781d037ef13d 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
@@ -25,6 +25,7 @@
 #include "ras_eeprom_mgr.h"
 #include "ras.h"
 #include "eeprom.h"
+#include "eeprom_fw.h"
 
 static bool __ras_eeprom_disabled(struct ras_core_context *ras_core)
 {
@@ -42,6 +43,10 @@ static const struct ras_eeprom_ops *ras_eeprom_mgr_get_ip_func(
 	case IP_VERSION(13, 0, 12):
 		mgr->eeprom_early_init_service_supported = false;
 		return &ras_drv_eeprom_ops;
+	case IP_VERSION(15, 0, 8):
+		mgr->eeprom_early_init_service_supported = true;
+		mgr->fw_record_enabled = true;
+		return &ras_fw_eeprom_ops;
 	default:
 		RAS_DEV_ERR(ras_core->dev,
 			"EEPROM(MP1) ip version(0x%x) is not supported!\n", ip_version);
diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc.c b/drivers/gpu/drm/amd/ras/core/ras_umc.c
index 1be677ca316e1..2ff6c9a7e5c17 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_umc.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc.c
@@ -435,7 +435,8 @@ static int ras_umc_eeprom_rec2nps_rec(struct ras_core_context *ras_core,
 	record->cur_nps = nps;
 
 	if (save_nps || ch_idx_v2) {
-		if ((nps == save_nps) && !ras_fw_eeprom_supported(ras_core)) {
+		if ((nps == save_nps) &&
+		    !ras_eeprom_mgr_fw_record_enabled(ras_core)) {
 			record->cur_nps_retired_row_pfn =
 				EEPROM_RECORD_UMC_ADDR_PFN(record);
 		} else {
-- 
2.55.0

