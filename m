Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D84CCF9E3
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 08:47:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C77E210E574;
	Tue,  4 Nov 2025 08:47:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e8Q6RJ7E";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012044.outbound.protection.outlook.com [40.107.209.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AFD310E55D
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 08:47:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TOR8NHH4x1BtIR/kPZDGF7zI8TWtBMmE3G4x4hiCw5/rw2BLL+nbxLo1pCFPV7N8coAAeGwTteVneDBiBOHovsQLA2MItUoYNHArIIntw/A5hbOkzMDqmzJknKpjEBgYrMXyJUewMRsgGaHzsDxWdyDW3XwLyzrzkhMmCsf0x07Ru6LJo5WmSdlCH3EmDVkbeaHZdEmKEi/i57fL7znsd51W05qR1J1DHkubpbjX4D5I6sb5fcX3TftQSc5UIOBMFAnkfQ2I5gSWS/tH5xeseRTNlNfGqtpAnOcatOKznv9+0pzusN25gEbr4+/URgKlk80agKzO/f0hNoXfKgbQqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=viPA1KQEtVVi0vL7NjZJq/29tPm1ZDB3HG3TiBQ1qcI=;
 b=fyksmMEKRav+QCWk1mOyJAu+BMRoh72k34R3jNh8dW7BKKFHt4b6FV5mZwSGXOxL1NuBBYAvDNkwsp+nyygpoYMIT+aQFFbcnyx/rRde9sS5rbtUpCwFVT2k09P/AkDbVsSknZ3SDvt++f3A9UE8+nDD4nfaFiSmugYEVi12bCswUwPby8LN1m0rrY1Mq2ZfA1zGIU8ZpwmYCVvav/aePAVf8qCOvMXa4c7iPg09p5Olw0EYZK07l3v8sUbNWjFGGNBPGxzJkrhwMpJgT7nsHEYjjl5ejrElgzCWzhQKcD/owMHXsQT2kgg8Hwz4WDMuRL8BSwdIBvPAqrrZkin6Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=viPA1KQEtVVi0vL7NjZJq/29tPm1ZDB3HG3TiBQ1qcI=;
 b=e8Q6RJ7Efxww96wSWUIknx2gQQatC2A0F06RqztOrJKqSqxoncd8kiq5cZC7VzxGBQNACpPoKGfj2cYFlNNNRmXHtqf+XuvSttFZrHL4h0dny6xVSGycvTYKVGZz6gequhcGamBTVMYfOFPcSdO3c7q2zP/Z4URaKX/nH6mVNa4=
