Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B8C8C88E43
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 03:56:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0D0E10E392;
	Mon, 26 Jan 2026 03:56:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wZhyRc/m";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012032.outbound.protection.outlook.com [40.107.209.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12DFF10E391
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 03:56:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lBIbp51CBJNVDH6x7l2uXcfI7MmiZjsxFi3u6lhRmGa7wstjhqPvEOLuXbZHsbHFi78q9I/bQJxC30QGmsVlygG9KcXhhQBasQYVH4bo3XMGzlvMYQ5fEaEsNEKUlbdMTtf3DOiSJi6A7bHiXwnGG2coLiU+Ub3b9OCUlV21wdAtuGzDRduj7kPOKVxbVEi2k41hHK/9uyEWETHedI3CpGSFNbUl/52mOWL5OWggHiqWztLuKSUOZj6/YzU/cnb/tuw3mHmffC7BS9NZKO2HLiqRfZ+asFF8MDRMpvZxxv0FcpOKeo8p4rby6r4x6PlpZF6n/u1ltz8eB1cSC4OoTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZvXTAxqHH81u+TNe1QuCwGsa8D/ZUU3dmoz7I1TuKic=;
 b=Fs6a/gXRv43WakymLC//YmPwioCrovf9BIQSGvwKN0UL0ZhGZeh1XKAxY3POowq+9lnKZaDbHz1sV8S4WgQOEv68Vkbha92BSM0Wkelt5Kj/ym+kouOHyVY+BV18/ssuM8ZyDJShmIfdzpsvjwtqwsvzdGynKpkg6jYcGAXE93vvAzg3Qx0bIduYaZcAPasP0GdIDV18kRqn2ttVfjdiu/+Mzr1GQ1Ri0FWTX7n6yOi8YV3iKjt9bOyMxffayzYfKhLAXi+oNE6IpC7VRhzncfoSfjCEBlVJWOkguYLpHLglZO0ouB4coU+t2HmOw1H7bbU0QXqJdJXT3f+spi8X5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvXTAxqHH81u+TNe1QuCwGsa8D/ZUU3dmoz7I1TuKic=;
 b=wZhyRc/mW79g+WAaAvaXbYTpLEd2gKAyTgKN+nOcFFXOnKGCi2WoJEGnvjucxtSZr5qZaIh22RCMwcW5la8QO4Ms0qwHZWwynsEoez7ypP7wVdtwJyUH7biJAL+SQ3gCMB9xAITb/gKnXaJvlfFnR3xydFwtee+7CybGasZTwuA=
