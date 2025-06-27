Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3F5C7EE31
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 14:34:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C90210EA38;
	Fri, 27 Jun 2025 14:34:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t7PxKVOF";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 540BB10E173
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 14:34:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jFVDsBzLcR06rw5T9P37sJ4rM9umXYoqMvXmtcHnLnsokZNIuxuGcfuRq9uCbP9/xGsYhzTt0Dw1fxiOiRpJdNbFUvbz0lR6NzoxVejCsrmUvjI4wfawAhA0qMOs3P0kmMGRin+ffz1fZyq9h3zzXENw/5gIH5SYzmxFPMNnEIsfohc0z1vKUIXfcxWCJ4YpnpohfI3qSJ/jb7X//KDZYeVqMlEY80xudvoaV2mz3T7jPIx2JbGpxn5wWsnNE6pbWy7eK74snfQpZZ49DF3Fg7bkTKbDLzQuW2M9k1AXnPugRNuzCxVRMNon4GyZqf8hfrj/odrEia+w+YYngwVzdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EoZyZrmhPzUs+wPOTaI6In6GCybDqVw8XpJB6ACQBm8=;
 b=JELgysCpJ3VVuuEW+wxnwv88lbnW6u1bgFvDQUqvigbHkMe+UA9HrvHDUdmWlZdSapjgeMucvU4jXpqSBg/6n+rk8KEFXJXtylIjziDYLB86HyRCBsjUWvHUARWWsUwYinQgMCGaR35SMjORRPy6hIDuuKdah681Ynz/yc33D9Q8Xx437bkU7YP06DmCDr26s8HEnwe5B9DNvCgZlxLxqLwBm6olXKo4HX1PMIBiSoYA6NtWzPHqc5Bsp/eLLbrrXfa9iXYppuYLjhIpGavb6gALuFhVyiAsy0jIQOKYbDq7dZlUjtJxuR1mSZrvX2wmY1M9HOt1AtpNKarD/mnDWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EoZyZrmhPzUs+wPOTaI6In6GCybDqVw8XpJB6ACQBm8=;
 b=t7PxKVOF7f9HsEz5Ah31LBN31ex5MUcoaAoq9DoDfzqFBmT0S/hXrld4b+Eh8Tt8WIlXCSlS0KPsmBLWjzZNq2BVe1I1ZwX7Pm4iKjECUwr3LBMoeRDKjD5zhmrzk2J/5iQnfgjk9PH0y8uJzJ4kDXWyGtf9dwqFUkUWxteFRwo=
Received: from BY5PR04CA0004.namprd04.prod.outlook.com (2603:10b6:a03:1d0::14)
 by DM6PR12MB4234.namprd12.prod.outlook.com (2603:10b6:5:213::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Fri, 27 Jun
 2025 14:34:08 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::cd) by BY5PR04CA0004.outlook.office365.com
 (2603:10b6:a03:1d0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.20 via Frontend Transport; Fri,
 27 Jun 2025 14:34:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 14:34:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Jun
 2025 09:34:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/6] drm/amd: add more cyan skillfish PCI ids
