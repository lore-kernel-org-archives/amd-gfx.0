Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58DB4C88CB2
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Aug 2023 00:34:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D738B10E5ED;
	Fri, 25 Aug 2023 00:34:44 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A4DF10E5ED
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Aug 2023 00:34:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BGhZJuVq7JMQv24Cao3uFmyH22tmVdokIXC7Y59uxndCVFes38XXMA5ASdAVwfslBMWtHLCkCIteDChmbeY+xr7JMLDUDZVK4WuUBLiJYZhuTE1Kx9OcS8DfVNMSZr6bbHUG9QuHVNbtMxs8Y3WXT/kXQLTubKoAp+bQAGEtJqxNPmukTLlH7vurpCgEJq2ZJ9RXZABdrnxupSNzqgEkddnaRZDNHO0Kl/8F2o9gnXwkb+5PzOvFVXrE4KhXBDA385QUs5mKaBKq5DSKlfacP/Ttl1v9AJy5zEzrDRcnvMCf4jEFkyImo/+DHZFrA8bdfKbHoVM/WMHL75p8jmyG1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dn9e40hqXv0KW2g/BHQNoIVpHj+C6cqwWUARDAReXts=;
 b=TrkMVsQuXhc+0Tk+iqg0Ccc2MumvtsnBBuEBTbun4YmsTsh2Tk7IucFALzMqCxu1U4xEm46/DuCL9UWOma9DgQ/99BgLfKa0NeZcsNDclLeH2AMB+goguhysHNYgNj/4kNEHqab7nupcRhxxQ/jl97CmR+R12bBpbH3xHywZWBRl4oDocIxeSQLDhWthTF1CffDszYfNtB7XaUh71yo9ABnLWLDG4gbGBXDyaQtz5RXaG5kdgf0Ta6vaNfmj4CRrGpor42MdfTzSrws6y1bTz73dIi/lbzoShxWauNYvSKfDSFGH7BjqDwQSvDeJgCRbtz2WykMb06c4Pwir99C7ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dn9e40hqXv0KW2g/BHQNoIVpHj+C6cqwWUARDAReXts=;
 b=sUoAyex+SNmwMz/LEw9pJuAAHodHXa9EDjNU6xPWil1Gmj6uk8ey06gfKLD1nURsfINxQsiRg9ER07csz1DXW16ctE1GAhBVjZtj9ld0KdzEW6f0SqEweXgye9+l8fnfB7aIOQMgYoklNXzPw3IOrzd+zI93oX4nGfcb3LRq6Qs=
Received: from SA1PR02CA0001.namprd02.prod.outlook.com (2603:10b6:806:2cf::7)
 by SJ0PR12MB8138.namprd12.prod.outlook.com (2603:10b6:a03:4e0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Fri, 25 Aug
 2023 00:34:39 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:2cf:cafe::e5) by SA1PR02CA0001.outlook.office365.com
 (2603:10b6:806:2cf::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Fri, 25 Aug 2023 00:34:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Fri, 25 Aug 2023 00:34:38 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 19:34:36 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 2/2] drm/amdgpu: Put page tables to GTT memory for gfx10
 onwards APUs
Date: Fri, 25 Aug 2023 08:33:48 +0800
Message-ID: <20230825003348.3978418-2-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230825003348.3978418-1-yifan1.zhang@amd.com>
References: <20230825003348.3978418-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|SJ0PR12MB8138:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cc2aaaf-db93-4c3e-4152-08dba50310af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: exc4faUPVXj1ca5DmeRrCvVkdvWyaH6supT/Mz3T1SKZ70Zy9a9eN/ESkz9nkE9miQoPjuXxZrT5ghoAIpiU3Gr4eh88cbDK/3ciQ4s/aJkqMPY+BGJF1ixbtNUwrcPbxAaQd/vSL7NAXc8YPLGFyqZObMdhnUAbbeKfrGVeODJ4G0QKhQI+9e6xB7IT22O+Dx1yxmBQRbVB/Ew6/v96BxabPikrr7KtFiILwWg4dSKcEXeN6vuFOJLR9RBVug34mPR5qMtJC/16jLP0P/fTT4rihtzfqeES/d+39kIzTnmsFFsP4H07RG8YEurTdR5q/y9c2R+Wn0xwXfJat6zJ9XX4V0Yd07FQ4sCXkx/1KCYEHjbhSE/qw2ygWyUWGXEcz8SBGWfD/YIonnVWu6wz31YZoqEGCAiMMfq4pF7SGnpzV93SGGxMRl+Oryylpzy5QRDSg2wnLwtId4IDW7+1W1koNr5CI+McltyRatgFiInGqqkjjmuP+O3zIJtuh2E0H6p7DsMtLak1scY34eM0E6BbMKveTxJT2uWuC7fFmY21KchBkyfqTtvSiiVi6FNqQLvP3pbEMMK3rxSIiW6pT8QXX+PtodnunBs26kyb3jd0ObbG4SSnKey2ZO67t473vgJBgBiDmOce/hHl22J38pMn12kG4qo4XBzPIs+FFiG94nayjtxWie2tDJPHiPYHCSvaxDFUtzqhoDQXMP0ihmVYmRGvgAThnVcCLhZH/7JMnjD6qAb6fQXAjKMzK4d4Smx5zsZvCXMt5xSxGUv8fA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199024)(82310400011)(1800799009)(186009)(36840700001)(46966006)(40470700004)(82740400003)(81166007)(356005)(40460700003)(4326008)(8676002)(8936002)(41300700001)(7696005)(316002)(6666004)(36756003)(54906003)(6916009)(70586007)(70206006)(86362001)(40480700001)(47076005)(26005)(478600001)(16526019)(336012)(1076003)(36860700001)(83380400001)(2906002)(2616005)(426003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 00:34:38.5838 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc2aaaf-db93-4c3e-4152-08dba50310af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8138
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
Cc: Alexander.Deucher@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To decrease VRAM pressure for APUs, put page tables to
GTT domain for gfx10 and newer APUs.

v2: only enable it for gfx10 and newer APUs (Alex, Christian)

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 96d601e209b8..4603d87c61a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -515,10 +515,13 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	bp.size = amdgpu_vm_pt_size(adev, level);
 	bp.byte_align = AMDGPU_GPU_PAGE_SIZE;
 
-	if (!adev->gmc.is_app_apu)
-		bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
-	else
+	if (adev->gmc.is_app_apu ||
+		((adev->flags & AMD_IS_APU) &&
+		(adev->ip_versions[GC_HWIP][0] >= IP_VERSION(10, 3, 3))))
 		bp.domain = AMDGPU_GEM_DOMAIN_GTT;
+	else
+		bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
+
 
 	bp.domain = amdgpu_bo_get_preferred_domain(adev, bp.domain);
 	bp.flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
-- 
2.37.3

