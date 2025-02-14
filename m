Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A1EC021A6
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 08:08:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 736B910EBEF;
	Fri, 14 Feb 2025 08:08:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HiWLIm0J";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2056.outbound.protection.outlook.com [40.107.100.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31DCB10EBE9
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 08:08:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Op7nPWUPau+wV+IgzvWt+ZN+ZBe+y/5y4SlRVCic+R/MndAe48lDLgtn+dsXEk+P1jk0Rx/2zauO1fsqIS+E+fO3ONoONJ9qeDElJem6s9N7n0GATmuk53Ol+fRTGgIbgm6XD4MO3NnTpbUXNi6Rmcj1YZp3B+jR3UOV1oIIJIDlW0LN6+S9A8GjC0XhK0gvsklXwZlukb/sY4k84nOGAh2sd4InxoN/lJiSWPtZtTmdPtAwp8iAnCXtl8CZS/+Xu7mHVDPC/zUxKnljRd23Gb93lBW0AzoMiFUf4OLg9m6llKw+WU88AUc2Bwc28TZLtoCKMfmX47ML4oFRxehQKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OeHsKv5eTXJjrTCrRp3eImxnNOse/yOZks3nssKvaJw=;
 b=TDZy88+uhNaD4ztpoACjApbFuMoXpxNvGqoLzLADUv4in8sezvdC7mdi3A/ADzFZjOnMuizkRaWPOxsK1ZUYKbKjBJDqulzlm7Ad3QYFCJdfcNJu7del6BEGGav2kMfQ5zwJ5zT3js2ZYbSp/EFZGnq7gGxMGMUYiAxlhGcxh7RYuN0duHvZsrwNwDMPJPAdhly26kjpwkGPXln4ctr37SXzWkpmC6JHFi5Fhpk7+RMp8w1gHTrwjlTMrn7+TkgRDyRb7YjBvOJGV7BrXjWxptcJ8LQIDTGcTVmRnH6yCHTnaGaBQN6oBfkhmrPQGV66OFOuqbZaDFclGOg3wGEnyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OeHsKv5eTXJjrTCrRp3eImxnNOse/yOZks3nssKvaJw=;
 b=HiWLIm0J2LjUAS5xEBhPE6wbMbvXF0kcZ+uLWGW9e+1liE/+S0AeUqzcTRvW/A9iWDwwPgcu96yexkJWJphDs/Hq2r9jFuNksVuHwNZFPOMNhchtJtXZea77Kx+VRL4g01SSvN+HvsCb2wpBFBsKlAXrvtBELzSzKsfPONB2kHA=
