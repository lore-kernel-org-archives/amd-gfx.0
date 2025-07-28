Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A94C83F26
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jul 2025 17:37:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5E4510E0D4;
	Mon, 28 Jul 2025 17:37:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4NqQrC9l";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4CD510E0D4
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jul 2025 17:37:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oXJgsgR4cfiSmhzjyQbnq5l73ZmktiqjzEd8GhRpwB/gxHLN+3mG82XWBlAlyhlEhC7HYkY67v6xXoSW8zkWyqpG5mk+fVbGwBPLUVyFmnFwP6RmF//JPm4jlONzPsPPUgmjwLpJO/bL0Ppp0sV1R3/UVtRBKbPUgaTZh6U3/LAuT8J74XqbrDpKH05RPuCw/UWftlV8ijcEDGb1eoV9+xUWFy+JUCFETX8mKV4Qxdk/z+2hzNQGUNC68kHwMCb+VliZAQXD8HvsDNJyigxDeRjZCgcW+OvvNWwNL/btt/Ufvssf9xbV7CBNLeKoHRD6f41/MRY5bOa0m4NidQxeDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=etia/ZGxU59dlLQUAy2MoX6EK7zKNTQZX+g6tlwRYvA=;
 b=CD0wYQeVgZOarntxjQTFVuZeZR0dQnmn77Cp2u7FYe+EfOEkq0R2F7IlsVoSAmzxdneV9Dyk/4GmAgz1wpSDaVTQ/Zac9To9wBUatOK5sdBD2CT3epBzu+7tdr3esdGeA9C1Vg6THppBopEu/n4nWVN4MwvwKDpZ9NZUJ1zIHoA/7UQv9blMROU6P+RKP+gemiFXwwQgAl4ImwDPTXWmH5+qpA4MFoeCNsRiT9yw14naLeddSjiZZvnX4p6SLZCx+0V0+ks82cPEN/g5f9Sz3nrHGYuRgERZVvrmbJwDd33Vl9Pym3A9+2JakZ2QWBQctXWwicIpDzgNdXznxwtjWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etia/ZGxU59dlLQUAy2MoX6EK7zKNTQZX+g6tlwRYvA=;
 b=4NqQrC9lbf2LZH11792EkC3qrJqVY6Wdg/fqKrVdzfuKRSVL8miPn5ymLqA/v2A6wGR2Y7Zra3XWxP8dBo1UMFAaE/j8sFpu9PBinoTkZEC8KsGIcuMkYTbAgHbiUkw2J2Q/Ked+ycX94SYEo56e6WAHEz0wjCT034x1/TktsFk=
Received: from BN9PR03CA0757.namprd03.prod.outlook.com (2603:10b6:408:13a::12)
 by DS0PR12MB7995.namprd12.prod.outlook.com (2603:10b6:8:14e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Mon, 28 Jul
 2025 17:37:50 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:408:13a:cafe::70) by BN9PR03CA0757.outlook.office365.com
 (2603:10b6:408:13a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.26 via Frontend Transport; Mon,
 28 Jul 2025 17:37:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Mon, 28 Jul 2025 17:37:49 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Jul
 2025 12:37:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] Documentation: update APU and dGPU tables with MP0/1 info
