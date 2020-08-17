Return-Path: <SRS0=yJoC=B3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6C7C433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 14:46:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29FEF2078B
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 14:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="V77wgU8c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29FEF2078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C37F66E0DA;
	Mon, 17 Aug 2020 14:46:02 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64C636E0DA
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2020 14:46:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UqKwFFn2J6FJHj/Ua86eChivSAQhWGhyllOfTpGNQvYXpkiZahzabn0MeGBgvhyEw0zkPfiNkglkORwJOpwYuYQWAfViqmnW83UbWy+dgjK0c0MZzLDKU0v5oJJ5H2N+DFr3HMrZDrIi8Dv5BxAMN+8aWQdxc+Sl6RoSkJIW31ZFdDDtv+UwW4s5pwZhdw3YvJIrWl+FgUiS3mDGlPgNaQv7X8OLAeHBwCa167ru4x8PVqnS14zu7y53irX10UEKEci/gCfQm4MZFHVMcCxc0dNg2IQb+VZLoBew6TV/YsDVWDmkQKetxu8EQ4cvnF7QqBXDBBAO3wBz82LN1R+6TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLu9QB98nFbschPVabLnsL6e8kRGS+dcR77GiIqqwx4=;
 b=WABHqKmn17UG7Pyhaicl8Uvcv9JIGpDjfx6AooXAfzunWvwcIvuryUArVvLQsu04UG4TlEBEHSDzifID88j583HU9Hs7dTUnnq7eIRYisb+wHQ19kksZK5VF2TQ8675M9bgiPHkP/tEAed7Ir8aBoezCYoGe0fJWA7CzLPo5HaAzxYi3XjP3y2WRaWPmnbg8pTRjsLtn+wlSJPQUyOS9l+aniw9CPxi2CZwUIOrFCEpK08WB/JGDdToiHTi6/jQlpp7to6WoqFlI/f2mM7z8HucrDwA/dKE7OBBKX/h4FeX6nCBXiC6ZSr9JZ1y4WAYA3Ui7s6BkC35sR2v/aMoElQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLu9QB98nFbschPVabLnsL6e8kRGS+dcR77GiIqqwx4=;
 b=V77wgU8cz6Scp6Z+W46q/3vrhD7BBGXml/gQoYrH14373LX09bfzilhcha/0KQp1TBhNetGgWQZTsl08orBH/C8EoSz78FoxPuT51aDoWueYK5YvYZt9nuT1XBHVqhr7FV7Fp9J67KtbgI3FFu6C+NvHowUiPf4w2LzGW3T8Jqk=
Received: from DM5PR07CA0108.namprd07.prod.outlook.com (2603:10b6:4:ae::37) by
 MN2PR12MB3535.namprd12.prod.outlook.com (2603:10b6:208:105::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.20; Mon, 17 Aug
 2020 14:46:00 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::6f) by DM5PR07CA0108.outlook.office365.com
 (2603:10b6:4:ae::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend
 Transport; Mon, 17 Aug 2020 14:46:00 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3283.16 via Frontend Transport; Mon, 17 Aug 2020 14:46:00 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 17 Aug
 2020 09:45:59 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 17 Aug
 2020 09:45:59 -0500
Received: from navi10-sut.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Mon, 17 Aug 2020 09:45:57 -0500
From: Jiansong Chen <Jiansong.Chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] Revert "drm/amdgpu: disable gfxoff for navy_flounder"
Date: Mon, 17 Aug 2020 22:45:49 +0800
Message-ID: <20200817144549.16407-1-Jiansong.Chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00b0db55-f4c9-4692-d77b-08d842bc4208
X-MS-TrafficTypeDiagnostic: MN2PR12MB3535:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3535D4BBD61F812C70FB1F99EA5F0@MN2PR12MB3535.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:345;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YsQP4J88Tm5RH//bbQU22huhIDNWYYsw3zo2NVMICV1k8lV4xbYFCd4BoiNYWLwGhzeb6oUEwUQyZjnyh/cmzaKy8suu1uOuQaPkJH5U34fjm29MmqwhUzlhUAeFP760pclSaNe9fgJ9KcjKMdmgxV9flhkCFeg/ebJc/zsPLXOgYSewTqvx0JkXduEj5KXtXHQbYl2ruE4D0c+0lf5YEtDVCaQK2wETqKqunQgQgihcBwg3i+5EP/Oqi4YrKWiv9YrS7Yj59kebapNnwpp7W4d44Ixcq2QndpZfDng+30Bm/1O9XvxwLhUJXMwSL/Mhd659m8rmvAbvat8d4bIg2gOAqzPMqphhhDtYzVIpwxVOLzXgvWZ/xn+bpCFN9rkQ3I7x24ba8Aux9aD3OOYiyw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(376002)(39860400002)(46966005)(7696005)(8936002)(36756003)(26005)(2906002)(6666004)(2616005)(70206006)(4744005)(1076003)(426003)(54906003)(478600001)(4326008)(83380400001)(82740400003)(81166007)(316002)(6916009)(336012)(8676002)(86362001)(5660300002)(356005)(47076004)(186003)(70586007)(82310400002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 14:46:00.1246 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b0db55-f4c9-4692-d77b-08d842bc4208
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3535
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
Cc: tao.zhou1@amd.com, kenneth.feng@amd.com,
 Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 6a72ad7e387c6fec821c230fda3460f79fc0f877.
Newly released sdma fw (51.52) provides a fix for the issue.
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index e87d43537013..e527be22a3d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3610,9 +3610,6 @@ static void gfx_v10_0_check_gfxoff_flag(struct amdgpu_device *adev)
 		if (!gfx_v10_0_navi10_gfxoff_should_enable(adev))
 			adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
 		break;
-	case CHIP_NAVY_FLOUNDER:
-		adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
-		break;
 	default:
 		break;
 	}
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
