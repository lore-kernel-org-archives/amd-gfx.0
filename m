Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F850C71136
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 09:39:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB90C10E30D;
	Mon, 16 Jun 2025 09:39:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EOuxidQw";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EB5C10E30D
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 09:39:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IfuxCRsT5SxilXyo/K0Aj3FIYnhstfSKUUHYO/ZbzlpLrUXW0P548Dtdmg8i2Jo1o8wqNfssDmIoDu2uujbGpMAVPCCrVNP7j93T7NYRAgYhHb1Cux6Fkbi1zRjl1YAxaLaCR3AD//eKlzhVaZ0NSYViEFlhF7ANvbDjMUznnBlnBvPplxyigO7lETxjWbeH8ojBMGA6Wd1ENMC40NtgcPhmW/bHgEhaBdccyEodps5ypIH7l5u5ydZCcWDRAVms5Ut30Zm8OsXApPA/lNDQMWqw28Y+WaKGLaoDgJ8SIanV9wsTaHyqM8ALvUrwEK8JL2ShVQaQsHm1KDMkF3GYuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bp/4rP7LpmO6LT8PcC3FkTU4iBNCCElkMp/W0/Bt9LQ=;
 b=KeSzcCZaIBsLslAQq1DTY5Wi2gyM6waZCSzlxSgcM9wVmlUn/MDmERRm+n6FatbgJQ4L10b37VfRvcovKVbisH3G/jvfkSUxfF4/kf2gDb9YyrLXEkXNNCO1MuF768tTSzWcYcy2GiZ9FN82WaaThyBYLhpZdTfglV5f+Mh4xbqBS6p2ogw8OmtTou2xaQ0WMVyrjB6ZT3B4iL5dxE8+t6a8wL9tYK6CYvPOPNfG85/Wvi8e8M/yPt5b6OlhkV8moK45hhi89e0iAh37pBjnVTJpjLhudho1cRxutM4bbW9XniSnr4+3aXb28hLH/2G6DIzXK3ZsTuxlyopWn8kawA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bp/4rP7LpmO6LT8PcC3FkTU4iBNCCElkMp/W0/Bt9LQ=;
 b=EOuxidQwTrtBjQbIh2SVrBLz6fQqM3Yd7FSaVMQzQnR3XpkPO+HNo2TSzednJuZoAjWJQ7aMJToJ99D0siUDzMUdJKSzAJglXPNyKUyGQjQ9IF3HSWKdrUKSZtIWqKy5Nl70wksKo1NXOg60CTdAwr+F5TbbtRFZZxt9giLdJDA=
Received: from DM5PR07CA0110.namprd07.prod.outlook.com (2603:10b6:4:ae::39) by
 PH7PR12MB7426.namprd12.prod.outlook.com (2603:10b6:510:201::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 09:39:14 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:4:ae:cafe::32) by DM5PR07CA0110.outlook.office365.com
 (2603:10b6:4:ae::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Mon,
 16 Jun 2025 09:39:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 09:39:14 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 16 Jun 2025 04:39:12 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>, Le Ma
 <Le.Ma@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH 08/10] drm/amdgpu: Convert query_memory_partition into common
 helpers