Date: Mon, 28 Jul 2025 13:37:32 -0400
Message-ID: <20250728173733.27723-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|DS0PR12MB7995:EE_
X-MS-Office365-Filtering-Correlation-Id: 44298014-cc97-4878-7870-08ddcdfd791e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8gki4J84SW0Vsp9NR7u8+T5Md8cIYmuTU3gOTR5GyczsPmA/xaLAMfNOI4KW?=
 =?us-ascii?Q?/i1ggNN0bvOz3LJYzNu0UptZsmbk/xqhk1Smy8ffv6QHKVnsSPyVqNvtGBF9?=
 =?us-ascii?Q?yZ9uTHdm3lrwux/OaWA/gDP3c86SpE69kFzoNvBoGZ6xMS13oIebKMhJnfmk?=
 =?us-ascii?Q?tdezYZh2TN8nLSS43IvExbX3owwfFRLXOAcD6a8I5s2uF3MBiB2H7oPcdtF8?=
 =?us-ascii?Q?Q1mQn93blX4yN8FRaugJn27fU2X1bJsqQW8QlG0n9s/7LgDJlumEh5H1v19u?=
 =?us-ascii?Q?QK6xAiGMqjtvuBq0Nv88nQj5Lb4jGovuVpR277AOVQksWSiTPTVMfRAbrlwJ?=
 =?us-ascii?Q?/Av/LUPOhThe1p9KQnqnRpqOaYovNanC2AjdyrNvxfbdeCQDCkD4eKYyvgSj?=
 =?us-ascii?Q?boK4fQqoaQaM4NSR7UvLrd6xSH+xboXzfXq1gSftK9zKEhI5Mv/oGPpVgMvY?=
 =?us-ascii?Q?Q5klEP/MEcVp0XrkRoKz16Em87UH7DN+saR6wYAOx/QP+ZPGWKApZAqiSTPL?=
 =?us-ascii?Q?pbjQEu0BACbiVVqXl7R3wopvwiIx1pvIUTN1oWG/aWEj+niz6YAk2tKEbbjh?=
 =?us-ascii?Q?3SGnDh+gwmguHek9r4JwTqoqU1kL4tUpLrTe8GSuI9EHbkOvuYP3h8cBrH6G?=
 =?us-ascii?Q?dWbASeMIfeVit9bFXJHYokFfhIWiCM01FuhfPRkI94bhEcNSysyTo4TvcrLI?=
 =?us-ascii?Q?nVajDxSuOsQ3S9pr6fCRt7gnJgfShndwauMmND2w/vhzsIQHwFsSFpiwLjZE?=
 =?us-ascii?Q?ML4AOa/8lbiRc0UEYuH9zCcFldlAhiunkGvREkF0HSXK/TauFOgq7MbJ6UM5?=
 =?us-ascii?Q?EcQNzZiDZAY1YEkEbvTFuSx7K7/IIKc+MP92P43LMA+mWEVAcdTUWf0cnFck?=
 =?us-ascii?Q?oON6ESjxFSV46t5n/aw/rQ53nqWqENUFrrN2exbp2Zo4dQ6LK+JmA+r34N5Y?=
 =?us-ascii?Q?ltx8MzzaZmygwC8TO6X1rk+bmeZ21rIULVNybqA1b0ushbSNbS+FfgChbMxT?=
 =?us-ascii?Q?3SZXtAGj1ciZSiAC1beLoNSEs+MYrdP0X5vF+oa4Itm6EeoNHwlgmrudPTbu?=
 =?us-ascii?Q?BmybHPL8PIONrAZOk9uKIDcWLWZr9ECIFKNKWLO4q1jWSFTQYmIn7aObgVOx?=
 =?us-ascii?Q?pxyk5XzfScOiApHMcltxpSSYkW4nPHlY8LcKedxvLpmrzgqOhUcqn0tPCzPI?=
 =?us-ascii?Q?2ir6TOlPbRo8LMpHAVnry5frTa7MFqXeVeTtuBxOMQOIAyCDaTdhvWf8LeSG?=
 =?us-ascii?Q?n5ClqEvT6mCo3Tr0oHxdqrZWO9EA+XLmk0aSmOkge6T37mrFNlAEzzwZY/CK?=
 =?us-ascii?Q?LPSJm+4VNRu5TgAcpYRqqOmHJC4u1RLytlwN6V4hEiNi6eB2dAb8HYDyAC+d?=
 =?us-ascii?Q?C5xoc/FJFbjkiAiuuuS80aESgqoHeSYs0OM9Tb2IkZS7JLZvg/7k5PACdpIg?=
 =?us-ascii?Q?zESQaoVQ+b0OnDd3fWm/rn9LB9QBftGm0eqNR26tk4MfHqn7qceAwg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 17:37:49.8510 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44298014-cc97-4878-7870-08ddcdfd791e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7995
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

Add MP1 for APUs and MP0 and MP1 details for dGPUs.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3905
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/amdgpu/amd-hardware-list-info.rst     |  4 +-
 .../gpu/amdgpu/apu-asic-info-table.csv        | 34 +++++------
 .../gpu/amdgpu/dgpu-asic-info-table.csv       | 56 +++++++++----------
 3 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/Documentation/gpu/amdgpu/amd-hardware-list-info.rst b/Documentation/gpu/amdgpu/amd-hardware-list-info.rst
