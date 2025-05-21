Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A4F2C54E65
	for <amd-gfx@archiver.kernel.org>; Wed, 21 May 2025 09:49:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2BEC10E6D6;
	Wed, 21 May 2025 09:49:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4p6ZAjQZ";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFC6210E6D6
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 May 2025 09:49:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JjhPzNj1CRSu+9FdsNgDVc37D4fdCmYmA3vzcS//5q2GDUBLixNUJi4ie2mLg7BkXCLYWEb8ABtUcldBj2BaBqfCXNYr9tIti9U66AmFatUT2zmNPCL13Tp4iggU4wV68XOnA8odkgJBihe7sNHDUL0EVUIwB5uqaAZphIdWhORgAdUiy5I59QMyw3Vi6Y6L4rjgmSkNrrGGuU9J/oqoQSM8jWHIY6u1QSfHIQ3vbsCx+TddNOId4MOLOgzbJfcm0YWn+DEfAuv1fCUYgngrcchGHtEP+97hpOt0DMJdE6ClS9Xi7gLROZ1N3FeaZgPu8D3d+J7Ovlj6yXF+raHg0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9na9c9EuTG9HlPxrD2+lstk+I8nckOSrNeb0KUwDXDs=;
 b=wscTHPheAk5QsJxg9ATOI6SlndA8bv1O4hgp88brRVV3uw2Ai084FHyyTe5YEHUoV8/UXIwBp+ktL9mYmBZruQ/bqbRxDwk9eybo/+KMLtrXUBXXlctHPF1ft8g3qAq5EGJVFzs++V2YMGFi3FwW9x7soJw3BZZbyvOQkmpOL0Z8uX2YkadE+cUi6Pd3kzNDXWuM0RvkGk8+IQ7rwnayj3ORsGRH9essNPy5JLlRzP/iPk8W+k8/+rS4pC1vQpG9t+JLrmMc3t2oUshKWnxZH3n/FCZ59QobLloMF3CRb7wmyPfdm1yGy8jYX1znpi0deT+VZFR57BxVkkSP4b2GYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9na9c9EuTG9HlPxrD2+lstk+I8nckOSrNeb0KUwDXDs=;
 b=4p6ZAjQZ+raebYPUSCMxco6TZwUhc6Q7J/20AeKA1Hn4w4ARkDcmEoDnyrjAwdBu5kkwhXAEHdnFx799btG1cK+FwI4YYyd9JRu721RVwCroEd7l2NrY2nLHUaxixKYhP8+rI23+8kmCJ3kid8BETNrFrYPt2SjdQFvPeMJ50Uk=
