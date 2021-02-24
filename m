Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D401C433E6
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5365964ED6
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5365964ED6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0301F6EB54;
	Wed, 24 Feb 2021 22:21:06 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6889A6EB54
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AKJafLGJ/qLUvxf/gc3nJP2hjztvJZyHAmJIcJOaEhd8uEvj6W7y6r91MEIbc2+2HRBJYPenIyQAU/cd07O/6BnT7IDeyoVGC9qoJb5ODvgnk89n3iuh62iJZnBf3ED6GTRdA0B53kugNQ5cxxXbzr21cUjURTWHrm42PUYC+I4AKHbWiuSwFYLYdGHO7MT7UHqRLhstXOpsf/REI0F1i1iMT/sMFs+hrVZdpMk3bGj3REDuu7KL5kqw4Y5wiS6130mIymnIf1GGOMmVWogR/fseMQcXdLyqBIUO2Rzq8gHft7IgUWblaXw8Bd3dmplyVZKSNECwKZyKJ+HVIDapIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMEsnAqvDHzbx/93gS9qPltI1HuCEk0oRExe6o6uGds=;
 b=KPxicuMfthD2UC6coXRmM/2TxHjsMw/Pt94Mux2tNhoQmdryZ9Kjv5RdxyLu+2lst7t81QmtJ8zcwb3FKSSHreAW2zELdIVPqEzmdqDgz/io7HkO+HJwIODR5Z1j4pe2Xecq7UaL9YSgQHbLhYGrgG/UvVqV1B1reWFagD5N39f35e32itbbBU+WeEQUld05LDkAXUEJmB8xhy4axe7YQPetfdxQ55G3wqkRtEu3OX5KdsBq0Cau+7/Ng04CNk9FSs2dBR7TeL/2wmF/EAEwc1NV9dgMFCGtFstQ8b5T/idwyJjZGF9djl/x3zDrdSIFDOyxBHUaFZYs73qVa9RvTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMEsnAqvDHzbx/93gS9qPltI1HuCEk0oRExe6o6uGds=;
 b=UNd7VKYUwo2TpfxCnbgYyvM4d1iOPNcMUzCeoiu4CctDr2MzwaZGRhdto+j4WXBDEjVvMFNvhtIsHVV/ic265bYc1SicYY5InV0CQNvl/XHcUN7gKIPJx0LsyS4UOl4YxQEYKzQzNrhTFb58C4fo9nXPJFVp/8O9s6sLz6D6ReA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2497.namprd12.prod.outlook.com (2603:10b6:207:4c::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:21:04 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:04 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 075/159] drm/amdgpu: apply sdma golden settings for aldebaran
