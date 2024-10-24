Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3261FD0BB5E
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2024 05:49:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEEDC10E071;
	Thu, 24 Oct 2024 05:49:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oeBHDV+U";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2055.outbound.protection.outlook.com [40.107.101.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EF2210E071
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2024 05:49:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hrvIKjxXK9vONk5DGixSOM1NDT8nMXja7G/eMrZzvOIDNvvJ17WtPz0gPNZGQBgH0LU49tK0ChPJJqZ2xx5ulzjO0KgGJl3bgFjgwWNJZIny+GbbtbElpL8Mxoty+rTKUru3S/AQYnMzhlq2Vdpw1oTAY9cYHUOqIOyQYGlaX8Q4GMqpjEeQOLB0OctjYk17Npffd3s4wxQDkfCVe4WXWa8mbs9CNzhfskM18uvIuL7tN6ZlFQ12rTdg4Qf+rc/ULPrLi6xCNoZ6+lJN+aC4OtOMspUap/KBgXAKot1b7yBntu+Sbrp0ZegnCFkdftfM8ReFvnD+ypC7ih74i38q1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtj5yf8Vp/pvUc7hNA2DpedYf3nfctQ05VZ/gDu9w/8=;
 b=yWOGrG88I4h/9NC4Ss91B00iJfbtBKQA0fMxd4wEGMRlmPyqMYGu745GyfeAFooZknoD9aoL2fzyS3vNZkCf9yvi0qk7/dc59hCU1ZhW/Ung52Yjyf3U8ibM/b1o9wKRMOMyM9FycwG1d3y0SZ/m6qzCl0NUQFn4BtX88SBJnzP0qg49sIZrhL5E2NG1nz9HZHIHznXQTgNKzkanizAQCUkbfgrWu1AaqyzZEKsghqm9AFBJ6SYGZzQndFJmtPmOnY8PwUuJOVOcgfm08wKri3XaW2ESGPRyk4ru9bUfodj613dkUl4GrVy4WMdELv9rYhHCbk6TQnJh1JN8VDjanQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtj5yf8Vp/pvUc7hNA2DpedYf3nfctQ05VZ/gDu9w/8=;
 b=oeBHDV+UINL4BYssnzxnoRmLWq2XqBg6ONO0HTmqGXWjNvPIkPb92GYbdYnEaDwtWJf6bky94D1rVIi9tVQgSIrw8Ek4b+tSrrm6czZEvnme8dd2jXaaTZAHwh7RaY2GD2Wn7hpunJh/mf9a2dgHDNy4LBs9xQNzBIgOSzT1XLg=
