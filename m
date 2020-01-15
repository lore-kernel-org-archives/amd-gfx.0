Return-Path: <SRS0=p2a1=3E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1EFC33CB1
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 09:41:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C01CD24671
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 09:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="F/dIKOrh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C01CD24671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CDA86E1F8;
	Wed, 15 Jan 2020 09:41:37 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 768EF6E1F8
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 09:41:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRJXTfUU798u8GWsH+uldtQ6d6c4irZHoJzsCC0mOsCiacwNLg6+WhIz1xiwnOF3LJ9pOLXqLIlz6OrxZdTAtgcBZody+tKa42XKfN01ceTyVBoKruk26Toz32c0jjOWqMdWnAbkADhPRdMu8vPJCwj+ziqE+PwTaK2tf8LwgAbKb1lt1gLbiYPP+Ayigem61aVTjryIOjs2IplMV1Lq0yMKoEst39VATl9ZCqXe9BYfjzBGcYjqYsiHKuKFbpGp8U8zMuU47HvFB2wuRUgqbB65DfzYqIa4Aku6twfXmcUcfL18Kf16R/cciS0h7Lvuabft2KYaom5csRs9DV7Y4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PT+d1vZ/9ovo+Kqnt8y4NCoEVfsiDraxi47C12Epygc=;
 b=WTpBGOPTtdxWPYIaiCqoVeMMEpDqaIZCbCExTHticIZIqKVoonurCOJ7g6owDvKZ2YogCsIhTAIytaGX1FDrQUI+bYgf0E4YWBdMmX3lLdW3h+90Y2pCuGSRb8zZ7hsp//oC8AiqUpVIGLn3cniRHu4e/Pes1jZ1wYf77HiyB678T9vgZQdnIfxECeGvUr7o/88ezg/Er1e10U52fMMcflmfGl/b17fBjO+pDVWSyJpkZxJ/ISFBlFCgFeEoA3UZhKdBpDGFf/JZWvW+XeKG9cjos+syT8mXVN5diAsDA12rL7y/yeswyr3cmfILfI1mkJ+yEs4YLhKKssKIaJ/48A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PT+d1vZ/9ovo+Kqnt8y4NCoEVfsiDraxi47C12Epygc=;
 b=F/dIKOrhS8NnHD7WVYn1QnBYYNOUff9hloJCmT2spthPcHapJFqY7qs+HxbLDJbT2jTVk5PPcsTRnq3MctOxxmc6SHBkKwXghit+jg+CmJb96IX5JQtvtex2hZWfWPNStMn9d/oVSbi71KzCr+01V/KBzjaoFIolUGLfv5Mhxnk=
