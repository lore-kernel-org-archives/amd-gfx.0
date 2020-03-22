Return-Path: <SRS0=k9Mm=5H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D3DC1975A
	for <amd-gfx@archiver.kernel.org>; Sun, 22 Mar 2020 21:48:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1C1F206F8
	for <amd-gfx@archiver.kernel.org>; Sun, 22 Mar 2020 21:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0Ay4B2M+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1C1F206F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 836356E104;
	Sun, 22 Mar 2020 21:48:46 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 712D46E10D
 for <amd-gfx@lists.freedesktop.org>; Sun, 22 Mar 2020 21:48:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MaJuFGXZ+i+c5XZYZZ2FKNLZaaOuAkddQnkjmDKaLOZymIrJTh5/Ny4DXhQxliiigmWltIKyk0bKFyxwAzbAS1QDwFfpTNv4SIZhRRXA/S0O7N05TL1b0PL0eiZ+Ps2s1QiY9FBrB69eZgobn/McDhHLMlMsBW1Xjig8d+3b+oeb+896QWuUVtw48SdQxWSdfG07hW/MIEtBIvx+2kY2UNOWYO4WAVUOVYDJtbM7EvjUQl5i5hr0eNYuOco80F9RzKhF+KiJ5LLi4p2mQOOc6dy8lp1lEbTCER4SKiyVwJzWA67LJHc8e9gPO0SCHjIWEkyb0j+J2NInocUJ+O0xhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lD1vtzzVer9v9CMmYVHypDX7Nk1BelZ9jTZ/asf+gE4=;
 b=S3sEyks5NfCOwDwsO0B8bdGxk3SUhxqPLufhFpQBeTzIuX1rnpxHd7HlZSUQlcrBxvv4Dlf2SBXrjT8lWVruaqZoTscd9H0twLYHdqQwfr/jai7UHsyypGk2KqhjPkt9zrVexulmhf9v88X5ygHHGaOxAqBvSS8XMsHRxs4+tV9LR+KAHkyNqNKICrLw6J0V5kvD1Pu38I8N+Wp2otE+g/TXNPUnAp2Qe2l6JOAO2us0z76OPhU1w6b3nwI1r4KVpjQa5+9Fk2d1Mvms/lRX7MP4nb5aIvMnM/YWtiLRPo3ovnsdySdHAjY6sRwoj5FARtKHeagQygHmEMDArNDG1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lD1vtzzVer9v9CMmYVHypDX7Nk1BelZ9jTZ/asf+gE4=;
 b=0Ay4B2M+ngvdrgM1HLb3BjSKXotQDcEde2jCROmz9L91vaXU9VJ3PvtGP/3xkiDMWFhGF8cs5lRJPKfuxK4/RO+tOA5zMUzgCtt2QVne63A99wnoXGuW4Amlp2MLR9hY/ABSlztaOfw0581XulLDOzk5UNdniZAx/IruBrviA+o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
Received: from SA0PR12MB4576.namprd12.prod.outlook.com (2603:10b6:806:93::13)
 by SA0PR12MB4381.namprd12.prod.outlook.com (2603:10b6:806:70::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Sun, 22 Mar
 2020 21:48:42 +0000
Received: from SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047]) by SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047%7]) with mapi id 15.20.2835.021; Sun, 22 Mar 2020
 21:48:42 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: infinite retries fix from UTLC1 RB SDMA
