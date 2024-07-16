Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD51C3DA61
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jul 2024 02:31:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B73610E53F;
	Tue, 16 Jul 2024 02:31:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xfPaNUZJ";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AD0E10E506
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jul 2024 02:31:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=toRpAt3rexGpg9CtPG+KwL1JKiM23abgZEsX22FhOkVVAHNV8eI1Ibly1BAllKOxcB61aSd9EVwaw4BXkGr5lhqvPzLfjl5ePN1HoCDTEXbL6IHipgvjHqD/pJ8inqIUS2dACn7CfBZpxQhq/54LqMSrPo6Cm408soyhEBagwIvg0MYTgXBlqqSapzF6VEXsc10XfSg4eJXIhXvsirv/4EGcZV8S9xR3CfO03gL+T/aaVL0BwIw/XzHS0fC9nVo0VAOzVO6W5qQ7diw+214NDJuFiePtHOsBjAGphgAjZc37sT7C9pkbrkb8y5xTdUMA/c23wu7KEc0yIBByc2FDeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7doH/JGBWbcq6L+RCEUzlr7UzQqGl2rnKEebVi1yHGM=;
 b=y7bXYWe6NYP64rtrD4J8jcprW82wLhzzK54FXjDGSP4UKqk4hnNrJoYUzo16NYkK7ceWM99AhmLHRuIJgyz3m+53Ppvg9l22G0cIStn403BDCYUW1S7mBN4+43s4rC9fqhzPJaXysMVSbqN5rpuPf2lN+iF14llkwjEKaX5u6uN+Ix+L4HIGuEvx8Q5+LOSZkqn8FaWema8aXk6izhyrOiaS4UHNz4dzhvI5kW8Rpy40XlwEW6tILG8D2JCVdwa6I8JOjx6fqhWQt/7emmOZ48Ar98xCO/AJDsnKZQbvVLyDidDM0IKQj1mMIFwT1TfZ7iUBiHFg8RSoYnhnWWKQmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7doH/JGBWbcq6L+RCEUzlr7UzQqGl2rnKEebVi1yHGM=;
 b=xfPaNUZJY/MyMBbT+NINYD/wY+mXq+tEpb/wmxDhfyJW1+vDYKJfJjx6L1Qtf9VJ2rrVGCZcc9SszQkSoJuT38460JuQ3hou4SiGC3TGXOXaInmk87lLFRhkTkHDJ+HQ3F0NlCk+8XIQTIBhn9xgWZ7TYrtga9Lv5Ob5tPesw58=
