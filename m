Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0859BFA0C42
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2026 07:44:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FAF710E112;
	Wed, 15 Apr 2026 07:44:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AV/vdEzV";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010011.outbound.protection.outlook.com [52.101.201.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9072310E112
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2026 07:44:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vyD83dIE1kxkuJB9nWBC2xVXUo5rhn6mSS82TJYO2kXSlZYSCO/wqPAAW0oeLXzhg1ycrWgnMajV32OrbSq/SdSjpAnlPUcqqz9KjMF0qQZtEMLOpC7KmQXhPswKbOtJIqpNhtWEpxUZCZ79+NxJ7NcVfQ4ojXPy8h0jZ7EAYnERy7R4AdGCxnwRIFhDHn2ecwVp6bJ4PLgpKkgbonOoo59eLgwSk1uEi9DhU4fi0l8WiG+qY1B540ZG905OhJZwzSQReLJvp+B2uaKBAES1BE72op9W8krGmKcE/2BtPyyjbp/LE0ob1g02B98K0MVCKkYQqIhSopZbs8xfvl0m1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8qjL/j647ttkT8vOZ//vE3laVv1x5GS922MgMSvhG0=;
 b=oG6n/81lZXY7gdJWZ/dTr79aUepnb/tit1h01lsq1BrBfdJI5hIadhVj4sWlXfKiEh6/sW1Z6aLLbGqGTaceVFEQAbrg52amekWfFfPACJD97cnphtfxaCVuY2aoQuYXkLtSuF+SgPP9W7Ib+rqC72lCqmlRg6FzDsAESJNYZI/Y3FIKWlj+97LSyRvydK2FuX/9SqFzU3bwJMcDyc49zYCUjqBHUx0KEw4ukQZ1ue7AVz3HyvCnNbM1YrWhnbcxhI1Qb9ZlxgjDUsWTvpez/tJvN6ot09G4MlSAhPJcbsnCL9Q6AIQC+dbGz20+8QnnhPTv6zao3suw59h58kWLCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8qjL/j647ttkT8vOZ//vE3laVv1x5GS922MgMSvhG0=;
 b=AV/vdEzVpBxcKz39amOCyn7Nn8LpruXBzNmMBY4ibuj+KMuTRThh8L4AUqvoTsnapHKyH5ZtWZe29VRzzhDq3GQ1W9LQdM5ZBwWNo0+jufpchYDnN1w6ZCEV8N7qksJ4m3MbfjHbDCisgOgFl+I0eZp2JRahA/9v/t2NJMD8oBs=
