Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D638CCF9EE
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 17:57:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1C0B10E81E;
	Wed, 29 Oct 2025 17:57:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jXwBxt8S";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012034.outbound.protection.outlook.com [40.107.209.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25A0210E822
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 17:57:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KLZzs6Qcj79DoJhrvnIhU4fz3InwININZb4qKsDHwxer0+pc35DeSvDCv07dfLFJRlG7CY+MlVYSbu+mpBJbYXtAxeGM9cdCaxHeByItgDuPvwtyBFV4AZD4ZT3XHA02Zy9tGyE8XLVTZls1ZyA2haT8L7AbcIap0ee5BFe0LCoGmigfbkA5Lj0CKZFmKWYKObLDT+0McattI+7xlOvB56zAgaZ/1dSgg3FS9nnBXak7H3f121EtVvEwC4pWYPZqv04PDv5b+MJBRlvuFejCg3Zt+6vzeVeMS0jJ4e1k5MIz96MeBKwQh6ljo+DBHw7tGV2mU3qCKXrni1Q7cZHplg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRF3LHswK//PPZWMOzyeYzI9mGuKY7LjbEnRBkazFtc=;
 b=emPMv2CdAjfz85barXLObRHxVWIsBucbA77gcvcfSOQqXAJpgHqyZk3ZzDguuS688pIRcUSN3Kjyqmb0flf0KMCmzqGXsRVAqvNhR0ZRluU2ZBspEXYrm2jpwz9sbIrDfM1xyRAiA35EZyJVyUrz6WN/DaHvhk3nqGCGRT5bntuTY4YJYLKtsEq1Ub4KszuQP5VugwLKLweAfUAuzheWcTuiYuDNCo6+j8PMFkKw4B0XZlwL6neo9WuQIktdGzgQgYnIG81N0apUbRRbJVO7r/JXTjOhbrKhAZ6Wm+1QtGq8VCnfw/ELO/oCLCqe1+X+wBhr6L4/sTqAWoHsRA2S7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRF3LHswK//PPZWMOzyeYzI9mGuKY7LjbEnRBkazFtc=;
 b=jXwBxt8SahnLHXiJ0Cvd5fJwZ8t7yvj/cu0v9+x690k0Q376d4DyIO/H9GPqDY+rqpSPznM9KsnZz7ZLdUcOrggxVn1fnlZXCCEguz6eVvqmaNA7md1xmC2KERU1kQVfL8bhMbucRvxnlH9VWC7+P7CrRpD8fMHmyzhMM8JzTsw=
