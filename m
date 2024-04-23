Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD67C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 01:59:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAB5610F7C9;
	Tue, 23 Apr 2024 01:59:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O0zBv4wj";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2076.outbound.protection.outlook.com [40.107.95.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B799C10F7C9
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 01:59:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIVMaHJ8tI7ZBBixzdm7qc5s5LQhUnqkGozY//5qz8zFCxmOgUHeoV8HrVvt9JfoTYRL9qQL4QUCrWIWWTug8QnODtF3Sg10uUPXByJbNAn65+W3aUkNzmtLzjLuOI9bMVRZqssIDleYfDT39rGBiMh4eNUysnQFDAwcyCdF0ccjW8t0vWpnehM8s818HMQ5iiVNtyt9clc8APFwVGSBouR/QfALigvnFSvJSL75PNyxUUNyKuqHBnwuLz4ykWhaS7A6mMjEO3fUcEwyelr025ZE5ebIKKFIW5QomdgTAa6TilZzwfC7oL+zoXVc4Dqgtu5mw+v357PT/O8VKBThmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5aXOWuWeG1O6thfc84d0CSYX5Ny0/ZgbuHaE37mFUI=;
 b=mRVM38N9IzFPgGJYRIsgJjFf21gWVbi5BG5eEpyg3rpwgXIY0aDRb90K5mgESf9fae9Wxttn48ucHFi0CGSkFNHAq20ZxQvPmwDfT+wPAxouX+q0AH72GPNudjyc4+jt9FRn7QwZDySixZ+63nV0qJHIz4fCcWXtwHqebuWccqWgTDIS213XL4fDqgtBp5y7NiDpMhlAi4gg03DdhAiKACU1i92e1z3SHeMgiez1tFY2pq1fWuG0bzjGvxOdQnj7VZeIRs9hqqKiSlOpaUZuKaQsZUCjxFiN6VIhoAaPaR9QmXQwIv8LRT2nVqObIXAMmkd30PHnAKH3wvPnbvdL1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5aXOWuWeG1O6thfc84d0CSYX5Ny0/ZgbuHaE37mFUI=;
 b=O0zBv4wj9+LaTyQMfWzkk7MgVqJ6zGi5XAYp7X1VJi6QQN0CcWCKA3vHSLlyVgE51335qURHryaTPsrffHOajnw/jrw/CliStHAam7+G0wnWA7RR0+uMBTmyAgjKAOEA3SgXHheEAT9krOSiSIJ9lGm98WvuPIAg1mTtoNpuQu0=
