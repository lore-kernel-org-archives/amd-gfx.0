Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B53C88E47
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 03:56:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8952310E390;
	Mon, 26 Jan 2026 03:56:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a7XB8hAf";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011039.outbound.protection.outlook.com [52.101.62.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D68B10E390
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 03:56:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t+EAQr8HQDPR/194n/koIh21LsS3OgZObILrcgg6w1MDG8mEXatyZrOhhVV0B85boQedlY1XGkBYIMIqzUQffI/wRKgb3cPzhsDiLdHu4AFgyl6F6fYNCOqK7iwNV4JhnY9RTkrgNHN96KefoAI809zaFCg9nO3/Npk1maYlI4p5XDkLBHofZobTYOuA+L8yQFGkAqkrI5IiP/Jfcw8f8rCXorePFtBp1IE1y+5QUQUjtxRQiGMc8FwBayK3Y7f3BPKuyI2ue2hbHN3TT+MKPQJQyCdQHQztgL0ReABFmItK5YLfF7ZJQ3Mw4Rbn54Pky4Rudgf4BlHaGnMmbBUwMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyTAWHYUfx8L2Zl6FdjqDEvbSD1zjMRELY2LfSd9br8=;
 b=IAdBCl1qYHm83tVUgrig3hFTImkboSS1up7xdm+GtmMZ1+sXKq2mGXh4iJdi9m4HqMjAoQRN0F4IgWdrQsxteRF4lB4jhegqGKHH++3H+V/cGKFX0bXsuWbTfGZV3KeN9n3/TQBBUOm3+cwTxYwg9v+NejidUmhsM8vDnxjhto393aYMaHy1Qg74FHsZGxoCafJp0sMgTYWTZI07MlMa8520Xxz8sa6zE036MkxUOcLwRusgAwWlTLQCRWGqCseHP0oVV3OIWAtGkiI4nLs8/vRMAkdaFC7DTwhofesfT7Xbm2EZ3SZckG6FLTHyy9A0dIb7CCgZNSdkvfPJupy+nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyTAWHYUfx8L2Zl6FdjqDEvbSD1zjMRELY2LfSd9br8=;
 b=a7XB8hAfciUl3JvHFxiqO3JBr8LH4sH+wwxOcPtb/o4gTuDuleomjazm/K612FVgRRIRxxHP/BYCtqVbQxNhLCfhIsDzlS2r3MKMRyMcjxxaL1JXSaPSFmIlW3zv+sYDeNME7PjghU5QM/li1nZIooqk2gEdqaUyIrm27fGl/fQ=
