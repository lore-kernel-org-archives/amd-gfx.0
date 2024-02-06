Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D618C48297
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 21:51:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BC9B112E92;
	Tue,  6 Feb 2024 21:51:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XXj5C66T";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC692112E92
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 21:51:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVTddr6L/tfb7bCm+b3VFAUnmwmnesyULkl98CUyWCPkSGxFdpI7CkiqwMsWOfu9rVt0gTzseE5xFO4F3Mhfs0tIELPhhphbuNII+BgwULddHUwOD78Ysn1yaKhpzOG+dml7ovlh5a76Q2h0toHaolpbcloobHWglKVfWQjbolvYzn3R4GHVKxtr5YsjOA+tLu7MMvY1R/DUrjezNPq3pzCwrs/8p/lyBmqtLqB5AjFP3vVJwCV3Y/bOOoESQNAnZGpiVwn8NJzY52LYF/HyDMEEm4ULTNS9DzD1a3WsMN0p2QUld4SnR8i/TIpNi+yqUpxlzTOb/6Rn0FRjQ07u6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJt/oia9xd/qLACSdUL9NwTOi571rRWaeIytaEp6OBo=;
 b=bDfX7s/NFJt+hmLNJ4eT9xVtcVwnn4gJ2/5fgPdb1uFCg8CXnUVSsogUBZ+N/q/f9tzSpZ8h9mc1sSNpe+7ijunKywTgRd+ntekXa+Lf28WPInlyI5bpg1o7WuRLVqCDD01KO6BOcSj0MIFEn0vA4zrUyIMX/a8JYY+/P2S+r4RqXtUhn+F7slvO3GCc6x26W881GryjCHpKyCCwofLplRw7nMGlERRJhR1C/d/sHrfp5EiDjtcjueA++QpVlG3u3Q5ZZ9MpiMTSwsEinACdsiAcVcZNQdUQgYGm9qBe++fp08uJy6eejb/naxmN2VUkz8nv4n4Fe/5zTDyg27oDgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJt/oia9xd/qLACSdUL9NwTOi571rRWaeIytaEp6OBo=;
 b=XXj5C66TlEs6y7oyEpthWr0mqe/+jiKR3xEn9fzmlnU7/sD1U4yRY5VWUU7ukvfvQCcnXW1zNjwjZ5GJSBonw4m3L9Jn7A1N2/6YZ0lBKY2BXojlbL+zGKm1YXTMEa5D+zfZH5rLAVhektOY0rdHltbFl5H9f1YCs5/a9KvxUtc=
