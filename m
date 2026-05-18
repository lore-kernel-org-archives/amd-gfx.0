Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D75E9CD4F55
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 08:35:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6951610E732;
	Mon, 18 May 2026 08:35:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OobI7vN4";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010004.outbound.protection.outlook.com [52.101.46.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCDBB10E732
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 08:35:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=amDIhX9xCviGRYJffan6Ps1Zka48npZ/4U7G7FElbOFn1OW67KNeM98Urkd6yKecG424vg1en1jYfi+pai00NKbkXkhG6rA8PoWL7mEVmpG6b5t9mZmqBzAUuOqr/OH9AAdMn6ksXCL0tySFC0Uk0012aTKMB4FWHPAQwmlv+dB7aKDhrhUPnAVzkinOj69KOekrg29ZS6nBrk6fxmodFj845m8SNw0skZA/lSM8/yVkcErPvH4FhoXKWNcbFfaHTl67vI52SssRMWgU/GtIASgzn8isMlPmNVR9HpvUY8VHCw9THNh2MvTOCUSV8zMMuTC57/nLaGdpNo/gBCX4rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YsHYIJEtk5Cpegj1IQggnjyu9UP+TlKbcXV4W4/XZGQ=;
 b=m70pNmAqYfegCGolTbayONSqZQo3gwqoefp/GHejYxGKgAnwNy49uqLR6zHC60U6PY4XuS5XiNecIj+EHqc1wioy5SQhDwQUzafAwSmOCV+2NIPcFVxchgFR1DSYQVcL3E+M19pu5jkjXYZS6FnAuZWagAOSTFZLZgq5Pr01Kfv/PLhwwcAfgn3iTT3pUc7IIKo53QTzUnf6JQpGMEi1Qw9t13nOaz2HQLOiNkV7frNWwrBLsxM0D5jDixmRw5eNFNeHbpNfsIKOCqHFPEK7wKx9Vmi0OsaKqZ6AvePWKCIHD8TH9LPSa+FW8rZTYWmlZs3GAVrV6BWvYAK+5U3gqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsHYIJEtk5Cpegj1IQggnjyu9UP+TlKbcXV4W4/XZGQ=;
 b=OobI7vN4ZQA+cQLby2r9ToqkDZ+L5FzrVPmrspW3z0dL1YHnD/gulQTw/NnrCmshy016yNLAAXfMdVluqUj3B3ZT4GKQz2rqOYZi8B+DxVbTeT3nmZReeZrJNI/cIxmPbFsMtCDU/Hmn1XsG6u6IjYgsUx/JhnT6509dF+q8OWQ=
