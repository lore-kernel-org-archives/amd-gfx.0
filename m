Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C806C19F53
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 14:58:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDA2B10FF23;
	Mon, 29 Apr 2024 14:58:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zdfnIU1H";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4241A10FF1F
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 14:58:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MjNtPNn99wTiWvn5REZOtwt3uTKwkGrTZIBPR6M4eUZO4Qg1p1t0IKpBb3VTuwbbBUMcyRxyyfovFg5rZ6rNGg7jDp4Us04XyU5+vLR87OCGO17ufOuH8LVASiTYV/IVupsrefMGEAWhrLnfg71JmLmekO0JAKiq0NWLr67bUh7sqlvKHuqPWb3u9iX/OH56sk+NhcvgGFu6uRNrCNx/XXsu6a4xynuoJVwG98vc3unsX/ceCNfwHItkfBT0Vv4r5+neh3qbi+CExyw1Vb/IWzJ3SvjtLhN0rQbSWtBtHh7NMmRVj7od2NuAfUCUJDRDmZFEK6CIymc9AVVfFcGVog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KI0ACzoTKJAmrizaXTWO+tEizCUj1Np4Fo/ytF+t3nI=;
 b=YhKnByuMUA4Vg5wyaktyUouMjqMMalooOzezv1sbZHCAg7IuijPH1b5NOlCI7014yTZnAb5+YLNowi/7MTbAtSf/IMyzz5aC7PG8/d5A3BTkYRDuOk8EQuTREAAccFyPKFAmNv8N0RK9cDvC7rya4cWHp5IaiSdCohRqaBcag01clq/xa2Jxl0zTMgmXm26HDUBb5wnSUSWoNIzJhsgpKlprPa0RQRROGTN9MZQD9/zTao0O6CNFBiR903DR1kdd+soqoLY5ijB6X6AacPgy3+7R8JfQRaqjdSxqsZhJZHfc7n4+F4JVn4zElyM3RGcRkbIUTjpuFWCmmNADuexpqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KI0ACzoTKJAmrizaXTWO+tEizCUj1Np4Fo/ytF+t3nI=;
 b=zdfnIU1HukZdERiEPVsYpGqKPqzwTkPDumwUvgMefKcMoNRnIQvCZzu1S5r9+zc5I1XURvw2vUEAT86pxgpnWxSY/Yl3Fo0vIO06M78CHm85QCedZkvJqK+/LzY6tb0yFKeZa9iovTW3wEgyZWE+ugcrEcfH2bLZkdY3jj1r7Vg=
Received: from SJ0PR05CA0128.namprd05.prod.outlook.com (2603:10b6:a03:33d::13)
 by PH7PR12MB8427.namprd12.prod.outlook.com (2603:10b6:510:242::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 14:57:56 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::7f) by SJ0PR05CA0128.outlook.office365.com
 (2603:10b6:a03:33d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.22 via Frontend
 Transport; Mon, 29 Apr 2024 14:57:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 14:57:56 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 09:57:50 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Eric Huang <jinhuieric.huang@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 11/14] drm/amdkfd: fix NULL ptr for debugfs mqds on GFX v12