Date: Wed, 24 Feb 2021 17:17:35 -0500
Message-Id: <20210224221859.3068810-68-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:20:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 08f01ad2-04b7-4f18-32f2-08d8d91259ec
X-MS-TrafficTypeDiagnostic: BL0PR12MB2497:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2497DE1058794B2DE4200319F79F9@BL0PR12MB2497.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i/1Z1IXBhWzfViJOc9wxJ1zrnWUv5CYoXBDZw29Wve2oiawHsX1J3JVYD8iE2EmwW0OtrpL0Mg1Feg66m6rR30KAf6jxUkzQcS3z0Q5C5aAkPfO2eGstGdd67VDAqT6OWxih4Isx5l6DRaT8kMaf+46BaR4Vb14kAMbTtcEwJsDo9UU2a0Wkfk4gqc0nmGS3YxgA8Mo3EnguILBiJ+zSUFAcUVPGOV28Mg9fwwBGLp6YYSbf7up5p4ck0Ax7MYViHUhCmhbx5fYOcDsb2GbNM+U1ZC+l99OtHSVvz6qTbeXH24aHEl2jx5EUuh24g7Eas5UkP5PqQnGz6KZk0QMJ5hGxokxMGLMQxk+8S6LCv0RLXVgxZW9MyxTNfrsTEhGMwfw4or0d9WlcwSCwFQcaLlKy2LO2jqWWUw8BDdLPj2Km0NW1xgrhY+Lb3JZX3mTgt9Z3TmfoAgAJ9dGC72X2w1RIKgi8XEEyTIcAQLjwCG9pgz1x34x0yhCfp4uUAladcy8AiuesfDTI3+9pL7EmRTap9xp1Rsn4ZyuT+smMYE4z5nUlYe9E4GBiC+th6oaQp/sjBqynX8oXQkbfPipl/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(4326008)(69590400012)(8936002)(6512007)(54906003)(6916009)(26005)(956004)(6486002)(316002)(2616005)(52116002)(8676002)(6506007)(2906002)(86362001)(186003)(16526019)(36756003)(6666004)(478600001)(66946007)(66556008)(66476007)(1076003)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?EbwSGbrU/OTumNgP9z2yC08Na6hnpq9UnsZYl51atpJuKd8vjgje+W/VEi3i?=
 =?us-ascii?Q?RlKZmYFhA0Ou3pKiE9iv6qJwGpaV0rQ5G4cjF74mpIhu4KfDWqMCVATKzuM5?=
 =?us-ascii?Q?bn6xliIcYt/60L5dVtw2YcXpcWbBCBPBnaFPqE4bcMS46Gl3Zvso4Wol8Gsy?=
 =?us-ascii?Q?dard7FFg9VBj+5wyq9BZwY9wb5+jAiItrKQRhOiePg8ilAmuh9bFqf1Z3dWG?=
 =?us-ascii?Q?Bs3e09HX+u4xY4IoSq6kV2xceLkRJHT2cnpS9x+s+0j5Fan97lpWGvFCdIcd?=
 =?us-ascii?Q?GkhFSUzHGCOiAqIR4pWjxNxUg3WRt7YGlsPhlQBwes6KY3LkL0SUZpoMpXeo?=
 =?us-ascii?Q?xtNRrc2C2oqwcf4gcxgWs1LwqcmRPWCw0CHeYuM3I1wmhXeDbj4jTZR9XCCu?=
 =?us-ascii?Q?XYeQkTzNlH5R6ExIJhOk1SeL1P+U4iXxkX5y9GOyS8TO2OAEdeXvs3cmOG8D?=
 =?us-ascii?Q?CK2Y1oBhLVBs3R85ELTWXTZv5skuJMS9Q6B3IbAAe+WfI847apjdiudfg98I?=
 =?us-ascii?Q?O21h+YP5j3ChLXZs5frtf82HyMeAxVRgqlwdIWA8Wd0Cw/9/yOWFMWFb/YUg?=
 =?us-ascii?Q?fQOpgh+TpceuQWMrZC790NgfwqHNe19Dai7k5zLkf8+96y652kZl/z8qcyTo?=
 =?us-ascii?Q?nX/BD690tqemgfJZ72Tmh09mO54qXA7dOyrHXvlOIg8nGY1YIFgVawGacMcK?=
 =?us-ascii?Q?72OoWSLE2sXyn/s27vDJcOjG14/aaABZAugV+fh3SHLDeC4atSfMnjVkpP5K?=
 =?us-ascii?Q?/CZRchuB0Zlqz3J6BuQT5ExXSuCXYmDMF30ziBZ+n0rLyFUVRzSWhcj4hvFV?=
 =?us-ascii?Q?dgJFVvx4st5E+nYdSaWreR+Fp/uxGEukKjNVoBYkfo/lTj/+mB3gd/mFqRfK?=
 =?us-ascii?Q?ALBlJpRGRbjBJk9PgO96Ci+711FQAHyqOQmzjj6uXndAv5CI8d6t/SHXTlku?=
 =?us-ascii?Q?MN5FWTZ4NpGyVrjutFQk+VsdWkiM0PYxKndIjhAOwFLoAq5ekllI7byt0GOg?=
 =?us-ascii?Q?MIYV79cQ/QhFedo7PmQNJ0n4zdVGLsyng945gOCOBqf0eA/ayiO1FAQOE/US?=
 =?us-ascii?Q?ABllPrWe9S6WBoprzmRq76BerR0W7M5dXMSsw8IhpMQPx/jR3wwZzYVttjjI?=
 =?us-ascii?Q?fiv6wyrjO4i4+Ipmqz5t6DwK+jz4g+6rJAQOJrwrjMrgYgU7o+xWNsSdjH0W?=
 =?us-ascii?Q?BMr6OhdPTlcqDXLn7HjJllegQuyTL95cSHmCsq8ziuWOx0XNqc99Q5y9IV8n?=
 =?us-ascii?Q?QiaubBk2huEJozqerMgr9VBXa8fC75jUkxmyXexwmNoL8kSaNs8JOjHAF3ng?=
 =?us-ascii?Q?6swuLqkUUyyS5uAgqYlSTGuD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08f01ad2-04b7-4f18-32f2-08d8d91259ec
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:11.5888 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tiBxmg1HkOKLgeZYsCYlfESn8joRWgAmXrqrMhBQY4f+Q/a1W++maVacrVMsTOztM4TBVrL+U2CwzQ3VwQAGDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2497
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Kevin Wang <kevin1.wang@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