Received: from CH0PR13CA0039.namprd13.prod.outlook.com (2603:10b6:610:b2::14)
 by MN6PR12MB8544.namprd12.prod.outlook.com (2603:10b6:208:47f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 08:47:16 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::cd) by CH0PR13CA0039.outlook.office365.com
 (2603:10b6:610:b2::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 08:47:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 08:47:16 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 00:47:07 -0800
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 2/8] drm/amdgpu: add ras_eeprom_read_idx interface
Date: Tue, 4 Nov 2025 16:46:51 +0800
Message-ID: <20251104084657.1412130-2-tao.zhou1@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|MN6PR12MB8544:EE_
X-MS-Office365-Filtering-Correlation-Id: dd49326b-aa99-4799-2aad-08de1b7ec202
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TRXemV+0hN3oLnB0aFOCsSEBON9A9AA0Y7oExmpjyNJ0OD1i/fOgKjW7PkTw?=
 =?us-ascii?Q?AmXhZsS5/XTbR7i8YBkHVXSI4TxYmYR1wrEDQIU26KPvAzKTRXoC/9HCBEVG?=
 =?us-ascii?Q?/o9DI3xztvYC4mm1RUAQnQjIzb2wOptfQXsS42jJ6OaMkxtNXhYmvLwBWy9k?=
 =?us-ascii?Q?ZQbVgQLSYe5SZhtdwUVdFPGojX4vv0n3HbW/OgALcMXYZ6YmxZjru3Zgueqy?=
 =?us-ascii?Q?ufoWUjEqsWgBT1aqqxYlrLevyYOZ+kCql96itD7BwjnMv9WDNjhigE+yf3w6?=
 =?us-ascii?Q?Zyfl0kJBhbXvj80/oXm62USckx91GGdzIMNJFjuP6utHXWwGVXwNTj1zreQQ?=
 =?us-ascii?Q?m0cN+H01X8HOvKMgfniY53wgTFCSVVwvBsLGwJzO5ysULpWUvcgAoXH5/0YV?=
 =?us-ascii?Q?E9Xs7ZkBUhbs2qCT3YjFE00HPBlArSuatwh0PZTKKCAHldf9UNldoyL6wEyk?=
 =?us-ascii?Q?YK2MFx/2CcdpO6rlJz841MWzNhXFU1M1+WCdJJ/ivToBBVykwIttteYphQK8?=
 =?us-ascii?Q?NaULzL8Ns/fz0G2M4O26WXutpFjygTrWxkwVDw0+T6SXUmFV0xfsAhb3JDEj?=
 =?us-ascii?Q?DX6Bcd4Pn8QpbDroMrg1fqgkMTIdc0OPYsIeBQHC1XJm6ssrw+LsR4dO6+mX?=
 =?us-ascii?Q?QpoL8SOdUAhttivW9UsKHlUoLx7i9paKosRMFXOt6/Flq0PZLszylMZozOcW?=
 =?us-ascii?Q?IIhvr1MOCc8mhXjAdT5VWMTJExa4Sy272WWAh4zAqjHOeRqWtT/A5XKC0tK3?=
 =?us-ascii?Q?ajjcuwDlkbi+NTqZBCJ6hT+PxzjKnOri0924y8DnHuRtOaKMh9C8JmZcfLLE?=
 =?us-ascii?Q?Ux64ljjUlLSIRVAatxzrksHU5qQGyRqx3gCQEbpKOvo5qjveZVz7cgnXD41L?=
 =?us-ascii?Q?CR99y+XQruidLMP+D4BQwrxub+zkehtfYGKYRuZbmGZYy3pRfIb1/M9BRLFR?=
 =?us-ascii?Q?V8uAThQ4E6TcH4wlFsQOev63M1eazRX68hxNwPIx38ovIx3ciDMYgmcLDkUO?=
 =?us-ascii?Q?uvk8Q2emgfe26WuUEwWsu53Mbt29+OY2D9dqsKv+azO0j9f74Pw+NHlNwWBM?=
 =?us-ascii?Q?xhMuTgXSgby7q4INrhDT+JiZyAECoBs9TLDVeis9d0O6Eynd1035Tuz/XLxc?=
 =?us-ascii?Q?Wg925GiTp/3mxwT4+iQFYG8nECj2uXqzufRCGSDEbxW+HYiyY+xCITJPYuFS?=
 =?us-ascii?Q?NV/mB+AznahKsEwqcNz787EhqafhrHVQpiEzRh7DUm4tiE+5WLP9eB40q+Sb?=
 =?us-ascii?Q?4LUe6DWY35HUPInvoP/vKbO4qu6vHIP+0c6JU0IFyAyVPqgHCwJ2rqKAbg94?=
 =?us-ascii?Q?fR+YyYf+pgXNzXqY8Ow9o+tCFKIkmJT/szPbc5GGHrqfye+4dseiwkSAlX0H?=
 =?us-ascii?Q?/GrkI/Iy64ABW67AEJA6gZ7Y+MVdnzcXUGpfOUkVpMSNpexBPl2Y0tF1Avmu?=
 =?us-ascii?Q?BGR1SRezFAbMUkwcmH81P9yxYRrgoKXY5jXYCLoH8FLp/sZ6XbU6m2KLVoN2?=
 =?us-ascii?Q?aU3krPWMr2JvmtrNjl26RKIVUI2nuQSj3BOiT72OZI8h9xMq6PT++OLE4UTG?=
 =?us-ascii?Q?nHcr0qmWEkJsE/dPUQs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 08:47:16.7388 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd49326b-aa99-4799-2aad-08de1b7ec202
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8544
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

