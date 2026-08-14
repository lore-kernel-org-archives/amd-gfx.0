Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F21F7C5DF6A
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 497C410F6F9;
	Fri, 14 Aug 2026 21:03:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oN1NJeAL";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012040.outbound.protection.outlook.com [40.107.209.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B16E10F6E6
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uT/6+QIOyHaFbNuwp9RxAdkNJ/VOYF0bVn+Hg8VZST7H2jcX7MZI0w2tk3sT+dd4OKqx8YdfoHxuEjym/OXCmhH+tf1G7cPc6qANzWbsZGhXu10IHPQQwo2++PKtE4/CQeNM8IrJnG2F2gT9kCt3BUOCr4c0WjYp9mfHdb2Xyo1S2O20HYsi7qOWsoO0Sw+ktdMjF73yunJr1lcADJXAKus/bj+Nx7B9P2e9W7K+SOjusKCOtLkfaW/3n7x+nQ17F8j4e8L3S7AwI2y+WOiTMLSBO5nKexHFd9GJcZErAaTZXFOnnsK4cUuQ3qNWzO3xE7LX/Xj3bMuLlZ3e01iwqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RM/g+/Z0UqTyywj4nFZzYDa2oil+AJyzYVfzm/4E4iM=;
 b=w4qlymq+Z4J5y9KFhvwXPw7OKOgdv4ExpTYUAn6KCekDj8pr1EICNHTsaZdDWdHCc+3hw/ST63pfELkxxWhQ43r23DFtzYO/bzmCkgmGrry65+tWb4QBSgu79w1N0ZTVJDoFcnvTro+QYJ0rwjnnlrM5LOvu0lyB0OkGo9aTMK8G6l/FTxP1idDXOFPyoMIwEmAZgd2UW2pEi2wIgPksypjziEpiIkQOgNy70CD0PKIZyffPyHaNe8eA5C95a4Zoipq0IJ3zmYIeqpg90vZQmovRpbvXblGDT8MxxW6qrGg5MzkL0qrJV+JgAh0YHij6EXoTE2b7nJ34p9YTYHP7FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RM/g+/Z0UqTyywj4nFZzYDa2oil+AJyzYVfzm/4E4iM=;
 b=oN1NJeAL1S7WHbeCzkv//gU0W9FkoJj4B0+yjqpAt8Q20kCfXlZMCMGX5H8NcpXlaJxDoQADJGPYqpViro4W8V+NDmTwkNuT0OGD8sQQc+d0AOnqsHFwpGFqxOB2MDeLdzs1JLVsoMubCoi+EsPwhLdE0SOsZUMSQhcafi1GjCs=
Received: from BN9PR03CA0340.namprd03.prod.outlook.com (2603:10b6:408:f6::15)
 by DM6PR12MB4417.namprd12.prod.outlook.com (2603:10b6:5:2a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 21:03:24 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:f6:cafe::29) by BN9PR03CA0340.outlook.office365.com
 (2603:10b6:408:f6::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Fri,
 14 Aug 2026 21:03:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:03:24 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:23 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:23 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:23 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 043/109] drm/amd/ras: Ras eeprom supports new eeprom
 management interfaces
Date: Fri, 14 Aug 2026 17:01:40 -0400
Message-ID: <20260814210246.3067612-44-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|DM6PR12MB4417:EE_
X-MS-Office365-Filtering-Correlation-Id: 664f5afa-fbb7-4339-38a9-08defa477ac4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|56012099006|10067099003|18002099003|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: RIKKHvSpOTpKHngEzg3zp+nwRmf/SwatuMNI11G48amyxZIS7NluRiQ3IGs71DLetpqbQmLONg/EviFGSGXEkC12uq3Zg5r9a8B/EZ+BV7wsJJRXuhlRES0R06h+JOYBkcPHmfskjCIVtQZbcKs9qPloSQmayfne2bokywl8dfz3HFXjEaaGPBssuHumB89T8dTwTaZan5KsfqcdnS/D9BrHeY0wMOzlQQcAsof31QM8mcF+thELHG4ntLtzUSqJ08WLnrYZapkuAnHoSEuRs9o0UjnJrZ8R0upDGRh+SgjcZeAjb4HlOXDaCvSZzH0/+snAltuf7TdCOaxvIVXgYqcj7WuPKIgpWaAxB/vaHFbyeHkUmNu8W+1L0QZzRCPSKVW+QDcv1ObNT0LaILbgFaLSS8gnugogkYm7Jtec3+pZ0ti7vRYv67+LV2AGKFIW5DyGRKCEULLuMDh1unnGUJF+UqDUTy2juqrWxgREquHekE/7T4XCYQTRz2qp1xW0rOUUnoZ82hvKp5cPtD/NsnlFUsqo6QWywXhEfOmRWHkt2wwLcwF3rQ0D800YSPHsGTplesdiTLcKc0PywPpNtzEJRtUhaAk7Uj0dOJJM4W1ov9P/QkZYP5FPEzfYT5EEAUVG0lp9aHs6c9PCv1B9Clvqzd/theoeOa/D5LPlzw+nohFyJWkqNJNu1fLAmZbHheIOmRBg+OBAkHzyguaE3A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(56012099006)(10067099003)(18002099003)(11063799006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sh80mZgoAH9mj7I4xF8my1N6Cev7S5suRISoPH8vRrSKUPp1ocB6bATTjBxHtetw0xYN5zExwAi+a1rHRkr8kRiLaxD1VhKmOf6onihOzK3xD4eF/LTcscok3+0HxTCehZNnd/XlKjRiRN6QceDu5vFGK9m+0Rq4EvAbuXpss+94nCD3VnTvGn3FXJ6A771HqAiQpU48ER3jDMS53nkvQe4S7taM1CTjWDr7zb0DB9x2mYqk3ZHaYUonmkOGGj7nJsCbLe75Gj8rW+YIZiB0cvzssrfNYjRauPyC/iYzphHD8+n7IXglBGLi03UAxa8fINcBU0RPyj/gspySPo0t0Kr10K8PufVd4+u8V4G6wUXigHmjdtjHP13g02cPSB2bPmaP2FPeEZWFE1YiVwE41MujpcqWtMBPEqMnQzUuB9KrvZ8dmqaImHUCkGbdHEaM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:24.1660 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 664f5afa-fbb7-4339-38a9-08defa477ac4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4417
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

Ras eeprom supports new eeprom management interfaces.

v2:
  Correct incorrect return values.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/eeprom.c | 87 +++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/core/eeprom.c b/drivers/gpu/drm/amd/ras/core/eeprom.c
index 7913cdbdb8b0a..39aae3248ea77 100644
--- a/drivers/gpu/drm/amd/ras/core/eeprom.c
+++ b/drivers/gpu/drm/amd/ras/core/eeprom.c
@@ -1390,3 +1390,90 @@ int ras_eeprom_get_version(struct ras_core_context *ras_core, uint32_t *version)
 
 	return 0;
 }
