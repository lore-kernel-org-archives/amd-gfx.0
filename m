Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A03C02198
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2025 04:23:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5874010E41C;
	Thu,  6 Feb 2025 04:23:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C1IzOink";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50A9810E41C
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2025 04:23:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KAC9P207wJyu26T/knGCeqUIO7iWX2bsAPu0Hw1OZY1ygqCtlEB47AIQyZ2BiDHqzkkt6X6jFtTIAHumMjUmoUANFr8s/6jzCkp9gm7cS97dYgFmBMu6Vqfx6T1PBnTEbopLCZ3inT+IA3dMBAT3zH90rw0rzBAs7u3sRpDLv66v7NCpfE0e2hIFIPjc7ccJ/9ps5MFibwjIgbzbGmAdrJ+g6UflOe6VzWrWqzBbEauvhTCsT8p/8sZRFbo4VRM708BKkPT6mhGiArCkA3t+P/B0kpGliZ6AqvKx0ehA5O+FCnBwesHnVFOwaCsdAlYReVuwVfWi2mTQXc3CmXxhxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0sTM30bPh+Wwr6tJfDTV9jo5ovp0ODF7Rzb6V5A4w0=;
 b=nKzfT+2yGy3RQ9zHMMo6WOtkZ4W55ZPnA13gcfA7Jdt8RjZU4xFBnsS0+S3A0ysb1/QG2vb0zoCaHEwT1gZEeZNs41cglNe5psKZ2iyOrEpT9kk89QHpaQYRZ0VvaDCkfXGTN/SmY6THb5+s307NcIT8TZ6Dzd2aDusTHjnf5iaT+PDbEec+QZDrLLVitiBX9rsNFSLPa+/RFWzfD9J7rcxcAYyuX0ovNWAZKQGpBvCEGGGoHcfk0nFyA0lAVNxoOGv0qH1VW7Fe3lyNqTddnUtUyFSEV3P3Nd6fwVVp2+gylb7OtJoHN4at8JeqVxuvYDyJl6agYgyK9jBG10QW/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0sTM30bPh+Wwr6tJfDTV9jo5ovp0ODF7Rzb6V5A4w0=;
 b=C1IzOinkDF8rNF8X3oPx3fjoXPh+m3xdI9gUdicA8BpUJ1DxZCaK35MRLDrN7hyuBEssDNvx4Chj2mcCiC2Oa71c1+sqGjqi6V0qN8TN0xZNB0YtDoS6TmIlLr3CN+Gf1z8YY0tCdEAIKdGObpH0upkCu/ydaBWaLPnlUUz+ff8=
