Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86DF6C3DA59
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jul 2024 02:31:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B44610E400;
	Tue, 16 Jul 2024 02:31:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J5XSdqLh";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2069.outbound.protection.outlook.com [40.107.95.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 282DA10E400
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jul 2024 02:31:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FBK3W3EFAOYbBXiNNi2eFbUfncATZS2GKSwcXibNH5ATHq2Tl1Q+pK8wRta7lAAFTTip0NbL4wVcpFLPmtWhoR33g7M111psAn+3IobN6o8QiiaoQV8n/hGbf2/myizVElESPbL6+DarnBGPaQVfcF7aOVJDPB2uBWqzw6x4HTdpduoMKZzvZ/dB3y5d+wYvJc/FSu4DBHRNYQoOuMd9gNhLLJS4k2YS3/stqvh8W3QfM0S519IAC429Hpl0mXvW5ejLl52KIOIr9jvcsvKEVW9x/JnUWgzczgllu7t0Jn7RYu+uNLrjP4rbiywMFfx4DOkQrQrYLw2nYrvn8L9vHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EtR/46YaP1uvkGvN4TudxhaR0yN78cre7BYOHIQft1g=;
 b=R+ac1KJBVBNuddYIYkUTXCJlQ4W1Tzt7jS76HhTl7PmRj0fEoxXS+hWRZBtFHWcX72V2W/Ebcws8UuCOlXyKINR/A2C0JXS0Z8oUuktbfu/qaq5lgiX2PkVkpXXGhUHzyzpMMMOEi4IFrcq1woN2s8GTUjZHlbSBN+4XsWRQh1SuOhEyFffJsXYtGKJBrMlSLQ1sIpzx0gEmyHNHiZpEHig46OvV1x7TolmCKeY/lbSoNBUdNZavb4HUJt2y6QA8o3pue1sEtyWXmiwejglYeqmnOKvV1rnAv1NJ35Pg86pVWpjZM0FJsUxae0unvkHYybVYFYZjSNq1XH2qIsLy/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtR/46YaP1uvkGvN4TudxhaR0yN78cre7BYOHIQft1g=;
 b=J5XSdqLhWTXiQ2KNNOroZyDzj54/06yB6fsqFoedhySuyumobftH1XmrP+gk2H7pAaQtwGChW3bJ1Mk7XKRFEQMs/LaeOAiFmL6060olGIppxj6H3INWMZES/sqgCX0MOOr4AjnaNwyNphjjaRfXISHGmU/LHbHNDpDQNaPBxE4=
