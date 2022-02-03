Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7766C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Feb 2022 19:09:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 200C510E576;
	Thu,  3 Feb 2022 19:09:23 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 739EF10E26D
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Feb 2022 19:09:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmSrLcpe6Wqx4DR2laOJzdKcHCFc9D4CboiWucvzEzCWKmhz1LdDT1nWwg7/RyYDS45WV1pHaH7zDBF8xOCMgFSgp0SRZN9N7yBZ9AxN/RGJbOMXDiYViG13VU34f5Nt2IqVAPYpHDie1PgG9WalEVRZs59wMkaZk/x4ED+3RtZg0R6WctbzNeAHApT0RHu0dIV3UTNDFRYc4R0VHto2J5N5m45BsObgZybrdMpU165HD0gr9nAXQ5bcolt6eULYXn+XcvYxTIyP3svUXoT1/NWma+mRwltoljCaFQlb74A1tVvX5BtZRl6mDyTvX7aIyHyo6Kkfg6zSm1wG/AaNDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5UQpdu8wpAJfT0G7UQnA7M9LXvCOGTHLsToAtPDLbM=;
 b=XJoAKZkLAyILrqd5aA6cUq12BJqUSXbt2Tx66rC9eA3RhBJKpon99eXgvCz7ZuTOoINkHWE16HKrvgREKmAuQIuaY7edtftUWoyfAhp1ydI76g886d03VdesVVOJ61V8Vo28ziGCEizh4pq5FncuIi+Q2RqO8A+ScFoFiT8YJxwBgimurz2KhJuLydHXLpksm362smEn8VJs1nScXtIpaQ2Z5oYUmWNIU2usrfGtJY/CAed7gGVJC31QlMx7zTl3bfd08Pq+Cb++BtDfwYMOD2kdjKFfObTM4u2SBvLtv5VPDpO72Kol2yeA+oxRAW7W0rUZKnVMKOlGZru3AOqOyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5UQpdu8wpAJfT0G7UQnA7M9LXvCOGTHLsToAtPDLbM=;
 b=Vgxq4m/ur1Ke7me5xs26M3UamZv8tHMjSYdKW3MQd1opEEY4ChjDu8y3OJiN+wDelYDxDX88NW0nZ5dZeZiw9a3xtyr2ezx5ECO8ihLDur2o9yAna1SDdm7JXy3wwegwvctGX7sRN6R7mCiDUx08+4fdcWBRZiXVekMDbr2Mmtw=
Received: from MW4P223CA0026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::31)
 by SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 19:09:19 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::77) by MW4P223CA0026.outlook.office365.com
 (2603:10b6:303:80::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Thu, 3 Feb 2022 19:09:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Thu, 3 Feb 2022 19:09:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Feb
 2022 13:09:17 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: drop experimental flag on aldebaran
Date: Thu, 3 Feb 2022 14:09:05 -0500
Message-ID: <20220203190905.1476855-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c39e8ad9-274c-4e20-c8b2-08d9e748addd
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB4557F84C0CB17614E8B9EB35F7289@SA0PR12MB4557.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hR9HAPRYl9fDt/+nIBXi4ItbODXYmfs6ZwHFKKdMOwWnkhPbzXCN3xkO7apxY3JxiUkzHVlrNrI1MxY61+rjs66XQxeSre5K5OUmY4r/t0LaXC9DyDbxtrwIEEoOlSR5cjDJYgrV4Oj4L5N7woaU94TzrpIDTyGIhV4vW7TkaMIw7ybMsmHDONetTt6YXBi2txJoB3My0FSiznkB9xVKWetx8HXX9jnoa5PmyS1wQre9dGgizaPJLFzbcAYBaoPZ2hMI1pfuuZYUykhX2cY0Gk+OYnsKQOc2MLNZ6/plBB7Sr0uU3kRWKVWadF6vNvV/EdfJK6a6KtZ3mxvwIu/nZXlCZyj5mgEvwYGjhzjO192pDSvLz67brLJaMGULhTqdpkGHQ3fmANWmACQrJHRa6YscFzrRIpD2nR5+chh2zpC8uxKGVGM2R3S1LJwQejnrVpVzmS93qw9hjh9akcrS0l1M/G1PozDtuf+uh/ZklMwfHnqPxCYsbCmt3KYQHf9lK7pjPGYdmo88P1EbxQdACC+b4GkOO0uBWDTSIk3EB0+eOto8jTrdaXzxO6v/3/eoiaozcGAFbkAjRiVvX/t09FdCGcynZOTX0BHZ44ANh0HIO2yL13nKLIs0Ey8JPFdUPFGD0P3kGgBuLsVyljfQ3VRuRlkkKgOPOYcTZMxtTONGUrrnFgNGbWqVuSeqhqK0RZFc4pvgbwnQnXIVwX2kmw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(336012)(426003)(16526019)(186003)(26005)(4326008)(8676002)(1076003)(2906002)(356005)(81166007)(86362001)(36756003)(2616005)(8936002)(40460700003)(83380400001)(508600001)(316002)(70586007)(6666004)(7696005)(70206006)(47076005)(6916009)(5660300002)(82310400004)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 19:09:18.8571 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c39e8ad9-274c-4e20-c8b2-08d9e748addd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4557
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

These have been at production level for a while. Drop
the flag.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 16a47894579d..d7fff876ad13 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1916,10 +1916,10 @@ static const struct pci_device_id pciidlist[] = {
 	{0x1002, 0x73FF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_DIMGREY_CAVEFISH},
 
 	/* Aldebaran */
-	{0x1002, 0x7408, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ALDEBARAN|AMD_EXP_HW_SUPPORT},
-	{0x1002, 0x740C, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ALDEBARAN|AMD_EXP_HW_SUPPORT},
-	{0x1002, 0x740F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ALDEBARAN|AMD_EXP_HW_SUPPORT},
-	{0x1002, 0x7410, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ALDEBARAN|AMD_EXP_HW_SUPPORT},
+	{0x1002, 0x7408, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ALDEBARAN},
+	{0x1002, 0x740C, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ALDEBARAN},
+	{0x1002, 0x740F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ALDEBARAN},
+	{0x1002, 0x7410, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ALDEBARAN},
 
 	/* CYAN_SKILLFISH */
 	{0x1002, 0x13FE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_CYAN_SKILLFISH|AMD_IS_APU},
-- 
2.34.1

