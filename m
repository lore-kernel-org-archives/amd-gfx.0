Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06EA3CA0EE4
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Aug 2025 20:05:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87CE610E4BD;
	Mon, 18 Aug 2025 20:05:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uWRq9m+l";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2082.outbound.protection.outlook.com [40.107.95.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 957C110E4BD
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 20:05:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fdxqheaj71OWGVShsUqNnNfDA6Hq6tJmLmrPSHpz4aRdyIzAAPZiUdXf+i/goYHBj4wsm+3xXBaHRaS4MbzSGCPDBSoyAu1Cvl7IP5yN62DW1v7dW/fh8XruAVampAe9XHZqXlctAd/x5taGDxtJbMB7QXkeN1R4An9MecNu7fNMUKXvaoXPZZMtlFsHQCHI1FNHt22LfXLSgUHdETMvbOXttk7UcZO1bqTMvPJZLyHaa+uGglLR+NNNLIHgr7mOTdHr51w7Qr76JmDmomUvClDkvJleSBYVSa4CChavekUY3D3NI7e5Ju3Yg5WUJv+jc11F76dg2appq2RUplac8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5ZJHNbzDl6ToOIwzZr6PLhDOh+FkMvf0cGzs9uu2sU=;
 b=CM18aa1IeYfCdANNUYW7goPAFMZpRAKdzhbKsMik9bzQu2Urp5ziP8wO1anb9/w7/mgWyck3Ze8Ok2CG2cilqrONgUjHj6wU6T7snwNzSYLz8yquqPC4EE21Ojo57L1CM+3s1ZI64wtkNprr6JbZ0of/MkNrVRRqEcxenhRPOZyL2k3iAs5DL3MQ/eZXYrCPL3w6czYMu1DlQpVNk30zzQVo6aMT14dzxkogP8sOOBQSHkepvF4mDQ83higOch/TLSwELEtUAx0IpjW9AS3aQVuCif8lpCGTKTgxrxveKd1PcQ8UeBGz8tDSlqDpvsw6HQRjkU5xawTsVqD5H1Xckw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5ZJHNbzDl6ToOIwzZr6PLhDOh+FkMvf0cGzs9uu2sU=;
 b=uWRq9m+lxWEj3GhcYsWIPMSCNtiusE1ZvojimhkOBTgb4d4EYiJIaVeyzWRMsvGAwllSbEhrU1OKS7rxn6vzFX6h9JJxhWMqEv2sV5mfpH5nLz2TwN5/Mxk2Qh6BDyyr4FBIpAhZ6edHI0CDxXLLgPFCW2Hwzkuzi12Dkc3K9AI=
Received: from SJ0PR05CA0190.namprd05.prod.outlook.com (2603:10b6:a03:330::15)
 by IA1PR12MB6529.namprd12.prod.outlook.com (2603:10b6:208:3a6::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 20:05:02 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::80) by SJ0PR05CA0190.outlook.office365.com
 (2603:10b6:a03:330::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.12 via Frontend Transport; Mon,
 18 Aug 2025 20:05:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 18 Aug 2025 20:05:01 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 15:05:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/5] drm/amd: add more cyan skillfish PCI ids