Received: from BL1PR13CA0076.namprd13.prod.outlook.com (2603:10b6:208:2b8::21)
 by DS7PR12MB6143.namprd12.prod.outlook.com (2603:10b6:8:99::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 17:57:15 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:2b8:cafe::ca) by BL1PR13CA0076.outlook.office365.com
 (2603:10b6:208:2b8::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 17:57:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 17:57:15 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 10:57:14 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Enable IH CAM on IH 7.1.0
Date: Wed, 29 Oct 2025 13:56:58 -0400
Message-ID: <20251029175658.2862310-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029175658.2862310-1-alexander.deucher@amd.com>
References: <20251029175658.2862310-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|DS7PR12MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c29f8fb-8269-4b5d-eae5-08de17149850
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7I2NCdSK0ny6ckzbiQoV2TO1DitQn/f5Vw7qTfx7qDw8NyUs5ZkAyoYG6p7k?=
 =?us-ascii?Q?3V8KrSV1Bo8hcMGkyowrkP0NJN/UEEO/RxvBiOemTJ/csdVydd738O/eBmU5?=
 =?us-ascii?Q?fyKeHPF/EBroQusJYHJpN9CqxgZGJAATdORty1kO7jNb3y4IjhmtwXJBG++D?=
 =?us-ascii?Q?EN5PjoiX/6ZIV6weWpOf6X/tAibf0Zh3FlpkB+BXPr3TEMCWHwsuUKB7mWMI?=
 =?us-ascii?Q?3wfRfxAnd3NtrCmwFFfJ5SBT9NqXy4QimrUkEZiUmKUWsaeDgHc5u8vyn/1P?=
 =?us-ascii?Q?qrUy8nQvYjta4Z1rXZPkIGYMPG+00c6Nn/A8ToWKDHxGGK+w/iZew0pXZVLA?=
 =?us-ascii?Q?nVBIjAzdYpxuXOKrps15eG+OlL0X6RTUsCDrvKOAC5y/e/rjHtB1ct178/5z?=
 =?us-ascii?Q?uEbcTk30EetBnzcl7fgUZg+9cURR1ZADeOyidMoqarePk5VMZwwCOQ4DNPSh?=
 =?us-ascii?Q?bm10D9bJAnJ38EWnSQzJg+AUWvLhjgknur0xpp0NzqrN/xs51Ryj9pUE8Xnz?=
 =?us-ascii?Q?hyr0XToE0cFIgGQCaGdNyJGKTBP69Rip7Qzr/jXq9xLZ5b6nJwsjUH3W5tSg?=
 =?us-ascii?Q?MXaU7qNMyhebmZ166P0RlCNcVGVl9Zhhl+73BRe6ToHGod+nuWkx+9o9iM1i?=
 =?us-ascii?Q?tgWn8j6PeZs/0PhcCN+Ofg2Qx6gr4eNTM5Q4pNQfXpK+mTJIae+dMmPZXkF2?=
 =?us-ascii?Q?rWOxYAFHGxMT3l3pFBgAWJ1DLnSAUS6uXV0rkvGRbdTdj0M9D3Vekwo8w1iO?=
 =?us-ascii?Q?Ci0a8OIOMI8hQIFLIm3YnFu8FrrCr/J80vapc310HJeIpnRSDZ8kb+ejpUtB?=
 =?us-ascii?Q?6IxBsjkOkBeMMhqTT6khXPWyYeVHEYyb+pA564xe0Rv+xqQ8hpmOYpZtBGkk?=
 =?us-ascii?Q?BjKk2P/KO3St7OHDTWh20wtfrK2gfFIMslNjxHs8kuHhjAa+cGzuWPo0EQKk?=
 =?us-ascii?Q?kdeykFkJak8b/eLA8uqRr7Kzxc3pSpQ2ICIacRr/E6V1kt71GmahpXby1AhH?=
 =?us-ascii?Q?D4TI3at/E+s3fU1Gpxn3r4vc2UrWbfCgqT0EgTbQ77Zb8rJB1c7RAD62qAy8?=
 =?us-ascii?Q?9FuXfu0Sxr4WDX1eRGYxz3aPZdpaJPqGbnSVanrJxPytkEwQWGn/BOmcV0Dk?=
 =?us-ascii?Q?YMcFusr0hYl/9bElm/bvVo3/Zo2/iJDHeccw0HHZ0L5TfYNdD81ZOPj2X4dU?=
 =?us-ascii?Q?31xnHxQXp6co4vWqptrBVD0V6/T/xru8zG/r4Q162SdD0wCp1Ddo9zanedsl?=
 =?us-ascii?Q?bbujLGbzU4OtFUJL4B/fOpjt/OlL4hfH0cCb1Fyg2JP6YzBnHcw1BwBJyVPb?=
 =?us-ascii?Q?mJYQp7ZqatRSOw0d6HehHuLAjqPEfhOoIPf3evPCBc7/iEHwHKRx2FIYZ7lS?=
 =?us-ascii?Q?qU+CNwunCpRBheRplbWpe8/6IBfrOepWlbQv3qb6t79EeZP3D/IcXmoL+hAa?=
 =?us-ascii?Q?HJgwjM5Q1xmeYJHknUxJlA2WPPEvAERCB0wWOnIMqQLJ9sl9uZsKWBijSrZw?=
 =?us-ascii?Q?pqy9vYAl1EFoOrysZTeRAH1A4x3rHf+S7HomHbuJkSHkaMnQotIyKCz7nklV?=
 =?us-ascii?Q?LWFPDj197MxzGCwiklg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 17:57:15.4985 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c29f8fb-8269-4b5d-eae5-08de17149850
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6143
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

From: Mukul Joshi <mukul.joshi@amd.com>

Enable IH CAM to handle retry faults on IH 7.1.0.
Also increase the soft ring size.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Philip Yang <Philip.Yang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c | 30 +++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
index b32ea4129c616..451828bf583e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
@@ -279,6 +279,16 @@ static int ih_v7_0_enable_ring(struct amdgpu_device *adev,
 	return 0;
 }
 
+static uint32_t ih_v7_0_setup_retry_doorbell(u32 doorbell_index)
+{
+	u32 val = 0;
+
+	val = REG_SET_FIELD(val, IH_DOORBELL_RPTR, OFFSET, doorbell_index);
+	val = REG_SET_FIELD(val, IH_DOORBELL_RPTR, ENABLE, 1);
+
+	return val;
+}
+
 /**
  * ih_v7_0_irq_init - init and enable the interrupt ring
  *
@@ -363,6 +373,21 @@ static int ih_v7_0_irq_init(struct amdgpu_device *adev)
 
 	pci_set_master(adev->pdev);
 
+	if (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(7, 1, 0)) {
+		/* Allocate the doorbell for IH Retry CAM */
+		adev->irq.retry_cam_doorbell_index = (adev->doorbell_index.ih + 2) << 1;
+		WREG32_SOC15(OSSSYS, 0, regIH_DOORBELL_RETRY_CAM,
+				ih_v7_0_setup_retry_doorbell(adev->irq.retry_cam_doorbell_index));
+
+		/* Enable IH Retry CAM */
+		tmp = RREG32_SOC15(OSSSYS, 0, regIH_RETRY_INT_CAM_CNTL);
+		tmp = REG_SET_FIELD(tmp, IH_RETRY_INT_CAM_CNTL, ENABLE, 1);
+		tmp = REG_SET_FIELD(tmp, IH_RETRY_INT_CAM_CNTL, CAM_SIZE, 0xF);
+		WREG32_SOC15(OSSSYS, 0, regIH_RETRY_INT_CAM_CNTL, tmp);
+
+		adev->irq.retry_cam_enabled = true;
+	}
+
 	/* enable interrupts */
 	ret = ih_v7_0_toggle_interrupts(adev, true);
 	if (ret)
@@ -542,6 +567,7 @@ static int ih_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 	int r;
 	struct amdgpu_device *adev = ip_block->adev;
 	bool use_bus_addr;
+	unsigned int sw_ring_size;
 
 	r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_IH, 0,
 			      &adev->irq.self_irq);
@@ -573,7 +599,9 @@ static int ih_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 	/* initialize ih control register offset */
 	ih_v7_0_init_register_offset(adev);
 
-	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, PAGE_SIZE, true);
+	sw_ring_size = (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(7, 1, 0)) ?
+			IH_SW_RING_SIZE : PAGE_SIZE;
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, sw_ring_size, true);
 	if (r)
 		return r;
 
-- 
2.51.0

