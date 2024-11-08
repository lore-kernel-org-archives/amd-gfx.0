Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35845D5E15E
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2024 11:15:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D993610E971;
	Fri,  8 Nov 2024 11:15:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n+0FLP/H";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2977210E971
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2024 11:15:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNCEtvMYD+55udA4+1ALnSL0vIaWdpARsjAaPSScHumxO0sr8f0HYWDPF4xokWk8Qki8/qsDVCcfqJhZxT4k2S2jvHtBgQybT9HGYvmsdNTDpUkP9X3in+ABfOIBvn3uQoPBzg6bgNvcvNLvWpx5lUONbcs1FkTmEee3jC5NZmUYC3De7iNLk7zxMvVaaFFtRoqYv9926i6qhBHTEPFWJGyAFs5BSiZF4IuxcXpn17FSv3/eRRr5bY9W6nERex1a+P2mTfLHxh6om6JY3SFFOOUQtLIAp0QpdxZ6eclv9vuHZLu6LgH/5BXbbIWGvcJlSw7KG6Hnb6RmPly43kDmOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WhDcPqGuuB53B7XGDTvBmo/prl3zcLkq83yJyLIKuFg=;
 b=JdrnwQF2YAO8e+fAjxgKZoGD82ySRpWr3p3xaDBQcoTdA4E81Bq8EyDHlnQFEWVsmNbNNMNSFTaN/qNqaiWfpCiuu0x2vZcI9mmLJDXBhFchMakozdPiE+dzNfh9OLHKgNnSSbM7beVl6ooTgLC/MOEQkvLbjCnF1sR6LFTnLrYLPGF38FDcX8ESwQ/A9WxQmIcra/izjXONBIA42Q0nRlD6hEax726A31/LpiksY4G2WmPO8XgwxAHYzG2J3XBhPKFf+EDrjhlJi8/sQxa859e0cuhcoLyUCm/WM54NyLCktpx96ok2vEPwLqMfcg6OC1MjchQhfu0TMzxCUeKJdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhDcPqGuuB53B7XGDTvBmo/prl3zcLkq83yJyLIKuFg=;
 b=n+0FLP/HCRRaluVOqQgEQCNhT8h/fxaCzlw6z3aBrlYrTP0bx/sUmF94vMv3qJL7kgqdm++oyGYHMK2TvM6XH1C4SZr9Fa+o9z20kSQYMPg6J0NquYA4eENepYui+2c955ZKW8pZkJDGxlfdh2RHBb685lNZ6qQMXTdN8YM6ZgY=
Received: from BN9PR03CA0254.namprd03.prod.outlook.com (2603:10b6:408:ff::19)
 by MN0PR12MB6294.namprd12.prod.outlook.com (2603:10b6:208:3c1::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Fri, 8 Nov
 2024 11:14:56 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:408:ff:cafe::3e) by BN9PR03CA0254.outlook.office365.com
 (2603:10b6:408:ff::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Fri, 8 Nov 2024 11:14:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Fri, 8 Nov 2024 11:14:56 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 05:14:54 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 20/23] drm/amdgpu: add from_rom parameter for ras_add_bad_pages