Date: Sun, 22 Mar 2020 16:48:15 -0500
Message-Id: <20200322214815.9771-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: DM5PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:3:23::11) To SA0PR12MB4576.namprd12.prod.outlook.com
 (2603:10b6:806:93::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 DM5PR13CA0001.namprd13.prod.outlook.com (2603:10b6:3:23::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.12 via Frontend Transport; Sun, 22 Mar 2020 21:48:42 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1c22cf8f-4f1b-4d17-5fdb-08d7ceaac9fd
X-MS-TrafficTypeDiagnostic: SA0PR12MB4381:|SA0PR12MB4381:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB43817FEC255FFE6D68CD5392FDF30@SA0PR12MB4381.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0350D7A55D
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(39850400004)(366004)(376002)(346002)(199004)(66946007)(66476007)(66556008)(4326008)(52116002)(7696005)(1076003)(316002)(478600001)(5660300002)(2906002)(6486002)(6916009)(86362001)(26005)(36756003)(81156014)(8676002)(8936002)(6666004)(16526019)(81166006)(186003)(956004)(2616005)(44832011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SA0PR12MB4381;
 H:SA0PR12MB4576.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7iXCgZy8CuRRCfpAEtOeZDaozuXk8bhypaMPcEBkTCuCaSDgY5VmQ+DXtx9dY8OdI5eozBjzYZo2BZn+OnVq1vdbwahrmYt4/xo1mAXH0FJ3IVRhVZM0iqif3dvcUD1CqqWYehI3iDTWrEWQOv7695W9IUcJvR1qRleL14jIjLKZRIWvl9zDM2GQPU1aSVvTqI9UQ8FOD5nIqbRPsRT8f2MLQziwQH2zqU2H9NALRLgl+Gjonvz2o/abBeKN8oUIWp+ORT34LONeEQOIiiLWf0YnZQWrEyYiSkbKoNC4BEScwLq6U/b+I1G5IvpPxhhBJOgWvwA5zJOMyzp3dtDInvhNG7xWq/epv89H6iTANDn7nNaVE71EqjN5q9ChYGu050L0U1Q2yCwCZfd7B0d1mJdo2X+99a2t0/R0prZa+XkVzhMr/PrLRHit8+lGT+J/
X-MS-Exchange-AntiSpam-MessageData: rPIT7BBLXdWwsToIQjRE9uaI+dIlydL2zw41RrciVjOjFNbPICQvUc8dOJlxgU2ImDnelcHhZrx/Xf/vo5++Hd2oOPClNitbORh6sumNAFU8HCcVKpv9v9UfuhZWaoMxFml++xipSmdytXZnripCUQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c22cf8f-4f1b-4d17-5fdb-08d7ceaac9fd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2020 21:48:42.6544 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cq/gFg1hcZDp1uuqVGbSfP71+AEityKwLl/0WuVLeG9U9x1pwwW9MNXF7CYvL8kQ2ZLsJ7c2Di/gOQU0LmzzbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4381
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
Cc: Alex Sierra <alex.sierra@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Previously these registers were set to 0. This was causing an
infinite retry on the UTCL1 RB, preventing higher priority RB such as paging RB.

[How]
Set to one the SDMAx_UTLC1_TIMEOUT registers for all SDMAs on Vega10, Vega12,
Vega20 and Arcturus.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index fc664ec6b5fd..a425eecc7e04 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -115,17 +115,21 @@ static const struct soc15_reg_golden golden_settings_sdma_4[] = {
 static const struct soc15_reg_golden golden_settings_sdma_vg10[] = {
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_GB_ADDR_CONFIG, 0x0018773f, 0x00104002),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_GB_ADDR_CONFIG_READ, 0x0018773f, 0x00104002),
+	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_CHICKEN_BITS, 0xfe931f07, 0x02831d07),
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_GB_ADDR_CONFIG, 0x0018773f, 0x00104002),
-	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_GB_ADDR_CONFIG_READ, 0x0018773f, 0x00104002)
+	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_GB_ADDR_CONFIG_READ, 0x0018773f, 0x00104002),
+	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
 };
 
 static const struct soc15_reg_golden golden_settings_sdma_vg12[] = {
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_GB_ADDR_CONFIG, 0x0018773f, 0x00104001),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_GB_ADDR_CONFIG_READ, 0x0018773f, 0x00104001),
+	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_CHICKEN_BITS, 0xfe931f07, 0x02831d07),
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_GB_ADDR_CONFIG, 0x0018773f, 0x00104001),
-	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_GB_ADDR_CONFIG_READ, 0x0018773f, 0x00104001)
+	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_GB_ADDR_CONFIG_READ, 0x0018773f, 0x00104001),
+	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
 };
 
 static const struct soc15_reg_golden golden_settings_sdma_4_1[] = {
@@ -174,6 +178,7 @@ static const struct soc15_reg_golden golden_settings_sdma0_4_2[] =
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_RLC7_RB_RPTR_ADDR_LO, 0xfffffffd, 0x00000001),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_RLC7_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_PAGE, 0x000003ff, 0x000003c0),
+	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
 };
 
 static const struct soc15_reg_golden golden_settings_sdma1_4_2[] = {
@@ -203,6 +208,7 @@ static const struct soc15_reg_golden golden_settings_sdma1_4_2[] = {
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_RLC7_RB_RPTR_ADDR_LO, 0xfffffffd, 0x00000001),
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_RLC7_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_UTCL1_PAGE, 0x000003ff, 0x000003c0),
+	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
 };
 
 static const struct soc15_reg_golden golden_settings_sdma_rv1[] =
