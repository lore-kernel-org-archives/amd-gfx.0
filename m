Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D8BC5DF97
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:21:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A98010EE41;
	Wed, 26 Aug 2026 23:21:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t0WRmisL";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010027.outbound.protection.outlook.com [52.101.46.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D06CB10EE41
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:21:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PDJxSFt4m1nl2YydlZXtKh7kMQ1OalbZr+a975INa5dB6LPEg0Jmn5eK39YKgvskqumO1vEuecn5kB8q7WJrtW09rrgoOYCzUHZaHG/dO4FBLNtduxWIDiHBFZljYl/v9xQNP9lVDfvaIKgM01ze0Jpbt9diXp7/SuWdoQOCOfG9xQzGpX63iE9pB0U3JfUT1qTobBIv19V+6aiQ4z65VUa8HQ1j7BQCIp1x8V5hx1XMHWuAq2YOpL3tyiWr9NADBFMmljS3qrsVvWSVUe3BSytXxrcDtEqEQUAI597SJT76sJfbOtZ6cA7KWxSyeJqourgmaDRjsCiMZ2EVja3Dfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/bFu07/W/5lx1tgXKGZ0vKV68VQ/4buCc2hu7T5/Dg=;
 b=BHRlBjSiGkYDwtFydaR+2obNCUwax4CnsrslBlopqJfANN4wQ3nCn4e0WmmJDg8Q5rJnXY9/5mgXJ/9WD9PGNQGD6Zx7V9OsSk1AfA5go7qd1E+o5I3y/f+33zajj/8jM1a1gm9TfHz2sii0L4c2+xiIxxTwnDhAlmP2Sm6ndgUyUXTw73yF3UJ/JZZRudcuXqOP8TRSyAtOrTkgyQLxPn/bIVqugk5dszKUzKm/A3vfC7+ZEpS1MBJCVFrn1TcFyozKFuox8eSVj99C1fawZh+99Xm8ojA6DitW2AIfCBYMIPsI0k+DICShDuofHbqRmLhtCRQP9NIwBqed67wGaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/bFu07/W/5lx1tgXKGZ0vKV68VQ/4buCc2hu7T5/Dg=;
 b=t0WRmisLrzpHmhxT4lccF8HBMFNzpN2d8/+DT9HFa31cNTT4EXUijbjruajWcx0PISrPQ/JVXosczTeuEixwn5jHVqv6X7XxAdWWmODtU1N2rD0du6btUQOO0eHIhOTWqtbsLYFOulNylRLvP/4yFRCVkZ6xng5jGdCA9giFjR4=
Received: from PH8PR22CA0004.namprd22.prod.outlook.com (2603:10b6:510:2d1::19)
 by SA1PR12MB9469.namprd12.prod.outlook.com (2603:10b6:806:45a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 23:21:53 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:510:2d1:cafe::52) by PH8PR22CA0004.outlook.office365.com
 (2603:10b6:510:2d1::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.8 via Frontend Transport; Wed, 26
 Aug 2026 23:21:53 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:21:52 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:21:46 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Austin Zheng <Austin.Zheng@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 18/59] drm/amd/display: Clean up Per-DPM Struct
Date: Wed, 26 Aug 2026 17:04:49 -0600
Message-ID: <20260826231519.881949-19-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826231519.881949-1-alex.hung@amd.com>
References: <20260826231519.881949-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|SA1PR12MB9469:EE_
X-MS-Office365-Filtering-Correlation-Id: df7c3f9e-ae2c-4fee-18d1-08df03c8d01e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|30052699003|23010399003|376014|36860700016|82310400026|1800799024|10067099003|56012099006|11063799006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: WIXSlwi9R539tKuqZ6j/ZrwXJiF1cSSc9Z1O9YG7Jop1pgoxLi4uo6FDsWIhVf2myzjekT8w/Qb6Y4uMHXDFirbBcfwcw+JJx/TmmbOi/K6prKGR7g8sHPQovGhkDEkqx70UgnDcPtnviiG0i/KZiATyiDox5o5lOqwPUgewWKSIOTwTfNsdfr7+9QY528AKdG2ZZySk9KuywhXJYjjUw6S92+S/xk1fO6IeLgCtUnX9WoQhE0Hf7/O7sqpiUh7/mZwwXVpWEPjvwsm2ohNnGr+Npw7i0iI26oaaTNHLmx0SBe1MBj1/pU+Nsqb5wB2rHeXTS9BVuD0ZUj8fqMnd1Ue454lvjt0S8BUNRjirKQJ8nAE+1EIBfsfX6Bs6lX0HyOBFSZi20LMtBOVTl70X6m0Zh85TeUYzOtg5ET91PPfmo0tZzOyGHxADIauUSMSbetS6CQ3q+XSpAHDRZrvhcyjDSpzLSwrVW+MK2BZgAQMNmJXdLM0eODM3okxMyA3f9JOErp92ucqK07lFFHrw66MV9ZpjNW+6vR7IRvuGtowSNIF8l6i4lt1c50/9DUm3PR9HeG6pEHny9yTFkuedDtmdVI6vGNkMD+32mTWb65kfXk6Ki22k3vlfhu3k5qmY9ujeyWglOjrhWyPypFtt3SXiTLOj4evMfULOXboTOCnqhlLd4vdN0UwcJqfKdahfhOFIKpDYjaJAtowlpcrXSw==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(30052699003)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: //LAVfkkvPHEd2Rwm4YpNEnmGq4cOP2QpoRl0DTewuyzhOLAROkLAzemG8rMnXqscbuR9uw5tktG9k7eHYLzsXJ2F6JrXUu8cU397Kd0cFpLG3uGrs4KP/yIPdAeAa+zpAgYhK4LHnnDMXvyVhy5lAzHKCCpB8THgIHJ3ZXYycAnVXU/ycN9I/WDdPa7uvEfUXB2n8jV8lx6y7fFso5QtMGLZ/U/dTsbGzvVqVvXv4jVzMDbZgY7Vuz2/CnicXZCLiYVNSsaEKhv+8fJyItPWBBFvWDA5rUurkRrzb2ju3R365CNvaf8suVM1HLLn44FKHI+0x33aFHBNyhDevrK5LYR1GJQWR97z8gVZmMVk6RYD/0uAnyzHVBYN/MvKGc8KN1JdD4d4SncBFdqFPE5pEwlVDnpD46UUohiwH2z1/3G3yX5GAGz0WiLfsyy49xn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:21:52.8673 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df7c3f9e-ae2c-4fee-18d1-08df03c8d01e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9469
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

