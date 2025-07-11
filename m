Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D026C83F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 08:00:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9FDA10E9C4;
	Fri, 11 Jul 2025 08:00:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tuZaOKRC";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2046.outbound.protection.outlook.com [40.107.96.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FD3010E9C3
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 08:00:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RIxb8A0zk5811cnUxlgWWwt9zd+USWh+bX2ojXfPJfuqonYxZZj+S+68ys8g8Lhi8U1WSI5bOmx9rvyk7gZ9Mb8KjsVd9KdIJ0pQXfbSmzXgPhyjNQUOCIL9rUSkTtOGH3gubXVVjV6iZbopaTZnafi3hV5Xi1MJTYFttf/e71Wrq3XcEbJjN4SyYmAB76OKJrxeEZx8jp01FW2tIds6hz1qGg3qB0ktnzoSskExTMdRgIqUROlGxK3o6HNilO0H7nJrhkRfjOkMO1JJUIcA6N6bWISXG+C4Y5QxIlPDrRKFwJOynGswbVt/0na+CGY29aOHhr+zXuyXAN1WXjkfDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nWp4Wr/2f5wRyGBiWW1W9CXI4gsU3JptmKGY8+DBlU=;
 b=FJ6gcyzQ8vipBa1AZyqPjYU2ev1u+24PZ4DUqTMq9wE335123rwtxXBIz+oIIi461lgthhn8Q8TvA/pXT2FoqjwxLHy8zfwIuyayQu60V8/FzJNN0iHb3x7kYLq3OVIVJTWrMXLzrWPjp0Ij45/QyuRzgsKwgNwOwNH6FAtmXRpPKhMXhIS3+tHEwGj3H86T2kC+XvqPeurskwWiJsf7EWrgRrn+aWCHyQVEQeSL8NIzUakuCTlcu9EMlEmRS/hY3YBdLGnM530W4dmF37k7LuprfQSuLztl0VVo5mNfgLhk9QmB6BNEIKnJyFMDfWLMCfQv+aDN+Cpgi63p9Gp3Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nWp4Wr/2f5wRyGBiWW1W9CXI4gsU3JptmKGY8+DBlU=;
 b=tuZaOKRCrTKSMxi5gfSBl7g8CYUHuy1b6Pil6KROqqVWfWpQ42pHKTqs8W7H+IcewtGsLo+RVk/+P3qj0f7pblfbGl4FMk0tKia3dN6mCSLVWjhsGjzcx3HVJpxEm/lIIZxbFquOxT89anz/fvSvFu1D6xE6u1myPhUTeCRnTsQ=
