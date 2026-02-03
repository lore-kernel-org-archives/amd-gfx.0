Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F71DE83040
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 04:13:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F58C10E4F0;
	Tue,  3 Feb 2026 04:13:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hUdDLqcK";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012065.outbound.protection.outlook.com [40.107.209.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3496210E4F5
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 04:13:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hCTshzKaXgFHNqukbQAv9/5FF4G5POHt8Ju8JK/+zMy9vsdWLptVgNg9+DKUj2Bb7ielWnk1zpQVIjbpgExypsF9IEoXKvE5GfwcAA+aLs4tRUl+CmAtXRoEOyiA/bgzXLxA5WhMTHDZjjh0cnR1ATuJDil59yArrEfVY/e3x6V+Tg4QB0hfKm1pvpB9HvPtPROROp1aW9AF55UHY9Kg006cOmtCNRevg6fXlktCJ/6FC8zxaMDYbuOH5LlLtmcNhe79PYYcF4mJo+qv4n976yhVlg0FOnq88e7c0rP+9IPItggCFanaQIt5+MWJw5TppjqTqOhUeTOEOa1sbArVUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GwGKvy3ksz6CtDaY8KWJIQGouVF6yK+c6rqVt6pEggc=;
 b=PUSg2FCCzh9ls713pK6nx2l2biXjTCRXKuzAmv+xZuIhMUEZ4veRxfy1Cp8FrW/AEIHa8At6VhgXQcJL94ReNS7KJfcp3avit4W2TXIm618GilzBcLnsYK9+PDY6n8tDDRjl7PwiOpT9FfS4nQXBcE0TyPADxDiBs1lAJn+amSmnjNxO4CRw12PwmmpLdyjrwr9Ob4gjUbrf+TpojmdDO6NsXXjUiIuK9nYr6pFEOVkjIfUcPsOwR1IXPuX+IQ3BNfPzq8SHUi0Unskc3rS0VbaPZXWurMlqbRgyPhc2lQWGap72eq7xQ0DHzLrnDCb6UI++bQ0de8PoHI6obSP3Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GwGKvy3ksz6CtDaY8KWJIQGouVF6yK+c6rqVt6pEggc=;
 b=hUdDLqcKoBa+s9QjlfQBXNnCEu8Txe1fjbfyXSPExrm8AUjmZJKtXr2s8lw2EWcmMBvXOAm8BgVlwpDtYVXJrXWzOePP738UHv7YKWOukEaQRk63UPCDAowQxJWdtNoO3CdjuwHQJnJdOeCCWFirtPYymnGHH+roM4kc10esmJ8=
Received: from BN1PR12CA0001.namprd12.prod.outlook.com (2603:10b6:408:e1::6)
 by DS0PR12MB9397.namprd12.prod.outlook.com (2603:10b6:8:1bd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.12; Tue, 3 Feb
 2026 04:12:57 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:408:e1:cafe::a2) by BN1PR12CA0001.outlook.office365.com
 (2603:10b6:408:e1::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 04:12:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 04:12:57 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 2 Feb 2026 22:12:55 -0600
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <YiPeng.Chai@amd.com>, <KevinYang.Wang@amd.com>,
 Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH V2 08/14] drm/amd/ras: add append func for pmfw eeprom