Received: from DM6PR11CA0036.namprd11.prod.outlook.com (2603:10b6:5:190::49)
 by BL3PR12MB6402.namprd12.prod.outlook.com (2603:10b6:208:3b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.15; Wed, 15 Apr
 2026 07:44:34 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:5:190:cafe::ea) by DM6PR11CA0036.outlook.office365.com
 (2603:10b6:5:190::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.50 via Frontend Transport; Wed,
 15 Apr 2026 07:44:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 07:44:33 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 15 Apr
 2026 02:44:33 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 15 Apr
 2026 02:44:33 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 15 Apr 2026 02:44:24 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>, Taimur Hassan
 <Syed.Hassan@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>, Tom Chung
 <ChiaHsuan.Chung@amd.com>
Subject: [PATCH 19/19] drm/amd/display: Promote DC to 3.2.379
Date: Wed, 15 Apr 2026 15:39:58 +0800
Message-ID: <20260415074223.34848-20-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415074223.34848-1-chen-yu.chen@amd.com>
References: <20260415074223.34848-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|BL3PR12MB6402:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f66d21a-bdd1-405c-8f14-08de9ac2d60a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: v+PLBDsA7VBY0hfF1pIQXlojuIvEUlZi8E+LGVyzHYU0FUembeSeYGVg7aPXtE9jP3ZH+sUpUhXAfPr7BVKOoHSobQ/aO8StF1gvmj/+BMQHUJQZNVa2m1NYwAZrh4okEIYaZc6y7jdWo62STQkVVqPlP9VcPi8X+QkJv7ibH6uiz8D8nHT/kHswsL6wk+54sM81pfYLSgw07h5YPOPP5EB3+pVw32iAHlq1N5AaJ+lIhCT3Un7WCg92+5ZKAx4DwTOezuVk4uXLdc7ugVsYtgz0I+SjwW+h+GnWBrfqcdpC6hvt3qA/0FM5jlaLRvFTzQHQlC6LU4O0lt4F6zM8MRubL0FPGLUj23R+cPO0kevuhdP7gWPSDMxiiH6gxPCD98YKrCkCoD5Q/GqnqxkImhruqaUcFkvEjOPKB93pI6r6OUgB5AKfrjakchDIMS7vtq7W+rYZ7EbPa5f8A70ZV/9TVmvD6wYQrgIzwE+1yRedMMxMeakvKycR1lAyZ+Gtqz5slm4mwCo844UTOiP+F02gz1QzE4fwjE74AOri/MtgoZMIRk+HRrFcsdsjJvtmeAWPaFxuGatmSI4+Xs/QSMI7kzSRwwXa9EPabwHvLFqZhO1r/yr+ks3Ra1UoE8YfQc4CpLoyQlQB7lvcAol7jHxzWyVA2N30d9yb3y11DEXG65quD34zwVjok5a/B0huiUdyJ9TpxzijYZ7VHpUIiGq+CTH+x9+B5OHcPHgt6FS1K24nH5ee/2GJn8XMmet4PlvO6OU6zVDx87cNyohF6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wiG+j1RHSa/Mnu6DQYg4i51AMW7/QH0xpy8/6/Cr9/d9iEcliNttFTQnvlmQBFaCEcYvrX6MCGC7cSLTI1YMkA5ITZjkWXzRbIZBLbQR9/yCPlFr2SH545UAxdVdmPc5Ed2LpWqFeY6U9DbBAa6YkwR/PFlrTm99MuR7muiI4Tq6/G5zaPiIYyLZjYTwTFmf+D8rtIGTzOcNC/mcz9j+xJKU/TWjWt/Zl5P5qTXvl8SejIoM2CkF5gFXV6NCT+YnU3b7BJLfzlSo9/IU/34K5PzoRLUld/lJNi1bi3urmEos4bDP4ZJ8qg6eXMIMOX+Mx02ISziNdE8XPTB30BzeHkE6XiuyWfa+lEuoQOqzqQsbarXUZH7IJDL7eR8TRNj3MTb3/SYBJ7LddUBPHi0b4rdFm3MHkh99W202m1Sdq9UKPksmZnq1BHPMIekn/JXU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 07:44:33.7848 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f66d21a-bdd1-405c-8f14-08de9ac2d60a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6402
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

From: Taimur Hassan <Syed.Hassan@amd.com>

This version brings along the following updates:

 - Add allow_clock_gating to dcn42 dccg.
 - Bypass post csc for additional color spaces in dcn42.
 - Remove unused dml2_project.
 - Unset Replay desync error verification by default.
 - Align HWSS fast commit path with legacy path.
 - Fix implicit narrowing conversion warnings.
 - Fix double free.
 - Introduce power module on Linux.
 - Add power module on Linux.
 - Fix fpu guard warning.
 - Add Replay/PSR active check in link loss status check.
 - Remove SYMCLK F and G values from link encoder and MANUAL_FLOW_CONTROL from optc.
 - Add minimum vfp requirement.
 - Fix narrowing boundaries and eDP parser assignment.
 - Fix dml2_0 narrowing boundaries.
 - Add README.md file to DML2_0 repository.
 - Fix DPMS using partially updated pipe context.
 - Move dml2_destroy to non-FPU compilation unit.

Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
Acked-by: Tom Chung <ChiaHsuan.Chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 1b10b9770982..50ec5acb6c7b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -63,7 +63,7 @@ struct dcn_dsc_reg_state;
 struct dcn_optc_reg_state;
 struct dcn_dccg_reg_state;
 
-#define DC_VER "3.2.378"
+#define DC_VER "3.2.379"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