Received: from PH7P220CA0132.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::24)
 by BL3PR12MB6523.namprd12.prod.outlook.com (2603:10b6:208:3bf::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.20; Mon, 18 May
 2026 08:35:43 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:510:327:cafe::54) by PH7P220CA0132.outlook.office365.com
 (2603:10b6:510:327::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Mon, 18
 May 2026 08:35:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 08:35:42 +0000
Received: from canli-build.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 18 May
 2026 03:35:39 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Stanley Yang <stanley.yang@amd.com>, Thomas Chai <yipeng.chai@amd.com>,
 Candice Li <candice.li@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: Bound GPIO I2C table entry count from VBIOS
Date: Mon, 18 May 2026 16:35:26 +0800
Message-ID: <20260518083526.790945-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|BL3PR12MB6523:EE_
X-MS-Office365-Filtering-Correlation-Id: 6089738c-10ed-4960-7882-08deb4b872b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|18002099003|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info: AcxCxDJpD+/wYS61oHZyfObTF4KZdLLjvKIL1/ZKF0KZOqp7Wpz/MLs/V/fMMtSJAHF4cHfB3uljRaM8mG4r9fBl/qLJYJs3Atw+gQt9drXkUsyVYFy8XJzRJqc3IyBT2IAhvIDJsu8ruXWPNaNVJbOAgPOkXJyKAazT7nLFh4uqB2e6bcyJU4sid0YhrXcX3i+5uINLA7aSibM08ZgDx2uQTtOUvAqsBnzXZGMwvnfiBwbaB+bVadiHIylj6oJyEjatnOkn5TTPm3JXL/5Z4Io5Kv3xbfdQapuB/Iob4PfpM/Z+Dt7JEfgv23OOGYkOh3BW7z43lK11JbO+YKUEIZk4E3JkFfBKiA8Ss/qCXnV52h9XbSfmLOvu/mlfeWbtLqXy1stitaGFLZbL9RAl0wEP7Ik9jq0AKg+ssjKLxkjOIJFVnODmNtgC/wFB97pWpTioJjOYjw1KHkFWjSl+zVjzVLmqjxd/uYyLgnl4m9UBF+Ji/jfntVtps7ep29xtD1Xtco4ygyWeSFLsQhvOueKsTmR0Q9wMa/KkM9so1v5yd4qbNDrZF8hQZT6TmmR6UA65DHfT+RM1gQ/AwnqK5etGbQeTPENHrJbW1KmJOa2FCV3JXcYtqmo8smWDWW0FfZ8cl3hb5yoXkVWIXOnyUdXM1mz+y41bpZ6ZnaVCkj/OGyUFlIHTFtBqDKKwE+cdb6ZXizam6MTOZRA7a0l5HkKK3gtl1uMkgXSsPuGDVEg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(18002099003)(11063799003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kgUwsnh3WnRWoXJyyV+SgQ93yAWV1lPJ6muKEcvlz3mx5WobAdSUgLLSJ04xyKc+96eJH4Rtur6DnN+GLoB4lDcL7T4B4aKkpnweV7FoHUbkrRvCFPVdYrsSvhAyn7ft04yYDmJkMW8Iget1s5x1D5ePHH04gjfBOq/jFbQdjOpAdpSeIXU+B3GwC+mXZVBfZHN7rpnaLCMmAkuyhQHGTm4Fbg2eajIVcJ6fsSaaT4NRswjbvNcqsT+pvIgInHfr/g82qEutSC41ZbXUMqs/wuBvV1t4U0YAAapWzazA+uwitvQAEPAr1cZyH5pYVDiIqFZFyw5pat2KHgedz9irGuG9MTqryKqPYXF4TX1gzYHQJYX/EPKDee32/FEJlb9R45dm+1OV7QgZHI6RCjiJ/pX8iodc2q9LjLJc+3VVum5XGF+YwYKRoFOzoR1dNR6j
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 08:35:42.3792 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6089738c-10ed-4960-7882-08deb4b872b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6523
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

Reject undersized tables and cap the derived entry count
to AMDGPU_MAX_I2C_BUS so we do not overrun adev->i2c_bus[]
or walk an absurd number of entries on corrupt size fields.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 24 +++++++++++++++-----
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
index 956eb33008f85d..ca65e6ebdb25e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -36,6 +36,21 @@
 #include "atombios_encoders.h"
 #include "bif/bif_4_1_d.h"
 
+/* VBIOS-reported table size is unchecked against the image; cap iterations and
+ * adev->i2c_bus[] indexing to AMDGPU_MAX_I2C_BUS.
+ */
+static int amdgpu_atombios_gpio_i2c_num_entries(uint16_t size)
+{
+	u32 bytes;
+
+	if (size < sizeof(ATOM_COMMON_TABLE_HEADER))
+		return 0;
+
+	bytes = size - sizeof(ATOM_COMMON_TABLE_HEADER);
+	return (int)min_t(u32, bytes / sizeof(ATOM_GPIO_I2C_ASSIGMENT),
+			  AMDGPU_MAX_I2C_BUS);
+}
+
 static struct amdgpu_i2c_bus_rec amdgpu_atombios_get_bus_rec_for_i2c_gpio(ATOM_GPIO_I2C_ASSIGMENT *gpio)
 {
 	struct amdgpu_i2c_bus_rec i2c;
@@ -96,8 +111,7 @@ struct amdgpu_i2c_bus_rec amdgpu_atombios_lookup_i2c_gpio(struct amdgpu_device *
 	if (amdgpu_atom_parse_data_header(ctx, index, &size, NULL, NULL, &data_offset)) {
 		i2c_info = (struct _ATOM_GPIO_I2C_INFO *)(ctx->bios + data_offset);
 
-		num_indices = (size - sizeof(ATOM_COMMON_TABLE_HEADER)) /
-			sizeof(ATOM_GPIO_I2C_ASSIGMENT);
+		num_indices = amdgpu_atombios_gpio_i2c_num_entries(size);
 
 		gpio = &i2c_info->asGPIO_Info[0];
 		for (i = 0; i < num_indices; i++) {
@@ -127,8 +141,7 @@ void amdgpu_atombios_i2c_init(struct amdgpu_device *adev)
 	if (amdgpu_atom_parse_data_header(ctx, index, &size, NULL, NULL, &data_offset)) {
 		i2c_info = (struct _ATOM_GPIO_I2C_INFO *)(ctx->bios + data_offset);
 
-		num_indices = (size - sizeof(ATOM_COMMON_TABLE_HEADER)) /
-			sizeof(ATOM_GPIO_I2C_ASSIGMENT);
+		num_indices = amdgpu_atombios_gpio_i2c_num_entries(size);
 
 		gpio = &i2c_info->asGPIO_Info[0];
 		for (i = 0; i < num_indices; i++) {
@@ -158,8 +171,7 @@ void amdgpu_atombios_oem_i2c_init(struct amdgpu_device *adev, u8 i2c_id)
 	if (amdgpu_atom_parse_data_header(ctx, index, &size, NULL, NULL, &data_offset)) {
 		i2c_info = (struct _ATOM_GPIO_I2C_INFO *)(ctx->bios + data_offset);
 
-		num_indices = (size - sizeof(ATOM_COMMON_TABLE_HEADER)) /
-			sizeof(ATOM_GPIO_I2C_ASSIGMENT);
+		num_indices = amdgpu_atombios_gpio_i2c_num_entries(size);
 
 		gpio = &i2c_info->asGPIO_Info[0];
 		for (i = 0; i < num_indices; i++) {
-- 
2.25.1

