Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE1ABCCF9E9
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 08:48:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63CF510E761;
	Wed, 29 Oct 2025 08:48:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Bk8xK+kh";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011057.outbound.protection.outlook.com [40.107.208.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBD7410E761
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 08:48:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mwsYj5tek9VexJHtsnVxVlq/UxmES7EaPaBU+L4Ew1q4pQxp8DMPgYS7p1uuZu+4LU1nRuxGd17KrN+N3UVoPsnPAyIbrHTaIopRJQISaGlnhM5CiwT78dr7i/HXVXdQSA+8fItF2cxCQ7HKy0GBmi80Gi3fdr0N9o93eDRRd6HG1sAqK6O/XkYClYHDbGtF11FlHCCohiFOOr5LjKhmrpbEDoeIYfBKyJcfr6niJWmTwnScjCn7CsNpjGaw15rSg1637adXX1+7EU/q61YhCGG4tR36axCXATX1+UeexHpNsXJi5q6NWieiXwCn7IXlfFQdkXdUOnXilo6UUIm/6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SrGZuMEC1oRjPeIcONvZu9l9XlyOz13+YVRoyEczK2M=;
 b=iCwHr/6GcZS5gFVuF/OXNgIXTzu7fS4HCaVJKjNDe0f5UyqljXSqQmkjCp8UEC8/Qw7C4cohR882PBr9qK8n6F9ek+Ro+PHmwANldvoLOXpq0/mhFIh07gjFYf5LBXaG5fMd/13SZHIOQy4ohtgZxUohepQTCO5RzE/9MosAFfipXIz/pN0E32x4XajUFyFfexqzla1r2UfRyI2ysRV3C7KydhyOTYKf3Ka9AoPYNQ4c94YraST6jCH9kylBcP42TroOfyG0oFNrI1UraZ2bgeZS0lwbzR8PmSTUs6hq0r/uu9d8WpfnfGupx1DAz3JXhAslDaF8uluMXp8VdDqmaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SrGZuMEC1oRjPeIcONvZu9l9XlyOz13+YVRoyEczK2M=;
 b=Bk8xK+khCB3GAZDeImFQ8qoU53+JerwFGgafcsycyJU+PJ/bU3fZZgaq7oiQjH077LB0fZznXPBgiQwOvTr/Dmq04GM5LO48jc/G54gr53xb6GX0Stnujwz2hD3Cc0/iCt6qBnmfdI1bpVjnjjYL8HfnDrDRrVjicLRtwOSVaHs=
