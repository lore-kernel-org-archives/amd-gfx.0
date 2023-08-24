Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC4EC6FA8F
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 13:54:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95EC810E54F;
	Thu, 24 Aug 2023 13:54:57 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AACB010E54F
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Aug 2023 13:54:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEfsCaVThYUQCPJXIOQ+hgs5OGUiWAj2tfUr74OO1UAfu35JxT1g0Q0N4o9nXipOAKIHX85xKgvWFCgZ48gZWP2fzqSiqYXU4PymLxIrnppGd1PiHw7T+Zdlx1M6UdTNUj3GxprZIDuHUR4Igfui/TlFgoKdmmPVuysdlK4rvEZW0yf7Lz9Zf9IasPDf69Aov4UG+qDn4f6iL1DmGLJCn1MufIXRbdIZ6TQ3HLXQCWRgdU9YzFPu8clOL/7iMQcg2+qr4bBqRDp1L6xcb4t7Bbrt4Ax+wjhFWTJSzwE//DQeEbqbxKyoy5TEbzJL0XSWdTQy5eZiuZ0YHMv1ZEKGlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVQtP4Gf8EQHHDKiVWE9W8rNBDXK3a5pUulzacRJzTI=;
 b=Fo6dc9HH7ERgisMVnEREjGTvt0rx282wb07/sbcAYf6rI2fg+2jlQSbweOSqPTXjJrAY0M4gb+XoNzCGPy/5v7ryAzFXTeAkMEiMKA0TyENLXPtWgELEFwpPkHod7IeD1xETaKMzgX33lrKMWgccPV8s+ovhKt8B8sqoRtHs1fKu97vZ3pBrJFX8852Ky0C2VXZA9tsFhI6sIXGaQWLEi5kzgPzL6P51l2lNNkTkj1at6GiG1mJXwPqUmlO1UAdBirNgP5MQbcYmXCw+22zRE7l3lmsnTyG/1OvyTFDFNUe4GD2i4Jy95mvinYVvT0dmx0CV60vHiA6JA176iklKOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVQtP4Gf8EQHHDKiVWE9W8rNBDXK3a5pUulzacRJzTI=;
 b=zZw3/FFtbzwWy12PADQ9Ycwii82F00bgVRoq/5OUI3t5lNpRIGS5IqGHTIVBRDvW1bDvzu55X6fLeVFDfWeXvGwcPkMIDIkCR8H1L32cYo/Se9r8RpSjN8rBEFwiObWWY/76gUoDIwK8dld7gG9uNsNbqVfdD8lt53MbUN9ZphQ=
Received: from PH0PR07CA0107.namprd07.prod.outlook.com (2603:10b6:510:4::22)
 by MN2PR12MB4374.namprd12.prod.outlook.com (2603:10b6:208:266::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 13:54:53 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:510:4:cafe::e) by PH0PR07CA0107.outlook.office365.com
 (2603:10b6:510:4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 13:54:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 13:54:53 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 08:54:51 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/2] drm/amdgpu: Put page tables to GTT memory for gfx10
 onwards APUs
Date: Thu, 24 Aug 2023 21:53:37 +0800
Message-ID: <20230824135337.3975006-2-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230824135337.3975006-1-yifan1.zhang@amd.com>
References: <20230824135337.3975006-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|MN2PR12MB4374:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dc4bd90-396f-4a14-92d8-08dba4a9b121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LqIe0mqrQQzYWpaDMy20Bv7CtU+PTDaJH7UtA58iuBGOcBebQiSbh+046RCHyxOaLsVR1iTmrSHhP9zGT+wO3ZXePgWyu1REunTJVsQ/baOvSzhY3fV6kX7Y/LpFodlKstMdc//wHxk+hcXTR/UfBcom+26NtasngtMwc10M7iQHD+bYDunay6/lMCljzsyIukuoMcfwo4rEoER5kTd5LVPEsxRQS47BwCmxozQx56k75wECcktrDIksD8gr/PIQtY2qUTMw/sYOwC8RSRWOnKMpGFgTAegqKv4Tos8O5/e54a8mgPlgsjrFuxML8u8s6Yvk8fouWbM8Q7ZIhN8xeCJgDrP7af0i4GEzzht8fZ3+YIKv/N8bofEEX9dGZeiBjDPaIoSKKHX58U7dIkjtMklovH+wuqbm4dOg42Po/z+nZL+VSpaQa1S5eyT1g84ALVYyj9PaO2ZYpoAMnAtWFG7epvUk4DrKvzxdSuzin0e6zL3QoSbS8b8OgV/FuVbkxvjMC4hKEdnJk/R5WYCb3/nui+hA+xjPSk2p86p7YhzXopleRujLF2BHuUAu39gbTJHqojxSyPMigw2HqovP+e6H+cDgqDppMsFGVxKd1574tmiBVsMUz3DSzD4eyifjoC7p7+mg+Wnvth9CT+XTSCMmb0H2RnaumSvckWsM3NwiZPt0NeHZkrDrvVCoDkM3+NdqmMFpETgrvnFDhz/c/3jqeSwkJZjm1do5csduMW3L5QmmBqTiFGJCOdJMG+aVDY3YrZ8QlJcMUjXt1QMt6g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(186009)(82310400011)(1800799009)(451199024)(46966006)(40470700004)(36840700001)(1076003)(40460700003)(2616005)(5660300002)(8936002)(8676002)(4326008)(336012)(426003)(47076005)(36756003)(83380400001)(36860700001)(26005)(16526019)(40480700001)(82740400003)(356005)(6666004)(70206006)(70586007)(54906003)(316002)(6916009)(478600001)(81166007)(41300700001)(2906002)(7696005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 13:54:53.0627 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc4bd90-396f-4a14-92d8-08dba4a9b121
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4374
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
index 96d601e209b8..b108d92883d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -515,10 +515,13 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	bp.size = amdgpu_vm_pt_size(adev, level);
 	bp.byte_align = AMDGPU_GPU_PAGE_SIZE;
 
-	if (!adev->gmc.is_app_apu)
-		bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
-	else
+	if (adev->gmc.is_app_apu ||
+			((adev->flags & AMD_IS_APU) &&
+			 (adev->ip_versions[GC_HWIP][0] >= IP_VERSION(10, 3, 3))))
 		bp.domain = AMDGPU_GEM_DOMAIN_GTT;
+	else
+		bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
+
 
 	bp.domain = amdgpu_bo_get_preferred_domain(adev, bp.domain);
 	bp.flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
-- 
2.37.3