PMFW will manage RAS eeprom data by itself, add new interface to read
eeprom data via PMFW, we can read part of records by setting index.

v2: use IPID parse interface.
    pa is not used and set it to a fixed value.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 51 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  4 ++
 2 files changed, 55 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index d7e2a81bc274..47f292557a0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -970,6 +970,50 @@ static int __amdgpu_ras_eeprom_read(struct amdgpu_ras_eeprom_control *control,
 	return res;
 }
 
+int amdgpu_ras_eeprom_read_idx(struct amdgpu_ras_eeprom_control *control,
+			struct eeprom_table_record *record, u32 rec_idx,
+			const u32 num)
+{
+	struct amdgpu_device *adev = to_amdgpu_device(control);
+	uint64_t ts, end_idx;
+	int i, ret;
+	u64 mca, ipid;
+
+	if (!amdgpu_ras_smu_eeprom_supported(adev))
+		return 0;
+
+	end_idx = rec_idx + num;
+	for (i = rec_idx; i < end_idx; i++) {
+		ret = amdgpu_ras_smu_get_badpage_mca_addr(adev, i, &mca);
+		if (ret)
+			return ret;
+
+		ret = amdgpu_ras_smu_get_badpage_ipid(adev, i, &ipid);
+		if (ret)
+			return ret;
+
+		ret = amdgpu_ras_smu_get_timestamp(adev, i, &ts);
+		if (ret)
+			return ret;
+
+		record[i - rec_idx].address = mca;
+		/* retired_page (pa) is unused now */
+		record[i - rec_idx].retired_page = 0x1ULL;
+		record[i - rec_idx].ts = ts;
+		record[i - rec_idx].err_type = AMDGPU_RAS_EEPROM_ERR_NON_RECOVERABLE;
+		record[i - rec_idx].cu = 0;
+
+		if (adev->umc.ras->mca_ipid_parse)
+			adev->umc.ras->mca_ipid_parse(adev, ipid, NULL,
+				(uint32_t *)&(record[i - rec_idx].mem_channel),
+				(uint32_t *)&(record[i - rec_idx].mcumc_id), NULL);
+		else
+			return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
 /**
  * amdgpu_ras_eeprom_read -- read EEPROM
  * @control: pointer to control structure
@@ -991,6 +1035,9 @@ int amdgpu_ras_eeprom_read(struct amdgpu_ras_eeprom_control *control,
 	u8 *buf, *pp;
 	u32 g0, g1;
 
+	if (amdgpu_ras_smu_eeprom_supported(adev))
+		return amdgpu_ras_eeprom_read_idx(control, record, 0, num);
+
 	if (!__is_ras_eeprom_supported(adev))
 		return 0;
 
@@ -1162,6 +1209,10 @@ static ssize_t amdgpu_ras_debugfs_table_read(struct file *f, char __user *buf,
 	int res = -EFAULT;
 	size_t data_len;
 
+	/* pmfw manages eeprom data by itself */
+	if (amdgpu_ras_smu_eeprom_supported(adev))
+		return 0;
+
 	mutex_lock(&control->ras_tbl_mutex);
 
 	/* We want *pos - data_len > 0, which means there's
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index cfbd402ddea2..e881007f715b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -186,6 +186,10 @@ int amdgpu_ras_smu_get_badpage_ipid(struct amdgpu_device *adev,
 int amdgpu_ras_smu_erase_ras_table(struct amdgpu_device *adev,
 									uint32_t *result);
 
+int amdgpu_ras_eeprom_read_idx(struct amdgpu_ras_eeprom_control *control,
+			struct eeprom_table_record *record, u32 rec_idx,
+			const u32 num);
+
 extern const struct file_operations amdgpu_ras_debugfs_eeprom_size_ops;
 extern const struct file_operations amdgpu_ras_debugfs_eeprom_table_ops;
 
-- 
2.34.1

