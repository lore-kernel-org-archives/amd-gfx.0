Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3C9606A32A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 17:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=bwYP96D9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C16910F83D;
	Tue, 17 Nov 2026 17:14:02 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011015.outbound.protection.outlook.com [40.107.208.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE05010F822
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 17:13:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JQHDLcIotCXMGL1JkKIa9Cmc+62Z7keZE+NToJPOozih54Q2AC7NGoau2X+BSfaViqzVMVoQa12+7wQUyzOSZX8RNgtu3Owjt4cOdFiPrbpZOm1e2ZdZv1r2aGdM7Sn1kBNpDgywLmfg+CD3fvPCM0W+cj7NW4UbC6ZSmAr603A9BRMbbvFPid7woadwQbTLXINt9/sD0SpWeonLV/gPAt+3R6lAJ6tufViJjCAado9U5pf6rBy+4TeEDZbGrhjkPu5cS2URcgSrEUHrOlOFHA4GGgtC5PQO/mh+/BpGTqxQoHwhADBbqQgC2KYAD2gKVJrQ/U4VAhMJal0Bs9A1Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8BLNcJyBXMapGIqPUhr/dNO12q4Coyn08FnE92e8LrU=;
 b=m6tm8zMlMVgiLcHR3FwvlumHMDLPhVHH3bjYYsmVXAXYNDMbpSapnF+c3kLSjuD9+sexmRfmle54h7meUtcVFUKd1QFFtLS/7Xh5Rd+sNGQ1QlfqENexsssroDlCGhYhWUYBuRM2l0zca7o/4+aACaStoCot2pdYh8izkMzX/JGSm8z5Oj8gTRyn/9Qum4xb+gaDcWulUi5hbRPTGNSDK3qpor7asfEjb/oYOsIoEe5rp7AoalW/WBa6uPKQBPscDg0QQ2604C9YKiBA0doauyRukhXQI9YQzeNXxlnhHu59KXuleCqyuF5vRwDSO0ADq8VSnfiourcpvzsskbbe0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BLNcJyBXMapGIqPUhr/dNO12q4Coyn08FnE92e8LrU=;
 b=bwYP96D9TKqdX8gTXLZUFrM80Whyf9GenwKeDZZPhGEG3WX5Mnrdj5x6uorzEd9/KEFd3GLzxB6+D3i3+EOEtCexMbvAfOPGBNvxP5jpJj2iDwys7kzSXMsm90rhu0QCSP7tOTJbgumGu1wmuWJ8iONC37z1apn8AdJvaUnlsT8=
Received: from CH5PR03CA0017.namprd03.prod.outlook.com (2603:10b6:610:1f1::12)
 by SA5PPF6407DD448.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8ce) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 17:13:52 +0000