Received: from BN8PR12CA0004.namprd12.prod.outlook.com (2603:10b6:408:60::17)
 by MN2PR12MB3695.namprd12.prod.outlook.com (2603:10b6:208:15a::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9; Wed, 15 Jan
 2020 09:41:34 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::209) by BN8PR12CA0004.outlook.office365.com
 (2603:10b6:408:60::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend
 Transport; Wed, 15 Jan 2020 09:41:34 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Wed, 15 Jan 2020 09:41:34 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 15 Jan
 2020 03:41:34 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 15 Jan
 2020 03:41:33 -0600
Received: from gc-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 15 Jan 2020 03:41:32 -0600
From: chen gong <curry.gong@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: read gfx register using RREG32_KIQ macro
Date: Wed, 15 Jan 2020 17:41:22 +0800
Message-ID: <1579081282-659-3-git-send-email-curry.gong@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579081282-659-1-git-send-email-curry.gong@amd.com>
References: <1579081282-659-1-git-send-email-curry.gong@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(376002)(136003)(39860400002)(428003)(199004)(189003)(81156014)(6666004)(356004)(5660300002)(6916009)(8676002)(8936002)(86362001)(426003)(2616005)(336012)(316002)(186003)(26005)(7696005)(2906002)(36756003)(478600001)(4326008)(70586007)(70206006)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3695; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93961471-a4fd-42f7-3a9d-08d7999f1c14
X-MS-TrafficTypeDiagnostic: MN2PR12MB3695:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3695DB0EAFED06177BE941C89D370@MN2PR12MB3695.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-Forefront-PRVS: 02830F0362
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +APMar8BEJTK3J9bGYufugX5KG9DTUk72aUjcl48vq97bopWg1i9Qe6cCeJOUIYMt8PJxBivd+OL7XTgZZSWFGWttu3+28Ac98hNiA4UPjovlp532A/oIvFvPCVppXporlyVfi7ExpxTFoeU83b4sB7zKRHRxyInPzaVV8XXHh/5gNC9No+dbrQdHGXKr0NmX6Dakk3WUBK969E6CZKp2JJHmUlmn8P2g86bLgBXr7dE6pYIEJHHQ7xI9oysOajYePtre/CtHuttYSt/gp/QstKjxu4fGwvIFVG+0rmeN2uQtMjwOaJXWtwk0deITXLtv2GUbfaMnazXzkdGXzZI0GIdgdRoqDaGqrVIaCNd3+f4AXFIWQ5woq4sGKLS4oL+YgXe7DcfAGNE8xUcwsgG83xl8TtojmK9tobhlg7Vhyv9hHESIjnIYFvdyl4sLy+5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2020 09:41:34.5721 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93961471-a4fd-42f7-3a9d-08d7999f1c14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3695
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
Cc: chen gong <curry.gong@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reading CP_MEM_SLP_CNTL register with RREG32_SOC15 macro will lead to
hang when GPU is in "gfxoff" state.
I do a uniform substitution here.

Signed-off-by: chen gong <curry.gong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 425762a..cdafacc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4714,12 +4714,12 @@ static void gfx_v9_0_get_clockgating_state(void *handle, u32 *flags)
 		*flags = 0;
 
 	/* AMD_CG_SUPPORT_GFX_MGCG */
-	data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
+	data = RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE));
 	if (!(data & RLC_CGTT_MGCG_OVERRIDE__GFXIP_MGCG_OVERRIDE_MASK))
 		*flags |= AMD_CG_SUPPORT_GFX_MGCG;
 
 	/* AMD_CG_SUPPORT_GFX_CGCG */
-	data = RREG32_SOC15(GC, 0, mmRLC_CGCG_CGLS_CTRL);
+	data = RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, mmRLC_CGCG_CGLS_CTRL));
 	if (data & RLC_CGCG_CGLS_CTRL__CGCG_EN_MASK)
 		*flags |= AMD_CG_SUPPORT_GFX_CGCG;
 
@@ -4728,18 +4728,18 @@ static void gfx_v9_0_get_clockgating_state(void *handle, u32 *flags)
 		*flags |= AMD_CG_SUPPORT_GFX_CGLS;
 
 	/* AMD_CG_SUPPORT_GFX_RLC_LS */
-	data = RREG32_SOC15(GC, 0, mmRLC_MEM_SLP_CNTL);
+	data = RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, mmRLC_MEM_SLP_CNTL));
 	if (data & RLC_MEM_SLP_CNTL__RLC_MEM_LS_EN_MASK)
 		*flags |= AMD_CG_SUPPORT_GFX_RLC_LS | AMD_CG_SUPPORT_GFX_MGLS;
 
 	/* AMD_CG_SUPPORT_GFX_CP_LS */
-	data = RREG32_SOC15(GC, 0, mmCP_MEM_SLP_CNTL);
+	data = RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, mmCP_MEM_SLP_CNTL));
 	if (data & CP_MEM_SLP_CNTL__CP_MEM_LS_EN_MASK)
 		*flags |= AMD_CG_SUPPORT_GFX_CP_LS | AMD_CG_SUPPORT_GFX_MGLS;
 
 	if (adev->asic_type != CHIP_ARCTURUS) {
 		/* AMD_CG_SUPPORT_GFX_3D_CGCG */
-		data = RREG32_SOC15(GC, 0, mmRLC_CGCG_CGLS_CTRL_3D);
+		data = RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, mmRLC_CGCG_CGLS_CTRL_3D));
 		if (data & RLC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK)
 			*flags |= AMD_CG_SUPPORT_GFX_3D_CGCG;
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