Received: from BL1PR13CA0151.namprd13.prod.outlook.com (2603:10b6:208:2bd::6)
 by DM4PR12MB7574.namprd12.prod.outlook.com (2603:10b6:8:10e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Thu, 24 Oct
 2024 05:49:25 +0000
Received: from BL02EPF0002992A.namprd02.prod.outlook.com
 (2603:10b6:208:2bd:cafe::7a) by BL1PR13CA0151.outlook.office365.com
 (2603:10b6:208:2bd::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.5 via Frontend
 Transport; Thu, 24 Oct 2024 05:49:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992A.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Thu, 24 Oct 2024 05:49:24 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Oct
 2024 00:49:24 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Oct
 2024 00:49:23 -0500
Received: from victor-x86-02.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 24 Oct 2024 00:49:23 -0500
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Victor Zhao <Victor.Zhao@amd.com>
Subject: [PATCH] drm/amdgpu: skip pci_restore_state under sriov during device
 init
Date: Thu, 24 Oct 2024 13:49:20 +0800
Message-ID: <20241024054920.3011641-1-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992A:EE_|DM4PR12MB7574:EE_
X-MS-Office365-Filtering-Correlation-Id: dc266bd0-29d9-419e-938b-08dcf3ef9db2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bmm7K8G825ComRMOZbH0ETNn8dNzskySA7AzL53Pv+px/LKyOCuLsjEKJ4gi?=
 =?us-ascii?Q?N4+OVVNR7Rz9ABHvT03bEQjJpG39GmD+ScE8IBwr45HJMvV+he/eBVUXsF4U?=
 =?us-ascii?Q?UOCZ8UBGcfbloTzZ5g9cGduffXF+pPqyuhD0ewwojOac/5hqceQSY7EEM942?=
 =?us-ascii?Q?LWXznOrbgpyepB1KdXE2MamB9gZNOPXYzC4GHsOFATOTA2X7fIN5dnU3gz3J?=
 =?us-ascii?Q?GmaiSDbo87jqTFu0FSOCQpIkYkIeit7ShSNkexiCTcJ27IVwiGFGfu6UcH1L?=
 =?us-ascii?Q?9yVFnUO1zpHYBAJu8bgzRDWuouG8ItQjkqXFhkHB4qyjGCqCDRHSPDeGMrfZ?=
 =?us-ascii?Q?1pg/dXi2yWro9kB02TxTK4NJrlz4xyO7zi+cOY66Z2nn8Wf94+v1ePA6z5Vj?=
 =?us-ascii?Q?IAa4Bi9UvHynxC0CPtqeL3Z+z8op2Vik+fQTYC1NxpDjXTlkeJzqQNZ5hv22?=
 =?us-ascii?Q?AzzMI3cvtlvk2mJdZ+hxyf1cTEa3O2Zjap761+c35wf9LoyWBSmF4m6Omgrj?=
 =?us-ascii?Q?C2y/G1ct4U5GCwUW1ejWCqMq8gUaBmXW7G75Xg/FEWyew7ytTFeNQ0ifpPIW?=
 =?us-ascii?Q?r5Hnh+frDGm1tPSREIV2xUW5RZVl/ZhIQ3yWH7LNeA6l+qovnu+xs8aD9CRG?=
 =?us-ascii?Q?ad+ELH7VVDT/8EtAmFAAltw3TakWNDhnWV6YNJ4xDKFgrHwAuaA8LIMGCHfw?=
 =?us-ascii?Q?2m3vm1cwmjG+oPZ7sdmD1JhbzZT8jbQQA99xi3dmmzkjGsUXJL9p4mo4ZbBQ?=
 =?us-ascii?Q?f2ezCP4nmqaaZ7ahIltip09311I98eXFzsrA/UiFdZkGk70DD5jdShw0juFv?=
 =?us-ascii?Q?Wbmwh+9jRwO403U1YSwFglyqeO+XU3ds2ZHnzmwKCHGm29HlNKPzR1VCCds5?=
 =?us-ascii?Q?MTrZN+UnJGbEISaK7cgk7O7jRvhydhRYp+560z7GP1+XoimQJo5IZoTMZL2I?=
 =?us-ascii?Q?hgxrxe7kN+aWJpVlv1KBmSdX75YVC0rfP32ThA2x4nrLA+cuKp36KnvW1tpv?=
 =?us-ascii?Q?OIOcSS7pnI/Z9aoUaQ9EnoBHZZ4H44FDIiEvdJMqWPlgni77CTjCABTBWSaV?=
 =?us-ascii?Q?ZVO2S/sNTUTzDw//OBKnysGvfEpWBcSNKC9DrQOLCD+pqrqG1qq8JBKj8OGX?=
 =?us-ascii?Q?wjhwiuiWSf2+9ouwY4+/sIShH6weEP0MRgc/dYmSFp5kGD6Zy28p1NVUAhTZ?=
 =?us-ascii?Q?OeQ4v7OROss3KEktMsW+W5GfddKOXyl2BCGiSHVRHm2vMamaAnWFP39GddSv?=
 =?us-ascii?Q?YWQPc+JW+PeCod5SaMZU25PHivL9IGX13dHPAkoFPydWV0uqhPxa/sNtKcki?=
 =?us-ascii?Q?H6Jvja631Wth3a552wJBk4/7qehc/lmVz7eJsJoryjPuSM+rwiHbHXR95Pkt?=
 =?us-ascii?Q?9nqT71RHRzSaGOjLV/GouGaizmj4GxWpCWBu8VuCleCYikBfig=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 05:49:24.7445 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc266bd0-29d9-419e-938b-08dcf3ef9db2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7574
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

during device init, under sriov, pci_restore_state happens after
fullaccess released, and it can have race condition with mmio protection
enable from host side.

Since msix was toggled during pci_restore_state, if mmio protection
happens during this time, guest side msix will not be properly
programmed and leading to missing interrupts.

So skip pci_restore_state during device init.

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 6c0ff1c2ae4c..52803cd91ef5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4524,7 +4524,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		dev_err(adev->dev, "amdgpu_pmu_init failed\n");
 
 	/* Have stored pci confspace at hand for restore in sudden PCI error */
-	if (amdgpu_device_cache_pci_state(adev->pdev))
+	if (!amdgpu_sriov_vf(adev) && amdgpu_device_cache_pci_state(adev->pdev))
 		pci_restore_state(pdev);
 
 	/* if we have > 1 VGA cards, then disable the amdgpu VGA resources */
-- 
2.34.1

