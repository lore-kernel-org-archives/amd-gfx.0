Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DECC2D0C4
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 06:09:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2898208C3
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 06:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vvc2SZZl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2898208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 736386EA48;
	Wed, 11 Dec 2019 06:09:39 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750078.outbound.protection.outlook.com [40.107.75.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E7F46EA48
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 06:09:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbSwg8P91OvN+nI9T5cQ9V1n1IRgAJWvbcULc8HsyxbUZgcWPNSx2y5FZPOEJ6zvPq5QS/R7gKdjZKIErkbpcfjcGk8Eg33yA9/gEs3g8UGPu1hG2aguK3vJayqSwx/dd4wpMmKFVVT+LJZsOuhcnl2opEquvZV/E9SebsRHvEteVHkM65uwpep5CtozcaQB62+V6vGT/E8Y17G6lW4EHr7PPmbkXJZGrYd6v34r8dR/qbeNEL60LJMZt5C5QD3SSmP736h2S7gtIv/WqnPqOj1nFjb7ThObghlJMSNIC9Qt4UcF3aM8dR2v+94XwH1mCSJrfmPye24cCeKA9kST1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcuXWBBOMzYsJjfJGvy++vilSRYDVRlmeLs/H12fzWM=;
 b=NNfJExft7Np+Fr09Z70R/1yDqv0CWkkjKp+F0y41bImfexXJ3Ba3wHKZ75FBkEovNuDGe2g394cTFr1klD98owbrvh2BIh0vm9RpfQn8Uck9y0+gO+wnrD1NomrIGMXRVOfTmpsMHYfwmQl2OumGy+lOecn1xzbJ5ksTvY8LPqkZCKJfjC1uaBALt0icZvpHoVOHAfhsaexyo/Ln7Bx4qMZZcC1rC+y8FJqXDEBnjn32JaZ/70eMdV5a6NDwfsQyI5Scw1y7JosjG28WVly7iSCexaGp/xde3CHpi1weWcPXLdLGBPXP0HxEMX70Re3hs0Ut8v/SAMPu5uDWvR6Mkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcuXWBBOMzYsJjfJGvy++vilSRYDVRlmeLs/H12fzWM=;
 b=vvc2SZZlRc33NITj5F2TKYPz5CaV1apYD+l5baZfATlgzgUheSJDcz8fQmv9uJgOCZja5ba9nTxrF6yoIti1BWaFpc7gCwG6qiWkVfG5ADzykHjUGAvGDKhAwJ+zJ7VHPfF4yLH+E8EC/c7ygIGQ/gx8CAbOd5NSlSgT94b4m0I=
Received: from MN2PR12CA0003.namprd12.prod.outlook.com (2603:10b6:208:a8::16)
 by MN2PR12MB3485.namprd12.prod.outlook.com (2603:10b6:208:c9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.15; Wed, 11 Dec
 2019 06:09:36 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::204) by MN2PR12CA0003.outlook.office365.com
 (2603:10b6:208:a8::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.14 via Frontend
 Transport; Wed, 11 Dec 2019 06:09:36 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2538.14 via Frontend Transport; Wed, 11 Dec 2019 06:09:35 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 11 Dec
 2019 00:09:34 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 11 Dec
 2019 00:09:34 -0600
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 11 Dec 2019 00:09:32 -0600
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/gfx10: update gfx golden settings for navi12
Date: Wed, 11 Dec 2019 14:09:29 +0800
Message-ID: <20191211060929.11648-1-tianci.yin@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(376002)(39860400002)(346002)(428003)(199004)(189003)(4326008)(6916009)(44832011)(81156014)(81166006)(8676002)(36756003)(2906002)(8936002)(5660300002)(1076003)(15650500001)(186003)(26005)(70206006)(70586007)(7696005)(316002)(86362001)(54906003)(336012)(426003)(356004)(2616005)(478600001)(6666004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3485; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d53f0270-870e-4850-dcdc-08d77e00b294
X-MS-TrafficTypeDiagnostic: MN2PR12MB3485:
X-Microsoft-Antispam-PRVS: <MN2PR12MB348504F7602B8D7C45EF4B11955A0@MN2PR12MB3485.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:168;
X-Forefront-PRVS: 024847EE92
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jSIAZy9dlVXfU2RAGniamvgTvlWVTtx6ydoEGC5nzZ9q13arm+oxNQH49Vgm3x5lWRUSS6yhF1fuE/+7f/UqFjm6oufMLos7ADrHVZTiIgbwgpdPEPqDCVYRonyQnMT3s6F2sycT+NCA5pNlWX9JXSV8Z67Ceg0jufwfzrrB9wOqT2t4ESL35IcElnVgzt5JFhwbtwqNPsjGJOweFeDLef6G4Lgjpb1W5fiparwUFIirVeXVaiI+BdjPxmQ6DVP0NgbsO2rse6fYiC51TnXFT+lG9KYGwjP2XQvvu2hga3Y8aUVLjw7U3IU2F50UPZ2weagydsAnu7ysJQLIKIUrJjdLryN9nEWSnstXGSpL6ss/2LH8AFZqZFc1AhM3ZRul7Hy15lQc4pi1ZXRJ9rJdhzuVuMHHFyplxTpSFWU+br4Z4iQE8JLVTPxmySpvMEYw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 06:09:35.5803 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d53f0270-870e-4850-dcdc-08d77e00b294
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3485
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
Cc: Long Gang <Gang.Long@amd.com>, Pauline
 Li <pauline.li@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Tianci Yin <tianci.yin@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Tianci.Yin" <tianci.yin@amd.com>

add registers: mmSPI_CONFIG_CNTL
update registers: mmDB_DEBUG4 and mmUTCL1_CTRL

Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index db9b8bfb1c3c..557ebf317b5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -185,7 +185,7 @@ static const struct soc15_reg_golden golden_settings_gc_10_1_2[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG, 0xffffffff, 0x20000000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG2, 0xffffffff, 0x00000420),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG3, 0xffffffff, 0x00000200),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG4, 0xffffffff, 0x04800000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG4, 0xffffffff, 0x04900000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DFSM_TILES_IN_FLIGHT, 0x0000ffff, 0x0000003f),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_LAST_OF_BURST_CONFIG, 0xffffffff, 0x03860204),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL, 0x1ff0ffff, 0x00000500),
@@ -205,12 +205,13 @@ static const struct soc15_reg_golden golden_settings_gc_10_1_2[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_ENHANCE_2, 0x00000820, 0x00000820),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_LINE_STIPPLE_STATE, 0x0000ff0f, 0x00000000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmRMI_SPARE, 0xffffffff, 0xffff3101),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSPI_CONFIG_CNTL, 0x001f0000, 0x00070104),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_ALU_CLK_CTRL, 0xffffffff, 0xffffffff),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_ARB_CONFIG, 0x00000133, 0x00000130),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_LDS_CLK_CTRL, 0xffffffff, 0xffffffff),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTA_CNTL_AUX, 0xfff7ffff, 0x01030000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTCP_CNTL, 0xffdf80ff, 0x479c0010),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffffffff, 0x00800000)
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffffffff, 0x00c00000)
 };
 
 static const struct soc15_reg_golden golden_settings_gc_10_1_nv14[] =
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
