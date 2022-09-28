Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD44C32771
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 15:22:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7DD110E9F2;
	Wed, 28 Sep 2022 15:22:37 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 157B910E422
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 15:22:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UuAsEQ+TNnMIUpQ7kyNPNRW7a5pN3UfjPZHUWKj6M57bUmPNqxbKWTKRLJUHKDFkTnogubSXkD9a9y149P8Rkeg/o776t0iypzZ47Ky7v9/phsXrB6BCUMvJuCuNv53/0zSXZCtAgAlqgWEhDcWWDgI3KeK4lfURNRLvXcfg7RzCVfWDWI2BtofrHszlAj0oR4Jt+XJCCT8M3m4eOgaB1nd3d9SPF5yAajOnUEutG8JY2zNiZf468XUrRy5kD3dG2MFvKH4q4iZ4yUn6kwLA15Ij63CcpdXMuNxgwQbx9sremG0nNQayElysZgrNoiG2rqf+aYlhZ/AAPBBcskcztg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EADvjSdCbt6ohcpdMcPGsP8zWFqxULLzn0YNtv93wKc=;
 b=fKgCH4nZZsbRyHgVlgsWqzhWzVkldxA42TZoBKXl+Q5abejQTLPxUSLx5tPbL31LhP5MeQtsq/rz578KkZ0xB4oEy6H9YMu5U3DIOMVUP8ayFXQjV6Dj1sXaew2HByKn3/t2m5SN7NrDgCUvGydVtcQzyVjB5Ah/J9uZjkeiNxOtidI6/Qc/ADU39DubLRvVh1VQ16QzFnX6m/ff38RLUZNfSJ45d4jUchU56A95WNZcl2uCbKePTzXMmyqkpyD94kwug+TDHABTplIb8f1likJeS2tZmJyFFydOJCugiStBt6iqW7TJfeGe58B37WjXep1Y/49K3XQlpB3WZfvq6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EADvjSdCbt6ohcpdMcPGsP8zWFqxULLzn0YNtv93wKc=;
 b=fDnFtmrUZRjxV8hQRsOeln+CrFTzOclcXyYByim9+qgd9QZV/f8Yel32YI0Nkj7hnVHe0mVWlyELTrxHnzDDVVVRNraqcYzFgpXw6uZ/yS2qb2yXzipvbMJA2b9O2TfOTq2SYW3b1J5LloxJDqKHxdDRvedGmC9ZqUof51RIpEo=
