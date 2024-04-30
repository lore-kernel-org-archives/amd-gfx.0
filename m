Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CAA1C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 21:12:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D967E10E45C;
	Tue, 30 Apr 2024 21:12:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iip9m5Xk";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 044FE10E45C
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 21:12:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A51y2CJ48PIVVuaVR6bKOK5DHc5kLEXH4DKTXXYiVhtTd4Mosx0qAJNXuOfGxg/rUq83VxHQ6s2Pi1NMw/wu+AdVDdI80/hPWP6ptw87JLcE9LTI3CFUEnMkaHp0tX22i/T2bhD2PPi8A8AXeLPwXEgsK2O0oBYW1aMU8mrx//vaWYH9qFIxbppQrzo1tdeR6/tJPgMo21y5xXfz6T7czExIkaEqu2pApdc8RpLGDwxIAggnBmehPve0ARKmu13qoZmx7juE8w1or19w8vLk3mPM8znTZ/EHXAVJzNVyb4ZxHVFpqfCRP8dsqeLIBXBnuyBeJ5gAklUy9wj9zB3ZNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSv6n3Sj7ixPqnKrNxhZXM2fvRJEvxH5DwNPmnuGY2k=;
 b=TIFpxIpT/ps2g+YMqrY8FULphot92wDXG9suN4D/TJiOwpidMVP4eHmE3AYbNujr8scjbDaaeLnBYSYlUJhI7aryWSKCE2ZZzK8VRPKkg/20l8q0HKmF5rTsxrbwn9u4ueoE2PKEoh4llrnuzE+W9KrCWVxT8DgzJAUvTgwQH8xs/w+Ljn3R7QjI7FnNWMq5lMu6gtE5hjiKvADyV1bo1YuEOeWaS1LQD5XI+wW6c0G49qozyBmgTef3ZyM0Esj6zC/WmiQjaFDf2+NiqNpXX29s6I+0mc+Jym2c1YnNUpmNfwL/OqVKqBmgT0LiumrOmy2yMzLLdfkl4cH71tgE7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSv6n3Sj7ixPqnKrNxhZXM2fvRJEvxH5DwNPmnuGY2k=;
 b=iip9m5XkfyHeAdQuC3pAfB5hkiHDgmJyxxnv+hylNrXnsmRd/aOTxmIB7bpzQ64S2LwscVvJJv8B8Pb6uIOpj2E2+EkxF+yjFg4YZygZ0TrOE0QCk6mtuqPo9eMYFvYWkOi5gdYcJC9mk4P1MpwU3wEjjxyMtFpXuAQP3PogJ3s=