Received: from MW4PR03CA0156.namprd03.prod.outlook.com (2603:10b6:303:8d::11)
 by MN2PR12MB4303.namprd12.prod.outlook.com (2603:10b6:208:198::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Thu, 6 Feb
 2025 04:23:32 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:303:8d:cafe::f0) by MW4PR03CA0156.outlook.office365.com
 (2603:10b6:303:8d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.16 via Frontend Transport; Thu,
 6 Feb 2025 04:23:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 6 Feb 2025 04:23:31 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 22:23:29 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>
CC: <Hawking.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v2 1/4] drm/amdgpu: Add wrapper for freeing vbios memory
Date: Thu, 6 Feb 2025 09:52:56 +0530
Message-ID: <20250206042259.1927200-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|MN2PR12MB4303:EE_
X-MS-Office365-Filtering-Correlation-Id: 338693d2-0930-4573-b7c2-08dd46660398
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?W/IBK+0XLaUhxq2WoWIy+JCw8hm6037YY4sMRc0fVr1QJCoJOBw01mDRP7CD?=
 =?us-ascii?Q?PqwRnBtdmYo0WE7LAFzteWyGVmQXaiB2X6XP1Mcjy5F2MjH3A9+KievlWULa?=
 =?us-ascii?Q?hQkymboqaOse4E2jVJzCEbIE+Y/UiAIax0XQcqojD1czOYDRfZQqf98wekL6?=
 =?us-ascii?Q?X26kmoLyI4pfgOfiD/id7bbC6nwZNdLpK1baYkfntNIHQEfFS+qiwxt3hLs6?=
 =?us-ascii?Q?TpUeQ0xYBZB3QAdnOWuawWspVY7Lkw3E/2njlu3Iir+w9a9MjERxrr2bKsQS?=
 =?us-ascii?Q?65S9KUc0IrEpZPLrDlyfFlVtWtyO6fe228tdl/gsbgHmj8r77llJ0dk1LK0W?=
 =?us-ascii?Q?N90mmeDRBoSaeFYWCuqpQiDbqcZsMJG75UAbQ7VNZw7zJ84ejlgXXLhsDIPG?=
 =?us-ascii?Q?Xa5smJqj33b2YzQZvtl9vovXlP8ktF10cR7dDWAd4uFt6I7LGoBkKI4mhkqR?=
 =?us-ascii?Q?gd03zj03fS/mQ0hzkOTVkv5iiZ6GH89XKlhChUszuXxaFMyOi3sIYZeupYxH?=
 =?us-ascii?Q?TdhjYMPKgajS3bkCuQiNToo0yxdYwBsTbx0xLRninK25olpQAn09wcW+4UhA?=
 =?us-ascii?Q?USooiyuOPR5+6dCDtLvle4mXckWpNuqxdXAgaVBBLgiWvdLpdeb7V4bhChdb?=
 =?us-ascii?Q?DljJrONwxFiBT6R9FIh4yHhzQNDBCgAsiFoPMygEWpfTRViMjEPo5oQQMqik?=
 =?us-ascii?Q?7fm9og+EPCQRpLZEW4g8iE7ug6jK5ILvCsGErZwbBDcHlYnQvakvZ73cZN8m?=
 =?us-ascii?Q?up3IH82rsL8f0QMA+iNJ5bLBm8Yeuc1oY+hJT+wkISv9UhC5KlBradHMl8XE?=
 =?us-ascii?Q?VqpZVQ7uOhJotOYmL3QahzBEZQ0l9LFdDPI8FLZZmAga4nPizaqsY1h1IlFN?=
 =?us-ascii?Q?Heq3Gpgyytu7ghsVAHXVSxvE4drQCRzKpe2iT9VPsHR1zmUyQspp0pJ2kFEf?=
 =?us-ascii?Q?F+yqq5CsK6yprQu/rhDYWaYuv1pQXiq4NRWhMKEcLz3s8jVNRjD4pC2EoQQh?=
 =?us-ascii?Q?Cec+B/oUyq2CmDs1eJrA8Dcw6L5jlqZ0LqYQkYNARx5Agv193gLVa9SndJp7?=
 =?us-ascii?Q?lzsa0n6wj6Wv7Npepw2O4sQztKxB0fjlkhAHGsZkvRP712OgpDOEdcfJJ1HP?=
 =?us-ascii?Q?QI8bw8oDu2yTp8/X9dRl3rOZbdDGUS0Hfhg5R3D7Ny5bFL/JU9S+U/b7hv1E?=
 =?us-ascii?Q?cxNHOkZQSplICXGKYGDl+qYbjGl383SxFaLUrCV+5STJ5HvKp5k8KzcVjAwb?=
 =?us-ascii?Q?erRoaArzMD86Zq2xMb1TzFnhA0f7hyZ7ZBKxh+18BRowAqZQKTqq+vJh5rK7?=
 =?us-ascii?Q?SVXxAmGo5Ng/MvfiOGkFx5+GuevzeruYbwc32CUQG6Zax4S27U7/1DnJaXgX?=
 =?us-ascii?Q?BCRiylZcuyjbga8GqNKWzs6T5CgEoC7p1rrBm4xqFvGijchXffWfo7DYP4iR?=
 =?us-ascii?Q?FAZrBGdqcmdcCGiV9kZJR8Ts++5wrjJ0iWVit+kmJwYeZ+R6ZPS0Xe0Gj0V8?=
 =?us-ascii?Q?PRoZ3hcL1eLiF1Q=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 04:23:31.5708 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 338693d2-0930-4573-b7c2-08dd46660398
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4303
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

