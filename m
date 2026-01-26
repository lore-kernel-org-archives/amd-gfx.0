Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B8DC88E43
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 03:56:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1687110E394;
	Mon, 26 Jan 2026 03:56:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="El3yg+SN";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013009.outbound.protection.outlook.com
 [40.107.201.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A046410E38B
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 03:56:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bF/Ms2ElRiN9dZDvWk3prcJ99JDgmBNWnYItApEnxgiEQoo9izdp0mIzny0gCfokT6zG62olx3oFdP43HYsfpqkWshvKxqOyyVoVoy4naFdmErJ1QzZrXmVMc+fdRg7O2B00hl6LR/IQxhBLftnF0Y8zMEbNun3VIuobmsWCB5TaBKpvaBm5yYdLl2jkHfR//c0JU3aViVH+jmrMrmPIgImEeW0GFgMO1Laa82HdntFvDu/fhgl0R0xAE7pgEnaQtFXh6sCHVJycNRSCc9SQbPZJRLOboRMUNUYtQJD8K7eYS//GxZKxW1rXt1q7s0+LntWOHdsPWhdEcCCu9yj+EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mzh3+pPVqn3kamJ63e0oAMBu/NZH7Zh9cJCscHzskxo=;
 b=svp2v+F1BY//+oSZO5gH5JFuZXkOYH1lhsMugQRhqjtlUSoAT1jJnkhBEqeObtn5RZ7p8WSjtTExI+1jC9kThNbWOD34WWuLziuvhJoUeEK5uGLVkV75nK4NB0Ykh8UokeLjAMJJ0SYuqaoFyB6ePl5CvDtRGjAebOt8cCHoZEiS3NZ97OXDAMt22J+A//hQK8nSfAvFv/JL8dNMzOVapvE+B8KjVBn9IgVbf6UJn6Uk7xtQ6IMTsUiaqOC35Ph66Y3ONuYeiurawQOp4M0jRaTVitnScRJZt4k2O0JYao1jgqfwJDiQpuxRxOE1gPs+oHuT/Y3xRtuBOikci/K0/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mzh3+pPVqn3kamJ63e0oAMBu/NZH7Zh9cJCscHzskxo=;
 b=El3yg+SN+R4iRVBHLsXOg5wYanzFKie5+o5lUiU4XUDj3ewATWhXoAuHlu+9I+Oxf9+FfwN7JCsay5tP+ueG2eiqioMpQfOJs+CvGShdUSLpMNCMedDpYAZiNyoj4+8dPYhHyRn+EUCq9B2xJzChWyboVpt3pRl18umBHXlGMWo=
Received: from DS7PR03CA0236.namprd03.prod.outlook.com (2603:10b6:5:3ba::31)
 by IA0PR12MB9009.namprd12.prod.outlook.com (2603:10b6:208:48f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 03:56:04 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:5:3ba:cafe::37) by DS7PR03CA0236.outlook.office365.com
 (2603:10b6:5:3ba::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.15 via Frontend Transport; Mon,
 26 Jan 2026 03:55:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 03:56:03 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 25 Jan 2026 21:55:59 -0600
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <YiPeng.Chai@amd.com>, Gangliang Xie
 <ganglxie@amd.com>
Subject: [PATCH 08/14] drm/amd/ras: add append func for pmfw eeprom
Date: Mon, 26 Jan 2026 11:55:21 +0800
Message-ID: <20260126035527.1108488-8-ganglxie@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|IA0PR12MB9009:EE_
X-MS-Office365-Filtering-Correlation-Id: ce5df242-a5cf-44b6-6812-08de5c8ed366
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bnrjWIgoHlMpEyzRSxqXgXig/QoBLzRSMBu76kwKNf/iJZo5+lkEoMejDMXE?=
 =?us-ascii?Q?2sX0epMHyTypITyunrcfdHoGBWztcbuR2UYyw61XerZR43HJ7nPyhTbSjKjA?=
 =?us-ascii?Q?THwKNUXvROPKRBwRJb55P31EdlHgaYE4MkharyNcQH8nwFEUEZ6ZkuKbDuRj?=
 =?us-ascii?Q?KYZ9VNZSwidIIOhg1Up7rlQLwdgMAKNxdp8Fg2OO9zkGdFkbmH64uKLBDN0M?=
 =?us-ascii?Q?h/SsG46eLVQwDOsZOYHwm4TnbG1iAAEVxB59mx5pHMudKzk04aqMdJFKt1Uu?=
 =?us-ascii?Q?KAtqplQ92jqufXuhCg9LjK81NCbv96ollTldaFSxeKrLkEn9IaIs15blGXzl?=
 =?us-ascii?Q?2XcZHDkWAMr82GL92pCAxQM3F12MMp5lLThCcHdl5o5i4dZNp1uZzPEtauGM?=
 =?us-ascii?Q?27UP4R3B85QLzyKzN97dwdWexnHxKmjsFGC8o9d7lLRk3gAx/VIxdmsTUnBn?=
 =?us-ascii?Q?jelIheaZ9acBuCE0ViE6iG5ULAsm1p85UDa3LyCKUy/m3etPIDy/55Bewcgl?=
 =?us-ascii?Q?AI4ZWJyQFsG0ERaOmc639OMry697/+JonQDoOpJ+Hs28txxhlqjXcUfvP130?=
 =?us-ascii?Q?fHGaI+OEC8QUg+JRgfOh5v+wGkuShyHaQ7vbBkRYBZu2FXqUx3dn7Rd3kF6T?=
 =?us-ascii?Q?ul5cumbJePdxMQ5WrE+Co5m5UZGhWEO3FJvOhHunAU4DhMmLTVX2AwG1QgVa?=
 =?us-ascii?Q?t6PlROwBs1UKDO1RkC1Z9Rig0sQwydKia4BiRt/gnIJxIbwIq+uhf21hrn56?=
 =?us-ascii?Q?S8+WRsljj90FkvrEDIEP9iSencVHuqYcNQjCJnDzjhQCNASKkeioEAuBtC0M?=
 =?us-ascii?Q?nyClQMEJdoD00Xxs8NAZtiv+abEExVtE5S4poiz7AdYOlC7th7Q04xqkAN4B?=
 =?us-ascii?Q?/DCkErj9/9iFoHOI7zAku11sZJFWMNEgaO1WrSd25s04JeMLBRSv5WcI22WA?=
 =?us-ascii?Q?/n9TkN2nLaG+LHpIVSSVL2N+PMyRxnyOexWGJBbyrNJN3LjvOcWFOQRYwV0R?=
 =?us-ascii?Q?GVwsO7yIr1VNCVLw1s/6dfniTjMixBt6w7iDxvhWKHVjzPyrMHvUDMg/Tgeb?=
 =?us-ascii?Q?th67UDhghJhiNsU+wEnZ1optW2xr03hl1vt3SL0EEpfxw/ocnN1b46FYJZnO?=
 =?us-ascii?Q?ixi8z/N2J+J9d1Fxdd8KL0p9sk2O2djNMJwIdsSAOWFRcyAcoFQCaAdrQn3p?=
 =?us-ascii?Q?FuKY3PCjD4AMfg+HGaq57gWcW13K1Hevg5CTAsrrw/U2KMXRovTfsebIIgzE?=
 =?us-ascii?Q?elrC8OtA8nh37Qi3r8eC/YAAMQ12qXsO83ccJJnjgFk4PUQbY9492q5j588/?=
 =?us-ascii?Q?J10G4O0ItAvHhEmcggPQYmF4pU1vRyEzLqnPBdQRt8FmBZC/heZJiN22e2Z/?=
 =?us-ascii?Q?U78Ab6jevMEVM0OuHIKOjTkfzri41r1aSHQIRsnJ+Q3iTxKOL+iww2eDpJ26?=
 =?us-ascii?Q?ztPXxrccXi6H8QXOyatAPyKaxSreUntBkaGc5lSJpt+hgcbf36xL5kxMGl7d?=
 =?us-ascii?Q?G8DlKcXxZTcJdQF/NZsOfv+47MyIN3GyRyGXAa5BhqI2tPY2DI+VsqA5VBGM?=
 =?us-ascii?Q?8HN+VYrQgIQ+RexZzwkPIFrAFKd4xzZavt9j8dIe53LR5LnxaqkkLJLi764o?=
 =?us-ascii?Q?6j17EiZHAN+ntfGUHmWk6GhVLhl9EdB06vhMfOqu3j14eQqq7vcQzzvw6VyV?=
 =?us-ascii?Q?isY/Eg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 03:56:03.4544 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5df242-a5cf-44b6-6812-08de5c8ed366
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9009
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

add append func for pmfw eeprom

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.c   | 39 +++++++++++++++++++
 .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.h   |  2 +
 drivers/gpu/drm/amd/ras/rascore/ras_umc.c     | 10 +++--
 3 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
index 66934f61bcf9..f7a6f2368530 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
@@ -220,3 +220,42 @@ bool ras_fw_eeprom_check_safety_watermark(struct ras_core_context *ras_core)
 
 	return ret;
 }
+
+int ras_fw_eeprom_append(struct ras_core_context *ras_core,
+			   struct eeprom_umc_record *record, const u32 num)
+{
+	struct ras_fw_eeprom_control *control = &ras_core->ras_fw_eeprom;
+	int threshold_config = control->record_threshold_config;
+	int i, bad_page_count;
+
+	mutex_lock(&control->ras_tbl_mutex);
+
+	for (i = 0; i < num; i++) {
+		/* update bad channel bitmap */
+		if ((record[i].mem_channel < BITS_PER_TYPE(control->bad_channel_bitmap)) &&
+			!(control->bad_channel_bitmap & (1 << record[i].mem_channel))) {
+			control->bad_channel_bitmap |= 1 << record[i].mem_channel;
+			control->update_channel_flag = true;
+		}
+	}
+	control->ras_num_recs += num;
+
+	bad_page_count = ras_umc_get_badpage_count(ras_core);
+
+	if (threshold_config != 0 &&
+		bad_page_count > control->record_threshold_count) {
+		RAS_DEV_WARN(ras_core->dev,
+			"Saved bad pages %d reaches threshold value %d\n",
+			bad_page_count, control->record_threshold_count);
+
+		if ((threshold_config != WARN_NONSTOP_OVER_THRESHOLD) &&
+			(threshold_config != NONSTOP_OVER_THRESHOLD))
+			ras_core->is_rma = true;
+
+		/* ignore the -ENOTSUPP return value */
+		ras_core_event_notify(ras_core, RAS_EVENT_ID__DEVICE_RMA, NULL);
+	}
+
+	mutex_unlock(&control->ras_tbl_mutex);
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
index 09632f1121f0..27507bb38135 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
@@ -68,5 +68,7 @@ int ras_fw_erase_ras_table(struct ras_core_context *ras_core,
 				   uint32_t *result);
 int ras_fw_eeprom_reset_table(struct ras_core_context *ras_core);
 bool ras_fw_eeprom_check_safety_watermark(struct ras_core_context *ras_core);
+int ras_fw_eeprom_append(struct ras_core_context *ras_core,
+			   struct eeprom_umc_record *record, const u32 num);
 
 #endif
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
index 4dae64c424a2..fd427fd59ecf 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
@@ -479,9 +479,13 @@ static int ras_umc_save_bad_pages(struct ras_core_context *ras_core)
 	save_count = data->count - eeprom_record_num;
 	/* only new entries are saved */
 	if (save_count > 0) {
-		if (ras_eeprom_append(ras_core,
-					   &data->bps[eeprom_record_num],
-					   save_count)) {
+		if (ras_fw_eeprom_supported(ras_core))
+			ret = ras_fw_eeprom_append(ras_core, &data->bps[eeprom_record_num],
+					save_count);
+		else
+			ret = ras_eeprom_append(ras_core, &data->bps[eeprom_record_num],
+					save_count);
+		if (ret) {
 			RAS_DEV_ERR(ras_core->dev, "Failed to save EEPROM table data!");
 			ret = -EIO;
 			goto exit;
-- 
2.34.1