Received: from BYAPR06CA0028.namprd06.prod.outlook.com (2603:10b6:a03:d4::41)
 by IA0PR12MB7627.namprd12.prod.outlook.com (2603:10b6:208:437::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 21:12:50 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:a03:d4:cafe::91) by BYAPR06CA0028.outlook.office365.com
 (2603:10b6:a03:d4::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36 via Frontend
 Transport; Tue, 30 Apr 2024 21:12:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 21:12:46 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 16:12:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Le Ma <Le.Ma@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Add smu v13_0_14 ip block
Date: Tue, 30 Apr 2024 17:12:11 -0400
Message-ID: <20240430211212.814162-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430211212.814162-1-alexander.deucher@amd.com>
References: <20240430211212.814162-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|IA0PR12MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: b9360841-5933-4c04-5e9e-08dc695a487f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400014|36860700004|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?B1kPznpKpm2nizH2Adsf1soBijAZieXPzuFtZ/gKcavUIb0yjfcdQWDswzlH?=
 =?us-ascii?Q?3+Sa6nnmn45xRVU3qY8hBb1AMnQjoCi7XxL6/6ulvNPrMmst0pMBP0Kce/iy?=
 =?us-ascii?Q?kJb8ncaClbF0av//jS3p3QTk0zPAYJy9aYFBWF1o0JNL6LWoMxCzpOpI+B6B?=
 =?us-ascii?Q?ke7bwxBynhZqM7pDjUbPSDDesY3KUPrZYrZ5N8kEJmmfS8g/NFxW3JAUwWFD?=
 =?us-ascii?Q?8CIs7hrqDcPx2LL3CPtpGrPJzue75N0W8EDfo/KC0CBfJSTfBrcxU/PPu3lP?=
 =?us-ascii?Q?xyPKag5YJcUqi0gdZcUc7m4p1Sqq1/bA61apTYeFa56L3pLgfTDGY+4axCNM?=
 =?us-ascii?Q?VyauygQPiZG9eUQdOgyTez2sDDPlu2rPl9y0igqc+I/2wQTq3QJJoQVxNg8g?=
 =?us-ascii?Q?5+Qwt/y8tSPwAEQnejNorNtVikawntdv6zNEzi2F+dm6cDEDylU+nyaSZ1aB?=
 =?us-ascii?Q?UAbh2XEdwdIcxnIT2OeyGWl0kxDibE8ncRKgtzm0p4GV71AhelGeG3TB7fAq?=
 =?us-ascii?Q?M06D8PD7K1Cc/fmHZ0xabrSLebP2Mm1IbFABcEHtm4QEOWAFH8XXghXcq1fn?=
 =?us-ascii?Q?+iIQEvL9FG4+YhQ8sF4O6lXkHhfcwxGA8B9sxfPpChAIaqpEQq8GufKSYLsS?=
 =?us-ascii?Q?QQi61hKywqy6rGReS2NtDxNK6zScZt0xHnAbD6BCkrxwYVWwAEPcgWHVLBNY?=
 =?us-ascii?Q?MMfEVl9dPA/8nXPYjClH4saYLeLN1ZfLHQP5N6PzOA7Yc3rwAU3GkRZ5dwn/?=
 =?us-ascii?Q?3FrnqQk78ObvfxC0B84HHW5bp/apssoF5AzkFR8fcJg2Ks9ytjWhQMd8T2bg?=
 =?us-ascii?Q?X5KGdaf+LSvuFgc/+BYP8payg2rToB3RqDd/YRMVxSrBgi3rxvSLkeojT0Z9?=
 =?us-ascii?Q?n7pQTMemYG7QsqIWBwnOjOqNaMsJm4HlPFNVWqVZZM1njP5+6SIejS5DqeJy?=
 =?us-ascii?Q?lQhDgV3cNDZ1f54S6oRXKxxvhcaHrEZhRQ5xLjE31HYUc6zGOYkO4oGBrYZ8?=
 =?us-ascii?Q?RyECCcdRnvn8odJStgqXCsUGkrqTWZZFBcJEeSil8+QUgbZqFAcsZVH23irD?=
 =?us-ascii?Q?UYfWI8IuU+mKE6opM+sK20+nbHflfK2hEOhsoTGM8NJe9ZQ5XVfz8+elvKYw?=
 =?us-ascii?Q?gyQjwpote3yfuo4hI9CTJ4ctvPp3ImTd/AIUNXj0I0xlsr6Fqx3+Fq4OWVwZ?=
 =?us-ascii?Q?AAPNooXVoDZma/Aw+GyGpy4GL76Rq0FFQKu2sSrglLVWFeXJocZrTbMwgCeq?=
 =?us-ascii?Q?jQ+p7X7+TyzLoWVPfm9DNGl8FWqTUusKoyggeKfOl9jDf9RARRUBBaKzow/+?=
 =?us-ascii?Q?zmECgd7V6YNfCPfxswslVDMpzpEzPfKwEQMj5Jm//Rxu68Ej1/pL4ab9X42C?=
 =?us-ascii?Q?+rcYpZgCFacRs5iPmfEKeD4l3HhU?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 21:12:46.2641 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9360841-5933-4c04-5e9e-08dc695a487f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7627
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Add smu v13_0_14 ip block support

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <Le.Ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c              | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c        | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c       | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c              | 4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c       | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c            | 2 ++
 drivers/gpu/drm/amd/amdgpu/soc15.c                   | 4 +++-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c            | 2 ++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c       | 3 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 7 +++++--
 10 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index c50202215f6b1..b6b757268b8e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -759,7 +759,7 @@ static int aca_bank_get_error_code(struct amdgpu_device *adev, struct aca_bank *
 	if (!smu_funcs || !smu_funcs->parse_error_code)
 		return -EOPNOTSUPP;
 
-	return smu_funcs->parse_error_code(adev, bank);
+	return (smu_funcs->parse_error_code(adev, bank));
 }
 
 int aca_bank_check_error_codes(struct amdgpu_device *adev, struct aca_bank *bank, int *err_codes, int size)
@@ -892,7 +892,9 @@ DEFINE_DEBUGFS_ATTRIBUTE(aca_debug_mode_fops, NULL, amdgpu_aca_smu_debug_mode_se
 void amdgpu_aca_smu_debugfs_init(struct amdgpu_device *adev, struct dentry *root)
 {
 #if defined(CONFIG_DEBUG_FS)
-	if (!root || adev->ip_versions[MP1_HWIP][0] != IP_VERSION(13, 0, 6))
+	if (!root ||
+	    (adev->ip_versions[MP1_HWIP][0] != IP_VERSION(13, 0, 6) &&
+	     adev->ip_versions[MP1_HWIP][0] != IP_VERSION(13, 0, 14)))
 		return;
 
 	debugfs_create_file("aca_debug_mode", 0200, root, adev, &aca_debug_mode_fops);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index b68cd3b9d60ab..8384cda48b29f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1910,6 +1910,7 @@ static int amdgpu_discovery_set_smu_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 8):
 	case IP_VERSION(13, 0, 10):
 	case IP_VERSION(13, 0, 11):
+	case IP_VERSION(13, 0, 14):
 		amdgpu_device_ip_block_add(adev, &smu_v13_0_ip_block);
 		break;
 	case IP_VERSION(14, 0, 0):
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index a08c148b13f92..ceb5163480f4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -100,6 +100,7 @@ static bool is_fru_eeprom_supported(struct amdgpu_device *adev, u32 *fru_addr)
 				*fru_addr = FRU_EEPROM_MADDR_6;
 		return true;
 	case IP_VERSION(13, 0, 6):
+	case IP_VERSION(13, 0, 14):
 			if (fru_addr)
 				*fru_addr = FRU_EEPROM_MADDR_8;
 			return true;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
index a111751b97818..7b7040ec61bd7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -609,7 +609,9 @@ DEFINE_DEBUGFS_ATTRIBUTE(mca_debug_mode_fops, NULL, amdgpu_mca_smu_debug_mode_se
 void amdgpu_mca_smu_debugfs_init(struct amdgpu_device *adev, struct dentry *root)
 {
 #if defined(CONFIG_DEBUG_FS)
-	if (!root || amdgpu_ip_version(adev, MP1_HWIP, 0) != IP_VERSION(13, 0, 6))
+	if (!root ||
+	    (amdgpu_ip_version(adev, MP1_HWIP, 0) != IP_VERSION(13, 0, 6) &&
+	     amdgpu_ip_version(adev, MP1_HWIP, 0) != IP_VERSION(13, 0, 14)))
 		return;
 
 	debugfs_create_file("mca_debug_mode", 0200, root, adev, &mca_debug_mode_fops);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 06a62a8a992e9..9b789dcc2bd17 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -161,6 +161,7 @@ static bool __is_ras_eeprom_supported(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 10):
 		return true;
 	case IP_VERSION(13, 0, 6):
+	case IP_VERSION(13, 0, 14):
 		return (adev->gmc.is_app_apu) ? false : true;
 	default:
 		return false;
@@ -222,6 +223,7 @@ static bool __get_eeprom_i2c_addr(struct amdgpu_device *adev,
 		return true;
 	case IP_VERSION(13, 0, 6):
 	case IP_VERSION(13, 0, 10):
+	case IP_VERSION(13, 0, 14):
 		control->i2c_address = EEPROM_I2C_MADDR_4;
 		return true;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index ea4873f6ccd19..bfdde772b7ee0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -33,6 +33,7 @@ int amdgpu_reset_init(struct amdgpu_device *adev)
 	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
 	case IP_VERSION(13, 0, 2):
 	case IP_VERSION(13, 0, 6):
+	case IP_VERSION(13, 0, 14):
 		ret = aldebaran_reset_init(adev);
 		break;
 	case IP_VERSION(11, 0, 7):
@@ -55,6 +56,7 @@ int amdgpu_reset_fini(struct amdgpu_device *adev)
 	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
 	case IP_VERSION(13, 0, 2):
 	case IP_VERSION(13, 0, 6):
+	case IP_VERSION(13, 0, 14):
 		ret = aldebaran_reset_fini(adev);
 		break;
 	case IP_VERSION(11, 0, 7):
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 55ee5ac828794..5169795df38c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -326,7 +326,8 @@ static u32 soc15_get_xclk(struct amdgpu_device *adev)
 
 	if (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(12, 0, 0) ||
 	    amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(12, 0, 1) ||
-	    amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 6))
+	    amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 6) ||
+	    amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 14))
 		return 10000;
 	if (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(10, 0, 0) ||
 	    amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(10, 0, 1))
@@ -554,6 +555,7 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
 			return AMD_RESET_METHOD_MODE2;
 		break;
 	case IP_VERSION(13, 0, 6):
+	case IP_VERSION(13, 0, 14):
 		/* Use gpu_recovery param to target a reset method.
 		 * Enable triggering of GPU reset only if specified
 		 * by module parameter.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 7789b313285c4..bdf9f80311870 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -705,6 +705,7 @@ static int smu_set_funcs(struct amdgpu_device *adev)
 		smu_v13_0_0_set_ppt_funcs(smu);
 		break;
 	case IP_VERSION(13, 0, 6):
+	case IP_VERSION(13, 0, 14):
 		smu_v13_0_6_set_ppt_funcs(smu);
 		/* Enable pp_od_clk_voltage node */
 		smu->od_enabled = true;
@@ -2716,6 +2717,7 @@ int smu_get_power_limit(void *handle,
 			switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
 			case IP_VERSION(13, 0, 2):
 			case IP_VERSION(13, 0, 6):
+			case IP_VERSION(13, 0, 14):
 			case IP_VERSION(11, 0, 7):
 			case IP_VERSION(11, 0, 11):
 			case IP_VERSION(11, 0, 12):
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index ed5a7a83c9e27..0fd25b72a40c2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -271,7 +271,8 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
 	smu_minor = (smu_version >> 8) & 0xff;
 	smu_debug = (smu_version >> 0) & 0xff;
 	if (smu->is_apu ||
-	    amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 6))
+	    amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 6) ||
+	    amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 14))
 		adev->pm.fw_version = smu_version;
 
 	/* only for dGPU w/ SMU13*/
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index a923e44451d62..051092f1b1b4a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -68,6 +68,7 @@
 #undef pr_debug
 
 MODULE_FIRMWARE("amdgpu/smu_13_0_6.bin");
+MODULE_FIRMWARE("amdgpu/smu_13_0_14.bin");
 
 #define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.smu_i2c))
 
@@ -462,8 +463,10 @@ static ssize_t smu_v13_0_6_get_pm_metrics(struct smu_context *smu,
 
 	memset(&pm_metrics->common_header, 0,
 	       sizeof(pm_metrics->common_header));
-	pm_metrics->common_header.mp1_ip_discovery_version =
-		IP_VERSION(13, 0, 6);
+	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 6))
+		pm_metrics->common_header.mp1_ip_discovery_version = IP_VERSION(13, 0, 6);
+	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 14))
+		pm_metrics->common_header.mp1_ip_discovery_version = IP_VERSION(13, 0, 14);
 	pm_metrics->common_header.pmfw_version = pmfw_version;
 	pm_metrics->common_header.pmmetrics_version = table_version;
 	pm_metrics->common_header.structure_size =
-- 
2.44.0