Received: from BN0PR04CA0103.namprd04.prod.outlook.com (2603:10b6:408:ec::18)
 by DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.19; Wed, 28 Sep
 2022 15:22:32 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::30) by BN0PR04CA0103.outlook.office365.com
 (2603:10b6:408:ec::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 15:22:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 15:22:32 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 10:22:31 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: remove switch from amdgpu_gmc_noretry_set
Date: Wed, 28 Sep 2022 11:21:17 -0400
Message-ID: <20220928152117.1602358-1-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT046:EE_|DM6PR12MB4250:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ced1b84-ee18-4091-4683-08daa165437d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fYIYNyOVwCqvcMrxtjQPxsMy2SZPvIGfqd+yrJVpBVtwkpqJJpwMGswOm261UQboUo0OLb00okGBC2yv95jlQ+s2CFuioflsUGJPLJcxV6rQTvhSimQhWRomX/stgrFid8Gg1A/jfRO/XFI8wFTUEUemb2LlHyeN9NFkY7J/VVY6u93u+K15H7IgivFaLfbqp5/bIKw93K17Q91ejalCK0az9HBxI2u9uoOlG8Vgn2IdGc1mJnEYBTwulzWEL220fxyObiHq3VsJ2F7MoKqimWABUIjGtD0yD6jybR4F9biQFGbEbcmaHHpYVBy6J7edY7DnDjnxenbdFYaj7B0R3w4/Y5XCZuCAQ6G53RTpcEwWQpn8ZCjWUfpJW0kwqKif6WpTL8gPoRe95oqc3uhH8E7rcK1dqedANHhVBKnGHNYJde7BwTWtgId07nZX+nzJsQlaOvcExBXPfXPLLNjPqGWi5Dqi/MvT+mWUbLAfWRRG+twwzPLWbHQbtAn99/Hib73IH4zOYLD08QqjXo3bS1lwVIlSds9NpWCpi+xASmZFzeNf9NVI87XwWc8FyJQfrvVVe/iTDQV93bNOERk6/YwpTzHjAOeaqH6kVf6rTUqoF2iEK7Fn7YQMR+QkAJitTSg2UXqmIOu8lXiSa2FzA/4fztC6y1JWug0XfbqNwqhuIMt93it0tTUP3/Pr3MuwT/Eu2GT1Qi4izBdtSnvUMGGQtbFtugAGTQb7am7g3h/+Gu1Zf+e46yWpG2miAPzYjd3luE9TzL/7u+CrsGSpOsPtnFmDW0PhlDlohn7zkTlYVZ711ZpJZwHGv44hvutQ5nuDtFhO2Dyz/s2lsY1D+bjreEDSJUfJYqcxBj8Z2pQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199015)(36840700001)(46966006)(40470700004)(36756003)(54906003)(6916009)(86362001)(186003)(82740400003)(81166007)(356005)(36860700001)(5660300002)(83380400001)(2616005)(16526019)(336012)(1076003)(47076005)(426003)(26005)(6666004)(7696005)(478600001)(316002)(70586007)(70206006)(8676002)(4326008)(40480700001)(8936002)(82310400005)(2906002)(41300700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 15:22:32.1617 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ced1b84-ee18-4091-4683-08daa165437d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4250
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
Cc: Felix.Kuehling@amd.com, Harish.Kasiviswanathan@amd.com,
 Graham Sider <Graham.Sider@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Simplify the logic in amdgpu_gmc_noretry_set by getting rid of the
switch. Also set noretry=1 as default for GFX 10.3.0 and greater since
retry faults are not supported.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 48 +++++--------------------
 1 file changed, 9 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index aebc384531ac..34233a74248c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -572,45 +572,15 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
 void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
 {
 	struct amdgpu_gmc *gmc = &adev->gmc;
-
-	switch (adev->ip_versions[GC_HWIP][0]) {
-	case IP_VERSION(9, 0, 1):
-	case IP_VERSION(9, 3, 0):
-	case IP_VERSION(9, 4, 0):
-	case IP_VERSION(9, 4, 1):
-	case IP_VERSION(9, 4, 2):
-	case IP_VERSION(10, 3, 3):
-	case IP_VERSION(10, 3, 4):
-	case IP_VERSION(10, 3, 5):
-	case IP_VERSION(10, 3, 6):
-	case IP_VERSION(10, 3, 7):
-		/*
-		 * noretry = 0 will cause kfd page fault tests fail
-		 * for some ASICs, so set default to 1 for these ASICs.
-		 */
-		if (amdgpu_noretry == -1)
-			gmc->noretry = 1;
-		else
-			gmc->noretry = amdgpu_noretry;
-		break;
-	default:
-		/* Raven currently has issues with noretry
-		 * regardless of what we decide for other
-		 * asics, we should leave raven with
-		 * noretry = 0 until we root cause the
-		 * issues.
-		 *
-		 * default this to 0 for now, but we may want
-		 * to change this in the future for certain
-		 * GPUs as it can increase performance in
-		 * certain cases.
-		 */
-		if (amdgpu_noretry == -1)
-			gmc->noretry = 0;
-		else
-			gmc->noretry = amdgpu_noretry;
-		break;
-	}
+	uint32_t gc_ver = adev->ip_versions[GC_HWIP][0];
+	bool noretry_default = (gc_ver == IP_VERSION(9, 0, 1) ||
+				gc_ver == IP_VERSION(9, 3, 0) ||
+				gc_ver == IP_VERSION(9, 4, 0) ||
+				gc_ver == IP_VERSION(9, 4, 1) ||
+				gc_ver == IP_VERSION(9, 4, 2) ||
+				gc_ver >= IP_VERSION(10, 3, 0));
+
+	gmc->noretry = (amdgpu_noretry == -1) ? noretry_default : amdgpu_noretry;
 }
 
 void amdgpu_gmc_set_vm_fault_masks(struct amdgpu_device *adev, int hub_type,
-- 
2.25.1