+
+static int ras_eeprom_get_records(struct ras_core_context *ras_core, u32 start,
+		struct eeprom_umc_record *record, u32 num)
+{
+	if (!record)
+		return -EINVAL;
+
+	return ras_eeprom_read(ras_core, record, num);
+}
+
+static int __check_ras_table(struct ras_core_context *ras_core,
+			struct ras_eeprom_control *control)
+{
+	int res = 0;
+
+	mutex_lock(&control->ras_tbl_mutex);
+	res = __verify_ras_table_checksum(control);
+	mutex_unlock(&control->ras_tbl_mutex);
+	if (res)
+		RAS_DEV_ERR(ras_core->dev,
+			"RAS table checksum is incorrect! ret: %d\n", res);
+
+	return res;
+}
+
+static void __get_eeprom_status(struct ras_core_context *ras_core,
+		u32 *status, bool fast_mode)
+{
+	struct ras_eeprom_control *control = ras_core->eeprom_mgr.ras_eeprom;
+	struct ras_eeprom_table_header *hdr;
+
+	if (!control)
+		return;
+
+	hdr = &control->tbl_hdr;
+	if (!fast_mode && __check_ras_table(ras_core, control))
+		*status = RAS_EEPROM_FAULT;
+	else if (hdr->header == RAS_TABLE_HDR_VAL)
+		*status = RAS_EEPROM_OK;
+	else if (hdr->header == RAS_TABLE_HDR_BAD)
+		*status = RAS_EEPROM_LOCKED;
+	else
+		*status = RAS_EEPROM_UNKNOWN;
+}
+
+static int ras_eeprom_get_eeprom_info(struct ras_core_context *ras_core,
+		struct ras_eeprom_info *eeprom_info, bool fast_mode)
+{
+	struct ras_eeprom_control *ctl = ras_core->eeprom_mgr.ras_eeprom;
+	struct ras_eeprom_table_header *hdr;
+
+	if (!ctl || !eeprom_info)
+		return -EINVAL;
+
+	hdr = &ctl->tbl_hdr;
+	__get_eeprom_status(ras_core, &eeprom_info->eeprom_status, fast_mode);
+	eeprom_info->record_format_version = hdr->version;
+	eeprom_info->record_count = ctl->ras_num_recs;
+	eeprom_info->max_record_count = ctl->ras_max_record_count;
+	eeprom_info->bad_channel_bitmap = ctl->bad_channel_bitmap;
+
+	return 0;
+}
+
+static int ras_eeprom_unlock(struct ras_core_context *ras_core)
+{
+	struct ras_eeprom_control *control = ras_core->eeprom_mgr.ras_eeprom;
+	int ret;
+
+	if (!control)
+		return -EINVAL;
+
+	ret = __check_ras_table(ras_core, control);
+	if (ret)
+		return ret;
+
+	return ras_eeprom_correct_header_tag(control, RAS_TABLE_HDR_VAL);
+}
+
+struct ras_eeprom_ops ras_drv_eeprom_ops = {
+	.reset_table = ras_eeprom_reset_table,
+	.get_records = ras_eeprom_get_records,
+	.append_records = ras_eeprom_append,
+	.get_record_count = ras_eeprom_get_record_count,
+	.get_eeprom_info = ras_eeprom_get_eeprom_info,
+	.unlock_eeprom = ras_eeprom_unlock,
+};
-- 
2.55.0

