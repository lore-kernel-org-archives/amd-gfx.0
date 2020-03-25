Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B11C18E5B
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 08:24:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3687520663
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 08:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hWE3a0g0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3687520663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E26886E5A4;
	Wed, 25 Mar 2020 08:24:55 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1ED66E5A4
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 08:24:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dsGNS82VQbq6fbtihug/t5QpoB7Eidg8Avp9+KbfMJZP5f0IO8GwhmWxNPTVVl4SKOlh0leBS0BaAbw98PxbhFdZ5LrpmslBThgjzChIvLgq1izupwfXSNVyXiR3Psb1RExpwe9OYiYzhtC9+A6PsRXEnnje2m2tcq5yis652BMIb6r2T7kmtrnFQk1kzO9j/eNXPudqiRYhmRG1h9CWWPtgDJ/0/MGRJWf3o7+h1d5fI72O7hFgKdLWFmyZtKpiam3fDqp9Gg8+MjdZzHVxUnCqrh44jw0EluELoZL1rUbgucq2CXZgBBU/ufdNsZ0Cplu2cl1TsjUf5/tbO4xyZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vy0kKJ+IB86bv6wjAaizkHZB2iAZ9gmmxd6lgqoMaVU=;
 b=KuX88nmvinPXRtw7mEtk2SJd5hGR+bMjRyKJZiu+f61SqAuZXQismYFF91NpH9cic+5a/BKL97pwiiD2+GFxsOAaYwu/N0Flxcudc+c0IVI5aKfhjPikxeoKfFyYQM24T5ka0RJqaRpAdlSQgulKBEJiu0ImgkpDkC2o3Y/QEJG/ebbxV8JqoYRdy6Vx7/lBPNpnDP4GWcQP9/3If+4n4t9P2WUxYK7bwAyGeSJDrjLdn/84gAKOajScPr1F61l2Q3AQSxQDxNyKb9yef85xqh72AHx5KgYuBPbz4+WcSF7S9ODpOEm+urhBrjWGB4629CtGwEuBer3lG6ydXdhoWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vy0kKJ+IB86bv6wjAaizkHZB2iAZ9gmmxd6lgqoMaVU=;
 b=hWE3a0g0rmXPQhhZjcEvz34DuhbtsVnRhcXwtuHRM8JrtPDZL+DZrlO8BbwlOWRUq247/7QYvqEF1+7LOxPLQtGVXMH9rIjgxhkNJdk2+iQXzH73tlok60GozMu2pjMek+GmgSIQhes4GISI8ditphQMTPJD3lxBQ+uG5FkgoIo=
Received: from MN2PR16CA0013.namprd16.prod.outlook.com (2603:10b6:208:134::26)
 by MN2PR12MB3950.namprd12.prod.outlook.com (2603:10b6:208:16d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Wed, 25 Mar
 2020 08:24:53 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:208:134:cafe::f7) by MN2PR16CA0013.outlook.office365.com
 (2603:10b6:208:134::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20 via Frontend
 Transport; Wed, 25 Mar 2020 08:24:53 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2814.13 via Frontend Transport; Wed, 25 Mar 2020 08:24:53 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 25 Mar
 2020 03:24:52 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 25 Mar
 2020 03:24:52 -0500
Received: from emily-build-machine.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 25 Mar 2020 03:24:51 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] SWDEV-227605 - Virtual display need to support multiple
 ctrcs
Date: Wed, 25 Mar 2020 16:24:33 +0800
Message-ID: <1585124676-14143-1-git-send-email-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(136003)(376002)(396003)(428003)(46966005)(6916009)(81166006)(8676002)(186003)(4326008)(36756003)(2616005)(478600001)(81156014)(8936002)(316002)(4744005)(426003)(26005)(7696005)(86362001)(336012)(82740400003)(5660300002)(2906002)(70586007)(47076004)(6666004)(356004)(70206006)(17423001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3950; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ff90427-9866-4ea5-4c46-08d7d095fe6e
X-MS-TrafficTypeDiagnostic: MN2PR12MB3950:
X-Microsoft-Antispam-PRVS: <MN2PR12MB39509B29A8EF509AF266D1CB8FCE0@MN2PR12MB3950.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-Forefront-PRVS: 0353563E2B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bNx+qRXfEtaHzSSI3K7cxWrezjSztr0Vw2DCe82HcbEXnh6jKoWn2/NCMYGaAQArVGpCCi/aeiuqoOh0CNDB8ggzmqM2R6PP4pdZ33R6LYe3WKLNzfY6pUdlUHt9q6iNg06jedmDGtBzyKL5o1Ij5YFNLFFVpNNaw2r7GjlGzjSXmWpLHMr/9sszLOqI/wDT6Z5czcdl7KbdbYMLtScEyMKEF+1tlyi6V/jQR7Cp5sbC+XUSBGnNfdUS03ISKjbSYfgVjnOm5Jsqy6YN1C6Iv6Pd6zN5dAfaCWsGn4yqzC9kwBy88cIZparCmsthBYm4aO4+Kfp7XC0i1AkGOdA1OOHVojhlNaONm287vjorhLlvNdi0oyHim4VFuiIIFpRkbIzCnSjXOZSmDDVjTeuSaFh3tEbYqv3hTBF8fCnvOGjF2bfvcfuxjSkUWRs+a20tmU2qnrrYoQAmgwTBlw9va66TveA8cTn4iXBrbF+H2HbuIhJh55U32SdchDjs0OB01hdEO/r9MTDZJoje4qMlbCC3BfVf7EtOshiEAWj13AQ=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 08:24:53.3120 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff90427-9866-4ea5-4c46-08d7d095fe6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3950
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

The crtc num is determined by virtual_display parameter.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 43a1ee3..d791bfe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -38,7 +38,8 @@ bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev)
 void amdgpu_virt_init_setting(struct amdgpu_device *adev)
 {
 	/* enable virtual display */
-	adev->mode_info.num_crtc = 1;
+	if (adev->mode_info.num_crtc == 0)
+		adev->mode_info.num_crtc = 1;
 	adev->enable_virtual_display = true;
 	adev->ddev->driver->driver_features &= ~DRIVER_ATOMIC;
 	adev->cg_flags = 0;
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
