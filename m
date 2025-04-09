Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41233C36002
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Apr 2025 13:40:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF6F210E1AF;
	Wed,  9 Apr 2025 13:40:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ApdI4M9A";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2040.outbound.protection.outlook.com [40.107.96.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E499810E1AF
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Apr 2025 13:40:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oFiqzvB9Dc6if9ZU08zqEsxXZWQDIuAu2zIgwdX8ufDGHorlvLbI9fvcb0ot7fvu8GAMbPNm4BjCLgNZ8K+txzBY5c3fNO7GrbdhFJgoVD2pE79Uu0ZXPY0gKDYmiJeaqLCpg9rOcpvhSRlJxiX0vvKsvJ7mBDqVifpdZwdnz5wdhtAjS+Esdhr+7PQkIN+GRFPM+ozpCrvftE4CsBBlk9s15a+G+nZq78UmqpyJhLj9Spzc6Z8TEo4vcIXXmNd5tVYytlLkPlb82p5fCL9VDA5tQeVmrwZ9LQBsj59+Y8nHu4wjvMK4RymUqjmeC0L8jlOwnzkHk/y+Q/RRjDOoPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBNQohn4eag+lnZ139grbO9stII4uSLjUygIuGH4f+4=;
 b=dDDWx3qnU8kRTgrG32lWj6/gKiYm7UhISHNhMvNXBOiHScF36JeOLT+3r/CImMELXnD8wUa+EqFI1BSnoL5EWjeahzIhEUlVV2G7XgZHXV4DBIfQX2ojul+7f3M5kDTqQrr7071WTvKWDqWkeIojdoCbgMMW0bPVKr+qH1PioQ8+fvFVlwIEoXtMrlQGZgbX6eBxzD6mWvfMWrlvk/O3uZ1z74KH4JnSQVGTN7jTpq9xvCUcd6L5ytAv65EvU+MZoP4xbwy38CFfIcPwQDAMWW/RALTIbkuNfRB35GGfEY9jYIBZvcyAbAIiha+1NnqycgFMjG8eBzoTMGk1+6Jy0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBNQohn4eag+lnZ139grbO9stII4uSLjUygIuGH4f+4=;
 b=ApdI4M9AHgH5maw7+gWuS8tUSdCRyJV2Fyz58JAQ3/nbg7ZWGR38pgjhM26vpdB9dYWhSsE1QfY6CpjhungviBfQib253Y0TyY2VZym2GwkhNWE9obGa8txuzJIRBbNpCquZT8/TJLCWUiLgx0A1FunzAeO0NCnOV6fdDpF2LuQ=
