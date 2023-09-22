Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B628ACD4F2E
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Sep 2023 08:16:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 029C310E63F;
	Fri, 22 Sep 2023 08:16:27 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F216310E63F
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Sep 2023 08:16:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUCE5M6H3TylTg5hh6tsvdRXwDaGETZMRkfBAuSX1X0Gm8esVxUjbD6w9QudmJE5T8iG3m7amNVbl2mcLm2oySVXLuzOSDs2/aL0HgUdMRvLWTttzL0ZtAA7bEt//vmjMBegPe3WznbVi6XdUWvkYDqcrEAyUtvACt+9XljmSWPVZ7emkkAI2eqAJaTikaEesTRXxFO2RveBrdQdJzplvkqNmFFbrSPCcccOWUIvrKH0vQZU8WYG6PgVetY3z5wdFqgYI+YEY1iyMggbMhrStMcl59TAHamafri21zgouxShT/lVp3YcW+IXyU/dMBtB1R6qF+8wD0jZQknyK5JodQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oo+lgd94PHsF28aKywD7+lgeq1YjBMyeyfS2yNO8CoQ=;
 b=mCdN4v8+ohQcQkDNpqlMS0SBIJbCIYsZUR92/lRUa14F6o78bYmwFeVDVkxjyOt4SOt5xl1biAftRckDQLPfx8sqPV6xLe0Hpz3+2q1IfBz0JCQOk81t4NcCSHVpB4c8XGEJgydJjLsNooMFNEoh6NBuWllBu7tIPRZMYZxF0ty4U6gfxAlqfumu356ypDjXxsSOKv6+7DLGYHx0/mSpK8cPnR193NvEGv944C89RyAdkWaevjZfwikIJyp8yfCVsKre3HqglSHQ0BYa/BucjS0eW4fQcvHa8uDUCzDXiJCPHQ6I6ieL4K/RDuRDt6n2jWrOvIWCvcz8KQm9jbfceg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oo+lgd94PHsF28aKywD7+lgeq1YjBMyeyfS2yNO8CoQ=;
 b=TY/C5EjiFZUbupt3z8U5yDCB5UvED4ntIxct5uuFt+NupAnKyYb9lxaSLlewbTHcA/A4keCdfstgxydmj5HDnkQdIxgcwo9qP9aHUcyoVPIZ0tePT+fNvH8a88CiqkgMn+C5yBj7KSL35uFrctbk1B/hZNSId0B3AHzx0TI4DUs=
Received: from CY5PR15CA0114.namprd15.prod.outlook.com (2603:10b6:930:7::28)
 by DS0PR12MB7825.namprd12.prod.outlook.com (2603:10b6:8:14d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 22 Sep
 2023 08:16:21 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:7:cafe::3a) by CY5PR15CA0114.outlook.office365.com
 (2603:10b6:930:7::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.34 via Frontend
 Transport; Fri, 22 Sep 2023 08:16:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 22 Sep 2023 08:16:21 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 22 Sep
 2023 03:15:59 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/vpe: fix truncation warnings
Date: Fri, 22 Sep 2023 16:15:36 +0800
Message-ID: <20230922081536.3998673-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|DS0PR12MB7825:EE_
X-MS-Office365-Filtering-Correlation-Id: 857da861-afb0-4242-4b4e-08dbbb443467
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +GkfO152yj7ykSf2WDj3fa7h49SAYTcEgGQjaAYifIvnlUIxs43oQ+jSHuocMwXNprM3FCBxgMKHdn0AE2dxIKQaCul172knpeIDH4BzGY5444l/qSBRn/gg8NKSnRYIDhHV1WrBzpYeDn3Vl0CGzsbm0kd6c6lxuNJBt2KsUv4QnEJ/jRvSU3tyfbJgGmCwdSFOD9ajGzfBmZy6YRr91e4VJjvky3WQdQGw2QmsYZ486BpUh8vXObtkoX3dzkv7gfJEdhd6HBxRcF4ch1P3LKbaHc4rfnTStKwYcOFSHqPyBH1VGe79HYfED98cadFbzcCXovVB/KobWNUMBkkJVM4VU6k7ofTuIOyMpwcMnK9X7Uf5LHAf+vXNj8dEIk+08o8h1Xoa9T5oJIpy9fVzZrlD9qFUZUdovwgqLGP5RLg6oIQ+LubCU0bLa48qIVrQXi6QQ3AD5CTmjelaoSvcElTZ/uhhB4g0EaMQc0SMYN2SHT0e1p55sWIGTVYOLw5oZcNdYhekjGIaa1PZJlGUZhP2l/mc/A6HZzfsVy1YptA0dnhHgC1HeWKGCgIS3wwcDScerwsEfuErL6PbGg5JXjQp6bzoBVVn97DXccyy2OnFQuhIfKRYo1oB7Voy2eN3YzT4VEOM9iiqchMdzRMvZRmIZBYnmyGqcAjDp5nJHmWOrzCTne3HDGTRteSdPtVVvTQuoGoLge8JMUng9uXnGT7gy/YokyUpUMo/84N7mvsReJrclh1THA0fj0Ot9Z3u/HXLtTl4yTvr25GVzaLViPSPvEdVaLOvlmU3b1QMcns=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(346002)(136003)(376002)(186009)(230921699003)(451199024)(1800799009)(82310400011)(36840700001)(46966006)(40470700004)(36756003)(86362001)(40460700003)(81166007)(26005)(966005)(336012)(36860700001)(478600001)(70586007)(40480700001)(7696005)(316002)(54906003)(8936002)(1076003)(356005)(70206006)(426003)(4326008)(2616005)(16526019)(8676002)(5660300002)(6916009)(47076005)(83380400001)(41300700001)(82740400003)(2906002)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 08:16:21.3318 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 857da861-afb0-4242-4b4e-08dbbb443467
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7825
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Solomon Chiu <solomon.chiu@amd.com>, Lang Yu <Lang.Yu@amd.com>,
 kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes: ab041551f4a7 ("drm/amdgpu: add VPE 6.1.0 support")

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202309200028.aUVuM8os-lkp@intel.com
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index a68354d03a49..81e5600bd545 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -29,8 +29,6 @@
 #include "soc15_common.h"
 #include "vpe_v6_1.h"
 
-#define VPE_FW_NAME_LEN		64
-
 #define AMDGPU_CSA_VPE_SIZE 	64
 /* VPE CSA resides in the 4th page of CSA */
 #define AMDGPU_CSA_VPE_OFFSET 	(4096 * 3)
@@ -52,8 +50,7 @@ int amdgpu_vpe_init_microcode(struct amdgpu_vpe *vpe)
 {
 	struct amdgpu_device *adev = vpe->ring.adev;
 	const struct vpe_firmware_header_v1_0 *vpe_hdr;
-	char fw_name[VPE_FW_NAME_LEN];
-	char fw_prefix[VPE_FW_NAME_LEN];
+	char fw_prefix[32], fw_name[64];
 	int ret;
 
 	amdgpu_ucode_ip_version_decode(adev, VPE_HWIP, fw_prefix, sizeof(fw_prefix));
-- 
2.25.1

