Return-Path: <SRS0=Ny8F=5J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6930C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2020 10:59:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD70420786
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2020 10:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BXC1Lnq5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD70420786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F11E58977A;
	Tue, 24 Mar 2020 10:59:02 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDFAE89133
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2020 10:59:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEaA96Ul9OVkj7E/3kLW60scS6gkhN8jJ9ZrltQoosKwpY+diL1tUGJxVFoe4ayQZaWtWmrByGdUwFF+CgLkXK8JY/J9P4dzFkKZ7bK7hExJ27Hoj7MD+/YPFdCYEt0gLzzmVrtgaWxEzVU9az4Dy8uD2VfjANeKDJcg5YlJ71SIyCZIiV8bwfv8dKI9e4OnMUpwDmKUsGx9GNEF8psVVhg9NMyMM1zngdX4hgO6i85ntiv9TjSl9bKKYD3BEFpUU+4KNxVP+Nu/kQVmYVjdBnu85nWofb09TGFN0OxaJQEBLS+eIrefgo1SlDcewRaJyi9spHd+rZHcMjufxkNQdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ad2SHQBtUF17YtuCMzSpG8iNP0Sk4reUUIEBwCtG45Y=;
 b=M/+lBINF0pQsiboIXctF5OnkSP08VSyyLFROqymAl/Px56m5Ib0mkta7BVxiRLnfhv7Poq0YLISRDyBL+vHFj8leVoY2ehanFxoWHC82YWdgUmxj6F+A/nNTZKcDKfX00j9XM9n+ofB8i5Jc3HHNYtfPiBhQx51hIlrTDajzTg7FOqI8yn/Gfxb7NQqhvPzb3x0hsdTz4jc/Z0qepyis367vYQ/VvOc/8TG2287V+8jw+DMUvTNcyP3EdU54+C2f6yfSQq5NGYhCd9ahRQ09LMDwkD4KuU8Zxu9Af/RAjjgnHdubYr1o2hImCDQOmcr3YBTq/xoETfL+VtLCqDVjUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ad2SHQBtUF17YtuCMzSpG8iNP0Sk4reUUIEBwCtG45Y=;
 b=BXC1Lnq53BujphWo9bXPFMr8t+p/WRYtB8a388SlqDizMxZA1PSsJL7b5hkJnQaIVLG0qQuT3/ziJKinmlxVu50NYNnltPD4wCKjP+YZMBSBPQMRtp7mvjSKP8jscCpohPDD4IerdwUecdsfdzrnFjWTPwexRbHxdKNit0BwzOE=
Received: from MWHPR19CA0082.namprd19.prod.outlook.com (2603:10b6:320:1f::20)
 by MWHPR1201MB0029.namprd12.prod.outlook.com (2603:10b6:301:4d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19; Tue, 24 Mar
 2020 10:58:57 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:320:1f:cafe::dd) by MWHPR19CA0082.outlook.office365.com
 (2603:10b6:320:1f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20 via Frontend
 Transport; Tue, 24 Mar 2020 10:58:57 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2814.13 via Frontend Transport; Tue, 24 Mar 2020 10:58:57 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 24 Mar
 2020 05:58:56 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 24 Mar
 2020 05:58:56 -0500
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 24 Mar 2020 05:58:55 -0500
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amdgpu: don't try to reserve training bo for sriov
Date: Tue, 24 Mar 2020 18:58:50 +0800
Message-ID: <1585047533-10966-1-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(39860400002)(376002)(396003)(428003)(46966005)(8676002)(81156014)(81166006)(8936002)(4326008)(36756003)(70586007)(70206006)(426003)(356004)(6916009)(6666004)(2616005)(186003)(26005)(316002)(86362001)(2906002)(478600001)(47076004)(7696005)(336012)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR1201MB0029; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ff38a88-43dc-4b05-bf01-08d7cfe259e2
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0029:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB00298B03BCB668C17A13B0C684F10@MWHPR1201MB0029.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 03524FBD26
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jQcJpAJ2PNv8JFTHXTU8xz+1e1gPL26zWtnCCzDbOIn8zRZ65WNqX6tBIn8mRtdyIoizA2qG0neziLtPGqWCF9JSDs/rmXOvpjVrsSkQxhv9SttwIn951hYaFjVwtD0zMVdKCDDL3MTvJr+Ku7JKdiwRgA12rIsVLtUJkE6lxUzBzX5/Ot1K0YvCA9uGEJoMQYBqPf+/d1LOVCuEXXVIpziJvSYPiazyGpEYon4y2JGrl8ziODlHSf41cQ8jPU70YYW65iyGxAAskvU8ODAPHkdeK+4YYHJdZxQBl/74Q68kk9UxVUjvVMdDkGBx40LnRPVG9Hso2pCrLgw5CsuGJuH63chj9ubxYQX6G7xC+t2EVB3xA+VTgFZYET469C5Asi3mZiluQi8mAv6fixE7cPGNJPzAq238HIJWBuFsVnfvXTG38DyVJVJ7uGz+4dTXXwk6xIybW8rC3B32e1ZKRzJ6L3+FFCQdjtpCKTaEpXnCX9SUSebHuMvrgw8vq1lmYPMLr0v/Ac9s8KhhMMJp0Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2020 10:58:57.2086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff38a88-43dc-4b05-bf01-08d7cfe259e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0029
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
Cc: Monk Liu <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1) SRIOV guest KMD doesn't care training buffer
2) if we resered training buffer that will overlap with IP discovery
reservation because training buffer is at vram_size - 0x8000 and
IP discovery is at ()vram_size - 0x10000 => vram_size -1)

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 665db23..54cfa3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1859,9 +1859,10 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	 *The reserved vram for memory training must be pinned to the specified
 	 *place on the VRAM, so reserve it early.
 	 */
-	r = amdgpu_ttm_training_reserve_vram_init(adev);
-	if (r)
-		return r;
+	if (!amdgpu_sriov_vf(adev))
+		r = amdgpu_ttm_training_reserve_vram_init(adev);
+		if (r)
+			return r;
 
 	/* allocate memory as required for VGA
 	 * This is used for VGA emulation and pre-OS scanout buffers to
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