Received: from BN1PEPF00018072.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::af) by CH5PR03CA0017.outlook.office365.com
 (2603:10b6:610:1f1::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 17:13:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018072.mail.protection.outlook.com (10.167.245.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 17:13:51 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:13:29 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:13:29 -0600
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via
 Frontend Transport; Tue, 17 Nov 2026 11:13:15 -0600
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ray Wu <ray.wu@amd.com>, James Lin
 <pinglei.lin@amd.com>
Subject: [PATCH 08/33] drm/amd/display: Read PWM back linearly with the linear
 backlight curve
Date: Tue, 17 Nov 2026 05:50:45 +0800
Message-ID: <20261116215641.2800595-9-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116215641.2800595-1-PingLei.Lin@amd.com>
References: <20261116215641.2800595-1-PingLei.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018072:EE_|SA5PPF6407DD448:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d1cf15d-2661-4712-8277-08df44ce26c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|22082099003|18002099003|6133799003|11063799006|56012099006|261022075727099003|261009223027099003|10067099003|261021121427099003|261021123027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: ifhq9pRO8I2p/KCfh/H0y3ENxZoqfg5jtyLChrZpj8o258wM+LdzTuMnK7UjaUP7Tj2jwO2DB2Bh0t9+nbBimwvTzuYLsi7Vj3vpzf942UAoAQBZyJ3R/qP0veSfs7KbjzdaTMR/HmcK9bZs+o+fYYpZh/mN191itL7L82o829XGJ6nmricd0vJVRdlhSrKCsJOfS4EIgIrzDwpo+N+cAPmuAEpJQTCvRGYX5et8RnIsJFf6glsAoBZzQnGLn5bX1mv9cMOZzEaH9/EGIN8vXwSo5GkjUDoDEpBHENYgN4Lf+leD6BgyH5/270SXpDuITRSdh/X99n4+HacboGoCXYD4mvzJ8+H8qwbJxkqFE4ti4JwYCiz89cbzb8PVyHMynRk/pEutwGa6nJYUpUWdH1nshM36dShzN4pehF59hfNHkYtfaqzlp9hZCxoWeMq0KgYTXIPtnhckPvhc9gyH+6us++B6G6xeco2zMD4VvwXxdxYVcIsKfpyfxMScvLhPWjHwpd55EAFeMCSvzPBT9DLHh+CPT8rSTRGmWYnMA7hkEthbrHHQJ9ifmzC6z+8qZIKnD7++6OU3c/84l8VEMDZTN9HJ5hjrC0JWCat3FoH9vTPBnJRMgOyQbbCpCtwrHNUdsjbeNALLNEKXuC3d+E8bx750I/z0AFvXzbLZfUdTZL2RCGV6jmI62LHJcCnooeQB3NfAVKyxfVSGhibINA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006)(261022075727099003)(261009223027099003)(10067099003)(261021121427099003)(261021123027099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7VCSqUIbUFWuhMaPpRJWTbuPMvV3Mu4R0Yi8pfJKgB+bX1OcivG1Py4nKq9cngWItIA4zXCDCvef8nUDEGMZGqELp2LEZwQ+3Vq8l/GgnrvVOt7o4k2y1u/PYTbGKJs6Q/2pUbJW/dFfi7+cyx/xMfdvurRp4Ik8DOjY5aWbXV28NVCdmXwGMw4A/ZaUTdC1ncU6aDT3JM7gAGEDP+o4IIN2JHR0xQY6n0jTuzwvWmYFBPCqMZEd6h3hErZc4mYWvblTM41f18ePMOfxe+dp9uMgvsTfM9KIJxRgTSwrwIlMVDO7fP0Rc9xjFYNOjtJOnG67WSw2AVLcTfeJhSZAetfz18neCxJFuyMcRABs2hCHN4TlH1l4OHtVJRJyqPqMKvQyMd9L7wGOXGbBFG5BBZFHXUak1/DQd47V9T62ERFmTDuuiwClCZEg8bwD15kq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:13:51.3897 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d1cf15d-2661-4712-8277-08df44ce26c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF6407DD448
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ray Wu <ray.wu@amd.com>

[Why]
use_linear_backlight_curve makes the power module bypass its LUT when
setting PWM, but reading PWM back still searched the LUT, so the
percentage read back did not match the one set.

[How]
Map PWM back linearly over the same range instead. Also read the flag
for the panel being converted, not the first one.

Cc: ChiaHsuan Chung <chiahsuan.chung@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 .../drm/amd/display/modules/power/power_abm.c  | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/power/power_abm.c b/drivers/gpu/drm/amd/display/modules/power/power_abm.c
index 5e86889eaa84..60930d969b9b 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_abm.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_abm.c
@@ -374,6 +374,22 @@ static unsigned int backlight_pwm_to_millipercent_legacy(
 	if (core_power == NULL)
 		return 0;
 
+	/* Inverse of the LUT bypass in backlight_millipercent_to_pwm_legacy() */
+	if (core_power->bl_prop[inst].use_linear_backlight_curve) {
+		const struct pwr_backlight_properties *bl_prop = &core_power->bl_prop[inst];
+
+		if (pwm <= bl_prop->min_backlight_pwm)
+			return 0;
+
+		if (pwm >= bl_prop->max_backlight_pwm)
+			return BACKLIGHT_MILLIPERCENT_MAX;
+
+		return (unsigned int)div_u64(
+				(unsigned long long)(pwm - bl_prop->min_backlight_pwm) *
+				BACKLIGHT_MILLIPERCENT_MAX + bl_prop->backlight_range / 2,
+				bl_prop->backlight_range);
+	}
+
 	if (!core_power->bl_prop[inst].backlight_caps_valid)
 		return 0;
 
@@ -529,7 +545,7 @@ static unsigned int backlight_millipercent_to_pwm_legacy(
 		return 0;
 
 	// Bypass the brightness mapping LUT
-	if (core_power->bl_prop->use_linear_backlight_curve) {
+	if (core_power->bl_prop[inst].use_linear_backlight_curve) {
 		pwm = core_power->bl_prop[inst].min_backlight_pwm +
 			(unsigned int) div_u64((unsigned long long) millipercent *
 			core_power->bl_prop[inst].backlight_range,
-- 
2.43.0