Received: from SJ0PR03CA0342.namprd03.prod.outlook.com (2603:10b6:a03:39c::17)
 by DM4PR12MB5963.namprd12.prod.outlook.com (2603:10b6:8:6a::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Tue, 23 Apr 2024 01:59:46 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:39c:cafe::bc) by SJ0PR03CA0342.outlook.office365.com
 (2603:10b6:a03:39c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Tue, 23 Apr 2024 01:59:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Tue, 23 Apr 2024 01:59:46 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 20:59:43 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Roman Li <roman.li@amd.com>, Qingqing Zhuo
 <Qingqing.Zhuo@amd.com>, Tom Chung <chiahsuan.chung@amd.com>
Subject: [PATCH] drm/amd/display: Address kdoc for 'Enable CRTC' in
 optc401_enable_crtc
Date: Tue, 23 Apr 2024 07:29:28 +0530
Message-ID: <20240423015928.1622672-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|DM4PR12MB5963:EE_
X-MS-Office365-Filtering-Correlation-Id: a35dd004-08e4-4429-5485-08dc63390d1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5Qc7gvB3u9eVmUDz28/0qq0mJXHcpdD3PuCW6El8gZvIOj9l9v2l+zv9bmMO?=
 =?us-ascii?Q?75ebp8brr13v9QtUOpWj379qdw6ACMrNwgaK7sh8PWGkyIM+Y0ROPlNyjosT?=
 =?us-ascii?Q?CkjZaKrsLJibmBVGi3BL6R3wuOzppgn6K/D/hSwJr1PvCA3RggtI1rGDNF7I?=
 =?us-ascii?Q?kEOd/DKWkZBDsmx37jUlIh9dQVQVaZVSe0vZminxECTVpv2tXtYrxoAbtI6Z?=
 =?us-ascii?Q?oh5XXEdJj/kgpgySYInoVdt/P7EKhnp1YxGTNdZ3nODf9yYDbPv9sSPwKYIG?=
 =?us-ascii?Q?wRauTJRumxRsyOFcmvOQAr5dfuZXQZPfv917d4Ixsr4p8pYkZ5TvEZq58o66?=
 =?us-ascii?Q?UhoXHR6TiyAzihfcknMVqhvPASz7BoOrVC3R/Tgaa3VDmQa29zEhYAT8J3vI?=
 =?us-ascii?Q?7e8gsNPR66fOxXJLL5bPg7/A/gQHaLbPYUT6RmsAf9tOXh1lFashM6QzLtfg?=
 =?us-ascii?Q?8MBVLh5BsIlUhpEwCbeuMsgKPDmJ69xjXbUkmIpZQGrNnd2y+n84Ngf51eGC?=
 =?us-ascii?Q?BwPYWZSm94wmbMnD8jxNFfmWZSdY8QrYSejwlw2rh5hFmytqeaWcHSYH5N6r?=
 =?us-ascii?Q?mpQCCGl7ue+AqOkn8tlpPyQPxE+kkffOSLCEoppdF0hkgVhMDpR+OzrG9frO?=
 =?us-ascii?Q?qy1DKWnE990Mz3CfHBGskIQVhGJHCWCruLrUQvUUZf1hRE5CE74O1e28ep1G?=
 =?us-ascii?Q?/u9+pc8dbkzAdYr8z9O24t3rjv81oyVfKJvcChyK9cC2nUvbJxMAxyQXzGHg?=
 =?us-ascii?Q?WwA8L4py1okbWZp8FliHqdCE5bZmxBG7TZJvdh/Obau7kAmrWh5mkEXSMMJQ?=
 =?us-ascii?Q?AxMUZNqP6Pvf6ddHA6FgOxib8kbU3IenGfN6m8+olieF3XOvbm8mVnSQYqGy?=
 =?us-ascii?Q?T+aK0/eq+DoGie3VZy8cNBYVZa1NLZ+eg5VQRmhImmHTs3UzVqO+c4EdiuW1?=
 =?us-ascii?Q?v+hTLAh0Hf5ENfHm44bVaMnRLFEIaqvWWEytF5EZO/9Sj4pPNif/qYkLs6v7?=
 =?us-ascii?Q?7RULhqB3QO9mxsa5pE8KqD8PDhrwLg6JqM5hOkE9En13jXGq25ouK5Cdnnvq?=
 =?us-ascii?Q?PJYBelA9J4JcEXXfZQp50G2ZkiuFcYGvuEUhmvGEDfmc+nziVRuQ90pNG4Ze?=
 =?us-ascii?Q?g5XcE6yziJYjae+WlurvK/gkOmN2cE+bGYQJoJaN+90I4b87j2+/2fsnfXyT?=
 =?us-ascii?Q?on7kzgWdmjfsak36SjkJfbyqDFHdREy7Tf6e0xEQM1Z3KfXirT+yUPTZ7tx5?=
 =?us-ascii?Q?D/P+FLSHh1OcS86aL1q++kaALT+cnicYHadzguMsIeF3ROkcLdC6/o58fcQU?=
 =?us-ascii?Q?9O31aMNFwUfmhuPthyvivgN3GemsOTrNzFkWHLKwWrmjXVzH90hUu9Epr/kG?=
 =?us-ascii?Q?EbOrRiM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 01:59:46.1801 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a35dd004-08e4-4429-5485-08dc63390d1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5963
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

This commit fixes the kdoc for 'Enable CRTC' in `optc401_enable_crtc`
function.

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/../display/dc/optc/dcn401/dcn401_optc.c:177: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Enable CRTC

Fixes: 96c23c8cb3fb ("drm/amd/display: Add new DCN401 sources")
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
index 3c7b0624acea..5d65d8376f50 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
@@ -174,8 +174,12 @@ static void optc401_set_h_timing_div_manual_mode(struct timing_generator *optc,
 			OTG_H_TIMING_DIV_MODE_MANUAL, manual_mode ? 1 : 0);
 }
 /**
- * Enable CRTC
- * Enable CRTC - call ASIC Control Object to enable Timing generator.
+ * optc401_enable_crtc() - Enable CRTC
+ * @optc: Pointer to the timing generator structure
+ *
+ * This function calls ASIC Control Object to enable Timing generator.
+ *
+ * Return: Always returns true
  */
 static bool optc401_enable_crtc(struct timing_generator *optc)
 {
-- 
2.34.1