Date: Mon, 16 Jun 2025 17:37:54 +0800
Message-ID: <20250616093756.16200-9-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250616093756.16200-1-Hawking.Zhang@amd.com>
References: <20250616093756.16200-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|PH7PR12MB7426:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d5c0899-7146-40c8-1397-08ddacb9a810
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NSxTDj7s3BtLZDJdqjv6e+SNguPLQtZtlpMmGaZSvwQUsWFMhiTydgh85s5C?=
 =?us-ascii?Q?uA28khmTnEEcRNdXelqQB78/lIUW8mbzPpchwKbAAbQ+WsNcscC4xN51ycp9?=
 =?us-ascii?Q?1hTFFoNKSKBHh3Sw10qUnvG//OqOls58FR0Ra8VGJLEMxMyQY0qFsTqBev/G?=
 =?us-ascii?Q?yf5EbUlzMSKSVWlLdUC/UjkPhlfZ5a3JB6Ss1hLrJttcuty4cCreEGGBwpco?=
 =?us-ascii?Q?pOBTxPmchQIxGiWbYhmq0xAl40R8ULx+jWxbvAwVcggBUTED5gFgbQLJDmFY?=
 =?us-ascii?Q?V0E5FY+95OW4A8mTeP/iIEFYnpMqdihhfd1b1txvY27MhitOM4X4k0bqaF5r?=
 =?us-ascii?Q?B5ALrwaAampthfDWMk5Gu6eNM5pGUR0C6G9LBS94XEpbXYnx/8ApXVEkQaPH?=
 =?us-ascii?Q?N3zZEKmNgb9So5/bkLVzRoZjfnBc/RQ0zTDSl8KR/8FRrZsa7P6Byvu8e03R?=
 =?us-ascii?Q?rQBT08YhgvTp3uAgzZcMzIWUPNQGSl7NpZB4mdT7WEE8ShIB1rsmvIGN+Hef?=
 =?us-ascii?Q?I2OR8sp+oyTOTftlH3UEzU/ez9dy0or74qtwXFReCR1ukHHRY5F9BqUvZ8u+?=
 =?us-ascii?Q?bfkdmBD9F+1TD/KOnzoeWUmHrqeak5yherrfmnVnCv06YRufkgeioB4RMUyB?=
 =?us-ascii?Q?Gye90nxspeW+Z44n9Xb3zoDvjnY8x1oADSe6n99qGNflEBWya9JebOilwURw?=
 =?us-ascii?Q?PkKRbIVh13j+2WuQXXA1MYdco3g7BuZ/KadswT1fxYuq2+P2GLCDWRKxGT8k?=
 =?us-ascii?Q?5ROyVjX0JHJf4kzb1SLqF97IY6oSHMUDMsTHnBv2Opynnge5YFpaYIyP93hb?=
 =?us-ascii?Q?KcN5n5P15v+8Sjn4T4TyKAPNVALYVBdU/wBdn2zYQrZ6t7LNkzcc17d2pU97?=
 =?us-ascii?Q?sjzPhnF5nghLhPhdb2xEkxedgorcNG+k0SAiW/6NhtCgZnlqZy0WupvMIkRa?=
 =?us-ascii?Q?2K3S/hFFV5auog9LEFkXo9ebLPwvgnrIYJuTMYNj3dZF0pV4hkhDqDIYb6sR?=
 =?us-ascii?Q?ry1pqtwsohV26CoQsZ42Daajpfdayy3uwMMlVrwq9Xnz9XxUIKF47pi4u4E/?=
 =?us-ascii?Q?rIshB77TnWS3jPdMzNs6g7tmHe+99i5Ur2FtKiSJLWkf4MF2I7+qIlDySTCP?=
 =?us-ascii?Q?JRQomNExqNbwnaplN2E8DGVXLvrGWT628nqilLMiNZzNtlJrnTeRnC5b6kQm?=
 =?us-ascii?Q?p7+qDjobGjY1c8q6xhBBJpCMydiVPP9syjqsRYvzRl7WPQWrBKP1S4dziuza?=
 =?us-ascii?Q?LNhmJdAXk4gq0OD3QFgQdEq5EDYfSo89MK09ZcKifeFdotodBP3cHZ+N/MlE?=
 =?us-ascii?Q?CvEtPf6PHsPAl5jwqybF4jpkg7gRzilho/+Gmuz2w8awHHDJaRv7TQZOiMBX?=
 =?us-ascii?Q?1CfilRoW0vv9wtV32dRNDS0FC4kic21z9rk9WK1bBkQxhgV19INqaKUHZfA7?=
 =?us-ascii?Q?kJKVwfGjxnFubcKs1QSKXTTzTeEEuzKs4u1hKynQpzQf4ibTjJOZIJnWviIB?=
 =?us-ascii?Q?T4Af3369EtOLH51RXVttFvuj6tFWi1NOTpHR?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 09:39:14.4230 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d5c0899-7146-40c8-1397-08ddacb9a810
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7426
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

The query_memory_partition does not need to remain
as soc specific callbacks. They can be shared across
multiple products

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 43 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  7 +++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 48 +++----------------------
 3 files changed, 53 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index c5f06142e892..7e69296cf9ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1448,3 +1448,46 @@ bool amdgpu_gmc_need_reset_on_init(struct amdgpu_device *adev)
 
 	return false;
 }
+
+enum amdgpu_memory_partition
+amdgpu_gmc_get_vf_memory_partition(struct amdgpu_device *adev)
+{
+	switch (adev->gmc.num_mem_partitions) {
+	case 0:
+		return UNKNOWN_MEMORY_PARTITION_MODE;
+	case 1:
+		return AMDGPU_NPS1_PARTITION_MODE;
+	case 2:
+		return AMDGPU_NPS2_PARTITION_MODE;
+	case 4:
+		return AMDGPU_NPS4_PARTITION_MODE;
+	case 8:
+		return AMDGPU_NPS8_PARTITION_MODE;
+	default:
+		return AMDGPU_NPS1_PARTITION_MODE;
+	}
+}
+
+enum amdgpu_memory_partition
+amdgpu_gmc_get_memory_partition(struct amdgpu_device *adev, u32 *supp_modes)
+{
+	enum amdgpu_memory_partition mode = UNKNOWN_MEMORY_PARTITION_MODE;
+
+	if (adev->nbio.funcs &&
+	    adev->nbio.funcs->get_memory_partition_mode)
+		mode = adev->nbio.funcs->get_memory_partition_mode(adev,
+								   supp_modes);
+	else
+		dev_warn(adev->dev, "memory partition mode query is not supported\n");
+
+	return mode;
+}
+
+enum amdgpu_memory_partition
+amdgpu_gmc_query_memory_partition(struct amdgpu_device *adev)
+{
+        if (amdgpu_sriov_vf(adev))
+                return amdgpu_gmc_get_vf_memory_partition(adev);
+        else
+                return amdgpu_gmc_get_memory_partition(adev, NULL);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 5aa404390d68..95a68e0eb96e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -458,5 +458,10 @@ int amdgpu_gmc_request_memory_partition(struct amdgpu_device *adev,
 					int nps_mode);
 void amdgpu_gmc_prepare_nps_mode_change(struct amdgpu_device *adev);
 bool amdgpu_gmc_need_reset_on_init(struct amdgpu_device *adev);
-
+enum amdgpu_memory_partition
+amdgpu_gmc_get_vf_memory_partition(struct amdgpu_device *adev);
+enum amdgpu_memory_partition
+amdgpu_gmc_get_memory_partition(struct amdgpu_device *adev, u32 *supp_modes);
+enum amdgpu_memory_partition
+amdgpu_gmc_query_memory_partition(struct amdgpu_device *adev);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 01b9374134f2..3cc2d5c21f49 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1383,46 +1383,6 @@ static unsigned int gmc_v9_0_get_vbios_fb_size(struct amdgpu_device *adev)
 	return size;
 }
 
