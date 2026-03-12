Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 434FF103E301
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2026 10:28:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2A3810E9CF;
	Thu, 12 Mar 2026 10:28:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0ic500p9";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011053.outbound.protection.outlook.com [40.107.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65BB510E9CF
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 10:28:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lDWlrIpVGrpfWmTLwws6aRf/mRGT+rZWC+dwJBylCOH+wCcIunFIIoFPziifQX8Vu5TMWdN5B8OLwc92GviePfCE4q71xg7qH2qizgNdWubYZRJ5X3zE6QXEuVSX4CCzLEq/sBnEyUgeefkq75D95MZeFmOa8bc0NgIm13rjWS2PAEuc9JXBmvlPPyihJIJv5zZOB8Ox7BtptJIHDKXYCcM0Kio7bcCAJUDauN6UQYqG+aN969jGEqK3ogcrXtejGt5x1eO1CuA291q3CzqqdtvratZ2a1w2sqTxiyv5jk0RAO2LMyZSeRbL3rFut6agcALkVRsZAUbZjLc55sxAHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3DbEIJffECOXw/RjoBtsQT+zF8fU8jENMfpDO7Y/L2g=;
 b=aTOstdvpHsv4Z1Pn8vGMcHAJXJzbptiVTq4tYo2hahExc63W4MYu1DC15XYpf3lZFTJ5MzEFtvsG/A7teNNysJ6V4C9KvK7HpAALffb1gNDSpw37+uKSOXfGmrJaEd0mpcTmQzhHfR+8C2oS+jndXpCKSBc/FuOJDjeYknNRb+KqeG3Z4GY3CsFVbUDPcgwTkjVRuqbYkYW1kbpX8w+7WVTLJAi3ckwOXMKHgrPVstO+jlvHhtf/DaMoC0ven+TtPhjyZHrAw5HJOt5QuThBNaZ7J9DXDlPM6khXSmimkwchiPehKHNfwvdBu2UbhIwP9u21/jOBceD9hduWZjZ8Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DbEIJffECOXw/RjoBtsQT+zF8fU8jENMfpDO7Y/L2g=;
 b=0ic500p95ymlOzwTAV87dub8+uV6tg7kH6eok3+PkGl1c6v1HGtuMr1onqxa8Iqi47/kEwt5BUFMSQaJLzZNxl+nMMOMk8T6qQno0KP6XrHDlLlNE5W+VAlJqLaXU7UYQP3XXdKL+c9G58IUhvLdIDGzQUwbQsCfmr65B04u6ug=