Received: from BN0PR04CA0012.namprd04.prod.outlook.com (2603:10b6:408:ee::17)
 by PH7PR12MB6441.namprd12.prod.outlook.com (2603:10b6:510:1fb::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.25; Tue, 16 Jul
 2024 02:31:52 +0000
Received: from BN2PEPF000055E0.namprd21.prod.outlook.com
 (2603:10b6:408:ee:cafe::56) by BN0PR04CA0012.outlook.office365.com
 (2603:10b6:408:ee::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Tue, 16 Jul 2024 02:31:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055E0.mail.protection.outlook.com (10.167.245.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.5 via Frontend Transport; Tue, 16 Jul 2024 02:31:52 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 21:31:51 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <Roman.Li@amd.com>, 
 <Alex.Hung@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 3/6] Documentation/gpu: Adjust DCN documentation paths
Date: Mon, 15 Jul 2024 20:27:25 -0600
Message-ID: <20240716023022.100811-6-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716023022.100811-3-Rodrigo.Siqueira@amd.com>
References: <20240716023022.100811-3-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E0:EE_|PH7PR12MB6441:EE_
X-MS-Office365-Filtering-Correlation-Id: bad2cc21-c6ea-4d74-6bec-08dca53f73d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g8Xj/bk8zx8s+j9o7FxM4kRL4hizsKjzVi+5uv10xbjlNA5ooUgFnO/u/8tF?=
 =?us-ascii?Q?clWge8CJNpyokYT+jqKA/qYhgAy22ehj2t3xB2wIo1r71mMH+m9leWQtGS1l?=
 =?us-ascii?Q?7qyKxm6Qdt8uMiKms3jBGryst+KFUGnDcdrrurIxkecVbXonq7Ekg+wXaCnx?=
 =?us-ascii?Q?1PaDU/LzEK2BwR3Rhl+UW0VLYYTzqOI6opv8cr58T07iy5izH169IZdQVsI2?=
 =?us-ascii?Q?XkMsBlEHKTsWWV1j/cfJMr1BR6c3JjDXJVVMQjoaf7XpuKQ1bRmzuTlMWpQA?=
 =?us-ascii?Q?aHWV4xWit/T6liDNtjxdQ9wvTpkK+G90vCuO76lEOwqXX2ckx+H5bLRcib5R?=
 =?us-ascii?Q?wOIlik9xLEpzdFJv1pm0VSakySa2TcpoUupNYb8QLbgMv5rDE6q8tfxb5xcP?=
 =?us-ascii?Q?f0WUXrqiecx2go1jJxtsxVmLMEH++oRKHBqiOuqfFnAmgnk9Jp8lFoJv3nKU?=
 =?us-ascii?Q?FHTfAoUwsrH48+9sWscGDNFWfWKZw3JmC+h7SMlT3JZExoBZ3vj8dy7l9a+V?=
 =?us-ascii?Q?w1p1U09PKLQeXBVsrKLxII+NROSbRdVKGzbyPIjEAReHD59PkZEA1VWpgcKb?=
 =?us-ascii?Q?6yUPMGiUgn21VdkXrujbPhbwZ06cci4vgvR+Yv/k4xpt0SE0BtwsbZECEN+v?=
 =?us-ascii?Q?rMoPURYk3syyX+QHcBGfkMypfJpeZTbKN+Sm917j+X2jt/V0+ddxvOLDgZuq?=
 =?us-ascii?Q?8B/XUKyDxzdNN3Z6aefNlQW6ez5zfvqJs2EEVEm6/APjNDvgqJ1uxhq/3bnh?=
 =?us-ascii?Q?NlC1foy1haJ3jWJvZWyCVFLZhB/2G7VXMfqVpZ6yVURVa4bVK1RHRLVjxWSR?=
 =?us-ascii?Q?cSgIRQ2gcx6PdFH9mkMZ5EDEVuB4C+r9tGaQ8Ve5iWpOoidnqJhW70KnmWQI?=
 =?us-ascii?Q?9AZjlCWj58Xg3+ohurelMtdRtTKUTgghilPiBI9IAZwr45S2Y5AsIM2hmTfH?=
 =?us-ascii?Q?ooe5YuZpFVNZgycqQEcEzam5DqsZvdyUq8O7I6zurrIdO9MbmW/GeE7rW7lL?=
 =?us-ascii?Q?vwKyTizFs3NmmN+omUCcTv6FprzE4TbWk6pGVWuWeVZomOE57rtXG7ycdY06?=
 =?us-ascii?Q?yFxbUZgLr3LH7Lt1hC7j3PMKSmpGQ0JH2RpPXkxdaxes7Xa/YexrEE9TSOm4?=
 =?us-ascii?Q?7UHkmoZGdHA+/5rcj+J2X5nJc1T2zbSY6N43o7QJl4oWrwe6YvPnYlvID4t1?=
 =?us-ascii?Q?NURqII+YeP/GVvdNsPYdUXE5ZBlq88nwGPVrhIfc9IRnAgE2wC2f5HKxYEnu?=
 =?us-ascii?Q?2k91Tm3xr2dAodR6A9n7XoHP01hKez7n6A/bGrlKHD+sHpGvEwybyyeQzksE?=
 =?us-ascii?Q?g0EgYNlyt37+9hzelY++RfmH+wAYT/UI0UG8A6sHy45cxnTTce8flaskgvRG?=
 =?us-ascii?Q?gERot/efjEDuFBLgHBEV/QZbKd/fbDKGPMPq2FKRPXyEFJaZDI3idaDUjCFA?=
 =?us-ascii?Q?1HQpaM7cuT1G+gNP6g4TNiimHyk8MvD6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 02:31:52.3835 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bad2cc21-c6ea-4d74-6bec-08dca53f73d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E0.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6441
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

When building the kernel-doc, it has the following complaints:

Documentation/gpu/amdgpu/display/dcn-blocks:23:
drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h:3: WARNING: Duplicate C
declaration, also defined at gpu/amdgpu/display/dcn-blocks:3.

Declaration is '.. c:struct:: surface_flip_registers'.

Documentation/gpu/amdgpu/display/dcn-blocks:35:
drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h:3: WARNING: Duplicate C
declaration, also defined at gpu/amdgpu/display/dcn-blocks:3.
Declaration is '.. c:struct:: surface_flip_registers'.

This error happened due to a copy-and-paste where the same file path was
duplicated multiple times to a different set of blocks. This commit
addresses this issue by using the correct file path.

Cc: Alex Deucher <alexander.deucher@amd.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 Documentation/gpu/amdgpu/display/dcn-blocks.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/gpu/amdgpu/display/dcn-blocks.rst b/Documentation/gpu/amdgpu/display/dcn-blocks.rst
index 582a5fee7f29..00bc0607e98c 100644
--- a/Documentation/gpu/amdgpu/display/dcn-blocks.rst
+++ b/Documentation/gpu/amdgpu/display/dcn-blocks.rst
@@ -8,10 +8,10 @@ and the code documentation when it is automatically generated.
 DCHUBBUB
 --------
 
-.. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+.. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
    :doc: overview
 
-.. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+.. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
    :internal:
 
 HUBP
@@ -26,10 +26,10 @@ HUBP
 DPP
 ---
 
-.. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+.. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
    :doc: overview
 
-.. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+.. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
    :internal:
 
 MPC
-- 
2.43.0