Date: Mon, 18 Aug 2025 16:04:41 -0400
Message-ID: <20250818200445.437007-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|IA1PR12MB6529:EE_
X-MS-Office365-Filtering-Correlation-Id: bf289d23-5306-4322-561f-08ddde92841a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?regQtMFBDs6QYsqYKYQvMwZVSj4Alve4F944MklpBuz0X4ALyNxlWoFlZ56x?=
 =?us-ascii?Q?/Mujjs6jyI50ktDOc6RUbFx+iLX9m8uA8PFg2yHfInH4vDVceK4Qv7QqEx7D?=
 =?us-ascii?Q?ivQlNKuYy9UF1YU8rmsJVDQQmaSRnAMnHljsqE07btdWOg0AsIq+0MB39HN0?=
 =?us-ascii?Q?ciuEzuFtdDkNH/e1GC5dMKEWXCqeywoNd+7s1zILw0z1tYg6gzoMCx0wQgjz?=
 =?us-ascii?Q?dxhP05SvhC6Fbf6RgrNptM0qskZHFCERRRaCAfNGVX0H+/Y2aadp94iYhEDx?=
 =?us-ascii?Q?Xto7CAb89IyNs8q9OHf/UG6mtmkzzergCsyGzqbC3eg3k4V++Ac4v6FQLpGw?=
 =?us-ascii?Q?pdjdd31xo/ubrL2fR0S4vYVL6Ldnw4RVUBo3HQxBKWmSGBN6cUZzWdLN5ovu?=
 =?us-ascii?Q?lCubGEmtd3tAjH6znX/Brfwc4CG3q4X3GPWyMGuicF2+FkXSR3lKf1pShCmk?=
 =?us-ascii?Q?FJPt+28J5GSgMMKFhEuO6Eekpw0o4oKllqrpJ6S1XZwvcDBQGXtGJuMcH6l3?=
 =?us-ascii?Q?hrgn1UjTaYL1zqCYbFjBmyn/UCR0QyS7DPraloCYOSldfHD42QUyPmroSy4g?=
 =?us-ascii?Q?/VAIFMTRQUc1GCxjRtfrcVq1SPvsSsUAUObxmuSSc951hGfpLWEn4cHCBCMt?=
 =?us-ascii?Q?QA3yBBtpwFZW9iX68f4SX+KhIypFQmCbA1jXwC5+3TTYjIlXbg6k84jH9heR?=
 =?us-ascii?Q?vBq5mW98+a2phigHO90MzVbezyxA98gNk2KAa2PdRGO0xskN5sy84Ze4lftG?=
 =?us-ascii?Q?ARVVSTyTSJyfxeHVQNhLd+JUbwo2CVpGtvhad49LEYB9ffriYKeLYab/hDIU?=
 =?us-ascii?Q?eUjwdM77Vr4F+i9nvVzBEXYEv5iGHjKTD1kcQk9BWIAKVRekfJ+ggPCwenz/?=
 =?us-ascii?Q?agU67sGEdjmi1yLcqyX5M9O/8ToRe16NmKrUuiZQo+b4gB/ycldnyJD3gbDt?=
 =?us-ascii?Q?uwmVSPcGUDY+ur2GGU/PVZwj1S/3oeE7KZTGJNa5ojYg3sGw3V+or1QwX7SG?=
 =?us-ascii?Q?LzT+3TwIkeJZ69QmlA/X4MY9g+DO/CwnpP2V896h67AZuGyogmuYZVklWb2Z?=
 =?us-ascii?Q?4C+DR//elDwbgIBGFWFsv/TcYD0sivHnaMJ/WDBxWFQojMb3d44YKt1lt3M0?=
 =?us-ascii?Q?bTpFKoDFtDBoNDAvDvgATbMQtxQrRLIRlQJ3HkcdvhwVJuIem/Gnr7vvAglZ?=
 =?us-ascii?Q?PLZ/t1up8bRi9ZlRg+NuClqwQLEwmfMZUTRCwq1cXOeJNBqlU4AdUW3zzifQ?=
 =?us-ascii?Q?dnEZQTDjIBJNjzyASJfuRliYzpAJKjqo0kJiUEWn7qUoSCPWK6YdUnshgFQU?=
 =?us-ascii?Q?/yFEMbdkGZW3ZdiRe79gASGx9m931rJACFbv4xrWdxrgiFGqLATfvuq0PjOJ?=
 =?us-ascii?Q?OwmnHvD752pshBAlR3KD0Tva0H8H/Xhu02Vgk2O/IM28e5MimQDD/igxs4l4?=
 =?us-ascii?Q?th0q/xjFrm1rxV51M7Tu4QQKFHduSMH5t9PeE8FYfsKC8fuk+IEq6Wnajd7E?=
 =?us-ascii?Q?RelyeVCp/kpY5kLo519LaCpD9YogpkcJ61UP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 20:05:01.8035 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf289d23-5306-4322-561f-08ddde92841a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6529
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
index 113e39cd164fd..f5252e8dceb01 100644
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
2.50.1

