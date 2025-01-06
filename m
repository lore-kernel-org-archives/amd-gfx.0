Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C55E77188
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2025 21:06:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CFBA10E99D;
	Mon,  6 Jan 2025 21:06:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X+OMiq2/";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D05C910EA13
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2025 21:06:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fK132VYO4uj7kUW/XRTssAVtz90VqKR3bT/CrOs+EqSJYhuVWFB2P6b6NGVSJfukc8yQ0ai6nLVN84Yx7ovbcG9DjdhH8LqNBJglTO7RS2OUbYkLfX9eP9y/tI0+YNEZZUCtqKhAIh89IXIRPK88kP5l0LoFvRcwsfXeXxKRfszNOeAzekITzklY/0F/uK+vZ8AJv6cEV+hj+fNM3tDxcBMMsExgfn+zrNB2KZTF7Z5TZ/zMZk+ItPIFSMvX5OGJAZQfi9TXN5W6RQmEa4zAS3zAK+1I7NjjCR9TH+jXYcAklS6MK5Arnix6UFKK0f18G5OpmSyMO9xYi//WY1zbLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2O4Zb85ooUCIpMJIW6gm4YSUHqCIbcGYsBKRPwtexM=;
 b=gKf/9XZCtRza1dwxqreD84ABW5JasGHowLFg0eAVHkxQ1tKM8gMYlECY5tkAg+WU/P6XsQ6J8YT25TEBtkOPKbWgmCWgrt6w7FIK4nPUZEtfDtTfhQaXZTkP1SDS9uHRDlIw7bvQL6+SR22V4nwU4qOecPr5L29H5lDg6fheLiI1/S2twZmUKEoCphD0Vz/0Scl1+jm2mZlLHK3AENtbfgTc/5P3yvdq1sVVZ5Gcp/OGO0KtAR7wjF93Dx6x15cFXSbcGOuujfYwjX93o19O7ruK8tOXeVKm8OGkoDDufFg3n3WBqfVVaJpk5glvL0slXa5yU4Vwg8sZ6OcH+Qd5dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2O4Zb85ooUCIpMJIW6gm4YSUHqCIbcGYsBKRPwtexM=;
 b=X+OMiq2/BLkZ+Yh2as8GbVXDWYXuPlzKI26kzaazKWs9XIRM92xrUK7lxQQqcA+BuVXHJ43F31Bs2ZdV0MoHlsb6M5S8IcOj2iAFGjfi0LihubEWN52ifPwarE+OMoXaKpEb/lGivxNh1TXxXR0eQkbGszJis+f0QlsO5V2zMrI=
Received: from CH0PR08CA0017.namprd08.prod.outlook.com (2603:10b6:610:33::22)
 by DS0PR12MB8219.namprd12.prod.outlook.com (2603:10b6:8:de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 20:33:30 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:33:cafe::cc) by CH0PR08CA0017.outlook.office365.com
 (2603:10b6:610:33::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.17 via Frontend Transport; Mon,
 6 Jan 2025 20:33:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Mon, 6 Jan 2025 20:33:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 6 Jan
 2025 14:33:28 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 06/10] drm/amd/display/dc: add support for oem i2c in
 atom_firmware_info_v3_1
