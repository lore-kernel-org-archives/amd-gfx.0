Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF880EE49A3
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Aug 2023 06:18:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FDB410E2E0;
	Tue, 22 Aug 2023 06:18:12 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAEBF10E2E0
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Aug 2023 06:18:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5sOCoFp1KwOapizLdU+LFsGWxmCeYDNKiOTJvJDrUGQ1Aas6KXUoH1D43Wy/JIAktciaKjd/ScAbTwczW9aH8eTEig0fhxqLaiIjjsC6yXU5SbYxiYig+35shtKLZYCYaWB1d32+iSwryJ/QbBA0GaoISTVJ00iFTrg04AyFulzbXGpj7ARXn314DW8Ff3zm1rcyioXwxfpvsaGR1W5KztOg2lAR/tGZBmNbV3c9MOsBKbjpTeKLvciiOH/VKmRae6XQimVFr8w7kPyBK/DVd28HHMS4X2+/Uiw7vhNLiMIp3/365nSUHO4f4ijR4Ll7YVtqW1OEdE+Tplls4GJmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wU7uIFxXTHhLO/+XQsnmiz2Bd8KiDef3XgitqAFDufY=;
 b=Y8sk1TDNuvBZS+abOA3+EmYWdZPj/QqA7vr8AE0nKDpBVCoMuU+GD7gHbEV+viLjqXv74TJ4/V0gjj43N4cSdClN2dsEsGdLlYtEed30erpmrtnawJWTKkuJup5pPisPnNaZHB9elfriOECXtEFe7o2Wt5rI4mcMKvTZDP4AaDP09PQl7OQNBoN3y6xHQy05xuSPZdQIZMyzD9crGMCUj0RqLHgF4LugutyP3m2PFphJEUOmHqfM5hthHBif4LmqRk7YvAUlsTCc/CLfcJXxVeN4FUzWTYsUZ2FaoPlDj5ZJHmck1tw9oclI1Ok+Ye1NfDXqH0v4QfdTrtVNsa2KPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wU7uIFxXTHhLO/+XQsnmiz2Bd8KiDef3XgitqAFDufY=;
 b=HNCQdh99z2xisGtBfaef9btyhabQtVkNU2QhQXVJTJ6U+8tCHUcSWrXlBBG8AHgDw24gT7GHp9WpUPR62eakD2492n/KvDhpho5hN9wNYYZ3q6oFGsb4Y6/ufZk8708sooyv1chwIhUaHJBUB4gzgOS6hpXc+qzcJVOfXMoN3FU=
Received: from PH8PR07CA0036.namprd07.prod.outlook.com (2603:10b6:510:2cf::9)
 by DM6PR12MB4185.namprd12.prod.outlook.com (2603:10b6:5:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 06:18:08 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:510:2cf:cafe::c6) by PH8PR07CA0036.outlook.office365.com
 (2603:10b6:510:2cf::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.22 via Frontend
 Transport; Tue, 22 Aug 2023 06:18:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Tue, 22 Aug 2023 06:18:08 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 22 Aug
 2023 01:18:06 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Put page tables to GTT memory for APUs.
Date: Tue, 22 Aug 2023 14:17:24 +0800
Message-ID: <20230822061724.3917603-2-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230822061724.3917603-1-yifan1.zhang@amd.com>
References: <20230822061724.3917603-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|DM6PR12MB4185:EE_
X-MS-Office365-Filtering-Correlation-Id: dd23abb4-496a-4132-12fc-08dba2d78dbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t3FEkFrR/7FgWCsQRTwodUKznZuTZJUEUGNa/1H6L2PIoZKS6Itl7VdvlufKCuujAmMbPDLsntNvBgRQIdD1tpBPVgNGu8YFvqBpbEFKI72/mKmvbcif/0DzmKwT1tIUOuathU86cskBZe95b0XPc8FVxRFdieoIRQDbI+44cZgXojTh7LTmj+Ta9QL7TljTM5q9Nsy2f9S1EvaWCAHM9SQH5tbBi63YYEr0L7F3WbXI7OswsKNp8OdFhLSL7CIT3DIWgxur+pcz2h3RJL9VY/c+eWnoGLbmHUIp37iyQozqggpjrauet14ML8doDVZBTiX6UFISSq3Cp4V9os9lbZlq7jj+qWwiSmlhKVLx69RRUQOeDA7H66EXLOgnNJv31ovdlqr1S92xCDgUdHwPlS0D/cNo6gQSbbFCJ51yu04tleKP5RwtMrmubVSGwbLJhiwxoSuTvXmuD3M+FTKevAgjGBfMp40Sva9IXDah4EwlIvSwBcdyY5qnVYhIMxf4ZbtiHqEIfcY9oeJwcYu/9dpDyqf8o3GOxkQEfEAzNEHc7kC2i57pUr0wkfnEY4+/EDKZjvfC4NXQZmQJ7NaWkYiAR27PWOtcx1AtxjXbiSetuTOKONjmDLCLpFd8H7JS+/+RcA4CcEJA3PhuNHmcH1zcqyRicWu4qSBacS2QRG7kCFKyi6mXN0ouXAc1nAYoO4LpM/Qgkj9h9bxrrcSadvnQj1y+tNw9QAq5E826mqInjr4W/PVNh/Hob77MKUHgXuCJfZK5NfuCbyd10XVhHA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(82310400011)(451199024)(1800799009)(186009)(46966006)(36840700001)(40470700004)(2906002)(4744005)(7696005)(40480700001)(83380400001)(5660300002)(426003)(26005)(16526019)(336012)(86362001)(36860700001)(47076005)(8676002)(8936002)(2616005)(4326008)(70206006)(316002)(6916009)(54906003)(70586007)(478600001)(82740400003)(356005)(81166007)(6666004)(40460700003)(41300700001)(36756003)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 06:18:08.2144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd23abb4-496a-4132-12fc-08dba2d78dbe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4185
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
GTT domain.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 96d601e209b8..26063e611c49 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -515,7 +515,7 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	bp.size = amdgpu_vm_pt_size(adev, level);
 	bp.byte_align = AMDGPU_GPU_PAGE_SIZE;
 
-	if (!adev->gmc.is_app_apu)
+	if (!(adev->gmc.is_app_apu || (adev->flags & AMD_IS_APU)))
 		bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
 	else
 		bp.domain = AMDGPU_GEM_DOMAIN_GTT;
-- 
2.37.3

