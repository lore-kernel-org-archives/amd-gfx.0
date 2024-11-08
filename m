Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD32BD5E15E
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2024 11:15:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FF3F10E970;
	Fri,  8 Nov 2024 11:15:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vOglWgQd";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EF3510E969
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2024 11:15:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AVb8zp/V+4WJ6h+nc2M0NatH9K2V+Lr8yguyHOg/ENdSwGqwRd1nynv+Rpo5vsP9iu3q1gP31/C8KgypH3+7SaSyMu7ZejmMiXArbWvy1rD8fOzAr+1pK2HK0QZk7aeFfC3zjGiuYuHxWCQ1Br0PidjpqwWy25+0Bw6ALpmJT8kydpXf+ObDq0DvBltJeX4WRrCG6LB4g3BWyeCVCg6sumTKjezgVYATGmoFpXc7wrLi9bsJjMGJzFzYJVeGgbgUKigYDe/tF3KYo4GFluUAftd9OpI1dQqDqlGRV4K1r/fjQLYIPW1FiFo0CdhiECT7i5jHTMbDGfjM6aOVmGgyAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Cztf4hcLEUPFP1IMqrCMrUFflpFWAHdWzZCFy1kbbM=;
 b=FQXAC3gRNVqDKUtF2uwtdura7OoBXQaY/MPhduv60k3ERgd7/d4GgVsoCdQ13v5SBeiDdbHbVUmo23wC/Ldd6K2t+adBWpfcgp6JSTnGpGfy0d19///UbcEYs0t2Gmg1ldf/NudkYMxqDSfF+aLRllkMzt92KnmO01MMGjVCS0FA2LVvZGIT3+3e5EMmslSn7ba5dIIF4haSvpFyy1u4WN0DOb1ONim3Y3s3M+Q8o6sDce/r9P6cCidzYNBAHwM3daH6pqYzMQYISYqceMAnW7XMMEt1HwBDL+SGVHObzhZlRpm211OQYqxaN6PreXATGE9nkTQnpWaB8ddOyZKe3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Cztf4hcLEUPFP1IMqrCMrUFflpFWAHdWzZCFy1kbbM=;
 b=vOglWgQdCHVva7tw9xFPCE4WernKWkTKalPOB0fs/L9zirVOpY/LZzNjd2ZSPktZxiL91RHYADRb74rHjlbfIsEmr1aoWK69hjFeAErhJaN5RYspGcTYBei2DMUik6jRWn3JGC9sniPY980sRW7EAU/93EZnGpyYkvcXdk6ZosE=
Received: from BN9PR03CA0252.namprd03.prod.outlook.com (2603:10b6:408:ff::17)
 by PH8PR12MB6817.namprd12.prod.outlook.com (2603:10b6:510:1c8::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Fri, 8 Nov
 2024 11:14:58 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:408:ff:cafe::ff) by BN9PR03CA0252.outlook.office365.com
 (2603:10b6:408:ff::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20 via Frontend
 Transport; Fri, 8 Nov 2024 11:14:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Fri, 8 Nov 2024 11:14:58 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 05:14:55 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 21/23] drm/amdgpu: parse legacy RAS bad page mixed with new
 data in various NPS modes
