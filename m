Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF33C54FB3
	for <amd-gfx@archiver.kernel.org>; Thu, 29 May 2025 10:03:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1741C10E72C;
	Thu, 29 May 2025 10:03:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="42JZGrUK";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDB7910E72C
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 10:03:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B60Ac/2qU15Pqlzv8Vg+JlRj2xomsJkRsBXau3aLHnJjeO6/7naHRwM5n+5cVO1KzO59WmBNM6IykkqfamqkSYB0pm+vXLlK/R0VlBEgAI3wl4MwjJIRP53pET8CVMbpEeYR1r6HoZ8pIZK7EepseqRiDQ4J57XF5Xfjnr5el43ab7+3E7OYPEphcC1eDogvYN35eDffKICuQH8owx8HEcvbd3zVRHfILMJqvDTbMHb5Onhgd4jqREYKm2wzSbC7L5F7FYaONC73amotZya9E4n2/8unRlge/Zvr5MmtjjQTtTKuCu6Jcm5vcUT8gAnlgm/b7SvAGBpAEWTI9uq+sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bh4uV3H24FBYP6yK1tC25rA2oPC7Fm6vD2ZQ/BsnSPY=;
 b=sYDjfoBb1ke+Nyf08Owy31qfjkSEk6WR8Wt+n6Zu2que/jcbLljQtHpG/pfhSSp5o/UFF2K3yCHQ/pr77DQsxw0qATincDKNAlBzaGB0kaCrzXUDcaXqg9HInZEdR5B/N6egk07Ge2cyw1ZRAeX0KHelH3rm9V3yhF+CU3h4qFnvLzw4RXlfx8gIRr/8fFhzWTvEi6c6zj+b5MVmaHQcxF1+0wIzqdAijC0/6iWAP1TAnpQdobnE1N12kyT/Pm4W7AdDYZzkefbBgjEmbyyGaHd+T6kMY2JiyaN4bd6q5yubgBT/7pkPSbes7dOQBqaz2TejPEqY4K10JvgdMTcvNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bh4uV3H24FBYP6yK1tC25rA2oPC7Fm6vD2ZQ/BsnSPY=;
 b=42JZGrUKW4W3ETGscGjkb1SglVU0LP7yWocFdel7GMPteJCYIaPh58ANfxvX5C09lu53UzdbHrl+xsIRU20LVg8BIKDc32s6Usng0j1ORXSg7sRptYsSua6CIOjVEGLRLORBwe4zwVwqfAFEaOq7AI9/IeuEzZ+scyDSqsgbb+A=
