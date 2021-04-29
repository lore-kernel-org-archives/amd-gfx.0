Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49022C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 06:09:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E287061434
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 06:09:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E287061434
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 683606EC7D;
	Thu, 29 Apr 2021 06:09:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E6BE6EC7D
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 06:09:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4i20+YnXznykwrz1WRzQumxMzeQMLZF+PK2U3gG7Tct+WmrvZSXIYX3TR42WNdonb2eQmhgqoTOC0UitleBP34Jb3xk6JyuTc6RQO6HvciIM9mIfLyYm3XVMCLMPcI6QRkqAyqsU/WpLTEIGMP5l4QQ7G6XRXjO9BBb1bTS2Oo8zLiZna4tMhivqMGBnpXEUgbe82g4FnK4PVsEI3AHv0p1WQVuzIUlj6TSYfaviYHY3tRtF9OhUm4D14nwjcFCZUmRkyZSahUrXEjKH799uuH5sbb7s8FmFYNJmSXCuPMVdO4tRqp41PavR81zfvUBbma+EfOF3Bus6zhYIT2raA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/UjNoD/Ptl8Pqq9txX4ZqKua7Tel8iAWKtlIFRk5kY=;
 b=HA0GmZ/vwsPZfcyP3kHWkF9ow7ej9Itmw/zG35WU5bn6L8z79XyuUA8dWZxCSwoZvSQNwjwbbzJMgn318IuFf2cgkyxgBECO6gTLqYQVaqojGy6N55xAjDYhioELf2K274p7gbLNBObnlYVaDqI+LqyhX2pcEQ1yJF/Tj1elBHBBZMOUMxeJTFSKIDyh55jup4UY9sxsvcffQy2o4Zdtg/W6nI2qIwHWedjDh19wB2h4/KKDP7cUL1y1Eu3OKYHzi6ubFl/+EZ7tx0wlHUoDvm1Koicj9LuVImaQZsGvxcI80rbXMM6vjafUf6wFS0ApUvpJI6Zj/r03Iqx8yCK+IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/UjNoD/Ptl8Pqq9txX4ZqKua7Tel8iAWKtlIFRk5kY=;
 b=qg+Gyhe1ONBrKC5waVrdO5IgVEJx3PX65gJoAvgAQHasZg1rYHJQXM43VT04pn0k7uMJ9PIWzGKBkEs6r6lbbrW4x1Dv/52uspbEUAOh+Bv9hwiKxQVYrqM7HEJ5RbPP37auG8g8fv+4uzHDKDM32ZfIP6ofwPlX1F774g9Qb/0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB4684.namprd12.prod.outlook.com (2603:10b6:302:13::29)
 by MW2PR12MB2540.namprd12.prod.outlook.com (2603:10b6:907:7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Thu, 29 Apr
 2021 06:09:13 +0000
Received: from MW2PR12MB4684.namprd12.prod.outlook.com
 ([fe80::14db:e180:2a16:1b2a]) by MW2PR12MB4684.namprd12.prod.outlook.com
 ([fe80::14db:e180:2a16:1b2a%3]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 06:09:13 +0000
From: "Changfeng.Zhu" <changfeng.zhu@amd.com>
To: amd-gfx@lists.freedesktop.org,
	Ray.Huang@amd.com,
	Kevin1.Wang@amd.com
Subject: [PATCH] drm/amdgpu: seperate the dependency between CGCG and CGLS
 when diable CGCG/CGLS
Date: Thu, 29 Apr 2021 14:08:53 +0800
Message-Id: <20210429060853.4144-1-changfeng.zhu@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR02CA0202.apcprd02.prod.outlook.com
 (2603:1096:201:20::14) To MW2PR12MB4684.namprd12.prod.outlook.com
 (2603:10b6:302:13::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from changfeng-pc.amd.com (180.167.199.189) by
 HK2PR02CA0202.apcprd02.prod.outlook.com (2603:1096:201:20::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.28 via Frontend Transport; Thu, 29 Apr 2021 06:09:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0bd1c81-8746-4331-0590-08d90ad54fce
X-MS-TrafficTypeDiagnostic: MW2PR12MB2540:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2540CAD2DA92E7B8DB05EDB2FD5F9@MW2PR12MB2540.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8vc5UqbCloNKsY74dkoP1ZbbkzyNAGI5MRd04hVHDMc/adlof23J/6A43asrtlzDuq92tQYCHpJpR5XidAFJWYIfKkGaAHM5T9Xz0GyYEX4ZzJhhluGlg/4PwhnNmfaTb/xYWV8nH8PMjGLZ21K36IOne6AIvMxD6ThbAXVeY4aqmFwqq31G4ghwoxW5IZ7avSGCw0BWO0cxbt9suV0utusOsXAzkp3gCkU5Gxjzky1e4NVEes35p7uPkLTPvoWb//WVJvpykgdrPUo1hRFpnl1tu3FfCmlE3pGNDCxFzKwDCygrAFxxmcOBTtbVZ3B2pLqpIZtUXsOryrhtN0vivc+sYBg+6EaIIXoP33ngxTITB7jZwtowmAeHU77nTs+Pf4Vu9CM7+eVBEX/vG/BpN1nBwxTwqVZwka+rTylp2sOb/NGaoVUZeHKKhqDuy6vIEFjqnAfKMw5oxsfHhtQH/+ITqwbZjZg4rOrwINZC8ACDtSUVmpBqhrLjAfTSlYtug2/Lhf3hV8vRf0Ux3ogqdCBfNQBfYC2SW3jlnPgacQ5awerZWqM1xInHXupvQnwNqnOL4+0jn1jznWX/M25q4QbXOtAJlc9PGQfix9QRzDUPONeyhNRFVf7n2m/FGH9HgrD44OgyUcyFK7NLibWxxushcM32Kxl2jp70CjxhgQgx3IMVdkF/enZl0yliR2JK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4684.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(7696005)(36756003)(52116002)(2906002)(66476007)(6636002)(956004)(2616005)(8936002)(38350700002)(66946007)(6486002)(1076003)(6666004)(38100700002)(186003)(66556008)(4326008)(316002)(5660300002)(26005)(86362001)(8676002)(83380400001)(16526019)(478600001)(16060500005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ZpRUbo8DdLTJM38yMd7BFzxUR6cx65II1yitAxvZR3iU/TZ9iuqTL2beb9gH?=
 =?us-ascii?Q?JbfJFIGpkhijpcsH9G3PflcRL9GjbbGMMrUF8OhcefATTYbkCtdFVqxuJIVU?=
 =?us-ascii?Q?VU5FaMiBgu2B6EM3zB8Z8aZZSBcf2Krl204WLHl/l5vnDa23jQlTN9JuHsWA?=
 =?us-ascii?Q?RTHVN8CnscF4SnkdkXcGwp0fCvYNIS2EvgoV36oEnaneZrSNR6KgW/W0N/jv?=
 =?us-ascii?Q?M4bcTwXrp1MNx3rJAuN/KoyrHqR2ukj3gAhI3OQneUDyueG5coibvInswrBK?=
 =?us-ascii?Q?36wb1AsMfB9MwZnRsy8JK6RJt8hgn3cHWUCgvjq79vIWPJOnWruenfuENzs4?=
 =?us-ascii?Q?iHxcd28h5xWY8YxdQNqgQHysENoBCdM22bsrj7Qu0jBkwil02Rofm0r3+XWd?=
 =?us-ascii?Q?rRPA9LVDVJ67kfvDuy5upkBflODgT4Vce6xLTkz4umPtFEi06j2Cdk3VG3zL?=
 =?us-ascii?Q?OWCv1+HUbnuUqvRHd5n+Y0x8ItmNr+FEH3Q5ZmjCKnFOdkoqEjKiKJxnhqPr?=
 =?us-ascii?Q?LWIbOTmGQOSW18A62Pdyf5cmT1Fs5xqnhIE597qM68wTHLCI08F5tuipbzVW?=
 =?us-ascii?Q?OzScqQUMkJ8LYEkoe7+Xfo44paFxABlBFzmG9pUsdj4QpXF59R2wTQcLCUzI?=
 =?us-ascii?Q?BbRBod5SYDBxEuFY4KOxUWwFbWJnNBzWoGNJ6EJsMh+74VkzNwafUL45mnOO?=
 =?us-ascii?Q?AWkriULylwbP3PJ+AKrNspzLBw5hitW+W9y4D+OH8jkrJpGE93rtTEgBOfE5?=
 =?us-ascii?Q?QxBzlvuef5Zt64nD5XwncrZ3tX9eMHS9pGrSGCpD8oVaQ53/ToCNkPPqqlgN?=
 =?us-ascii?Q?4TIVYp/u41jcTS0wlc20iG8l5LwabHuNKhiBAXbD4eLrfUa5IqtAZO/WXVPx?=
 =?us-ascii?Q?F3z8JB9hCe9jYjJEAKnoYSGwnXrJMMrD/bezecwAf6wQHY+YsM2nZMh76Z+A?=
 =?us-ascii?Q?NvU6O8JkHD8yE/dQahgY7ovqeInxaLEL/TYEj8UFL6t5i2uK1K6EUO0t7Wc5?=
 =?us-ascii?Q?BWfZXjxk+2yGkHbciUPfx8R0D2Pi7jMcuAi1i0kLqJdoKR627fEoyU8WN0/L?=
 =?us-ascii?Q?7IcJkf2J36NntA1Tqn2S9L9rqxNR4agqMn80CBu37oilS7TQqU00iijZukap?=
 =?us-ascii?Q?3JnnHNwlBrhrgcz6AvIKkq22z03keAZgTJvWznuI7Axeg+yPhNS5DQfmuCu4?=
 =?us-ascii?Q?A1JSYKF9x++qPGVn4NqXl62lmtGb3aSjRY61hf59WUDnWpxGMdcGnTenJNOX?=
 =?us-ascii?Q?fX7SHYmiknFzTDG4R13Z5nG7YcfMpT+Z1SiDcLhipUw8/OfckVraEzuzUpM0?=
 =?us-ascii?Q?fuYjLLRCHmZliFn+X99SESbX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0bd1c81-8746-4331-0590-08d90ad54fce
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4684.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 06:09:13.5018 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /0Mj549W5pH7edr5K7zLnh6SRnTUnGtapVJ5M2m5QaxE3w50gW0ZF6nZ/S5UJq95hEUg2lA0LAeRGuXgGrlSVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2540
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
Cc: changzhu <Changfeng.Zhu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: changzhu <Changfeng.Zhu@amd.com>

From: Changfeng <Changfeng.Zhu@amd.com>

The disable process of CGLS is dependent on CGCG now. Align with windows
code, seperate the dependency between CGCG and CGLS and it will reduce
confusion when debug CGCG/CGLS related issue.

Change-Id: Ia91b8b16236bebd9224160672e500f6850dbc268
Signed-off-by: Changfeng <Changfeng.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 24 ++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  | 33 ++++++++++++++++----------
 2 files changed, 37 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 49fd10a15707..3f8aa2fb974d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7717,18 +7717,22 @@ static void gfx_v10_0_update_3d_clock_gating(struct amdgpu_device *adev,
 	uint32_t data, def;
 
 	/* Enable 3D CGCG/CGLS */
-	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG)) {
+	if (enable) {
 		/* write cmd to clear cgcg/cgls ov */
 		def = data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
 		/* unset CGCG override */
-		data &= ~RLC_CGTT_MGCG_OVERRIDE__GFXIP_GFX3D_CG_OVERRIDE_MASK;
+		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG)
+			data &= ~RLC_CGTT_MGCG_OVERRIDE__GFXIP_GFX3D_CG_OVERRIDE_MASK;
 		/* update CGCG and CGLS override bits */
 		if (def != data)
 			WREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE, data);
 		/* enable 3Dcgcg FSM(0x0000363f) */
 		def = RREG32_SOC15(GC, 0, mmRLC_CGCG_CGLS_CTRL_3D);
-		data = (0x36 << RLC_CGCG_CGLS_CTRL_3D__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
-			RLC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK;
+		data = 0;
+
+		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG)
+			data |= (0x36 << RLC_CGCG_CGLS_CTRL_3D__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
+				RLC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK;
 		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGLS)
 			data |= (0x000F << RLC_CGCG_CGLS_CTRL_3D__CGLS_REP_COMPANSAT_DELAY__SHIFT) |
 				RLC_CGCG_CGLS_CTRL_3D__CGLS_EN_MASK;
@@ -7758,10 +7762,11 @@ static void gfx_v10_0_update_coarse_grain_clock_gating(struct amdgpu_device *ade
 {
 	uint32_t def, data;
 
-	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGCG)) {
+	if (enable) {
 		def = data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
 		/* unset CGCG override */
-		data &= ~RLC_CGTT_MGCG_OVERRIDE__GFXIP_CGCG_OVERRIDE_MASK;
+		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGCG)
+			data &= ~RLC_CGTT_MGCG_OVERRIDE__GFXIP_CGCG_OVERRIDE_MASK;
 		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGLS)
 			data &= ~RLC_CGTT_MGCG_OVERRIDE__GFXIP_CGLS_OVERRIDE_MASK;
 		else
@@ -7772,8 +7777,11 @@ static void gfx_v10_0_update_coarse_grain_clock_gating(struct amdgpu_device *ade
 
 		/* enable cgcg FSM(0x0000363F) */
 		def = RREG32_SOC15(GC, 0, mmRLC_CGCG_CGLS_CTRL);
-		data = (0x36 << RLC_CGCG_CGLS_CTRL__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
-			RLC_CGCG_CGLS_CTRL__CGCG_EN_MASK;
+		data = 0;
+
+		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGCG)
+			data |= (0x36 << RLC_CGCG_CGLS_CTRL__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
+				RLC_CGCG_CGLS_CTRL__CGCG_EN_MASK;
 		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGLS)
 			data |= (0x000F << RLC_CGCG_CGLS_CTRL__CGLS_REP_COMPANSAT_DELAY__SHIFT) |
 				RLC_CGCG_CGLS_CTRL__CGLS_EN_MASK;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 16a3b279a9ef..f69129097f2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4946,20 +4946,23 @@ static void gfx_v9_0_update_3d_clock_gating(struct amdgpu_device *adev,
 	amdgpu_gfx_rlc_enter_safe_mode(adev);
 
 	/* Enable 3D CGCG/CGLS */
-	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG)) {
+	if (enable) {
 		/* write cmd to clear cgcg/cgls ov */
 		def = data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
 		/* unset CGCG override */
-		data &= ~RLC_CGTT_MGCG_OVERRIDE__GFXIP_GFX3D_CG_OVERRIDE_MASK;
+		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG)
+			data &= ~RLC_CGTT_MGCG_OVERRIDE__GFXIP_GFX3D_CG_OVERRIDE_MASK;
 		/* update CGCG and CGLS override bits */
 		if (def != data)
 			WREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE, data);
 
 		/* enable 3Dcgcg FSM(0x0000363f) */
 		def = RREG32_SOC15(GC, 0, mmRLC_CGCG_CGLS_CTRL_3D);
+		data = 0;
 
-		data = (0x36 << RLC_CGCG_CGLS_CTRL_3D__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
-			RLC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK;
+		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG)
+			data |= (0x36 << RLC_CGCG_CGLS_CTRL_3D__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
+				RLC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK;
 		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGLS)
 			data |= (0x000F << RLC_CGCG_CGLS_CTRL_3D__CGLS_REP_COMPANSAT_DELAY__SHIFT) |
 				RLC_CGCG_CGLS_CTRL_3D__CGLS_EN_MASK;
@@ -4993,10 +4996,12 @@ static void gfx_v9_0_update_coarse_grain_clock_gating(struct amdgpu_device *adev
 
 	amdgpu_gfx_rlc_enter_safe_mode(adev);
 
-	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGCG)) {
+	if (enable) {
 		def = data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
 		/* unset CGCG override */
-		data &= ~RLC_CGTT_MGCG_OVERRIDE__GFXIP_CGCG_OVERRIDE_MASK;
+		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGCG)
+			data &= ~RLC_CGTT_MGCG_OVERRIDE__GFXIP_CGCG_OVERRIDE_MASK;
+
 		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGLS)
 			data &= ~RLC_CGTT_MGCG_OVERRIDE__GFXIP_CGLS_OVERRIDE_MASK;
 		else
@@ -5007,13 +5012,17 @@ static void gfx_v9_0_update_coarse_grain_clock_gating(struct amdgpu_device *adev
 
 		/* enable cgcg FSM(0x0000363F) */
 		def = RREG32_SOC15(GC, 0, mmRLC_CGCG_CGLS_CTRL);
+		data = 0;
+
+		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGCG) {
+			if (adev->asic_type == CHIP_ARCTURUS)
+				data |= (0x2000 << RLC_CGCG_CGLS_CTRL__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
+					RLC_CGCG_CGLS_CTRL__CGCG_EN_MASK;
+			else
+				data |= (0x36 << RLC_CGCG_CGLS_CTRL__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
+					RLC_CGCG_CGLS_CTRL__CGCG_EN_MASK;
+		}
 
-		if (adev->asic_type == CHIP_ARCTURUS)
-			data = (0x2000 << RLC_CGCG_CGLS_CTRL__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
-				RLC_CGCG_CGLS_CTRL__CGCG_EN_MASK;
-		else
-			data = (0x36 << RLC_CGCG_CGLS_CTRL__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
-				RLC_CGCG_CGLS_CTRL__CGCG_EN_MASK;
 		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGLS)
 			data |= (0x000F << RLC_CGCG_CGLS_CTRL__CGLS_REP_COMPANSAT_DELAY__SHIFT) |
 				RLC_CGCG_CGLS_CTRL__CGLS_EN_MASK;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
