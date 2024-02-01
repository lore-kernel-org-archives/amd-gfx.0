Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E09C48286
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Feb 2024 16:51:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70B7710F26A;
	Thu,  1 Feb 2024 16:51:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F1yHrMuV";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0EB710F26A
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Feb 2024 16:50:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvEBPIKIT41wNSUriTuO60Co7FNpVVQq324ALGOHAYj7vFkVnS49Jr8+thvCLY/YgBA+g1NxZpDW5ZIcS10y/iXMGwOMXhdAGTrAppDCnxGYkJHaCyND46BRo5FoL/RFKaqC0TsoqwN+WpLe3lXix15azfL8KmNNSBthFcAC7cvYWKAkXDShwrkJ+b9OxGPiq+22oJh+OgS6aZryxiPiqFRyrDGC5fiefEoKRyrLiE+Hzfsq37PmolwdU5gO8ElsjtISky1mx5RdWMzAU59grejnSjB0cQnHJIUbTWyA2rJqN51kc5c51BSjTWdB//B9xDdWLBkatjNZfrdH3h8UiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJOcUY16hCuX3V4ZhAeTM+nNJsGBMSf7oUsjJLcxTXk=;
 b=aUPPbmRm7sMOgmgoJwgLlTges9WQVDasK+xvdfVqf2Y5PqNIjLMIK80dvsu2urGBJY3mHZByhslXkeIUW7q9dYvGhbvd4tDa0RUg9eqYlMwPfiQjugPYiaRd9+lMpQYzChOC1OQQ5MTYjM/ANf5K40bajdCpGcCoF3r4UaA4qQVYuBaGtxM1/dKfWuB1+dgd1uHdcqSxDEqpDyEkIgv2IbzWMUh6+IMRIxdMLR5BhqjoWcSxZpY1kC5gc6Egbz7n3oYPLJLI/bFLZQ0yLIJcNRom0q/3jN/IdvLcv9kdiZATQ+dXjilATuzqa5/86icaaoylLopgJ46UMNq+jA0+vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJOcUY16hCuX3V4ZhAeTM+nNJsGBMSf7oUsjJLcxTXk=;
 b=F1yHrMuV8nBQVxOLjE+REnnA1KbICodJsju0Y4mdl2EiLMBIQ1Ya3p8f5OHQV+ZnemR+HZvNQO14Bf3nZ0uOrf975XeYl4CxOQZQklJ4IukIhfgtaj2UeJqxzeU3lblkSHQnzHDehVUbCv25iliRH8zQsxbukP/WON0hc+6sZ0w=
Received: from SA9P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::11)
 by SN7PR12MB8131.namprd12.prod.outlook.com (2603:10b6:806:32d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Thu, 1 Feb
 2024 16:50:54 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:25:cafe::13) by SA9P221CA0006.outlook.office365.com
 (2603:10b6:806:25::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26 via Frontend
 Transport; Thu, 1 Feb 2024 16:50:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Thu, 1 Feb 2024 16:50:54 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 1 Feb
 2024 10:50:52 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>, Philip Yang
 <Philip.Yang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Improve huge page mapping update
Date: Thu, 1 Feb 2024 11:50:17 -0500
Message-ID: <20240201165017.29789-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240201165017.29789-1-Philip.Yang@amd.com>
References: <20240201165017.29789-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|SN7PR12MB8131:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a7b4560-2352-4931-911a-08dc2345f4f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G0loKJ0HwK5dsWMNxjbFt4Iz5r2fVAtdQ8DooOWILels6z32cUvosy5MHbuArnOyN8r0mziRD3pN/9eIYKiiRe/gJltkwLpfu5UU+A1OmZpAZ7DGuKyeJEfRMMLf4OOIeAd276Fuo8+rthwqlt2UcdV2Q56fXa5dkjYB2TM3STRCkH0ei3xFx7iFxnhW33tuPYmkDu70oUJ3lMCmx+6AQvxHa2krvv50D0dxMvaOblPDKG+6xWfEl8dLrkr/Szo6xkju0IEGhoP+e2kn3om239mRYvuQfDNf50SNitPk+8Lq81457ybLuHjE9pOgNXNMlYzjJOJ63ALWzedJKI88/Taoq073t+JXZNn05wquP2QgIvGYgO7gb/HLlqvuVF+kI+OCDAQCMixJ4tauJANHi0wPmJo8l12Y0f2opvFKLqseMKtAHKIKUjXvGZdATeURUym/3L14OONFXoUHZpLxBfA+piLdu/75OQ1Ie+pJbvd3aKOgUutcRDJ/r5CxEjKJcSePZfpZuSr94cg4BqebqokqwYVJIJcGELSpG6SkGK0KCf6mSbxkIhHUBU3EbFI44W7HZYJwPTzhb247b8CVfW2/MevYvc38fs0yAJUXgav+23Uj3MdsyfMiXjSAYWeFpYa1SdGT2Z+kFVVjj29jM/pIiSQxSNCmWO1v3Y54a51CXa3a3xg+eDJ5tl2urI6iZfGPCz5aNBJh4LjmS4B3h4B1DcGpk9avqrZqUEXjhn6l2TmpKK/MkDsJmvALSarzYMNxkxWLml13tFoL2ksQzOUfxaFHq6XlaqIkMPK5fdc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(82310400011)(186009)(64100799003)(1800799012)(451199024)(46966006)(36840700001)(40470700004)(70206006)(47076005)(426003)(6666004)(336012)(316002)(54906003)(70586007)(6916009)(86362001)(4326008)(36860700001)(356005)(8936002)(8676002)(81166007)(478600001)(2616005)(26005)(16526019)(5660300002)(82740400003)(40460700003)(40480700001)(83380400001)(7696005)(1076003)(36756003)(2906002)(15650500001)(41300700001)(14583001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 16:50:54.8789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a7b4560-2352-4931-911a-08dc2345f4f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8131
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

Update huge page mapping, ex 2MB address and size aligned, we alloc PTB
bo, and then free the PTB bo after updating PDE0 as PTE.

If fragment size >= parent_shift, don't alloc PT bo, because we will
update PDE entry, this will improve the huge page mapping update
by removing the extra PTB bo alloc and free.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index a3d609655ce3..ef3ef03e50ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -916,7 +916,11 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 		uint64_t incr, entry_end, pe_start;
 		struct amdgpu_bo *pt;
 
-		if (!params->unlocked) {
+		shift = amdgpu_vm_pt_level_shift(adev, cursor.level);
+		parent_shift = amdgpu_vm_pt_level_shift(adev, cursor.level - 1);
+
+		if (!params->unlocked &&
+		    (adev->asic_type < CHIP_VEGA10 || frag < parent_shift)) {
 			/* make sure that the page tables covering the
 			 * address range are actually allocated
 			 */
@@ -926,8 +930,6 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 				return r;
 		}
 
-		shift = amdgpu_vm_pt_level_shift(adev, cursor.level);
-		parent_shift = amdgpu_vm_pt_level_shift(adev, cursor.level - 1);
 		if (params->unlocked) {
 			/* Unlocked updates are only allowed on the leaves */
 			if (amdgpu_vm_pt_descendant(adev, &cursor))
-- 
2.35.1

