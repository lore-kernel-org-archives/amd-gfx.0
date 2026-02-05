Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6DB0ECD986
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 16:43:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3ECCF10E929;
	Thu,  5 Feb 2026 16:43:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xdn4zA41";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010022.outbound.protection.outlook.com
 [52.101.193.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BAA810E932
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 16:43:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bvU8Mf9DHZxtpBkHU9fjpnhCUrbM7jDUZsBkMO/0eBCCfMaqIxCc+0PK7dV+w8b25MdckLqQF8+10IuYbILEpzXNhgXRVsnvR0YF8+ieiccb/wz2XIB04Gn+kDnh7PSzGAWGBb5AeE3VEwZXIcLbzeGa9HOSeFbqSH/IvFTJHVe8UyBszSB6lbBMWJJv/Q6K0r5He9tWjILbyB9rcfj0BMJYByzBEdWcrknCVHqsjx87lZ+054mFcg8d2ylPisDf3loqIrStiKYWpIK3KLwv3+2byjywgKVmICtwNMnHJYSJ2ReGa/4eK/EllQZvfDc7DgidnS5gg4cyPRijlCnD1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CL620UZaqxhudKvxWidevGMySjgMUdo3dVZIOVLg6Jo=;
 b=nY+SdzxP8hqrFU+nlHjaFV6zBd2DO7m6zo74WQOwcGh/Uli0mHixLPt7rW7BPS0aTd54cNWo/xiBIo1v9WQncXUjhN7S/7pAWJAh0RyhFACKhYQgqpG/1i6dkVHYc7e/FSqgUf9QPaq6f9YW3EgklUWAHa/ZF9Nb1yR0nN/7Fvp4SHF3xtIdoFuRp1h4w4p6oDNRAJou9Hjt7b8Ckjte9yKodPjClAC097LDigjADzSeog/PXB4QD+4z2jYd5NcEMft+MADJQ62DF/ASoiHeu5/pHgltAWWvQBakyZwNTzKf2ZJNsYeOO7glcQZ1hFyTQ8qRmliAAMItSonb0aKPzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CL620UZaqxhudKvxWidevGMySjgMUdo3dVZIOVLg6Jo=;
 b=Xdn4zA418UmBTu/F7CRE4YpVUwsxj72jW5ZDu8FPDjJj4y4MV+TZx1kGNrOhP1Rt+upd3yEern3DqYA88kmmHQZXxiuXGxdWyRDgsETpYlQX/1731s6LfyGD4/QA1gbb5k9OkG/amcKWbc1drl+pwO5MOJOmUdRtFJhAXoH6N1c=
Received: from DS7PR03CA0117.namprd03.prod.outlook.com (2603:10b6:5:3b7::32)
 by SJ5PPF665EE4E73.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::996) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 16:43:34 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:5:3b7:cafe::b1) by DS7PR03CA0117.outlook.office365.com
 (2603:10b6:5:3b7::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Thu,
 5 Feb 2026 16:43:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.0 via Frontend Transport; Thu, 5 Feb 2026 16:43:33 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 5 Feb 2026 10:43:31 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, Cal Peake
 <cp@absolutedigital.net>
Subject: [PATCH] drm/amd: Fix hang on amdgpu unload by using
 pci_dev_is_disconnected()
Date: Thu, 5 Feb 2026 10:42:54 -0600
Message-ID: <20260205164254.4091912-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|SJ5PPF665EE4E73:EE_
X-MS-Office365-Filtering-Correlation-Id: 709b0f46-ea1c-4201-f6f3-08de64d5b334
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HRRSz2Urxb1umr1DwjwUT7WpY7Q4/V/fRtGhPfGkH6xNVJ7U70WpPGDbttSM?=
 =?us-ascii?Q?4H2vWY0DNodcC0+C73MfF5mlbhIQAJgcqHr6nr7UTOe+Vcf/t2NyR+RRnkJ1?=
 =?us-ascii?Q?eKLx/lAbjrQmDMOHRGVmTuYGsF1YoZA1phcSUuhAyJX4JFkIMaLe+BTpzIkG?=
 =?us-ascii?Q?7dJd3IQ87lx+RJ1zc5SPczW/LLIgptPDB1lpfTkLgey8nkFpxE+YA16lyi5X?=
 =?us-ascii?Q?S0vmYLeG+MSAVLlYel7fLidaoTOKehrEz2GKX9U1y9ULxQkaCeEPHugg6GEd?=
 =?us-ascii?Q?Q1msvE1YYzDbN18i1XIzBMwIAkjPnR+sGoF2YV5asGZm0Ff7e3lDRF107wry?=
 =?us-ascii?Q?mMphbk0oQY/uS4pLF4LhislZjnMIWfsJAzU+RTHm+Z3s5z2hcYISUjKeCQwp?=
 =?us-ascii?Q?S5DYGLFZEb47jYDUobA5K2qLmZJM9CczjVEVQ83fXtkeZV8o76VA0KsRJci2?=
 =?us-ascii?Q?lB+/H6He8NLsG4qx0lNnlvgUrqMmQ6yg+tuu3cb+Azp3uMYYKzIYQe/jQD6W?=
 =?us-ascii?Q?istgIcHCTq5YHnjV15X8Wb18cf9zPkQ0h1QpWr2hi9dHYHZQmga0e5Aw36sA?=
 =?us-ascii?Q?BwxblcFzNGeps0cQOwVEJxAbrm6xn4YTPio7mFOnOaaGylxBepQcaCrnSktX?=
 =?us-ascii?Q?f0TvgdwIZ0BIQstEKE5OdQufl/XOJtMx9DBUMuh5YZX4EqVWWRAVI/qXL6JY?=
 =?us-ascii?Q?/arRLx3VTW2SF91KOkiikv332+UOH6RGG6u0zmAxTEiRwvJgAZ4JaqDkpGPv?=
 =?us-ascii?Q?uEHE6sjOAxS0KLyhxTKSimHwIDSYhIUsN0uoTzLbxeYBs54pPyBeF6bvthgG?=
 =?us-ascii?Q?9Wq5F1IVzQDXss66pQSAoTQfINdtHs0xyYtiTdxaQLCAs/BVkrhd5dGCBDTB?=
 =?us-ascii?Q?NT8aarBbT7Le9MTeYTnbFQ0K/wM2MtkImiLUoVQ22SCf8qi2MyOCqVUKaFfr?=
 =?us-ascii?Q?XVq/gaqaDdlavfgJ3KpJyNd1vL0XewBZMvFN6+vwLb8/vqyu7efp/m3qtnOd?=
 =?us-ascii?Q?H4f7jV9R30179Khk346xn05n7PJeWCYVdOMb5bsBcgomM7Ik3U3Kg6vknZpV?=
 =?us-ascii?Q?kmU20nsXMczmcdXa/QNOadF/jDqlcjEabh47aY6+LB8wJw5ib6dJ7R12Nqxl?=
 =?us-ascii?Q?QvXXlEZ3B0TB0Sw3NMq/CFBFxF4/bEI78r0WegZeVBIeZyB2SCo90gQUxxqS?=
 =?us-ascii?Q?s73hcD5d6/hWQS7O9YZfSlYCJ+c7j/UUH0QPt4TJmdtJ37xI4KZhgIrisrg6?=
 =?us-ascii?Q?R+K+swOtsWR3zPIesjHK50E0yqmTUqKXqnU6nIUk7roMFIq3jozixpkvIRcW?=
 =?us-ascii?Q?6vCiSRdsyvU06EJJBgLPqP1Iwzo4pCxM8gn5Z8KUf+pw+snGHka+Cn6eHNxh?=
 =?us-ascii?Q?q7wsEvUPy0e9IlvYV5Hi6VETVcDKUueK1hc5cw6xFuv2wzg73xgDTmLlGvEz?=
 =?us-ascii?Q?jBRnIdvfgwKvT6kLjennHrpYX5qX0OKl0Wx6l4eCLcERxBYogwlYwWUwBFAW?=
 =?us-ascii?Q?PCD+3AyEH7Hq3Il9E7rYrrEfDuxOF/VH4H8NfGnpEJEA9BedZusPO6IL+c9t?=
 =?us-ascii?Q?iv48J60CYt0s0uCjJhuMrqIoPQkKdTTthje++woSyJM00T8IxQbyZduzalfb?=
 =?us-ascii?Q?fq6Cvnow9Xp7PpZnkMeI4VM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: k5ywHkOak1OQ2jztrVzsGkCfKR+AUoi2Zy6tCjsnB+rY/e7rDG/NjWYRV0Jzlhs+AwaOdv2kkagRl70vjPXsaclUD8Urv6QbMLB0tJkYK0Ie2B7+1adRH/053uR8xupiL3RO1IQUAsKHN6f3Ws2JVI6Dbi0Rh/KY8VYBjmpSzuKUEK2bpqg1ZIL2F7Q0JjBWt1K12ww32f2e6b1FPYr1an5QS/RX21ACzJaFQumzWFN7pKtMZbKJHi0jIBd6QtZ7dVW+wxYo5c+/YLtWe1XQ+Y1n4CARx+yruxLZhgpL1y0VdQI2d+uxcHPHmNDkSJA/9m8SXZIsFuwpjKmFpJVuiexMyYOviyiipkKNHnkeVDeXi6UT6T12TA2GI9KdUk+ihJ7vrMwqQ7tpReiSV0myPRPlm4whJ+DANmUK88GcMM5GAiMDmDodEUYSbf66VCLC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 16:43:33.0351 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 709b0f46-ea1c-4201-f6f3-08de64d5b334
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF665EE4E73
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

The commit 28695ca09d32 ("drm/amd: Clean up kfd node on surprise
disconnect") introduced early KFD cleanup when drm_dev_is_unplugged()
returns true. However, this causes hangs during normal module unload
(rmmod amdgpu).

The issue occurs because drm_dev_unplug() is called in amdgpu_pci_remove()
for all removal scenarios, not just surprise disconnects. This was done
intentionally in commit 39934d3ed5725c ("Revert "drm/amdgpu: TA unload
messages are not actually sent to psp when amdgpu is uninstalled"") to
fix IGT PCI software unplug test failures. As a result,
drm_dev_is_unplugged() returns true even during normal module unload,
triggering the early KFD cleanup inappropriately.

The correct check should distinguish between:
- Actual surprise disconnect (eGPU unplugged): pci_dev_is_disconnected()
  returns true
- Normal module unload (rmmod): pci_dev_is_disconnected() returns false

Replace drm_dev_is_unplugged() with pci_dev_is_disconnected() to ensure
the early cleanup only happens during true hardware disconnect events.

Reported-by: Cal Peake <cp@absolutedigital.net>
Closes: https://lore.kernel.org/all/b0c22deb-c0fa-3343-33cf-fd9a77d7db99@absolutedigital.net/
Fixes: 28695ca09d32 ("drm/amd: Clean up kfd node on surprise disconnect")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d2c3885de711f..8900e0dc8a61d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5068,7 +5068,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 	 * before ip_fini_early to prevent kfd locking refcount issues by calling
 	 * amdgpu_amdkfd_suspend()
 	 */
-	if (drm_dev_is_unplugged(adev_to_drm(adev)))
+	if (pci_dev_is_disconnected(adev->pdev))
 		amdgpu_amdkfd_device_fini_sw(adev);
 
 	amdgpu_device_ip_fini_early(adev);
@@ -5080,7 +5080,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 
 	amdgpu_gart_dummy_page_fini(adev);
 
-	if (drm_dev_is_unplugged(adev_to_drm(adev)))
+	if (pci_dev_is_disconnected(adev->pdev))
 		amdgpu_device_unmap_mmio(adev);
 
 }
-- 
2.52.0

