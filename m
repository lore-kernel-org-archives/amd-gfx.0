Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBCF8C433F5
	for <amd-gfx@archiver.kernel.org>; Sat,  8 Oct 2022 05:56:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26B9010E1F0;
	Sat,  8 Oct 2022 05:56:42 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4CFF10E1F0
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Oct 2022 05:56:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXe3A7xs/Neg80mcAFeYr5BDWo8/8FYDjKUq0JnK1LxUYP3xvxGAiX8KKmlOyghZ7sHsNDuiP5LlPJ3IXDIVpB/WOzEdKjMOWlzkMdAOewrCIsrq9ZXOXyyfsXMyjiCfRhP904qeY1OYVG540WEOMPNngqN117XVqj3LVOjWoZXdGA1f1IekZdFaTG9+DScay5Ngt7OIK5zmOaDoFB6RHL805gQuLIGgzDdLYLuZJzvvfxnHeE+X1q/pHbkT+NQSScXxvf9W3/KTc6PuroCQfX2N4PCiIvvGBJC8VNzwzdld9MkzH4qA+JRmjZC+SCu/LoMfw2qgr+FLaS2/xxr9/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lrdB3zN/PO30gla1PoWFC2fYsE2Uk9hWpjWfNFcHco4=;
 b=DpnnHknYR7Yx4200hXMHCHLJNkhHVgXTmo+asGTj0qIGhvgtt8qGJMOgMuSiFjGb4wpOqTL6WbWjsnAlV1YlHYmYl8Eb+Lon4XvHvzyw4SdPzH/3LSsilEcrfNVbruZPfdQw5SKIywo4sLQZNqR8Y+30tCyZiH+qsHRXS4jWRcbgkmrFx0wKQ2RGmNrdCCCCQgtSWfDmDtLPf03xzf0ixFA97DhfP5cOPrnRhhRcbdPnIVFpHoWUsQh8q+3hT3UJnFbWanSuHBSEjBGHP93jAuwEkb2y1VShrAMV60wKKz2Zf2SLQE6VYkMHbUp0sjH7pIPSfJre3WfTVFiJ8f8sgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrdB3zN/PO30gla1PoWFC2fYsE2Uk9hWpjWfNFcHco4=;
 b=RcOg36kUpERuTH5Xft0pw+xDsb4uoMOZlfcGX3Ysiog0hoCtgBCAcNgY9sv3yXsytw8pzExJFBXqjOEq5SobWs9dn1xrRA308YGE99fzcf4GUR/kfOGf9sa5nP80+iDuYW5RGmRzXM9e3pjiv/i5up0fPDLGu7yFzpBpdDAhJew=
Received: from MW4PR03CA0310.namprd03.prod.outlook.com (2603:10b6:303:dd::15)
 by MW4PR12MB6949.namprd12.prod.outlook.com (2603:10b6:303:208::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Sat, 8 Oct
 2022 05:56:35 +0000
Received: from CO1NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::34) by MW4PR03CA0310.outlook.office365.com
 (2603:10b6:303:dd::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.26 via Frontend
 Transport; Sat, 8 Oct 2022 05:56:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT072.mail.protection.outlook.com (10.13.174.106) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Sat, 8 Oct 2022 05:56:35 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sat, 8 Oct
 2022 00:56:32 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <felix.kuehling@amd.com>,
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdkfd: Fix the warning  of array-index-out-of-bounds
Date: Sat, 8 Oct 2022 13:56:12 +0800
Message-ID: <20221008055612.505160-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT072:EE_|MW4PR12MB6949:EE_
X-MS-Office365-Filtering-Correlation-Id: 85eae05c-578e-4130-5799-08daa8f1dbbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A1nFBoFz8ffwflZmm+cTLQ2o+MZH6bsk46R3CIOK7IcCmhH0bMxQFYT4f8xOS4rV1ZpH7iratJ8KEQsLkqq9Ih0o3IlpjIfZ4FfH6SEEeggzEq0dqqyjeYPP+eU2ccUgnvhM4QYmXmLC62cqVpbEvEVFv7APrF+fNa6JjKrEOY6USFgbAH2Q+Yk7Wt4cFC7Tpg44tteYb/nEYgnoSeF4vqzYbfKvbuxq3r8VfzU4Ew3xLWcsVe/VyHO2A344F5KbkInCGTJUXOhegD8quUj2aZzcXq6FJ8E+VXNgGGDtkArVY2wD72Ib4dJmhFI2a2aIgOzeZ3sBQm1MHeSbhh4pA7jI5Qyc2UNsC2jGrYefJibXVbPPjg/CtZ7rDEwAhyahPkfLWL7d3SHspi5R1Byg+xBky4hVbDTor9EgPly6fJqQ8ah+UdGRf+ZIAD5schNTgvUadA8idGLoBqYQ020lC6jzEbICeca0RUffAxPi5tY34qbkIzcYB2apFmayLoYI8rasbJLK9GHK+EN8X/x8ds+PPj5HvbX75AB77DbwKrMD+0YVGKY8bunN1HAoAgLAN+ykvQmldOfrdfXXkTh+9V7x2Rl/ko50MOQ31hZniS3Dw0RxmTxDy24ssSCjklFGIcRA/aMK7Oh0pYxuyHMunyPacrBjqvbjLsOfox78GniqERTsxXiVu/OJw7cAeoo8JMHNi64WwCvLuDdBqdkbsVRuInSvCyik1iVCbjD0ERzW1sPG9/RKLu3CzdUgtqwgAcKytJJgKy4lRoFxLN+H/9iv5I3Ko2XalvDX8szqaLC9Cszf5sYBUebG9i2xq3Rr
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(7696005)(6666004)(26005)(5660300002)(1076003)(478600001)(41300700001)(82740400003)(36756003)(40460700003)(81166007)(40480700001)(86362001)(82310400005)(2906002)(47076005)(36860700001)(186003)(8936002)(356005)(2616005)(16526019)(336012)(83380400001)(426003)(316002)(70586007)(54906003)(110136005)(6636002)(4326008)(8676002)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2022 05:56:35.1766 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85eae05c-578e-4130-5799-08daa8f1dbbc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6949
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
Cc: guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Increasing the simbling array size to fix the warning of
array-index-out-of-bounds. The VCRAT_SIZE_FOR_GPU is also
increased accrordingly.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 477a30981c1b..3ec425c3737d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1683,7 +1683,7 @@ int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
  * expected to cover all known conditions. But to be safe additional check
  * is put in the code to ensure we don't overwrite.
  */
-#define VCRAT_SIZE_FOR_GPU	(4 * PAGE_SIZE)
+#define VCRAT_SIZE_FOR_GPU	(6 * PAGE_SIZE)
 
 /* kfd_fill_cu_for_cpu - Fill in Compute info for the given CPU NUMA node
  *
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
index fbb5f6c32ef5..31a4bbc9f9cb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
@@ -80,7 +80,7 @@ struct crat_header {
 #define CRAT_SUBTYPE_IOLINK_AFFINITY		5
 #define CRAT_SUBTYPE_MAX			6
 
-#define CRAT_SIBLINGMAP_SIZE	32
+#define CRAT_SIBLINGMAP_SIZE	64
 
 /*
  * ComputeUnit Affinity structure and definitions
-- 
2.25.1

