Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81160C7EE2A
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:07:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0A9D10E3FC;
	Tue,  9 May 2023 22:07:36 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 365FE10E3F7
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:07:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EwkPJB/6LViq73huT53ESO22po+TRUm7xVVfpOmgFUn/kpkU2CcWMl9RvZUdF3m54ZB6ojfAdbfSkE0TLXilmT4X8+B39DA6Mtk1oO98i6mlD1JxA0ld8s7E1r+rFDqxoBgzc5jN3+FpzTjm4oqPpiuKe7POpf08gxSRbmsrUoC/utcVuLV/tSzr9TR2zD2tqmSeySAb0e0RZz/f5Hzfydyq5s3ru2kwYzNCe3hCfx+gGliPHE7GvqGhh1smmoU2mabzXZf/4AFkqcdN9zEGLOfrodY7Z07GGwcvHAJB7bZD+DRY7xwgbavXAgb0GnaNk3Hu2K7wgLBfvgkBSOchfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C77+ybjl3ubWOeLVO1EsNUd6VEoVdIAFaeZir/PcuOM=;
 b=HekFD5vFkCNFcExgl08I712NhQn6AWuJb3dHfLtCRF5V/cNKrVd/kTOiYSDm+UII2cUNbKzlbn3MIETPT6VJScO04b4G+4uG9EzyxVPyFwB1r5Hy1ZF1XFmbgyUIdC6RxU6rBnLLqoH8wNVPFM6ulruLzM0y0lXDliZyAdcYXp50SWh5rlnYvc8dJzZq0d8Zf/xqW9WBB+ee0Icxz16Y0y0xsq0paSHxR82W+5nEPzGhm44hqCc0higl/Y13bxhhF+URfDje4ihjQ7NQfvrUijDQ8RqPJ8JxhMxjj6PSCQ/BmdeEoK7eaSfvtle+VSjgU/TmVKcVi7EZ0mCair2Smw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C77+ybjl3ubWOeLVO1EsNUd6VEoVdIAFaeZir/PcuOM=;
 b=dKCOui+IYjishovKzujUjQBiOHYgYA7xGuPaUGFDLIt3ejV0miTtNnGZZm8uT3ufoC9fB3CNRr19oargV18niAX7AVG5D0xKO8CBzN3+s50XIctEgbKtyiFQ1TCvkbf5nNSjtr+I6Ciw+3/Jjbdaihr9Nk4ymCvUjWBEGBb5GSg=
Received: from BN0PR08CA0008.namprd08.prod.outlook.com (2603:10b6:408:142::30)
 by BL1PR12MB5994.namprd12.prod.outlook.com (2603:10b6:208:39a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Tue, 9 May
 2023 22:07:32 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:142:cafe::60) by BN0PR08CA0008.outlook.office365.com
 (2603:10b6:408:142::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Tue, 9 May 2023 22:07:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:07:32 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:07:31 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/12] drm/amd/pm: Update PMFW headers for version 85.54
