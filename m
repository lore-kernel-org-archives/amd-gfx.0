Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3138C3DA4B
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 11:20:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7412010E0DB;
	Wed, 17 Jul 2024 11:20:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XailiSqt";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B4CB10E0DB
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 11:20:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N5Q+Xf4ePC9spQRsX6HUCLHfqpuwIdqLrbyUQYqRX6NsO0iDAqIWK/ehYW9+XEGgSGjOZ64zWbxh6wdrXk9V1WECMCLVxVebt+U1TDRkswLb8OETfHeTVLflyi6cPymsvZvcWYJTnEvLrKtJqLuYQlyzH04IJuRGz8sp5zWy8CEGioXlrCcx1zefxo3mb1LKNMQOddK/M6Mq6lWee85Ikwjx6JP1t9K4fj5BB80UcD/esBuzgGa6LcFTd8guLJBCWpD4foAhlnAnRNVEvP7TdtqRcV2CWXuX1o5SWWcNSHMf5CDWKYuy/LZ7w5zk0jW9yT7+MnJqOOMaNMTAQad2Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X80G9nocX763jr/eBI9P6UbhXB8eMtrL45R9dDxGiHA=;
 b=I7WnOD+HHSEbtX+RRWBfMWosL21NfExK3h8/dEcHTdhyeFmokRBl4hwt4q7Jy6w9Y+biJn7xmNcOrWB4rNBoJIYBm6oX4tZJes1VEPLnmTzGGah976i6qQnwpH2RrwmPEAKdXgfUumkSX825qDbUz3XWeuFUJFdpK9fNDPwnM+upMsO0F+Scr/QJJ/PAEluCU9Ltm2hnvl+pdBwmXekthLHiCCW8MdzOSKNOXU4YPriAsKPWBfJH+0ilhmS30Pssk7xbjiX0tCJPOBlGt86vVNYiSqJXLUprGZicwQ2UPkUBKAzB/xLCzf/S6qSCrvxvD0ebvhHDkf670Axa86nImQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X80G9nocX763jr/eBI9P6UbhXB8eMtrL45R9dDxGiHA=;
 b=XailiSqticxXvwbnE6xDuVpgjyBs+19GPAxK5oktbeAOwm39MObYf5xPZiiTIFhTNYmJixfvvzY/KBjyHR6xvFQ3uSNJ6I05yDnUpTFWLQZlL/K1g6YTPZMOuKM345TJS1KBLXZfmiNFSB9g+CfKHFanM4s60GaDh0+5vrUCkdo=
