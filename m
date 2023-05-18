Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C7EC77B7D
	for <amd-gfx@archiver.kernel.org>; Thu, 18 May 2023 10:53:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE00710E50C;
	Thu, 18 May 2023 10:53:53 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2611210E50A
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 May 2023 10:53:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+e4HhNZosBV/htxR+7UY1hNIa+tkceHnkqm4rrDejQu1arO30VtYZ+2Lgpgm7icJVJUmf7Gzp71cFlF8d4d7o6jl+ztgATvTDsQR+jh1P/nPPziTv2hAXYRinarjPkSmox1U68XYNSBcgHesLIerCbYO9rUhTgZ1bMp4B7m98XzPubKF01QWj00yKIeJxllhXInesEFPt4e4yqWJHVaLHw7+mXtNugzbooB2vq59fgWpyQKw18J6SXP8CLoQEuDWUlquRD3+ol/I05nQi7gFfwPukuB3+McEa5bWdRfd0zShwkjcAXhzSCm/kd+17eXtcw8HkgFJ1pWMvCNt+hAiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBS51Cfe9OoKDeF7zGDBMp9KaYSzu6+ngJPEXhUsu68=;
 b=DCHC2xktsZNVM5tj8LAZVTbuMVmYHEF2w14oOWSqsUSAZ67VTCQxjQ2oOaZ+HU+iiuaN7HqbFIfnYoTMV2Wtxrbi1wkfYFIEV7y5uWqvDanU654NzLcKoHkIpnbJcohoD703NsJcAu8rA2iT+yiWixU0Bbmrcsf2zCVzZNX7sDxH1ZGE7uEntwvDePBQquUN13yilOTJFvRDA6Hec/Rr38IXo9WinwSiuYliULd5jP82+MIhqMPonjy8JRvxaq7OKCVBNI3Unb7Tda2jAfUPZKYn8aoh2z01lQkDyDabNS+CFU/X40QIxOSlZd6tdipaFBXI9jpbJooxLpWY6AKXgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBS51Cfe9OoKDeF7zGDBMp9KaYSzu6+ngJPEXhUsu68=;
 b=fi+fxvKpaqtZlIObM5vImy01X162Tj1R1iKNzWSRHnnd7oqMlFo5VizlTOZPQv0TVtoTKk6HFktlDUl43bGwFRBxMrqlkrZTigZKtemPhGQm6UaqgrmE02eWyUZ/7nwEtow8vXA4QVPE8OH4pV2jMjAjIAMjVfIigGQxjcjQ2dc=
Received: from MW4PR04CA0150.namprd04.prod.outlook.com (2603:10b6:303:84::35)
 by SJ0PR12MB5424.namprd12.prod.outlook.com (2603:10b6:a03:300::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 10:53:48 +0000
Received: from CO1NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::a2) by MW4PR04CA0150.outlook.office365.com
 (2603:10b6:303:84::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19 via Frontend
 Transport; Thu, 18 May 2023 10:53:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT094.mail.protection.outlook.com (10.13.174.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.19 via Frontend Transport; Thu, 18 May 2023 10:53:48 +0000
Received: from lnx-ci-node.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 18 May
 2023 05:53:47 -0500
From: Shiwu Zhang <shiwu.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/8] drm/amdgpu: skip bar resizing for aqua_vanjaram
Date: Thu, 18 May 2023 18:53:22 +0800
Message-ID: <20230518105325.15609-6-shiwu.zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230518105325.15609-1-shiwu.zhang@amd.com>
References: <20230518105325.15609-1-shiwu.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT094:EE_|SJ0PR12MB5424:EE_
X-MS-Office365-Filtering-Correlation-Id: 201af4e6-2e5d-487c-7693-08db578e28d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AmigjADxvWcQMHPOvryEnbklX552PVQ1ToL/tL1qd5PnabvNKYNJ+D4tfV4pNLQjnq4W0T7KVmCOSvfiK9lcU5a9ValKqcSYkv75n66J3z3DCHOvQDAJyd4bvLjf+bMPHBFuFSwOlcWrMgpkn4Mm0Z73jKnb0ROFZXWqtHLmcHyFJRH1h/MZjUOCZiH8MCHburX3dxQgaihtNeYuo2jROrb0yac8B3hYNWlAiuRFcsOqoWknj3cPOJQwgx0H2twhwP9ZdOXshLyFf/uLthAcM04OuCGswHGwA1p45t6Y8+sSLlJH1LxxXuF807vyZsuWJfVnHA5qgp8YmHBjXFkzIxfRiYnbUsw0b4GQb42ScVGPD/kP/ROYgJf17GDOQKpPnWzGmql+GOpZVJopSvoEM/ekREMis9RPIKNAJJfsHWLEbrvYdJpdYjOpQMmn70777Cyw8KjFlyLGY7l3j+93/Jlsru2Qdr19jatTrq7TZw7a8cUM3FlS+E9N6MfiLp/I5RMOG1TqcacjtUUm8/mozI3EgVt2Z1QbcjFOv4rVxdotePduV0Y+44C3chY1goOh91YlUr+IESUiADu+ibNej6A84V+QwE22cwu0Gzc8bUxNqj24peJysUB8YAOTfUGyAmvFnM8UXbGsOlptuKzffZUxg6CKXbQ3rYnIiq9Jr+H4rtucQXI35ES5gHdNgdahBH8UwKU/IxBOhacN3nLLpBCJmtkJpQfdOniGQ2uq7vPe0njJCldjpUpJqvyFMBCUota0qlHtTYh1cq3RVM1Wng==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199021)(40470700004)(46966006)(36840700001)(70586007)(316002)(478600001)(70206006)(86362001)(6916009)(36756003)(186003)(1076003)(16526019)(26005)(81166007)(2616005)(356005)(336012)(82740400003)(47076005)(426003)(83380400001)(36860700001)(40480700001)(8936002)(82310400005)(6666004)(41300700001)(8676002)(40460700003)(7696005)(5660300002)(4744005)(44832011)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 10:53:48.3505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 201af4e6-2e5d-487c-7693-08db578e28d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5424
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

This feature has not been verified yet so it is better to
skip it for current phase.

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 3b6b80d784c6..4ec85c85c29c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1710,7 +1710,8 @@ static int gmc_v9_0_mc_init(struct amdgpu_device *adev)
 	adev->gmc.real_vram_size = adev->gmc.mc_vram_size;
 
 	if (!(adev->flags & AMD_IS_APU) &&
-	    !adev->gmc.xgmi.connected_to_cpu) {
+	    !adev->gmc.xgmi.connected_to_cpu &&
+	    !(adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3))) {
 		r = amdgpu_device_resize_fb_bar(adev);
 		if (r)
 			return r;
-- 
2.17.1

