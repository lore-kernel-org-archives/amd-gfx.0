Return-Path: <SRS0=93xL=DJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7B6C46466
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2020 23:56:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5328220796
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2020 23:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KtTi7jKa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5328220796
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC20E6E9F6;
	Fri,  2 Oct 2020 23:56:13 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBCEE6E9F6
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2020 23:56:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKT1dwbRkYuyKf5MuR7wz+mTT3n/SLjOwB6pNkGg0O9vAmKpl7pYD3QVMtoSvYEm2jbBvRochJHDv9n0LMt2y9JE6hqXAXXZAsiFDzh0gDigwKrGuHsiUu46W86YP/IJ48iu3pfFTR+v5O7xN5dE9SHUk2ck/FqhbFx06MepISiv/ez4kKoe/qk7oDQhuLMBx75ovUWOz8qOoEe0eMU0I4MxMrVb56JgdAMLwvAWf8BPqEoXTYj0sWZzLnoPW86tZSBgF2sOYnfrgwzp7FMElb0/jQjrhZmvauRw/q2xyBoTD0Csb+2XhgUPnKSVj/sIyx5QDCrGm8bPqIGAWX7U2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bo0h9VhkUNV2xiUlLZCtnrfMUu2tzOIHbozYXErwICo=;
 b=BOdiHm9joWGUraVBnGku/OfRqAdbHVTBa0WprMjhBvjX6VRYD7Yc9uP3TzHM7P8kaxFVlTCgbIZPBl673EEJxaObU0hh+mIkiySLI89dTWMiVdkVJWlClP6zIGdtV4aVKehSsKZiJ50zNPF1Um+Je21G4Q6pbXYkXzg7v1qgRTmdV7pdgbUFFX2NIEug+0BiOYXtuVi+Vp2He4rt7RBXmFQx0P9Wrw0Rnfyh9ZcKN9lebedKnzsxd6/CEuIsDy4Nwx4egQB69prMk/I/G+oKsXWK8/eRfXPtbv7TSUHoQth1XO34ufSOGTmR1hNnkRHiMKR9j+4oiTmd1tYakjM7rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bo0h9VhkUNV2xiUlLZCtnrfMUu2tzOIHbozYXErwICo=;
 b=KtTi7jKa9RM/3fZioR8m8DKwaU97QlH8y7U/M9zNzjZlOqeGxFXxf9MebfXQlJy/pus7C9I9Le94K9RjCMmhtCdi93M32jLE4cNw5o5+x+RBdioRmFwXsQ6D51ibO9O5TjO6gC2vUQRF7pQ1sbN96jIyNh3UFAT7+76WIphH0es=
Received: from BN8PR07CA0019.namprd07.prod.outlook.com (2603:10b6:408:ac::32)
 by DM5PR12MB1578.namprd12.prod.outlook.com (2603:10b6:4:e::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.36; Fri, 2 Oct 2020 23:56:11 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::ef) by BN8PR07CA0019.outlook.office365.com
 (2603:10b6:408:ac::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.36 via Frontend
 Transport; Fri, 2 Oct 2020 23:56:10 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3433.35 via Frontend Transport; Fri, 2 Oct 2020 23:56:10 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 2 Oct 2020
 18:56:10 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 2 Oct 2020
 18:56:09 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 2 Oct 2020 18:56:09 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: [FIX] Compilation error
Date: Fri, 2 Oct 2020 19:56:08 -0400
Message-ID: <20201002235608.10953-1-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afa2b2ef-1a88-4da1-620a-08d8672ebcb1
X-MS-TrafficTypeDiagnostic: DM5PR12MB1578:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1578B80A72B1586C8FAEAEEAFB310@DM5PR12MB1578.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J1Nuj4xLFQb/3vSXDRy/G/C5KD2XzMe+dM51z+JGt047HT5DDaYGgK5dO32AaWUUaSvCoxJUoeyZSOpDVhzMIfs02MpixmCG8LORrWOiANIJQa1ylAxpUhn3zjqjNhQ7cTAYLL8XvXPFKoYNrM8I4AMCx/KplrV4CPfx0G8gOfVtgvrq8dGcZVv6n72lGFfLRit4W4FJQBKc/3w2hQsHksMNyxJdqpcKuGfBGs0DLJT7o2+nvUZozkMuGjbMNMuCb+7G71DaPp1DbyTssbD9zxtxYhEjaTsWSBCkNCZD2XA2ALMmfQ+gKGvm9BvCLjbqoVOzsRlyGjLJ1l+Og8kcWM/bihEJgabH79t2/KtLyrSyEBTtlWN4U4eoOBP11C1WCMi/UW91TjRSVCZ+vG2bsg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(39860400002)(396003)(46966005)(26005)(82740400003)(8676002)(316002)(47076004)(2616005)(4744005)(186003)(70586007)(70206006)(82310400003)(36756003)(356005)(86362001)(4326008)(426003)(44832011)(478600001)(81166007)(1076003)(6916009)(8936002)(336012)(2906002)(5660300002)(83380400001)(54906003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2020 23:56:10.4393 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afa2b2ef-1a88-4da1-620a-08d8672ebcb1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1578
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
Cc: Lewis.Huang@amd.com, Aric.Cyr@amd.com, sfr@canb.auug.org.au,
 Harry.Wentland@amd.com, stable@vger.kernel.org, Alexander.Deucher@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas.Kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
ifdef mismatch.

[How]
Update to the correct flag.

Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Cc: <stable@vger.kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.h b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.h
index 389ca0d54d1b..24f7fe374e13 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.h
@@ -189,7 +189,7 @@
 
 #define ABM_MASK_SH_LIST_DCN20(mask_sh) ABM_MASK_SH_LIST_DCE110(mask_sh)
 
-#if defined(CONFIG_DRM_AMD_DC_DCN3_01)
+#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
 #define ABM_MASK_SH_LIST_DCN301(mask_sh) ABM_MASK_SH_LIST_DCN10(mask_sh)
 #endif
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
