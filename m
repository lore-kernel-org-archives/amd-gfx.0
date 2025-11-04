Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E72FCCFA04
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 08:47:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72F5410E55D;
	Tue,  4 Nov 2025 08:47:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AUDS0ukI";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012003.outbound.protection.outlook.com
 [40.93.195.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EC9B10E568
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 08:47:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3G0U/9Gv6DcU9i5js7BjclSeF6P0Bcxt7/VXtB1Vi5DQ+g7eYZ3b+5sjx13x9gi8dwOkEpAvYuwYDD4BCYS+sSHlaF1szsJj3YMZ9ildi3Yl2cYjVA7LKfa0hQSKo3W9rgDXC9UNGDPNk9pRgbnVbY8ATF4zNA1FHzipK4nvti+b9IT4drNoqw1qvkwROfzzMEvC7CyD0oDSEMM5xjWygE5nrw4EokUGuLbuw9AmD/qDNBF8a3oCT4GdRwkYZHRgv47yx858NtoJv4cX2G+8WOxPKvuOwNoacJfitzdjauxT/MXjr45i2X8s403fA6Q+1CcGxt78ItAqLhZI/n5Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yai/iijDEZJJySkxPCjElPXlseBCGZKQn4CQRM+E5eY=;
 b=b3hOsfYd0Xrr7dCYF27aTDX0AvbNMwD5SqmwnJCbhROy2cHKZDz7ZbKsasBlLHOCJg3RbH1sAt3wubuqdITXRhHote4kLYuU4gwDOfFW28J3U/VXhKAp8GekMk7leI5W6ZztxWtxfuMk3sozhoE78xjxDYotaa1+My0017pQpU430YxP/6hW+Fg6y7dQ+Xt4EWqzV1Ecb95bDeT31izlWRhlEasxGuRwL1wP7fsofYHfGw+CFnc+PX29qT/dWmxD+GDSDkJvVhM9UR7TslkAW9pLRiPi+1OcltrD96bVcnNLVe3CASAhPtevO0/hhij8ESu1IZHFfw0FK1JxAraqAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yai/iijDEZJJySkxPCjElPXlseBCGZKQn4CQRM+E5eY=;
 b=AUDS0ukITUnGDqwrW8hAQeiFwVzxTr3Dmlq9OuFvscCglt54iomU38LgG19/r0iNfuPuZDtJicFlqXCzWaffTNhHk7L8Z5YyAC2XnFlg36EJ0AFm+BE+RbpabX1RrfHBbYJZWScBYcyYvh7Fgx8r7fYU/TVMtouhw+L7Jll4vU4=
Received: from CH2PR05CA0010.namprd05.prod.outlook.com (2603:10b6:610::23) by
 IA1PR12MB7519.namprd12.prod.outlook.com (2603:10b6:208:418::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 08:47:18 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::a5) by CH2PR05CA0010.outlook.office365.com
 (2603:10b6:610::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 08:47:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 08:47:17 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 00:47:09 -0800
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 4/8] drm/amdgpu: skip writing eeprom when PMFW manages RAS data
Date: Tue, 4 Nov 2025 16:46:53 +0800
Message-ID: <20251104084657.1412130-4-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104084657.1412130-1-tao.zhou1@amd.com>
References: <20251104084657.1412130-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|IA1PR12MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: 7564c872-e1d7-4adc-044f-08de1b7ec2c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?F02QS5AHt7Y5MQ0+p5OjcCcLc4NL/CpkgA/WTg5JW/Jb0MpK5xHqhwnyjklp?=
 =?us-ascii?Q?qWZF873FXo9MTx7KgjGeWLzFqliUnFhm7iOAZSxby660EjbkjqDttuhwhLjk?=
 =?us-ascii?Q?7BJJfk+Ts7YhdJtfUHltHwqfZZDHwh3FB3jLMZsu0zhUqgfXSXuCkiul+ft6?=
 =?us-ascii?Q?UEEnPfL0UYu5lQCs47JiuBR3n79sjUH5jF/6WaJtG4wzlQeVoNYCAt1wKUHZ?=
 =?us-ascii?Q?tMM169Jqhd5WjJLBXXJF+0yiirP7kuTODOnGW/gXcJjBQiMV1EFG3us5Y/o3?=
 =?us-ascii?Q?ruQMEfEvdudO0pp79BYI65Xk+Whdq5yx6/yl6095kaISrG3mZnKIfYTVKb++?=
 =?us-ascii?Q?TJV5NuD3T6n3ffq3AIx2cgjOmwhaiSq+b114L/ZZJ/rDBCXuIHi340i/l5K9?=
 =?us-ascii?Q?IslHE5soo+jZl6AR1X84l/hi9mVFsel2Y3f16uBUFIP6d0F2zgOfxu+kLT53?=
 =?us-ascii?Q?W/5O5Vhp7PnLMp1b7SNSPK0MoDJv/tzOx+fhOybc9FXJOJMx9hqvlaMoU2Oo?=
 =?us-ascii?Q?HB9TbnCAwj0b4FFhUCGZwRxYu2BJOeirwcUq1MOeb47Pusq9VkK1hnAhIoak?=
 =?us-ascii?Q?7VA9NorsVWdtkGo3tV4Wjnys9cvrcun2fOGzKx9eJUylYEhYP/Dx1YcPSxFn?=
 =?us-ascii?Q?srkb/3birGaEGlgJvRUwQMpXa48WoEUyyHH4KRUfJN3p1mF+aDVPAumU3now?=
 =?us-ascii?Q?aFPhdFWJoJO6CNdAjv5Pl74JkEjrr0nuFtgr2/vYb7KiJaV5eToqxKsw6F91?=
 =?us-ascii?Q?98LJa88wO4TLjRHBKSz0Sb8SJbLnIpFiAuNYdRjDMQrfWswHSO0BoVRCop4M?=
 =?us-ascii?Q?//0O4tXrXlMEQb961I4OKCUAhvpQvH6HUCiE0oSrAEqhyjNGvE9UFy4/CkdZ?=
 =?us-ascii?Q?wNI2f7y/Ph5qeO6ia7ULV25Bm5Q9H1VrqUjwfs3oofwOcyiu2PBbwfPUOJVa?=
 =?us-ascii?Q?62orP/lG1NwK3n/lXuvLGX5bvzVW0MklxqppT9sntLEtCeaQ5z2b9eDtI5Mm?=
 =?us-ascii?Q?0n1DuLk5YbCKxNXiqxRpqbSwPGhs9NMDqCj6HQ82nXLRzlXNMGuHF8T0wvZj?=
 =?us-ascii?Q?kMAIFX9bCwc4J3yQTcomagwgF2Br+7LHhI4zNQP33wxZFIfU0foIz5iYFfkZ?=
 =?us-ascii?Q?tTm+fId01gPY1uQoTQoXB//t0PuT2/eaoDF6uY34pbX7/uajfUv3FBgEpFwT?=
 =?us-ascii?Q?5Hgs+TG/WDFcET9U48cbERQ5AbtUkidbkF93xJIfBNY7wQUUHZDmSON6KJHm?=
 =?us-ascii?Q?4VBAzteqaCCycohi8WE14KjjVYO7dct22KjV3iusMYzppn8c4x9v24SYJgml?=
 =?us-ascii?Q?OPnYRqNFESoSAaoD3eAD6vZWOmDi+cEMWNoGVwx9psctUwXY11u4iErxz1UU?=
 =?us-ascii?Q?llag2DANILYUHSJZOt19C/B4Pj5ugBwJeQEOHbaA7sUXg60sxmQvGEdyv5oV?=
 =?us-ascii?Q?dw+7O70jBLeAUNP09ZQoyfwlusSiHqs5tOHDRpxYg7ntB1p0hJYhMJzmvNQG?=
 =?us-ascii?Q?5mmMAOYR7KnRSkGQDnQSs2hDQGyKAS5lkhWZa0luQ3AtZ1EwH6WHAh28dqc+?=
 =?us-ascii?Q?+66OvBcvYcNx5mMkcEU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 08:47:17.9857 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7564c872-e1d7-4adc-044f-08de1b7ec2c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7519
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

Only update bad page number in legacy eeprom write path.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 18 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h |  3 +++
 2 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 47f292557a0c..4e6c1d55ce8a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -871,6 +871,18 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eeprom_control *control)
 	return res;
 }
 
