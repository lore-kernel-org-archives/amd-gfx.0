Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55EADC30653
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jul 2024 14:57:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0252F10EA3C;
	Thu,  4 Jul 2024 14:57:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q4nscYAR";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3CEA10EA3C
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jul 2024 14:57:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8cfXAVv4gwCe64kyPGhIgnn8uJKN6rca8/BB/BF+hgGxEavxn+fIJSO54KpsSNx0PvmYrUrXbhcqIdYEIxqvcsyog7J5g0iRrgRZZ+lVdz/ofgvTJLcyd/quIH0y8QMp1srdtm6VurJPrCQ0jpMC0kPll6cUEqbcdY5yymov/bp5Mv9PlIdOZUp0RksAsiQIJXEnFZAqmeUZIvyeg7frdby2XWgDZG2+gYJth5IeGgB9sty4apzGtZjfBR+G3NTUZRwggH7PPTcqguY0/++UiA9hXNniGqTV9wrwJ4/KT2e8qWZwmURSeEYpvbgW9OG2S7KwbUQA1JhivbsouvwPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f2iNLDD1CxM+OQnyEuPh/7toIzxf2hBc/ragMHJ/+RE=;
 b=JbTwkjTVvwbjuILXubuVgXZxEy6kEw+h2jcNZWIWDYjQ03qKe2PF0bvfoXVMBcBffRg7bK2bWzHu7VJZu4atmGoiJMpbGjw1VWfd1Eq+m5CA4xW4HSmRiFBpcnkL5pm3UNVFnf3/BEXqcsneDeTxI2wZ1eGqEHKY+6/Mq+IXc8R4EhVhqQ1K9bskHo0RomlW/rfiOanGaF7+QewkAbx+sg9AfEiS2YNf5DG5NJGOiOsTH78VY8Fy5WmkP0K7tjLxjzkLdKJ8wA4/MfD3ioaErrE/jCFnN674VJNJhTKYZ5HCbEu8pC+Ol7GKhg/sdQpup/Fcfc1zTlxf7Os/flGMRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2iNLDD1CxM+OQnyEuPh/7toIzxf2hBc/ragMHJ/+RE=;
 b=q4nscYARN+e9CdIWiYDQ0r14QFAhSASEOuXqVyh+qytKdtA27A7teI/A+hwGixmnWEIQ6aU3UEC+Q66M5ACFc4gutuCwLLHrbp+8TmUYjd0qp/H2iRYmbz7M/Pab3kjLy0y06DLF97rAXz+446jdeJkKn0i64Wq48EW3DPHpKUo=
