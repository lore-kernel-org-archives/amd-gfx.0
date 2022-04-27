Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3CCAC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 03:01:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 314CD10F3B9;
	Wed, 27 Apr 2022 03:01:53 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C9DF10F3C0
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 03:01:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJ9B4F/FmP3Dt0wq1v8JFDwzLsW8oyFlFd0EFE3uWmLeFGDrP/+OKBi/BJb1svwNfmQ6GLTKcdULEBD+N+EFaAk8pFt33YPJ+T9Z+kX/vKYSQWs8/C7dYbl4pVWGTomuuwQiZJyi0vfQwvxPLLLrmF4b1Nq+7NvPZ0rkKcB0Wcqk8fzLNhKLJ7zQ1vDNpLQgDr7rQDhMOSy8hkswZn/EwuiLd4LDJI9AVOefny+0mgyp6ZliwRpbg6PFoN00FmV/3JUp074+1s2mJ2NTAXI+Fr6yabSWGQOeEdj+FAtjBFfIWsUftqxVR3JwfV94JZoy2z3dXqL/mknW9TAuaSQw0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKu4m2WvG1i0lLnG4MTl9XvVbMcYNpECakhQ3g9wy0M=;
 b=HnExKirCp4UFm0Iv3MVqZzQfvd5j+8+UGGdYfCKfhy/ZwhBDgRfEUundGwaZfETlCLy2jGlWCcj4KniElGfxH2A2mEg75+o0VfSbeiE92dD06gwxl4KHW+hrn0XO/tBDtXejJpPZVMugXdhB6GvpJFK6heSgOy5yxlArbFAijH66E3b1OTvBBFj32gWUh3ZDWLrFghcI6vpBDSa8RmULgWW4cPnxiY5xz3r2NJpkZvAt1klpszRhcswDFesQfjsc07vNMocSbog+aagpvAXO32QBFbyJIbdOS6NzRKEjrklGmG9RWbuTiQyGfMPm6qsrf2vlnwE+ygijGL3MUJ3nhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKu4m2WvG1i0lLnG4MTl9XvVbMcYNpECakhQ3g9wy0M=;
 b=L4SSKPQpQL3jdVLlWLDfwk5+PfrFo5BA74LrVqjm2ltiLqxlOWSxUOAP5IZu6L8NqW8RTvQxgSXCnSf/i8LVvvuMwliF8+YSogUljnrFZeRZp65P0LVrT+ci43063vmWJhGC8gvdU2fcszVo9PWLEmYPOz3I6qs/zQSmXDwe+eg=
Received: from MW4P223CA0029.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::34)
 by DM6PR12MB5536.namprd12.prod.outlook.com (2603:10b6:5:1ba::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 27 Apr
 2022 03:01:50 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::dc) by MW4P223CA0029.outlook.office365.com
 (2603:10b6:303:80::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Wed, 27 Apr 2022 03:01:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Wed, 27 Apr 2022 03:01:49 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 22:01:48 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 22:01:48 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24
 via Frontend Transport; Tue, 26 Apr 2022 22:01:43 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/8] drm/amd/display: Remove outdated register for dcn3+
Date: Wed, 27 Apr 2022 11:00:55 +0800
Message-ID: <20220427030059.1242868-5-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220427030059.1242868-1-Wayne.Lin@amd.com>
References: <20220427030059.1242868-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 822df1e9-a9d5-4042-66bd-08da27fa460b
X-MS-TrafficTypeDiagnostic: DM6PR12MB5536:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB55369CF4C691EB6EDF805BBFFCFA9@DM6PR12MB5536.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q+o7swtPLddoMOmsBTyz9op1AMoDC+ZTuMuC6M4FUnD3Bzbimbd7ghQatWjyxESW10DBCQF5SzVvSyxAjVJfJynhxevaltN4oXme4qi8qTrHciNyO+s7WPBrpEwZDs7TBXD66Y1ru8CEJKFzPzdSY8//+FyrwxCEOd9eb5PJM/3vmmPbQ2h6sGR9YpJnXojLaI3CWvDKukUl/yQz6gjx5939xxNKIfXfVlwkLr/HrRjDjzGEPctJfFGaSEKiJuBnhBfWhX31t/4nurIWYNzUkuAFZ1iPsaIAet7gpiKcPnRQyVa1fprd1nEzoySnR/YIGougxRLODZkvul4sMzUn5gUNwsIfFpInrZoXZu1efIJmNKsqrgJogBq7A3oGSI/MBIfDdZHUroVnIPF4DzLjqFAlV9Aoqt3zS+ZawESSylqBgC5M3TuKl9eC+H3ktfXIEORlVhCAH4OPNkYR+NiTxLFy1WVfsZfKuD0IlY8BBMga3sLIBL1R5/tgGAK782suDr/Ae6FsE7JjVebNH5EgGa8yIfzXEnfeLj8X+YJxl8oJ011Hua7dIf/123PC1nHajyy9hJRbGbwvHQSeP/+C768W9q9Ny7546o9sahXNz/9geUCGQTaAzpXHHKvB4VdGyyiMcv7p572k//Ombzx0CSsoWsNYxZ5eM6wTCOMJz5JmffDOdFDzDLxxsgBcLWP3PICt0tgqnQdwEiNK03kL5g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(6666004)(26005)(508600001)(40460700003)(81166007)(5660300002)(2906002)(82310400005)(36756003)(36860700001)(8936002)(7696005)(2616005)(70206006)(4326008)(70586007)(8676002)(83380400001)(356005)(1076003)(47076005)(186003)(336012)(426003)(316002)(54906003)(6916009)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 03:01:49.5087 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 822df1e9-a9d5-4042-66bd-08da27fa460b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5536
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Martin Leung <Martin.Leung@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Nevenko Stupar <Nevenko.Stupar@amd.com>, "Tse,
 Kaitlyn" <Kaitlyn.Tse@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Tse, Kaitlyn" <Kaitlyn.Tse@amd.com>

[Why & How]
Remove MPCC_OGAM_LUT_RAM_CONTROL register which is outdated.

Reviewed-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Tse Kaitlyn <Kaitlyn.Tse@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.h
index b7dc78624963..34b9cedbd012 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.h
@@ -99,11 +99,6 @@
 	SRII(MPCC_OGAM_CONTROL, MPCC_OGAM, inst),\
 	SRII(MPCC_OGAM_LUT_CONTROL, MPCC_OGAM, inst)
 
-/*
-	SRII(MPCC_OGAM_LUT_RAM_CONTROL, MPCC_OGAM, inst),\
-	SRII(MPCC_OGAM_MODE, MPCC_OGAM, inst)
-*/
-
 #define MPC_OUT_MUX_REG_LIST_DCN3_0(inst) \
 	MPC_OUT_MUX_COMMON_REG_LIST_DCN1_0(inst),\
 	SRII(CSC_MODE, MPC_OUT, inst),\
-- 
2.36.0

