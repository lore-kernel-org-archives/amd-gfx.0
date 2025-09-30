Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA892CAC5B8
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Sep 2025 06:36:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 499FA10E26F;
	Tue, 30 Sep 2025 06:36:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4OY9LlvX";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010045.outbound.protection.outlook.com
 [40.93.198.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9412B10E26F
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Sep 2025 06:36:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W2W7YfF9lJADebHTl8649sWlZGsh29j2ujE5jlelCfvVwCx8RIal9q6DQKeNoF/Xq6D3UrJ0fel8MiOnA2v5NG/oG6Z6lglZcPPgzAO1LeOjOtkEicY8F/kufUJ7RXzWyPPihW5t1zky5A0SFpfpp4jj4CcEjQ+uUVL0T0J5axKbX19fy3lM7x4b41C9hlMuoDS9C3qclSg3xgQi753+G6QKU428jqj7HN9k3M2ibv+5YX8CloZ6M/mq5OGqEHlp6WlNt9nVnnxtlkT6DM31VzM+GhooMJXms2UbRrEns00htYk5M0CIOEMrEiJ/p0UU9994R/ZN+tu6KHzM7SOLYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIfht2XVfDXndnuoU+RuYI0fAzOOgW5Wr2JKu1qVqFs=;
 b=cZbV5PK0R47eEbXLX0yVzwWUkMVGujL+GBvbljSOnt1W1Cy1M5TAbGUkuZ+UxkvsfBi7njkTxr1gs5PIPY943ZrXtblLZKYXVVOifx30rSr/DG2859tBiWyzdfgikkdku20OVBcqtT3yxNwHRDZGkSuoOZXmVosYZKtUs+ImUUMJ7lJ/Ae3Jtl6AiMIEdqrYugEtG0e6duR1jS+0iZrogvRKeAROlUdoZzhGDxHoafaYXsy0dEwsoFbHRicX+EFPu04CkqAkmZm6PO/ujDhfDvrjRHW1OHIh0yl+l1kDIe8nyiOw5K5d0GyknEUrF2eoCrDnFJUo/pcWJJN91MNO3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIfht2XVfDXndnuoU+RuYI0fAzOOgW5Wr2JKu1qVqFs=;
 b=4OY9LlvXTcqXwdzB2ss9bi9UoM9plpp9wfsHZVI2XGnVR+D/5Ku8xDTKmCRvvT8GFoww5ZYtbMPHwcxFz0YDN5Iw+jRFu8zgofSqNCFCRVwGCD4blHwz7dLNvjBXfVwmkYOMEfMIdcl4hj+b7YhcDpSoBw65Frkm90VWDETOwNY=
Received: from DM6PR07CA0076.namprd07.prod.outlook.com (2603:10b6:5:337::9) by
 CY5PR12MB6550.namprd12.prod.outlook.com (2603:10b6:930:42::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.17; Tue, 30 Sep 2025 06:36:51 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:5:337:cafe::ca) by DM6PR07CA0076.outlook.office365.com
 (2603:10b6:5:337::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Tue,
 30 Sep 2025 06:36:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Tue, 30 Sep 2025 06:36:50 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 29 Sep
 2025 23:36:49 -0700
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, Roman Elshin
 <roman.elshin@gmail.com>
Subject: [PATCH] drm/amdgpu: Check swus/ds for switch state save
Date: Tue, 30 Sep 2025 12:06:32 +0530
Message-ID: <20250930063632.3270909-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|CY5PR12MB6550:EE_
X-MS-Office365-Filtering-Correlation-Id: acb452c9-d5c0-4de6-69d1-08ddffebbd03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h4CzF6NRpwHvkJErCQijf54S02wdhlfq43cwKSnKbiec/y381aJqPtiRoUHl?=
 =?us-ascii?Q?pZzvxsa43OXB4BZDZPZ144lO5H8PZL4CxxIS4OFDMDFQzLoyEIJq3sMmZxYd?=
 =?us-ascii?Q?4zauBFmr1krIeMjPWKMM0gxHA35t4LGk81Eg132WnMdRkeh4DUGCfniFrxSs?=
 =?us-ascii?Q?aojVsi3KpwEq2lsKAAEdmFVYn5C8GOhl7zs2Z3ipN181mSmvHtCda09eiBh+?=
 =?us-ascii?Q?Sr6ywGRO8zqK1Pqey0a/LsfOVG6JrMD7wDYcD9uA64491JhwHQndLl220QHY?=
 =?us-ascii?Q?EYfTsPMy4li9Cb2h9DkG1YPj+ckSqVb/hY8YFE1WEYSKscpmQBxWJ+1BA1jW?=
 =?us-ascii?Q?NeOECRIGgyJApqOD0AKTUw05xFSAk9uxtKiZrN67Itooin2TM/Pzwt6T5AtB?=
 =?us-ascii?Q?66Mvcuow5Xv3peQGQ4zl71IRpi8rn6HDMccD9UUsA+ZmzwXp+aQRTtHilwgf?=
 =?us-ascii?Q?IGXsYi7MX9hjVsHXL1P1TfyvaGc5A8VxcTiNZsbvWGvE/ZAHpSE7FC4zkwq2?=
 =?us-ascii?Q?zzjds5B2qlMF5mRo9iDkjIEIP9HD6Rez20PBlf/emXnMdk/NNfyHU13EpuOR?=
 =?us-ascii?Q?IYfLbDWGUtdore9mH8VNXgMRRKEPfpPrRKkT0l+IIi+0ZfnoumUSMAxjz0oY?=
 =?us-ascii?Q?VtnLtAUs5eECE0OwTEP6xCsnNStGM8b8DuDdkjfFrgItIfD/1MK23uNFmkkG?=
 =?us-ascii?Q?nXoQGGchj09fPnZAuwKykOVFxIM8/3ktOcwvDsCkTWUExcqdx0eYUq+YSF0l?=
 =?us-ascii?Q?WzpHJhDMRtdNzHeftPgzaV3Ipqyu6L332NteoC0siFBoVYEc6njKkGZ3YK8r?=
 =?us-ascii?Q?C8Qd5o1CroqwZzhDFyodM5zD6Keh9aW2iY2qG1shf+LyChHfaKgJ0maqC/s2?=
 =?us-ascii?Q?f8Rqje3IWl5/BE+YS/qNqfqlY5bt9F2pqk247kEFzcRf3ZIVHI4QDwal7mvZ?=
 =?us-ascii?Q?3TA7Wsnm4kTVZ3CNiIS0PK4Xq1Dot7kB13GDZQmbDskk0QPodqcI66ZX3My2?=
 =?us-ascii?Q?bSHdxTaNneKWFTnlP4dUVROI2kP0w4QAn1VhP0siLrZc/D633LqBtqeYzITf?=
 =?us-ascii?Q?Zw2Ve5LJeMrhxOF584X6xqbUZCt6AyCsrFNAikVxvZWFuaO/Qk6JI3MPz51A?=
 =?us-ascii?Q?rOfAIn8P2EZjJyKMxAg13FUtZuzuXczqDrcQp+VEWScxeCx+r9jEhjP8kTBG?=
 =?us-ascii?Q?pGB9LDPMGK7tn3DZWTcE76aH3BFb/uAEfeUZrfw1iElWd7Hdp7fhWUoHEfLN?=
 =?us-ascii?Q?9U3HbZbXfE1ZL11tfnqCoMaCoL3zEqsBLlq1StNH8yPXkyxKa93QPp0ruuVT?=
 =?us-ascii?Q?m0ycM23Trn+/lD6kMgj685zW5HsntmnmP0nGZXSOTsdLqmkUXFuXnzTjX92g?=
 =?us-ascii?Q?Lx5Ep8fP/S6iMbh9YS9yWjDGxiPmS9k9pPHT5wTclFfYLBBCjNhQgNrSAQQA?=
 =?us-ascii?Q?Fqq5mkDAJmlejmqXK4WX4neUQoZuGzQa5GlyUF2Km+U6L33v7PdEpT01OIZR?=
 =?us-ascii?Q?4eCUXxws+/K7V8B3g4VW38Rkbg2d/f+nKhi46GFejh55YsEstgPpc/Q0lcKA?=
 =?us-ascii?Q?ftAe1YRm2+Jwa+8+SwU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 06:36:50.9235 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acb452c9-d5c0-4de6-69d1-08ddffebbd03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6550
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

For saving switch state, check if the GPU is having SWUS/DS
architecture. Otherwise, skip saving.

Reported-by: Roman Elshin <roman.elshin@gmail.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4602
Fixes: 1dd2fa0e00f1 ("drm/amdgpu: Save and restore switch state")
Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 23 ++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 58287a006b87..562c5d7b8cfb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -7171,28 +7171,35 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
 
 static void amdgpu_device_cache_switch_state(struct amdgpu_device *adev)
 {
-	struct pci_dev *parent = pci_upstream_bridge(adev->pdev);
+	struct pci_dev *swus, *swds;
 	int r;
 
-	if (!parent || parent->vendor != PCI_VENDOR_ID_ATI)
+	swds = pci_upstream_bridge(adev->pdev);
+	if (!swds || swds->vendor != PCI_VENDOR_ID_ATI ||
+	    pci_pcie_type(swds) != PCI_EXP_TYPE_DOWNSTREAM)
+		return;
+	swus = pci_upstream_bridge(swds);
+	if (!swus ||
+	    (swus->vendor != PCI_VENDOR_ID_ATI &&
+	     swus->vendor != PCI_VENDOR_ID_AMD) ||
+	    pci_pcie_type(swus) != PCI_EXP_TYPE_UPSTREAM)
 		return;
 
 	/* If already saved, return */
 	if (adev->pcie_reset_ctx.swus)
 		return;
 	/* Upstream bridge is ATI, assume it's SWUS/DS architecture */
-	r = pci_save_state(parent);
+	r = pci_save_state(swds);
 	if (r)
 		return;
-	adev->pcie_reset_ctx.swds_pcistate = pci_store_saved_state(parent);
+	adev->pcie_reset_ctx.swds_pcistate = pci_store_saved_state(swds);
 
-	parent = pci_upstream_bridge(parent);
-	r = pci_save_state(parent);
+	r = pci_save_state(swus);
 	if (r)
 		return;
-	adev->pcie_reset_ctx.swus_pcistate = pci_store_saved_state(parent);
+	adev->pcie_reset_ctx.swus_pcistate = pci_store_saved_state(swus);
 
-	adev->pcie_reset_ctx.swus = parent;
+	adev->pcie_reset_ctx.swus = swus;
 }
 
 static void amdgpu_device_load_switch_state(struct amdgpu_device *adev)
-- 
2.49.0

