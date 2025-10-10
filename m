Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C4BCCD18C
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 04:43:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7824210E26A;
	Fri, 10 Oct 2025 04:43:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mNRMf4c2";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013050.outbound.protection.outlook.com
 [40.107.201.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9515A10E267
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 04:43:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W4z5t6vJJJ/DPix0hUjGTcx0niz7S0rZkLTzS04ezeNh0Gp55SjtkS/Q0JhTtyL/Ghvbb61X95WElWm1h0cGhEfPdS8JwBTR/H9xF+Wq3s54TNkEHtvc2s0j714YRQ+BEmAtP6yuyKBsknCdq8tHn62JMbhinS2RyMrOo08bcSSJ083DwVTpI+5qVRgCk0f9ODihJyWxorNbSfeCaih8oVRe8X3dcaAV5lI3wUyf+XVUX8w8ojsP0Re92W7lU2euJ7rmIzioTkunaqSBsIvBNTQymPpwubYZpYEpLWO5jHBFAMAdMvZCh2I4g9eA9J/npj1bBLaRPI0KHrDfjQ/xLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1K6KLbhVS/cbC5KdHuNKZtujZJbyKqMwkXhN8m2WEw=;
 b=YAqJ7ivEfg8qqFjz2DIW20SHYA8x1ThQ0p7lnxlFGTIUff5F9yxOoCrB+PV8MbCPLYDZNXX8kpYNubWOZu3S8aT9Du6DXCLUCWdXO+Aj452Kt9J4MvQTl1+ce7YJ1/wdAFZg2DYmCN3nDxeTqqm6NWFQ8RQC70ueapDqs1q1VGzq+q93X6bBb/cwW7AyDiohrDv2hspLHY3NvOOkx0bNZZ5bIaYohpWC5dJ5xHXJJ/TGfLdAtmlEgk1jDhrBPxPale8ykuHAfCoFAxLQLGSR0vedfO0FUd+l+JYrEImXwjpBtXTZX+vqCLN7SSoSy3LAfbzDz9dt+crjIktyX/gHoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1K6KLbhVS/cbC5KdHuNKZtujZJbyKqMwkXhN8m2WEw=;
 b=mNRMf4c2y/coJkWuCBZRcADfTFo7YZGOjNwwKsy2RS+BvFuUGi0GiVD5YihtLMYdKgdkbEpaDXx8jQ50uemQ+9H31T0iUJGQ9cu8L1F+f9pZtHgrL/Pqlhkp6mlqOHGy5b/0vrUTuGQXwZPGTur3lbLZYEFr9dLSDsxGeAJErAM=
Received: from BN9PR03CA0337.namprd03.prod.outlook.com (2603:10b6:408:f6::12)
 by LV2PR12MB5872.namprd12.prod.outlook.com (2603:10b6:408:173::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 04:43:29 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::35) by BN9PR03CA0337.outlook.office365.com
 (2603:10b6:408:f6::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Fri,
 10 Oct 2025 04:43:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Fri, 10 Oct 2025 04:43:29 +0000
Received: from cv350-ccs-aus-h13-08.cs-aus.dcgpu (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 9 Oct 2025 21:43:28 -0700
From: Ellen Pan <yunru.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Jeffrey.Chan@amd.com>, Ellen Pan <yunru.pan@amd.com>
Subject: [PATCH 5/6] drm/amdgpu: Add logic for VF ipd and VF bios to init from
 dynamic crit_region offsets
Date: Thu, 9 Oct 2025 23:43:08 -0500
Message-ID: <20251010044309.11822-5-yunru.pan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251010044309.11822-1-yunru.pan@amd.com>
References: <20251010044309.11822-1-yunru.pan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|LV2PR12MB5872:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b5c2248-81c1-4b6f-94d3-08de07b78f1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yGuEcDVYX090NejQGSNtsP/FHT2+WE22ZDotw3VDmPX5l7ND47OhClQiOUJf?=
 =?us-ascii?Q?LoP3a96IgAIXA1PomlavFaPqVaj1SW2zrdHmcyJGWor833nNf4YCr7KuSlp8?=
 =?us-ascii?Q?7mFiPqNV+wmJCLXq1dpZ5C4W2a7U3Y2+Mi7OmV/qXYa7QS+BytX4ll8cJas5?=
 =?us-ascii?Q?MvjvYA9ATsIJFtblXXkq2xzBh9VCbuFtlo9gjjSgbhlDNI22jFog7vJ6xk3G?=
 =?us-ascii?Q?/ZBrKg7UeP2bvNSckFv6LTPTYyUnh39ERRGS4DGiyUBPS0qka40BqvZqj1mY?=
 =?us-ascii?Q?gD9Oa0kreSrUZOfMYD5kkVmfdkypBrtx3R00L64GTH35B2e81boqAkXArKfi?=
 =?us-ascii?Q?rcS89saa0EziYGSyKpesFJYHlonAXgeXMjHQLPCWj20gPbUCaUXPwdaZ5WQS?=
 =?us-ascii?Q?Q6W8RpouJhWph36uv5RqKbW81wgMAPp2rBfX8RXtiEO6TJELcrbVddzPDph8?=
 =?us-ascii?Q?uVSdwnt185L2Xvg5LMvA2BXvFDp/FuDqZELL5WvnxaP2z/wZLID2i6tgNUj1?=
 =?us-ascii?Q?doGd2qkavmSRdUDypy3fy/bv1O2tAQRX94qL7k1KmsTdzHg/gokyar2UuuJ6?=
 =?us-ascii?Q?8/J1QLvkbelvWcNNvEVepqlv91D+TsuCfRokre2LifupN/milaZ+uIVROlzo?=
 =?us-ascii?Q?3psFWuCTeQtirv3ULx/bR03UQABMQ3IV4ghv7H7R1FrG/hshARJHKg9fiGH3?=
 =?us-ascii?Q?AkaRbDMJ9kJyGB9+tLwX24fHA5rvVAQBblo05tqMgAQywyWkZVwGEvxzya4Z?=
 =?us-ascii?Q?kIEkKBXkU1i5M9lDg3DM+1Wj/k8JFKDmQr+bpa8XEchlinVnbJ205Ths1nfb?=
 =?us-ascii?Q?eRVYHs3BraYqdTXPSGAUHqpjEXjL+tokpx86fbuyLpljVuPl2J5fVMPrR94e?=
 =?us-ascii?Q?uOoh9QZJjj2+ekhiCrpKcNbPjgi5I6k6PWQFQ6pYY2g7153lP0Sm/nQxNCir?=
 =?us-ascii?Q?OMCsEtQu8GWdXHKjPVOC4B68ontFL5HgO1Y417iLgB1VM9tD/ghYEVDLefS9?=
 =?us-ascii?Q?EYtsNkYWns2w7QnqlNPkmVhgljZu0rwXymWQb9NHte+JI4MBPtZkfp4h4Y05?=
 =?us-ascii?Q?tBmk7Jx7xaUVXohjaj18raiB8q0n2mLyrXfjBPc4NvnTpy3CIy4z8EFtp/9p?=
 =?us-ascii?Q?dS5nzSyLvqWau1NKHRwtC821TF7y3zNyoSYft9ejbL1LxiaAQup7cWw88IhV?=
 =?us-ascii?Q?7Io1vOMdqQt3g9yRhgtpcm2LP4/MnzqTWSBS7F/Pg8wdtGPEdauuv2v7eyNn?=
 =?us-ascii?Q?zx9jPsh20ja1gBUJ4XsZWHPXIlZGWQ5tDIfMO3D9k4chCHisdwtNijbLcL3j?=
 =?us-ascii?Q?KK7rvzgxsaz/Qp9pE7SFVS+Z5Qwy1SzN7GDlhFJghxbCIaZsBsm8SbTVl+aA?=
 =?us-ascii?Q?aYPZqCy2b81Ocqnj/4smwqaq6cUbNSAqskGj2JztpfyRhgLwYREW90JA3mS4?=
 =?us-ascii?Q?jid6/K5C2z8/x8Fikz5uJT/uklUistoSoITMNtn7qyRdwotsRLLeNFrcK8Xf?=
 =?us-ascii?Q?7xhO5MKYa8MfcjD7DreL1Tghg5SiUrf5ui+yiPNci3OwPuJeZjq6X75TMAUV?=
 =?us-ascii?Q?ik0RRhDFiD9xo4v3Ewk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 04:43:29.4174 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b5c2248-81c1-4b6f-94d3-08de07b78f1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5872
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

1. Added VF logic in amdgpu_virt to init IP discovery using the offsets from dynamic(v2) critical regions;
2. Added VF logic in amdgpu_virt to init bios image using the offsets from dynamic(v2) critical regions;

Signed-off-by: Ellen Pan <yunru.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c      |  26 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  33 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      | 107 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h      |   2 +
 5 files changed, 142 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 2a0df4cabb99..d320118858bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -416,6 +416,7 @@ int amdgpu_device_ip_block_add(struct amdgpu_device *adev,
 /*
  * BIOS.
  */
+bool amdgpu_check_atom_bios(struct amdgpu_device *adev, size_t size);
 bool amdgpu_get_bios(struct amdgpu_device *adev);
 bool amdgpu_read_bios(struct amdgpu_device *adev);
 bool amdgpu_soc15_read_bios_from_rom(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index 00e96419fcda..787584956214 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -47,7 +47,7 @@
 /* Check if current bios is an ATOM BIOS.
  * Return true if it is ATOM BIOS. Otherwise, return false.
  */
-static bool check_atom_bios(struct amdgpu_device *adev, size_t size)
+bool amdgpu_check_atom_bios(struct amdgpu_device *adev, size_t size)
 {
 	uint16_t tmp, bios_header_start;
 	uint8_t *bios = adev->bios;
@@ -96,7 +96,8 @@ void amdgpu_bios_release(struct amdgpu_device *adev)
  * part of the system bios.  On boot, the system bios puts a
  * copy of the igp rom at the start of vram if a discrete card is
  * present.
- * For SR-IOV, the vbios image is also put in VRAM in the VF.
+ * For SR-IOV, if dynamic critical region is not enabled,
+ * the vbios image is also put at the start of VRAM in the VF.
  */
 static bool amdgpu_read_bios_from_vram(struct amdgpu_device *adev)
 {
@@ -127,7 +128,7 @@ static bool amdgpu_read_bios_from_vram(struct amdgpu_device *adev)
 	memcpy_fromio(adev->bios, bios, size);
 	iounmap(bios);
 
-	if (!check_atom_bios(adev, size)) {
+	if (!amdgpu_check_atom_bios(adev, size)) {
 		amdgpu_bios_release(adev);
 		return false;
 	}
@@ -155,7 +156,7 @@ bool amdgpu_read_bios(struct amdgpu_device *adev)
 	memcpy_fromio(adev->bios, bios, size);
 	pci_unmap_rom(adev->pdev, bios);
 
-	if (!check_atom_bios(adev, size)) {
+	if (!amdgpu_check_atom_bios(adev, size)) {
 		amdgpu_bios_release(adev);
 		return false;
 	}
@@ -195,7 +196,7 @@ static bool amdgpu_read_bios_from_rom(struct amdgpu_device *adev)
 	/* read complete BIOS */
 	amdgpu_asic_read_bios_from_rom(adev, adev->bios, len);
 
-	if (!check_atom_bios(adev, len)) {
+	if (!amdgpu_check_atom_bios(adev, len)) {
 		amdgpu_bios_release(adev);
 		return false;
 	}
@@ -225,7 +226,7 @@ static bool amdgpu_read_platform_bios(struct amdgpu_device *adev)
 	memcpy_fromio(adev->bios, bios, romlen);
 	iounmap(bios);
 
-	if (!check_atom_bios(adev, romlen))
+	if (!amdgpu_check_atom_bios(adev, romlen))
 		goto free_bios;
 
 	adev->bios_size = romlen;
@@ -334,7 +335,7 @@ static bool amdgpu_atrm_get_bios(struct amdgpu_device *adev)
 			break;
 	}
 
-	if (!check_atom_bios(adev, size)) {
+	if (!amdgpu_check_atom_bios(adev, size)) {
 		amdgpu_bios_release(adev);
 		return false;
 	}
@@ -399,7 +400,7 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
 					     vhdr->ImageLength,
 					     GFP_KERNEL);
 
-			if (!check_atom_bios(adev, vhdr->ImageLength)) {
+			if (!amdgpu_check_atom_bios(adev, vhdr->ImageLength)) {
 				amdgpu_bios_release(adev);
 				return false;
 			}
@@ -467,9 +468,14 @@ static bool amdgpu_get_bios_dgpu(struct amdgpu_device *adev)
 	}
 
 	/* this is required for SR-IOV */
-	if (amdgpu_read_bios_from_vram(adev)) {
-		dev_info(adev->dev, "Fetched VBIOS from VRAM BAR\n");
+	if (amdgpu_sriov_vf(adev) && amdgpu_virt_read_bios_from_vram(adev)) {
+		dev_info(adev->dev, "Fetched VBIOS from dynamic VRAM BAR\n");
 		goto success;
+	} else {
+		if (amdgpu_read_bios_from_vram(adev)) {
+			dev_info(adev->dev, "Fetched VBIOS from VRAM BAR\n");
+			goto success;
+		}
 	}
 
 	if (amdgpu_prefer_rom_resource(adev)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 73401f0aeb34..de8676d6ff9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -275,21 +275,18 @@ static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
 	int i, ret = 0;
 	u32 msg;
 
-	if (!amdgpu_sriov_vf(adev)) {
-		/* It can take up to two second for IFWI init to complete on some dGPUs,
-		 * but generally it should be in the 60-100ms range.  Normally this starts
-		 * as soon as the device gets power so by the time the OS loads this has long
-		 * completed.  However, when a card is hotplugged via e.g., USB4, we need to
-		 * wait for this to complete.  Once the C2PMSG is updated, we can
-		 * continue.
-		 */
-
-		for (i = 0; i < 2000; i++) {
-			msg = RREG32(mmMP0_SMN_C2PMSG_33);
-			if (msg & 0x80000000)
-				break;
-			msleep(1);
-		}
+	/* It can take up to two second for IFWI init to complete on some dGPUs,
+	 * but generally it should be in the 60-100ms range.  Normally this starts
+	 * as soon as the device gets power so by the time the OS loads this has long
+	 * completed.  However, when a card is hotplugged via e.g., USB4, we need to
+	 * wait for this to complete.  Once the C2PMSG is updated, we can
+	 * continue.
+	 */
+	for (i = 0; i < 2000; i++) {
+		msg = RREG32(mmMP0_SMN_C2PMSG_33);
+		if (msg & 0x80000000)
+			break;
+		msleep(1);
 	}
 
 	vram_size = RREG32(mmRCC_CONFIG_MEMSIZE);
@@ -467,8 +464,10 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 			goto out;
 	} else {
 		drm_dbg(&adev->ddev, "use ip discovery information from memory");
-		r = amdgpu_discovery_read_binary_from_mem(
-			adev, adev->mman.discovery_bin);
+		if (amdgpu_sriov_vf(adev))
+			r = amdgpu_virt_init_discovery_from_mem(adev, adev->mman.discovery_bin);
+		else
+			r = amdgpu_discovery_read_binary_from_mem(adev, adev->mman.discovery_bin);
 		if (r)
 			goto out;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 461e83728594..67d5f15a72a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -965,6 +965,113 @@ int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
 	return r;
 }
 
+int amdgpu_virt_init_discovery_from_mem(struct amdgpu_device *adev, uint8_t *binary)
+{
+	uint64_t vram_size;
+	uint32_t ip_discovery_offset, ip_discovery_size;
+	uint64_t pos = 0;
+
+	/* Get dynamic offset for IPD if dynamic critical region is enabled */
+	if (adev->virt.is_dynamic_crit_regn_enabled) {
+		ip_discovery_offset =
+			adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].offset;
+		ip_discovery_size =
+			adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].size_kb << 10;
+
+		dev_info(adev->dev,
+			"Got IPD info from dynamic crit_region at offset 0x%x with size of 0x%x bytes.\n",
+			ip_discovery_offset, ip_discovery_size);
+
+		if (!IS_ALIGNED(ip_discovery_offset, 4) || !IS_ALIGNED(ip_discovery_size, 4)) {
+			dev_err(adev->dev, "IP discovery data not aligned to 4 bytes\n");
+			return -EINVAL;
+		}
+
+		if (ip_discovery_size > DISCOVERY_TMR_SIZE) {
+			dev_err(adev->dev, "Invalid IP discovery size: 0x%x\n", ip_discovery_size);
+			return -EINVAL;
+		}
+
+		pos = (uint64_t)ip_discovery_offset;
+		amdgpu_device_vram_access(adev, pos, (uint32_t *)binary,
+					ip_discovery_size, false);
+	} else {
+		vram_size = RREG32(mmRCC_CONFIG_MEMSIZE);
+		if (!vram_size || vram_size == U32_MAX)
+			return -EINVAL;
+
+		vram_size <<= 20;
+
+		pos = vram_size - DISCOVERY_TMR_OFFSET;
+		amdgpu_device_vram_access(adev, pos, (uint32_t *)binary,
+					adev->mman.discovery_tmr_size, false);
+	}
+
+	return 0;
+}
+
+/* For SR-IOV, if dynamic critical region is enabled,
+ * the vbios image is put at a dynamic offset of VRAM in the VF.
+ * If dynamic critical region is disabled, exit early to proceed
+ * the same seq as on baremetal.
+ */
+bool amdgpu_virt_read_bios_from_vram(struct amdgpu_device *adev)
+{
+	uint8_t __iomem *bios;
+	resource_size_t vram_base;
+	resource_size_t size = 256 * 1024; /* ??? */
+	uint32_t vbios_offset = 0;
+	uint32_t vbios_size = 0;
+
+	/* Exit early if it's not initialized */
+	if (!adev->virt.is_dynamic_crit_regn_enabled)
+		return false;
+
+	if (amdgpu_device_need_post(adev))
+		return false;
+
+	/* FB BAR not enabled */
+	if (pci_resource_len(adev->pdev, 0) == 0)
+		return false;
+
+	adev->bios = NULL;
+	vram_base = pci_resource_start(adev->pdev, 0);
+
+	vbios_offset = adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID].offset;
+	vbios_size =
+		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID].size_kb << 10;
+	if (vbios_size > size) {
+		dev_err(adev->dev, "Invalid vbios size: 0x%x\n", vbios_size);
+		return false;
+	}
+
+	dev_info(adev->dev,
+		"Got bios info from dynamic crit_region_table at offset 0x%x with size of 0x%x bytes.\n",
+		vbios_offset, vbios_size);
+
+	size = vbios_size;
+
+	bios = ioremap_wc(vram_base + vbios_offset, size);
+	if (!bios)
+		return false;
+
+	adev->bios = kmalloc(size, GFP_KERNEL);
+	if (!adev->bios) {
+		iounmap(bios);
+		return false;
+	}
+	adev->bios_size = size;
+	memcpy_fromio(adev->bios, bios, size);
+	iounmap(bios);
+
+	if (!check_atom_bios(adev, size)) {
+		amdgpu_bios_release(adev);
+		return false;
+	}
+
+	return true;
+}
+
 void amdgpu_virt_init(struct amdgpu_device *adev)
 {
 	bool is_sriov = false;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index bc1fc1c6daba..f2aa306f4192 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -438,6 +438,8 @@ void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev);
 void amdgpu_virt_init(struct amdgpu_device *adev);
 
 int amdgpu_virt_init_critical_region(struct amdgpu_device *adev);
+int amdgpu_virt_init_discovery_from_mem(struct amdgpu_device *adev, uint8_t *binary);
+bool amdgpu_virt_read_bios_from_vram(struct amdgpu_device *adev);
 
 bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev);
 int amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev);
-- 
2.34.1

