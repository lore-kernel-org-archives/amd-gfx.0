Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A087AC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Mar 2022 21:49:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48DAD10E27A;
	Fri, 18 Mar 2022 21:49:54 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2051.outbound.protection.outlook.com [40.107.100.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35E0A10E211
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Mar 2022 21:49:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EB3fL0xPKLzo6mtgTjmBtFnrHAonGOqfsrQCKV0YcC4esEd0OHJA1GFyqtllkzqA5iOCdJc17+O2If83wB8ODRjOa4kCt22WIdqmNGIrNrIJiitPajGsntvZf8XGBfUMzxNYhUXU447pnB7R2VoCu4n7qhMEdClbSdZjHN2jiEvFDJPSLbdk94ANYWAjdgdZNBsY9pzAsLEJsf9DTzy6PXePN6Z+NESx53Cyvf/ygA8sVE+rd04eIcs/48FknNecxW883mDHPkKUT1hXf6Eanqtua1eFpqqQdkh+7F8qFftguv7+ADcGKa0FpdgBjBkTIKNm08u8ye2L3tzSBz6n/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWfBvRH9CkCMI7qONsALxkLuZYClVEs+lStWClPPqNU=;
 b=dZy98Kx9k5sm/NiWrQGpBKq6p2gmB1Kw032sQsMOY1Vp3OLOGJ/EUro8uSIbcgforzp03DX2eiI+B/8KwZjHPHMwk2J/HTirJFtPCbH2W5dQ0SKqvpbU74UOEHVS861bOxmMpm4uGbvEVmViJ8GcFilYe7Duy3i2k5WjoKs5MAmZ+bFg4ZHZWNb3zhMl/PyEEyOBsjShoKRWgNSEBr5bEfej0h+iBJzl1s5Y4BwO+bIqT6W75Ljnpn5iNRcCGDUC1GggfzNbZTlH3dTo16aEWHtnxpXjFOE0/UHrabFJ2lSznTvydUh9JVr6bNBVEYkSuLDXNguLS8o3nbyVoGJlsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWfBvRH9CkCMI7qONsALxkLuZYClVEs+lStWClPPqNU=;
 b=bQtLD+G7kdqFsgaIiMGOtDsXZFimlVZHonXShyp76YBjcik8eZu6IVH/ek1A/XrSfaSFa3IfDwV9cM/SIxzNVJEI8QpJappjT70m7ZQlyO1fbETuSGKEDoIk6P3xIGNR0FKNh0ovM1AYs5WmrZSRUFVXdlB1CO+yId2gHM9frfI=
Received: from BN9PR03CA0633.namprd03.prod.outlook.com (2603:10b6:408:13b::8)
 by DM6PR12MB3851.namprd12.prod.outlook.com (2603:10b6:5:1c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Fri, 18 Mar
 2022 21:49:50 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::70) by BN9PR03CA0633.outlook.office365.com
 (2603:10b6:408:13b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17 via Frontend
 Transport; Fri, 18 Mar 2022 21:49:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Fri, 18 Mar 2022 21:49:49 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 18 Mar
 2022 16:49:46 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/13] drm/amd/display: [FW Promotion] Release 0.0.109.0
Date: Fri, 18 Mar 2022 15:47:54 -0600
Message-ID: <20220318214800.3565679-8-alex.hung@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220318214800.3565679-1-alex.hung@amd.com>
References: <20220318214800.3565679-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ac5ba84-97af-4071-3512-08da092939ac
X-MS-TrafficTypeDiagnostic: DM6PR12MB3851:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB38519897789A6DE723999359F7139@DM6PR12MB3851.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2q3M1NEXbTFOAt66kK9eWI6Ffo3KyZCGlxPzY0yFHIFwAFYMCaptsBtiCOCKyhv5Z8CFs4vaTkdesdnhq2hhTBdphwJ8sfqSSR/4wLWlFS+4hOJtTyNS47xGVkiFXRtjuRTsO/h9N16mGTXCCC+J1+3ddcC6lj0d3VRG4g0SnYo4NfpMzn7dyRPElf+6hucAFNpEJ6q0I/uayqS1gMsVTfN959cXa09vj5Ri/JcfbFrOl0HejSyvvD/Ycxo40dv42XZ09/VsGh2J5tf3gMDgoeLvHD3lFHdYr+RsQM6wvD4PKWSqklT+WK1OHXeuqUbDpHSOXua2BFMZ8rO7XFBRXKOrUQ8X2EPcw1tr5b9/ZUR053d2TkqT5YGAHa0j8DWrg+7P9JLjdWw90dQRQ5gfuGIUf9KBO9m2KM5R4mQ6FwrlYjM/IQTkzD60b3S3wUrzC9D4wU5hw7At05NMMyCh8FMbKCjXWoKIJJTHTWzV49P8foZDyQLK0IjELL0tT3i4np6CXrFUAbn0r5rd7luNQw6tUPR3qtSIHIfCl4AqMtNtCbjWzAS7fVWDZCWz1gWHpvmhestkesc5bdUZUKWg5pKQgSFt0fDngv2aUyxHd8pphgkwUMf8OkVGtxJxxFMhFGsGugs7ORjVzp49Wx6/yCw5qDbvfjc7/gNYB/ceDIA1ZmM8hMnuHP2FUcPZ3/HRHxAiqD8oxoLcRsgXwn8MGg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(426003)(47076005)(2616005)(336012)(16526019)(4744005)(44832011)(6916009)(54906003)(26005)(186003)(36860700001)(1076003)(316002)(36756003)(81166007)(82310400004)(356005)(7696005)(2906002)(40460700003)(86362001)(8676002)(70586007)(70206006)(4326008)(6666004)(83380400001)(8936002)(508600001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 21:49:49.1461 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ac5ba84-97af-4071-3512-08da092939ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3851
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 71214c7a60fc..ce773b56a778 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -46,10 +46,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x929554ba
+#define DMUB_FW_VERSION_GIT_HASH 0x51b95a35
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 108
+#define DMUB_FW_VERSION_REVISION 109
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
-- 
2.35.1