Date: Fri, 27 Jun 2025 10:33:37 -0400
Message-ID: <20250627143342.23856-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|DM6PR12MB4234:EE_
X-MS-Office365-Filtering-Correlation-Id: da4b7579-b357-40e6-5e61-08ddb587ac6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dv2cuRyo/G0foCVOg73h+429xU+PRuxVbX04YQAxhD6hXL8glmXhDvlLm5eq?=
 =?us-ascii?Q?CFzkGGjdw5v2XJ3s5vuHwm5Cb3PXRVxXpxUaP5nrx27lfj3R1T9NOFSO3G7w?=
 =?us-ascii?Q?Z/6kvkChB4lWggGgOmWb+OarQb12EAZxoRalCVbl/UTOOJ24chnYzmDryp4/?=
 =?us-ascii?Q?HTbkQH3wqd4MeRPRif/ixgV2Zya05T9ODU8PA7Uwmr2iBBxFcFnM4pNVM3xB?=
 =?us-ascii?Q?c/CUxJR0KPVpGIVIgtnbmc7lILGHMUUT5x3m+0+39oVSA1yEw0xbL3GRZQPu?=
 =?us-ascii?Q?ZZ7p5Nm/zXEkFkxilgAdVvbV9ZjX4NLvPj1heBfBdL07W+RvFOoz1xPVvUCH?=
 =?us-ascii?Q?V7Hy8WjX6uV8LPqOpNEie1vq3Onb850StiU6kVRv3hqPbHGLVQxtN8j8zIFD?=
 =?us-ascii?Q?HGTU5ehwxiTY6vupWX3YmF3yI3xHZzTShX0c3MAd209ie4d703yo7DjArYix?=
 =?us-ascii?Q?6Zu+PYtdOgFinsvjLOj3n3gnwU0+2JslWipnWmXkfkOMnQHwr1L53GToR/5G?=
 =?us-ascii?Q?xfymZljB89EXmfzFjhrnGPG76jY8p6Fz5v73av32lar4WjL2m+EMiS4zN/3S?=
 =?us-ascii?Q?qFKiWQ3z8oDCpjZCxD9YPT+AYMLLReLfsjIjOHyJKqxdV3D9UVokuGgXkHoH?=
 =?us-ascii?Q?0NAWB/899ZjPr4w3FrmfdRit3H8q5j8HQmPAqOEJZE1eIV6vP9xS+A9Ns3ll?=
 =?us-ascii?Q?9htMhkKadrekgZ9GEdCNkymrSB3eK1/wVVy0s8QV8M0TrxIDTX0wORgfOGEH?=
 =?us-ascii?Q?8qVwsOIu5HagpC/zmgaH+8irj8acW90clzSXP5c8O2D/WVgDnCrEY0vv/u/N?=
 =?us-ascii?Q?Js0pk7alCvQOIU69FgXpqA92m9j0BJMo4v80sZAdFCx4jaCO0wAnypDFsbbf?=
 =?us-ascii?Q?t0gshadA4shUWnaFJ/eqLUJfiTSN5jcdAs4c7wfmK8TI5fDT2SoTnvDvsnBX?=
 =?us-ascii?Q?v4m/uPuRIdHCTRVjpPgj1TDlvka8cLEIWh92OgLyDxyidlO5VZgZLkOGnhAq?=
 =?us-ascii?Q?EfgDBOx8w0muwv+A1Brh/xB8s+lF/iSky+Wxv627XCndbvb2SwtUOcHcX8vJ?=
 =?us-ascii?Q?bcj8ULFHUnn7Kt1rDyxF7WY5/PoDhzCvBHVWPII4Hx7tkTvaqS/GnUCi+zFD?=
 =?us-ascii?Q?BEjZ7dQrlUGSNQnSo+hwDjaA1ZNC9TBDTLcT3R/F9L1GZUIFdHjTguR7UQCh?=
 =?us-ascii?Q?DGtWKshvDFNhMyLkmQ+QCpW6K1yLi6xhKsoUOctgFlqKkGaIhptWkCcYnAX7?=
 =?us-ascii?Q?b79jXXtQvoPrOUYQSEc8dJ0fhRYL/VLaHgGUCgJY/XAiuU3CGP2wIl7iVZ0Q?=
 =?us-ascii?Q?uOD7Lt2rBwrwCKeJIledMmRHNoSxCPl9UdTubYUe61VtO0oUq+bDKPTskEMI?=
 =?us-ascii?Q?O9PgLjLtV+aolvXBnrAyrHdQqyNGHpuyzALJ3pPRVk1CTTTkLbX8Q/JpwUZb?=
 =?us-ascii?Q?ZYa7zWK/9q316WsGYNDAyrM7uQVzjeywyb0a+hV9z8xAWnNjWwPLa8hxP5k2?=
 =?us-ascii?Q?7M/lOYWlcM74r0gOVFoxJUZ/dX7zd3Sa+lcK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 14:34:07.3066 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da4b7579-b357-40e6-5e61-08ddb587ac6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4234
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

Add additional PCI IDs to the cyan skillfish family.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 21aea5d28a161..9a05efd80f278 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2172,6 +2172,11 @@ static const struct pci_device_id pciidlist[] = {
 	{0x1002, 0x7410, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ALDEBARAN},
 
 	/* CYAN_SKILLFISH */
+	{0x1002, 0x13DB, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_CYAN_SKILLFISH|AMD_IS_APU},
+	{0x1002, 0x13F9, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_CYAN_SKILLFISH|AMD_IS_APU},
+	{0x1002, 0x13FA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_CYAN_SKILLFISH|AMD_IS_APU},
+	{0x1002, 0x13FB, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_CYAN_SKILLFISH|AMD_IS_APU},
+	{0x1002, 0x13FC, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_CYAN_SKILLFISH|AMD_IS_APU},
 	{0x1002, 0x13FE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_CYAN_SKILLFISH|AMD_IS_APU},
 	{0x1002, 0x143F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_CYAN_SKILLFISH|AMD_IS_APU},
 
-- 
2.50.0

