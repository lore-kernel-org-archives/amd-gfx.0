Return-Path: <SRS0=//M4=CC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFCCC433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 10:59:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2FB020738
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 10:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yAz0alz1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2FB020738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85ACC6E1F3;
	Mon, 24 Aug 2020 10:59:13 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EE0D6E1F3
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2020 10:59:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+3ddKW9C2Jwru7qOvs2cuWIAlpnNmIEqSTn9jIPTEhGVGnNrvg21dsoilvla8FxkMrEeGDmLGF9s5WDXz+yfZABT66AipL9nUYtdubNY+Y85CUtL7djrjS6YGe4NRhsfsP98EfNtOdbpqfipizTFU6Kr+lR/g+jwsby8pUXAYU+UDRgQkfwCPd04mRQLRReAUWkP6qH2wKyRB0UUxORv8lsEWymxMw18cfauI8nQ/jD4GUZWOn1PSydhBDy/xK7RLUUJWhzco0J9fDwmeeuDGQF92zI31BcJ6c2dpo8MM4mw4DVoyoO4XpG/20QA1sU2AAmOTemuZtF4LxQr6EtxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmNNigupPDhxTjwGe7JJYeBZ3qRFOOtNJKnBGvLTMCI=;
 b=CLFqBLFpnMi3V+VodLyPHRdJh6xskiLLvNPNXuv3iClC4OPchhIAusawrT8drNuYxd38//uIAcN2HotE0R4jeDnfuR/8pH+ZNCc1wXkQ0J6d2BUUMD/4YZCN0V7ngHw1hQ9NhBZC2ompQjD9ERBKRqRFOpypM8Y/vLzzBw457RnoPEgVpxSIjPspL4IQ5wgm3uinLGQdQX7Um1gO9mX9+PeexVEiap6IZp0eGEs1/jwP/1xdd5aV5dhL+RMEjVmjYmQrAAPcq/OgKTdV2rHHxDS9Lj90ZA4KNaqDLjFFMjePFiQ8MxsEGFopg979vS11YVdTc5/pvkjSl1OBEPoAgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmNNigupPDhxTjwGe7JJYeBZ3qRFOOtNJKnBGvLTMCI=;
 b=yAz0alz1UMQUSTsEN7afK6Yth59SoMScyja8/fSW0Zr9r6TLcSMwDh8xO06h5hKKXHEhUYJ1PDNf/at4Q2xNT6X2WMY6vBtC7tHOG1UfmJIsHTdAkm40bAmiGJe3pZukcBDXgMeU/SEHOKOTGeW3UwumazesclGEufe8PHM9KtA=
Received: from DM5PR15CA0068.namprd15.prod.outlook.com (2603:10b6:3:ae::30) by
 SA0PR12MB4351.namprd12.prod.outlook.com (2603:10b6:806:71::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24; Mon, 24 Aug 2020 10:59:11 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ae:cafe::37) by DM5PR15CA0068.outlook.office365.com
 (2603:10b6:3:ae::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend
 Transport; Mon, 24 Aug 2020 10:59:11 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3305.24 via Frontend Transport; Mon, 24 Aug 2020 10:59:11 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 24 Aug
 2020 05:59:10 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 24 Aug
 2020 05:59:10 -0500
Received: from navi10-sut.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Mon, 24 Aug 2020 05:59:09 -0500
From: Jiansong Chen <Jiansong.Chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/gfx10: refine mgcg setting
Date: Mon, 24 Aug 2020 18:58:59 +0800
Message-ID: <20200824105859.4217-1-Jiansong.Chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 253cbd52-0fa4-467a-eee8-08d8481cbb72
X-MS-TrafficTypeDiagnostic: SA0PR12MB4351:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4351FE6AC3A24D6F8888099DEA560@SA0PR12MB4351.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SRt2HxxwnGdDwGHDb1XXsd0zcPoP/SCEK90tVhauOyFuMMnLBnejvpzLbAARYoo/emxtCVyH4g/cFPrIAMdSfFcfmaZbWt36Uwc4jVkI8FJgoSc/7ETMqkIKdj8oDNL+wLZHg42dEJpDxA1dL1DxcaESX/LfU45/NNtjZ8P7tBKf5n7ibf7JaVk0iw9FLSBcXM8AiyMddke+Om0zUf98Vn5tskw+xjG74SapyrWuWqveTjt8PPiQDUZUm85B3pILQjduc7uXhIgU8OxhNzTgFAMoQypDBHOQV9o2HUB6OPFzRk5OX397j1opDkKTZ4TQ4vJUGHiNiWN6YNmbS2ZOgK/PPu4LZ+tLG3X0Me1bkOOb6BcIMFxkq40dt65HDErfbXpy9wqRpPaWJ4dwNpcG/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(346002)(396003)(46966005)(86362001)(1076003)(426003)(70206006)(47076004)(6666004)(5660300002)(70586007)(54906003)(83380400001)(336012)(6916009)(8936002)(36756003)(316002)(4326008)(26005)(82310400002)(81166007)(2906002)(82740400003)(356005)(478600001)(186003)(8676002)(7696005)(2616005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 10:59:11.3241 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 253cbd52-0fa4-467a-eee8-08d8481cbb72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4351
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
Cc: Jiansong Chen <Jiansong.Chen@amd.com>, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1. enable ENABLE_CGTS_LEGACY to fix specviewperf11 random hang.
2. remove obsolete RLC_CGTT_SCLK_OVERRIDE workaround.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: Id52d45ba48159c5e1c9ecf658c5b52f7fc72eb65
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index d851fe80eaf4..2db195ec8d0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7285,10 +7285,8 @@ static void gfx_v10_0_update_medium_grain_clock_gating(struct amdgpu_device *ade
 		def = data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
 		data &= ~(RLC_CGTT_MGCG_OVERRIDE__GRBM_CGTT_SCLK_OVERRIDE_MASK |
 			  RLC_CGTT_MGCG_OVERRIDE__GFXIP_MGCG_OVERRIDE_MASK |
-			  RLC_CGTT_MGCG_OVERRIDE__GFXIP_MGLS_OVERRIDE_MASK);
-
-		/* only for Vega10 & Raven1 */
-		data |= RLC_CGTT_MGCG_OVERRIDE__RLC_CGTT_SCLK_OVERRIDE_MASK;
+			  RLC_CGTT_MGCG_OVERRIDE__GFXIP_MGLS_OVERRIDE_MASK |
+			  RLC_CGTT_MGCG_OVERRIDE__ENABLE_CGTS_LEGACY_MASK);
 
 		if (def != data)
 			WREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE, data);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
