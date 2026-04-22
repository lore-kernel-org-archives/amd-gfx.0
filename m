Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91330F94CC2
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 03:57:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E7B510E256;
	Wed, 22 Apr 2026 03:57:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5fYWJeIQ";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013040.outbound.protection.outlook.com
 [40.93.196.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BD0710E256
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 03:57:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TGdyLN9oYb06UzQo0PGzB/wIuF+M79GPG9kxryiKDqZYpEQgHBpsAtZDoZt/W6FN9WVPhSIveyCtI/ZEyqNS5nP8tbm8rf9axmNvqxCcJiuea3Qb0mC6ThqvuzWjfBGP1wr1pFq24COKL72PZjdgX6Y/8T/zOhGcjQJ/F/sbhtVpdTCuBEU2GYtjFyfKrHcfpKYRHi6fnloybOfhVdFMJUncofJ7jLAM5y3vrXyRMpuL0DRyeRD5lNdKf/1qu5JlKLRU4OBgQpkcIRYSjqTtAwCJIEFKftQfTCDc5muw5hFrGScV8RXX/5EMHiU2IEnubB8YWUg9Q+Sxs/9uCw9Yvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8o5ZTWPVuVLhFh4DGGQBRy1ypWDMsapNap4sAisp5kU=;
 b=n4x2dRx1n9Vb9SAkTlwA4GMzwT4f7emOLTRc14pqnBKhK6gjaQdUr2uYtJeaBKE+sV8624S8dVvHhyaw3T9XWC9IxztC/WqqTDwIrnI/2g8Z5otNBz5lxsyIyDJyZJPjisYO6AUc8dVJqsFS0QlTTk+BPkiCtZawF1kCrNkmc6gigNvuPqWc1KMR2Qt1TLO6I3GSHer2NHzzEQ0A9L0g9x8E4kV1AMeRRdYI6jxSdZ8EChtCS8+UHVsQqBMESgaqAeKjdVS9nYBe8XwrqHvh3CxR97hMsNA5QdsenE7qtbUnrmE6m4A+PaZEdJobEkdZompH2b9AZf8xsHdlJFTlqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8o5ZTWPVuVLhFh4DGGQBRy1ypWDMsapNap4sAisp5kU=;
 b=5fYWJeIQMMIs5l7TEdO4y+JPyW/fB5/6nKes22T8QzxVARhYoFUW7afsGIl2mQ3QxlbWiWMQy2Sk6XiLbsm8alC3h/RWODo0z4Fll40ewJmFfMYpLXK+cpwU+ao9HLqD8JrIminU5jSUawqnuM7wWeELYamM8TPuZzUXXc8KigU=
Received: from PH8P222CA0004.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:2d7::34)
 by SJ5PPF816B88375.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::99b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Wed, 22 Apr
 2026 03:57:19 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:510:2d7:cafe::38) by PH8P222CA0004.outlook.office365.com
 (2603:10b6:510:2d7::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Wed,
 22 Apr 2026 03:57:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 03:57:19 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 21 Apr
 2026 22:57:18 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 21 Apr
 2026 22:57:17 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 21 Apr 2026 22:57:09 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Taimur Hassan
 <Syed.Hassan@amd.com>, Alex Hung <Alex.Hung@amd.com>
Subject: [PATCH 13/14] drm/amd/display: [FW Promotion] Release 0.1.57.0
Date: Wed, 22 Apr 2026 11:52:51 +0800
Message-ID: <20260422035611.1870316-14-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422035611.1870316-1-chiahsuan.chung@amd.com>
References: <20260422035611.1870316-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|SJ5PPF816B88375:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cfcd0d0-98e9-43e7-6290-08dea0233ffb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: FHs6Rx/zL1O1EBQKDpZ0cWYfItSrafa+Mr68onRnViTv52XJgPwHxdzpzEiWFyvkhhTiGNQwI1RNdLL766fhdhOF8GuItabgzoVfbvf28bx9zQCKJSlVhshPAjfPLdEW7oYHJ0e4BOvxiN8IV6r0fkt8QQjRfqo9qCI3WfXwHMxCZ5mn+xlUl4IkM4usAvhO5qvJGZkYw06Ra1xOv9jKaVZrn2uagSzNgWVxloZQgZ0OFqbCh3uWu7WfDBV/5mS3/oZ4sOi9VcX2jqqz5ZIspaZmC60VNKdqj43M82/w5+DtrltpYThybzB8GktbwT8cpz9xYBCyEpZvygkqjHYc1ZC1Y03ghlaJYT37ClDgLeO0P8GD9hB8p4SIk4y97HOOSX/g2I5u7Kc1npDPJ8BtB5jb0O6NhApqAhK9AcJ8GY/NHl/LlsVCvFsO3Kioy7ovDVRSFpMsh1Lcy/WkMdG9M1jla/Dsf9GITbuijrcIurtX+rU9LWfDmvqeJOg4TcN0AwC0zsTlT4zyUhM+GiBeDlcpkcHs95B/ZDEKV0nGqXrr29TNfjcH8IKPfwwauIA+KpynhGdpf6ooaeeIlL3++VWtOWIUtBnYohqTKyGbnXgHNzxJOXNBREZVKVZtG9jkBtZCWZBKaj8mgjvnce+vdgG5q7g9/BaX2WayJvuuH2PcFacb7xdepZe8kPbXgkL+wqvEgVod69jocKIRMr52a+gnX5j5B5PL10e+tk3qTg/MSOZnVdxmWq98hUSyvW3hDae2eFqfFa9qJ9CSvNpObg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GwTfHU3HtSO+uD5eT1vi5ykesxIJpVtXprD+4I2CuDfMtebYmWtv7FRhod0+kIeHlpEzKiAd1ia18+pnHwoSbzTHvBFcFAGqk8Azjkd/+m/78rlc66MMM3gnGEv9wESlsHgB/7qw3j/+Hj6rq4qO1oZjumqnTUCuf1nUM54ye05eIXkbprnGFcER0SCj6hzhGuIq7OZVlcosjBU4LlMAi36fmigKzzRJZnfVOWIwZhkbU017FN/a1/KO2j8Lr+7X6WUox1za7+siIIZEiUmXoquhUSm9qr7kKbkLOI63khH0v5IgIEqFjaTELQnF/R/+6c88pVMLza6QTtkfiwjH9x5+oXX7goUZinNFLgHoRgaCQS3/CBM6iXWiPSQ05XEagNObwF51hUs2ew0qFYGURmxQwVorHqRVJwiOMft+Ah43iGDfk4zkPa7uHzQ5Cl4X
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 03:57:19.0522 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cfcd0d0-98e9-43e7-6290-08dea0233ffb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF816B88375
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

From: Taimur Hassan <Syed.Hassan@amd.com>

[Why & How]
Modify some IPS related commands.

Acked-by: Alex Hung <Alex.Hung@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 26 ++++++++++++-------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index fe9431cea3e5..7ae5f666883d 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -1546,8 +1546,9 @@ enum dmub_gpint_command {
 	 * DESC: Gets IPS residency in microseconds
 	 * ARGS: 0 - Return IPS1 residency
 	 *       1 - Return IPS2 residency
-	 *       2 - Return IPS1_RCG residency
+	 *       2 - Return IPS0_RCG residency
 	 *       3 - Return IPS1_ONO2_ON residency
+	 *       4 - Return IPS1_Z8_RETENTION residency
 	 * RETURN: Total residency in microseconds - lower 32 bits
 	 */
 	DMUB_GPINT__GET_IPS_RESIDENCY_DURATION_US_LO = 124,
@@ -1567,17 +1568,18 @@ enum dmub_gpint_command {
 	 * DESC: Gets IPS residency
 	 * ARGS: 0 - Return IPS1 residency
 	 *       1 - Return IPS2 residency
-	 *       2 - Return IPS1_RCG residency
+	 *       2 - Return IPS0_RCG residency
 	 *       3 - Return IPS1_ONO2_ON residency
+	 *       4 - Return IPS1_Z8_RETENTION residency
 	 * RETURN: Total residency in milli-percent.
 	 */
 	DMUB_GPINT__GET_IPS_RESIDENCY_PERCENT = 127,
 	/**
-	 * DESC: Gets IPS1_RCG histogram counts
+	 * DESC: Gets IPS0_RCG histogram counts
 	 * ARGS: Bucket index
 	 * RETURN: Total count for the bucket
 	 */
-	DMUB_GPINT__GET_IPS1_RCG_HISTOGRAM_COUNTER = 128,
+	DMUB_GPINT__GET_IPS0_RCG_HISTOGRAM_COUNTER = 128,
 	/**
 	 * DESC: Gets IPS1_ONO2_ON histogram counts
 	 * ARGS: Bucket index
@@ -1588,8 +1590,9 @@ enum dmub_gpint_command {
 	 * DESC: Gets IPS entry counter during residency measurement
 	 * ARGS: 0 - Return IPS1 entry counts
 	 *       1 - Return IPS2 entry counts
-	 *       2 - Return IPS1_RCG entry counts
-	 *       3 - Return IPS2_ONO2_ON entry counts
+	 *       2 - Return IPS0_RCG entry counts
+	 *       3 - Return IPS1_ONO2_ON entry counts
+	 *       4 - Return IPS1_Z8_RETENTION entry counts
 	 * RETURN: Entry counter for selected IPS mode
 	 */
 	DMUB_GPINT__GET_IPS_RESIDENCY_ENTRY_COUNTER = 130,
@@ -1597,8 +1600,9 @@ enum dmub_gpint_command {
 	 * DESC: Gets IPS inactive residency in microseconds
 	 * ARGS: 0 - Return IPS1_MAX residency
 	 *       1 - Return IPS2 residency
-	 *       2 - Return IPS1_RCG residency
+	 *       2 - Return IPS0_RCG residency
 	 *       3 - Return IPS1_ONO2_ON residency
+	 *       4 - Return IPS1_Z8_RETENTION residency
 	 * RETURN: Total inactive residency in microseconds - lower 32 bits
 	 */
 	DMUB_GPINT__GET_IPS_INACTIVE_RESIDENCY_DURATION_US_LO = 131,
@@ -1606,8 +1610,9 @@ enum dmub_gpint_command {
 	 * DESC: Gets IPS inactive residency in microseconds
 	 * ARGS: 0 - Return IPS1_MAX residency
 	 *       1 - Return IPS2 residency
-	 *       2 - Return IPS1_RCG residency
+	 *       2 - Return IPS0_RCG residency
 	 *       3 - Return IPS1_ONO2_ON residency
+	 *       4 - Return IPS1_Z8_RETENTION residency
 	 * RETURN: Total inactive residency in microseconds - upper 32 bits
 	 */
 	DMUB_GPINT__GET_IPS_INACTIVE_RESIDENCY_DURATION_US_HI = 132,
@@ -1615,8 +1620,9 @@ enum dmub_gpint_command {
 	 * DESC: Gets IPS residency in microseconds
 	 * ARGS: 0 - Return IPS1 residency
 	 *       1 - Return IPS2 residency
-	 *       2 - Return IPS1_RCG residency
+	 *       2 - Return IPS0_RCG residency
 	 *       3 - Return IPS1_ONO2_ON residency
+	 *       4 - Return IPS1_Z8_RETENTION residency
 	 * RETURN: Total residency in microseconds - upper 32 bits
 	 */
 	DMUB_GPINT__GET_IPS_RESIDENCY_DURATION_US_HI = 133,
@@ -6513,7 +6519,7 @@ struct dmub_rb_cmd_assr_enable {
 enum ips_residency_mode {
 	IPS_RESIDENCY__IPS1_MAX,
 	IPS_RESIDENCY__IPS2,
-	IPS_RESIDENCY__IPS1_RCG,
+	IPS_RESIDENCY__IPS1_RCG, // refers to IPS0 + RCG
 	IPS_RESIDENCY__IPS1_ONO2_ON,
 	IPS_RESIDENCY__IPS1_Z8_RETENTION,
 	IPS_RESIDENCY__PG_ONO_LAST_SEEN_IN_IPS,
-- 
2.43.0

