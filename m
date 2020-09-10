Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20A2C07548
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4757321D81
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nTritwGl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4757321D81
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF7A26E932;
	Thu, 10 Sep 2020 13:47:28 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AE766E932
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 13:47:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JY5yZMQDNWX1dUplk4l5ZVzBTsQhz3IKgGWwhC+HPvXawAnVV1iqT5+oxYW3al133SeL23zVHUxssI2usQVerW7v4WndjQo256oErZJl26zYjj6hSg2BIS6H7C4RgO2lv2pug5Ptt/Q+JWFbieQZB+fXAVySu1VCqmnk+v6pw5ZXfOWtJvrPiDsYaWj5S3nc6v9Ba7O4HKGyFwy1EL1450aHIe0RjhLD9YARTjW/xxUfIl29gvivgKtZd4PvIayzIHxt8HmllpCbtjszAyqZIIkEgMAKIhdzNvwwZkais2lSIk7uf3zC3fDBUW9ylmR6bZR6fdK5TYOaMLgkIPm2pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okWSJlTgpH5/n7TUCfjsx894PVoUmLuMh1ECn7UcyMY=;
 b=E9hOfd9DNWFtm1T5rMJJZWaQCnPMQdmny60xTtBAd5qglGcmT5xxszh67plDEiCUA5z4MTFDH1MvRekDmfVIHDdPd7zGwmLv9n5H26dmr2nbEKNEQapm2S5qcI8F8d6I5NnEq1pUW/oiqHsurKwVuJSmHA5Ib9ao1Nfu78ASR+m8lvEh+jfwm9+l1LpUDuCaj2GFi3EmV5QEzDwfRYt10i9Bt35TBr6eW3yVte3/doeaj0X/J1yti6zt3HAaKLcsiIFXBe8jubEnMV8U8jCUaTlwWb6VIqEo2sT/5+kxmAbzmGwqEKPTtWG9ABj3vta5LdwERb8d9mE8zZuw0PtV/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okWSJlTgpH5/n7TUCfjsx894PVoUmLuMh1ECn7UcyMY=;
 b=nTritwGlZ+jG2IhCg04AnO/L9BVZFpmYhqJ2PpJNBV0uGOxzCXD0LAoCniYusqL0cBfeoP7ObpsclL3DjSSm1FrAGY3c++hh+L+J0NhkcSXvXmH1uLzc1ObN7Q5Ha9hdbSCTlSX6T7cZ0677N2a0rrdz1eUbQkcSX1ulTk1a8dk=
Received: from BN8PR16CA0018.namprd16.prod.outlook.com (2603:10b6:408:4c::31)
 by CY4PR12MB1461.namprd12.prod.outlook.com (2603:10b6:910:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 13:47:25 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::a4) by BN8PR16CA0018.outlook.office365.com
 (2603:10b6:408:4c::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Thu, 10 Sep 2020 13:47:24 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 13:47:24 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:47:24 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 10 Sep 2020 08:47:24 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/42] drm/amd/display: [FW Promotion] Release 0.0.30
Date: Thu, 10 Sep 2020 09:46:42 -0400
Message-ID: <20200910134723.27410-2-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910134723.27410-1-aurabindo.pillai@amd.com>
References: <20200910134723.27410-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5333bf7a-d0d4-42f6-c335-08d855900cb2
X-MS-TrafficTypeDiagnostic: CY4PR12MB1461:
X-Microsoft-Antispam-PRVS: <CY4PR12MB14613176A4526FCE5523A4768B270@CY4PR12MB1461.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wIqiajIsm5PE6CGPrM3vpW89HezxaR1dEsKsQPPxmL70QdfnGPdZXHI/Ramb1tbf4Nlm+9a62CdrEylRx+FJ2VY9RF2kfMxkBrKE7zGoseA8kOFMVEX6Pwkog0gxQLeZZMO6Wrf3977skCef37E10voF9Qy8kKfJkdc2zlQ4oBUao0gSDfhnUxseEqwUVaArcjp7cC1g8bqXoyXK71AcFjthMTOJTsknxsKU7SgMOSfy60+r1rqxTtmLzEEkB0PpF0CMQBsfQEoXmTldz6oNUtmeveiR1HVKJN3gWrbi45hwRoeZIlDHDO1Tcbdgu4imVn9hD9nCRjBx1Wo+UJbkWsdmv6yPDNsAzWJ/t7N8FHxdAe9q+p5nW84qehRWDS7JPvnbAFB150s1+p9i6EltVw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(376002)(346002)(46966005)(1076003)(478600001)(82310400003)(70586007)(336012)(83380400001)(70206006)(44832011)(7696005)(8676002)(6666004)(36756003)(82740400003)(316002)(2906002)(47076004)(2616005)(8936002)(356005)(6916009)(26005)(4326008)(5660300002)(426003)(81166007)(4744005)(86362001)(186003)(54906003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 13:47:24.9168 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5333bf7a-d0d4-42f6-c335-08d855900cb2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1461
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index d7e7f2eda92f..5eb642fe9315 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -36,10 +36,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x4e5b2f46f
+#define DMUB_FW_VERSION_GIT_HASH 0xb18f2464d
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 29
+#define DMUB_FW_VERSION_REVISION 30
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
