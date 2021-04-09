Return-Path: <SRS0=E5im=JG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72686C43461
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Apr 2021 14:52:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3737B61041
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Apr 2021 14:52:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3737B61041
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AB086EC37;
	Fri,  9 Apr 2021 14:52:43 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36EE56EC34
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Apr 2021 14:52:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGGqIIf3LphwYtR1Ojn/H5tcXDCr7rbT/Q9Q34u2Hu4/6rl36GzGucZo1LqKIXv07V1gq8Y0dKtg0Op4YsheTM9y+Vd+ldZ/vVf8JkDOjoU/PHrxndHdJz32GhiZ92WRZSITSPEUJZ+rkGMY+nDreFj0jyU8xjl9FrvQcrCku57N4Qw6UQc4JCxzIFcWMOSqiL1wy25Buch7JYpZna8CxcFkbLSrDQiKT4eHqtvkHAm1HKrLLQHLa0uFHt+Lc3gJWS85AsS0YQSaH9Mz/2gbW0xgxtmTB7sc0iHvY45TnnxUac7iGwTaGaY38ZKmL+afq69bINg6VwO0EAWWY+DHXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQP8U17dd1tVTbWdrvzrWUqe5xpoJ97dhbpV/W9GbZk=;
 b=ZdV2T02H1/RaxFFdcIMPjOrfyPkSqkImp0xfnEIv/lpPN/KgzppvLQUVbdwSEfP3V8fxS3iBXD0x2aNV1QX6cu+yi22mjx1rMBvTeql66R3MhaxjDMGSBEbUxdCWymqFYH+RIRPvJ/bV5zWrrz+3DM/eWi9bKahO6GUrfMVaSLGmVXDIdN/WSOz3b+6urn6PzkOFN+pd5YjQAkkZi+AeVqO6ti9GsgbPU7vVnimodkTwarm2Q4SjvWpCkNcpmz+sO/bU0xsPvoKR2aV0pCbITMozLCMz9ouN8z4vBqxmMy6MQ3VBXkDeS5BfFzghOFNVslOthK/L6y4bnf+Qo3QmbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQP8U17dd1tVTbWdrvzrWUqe5xpoJ97dhbpV/W9GbZk=;
 b=5brqrJw9+a5Jq0Wq57YKiqHtsJhXpDQHnYknRDVznK+Qs6kSLHjuONuNM6gEpWW0vpNC2KJFMABHCEJmjLxBtxOhMt/4XWzjuQfa9ndiJ0EZugNuD9KXWOn1MqClTbjTTZLcKbYlvwOWKMpaGEd+5grK0YXUahCpfUU5oxlcI3E=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2761.namprd12.prod.outlook.com (2603:10b6:5:41::27) by
 DM6PR12MB3994.namprd12.prod.outlook.com (2603:10b6:5:1cd::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.28; Fri, 9 Apr 2021 14:52:38 +0000
Received: from DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::c5db:878f:cbb4:f136]) by DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::c5db:878f:cbb4:f136%7]) with mapi id 15.20.3999.033; Fri, 9 Apr 2021
 14:52:38 +0000
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] Revert "drm/amdgpu: workaround the TMR MC address issue
 (v2)"