Received: from BN9PR03CA0422.namprd03.prod.outlook.com (2603:10b6:408:113::7)
 by SN7PR12MB8772.namprd12.prod.outlook.com (2603:10b6:806:341::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 08:48:22 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:408:113:cafe::48) by BN9PR03CA0422.outlook.office365.com
 (2603:10b6:408:113::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Wed,
 29 Oct 2025 08:48:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 08:48:22 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 29 Oct 2025 01:48:19 -0700
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH 07/10] drm/amdgpu: adapt reset function for pmfw eeprom
Date: Wed, 29 Oct 2025 16:47:48 +0800
Message-ID: <20251029084751.1701305-7-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029084751.1701305-1-ganglxie@amd.com>
References: <20251029084751.1701305-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|SN7PR12MB8772:EE_
X-MS-Office365-Filtering-Correlation-Id: aeeabae5-b636-4353-bf70-08de16c7ea98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Mix1SOFiUKvFReMBwWr86Jd80jp666Wm6c1ah+H2TlIZyJm11MCdgwHsINQg?=
 =?us-ascii?Q?m+rw4/zylBIojgSFrvwDqQH4rJ0kK7Dfz2QCul3Q3VflH9DNVPkM1hom4Bh/?=
 =?us-ascii?Q?0grpblIn6yl/dKVWzSh+ljgtbCY3hvGKTP1oUh5rywh6dTayZeraGRrzSQ+K?=
 =?us-ascii?Q?Mm1QwXvU7hqBCrUD8pJYl/g7cYAab//Z0i5GTB/GJijsWh2w5ipS4FFsRAhX?=
 =?us-ascii?Q?fAqgtaySFK4x36g03qvpNUG0zd7o6MxBnESLBsFrM5cZRIi1Fi5ekciADP7L?=
 =?us-ascii?Q?Sbvf2bJX5Z2Jejh1WU8NGESDVSf5W33d0eFSFMEjiqjUqvDTK5LqSU9D1gIk?=
 =?us-ascii?Q?QQwccPvQznrLPfHvD/m8bdQGY1WT5/VwJv1gluWrrKxtxQmxsA9s1jac343n?=
 =?us-ascii?Q?ws0BlkNYK8c0idZbvv9SN2C2A2dbS7Nx4hkhyASKnqahNiZ5QCu44epqLTCy?=
 =?us-ascii?Q?bjl1ffUlfLvQ7Xu8Vo1y5SDUbMh/4EtnEw+daH2wlFkKdmr66feDQIyS5vtF?=
 =?us-ascii?Q?fNHXAzxsPqvB0kasmmqfJeli08qS9QScjF2pgkHJ8ugUP7SP4ICjvNsbdHjv?=
 =?us-ascii?Q?ey5G3ERblwGTrBRiImKZ9RAUA7kxsy446Ks06F0ESnedmReqdX0xSTEHGALy?=
 =?us-ascii?Q?mfbVk/T4GePA/bvzN2CFIf4lVhgv55mhNvhnmGJcV+wvgcmoKSPvHQP8TwLo?=
 =?us-ascii?Q?5hucPC+vbFVjFSlliyh+FilLYJuxrYrDRQ1jdZooJbn9MPX/X7pqNvsBNLYa?=
 =?us-ascii?Q?LfTY9WqcjUqnrdcuo/hMykZreSPZLNLY6oBi22R1VWszqnxDm3vOT2Tet86d?=
 =?us-ascii?Q?CGNkKYXMYJBiQhuQcAZxeGS2naNt9EMYdN9vI++FiMPJQlIEdSrGBR9QmLq1?=
 =?us-ascii?Q?soa8vbe0u09gdggSe8R72qT7WgQ53DD4eOLHwKIdtTT+lJjQYhpc67E4jHJC?=
 =?us-ascii?Q?unhSqkrWs6qezVby1/aLST8oCyce6t1wQRDdygirNLobaOV9KtZERY7VNefc?=
 =?us-ascii?Q?etpavARCB0qAKnhjKlb4z8YerrG8u2zLDsOtZLXGhF3XO151RCugCxaGLAlk?=
 =?us-ascii?Q?7kQQ+MOK00IHR7otNL1O/FU7PcVF4E9Anju8b4il9UvvEJScvMdIthfNCslj?=
 =?us-ascii?Q?gu1BTrS64P7rXhNTl6acBYqxFdDv4YQ+AYGniVRfE3OidlPVF5nLc9JlCgPr?=
 =?us-ascii?Q?RktK3L90oSzya96GQzAW5HV2hAm8XPAhoCmCe/VsxHSutDWx8fc/dEOC1RCU?=
 =?us-ascii?Q?v7gbCTdCzqSe+r55Ygc6jg5HCh7p/cMn5ARkkPt5Aejliu2sBzOV2CWgBNII?=
 =?us-ascii?Q?2hfHxw20X+TECQejRv/ohTr5xfO4aMwPUJPzdCN3oUrb/NCbAvG2O4AHCwfA?=
 =?us-ascii?Q?Qd8sSH0M7MoErxLrqzPjM5ewAi+iUfdV1Tj5i21ihX6VjUBdE1DkERLBBacz?=
 =?us-ascii?Q?7YzGlnOlCvFA12ixWoHSS2l+5SVCrmdEGeUsO6muF7tjO7B6wy+ztAzfEiuD?=
 =?us-ascii?Q?28I/duKLLxJqEm3ItVrgQNjfOwo5HTUDTzg9xL53iRHvMcoMqNpc9dV+Nw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 08:48:22.2956 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aeeabae5-b636-4353-bf70-08de16c7ea98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8772
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

