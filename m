Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D298DFD88F3
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 04:03:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7123A10E2F9;
	Wed, 11 Mar 2026 04:03:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4+akMJlg";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011065.outbound.protection.outlook.com [52.101.62.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE61B10E2F9
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 04:03:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pCDJ62nBsW8+34IeNW/jPBu3ZShFurVSEVcNWJVExikUCEkTakXNWScjFliXa/dXSEddFnlxHTChsnrktCYW3PqDB9Iqb2Ax77wWe+vFI/zzZsE2kO9G2zPMI30F/f1VwdgFFj4CrbOsenFsL4y8D1o05meEJr/xuU8Zj+uOkQrPHcxULtz/oy3VvvveSHGbS6rrZ6d1qvXEOPFNmI66XCScKivSmCGOG/LgMsyhbUnpDZoY6y3wYk+uQegLTW9FFkUCTnYcIgBSu/ZjNrtuo5hkHKbRRP4CXHJCk5BNwOCZBT+eXX6n4xBt0Mh+57SBJTRPprM21K08zk/y8J4j+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1oGtj1b/WdI7yrsoKTa0lry6PjoRDgofYio1L/27jw=;
 b=ewwiDp7rPeOMzKYjvYM7BSIVexxFMcpbY39xTVP+GxykZILdMdmaoMS2ptqtW/AmFUBhRNQEDOfC3HQoa9c+NJRSNaFGWO7gmLVfjyl9GxKP4QIEjTgxO5YyQT5JrKh80duIJRC6CeReEjhhTVn6JVsqXrFQOBPWTTE43O+uvCumvBJx6/PFI2oYn6ghLrvN11v6VGbWXDZTvzQ0YcY6o5kL9HhHw4hXHbQCUiFRpzg93d8a6bjSSJdX1zNL3Nmk4p7N2FmeL6VialYA6S3m85TsxPMrKrrm/P8/HKHNwpIxM0GwpoIDQZeO2IKRC5TuuLJNE8+Zt+GS4T5XMJg4pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1oGtj1b/WdI7yrsoKTa0lry6PjoRDgofYio1L/27jw=;
 b=4+akMJlgY65fF+5ItArcysNDq26weUUyH2qUpAW2BIGsYrmnLaHvCYOvsEXasYA5XSiKCEP7BG4vVpeNHTPiHKxPJpYUOSNp2QDISlqtNU39gQSIIcP3Qf4wcv/z8KC6r0cjODhfsXPfpCOjK1IgKkv9St0aoPX5hh02bd2zAXY=
Received: from PH7PR13CA0023.namprd13.prod.outlook.com (2603:10b6:510:174::23)
 by PH7PR12MB9126.namprd12.prod.outlook.com (2603:10b6:510:2f0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 04:03:43 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:510:174:cafe::31) by PH7PR13CA0023.outlook.office365.com
 (2603:10b6:510:174::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Wed,
 11 Mar 2026 04:03:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 04:03:43 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 23:03:39 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Austin Zheng <Austin.Zheng@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH v2 2/9] drm/amd/display: Fix number of opp
Date: Wed, 11 Mar 2026 11:32:57 +0800
Message-ID: <20260311040501.2693643-3-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311040501.2693643-1-ChuanYu.Tseng@amd.com>
References: <20260311040501.2693643-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|PH7PR12MB9126:EE_
X-MS-Office365-Filtering-Correlation-Id: f7876f0e-6838-4592-f52d-08de7f232fcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4bdJrnvTTU7xlbxooLWqWf6rbQ2r1mSdtV7StwoG4HCSKDLeDDUuH9TCELCfF660nPeLLrXizR5iL1ySfxDWlJIZPOJiJ32JkIn7EQBZk0OKHEiG3oQ4AKIDVqjKoi81tAdTajT/Oc1lwP6v9r9DMcZEFSGMQeiD06SY9WP3PMv0/AhB2u7HGoGrO7TWYZfdtKdfBYAxjFmX13FE9dDxlbxqb81b/uNEbMlfDUcW/snd/fI982wfBIBderqQe4YG5HorHV8+sIguEsfmVr4AlQf06XrgUi4FFJP3PGpEoiDIzNTfoQvmJDSgaMhE1baeIYmCuCf+TmPbJDNENBIw5VpMJxgrSHf5C5Hm+U6Pq7HQ41k07OEQJdQ3UAK/obmCQ3skJ807ca6+qTUVeEMm7BsgDVXxdP+n9gxU4REtmc1LbCd2OOGPh1q98wgzliLwQGZBPZbgHFfu3ihwQlBhvc93q/ZTTf8K5w6mnPAD3GA8FpDu9KUTiizVUBq/b7K5jv115cT8AUY4V0OpBLVFAzTz/+twsrnuXO4+9V6NsG1drC4XbiHepSpMOXavWl9yB8pW/49RlTaxhPgLninD70uLW1YMESINA9IvJYtfGolmBfmv5WpafJIkfJM5a9gyWyOB3qvWkfefSkk3k1hRXl5Ho9Poy+GnOj6uY6g8hmj3ckiQrpDHscHzF4J4hDdK4ogN8VJyrXxMRdDerIQreCgUs4e74KOVekpDwLl3p0XdO+Czlnycm78CUY8XrvRMECb/62QJY9ElCz3NkeXzgw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: T5+eAqV+/MbHdfsLhPMwNUQ9FfYfrM7m6BuhARX0Naw20Z9hk4AYD93c8BcMpgDasvXayNd21GYySiA3A9q0Tyfy8ENG3Y0Dwcj4mNhUIvCPsnMtbSOEkHMRxCzKJNvPDOs4YVLv7QTUwvtVc0hTmEuCQVzS63Hxon3kc1BcwPPtqEk74QHXI2vPvsl0fktgzc8WcP1tXGD2JpqWrwTsCK4kDU39lBFlCAh/gicOUp9qitSyYxLydhMrYXUM3vPl/cgaogozM5SHIl48LTu1I0HjLLiYB5Y6BqiB7Kmvix7y5TDompqyAdglxAwdEGg9lVwYhjh+ZfB5GNl9UG6SBWR4uif3+4qzR3c9YhzuVDgI6a+R/ggkEfxv6fXbetD60NtZ8s/NpGHjK8Q9Xh9wb6l8EUfPrqjhyIbDH5DRn7ulNs4stYLxJ78ooXPZaHH+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 04:03:43.5123 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7876f0e-6838-4592-f52d-08de7f232fcc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9126
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

From: Austin Zheng <Austin.Zheng@amd.com>

[Why/How]
Patch number of opp based on IP caps

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 .../amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c   | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c
index 608b4a305c65..99fc2f0666e2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c
@@ -187,6 +187,7 @@ static void patch_ip_params_with_ip_caps(struct dml2_core_ip_params *ip_params,
 {
 	ip_params->max_num_dpp = ip_caps->pipe_count;
 	ip_params->max_num_otg = ip_caps->otg_count;
+	ip_params->max_num_opp = ip_caps->otg_count;
 	ip_params->num_dsc = ip_caps->num_dsc;
 	ip_params->max_num_dp2p0_streams = ip_caps->max_num_dp2p0_streams;
 	ip_params->max_num_dp2p0_outputs = ip_caps->max_num_dp2p0_outputs;
-- 
2.43.0