Received: from BN9PR03CA0864.namprd03.prod.outlook.com (2603:10b6:408:13d::29)
 by DS0PR12MB8319.namprd12.prod.outlook.com (2603:10b6:8:f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 09:49:32 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:408:13d:cafe::bc) by BN9PR03CA0864.outlook.office365.com
 (2603:10b6:408:13d::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 21 May 2025 09:49:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.4 via Frontend Transport; Wed, 21 May 2025 09:49:32 +0000
Received: from FRAPPELLOUX01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 04:49:30 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH v1 1/7] drm/amdgpu: make devcoredump reading fast
Date: Wed, 21 May 2025 11:49:03 +0200
Message-ID: <20250521094912.6714-1-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|DS0PR12MB8319:EE_
X-MS-Office365-Filtering-Correlation-Id: 97b5da88-2a98-4efc-466f-08dd984cc986
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7H4mAzH4U9s+p7B2I3tm1uGAM5JIbGHaPE2s1BWsVdFkdNkjL9ZC6SyIea+Q?=
 =?us-ascii?Q?oLPgEqL4VxySp2jOMlBHsc/mu/UVg9n6rH/EkLyazRHdDz/W4K/gUUKuceEY?=
 =?us-ascii?Q?sb+T+nThfPjbvZlPOziw3juYU/VGweRCnAvmlfK1tu/RwXUAdhIUgYbY85kA?=
 =?us-ascii?Q?OJJF5/2XiO995oHv+W57rA9m3iH/leWA03d4TnHQnpJ83a3qAkzbHXfN5zAl?=
 =?us-ascii?Q?WPCLJaaOoTiHkEOtc4vpHEQSdB8yTl7+dcxECsdJ8QtlFWoWSB2kAmkc3vYV?=
 =?us-ascii?Q?RWOtCZ6O3qjFH02QA5xiYxBtt2B/EVHcFwRSPXD9zwmJhRlM8+iE/Gg861eQ?=
 =?us-ascii?Q?WjicHVOgnxwM2M22wCuuHZ4Xye3sfEWOLZqRb46uoZEE81iGXybHCDz9IhGo?=
 =?us-ascii?Q?dJThnJO5eBg+IyhozBIG3F5x8yUrtOhkIs7JeALU/7ikCiIm11Mgy4WutXOv?=
 =?us-ascii?Q?1hz0WJ5sEidGbjCsH5BIeqENA73U+wTNqpE+wxM/J+2AF0O2DlDfVIRT38XS?=
 =?us-ascii?Q?h5g19+Pagz86IrCdY4FFRoYB1E/+aQvnwgpuXvvWqIcHV/hpGuJ2nYSFyAa1?=
 =?us-ascii?Q?roZSJgf+HUQBkJFSLw+cnsd694NtcAiFkZXd0p8wA+zmXgjgVD3zS3Dyp5At?=
 =?us-ascii?Q?cymCGjAbK29bdaQnpuOvieMIbSFOZtBV8Zz8k6ZIkqX+SSuPDs9J1NmKOTtx?=
 =?us-ascii?Q?hXhvMPRHyhscHIu7cTH6+T0WoT15Rep9sEwgEI9uRURSECBU9gZtttFCFt5/?=
 =?us-ascii?Q?lEGTyQ6X/WQTzpYmICgfFJMxJzfisn6OF6zrLVqwu01gYx1r2ClT1S0xDpQt?=
 =?us-ascii?Q?AF9DmBFn6TgLRoLPxClJ06g2Q68zXRj9ksjS6lBMzYNVOUalrBJRJQ5NG9n8?=
 =?us-ascii?Q?/P9ekASQW1qsMx6baT9MbTprS62w34o+dc2KgmYtAUrGgox7ySfMlfMrsV4q?=
 =?us-ascii?Q?wLctmmMR2jWC5Vs4dgoMSwRWfzNRB+Y2AOeG9WyidLVTKQstDqcznimYZo5e?=
 =?us-ascii?Q?rYzrjGD5b3iIPSM68bZtTr57GbL85NxgkVnQ8k0mIWJYj0j8L5nTsZcZ7OE9?=
 =?us-ascii?Q?ChHZWQCtRhfDuDfxVmhAaYqauGidAd/ELEhMa21OpewZNMHLLty/Tu50RgUn?=
 =?us-ascii?Q?Yz2dXKADzQRtk+6iUTcSQ/Za/rMIpKkipLE6w7rwtpB+vfOFHYhaMU6YtG+3?=
 =?us-ascii?Q?F09XSpvyucvC5MoZ1PXX4Grq97w280JlBFk+n0dML6MvuNpDVEFi87pPlEBq?=
 =?us-ascii?Q?dwueWEtyBcgTBmGM2V9ACbcUs7ME+AZEVACraJ25FF4tO4op9ML3DG3uUXDt?=
 =?us-ascii?Q?yI9sx503lV53ofnXvFvg7agPpsydgA9LyWiPACW71dDLDjArwge6yqowwUfB?=
 =?us-ascii?Q?C4UHJ268MO0RYqX6aQRYd1cjjN0zyXJJaOroECpU1M8kiBh7v8ZnqBOqf1pg?=
 =?us-ascii?Q?ePpUJBcVWRUJjxK2Nop81ZYJJ+fFsOlIbZyOQywV5q6RoBbEVblpHyzV2HxA?=
 =?us-ascii?Q?JyjjJrNUoalLA+mXOUvG/6Plr89n/+YMy6eF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 09:49:32.2007 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b5da88-2a98-4efc-466f-08dd984cc986
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8319
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