adapt reset function for pmfw eeprom

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 61 +++++++++++--------
 1 file changed, 36 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 8533f1b6ebe5..7ee1a758a051 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -444,40 +444,51 @@ int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control)
 	struct amdgpu_ras_eeprom_table_header *hdr = &control->tbl_hdr;
 	struct amdgpu_ras_eeprom_table_ras_info *rai = &control->tbl_rai;
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	u32 erase_res = 0;
 	u8 csum;
 	int res;
 
 	mutex_lock(&control->ras_tbl_mutex);
 
-	hdr->header = RAS_TABLE_HDR_VAL;
-	amdgpu_ras_set_eeprom_table_version(control);
+	if (!amdgpu_ras_smu_eeprom_supported(adev)) {
+		hdr->header = RAS_TABLE_HDR_VAL;
+		amdgpu_ras_set_eeprom_table_version(control);
 
-	if (hdr->version >= RAS_TABLE_VER_V2_1) {
-		hdr->first_rec_offset = RAS_RECORD_START_V2_1;
-		hdr->tbl_size = RAS_TABLE_HEADER_SIZE +
-				RAS_TABLE_V2_1_INFO_SIZE;
-		rai->rma_status = GPU_HEALTH_USABLE;
-		/**
-		 * GPU health represented as a percentage.
-		 * 0 means worst health, 100 means fully health.
-		 */
-		rai->health_percent = 100;
-		/* ecc_page_threshold = 0 means disable bad page retirement */
-		rai->ecc_page_threshold = con->bad_page_cnt_threshold;
+		if (hdr->version >= RAS_TABLE_VER_V2_1) {
+			hdr->first_rec_offset = RAS_RECORD_START_V2_1;
+			hdr->tbl_size = RAS_TABLE_HEADER_SIZE +
+					RAS_TABLE_V2_1_INFO_SIZE;
+			rai->rma_status = GPU_HEALTH_USABLE;
+			/**
+			 * GPU health represented as a percentage.
+			 * 0 means worst health, 100 means fully health.
+			 */
+			rai->health_percent = 100;
+			/* ecc_page_threshold = 0 means disable bad page retirement */
+			rai->ecc_page_threshold = con->bad_page_cnt_threshold;
+		} else {
+			hdr->first_rec_offset = RAS_RECORD_START;
+			hdr->tbl_size = RAS_TABLE_HEADER_SIZE;
+		}
+
+		csum = __calc_hdr_byte_sum(control);
+		if (hdr->version >= RAS_TABLE_VER_V2_1)
+			csum += __calc_ras_info_byte_sum(control);
+		csum = -csum;
+		hdr->checksum = csum;
+		res = __write_table_header(control);
+		if (!res && hdr->version > RAS_TABLE_VER_V1)
+			res = __write_table_ras_info(control);
 	} else {
-		hdr->first_rec_offset = RAS_RECORD_START;
-		hdr->tbl_size = RAS_TABLE_HEADER_SIZE;
+		res = amdgpu_ras_smu_erase_ras_table(adev, &erase_res);
+		if (res || erase_res) {
+			dev_warn(adev->dev, "RAS EEPROM reset failed, res:%d result:%d",
+										res, erase_res);
+			if (!res)
+				res = -EIO;
+		}
 	}
 
-	csum = __calc_hdr_byte_sum(control);
-	if (hdr->version >= RAS_TABLE_VER_V2_1)
-		csum += __calc_ras_info_byte_sum(control);
-	csum = -csum;
-	hdr->checksum = csum;
-	res = __write_table_header(control);
-	if (!res && hdr->version > RAS_TABLE_VER_V1)
-		res = __write_table_ras_info(control);
-
 	control->ras_num_recs = 0;
 	control->ras_num_bad_pages = 0;
 	control->ras_num_mca_recs = 0;
-- 
2.34.1