Date: Tue, 9 May 2023 18:07:11 -0400
Message-ID: <20230509220714.475369-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509220714.475369-1-alexander.deucher@amd.com>
References: <20230509220714.475369-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT039:EE_|BL1PR12MB5994:EE_
X-MS-Office365-Filtering-Correlation-Id: c9f78e18-34d0-4922-5ddc-08db50d9c97b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jUH7r9n+7IrlwLFRneVwUEmz1ec3W7Mfh4218OjhIQz20qN2yUoNwClKEx1ZZE9v9IgzlSfcvfMazqlRoYJicEZPXaS6VVSErGKzN15hTezJBzil1q9mvuvL28tx7buGfgi5eLGEg+73McJJDHmxTvE7dJjaC3z19cXxpSuvHyeiQz/51bJyhzNDrE/CvnS2JvlA8NtEoqP5MogiAnVYo5IbfFCvZgrXKH2ma95PRRxY1VnPOcBES2SbTE4Z83+kLuQ+HxPs9a3H3FqqH5MqgkJuTMWXKizvb1WdbJz6EGE3OqeOzFxBVjYl5R7McVqkhx7nEpAkLbyDN46DCaTXR6pOJfhqWbyjErUhSk5p36ZcyeQPS1m7oD8iLdfqaWgnEuQuq3gPKoO6RSuT7CO5CzHAkBPThvWJGhUIFHy3wjEg9vlXCRmklXNmeHohbaTHIzyTk6EKPsQZ/D4FanTlzu94tBXyBtsE5E7ZxhaYo/pM5ddaiI2yjVviXlTVvAQVLVcqspqf3bhGGMRxXZdBU0XxH4kZ9Orfh5DwhtdhvqFOzTDVqwU3gRilxnL2M589NPuAS4Nut1XtDUSzNq5VmUT9HfpfegfH4u0JyjO2wo4vOAQlDHNYTP8f3P0oPwXYo5OIpChHIiyl2Sg6JndlyMFDBk1JGHLF1BcEPPby93Lv+xgvlPP+IM7XzJnPhlXJPupU9S9bUXRh18sLIVj07A28c6yolzEOQ9cxLyJboRXHK7gsHibr5FEgeSi5t0RYhpmhDRuBSf8lvz0JABV3pg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199021)(46966006)(36840700001)(40470700004)(1076003)(36860700001)(83380400001)(47076005)(2616005)(26005)(16526019)(316002)(70586007)(70206006)(4326008)(6916009)(356005)(81166007)(336012)(426003)(186003)(40460700003)(19627235002)(478600001)(6666004)(7696005)(82310400005)(82740400003)(86362001)(54906003)(40480700001)(8936002)(5660300002)(8676002)(15650500001)(2906002)(36756003)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:07:32.1019 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f78e18-34d0-4922-5ddc-08db50d9c97b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5994
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Asad Kamal <asad.kamal@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

It adds message support for FW notification on driver unload.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../inc/pmfw_if/smu13_driver_if_v13_0_6.h      | 18 ------------------
 .../pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h   |  3 ++-
 2 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_6.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_6.h
index 8b7fa0fa59c3..de84fff39799 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_6.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_6.h
@@ -132,22 +132,4 @@ typedef struct {
 #define THROTTLER_TEMP_AID_BIT     8
 #define THROTTLER_VRHOT_BIT        9
 
-
-// These defines are used with the following messages:
-// SMC_MSG_TransferTableDram2Smu
-// SMC_MSG_TransferTableSmu2Dram
-// #define TABLE_PPTABLE                 0
-// #define TABLE_AVFS_PSM_DEBUG          1
-// #define TABLE_AVFS_FUSE_OVERRIDE      2
-// #define TABLE_PMSTATUSLOG             3
-// #define TABLE_SMU_METRICS             4
-// #define TABLE_DRIVER_SMU_CONFIG       5
-// #define TABLE_I2C_COMMANDS            6
-// #define TABLE_COUNT                   7
-
-// // Table transfer status
-// #define TABLE_TRANSFER_OK         0x0
-// #define TABLE_TRANSFER_FAILED     0xFF
-// #define TABLE_TRANSFER_PENDING    0xAB
-
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
index b838e8db395a..ae4f44c4b877 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
@@ -82,7 +82,8 @@
 #define PPSMC_MSG_SetSoftMaxGfxClk                  0x31
 #define PPSMC_MSG_GetMinGfxDpmFreq                  0x32
 #define PPSMC_MSG_GetMaxGfxDpmFreq                  0x33
-#define PPSMC_Message_Count                         0x34
+#define PPSMC_MSG_PrepareForDriverUnload            0x34
+#define PPSMC_Message_Count                         0x35
 
 //PPSMC Reset Types for driver msg argument
 #define PPSMC_RESET_TYPE_DRIVER_MODE_1_RESET        0x1
-- 
2.40.1