Date: Fri,  9 Apr 2021 10:47:34 -0400
Message-Id: <20210409144734.1591798-4-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210409144734.1591798-1-Harish.Kasiviswanathan@amd.com>
References: <20210409144734.1591798-1-Harish.Kasiviswanathan@amd.com>
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22)
 To DM6PR12MB2761.namprd12.prod.outlook.com
 (2603:10b6:5:41::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from harish-base-compute.amd.com (165.204.55.251) by
 YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.32 via Frontend Transport; Fri, 9 Apr 2021 14:52:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db17700c-add6-4152-9e82-08d8fb671c77
X-MS-TrafficTypeDiagnostic: DM6PR12MB3994:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3994D767238F7C10060D22858C739@DM6PR12MB3994.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b7wsKJVJRWuqar2xmg+tpz5pm13Or+AjRQ2NL2MrKs+7MezoEXopu7v0Gs20zByHnueWBvFbO/uSNdpxZc9ow9G24gqJnQE9zg7RH3hAw9lU+eAS2Tq7ExBK/VWMnYzxE1gKuqPYs/0U0LuigFb4HAP5Xjt8JiVnqPwDx+yJwYmgsWZB7UAjj76seGjsoYse+qC/oPIj7b+atFBL8Vmc5S/1PaGEsF25FJT/wDUVcS1H/mxjBqp1LJLuCpgziZyzbwQZF8t/CFs1vxEFI5+rAczlnx2bczM3uI/aOxhZMIB4UdF1YTSuNqAnOA0TMC+4q/lXuthZrxF1y1LaEmNaiiYP6RffGxg7HDqiwj3mKdKGI+6KnYUSOzSf2aDuHbByoRw9vcgG/MTsQqKgiC01dXUZwn6m9uuMUhGauJxbB6GxJW2QcQqaS0D/2rGwkQHhfeRFThTAV1bMaPKJ0eYr9Ea9557G90Tt8Ux4Wo0s2lZ9lEipicnmnk1WJx0Md2XrTnf3zZUznJJUesLFCUNp3UccFGSMnyoBdZ/6GDTjk98JbagUAQ4sPnorCNwFnghd23sl32+zkMMf/e0vWkJwhxseUwdTOBWnkJMZXDrsfDslbXvG6c/0xzEP7Z4igwJr/iTXYZmfxpVEuaqxcAmueYbNSwFGqacVs3xnlcGR1fOxeApHrPwW/0h5e9zsBE3u
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2761.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(36756003)(1076003)(478600001)(4326008)(8676002)(38350700001)(186003)(83380400001)(38100700001)(26005)(16526019)(2906002)(6916009)(66946007)(86362001)(8936002)(2616005)(956004)(5660300002)(316002)(52116002)(7696005)(66556008)(6486002)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?X5NeKFU4y6lDH1XGAdj23qSc+oSEoxTmyTCvQmJqWsTZvM1wcyfXTKIZ+nIy?=
 =?us-ascii?Q?bj+HuHChzvgcA25vptDa3KXifUqjqBRBZh9t2uRCNQLCcl12FUp5jsBgYBwc?=
 =?us-ascii?Q?q6EJu+UL5KfuOag7hLYfI40fY0AE6kz/QxeQq8fYgcnvgjzyeOtLUiz9noO+?=
 =?us-ascii?Q?zO7ffhkJukIv4qVrUGn8JTO5u/nu04A8qJnppKJl9vmCr3Pds3OXj8pRxZoZ?=
 =?us-ascii?Q?k1A1PTRRBMpwRM/6wjt/aj1HVTngm00XcQYP4cZJTquZAEfOBI+h57mClSns?=
 =?us-ascii?Q?uNL5KgL8mBXCx0Wm3xgMOpj/7VpacRyurghI565+UQlYNPKidxI+a2bysPKt?=
 =?us-ascii?Q?hpnN85Ihm+12OvyUG4oGCyj/iD2gU1J9JYUhPIWrTBbKbeE07VZF3MNOK8BU?=
 =?us-ascii?Q?V7azZRNo3O3DmDIuPVXZV09snkR/8kEJpNQOsvXVhJdI0mzALuHCDM55kz7z?=
 =?us-ascii?Q?pcqYQcew3KXxznKuK1T01YOwU21Qfi1NHmkAivvmoZ2hX05rPGNhkvhP/WLo?=
 =?us-ascii?Q?MQGca1WBNK/G8BSxsicclXwkHygC3Q+RsUoK0aOK7FtRb6e5OnL7H2E5gH0E?=
 =?us-ascii?Q?AANJni86jnXEFCfSIUnvRFjU+JJR22BkpEjQ6XDMq+ldNEuJbwr7g9F3HLCL?=
 =?us-ascii?Q?zV6pG+l3zUaSZ3c+xJJGknYRv6n380YaC95JKz3NabTkz0FmMGwyXchRrXrY?=
 =?us-ascii?Q?j6JyfCFNdPALBL1dofKvpCq4AI/yUcHvEMe2UhvEOmecXCsqY1pT14zn/VSp?=
 =?us-ascii?Q?KyjnR8yga7quLa8KUfWwOpSbqXqsnnJLHLA7YrEYnJ88wtxeoKs/yj1XXiDO?=
 =?us-ascii?Q?yTTJrC2TujOSXD6/JpNNUouez8SbAkUKaDrS7rgEIOw4o1y3P+lTa900mfOD?=
 =?us-ascii?Q?b+qnJo5u2AymebGpW4WRDLCOx/3UQmiEz3XMKb36iIEWzqBRSBuEP/rswvZ5?=
 =?us-ascii?Q?2KA8b1U11G033oNMBWNis/hNGxtFQFkZ4FhItbuwJITlw/HkRbKwMXurSAPy?=
 =?us-ascii?Q?JsNu18a3Rre0PcCkKHTi/Qmcku609RdWh75DO85pqfA8JkNBtFCF8lX/e+/5?=
 =?us-ascii?Q?IFHFE2UdsXXC8+T/ZJOBKF9AiN2T6WDEkbHnuAbSi7Y8Y174YTSlK+/+lBfO?=
 =?us-ascii?Q?tCa8pGnqQIqj+29F/TafrIZTMuf0laNNrXHSoK/Xdyp9L37NfDJkd++CBaqp?=
 =?us-ascii?Q?Q1eSeTEQcyI0rjutiSlgkppJwHf+HogPeiaDVgfEIt7ZGpjJPM4/Z7WSi4/u?=
 =?us-ascii?Q?giMzv1VFsGv4oRTFUDmHeEZwQ4mHEfqki0VEn6MsOIKZaf2Y+TXKyx3xQIbe?=
 =?us-ascii?Q?Z+B7bmB2cC88WuhpFoEYAp7X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db17700c-add6-4152-9e82-08d8fb671c77
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2761.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 14:52:35.2159 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3qFxABYRn4qmU3y/lms3U+vJQiiWabjTlEpBOoZkad5tzVJnKiz8jOkUvOXH6DnHO8cq/HlpmEfozaabaJrqpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3994
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
Cc: Oak Zeng <Oak.Zeng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Oak Zeng <Oak.Zeng@amd.com>

This reverts commit 34a33d4683cba7ba63c894132efb1998c0217631.

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  9 ---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c  | 10 ----------
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c | 21 ++++++---------------
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c  | 10 ++++------
 4 files changed, 10 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index b2f473cff67b..9d11c02a3938 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -218,15 +218,6 @@ struct amdgpu_gmc {
 	 */
 	u64			fb_start;
 	u64			fb_end;
-	/* In the case of use GART table for vmid0 FB access, [fb_start, fb_end]
-	 * will be squeezed to GART aperture. But we have a PSP FW issue to fix
-	 * for now. To temporarily workaround the PSP FW issue, added below two
-	 * variables to remember the original fb_start/end to re-enable FB
-	 * aperture to workaround the PSP FW issue. Will delete it after we
-	 * get a proper PSP FW fix.
-	 */
-	u64			fb_start_original;
-	u64			fb_end_original;
 	unsigned		vram_width;
 	u64			real_vram_size;
 	int			vram_mtrr;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 123ab3156f5a..529869818f6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -414,16 +414,6 @@ static int psp_tmr_init(struct psp_context *psp)
 				      AMDGPU_GEM_DOMAIN_VRAM,
 				      &psp->tmr_bo, &psp->tmr_mc_addr, pptr);
 
-	/* workaround the tmr_mc_addr:
-	 * PSP requires an address in FB aperture. Right now driver produce
-	 * tmr_mc_addr in the GART aperture. Convert it back to FB aperture
-	 * for PSP. Will revert it after we get a fix from PSP FW.
-	 */
-	if (psp->adev->asic_type == CHIP_ALDEBARAN) {
-		psp->tmr_mc_addr -= psp->adev->gmc.fb_start;
-		psp->tmr_mc_addr += psp->adev->gmc.fb_start_original;
-	}
-
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index f0f7025bf322..38eb08dc4315 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -140,21 +140,12 @@ static void gfxhub_v1_0_init_system_aperture_regs(struct amdgpu_device *adev)
 	 * FB aperture and AGP aperture. Disable them.
 	 */
 	if (adev->gmc.pdb0_bo) {
-		if (adev->asic_type == CHIP_ALDEBARAN) {
-			WREG32_SOC15(GC, 0, mmMC_VM_FB_LOCATION_TOP, adev->gmc.fb_end_original >> 24);
-			WREG32_SOC15(GC, 0, mmMC_VM_FB_LOCATION_BASE, adev->gmc.fb_start_original >> 24);
-			WREG32_SOC15(GC, 0, mmMC_VM_AGP_TOP, 0);
-			WREG32_SOC15(GC, 0, mmMC_VM_AGP_BOT, 0xFFFFFF);
-			WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_LOW_ADDR, adev->gmc.fb_start_original >> 18);
-			WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_HIGH_ADDR, adev->gmc.fb_end_original >> 18);
-		} else {
-			WREG32_SOC15(GC, 0, mmMC_VM_FB_LOCATION_TOP, 0);
-			WREG32_SOC15(GC, 0, mmMC_VM_FB_LOCATION_BASE, 0x00FFFFFF);
-			WREG32_SOC15(GC, 0, mmMC_VM_AGP_TOP, 0);
-			WREG32_SOC15(GC, 0, mmMC_VM_AGP_BOT, 0xFFFFFF);
-			WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_LOW_ADDR, 0x3FFFFFFF);
-			WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_HIGH_ADDR, 0);
-		}
+		WREG32_SOC15(GC, 0, mmMC_VM_FB_LOCATION_TOP, 0);
+		WREG32_SOC15(GC, 0, mmMC_VM_FB_LOCATION_BASE, 0x00FFFFFF);
+		WREG32_SOC15(GC, 0, mmMC_VM_AGP_TOP, 0);
+		WREG32_SOC15(GC, 0, mmMC_VM_AGP_BOT, 0xFFFFFF);
+		WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_LOW_ADDR, 0x3FFFFFFF);
+		WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_HIGH_ADDR, 0);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
index 176331587f98..c266364ab356 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -47,8 +47,6 @@ static u64 mmhub_v1_7_get_fb_location(struct amdgpu_device *adev)
 
 	adev->gmc.fb_start = base;
 	adev->gmc.fb_end = top;