Use bios_release wrapper to release memory allocated for vbios image and
reset the variables.

v2:
	Use the same wrapper for clean up in sw_fini (Alex Deucher)

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c   | 20 ++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  3 +--
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index af7f1c2cfcdf..df3903fcfc87 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -417,6 +417,7 @@ bool amdgpu_get_bios(struct amdgpu_device *adev);
 bool amdgpu_read_bios(struct amdgpu_device *adev);
 bool amdgpu_soc15_read_bios_from_rom(struct amdgpu_device *adev,
 				     u8 *bios, u32 length_bytes);
+void amdgpu_bios_release(struct amdgpu_device *adev);
 /*
  * Clocks
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index 423fd2eebe1e..75fcc521c171 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -84,6 +84,13 @@ static bool check_atom_bios(struct amdgpu_device *adev, size_t size)
 	return false;
 }
 
+void amdgpu_bios_release(struct amdgpu_device *adev)
+{
+	kfree(adev->bios);
+	adev->bios = NULL;
+	adev->bios_size = 0;
+}
+
 /* If you boot an IGP board with a discrete card as the primary,
  * the IGP rom is not accessible via the rom bar as the IGP rom is
  * part of the system bios.  On boot, the system bios puts a
@@ -121,7 +128,7 @@ static bool amdgpu_read_bios_from_vram(struct amdgpu_device *adev)
 	iounmap(bios);
 
 	if (!check_atom_bios(adev, size)) {
-		kfree(adev->bios);
+		amdgpu_bios_release(adev);
 		return false;
 	}
 
@@ -149,7 +156,7 @@ bool amdgpu_read_bios(struct amdgpu_device *adev)
 	pci_unmap_rom(adev->pdev, bios);
 
 	if (!check_atom_bios(adev, size)) {
-		kfree(adev->bios);
+		amdgpu_bios_release(adev);
 		return false;
 	}
 
@@ -189,7 +196,7 @@ static bool amdgpu_read_bios_from_rom(struct amdgpu_device *adev)
 	amdgpu_asic_read_bios_from_rom(adev, adev->bios, len);
 
 	if (!check_atom_bios(adev, len)) {
-		kfree(adev->bios);
+		amdgpu_bios_release(adev);
 		return false;
 	}
 
@@ -225,7 +232,8 @@ static bool amdgpu_read_platform_bios(struct amdgpu_device *adev)
 
 	return true;
 free_bios:
-	kfree(adev->bios);
+	amdgpu_bios_release(adev);
+
 	return false;
 }
 
@@ -327,7 +335,7 @@ static bool amdgpu_atrm_get_bios(struct amdgpu_device *adev)
 	}
 
 	if (!check_atom_bios(adev, size)) {
-		kfree(adev->bios);
+		amdgpu_bios_release(adev);
 		return false;
 	}
 	adev->bios_size = size;
@@ -392,7 +400,7 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
 					     GFP_KERNEL);
 
 			if (!check_atom_bios(adev, vhdr->ImageLength)) {
-				kfree(adev->bios);
+				amdgpu_bios_release(adev);
 				return false;
 			}
 			adev->bios_size = vhdr->ImageLength;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ae83e23872fa..38679e3d5209 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4741,8 +4741,7 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 	if (amdgpu_emu_mode != 1)
 		amdgpu_atombios_fini(adev);
 
-	kfree(adev->bios);
-	adev->bios = NULL;
+	amdgpu_bios_release(adev);
 
 	kfree(adev->fru_info);
 	adev->fru_info = NULL;
-- 
2.25.1

