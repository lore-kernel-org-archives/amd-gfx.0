Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55AD7CDB466
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 04:58:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7A2110E15F;
	Thu, 25 Jun 2026 04:58:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fdEwHlhQ";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012037.outbound.protection.outlook.com
 [40.107.200.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4A6E10E15F
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 04:58:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gzw7UjEF99Ly7UITH6lvvxd6xj/YSGpmuTTB12/uQ+ai80vXYkXODPRvBATUJzJpNE3h1jciuudjQVjamtuVDy2CTstt8ZsY+QHzd7Dfjgri9//kIq6YWW+01Vxc7lr4Oc3gwtuQNQgP1PEEYmRxfxGeNiIk1kfdsylPNGjnNruHqpnkfQ90hW0YrAxfHDlWEUsRestkZkcJeiiiqfKR4eUiaPzQ4jY18NdT+zjKuxpArLJs84E3kDUMyVnwIc6CkRGBXZumud/k1yEUlF2a73sZNez41XC1N+aPhg2z/gHowEM1QiLHN7QI2ckw5CNwqhhduGPI2tSUoq1dLxWORg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZXZRhXJkhfLKHu0YApsZHx9uD2QHJt6lzlSKJ58qUU=;
 b=wBNVF77CcB/es5sgB6meyrr8Tsw3RutbYrSnpu3WynY+i28w3rjQi470TlUz8hf7SVcuoiJrrm3evCay2clLwiA3cmpSBgt1SIAmwvMwE6qfdZgsGagDlZ9TjZQZ2pidC2ZcV89HFenL6v0zEifUVrmoJAWbyqgxjagcrixTjJ/QSAwIplTg7guAZ6zeYuOLkqyiLWFp+Nr2rGDYiRB8S9w0I0MH+Tu3wENZkzdhI/A7aVg+d+Tc2AawxWObFxJnYWjGu+zi7DzH6QEqpcNwYdUdMsr4QNCjGV2sodPcTV1HTB0U+fjSEZswExUyEgjJgkA54Frt/emo5Uvp0yF7ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZXZRhXJkhfLKHu0YApsZHx9uD2QHJt6lzlSKJ58qUU=;
 b=fdEwHlhQ+31K5/U7l3m9H4+0/sjStoBtAilk14RqZZmi17ZOetUMxyMbTi+v48q3IBZOHCRZqBJjKX3ZV6j5JALBqo+fWr2p/P1wwlWFDcR2UNEDfYfGNGpwvfDCVWr6TgMj7dwmJK562VIQfssDXQl798doeKEQLLtjvEx8pTE=
Received: from CY5PR15CA0022.namprd15.prod.outlook.com (2603:10b6:930:14::30)
 by CH2PR12MB4263.namprd12.prod.outlook.com (2603:10b6:610:a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 04:58:11 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:930:14:cafe::53) by CY5PR15CA0022.outlook.office365.com
 (2603:10b6:930:14::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.15 via Frontend Transport; Thu,
 25 Jun 2026 04:58:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 04:58:10 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 24 Jun 2026 23:58:08 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Yang Wang <kevinyang.wang@amd.com>, "Hawking
 Zhang" <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu/powerplay: Align get_tonga_state_array() header
 with prototype
Date: Thu, 25 Jun 2026 10:27:37 +0530
Message-ID: <20260625045737.3063698-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|CH2PR12MB4263:EE_
X-MS-Office365-Filtering-Correlation-Id: c753dcbf-6e7d-4f3a-0766-08ded2765b1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|376014|82310400026|56012099006|6133799003|11063799006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: XodsQYAjwwd/QCH+zOB1MKYYOfRRHT9CxH0nvCKbYVc5PsfzQX2kFbhg8dapuhlu5hL7I0k/9TlIANSqW4lB8BYu7KJpzHOulTryuHI74oke3Y2/RhH/+MYoff/6qr+gsH4suL3R2srLFOgJtxh0VhGgGc5dQ4Zre1dFOt+XkVEUbeIA0Srcs3Hmm4D7PaWGm44HK35y6tE9iD8TJ2QoPd2AR6oNjoB6pVjL4XRCTOQ86mwRoWQNmbK4bk9KoaAPEkje8mItLKoRJr40JOtw1qA6gVzYd2ynOTpSeuxLqIombzSHiU3W4HUgWGNFhn8QoewBC1neym1v+WnCHKFWI5pUoUVNkumNxFYNo49n9DMym0P0I6wDp5SDXSJpeVHzebk28FcNxzOU49Ne9/5eIXlvN+F3wE8vinACpTigJHPUr7FRhCNg4KyXgStYE1NKuSV5C6o5LqoeaCQ2nlo/MS2G8ekpeILXof+2vpav0YJt3DnZABZ7H1pg2HNnU1ZDmB+tOg3a0u3O00txwUu5zFBcJIrK3XyCQbAFRJ4tWbE8k7MGmJma3U+N7c0PY1tQAYgAqiV5g044+Q0KTbC/A7n7PJGatap6IQ5GNNFbLsN4nT+uA9cYY9t8+qgdoCUlIXtvCa3zJHPShS3Rb1Aqw2ykIxPSHLcya0nr6Nd0f+DuG0qtlWKON7PCZNH1DBXwF7L2yA6QJT517BMx6gF8Dw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(376014)(82310400026)(56012099006)(6133799003)(11063799006)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TQhXUR3/gU0mM95MLzesgrRO8YBn+yqL/s30dnZ3uOCzq1VOlBFdMiVv7HKqIJeccs9GuYoVxeinhGWsv9XgeZPL4Rztwm4AEdmKE2qmRANj2wlJL9V0abtt12T/0K2jAwmVIAct7EIli7sXLlLYwlO1zv20cKt6izY09La+4IzFFaYds/OvKnz+K4+PQZvT5VRfDZvXBPXbI0El7BrHVrIJyjj/7Yb/s05MxornD7o462QFHvMX/ZHDl0duPefJ2KoIEopt0BrPapw3iWV/zzdAoehyy8jvlNS4jThS2/AzwT2iT5Z7jmfUZNhhYpExiczhYEkY8Xa5cymDTpadh7DeWjZItRpKQsEpcN8DcNRVoG3PgPWic2a5AA/c1tR9tCxl0nAcy69phyNDkgR9zd+VmbsokLESyuARcUJqgHmXKKk4NFIypSDLym7kbLfd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 04:58:10.9175 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c753dcbf-6e7d-4f3a-0766-08ded2765b1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4263
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

The function header above get_tonga_state_array() still
refers to check_powerplay_tables() and does not describe
all of the function parameters.

Update it to match the current function prototype and
include the missing parameter description.

Fixes: 8c8c4544cc43 ("drm/amd/pm: Validate Tonga PowerPlay state array bounds")
Cc: Yang Wang <kevinyang.wang@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
index 17d5bb62e3db..0d6d711b4995 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
@@ -1546,11 +1546,12 @@ static int init_thermal_controller(
 }
 
 /**
- * check_powerplay_tables - Private Function used during initialization.
- * Inspect the PowerPlay table for obvious signs of corruption.
+ * get_tonga_state_array - Get the Tonga state array from the PowerPlay table.
  * @hwmgr: Pointer to the hardware manager.
  * @powerplay_table: Pointer to the PowerPlay Table.
- * Exception:  2 if the powerplay table is incorrect.
+ * @state_array: Pointer to the returned Tonga state array.
+ *
+ * Return: 0 on success, negative error code on failure.
  */
 static int get_tonga_state_array(struct pp_hwmgr *hwmgr,
 	const ATOM_Tonga_POWERPLAYTABLE *powerplay_table,
-- 
2.34.1

