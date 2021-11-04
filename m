Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8D0C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 02:55:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81498611C7
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 02:55:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 81498611C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 304D47B3F8;
	Thu,  4 Nov 2021 02:55:39 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A99F7B3FD
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 02:55:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTmalodyLDBreQI9jJ/g7GbWgu0mbhFwPHeY+psKhiKZRIQ1+bFW6qDWTj/DoJB2bdI7TY1NCS3ZH88D1SA4WqkXAdfS7ACseApps5tu8gj+ReSR+PkfFUIZj+H4BUIQuz7+YxH3TBFvOdvuAKQ2bmDsCdeqimVzm3HKQ7tTttHGnjOtgdUxdnf+b/+3paR0LtGaROXSM33cIESIeaYdlZHO0s69oRIgtKFk1Scz+sFank0dj1oP8J9qj/KLD1CH/q5P7xBQyomaeFB5aZHEtYTfMAlrK6Nij08WhcmbXEt7N0rAHW2r2cwQUvg1CM5r9g0jtGRm63+BCcQoWu5hIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfYP/oweakt04W8InIzJxw6B+MbnqJqPSE9htlGDuz0=;
 b=cq0c6cjSi1wOnc59CYNmnoAxjB3wZJ9q9KH+Cx507l5PefHvoUkQTyWbSJZZTYTgSFk6miR0RJOgKS0oxPet7klpNWDvHbQZyS8moUyXR9aqhqvUJx0jCy8kTK0TrKsZtKa7zuI2IbvHV/zxJ/u7pScgeJPKemkwcdo3eSdYVlyZSFLXPcDr2ZrFm8g64fkzlLHyF/AJISyYm2+9nuVMmXt9qtebY5/wtfwAULXKHF1aHzQcPPGGb1rS5UvxjMF2ibo4S8juL2FfVzUA2fU8agPMlhbHqlMYScUQQ3cdCVtWKbcLPPCQrLWNjxQsFGoPE/VGiNkZuWlBn27TPsztFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfYP/oweakt04W8InIzJxw6B+MbnqJqPSE9htlGDuz0=;
 b=PEOxuEQxsM7eXFVtukHJ3KeeWgVwqp9F02kOraEDKT+ZJsXezPGOQLJE9Dcj0wFQki2cNpKmN0Z2Dp3GpNT9PjQivnSVUsrpVBi63X8p+JEUyYJoNuIG7fLwd/NAA3q041fTCA9DAx8uKaf3luwVdtevPpUjQbOqqWRI41in6eE=