Received: from DM6PR06CA0096.namprd06.prod.outlook.com (2603:10b6:5:336::29)
 by PH8PR12MB6844.namprd12.prod.outlook.com (2603:10b6:510:1cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Thu, 4 Jul
 2024 14:57:52 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:5:336:cafe::9c) by DM6PR06CA0096.outlook.office365.com
 (2603:10b6:5:336::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29 via Frontend
 Transport; Thu, 4 Jul 2024 14:57:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Thu, 4 Jul 2024 14:57:51 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Jul
 2024 09:57:50 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Kent Russell <kent.russell@amd.com>
Subject: [PATCH] Documentation/amdgpu: Clarify MI200 and MI300 entries
Date: Thu, 4 Jul 2024 10:57:41 -0400
Message-ID: <20240704145741.378053-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|PH8PR12MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: 45bc7fbc-aade-436f-3d22-08dc9c39ad75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Wf5AuuP2va9spC0mvBujKDRmE9t+4m2W1Q4g1jVXqcrpioCUezaqDBjF+XGP?=
 =?us-ascii?Q?sEX1610eloFjNRs+ue8rvnLwSagmZWfAjpv5GAfos4+JrErb6y0eHVTKgHhS?=
 =?us-ascii?Q?33pqG4tXcl3w5gPzceNVIE5aCttVzFd/4TVfEY2LLgp3D0ZBtp6TyIcP6bAN?=
 =?us-ascii?Q?aJtDfBL+XTxbkm+iDw1NWaGXDsZ6pFxmwk4MsQ/rfWViXLzoOPxZiV6C+C23?=
 =?us-ascii?Q?whoZdpa20Du9XKxf86QMQLKU9twkPVH7p+etlNTWgbrSMG42n8kBLRZNWR3Z?=
 =?us-ascii?Q?kEUN5r095gp44J/woWIobE6r467MPxOLcJ+1pA1qf4mzYXgqgK/+SrReJ4t3?=
 =?us-ascii?Q?Xtn5MQMTIVdpetaWQpRaEM03Ba72mUAAGp+cQ6MSiOz0okcqeutTzVlohdyC?=
 =?us-ascii?Q?PmqI5tX89XIsHxM3swfSf3XBr6RAsj69WvsEvu+jBw31ElU+zLtWUAtp5yWl?=
 =?us-ascii?Q?FRwr/e5dfGvOzETdhoHmzInz823Mmk7OM7N2EfSzEY+2BgPOGatG9NZQCdR1?=
 =?us-ascii?Q?z29qO2DIq3XW69LvsrOuuwD2/1XHriuyCVccUqN9a9USr38KL8ppxfnSb+ay?=
 =?us-ascii?Q?KyrPD6LxCPpSDN78kCNoRstFRPszzgAJsjH//ouELKimRl9lJx1XZJgqqrFl?=
 =?us-ascii?Q?fAEZeLHQWZcfrCBh3P3T/XkA251D/rfKtNCEJmE4ZUd+3qYPEhqQ9x25f8H8?=
 =?us-ascii?Q?55zDn/IfHSNoynlg6oDCxg8uXhm+xETRq8kB11iY6eDHtYj9eE23QQPst/wX?=
 =?us-ascii?Q?LgW410imi8osBA2TXBuKYEuWxL8R1BdpHdMLvBIiNiPFp4Y0AvSlQ08W6Fw0?=
 =?us-ascii?Q?SAa7HLPEXwlRuMWi7Vg9CwN9lNiNe61zPApoDGYJkzrkYIoOSNIy7Jm6qGsI?=
 =?us-ascii?Q?JLVGhGH7+D+ib0IMu9B2otaVCBGPUuhCCBUQrTPpvBR+4yAMTY6rsvPxKWeh?=
 =?us-ascii?Q?dtgxRdRvq/BaRxx2T7mt0NVFgpNcf5uD60EyFl1Tc5Qov0OmLmS8Ziz6wO/l?=
 =?us-ascii?Q?bP9DWD47RLViNsY0mkCujmLqJdhw6KpQjWTUKaMcBZBoup4C2G7pqsioCQFd?=
 =?us-ascii?Q?swnXuz6qMgpXhdHQFdwLoFIARH1aSsKk5hEu4jfoolxQMsu4mtp6W/bhrgIZ?=
 =?us-ascii?Q?sjG2ieDRhUE9D7dJRHvkazP+JdTjva3TYdxBQp+y/FJjUHJRXcmtrxay+g9a?=
 =?us-ascii?Q?aCnoluKQt1SzL0Gtu8FcXxljYn+E9Y/AgZ7i/sXVFqgq/f/DScVTtEaQuvuD?=
 =?us-ascii?Q?KGwvfTKzpkc9JHSTOZGa9rX2atNe4Uz6JaSCOIn4k/6ak45zncTr9FYP7G0Q?=
 =?us-ascii?Q?auguMRIdL1VW4dNQgUTzQ5jpPdQROnrorr4ijoWXPnChJC/v9dTMz/qLhP6R?=
 =?us-ascii?Q?HD6H/r0FVVQriOZGisu8sce3FeBdU1uzY0K00kWWAmcq/4Kbx9QSzPr2OULZ?=
 =?us-ascii?Q?iSXxe7Aj6FPtnPFvwgoQxH/js9RRtakp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 14:57:51.6040 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45bc7fbc-aade-436f-3d22-08dc9c39ad75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6844
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

Add "Series" to MI200 and MI300 to clarify that they represent the
series of cards, and to more closely match the product information
materials. This also matches other entries in this list

Also correct a typo in the MI300 codename (Vangaram->Vanjaram)

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 Documentation/gpu/amdgpu/dgpu-asic-info-table.csv | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv b/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv
index 3825f00ca9fe..d2f10ee69dfc 100644
--- a/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv
+++ b/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv
@@ -15,8 +15,8 @@ Radeon (RX/Pro) 500 /540(X) /550 /640 /WX2100 /WX3100 /WX200 Series, POLARIS12,
 Radeon (RX|TM) (PRO|WX) Vega /MI25 /V320 /V340L /8200 /9100 /SSG MxGPU, VEGA10, DCE 12, 9.0.1, VCE 4.0.0 / UVD 7.0.0, 4.0.0
 AMD Radeon (Pro) VII /MI50 /MI60, VEGA20, DCE 12, 9.4.0, VCE 4.1.0 / UVD 7.2.0, 4.2.0
 MI100, ARCTURUS, *, 9.4.1, VCN 2.5.0, 4.2.2
-MI200, ALDEBARAN, *, 9.4.2, VCN 2.6.0, 4.4.0
-MI300, AQUA_VANGARAM, *, 9.4.3, VCN 4.0.3, 4.4.2
+MI200 Series, ALDEBARAN, *, 9.4.2, VCN 2.6.0, 4.4.0
+MI300 Series, AQUA_VANJARAM, *, 9.4.3, VCN 4.0.3, 4.4.2
 AMD Radeon (RX|Pro) 5600(M|XT) /5700 (M|XT|XTB) /W5700, NAVI10, DCN 2.0.0, 10.1.10, VCN 2.0.0, 5.0.0
 AMD Radeon (Pro) 5300 /5500XTB/5500(XT|M) /W5500M /W5500, NAVI14, DCN 2.0.0, 10.1.1, VCN 2.0.2, 5.0.2
 AMD Radeon RX 6800(XT) /6900(XT) /W6800, SIENNA_CICHLID, DCN 3.0.0, 10.3.0, VCN 3.0.0, 5.2.0
-- 
2.34.1