Received: from SJ0PR05CA0041.namprd05.prod.outlook.com (2603:10b6:a03:33f::16)
 by SJ2PR12MB7920.namprd12.prod.outlook.com (2603:10b6:a03:4c6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 29 May
 2025 10:03:40 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a03:33f:cafe::5) by SJ0PR05CA0041.outlook.office365.com
 (2603:10b6:a03:33f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Thu,
 29 May 2025 10:03:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 10:03:40 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 05:03:38 -0500
Received: from hjbog-srdc-17.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 29 May 2025 05:03:36 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <guoqing.zhang@amd.com>,
 <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <Owen.Zhang2@amd.com>, <Qing.Ma@amd.com>, <Lijo.Lazar@amd.com>,
 <Emily.Deng@amd.com>
Subject: [PATCH v9 4/4] drm/amdgpu: fix fence fallback timer expired error
Date: Thu, 29 May 2025 18:02:56 +0800
Message-ID: <20250529100256.754769-5-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250529100256.754769-1-guoqing.zhang@amd.com>
References: <20250529100256.754769-1-guoqing.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|SJ2PR12MB7920:EE_
X-MS-Office365-Filtering-Correlation-Id: 08a752ba-cadf-4f51-71b1-08dd9e981642
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vKJQQyJ/Izz8osBssZS1+lJQ2Bshr8+ZKQDBQkNDyZ4PMJfQD3/EWZ03gbEt?=
 =?us-ascii?Q?wVfg9Y9GjH7ZEtdKvKyvhaV0291YFwuXogzn4mJfSpS+wA1k7q7sW1NzGvvg?=
 =?us-ascii?Q?P8EHumBXWlPHXNM+ZhsyjYQfmBE3hOCpU+LkHLATet+BCIki1m/WFrPHNDCE?=
 =?us-ascii?Q?ZLjqkUR1yPqFd2jXUxbcA81WIu0wQJDTKMh+x0fN9gXPmgKOMrtdTuq9QgCB?=
 =?us-ascii?Q?j405H9K7jhywx20c5o/GHPLlnYkoZ639Zh+u3pLmRNliG130I2kxTYhT7xJC?=
 =?us-ascii?Q?d4YjM11v/fTd3flTI01WDz3AD9S62JNgIENtbL3Mqay24KiamRg2ZbtCr/WD?=
 =?us-ascii?Q?ZxwFWud3BKq31tsVjHWRHYfdPOvftOOPjE0in6mdwHQojB+KEuTwEZzD2pXq?=
 =?us-ascii?Q?VX3IoTnN25C2xqyBPtKSerhdxpMaCdDi6nmPA+hmGqMW9JWH+fuWbM0MWgKv?=
 =?us-ascii?Q?H5DytKz/ytqdSTo47kOFwwBtamQ7KKeCs9ram/Q4P4OxQ7rRgvkwdP0XI1MF?=
 =?us-ascii?Q?h65WIEo+An7QRSi7PMcolimMbHY2euxmQ3/LrFn6wvgGTCAjSojjIXVzFw3a?=
 =?us-ascii?Q?pdfPvSCTWcP68f8MdHPyTTTPCEGzIQfeKSCN0akmZfR0S42ZC0gBhqMNUt/+?=
 =?us-ascii?Q?L5jFOjXpGG6zd+yv2IBwZca4xfxA9HKig74wzA2wQSYOGotnC1I/mt2zdPji?=
 =?us-ascii?Q?EN5P09dq2SaJtIeyMEOEULn/ZrkqE8FQN3h8vV1RpuDaCJHlmrMb9XBlDbBr?=
 =?us-ascii?Q?Mvmv+5picMfvg7DTey+BmJ6LtUxcLX9tpm8sL80+halTLdXduMTx+YYWo2eb?=
 =?us-ascii?Q?Q/4WkC/OvPLk7SI/ObnXTypbHgtwWW6jI1SIw8CthR7O0W92fCOhoXQ/E38G?=
 =?us-ascii?Q?Jxxy03UI1Ksn4vXBX5ShxaNy28uR2rg4I2Hg3SxFR2Vr/qBsDHrJKLFvTOjr?=
 =?us-ascii?Q?gPWEAatlCvCvK6GzR/UrXcx74CpPYgxBQ0ytWSunFrZh6Lq/lSMAihmEC1Ta?=
 =?us-ascii?Q?/I8RvxeCnANq1UYzU78PITzsmH9QHDj08E0kCU5m5fviSDelkmCLBKkzHb0+?=
 =?us-ascii?Q?dWI5z8JTCgSbla8SiWO0svD9oAgiTh5WxSa5BiyejE9asD7Yre3XGhgaAgZJ?=
 =?us-ascii?Q?k2Mww/FCjyXBc+UfIh7LSS410P9QdyH9tWdLoE4x9LROgszavj9veM5hp9m0?=
 =?us-ascii?Q?pkwsVMNomWMy8Sf/y4+a4p3mO7KYHt/BWPHHvJHtZ9+JXg0yBS4QVhLTwuzm?=
 =?us-ascii?Q?nq5Td/d/WcDpQlVDO4jxLjl+0G+vCd1epUpMMV58uJawfDj/dThLQ8sgCjap?=
 =?us-ascii?Q?G10D3uyWFsajJATeN/F/05Sa1x638fz/PDPxeUbDx8E8rh2muoiWpfoQb3K+?=
 =?us-ascii?Q?ojnKyhweDBxjjDc8PeL02/aBgJEIr0wppjH9rDa5Q+k/0D5xjcZHW9YbUk6P?=
 =?us-ascii?Q?US7E469jlYXXX5WNx9XakhwM/1RmThDwjmHT84GsfP3LQj6L9FxU1HMyvf9g?=
 =?us-ascii?Q?xHs7IXDNxqmTz/EDK2jT+q09oIDYX2x4BDt+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 10:03:40.0892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a752ba-cadf-4f51-71b1-08dd9e981642
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7920
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

IH is not working after switching a new gpu index for the first time.

During VM resume, QEMU programming of VF MSIX table (register GFXMSIX_VECT0_ADDR_LO)
may not work.The access could be blocked by nBIF protection as VF isn't in
exclusive access mode. Exclusive access is enabled now, disable/enable MSIX
so that QEMU reprograms MSIX table.

call amdgpu_restore_msix on resume to restore msix table.

Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c    | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h    | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0246a33b90af..f67bc9a52d53 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5051,6 +5051,13 @@ static inline int amdgpu_virt_resume(struct amdgpu_device *adev)
 	int r;
 	unsigned int prev_physical_node_id = adev->gmc.xgmi.physical_node_id;
 
+	/* During VM resume, QEMU programming of VF MSIX table (register GFXMSIX_VECT0_ADDR_LO)
+	 * may not work. The access could be blocked by nBIF protection as VF isn't in
+	 * exclusive access mode. Exclusive access is enabled now, disable/enable MSIX
+	 * so that QEMU reprograms MSIX table.
+	 */
+	amdgpu_restore_msix(adev);
+
 	r = adev->gfxhub.funcs->get_xgmi_info(adev);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 0e890f2785b1..f080354efec8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -245,7 +245,7 @@ static bool amdgpu_msi_ok(struct amdgpu_device *adev)
 	return true;
 }
 
-static void amdgpu_restore_msix(struct amdgpu_device *adev)
+void amdgpu_restore_msix(struct amdgpu_device *adev)
 {
 	u16 ctrl;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
index aef5c216b191..f52bd7e6d988 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
@@ -149,5 +149,6 @@ void amdgpu_irq_gpu_reset_resume_helper(struct amdgpu_device *adev);
 int amdgpu_irq_add_domain(struct amdgpu_device *adev);
 void amdgpu_irq_remove_domain(struct amdgpu_device *adev);
 unsigned amdgpu_irq_create_mapping(struct amdgpu_device *adev, unsigned src_id);
+void amdgpu_restore_msix(struct amdgpu_device *adev);
 
 #endif
-- 
2.43.5