Date: Fri, 8 Nov 2024 19:14:20 +0800
Message-ID: <20241108111423.60169-20-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108111423.60169-1-tao.zhou1@amd.com>
References: <20241108111423.60169-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|MN0PR12MB6294:EE_
X-MS-Office365-Filtering-Correlation-Id: dddeb2bf-1eb7-4807-c252-08dcffe69390
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4+6weE+FrMBdAmpNCl871T0TJJnwsHN6rON45fI+TXayFV1ENBvD7AYcKL9R?=
 =?us-ascii?Q?DslEu0ZtP9dMAXFLw9QF3Cgimi2abvyW9K7TLuHQq8oIgzde2L9aZBgI/ZGV?=
 =?us-ascii?Q?7aNM7igKffoGKHXyzl/0PHXi6OupYDCt/YdhRYmrVY4TZVryOs2Q+0NM6DQ+?=
 =?us-ascii?Q?V/IvZNJ8ATEqzBJ343ex9igo9nFcXNKYnyx4PKE7rOAyrvk4nIOCfonq+XCt?=
 =?us-ascii?Q?Z6DvSsBDqI/MDBwcKaLQahF71fssUACzFGRbMIQHNC1077/kK0lPuSxoCFt2?=
 =?us-ascii?Q?FlLt1LG4DN9PPM9ruCxXtiL0j/SKNaFNmEAllvT1HO6Cbta01YCcaxKO9cB3?=
 =?us-ascii?Q?8ptliwU8FSJfMLUcyeklQVJbj4ooVbWNiwsQasxkAbKZ5wHvl0RPRjfB4jRn?=
 =?us-ascii?Q?b5cqq/QwgT3iIwlaaLUHT6zHWyS0o0UpKN2B7EGqb6F8mJblOh1u5UVeMxKE?=
 =?us-ascii?Q?U1QRa7xwO01A5qh9ymztlsHoCC7WBdc9CNUebbAL5ZzbYQP2Fzav1vL3o6f2?=
 =?us-ascii?Q?aF5e9poBizCiv/98IkHerc5GDGZCrRZwgAPcimjXCbc0/xmS1ODGtOoj/4m6?=
 =?us-ascii?Q?ZfkL2wUxOS7Z5hgAItf6qDK71mzljq0p3lQW91kQqTgbBqQJHBoXnpmFMyCW?=
 =?us-ascii?Q?XKVXe3PBA8t/nxujXxXuFyzaOl6PuEgvYI/IMbzvGJkPR9Ccm/Z3EtCdaVBj?=
 =?us-ascii?Q?RksApoXEew8Qc9tT5Nl3OviAtQs8Ex5Q1YCFqSiUcDPcU1JF5UXpsCasGxDk?=
 =?us-ascii?Q?B/7+LktgWCADUy1cxVNay/+hCcT7ELtiKdUeOkGeY3t45l5t/W/NHwgrotM7?=
 =?us-ascii?Q?EuQviorDjCWssYDTvTx9cQ8y+WvWafOZLZ8UyAhVW5Sr6kM161FdDpR1R3UP?=
 =?us-ascii?Q?gKMjEZwcbbAAOpN+DreehL8+38EBgh8UqiFDqLbn3LpEOYPzmVZ2MgkbYSae?=
 =?us-ascii?Q?RJDpI6r/VemHW2Z3biuwK5dz0RsSjhAyRpdQsUZHXvcxft9p1ErdOO/8r4Qg?=
 =?us-ascii?Q?rYcEw/dbI4TSXCIc3bRa/gWB4pzA2XRlCh5i898yOrgCBfetpj7Yd5tUJuyc?=
 =?us-ascii?Q?srpwUfAR3VrL203LSXQ06b3iKdn7LsIL0ntW6ETkKmFO6chYD3ax83doOWZr?=
 =?us-ascii?Q?iPu5WWrGqg8E1eQgnAKmrs7JvXkxDfDli3ObGIUmzBSzr9gB3RqNlbOnCVMQ?=
 =?us-ascii?Q?/CWKfXDZ68lmEqsPRI5i0+yJ2+vPBPKZCiRO7L+o/S0DLTEGHz1Fxu/06pJK?=
 =?us-ascii?Q?YWhEKdibBnGV8QNHH7w1kkgTsEylvj3Swfph016gqMj82Vcl3k6dEpLONyxE?=
 =?us-ascii?Q?m5jLyg5eXoynX18rcHTsa3bqTz159qNHXTnAj8/2+sOHD8OMFEtCDvrWr9uP?=
 =?us-ascii?Q?jsOjNnnG2tMlzu/z92wqkUbbt0nC1jh78QfO3a0XCDDPhX4eXw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 11:14:56.2285 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dddeb2bf-1eb7-4807-c252-08dcffe69390
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6294
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

Tell the function if the error records come from eeprom.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 4f1dea11501f..bc4a5db2793a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -192,7 +192,7 @@ static int amdgpu_reserve_page_direct(struct amdgpu_device *adev, uint64_t addre
 
 	if (amdgpu_bad_page_threshold != 0) {
 		amdgpu_ras_add_bad_pages(adev, err_data.err_addr,
-					 err_data.err_addr_cnt);
+					 err_data.err_addr_cnt, false);
 		amdgpu_ras_save_bad_pages(adev, NULL);
 	}
 
@@ -2733,7 +2733,7 @@ static int amdgpu_ras_mca2pa(struct amdgpu_device *adev,
 
 /* it deal with vram only. */
 int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
-		struct eeprom_table_record *bps, int pages)
+		struct eeprom_table_record *bps, int pages, bool from_rom)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_err_handler_data *data;
@@ -2939,7 +2939,7 @@ static int amdgpu_ras_load_bad_pages(struct amdgpu_device *adev)
 				control->rec_type = AMDGPU_RAS_EEPROM_REC_MCA;
 		}
 
-		ret = amdgpu_ras_add_bad_pages(adev, bps, control->ras_num_recs);
+		ret = amdgpu_ras_add_bad_pages(adev, bps, control->ras_num_recs, true);
 	}
 
 	kfree(bps);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 252e360c6416..4a3a1e73bcbf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -751,7 +751,7 @@ int amdgpu_ras_query_error_count(struct amdgpu_device *adev,
 
 /* error handling functions */
 int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
-		struct eeprom_table_record *bps, int pages);
+		struct eeprom_table_record *bps, int pages, bool from_rom);
 
 int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev,
 		unsigned long *new_cnt);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 17659fa4450a..f7867c462ab9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -78,7 +78,7 @@ int amdgpu_umc_page_retirement_mca(struct amdgpu_device *adev,
 
 	if (amdgpu_bad_page_threshold != 0) {
 		amdgpu_ras_add_bad_pages(adev, err_data.err_addr,
-						err_data.err_addr_cnt);
+						err_data.err_addr_cnt, false);
 		amdgpu_ras_save_bad_pages(adev, NULL);
 	}
 
@@ -166,7 +166,7 @@ void amdgpu_umc_handle_bad_pages(struct amdgpu_device *adev,
 		if ((amdgpu_bad_page_threshold != 0) &&
 			err_data->err_addr_cnt) {
 			amdgpu_ras_add_bad_pages(adev, err_data->err_addr,
-						err_data->err_addr_cnt);
+						err_data->err_addr_cnt, false);
 			amdgpu_ras_save_bad_pages(adev, &err_count);
 
 			amdgpu_dpm_send_hbm_bad_pages_num(adev, con->eeprom_control.ras_num_recs);
-- 
2.34.1