+int amdgpu_ras_eeprom_update_record_num(struct amdgpu_ras_eeprom_control *control)
+{
+	struct amdgpu_device *adev = to_amdgpu_device(control);
+
+	if (!amdgpu_ras_smu_eeprom_supported(adev))
+		return 0;
+
+	control->ras_num_recs_old = control->ras_num_recs;
+	return amdgpu_ras_smu_get_badpage_count(adev,
+			&(control->ras_num_recs), 12);
+}
+
 /**
  * amdgpu_ras_eeprom_append -- append records to the EEPROM RAS table
  * @control: pointer to control structure
@@ -889,12 +901,18 @@ int amdgpu_ras_eeprom_append(struct amdgpu_ras_eeprom_control *control,
 			     const u32 num)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	int res, i;
 	uint64_t nps = AMDGPU_NPS1_PARTITION_MODE;
 
 	if (!__is_ras_eeprom_supported(adev))
 		return 0;
 
+	if (amdgpu_ras_smu_eeprom_supported(adev)) {
+		control->ras_num_bad_pages = con->bad_page_num;
+		return 0;
+	}
+
 	if (num == 0) {
 		dev_err(adev->dev, "will not append 0 records\n");
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index e881007f715b..2e5d63957e71 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -82,6 +82,7 @@ struct amdgpu_ras_eeprom_control {
 	/* Number of records in the table.
 	 */
 	u32 ras_num_recs;
+	u32 ras_num_recs_old;
 
 	/* the bad page number is ras_num_recs or
 	 * ras_num_recs * umc.retire_unit
@@ -190,6 +191,8 @@ int amdgpu_ras_eeprom_read_idx(struct amdgpu_ras_eeprom_control *control,
 			struct eeprom_table_record *record, u32 rec_idx,
 			const u32 num);
 
+int amdgpu_ras_eeprom_update_record_num(struct amdgpu_ras_eeprom_control *control);
+
 extern const struct file_operations amdgpu_ras_debugfs_eeprom_size_ops;
 extern const struct file_operations amdgpu_ras_debugfs_eeprom_table_ops;
 
-- 
2.34.1