Received: from CH5PR03CA0016.namprd03.prod.outlook.com (2603:10b6:610:1f1::28)
 by CYXPR12MB9387.namprd12.prod.outlook.com (2603:10b6:930:e6::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 03:55:57 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::65) by CH5PR03CA0016.outlook.office365.com
 (2603:10b6:610:1f1::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.15 via Frontend Transport; Mon,
 26 Jan 2026 03:55:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 03:55:57 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 25 Jan 2026 21:55:55 -0600
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <YiPeng.Chai@amd.com>, Gangliang Xie
 <ganglxie@amd.com>
Subject: [PATCH 06/14] drm/amd/ras: Add table reset func for pmfw eeprom
Date: Mon, 26 Jan 2026 11:55:19 +0800
Message-ID: <20260126035527.1108488-6-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260126035527.1108488-1-ganglxie@amd.com>
References: <20260126035527.1108488-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|CYXPR12MB9387:EE_
X-MS-Office365-Filtering-Correlation-Id: 379300c3-4ff3-4d9a-7f26-08de5c8ecfa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CrUTi88JaDN0YYAZYia+evEmjwnki4STwj+59Fq14r7VwXdQm7ALoxCEPp4/?=
 =?us-ascii?Q?I8b4YbbHtzFqII2rtn6cGP624wdY476jESzJGbQfnJwiZYI8kvEmDa3OcX4n?=
 =?us-ascii?Q?J8LCMZ0LU97SDwP3ou7fRiyy8C2Q/+lSMohqxCDeyxKwsUwi0TaOvpgMvWoK?=
 =?us-ascii?Q?Q5qxfIBKD11Pe+vlXakiaH7j/A3rAhFFqoTlYqEiJT2785qnY5xOAuNqioD6?=
 =?us-ascii?Q?vePJ8G728uFW3FkZmpXgamRiXtGSd52Kb5BWaXpECggZpdWQbaeYvbStPXQF?=
 =?us-ascii?Q?9O39vN/yuLgJl5R5hC26XcO1OCftGBPpdXjByWRDKRUi21OzKk5yxVSn9QEX?=
 =?us-ascii?Q?BMtNvpKHhu00bkERGtZx82G904CaGH8gpPTujUJzCmDJOqRnoATr3QZMaZhX?=
 =?us-ascii?Q?V7AExvYXXVnRG9dzZI+8XFQhlV7f1+NohmfNraRw3zCYHu8mhKu9r4e5TEoD?=
 =?us-ascii?Q?2wsd6jtmEd2NkuE9ebjJKElyP5euGs4/FRo/DAq6sKINBT541dKsWGxiEktx?=
 =?us-ascii?Q?EzsG6QI/VixwIYEah1JylQQLefrE7/eHP+u/amfjJDlXhbC99w5ScUtyYMce?=
 =?us-ascii?Q?XEgVTCycbgjhdduTa8imSY05/93uWjiX63ZqSmn4ykMfm7zK510d1pLCvqUZ?=
 =?us-ascii?Q?00Jm5xmAGK7QailaA41kEgqMMBaWQsa+1nTjcBEsSb5I96mO5S0T8RdCyipG?=
 =?us-ascii?Q?16XedE1Picd8F279BPgwGWd08dpT6+eFRm9m/N8msmJPJGKLfd3Uz8136hq8?=
 =?us-ascii?Q?F9fAZ+k8Kg+ydq0qy6tsfnMbpYYuIWa/2wedeftfIkIyKQpGDdwOp1BAudQJ?=
 =?us-ascii?Q?aKmwraBoEDJVvi2s50hVxYqXlyVhLlfXdxalB9ENoTE+XMQ8Cwob2jfLdvzg?=
 =?us-ascii?Q?vYzhc9qtI6WJCUExd9jbZow6v4PopFKALJmHMTFL3criVvauMJ/b2viD5Zhj?=
 =?us-ascii?Q?NmMxpgKIq+TXjJyrm6SLbO1rR/j7uoHySZH8bhVYpNXxCGkviNGWUTHGuRlK?=
 =?us-ascii?Q?rPA1F5GHbyWMGlsfLlgC8P+frKteZvqpmzhqjl+6tWLIrwnQDiUDI2EqIg4j?=
 =?us-ascii?Q?rzPpp3pI84qHdy7DBrtYkL4z1K/aB+T/b4eASr8U49Xx6I2spGIG59jswh/h?=
 =?us-ascii?Q?BDJybuRrNPVlFavpxCnfJeqgFA5Ld2S2IATFtLngDdSn8Lz4p+6E2fG4vYbS?=
 =?us-ascii?Q?CVzJKJFtMr7n34SlKOxdjME00evajmFT8BkC/0VPlgl0NtYEcVZV73tD093r?=
 =?us-ascii?Q?7SymFwzmpuaXlHuoht7SbYyQo3O3dZS63dUHIpmOePxPSWGyScEN+iAq3Q8Z?=
 =?us-ascii?Q?W5dPc4q9FBunmholMwO5+HN5zozVRL/7uo3rP8iLM7sFROQOdV47Bt75YXdM?=
 =?us-ascii?Q?P6Fo9z5TkxEIxk9q4dJ6crAOQB54DQ5URLcmDZcGeml2zcf1Yw2b0UqXbBaT?=
 =?us-ascii?Q?M4LNHXPyB11qoBjau+LOlK720y++GjxL6wUhK0sbsfitfrlQyb82fRgyBp7n?=
 =?us-ascii?Q?QfDx13QgISHPohs8Nx5ecGeOtNw+bQFSYCVT8lQ6BLcwUg9V8jj8OhrrE4sc?=
 =?us-ascii?Q?jBn72GMrUlc2/HOL2MFVzfeo+uVrGM6zOFIBCH+fu4pwxwZz2au+B/DwtQA4?=
 =?us-ascii?Q?oaIINeiq4zJmIIwepZ6gIdttvMs5aOEzYtPM3kEugXZcolYfdffLAZhx+7QG?=
 =?us-ascii?Q?0PuL+w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 03:55:57.0899 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 379300c3-4ff3-4d9a-7f26-08de5c8ecfa0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9387
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
index 5231dfe8c518..31bb423b4eb7 100644
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
index ad98077d532e..8ff2d554c3ba 100644
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