Date: Tue, 3 Feb 2026 12:12:00 +0800
Message-ID: <20260203041206.1299104-8-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260203041206.1299104-1-ganglxie@amd.com>
References: <20260203041206.1299104-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|DS0PR12MB9397:EE_
X-MS-Office365-Filtering-Correlation-Id: c5ef5a43-ef6e-4aba-30f4-08de62da82eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zVsj/WHNtxs+oQ8PzA3LAembhIpf6G/rU8tkd25kMGPnyf9NOlQ+BBShqqEl?=
 =?us-ascii?Q?AGRVVkEkyuUz87MBtZkXo5LH0LMfkkQZ+ZcLgmQD22z4BAS1d+iTKB7/6HgY?=
 =?us-ascii?Q?yVjkDY4hg9kcqIMgSYwpGhThi38pIRoPIUpVV4WQibmMIX25fov5mMEY/tqq?=
 =?us-ascii?Q?NvZnInFpHDGkqRU0O0Jc/KTdSX9ONmqgWcVySOyqdJrM8zBB0zbC3xFqirN+?=
 =?us-ascii?Q?FJhu4s1rzlNVoT0U1HgiQHO+VP1i7dZRCRWNKsyOSdlHD7QCqdy3z9JRcGen?=
 =?us-ascii?Q?k0UJlO+JcuiBh974ueHRQamyz4lgLm/DGWHDaTUcX1aBXzws7dq7na5GMx3N?=
 =?us-ascii?Q?u4yimUVmIBooFbBEl2qin2dAUwIZiZLV4gE+9PDKfdRVT6ZsP9qD+sW3XCqp?=
 =?us-ascii?Q?GQ8V6cUpA6zl8wag+bFb7GS6hTdEnDvQZxIf82MaKTVrPbwvAcahV2XTRzxl?=
 =?us-ascii?Q?aLD9XTFYA1LiMCaMZ/VhWS+J/CIL7QU/J7MILFae19T52Qp5THArKsadNnvx?=
 =?us-ascii?Q?hYy61V3711rcz5I7rJKug+8Tr4nwv8yxo0B/CsnORIZRRWqfd4uFRoXiYw/u?=
 =?us-ascii?Q?HzDTpqq5RX2Ybzk0YEFO7aKtWJQsdSr9KGTFo+a5xDfCqAfTgZlTuuw8srhe?=
 =?us-ascii?Q?ojf7oL5WsTFOfsT5k6HVWUo6poa89rLqLljsKvPEvWCDh1mrIRaudscdUp5E?=
 =?us-ascii?Q?lTa9LanbVItpeOhZzRQruouQv7md60GHs3numfx3PIUBHfkIgfamtRK8n2Fz?=
 =?us-ascii?Q?QEUv/5bXSlTzXUKoNYf/HW0i+FKdc5fjApvUPtpkgnGpLFIzyRoPFKFCeZdP?=
 =?us-ascii?Q?615Hn1j4E9JBoiBIlBrcS6GS67x8jILfrbFc/PBEu3ZKPrilITbeI5+8LVfF?=
 =?us-ascii?Q?l5jjc4Qpui8Rnk9SwSNL4Uee+X+zSlz8P6LFJktQQka3vJoHNXR6jhTisww5?=
 =?us-ascii?Q?YWzzBgqH7lg0QpD8CzqCfKmGt/bp9y+Yy3nS1Pekgl0/fw+9qedSERVuImQj?=
 =?us-ascii?Q?hphrgQv2DFI4vBbNhuR4LTm2Bsqm56mH0I7JjlCczOF28r8W6kw/f0Pvdq59?=
 =?us-ascii?Q?bajk0GF9z050bOhIla3PKpa6HepTp9Z24U3kXl+Wkkve6onpnO73txqQEDI3?=
 =?us-ascii?Q?ygnK5UIAffgpv0oECM39Onv4Q0vCxrwuCUIutcPHiO9UnQlnlnfvb/wG6iQG?=
 =?us-ascii?Q?miyeGocLMEoDCtLVs6I3NTF3JJSF9aZW+LzPBGmToJYJySGtsWZH3YBVZm1H?=
 =?us-ascii?Q?NqvWkGHDETLIJgRjGwCELqvsBgJ9M47WI4yrrFurWKiY59DpUPstTukRffCZ?=
 =?us-ascii?Q?xPfGYDfExongIChU8KnPjaVhntKcDq+q9weh0kboZME9O3E/OHlCNSzRGzha?=
 =?us-ascii?Q?61hsVUs4TyynDx7a9khOaE3pGJDtsKibwjLLUjvL6bxhG4idahzLXcdKZtl3?=
 =?us-ascii?Q?ejBwO6tNFa/l43JRyf0NPwkKUonSCDAVWEwDgG7jcS+YoM41E7iNMBQ799xu?=
 =?us-ascii?Q?zkeubTvBfQa61POnCtTLhXamDX7h7He/9wlwSowI3vI3V0nljIyZxyAu0PbU?=
 =?us-ascii?Q?P//Pi9BjmKZ3mFGUr5N6yNFHpI21y/t8eEhYy+B+smHMUfU7PX8l0Jv5PIhz?=
 =?us-ascii?Q?5127HEcmj45bhpJG9JrjwXYjODI9zoQKzIWrUkoRsnfYh1t8cpYtalCMem+b?=
 =?us-ascii?Q?YAk9Pw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OIIwtmQAz7TT9qpjvJ40Pi9StEYRWL4CCmNvJ8OEeiQQ9RHm5AMzuaZnhyFE2s3923onlb0h9pBM8bVdjpu2y9wYektP6dya4G2of3zIRoQiSqwlH40KabX6pZlOqdnC0+GAx/94Al2st0KEy463jv3QR5An5h7oYarDmJJN3OsZzTQz3SryigvzMzDjhuTbA58ywL1MQbJFHHaKdg1LJoCju+qMuDWI9Wq6/O8nUDu4b/VC4a/FiafDGyuvxjBA+BYqd+7GT/1PTu/KmA5bK79NYn7NFyUA2EabBeewTxHJnica7BVN7jzKw8SZnRgzMUGSvmqajBGUcr32CosN9Uh4Ged9lfqy8RLZBLP6qs2D8j4u+2LTTeniuKdbDm7sH+4miN/yiESR6IpC59OtD7GzWjB1kAKLBHnPdkoe8t9MLJQrVmOHqhOJBoVaq8MK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 04:12:57.1595 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ef5a43-ef6e-4aba-30f4-08de62da82eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9397
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
index 34a4161251b3..580dd7b09d00 100644
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
index b0d3eade4377..b94d3c9703e3 100644
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