@@ -222,27 +228,35 @@ static const struct soc15_reg_golden golden_settings_sdma_arct[] =
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_CHICKEN_BITS, 0xfe931f07, 0x02831f07),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_GB_ADDR_CONFIG, 0x0000773f, 0x00004002),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_GB_ADDR_CONFIG_READ, 0x0000773f, 0x00004002),
+	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_CHICKEN_BITS, 0xfe931f07, 0x02831f07),
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_GB_ADDR_CONFIG, 0x0000773f, 0x00004002),
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_GB_ADDR_CONFIG_READ, 0x0000773f, 0x00004002),
+	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
 	SOC15_REG_GOLDEN_VALUE(SDMA2, 0, mmSDMA2_CHICKEN_BITS, 0xfe931f07, 0x02831f07),
 	SOC15_REG_GOLDEN_VALUE(SDMA2, 0, mmSDMA2_GB_ADDR_CONFIG, 0x0000773f, 0x00004002),
 	SOC15_REG_GOLDEN_VALUE(SDMA2, 0, mmSDMA2_GB_ADDR_CONFIG_READ, 0x0000773f, 0x00004002),
+	SOC15_REG_GOLDEN_VALUE(SDMA2, 0, mmSDMA2_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
 	SOC15_REG_GOLDEN_VALUE(SDMA3, 0, mmSDMA3_CHICKEN_BITS, 0xfe931f07, 0x02831f07),
 	SOC15_REG_GOLDEN_VALUE(SDMA3, 0, mmSDMA3_GB_ADDR_CONFIG, 0x0000773f, 0x00004002),
 	SOC15_REG_GOLDEN_VALUE(SDMA3, 0, mmSDMA3_GB_ADDR_CONFIG_READ, 0x0000773f, 0x00004002),
+	SOC15_REG_GOLDEN_VALUE(SDMA3, 0, mmSDMA3_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
 	SOC15_REG_GOLDEN_VALUE(SDMA4, 0, mmSDMA4_CHICKEN_BITS, 0xfe931f07, 0x02831f07),
 	SOC15_REG_GOLDEN_VALUE(SDMA4, 0, mmSDMA4_GB_ADDR_CONFIG, 0x0000773f, 0x00004002),
 	SOC15_REG_GOLDEN_VALUE(SDMA4, 0, mmSDMA4_GB_ADDR_CONFIG_READ, 0x0000773f, 0x00004002),
+	SOC15_REG_GOLDEN_VALUE(SDMA4, 0, mmSDMA4_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
 	SOC15_REG_GOLDEN_VALUE(SDMA5, 0, mmSDMA5_CHICKEN_BITS, 0xfe931f07, 0x02831f07),
 	SOC15_REG_GOLDEN_VALUE(SDMA5, 0, mmSDMA5_GB_ADDR_CONFIG, 0x0000773f, 0x00004002),
 	SOC15_REG_GOLDEN_VALUE(SDMA5, 0, mmSDMA5_GB_ADDR_CONFIG_READ, 0x0000773f, 0x00004002),
+	SOC15_REG_GOLDEN_VALUE(SDMA5, 0, mmSDMA5_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
 	SOC15_REG_GOLDEN_VALUE(SDMA6, 0, mmSDMA6_CHICKEN_BITS, 0xfe931f07, 0x02831f07),
 	SOC15_REG_GOLDEN_VALUE(SDMA6, 0, mmSDMA6_GB_ADDR_CONFIG, 0x0000773f, 0x00004002),
 	SOC15_REG_GOLDEN_VALUE(SDMA6, 0, mmSDMA6_GB_ADDR_CONFIG_READ, 0x0000773f, 0x00004002),
+	SOC15_REG_GOLDEN_VALUE(SDMA6, 0, mmSDMA6_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
 	SOC15_REG_GOLDEN_VALUE(SDMA7, 0, mmSDMA7_CHICKEN_BITS, 0xfe931f07, 0x02831f07),
 	SOC15_REG_GOLDEN_VALUE(SDMA7, 0, mmSDMA7_GB_ADDR_CONFIG, 0x0000773f, 0x00004002),
-	SOC15_REG_GOLDEN_VALUE(SDMA7, 0, mmSDMA7_GB_ADDR_CONFIG_READ, 0x0000773f, 0x00004002)
+	SOC15_REG_GOLDEN_VALUE(SDMA7, 0, mmSDMA7_GB_ADDR_CONFIG_READ, 0x0000773f, 0x00004002),
+	SOC15_REG_GOLDEN_VALUE(SDMA7, 0, mmSDMA7_UTCL1_TIMEOUT, 0xffffffff, 0x00010001)
 };
 
 static const struct soc15_reg_golden golden_settings_sdma_4_3[] = {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
