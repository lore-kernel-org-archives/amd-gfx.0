Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB3D7CCF9E3
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Nov 2025 02:05:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CCAC10E69B;
	Wed,  5 Nov 2025 02:05:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nMIj04Ou";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012019.outbound.protection.outlook.com
 [40.93.195.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6349710E69B
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Nov 2025 02:05:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Swk4ztV8QzOk/nIze/+5rHQQQiKb/vjUIwWG8S/792zrnwswUG8MUj/Bzv8vi/Ei02/0++Knfy/phuQXArX5ZiqSzNUF8KfDOyrrHSgBJ9COQQdvu5AcmxyKe0wRCYtYbEtYTYkovDwjUlT9z9vjkYaWm526IJ7m5/xpuAz9sHsdctUQQTfWbLYUNqOfQ0g2SoR+RWfKIvIk8SrDy6DwSlQHnEEVNPBDm8RAC6LuuhU4JF07L7Cy8dTTZCQkK7WQYLSB/aAnpZNF34UISNn8jyffmtpuh4sVmNHUt9XjVHs7PwkUGcWjsyB9DhWPqSJ2ZABNbG+s7X6sdOaowZWOIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSKW0gMVY9SV0yc0yaxcwmvuIQhczPKmQ+fu8lZxZaY=;
 b=rY2Vbq/sEbQV7+pEBLiYSkfo5g1twbFq/h8J9tpZI/yn7gHWxJQpWZZIVWxp4INbIOCgjdv1UbZ0oQ7l7EV7KuiW98l3jf3V8EJKr4iFowiDK04jOTGGD4mU2mDqxhdcxXPF7rV7lSHzDNQtiiGCh/FO1sypz/OxhLFssfQ4OtLJWqLcxKAlyrwEWQ9lQdZs+1nf1tHz4S94Bcz7itsR89cktDVowBJRs9TlANtCbQhm4Iv5Y76uUzAzYGHveQ/+YmQ9Tf/rYy6rBxBl0fdDCeAI3Wutawn84/OPJm5zLMSjLxMhsHB4YMC9657Y+UcL2xGRfL+TBTp+fnw26RwAGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSKW0gMVY9SV0yc0yaxcwmvuIQhczPKmQ+fu8lZxZaY=;
 b=nMIj04OucSizlP76dR+EAI0QzsYIvNb1khBllzs0cQhpaOTqTvCIm8VJugcvK1q3eS1mLhZ1rZjdOmX5AoOY1qTPUohZW8DVbVjfNED3iLlPosmF0zNql02TdJOgBBBEmTK9rKkmavrhsTezIi1bHnHm1Bu4jDq8p6u2Vjs6wcA=
Received: from SJ0PR05CA0133.namprd05.prod.outlook.com (2603:10b6:a03:33d::18)
 by SA1PR12MB7368.namprd12.prod.outlook.com (2603:10b6:806:2b7::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Wed, 5 Nov
 2025 02:05:05 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::74) by SJ0PR05CA0133.outlook.office365.com
 (2603:10b6:a03:33d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Wed, 5
 Nov 2025 02:04:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 02:05:04 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 18:04:59 -0800
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 5/8] drm/amdgpu: load RAS bad page from PMFW in page retirement
Date: Wed, 5 Nov 2025 10:04:42 +0800
Message-ID: <20251105020445.1423034-5-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251105020445.1423034-1-tao.zhou1@amd.com>
References: <20251105020445.1423034-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|SA1PR12MB7368:EE_
X-MS-Office365-Filtering-Correlation-Id: d08289c2-27af-4026-59fd-08de1c0fbcd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JJhog2nVfzXPLJPSYMfjjxCQAH+Xd5GDY0pmjlGCyO8V0DCFOm6seC2ktMlC?=
 =?us-ascii?Q?zzmfuuD1nVafD/KrIFHyG/zemHyMA53mXWko761L8/oHM33pm4jr8WkQUH5W?=
 =?us-ascii?Q?ZPjv2WwpJnst3HRyRmBSi0dRvnSg+CVeZnuiWGm2D6ZtTDrgcoBLL3UXIRKp?=
 =?us-ascii?Q?SIsSh83v/U13rU8Izufk/W9Gf9qzGLjfnv5K89oP1fX+C4jU/0S2sF6M6PE+?=
 =?us-ascii?Q?O6stx8imtEYP9cK4il3d/nR+D6WslZPdlCW/uLVP60/cSw+WzvGrHtDOeWrK?=
 =?us-ascii?Q?OhsGNHWLQn3llkzuSDy4OD0m7HUtqb2+e4AsYXNxN1Bm9idcHTZP0jCwOZzY?=
 =?us-ascii?Q?PxjtuZkCjmzpvGyg7TErQkFBZ0GcyVOW0XvzRlHVJUvpKWLpnmoZisvu0R6c?=
 =?us-ascii?Q?VHbMfz5qTVLCxUjDuPa36ZaUjW35ZRxVOCqvrLUMUdZnH6rfJqwpGtyZLiRY?=
 =?us-ascii?Q?m1g3ZWlZePBVgA410aFTgRlgVXt9Af56yxjI2RMp3EMLp+PHdbew+l4EVJ01?=
 =?us-ascii?Q?6v8JWBG4OOI/aFZsr0ohwdtPPuHS6hpQlANknczJc0mN7O9Da9jTrvKGTfJy?=
 =?us-ascii?Q?V4fJl14ueBUgtnAi7II5FioYZUV4+vjSiq+ckv4v5ACsG0aa4gO9Se1cusot?=
 =?us-ascii?Q?g860xNP/zsWe4Mz5U7GxRgq25RrxGUuQ5hDyi/2UGN/GA77ah50HaHKOiZCH?=
 =?us-ascii?Q?ifLfy2/xzZya9Hz79MVHw/QhKU+YLcU9CA8FvTwIqtc8bbi0Bgq7j7oVcRQa?=
 =?us-ascii?Q?WCBQ15uCZG4fjBAGeuJCfAXPqto896KuXTFCcqvF6VLRUoWpTI1ZCXOuh/rc?=
 =?us-ascii?Q?wk3ipJlnXocRa29cxKRPkNr82sUb8odQ7d+mkEDT/PgxRDXKud09vqDJqpl3?=
 =?us-ascii?Q?IIBK9KNx/jo7AYjIy+zePTefgMC0hYU2TXQxlEFJIXz/lM0gvhK8Uj9TNluj?=
 =?us-ascii?Q?3Q2H0AW9Bf90vuQWGkEm5PxhkIIkSv0g0D0Nu5V09kJ+ys37tBxqywLsMBub?=
 =?us-ascii?Q?OaldXqlDSOUpPigeyRS6KapCto8OOkKnsK+4U+3xdf3VeYiMty+yJnSjMpsj?=
 =?us-ascii?Q?bKnt8c2gQLDnJQkQYZJqyaUP1P/IttqSoI/D34lwztMXafPtD+KzVaV0yrmf?=
 =?us-ascii?Q?I+iXpnzpTzQFwLfX86qVWjHqrWOBOSaF/iqZPg43aq7id9AL39tDUltEFGdl?=
 =?us-ascii?Q?Be8s9IChcBuQ1I3GpheVa2j84eiCZrOm4MjjGettaKF/VGde135R5G4ncQZg?=
 =?us-ascii?Q?cIIcp4UXmNUv98+ceuDLVaiVkfrSh8yyWDJAkhimw90blVcpmb757SBRRSLl?=
 =?us-ascii?Q?9/j7GjVXeEduVJ3VOzoh4YwdJe+q+KtXUNqyg3aLaN+tlbyeeClkNj3HuIqN?=
 =?us-ascii?Q?px8KjtUorU0awN9fsaAKSS3oSUWsypWL4fNrzg7nsi404sVIxP/YbYofxPwn?=
 =?us-ascii?Q?V/CSbISHFs7XVuuHG01sijTq7vofs/ZbAvA6P9044BjYZddTadJ1X/cgUK1d?=
 =?us-ascii?Q?13joYn9ri+O3lWKKlHtrUyExM9tQlbsk4H1KrxDyOoM3U+gqkuNFB4GWipbl?=
 =?us-ascii?Q?/yy3I6g048cdZDeo9+c=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 02:05:04.9798 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d08289c2-27af-4026-59fd-08de1c0fbcd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7368
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

In legacy way, bad page is queried from MCA registers, switch to
getting it from PMFW when PMFW manages eeprom data.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 137 ++++++++++++++----------
 2 files changed, 90 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index de8aa2e36d38..81135cd45d0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3296,7 +3296,13 @@ int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev,
 	mutex_lock(&con->recovery_lock);
 	control = &con->eeprom_control;
 	data = con->eh_data;
-	unit_num = data->count / adev->umc.retire_unit - control->ras_num_recs;
+	if (amdgpu_ras_smu_eeprom_supported(adev))
+		unit_num = control->ras_num_recs -
+			control->ras_num_recs_old;
+	else
+		unit_num = data->count / adev->umc.retire_unit -
+			control->ras_num_recs;
+
 	save_count = con->bad_page_num - control->ras_num_bad_pages;
 	mutex_unlock(&con->recovery_lock);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 2e039fb778ea..3eb252de343b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -96,67 +96,96 @@ void amdgpu_umc_handle_bad_pages(struct amdgpu_device *adev,
 {
 	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	struct amdgpu_ras_eeprom_control *control = &con->eeprom_control;
 	unsigned int error_query_mode;
 	int ret = 0;
 	unsigned long err_count;
 
 	amdgpu_ras_get_error_query_mode(adev, &error_query_mode);
 
+	err_data->err_addr =
+		kcalloc(adev->umc.max_ras_err_cnt_per_query,
+			sizeof(struct eeprom_table_record), GFP_KERNEL);
+
+	/* still call query_ras_error_address to clear error status
+	 * even NOMEM error is encountered
+	 */
+	if (!err_data->err_addr)
+		dev_warn(adev->dev,
+			"Failed to alloc memory for umc error address record!\n");
+	else
+		err_data->err_addr_len = adev->umc.max_ras_err_cnt_per_query;
+
 	mutex_lock(&con->page_retirement_lock);
-	ret = amdgpu_dpm_get_ecc_info(adev, (void *)&(con->umc_ecc));
-	if (ret == -EOPNOTSUPP &&
-	    error_query_mode == AMDGPU_RAS_DIRECT_ERROR_QUERY) {
-		if (adev->umc.ras && adev->umc.ras->ras_block.hw_ops &&
-		    adev->umc.ras->ras_block.hw_ops->query_ras_error_count)
-		    adev->umc.ras->ras_block.hw_ops->query_ras_error_count(adev, ras_error_status);
-
-		if (adev->umc.ras && adev->umc.ras->ras_block.hw_ops &&
-		    adev->umc.ras->ras_block.hw_ops->query_ras_error_address &&
-		    adev->umc.max_ras_err_cnt_per_query) {
-			err_data->err_addr =
-				kcalloc(adev->umc.max_ras_err_cnt_per_query,
-					sizeof(struct eeprom_table_record), GFP_KERNEL);
-
-			/* still call query_ras_error_address to clear error status
-			 * even NOMEM error is encountered
-			 */
-			if(!err_data->err_addr)
-				dev_warn(adev->dev, "Failed to alloc memory for "
-						"umc error address record!\n");
-			else
-				err_data->err_addr_len = adev->umc.max_ras_err_cnt_per_query;
-
-			/* umc query_ras_error_address is also responsible for clearing
-			 * error status
-			 */
-			adev->umc.ras->ras_block.hw_ops->query_ras_error_address(adev, ras_error_status);
+	if (!amdgpu_ras_smu_eeprom_supported(adev)) {
+		ret = amdgpu_dpm_get_ecc_info(adev, (void *)&(con->umc_ecc));
+		if (ret == -EOPNOTSUPP &&
+		    error_query_mode == AMDGPU_RAS_DIRECT_ERROR_QUERY) {
+			if (adev->umc.ras && adev->umc.ras->ras_block.hw_ops &&
+			    adev->umc.ras->ras_block.hw_ops->query_ras_error_count)
+				adev->umc.ras->ras_block.hw_ops->query_ras_error_count(adev,
+								ras_error_status);
+
+			if (adev->umc.ras && adev->umc.ras->ras_block.hw_ops &&
+			    adev->umc.ras->ras_block.hw_ops->query_ras_error_address &&
+			    adev->umc.max_ras_err_cnt_per_query) {
+				err_data->err_addr =
+					kcalloc(adev->umc.max_ras_err_cnt_per_query,
+						sizeof(struct eeprom_table_record), GFP_KERNEL);
+
+				/* still call query_ras_error_address to clear error status
+				 * even NOMEM error is encountered
+				 */
+				if (!err_data->err_addr)
+					dev_warn(adev->dev,
+						"Failed to alloc memory for umc error address record!\n");
+				else
+					err_data->err_addr_len =
+						adev->umc.max_ras_err_cnt_per_query;
+
+				/* umc query_ras_error_address is also responsible for clearing
+				 * error status
+				 */
+				adev->umc.ras->ras_block.hw_ops->query_ras_error_address(adev,
+								ras_error_status);
+			}
+		} else if (error_query_mode == AMDGPU_RAS_FIRMWARE_ERROR_QUERY ||
+		    (!ret && error_query_mode == AMDGPU_RAS_DIRECT_ERROR_QUERY)) {
+			if (adev->umc.ras &&
+			    adev->umc.ras->ecc_info_query_ras_error_count)
+				adev->umc.ras->ecc_info_query_ras_error_count(adev,
+								ras_error_status);
+
+			if (adev->umc.ras &&
+			    adev->umc.ras->ecc_info_query_ras_error_address &&
+			    adev->umc.max_ras_err_cnt_per_query) {
+				err_data->err_addr =
+					kcalloc(adev->umc.max_ras_err_cnt_per_query,
+						sizeof(struct eeprom_table_record), GFP_KERNEL);
+
+				/* still call query_ras_error_address to clear error status
+				 * even NOMEM error is encountered
+				 */
+				if (!err_data->err_addr)
+					dev_warn(adev->dev,
+						"Failed to alloc memory for umc error address record!\n");
+				else
+					err_data->err_addr_len =
+						adev->umc.max_ras_err_cnt_per_query;
+
+				/* umc query_ras_error_address is also responsible for clearing
+				 * error status
+				 */
+				adev->umc.ras->ecc_info_query_ras_error_address(adev,
+								ras_error_status);
+			}
 		}
-	} else if (error_query_mode == AMDGPU_RAS_FIRMWARE_ERROR_QUERY ||
-	    (!ret && error_query_mode == AMDGPU_RAS_DIRECT_ERROR_QUERY)) {
-		if (adev->umc.ras &&
-		    adev->umc.ras->ecc_info_query_ras_error_count)
-		    adev->umc.ras->ecc_info_query_ras_error_count(adev, ras_error_status);
-
-		if (adev->umc.ras &&
-		    adev->umc.ras->ecc_info_query_ras_error_address &&
-		    adev->umc.max_ras_err_cnt_per_query) {
-			err_data->err_addr =
-				kcalloc(adev->umc.max_ras_err_cnt_per_query,
-					sizeof(struct eeprom_table_record), GFP_KERNEL);
-
-			/* still call query_ras_error_address to clear error status
-			 * even NOMEM error is encountered
-			 */
-			if(!err_data->err_addr)
-				dev_warn(adev->dev, "Failed to alloc memory for "
-						"umc error address record!\n");
-			else
-				err_data->err_addr_len = adev->umc.max_ras_err_cnt_per_query;
-
-			/* umc query_ras_error_address is also responsible for clearing
-			 * error status
-			 */
-			adev->umc.ras->ecc_info_query_ras_error_address(adev, ras_error_status);
+	} else {
+		if (!amdgpu_ras_eeprom_update_record_num(control)) {
+			err_data->err_addr_cnt = err_data->de_count =
+				control->ras_num_recs -	control->ras_num_recs_old;
+			amdgpu_ras_eeprom_read_idx(control, err_data->err_addr,
+				control->ras_num_recs_old, err_data->de_count);
 		}
 	}
 
@@ -166,7 +195,7 @@ void amdgpu_umc_handle_bad_pages(struct amdgpu_device *adev,
 		if ((amdgpu_bad_page_threshold != 0) &&
 			err_data->err_addr_cnt) {
 			amdgpu_ras_add_bad_pages(adev, err_data->err_addr,
-						err_data->err_addr_cnt, false);
+				err_data->err_addr_cnt, amdgpu_ras_smu_eeprom_supported(adev));
 			amdgpu_ras_save_bad_pages(adev, &err_count);
 
 			amdgpu_dpm_send_hbm_bad_pages_num(adev,
-- 
2.34.1

