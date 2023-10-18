Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 757FECDB47E
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 13:10:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A806410E029;
	Wed, 18 Oct 2023 13:10:35 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E53910E029
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 13:10:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWCHZcvh4fpkvI/jtyRz8fafPEm5GlPaoe6+NY0GTHVGvCZiYz5fN7ycK8AWah4YAn9oxUZkuVlSI4p0rReIBB/rcnyw9fGI8hLNUShQTCFy3m4DdYoqcFakzYgrBAqRt37C7vZOiuHqJPC9JLFnxaCB2frf15Ydpriao+HYZeZrIKFUqIDtfAQB/IYvx2iZHMY4o+DRGUL5Ap4YQwDRe31jZqWVGffKYhwj17XjSNSmqPGouSk6doCrmmTfxojf6b480eh9IMuqmZoki1ziLnh/WbMypPyhjYjSSWcVW5vdlHbhajSvVdTy33qY/SQtwYgKpDX4Kw8QJBSqgyhmGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwEqSuR/IxhiM9jlB1mD2EsfO+R46pOatkf9TjeU3Hs=;
 b=XpbPfLmVPKXlNJib+flr33zFmbvGif64GuTjM3aah0uZIuIwu8vkVG0Uhe91DW3ombGQnBlBk8ExTs7ndl/lVkD2wlcWNGqDAt1B1yqWPky5OqXDEUzrTssvLht9D/cDnVFEqePA9G7mfL5MNmu4MaVYZ3Hgigsg9OFXnl2QtVJsJkMB7IkO7+siNqW7i5HV7z7qW1YEuAVGd4rtUkwXOZNh4s+WkolLMbynFGXeIdtdW2+YqXj6LrQgcCYQUBqSxNq+U5dQ85G0SyGFIWSN8V/2bzi6MvzCNIkoghfCrjnHTkIsC+CN2gw3GnAKcYPdJ6OvjyAUCXrUGt6BAqBAxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwEqSuR/IxhiM9jlB1mD2EsfO+R46pOatkf9TjeU3Hs=;
 b=C5EdmbDTR2op9zFHdLkDjvOP31TIClUGYFNojEygInVYxRYIb/UCdUNG0Cb1/Z3xnA7hkw/GAX0jW8nHd0ftcvQUCrKVcZt7oJFN9Vw8AEC+rIa1OCDMikfEdrdmBhQOgxZ24j9FwBFGxgrsRH0XbEjY7Q33qrt6I9iRwmmDsxk=
Received: from CY5PR14CA0005.namprd14.prod.outlook.com (2603:10b6:930:2::14)
 by DM6PR12MB4268.namprd12.prod.outlook.com (2603:10b6:5:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Wed, 18 Oct
 2023 13:10:30 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:930:2:cafe::c1) by CY5PR14CA0005.outlook.office365.com
 (2603:10b6:930:2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Wed, 18 Oct 2023 13:10:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Wed, 18 Oct 2023 13:10:30 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 08:10:26 -0500
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 18 Oct 2023 08:10:25 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH Review V2 1/1] drm/amdgpu: Enable mca debug mode mode when ras
 enabled
Date: Wed, 18 Oct 2023 21:10:17 +0800
Message-ID: <20231018131017.3280997-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|DM6PR12MB4268:EE_
X-MS-Office365-Filtering-Correlation-Id: 32bd92ff-140a-4003-c915-08dbcfdb9acd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9PIzYcJ48OcdVdwkr/pcTZGvOqunfSnEKbkLy0ngwT2Io5XeWslZUoE7thYTY+FpV8+ap92Zo4lFD4bAa+5JkadnInOz7b+sTcJNVXulyM/PtDqqALaen5yw0Wpt6JB9GQOoL/2xxrl6B6whqZlY9AgW7LOTDsGFZmbUXwib4e4YX5DGr2OcxcCQsZb6KC/pnoNEkY76hVAJoqhsFu3BzNtvzC5d6ZVmR7vPS+ne/DiorWKQQLlMutJz4lBSEjETscTLry6Jys2BpU2gex4hDN7Ke565Hwj0o1rxvgcCX4LRvKENTJzBL1zOCN3kEA8dc3kI27M4RLVjcLQ41O6sSiY/10MxyST8V7GrjhwkWZKqLQa+nIxnZqrT3RyxOWgsI4DjS40HBypwyI3q5lDRIQ1ZHKczXcxqYO9ax+sujxH2o0IGdlg7lWAS9lEvLhWFmac6Wafu9+A7gkXfXYAcA4XGaUvhex0901cgr9143Kes1DO9xi0PWMUo5/FJetqpfZKK9dHV9fszQ2DQkHWco98b0kqPkI7IIevK864NR54Qp+jA/3EyjGuCcgXSpC9gg1qXM/Otu5X6X1OIj2AwTMAoBZ4o2SRiCMk5kT/gwVN2uNHTWfJCXOUBWAzy7JPbG9uLDqSfUnakG9XSp+1VCwK+SDUHRxVsKAdi54BF1bdOBmCdB6gIwcTkmacBIoAhOi91NkVtdFHTysN8LSbtKE45lCNe5zKB+q5S1vRMIavnEeUsyH6/OPr9EH0Bklz+DuVnUs3IvwlIOaUlZY/ffA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(8936002)(1076003)(426003)(6666004)(83380400001)(478600001)(2616005)(336012)(26005)(36860700001)(47076005)(316002)(70206006)(6916009)(70586007)(40480700001)(4326008)(4744005)(41300700001)(2906002)(7696005)(8676002)(5660300002)(86362001)(356005)(81166007)(82740400003)(40460700003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 13:10:30.4084 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32bd92ff-140a-4003-c915-08dbcfdb9acd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4268
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable smu_v13_0_6 mca debug mode if ras is enabled.

Changed from V1:
	enable mca debug mode if ras enabled.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index cab5a5569bc6..89c63237e470 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2298,7 +2298,7 @@ static int smu_v13_0_6_post_init(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 
-	if (!amdgpu_sriov_vf(adev) && amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC))
+	if (!amdgpu_sriov_vf(adev) && adev->ras_enabled)
 		return smu_v13_0_6_mca_set_debug_mode(smu, true);
 
 	return 0;
-- 
2.25.1