-	adev->gmc.fb_start_original = base;
-	adev->gmc.fb_end_original = top;
 
 	return base;
 }
@@ -126,10 +124,10 @@ static void mmhub_v1_7_init_system_aperture_regs(struct amdgpu_device *adev)
 	if (adev->gmc.pdb0_bo) {
 		WREG32_SOC15(MMHUB, 0, regMC_VM_AGP_BOT, 0xFFFFFF);
 		WREG32_SOC15(MMHUB, 0, regMC_VM_AGP_TOP, 0);
-		WREG32_SOC15(MMHUB, 0, regMC_VM_FB_LOCATION_TOP, adev->gmc.fb_end_original >> 24);
-		WREG32_SOC15(MMHUB, 0, regMC_VM_FB_LOCATION_BASE, adev->gmc.fb_start_original >> 24);
-		WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_LOW_ADDR, adev->gmc.fb_start_original >> 18);
-		WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_HIGH_ADDR, adev->gmc.fb_end_original >> 18);
+		WREG32_SOC15(MMHUB, 0, regMC_VM_FB_LOCATION_TOP, 0);
+		WREG32_SOC15(MMHUB, 0, regMC_VM_FB_LOCATION_BASE, 0x00FFFFFF);
+		WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_LOW_ADDR, 0x3FFFFFFF);
+		WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_HIGH_ADDR, 0);
 	}
 	if (amdgpu_sriov_vf(adev))
 		return;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
