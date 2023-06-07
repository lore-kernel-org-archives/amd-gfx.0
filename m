Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE33C7EE23
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 19:52:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD2BF10E540;
	Wed,  7 Jun 2023 19:52:57 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EE9E10E540
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 19:52:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZGopeZAUiQReMHl037SWSAMiQ/XmDTczXh9Nm6GVxV6LjD1OruywaDrYze+POoHsZ66cMaLur/SkVHDIhbbTM/Q6UQs/GzGKVIf/lbwLSnodsOwa7oD3Fcl0MEHXpH6S2YzbDqzxLHxNRKQTUo6k1G2k6Sthwlu2dRxepjQxWkZD++oleJmPZVDPfSeAq3y7LIIldm0+n1Wfic7Kf82rX1EqZ3Ksph/1Ib7x0QkSI+LEFYCkoHYHxg5F3R4zbXWqKu05rr8qkgYfSgnIMLJYC8oWYv3EXlW3j9tvmbpotMnqX75HPNp0IEnDNlLuUbfztAi9g0AIzgbMRZ035F4ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZ87HA8P+aqSP8oSjEh+Cc/7B16qH4YEjHfVzToPdq0=;
 b=hWO/ArlI9BxZP0Vd6Tv6sk7/0xlHU/SsJEt0/hfAORZnNxRLHBJFMP9JHs7gHLU+kGk15HNLrUPJ3lY5DUxTPpOaf40DGo5JVFZWKiNmFxy6OZnPLshK3ZP2KfLayQzFTZJJMGGcKV4NjuAlrMajYf2rP/zkoeyBvn0tJ4y/oNRWtljqXW09Xo4Z2DqJs4iRgZCdIVl3JQYAjLSNx6uVrgqrNoX28AdGiKhzG+ZwhacMGHe/lUn1wlwD4se5vcwplfjSLU75SNU8lPkRoivePWc3DvCfmHSivzx7QfnNWXiULaSF6xDhhF4uWxzQm9dTkI88tuhuVJc2OiNeE5Dofg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZ87HA8P+aqSP8oSjEh+Cc/7B16qH4YEjHfVzToPdq0=;
 b=SoGi8H3tl3g34y4OpuPLCbmJLuD7fNAo8gGmEA6QIRjmzUGAPDI8KL/rwH5QGSn/i61c2Cr9uYuvJTS1a5CrkaaXTqUNcDosqJES99vBOmNNsXzmzoSH1tNEMQLD+xy/DrJQ+vAqsXOlzCKqH2N2RE/P4EsNoqXeaOtI5JGpKZs=
Received: from BN0PR04CA0006.namprd04.prod.outlook.com (2603:10b6:408:ee::11)
 by PH7PR12MB8014.namprd12.prod.outlook.com (2603:10b6:510:27c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Wed, 7 Jun
 2023 19:52:52 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::fb) by BN0PR04CA0006.outlook.office365.com
 (2603:10b6:408:ee::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 19:52:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.24 via Frontend Transport; Wed, 7 Jun 2023 19:52:52 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 14:52:52 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd: Make sure image is written to trigger VBIOS
 image update flow
Date: Wed, 7 Jun 2023 01:52:58 -0500
Message-ID: <20230607065259.48516-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT008:EE_|PH7PR12MB8014:EE_
X-MS-Office365-Filtering-Correlation-Id: b1976f8f-91c0-413c-da71-08db6790c7d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yDq00xWBwMoWpm36cNC1qbsBOAuI3ohQHi0zu3if570nx+TYwi7Oai6qaPtW3G3Klm2jBrS7dx7Q2AAzsTm13Ao4VNyixfoItsruHJ6zRqd4ptlv5OUim+YInKQrH3pjFWuFgY7F+zNKvYcOTJ2t/dkfSdycc0gi6+8q5QPmHyFcnCYD+jR/JjBMQxDb0zQGhFDWtSApZMws0RnDw5p63TytdgivKf4ACjXM/Hg92xpT6Nf73Jr5BybTmHdfeFSqn25cgzxa7btAgK/h14byJn7oPH9WV2I7hKqJqdESByl3C5zsCjWo9R99/323oLukfNHtT+ZJ7xl3zKJdgCjq4bz7tkU5FMIDx3Z4S3jaz/4t8gQXlZ6J/g8a6A5SjEiIcSQ0oj6C4X9SyGWJ+Lip11KS/ezZqZ24YWJxJsMLGgVBEd0H+bFhOggKFPT6zQ3n7AchvcNDVnz+yobR7BdquCp/zhbnoeVmNaWE3kKl7Q6nRIlYU/AMNizozqQBTwoOaKXHcHdYTTgrDr9Lo3O40Rlg9lcZw23QgNzYB6tFvXfMJei8ekHxlzViUd6bqplTFXboixEbwh5jlCmzQtIgrArjVzwxQEW54YyEJ7KsVY8UVKwYl4bqkYT0KDPhW08QdoO7yAurU0t6iLYNkoXuA/0G5Z6v26AW0rqro8fLGq5UxfhaTOTmsx0PPxqHDdD2xJktV5wqNwqhXKT+GTneHO5PoOKvZj8b5HW/0kYI0TwlXDJKzn6PhSWYoZYCA3PhepF9hKFSHvSVp70v+z6Yuw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(1076003)(26005)(16526019)(426003)(336012)(2616005)(83380400001)(47076005)(36860700001)(186003)(82310400005)(81166007)(356005)(82740400003)(2906002)(70586007)(70206006)(7696005)(40460700003)(44832011)(15650500001)(8936002)(8676002)(5660300002)(36756003)(478600001)(86362001)(41300700001)(40480700001)(316002)(6916009)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 19:52:52.7958 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1976f8f-91c0-413c-da71-08db6790c7d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8014
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The VBIOS image update flow requires userspace to:
1) Write the image to `psp_vbflash`
2) Read `psp_vbflash`
3) Poll `psp_vbflash_status` to check for completion

If userspace reads `psp_vbflash` before writing an image, it's
possible that it causes problems that can put the dGPU into an invalid
state.

Explicitly check that an image has been written before letting a read
succeed.

Fixes: 8424f2ccb3c0 ("drm/amdgpu/psp: Add vbflash sysfs interface support")
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 27559a05a67b..8c60db176119 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3617,6 +3617,9 @@ static ssize_t amdgpu_psp_vbflash_read(struct file *filp, struct kobject *kobj,
 	void *fw_pri_cpu_addr;
 	int ret;
 
+	if (adev->psp.vbflash_image_size == 0)
+		return -EINVAL;
+
 	dev_info(adev->dev, "VBIOS flash to PSP started");
 
 	ret = amdgpu_bo_create_kernel(adev, adev->psp.vbflash_image_size,
-- 
2.34.1