Received: from BN9P223CA0015.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::20)
 by DS0PR12MB7583.namprd12.prod.outlook.com (2603:10b6:8:13f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 02:31:51 +0000
Received: from BN2PEPF000055DD.namprd21.prod.outlook.com
 (2603:10b6:408:10b:cafe::c0) by BN9P223CA0015.outlook.office365.com
 (2603:10b6:408:10b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Tue, 16 Jul 2024 02:31:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DD.mail.protection.outlook.com (10.167.245.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.5 via Frontend Transport; Tue, 16 Jul 2024 02:31:51 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 21:31:49 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <Roman.Li@amd.com>, 
 <Alex.Hung@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, "Stephen
 Rothwell" <sfr@canb.auug.org.au>
Subject: [PATCH 2/6] Documentation/gpu: Remove ':export:' option from DCN
 documentation
Date: Mon, 15 Jul 2024 20:27:24 -0600
Message-ID: <20240716023022.100811-5-Rodrigo.Siqueira@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DD:EE_|DS0PR12MB7583:EE_
X-MS-Office365-Filtering-Correlation-Id: 17587bb4-1951-4799-c177-08dca53f7306
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AwNptLgPiEEaLZH7naMmfBIASW96anAqQecFASTW9iac4iN8gbd4sQd40qS6?=
 =?us-ascii?Q?E/HoayVL53iLjVqXOys/4jKaHMlVQ4q4cJAcRFLMPSjAWb7hb/xJm/quKNZ5?=
 =?us-ascii?Q?tR/VOt/E/GdgiTrworENZLP5zXG+Drvuu6QxKopkXVmX4zuhA2YLF6sE80re?=
 =?us-ascii?Q?5NbLqev/SK8C3v+9WoLtetcELWdwbufV3UuPYAnkepJnpmDrtiPswQEtG/HJ?=
 =?us-ascii?Q?awodOGUhN+kHnx1uA4+/5PhMiiyHt6c6YjPGrPXXDRx6hnauOF/1gJBF910K?=
 =?us-ascii?Q?2dL/nhxg1hAhnfusKMbYd4vjGyJpHcysaLzX7J7e9FAbBlXCj2sJzhyNJ/H9?=
 =?us-ascii?Q?2x7wwZ4YYwbyV6cvHaHzwbTMW8+/keDs9KUWXtR36HhqgB/0QDg+i6FgFIxl?=
 =?us-ascii?Q?1i2M/r0mL8+fDYAIUFE6C6RdPI31SQ1tRlgROJdN2SezScNi+SUNkADZ7Rjp?=
 =?us-ascii?Q?xqbqCgAcmUj0pOQCpWYtajdY1HDMWWbFP8y7XZlKG9FNK6VKHMLn0kCgGVfX?=
 =?us-ascii?Q?/VR3WJHdYzMVL5TxKIGFyYleEhqubQJq4bDrOSzvpFaS+JRg1lmczj8MujMB?=
 =?us-ascii?Q?C+uGcCgIwP7LfpCJ+nJcIw+uIO5dpXF3+vhtdo25S+0RM+PKiqnVhlWCtaX1?=
 =?us-ascii?Q?TvECglKBzphG85UmplR9NCxAjQ0WAuFe8kEEPVrvAnII6cJl2FQ0LtAoZiKI?=
 =?us-ascii?Q?+S6bqKadZfPWWHIx/B/mBFXaFR0hCLzZAQ1ruZzekkHvBREtKKG8aauUlA3U?=
 =?us-ascii?Q?VCf+kW4yBTSgAyroWsoXiybVCw4tnfWA84gFVZod1dzZVKg8LnW5JHGj30IW?=
 =?us-ascii?Q?Ju3IHdp/l+SNHGo1rtlraV4WjgJTPMWnDoJ69eszjJFmPvPjetfCLiBM0MqX?=
 =?us-ascii?Q?Cb/OZfNIGlaG4W0OJTWjFXsqTJvJheIakX/fX+GmhKvr9zPVpBjlLNpG84ZV?=
 =?us-ascii?Q?sRjiX+TUDmvGhZRyoSCfKIebGlaWbQeHaUjzdViHW6uaR8AR3O9ba3yAR8JX?=
 =?us-ascii?Q?XdG8qhMWPCo1LuUk4sIR7pKZ8ejaMlh6US+FEzX8o2ltFnqxwKMh/uZxzcHz?=
 =?us-ascii?Q?SpTbyOqMkLsFvtKg5bVIB5oDCwtvCgfyeffFrJUUqgPJdcimH+am1A0fOlBX?=
 =?us-ascii?Q?b/txkWE/3UPD80PFypeBuBcubiDk073rIIxD9Rok8EA1NPiIXKjZbtgxMA5N?=
 =?us-ascii?Q?yXa48uTCjBS4weO5uF4Yr6hbk+74/PRMtdKQ9fJ6mvrH3CPgzO/2k8oDmadG?=
 =?us-ascii?Q?oDXd9MdtFQyxunr8BSiCEhit7CoaOYWWzhIdLw+tvLnCIJhtmRdw0K7rTWT1?=
 =?us-ascii?Q?PrW1waOuubqW7EjJC5mThvb7kZOhzrzaiwigzMIa7pccPiJJi/Rre2rxWuST?=
 =?us-ascii?Q?Hnp3kCsiUyi35fdyUyliZyAvTzKPvCgBNFhjQs/PKLOUGYwCpT0LLY3vBkr3?=
 =?us-ascii?Q?6qRLUlRPBo9nSv9QtuINsgwgDbUg9GQG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 02:31:51.0488 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17587bb4-1951-4799-c177-08dca53f7306
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7583
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

This commit reduces, but does not fix, all the occurrences and some of
the documentation warnings related to the 'no structured comments.' This
was caused by the wrong use of the ':export:' option in the DCN
kernel-doc, so this commit drops the usage of those options.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 Documentation/gpu/amdgpu/display/dcn-blocks.rst | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/Documentation/gpu/amdgpu/display/dcn-blocks.rst b/Documentation/gpu/amdgpu/display/dcn-blocks.rst
index 118aeb9fd2b4..582a5fee7f29 100644
--- a/Documentation/gpu/amdgpu/display/dcn-blocks.rst
+++ b/Documentation/gpu/amdgpu/display/dcn-blocks.rst
@@ -11,9 +11,6 @@ DCHUBBUB
 .. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
    :doc: overview
 
-.. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
-   :export:
-
 .. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
    :internal:
 
@@ -23,9 +20,6 @@ HUBP
 .. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
    :doc: overview
 
-.. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
-   :export:
-
 .. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
    :internal:
 
@@ -35,9 +29,6 @@ DPP
 .. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
    :doc: overview
 
-.. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
-   :export:
-
 .. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
    :internal:
 
@@ -47,9 +38,6 @@ MPC
 .. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
    :doc: overview
 
-.. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
-   :export:
-
 .. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
    :internal:
 
@@ -59,9 +47,6 @@ OPP
 .. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/opp.h
    :doc: overview
 
-.. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/opp.h
-   :export:
-
 .. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/opp.h
    :internal:
 
-- 
2.43.0