perform one-time initialization for sdma registers

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 17f6e59ea96a..783f8dba085a 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -260,6 +260,19 @@ static const struct soc15_reg_golden golden_settings_sdma_arct[] =
 	SOC15_REG_GOLDEN_VALUE(SDMA7, 0, mmSDMA7_UTCL1_TIMEOUT, 0xffffffff, 0x00010001)
 };
 
+static const struct soc15_reg_golden golden_settings_sdma_aldebaran[] = {
+	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_GB_ADDR_CONFIG, 0x0018773f, 0x00104002),
+	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_GB_ADDR_CONFIG_READ, 0x0018773f, 0x00104002),
+	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_GB_ADDR_CONFIG, 0x0018773f, 0x00104002),
+	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_GB_ADDR_CONFIG_READ, 0x0018773f, 0x00104002),
+	SOC15_REG_GOLDEN_VALUE(SDMA2, 0, mmSDMA2_GB_ADDR_CONFIG, 0x0018773f, 0x00104002),
+	SOC15_REG_GOLDEN_VALUE(SDMA2, 0, mmSDMA2_GB_ADDR_CONFIG_READ, 0x0018773f, 0x00104002),
+	SOC15_REG_GOLDEN_VALUE(SDMA3, 0, mmSDMA3_GB_ADDR_CONFIG, 0x0018773f, 0x00104002),
+	SOC15_REG_GOLDEN_VALUE(SDMA3, 0, mmSDMA3_GB_ADDR_CONFIG_READ, 0x0018773f, 0x00104002),
+	SOC15_REG_GOLDEN_VALUE(SDMA4, 0, mmSDMA4_GB_ADDR_CONFIG, 0x0018773f, 0x00104002),
+	SOC15_REG_GOLDEN_VALUE(SDMA4, 0, mmSDMA4_GB_ADDR_CONFIG_READ, 0x0018773f, 0x00104002),
+};
+
 static const struct soc15_reg_golden golden_settings_sdma_4_3[] = {
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_CHICKEN_BITS, 0xfe931f07, 0x02831f07),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_CLK_CTRL, 0xffffffff, 0x3f000100),
@@ -483,6 +496,11 @@ static void sdma_v4_0_init_golden_registers(struct amdgpu_device *adev)
 						golden_settings_sdma_arct,
 						ARRAY_SIZE(golden_settings_sdma_arct));
 		break;
+	case CHIP_ALDEBARAN:
+		soc15_program_register_sequence(adev,
+						golden_settings_sdma_aldebaran,
+						ARRAY_SIZE(golden_settings_sdma_aldebaran));
+		break;
 	case CHIP_RAVEN:
 		soc15_program_register_sequence(adev,
 						golden_settings_sdma_4_1,
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