Received: from DM6PR18CA0005.namprd18.prod.outlook.com (2603:10b6:5:15b::18)
 by IA0PR12MB8088.namprd12.prod.outlook.com (2603:10b6:208:409::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Tue, 6 Feb
 2024 21:51:35 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:5:15b:cafe::74) by DM6PR18CA0005.outlook.office365.com
 (2603:10b6:5:15b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 21:51:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 6 Feb 2024 21:51:34 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 6 Feb
 2024 15:51:33 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?q?J=C3=BCrg=20Billeter?= <j@bitron.ch>
Subject: [PATCH] drm/amd: Set s0i3/s3 in prepare() callback instead of
 suspend() callback
Date: Tue, 6 Feb 2024 15:31:51 -0600
Message-ID: <20240206213151.22499-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|IA0PR12MB8088:EE_
X-MS-Office365-Filtering-Correlation-Id: 460f4d5b-97b1-422e-8101-08dc275dc95d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WHVna5rO+LbxH1KIerIvmuoHGfn2sQTTa3+253T5nkK++6NjuTIjtG4aSbkXV0EKmNbGXbaHAGo9GWrU95HxzpMXPD1iW26MA4Dko2AgLPtRGq6uvVMaiYfemr340n6HrPaaBw03eV8d+9W1rLRqpNoCRjNaOVQEH5pIjbRJ6mvsspbB4JhMadNSX1iAfjZKxcmaLPL32LYNasJ73lR/heS/hS3rPDomxW5hAH0P9aO+6+3RT5P2iINN3L9rGjPXalm7tl2PPLSLObDYYeXu/xonutA61+p6Ep3M0WaMX0+7XC5KiRVVHfiguzVfz2DFzWgwv1yaNGEoJeSq5MTP1p4VgUEpOYgdmVHLk1sI0xk2fYi9DW08t/ngWZYzj8dHELrfarStA7sCWyEWYpwxE74uPygK+e1LnpAJsaJNI1XQFu6PJl8QIVlBQa1Y2cdOzT8K8wh3WL4N+9LQ/S9W9kZnepsqbV0C0OycAlMFqf3CGNN8ROUIeV8Z2eZHolvKDFxOLLL9IM3axiQGIt3z3CSvRiSLhC2fEoVvvJobrj7tQ7K8NR4+q6f7RUEDJh4D08LTfvDaqCvRa18Z4nmGG18p1amowHRp0nJQ6Qtt2VVv1Zarod1FaZcpK1w6UQw0QYeEiDcP/DJUxnWU29lN/x8KnqUHKfD5FhuVacMDGIFMg+Okx+tWpvHTQAbkNOQJrFMrGiaAHz0b2uQ0F5k/FhRuBLRFNIrwl4slxevcX7ju9olI/AyxXmynyMxTx8IX
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(39860400002)(136003)(396003)(230922051799003)(186009)(451199024)(64100799003)(82310400011)(1800799012)(36840700001)(40470700004)(46966006)(40460700003)(40480700001)(36756003)(478600001)(86362001)(966005)(26005)(41300700001)(426003)(81166007)(83380400001)(66574015)(336012)(1076003)(82740400003)(356005)(2616005)(70586007)(16526019)(47076005)(316002)(15650500001)(6666004)(5660300002)(6916009)(2906002)(7696005)(8936002)(70206006)(4326008)(54906003)(44832011)(36860700001)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 21:51:34.2932 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 460f4d5b-97b1-422e-8101-08dc275dc95d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8088
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

commit 5095d5418193 ("drm/amd: Evict resources during PM ops prepare() callback")
intentionally moved the eviction of resources to earlier in the suspend
process, but this introduced a subtle change that it occurs before adev->in_s0ix
or adev->in_s3 are set. This meant that APUs actually started to evict
resources at suspend time as well.

Move the s0i3/s3 setting flags into prepare() to ensure that they're set
during eviction. Drop the existing call to return 1 in this case because
the suspend() callback looks for the flags too.

Reported-by: Jürg Billeter <j@bitron.ch>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3132#note_2271038
Fixes: 5095d5418193 ("drm/amd: Evict resources during PM ops prepare() callback")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index b74f68a15802..190b2ee9e36b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2464,12 +2464,10 @@ static int amdgpu_pmops_prepare(struct device *dev)
 	    pm_runtime_suspended(dev))
 		return 1;
 
-	/* if we will not support s3 or s2i for the device
-	 *  then skip suspend
-	 */
-	if (!amdgpu_acpi_is_s0ix_active(adev) &&
-	    !amdgpu_acpi_is_s3_active(adev))
-		return 1;
+	if (amdgpu_acpi_is_s0ix_active(adev))
+		adev->in_s0ix = true;
+	else if (amdgpu_acpi_is_s3_active(adev))
+		adev->in_s3 = true;
 
 	return amdgpu_device_prepare(drm_dev);
 }
@@ -2484,10 +2482,6 @@ static int amdgpu_pmops_suspend(struct device *dev)
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
 
-	if (amdgpu_acpi_is_s0ix_active(adev))
-		adev->in_s0ix = true;
-	else if (amdgpu_acpi_is_s3_active(adev))
-		adev->in_s3 = true;
 	if (!adev->in_s0ix && !adev->in_s3)
 		return 0;
 	return amdgpu_device_suspend(drm_dev, true);
-- 
2.34.1

