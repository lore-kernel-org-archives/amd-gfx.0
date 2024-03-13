Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF305C54791
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Mar 2024 17:44:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3811910F5FB;
	Wed, 13 Mar 2024 17:44:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sxfjLjuP";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2071.outbound.protection.outlook.com [40.107.95.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB15F10F5FB
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Mar 2024 17:44:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ATkbwUe/LjeaVW91gDnFNfQXvPZ7tZ7OT2FazOEtuk6wIp6+sAkz4ZaudUIAgS0t7lEigQug0uyC0vFLv5ckg0v+sqy87DA8i1uXDEu32VSRKwlxtJ34bgGbmHsyFNUwfUFTl5bL8eMImXXbYZC7/8uD2wOEdzpVLOhuKKRv2W3BbJiV37ACUyRI7uz7lNgzvfOhTcYGMAbj3dYrNOmxcTY+v+T1kBPDo9Q5lTOlp7pgVXaXznf+TYfUcDYJjkiPjXcfPi9nMU8RGpkxj3c5O4AEvcHijePPykgBwrAkrd/xrZLgxg4U0RHW12KoXd6xKNYNwFitF+tdc/Xo1XZ3qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtNPvFGvo98I+LHf7h5CIgdxO3dPjSkx7of8Iq3DXFs=;
 b=biZSps4Q8VfHCY+Ds4XwgW+pC/PgkHejIzO/7wKAWFMmx2ldFn4WfhjYqk87k/f/EIxQ1TAfxsCq0Ggah8qHQvT/a2/X8IAlGRjASXSJZNkpn8YpY3sTFuR6e1snInP0jww8NdA6YTn+rvozwXEjICmuDr/b67v+HaUmdesq60yFLnl9y51SBDCuDLTn4tCBIolxVZ45kceOUjK8q+CbVfmpvGU6tu1fgQLHPNmAeHtzVoPDw4o1F7hKv7w9RqjVIIra0VJ6LNCmoQGycQXIi15vXEJ2PcD1qr/V6yfY6ZiphwOkHb9zeP6QeGGE0mFN6/VymjRCcTrH5gHgMNHxDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtNPvFGvo98I+LHf7h5CIgdxO3dPjSkx7of8Iq3DXFs=;
 b=sxfjLjuPDa1+Qshm1AoS9oU3gyzXi3AI9QYuAAAchBV7zHSN/dxcZESdA3p+1FMkCNcl1mfCUPFTkV44+uzb7RkoKtlJ1k4Uml8ihiyJR6kRVwjT9I4XfX6kU/3aHVBrbru6EJ48i+sdlEP3pACrpfwj+nsWaaCj9abrHfiQKVY=
Received: from BN8PR03CA0024.namprd03.prod.outlook.com (2603:10b6:408:94::37)
 by PH7PR12MB6737.namprd12.prod.outlook.com (2603:10b6:510:1a8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Wed, 13 Mar
 2024 17:44:38 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:94:cafe::b5) by BN8PR03CA0024.outlook.office365.com
 (2603:10b6:408:94::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18 via Frontend
 Transport; Wed, 13 Mar 2024 17:44:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Wed, 13 Mar 2024 17:44:38 +0000
Received: from MKM-D1-DEWAALAM.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 13 Mar
 2024 12:44:37 -0500
From: Dewan Alam <dewan.alam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, Dewan Alam <dewan.alam@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Enable IH Retry CAM by register read
Date: Wed, 13 Mar 2024 13:43:44 -0400
Message-ID: <20240313174344.2580-1-dewan.alam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|PH7PR12MB6737:EE_
X-MS-Office365-Filtering-Correlation-Id: 69fae5e3-c7b2-496f-e74b-08dc43854133
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: han8g99wkxWDrWiIXz/bK45sm5Pm1ZGJNYwkeeFKmnwhDRZIZdFpFjL+UEaH7yrsl1gvFcrPiJX0boGkrypsdvZCPdwPM0CM48Bfiif9eP9BVYV0UL2Cg/WfVPakdIxpdT4+rQlNUGdqFXfo+dGi5UE5O4Hxsv861856SQVA8z5WPYjN9TZv2vOn7uWwO1wYqOcreOLZPdtxHKWVCazInjBrZgZFVGsa1Fos7JiKT4MJLalO75iMjVNBuhEt06lmhjk9CJFA/D2EtLaxYGy1VU0/P3u7qlXgavqqjTIqb/F4/FlUPt32f3GV4wkpu+fL8TskWhas7U5zrXm3cesPCjBXKDFpdGDnKT8VKihgbxu48HaE5LrhLA3rmRS4NTO/nX03jYr3HozJGx28cEjXYsQ06LPB8Xm+LFTYEN/Da38nK8hnrURx1XP2Hlwj3WclkGqqyR04wB/rNn/FiYQhX+tboCwuq6yWmabxFGNzfs1LdUyj/edqRAOQK+wxxbKUEceGKPvz8CUfLqDNVEygF2y77rcvCB9XPGkkGZlV1kwVjsUsCOxDZm62QalNsK+ao0uGzGJmhpX6WhyqCXNCU2T3M1agCudpc70kAUnTaooyaeuotqMICHnaL668Wh2OUUFvNWmDB23o0u+tzJTahmRK3cZoUpa/uMhZMLKHdGzjDQjpJ1yYh3GiThUgGkn6+T2D2ITgigDxZi8puA4wrgtOm4GAtoF4eajzN9O3gMGn4dN/VhPWqP7aJ2thzveQ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 17:44:38.2774 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69fae5e3-c7b2-496f-e74b-08dc43854133
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6737
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

IH Retry CAM should be enabled by register reads instead of always being set to true.

Signed-off-by: Dewan Alam <dewan.alam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index b9e785846637..c330f5a88a06 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -337,13 +337,20 @@ static int vega20_ih_irq_init(struct amdgpu_device *adev)
 
 	/* Enable IH Retry CAM */
 	if (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(4, 4, 0) ||
-	    amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(4, 4, 2))
+	    amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(4, 4, 2)) {
 		WREG32_FIELD15(OSSSYS, 0, IH_RETRY_INT_CAM_CNTL_ALDEBARAN,
 			       ENABLE, 1);
-	else
+		adev->irq.retry_cam_enabled = REG_GET_FIELD(
+			RREG32_SOC15(OSSSYS, 0,
+				mmIH_RETRY_INT_CAM_CNTL_ALDEBARAN),
+				IH_RETRY_INT_CAM_CNTL_ALDEBARAN, ENABLE);
+		} else {
 		WREG32_FIELD15(OSSSYS, 0, IH_RETRY_INT_CAM_CNTL, ENABLE, 1);
-
-	adev->irq.retry_cam_enabled = true;
+		adev->irq.retry_cam_enabled = REG_GET_FIELD(
+			RREG32_SOC15(OSSSYS, 0,
+				mmIH_RETRY_INT_CAM_CNTL),
+				IH_RETRY_INT_CAM_CNTL, ENABLE);
+		}
 
 	/* enable interrupts */
 	ret = vega20_ih_toggle_interrupts(adev, true);
-- 
2.34.1

