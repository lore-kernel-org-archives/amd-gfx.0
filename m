Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AFDC43618
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E07E61420
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E07E61420
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D73F6EC64;
	Wed, 12 May 2021 17:31:20 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2042.outbound.protection.outlook.com [40.107.102.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85D3E6EC64
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 17:31:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJs77CCaHkilpUj/FObOe3VEdKwyqLP+cQKaE1/6hVWPDEPcwor/cRKHewySMahDosfS1xvtYLzLIIUN/9xkBxpbUC8b1Vs4gig+y3NJ0xJOQC6MadbcYr/F65eJNLAihTM9URuWkVcxzsZnFZsE9z4tI3MhlXDUoM5QwhVKoYtPGZJCJiMUjaOuWPV05DnxchA1OTvUNqulIwHQCh3Y/FoFX/iXYRlJtuqS5be9tHJthT7ryz871SyOlVF/A5m67qfa1SRSkq+MCO1GxgQtiHZWlncS0zP2NO/aQ3UaNPT8uB4Tfued0Meb/rS1aRyBKuqXjNv6SSK/tGYD6Ci6pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lf2sMOcwP6vpvee6uwhE2VY9gWBMHVj8Q5U7jboXAQc=;
 b=g7IflLPgMMBbUEC1Fl9E/iQpSq7Pjbdk14Bf0Jg+yZI0oJ0ktMZYqteXvDtmmmRmLxK0DOGO754Cigx5QclmnSAHAIWO3f9UqytyZKSLiCzlOyPcCQ1K/omdh2oaKYIwuz485WXzm7pgt9ZKZKC0JhMR7L7FGFEjkSdQhvclvAq9DAo49k039G4Se/aWC73MrpzDsvSieipqXhPNTHKfxfd4zqgrM81jP+vjearuRpPMhsbXKJcE0ZAlI9oLc9et3AVKxp7dMbRBzQ6mcRdA87r2pDeipKIQS362R92TY/EyvVLf0jofuMvVyscLFs10OcXxkBJuK0Rv6MH3IDYK5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lf2sMOcwP6vpvee6uwhE2VY9gWBMHVj8Q5U7jboXAQc=;
 b=q8VkXJBYQCsYVNUdzhuOOV7Gk2sGoZ4YMnZfRgiEGu7amqlKa1M2N7g93DC2vXCCbIsXTAE1NVz5382l1LfPdPKJMr0xFvEDyTQM69sLyV6gUvwGvRzzHwbqsE8hXSxX4hqCWCJMyBjXXME9SVJcenAsQQDTsGD6YJlUCy8ngi4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4915.namprd12.prod.outlook.com (2603:10b6:208:1c9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 12 May
 2021 17:31:18 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 17:31:18 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/49] drm/amd/amdgpu: add mmhub support for beige_goby
Date: Wed, 12 May 2021 13:30:13 -0400
Message-Id: <20210512173053.2347842-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512173053.2347842-1-alexander.deucher@amd.com>
References: <20210512173053.2347842-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.245]
X-ClientProxiedBy: BL1PR13CA0159.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::14) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.245) by
 BL1PR13CA0159.namprd13.prod.outlook.com (2603:10b6:208:2bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend
 Transport; Wed, 12 May 2021 17:31:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b181e38-360c-4c6c-70b9-08d9156bc018
X-MS-TrafficTypeDiagnostic: BL0PR12MB4915:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB491512A8FB605D08F3A925DCF7529@BL0PR12MB4915.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:415;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fWICNLtSvDJlQCSQ/3awS6coWHbdIqURyOHyrhSXk5jtMfCqHVVEkB54Qw4UigsaAj4cY9exSX5kcpoZGG3SKea+gsjwjes8cebJOFifCpKO0JQowX6s1Ak25D/HkJzl3yqqOL4i7ryyFCVzZeqYQA5NwBfRrBXFrZIlE+tSZeLqrPuNM59YnFwB9XJb4FffeEU+bWUWrBAThXFacX3Hu86pzWXSmNEH665dpnSF1lG1guWcnJpSUlo74iELbGUH0Iy3UVyewD8nd/lWB5x7uEdJ0cXXoj+mMTtkQ+dxHCSO/mtGD01ADsd7xYdxfTPaC2KFUExCgjCtSrNLs/VCO8HnNwUvkHxNOa5a+kHkqC+j3RIeVFNv9AsxrdlcWA7rmDRTA/wnirwLvKnFxw+DSa7RpA3j3UPa/FI+eI61JvmNLdp69iw642/jH+XOQB//MQeGSgjRuToRJI47f6xy668RicCHOdvpjtCGUDSDfKyMkZGMa2dyJzGTlRIvkvTbbuM9drfyPK/8vMD/Bbcsxx291cH6HH9/CQE6a9l+VFRNcXPosf1Lww6YDRTbdVitcD/c5WHujEkIG4YviabtZoVnud1SDg6qxIr5fNUb3QHfSGdL2U87uIEWlyWrFUKvF3v9JiJYmTu1OQptwFKr92GUtta3jL9ACZPHdI+KQiv6BqD1Dw9AacAboKWaLAcU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(396003)(366004)(39850400004)(8676002)(186003)(16526019)(8936002)(54906003)(6506007)(66556008)(478600001)(52116002)(6666004)(66476007)(38100700002)(6486002)(956004)(5660300002)(6512007)(26005)(36756003)(66946007)(6916009)(2616005)(86362001)(4326008)(1076003)(2906002)(83380400001)(316002)(38350700002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?lARCfF1CThfDtWyo5fIp+jhpSN/l3KK33v/KeIN9Oe++lDAMbjgw/6y+mO9N?=
 =?us-ascii?Q?Bjyn7/gVihNImsQQ35s8dgIYL8HNTsXFyLCTNUJ/J2TY++pmndAwI/nyINyh?=
 =?us-ascii?Q?3YDWhGe6tIxVdi124LtMDX98FVcnwCOK857+My4wpOX/DzvHdg2utPfQpTDE?=
 =?us-ascii?Q?vPwmgmA30nVmv/47/noNxCvtf1p53QzYj3tCrR+M3nwUAW+RQuCQBk5lwZ7o?=
 =?us-ascii?Q?+gD8+7iZAs1IiHwbIPyxxe+PzgjHY52cR/Gn3oFdF2p5j/KeBoTunWyPcSQ9?=
 =?us-ascii?Q?ojUVStUCteRHS/ire1nIpAuQZi/FXKYURqfjgvZpxdstdmFns+udpx7etXwH?=
 =?us-ascii?Q?JlORrIxS+l23G8WZ/rasacJuM7fYdSj95UK2ibA2B8ndF4McaHUhow9whlgd?=
 =?us-ascii?Q?FqjEt7r1hq/BwLyxoqhiNE3YtYQpIPi1icj32VeFGmMNIhEaKPIZ3le5NsJ5?=
 =?us-ascii?Q?xSU1ZkK+hdoi/g1un4Utohn4ue1hkmMiHg7txQspgk1CSh7R0zJkJaBL+WUe?=
 =?us-ascii?Q?xV3yasBlnJT4ntmSSf0laBuHAzuw1bhywIF1pC97dcpAGLUi+WBAMq5+a7hU?=
 =?us-ascii?Q?8EM50ZzW/2drP+vzji5iv02FSuGfS/KLNLLOaA3JckISFST/gOsxwUkXxH4h?=
 =?us-ascii?Q?CwrD9D4XXZIGAl3r+pfUsy/sTcMuMH75V1gT0VJBSWxmGcAYUrBxd9wzHsVp?=
 =?us-ascii?Q?dht1IKjrZ7FtJs6WshyASVwV/B758UebVfSzCHlCDYIHiBmgZXisJ6bhe7pU?=
 =?us-ascii?Q?SyvO6GxDJ/N00p2eC+++SYS4SzZkHQJ0Raju0gBCvyjy3gF+IPiqb8pA/6y/?=
 =?us-ascii?Q?1MKeXBx6j1EGV7W/Hm/D6FmoGscVqXOqIBR+eVM2xXcnM4GcojG/xsn58Vtd?=
 =?us-ascii?Q?qbCIR0ZrXlJKqPcS2haJd/Yd+E102yGjuSN2fEcMAG6MkrDwOkpAZSZ/jA0y?=
 =?us-ascii?Q?7Rrjw8r5alU4T3LKz82tb6n52JcsQkpTa/PrCQBd2f0O/LfjWgkPxztACC/9?=
 =?us-ascii?Q?5F5fOUh5bgTuzvQTrxi26bzDNn/VMWUSEpEqFuoYS6FNF8fwArYoIfoEPH3o?=
 =?us-ascii?Q?ElsZ6pyhhqhlxA2CModcFG7pomFEWdSO2ccZXnJnsVa44n7Jk8f+HguWU8WP?=
 =?us-ascii?Q?TWppUYJQ/cyAgxakAXKoo4ObpmEMuuo92QVe9+jwsLLKoH9Ua7TRgkz1y6p8?=
 =?us-ascii?Q?Z9w7mC9BGka3AexoWmJ4c0Dtex1I3bat+ihYSqjMMMnx10AENz/aEs7brbRk?=
 =?us-ascii?Q?gQ9jhWXdeD+ECETsaOkLtMyOhsSoxVim0wrGyLSgPpnB2PuFY0mHmbdBYpjM?=
 =?us-ascii?Q?ZJHVJfwfnI9+an+W/kYaDSQV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b181e38-360c-4c6c-70b9-08d9156bc018
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:31:17.9650 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NZDGFT7i2+Q1YEyYe6mvaAqqErJo3q9Z84p0TPGuZCyc3zQzPlNdbZHGDJJmGzmPa74TwFfjEnQeJojE6FQa9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4915
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Chengming Gui <Jack.Gui@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chengming Gui <Jack.Gui@amd.com>

Same as dimgrey_cavefish

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index ac76081b91d5..72d9c8f8d9f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -544,6 +544,7 @@ static void mmhub_v2_0_update_medium_grain_clock_gating(struct amdgpu_device *ad
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_DIMGREY_CAVEFISH:
+	case CHIP_BEIGE_GOBY:
 		def  = data  = RREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG_Sienna_Cichlid);
 		def1 = data1 = RREG32_SOC15(MMHUB, 0, mmDAGB0_CNTL_MISC2_Sienna_Cichlid);
 		break;
@@ -578,6 +579,7 @@ static void mmhub_v2_0_update_medium_grain_clock_gating(struct amdgpu_device *ad
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_DIMGREY_CAVEFISH:
+	case CHIP_BEIGE_GOBY:
 		if (def != data)
 			WREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG_Sienna_Cichlid, data);
 		if (def1 != data1)
@@ -601,6 +603,7 @@ static void mmhub_v2_0_update_medium_grain_light_sleep(struct amdgpu_device *ade
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_DIMGREY_CAVEFISH:
+	case CHIP_BEIGE_GOBY:
 		def  = data  = RREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG_Sienna_Cichlid);
 		break;
 	default:
@@ -618,6 +621,7 @@ static void mmhub_v2_0_update_medium_grain_light_sleep(struct amdgpu_device *ade
 		case CHIP_SIENNA_CICHLID:
 		case CHIP_NAVY_FLOUNDER:
 		case CHIP_DIMGREY_CAVEFISH:
+		case CHIP_BEIGE_GOBY:
 			WREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG_Sienna_Cichlid, data);
 			break;
 		default:
@@ -640,6 +644,7 @@ static int mmhub_v2_0_set_clockgating(struct amdgpu_device *adev,
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_DIMGREY_CAVEFISH:
+	case CHIP_BEIGE_GOBY:
 		mmhub_v2_0_update_medium_grain_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		mmhub_v2_0_update_medium_grain_light_sleep(adev,
@@ -663,6 +668,7 @@ static void mmhub_v2_0_get_clockgating(struct amdgpu_device *adev, u32 *flags)
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_DIMGREY_CAVEFISH:
+	case CHIP_BEIGE_GOBY:
 		data  = RREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG_Sienna_Cichlid);
 		data1 = RREG32_SOC15(MMHUB, 0, mmDAGB0_CNTL_MISC2_Sienna_Cichlid);
 		break;
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