Update the way drm_coredump_printer is used based on its documentation
and Xe's code: the main idea is to generate the final version in one go
and then use memcpy to return the chunks requested by the caller of
amdgpu_devcoredump_read.

This cuts the time to copy the dump from 40s to ~0s on my machine.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  | 43 +++++++++++++++++--
 .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h  |  7 +++
 2 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
index 7b50741dc097..de70747a099d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -34,6 +34,8 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
 }
 #else
 
+#define AMDGPU_CORE_DUMP_SIZE_MAX (256 * 1024 * 1024)
+
 const char *hw_ip_names[MAX_HWIP] = {
 	[GC_HWIP]		= "GC",
 	[HDP_HWIP]		= "HDP",
@@ -196,11 +198,9 @@ static void amdgpu_devcoredump_fw_info(struct amdgpu_device *adev,
 }
 
 static ssize_t
-amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
-			void *data, size_t datalen)
+__amdgpu_devcoredump_read(char *buffer, size_t count, struct amdgpu_coredump_info *coredump)
 {
 	struct drm_printer p;
-	struct amdgpu_coredump_info *coredump = data;
 	struct drm_print_iterator iter;
 	struct amdgpu_vm_fault_info *fault_info;
 	struct amdgpu_ip_block *ip_block;
@@ -208,7 +208,6 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
 
 	iter.data = buffer;
 	iter.offset = 0;
-	iter.start = offset;
 	iter.remain = count;
 
 	p = drm_coredump_printer(&iter);
@@ -321,8 +320,44 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
 	return count - iter.remain;
 }
 
+static ssize_t
+amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
+			void *data, size_t datalen)
+{
+	struct amdgpu_coredump_info *coredump = data;
+	ssize_t byte_copied;
+
+	if (!coredump)
+		return -ENODEV;
+
+	if (!coredump->read.buffer) {
+		/* Do a one-time preparation of the coredump output because
+		 * repeatingly calling drm_coredump_printer is very slow.
+		 */
+		coredump->read.size =
+			__amdgpu_devcoredump_read(NULL, AMDGPU_CORE_DUMP_SIZE_MAX, coredump);
+		coredump->read.buffer = kvmalloc(coredump->read.size, GFP_USER);
+		if (!coredump->read.buffer)
+			return -ENODEV;
+
+		__amdgpu_devcoredump_read(coredump->read.buffer, coredump->read.size, coredump);
+	}
+
+	if (offset >= coredump->read.size)
+		return 0;
+
+	byte_copied = count < coredump->read.size - offset ? count :
+		coredump->read.size - offset;
+	memcpy(buffer, coredump->read.buffer + offset, byte_copied);
+
+	return byte_copied;
+}
+
 static void amdgpu_devcoredump_free(void *data)
 {
+	struct amdgpu_coredump_info *coredump = data;
+
+	kvfree(coredump->read.buffer);
 	kfree(data);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
index ef9772c6bcc9..33f2f6fdfcf7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
@@ -38,6 +38,13 @@ struct amdgpu_coredump_info {
 	bool                            skip_vram_check;
 	bool                            reset_vram_lost;
 	struct amdgpu_ring              *ring;
+	/* Readable form of coredevdump, generate once to speed up
+	 * reading it (see drm_coredump_printer's documentation).
+	 */
+	struct {
+		ssize_t size;
+		char *buffer;
+	} read;
 };
 #endif
 
-- 
2.43.0