Received: from DS7PR03CA0294.namprd03.prod.outlook.com (2603:10b6:5:3ad::29)
 by MW4PR12MB6850.namprd12.prod.outlook.com (2603:10b6:303:1ed::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 03:55:59 +0000
Received: from DS3PEPF000099D9.namprd04.prod.outlook.com
 (2603:10b6:5:3ad:cafe::12) by DS7PR03CA0294.outlook.office365.com
 (2603:10b6:5:3ad::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.15 via Frontend Transport; Mon,
 26 Jan 2026 03:55:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099D9.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 03:55:59 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 25 Jan 2026 21:55:57 -0600
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <YiPeng.Chai@amd.com>, Gangliang Xie
 <ganglxie@amd.com>
Subject: [PATCH 07/14] drm/amd/ras: add check safety watermark func for pmfw
 eeprom
Date: Mon, 26 Jan 2026 11:55:20 +0800
Message-ID: <20260126035527.1108488-7-ganglxie@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D9:EE_|MW4PR12MB6850:EE_
X-MS-Office365-Filtering-Correlation-Id: 42353410-a9c9-4bc1-77e5-08de5c8ed0ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Oh0cdttipr3cFsm+84jm5519vYxP41+DPggc2wILLDaADxwZ545WsF7LUkI1?=
 =?us-ascii?Q?PjTDF6NcFo/dMBaT+E5Zh+88fNz8mgXnf+2KauaCeJl/ZNsGw5GqKJBPAsD4?=
 =?us-ascii?Q?gChHwUEgvVkGcMsDeTeSFVXde12044vsvY5/ncM05smVkBESZvH1t/GmvvRn?=
 =?us-ascii?Q?m6Mq9p/jMtdCBAu7GZI+VvRhphhI9/FA2oxTv7GK2SAIfEevz914Sr6v0QII?=
 =?us-ascii?Q?Y28Q8DSF6bUU0SKTq1wJhLDHSTmjLIjDV4gjwqeNCwc44X6JZzktw2fxDlq0?=
 =?us-ascii?Q?Tnlmv1aeA+9ovAHzRuEGTsiKR8/lU5uX5qArAdoStG8W0wm3bTtj2nt5C9G0?=
 =?us-ascii?Q?Z5LfF5xLuaq2avGAX/SFgRPJbBb+ccY10PdpR/pSCTc1CKtKR9hPD/NivbO4?=
 =?us-ascii?Q?pcN+ruDciOScfjrGrrBG7eXlkQKnpfOkKQklJKWgR2VnbpyC2oaZRXPuxLSt?=
 =?us-ascii?Q?CJUhmfOxe5v9TrrXvARP7D6q6VNsZGaNEDlw8haMUSJcDqYwq8Jv+7rS6dZ3?=
 =?us-ascii?Q?ilhUGYxStzPCUsl7XO5B1g3BvlvWBzx0qTj9rVZOZKsVKQR+ZVmsuIB23Z1U?=
 =?us-ascii?Q?9qo/fg9ktQ36J9XQXbyhMWQTsLaVdCSlmGg980bbnljPZPDAiUmj2n8El117?=
 =?us-ascii?Q?T2HI1LOf2H/O+33xtmQmi7YihO+MpG/GW+7yMyaQl7yAGdG1lAZduUWlA+vo?=
 =?us-ascii?Q?rw74B0HQ0koEoIN2es2XyxQ+s7gNSbXfw79MZJqbEiewg6/aNVnmeKK7hqUa?=
 =?us-ascii?Q?FZwL0bnbz0JfZKYUPeAxGX68LZWkpjS68x32Kx9HtEypK6BcmPT6gq6M4/go?=
 =?us-ascii?Q?n8CaR9QxwBAOEzShgkiv0TgC8dDSgJUGPkaQl9IXcbvCiryNlLEI9Nu2psXa?=
 =?us-ascii?Q?fFQlMd9rYyhdnUn3bfSmjS37Ra748KT3a3lHP8E8dMfY/cPjOPn8gYa42VKg?=
 =?us-ascii?Q?xGWEZuIWm5PyM9NE3m6zAEnLJLogcQF46j9u1oBPFWuJ+pFg3LMdYRYido4e?=
 =?us-ascii?Q?le5MgNcYoRGs54fhJQwEIrCd159W2w2Vfvxd69Rfn/IBSG62cb3X5MNYjTOH?=
 =?us-ascii?Q?OD5GLl7Pegildl0ruP5DPVzLjMgfzn9mesEC2soQuES5I7o+ejh4jPsuyeQl?=
 =?us-ascii?Q?8Z4cziPYBcn3DpD7+ZTYV+icQMtnSatnwQ7RG6/NAzEtWoPyBE0ENIwXhf8B?=
 =?us-ascii?Q?y1IXF8LOPTdh4GcgUOP12TufkMUhAngCt4YrQWbN/+WG/6WEgQKHQUoCyaMC?=
 =?us-ascii?Q?RV8BA7z9gHKlZllnQNa59gS1VlVwuDHJegHns2W8YS21qktmMZfN8uXg0ZHF?=
 =?us-ascii?Q?2VduQ4emkDWL9Eic+krG6w6edpB3AcyL6dFF5HyCZESsOL0C0+2JuSD8R6qF?=
 =?us-ascii?Q?0/y6/qKn2sRxueXwnuYGuwU+uFS13TMzUlri116SnbrpiJxEAn6zCMzAarTX?=
 =?us-ascii?Q?cYCAokQ/+S9lSPpmX4MRSfKDQqEp2Yk5ONHsPoFV0kDhtgSL7jL22TH0GuA4?=
 =?us-ascii?Q?y3pGXxCfc1510znfGibeexWV2OR6YmeWhj9tQu5FWsAQYWpgdJAu9je3Ghq2?=
 =?us-ascii?Q?5P7xiCriOegVrDd+xt1B4hQRQuX2Bk5RIl89E72L7BjuVxGGLdYSvF/mdNb+?=
 =?us-ascii?Q?H/VDhYUWIXOU2ZuoqVZZYjUWSC+guEmjesMB4nefOIxUMzO7ctW9hPwJ+WLS?=
 =?us-ascii?Q?tHWBaQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 03:55:59.2784 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42353410-a9c9-4bc1-77e5-08de5c8ed0ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6850
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

add check safety watermark func for pmfw eeprom

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  |  3 ++
 drivers/gpu/drm/amd/ras/rascore/ras_core.c    |  3 ++
 .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.c   | 30 +++++++++++++++++++
 .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.h   |  1 +
 4 files changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index 923bddd0af3a..36c264ab889c 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -570,6 +570,9 @@ bool amdgpu_ras_mgr_check_eeprom_safety_watermark(struct amdgpu_device *adev)
 	if (!amdgpu_ras_mgr_is_ready(adev))
 		return false;
 
+	if (ras_fw_eeprom_supported(ras_mgr->ras_core))
+		return ras_fw_eeprom_check_safety_watermark(ras_mgr->ras_core);
+
 	return ras_eeprom_check_safety_watermark(ras_mgr->ras_core);
 }
 
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
index 91c883f16ae5..1f2ce3749d43 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
@@ -561,6 +561,9 @@ bool ras_core_is_ready(struct ras_core_context *ras_core)
 
 bool ras_core_check_safety_watermark(struct ras_core_context *ras_core)
 {
+	if (ras_fw_eeprom_supported(ras_core))
+		return ras_fw_eeprom_check_safety_watermark(ras_core);
+
 	return ras_eeprom_check_safety_watermark(ras_core);
 }
 
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
index 31bb423b4eb7..66934f61bcf9 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
@@ -190,3 +190,33 @@ int ras_fw_eeprom_reset_table(struct ras_core_context *ras_core)
 
 	return res;
 }
