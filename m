Return-Path: <SRS0=7JJ9=7Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376C6C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2020 06:01:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD77C2072F
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2020 06:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Air+/Pqj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD77C2072F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 354AD6E184;
	Thu, 11 Jun 2020 06:01:54 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690080.outbound.protection.outlook.com [40.107.69.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58B946E184
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2020 06:01:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PsREFa0clvruobPcYaqyyh74iYD7WeEJu1YMD6sBcxG/8etj4imQ0LCIbLgWJ+xz+kW4JcBbk5Yj3M7KKGQMWOo9MN+z2o3Oz1eR/r6IYtaLOgmcyu5hnv+nn1WlE5gAO3cukXr5Jdeauu6dtpuN2hegqp6dVorrKmVsJsI1BK0nig0c6XN9alNRG6aG0sAE4Q6ZN21q9EEkT6usyM7fl8ePMq4T9GirPBdS7GCuOvT9Btqm+DFgb/1iSECwVQQ5NzcWb6sT8Zwn/TnHdNcmm1tSodhUxJ/cZPv5LYJIo4uEO99jW6p/iFylt8IEcw1XrnYJpyjfbf3XF70PuqyRng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOcOo6u6LL74TArWmXAaBnQTcKERbYtbREPVeRHZeuA=;
 b=Ol5Gw3GFQgZsjjQkbbjU9a5jPiQWUK4RGdjD0jVa1FZn7jfwlYX3y5opGi0lSX193KI6Fnq8MCMmtGmenMuS2j5NRgkNnATgJw3VHeK+vQIPVKagktLfKGcKDwshJ661l0gJzFFI0Rs+o20WBTovicVDtXnClrZQCNi+58SCWuCqxSQPuKU9XK6ykbR6fCt7JXVHK8cgA1Vg9m+IZMgL+PI//sRuIdGDF1tHV11VdO3Ml2TCYjuWEkzVq7b5/zv/gQ+GmEetyCnqaht+3kmFhPORZF/aRwfAi6JRUsaG6Kqk/bn9l/J3JYO5aoPbVa7uUq/ujyJF8bxLNaTrNAeK+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOcOo6u6LL74TArWmXAaBnQTcKERbYtbREPVeRHZeuA=;
 b=Air+/PqjN6ZDvwbla0gpLA5ONd6CbGIGrB+OGbvF1hYHD3t5S8GqfS3hB7MMHNrYNkQb+Pv4F9tWjiiBH2mBirD0z4mKtiuP1yng5mqEEeh5jp73aQgyWV5ur+X5zwWpD0P8D+5V+Xjy67FicburrxVJJ+nP7UlP/DvrakjRrf0=
Received: from BN6PR22CA0060.namprd22.prod.outlook.com (2603:10b6:404:ca::22)
 by BL0PR12MB2371.namprd12.prod.outlook.com (2603:10b6:207:3e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Thu, 11 Jun
 2020 06:01:51 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:ca:cafe::6e) by BN6PR22CA0060.outlook.office365.com
 (2603:10b6:404:ca::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19 via Frontend
 Transport; Thu, 11 Jun 2020 06:01:51 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3088.18 via Frontend Transport; Thu, 11 Jun 2020 06:01:51 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 11 Jun
 2020 01:01:51 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 11 Jun
 2020 01:01:50 -0500
Received: from emily-build-machine.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Thu, 11 Jun 2020 01:01:50 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/sriov: Need to clear kiq position
Date: Thu, 11 Jun 2020 14:01:51 +0800
Message-ID: <1591855311-13218-1-git-send-email-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(46966005)(478600001)(82740400003)(356005)(7696005)(316002)(6916009)(81166007)(426003)(8936002)(47076004)(8676002)(82310400002)(336012)(2616005)(86362001)(70206006)(36756003)(5660300002)(186003)(70586007)(2906002)(26005)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4de38cea-ef3d-4a0b-0455-08d80dccef78
X-MS-TrafficTypeDiagnostic: BL0PR12MB2371:
X-Microsoft-Antispam-PRVS: <BL0PR12MB2371FB7502F384539C4AAD6B8F800@BL0PR12MB2371.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:227;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Boo2nOnbq9opf+PA+F9IyQpQ+YYsb8QxuusWVrpW2g865p1xApNbGgRo6HvrQIIEh49GoEyUI15h4HPLMuu9lCcPMJB4CRBAs51ED6Riayf6bP3K5HbM7mKWyVHMau2vYB3vz9xbzDhpN9sGfxlxh+v9/nrjN3LKbUgCFmLrbczlxc/yREZUCEolsv3kwFcszFnro/jCZfdn5E0XRvYUhEsEDUtVQ6kaZtbxFuD2f3ZQYLE3fKMiUsbJrSPEkN9xoGZf7gfHZV/ZyN/QL7WGnXPp1WKjyVhVeQk19SPoWaejSN6SAkr59IDCoq4fAoOywzMe03nxomB8Elh2n5XCmvFLdVW6IRL1we1x1TdpD+ltmoVXMJeXCKrIvsVf+f8lt4+Bn2IX85vdA25skEw/Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 06:01:51.4614 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de38cea-ef3d-4a0b-0455-08d80dccef78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2371
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
Cc: Emily Deng <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As will clear vf fw during unload driver, to avoid idle fail. Need
to clear KIQ portion also.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index e9045dd..323285e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6876,6 +6876,7 @@ static int gfx_v10_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int r;
+	uint32_t tmp;
 
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
@@ -6890,6 +6891,11 @@ static int gfx_v10_0_hw_fini(void *handle)
 		DRM_ERROR("KCQ disable failed\n");
 	if (amdgpu_sriov_vf(adev)) {
 		gfx_v10_0_cp_gfx_enable(adev, false);
+		/* Program KIQ position of RLC_CP_SCHEDULERS during destroy */
+		tmp = RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS);
+		tmp &= 0xffffff00;
+		WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
+
 		return 0;
 	}
 	gfx_v10_0_cp_enable(adev, false);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