Received: from SJ0PR03CA0182.namprd03.prod.outlook.com (2603:10b6:a03:2ef::7)
 by IA1PR12MB6385.namprd12.prod.outlook.com (2603:10b6:208:38b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 08:00:20 +0000
Received: from SJ1PEPF000023CD.namprd02.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::f9) by SJ0PR03CA0182.outlook.office365.com
 (2603:10b6:a03:2ef::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.23 via Frontend Transport; Fri,
 11 Jul 2025 08:00:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023CD.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 08:00:18 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Jul 2025 03:00:12 -0500
From: ganglxie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, ganglxie <ganglxie@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: refine eeprom data check
Date: Fri, 11 Jul 2025 15:59:57 +0800
Message-ID: <20250711075958.27835-1-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CD:EE_|IA1PR12MB6385:EE_
X-MS-Office365-Filtering-Correlation-Id: ef256222-f66d-4c4b-d26f-08ddc050faab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MyEUUfTRoHq0hx5vHwny12mB73nu+qt0E+0CQxgV+oxv8Pv3hYsUIg64pKwY?=
 =?us-ascii?Q?YiqhKmeXUGgeiAtKKbv6pqbSKLqkiXla1d4jEBcQgepxdHxqFhQMJppg5aTG?=
 =?us-ascii?Q?0/25/EUM/28lIyDVMqCBL11vNzufbN38TZGCcdAbc3ANQDzDRgrgf3tzMXHR?=
 =?us-ascii?Q?YmoIpbYaBTnye0F4GfjMHcU8BSl0SPrx+8ypqcj3QV4WpJ3VYw5NckSKzzpK?=
 =?us-ascii?Q?ZkZK2IOdm0Ze0ZS2CvbYf44G2w3oWavZ9ROjckkHSN5SJuuaNyGjYVr3SGry?=
 =?us-ascii?Q?h4GXNsgAZMa+q8pgzrOMygchJiwkm1f4hByn45ynRVboFY9UtBrqz6jSOYrJ?=
 =?us-ascii?Q?OKOFMrPyJw5N/g8YaJtXVs0APPU495ne/E/NMI++b2jvgtJamA3ox5p9aOj8?=
 =?us-ascii?Q?m+qg+8A7cg3YbkcZ3plT6JUiMoqHkvuIp3fNlHvR0OvMv0Zg7sKT4Rwt8e4M?=
 =?us-ascii?Q?3SBC07vfK4QncphoRO0Fnhx5eCUPSCd1fMchq0E1MbRE0CHjQdP+o00dsXvL?=
 =?us-ascii?Q?UPGYRUJrr2adVvmflH+KhzCHboNgVkFi5dTxjgxX6od0mHG5FYI4tEAwylSw?=
 =?us-ascii?Q?un0aHXJ28TapIcs9uw0WO2EbqrT1mB+Z1ZpdbpIP1l37jMYYEsJYvwCdjYOX?=
 =?us-ascii?Q?H48pahbwNJL0ZXeVpahpea29QVsBhs8GNj+o6Aqic3Svz2dhaKjYHGcD/Rof?=
 =?us-ascii?Q?Wsn1fuVPlq8B73lm5QoPVg3kJe7G2dbYXQQqhTz5mgyvrPagMBAqtIhv1quP?=
 =?us-ascii?Q?z0GbEWyKmFq2XAzyb9PoCs76RU3gJ/QLywfiGIublbNXHhx2at4mAaixIO1t?=
 =?us-ascii?Q?zcoz4rstzRM+BxkwFFJlfc+bStCqS9EHT8AVwM7DvaFyqqsjO5YPnR+JZ6KS?=
 =?us-ascii?Q?94ejQGNTTIpcwxsjVlzR3jkUy1dtbnrLzuzsA8kHL3xqiBS1Bc0prq0n5PmZ?=
 =?us-ascii?Q?Rj6gbf8L2kzpZVoiCgYJyd+aAt5Ln8sSjWtqnCTaTI+wfcns1i6XymOv6PFw?=
 =?us-ascii?Q?4Jt9SYthf77V1rg/J/X90c1qASHlX/gKEsf4bUXm/g+1CosPFYvEWJsYOizo?=
 =?us-ascii?Q?nH5FfBlz0AQgGgXO9Tn/cY8cHlkFsMsjRleKkzHOK0g3nw8SE7gsJAKIJx3f?=
 =?us-ascii?Q?30Jb8LtwSxTqJ0Dks5scT9HFtRNj3zxUG+CHlPU9+WMq60N0l2JniqxUGvJZ?=
 =?us-ascii?Q?+ei+mfUBuos633L8JQmz3RSuUCuTWx2Epi2XRwfwc78krCfrwtfmfeVv5yr4?=
 =?us-ascii?Q?fjp1qjJY2FofViGOoBCJN0IbAlEAYqmIZt1lpx+mmK9AyNIc+ZesiM8W9VLR?=
 =?us-ascii?Q?sZUymHQv2FV3d4r1ksuzGIEeddt9iCLvNFCfbr6P1BZR6U1NUXya1DntAyAj?=
 =?us-ascii?Q?D94S4B2xC7+pDcCtzna9eCfGS+nWF0iKahSoac00ZCmzp5JFrsxyb1gKKCcD?=
 =?us-ascii?Q?q5q973wNbUI0xGVqVsgTxADeALcwXOerMlq8H5OeeNuKY5NEA4w5ThEwujGD?=
 =?us-ascii?Q?LP7H1RhE0yLoY3pEEkv8XlIYOF6KVIGuQ/Fq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 08:00:18.9719 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef256222-f66d-4c4b-d26f-08ddc050faab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6385
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

add eeprom data checksum check before driver unload. reset eeprom
and save correct data to eeprom when check failed

Signed-off-by: ganglxie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  1 +
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 28 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  2 ++
 3 files changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 571b70da4562..1009b60f6ae4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2560,6 +2560,7 @@ amdgpu_pci_remove(struct pci_dev *pdev)
 	struct drm_device *dev = pci_get_drvdata(pdev);
 	struct amdgpu_device *adev = drm_to_adev(dev);
 
+	amdgpu_ras_eeprom_check_and_recover(adev);
 	amdgpu_xcp_dev_unplug(adev);
 	amdgpu_gmc_prepare_nps_mode_change(adev);
 	drm_dev_unplug(dev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 2af14c369bb9..df0e9b87d578 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1522,3 +1522,31 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
 
 	return res < 0 ? res : 0;
 }
+
+void amdgpu_ras_eeprom_check_and_recover(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+	struct amdgpu_ras_eeprom_control *control;
+	int res = 0;
+
+	if (!ras)
+		return;
+	control = &ras->eeprom_control;
+	if (!control->is_eeprom_valid)
+		return;
+	res = __verify_ras_table_checksum(control);
+	if (res) {
+		dev_warn(adev->dev,
+			"RAS table incorrect checksum or error:%d, try to recover\n",
+			res);
+		if (!amdgpu_ras_eeprom_reset_table(control))
+			if (!amdgpu_ras_save_bad_pages(adev, NULL))
+				if (!__verify_ras_table_checksum(control)) {
+					dev_info(adev->dev, "RAS table recovery succeed\n");
+					return;
+				}
+		dev_err(adev->dev, "RAS table recovery failed\n");
+		control->is_eeprom_valid = false;
+	}
+	return;
+}
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index 35c69ac3dbeb..ebfca4cb5688 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -161,6 +161,8 @@ void amdgpu_ras_debugfs_set_ret_size(struct amdgpu_ras_eeprom_control *control);
 
 int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control);
 
+void amdgpu_ras_eeprom_check_and_recover(struct amdgpu_device *adev);
+
 extern const struct file_operations amdgpu_ras_debugfs_eeprom_size_ops;
 extern const struct file_operations amdgpu_ras_debugfs_eeprom_table_ops;
 
-- 
2.34.1

