Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C7BD73E86
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 02:30:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68C2E10E34F;
	Fri, 30 Jan 2026 02:30:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cKA8GDU3";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013062.outbound.protection.outlook.com
 [40.93.201.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21A5B10E34F
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 02:30:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jyD0rmNySRbDurqpDTzqrX9RnLe8B9xXIAesC25TIY2CxxJiiMY1FSwswR3PkAeDhhu/fiQGT2H2kRkCNwzSTrHaHGaoKPPj7TigUE3JBBXREa3bFGu/b9tdzFE9snMSzNVDrOyRYHEUuFCMLFf3I8w896PkIOrYTrFmQSWZtKUpfLJMubmDVFk/gEejukKxgS3mFY3NgE9jcblDurcInSgNgQM1ylll4KBW+yEwght7A53xJ35v7Ty90CZT3lWh9h5axF2w9O0nti9nFzwY/Bs8SW1/G7pfAUGNTzwYCaNgMwA41bNqYFFF41ttJiK8TAY5OGz/C/3ZkGxKqIXh0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kg7U5onN+odpUeQesO0XotfUzEXLHz/1nRwlh5a7QPQ=;
 b=lJTmGGJ7qC/REl3G9CoNZtU9kleX/Zr+63OYOg3ojsAMGUVBvB8Pt8jBWbTkABmGBoXM4j7fRB0CflL5nOi0aTKq9l67OgYRsO0NriGQSlWBVZ4eDjGpJha+cTPF67WbCofHINp+/edwjlEQRehIj2oGzvCgw7n9YzBSLQjVjf008bBaa7NRQD696VV2nYJ0XHDIzWezGm5h9z8qTOCCPLoRyApuW64u528dCrCC5Y+e/20qAUtN1F1hu1O1O/0ts+c2AhSVqNwd5B9d8S/szbxvZaWrHECKVB6+5A4ltaL9xu1FhjQX3ta+tLTrDsOg1SBobjX1T764jXuvPhXk3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kg7U5onN+odpUeQesO0XotfUzEXLHz/1nRwlh5a7QPQ=;
 b=cKA8GDU3gBnvUvOWgzNmp7V5FehEKdgFQSMTM9G/qDKYMdm0ttZkwDly498Htk51mgraEzEUwkAB5oPgSBgT8ZF84hyDT5lKZqu8GS3UaFsgNfhTAjgRPsk9x4kVa49V0vTYNm8R3zIMrZAKNZMQGu6PvCgT0cePRgIl6USb8ss=
Received: from SJ0PR05CA0036.namprd05.prod.outlook.com (2603:10b6:a03:33f::11)
 by MW4PR12MB7192.namprd12.prod.outlook.com (2603:10b6:303:22a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 02:30:29 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::45) by SJ0PR05CA0036.outlook.office365.com
 (2603:10b6:a03:33f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Fri,
 30 Jan 2026 02:30:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 02:30:29 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 29 Jan 2026 20:30:27 -0600
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <YiPeng.Chai@amd.com>, <KevinYang.Wang@amd.com>,
 Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH 06/14] drm/amd/ras: Add table reset func for pmfw eeprom
Date: Fri, 30 Jan 2026 10:29:42 +0800
Message-ID: <20260130022950.1160058-6-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260130022950.1160058-1-ganglxie@amd.com>
References: <20260130022950.1160058-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|MW4PR12MB7192:EE_
X-MS-Office365-Filtering-Correlation-Id: efeae236-bf6f-42f0-621b-08de5fa788c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?duFlEz8gqM/Kaqhuz/2HhFA+wwWJFY4M/LAAw+G2d0Aj/69Trs2nk+high95?=
 =?us-ascii?Q?RmcL5dZzhEF+GLAE4WmTFhKyKTMWMP+yCvIxAho5hJXpVKd61LooREUg4Pz/?=
 =?us-ascii?Q?WXmlB2pbgQQU+lTxtHG0oa//tRRu8S131jtuSjfREcTkINngRQcVfmZnn4pw?=
 =?us-ascii?Q?uO4qjQmJJay0eZJGkDUkPwM7YjDJQZLrXGCzdeNDP8W67/lKI7wBmYkLroXH?=
 =?us-ascii?Q?scoSHnWuYLTcRE+bfwaBN8dBeRsT0HadFHzmGAFXXxJFCnM4vwP88sEjDIs+?=
 =?us-ascii?Q?pqNf5puvQ5XSerHcYteffYBFMH+kSjw/zb6+gLmc7ZaMoacwUnFHdwQFCrdR?=
 =?us-ascii?Q?/JIiZ0KqMLMDOSwOmktiDZPn7W8gHV0f1hh++le+dQUmxXAhNDm8rBVImz7W?=
 =?us-ascii?Q?ooJj0LESpultVga9GQ4Y5uEhdULlypRywYy9Q9Trkpvay+jFWP/yxmlcprPD?=
 =?us-ascii?Q?Ba9+OPifJsDvt9bJ7Uvg/NOXDv+7qLQN6ctebPJf2po+zWiNYJjCcX6Pg7RH?=
 =?us-ascii?Q?ogbrw0tY2rvmCx+T+yqqL1h3HfjD8CPwY9u/VSD2uUuVE0oFYad5nGQH6CvJ?=
 =?us-ascii?Q?d4J/yHWVQX4axL4u6x0LFokdZt/E5b5/qDtp4iAG0v8SaEuBJQhp08X4LoQk?=
 =?us-ascii?Q?VnnqAW8Cr/vBT+vUcMGWWZf/SO0ADNhYb/svFWgEH+WjoiA3wsHiQHzU1L/O?=
 =?us-ascii?Q?BnUXH2LTSSqtx4klPHc6PLsre5r22iePsFSlEbGngGqbqUrMDUWnb0F4SEUx?=
 =?us-ascii?Q?BgSFgqmAaTcn0v660+NrFWvVxUupuR94hze4daEsn9OcU2zrFImzLA72DRW9?=
 =?us-ascii?Q?1bRtcSThA7DIS1iODVPNCvfuhka9tbxtTMPf5yyB9Q1WcT6VAzyNK53+KO1Q?=
 =?us-ascii?Q?oif56j+lLg/ch3RXH3IlxukoqnjGBI0c8FEQiDiJDuC4S8yp8srtL4eCQiAN?=
 =?us-ascii?Q?Vn6RaT5uWrm8Km0xisimEfLcQPenCqJw+5obImu1RekSj0Yu3eJq756alLI9?=
 =?us-ascii?Q?ojOiUiqMVQQfA3/x6/G8/A4kIkB3wHZKMCTy6WaKF8bjLqPvE3tXJVosxZkd?=
 =?us-ascii?Q?q25IbByXQbK1NB6zHEUhVbAJ34znP5FobRQJXrRB6ikewRoWUyrcLkT2eIyW?=
 =?us-ascii?Q?bQ3HMpmpUOyODCT59h+HpoirC/H5MQrj7HbpKp9YlrfVFzPg5BOIoMvfjzBr?=
 =?us-ascii?Q?B0sXuUKrPagGtkq4d1o+kAhxXYa7dSl7rnvCT5rQj/1SkxWdn9jz1CjO1cqF?=
 =?us-ascii?Q?v71yRB29TzNuKxS0WkUG6hQ9Q7uquFVyB+cFn51y/IpWZcQvhhbODM+HtXun?=
 =?us-ascii?Q?BpSIiU45rOZiyCxp+jTdtLMoRfYZW24PO4ZCGlgohsby2z8wIIV8H5JswU2Q?=
 =?us-ascii?Q?81vnp23mqfeDVRIt/L+acElTw+WWsNFWzfL4iNqboEvX6vT2wIVUg3raz0pe?=
 =?us-ascii?Q?gnKHEaLa1bBAmEpGd5k/HSk1NQIte04Gacp+mR2nXMha8VihFxYb4Y1ckLYY?=
 =?us-ascii?Q?RisFqX6pCx/IUgIe7Q0Hrs/FRmnJtQkyZjZK8tFAM+B5bintm+NTydRlgNV4?=
 =?us-ascii?Q?3qqi5RvH3AN+H5jLdq5NAUoC36E8g82+lZBH7P96BY3lEYd8nGs0ZL2mTdY7?=
 =?us-ascii?Q?k3xBT1J3Wic5FKxWWP7oUtaW6DVrp3xW22vBWStHUVoVn8Jla0NDQ+NK7n0f?=
 =?us-ascii?Q?i+Eb9Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ixpKGnV0yiC6ecLDtafgJaIoOKAWKHISxTQHYhxkJ1xQFSfRSMHisOzRnlb8I+tpg5catodb7g101o4tWe3dVyTriq/H50Q17KkWN+7NMlBJRDJHOgJ3V/JOyUb4Z/5AfbR7IUQLKvslSHfwIvStcynh1I39fYnpDi/TynPCTi766dEEcW9lgtfrbEh49qXB/slrzmlR95v5zreFp9raydez9D2AbdTO9YcAVF131Hv8O9bV6tVf8tP6VIaU+t996yKdY4dvG1p+Xx3kN7Dr+qGaCoRsZForF36QohnwYeJuIKZ/dl4QS+h/Y61xA0pPOGKuxiX6x5TzQHXgCv+kNh4o4/nCnW1L2kYIUfs79Bs4BEkMcz9cEUNKujrqI9GNURot/PoboKlwk7GFsVoSSA5KU5zW2KjgH5cDI3LyOpPmF5Lnz4TlwMRzmbSRnYg5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 02:30:29.0783 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efeae236-bf6f-42f0-621b-08de5fa788c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7192
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

add table reset func for pmfw eeprom, add smu eeprom control
structure

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras.h         |  1 +
 drivers/gpu/drm/amd/ras/rascore/ras_cmd.c     |  9 ++++--
 .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.c   | 29 +++++++++++++++++++
 .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.h   | 26 +++++++++++++++++
 4 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras.h b/drivers/gpu/drm/amd/ras/rascore/ras.h
index 6e223eff522c..ae10d853c565 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras.h
@@ -313,6 +313,7 @@ struct ras_core_context {
 
 	bool ras_eeprom_supported;
 	struct ras_eeprom_control ras_eeprom;
+	struct ras_fw_eeprom_control ras_fw_eeprom;
 
 	struct ras_psp ras_psp;
 	struct ras_umc ras_umc;
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c b/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c
index 94e6d7420d94..4f89810d85a1 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c
@@ -146,8 +146,13 @@ static int ras_cmd_clear_bad_page_info(struct ras_core_context *ras_core,
 	if (cmd->input_size != sizeof(struct ras_cmd_dev_handle))
 		return RAS_CMD__ERROR_INVALID_INPUT_SIZE;
 
-	if (ras_eeprom_reset_table(ras_core))
-		return RAS_CMD__ERROR_GENERIC;
+	if (ras_fw_eeprom_supported(ras_core)) {
+		if (ras_fw_eeprom_reset_table(ras_core))
+			return RAS_CMD__ERROR_GENERIC;
+	} else {
+		if (ras_eeprom_reset_table(ras_core))
+			return RAS_CMD__ERROR_GENERIC;
+	}
 
 	if (ras_umc_clean_badpage_data(ras_core))
 		return RAS_CMD__ERROR_GENERIC;
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
index f880fc49477d..ae63e7394829 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
@@ -161,3 +161,32 @@ int ras_fw_erase_ras_table(struct ras_core_context *ras_core,
 	return sys_func->mp1_send_eeprom_msg(ras_core,
 			RAS_SMU_EraseRasTable, 0, result);
 }
+
+int ras_fw_eeprom_reset_table(struct ras_core_context *ras_core)
+{
+	struct ras_fw_eeprom_control *control = &ras_core->ras_fw_eeprom;
+	u32 erase_res = 0;
+	int res;
+
+	mutex_lock(&control->ras_tbl_mutex);
+
+	res = ras_fw_erase_ras_table(ras_core, &erase_res);
+	if (res || erase_res) {
+		RAS_DEV_WARN(ras_core->dev, "RAS EEPROM reset failed, res:%d result:%d",
+									res, erase_res);
+		if (!res)
+			res = -EIO;
+	}
+
+	control->ras_num_recs = 0;
+	control->bad_channel_bitmap = 0;
+	ras_core_event_notify(ras_core, RAS_EVENT_ID__UPDATE_BAD_PAGE_NUM,
+		&control->ras_num_recs);
+	ras_core_event_notify(ras_core, RAS_EVENT_ID__UPDATE_BAD_CHANNEL_BITMAP,
+		&control->bad_channel_bitmap);
+	control->update_channel_flag = false;
+
+	mutex_unlock(&control->ras_tbl_mutex);
+
+	return res;
+}
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
index 46f45e82a3f3..a1003db3c33b 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
@@ -24,6 +24,31 @@
 #ifndef __RAS_EEPROM_FW_H__
 #define __RAS_EEPROM_FW_H__
 
+struct ras_fw_eeprom_control {
+	uint32_t version;
+	/* record threshold */
+	int record_threshold_config;
+	uint32_t record_threshold_count;
+	bool update_channel_flag;
+
+	/* Number of records in the table.
+	 */
+	u32 ras_num_recs;
+
+	/* Maximum possible number of records
+	 * we could store, i.e. the maximum capacity
+	 * of the table.
+	 */
+	u32 ras_max_record_count;
+
+	/* Protect table access via this mutex.
+	 */
+	struct mutex ras_tbl_mutex;
+
+	/* Record channel info which occurred bad pages
+	 */
+	u32 bad_channel_bitmap;
+};
 
 void ras_fw_init_feature_flags(struct ras_core_context *ras_core);
 bool ras_fw_eeprom_supported(struct ras_core_context *ras_core);
@@ -41,5 +66,6 @@ int ras_fw_get_badpage_ipid(struct ras_core_context *ras_core,
 				    uint16_t index, uint64_t *ipid);
 int ras_fw_erase_ras_table(struct ras_core_context *ras_core,
 				   uint32_t *result);
+int ras_fw_eeprom_reset_table(struct ras_core_context *ras_core);
 
 #endif
-- 
2.34.1