Received: from BN9PR03CA0535.namprd03.prod.outlook.com (2603:10b6:408:131::30)
 by PH0PR12MB5465.namprd12.prod.outlook.com (2603:10b6:510:ec::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.17; Thu, 4 Nov
 2021 02:55:34 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::2e) by BN9PR03CA0535.outlook.office365.com
 (2603:10b6:408:131::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend
 Transport; Thu, 4 Nov 2021 02:55:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 02:55:33 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Wed, 3 Nov
 2021 21:55:28 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Wed, 3 Nov
 2021 19:55:27 -0700
Received: from yubiwang-dev-linux.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15
 via Frontend Transport; Wed, 3 Nov 2021 21:55:24 -0500
From: YuBiao Wang <YuBiao.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: Avoid writing GMC registers under sriov in
 gmc9
Date: Thu, 4 Nov 2021 10:55:06 +0800
Message-ID: <20211104025506.533625-1-YuBiao.Wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 120f371a-0153-4013-f546-08d99f3e9229
X-MS-TrafficTypeDiagnostic: PH0PR12MB5465:
X-Microsoft-Antispam-PRVS: <PH0PR12MB5465A81CB78773700E8E1D94E58D9@PH0PR12MB5465.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:469;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dhe8LYcJ+8Q/WG4zkLwGmHLFIAcoEvs4wD+4U/ZB2FQET4kJzuHvTPW4Sj3427cvvxPD0EifcioOS94i47fKoKsvYvwPaRO91FdqBMhpigH6fPQn3GaEHsM66hRTvp9EwDLxidz9X0phVQIeR7kXpYn/noAZgURBVs3/YJ55vuEmma1jpK7PIy/hJuIjKo2N5HN8kTGf66hHbW3/T4fujDHEQb2/hWLyiKX2oZt+67DEsigJgBsGKhBTMijukTJBkpffj+rES+uvyIhP1hHN76he9KcVKC89M2B56K5UNaY2wIclvNDMTFz7zQwACTyCGXuu5QHNscN5gD5UfI2lA5es5SdjMaRliPW2ARUZhGU9SpPv/7qoGu4SR1lHv5q6wkGAeCEVdmCCJtMoZNlhy31rdyMfw1ySMoqbHh3CdO1NEbtS8fWAYW68NZFoXXrz0l8x2N86x6csq6X/rFfhaV/UNYWzUxdyaRmanE1Loh26fsK9BRKDrtLSjcmoWLe25NSE0NOZZBaS4M6H8qGqNdBD2RGd2WDYV0UWzsS5tbl3hhKwFWLXCzUM3A6ys9lms9fVJnVSLDxGyaehAfrWSWFfaYNm1Khe+9gHKqM4g8++ggUhwULSb78tJAvgqfS827GSdKUS2/F6HqtNl4MvKQd8GexERbhVt6kiK9yCbe9+5gAoS1r8C2Zru97s3LK3attqhPgwBHxg8LELsEx23KbPa19ebNPUyRmWqgWRIKs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(426003)(82310400003)(83380400001)(186003)(81166007)(26005)(1076003)(47076005)(36860700001)(86362001)(4326008)(8676002)(70206006)(316002)(356005)(508600001)(5660300002)(2616005)(6666004)(36756003)(8936002)(7696005)(336012)(70586007)(2906002)(54906003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 02:55:33.8208 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 120f371a-0153-4013-f546-08d99f3e9229
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5465
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
Cc: YuBiao Wang <YuBiao.Wang@amd.com>,
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 Feifei Xu <Feifei.Xu@amd.com>, horace.chen@amd.com,
 Kevin Wang <Kevin1.Wang@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 Jingwen Chen <Jingwen.Chen2@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Monk
 Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
For Vega10, disabling gart of gfxhub and mmhub could mess up KIQ and PSP
under sriov mode, and lead to DMAR on host side.

[How]
Skip writing GMC registers under sriov.

Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c | 26 +++++++++++++-----------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index bda1542ef1dd..f9a7349eb601 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -348,18 +348,20 @@ static void gfxhub_v1_0_gart_disable(struct amdgpu_device *adev)
 		WREG32_SOC15_OFFSET(GC, 0, mmVM_CONTEXT0_CNTL,
 				    i * hub->ctx_distance, 0);
 
-	/* Setup TLB control */
-	tmp = RREG32_SOC15(GC, 0, mmMC_VM_MX_L1_TLB_CNTL);
-	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ENABLE_L1_TLB, 0);
-	tmp = REG_SET_FIELD(tmp,
-				MC_VM_MX_L1_TLB_CNTL,
-				ENABLE_ADVANCED_DRIVER_MODEL,
-				0);
-	WREG32_SOC15_RLC(GC, 0, mmMC_VM_MX_L1_TLB_CNTL, tmp);
-
-	/* Setup L2 cache */
-	WREG32_FIELD15(GC, 0, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
-	WREG32_SOC15(GC, 0, mmVM_L2_CNTL3, 0);
+	if (!amdgpu_sriov_vf(adev)) {
+		/* Setup TLB control */
+		tmp = RREG32_SOC15(GC, 0, mmMC_VM_MX_L1_TLB_CNTL);
+		tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ENABLE_L1_TLB, 0);
+		tmp = REG_SET_FIELD(tmp,
+					MC_VM_MX_L1_TLB_CNTL,
+					ENABLE_ADVANCED_DRIVER_MODEL,
+					0);
+		WREG32_SOC15_RLC(GC, 0, mmMC_VM_MX_L1_TLB_CNTL, tmp);
+
+		/* Setup L2 cache */
+		WREG32_FIELD15(GC, 0, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
+		WREG32_SOC15(GC, 0, mmVM_L2_CNTL3, 0);
+	}
 }
 
 /**
-- 
2.25.1

