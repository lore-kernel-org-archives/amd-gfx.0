Return-Path: <SRS0=lIYJ=3K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6A4C33CAA
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 16:19:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7648D24653
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 16:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FDwm2vis"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7648D24653
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C90AC6ED9F;
	Tue, 21 Jan 2020 16:19:31 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5E106ED9E
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2020 16:19:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZGZDavzepglTG8UOtFQl4TxvcV6g3Bc8Lefwl/lNlF93mjK9irjjYYRvisDCsA7Nj5KnV6KVhvQ2osA3aaENPgEkly4ZeUNEWaL7Fk89OPNLtsIGI0uKDwPSV49rFAYxhmfltBAAEMzdf/g/bAOa3vX7VBp/fq4esb1r8XGvz5qP3oddOJSvfi+dHzbWFpe86eCJhHx0kPSLBHnDj8jo11IcjYX11Xb1yi0ocYVfBz7MrSVRKKGGhbJDEyKFWtskLXtyLPG4v7fgv6OQuXxmk9tm+IKCIacyZ+NGPc35X2cn1Xy3oJm7qJJSZ1D7GdrbL6j2eB6bE3M9cCO7WIg/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlWh7kXnMiFXMM+uopy/Fd4g3M5tEzDH/cUziaAc6DU=;
 b=Siw3AsYV2fs9v4TiLVFc4BXm5NA99UMnWWltwl3BVmvPRAhTTmT852/94cR89xuY0QDgrp6fEmkh/deNGI1UO1eFuUGaR5qAOOpv8+njRE7STvpz+SjY+4YAhZj3WIbclpHjTsS9D/L1NQsLbE+TCKpUcVOPcz3bXoh5E8X5/3FWl8XbmnEUUB2Tq6ndK3p4HvcEiCWsc9ZQ51kx/3AT/KxlXYLQI06fpe3tH+Ea04aTWITa7NuoE+26tvFjfQ7H2XR9tZwr4LIwFRCXgUDfuA5uWC3Vz+qLQu7nMb6zZmIH7FUfIHgnJ7sEu2/rf6CIyCKVAXYf4GXqO1Dsq62oKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlWh7kXnMiFXMM+uopy/Fd4g3M5tEzDH/cUziaAc6DU=;
 b=FDwm2visNRmPAVJgBVMxHLvcfAt7tqwW9jzI7cCftKQq/rQESa65fy2MpOIo2c96OZtp6dYwuUgobaZ+56QnTDC1bH3frr6GeRaJpzciUUVKqkVptOgjhBQ4KdEIlkkukHnOk+mcwBgsZU2maGizCfq8Le0Z6WA+QMZ5x00XzYI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (20.179.92.142) by
 BYAPR12MB2696.namprd12.prod.outlook.com (20.177.124.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.26; Tue, 21 Jan 2020 16:19:29 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99%7]) with mapi id 15.20.2644.027; Tue, 21 Jan 2020
 16:19:29 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] drm/amdgpu/vcn2.5: fix a bug for the 2nd vcn instance
Date: Tue, 21 Jan 2020 11:19:14 -0500
Message-Id: <1579623556-30941-2-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579623556-30941-1-git-send-email-James.Zhu@amd.com>
References: <1579623556-30941-1-git-send-email-James.Zhu@amd.com>
X-ClientProxiedBy: YTXPR0101CA0062.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::39) To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
Received: from work_495456.amd.com (165.204.55.251) by
 YTXPR0101CA0062.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2644.19 via Frontend
 Transport; Tue, 21 Jan 2020 16:19:27 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fb466c99-bd9d-430d-2c33-08d79e8db023
X-MS-TrafficTypeDiagnostic: BYAPR12MB2696:|BYAPR12MB2696:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB26967429366B98F7ABDA2D11E40D0@BYAPR12MB2696.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-Forefront-PRVS: 0289B6431E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(199004)(189003)(6916009)(36756003)(86362001)(81156014)(8936002)(2906002)(81166006)(8676002)(498600001)(52116002)(6666004)(7696005)(26005)(186003)(4326008)(16526019)(66556008)(6486002)(66476007)(5660300002)(66946007)(956004)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB2696;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W6YiggQ7EL+DnahNzuQlhYc3X4AlzKqR3Q7YOgKECO+w785CR710T2sPuYlhBrzF1q4bmu0Qaws+ZgUMC6pi82d6jOBDvfRntF9xpW0zZj3FhQYXppXEsq2GFGn2FXrwT/frpHVdjqgLON+zgEnlEm3vBH79QBfeUJ4xMt2nBpaSh6PTYnpoQZPYEnzG4ac8Ir4MN4p7bD4fp1IthC3lBRBJL6GusYB7itQGrryo9xFGeZxYJCRCvsQR7ZhYKdUd/nAHSiDO30tJtTtxz/qpWX00HTyl/qLgu2FGe7gy+g+lvqgfK83wrVgC41wnSMO9D8od1W9UvpbokI60ZFfAMNSuNDK/NUEak8fSVJkMb/p3s/eeQYDeLxULsOtvJywrjDSiJoXn6xq1dXUMV9AXdmZjGLvBJLWT0jqWLsSszO+Stz1BgQukH0RKeBsB4ldt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb466c99-bd9d-430d-2c33-08d79e8db023
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2020 16:19:28.4783 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1MQyMKWZEEGMRP+xveznbZwYGmULROWFQUWzsDiY1BRe2AdhaW7QUF4DCgAjOqAC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2696
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
Cc: jamesz@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix a bug for the 2nd vcn instance at start and stop.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index c351d1a..740a291 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -891,8 +891,10 @@ static int vcn_v2_5_start(struct amdgpu_device *adev)
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
-		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
-			return vcn_v2_5_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
+		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
+			r = vcn_v2_5_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
+			continue;
+		}
 
 		/* disable register anti-hang mechanism */
 		WREG32_P(SOC15_REG_OFFSET(UVD, i, mmUVD_POWER_STATUS), 0,
@@ -903,6 +905,9 @@ static int vcn_v2_5_start(struct amdgpu_device *adev)
 		WREG32_SOC15(UVD, i, mmUVD_STATUS, tmp);
 	}
 
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
+		return 0;
+
 	/*SW clock gating */
 	vcn_v2_5_disable_clock_gating(adev);
 
@@ -1294,10 +1299,9 @@ static int vcn_v2_5_stop(struct amdgpu_device *adev)
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
-
 		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
 			r = vcn_v2_5_stop_dpg_mode(adev, i);
-			goto power_off;
+			continue;
 		}
 
 		/* wait for vcn idle */
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