From: Austin Zheng <Austin.Zheng@amd.com>

[WHY/HOW]
Deprecate original organization in favor for the organization used by v2.
External usages no longer used so it can be removed entirely.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../dml21/inc/dml_top_soc_parameter_types.h   | 32 +++----------------
 1 file changed, 4 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_soc_parameter_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_soc_parameter_types.h
index 45208f804d2b..422833548aa6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_soc_parameter_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_soc_parameter_types.h
@@ -78,41 +78,17 @@ enum dml2_qos_param_type {
 // - If a non-zero DPM index has derate_percent = 0, fall back to index 0
 // Unpopulated derates should fallback to the global derate value.
 // Each element pairs a derate percentage with its threshold
-struct dml2_soc_derate_values_per_dpm_v2 {
+struct dml2_soc_derate_values_per_dpm {
 	unsigned int derate_percent;
 	unsigned int clk_upperbound_threshold_khz;
 };
 
-// Legacy structure - for backward compatibility as driver debug values can override the values. (will temporarily break driver overrides)
 // Per-DPM derate arrays for system_active_average (the only power state that varies by DPM)
 // Urgent derates are constant across DPMs and come from derate_table.system_active_urgent
-struct dml2_soc_derate_values_per_dpm {
-	unsigned int dram_derate_percent_pixel[DML_MAX_CLK_TABLE_SIZE];
-	unsigned int fclk_derate_percent[DML_MAX_CLK_TABLE_SIZE];
-	unsigned int dcfclk_derate_percent[DML_MAX_CLK_TABLE_SIZE];
-};
-
 struct dml2_soc_derates_per_dpm {
-	// Union allows both layouts to coexist without increasing struct size
-	// Anonymous structs allow direct member access without .v1 or .v2 prefix
-	union {
-		// Legacy layout - used by soc_and_ip_translator (unchanged access pattern)
-		// TODO: Remove after soc_and_ip_translator migration is complete
-		struct {
-			struct dml2_soc_derate_values_per_dpm system_active_derates_per_dpm;
-			unsigned int min_uclk_khz_threshold[DML_MAX_CLK_TABLE_SIZE];
-			unsigned int min_fclk_khz_threshold[DML_MAX_CLK_TABLE_SIZE];
-			unsigned int min_dcfclk_khz_threshold[DML_MAX_CLK_TABLE_SIZE];
-		};
-
-		// New layout - used by DML internally
-		// Arrays of derate/threshold pairs, one per DPM level
-		struct {
-			struct dml2_soc_derate_values_per_dpm_v2 dram_per_dpm_derate_pixel[DML_MAX_CLK_TABLE_SIZE];
-			struct dml2_soc_derate_values_per_dpm_v2 fclk_per_dpm_derate[DML_MAX_CLK_TABLE_SIZE];
-			struct dml2_soc_derate_values_per_dpm_v2 dcfclk_per_dpm_derate[DML_MAX_CLK_TABLE_SIZE];
-		};
-	};
+	struct dml2_soc_derate_values_per_dpm dram_per_dpm_derate_pixel[DML_MAX_CLK_TABLE_SIZE];
+	struct dml2_soc_derate_values_per_dpm fclk_per_dpm_derate[DML_MAX_CLK_TABLE_SIZE];
+	struct dml2_soc_derate_values_per_dpm dcfclk_per_dpm_derate[DML_MAX_CLK_TABLE_SIZE];
 };
 
 struct dml2_soc_qos_parameters {
-- 
2.43.0