+
+bool ras_fw_eeprom_check_safety_watermark(struct ras_core_context *ras_core)
+{
+	struct ras_fw_eeprom_control *control = &ras_core->ras_fw_eeprom;
+	bool ret = false;
+	int bad_page_count;
+
+	if (!control->record_threshold_config)
+		return false;
+
+	bad_page_count = ras_umc_get_badpage_count(ras_core);
+
+	if (bad_page_count > control->record_threshold_count)
+		RAS_DEV_WARN(ras_core->dev, "RAS records:%d exceed threshold:%d",
+			bad_page_count, control->record_threshold_count);
+
+	if ((control->record_threshold_config == WARN_NONSTOP_OVER_THRESHOLD) ||
+		(control->record_threshold_config == NONSTOP_OVER_THRESHOLD)) {
+		RAS_DEV_WARN(ras_core->dev,
+			"Please consult AMD Service Action Guide (SAG) for appropriate service procedures.\n");
+		ret = false;
+	} else {
+		ras_core->is_rma = true;
+		RAS_DEV_WARN(ras_core->dev,
+			"Please consider adjusting the customized threshold.\n");
+		ret = true;
+	}
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
index 8ff2d554c3ba..09632f1121f0 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
@@ -67,5 +67,6 @@ int ras_fw_get_badpage_ipid(struct ras_core_context *ras_core,
 int ras_fw_erase_ras_table(struct ras_core_context *ras_core,
 				   uint32_t *result);
 int ras_fw_eeprom_reset_table(struct ras_core_context *ras_core);
+bool ras_fw_eeprom_check_safety_watermark(struct ras_core_context *ras_core);
 
 #endif
-- 
2.34.1