index 1786544fe7c11..e72f4ff770c45 100644
--- a/Documentation/gpu/amdgpu/amd-hardware-list-info.rst
+++ b/Documentation/gpu/amdgpu/amd-hardware-list-info.rst
@@ -10,7 +10,7 @@ Accelerated Processing Units (APU) Info
 
 .. csv-table::
    :header-rows: 1
-   :widths: 3, 2, 2, 1, 1, 1, 1
+   :widths: 3, 2, 2, 1, 1, 1, 1, 1
    :file: ./apu-asic-info-table.csv
 
 Discrete GPU Info
@@ -18,6 +18,6 @@ Discrete GPU Info
 
 .. csv-table::
    :header-rows: 1
-   :widths: 3, 2, 2, 1, 1, 1
+   :widths: 3, 2, 2, 1, 1, 1, 1, 1
    :file: ./dgpu-asic-info-table.csv
 
diff --git a/Documentation/gpu/amdgpu/apu-asic-info-table.csv b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
index 1d50b539677f0..b479c5629146f 100644
--- a/Documentation/gpu/amdgpu/apu-asic-info-table.csv
+++ b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
@@ -1,17 +1,17 @@
-Product Name, Code Reference, DCN/DCE version, GC version, VCE/UVD/VCN version, SDMA version, MP0 version
-Radeon R* Graphics, CARRIZO/STONEY, DCE 11, 8, VCE 3 / UVD 6, 3, n/a
-Ryzen 3000 series / AMD Ryzen Embedded V1*/R1* with Radeon Vega Gfx, RAVEN/PICASSO, DCN 1.0, 9.1.0, VCN 1.0, 4.1.0, 10.0.0
-Ryzen 4000 series, RENOIR, DCN 2.1, 9.3, VCN 2.2, 4.1.2, 11.0.3
-Ryzen 3000 series / AMD Ryzen Embedded V1*/R1* with Radeon Vega Gfx, RAVEN2, DCN 1.0, 9.2.2, VCN 1.0.1, 4.1.1, 10.0.1
-SteamDeck, VANGOGH, DCN 3.0.1, 10.3.1, VCN 3.1.0, 5.2.1, 11.5.0
-Ryzen 5000 series / Ryzen 7x30 series, GREEN SARDINE / Cezanne / Barcelo / Barcelo-R, DCN 2.1, 9.3, VCN 2.2, 4.1.1, 12.0.1
-Ryzen 6000 series / Ryzen 7x35 series / Ryzen 7x36 series, YELLOW CARP / Rembrandt / Rembrandt-R, 3.1.2, 10.3.3, VCN 3.1.1, 5.2.3, 13.0.3
-Ryzen 7000 series (AM5), Raphael, 3.1.5, 10.3.6, 3.1.2, 5.2.6, 13.0.5
-Ryzen 9000 series (AM5), Granite Ridge, 3.1.5, 10.3.6, 3.1.2, 5.2.6, 13.0.5
-Ryzen 7x45 series (FL1), Dragon Range, 3.1.5, 10.3.6, 3.1.2, 5.2.6, 13.0.5
-Ryzen 7x20 series, Mendocino, 3.1.6, 10.3.7, 3.1.1, 5.2.7, 13.0.8
-Ryzen 7x40 series, Phoenix, 3.1.4, 11.0.1 / 11.0.4, 4.0.2, 6.0.1, 13.0.4 / 13.0.11
-Ryzen 8x40 series, Hawk Point, 3.1.4, 11.0.1 / 11.0.4, 4.0.2, 6.0.1, 13.0.4 / 13.0.11
-Ryzen AI 300 series, Strix Point, 3.5.0, 11.5.0, 4.0.5, 6.1.0, 14.0.0
-Ryzen AI 350 series, Krackan Point, 3.5.0, 11.5.2, 4.0.5, 6.1.2, 14.0.4
-Ryzen AI Max 300 series, Strix Halo, 3.5.1, 11.5.1, 4.0.6, 6.1.1, 14.0.1
+Product Name, Code Reference, DCN/DCE version, GC version, VCE/UVD/VCN version, SDMA version, MP0 version, MP1 version
+Radeon R* Graphics, CARRIZO/STONEY, DCE 11, 8, VCE 3 / UVD 6, 3, n/a, 8
+Ryzen 3000 series / AMD Ryzen Embedded V1*/R1* with Radeon Vega Gfx, RAVEN/PICASSO, DCN 1.0, 9.1.0, VCN 1.0, 4.1.0, 10.0.0, 10.0.0
+Ryzen 4000 series, RENOIR, DCN 2.1, 9.3, VCN 2.2, 4.1.2, 11.0.3, 12.0.1
+Ryzen 3000 series / AMD Ryzen Embedded V1*/R1* with Radeon Vega Gfx, RAVEN2, DCN 1.0, 9.2.2, VCN 1.0.1, 4.1.1, 10.0.1, 10.0.1
+SteamDeck, VANGOGH, DCN 3.0.1, 10.3.1, VCN 3.1.0, 5.2.1, 11.5.0, 11.5.0
+Ryzen 5000 series / Ryzen 7x30 series, GREEN SARDINE / Cezanne / Barcelo / Barcelo-R, DCN 2.1, 9.3, VCN 2.2, 4.1.1, 12.0.1, 12.0.1
+Ryzen 6000 series / Ryzen 7x35 series / Ryzen 7x36 series, YELLOW CARP / Rembrandt / Rembrandt-R, 3.1.2, 10.3.3, VCN 3.1.1, 5.2.3, 13.0.3, 13.0.3
+Ryzen 7000 series (AM5), Raphael, 3.1.5, 10.3.6, 3.1.2, 5.2.6, 13.0.5, 13.0.5
+Ryzen 9000 series (AM5), Granite Ridge, 3.1.5, 10.3.6, 3.1.2, 5.2.6, 13.0.5, 13.0.5
+Ryzen 7x45 series (FL1), Dragon Range, 3.1.5, 10.3.6, 3.1.2, 5.2.6, 13.0.5, 13.0.5
+Ryzen 7x20 series, Mendocino, 3.1.6, 10.3.7, 3.1.1, 5.2.7, 13.0.8, 13.0.8
+Ryzen 7x40 series, Phoenix, 3.1.4, 11.0.1 / 11.0.4, 4.0.2, 6.0.1, 13.0.4 / 13.0.11, 13.0.4 / 13.0.11
+Ryzen 8x40 series, Hawk Point, 3.1.4, 11.0.1 / 11.0.4, 4.0.2, 6.0.1, 13.0.4 / 13.0.11, 13.0.4 / 13.0.11
+Ryzen AI 300 series, Strix Point, 3.5.0, 11.5.0, 4.0.5, 6.1.0, 14.0.0, 14.0.0
+Ryzen AI 350 series, Krackan Point, 3.5.0, 11.5.2, 4.0.5, 6.1.2, 14.0.4, 14.0.4
+Ryzen AI Max 300 series, Strix Halo, 3.5.1, 11.5.1, 4.0.6, 6.1.1, 14.0.1, 14.0.1
diff --git a/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv b/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv
index d2f10ee69dfcb..0f822a252fcb3 100644
--- a/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv
+++ b/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv
@@ -1,28 +1,28 @@
-Product Name, Code Reference, DCN/DCE version, GC version, VCN version, SDMA version
-AMD Radeon (TM) HD 8500M/ 8600M /M200 /M320 /M330 /M335 Series, HAINAN, --,  6, --, --
-AMD Radeon HD 7800 /7900 /FireGL Series, TAHITI, DCE 6, 6, VCE 1 / UVD 3, --
-AMD Radeon R7 (TM|HD) M265 /M370 /8500M /8600 /8700 /8700M, OLAND, DCE 6, 6, VCE 1 / UVD 3, --
-AMD Radeon (TM) (HD|R7) 7800 /7970 /8800 /8970 /370/ Series, PITCAIRN, DCE 6, 6, VCE 1 / UVD 3, --
-AMD Radeon (TM|R7|R9|HD) E8860 /M360 /7700 /7800 /8800 /9000(M) /W4100 Series, VERDE, DCE 6, 6, VCE 1 / UVD 3, --
-AMD Radeon HD M280X /M380 /7700 /8950 /W5100, BONAIRE, DCE 8, 7, VCE 2 / UVD 4.2, 1
-AMD Radeon (R9|TM) 200 /390 /W8100 /W9100 Series, HAWAII, DCE 8, 7, VCE 2 / UVD 4.2, 1
-AMD Radeon (TM) R(5|7) M315 /M340 /M360, TOPAZ, *, 8, --, 2
-AMD Radeon (TM) R9 200 /380 /W7100 /S7150 /M390 /M395 Series, TONGA, DCE 10, 8, VCE 3 / UVD 5, 3
-AMD Radeon (FirePro) (TM) R9 Fury Series, FIJI, DCE 10, 8, VCE 3 / UVD 6, 3
-Radeon RX 470 /480 /570 /580 /590 Series - AMD Radeon (TM) (Pro WX) 5100 /E9390 /E9560 /E9565 /V7350 /7100 /P30PH, POLARIS10, DCE 11.2, 8, VCE 3.4 / UVD 6.3, 3
-Radeon (TM) (RX|Pro WX) E9260 /460 /V5300X /550 /560(X) Series, POLARIS11, DCE 11.2, 8, VCE 3.4 / UVD 6.3, 3
-Radeon (RX/Pro) 500 /540(X) /550 /640 /WX2100 /WX3100 /WX200 Series, POLARIS12, DCE 11.2, 8, VCE 3.4 / UVD 6.3, 3
-Radeon (RX|TM) (PRO|WX) Vega /MI25 /V320 /V340L /8200 /9100 /SSG MxGPU, VEGA10, DCE 12, 9.0.1, VCE 4.0.0 / UVD 7.0.0, 4.0.0
-AMD Radeon (Pro) VII /MI50 /MI60, VEGA20, DCE 12, 9.4.0, VCE 4.1.0 / UVD 7.2.0, 4.2.0
-MI100, ARCTURUS, *, 9.4.1, VCN 2.5.0, 4.2.2
-MI200 Series, ALDEBARAN, *, 9.4.2, VCN 2.6.0, 4.4.0
-MI300 Series, AQUA_VANJARAM, *, 9.4.3, VCN 4.0.3, 4.4.2
-AMD Radeon (RX|Pro) 5600(M|XT) /5700 (M|XT|XTB) /W5700, NAVI10, DCN 2.0.0, 10.1.10, VCN 2.0.0, 5.0.0
-AMD Radeon (Pro) 5300 /5500XTB/5500(XT|M) /W5500M /W5500, NAVI14, DCN 2.0.0, 10.1.1, VCN 2.0.2, 5.0.2
-AMD Radeon RX 6800(XT) /6900(XT) /W6800, SIENNA_CICHLID, DCN 3.0.0, 10.3.0, VCN 3.0.0, 5.2.0
-AMD Radeon RX 6700 XT / 6800M / 6700M, NAVY_FLOUNDER, DCN 3.0.0, 10.3.2, VCN 3.0.0, 5.2.2
-AMD Radeon RX 6600(XT) /6600M /W6600 /W6600M, DIMGREY_CAVEFISH, DCN 3.0.2, 10.3.4, VCN 3.0.16, 5.2.4
-AMD Radeon RX 6500M /6300M /W6500M /W6300M, BEIGE_GOBY, DCN 3.0.3, 10.3.5, VCN 3.0.33, 5.2.5
-AMD Radeon RX 7900 XT /XTX, , DCN 3.2.0, 11.0.0, VCN 4.0.0, 6.0.0
-AMD Radeon RX 7800 XT, , DCN 3.2.0, 11.0.3, VCN 4.0.0, 6.0.3
-AMD Radeon RX 7600M (XT) /7700S /7600S, , DCN 3.2.1, 11.0.2, VCN 4.0.4, 6.0.2
+Product Name, Code Reference, DCN/DCE version, GC version, VCN version, SDMA version, MP0 version, MP1 version
+AMD Radeon (TM) HD 8500M/ 8600M /M200 /M320 /M330 /M335 Series, HAINAN, --,  6, --, --, --, 6
+AMD Radeon HD 7800 /7900 /FireGL Series, TAHITI, DCE 6, 6, VCE 1 / UVD 3, --, --, 6
+AMD Radeon R7 (TM|HD) M265 /M370 /8500M /8600 /8700 /8700M, OLAND, DCE 6, 6, VCE 1 / UVD 3, --, --, 6
+AMD Radeon (TM) (HD|R7) 7800 /7970 /8800 /8970 /370/ Series, PITCAIRN, DCE 6, 6, VCE 1 / UVD 3, --, --, 6
+AMD Radeon (TM|R7|R9|HD) E8860 /M360 /7700 /7800 /8800 /9000(M) /W4100 Series, VERDE, DCE 6, 6, VCE 1 / UVD 3, --, --, 6
+AMD Radeon HD M280X /M380 /7700 /8950 /W5100, BONAIRE, DCE 8, 7, VCE 2 / UVD 4.2, 1, --, 7
+AMD Radeon (R9|TM) 200 /390 /W8100 /W9100 Series, HAWAII, DCE 8, 7, VCE 2 / UVD 4.2, 1, --, 7
+AMD Radeon (TM) R(5|7) M315 /M340 /M360, TOPAZ, *, 8, --, 2, n/a, 7
+AMD Radeon (TM) R9 200 /380 /W7100 /S7150 /M390 /M395 Series, TONGA, DCE 10, 8, VCE 3 / UVD 5, 3, n/a, 7
+AMD Radeon (FirePro) (TM) R9 Fury Series, FIJI, DCE 10, 8, VCE 3 / UVD 6, 3, n/a, 7
+Radeon RX 470 /480 /570 /580 /590 Series - AMD Radeon (TM) (Pro WX) 5100 /E9390 /E9560 /E9565 /V7350 /7100 /P30PH, POLARIS10, DCE 11.2, 8, VCE 3.4 / UVD 6.3, 3, n/a, 7
+Radeon (TM) (RX|Pro WX) E9260 /460 /V5300X /550 /560(X) Series, POLARIS11, DCE 11.2, 8, VCE 3.4 / UVD 6.3, 3, n/a, 7
+Radeon (RX/Pro) 500 /540(X) /550 /640 /WX2100 /WX3100 /WX200 Series, POLARIS12, DCE 11.2, 8, VCE 3.4 / UVD 6.3, 3, n/a, 7
+Radeon (RX|TM) (PRO|WX) Vega /MI25 /V320 /V340L /8200 /9100 /SSG MxGPU, VEGA10, DCE 12, 9.0.1, VCE 4.0.0 / UVD 7.0.0, 4.0.0, 9.0.0, 9.0.0
+AMD Radeon (Pro) VII /MI50 /MI60, VEGA20, DCE 12, 9.4.0, VCE 4.1.0 / UVD 7.2.0, 4.2.0, 11.0.2, 11.0.2
+MI100, ARCTURUS, *, 9.4.1, VCN 2.5.0, 4.2.2, 11.0.4, 11.0.2
+MI200 Series, ALDEBARAN, *, 9.4.2, VCN 2.6.0, 4.4.0, 13.0.2, 13.0.2
+MI300 Series, AQUA_VANJARAM, *, 9.4.3, VCN 4.0.3, 4.4.2, 13.0.6, 13.0.6
+AMD Radeon (RX|Pro) 5600(M|XT) /5700 (M|XT|XTB) /W5700, NAVI10, DCN 2.0.0, 10.1.10, VCN 2.0.0, 5.0.0, 11.0.0, 11.0.0
+AMD Radeon (Pro) 5300 /5500XTB/5500(XT|M) /W5500M /W5500, NAVI14, DCN 2.0.0, 10.1.1, VCN 2.0.2, 5.0.2, 11.0.5, 11.0.5
+AMD Radeon RX 6800(XT) /6900(XT) /W6800, SIENNA_CICHLID, DCN 3.0.0, 10.3.0, VCN 3.0.0, 5.2.0, 11.0.7, 11.0.7
+AMD Radeon RX 6700 XT / 6800M / 6700M, NAVY_FLOUNDER, DCN 3.0.0, 10.3.2, VCN 3.0.0, 5.2.2, 11.0.11, 11.0.11
+AMD Radeon RX 6600(XT) /6600M /W6600 /W6600M, DIMGREY_CAVEFISH, DCN 3.0.2, 10.3.4, VCN 3.0.16, 5.2.4, 11.0.12, 11.0.12
+AMD Radeon RX 6500M /6300M /W6500M /W6300M, BEIGE_GOBY, DCN 3.0.3, 10.3.5, VCN 3.0.33, 5.2.5, 11.0.13, 11.0.13
+AMD Radeon RX 7900 XT /XTX, , DCN 3.2.0, 11.0.0, VCN 4.0.0, 6.0.0, 13.0.0, 13.0.0
+AMD Radeon RX 7800 XT, , DCN 3.2.0, 11.0.3, VCN 4.0.0, 6.0.3, 13.0.10, 13.0.10
+AMD Radeon RX 7600M (XT) /7700S /7600S, , DCN 3.2.1, 11.0.2, VCN 4.0.4, 6.0.2, 13.0.7, 13.0.7
-- 
2.50.1