Date: Mon, 29 Apr 2024 10:57:23 -0400
Message-ID: <20240429145726.3459450-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429145726.3459450-1-alexander.deucher@amd.com>
References: <20240429145726.3459450-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|PH7PR12MB8427:EE_
X-MS-Office365-Filtering-Correlation-Id: f403f7d6-9186-4e9f-42b0-08dc685cc0ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|82310400014|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vrbpkxSwRxbfWgjzFoCJmMyGWxAo1IebVCWJilgp7Deo+8rG/tKDha0LVc6o?=
 =?us-ascii?Q?DlnUgJ9ickcs853hyb1E0SMN+FmrSz47GC/kBCkQ3GHUykPHEwSUj6+A5EZb?=
 =?us-ascii?Q?rgrObCKwJ9cPnHoXQwXEwJ9tSOnPqyujFPqivPu9u3QNPsgmUw8ja1iLl1TR?=
 =?us-ascii?Q?pRsrAXzfJbA7U8qeVQr70YmIF3TiOsDiDQTkgCP/Ailk2ihJ5ieV0Ijrs5t0?=
 =?us-ascii?Q?ma2ae5TBE2EK37OmleJVqrHX2X2z1utGG0E/dE6cfgdprCLifZ6/LM24kzbZ?=
 =?us-ascii?Q?hHd5WKXs/acbGwdWOU9S5RwmW2+kWUuKWJ22owi97dkLJHibPDJVNPQnzMm7?=
 =?us-ascii?Q?DUOrRH3Wknimd3Re2cOvY20AJ3lZbMlTfInWHyswgf1Q1pb20E2/sjv80hnL?=
 =?us-ascii?Q?XrqfleJ/bwS/wHdC8QcACuwgiBhCBG3Hqd0KLMip3+qXZTsNg9ANSCX6t1uk?=
 =?us-ascii?Q?72JWmNE/SGLjfu0Tu1LQs0RXNBC6r11L0HaVQfuOZXseUsFrQKGt8vI3UykH?=
 =?us-ascii?Q?QFzXjyDZOBQQxD5cy1e3dihz8ojXBzKYAyGt7HcC8Ycqm4GmmPIpn6G6sXQa?=
 =?us-ascii?Q?u/Mg6sfo4We1WYO8gC/64jPJSiUAPt1NoBIFP0LlC6V1bOl4yJGbYka1k+uu?=
 =?us-ascii?Q?lmf5Pl7clfJKLQusiFzTEVske7lixvbxMZdGjuA/Aicj9RhDeJCmfpyCqMFE?=
 =?us-ascii?Q?FUk9+sado/DmVjF6yc5niDPAQwnoSoKOBy2lLx6CL1sHZUBeVwkLNQLblfmt?=
 =?us-ascii?Q?e7qKt++VO+97v8gYgsYtH2mjLtbTpyRpzK+r/JLY1bT7Psw/Z2sodyd/dbaK?=
 =?us-ascii?Q?+QxC2Bqw7ooqq204HULfWr1F0iyDDOHnd0+i7suLvugwYGsQycp8Q7rCEiHL?=
 =?us-ascii?Q?GbOBEE2/WbdXmMIcQ43Vr9rR2qqPkElLVNQ7GbPuOVZErbrCJlxesVs3sjYA?=
 =?us-ascii?Q?f8+8plqp/zLwXp+2FM3CPD3nITlrMoCIp0Scd8EIgxgzeNwWgbFK1UCY1Xvg?=
 =?us-ascii?Q?pUVhOarkK8fDLsF9DZ5DqkIQr3yV/ADQDf8vWjJFdeuCGlTfl2calhGEw22c?=
 =?us-ascii?Q?lrK4wCnL30PiGrqYtomV95ETCpwAmPlzVqRNts8dbA4laXzDy9OfMG/TIaVh?=
 =?us-ascii?Q?miM4HIPeiM5e+BMO9UoJzbEKtcUJ4cFvHcNmhjaXouc2YnRpN8QxSuDrBwqk?=
 =?us-ascii?Q?ew2SQpHX1mFnvsdn+q351TVcElqZrXUW27z9L1XiSWEA2nn9lu14Kk3yEynO?=
 =?us-ascii?Q?to5sTs9JFzPS6jeFwgTVR5gqRhWqmtQcZQC1/168lRmwwXXor2+Xsxekm2PQ?=
 =?us-ascii?Q?JREqj4AXh9tRXV/7Msiq9ar9hbUzgoedvcGVQZJih7J3VIpv6V1cy2NfGUg3?=
 =?us-ascii?Q?lhEi6FNHZCZD0S4uABfpZrnV4sOx?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:57:56.1063 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f403f7d6-9186-4e9f-42b0-08dc685cc0ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8427
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

From: Eric Huang <jinhuieric.huang@amd.com>

mqd_stride function in gfx v12 is not implemented, that
causes NULL ptr error. Add the generic func to fix it.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
index 4d786b5ffd130..aa900b651eb0e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
@@ -389,6 +389,7 @@ struct mqd_manager *mqd_manager_init_v12(enum KFD_MQD_TYPE type,
 		mqd->is_occupied = kfd_is_occupied_cp;
 		mqd->mqd_size = sizeof(struct v12_compute_mqd);
 		mqd->get_wave_state = get_wave_state;
+		mqd->mqd_stride = kfd_mqd_stride;
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd;
 #endif
@@ -404,6 +405,7 @@ struct mqd_manager *mqd_manager_init_v12(enum KFD_MQD_TYPE type,
 		mqd->destroy_mqd = kfd_destroy_mqd_cp;
 		mqd->is_occupied = kfd_is_occupied_cp;
 		mqd->mqd_size = sizeof(struct v12_compute_mqd);
+		mqd->mqd_stride = kfd_mqd_stride;
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd;
 #endif
@@ -433,6 +435,7 @@ struct mqd_manager *mqd_manager_init_v12(enum KFD_MQD_TYPE type,
 		mqd->destroy_mqd = kfd_destroy_mqd_sdma;
 		mqd->is_occupied = kfd_is_occupied_sdma;
 		mqd->mqd_size = sizeof(struct v12_sdma_mqd);
+		mqd->mqd_stride = kfd_mqd_stride;
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd_sdma;
 #endif
-- 
2.44.0