Received: from BN1PR14CA0007.namprd14.prod.outlook.com (2603:10b6:408:e3::12)
 by MW4PR12MB6682.namprd12.prod.outlook.com (2603:10b6:303:1e3::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Fri, 14 Feb
 2025 08:08:05 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:408:e3:cafe::b2) by BN1PR14CA0007.outlook.office365.com
 (2603:10b6:408:e3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.13 via Frontend Transport; Fri,
 14 Feb 2025 08:08:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.0 via Frontend Transport; Fri, 14 Feb 2025 08:08:04 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Feb
 2025 02:08:02 -0600
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH v2 10/12] drm/amdgpu: Get timestamp from system time
Date: Fri, 14 Feb 2025 16:07:17 +0800
Message-ID: <7354805aedeccf59b3e1e2c9a3098e9bb9041bea.1739519672.git.xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1739519672.git.xiang.liu@amd.com>
References: <cover.1739519672.git.xiang.liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|MW4PR12MB6682:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c3a8560-eb26-403f-f052-08dd4cceb55a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xSu9xQAXxhhpc6MYwGYbzAd1pUZBNlGGPTX0dH/0HNSDAzEk57wa4nTHnSNZ?=
 =?us-ascii?Q?qUQmLZVL7pgc8L5jf6r+rOifsjXy6PtqMMhtlv6bPuxO2kr+zwMER+JTRiM6?=
 =?us-ascii?Q?EfFSXRzepWB1wYLCIPXTYx9qgJT23sVZa/wqYUpYfWLh1asHWSBpMKdSbwOD?=
 =?us-ascii?Q?wd8AMQo4UzBENGRh1pFg8QQWD0Gbl2mBL2/KVD7uoi8+Quy73CUEq3t4jI26?=
 =?us-ascii?Q?B47hFsUuwbFdDrW+Y1U9ha3saUbF9aCG2C4061sa0FvngrHL45eZc8I2QgXc?=
 =?us-ascii?Q?Pzj3V9g8ycCzD32WYnUcekdBafuGBEnZhidZ9vqbgaMs2vaglDs1ZlNlS1vL?=
 =?us-ascii?Q?6bq2wlbJp9cs/DVQrj0TQndYJLqZ4yECr4EueBgeLkq4cK2Mg1eJcsZo9dRm?=
 =?us-ascii?Q?tiC0MVLU5IBA6+VnMhaXQwX7lctKg31XMjrs7gdtzxo57te9BD+RjQqTOobb?=
 =?us-ascii?Q?GvikiNdKNtJLJ5NGzaxmT+1mQzhMr/6OVoXxY6dw2vI4/Q5MuLjPYfrl/hsd?=
 =?us-ascii?Q?H0Vks4fEUJIEG3fDccwcs28nPF1/Z05EHV/xb2JpMddQ0G61BdxZvMA6rA1O?=
 =?us-ascii?Q?YmJL8VAoowTYVZD5f0HNZfvbhUmD1CG6KkIfcGTJRwA+ktY7fVQeyNZC65EN?=
 =?us-ascii?Q?PqxgH2DGgzVc00i3iSaaJgxQ8z8MNOnLt4+zoh+KB4AhysINqcmEgjZ5XFVS?=
 =?us-ascii?Q?gSXFJ2h/Lw/BuWiqEOzFBan1J3zeEi7KvPIvjKvYNWWTF1AnHQW1as+9VXXk?=
 =?us-ascii?Q?X2/fvYZ7JcODKcOaWGn8pxkmZN93eQ40xxw8wTQ1avK9xBDzqrRgEjYFEpNP?=
 =?us-ascii?Q?nHKjf7gvVA2hMuNYoU/KtXXVkRPBytWQvdqHt1Y6ktNPeoNZ9J/p6UEUt88y?=
 =?us-ascii?Q?9akhn0r79E9k4wJvEbjIeRy3TNBlHA4hHVxBZPiYzLS2meZW/Qgh4svVHIOO?=
 =?us-ascii?Q?scT71StyWHAuTdI8IjB0gT5MuQktw0zUr6bmfK6V81qey0Fvhhhn3LEtZ2oD?=
 =?us-ascii?Q?j27/bXrepq5ko/W95pZRQ8dgsxyIxoBwGpgEuPwxTMzrI1NBwNLs5QTNx2oV?=
 =?us-ascii?Q?M6DJ4VFeRiYSsTEbuz4o/NsPyKzdoZnPZOb7wGxMYjIQ2f/Ver7wgqGXt0Kg?=
 =?us-ascii?Q?NvEbPtA69GXuVr082cgNVPg255tdu6Ye7xsectS8D7lz0M4Xag7T8xSA0Y0x?=
 =?us-ascii?Q?LJ4/wogLWEs0DwLOfmyLHKU/OOHgrBafXsIxFEOjKznFc+zwB26VH9g3xpa7?=
 =?us-ascii?Q?QH18YR4Y3CcqJ2kBAqMbldRrpGAgT76RE+DlHxv7UhHVL/SWTLNh8mGAJs0e?=
 =?us-ascii?Q?BOkLJc+eBnL9uYnyWdGUlPvfluXpXp7ywAMsR48mH/qzA39//oWf9mlk8qoi?=
 =?us-ascii?Q?4DRQTYVim1aTX9lhbF+FfXvrEFaQPXlbQdD+wkvgvtewL37MgCSLvPd5jb4o?=
 =?us-ascii?Q?6kTDo4B85hrxooZjaFxCqRDaWrwVG5SK5qyq2LgczY7PZrBZsUHDfyqD0OOk?=
 =?us-ascii?Q?gRNXmVKBKu8K8BI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 08:08:04.5307 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c3a8560-eb26-403f-f052-08dd4cceb55a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6682
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

Get system local time and encode it to timestamp for CPER.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
index c14742eb4d67..0bdc08fba3b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
@@ -36,6 +36,22 @@ static void __inc_entry_length(struct cper_hdr *hdr, uint32_t size)
 	hdr->record_length += size;
 }
 
+static void amdgpu_cper_get_timestamp(struct cper_timestamp *timestamp)
+{
+	struct tm tm;
+	time64_t now = ktime_get_real_seconds();
+
+	time64_to_tm(now, 0, &tm);
+	timestamp->seconds = tm.tm_sec;
+	timestamp->minutes = tm.tm_min;
+	timestamp->hours = tm.tm_hour;
+	timestamp->flag = 0;
+	timestamp->day = tm.tm_mday;
+	timestamp->month = 1 + tm.tm_mon;
+	timestamp->year = (1900 + tm.tm_year) % 100;
+	timestamp->century = (1900 + tm.tm_year) / 100;
+}
+
 void amdgpu_cper_entry_fill_hdr(struct amdgpu_device *adev,
 				struct cper_hdr *hdr,
 				enum amdgpu_cper_type type,
@@ -52,7 +68,8 @@ void amdgpu_cper_entry_fill_hdr(struct amdgpu_device *adev,
 	hdr->valid_bits.platform_id	= 1;
 	hdr->valid_bits.partition_id	= 1;
 	hdr->valid_bits.timestamp	= 1;
-	/*TODO need to initialize hdr->timestamp */
+
+	amdgpu_cper_get_timestamp(&hdr->timestamp);
 
 	snprintf(hdr->record_id, 8, "%d", atomic_inc_return(&adev->cper.unique_id));
 	snprintf(hdr->platform_id, 16, "0x%04X:0x%04X",
-- 
2.34.1