Received: from SJ0PR13CA0076.namprd13.prod.outlook.com (2603:10b6:a03:2c4::21)
 by PH7PR12MB8825.namprd12.prod.outlook.com (2603:10b6:510:26a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Thu, 12 Mar
 2026 10:27:56 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::60) by SJ0PR13CA0076.outlook.office365.com
 (2603:10b6:a03:2c4::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.8 via Frontend Transport; Thu,
 12 Mar 2026 10:27:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 12 Mar 2026 10:27:56 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Mar
 2026 05:27:53 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>, 
 <asad.kamal@amd.com>
Subject: [PATCH v2 1/3] drm/amd/pm: Add common smu fw check function
Date: Thu, 12 Mar 2026 18:27:33 +0800
Message-ID: <20260312102735.609454-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|PH7PR12MB8825:EE_
X-MS-Office365-Filtering-Correlation-Id: 37338f03-fd99-49dd-a998-08de802206c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: /NK+XAQLh889lOx1bCIDjeAxe0Pbs6thwziEIRBHVfnFybnk1YN8G5wPUZdtnmVF3NPpF+jGIzBEulUtI6mCXGMOH2Uv0rRlRWMDt1B4BOTA1U+Z5//LejkHxncBUWGbFPWi94huWYF/3td6U7UKUSuKgFygqEcvugV5s/yrwzvo03XAzqISW64GnwQiNDLdw0kBSeKiLeTGw8I2gWbmE02uj/eShb2sEbEAfgcyvAXxZUW/NgiLJsEUrJA8RlyTAS2DSqDjKei9biUne962b06uWkaIgj3Hp5A+gNPKS6ia4YzV/w2AjineuV4k0+C5q+BM9bnHyJ+Dv8Epaz/ut/HSIOLYzzA9b8oDL1LgxfL2X0bf2hzPWQ+jnzXeO+/Ejip+/8FG4yCpzHuDc2X6pOvRfgbh1E0TMhOjvzZ1UOP9OYzP3npcRoRKYIgZDwRrBGGAPUzMSZhWfijlvw30wvCsyZ0bP6awmH3ciDB5GRdOxY3qLMe/Ze4dgySK1PRZPK4peDaTgxirC6nusfk8vBnw0LX3ObUB1gFFtZWSqKVlkck/KPLGKjrhEUoljFXp4G0qOU91MW6ZDWtwVZyjwcPHZaUq+Asa8VgJ8HZS6OQZi0XKY87zp5DH+6E6tEJMAxyB0H32+mGuEzHHVSeH61xLom344Fl5//rqLgifQv+F4NFhfg/X/Kuk1NBFSpeughy4XLRl39JakOXPHEYXl5ipOG1dz/ugAjTD5eIW9Yw4byzkrd3NJIixK8sq9pp4foNf5st6jGOUTAqsdil4Jg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jRHwPVJXCISuHS3YmrkaJ6P0tMtCdW2X3XnjgUP+FWQogNRxQWmB0bmV8E5fqkPVgXRvchWye1fXp8TvaVlTZhNCNL5uRe+mLqgo13lXdZYndr4XcksNrl463B9OufqRj12p/NdNI5s8XgGyMQ9Dtp2iKXRmIKt8Mf2R8PvSDv3gt3keV3q4jc+pmjx0chQ7+4jJ+FwDMgUDYy4+6FnyONIqLg8YYpQH/tQsIIF3xlTFgw+OLYbNp2SUDkfJxu7+H9YMQI0vXIMiIG68iW5uEWNd2WLAjkTaf/SSIh/N+8UW5CIMNDXv3glRGCr2694lv+C1Wc3kxvOt2pI7LZs91zbxUtxRSjH+hQyZllAdZ0RtudErYlt2BQ0anKdo4MNbOInXpybgrWs8D2cSvuwGXE0SBGGDZLiydrOqCVHn2tpkQtfeqY6XRqwDsEvP0xXZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 10:27:56.2820 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37338f03-fd99-49dd-a998-08de802206c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8825
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

Add common smu firmware version check function

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 33 ++++++++++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h |  1 +
 2 files changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 326c86b920a2..432ff30dbbd5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -1035,6 +1035,39 @@ int smu_cmn_get_smc_version(struct smu_context *smu,
 	return ret;
 }
 
+int smu_cmn_check_fw_version(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t if_version = 0xff, smu_version = 0xff;
+	uint8_t smu_program, smu_major, smu_minor, smu_debug;
+	int ret;
+
+	ret = smu_cmn_get_smc_version(smu, &if_version, &smu_version);
+	if (ret)
+		return ret;
+
+	smu_program = (smu_version >> 24) & 0xff;
+	smu_major = (smu_version >> 16) & 0xff;
+	smu_minor = (smu_version >> 8) & 0xff;
+	smu_debug = (smu_version >> 0) & 0xff;
+	adev->pm.fw_version = smu_version;
+
+	if (adev->pm.fw)
+		dev_dbg(adev->dev, "smu fw reported program %d, version = 0x%08x (%d.%d.%d)\n",
+			smu_program, smu_version, smu_major, smu_minor, smu_debug);
+
+	dev_info_once(adev->dev, "smu driver if version = 0x%08x, smu fw if version = 0x%08x, "
+		      "smu fw program = %d, smu fw version = 0x%08x (%d.%d.%d)\n",
+		      smu->smc_driver_if_version, if_version,
+		      smu_program, smu_version, smu_major, smu_minor, smu_debug);
+
+	if (smu->smc_driver_if_version != SMU_IGNORE_IF_VERSION &&
+	    if_version != smu->smc_driver_if_version)
+		dev_info(adev->dev, "SMU driver if version not matched\n");
+
+	return 0;
+}
+
 int smu_cmn_update_table(struct smu_context *smu,
 			 enum smu_table_id table_index,
 			 int argument,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index b7bfddc65fb2..e4d282d8bcae 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -207,6 +207,7 @@ int smu_cmn_print_pcie_levels(struct smu_context *smu,
 
 int smu_cmn_dpm_pcie_gen_idx(int gen);
 int smu_cmn_dpm_pcie_width_idx(int width);
+int smu_cmn_check_fw_version(struct smu_context *smu);
 
 /*SMU gpu metrics */
 
-- 
2.46.0