Date: Fri, 8 Nov 2024 19:14:21 +0800
Message-ID: <20241108111423.60169-21-tao.zhou1@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|PH8PR12MB6817:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c84f729-52ef-41f5-167d-08dcffe694c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WbOPF2P6ZOt6IUblnhZKUZQo9nn7HUFX27aeceG//Y1bwWOBNRzT4yKw5PSc?=
 =?us-ascii?Q?uThmsc6nObsEgbqoQaFOQwKpZzOxqwa/EKYC7ouqeSKQnH6A1m6bf+An46GI?=
 =?us-ascii?Q?VNxvmHR4A5ClVNpIoODePx/ItzH/02QWTXzqUBFhGXgI8t14iQmTdfuJxCzN?=
 =?us-ascii?Q?0jAuCPaAjvdSunewaWdNKgn+en8I4uTbqrXaW/DevE9IfJW4n33TIewvWNMH?=
 =?us-ascii?Q?z2ii5DDxTtyoHOV4iF39uX7Uyj7iXH5A6VDsKEpPKPCHrF/twgfcGe8UVPsi?=
 =?us-ascii?Q?o75FJXw21moii0oyre0Ikdq8GINwe1cSLB0KGKliQgKo3FA9TQSsKOPK4HaP?=
 =?us-ascii?Q?w9UCMUt+v3rRWCB80hd5ItT8gqC/YYnBJ++8LEWXRXncmTm+bdpKMUXLKG7J?=
 =?us-ascii?Q?pXajXXFRYaFnA4A9486GERHe6rwCq3+FYTKYBOE3ZHMHpnyiXb1TEO8J4I5B?=
 =?us-ascii?Q?owuYhYjGY5K4i7GcBpWAP6mzqsx/lMJgx/M3ENDcd3KFOVcJv6qm46OLfzn6?=
 =?us-ascii?Q?MNHMdy25xigRsUE16DqtrTxbzx9JbPBCrqlnPkE6lYS03I3lkSrCeQx+20Ax?=
 =?us-ascii?Q?ouviBKxSGsQov2kxgkL35pmSDJFMZl4QOHj4IFMONxfOmaWtSu1k0w1b95xG?=
 =?us-ascii?Q?Zss6Y/eJrJ4LaoIyxY29WAF4PPBi12416Da4Jb7aIhSfHs2HBH9H6uI3YZgZ?=
 =?us-ascii?Q?FpnkuegoZ15A/idd/yxZKIcKF8DkqA8Yvchn1DxXWXo8vHQQUf4dN05T5RbB?=
 =?us-ascii?Q?VgjcCRo7SlqrA1TfsL/1LiFSw4aoIH/R1TmjjsGZZsW4dL9yAVLyW3O0wu+B?=
 =?us-ascii?Q?dDXksAZpnwFRmvEePMJhBJZE8tE9HQqXdbfa88AVCicC1RXPQVBFpTPUrRJs?=
 =?us-ascii?Q?YguS6HiwEtQ63iNwPw6c+IVz5iL7QqDP7nSoBztT0mdZbkoCXjRauvE2mmGE?=
 =?us-ascii?Q?KIrSslx+sp3ePM8TVv0gJwfO0ke5Ay3xp7mfNepUY9G8J1p7q/I82F1EFsql?=
 =?us-ascii?Q?xfghbT0tEc41h6LX1MbDa2RXWmPr/DnArp9NBOKxlWU5IqzE7wxO7qhCRHrO?=
 =?us-ascii?Q?P8knbdxBcgPwUdeWlOxHYM2io0aIP0Bb17q/GvlQTQwTG6zrNX6OX4APNs66?=
 =?us-ascii?Q?TiL21aovslEx7toIbco1ajsh7zrgOkD9h6tHq1VUvfQ4IDDpaOkw1rjIy0xM?=
 =?us-ascii?Q?hzFZnPnAmKQqG0H+ADRSzpgHn7AQh2//sj1PwSxBGVVTrcbHU32KC++JvMP2?=
 =?us-ascii?Q?Y63dJYQZnLnfvAgr3tWOnx3HbJODhh8Lj0+G9tKe/DNnvQeD1RdLtZ0CVYIH?=
 =?us-ascii?Q?vbdu6hXwWq22up0q1yBflLhDsg318Lxn+tYYfT+RVSjmjtNSyHiY3V99bwFr?=
 =?us-ascii?Q?IH6KLH/8Fcc5nyUKMF5Y0VDo/AKox0gZQpST9TEw9cnqzvwG1g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 11:14:58.2910 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c84f729-52ef-41f5-167d-08dcffe694c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6817
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

All legacy RAS bad pages are generated in NPS1 mode, but new bad page can be
generated in any NPS mode, so we can't use retired_page sotred on eeprom
directly in non-nps1 mode even for legacy data. We need to take different
actions for different data, new data can be identified from old data by
UMC_CHANNEL_IDX_V2 flag.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 45 +++++++++++++++++++------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index bc4a5db2793a..324c71d99175 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2758,12 +2758,7 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 			is_mca_add = false;
 	}
 
-	mutex_lock(&con->recovery_lock);
-	data = con->eh_data;
-	if (!data)
-		goto out;
-
-	if (is_mca_add) {
+	if (from_rom) {
 		err_data.err_addr =
 			kcalloc(adev->umc.retire_unit,
 				sizeof(struct eeprom_table_record), GFP_KERNEL);
@@ -2774,11 +2769,17 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 			goto out;
 		}
 
+		err_rec = err_data.err_addr;
 		loop_cnt = adev->umc.retire_unit;
 		if (adev->gmc.gmc_funcs->query_mem_partition_mode)
 			nps = adev->gmc.gmc_funcs->query_mem_partition_mode(adev);
 	}
 
+	mutex_lock(&con->recovery_lock);
+	data = con->eh_data;
+	if (!data)
+		goto free;
+
 	for (i = 0; i < pages; i++) {
 		if (is_mca_add) {
 			if (!find_pages_per_pa) {
@@ -2800,10 +2801,34 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 						bps[i].retired_page << AMDGPU_GPU_PAGE_SHIFT))
 					goto free;
 			}
-
-			err_rec = err_data.err_addr;
 		} else {
-			err_rec = &bps[i];
+			if (from_rom && !find_pages_per_pa) {
+				if (bps[i].retired_page & UMC_CHANNEL_IDX_V2) {
+					/* bad page in any NPS mode in eeprom */
+					if (amdgpu_ras_mca2pa_by_idx(adev, &bps[i], &err_data))
+						goto free;
+				} else {
+					/* legacy bad page in eeprom, generated only in NPS1 mode */
+					if (amdgpu_ras_mca2pa(adev, &bps[i], &err_data)) {
+						/* old RAS TA or ASICs which don't support to convert addrss
+						 * via mca address
+						 */
+						if (!i && nps == AMDGPU_NPS1_PARTITION_MODE) {
+							find_pages_per_pa = true;
+							err_rec = &bps[i];
+							loop_cnt = 1;
+						} else {
+							/* non-nps1 mode, old RAS TA can't support it */
+							goto free;
+						}
+					}
+				}
+
+				if (!find_pages_per_pa)
+					i += (adev->umc.retire_unit - 1);
+			} else {
+				err_rec = &bps[i];
+			}
 		}
 
 		for (j = 0; j < loop_cnt; j++) {
@@ -2827,7 +2852,7 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 	}
 
 free:
-	if (is_mca_add)
+	if (from_rom)
 		kfree(err_data.err_addr);
 out:
 	mutex_unlock(&con->recovery_lock);
-- 
2.34.1