-static enum amdgpu_memory_partition
-gmc_v9_0_get_memory_partition(struct amdgpu_device *adev, u32 *supp_modes)
-{
-	enum amdgpu_memory_partition mode = UNKNOWN_MEMORY_PARTITION_MODE;
-
-	if (adev->nbio.funcs->get_memory_partition_mode)
-		mode = adev->nbio.funcs->get_memory_partition_mode(adev,
-								   supp_modes);
-
-	return mode;
-}
-
-static enum amdgpu_memory_partition
-gmc_v9_0_query_vf_memory_partition(struct amdgpu_device *adev)
-{
-	switch (adev->gmc.num_mem_partitions) {
-	case 0:
-		return UNKNOWN_MEMORY_PARTITION_MODE;
-	case 1:
-		return AMDGPU_NPS1_PARTITION_MODE;
-	case 2:
-		return AMDGPU_NPS2_PARTITION_MODE;
-	case 4:
-		return AMDGPU_NPS4_PARTITION_MODE;
-	default:
-		return AMDGPU_NPS1_PARTITION_MODE;
-	}
-
-	return AMDGPU_NPS1_PARTITION_MODE;
-}
-
-static enum amdgpu_memory_partition
-gmc_v9_0_query_memory_partition(struct amdgpu_device *adev)
-{
-	if (amdgpu_sriov_vf(adev))
-		return gmc_v9_0_query_vf_memory_partition(adev);
-
-	return gmc_v9_0_get_memory_partition(adev, NULL);
-}
-
 static bool gmc_v9_0_need_reset_on_init(struct amdgpu_device *adev)
 {
 	if (adev->nbio.funcs && adev->nbio.funcs->is_nps_switch_requested &&
@@ -1444,7 +1404,7 @@ static const struct amdgpu_gmc_funcs gmc_v9_0_gmc_funcs = {
 	.get_vm_pte = gmc_v9_0_get_vm_pte,
 	.override_vm_pte_flags = gmc_v9_0_override_vm_pte_flags,
 	.get_vbios_fb_size = gmc_v9_0_get_vbios_fb_size,
-	.query_mem_partition_mode = &gmc_v9_0_query_memory_partition,
+	.query_mem_partition_mode = &amdgpu_gmc_query_memory_partition,
 	.request_mem_partition_mode = &amdgpu_gmc_request_memory_partition,
 	.need_reset_on_init = &gmc_v9_0_need_reset_on_init,
 };
@@ -1597,7 +1557,7 @@ static void gmc_v9_0_init_nps_details(struct amdgpu_device *adev)
 	if (amdgpu_sriov_vf(adev) || (adev->flags & AMD_IS_APU))
 		return;
 
-	mode = gmc_v9_0_get_memory_partition(adev, &supp_modes);
+	mode = amdgpu_gmc_get_memory_partition(adev, &supp_modes);
 
 	/* Mode detected by hardware and supported modes available */
 	if ((mode != UNKNOWN_MEMORY_PARTITION_MODE) && supp_modes) {
@@ -1889,7 +1849,7 @@ static bool gmc_v9_0_validate_partition_info(struct amdgpu_device *adev)
 	u32 supp_modes;
 	bool valid;
 
-	mode = gmc_v9_0_get_memory_partition(adev, &supp_modes);
+	mode = amdgpu_gmc_get_memory_partition(adev, &supp_modes);
 
 	/* Mode detected by hardware not present in supported modes */
 	if ((mode != UNKNOWN_MEMORY_PARTITION_MODE) &&
@@ -1973,7 +1933,7 @@ gmc_v9_0_init_sw_mem_ranges(struct amdgpu_device *adev,
 	u32 start_addr = 0, size;
 	int i, r, l;
 
-	mode = gmc_v9_0_query_memory_partition(adev);
+	mode = amdgpu_gmc_query_memory_partition(adev);
 
 	switch (mode) {
 	case UNKNOWN_MEMORY_PARTITION_MODE:
-- 
2.17.1