Received: from BN0PR02CA0034.namprd02.prod.outlook.com (2603:10b6:408:e5::9)
 by BY5PR12MB4098.namprd12.prod.outlook.com (2603:10b6:a03:205::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Wed, 9 Apr
 2025 13:40:08 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:408:e5:cafe::57) by BN0PR02CA0034.outlook.office365.com
 (2603:10b6:408:e5::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.23 via Frontend Transport; Wed,
 9 Apr 2025 13:40:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Wed, 9 Apr 2025 13:40:07 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Apr
 2025 08:40:05 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <dan.carpenter@linaro.org>, Ce Sun <cesun102@amd.com>
Subject: [PATCH] drm/amdgpu: Replace tmp_adev with hive in
 amdgpu_pci_slot_reset
Date: Wed, 9 Apr 2025 21:39:55 +0800
Message-ID: <20250409133955.26169-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|BY5PR12MB4098:EE_
X-MS-Office365-Filtering-Correlation-Id: 6edd72c4-191b-4006-0d85-08dd776c0ac7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xyJEgjogm3YD4K+eAyfOMDHM3CsaAW/BYClrfjNUsXX5wlzw5iFTdwWU7v71?=
 =?us-ascii?Q?J5jVaIQymh5d5A9b3Z3YHkozKfJTHhDApsYt/bgbcmtJ3e+Nk9/UwuffSJe/?=
 =?us-ascii?Q?VvV0iIQ/q8K0Xjw0TND5AiDUXYxRNMT5LVbXESfyw1NWe1O+5yhcs0Q43b+L?=
 =?us-ascii?Q?0DzXCzUbY8y7of45jiFzDAEzS1ncrG3lGkA8ikOwjYgWfnEG+d0zFoPhiC8F?=
 =?us-ascii?Q?1bA/uhbGfobbQMvXqvcZgKiOUxftk8APNDStKyYFFOYAMi0JmjrPBqeeZPO/?=
 =?us-ascii?Q?2CWwZ6ynJGMZeUcADCZ/mtntyvYFHEzYhtP4SkYEArpOJSoKFunrTfniUwlt?=
 =?us-ascii?Q?A+XHBQhe3SsYGS+lLK4OnEiWYf6Z4mPS5V7JUuSGb/fD4XtZP5mCMylff/pX?=
 =?us-ascii?Q?EjpMLz6dYfq1iwMNwYFaLiUnHIz/SAw67Zp4af9FeduxoksKV3LDHg5Ypaqn?=
 =?us-ascii?Q?zRnZNgCkn4NFDqS9IvQ86+VsfyC6YSqp0SbhFvVNRGk2zdrEa5I4auy6xITL?=
 =?us-ascii?Q?DS/TvDkuqZiGYpxj+FKLKJSNLnwVcVbUBaV/woQrOwVlC1nAPbXB2/0JJmRh?=
 =?us-ascii?Q?udgcdMcDaJ0k3C9Ccs3KUTxBTkVybuw8IOhN5WAwJNh6iXMXN4mAW0xXm+fT?=
 =?us-ascii?Q?NPtVSn0afsB4XRruNyMYd7Nt/7/qloAE68m1BKCEf6ZmtydTC/oLUb071D/G?=
 =?us-ascii?Q?LplS5QoVhMue560J2ZggJqKhJ5PbrWCNEr4Q8H7f5MkqQudK/pkz7HwWEFGp?=
 =?us-ascii?Q?zWH0hZoMsk6WloM+ZZMGNfzt4ZLZC4o2px294P7d44y3zsztAxZ7PhCiQ8fs?=
 =?us-ascii?Q?XRL/D8MQctA7chCR4G2lb6HKqGwnVXNqm0kXqzXK3tNQDfDXzHv4KiS8jK6k?=
 =?us-ascii?Q?BBAoZYhOlhaMHNsVHfjXvhu8J1B6J8bdm9Us6t79IYKLQA5h15KN5gyyhtE3?=
 =?us-ascii?Q?4YJzo3MUnvcDgCZtyaolBDsCIAXAmBPkKhZ87lwcGxOuooL8ZH06kslOp1j4?=
 =?us-ascii?Q?zMZ8SlJD1eXGM4IvXWiYAd9Zz/VmEeI7Kc2k+slJy/GSWCK0n+1973KEbT1D?=
 =?us-ascii?Q?00dzoH0yfvq020XhTGOP0en1363xf7XlcH+UNSSJNhkCRH1q3GvjOuTeV1Ry?=
 =?us-ascii?Q?wmjzX8BRCehr+m+BKOLJdMpghjN9IDCo7Cyk92S9a+/UJhLmsMZYD8D/y9NR?=
 =?us-ascii?Q?eLkJD8fCztI3S4AaWOhAB7yhXjVUmGV4+j0DYUjU35rJWwkco2V4aEkYe+1/?=
 =?us-ascii?Q?e5dZ/9k9KGVuwJ4GOi7srOQ6e4q+n9uiKK23IgAkm5bgyfj5n8984TjW7o3q?=
 =?us-ascii?Q?UXjz5J4RRptXP5v4edPyExPl9KTl+rJNnX4wlsXFjEwaCs0ozntVQQRJjCvR?=
 =?us-ascii?Q?CW0ueOmulQCicVv6U3pbyfviapbFkEzR/YBimTGRprBYoq4Gt17OyCuSTVPO?=
 =?us-ascii?Q?e7hVPZfaU8GkjuDydTWBcw9rN9NZgHJjOxnTKiFUIHXIO9NC3s9wTPb87LUZ?=
 =?us-ascii?Q?HIJAmZ08gW5i5Uy3JHaok0htw0mgD6EKoEaS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 13:40:07.7157 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6edd72c4-191b-4006-0d85-08dd776c0ac7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4098
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

Checking hive is more readable.

The following smatch warning:
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:6820 amdgpu_pci_slot_reset()
warn: iterator used outside loop: 'tmp_adev'

Fixes: 8ba904f54148 ("drm/amdgpu: Multi-GPU DPC recovery support")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 60269fba5745..6fb234832ff3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6784,8 +6784,8 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 	struct drm_device *dev = pci_get_drvdata(pdev);
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct amdgpu_reset_context reset_context;
-	struct amdgpu_device *tmp_adev = NULL;
-	struct amdgpu_hive_info *hive = NULL;
+	struct amdgpu_device *tmp_adev;
+	struct amdgpu_hive_info *hive;
 	struct list_head device_list;
 	int r = 0, i;
 	u32 memsize;
@@ -6846,7 +6846,7 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 		dev_info(adev->dev, "PCIe error recovery succeeded\n");
 	} else {
 		dev_err(adev->dev, "PCIe error recovery failed, err:%d\n", r);
-		if (tmp_adev) {
+		if (hive) {
 			list_for_each_entry(tmp_adev, &device_list, reset_list)
 				amdgpu_device_unset_mp1_state(tmp_adev);
 			amdgpu_device_unlock_reset_domain(adev->reset_domain);
-- 
2.34.1