Received: from BL0PR02CA0032.namprd02.prod.outlook.com (2603:10b6:207:3c::45)
 by SA3PR12MB7921.namprd12.prod.outlook.com (2603:10b6:806:320::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 11:20:43 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:207:3c:cafe::97) by BL0PR02CA0032.outlook.office365.com
 (2603:10b6:207:3c::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Wed, 17 Jul 2024 11:20:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 11:20:43 +0000
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 06:20:41 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Stanley.Yang <Stanley.Yang@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: Fix eeprom max record count
Date: Wed, 17 Jul 2024 19:20:27 +0800
Message-ID: <20240717112027.1347891-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|SA3PR12MB7921:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e88c033-f957-44f5-1ac2-08dca6527f50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sg4Dh25lfSrYMNfQ+U0sfRZ77KwL7BtRNgZ0ZAEV1CHPLXF8B3zoRW2AyNsf?=
 =?us-ascii?Q?pSUPtt83GgE2PfyGVrHYLk3ywe3bdFp/jXI6StzBOgtE0RMbNtO5EZJf2lRl?=
 =?us-ascii?Q?gbiwqUxLNrpgBdwviA0iBaSO4zhpQDq7DiIr3CGpgMKMnUUmEvh7eZXG7wLW?=
 =?us-ascii?Q?WIkVYU3WAgfyMxliRVDlgyKxUGpXcK+P+HlDZrKmCWlmqJyuz9tUstNjtVue?=
 =?us-ascii?Q?o0+ND9b91P6WZtsiR1NMTw0zjpCx9d6yKgnD2hKBm7speSx3PU6JcHq1kMxa?=
 =?us-ascii?Q?8w0OLA+akwxLiIVflTRx6XvUD2LEv3oCcsfg/w1C5gCuOaYhSHP4JKWL3jmG?=
 =?us-ascii?Q?Ldr/lb0HdVxwfXaJ+hLf5Xy8its7KOJNnk+V3pvsVCBKLTJVZVP0hyi90U0Z?=
 =?us-ascii?Q?ZkwhPEPjiA5kL+FBNG0WJroFDQi4Qn7EpPjP6WH86Mq8glEY8Glsg/PSXV39?=
 =?us-ascii?Q?5mo4LJ8ESnnmKBXz7k1khLjICVCDO7FJ+64F0IgU283oh5Ik23oJb359aDQt?=
 =?us-ascii?Q?khHpR8dpRHOKSdfQRf3Xd0yDO5e4B5wu8AVvz4txyZRmWq4A92pxMsz3pZo7?=
 =?us-ascii?Q?P85zjJkdDSlRmJ2Wh4LtvDUDdvTLuA66WHebKPCuN+dMxd4gVA8+iNp3xPun?=
 =?us-ascii?Q?HrFizhhtjP4qksfLs5tlASRhb0Oj5fkfhVyRNzZbZnZRxWccub7YcvNQkLh5?=
 =?us-ascii?Q?GGvf34l4NtMUiml30hr/rO3imsUvSQBmMJmyDedE9RWAJr3WKGdILDNG3NxI?=
 =?us-ascii?Q?on5Mq4FsihzrQR7WZ+hcBkskDzqdMJREXoNAmy+hboG65jHixK79ahrnN8Lu?=
 =?us-ascii?Q?U1oojqloa8iow826nOUemE8U3zlgq8AIh6sIuOwFtj1SOGKpVlxlm/6bKdlM?=
 =?us-ascii?Q?yt1u1bFx4c3cJQaFtWD2Zva556OSJ4LEOJxQ3yXsWJRtN8zPACh1GRXlPn2p?=
 =?us-ascii?Q?u0sQprIgBhVp2DJm7stdg9WY3sfF0aO62LhOA/B7kKjfv2Kd/0F6E8Edtb/x?=
 =?us-ascii?Q?Ka4T7AYxEqQBnw8KAwm1iX1bTMN6srbsaPnEXRZ24UcHh9+vqVfzrlZgeK5O?=
 =?us-ascii?Q?c+fA3JlHz1ZHZ18HxFyIdIwxc+GxZIV0Y5SMU/OsQkY+QO0bJ+wFfTsPxdqq?=
 =?us-ascii?Q?LpljUoJ9rXzOXVA1GrQ3PLuX4GZfBkfiw8O4pK6HzRhd/HvfiN/Lf/xH+NN6?=
 =?us-ascii?Q?CE+IexzmK1R1QZZxFribBS4kGjjrHpOIdqP7hLHyu9N1er597w/f4cHcG/57?=
 =?us-ascii?Q?Bo09mWwhn0///Lz+DEJuloJo2wL/CfkcqoC8jebnEkZzR8IbRT2T3uGtLbAa?=
 =?us-ascii?Q?ehTZEthQP9dZ7ThvbcXVq95L3xgxq+bwrGclbLSp7sGGooMtLjGpBPk4d5s1?=
 =?us-ascii?Q?6bgOERu4n0lILpe/iDUge44OjPizCy118QgUAgqVdc5eTOf7RVE/FHOiv8ST?=
 =?us-ascii?Q?TA6k+CxXq/kOb8M4ojpNxZ2RENku/+VM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 11:20:43.2471 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e88c033-f957-44f5-1ac2-08dca6527f50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7921
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

The eeprom table is empty before initializing,
add get eeprom table version function according
UMC HWIP version before initializing eeprom table.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index eae0a555df3c..c30d7daab472 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -406,6 +406,21 @@ static int amdgpu_ras_eeprom_correct_header_tag(
 	return res;
 }
 
+static uint32_t amdgpu_ras_get_eeprom_table_version(struct amdgpu_ras_eeprom_control *control)
+{
+	struct amdgpu_device *adev = to_amdgpu_device(control);
+
+	switch (amdgpu_ip_version(adev, UMC_HWIP, 0)) {
+	case IP_VERSION(8, 10, 0):
+	case IP_VERSION(12, 0, 0):
+		return RAS_TABLE_VER_V2_1;
+	default:
+		return RAS_TABLE_VER_V1;
+	}
+
+	return RAS_TABLE_VER_V1;
+}
+
 static void amdgpu_ras_set_eeprom_table_version(struct amdgpu_ras_eeprom_control *control)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
@@ -1011,7 +1026,9 @@ int amdgpu_ras_eeprom_read(struct amdgpu_ras_eeprom_control *control,
 
 uint32_t amdgpu_ras_eeprom_max_record_count(struct amdgpu_ras_eeprom_control *control)
 {
-	if (control->tbl_hdr.version == RAS_TABLE_VER_V2_1)
+	uint32_t tbl_version = amdgpu_ras_get_eeprom_table_version(control);
+
+	if (tbl_version == RAS_TABLE_VER_V2_1)
 		return RAS_MAX_RECORD_COUNT_V2_1;
 	else
 		return RAS_MAX_RECORD_COUNT;
-- 
2.25.1

