Return-Path: <SRS0=9SYE=DH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC377C2D0A8
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2020 07:37:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E5502075F
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2020 07:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3qZFHhqa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E5502075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 673B26E4CF;
	Wed, 30 Sep 2020 07:36:59 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F14666E4CF
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2020 07:36:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMyywcjqGNWhl9ICxDy/AJGb6UZJQpGfF7klI382Vd7fPDmKqE4r+i73IUZvL6czKH53ecIXqiQA49MR8geka5chYI6Mcp8niv6d17YSD/hi3DrP5X64YWtOLVowJ0Hg3lqUhBhsVmH5WtKrGTRT9pBuesGqiCLCww/zr4da2MXGj7ZPRd7vJc0SDWi88R8nrt2d6NAulu1gUhgtN1l2ZyyUHSbSVuMnbtuwhOxyCoo9U5WevXjJgqKldPuxzNlvTG3v1bwWPeYOgVnLuS5SUMNVVt5nUDNixFOwWajwsNQHdA2tr7LIYOq/uLySHSRmKkmFq5uc+I7IhrfCme3LFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pyhtfH3UvKKdtRiLbYf62kLnqdV6jEIz9Hvz5XqqxBs=;
 b=XGjvF7rOPm8/ER4mrosTYtV26/A49oRFgMqIdxuYlfSYaaWp2Bw8oDQ1CPaDl2MFhvSKtzI+jAj7dbV174PD4eK4RabiC4Z7nbwRmrpXxY1s+h+6OCny/hR/RLKkk+gt/QlIICuaRZBuaklJe2tiLBbvkdjMlMP5fKJd0DWICzMxtQWYUx0NVLD0Dk9jytezFg7JIVGCzWO9Fb5j/wDX3xo23sGRvLb89prYoclZBjpJOJXNblQXiH8YxmuCAEJhWObvJOffCGwwZcO5QQ0zL4zfYVfrJGvbBUQPV1xvLS/aQ2nPTKM9i+Y1y6xfse6HXIaDbHv0jmBMFsWn/y9h6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pyhtfH3UvKKdtRiLbYf62kLnqdV6jEIz9Hvz5XqqxBs=;
 b=3qZFHhqaO+Yd/mNDgjL2e4ife6Gwp3B5nvU9ifpVtGCEVDPNk06Fm9xS0zaYTL4uRymjdXrKw3Pvng0IUnhvlvtMogS3OaEtJbso3NHR4n3XOhD4G3RyqjyPjgWef6yVtnaIoHauD75W3VoywXFTv4inquhpcLGefUKyEWmfHC8=
Received: from BN6PR2001CA0048.namprd20.prod.outlook.com
 (2603:10b6:405:16::34) by MW3PR12MB4473.namprd12.prod.outlook.com
 (2603:10b6:303:56::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Wed, 30 Sep
 2020 07:36:55 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:16:cafe::97) by BN6PR2001CA0048.outlook.office365.com
 (2603:10b6:405:16::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32 via Frontend
 Transport; Wed, 30 Sep 2020 07:36:55 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3433.35 via Frontend Transport; Wed, 30 Sep 2020 07:36:54 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 30 Sep
 2020 02:36:54 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 30 Sep
 2020 02:36:54 -0500
Received: from navi10-sut.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Wed, 30 Sep 2020 02:36:53 -0500
From: Jiansong Chen <Jiansong.Chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: disable gfxoff temporarily for navy_flounder
Date: Wed, 30 Sep 2020 15:36:42 +0800
Message-ID: <20200930073642.7438-1-Jiansong.Chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9b39d3b-c41a-45a9-5a4c-08d865139ad5
X-MS-TrafficTypeDiagnostic: MW3PR12MB4473:
X-Microsoft-Antispam-PRVS: <MW3PR12MB4473D1D0C8EA07EF3DE37955EA330@MW3PR12MB4473.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +OZoVfqeKox/vAZfTq4u7YklsHe/mlsUdbACJL/ecRV73v3PX7U/+GDWuDXmdLBdQW/ijLOcf2l9bXqnagQudoiIsSTA5fN+GZmfyo8AjnALxoDz7hSV6k21+IAJGoWPM8vZsqEnjDzh2mkcAR65R94/M8qM1Km74xpZED8LjiN8mDprd/k1VIMK+JgDdxQ7He0/vRC92UVV3nPlgmyA50vH30Usgkrt3cW8k+jvAtKSP4yUb8dmoyYRoYAZw0IGutmNiaMfuISAT2JYUotePM7kVk8mv+hT2br6SCzJ2zkDRLW4BazkYQfoqfd+yybMtFfEopmWAUBX0Q+vNNJnA7qwrt3GnnXisLwhF12Y424M5JxIws7gG9L1Qjz52AKJzFVMfjdh4gMePfEXGgcB3hXutLJIvPJnqWMm79DG3Ee3rmbh7Wv79Kil+Hjl6Vzd
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(46966005)(478600001)(8676002)(6666004)(1076003)(86362001)(26005)(8936002)(7696005)(4326008)(82310400003)(186003)(316002)(36756003)(82740400003)(356005)(70586007)(426003)(2616005)(2906002)(47076004)(5660300002)(70206006)(54906003)(83380400001)(6916009)(336012)(4744005)(81166007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2020 07:36:54.8952 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b39d3b-c41a-45a9-5a4c-08d865139ad5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4473
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
Cc: Jiansong Chen <Jiansong.Chen@amd.com>, tao.zhou1@amd.com,
 hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

gfxoff is temporarily disabled for navy_flounder, since
at present the feature caused some tdr when performing
display operation.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: Ib2be4041f82a3f5e12c657541c516815c8eb3670
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 17fb2efdadd3..9792ec737029 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3610,6 +3610,9 @@ static void gfx_v10_0_check_gfxoff_flag(struct amdgpu_device *adev)
 		if (!gfx_v10_0_navi10_gfxoff_should_enable(adev))
 			adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
 		break;
+	case CHIP_NAVY_FLOUNDER:
+		adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
+		break;
 	default:
 		break;
 	}
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
