Return-Path: <SRS0=xwvD=6L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAEFC55194
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2020 01:57:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A451206A5
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2020 01:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Kr3ZdQhK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A451206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D5FB6E06D;
	Mon, 27 Apr 2020 01:57:27 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770040.outbound.protection.outlook.com [40.107.77.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 030BE6E06D
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2020 01:57:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZYhHi2YvP9wNDX8trfl5gYfJpczvgq5gonJ57VIFKmXlnD5ani/15RT5eU5+q5wEoAar88aeB9DF4iwd7Y33SQXYPHRt2GMo4Pl23y8/Fcwz6r4AkGMMqvIdE+uUR7ILzogJ5/d/DE7GjtNPvlF1iM7kXFGnrCAK+FHKbd6ME9YkDkitmPL8Thg2hXO84FhKXSx8ug4hI2dvB5U2D5x3xJUj/P1r9GL2eKdxcrkwF4fT0a9P1mJLecYC4JTbVEZ6iekl9XIMXcQhVVCwIK7QIe4VnDFiFTGaH9iAAg+oFI0p3RzGhswHPVPMr/dzGqPv7kloCcGG2aKMpRxiaQjMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tyYzsivDgKvW79Z4gdbOgnHvw479+5kVYSJWpf+5VtU=;
 b=QXK/ZrdpEawm3gOE12DM5AqEG5uN3X4EXE/YM+0gIrJ4c6sgqykKnypHFMcuGAhQehaoWYsWhiaf3FT+HiWaVC9DV2vMctbGz10mY/MndZt0lbE4Va0PFQpauSUcMU611d1hOLgb7A69KhNtm08imNwrZTUmGfZo6xCKn+JXJZVWJv7kacyHtElx5r/t383f7Vfwc3qKpuUdaevANVilsd/cg8/B2r4DFiRCAgMA2vN0Fs0ILRnc53t1LSJ7Rl4bsAZF7CkBHPlMgJxeKGlP2kknU/sD7tCOmbqJtlV7q3yE88UFcp5yMivI8OXiCt/YIFMwRSyvrMYqFiEUz/B5lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tyYzsivDgKvW79Z4gdbOgnHvw479+5kVYSJWpf+5VtU=;
 b=Kr3ZdQhKmehUfBEDDgeA9EZanztT0yLxIkWESd88+zJgL8rQwxCJotM2hCq65sgn7fspMlKT1XcnE53V1SWiSw6PftqDz57JEF7KKwH4niJkrC+KP2R+EaGJJaNRoIzcYirgrSabUUNp5XXr/me/2YSECK08QpoFH3TKxLP+g6I=
Received: from DM5PR07CA0111.namprd07.prod.outlook.com (2603:10b6:4:ae::40) by
 MN2PR12MB3583.namprd12.prod.outlook.com (2603:10b6:208:c5::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13; Mon, 27 Apr 2020 01:57:24 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::3) by DM5PR07CA0111.outlook.office365.com
 (2603:10b6:4:ae::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Mon, 27 Apr 2020 01:57:24 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2937.15 via Frontend Transport; Mon, 27 Apr 2020 01:57:23 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 26 Apr
 2020 20:57:23 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 26 Apr
 2020 20:57:22 -0500
Received: from gamma.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sun, 26 Apr 2020 20:57:21 -0500
From: Tiecheng Zhou <Tiecheng.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/powerplay: avoid using pm_en before it is
 initialized revised
Date: Mon, 27 Apr 2020 09:57:19 +0800
Message-ID: <20200427015719.12471-1-Tiecheng.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(136003)(346002)(39860400002)(428003)(46966005)(478600001)(47076004)(426003)(8936002)(4326008)(2616005)(26005)(81156014)(7696005)(8676002)(36756003)(86362001)(5660300002)(336012)(1076003)(186003)(6916009)(82310400002)(2906002)(356005)(82740400003)(70586007)(70206006)(316002)(81166007)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1062baa7-054b-41b2-e7f5-08d7ea4e5431
X-MS-TrafficTypeDiagnostic: MN2PR12MB3583:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3583ED0ECFF061E8446CF03EE4AF0@MN2PR12MB3583.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0386B406AA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mkjq0gUeIRIQKUePgv56kx2ZUqRXEOH7JYo8IHP/tyooEEfSVaZ/z1xethq15hRjXxygCkdinajl4WDteBRhWdEhUEFJrFWyyZOb9jejnQ3Pebl0OCRZUNQBO0GGu/0ISdsnWyNx5LDnGnodJ8tueuEG2fR84SFO1gDrt1al6k558i8N4FZO+oZ0+b/HDNWDo+Mwgzvp1WP9OKwg8BTYp313YtQORWQLspKujua9nNdQohderwPn1E44rcTu2CEabBAQ3B1klc7CvA1z+rysHFyuv6SFx5+PYjkI3dod3oP6xSIzNbjBsovcrsGyaqqt9gj2kqqByPgMTye0/hXarchGJM/t3yh/dtxj7i2R/J0XZ4aBmkyc5iREYUKd1+uLY2sFYzQQ5FgPyrlFZN8TW7DyvY6uAWd8AeAv2EiIYMRojueZUzGxF3SCjz6pSxPdfsmi2mLcFXAMo+1kvW9C7rlMbMoB5bSSZiXIPaSLkcaubOCh2zsVoZxWUOAe/efH3vOKCdFjoIBnmXb3ORrnQA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 01:57:23.6290 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1062baa7-054b-41b2-e7f5-08d7ea4e5431
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3583
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
Cc: Tiecheng.Zhou@amd.com, Yintian Tao <yttao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

hwmgr->pm_en is initialized at hwmgr_hw_init.
during amdgpu_device_init, there is amdgpu_asic_reset that calls to
pp_get_asic_baco_capability, while hwmgr->pm_en has not yet been initialized.

this is to avoid using pm_en in pp_get_asic_baco_capability

Signed-off-by: Tiecheng Zhou <Tiecheng.Zhou@amd.com>
Signed-off-by: Yintian Tao <yttao@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
index 71b843f542d8..fb4ca614f6e3 100644
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
@@ -1438,7 +1438,8 @@ static int pp_get_asic_baco_capability(void *handle, bool *cap)
 	if (!hwmgr)
 		return -EINVAL;
 
-	if (!hwmgr->pm_en || !hwmgr->hwmgr_func->get_asic_baco_capability)
+	if (!(hwmgr->not_vf && amdgpu_dpm) ||
+		!hwmgr->hwmgr_func->get_asic_baco_capability)
 		return 0;
 
 	mutex_lock(&hwmgr->smu_lock);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
