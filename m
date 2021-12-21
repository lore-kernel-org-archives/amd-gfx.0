Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20EA4C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Dec 2021 14:59:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78478113C54;
	Tue, 21 Dec 2021 14:59:12 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36374113C54
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Dec 2021 14:59:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=llwu7+W0wqCAWuhGnad7J4EUvQUSw6ImmMe4SQrSBXsif9y6MCxRkudhe/ZMUxln6R9yGEp5++5aDzLfHo/gZ9ltyvr4qUhBrL7P+QuFDkZdh3+VrjkXoxXy5a+aKzuI1AP6+eV3JVCJYUq6v4cEti3kM9KaFdRMvW7LkPJTf5L97ZeEXWBAkBbo5Li+eTVIGlHRm5lyGOezjFl9IU3jyFreEWnAaDCljczVbGrV87a0ScLoPtq7ghcTLkuIZ8WLhmjOhtWPes1MmbYQ7G7FWa+tjSVcmad2EqUPRjEXjRX0QkNCKHnnM+fIdxRn22lsmZ/nyj8DAiXs8fG6mdGYgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DGppyRHqsMrFADIaj68x1fHFFRunNywAWfyi0E1LIMw=;
 b=HmW/pd7cueBhFGci4ChETOfJtqc1u9NyXmFfXhXNmGy30l9OjlgJTDGjExHLL6WFxVBPNUJ3ufnZ3+De1BoMUs8NOeMDc/L+qkBQkYV/p9J8/kRm4TyeNt7PlIOjf4FBkTlzBLyUQudLFtI4IxI21WPXjoIhmy8pEvO8OWPWD776HM01nsXUD4Hdb8WL6h1I9m2eI63uw2q/myuL7bOR1VZbhLy3VZOEhJKK0FP+fTe7ylBP2ouQ+lc+yJ+CUTBDu3649kHVp1IYR90klj68ce38P/G4IdKYl96csQXBeR5a4mKNg26jlKN5JkEnwn9rsXMlco96r3T6ee11T0q5Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGppyRHqsMrFADIaj68x1fHFFRunNywAWfyi0E1LIMw=;
 b=TYxJie9Hu1lJs/aYc20FR5tu6FY1DP5na1rcsKIY8edpPETmpcoEp0ytg2QY12DkTbTHf110xMp/QkTliazemI0vFeHJFC6vLsGQjVYmgmPGiY2u1lZqopuXo1xgDJhbdrL0rG6JA6IstEbMe/OyPbExwKgw38m6Y2TecTXJP1Y=
Received: from DM5PR1101CA0002.namprd11.prod.outlook.com (2603:10b6:4:4c::12)
 by SN6PR12MB2605.namprd12.prod.outlook.com (2603:10b6:805:6a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15; Tue, 21 Dec
 2021 14:59:08 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4c:cafe::a5) by DM5PR1101CA0002.outlook.office365.com
 (2603:10b6:4:4c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Tue, 21 Dec 2021 14:59:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Tue, 21 Dec 2021 14:59:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 21 Dec
 2021 08:59:06 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix runpm documentation
Date: Tue, 21 Dec 2021 09:58:53 -0500
Message-ID: <20211221145853.725472-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa06a9ae-e55d-4ab4-1021-08d9c49270c5
X-MS-TrafficTypeDiagnostic: SN6PR12MB2605:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB2605FB6E60B013546908C7C3F77C9@SN6PR12MB2605.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9NqyNglK29IXLP1DMaCs2Fkc0fMWAYvqkFeahJgc3uaaDwu7WD3T6RSt3+/QwtZNWRfBKH6nJAJb2hRdfVAP7YMtacW59wGYkFJEEeflJuw2V7fNqu0I5a1Q68rVbyTH+iBwLwk8HSfVRjIUykcVznrelX/iKp6DvP19eB4BWkvfjcnXOFBSJToaL7F8GWYI27x+7LNhXC4O6UjXmHI/jPx/pnSn6CpY/wz2t29zOqWwrlu6wFCohwWF1g2hjBfBdvDgdSDpy3BFjIKmX81isSlZ9hdbfphpQK/plGyEQ5WVM+7j9U9B4lEYIQ0ZC9YEUrdYTLKil1GWVO1WQjDo58SygTMzSqc1iNt9bBjS3kIHPgbHEkVYc9qptruskcQZM5ioFiGIpE8UEa8vLRiOmkFXLbbz9tulU4WHB2g4TigWP27PTknBDPEFJzwLSMPwNlE8rrAvDL2wl/OC9WDa+gpL8374F2GucrA4izO7SQLwwU//ic3R7JCdJpOxcDCVjw9cBtSyeevPvP6TnB+Kj9h4vs3P7PCAn4k2VeN2uVIGcc+Cck2n9euGDWVvJfhmZInvIT+gGN1B13Cm/SOwJ2HksEnJRU/dcBHsOSuCb30GYiNApCXZVo6KgD26dgU813+niZOSzAYY8whTkEUfiec7bxiTWb1tcRd0avXZ1mNTgbgrOUzDXUGKYbVE3SI8ZJ/uuZG9bnZPfMFpCx0G+QOgot2dQLkCVpCVU1lH3YLR2fcvKdEqGMsihACV/Hw2AlpGOWMVPjcvqrBVCqut6R28MazMJi7kyzFncIWkxFs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700002)(36840700001)(47076005)(4326008)(508600001)(2616005)(83380400001)(70206006)(70586007)(81166007)(356005)(36860700001)(6916009)(5660300002)(186003)(36756003)(8936002)(1076003)(6666004)(2906002)(316002)(86362001)(8676002)(426003)(82310400004)(40460700001)(336012)(16526019)(26005)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 14:59:08.5086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa06a9ae-e55d-4ab4-1021-08d9c49270c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2605
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It's not only supported by HG/PX laptops.  It's supported
by all dGPUs which supports BOCO/BACO functionality (runtime
D3).

BOCO - Bus Off, Chip Off.  The entire chip is powered off.
       This is controlled by ACPI.
BACO - Bus Active, Chip Off.  The chip still shows up
       on the PCI bus, but the device itself is powered
       down.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index a78bbea9629d..f001924ed92e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -331,9 +331,10 @@ module_param_named(aspm, amdgpu_aspm, int, 0444);
 /**
  * DOC: runpm (int)
  * Override for runtime power management control for dGPUs in PX/HG laptops. The amdgpu driver can dynamically power down
- * the dGPU on PX/HG laptops when it is idle. The default is -1 (auto enable). Setting the value to 0 disables this functionality.
+ * the dGPUs when they are idle if supported. The default is -1 (auto enable).
+ * Setting the value to 0 disables this functionality.
  */
-MODULE_PARM_DESC(runpm, "PX runtime pm (2 = force enable with BAMACO, 1 = force enable with BACO, 0 = disable, -1 = PX only default)");
+MODULE_PARM_DESC(runpm, "PX runtime pm (2 = force enable with BAMACO, 1 = force enable with BACO, 0 = disable, -1 = auto)");
 module_param_named(runpm, amdgpu_runtime_pm, int, 0444);
 
 /**
-- 
2.33.1