Date: Mon, 6 Jan 2025 15:33:06 -0500
Message-ID: <20250106203310.3349585-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106203310.3349585-1-alexander.deucher@amd.com>
References: <20250106203310.3349585-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|DS0PR12MB8219:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a1bddb4-f72e-48cc-8395-08dd2e9161bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RUlkqIUD6XbWLHbceQvNR7fYN5XZC5Y++eBHc71DtY9Un28GODTArHG/+bGW?=
 =?us-ascii?Q?b+pGOL64wW4cZwceQ9YMV0AX3/IUEMMWP20n39L5x7S+6hgHRmWKDqdWixwT?=
 =?us-ascii?Q?NBwHdex+yO71AqijwTFmsd0idd6H7qRGiZbFtdZGFSMtN+dP1L7yEn+tv/9z?=
 =?us-ascii?Q?evjq+HLCIhMAZrjvpmk84ul4dTeVkILBvS//zEH+5eQ2tVs4q9ckbp/28pV6?=
 =?us-ascii?Q?tCeNawnK9kc7N2X5rLWOhf7Qd2C2I08yFpFYFdZwl02IvSTqrtc0O++nZgJf?=
 =?us-ascii?Q?mNnk9NVZV3AoWrX2lO9KxVR1BpYvkmurR8idf3gMFOwD09rWHBITU7aVNk8g?=
 =?us-ascii?Q?8KmW1fsDt5KBbSVP7cSft9cNwk1MzJOF2QJlKmNvICSvNdemkwAJ8ogeLy3R?=
 =?us-ascii?Q?cZxAWsqQTwTLeAXIjpI86o+XUdnMHOV3VCY8QIuP9P3CibKxy5GyNingusPC?=
 =?us-ascii?Q?B6nzVORjYesmOjcoCdG4BK4jgfn9lfWMX5eKIW8HvVG4kZGV2zNdTYxOuveS?=
 =?us-ascii?Q?RBotL8vI3onV5DdGEepPJfAyVHKXdLgwR+HFesv4sYQJf/TMJptf+A1acToX?=
 =?us-ascii?Q?MQHl7oi0up+4hnq2QzZTXr1cD5JPiGayyvi6Oie1BydlF55KIZ8U1XQORgx4?=
 =?us-ascii?Q?4m6Fo/4cJ4r2GQh1/k5VKmK1TUyIEIHsHg+6jPOhmKRy520U5qreq44+8VVX?=
 =?us-ascii?Q?zqY5985mpIInRM5Rle+RIxNHVjV0lNbxoVjCHHlMX6AC6KRyHAH2UBmhGlcO?=
 =?us-ascii?Q?OW+dYBVUIg0HUtgH0qvbAi7VtDe6S3ZK+CDjj06yzsi0fAdJvD3Ut+xepBFa?=
 =?us-ascii?Q?XDeuk7A5dxZWKcd0CH4Y0D6Zu4c5ZlwQgxykFaFicZXh5bamYylqge/VLp1X?=
 =?us-ascii?Q?jLkggALOEYK0zLLwEcPlZrngzRHCtdLdjErpvnCSWV/wg/kJa77nrE8sGf24?=
 =?us-ascii?Q?4fWbsNZMKP4uifegq0Th8knnt3h8c3lNEaeakjb/B6BKqlDlokQjpxg6KHQo?=
 =?us-ascii?Q?ojYxEX0qaGtYOUYhg4Cu0y/ev5QsZ7xDv8yBuM1tqnna3bo8I0kXgvtkGUvC?=
 =?us-ascii?Q?QjGtKvkRGt6YvjEwilmJWsDkIvLEmWYm8/TLWlMy530dlSqPW43ExR02LNRi?=
 =?us-ascii?Q?a/dLdbSEJ59aZ5gqFKXh8Zy8nLo2dfSzZgMye9NrT8sxX9WQnu3vJaPjbZ5d?=
 =?us-ascii?Q?c3mi0O5CwFqeWnG1GdvxTSNXc3Wt0IeU+od6ewF2TnUkDCoqnJSnh3LaWTiA?=
 =?us-ascii?Q?Ms9w1KwmxUT3kcaowzV8TJjvpkTKfibpqItA23+QAhqTeJ/Dx2c491Y1DTGj?=
 =?us-ascii?Q?ksURLOl2ip99JpOp2l5OZYZDiB1GlcdoGZQOInQ+XlD6sGHbiYDa1nFG8sqT?=
 =?us-ascii?Q?tzvcz0ytKxSW4mqBfCIOIFzVonD+r+Hv3ZcsmOf7XhREEEvNdA3QjyRJkxAr?=
 =?us-ascii?Q?nKsmS7sjGCV53YX9XPRaHYvT0J+s7FLGXz1bRlOY2ry5saLEiXcUjGxKtpqY?=
 =?us-ascii?Q?jxrfG9cDcyRrb48=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 20:33:30.0642 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1bddb4-f72e-48cc-8395-08dd2e9161bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8219
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

The fields are marked as reserved in atom_firmware_info_v3_1,
but thet contain valid data in all of the vbios images I've
looked at so add parse these fields as per
atom_firmware_info_v3_2.  The offsets are the same and the
reset of the structure is the same.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index c9a6de110b742..470ec970217b5 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -1778,6 +1778,7 @@ static enum bp_result get_firmware_info_v3_1(
 	struct dc_firmware_info *info)
 {
 	struct atom_firmware_info_v3_1 *firmware_info;
+	struct atom_firmware_info_v3_2 *firmware_info32;
 	struct atom_display_controller_info_v4_1 *dce_info = NULL;
 
 	if (!info)
@@ -1785,6 +1786,8 @@ static enum bp_result get_firmware_info_v3_1(
 
 	firmware_info = GET_IMAGE(struct atom_firmware_info_v3_1,
 			DATA_TABLES(firmwareinfo));
+	firmware_info32 = GET_IMAGE(struct atom_firmware_info_v3_2,
+			DATA_TABLES(firmwareinfo));
 
 	dce_info = GET_IMAGE(struct atom_display_controller_info_v4_1,
 			DATA_TABLES(dce_info));
@@ -1817,7 +1820,15 @@ static enum bp_result get_firmware_info_v3_1(
 				bp->cmd_tbl.get_smu_clock_info(bp, SMU9_SYSPLL0_ID) * 10;
 	}
 
-	info->oem_i2c_present = false;
+	/* These fields are marked as reserved in v3_1, but they appear to be populated
+	 * properly.
+	 */
+	if (firmware_info32->board_i2c_feature_id == 0x2) {
+		info->oem_i2c_present = true;
+		info->oem_i2c_obj_id = firmware_info32->board_i2c_feature_gpio_id;
+	} else {
+		info->oem_i2c_present = false;
+	}
 
 	return BP_RESULT_OK;
 }
-- 
2.47.1

